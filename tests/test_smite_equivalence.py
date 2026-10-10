#!/usr/bin/env python3
"""Bounded original-instruction comparison with synthetic reader results.

Runs the outer Android decision and category helper. Reader calls, clocks,
damage discovery, cache updates, sleep and touch are intercepted, never live.
The damage formula is also compared with its original instruction tail.
"""
import ctypes as c
import hashlib
import io
import math
import os
import random
import struct
import subprocess
import unittest
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_LITTLE_ENDIAN
from elftools.elf.elffile import ELFFile
from unicorn import Uc, UC_ARCH_ARM64, UC_MODE_ARM, UC_HOOK_CODE
from unicorn.arm64_const import UC_ARM64_REG_X0, UC_ARM64_REG_X1, UC_ARM64_REG_X2, UC_ARM64_REG_X3, UC_ARM64_REG_X21, UC_ARM64_REG_SP, UC_ARM64_REG_LR, UC_ARM64_REG_PC

ROOT = Path(__file__).resolve().parents[1]
INPUT = Path(os.environ.get('LVLOLM_ANDROID_BINARY', '/root/lvlolm1.3.sh'))
OBJ, STACK, ACTOR_TABLE, ACTORS = 0x20000000, 0x10000000, 0x40000000, 0x40001000
TARGET_TABLE, TARGETS, READER, HALT = 0x40009000, 0x4000a000, 0x30000000, 0x50000000


class Actor(c.Structure):
    _fields_ = [('id', c.c_int32), ('is_local', c.c_int), ('health', c.c_float),
                ('x', c.c_float), ('y', c.c_float), ('camp', c.c_int32),
                ('available', c.c_int), ('skill_id', c.c_int32)]


class Target(c.Structure):
    _fields_ = [('id', c.c_int32), ('type_id', c.c_int32), ('valid', c.c_int),
                ('x', c.c_float), ('y', c.c_float), ('read_ok', c.c_int), ('health_fixed', c.c_int64)]


class Input(c.Structure):
    _fields_ = [('enabled', c.c_int), ('touch_available', c.c_int), ('require_enemy', c.c_int),
                ('red', c.c_int), ('blue', c.c_int), ('dragon', c.c_int), ('range', c.c_int32),
                ('fallback', c.c_int32), ('width', c.c_float), ('height', c.c_float),
                ('x', c.c_float), ('y', c.c_float), ('now', c.c_int64), ('skill_read_ok', c.c_int),
                ('skill_id', c.c_int32), ('cooldown', c.c_float), ('rank', c.c_int)]


class State(c.Structure):
    _fields_ = [('deadline', c.c_int64), ('refresh', c.c_int64), ('damage', c.c_int32)]


class Touch(c.Structure):
    _fields_ = [('x', c.c_int64), ('y', c.c_int64), ('duration', c.c_uint32), ('index', c.c_size_t)]


class Decision(c.Structure):
    _fields_ = [('touch', Touch), ('type_id', c.c_int32), ('threshold', c.c_int32), ('health', c.c_int64)]


def machine(data):
    uc = Uc(UC_ARCH_ARM64, UC_MODE_ARM)
    uc.mem_map(0, 0x600000)
    for seg in ELFFile(io.BytesIO(data)).iter_segments():
        if seg['p_type'] == 'PT_LOAD': uc.mem_write(seg['p_vaddr'], seg.data())
    for addr, size in [(OBJ, 0x4000), (STACK, 0x20000), (ACTOR_TABLE, 0x20000),
                       (READER, 0x1000), (HALT, 0x1000)]: uc.mem_map(addr, size)
    uc.reg_write(UC_ARM64_REG_SP, STACK + 0x10000)
    uc.reg_write(UC_ARM64_REG_LR, HALT)
    return uc


def write(uc, base, off, fmt, value):
    uc.mem_write(base + off, struct.pack('<' + fmt, value))


