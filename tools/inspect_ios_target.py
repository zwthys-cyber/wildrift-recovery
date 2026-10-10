#!/usr/bin/env python3
"""Inspect an IPA or Mach-O without executing or modifying it.

Reports UUIDs, encryption state, load commands, text sections, and function
starts. An encrypted code section is not disassembled or claimed recovered.
"""
from __future__ import annotations
import argparse
import hashlib
import json
import math
import plistlib
import struct
import uuid
import zipfile
from pathlib import Path


def cstr(data, offset=0):
    if not 0 <= offset < len(data): return ''
    return data[offset:].split(b'\0', 1)[0].decode('utf-8', errors='replace')


def slices(data):
    if data[:4] == b'\xcf\xfa\xed\xfe': return [(0, data)]
    if len(data) < 8: raise ValueError('File is too short for Mach-O')
    magic = data[:4]
    layouts = {b'\xca\xfe\xba\xbe': ('>', False), b'\xca\xfe\xba\xbf': ('>', True),
               b'\xbe\xba\xfe\xca': ('<', False), b'\xbf\xba\xfe\xca': ('<', True)}
    if magic not in layouts: raise ValueError('Expected 64-bit Mach-O or universal binary')
    endian, wide = layouts[magic]
    count = struct.unpack_from(endian + 'I', data, 4)[0]
    stride = 32 if wide else 20
    if count > 64 or 8 + count * stride > len(data): raise ValueError('Invalid universal header')
    result = []
    for i in range(count):
        record = struct.unpack_from(endian + ('IIQQII' if wide else 'IIIII'), data, 8 + i * stride)
        offset, size = record[2:4]
        if offset > len(data) or size > len(data) - offset: raise ValueError('Slice exceeds file')
        chunk = data[offset:offset + size]
        if chunk[:4] == b'\xcf\xfa\xed\xfe': result.append((offset, chunk))
    if not result: raise ValueError('No 64-bit Mach-O slices found')
    return result


def version(v): return '.'.join(str(n) for n in (v >> 16, (v >> 8) & 255, v & 255))


def signature_report(data, offset, size):
    blob = data[offset:offset + size]
    if len(blob) < 12: raise ValueError('Truncated signature')
    magic, length, count = struct.unpack_from('>III', blob)
    if magic != 0xfade0cc0 or length > len(blob) or count > 64 or 12 + count * 8 > length:
        raise ValueError('Invalid embedded signature header')
    code_directories, entitlements = [], None
    for i in range(count):
        slot, start = struct.unpack_from('>II', blob, 12 + i * 8)
        if start + 8 > length: raise ValueError('Signature sub-blob exceeds signature')
        child_magic, child_size = struct.unpack_from('>II', blob, start)
        if child_size < 8 or start + child_size > length: raise ValueError('Invalid signature sub-blob size')
        child = blob[start:start + child_size]
        if slot == 5 and child_magic == 0xfade7171:
            entitlements = plistlib.loads(child[8:])
        if child_magic != 0xfade0c02: continue
        if len(child) < 44: raise ValueError('Truncated CodeDirectory')
        (_, _, ver, flags, hash_off, ident_off, special, pages, limit,
         hash_size, hash_type, platform, page_log) = struct.unpack_from('>9I4B', child)
        hash_functions = {1: hashlib.sha1, 2: hashlib.sha256, 3: hashlib.sha256, 4: hashlib.sha384}
        if hash_type not in hash_functions or page_log > 30 or limit > offset:
            raise ValueError('Unsupported or invalid CodeDirectory hash layout')
        page_bytes = 1 << page_log if page_log else max(limit, 1)
        if pages != math.ceil(limit / page_bytes) or hash_off + pages * hash_size > len(child):
            raise ValueError('Invalid code page hash table')
        page_ok = all(
            hash_functions[hash_type](data[n * page_bytes:min((n + 1) * page_bytes, limit)]).digest()[:hash_size] ==
            child[hash_off + n * hash_size:hash_off + (n + 1) * hash_size]
            for n in range(pages))
        ent_ok = None
        if special >= 5:
            entry = next((struct.unpack_from('>II', blob, 12 + n * 8)[1]
                          for n in range(count) if struct.unpack_from('>I', blob, 12 + n * 8)[0] == 5), None)
            if entry is not None:
                elen = struct.unpack_from('>I', blob, entry + 4)[0]
                expected = hash_functions[hash_type](blob[entry:entry + elen]).digest()[:hash_size]
                ent_ok = expected == child[hash_off - 5 * hash_size:hash_off - 4 * hash_size]
        code_directories.append({'version': hex(ver), 'flags': hex(flags),
            'identifier': cstr(child, ident_off), 'hash_type': hash_type, 'code_pages': pages,
            'page_hashes_valid': page_ok, 'entitlement_hash_valid': ent_ok})
    return {'code_directories': code_directories, 'entitlements': entitlements}


