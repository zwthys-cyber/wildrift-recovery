#!/usr/bin/env python3
"""Check CI-recovered layout against the actual international inputs and reader profile."""
import json
import os
import plistlib
import re
import sys
import unittest
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'tools'))
from recover_ios_metadata import Metadata,NativeTables
from capstone import Cs,CS_ARCH_ARM64,CS_MODE_LITTLE_ENDIAN

class InternationalProfile(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.fw=(ROOT/'inputs/UnityFramework').read_bytes()
        cls.md=Metadata((ROOT/'inputs/global-metadata.dat').read_bytes(),cls.fw)
        cls.native=NativeTables(cls.fw,cls.md)
        cls.profile=(ROOT/'core/LVGameProfile.h').read_text()
        cls.record=json.loads((ROOT/'analysis/international-layout.json').read_text())

    def test_installed_target_identity(self):
        info=plistlib.loads((ROOT/'inputs/Info.plist').read_bytes())
        self.assertEqual((info['CFBundleIdentifier'],info['CFBundleExecutable'],info['CFBundleVersion']),
            ('com.riotgames.league.wildrift','wildrift','2813'))
        app=plistlib.loads((ROOT/'ios/Info.plist').read_bytes())
        self.assertEqual(app['CFBundleIdentifier'],'local.wildrift.recovery')
        self.assertNotEqual(app['CFBundleIdentifier'],'local.lvlolm.recovery')
        self.assertEqual(app['CFBundleDisplayName'],'Wild Rift 国际服')
        self.assertNotIn('local.lvlolm.recovery',(ROOT/'ios/LVHUDControl.m').read_text())
        self.assertNotIn('/private/var/tmp/lvlolm-hud-',(ROOT/'ios/LVHUDTrace.m').read_text())

    def test_class_cache_global_instruction(self):
        pc=int(self.record['class_getter'],16)+0x2c
        cs=Cs(CS_ARCH_ARM64,CS_MODE_LITTLE_ENDIAN);cs.detail=True
        a,b=list(cs.disasm(self.fw[pc:pc+8],pc))
        self.assertEqual((a.mnemonic,b.mnemonic),('adrp','ldr'))
        actual=a.operands[1].imm+b.operands[1].mem.disp
        self.assertEqual(actual,int(self.record['class_cache'],16))
        declared=int(re.search(r'LV_TARGET_CLASS_CACHE_OFFSET UINT64_C\((0x[0-9a-f]+)\)',self.profile)[1],16)
        self.assertEqual(actual,declared)

    def test_runtime_type_indices_and_managed_fields(self):
        for macro,name,namespace in (
            ('LV_TYPE_DRIVE_ENTRY_UNITY','DriveEntryUnity','FrameEngine.Visual'),
            ('LV_TYPE_FE_VISI','FEVisi','FrameEngine.Visual'),
            ('LV_TYPE_MINIMAP_MAPPING','UIMiniMappingMgr',''),
            ('LV_TYPE_MINIMAP_CONTROLLER','UIMainBattleMiniMapCtrl',''),
            ('LV_TYPE_MINIMAP_HERO_ICON','UIMiniIconHeroCtrl','')):
            index=int(re.search(r'#define '+macro+r' (\d+)',self.profile)[1])
            t=self.md.type(index)
            self.assertEqual((t['name'],t['namespace']),(name,namespace))
        for selected in self.record['selected_types']:
            t=self.md.type(selected['index'])
            self.assertEqual((t['name'],t['namespace']),(selected['name'],selected['namespace']))
            self.assertEqual(self.native.fields(t),selected['fields'])
            self.assertEqual(self.native.methods(t),selected['methods'])
            self.assertEqual(selected['changed_offsets'],[])

    def test_original_minimap_class_globals(self):
        # Actual original consumer instructions, independently of our fixture.
        cs=Cs(CS_ARCH_ARM64,CS_MODE_LITTLE_ENDIAN);cs.detail=True
        for macro,pc in (('LV_MINIMAP_CONTROLLER_CLASS_GLOBAL',0x5e713a0),
                         ('LV_MINIMAP_MAPPING_CLASS_GLOBAL',0x5e96960)):
            a,b=list(cs.disasm(self.fw[pc:pc+8],pc))
            self.assertEqual((a.mnemonic,b.mnemonic),('adrp','ldr'))
            actual=a.operands[1].imm+b.operands[1].mem.disp
            declared=int(re.search(macro+r' UINT64_C\((0x[0-9a-f]+)\)',self.profile)[1],16)
            self.assertEqual(actual,declared)

    def test_native_anchor_configuration_getters(self):
        cs=Cs(CS_ARCH_ARM64,CS_MODE_LITTLE_ENDIAN);cs.detail=True
        for pc,mnemonic,immediate in ((0x3777084,'adds',0xca0),(0x3776ff8,'adds',0xc30)):
            ins=next(cs.disasm(self.fw[pc:pc+4],pc))
            self.assertEqual(ins.mnemonic,mnemonic)
            self.assertEqual(ins.operands[-1].imm,immediate)
        for pc,offset in ((0x3b099cc,0x18),(0x3b09a18,0x30),(0x3b09b00,0x28),
                          (0x3b09ac0,0x28),(0x3b058e4,0x30),(0x3b05b90,0xb8)):
            ins=next(cs.disasm(self.fw[pc:pc+4],pc))
            self.assertEqual(ins.mnemonic,'ldr')
            self.assertEqual(ins.operands[1].mem.disp,offset)
        # Native conversion uses the original item as the factory argument;
        # its first word is a type/factory key, not a second native pointer.
        ins=next(cs.disasm(self.fw[0xa9c7824:0xa9c7828],0xa9c7824))
        self.assertEqual((ins.mnemonic,ins.op_str),('mov','x1, x20'))
        t=self.md.type(34147)
        self.assertEqual((t['namespace'],t['name']),('FrameEngine','DataConfig'))
        fields={f['name']:f for f in self.native.fields(t)}
        self.assertEqual(fields['_config']['offset'],0x10)
        self.assertTrue(fields['_config']['static'])
        t=self.md.type(35504)
        self.assertEqual((t['namespace'],t['name']),('FrameEngine.Logic','MapDataSet'))

    def test_chained_rebases_do_not_mutate_input(self):
        from macho_rebases import local_rebases
        import hashlib
        before=hashlib.sha256(self.fw).hexdigest()
        rebased,count=local_rebases(self.fw)
        self.assertGreater(count,100000)
        self.assertNotEqual(rebased,self.fw)
        self.assertEqual(hashlib.sha256(self.fw).hexdigest(),before)
        self.assertEqual(before,'b82b1ece4d3017df66ccc68f4306d69d4df1fb69305fe8a287648008821f310c')

if __name__=='__main__':
    if os.environ.get('GITHUB_ACTIONS')!='true':raise SystemExit('Run validation in GitHub Actions only.')
    unittest.main()
