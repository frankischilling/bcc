#!/usr/bin/env python3
"""Lower real scalar records to native images and reject malformed expressions."""
import argparse
import importlib.util
import os
from pathlib import Path
import platform
import random
import struct
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[1]
NATIVE = PROJECT / 'pdp-11/bcc-pdp/bootstrap'
spec = importlib.util.spec_from_file_location('wide_frontend', ROOT / 'frontend/build.py')
frontend = importlib.util.module_from_spec(spec)
spec.loader.exec_module(frontend)
HARNESS = r'''
argnum(s) {
    extrn char;auto i,n,neg,c;
    i=0;n=0;neg=0;if(char(s,0)=='-') {neg=1;i++;}
    while((c=char(s,i++))>='0' & c<='9') n=n*10+c-'0';
    if(neg) return(-n);return(n);
}
report() {
    xbin(5,4,3);xcond(5,4094);
    xstack(0,0);xmov(6,4);xmovim(0,1);xmovim(7,1);xmovim(2,8);xsys();
    xmovim(0,60);xmovim(7,0);xsys();
    xmark(4094);xmovim(0,60);xmovim(7,78);xsys();
    xmark(4095);xmovim(0,60);xmovim(7,77);xsys();
}
main() {
    extrn argv,creat,open,close;
    auto pass,fd,buf 520;
    if(argv[0]==4) {xrinit(argnum(argv[2]),argnum(argv[3]),argnum(argv[4]));return(0);}
    if(argv[0]!=2) return(2);
    pass=1;
    while(pass<=2) {
        fd=open(argv[2],0);if(fd<0) fatal("input open");icini(fd);
        if(pass==1) xstart(creat("layout",0600));else xstart(1);
        xlblbeg(pass);xrinit(0,4094,4095);xmov(3,4);
        while(getln(buf,1040)) xrline(buf);
        xrendex();if(close(fd)<0) fatal("input close");
        report();xlblend();xfinish();pass++;
    }
    return(0);
}
'''


def wrapped(n):
    n &= (1 << 64) - 1
    return n - (1 << 64) if n >= 1 << 63 else n


