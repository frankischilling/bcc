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
        ok = checked_run([sys.executable, str(root / 'tests/test_object_output.py'),
                          '--compiler', str(compiler)], 'object output') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_assembly_output.py'),
                          '--compiler', str(compiler)], 'assembly output') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_command_arguments.py'),
                          '--compiler', str(compiler)], 'command arguments') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_exec_runtime.py'),
                          '--compiler', str(compiler)], 'exec runtime') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_tty_runtime.py'),
                          '--compiler', str(compiler)], 'terminal buffer safety') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_time_runtime.py'),
                          '--compiler', str(compiler)], 'time runtime') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_library_bindings.py'),
                          '--compiler', str(compiler)], 'library binding callbacks') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_library_names.py'),
                          '--compiler', str(compiler)], 'library names') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_putchar_runtime.py'),
                          '--compiler', str(compiler)], 'packed character output') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_vector_extent.py'),
                          '--compiler', str(compiler)], 'vector extents') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_argv_runtime.py'),
                          '--compiler', str(compiler)], 'argument vector') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_unix_metadata.py'),
                          '--compiler', str(compiler)], 'Unix metadata') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_switch_runtime.py'),
                          '--compiler', str(compiler)], 'switch control flow') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_external_scope.py'),
                          '--compiler', str(compiler)], 'external declaration scope') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_declarations.py'),
                          '--compiler', str(compiler)], 'declaration statements') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_docs_examples.py'),
                          '--compiler', str(compiler)], 'documentation examples') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_identifier_bytes.py'),
                          '--compiler', str(compiler)], 'B identifier bytes') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_word_arithmetic.py'),
                          '--compiler', str(compiler)], 'word arithmetic') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_call_frames.py'),
                          '--compiler', str(compiler)], 'B call frames') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_parameter_layout.py'),
                          '--compiler', str(compiler)], 'parameter storage') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_function_cells.py'),
                          '--compiler', str(compiler)], 'source function cells') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_label_cells.py'),
                          '--compiler', str(compiler)], 'internal label cells') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_mkdir_runtime.py'),
                          '--compiler', str(compiler)], 'mkdir runtime') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_allocation_sizes.py'),
                          '--compiler', str(compiler)], 'allocation size checks') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_reread_runtime.py'),
                          '--compiler', str(compiler)], 'command replay') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_open_runtime.py'),
                          '--compiler', str(compiler)], 'historical open modes') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_read_runtime.py'),
                          '--compiler', str(compiler)], 'read buffer preservation') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_number_formatting.py'),
                          '--compiler', str(compiler)], 'number formatting') and ok
        ok = checked_run([sys.executable, str(root / 'tests/test_global_storage.py'),
                          '--compiler', str(compiler)], 'global storage') and ok
    print('All host suites passed.' if ok else 'Host suite failed.')
    return 0 if ok else 1


if __name__ == '__main__':
    raise SystemExit(main())
