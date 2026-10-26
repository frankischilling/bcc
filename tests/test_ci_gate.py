#!/usr/bin/env python3
"""The CI gates must not accept failed, cancelled, skipped or absent lanes."""
import itertools
from pathlib import Path
import subprocess
import unittest

GATE = Path(__file__).resolve().parents[1] / '.github/scripts/require-success.sh'


class Gate(unittest.TestCase):
    def run_gate(self, values, count=3):
        return subprocess.run(['sh', str(GATE), str(count), *values], capture_output=True, text=True, timeout=5)

    def test_all_lane_states(self):
        for count in (2, 3):
            for values in itertools.product(('success', 'failure', 'cancelled', 'skipped'), repeat=count):
                with self.subTest(count=count, values=values):
                    result = self.run_gate(values, count)
                    self.assertEqual(result.returncode, 0 if values == ('success',) * count else 1)

    def test_missing_or_extra_lanes(self):
        for expected in (2, 3):
            for count in (0, 1, 2, 3, 4):
                if count != expected:
                    with self.subTest(expected=expected, count=count):
                        self.assertEqual(self.run_gate(['success'] * count, expected).returncode, 2)

    def test_unknown_states(self):
        for count in (2, 3):
            for value in ('', 'pending', 'SUCCESS', '--pair', '3'):
                with self.subTest(count=count, value=value):
                    self.assertEqual(self.run_gate([value] + ['success'] * (count - 1), count).returncode, 1)

    def test_unix_v1_gate_covers_all_lanes(self):
        workflow = (GATE.parents[1] / 'workflows/conformance.yml').read_text()
        gate = workflow.split('  unix-v1:\n', 1)[1].split('\n  b-passes-v1:', 1)[0]
        self.assertIn('needs: [unix_v1_seed, unix_v1_runtime, unix_v1_bootstrap]', gate)
        self.assertIn('if: ${{ always() }}', gate)
        for variable, lane in (('SEED', 'seed'), ('RUNTIME', 'runtime'), ('RESOLVER', 'bootstrap')):
            self.assertIn(variable + '_RESULT: ${{ needs.unix_v1_' + lane + '.result }}', gate)
        self.assertIn('require-success.sh 3 "$SEED_RESULT" "$RUNTIME_RESULT" "$RESOLVER_RESULT"', gate)

    def test_invalid_lane_count(self):
        for count in ('', '0', '1', '4', '-1', 'two', '--pair'):
            with self.subTest(count=count):
                self.assertEqual(self.run_gate(['success'] * 3, count).returncode, 2)
        self.assertEqual(subprocess.run(['sh', str(GATE)], capture_output=True, timeout=5).returncode, 2)

    def test_workflow_supplies_explicit_counts(self):
        workflow = (GATE.parents[1] / 'workflows/conformance.yml').read_text()
        self.assertIn('require-success.sh 3 "$HOST_RESULT" "$BOOTSTRAP_RESULT" "$ASSEMBLY_RESULT"', workflow)
        self.assertIn('require-success.sh 2 "$COMPILER_RESULT" "$GENERATED_RESULT"', workflow)


if __name__ == '__main__':
    unittest.main()
