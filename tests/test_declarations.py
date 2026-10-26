#!/usr/bin/env python3
"""Check declaration statements and invocation-wide B72 automatic storage."""
import argparse
from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]
FIXTURES = ('t70_declaration_bodies', 't71_late_auto_vectors', 't72_auto_function_scope', 't82_many_vectors')
REJECTS = {
    'empty-auto': 'main(){auto ; return(0);}',
    'trailing-auto-comma': 'main(){auto x,; return(0);}',
    'empty-extrn': 'main(){extrn ; return(0);}',
    'trailing-extrn-comma': 'main(){extrn x,; return(0);}',
    'missing-declaration-body': 'main(){auto x;}',
    'duplicate-local': 'main(){auto x; {auto x; x=1;} return(0);}',
    'duplicate-parameter': 'f(x,x){return(x);} main(){return(0);}',
    'missing-parameter-comma': 'f(x y){return(x);} main(){return(0);}',
    'trailing-parameter-comma': 'f(x,){return(x);} main(){return(0);}',
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    compiler = args.compiler.resolve()
    modes = [('host', False)] if args.bootstrap else [(word, inline) for word in ('host', '16') for inline in (False, True)]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-declarations-') as directory:
        work = Path(directory)
        for word, inline in modes:
            cases = [(name, (ROOT/'pdp-11/bcc-pdp/tests/run'/f'{name}.b').read_text(), b'OK\n') for name in FIXTURES]
            cases += [(name, source, None) for name, source in REJECTS.items()]
            for name, source, expected in cases:
                path = work/'case.b'; path.write_text(source+'\n')
                command = [str(compiler), '--strict', '--pedantic']
                if not args.bootstrap: command += [f'--word={word}']
                if inline: command += ['--inline-runtime']
                try:
                    result = subprocess.run([*command, str(path), '-o', str(work/'case')], capture_output=True, timeout=30)
                    if expected is None:
                        ok = result.returncode > 0
                    elif result.returncode:
                        ok = False
                    else:
                        result = subprocess.run([str(work/'case')], capture_output=True, timeout=10)
                        ok = result.returncode == 0 and result.stdout == expected
                    detail = repr((result.returncode, result.stdout, result.stderr[-1500:]))
                except (OSError, subprocess.TimeoutExpired) as error:
                    ok, detail = False, str(error)
                print(f'{"PASS" if ok else "FAIL"}: declarations/{word}/{"inline" if inline else "shared"}/{name}', flush=True)
                if not ok: print(detail)
                passed += ok; failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
