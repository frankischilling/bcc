#!/usr/bin/env python3
"""Check B source features through the seed encoder and both VM builds."""
import os
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
NATIVE = ROOT.parent
sys.path.insert(0, str(ROOT / 'tools'))
from build_vm import build, resolver_image
from encode_vm import encode

CASES = [
    ('arithmetic', 'main(){return((3+5)*(9-2));}', 56, b'', []),
    ('recursive', 'sum(n){if(n) return(n+sum(n-1));return(0);}main(){return(sum(10));}', 55, b'', []),
    ('vector', 'main(){auto v 3;v[0]=7;v[1]=9;return(v[0]+v[1]);}', 16, b'', []),
    ('global-vector', 'v[3] 7,9;main(){extrn v;return(v[0]+v[1]+v[2]);}', 16, b'', []),
    ('global-pointer', 'x 12;p x;main(){extrn p;return(*p);}', 12, b'', []),
    ('global-string', 's "AB";main(){extrn s,char;return(char(s,1));}', 66, b'', []),
    ('literal-copy', 'main(){extrn char,lchar;auto p;p="AB";lchar(p,1,67);return(char(p,1));}', 67, b'', []),
    ('loop', 'main(){auto i,n;i=0;n=0;while(i<5){n=+i;i++;}return(n);}', 10, b'', []),
    ('comparison', 'main(){return((1<2)+(2>=2)+(3==3)+(4!=4));}', 3, b'', []),
    ('switch', 'main(){auto x;x=2;switch x {case 1:return(7);case 2:return(9);}return(3);}', 9, b'', []),
    ('computed-goto', 'main(){auto p;p=done;goto p;return(1);done:return(7);}', 7, b'', []),
    ('function-cell', 'f(){return(7);}g(){return(9);}main(){extrn f,g;f=g;return(f());}', 9, b'', []),
    ('putchar', 'main(){extrn putchar;putchar(65);return(0);}', 0, b'A', []),
    ('argc', 'main(n,v){return(n);}', 2, b'', ['alpha']),
    ('argv', 'main(n,v){extrn char;return(char(v[1],0));}', 97, b'', ['alpha']),
    ('counted-argv', 'main(){extrn argv,char;return(char(argv[2],0));}', 97, b'', ['alpha']),
    ('ternary-true', 'main(){auto x;x=0;return(1 ? ++x : 100);}', 1, b'', []),
    ('ternary-false', 'main(){auto x;x=0;return(0 ? 100 : ++x);}', 1, b'', []),
    ('ternary-nested', 'main(){return(0 ? 1 : 1 ? 7 : 9);}', 7, b'', []),
    ('ternary-side-effect', 'main(){auto x,y;x=0;y=1 ? 7 : ++x;return(x+y);}', 7, b'', []),
]

for number in (103, 104, 105, 106, 109):
    fixture = next((NATIVE / 'tests/run').glob(f't{number}_*.b'))
    CASES.append((fixture.stem, fixture.read_text(), 0, fixture.with_suffix('.out').read_bytes(), []))

RECORDS = []
for is_and, left, expected in ((0, 7, 7), (0, 0, 9), (1, 0, 0), (1, 7, 9)):
    records = f'pr main 0 30000\nn {left}\nao {is_and} 1\nn 9\naoe 1\nrt\nep 0\n'
    RECORDS.append((f'record/short-circuit/{is_and}/{left}', records, expected, b'', []))


def main():
    failed = passed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-vm-encoder-') as directory:
        work = Path(directory)
        resolver_image(work)  # Snapshot the seed tools in the same isolated root.
        build(work / 'native')
        build(work / 'host', host=NATIVE.parents[1] / 'bcc')
        env = dict(os.environ, APOUT_ROOT=str(work), APOUT_UNIX_VERSION='V2')
        for name, source, status, output, args in CASES + RECORDS:
            if name.startswith('record/'):
                (work / 'code.ic').write_text(source)
            else:
                (work / 'input.b').write_text(source + '\n')
                for binary, flags in [('b00', ['-o', 'raw.ic', 'input.b']),
                                      ('b01', ['-i', 'raw.ic', '-o', 'code.ic'])]:
                    subprocess.run([str(work / 'apout'), str(work / binary), *flags], cwd=work,
                                   env=env, check=True, timeout=30)
            image, _, _ = encode((work / 'code.ic').read_text())
            (work / 'code.vm').write_bytes(image)
            for model, command in [('native', [str(work / 'apout'), str(work / 'native')]),
                                   ('host16', [str(work / 'host')])]:
                (work / 'heap.vm').write_bytes(bytes(16384))
                result = subprocess.run([*command, 'code.vm', *args], cwd=work, env=env,
                                        capture_output=True, timeout=120)
                ok = (result.returncode, result.stdout, result.stderr) == (status, output, b'')
                print(f'{"PASS" if ok else "FAIL"}: VM-encoder/{model}/{name}', flush=True)
                if not ok:
                    print(result.returncode, repr(result.stdout), repr(result.stderr), flush=True)
                passed += ok
                failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
