#!/usr/bin/env python3
"""Check nested switches, far cases, fall-through, and stack-neutral branches."""
import argparse
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
FIXTURES = ('t103_switch_nested', 't104_switch_far', 't105_switch_escape',
            't106_switch_capacity', 't109_switch_flow')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=ROOT/'bcc')
    group = parser.add_mutually_exclusive_group()
    group.add_argument('--bootstrap', action='store_true')
    group.add_argument('--native', action='store_true')
    args = parser.parse_args()
    modes = [('host', False)] if args.bootstrap or args.native else [(w, i) for w in ('host','16','32') for i in (False,True)]
    cases = [(name, (ROOT/'pdp-11/bcc-pdp/tests/run'/f'{name}.b').read_text(), b'OK\n', None) for name in FIXTURES]
    cases += [
        ('adjacent-labels', "main(){extrn putchar;auto x;x=0;switch 1 {case 1:case 2:x=7;}if(x!=7)return(1);putchar('OK');putchar('*n');return(0);}", b'OK\n', None),
        ('empty-between-labels', "main(){extrn putchar;auto x;x=0;switch 1 {case 1:;case 2:x=7;}if(x!=7)return(1);putchar('OK');putchar('*n');return(0);}", b'OK\n', None),
    ]
    cases += [('outside', 'main(){case 1:return(0);}', None, b'case')]
    if args.native:
        cases += [('capacity', 'main(){switch 0 {'+''.join(f'case {i}:' for i in range(33))+'return(0);}}', None, b'>c')]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-switch-') as directory:
        work = Path(directory)
        for word, inline in modes:
            for name, source, expected, diagnostic in cases:
                path = work/'case.b'; path.write_text(source+'\n')
                if args.native:
                    command = [sys.executable, str(ROOT/'pdp-11/bcc-pdp/tools/run_apout.py'), '--timeout', '10', str(path)]
                else:
                    command = [str(args.compiler.resolve()), '--strict', '--pedantic']
                    if not args.bootstrap: command += [f'--word={word}']
                    if inline: command += ['--inline-runtime']
                    command += [str(path), '-o', str(work/'case')]
                result = subprocess.run(command, capture_output=True, timeout=60)
                compile_output = result.stdout + result.stderr
                if expected is not None and result.returncode == 0 and not args.native:
                    result = subprocess.run([str(work/'case')], capture_output=True, timeout=10)
                output = result.stdout + result.stderr
                if expected is not None:
                    ok = (result.returncode == 0 and result.stdout == expected
                          and b'case label falls through' not in compile_output)
                else:
                    ok = result.returncode > 0 and diagnostic in output
                ok = ok and all(marker not in compile_output + output for marker in (b'Sanitizer', b'runtime error:'))
                print(f'{"PASS" if ok else "FAIL"}: switch/{word}/{inline}/{name}', flush=True)
                if not ok: print(result.returncode, repr(output[-1800:]))
                passed += ok; failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
