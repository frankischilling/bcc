#!/usr/bin/env python3
"""Check V1 status fields, buffer bounds, and historical permission modes."""
import argparse
import os
from pathlib import Path
import stat
import subprocess
import tempfile

EPOCH_NS = 31536000 * 1_000_000_000


def status_words(info):
    flags = 0o120000
    directory = stat.S_ISDIR(info.st_mode)
    if directory: flags |= 0o40000
    if info.st_size > 4096: flags |= 0o10000
    if info.st_mode & stat.S_ISUID: flags |= 0o40
    if not directory and info.st_mode & 0o111: flags |= 0o20
    for host, old in ((0o400, 0o10), (0o200, 0o4), (0o4, 0o2), (0o2, 0o1)):
        if info.st_mode & host: flags |= old
    created = ((info.st_ctime_ns - EPOCH_NS) * 60 // 1_000_000_000) & 0xffffffff
    modified = ((info.st_mtime_ns - EPOCH_NS) * 60 // 1_000_000_000) & 0xffffffff
    return [info.st_ino & 65535, flags, ((info.st_uid & 255) << 8) | (info.st_nlink & 255), info.st_size & 65535,
            *([0] * 8), created >> 16, created & 65535, modified >> 16, modified & 65535, 0]


def status_source(path, expected, word):
    source = 'want[17] ' + ','.join(map(str, expected)) + ';\n'
    source += '''main(){
        auto a 22,b 22,s,t,i,fd;
        extrn want,stat,fstat,open,close,char;
        i=0;while(i<22){a[i]=123;b[i]=123;i++;}s=a+1;t=b+1;
        if(stat("PATH",s)!=0)return(1);
        fd=open("PATH",0);if(fd<0)return(2);
        if(fstat(fd,t)!=0)return(3);close(fd);
        i=0;while(i<17){if(s[i]!=want[i] | t[i]!=want[i])return(10+i);i++;}
        if(a[0]!=123 | b[0]!=123)return(30);
        i=18;while(i<22){if(a[i]!=123 | b[i]!=123)return(31);i++;}
    '''.replace('PATH', path)
    if word == '16':
        source += f'if(char(s,4)!={expected[2] & 255} | char(s,5)!={expected[2] >> 8})return(32);\n'
    return source + 'return(0);}\n'


ERRORS = '''main(){auto a 22,i;extrn stat,fstat;i=0;while(i<22){a[i]=123;i++;}
    if(stat("missing",a+1)>=0 | fstat(-1,a+1)>=0)return(1);
    if(stat("file",0)>=0 | fstat(0,0)>=0)return(2);
    i=0;while(i<22){if(a[i]!=123)return(3);i++;}return(0);}
'''
MODES = '''main(){auto fd;extrn creat,close,chmod,makdir;
    fd=creat("created",016);if(fd<0)return(1);close(fd);
    fd=creat("changed",016);if(fd<0)return(2);close(fd);
    if(chmod("changed",010)!=0)return(3);
    fd=creat("modern",0640);if(fd<0)return(4);close(fd);
    if(makdir("folder",016)!=0)return(5);return(0);}
'''


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    compiler = args.compiler.resolve()
    modes = [('host', False)] if args.bootstrap else [(word, inline) for word in ('host', '16') for inline in (False, True)]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-unix-status-') as directory:
        root = Path(directory)
        for word, inline in modes:
            for case in ('regular', 'large', 'wrapped-size', 'wrapped-time', 'directory', 'errors', 'permissions'):
                work = root/f'{word}-{inline}-{case}'; work.mkdir()
                file = work/'file'
                if case == 'directory': file.mkdir(); file.chmod(0o755)
                else: file.write_bytes(b'x'*65539 if case == 'wrapped-size' else b'x'*8193 if case == 'large' else b'A\0B'); file.chmod(0o644)
                stamp = EPOCH_NS - 500_000_000 if case == 'wrapped-time' else EPOCH_NS + 1_500_000_000
                os.utime(file, ns=(stamp, stamp))
                source = ERRORS if case == 'errors' else MODES if case == 'permissions' else status_source('file', status_words(file.stat()), word)
                path = work/'case.b'; path.write_text(source)
                command = [str(compiler), '--strict', '--pedantic']
                if not args.bootstrap: command += [f'--word={word}']
                if inline: command += ['--inline-runtime']
                try:
                    result = subprocess.run([*command, str(path), '-o', str(work/'case')], capture_output=True, timeout=30)
                    if result.returncode == 0:
                        result = subprocess.run([str(work/'case')], cwd=work, capture_output=True, timeout=10, preexec_fn=lambda: os.umask(0))
                    ok = result.returncode == 0 and result.stdout == b''
                    if ok and case == 'permissions':
                        for name, expected in [('created', 0o644), ('changed', 0o400), ('modern', 0o640), ('folder', 0o755)]:
                            if stat.S_IMODE((work/name).stat().st_mode) != expected: ok = False
                    detail = repr((result.returncode, result.stdout, result.stderr[-1500:]))
                except (OSError, subprocess.TimeoutExpired) as error:
                    ok, detail = False, str(error)
                print(f'{"PASS" if ok else "FAIL"}: unix-status/{word}/{"inline" if inline else "shared"}/{case}', flush=True)
                if not ok: print(detail)
                passed += ok; failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
