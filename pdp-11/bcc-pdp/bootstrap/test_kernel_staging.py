#!/usr/bin/env python3
"""Kernel tests must stage clean trees and preserve their original failures."""
import contextlib
import importlib.util
import io
from pathlib import Path
import re
import sys
import tempfile
from types import SimpleNamespace
from unittest.mock import patch

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[2]


class GuestFailure(RuntimeError):
    pass


def check_staging(filename, populated, self_test=False):
    spec = importlib.util.spec_from_file_location('kernel_case', ROOT / filename)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    with tempfile.TemporaryDirectory(prefix='bcc-kernel-stage-') as directory:
        base = Path(directory)
        native = base / 'native'
        native.mkdir()
        v1 = base / 'unix-v1'
        target = v1 / 'fs/usr/tmp'
        saved = {}
        if populated:
            target.mkdir(parents=True)
            for name in ('code.vm', 'heap.vm', 'input.b', 'raw.ic', 'code.ic', 'input.ic', 'out.vm', 'out.s', 'input.s', 'out', 'engine', 'front.vm', 'resolve', 'codegen', 'select', 'runtime', 'image', 'encoder', 'libb.b', 'bmain.s', 'brt.s', 'libb.s', 'prog.s', 'selrt.s', 'sellib.s', 'done', 'longout', 'driver', 'bf.b', 'br.b', 'bg.b', 'bs.b', 'rt.b', 'bi.b', 'be.b', 'vm.b', 'bdrv.b', 'rstart', 'rprim', 'rlib', 'fron.new', 'reso.new', 'code.new', 'sele.new', 'runt.new', 'imag.new', 'enco.new', 'drv.new', 'eng.new'):
                path = target / name
                path.write_bytes(('original ' + name).encode())
                path.chmod(0o640)
                saved[name] = path.read_bytes()
        calls = []

        def subprocess_run(command, **kwargs):
            if command[0] == 'bash':
                assert target.is_dir()
                if filename == 'test_toolchain_v1.py':
                    assert (target / 'engine').is_file()
                    assert not (target / 'heap.vm').exists()
                    if self_test:
                        for name in ('fron.new', 'reso.new', 'code.new', 'sele.new', 'runt.new', 'imag.new', 'enco.new', 'drv.new', 'eng.new'):
                            assert not (target / name).exists()
                        assert '--run-timeout=86400' in command
                        assert kwargs['timeout'] == 86700
                        assert (target / 'bf.b').is_file()
                        assert (target / 'rstart').is_file()
                else:
                    assert (target / 'code.vm').is_file()
                    assert (target / 'heap.vm').read_bytes() == bytes(16384)
                calls.append(command)
                raise GuestFailure('forced guest failure before images exist')
            if '--emit-image' in command:
                Path(command[command.index('--emit-image') + 1]).write_bytes(b'reference')
                return SimpleNamespace(returncode=0, stdout=b'', stderr=b'')
            work = Path(kwargs['cwd'])
            for name in ('raw.ic', 'code.ic', 'input.ic', 'ref.s'):
                (work / name).write_bytes(b'reference')
            return SimpleNamespace(returncode=0, stdout=b'reference', stderr=b'')

        with contextlib.ExitStack() as stack:
            stack.enter_context(patch.object(module, 'NATIVE', native))
            stack.enter_context(patch.object(module, 'V1', v1))
            stack.enter_context(patch.object(module.subprocess, 'run', subprocess_run))
            if hasattr(module, 'source_text'):
                stack.enter_context(patch.object(module, 'source_text', lambda *args: 'main(){return(0);}'))
            if filename == 'test_toolchain_v1.py':
                def seed_build(path):
                    path.mkdir()
                    (path / 'bdrv.b').write_text('main(){return(0);}')
                    for name in ('engine', 'front.vm', 'resolve', 'codegen', 'select', 'runtime', 'image', 'encoder', 'libb.b', 'bmain.s', 'brt.s', 'libb.s', 'driver', 'bf.b', 'br.b', 'bg.b', 'bs.b', 'rt.b', 'bi.b', 'be.b', 'vm.b'):
                        (path / name).write_bytes(b'reference')
                stack.enter_context(patch.object(module, 'build', seed_build))
            if hasattr(module, 'engine_source'):
                stack.enter_context(patch.object(module, 'engine_source', lambda: 'main(){return(0);}'))
            if hasattr(module, 'snapshot'):
                stack.enter_context(patch.object(module, 'snapshot', lambda work: None))
            if hasattr(module, 'seed_image'):
                stack.enter_context(patch.object(module, 'seed_image', lambda *a, **k: (b'image', 0, 0)))
            if hasattr(module, 'resolver_image'):
                stack.enter_context(patch.object(module, 'resolver_image', lambda work: (b'image', 0, 0)))
            if hasattr(module, 'encode'):
                stack.enter_context(patch.object(module, 'encode', lambda source: (b'image', 0, 0)))
            arguments = [filename]
            if self_test:
                arguments.append('--self-test')
            if filename == 'test_passes_v1.py':
                arguments += ['--case', 'calls', '--failure-dir', str(base / 'failures')]
            stack.enter_context(patch.object(sys, 'argv', arguments))
            with contextlib.redirect_stdout(io.StringIO()):
                try:
                    module.main()
                except GuestFailure as error:
                    assert str(error) == 'forced guest failure before images exist'
                else:
                    raise AssertionError('guest failure was swallowed')
        assert len(calls) == 1
        assert {path.name for path in target.iterdir()} == set(saved)
        for name, data in saved.items():
            assert (target / name).read_bytes() == data
            assert (target / name).stat().st_mode & 0o777 == 0o640
        if filename == 'test_passes_v1.py':
            reports = list((base / 'failures').glob('*/failure.txt'))
            assert len(reports) == 1 and 'forced guest failure' in reports[0].read_text()
        if filename in ('test_image_v1.py', 'test_toolchain_v1.py'):
            folder = 'image-v1-failures' if filename == 'test_image_v1.py' else 'toolchain-v1-failures'
            reports = list((native / 'build' / folder).glob('*/failure.txt'))
            assert len(reports) == 1 and 'forced guest failure' in reports[0].read_text()
        print(f'PASS: kernel staging/{filename}/{"existing" if populated else "clean"}')


def main():
    for filename in ('test_passes_v1.py', 'test_codegen_v1.py', 'test_vm_v1.py', 'test_vm_v1_limits.py', 'test_image_v1.py', 'test_toolchain_v1.py'):
        for populated in (False, True):
            check_staging(filename, populated)
    for populated in (False, True):
        check_staging('test_toolchain_v1.py', populated, self_test=True)
    workflow = (PROJECT / '.github/workflows/conformance.yml').read_text()
    count = 0
    for line in workflow.splitlines():
        if '--expect-compile-error' not in line:
            continue
        match = re.search(r'(pdp-11/bcc-pdp/tests/run/[^\s]+\.b)', line)
        if match:
            source = PROJECT / match[1]
            assert source.with_suffix('.reject').is_file(), f'expected failure lacks a rejection fixture: {source.name}'
            count += 1
    assert count
    print(f'PASS: workflow rejection expectations ({count} fixtures)')
    print('Results: 15 passed, 0 failed')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
