#!/usr/bin/env python3
"""Artifact integrity and negative parser checks; no device runtime claims."""
import importlib.util
import json
import plistlib
import struct
import unittest
import zipfile
import zlib
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
VERSION = plistlib.loads((ROOT / 'ios/Info.plist').read_bytes())['CFBundleShortVersionString']
spec = importlib.util.spec_from_file_location('inspector', ROOT / 'tools/inspect_ios_target.py')
inspector = importlib.util.module_from_spec(spec)
spec.loader.exec_module(inspector)


def png_info(data):
    if data[:8] != b'\x89PNG\r\n\x1a\n': raise ValueError('Not PNG')
    offset = 8; header = None; pixels = bytearray(); ended = False
    while offset < len(data):
        size = struct.unpack_from('>I', data, offset)[0]
        kind = data[offset+4:offset+8]; body = data[offset+8:offset+8+size]
        if offset+12+size > len(data): raise ValueError('Truncated PNG')
        crc = struct.unpack_from('>I', data, offset+8+size)[0]
        if zlib.crc32(kind+body) & 0xffffffff != crc: raise ValueError('PNG CRC mismatch')
        if kind == b'IHDR': header = struct.unpack('>IIBBBBB', body)
        if kind == b'IDAT': pixels.extend(body)
        offset += 12+size
        if kind == b'IEND': ended = True; break
    if not header or not pixels or not ended or offset != len(data): raise ValueError('Incomplete PNG')
    raw = zlib.decompress(pixels)
    if not raw: raise ValueError('No PNG pixels')
    return header


class IPATests(unittest.TestCase):
    def test_real_ipa_integrity(self):
        report = inspector.inspect_path(ROOT / ('dist/wildrift-recovery-' + VERSION + '.ipa'))
        self.assertEqual(report['bundle_identifier'], 'local.wildrift.recovery')
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
        report = inspector.inspect_path(ROOT / ('dist/wildrift-recovery-' + VERSION + '.ipa'))
        image = report['images']['Payload/LVRecovery.app/LVHUD'][0]
        entitlements = image['signature']['entitlements']
        self.assertEqual(entitlements['application-identifier'], 'local.wildrift.recovery.hud')
        for key in ('task_for_pid-allow', 'platform-application', 'com.apple.QuartzCore.displayable-context',
                    'com.apple.backboard.client', 'com.apple.springboard.accessibility-window-hosting'):
            self.assertTrue(entitlements[key])
        self.assertNotIn('com.apple.private.hid.client.event-dispatch', entitlements)
        self.assertNotIn('com.apple.springboard.disallowControlCenter', entitlements)
        with zipfile.ZipFile(ROOT / ('dist/wildrift-recovery-' + VERSION + '.ipa')) as z:
            self.assertEqual(z.read('Payload/LVRecovery.app/TrollSpeed-LICENSE.txt'),
                             (ROOT / 'ios/TrollSpeed-LICENSE.txt').read_bytes())

    def test_desktop_icon_files(self):
        # Verify actual opaque PNGs, dimensions and both device-family plist entries.
        sizes = {'AppIcon20@2x':40, 'AppIcon20@3x':60, 'AppIcon29@2x':58, 'AppIcon29@3x':87,
                 'AppIcon40@2x':80, 'AppIcon40@3x':120, 'AppIcon60@2x':120, 'AppIcon60@3x':180,
                 'AppIcon76':76, 'AppIcon76@2x':152, 'AppIcon83.5@2x':167, 'AppIcon1024':1024}
        base = 'Payload/LVRecovery.app/'
        with zipfile.ZipFile(ROOT / ('dist/wildrift-recovery-' + VERSION + '.ipa')) as z:
            info = plistlib.loads(z.read(base + 'Info.plist'))
            self.assertIn('AppIcon60', info['CFBundleIcons']['CFBundlePrimaryIcon']['CFBundleIconFiles'])
            self.assertIn('AppIcon83.5', info['CFBundleIcons~ipad']['CFBundlePrimaryIcon']['CFBundleIconFiles'])
            for name, side in sizes.items():
                data = z.read(base + name + '.png'); header = png_info(data)
                self.assertEqual(header[:4], (side, side, 8, 2))  # RGB, no alpha channel
                self.assertEqual(data, (ROOT / 'ios/Assets/AppIcon' / (name+'.png')).read_bytes())

    def test_hero_catalog_and_image_payloads(self):
        import hashlib
        base = 'Payload/LVRecovery.app/Assets/Heroes/'
        with zipfile.ZipFile(ROOT / ('dist/wildrift-recovery-' + VERSION + '.ipa')) as z:
            manifest = json.loads(z.read(base + 'manifest.json'))
            source = (ROOT / 'analysis/official-hero-list.json').read_bytes()
            self.assertEqual(hashlib.sha256(source).hexdigest(), manifest['source_sha256'])
            catalog = json.loads(source)['heroList']
            self.assertEqual(set(catalog), set(manifest['heroes']))
            self.assertGreater(len(catalog), 100)
            for rid, record in manifest['heroes'].items():
                self.assertEqual(rid, catalog[rid]['heroId'])
                self.assertEqual(record['name'], catalog[rid]['name'])
                self.assertEqual(record['url'], catalog[rid]['avatar'])
                self.assertEqual(Path(record['file']).name, record['file'])
                data = z.read(base + record['file'])
                self.assertEqual(hashlib.sha256(data).hexdigest(), record['sha256'])
                self.assertEqual(png_info(data)[:2], tuple(record['dimensions']))
            pngs = [n for n in z.namelist() if n.startswith(base) and n.endswith('.png')]
            self.assertEqual(len(pngs), len(catalog))

    def test_exact_resource_id_mapping(self):
        # Known IDs from the supplied device reports match the official directory.
        heroes = json.loads((ROOT / 'ios/Assets/Heroes/manifest.json').read_bytes())['heroes']
        for rid, name in {'10001':'盖伦', '10055':'卡蜜尔', '10063':'婕拉',
                          '10094':'艾瑞莉娅', '10098':'伊泽瑞尔'}.items():
            self.assertEqual(heroes[rid]['name'], name)
        for rid in ('0', '-1', '99999', '820101', '810202'):
            self.assertIsNone(heroes.get(rid))


if __name__ == '__main__': unittest.main()
