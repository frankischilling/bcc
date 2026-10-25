#!/usr/bin/env python3
"""Compare host-built B resolvers with the native C reference, not a self-host."""
import argparse
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

NATIVE = Path(__file__).resolve().parents[1]
PROJECT = NATIVE.parents[1]
sys.path.insert(0, str(NATIVE / 'tools'))
from run_apout import build_snapshot_lock

RAW = [
    ('empty', '', None),
    ('blank-lines', '\n\n', None),
    ('function', 'Adef main\nn 0\nrt\nAend\n', None),
    ('global-string', 'gvb text 1\nGstr 4 65 0 255 4\ngve\n', None),
    ('compat-global', 'Acompat\ngvb data 1\ngvc 42\ngve\nAdef main\nRname data\nRderef\nAend\n', None),
    ('orphan-literal', 'Gstr 1 4\n', b'literal outside global definition'),
    ('unfinished-global', 'gvb x 0\n', b'unfinished global definition'),
    ('nested-global', 'gvb x 0\ngvb y 0\n', b'nested global definition'),
    ('orphan-end', 'gve\n', b'global end without definition'),
    ('orphan-value', 'gvc 0\n', b'initializer outside definition'),
    ('global-buffer', 'gvb x 0\n' + 'gvc 0\n'*350 + 'gve\n', b'global records too large'),
    ('line-buffer', 'x'*1040+'\n', b'IC line too long'),
    ('duplicate-local', 'Adef main\nAauto x\nAauto x\n', b'duplicate local name'),
    ('duplicate-argument', 'Adef main\nAarg x 0\nAarg x 1\n', b'duplicate parameter'),
    ('undefined-label', 'Adef main\nRname x\nAend\n', b'undefined internal label'),
    ('late-external', 'Adef main\nRname x\nAextrn x\n', b'external declaration follows internal use'),
    ('symbol-capacity', ''.join(f'Agvec n{i}\n' for i in range(201)), b'symbol table full'),
]
for field in ('32768', '-32769', '65536', '-65536', '99999999999999999999'):
    RAW.append(('range-'+field, 'Adef main\nAarg x '+field+'\n', b'IC integer out of range'))
for field in ('', '-', 'x', '1x', '--1'):
    RAW.append(('integer-'+field, 'Adef main\nAarg x '+field+'\n', b'bad IC integer'))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--bcc', type=Path, default=PROJECT/'bcc')
    parser.add_argument('--word', action='append', choices=('16', '32', 'host'))
    args = parser.parse_args()
    if not args.bcc.is_file():
        parser.error('host compiler missing; run make in the repository root')
    for name in ('b00', 'b01'):
        if not (NATIVE/'build'/name).is_file():
            parser.error('native compiler missing; run make -C pdp-11/bcc-pdp')
    passed = failed = rejected = 0
    with tempfile.TemporaryDirectory(prefix='bcc-B-resolver-') as directory:
        work = Path(directory)
        with build_snapshot_lock(NATIVE):
            for name in ('b00', 'b01'):
                shutil.copy2(NATIVE/'build'/name, work/name)
            shutil.copy2(NATIVE.parent/'unix-v1/tools/apout/apout', work/'apout')
        env = dict(os.environ, APOUT_ROOT=str(work))
        cases = []
        for kind in ('run', 'ext'):
            for source in sorted((NATIVE/'tests'/kind).glob('*.b')):
                (work/'input.b').write_bytes(source.read_bytes())
                front = subprocess.run([str(work/'apout'),str(work/'b00'),
                                        *(['-x'] if kind=='ext' else []),'-o','raw.ic','input.b'],
                                       cwd=work,env=env,capture_output=True,timeout=30)
                if front.returncode:
                    rejection = source.with_suffix('.reject')
                    if not rejection.exists() or rejection.read_bytes().strip() not in front.stdout+front.stderr:
                        print('FAIL: reference frontend/'+source.stem,repr(front.stderr))
                        failed += 1
                    else:
                        rejected += 1
                    continue
                cases.append((kind+'/'+source.stem, (work/'raw.ic').read_bytes(), 'compare'))
        cases += [('raw/'+name,text.encode(),diagnostic) for name,text,diagnostic in RAW]
        for word in args.word or ('16', '32', 'host'):
            candidate = work/'resolver'
            sources = [NATIVE/'bootstrap/src'/name for name in ('io.b','ic.b','symbols.b','b01.b')]
            build = subprocess.run([str(args.bcc.resolve()),'--strict','--pedantic','--word='+word,
                                    *map(str,sources),'-o',str(candidate)],capture_output=True,timeout=180)
            if build.returncode:
                print('FAIL: B resolver build/'+word,repr(build.stderr[-2000:]));failed += 1
                continue
            for name, data, diagnostic in cases:
                (work/'raw.ic').write_bytes(data)
                reference = subprocess.run([str(work/'apout'),str(work/'b01'),'-i','raw.ic'],
                                           cwd=work,env=env,capture_output=True,timeout=30)
                result = subprocess.run([str(candidate),'-i','raw.ic'],cwd=work,capture_output=True,timeout=30)
                ok = ((reference.returncode==0)==(result.returncode==0)
                      and reference.stdout==result.stdout and reference.stderr==result.stderr)
                if diagnostic is None:
                    ok = ok and result.returncode==0
                elif diagnostic != 'compare':
                    ok = ok and result.returncode!=0 and diagnostic in result.stdout+result.stderr
                print(f'{"PASS" if ok else "FAIL"}: B-resolver/{word}/{name}',flush=True)
                if not ok:
                    print(reference.returncode,result.returncode,repr(reference.stdout[-500:]),
                          repr(result.stdout[-500:]),repr(reference.stderr),repr(result.stderr),flush=True)
                passed += ok; failed += not ok
    print(f'Frontend rejection fixtures excluded from resolver comparison: {rejected}')
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
