#!/usr/bin/env python3
"""Check that the runtime's label namespace cannot wrap or reuse a token."""
import os
from pathlib import Path
import shlex
import subprocess
import tempfile


def main():
    root = Path(__file__).resolve().parents[1]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-label-limits-') as directory:
        exe = Path(directory) / 'limits'
        for bits in (16, 32, 64):
            command = [*shlex.split(os.environ.get('CC', 'cc')), '-std=c99', '-O2',
                       '-I', str(root / 'lib'), f'-DWORD_BITS={bits}',
                       str(root / 'tests/fixtures/label_token_limits.c'), '-o', str(exe)]
            build = subprocess.run(command, capture_output=True, timeout=30)
            for exhaust in (False, True):
                run = subprocess.run([str(exe)] + (['exhaust'] if exhaust else []),
                                     capture_output=True, timeout=5) if build.returncode == 0 else build
                ok = build.returncode == 0 and run.returncode == (1 if exhaust else 0)
                ok = ok and (b'label token space exhausted' in run.stderr if exhaust else not run.stderr)
                print(f'{"PASS" if ok else "FAIL"}: label-limit/{bits}/{exhaust}')
                if not ok:
                    print(run.returncode, repr(run.stdout), repr(run.stderr))
                passed += ok
                failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
