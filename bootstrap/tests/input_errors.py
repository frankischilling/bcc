#!/usr/bin/env python3
"""Distinguish failed source reads from an empty translation unit."""
from pathlib import Path
import argparse
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[2]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--build', type=Path, default=ROOT / 'bootstrap/build')
    args = parser.parse_args()
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bbc-input-') as directory:
        work = Path(directory)
        unreadable = work / 'directory.b'
        unreadable.mkdir()
        empty = work / 'empty.b'
        empty.write_bytes(b'')
        valid = work / 'valid.b'
        valid.write_text('main(){return(0);}\n')
        cases = [
            ('read-error', unreadable, b'cannot read input'),
            ('open-error', work / 'missing.b', b'cannot open input'),
            ('empty', empty, None),
            ('valid', valid, None),
        ]
        for stage in (1, 2, 3):
            compiler = args.build.resolve() / f'stage{stage}/bbc'
            for strict in (False, True):
                flags = ['--strict', '--pedantic'] if strict else []
                for name, path, diagnostic in cases:
                    result = subprocess.run([str(compiler), *flags, '-S', str(path)],
                                            cwd=work, capture_output=True, timeout=30)
                    output = result.stdout + result.stderr
                    if diagnostic is None:
                        ok = result.returncode == 0 and bool(result.stdout) and not result.stderr
                    else:
                        ok = result.returncode > 0 and diagnostic in output
                    print(f'{"PASS" if ok else "FAIL"}: stage{stage}/input/{strict}/{name}', flush=True)
                    if not ok:
                        print(result.returncode, repr(output))
                    passed += ok
                    failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
