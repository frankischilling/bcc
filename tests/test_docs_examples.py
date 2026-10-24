#!/usr/bin/env python3
"""Compile and execute explicitly reviewed documentation examples."""
import argparse
import json
import os
from pathlib import Path
import re
import subprocess
import tempfile

EXAMPLE = re.compile(r'<!-- bcc-example (\{[^\n]+\}) -->\s*```b\n(.*?)\n```', re.S)


def main():
    root = Path(__file__).resolve().parents[1]
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=root/'bcc')
    backend = parser.add_mutually_exclusive_group()
    backend.add_argument('--bootstrap', action='store_true')
    backend.add_argument('--native', action='store_true')
    args = parser.parse_args()
    passed = failed = 0
    env = dict(os.environ)
    env.pop("B0FLAGS", None)
    env.pop("B00FLAGS", None)
    paths = [*sorted((root/'examples/b72').glob('*.b')), root/'README.md', *sorted((root/'wiki').glob('*.md')), *sorted((root/'docs').glob('*.md'))]
    with tempfile.TemporaryDirectory(prefix='bcc-docs-') as directory:
        work = Path(directory)
        for path in paths:
            text = path.read_text()
            matches = [(match[1], match[2]) for match in EXAMPLE.finditer(text)]
            if path.suffix == ".b":
                marker = re.match(r"/\* bcc-example (\{[^\n]+\}) \*/", text)
                matches = [(marker[1], text)] if marker else []
                if not marker:
                    print(f"FAIL: {path.name}: missing example metadata")
                    failed += 1
            if path.suffix != ".b" and text.count("<!-- bcc-example ") != len(matches):
                print(f"FAIL: {path.name}: malformed example marker")
                failed += 1
            for index, match in enumerate(matches, 1):
                meta = json.loads(match[0])
                if args.bootstrap and not meta.get('bootstrap'): continue
                if args.native and not meta.get('native'): continue
                source = work/'example.b'
                source.write_text(match[1]+'\n')
                modes = (False,) if args.bootstrap or args.native else (False, True)
                for inline in modes:
                    label = f'{path.relative_to(root)}:{index}/{"native" if args.native else "inline" if inline else "shared"}'
                    try:
                        if args.native:
                            command = [str(root/'pdp-11/bcc-pdp/tools/run-apout.sh'), '--timeout', '15', str(source)]
                        else:
                            command = [str(args.compiler.resolve()), '--strict', '--pedantic']
                            if not args.bootstrap: command += ['--word=16']
                            if inline: command += ['--inline-runtime']
                            build = subprocess.run([*command, str(source), '-o', str(work/'example')], cwd=work, capture_output=True, timeout=30)
                            if build.returncode: raise AssertionError(build.stderr.decode(errors='replace'))
                            command = [str(work/'example')]
                        run_dir = work / f'run-{passed+failed}'
                        run_dir.mkdir()
                        run = subprocess.run(command, env=env, cwd=run_dir, input=meta.get('stdin','').encode(), capture_output=True, timeout=60)
                        expected = meta['stdout'].encode()
                        if run.returncode != meta.get('exit',0) or run.stdout != expected:
                            raise AssertionError((run.returncode,run.stdout,expected,run.stderr))
                        passed += 1
                        print(f'PASS: {label}', flush=True)
                    except (OSError, AssertionError, subprocess.TimeoutExpired) as error:
                        failed += 1
                        print(f'FAIL: {label}: {error}', flush=True)
    if passed+failed == 0:
        print('FAIL: no documentation examples selected')
        failed += 1
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
