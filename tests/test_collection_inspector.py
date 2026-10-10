#!/usr/bin/env python3
import importlib.util
import json
import struct
import tempfile
import unittest
import uuid
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('inspector', ROOT / 'tools/inspect_ios_target.py')
inspector = importlib.util.module_from_spec(spec)
spec.loader.exec_module(inspector)
UNITY_UUID = '085E1DDF-4A8D-34E2-9D73-A0A28BCC0B83'


def image(image_uuid, cryptid):
    commands = struct.pack('<II16s', 0x1b, 24, uuid.UUID(image_uuid).bytes)
    commands += struct.pack('<6I', 0x2c, 24, 0, 0, cryptid, 0)
    return struct.pack('<8I', 0xfeedfacf, 0x100000c, 0, 6, 2, len(commands), 0, 0) + commands


class CollectionTests(unittest.TestCase):
    def export_fixture(self, path, unsafe=False, wrong_uuid=False):
        framework = 'Bundle/../escape' if unsafe else 'Bundle/Frameworks/UnityFramework.framework/UnityFramework'
        main = 'Bundle/lolm'
        metadata = 'Bundle/Data/Managed/Metadata/global-metadata.dat'
        payloads = {framework: image(UNITY_UUID, 0), main: image('34D7B1EF-409C-3BF1-BEC4-122FFAB05100', 1),
                    metadata: struct.pack('<II', 0xfab11baf, 29) + bytes(64)}
        files = [{'archive_path': name, 'size': len(value), 'source_path': '/device/' + name,
                  'role': role} for (name, value), role in zip(payloads.items(), ['unity_framework', 'main_executable', 'il2cpp_metadata'])]
        manifest = {'format': 'lvlolm-ios-inputs', 'format_version': 1, 'files': files,
            'device_images': [{'path': '/device/' + framework, 'uuid': '00000000-0000-0000-0000-000000000000' if wrong_uuid else UNITY_UUID}],
            'bundle_identifier': 'fixture.game', 'collection_mode': 'unchanged on-disk files'}
        with zipfile.ZipFile(path, 'w') as archive:
            archive.writestr('manifest.json', json.dumps(manifest))
            for name, data in payloads.items(): archive.writestr(name, data)
        return framework, main

    def test_uuid_and_encryption_and_metadata(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'inputs.zip'
            framework, main = self.export_fixture(path)
            report = inspector.inspect_path(path)
            self.assertTrue(report['images'][framework][0]['uuid_matches_device'])
            self.assertFalse(report['images'][framework][0]['encrypted'])
            self.assertTrue(report['images'][main][0]['encrypted'])
            self.assertTrue(report['metadata_files'][0]['standard_il2cpp_magic'])
            self.assertEqual(report['metadata_files'][0]['header_version'], 29)

    def test_mismatched_framework_uuid_reported(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'inputs.zip'
            framework, _ = self.export_fixture(path, wrong_uuid=True)
            self.assertFalse(inspector.inspect_path(path)['images'][framework][0]['uuid_matches_device'])

    def test_unsafe_paths_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'inputs.zip'
            self.export_fixture(path, unsafe=True)
            with self.assertRaises(ValueError): inspector.inspect_path(path)


if __name__ == '__main__': unittest.main()
