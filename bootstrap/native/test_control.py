#!/usr/bin/env python3
"""Execute structured branch and conditional-expression records as native code."""
import argparse
import importlib.util
import os
from pathlib import Path
import platform
import struct
import subprocess
import sys
import tempfile

ROOT=Path(__file__).resolve().parent
PROJECT=ROOT.parents[1]
NATIVE=PROJECT/'pdp-11/bcc-pdp/bootstrap'
sys.path.insert(0,str(NATIVE/'tools'))
from build_passes import source_text as pass_source
spec=importlib.util.spec_from_file_location('wide_frontend',ROOT/'frontend/build.py')
frontend=importlib.util.module_from_spec(spec)
spec.loader.exec_module(frontend)
HARNESS=r'''
number(s){extrn char;auto i,n,c;i=0;n=0;while((c=char(s,i++))>='0'&c<='9')n=n*10+c-'0';return(n);}
guard(){
 auto start;
 /* Skip the fixed-width exit sequence when the preceding comparison agrees. */
 xjcc(4,22);start=xtell();xmovim(0,60);xmovim(7,78);xsys();
 if(xtell()!=start+22)xfail();
}
report(){
 xbin(5,4,3);guard();xmovim(2,123456789);xbin(5,5,2);guard();
 xstack(0,0);xmov(6,4);xmovim(0,1);xmovim(7,1);xmovim(2,8);xsys();
 xmovim(0,60);xmovim(7,0);xsys();
 xmark(4095);xmovim(0,60);xmovim(7,77);xsys();
}
main(){
 extrn argv,open,close,creat;auto n,fd,pass,buf 520,mode,ret;
 if(argv[0]!=3 & argv[0]!=4)return(2);
 mode=0;if(argv[0]==4)mode=number(argv[4]);
 fd=open(argv[2],0);if(fd<0)fatal("input open");n=xcfscan(fd);
 if(close(fd)<0)fatal("scan close");pass=1;
 while(pass<=2){
  fd=open(argv[2],0);if(fd<0)fatal("input reopen");icini(fd);
  if(pass==1)xstart(creat("layout",0600));else xstart(1);
  xlblbeg(pass);xrinit(n,4094,4095);
  if(mode==1)xcfend();
  ret=4094;if(mode==5)ret=0;if(mode==6)ret=4095;if(mode==7)ret=4093;if(mode==8)ret=4096;if(mode==9)ret= -1;
  xcfbeg(ret);if(mode==2)xcfbeg(ret);if(mode==4)xcfscan(fd);
  xmov(3,4);xmovim(5,123456789);xmframe(number(argv[3]));
  while(getln(buf,1040))if(!xcfline(buf))if(!xmline(buf))xrline(buf);
  xcfend();if(mode==3)xcfend();
  if(close(fd)<0)fatal("input close");xmleave();report();xlblend();xfinish();pass++;
 }
 return(0);
}
'''


