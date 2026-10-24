"""Wrap V1 code for apout's V2-compatible syscall observer.

The pinned emulator's 0405 mode discards exit status and fails to return
fork/wait PIDs. Its 0407/V2 mode observes those results. The inner 0405
header still branches to the same 040014 entry. A skipped header word
is tagged with the emulator's V2 marker to avoid checksum/size collisions;
B instructions, data, and their addresses do not change. Real V1 behavior is checked separately in SIMH.
"""
import struct


def test_image(native):
    if len(native) < 12:
        raise ValueError('short V1 executable')
    magic, size, _, _, _, _ = struct.unpack_from('<6H', native)
    if magic != 0o405 or not 12 <= size <= min(len(native), 16384):
        raise ValueError('invalid V1 executable')
    payload = bytearray(native[:size])
    struct.pack_into('<H', payload, 2, 0o177304)
    return struct.pack('<8H', 0o407, size, 0, 0, 0, 0, 0, 1) + payload
