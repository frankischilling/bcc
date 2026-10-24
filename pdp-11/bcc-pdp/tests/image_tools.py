#!/usr/bin/env python3
"""Regression checks for safe V1 images and offset-preserving tool overlays."""
from pathlib import Path
import struct
import sys
import unittest
sys.path.insert(0, str(Path(__file__).resolve().parents[1]/'tools'))
from v1_image import inspect, DATA_LIMIT, RF_BLOCKS, BLOCK
from prepare_v1_tools import relocate
from apout_image import test_image


class ImageSafety(unittest.TestCase):
    def image(self, reserved=True):
        data = bytearray(RF_BLOCKS*BLOCK)
        struct.pack_into('<H', data, 0, 128)
        data[2:130] = b'\xff'*128
        struct.pack_into('<H', data, 130, 32)
        if reserved:
            for block in range(DATA_LIMIT, RF_BLOCKS):
                data[2+block//8] &= ~(1 << (block%8))
        return data

    def test_reserved(self):
        self.assertEqual(inspect(self.image()), DATA_LIMIT)

    def test_free_swap_rejected(self):
        with self.assertRaisesRegex(ValueError, 'incorrectly marked free'):
            inspect(self.image(False))

    def test_reserved_file_rejected(self):
        data = self.image()
        offset = 2*BLOCK+42*32
        struct.pack_into('<HHHH', data, offset, 0o100000, 1, 512, DATA_LIMIT)
        with self.assertRaisesRegex(ValueError, 'uses reserved block'):
            inspect(data)

    def test_reserved_indirect_rejected(self):
        data = self.image()
        offset = 2*BLOCK+42*32
        struct.pack_into('<HHHH', data, offset, 0o110000, 1, 512, 100)
        struct.pack_into('<H', data, 100*BLOCK, DATA_LIMIT)
        with self.assertRaisesRegex(ValueError, 'uses reserved block'):
            inspect(data)

    def test_truncated_rejected(self):
        with self.assertRaisesRegex(ValueError, 'truncated'):
            inspect(self.image()[:BLOCK])

    def test_tool_offsets(self):
        original = b'code\xff/tmp/atm1a\0tail'
        result = relocate(original, [b'/tmp/atm1a\0'])
        self.assertEqual(result, b'code\xff/usr/atm1a\0tail')
        self.assertEqual(len(result), len(original))

    def test_missing_template_rejected(self):
        with self.assertRaises(ValueError):
            relocate(b'other', [b'/tmp/atm1a\0'])

    def test_duplicate_template_rejected(self):
        with self.assertRaises(ValueError):
            relocate(b'/tmp/atm1a\0'*2, [b'/tmp/atm1a\0'])

    def test_observer_preserves_native_text(self):
        native = struct.pack('<6H', 0o405, 16, 0, 0, 0, 0) + b'code' + b'symbols'
        wrapped = test_image(native)
        self.assertEqual(struct.unpack_from('<8H', wrapped), (0o407, 16, 0, 0, 0, 0, 0, 1))
        self.assertEqual(wrapped[16:18], native[:2])
        self.assertEqual(struct.unpack_from('<H', wrapped, 18)[0], 0o177304)
        self.assertEqual(wrapped[20:], native[4:16])

    def test_observer_rejects_bad_header(self):
        with self.assertRaises(ValueError):
            test_image(bytes(16))

    def test_observer_rejects_short_text(self):
        with self.assertRaises(ValueError):
            test_image(struct.pack('<6H', 0o405, 40, 0, 0, 0, 0))


if __name__ == '__main__':
    unittest.main()
