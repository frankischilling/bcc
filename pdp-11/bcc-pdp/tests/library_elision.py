#!/usr/bin/env python3
"""Compare host and native decisions to omit the unused B library."""
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
from compile_native import compile_sources
from run_apout import build_snapshot_lock
from runtime_selection import needs_b_library

HARNESS = '''
failmsg(s) char s[]; { exit(1); }
badout(s) char s[]; { exit(1); }
main() {
    extern uselib;
    int uselib;
    selfns("input.s");
    if(uselib) write(1,"yes",3); else write(1,"no",2);
    return(0);
}
'''
CASES = [
    ('empty', b'', False),
    ('primitives', b'\tmov\t$_putchar, r0\n\tjsr pc, *_write\n', False),
    ('printn-call', b'\tjsr pc, *_printn\n', True),
    ('printf-address', b'\tmov\t$_printf, r0\n', True),
    ('getstr-initializer', b'\t[_getstr-start+40014]\\/2\n', True),
    ('ctime-definition', b'_ctime:\n\t.+2\n', True),
    ('prefix', b'\tmov $_ctimex, r0\n', False),
    ('suffix', b'\tmov $foo_ctime, r0\n', False),
    ('underscore', b'\tmov $_printf_extra, r0\n', False),
    ('case', b'\tmov $_PRINTF, r0\n', False),
    ('bare-token', b'_printn', True),
    ('short-token', b'_pri\n', False),
    ('line-limit', b'/' + b'x'*1037 + b'\n', False),
    ('split-line', b'/' + b'x'*1038 + b'\n', True),
    ('split-reference', b' '*1036 + b'_printf\n', True),
    ('tail-limit', b'x'*1039, False),
    ('tail-over-limit', b'x'*1040, True),
    ('carriage-returns', b'\r'*1040, True),
    ('many-lines', b'\tmov $0, r0\n'*200, False),
]


def main():
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-library-elision-') as directory:
        work = Path(directory)
        with build_snapshot_lock(ROOT):
            shutil.copytree(ROOT / 'build/aroot', work, dirs_exist_ok=True)
            shutil.copy2(ROOT.parent / 'unix-v1/tools/apout/apout', work / 'apout')
            shutil.copyfile(ROOT / 'src/bsel.c', work / 'bsel.c')
        (work / 'probe.c').write_text(HARNESS)
        compile_sources(work, work / 'apout', ['probe.c', 'bsel.c'])
        env = dict(os.environ, APOUT_ROOT=str(work))
        for name, assembly, needed in CASES:
            (work / 'input.s').write_bytes(assembly)
            run = subprocess.run([str(work / 'apout'), str(work / 'a.out')], cwd=work,
                                 env=env, capture_output=True, timeout=10)
            expected = b'yes' if needed else b'no'
            ok = (needs_b_library(assembly) == needed and run.returncode == 0
                  and run.stdout == expected and not run.stderr)
            print(f'{"PASS" if ok else "FAIL"}: library-elision/{name}', flush=True)
            if not ok:
                print(needs_b_library(assembly), run.returncode, repr(run.stdout), repr(run.stderr))
            passed += ok
            failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
