#!/usr/bin/env python3
"""Check the historical zero/read, nonzero/write contract using the full B word."""
import argparse
from pathlib import Path
import struct
import subprocess
import tempfile

SOURCE = '''main() {
    extrn open, close, read, write, char;
    auto fd, data 2;
    fd = open("file", MODE);
    if (fd < 0) return(1);
    if (MODE == 0) {
        if (read(fd, data, 1) != 1) return(2);
        if (char(data, 0) != 'a') return(3);
        if (write(fd, "Z", 1) != -1) return(4);
    } else {
        if (write(fd, "Z", 1) != 1) return(5);
        if (read(fd, data, 1) != -1) return(6);
    }
    if (close(fd) != 0) return(7);
    if (open("missing", MODE) != -1) return(8);
    return(0);
}
'''


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    compiler = args.compiler.resolve()
    layouts = [('host', False)] if args.bootstrap else [
        (word, inline) for word in ('host', '16', '32') for inline in (False, True)]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-open-') as directory:
        root = Path(directory)
        for word, inline in layouts:
            values = [0, 1, 2, -1, -32768]
            if word != '16':
                values += [65536, -65536]
            if word == 'host' and struct.calcsize('P') > struct.calcsize('i'):
                values += [1 << (8 * struct.calcsize('i')), -(1 << (8 * struct.calcsize('i')))]
            for mode in values:
                work = root / f'{word}-{inline}-{mode}'
                work.mkdir()
                (work/'file').write_bytes(b'abc')
                source = work/'case.b'
                source.write_text(SOURCE.replace('MODE', str(mode)))
                command = [str(compiler), '--strict', '--pedantic']
                if not args.bootstrap:
                    command += [f'--word={word}']
                if inline:
                    command += ['--inline-runtime']
                try:
                    result = subprocess.run([*command, str(source), '-o', str(work/'case')],
                                            capture_output=True, timeout=30)
                    if result.returncode == 0:
                        result = subprocess.run([str(work/'case')], cwd=work,
                                                capture_output=True, timeout=10)
                    expected = b'abc' if mode == 0 else b'Zbc'
                    ok = (result.returncode == 0 and result.stdout == b''
                          and (work/'file').read_bytes() == expected
                          and not (work/'missing').exists())
                    detail = repr((result.returncode, result.stdout, result.stderr[-1500:]))
                except (OSError, subprocess.TimeoutExpired) as error:
                    ok, detail = False, str(error)
                print(f'{"PASS" if ok else "FAIL"}: open/{word}/{"inline" if inline else "shared"}/{mode}', flush=True)
                if not ok:
                    print(detail)
                passed += ok
                failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
