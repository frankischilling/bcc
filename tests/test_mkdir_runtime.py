#!/usr/bin/env python3
"""Check the historical mkdir name, function values, and makdir alias."""
import argparse
from pathlib import Path
import subprocess
import tempfile

SOURCE = """
main() {
    extrn mkdir, makdir, stat;
    auto st 20, f;
    if(mkdir("first",016)<0)return(1);
    if(stat("first",st)<0 | !(st[1]&040000))return(2);
    f=mkdir;
    if(f("second",016)<0)return(3);
    if(stat("second",st)<0 | !(st[1]&040000))return(4);
    if(makdir("third",016)<0)return(5);
    if(mkdir("first",016)>=0)return(6);
    return(0);
}
"""
EXPECTED = b''


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    passed = failed = 0
    modes = [('host', False)] if args.bootstrap else [(mode, inline) for mode in ('host', '16', '32') for inline in (False, True)]
    with tempfile.TemporaryDirectory(prefix='bcc-mkdir-') as directory:
        root = Path(directory)
        source = root / 'case.b'
        source.write_text(SOURCE)
        for mode, inline in modes:
            case_dir = root / f"run-{mode}-{inline}"
            case_dir.mkdir()
            command = [str(args.compiler.resolve()), '--strict', '--pedantic']
            if not args.bootstrap: command += [f'--word={mode}']
            if inline: command += ['--inline-runtime']
            build = subprocess.run([*command, str(source), '-o', str(root/'case')], capture_output=True, timeout=30)
            run = subprocess.run([str(root/'case')], cwd=case_dir, input=b'', capture_output=True, timeout=10) if build.returncode == 0 else build
            ok = run.returncode == 0 and run.stdout == EXPECTED
            print(f'{"PASS" if ok else "FAIL"}: mkdir/{mode}/{"inline" if inline else "shared"}')
            if not ok: print(run.returncode, repr(run.stdout), repr(run.stderr))
            passed += ok
            failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
