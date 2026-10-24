#!/usr/bin/env python3
"""Regression tests for the test runner itself."""
import contextlib
import io
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


if __name__ == '__main__':
    unittest.main()
