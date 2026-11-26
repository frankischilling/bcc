#!/usr/bin/env python3
"""Run each host suite and reject missing, crashed, or empty test runs."""
import argparse
from concurrent.futures import ThreadPoolExecutor
import os
import threading
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile

ANSI = re.compile(r'\x1b\[[0-9;]*m')
SUMMARY = re.compile(r'Results:\s*(\d+) passed,\s*(\d+) failed(?:,\s*(\d+) skipped)?')


OUTPUT_LOCK = threading.Lock()

def checked_run(command, label):
    try:
        result = subprocess.run(command, capture_output=True, text=True,
                                errors='replace', timeout=600)
    except (OSError, subprocess.TimeoutExpired) as error:
        with OUTPUT_LOCK:
            print(f'FAIL: {label}: {error}', flush=True)
        return False
    with OUTPUT_LOCK:
        print(f'=== {label} ===', flush=True)
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


def run_suites(suites, jobs):
    if jobs < 1:
        raise ValueError('jobs must be positive')
    if not suites:
        return False
    def run(suite):
        command, label = suite
        try:
            return checked_run(command, label)
        except Exception as error:
            with OUTPUT_LOCK:
                print(f'FAIL: {label}: runner error: {error}', flush=True)
            return False
    with ThreadPoolExecutor(max_workers=jobs) as workers:
        # Consume every result, even after a failure, so coverage is unchanged.
        results = list(workers.map(run, suites))
    return all(results)


def main():
    root = Path(__file__).resolve().parent.parent
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=root / 'bcc')
    parser.add_argument('--jobs', type=int, default=os.environ.get('BCC_TEST_JOBS', '1'),
                        help='independent suites to run at once (default: BCC_TEST_JOBS or 1)')
    parser.add_argument('-q', '--quick', action='store_true')
    parser.add_argument('-v', '--verbose', action='store_true')
    args = parser.parse_args()
    if args.jobs < 1:
        parser.error('--jobs must be positive')
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
        commands = []
        def enqueue(command, label):
            commands.append((command, label))

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
            enqueue(command, name)
        enqueue([sys.executable, str(root / 'tests/test_b72_conformance.py'),
                          '--bcc', str(compiler)], 'B72 conformance')
        enqueue([sys.executable, str(root / 'tests/test_label_token_limits.py')],
                         'label token limits')
        enqueue([sys.executable, str(root / 'tests/test_intr_runtime.py'),
                          '--compiler', str(compiler)], 'interrupt modes')
        enqueue([sys.executable, str(root / 'tests/test_runtime_cache.py'),
                          '--compiler', str(compiler)], 'private runtime cache')
        enqueue([sys.executable, str(root / 'tests/test_output_errors.py'),
                          '--compiler', str(compiler)], 'output errors')
        enqueue([sys.executable, str(root / 'tests/test_object_output.py'),
                          '--compiler', str(compiler)], 'object output')
        enqueue([sys.executable, str(root / 'tests/test_assembly_output.py'),
                          '--compiler', str(compiler)], 'assembly output')
        enqueue([sys.executable, str(root / 'tests/test_command_arguments.py'),
                          '--compiler', str(compiler)], 'command arguments')
        enqueue([sys.executable, str(root / 'tests/test_exec_runtime.py'),
                          '--compiler', str(compiler)], 'exec runtime')
        enqueue([sys.executable, str(root / 'tests/test_tty_runtime.py'),
                          '--compiler', str(compiler)], 'terminal buffer safety')
        enqueue([sys.executable, str(root / 'tests/test_time_runtime.py'),
                          '--compiler', str(compiler)], 'time runtime')
        enqueue([sys.executable, str(root / 'tests/test_library_bindings.py'),
                          '--compiler', str(compiler)], 'library binding callbacks')
        enqueue([sys.executable, str(root / 'tests/test_library_names.py'),
                          '--compiler', str(compiler)], 'library names')
        enqueue([sys.executable, str(root / 'tests/test_putchar_runtime.py'),
                          '--compiler', str(compiler)], 'packed character output')
        enqueue([sys.executable, str(root / 'tests/test_vector_extent.py'),
                          '--compiler', str(compiler)], 'vector extents')
        enqueue([sys.executable, str(root / 'tests/test_char_storage.py'),
                          '--compiler', str(compiler)], 'packed byte storage')
        enqueue([sys.executable, str(root / 'tests/test_seek_runtime.py'),
                          '--compiler', str(compiler)], 'file offsets')
        enqueue([sys.executable, str(root / 'tests/test_argv_runtime.py'),
                          '--compiler', str(compiler)], 'argument vector')
        enqueue([sys.executable, str(root / 'tests/test_unix_metadata.py'),
                          '--compiler', str(compiler)], 'Unix metadata')
        enqueue([sys.executable, str(root / 'tests/test_switch_runtime.py'),
                          '--compiler', str(compiler)], 'switch control flow')
        enqueue([sys.executable, str(root / 'tests/test_case_constants.py'),
                          '--compiler', str(compiler)], 'switch constant folding')
        enqueue([sys.executable, str(root / 'tests/test_external_scope.py'),
                          '--compiler', str(compiler)], 'external declaration scope')
        enqueue([sys.executable, str(root / 'tests/test_declarations.py'),
                          '--compiler', str(compiler)], 'declaration statements')
        enqueue([sys.executable, str(root / 'tests/test_docs_examples.py'),
                          '--compiler', str(compiler)], 'documentation examples')
        enqueue([sys.executable, str(root / 'tests/test_identifier_bytes.py'),
                          '--compiler', str(compiler)], 'B identifier bytes')
        enqueue([sys.executable, str(root / 'tests/test_word_arithmetic.py'),
                          '--compiler', str(compiler)], 'word arithmetic')
        enqueue([sys.executable, str(root / 'tests/test_call_frames.py'),
                          '--compiler', str(compiler)], 'B call frames')
        enqueue([sys.executable, str(root / 'tests/test_parameter_layout.py'),
                          '--compiler', str(compiler)], 'parameter storage')
        enqueue([sys.executable, str(root / 'tests/test_function_cells.py'),
                          '--compiler', str(compiler)], 'source function cells')
        enqueue([sys.executable, str(root / 'tests/test_label_cells.py'),
                          '--compiler', str(compiler)], 'internal label cells')
        enqueue([sys.executable, str(root / 'tests/test_mkdir_runtime.py'),
                          '--compiler', str(compiler)], 'mkdir runtime')
        enqueue([sys.executable, str(root / 'tests/test_allocation_sizes.py'),
                          '--compiler', str(compiler)], 'allocation size checks')
        enqueue([sys.executable, str(root / 'tests/test_reread_runtime.py'),
                          '--compiler', str(compiler)], 'command replay')
        enqueue([sys.executable, str(root / 'tests/test_open_runtime.py'),
                          '--compiler', str(compiler)], 'historical open modes')
        enqueue([sys.executable, str(root / 'tests/test_read_runtime.py'),
                          '--compiler', str(compiler)], 'read buffer preservation')
        enqueue([sys.executable, str(root / 'tests/test_number_formatting.py'),
                          '--compiler', str(compiler)], 'number formatting')
        enqueue([sys.executable, str(root / 'tests/test_global_storage.py'),
                          '--compiler', str(compiler)], 'global storage')
        ok = run_suites(commands, args.jobs) and ok
    print('All host suites passed.' if ok else 'Host suite failed.')
    return 0 if ok else 1


if __name__ == '__main__':
    raise SystemExit(main())
