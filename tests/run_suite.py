#!/usr/bin/env python3
"""Run each host suite and reject missing, crashed, or empty test runs."""
import argparse
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile

ANSI = re.compile(r'\x1b\[[0-9;]*m')
SUMMARY = re.compile(r'Results:\s*(\d+) passed,\s*(\d+) failed(?:,\s*(\d+) skipped)?')


def checked_run(command, label):
    try:
        result = subprocess.run(command, capture_output=True, text=True,
                                errors='replace', timeout=600)
    except (OSError, subprocess.TimeoutExpired) as error:
        print(f'FAIL: {label}: {error}', flush=True)
        return False
    print(result.stdout, end='', flush=True)
    if result.stderr:
        print(result.stderr, end='', file=sys.stderr, flush=True)
    summaries = SUMMARY.findall(ANSI.sub('', result.stdout))
    if not summaries:
        print(f'FAIL: {label}: no test summary', flush=True)
        return False
    passed, failed, _ = summaries[-1]
    if int(passed) + int(failed) == 0:
        print(f'FAIL: {label}: no tests executed', flush=True)
        return False
    return result.returncode == 0 and int(failed) == 0


def main():
    root = Path(__file__).resolve().parent.parent
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=root / 'bcc')
    parser.add_argument('-q', '--quick', action='store_true')
    parser.add_argument('-v', '--verbose', action='store_true')
    args = parser.parse_args()
    compiler = args.compiler.resolve()
    if not compiler.is_file():
        parser.error(f'compiler not found: {compiler}')
    harness = subprocess.run([sys.executable, str(root / "tests/test_suite_runner.py")])
    ok = harness.returncode == 0
    with tempfile.TemporaryDirectory(prefix='bcc-suite-') as directory:
        stage = Path(directory)
        shutil.copytree(root / 'tests', stage / 'tests')
        (stage / 'bcc').symlink_to(compiler)
        for path in (stage / 'tests').rglob('*'):
            if path.is_file() and path.suffix in {'.sh', '.b', '.out', '.exit', '.ast'}:
                path.write_bytes(path.read_bytes().replace(b'\r\n', b'\n'))
        suites = ['run_tests.sh', 'run_conformance.sh', 'test_strict_historical.sh']
        if not args.quick:
            suites.append('test_word_semantics.sh')
        for name in suites:
            path = stage / 'tests' / name
            if not path.is_file():
                print(f'FAIL: missing suite {name}')
                ok = False
                continue
            command = ['bash', str(path)]
            if args.verbose and name in suites[:2]:
                command.append('--verbose')
            ok = checked_run(command, name) and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_b72_conformance.py'),
                          '--bcc', str(compiler)], 'B72 conformance') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_assembly_output.py'),
                          '--compiler', str(compiler)], 'assembly output') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_command_arguments.py'),
                          '--compiler', str(compiler)], 'command arguments') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_exec_runtime.py'),
                          '--compiler', str(compiler)], 'exec runtime') and ok
    print('All host suites passed.' if ok else 'Host suite failed.')
    return 0 if ok else 1


if __name__ == '__main__':
    raise SystemExit(main())
