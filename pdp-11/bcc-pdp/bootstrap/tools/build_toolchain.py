#!/usr/bin/env python3
"""Prepare an experimental B toolchain in a new directory using the C seed."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
NATIVE = ROOT.parent
PROJECT = NATIVE.parents[1]
sys.path[:0] = [str(ROOT / 'tools'), str(NATIVE / 'tools')]
from build_passes import source_text, seed_image
from run_apout import build_snapshot_lock
from build_vm import source_text as engine_source

FILES = {
    'frontend': ('front.vm', 'bf.b'),
    'resolver': ('resolve', 'br.b'),
    'codegen': ('codegen', 'bg.b'),
    'selector': ('select', 'bs.b'),
    'runtime': ('runtime', 'rt.b'),
    'image': ('image', 'bi.b'),
    'encoder': ('encoder', 'be.b'),
}



def guest_file_sizes(paths):
    """The pinned V1 inode has a two-byte unsigned size field."""
    sizes = {}
    for name, path in paths.items():
        if not path.is_file():
            raise ValueError(f'missing guest build file: {name}')
        size = path.stat().st_size
        if size > 65535:
            raise ValueError(f'{name} is {size} bytes; the guest file limit is 65535')
        sizes[name] = size
    return sizes


def build(output):
    """Keep failed seed artifacts for diagnosis; never overwrite a directory."""
    sources = {name: source_text(name) for name in FILES}
    sources['engine'] = engine_source()
    sources['driver'] = (ROOT / 'driver/main.b').read_text()
    output.mkdir(parents=True, exist_ok=False)
    manifest = {'description': 'C-seeded experimental B toolchain; not a completed self-bootstrap',
                'revision': subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=PROJECT, text=True).strip(),
                'worktree_dirty': bool(subprocess.check_output(
                    ['git', 'status', '--porcelain', '--ignore-submodules=dirty'], cwd=PROJECT)),
                'python_version': sys.version, 'seed_tools': {}, 'seed_inputs': {}, 'native': {}, 'images': {}, 'sources': {}}
    with build_snapshot_lock(NATIVE), tempfile.TemporaryDirectory(prefix='bcc-B-toolchain-seed-') as directory:
        work = Path(directory)
        # Hold one shared build lock across every seed input snapshot.
        for name in ('b00', 'b01', 'b1'):
            shutil.copy2(NATIVE / 'build' / name, work / name)
        shutil.copy2(NATIVE.parent / 'unix-v1/tools/apout/apout', work / 'apout')
        for name in ('b00', 'b01', 'b1', 'apout'):
            manifest['seed_tools'][name] = hashlib.sha256((work / name).read_bytes()).hexdigest()
        direct_tools = {
            'as': NATIVE / 'build/aroot/bin/as',
            'as2': NATIVE / 'build/aroot/etc/as2',
            'helpers/encode_vm.py': ROOT / 'tools/encode_vm.py',
            'helpers/build_passes.py': ROOT / 'tools/build_passes.py',
            'helpers/build_toolchain.py': ROOT / 'tools/build_toolchain.py',
            'helpers/run_apout.py': NATIVE / 'tools/run_apout.py',
            'helpers/apout_image.py': NATIVE / 'tools/apout_image.py',
            'helpers/runtime_selection.py': NATIVE / 'tools/runtime_selection.py',
        }
        for name, path in direct_tools.items():
            manifest['seed_tools'][name] = hashlib.sha256(path.read_bytes()).hexdigest()
        for name, (image_name, source_name) in FILES.items():
            source = sources[name]
            (output / source_name).write_text(source)
            image, data, words = seed_image(name, work, source=source)
            sizes = guest_file_sizes({'source': output / source_name, 'raw_records': work / 'raw.ic',
                                      'resolved_records': work / 'code.ic'})
            (output / image_name).write_bytes(image)
            sizes.update(guest_file_sizes({'image': output / image_name}))
            manifest['images'][image_name] = {'bytes': len(image), 'data_words': data,
                                               'instruction_words': words,
                                               'sha256': hashlib.sha256(image).hexdigest(), 'guest_file_bytes': sizes}
            manifest['sources'][source_name] = hashlib.sha256(source.encode()).hexdigest()
        for name, source_name in [('engine', 'vm.b'), ('driver', 'bdrv.b')]:
            source = sources[name]
            (output / source_name).write_text(source)
            (work / 'input.b').write_text(source)
            for binary, flags in [('b00', ['-o', 'raw.ic', 'input.b']),
                                  ('b01', ['-i', 'raw.ic', '-o', 'code.ic']),
                                  ('b1', ['-i', 'code.ic', '-o', 'prog.s'])]:
                subprocess.run([str(work / 'apout'), str(work / binary), *flags], cwd=work,
                               env=dict(os.environ, APOUT_ROOT=str(work)), check=True, timeout=60)
            sizes = guest_file_sizes({'source': output / source_name, 'raw_records': work / 'raw.ic',
                                      'resolved_records': work / 'code.ic', 'assembly': work / 'prog.s'})
            subprocess.run([sys.executable, str(NATIVE / 'tools/run_apout.py'), '--raw-v1',
                            '--emit-image', str(output / name), str(output / source_name)],
                           env=dict(os.environ, _BCC_NATIVE_LOCKED='1'), check=True, timeout=180)
            (output / name).chmod(0o755)
            image = (output / name).read_bytes()
            manifest['native'][name] = {'bytes': len(image), 'sha256': hashlib.sha256(image).hexdigest(),
                                        'guest_file_bytes': sizes}
            manifest['sources'][source_name] = hashlib.sha256(source.encode()).hexdigest()
        for name in ('bmain.s', 'brt.s', 'libb.s', 'libb.b'):
            shutil.copy2(NATIVE / 'runtime' / name, output / name)
            manifest['seed_inputs'][name] = hashlib.sha256((output / name).read_bytes()).hexdigest()
    (output / 'seed.json').write_text(json.dumps(manifest, indent=2) + '\n')
    return manifest


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('directory', type=Path, help='new caller-owned toolchain directory')
    args = parser.parse_args()
    output = args.directory.resolve()
    if output.exists():
        parser.error('destination already exists; choose a new directory')
    build(output)
    print(f'Prepared C-seeded B toolchain: {output}')


if __name__ == '__main__':
    main()
