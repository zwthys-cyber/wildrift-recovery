#!/usr/bin/env python3
"""Compare recovered transforms with bounded original iOS instructions.

Only the two pure RAM transforms run: no framework entry point, calls,
syscalls, task access, game actions, file loading or network code is executed.
"""
import hashlib
import json
import os
import random
import struct
import sys
import unittest
from pathlib import Path
from unicorn import Uc, UC_ARCH_ARM64, UC_MODE_ARM, UC_HOOK_CODE
from unicorn.arm64_const import (UC_ARM64_REG_X0, UC_ARM64_REG_X1, UC_ARM64_REG_X9,
                                 UC_ARM64_REG_SP, UC_ARM64_REG_LR)

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
from recover_ios_metadata import Metadata, NativeTables, FRAMEWORK_SHA256, stream_block

FRAMEWORK = Path(os.environ.get('LVLOLM_IOS_FRAMEWORK', str(ROOT / 'inputs/ios-0.2.0/Bundle/Frameworks/UnityFramework.framework/UnityFramework')))
METADATA = Path(os.environ.get('LVLOLM_IOS_METADATA', str(ROOT / 'inputs/ios-0.2.0/Bundle/Data/Managed/Metadata/global-metadata.dat')))
STACK, HALT, STATE, OUTPUT = 0x30000000, 0x40000000, 0x50000000, 0x50001000


def machine(framework, start, end):
    uc = Uc(UC_ARCH_ARM64, UC_MODE_ARM)
    page = start & ~4095
    uc.mem_map(page, ((end + 4095) & ~4095) - page)
    uc.mem_write(start, framework[start:end])
    uc.mem_map(STACK, 0x10000)
    uc.mem_map(HALT, 4096)
    uc.reg_write(UC_ARM64_REG_SP, STACK + 0x8000)
    uc.reg_write(UC_ARM64_REG_LR, HALT)

    def guard(u, pc, size, _):
        if not start <= pc < end: raise AssertionError(f'Execution escaped pure function: {pc:#x}')
        word, = struct.unpack('<I', bytes(u.mem_read(pc, size)))
        if word & 0xfc000000 == 0x94000000 or word & 0xfffffc1f == 0xd63f0000:
            raise AssertionError('Unexpected external call')
        if word & 0xffe0001f == 0xd4000001: raise AssertionError('Unexpected syscall')
    uc.hook_add(UC_HOOK_CODE, guard)
    return uc


