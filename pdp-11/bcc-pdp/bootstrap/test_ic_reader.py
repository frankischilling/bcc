#!/usr/bin/env python3
"""Exercise both B record readers across short reads, boundaries and reentry."""
import argparse
from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[2]

# Rename only the reader's call site and external declaration. The wrapper still
# uses real file descriptors, but can force short reads and a delayed error.
HARNESS = r'''
chunks 128; errat -1; total 0; calls 0;
tread(fd,b,n) {
    extrn chunks,errat,total,calls,read;
    auto k;
    calls++;
    if(errat>=0) if(total>=errat) return(-1);
    if(n>chunks) n=chunks;
    if(errat>=0) if(n>errat-total) n=errat-total;
    k=read(fd,b,n);
    if(k>0) total=total+k;
    return(k);
}
number(s) {
    extrn char;
    auto n,i,c,neg;
    i=0;n=0;neg=0;
    if(char(s,0)=='-') {neg=1;i++;}
    while((c=char(s,i++))>= '0' & c<= '9') n=n*10+c-'0';
    if(neg) return(-n);
    return(n);
}
main(argc,argv) {
    extrn chunks,errat,calls,open,close,char;
    auto buf 512,max,fd,i,reset;
    chunks=number(argv[1]);errat=number(argv[2]);max=number(argv[3]);
    reset=number(argv[4]);
    fd=open(argv[5],0);if(fd<0) return(2);
    icini(fd);
    while(getln(buf,max)) {
        i=0;while(char(buf,i)) i++;
        outd(i);outc(':');
        i=0;while(char(buf,i)) outc(char(buf,i++));outc('*n');
        if(reset) {
            close(fd);fd=open(argv[6],0);if(fd<0) return(3);
            icini(fd);reset=0;
        }
    }
    close(fd);outc('#');outd(calls);outc('*n');oflush();return(0);
}
'''


def records(data):
    """A newline ends a record; EOF only emits a nonempty final record."""
    lines = data.split(b'\n')
    if not lines[-1]:
        lines.pop()
    return b''.join(str(len(line)).encode() + b':' + line + b'\n' for line in lines)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--bcc', type=Path, default=PROJECT / 'bcc')
    args = parser.parse_args()
    passed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-ic-reader-') as directory:
        work = Path(directory)
        for module in ('src', 'encoder'):
            reader = (ROOT / module / 'ic.b').read_text()
            assert reader.count('read(') == 1 and reader.count(',read,') == 1
            reader = reader.replace('read(', 'tread(').replace(',read,', ',tread,')
            source = work / 'reader.b'
            source.write_text((ROOT / 'src/buffered_io.b').read_text() +
                              (ROOT / 'src/decimal16.b').read_text() +
                              (ROOT / 'src/diagnostics.b').read_text() + reader + HARNESS)
            for word in ('16', '32', 'host'):
                binary = work / 'reader'
                subprocess.run([str(args.bcc.resolve()), '--strict', '--pedantic',
                                '--word=' + word, str(source), '-o', str(binary)],
                               check=True, timeout=180)

                def check(name, data, *, chunk=128, error=-1, maximum=1024,
                          second=None, expected=None, diagnostic=None, reads=None):
                    nonlocal passed
                    (work / 'input').write_bytes(data)
                    (work / 'second').write_bytes(second or b'')
                    result = subprocess.run([str(binary), str(chunk), str(error),
                                             str(maximum), str(int(second is not None)),
                                             'input', 'second'], cwd=work,
                                            capture_output=True, timeout=30)
                    label = f'{module}/{word}/{name}'
                    if diagnostic is not None:
                        assert result.returncode != 0, (label, result)
                        assert diagnostic in result.stdout + result.stderr, (label, result)
                        if expected is not None:
                            assert result.stdout == expected, (label, result)
                    else:
                        assert result.returncode == 0 and not result.stderr, (label, result)
                        output, count = result.stdout.rsplit(b'#', 1)
                        assert output == (records(data) if expected is None else expected), (label, result)
                        if reads is not None:
                            assert int(count) == reads, (label, count, reads)
                    passed += 1

                for chunk in (1, 3, 127, 128):
                    for length in (0, 1, 126, 127, 128, 129, 255, 256, 257, 1023):
                        for newline in (False, True):
                            data = b'x' * length + (b'\n' if newline else b'')
                            check(f'length-{length}-{newline}/chunk-{chunk}', data, chunk=chunk)
                    check(f'blank-lines/{chunk}', b'\n\nalpha\n\nomega', chunk=chunk)
                    check(f'byte-values/{chunk}', bytes(range(128, 256)) + b'\n', chunk=chunk)
                check('read-ahead-count', b'a\n' * 1024, reads=17)
                check('reopen-discards-buffer', b'old\nstale\n', second=b'new\nlast',
                      expected=records(b'old\nnew\nlast'))
                check('reopen-empty', b'old\nstale\n', second=b'', expected=records(b'old\n'))
                check('empty-one-byte-buffer', b'\n', maximum=1)
                check('full-buffer', b'a' * 1023 + b'\n')
                check('overflow', b'a' * 1024 + b'\n', diagnostic=b'IC line too long')
                check('overflow-at-eof', b'a' * 1024, diagnostic=b'IC line too long')
                check('first-read-error', b'a\n', error=0, diagnostic=b'cannot read IC', expected=b'')
                check('error-after-complete-line', b'a\nrest', error=2,
                      diagnostic=b'cannot read IC', expected=records(b'a\n'))
                check('error-in-partial-line', b'a\nrest', error=4,
                      diagnostic=b'cannot read IC', expected=records(b'a\n'))
                print(f'PASS: {module}/{word}', flush=True)
    print(f'{passed} record-reader checks passed', flush=True)


if __name__ == '__main__':
    main()
