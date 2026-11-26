#!/usr/bin/env python3
"""Check native assembly snapshots, or explicitly refresh all five together."""
import argparse
import difflib
import os
from pathlib import Path
import shutil
import subprocess
import tempfile

CASES = {'hello': 'tests/run/t01_hello.b', 'fact': 'examples/fact.b',
         'fib': 'examples/fib.b', 'sieve': 'examples/sieve.b',
         'printn': 'tests/run/t12_printn.b'}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--update', action='store_true')
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[1]
    subprocess.run(['make', '-C', str(root)], check=True)
    apout = root.parent/'unix-v1/tools/apout/apout'
    snapshots = {}
    failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-golden-') as directory:
        work = Path(directory)
        env = dict(os.environ, APOUT_ROOT=str(work))
        for name, relative in CASES.items():
            shutil.copyfile(root/relative, work/'input.b')
            commands = [('b00', ['-o', 'raw.ic', 'input.b']),
                        ('b01', ['-i', 'raw.ic', '-o', 'resolved.ic']),
                        ('b1', ['-i', 'resolved.ic', '-o', 'program.s'])]
            for binary, flags in commands:
                result = subprocess.run([str(apout), str(root/'build'/binary), *flags], cwd=work, env=env, capture_output=True, timeout=30)
                if result.returncode:
                    print(f'FAIL: {name}/{binary}: {result.stderr.decode(errors="replace")}')
                    return 1
            data = (work/'program.s').read_bytes()
            if not data: raise ValueError(f'empty assembly for {name}')
            path = root/f'tests/golden/{name}.s.golden'
            snapshots[path] = data
            if not args.update:
                expected = path.read_bytes()
                ok = data == expected
                print(f'{"PASS" if ok else "FAIL"}: golden/{name}')
                if not ok:
                    failed += 1
                    print(''.join(difflib.unified_diff(expected.decode().splitlines(True), data.decode().splitlines(True), fromfile=str(path), tofile='generated')))
    if args.update:
        for path, data in snapshots.items(): path.write_bytes(data)
        print(f'Updated {len(snapshots)} assembly snapshots; review the diff before committing.')
    else:
        print(f'Results: {len(CASES)-failed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
