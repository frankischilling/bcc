#!/usr/bin/env python3
"""Compare the B runtime selector with the independent Python selector."""
import argparse
import importlib.util
import os
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
NATIVE = ROOT.parent
PROJECT = NATIVE.parents[1]
sys.path[:0] = [str(ROOT / 'tools'), str(NATIVE / 'tools')]
from build_passes import source_text, snapshot, seed_image
from build_vm import build
from runtime_selection import select_runtime, select_primitive_runtime, needs_b_library

spec = importlib.util.spec_from_file_location('selector_fixtures', ROOT / 'selector/fixtures.py')
fixtures = importlib.util.module_from_spec(spec)
spec.loader.exec_module(fixtures)


def run(command, work, timeout=180):
    return subprocess.run([str(p) for p in command], cwd=work,
                          env=dict(os.environ, APOUT_ROOT=str(work), APOUT_UNIX_VERSION='V2'),
                          capture_output=True, timeout=timeout)


def check(command, work, case):
    name, program, primitive, library = case
    for path, data in [('p.s', program), ('r.s', primitive), ('l.s', library)]:
        (work / path).write_bytes(data)
    (work / 'done').unlink(missing_ok=True)
    result = run([*command, '-s', 'done', 'p.s', 'r.s', 'l.s', 'r.out', 'l.out'], work, timeout=600)
    selected = library if needs_b_library(program) else b''
    expected = (select_primitive_runtime(program, primitive, selected),
                select_runtime(program, library) if selected else b'')
    if (result.returncode, result.stdout, result.stderr) != (0, b'', b''):
        raise AssertionError((name, result.returncode, result.stdout, result.stderr))
    actual = ((work / 'r.out').read_bytes(), (work / 'l.out').read_bytes())
    if actual != expected or (work / 'done').read_bytes() != b'ok':
        raise AssertionError((name, 'selection or marker differs'))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--bcc', type=Path, default=PROJECT / 'bcc')
    parser.add_argument('--vm', action='store_true')
    args = parser.parse_args()
    source = source_text('selector')
    cases = fixtures.cases()
    passed = rejected = 0
    with tempfile.TemporaryDirectory(prefix='bcc-B-selector-') as directory:
        work = Path(directory)
        snapshot(work)
        primitive = (NATIVE / 'runtime/brt.s').read_bytes()
        library = (NATIVE / 'runtime/libb.s').read_bytes()
        for kind in ('run', 'ext'):
            for path in sorted((NATIVE / 'tests' / kind).glob('*.b')):
                (work / 'input.b').write_bytes(path.read_bytes())
                for binary, flags in [('b00', [*(['-x'] if kind == 'ext' else []), '-o', 'raw.ic', 'input.b']),
                                      ('b01', ['-i', 'raw.ic', '-o', 'code.ic']),
                                      ('b1', ['-i', 'code.ic', '-o', 'prog.s'])]:
                    result = run([work / 'apout', work / binary, *flags], work)
                    if result.returncode:
                        rejection = path.with_suffix('.reject')
                        if not rejection.exists() or rejection.read_bytes().strip() not in result.stdout + result.stderr:
                            raise AssertionError((path.name, binary, result.stdout, result.stderr))
                        rejected += 1
                        break
                else:
                    cases.append((path.stem, (work / 'prog.s').read_bytes(), primitive, library))
        (work / 'selector.b').write_text(source)
        for word in ('16', '32', 'host'):
            binary = work / ('selector-' + word)
            subprocess.run([str(args.bcc.resolve()), '--strict', '--pedantic', '--word=' + word,
                            str(work / 'selector.b'), '-o', str(binary)], check=True, timeout=180)
            for case in cases:
                check([binary], work, case)
                passed += 1
            for name, program, runtime, diagnostic in fixtures.rejections():
                for path, data in [('p.s', program), ('r.s', runtime), ('l.s', b'')]:
                    (work / path).write_bytes(data)
                (work / 'done').unlink(missing_ok=True)
                result = run([binary, '-s', 'done', 'p.s', 'r.s', 'l.s', 'r.out', 'l.out'], work)
                if not result.returncode or diagnostic not in result.stdout + result.stderr or (work / 'done').exists():
                    raise AssertionError((word, name, result.returncode, result.stdout, result.stderr))
                passed += 1
            print(f'PASS: selector/{word}/{len(cases)} byte cases and 4 rejections', flush=True)
        if args.vm:
            (work / 'code.vm').write_bytes(seed_image('selector', work, source=source)[0])
            build(work / 'native-vm')
            build(work / 'host-vm', host=args.bcc)
            selected = [('runtime', b'_putchar:\n.+2\n_printf\n_time\n', primitive, library),
                        ('chunks', b'_printf\n', b'x' * 5000 + b'\n', b'_printf:\n' + b'y' * 1040 + b'\n')]
            for model, command in [('native', [work / 'apout', work / 'native-vm']),
                                   ('host16', [work / 'host-vm'])]:
                for case in selected:
                    (work / 'heap.vm').write_bytes(bytes(16384))
                    check([*command, 'code.vm'], work, case)
                    passed += 1
                    print(f'PASS: selector-vm/{model}/{case[0]}', flush=True)
    print(f'Compile-rejection fixtures excluded: {rejected}')
    print(f'Results: {passed} passed, 0 failed')
    return 0


if __name__ == '__main__':
    main()
