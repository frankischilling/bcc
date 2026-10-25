#!/usr/bin/env python3
"""Compare a B-written resolver running in the VM with the C-written seed."""
import importlib.util
import os
from pathlib import Path
import subprocess
import sys
import tempfile

BOOTSTRAP = Path(__file__).resolve().parent
NATIVE = BOOTSTRAP.parent
sys.path.insert(0, str(BOOTSTRAP / 'tools'))
from build_vm import build, resolver_image

spec = importlib.util.spec_from_file_location('reference_tests', BOOTSTRAP / 'test_resolver.py')
reference_tests = importlib.util.module_from_spec(spec)
spec.loader.exec_module(reference_tests)


def main():
    passed = failed = rejected = 0
    with tempfile.TemporaryDirectory(prefix='bcc-resolver-vm-') as directory:
        work = Path(directory)
        image, _, _ = resolver_image(work)
        (work / 'code.vm').write_bytes(image)
        build(work / 'native-vm')
        build(work / 'host-vm', host=NATIVE.parents[1] / 'bcc')
        env = dict(os.environ, APOUT_ROOT=str(work), APOUT_UNIX_VERSION='V2')
        cases = []
        for kind in ('run', 'ext'):
            for source in sorted((NATIVE / 'tests' / kind).glob('*.b')):
                (work / 'input.b').write_bytes(source.read_bytes())
                result = subprocess.run([str(work / 'apout'), str(work / 'b00'),
                                         *(['-x'] if kind == 'ext' else []), '-o', 'raw.ic', 'input.b'],
                                        cwd=work, env=env, capture_output=True, timeout=30)
                if result.returncode:
                    rejection = source.with_suffix('.reject')
                    if not rejection.exists() or rejection.read_bytes().strip() not in result.stdout + result.stderr:
                        raise RuntimeError(('reference frontend', source, result))
                    rejected += 1
                    continue
                cases.append((kind + '/' + source.stem, (work / 'raw.ic').read_bytes(), 'compare'))
        cases += [('raw/' + name, text.encode(), diagnostic) for name, text, diagnostic in reference_tests.RAW]
        for name, data, diagnostic in cases:
            (work / 'raw.ic').write_bytes(data)
            reference = subprocess.run([str(work / 'apout'), str(work / 'b01'), '-i', 'raw.ic'],
                                       cwd=work, env=env, capture_output=True, timeout=30)
            for model, command in [('native', [str(work / 'apout'), str(work / 'native-vm')]),
                                   ('host16', [str(work / 'host-vm')])]:
                (work / 'heap.vm').write_bytes(bytes(16384))
                try:
                    result = subprocess.run([*command, 'code.vm', '-i', 'raw.ic'], cwd=work,
                                            env=env, capture_output=True, timeout=120)
                    ok = ((reference.returncode == 0) == (result.returncode == 0)
                          and reference.stdout == result.stdout and reference.stderr == result.stderr)
                    if diagnostic is None:
                        ok = ok and result.returncode == 0
                    elif diagnostic != 'compare':
                        ok = ok and result.returncode != 0 and diagnostic in result.stdout + result.stderr
                except subprocess.TimeoutExpired:
                    ok = False
                    result = None
                print(f'{"PASS" if ok else "FAIL"}: VM-resolver/{model}/{name}', flush=True)
                if not ok:
                    print('reference:', reference.returncode, repr(reference.stdout[-500:]), repr(reference.stderr),
                          'candidate:', None if result is None else (result.returncode, result.stdout[-500:], result.stderr),
                          flush=True)
                passed += ok
                failed += not ok
    print(f'Frontend rejection fixtures excluded: {rejected}')
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
