#!/usr/bin/env python3
"""Check B external cells, contiguous initializers, and cross-file addresses."""
import argparse
from pathlib import Path
import subprocess
import tempfile

CASES = {
    'literal-storage': ['text(){return("same");} other(){return("same");} main(){auto p;extrn text,other,char,lchar;p=text();lchar(p,0,122);return(char(text(),0)!=122 | char(other(),0)!=115);}'],
    'mixed-string-cells': ['mixed 11,"ab*0c",22,"",33; main(){auto p; extrn mixed,char,lchar; p= &mixed; if(p[0]!=11 | p[2]!=22 | p[4]!=33)return(1); if(char(p[1],2)!=0 | char(p[1],3)!=\'c\' | char(p[1],4)!=004 | char(p[3],0)!=004)return(2); lchar(p[1],0,\'z\');return(char(p[1],0)!=\'z\');}'],
    'interleaved-string-definitions': ['before(){return("before");} values[4] "one","two"; after(){return("after");} main(){extrn values,before,after,char; return(char(values[0],0)!=\'o\' | char(values[1],0)!=\'t\' | values[2]!=0 | values[3]!=0 | char(before(),0)!=\'b\' | char(after(),0)!=\'a\');}'],
    'compat-long-name': ['long_name 37; main(){extrn long_name;return(long_name!=37);}'],
    'keyword-data': ['int 11;', 'b_int 22;', 'main(){extrn int,b_int;return(int!=11 | b_int!=22);}'],
    'keyword-functions': ['int(n){return(n+1);}', 'b_int(n){return(n+2);}', 'main(){extrn int,b_int;return(int(1)!=2 | b_int(1)!=3);}'],
    'contiguous': ['data 11,22,33; main(){auto p; extrn data; p= &data; return(data!=11 | p[1]!=22 | p[2]!=33);}'],
    'mutation': ['data 11,22,33; main(){auto p; extrn data; p= &data; p[0]=99; p[1]=77; return(data!=99 | p[1]!=77);}'],
    'zero': ['data; main(){extrn data; return(data!=0);}'],
    'string-cell': ['pair "abc",37; main(){auto p; extrn pair,char,lchar; p= &pair; if(p[1]!=37 | char(pair,1)!=\'b\')return(1); lchar(pair,1,\'z\'); return(char(pair,1)!=\'z\');}'],
    'addresses': ['data 11,22,33; refs[2] data,data; main(){auto p; extrn refs,data; p=refs[0]; return(p!= &data | p[2]!=33 | refs[1]!=p);}'],
    'cross-file': ['data 11,22,33; fetch(){extrn data; return(data);}', 'main(){auto p; extrn data,fetch; p= &data; if(p[2]!=33)return(1); data=99; return(fetch()!=99);}'],
    'forward-address': ['ref base; fetch(){extrn ref; return(ref);}', 'base 11,22,33;', 'main(){auto p; extrn fetch,base; p=fetch(); return(p!= &base | p[1]!=22 | p[2]!=33);}'],
    'cycle': ['left right;', 'right left;', 'main(){extrn left,right; return(*left!= &left | *right!= &right);}'],
    'shadow': ['data 11,22; fetch(data){return(data);} main(){auto data; data=7; return(fetch(data)!=7);}'],
    'function-cell': ['fp; next(n){return(n+1);} main(){extrn fp,next; fp=next; return(fp(41)!=42);}'],
    'foreign-function-value': ['next(n){return(n+1);}', 'main(){auto f; extrn next; f=next; return(f(41)!=42);}'],
    'host-macro': ['main(){extrn EOF; return(EOF!=-1);}'],
    'unbraced-function': ['choose(n) if(n)return(7); else return(9); main(){extrn choose; return(choose(1)!=7 | choose(0)!=9);}'],
    'labeled-function': ['choose() done:return(37); main(){extrn choose; return(choose()!=37);}'],
}
CASES['long-string'] = ['data "' + 'x'*255 + '"; main(){extrn data,char;return(char(data,254)!=120 | char(data,255)!=004);}']
CASES['many-string-cells'] = ['refs[128] ' + ','.join('""' for _ in range(128)) + '; main(){auto i;extrn refs,char,lchar;i=0;while(i<128){if(char(refs[i],0)!=004)return(1);i++;}lchar(refs[0],0,120);return(char(refs[127],0)!=004);}']
CASES['reverse-address'] = list(reversed(CASES['forward-address']))
HOST_COMPAT_CASES = {
    'runtime-initializer': ['saved = argv[0]; main(){extrn saved,argc;return(saved!=argc());}'],
    'cross-file-runtime-initializer': ['saved = argc();', 'main(){extrn saved,argc;return(saved!=argc());}'],
    'initialize-once': ['data 11; main(){extrn data;data=37;__b_init();return(data!=37);}'],
}
REJECTS = {
    'negative-extent': (['data[-1]; main(){return(0);}'], 'negative'),
    'dynamic-extent': (['size 3; data[size]; main(){return(0);}'], 'constant'),
    'duplicate-variable': (['data 1;', 'data 2; main(){return(0);}'], 'duplicate'),
    'duplicate-function': (['f(){return(1);}', 'f(){return(2);} main(){return(0);}'], 'duplicate'),
    'conflicting-definition': (['data 1;', 'data(){return(2);} main(){return(0);}'], 'conflicting'),
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    passed = failed = 0
    modes = [('host', False)] if args.bootstrap else [(mode, inline) for mode in ('host', '16') for inline in (False, True)]
    with tempfile.TemporaryDirectory(prefix='bcc-globals-') as directory:
        root = Path(directory)
        for mode, inline in modes:
            entries = [(name, sources, None) for name, sources in CASES.items()]
            if not args.bootstrap:
                entries += [(name, sources, None) for name, sources in HOST_COMPAT_CASES.items()]
            entries += [(name, sources, diagnostic) for name, (sources, diagnostic) in REJECTS.items()]
            for name, sources, diagnostic in entries:
                paths = []
                for index, text in enumerate(sources):
                    path = root/f'part{index}.b'; path.write_text(text+'\n'); paths.append(str(path))
                command = [str(args.compiler.resolve())]
                if name != 'compat-long-name': command += ['--strict', '--pedantic']
                if not args.bootstrap: command += [f'--word={mode}']
                if inline: command += ['--inline-runtime']
                build = subprocess.run([*command, *paths, '-o', str(root/'case')], capture_output=True, timeout=30)
                if diagnostic:
                    run = build
                    ok = run.returncode > 0 and diagnostic.encode() in run.stdout + run.stderr
                else:
                    run = subprocess.run([str(root/'case')], capture_output=True, timeout=10) if build.returncode == 0 else build
                    ok = run.returncode == 0 and run.stdout == b''
                print(f'{"PASS" if ok else "FAIL"}: globals/{mode}/{"inline" if inline else "shared"}/{name}', flush=True)
                if not ok: print(run.returncode, repr(run.stdout), run.stderr.decode(errors='replace')[-2500:])
                passed += ok
                failed += not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
