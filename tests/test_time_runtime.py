#!/usr/bin/env python3
"""B72 date buffers and Unix V1 high-word-first 60 Hz time."""
import argparse
from datetime import datetime, timedelta, timezone
from pathlib import Path
import subprocess
import tempfile
import time

EPOCH = datetime(1971, 1, 1, tzinfo=timezone.utc)
TICKS = [0, 59, 60, 65535, 65536, 5183999, 5184000,
         59 * 5184000, 364 * 5184000 + 5183940,
         424 * 5184000 + 123456, 731 * 5184000, 0xffffffff]


def fixture():
    lines = ['/* B72 ctime: zero, boundaries, leap day, and unsigned words. */',
             'main(){auto t 2, date 9, i; extrn ctime,lchar,putchar,char;']
    expected = bytearray()
    months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
    for ticks in TICKS:
        lines += [f't[0]={ticks >> 16}; t[1]={ticks & 65535};',
                  "lchar(date,16,'X'); lchar(date,17,'Y'); ctime(t,date);",
                  'i=0; while(i<18){putchar(char(date,i)); i=i+1;}']
        value = EPOCH + timedelta(seconds=ticks // 60)
        expected += f'{months[value.month-1]} {value.day:2} {value.hour:02}:{value.minute:02}:{value.second:02}'.encode() + b'\0XY'
    lines += ['return(0);}']
    return '\n'.join(lines) + '\n', bytes(expected)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    args = parser.parse_args()
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-time-') as directory:
        root = Path(directory)
        date_source, expected = fixture()
        clock_source = 'main(){auto t 2; extrn time,putchar; if(time(t)<0)return(1); putchar((t[0]>>8)&255); putchar(t[0]&255); putchar((t[1]>>8)&255); putchar(t[1]&255); return(0);}'
        for inline in (False, True):
            for mode in ('host', '16'):
                for name, source in [('ctime', date_source), ('time', clock_source)]:
                    path = root / 'case.b'
                    path.write_text(source)
                    command = [str(args.compiler.resolve()), '--strict', '--pedantic', f'--word={mode}']
                    if inline: command += ['--inline-runtime']
                    build = subprocess.run([*command, str(path), '-o', str(root/'case')], capture_output=True, timeout=30)
                    before = ((time.time_ns() - 31536000 * 1000000000) * 60 // 1000000000) & 0xffffffff
                    run = subprocess.run([str(root/'case')], capture_output=True, input=b'', timeout=10) if build.returncode == 0 else build
                    after = ((time.time_ns() - 31536000 * 1000000000) * 60 // 1000000000) & 0xffffffff
                    ok = run.returncode == 0
                    if name == 'ctime': ok = ok and run.stdout == expected
                    else:
                        ticks = int.from_bytes(run.stdout, 'big')
                        ok = ok and len(run.stdout) == 4 and ((ticks-before)&0xffffffff) <= ((after-before)&0xffffffff)
                    print(f'{"PASS" if ok else "FAIL"}: {"inline" if inline else "shared"}/{mode}/{name}')
                    if not ok: print(run.returncode, repr(run.stdout), repr(run.stderr))
                    passed += ok
                    failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
