#!/usr/bin/env python3
"""Byte writes preserve neighboring bytes in every supported storage mode."""
import argparse
from pathlib import Path
import subprocess
import tempfile

SOURCE = '''main(){
    extrn read,write,char,lchar;
    auto ctl 1,buf 16,i,at,c;
    if(read(0,ctl,1)!=1 | read(0,buf,16)!=16)return(1);
    at=char(ctl,0);
    if(at==255){i=0;while(i<16){c=(i*37+3)&255;if(lchar(buf,i,c)!=c)return(2);i++;}}
    else if(at>=252 & at<=254){
        c= -1;if(at==253)c=256;if(at==252)c=4660;
        if(lchar(buf,1,c)!=c)return(3);
    }
    else if(lchar(buf,at,255)!=255)return(4);
    return(write(1,buf,16)!=16);
}'''


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    modes = [('host',False,False)] if args.bootstrap else [
        (word,inline,byteptr) for word in ('host','16','32')
        for inline in (False,True) for byteptr in (False,True)]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-char-storage-') as directory:
        root = Path(directory);source=root/'case.b';exe=root/'case'
        source.write_text(SOURCE)
        for word,inline,byteptr in modes:
            flags=['--strict','--pedantic']
            if not args.bootstrap:
                flags += ['--word='+word, '--byteptr' if byteptr else '--wordptr']
            if inline: flags.append('--inline-runtime')
            build=subprocess.run([str(args.compiler.resolve()),*flags,str(source),'-o',str(exe)],
                                 capture_output=True,timeout=30)
            for index in (255,254,253,252,0,3,4,7,8,15):
                data=bytes(range(16))
                if index==255:
                    expected=bytes((i*37+3)&255 for i in range(16))
                elif index in (254,253,252):
                    value={254:255,253:0,252:52}[index]
                    expected=data[:1]+bytes([value])+data[2:]
                else:
                    expected=data[:index]+b'\xff'+data[index+1:]
                run=subprocess.run([str(exe)],input=bytes([index])+data,capture_output=True,timeout=5) if build.returncode==0 else build
                ok=build.returncode==0 and run.returncode==0 and run.stdout==expected and not run.stderr
                print(f'{"PASS" if ok else "FAIL"}: char-storage/{word}/{inline}/{byteptr}/{index}',flush=True)
                if not ok: print(run.returncode,repr(run.stdout),repr(run.stderr))
                passed+=ok;failed+=not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__=='__main__':
    raise SystemExit(main())
