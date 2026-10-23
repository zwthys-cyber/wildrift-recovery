#!/usr/bin/env python3
"""Bounded original FEProj getters in synthetic RAM; no game or device calls.

Only explicitly listed instruction ranges are executable. Assert handlers,
hotfix callbacks, unknown calls and syscalls are rejected. Private bytes stay
in ignored inputs and are never included in source/release artifacts.
"""
import hashlib
import os
import struct
import unittest
from pathlib import Path
from unicorn import Uc, UC_ARCH_ARM64, UC_MODE_ARM, UC_HOOK_CODE
from unicorn.arm64_const import UC_ARM64_REG_X0, UC_ARM64_REG_X1, UC_ARM64_REG_X2, UC_ARM64_REG_X8, UC_ARM64_REG_X9, UC_ARM64_REG_X19, UC_ARM64_REG_X20, UC_ARM64_REG_SP, UC_ARM64_REG_LR

ROOT=Path(__file__).resolve().parents[1]
ENGINE=Path(os.environ.get('LVLOLM_IOS_ENGINE',str(ROOT/'inputs/ios-engine-0.7.5/Bundle/Frameworks/FEProj.framework/FEProj')))
ENGINE_SHA='e24ae2f5c2cc2a4910ff9c4e04177ca9f8a8fea0eb70ed790ed79cfbe0146eeb'
HEAP,STACK,HALT=0x350000000,0x60000000,0x70000000

def q(u,a,v): u.mem_write(a,struct.pack('<Q',v&((1<<64)-1)))

def machine(data,ranges):
    u=Uc(UC_ARCH_ARM64,UC_MODE_ARM)
    pages=set()
    for a,b in ranges:
        for p in range(a&~4095,(b+4095)&~4095,4096):
            if p not in pages: u.mem_map(p,4096); pages.add(p)
        u.mem_write(a,data[a:b])
    for a,n in ((HEAP,0x10000),(STACK,0x10000),(HALT,4096),(0x523c000,4096),(0x51ab000,4096)):
        u.mem_map(a,n)
    u.reg_write(UC_ARM64_REG_SP,STACK+0x8000); u.reg_write(UC_ARM64_REG_LR,HALT)
    def guard(uc,pc,size,_):
        if not any(a<=pc<b for a,b in ranges): raise AssertionError(f'Getter escaped: {pc:#x}')
        w,=struct.unpack('<I',bytes(uc.mem_read(pc,size)))
        if w&0xfc000000==0x94000000:
            imm=w&0x3ffffff
            if imm&0x2000000: imm-=0x4000000
            target=pc+imm*4
            if not any(a<=target<b for a,b in ranges): raise AssertionError(f'Unknown call: {pc:#x} -> {target:#x}')
        if w&0xfffffc1f==0xd63f0000: raise AssertionError('Indirect call rejected')
        if w&0xffe0001f==0xd4000001: raise AssertionError('Syscall rejected')
    u.hook_add(UC_HOOK_CODE,guard)
    return u

