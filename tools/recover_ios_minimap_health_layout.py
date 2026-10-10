#!/usr/bin/env python3
"""Record selected HP-cache and diagnostic-position evidence for one exact input.

Requires the ignored private framework/metadata inputs. Does not run the game
or dump/export its complete metadata or binary.
"""
import json
from pathlib import Path
from capstone import Cs, CS_ARCH_ARM64, CS_MODE_LITTLE_ENDIAN
from recover_ios_metadata import Metadata, NativeTables, FRAMEWORK_SHA256, FRAMEWORK_UUID, METADATA_SHA256

ROOT = Path(__file__).resolve().parents[1]
bundle = ROOT / 'inputs/ios-0.2.0/Bundle'
fw = (bundle / 'Frameworks/UnityFramework.framework/UnityFramework').read_bytes()
md = Metadata((bundle / 'Data/Managed/Metadata/global-metadata.dat').read_bytes(), fw)
native = NativeTables(fw, md)
selected = []
for index, fields, methods in (
    (6835, ('_entityCtrl',), ()),
    (6801, ('miniMapIconCtrl',), ()),
    (6788, ('miniIcons',), ('GetIconByBattleActor',)),
    (6774, ('_actor', 'isInitiate', 'isShowing', '<isBeRecyle>k__BackingField'), ()),
    (6780, ('currentHpPercent', 'enableHpBar', '<objId>k__BackingField', 'lastUpdateHpTime'), ('UpdateHpPercent',)),
    (12138, ('_actor', '_logicActor', '_logicPos', '_lastLogicTime'), ('OnSync',)),
    (34579, (), ('get_lastPosition',))):
    record = md.type(index)
    actual_fields = [f for f in native.fields(record) if f['name'] in fields]
    actual_methods = [m for m in native.methods(record) if m['name'] in methods]
    if len(actual_fields) != len(fields) or len(actual_methods) != len(methods):
        raise ValueError('Selected metadata names changed: ' + record['name'])
    selected.append(dict(index=index, name=record['name'], namespace=record['namespace'],
                         fields=actual_fields, methods=actual_methods))
branches = (
    ('07378554-hp-fraction', 0x7378554, 0x737855c),
    ('07378768-hp-store', 0x7378768, 0x737876c),
    ('0738b8d0-icon-entry', 0x738b8d0, 0x738b8dc),
    ('04ea11d8-last-position', 0x4ea11d8, 0x4ea11fc),
    ('092af05c-sync-position-store', 0x92af05c, 0x92af064),
    ('04ee65e8-host-actor', 0x4ee65e8, 0x4ee65f0),
)
disassembler = Cs(CS_ARCH_ARM64, CS_MODE_LITTLE_ENDIAN)
for name, start, end in branches:
    lines = ['; Selected local evidence from the exact UUID/SHA input.']
    for i in disassembler.disasm(fw[start:end], start):
        lines.append(f'{i.address:08x}: {i.mnemonic:8s} {i.op_str}')
    if len(lines) != 1 + (end-start)//4:
        raise ValueError('Instruction range failed: ' + name)
    (ROOT / 'analysis/ios-assembly' / (name+'.asm')).write_text('\n'.join(lines)+'\n')
out = {
    'framework_uuid': FRAMEWORK_UUID, 'framework_sha256': FRAMEWORK_SHA256,
    'metadata_sha256': METADATA_SHA256, 'selected_types': selected,
    'health_chain': 'Class cache[6835] -> statics+0 -> entity+190 -> icons+80 -> dictionary+18 -> entries',
    'dictionary_entry_layout': {'array_data': 32, 'stride': 24, 'hash': 0, 'key_uint32': 8, 'value': 16},
    'health_fraction_math': '(currentHP << 14) / maxHP; native UI stores Q14 at hero icon+1a0',
    'health_scope': 'Use only visible, enabled, initialized, non-recycled, identity-checked icons with a finite positive update timestamp and a fraction in [0,16384]. UI cache has its own refresh interval; not an atomic server HP sample. Unknown HP renders gray. Maximum HP is not inferred.',
    'coordinate_candidate_scope': 'Attribute last position, ActorTransformSync logic position/time, host actor native transform and visual visibility/tick are diagnostic only. OnSync copies native logic position; it is not proven to contain a separate, fresh fog coordinate.',
    'history_position_used_for_overlay': False, 'alternative_position_used_for_overlay': False,
    'fog_realtime_source_verified': False, 'new_fields_device_verified': False,
    'instruction_equivalence': {'tests': 3, 'cases': 27, 'scope': 'Last-position getter, isolated HP math and dictionary stride. External calls and syscalls rejected.'},
}
(ROOT / 'analysis/ios-minimap-health-layout.json').write_text(json.dumps(out, ensure_ascii=False, indent=2)+'\n')
print('Recorded seven selected types and six short instruction ranges.')
