#!/usr/bin/env python3
"""Rebuild experimental native tools twice without a C toolchain after seeding."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import shutil
import struct
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[1]
SHARED = PROJECT / 'pdp-11/bcc-pdp/bootstrap'
LIBRARIES = ('execv', 'printf', 'printn', 'putchar', 'getchar', 'getstr', 'putstr', '__path', 'chdir', 'link', 'getuid', '__stat', 'stat', 'fstat', '__ticks', 'time', 'ctime')
sys.path.insert(0, str(SHARED / 'tools'))


def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


def sources():
    frontend = module('rebuild_frontend', ROOT / 'frontend/build.py')
    resolver = module('rebuild_resolver', ROOT / 'resolver/build.py')
    parts = [SHARED / 'src' / name for name in
             ('buffered_io.b', 'decimal16.b', 'diagnostics.b', 'ic.b')]
    parts += [ROOT / name for name in (
        'x64.b', 'labels.b', 'ops.b', 'scalar.b', 'memory.b', 'control.b',
        'switch.b', 'arity.b', 'calls.b', 'runtime/emit.b', 'runtime/path.b',
        'runtime/argv.b', 'runtime/imports.b', 'data/layout.b', 'data/labels.b',
        'data/output.b', 'fixtures/calls/metadata.b', 'fixtures/calls/emission.b',
        'fixtures/calls/driver.b')]
    return {
        'front': frontend.source_text(),
        'resolve': resolver.source_text(),
        'construct': '\n'.join(p.read_text() for p in parts),
        'image': (ROOT / 'elfimage.b').read_text(),
        'driver': (SHARED / 'src/ic.b').read_text() + '\n' +
                  (ROOT / 'driver/process.b').read_text() + '\n' +
                  (ROOT / 'driver/output.b').read_text() + '\n' +
                  (ROOT / 'driver/main.b').read_text(),
    }


def digest(data):
    return hashlib.sha256(data).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=PROJECT / 'bcc')
    parser.add_argument('--bootstrap', action='store_true')
    parser.add_argument('--output', type=Path, help='save verified native tools and sources in a new directory')
    args = parser.parse_args()
    if args.output is not None and args.output.exists():
        parser.error("output directory already exists")
    if platform.system() != 'Linux' or platform.machine().lower() not in ('x86_64', 'amd64'):
        print('SKIP: native rebuild requires Linux x86-64')
        return
    command = [str(args.compiler.resolve()), '--strict', '--pedantic']
    if not args.bootstrap:
        command.append('--word=host')
    text = sources()
    libraries = {name + ".b": (ROOT / "lib" / (name + ".b")).read_bytes() for name in LIBRARIES}
    with tempfile.TemporaryDirectory(prefix='bcc-native-rebuild-') as directory:
        work = Path(directory)
        source = work / 'sources'
        source.mkdir()
        previous = work / 'stage0'
        previous.mkdir()
        stdio = module('native_stdio_cases', ROOT / 'test_stdio.py')
        paths = module('native_path_cases', ROOT / 'test_paths.py')
        metadata = module('native_metadata_cases', ROOT / 'test_metadata.py')
        clock = module('native_clock_cases', ROOT / 'test_clock.py')
        if not args.bootstrap:
            stdio.reference_checks(command, work / 'stdio-reference')
            paths.reference_checks(command, work / 'paths-reference')
            metadata.reference_checks(command, work / 'metadata-reference')
            clock.reference_checks(command, work / 'clock-reference')
        for name, content in text.items():
            path = source / (name + '.b')
            path.write_text(content)
            if name != 'driver':
                subprocess.run([*command, str(path), '-o', str(previous / name)],
                               check=True, timeout=180)
        # No C compiler or external assembler/linker is launched below this point.
        env = dict(os.environ, PATH='')
        manifests = []

        def run(tool, arguments, cwd, target):
            result = subprocess.run([str(tool), *map(str, arguments)], cwd=cwd,
                                    env=env, capture_output=True, timeout=180)
            assert (result.returncode, result.stderr) == (0, b''), (tool, arguments, result)
            target.write_bytes(result.stdout)

        for stage in range(1, 4):
            current = work / f'stage{stage}'
            current.mkdir()
            (current / 'sources').mkdir()
            for name, content in libraries.items():
                (current / 'sources' / name).write_bytes(content)
            records = {}
            for name in text:
                scratch = current / (name + '-work')
                scratch.mkdir()
                raw = scratch / 'raw.ic'
                resolved = scratch / 'resolved.ic'
                data = scratch / 'data'
                code = scratch / 'code'
                run(previous / 'front', [source / (name + '.b')], scratch, raw)
                run(previous / 'resolve', ['-i', raw], scratch, resolved)
                run(previous / 'construct', [raw, resolved, data, 'run'], scratch, code)
                run(previous / 'image', [code, data, '0', '0'], scratch, current / name)
                executable = (current / name).read_bytes()
                assert executable[:7] == b'\x7fELF\x02\x01\x01', (stage, name)
                phoff = struct.unpack_from('<Q', executable, 32)[0]
                phsize, phcount = struct.unpack_from('<HH', executable, 54)
                assert phsize == 56 and phcount == 3, (stage, name, phsize, phcount)
                kinds = [struct.unpack_from('<I', executable, phoff + i * phsize)[0]
                         for i in range(phcount)]
                assert kinds == [1, 1, 0x6474e551], (stage, name, kinds)
                (current / name).chmod(0o700)
                artifacts = {'raw': raw, 'resolved': resolved, 'code': code,
                             'data': data, 'executable': current / name}
                records[name] = {key: {'bytes': path.stat().st_size,
                                      'sha256': digest(path.read_bytes())}
                                 for key, path in artifacts.items()}
                if manifests:
                    old_paths = {'raw': previous / (name + '-work/raw.ic'),
                                 'resolved': previous / (name + '-work/resolved.ic'),
                                 'code': previous / (name + '-work/code'),
                                 'data': previous / (name + '-work/data'),
                                 'executable': previous / name}
                    for key, path in artifacts.items():
                        assert path.read_bytes() == old_paths[key].read_bytes(), (stage, name, key)
                    assert records[name] == manifests[-1][name], (stage, name, records[name], manifests[-1][name])
                print(f'stage {stage}: {name} ({records[name]["executable"]["bytes"]} bytes)', flush=True)
            manifests.append(records)
            previous = current
        cases = module('native_rebuild_cases', ROOT / 'test_calls.py').SOURCE_CASES
        scratch = work / 'programs'
        scratch.mkdir()
        for index, (content, value) in enumerate(cases):
            path = scratch / 'program.b'
            path.write_text(content)
            run(previous / 'front', [path], scratch, scratch / 'raw.ic')
            run(previous / 'resolve', ['-i', 'raw.ic'], scratch, scratch / 'resolved.ic')
            run(previous / 'construct', ['raw.ic', 'resolved.ic', 'data'], scratch, scratch / 'code')
            run(previous / 'image', ['code', 'data', '0', '0'], scratch, scratch / 'program')
            (scratch / 'program').chmod(0o700)
            result = subprocess.run([str(scratch / 'program')], cwd=scratch, env=env,
                                    stdin=subprocess.DEVNULL, capture_output=True, timeout=10)
            assert (result.returncode, result.stdout, result.stderr) == (0, struct.pack('<q', value), b''), (index, content, result)
        print(f'{len(cases)} source programs passed through the final native tools')
        stdio.run_checks(previous, work / 'stdio')
        paths.run_checks(previous, work / 'paths')
        metadata.run_checks(previous, work / 'metadata')
        clock.run_checks(previous, work / 'clock')
        driver = module('native_driver_cases', ROOT / 'test_driver.py')
        driver.run_checks(previous, work / 'driver-checks', source, text)
        for content in ('main(){return(;}', 'main(){return(1);', 'main(){auto;return(0);}'):
            (scratch / 'bad.b').write_text(content)
            result = subprocess.run([str(previous / 'front'), 'bad.b'], cwd=scratch,
                                    env=env, capture_output=True, timeout=10)
            assert result.returncode != 0 and result.stderr, (content, result)
        manifest = {'source_sha256': {name: digest(value.encode()) for name, value in text.items()},
                    'native_fixed_point': manifests[-1],
                    'runtime_sha256': {name: digest(content) for name, content in libraries.items()}}
        if args.output is not None:
            target = args.output.resolve()
            target.mkdir(parents=True, exist_ok=False)
            (target / 'sources').mkdir()
            for name in text:
                shutil.copyfile(previous / name, target / name)
                (target / name).chmod(0o700)
                shutil.copyfile(source / (name + '.b'), target / 'sources' / (name + '.b'))
                assert (target / name).read_bytes() == (previous / name).read_bytes()
                assert (target / 'sources' / (name + '.b')).read_bytes() == (source / (name + '.b')).read_bytes()
            for name in libraries:
                shutil.copyfile(previous / 'sources' / name, target / 'sources' / name)
                assert digest((target / 'sources' / name).read_bytes()) == manifest['runtime_sha256'][name]
            # Written last: absence means the export did not finish.
            (target / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
            print(f'Verified native tools: {target}')
        print(json.dumps(manifest, sort_keys=True))
        print('PASS: five native tools rebuilt twice with identical records, code, data, and executables')


if __name__ == '__main__':
    main()
