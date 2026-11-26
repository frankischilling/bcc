#!/usr/bin/env python3
"""Saving an image must not execute it or overwrite the B source."""
import os
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
from apout_image import test_image


def main():
    with tempfile.TemporaryDirectory(prefix='bcc-emit-image-') as directory:
        work = Path(directory)
        source = work / 'source.b'
        source.write_text('main(){extrn putchar;putchar(65);return(7);}\n')
        command = [sys.executable, str(ROOT / 'tools/run_apout.py')]
        for raw, name in ((False, 'observer'), (True, 'kernel')):
            image = work / name
            result = subprocess.run([*command, '--emit-image', str(image), *(['--raw-v1'] if raw else []), str(source)],
                                    cwd=work, capture_output=True, timeout=90)
            assert result.returncode == 0 and not result.stdout, result
            assert image.is_file()
        assert (work / 'observer').read_bytes() == test_image((work / 'kernel').read_bytes())
        result = subprocess.run([str(ROOT.parent / 'unix-v1/tools/apout/apout'), str(work / 'observer')],
                                cwd=work, env=dict(os.environ, APOUT_UNIX_VERSION='V2', APOUT_ROOT=str(work)),
                                capture_output=True, timeout=10)
        assert (result.returncode, result.stdout, result.stderr) == (7, b'A', b''), result
        saved = source.read_bytes()
        for args in ([str(source), str(source)], [str(work / 'absent'), str(source), 'extra']):
            result = subprocess.run([*command, '--emit-image', *args], cwd=work, capture_output=True, timeout=10)
            assert result.returncode != 0
        assert source.read_bytes() == saved and not (work / 'absent').exists()
    print('PASS: image emission, equivalent headers, execution, and argument guards')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
