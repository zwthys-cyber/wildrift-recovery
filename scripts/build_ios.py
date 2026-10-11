#!/usr/bin/env python3
"""Compile actual iOS ARM64 Mach-O executables and package a TrollStore IPA.

Builds the recovery application, read-only HUD, and calibrated minimap overlay.
Dependencies are supplied locally; no upload or remote CI is performed.
"""
import argparse
import hashlib
import json
import os
import plistlib
import shutil
import subprocess
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def run(*args):
    subprocess.run([str(x) for x in args], check=True)


def build(sdk, clang, linker, ldid):
    if not sdk.is_dir():
        raise ValueError('SDK directory does not exist')
    build_dir = ROOT / 'build'
    app = build_dir / 'Payload' / 'LVRecovery.app'
    if app.exists(): shutil.rmtree(app)
    app.mkdir(parents=True, exist_ok=True)
    common = [clang, '-target', 'arm64-apple-ios15.0', '-isysroot', sdk,
              '-O2', '-Wall', '-Werror', '-Wno-deprecated-declarations',
              '-fvisibility=hidden', '-I', ROOT / 'core', '-I', ROOT / 'ios']
    files = ['ios/main.m', 'ios/LVMachReader.m', 'ios/LVHelper.m', 'ios/LVProbe.m', 'ios/LVCollect.m', 'ios/LVHUDTrace.m',
             'ios/LVSnapshot.m', 'ios/LVSnapshotController.m', 'ios/LVHUD.m', 'ios/LVHeroPortraits.m', 'ios/LVHUDControl.m', 'ios/LVMinimapSettings.m', 'core/LVMinimap.c', 'core/LVMinimapMotion.c', 'core/LVHUDTelemetry.c', 'core/LVConfig.c', 'core/LVActions.c', 'core/LVZip.c', 'core/LVTarget.c', 'core/LVLogicPosition.c', 'core/LVSmitePreview.c']
    objects = {}
    for filename in files:
        src = ROOT / filename
        obj = build_dir / (src.stem + '.o')
        extra = ['-fobjc-arc', '-fblocks'] if src.suffix == '.m' else ['-std=c11']
        run(*common, *extra, '-c', src, '-o', obj)
        objects[src.stem] = obj
    links = [linker, '-arch', 'arm64', '-platform_version', 'ios', '15.0', '16.5',
             '-syslibroot', sdk, '-lSystem', '-framework', 'Foundation',
             '-adhoc_codesign']
    run(*links, '-framework', 'UIKit', '-framework', 'CoreGraphics', objects['main'], objects['LVConfig'], objects['LVActions'],
        objects['LVMachReader'], objects['LVHelper'], objects['LVSnapshotController'], objects['LVHUDControl'], objects['LVHUDTrace'], objects['LVHUDTelemetry'], objects['LVMinimapSettings'], objects['LVMinimap'], '-o', app / 'LVRecovery')
    run(*links, '-lz', objects['LVProbe'], objects['LVMachReader'], objects['LVCollect'], objects['LVZip'],
        objects['LVSnapshot'], objects['LVTarget'], objects['LVLogicPosition'], objects['LVSmitePreview'], objects['LVActions'], objects['LVConfig'], objects['LVHUDControl'], objects['LVHUDTrace'], objects['LVHUDTelemetry'], objects['LVMinimap'], '-o', app / 'LVProbe')
    run(*links, '-framework', 'UIKit', '-framework', 'QuartzCore', '-framework', 'CoreGraphics',
        objects['LVHUD'], objects['LVHUDControl'], objects['LVHUDTrace'], objects['LVMachReader'], objects['LVSnapshot'], objects['LVTarget'], objects['LVLogicPosition'],
        objects['LVSmitePreview'], objects['LVActions'], objects['LVConfig'], objects['LVHUDTelemetry'], objects['LVMinimap'], objects['LVMinimapMotion'], objects['LVHeroPortraits'], '-o', app / 'LVHUD')
    info = plistlib.loads((ROOT / 'ios/Info.plist').read_bytes())
    (app / 'Info.plist').write_bytes(plistlib.dumps(info, fmt=plistlib.FMT_BINARY))
    shutil.copy2(ROOT / 'ios/recovered_config.json', app / 'recovered_config.json')
    shutil.copy2(ROOT / 'ios/TrollSpeed-LICENSE.txt', app / 'TrollSpeed-LICENSE.txt')
    shutil.copytree(ROOT / 'ios/Assets/Heroes', app / 'Assets/Heroes')
    shutil.copy2(ROOT / 'ios/Assets/README.md', app / 'Asset-credits.txt')
    for icon in (ROOT / 'ios/Assets/AppIcon').glob('AppIcon*.png'):
        shutil.copy2(icon, app / icon.name)
    for filename, entitlement in [('LVRecovery', 'App'), ('LVProbe', 'Probe'), ('LVHUD', 'HUD')]:
        binary = app / filename
        binary.chmod(0o755)
        run(ldid, '-S' + str(ROOT / 'ios' / (entitlement + '.entitlements.plist')), binary)
    dist = ROOT / 'dist'
    dist.mkdir(exist_ok=True)
    ipa = dist / ('lvlolm-recovery-' + info['CFBundleShortVersionString'] + '.ipa')
    with zipfile.ZipFile(ipa, 'w', zipfile.ZIP_DEFLATED) as z:
        for file in sorted(app.rglob('*')):
            if file.is_file(): z.write(file, file.relative_to(build_dir))
    metadata = {'artifact': ipa.name, 'app_version': info['CFBundleShortVersionString'], 'build_version': info['CFBundleVersion'],
                'sha256': hashlib.sha256(ipa.read_bytes()).hexdigest(),
                'minimum_ios': '15.0', 'architecture': 'arm64', 'bundle_id': info['CFBundleIdentifier'],
                'purpose': 'configuration recovery, diagnostics, UUID-gated read-only snapshots, smite simulation, global live HUD and calibrated enemy minimap markers',
                'game_functions_implemented': False, 'device_runtime_verified': False,
                'read_only_snapshot_implemented': True, 'read_only_snapshot_device_verified': False,
                'prior_actor_snapshot_device_evidence_version': '0.5.0',
                'prior_position_and_skill_reads_succeeded': True,
                'prior_position_and_skill_device_evidence_version': '0.5.0',
                'prior_class_stock_slot_cast_reads_succeeded': True,
                'prior_class_stock_slot_cast_device_evidence_version': '0.5.0',
                'read_only_smite_preview_implemented': True, 'smite_preview_device_verified': False,
                'read_only_global_hud_implemented': True, 'global_hud_device_verified': False,
                'prior_global_hud_launch_device_evidence_version': '0.6.0',
                'prior_global_hud_launch_and_status_succeeded': True,
                'prior_global_hud_visible_and_updating_user_confirmed': True,
                'prior_global_hud_orientation_and_touch_passthrough_user_confirmed': True,
                'hud_sampling_telemetry_implemented': True, 'hud_sampling_telemetry_device_verified': False,
                'prior_hud_sampling_telemetry_device_evidence_version': '0.6.1',
                'prior_hud_sampling_telemetry_reads_succeeded': True,
                'minimap_overlay_implemented': True, 'minimap_alignment_device_verified': False,
                'prior_minimap_device_evidence_version': '0.7.0',
                'prior_minimap_native_projection_user_observed': True,
                'prior_unseen_enemy_updates_user_confirmed': True,
                'minimap_device_evidence': 'analysis/device-0.7.0-summary.json',
                'minimap_fog_observation_scope': 'User observation in the tested scene; not a five-enemy match or server-position verification',
                'minimap_recommended_rect_percent': [6.8, 1.2, 15.5, 33.5],
                'minimap_recommended_rect_source': 'Estimated from a cropped user screenshot; user accepts 0.7.1 alignment in the tested scene',
                'prior_minimap_alignment_evidence_version': '0.7.1',
                'prior_minimap_alignment_acceptable_user_confirmed': True,
                'prior_minimap_alignment_evidence': 'analysis/device-0.7.1-summary.json',
                'hud_info_panel_default_visible': False,
                'minimap_local_reference_default_visible': False,
                'hud_sampling_interval_seconds': 0.15,
                'minimap_motion_interpolation_implemented': True,
                'minimap_motion_preferred_display_fps': 60,
                'minimap_motion_device_verified': False,
                'app_icon_implemented': True,
                'minimap_hero_portraits_implemented': True,
                'minimap_hero_portrait_count': len(json.loads((ROOT / 'ios/Assets/Heroes/manifest.json').read_text())['heroes']),
                'minimap_hero_portraits_device_verified': False,
                'minimap_hero_portrait_unknown_fallback': 'numeric marker',
                'minimap_saved_custom_rect_preserved': True,
                'minimap_expected_enemy_roster': 'Observed confirmed enemy heroes; never pads or truncates to five',
                'minimap_telemetry_protocol_version': 3,
                'minimap_health_ring_implemented': True,
                'minimap_health_ring_source': 'Identity-checked native current/max attributes selected by FEProj useDataSyncObject; validated visible minimap UI percentage is fallback',
                'minimap_native_health_profile_uuid': 'D5B32037-47A3-3EFF-B0E5-04B071EFBEE3',
                'minimap_native_health_layout_evidence': 'analysis/ios-native-health-layout.json',
                'minimap_native_health_device_verified': False,
                'minimap_health_ring_device_verified': False,
                'prior_minimap_native_health_device_evidence_version': '0.7.6',
                'prior_minimap_native_health_reads_succeeded': True,
                'prior_minimap_health_ring_user_confirmed': True,
                'minimap_unknown_health_ring': 'gray',
                'minimap_max_health_inferred': False,
                'minimap_history_position_fallback': False,
                'minimap_coordinate_candidates_used_for_overlay': False,
                'minimap_fog_disappearance_resolved': False,
                'minimap_logic_position_reader_implemented': True,
                'minimap_logic_position_layout_version': 2,
                'minimap_logic_position_device_verified': False,
                'minimap_logic_position_layout_evidence': 'analysis/ios-native-logic-position-layout.json',
                'minimap_logic_position_source': 'Current independent native logic actor matched to sync hero by object ID, resource ID and camp; Q14 transform decoded with the current engine XOR key',
                'minimap_latest_device_evidence': 'analysis/device-0.7.7-summary.json',
                'minimap_latest_device_issue': '0.7.7 probe and all 32 trace samples fail logic_lookup_layout_mismatch before reading any logical actor. Original-code analysis identifies the wrong resource root/manager. 0.7.8 uses the runtime frame battle and constructor-verified ActorMgr layout; live fog verification is pending.',
                'minimap_coordinate_trace_implemented': True,
                'minimap_coordinate_trace_device_verified': False,
                'prior_minimap_coordinate_trace_device_evidence_version': '0.7.4',
                'prior_minimap_coordinate_trace_transport_observed': True,
                'minimap_coordinate_trace_limits': {'interval_seconds':1,'samples':32,'heroes_per_sample':16,'file_bytes':524288},
                'native_engine_collection_implemented': True,
                'native_engine_collection_device_verified': True,
                'native_engine_collection_device_evidence_version': '0.7.5',
                'native_engine_input_sha256': '76c505959d300935c055d3212bc73b247dbc72a76e0afc82e2b14b92dc78c96f',
                'native_engine_collection_archive': 'lvlolm-ios-engine.zip',
                'native_engine_collection_scope': 'Loaded on-disk FEProj and its Info.plist only; no decryption or memory dump',
                'native_engine_analysis_pending_input': False,
                'clang_version': subprocess.check_output([clang, '--version'], text=True).splitlines()[0],
                'sdk': sdk.name, 'files': {str(f.relative_to(app)): hashlib.sha256(f.read_bytes()).hexdigest()
                                         for f in sorted(app.rglob('*')) if f.is_file()}}
    (dist / 'build-metadata.json').write_text(json.dumps(metadata, ensure_ascii=False, indent=2) + '\n')
    (dist / ('build-metadata-' + info['CFBundleShortVersionString'] + '.json')).write_text(
        json.dumps(metadata, ensure_ascii=False, indent=2) + '\n')
    print(f'Built: {ipa}')


if __name__ == '__main__':
    p = argparse.ArgumentParser()
    p.add_argument('--sdk', type=Path, default=ROOT / 'toolchain/iPhoneOS16.5.sdk')
    p.add_argument('--clang', default=shutil.which('clang-21') or shutil.which('clang'))
    p.add_argument('--linker', default=shutil.which('ld64.lld-21') or shutil.which('ld64.lld'))
    p.add_argument('--ldid', default=str(ROOT / 'toolchain/ldid'))
    a = p.parse_args()
    if not a.clang or not a.linker: p.error('A clang compiler and Mach-O lld linker are required')
    build(a.sdk.resolve(), a.clang, a.linker, a.ldid)
