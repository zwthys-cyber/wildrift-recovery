#!/usr/bin/env python3
"""CI-only bounded inspection of the original summoner-skill lookup."""
from inspect_skill_panel import ROOT,engine,fw,cs,md,native,follow,exports
lines=[]
for start,end,label in ((0x1fafccc,0x1faff00,'native hero/component accessor'),
 (0x1001d60,0x1001f50,'native/sync summoner GetSkill'),
 (0xff8b28,0xff8b50,'native summoner manager consumer'),
 (0xff9030,0xff9050,'sync summoner manager consumer')):
 lines.append(f'; {label} {start:#x}')
 lines.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(engine[start:end],start))
for index in (36047,):
 t=md.type(index)
 for m in native.methods(t):
  if m['name'] not in ('GetSkill','GetSkillSync','get_skills'):continue
  start=m['native_address'];lines.append(f'; {t["name"]}.{m["name"]} {start:#x}')
  lines.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(fw[start:start+200],start))
(ROOT/'build/summoner-cooldown.asm').write_text('\n'.join(lines)+'\n')
