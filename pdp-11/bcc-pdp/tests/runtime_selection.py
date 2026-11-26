#!/usr/bin/env python3
"""Check that library selection removes labels, never retained code bytes."""
from pathlib import Path
import sys
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'tools'))
from runtime_selection import select_runtime


def main():
    cases = [
        (b'_f:\n\t.+2\n', b'_g:\n\t.+2\n\trts pc\n', b'_g:\n\t.+2\n\trts pc\n'),
        (b'_f:\n\t.+2\n', b'_f:\n\t.+2\n\trts pc\n', b'\t.+2\n\trts pc\n'),
        (b'_f:\n\t.+2\n', b'_alias:\n\t.+4\n_f:\n\t.+2\n\trts pc\n', b'_alias:\n\t.+4\n\t.+2\n\trts pc\n'),
        (b'_f:\n\t123.\n', b'_f:\n\t.+2\n', b'\t.+2\n'),
        (b'\t.globl _f\n', b'_f:\n\t.+2\n', b'_f:\n\t.+2\n'),
        (b'L1:\n\t.+2\n', b'L1:\n\t.+2\n', b'L1:\n\t.+2\n'),
        (b'_f:\r\n\t.+2\r\n', b'_f:\r\n\t.+2\r\n', b'\t.+2\r\n'),
        (b'_f:\n\t.+2\n_g:\n\t.+2\n', b'_f:\n\t.+2\n_g:\n\t.+2\n', b'\t.+2\n\t.+2\n'),
        (b'_f:\n\t.+2\n', b'\t.globl _f\n_f:\n\t.+2\n', b'\t.globl _f\n\t.+2\n'),
    ]
    passed=failed=0
    for i,(program,runtime,expected) in enumerate(cases):
        actual=select_runtime(program,runtime)
        ok=actual==expected
        print(f'{"PASS" if ok else "FAIL"}: runtime-selection/{i}')
        if not ok: print(repr(actual),repr(expected))
        passed+=ok;failed+=not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__=='__main__': raise SystemExit(main())
