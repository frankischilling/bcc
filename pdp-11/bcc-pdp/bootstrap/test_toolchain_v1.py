#!/usr/bin/env python3
"""Run runtime regeneration and a B-driven native build inside Unix V1."""
import fcntl
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import time

ROOT = Path(__file__).resolve().parent
NATIVE = ROOT.parent
V1 = NATIVE.parent / 'unix-v1'
sys.path[:0] = [str(ROOT / 'tools'), str(NATIVE / 'tools')]
from build_toolchain import build
from v1_files import FileSystem

SOURCE = "main(){extrn putchar;putchar('O');putchar('K');putchar('*n');return(0);}\n"
WRAPPER = '''
/* A success-only test entry prevents the shell's missing status from hiding failure. */
main(){
 extrn argv,lchar,write;auto v 8,opt 2;
 argv=v;v[0]=2;v[1]="driver";v[2]=opt;
 lchar(opt,0,'-');lchar(opt,1,'r');lchar(opt,2,0);
 if(drvmain())return(1);
 lchar(opt,1,'b');if(drvmain())return(1);
 v[0]=3;v[2]="input.b";v[3]="out";
 if(drvmain())return(1);
 write(1,"OK*n",3);return(0);
}
'''



def verify_errors(driver, work):
    """Caller holds the native staging lock and owns the three scratch paths."""
    wrapper = 'main(){extrn close;close(2);return(drvmain());}\n'
    (work / 'errors.b').write_text(driver.replace('main(){', 'drvmain(){', 1) + wrapper)
    cases = [([], b'usage: driver [-v|-s|-l|-L] input output\n'),
             (['a' * 129, 'longout'], b'B build failed\n')]
    for arguments, expected in cases:
        (V1 / 'fs/usr/tmp/heap.vm').write_bytes(b'U' * 16384)
        (V1 / 'fs/usr/tmp/done').write_bytes(b'preserve')
        (V1 / 'fs/usr/tmp/longout').unlink(missing_ok=True)
        (work / 'errors.out').write_bytes(expected)
        subprocess.run(['bash', str(NATIVE / 'tools/v1-run.sh'), str(work / 'errors.b'),
                        '--workdir', '/usr/tmp', '--timings', '--run-timeout=60',
                        *['--argument=' + argument for argument in arguments]],
                       env=dict(os.environ, _BCC_NATIVE_LOCKED='1'), check=True, timeout=300)
        fs = FileSystem((V1 / 'images/rk0.dsk').read_bytes())
        if fs.read('tmp/heap.vm') != b'U' * 16384 or fs.read('tmp/done') != b'preserve':
            raise AssertionError('rejected command changed scratch files')
        _, entries = fs.inode(41)
        directories = [int.from_bytes(entries[i:i + 2], 'little')
                       for i in range(0, len(entries), 10)
                       if entries[i + 2:i + 10].split(b'\0', 1)[0] == b'tmp']
        if len(directories) != 1:
            raise AssertionError('invalid guest scratch directory')
        flags, entries = fs.inode(directories[0])
        if not flags & 0o40000:
            raise AssertionError('guest scratch path is not a directory')
        if any(int.from_bytes(entries[i:i + 2], 'little') and
               entries[i + 2:i + 10].split(b'\0', 1)[0] == b'longout'
               for i in range(0, len(entries), 10)):
            raise AssertionError('rejected command created an output')
        print('PASS: Unix-V1 driver diagnostic and scratch preservation/' +
              ('argument-limit' if arguments else 'usage'), flush=True)


def main():
    with tempfile.TemporaryDirectory(prefix='bcc-B-toolchain-v1-') as directory:
        work = Path(directory)
        seed = work / 'seed'
        build(seed)
        driver = (seed / 'bdrv.b').read_text()
        if driver.count('main(){') != 1:
            raise AssertionError('unexpected driver entry definition')
        (work / 'runner.b').write_text(driver.replace('main(){', 'drvmain(){', 1) + WRAPPER)
        (work / 'runner.out').write_bytes(b'OK\n')
        (work / 'input.b').write_text(SOURCE)
        reference = work / 'reference'
        subprocess.run([sys.executable, str(NATIVE / 'tools/run_apout.py'), '--raw-v1',
                        '--emit-image', str(reference), str(work / 'input.b')], check=True, timeout=180)
        expected = reference.read_bytes()
        references = {name: (seed / name).read_bytes() for name in ('bmain.s', 'brt.s', 'libb.s')}
        files = {name: (seed / name).read_bytes() for name in
                 ('engine', 'front.vm', 'resolve', 'codegen', 'select', 'runtime', 'image', 'encoder', 'libb.b')}
        files['input.b'] = SOURCE.encode()
        files.update({name: None for name in ('bmain.s', 'brt.s', 'libb.s', 'heap.vm', 'raw.ic',
                                               'code.ic', 'prog.s', 'selrt.s', 'sellib.s', 'done', 'out', 'longout')})
        with (NATIVE / '.native-build.lock').open('a') as lock:
            fcntl.flock(lock, fcntl.LOCK_EX)
            (V1 / 'fs/usr/tmp').mkdir(parents=True, exist_ok=True)
            targets = {V1 / 'fs/usr/tmp' / name: data for name, data in files.items()}
            saved = {p: (p.read_bytes(), p.stat().st_mode & 0o777) if p.exists() else None for p in targets}
            try:
                for path, data in targets.items():
                    if data is None:
                        path.unlink(missing_ok=True)
                    else:
                        path.write_bytes(data)
                        path.chmod(0o755 if path.name == 'engine' else 0o644)
                subprocess.run(['bash', str(NATIVE / 'tools/v1-run.sh'), str(work / 'runner.b'),
                                '--workdir', '/usr/tmp', '--timings', '--run-timeout=3600'],
                               env=dict(os.environ, _BCC_NATIVE_LOCKED='1'), check=True, timeout=3900)
                fs = FileSystem((V1 / 'images/rk0.dsk').read_bytes())
                for name, data in references.items():
                    if fs.read('tmp/' + name) != data:
                        raise AssertionError('guest runtime differs: ' + name)
                actual = fs.read('tmp/out')
                if actual != expected:
                    raise AssertionError('guest native executable differs')
                (V1 / 'fs/usr/tmp/out').write_bytes(actual)
                (V1 / 'fs/usr/tmp/out').chmod(0o755)
                (work / 'execute.b').write_text('main(){extrn execl;execl("./out","out",0);return(1);}\n')
                (work / 'execute.out').write_bytes(b'OK\n')
                subprocess.run(['bash', str(NATIVE / 'tools/v1-run.sh'), str(work / 'execute.b'),
                                '--workdir', '/usr/tmp', '--timings', '--run-timeout=60'],
                               env=dict(os.environ, _BCC_NATIVE_LOCKED='1'), check=True, timeout=300)
                print(f'PASS: Unix-V1 B driver, regenerated runtimes, {len(actual)} exact native bytes and execution', flush=True)
                verify_errors(driver, work)
            except BaseException as error:
                failure = NATIVE / 'build/toolchain-v1-failures' / str(time.time_ns())
                failure.mkdir(parents=True)
                (failure / 'failure.txt').write_text(str(error))
                for name in ('rk0.dsk', 'rf0.dsk'):
                    path = V1 / 'images' / name
                    if path.exists():
                        shutil.copy2(path, failure / name)
                raise
            finally:
                for path, previous in saved.items():
                    if previous is None:
                        path.unlink(missing_ok=True)
                    else:
                        path.write_bytes(previous[0])
                        path.chmod(previous[1])
    return 0


if __name__ == '__main__':
    main()
