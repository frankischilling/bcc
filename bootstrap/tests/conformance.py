#!/usr/bin/env python3
"""Check B72 expression and lexical rules in all three bootstrap stages."""
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tests'))
from test_b72_conformance import CASES



def main():
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bbc-conformance-') as directory:
        work = Path(directory)
        for stage in (1, 2, 3):
            compiler = ROOT / f'bootstrap/build/stage{stage}/bbc'
            for name, (source, expected) in CASES.items():
                path = work / 'case.b'
                path.write_text(source + '\n')
                try:
                    result = subprocess.run([str(compiler), '--strict', '--pedantic', str(path), '-o', str(work / 'case')], capture_output=True, timeout=30)
                    if expected is None:
                        ok = result.returncode != 0
                    elif result.returncode:
                        ok = False
                    else:
                        result = subprocess.run([str(work / 'case')], input=b'', capture_output=True, timeout=5)
                        ok = result.returncode == expected
                    detail = result.stderr.decode(errors='replace')[-1500:]
                except (OSError, subprocess.TimeoutExpired) as error:
                    ok, detail = False, str(error)
                print(f'{"PASS" if ok else "FAIL"}: stage{stage}/{name}', flush=True)
                if not ok: print(detail)
                passed += ok
                failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
