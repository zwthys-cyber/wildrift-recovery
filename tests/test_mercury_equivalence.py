#!/usr/bin/env python3
"""Compare pure reconstructed decisions with the original ARM64 instructions.

The Android Touch, usleep, printf and availability calls are intercepted; no
Android executable entry point, device access, or real touch is performed.
"""
import ctypes as c
import hashlib
import io
import math
import os
import struct
import subprocess
import unittest
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_LITTLE_ENDIAN
from elftools.elf.elffile import ELFFile
from unicorn import Uc, UC_ARCH_ARM64, UC_MODE_ARM, UC_HOOK_CODE
from unicorn.arm64_const import UC_ARM64_REG_X0, UC_ARM64_REG_X1, UC_ARM64_REG_X2, UC_ARM64_REG_SP, UC_ARM64_REG_LR, UC_ARM64_REG_PC

ROOT = Path(__file__).resolve().parents[1]
INPUT = Path(os.environ.get('LVLOLM_ANDROID_BINARY', '/root/lvlolm1.3.sh'))


class Actor(c.Structure):
    _fields_ = [('id', c.c_int32), ('is_local', c.c_int), ('health', c.c_float),
                ('control', c.c_int32), ('available', c.c_int), ('item', c.c_int32), ('cooldown', c.c_float)]


class Input(c.Structure):
    _fields_ = [('enabled', c.c_int), ('touch_available', c.c_int), ('width', c.c_float),
                ('height', c.c_float), ('x', c.c_float), ('y', c.c_float), ('now', c.c_int64)]


class State(c.Structure):
    _fields_ = [('deadline', c.c_int64), ('pending', c.c_int)]


class Decision(c.Structure):
    _fields_ = [('x', c.c_int64), ('y', c.c_int64), ('duration', c.c_uint32), ('index', c.c_size_t)]


def original(data, actor, inputs, state):
    elf = ELFFile(io.BytesIO(data))
    uc = Uc(UC_ARCH_ARM64, UC_MODE_ARM)
    uc.mem_map(0, 0x600000)
    for seg in elf.iter_segments():
        if seg['p_type'] == 'PT_LOAD': uc.mem_write(seg['p_vaddr'], seg.data())
    obj, stack, table, item, halt = 0x20000000, 0x10000000, 0x40000000, 0x40001000, 0x50000000
    for addr, n in [(obj, 0x4000), (stack, 0x20000), (table, 0x20000), (halt, 0x1000)]: uc.mem_map(addr, n)

    def write(base, off, fmt, value): uc.mem_write(base + off, struct.pack('<' + fmt, value))
    write(obj, 0x68a, 'B', bool(inputs.enabled))
    write(obj, 0x138, 'Q', table)
    write(obj, 0x140, 'Q', table + 8)
    write(obj, 0x150, 'Q', 0)
    write(obj, 0x158, 'Q', 1)
    write(table, 0, 'Q', item)
    for off, value in [(0x6a0, inputs.width), (0x6a4, inputs.height), (0x6a8, inputs.x), (0x6ac, inputs.y)]: write(obj, off, 'f', value)
    write(obj, 0x2d48, 'q', state.deadline)
    write(obj, 0x2d50, 'B', bool(state.pending))
    for off, fmt, value in [(8, 'i', actor.id), (0x20, 'B', bool(actor.is_local)), (0x28, 'f', actor.health),
                            (0x24, 'i', actor.control), (0x180, 'B', bool(actor.available)),
                            (0x170, 'i', actor.item), (0x178, 'f', actor.cooldown)]: write(item, off, fmt, value)
    uc.reg_write(UC_ARM64_REG_X0, obj)
    uc.reg_write(UC_ARM64_REG_X1, inputs.now)
    uc.reg_write(UC_ARM64_REG_SP, stack + 0x10000)
    uc.reg_write(UC_ARM64_REG_LR, halt)
    md = Cs(CS_ARCH_ARM64, CS_MODE_LITTLE_ENDIAN)
    down, up, sleep = [], [], []

    def hook(u, pc, size, _):
        ins = next(md.disasm(bytes(u.mem_read(pc, size)), pc))
        if ins.mnemonic == 'bl' or (ins.mnemonic == 'b' and ins.op_str == '#0x5540e0'):
            target = int(ins.op_str.lstrip('#'), 0)
            if target == 0x3a2d10: u.reg_write(UC_ARM64_REG_X0, inputs.touch_available)
            elif target == 0x3a2ed0: down.append((u.reg_read(UC_ARM64_REG_X0), u.reg_read(UC_ARM64_REG_X1), u.reg_read(UC_ARM64_REG_X2)))
            elif target == 0x3a2edc: up.append(u.reg_read(UC_ARM64_REG_X0))
            elif target == 0x5544d0: sleep.append(u.reg_read(UC_ARM64_REG_X0))
            elif target not in (0x554500, 0x5540e0): raise RuntimeError(f'Unexpected original call: {target:#x}')
            u.reg_write(UC_ARM64_REG_PC, halt if ins.mnemonic == 'b' else pc + 4)
        elif ins.mnemonic in ('svc', 'hvc', 'smc', 'blr', 'br'): raise RuntimeError('Unexpected external operation')

    uc.hook_add(UC_HOOK_CODE, hook)
    uc.emu_start(0x41a25c, halt, count=2048)
    if uc.reg_read(UC_ARM64_REG_PC) != halt: raise RuntimeError('Original function did not return')
    deadline = struct.unpack('<q', bytes(uc.mem_read(obj + 0x2d48, 8)))[0]
    pending = bytes(uc.mem_read(obj + 0x2d50, 1))[0]
    if down: assert up == [8] and sleep == [5000]
    return down, deadline, pending


