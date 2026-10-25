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


def check_staging(filename, populated):
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
            for name in ('code.vm', 'heap.vm', 'input.b', 'raw.ic', 'code.ic', 'input.ic', 'out.vm', 'out.s', 'input.s', 'out'):
                path = target / name
                path.write_bytes(('original ' + name).encode())
                path.chmod(0o640)
                saved[name] = path.read_bytes()
        calls = []

        def subprocess_run(command, **kwargs):
            if command[0] == 'bash':
                assert target.is_dir()
                assert (target / 'code.vm').is_file()
                assert (target / 'heap.vm').read_bytes() == bytes(16384)
                calls.append(command)
                raise GuestFailure('forced guest failure before images exist')
            work = Path(kwargs['cwd'])
            for name in ('raw.ic', 'code.ic', 'input.ic', 'ref.s'):
                (work / name).write_bytes(b'reference')
            return SimpleNamespace(returncode=0, stdout=b'reference', stderr=b'')

        with contextlib.ExitStack() as stack:
            stack.enter_context(patch.object(module, 'NATIVE', native))
            stack.enter_context(patch.object(module, 'V1', v1))
            stack.enter_context(patch.object(module.subprocess, 'run', subprocess_run))
            stack.enter_context(patch.object(module, 'source_text', lambda *args: 'main(){return(0);}'))
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
        if filename == 'test_image_v1.py':
            reports = list((native / 'build/image-v1-failures').glob('*/failure.txt'))
            assert len(reports) == 1 and 'forced guest failure' in reports[0].read_text()
        print(f'PASS: kernel staging/{filename}/{"existing" if populated else "clean"}')


def main():
    for filename in ('test_passes_v1.py', 'test_codegen_v1.py', 'test_vm_v1.py', 'test_vm_v1_limits.py', 'test_image_v1.py'):
        for populated in (False, True):
            check_staging(filename, populated)
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
    print('Results: 11 passed, 0 failed')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
