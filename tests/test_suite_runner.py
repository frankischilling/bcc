#!/usr/bin/env python3
"""Regression tests for the test runner itself."""
import contextlib
import io
import os
from pathlib import Path
import shutil
import tempfile
import subprocess
import sys
import unittest
import threading
from unittest.mock import patch
from run_suite import checked_run, run_suites


class SuiteResults(unittest.TestCase):
    def check(self, output, status=0):
        result = subprocess.CompletedProcess(['fixture'], status, output, '')
        with patch('run_suite.subprocess.run', return_value=result), contextlib.redirect_stdout(io.StringIO()):
            return checked_run(['fixture'], 'fixture')

    def test_good(self):
        self.assertTrue(self.check('Results: 3 passed, 0 failed\n'))

    def test_missing_summary(self):
        self.assertFalse(self.check('ALL TESTS PASSED\n'))

    def test_empty(self):
        self.assertFalse(self.check('Results: 0 passed, 0 failed\n'))

    def test_crashed_after_summary(self):
        self.assertFalse(self.check('Results: 3 passed, 0 failed\n', 1))

    def test_reported_failure(self):
        self.assertFalse(self.check('Results: 3 passed, 1 failed\n'))

    def test_last_summary(self):
        self.assertFalse(self.check('Results: 3 passed, 0 failed\nResults: 0 passed, 2 failed\n'))


class ParallelSuites(unittest.TestCase):
    def test_all_suites_run_after_failure(self):
        seen = []
        lock = threading.Lock()
        def run(command, label):
            with lock:
                seen.append(label)
            if label == 'crash':
                raise RuntimeError('fixture')
            return label != 'failed'
        suites = [(['fixture'], name) for name in ('failed', 'crash', 'passed', 'last')]
        with patch('run_suite.checked_run', side_effect=run), contextlib.redirect_stdout(io.StringIO()):
            self.assertFalse(run_suites(suites, 2))
        self.assertCountEqual(seen, [name for _, name in suites])

    def test_concurrency_is_bounded(self):
        lock = threading.Lock()
        barrier = threading.Barrier(2, timeout=5)
        active = peak = 0
        def run(command, label):
            nonlocal active, peak
            with lock:
                active += 1
                peak = max(peak, active)
            barrier.wait()
            with lock:
                active -= 1
            return True
        with patch('run_suite.checked_run', side_effect=run):
            self.assertTrue(run_suites([(['fixture'], str(i)) for i in range(4)], 2))
        self.assertEqual(peak, 2)
        self.assertEqual(active, 0)

    def test_sequential_order(self):
        seen = []
        def run(command, label):
            seen.append(label)
            return True
        with patch('run_suite.checked_run', side_effect=run):
            self.assertTrue(run_suites([([], str(i)) for i in range(4)], 1))
        self.assertEqual(seen, ['0', '1', '2', '3'])

    def test_real_subprocess_results(self):
        with tempfile.TemporaryDirectory(prefix='bcc-runner-workers-') as directory:
            marker = Path(directory) / 'last'
            suites = [
                ([sys.executable, '-c', "print('Results: 2 passed, 0 failed')"], 'good'),
                ([sys.executable, '-c', "print('Results: 0 passed, 1 failed')"], 'bad'),
                ([sys.executable, '-c', 'from pathlib import Path; '
                  + f'Path({str(marker)!r}).write_text("ran"); '
                  + "print('Results: 1 passed, 0 failed')"], 'last'),
            ]
            with contextlib.redirect_stdout(io.StringIO()):
                self.assertFalse(run_suites(suites, 2))
            self.assertEqual(marker.read_text(), 'ran')

    def test_invalid_jobs_and_empty_batch(self):
        for jobs in (0, -1):
            with self.assertRaises(ValueError):
                run_suites([([], 'fixture')], jobs)
        self.assertFalse(run_suites([], 1))


class ShellIsolation(unittest.TestCase):
    def test_cleanup_preserves_neighbor(self):
        fd, filename = tempfile.mkstemp(prefix='word_test_neighbor_')
        os.close(fd)
        neighbor = Path(filename)
        try:
            with tempfile.TemporaryDirectory(prefix='bcc-runner-test-') as directory:
                root = Path(directory)
                (root/'tests').mkdir()
                temporary = root/'temporary files'; temporary.mkdir()
                source = Path(__file__).resolve().parent/'test_word_semantics.sh'
                script = root/'tests'/source.name
                shutil.copyfile(source, script)
                compiler = root/'bcc'
                compiler.write_text('#!/bin/sh\nexit 1\n')
                compiler.chmod(0o755)
                result = subprocess.run(['bash', str(script)], env={**os.environ, 'TMPDIR': str(temporary)}, capture_output=True, timeout=30)
                self.assertEqual(result.returncode, 1)
                self.assertTrue(neighbor.exists())
                self.assertEqual(list(temporary.iterdir()), [])
        finally:
            neighbor.unlink(missing_ok=True)


if __name__ == '__main__':
    unittest.main()
