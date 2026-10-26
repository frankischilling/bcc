#!/usr/bin/env python3
"""Execute local-cell, vector, pointer, and assignment lowering fixtures."""
import argparse
import importlib.util
import os
from pathlib import Path
import platform
import struct
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[1]
NATIVE = PROJECT / 'pdp-11/bcc-pdp/bootstrap'
sys.path.insert(0, str(NATIVE / 'tools'))
from build_passes import source_text as pass_source
spec = importlib.util.spec_from_file_location('wide_frontend', ROOT / 'frontend/build.py')
frontend = importlib.util.module_from_spec(spec)
spec.loader.exec_module(frontend)
HARNESS = r'''
number(s) {
    extrn char;auto i,n,c,neg;
    i=0;n=0;neg=0;if(char(s,0)=='-') {neg=1;i++;}
    while((c=char(s,i++))>='0' & c<='9') n=n*10+c-'0';
    if(neg) return(-n);return(n);
}
report() {
    xbin(5,4,3);xcond(5,4094);
    xmovim(2,123456789);xbin(5,5,2);xcond(5,4094);
    xstack(0,0);xmov(6,4);xmovim(0,1);xmovim(7,1);xmovim(2,8);xsys();
    xmovim(0,60);xmovim(7,0);xsys();
    xmark(4094);xmovim(0,60);xmovim(7,78);xsys();
    xmark(4095);xmovim(0,60);xmovim(7,77);xsys();
}
main() {
    extrn argv,creat,open,close;
    auto pass,fd,buf 520;
    if(argv[0]!=3) return(2);
    pass=1;
    while(pass<=2) {
        fd=open(argv[2],0);if(fd<0) fatal("input open");icini(fd);
        if(pass==1) xstart(creat("layout",0600));else xstart(1);
        xlblbeg(pass);xrinit(0,4094,4095);xmov(3,4);xmovim(5,123456789);
        xmframe(number(argv[3]));
        while(getln(buf,1040)) if(!xmline(buf)) xrline(buf);
        xrendex();if(close(fd)<0) fatal("input close");
        xmleave();report();xlblend();xfinish();pass++;
    }
    return(0);
}
'''


