#!/usr/bin/env python3
"""Check B-driven native construction or a full B-source rebuild inside Unix V1."""
import argparse
import fcntl
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import time

ROOT = Path(__file__).resolve().parent
NATIVE = ROOT.parent
V1 = NATIVE.parent / 'unix-v1'
sys.path[:0] = [str(ROOT / 'tools'), str(NATIVE / 'tools')]
from build_toolchain import build, FILES
from seed_snapshot import copy_seed
from v1_files import FileSystem

SOURCE = "main(){extrn putchar;putchar('O');putchar('K');putchar('*n');return(0);}\n"
WRAPPER = '''
/* A success-only test entry prevents the shell's missing status from hiding failure. */
main(){
 extrn argv,lchar,write;auto v 8,opt 2;
 argv=v;v[0]=2;v[1]="driver";v[2]=opt;
 lchar(opt,0,'-');lchar(opt,1,'r');lchar(opt,2,0);
 if(drvmain())return(1);
 lchar(opt,1,'b');if(drvmain())return(1);
 v[0]=3;v[2]="input.b";v[3]="out";
 if(drvmain())return(1);
 write(1,"OK*n",3);return(0);
}
'''


# Compare on the target as well as from the extracted disk image. A stage line
# is printed only after every output for that stage matches its seed bytes.
REBUILD_HELPERS = r"""
invoke(mode,src,dst){
 extrn argv,lchar;auto v 8,opt 2;
 argv=v;v[1]="driver";
 if(mode){
  v[0]=2;v[2]=opt;lchar(opt,0,'-');lchar(opt,1,mode);lchar(opt,2,0);
  if(mode=='v'){v[0]=4;v[3]=src;v[4]=dst;}
 }else{v[0]=3;v[2]=src;v[3]=dst;}
 return(drvmain());
}
cmpfiles(left,right){
 extrn open,read,close,char;
 auto fa,fb,na,nb,i,x,y,ba 128,bb 128;
 fa=open(left,0);if(fa<0)return(1);
 fb=open(right,0);if(fb<0){close(fa);return(1);}
 loop:na=read(fa,ba,256);if(na<0)goto bad;
 nb=read(fb,bb,256);if(nb!=na)goto bad;
 if(!na){x=close(fa);y=close(fb);return(x<0|y<0);}
 i=0;while(i<na){x=char(ba,i);y=char(bb,i);if(x!=y)goto bad;i++;}
 goto loop;
 bad:close(fa);close(fb);return(1);
}
stage(s){extrn char,write;auto n,c;n=0;
 loop:c=char(s,n);if(!c|c==4)goto done;n++;goto loop;
 done:write(1,"BCC_STAGE ",10);write(1,s,n);write(1,"*n",1);
}
"""


def rebuild_case(seed, selected=None):
    """Select source rebuilds while always checking runtime prerequisites."""
    allowed = set(FILES) | {'driver', 'engine'}
    if selected is not None:
        if not selected or len(set(selected)) != len(selected) or not set(selected) <= allowed:
            raise ValueError('invalid or duplicate rebuild component')
    stages = ['templates', 'library']
    lines = ['main(){', "if(invoke('r',0,0))return(1);",
             'if(cmpfiles("bmain.s","rstart"))return(1);',
             'if(cmpfiles("brt.s","rprim"))return(1);', 'stage("templates");',
             "if(invoke('b',0,0))return(1);",
             'if(cmpfiles("libb.s","rlib"))return(1);', 'stage("library");']
    files = {alias: (seed / name).read_bytes() for alias, name in
             [('rstart', 'bmain.s'), ('rprim', 'brt.s'), ('rlib', 'libb.s')]}
    references = {name: (seed / name).read_bytes() for name in ('bmain.s', 'brt.s', 'libb.s')}
    components = [(name, source, name[:4] + '.new', image, "'v'")
                  for name, (image, source) in FILES.items()]
    components += [('driver', 'bdrv.b', 'drv.new', 'driver', '0'),
                   ('engine', 'vm.b', 'eng.new', 'engine', '0')]
    for name, source, output, reference, mode in components:
        if selected is not None and name not in selected:
            continue
        if output in references or output in files:
            raise ValueError('duplicate guest rebuild output: ' + output)
        files[source] = (seed / source).read_bytes()
        files[reference] = (seed / reference).read_bytes()
        files[output] = None
        references[output] = files[reference]
        lines += [f'if(invoke({mode},"{source}","{output}"))return(1);',
                  f'if(cmpfiles("{output}","{reference}"))return(1);', f'stage("{name}");']
        stages.append(name)
    lines += ['return(0);', '}']
    for name, data in files.items():
        if len(name.encode()) > 8 or (data is not None and len(data) > 65535):
            raise ValueError('file exceeds Unix-V1 name or size limit: ' + name)
    wrapper = REBUILD_HELPERS + '\n'.join(lines) + '\n'
    console = ''.join('BCC_STAGE ' + name + '\n' for name in stages).encode()
    return wrapper, console, files, references



