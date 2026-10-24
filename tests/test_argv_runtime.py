#!/usr/bin/env python3
"""Check the B argv vector separately from compatibility argument helpers."""
import argparse
from pathlib import Path
import subprocess
import tempfile

CASES = {
    'empty': ['''main(){extrn argv,char; if(argv[0]!=3)return(1); return(char(argv[2],0)!=0 | char(argv(1),0)!=4 | char(argv[3],3)!=' ');}'''],
    'vector': ['''main(){extrn argv,char;
if(argv[0]!=3 | !argv[1])return(1);
if(char(argv[2],0)!='a' | char(argv[3],0)!='b')return(2);
return(char(argv[2],5)!=0 | char(argv(1),5)!=4); }'''],
    'parameters': ['''main(n,values){extrn char;
if(n!=3)return(1); return(char(values[1],0)!='a' | char(values[2],0)!='b');}'''],
    'mutable': ['''main(){auto old, v 1; extrn argv;
old=argv; v[0]=42; argv=v; if(argv[0]!=42)return(1);
*(&argv)=old; return(argv[0]!=3);}'''],
    'local-shadow': ['''main(){auto argv 1; argv[0]=37; return(argv[0]!=37);}'''],
    'global-shadow': ['''argv[1] 37; main(){extrn argv; return(argv[0]!=37);}'''],
    'function-shadow': ['''argv(){return(37);} main(){extrn argv; auto f; f=argv; return(argv()!=37 | f()!=37);}'''],
    'cross-file': ['''main(){extrn check; return(check());}''',
                   '''check(){extrn argv,argc,char; return(argv[0]!=3 | argc()!=3 | char(argv[2],0)!='a' | char(argv(2),0)!='b');}'''],
    'initializer': ['''ref argv; main(){extrn ref,argv; return(*ref!=argv | argv[0]!=3);}'''],
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    passed = failed = 0
    modes = [('host', False)] if args.bootstrap else [(mode, inline) for mode in ('host', '16') for inline in (False, True)]
    with tempfile.TemporaryDirectory(prefix='bcc-argv-') as directory:
        root = Path(directory)
        for mode, inline in modes:
            for name, sources in CASES.items():
                paths = []
                for index, text in enumerate(sources):
                    path = root/f'part{index}.b'; path.write_text(text+'\n'); paths.append(str(path))
                command = [str(args.compiler.resolve()), '--strict', '--pedantic']
                if not args.bootstrap: command += [f'--word={mode}']
                if inline: command += ['--inline-runtime']
                build = subprocess.run([*command, *paths, '-o', str(root/'case')], capture_output=True, timeout=30)
                arguments = ['', 'two words'] if name == 'empty' else ['alpha', 'beta']
                run = subprocess.run([str(root/'case'), *arguments], capture_output=True, timeout=10) if build.returncode == 0 else build
                ok = run.returncode == 0 and run.stdout == b''
                print(f'{"PASS" if ok else "FAIL"}: argv/{mode}/{"inline" if inline else "shared"}/{name}', flush=True)
                if not ok: print(run.returncode, repr(run.stdout), run.stderr.decode(errors='replace')[-2000:])
                passed += ok
                failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
