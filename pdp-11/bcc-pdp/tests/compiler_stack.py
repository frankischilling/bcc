#!/usr/bin/env python3
"""Check the parser's linked storage boundary and reserved diagnostic stack."""
import os
from pathlib import Path
import re
import shutil
import struct
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]
PROBE = '''main(argc, argv) int argv[]; {
    extern stkend;
    int stkend, mode;
    char p[];
    if (argc != 2) return(1);
    p = argv[1]; mode = p[0] - '0';
    stkini();
    if (mode == 0) { write(1, &stkend, 2); return(0); }
    if (mode == 1) stkuse(stkend + 127);
    if (mode == 2) stkuse(stkend + 128);
    if (mode == 3) stkuse(stkend - 1);
    if (mode == 4) stkuse(-100);
    if (mode == 5) stkuse(0);
    write(1, "OK\\n", 3);
    return(0);
}
'''


def main():
    apout = ROOT.parent/'unix-v1/tools/apout/apout'
    sources = re.search(r'^B00_SRCS = (.+)$', (ROOT/'Makefile').read_text(), re.M).group(1).split()
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-compiler-stack-') as directory:
        work = Path(directory)
        shutil.copytree(ROOT/'build/aroot', work, dirs_exist_ok=True)
        for name in sources:
            text = (ROOT/'src'/name).read_text()
            if name == 'b00drv.c':
                assert text.count('main(argc, argv)') == 1
                text = text.replace('main(argc, argv)', 'oldmn(argc, argv)')
            (work/name).write_text(text)
        (work/'probe.c').write_text(PROBE)
        (work/'a.out').unlink(missing_ok=True)
        env = dict(os.environ, APOUT_ROOT=str(work))
        result = subprocess.run([str(apout), str(work/'bin/cc'), 'probe.c', *sources],
                                cwd=work, env=env, capture_output=True, timeout=60)
        expected_log = ''.join(name+':\nI\nII\n' for name in ['probe.c', *sources]).encode()
        if result.stdout != expected_log or result.stderr or not (work/'a.out').is_file():
            print('FAIL: stack probe compilation', result.returncode, repr(result.stdout), repr(result.stderr))
            return 1
        image = (work/'a.out').read_bytes()
        magic, text, data, bss = struct.unpack_from('<4H', image)
        if magic != 0o407 or len(image) < 16 + text + data:
            print('FAIL: stack probe image')
            return 1
        expected_end = 0o40000 + text + data + bss
        for mode in range(6):
            result = subprocess.run([str(apout), str(work/'a.out'), str(mode)], cwd=work,
                                    env=env, capture_output=True, timeout=10)
            output = result.stdout + result.stderr
            if mode == 0:
                ok = result.stdout == struct.pack('<H', expected_end) and not result.stderr
            elif mode in (1, 3, 5):
                ok = b'compiler stack exhausted' in output and b'OK\n' not in output
            else:
                ok = result.stdout == b'OK\n' and not result.stderr
            print(f'{"PASS" if ok else "FAIL"}: compiler-stack/{mode}', flush=True)
            if not ok: print('image end:', expected_end, 'actual:', repr(output))
            passed += ok; failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
