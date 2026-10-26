#!/usr/bin/env python3
"""Absolute 16-bit file offsets are unsigned; relative displacements are signed."""
import argparse
from pathlib import Path
import subprocess
import tempfile

CASES = {
    'absolute-high': 'if(seek(fd,32768,0)!=0 | read(fd,b,1)!=0)return(2);',
    'absolute-max': 'if(seek(fd,65535,0)!=0 | read(fd,b,1)!=0)return(2);',
    'absolute-sign': 'if(seek(fd,-1,0)!=EXPECTED)return(2);',
    'relative-current': "if(seek(fd,2,0)!=0 | read(fd,b,1)!=1)return(2);if(seek(fd,-2,1)!=0 | read(fd,b,1)!=1)return(3);if(char(b,0)!='B')return(4);",
    'relative-end': "if(seek(fd,-1,2)!=0 | read(fd,b,1)!=1)return(2);if(char(b,0)!='C')return(3);if(seek(fd,-3,2)!=0 | read(fd,b,1)!=1)return(4);if(char(b,0)!='A')return(5);",
    'absolute-zero': "if(seek(fd,0,0)!=0 | read(fd,b,1)!=1)return(2);if(char(b,0)!='A')return(3);",
    'bad-descriptor': 'if(seek(-1,0,0)!=-1)return(2);',
    'bad-origin': "if(seek(fd,0,77)!=-1)return(2);if(read(fd,b,1)!=1 | char(b,0)!='A')return(3);",
}
PREFIX = 'main(){extrn open,close,read,seek,char;auto fd,b 2;fd=open("input",0);if(fd<0)return(1);'
SUFFIX = 'return(close(fd)<0);}'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    modes = [('host', False, False)] if args.bootstrap else [
        (word, inline, byteptr) for word in ('host', '16', '32')
        for inline in (False, True) for byteptr in (False, True)]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-seek-') as directory:
        work = Path(directory)
        (work / 'input').write_bytes(b'ABC')
        for word, inline, byteptr in modes:
            flags = ['--strict', '--pedantic']
            if not args.bootstrap:
                flags += ['--word=' + word, '--byteptr' if byteptr else '--wordptr']
            if inline:
                flags.append('--inline-runtime')
            for name, body in CASES.items():
                (work / 'case.b').write_text(PREFIX + body.replace('EXPECTED', '0' if word == '16' else '-1') + SUFFIX)
                build = subprocess.run([str(args.compiler.resolve()), *flags, str(work / 'case.b'),
                                        '-o', str(work / 'case')], capture_output=True, timeout=30)
                run = subprocess.run([str(work / 'case')], cwd=work, capture_output=True, timeout=5) if build.returncode == 0 else build
                ok = build.returncode == 0 and run.returncode == 0 and not run.stdout and not run.stderr
                print(f'{"PASS" if ok else "FAIL"}: seek/{word}/{inline}/{byteptr}/{name}', flush=True)
                if not ok:
                    print(run.returncode, repr(run.stdout), repr(run.stderr))
                passed += ok
                failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
