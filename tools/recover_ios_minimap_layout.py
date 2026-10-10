#!/usr/bin/env python3
"""Record only selected metadata and the ordinary-map arithmetic evidence."""
import json
from pathlib import Path
from capstone import Cs, CS_ARCH_ARM64, CS_MODE_LITTLE_ENDIAN
from recover_ios_metadata import Metadata, NativeTables, FRAMEWORK_SHA256, FRAMEWORK_UUID, METADATA_SHA256

ROOT=Path(__file__).resolve().parents[1]
fw=(ROOT/'inputs/ios-0.2.0/Bundle/Frameworks/UnityFramework.framework/UnityFramework').read_bytes()
md=Metadata((ROOT/'inputs/ios-0.2.0/Bundle/Data/Managed/Metadata/global-metadata.dat').read_bytes(),fw)
native=NativeTables(fw,md)
selected=[]
for index,fields,methods in (
    (6839,('Instance','isViewportMode','miniMapSize','scaleX','scaleZ','halfWidth','halfHeight','viewportSuspendCount','fullMapUniformScale'),
     ('WorldToMiniMap','WorldToMinmap','get_IsViewportMode','get_isViewportModeSuspended')),
    (6835,('normalMiniMapInstance','isFullMapShowing','zoomState'),('get_NormalMiniMapInstance',))):
    record=md.type(index)
    selected.append(dict(index=index,name=record['name'],namespace=record['namespace'],
        fields=[f for f in native.fields(record) if f['name'] in fields],
        methods=[m for m in native.methods(record) if m['name'] in methods]))
out={'framework_uuid':FRAMEWORK_UUID,'framework_sha256':FRAMEWORK_SHA256,'metadata_sha256':METADATA_SHA256,
     'selected_types':selected,'ordinary_map_branch':'0x740199c..0x7401a04',
     'native_formula':'rotatedX * scaleX, rotatedZ * scaleZ; optional clamp to +-halfWidth/halfHeight',
     'normalized_formula':'u = 0.5 + rotatedX*scaleX/(2*halfWidth); v = 0.5 - rotatedZ*scaleZ/(2*halfHeight)',
     'rotation_source':'Default camp 1 => 0 degrees, camp 2 => 180 degrees; user may override. Native camera rotation getter is NOT re-executed.',
     'screen_rect_source':'iOS-only user calibration in landscape screen percentages; initial rectangle is an unverified estimate',
     'device_geometry_verified':False,'device_screen_alignment_verified':False,
     'scope':'Offline ordinary-map branch and field layout. Native viewport/full-map branches are suppressed. Current resource hotfix behavior and UI placement still need device verification.'}
device_summary=ROOT/'analysis/device-0.7.0-summary.json'
if device_summary.exists():
    observation=json.loads(device_summary.read_text())
    out['device_observation']={
        'summary':'analysis/device-0.7.0-summary.json',
        'native_projection_status_visible':observation['native_projection_status_visible'],
        'fog_updates_user_confirmed':observation['fog_updates_user_confirmed'],
        'scope':observation['fog_updates_observation_scope']}
    out['recommended_rect_percent']=observation['rectangle_calibration']['recommendation_percent']
    out['screen_rect_source']='iOS user calibration; 0.7.1 recommendation estimated from a cropped screenshot assuming the old default rectangle. Corrected alignment awaits a multi-position phone check.'
(ROOT/'analysis/ios-minimap-layout.json').write_text(json.dumps(out,ensure_ascii=False,indent=2)+'\n')
disassembler=Cs(CS_ARCH_ARM64,CS_MODE_LITTLE_ENDIAN)
lines=['; Ordinary-map scalar branch only; extracted locally from the exact UUID/SHA input.']
for i in disassembler.disasm(fw[0x74019c8:0x7401a04],0x74019c8):lines.append(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}')
(ROOT/'analysis/ios-assembly/074019c8-minimap.asm').write_text('\n'.join(lines)+'\n')
print('Recorded two types and the 15-instruction ordinary-map arithmetic branch.')
