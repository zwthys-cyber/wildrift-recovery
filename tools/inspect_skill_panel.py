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
# Follow the named GetRSkillSync import to its FEProj implementation.
# Pointers are read from on-disk chained imports; the game is never invoked.
import struct
cs.detail=True
commands={};off=32
for _ in range(struct.unpack_from('<I',fw,16)[0]):
 cmd,size=struct.unpack_from('<II',fw,off);commands[cmd]=off;off+=size
fixoff=struct.unpack_from('<I',fw,commands[0x80000034]+8)[0]
_,_,imports,symbols,_,fmt,symfmt=struct.unpack_from('<7I',fw,fixoff)
if symfmt!=0:raise ValueError('Compressed chained symbols are unsupported')
engine=(ROOT/'inputs/FEProj').read_bytes()
off=32
for _ in range(struct.unpack_from('<I',engine,16)[0]):
 cmd,size=struct.unpack_from('<II',engine,off)
 if cmd==2:symoff,nsyms,stroff,strsize=struct.unpack_from('<4I',engine,off+8)
 off+=size
exports={}
for i in range(nsyms):
 idx,kind,sect,desc,value=struct.unpack_from('<IBBHQ',engine,symoff+i*16)
 if not value or not idx:continue
 end=engine.find(b'\0',stroff+idx,stroff+strsize)
 exports[engine[stroff+idx:end].decode(errors='replace')]=value

def follow(pc):
 for _ in range(4):
  ins=list(cs.disasm(fw[pc:pc+12],pc))
  if ins[0].mnemonic=='b':pc=ins[0].operands[0].imm;continue
  if ins[0].mnemonic!='adrp' or ins[1].mnemonic!='ldr':raise ValueError('Unknown import stub '+hex(pc))
  slot=ins[0].operands[1].imm+ins[1].operands[1].mem.disp
  word=struct.unpack_from('<Q',fw,slot)[0]
  if word>>63!=1:raise ValueError('Expected a chained bind')
  ordinal=word&0xffffff
  if fmt in (1,2):v=struct.unpack_from('<I',fw,fixoff+imports+ordinal*(4 if fmt==1 else 8))[0];nameidx=v>>9
  elif fmt==3:v=struct.unpack_from('<Q',fw,fixoff+imports+ordinal*16)[0];nameidx=v>>32
  else:raise ValueError('Unknown chained import format')
  start=fixoff+symbols+nameidx;end=fw.find(b'\0',start)
  return fw[start:end].decode()
 raise ValueError('Import thunk depth')
name=follow(0x7c0f898);entry=exports[name]
lines.append('\n; GetRSkillSync -> '+name+' -> FEProj '+hex(entry))
pending=[entry];seen=set()
while pending and len(seen)<10:
 pc=pending.pop(0)
 if pc in seen:continue
 seen.add(pc);lines.append('\n; FEProj '+hex(pc))
 for ins in cs.disasm(engine[pc:pc+256],pc):
  lines.append(f'{ins.address:08x}: {ins.mnemonic:8s} {ins.op_str}')
  if ins.mnemonic in ('bl','b'):
   target=ins.operands[0].imm
   if 0x4000<=target<0x4585948 and target not in seen:pending.append(target)
  if ins.mnemonic=='b':break
(out/'skill-panel-getters.asm').write_text('\n'.join(lines)+'\n')
print('GetRSkillSync native symbol:',name,hex(entry))
