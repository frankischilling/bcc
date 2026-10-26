#!/usr/bin/env python3
"""Run the B-written native code generator inside Unix V1 and compare assembly."""
import fcntl
import os
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
NATIVE = ROOT.parent
V1 = NATIVE.parent / 'unix-v1'
sys.path.insert(0, str(ROOT / 'tools'))
sys.path.insert(0, str(NATIVE / 'tools'))
from build_passes import snapshot, seed_image
from build_vm import source_text
from v1_files import FileSystem

SOURCE = ('data 7;call(n){return(n+2);}main(){extrn data,call;auto p;'
          'p=done;goto p;return(1);done:return(call(data));}\n')


def main():
    with tempfile.TemporaryDirectory(prefix='bcc-B-codegen-v1-') as directory:
        work = Path(directory)
        snapshot(work)
        image = seed_image('codegen', work)[0]
        (work / 'input.b').write_text(SOURCE)
        for binary, flags in [('b00', ['-o', 'raw.ic', 'input.b']),
                              ('b01', ['-i', 'raw.ic', '-o', 'input.ic']),
                              ('b1', ['-i', 'input.ic', '-o', 'ref.s'])]:
            subprocess.run([str(work / 'apout'), str(work / binary), *flags], cwd=work,
                           env=dict(os.environ, APOUT_ROOT=str(work)), check=True, timeout=60)
        (work / 'runner.b').write_text(source_text())
        (work / 'runner.out').write_bytes(b'')
        with (NATIVE / '.native-build.lock').open('a') as lock:
            fcntl.flock(lock, fcntl.LOCK_EX)
            (V1 / 'fs/usr/tmp').mkdir(parents=True, exist_ok=True)
            files = {'code.vm': image, 'heap.vm': bytes(16384),
                     'input.ic': (work / 'input.ic').read_bytes(), 'out.s': None}
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
                                '--argument=code.vm', '--argument=-i', '--argument=input.ic',
                                '--argument=-o', '--argument=out.s'],
                               env=dict(os.environ, _BCC_NATIVE_LOCKED='1'), check=True, timeout=900)
                actual = FileSystem((V1 / 'images/rk0.dsk').read_bytes()).read('tmp/out.s')
                if actual != (work / 'ref.s').read_bytes():
                    raise AssertionError('B-written native assembly differs from the seed')
                print(f'PASS: Unix-V1 B-native code generation, {len(actual)} exact bytes', flush=True)
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
