#!/usr/bin/env python3
"""Direct V1 launchers must build the same tools as the Makefile entry points."""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]


def test_make_target():
    with tempfile.TemporaryDirectory(prefix='bcc-v1-tools-') as directory:
        work = Path(directory)
        v1 = work / 'unix-v1'
        tools = v1 / 'tools'
        (tools / 'simh').mkdir(parents=True)
        (tools / 'simh/makefile').write_text('# dependency marker\n')
        (tools / 'mkfs.c').write_text('/* dependency marker */\n')
        (tools / 'Makefile').write_text('all: pdp11 mkfs\npdp11 mkfs:\n\tprintf ready > $@\n')
        process = subprocess.run(['make', '-f', str(ROOT / 'Makefile'), '_BCC_NATIVE_LOCKED=1',
                                  'V1=' + str(v1), 'v1-tools'], cwd=work, capture_output=True, timeout=30)
        if process.returncode:
            raise AssertionError((process.returncode, process.stdout, process.stderr))
        assert (tools / 'pdp11').read_text() == 'ready'
        assert (tools / 'mkfs').read_text() == 'ready'
        print('PASS: v1-tools builds missing emulator and filesystem builder')


def test_launcher(populated, launcher=None, *, mutate=False, shell="sh"):
    with tempfile.TemporaryDirectory(prefix='bcc-v1-launcher-') as directory:
        work = Path(directory)
        native = work / 'native'
        tools = native / 'tools'
        tools.mkdir(parents=True)
        v1 = work / 'unix-v1'
        (v1 / 'fs/root').mkdir(parents=True)
        source = work / 'input.b'
        source.write_text('main(){return(0);}\n')
        stage = v1 / 'fs/root/v1.b'
        if populated:
            stage.write_text('original staged source\n')
        for name in ('v1-run.sh', 'native-lock.sh'):
            shutil.copy2(launcher if name == 'v1-run.sh' and launcher else ROOT / 'tools' / name, tools / name)
        bin_dir = work / 'bin'
        bin_dir.mkdir()
        make = bin_dir / 'make'
        make.write_text('''#!/bin/sh
printf '%s\\n' "$*" >> "$TEST_ROOT/make.log"
case " $* " in
  *" v1-tools "*)
    mkdir -p "$TEST_ROOT/unix-v1/tools"
    : > "$TEST_ROOT/unix-v1/tools/pdp11"
    : > "$TEST_ROOT/unix-v1/tools/mkfs"
    ;;
esac
''')
        make.chmod(0o755)
        for name in ('install_v1.sh', 'rebuild_v1.sh'):
            script = tools / name
            script.write_text('''#!/bin/sh
set -e
[ -f "$TEST_ROOT/unix-v1/tools/pdp11" ]
[ -f "$TEST_ROOT/unix-v1/tools/mkfs" ]
''')
            script.chmod(0o755)
        smoke = 'print("OK")\n'
        if mutate:
            smoke = ('from pathlib import Path\nimport os\n'
                     'path=Path(os.environ["TEST_ROOT"])/"native/tools/v1-run.sh"\n'
                     'path.write_text("# launcher edited during guest execution\\n" + path.read_text())\n' + smoke)
        (tools / 'v1_smoke.py').write_text(smoke)
        env = dict(os.environ, PATH=str(bin_dir) + os.pathsep + os.environ['PATH'], TEST_ROOT=str(work))
        env.pop('_BCC_NATIVE_LOCKED', None)
        process = subprocess.run([shell, str(tools / 'v1-run.sh'), str(source)],
                                 cwd=work, env=env, capture_output=True, timeout=30)
        if process.returncode or process.stdout != b'OK\n':
            raise AssertionError((process.returncode, process.stdout, process.stderr))
        assert 'all v1-tools' in (work / 'make.log').read_text().splitlines()
        if populated:
            assert stage.read_text() == 'original staged source\n'
        else:
            assert not stage.exists()
        print(f'PASS: direct launcher/{shell}/{"existing" if populated else "clean"}/{"edited" if mutate else "unchanged"}')


def main():
    test_make_target()
    test_launcher(False)
    test_launcher(True)
    for shell in ('sh', 'bash'):
        for populated in (False, True):
            test_launcher(populated, mutate=True, shell=shell)
    print('Results: 7 passed, 0 failed')


if __name__ == '__main__':
    main()
