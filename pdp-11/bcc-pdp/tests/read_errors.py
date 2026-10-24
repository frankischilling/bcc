#!/usr/bin/env python3
"""Inject read failures into the native source and intermediate scanners."""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]
HARNESS = r'''
mode 0;
count 0;
read(fd, buf, size) char buf[]; {
    extern mode, count;
    int mode, count;
    if (mode == 0) return(0);
    if (mode == 1) return(-1);
    if (count == 0) {
        count = 1;
        buf[0] = 'X';
        return(1);
    }
    if (mode == 2) return(0);
    return(-1);
}
main(argc, argv) int argv[]; {
    extern mode;
    int mode, n;
    char p[], buf[16];
    p = argv[1];
    mode = p[0] - '0';
    BODY
    write(1, "OK\n", 3);
    return(0);
}
'''
SOURCE = '''lexini(0);
    n = gtch();
    if (mode >= 2) {
        if (n != 'X') return(1);
        n = gtch();
    }
    if (n != -1) return(1);'''
RECORD = '''icini(0);
    n = getln(buf, 16);
    if (mode == 0) { if (n != 0) return(1); }
    if (mode >= 2) {
        if (n != 1) return(1);
        if (buf[0] != 'X') return(1);
        if (buf[1] != 0) return(1);
    }'''


def main():
    apout = ROOT.parent / 'unix-v1/tools/apout/apout'
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-native-read-') as directory:
        work = Path(directory)
        shutil.copytree(ROOT / 'build/aroot', work, dirs_exist_ok=True)
        env = dict(os.environ, APOUT_ROOT=str(work))
        for scanner, body, diagnostic in [('blex.c', SOURCE, b'cannot read source'),
                                           ('blex1.c', RECORD, b'cannot read IC')]:
            for name in (scanner, 'butil.c'):
                shutil.copyfile(ROOT / 'src' / name, work / name)
            (work / 'probe.c').write_text(HARNESS.replace('BODY', body))
            (work / 'a.out').unlink(missing_ok=True)
            result = subprocess.run([str(apout), str(work / 'bin/cc'), 'probe.c', scanner, 'butil.c'],
                                    cwd=work, env=env, capture_output=True, timeout=60)
            if not (work / 'a.out').is_file():
                print('FAIL: native fault harness build', repr(result.stdout + result.stderr))
                return 1
            for mode in range(4):
                result = subprocess.run([str(apout), str(work / 'a.out'), str(mode)],
                                        cwd=work, env=env, capture_output=True, timeout=10)
                output = result.stdout + result.stderr
                ok = diagnostic in output and b'OK\n' not in output if mode in (1, 3) else result.stdout == b'OK\n'
                print(f'{"PASS" if ok else "FAIL"}: {scanner}/read-mode-{mode}', flush=True)
                if not ok:
                    print(result.returncode, repr(output))
                passed += ok
                failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
