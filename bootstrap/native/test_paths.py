#!/usr/bin/env python3
"""Exercise B-native pathname adapters without a host toolchain at runtime."""
import argparse
import os
from pathlib import Path
import subprocess
import tempfile

CASES = [
    ('chdir', 'main(){extrn chdir,open,read,close;auto f,b 1;if(chdir("child"))return(1);f=open("inside",0);if(f<0)return(2);if(read(f,b,1)!=1)return(3);close(f);return((b[0]&255)==65?0:4);}', True),
    ('chdir-nul', 'main(){extrn chdir;return(chdir("child*0ignored"));}', True),
    ('chdir-preserves', 'main(){extrn chdir;auto s,before;s="child";before=s[0];if(chdir(s))return(1);return(s[0]==before?0:2);}', True),
    ('chdir-failure', 'main(){extrn chdir;return(chdir("absent")<0 & chdir("")<0 & chdir("original")<0?0:1);}', True),
    ('chdir-null', 'main(){extrn chdir;return(chdir(0)==-1?0:1);}', True),
    ('link', 'main(){extrn link;return(link("original","linked"));}', True),
    ('link-nul', 'main(){extrn link;return(link("original*0tail","linked*0tail"));}', True),
    ('link-preserves', 'main(){extrn link;auto a,b,x,y;a="original";b="linked";x=a[0];y=b[0];if(link(a,b))return(1);return(a[0]==x & b[0]==y?0:2);}', True),
    ('link-existing', 'main(){extrn link;return(link("original","existing")<0?0:1);}', True),
    ('link-failure', 'main(){extrn link;return(link("absent","linked")<0 & link("original","absent/linked")<0?0:1);}', True),
    ('link-null', 'main(){extrn link;return(link(0,"linked")==-1 & link("original",0)==-1?0:1);}', True),
    ('private-packing', 'char(s,i){return(4);}lchar(s,i,c){return(0);}main(){extrn chdir,link;if(link("original","linked"))return(1);return(chdir("child"));}', True),
    ('saved-chdir', 'other(s){return(42);}main(){extrn chdir,other;auto old;old=chdir;chdir=other;return(old("child")==0 & chdir(0)==42?0:1);}', True),
    ('saved-link', 'other(a,b){return(42);}main(){extrn link,other;auto old;old=link;link=other;return(old("original","linked")==0 & link(0,0)==42?0:1);}', True),
    ('source-definitions', 'chdir(p){return(41);}link(a,b){return(42);}getuid(){return(43);}main(){return(chdir(0)==41 & link(0,0)==42 & getuid()==43?0:1);}', True),
    ('byte-path', 'main(){extrn link,lchar;auto s 1;s[0]=0;lchar(s,0,255);lchar(s,1,4);return(link(s,"linked"));}', True),
    ('missing-arguments', 'main(){extrn chdir,link;return(chdir()==-1 & link()==-1 & link("original")==-1?0:1);}', False),
    ('path-limit', '__sys(n,a,b,c,d,e,f){return(0);}main(){extrn chdir,link,lchar;auto s 513,i;i=0;while(i<4096)lchar(s,i++,65);lchar(s,4096,4);if(chdir(s)!=-1 | link(s,"x")!=-1 | link("x",s)!=-1)return(1);lchar(s,4095,4);return(chdir(s)==0 & link(s,s)==0?0:2);}', False),
]
LINKED = {'link', 'link-nul', 'link-preserves', 'private-packing', 'saved-link', 'byte-path'}


def cases():
    return CASES + [('saved-identity', 'other(){return(42);}main(){extrn getuid,other;auto old;old=getuid;getuid=other;return(old()==' + str(os.getuid()) + ' & getuid()==42?0:1);}', True), ('identity', 'main(){extrn getuid;return(getuid()==' + str(os.getuid()) + '?0:1);}', True)]


