#!/usr/bin/env python3
"""Check byte-exact V1 bootstrap verification, including odd file lengths."""
from pathlib import Path
import struct
import sys
import unittest
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'tools'))
from v1_files import FileSystem, verify_files, BLOCK


class FileVerification(unittest.TestCase):
    def image(self, payload=b'abc', large=False):
        image = bytearray(64 * BLOCK)
        struct.pack_into('<H', image, 0, 8)
        struct.pack_into('<H', image, 10, 8)
        self.node(image, 41, 0o140000, 10, 8)
        struct.pack_into('<H8s', image, 8 * BLOCK, 42, b'file')
        self.node(image, 42, 0o110000 if large else 0o100000, len(payload), 9)
        if large:
            struct.pack_into('<H', image, 9 * BLOCK, 10)
        start = (10 if large else 9) * BLOCK
        image[start:start + len(payload)] = payload
        return image

    @staticmethod
    def node(image, number, flags, size, block):
        struct.pack_into('<HHHH', image, 2 * BLOCK + (number - 1) * 32,
                         flags, 1, size, block)

    def test_odd_bytes(self):
        verify_files(self.image(), {'file': b'abc'})

    def test_odd_last_byte(self):
        with self.assertRaisesRegex(ValueError, 'differs'):
            verify_files(self.image(b'abX'), {'file': b'abc'})

    def test_extra_nul(self):
        with self.assertRaisesRegex(ValueError, '4 bytes, expected 3'):
            verify_files(self.image(b'abc\0'), {'file': b'abc'})

    def test_missing_byte(self):
        with self.assertRaisesRegex(ValueError, '2 bytes, expected 3'):
            verify_files(self.image(b'ab'), {'file': b'abc'})

    def test_empty(self):
        verify_files(self.image(b''), {'file': b''})

    def test_indirect(self):
        verify_files(self.image(b'odd\0\xff', large=True), {'file': b'odd\0\xff'})

    def test_multiblock_and_tail(self):
        for large, size in ((False, 1025), (True, 4609)):
            payload = bytes(i % 251 for i in range(size))
            image = self.image(payload, large=large)
            for i in range((size + BLOCK - 1) // BLOCK):
                offset = 9 * BLOCK + i * 2 if large else 2 * BLOCK + 41 * 32 + 6 + i * 2
                struct.pack_into('<H', image, offset, (10 if large else 9) + i)
            verify_files(image, {'file': payload})

    def test_sparse(self):
        image = self.image()
        self.node(image, 42, 0o100000, 3, 0)
        verify_files(image, {'file': bytes(3)})
        self.node(image, 42, 0o110000, 3, 0)
        verify_files(image, {'file': bytes(3)})

    def test_nested(self):
        image = self.image()
        self.node(image, 42, 0o140000, 10, 9)
        struct.pack_into('<H8s', image, 9 * BLOCK, 43, b'leaf')
        self.node(image, 43, 0o100000, 3, 10)
        image[10 * BLOCK:10 * BLOCK + 3] = b'yes'
        verify_files(image, {'file/leaf': b'yes'})

    def test_missing(self):
        with self.assertRaisesRegex(ValueError, 'missing'):
            FileSystem(self.image()).read('absent')

    def test_duplicate(self):
        image = self.image()
        self.node(image, 41, 0o140000, 20, 8)
        image[8 * BLOCK + 10:8 * BLOCK + 20] = image[8 * BLOCK:8 * BLOCK + 10]
        with self.assertRaisesRegex(ValueError, 'duplicate'):
            FileSystem(image).read('file')

    def test_truncated_directory(self):
        image = self.image()
        self.node(image, 41, 0o140000, 9, 8)
        with self.assertRaisesRegex(ValueError, 'directory entry'):
            FileSystem(image).read('file')

    def test_bad_file_blocks(self):
        for block in (1, 64):
            for flags in (0o100000, 0o110000):
                image = self.image()
                self.node(image, 42, flags, 3, block)
                with self.assertRaisesRegex(ValueError, 'data block'):
                    FileSystem(image).read('file')

    def test_bad_indirect_leaf(self):
        image = self.image(large=True)
        struct.pack_into('<H', image, 9 * BLOCK, 64)
        with self.assertRaisesRegex(ValueError, 'data block'):
            FileSystem(image).read('file')

    def test_unallocated(self):
        image = self.image()
        self.node(image, 42, 0, 3, 9)
        with self.assertRaisesRegex(ValueError, 'unallocated'):
            FileSystem(image).read('file')

    def test_small_capacity(self):
        image = self.image()
        self.node(image, 42, 0o100000, 4097, 9)
        with self.assertRaisesRegex(ValueError, 'capacity'):
            FileSystem(image).read('file')

    def test_bad_paths(self):
        for path in ('', '/', '../file', 'file/..', '123456789', 'file//leaf'):
            with self.assertRaises(ValueError):
                FileSystem(self.image()).read(path)

    def test_truncated_image(self):
        for size in (0, 513, 2 * BLOCK, 63 * BLOCK):
            with self.assertRaises(ValueError):
                FileSystem(self.image()[:size])

    def test_file_is_not_directory(self):
        with self.assertRaisesRegex(ValueError, 'not a V1 directory'):
            FileSystem(self.image()).read('file/leaf')


if __name__ == '__main__':
    unittest.main()
