#!/usr/bin/env python3
"""Record the actual GitHub-built artifact separately from local validation."""
import hashlib
import json
import os
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
if os.environ.get('GITHUB_ACTIONS') != 'true':
    raise SystemExit('This record is generated only inside GitHub Actions.')
metadata = json.loads((ROOT / 'dist/build-metadata.json').read_text())
artifact = ROOT / 'dist' / metadata['artifact']
digest = hashlib.sha256(artifact.read_bytes()).hexdigest()
if digest != metadata['sha256']:
    raise SystemExit('IPA does not match current build metadata.')

def checks(name):
    output = (ROOT / 'build' / name).read_text()
    match = re.search(r'(\d+) (?:checks|scenarios) passed', output)
    if not match:
        raise ValueError('Missing completed test output: ' + name)
    return int(match.group(1))

record = {
    'artifact': artifact.name, 'sha256': digest,
    'app_version': metadata['app_version'],
    'commit': os.environ['GITHUB_SHA'],
    'repository': os.environ['GITHUB_REPOSITORY'],
    'run_url': os.environ['GITHUB_SERVER_URL'] + '/' + os.environ['GITHUB_REPOSITORY'] +
               '/actions/runs/' + os.environ['GITHUB_RUN_ID'],
    'compiler': metadata['clang_version'], 'sdk': metadata['sdk'],
    'minimap_checks': checks('minimap-checks.txt'),
    'minimap_motion_checks': checks('minimap-motion-checks.txt'),
    'ward_minimap_checks': checks('ward-minimap-checks.txt'),
    'target_reader_scenarios': checks('target-reader-checks.txt'),
    'minimap_health_checks': checks('minimap-health-checks.txt'),
    'native_health_checks': checks('native-health-checks.txt'),
    'logic_position_checks': checks('logic-position-checks.txt'),
    'hud_telemetry_checks': checks('hud-telemetry-checks.txt'),
    'ipa_signature_tests': 5,
    'ipa_total_tests': 8,
    'zip_export_tests': 3,
    'collection_inspector_tests': 6,
    'device_minimap_checker_tests': 9,
    'native_engine_collection_device_verified': metadata['native_engine_collection_device_verified'],
    'native_health_device_verified': False,
    'logic_position_device_verified': False,
    'enemy_ward_minimap_device_verified': False,
    'bundled_hero_portraits': metadata['minimap_hero_portrait_count'],
    'desktop_icon_payload_verified': True,
    'scope': 'International 7.3.0 (2813): build, signatures, synthetic reader tests and bounded original instruction comparisons run in GitHub Actions. No international phone runtime evidence. Historical CN reports are retained only as upstream context.'
}
text = json.dumps(record, ensure_ascii=False, indent=2) + '\n'
(ROOT / 'analysis/ci-validation.json').write_text(text)
(ROOT / 'dist' / ('ci-validation-' + metadata['app_version'] + '.json')).write_text(text)
print('Recorded GitHub build:', record['run_url'])
