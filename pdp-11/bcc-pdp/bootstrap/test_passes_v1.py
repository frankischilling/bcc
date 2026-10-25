#!/usr/bin/env python3
"""Run the B source-to-image pipeline in Unix V1, then execute its output."""
import argparse
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
sys.path.insert(0, str(ROOT / 'tools'))
sys.path.insert(0, str(NATIVE / 'tools'))
from build_passes import MODULES, snapshot, seed_image
from build_vm import source_text
from encode_vm import encode
from v1_files import FileSystem

CASES = {
    'calls': 'f(n){if(n) return(n+f(n-1));return(0);}'
             'main(){extrn putchar;if(f(5)!=15) return(1);putchar(79);putchar(75);putchar(10);return(0);}',
    'names': 'break 7;continue(n){return(n+2);}'
             'main(){extrn break,continue,putchar;if(continue(break)!=9) return(1);'
             'putchar(79);putchar(75);putchar(10);return(0);}',
    'conditional': 'main(){extrn putchar;auto x;x=0;'
                   'if((1 ? ++x : 100)!=1) return(1);if(x!=1) return(2);'
                   'putchar(79);putchar(75);putchar(10);return(0);}',
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--case', choices=CASES, action='append')
    parser.add_argument('--failure-dir', type=Path, help='preserve disk images here if a guest check fails')
    args = parser.parse_args()
    with tempfile.TemporaryDirectory(prefix='bcc-B-pipeline-v1-') as directory:
        work = Path(directory)
        snapshot(work)
        images = {name: seed_image(name, work)[0] for name in MODULES}
        (work / 'runner.b').write_text(source_text())
        with (NATIVE / '.native-build.lock').open('a') as lock:
            fcntl.flock(lock, fcntl.LOCK_EX)
            target = V1 / 'fs/usr/tmp'
            target.mkdir(parents=True, exist_ok=True)
            paths = [target / name for name in ('code.vm', 'heap.vm', 'input.b', 'raw.ic', 'code.ic', 'out.vm')]
            saved = {p: (p.read_bytes(), p.stat().st_mode & 0o777) if p.exists() else None for p in paths}
            try:
                for name in args.case or CASES:
                    source = CASES[name] + '\n'
                    (work / 'input.b').write_text(source)
                    env = dict(os.environ, APOUT_ROOT=str(work))
                    for binary, flags in [('b00', ['-o', 'raw.ic', 'input.b']),
                                          ('b01', ['-i', 'raw.ic', '-o', 'code.ic'])]:
                        subprocess.run([str(work / 'apout'), str(work / binary), *flags],
                                       cwd=work, env=env, check=True, timeout=60)
                    reference = encode((work / 'code.ic').read_text())[0]
                    data = source.encode()
                    for stage, infile, outfile, flags in (
                        ('frontend', 'input.b', 'raw.ic', ['-o', 'raw.ic', 'input.b']),
                        ('resolver', 'raw.ic', 'code.ic', ['-i', 'raw.ic', '-o', 'code.ic']),
                        ('encoder', 'code.ic', 'out.vm', ['code.ic', 'out.vm']),
                        ('program', None, None, []),
                    ):
                        (target / 'code.vm').write_bytes(data if stage == 'program' else images[stage])
                        (target / 'heap.vm').write_bytes(bytes(16384))
                        if infile:
                            (target / infile).write_bytes(data)
                        if outfile:
                            (target / outfile).unlink(missing_ok=True)
                        (work / 'runner.out').write_bytes(b'OK\n' if stage == 'program' else b'')
                        command = ['bash', str(NATIVE / 'tools/v1-run.sh'), str(work / 'runner.b'),
                                   '--workdir', '/usr/tmp', '--timings', '--run-timeout=300', '--argument=code.vm']
                        command.extend('--argument=' + arg for arg in flags)
                        subprocess.run(command, env=dict(os.environ, _BCC_NATIVE_LOCKED='1'),
                                       check=True, timeout=600)
                        if outfile:
                            data = FileSystem((V1 / 'images/rk0.dsk').read_bytes()).read('tmp/' + outfile)
                        if stage == 'encoder' and data != reference:
                            raise AssertionError((name, 'instruction image differs from reference'))
                        print(f'PASS: Unix-V1 B-pipeline/{name}/{stage}', flush=True)
            except BaseException as error:
                if args.failure_dir:
                    failure = args.failure_dir / str(time.time_ns())
                    try:
                        failure.mkdir(parents=True)
                        (failure / 'failure.txt').write_text(str(error) + '\n')
                        for disk in ('rk0.dsk', 'rf0.dsk'):
                            source = V1 / 'images' / disk
                            if source.is_file():
                                shutil.copy2(source, failure / disk)
                        print('Failure details:', failure, flush=True)
                    except OSError as save_error:
                        print('Could not preserve failure details:', save_error, file=sys.stderr)
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
    raise SystemExit(main())
