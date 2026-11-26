"""Read regular files from the pinned V1 disk layout for independent build checks."""
import struct

BLOCK = 512


class FileSystem:
    def __init__(self, image):
        self.image = image
        if len(image) < 2 * BLOCK or len(image) % BLOCK:
            raise ValueError('truncated V1 filesystem')
        map_bytes = struct.unpack_from('<H', image)[0]
        if not map_bytes or 4 + map_bytes > 2 * BLOCK:
            raise ValueError('invalid V1 free map')
        self.blocks = map_bytes * 8
        if self.blocks * BLOCK > len(image):
            raise ValueError('truncated V1 block area')
        self.inodes = struct.unpack_from('<H', image, 2 + map_bytes)[0] * 8
        self.data_start = (2 * BLOCK + (self.inodes - 1) * 32 + BLOCK - 1) // BLOCK
        if self.inodes <= 41 or self.data_start >= self.blocks:
            raise ValueError('invalid V1 inode area')

    def block(self, number):
        if not self.data_start <= number < self.blocks:
            raise ValueError(f'invalid V1 data block {number}')
        return self.image[number * BLOCK:(number + 1) * BLOCK]

    def inode(self, number):
        if not 41 <= number < self.inodes:
            raise ValueError(f'invalid V1 file inode {number}')
        offset = 2 * BLOCK + (number - 1) * 32
        flags, _, size = struct.unpack_from('<HHH', self.image, offset)
        if not flags & 0o100000:
            raise ValueError(f'unallocated V1 inode {number}')
        pointers = struct.unpack_from('<8H', self.image, offset + 6)
        count = (size + BLOCK - 1) // BLOCK
        if not flags & 0o10000 and count > len(pointers):
            raise ValueError('small V1 file exceeds direct block capacity')
        result = bytearray()
        for logical in range(count):
            if flags & 0o10000:
                indirect = pointers[logical // 256]
                block = (struct.unpack_from('<H', self.block(indirect),
                                            (logical % 256) * 2)[0] if indirect else 0)
            else:
                block = pointers[logical]
            result.extend(self.block(block) if block else bytes(BLOCK))
        return flags, bytes(result[:size])

    def read(self, path):
        parts = path.strip('/').split('/')
        if any(not part or part in ('.', '..') or len(part.encode('ascii')) > 8 for part in parts):
            raise ValueError(f'invalid V1 file path {path!r}')
        inode = 41
        for part in parts:
            flags, entries = self.inode(inode)
            if not flags & 0o40000:
                raise ValueError(f'not a V1 directory while resolving {path!r}')
            if len(entries) % 10:
                raise ValueError('truncated V1 directory entry')
            matches = []
            for offset in range(0, len(entries), 10):
                number = struct.unpack_from('<H', entries, offset)[0]
                name = entries[offset + 2:offset + 10].split(b'\0', 1)[0]
                if number and name == part.encode('ascii'):
                    matches.append(number)
            if len(matches) != 1:
                raise ValueError(f'missing or duplicate V1 path {path!r}')
            inode = matches[0]
        flags, data = self.inode(inode)
        if flags & 0o40000:
            raise ValueError(f'expected regular V1 file {path!r}')
        return data


def verify_files(image, expected):
    filesystem = FileSystem(image)
    for path, reference in expected.items():
        actual = filesystem.read(path)
        if actual != reference:
            raise ValueError(f'rebuilt {path} differs: {len(actual)} bytes, expected {len(reference)}')
