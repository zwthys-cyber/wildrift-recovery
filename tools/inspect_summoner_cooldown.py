#!/usr/bin/env python3
"""CI-only bounded inspection of the original summoner-skill lookup."""
from inspect_skill_panel import ROOT,engine,fw,cs,md,native,follow,exports
lines=[]
for start,end,label in ((0x1fafccc,0x1fafd04,'native hero type check'),
 (0x1001d60,0x1001e60,'native summoner GetSkill'),
 (0x1001e60,0x1001f80,'sync summoner GetSkill'),
 (0xfefc48,0xfefc58,'native/sync resource getter'),
 (0x1001000,0x10011c0,'summoner manager construction context'),
 (0xff8b28,0xff8f80,'native summoner manager consumer'),
 (0xff9030,0xff9480,'sync summoner manager consumer')):
 lines.append(f'; {label} {start:#x}')
 lines.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(engine[start:end],start))
for index in (36047,):
 t=md.type(index)
 for m in native.methods(t):
  if m['name'] not in ('GetSkill','GetSkillSync','get_skills'):continue
  start=m['native_address'];lines.append(f'; {t["name"]}.{m["name"]} {start:#x}')
  lines.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(fw[start:start+200],start))
# Follow the native resource getter tail branch.
for ins in cs.disasm(engine[0xfefc48:0xfefc50],0xfefc48):
 if ins.mnemonic=='b':
  start=ins.operands[0].imm;lines.append(f'; resource getter implementation {start:#x}')
  lines.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(engine[start:start+128],start))
# Complete node accessor bodies. GetState 1014ff4 reads node +10 byte and
# +18 signed value (state 0/1/2); 1015164/101516c are the two GetRemainCD
# entry points; 102498c/10249b0 consume the +570 trigger-field address and
# read the adjacent +580 owner slot.
for start,end,label in ((0x1014ff4,0x1015090,'native GetState'),
 (0x1015164,0x1015184,'native GetRemainCD entries'),
 (0x102498c,0x1024c20,'trigger field validation helper')):
 lines.append(f'; {label} {start:#x}')
 lines.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(engine[start:end],start))
(ROOT/'build/summoner-cooldown.asm').write_text('\n'.join(lines)+'\n')
