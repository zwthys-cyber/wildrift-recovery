#!/usr/bin/env python3
"""CI-only selected spell labels and monster refresh layouts, not a metadata dump."""
from inspect_skill_panel import ROOT,md,native,fw,cs
import json,re,struct
spell_fields=[];timers=[];assembly=[]
for index in range(md.tables['types']['count']):
 t=md.type(index);name=t['name'];fields=md.fields(t)
 chosen=[f for f in fields if re.search(r'(summoner|ignite|ghost|flash|barrier|smite|exhaust|clarity|snowball|heal).*(skill|spell|id)|(skill|spell).*(ignite|ghost|flash|barrier|smite|exhaust|clarity|snowball|heal)',f['name'],re.I)]
 if chosen:
  nf={f['index']:f for f in native.fields(t)}
  spell_fields.append({'type':t['namespace']+'.'+name,'index':index,'fields':[nf[f['index']] for f in chosen]})
 if re.search(r'monster|neutral|jungle|wildarea|camp|creep',name,re.I):
  selected=[f for f in fields if re.search(r'time|spawn|born|refresh|respawn|dead|alive|config|position|camp|group',f['name'],re.I)]
  if selected:
   timers.append({'type':t['namespace']+'.'+name,'index':index,'fields':native.fields(t),
    'methods':[m for m in native.methods(t) if re.search(r'time|spawn|born|refresh|respawn|dead|alive',m['name'],re.I)]})
 if index==16926:
  for m in native.methods(t):
   if m['name'] not in ('.ctor','.cctor'):continue
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
