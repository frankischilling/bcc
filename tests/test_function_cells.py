#!/usr/bin/env python3
"""Check writable source-function cells, saved code values, and cross-file use."""
import argparse
from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]
CASES = {
    'native-fixture': ([(ROOT/'pdp-11/bcc-pdp/tests/run/t63_function_cells.b').read_text()], 0, b'OK\n'),
    'persistent': (['f(){return(7);} g(){return(9);} set(){extrn f,g;f=g;} main(){extrn f,set;set();return(f()!=9);}'],0,b''),
    'cross-file': (['f(){return(7);}', 'g(){return(9);}', 'refs[1] f;', 'main(){extrn f,g,refs;auto old;old=f;*refs[0]=g;if(f()!=9 | old()!=7)return(1);f=old;return(f()!=7);}'],0,b''),
    'cross-main': (['peek(){extrn main;return(main);}', 'main(){extrn peek,main;return(peek()!=main);}'],0,b''),
    'library-name': (['printf(n){return(n+1);} other(n){return(n+8);} main(){extrn printf,other;auto old;old=printf;printf=other;return(printf(1)!=9 | old(1)!=2);}'],0,b''),
    'recursive-value': (['f(n){extrn f;if(n)return(f(n-1)+1);return(0);} g(n){return(10);} main(){extrn f,g;auto old;old=f;f=g;return(old(1)!=11);}'],0,b''),
    'main-cell': (['g(){return(9);} main(){extrn main,g;auto old,p;old=main;p= &main;main=g;if(*p!=g)return(1);*p=old;return(main!=old);}'],0,b''),
    'ordinary-b-main': (['b_main(){return(42);}', 'main(){extrn b_main;return(b_main()!=42);}'],0,b''),
}
HOST_COMPAT = {
    'main-initializer': (['chosen = setup(); setup(){extrn main,g;main=g;return(0);} g(){return(42);} main(){return(1);}'],42,b''),
    'initialize-once': (['f(){return(7);}g(){return(9);}main(){extrn f,g;f=g;__b_init();return(f()!=9);}'],0,b''),
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler',type=Path,required=True)
    parser.add_argument('--bootstrap',action='store_true')
    args = parser.parse_args()
    modes = [('host',False)] if args.bootstrap else [(mode,inline) for mode in ('host','16','32') for inline in (False,True)]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-function-cells-') as directory:
        work = Path(directory)
        for mode,inline in modes:
            for strict in (False,True):
                cases = dict(CASES)
                if not strict and not args.bootstrap: cases.update(HOST_COMPAT)
                for name,(sources,status,output) in cases.items():
                    paths=[]
                    for i,source in enumerate(sources):
                        path=work/f'part{i}.b';path.write_text(source+'\n');paths.append(str(path))
                    command=[str(args.compiler.resolve())]
                    if strict: command += ['--strict','--pedantic']
                    if not args.bootstrap: command.append(f'--word={mode}')
                    if inline: command.append('--inline-runtime')
                    try:
                        build=subprocess.run([*command,*paths,'-o',str(work/'case')],capture_output=True,timeout=30)
                        run=subprocess.run([str(work/'case')],input=b'',capture_output=True,timeout=10) if build.returncode==0 else build
                        ok=build.returncode==0 and run.returncode==status and run.stdout==output
                        detail=repr((run.returncode,run.stdout,run.stderr[-1800:]))
                    except (OSError,subprocess.TimeoutExpired) as error:
                        ok,detail=False,str(error)
                    print(f'{"PASS" if ok else "FAIL"}: function-cells/{mode}/{inline}/{strict}/{name}',flush=True)
                    if not ok: print(detail)
                    passed+=ok;failed+=not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__=='__main__':
    raise SystemExit(main())