@unittest.skipUnless(FRAMEWORK.exists() and METADATA.exists(), 'Private iOS inputs not present')
class OriginalInstructions(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.fw = FRAMEWORK.read_bytes()
        if hashlib.sha256(cls.fw).hexdigest() != FRAMEWORK_SHA256:
            raise ValueError('Wrong iOS framework profile')
        cls.md = Metadata(METADATA.read_bytes(), cls.fw)
        cls.native = NativeTables(cls.fw, cls.md)
        from capstone import Cs, CS_ARCH_ARM64, CS_MODE_LITTLE_ENDIAN
        cs=Cs(CS_ARCH_ARM64,CS_MODE_LITTLE_ENDIAN);cs.detail=True
        def address(pc):
            a,b=list(cs.disasm(cls.fw[pc:pc+8],pc))
            return a.operands[1].imm+b.operands[1].mem.disp
        cls.metadata_global=address(0x17841b8+0x18)
        cls.bitmap_global=address(0x17841b8+0x34)
        cls.string_keys=0xe9903e0

    def test_original_international_spell_identifiers(self):
        fields={f['index']:f['name'] for f in self.native.fields(self.md.type(26902)) if f['literal']}
        fo,fs=struct.unpack_from('<II',self.md.header,0x40)
        do,ds=struct.unpack_from('<II',self.md.header,0x48)
        actual={}
        for pos in range(fo,fo+fs,12):
            field,typ,offset=struct.unpack_from('<iii',self.md.data,pos)
            if field not in fields:continue
            self.assertGreaterEqual(offset,0);self.assertLess(offset+4,ds)
            raw=self.md.data[do+offset:do+offset+4];prefix=raw[0]
            if prefix<128:value=prefix
            elif prefix<192:value=((prefix&63)<<8)|raw[1]
            else:
                self.assertLess(prefix,224)
                value=((prefix&31)<<24)|int.from_bytes(raw[1:4],'big')
            actual[fields[field]]=-(value>>1)-1 if value&1 else value>>1
        expected=json.loads((ROOT/'analysis/international-spell-ids.json').read_text())
        self.assertEqual(actual,expected)
        # Independent original initializer emits Ignite's resource constant.
        uc=machine(self.fw,0x8ecc9d8,0x8ecc9e0)
        uc.emu_start(0x8ecc9d8,0x8ecc9e0,count=4)
        self.assertEqual(uc.reg_read(UC_ARM64_REG_X9),actual['SUMMON_SKILL_TYPE_IGNITE'])
        self.assertNotEqual(actual['SUMMON_SKILL_TYPE_IGNITE'],actual['SUMMON_SKILL_TYPE_SMITE'])

    def test_stream_block_64_states(self):
        rng = random.Random(20261010)
        states = [[0] * 16, [0xffffffff] * 16] + [[rng.getrandbits(32) for _ in range(16)] for _ in range(62)]
        for state in states:
            uc = machine(self.fw, 0x1762e58, 0x17630fc)
            uc.mem_map(STATE, 8192)
            uc.mem_write(STATE, struct.pack('<16I', *state))
            uc.reg_write(UC_ARM64_REG_X0, OUTPUT)
            uc.reg_write(UC_ARM64_REG_X1, STATE)
            uc.emu_start(0x1762e58, HALT, count=20000)
            self.assertEqual(uc.reg_read(UC_ARM64_REG_X0), OUTPUT)
            self.assertEqual(bytes(uc.mem_read(OUTPUT, 64)), stream_block(state))

    def test_names_and_cached_repeat(self):
        rng = random.Random(31)
        indices = {0x10, 0x14, 0x28, 0x47, 0x7d}
        for image in range(self.md.tables['images']['count']):
            indices.add(self.md.record('images', image, '<10i')[0])
        for i in range(120):
            table = 'types' if i % 2 else 'fields'
            ix = rng.randrange(self.md.tables[table]['count'])
            fmt = '<16i8H2I' if table == 'types' else '<IiI'
            indices.add(self.md.record(table, ix, fmt)[0])
        self.assertGreaterEqual(len(indices), 190)
        for index in indices:
            name = self.md.name(index).encode('utf-8')
            uc = machine(self.fw, 0x17841b8, 0x17842b8)
            for page in {self.metadata_global&~4095,self.bitmap_global&~4095,self.string_keys&~4095,STATE}: uc.mem_map(page, 4096)
            uc.mem_write(STATE, self.md.header)
            uc.mem_write(self.string_keys, self.md.keys)
            source = 0x60000000
            address = source + self.md.string_offset + index
            first, last = address & ~4095, (address + len(name) + 1 + 4095) & ~4095
            uc.mem_map(first, last - first)
            uc.mem_write(address, self.md.data[self.md.string_offset + index:self.md.string_offset + index + len(name) + 1])
            bitmap = 0x70000000
            word = bitmap + (index >> 5) * 4
            uc.mem_map(word & ~4095, 4096)
            uc.mem_write(self.metadata_global, struct.pack('<QQ', source, STATE))
            uc.mem_write(self.bitmap_global, struct.pack('<Q', bitmap))
            for _ in range(2):
                uc.reg_write(UC_ARM64_REG_X0, index)
                uc.reg_write(UC_ARM64_REG_LR, HALT)
                uc.emu_start(0x17841b8, HALT, count=200000)
                self.assertEqual(uc.reg_read(UC_ARM64_REG_X0), address)
                self.assertEqual(bytes(uc.mem_read(address, len(name) + 1)), name + b'\0')

    def test_tables_and_concrete_fields(self):
        self.assertEqual([self.md.tables[n]['count'] for n in ('types','fields','methods','images')],
                         [49134, 497025, 392546, 88])
        checks = [(37277, 'DriveEntryUnity', '_cur', 0, True),
                  (37282, 'FEVisi', '_myHero', 0x30, True),
                  (37314, 'VisiActorMgr', 'visiActorList', 0x10, False),
                  (37262, 'BattleActorVisi', '_actor', 0xa0, False),
                  (34492, 'BattleActor', '_skillMgr', 0xa0, False)]
        for index, name, field_name, offset, static in checks:
            record = self.md.type(index)
            self.assertEqual(record['name'], name)
            field = next(f for f in self.native.fields(record) if f['name'] == field_name)
            self.assertEqual((field['offset'], field['static']), (offset, static))
        method = next(m for m in self.native.methods(self.md.type(34457)) if m['name'] == 'get_resId')
        self.assertEqual(method['native_address'], 0x39452ac)
        self.assertEqual(method['declaring_module'], 'Assembly-CSharp.dll')

    def test_profile_and_input_rejection(self):
        with self.assertRaises(ValueError): Metadata(self.md.data, b'wrong framework')
        bad = b'XXXX' + self.md.data[4:]
        with self.assertRaises(ValueError): Metadata(bad, self.fw)
        with self.assertRaises(ValueError): self.md.name(self.md.string_size)
        with self.assertRaises(ValueError): self.md.record('types', 49134, '<16i8H2I')
        with self.assertRaises(ValueError): self.native.type(self.native.type_count)
        with self.assertRaises(ValueError): self.native.read(0x10d5c000, '<Q')


if __name__ == '__main__': unittest.main()
