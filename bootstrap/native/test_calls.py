#!/usr/bin/env python3
"""Check native call frames and whole-function source integration."""
import argparse
import importlib.util
import os
from pathlib import Path
import platform
import re
import struct
import subprocess
import sys
import tempfile

ROOT=Path(__file__).resolve().parent
PROJECT=ROOT.parents[1]
NATIVE=PROJECT/'pdp-11/bcc-pdp/bootstrap'
FIXTURES=ROOT/'fixtures/calls'
sys.path.insert(0,str(NATIVE/'tools'))
from build_passes import source_text as pass_source
spec=importlib.util.spec_from_file_location('wide_frontend',ROOT/'frontend/build.py')
frontend=importlib.util.module_from_spec(spec)
spec.loader.exec_module(frontend)
SOURCE_CASES=[('main(){return(42);}', 42),
 ('add(a,b){return(a+b);}main(){return(add(7,9));}', 16),
 ('f(a,b,c){return(a+b+c);}main(){return(f(7));}', 7),
 ('f(a,b){return((&a)[1]);}main(){return(f(7));}', 0),
 ('f(x){return((&x)[3]);}main(){return(f(1,2,3,4));}', 4),
 ('f(n){if(n)return(n+f(n-1));return(0);}main(){return(f(10));}', 55),
 ('sum(n,x){auto p,s,i;p= '
  '&x;s=0;i=0;while(i<n){s=+p[i];i++;}return(s);}main(){return(sum(4,10,20,30,40));}',
  100),
 ('f(){return(7);}g(){return(9);}main(){extrn f,g;auto old;old=f;f=g;return(old()*10+f());}', 79),
 ('first(x){return(1);}second(x){return(2);}replace(){extrn '
  'first,second;first=second;return(0);}main(){extrn first,replace;return(first(replace()));}',
  1),
 ('f(x){x=99;return(x);}main(){auto a;a=42;return(f(a)+a);}', 141),
 ('f(n){return(n+2);}g(n){return(n+3);}main(){extrn f,g;auto v '
  '2;v[0]=f;v[1]=g;return(v[0](40)+v[1](39));}',
  84),
 ('f(n){if(n)return(f(n-1)+1);return(0);}g(n){return(10);}main(){extrn f,g;auto '
  'old;old=f;f=g;return(old(1));}',
  11),
 ('printf(n){return(n+1);}main(){return(printf(41));}', 42),
 ('f(a,b){return(a*10+b);}main(){return(f(f(1,2),f(3,4)));}', 154),
 ('main(){auto i,s;i=0;s=0;while(i<10){s=+i;i++;}return(s);}', 45),
 ('apply(p,x){return(p(x));}f(n){return(n+2);}main(){extrn f;return(apply(f,40));}', 42),
 ('f(n){return(n+2);}choose(){extrn f;return(f);}main(){return(choose()(40));}', 42),
 ('even(n){if(n)return(odd(n-1));return(1);}odd(n){if(n)return(even(n-1));return(0);}main(){return(even(10)*10+odd(11));}',
  11),
 ('change(p){p[1]=42;return(0);}main(){auto a 2;a[0]=7;a[1]=9;change(a);return(a[1]);}', 42),
 ('first(a,b){return((&a)[1]);}second(){return(9);}replace(){extrn '
  'first,second;first=second;return(7);}main(){return(first(replace()));}',
  0),
 ('g(){return(9);}main(){extrn main,g;auto p,old;p= '
  '&main;old=main;main=g;if(*p!=g)return(1);*p=old;return(main!=old);}',
  0),
 ('f(a,b,c,d,e,f,g,h){return((&a)[7]);}main(){return(f(7));}', 0),
 ('f(x){return(x);}main(){return(f(9223372036854775808));}', -9223372036854775808),
 ('f(){return(7);}main(){return(f(1,2,3,4,5,6,7,8));}', 7),
 ('main(){auto a 8190;a[0]=7;a[8189]=9;return(a[0]+a[8189]);}', 16)]

