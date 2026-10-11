#!/usr/bin/env python3
"""Independent device acceptance cases, including hidden-marker regressions."""
import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('checker', Path(__file__).resolve().parents[1] / 'tools/check_device_minimap.py')
checker = importlib.util.module_from_spec(spec)
spec.loader.exec_module(checker)


def report():
    samples = []
    for index in range(10):
        heroes = [{'object_id': i, 'resource_id': 10000+i, 'camp': 2, 'is_local': False,
                   'health_read_ok': True, 'health': 100, 'logic_position_read_ok': True,
                   'logic_position': [index+i, 0, -index-i], 'minimap_marker_prepared': True,
                   'minimap_position_source': 'native_logic_transform',
                   'coordinate_candidates': {'fog_cut_state_read_ok': True, 'fog_cut_disappear': True}}
                  for i in range(6, 11)]
        samples.append({'sampled_at': f'2026-10-11T01:00:{index:02d}Z',
                        'map_reason': 'ready', 'local_camp': 1, 'heroes': heroes,
                        'current_enemy_markers': 5, 'logic_positions': {'layout_version': 3,
                        'reason': 'ready', 'runtime_battle_matches_frame': True}})
    return {'recovery_app_version': checker.VERSION, 'target_probe': {'metadata': {'images': [
        {'uuid': checker.UNITY_UUID}, {'uuid': checker.ENGINE_UUID}]}},
        'hud': {'sampling': {'fresh': True, 'latest_snapshot_usable': True, 'minimap_enabled': True},
                'coordinate_trace': {'session': 'synthetic-session', 'battle_instance': 'synthetic-match', 'samples': samples}}}


class AcceptanceTests(unittest.TestCase):
    def test_five_moving_hidden_enemies(self):
        result = checker.check_reports([report()])
        self.assertEqual(result['result'], 'passed_observed_data')
        self.assertEqual(result['enemies_with_repeated_hidden_position_updates'], 5)
        self.assertFalse(result['screen_rendering_verified'])

    def test_prior_version_and_failed_layout(self):
        value = report(); value['recovery_app_version'] = '0.7.8'
        self.assertEqual(checker.check_reports([value])['result'], 'failed')
        value = report()
        for sample in value['hud']['coordinate_trace']['samples']:
            sample['logic_positions']['reason'] = 'logic_lookup_layout_mismatch'
        self.assertEqual(checker.check_reports([value])['failures']['logic_reader_not_ready'], 10)

    def test_no_fog_or_motion_is_incomplete(self):
        for mode in ('visible', 'stationary'):
            value = report()
            for sample in value['hud']['coordinate_trace']['samples']:
                for hero in sample['heroes']:
                    if mode == 'visible': hero['coordinate_candidates']['fog_cut_disappear'] = False
                    else: hero['logic_position'] = [1, 0, 2]
            self.assertEqual(checker.check_reports([value])['result'], 'incomplete')

    def test_missing_marker_or_old_source_fails(self):
        for key, value in (('minimap_marker_prepared', False), ('minimap_position_source', 'sync_transform')):
            fixture = report(); fixture['hud']['coordinate_trace']['samples'][0]['heroes'][0][key] = value
            self.assertEqual(checker.check_reports([fixture])['result'], 'failed')

    def test_invalid_hidden_coordinates(self):
        for position in ([500, 0, 500], [-10000, 0, 0], [float('nan'), 0, 0], None):
            fixture = report(); fixture['hud']['coordinate_trace']['samples'][0]['heroes'][0]['logic_position'] = position
            self.assertIn('hidden_enemy_logic_position_invalid', checker.check_reports([fixture])['failures'])

    def test_dead_enemy_is_excluded(self):
        fixture = report(); sample = fixture['hud']['coordinate_trace']['samples'][0]
        sample['heroes'][0]['health'] = 0; sample['heroes'][0]['minimap_marker_prepared'] = False
        sample['current_enemy_markers'] = 4
        self.assertEqual(checker.check_reports([fixture])['result'], 'passed_observed_data')
        sample['heroes'][0]['minimap_marker_prepared'] = True
        self.assertIn('dead_enemy_marker_present', checker.check_reports([fixture])['failures'])

    def test_subset_of_roster_is_incomplete(self):
        fixture = report()
        for sample in fixture['hud']['coordinate_trace']['samples']:
            sample['heroes'] = sample['heroes'][:1]; sample['current_enemy_markers'] = 1
        self.assertEqual(checker.check_reports([fixture])['result'], 'incomplete')

    def test_missing_trace_profile_or_stale_hud_fails(self):
        mutations = [lambda x: x['target_probe']['metadata'].update(images=[]),
                     lambda x: x['hud']['sampling'].update(fresh=False),
                     lambda x: x['hud']['coordinate_trace'].update(samples=[])]
        for mutate in mutations:
            fixture = report(); mutate(fixture)
            self.assertEqual(checker.check_reports([fixture])['result'], 'failed')

    def test_mixed_matches_fail_and_duplicate_exports_do_not_inflate(self):
        first = report(); second = report()
        second['hud']['coordinate_trace']['battle_instance'] = 'other-match'
        self.assertIn('mixed_matches', checker.check_reports([first, second])['failures'])
        self.assertEqual(checker.check_reports([first, first])['samples_checked'], 10)


if __name__ == '__main__':
    unittest.main()
