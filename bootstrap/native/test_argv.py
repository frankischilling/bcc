#!/usr/bin/env python3
"""Pack Linux entry arguments into independent word-aligned B strings."""
import argparse
import os
from pathlib import Path
import platform
import struct
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[1]
NATIVE = PROJECT / 'pdp-11/bcc-pdp/bootstrap/src'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=PROJECT / 'bcc')
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    command = [str(args.compiler.resolve()), '--strict', '--pedantic']
    if not args.bootstrap:
        command.append('--word=host')
    execute = platform.system() == 'Linux' and platform.machine().lower() in ('x86_64', 'amd64')
    passed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-native-argv-') as directory:
        work = Path(directory)
        parts = [NATIVE / n for n in ('buffered_io.b', 'decimal16.b', 'diagnostics.b', 'ic.b')]
        parts += [ROOT / n for n in ('x64.b', 'labels.b', 'ops.b', 'scalar.b', 'memory.b',
                                    'calls.b', 'runtime/emit.b', 'runtime/path.b',
                                    'runtime/argv.b', 'fixtures/runtime/argv.b')]
        (work / 'emit.b').write_text('\n'.join(p.read_text() for p in parts))
        for name, source in [('emit', work / 'emit.b'), ('image', ROOT / 'elfimage.b')]:
            subprocess.run([*command, str(source), '-o', str(work / name)], check=True, timeout=180)
        env = dict(os.environ, PATH='')
        (work / 'empty').write_bytes(b'')

        def check(arguments, limit=1048576, mode=0, status=0):
            nonlocal passed
            code = subprocess.run([str(work / 'emit'), str(limit), str(mode)], cwd=work,
                                  env=env, capture_output=True, timeout=30)
            assert (code.returncode, code.stderr) == (0, b''), code
            (work / 'code').write_bytes(code.stdout)
            image = subprocess.run([str(work / 'image'), 'code', 'empty', '0', '0'], cwd=work,
                                   env=env, capture_output=True, timeout=30)
            assert (image.returncode, image.stderr) == (0, b''), image
            if execute:
                program = work / 'program'
                program.write_bytes(image.stdout)
                program.chmod(0o700)
                values = [os.fsencode(program), *arguments]
                run = subprocess.run(values, cwd=work, env=env, capture_output=True, timeout=10)
                expected = b'' if status else struct.pack('<q', len(values)) + b''.join(v + b'\0' for v in values)
                if mode == 4:
                    changed = [b'!' + values[0][1:], *values[1:]]
                    expected = struct.pack('<q', len(changed)) + b''.join(v + b'\0' for v in changed)
                if mode == 3:
                    expected = struct.pack('<q', 0)
                assert (run.returncode, run.stdout, run.stderr) == (status, expected, b''), (limit, mode, run)
            passed += 1

        for values in ([], [b''], [b'alpha', b'beta'], [b'', b'two words', b''],
                       [b'\xff\x04\x80'], [b'x' * n for n in range(33)],
                       [b'x' * 131071], [b'abc'] * 1024):
            check(values)
        check([], mode=1, status=77)
        check([], mode=2, status=77)
        check([], mode=3)
        check([b'unchanged'], mode=4)
        check([], mode=6, status=77)
        check([b''] * 4094)
        check([b''] * 4095, status=77)
        check([], limit=16, status=77)
        # Exact storage includes the vector and a separately rounded string.
        needed = 16 + ((len(os.fsencode(work / 'program')) + 1 + 7) // 8) * 8
        check([], limit=needed)
        check([], limit=needed - 8, status=77)
        for limit in (0, 15, 17, 16777224):
            run = subprocess.run([str(work / 'emit'), str(limit), '0'], cwd=work,
                                 env=env, capture_output=True, timeout=30)
            assert run.returncode != 0 and run.stderr, (limit, run)
            passed += 1
    print(f'{passed} native argv checks passed')
    if not execute:
        print('SKIP: native execution requires Linux x86-64')


if __name__ == '__main__':
    main()
