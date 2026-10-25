#!/usr/bin/env python3
"""Fuse only adjacent address/load records; flush addresses at every boundary."""
import os
from pathlib import Path
import subprocess
import tempfile


def main():
    root = Path(__file__).resolve().parents[1]
    apout = root.parent / 'unix-v1/tools/apout/apout'
    env = dict(os.environ, APOUT_ROOT=str(root/'build/aroot'))
    local = b'\tmov\tr5, r0\n\tsub\t$2., r0\n\tasr\tr0\n'
    argument = b'\tmov\tr5, r0\n\tadd\t$4., r0\n\tasr\tr0\n'
    external = b'\tmov\t$_value, r0\n\tasr\tr0\n'
    deref = b'\tasl\tr0\n\tmov\t(r0), r0\n'
    end = b'\n.globl .bend\n.bend:\n'
    cases = [
        ('local', 'lc 0\ndr\n', b'\tmov\t-2.(r5), r0\n'),
        ('second-local', 'lc 1\ndr\n', b'\tmov\t-4.(r5), r0\n'),
        ('argument', 'ar 0\ndr\n', b'\tmov\t4.(r5), r0\n'),
        ('third-argument', 'ar 2\ndr\n', b'\tmov\t8.(r5), r0\n'),
        ('external', 'ex value\ndr\n', b'\tmov\t_value, r0\n'),
        ('local-eof', 'lc 0\n', local),
        ('argument-eof', 'ar 0\n', argument),
        ('external-eof', 'ex value\n', external),
        ('successive-addresses', 'ex value\nex other\ndr\n', external+b'\tmov\t_other, r0\n'),
        ('label-boundary', 'lc 0\nlb 9\ndr\n', local+b'L9:\n'+deref),
        ('overwritten-value', 'lc 0\nn 5\ndr\n', local+b'\tmov\t$5., r0\n'+deref),
        ('saved-address', 'ar 0\nps\n', argument+b'\tmov\tr0, -(sp)\n'),
        ('double-indirection', 'ex value\ndr\ndr\n', b'\tmov\t_value, r0\n'+deref),
        ('local-and-argument', 'lc 0\ndr\nar 0\ndr\n', b'\tmov\t-2.(r5), r0\n\tmov\t4.(r5), r0\n'),
    ]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-direct-loads-') as directory:
        work = Path(directory)
        for name, source, expected in cases:
            (work/'input.ic').write_text(source)
            result = subprocess.run([str(apout),str(root/'build/b1'),'-i','input.ic'],
                                    cwd=work,env=env,capture_output=True,timeout=10)
            ok = result.returncode == 0 and result.stdout == expected+end and not result.stderr
            print(f'{"PASS" if ok else "FAIL"}: direct-load/{name}')
            if not ok: print(result.returncode,repr(result.stdout),repr(result.stderr))
            passed += ok; failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