def prepare(work):
    work.mkdir(parents=True, exist_ok=True)
    (work / 'child').mkdir()
    (work / 'child/inside').write_bytes(b'A')
    (work / 'original').write_bytes(b'original bytes')
    (work / 'existing').write_bytes(b'keep these bytes')
    os.link(work / 'original', work / os.fsdecode(b'\xff'))


def check_run(program, work, name, env):
    result = subprocess.run([str(program)], cwd=work, env=env, capture_output=True, timeout=10)
    assert (result.returncode, result.stdout, result.stderr) == (0, b'', b''), (name, result)
    assert (work / 'original').read_bytes() == b'original bytes'
    assert (work / 'existing').read_bytes() == b'keep these bytes'
    if name in LINKED:
        assert (work / 'linked').stat().st_ino == (work / 'original').stat().st_ino
    else:
        assert not (work / 'linked').exists(), name



def exec_replacement(build, work, env):
    work = Path(work)
    work.mkdir(parents=True)
    sources = {
        'helper': 'main(){extrn argv,char;if(argv[0]!=2)return(1);'
                  'return(char(argv[2],0)==65 & char(argv[2],1)==0?37:2);}',
        'caller': 'char(s,i){return(4);}lchar(s,i,c){return(0);}'
                  'main(){extrn execv;auto a 2;a[0]="custom";a[1]="A";'
                  'execv("./helper",a,2);return(99);}',
    }
    for name, source in sources.items():
        path = work / (name + '.b')
        path.write_text(source)
        build(path.resolve(), (work / name).resolve())
    result = subprocess.run([str((work / 'caller').resolve())], cwd=work,
                            env=env, capture_output=True, timeout=10)
    assert (result.returncode, result.stdout, result.stderr) == (37, b'', b''), result

def reference_checks(command, work):
    count = 0
    for name, source, compare in cases():
        if not compare:
            continue
        case = Path(work) / name
        prepare(case)
        path = case / 'input.b'
        path.write_text(source)
        program = case / 'program'
        result = subprocess.run([*command, str(path.resolve()), '-o', str(program.resolve())],
                                capture_output=True, timeout=60)
        assert result.returncode == 0, (name, result.stderr)
        check_run(program.resolve(), case, name, os.environ)
        count += 1
    def build(path, program):
        result = subprocess.run([*command, str(path), '-o', str(program)],
                                capture_output=True, timeout=60)
        assert result.returncode == 0, result.stderr
    exec_replacement(build, Path(work) / 'exec-packing', os.environ)
    print(f'{count + 1} pathname/identity reference checks passed', flush=True)


def run_checks(tools, work):
    tools = Path(tools).resolve()
    env = dict(os.environ, PATH='')
    for name, source, compare in cases():
        case = Path(work) / name
        prepare(case)
        path = case / 'input.b'
        path.write_text(source)
        program = case / 'program'
        result = subprocess.run([str(tools / 'driver'), str(path.resolve()), '-o', str(program.resolve())],
                                cwd=case, env=env, capture_output=True, timeout=60)
        assert (result.returncode, result.stdout, result.stderr) == (0, b'', b''), (name, result)
        check_run(program.resolve(), case, name, env)
    def build(path, program):
        result = subprocess.run([str(tools / 'driver'), str(path), '-o', str(program)],
                                env=env, capture_output=True, timeout=60)
        assert (result.returncode, result.stdout, result.stderr) == (0, b'', b''), result
    exec_replacement(build, Path(work) / 'exec-packing', env)
    print(f'{len(cases()) + 1} native pathname/identity checks passed', flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tools', type=Path, required=True)
    parser.add_argument('--reference', type=Path)
    args = parser.parse_args()
    with tempfile.TemporaryDirectory(prefix='bcc-native-paths-') as directory:
        work = Path(directory)
        if args.reference:
            reference_checks([str(args.reference.resolve()), '--strict', '--pedantic', '--word=host'], work / 'reference')
        run_checks(args.tools, work / 'native')


if __name__ == '__main__':
    main()
