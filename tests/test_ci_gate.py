#!/usr/bin/env python3
"""The host CI gates must not accept failed, cancelled, skipped or absent lanes."""
import itertools
from pathlib import Path
import subprocess
import unittest

GATE = Path(__file__).resolve().parents[1] / '.github/scripts/require-success.sh'


class Gate(unittest.TestCase):
    def run_gate(self, values):
        return subprocess.run(['sh', str(GATE), *values], capture_output=True, text=True, timeout=5)

    def test_all_lane_states(self):
        for values in itertools.product(('success', 'failure', 'cancelled', 'skipped'), repeat=3):
            with self.subTest(values=values):
                result = self.run_gate(values)
                self.assertEqual(result.returncode, 0 if values == ('success',) * 3 else 1)

    def test_missing_or_extra_lanes(self):
        for count in (0, 1, 2, 4):
            with self.subTest(count=count):
                self.assertEqual(self.run_gate(['success'] * count).returncode, 2)

    def test_unknown_states(self):
        for value in ('', 'pending', 'SUCCESS'):
            with self.subTest(value=value):
                self.assertEqual(self.run_gate(['success', value, 'success']).returncode, 1)


if __name__ == '__main__':
    unittest.main()