@unittest.skipUnless(ENGINE.exists(),'Private native engine not present')
class OriginalEngineGetters(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.data=ENGINE.read_bytes()
        if hashlib.sha256(cls.data).hexdigest()!=ENGINE_SHA: raise ValueError('Wrong native engine profile')

    def test_original_sync_cooldown_accessor_uses_same_cached_field(self):
        # Named SkillCDNode.GetRemainCDSync forwards to _FE_TN51.
        # A zero return is not evidence of a current/castable game skill.
        ranges=((0x62c0,0x6344),(0xd03e60,0xd03e84),(0x1015164,0x1015174))
        for mode in (0,1):
            for value in (0,1,16384,9*16384,-16384):
                u=machine(self.data,ranges)
                q(u,0x523cf28,HEAP+0x1000);q(u,HEAP+0x1018,HEAP+0x2000)
                u.mem_write(HEAP+0x201e,bytes([mode]))
                q(u,HEAP+(0x20 if mode else 0x18),value)
                u.reg_write(UC_ARM64_REG_X0,HEAP);u.reg_write(UC_ARM64_REG_X1,HEAP+0xf000)
                u.emu_start(0x62c0,HALT,count=100)
                self.assertEqual(struct.unpack('<q',bytes(u.mem_read(HEAP+0xf000,8)))[0],value)

    def test_original_ultimate_selects_last_positive_configured_id(self):
        # Execute the actual reverse selection loop; stop BEFORE the native
        # GetSkill call. No allocator, hotfix or game methods are executed.
        for ids in ((101,102,103,104),(101,0,103,0),(101,-1,0),(-1,0),(),(0,104),
                    tuple(range(1,33))):
            u=machine(self.data,((0xffa3ac,0xffa3f0),))
            if ids:u.mem_write(HEAP,struct.pack('<'+'i'*len(ids),*ids))
            u.reg_write(UC_ARM64_REG_X20,HEAP)
            u.reg_write(UC_ARM64_REG_X9,HEAP+len(ids)*4)
            u.reg_write(UC_ARM64_REG_X19,HEAP+0x1000)
            positives=[v for v in ids if v>0]
            stop=0xffa3ec if positives else 0xffa400
            u.emu_start(0xffa3ac,stop,count=500)
            if positives:
                self.assertEqual(u.reg_read(UC_ARM64_REG_X1),positives[-1])
                self.assertEqual(u.reg_read(UC_ARM64_REG_X0),HEAP+0x1000)
                self.assertEqual(u.reg_read(UC_ARM64_REG_X2),0)

    def test_original_logger_accessor_is_not_the_runtime_battle(self):
        # The 0.7.8 test correctly executed this helper, but incorrectly
        # named its result Battle. It actually returns a distinct logger.
        for delta in (0,0x100,0x800):
            u=machine(self.data,((0xd03bc0,0xd03c44),(0x3ca82f8,0x3ca8310)))
            u.reg_write(UC_ARM64_REG_X0,HEAP+0x2000+delta)
            u.emu_start(0x3ca82f8,0x3ca8310,count=10)
            self.assertEqual(struct.unpack('<Q',bytes(u.mem_read(HEAP+0x2000+delta,8)))[0],0x501c898)
            q(u,0x523cf28,HEAP);q(u,HEAP+0x38,HEAP+0x1000)
            q(u,HEAP+0x1028,HEAP+0x2000+delta)
            q(u,HEAP+0x1010,HEAP+0x5000)
            q(u,HEAP+0x10,HEAP+0x3000);q(u,HEAP+0x3018,HEAP+0x4000)
            u.emu_start(0xd03bc0,HALT,count=100)
            self.assertEqual(u.reg_read(UC_ARM64_REG_X0),HEAP+0x2000+delta)
            self.assertNotEqual(u.reg_read(UC_ARM64_REG_X0),HEAP+0x5000)

    def test_original_frame_runtime_dispatch_and_positions(self):
        # Execute the original FrameRoot-to-global store, original Battle
        # manager address calculation, original ActorMgr vptr store, and
        # the ACTUAL game lookup caller. Its method is loaded from the
        # original static vtable, never seeded with a guessed function.
        # Stop before BLR, then execute the separately whitelisted pure
        # lookup/getters/decoder over six independently identified actors.
        ranges=((0xcceaac,0xcceabc),(0x4b9acc,0x4b9ad4),
                (0x748618,0x74862c),(0x4b22650,0x4b22710),
                (0x434748,0x434768),(0x32f2318,0x32f232c),
                (0x1011910,0x1011a18),(0x3326590,0x3326598),
                (0x33269c8,0x33269d0),(0x3959e5c,0x3959e64),
                (0x395c260,0x395c268),(0x1030de8,0x1030e10))
        for delta in (0,0x80,0x100):
            u=machine(self.data,ranges);frame=HEAP+0x1000;battle=HEAP+0x2000+delta
            q(u,frame+0x10,battle);q(u,frame+0x28,HEAP+0x3000)
            u.reg_write(UC_ARM64_REG_X19,frame)
            u.emu_start(0xcceaac,0xcceabc,count=10)
            self.assertEqual(struct.unpack('<Q',bytes(u.mem_read(0x523cf30,8)))[0],battle)
            u.reg_write(UC_ARM64_REG_X19,battle)
            u.emu_start(0x4b9acc,0x4b9ad0,count=10)
            manager=u.reg_read(UC_ARM64_REG_X0)
            u.reg_write(UC_ARM64_REG_X19,manager)
            u.emu_start(0x748618,0x74862c,count=10)
            header=HEAP+0x5000;q(u,manager+0x20,header);q(u,header,HEAP+0x4400)
            key=0xd501a084d9240301;q(u,0x523cf38,key)
            for actor_id,left,right in ((4,2,5),(2,1,3),(5,0,6),(1,0,0),(3,0,0),(6,0,0)):
                node=HEAP+0x4000+actor_id*0x100;actor=HEAP+0x6000+actor_id*0x400
                transform=HEAP+0xa000+actor_id*0x80
                q(u,node+8,HEAP+0x4000+left*0x100 if left else 0)
                q(u,node+0x10,HEAP+0x4000+right*0x100 if right else 0)
                u.mem_write(node+0x20,struct.pack('<I',actor_id));q(u,node+0x28,actor)
                for member,value in ((0x14,actor_id),(0xc4,10000+actor_id),(0x198,1 if actor_id==1 else 2)):
                    u.mem_write(actor+member,struct.pack('<I',value))
                q(u,actor+0x20,transform)
                position=((actor_id-3)*16384+delta,0,(actor_id-1)*16384-delta)
                u.mem_write(transform+0x28,b''.join(struct.pack('<Q',(p&((1<<64)-1))^key) for p in position))
            for actor_id in range(1,7):
                u.reg_write(UC_ARM64_REG_X19,actor_id)
                u.emu_start(0x434748,0x434764,count=20)
                self.assertEqual(u.reg_read(UC_ARM64_REG_X0),manager)
                self.assertEqual(u.reg_read(UC_ARM64_REG_X1),actor_id)
                # The original table is the independent virtual target oracle.
                lookup=u.reg_read(UC_ARM64_REG_X9);self.assertEqual(lookup,0x32f2318)
                u.emu_start(lookup,HALT,count=300)
                actor=u.reg_read(UC_ARM64_REG_X0)
                self.assertEqual(actor,HEAP+0x6000+actor_id*0x400)
                for start,expected in ((0x3326590,actor_id),(0x3959e5c,10000+actor_id),
                                       (0x395c260,1 if actor_id==1 else 2),
                                       (0x33269c8,HEAP+0xa000+actor_id*0x80)):
                    u.reg_write(UC_ARM64_REG_X0,actor);u.emu_start(start,HALT,count=10)
                    self.assertEqual(u.reg_read(UC_ARM64_REG_X0),expected)
                u.reg_write(UC_ARM64_REG_X8,u.reg_read(UC_ARM64_REG_X0))
                u.reg_write(UC_ARM64_REG_X19,HEAP+0xf000)
                u.emu_start(0x1030de8,0x1030e10,count=20)
                self.assertEqual(struct.unpack('<3q',bytes(u.mem_read(HEAP+0xf000,24))),
                                 ((actor_id-3)*16384+delta,0,(actor_id-1)*16384-delta))

    def test_original_runtime_actor_manager_constructor_and_vtable(self):
        # Recover the embedded manager from the ACTUAL battle constructor,
        # then the ACTUAL ActorMgr vptr store and original static vtable.
        # The 0.7.7 test seeded the expected virtual method in fake RAM and
        # never proved that the selected manager really dispatches it.
        for offset in (0,0x1000):
            u=machine(self.data,((0x4b9acc,0x4b9ad4),(0x748618,0x74862c)))
            battle=HEAP+offset;u.reg_write(UC_ARM64_REG_X19,battle)
            u.emu_start(0x4b9acc,0x4b9ad0,count=10)
            manager=u.reg_read(UC_ARM64_REG_X0)
            self.assertEqual(manager,battle+0x1e0)
            call,=struct.unpack_from('<I',self.data,0x4b9ad0)
            self.assertEqual(0x4b9ad0+((call&0x3ffffff)<<2),0x74858c)
            u.reg_write(UC_ARM64_REG_X19,manager)
            u.emu_start(0x748618,0x74862c,count=10)
            vptr,=struct.unpack('<Q',bytes(u.mem_read(manager,8)))
            self.assertEqual(vptr,0x4b22650)
            # These are original DATA_CONST bytes, not a fixture target.
            lookup,=struct.unpack_from('<Q',self.data,vptr+0xb0)
            self.assertEqual(lookup,0x32f2318)
            self.assertNotEqual(struct.unpack_from('<Q',self.data,vptr+0x78)[0],lookup)

    def test_original_resource_manager_is_a_distinct_layout(self):
        # The old +d10/+78 path is a resource lookup keyed by signed IDs
        # with an embedded +a8 tree. It cannot look up live actor objIds
        # using the generic manager's +20 tree pointer.
        u=machine(self.data,((0x376f78,0x37706c),))
        u.reg_write(UC_ARM64_REG_X0,HEAP)
        u.emu_start(0x376f78,HALT,count=200)
        vptr,=struct.unpack('<Q',bytes(u.mem_read(HEAP,8)))
        self.assertEqual(vptr,0x4ac9df8)
        self.assertEqual(struct.unpack_from('<Q',self.data,vptr+0x78)[0],0x37c868)
        self.assertEqual(struct.unpack('<Q',bytes(u.mem_read(HEAP+0x20,8)))[0],HEAP+0x18)

    def test_original_logic_object_tree_lookup(self):
        # Original signed/object layout is checked against an independently
        # built unsigned-key tree: left/right boundaries, absent keys and
        # keys above INT32_MAX. Unknown logging/error calls remain rejected.
        for sought,expected in ((1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(0,0),(7,0),
                                (0xffffffff,0),(0x80000000,0),(0xffffffff,6),(0x80000000,6)):
            u=machine(self.data,((0x32f2318,0x32f232c),(0x1011910,0x1011a18)))
            header=HEAP+0x1000;q(u,HEAP+0x20,header);q(u,header,HEAP+0x2400)
            for node_id,left,right in ((4,2,5),(2,1,3),(5,0,6),(1,0,0),(3,0,0),(6,0,0)):
                a=HEAP+0x2000+node_id*0x100
                q(u,a+8,HEAP+0x2000+left*0x100 if left else 0)
                q(u,a+0x10,HEAP+0x2000+right*0x100 if right else 0)
                node_key=sought if expected==6 and sought>=0x80000000 and node_id==6 else node_id
                u.mem_write(a+0x20,struct.pack('<I',node_key));q(u,a+0x28,HEAP+0x5000+node_id*0x100)
                u.mem_write(HEAP+0x5014+node_id*0x100,struct.pack('<I',node_key))
            u.reg_write(UC_ARM64_REG_X0,HEAP);u.reg_write(UC_ARM64_REG_X1,sought)
            u.emu_start(0x32f2318,HALT,count=300)
            self.assertEqual(u.reg_read(UC_ARM64_REG_X0),HEAP+0x5000+expected*0x100 if expected else 0)

    def test_named_original_logic_actor_identity(self):
        # Lua registrations name FixGameObject.objId/transform and
        # BattleActor.ResID/camp. These are not sync actor field offsets.
        for start,member,size in ((0x3326590,0x14,4),(0x33269c8,0x20,8),
                                  (0x3959e5c,0xc4,4),(0x395c260,0x198,4)):
            for v in (0,16384,0xffffffff if size==4 else HEAP+0x1234):
                u=machine(self.data,((start,start+8),))
                u.mem_write(HEAP+member,struct.pack('<I' if size==4 else '<Q',v))
                u.reg_write(UC_ARM64_REG_X0,HEAP);u.emu_start(start,HALT,count=30)
                self.assertEqual(u.reg_read(UC_ARM64_REG_X0),v)

    def health(self,mode,logic,sync,node=True,count=3,config=True):
        u=machine(self.data,((0xcb3c,0xcbf8),(0xd03e60,0xd03e84),
            (0xfe29ec,0xfe2a4c),(0x1024524,0x102453c)))
        q(u,0x523cf28,HEAP+0x1000); q(u,HEAP+0x1018,HEAP+0x2000 if config else 0)
        u.mem_write(HEAP+0x201e,bytes([mode]))
        q(u,HEAP+0x28,HEAP+0x3000); q(u,HEAP+0x30,HEAP+0x3000+count*8)
        q(u,HEAP+0x3010,HEAP+0x4000 if node else 0)
        q(u,HEAP+0x4060,logic); q(u,HEAP+0x4068,sync)
        u.reg_write(UC_ARM64_REG_X0,HEAP); u.reg_write(UC_ARM64_REG_X1,2); u.reg_write(UC_ARM64_REG_X2,HEAP+0xf000)
        return u

    def test_original_max_health_dispatch_and_vector(self):
        for mode in (0,1,255):
            for value in (-(1<<63),-16384,0,1,16384,1000*16384,(1<<63)-1):
                for count in (3,16):
                    u=self.health(mode,value,value^0x12345,count=count)
                    u.emu_start(0xcb3c,HALT,count=300)
                    result,=struct.unpack('<q',bytes(u.mem_read(HEAP+0xf000,8)))
                    self.assertEqual(result,value^0x12345 if mode else value)

    def test_null_node_original_returns_zero(self):
        for mode in (0,1,255):
            u=self.health(mode,1,2,node=False); u.emu_start(0xcb3c,HALT,count=300)
            self.assertEqual(bytes(u.mem_read(HEAP+0xf000,8)),b'\0'*8)

    def test_invalid_inputs_reject_assert_handlers(self):
        for mode in (0,1):
            for count in (0,1,2):
                u=self.health(mode,1,2,count=count)
                with self.assertRaisesRegex(AssertionError,'Unknown call'): u.emu_start(0xcb3c,HALT,count=300)
        u=self.health(1,1,2,config=False)
        with self.assertRaisesRegex(AssertionError,'Unknown call'): u.emu_start(0xcb3c,HALT,count=300)

    def test_named_native_config_accessors(self):
        # Lua registration 0x35ae384 names these four original getters.
        for start,member in ((0x3768c30,0x1c),(0x3768c40,0x1d),(0x3768c50,0x1e),(0x3768cd0,0x26)):
            for v in (0,1,255):
                u=machine(self.data,((start,start+8),));u.mem_write(HEAP+member,bytes([v]));u.reg_write(UC_ARM64_REG_X0,HEAP)
                u.emu_start(start,HALT,count=100);self.assertEqual(u.reg_read(UC_ARM64_REG_X0),v)

    def test_original_fow_positions_are_distinct_layouts(self):
        # This proves the two getters' layout, not live enemy logical objects.
        for sync in (False,True):
            start,end=(0x1030e4c,0x1030f5c) if sync else (0x1030d24,0x1030e4c)
            for force in ((-163840000,0,0),(16384,0,-32768)):
                for position in ((12345,0,-65432),(8192000,0,8192000)):
                    u=machine(self.data,((start,end),));u.reg_write(UC_ARM64_REG_X0,HEAP);u.reg_write(UC_ARM64_REG_X8,HEAP+0xf000)
                    q(u,HEAP+(0x18 if sync else 0x28),HEAP+0x1000);q(u,HEAP+0x1020,HEAP+0x2000)
                    u.mem_write(HEAP+(0x28 if sync else 0x88),struct.pack('<3q',*force))
                    key=0xd501a084d9240301;q(u,0x523cf38,key)
                    raw=struct.pack('<3q',*position)
                    encrypted=b''.join(struct.pack('<Q',(p&((1<<64)-1))^key) for p in position)
                    u.mem_write(HEAP+0x2000+(0x18 if sync else 0x28),raw if sync else encrypted)
                    u.emu_start(start,HALT,count=200)
                    self.assertEqual(bytes(u.mem_read(HEAP+0xf000,24)),raw if force[0]==-163840000 else struct.pack('<3q',*force))

if __name__=='__main__': unittest.main(verbosity=2)
