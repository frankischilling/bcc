#!/usr/bin/env python3
"""Check copied argument capacity and rejection before it reaches program data."""
from pathlib import Path
import subprocess
import tempfile


def main():
    root = Path(__file__).resolve().parents[1]
    cases = [
        ('capacity', '''main(count,values){extrn argv,char,putchar;
            if(count!=30 | argv[0]!=31 | values[29]!=argv[31])return(1);
            if(char(argv[31],0)!='x')return(2);
            putchar('OK');putchar('*n');return(0);}''', ['x']*40, 0, b'OK\n'),
        # The fast observer has a larger stack address range than V1. Both use
        # the same startup bounds check against the assembled program end.
        ('overlap', 'main(){return(99);}', ['x'*1024]*30, 1, b'bcc: argument storage\n'),
    ]
    passed = failed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-argv-storage-') as directory:
        work = Path(directory)
        for name, source, arguments, expected_code, expected_output in cases:
            path = work/'case.b'; path.write_text(source+'\n')
            try:
                result = subprocess.run([str(root/'tools/run-apout.sh'), '--timeout', '5', str(path), *arguments], cwd=work, capture_output=True, timeout=30)
                ok = result.returncode == expected_code and result.stdout == expected_output
                detail = repr((result.returncode, result.stdout, result.stderr[-1500:]))
            except (OSError, subprocess.TimeoutExpired) as error:
                ok, detail = False, str(error)
            print(f'{"PASS" if ok else "FAIL"}: argv-storage/{name}')
            if not ok: print(detail)
            passed += ok; failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
