#!/usr/bin/env python3
"""Do not execute or publish images from a diagnosed assembler failure."""
import argparse
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
from apout_image import validate_assembler_output


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--runner', type=Path, default=ROOT / 'tools/run_apout.py')
    args = parser.parse_args()
    passed = 0
    for output, error, accepted in (
        (b'I\nII\n', b'', True), (b'I\r\nII\r\n', b'', True),
        (b'', b'', False), (b'I\n', b'', False),
        (b'I\nII\nprogram.s\nu 0009\n', b'', False),
        (b'I\nII\n', b'error\n', False), (b'garbage\nI\nII\n', b'', False),
    ):
        try:
            validate_assembler_output(output, error)
            actual = True
        except ValueError:
            actual = False
        assert actual == accepted, (output, error, accepted)
        passed += 1
    print('PASS: assembler progress and diagnostic validation (7 cases)', flush=True)
    with tempfile.TemporaryDirectory(prefix='bcc-asm-diagnostics-') as directory:
        work = Path(directory)
        cases = [('valid', 'main(){return(0);}', True),
                 ('missing-call', 'main(){extrn missing;return(missing());}', False),
                 ('missing-data', 'main(){extrn missing;return(missing);}', False)]
        for name, source, accepted in cases:
            path = work / 'input.b'
            output = work / 'program.out'
            path.write_text(source + '\n')
            output.unlink(missing_ok=True)
            result = subprocess.run([sys.executable, str(args.runner.resolve()), '--emit-image',
                                     str(output), str(path)], capture_output=True, timeout=180)
            if accepted:
                assert result.returncode == 0 and output.is_file(), (name, result)
            else:
                assert result.returncode != 0 and not output.exists(), (name, result, output.exists())
                assert b'assembler reported unexpected diagnostics' in result.stderr, (name, result.stderr)
            passed += 1
            print('PASS: assembler diagnostics/' + name, flush=True)
    print(f'Results: {passed} passed, 0 failed')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
