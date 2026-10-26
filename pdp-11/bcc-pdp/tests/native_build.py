#!/usr/bin/env python3
"""Reject bad native C builds even when the old driver leaves an a.out."""
import importlib.util
import os
from pathlib import Path
import shutil
import struct
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('native_compile_checks', ROOT/'tools/compile_native.py')
checks = importlib.util.module_from_spec(spec)
spec.loader.exec_module(checks)


def image(text=2, data=2, bss=2, magic=0o407):
    return struct.pack('<8H', magic, text, data, bss, 0, 0, 0, 0) + bytes(text + data)


class BuildChecks(unittest.TestCase):
    def test_progress(self):
        checks.validate_progress(b'I\nII\n', ['one.c'])
        checks.validate_progress(b'one.c:\r\nI\r\nII\r\ntwo.c:\r\nI\r\nII\r\n', ['one.c', 'two.c'])

    def test_diagnostics(self):
        for output in (b'', b'I\n', b'I\nII\nun: _end\n', b'I\nII\nsyntax error\n'):
            with self.assertRaises(ValueError): checks.validate_progress(output, ['one.c'])

    def test_source_names(self):
        for names in ([], ['bad\n.c'], ['-c'], ['../one.c'], ['toolong.c']):
            with self.assertRaises(ValueError): checks.validate_progress(b'I\nII\n', names)

    def test_short_header(self):
        for length in range(16):
            with self.assertRaises(ValueError): checks.validate_image(bytes(length))

    def test_bad_header(self):
        for data in (image(magic=0o405), image(text=0)):
            with self.assertRaises(ValueError): checks.validate_image(data)

    def test_alignment(self):
        for data in (image(text=1), image(data=1), image(bss=1)):
            with self.assertRaises(ValueError): checks.validate_image(data)

    def test_short_sections(self):
        with self.assertRaises(ValueError): checks.validate_image(image()[:-1])

    def test_stack_reserve(self):
        checks.validate_image(image(text=2, data=0, bss=15870), 512)
        with self.assertRaises(ValueError): checks.validate_image(image(text=2, data=0, bss=15872), 512)
        for reserve in (-1, 16385):
            with self.assertRaises(ValueError): checks.validate_image(image(), reserve)

    def test_symbols_may_follow_sections(self):
        checks.validate_image(image() + bytes(64))


def integration():
    apout = ROOT.parent/'unix-v1/tools/apout/apout'
    cases = [('valid', 'main(){write(1,"OK\\n",3);return(0);}', True),
             ('unresolved', 'main(){missing();return(0);}', False),
             ('syntax', 'main( {', False),
             ('oversized', 'huge[9000];main(){return(0);}', False)]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-native-build-') as directory:
        work = Path(directory)
        shutil.copytree(ROOT/'build/aroot', work, dirs_exist_ok=True)
        env = dict(os.environ, APOUT_ROOT=str(work))
        for name, source, accepted in cases:
            (work/'case.c').write_text(source+'\n')
            # A stale valid file must not conceal a failed compiler invocation.
            (work/'a.out').write_bytes(image())
            result = subprocess.run([sys.executable, str(ROOT/'tools/compile_native.py'),
                                     '--root', str(work), '--emulator', str(apout), 'case.c'],
                                    capture_output=True, timeout=120)
            if accepted:
                ok = result.returncode == 0 and (work/'a.out').is_file()
                if ok:
                    run = subprocess.run([str(apout), str(work/'a.out')], cwd=work, env=env,
                                         capture_output=True, timeout=10)
                    ok = run.returncode == 0 and run.stdout == b'OK\n' and not run.stderr
            else:
                ok = result.returncode != 0 and not (work/'a.out').exists()
            print(f'{"PASS" if ok else "FAIL"}: native-build/{name}', flush=True)
            if not ok: print(result.returncode, repr(result.stdout), repr(result.stderr))
            passed += ok; failed += not ok
    return passed, failed


def main():
    result = unittest.TextTestRunner().run(unittest.defaultTestLoader.loadTestsFromTestCase(BuildChecks))
    if not result.wasSuccessful(): return 1
    passed, failed = integration()
    print(f'Results: {result.testsRun + passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
