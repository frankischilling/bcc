#!/usr/bin/env python3
"""Reject oversized internal records before writing past fixed V1 buffers."""
import os
from pathlib import Path
import subprocess
import tempfile


def main():
    root = Path(__file__).resolve().parents[1]
    apout = root.parent / 'unix-v1/tools/apout/apout'
    env = dict(os.environ, APOUT_ROOT=str(root/'build/aroot'))
    cases = [('b1', 'cl -1\n', b'bad argument count'),
             ('b1', 'cl 8191\n', b'bad argument count'),
             ('b1', 'Slit 257\n', b'literal length too large'),
             ('b1', 'Slit -1\n', b'negative literal length'),
             ('b1', 'swe 1 2 3 33\n', b'too many cases'),
             ('b1', 'swe 1 2 3 -1\n', b'negative case count'),
             ('b1', 'x'*1040+'\n', b'IC line too long'),
             ('b01', 'x'*1040+'\n', b'IC line too long')]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-v1-ic-') as directory:
        for index, (binary, content, diagnostic) in enumerate(cases):
            source = Path(directory)/'input.ic'
            source.write_text(content)
            result = subprocess.run([str(apout), str(root/'build'/binary), '-i', source.name], cwd=directory, env=env, capture_output=True, timeout=5)
            ok = result.returncode != 0 and diagnostic in result.stdout + result.stderr
            print(f'{"PASS" if ok else "FAIL"}: {binary}/record-{index}')
            if not ok: print(result.returncode, repr(result.stdout), repr(result.stderr))
            passed += ok
            failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
