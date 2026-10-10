#!/usr/bin/env python3
"""Compare the ordinary map scalar branch against bounded original ARM64.

Only pure loads/multiply/optional clamp instructions execute in synthetic RAM.
No game entry point, native invocation, camera getter, or hotfix call executes.
"""
import ctypes
import hashlib
import itertools
import os
import struct
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from unicorn import Uc, UC_ARCH_ARM64, UC_MODE_ARM, UC_HOOK_CODE
from unicorn.arm64_const import UC_ARM64_REG_X19, UC_ARM64_REG_X20, UC_ARM64_REG_S0, UC_ARM64_REG_S1, UC_ARM64_REG_S2

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'tools'))
from recover_ios_metadata import FRAMEWORK_SHA256
FRAMEWORK=Path(os.environ.get('LVLOLM_IOS_FRAMEWORK',str(ROOT/'inputs/ios-0.2.0/Bundle/Frameworks/UnityFramework.framework/UnityFramework')))

@unittest.skipUnless(FRAMEWORK.exists(),'Private framework not present')
class OrdinaryMapProjection(unittest.TestCase):
    def test_fifty_numeric_cases(self):
        fw=FRAMEWORK.read_bytes()
        self.assertEqual(hashlib.sha256(fw).hexdigest(),FRAMEWORK_SHA256)
        start,end,heap=0x74019c8,0x7401a04,0x350000000
        with tempfile.TemporaryDirectory() as directory:
            library=Path(directory)/'map.so'
            subprocess.run(['gcc','-std=c11','-D_POSIX_C_SOURCE=200809L','-Wall','-Wextra','-Werror','-fPIC','-shared','-I'+str(ROOT/'core'),
                str(ROOT/'core/LVMinimap.c'),str(ROOT/'tests/minimap_projection_fixture.c'),'-lm','-o',str(library)],check=True)
            project=ctypes.CDLL(str(library)).project
            project.argtypes=[ctypes.c_int,ctypes.c_int]+[ctypes.c_float]*4+[ctypes.POINTER(ctypes.c_double)]*2
            project.restype=ctypes.c_int
            for sx,sz,hw,hh in ((2,3,100,150),(1.7,1.2,102,72)):
                for x,z in itertools.product((-50,-20,0,25,50),repeat=2):
                    with self.subTest(x=x,z=z,scale=(sx,sz)):
                        uc=Uc(UC_ARCH_ARM64,UC_MODE_ARM);uc.mem_map(start&~4095,4096);uc.mem_write(start,fw[start:end]);uc.mem_map(heap,4096)
                        uc.mem_write(heap+0x44,struct.pack('<ff',sx,sz));uc.mem_write(heap+0x64,struct.pack('<ff',hw,hh))
                        uc.reg_write(UC_ARM64_REG_X20,heap);uc.reg_write(UC_ARM64_REG_X19,0)
                        for register,value in ((UC_ARM64_REG_S0,x),(UC_ARM64_REG_S2,z)):
                            uc.reg_write(register,struct.unpack('<I',struct.pack('<f',value))[0])
                        def guard(machine,pc,size,_):
                            self.assertTrue(start<=pc<end)
                            word=struct.unpack('<I',bytes(machine.mem_read(pc,size)))[0]
                            self.assertNotEqual(word&0xfc000000,0x94000000)
                            self.assertNotEqual(word&0xfffffc1f,0xd63f0000)
                            self.assertNotEqual(word&0xffe0001f,0xd4000001)
                        uc.hook_add(UC_HOOK_CODE,guard);uc.emu_start(start,end,count=100)
                        native_x=struct.unpack('<f',struct.pack('<I',uc.reg_read(UC_ARM64_REG_S0)))[0]
                        native_z=struct.unpack('<f',struct.pack('<I',uc.reg_read(UC_ARM64_REG_S1)))[0]
                        u,v=ctypes.c_double(),ctypes.c_double()
                        self.assertEqual(project(x,z,sx,sz,hw,hh,ctypes.byref(u),ctypes.byref(v)),1)
                        self.assertAlmostEqual(u.value,.5+native_x/(2*hw),delta=1e-7)
                        self.assertAlmostEqual(v.value,.5-native_z/(2*hh),delta=1e-7)

if __name__=='__main__':unittest.main()
