#!/usr/bin/env python3
"""Check syntax boundaries and exercise the compiler with mutated B sources."""
import argparse
from pathlib import Path
import random
import subprocess
import tempfile


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    args = parser.parse_args()
    compiler = args.compiler.resolve()
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-parser-') as directory:
        root = Path(directory)
        path = root / 'case.b'

        def check(name, source, flags, expected, diagnostic=b'', execute=False):
            nonlocal passed, failed
            path.write_bytes(source.encode('ascii'))
            command = [str(compiler), *flags, '--verbose-errors']
            command += ['-o', str(root / 'case')] if execute else ['-S']
            try:
                result = subprocess.run([*command, str(path)], cwd=root,
                                        stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, timeout=15)
                ok = result.returncode >= 0 and not any(marker in result.stderr for marker in
                    (b'Sanitizer', b'runtime error:'))
                if expected is not None:
                    ok = ok and ((result.returncode == 0) == expected)
                ok = ok and (result.returncode == 0 or bool(result.stderr))
                ok = ok and diagnostic in result.stderr
                if ok and execute:
                    result = subprocess.run([str(root / 'case')], cwd=root, capture_output=True, timeout=5)
                    ok = result.returncode == 0 and not result.stdout and not result.stderr
                detail = (result.returncode, result.stderr[-1200:])
            except (OSError, subprocess.TimeoutExpired) as error:
                ok, detail = False, str(error)
            print(f'{"PASS" if ok else "FAIL"}: parser/{name}', flush=True)
            if not ok:
                print(repr(source[:300]), detail)
            passed += ok
            failed += not ok

        strict = ['--strict', '--pedantic']
        for prefix in ('0x', '0X'):
            check('empty-' + prefix, f'main(){{return({prefix});}}', [], False,
                  b'hexadecimal digit')
        check('hex-extension', 'main(){return(0x2a!=42 | 0XfF!=255);}', [], True, execute=True)
        check('compatibility-initializers', 'v[1+2] {1,2,3}; x 1+2; main(){extrn v,x;return((1,v[2])!=3 | x!=3);}', [], True, execute=True)
        check('strict-literal-initializers', 'v[3] 1,2,3; x -7; p v; main(){extrn v,x,p;return(v[2]!=3 | x!=-7 | *p!=v);}', strict, True, execute=True)
        check('moderate-depth', 'main(){return(' + '(' * 48 + '0' + ')' * 48 + ');}', strict, True, execute=True)
        check('long-flat-block', 'main(){' + ';' * 5000 + 'return(0);}', strict, True)

        deep = {
            'parentheses': 'main(){return(' + '(' * 2000 + '0' + ')' * 2000 + ');}',
            'unary': 'main(){return(' + '!' * 2000 + '0);}',
            'assignments': 'main(){auto x;' + 'x=' * 2000 + '0;return(0);}',
            'binary-chain': 'main(){return(' + '1+' * 2000 + '0);}',
            'postfix-chain': 'main(){auto x;x' + '[0]' * 2000 + ';return(0);}',
            'blocks': 'main(){' + '{' * 2000 + ';' + '}' * 2000 + 'return(0);}',
            'initializers': 'v[] ' + '{' * 2000 + '0' + '}' * 2000 + ';main(){return(0);}',
        }
        for name, source in deep.items():
            check('depth-' + name, source, [], False, b'nesting limit exceeded')

        # Fixed seed, bounded inputs, and no claim that every mutation is invalid.
        rng = random.Random(197201)
        seeds = (
            'main(){auto x;x=3;while(x)x--;return(x);}',
            'f(x){return(x+1);}main(){return(f(41)!=42);}',
            'data[3] 1,2,3;main(){extrn data;return(data[1]!=2);}',
            'main(){auto p;p=done;goto p;done:return(0);}',
            'main(){switch (1)+1 {case 2:return(0);}return(1);}',
            'main(){extrn char;return(char("ab*e",1)!=98);}',
        )
        alphabet = 'abcdefghijklmnopqrstuvwxyz0123456789(){}[];,+-*/&|=!?:\'"\n\x00'
        for index in range(128):
            source = rng.choice(seeds)
            for _ in range(rng.randint(1, 6)):
                at = rng.randrange(len(source) + 1)
                if rng.randrange(2):
                    source = source[:at] + rng.choice(alphabet) + source[at:]
                else:
                    source = source[:at] + source[at+1:]
            check(f'mutation-{index:03}', source, strict if index % 2 else [], None)
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
