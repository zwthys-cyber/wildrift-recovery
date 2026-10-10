#!/usr/bin/env python3
"""Read this game's custom metadata through its recovered loader rules.

Does not execute the framework, modify inputs or create a decrypted game image.
The profile is tied to one UUID and exact SHA-256 values. The small stream
transform and per-string transform are transcribed from the ARM64 loader;
table records are independently checked before names are read.
"""
from __future__ import annotations
import argparse
import hashlib
import json
import re
import struct
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
FRAMEWORK_SHA256 = 'effa95dbbc2bf16f9474c7c99700b80b3e0b7c793537e2da7089bd01b6a5e394'
FRAMEWORK_UUID = '085E1DDF-4A8D-34E2-9D73-A0A28BCC0B83'
METADATA_SHA256 = '0ea4de1fdba5924e75f09a10911692c833ae996ec3df773aba4d9b32c39f90e3'
MASK = 0xffffffff


def stream_block(state):
    if len(state) != 16 or any(not 0 <= v <= MASK for v in state):
        raise ValueError('Expected sixteen uint32 state words')
    work = list(state)

    def rotate(value, count):
        return ((value << count) | (value >> (32 - count))) & MASK

    def quarter(a, b, c, d):
        work[a] = (work[a] + work[b]) & MASK
        work[d] = rotate(work[d] ^ work[a], 16)
        work[c] = (work[c] + work[d]) & MASK
        work[b] = rotate(work[b] ^ work[c], 12)
        work[a] = (work[a] + work[b]) & MASK
        work[d] = rotate(work[d] ^ work[a], 8)
        work[c] = (work[c] + work[d]) & MASK
        work[b] = rotate(work[b] ^ work[c], 7)

    for _ in range(10):
        for indices in ((0, 4, 8, 12), (1, 5, 9, 13), (2, 6, 10, 14),
                        (3, 7, 11, 15), (0, 5, 10, 15), (1, 6, 11, 12),
                        (2, 7, 8, 13), (3, 4, 9, 14)):
            quarter(*indices)
    return struct.pack('<16I', *((a + b) & MASK for a, b in zip(work, state)))


