#!/usr/bin/env python3
"""Check that short, zero-length, failed, and EOF reads preserve untouched bytes."""
import argparse
from pathlib import Path
import subprocess
import tempfile

SOURCE = """
main() {
    extrn read, char, lchar;
    auto buf 2, i;
    i=0; while(i<4) { lchar(buf,i,'Z'); i=+1; }
    if(read(0,buf,0)!=0) return(1);
    i=0; while(i<4) { if(char(buf,i)!='Z')return(2); i=+1; }
    if(read(0,buf,1)!=1 | char(buf,0)!='A')return(3);
    i=1; while(i<4) { if(char(buf,i)!='Z')return(4); i=+1; }
    if(read(-1,buf,1)!=-1)return(5);
    if(char(buf,0)!='A' | char(buf,1)!='Z')return(6);
    if(read(0,buf,1)!=0)return(7);
    if(char(buf,0)!='A' | char(buf,1)!='Z')return(8);
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
    with tempfile.TemporaryDirectory(prefix='bcc-read-') as directory:
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
            print(f'{"PASS" if ok else "FAIL"}: read/{mode}/{"inline" if inline else "shared"}')
            if not ok: print(run.returncode, repr(run.stdout), repr(run.stderr))
            passed += ok
            failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
