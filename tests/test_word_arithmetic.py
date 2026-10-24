#!/usr/bin/env python3
"""Check word wrapping, zero-filled shifts, and single-evaluation updates."""
import argparse
from pathlib import Path
import struct
import subprocess
import tempfile


def cases(bits):
    maximum = str((1 << (bits - 1)) - 1)
    minimum = f'(-{maximum}-1)'
    return {
        'update-<': 'x=0; v[0]=7; v[1]=9; v[x++]=<8; return(x!=1 | v[0]!=1 | v[1]!=9);',
        'update-<=': 'x=0; v[0]=7; v[1]=9; v[x++]=<=8; return(x!=1 | v[0]!=1 | v[1]!=9);',
        'update->': 'x=0; v[0]=7; v[1]=9; v[x++]=>8; return(x!=1 | v[0]!=0 | v[1]!=9);',
        'update->=': 'x=0; v[0]=7; v[1]=9; v[x++]=>=8; return(x!=1 | v[0]!=0 | v[1]!=9);',
        'update-==': 'x=0; v[0]=7; v[1]=9; v[x++]===8; return(x!=1 | v[0]!=0 | v[1]!=9);',
        'update-!=': 'x=0; v[0]=7; v[1]=9; v[x++]=!=8; return(x!=1 | v[0]!=1 | v[1]!=9);',
        'octal-digits-eight-nine': 'return(09!=9 | 018!=16 | 099!=81);',
        'octal-word': f'x=0{(1 << bits) - 1:o}; return(x!= -1);',
        'full-left-shift': f'x=1; return((x<<{bits})!=0);',
        'full-right-shift': f'x= -1; return((x>>{bits})!=0);',
        'full-left-assign': f'x=1; x=<<{bits}; return(x!=0);',
        'full-right-assign': f'x= -1; x=>>{bits}; return(x!=0);',
        'right-shift': 'x= -1; return((x>>1)<0);',
        'right-shift-assign': 'x= -1; x=>>1; return(x<0);',
        'addition': f'x={maximum}; return(x+1!={minimum});',
        'subtraction': f'x={minimum}; return(x-1!={maximum});',
        'multiplication': f'x={minimum}; return(x* -1!=x);',
        'negation': f'x={minimum}; return(-x!=x);',
        'division': f'x={minimum}; return(x/ -1!=x);',
        'remainder': f'x={minimum}; return(x% -1!=0);',
        'left-shift': f'x=1; return((x<<{bits-1})!={minimum});',
        'preincrement': f'x={maximum}; return(++x!={minimum} | x!={minimum});',
        'postincrement': f'x={maximum}; y=x++; return(y!={maximum} | x!={minimum});',
        'predecrement': f'x={minimum}; return(--x!={maximum} | x!={maximum});',
        'postdecrement': f'x={minimum}; y=x--; return(y!={minimum} | x!={maximum});',
        'add-assign': f'x={maximum}; x=+1; return(x!={minimum});',
        'subtract-assign': f'x={minimum}; x=-1; return(x!={maximum});',
        'multiply-assign': f'x={minimum}; x=* -1; return(x!={minimum});',
        'divide-assign': f'x={minimum}; x=/ -1; return(x!={minimum});',
        'remainder-assign': f'x={minimum}; x=% -1; return(x!=0);',
        'left-shift-assign': f'x=1; x=<<{bits-1}; return(x!={minimum});',
        'signed-result': 'x= -2; return(!(x+1<0) | !(x-1<0) | !(x*2<0));',
        'indexed-update': f'x=0; v[0]={maximum}; v[1]=7; v[x++]=+1; return(x!=1 | v[0]!={minimum} | v[1]!=7);',
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
    with tempfile.TemporaryDirectory(prefix='bcc-word-arithmetic-') as directory:
        work = Path(directory)
        for mode, inline in modes:
            bits = struct.calcsize('P') * 8 if mode == 'host' else int(mode)
            for name, body in cases(bits).items():
                source = work / 'case.b'
                source.write_text('main(){auto x,y,v 2;' + body + '}\n')
                command = [str(args.compiler.resolve()), '--strict', '--pedantic']
                if not args.bootstrap:
                    command.append(f'--word={mode}')
                if inline:
                    command.append('--inline-runtime')
                try:
                    build = subprocess.run(command + [str(source), '-o', str(work / 'case')],
                                           capture_output=True, timeout=30)
                    run = (subprocess.run([str(work / 'case')], capture_output=True, timeout=10)
                           if build.returncode == 0 else build)
                    ok = run.returncode == 0 and not run.stdout and not run.stderr
                    detail = repr((run.returncode, run.stdout, run.stderr[-1800:]))
                except (OSError, subprocess.TimeoutExpired) as error:
                    ok, detail = False, str(error)
                print(f'{"PASS" if ok else "FAIL"}: arithmetic/{mode}/{inline}/{name}', flush=True)
                if not ok:
                    print(detail)
                passed += ok
                failed += not ok
        if not args.bootstrap:
            minimum = f'(-{(1 << (struct.calcsize("l") * 8 - 1)) - 1}-1)'
            for name, expression, expected in (
                ('fold-divide-min', minimum + '/-1', False),
                ('fold-negate-min', '-' + minimum, False),
                ('fold-remainder-min', minimum + '%-1', True),
            ):
                source = work / 'fold.b'
                source.write_text('data[' + expression + '];main(){return(0); }\n')
                result = subprocess.run([str(args.compiler.resolve()), '-S', str(source)],
                                        capture_output=True, timeout=30)
                ok = ((result.returncode == 0) if expected else
                      (result.returncode > 0 and b'negative' in result.stderr))
                ok = ok and b'runtime error:' not in result.stderr and b'Sanitizer' not in result.stderr
                print(f'{"PASS" if ok else "FAIL"}: arithmetic/{name}', flush=True)
                if not ok:
                    print(result.returncode, repr(result.stderr[-1800:]))
                passed += ok
                failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
