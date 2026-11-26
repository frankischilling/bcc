#!/usr/bin/env python3
"""Check B72 expression and lexical rules in all three bootstrap stages."""
import argparse
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tests'))
from test_b72_conformance import CASES


# Thompson's January 1972 reference, sections 2, 4.1, 4.10, 5.4 and 7.
# Rejection checks exercise the parser itself, without invoking GCC.
GRAMMAR_CASES = {
    'grammar_call_comma': ('f(x){return(x);}main(){return(f(0,));}', None),
    'grammar_library_comma': ('main(){return(char("x",0,));}', None),
    'grammar_initializer_comma': ('v[] 1,;main(){return(0);}', None),
    'grammar_scalar_comma': ('v 1,;main(){return(0);}', None),
    'grammar_braced_initializer': ('v[] {1,2};main(){return(0);}', None),
    'grammar_expression_initializer': ('v 1+2;main(){return(0);}', None),
    'grammar_parenthesized_initializer': ('v[1] (1);main(){return(0);}', None),
    'grammar_expression_extent': ('v[1+2];main(){return(0);}', None),
    'grammar_top_extrn': ('extrn x;main(){return(0);}', None),
    'grammar_comma_expression': ('main(){return(1,2);}', None),
    'grammar_switch_expression': ('main(){switch (1)+1 {case 2:return(0);}return(1);}', 0),
    'grammar_conditional_argument': ('f(a,b){return(a*10+b);}main(){return(f(1?2:3,4)!=24);}', 0),
    'grammar_global_constants': ("v[3] -1,'AB',\"x\";main(){extrn v;return(v[0]!=-1 | v[1]!='AB' | char(v[2],0)!='x');}", 0),
}

COMPAT_CASES = {
    'grammar_missing_hex_digits': ('main(){return(0x);}', None),
    'grammar_missing_upper_hex_digits': ('main(){return(0X);}', None),
    'grammar_hex_digits': ('main(){return(0X2a!=42 | 0x2A!=42);}', 0),
    'grammar_compat_switch_expression': GRAMMAR_CASES['grammar_switch_expression'],
    'grammar_compat_conditional_argument': GRAMMAR_CASES['grammar_conditional_argument'],
    'grammar_compat_comma_expression': ('main(){auto a;return((a=1,a+41)!=42);}', 0),
    'grammar_compat_initializers': ('v[1+2] {1+2,4,5};main(){return(v[0]+v[1]+v[2]!=12);}', 0),
}

DEPTH_CASES = {
    'depth_parentheses': 'main(){return(' + '(' * 2000 + '0' + ')' * 2000 + ');}',
    'depth_unary': 'main(){return(' + '!' * 2000 + '0);}',
    'depth_assignments': 'main(){auto x;' + 'x=' * 2000 + '0;return(0);}',
    'depth_binary_chain': 'main(){return(' + '1+' * 2000 + '0);}',
    'depth_postfix_chain': 'main(){auto x;x' + '[0]' * 2000 + ';return(0);}',
    'depth_blocks': 'main(){' + '{' * 2000 + ';' + '}' * 2000 + 'return(0);}',
    'depth_conditional': 'main(){return(' + '0?1:' * 2000 + '0);}',
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--build', type=Path, default=ROOT / 'bcc-b/build')
    parser.add_argument('--stage', type=int, choices=(1, 2, 3), action='append')
    parser.add_argument('--filter', default='')
    args = parser.parse_args()
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bbc-conformance-') as directory:
        work = Path(directory)
        for stage in args.stage or (1, 2, 3):
            compiler = args.build.resolve() / f'stage{stage}/bbc'
            cases = {**CASES, **GRAMMAR_CASES, **COMPAT_CASES,
                     **{name: (source, None) for name, source in DEPTH_CASES.items()},
                     'depth_moderate': ('main(){return(' + '(' * 48 + '0' + ')' * 48 + ');}', 0)}
            for name, (source, expected) in cases.items():
                if args.filter not in name:
                    continue
                path = work / 'case.b'
                path.write_text(source + '\n')
                command = [str(compiler), '--libdir', str(ROOT / 'lib')]
                if name not in COMPAT_CASES:
                    command += ['--strict', '--pedantic']
                parser_reject = expected is None and name not in CASES
                if parser_reject:
                    command += ['-S', str(path)]
                else:
                    command += [str(path), '-o', str(work / 'case')]
                try:
                    result = subprocess.run(command, capture_output=True, timeout=30)
                    if expected is None:
                        ok = result.returncode != 0 and (not parser_reject or b'bbc: ' in result.stderr)
                        if name in DEPTH_CASES:
                            ok = ok and b'nesting limit exceeded' in result.stderr
                    elif result.returncode:
                        ok = False
                    else:
                        result = subprocess.run([str(work / 'case')], input=b'', capture_output=True, timeout=5)
                        ok = result.returncode == expected
                    detail = result.stderr.decode(errors='replace')[-1500:]
                except (OSError, subprocess.TimeoutExpired) as error:
                    ok, detail = False, str(error)
                print(f'{"PASS" if ok else "FAIL"}: stage{stage}/{name}', flush=True)
                if not ok: print(detail)
                passed += ok
                failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
