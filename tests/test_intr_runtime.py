#!/usr/bin/env python3
"""Exercise the historical intr modes without signaling the test runner."""
import argparse
from pathlib import Path
import select
import signal
import subprocess
import tempfile


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    compiler = str(args.compiler.resolve())
    cases = [
        ('ignore', 'if(CALL(0))return(3);', 0),
        ('default', 'if(CALL(1))return(3);', -signal.SIGINT),
        ('restore-default', 'CALL(0);if(CALL(1))return(3);', -signal.SIGINT),
        ('restore-ignore', 'CALL(1);if(CALL(0))return(3);', 0),
        ('unsupported-address', 'CALL(0);if(CALL(handler)!=-1)return(4);', 0),
        ('unsupported-number', 'CALL(0);if(CALL(2)!=-1)return(4);', 0),
        ('unsupported-negative', 'CALL(0);if(CALL(-1)!=-1)return(4);', 0),
    ]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-intr-') as directory:
        root = Path(directory)
        for bits in (('host',) if args.bootstrap else ('host', '16', '32')):
            for inline in ((False,) if args.bootstrap else (False, True)):
                for indirect in (False, True):
                    for name, setup, expected in cases:
                        source = root / 'case.b'
                        exe = root / 'case'
                        body = setup.replace('CALL', 'saved' if indirect else 'intr')
                        source.write_text('handler(){return(0);}\nmain(){'
                                          'extrn intr,putchar,getchar,handler;'
                                          'auto saved;saved=intr;' + body +
                                          "putchar('R');getchar();return(0);}\n")
                        label = f'intr/{bits}/{inline}/{indirect}/{name}'
                        child = None
                        try:
                            flags = ['--strict', '--pedantic']
                            if not args.bootstrap:
                                flags.append('--word=' + bits)
                            if inline:
                                flags.append('--inline-runtime')
                            build = subprocess.run([compiler, *flags, str(source), '-o', str(exe)],
                                                   capture_output=True, timeout=30)
                            if build.returncode:
                                raise AssertionError(build.stderr[-1500:])
                            child = subprocess.Popen([str(exe)], stdin=subprocess.PIPE,
                                                     stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                            ready = select.select([child.stdout], [], [], 5)[0]
                            if not ready or child.stdout.read(1) != b'R':
                                raise AssertionError('program did not install the requested disposition')
                            child.send_signal(signal.SIGINT)
                            out, err = child.communicate(b'\n', timeout=5)
                            if child.returncode != expected or out or err:
                                raise AssertionError((child.returncode, expected, out, err))
                            print('PASS: ' + label)
                            passed += 1
                        except (AssertionError, OSError, subprocess.TimeoutExpired) as error:
                            print('FAIL: ' + label + ': ' + str(error))
                            failed += 1
                        finally:
                            if child is not None:
                                if child.poll() is None:
                                    child.kill()
                                child.communicate()
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
