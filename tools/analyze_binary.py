#!/usr/bin/env python3
"""Read-only Android ELF inventory and candidate ARM64 references.

Address propagation is a linear heuristic, not a decompiler. The emitted
assembly is retained so any recovered behavior can be checked independently.
The input executable is never launched.
"""
from __future__ import annotations

import argparse
import bisect
import hashlib
import io
import json
import re
import struct
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_LITTLE_ENDIAN
from elftools.elf.elffile import ELFFile
from elftools.dwarf.callframe import FDE


KEY = re.compile(r"^[a-z][A-Za-z0-9_]{2,63}=$")
REG = r"([xw]\d+|sp|xzr|wzr)"
IMM = r"#?(-?0x[0-9a-f]+|-?\d+)"


def dump(path, data):
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n")


def inventory(binary: Path, out: Path):
    data = binary.read_bytes()
    elf = ELFFile(io.BytesIO(data))
    if elf['e_machine'] != 'EM_AARCH64':
        raise ValueError('Expected an ARM64 ELF executable')
    out.mkdir(parents=True, exist_ok=True)
    sections = {s.name: s for s in elf.iter_sections()}
    textsec = sections['.text']
    ts, te = textsec['sh_addr'], textsec['sh_addr'] + textsec['sh_size']
    funcs = sorted({(e['initial_location'], e['address_range'])
                    for e in elf.get_dwarf_info().EH_CFI_entries()
                    if isinstance(e, FDE) and ts <= e['initial_location'] < te})
    starts = [s for s, _ in funcs]

    def owner(pc):
        i = bisect.bisect_right(starts, pc) - 1
        return funcs[i][0] if i >= 0 and pc < sum(funcs[i]) else None

    ro = sections['.rodata']
    strings = []
    pos = 0
    for chunk in ro.data().split(b'\0'):
        try:
            decoded = chunk.decode('utf-8')
        except UnicodeDecodeError:
            decoded = ''
        if len(decoded) >= 3 and len(decoded) <= 4096 and all(
            ord(c) >= 32 or c in '\n\r\t\x1b' for c in decoded
        ):
            strings.append({'address': ro['sh_addr'] + pos,
                            'file_offset': ro['sh_offset'] + pos,
                            'text': decoded, 'byte_size': len(chunk)})
        pos += len(chunk) + 1
    # Some strings are suffix-merged; only exact complete strings are inventoried.
    selected = {s['address']: s for s in strings if KEY.fullmatch(s['text']) or
                any(t in s['text'] for t in (
                    'dynamic_draw_lolm.ini', 'com.tencent.lolm', 'libil2cpp',
                    '[action]', '[mercury]', '[smite]', 'GWorld:', 'GName:',
                    '/proc/%d/mem', '/proc/%d/maps', '/dev/uinput',
                    'SurfaceComposerClient is unavailable', '卡密',
                    'ro.build.version', 'lvlolm', '驱动', '内核'))}
    loads = [s for s in elf.iter_segments() if s['p_type'] == 'PT_LOAD']
    relocs = {r['r_offset']: r['r_addend'] for r in sections['.rela.dyn'].iter_relocations()
              if r['r_info_type'] == 1027}  # R_AARCH64_RELATIVE

    def read_addr(addr, size):
        for s in loads:
            off = addr - s['p_vaddr']
            if 0 <= off and off + size <= s['p_filesz']:
                return data[s['p_offset'] + off:s['p_offset'] + off + size]
        return b'\0' * size

    ds = sections['.dynsym']
    imports = [s.name for s in ds.iter_symbols() if s['st_shndx'] == 'SHN_UNDEF' and s.name]
    plt_start = sections['.plt']['sh_addr']
    plt = {plt_start + 32 + i * 16: ds.get_symbol(r['r_info_sym']).name
           for i, r in enumerate(sections['.rela.plt'].iter_relocations())}
    dump(out / 'metadata.json', {
        'input_name': binary.name, 'size': len(data),
        'sha256': hashlib.sha256(data).hexdigest(),
        'machine': elf['e_machine'], 'elf_class': elf.elfclass,
        'entry_point': hex(elf['e_entry']),
        'interpreter': next(s.get_interp_name() for s in elf.iter_segments()
                            if s['p_type'] == 'PT_INTERP'),
        'dependencies': [t.needed for t in sections['.dynamic'].iter_tags()
                         if t['d_tag'] == 'DT_NEEDED'],
        'function_range_count': len(funcs),
        'has_symbol_table': '.symtab' in sections,
        'has_debug_info': '.debug_info' in sections,
        'compiler_comments': sections['.comment'].data().decode(errors='replace').split('\0'),
        'sections': [{'name': s.name, 'address': hex(s['sh_addr']),
                      'size': s['sh_size'], 'offset': s['sh_offset']}
                     for s in sections.values()],
        'method': 'FDE boundaries plus linear ARM64 address propagation; candidate references only',
    })
    dump(out / 'imports.json', imports)
    dump(out / 'functions.json', [{'start': hex(s), 'size': n} for s, n in funcs])
    dump(out / 'strings.json', strings)
    dump(out / 'plt.json', {hex(k): v for k, v in plt.items()})
    refs, calls, regs = [], [], {}
    md = Cs(CS_ARCH_ARM64, CS_MODE_LITTLE_ENDIAN)
    md.skipdata = True
    curfunc = None
    for pc, size, mnemonic, operands in md.disasm_lite(textsec.data(), ts):
        f = owner(pc)
        if f != curfunc:
            regs.clear()
            curfunc = f

        def remember(addr, how):
            if addr in selected:
                refs.append({'instruction': hex(pc), 'function': hex(f) if f else None,
                             'string_address': hex(addr), 'text': selected[addr]['text'],
                             'instruction_text': mnemonic + ' ' + operands, 'via': how})

        if mnemonic in ('bl', 'b'):
            m = re.fullmatch(IMM, operands)
            if m:
                target = int(m[1], 0)
                calls.append({'instruction': hex(pc), 'function': hex(f) if f else None,
                              'target': hex(target), 'import': plt.get(target),
                              'tail': mnemonic == 'b'})
            if mnemonic == 'bl':
                for n in range(19):
                    regs.pop('x' + str(n), None)
            continue
        if mnemonic in ('adrp', 'adr'):
            m = re.fullmatch(REG + r', ' + IMM, operands)
            if m:
                regs[m[1]] = int(m[2], 0)
                if mnemonic == 'adr':
                    remember(regs[m[1]], mnemonic)
            continue
        if mnemonic in ('add', 'sub'):
            m = re.fullmatch(REG + r', ' + REG + r', ' + IMM, operands)
            if m and m[2] in regs:
                regs[m[1]] = regs[m[2]] + (1 if mnemonic == 'add' else -1) * int(m[3], 0)
                remember(regs[m[1]], mnemonic)
            else:
                regs.pop(operands.split(',')[0], None)
            continue
        if mnemonic == 'mov':
            m = re.fullmatch(REG + r', ' + REG, operands)
            if m and m[2] in regs:
                regs[m[1]] = regs[m[2]]
            else:
                regs.pop(operands.split(',')[0], None)
            continue
        if mnemonic.startswith(('ldr', 'ldur')):
            m = re.fullmatch(REG + r', \[' + REG + r'(?:, ' + IMM + r')?\]', operands)
            if m:
                addr = regs.get(m[2])
                if addr is not None:
                    addr += int(m[3], 0) if m[3] else 0
                    remember(addr, 'load_address')
                    if mnemonic == 'ldr' and m[1].startswith('x'):
                        val = relocs.get(addr, int.from_bytes(read_addr(addr, 8), 'little'))
                        regs[m[1]] = val
                        remember(val, 'load_pointer')
                    else:
                        regs.pop(m[1], None)
                else:
                    regs.pop(m[1], None)
            else:
                regs.pop(operands.split(',')[0], None)
            continue
        # Conservative invalidation for common instructions that write a GPR.
        if not mnemonic.startswith(('str', 'stp', 'stur', 'cb', 'tb', 'b.', 'cmp', 'tst', 'ret', 'br', 'nop')):
            regs.pop(operands.split(',')[0], None)

    dump(out / 'references.json', refs)
    dump(out / 'calls.json', calls)
    persisted = [s for s in strings if KEY.fullmatch(s['text'])]
    dump(out / 'config_keys.json', [{'key': s['text'][:-1],
                                    'string_address': hex(s['address']),
                                    'references': [r for r in refs if r['string_address'] == hex(s['address'])]}
                                   for s in persisted])
    hot = {int(r['function'], 16) for r in refs if r['function']}
    byfunc = {s: n for s, n in funcs}
    asm_dir = out / 'assembly'
    asm_dir.mkdir(exist_ok=True)
    for s in sorted(hot):
        size = byfunc[s]
        buf = textsec.data()[s - ts:s - ts + size]
        lines = []
        for pc, _, mnemonic, operands in md.disasm_lite(buf, s):
            annotation = ''
            m = re.fullmatch(IMM, operands)
            if mnemonic in ('bl', 'b') and m and int(m[1], 0) in plt:
                annotation = ' ; ' + plt[int(m[1], 0)]
            for r in refs:
                if r['instruction'] == hex(pc):
                    annotation += ' ; ' + repr(r['text'])
            lines.append(f'{pc:08x}: {mnemonic:8} {operands}{annotation}')
        (asm_dir / f'{s:08x}.asm').write_text('\n'.join(lines) + '\n')
    print(json.dumps({'sha256': hashlib.sha256(data).hexdigest(),
                      'functions': len(funcs), 'strings': len(strings),
                      'candidate_config_keys': len(persisted), 'references': len(refs),
                      'assembly_functions': len(hot)}, ensure_ascii=False))


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('binary', type=Path)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    inventory(args.binary, args.output)
