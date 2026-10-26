#!/usr/bin/env python3
"""Check the full guest rebuild's plan and binary comparison helper."""
from pathlib import Path
import os
import subprocess
import sys
import tempfile
from types import SimpleNamespace

from test_toolchain_v1 import FILES, REBUILD_HELPERS, rebuild_case, verify_outputs

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[2]


def main():
    passed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-guest-rebuild-') as directory:
        work = Path(directory)
        names = [name for pair in FILES.values() for name in pair]
        names += ['engine', 'driver', 'vm.b', 'bdrv.b', 'bmain.s', 'brt.s', 'libb.s']
        for name in names:
            (work / name).write_bytes(('seed ' + name).encode())
        wrapper, console, files, references = rebuild_case(work)
        assert len(references) == 12 and len(console.splitlines()) == 11
        candidates = {name for name, data in files.items() if data is None}
        assert len(candidates) == 9 and candidates <= references.keys()
        assert all(name in wrapper for name in candidates)
        assert len(set(candidates) & set(names)) == 0
        assert all(len(name) <= 8 for name in files)
        for name, (image, source) in FILES.items():
            assert files[source] == (work / source).read_bytes()
            assert references[name[:4] + '.new'] == (work / image).read_bytes()
        passed += 1
        disk = {'tmp/' + name: data for name, data in references.items()}
        verify_outputs(SimpleNamespace(read=disk.__getitem__), references)
        passed += 1
        for name in references:
            for missing in (False, True):
                altered = dict(disk)
                if missing:
                    del altered['tmp/' + name]
                else:
                    altered['tmp/' + name] += b'wrong'
                try:
                    verify_outputs(SimpleNamespace(read=altered.__getitem__), references)
                except (AssertionError, KeyError):
                    passed += 1
                else:
                    raise AssertionError('missing or changed guest output accepted: ' + name)
        (work / 'bf.b').write_bytes(bytes(65536))
        try:
            rebuild_case(work)
        except ValueError as error:
            assert 'bf.b' in str(error)
        else:
            raise AssertionError('oversized guest source accepted')
        passed += 1

        helper = REBUILD_HELPERS[REBUILD_HELPERS.index('cmpfiles('):REBUILD_HELPERS.index('\nstage(')]
        (work / 'compare.b').write_text(helper + '\nmain(){return(cmpfiles("left","right"));}\n')
        binary_data = bytes(range(256)) * 3 + b'\0\4\377'
        cases = [('empty', b'', b'', 0),
                 ('binary', binary_data, binary_data, 0),
                 ('first-byte', b'x' + binary_data[1:], binary_data, 1),
                 ('last-byte', binary_data[:-1] + b'x', binary_data, 1),
                 ('short-left', binary_data[:-1], binary_data, 1),
                 ('short-right', binary_data, binary_data[:-1], 1),
                 ('missing-left', None, b'', 1),
                 ('missing-right', b'', None, 1)]
        for word in ('16', '32', 'host', 'native'):
            binary = work / ('compare-' + word)
            if word == 'native':
                subprocess.run([sys.executable, str(ROOT.parent / 'tools/run_apout.py'),
                                '--emit-image', str(binary), str(work / 'compare.b')],
                               check=True, timeout=180)
                command = [str(ROOT.parent.parent / 'unix-v1/tools/apout/apout'), str(binary)]
            else:
                subprocess.run([str(PROJECT / 'bcc'), '--strict', '--pedantic', '--word=' + word,
                                str(work / 'compare.b'), '-o', str(binary)], check=True, timeout=180)
                command = [str(binary)]
            for label, left, right, expected in cases:
                for name, data in [('left', left), ('right', right)]:
                    path = work / name
                    if data is None:
                        path.unlink(missing_ok=True)
                    else:
                        path.write_bytes(data)
                result = subprocess.run(command, cwd=work, capture_output=True, timeout=30,
                                        env=dict(os.environ, APOUT_ROOT=str(work), APOUT_UNIX_VERSION='V2'))
                assert (result.returncode, result.stdout, result.stderr) == (expected, b'', b''), (word, label)
                passed += 1
            print(f'PASS: guest comparison/{word}/binary bytes, lengths and missing files', flush=True)
    print(f'Results: {passed} passed, 0 failed')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
