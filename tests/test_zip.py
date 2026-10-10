#!/usr/bin/env python3
"""Independent Python ZIP-reader checks for the native streaming exporter."""
import struct
import subprocess
import tempfile
import unittest
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


class ExportZipTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        (ROOT / 'build').mkdir(exist_ok=True)
        cls.fixture = ROOT / 'build/zip_fixture'
        subprocess.run(['gcc', '-std=c11', '-D_POSIX_C_SOURCE=200809L', '-Wall', '-Wextra', '-Werror',
            '-fsanitize=address,undefined', '-fno-omit-frame-pointer', '-fno-pie', '-no-pie', '-g',
            '-I' + str(ROOT / 'core'), str(ROOT / 'core/LVZip.c'), str(ROOT / 'tests/zip_fixture.c'),
            '-lz', '-o', str(cls.fixture)], check=True)

    def test_cross_reader_contents(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            payload = bytes(range(256)) * 900
            source, output = root / 'source with spaces', root / 'export.zip'
            source.write_bytes(payload)
            subprocess.run([str(self.fixture), 'valid', str(output), str(source)], check=True)
            with zipfile.ZipFile(output) as z:
                self.assertIsNone(z.testzip())
                self.assertEqual(z.read('manifest.json'), b'{"fixture":true}\n')
                self.assertEqual(z.read('Bundle/Frameworks/UnityFramework'), payload)
                self.assertEqual(z.read('empty.dat'), b'')
                self.assertEqual(z.read('测试.dat'), bytes([0, 255, 10, 128, 0, 42]))
                self.assertTrue(all(i.compress_type == zipfile.ZIP_STORED for i in z.infolist()))

    def test_rejected_inputs_and_limit(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            source = root / 'source'
            source.write_bytes(b'not game code')
            link = root / 'link'
            link.symlink_to(source)
            large = root / 'sparse'
            with large.open('wb') as f: f.truncate(1024 * 1024 * 1024 + 1)
            cases = [('traversal', source), ('duplicate', source), ('missing', root / 'missing'),
                     ('symlink', link), ('directory', root), ('large', large), ('limit', source)]
            for mode, input_path in cases:
                with self.subTest(mode=mode):
                    subprocess.run([str(self.fixture), mode, str(root / 'output.zip'), str(input_path)], check=True)

    def test_corruption_is_detected(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            source, output = root / 'source', root / 'archive.zip'
            source.write_bytes(b'reference payload')
            subprocess.run([str(self.fixture), 'valid', str(output), str(source)], check=True)
            with zipfile.ZipFile(output) as z: info = z.getinfo('Bundle/Frameworks/UnityFramework')
            data = bytearray(output.read_bytes())
            name_size, extra_size = struct.unpack_from('<HH', data, info.header_offset + 26)
            data[info.header_offset + 30 + name_size + extra_size] ^= 1
            output.write_bytes(data)
            with zipfile.ZipFile(output) as z:
                self.assertEqual(z.testzip(), info.filename)


if __name__ == '__main__': unittest.main()
