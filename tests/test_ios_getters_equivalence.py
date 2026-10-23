#!/usr/bin/env python3
"""Run bounded original getters in synthetic RAM; reject calls and syscalls.

No game entry point or device memory is accessed. The vector accessor stops
before class initialization and wrapper conversion; only the selected native pointer is
compared. Framework bytes are used locally and are not distributed.
"""
import hashlib
import os
import struct
import sys
import unittest
from pathlib import Path
from unicorn import Uc, UC_ARCH_ARM64, UC_MODE_ARM, UC_HOOK_CODE
from unicorn.arm64_const import UC_ARM64_REG_X0, UC_ARM64_REG_X1, UC_ARM64_REG_X8, UC_ARM64_REG_X19, UC_ARM64_REG_SP, UC_ARM64_REG_LR

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
from recover_ios_metadata import FRAMEWORK_SHA256
FRAMEWORK = Path(os.environ.get('LVLOLM_IOS_FRAMEWORK', str(ROOT / 'inputs/ios-0.2.0/Bundle/Frameworks/UnityFramework.framework/UnityFramework')))
HEAP, STACK, HALT = 0x350000000, 0x60000000, 0x70000000


def machine(framework, start, end, stop_before=None):
    uc = Uc(UC_ARCH_ARM64, UC_MODE_ARM)
    page = start & ~4095
    uc.mem_map(page, ((end + 4095) & ~4095) - page)
    uc.mem_write(start, framework[start:end])
    uc.mem_map(HEAP, 0x10000); uc.mem_map(STACK, 0x10000); uc.mem_map(HALT, 4096)
    uc.reg_write(UC_ARM64_REG_SP, STACK + 0x8000); uc.reg_write(UC_ARM64_REG_LR, HALT)

    def guard(u, pc, size, _):
        if pc == stop_before:
            u.emu_stop(); return
        if not start <= pc < end: raise AssertionError(f'Getter escaped: {pc:#x}')
        word, = struct.unpack('<I', bytes(u.mem_read(pc, size)))
        if word & 0xfc000000 == 0x94000000 or word & 0xfffffc1f == 0xd63f0000:
            raise AssertionError(f'Unexpected call: {pc:#x}')
        if word & 0xffe0001f == 0xd4000001: raise AssertionError('Unexpected syscall')
    uc.hook_add(UC_HOOK_CODE, guard)
    return uc


def q(uc, address, value): uc.mem_write(address, struct.pack('<Q', value & ((1 << 64) - 1)))
def d(uc, address, value): uc.mem_write(address, struct.pack('<I', value & 0xffffffff))


