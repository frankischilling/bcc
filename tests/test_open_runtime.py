#!/usr/bin/env python3
"""Check the historical zero/read, nonzero/write contract using the full B word."""
import argparse
from pathlib import Path
import resource
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

REDIRECT = '''main(){
    extrn openr,openw,read,write,close,char,getchar,putchar;
    auto buf 2;
    if(openr(9,"PATH")!=9)return(1);
    if(openr(10,"missing")!=-1)return(2);
    if(getchar()!='A')return(3);
    if(openr(-1,"")!=0 | read(9,buf,1)!=-1)return(4);
    if(openw(9,"PATH")!=9)return(5);
    if(openw(10,"missing/output")!=-1)return(6);
    if(openw(64,"untouched")!=-1)return(8);
    if(openw(64,"not-created")!=-1)return(9);
    putchar('Z');
    if(openw(-1,"")!=1 | write(9,"X",1)!=-1)return(7);
    putchar('Q');
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
            work = root / f'{word}-{inline}-redirect'
            work.mkdir()
            directory = Path('a'*150) / ('b'*150) / ('c'*150)
            (work / directory).mkdir(parents=True)
            prefix = directory / ('d'*58)
            target = Path(str(prefix) + 'extra')
            assert len(str(prefix)) == 511
            (work / prefix).write_bytes(b'KEEP')
            (work / target).write_bytes(b'ABC')
            (work / 'untouched').write_bytes(b'KEEP')
            source = work / 'case.b'
            source.write_text(REDIRECT.replace('PATH', str(target)))
            command = [str(compiler), '--strict', '--pedantic']
            if not args.bootstrap:
                command += [f'--word={word}']
            if inline:
                command += ['--inline-runtime']
            try:
                result = subprocess.run([*command, str(source), '-o', str(work/'case')],
                                        capture_output=True, timeout=30)
                if result.returncode == 0:
                    def limit_descriptors():
                        _, hard = resource.getrlimit(resource.RLIMIT_NOFILE)
                        resource.setrlimit(resource.RLIMIT_NOFILE, (64, hard))
                    result = subprocess.run([str(work/'case')], cwd=work,
                                            capture_output=True, timeout=10,
                                            preexec_fn=limit_descriptors)
                ok = (result.returncode == 0 and result.stdout == b'Q'
                      and (work / prefix).read_bytes() == b'KEEP'
                      and (work / target).read_bytes() == b'Z'
                      and (work / 'untouched').read_bytes() == b'KEEP'
                      and not (work / 'not-created').exists())
                detail = repr((result.returncode, result.stdout, result.stderr[-1500:]))
            except (OSError, subprocess.TimeoutExpired) as error:
                ok, detail = False, str(error)
            print(f'{"PASS" if ok else "FAIL"}: open/{word}/{"inline" if inline else "shared"}/redirection', flush=True)
            if not ok:
                print(detail)
            passed += ok
            failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
