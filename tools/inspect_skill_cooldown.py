#!/usr/bin/env python3
"""CI-only inspection of selected actual cooldown accessor paths."""
from inspect_skill_panel import ROOT,fw,engine,cs,follow,exports,profile,md,native
out=ROOT/'build';lines=[];targets=[]
for t in profile['selected_types']:
 if t['namespace']!='FrameEngine.Logic':continue
 selected={'SkillCDNode':('GetRemainCDSync','GetRemainCD','GetStateSync','get_remainTime','get_totalTime','get_startTime'),
 'ActorSkill':('get_CD1','get_CD2','get_cdingTotalTime'),
 'SkillCDTrigger':('GetCD1Sync','GetCD2Sync','IsCDingSync','get_cdNode')}.get(t['name'],())
 for m in native.methods(md.type(t['index'])):
  if m['name'] not in selected:continue
  start=m['native_address'];lines.append('\n; '+t['name']+'.'+m['name']+' '+hex(start))
  for ins in cs.disasm(fw[start:start+280],start):
   lines.append(f'{ins.address:08x}: {ins.mnemonic:8s} {ins.op_str}')
   if ins.mnemonic in ('b','bl'):
    dest=ins.operands[0].imm
    if 0x3c70000<dest<0x3c80000:
     for nested in cs.disasm(fw[dest:dest+160],dest):
      lines.append(f'{nested.address:08x}: {nested.mnemonic:8s} {nested.op_str}')
      if nested.mnemonic in ('b','bl') and 0x7c00000<nested.operands[0].imm<0x7c20000:
       name=follow(nested.operands[0].imm)
       if name in exports:targets.append((name,exports[name]))
    if 0x7c00000<dest<0x7c20000:
     name=follow(dest)
     if name in exports:targets.append((name,exports[name]))
   if ins.mnemonic in ('ret','b'):break
for name,start in targets:
 lines.append('\n; '+name+' engine '+hex(start))
 lines.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(engine[start:start+256],start))
 # Include calls from the selected native wrapper; no recursion into unrelated code.
 for ins in cs.disasm(engine[start:start+128],start):
  if ins.mnemonic=='bl':
   dest=ins.operands[0].imm
   if 0x100000<=dest<0x4100000:
    lines.append('\n; engine helper '+hex(dest))
    lines.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(engine[dest:dest+320],dest))
for start,end in ((0x1015164,0x1015184),(0xff8a2c,0xff8bd0),(0xff8f30,0xff90e0)):
 lines.append('\n; GetSkill resource lookup '+hex(start))
 lines.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(engine[start:end],start))
(out/'skill-cooldown-accessors.asm').write_text('\n'.join(lines)+'\n')
print('Selected cooldown imports:',targets)
# Search only named skill cooldown consumers; export selected names and code,
# never the complete metadata or private binaries.
consumers=[]
for index in range(md.tables['types']['count']):
 t=md.type(index)
 if not any(term in t['name'].lower() for term in ('skill','cooldown')):continue
 for m in native.methods(t):
  name=m['name'].lower()
  if any(term in name for term in ('cdleft','remaincd','cooldown','cdremain','leftcd')):
   consumers.append((t['namespace'],t['name'],m['name'],m['native_address']))
extra=[]
for namespace,kind,name,start in consumers:
 extra.append(f'; {namespace}.{kind}.{name} {start:#x}')
 if start and len(consumers)<150:
  extra.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(fw[start:start+512],start))
# Constructor/field preparation and the complete nearby native node routines.
for label,data,start,end in (('managed SkillCDNode ctor',fw,0x3ba8058,0x3ba8214),
 ('native CD node state and time updates',engine,0x1014c00,0x1015980)):
 extra.append(f'; {label} {start:#x}')
 extra.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(data[start:end],start))
(out/'skill-cooldown-consumers.asm').write_text('\n'.join(extra)+'\n')
print('Selected cooldown consumers:',len(consumers))
import struct
# Direct original callers identify how ActorSkill obtains its trigger, without
# guessing an offset from the managed sync representation.
callers=[]
for pc in range(0,len(engine)-4,4):
 w=struct.unpack_from('<I',engine,pc)[0]
 if w>>26!=0x25:continue
 imm=w&0x3ffffff
 if imm&0x2000000:imm-=0x4000000
 target=pc+imm*4
 if target in (0x102498c,0x10249b0,0x1015164,0x101516c):
  callers.append((pc,target))
for pc,target in callers[:40]:
 extra.append(f'; cooldown caller {pc:#x} -> {target:#x}')
 extra.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(engine[max(0,pc-96):pc+36],max(0,pc-96)))
for start,end in ((0xff1a6c,0xff1ae0),(0x32edfb0,0x32ee080)):
 extra.append(f'; selected native field/clock accessor {start:#x}')
 extra.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(engine[start:end],start))
(out/'skill-cooldown-consumers.asm').write_text('\n'.join(extra)+'\n')
print('Selected direct cooldown callers:',len(callers))
