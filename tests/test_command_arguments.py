#!/usr/bin/env python3
"""Check the shell-free system extension in both runtime layouts."""
import argparse
from pathlib import Path
import subprocess
import tempfile


def literal(text):
    return '"' + text.replace('\\', '\\\\').replace('*', '**').replace('"', '*"').replace('\n', '*n') + '"'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    args = parser.parse_args()
    cases = [
        ("printf '%s|%s|%s|%s' 'two words' '' 'it'\\''s' '$HOME;*'", b"two words||it's|$HOME;*", False),
        ('printf "%s" "double quoted value"', b'double quoted value', False),
        ('printf %s escaped\\ space', b'escaped space', False),
        ("printf 'unfinished", b'', True),
        ('printf trailing\\', b'', True),
        ('', b'', True),
    ]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-command-') as directory:
        root = Path(directory)
        for inline in (False, True):
            for index, (command, output, reject) in enumerate(cases):
                path = root / 'case.b'
                path.write_text('main(){extrn system; return(system(' + literal(command) + ')!=' + ('-1' if reject else '0') + ');}\n')
                flags = ['--inline-runtime'] if inline else []
                build = subprocess.run([str(args.compiler.resolve()), *flags, str(path), '-o', str(root / 'case')], capture_output=True)
                run = subprocess.run([str(root / 'case')], capture_output=True, timeout=5) if build.returncode == 0 else build
                ok = run.returncode == 0 and run.stdout == output
                print(f'{"PASS" if ok else "FAIL"}: {"inline" if inline else "shared"}/command-{index}')
                if not ok:
                    print(repr(run.stdout), repr(run.stderr))
                passed += ok
                failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
