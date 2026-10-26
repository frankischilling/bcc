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
    success = "putchar('OK');putchar('*n');return(0);"
    checks = [
        ('adjacent-if-labels', 'x=0;if(0) first:second:x=7;else x=9;if(x!=9)return(1);'),
        ('label-before-case', 'x=0;switch 1 if(0) mark:case 1:x=7;else x=9;if(x!=7)return(1);'),
        ('label-inside-if', 'x=0;if(0) done:x=7;else x=9;if(x!=9)return(1);'),
        ('label-inside-while', 'x=0;while(0) done:x++;if(x!=0)return(1);'),
        ('jump-into-if-label', 'x=0;goto done;if(0) done:x=7;else x=9;if(x!=7)return(1);'),
        ('case-declaration-prefix', 'switch 1 case 1:auto y;y=7;if(y!=7)return(1);'),
        ('case-string', 'extrn char;switch 1 case 1:auto p;p="";x=char(p,0);if(x!=4)return(1);'),
        ('duplicate-case', 'x=0;switch 1 {case 1:x=7;case 1:x=+2;}if(x!=9)return(1);'),
        ('duplicate-first', 'x=0;switch 1 {case 1:x=7;goto done;case 1:x=9;}done:if(x!=7)return(1);'),
        ('duplicate-nested', 'x=0;switch 1 {case 1:switch 2 {case 2:x=7;goto done;case 2:x=9;}case 1:x=11;}done:if(x!=7)return(1);'),
        ('unbraced-case', 'x=0;switch 1 case 1:x=7;if(x!=7)return(1);'),
        ('case-inside-if', 'x=0;switch 1 if(0) case 1:x=7;else x=9;if(x!=7)return(1);'),
        ('case-inside-while', 'x=0;switch 1 while(0) case 1:{x=7;goto done;}done:if(x!=7)return(1);'),
        ('case-selector-once', 'x=0;switch x++ {case 0:x=+7;case 0:x=+2;}if(x!=10)return(1);'),
        ('nested-unbraced', 'x=0;switch 1 case 1:switch 2 case 2:x=7;if(x!=7)return(1);'),
    ]
    for name, body in checks:
        cases.append((name, 'main(){extrn putchar;auto x;'+body+success+'}', b'OK\n', None))
    cases += [('trailing-label', 'main(){done:}', None, b''), ('trailing-case', 'main(){switch 1 {case 1:}}', None, b'')]
    cases += [('outside', 'main(){case 1:return(0);}', None, b'case')]
    if args.native:
        cases += [('capacity', 'main(){switch 0 {'+''.join(f'case {i}:' for i in range(33))+'return(0);}}', None, b'>c')]
    cases = [(*case, True) for case in cases]
    if not args.native:
        compatibility = [
            ('continue-enclosing-loop', 'auto i;i=0;x=0;while(i<3){i++;switch i {case 1:i=2;continue;default:x++;}}if(x!=1)return(1);'),
            ('continue-inner-loop', 'auto i;i=0;x=0;switch 1 {default:while(i<3){i++;continue;x++;}}if(i!=3|x!=0)return(1);'),
            ('continue-nested-switch', 'auto i;i=0;x=0;while(i<3){i++;switch 1 {default:switch 2 {default:continue;}}x++;}if(x!=0)return(1);'),
            ('default-unmatched', 'x=0;switch 7 {case 1:x=1;break;default:x=7;}if(x!=7)return(1);'),
            ('default-before-match', 'x=0;switch 7 {default:x=1;break;case 7:x=7;}if(x!=7)return(1);'),
            ('negative-not-default', 'x=0;switch -1 {case -1:x=7;break;default:x=9;}if(x!=7)return(1);'),
            ('default-fallthrough', 'x=0;switch 7 {default:x=3;case 2:x=+4;}if(x!=7)return(1);'),
            ('default-nested', 'x=0;switch 7 {default:switch 3 {case 1:x=1;break;default:x=7;}}if(x!=7)return(1);'),
            ('case-declaration', 'switch 1 {case 1:auto y;y=7;case 2:if(y!=7)return(1);}'),
        ]
        for name, body in compatibility:
            cases.append((name, 'main(){extrn putchar;auto x;'+body+success+'}', b'OK\n', None, False))
        cases.append(('continue-no-loop', 'main(){switch 1 {default:continue;}}', None, b'continue', False))
        cases.append(('duplicate-default', 'main(){switch 1 {default:;default:;}}', None, b'default', False))
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-switch-') as directory:
        work = Path(directory)
        for word, inline in modes:
            for name, source, expected, diagnostic, strict in cases:
                path = work/'case.b'; path.write_text(source+'\n')
                if args.native:
                    command = [sys.executable, str(ROOT/'pdp-11/bcc-pdp/tools/run_apout.py'), '--timeout', '10', str(path)]
                else:
                    command = [str(args.compiler.resolve())]
                    if strict: command += ['--strict', '--pedantic']
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
                print(f'{"PASS" if ok else "FAIL"}: switch/{word}/{inline}/{strict}/{name}', flush=True)
                if not ok: print(result.returncode, repr(output[-1800:]))
                passed += ok; failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
