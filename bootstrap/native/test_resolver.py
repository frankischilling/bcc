#!/usr/bin/env python3
"""Check host resolver capacity without enlarging the PDP-11 configuration."""
import argparse
import importlib.util
import os
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[1]
NATIVE = PROJECT / 'pdp-11/bcc-pdp/bootstrap'
sys.path.insert(0, str(NATIVE / 'tools'))
from build_passes import source_text as native_source


def load(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


resolver = load('host_resolver', ROOT / 'resolver/build.py')
frontend = load('wide_frontend', ROOT / 'frontend/build.py')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=PROJECT / 'bcc')
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    compiler = [str(args.compiler.resolve()), '--strict', '--pedantic']
    if not args.bootstrap:
        compiler.append('--word=host')
    passed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-host-resolver-') as directory:
        work = Path(directory)

        def build(name, text, command=compiler):
            source = work / (name + '.b')
            source.write_text(text)
            subprocess.run([*command, str(source), '-o', str(work / name)], check=True, timeout=180)

        text = resolver.source_text()
        build('wide', text)
        build('native', native_source('resolver'))
        build('front', frontend.source_text())
        joined = work / 'joined.b'
        subprocess.run([sys.executable, str(ROOT / 'resolver/build.py'), str(joined),
                        '--source-only', '--compiler', str(work / 'absent')], check=True, timeout=30)
        assert joined.read_text() == text
        passed += 1
        original = resolver.MODULES['resolver']
        try:
            resolver.MODULES['resolver'] = tuple(p for p in original if p != 'src/resolver16.b')
            try:
                resolver.source_text()
            except ValueError as error:
                assert 'storage configuration' in str(error)
            else:
                raise AssertionError('missing storage configuration was ignored')
        finally:
            resolver.MODULES['resolver'] = original
        passed += 1

        def run(name, data, error=None, expected=None):
            nonlocal passed
            (work / 'input').write_text(data)
            result = subprocess.run([str(work / name), '-i', 'input'], cwd=work,
                                    env=dict(os.environ, PATH=''), capture_output=True, timeout=30)
            if error:
                assert result.returncode != 0 and error in result.stderr, (name, result)
            else:
                assert (result.returncode, result.stderr) == (0, b''), (name, result)
                if expected is not None:
                    assert result.stdout == expected, (name, result, expected[:100])
            passed += 1
            return result.stdout

        for count in (0, 1, 199, 200, 201, 1023, 1024, 1025):
            records = ''.join(f'gvb g{i} 1\ngvc {i}\ngve\n' for i in range(count))
            for name, limit in [('native', 200), ('wide', 1024)]:
                run(name, records, error=b'symbol table full' if count > limit else None,
                    expected=records.encode())

        def header(size):
            data = 'gvb x 1\n'
            while size-len(data) > 1000:
                data += 'gvc 0\n'
            data += 'gvc 0' + ' '*(size-len(data)-6) + '\n'
            assert len(data) == size
            return data+'gve\n'

        for size in (2046, 2047, 2048, 8190, 8191, 8192):
            for name, limit in [('native', 2047), ('wide', 8191)]:
                records = header(size)
                run(name, records, error=b'global records too large' if size > limit else None,
                    expected=records.encode())

        source = 'values[128] '+','.join(['9223372036854775807']*128)+';main(){extrn values;return(values[127]);}'
        sources = [source, text, frontend.source_text()]
        parts = [NATIVE / 'src' / n for n in ('buffered_io.b', 'decimal16.b', 'diagnostics.b', 'ic.b')]
        parts += [ROOT / n for n in ('x64.b', 'labels.b', 'ops.b', 'scalar.b', 'memory.b',
                                     'control.b', 'arity.b', 'calls.b', 'data/layout.b', 'data/output.b')]
        parts += [ROOT / 'fixtures/calls' / n for n in ('metadata.b', 'emission.b', 'driver.b')]
        sources.append('\n'.join(p.read_text() for p in parts))
        for source in sources:
            (work / 'source.b').write_text(source)
            front = subprocess.run([str(work / 'front'), 'source.b'], cwd=work,
                                   capture_output=True, timeout=30)
            assert (front.returncode, front.stderr) == (0, b''), front
            output = run('wide', front.stdout.decode())
            assert b'pr main ' in output and b'ep ' in output

        if not args.bootstrap:
            for mode in ('16', '32'):
                name = 'narrow'+mode
                build(name, text, [str(args.compiler.resolve()), '--strict', '--pedantic', '--word='+mode])
                run(name, '', error=b'64-bit resolver requires 64-bit words')
    print(f'{passed} host-resolver checks passed')


if __name__ == '__main__':
    main()
