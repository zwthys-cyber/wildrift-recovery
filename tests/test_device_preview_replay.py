#!/usr/bin/env python3
"""Compare the current native preview with published 0.5.0 device decisions.

This replays numeric snapshots, not memory reads or device touch/display APIs.
The fixture omits live pointers, bundle/container paths and image metadata.
"""
import json
import subprocess
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
REPORTS = json.loads((ROOT / 'tests/fixtures/device-0.5.0-preview.json').read_text())['reports']
ACTOR_FIELDS = dict(zip(
    'values_read_ok health_read_ok object_id_read_ok position_read_ok classification_read_ok'.split(),
    'values_ok health_ok object_id_ok position_ok classification_ok'.split()))
SKILL_FIELDS = dict(zip(
    'values_read_ok cooldown_read_ok stock_read_ok slot_state_read_ok cast_state_read_ok slot_state_raw cast_state_raw'.split(),
    'values_ok cooldown_ok stock_ok slot_state_ok cast_state_ok slot_state cast_state'.split()))


def initializer(record, mapping):
    fields = []
    for key, value in record.items():
        if key.endswith('_present'):
            key = key.removesuffix('_present')
            value = 0x350000000 if value else 0
        field = mapping.get(key, key)
        if isinstance(value, list):
            rendered = '{' + ','.join(str(int(x)) for x in value) + '}'
        else:
            rendered = str(int(value))
        fields.append('.' + field + '=' + rendered)
    return '{' + ','.join(fields) + '}'


def source():
    cases = []
    for report in REPORTS:
        lines = ['memset(&s,0,sizeof(s)); lv_config_defaults(&config);',
                 's.result=LV_TARGET_READY;', f's.count={len(report["actors"])};']
        for index, actor in enumerate(report['actors']):
            lines.append(f's.actors[{index}]=(LVTargetActor){initializer(actor, ACTOR_FIELDS)};')
        lines.append('s.local_skills.result=LV_TARGET_READY;')
        for name in ('all', 'summoner'):
            skills = report['local_skills'][name]['skills']
            lines.extend([f's.local_skills.{name}.result=LV_TARGET_READY;',
                          f's.local_skills.{name}.count={len(skills)};'])
            for index, skill in enumerate(skills):
                lines.append(f's.local_skills.{name}.skills[{index}]=(LVTargetSkill){initializer(skill, SKILL_FIELDS)};')
        for key, value in report['settings'].items():
            lines.append(f'if(lv_config_set(&config,(size_t)lv_config_index("{key}"),"{int(value)}",NULL)) return 2;')
        cases.append('\n'.join(lines))
    return r'''#include "LVSmitePreview.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
static LVTargetSnapshot s;
int main(int argc,char **argv) {
 if(argc!=2) return 2;
 LVConfig config; LVSmitePreview p;
 switch(atoi(argv[1])) {
''' + ''.join(f'case {i}:\n{case}\nbreak;\n' for i, case in enumerate(cases)) + r'''
 default: return 2;
 }
 lv_smite_preview(&s,&config,&p);
 printf("{\"would_trigger_in_simulation\":%u,\"original_rule_threshold\":%d,",p.would_trigger,p.threshold);
 printf("\"nearby_enemy_hero_count\":%zu,\"unconfirmed_enemy_object_count\":%zu,",p.enemy_count,p.unknown_enemy_count);
 printf("\"recognized_target_count\":%zu,\"eligible_target_count\":%zu,",p.candidate_count,p.eligible_count);
 printf("\"range_world_xz_assumed\":%.17g,\"threshold_source\":\"%s\",",(double)p.range_fixed/16384.0,
        p.threshold_from_level?"recovered_android_level_formula":"configuration_fallback");
 if(p.smite_found) printf("\"smite_resource_id\":%u,\"smite_level\":%d,",
        s.local_skills.summoner.skills[p.skill_index].resource_id,s.local_skills.summoner.skills[p.skill_index].level);
 printf("\"blockers\":["); unsigned printed=0;
 for(unsigned bit=1;bit<=LV_PREVIEW_LOCAL_AMBIGUOUS;bit<<=1)
   if(p.blockers&bit) printf("%s\"%s\"",printed++?",":"",lv_smite_preview_block_name(bit));
 printf("],\"candidates\":[");
 for(size_t i=0;i<p.candidate_count;i++) {
   const LVPreviewCandidate *c=&p.candidates[i];const LVTargetActor *a=&s.actors[c->actor_index];
   printf("%s{\"actor_index\":%zu,\"object_id\":%u,\"resource_id\":%d,",i?",":"",c->actor_index,a->object_id,a->resource_id);
   printf("\"status\":\"%s\",\"distance_read_ok\":%u,",lv_smite_candidate_status_name(c->status),c->distance_ok);
   printf("\"health\":%.17g,\"distance_world_xz\":%.17g}",(double)a->health_fixed/16384.0,c->distance_world_xz);
 }
 puts("]}");return 0;
}
'''


class DevicePreviewReplay(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.directory = tempfile.TemporaryDirectory(prefix='lvlolm-device-replay-')
        directory = Path(cls.directory.name)
        generated = directory / 'replay.c'
        generated.write_text(source())
        cls.binary = directory / 'replay'
        subprocess.run(['gcc', '-std=c11', '-D_POSIX_C_SOURCE=200809L', '-Wall', '-Wextra', '-Werror',
                        '-fsanitize=address,undefined', '-fno-omit-frame-pointer', '-no-pie', '-g',
                        '-I' + str(ROOT / 'core'), str(generated),
                        *[str(ROOT / 'core' / name) for name in ('LVSmitePreview.c', 'LVConfig.c', 'LVActions.c')],
                        '-lm', '-o', str(cls.binary)], check=True)

    @classmethod
    def tearDownClass(cls):
        cls.directory.cleanup()

    def compare_report(self, index):
        report = REPORTS[index]
        self.assertEqual(report['result'], 'ready')
        self.assertEqual(report['local_skills']['result'], 'ready')
        self.assertEqual(report['local_skills']['summoner']['result'], 'ready')
        actual = json.loads(subprocess.check_output([str(self.binary), str(index)], text=True))
        expected = report['expected_preview']
        for key, value in actual.items():
            if key == 'candidates':
                self.assertEqual(len(value), len(expected[key]))
                for candidate, recorded in zip(value, expected[key]):
                    for field, number in candidate.items():
                        if field == 'distance_world_xz':
                            # Different hypotf implementations may differ by a float32 ULP.
                            self.assertAlmostEqual(number, recorded[field], delta=1e-5)
                        else:
                            self.assertEqual(number, recorded[field], (index, field))
            else:
                self.assertEqual(value, expected[key], (index, key))

    def test_stock_one_no_cooldown_report(self):
        self.compare_report(0)

    def test_empty_stock_active_cooldown_report(self):
        self.compare_report(1)


if __name__ == '__main__':
    unittest.main()
