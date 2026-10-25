#!/usr/bin/env python3
"""Compact zero reservations must preserve every loadable byte."""
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
from apout_image import native_image
from run_apout import build_snapshot_lock

CASES = [
    ('empty-vector', 'gvp', 0, [], 0),
    ('one-word', 'gvb', 1, [], 2),
    ('partial-scalar', 'gvb', 5, [42], 8),
    ('partial-vector', 'gvp', 5, [42], 8),
    ('extra-initializers', 'gvp', 1, [7, 8], 0),
    ('large-zero-tail', 'gvp', 1024, [7, 8], 2044),
    ('chunk-limit', 'gvb', 8191, [], 16382),
    ('multiple-chunks', 'gvb', 16384, [], 32768),
    ('maximum-field', 'gvb', 32767, [], 65534),
]
RESERVATION = re.compile(rb'\t\.=\.\+(\d+)\.\n')


def main():
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-zero-storage-') as directory:
        work = Path(directory)
        with build_snapshot_lock(ROOT):
            shutil.copytree(ROOT / 'build/aroot', work, dirs_exist_ok=True)
            shutil.copy2(ROOT.parent / 'unix-v1/tools/apout/apout', work / 'apout')
            shutil.copyfile(ROOT / 'build/b1', work / 'b1')
        env = dict(os.environ, APOUT_ROOT=str(work))
        for name, tag, count, values, zero_bytes in CASES:
            source = f'{tag} value {count}\n' + ''.join(f'gvc {value}\n' for value in values) + 'gve\n'
            (work / 'input.ic').write_text(source)
            run = subprocess.run([str(work / 'apout'), str(work / 'b1'), '-i', 'input.ic'],
                                 cwd=work, env=env, capture_output=True, timeout=10)
            reservations = [int(value) for value in RESERVATION.findall(run.stdout)]
            ok = (run.returncode == 0 and not run.stderr and sum(reservations) == zero_bytes
                  and all(0 < value <= 16382 and value % 2 == 0 for value in reservations))
            if count <= 1024 and ok:
                expanded = RESERVATION.sub(lambda match: b'\t0.\n' * (int(match[1]) // 2), run.stdout)
                images = []
                for assembly in (run.stdout, expanded):
                    (work / 'program.s').write_bytes(b'.. = 40014\n.globl start\nstart:\n' + assembly)
                    (work / 'a.out').unlink(missing_ok=True)
                    built = subprocess.run([str(work / 'apout'), str(work / 'bin/as'), 'program.s'],
                                           cwd=work, env=env, capture_output=True, timeout=30)
                    if built.returncode or built.stdout.replace(b'\r\n', b'\n') != b'I\nII\n' or built.stderr:
                        print('assembler:', built.returncode, repr(built.stdout), repr(built.stderr))
                        ok = False
                        break
                    images.append(native_image((work / 'a.out').read_bytes()))
                ok = ok and len(images) == 2 and images[0] == images[1]
            print(f'{"PASS" if ok else "FAIL"}: zero-storage/{name}', flush=True)
            if not ok:
                print(run.returncode, reservations, repr(run.stdout[-1000:]), repr(run.stderr))
            passed += ok
            failed += not ok
        (work / 'input.ic').write_text('gvb value 10\ngvc 1\ngve\ngve\n')
        run = subprocess.run([str(work / 'apout'), str(work / 'b1'), '-i', 'input.ic'],
                             cwd=work, env=env, capture_output=True, timeout=10)
        ok = run.returncode == 0 and RESERVATION.findall(run.stdout) == [b'18']
        print(f'{"PASS" if ok else "FAIL"}: zero-storage/repeated-end', flush=True)
        passed += ok
        failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
