#!/usr/bin/env python3
"""Create a native executable with the B image writer inside Unix V1, then run it."""
import fcntl
import os
from pathlib import Path
import shutil
import struct
import subprocess
import sys
import tempfile
import time

ROOT = Path(__file__).resolve().parent
NATIVE = ROOT.parent
V1 = NATIVE.parent / 'unix-v1'
sys.path[:0] = [str(ROOT / 'tools'), str(NATIVE / 'tools')]
from build_passes import snapshot, seed_image, source_text
from build_vm import source_text as engine_source
from v1_files import FileSystem


def child_inode(entries, name):
    matches = [struct.unpack_from('<H', entries, offset)[0]
               for offset in range(0, len(entries), 10)
               if entries[offset + 2:offset + 10].split(b'\0', 1)[0] == name]
    if len(matches) != 1:
        raise AssertionError((name, matches))
    return matches[0]


def main():
    source = source_text('image')
    assembly = (ROOT / 'image/fixtures/hello.s').read_bytes()
    expected = struct.pack('<14H', 0o405, 28, 0, 0, 0, 0,
                           0o12700, 1, 0o104404, 0o40030, 3, 0o104401, 0x4b4f, 10)
    with tempfile.TemporaryDirectory(prefix='bcc-B-image-v1-') as directory:
        work = Path(directory)
        snapshot(work)
        image = seed_image('image', work, source=source)[0]
        (work / 'runner.b').write_text(engine_source())
        (work / 'runner.out').write_bytes(b'')
        with (NATIVE / '.native-build.lock').open('a') as lock:
            fcntl.flock(lock, fcntl.LOCK_EX)
            (V1 / 'fs/usr/tmp').mkdir(parents=True, exist_ok=True)
            files = {'code.vm': image, 'heap.vm': bytes(16384), 'input.s': assembly, 'out': None}
            targets = {V1 / 'fs/usr/tmp' / name: data for name, data in files.items()}
            saved = {p: (p.read_bytes(), p.stat().st_mode & 0o777) if p.exists() else None for p in targets}
            try:
                for path, data in targets.items():
                    if data is None:
                        path.unlink(missing_ok=True)
                    else:
                        path.write_bytes(data)
                subprocess.run(['bash', str(NATIVE / 'tools/v1-run.sh'), str(work / 'runner.b'),
                                '--workdir', '/usr/tmp', '--timings', '--run-timeout=600',
                                '--argument=code.vm', '--argument=out', '--argument=input.s'],
                               env=dict(os.environ, _BCC_NATIVE_LOCKED='1'), check=True, timeout=900)
                fs = FileSystem((V1 / 'images/rk0.dsk').read_bytes())
                actual = fs.read('tmp/out')
                if actual != expected:
                    raise AssertionError(('native bytes', actual, expected))
                _, entries = fs.inode(41)
                _, entries = fs.inode(child_inode(entries, b'tmp'))
                flags, _ = fs.inode(child_inode(entries, b'out'))
                if not flags & 0o20:
                    raise AssertionError(('missing native execute bit', oct(flags)))
                # A second boot checks the saved guest-produced bytes. Restaging
                # maps host permissions separately; the original mode was checked above.
                (V1 / 'fs/usr/tmp/out').write_bytes(actual)
                (V1 / 'fs/usr/tmp/out').chmod(0o755)
                (work / 'execute.b').write_text('main(){extrn execl;execl("./out","out",0);return(1);}\n')
                (work / 'execute.out').write_bytes(b'OK\n')
                subprocess.run(['bash', str(NATIVE / 'tools/v1-run.sh'), str(work / 'execute.b'),
                                '--workdir', '/usr/tmp', '--timings', '--run-timeout=60'],
                               env=dict(os.environ, _BCC_NATIVE_LOCKED='1'), check=True, timeout=300)
                print('PASS: Unix-V1 B image writer, 28 exact bytes, native execute mode and execution', flush=True)
            except BaseException as error:
                failure = NATIVE / 'build/image-v1-failures' / str(time.time_ns())
                failure.mkdir(parents=True)
                (failure / 'failure.txt').write_text(str(error))
                for name in ('rk0.dsk', 'rf0.dsk'):
                    path = V1 / 'images' / name
                    if path.exists():
                        shutil.copy2(path, failure / name)
                raise
            finally:
                for path, previous in saved.items():
                    if previous is None:
                        path.unlink(missing_ok=True)
                    else:
                        path.write_bytes(previous[0])
                        path.chmod(previous[1])
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
