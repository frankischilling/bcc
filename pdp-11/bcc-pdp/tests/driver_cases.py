#!/usr/bin/env python3
"""Check the native compiler driver's child failures in an isolated V1 root."""
import os
from pathlib import Path
import shutil
import subprocess
import struct
import tempfile


def main():
    root = Path(__file__).resolve().parents[1]
    apout = root.parent / 'unix-v1/tools/apout/apout'
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-v1-driver-') as directory:
        work = Path(directory)
        shutil.copytree(root / 'build/aroot', work, dirs_exist_ok=True)
        (work / 'usr/lib/bcc').mkdir(parents=True, exist_ok=True)
        (work / 'usr/tmp').mkdir(exist_ok=True)
        for name in ('b00', 'b01', 'b1'):
            shutil.copyfile(root / 'build' / name, work / 'usr/lib/bcc' / name)
        shutil.copyfile(root / 'build/b', work / 'bin/b')
        for name in ('bmain.s', 'brt.s', 'libb.s'):
            shutil.copyfile(root / 'runtime' / name, work / 'usr/lib' / name)
        # Selection must preserve long non-label lines while removing overrides.
        library = work / 'usr/lib/libb.s'
        library.write_bytes(b'/' + b'x' * 3000 + b'\n' + library.read_bytes())
        env = dict(os.environ, APOUT_ROOT=str(work))
        (work / 'good.b').write_text("main(){putchar('O');putchar('K');putchar('*n');return(0);}\n")
        (work / 'large.b').write_text('first[5000];second[5000];main(){return(0); }\n')
        (work / 'undef.b').write_text('main(){extrn missing; missing();return(0); }\n')
        (work / 'bad.b').write_text('main(){auto ; this is not B}\n')
        shutil.copyfile(root / 'tests/run/t24_ctime.b', work / 'clock.b')
        for case in ('t67_global_string_limits','t92_source_library','t93_source_printf','t94_source_library_data'):
            shutil.copyfile(root/'tests/run'/f'{case}.b', work/f'{case}.b')
        cases = [('long-string', 't67_global_string_limits.b', b'OK\n'), ('source-data','t94_source_library_data.b',b'OK\n'), ('source-library','t92_source_library.b',b'OK\n'), ('source-printf','t93_source_printf.b',b'custom\n'), ('valid', 'good.b', b'OK\n'), ('large-clock', 'clock.b', (root / 'tests/run/t24_ctime.out').read_bytes()), ('syntax-error', 'bad.b', None), ('missing-input', 'missing.b', None), ('unresolved-symbol', 'undef.b', None), ('oversized-program', 'large.b', None)]
        for name, source, expected in cases:
            result = subprocess.run([str(apout), str(work/'bin/b'), source], cwd=work, env=env, capture_output=True, timeout=30)
            ok = (result.returncode == 0) == (expected is not None)
            if name == 'unresolved-symbol':
                ok = ok and not (work/'a.out').exists()
            if name == 'oversized-program':
                ok = ok and b'program exceeds 16 KB' in result.stdout + result.stderr and not (work/'a.out').exists()
            if ok and expected is not None:
                data = (work/'a.out').read_bytes()
                header = struct.unpack_from('<6H', data)
                ok = header == (0o405, len(data), 0, 0, 0, 0)
                if not ok: print('header:', header, 'file size:', len(data))
                run = subprocess.run([str(apout), str(work/'a.out')], cwd=work, env=env, capture_output=True, timeout=5)
                ok = ok and run.returncode == 0 and run.stdout == expected
                if not ok: print('execution:', run.returncode, repr(run.stdout), repr(run.stderr))
            print(f'{"PASS" if ok else "FAIL"}: driver/{name}', flush=True)
            if not ok: print(result.returncode, repr(result.stdout), repr(result.stderr))
            passed += ok
            failed += not ok
        for name, target, diagnostic in [
            ('missing-completion', work/'usr/lib/bcc/b00', b'pass failed'),
            ('false-assembler-success', work/'bin/as', b'assembler failed'),
        ]:
            shutil.copyfile(root/'build/b00', work/'usr/lib/bcc/b00')
            saved = target.read_bytes()
            shutil.copyfile(work/'bin/echo', target)
            (work/'usr/tmp/b.ok').write_bytes(b'ok')
            result = subprocess.run([str(apout), str(work/'bin/b'), 'good.b'], cwd=work, env=env, capture_output=True, timeout=30)
            ok = result.returncode != 0 and diagnostic in result.stdout + result.stderr
            target.write_bytes(saved)
            print(f'{"PASS" if ok else "FAIL"}: driver/{name}', flush=True)
            if not ok: print(result.returncode, repr(result.stdout), repr(result.stderr))
            passed += ok
            failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
