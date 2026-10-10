#!/usr/bin/env python3
"""Fetch the pinned Linux build dependencies recorded during recovery."""
import hashlib
import json
import os
import tarfile
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
dest = ROOT / 'toolchain'
dest.mkdir(exist_ok=True)
for entry in json.loads((ROOT / 'scripts/toolchain-manifest.json').read_text()):
    path = dest / entry['name']
    if not path.exists():
        with urllib.request.urlopen(entry['url'], timeout=60) as response:
            path.write_bytes(response.read())
    if hashlib.sha256(path.read_bytes()).hexdigest() != entry['sha256']:
        raise ValueError('Downloaded file hash mismatch: ' + entry['name'])
    if path.name.endswith('.tar.xz'):
        if not (dest / 'iPhoneOS16.5.sdk').exists():
            with tarfile.open(path) as archive: archive.extractall(dest, filter='tar')
    else:
        (dest / 'ldid').write_bytes(path.read_bytes())
        (dest / 'ldid').chmod(0o755)
print('Pinned SDK and ldid ready. Compiler/linker are supplied by the host.')
