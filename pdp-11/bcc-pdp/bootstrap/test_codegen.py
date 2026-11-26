#!/usr/bin/env python3
"""Compare B-written native assembly generation with the C-written pass."""
import argparse
import os
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
NATIVE = ROOT.parent
PROJECT = NATIVE.parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
from build_passes import MODULES, snapshot, seed_image, source_text
from build_vm import build


def run(command, work, *, native=False, timeout=180):
    env = dict(os.environ, APOUT_ROOT=str(work))
    if native:
        env['APOUT_UNIX_VERSION'] = 'V2'
    return subprocess.run([str(part) for part in command], cwd=work, env=env,
                          capture_output=True, timeout=timeout)


def result(process):
    return process.returncode, process.stdout, process.stderr


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--bcc', type=Path, default=PROJECT / 'bcc')
    parser.add_argument('--vm', action='store_true')
    args = parser.parse_args()
    passed = failed = rejected = 0
    sources = {name: source_text(name) for name in MODULES}

    def check(name, actual, expected):
        nonlocal passed, failed
        ok = actual == expected
        print(f'{"PASS" if ok else "FAIL"}: {name}', flush=True)
        if not ok:
            print('expected:', repr(expected)[:1000], 'actual:', repr(actual)[:1000], flush=True)
        passed += ok
        failed += not ok

    with tempfile.TemporaryDirectory(prefix='bcc-B-codegen-') as directory:
        work = Path(directory)
        snapshot(work)
        inputs = []
        for kind in ('run', 'ext'):
            for path in sorted((NATIVE / 'tests' / kind).glob('*.b')):
                inputs.append((kind + '/' + path.stem, path.read_bytes(), kind == 'ext', False,
                               path.with_suffix('.reject')))
        inputs += [('library', (NATIVE / 'runtime/libb.b').read_bytes(), False, True, None)]
        inputs += [('self/' + name, text.encode(), False, False, None) for name, text in sources.items()]
        cases = []
        for name, data, extensions, library, rejection in inputs:
            (work / 'input.b').write_bytes(data)
            commands = [('b00', [*(['-x'] if extensions else []), '-o', 'raw.ic', 'input.b']),
                        ('b01', ['-i', 'raw.ic', '-o', 'code.ic'])]
            for binary, flags in commands:
                process = run([work / 'apout', work / binary, *flags], work)
                if process.returncode:
                    if not rejection or not rejection.exists() or rejection.read_bytes().strip() not in process.stdout + process.stderr:
                        raise RuntimeError((name, binary, result(process)))
                    rejected += 1
                    break
            else:
                cases.append((name, (work / 'code.ic').read_bytes(), library))
        cases += [('bad/tag', b'unknown\n', False),
                  ('bad/integer', b'n 32768\n', False),
                  ('bad/switch', b'swb -1\n', False),
                  ('bad/literal-size', b'Slit 257\n', False)]
        references = []
        for name, records, library in cases:
            (work / 'code.ic').write_bytes(records)
            flags = ['-l'] if library else []
            references.append(result(run([work / 'apout', work / 'b1', *flags, '-i', 'code.ic'], work)))

        (work / 'pass.b').write_text(sources['codegen'])
        for word in ('16', '32', 'host'):
            executable = work / ('codegen-' + word)
            subprocess.run([str(args.bcc.resolve()), '--strict', '--pedantic', '--word=' + word,
                            str(work / 'pass.b'), '-o', str(executable)], check=True, timeout=180)
            for (name, records, library), expected in zip(cases, references):
                (work / 'code.ic').write_bytes(records)
                flags = ['-l'] if library else []
                process = run([executable, *flags, '-i', 'code.ic'], work)
                check(f'B-codegen/{word}/{name}', result(process), expected)

        if args.vm:
            (work / 'code.vm').write_bytes(seed_image('codegen', work, source=sources['codegen'])[0])
            build(work / 'native-vm')
            build(work / 'host-vm', host=args.bcc)
            selected = ('t02_', 't41_', 't43_', 't55_', 't56_', 't63_', 't96_',
                        't97_', 't103_', 't109_', 't115_', 't116_')
            for (name, records, library), expected in zip(cases, references):
                if name != 'library' and not name.startswith('bad/') and not any('/' + prefix in name for prefix in selected):
                    continue
                (work / 'input.ic').write_bytes(records)
                flags = ['-l'] if library else []
                for model, command in [('native', [work / 'apout', work / 'native-vm']),
                                       ('host16', [work / 'host-vm'])]:
                    (work / 'heap.vm').write_bytes(bytes(16384))
                    for filename in ('out.s', 'done'):
                        (work / filename).unlink(missing_ok=True)
                    process = run([*command, 'code.vm', *flags, '-i', 'input.ic', '-o', 'out.s', '-s', 'done'],
                                  work, native=True, timeout=300)
                    assembly = (work / 'out.s').read_bytes() if (work / 'out.s').exists() else None
                    marker = (work / 'done').read_bytes() if (work / 'done').exists() else None
                    check(f'VM-codegen/{model}/{name}', (*result(process), assembly, marker),
                          (expected[0], b'', expected[2], expected[1], b'ok' if expected[0] == 0 else None))
    print(f'Frontend/resolver rejection fixtures excluded: {rejected}')
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
