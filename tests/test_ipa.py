#!/usr/bin/env python3
"""Artifact integrity and negative parser checks; no device runtime claims."""
import importlib.util
import json
import plistlib
import struct
import unittest
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
VERSION = plistlib.loads((ROOT / 'ios/Info.plist').read_bytes())['CFBundleShortVersionString']
spec = importlib.util.spec_from_file_location('inspector', ROOT / 'tools/inspect_ios_target.py')
inspector = importlib.util.module_from_spec(spec)
spec.loader.exec_module(inspector)


class IPATests(unittest.TestCase):
    def test_real_ipa_integrity(self):
        report = inspector.inspect_path(ROOT / ('dist/lvlolm-recovery-' + VERSION + '.ipa'))
        self.assertEqual(report['bundle_identifier'], 'local.lvlolm.recovery')
        self.assertEqual(len(report['images']), 3)
        banned = {'com.apple.private.cs.debugger', 'dynamic-codesigning', 'com.apple.private.skip-library-validation'}
        for images in report['images'].values():
            self.assertEqual(len(images), 1)
            image = images[0]
            self.assertEqual(image['architecture'], 'arm64')
            self.assertEqual(image['platform'], 2)
            self.assertEqual(image['minimum_os'], '15.0.0')
            self.assertFalse(image['encrypted'])
            signature = image['signature']
            self.assertTrue(signature['code_directories'])
            self.assertTrue(all(d['page_hashes_valid'] and d['entitlement_hash_valid']
                                for d in signature['code_directories']))
            self.assertFalse(banned.intersection(signature['entitlements']))

    def test_modified_executable_detected(self):
        data = bytearray((ROOT / 'build/Payload/LVRecovery.app/LVRecovery').read_bytes())
        metadata = inspector.inspect_macho(data)[0]
        text = next(s for s in metadata['sections'] if s['name'] == '__text')
        data[text['file_offset']] ^= 1
        altered = inspector.inspect_macho(data)[0]
        self.assertFalse(altered['signature']['code_directories'][0]['page_hashes_valid'])

    def test_bad_header_and_commands(self):
        for data in (b'', b'\x7fELF' + bytes(64),
                     struct.pack('<8I', 0xfeedfacf, 0x100000c, 0, 2, 1, 1000, 0, 0),
                     struct.pack('<8I', 0xfeedfacf, 0x100000c, 0, 2, 1, 8, 0, 0) + struct.pack('<II', 0x19, 0)):
            with self.assertRaises(ValueError): inspector.inspect_macho(data)

    def test_encryption_report(self):
        # A well-formed metadata-only fixture must never be marked decrypted.
        data = struct.pack('<8I', 0xfeedfacf, 0x100000c, 0, 2, 1, 24, 0, 0)
        data += struct.pack('<6I', 0x2c, 24, 0, 0, 1, 0)
        self.assertTrue(inspector.inspect_macho(data)[0]['encrypted'])

    def test_hud_identity_permissions_and_license(self):
        report = inspector.inspect_path(ROOT / ('dist/lvlolm-recovery-' + VERSION + '.ipa'))
        image = report['images']['Payload/LVRecovery.app/LVHUD'][0]
        entitlements = image['signature']['entitlements']
        self.assertEqual(entitlements['application-identifier'], 'local.lvlolm.recovery.hud')
        for key in ('task_for_pid-allow', 'platform-application', 'com.apple.QuartzCore.displayable-context',
                    'com.apple.backboard.client', 'com.apple.springboard.accessibility-window-hosting'):
            self.assertTrue(entitlements[key])
        self.assertNotIn('com.apple.private.hid.client.event-dispatch', entitlements)
        self.assertNotIn('com.apple.springboard.disallowControlCenter', entitlements)
        with zipfile.ZipFile(ROOT / ('dist/lvlolm-recovery-' + VERSION + '.ipa')) as z:
            self.assertEqual(z.read('Payload/LVRecovery.app/TrollSpeed-LICENSE.txt'),
                             (ROOT / 'ios/TrollSpeed-LICENSE.txt').read_bytes())


if __name__ == '__main__': unittest.main()