class Metadata:
    def __init__(self, metadata, framework, verify=True):
        self.data = bytes(metadata)
        if verify and hashlib.sha256(framework).hexdigest() != FRAMEWORK_SHA256:
            raise ValueError('Framework does not match the recovered profile')
        if verify and hashlib.sha256(self.data).hexdigest() != METADATA_SHA256:
            raise ValueError('Metadata does not match the recovered profile')
        if len(self.data) < 256 or self.data[:8] != b'FMN!\x1f\0\0\0':
            raise ValueError('Expected the recovered FMN! v31 metadata header')
        if len(framework) < 0x102396d4:
            raise ValueError('Framework is too short for loader constants')
        state = (list(struct.unpack_from('<4I', framework, 0xeda2890)) +
                 list(struct.unpack_from('<8I', framework, 0x102396b4)) + [0, 0] +
                 list(struct.unpack_from('<2I', framework, 0x102396b4)))
        header = bytearray(self.data[:256])
        header[8:40] = bytes(a ^ b for a, b in zip(header[8:40], stream_block(state)))
        self.header = bytes(header)
        self.keys = bytes(framework[0x10239480:0x10239580])
        self.string_offset, self.string_size = struct.unpack_from('<II', self.header, 0x1c)
        self._range(self.string_offset, self.string_size)
        self.tables = {}
        for name, position, stride in (('fields', 0x60, 12), ('methods', 0x30, 36),
                                      ('types', 0xa0, 88), ('images', 0xa8, 40),
                                      ('assemblies', 0xb0, 64)):
            offset, size = struct.unpack_from('<II', self.header, position)
            self._range(offset, size)
            if size % stride: raise ValueError(f'Invalid {name} record size')
            self.tables[name] = {'offset': offset, 'size': size, 'stride': stride,
                                 'count': size // stride}
        self.cache = {}

    def _range(self, offset, size):
        if offset > len(self.data) or size > len(self.data) - offset:
            raise ValueError('Metadata table exceeds the input')

    def record(self, table, index, fmt):
        layout = self.tables[table]
        if not 0 <= index < layout['count']: raise ValueError(f'Invalid {table} index')
        if struct.calcsize(fmt) != layout['stride']: raise ValueError('Wrong record format')
        return struct.unpack_from(fmt, self.data, layout['offset'] + index * layout['stride'])

    def name(self, index):
        if index in self.cache: return self.cache[index]
        if not 0 <= index < self.string_size: raise ValueError('String index exceeds heap')
        start = (((self.string_offset + index) * self.string_size) & MASK) % 73043
        key_index = (start & 15) << 4
        out = bytearray()
        for i in range(min(16384, self.string_size - index)):
            value = self.data[self.string_offset + index + i] ^ self.keys[(key_index + i) & 255]
            if not value:
                text = out.decode('utf-8')
                self.cache[index] = text
                return text
            out.append(value)
        raise ValueError('String has no terminator within the bounded read')

    def images(self):
        result = []
        for i in range(self.tables['images']['count']):
            words = self.record('images', i, '<10i')
            start, count = words[2:4]
            if not 0 <= start <= self.tables['types']['count'] or not 0 <= count <= self.tables['types']['count'] - start:
                raise ValueError('Image type range exceeds the table')
            result.append({'index': i, 'name': self.name(words[0]), 'assembly_index': words[1],
                           'type_start': start, 'type_count': count})
        return result

    def type(self, index):
        words = self.record('types', index, '<16i8H2I')
        result = {'index': index, 'name': self.name(words[0]), 'namespace': self.name(words[1]),
                  'byval_type_index': words[2], 'declaring_type_index': words[3],
                  'parent_type_index': words[4], 'flags': words[7],
                  'field_start': words[8], 'method_start': words[9],
                  'method_count': words[16], 'field_count': words[18],
                  'bitfield': words[24], 'token': words[25]}
        for table, start_key, count_key in (('fields', 'field_start', 'field_count'),
                                            ('methods', 'method_start', 'method_count')):
            count, start = result[count_key], result[start_key]
            if count and not 0 <= start <= self.tables[table]['count'] - count:
                raise ValueError(f'Type {index} has an invalid {table} range')
        return result

    def fields(self, type_record):
        fields = []
        for i in range(type_record['field_count']):
            index = type_record['field_start'] + i
            name, type_index, token = self.record('fields', index, '<IiI')
            fields.append({'index': index, 'name': self.name(name), 'type_index': type_index,
                           'token': token})
        return fields

    def methods(self, type_record):
        methods = []
        for i in range(type_record['method_count']):
            index = type_record['method_start'] + i
            words = self.record('methods', index, '<I5iI4H')
            if words[1] != type_record['index']: raise ValueError('Method declaring type mismatch')
            methods.append({'index': index, 'name': self.name(words[0]), 'return_type_index': words[2],
                            'token': words[6], 'flags': words[7], 'parameter_count': words[10]})
        return methods


class NativeTables:
    """Registration tables verified in the same framework, before rebasing."""
    def __init__(self, framework, metadata):
        self.data, self.metadata = framework, metadata
        # 0xd8f6724 -> il2cpp_codegen_register, x0/x1 registration arguments.
        self.code_registration, self.metadata_registration = 0xfc1e1f8, 0xfe40a58
        self.type_count, self.types = self.read(self.metadata_registration + 0x30, '<QQ')
        self.offset_count, self.offsets = self.read(self.metadata_registration + 0x50, '<QQ')
        if self.offset_count != metadata.tables['types']['count'] or not 0 < self.type_count < 1000000:
            raise ValueError('Registration counts do not match metadata')
        count, modules = self.read(self.code_registration + 0x78, '<QQ')
        if count != metadata.tables['images']['count']: raise ValueError('Module count mismatch')
        self.modules = {}
        for i in range(count):
            pointer, = self.read(modules + i * 8, '<Q')
            name_pointer, methods, method_table = self.read(pointer, '<QQQ')
            end = framework.find(b'\0', name_pointer, min(name_pointer + 256, len(framework)))
            if end < 0: raise ValueError('Invalid module name')
            name = framework[name_pointer:end].decode('ascii')
            if name in self.modules: raise ValueError('Duplicate codegen module')
            self.modules[name] = {'address': pointer, 'method_count': methods, 'method_table': method_table}

    def read(self, address, fmt):
        # In this exact profile TEXT, DATA_CONST and file-backed DATA have
        # vmaddr == fileoff. Reject pointers into zerofill/LINKEDIT explicitly.
        size = struct.calcsize(fmt)
        if address < 0 or address + size > 278413312 or address + size > len(self.data):
            raise ValueError('Native registration read exceeds file-backed segments')
        return struct.unpack_from(fmt, self.data, address)

    def type(self, index):
        if not 0 <= index < self.type_count: raise ValueError('Invalid native type index')
        pointer, = self.read(self.types + index * 8, '<Q')
        data, bits = self.read(pointer, '<QI')
        return {'data': data, 'attributes': bits & 65535, 'kind': (bits >> 16) & 255}

    def fields(self, record):
        pointer, = self.read(self.offsets + record['index'] * 8, '<Q')
        result = self.metadata.fields(record)
        for i, field in enumerate(result):
            offset, = self.read(pointer + i * 4, '<i')
            native_type = self.type(field['type_index'])
            field.update(offset=offset, static=bool(native_type['attributes'] & 0x10),
                         literal=bool(native_type['attributes'] & 0x40), native_type=native_type)
        return result

    def methods(self, record):
        image = next((i for i in self.metadata.images()
                      if i['type_start'] <= record['index'] < i['type_start'] + i['type_count']), None)
        if image is None: raise ValueError('Type has no declaring image')
        module = self.modules[image['name']]
        result = self.metadata.methods(record)
        for method in result:
            rid = method['token'] & 0xffffff
            if method['token'] >> 24 != 6 or not 1 <= rid <= module['method_count']:
                raise ValueError('Method token exceeds its declaring module')
            pointer, = self.read(module['method_table'] + (rid - 1) * 8, '<Q')
            method.update(native_address=pointer, declaring_module=image['name'])
        return result


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--framework', type=Path, default=ROOT / 'inputs/ios-0.2.0/Bundle/Frameworks/UnityFramework.framework/UnityFramework')
    p.add_argument('--metadata', type=Path, default=ROOT / 'inputs/ios-0.2.0/Bundle/Data/Managed/Metadata/global-metadata.dat')
    p.add_argument('--output', type=Path, default=ROOT / 'build/ios-metadata.json')
    p.add_argument('--match', default=r'actor|hero|monster|smite|mercury|skill|cooldown|battle|buff|gameworld|gamemanager|player')
    args = p.parse_args()
    fw, raw = args.framework.read_bytes(), args.metadata.read_bytes()
    metadata = Metadata(raw, fw)
    native = NativeTables(fw, metadata)
    images, types, selected = metadata.images(), [], []
    pattern = re.compile(args.match, re.IGNORECASE)
    for i in range(metadata.tables['types']['count']):
        record = metadata.type(i)
        types.append(record)
        if pattern.search(record['namespace'] + '.' + record['name']):
            selected.append(dict(record, fields=native.fields(record), methods=native.methods(record)))
    report = {'framework_uuid': FRAMEWORK_UUID, 'framework_sha256': hashlib.sha256(fw).hexdigest(),
              'metadata_sha256': hashlib.sha256(raw).hexdigest(), 'metadata_format': 'FMN! v31',
              'table_layouts': metadata.tables, 'string_heap': {'offset': metadata.string_offset, 'size': metadata.string_size},
              'images': images, 'types': types, 'selected_types': selected,
              'registration': {'code': native.code_registration, 'metadata': native.metadata_registration},
              'scope': 'Offline names, managed field offsets and method addresses. Live object pointers and native C++ member semantics require separate verification.'}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps({'output': str(args.output), 'tables': metadata.tables,
                      'matched_types': len(selected), 'decoded_names': len(metadata.cache)}, ensure_ascii=False))


if __name__ == '__main__': main()
