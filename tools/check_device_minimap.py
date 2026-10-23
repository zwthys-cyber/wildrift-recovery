#!/usr/bin/env python3
"""Check observed fog coordinates and prepared markers; never certify screen UI.

Private input reports remain on disk. Output contains counts, game object IDs,
resource IDs and input hashes, not process/device addresses or player names.
"""
import argparse
import collections
import hashlib
import json
import math
from pathlib import Path

VERSION = '0.8.0'
UNITY_UUID = 'B59675EA-20A7-306E-97FF-5EA41A2B36C6'
ENGINE_UUID = 'D5B32037-47A3-3EFF-B0E5-04B071EFBEE3'


def position_valid(value):
    return isinstance(value, list) and len(value) == 3 and all(
        isinstance(x, (int, float)) and not isinstance(x, bool) and math.isfinite(x) and -200 <= x <= 200
        for x in value)


def check_reports(reports, version=VERSION):
    failures = collections.Counter()
    hidden = collections.Counter()
    positions = collections.defaultdict(set)
    enemies = set()
    match = None
    seen = set()
    samples_checked = 0
    for report in reports:
        if report.get('recovery_app_version') != version:
            failures['version_mismatch'] += 1
            continue
        images = report.get('target_probe', {}).get('metadata', {}).get('images', [])
        uuids = {i.get('uuid') for i in images if isinstance(i, dict)}
        if not {UNITY_UUID, ENGINE_UUID} <= uuids:
            failures['framework_profile_mismatch'] += 1
            continue
        hud = report.get('hud', {})
        sampling = hud.get('sampling', {})
        if not all(sampling.get(k) for k in ('fresh', 'latest_snapshot_usable', 'minimap_enabled')):
            failures['hud_sampling_unusable'] += 1
        trace = hud.get('coordinate_trace', {})
        match_identity = (trace.get('session'), trace.get('battle_instance'))
        if not all(match_identity):
            failures['match_identity_missing'] += 1
        elif match is not None and match_identity != match:
            failures['mixed_matches'] += 1
            continue
        else:
            match = match_identity
        samples = trace.get('samples', [])
        if not samples:
            failures['trace_missing'] += 1
        for sample in samples:
            sampled_at = sample.get('sampled_at')
            if not sampled_at:
                failures['sample_time_missing'] += 1
                continue
            sample_key = (match_identity, sampled_at)
            if sample_key in seen:
                continue
            seen.add(sample_key)
            if sample.get('map_reason') != 'ready' or sample.get('hero_list_truncated'):
                failures['map_sample_unusable'] += 1
                continue
            samples_checked += 1
            logic = sample.get('logic_positions', {})
            if (logic.get('layout_version') != 3 or logic.get('reason') != 'ready' or
                    not logic.get('runtime_battle_matches_frame')):
                failures['logic_reader_not_ready'] += 1
            local_camp = sample.get('local_camp')
            if local_camp not in (1, 2):
                failures['local_camp_unavailable'] += 1
                continue
            living = 0
            for hero in sample.get('heroes', []):
                if hero.get('camp') != 3-local_camp or hero.get('is_local'):
                    continue
                identity = (hero.get('object_id'), hero.get('resource_id'))
                if not all(isinstance(x, int) and x > 0 for x in identity):
                    failures['enemy_identity_invalid'] += 1
                    continue
                enemies.add(identity)
                hp = hero.get('health')
                if not hero.get('health_read_ok') or not isinstance(hp, (int, float)) or not math.isfinite(hp):
                    failures['enemy_health_unavailable'] += 1
                    continue
                if hp <= 0:
                    if hero.get('minimap_marker_prepared'):
                        failures['dead_enemy_marker_present'] += 1
                    continue
                living += 1
                if not hero.get('minimap_marker_prepared'):
                    failures['living_enemy_marker_missing'] += 1
                candidates = hero.get('coordinate_candidates', {})
                if not candidates.get('fog_cut_state_read_ok') or not candidates.get('fog_cut_disappear'):
                    continue
                hidden[identity] += 1
                position = hero.get('logic_position')
                if not hero.get('logic_position_read_ok') or not position_valid(position):
                    failures['hidden_enemy_logic_position_invalid'] += 1
                elif hero.get('minimap_position_source') != 'native_logic_transform':
                    failures['hidden_enemy_marker_not_using_logic'] += 1
                else:
                    positions[identity].add(tuple(position))
            if sample.get('current_enemy_markers') != living:
                failures['prepared_marker_count_mismatch'] += 1
    covered = sum(hidden[i] >= 3 and len(positions[i]) >= 2 for i in enemies)
    result = 'failed' if failures else ('passed_observed_data' if len(enemies) == 5 and covered == 5 and samples_checked >= 10 else 'incomplete')
    return {'result': result, 'app_version': version, 'samples_checked': samples_checked,
            'enemy_identities_observed': len(enemies), 'hidden_enemy_observations': sum(hidden.values()),
            'enemies_with_repeated_hidden_position_updates': covered,
            'failures': dict(failures), 'screen_rendering_verified': False,
            'scope': 'Observed client-memory data and prepared marker checks only. Five enemy identities each need at least three hidden samples and two distinct valid positions. Reports must belong to one match. Screen visibility/alignment require user confirmation; this does not prove all future games.'}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('reports', type=Path, nargs='+')
    parser.add_argument('--version', default=VERSION, help='Expected recovery app version; override for earlier captures')
    args = parser.parse_args()
    raw = [p.read_bytes() for p in args.reports]
    result = check_reports([json.loads(data) for data in raw], version=args.version)
    result['input_sha256'] = [hashlib.sha256(data).hexdigest() for data in raw]
    print(json.dumps(result, ensure_ascii=False, indent=2))
    raise SystemExit(0 if result['result'] == 'passed_observed_data' else 1)
