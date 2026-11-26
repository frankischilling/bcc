#!/usr/bin/env python3
"""Check instruction reads above byte offset 32767 in the real V1 kernel."""
import fcntl
import os
from pathlib import Path
import struct
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
NATIVE = ROOT.parent
V1 = NATIVE.parent / 'unix-v1'
sys.path.insert(0, str(ROOT / 'tools'))
from build_vm import source_text


def main():
    body = []
    for byte in b'OK\n':
        body.extend([1, 32711, 8, 1, byte, 8, 10, 1])
    body.extend([1, 0, 0])
    with tempfile.TemporaryDirectory(prefix='bcc-code-limits-v1-') as directory:
        work = Path(directory)
        (work / 'runner.b').write_text(source_text())
        (work / 'runner.out').write_bytes(b'OK\n')
        with (NATIVE / '.native-build.lock').open('a') as lock:
            fcntl.flock(lock, fcntl.LOCK_EX)
            (V1 / 'fs/usr/tmp').mkdir(parents=True, exist_ok=True)
            paths = [V1 / 'fs/usr/tmp' / name for name in ('code.vm', 'heap.vm')]
            saved = {p: (p.read_bytes(), p.stat().st_mode & 0o777) if p.exists() else None for p in paths}
            try:
                for offset in (16383, 16384, 32700 - len(body)):
                    code = [6, offset] + [0] * (offset - 2) + body
                    paths[0].write_bytes(struct.pack('<' + 'H' * len(code), *code))
                    paths[1].write_bytes(bytes(16384))
                    subprocess.run(['bash', str(NATIVE / 'tools/v1-run.sh'), str(work / 'runner.b'),
                                    '--workdir', '/usr/tmp', '--timings', '--argument=code.vm'],
                                   env=dict(os.environ, _BCC_NATIVE_LOCKED='1'), check=True, timeout=600)
                    print(f'PASS: Unix-V1 code offset {offset}, image size {2*len(code)} bytes', flush=True)
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
