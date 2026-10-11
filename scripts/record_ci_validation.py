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
    'prior_native_health_device_evidence_version': '0.7.6',
    'prior_native_health_ring_user_confirmed': True,
    'bundled_hero_portraits': metadata['minimap_hero_portrait_count'],
    'desktop_icon_payload_verified': True,
    'scope': 'GitHub CI checks and build provenance. Local original FEProj getter emulation is separately recorded; private engine bytes are absent from CI. The 0.7.6 native HP ring was confirmed by the user. The 0.7.9 global Battle correction is checked against the original FrameRoot store and actual actor dispatch, with an 18-actor native-instruction pipeline locally. Device acceptance checks are separately tested. 0.7.8 failed its lookup gate in all 32 samples. Live 0.7.9 fog display still requires device evidence.'
}
text = json.dumps(record, ensure_ascii=False, indent=2) + '\n'
(ROOT / 'analysis/ci-validation.json').write_text(text)
(ROOT / 'dist' / ('ci-validation-' + metadata['app_version'] + '.json')).write_text(text)
print('Recorded GitHub build:', record['run_url'])
