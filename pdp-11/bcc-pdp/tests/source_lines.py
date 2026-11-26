#!/usr/bin/env python3
"""Pushed-back newlines must count exactly once when the lexer consumes them."""
import argparse
import contextlib
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
from run_apout import build_snapshot_lock

CASES = [
    ('number', 'main(){\nreturn(1\n+ );\n}\n', 3),
    ('name', 'main(){auto x;\nreturn(x\n+ );\n}\n', 3),
    ('operator', 'main(){\nreturn(1 +\n);\n}\n', 3),
    ('slash', 'main(){\nreturn(1 /\n);\n}\n', 3),
    ('comparison', 'main(){\nreturn(1 ==\n);\n}\n', 3),
    ('comment', 'main(){\n/* comment\n */ return(1\n+ );\n}\n', 4),
    ('blank-line', 'main(){\nreturn(1\n\n+ );\n}\n', 4),
    ('eof', 'main(){\nreturn(1\n', 3),
    ('crlf', 'main(){\r\nreturn(1\r\n+ );\r\n}\r\n', 3),
]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, help='use an already isolated native b00 image')
    parser.add_argument('--emulator', type=Path, help='emulator for the isolated image')
    args = parser.parse_args()
    if bool(args.compiler) != bool(args.emulator):
        parser.error('--compiler and --emulator must be supplied together')
    compiler = args.compiler or ROOT / 'build/b00'
    emulator = args.emulator or ROOT.parent / 'unix-v1/tools/apout/apout'
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-source-lines-') as directory:
        work = Path(directory)
        with contextlib.nullcontext() if args.compiler else build_snapshot_lock(ROOT):
            shutil.copy2(compiler, work / 'b00')
            shutil.copy2(emulator, work / 'apout')
        for name, source, line in CASES:
            (work / 'input.b').write_bytes(source.encode())
            result = subprocess.run([str(work / 'apout'), str(work / 'b00'), 'input.b'],
                                    cwd=work, env=dict(os.environ, APOUT_ROOT=str(work)),
                                    capture_output=True, timeout=10)
            diagnostic = 'expected )' if name == 'eof' else 'expected expression'
            expected = f'\nbcc: line {line}: {diagnostic}\n'.encode()
            ok = result.returncode != 0 and result.stderr == expected
            print(f'{"PASS" if ok else "FAIL"}: source-line/{name}', flush=True)
            if not ok:
                print(result.returncode, repr(result.stdout), repr(result.stderr), flush=True)
            passed += ok
            failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
