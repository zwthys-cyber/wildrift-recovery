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
        for start, member in ((0x4f81308, 0x18), (0x4ecc0ec, 0x20), (0x4ecc1a4, 0x38), (0x4ecc1c8, 0x44)):
            for value in (0, 81110101, 0xffffffff):
                uc = machine(self.fw, start, start + 12)
                q(uc, HEAP + 0x18, HEAP + 0x1000); d(uc, HEAP + 0x1000 + member, value)
                uc.reg_write(UC_ARM64_REG_X0, HEAP)
                uc.emu_start(start, HALT, count=100)
                self.assertEqual(uc.reg_read(UC_ARM64_REG_X0), value)

    def test_fix_position(self):
        for values in ((-16384, 0, 8192), (12345678, -987654, 1638400), (-(1 << 63), (1 << 63)-1, -1)):
            uc = machine(self.fw, 0x4f82550, 0x4f82568)
            q(uc, HEAP + 0x18, HEAP + 0x1000)
            raw = struct.pack('<3q', *values); uc.mem_write(HEAP + 0x1018, raw)
            uc.reg_write(UC_ARM64_REG_X0, HEAP); uc.reg_write(UC_ARM64_REG_X8, HEAP + 0xb000)
            uc.emu_start(0x4f82550, HALT, count=100)
            self.assertEqual(bytes(uc.mem_read(HEAP + 0xb000, 24)), raw)

    def test_cd_left_time_locked_and_signed_clamp(self):
        for locked in (0, 1, 255):
            for remaining in (-16384, 0, 8192, 30 * 16384, (1 << 63)-1):
                uc = machine(self.fw, 0x4ed1f94, 0x4ed2268)
                for page in (0x10b37000, 0x10604000): uc.mem_map(page, 4096)
                uc.mem_write(0x10b37bdd, b'\x01')
                q(uc, 0x106048c0, HEAP + 0x8000); d(uc, HEAP + 0x80e0, 1)
                q(uc, HEAP + 0x80b8, HEAP + 0x9000); q(uc, HEAP + 0x9018, 0)
                q(uc, HEAP + 0x18, HEAP + 0x1000); q(uc, HEAP + 0x60, HEAP + 0x4000)
                q(uc, HEAP + 0x4010, HEAP + 0x1420); q(uc, HEAP + 0x4018, HEAP + 0x1420)
                q(uc, HEAP + 0x1440, HEAP + 0x6000); q(uc, HEAP + 0x4028, HEAP + 0x5000)
                q(uc, HEAP + 0x5010, HEAP + 0x6000); q(uc, HEAP + 0x5018, HEAP + 0x6000)
                uc.mem_write(HEAP + 0x6018, bytes([locked])); q(uc, HEAP + 0x6020, remaining)
                uc.reg_write(UC_ARM64_REG_X0, HEAP)
                uc.emu_start(0x4ed1f94, HALT, count=1000)
                self.assertEqual(uc.reg_read(UC_ARM64_REG_X0), 0 if locked else max(remaining, 0))

    def test_native_skill_vector_accessor(self):
        for count in (0, 1, 3):
            for index in (-1, 0, 1, 2, 3):
                uc = machine(self.fw, 0x4ebd8a0, 0x4ebdaf8, stop_before=0x4ebda20)
                for page in (0x10b37000, 0x10b3c000, 0x1062f000, 0x10645000, 0x10619000): uc.mem_map(page, 4096)
                uc.mem_write(0x10b37bc2, b'\x01'); uc.mem_write(0x10b37bbd, b'\x01'); uc.mem_write(0x10b3c084, b'\x01')
                q(uc, 0x10619ce0, HEAP + 0x8000); d(uc, HEAP + 0x80e0, 1)
                q(uc, 0x10645128, HEAP + 0x9000); q(uc, HEAP + 0x9020, HEAP + 0xa000)
                q(uc, HEAP + 0x18, HEAP + 0x1000); q(uc, HEAP + 0xf8, HEAP + 0x4000)
                q(uc, HEAP + 0x4010, HEAP + 0x1208); q(uc, HEAP + 0x4018, HEAP + 0x1208)
                q(uc, HEAP + 0x4020, HEAP + 0x5000); q(uc, HEAP + 0x5010, HEAP + 0x1218)
                q(uc, HEAP + 0x1218, HEAP + 0x6000); q(uc, HEAP + 0x1220, HEAP + 0x6000 + count * 8)
                d(uc, HEAP + 0x1230, 8)
                for i in range(count): q(uc, HEAP + 0x6000 + i * 8, HEAP + 0xb000 + i * 0x100)
                uc.reg_write(UC_ARM64_REG_X0, HEAP); uc.reg_write(UC_ARM64_REG_X1, index & 0xffffffff)
                uc.emu_start(0x4ebd8a0, HALT, count=2000)
                register = UC_ARM64_REG_X19 if 0 <= index < count else UC_ARM64_REG_X0
                self.assertEqual(uc.reg_read(register), HEAP + 0xb000 + index * 0x100 if 0 <= index < count else 0)

    def test_stock_slot_and_cast_state_values(self):
        for start, member in ((0x514b264, 0x1c), (0x514b270, 0x20), (0x5146a6c, 0x18), (0x514a0c4, 0x18)):
            for value in (0, 2, 0xffffffff):
                uc = machine(self.fw, start, start + 12)
                q(uc, HEAP + 0x18, HEAP + 0x1000); d(uc, HEAP + 0x1000 + member, value)
                uc.reg_write(UC_ARM64_REG_X0, HEAP)
                uc.emu_start(start, HALT, count=100)
                self.assertEqual(uc.reg_read(UC_ARM64_REG_X0), value)

    def test_cast_state_predicates(self):
        cases = ((0x514a328, 16, lambda s: bool(s & 0x40)),
                 (0x514a338, 16, lambda s: bool(s & 0x20)),
                 (0x514a348, 28, lambda s: (s & 0x50) == 0x40),
                 (0x514a364, 16, lambda s: bool(s & 0x10)),
                 (0x514a374, 16, lambda s: bool(s & 0x200)),
                 (0x514a384, 20, lambda s: s == 0x100))
        for start, length, predicate in cases:
            for state in (0, 1, 0x10, 0x20, 0x40, 0x50, 0x60, 0x70, 0x100, 0x200, 0x300, 0xffffffff):
                uc = machine(self.fw, start, start + length)
                q(uc, HEAP + 0x18, HEAP + 0x1000); d(uc, HEAP + 0x1018, state)
                uc.reg_write(UC_ARM64_REG_X0, HEAP)
                uc.emu_start(start, HALT, count=100)
                self.assertEqual(uc.reg_read(UC_ARM64_REG_X0), int(predicate(state)))


if __name__ == '__main__': unittest.main()
