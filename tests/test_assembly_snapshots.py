#!/usr/bin/env python3
"""Reject missing, stale or incomplete generated assembly snapshots."""
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile


def main():
    root = Path(__file__).resolve().parents[1]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-snapshot-check-') as directory:
        work = Path(directory)
        (work / 'bcc-c').mkdir()
        for source in (root / 'bcc-c').iterdir():
            if source.suffix in ('.c', '.h'):
                shutil.copyfile(source, work / 'bcc-c' / source.name)
        shutil.copytree(root / 'bccasm/generated', work / 'bccasm/generated',
                        ignore=shutil.ignore_patterns('*.o'))
        script = work / 'bccasm/regenerate.py'
        shutil.copyfile(root / 'bccasm/regenerate.py', script)
        manifest = work / 'bccasm/generated/manifest.json'
        original = manifest.read_bytes()

        def check(name, expected, diagnostic=b''):
            nonlocal passed, failed
            result = subprocess.run([sys.executable, str(script), '--check'],
                                    capture_output=True, timeout=15)
            ok = result.returncode == expected and diagnostic in result.stderr
            print(f'{"PASS" if ok else "FAIL"}: snapshot/{name}', flush=True)
            if not ok:
                print(result.returncode, repr(result.stderr))
            passed += ok
            failed += not ok

        check('original', 0)
        for name, change, diagnostic in (
            ('empty-assembly', lambda m: m.update(assembly={}), b'every generated source'),
            ('missing-assembly', lambda m: m['assembly'].pop('lexer.s'), b'every generated source'),
            ('unexpected-assembly', lambda m: m['assembly'].update(other='0'), b'every generated source'),
            ('flags', lambda m: m.update(flags=[]), b'compiler flags'),
            ('stale-source', lambda m: m['sources'].update({'bcc-c/lexer.c': '0'}), b'stale'),
        ):
            data = json.loads(original)
            change(data)
            manifest.write_text(json.dumps(data))
            check(name, 2, diagnostic)
        manifest.write_bytes(original)
        (work / 'bccasm/generated/lexer.s').unlink()
        check('missing-file', 2, b'lexer.s')
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
