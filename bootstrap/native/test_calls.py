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
spec=importlib.util.spec_from_file_location('wide_frontend',ROOT/'frontend/build.py')
frontend=importlib.util.module_from_spec(spec)
spec.loader.exec_module(frontend)
spec=importlib.util.spec_from_file_location('host_resolver',ROOT/'resolver/build.py')
resolver=importlib.util.module_from_spec(spec)
spec.loader.exec_module(resolver)
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

SOURCE_CASES.append(('v[128] '+','.join(['9223372036854775807']*128)+';main(){extrn v;return(v[127]);}', (1<<63)-1))

SOURCE_CASES += [
 ('main(){goto done;return(1);done:return(42);}',42),
 ('main(){auto p;p=done;goto p;return(1);done:return(42);}',42),
 ('main(){auto i;i=0;again:i++;if(i<10)goto again;return(i);}',10),
 ('main(){first=second;goto first;first:return(1);second:return(42);}',42),
 ('saved;f(n){extrn saved;if(n){saved=done;return(0);}goto saved;done:return(42);}main(){f(1);return(f(0));}',42),
 ('main(){auto v 2;v[0]=first;v[1]=second;goto v[1];first:return(1);second:return(42);}',42),
 ('main(){auto p;p= &first;*p=second;goto first;first:return(1);second:return(42);}',42),
]

SOURCE_CASES += [
 ('main(){switch 1 {case 1:return(42);}return(0);}',42),
 ('main(){switch 0 {case 1:return(7);}return(42);}',42),
 ('main(){switch 0 {}return(42);}',42),
 ('main(){auto n;n=0;switch 1 {case 1:n=7;case 2:n=+35;}return(n);}',42),
 ('main(){switch 1 {case 1:switch 2 {case 1:return(1);case 2:return(42);}}return(0);}',42),
 ('main(){switch 9223372036854775808 {case 9223372036854775807:return(1);case 9223372036854775808:return(42);}return(0);}',42),
 ('main(){auto i,n;i=0;n=0;while(i<10){switch i {case 3:n=+7;case 8:n=+9;}i++;}return(n);}',25),
 ('f(){return(42);}main(){switch 1 {case 1:return(f());}return(0);}',42),
 ('main(){switch 1 {case 1:goto done;case 2:return(1);}done:return(42);}',42),
 ('main(){goto inside;switch 2 {case 1:inside:return(42);case 2:return(1);}return(0);}',42),
]

SOURCE_CASES += [
 ('main(){return(&one!=&two);one:two:return(0);}',1),
 ('f(){return(done);done:return(0);}g(){return(done);done:return(0);}main(){return(f()!=g());}',1),
 ('f(n){switch n {case 0:return(0);case 1:return(1);}return(f(n-1)+f(n-2));}main(){return(f(10));}',55),
]

SOURCE_CASES += [
 ('main(){switch 4294967296 {case 0:return(1);case 4294967296:return(42);}return(0);}',42),
 ('main(){switch 4294967297 {case 1:return(1);}return(42);}',42),
]

SOURCE_CASES += [
 ('main(){extrn char;return(char("ABCDEFGHxyz",8));}',120),
 ('main(){extrn char,lchar;auto p;p="ABCDEFGHxyz";lchar(p,8,321);return(char(p,8));}',65),
 ('main(){extrn lchar;return(lchar("abc",1,321));}',321),
 ('main(){extrn close;return(close(-1));}',-1),
 ('main(){extrn read;auto b 2;return(read(-1,b,1));}',-1),
 ('main(){extrn write;return(write(-1,"hello",5));}',-1),
 ('main(){extrn seek;return(seek(-1,0,0));}',-1),
 ('main(){extrn open;return(open("",0));}',-1),
 ('main(){extrn creat;return(creat("",016));}',-1),
 ('main(){extrn chmod;return(chmod("",016));}',-1),
 ('main(){extrn unlink;return(unlink(""));}',-1),
 ('char(x,y){return(42);}main(){return(char("abc",0));}',42),
 ('char 42;main(){extrn char;return(char);}',42),
 ('char[1] 42;main(){extrn char;return(char[0]);}',42),
 ('main(){auto char;char=42;return(char);}',42),
 ('main(){extrn char;return(char("ABC",1));}char(x,y){return(42);}',42),
 ('saved char;main(){extrn saved;return((*saved)("ABC",1));}',66),
 ('f(x,y){return(42);}main(){extrn char,f;auto old;old=char;char=f;return(old("ABC",1)+char(0,0));}',108),
 ('f(x,y){return(42);}main(){extrn char,f;auto p;p= &char;*p=f;return(char(0,0));}',42),
 ('f(p){return(p("ABC",2));}main(){extrn char;return(f(char));}',67),
]

