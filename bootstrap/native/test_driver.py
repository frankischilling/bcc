#!/usr/bin/env python3
"""Check the native B driver in a private copy of an exported tool bundle."""
import argparse
import os
import platform
try:
    import resource
except ImportError:
    resource = None
from pathlib import Path
import shutil
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[1]
TOOLS = ('front', 'resolve', 'construct', 'image', 'driver')


def run_checks(tools, work, source_dir, tool_names=TOOLS):
    if platform.system() != 'Linux' or platform.machine().lower() not in ('x86_64', 'amd64'):
        print('SKIP: native driver checks require Linux x86-64')
        return
    work = Path(work).resolve()
    work.mkdir(parents=True, exist_ok=True)
    previous = work / 'tools'
    previous.mkdir()
    origin = Path(tools).resolve()
    for name in TOOLS:
        shutil.copy2(origin / name, previous / name)
    (previous / 'sources').mkdir()
    for path in (origin / 'sources').glob('*.b'):
        shutil.copy2(path, previous / 'sources' / path.name)
    scratch = work / 'cases'
    scratch.mkdir()
    source = Path(source_dir).resolve()
    text = tuple(tool_names)
    env = dict(os.environ, PATH='')
    sentinels = {name: b'caller-owned ' + name.encode() for name in
                 ('raw.ic', 'resolved.ic', 'code', 'data', 'imports', 'layout')}
    for name, content in sentinels.items():
        (scratch / name).write_bytes(content)
    driver_cases = [
        ('main(){return(42);}', 42, b''),
        ((PROJECT / 'examples/native-hello.b').read_text(), 0, b'hello from native B\n'),
        ('execv 42;main(){extrn execv;return(execv);}', 42, b''),
        ('execv(a,b,c){return(42);}main(){return(execv(0,0,0));}', 42, b''),
        ('main(){extrn execv;return(execv("missing",0,0)==-1?42:0);}', 42, b''),
    ]
    for index, (content, status, output) in enumerate(driver_cases):
        path = scratch / "driver input's.b"
        path.write_text(content)
        result = subprocess.run([str(previous / 'driver'), path.name], cwd=scratch,
                                env=env, capture_output=True, timeout=60)
        assert (result.returncode, result.stderr) == (0, b''), (index, result)
        program = scratch / 'driver-result'
        program.write_bytes(result.stdout)
        program.chmod(0o700)
        result = subprocess.run([str(program)], cwd=scratch, env=env,
                                capture_output=True, timeout=10)
        assert (result.returncode, result.stdout, result.stderr) == (status, output, b''), (index, result)
    (scratch / 'prefix.b').write_text('main(){return(7);}')
    for filename in ('prefix.b\x04tail', 'nonascii-\udcff.b'):
        path = scratch / filename
        path.write_text('main(){return(42);}')
        result = subprocess.run([str(previous / 'driver'), filename], cwd=scratch,
                                env=env, capture_output=True, timeout=60)
        assert (result.returncode, result.stderr) == (0, b''), (filename, result)
        program = scratch / 'path-result'
        program.write_bytes(result.stdout)
        program.chmod(0o700)
        result = subprocess.run([str(program)], cwd=scratch, env=env, capture_output=True, timeout=10)
        assert (result.returncode, result.stdout, result.stderr) == (42, b'', b''), result
    odd = work / 'tool\x04directory'
    shutil.copytree(previous, odd)
    result = subprocess.run([str(odd / 'driver'), str(source / 'image.b')], cwd=scratch,
                            env=env, capture_output=True, timeout=60)
    assert (result.returncode, result.stderr) == (0, b''), result
    assert result.stdout == (previous / 'image').read_bytes()
    path = scratch / 'named-input.b'
    path.write_text('main(){return(42);}')
    output = scratch / 'named-output'
    result = subprocess.run([str(previous / 'driver'), path.name, '-o', output.name], cwd=scratch,
                            env=env, capture_output=True, timeout=60, umask=0o022)
    assert (result.returncode, result.stdout, result.stderr) == (0, b'', b''), result
    assert output.stat().st_mode & 0o777 == 0o700
    run = subprocess.run([str(output)], cwd=scratch, env=env, capture_output=True, timeout=10)
    assert (run.returncode, run.stdout, run.stderr) == (42, b'', b''), run
    for destination in (output, path):
        original = destination.read_bytes()
        mode = destination.stat().st_mode
        result = subprocess.run([str(previous / 'driver'), path.name, '-o', str(destination)],
                                cwd=scratch, env=env, capture_output=True, timeout=60)
        assert result.returncode != 0 and not result.stdout and result.stderr, result
        assert destination.read_bytes() == original and destination.stat().st_mode == mode
    alias = scratch / 'output-link'
    alias.symlink_to(path.name)
    original = path.read_bytes()
    result = subprocess.run([str(previous / 'driver'), path.name, '-o', alias.name], cwd=scratch,
                            env=env, capture_output=True, timeout=60)
    assert result.returncode != 0 and alias.is_symlink() and path.read_bytes() == original, result
    odd_output = scratch / 'output\x04directory'
    odd_output.mkdir()
    result = subprocess.run([str(previous / 'driver'), path.name, '-o', str(odd_output / 'program')],
                            cwd=scratch, env=env, capture_output=True, timeout=60)
    assert (result.returncode, result.stdout, result.stderr) == (0, b'', b''), result
    run = subprocess.run([str(odd_output / 'program')], capture_output=True, timeout=10)
    assert run.returncode == 42, run
    assert not list(scratch.glob('.bcc-output-*')) and not list(odd_output.glob('.bcc-output-*'))
    hard = scratch / 'hard-output'
    os.link(path, hard)
    dangling = scratch / 'dangling-output'
    dangling.symlink_to('absent-output')
    for destination in (hard, dangling):
        result = subprocess.run([str(previous / 'driver'), path.name, '-o', destination.name],
                                cwd=scratch, env=env, capture_output=True, timeout=60)
        assert result.returncode != 0 and not result.stdout and result.stderr, result
    assert hard.read_bytes() == path.read_bytes() and dangling.is_symlink()
    assert not (scratch / 'absent-output').exists()
    mask_output = scratch / 'masked-output'
    result = subprocess.run([str(previous / 'driver'), path.name, '-o', mask_output.name], cwd=scratch,
                            env=env, capture_output=True, timeout=60, umask=0o111)
    assert (result.returncode, result.stdout, result.stderr) == (0, b'', b''), result
    assert mask_output.stat().st_mode & 0o777 == 0o600
    assert mask_output.read_bytes() == output.read_bytes()
    private_output = scratch / 'private-output'
    result = subprocess.run([str(previous / 'driver'), path.name, '-o', private_output.name], cwd=scratch,
                            env=env, capture_output=True, timeout=60, umask=0o777)
    assert (result.returncode, result.stdout, result.stderr) == (0, b'', b''), result
    assert private_output.stat().st_mode & 0o777 == 0
    assert private_output.stat().st_size == output.stat().st_size

    strange = odd_output / 'program\x04tail-\udcff'
    result = subprocess.run([str(previous / 'driver'), path.name, '-o', str(strange)], cwd=scratch,
                            env=env, capture_output=True, timeout=60)
    assert (result.returncode, result.stdout, result.stderr) == (0, b'', b''), result
    assert strange.read_bytes() == output.read_bytes()
    winner = scratch / 'race-output'
    jobs = [subprocess.Popen([str(previous / 'driver'), path.name, '-o', winner.name], cwd=scratch,
                             env=env, stdout=subprocess.PIPE, stderr=subprocess.PIPE) for _ in range(2)]
    codes = []
    for job in jobs:
        stdout, stderr = job.communicate(timeout=60)
        assert not stdout and (not stderr if job.returncode == 0 else bool(stderr))
        if job.returncode:
            assert b'output already exists' in stderr, stderr
        codes.append(job.returncode)
    assert sorted(codes) == [0, 1], codes
    assert winner.read_bytes() == output.read_bytes()
    def limit_file_size():
        resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
        resource.setrlimit(resource.RLIMIT_FSIZE, (4096, 4096))
    limited = scratch / 'limited-output'
    result = subprocess.run([str(previous / 'driver'), path.name, '-o', limited.name], cwd=scratch,
                            env=env, capture_output=True, timeout=60, preexec_fn=limit_file_size)
    assert result.returncode != 0 and not result.stdout and not limited.exists(), result
    (scratch / 'invalid.b').write_text('main(){return(; }')
    invalid_output = scratch / 'invalid-output'
    result = subprocess.run([str(previous / 'driver'), 'invalid.b', '-o', invalid_output.name], cwd=scratch,
                            env=env, capture_output=True, timeout=60)
    assert result.returncode != 0 and not result.stdout and not invalid_output.exists(), result
    for target in ('', 'missing-directory/program'):
        result = subprocess.run([str(previous / 'driver'), path.name, '-o', target], cwd=scratch,
                                env=env, capture_output=True, timeout=60)
        assert result.returncode != 0 and not result.stdout and result.stderr, result
    assert not list(scratch.glob('.bcc-output-*')) and not list(odd_output.glob('.bcc-output-*'))
    for content in ('main(){return(unknown());}', 'main(){return(;}', None):
        path = scratch / 'bad-driver.b'
        if content is None:
            path.unlink(missing_ok=True)
        else:
            path.write_text(content)
        result = subprocess.run([str(previous / 'driver'), path.name], cwd=scratch,
                                env=env, capture_output=True, timeout=60)
        assert result.returncode != 0 and not result.stdout and result.stderr, (content, result)
    jobs = []
    for index in range(2):
        path = scratch / f'parallel{index}.b'
        path.write_text(f'main(){{return({40 + index});}}')
        jobs.append(subprocess.Popen([str(previous / 'driver'), path.name], cwd=scratch,
                                     env=env, stdout=subprocess.PIPE, stderr=subprocess.PIPE))
    for index, job in enumerate(jobs):
        output, errors = job.communicate(timeout=60)
        assert (job.returncode, errors) == (0, b''), (index, errors)
        program = scratch / f'parallel{index}'
        program.write_bytes(output)
        program.chmod(0o700)
        result = subprocess.run([str(program)], cwd=scratch, env=env, capture_output=True, timeout=10)
        assert (result.returncode, result.stdout, result.stderr) == (40 + index, b'', b''), result
    assert all((scratch / name).read_bytes() == data for name, data in sentinels.items())
    for missing, content in [
        (previous / 'front', 'main(){return(0);}'),
        (previous / 'sources/execv.b', 'main(){extrn execv;return(execv("missing",0,0));}'),
        (previous / 'sources/printf.b', 'main(){extrn printf;printf("X");return(0);}'),
        (previous / 'sources/putchar.b', 'main(){extrn printf;printf("X");return(0);}'),
    ]:
        backup = missing.with_name(missing.name + '.saved')
        missing.rename(backup)
        try:
            (scratch / 'missing.b').write_text(content)
            result = subprocess.run([str(previous / 'driver'), 'missing.b'], cwd=scratch,
                                    env=env, capture_output=True, timeout=60)
            assert result.returncode != 0 and not result.stdout and result.stderr, (missing, result)
        finally:
            backup.rename(missing)
    library = previous / 'sources/printf.b'
    original = library.read_bytes()
    try:
        library.write_text('notprint(){return(0);}')
        (scratch / 'bad-provider.b').write_text('main(){extrn printf;printf("X");return(0);}')
        result = subprocess.run([str(previous / 'driver'), 'bad-provider.b'], cwd=scratch,
                                env=env, capture_output=True, timeout=60)
        assert result.returncode != 0 and not result.stdout and b'did not define' in result.stderr, result
    finally:
        library.write_bytes(original)
    (scratch / 'full.b').write_text('main(){return(0);}')
    if Path('/dev/full').exists():
        with open('/dev/full', 'wb') as sink:
            result = subprocess.run([str(previous / 'driver'), 'full.b'], cwd=scratch,
                                    env=env, stdout=sink, stderr=subprocess.PIPE, timeout=60)
            assert result.returncode != 0 and result.stderr, result
    result = subprocess.run([str(previous / 'driver')], cwd=scratch,
                            env=env, capture_output=True, timeout=10)
    assert result.returncode == 2 and not result.stdout and b'usage:' in result.stderr, result
    assert all((scratch / name).read_bytes() == data for name, data in sentinels.items())
    print('Native B driver checks passed, including paths, atomic output, races, and failed dependencies')
    for name in text:
        result = subprocess.run([str(previous / 'driver'), str(source / (name + '.b'))],
                                cwd=scratch, env=env, capture_output=True, timeout=180)
        assert (result.returncode, result.stderr) == (0, b''), (name, result)
        assert result.stdout == (previous / name).read_bytes(), name
        named = scratch / ('rebuilt-' + name)
        result = subprocess.run([str(previous / 'driver'), str(source / (name + '.b')), '-o', str(named)],
                                cwd=scratch, env=env, capture_output=True, timeout=180, umask=0o022)
        assert (result.returncode, result.stdout, result.stderr) == (0, b'', b''), (name, result)
        assert named.read_bytes() == (previous / name).read_bytes() and named.stat().st_mode & 0o100
        if name == 'driver':
            result = subprocess.run([str(named)], env=env, capture_output=True, timeout=10)
            assert result.returncode == 2 and b'usage:' in result.stderr, result
        print(f'Native B driver rebuilt {name} byte-for-byte, including named executable output', flush=True)




def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tools', type=Path, required=True)
    parser.add_argument('--sources', type=Path)
    args = parser.parse_args()
    with tempfile.TemporaryDirectory(prefix='bcc-native-driver-') as directory:
        run_checks(args.tools, Path(directory), args.sources or args.tools / 'sources')


if __name__ == '__main__':
    main()
