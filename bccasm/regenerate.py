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
SOURCES = ['util', 'lexer', 'parser', 'sem', 'arena', 'emitter', 'runtime_cache', 'main']
FLAGS = ['-std=c99', '-O2', '-fno-ident', '-S']


def hashes():
    return {f'bcc-c/{name}': hashlib.sha256((ROOT / 'bcc-c' / name).read_bytes()).hexdigest()
            for name in ['bcc.h', *(name + '.c' for name in SOURCES)]}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument('--check', action='store_true', help='check all source and assembly hashes')
    mode.add_argument('--verify', action='store_true', help='also reproduce assembly with the recorded compiler')
    parser.add_argument('--cc', default=os.environ.get('CC', 'gcc'))
    args = parser.parse_args()
    manifest = ROOT / 'bccasm/generated/manifest.json'
    current = hashes()
    if args.check or args.verify:
        try:
            saved = json.loads(manifest.read_text())
        except (OSError, ValueError) as error:
            parser.error(f'cannot read assembly manifest: {error}')
        if not isinstance(saved, dict) or saved.get('flags') != FLAGS:
            parser.error('invalid assembly manifest or compiler flags')
        if saved.get('sources') != current:
            parser.error('assembly snapshots are stale; run make -C bccasm regenerate')
        expected_names = {name + '.s' for name in SOURCES}
        assembly = saved.get('assembly')
        if not isinstance(assembly, dict) or set(assembly) != expected_names:
            parser.error('assembly manifest must list every generated source exactly once')
        for name, digest in assembly.items():
            path = ROOT / 'bccasm/generated' / name
            if not path.is_file() or hashlib.sha256(path.read_bytes()).hexdigest() != digest:
                parser.error(f'assembly snapshot changed: {name}; regenerate it')
        if not args.verify:
            return
        version = subprocess.check_output([args.cc, '--version'], text=True).splitlines()[0]
        if version != saved.get('compiler'):
            parser.error(f'compiler version differs from manifest: {version!r} != {saved.get("compiler")!r}')
    with tempfile.TemporaryDirectory(prefix='bcc-assembly-') as directory:
        tmp = Path(directory)
        for name in SOURCES:
            subprocess.run([args.cc, *FLAGS, f'bcc-c/{name}.c', '-o', str(tmp / (name + '.s'))], cwd=ROOT, check=True)
        if args.verify:
            for name in SOURCES:
                path = tmp / (name + '.s')
                if hashlib.sha256(path.read_bytes()).hexdigest() != assembly[path.name]:
                    parser.error(f'assembly snapshot is not reproducible: {path.name}')
            return
        assembly = {}
        for name in SOURCES:
            data = (tmp / (name + '.s')).read_bytes()
            (ROOT / 'bccasm/generated' / (name + '.s')).write_bytes(data)
            assembly[name + '.s'] = hashlib.sha256(data).hexdigest()
    version = subprocess.check_output([args.cc, '--version'], text=True).splitlines()[0]
    manifest.write_text(json.dumps({'compiler': version, 'flags': FLAGS, 'sources': current, 'assembly': assembly}, indent=2) + '\n')


if __name__ == '__main__':
    main()
