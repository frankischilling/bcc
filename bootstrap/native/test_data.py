#!/usr/bin/env python3
"""Check native static cells, address initializers, and distinct string storage."""
import argparse
from pathlib import Path
import os
import struct
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[1]
NATIVE = PROJECT / 'pdp-11/bcc-pdp/bootstrap/src'
HARNESS = '''
entry(name){if(!arname(name))return(0);return(4198400);}
main(){
 extrn argv,open,close,creat,entry;auto fd,out,pass;
 if(argv[0]!=3)return(2);
 pass=0;while(pass++<2){
 fd=open(argv[2],0);if(fd<0)return(2);xdscan(fd);if(close(fd)<0)return(2);
 fd=open(argv[2],0);out=creat(argv[3],0600);if(fd<0 | out<0)return(2);
 xdemit(fd,out,8388608,entry);if(close(fd)<0 | close(out)<0)return(2);
 }
 return(0);
}
'''


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=PROJECT / 'bcc')
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    parts = [NATIVE / name for name in ('buffered_io.b', 'decimal16.b', 'diagnostics.b', 'ic.b')]
    parts += [ROOT / name for name in ('x64.b', 'labels.b', 'ops.b', 'scalar.b', 'arity.b',
                                       'data/layout.b', 'data/output.b')]
    command = [str(args.compiler.resolve()), '--strict', '--pedantic']
    if not args.bootstrap:
        command.append('--word=host')
    passed = 0
    word = lambda n: struct.pack('<Q', n % (1 << 64))
    base = 8388608 // 8
    with tempfile.TemporaryDirectory(prefix='bcc-native-data-') as directory:
        work = Path(directory)
        (work / 'driver.b').write_text('\n'.join(p.read_text() for p in parts) + HARNESS)
        subprocess.run([*command, str(work / 'driver.b'), '-o', str(work / 'driver')], check=True, timeout=180)

        def check(name, records, expected=None, error=False, output="data"):
            nonlocal passed
            (work / 'input').write_text(records)
            result = subprocess.run([str(work / 'driver'), 'input', output], cwd=work,
                                    env=dict(os.environ, PATH=''), capture_output=True, timeout=30)
            if error:
                assert result.returncode != 0 and result.stderr, (name, result)
            else:
                assert (result.returncode, result.stderr) == (0, b''), (name, result)
                actual = (work / 'data').read_bytes()
                assert actual == expected, (name, len(actual), actual[:100], expected[:100])
            passed += 1

        check('empty', '', b'')
        check('scalar', 'gvb x 1\ngvc 42\ngve\n', word(42))
        check('empty-scalar', 'gvb x 0\ngve\n', word(0))
        check('empty-vector', 'gvp x 0\ngve\n', word(base+1))
        check('vector-padding', 'gvp x 4\ngvc 7\ngvc 9\ngve\n', word(base+1)+word(7)+word(9)+word(0)*2)
        check('vector-enlargement', 'gvp x 1\ngvc 7\ngvc 9\ngve\n', word(base+1)+word(7)+word(9))
        check('scalar-list', 'gvb x 1\ngvc -9223372036854775808\ngvc 9223372036854775807\ngve\n', word(-(1<<63))+word((1<<63)-1))
        check('cycles', 'gvb x 1\ngvn y\ngve\ngvb y 1\ngvn x\ngve\n', word(base+1)+word(base))
        check('function-address', 'gvb x 1\ngvn f\ngve\npr f 0 30000\nn 42\nrt\nep 0\n', word(base+1)+word(4198400))
        check('literals', 'Glit 4 65 0 255 4\ngvb x 1\ngvl 0\ngve\npr main 0 30000\nSlit 4 65 0 255 4\nep 0\n',
              b'A\0\xff\4\0\0\0\0'+word(base)+word(4198400)+b'A\0\xff\4\0\0\0\0')
        check('forward-literal', 'gvb x 1\ngvl 0\ngve\nGlit 1 4\n', word(base+1)+b'\4'+b'\0'*7)
        check('maximum-literal', 'Glit 256 '+'65 '*255+'4\n', b'A'*255+b'\4')
        check('maximum-vector', 'gvp x 8190\ngve\n', word(base+1)+word(0)*8190)
        check('maximum-initializers', 'gvb x 0\n'+'gvc 7\n'*128+'gve\n', word(7)*128)
        check('maximum-symbols', ''.join(f'gvb g{i} 1\ngve\n' for i in range(1024)), word(0)*1024)
        check('maximum-literals', 'Glit 1 4\n'*512, (b'\4'+b'\0'*7)*512)
        if Path('/dev/full').exists():
            check('failed-final-write', 'gvb x 1\ngvc 7\ngve\n', error=True, output='/dev/full')
            check('failed-buffer-write', 'gvp x 8190\ngve\n', error=True, output='/dev/full')
        bad = [
            'gvb x -1\ngve\n', 'gvp x 8191\ngve\n', 'gvc 0\n', 'gve\n',
            'gvb x 1\n', 'gvb x 1\ngvb y 1\ngve\n',
            'gvb x 1\ngve\ngvb x 1\ngve\n',
            'gvb x 1\ngvc 9223372036854775808\ngve\n',
            'gvb x 1\ngvc -9223372036854775809\ngve\n',
            'gvb x 1\ngvn missing\ngve\n', 'gvb x 1\ngvl 0\ngve\n',
            'gvb x 1\ngvl -1\ngve\n', 'gvb x 1\ngvl 512\ngve\n',
            'gvb abcdefghi 1\ngve\n', 'gvb 1x 1\ngve\n',
            'gvb x 1\n'+'gvc 0\n'*129+'gve\n',
            ''.join(f'gvb g{i} 1\ngve\n' for i in range(1025)),
            'Glit 1 4\n'*513, 'Glit 0\n', 'Glit 1 0\n',
            'Glit 2 256 4\n', 'Glit 2 -1 4\n', 'Glit 2 65\n',
            'Glit 1 4 junk\n', 'Slit 1 4\n', 'ep 0\n',
            'pr f 0 30000\n', 'pr f 0 30000\npr g 0 30000\nep 0\n',
            'pr f 0 30000\nep 8192\n', 'pr f 0 30000\ngvb x 1\ngve\nep 0\n',
            'gvb x 1\nGlit 1 4\ngve\n', 'unknown\n',
            # The full segment limit is independent of the per-symbol limit.
            ''.join(f'gvp g{i} 8190\ngve\n' for i in range(257)),
        ]
        for index, records in enumerate(bad):
            check('invalid-'+str(index), records, error=True)
    print(f'PASS: native static data ({passed} checks)')


if __name__ == '__main__':
    main()
