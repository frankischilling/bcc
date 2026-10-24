#!/usr/bin/env python3
"""Assemble and execute --asm output, including nonconstant return values."""
import argparse
from pathlib import Path
import subprocess
import tempfile
from test_b72_conformance import CASES, WORD_CASES

EXTRA = {
    'globals_calls_loops': ('g 7; v[3] 3,4,5; twice(n){return(n*2);} main(){extrn g,v; auto i,s; s=g; i=0; while(i<3){s=+v[i]; i++;} return(twice(s));}', 38, b''),
    'recursion_and_output': ('f(n){if(n<2)return(1); return(n*f(n-1));} main(){extrn putchar; putchar(\'B\'); putchar(\'*n\'); return(f(5));}', 120, b'B\n'),
    'function_value': ('f(){return(37);} main(){auto p; p=f; return(p());}', 37, b''),
    'branch_value': ('main(){auto p; p=done; goto p; return(3); done:return(61);}', 61, b''),
}


def require(condition, detail):
    if not condition:
        raise AssertionError(detail)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=Path(__file__).resolve().parents[1] / 'bcc')
    args = parser.parse_args()
    compiler = str(args.compiler.resolve())
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-asm-output-') as directory:
        tmp = Path(directory)
        for bits in ('host', '16'):
            cases = {name: (source, expected, None) for name, (source, expected) in CASES.items()}
            if bits == '16':
                cases.update({name: (source, 0, None) for name, source in WORD_CASES.items()})
            cases.update(EXTRA)
            for name, (source, expected, output) in cases.items():
                path = tmp / 'case.b'
                path.write_text(source + '\n')
                try:
                    result = subprocess.run([compiler, '--asm', '--strict', '--pedantic',
                                             f'--word={bits}', str(path)], capture_output=True, timeout=30)
                    if expected is None:
                        require(result.returncode > 0 and result.stderr, 'missing source diagnostic')
                    else:
                        require(result.returncode == 0, result.stderr[-1500:])
                        assembly = tmp / 'case.s'
                        assembly.write_bytes(result.stdout)
                        linked = subprocess.run(['gcc', str(assembly), '-ldl', '-lm', '-o', str(tmp / 'case')],
                                                capture_output=True, timeout=20)
                        require(linked.returncode == 0, linked.stderr[-1500:])
                        run = subprocess.run([str(tmp / 'case')], input=b'', capture_output=True, cwd=tmp, timeout=5)
                        require(run.returncode == expected, (run.returncode, expected, run.stderr))
                        if output is not None:
                            require(run.stdout == output, (run.stdout, output))
                    passed += 1
                except (AssertionError, OSError, subprocess.TimeoutExpired) as error:
                    failed += 1
                    print(f'FAIL: asm/{bits}/{name}: {error}')
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
