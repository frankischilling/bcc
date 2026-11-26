#!/usr/bin/env python3
"""Retain unused formal counts and validate the function-record boundaries."""
import argparse
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[1]
NATIVE = PROJECT / 'pdp-11/bcc-pdp/bootstrap'
HARNESS = r'''
reject 0;
collect(name,count) {
    extrn reject;
    outs(name);outc(' ');outd(count);outln();return(reject);
}
main() {
    extrn argv,open,close,collect,reject,char;
    auto fd,n,i;
    if(argv[0]<2) return(2);
    i=2;
    while(i<=argv[0]) {
        if(char(argv[i],0)=='!') {reject=1;i++;}
        fd=open(argv[i],0);if(fd<0) return(2);
        n=arscan(fd,collect);if(close(fd)<0) fatal("cannot close records");
        outc('#');outd(n);outln();i++;
    }
    oflush();return(0);
}
'''


def source_text():
    parts = [NATIVE / 'src' / name for name in ('buffered_io.b', 'decimal16.b',
                                              'diagnostics.b', 'ic.b')]
    return '\n'.join(path.read_text() for path in parts) + (ROOT / 'arity.b').read_text() + HARNESS


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=PROJECT / 'bcc')
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    compiler = [str(args.compiler.resolve()), '--strict', '--pedantic']
    modes = (None,) if args.bootstrap else ('16', '32', 'host')
    passed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-arity-') as directory:
        work = Path(directory)
        source = work / 'arity.b'
        source.write_text(source_text())
        front = work / 'front'
        command = [sys.executable, str(ROOT / 'frontend/build.py'), str(front),
                   '--compiler', str(args.compiler.resolve())]
        if args.bootstrap:
            command.append('--bootstrap')
        subprocess.run(command, check=True, timeout=180)
        integration = [
            (b'f(a,b){return((&a)[1]);}main(){return(f(7));}', b'f 2\nmain 0\n#2\n'),
            (b'f(a,b,c){return(a);}g(){return(9223372036854775808);}', b'f 3\ng 0\n#2\n'),
            (b'f\b(a\b,b){return(a\b);}main(){return(0);}', b'f\b 2\nmain 0\n#2\n'),
            (b'data 65536;', b'#0\n'),
        ]
        records = []
        for text, expected in integration:
            (work / 'program.b').write_bytes(text)
            result = subprocess.run([str(front), 'program.b'], cwd=work, capture_output=True, timeout=30)
            assert (result.returncode, result.stderr) == (0, b''), result
            records.append((result.stdout, expected))
        for word in modes:
            binary = work / 'arity'
            subprocess.run([*compiler, *(['--word=' + word] if word else []), str(source),
                            '-o', str(binary)], check=True, timeout=180)

            def check(name, data, output=None, error=None, second=None, reject=False):
                nonlocal passed
                (work / 'input').write_bytes(data)
                command = [str(binary), *(['!'] if reject else []), 'input']
                if second is not None:
                    (work / 'second').write_bytes(second)
                    command.append('second')
                result = subprocess.run(command, cwd=work, capture_output=True, timeout=60)
                detail = (word, name, result.returncode, result.stdout[-200:], result.stderr[-300:])
                if error:
                    assert result.returncode != 0 and error in result.stderr, detail
                else:
                    assert (result.returncode, result.stdout, result.stderr) == (0, output, b''), detail
                passed += 1

            check('empty', b'', b'#0\n')
            check('globals', b'gvb g 0\ngvc 7\ngve\n', b'#0\n')
            check('zero-parameters', b'Adef main\nn 0\nrt\nAend\n', b'main 0\n#1\n')
            unused = b'Adef f\nAarg a 0\nAarg b 1\nRname a\nRderef\nrt\nAend\nAdef main\nn 0\nAend\n'
            check('unused-parameter', unused, b'f 2\nmain 0\n#2\n')
            check('later-storage-class', b'Acompat\nAdef f\nAarg a 0\nAextrn a\nAend\n', b'f 1\n#1\n')
            check('name-width', b'Adef abcdefgh\nAarg param001 0\nAend\n', b'abcdefgh 1\n#1\n')
            check('backspace-name', b'Adef f\b\nAarg a\b 0\nAend\n', b'f\b 1\n#1\n')
            check('final-no-newline', b'Adef f\nAend', b'f 0\n#1\n')
            check('reentry', unused, b'f 2\nmain 0\n#2\ng 0\n#1\n', second=b'Adef g\nAend\n')
            literal = b'Slit 256 ' + b'120 ' * 255 + b'4\n'
            check('long-literal-record', b'Adef f\n' + literal + b'Aend\n', b'f 0\n#1\n')
            many = b'Adef f\n' + b''.join(f'Aarg p{i:05d} {i}\n'.encode() for i in range(199)) + b'Aend\n'
            check('many-parameters', many, b'f 199\n#1\n')
            bad = [
                ('orphan-arg', b'Aarg a 0\n', b'parameter outside function'),
                ('orphan-end', b'Aend\n', b'function end without definition'),
                ('nested', b'Adef f\nAdef g\n', b'nested function record'),
                ('unfinished', b'Adef f\n', b'unfinished function records'),
                ('empty-name', b'Adef\n', b'invalid function record'),
                ('numeric-name', b'Adef 1\n', b'invalid function record'),
                ('long-name', b'Adef abcdefghi\n', b'invalid function record'),
                ('extra-def-field', b'Adef f 1\n', b'invalid function record'),
                ('skipped-index', b'Adef f\nAarg a 1\n', b'invalid parameter index'),
                ('duplicate-index', b'Adef f\nAarg a 0\nAarg b 0\n', b'invalid parameter index'),
                ('negative-index', b'Adef f\nAarg a -1\n', b'invalid parameter index'),
                ('range-index', b'Adef f\nAarg a 32768\n', b'IC integer out of range'),
                ('missing-index', b'Adef f\nAarg a\n', b'invalid parameter record'),
                ('long-arg', b'Adef f\nAarg abcdefgh0\n', b'invalid parameter record'),
                ('numeric-arg', b'Adef f\nAarg 1 0\n', b'invalid parameter record'),
                ('extra-index-field', b'Adef f\nAarg a 0 extra\n', b'invalid parameter index'),
                ('extra-end-field', b'Adef f\nAend extra\n', b'invalid function end'),
            ]
            for name, data, error in bad:
                check(name, data, error=error)
            check('callback-error', unused, error=b'parameter callback failed', reject=True)
            max_args = b'Adef f\n' + b''.join(f'Aarg p{i:05d} {i}\n'.encode() for i in range(32767))
            check('parameter-limit', max_args + b'Aend\n', b'f 32767\n#1\n')
            check('parameter-overflow', max_args + b'Aarg p32767 32767\nAend\n', error=b'too many parameters')
            if word in (None, 'host'):
                functions = b'Adef f\nAend\n' * 32767
                check('function-limit', functions, b'f 0\n' * 32767 + b'#32767\n')
                check('function-overflow', functions + b'Adef f\nAend\n',
                      error=b'too many function records')
            for index, (data, expected) in enumerate(records):
                check(f'frontend/{index}', data, expected)
            print(f'PASS: arity/{word or "bootstrap"}', flush=True)
    print(f'{passed} arity checks passed', flush=True)


if __name__ == '__main__':
    main()
