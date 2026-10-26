#!/usr/bin/env python3
"""B72 section 8: counted exec vectors and explicit execl arg0."""
import argparse
from pathlib import Path
import subprocess
import tempfile

CASES = {
    'counted-vector': ('main(){auto v 5; extrn execv; v[0]="chosen-name"; v[1]="%s|%s"; v[2]="two words"; v[3]="last"; v[4]="ignored"; execv("/usr/bin/printf",v,4); return(99);}', b'two words|last'),
    'explicit-arg0': ('main(){extrn execl; execl("/usr/bin/printf","chosen-name","%s","packed string",0); return(99);}', b'packed string'),
    'invalid-count': ('main(){extrn execv; return(execv("/no/such/program",0,-1)!=-1);}', b''),
    'missing-file': ('main(){auto v 1; extrn execv; v[0]="arg0"; return(execv("/no/such/program",v,1)!=-1);}', b''),
    'missing-file-list': ('main(){extrn execl; return(execl("/no/such/program","arg0","value",0)!=-1);}', b''),
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    args = parser.parse_args()
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-exec-') as directory:
        root = Path(directory)
        for inline in (False, True):
            for mode in ('host', '16'):
                for name, (source, expected) in CASES.items():
                    path = root / 'case.b'
                    path.write_text(source + '\n')
                    command = [str(args.compiler.resolve()), '--strict', '--pedantic', f'--word={mode}']
                    if inline: command += ['--inline-runtime']
                    build = subprocess.run([*command, str(path), '-o', str(root / 'case')], capture_output=True, timeout=30)
                    run = subprocess.run([str(root / 'case')], input=b'', capture_output=True, timeout=5) if build.returncode == 0 else build
                    ok = run.returncode == 0 and run.stdout == expected
                    print(f'{"PASS" if ok else "FAIL"}: {"inline" if inline else "shared"}/{mode}/{name}')
                    if not ok: print(run.returncode, repr(run.stdout), repr(run.stderr))
                    passed += ok
                    failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