def original(data, actors, targets, inputs, state, cooldown_fixed):
    uc = machine(data)
    for off, value in [(0x688, inputs.enabled), (0x689, inputs.require_enemy),
                       (0x694, inputs.red), (0x695, inputs.blue), (0x696, inputs.dragon)]:
        write(uc, OBJ, off, 'B', bool(value))
    for off, value in [(0x690, inputs.range), (0x68c, inputs.fallback), (0x2d40, state.damage)]:
        write(uc, OBJ, off, 'i', value)
    for off, value in [(0x2d30, state.deadline), (0x2d38, state.refresh)]: write(uc, OBJ, off, 'q', value)
    for off, value in [(0x6a0, inputs.width), (0x6a4, inputs.height), (0x698, inputs.x), (0x69c, inputs.y)]:
        write(uc, OBJ, off, 'f', value)
    for off, value in [(0x138, ACTOR_TABLE), (0x140, ACTOR_TABLE + (8 if actors else 0)),
                       (0x150, 0), (0x158, len(actors)), (0x758, TARGET_TABLE),
                       (0x760, TARGET_TABLE + (8 if targets else 0)), (0x770, 0), (0x778, len(targets)),
                       (0x30, READER)]: write(uc, OBJ, off, 'Q', value)
    write(uc, ACTOR_TABLE, 0, 'Q', ACTORS)
    write(uc, TARGET_TABLE, 0, 'Q', TARGETS)
    write(uc, READER, 0, 'Q', READER + 0x100)
    write(uc, READER, 0x110, 'Q', HALT + 0x100)
    for i, a in enumerate(actors):
        address = ACTORS + i * 0x1b0
        for off, fmt, value in [(8, 'i', a.id), (0x20, 'B', bool(a.is_local)), (0x28, 'f', a.health),
                                (0xc, 'f', a.x), (0x10, 'f', a.y), (0x1c, 'i', a.camp),
                                (0x1a0, 'B', bool(a.available)), (0x190, 'i', a.skill_id),
                                (0x188, 'Q', 0x70000000 + i * 0x1000)]:
            write(uc, address, off, fmt, value)
    for i, t in enumerate(targets):
        address = TARGETS + i * 0x60
        for off, fmt, value in [(8, 'i', t.id), (0x18, 'i', t.type_id), (0x3d, 'B', bool(t.valid)),
                                (0xc, 'f', t.x), (0x10, 'f', t.y), (0x50, 'Q', 0x71000000 + i * 0x1000)]:
            write(uc, address, off, fmt, value)
    uc.reg_write(UC_ARM64_REG_X0, OBJ)
    md = Cs(CS_ARCH_ARM64, CS_MODE_LITTLE_ENDIAN)
    down, up, pauses, clicked = [], [], [], []

    def hook(u, pc, size, _):
        ins = next(md.disasm(bytes(u.mem_read(pc, size)), pc))
        if ins.mnemonic == 'blr':
            address, out, size = (u.reg_read(r) for r in (UC_ARM64_REG_X1, UC_ARM64_REG_X2, UC_ARM64_REG_X3))
            if pc == 0x419880:
                assert size == 20 and address >= 0x70000010
                u.mem_write(out, struct.pack('<5i', 0, inputs.skill_id, cooldown_fixed, 0, 0))
                u.reg_write(UC_ARM64_REG_X0, inputs.skill_read_ok)
            elif pc == 0x419a24:
                assert size == 8 and address >= 0x71000150
                i = (address - 0x71000150) // 0x1000
                u.mem_write(out, struct.pack('<q', targets[i].health_fixed))
                u.reg_write(UC_ARM64_REG_X0, targets[i].read_ok)
            else: raise RuntimeError(f'Unexpected reader call {pc:#x}')
            u.reg_write(UC_ARM64_REG_PC, pc + 4)
        elif ins.mnemonic == 'bl':
            target = int(ins.op_str.lstrip('#'), 0)
            # Execute the original category helper directly.
            if target == 0x439998: return
            if target == 0x3a2d10: u.reg_write(UC_ARM64_REG_X0, inputs.touch_available)
            elif target == 0x50aaf8: u.reg_write(UC_ARM64_REG_X0, inputs.now)
            elif target == 0x4396c0: u.reg_write(UC_ARM64_REG_X0, 600 + (inputs.rank - 1) * 400 if 1 <= inputs.rank <= 3 else 0)
            elif target == 0x5549b0:
                # Register constants S0/S1 are discovered by name for clarity.
                from unicorn.arm64_const import UC_ARM64_REG_S0, UC_ARM64_REG_S1
                x, y = (struct.unpack('<f', struct.pack('<I', u.reg_read(r)))[0]
                        for r in (UC_ARM64_REG_S0, UC_ARM64_REG_S1))
                result = struct.unpack('<I', struct.pack('<f', math.hypot(x, y)))[0]
                u.reg_write(UC_ARM64_REG_S0, result)
            elif target == 0x3a2ed0:
                down.append(tuple(u.reg_read(r) for r in (UC_ARM64_REG_X0, UC_ARM64_REG_X1, UC_ARM64_REG_X2)))
                address = u.reg_read(UC_ARM64_REG_X21)
                health = struct.unpack('<q', bytes(u.mem_read(address + 0x20, 8)))[0]
                clicked.append(((address - TARGETS) // 0x60, health))
            elif target == 0x3a2edc: up.append(u.reg_read(UC_ARM64_REG_X0))
            elif target == 0x5544d0: pauses.append(u.reg_read(UC_ARM64_REG_X0))
            elif target not in (0x436454, 0x554500, 0x5540e0): raise RuntimeError(f'Unexpected call {target:#x}')
            u.reg_write(UC_ARM64_REG_PC, pc + 4)
        elif ins.mnemonic in ('svc', 'hvc', 'smc', 'br'): raise RuntimeError('Unexpected external operation')

    uc.hook_add(UC_HOOK_CODE, hook)
    uc.emu_start(0x419710, HALT, count=4096)
    if uc.reg_read(UC_ARM64_REG_PC) != HALT: raise RuntimeError('Original function did not return')
    updated = (struct.unpack('<q', bytes(uc.mem_read(OBJ + 0x2d30, 8)))[0],
               struct.unpack('<q', bytes(uc.mem_read(OBJ + 0x2d38, 8)))[0],
               struct.unpack('<i', bytes(uc.mem_read(OBJ + 0x2d40, 4)))[0])
    if down:
        assert up == [8] and pauses == [5000]
    return down, updated, clicked[0] if clicked else None


class Equivalence(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.data = INPUT.read_bytes()
        assert hashlib.sha256(cls.data).hexdigest() == 'e385f312ecbb5e575d2709a15a3b0157aa6fb37b52299075d9665f14df6fd111'
        (ROOT / 'build').mkdir(exist_ok=True)
        lib = ROOT / 'build/liblvsmite.so'
        subprocess.run(['gcc', '-std=c11', '-Wall', '-Wextra', '-Werror', '-shared', '-fPIC',
                        '-I' + str(ROOT / 'core'), str(ROOT / 'core/LVActions.c'), '-lm', '-o', str(lib)], check=True)
        cls.lib = c.CDLL(str(lib))
        cls.lib.lv_smite_decide.argtypes = [c.POINTER(Input), c.POINTER(Actor), c.c_size_t,
            c.POINTER(Target), c.c_size_t, c.POINTER(State), c.POINTER(Decision)]
        cls.lib.lv_smite_decide.restype = c.c_int
        cls.lib.lv_smite_type_enabled.argtypes = [c.c_int32, c.c_int, c.c_int, c.c_int]

    def test_outer_decisions(self):
        cases = [{}, {'enabled': 0}, {'touch_available': 0}, {'deadline': 1000000001},
                 {'local_id': -1}, {'local_flag': 0}, {'local_health': 0}, {'local_health': math.nan},
                 {'old_available': 0}, {'old_skill': 0}, {'require_enemy': 1},
                 {'require_enemy': 1, 'enemy': True}, {'require_enemy': 1, 'enemy': True, 'enemy_camp': 1},
                 {'require_enemy': 1, 'enemy': True, 'enemy_x': 90000},
                 {'require_enemy': 1, 'enemy': True, 'enemy_health': 0},
                 {'require_enemy': 1, 'enemy': True, 'enemy_health': math.nan},
                 {'require_enemy': 1, 'enemy': True, 'camp': 0},
                 {'skill_read_ok': 0}, {'skill_id': 0}, {'cooldown_fixed': 819}, {'cooldown_fixed': 820},
                 {'cooldown_fixed': -16384}, {'rank': 1}, {'rank': 2}, {'rank': 3}, {'rank': 4},
                 {'rank': 1, 'health_fixed': 601 * 16384},
                 {'refresh': 1000000001, 'damage': 1200, 'health_fixed': 1100 * 16384},
                 {'refresh': 1000000001, 'damage': 0}, {'target_valid': 0}, {'target_id': -1},
                 {'type_id': 201401, 'red': 0}, {'type_id': 201402, 'blue': 0},
                 {'type_id': 830701, 'dragon': 0}, {'type_id': 12345},
                 {'target_x': 90000}, {'target_x': math.nan}, {'target_x': math.inf},
                 {'read_ok': 0}, {'health_fixed': 1001 * 16384}, {'health_fixed': 16383},
                 {'health_fixed': -16384}, {'health_fixed': 16384},
                 {'x': 120.5, 'y': 72.5}, {'x': 9999, 'y': 9999}, {'x': -1, 'y': -2},
                 {'x': math.nan, 'y': math.inf}, {'x': 1e-40, 'y': 1e-40},
                 {'width': 0}, {'height': 0}, {'second_target': True, 'health_fixed': 1100 * 16384},
                 {'second_local': True, 'old_skill': 0}, {'no_actors': True}, {'no_targets': True}]
        for case in cases:
            with self.subTest(case=case):
                v = dict(enabled=1, touch_available=1, require_enemy=0, red=1, blue=1, dragon=1,
                         range=83000, fallback=1000, width=2532, height=1170, x=0, y=0, now=1000000000,
                         skill_read_ok=1, skill_id=81110101, cooldown_fixed=0, rank=0,
                         deadline=0, refresh=0, damage=0, local_id=1, local_flag=1, local_health=100,
                         camp=1, old_available=1, old_skill=81110101, enemy=False, enemy_camp=2,
                         enemy_x=100, enemy_health=100, type_id=201401, target_id=7, target_valid=1,
                         target_x=200, read_ok=1, health_fixed=900 * 16384, second_target=False,
                         second_local=False, no_actors=False, no_targets=False)
                v.update(case)
                inputs = Input(*(v[k] for k in ['enabled', 'touch_available', 'require_enemy', 'red', 'blue',
                    'dragon', 'range', 'fallback', 'width', 'height', 'x', 'y', 'now', 'skill_read_ok', 'skill_id']),
                    v['cooldown_fixed'] / 16384, v['rank'])
                actors = [Actor(v['local_id'], v['local_flag'], v['local_health'], 100, 100, v['camp'], v['old_available'], v['old_skill'])]
                if v['enemy']: actors.append(Actor(2, 0, v['enemy_health'], v['enemy_x'], 100, v['enemy_camp'], 0, 0))
                if v['second_local']: actors.append(Actor(3, 1, 100, 100, 100, 1, 1, 81110101))
                if v['no_actors']: actors = []
                targets = [Target(v['target_id'], v['type_id'], v['target_valid'], v['target_x'], 100, v['read_ok'], v['health_fixed'])]
                if v['second_target']: targets.append(Target(8, 201402, 1, 200, 100, 1, 500 * 16384))
                if v['no_targets']: targets = []
                state = State(v['deadline'], v['refresh'], v['damage'])
                down, expected_state, clicked = original(self.data, actors, targets, inputs, state, v['cooldown_fixed'])
                out = Decision()
                got = self.lib.lv_smite_decide(c.byref(inputs), (Actor * len(actors))(*actors), len(actors),
                    (Target * len(targets))(*targets), len(targets), c.byref(state), c.byref(out))
                self.assertEqual(bool(got), bool(down))
                self.assertEqual((state.deadline, state.refresh, state.damage), expected_state)
                if got:
                    self.assertEqual((8, out.touch.x, out.touch.y), down[0])
                    self.assertEqual((out.touch.index, out.health), clicked)
                    self.assertEqual(out.type_id, targets[out.touch.index].type_id)
                    self.assertEqual(out.threshold, state.damage if state.damage > 0 else v['fallback'])
                    self.assertEqual(out.touch.duration, 5000)

    def test_category_helper(self):
        uc = machine(self.data)
        write(uc, OBJ, 0x100, 'Q', OBJ)
        known = [201104, 201105, 201201, 201202, 201401, 201402, 202902, 203001,
                 260101, 830001, 830002, 830101, 830102, 830701, 830702, 830704, 830705, 830721]
        ids = set(known + [v + d for v in known for d in (-1, 1)] + [-1, 0, 2147483647])
        rng = random.Random(1730)
        ids.update(rng.randint(100000, 1000000) for _ in range(20))
        for flags in range(8):
            red, blue, dragon = [(flags >> bit) & 1 for bit in range(3)]
            for off, value in [(0x694, red), (0x695, blue), (0x696, dragon)]: write(uc, OBJ, off, 'B', value)
            for type_id in sorted(ids):
                uc.reg_write(UC_ARM64_REG_X0, OBJ + 0x100)
                uc.reg_write(UC_ARM64_REG_X1, type_id & 0xffffffff)
                uc.reg_write(UC_ARM64_REG_LR, HALT)
                uc.emu_start(0x439998, HALT, count=128)
                self.assertEqual(uc.reg_read(UC_ARM64_REG_PC), HALT)
                self.assertEqual(self.lib.lv_smite_type_enabled(type_id, red, blue, dragon), uc.reg_read(UC_ARM64_REG_X0))

    def test_rank_formula_instructions(self):
        uc = machine(self.data)
        for rank in (-1, 0, 1, 2, 3, 4, 2147483647):
            write(uc, STACK + 0x10000, 0, 'i', rank)
            uc.reg_write(UC_ARM64_REG_X0, 0)
            uc.emu_start(0x439974, 0x439880, count=32)
            self.assertEqual(uc.reg_read(UC_ARM64_REG_PC), 0x439880)
            self.assertEqual(self.lib.lv_smite_damage_from_rank(rank), uc.reg_read(UC_ARM64_REG_X0))


if __name__ == '__main__': unittest.main()
