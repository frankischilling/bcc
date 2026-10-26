#!/usr/bin/env python3
"""Build the experimental B execution engine with the existing C-written seed."""
import argparse
import os
import shutil
import sys
from pathlib import Path
import subprocess
import tempfile

BOOTSTRAP = Path(__file__).resolve().parents[1]
NATIVE = BOOTSTRAP.parent
MODULES = ('fetch', 'arithmetic', 'heap', 'primitives', 'execute')


def source_text(main=None):
    parts = [BOOTSTRAP / 'vm' / (name + '.b') for name in MODULES]
    parts.append(main or BOOTSTRAP / 'vm/main.b')
    return '\n'.join(path.read_text() for path in parts)


def build(output, *, host=None, main=None, raw_v1=False):
    with tempfile.TemporaryDirectory(prefix='bcc-vm-build-') as directory:
        source = Path(directory) / 'engine.b'
        source.write_text(source_text(main))
        if host:
            command = [str(host.resolve()), '--strict', '--pedantic', '--word=16', str(source), '-o', str(output)]
        else:
            command = ['python3', str(NATIVE / 'tools/run_apout.py'), '--emit-image', str(output)]
            if raw_v1:
                command.append('--raw-v1')
            command.append(str(source))
        subprocess.run(command, check=True, timeout=180)


def resolver_image(work):
    """Resolve the B-written pass using the seed, then encode its VM image."""
    sys.path.insert(0, str(NATIVE / 'tools'))
    from run_apout import build_snapshot_lock
    from encode_vm import encode
    with build_snapshot_lock(NATIVE):
        for name in ('b00', 'b01'):
            shutil.copy2(NATIVE / 'build' / name, work / name)
        shutil.copy2(NATIVE.parent / 'unix-v1/tools/apout/apout', work / 'apout')
    source = '\n'.join((BOOTSTRAP / 'src' / name).read_text()
                       for name in ('buffered_io.b', 'decimal16.b', 'diagnostics.b', 'ic.b', 'resolver16.b', 'symbols.b', 'b01.b'))
    (work / 'b01.b').write_text(source)
    env = dict(os.environ, APOUT_ROOT=str(work))
    for binary, args in [('b00', ['-o', 'b01.ic', 'b01.b']),
                         ('b01', ['-i', 'b01.ic', '-o', 'b01.r2'])]:
        subprocess.run([str(work / 'apout'), str(work / binary), *args],
                       cwd=work, env=env, check=True, timeout=60)
    return encode((work / 'b01.r2').read_text())


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('output', type=Path)
    parser.add_argument('--host-bcc', type=Path, help='build a host-side 16-bit model instead of PDP-11 code')
    parser.add_argument('--raw-v1', action='store_true')
    parser.add_argument('--source-only', action='store_true', help='write combined B source instead of an image')
    args = parser.parse_args()
    if args.source_only:
        args.output.write_text(source_text())
    else:
        if args.host_bcc and args.raw_v1:
            parser.error('--raw-v1 applies only to PDP-11 images')
        build(args.output, host=args.host_bcc, raw_v1=args.raw_v1)


if __name__ == '__main__':
    main()
