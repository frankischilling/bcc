#!/usr/bin/env python3
"""Compile a B program in an isolated V1 tool root, then run it with apout."""
import argparse
import os
from pathlib import Path
import shlex
import shutil
import subprocess
import sys
import tempfile


def main():
    root = Path(__file__).resolve().parents[1]
    v1 = root.parent / 'unix-v1'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--timeout', type=float, default=None)
    parser.add_argument('source', type=Path)
    parser.add_argument('arguments', nargs=argparse.REMAINDER)
    args = parser.parse_args()
    source = args.source.resolve(strict=True)
    apout = v1 / 'tools/apout/apout'
    required = [apout, root / 'build/aroot/bin/as', root / 'runtime/libb.s']
    required += [root / 'build' / name for name in ('b00', 'b01', 'b1')]
    for path in required:
        if not path.is_file():
            parser.error(f'missing {path}; run make -C {root} first')
    if (root / 'runtime/libb.s').stat().st_mtime < max(
            p.stat().st_mtime for p in required[-3:] + [root / 'runtime/libb.b']):
        parser.error('stale runtime/libb.s; rebuild the native compiler first')
    caller = Path.cwd()
    with tempfile.TemporaryDirectory(prefix='bcc-v1-run-') as directory:
        work = Path(directory)
        shutil.copytree(root / 'build/aroot', work, dirs_exist_ok=True)
        shutil.copyfile(source, work / 'program.b')
        env = dict(os.environ, APOUT_ROOT=str(work))
        flags = shlex.split(os.environ.get('B00FLAGS', os.environ.get('B0FLAGS', '')))
        commands = [
            [str(apout), str(root / 'build/b00'), *flags, '-o', 'program.ic', 'program.b'],
            [str(apout), str(root / 'build/b01'), '-i', 'program.ic', '-o', 'program.r2'],
            [str(apout), str(root / 'build/b1'), '-i', 'program.r2', '-o', 'program.s'],
        ]
        for command in commands:
            result = subprocess.run(command, cwd=work, env=env, capture_output=True, timeout=60)
            if result.stdout: sys.stderr.buffer.write(result.stdout)
            if result.stderr: sys.stderr.buffer.write(result.stderr)
            if result.returncode:
                return result.returncode if result.returncode > 0 else 1
        for name in ('bmain.s', 'brt.s', 'libb.s'):
            shutil.copyfile(root / 'runtime' / name, work / name)
        result = subprocess.run([str(apout), str(work / 'bin/as'), 'bmain.s', 'brt.s',
                                 'libb.s', 'program.s'], cwd=work, env=env,
                                capture_output=True, timeout=60)
        if result.stdout: sys.stderr.buffer.write(result.stdout)
        if result.stderr: sys.stderr.buffer.write(result.stderr)
        if result.returncode:
            return result.returncode if result.returncode > 0 else 1
        subprocess.run([sys.executable, str(v1 / 'tools/fixaout.py')], cwd=work, check=True, timeout=10)
        result = subprocess.run([str(apout), str(work / 'a.out'), *args.arguments],
                                cwd=caller, env=env, timeout=args.timeout)
        return result.returncode if result.returncode >= 0 else 128 - result.returncode


if __name__ == '__main__':
    try:
        raise SystemExit(main())
    except (OSError, subprocess.SubprocessError) as error:
        print(f'bcc-pdp: {error}', file=sys.stderr)
        raise SystemExit(1)
