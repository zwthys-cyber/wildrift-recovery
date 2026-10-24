#!/usr/bin/env python3
"""CI-only selected spell labels and monster refresh layouts, not a metadata dump."""
from inspect_skill_panel import ROOT,md,native,fw,cs
import json,re,struct
spell_fields=[];timers=[];assembly=[]
for index in range(md.tables['types']['count']):
 t=md.type(index);name=t['name'];fields=md.fields(t)
 chosen=[f for f in fields if re.search(r'(summoner|ignite|ghost|flash|barrier|smite|exhaust|clarity|snowball|heal).*(skill|spell|id)|(skill|spell).*(ignite|ghost|flash|barrier|smite|exhaust|clarity|snowball|heal)',f['name'],re.I)]
 if index==26902:chosen=fields
 if chosen and t['namespace']!='IFix':
  nf={f['index']:f for f in native.fields(t)}
  spell_fields.append({'type':t['namespace']+'.'+name,'index':index,'fields':[nf[f['index']] for f in chosen]})
 if re.search(r'monster|neutral|jungle|wildarea|camp|creep|anchor',name,re.I):
  selected=[f for f in fields if re.search(r'time|spawn|born|refresh|respawn|dead|alive|config|position|camp|group',f['name'],re.I)]
  if selected:
   timers.append({'type':t['namespace']+'.'+name,'index':index,'fields':native.fields(t),
    'methods':[m for m in native.methods(t) if re.search(r'time|spawn|born|refresh|respawn|dead|alive',m['name'],re.I)]})
 if index in (16926,35519):
  for m in native.methods(t):
   if m['name'] not in ('.ctor','.cctor','get_showTimeForVisi','get_bornTimeForVisi','GetBornCountDownTick','get_timeNeedToBorn','get_anchorData','get_id','get__actorList'):continue
   start=m['native_address'];assembly.append(f'; {name}.{m["name"]} {start:#x}')
   assembly.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(fw[start:start+640],start))
# Selected default records, with raw bytes retained until their encoding is proven.
fo,fs=struct.unpack_from('<II',md.header,0x40);do,ds=struct.unpack_from('<II',md.header,0x48)
selected_indices={f['index'] for t in spell_fields for f in t['fields'] if f['literal']}
defaults={}
for pos in range(fo,fo+fs,12):
 field,typ,offset=struct.unpack_from('<iii',md.data,pos)
 if field in selected_indices and 0<=offset<ds:
  defaults[field]={'type_index':typ,'data_index':offset,'raw':md.data[do+offset:do+min(ds,offset+16)].hex()}
(ROOT/'build/runtime-feature-layouts.json').write_text(json.dumps({'spell_fields':spell_fields,'spell_defaults':defaults,'monster_timers':timers},indent=2))
(ROOT/'build/spell-label-initializers.asm').write_text('\n'.join(assembly)+'\n')

def compressed_signed(data):
 b=data[0]
 if b<0x80:u=b
 elif b<0xc0:u=((b&0x3f)<<8)|data[1]
 elif b<0xe0:u=((b&0x1f)<<24)|int.from_bytes(data[1:4],'big')
 else:raise ValueError('Unsupported integer prefix')
 return -(u>>1)-1 if u&1 else u>>1
spell_enum={f['name']:compressed_signed(bytes.fromhex(defaults[f['index']]['raw']))
 for t in spell_fields if t['index']==26902 for f in t['fields'] if f['literal']}
assert spell_enum['SUMMON_SKILL_TYPE_FLASH']==81090101
assert spell_enum['SUMMON_SKILL_TYPE_IGNITE']==81100101
assert spell_enum['SUMMON_SKILL_TYPE_SMITE']==81110101
(ROOT/'build/international-spell-ids.json').write_text(json.dumps(spell_enum,indent=2)+'\n')
# All anchor-related layouts are selected; no unrelated gameplay metadata.
anchors=[]
for index in range(md.tables['types']['count']):
 t=md.type(index)
 if 'anchor' not in t['name'].lower() and t['name'] not in ('MiniMapActorCircle','MiniMap','UIMiniMapIcon','Battle'):continue
 anchors.append({'index':index,'type':t['namespace']+'.'+t['name'],'fields':native.fields(t),
  'methods':[m for m in native.methods(t) if any(w in m['name'].lower() for w in ('anchor','time','pos'))]})
(ROOT/'build/monster-anchor-layouts.json').write_text(json.dumps(anchors,indent=2))

# Selected original map timer consumers, preserving current game semantics.
lines=[]
for index,names in ((6772,('OnLogicTimeUpdate',)),(6768,('OnLogicTimeUpdate','SetTime')),
 (6766,('OnLogicTimeUpdate','SetTime')),(35519,('get_showTimeForVisi','get_bornTimeForVisi','get_timeNeedToBorn')),
 (34491,('get_fixTime',)),(6774,('UpdatePosition','UpdatePos','UpdatePosByFollow'))):
 t=md.type(index)
 for m in native.methods(t):
  if m['name'] not in names:continue
  start=m['native_address'];lines.append(f'; {t["name"]}.{m["name"]} {start:#x}')
  size=64 if m['name'].startswith('get_') and index==35519 else 4096
  lines.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(fw[start:start+size],start))
# TMPro base text field layout is used only if a current UI countdown is proven.
for index in range(md.tables['types']['count']):
 t=md.type(index)
 if t['namespace']=='TMPro' and t['name']=='TMP_Text':
  lines.append('; TMP_Text fields '+repr([(f['name'],f['offset']) for f in native.fields(t) if f['name'] in ('m_text','m_fontSize')]))
(ROOT/'build/monster-timer-consumers.asm').write_text('\n'.join(lines)+'\n')