SOURCE_CASES += [
 ('data 7;main(){extrn data;data=+35;return(data);}',42),
 ('x y;y x;main(){extrn x,y;return(x==&y & y==&x);}',1),
 ('v[1] 7,9;main(){extrn v;return(v[0]+v[1]);}',16),
 ('v[4] 7,9;main(){extrn v;return(v[0]+v[1]+v[2]+v[3]);}',16),
 ('cell f;f(){return(42);}main(){extrn cell;return((*cell)());}',42),
 ('v[2] 7,9;main(){extrn v;auto p;p=v;v=v+1;return(*v+*p);}',16),
 ('x 9223372036854775808;main(){extrn x;return(x);}',-(1<<63)),
 ('text "A*0B";main(){extrn text;return(*text);}',0x04420041),
 ('main(){auto p,q;p="A";q="A";*p=7;return(p!=q & *q==0101+4*256);}',1),
 ('main(){auto p;p="";return(*p);}',4),
 ('v[8190];main(){extrn v;v[8189]=42;return(v[0]+v[8189]);}',42),
 ('x 1,2,3;main(){extrn x;return((&x)[0]+(&x)[1]+(&x)[2]);}',6),
 ('f(){return("A");}g(){return("A");}main(){auto p,q;p=f();q=g();*p=42;return(*f()+(*g()==0101+4*256));}',43),
 ('peek(s,i){return((s[i/8]>>((i%8)*8))&255);}main(){return(peek("123456789*0AB",9)+peek("123456789*0AB",11));}',66),
]

