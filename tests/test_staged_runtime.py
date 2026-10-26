#!/usr/bin/env python3
"""Check that staged assembly builds restore every copied runtime file."""
from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]
FILES = ('libb.c', 'libb.h', 'btarget.h', 'binit.h', 'bcall.h', 'bunix.h',
         'bformat.h', 'bprimitives.h')


def main():
    with tempfile.TemporaryDirectory(prefix='bcc-staged-runtime-') as directory:
        stage = Path(directory) / 'stage'
        command = ['make', '-C', str(ROOT / 'asm/bootstrap'),
                   'STAGE=' + str(stage), 'runtime']

        def refresh():
            subprocess.run(command, check=True, capture_output=True, timeout=30)
            for name in FILES:
                assert (stage / 'lib' / name).read_bytes() == (ROOT / 'lib' / name).read_bytes(), name

        refresh()
        for name in FILES:
            target = stage / 'lib' / name
            target.unlink()
            refresh()
            target.write_text('stale runtime copy\n')
            refresh()
    print('17 staged runtime refresh checks passed')


if __name__ == '__main__':
    main()
