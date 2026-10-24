#!/usr/bin/env python3
"""CI-only current native anchor configuration lookup evidence."""
from inspect_skill_panel import ROOT,md,native,fw,cs,engine,follow,exports
import json
layouts=[];lines=[]
for index in range(md.tables['types']['count']):
 t=md.type(index);name=t['name']
 if not (name in ('Battle','BattleMapMgr','BattleMap','MapDataData','MonsterAnchor','AnchorDataData','UIMiniIconAnchorCtrl') or
         ('LGameVector' in name and ('BattleMap' in name or 'AnchorDataData' in name))):continue
 if t['namespace']=='IFix':continue
 methods=native.methods(t)
 layouts.append({'index':index,'type':t['namespace']+'.'+name,'fields':native.fields(t),'methods':methods})
 for m in methods:
  if m['name'] not in ('get_anchorData','get_maps','get_mapMgr','get_Item','get_data','get_mapData','get_anchorDatas','get_anchorDataList','get_ID','get_id','OnLogicTimeUpdate'):continue
  start=m['native_address']
  if not start:continue
  size=1024 if m['name']=='get_anchorData' else 2048
  lines.append(f'; {t["namespace"]}.{name}.{m["name"]} {start:#x}')
  lines.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(fw[start:start+size],start))
(ROOT/'build/anchor-binding-layouts.json').write_text(json.dumps(layouts,indent=2))
(ROOT/'build/anchor-binding-getters.asm').write_text('\n'.join(lines)+'\n')
# Resolve exactly the wrapper constructors/lookups called by get_anchorData.
targets={0x3b04ffc,0x3b0588c,0x398f05c}
extra=[];extra_asm=[]
for index in range(md.tables['types']['count']):
 t=md.type(index)
 if t['namespace']!='FrameEngine.Logic':continue
 methods=native.methods(t)
 if not any(m['native_address'] in targets for m in methods):continue
 extra.append({'index':index,'type':t['namespace']+'.'+t['name'],'fields':native.fields(t),'methods':methods})
 for m in methods:
  if m['native_address'] not in targets:continue
  start=m['native_address'];extra_asm.append(f'; {t["name"]}.{m["name"]} {start:#x}')
  extra_asm.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(fw[start:start+1024],start))
(ROOT/'build/anchor-binding-layouts.json').write_text(json.dumps(layouts+extra,indent=2))
(ROOT/'build/anchor-binding-getters.asm').write_text('\n'.join(lines+extra_asm)+'\n')
context_layouts=[];context_asm=[]
for index in range(md.tables['types']['count']):
 t=md.type(index)
 if index not in (34199,36534) and not ('MapDC' in t['name'] or 'MapData' in t['name'] or 'BattleDesk' in t['name']):continue
 if index not in (34199,36534) and t['namespace'] not in ('FrameEngine','FrameEngine.Logic','FrameEngine.Interface'):continue
 context_layouts.append({'index':index,'type':t['namespace']+'.'+t['name'],'fields':native.fields(t),'methods':native.methods(t)})
 for m in native.methods(t):
  if not (m['name'].startswith('get_') and any(w in m['name'].lower() for w in ('map','instance','battle'))):continue
  start=m['native_address'];context_asm.append(f'; {t["name"]}.{m["name"]} {start:#x}')
  context_asm.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(fw[start:start+256],start))
(ROOT/'build/anchor-binding-layouts.json').write_text(json.dumps(layouts+extra+context_layouts,indent=2))
(ROOT/'build/anchor-binding-getters.asm').write_text('\n'.join(lines+extra_asm+context_asm)+'\n')
root_layouts=[];root_asm=[]
for index in range(md.tables['types']['count']):
 t=md.type(index)
 if not any('mapdataproxy' in f['name'].lower() for f in md.fields(t)):continue
 root_layouts.append({'index':index,'type':t['namespace']+'.'+t['name'],'fields':native.fields(t),'methods':native.methods(t)})
 for m in native.methods(t):
  if not (m['name'].startswith('get_') and any(w in m['name'].lower() for w in ('map','instance','frame','desk'))):continue
  start=m['native_address'];root_asm.append(f'; {t["name"]}.{m["name"]} {start:#x}')
  root_asm.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(fw[start:start+256],start))
(ROOT/'build/anchor-binding-layouts.json').write_text(json.dumps(layouts+extra+context_layouts+root_layouts,indent=2))
(ROOT/'build/anchor-binding-getters.asm').write_text('\n'.join(lines+extra_asm+context_asm+root_asm)+'\n')