def cases():
    entries = [
        ('0', 0), ('9223372036854775807', (1 << 63) - 1),
        ('9223372036854775808', -(1 << 63)), ('-9223372036854775807-1', -(1 << 63)),
        ('!0', 1), ('!!5', 1), ('-(3+4)', -7), ('2+3*4', 14), ('(2+3)*4', 20),
        ('(2+3)*4==20', 1), ('2!=3', 1), ('2<3', 1), ('2>3', 0),
        ('2<=3', 1), ('2>=3', 0), ('-7/3', -2), ('-7%3', -1),
        ('9223372036854775808/-1', -(1 << 63)), ('9223372036854775808%-1', 0),
        ('123<<64', 0), ('-1>>63', 1), ('123<<65', 246), ('123>>-1', 0),
        ('1|2&4', 1), ('9223372036854775807+1', -(1 << 63)),
        ('1+(2*(3+(4*5)))', 47), ('(10-3)-(5-2)', 4),
        ('7/(5-2)+9%(7-3)', 3), ('!(2<1)', 1),
    ]
    randoms = random.Random(12)
    operators = {
        '+': lambda a, b: a+b, '-': lambda a, b: a-b, '*': lambda a, b: a*b,
        '|': lambda a, b: a|b, '&': lambda a, b: a&b,
        '<': lambda a, b: int(a<b), '>': lambda a, b: int(a>b),
        '==': lambda a, b: int(a==b), '!=': lambda a, b: int(a!=b),
        '<=': lambda a, b: int(a<=b), '>=': lambda a, b: int(a>=b),
    }
    for _ in range(80):
        a, b, c = [randoms.randrange(-(1 << 63), 1 << 63) for _ in range(3)]
        op = randoms.choice(list(operators))
        entries.append((f'(({a}){op}({b}))+({c})', wrapped(operators[op](a,b)+c)))
    return entries


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=PROJECT / 'bcc')
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    compiler = [str(args.compiler.resolve()), '--strict', '--pedantic']
    if not args.bootstrap:
        compiler.append('--word=host')
    execute = platform.system() == 'Linux' and platform.machine().lower() in ('x86_64', 'amd64')
    passed = 0
    tool_free = dict(os.environ, PATH="")
    with tempfile.TemporaryDirectory(prefix='bcc-scalar-') as directory:
        work = Path(directory)
        parts = [NATIVE / 'src' / n for n in ('buffered_io.b', 'decimal16.b', 'diagnostics.b', 'ic.b')]
        parts += [ROOT / n for n in ('x64.b', 'labels.b', 'ops.b', 'scalar.b')]
        source = '\n'.join(p.read_text() for p in parts) + HARNESS

        def build(name, text):
            path = work / (name + '.b')
            path.write_text(text)
            subprocess.run([*compiler, str(path), '-o', str(work / name)],
                           check=True, capture_output=True, timeout=180)

        build('lower', source)
        for first, limit, fail, ok in [(0,4094,4095,True), (4095,4096,0,True),
                                      (-1,2,3,False), (0,4097,4095,False),
                                      (2,2,0,False), (3,2,0,False),
                                      (0,2,-1,False), (0,2,4096,False),
                                      (0,2,0,False), (0,2,1,False)]:
            result = subprocess.run([str(work / 'lower'), str(first), str(limit), str(fail)],
                                    capture_output=True, timeout=10)
            assert (result.returncode == 0) == ok, (first,limit,fail,result)
            passed += 1
        if not args.bootstrap:
            for word in ('16', '32'):
                subprocess.run([*compiler, '--word=' + word, str(work / 'lower.b'),
                                '-o', str(work / 'wrongwidth')], check=True,
                               capture_output=True, timeout=180)
                result = subprocess.run([str(work / 'wrongwidth'), '0', '2', '3'],
                                        capture_output=True, timeout=10)
                assert result.returncode != 0 and b'x64 scalar' in result.stderr, result
                passed += 1
        build('image', (ROOT / 'elfimage.b').read_text())
        build('front', frontend.source_text())
        expressions = cases()
        reference = 'main(){extrn write;auto v;' + ''.join(
            'v=(' + e + ');write(1,&v,8);' for e, _ in expressions) + 'return(0);}'
        build('reference', reference)
        expected = b''.join(struct.pack('=q', v) for _, v in expressions)
        result = subprocess.run([str(work / 'reference')], capture_output=True, timeout=30)
        assert (result.returncode, result.stdout, result.stderr) == (0, expected, b''), result
        passed += len(expressions)
        (work / 'empty').write_bytes(b'')

        def check(name, records, expected=None, status=0, error=False):
            nonlocal passed
            (work / 'input.ic').write_bytes(records)
            result = subprocess.run([str(work / 'lower'), 'input.ic'], cwd=work,
                                    capture_output=True, timeout=30, env=tool_free)
            if error:
                assert result.returncode != 0 and result.stderr, (name, result)
                passed += 1
                return
            assert (result.returncode, result.stderr) == (0, b''), (name, result)
            (work / 'code').write_bytes(result.stdout)
            image = subprocess.run([str(work / 'image'), 'code', 'empty', '0', '0'],
                                   cwd=work, capture_output=True, timeout=30, env=tool_free)
            assert (image.returncode, image.stderr) == (0, b''), (name, image)
            if execute:
                binary = work / 'result'
                binary.write_bytes(image.stdout)
                binary.chmod(0o700)
                run = subprocess.run([str(binary)], capture_output=True, timeout=10, env=tool_free)
                assert (run.returncode, run.stdout, run.stderr) == (status, expected, b''), (name, run, expected)
            passed += 1

        for expression, value in expressions + [('1/0', None), ('1+(2/0)', None)]:
            (work / 'input.b').write_text('main(){return(' + expression + ');}')
            result = subprocess.run([str(work / 'front'), 'input.b'], cwd=work,
                                    capture_output=True, timeout=30, env=tool_free)
            assert (result.returncode, result.stderr) == (0, b''), (expression, result)
            lines = result.stdout.splitlines()
            assert lines[0] == b'Adef main' and lines[-2:] == [b'rt', b'Aend'], lines
            check(expression, b'\n'.join(lines[1:-2]) + b'\n',
                  struct.pack('<q', value) if value is not None else b'',
                  0 if value is not None else 77)
        for text, value in [(b'n -0', 0), (b'n 000007 ', 7), (b'n 1\nuo 126\n', -2),
                            (b'n 5\nps\nn 3\nbin 94\n', 6)]:
            check(str(text), text, struct.pack('<q', value))
        check('operand-stack-limit', (b'n 1\nps\n')*4096 + b'n 1\n' +
              b'bin 43\n'*4096, struct.pack('<q',4097))
        check('operation-label-limit', b'n 1\n' + (b'ps\nn 1\nbin 47\n')*2047,
              struct.pack('<q',1))
        invalid = [b'', b'ps\n', b'n 1\nps\n', b'n 1\nbin 43\n',
                   b'n 1\nps\nbin 43\n', b'uo 45\n', b'n 1 2\n', b'n +1\n',
                   b'n -\n', b'n 1x\n', b'n 9223372036854775808\n',
                   b'n -9223372036854775809\n', b'n 18446744073709551616\n',
                   b'n 0\nps 1\n', b'n 0\nuo 1\n', b'n 0\nuo 45 1\n',
                   b'n 1\nps\nn 2\nbin 1\n', b'n 1\nps\nn 2\nbin 43 1\n',
                   b'n 1\nps\nn 2\nbinc 43 0 1\n',
                   b'n 1\nps\nn 2\nbinc 100 0 0\n', b'n 1\nuon -1 0\n',
                   b'n 1\nuon 0\n', b'n 1\ncl 0\n', b'pr main 0 0\n',
                   b'n 1\ndr\n', b'n 1\njm 0\n', b'n 1\nunknown\n',
                   b'n ' + b'0'*1040, (b'n 1\nps\n')*4097,
                   b'n 1\n' + (b'ps\nn 1\nbin 47\n')*2048]
        for i, records in enumerate(invalid):
            check('invalid/' + str(i), records, error=True)
        print(f'{passed} scalar lowering checks passed')
        if not execute:
            print('SKIP: native image execution requires Linux x86-64')


if __name__ == '__main__':
    main()
