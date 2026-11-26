#!/usr/bin/env python3
"""Seed the experimental 64-bit record frontend from shared B modules."""
import argparse
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[2]
NATIVE = PROJECT / 'pdp-11/bcc-pdp/bootstrap'
sys.path.insert(0, str(NATIVE / 'tools'))
from build_passes import MODULES

OVERRIDES = {
    'src/decimal16.b': ROOT / 'decimal64.b',
    'frontend/word16.b': ROOT / 'word64.b',
}


def source_text():
    parts = MODULES['frontend']
    if not OVERRIDES.keys() <= set(parts):
        raise ValueError('native frontend module list lost its word-specific helpers')
    return '\n'.join(OVERRIDES.get(part, NATIVE / part).read_text() for part in parts)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('output', type=Path)
    parser.add_argument('--compiler', type=Path, default=PROJECT / 'bcc')
    parser.add_argument('--bootstrap', action='store_true')
    parser.add_argument('--source-only', action='store_true')
    args = parser.parse_args()
    source = source_text()
    if args.source_only:
        args.output.write_text(source)
        return
    compiler = [str(args.compiler.resolve()), '--strict', '--pedantic']
    if not args.bootstrap:
        compiler.append('--word=host')
    with tempfile.TemporaryDirectory(prefix='bcc-wide-frontend-') as directory:
        path = Path(directory) / 'frontend.b'
        path.write_text(source)
        subprocess.run([*compiler, str(path), '-o', str(args.output.resolve())], check=True)


if __name__ == '__main__':
    main()
