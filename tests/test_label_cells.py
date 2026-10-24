#!/usr/bin/env python3
"""Check mutable, addressed, persistent function-local label cells."""
import argparse
from pathlib import Path
import subprocess
import resource
import tempfile

SOURCE = (Path(__file__).resolve().parents[1] / 'pdp-11/bcc-pdp/tests/run/t90_label_cells.b').read_text()
EXPECTED = b'OK\n'
CASES = {
    'mutable': (SOURCE, EXPECTED, False),
    'identity-and-cell': ((Path(__file__).resolve().parents[1] /
                          'pdp-11/bcc-pdp/tests/run/t110_label_identity.b').read_text(), b'OK\n', False),
    'function-identity': ('f(){return(done);done:return(1);}g(){return(done);done:return(2);}'
                          'main(){extrn f,g;return(f()==g() | f()!=f());}', b'', False),
    'word-identity': ('main(){goto done+0;done:return(0);}', b'', False),
    'numeric-target': ('main(){goto 1;done:return(0);}', b'', True),
    'foreign-target': ('f(){return(done);done:return(1);}'
                       'main(){extrn f;goto f();done:return(0);}', b'', True),
    'evaluated-once': ('main(){auto v 2,i;v[0]=done;v[1]=bad;i=0;goto v[i++];'
                       'done:return(i!=1);bad:return(2);}', b'', False),
}


def disable_core():
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    passed = failed = 0
    modes = [('host', False)] if args.bootstrap else [(mode, inline) for mode in ('host', '16', '32') for inline in (False, True)]
    with tempfile.TemporaryDirectory(prefix='bcc-label-cells-') as directory:
        root = Path(directory)
        for mode, inline in modes:
            command = [str(args.compiler.resolve()), '--strict', '--pedantic']
            if not args.bootstrap: command += [f'--word={mode}']
            if inline: command += ['--inline-runtime']
            for name, (text, output, reject) in CASES.items():
                source = root / 'case.b'
                source.write_text(text + '\n')
                build = subprocess.run([*command, str(source), '-o', str(root/'case')], capture_output=True, timeout=30)
                run = subprocess.run([str(root/'case')], input=b'A', capture_output=True, timeout=10,
                                     preexec_fn=disable_core) if build.returncode == 0 else build
                if reject:
                    ok = build.returncode == 0 and run.returncode != 0 and b'invalid label value' in run.stderr
                else:
                    ok = build.returncode == 0 and run.returncode == 0 and run.stdout == output
                print(f'{"PASS" if ok else "FAIL"}: label-cells/{mode}/{inline}/{name}')
                if not ok: print(run.returncode, repr(run.stdout), repr(run.stderr))
                passed += ok
                failed += not ok
            left = root / 'left.b'
            right = root / 'right.b'
            main_source = root / 'main.b'
            left.write_text('f(){return(done);done:return(1);}')
            right.write_text('g(){return(done);done:return(2);}')
            main_source.write_text('main(){extrn f,g;return(f()==g() | f()!=f());}')
            build = subprocess.run([*command, str(left), str(right), str(main_source), '-o', str(root/'case')],
                                   capture_output=True, timeout=30)
            run = subprocess.run([str(root/'case')], capture_output=True, timeout=10) if build.returncode == 0 else build
            ok = build.returncode == 0 and run.returncode == 0 and not run.stdout and not run.stderr
            print(f'{"PASS" if ok else "FAIL"}: label-cells/{mode}/{inline}/separate-files')
            if not ok: print(run.returncode, repr(run.stdout), repr(run.stderr))
            passed += ok
            failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
