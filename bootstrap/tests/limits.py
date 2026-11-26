#!/usr/bin/env python3
"""Reject exhausted bootstrap tables before writing beyond their storage."""
from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[2]


def main():
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bbc-limits-') as directory:
        root = Path(directory)
        functions = root/'functions.b'
        functions.write_text(''.join(f'f{i}(){{return(0);}}\n' for i in range(1025)))
        variables = root/'variables.b'
        variables.write_text(''.join(f'v{i};\n' for i in range(2049)))
        valid = root/'valid.b'
        valid.write_text('main(){return(0);}\n')
        cases = [
            ('functions', [str(functions)], b'too many functions'),
            ('variables', [str(variables)], b'too many globals'),
            ('input-files', ['missing.b'] * 257, b'too many input files'),
            ('options', ['-X', '-O0'] * 257 + [str(valid)], b'too many compiler options'),
        ]
        for stage in (1, 2, 3):
            compiler = ROOT/f'bootstrap/build/stage{stage}/bbc'
            for name, arguments, diagnostic in cases:
                result = subprocess.run([str(compiler), *arguments], cwd=root, capture_output=True, timeout=60)
                ok = result.returncode > 0 and diagnostic in result.stdout + result.stderr
                print(f'{"PASS" if ok else "FAIL"}: stage{stage}/limit-{name}', flush=True)
                if not ok: print(result.returncode, repr(result.stdout), repr(result.stderr))
                passed += ok
                failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
