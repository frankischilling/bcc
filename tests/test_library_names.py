#!/usr/bin/env python3
"""Check that B definitions take precedence over default library bindings."""
import argparse
from pathlib import Path
import subprocess
import tempfile

CASES = {
    'mkdir-replacement': ['mkdir(n){return(n+1);} main(){auto f; extrn mkdir; f=mkdir; return(mkdir(41)!=42 | f(42)!=43);}'],
    'cross-file-function': ['main(){auto f; extrn other; f=other; return(f(7)!=10);}', 'other(n){return(n+3);}'],
    'functions': ['''
printn(n,b) { if(n) return(printn(n-1,b)+1); return(b); }
printf(n) { return(n+1); }
callf(n) { return(n+2); }
main() {
    auto f;
    if(printn(3,10)!=13 | printf(40)!=41 | callf(40)!=42) return(1);
    f=printf; if(f(50)!=51) return(2);
    f=callf; if(f(50)!=52) return(3);
    return(0);
}
'''],
    'variables': ['''
time 17;
main() { auto printf; printf=19; return(time!=17 | printf!=19); }
'''],
    'multiple-files': ['''
main() { auto f,n; extrn printf; n=7; f=printf; return(printf(&n)!=10 | f(&n)!=10); }
''', '''printf(p) { return(*p+3); }'''],
    'namespace': ['''
printf(n) { return(n+1); }
__bcc_user_r_printf(n) { return(n+2); }
main() { return(printf(10)!=11 | __bcc_user_r_printf(10)!=12); }
'''],
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-library-names-') as directory:
        root = Path(directory)
        for inline in ((False,) if args.bootstrap else (False, True)):
            for mode in (('host',) if args.bootstrap else ('host', '16')):
                for name, sources in CASES.items():
                    paths = []
                    for index, source in enumerate(sources):
                        path = root / f'part{index}.b'
                        path.write_text(source)
                        paths.append(str(path))
                    command = [str(args.compiler.resolve())]
                    if not args.bootstrap: command += [f'--word={mode}']
                    if name != 'namespace': command += ['--strict', '--pedantic']
                    if inline: command += ['--inline-runtime']
                    build = subprocess.run([*command, *paths, '-o', str(root/'case')], capture_output=True, timeout=30)
                    run = subprocess.run([str(root/'case')], capture_output=True, timeout=10) if build.returncode == 0 else build
                    ok = run.returncode == 0 and run.stdout == b''
                    print(f'{"PASS" if ok else "FAIL"}: {"inline" if inline else "shared"}/{mode}/{name}')
                    if not ok: print(run.returncode, repr(run.stdout), repr(run.stderr))
                    passed += ok
                    failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
