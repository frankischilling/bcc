#!/usr/bin/env python3
"""Check completion framing independently of the simulator and console transport."""
from pathlib import Path
import importlib.util
import unittest

path = Path(__file__).resolve().parents[1] / 'tools/console_protocol.py'
spec = importlib.util.spec_from_file_location('guest_console_protocol', path)
protocol = importlib.util.module_from_spec(spec)
spec.loader.exec_module(protocol)


class ConsoleProtocol(unittest.TestCase):
    marker = 'bccdone_0123456789abcdef'

    def frame(self, output, echo=True, crlf=False):
        line = protocol.command_line('./a.out one', self.marker)
        text = (line + '\n' if echo else '') + output + '\n' + self.marker + '\n# '
        if crlf:
            text = text.replace('\n', '\r\n')
        return line, text.encode('latin-1')

    def test_round_trip(self):
        for output in ('', 'OK\n', 'no newline', '# ', '# OK\n', '\n\n', 'A\0B'):
            for echo in (True, False):
                for crlf in (True, False):
                    with self.subTest(output=output, echo=echo, crlf=crlf):
                        line, raw = self.frame(output, echo, crlf)
                        self.assertTrue(protocol.completion_pattern(self.marker).search(raw))
                        self.assertEqual(protocol.program_output(raw, line, self.marker), output)

    def test_historical_echo_trailing_space(self):
        line, raw = self.frame('OK\n')
        raw = raw.replace(self.marker.encode() + b'\n# ', self.marker.encode() + b' \n# ')
        self.assertTrue(protocol.completion_pattern(self.marker).search(raw))
        self.assertEqual(protocol.program_output(raw, line, self.marker), 'OK\n')

    def test_plain_prompt_is_not_completion(self):
        self.assertIsNone(protocol.completion_pattern(self.marker).search(b'./a.out\r\n# '))

    def test_command_echo_is_not_completion(self):
        line = protocol.command_line('./a.out', self.marker)
        self.assertIsNone(protocol.completion_pattern(self.marker).search(line.encode() + b'\r\n# '))

    def test_marker_without_prompt_is_not_completion(self):
        self.assertIsNone(protocol.completion_pattern(self.marker).search(b'\n' + self.marker.encode() + b'\n'))

    def test_partial_frames(self):
        line, raw = self.frame('OK\n')
        for end in range(len(raw)):
            self.assertIsNone(protocol.completion_pattern(self.marker).search(raw[:end]))
            with self.assertRaises(ValueError):
                protocol.program_output(raw[:end], line, self.marker)

    def test_wrong_marker(self):
        line, raw = self.frame('OK\n')
        with self.assertRaises(ValueError):
            protocol.program_output(raw, line, 'different')

    def test_reject_marker_metacharacters(self):
        for marker in ('', 'a;b', 'a b', 'a\nb', '$x', "'x'"):
            with self.assertRaises(ValueError):
                protocol.command_line('./a.out', marker)


if __name__ == '__main__':
    unittest.main()
