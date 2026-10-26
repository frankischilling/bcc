#!/usr/bin/env python3
"""Check historical C compiler diagnostics and its fresh output image."""
import argparse
import os
import re
from pathlib import Path
import struct
import subprocess
import sys


def validate_progress(output, sources):
    if not sources or any(not re.fullmatch(r'[A-Za-z0-9_][A-Za-z0-9_-]{0,5}\.c', name) for name in sources):
        raise ValueError('native C source names must be simple filenames with at most six stem characters')
    expected = ''.join((name + ':\n' if len(sources) > 1 else '') + 'I\nII\n'
                       for name in sources).encode('ascii')
    if output.replace(b'\r\n', b'\n').strip() != expected.strip():
        raise ValueError('historical C compiler reported unexpected diagnostics')


def validate_image(image, reserve=256):
    if reserve < 0 or reserve > 16384:
        raise ValueError('invalid stack reserve')
    if len(image) < 16:
        raise ValueError('missing or truncated compiler image')
    magic, text, data, bss = struct.unpack_from('<4H', image)
    if magic != 0o407 or text == 0:
        raise ValueError('invalid compiler image header')
    if (text | data | bss) & 1:
        raise ValueError('unaligned compiler image sections')
    if len(image) < 16 + text + data:
        raise ValueError('truncated compiler image sections')
    if text + data + bss + reserve > 16384:
        raise ValueError(f'compiler image leaves less than {reserve} bytes for arguments and stack')


def compile_sources(root, emulator, sources, reserve=256):
    root = root.resolve()
    emulator = emulator.resolve()
    output = root/'a.out'
    output.unlink(missing_ok=True)
    try:
        result = subprocess.run([str(emulator), str(root/'bin/cc'), *sources], cwd=root,
                                env=dict(os.environ, APOUT_ROOT=str(root)),
                                capture_output=True, timeout=120)
        sys.stdout.buffer.write(result.stdout)
        sys.stderr.buffer.write(result.stderr)
        # V1 cc's exit status is not reliable. Its diagnostics and output are.
        if result.returncode < 0:
            raise ValueError('historical C compiler process terminated by a signal')
        validate_progress(result.stdout, sources)
        if result.stderr:
            raise ValueError('historical C compiler wrote error output')
        validate_image(output.read_bytes(), reserve)
    except (OSError, ValueError, subprocess.SubprocessError):
        output.unlink(missing_ok=True)
        raise


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, required=True)
    parser.add_argument('--emulator', type=Path, required=True)
    parser.add_argument('--reserve', type=int, default=256)
    parser.add_argument('sources', nargs='+')
    args = parser.parse_args()
    try:
        compile_sources(args.root, args.emulator, args.sources, args.reserve)
    except (OSError, ValueError, subprocess.SubprocessError) as error:
        print(f'bcc-pdp: {error}', file=sys.stderr)
        return 1
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
