#!/usr/bin/env python3
"""Check ordered parameter cells, mutation, recursion, and fragmented storage."""
import argparse
from pathlib import Path
import subprocess
import tempfile

CASES={
    'adjacent': ['check(a,b,c){auto p;p= &a;return(p[0]!=a | p[1]!=b | p[2]!=c);} main(){extrn check;return(check(11,22,33));}'],
    'mutation': ['check(a,b,c){auto p;p= &a;p[1]=42;if(b!=42)return(1);b++;return(p[1]!=43);} main(){extrn check;auto b;b=22;if(check(11,b,33))return(1);return(b!=22);}'],
    'recursion': ['check(a,b,c){extrn check;auto p;p= &a;if(a)if(check(a-1,b+1,c+1))return(1);return(p[0]!=a | p[1]!=b | p[2]!=c);} main(){extrn check;return(check(4,22,33));}'],
    'fragmentation': ['hold;seed(){extrn alloc,hold;auto a,b;a=1;b=2;hold=alloc(1);*hold=99;} check(a,b,c){auto p;p= &a;return(p[0]!=a | p[1]!=b | p[2]!=c);} main(){extrn seed,check,free,hold;auto r;seed();r=check(11,22,33);free(hold);return(r);}'],
    'cross-file': ['check(a,b,c){auto p;p= &a;return(p[0]!=a | p[1]!=b | p[2]!=c);}', 'main(){extrn check;return(check(11,22,33));}'],
    'callable-parameter': ['first(){return(1);} second(){return(2);} check(f,g){auto p;p= &f;p[0]=g;return(f()!=2);} main(){extrn first,second,check;return(check(first,second));}'],
}


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler',type=Path,required=True)
    parser.add_argument('--bootstrap',action='store_true')
    args=parser.parse_args()
    modes=[('host',False)] if args.bootstrap else [(bits,inline) for bits in ('host','16','32') for inline in (False,True)]
    passed=failed=0
    with tempfile.TemporaryDirectory(prefix='bcc-parameter-layout-') as directory:
        work=Path(directory)
        for bits,inline in modes:
            for strict in (False,True):
                cases=dict(CASES)
                if not strict:
                    cases['shadow-parameter']=['check(a,b){{auto a;a=99;if(a!=99)return(1);}return(a!=11 | b!=22);} main(){extrn check;return(check(11,22));}']
                    cases['shadow-global']=['data 42;check(a){{auto data;data=1;}return(data!=42 | a!=11);}main(){extrn check;return(check(11));}']
                for name,sources in cases.items():
                    paths=[]
                    for i,source in enumerate(sources):
                        path=work/f'part{i}.b';path.write_text(source+'\n');paths.append(str(path))
                    command=[str(args.compiler.resolve())]
                    if strict:command+=['--strict','--pedantic']
                    if not args.bootstrap:command.append(f'--word={bits}')
                    if inline:command.append('--inline-runtime')
                    try:
                        build=subprocess.run([*command,*paths,'-o',str(work/'case')],capture_output=True,timeout=30)
                        run=subprocess.run([str(work/'case')],capture_output=True,timeout=10) if build.returncode==0 else build
                        ok=run.returncode==0 and not run.stdout
                        detail=repr((run.returncode,run.stdout,run.stderr[-1800:]))
                    except (OSError,subprocess.TimeoutExpired) as error:
                        ok,detail=False,str(error)
                    print(f'{"PASS" if ok else "FAIL"}: parameters/{bits}/{inline}/{strict}/{name}',flush=True)
                    if not ok:print(detail)
                    passed+=ok;failed+=not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__=='__main__':raise SystemExit(main())
