#!/usr/bin/env python3
"""Check B-native library selection, strict formatting, and mutable callbacks."""
import argparse
import os
from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[1]
SHORT = b'bcc: printf argument list is too short\n'
CASES = [
    ('hello', 'main(){extrn printf;return(printf("hello*n"));}', b'', b'hello\n', b'', 0, True),
    ('formats', 'main(){extrn printf;return(printf("%d %o %s %c*n",-42,-8,"text",\'XY\'));}', b'', b'-42 -10 text XY\n', b'', 0, True),
    ('minimum', 'main(){extrn printf;printf("%d %o*n",-9223372036854775808,-9223372036854775808);return(0);}', b'', b'-9223372036854775808 -1000000000000000000000\n', b'', 0, True),
    ('percent', 'main(){extrn printf;printf("%%d %q tail%",42);return(0);}', b'', b'%42 %q tail%', b'', 0, True),
    ('nul-format', 'main(){extrn printf;printf("A*0B");return(0);}', b'', b'A\0B', b'', 0, True),
    ('nul-string', 'main(){extrn printf;printf("%s|%s","A*0B","");return(0);}', b'', b'A\0B|', b'', 0, True),
    ('many-args', 'main(){extrn printf;printf("%d%d%d%d%d%d%d%d%d",1,2,3,4,5,6,7,8,9);return(0);}', b'', b'123456789', b'', 0, True),
    ('missing-conversion', 'main(){extrn printf;return(printf("prefix%d")==-1?0:1);}', b'', b'prefix', SHORT, 0, True),
    ('missing-format', 'main(){extrn printf;return(printf()==-1?0:1);}', b'', b'', b'', 0, False),
    ('null-format', 'main(){extrn printf;return(printf(0)==-1?0:1);}', b'', b'', b'', 0, False),
    ('printn', 'main(){extrn printn,putchar;printn(-9223372036854775808,10);putchar(32);printn(48879,16);return(printn(1,1)==-1?0:1);}', b'', b'-9223372036854775808 BEEF', b'', 0, True),
    ('putchar-packed', 'main(){extrn putchar;putchar(0);putchar(\'AB\');putchar(-1);return(0);}', b'', b'\0AB\xff\xff', b'', 0, True),
    ('putstr', 'main(){extrn putstr;auto s;s="A*0B";return(putstr(s)==s?0:1);}', b'', b'A\0B', b'', 0, True),
    ('getchar', 'main(){extrn getchar;auto a,b,c;a=getchar();b=getchar();c=getchar();return(a==255 & b==4 & c==4?0:1);}', b'\xff', b'', b'', 0, True),
    ('getstr', 'main(){extrn getstr,char,putstr;auto s 4,n;n=getstr(s);if(n!=4 | char(s,4)!=4)return(1);putstr(s);return(0);}', b'A\0B\r\n', b'A\0B\r', b'', 0, True),
    ('getstr-empty', 'main(){extrn getstr,char;auto s 1,n;n=getstr(s);return(n==0 & char(s,0)==4?0:1);}', b'', b'', b'', 0, True),
    ('printf-override', 'printf(a){return(42);}main(){return(printf(0)==42?0:1);}', b'', b'', b'', 0, True),
    ('printf-data', 'printf 42;main(){extrn printf;return(printf==42?0:1);}', b'', b'', b'', 0, True),
    ('saved-printf', 'other(a){return(42);}main(){extrn printf,other;auto old;old=printf;printf=other;old("ok");return(printf(0)==42?0:1);}', b'', b'ok', b'', 0, True),
    ('printn-callback', 'seen;printn(n,b){extrn seen,putchar;seen=n;putchar(\'P\');return(0);}main(){extrn printf,seen;printf("%d",-5);return(seen==5?0:1);}', b'', b'-P', b'', 0, True),
    ('putchar-callback', 'count;putchar(c){extrn count;count++;return(c);}main(){extrn printf,count;printf("%d",123);return(count==3?0:1);}', b'', b'', b'', 0, True),
    ('getchar-callback', 'index;getchar(){extrn index;if(index==2)return(4);return(65+index++);}main(){extrn getstr,putstr;auto s 2;getstr(s);putstr(s);return(0);}', b'', b'AB', b'', 0, True),
    ('lchar-not-output', 'lchar(s,i,c){return(0);}main(){extrn putchar;putchar(\'A\');return(0);}', b'', b'A', b'', 0, True),
    ('char-not-input', 'char(s,i){return(88);}main(){extrn getchar;return(getchar()==65?0:1);}', b'A', b'', b'', 0, True),
    ('printf-forward-definition', 'main(){return(printf(0)==42?0:1);}printf(a){return(42);}', b'', b'', b'', 0, True),
]