def inspect_macho(data):
    results = []
    for file_offset, chunk in slices(data):
        chunk = bytes(chunk)
        if len(chunk) < 32: raise ValueError('Truncated 64-bit Mach-O header')
        magic, cpu, subtype, kind, count, cmdbytes, flags, reserved = struct.unpack_from('<8I', chunk)
        if count > 32768 or cmdbytes > len(chunk) - 32: raise ValueError('Invalid load-command header')
        report = {'slice_offset': file_offset, 'slice_size': len(chunk),
                  'architecture': 'arm64' if cpu == 0x100000c else hex(cpu),
                  'cpu_subtype': subtype, 'file_type': kind, 'flags': hex(flags),
                  'encrypted': False, 'dependencies': [], 'segments': [], 'sections': [],
                  'sha256': hashlib.sha256(chunk).hexdigest()}
        position = 32
        function_starts = None
        text_base = None
        for _ in range(count):
            if position + 8 > 32 + cmdbytes: raise ValueError('Truncated load command')
            cmd, size = struct.unpack_from('<II', chunk, position)
            if size < 8 or size > 32 + cmdbytes - position: raise ValueError('Invalid load command size')
            body = chunk[position:position + size]
            if cmd == 0x1b and size >= 24: report['uuid'] = str(uuid.UUID(bytes=body[8:24])).upper()
            elif cmd == 0x2c and size >= 24:
                cryptoff, cryptsize, cryptid = struct.unpack_from('<III', body, 8)
                report.update(encrypted=cryptid != 0, cryptid=cryptid, encrypted_range=[cryptoff, cryptsize])
            elif cmd == 0x32 and size >= 24:
                platform, minimum, sdk = struct.unpack_from('<III', body, 8)
                report.update(platform=platform, minimum_os=version(minimum), sdk=version(sdk))
            elif cmd == 0x25 and size >= 16:
                minimum, sdk = struct.unpack_from('<II', body, 8)
                report.update(platform=2, minimum_os=version(minimum), sdk=version(sdk))
            elif cmd in (0xc, 0x80000018, 0x8000001f, 0x20) and size >= 24:
                report['dependencies'].append(cstr(body, struct.unpack_from('<I', body, 8)[0]))
            elif cmd == 0x19 and size >= 72:
                name = cstr(body[8:24])
                vmaddr, vmsize, off, filesize, maxprot, initprot, nsects, segflags = struct.unpack_from('<4Q4I', body, 24)
                report['segments'].append({'name': name, 'address': hex(vmaddr), 'memory_size': vmsize,
                                           'file_offset': off, 'file_size': filesize})
                if name == '__TEXT': text_base = vmaddr
                if nsects > 8192 or 72 + nsects * 80 > size: raise ValueError('Invalid section table')
                for n in range(nsects):
                    section = body[72 + n * 80:72 + (n + 1) * 80]
                    addr, length, off = struct.unpack_from('<QQI', section, 32)
                    report['sections'].append({'name': cstr(section[:16]), 'segment': cstr(section[16:32]),
                                               'address': hex(addr), 'size': length, 'file_offset': off})
            elif cmd in (0x26, 0x1d) and size >= 16:
                off, length = struct.unpack_from('<II', body, 8)
                if off > len(chunk) or length > len(chunk) - off: raise ValueError('Linkedit data exceeds file')
                if cmd == 0x26: function_starts = chunk[off:off + length]
                else: report['signature'] = signature_report(chunk, off, length)
            position += size
        if position != 32 + cmdbytes: raise ValueError('Load-command size mismatch')
        if function_starts is not None and text_base is not None:
            address, value, shift, starts = text_base, 0, 0, []
            for byte in function_starts:
                value |= (byte & 127) << shift
                if byte & 128:
                    shift += 7
                    if shift > 63: raise ValueError('Invalid function start encoding')
                    continue
                if not value: break
                address += value
                starts.append(hex(address))
                value = shift = 0
            report['function_starts'] = starts
            report['function_count'] = len(starts)
        results.append(report)
    return results


