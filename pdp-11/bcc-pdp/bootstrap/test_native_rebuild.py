#!/usr/bin/env python3
"""Rebuild the native engine through B passes, retaining the historical assembler."""
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import time

ROOT = Path(__file__).resolve().parent
NATIVE = ROOT.parent
sys.path.insert(0, str(ROOT / 'tools'))
sys.path.insert(0, str(NATIVE / 'tools'))
from build_passes import seed_image
from build_vm import source_text
from run_apout import build_snapshot_lock
from runtime_selection import select_runtime, needs_b_library, select_primitive_runtime
from apout_image import native_image, test_image, validate_assembler_output


def snapshot_inputs(work):
    with build_snapshot_lock(NATIVE):
        for name in ('b00', 'b01', 'b1'):
            shutil.copy2(NATIVE / 'build' / name, work / name)
        shutil.copy2(NATIVE.parent / 'unix-v1/tools/apout/apout', work / 'apout')
        for name in ('bin/as', 'etc/as2'):
            (work / name).parent.mkdir(exist_ok=True)
            shutil.copy2(NATIVE / 'build/aroot' / name, work / name)
        return {name: (NATIVE / 'runtime' / name).read_bytes() for name in ('bmain.s', 'brt.s', 'libb.s')}


def run(command, work, *, observer=False, timeout=180):
    env = dict(os.environ, APOUT_ROOT=str(work))
    if observer:
        env['APOUT_UNIX_VERSION'] = 'V2'
    process = subprocess.run([str(part) for part in command], cwd=work, env=env,
                             capture_output=True, timeout=timeout)
    if process.returncode:
        raise RuntimeError((command, process.returncode, process.stdout, process.stderr))
    return process


def assemble(program, runtimes, work):
    data = (work / program).read_bytes()
    library_needed = needs_b_library(data)
    for name, runtime in runtimes.items():
        if name == 'brt.s':
            runtime = select_primitive_runtime(data, runtime, runtimes['libb.s'] if library_needed else b'')
        elif name == 'libb.s':
            runtime = select_runtime(data, runtime)
        (work / name).write_bytes(runtime)
    inputs = ['bmain.s', 'brt.s'] + (['libb.s'] if library_needed else []) + [program]
    (work / 'a.out').unlink(missing_ok=True)
    assembled = run([work / 'apout', work / 'bin/as', *inputs], work)
    validate_assembler_output(assembled.stdout, assembled.stderr)
    return native_image((work / 'a.out').read_bytes())


def main():
    with tempfile.TemporaryDirectory(prefix='bcc-B-native-rebuild-') as directory:
        work = Path(directory)
        (work / 'tmp').mkdir()
        runtimes = snapshot_inputs(work)
        for name in ('frontend', 'resolver', 'codegen'):
            (work / (name + '.vm')).write_bytes(seed_image(name, work)[0])
        (work / 'input.b').write_text(source_text())
        for binary, flags in [('b00', ['-o', 'reference.ic', 'input.b']),
                              ('b01', ['-i', 'reference.ic', '-o', 'reference.r2']),
                              ('b1', ['-i', 'reference.r2', '-o', 'reference.s'])]:
            run([work / 'apout', work / binary, *flags], work)
        reference = assemble('reference.s', runtimes, work)
        (work / 'engine').write_bytes(test_image(reference))
        for name, flags, output, expected in (
            ('frontend', ['-o', 'raw.ic', 'input.b'], 'raw.ic', 'reference.ic'),
            ('resolver', ['-i', 'raw.ic', '-o', 'code.ic'], 'code.ic', 'reference.r2'),
            ('codegen', ['-i', 'code.ic', '-o', 'program.s'], 'program.s', 'reference.s'),
        ):
            (work / 'heap.vm').write_bytes(bytes(16384))
            (work / output).unlink(missing_ok=True)
            start = time.monotonic()
            process = run([work / 'apout', work / 'engine', name + '.vm', *flags],
                          work, observer=True, timeout=900)
            if process.stdout or process.stderr or (work / output).read_bytes() != (work / expected).read_bytes():
                raise AssertionError((name, 'pass output differs from reference'))
            print(f'PASS: B-native rebuild/{name} ({time.monotonic()-start:.3f}s)', flush=True)
        actual = assemble('program.s', runtimes, work)
        if actual != reference:
            raise AssertionError('rebuilt native engine differs from seed image')
        print(f'PASS: B passes plus historical assembler reproduce {len(actual)} native bytes', flush=True)
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
