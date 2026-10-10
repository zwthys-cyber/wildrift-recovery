#!/usr/bin/env python3
"""Compare recovered transforms with bounded original iOS instructions.

Only the two pure RAM transforms run: no framework entry point, calls,
syscalls, task access, game actions, file loading or network code is executed.
"""
import hashlib
import os
import random
import struct
import sys
import unittest
from pathlib import Path
from unicorn import Uc, UC_ARCH_ARM64, UC_MODE_ARM, UC_HOOK_CODE
from unicorn.arm64_const import (UC_ARM64_REG_X0, UC_ARM64_REG_X1,
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

    def test_stream_block_64_states(self):
        rng = random.Random(20261010)
        states = [[0] * 16, [0xffffffff] * 16] + [[rng.getrandbits(32) for _ in range(16)] for _ in range(62)]
        for state in states:
            uc = machine(self.fw, 0x2ca2c34, 0x2ca2ed8)
            uc.mem_map(STATE, 8192)
            uc.mem_write(STATE, struct.pack('<16I', *state))
            uc.reg_write(UC_ARM64_REG_X0, OUTPUT)
            uc.reg_write(UC_ARM64_REG_X1, STATE)
            uc.emu_start(0x2ca2c34, HALT, count=20000)
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
            uc = machine(self.fw, 0x2cc4004, 0x2cc4104)
            for page in (0x10a91000, 0x10b35000, 0x10239000, STATE): uc.mem_map(page, 4096)
            uc.mem_write(STATE, self.md.header)
            uc.mem_write(0x10239480, self.md.keys)
            source = 0x60000000
            address = source + self.md.string_offset + index
            first, last = address & ~4095, (address + len(name) + 1 + 4095) & ~4095
            uc.mem_map(first, last - first)
            uc.mem_write(address, self.md.data[self.md.string_offset + index:self.md.string_offset + index + len(name) + 1])
            bitmap = 0x70000000
            word = bitmap + (index >> 5) * 4
            uc.mem_map(word & ~4095, 4096)
            uc.mem_write(0x10a915d0, struct.pack('<QQ', source, STATE))
            uc.mem_write(0x10b357d8, struct.pack('<Q', bitmap))
            for _ in range(2):
                uc.reg_write(UC_ARM64_REG_X0, index)
                uc.reg_write(UC_ARM64_REG_LR, HALT)
                uc.emu_start(0x2cc4004, HALT, count=200000)
                self.assertEqual(uc.reg_read(UC_ARM64_REG_X0), address)
                self.assertEqual(bytes(uc.mem_read(address, len(name) + 1)), name + b'\0')

    def test_tables_and_concrete_fields(self):
        self.assertEqual([self.md.tables[n]['count'] for n in ('types','fields','methods','images')],
                         [47894, 495160, 390601, 86])
        checks = [(37468, 'DriveEntryUnity', '_cur', 0, True),
                  (37473, 'FEVisi', '_myHero', 0x30, True),
                  (37505, 'VisiActorMgr', 'visiActorList', 0x10, False),
                  (37453, 'BattleActorVisi', '_actor', 0xa0, False),
                  (34683, 'BattleActor', '_skillMgr', 0xa0, False)]
        for index, name, field_name, offset, static in checks:
            record = self.md.type(index)
            self.assertEqual(record['name'], name)
            field = next(f for f in self.native.fields(record) if f['name'] == field_name)
            self.assertEqual((field['offset'], field['static']), (offset, static))
        method = next(m for m in self.native.methods(self.md.type(34648)) if m['name'] == 'get_resId')
        self.assertEqual(method['native_address'], 0x4ecc1c8)
        self.assertEqual(method['declaring_module'], 'Assembly-CSharp.dll')

    def test_profile_and_input_rejection(self):
        with self.assertRaises(ValueError): Metadata(self.md.data, b'wrong framework')
        bad = b'XXXX' + self.md.data[4:]
        with self.assertRaises(ValueError): Metadata(bad, self.fw)
        with self.assertRaises(ValueError): self.md.name(self.md.string_size)
        with self.assertRaises(ValueError): self.md.record('types', 47894, '<16i8H2I')
        with self.assertRaises(ValueError): self.native.type(self.native.type_count)
        with self.assertRaises(ValueError): self.native.read(0x10d5c000, '<Q')


if __name__ == '__main__': unittest.main()
