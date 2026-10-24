#!/usr/bin/env python3
"""Install into a temporary prefix, then compile with both runtime layouts."""
from pathlib import Path
import subprocess
import tempfile


def main():
    root = Path(__file__).resolve().parent.parent
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc install ') as directory:
        destination = Path(directory)
        subprocess.run(['make', 'install', f'DESTDIR={destination}', 'PREFIX=/usr/local'], cwd=root, check=True, timeout=60)
        compiler = destination/'usr/local/bin/bcc'
        source = destination/'pointer.b'
        source.write_text('main(){auto v 2;v[1]=42;return(*(v+1)!=42);}\n')
        for inline in (False, True):
            command = [str(compiler), '--strict', '--pedantic', '--word=16']
            if inline: command.append('--inline-runtime')
            result = subprocess.run([*command, str(source), '-o', str(destination/'program')], capture_output=True, timeout=30)
            if result.returncode == 0:
                result = subprocess.run([str(destination/'program')], capture_output=True, timeout=5)
            ok = result.returncode == 0
            print(f'{"PASS" if ok else "FAIL"}: installed/{"inline" if inline else "shared"}')
            if not ok: print(result.stderr.decode(errors='replace'))
            passed += ok
            failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
