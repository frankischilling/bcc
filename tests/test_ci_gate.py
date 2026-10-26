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

    def test_bootstrap_gate_covers_all_lanes(self):
        workflow = (GATE.parents[1] / 'workflows/conformance.yml').read_text()
        gate = workflow.split('  b_bootstrap:\n', 1)[1].split('\n  assembly:', 1)[0]
        self.assertIn('needs: [b_bootstrap_checks, b_native, b_native_rebuild]', gate)
        self.assertIn('if: ${{ always() }}', gate)
        self.assertIn('BOOTSTRAP_RESULT: ${{ needs.b_bootstrap_checks.result }}', gate)
        self.assertIn('NATIVE_RESULT: ${{ needs.b_native.result }}', gate)
        self.assertIn('REBUILD_RESULT: ${{ needs.b_native_rebuild.result }}', gate)
        self.assertIn('require-success.sh 3 "$BOOTSTRAP_RESULT" "$NATIVE_RESULT" "$REBUILD_RESULT"', gate)

    def test_native_matrix_preserves_every_seed(self):
        workflow = (GATE.parents[1] / 'workflows/conformance.yml').read_text()
        lane = workflow.split('  b_native:\n', 1)[1].split('  b_native_rebuild:\n', 1)[0]
        self.assertIn('cc: [gcc, clang]', lane)
        self.assertIn('stage: [host, 1, 2, 3]', lane)
        self.assertIn('NATIVE_COMPILER=../bcc', lane)
        self.assertIn('NATIVE_COMPILER=build/stage${{ matrix.stage }}/bbc NATIVE_FLAGS=--bootstrap', lane)
        self.assertIn('test_elfimage.py --close-faults', lane)
        self.assertIn('test_x64.py --close-faults', lane)
        makefile = (GATE.parents[2] / 'bootstrap/Makefile').read_text()
        tests = makefile.split('NATIVE_TESTS :=', 1)[1].split('native-stage-test:', 1)[0]
        expected = ('elfimage', 'x64', 'labels', 'ops', 'calls', 'data', 'resolver',
                    'runtime', 'argv', 'control', 'memory', 'scalar', 'arity', 'frontend')
        for name in expected:
            self.assertEqual(tests.count('native/test_' + name + '.py'), 1)
        self.assertIn('../pdp-11/bcc-pdp/bootstrap/test_source_reader.py', tests)

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

    def test_only_result_gates_use_lightweight_runners(self):
        import re
        workflow = (GATE.parents[1] / 'workflows/conformance.yml').read_text()
        jobs = re.split(r'^  ([A-Za-z0-9_-]+):\n', workflow, flags=re.MULTILINE)
        slim = []
        for index in range(1, len(jobs), 2):
            name, body = jobs[index:index + 2]
            if 'runs-on: ubuntu-slim' in body:
                slim.append(name)
                self.assertIn('timeout-minutes: 5', body)
                self.assertIn('require-success.sh', body)
                self.assertNotIn('run: make', body)
        self.assertEqual(set(slim), {'b_bootstrap', 'host', 'sanitizers', 'unix-v1'})

    def test_workflow_supplies_explicit_counts(self):
        workflow = (GATE.parents[1] / 'workflows/conformance.yml').read_text()
        self.assertIn('require-success.sh 3 "$HOST_RESULT" "$BOOTSTRAP_RESULT" "$ASSEMBLY_RESULT"', workflow)
        self.assertIn('require-success.sh 2 "$COMPILER_RESULT" "$GENERATED_RESULT"', workflow)


if __name__ == '__main__':
    unittest.main()
