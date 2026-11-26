#!/usr/bin/env python3
"""Exercise the B driver with no C compiler or assembler in its application root."""
import argparse
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
NATIVE = ROOT.parent
sys.path[:0] = [str(ROOT / 'tools'), str(NATIVE / 'tools')]
from build_toolchain import build, FILES
from apout_image import test_image

SOURCE = "main(){extrn putchar;putchar('O');putchar('K');putchar('*n');return(0);}\n"


def run(command, work, timeout=1800, close_stderr=False):
    return subprocess.run([str(p) for p in command], cwd=work,
                          env=dict(os.environ, APOUT_ROOT=str(work), APOUT_UNIX_VERSION='V2'),
                          capture_output=True, timeout=timeout,
                          preexec_fn=(lambda: os.close(2)) if close_stderr else None)


def require(process):
    if process.returncode or process.stdout or process.stderr:
        raise AssertionError((process.returncode, process.stdout, process.stderr))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--self-test', action='store_true', help='also rebuild every component from B source (slow)')
    parser.add_argument('--rebuild', action='append', choices=[*FILES, 'driver', 'engine'], default=[],
                        help='rebuild only the named component; may be repeated')
    args = parser.parse_args()
    if args.self_test and args.rebuild:
        parser.error('--self-test and --rebuild are mutually exclusive')
    passed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-B-toolchain-') as directory:
        root = Path(directory)
        seed = root / 'seed'
        build(seed)
        work = root / 'work'
        shutil.copytree(seed, work)
        apout = NATIVE.parent / 'unix-v1/tools/apout/apout'
        for name in ('engine', 'driver'):
            (work / name).write_bytes(test_image((seed / name).read_bytes()))
        assert not any((work / name).exists() for name in ('b00', 'b01', 'b1', 'as', 'bin/as'))
        (work / 'input.b').write_text(SOURCE)
        reference = root / 'reference'
        subprocess.run([sys.executable, str(NATIVE / 'tools/run_apout.py'), '--raw-v1',
                        '--emit-image', str(reference), str(work / 'input.b')], check=True, timeout=180)
        for name in ('bmain.s', 'brt.s', 'libb.s'):
            (work / name).unlink()
        driver = [apout, work / 'driver']
        require(run([*driver, '-r'], work))
        assert all((work / name).read_bytes() == (seed / name).read_bytes() for name in ('bmain.s', 'brt.s'))
        passed += 1
        print('PASS: B driver regenerates target instruction templates', flush=True)
        require(run([*driver, '-b'], work))
        assert (work / 'libb.s').read_bytes() == (seed / 'libb.s').read_bytes()
        passed += 1
        print('PASS: B driver rebuilds the bundled B library without sed', flush=True)
        require(run([*driver, 'input.b', 'out'], work))
        assert (work / 'out').read_bytes() == reference.read_bytes()
        (work / 'observe').write_bytes(test_image((work / 'out').read_bytes()))
        result = run([apout, work / 'observe'], work, timeout=60)
        assert (result.returncode, result.stdout, result.stderr) == (0, b'OK\n', b'')
        passed += 1
        print('PASS: five B stages produce and execute the exact native image', flush=True)
        require(run([*driver, '-v', 'input.b', 'program'], work))
        (work / 'heap.vm').write_bytes(bytes(16384))
        result = run([apout, work / 'engine', 'program'], work, timeout=60)
        assert (result.returncode, result.stdout, result.stderr) == (0, b'OK\n', b'')
        passed += 1
        print('PASS: B driver produces an executable instruction image', flush=True)
        for mode, output in [('-s', 'normal.s'), ('-l', 'library.s'), ('-L', 'bundled.s')]:
            require(run([*driver, mode, 'input.b', output], work))
            assert (work / output).stat().st_size
            passed += 1
            print(f'PASS: B driver assembly mode {mode}', flush=True)
        (work / 'bad.b').write_text('main(){auto;}\n')
        (work / 'done').write_bytes(b'ok')
        result = run([*driver, 'bad.b', 'badout'], work)
        assert result.returncode and b'B build failed' in result.stderr
        assert not (work / 'done').exists() and not (work / 'badout').exists()
        passed += 1
        print('PASS: failed pass cannot reuse a stale completion marker', flush=True)
        (work / 'keep').write_bytes(b'keep this file')
        for source, output in [('input.b', 'keep'), ('input.b', 'input.b'), ('raw.ic', 'unused')]:
            before = (work / source).read_bytes()
            result = run([*driver, source, output], work)
            assert result.returncode and (work / source).read_bytes() == before
            assert (work / 'keep').read_bytes() == b'keep this file'
            passed += 1
            print(f'PASS: B driver rejects destructive paths {source} / {output}', flush=True)
        (work / 'heap.vm').write_bytes(b'U' * 16384)
        (work / 'done').write_bytes(b'preserve')
        result = run([*driver, 'a' * 129, 'longout'], work, timeout=60)
        assert result.returncode and (work / 'heap.vm').read_bytes() == b'U' * 16384
        assert (work / 'done').read_bytes() == b'preserve' and not (work / 'longout').exists()
        (work / 'done').unlink()
        passed += 1
        print('PASS: oversized engine arguments are rejected before scratch writes', flush=True)
        result = run(driver, work, timeout=60, close_stderr=True)
        assert result.returncode and result.stdout.startswith(b'usage: driver')
        passed += 1
        print('PASS: driver diagnostics survive a closed descriptor 2', flush=True)
        (work / 'heap.vm').write_bytes(bytes(16384))
        result = run([apout, work / 'engine', 'runtime'], work, timeout=60, close_stderr=True)
        assert result.returncode and result.stdout.startswith(b'usage: rtgen')
        passed += 1
        print('PASS: runtime diagnostics survive a closed descriptor 2', flush=True)
        if args.self_test or args.rebuild:
            for name, (image, source) in FILES.items():
                if not args.self_test and name not in args.rebuild:
                    continue
                output = name[:4] + '.new'
                require(run([*driver, '-v', source, output], work, timeout=7200))
                assert (work / output).read_bytes() == (seed / image).read_bytes(), name
                passed += 1
                print(f'PASS: B driver rebuilds {name} instruction image from B', flush=True)
            for name, source in [('driver', 'bdrv.b'), ('engine', 'vm.b')]:
                if not args.self_test and name not in args.rebuild:
                    continue
                output = name + '2'
                require(run([*driver, source, output], work, timeout=7200))
                assert (work / output).read_bytes() == (seed / name).read_bytes(), name
                passed += 1
                print(f'PASS: B driver rebuilds native {name} from B', flush=True)
    print(f'Results: {passed} passed, 0 failed')
    return 0


if __name__ == '__main__':
    main()
