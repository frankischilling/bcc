#!/usr/bin/env python3
"""Refresh the GNU assembler snapshots from the maintained C compiler."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent.parent
SOURCES = ['util', 'lexer', 'parser', 'sem', 'arena', 'emitter', 'main']
FLAGS = ['-std=c99', '-O2', '-fno-ident', '-S']


def hashes():
    return {f'src/{name}': hashlib.sha256((ROOT / 'src' / name).read_bytes()).hexdigest()
            for name in ['bcc.h', *(name + '.c' for name in SOURCES)]}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true')
    parser.add_argument('--cc', default=os.environ.get('CC', 'gcc'))
    args = parser.parse_args()
    manifest = ROOT / 'asm/generated/manifest.json'
    current = hashes()
    if args.check:
        saved = json.loads(manifest.read_text())
        if saved['sources'] != current:
            parser.error('assembly snapshots are stale; run make -C asm regenerate')
        for name, digest in saved['assembly'].items():
            if hashlib.sha256((ROOT / 'asm/generated' / name).read_bytes()).hexdigest() != digest:
                parser.error(f'assembly snapshot changed: {name}; regenerate it')
        return
    with tempfile.TemporaryDirectory(prefix='bcc-assembly-') as directory:
        tmp = Path(directory)
        for name in SOURCES:
            subprocess.run([args.cc, *FLAGS, f'src/{name}.c', '-o', str(tmp / (name + '.s'))], cwd=ROOT, check=True)
        assembly = {}
        for name in SOURCES:
            data = (tmp / (name + '.s')).read_bytes()
            (ROOT / 'asm/generated' / (name + '.s')).write_bytes(data)
            assembly[name + '.s'] = hashlib.sha256(data).hexdigest()
    version = subprocess.check_output([args.cc, '--version'], text=True).splitlines()[0]
    manifest.write_text(json.dumps({'compiler': version, 'flags': FLAGS, 'sources': current, 'assembly': assembly}, indent=2) + '\n')


if __name__ == '__main__':
    main()
