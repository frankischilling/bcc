#!/usr/bin/env python3
"""A second VM invocation must reload code while retaining flushed heap data."""
import os
from pathlib import Path
import struct
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
NATIVE = ROOT.parent
sys.path.insert(0, str(ROOT / 'tools'))
from build_vm import build


def main():
    with tempfile.TemporaryDirectory(prefix='bcc-vm-reentry-') as directory:
        work = Path(directory)
        build(work / 'native', main=ROOT / 'tests/vm_reentry.b')
        build(work / 'host', host=NATIVE.parents[1] / 'bcc', main=ROOT / 'tests/vm_reentry.b')
        (work / 'one.vm').write_bytes(struct.pack('<5h', 1, 42, 3, 16, 0))
        (work / 'two.vm').write_bytes(struct.pack('<5h', 2, 16, 4, 1, 0))
        for model, command in [('native', [str(NATIVE.parent / 'unix-v1/tools/apout/apout'), str(work / 'native')]),
                               ('host16', [str(work / 'host')])]:
            (work / 'heap.vm').write_bytes(bytes(16384))
            result = subprocess.run(command, cwd=work,
                                    env=dict(os.environ, APOUT_ROOT=str(work), APOUT_UNIX_VERSION='V2'),
                                    capture_output=True, timeout=10)
            if (result.returncode, result.stdout, result.stderr) != (0, b'', b''):
                raise AssertionError((model, result))
            print(f'PASS: VM-reentry/{model}', flush=True)
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
