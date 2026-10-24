#!/usr/bin/env python3
"""Check stable object outputs, separate strict linking, and input preservation."""
import argparse
from pathlib import Path
import subprocess
import tempfile


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    args = parser.parse_args()
    compiler = str(args.compiler.resolve())
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-object-output-') as directory:
        root = Path(directory)
        for bits in ('host', '16'):
            for inline in (False, True):
                work = root/f'{bits}-{inline}'; work.mkdir()
                flags = ['--strict', '--pedantic', f'--word={bits}']
                if inline: flags.append('--inline-runtime')
                def run(*arguments):
                    return subprocess.run([compiler, *flags, *arguments], cwd=work, capture_output=True, timeout=30)
                def check(ok, label, detail=''):
                    nonlocal passed, failed
                    passed += bool(ok); failed += not ok
                    print(f'{"PASS" if ok else "FAIL"}: object/{bits}/{inline}/{label}', flush=True)
                    if not ok: print(detail)
                source = work/'part name.b'
                source.write_text('item 41; select(n){return(n+1);} malloc(n){return(n+2);} strlen(n){return(n+1);}\n')
                result = run('-c', str(source), '-o', 'part name.o')
                obj = work/'part name.o'
                ok = result.returncode == 0 and obj.is_file() and obj.read_bytes().startswith(b'\x7fELF')
                check(ok, 'named', result.stderr)
                caller = work/'caller.b'
                caller.write_text('main(){extrn select,item,malloc,strlen;auto saved;saved=select;select=malloc;if(select(item)!=43 | saved(item)!=42)return(1);select=saved;return(select(item)!=42 | malloc(item)!=43 | strlen(item)!=42);}\n')
                if ok:
                    result = run(str(caller), '-X', str(obj), '-o', 'linked')
                    if result.returncode == 0:
                        result = subprocess.run([str(work/'linked')], capture_output=True, timeout=10)
                    check(result.returncode == 0 and not result.stdout, 'separate-link', result.stderr)
                else: check(False, 'separate-link', 'object compilation failed')
                (work/'first.b').write_text('first(){return(1);}\n')
                (work/'second.b').write_text('second 2;\n')
                result = run('-c', 'first.b', 'second.b')
                check(result.returncode == 0 and (work/'first.o').is_file() and (work/'second.o').is_file()
                      and not list(work.glob('bcc_*.o')), 'default-names', result.stderr)
                result = run('-c', 'first.b', 'second.b', '-o', 'ambiguous.o')
                check(result.returncode != 0 and b'exactly one input' in result.stderr
                      and not (work/'ambiguous.o').exists(), 'ambiguous-output', result.stderr)
                for name in ('a','b'):
                    (work/name).mkdir(); (work/name/'same.b').write_text(name+'(){return(0);}\n')
                result = run('-c', 'a/same.b', 'b/same.b')
                check(result.returncode != 0 and b'same object path' in result.stderr
                      and not (work/'same.o').exists(), 'duplicate-basename', result.stderr)
                original = source.read_bytes()
                for alias, make_alias in [('hard.b', lambda p: p.hardlink_to(source)),
                                           ('soft.b', lambda p: p.symlink_to(source))]:
                    path = work/alias; make_alias(path)
                    result = run('-c', str(source), '-o', alias)
                    check(result.returncode != 0 and b'overwrite input' in result.stderr
                          and source.read_bytes() == original, alias+'-protected', result.stderr)
                generated = Path(str(source)+'.c')
                generated.symlink_to(source)
                result = run('--emit-c', str(source), '-o', 'kept')
                check(result.returncode != 0 and b'overwrite input' in result.stderr
                      and source.read_bytes() == original, 'generated-c-protected', result.stderr)
                result = run(str(source), '-o', str(source))
                check(result.returncode != 0 and b'overwrite input' in result.stderr
                      and source.read_bytes() == original, 'executable-protected', result.stderr)
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
