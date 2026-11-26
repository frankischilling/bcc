#!/usr/bin/env python3
"""Check the pinned V1 RF image and reserve its swap/kernel blocks."""
import argparse
from pathlib import Path
import struct

BLOCK = 512
RF_BLOCKS = 1024
# The pinned kernel reserves 33 blocks per process and 64 for boot/kernel.
DATA_LIMIT = RF_BLOCKS - 16 * 33 - 64


def inspect(data, require_reserved=True):
    minimum = RF_BLOCKS if require_reserved else 996
    if len(data) < minimum * BLOCK:
        raise ValueError('truncated RF image')
    map_bytes = struct.unpack_from('<H', data)[0]
    if map_bytes != RF_BLOCKS // 8:
        raise ValueError('unexpected RF free-map size')
    inode_map_bytes = struct.unpack_from('<H', data, 2 + map_bytes)[0]
    count = inode_map_bytes * 8
    if not 42 < count <= 512:
        raise ValueError('unexpected RF inode count')

    def check_block(block, inode):
        if block >= DATA_LIMIT:
            raise ValueError(f'inode {inode} uses reserved block {block}; move files off the root disk before rebuilding')

    for inode in range(1, count):
        offset = 2 * BLOCK + (inode - 1) * 32
        flags, _, size = struct.unpack_from('<HHH', data, offset)
        if not flags & 0o100000 or size == 0:
            continue
        pointers = struct.unpack_from('<8H', data, offset + 6)
        remaining = (size + BLOCK - 1) // BLOCK
        for block in pointers:
            if not remaining: break
            if not block: continue
            check_block(block, inode)
            if flags & 0o10000:
                for entry in struct.unpack_from('<256H', data, block * BLOCK):
                    if not remaining: break
                    if entry: check_block(entry, inode)
                    remaining -= 1
            else:
                remaining -= 1
    free_reserved = [block for block in range(DATA_LIMIT, RF_BLOCKS)
                     if data[2 + block // 8] & (1 << (block % 8))]
    if require_reserved and free_reserved:
        raise ValueError(f'{len(free_reserved)} swap/kernel blocks are incorrectly marked free; run tools/rebuild_v1.sh')
    return sum(bool(data[2 + block // 8] & (1 << (block % 8))) for block in range(DATA_LIMIT))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('image', type=Path)
    parser.add_argument('--reserve', action='store_true')
    args = parser.parse_args()
    data = bytearray(args.image.read_bytes())
    try:
        inspect(data, require_reserved=not args.reserve)
        if args.reserve:
            data.extend(bytes(max(0, RF_BLOCKS * BLOCK - len(data))))
            for block in range(DATA_LIMIT, RF_BLOCKS):
                data[2 + block // 8] &= ~(1 << (block % 8))
            inspect(data)
            args.image.write_bytes(data)
        print(f'RF image: swap/kernel blocks reserved; {inspect(data)} data blocks free')
    except ValueError as error:
        parser.error(str(error))


if __name__ == '__main__':
    main()
