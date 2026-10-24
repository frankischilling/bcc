#!/usr/bin/env python3
"""Reject failed compiler output instead of accepting a truncated translation."""
import argparse
import os
from pathlib import Path
import subprocess
import tempfile


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    compiler = str(args.compiler.resolve())
    if not Path('/dev/full').exists():
        print('Results: 0 passed, 0 failed, 1 skipped')
        return 0
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-output-errors-') as directory:
        root = Path(directory)
        tools = root / 'tools'
        tools.mkdir()
        # A broken compiler must not send /dev/full's endless zero input to GCC.
        fake_gcc = tools / 'gcc'
        fake_gcc.write_text('#!/bin/sh\nprintf "unexpected C compiler invocation\\n" >&2\nexit 97\n')
        fake_gcc.chmod(0o755)
        source = root / 'input.b'
        source.write_text('main(){return(0);}\n')
        modes = ['-S'] if args.bootstrap else ['-S', '--dump-c', '--dump-tokens', '--dump-ast']
        cases = [(mode + '/stdout', [mode, str(source)], True, False) for mode in modes]
        if not args.bootstrap:
            cases.append(('named/output', ['-E', str(source), '-o', '/dev/full'], False, False))
        cases.append(('generated/output', ['--emit-c', str(source)], False, True))
        cases.append(('working/stdout', ['-S', str(source)], False, False))
        for name, flags, full_stdout, full_file in cases:
            generated = Path(str(source) + '.c')
            if generated.exists() or generated.is_symlink():
                generated.unlink()
            if full_file:
                generated.symlink_to('/dev/full')
            try:
                with open('/dev/full' if full_stdout else '/dev/null', 'wb') as sink:
                    env = os.environ.copy()
                    if full_file:
                        env['PATH'] = str(tools) + os.pathsep + env.get('PATH', '')
                    result = subprocess.run([compiler, *flags], cwd=root, env=env,
                                            stdout=sink if full_stdout else subprocess.PIPE,
                                            stderr=subprocess.PIPE, timeout=30)
                if name == 'working/stdout':
                    ok = result.returncode == 0 and bool(result.stdout)
                else:
                    ok = (result.returncode > 0 and b'write' in result.stderr.lower()
                          and b'unexpected C compiler invocation' not in result.stderr)
                print(f'{"PASS" if ok else "FAIL"}: {name}')
                if not ok:
                    print(result.returncode, repr(result.stderr))
                passed += ok
                failed += not ok
            except (OSError, subprocess.TimeoutExpired) as error:
                print(f'FAIL: {name}: {error}')
                failed += 1
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
