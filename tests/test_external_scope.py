#!/usr/bin/env python3
"""Keep strict external declarations local to a function and before first use."""
import argparse
import os
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
CASES = {
    'external-then-auto': ('data 42;main(){extrn data;auto data;return(0);}', False),
    'auto-then-external': ('data 42;main(){auto data;extrn data;return(0);}', False),
    'parameter-then-external': ('data 42;f(data){extrn data;return(data);}main(){return(0);}', False),
    'external-then-label': ('data 42;main(){extrn data;data:return(0);}', False),
    'repeated-external': ('data 42;main(){extrn data;extrn data;return(data!=42);}', True),
    'undeclared-global': ('data 42;main(){return(data!=42);}', False),
    'declared-global': ('data 42;main(){extrn data;return(data!=42);}', True),
    'other-function': ('data 42;f(){extrn data;return(data);}main(){return(data!=42);}', False),
    'late-external': ('data 42;main(){auto x;x=data;extrn data;return(x!=42);}', False),
    'own-function': ('f(){return(f);}main(){extrn f;return(f()!=f);}', True),
    'label-shadows-global': ('target 42;main(){auto x;x=target;goto x;return(1);target:return(0);}', True),
    'auto-shadows-global': ('data 42;main(){auto data;data=7;return(data!=7);}', True),
    'bare-call': ('f(){return(42);}main(){return(f()!=42);}', True),
    'saved-function': ('f(){return(42);}main(){extrn f;auto p;p=f;return(p()!=42);}', True),
    'undeclared-function-value': ('f(){return(42);}main(){auto p;p=f;return(p()!=42);}', False),
    'declared-library-value': ('main(){extrn putchar;auto p;p=putchar;return(p==0);}', True),
    'undeclared-library-value': ('main(){auto p;p=putchar;return(p==0);}', False),
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=ROOT/'bcc')
    group = parser.add_mutually_exclusive_group()
    group.add_argument('--bootstrap', action='store_true')
    group.add_argument('--native', action='store_true')
    args = parser.parse_args()
    modes = [('host', False)] if args.bootstrap or args.native else [(w, i) for w in ('host','16','32') for i in (False,True)]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-external-scope-') as directory:
        work = Path(directory)
        for word, inline in modes:
            cases = [(True, name, source, accepted) for name, (source, accepted) in CASES.items()]
            cases += [(False, name, CASES[name][0], True) for name in
                      ('undeclared-global', 'other-function', 'late-external', 'undeclared-function-value')]
            for strict, name, source, accepted in cases:
                path = work/'case.b'; path.write_text(source+'\n')
                if args.native:
                    command = [sys.executable, str(ROOT/'pdp-11/bcc-pdp/tools/run_apout.py'), str(path)]
                else:
                    command = [str(args.compiler.resolve())]
                    if strict: command += ['--strict', '--pedantic']
                    if not args.bootstrap: command += [f'--word={word}', '--verbose-errors']
                    if inline: command += ['--inline-runtime']
                    command += [str(path), '-o', str(work/'case')]
                env = dict(os.environ)
                if args.native: env['B00FLAGS'] = '' if strict else '-x'
                result = subprocess.run(command, capture_output=True, timeout=30, env=env)
                compile_output = result.stdout + result.stderr
                if accepted and result.returncode == 0 and not args.native:
                    result = subprocess.run([str(work/'case')], capture_output=True, timeout=10)
                output = result.stdout + result.stderr
                if accepted:
                    ok = result.returncode == 0 and not result.stdout and (result.stderr == b'I\nII\n' if args.native else not result.stderr)
                else:
                    ok = result.returncode > 0 and any(d in output.lower() for d in
                        (b'undefined internal', b'undeclared', b'external declaration', b'conflicts with', b'duplicate local', b'redeclaration', b'label name collision'))
                ok = ok and all(marker not in compile_output + output for marker in
                                (b'Sanitizer', b'runtime error:'))
                print(f'{"PASS" if ok else "FAIL"}: external-scope/{word}/{inline}/{strict}/{name}', flush=True)
                if not ok: print(result.returncode, repr(output[-1800:]))
                passed += ok; failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
