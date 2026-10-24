#!/usr/bin/env python3
"""Check mutable, addressed, persistent function-local label cells."""
import argparse
from pathlib import Path
import subprocess
import tempfile

SOURCE = (Path(__file__).resolve().parents[1] / 'pdp-11/bcc-pdp/tests/run/t90_label_cells.b').read_text()
EXPECTED = b'OK\n'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    passed = failed = 0
    modes = [('host', False)] if args.bootstrap else [(mode, inline) for mode in ('host', '16', '32') for inline in (False, True)]
    with tempfile.TemporaryDirectory(prefix='bcc-label-cells-') as directory:
        root = Path(directory)
        source = root / 'case.b'
        source.write_text(SOURCE)
        for mode, inline in modes:
            command = [str(args.compiler.resolve()), '--strict', '--pedantic']
            if not args.bootstrap: command += [f'--word={mode}']
            if inline: command += ['--inline-runtime']
            build = subprocess.run([*command, str(source), '-o', str(root/'case')], capture_output=True, timeout=30)
            run = subprocess.run([str(root/'case')], input=b'A', capture_output=True, timeout=10) if build.returncode == 0 else build
            ok = run.returncode == 0 and run.stdout == EXPECTED
            print(f'{"PASS" if ok else "FAIL"}: label-cells/{mode}/{"inline" if inline else "shared"}')
            if not ok: print(run.returncode, repr(run.stdout), repr(run.stderr))
            passed += ok
            failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