SOURCE_CASES += [
 ('main(){extrn argv;return(argv[0]);}',1),
 ('main(){extrn argv,char;return(char(argv[1],0));}',47),
 ('saved argv;main(){extrn argv,saved;return(*saved==argv);}',1),
 ('main(){extrn argv;auto old,v 1;old=argv;v[0]=42;argv=v;if(argv[0]!=42)return(1);*(&argv)=old;return(argv[0]);}',1),
 ('argv[1] 42;main(){extrn argv;return(argv[0]);}',42),
 ('argv(){return(42);}main(){return(argv());}',42),
 ('main(){auto argv 1;argv[0]=42;return(argv[0]);}',42),
]

SOURCE_CASES += [
 ('main(){extrn wait;return(wait());}',-1),
 ('main(){extrn fork,wait,exit;auto p;p=fork();if(p<0)return(1);if(!p)exit();return(wait()!=p);}',0),
 ('value 7;main(){extrn value,fork,wait,exit;auto p;p=fork();if(p<0)return(1);if(!p){value=99;exit();}if(wait()!=p)return(2);return(value);}',7),
 ('fork(){return(42);}main(){return(fork());}',42),
 ('wait 42;main(){extrn wait;return(wait);}',42),
 ('main(){extrn wait;auto saved;saved=wait;return(saved());}',-1),
 ('main(){extrn fork,wait,exit;auto p;p=fork();if(p<0)return(1);if(!p)exit(42);return(wait()!=p);}',0),
]


