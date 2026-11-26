#!/usr/bin/env python3
"""Check B72 formatting and explicitly separate host compatibility formats."""
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
    modes = [('host', False)] if args.bootstrap else [(bits, inline) for bits in ('host', '16', '32') for inline in (False, True)]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-number-format-') as directory:
        work = Path(directory)
        for mode, inline in modes:
            bits = ctypes.sizeof(ctypes.c_void_p)*8 if mode == 'host' else int(mode)
            minimum = -(1 << (bits-1)); maximum = (1 << bits)-1
            min_expr = f'(-{(1 << (bits-1))-1}-1)'
            for strict in (False, True):
                cases = {
                    'basic': ('printf("%d %o %c %s*n",42,42,\'AB\',"hi");', b'42 52 AB hi\n'),
                    'unknown': ('printf("%q%d|%%d|end%",7,8);', b'%q7|%8|end%' if strict else b'%q7|%d|end%'),
                    'signed-octal': ('printf("%d %o*n",-17,-17);', f'-17 {"-21" if strict else format((1 << bits)-17,"o")}\n'.encode()),
                    'minimum': (f'printf("%d|",{min_expr});printn({min_expr},10);putchar(\'*n\');', f'{minimum}|{minimum}\n'.encode()),
                    'bases': ('printn(255,16);putchar(\'|\');printn(10,2);putchar(\'|\');printn(0,10);if(printn(1,0)!=-1 | printn(1,1)!=-1 | printn(1,17)!=-1)return(1);', b'FF|1010|0'),
                    'wide': ('printn(40000,10);', b'-25536' if bits == 16 else b'40000'),
                    'embedded-nul': ('printf("%s|A*0B","C*0D");putstr("|E*0F");', b'C\0D|A\0B|E\0F' if strict else b'C|A|E'),
                    'compat-formats': (f'printf("%u %p %zu %zd %%*n",-1,-1,-1,{min_expr});', b'%u %p %zu %zd %%\n' if strict else f'{maximum} 0x{maximum:x} {maximum} {minimum} %\n'.encode()),
                }
                for name, (body, expected) in cases.items():
                    source = work/'case.b'
                    source.write_text('main(){extrn printf,printn,putstr,putchar;'+body+'return(0);}\n')
                    command = [str(args.compiler.resolve())]
                    if strict: command += ['--strict', '--pedantic']
                    if not args.bootstrap: command += [f'--word={mode}']
                    if inline: command += ['--inline-runtime']
                    try:
                        result = subprocess.run([*command, str(source), '-o', str(work/'case')], capture_output=True, timeout=30)
                        if result.returncode == 0:
                            result = subprocess.run([str(work/'case')], input=b'', capture_output=True, timeout=10)
                        ok = result.returncode == 0 and result.stdout == expected
                        detail = repr((result.returncode, result.stdout, expected, result.stderr[-1500:]))
                    except (OSError, subprocess.TimeoutExpired) as error:
                        ok, detail = False, str(error)
                    print(f'{"PASS" if ok else "FAIL"}: formatting/{mode}/{"inline" if inline else "shared"}/{"strict" if strict else "compat"}/{name}', flush=True)
                    if not ok: print(detail)
                    passed += ok; failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
