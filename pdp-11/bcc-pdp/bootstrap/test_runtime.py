#!/usr/bin/env python3
"""Compare B-emitted target templates with the native seed's runtime files."""
import argparse
import os
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
NATIVE = ROOT.parent
PROJECT = NATIVE.parents[1]
sys.path[:0] = [str(ROOT / 'tools'), str(NATIVE / 'tools')]
from build_passes import source_text, snapshot, seed_image
from build_vm import build


def run(command, work):
    return subprocess.run([str(p) for p in command], cwd=work,
                          env=dict(os.environ, APOUT_ROOT=str(work), APOUT_UNIX_VERSION='V2'),
                          capture_output=True, timeout=180)


def check(command, work, expected):
    for name in ('start.s', 'prim.s', 'done'):
        (work / name).unlink(missing_ok=True)
    result = run([*command, '-s', 'done', 'start.s', 'prim.s'], work)
    assert (result.returncode, result.stdout, result.stderr) == (0, b'', b'')
    assert [(work / name).read_bytes() for name in ('start.s', 'prim.s')] == expected
    assert (work / 'done').read_bytes() == b'ok'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--bcc', type=Path, default=PROJECT / 'bcc')
    parser.add_argument('--vm', action='store_true')
    args = parser.parse_args()
    source = source_text('runtime')
    expected = [(NATIVE / 'runtime' / name).read_bytes() for name in ('bmain.s', 'brt.s')]
    passed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-B-runtime-') as directory:
        work = Path(directory)
        snapshot(work)
        (work / 'runtime.b').write_text(source)
        for word in ('16', '32', 'host'):
            binary = work / ('runtime-' + word)
            subprocess.run([str(args.bcc.resolve()), '--strict', '--pedantic', '--word=' + word,
                            str(work / 'runtime.b'), '-o', str(binary)], check=True, timeout=180)
            check([binary], work, expected)
            passed += 1
            for arguments in [('keep', 'keep'), ('-s', 'keep', 'keep', 'second'),
                              ('-s', 'keep', 'first', 'keep'), ('missing/start', 'second')]:
                (work / 'keep').write_bytes(b'preserve this file')
                result = run([binary, *arguments], work)
                assert result.returncode and (work / 'keep').read_bytes() == b'preserve this file'
                passed += 1
            print(f'PASS: runtime/{word}/exact bytes, marker and protected paths', flush=True)
        if args.vm:
            (work / 'code.vm').write_bytes(seed_image('runtime', work, source=source)[0])
            build(work / 'native-vm')
            build(work / 'host-vm', host=args.bcc)
            for model, command in [('native', [work / 'apout', work / 'native-vm']),
                                   ('host16', [work / 'host-vm'])]:
                (work / 'heap.vm').write_bytes(bytes(16384))
                check([*command, 'code.vm'], work, expected)
                passed += 1
                print(f'PASS: runtime-vm/{model}/exact bytes and marker', flush=True)
    print(f'Results: {passed} passed, 0 failed')
    return 0


if __name__ == '__main__':
    main()
