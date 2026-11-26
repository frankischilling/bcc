#!/usr/bin/env python3
"""Check kbman 7.2 vector extents in generated storage and executable code."""
import argparse
from pathlib import Path
import re
import subprocess
import tempfile

CASES = {
    'character-automatic': ('', 9, "auto data '*t'; data[8]=7; return(data[8]!=7);"),
    'character-external': ("data['*t'];", 9, 'data[8]=7; return(data[8]!=7);'),
    'automatic': ('', 3, 'auto data 3; data[0]=1; data[2]=7; return(data[0]!=1 | data[2]!=7);'),
    'uninitialized': ('data[3];', 3, 'data[2]=7; return(data[0]!=0 | data[2]!=7);'),
    'padded': ('data[5] 3,4;', 5, 'return(data[0]!=3 | data[1]!=4 | data[4]!=0);'),
    'extended': ('data[2] 1,2,3,4;', 4, 'return(data[0]!=1 | data[3]!=4);'),
    'inferred': ('data[] 7,8,9;', 3, 'return(data[2]!=9);'),
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    passed = failed = 0
    modes = [('host', False)] if args.bootstrap else [(mode, inline) for mode in ('host', '16') for inline in (False, True)]
    with tempfile.TemporaryDirectory(prefix='bcc-vectors-') as directory:
        root = Path(directory)
        for mode, inline in modes:
            for name, (definition, extent, body) in CASES.items():
                source = root/'case.b'
                source.write_text(definition + '\nmain(){' + ('extrn data; ' if definition else '') + body + '}\n')
                command = [str(args.compiler.resolve()), '--strict', '--pedantic']
                if not args.bootstrap: command += [f'--word={mode}']
                if inline: command += ['--inline-runtime']
                result = subprocess.run([*command, '-S', str(source)], capture_output=True, timeout=30)
                match = re.search(rb'(?:static\s+)?word\s+(__[A-Za-z0-9_]*data_store)\b[^;]*;', result.stdout)
                ok = result.returncode == 0 and match is not None
                if ok:
                    # Compile a size assertion, rather than assuming a spelling
                    # for the constant expression emitted by either compiler.
                    check = root/'extent.c'
                    check.write_bytes(b'#include <stdint.h>\ntypedef intptr_t word;\n#define WVAL(x) (x)\n' + match[0] + f'\ntypedef char extent_check[(sizeof({match[1].decode()})/sizeof(word)=={extent})?1:-1];\n'.encode())
                    result = subprocess.run(['gcc', '-std=c99', '-c', str(check), '-o', str(root/'extent.o')], capture_output=True, timeout=30)
                    ok = result.returncode == 0
                if ok:
                    result = subprocess.run([*command, str(source), '-o', str(root/'case')], capture_output=True, timeout=30)
                    if result.returncode == 0:
                        result = subprocess.run([str(root/'case')], capture_output=True, timeout=10)
                    ok = result.returncode == 0 and result.stdout == b''
                print(f'{"PASS" if ok else "FAIL"}: vector/{mode}/{"inline" if inline else "shared"}/{name}', flush=True)
                if not ok: print(result.returncode, result.stderr.decode(errors='replace')[-2000:])
                passed += ok
                failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