def cases():
    return [
        ('return(7);',7),
        ('if(1)return(3);else return(5);',3),
        ('if(0)return(3);else return(5);',5),
        ('if(0)return(1);return(2);',2),
        ('if(1){if(0)return(1);else return(2);}return(3);',2),
        ('auto i,s;i=0;s=0;while(i<10){s=+i;i++;}return(s);',45),
        ('auto i;i=0;while(i<10){if(i==5)return(i);i++;}return(99);',5),
        ('auto i;i=0;while(i++<5);return(i);',6),
        ('auto i;i=0;while(0)i++;return(i);',0),
        ('auto i,j,s;i=0;s=0;while(i<4){j=0;while(j<3){s=+i+j;j++;}i++;}return(s);',30),
        ('auto a 4,i,s;i=0;while(i<4){a[i]=i*i;i++;}i=0;s=0;while(i<4){s=+a[i];i++;}return(s);',14),
        ('return(5+(1?7:9)*2);',19),('return(5+(0?7:9)*2);',23),
        ('auto x,y;x=0;y=(1?++x:99);return(y+x);',2),
        ('auto x,y;x=0;y=(0?99:++x);return(y+x);',2),
        ('return(1?(0?2:3):(1?4:5));',3),
        ('return(1+2*(1?(0?3:4):5));',9),
        ('auto a 2,i,r;i=0;a[0]=0;a[1]=0;r=(1?(a[i++]=3):(a[i++]=4));return(r*100+i*10+a[0]);',313),
        ('auto a 2,i,r;i=0;a[0]=0;a[1]=0;r=(0?(a[i++]=3):(a[i++]=4));return(r*100+i*10+a[0]);',414),
        ('return(0?(0?2:3):(1?4:5));',4),
        ('return(0?1:0?2:3);',3),
        ('auto i;i=0;while(i<3?(i<2?1:0):0)i++;return(i);',2),
        ('auto x;x=5;x=+(0?99:7);return(x);',12),
        ('return(0?1/0:42);',42),('if(0)return(1/0);return(43);',43),
        ('while(0){return(1/0);}return(44);',44),
        ('return(42);return(1/0);',42),
        ('auto break;break=7;if(break)return(break);return(0);',7),
        ('auto x;x=0;if(0){auto v 2;v[0]=9;}else x=3;return(x);',3),
        ('switch 1 {case 1:return(42);}return(0);',42),
        ('switch 9 {case 1:return(1);}return(42);',42),
        ('switch 9 {}return(42);',42),
        ('auto n;n=2;switch n++ {case 2:n=+39;}return(n);',42),
        ('switch 1 {case 1:'*16+'return(42);'+'}'*16+'return(0);',42),
        ('switch 31 {'+''.join(f'case {i}:return({i});' for i in range(32))+'}return(42);',31),
        ('switch 33 {'+''.join(f'case {i}:return({i});' for i in range(32))+'}return(42);',42),
    ]


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
    with tempfile.TemporaryDirectory(prefix='bcc-control-') as directory:
        work=Path(directory)
        def build(name,text):
            path=work/(name+'.b');path.write_text(text)
            run=subprocess.run([*command,str(path),'-o',str(work/name)],capture_output=True,timeout=180)
            assert run.returncode==0,(name,run.stderr)
        parts=[NATIVE/'src'/name for name in ('buffered_io.b','decimal16.b','diagnostics.b','ic.b')]
        parts += [ROOT/name for name in ('x64.b','labels.b','ops.b','scalar.b','memory.b','control.b','switch.b')]
        build('lower','\n'.join(path.read_text() for path in parts)+HARNESS)
        build('front',frontend.source_text());build('resolver',pass_source('resolver'))
        build('image',(ROOT/'elfimage.b').read_text())
        fixtures=cases()
        reference=''.join(f'f{i}(){{'+body+'}\n' for i,(body,_) in enumerate(fixtures))
        reference+='main(){extrn write;auto v;'+''.join(f'v=f{i}();write(1,&v,8);' for i in range(len(fixtures)))+'return(0);}'
        build('reference',reference)
        run=subprocess.run([str(work/'reference')],capture_output=True,timeout=30)
        expected=b''.join(struct.pack('=q',value) for _,value in fixtures)
        assert(run.returncode,run.stdout,run.stderr)==(0,expected,b''),run
        passed+=len(fixtures);(work/'empty').write_bytes(b'')
        def check(name,records,locals=0,value=None,status=0,error=False,mode=0):
            nonlocal passed
            (work/'input.ic').write_bytes(records)
            run=subprocess.run([str(work/'lower'),'input.ic',str(locals),str(mode)],cwd=work,
                               capture_output=True,timeout=30,env=tool_free)
            if error:
                assert run.returncode!=0 and run.stderr,(name,run)
            else:
                assert(run.returncode,run.stderr)==(0,b''),(name,run)
                (work/'code').write_bytes(run.stdout)
                image=subprocess.run([str(work/'image'),'code','empty','0','0'],cwd=work,
                                     capture_output=True,timeout=30,env=tool_free)
                assert(image.returncode,image.stderr)==(0,b''),(name,image)
                if execute:
                    (work/'result').write_bytes(image.stdout);(work/'result').chmod(0o700)
                    run=subprocess.run([str(work/'result')],capture_output=True,timeout=10,env=tool_free)
                    expected=b'' if value is None else struct.pack('<q',value)
                    assert(run.returncode,run.stdout,run.stderr)==(status,expected,b''),(name,run,expected)
            passed+=1
        for body,value in fixtures+[('return(1?1/0:42);',None),('if(1)return(1/0);return(42);',None)]:
            (work/'input.b').write_text('main(){'+body+'}')
            front=subprocess.run([str(work/'front'),'input.b'],cwd=work,capture_output=True,timeout=30,env=tool_free)
            assert(front.returncode,front.stderr)==(0,b''),(body,front)
            (work/'raw.ic').write_bytes(front.stdout)
            resolved=subprocess.run([str(work/'resolver'),'-i','raw.ic'],cwd=work,
                                    capture_output=True,timeout=30,env=tool_free)
            assert(resolved.returncode,resolved.stderr)==(0,b''),(body,resolved)
            lines=resolved.stdout.splitlines()
            assert lines[0].startswith(b'pr main ') and lines[-1].startswith(b'ep '),lines
            check(body,b'\n'.join(lines[1:-1])+b'\n',int(lines[-1].split()[1]),value,0 if value is not None else 77)
        check('fallthrough',b'',value=0)
        check('duplicate-case-order',b'n 1\nswb 1\nswc 1 2 1 3\nn 7\nrt\nswc 2 4 1 5\nn 9\nrt\nswx 4 6\n',value=7)
        check('null-goto',b'n 0\ngor\n',value=None,status=77)
        check('high-label',b'jm 32767\nn 1\nrt\nlb 32767\nn 7\nrt\n',value=7)
        collision=b''.join(f'lb {i*4096}\n'.encode() for i in range(8))+b'n 9\nrt\n'
        check('hash-collisions',collision,value=9)
        maximum=b''.join(f'lb {i}\n'.encode() for i in range(4093))
        check('label-capacity',maximum+b'n 11\nrt\n',value=11)
        check('label-overflow',maximum+b'lb 4093\nn 11\nrt\n',error=True)
        invalid=[b'jm 1\n',b'lb 1\nlb 1\n',b'lb -1\n',b'lb 32768\n',b'lb 1 2\n',
                 b'jm 1 2\nlb 1\n',b'bf 1\nlb 1\n',b'n 1\nbf 1 2\nlb 1\n',
                 b'n 1\nps\njm 1\nlb 1\n',b'n 1\nps\nlb 1\n',b'n 1\nps\nrt\n',
                 b'rt 1\n',b'n 1\ntq 1\n',b'tq 1\n',b'n 1\ntc 1 2\n',
                 b'n 1\nte 2\n',b'n 1\ntq 1\nps\ntc 1 2\n',
                 b'n 1\ntq 1\nn 2\ntc 1 2\nn 3\nps\nte 2\n',
                 b'n 1\ntq 1\nn 2\ntc 1 2\nte 2\n',
                 b'n 1\ntq 1\nn 2\ntc 1 2\nn 3\nte 2\nte 2\n',
                 b'jm 1\nn 1\ntq 1\nn 2\ntc 1 2\nn 3\nte 2\n',
                 b'n 1\ntq 1\nn 2\ntc 1 1\n',b'n 1\ntq 1\nlb 1\n',
                 b'n 1\ntq 1 2\n',b'n 1\ntq 1\nn 2\ntc 1 2 3\n',
                 b'n 1\ntq 1\nn 2\ntc 1 2\nn 3\nte 2 3\n',
                 b'n 1\ntq 1\nn 2\ntq 1\n',b'n 1\nps\n',b'swb 1\n',b'gor\n',b'cl 0\n']
        invalid += [
            b'n 1\nswb 1\n', b'swc 1 2 7 3\n', b'swx 1 2\n',
            b'n 1\nswb 1\nswx 2 3\n', b'n 1\nswb 1\nswc 2 3 7 4\n',
            b'n 1\nswb 1\nswc 1 1 7 3\n', b'n 1\nswb 1\nlb 1\n',
            b'n 1\nps\nn 2\nswb 1\nswx 1 2\n',
            b'n 1\nswb 1\nswc 1 2 9223372036854775808 3\nswx 2 4\n',
            b'n 1\nswb 1\nswx 1 2 3\n', b'n 1\ngor 7\n', b'n 1\nps\nn 2\ngor\n',
            b''.join(f'n 1\nswb {i}\n'.encode() for i in range(17)),
            b'n 1\nswb 0\n'+b''.join(f'swc {i} {i+1} {i} {100+i}\n'.encode() for i in range(33))+b'swx 33 200\n',
        ]
        for index,records in enumerate(invalid):check('invalid/'+str(index),records,error=True)
        for mode in range(1,10):check('api/'+str(mode),b'lb 0\nn 7\nrt\n',error=True,mode=mode)
        print(f'{passed} control-flow lowering checks passed')
        if not execute:print('SKIP: native image execution requires Linux x86-64')


if __name__=='__main__':main()
