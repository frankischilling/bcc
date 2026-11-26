#!/usr/bin/env python3
"""Compare native file-status adapters with V1-shaped host records."""
import argparse
import os
from pathlib import Path
import subprocess
import sys
import tempfile
from types import SimpleNamespace

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT.parents[1] / 'tests'))
from test_unix_metadata import EPOCH_NS, ERRORS, status_source, status_words

CASES = ('regular', 'owner-execute', 'group-execute', 'other-execute', 'boundary-small',
         'boundary-large', 'wrapped-size', 'wrapped-time', 'directory', 'symlink',
         'errors', 'private-packing', 'saved-stat', 'saved-fstat', 'source-definitions')


def prepare(case, name):
    case.mkdir(parents=True)
    target = case / 'file'
    if name == 'directory':
        target.mkdir()
        target.chmod(0o755)
    else:
        sizes = {'boundary-small': 4096, 'boundary-large': 4097, 'wrapped-size': 65539}
        target.write_bytes(b'x' * sizes.get(name, 3))
        mode = {'owner-execute': 0o744, 'group-execute': 0o654, 'other-execute': 0o645}.get(name, 0o644)
        target.chmod(mode)
    stamp = EPOCH_NS - 500_000_000 if name == 'wrapped-time' else EPOCH_NS + 1_500_000_000
    os.utime(target, ns=(stamp, stamp))
    if name == 'symlink':
        target.rename(case / 'target')
        target.symlink_to('target')
    source = ERRORS if name == 'errors' else status_source('file', status_words(target.stat()), 'host')
    if name == 'private-packing':
        source = 'char(s,i){return(4);}lchar(s,i,c){return(0);}' + source
    if name in ('saved-stat', 'saved-fstat'):
        function = name.removeprefix('saved-')
        call = 'stat("file",s)' if function == 'stat' else 'fstat(fd,t)'
        source = source.replace('auto a 22', 'auto old,a 22')
        source = source.replace('if(' + call, 'old=' + function + ';' + function + '=other;if(' + call.replace(function + '(', 'old(', 1))
        source = source.replace('return(0);', 'if(' + function + '(0,0)!=42)return(40);return(0);')
        source = 'other(p,b){return(42);}' + source
        source = source.replace('extrn want,', 'extrn other,want,')
    if name == 'source-definitions':
        source = 'stat(p,b){return(42);}fstat(f,b){return(43);}main(){return(stat(0,0)==42 & fstat(0,0)==43?0:1);}'
    return source


def execute(build, case, source):
    path = case / 'input.b'
    path.write_text(source)
    program = case / 'program'
    build(path.resolve(), program.resolve())
    result = subprocess.run([str(program.resolve())], cwd=case,
                            env=dict(os.environ, PATH=''), capture_output=True, timeout=10)
    assert (result.returncode, result.stdout, result.stderr) == (0, b'', b''), (case.name, result)


def synthetic_source(seconds):
    info = SimpleNamespace(st_ino=0x123456, st_mode=0o104744, st_uid=511,
                           st_nlink=0x123, st_size=65539,
                           st_ctime_ns=seconds * 1_000_000_000 + 500_000_000,
                           st_mtime_ns=EPOCH_NS + 999_999_999)
    raw = [0] * 18
    raw[1] = info.st_ino
    raw[2] = info.st_nlink
    raw[3] = (info.st_uid << 32) | info.st_mode
    raw[6] = info.st_size
    raw[11:15] = [31536000, 999999999, seconds, 500000000]
    return ('raw[18] ' + ','.join(map(str, raw)) + ';want[17] '
            + ','.join(map(str, status_words(info))) + ';'
            + 'main(){extrn raw,want,__stat;auto out 22,i;'
              'i=0;while(i<22)out[i++]=123;if(__stat(out+1,raw))return(1);'
              'i=0;while(i<17){if(out[i+1]!=want[i])return(10+i);i++;}'
              'if(out[0]!=123)return(30);i=18;while(i<22){if(out[i++]!=123)return(31);}return(0);}')


def reference_checks(command, work):
    def build(path, program):
        result = subprocess.run([*command, str(path), '-o', str(program)], capture_output=True, timeout=60)
        assert result.returncode == 0, result.stderr
    for name in CASES:
        case = Path(work) / name
        execute(build, case, prepare(case, name))
    print(f'{len(CASES)} file-status reference checks passed', flush=True)


def run_checks(tools, work):
    tools = Path(tools).resolve()
    def build(path, program):
        result = subprocess.run([str(tools / 'driver'), str(path), '-o', str(program)],
                                env=dict(os.environ, PATH=''), capture_output=True, timeout=60)
        assert (result.returncode, result.stdout, result.stderr) == (0, b'', b''), result
    for name in CASES:
        case = Path(work) / name
        execute(build, case, prepare(case, name))
    for index, seconds in enumerate((31535999, -1, -9223372036854775808, 9223372036854775807)):
        case = Path(work) / f'synthetic-{index}'
        case.mkdir()
        execute(build, case, synthetic_source(seconds))
    case = Path(work) / 'missing-arguments'
    case.mkdir()
    execute(build, case, 'main(){extrn stat,fstat;return(stat()==-1 & stat("file")==-1 & fstat()==-1 & fstat(0)==-1?0:1);}')
    print(f'{len(CASES) + 5} native file-status checks passed', flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tools', type=Path, required=True)
    parser.add_argument('--reference', type=Path)
    args = parser.parse_args()
    with tempfile.TemporaryDirectory(prefix='bcc-native-stat-') as directory:
        work = Path(directory)
        if args.reference:
            reference_checks([str(args.reference.resolve()), '--strict', '--pedantic', '--word=host'], work / 'reference')
        run_checks(args.tools, work / 'native')


if __name__ == '__main__':
    main()
