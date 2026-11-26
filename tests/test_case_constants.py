#!/usr/bin/env python3
"""Match switch constants to B word arithmetic without compiler signed overflow."""
import argparse
from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]


def values(bits):
    maximum, minimum, mask = (1 << (bits-1))-1, -(1 << (bits-1)), (1 << bits)-1
    span = str(1 << bits) if bits < 64 else f"({mask}+1)"
    return [
        ('0', 0), ('1', 1), ('-1', -1), (str(maximum), maximum),
        (str(minimum), minimum), (str(mask), -1), (span, 0),
        (f'{maximum}+1', minimum), (f'{minimum}-1', maximum),
        (f'{maximum}*{maximum}', 1), (f'{minimum}*-1', minimum),
        (f'{minimum}/-1', minimum), (f'{minimum}%-1', 0),
        (f'({maximum}+1)<0', 1), (f'{mask}<0', 1),
        (f'1/({mask}<0)', 1), (f'!{span}', 1),
        (f'{mask}&{minimum}', minimum), (f'{minimum}|1', minimum+1),
        (f'{mask}==-1', 1), (f'{maximum}!={minimum}', 1),
        (f'{minimum}<={maximum}', 1), (f'{mask}>=0', 0),
        (f'{maximum}>{minimum}', 1),
    ]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=ROOT/'bcc')
    args = parser.parse_args()
    passed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-case-constants-') as directory:
        work = Path(directory)
        for mode, bits in [('16', 16), ('32', 32), ('host', 64)]:
            cases = values(bits)
            functions = []
            for i, (expression, expected) in enumerate(cases):
                other = (expected + 1 + (1 << (bits-1))) % (1 << bits) - (1 << (bits-1))
                functions.append(f'f{i}(){{auto x;x=0;switch ({expected}) {{case ({expression}):x=1;}}'
                                 f'if(x!=1)return(1);switch ({other}) {{case ({expression}):return(1);}}return(0);}}')
            entry = 'main(){'+''.join(f'if(f{i}())return({i+1});' for i in range(len(cases)))+'return(0);}'
            (work/'all.b').write_text('\n'.join(functions)+entry)
            (work/'functions.b').write_text('\n'.join(functions))
            (work/'main.b').write_text(entry)
            base = [str(args.compiler.resolve()), '--pedantic', '--word='+mode]

            def run(command):
                result = subprocess.run(command, cwd=work, capture_output=True, timeout=120)
                assert result.returncode == 0, (mode, command, result.returncode, result.stderr[-1600:])
                assert b'runtime error:' not in result.stderr and b'Sanitizer' not in result.stderr, result
                return result

            for sources in (['all.b'], ['functions.b', 'main.b']):
                run([*base, *sources, '-o', 'program'])
                result = run([str(work/'program')])
                assert not result.stdout and not result.stderr, result
                passed += len(cases)*2
            stdout = run([*base, '-S', 'all.b']).stdout
            run([*base, '-E', 'all.b', '-o', 'output.c'])
            assert stdout == (work/'output.c').read_bytes(), mode
            passed += 2
            maximum = (1 << (bits-1))-1
            for operator, diagnostic in [('/', b'division by zero'), ('%', b'mod by zero')]:
                (work/'bad.b').write_text(f'main(){{switch 0 {{case (1{operator}(({maximum}+1)*2)):return(0);}}return(0);}}')
                result = subprocess.run([*base, '-S', 'bad.b'], cwd=work, capture_output=True, timeout=30)
                assert result.returncode > 0 and diagnostic in result.stderr, (mode, result)
                assert b'runtime error:' not in result.stderr and b'Sanitizer' not in result.stderr, result
                passed += 1
    print(f'Results: {passed} passed, 0 failed')


if __name__ == '__main__':
    main()
