#!/usr/bin/env python3
"""Create a source/evidence archive, excluding binaries and toolchain downloads."""
import hashlib
import plistlib
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
files = [ROOT / 'README.md', ROOT / '.gitignore', ROOT / 'AGENTS.md']
for directory in ('.github', 'core', 'ios', 'scripts', 'tools', 'tests', 'analysis', 'docs'):
    for path in (ROOT / directory).rglob('*'):
        if path.is_file() and '__pycache__' not in path.parts and path.name != 'config_test':
            files.append(path)

dist = ROOT / 'dist'
dist.mkdir(exist_ok=True)
version = plistlib.loads((ROOT / 'ios/Info.plist').read_bytes())['CFBundleShortVersionString']
target = dist / ('lvlolm-recovery-source-' + version + '.zip')
with zipfile.ZipFile(target, 'w', zipfile.ZIP_DEFLATED) as archive:
    for path in sorted(files):
        archive.write(path, Path('lvlolm-recovery') / path.relative_to(ROOT))
digest = hashlib.sha256(target.read_bytes()).hexdigest()
(dist / (target.name + '.sha256')).write_text(f'{digest}  {target.name}\n')
print(f'Packaged {len(files)} files: {target}')
