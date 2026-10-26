#!/usr/bin/env python3
"""Build experimental B frontend, resolver and code generators using the C seed."""
import argparse
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

BOOTSTRAP = Path(__file__).resolve().parents[1]
NATIVE = BOOTSTRAP.parent
MODULES = {
    'frontend': ('src/buffered_io.b', 'src/decimal16.b', 'src/diagnostics.b', 'frontend/lex.b', 'frontend/word16.b', 'frontend/bstmt.b',
                 'frontend/bexpr.b', 'frontend/bemit0.b', 'frontend/driver.b'),
    'resolver': ('src/buffered_io.b', 'src/decimal16.b', 'src/diagnostics.b', 'src/ic.b', 'src/symbols.b', 'src/b01.b'),
    'codegen': ('src/buffered_io.b', 'src/decimal16.b', 'src/diagnostics.b', 'src/ic.b', 'codegen/bcg.b', 'codegen/bcgnew.b',
                'codegen/blit.b', 'codegen/b1drv.b', 'codegen/driver.b'),
    'selector': ('src/io.b', 'selector/select.b'),
    'runtime': ('runtime/io.b', 'runtime/startup.b', 'runtime/prims.b'),
    'image': ('src/io.b',) + tuple('image/' + name + '.b' for name in
                                  ('symbols', 'lexer', 'expression', 'output',
                                   'operand', 'opcodes', 'parser', 'main')),
    'encoder': tuple('encoder/' + name + '.b' for name in
                     ('io', 'ic', 'symbols', 'tables', 'layout', 'emit', 'code', 'main')),
}


def source_text(name):
    return '\n'.join((BOOTSTRAP / part).read_text() for part in MODULES[name])


def snapshot(work):
    sys.path.insert(0, str(NATIVE / 'tools'))
    from run_apout import build_snapshot_lock
    with build_snapshot_lock(NATIVE):
        for name in ('b00', 'b01', 'b1'):
            shutil.copy2(NATIVE / 'build' / name, work / name)
        shutil.copy2(NATIVE.parent / 'unix-v1/tools/apout/apout', work / 'apout')


def seed_image(name, work, *, source=None):
    """Use already-snapshotted seed tools; return the independent Python image."""
    from encode_vm import encode
    (work / 'input.b').write_text(source_text(name) if source is None else source)
    env = dict(os.environ, APOUT_ROOT=str(work))
    for binary, args in [('b00', ['-o', 'raw.ic', 'input.b']),
                         ('b01', ['-i', 'raw.ic', '-o', 'code.ic'])]:
        subprocess.run([str(work / 'apout'), str(work / binary), *args],
                       cwd=work, env=env, check=True, timeout=60)
    return encode((work / 'code.ic').read_text())


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('pass_name', choices=MODULES)
    parser.add_argument('output', type=Path)
    parser.add_argument('--source-only', action='store_true')
    parser.add_argument('--host-bcc', type=Path)
    parser.add_argument('--word', choices=('16', '32', 'host'), default='16')
    args = parser.parse_args()
    if args.source_only and args.host_bcc:
        parser.error('--source-only and --host-bcc are mutually exclusive')
    if args.source_only:
        args.output.write_text(source_text(args.pass_name))
        return
    output = args.output.resolve()
    with tempfile.TemporaryDirectory(prefix='bcc-B-pass-') as directory:
        work = Path(directory)
        if args.host_bcc:
            source = work / 'pass.b'
            source.write_text(source_text(args.pass_name))
            subprocess.run([str(args.host_bcc.resolve()), '--strict', '--pedantic',
                            '--word=' + args.word, str(source), '-o', str(output)],
                           check=True, timeout=180)
        else:
            snapshot(work)
            image, _, _ = seed_image(args.pass_name, work)
            output.write_bytes(image)


if __name__ == '__main__':
    main()
