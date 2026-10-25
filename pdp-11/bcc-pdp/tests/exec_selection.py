#!/usr/bin/env python3
"""Exec buffers may be omitted only when program and retained library do not use them."""
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
from runtime_selection import needs_b_library, needs_exec_runtime, select_primitive_runtime

HARNESS = '''
failmsg(s) char s[]; { exit(1); }
badout(s) char s[]; { exit(1); }
main() {
    extern uselib, usexec;
    int uselib, usexec;
    selfns("input.s");
    if(uselib) selfex("library.s");
    selfil("runtime.s","selected.s",!usexec);
    if(usexec) write(1,"yes",3); else write(1,"no",2);
    return(0);
}
'''
RUNTIME = (b'/ base\n_keep:\n\t.+2\n/ bcc-exec-begin\n'
           b'.globl _execv\n_execv:\n\t.+2\n\trts pc\n/ bcc-exec-end\n'
           b'/ shared\n/ bcc-exec-begin\n.buf: .=.+12.\n/ bcc-exec-end\n/ end\n')
CASES = [
    ('unused', b'', b'', RUNTIME, False),
    ('call', b'jsr pc, *_execv\n', b'', RUNTIME, True),
    ('address', b'mov $_execl, r0\n', b'', RUNTIME, True),
    ('override', b'_execv:\n\t.+2\n', b'', RUNTIME, True),
    ('prefix', b'mov $_execvx, r0\n', b'', RUNTIME, False),
    ('suffix', b'mov $foo_execv, r0\n', b'', RUNTIME, False),
    ('unused-library', b'', b'jsr pc, *_execv\n', RUNTIME, False),
    ('library-call', b'mov $_printf, r0\n', b'jsr pc, *_execv\n', RUNTIME, True),
    ('library-address', b'mov $_printn, r0\n', b'_execl\n', RUNTIME, True),
    ('library-without-exec', b'mov $_getstr, r0\n', b'_write\n', RUNTIME, False),
    ('split-program', b'x'*1040, b'', RUNTIME, True),
    ('tail-limit', b'x'*1039, b'', RUNTIME, False),
    ('split-library', b'_ctime\n', b'x'*1040, RUNTIME, True),
    ('crlf', b'', b'', RUNTIME.replace(b'\n', b'\r\n'), False),
    ('marker-whitespace', b'', b'', RUNTIME.replace(b'begin\n', b'begin \t\n'), False),
    ('unmarked-runtime', b'', b'', b'_execv:\n\t.+2\n', False),
    ('nested', b'', b'', b'/ bcc-exec-begin\n/ bcc-exec-begin\n', None),
    ('unmatched-end', b'', b'', b'/ bcc-exec-end\n', None),
    ('unfinished', b'', b'', b'/ bcc-exec-begin\n', None),
]


def main():
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-exec-selection-') as directory:
        work = Path(directory)
        with build_snapshot_lock(ROOT):
            shutil.copytree(ROOT / 'build/aroot', work, dirs_exist_ok=True)
            shutil.copy2(ROOT.parent / 'unix-v1/tools/apout/apout', work / 'apout')
            shutil.copyfile(ROOT / 'src/bsel.c', work / 'bsel.c')
        (work / 'probe.c').write_text(HARNESS)
        compile_sources(work, work / 'apout', ['probe.c', 'bsel.c'])
        env = dict(os.environ, APOUT_ROOT=str(work))
        for name, program, library, runtime, needed in CASES:
            (work / 'input.s').write_bytes(program)
            (work / 'library.s').write_bytes(library)
            (work / 'runtime.s').write_bytes(runtime)
            (work / 'selected.s').unlink(missing_ok=True)
            run = subprocess.run([str(work / 'apout'), str(work / 'a.out')], cwd=work,
                                 env=env, capture_output=True, timeout=10)
            kept_library = library if needs_b_library(program) else b''
            try:
                selected = select_primitive_runtime(program, runtime, kept_library)
            except ValueError:
                ok = needed is None and run.returncode != 0 and not (work / 'selected.s').exists()
            else:
                native = (work / 'selected.s').read_bytes() if (work / 'selected.s').exists() else runtime
                ok = (needed is not None and needs_exec_runtime(program, kept_library) == needed
                      and run.returncode == 0 and run.stdout == (b'yes' if needed else b'no')
                      and not run.stderr and native == selected)
                if not needed and name != 'unmarked-runtime':
                    ok = ok and b'_execv' not in selected and b'.buf' not in selected
            print(f'{"PASS" if ok else "FAIL"}: exec-selection/{name}', flush=True)
            if not ok:
                print(run.returncode, repr(run.stdout), repr(run.stderr))
            passed += ok
            failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