CASES += [
    ('unknown-keeps-arg', 'main(){extrn printf;printf("%q%d|%%",7);return(0);}', b'', b'%q7|%%', b'', 0, True),
    ('minimum-callback', 'seen;printn(n,b){extrn seen,putchar;seen=n<0;putchar(\'M\');return(0);}main(){extrn printf,seen;printf("%d",-9223372036854775808);return(seen?0:1);}', b'', b'M', b'', 0, True),
    ('char-callback', 'char(s,i){if(i==0)return(81);return(4);}main(){extrn putstr;putstr("ignored");return(0);}', b'', b'Q', b'', 0, True),
    ('lchar-callback', 'count;lchar(s,i,c){extrn count;count++;return(c);}main(){extrn getstr,count;auto s 2,n;n=getstr(s);return(n==2 & count==3?0:1);}', b'AB\n', b'', b'', 0, True),
    ('saved-putchar', 'count;other(c){extrn count;count++;return(c);}main(){extrn putchar,other,count;auto old;old=putchar;putchar=other;old(65);putchar(66);return(count==1?0:1);}', b'', b'A', b'', 0, True),
    ('packed-nul', 'main(){extrn printf;printf("%c",16640);return(0);}', b'', b'A\0', b'', 0, True),
    ('putchar-high-word', 'main(){extrn putchar;return(putchar(16777281)==16777281?0:1);}', b'', b'A', b'', 0, True),
    ('eot-input', 'main(){extrn getstr,putstr;auto s 2;getstr(s);putstr(s);getstr(s);putstr(s);return(0);}', b'A\x04B\n', b'AB', b'', 0, True),
    ('missing-printn', 'main(){extrn printn;return(printn()==-1?0:1);}', b'', b'', b'', 0, False),
    ('missing-putchar', 'main(){extrn putchar;return(putchar()==-1?0:1);}', b'', b'', b'', 0, False),
    ('missing-strings', 'main(){extrn putstr,getstr;auto a,b;a=putstr();b=getstr();return(a==-1 & b==-1?0:1);}', b'', b'', b'', 0, False),
]



def reference_checks(reference, work):
    work = Path(work)
    work.mkdir(parents=True, exist_ok=True)
    checked = 0
    for name, source, data, output, errors, status, compare in CASES:
        if not compare:
            continue
        path = work / 'input.b'
        path.write_text(source)
        build = subprocess.run([*reference, str(path.resolve()), '-o', str(work / 'reference')],
                               capture_output=True, timeout=60)
        assert build.returncode == 0, (name, build.stderr)
        run = subprocess.run([str((work / 'reference').resolve())], input=data,
                             cwd=work, capture_output=True, timeout=10)
        assert (run.returncode, run.stdout, run.stderr) == (status, output, errors), (name, run)
        checked += 1
    print(f'{checked} strict runtime reference checks passed', flush=True)


def run_checks(tools, work, reference=None):
    tools = Path(tools).resolve()
    work = Path(work)
    work.mkdir(parents=True, exist_ok=True)
    env = dict(os.environ, PATH='')
    if reference is not None:
        reference_checks(reference, work / 'oracle')
    for name, source, data, output, errors, status, compare in CASES:
        path = work / 'input.b'
        path.write_text(source)
        build = subprocess.run([str(tools / 'driver'), str(path.resolve())], cwd=work,
                               env=env, capture_output=True, timeout=60)
        assert (build.returncode, build.stderr) == (0, b''), (name, build)
        program = work / 'program'
        program.write_bytes(build.stdout)
        program.chmod(0o700)
        run = subprocess.run([str(program.resolve())], input=data, cwd=work, env=env,
                             capture_output=True, timeout=10)
        assert (run.returncode, run.stdout, run.stderr) == (status, output, errors), (name, run)
    print(f'{len(CASES)} native standard-I/O checks passed', flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tools', type=Path, required=True)
    parser.add_argument('--reference', type=Path)
    args = parser.parse_args()
    reference = None
    if args.reference:
        reference = [str(args.reference.resolve()), '--strict', '--pedantic', '--word=host']
    with tempfile.TemporaryDirectory(prefix='bcc-native-stdio-') as directory:
        run_checks(args.tools, Path(directory), reference)


if __name__ == '__main__':
    main()
