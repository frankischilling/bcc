#!/usr/bin/env python3
"""Check wide B literals without changing the PDP-11 frontend's word rules."""
import argparse
import importlib.util
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[1]
spec = importlib.util.spec_from_file_location('wide_frontend', ROOT / 'frontend/build.py')
frontend = importlib.util.module_from_spec(spec)
spec.loader.exec_module(frontend)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=PROJECT / 'bcc')
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    compiler = [str(args.compiler.resolve()), '--strict', '--pedantic']
    if not args.bootstrap:
        compiler.append('--word=host')
    passed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-wide-frontend-test-') as directory:
        work = Path(directory)
        source = work / 'frontend.b'
        source.write_text(frontend.source_text())
        joined = work / 'joined.b'
        subprocess.run([sys.executable, str(ROOT / 'frontend/build.py'), str(joined),
                        '--source-only', '--compiler', str(work / 'absent-compiler')],
                       check=True, timeout=30)
        assert joined.read_text() == source.read_text()
        passed += 1
        original = frontend.MODULES['frontend']
        try:
            frontend.MODULES['frontend'] = tuple(part for part in original if part != 'frontend/word16.b')
            try:
                frontend.source_text()
            except ValueError as error:
                assert 'word-specific helpers' in str(error)
            else:
                raise AssertionError('missing word module was silently accepted')
        finally:
            frontend.MODULES['frontend'] = original
        passed += 1
        binary = work / 'frontend'
        subprocess.run([*compiler, str(source), '-o', str(binary)], check=True, timeout=180)

        def check(name, text, record=None, error=None):
            nonlocal passed
            (work / 'input.b').write_text(text)
            result = subprocess.run([str(binary), 'input.b'], cwd=work,
                                    capture_output=True, timeout=30)
            if error:
                assert result.returncode != 0 and error in result.stderr, (name, result)
            else:
                assert (result.returncode, result.stderr) == (0, b''), (name, result)
                if record is not None:
                    assert record in result.stdout.splitlines(), (name, record, result)
            passed += 1

        for value in (0, 1, 32767, 32768, 65535, 65536, 2**31-1, 2**31, 2**32-1,
                      2**32, 2**63-1, 2**63, 2**64-1, 2**64, 2**64+1):
            normalized = value & (2**64-1)
            if normalized >= 2**63:
                normalized -= 2**64
            check(f'decimal-{value}', f'main(){{return({value});}}', f'n {normalized}'.encode())
            check(f'octal-{value}', f'main(){{return(0{value:o});}}', f'n {normalized}'.encode())
        check('global-minimum', 'data -9223372036854775808;main(){return(0);}', b'gvc -9223372036854775808')
        check('global-maximum', 'data 9223372036854775807;main(){return(0);}', b'gvc 9223372036854775807')
        check('octal-eight-nine', 'main(){return(099);}', b'n 81')
        check('two-character', "main(){return('AB');}", b'n 16706')
        check('too-many-characters', "main(){return('ABC');}", error=b'character constant too long')
        check('eight-character-name', 'abcdefgh 1;main(){extrn abcdefgh;return(abcdefgh);}')
        check('long-name', 'abcdefghi 1;main(){return(0);}', error=b'identifier too long')
        check('embedded-null', 'main(){return("a*0b");}', b'Slit 4 97 0 98 4')
        check('string-limit', 'main(){return("' + 'a'*255 + '");}')
        check('string-overflow', 'main(){return("' + 'a'*256 + '");}', error=b'string literal too long')
        check('missing-input-terminator', 'main(){return(1)', error=b'expected')
        check('self-parse', source.read_text())
        for name in ('x64.b', 'labels.b', 'ops.b', 'elfimage.b', 'arity.b', 'scalar.b', 'memory.b', 'control.b'):
            check('backend/' + name, (ROOT / name).read_text())
        (work / 'input.b').write_text('main(){return(9223372036854775808);}')
        result = subprocess.run([str(binary), '-o', 'records', '-s', 'done', 'input.b'], cwd=work,
                                capture_output=True, timeout=30)
        assert (result.returncode, result.stdout, result.stderr) == (0, b'', b''), result
        assert b'n -9223372036854775808\n' in (work / 'records').read_bytes()
        assert (work / 'done').read_bytes() == b'ok'
        passed += 1
        cli_binary = work / 'frontend cli'
        command = [sys.executable, str(ROOT / 'frontend/build.py'), str(cli_binary),
                   '--compiler', str(args.compiler.resolve())]
        if args.bootstrap:
            command.append('--bootstrap')
        subprocess.run(command, check=True, timeout=180)
        result = subprocess.run([str(cli_binary), 'input.b'], cwd=work, capture_output=True, timeout=30)
        assert (result.returncode, result.stderr) == (0, b''), result
        assert b'n -9223372036854775808\n' in result.stdout
        passed += 1
        if not args.bootstrap:
            for word in ('16', '32'):
                narrow = work / ('frontend-' + word)
                subprocess.run([str(args.compiler.resolve()), '--strict', '--pedantic', '--word=' + word,
                                str(source), '-o', str(narrow)], check=True, timeout=180)
                result = subprocess.run([str(narrow), 'input.b'], cwd=work, capture_output=True, timeout=30)
                assert result.returncode != 0 and b'requires 64-bit words' in result.stderr, result
                assert not result.stdout, result
                passed += 1
    print(f'{passed} wide-frontend checks passed', flush=True)


if __name__ == '__main__':
    main()
