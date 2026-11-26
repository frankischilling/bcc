#!/usr/bin/env python3
"""Check B-native 60-Hz clocks and the fixed-size date conversion buffer."""
import argparse
from datetime import datetime, timedelta, timezone
import os
from pathlib import Path
import subprocess
import tempfile
import time as clock

ROOT = Path(__file__).resolve().parent
EPOCH = datetime(1971, 1, 1, tzinfo=timezone.utc)
EPOCH_NS = 31536000 * 1_000_000_000
TICKS = {0, 59, 60, 65535, 65536, 5183999, 5184000, 0xffffffff}
for year in (1971, 1972, 1973):
    for month in range(1, 13):
        tick = int((datetime(year, month, 1, tzinfo=timezone.utc) - EPOCH).total_seconds()) * 60
        for value in (tick - 1, tick, tick + (12 * 3600 + 34 * 60 + 56) * 60):
            if 0 <= value <= 0xffffffff:
                TICKS.add(value)
MONTHS = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')


def date_bytes(ticks):
    value = EPOCH + timedelta(seconds=ticks // 60)
    return f'{MONTHS[value.month-1]} {value.day:2} {value.hour:02}:{value.minute:02}:{value.second:02}'.encode() + b'\0'


def date_fixture():
    lines = ['main(){extrn ctime,write;auto t 2,d 3;']
    expected = bytearray()
    for ticks in sorted(TICKS):
        lines += [f't[0]={ticks >> 16};t[1]={ticks & 65535};d[2]=123;',
                  'if(ctime(t,d))return(1);if(d[2]!=123)return(2);if(write(1,d,16)!=16)return(3);']
        expected += date_bytes(ticks)
    lines.append('return(0);}')
    return '\n'.join(lines), bytes(expected)


CLOCK_SOURCE = ('main(){extrn time,putchar;auto t 4;t[0]=123;t[3]=124;'
                'if(time(t+1))return(1);if(t[0]!=123 | t[3]!=124)return(2);'
                'putchar((t[1]>>8)&255);putchar(t[1]&255);'
                'putchar((t[2]>>8)&255);putchar(t[2]&255);return(0);}')
CASES = [
    ('private-packing', 'char(s,i){return(4);}lchar(s,i,c){return(0);}main(){extrn ctime,write;auto t 2,d 3;t[0]=0;t[1]=0;d[2]=123;if(ctime(t,d) | d[2]!=123)return(1);write(1,d,16);return(0);}', date_bytes(0), True),
    ('alias', 'main(){extrn ctime,write;auto t 3;t[0]=65535;t[1]=65535;t[2]=123;if(ctime(t,t) | t[2]!=123)return(1);write(1,t,16);return(0);}', date_bytes(0xffffffff), True),
    ('masked-words', 'main(){extrn ctime,write;auto t 2,d 2;t[0]= -1;t[1]= -1;if(ctime(t,d))return(1);write(1,d,16);return(0);}', date_bytes(0xffffffff), True),
    ('nulls', 'main(){extrn time,ctime;auto t 2;return(time(0)==0 & ctime(0,t)==-1 & ctime(t,0)==-1?0:1);}', b'', True),
    ('saved-date', 'other(t,d){return(42);}main(){extrn ctime,other,write;auto old,t 2,d 2;t[0]=0;t[1]=0;old=ctime;ctime=other;if(old(t,d) | ctime(0,0)!=42)return(1);write(1,d,16);return(0);}', date_bytes(0), True),
    ('source-definitions', 'time(t){return(42);}ctime(t,d){return(43);}main(){return(time(0)==42 & ctime(0,0)==43?0:1);}', b'', True),
    ('missing-arguments', 'main(){extrn time,ctime;return(time()==-1 & ctime()==-1 & ctime(0)==-1?0:1);}', b'', False),
    ('clock-failure', '__sys(n,a,b,c,d,e,f){return(-1);}main(){extrn time;auto t 2;t[0]=123;t[1]=124;if(time(t)!=-1)return(1);return(t[0]==123 & t[1]==124?0:2);}', b'', False),
    ('clock-wrap', '__sys(n,a,b,c,d,e,f){auto p;if(n!=228 | a!=0)return(-1);p=b>>3;p[0]=31535999;p[1]=500000000;return(0);}main(){extrn time;auto t 2;if(time(t))return(1);return(t[0]==65535 & t[1]==65506?0:2);}', b'', False),
]


def checks(build, work, reference):
    work = Path(work)
    work.mkdir(parents=True)
    source, expected = date_fixture()
    programs = [('dates', source, expected, True), *CASES, ('clock', CLOCK_SOURCE, None, True)]
    count = 0
    for name, source, expected, compare in programs:
        if reference and not compare:
            continue
        path = work / (name + '.b')
        program = work / name
        path.write_text(source)
        build(path.resolve(), program.resolve())
        before = ((clock.time_ns() - EPOCH_NS) * 60 // 1_000_000_000) & 0xffffffff
        run = subprocess.run([str(program.resolve())], cwd=work, env=dict(os.environ, PATH=''),
                             capture_output=True, timeout=10)
        after = ((clock.time_ns() - EPOCH_NS) * 60 // 1_000_000_000) & 0xffffffff
        assert run.returncode == 0 and not run.stderr, (name, run)
        if expected is not None:
            assert run.stdout == expected, (name, run.stdout, expected)
        else:
            ticks = int.from_bytes(run.stdout, 'big')
            assert len(run.stdout) == 4 and ((ticks - before) & 0xffffffff) <= ((after - before) & 0xffffffff), (name, run.stdout)
        count += 1
    print(f'{count} {"reference" if reference else "native"} clock/date programs passed ({len(TICKS)} date vectors)', flush=True)


def reference_checks(command, work):
    def build(path, program):
        result = subprocess.run([*command, str(path), '-o', str(program)], capture_output=True, timeout=60)
        assert result.returncode == 0, result.stderr
    checks(build, work, True)


def run_checks(tools, work):
    tools = Path(tools).resolve()
    def build(path, program):
        result = subprocess.run([str(tools / 'driver'), str(path), '-o', str(program)],
                                env=dict(os.environ, PATH=''), capture_output=True, timeout=60)
        assert (result.returncode, result.stdout, result.stderr) == (0, b'', b''), result
    checks(build, work, False)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tools', type=Path, required=True)
    parser.add_argument('--reference', type=Path)
    args = parser.parse_args()
    with tempfile.TemporaryDirectory(prefix='bcc-native-clock-') as directory:
        work = Path(directory)
        if args.reference:
            reference_checks([str(args.reference.resolve()), '--strict', '--pedantic', '--word=host'], work / 'reference')
        run_checks(args.tools, work / 'native')


if __name__ == '__main__':
    main()