def verify_outputs(fs, references):
    for name, data in references.items():
        if fs.read('tmp/' + name) != data:
            raise AssertionError('guest output differs: ' + name)


def verify_errors(driver, work):
    """Caller holds the native staging lock and owns the three scratch paths."""
    wrapper = 'main(){extrn close;close(2);return(drvmain());}\n'
    (work / 'errors.b').write_text(driver.replace('main(){', 'drvmain(){', 1) + wrapper)
    cases = [([], b'usage: driver [-v|-s|-l|-L] input output\n'),
             (['a' * 129, 'longout'], b'B build failed\n')]
    for arguments, expected in cases:
        (V1 / 'fs/usr/tmp/heap.vm').write_bytes(b'U' * 16384)
        (V1 / 'fs/usr/tmp/done').write_bytes(b'preserve')
        (V1 / 'fs/usr/tmp/longout').unlink(missing_ok=True)
        (work / 'errors.out').write_bytes(expected)
        subprocess.run(['bash', str(NATIVE / 'tools/v1-run.sh'), str(work / 'errors.b'),
                        '--workdir', '/usr/tmp', '--timings', '--run-timeout=60',
                        *['--argument=' + argument for argument in arguments]],
                       env=dict(os.environ, _BCC_NATIVE_LOCKED='1'), check=True, timeout=300)
        fs = FileSystem((V1 / 'images/rk0.dsk').read_bytes())
        if fs.read('tmp/heap.vm') != b'U' * 16384 or fs.read('tmp/done') != b'preserve':
            raise AssertionError('rejected command changed scratch files')
        _, entries = fs.inode(41)
        directories = [int.from_bytes(entries[i:i + 2], 'little')
                       for i in range(0, len(entries), 10)
                       if entries[i + 2:i + 10].split(b'\0', 1)[0] == b'tmp']
        if len(directories) != 1:
            raise AssertionError('invalid guest scratch directory')
        flags, entries = fs.inode(directories[0])
        if not flags & 0o40000:
            raise AssertionError('guest scratch path is not a directory')
        if any(int.from_bytes(entries[i:i + 2], 'little') and
               entries[i + 2:i + 10].split(b'\0', 1)[0] == b'longout'
               for i in range(0, len(entries), 10)):
            raise AssertionError('rejected command created an output')
        print('PASS: Unix-V1 driver diagnostic and scratch preservation/' +
              ('argument-limit' if arguments else 'usage'), flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--self-test', action='store_true',
                        help='rebuild all B toolchain sources inside the guest instead of the small program (many hours)')
    parser.add_argument('--run-timeout', type=int,
                        help='guest execution deadline in seconds (default: 3600, or 86400 with --self-test)')
    parser.add_argument('--component', action='append', choices=[*FILES, 'driver', 'engine'],
                        help='rebuild only this source component; repeat to select several (requires --self-test)')
    parser.add_argument('--seed', type=Path,
                        help='snapshot a manifest-checked existing seed instead of rebuilding it (requires --self-test)')
    args = parser.parse_args()
    if (args.component or args.seed) and not args.self_test:
        parser.error('--component and --seed require --self-test')
    if args.component and len(set(args.component)) != len(args.component):
        parser.error('duplicate --component')
    timeout = args.run_timeout if args.run_timeout is not None else (86400 if args.self_test else 3600)
    if timeout <= 0:
        parser.error('--run-timeout must be positive')
    with tempfile.TemporaryDirectory(prefix='bcc-B-toolchain-v1-') as directory:
        work = Path(directory)
        seed = work / 'seed'
        if args.seed:
            try:
                manifest = copy_seed(args.seed, seed)
            except (OSError, ValueError) as error:
                parser.error(str(error))
            print('Using seed revision: ' + str(manifest.get('revision', 'unrecorded')), flush=True)
        else:
            build(seed)
        driver = (seed / 'bdrv.b').read_text()
        if driver.count('main(){') != 1:
            raise AssertionError('unexpected driver entry definition')
        (work / 'runner.b').write_text(driver.replace('main(){', 'drvmain(){', 1) + WRAPPER)
        (work / 'runner.out').write_bytes(b'OK\n')
        (work / 'input.b').write_text(SOURCE)
        reference = work / 'reference'
        subprocess.run([sys.executable, str(NATIVE / 'tools/run_apout.py'), '--raw-v1',
                        '--emit-image', str(reference), str(work / 'input.b')], check=True, timeout=180)
        expected = reference.read_bytes()
        references = {name: (seed / name).read_bytes() for name in ('bmain.s', 'brt.s', 'libb.s')}
        files = {name: (seed / name).read_bytes() for name in
                 ('engine', 'front.vm', 'resolve', 'codegen', 'select', 'runtime', 'image', 'encoder', 'libb.b')}
        files['input.b'] = SOURCE.encode()
        files.update({name: None for name in ('bmain.s', 'brt.s', 'libb.s', 'heap.vm', 'raw.ic',
                                               'code.ic', 'prog.s', 'selrt.s', 'sellib.s', 'done', 'out', 'longout')})
        if args.self_test:
            wrapper, console, extra, references = rebuild_case(seed, args.component)
            (work / 'runner.b').write_text(driver.replace('main(){', 'drvmain(){', 1) + wrapper)
            (work / 'runner.out').write_bytes(console)
            files.update(extra)
        with (NATIVE / '.native-build.lock').open('a') as lock:
            fcntl.flock(lock, fcntl.LOCK_EX)
            (V1 / 'fs/usr/tmp').mkdir(parents=True, exist_ok=True)
            targets = {V1 / 'fs/usr/tmp' / name: data for name, data in files.items()}
            saved = {p: (p.read_bytes(), p.stat().st_mode & 0o777) if p.exists() else None for p in targets}
            try:
                for path, data in targets.items():
                    if data is None:
                        path.unlink(missing_ok=True)
                    else:
                        path.write_bytes(data)
                        path.chmod(0o755 if path.name in ('engine', 'driver') else 0o644)
                subprocess.run(['bash', str(NATIVE / 'tools/v1-run.sh'), str(work / 'runner.b'),
                                '--workdir', '/usr/tmp', '--timings', f'--run-timeout={timeout}',
                                *(['--report-stages'] if args.self_test else [])],
                               env=dict(os.environ, _BCC_NATIVE_LOCKED='1'), check=True, timeout=timeout + 300)
                fs = FileSystem((V1 / 'images/rk0.dsk').read_bytes())
                verify_outputs(fs, references)
                if args.self_test:
                    scope = 'selected B sources' if args.component else 'all B sources'
                    print(f'PASS: Unix-V1 {scope}, {len(references)} byte-exact outputs', flush=True)
                else:
                    actual = fs.read('tmp/out')
                    if actual != expected:
                        raise AssertionError('guest native executable differs')
                    (V1 / 'fs/usr/tmp/out').write_bytes(actual)
                    (V1 / 'fs/usr/tmp/out').chmod(0o755)
                    (work / 'execute.b').write_text('main(){extrn execl;execl("./out","out",0);return(1);}\n')
                    (work / 'execute.out').write_bytes(b'OK\n')
                    subprocess.run(['bash', str(NATIVE / 'tools/v1-run.sh'), str(work / 'execute.b'),
                                    '--workdir', '/usr/tmp', '--timings', '--run-timeout=60'],
                                   env=dict(os.environ, _BCC_NATIVE_LOCKED='1'), check=True, timeout=300)
                    print(f'PASS: Unix-V1 B driver, regenerated runtimes, {len(actual)} exact native bytes and execution', flush=True)
                verify_errors(driver, work)
            except BaseException as error:
                failure = NATIVE / 'build/toolchain-v1-failures' / str(time.time_ns())
                failure.mkdir(parents=True)
                (failure / 'failure.txt').write_text(str(error))
                for source in (work / 'runner.b', work / 'runner.out', seed / 'seed.json'):
                    if source.exists():
                        shutil.copy2(source, failure / source.name)
                for name in ('rk0.dsk', 'rf0.dsk'):
                    path = V1 / 'images' / name
                    if path.exists():
                        shutil.copy2(path, failure / name)
                raise
            finally:
                for path, previous in saved.items():
                    if previous is None:
                        path.unlink(missing_ok=True)
                    else:
                        path.write_bytes(previous[0])
                        path.chmod(previous[1])
    return 0


if __name__ == '__main__':
    main()
