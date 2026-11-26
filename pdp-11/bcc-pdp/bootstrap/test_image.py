#!/usr/bin/env python3
"""Compare B-written native images with the pinned assembler and image converter."""
import argparse
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
NATIVE = ROOT.parent
PROJECT = NATIVE.parents[1]
sys.path[:0] = [str(ROOT / 'tools'), str(NATIVE / 'tools')]
from build_passes import snapshot, seed_image, source_text
from build_vm import build, source_text as engine_source
from run_apout import build_snapshot_lock
from apout_image import native_image, validate_assembler_output
from runtime_selection import select_runtime, needs_b_library, select_primitive_runtime


def run(command, work, timeout=180):
    return subprocess.run([str(p) for p in command], cwd=work,
                          env=dict(os.environ, APOUT_ROOT=str(work), APOUT_UNIX_VERSION='V2'),
                          capture_output=True, timeout=timeout)


def require(process):
    if process.returncode:
        raise RuntimeError((process.returncode, process.stdout, process.stderr))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--bcc', type=Path, default=PROJECT / 'bcc')
    parser.add_argument('--vm', action='store_true', help='also check selected inputs in both execution models')
    parser.add_argument('--engine-vm', action='store_true',
                        help='also reconstruct the full native engine in both VMs (slow)')
    args = parser.parse_args()
    source = source_text('image')
    rejects = json.loads((ROOT / 'image/fixtures/reject.json').read_text())
    passed = rejected = 0
    with tempfile.TemporaryDirectory(prefix='bcc-B-image-') as directory:
        work = Path(directory)
        snapshot(work)
        with build_snapshot_lock(NATIVE):
            (work / 'etc').mkdir()
            (work / 'tmp').mkdir()
            shutil.copy2(NATIVE / 'build/aroot/bin/as', work / 'as')
            shutil.copy2(NATIVE / 'build/aroot/etc/as2', work / 'etc/as2')
            runtimes = {name: (NATIVE / 'runtime' / name).read_bytes()
                        for name in ('bmain.s', 'brt.s', 'libb.s')}
        cases = [(p.stem, {'input.s': p.read_bytes()})
                 for p in sorted((ROOT / 'image/fixtures').glob('*.s'))]
        inputs = []
        for kind in ('run', 'ext'):
            for path in sorted((NATIVE / 'tests' / kind).glob('*.b')):
                inputs.append((path.stem, path.read_bytes(), kind == 'ext',
                               path.with_suffix('.reject')))
        inputs.append(('engine', engine_source().encode(), False, None))
        for name, data, extensions, rejection in inputs:
            if rejection and rejection.exists():
                rejected += 1
                continue
            (work / 'input.b').write_bytes(data)
            for binary, flags in [('b00', [*(['-x'] if extensions else []), '-o', 'raw.ic', 'input.b']),
                                  ('b01', ['-i', 'raw.ic', '-o', 'code.ic']),
                                  ('b1', ['-i', 'code.ic', '-o', 'program.s'])]:
                process = run([work / 'apout', work / binary, *flags], work)
                if process.returncode:
                    if not rejection or not rejection.exists() or rejection.read_bytes().strip() not in process.stdout + process.stderr:
                        require(process)
                    rejected += 1
                    break
            else:
                program = (work / 'program.s').read_bytes()
                library = runtimes['libb.s'] if needs_b_library(program) else b''
                files = {'bmain.s': runtimes['bmain.s'],
                         'brt.s': select_primitive_runtime(program, runtimes['brt.s'], library)}
                if library:
                    files['libb.s'] = select_runtime(program, library)
                files['program.s'] = program
                cases.append((name, files))
        references = []
        for name, files in cases:
            for filename, data in files.items():
                (work / filename).write_bytes(data)
            process = run([work / 'apout', work / 'as', *files], work)
            require(process)
            validate_assembler_output(process.stdout, process.stderr)
            references.append(native_image((work / 'a.out').read_bytes()))
        (work / 'writer.b').write_text(source)
        for word in ('16', '32', 'host'):
            executable = work / ('writer-' + word)
            subprocess.run([str(args.bcc.resolve()), '--strict', '--pedantic', '--word=' + word,
                            str(work / 'writer.b'), '-o', str(executable)], check=True, timeout=180)
            for (name, files), expected in zip(cases, references):
                for filename, data in files.items():
                    (work / filename).write_bytes(data)
                (work / 'output').unlink(missing_ok=True)
                process = run([executable, 'output', *files], work)
                require(process)
                if process.stdout or process.stderr or (work / 'output').read_bytes() != expected:
                    raise AssertionError((word, name, 'native image differs'))
                passed += 1
                print(f'PASS: image/{word}/{name}', flush=True)
            for name, text, diagnostic in rejects:
                (work / 'input.s').write_text(text)
                process = run([executable, 'output', 'input.s'], work)
                if not process.returncode or diagnostic.encode() not in process.stdout + process.stderr:
                    raise AssertionError((word, name, process.returncode, process.stdout, process.stderr))
                passed += 1
                print(f'PASS: image/{word}/reject/{name}', flush=True)
        if args.vm or args.engine_vm:
            (work / 'code.vm').write_bytes(seed_image('image', work, source=source)[0])
            build(work / 'native-vm')
            build(work / 'host-vm', host=args.bcc)
            for (name, files), expected in zip(cases, references):
                if name not in ('hello', 't02_arith', 't32_time_registers', 't115_literal_backslash') and not (args.engine_vm and name == 'engine'):
                    continue
                for filename, data in files.items():
                    (work / filename).write_bytes(data)
                for model, command in [('native', [work / 'apout', work / 'native-vm']),
                                       ('host16', [work / 'host-vm'])]:
                    (work / 'heap.vm').write_bytes(bytes(16384))
                    (work / 'output').unlink(missing_ok=True)
                    process = run([*command, 'code.vm', 'output', *files], work, timeout=1800 if name == 'engine' else 600)
                    require(process)
                    if process.stdout or process.stderr or (work / 'output').read_bytes() != expected:
                        raise AssertionError((model, name, 'VM native image differs'))
                    passed += 1
                    print(f'PASS: image-vm/{model}/{name}', flush=True)
    print(f'Rejection fixtures excluded from image comparisons: {rejected}')
    print(f'Results: {passed} passed, 0 failed')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
