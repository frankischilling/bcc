#!/usr/bin/env python3
"""Check terminal buffer safety using a private pseudoterminal, never the user's tty."""
import argparse
import os
from pathlib import Path
import pty
import resource
import subprocess
import tempfile
import termios

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=ROOT/'bcc')
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    modes = [('host', False)] if args.bootstrap else [(w, i) for w in ('host','16','32') for i in (False,True)]
    passed = failed = 0
    master, slave = pty.openpty()
    try:
        before = termios.tcgetattr(slave)
        cases = {
            'gtty-null': f'return(gtty({slave},0)!=-1);',
            'stty-null': f'return(stty({slave},0)!=-1);',
            'gtty-missing': f'return(gtty({slave})!=-1);',
            'stty-missing': f'return(stty({slave})!=-1);',
            'round-trip': f'auto t 4;t[3]=77;if(gtty({slave},t)!=0 | t[3]!=77)return(1);return(stty({slave},t)!=0);',
            'bad-fd': 'auto t 4;t[0]=11;t[1]=22;t[2]=33;t[3]=44;if(gtty(-1,t)!=-1 | stty(-1,t)!=-1)return(1);return(t[0]!=11 | t[1]!=22 | t[2]!=33 | t[3]!=44);',
        }
        with tempfile.TemporaryDirectory(prefix='bcc-private-tty-') as directory:
            work = Path(directory)
            for word, inline in modes:
                for name, body in cases.items():
                    source = work/'case.b'
                    source.write_text('main(){extrn gtty,stty;'+body+'}\n')
                    command = [str(args.compiler.resolve()), '--strict', '--pedantic']
                    if not args.bootstrap: command += [f'--word={word}']
                    if inline: command += ['--inline-runtime']
                    build = subprocess.run(command+[str(source), '-o', str(work/'case')], capture_output=True, timeout=30)
                    result = build
                    if build.returncode == 0:
                        result = subprocess.run([str(work/'case')], pass_fds=(slave,), capture_output=True, timeout=10, cwd=work,
                                                preexec_fn=lambda: resource.setrlimit(resource.RLIMIT_CORE, (0, 0)))
                    output = build.stdout + build.stderr + result.stdout + result.stderr
                    after = termios.tcgetattr(slave)
                    if name.endswith('-missing'):
                        ok = result.returncode > 0 and b'needs at least 2 arguments' in output and after == before
                    else:
                        ok = result.returncode == 0 and not result.stdout and after == before
                    ok = ok and all(marker not in output for marker in (b'Sanitizer', b'runtime error:'))
                    print(f'{"PASS" if ok else "FAIL"}: tty/{word}/{inline}/{name}', flush=True)
                    if not ok: print(result.returncode, repr(output[-1500:]), 'unchanged:', after == before)
                    passed += ok; failed += not ok
                    if after != before: termios.tcsetattr(slave, termios.TCSANOW, before)
    finally:
        os.close(slave)
        os.close(master)
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
