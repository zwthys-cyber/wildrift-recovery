#!/usr/bin/env python3
"""CI-only selected minimap root fields and original singleton accessors."""
from inspect_skill_panel import ROOT,md,native,fw,cs
import json
names={'UIMiniMappingMgr','UIMainBattleMiniMapCtrl','MiniMapEntityCtrl','UIMiniMapIconCtrl'}
layouts=[];lines=[]
for index in range(md.tables['types']['count']):
 t=md.type(index)
 if t['name'] not in names:continue
 layouts.append({'index':index,'type':t,'fields':native.fields(t),'methods':native.methods(t)})
 for m in native.methods(t):
  if m['name'] not in ('.ctor','.cctor') and not any(w in m['name'].lower() for w in ('instance','entity','mapping','awake','init','get_icon')):continue
  start=m['native_address']
  if not start:continue
  lines.append(f'; {t["name"]}.{m["name"]} {start:#x}')
  lines.extend(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}' for i in cs.disasm(fw[start:start+4096],start))
(ROOT/'build/minimap-root-layouts.json').write_text(json.dumps(layouts,indent=2))
(ROOT/'build/minimap-root-accessors.asm').write_text('\n'.join(lines)+'\n')
