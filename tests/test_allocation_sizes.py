#!/usr/bin/env python3
"""Reject invalid allocation sizes before converting words to host bytes."""
import argparse
import ctypes
from pathlib import Path
import subprocess
import tempfile


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    host_bits = ctypes.sizeof(ctypes.c_void_p)*8
    overflow = (1 << host_bits)//ctypes.sizeof(ctypes.c_void_p)
    modes = [('host',False)] if args.bootstrap else [(bits,inline) for bits in ('host','16','32') for inline in (False,True)]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-allocation-sizes-') as directory:
        work = Path(directory)
        for bits, inline in modes:
            width = host_bits if bits == 'host' else int(bits)
            minimum = f'(-{(1 << (width-1))-1}-1)'
            cases = {
                'valid': ('p=alloc(4);p[0]=11;p[3]=42;if(p[0]!=11 | p[3]!=42)return(2);free(p);free(0);', False),
                'zero': ('p=alloc(0);if(!p)return(2);free(p);', False),
                'negative': ('p=alloc(-1);free(p);', True),
                'minimum': (f'p=alloc({minimum});free(p);', True),
                'function-values': ('f=alloc;g=free;p=f(2);p[1]=42;if(p[1]!=42)return(2);g(p);', False),
            }
            if bits == 'host': cases['byte-overflow'] = (f'p=alloc({overflow});free(p);', True)
            for strict in (False,True):
                for name,(body,reject) in cases.items():
                    source = work/'case.b'
                    source.write_text('main(){extrn alloc,free;auto p,f,g;'+body+'return(0);}\n')
                    command = [str(args.compiler.resolve())]
                    if strict: command += ['--strict','--pedantic']
                    if not args.bootstrap: command += [f'--word={bits}']
                    if inline: command.append('--inline-runtime')
                    try:
                        result = subprocess.run([*command,str(source),'-o',str(work/'case')],capture_output=True,timeout=30)
                        built = result.returncode == 0
                        if built: result = subprocess.run([str(work/'case')],input=b'',capture_output=True,timeout=10)
                        ok = built and not result.stdout and (result.returncode == 1 and b'alloc: invalid size' in result.stderr if reject else result.returncode == 0)
                        detail = repr((result.returncode,result.stdout,result.stderr[-1200:]))
                    except (OSError, subprocess.TimeoutExpired) as error:
                        ok,detail=False,str(error)
                    print(f'{"PASS" if ok else "FAIL"}: alloc/{bits}/{inline}/{strict}/{name}',flush=True)
                    if not ok: print(detail)
                    passed += ok; failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
