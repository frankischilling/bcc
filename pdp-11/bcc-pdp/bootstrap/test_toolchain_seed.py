#!/usr/bin/env python3
"""Check guest file bounds and non-destructive seed-directory creation."""
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / 'tools'))
from build_toolchain import FILES, guest_file_sizes


def main():
    passed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-seed-rules-') as directory:
        work = Path(directory)
        for size in (0, 65535):
            path = work / 'input'
            path.write_bytes(bytes(size))
            assert guest_file_sizes({'input': path}) == {'input': size}
            passed += 1
        for kind in ('oversized', 'missing', 'directory'):
            path = work / kind
            if kind == 'oversized':
                path.write_bytes(bytes(65536))
            elif kind == 'directory':
                path.mkdir()
            try:
                guest_file_sizes({kind: path})
            except ValueError:
                passed += 1
            else:
                raise AssertionError('invalid guest file accepted: ' + kind)
        existing = work / 'existing'
        existing.mkdir()
        sentinel = existing / 'keep'
        sentinel.write_bytes(b'do not replace')
        result = subprocess.run([sys.executable, str(ROOT / 'tools/build_toolchain.py'), str(existing)],
                                capture_output=True, timeout=30)
        assert result.returncode and b'destination already exists' in result.stderr
        assert sentinel.read_bytes() == b'do not replace'
        assert list(existing.iterdir()) == [sentinel]
        passed += 1
        names = [name for pair in FILES.values() for name in pair]
        names += ['engine', 'driver', 'vm.b', 'bdrv.b', 'libb.b', 'bmain.s', 'brt.s', 'libb.s']
        assert len(set(names)) == len(names)
        assert all(0 < len(name.encode('ascii')) <= 8 and '/' not in name for name in names)
        passed += 1
    print(f'Results: {passed} passed, 0 failed')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
