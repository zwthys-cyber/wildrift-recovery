#!/usr/bin/env python3
"""Recover serialized fields and initialization constants from this exact ELF.

Only the constructor's straight-line stores are emulated. Loader helper calls
are intercepted to capture arguments; no syscalls, files, or network execute.
"""
import argparse
import io
import json
import re
import struct
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_LITTLE_ENDIAN
from elftools.elf.elffile import ELFFile
from unicorn import Uc, UC_ARCH_ARM64, UC_MODE_ARM, UC_HOOK_CODE
from unicorn.arm64_const import (UC_ARM64_REG_X0, UC_ARM64_REG_X1, UC_ARM64_REG_X2,
    UC_ARM64_REG_X19, UC_ARM64_REG_W3, UC_ARM64_REG_W4, UC_ARM64_REG_S0,
    UC_ARM64_REG_S1, UC_ARM64_REG_SP, UC_ARM64_REG_PC, UC_ARM64_REG_TPIDR_EL0)

EXPECTED_SHA = 'e385f312ecbb5e575d2709a15a3b0157aa6fb37b52299075d9665f14df6fd111'
CONSTRUCTOR, PURE_END = 0x426f24, 0x42718c
SAVER, SAVER_END = 0x429fc8, 0x42ad68
APPLY, APPLY_END = 0x427b38, 0x4281a4
OBJECT, STACK, TLS = 0x20000000, 0x10000000, 0x30000000


