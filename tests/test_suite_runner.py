#!/usr/bin/env python3
"""Regression tests for the test runner itself."""
import contextlib
import io
import os
from pathlib import Path
import shutil
import tempfile
import subprocess
import unittest
from unittest.mock import patch
from run_suite import checked_run


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