def cases():
    minimum = -(1 << 63)
    maximum = (1 << 63) - 1
    result = [
        ('auto x;x=7;return(x);', 7),
        ('auto a 3;a[0]=1;a[1]=2;a[2]=3;return(a[0]+a[1]*10+a[2]*100);', 321),
        ('auto x,y;x=7;y=x++;return(x*10+y);', 87),
        ('auto x;x=7;return(++x);', 8), ('auto x;x=7;return(x--);', 7),
        ('auto x;x=7;return(--x);', 6),
        ('auto a 2,p;a[0]=5;a[1]=9;p=a;p++;return(*p);', 9),
        ('auto a 3,p;a[1]=5;p= &a[1];*p=7;return(a[1]);', 7),
        ('auto a 3,p;a[0]=23;p=a+2;return(p[-2]);', 23),
        ('auto a 3;return(&a[2]-&a[0]);', 2),
        ('auto x;x=9223372036854775808;x=/-1;return(x);', minimum),
        ('auto x;x=9223372036854775808;x=%-1;return(x);', 0),
        (f'auto x,y;x={maximum};y=x++;return(y=={maximum} & x=={minimum});', 1),
        (f'auto x;x={minimum};return(--x);', maximum),
        ('auto x;x=5;x=<<64;return(x);', 0),
        ('auto x;x= -1;x=>>63;return(x);', 1),
        ('auto a 2,i;i=0;a[0]=5;a[1]=19;a[i++]=+(i=3);return(i*100+a[0]+a[1]*1000);', 19308),
        ('auto x;x=1;x=+(x=5);return(x);', 10),
    ]
    updates = [('+',-4), ('-',-10), ('*',-21), ('/',-2), ('%',-1),
               ('&',1), ('|',-5), ('<',1), ('>',0), ('==',0), ('!=',1),
               ('<=',1), ('>=',0), ('<<',-56), ('>>',((1 << 64)-7) >> 3)]
    for op, value in updates:
        result.append((f'auto x;x= -7;x={op}3;return(x);', value))
        # The indexed lvalue must be captured once before the right operand.
        value = (value+90100) & ((1 << 64)-1)
        if value >= 1 << 63:
            value -= 1 << 64
        result.append((f'auto a 2,i;i=0;a[0]= -7;a[1]=9;a[i++]={op}3;'
                       'return(i*100+a[0]+a[1]*10000);', value))
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=PROJECT / 'bcc')
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    compiler = [str(args.compiler.resolve()), '--strict', '--pedantic']
    if not args.bootstrap:
        compiler.append('--word=host')
    execute = platform.system() == 'Linux' and platform.machine().lower() in ('x86_64','amd64')
    tool_free = dict(os.environ, PATH='')
    passed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-memory-') as directory:
        work = Path(directory)

        def build(name, text):
            path = work / (name + '.b')
            path.write_text(text)
            run = subprocess.run([*compiler, str(path), '-o', str(work / name)],
                                 capture_output=True, timeout=180)
            assert run.returncode == 0, (name, run.stderr)

        parts = [NATIVE/'src'/name for name in ('buffered_io.b','decimal16.b','diagnostics.b','ic.b')]
        parts += [ROOT/name for name in ('x64.b','labels.b','ops.b','scalar.b','memory.b')]
        build('lower', '\n'.join(path.read_text() for path in parts) + HARNESS)
        build('front', frontend.source_text())
        build('resolver', pass_source('resolver'))
        build('image', (ROOT/'elfimage.b').read_text())
        fixtures = cases()
        reference = ''.join(f'f{i}(){{' + body + '}\n' for i,(body,_) in enumerate(fixtures))
        reference += 'main(){extrn write;auto v;'
        reference += ''.join(f'v=f{i}();write(1,&v,8);' for i in range(len(fixtures)))
        reference += 'return(0);}'
        build('reference', reference)
        expected = b''.join(struct.pack('=q',value) for _,value in fixtures)
        run = subprocess.run([str(work/'reference')], capture_output=True, timeout=30)
        assert (run.returncode,run.stdout,run.stderr) == (0,expected,b''), run
        passed += len(fixtures)
        (work/'empty').write_bytes(b'')

        def check(name, records, count, value=None, status=0, error=False):
            nonlocal passed
            (work/'input.ic').write_bytes(records)
            run = subprocess.run([str(work/'lower'),'input.ic',str(count)], cwd=work,
                                 capture_output=True, timeout=30, env=tool_free)
            if error:
                assert run.returncode != 0 and run.stderr, (name,run)
            else:
                assert (run.returncode,run.stderr) == (0,b''), (name,run)
                (work/'code').write_bytes(run.stdout)
                image = subprocess.run([str(work/'image'),'code','empty','0','0'], cwd=work,
                                       capture_output=True, timeout=30, env=tool_free)
                assert (image.returncode,image.stderr) == (0,b''), (name,image)
                if execute:
                    (work/'result').write_bytes(image.stdout)
                    (work/'result').chmod(0o700)
                    run = subprocess.run([str(work/'result')], capture_output=True,
                                         timeout=10, env=tool_free)
                    expected = b'' if value is None else struct.pack('<q',value)
                    assert (run.returncode,run.stdout,run.stderr) == (status,expected,b''), (name,run,expected)
            passed += 1

        for body,value in fixtures + [('auto x;x=1;x=/0;return(x);',None),
                                     ('auto a 2,i;i=0;a[0]=5;a[i++]=%0;return(i);',None)]:
            (work/'input.b').write_text('main(){'+body+'}')
            front = subprocess.run([str(work/'front'),'input.b'],cwd=work,capture_output=True,
                                   timeout=30,env=tool_free)
            assert (front.returncode,front.stderr) == (0,b''), (body,front)
            (work/'raw.ic').write_bytes(front.stdout)
            resolved = subprocess.run([str(work/'resolver'),'-i','raw.ic'],cwd=work,
                                      capture_output=True,timeout=30,env=tool_free)
            assert (resolved.returncode,resolved.stderr) == (0,b''), (body,resolved)
            lines = resolved.stdout.splitlines()
            assert lines[0].startswith(b'pr main ') and lines[-2] == b'rt' and lines[-1].startswith(b'ep '), lines
            count = int(lines[-1].split()[1])
            check(body,b'\n'.join(lines[1:-2])+b'\n',count,value,0 if value is not None else 77)
        check('maximum-frame',b'lc 8190\nps\nn 42\nas\nlc 8190\ndr\n',8191,42)
        check('zero-frame',b'n 7\n',0,7)
        check('zeroed-frame',b'lc 0\ndr\n',1,0)
        invalid = [(-1,b'n 0\n'),(8192,b'n 0\n'),(0,b'lc 0\n'),(1,b'lc 1\n'),
                   (1,b'lc -1\n'),(1,b'lc 0 1\n'),(1,b'vi 0 1\n'),(2,b'vi 1 0\n'),
                   (2,b'vi -1 0\n'),(2,b'vi 0 -1\n'),(2,b'vi 0 1 2\n'),
                   (1,b'dr\n'),(1,b'lc 0\ndr 0\n'),(1,b'as\n'),(1,b'n 0\nas\n'),
                   (1,b'lc 0\nps\nas\n'),(1,b'n 0\nix\n'),(1,b'lc 0\npo 2\n'),
                   (1,b'lc 0\npi -1\n'),(1,b'po 1\n'),(1,b'lc 0\npi 1 2\n'),
                   (1,b'lc 0\nps\nn 1\nca 1\n'),(1,b'lc 0\nps\nn 1\nca 43 0\n'),
                   (1,b'lc 0\nps\nn 1\ncac 43 0 1\n'),
                   (1,b'lc 0\nps\nn 1\ncac 100 0 0\n'),
                   (1,b'lc 0\nps\nn 1\ncac 100 -1 0\n'),(1,b'n 1\nca 43\n'),
                   (1,b'ar 0\n'),(1,b'ex global\n'),(1,b'lc 0\ncl 0\n')]
        for index,(count,records) in enumerate(invalid):
            check('invalid/'+str(index),records,count,error=True)
        print(f'{passed} memory lowering checks passed')
        if not execute:
            print('SKIP: native image execution requires Linux x86-64')


if __name__ == '__main__':
    main()
