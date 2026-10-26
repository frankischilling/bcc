#!/usr/bin/env python3
"""Encoded stack pushes must assemble to the same bytes as MOV instructions."""
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
from apout_image import native_image
from run_apout import build_snapshot_lock

CASES = {
    'arithmetic': 'main() { return((3+5)*(9-2)); }',
    'call': 'add(x,y) { return(x+y); } main() { return(add(3,4)); }',
    'recursion': 'sum(n) { if(n) return(n+sum(n-1)); return(0); } main() { return(sum(5)); }',
    'vector': 'main() { auto v 3; v[0]=7; v[1]=9; return(v[0]+v[1]); }',
    'assignment': 'main() { auto x; x=3; x=+4; return(x); }',
}


def main():
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-compact-push-') as directory:
        work = Path(directory)
        with build_snapshot_lock(ROOT):
            shutil.copytree(ROOT / 'build/aroot', work, dirs_exist_ok=True)
            shutil.copy2(ROOT.parent / 'unix-v1/tools/apout/apout', work / 'apout')
            for name in ('b00', 'b01', 'b1'):
                shutil.copy2(ROOT / 'build' / name, work / name)
        env = dict(os.environ, APOUT_ROOT=str(work))
        def run(binary, *args):
            return subprocess.run([str(work / 'apout'), str(work / binary), *args],
                                  cwd=work, env=env, capture_output=True, timeout=30)
        for name, source in CASES.items():
            (work / 'input.b').write_text(source + '\n')
            ok = True
            for binary, args in [('b00', ['-o', 'raw.ic', 'input.b']),
                                 ('b01', ['-i', 'raw.ic', '-o', 'code.ic']),
                                 ('b1', ['-i', 'code.ic', '-o', 'code.s'])]:
                result = run(binary, *args)
                if result.returncode or result.stderr:
                    print(binary, result.returncode, repr(result.stdout), repr(result.stderr))
                    ok = False
                    break
            if ok:
                compact = (work / 'code.s').read_bytes()
                ok = b'\t10046\n' in compact
                expanded = compact.replace(b'\t10046\n', b'\tmov\tr0, -(sp)\n')
                images = []
                for assembly in (compact, expanded):
                    (work / 'program.s').write_bytes(assembly)
                    (work / 'a.out').unlink(missing_ok=True)
                    result = run('bin/as', 'usr/lib/bmain.s', 'program.s', 'usr/lib/brt.s')
                    if result.returncode or result.stdout.replace(b'\r\n', b'\n') != b'I\nII\n' or result.stderr:
                        print('assembler', result.returncode, repr(result.stdout), repr(result.stderr))
                        ok = False
                        break
                    images.append(native_image((work / 'a.out').read_bytes()))
                ok = ok and len(images) == 2 and images[0] == images[1]
            print(f'{"PASS" if ok else "FAIL"}: compact-push/{name}', flush=True)
            passed += ok
            failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
