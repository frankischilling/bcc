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
    cases = [('b1', 'gw old 0\n', b'bad tag'),
             ('b1', 'ga old 1 1 0\n', b'bad tag'),
             ('b1', 'ep -1\n', b'bad frame size'),
             ('b1', 'ep 8192\n', b'bad frame size'),
             ('b1', 'Glit 257\n', b'literal length too large'),
             ('b1', 'Glit -1\n', b'negative literal length'),
             ('b1', 'gvl -1\n', b'bad literal reference'),
             ('b1', 'gvl 0\n', b'bad literal reference'),
             ('b01', 'Gstr 1 4\n', b'literal outside global definition'),
             ('b01', 'gvb x 0\n', b'unfinished global definition'),
             ('b01', 'gvb x 0\ngvb y 0\n', b'nested global definition'),
             ('b01', 'gve\n', b'global end without definition'),
             ('b01', 'gvc 0\n', b'initializer outside definition'),
             ('b01', 'gvb x 0\n' + 'gvc 0\n'*350 + 'gve\n', b'global records too large'),
             ('b1', 'cl -1\n', b'bad argument count'),
             ('b1', 'cl 8191\n', b'bad argument count'),
             ('b1', 'Slit 257\n', b'literal length too large'),
             ('b1', 'Slit -1\n', b'negative literal length'),
             ('b1', 'swe 1 2 3 33\n', b'bad tag'),
             ('b1', 'swe 1 2 3 -1\n', b'bad tag'),
             ('b1', 'x'*1040+'\n', b'IC line too long'),
             ('b01', 'x'*1040+'\n', b'IC line too long')]
    for record in ('swb -1', 'swc -1 2 3 4', 'swc 1 -2 3 4', 'swc 1 2 3 -4', 'swx -1 2', 'swx 1 -2'):
        cases.append(('b1', record + '\n', b'bad switch label'))
    for record in ('swc 1 2 3', 'swx 1'):
        cases.append(('b1', record + '\n', b'bad IC integer'))
    for integer in ('32768', '-32769', '65536', '-65536', '99999999999999999999'):
        cases.append(('b1', 'n ' + integer + '\n', b'IC integer out of range'))
    for integer in ('', '-', 'x', '1x', '--1'):
        cases.append(('b1', 'n ' + integer + '\n', b'bad IC integer'))
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
        for integer in ('0', '-0', '32767', '-32768', '00032767', '-00032768'):
            source.write_text('n ' + integer + '\n')
            result = subprocess.run([str(apout), str(root/'build/b1'), '-i', source.name],
                                    cwd=directory, env=env, capture_output=True, timeout=5)
            expected = f'\tmov\t${int(integer)}., r0\n'.encode()
            ok = result.returncode == 0 and expected in result.stdout and not result.stderr
            print(f'{"PASS" if ok else "FAIL"}: b1/integer-{integer}')
            if not ok: print(result.returncode, repr(result.stdout), repr(result.stderr))
            passed += ok
            failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
