#!/usr/bin/env python3
"""Check packed pairs, single characters, and NULs without text normalization."""
import argparse
from pathlib import Path
import subprocess
import tempfile

SOURCE = """
main() {
    auto f;
    extrn putchar, putchr;
    if ('AB' != 16706 | 'A*0' != 16640 | '*0B' != 66) return(1);
    putchar('AB'); putchar('*n*n'); putchar(0);
    putchar('A*0'); putchar('*0B'); putchar(65408);
    f=putchar; f('CD'); putchr('EF');
    return(0);
}
"""
EXPECTED = b'AB\n\n\0A\0B\xff\x80CDF'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    passed = failed = 0
    modes = [('host', False)] if args.bootstrap else [(mode, inline) for mode in ('host', '16') for inline in (False, True)]
    with tempfile.TemporaryDirectory(prefix='bcc-putchar-') as directory:
        root = Path(directory)
        source = root / 'case.b'
        source.write_text(SOURCE)
        for mode, inline in modes:
            command = [str(args.compiler.resolve()), '--strict', '--pedantic']
            if not args.bootstrap: command += [f'--word={mode}']
            if inline: command += ['--inline-runtime']
            build = subprocess.run([*command, str(source), '-o', str(root/'case')], capture_output=True, timeout=30)
            run = subprocess.run([str(root/'case')], capture_output=True, timeout=10) if build.returncode == 0 else build
            ok = run.returncode == 0 and run.stdout == EXPECTED
            print(f'{"PASS" if ok else "FAIL"}: putchar/{mode}/{"inline" if inline else "shared"}')
            if not ok: print(run.returncode, repr(run.stdout), repr(run.stderr))
            passed += ok
            failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