ABI_CASES=[(0,0,2,0),(0,1,2,1),(0,2,2,3),(0,5,2,3),(1,8,2,8),
           (2,0,0,0),(2,8,0,8),(3,15,1,120),(4,1,1,141),(5,1,1,15),
           (6,0,0,None),(7,0,0,None),(8,0,0,None),(9,0,32767,0),
           (3,4095,1,4095*4096//2),(10,0,0,42),(10,8,20,42)]


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
        parts += [ROOT/name for name in ('x64.b','labels.b','ops.b','scalar.b','memory.b','control.b', 'switch.b','arity.b','calls.b','runtime/emit.b','runtime/path.b','runtime/argv.b','runtime/imports.b','data/layout.b','data/labels.b','data/output.b')]
        common='\n'.join(path.read_text() for path in parts)
        build('abi',common+(FIXTURES/'abi.b').read_text())
        build('constructor',common+'\n'.join((FIXTURES/name).read_text() for name in ('metadata.b','emission.b','driver.b')))
        build('front',frontend.source_text());build('resolver',resolver.source_text())
        build('image',(ROOT/'elfimage.b').read_text());(work/'empty').write_bytes(b'')

        def image_check(name,code,data,value,status=0,prefix=b'',stderr=b'',arguments=(),environment=None):
            nonlocal passed
            (work/'code').write_bytes(code)
            image=subprocess.run([str(work/'image'),'code',data,'0','0'],cwd=work,
                                 capture_output=True,timeout=30,env=tool_free)
            assert(image.returncode,image.stderr)==(0,b''),(name,image)
            if execute:
                (work/'result').write_bytes(image.stdout);(work/'result').chmod(0o700)
                run=subprocess.run([str(work/'result'),*arguments],cwd=work,stdin=subprocess.DEVNULL,capture_output=True,timeout=10,env=tool_free if environment is None else environment)
                expected=prefix+(b'' if value is None else struct.pack('<q',value))
                assert(run.returncode,run.stdout,run.stderr)==(status,expected,stderr),(name,run,expected)
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

        def construct(data='data',mode=None):
            command=[str(work/'constructor'),'raw.ic','resolved.ic',data]
            if mode is not None:command.append(mode)
            return subprocess.run(command,cwd=work,
                                  capture_output=True,timeout=60,env=tool_free)

        cases=list(SOURCE_CASES)
        cases.append((''.join(f'f{i}(){{return({i});}}' for i in range(199))+'main(){return(f198());}',198))
        for index,(text,value) in enumerate(cases):
            # Rename the entry and its references in these controlled fixtures.
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

        (work/'map-input').write_bytes(bytes(4096)+b'M'+bytes(4095))
        runtime_cases = [
            ('main(){extrn __sys;auto p,v,x;p=__sys(9,0,4096,3,34,-1,0);if(p<0)return(1);v=p>>3;*v=42;x= *v;if(__sys(11,p,4096,0,0,0,0))return(2);return(x);}',42,0,b'',b''),
            ('main(){extrn __sys,open,close,char;auto fd,p,x;fd=open("map-input",0);if(fd<0)return(1);p=__sys(9,0,4096,1,2,fd,4096);if(p<0)return(2);x=char(p>>3,0);if(__sys(11,p,4096,0,0,0,0))return(3);close(fd);return(x);}',77,0,b'',b''),
            ('main(){extrn __sys;return(__sys(39,0,0,0,0,0,0)>0);}',1,0,b'',b''),
            ('main(){extrn __sys;return(__sys(3,-1,0,0,0,0,0));}',-9,0,b'',b''),
            ('main(){extrn __sys;auto p;p="S";return(__sys(1,1,p<<3,1,0,0,0));}',1,0,b'S',b''),
            ('main(){extrn __sys;return(__sys(39,0,0,0,0,0));}',None,77,b'',b''),
            ('__sys(a,b,c,d,e,f,g){return(42);}main(){return(__sys(0,0,0,0,0,0,0));}',42,0,b'',b''),
            ('main(){extrn write;return(write(1,"A",1));}', 1, 0, b'A', b''),
            ('main(){extrn write;return(write(2,"B",1));}', 1, 0, b'', b'B'),
            ('main(){extrn exit;exit();return(99);}', None, 0, b'', b''),
            ('main(){extrn exit;exit(42);return(99);}', None, 42, b'', b''),
            ('main(){extrn char;return(char("A"));}', None, 77, b'', b''),
            ('main(){extrn open;return(open("missing"));}', None, 77, b'', b''),
            ('write(a,b,c){return(42);}main(){return(write(0,0,0));}', 42, 0, b'', b''),
            ('write 42;main(){extrn write;return(write);}', 42, 0, b'', b''),
            ('main(){extrn creat,write,close,open,read,char,unlink;auto fd,b 2;'
             'fd=creat("runtime-file",016);if(fd<0)return(1);'
             'if(write(fd,"ABC",3)!=3)return(2);if(close(fd))return(3);'
             'fd=open("runtime-file",0);if(fd<0)return(4);'
             'if(read(fd,b,3)!=3)return(5);if(close(fd))return(6);'
             'if(unlink("runtime-file"))return(7);return(char(b,2));}',67,0,b'',b''),
        ]
        for index,(text,value,status,prefix,stderr) in enumerate(runtime_cases):
            records(text);run=construct()
            assert (run.returncode,run.stderr)==(0,b''),(index,text,run)
            image_check('runtime/'+str(index),run.stdout,'data',value,status,prefix,stderr)
        assert not (work/'runtime-file').exists()
        records('main(){extrn argv,char;if(argv[0]!=4)return(1);'
                'if(char(argv[2],0)!=0 | char(argv[3],0)!=255)return(2);'
                'if(char(argv[3],1)!=4 | char(argv[3],2)!=0)return(3);'
                'return(char(argv[4],3));}')
        run=construct()
        assert (run.returncode,run.stderr)==(0,b''),run
        image_check('argument-vector',run.stdout,'data',32,arguments=[b'',b'\xff\x04',b'two words'])

        (work/'raw.ic').write_bytes(b'Adef main\nAend\n')
        (work/'resolved.ic').write_bytes(b'Glit 1 4\npr main 0 30000\nst 0\ndr\nrt\nep 0\n')
        run=construct();assert(run.returncode,run.stderr)==(0,b''),run
        image_check('preassigned-literal',run.stdout,'data',4)

        exec_environment = {'BCC_EXEC_TEST': 'kept', 'PATH': ''}
        helper = ('main(){extrn argv,char,__env,__sys;auto p;'
                  'if(argv[0]!=3)return(1);'
                  'if(char(argv[2],0)!=0 | char(argv[3],0)!=65)return(2);'
                  'p=__env>>3;if(__sys(1,1,p[0],18,0,0,0)!=18)return(3);return(37);}')
        records(helper);run=construct(mode='run')
        assert (run.returncode,run.stderr)==(0,b''),run
        image_check('exec-helper',run.stdout,'data',None,37,prefix=b'BCC_EXEC_TEST=kept',
                    arguments=[b'',b'A'],environment=exec_environment)
        (work/'helper').write_bytes((work/'result').read_bytes())
        (work/'helper').chmod(0o700)
        exec_library = (ROOT/'lib/execv.b').read_text()
        text = exec_library + ('main(){extrn execv;auto v 3;v[0]="custom";v[1]="";'
                               'v[2]="A";execv("./helper",v,3);return(99);}')
        records(text);run=construct()
        assert (run.returncode,run.stderr)==(0,b''),run
        image_check('execv-replacement',run.stdout,'data',None,37,prefix=b'BCC_EXEC_TEST=kept',
                    environment=exec_environment)
        records(exec_library+'main(){extrn execv,lchar;auto p 7800,v 1,i;'
                'i=0;while(i<62392)lchar(p,i++,65);lchar(p,62392,4);v[0]=p;'
                'execv("helper",v,1);return(99);}')
        run=construct()
        assert (run.returncode,run.stderr)==(0,b''),run
        image_check('execv-exact-copy-bound',run.stdout,'data',None,1)
        exec_errors = [
            'return(execv());',
            'return(execv("helper"));',
            'return(execv("helper",0));',
            'return(execv(0,0,0));',
            'return(execv("missing",0,2));',
            'return(execv("missing",0,-1));',
            'return(execv("missing",0,256));',
            'return(execv("missing",0,0));',
            'auto v 2;v[0]="helper";v[1]=0;return(execv("helper",v,2));',
            'auto v 1,p;p="missing";v[0]=p;if(execv(p,v,1)!=-1)return(1);return(char(p,7)==4?-1:2);',
            'auto p 513,i;i=0;while(i<4096)lchar(p,i++,47);lchar(p,4096,4);return(execv(p,0,0));',
            'auto p 7800,v 1,i;i=0;while(i<62399)lchar(p,i++,65);lchar(p,62399,4);v[0]=p;return(execv("helper",v,1));',
        ]
        for index, body in enumerate(exec_errors):
            records(exec_library+'main(){extrn execv,char,lchar;'+body+'}')
            run=construct()
            assert (run.returncode,run.stderr)==(0,b''),(index,run)
            image_check('execv-error/'+str(index),run.stdout,'data',-1)

        records('main(){return(37);}');run=construct(mode='run')
        assert (run.returncode,run.stderr)==(0,b''),run
        image_check('normal-return',run.stdout,'data',None,37)
        run=construct(mode='unknown')
        assert (run.returncode,run.stdout,run.stderr)==(2,b'',b''),run
        passed+=1

        records('main(){goto 0;}');run=construct()
        assert(run.returncode,run.stderr)==(0,b''),run
        image_check('null-goto',run.stdout,'data',None,77)

        unsupported=['main(x){return(x);}', 'f(){return(0);}', 'main(){return(unknown());}']
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