@unittest.skipUnless(FRAMEWORK.exists(), 'Private iOS framework not present')
class OriginalGetters(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.fw = FRAMEWORK.read_bytes()
        if hashlib.sha256(cls.fw).hexdigest() != FRAMEWORK_SHA256: raise ValueError('Wrong framework profile')

    def test_object_and_skill_values(self):
        for start, member in ((0x39f9840, 0x18), (0x39451d0, 0x20), (0x3945288, 0x38), (0x39452ac, 0x44)):
            for value in (0, 81110101, 0xffffffff):
                uc = machine(self.fw, start, start + 12)
                q(uc, HEAP + 0x18, HEAP + 0x1000); d(uc, HEAP + 0x1000 + member, value)
                uc.reg_write(UC_ARM64_REG_X0, HEAP)
                uc.emu_start(start, HALT, count=100)
                self.assertEqual(uc.reg_read(UC_ARM64_REG_X0), value)

    def test_original_cached_ward_classification(self):
        # Named original IsSummonedWards and interface accessor, after the
        # initialization call. Execute only their byte-load instruction.
        for start in (0x397ff04,0x397dbd4):
            for value in (0,1,255):
                uc=machine(self.fw,start,start+4)
                uc.mem_write(HEAP+0x158,bytes([value]));uc.mem_write(HEAP+0x157,bytes([1-value if value<2 else 0]))
                uc.reg_write(UC_ARM64_REG_X19,HEAP);uc.emu_start(start,start+4,count=10)
                self.assertEqual(uc.reg_read(UC_ARM64_REG_X0),value)

    def test_fix_position(self):
        for values in ((-16384, 0, 8192), (12345678, -987654, 1638400), (-(1 << 63), (1 << 63)-1, -1)):
            uc = machine(self.fw, 0x39faa88, 0x39faaa0)
            q(uc, HEAP + 0x18, HEAP + 0x1000)
            raw = struct.pack('<3q', *values); uc.mem_write(HEAP + 0x1018, raw)
            uc.reg_write(UC_ARM64_REG_X0, HEAP); uc.reg_write(UC_ARM64_REG_X8, HEAP + 0xb000)
            uc.emu_start(0x39faa88, HALT, count=100)
            self.assertEqual(bytes(uc.mem_read(HEAP + 0xb000, 24)), raw)

    def test_cd_left_time_locked_and_signed_clamp(self):
        for locked in (0, 1, 255):
            for remaining in (-16384, 0, 8192, 30 * 16384, (1 << 63)-1):
                uc = machine(self.fw, 0x394b078, 0x394b34c)
                for page in (0xf276000, 0xed5e000): uc.mem_map(page, 4096)
                uc.mem_write(0xf276c4f, b'\x01')
                q(uc, 0xed5e5a0, HEAP + 0x8000); d(uc, HEAP + 0x80e0, 1)
                q(uc, HEAP + 0x80b8, HEAP + 0x9000); q(uc, HEAP + 0x9018, 0)
                q(uc, HEAP + 0x18, HEAP + 0x1000); q(uc, HEAP + 0x60, HEAP + 0x4000)
                q(uc, HEAP + 0x4010, HEAP + 0x1420); q(uc, HEAP + 0x4018, HEAP + 0x1420)
                q(uc, HEAP + 0x1440, HEAP + 0x6000); q(uc, HEAP + 0x4028, HEAP + 0x5000)
                q(uc, HEAP + 0x5010, HEAP + 0x6000); q(uc, HEAP + 0x5018, HEAP + 0x6000)
                uc.mem_write(HEAP + 0x6018, bytes([locked])); q(uc, HEAP + 0x6020, remaining)
                uc.reg_write(UC_ARM64_REG_X0, HEAP)
                uc.emu_start(0x394b078, HALT, count=1000)
                self.assertEqual(uc.reg_read(UC_ARM64_REG_X0), 0 if locked else max(remaining, 0))

    def test_native_skill_vector_accessor(self):
        for count in (0, 1, 3):
            for index in (-1, 0, 1, 2, 3):
                uc = machine(self.fw, 0x3936984, 0x3936bdc, stop_before=0x3936b04)
                for page in (0xf276000, 0xf27b000, 0xed89000, 0xed9f000, 0xed74000): uc.mem_map(page, 4096)
                uc.mem_write(0xf276c34, b'\x01'); uc.mem_write(0xf276c2f, b'\x01'); uc.mem_write(0xf27b0b8, b'\x01')
                q(uc, 0xed74100, HEAP + 0x8000); d(uc, HEAP + 0x80e0, 1)
                q(uc, 0xed9f730, HEAP + 0x9000); q(uc, HEAP + 0x9020, HEAP + 0xa000)
                q(uc, HEAP + 0x18, HEAP + 0x1000); q(uc, HEAP + 0xf8, HEAP + 0x4000)
                q(uc, HEAP + 0x4010, HEAP + 0x1208); q(uc, HEAP + 0x4018, HEAP + 0x1208)
                q(uc, HEAP + 0x4020, HEAP + 0x5000); q(uc, HEAP + 0x5010, HEAP + 0x1218)
                q(uc, HEAP + 0x1218, HEAP + 0x6000); q(uc, HEAP + 0x1220, HEAP + 0x6000 + count * 8)
                d(uc, HEAP + 0x1230, 8)
                for i in range(count): q(uc, HEAP + 0x6000 + i * 8, HEAP + 0xb000 + i * 0x100)
                uc.reg_write(UC_ARM64_REG_X0, HEAP); uc.reg_write(UC_ARM64_REG_X1, index & 0xffffffff)
                uc.emu_start(0x3936984, HALT, count=2000)
                register = UC_ARM64_REG_X19 if 0 <= index < count else UC_ARM64_REG_X0
                self.assertEqual(uc.reg_read(register), HEAP + 0xb000 + index * 0x100 if 0 <= index < count else 0)

    def test_stock_slot_and_cast_state_values(self):
        for start, member in ((0x3bdc5b0, 0x1c), (0x3bdc5bc, 0x20), (0x3bd7db8, 0x18), (0x3bdb410, 0x18)):
            for value in (0, 2, 0xffffffff):
                uc = machine(self.fw, start, start + 12)
                q(uc, HEAP + 0x18, HEAP + 0x1000); d(uc, HEAP + 0x1000 + member, value)
                uc.reg_write(UC_ARM64_REG_X0, HEAP)
                uc.emu_start(start, HALT, count=100)
                self.assertEqual(uc.reg_read(UC_ARM64_REG_X0), value)

    def test_cast_state_predicates(self):
        cases = ((0x3bdb674, 16, lambda s: bool(s & 0x40)),
                 (0x3bdb684, 16, lambda s: bool(s & 0x20)),
                 (0x3bdb694, 28, lambda s: (s & 0x50) == 0x40),
                 (0x3bdb6b0, 16, lambda s: bool(s & 0x10)),
                 (0x3bdb6c0, 16, lambda s: bool(s & 0x200)),
                 (0x3bdb6d0, 20, lambda s: s == 0x100))
        for start, length, predicate in cases:
            for state in (0, 1, 0x10, 0x20, 0x40, 0x50, 0x60, 0x70, 0x100, 0x200, 0x300, 0xffffffff):
                uc = machine(self.fw, start, start + length)
                q(uc, HEAP + 0x18, HEAP + 0x1000); d(uc, HEAP + 0x1018, state)
                uc.reg_write(UC_ARM64_REG_X0, HEAP)
                uc.emu_start(start, HALT, count=100)
                self.assertEqual(uc.reg_read(UC_ARM64_REG_X0), int(predicate(state)))

    def test_attribute_last_position(self):
        for values in ((0,0,0),(-16384,0,8192),(8192000,0,8192000)):
            start,end=0x391a2bc,0x391a2e0
            uc=machine(self.fw,start,end);q(uc,HEAP+0x18,HEAP+0x1000)
            raw=struct.pack('<3q',*values);uc.mem_write(HEAP+0x1090,raw)
            uc.reg_write(UC_ARM64_REG_X0,HEAP);uc.reg_write(UC_ARM64_REG_X8,HEAP+0xb000)
            uc.emu_start(start,HALT,count=100)
            self.assertEqual(bytes(uc.mem_read(HEAP+0xb000,24)),raw)

    def test_original_minimap_hp_fraction_math(self):
        # Only two scalar instructions of UpdateHpPercent, after GetMaxHpVisi
        # and GetCurHp returned. No UI code or external getter is executed.
        from unicorn.arm64_const import UC_ARM64_REG_X20,UC_ARM64_REG_X21
        for maximum in (1,600*16384,690*16384,123456789):
            for current in (0,maximum//4,maximum//2,maximum-1,maximum):
                start,end=0x5e0ca2c,0x5e0ca34
                uc=machine(self.fw,start,end);uc.reg_write(UC_ARM64_REG_X20,maximum);uc.reg_write(UC_ARM64_REG_X21,current)
                uc.emu_start(start,end,count=100)
                self.assertEqual(uc.reg_read(UC_ARM64_REG_X21),(current<<14)//maximum)

    def test_original_minimap_dictionary_entry_stride(self):
        for index in (0,1,7,31):
            start,end=0x5e1fda8,0x5e1fdb4
            uc=machine(self.fw,start,end);value=HEAP+0x8000+index*8
            q(uc,HEAP+0x20+index*24+16,value)
            uc.reg_write(UC_ARM64_REG_X8,HEAP);uc.reg_write(UC_ARM64_REG_X0,index)
            uc.emu_start(start,end,count=100)
            self.assertEqual(uc.reg_read(UC_ARM64_REG_X1),value)


if __name__ == '__main__': unittest.main()
