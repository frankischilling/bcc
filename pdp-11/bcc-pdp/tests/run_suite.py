#!/usr/bin/env python3
"""Compare native output as bytes; do not hide NULs or failed executions."""
import argparse
import os
import json
from pathlib import Path
import shlex
import subprocess
import tempfile


def main():
    root = Path(__file__).resolve().parents[1]
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--extensions', action='store_true')
    args = parser.parse_args()
    cases = sorted((root / 'tests' / ('ext' if args.extensions else 'run')).glob('*.b'))
    if not cases:
        parser.error('no native test cases found')
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-native-tests-') as directory:
        work = Path(directory)
        for source in cases:
            reject = source.with_suffix('.reject')
            env = dict(os.environ)
            env.pop('B0FLAGS', None)
            env['B00FLAGS'] = '-x' if args.extensions else ''
            command = [str(root / 'tools/run-apout.sh'), '--timeout', '15', str(source)]
            if source.with_suffix('.args').exists():
                command += shlex.split(source.with_suffix('.args').read_text())
            try:
                result = subprocess.run(command, env=env, cwd=work, input=b'', capture_output=True, timeout=90)
                if reject.exists():
                    expected = reject.read_bytes().strip()
                    if result.returncode == 0:
                        raise AssertionError('invalid program accepted')
                    if expected not in result.stderr:
                        raise AssertionError(result.stderr)
                else:
                    expected = source.with_suffix('.out').read_bytes()
                    exit_file = source.with_suffix('.exit')
                    exit_status = int(exit_file.read_text()) if exit_file.exists() else 0
                    if result.returncode != exit_status:
                        raise AssertionError((result.returncode, result.stderr))
                    if result.stdout != expected:
                        raise AssertionError((result.stdout, expected))
                    files = source.with_suffix('.files.json')
                    if files.exists():
                        for relative, encoded in json.loads(files.read_text()).items():
                            path = Path(relative)
                            if path.is_absolute() or '..' in path.parts:
                                raise AssertionError('file expectation escapes the test directory')
                            target = work / path
                            if encoded is None:
                                if target.exists(): raise AssertionError(f'unexpected file: {relative}')
                            elif target.read_bytes() != bytes.fromhex(encoded):
                                raise AssertionError(f'wrong bytes in {relative}')
                passed += 1
                print(f'PASS: {source.stem}', flush=True)
            except (OSError, AssertionError, subprocess.TimeoutExpired) as error:
                failed += 1
                print(f'FAIL: {source.stem}: {error}', flush=True)
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
