#!/usr/bin/env python3
"""Runtime caches must be private; unsafe locations fall back without mutation."""
import argparse
import os
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
import uuid

ROOT = Path(__file__).resolve().parents[1]
DEPENDENCIES = ('libb.c', 'libb.h', 'btarget.h', 'binit.h', 'bcall.h',
                'bunix.h', 'bformat.h', 'bprimitives.h')


def key(library):
    value = 14695981039346656037
    for name in DEPENDENCIES:
        for byte in (library / name).read_bytes():
            value = ((value ^ byte) * 1099511628211) & ((1 << 64) - 1)
    return value


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=ROOT / 'bcc')
    args = parser.parse_args()
    passed = 0
    with tempfile.TemporaryDirectory(prefix='bcc runtime cache ') as directory:
        work = Path(directory)
        tool = work / 'tool'
        tool.mkdir()
        shutil.copy2(args.compiler.resolve(), tool / 'bcc')
        shutil.copytree(ROOT / 'lib', tool / 'lib')
        with (tool / 'lib/libb.c').open('a') as stream:
            stream.write('\n/* isolated cache fixture ' + uuid.uuid4().hex + ' */\n')
        cache = work / 'cache'

        def build(label, location=cache, word='host'):
            nonlocal passed
            source = work / (label + '.b')
            source.write_text('main(){return(42);}')
            output = work / (label + '.program')
            env = dict(os.environ, BCC_CACHE_DIR=str(location))
            command = [str(tool / 'bcc'), '--strict', '--pedantic', '--wordptr',
                       '--word=' + word, '--emit-c', '-v', str(source), '-o', str(output)]
            result = subprocess.run(command, cwd=work, env=env, capture_output=True, timeout=60)
            assert result.returncode == 0, (label, result.stderr)
            run = subprocess.run([str(output)], cwd=work, capture_output=True, timeout=10)
            assert (run.returncode, run.stdout, run.stderr) == (42, b'', b''), (label, run)
            for path in re.findall(rb'(/tmp/bcc-libb-[A-Za-z0-9]{6})(?=\s|$)', result.stderr):
                assert not Path(os.fsdecode(path)).exists(), (label, path)
            passed += 1
            return result

        # Never consume the old shared pathname, even when it is readable.
        old = Path(f'/tmp/bcc_libb_{key(tool / "lib"):016x}_0_0_1.o')
        descriptor = os.open(old, os.O_CREAT | os.O_EXCL | os.O_WRONLY, 0o644)
        try:
            os.write(descriptor, b'not a runtime object\n')
            os.close(descriptor)
            build('public-cache')
            assert old.read_bytes() == b'not a runtime object\n'
        finally:
            old.unlink()
        assert cache.stat().st_uid == os.geteuid() and cache.stat().st_mode & 0o777 == 0o700
        objects = list(cache.glob('*.o'))
        assert len(objects) == 1
        obj = objects[0]
        assert obj.stat().st_mode & 0o777 == 0o600
        contents = obj.read_bytes()
        identity = (obj.stat().st_ino, obj.stat().st_mtime_ns)
        result = build('reuse')
        assert b'Compiling runtime library' not in result.stderr
        assert identity == (obj.stat().st_ino, obj.stat().st_mtime_ns)
        obj.write_bytes(b'bad shared-mode object')
        obj.chmod(0o644)
        build('unsafe-object')
        assert obj.read_bytes() == contents and obj.stat().st_mode & 0o777 == 0o600
        victim = work / 'neighbor'
        victim.write_bytes(b'leave this file alone')
        victim.chmod(0o600)
        obj.unlink()
        obj.symlink_to(victim)
        build('object-symlink')
        assert not obj.is_symlink() and victim.read_bytes() == b'leave this file alone'
        obj.unlink()
        os.link(victim, obj)
        build('object-hardlink')
        assert victim.read_bytes() == b'leave this file alone' and obj.read_bytes() == contents
        obj.write_bytes(b'')
        build('empty-object')
        assert obj.read_bytes() == contents
        obj.unlink()
        obj.mkdir()
        build('blocked-cache-publish')
        assert obj.is_dir() and list(cache.iterdir()) == [obj]
        obj.rmdir()
        obj.write_bytes(b'unsafe directory marker')
        cache.chmod(0o777)
        build('unsafe-directory')
        assert obj.read_bytes() == b'unsafe directory marker' and cache.stat().st_mode & 0o777 == 0o777
        cache.chmod(0o700)
        link = work / 'cache-link'
        link.symlink_to(cache, target_is_directory=True)
        build('directory-symlink', link)
        build('directory-symlink-slash', str(link) + '/')
        assert link.is_symlink() and obj.read_bytes() == b'unsafe directory marker'
        blocked = work / 'not-a-directory'
        blocked.write_bytes(b'preserve')
        build('directory-file', blocked)
        assert blocked.read_bytes() == b'preserve'
        build('missing-parent', work / 'absent/cache')
        assert not (work / 'absent').exists()
        build('word16', work / 'word16-cache', word='16')
        build('word32', work / 'word32-cache', word='32')

        parallel = work / 'parallel-cache'
        jobs = []
        for index in range(4):
            source = work / f'parallel-{index}.b'
            source.write_text('main(){return(42);}')
            output = work / f'parallel-{index}.program'
            command = [str(tool / 'bcc'), '--strict', '--pedantic', '--wordptr', '--emit-c',
                       str(source), '-o', str(output)]
            jobs.append((output, subprocess.Popen(command, cwd=work,
                         env=dict(os.environ, BCC_CACHE_DIR=str(parallel)),
                         stdout=subprocess.PIPE, stderr=subprocess.PIPE)))
        for output, job in jobs:
            stdout, stderr = job.communicate(timeout=60)
            assert job.returncode == 0, stderr
            assert subprocess.run([str(output)], timeout=10).returncode == 42
            passed += 1
        assert len(list(parallel.iterdir())) == 1

        foreign = work / 'foreign-cache'
        foreign.mkdir(mode=0o700)
        probe = work / 'owner-probe'
        subprocess.run(['gcc', '-std=c99', '-I', str(ROOT / 'src'),
                        str(ROOT / 'src/runtime_cache.c'),
                        str(ROOT / 'tests/fixtures/runtime_cache_owner.c'), '-o', str(probe)],
                       check=True, timeout=30)
        run = subprocess.run([str(probe), str(tool / 'lib')],
                             env=dict(os.environ, BCC_CACHE_DIR=str(foreign)),
                             capture_output=True, timeout=60, text=True)
        assert run.returncode == 0 and not list(foreign.iterdir()), run
        assert run.stdout.startswith('/tmp/bcc-libb-') and not Path(run.stdout.strip()).exists()
        passed += 1
    print(f'Results: {passed} passed, 0 failed')


if __name__ == '__main__':
    main()
