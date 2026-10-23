#!/usr/bin/env python3
"""GitHub-only selected skill-slot evidence; never execute game code."""
import json
import os
from pathlib import Path
from capstone import Cs,CS_ARCH_ARM64,CS_MODE_LITTLE_ENDIAN
from recover_ios_metadata import Metadata,NativeTables
ROOT=Path(__file__).resolve().parents[1]
if os.environ.get('GITHUB_ACTIONS')!='true':raise SystemExit('Run analysis in GitHub Actions only.')
fw=(ROOT/'inputs/UnityFramework').read_bytes()
md=Metadata((ROOT/'inputs/global-metadata.dat').read_bytes(),fw);native=NativeTables(fw,md)
cs=Cs(CS_ARCH_ARM64,CS_MODE_LITTLE_ENDIAN)
selected={('FrameEngine.Logic','SkillSlot'):('get_index','get_owner','get_currentSkill','get_defaultSkill','get_orignalSkill','get_level'),
 ('FrameEngine.Logic','ActorComponentSkillMgr'):('GetRSkillSync','GetSkillIDByIndexSync','GetSkillSlotByIndexSync','get_slots'),
 ('FrameEngine.Logic','ActorSkill'):('get__slot','get_objId','get_level','get_resId')}
profile=json.loads((ROOT/'analysis/international-layout.json').read_text())
lines=[];methods={}
for t in profile['selected_types']:
 key=(t['namespace'],t['name'])
 if key not in selected:continue
 for m in native.methods(md.type(t['index'])):
  if m['name'] not in selected[key]:continue
  start=m['native_address'];name='.'.join(key)+'.'+m['name'];methods[name]=hex(start)
  lines.append('\n; '+name+' '+hex(start))
  # Getter/wrapper through its first return/tail branch, capped to selected instructions.
  for ins in cs.disasm(fw[start:start+320],start):
   lines.append(f'{ins.address:08x}: {ins.mnemonic:8s} {ins.op_str}')
   if ins.mnemonic in ('ret','b'):break
out=ROOT/'build';out.mkdir(exist_ok=True)
(out/'skill-panel-getters.asm').write_text('\n'.join(lines)+'\n')
(out/'skill-panel-methods.json').write_text(json.dumps(methods,indent=2)+'\n')
print('Selected slot getter evidence:',len(methods))