def inspect_path(path):
    if not zipfile.is_zipfile(path): return {'file': path.name, 'images': {path.name: inspect_macho(path.read_bytes())}}
    with zipfile.ZipFile(path) as z:
        if 'manifest.json' in z.namelist():
            if z.namelist().count('manifest.json') != 1: raise ValueError('Duplicated collection manifest')
            if z.getinfo('manifest.json').file_size > 1024 * 1024: raise ValueError('Collection manifest exceeds 1 MiB')
            manifest = json.loads(z.read('manifest.json'))
            if not isinstance(manifest, dict): raise ValueError('Manifest must be an object')
            if manifest.get('format') == 'lvlolm-ios-inputs': return inspect_collection(path, z, manifest)
        infos = [n for n in z.namelist() if n.startswith('Payload/') and n.endswith('.app/Info.plist') and n.count('/') == 2]
        if len(infos) != 1: raise ValueError('Expected one top-level app bundle in IPA')
        info = plistlib.loads(z.read(infos[0]))
        app = infos[0].rsplit('/', 1)[0]
        main = app + '/' + info['CFBundleExecutable']
        candidates = [main] + [n for n in z.namelist() if n.startswith(app + '/') and n != main and
            ('.framework/' in n and n.rsplit('/', 1)[1] == n.rsplit('.framework/', 1)[0].rsplit('/', 1)[1] or
             n in (app + '/LVProbe', app + '/LVHUD'))]
        images = {}
        for n in candidates:
            entry = z.getinfo(n)
            if entry.file_size > 1024 * 1024 * 1024: raise ValueError('Executable exceeds 1 GiB analysis limit')
            images[n] = inspect_macho(z.read(n))
        return {'file': path.name, 'bundle_identifier': info.get('CFBundleIdentifier'),
                'app_version': info.get('CFBundleShortVersionString'),
                'build_version': info.get('CFBundleVersion'), 'images': images}


def inspect_collection(path, archive, manifest):
    if manifest.get('format_version') != 1: raise ValueError('Unsupported collection format')
    scope = manifest.get('collection_scope', 'unity_metadata')
    if scope not in ('unity_metadata', 'unity_metadata_and_engine', 'native_engine_only'):
        raise ValueError('Unsupported collection scope')
    files, device_images = manifest.get('files'), manifest.get('device_images', [])
    if not isinstance(files, list) or not 1 <= len(files) <= 64 or not isinstance(device_images, list):
        raise ValueError('Invalid collection file list')
    expected = {i['path']: i.get('uuid') for i in device_images
                if isinstance(i, dict) and isinstance(i.get('path'), str)}
    images, metadata, seen = {}, [], set()
    names = archive.namelist()
    for item in files:
        if not isinstance(item, dict): raise ValueError('Invalid collection item')
        name = item.get('archive_path', '')
        if not isinstance(name, str) or not name.startswith('Bundle/') or '\\' in name or len(name) > 512 or any(
                part in ('', '.', '..') for part in name.split('/')) or name in seen or names.count(name) != 1:
            raise ValueError('Unsafe or duplicated collection path')
        seen.add(name)
        entry = archive.getinfo(name)
        if entry.file_size > 1024 * 1024 * 1024: raise ValueError('Collected file exceeds 1 GiB')
        if item.get('size') != entry.file_size: raise ValueError('Collected size does not match manifest')
        role = item.get('role')
        if scope == 'native_engine_only' and role not in ('native_engine', 'native_engine_info'):
            raise ValueError('Unexpected file in engine-only collection')
        if role == 'native_engine' and name != 'Bundle/Frameworks/FEProj.framework/FEProj':
            raise ValueError('Native engine path does not match FEProj')
        if role in ('main_executable', 'unity_framework', 'native_engine'):
            records = inspect_macho(archive.read(name))
            source = item.get('source_path')
            target_uuid = expected.get(source) if isinstance(source, str) else None
            for record in records:
                record['role'] = role
                record['expected_device_uuid'] = target_uuid
                record['uuid_matches_device'] = bool(target_uuid and record.get('uuid') == target_uuid)
            images[name] = records
        elif role == 'il2cpp_metadata':
            with archive.open(name) as f: header = f.read(8)
            magic, version_value = struct.unpack('<II', header) if len(header) == 8 else (None, None)
            metadata.append({'file': name, 'size': entry.file_size,
                             'standard_il2cpp_magic': magic == 0xfab11baf, 'header_version': version_value})
    required = 'native_engine' if scope == 'native_engine_only' else 'unity_framework'
    if not any(i.get('role') == required for i in files):
        raise ValueError('Collection contains no ' + ('FEProj' if scope == 'native_engine_only' else 'UnityFramework'))
    return {'file': path.name, 'collection_format': 'lvlolm-ios-inputs',
            'bundle_identifier': manifest.get('bundle_identifier'), 'app_version': manifest.get('app_version'),
            'build_version': manifest.get('build_version'), 'collection_mode': manifest.get('collection_mode'),
            'collection_scope': scope,
            'metadata_files': metadata, 'images': images}


if __name__ == '__main__':
    p = argparse.ArgumentParser()
    p.add_argument('target', type=Path)
    p.add_argument('--output', type=Path)
    a = p.parse_args()
    try: report = inspect_path(a.target)
    except (ValueError, KeyError, struct.error, zipfile.BadZipFile) as e: p.exit(1, f'Inspection failed: {e}\n')
    text = json.dumps(report, ensure_ascii=False, indent=2) + '\n'
    if a.output: a.output.write_text(text)
    else: print(text, end='')
