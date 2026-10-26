#!/usr/bin/env python3
"""Exercise host command-line replay without pipe-capacity dependencies."""
import argparse
from pathlib import Path
import subprocess
import resource
import tempfile

PROGRAM = '''main(){extrn reread,getchar,putchar;auto c;
reread();while((c=getchar())!=4)putchar(c);return(0);}
'''
REPEAT = '''main(){extrn reread,getchar,putchar;auto c,n;n=0;
while(n<2){reread();while((c=getchar())!=10){if(c==4)return(1);putchar(c);}putchar(c);n++;}
while((c=getchar())!=4)putchar(c);return(0);}
'''


def limit_descriptors():
    resource.setrlimit(resource.RLIMIT_NOFILE, (32, 32))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    modes = [('host', False)] if args.bootstrap else [
        (bits, inline) for bits in ('host', '16', '32') for inline in (False, True)
    ]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-reread-') as directory:
        work = Path(directory)
        for bits, inline in modes:
            for name, program, arguments, copies in (
                ('basic', PROGRAM, ['one', 'two'], 1),
                ('empty-argument', PROGRAM, ['', 'two'], 1),
                ('large-argument', PROGRAM, ['x' * (20000 if bits == '16' else 100000)], 1),
                ('no-arguments', PROGRAM, [], 0),
                ('repeat', REPEAT, ['one'], 2),
                ('replace-unread', PROGRAM.replace('reread();', 'auto n;n=0;while(n<100){reread();n++;}'), ['one'], 1),
            ):
                path = work / 'case.b'
                path.write_text(program)
                command = [str(args.compiler.resolve()), '--strict', '--pedantic']
                if not args.bootstrap:
                    command += [f'--word={bits}']
                if inline:
                    command += ['--inline-runtime']
                try:
                    build = subprocess.run(command + [str(path), '-o', str(work / 'case')],
                                           capture_output=True, timeout=30)
                    run = (subprocess.run(['replay', *arguments], executable=str(work / 'case'),
                                          input=b'INPUT', capture_output=True, timeout=5,
                                          preexec_fn=limit_descriptors)
                           if build.returncode == 0 else build)
                    expected = (' '.join(['replay', *arguments]) + '\n').encode() * copies + b'INPUT'
                    ok = run.returncode == 0 and run.stdout == expected and not run.stderr
                    detail = repr((run.returncode, run.stdout[:100], run.stderr[-1000:]))
                except (OSError, subprocess.TimeoutExpired) as error:
                    ok, detail = False, f'{type(error).__name__}: {str(error)[:180]}'
                print(f'{"PASS" if ok else "FAIL"}: reread/{bits}/{inline}/{name}', flush=True)
                if not ok:
                    print(detail)
                passed += ok
                failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
