#!/usr/bin/env python3
"""Check source library replacements in calls, function values, and callbacks."""
import argparse
from pathlib import Path
import subprocess
import tempfile

CHAR = "char(s,i){if(i==0)return('O');if(i==1)return('K');return(4);}"
GETCHAR = "input;getchar(){extrn input;if(input++==0)return('A');return(10);}"
CASES = {
    'printf-putchar': (['count;putchar(c){extrn count;count++;return(c);}main(){extrn printf,count;printf("abc%d",42);return(count!=5);}'], b''),
    'printn-putchar': (['count;putchar(c){extrn count;count++;return(c);}main(){extrn printn,count;printn(-12,10);return(count!=3);}'], b''),
    'printf-printn': (['value;base;printn(n,b){extrn value,base;value=n;base=b;return(0);}main(){extrn printf,value,base;printf("%d",-12);return(value!=12 | base!=10);}'], b'-'),
    'printf-char': ([CHAR + 'main(){extrn printf;printf("ignored");return(0);}'], b'OK'),
    'putstr-char': ([CHAR + 'main(){extrn putstr;putstr("ignored");return(0);}'], b'OK'),
    'mutable-putchar': (['one;two;second(c){extrn two;two++;return(c);}putchar(c){extrn one,putchar,second;one++;putchar=second;return(c);}main(){extrn printf,one,two;printf("abc");return(one!=1 | two!=2);}'], b''),
    'data-putchar': (['putchar;count;handler(c){extrn count;count++;return(c);}main(){extrn putchar,handler,printf,count;putchar=handler;printf("abc");return(count!=3);}'], b''),
    'getstr-getchar': ([GETCHAR + 'main(){extrn getstr,char,input;auto buf 4,r;r=getstr(buf);return(r!=EXPECTED | input!=2 | char(buf,0)!=65 | char(buf,1)!=4);}'], b''),
    'getstr-lchar': ([GETCHAR + 'writes;lchar(s,i,c){extrn writes;writes++;return(c);}main(){extrn getstr,writes;auto buf 4;getstr(buf);return(writes!=2);}'], b''),
    'getstr-carriage': (['input;getchar(){extrn input;if(input++==0)return(13);return(10);}main(){extrn getstr,char,input;auto buf 4,r;r=getstr(buf);return(r!=EXPECTED | input!=READCOUNT | char(buf,0)!=FIRSTBYTE);}'], b''),
    'getstr-eot': (['getchar(){return(4);}main(){extrn getstr,char;auto buf 4,r;r=getstr(buf);return(r!=EXPECTED_ZERO | char(buf,0)!=4);}'], b''),
    'getstr-nul': (['input;getchar(){extrn input;if(input++==0)return(0);return(10);}main(){extrn getstr,char;auto buf 4,r;r=getstr(buf);return(r!=EXPECTED | char(buf,0)!=0 | char(buf,1)!=4);}'], b''),
    'cross-file-putchar': (['count;putchar(c){extrn count;count++;return(c);}', 'main(){extrn printf,count;printf("abc");return(count!=3);}'], b''),
}
OBJECTS = {
    'putchar': ('count;putchar(c){extrn count;count++;return(c);}',
                "main(){extrn putchar,count;auto f;putchar('a');f=putchar;f('b');return(count!=2);}"),
    'printf': ('count;printf(fmt,x){extrn count;count++;return(x);}',
               'main(){extrn printf,count;auto f;if(printf("x",42)!=42)return(1);f=printf;if(f("x",7)!=7)return(2);return(count!=2);}'),
    'data': ('putchar;count;handler(c){extrn count;count++;return(c);}flush(){extrn putchar,handler;putchar=handler;}',
             'main(){extrn flush,printf,count;flush();printf("abc");return(count!=3);}'),
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
    with tempfile.TemporaryDirectory(prefix='bcc-library-bindings-') as directory:
        work = Path(directory)
        for bits, inline in modes:
            for strict in (False, True):
                command = [str(args.compiler.resolve())]
                if strict:
                    command += ['--strict', '--pedantic']
                if not args.bootstrap:
                    command += [f'--word={bits}']
                if inline:
                    command.append('--inline-runtime')
                for name, (sources, expected) in CASES.items():
                    paths = []
                    for index, source in enumerate(sources):
                        path = work / f'part{index}.b'
                        source = source.replace('EXPECTED_ZERO', '0' if strict else 'buf').replace('EXPECTED', '1' if strict else 'buf')
                        source = source.replace('READCOUNT', '2' if strict else '1').replace('FIRSTBYTE', '13' if strict else '4')
                        path.write_text(source + '\n')
                        paths.append(str(path))
                    try:
                        result = subprocess.run(command + paths + ['-o', str(work / 'case')],
                                                capture_output=True, timeout=30)
                        if result.returncode == 0:
                            result = subprocess.run([str(work / 'case')], capture_output=True, timeout=10)
                        ok = result.returncode == 0 and result.stdout == expected and not result.stderr
                        detail = repr((result.returncode, result.stdout, result.stderr[-1800:]))
                    except (OSError, subprocess.TimeoutExpired) as error:
                        ok, detail = False, str(error)
                    print(f'{"PASS" if ok else "FAIL"}: bindings/{bits}/{inline}/{strict}/{name}', flush=True)
                    if not ok:
                        print(detail)
                    passed += ok
                    failed += not ok
                if args.bootstrap:
                    continue
                for name, (provider, caller) in OBJECTS.items():
                    (work / 'provider.b').write_text(provider + '\n')
                    (work / 'caller.b').write_text(caller + '\n')
                    try:
                        result = subprocess.run(command + ['-c', str(work / 'provider.b'), '-o', str(work / 'provider.o')],
                                                capture_output=True, timeout=30)
                        if result.returncode == 0:
                            result = subprocess.run(command + [str(work / 'caller.b'), '-X', str(work / 'provider.o'), '-o', str(work / 'linked')],
                                                    capture_output=True, timeout=30)
                        if result.returncode == 0:
                            result = subprocess.run([str(work / 'linked')], capture_output=True, timeout=10)
                        ok = result.returncode == 0 and not result.stdout and not result.stderr
                        detail = repr((result.returncode, result.stdout, result.stderr[-1800:]))
                    except (OSError, subprocess.TimeoutExpired) as error:
                        ok, detail = False, str(error)
                    print(f'{"PASS" if ok else "FAIL"}: bindings/{bits}/{inline}/{strict}/object-{name}', flush=True)
                    if not ok:
                        print(detail)
                    passed += ok
                    failed += not ok
        if not args.bootstrap:
            fixture = Path(__file__).resolve().parent / 'fixtures/old_call_registry.c'
            source = work / 'old-caller.b'
            source.write_text('main(){extrn oldfn,printf;if(oldfn(41)!=42)return(1);printf("OK*n");return(0); }\n')
            for inline in (False, True):
                try:
                    result = subprocess.run(['gcc', '-std=c99', '-O2', '-c', str(fixture), '-o', str(work / 'old.o')],
                                            capture_output=True, timeout=30)
                    if result.returncode == 0:
                        command = [str(args.compiler.resolve()), '--strict', '--pedantic', '--word=host']
                        if inline:
                            command.append('--inline-runtime')
                        result = subprocess.run(command + [str(source), '-X', str(work / 'old.o'), '-o', str(work / 'old-linked')],
                                                capture_output=True, timeout=30)
                    if result.returncode == 0:
                        result = subprocess.run([str(work / 'old-linked')], capture_output=True, timeout=10)
                    ok = result.returncode == 0 and result.stdout == b'OK\n' and not result.stderr
                    detail = repr((result.returncode, result.stdout, result.stderr[-1800:]))
                except (OSError, subprocess.TimeoutExpired) as error:
                    ok, detail = False, str(error)
                print(f'{"PASS" if ok else "FAIL"}: bindings/old-call-record/{inline}', flush=True)
                if not ok:
                    print(detail)
                passed += ok
                failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
