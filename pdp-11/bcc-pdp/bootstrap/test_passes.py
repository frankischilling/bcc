#!/usr/bin/env python3
"""Compare the B passes with seed tools and exercise the B-only VM pipeline."""
import argparse
import importlib.util
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import time

ROOT = Path(__file__).resolve().parent
NATIVE = ROOT.parent
PROJECT = NATIVE.parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
from build_passes import MODULES, source_text, snapshot, seed_image
from build_vm import build
from encode_vm import encode

spec = importlib.util.spec_from_file_location('encoder_cases', ROOT / 'test_vm_encoder.py')
fixtures = importlib.util.module_from_spec(spec)
spec.loader.exec_module(fixtures)


def run(command, work, *, timeout=180):
    return subprocess.run([str(item) for item in command], cwd=work,
                          env=dict(os.environ, APOUT_ROOT=str(work), APOUT_UNIX_VERSION='V2'),
                          capture_output=True, timeout=timeout)


def result(process):
    return process.returncode, process.stdout, process.stderr


def checked(command, work):
    process = run(command, work)
    if result(process) != (0, b'', b''):
        raise RuntimeError((command, result(process)))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--bcc', type=Path, default=PROJECT / 'bcc')
    parser.add_argument('--vm', action='store_true', help='also execute all three B passes in each VM')
    parser.add_argument('--self-test', action='store_true',
                        help='also rebuild all pass images from B source in each VM (slow)')
    args = parser.parse_args()
    sources = {name: source_text(name) for name in MODULES}
    passed = failed = 0

    def check(name, actual, expected):
        nonlocal passed, failed
        ok = actual == expected
        print(f'{"PASS" if ok else "FAIL"}: {name}', flush=True)
        if not ok:
            print('expected:', repr(expected)[:1000], 'actual:', repr(actual)[:1000], flush=True)
        passed += ok
        failed += not ok

    with tempfile.TemporaryDirectory(prefix='bcc-B-passes-') as directory:
        work = Path(directory)
        snapshot(work)
        front_cases = []
        for kind in ('run', 'ext'):
            for source in sorted((NATIVE / 'tests' / kind).glob('*.b')):
                front_cases.append((kind + '/' + source.stem, source.read_bytes(), kind == 'ext'))
        front_cases += [(name, source.encode(), False) for name, source in (
            ('empty', ''), ('newline-number', 'main(){\nreturn(1\n+ );\n}\n'),
            ('number-overflow', 'main(){return(65536);}'),
            ('negative-min', 'main(){switch -32768 {case -32768:return(0);}return(1);}'),
            ('empty-comment', '/**/'), ('unterminated', '/*'))]
        front_cases += [('self/' + name, sources[name].encode(), False) for name in MODULES]
        front_refs = []
        for _, data, extensions in front_cases:
            (work / 'input.b').write_bytes(data)
            flags = ['-x'] if extensions else []
            front_refs.append(result(run([work / 'apout', work / 'b00', *flags, 'input.b'], work)))

        encoder_cases = [(name, text) for name, text, *_ in fixtures.RECORDS]
        for name, source, *_ in fixtures.CASES:
            (work / 'input.b').write_text(source + '\n')
            checked([work / 'apout', work / 'b00', '-o', 'raw.ic', 'input.b'], work)
            checked([work / 'apout', work / 'b01', '-i', 'raw.ic', '-o', 'code.ic'], work)
            encoder_cases.append((name, (work / 'code.ic').read_text()))
        encoder_cases += [('512-literals', 'pr main 0 30000\n' + 'Slit 1 4\n'*512 + 'rt\nep 0\n')]
        encoder_cases += [
            ('same-bucket', ''.join(f'gvb n{i} 1\ngvc {i}\ngve\n' for i in range(199))
             + 'pr main 0 30000\nex n0\ndr\nrt\nep 0\n'),
            ('case-distinct', 'gvb n0 1\ngvc 3\ngve\ngvb N0 1\ngvc 7\ngve\n'
             'pr main 0 30000\nex n0\ndr\nps\nex N0\ndr\nbin 43\nrt\nep 0\n'),
            ('full-label-table', 'pr main 0 30000\nn 0\n'
             + ''.join(f'lb {i}\n' for i in range(1272)) + 'rt\nep 0\n'),
            ('high-label', 'pr main 0 30000\njm 32767\nn 1\nlb 32767\nn 42\nrt\nep 0\n'),
            ('load-label-barrier', 'gvb x 1\ngvc 3\ngve\n'
             'pr main 0 30000\nex x\nlb 1\ndr\nrt\nep 0\n'),
            ('load-double-deref', 'gvb x 1\ngvc 3\ngve\ngvb p 1\ngvn x\ngve\n'
             'pr main 0 30000\nex p\ndr\ndr\nrt\nep 0\n'),
        ]
        for name in MODULES:
            image, _, _ = seed_image(name, work, source=sources[name])
            (work / (name + '.vm')).write_bytes(image)
            for label, data in [('source', sources[name].encode()),
                                ('raw', (work / 'raw.ic').read_bytes()),
                                ('resolved', (work / 'code.ic').read_bytes()), ('image', image)]:
                check(f'guest-file-size/{name}/{label}', len(data) <= 65535, True)
            encoder_cases.append(('self/' + name, (work / 'code.ic').read_text()))

        for word in ('16', '32', 'host'):
            for name in ('frontend', 'encoder'):
                (work / 'pass.b').write_text(sources[name])
                subprocess.run([str(args.bcc.resolve()), '--strict', '--pedantic', '--word=' + word,
                                str(work / 'pass.b'), '-o', str(work / name)], check=True, timeout=180)
            for (name, data, extensions), expected in zip(front_cases, front_refs):
                (work / 'input.b').write_bytes(data)
                flags = ['-x'] if extensions else []
                check(f'B-frontend/{word}/{name}', result(run([work / 'frontend', *flags, 'input.b'], work)), expected)
            for name, records in encoder_cases:
                (work / 'input.ic').write_text(records)
                output = work / 'out.vm'
                output.unlink(missing_ok=True)
                process = run([work / 'encoder', 'input.ic', 'out.vm'], work)
                actual = (*result(process), output.read_bytes() if output.exists() else None)
                check(f'B-encoder/{word}/{name}', actual, (0, b'', b'', encode(records)[0]))

        if args.vm or args.self_test:
            build(work / 'native-vm')
            build(work / 'host-vm', host=args.bcc)
            for model, command in [('native', [work / 'apout', work / 'native-vm']),
                                   ('host16', [work / 'host-vm'])]:
                for name, source, status, output, arguments in fixtures.CASES:
                    (work / 'input.b').write_text(source + '\n')
                    for file in ('raw.ic', 'code.ic', 'out.vm'):
                        (work / file).unlink(missing_ok=True)
                    for stage, flags in [('frontend', ['-o', 'raw.ic', 'input.b']),
                                         ('resolver', ['-i', 'raw.ic', '-o', 'code.ic']),
                                         ('encoder', ['code.ic', 'out.vm'])]:
                        (work / 'heap.vm').write_bytes(bytes(16384))
                        checked([*command, stage + '.vm', *flags], work)
                    check(f'B-pipeline-image/{model}/{name}', (work / 'out.vm').read_bytes(),
                          encode((work / 'code.ic').read_text())[0])
                    (work / 'heap.vm').write_bytes(bytes(16384))
                    check(f'B-pipeline-run/{model}/{name}', result(run([*command, 'out.vm', *arguments], work)),
                          (status, output, b''))
                if args.self_test:
                    for name in MODULES:
                        (work / 'input.b').write_text(sources[name])
                        for file in ('raw.ic', 'code.ic', 'out.vm'):
                            (work / file).unlink(missing_ok=True)
                        for stage, flags in [('frontend', ['-o', 'raw.ic', 'input.b']),
                                             ('resolver', ['-i', 'raw.ic', '-o', 'code.ic']),
                                             ('encoder', ['code.ic', 'out.vm'])]:
                            (work / 'heap.vm').write_bytes(bytes(16384))
                            start = time.monotonic()
                            process = run([*command, stage + '.vm', *flags], work, timeout=900)
                            if result(process) != (0, b'', b''):
                                raise RuntimeError((model, name, stage, result(process)))
                            print(f'B-rebuild/{model}/{name}/{stage}: '
                                  f'{time.monotonic()-start:.3f}s', flush=True)
                        check(f'B-source-rebuild/{model}/{name}', (work / 'out.vm').read_bytes(),
                              (work / (name + '.vm')).read_bytes())
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
