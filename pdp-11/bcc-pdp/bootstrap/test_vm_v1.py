#!/usr/bin/env python3
"""Run the B-written resolver through the experimental VM inside Unix V1."""
import fcntl
import os
from pathlib import Path
import subprocess
import sys
import tempfile

BOOTSTRAP = Path(__file__).resolve().parent
NATIVE = BOOTSTRAP.parent
V1 = NATIVE.parent / 'unix-v1'
sys.path.insert(0, str(BOOTSTRAP / 'tools'))
sys.path.insert(0, str(NATIVE / 'tools'))
from build_vm import resolver_image, source_text
from v1_files import FileSystem

CASES = {
    'return': 'Adef main\nn 42\nrt\nAend\n',
    'global-literal': 'gvb text 1\nGstr 4 65 0 255 4\ngve\nAdef main\nAextrn text\nRname text\nRderef\nrt\nAend\n',
    'labels-locals': 'Adef main\nAauto local\nRname done\ngor\nRdef done\nRname local\nn 7\nrt\nAend\n',
}


def main():
    with tempfile.TemporaryDirectory(prefix='bcc-vm-kernel-') as directory:
        work = Path(directory)
        image, _, _ = resolver_image(work)
        (work / 'runner.b').write_text(source_text())
        (work / 'runner.out').write_bytes(b'')
        with (NATIVE / '.native-build.lock').open('a') as lock:
            fcntl.flock(lock, fcntl.LOCK_EX)
            targets = [V1 / 'fs/usr/tmp' / name for name in ('code.vm', 'heap.vm', 'raw.ic')]
            saved = {p: (p.read_bytes(), p.stat().st_mode & 0o777) if p.exists() else None for p in targets}
            try:
                for name, source in CASES.items():
                    (work / 'raw.ic').write_text(source)
                    reference = subprocess.run([str(work / 'apout'), str(work / 'b01'), '-i', 'raw.ic'],
                                               cwd=work, env=dict(os.environ, APOUT_ROOT=str(work)),
                                               capture_output=True, timeout=30, check=True)
                    if reference.stderr:
                        raise RuntimeError(reference.stderr)
                    for target, data in zip(targets, (image, bytes(16384), source.encode())):
                        target.write_bytes(data)
                    command = ['bash', str(NATIVE / 'tools/v1-run.sh'), str(work / 'runner.b'),
                               '--workdir', '/usr/tmp', '--timings', '--argument=code.vm',
                               '--argument=-i', '--argument=raw.ic', '--argument=-o', '--argument=out.ic']
                    subprocess.run(command, env=dict(os.environ, _BCC_NATIVE_LOCKED='1'), check=True, timeout=600)
                    actual = FileSystem((V1 / 'images/rk0.dsk').read_bytes()).read('tmp/out.ic')
                    if actual != reference.stdout:
                        raise AssertionError((name, actual, reference.stdout))
                    print('PASS: kernel B-resolver/' + name, flush=True)
            finally:
                for target, backup in saved.items():
                    if backup is None:
                        target.unlink(missing_ok=True)
                    else:
                        target.write_bytes(backup[0])
                        target.chmod(backup[1])
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
