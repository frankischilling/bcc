#!/usr/bin/env python3
"""A failed close must not leave a pass-completion marker or installed image."""
import argparse
import os
from pathlib import Path
import shlex
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
from run_apout import build_snapshot_lock


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--bcc', type=Path, help='also test the B-written resolver with this host compiler')
    args = parser.parse_args()
    if not Path('/proc/self/fd').is_dir():
        parser.error('close-fault injection requires Linux /proc/self/fd')
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-native-close-') as directory:
        work = Path(directory)
        with build_snapshot_lock(ROOT):
            # Do not inherit scratch files or compiler installations from a local VM run.
            shutil.copytree(ROOT / 'build/aroot', work, dirs_exist_ok=True,
                            ignore=shutil.ignore_patterns('tmp', 'bcc'))
            for directory in ('usr/lib/bcc', 'usr/tmp', 'tmp'):
                (work / directory).mkdir(parents=True, exist_ok=True)
            shutil.copy2(ROOT.parent / 'unix-v1/tools/apout/apout', work / 'apout')
            for name in ('b00', 'b01', 'b1'):
                shutil.copyfile(ROOT / 'build' / name, work / name)
                shutil.copyfile(ROOT / 'build' / name, work / 'usr/lib/bcc' / name)
            shutil.copyfile(ROOT / 'build/b', work / 'bin/b')
            for name in ('bmain.s', 'brt.s', 'libb.s'):
                shutil.copyfile(ROOT / 'runtime' / name, work / 'usr/lib' / name)
        shim = work / 'fault.so'
        subprocess.run([*shlex.split(os.environ.get('CC', 'cc')), '-Wall', '-Wextra',
                        '-shared', '-fPIC', str(ROOT / 'tests/fixtures/close_fault.c'),
                        '-ldl', '-o', str(shim)], check=True, timeout=30)
        env = dict(os.environ, APOUT_ROOT=str(work), LD_PRELOAD=str(shim),
                   BCC_CLOSE_SEEN=str(work / 'seen'))
        sources = {'b00': 'main(){return(0);}\n',
                   'b01': 'Adef main\nn 0\nrt\nAend\n', 'b1': 'n 0\n'}
        commands = {name: [str(work / 'apout'), str(work / name)] for name in sources}
        if args.bcc:
            for word in ('16', '32', 'host'):
                name = 'B-resolver-' + word
                binary = work / name
                source = [ROOT / 'bootstrap/src' / part for part in ('io.b', 'ic.b', 'symbols.b', 'b01.b')]
                subprocess.run([str(args.bcc.resolve()), '--strict', '--pedantic', '--word=' + word,
                                *map(str, source), '-o', str(binary)], check=True, timeout=180)
                commands[name] = [str(binary)]
                sources[name] = sources['b01']
        for name, command in commands.items():
            (work / 'input').write_text(sources[name])
            for target in ('none', 'result.ic', 'done'):
                for filename in ('result.ic', 'done', 'seen'):
                    (work / filename).unlink(missing_ok=True)
                arguments = ['-o', 'result.ic', '-s', 'done']
                arguments += ['input'] if name == 'b00' else ['-i', 'input']
                result = subprocess.run([*command, *arguments], cwd=work,
                                        env=dict(env, BCC_CLOSE_TARGET=target), capture_output=True, timeout=30)
                seen = (work / 'seen').exists()
                marker = (work / 'done').exists()
                ok = (result.returncode == 0 and not seen and marker
                      and (work / 'done').read_bytes() == b'ok') if target == 'none' else (
                          result.returncode != 0 and seen and not marker)
                print(f'{"PASS" if ok else "FAIL"}: output-close/{name}/{target}', flush=True)
                if not ok:
                    print(result.returncode, seen, marker, repr(result.stdout), repr(result.stderr))
                passed += ok
                failed += not ok
        for target, source, diagnostic in (
            ('.b.aout', 'main(){return(0);}', b'output close failed'),
            ('b.br', 'putchar(c){return(c);}main(){return(0);}', b'runtime close failed'),
            ('b.lb', 'printn(n,b){return(n);}main(){return(0);}', b'runtime close failed'),
        ):
            (work / 'good.b').write_text(source + '\n')
            (work / 'seen').unlink(missing_ok=True)
            result = subprocess.run([str(work / 'apout'), str(work / 'bin/b'), 'good.b'], cwd=work,
                                    env=dict(env, BCC_CLOSE_TARGET=target), capture_output=True, timeout=30)
            ok = (result.returncode != 0 and (work / 'seen').exists()
                  and not (work / 'a.out').exists() and not (work / '.b.aout').exists()
                  and diagnostic in result.stdout + result.stderr)
            if target != '.b.aout':
                ok = ok and not (work / 'usr/tmp' / target).exists()
            print(f'{"PASS" if ok else "FAIL"}: output-close/driver/{target}', flush=True)
            if not ok:
                print(result.returncode, repr(result.stdout), repr(result.stderr))
            passed += ok
            failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
