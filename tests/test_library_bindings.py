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
# Built-in cells must be writable even without a source definition.
CASES.update({
    'builtin-cell': (["replace(c){return(c+1);}main(){extrn putchar,replace;auto old,p;old=putchar;p= &putchar;*p=replace;if(putchar(41)!=42)return(1);putchar=old;putchar('OK');putchar('*n');return(0);}"], b'OK\n'),
    'builtin-initializer': (["saved putchar;replace(c){return(c+1);}main(){extrn saved,putchar,replace;auto old;old= *saved;if(saved!=&putchar)return(1);*saved=replace;if(putchar(41)!=42)return(2);*saved=old;putchar('OK');return(0);}"], b'OK'),
    'builtin-extra-arguments': (["n;tick(){extrn n;return(++n);}main(){extrn putchar,tick,n;putchar('A',tick(),tick(),tick());return(n!=3);}"], b'A'),
    'builtin-printf-value': (['replace(s){return(42);}main(){extrn printf,replace;auto f;f=printf;printf=replace;if(printf("ignored")!=42)return(1);f("%d %o %s*n",12,8,"OK");printf=f;return(0);}'], b'12 10 OK\n'),
    'builtin-callf-value': (['main(){extrn callf;auto f;f=callf;if(f("strlen","A*0")!=1)return(1);return(f("__bcc_missing_test_symbol__",1,2)!=-1);}'], b''),
    'builtin-execl-unterminated': (['main(){extrn execl;return(execl("/no/such/bcc-test-program","arg")!=-1);}'], b''),
    'builtin-exit-empty': (['main(){extrn exit;auto f;f=exit;f();return(99);}'], b''),
    'builtin-cross-file-io': (['setup(){extrn openw;return(openw(9,"/dev/null"));}', "main(){extrn setup,putchar,close;if(setup()!=9)return(1);putchar('X');close(9);putchar('OK');return(0);}"], b'OK'),
    'builtin-execl-value': (['main(){extrn execl;auto f;f=execl;return(f("/no/such/bcc-test-program","arg",0)!=-1);}'], b''),
    'builtin-cross-file': (["where(){extrn putchar;return(&putchar);}replace(c){return(c+1);}", "main(){extrn putchar,where,replace;auto p,old;p=where();if(p!=&putchar)return(1);old= *p;*p=replace;if(putchar(41)!=42)return(2);*p=old;putchar('OK');return(0);}"], b'OK'),
    'builtin-printn-recursion': (["seen;capture(c){extrn printn,other,seen;if(c=='-')printn=other;seen++;return(c);}other(n,b){extrn seen;if(n!=12 | b!=10)return(99);seen=+10;return(0);}main(){extrn putchar,printn,capture,seen;putchar=capture;printn(-123,10);return(seen!=12);}"], b''),
})


# argv without a call denotes the predefined vector, not its compatibility helper.
BUILTINS = ("char lchar getchar getchr putchr getstr putstr flush reread printf "
            "printn putnum print putchar exit abort free alloc open close read write "
            "creat seek openr openw fork wait execl execv chdir chmod chown link unlink "
            "stat fstat time ctime getuid setuid makdir mkdir intr gtty stty system "
            "usleep callf argc").split()
CASES['all-builtin-addresses'] = ([
    'main(){extrn ' + ','.join(BUILTINS) + ';auto p,f;' + ''.join(
        f'p= &{name};f={name};if(!f | *p!=f)return({i + 1});*p=f;'
        for i, name in enumerate(BUILTINS)) + 'return(0);}'
], b'')

OBJECTS = {
    'builtin-cell': ('saved;replace(c){return(c+1);}flush(){extrn saved,putchar,replace;saved=putchar;putchar=replace;}',
                     "main(){extrn flush,putchar,saved;flush();if(putchar(41)!=42)return(1);putchar=saved;putchar('OK');return(0);}"),
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
                for name, source, diagnostic in (
                    ('missing-fixed', 'main(){extrn char;char();return(99);}', b'bcc: char needs at least 2 arguments\n'),
                    ('missing-format', 'main(){extrn printf;printf("%d");return(0);}', b'bcc: printf argument list is too short\n'),
                ):
                    path = work / 'bad.b'
                    path.write_text(source + '\n')
                    try:
                        result = subprocess.run(command + [str(path), '-o', str(work / 'bad')], capture_output=True, timeout=30)
                        if result.returncode == 0:
                            result = subprocess.run([str(work / 'bad')], capture_output=True, timeout=10)
                        status = 1 if name == 'missing-fixed' else 0
                        ok = result.returncode == status and not result.stdout and result.stderr == diagnostic
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
                        ok = result.returncode == 0 and result.stdout == (b'OK' if name == 'builtin-cell' else b'') and not result.stderr
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
