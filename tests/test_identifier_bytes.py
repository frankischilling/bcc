#!/usr/bin/env python3
"""Check B72 backspace names and collision-free host identifier encoding."""
import argparse
from pathlib import Path
import subprocess
import sys
import tempfile

BS = '\x08'
CASES = {
    'source-nul-leading': ['\x00main(){return(0);}'],
    'source-nul-middle': ['main(){return(0);}\x00invalid source'],
    'source-nul-trailing': ['main(){return(0);}\x00'],
    'leading-function': [f'{BS}fn(x){{return(x+1);}}main(){{extrn {BS}fn;return({BS}fn(41)!=42);}}'],
    'global': [f'a{BS}A 42;main(){{extrn a{BS}A;return(a{BS}A!=42);}}'],
    'local': [f'main(){{auto a{BS};a{BS}=42;return(a{BS}!=42);}}'],
    'parameter': [f'f(a{BS}){{return(a{BS}+1);}}main(){{extrn f;return(f(41)!=42);}}'],
    'label': [f'main(){{auto p;p=lab{BS};goto p;return(1);lab{BS}:return(0);}}'],
    'eight-bytes': [f'abc{BS}defg 42;main(){{extrn abc{BS}defg;return(abc{BS}defg!=42);}}'],
    'distinct-names': [f'a{BS}A 11;a_08A 22;aA 33;main(){{extrn a{BS}A,a_08A,aA;return(a{BS}A!=11 | a_08A!=22 | aA!=33);}}'],
    'cross-file': [f'a{BS}A(x){{return(x+1);}}a_08A(x){{return(x+2);}}', f'main(){{extrn a_08A,a{BS}A;return(a_08A(40)!=42 | a{BS}A(41)!=42);}}'],
    'too-long': [f'abcd{BS}defg 42;main(){{extrn abcd{BS}defg;return(abcd{BS}defg!=42);}}'],
}
PREFIX = f'a{BS}A(x){{return(x+1);}}__bcc_bs_610841(x){{return(x+2);}}__bbc_bs_610841(x){{return(x+3);}}main(){{extrn a{BS}A,__bcc_bs_610841,__bbc_bs_610841;return(a{BS}A(41)!=42 | __bcc_bs_610841(40)!=42 | __bbc_bs_610841(39)!=42);}}'

V1_SOURCE = (f'{BS}fn(arg{BS}){{return(arg{BS}+1);}}a{BS}A 42;a_08A 11;abc{BS}defg 7;'
             f'main(){{extrn {BS}fn,a{BS}A,a_08A,abc{BS}defg,putchar;auto p{BS};'
             f'p{BS}=lab{BS};goto p{BS};return(1);lab{BS}:'
             f'if({BS}fn(41)!=42 | a{BS}A!=42 | a_08A!=11 | abc{BS}defg!=7)return(2);'
             "putchar('OK');putchar('*n');return(0); }\n")


def main():
    root = Path(__file__).resolve().parent.parent
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=root / 'bcc')
    parser.add_argument('--write-fixture', type=Path, help='write a backspace-name program for full-system testing')
    group = parser.add_mutually_exclusive_group()
    group.add_argument('--bootstrap', action='store_true')
    group.add_argument('--native', action='store_true')
    args = parser.parse_args()
    if args.write_fixture:
        args.write_fixture.write_bytes(V1_SOURCE.encode('ascii'))
        return 0
    modes = [('native', False)] if args.native else [('host', False)] if args.bootstrap else [
        (bits, inline) for bits in ('host', '16', '32') for inline in (False, True)
    ]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-identifier-bytes-') as directory:
        work = Path(directory)
        for bits, inline in modes:
            for strict in ((True,) if args.native else (False, True)):
                cases = dict(CASES)
                if not strict:
                    cases['reserved-prefix'] = [PREFIX]
                for name, sources in cases.items():
                    if args.native and len(sources) != 1:
                        continue
                    paths = []
                    for index, source in enumerate(sources):
                        path = work / f'part{index}.b'
                        path.write_bytes(source.encode('ascii') + b'\n')
                        paths.append(str(path))
                    reject = name.startswith('source-nul-') or (strict and name == 'too-long')
                    try:
                        if args.native:
                            result = subprocess.run([sys.executable, str(root / 'pdp-11/bcc-pdp/tools/run_apout.py'), paths[0]],
                                                    capture_output=True, timeout=30)
                        else:
                            command = [str(args.compiler.resolve())]
                            if strict:
                                command += ['--strict', '--pedantic']
                            if not args.bootstrap:
                                command += [f'--word={bits}', '--verbose-errors']
                            if inline:
                                command.append('--inline-runtime')
                            result = subprocess.run(command + paths + ['-o', str(work / 'case')],
                                                    capture_output=True, timeout=30)
                            if result.returncode == 0 and not reject:
                                result = subprocess.run([str(work / 'case')], capture_output=True, timeout=10)
                        output = result.stdout + result.stderr
                        if name.startswith('source-nul-'):
                            diagnostic = b'unexpected character' if args.native else b'NUL byte outside a literal'
                            ok = result.returncode > 0 and diagnostic in output
                        elif reject:
                            ok = result.returncode > 0 and (b'names cannot exceed 8' in output or b'identifier too long' in output)
                        else:
                            ok = result.returncode == 0
                            if not args.native:
                                ok = ok and not result.stdout and not result.stderr
                        ok = ok and b'Sanitizer' not in output and b'runtime error:' not in output
                        detail = repr((result.returncode, output[-1500:]))
                    except (OSError, subprocess.TimeoutExpired) as error:
                        ok, detail = False, str(error)
                    print(f'{"PASS" if ok else "FAIL"}: identifiers/{bits}/{inline}/{strict}/{name}', flush=True)
                    if not ok:
                        print(detail)
                    passed += ok
                    failed += not ok
        if not args.bootstrap and not args.native:
            for bits, inline in modes:
                provider = work / 'provider.b'
                caller = work / 'caller.b'
                provider.write_bytes(CASES['cross-file'][0].encode('ascii'))
                caller.write_bytes(CASES['cross-file'][1].encode('ascii'))
                command = [str(args.compiler.resolve()), '--strict', '--pedantic', f'--word={bits}']
                if inline:
                    command.append('--inline-runtime')
                try:
                    result = subprocess.run(command + ['-c', str(provider), '-o', str(work / 'provider.o')],
                                            capture_output=True, timeout=30)
                    if result.returncode == 0:
                        result = subprocess.run(command + [str(caller), '-X', str(work / 'provider.o'), '-o', str(work / 'linked')],
                                                capture_output=True, timeout=30)
                    if result.returncode == 0:
                        result = subprocess.run([str(work / 'linked')], capture_output=True, timeout=10)
                    ok = result.returncode == 0 and not result.stdout and not result.stderr
                    detail = repr((result.returncode, result.stdout, result.stderr[-1500:]))
                except (OSError, subprocess.TimeoutExpired) as error:
                    ok, detail = False, str(error)
                print(f'{"PASS" if ok else "FAIL"}: identifiers/{bits}/{inline}/separate-object', flush=True)
                if not ok:
                    print(detail)
                passed += ok
                failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