class Equivalence(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.data = INPUT.read_bytes()
        assert hashlib.sha256(cls.data).hexdigest() == 'e385f312ecbb5e575d2709a15a3b0157aa6fb37b52299075d9665f14df6fd111'
        (ROOT / 'build').mkdir(exist_ok=True)
        lib = ROOT / 'build/liblvactions.so'
        subprocess.run(['gcc', '-std=c11', '-Wall', '-Wextra', '-Werror', '-shared', '-fPIC',
                        '-I' + str(ROOT / 'core'), str(ROOT / 'core/LVActions.c'), '-lm', '-o', str(lib)], check=True)
        cls.lib = c.CDLL(str(lib))
        cls.lib.lv_mercury_decide.argtypes = [c.POINTER(Input), c.POINTER(Actor), c.c_size_t, c.POINTER(State), c.POINTER(Decision)]
        cls.lib.lv_mercury_decide.restype = c.c_int

    def test_original_decisions(self):
        cases = [{}, {'enabled': 0}, {'touch_available': 0}, {'id': -1}, {'is_local': 0}, {'health': 0},
                 {'health': math.nan}, {'control': 0}, {'control': 3}, {'available': 0}, {'item': 2298},
                 {'cooldown': 1}, {'cooldown': -1}, {'cooldown': math.nan},
                 {'x': 120.5, 'y': 72.5}, {'x': 9000, 'y': 8000}, {'x': -2, 'y': -3},
                 {'x': math.inf, 'y': math.nan}, {'x': 1e-40, 'y': 1e-40},
                 {'pending': 1, 'deadline': 1000000001}, {'pending': 1, 'deadline': 999999999},
                 {'pending': 1, 'cooldown': 1, 'deadline': 1000000001},
                 {'pending': 0, 'deadline': 1000000001}, {'width': 0}, {'height': 0}]
        for case in cases:
            with self.subTest(case=case):
                v = dict(id=1, is_local=1, health=100, control=1, available=1, item=2297, cooldown=0,
                         enabled=1, touch_available=1, width=2532, height=1170, x=0, y=0,
                         now=1000000000, deadline=0, pending=0)
                v.update(case)
                actor = Actor(*(v[k] for k in ['id', 'is_local', 'health', 'control', 'available', 'item', 'cooldown']))
                inputs = Input(*(v[k] for k in ['enabled', 'touch_available', 'width', 'height', 'x', 'y', 'now']))
                state = State(v['deadline'], v['pending'])
                expected, deadline, pending = original(self.data, actor, inputs, state)
                out = Decision()
                got = self.lib.lv_mercury_decide(c.byref(inputs), c.byref(actor), 1, c.byref(state), c.byref(out))
                self.assertEqual(bool(got), bool(expected))
                self.assertEqual((state.deadline, state.pending), (deadline, pending))
                if got:
                    self.assertEqual((8, out.x, out.y), expected[0])
                    self.assertEqual(out.duration, 5000)


if __name__ == '__main__': unittest.main()