ABI_CASES=[(0,0,2,0),(0,1,2,1),(0,2,2,3),(0,5,2,3),(1,8,2,8),
           (2,0,0,0),(2,8,0,8),(3,15,1,120),(4,1,1,141),(5,1,1,15),
           (6,0,0,None),(7,0,0,None),(8,0,0,None),(9,0,32767,0),
           (3,4095,1,4095*4096//2)]


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler',type=Path,default=PROJECT/'bcc')
    parser.add_argument('--bootstrap',action='store_true')
    args=parser.parse_args()
    command=[str(args.compiler.resolve()),'--strict','--pedantic']
    if not args.bootstrap:command.append('--word=host')
    execute=platform.system()=='Linux' and platform.machine().lower() in ('x86_64','amd64')
    tool_free=dict(os.environ,PATH='')
    passed=0
    with tempfile.TemporaryDirectory(prefix='bcc-native-calls-') as directory:
        work=Path(directory)
        def build(name,text):
            path=work/(name+'.b');path.write_text(text)
            run=subprocess.run([*command,str(path),'-o',str(work/name)],capture_output=True,timeout=180)
            assert run.returncode==0,(name,run.stderr)
        parts=[NATIVE/'src'/name for name in ('buffered_io.b','decimal16.b','diagnostics.b','ic.b')]
        parts += [ROOT/name for name in ('x64.b','labels.b','ops.b','scalar.b','memory.b','control.b','arity.b','calls.b','data/layout.b','data/output.b')]
        common='\n'.join(path.read_text() for path in parts)
        build('abi',common+(FIXTURES/'abi.b').read_text())
        build('constructor',common+'\n'.join((FIXTURES/name).read_text() for name in ('metadata.b','emission.b','driver.b')))
        build('front',frontend.source_text());build('resolver',pass_source('resolver'))
        build('image',(ROOT/'elfimage.b').read_text());(work/'empty').write_bytes(b'')

        def image_check(name,code,data,value,status=0):
            nonlocal passed
            (work/'code').write_bytes(code)
            image=subprocess.run([str(work/'image'),'code',data,'0','0'],cwd=work,
                                 capture_output=True,timeout=30,env=tool_free)
            assert(image.returncode,image.stderr)==(0,b''),(name,image)
            if execute:
                (work/'result').write_bytes(image.stdout);(work/'result').chmod(0o700)
                run=subprocess.run([str(work/'result')],capture_output=True,timeout=10,env=tool_free)
                expected=b'' if value is None else struct.pack('<q',value)
                assert(run.returncode,run.stdout,run.stderr)==(status,expected,b''),(name,run,expected)
            passed+=1

        for kind,nargs,params,value in ABI_CASES:
            run=subprocess.run([str(work/'abi'),str(kind),str(nargs),str(params)],cwd=work,
                               capture_output=True,timeout=60,env=tool_free)
            assert(run.returncode,run.stderr)==(0,b''),((kind,nargs,params),run)
            image_check(f'abi/{kind}/{nargs}/{params}',run.stdout,'empty',value,0 if value is not None else 77)
        for kind in range(20,45):
            run=subprocess.run([str(work/'abi'),str(kind),'0','1'],cwd=work,
                               capture_output=True,timeout=30,env=tool_free)
            expected=b'x64 scalar'
            if kind==37:expected=b'bad IC integer'
            if kind in (40,43,44):expected=b'x64 labels'
            assert run.returncode!=0 and expected in run.stderr,(kind,run,expected)
            passed+=1

        def records(text):
            (work/'input.b').write_text(text)
            run=subprocess.run([str(work/'front'),'input.b'],cwd=work,
                               capture_output=True,timeout=30,env=tool_free)
            assert(run.returncode,run.stderr)==(0,b''),(text,run)
            (work/'raw.ic').write_bytes(run.stdout)
            run=subprocess.run([str(work/'resolver'),'-i','raw.ic'],cwd=work,
                               capture_output=True,timeout=30,env=tool_free)
            assert(run.returncode,run.stderr)==(0,b''),(text,run)
            (work/'resolved.ic').write_bytes(run.stdout)

        def construct(data='data'):
            return subprocess.run([str(work/'constructor'),'raw.ic','resolved.ic',data],cwd=work,
                                  capture_output=True,timeout=60,env=tool_free)

        cases=list(SOURCE_CASES)
        cases.append((''.join(f'f{i}(){{return({i});}}' for i in range(199))+'main(){return(198);}',198))
        for index,(text,value) in enumerate(cases):
            # Controlled fixtures have no strings; rename the original entry and its references.
            reference=re.sub(r'(?<![A-Za-z0-9_\x08])main(?![A-Za-z0-9_\x08])','zzentry',text)
            assert reference!=text
            reference+='main(){extrn zzentry,write;auto value;value=zzentry();write(1,&value,8);return(0);}'
            build('reference',reference)
            run=subprocess.run([str(work/'reference')],capture_output=True,timeout=30)
            assert(run.returncode,run.stdout,run.stderr)==(0,struct.pack('=q',value),b''),(index,run,value)
            passed+=1
            records(text);run=construct()
            assert(run.returncode,run.stderr)==(0,b''),(index,text,run)
            image_check('source/'+str(index),run.stdout,'data',value)

        (work/'raw.ic').write_bytes(b'Adef main\nAend\n')
        (work/'resolved.ic').write_bytes(b'Glit 1 4\npr main 0 30000\nst 0\ndr\nrt\nep 0\n')
        run=construct();assert(run.returncode,run.stderr)==(0,b''),run
        image_check('preassigned-literal',run.stdout,'data',4)

        unsupported=['main(x){return(x);}', 'f(){return(0);}',

                     'main(){return(unknown());}',
                     'main(){switch 1 {case 1:return(7);}return(0);}',
                     'main(){goto done;done:return(0);}']
        for text in unsupported:
            records(text);run=construct()
            assert run.returncode!=0 and run.stderr,(text,run)
            passed+=1
        malformed=[
            (b'Adef main\nAend\nAdef main\nAend\n',b'pr main 0 30000\nn 0\nrt\nep 0\n'),
            (b'Adef main\nAend\n',b'pr other 0 30000\nn 0\nrt\nep 0\n'),
            (b'Adef main\nAend\n',b'pr main 0 30000\nn 0\nrt\n'),
            (b'Adef main\nAend\n',b'ep 0\n'),
            (b'Adef main\nAend\n',b'pr main 0 30000\nep 8192\n'),
            (b'Adef main\nAend\n',b'pr main 0 30000\nar 0\nrt\nep 0\n'),
            (b'Adef main\nAend\n',b'pr main 0 30000\ncl -1\nrt\nep 0\n'),
        ]
        for index,(raw,resolved) in enumerate(malformed):
            (work/'raw.ic').write_bytes(raw);(work/'resolved.ic').write_bytes(resolved)
            run=construct();assert run.returncode!=0 and run.stderr,(index,run);passed+=1
        records('main(){return(0);}')
        (work/'directory').mkdir()
        run=construct('directory');assert run.returncode!=0 and b'static data open' in run.stderr,run
        passed+=1
        print(f'{passed} native-call checks passed')
        if not execute:print('SKIP: native image execution requires Linux x86-64')


if __name__=='__main__':main()
