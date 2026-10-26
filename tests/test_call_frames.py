#!/usr/bin/env python3
"""Check complete B argument blocks independently of C parameter placement."""
import argparse
from pathlib import Path
import subprocess
import tempfile

SUM = 'sum(n,x){auto p,s,i;p= &x;s=0;i=0;while(i<n){s=+p[i];i++;}return(s);}'
CASES = {
    'extra-arguments': ([SUM + 'main(){extrn sum;return(sum(4,10,20,30,40)!=100);}'], b''),
    'indirect': ([SUM + 'main(){extrn sum;auto f;f=sum;return(f(4,10,20,30,40)!=100);}'], b''),
    'cross-file': ([SUM, 'main(){extrn sum;return(sum(4,10,20,30,40)!=100);}'], b''),
    'nested': ([SUM + 'main(){extrn sum;return(sum(3,sum(2,1,2),sum(2,3,4),5)!=15);}'], b''),
    'recursive': (['sum(n,x){extrn sum;auto p;p= &x;if(n)if(sum(0,7,8,9)!=24)return(-1);return(p[0]+p[1]+p[2]);}main(){extrn sum;return(sum(1,10,20,30)!=60);}'], b''),
    'write-extra': (['change(n,x){auto p;p= &x;p[2]=99;return(p[0]+p[1]+p[2]);}main(){extrn change;auto a;a=30;if(change(3,10,20,a)!=129)return(1);return(a!=30);}'], b''),
    'no-formals': (['f(){return(7);}main(){extrn f;return(f(1,2,3,4,5,6,7,8)!=7);}'], b''),
    'main-extra-parameters': (['main(a,b,c,d){return(a!=1 | b==0 | c!=0 | d!=0);}'], b''),
    'missing-all': (['f(a,b,c){return(a|b|c);}main(){extrn f;return(f());}'], b''),
    'missing-some': (['f(a,b,c){return(a!=7 | b!=0 | c!=0);}main(){extrn f;return(f(7));}'], b''),
    'captured-callee': (['first(x){return(1);}second(x){return(2);}replace(){extrn first,second;first=second;return(0);}main(){extrn first,replace;return(first(replace())!=1);}'], b''),
    'indexed-callee': (['first(x){return(1);}second(x){return(2);}main(){extrn first,second;auto v 2,i;v[0]=first;v[1]=second;i=0;return(v[i](i=1)!=1);}'], b''),
    'builtin-value': (['main(){extrn printn;auto f;f=printn;f(42,10);return(0);}'], b'42'),
    'builtin-variadic-value': (['main(){extrn printf;auto f;f=printf;f("%d %s*n",42,"OK");return(0);}'], b'42 OK\n'),
    'source-library-name': (['printf(n,x){auto p;p= &x;return(p[0]+p[1]+p[2]);}main(){extrn printf;return(printf(3,10,20,30)!=60);}'], b''),
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    modes = [('host', False)] if args.bootstrap else [
        (bits, inline) for bits in ('host', '16', '32') for inline in (False, True)
    ]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-call-frames-') as directory:
        work = Path(directory)
        for bits, inline in modes:
            for strict in (False, True):
                for name, (sources, expected) in CASES.items():
                    paths = []
                    for index, source in enumerate(sources):
                        path = work / f'part{index}.b'
                        path.write_text(source + '\n')
                        paths.append(str(path))
                    command = [str(args.compiler.resolve())]
                    if strict:
                        command += ['--strict', '--pedantic']
                    if not args.bootstrap:
                        command += [f'--word={bits}']
                    if inline:
                        command += ['--inline-runtime']
                    try:
                        build = subprocess.run(command + paths + ['-o', str(work / 'case')],
                                               capture_output=True, timeout=30)
                        run = (subprocess.run([str(work / 'case')], capture_output=True, timeout=10)
                               if build.returncode == 0 else build)
                        ok = run.returncode == 0 and run.stdout == expected and not run.stderr
                        detail = repr((run.returncode, run.stdout, run.stderr[-1800:]))
                    except (OSError, subprocess.TimeoutExpired) as error:
                        ok, detail = False, str(error)
                    print(f'{"PASS" if ok else "FAIL"}: calls/{bits}/{inline}/{strict}/{name}', flush=True)
                    if not ok:
                        print(detail)
                    passed += ok
                    failed += not ok
        if not args.bootstrap:
            for bits, inline in modes:
                flags = ['--strict', '--pedantic', f'--word={bits}']
                if inline:
                    flags.append('--inline-runtime')
                library = work / 'library.b'
                library.write_text(SUM + '\n')
                caller = work / 'caller.b'
                caller.write_text('main(){extrn sum;return(sum(4,10,20,30,40)!=100); }\n')
                command = [str(args.compiler.resolve()), *flags]
                try:
                    result = subprocess.run(command + ['-c', str(library), '-o', str(work / 'library.o')],
                                            capture_output=True, timeout=30)
                    if result.returncode == 0:
                        result = subprocess.run(command + [str(caller), '-X', str(work / 'library.o'),
                                                           '-o', str(work / 'linked')],
                                                capture_output=True, timeout=30)
                    if result.returncode == 0:
                        result = subprocess.run([str(work / 'linked')], capture_output=True, timeout=10)
                    ok = result.returncode == 0 and not result.stdout and not result.stderr
                    detail = repr((result.returncode, result.stdout, result.stderr[-1800:]))
                except (OSError, subprocess.TimeoutExpired) as error:
                    ok, detail = False, str(error)
                print(f'{"PASS" if ok else "FAIL"}: calls/{bits}/{inline}/separate-object', flush=True)
                if not ok:
                    print(detail)
                passed += ok
                failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