def recover(binary, out):
    import hashlib
    data = binary.read_bytes()
    if hashlib.sha256(data).hexdigest() != EXPECTED_SHA:
        raise ValueError('Hard-coded addresses apply only to the verified original ELF')
    elf = ELFFile(io.BytesIO(data))
    md = Cs(CS_ARCH_ARM64, CS_MODE_LITTLE_ENDIAN)
    uc = Uc(UC_ARCH_ARM64, UC_MODE_ARM)
    uc.mem_map(0, 0x600000)
    for seg in elf.iter_segments():
        if seg['p_type'] == 'PT_LOAD':
            uc.mem_write(seg['p_vaddr'], seg.data())
    for addr, size in [(OBJECT, 0x4000), (STACK, 0x20000), (TLS, 0x1000)]:
        uc.mem_map(addr, size)
    uc.reg_write(UC_ARM64_REG_SP, STACK + 0x10000)
    uc.reg_write(UC_ARM64_REG_TPIDR_EL0, TLS)
    uc.reg_write(UC_ARM64_REG_X0, OBJECT)
    uc.reg_write(UC_ARM64_REG_X1, 0)
    constructor_trace = []

    def guard(u, pc, size, _):
        ins = next(md.disasm(bytes(u.mem_read(pc, size)), pc))
        if ins.mnemonic.startswith(('bl', 'svc', 'hvc', 'smc', 'br', 'b.')) or ins.mnemonic in ('b', 'ret'):
            raise RuntimeError(f'Unexpected control transfer in pure initializer at {pc:#x}')
        constructor_trace.append(f'{pc:08x}: {ins.mnemonic:8} {ins.op_str}')

    h = uc.hook_add(UC_HOOK_CODE, guard)
    uc.emu_start(CONSTRUCTOR, PURE_END, count=1024)
    uc.hook_del(h)
    if uc.reg_read(UC_ARM64_REG_PC) != PURE_END:
        raise RuntimeError('Initializer did not reach the expected boundary')
    image = bytes(uc.mem_read(OBJECT, 0x440))
    (out / 'constructor.asm').write_text('\n'.join(constructor_trace) + '\n')
    (out / 'constructor-object.bin').write_bytes(image)

    def cstring(addr):
        return bytes(uc.mem_read(addr, 256)).split(b'\0', 1)[0].decode('utf-8')

    regs, fields, active = {}, {}, None
    saver = list(md.disasm_lite(bytes(uc.mem_read(SAVER, SAVER_END - SAVER)), SAVER))
    for pc, _, op, operands in saver:
        m = re.fullmatch(r'(x\d+), #?(0x[0-9a-f]+)', operands)
        if op == 'adrp' and m:
            regs[m[1]] = int(m[2], 16)
        elif op == 'add':
            m = re.fullmatch(r'(x\d+), (x\d+), #?(0x[0-9a-f]+|\d+)', operands)
            if m and m[2] in regs:
                regs[m[1]] = regs[m[2]] + int(m[3], 0)
            else:
                regs.pop(operands.split(',')[0], None)
        elif op == 'mov':
            m = re.fullmatch(r'(x\d+), (x\d+)', operands)
            if m and m[2] in regs:
                regs[m[1]] = regs[m[2]]
            else:
                regs.pop(operands.split(',')[0], None)
        elif op == 'bl':
            target = int(operands.lstrip('#'), 0)
            if target == 0x3a07c0 and 'x1' in regs and 0x1f8d0 <= regs['x1'] < 0x34426c:
                s = cstring(regs['x1'])
                if re.fullmatch(r'[a-z][A-Za-z0-9_]+=', s):
                    active = s[:-1]
                    fields.setdefault(active, {'key': active, 'serializer_reference': hex(pc),
                                               'offsets': [], 'load_instructions': []})
            for i in range(19):
                regs.pop('x' + str(i), None)
        elif op in ('ldr', 'ldrb'):
            m = re.fullmatch(r'(s0|w1), \[x19, #(0x[0-9a-f]+)\]', operands)
            if m and active:
                off = int(m[2], 16)
                f = fields[active]
                f['offsets'].append(off)
                f['load_instructions'].append(hex(pc))
                f['type'] = 'bool' if op == 'ldrb' else ('float' if m[1][0] == 's' else 'int')
    for f in fields.values():
        if len(f['offsets']) == 4:
            f['type'] = 'color'
        vals = []
        for off in f['offsets']:
            if f['type'] == 'bool': val = bool(image[off])
            elif f['type'] == 'int': val = struct.unpack_from('<i', image, off)[0]
            else: val = struct.unpack_from('<f', image, off)[0]
            vals.append(val)
        if not vals:
            raise RuntimeError('Missing serialized field load: ' + f['key'])
        f['default'] = vals if f['type'] == 'color' else vals[0]
        f['confidence'] = 'verified serializer load and bounded initialization emulation'
    byoff = {f['offsets'][0]: f for f in fields.values()}

    def capture(u, pc, size, _):
        ins = next(md.disasm(bytes(u.mem_read(pc, size)), pc))
        if ins.mnemonic == 'bl':
            target = int(ins.op_str.lstrip('#'), 0)
            if target in (0x4326a4, 0x432854, 0x4329d4, 0x432b50):
                key = cstring(u.reg_read(UC_ARM64_REG_X1))
                off = u.reg_read(UC_ARM64_REG_X2) - OBJECT
                f = byoff.get(off)
                if not f or f['key'] != key:
                    raise RuntimeError(f'Loader/serializer mismatch for {key}: {off:#x}')
                f['loader_reference'] = hex(pc)
                if target == 0x432854:
                    f['min'], f['max'] = [struct.unpack('<i', struct.pack('<I', u.reg_read(r)))[0]
                                         for r in (UC_ARM64_REG_W3, UC_ARM64_REG_W4)]
                elif target == 0x4329d4:
                    f['min'], f['max'] = [struct.unpack('<f', struct.pack('<I', u.reg_read(r)))[0]
                                         for r in (UC_ARM64_REG_S0, UC_ARM64_REG_S1)]
            u.reg_write(UC_ARM64_REG_PC, pc + 4)
        elif ins.mnemonic in ('svc', 'hvc', 'smc', 'blr', 'br', 'ret'):
            raise RuntimeError('Unexpected operation in loader argument capture')

    uc.reg_write(UC_ARM64_REG_X19, OBJECT)
    uc.reg_write(UC_ARM64_REG_SP, STACK + 0x10000)
    h = uc.hook_add(UC_HOOK_CODE, capture)
    uc.emu_start(APPLY, APPLY_END, count=2048)
    uc.hook_del(h)
    if uc.reg_read(UC_ARM64_REG_PC) != APPLY_END:
        raise RuntimeError('Loader argument capture did not finish')
    # The explicit three-way check follows the smite threshold parser.
    fields['smiteHealthThreshold']['choices'] = [600, 1000, 1400]
    fields['smiteHealthThreshold']['invalid_choice_fallback'] = 1000
    for f in fields.values():
        if 'loader_reference' not in f:
            raise RuntimeError('Unverified loader field: ' + f['key'])
    schema = {'binary_sha256': EXPECTED_SHA,
              'constructor': hex(CONSTRUCTOR), 'constructor_stop_before_calls': hex(PURE_END),
              'loader': '0x427698', 'serializer': hex(SAVER),
              'format_version': 1, 'serialized_float_decimal_places': 4,
              'fields': list(fields.values())}
    (out / 'recovered_config.json').write_text(json.dumps(schema, ensure_ascii=False, indent=2) + '\n')
    lines = ['version=1']
    for f in fields.values():
        v = f['default']
        if f['type'] == 'bool': s = str(int(v))
        elif f['type'] == 'int': s = str(v)
        elif f['type'] == 'color': s = ','.join(f'{x:.4f}' for x in v)
        else: s = f'{v:.4f}'
        lines.append(f'{f["key"]}={s}')
    (out / 'recovered_defaults.ini').write_text('\n'.join(lines) + '\n')
    print(json.dumps({'fields': len(fields), 'types': {t: sum(f['type'] == t for f in fields.values())
                      for t in ('bool', 'int', 'float', 'color')}}, ensure_ascii=False))


if __name__ == '__main__':
    p = argparse.ArgumentParser()
    p.add_argument('binary', type=Path)
    p.add_argument('--output', type=Path, required=True)
    a = p.parse_args()
    recover(a.binary, a.output)
