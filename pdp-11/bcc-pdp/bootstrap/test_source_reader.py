#!/usr/bin/env python3
"""Check source buffering, short reads, delayed errors, and reader reentry."""
import argparse
import math
from pathlib import Path
import re
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[2]
sys.path.insert(0,str(ROOT/'tools'))
from build_passes import source_text

WRAPPER = r'''
rchunks 128; rerrat -1; rtotal 0; rcalls 0;
tread(fd,b,n) {
    extrn rchunks,rerrat,rtotal,rcalls,read;auto k;
    rcalls++;
    if(rerrat>=0) if(rtotal>=rerrat) return(-1);
    if(n>rchunks) n=rchunks;
    if(rerrat>=0) if(n>rerrat-rtotal) n=rerrat-rtotal;
    k=read(fd,b,n);if(k>0) rtotal=rtotal+k;return(k);
}
rnumber(s) {
    extrn char;auto i,n,c,neg;
    i=0;n=0;neg=0;if(char(s,0)=='-') {neg=1;i++;}
    while((c=char(s,i++))>='0' & c<='9') n=n*10+c-'0';
    if(neg) return(-n);return(n);
}
'''
MAIN = r'''
main() {
    extrn argv,rchunks,rerrat,rcalls;auto v 4,path;
    if(argv[0]!=4) return(2);
    rchunks=rnumber(argv[2]);rerrat=rnumber(argv[3]);path=argv[4];
    v[0]=2;v[1]="front";v[2]=path;argv=v;
    if(frontcli()) return(1);
    bouts("calls ");outd(rcalls);outln();oflush();return(0);
}
'''
REENTRY = r'''
main(){
 extrn open,close,seek,lineno,rcalls;auto a,b;
 a=open("first",0);b=open("second",0);if(a<0|b<0)return(1);
 lexini(a);if(gtch()!=10|lineno!=2|rcalls!=1)return(2);
 unch(10);if(lineno!=1)return(3);
 if(gtch()!=10|lineno!=2|rcalls!=1)return(4);
 if(gtch()!='a'|rcalls!=1)return(5);
 lexini(b);if(lineno!=1|gtch()!='Z'|rcalls!=2)return(6);
 if(seek(a,0,0)<0)return(7);
 lexini(a);if(lineno!=1|gtch()!=10|lineno!=2|rcalls!=3)return(8);
 if(gtch()!='a')return(9);
 if(close(a)<0|close(b)<0)return(10);return(0);
}
'''


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler',type=Path,default=PROJECT/'bcc')
    parser.add_argument('--bootstrap',action='store_true')
    args=parser.parse_args()
    source=source_text('frontend')
    # Wrap only the actual input read, leaving the wrapper's real read untouched.
    source,changed=re.subn(r'\bread\(inpfd,\s*sinbuf,\s*128\)',
                          'tread(inpfd,sinbuf,128)',source)
    if changed!=1 or source.count('main() {')!=1:
        raise AssertionError('frontend input/entry shape changed; review the harness')
    source=source.replace('main() {','frontcli() {')+WRAPPER
    modes=(None,) if args.bootstrap else ('16','32','host')
    passed=0
    with tempfile.TemporaryDirectory(prefix='bcc-source-reader-') as directory:
        work=Path(directory)
        for word in modes:
            command=[str(args.compiler.resolve()),'--strict','--pedantic']
            if word:
                command.append('--word='+word)
            for name,entry in [('front',MAIN),('reentry',REENTRY)]:
                path=work/(name+'.b');path.write_text(source+entry)
                build=subprocess.run([*command,str(path),'-o',str(work/name)],
                                     capture_output=True,timeout=180)
                assert build.returncode==0,(word,name,build.stderr)
            expected=b'Adef main\nn 42\nrt\nAend\n'
            for prefix in (0,1,126,127,128,129,255,256,257,511):
                data=b' '*prefix+b'main(){return(42);}\n'
                (work/'input.b').write_bytes(data)
                def run(chunks,fail):
                    return subprocess.run([str(work/'front'),str(chunks),str(fail),'input.b'],
                                          cwd=work,capture_output=True,timeout=30)
                for chunks in (1,3,7,127,128):
                    result=run(chunks,-1)
                    calls=math.ceil(len(data)/chunks)+1
                    output=expected+f'calls {calls}\n'.encode()
                    assert(result.returncode,result.stdout,result.stderr)==(0,output,b''),(word,prefix,chunks,result)
                    passed+=1
                for stop in (0,1,min(127,len(data)-1),len(data)):
                    baseline=run(1,stop);buffered=run(128,stop)
                    assert (baseline.returncode,baseline.stdout,baseline.stderr)==(
                        buffered.returncode,buffered.stdout,buffered.stderr),(word,prefix,stop,baseline,buffered)
                    assert baseline.returncode!=0 and b'cannot read source' in baseline.stderr
                    passed+=1
            (work/'first').write_bytes(b'\na'+b'x'*300)
            (work/'second').write_bytes(b'Z'+b'y'*300)
            result=subprocess.run([str(work/'reentry')],cwd=work,capture_output=True,timeout=30)
            assert(result.returncode,result.stdout,result.stderr)==(0,b'',b''),(word,result)
            passed+=1
            print(f'PASS: source reader/{word or "bootstrap"}',flush=True)
    print(f'{passed} source-reader checks passed')


if __name__=='__main__':
    main()
