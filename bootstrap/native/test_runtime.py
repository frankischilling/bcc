#!/usr/bin/env python3
"""Exercise the initial native Linux primitives without a linked C runtime."""
import argparse
import os
from pathlib import Path
import platform
import struct
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[1]
NATIVE = PROJECT/'pdp-11/bcc-pdp/bootstrap/src'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=PROJECT/'bcc')
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    command = [str(args.compiler.resolve()), '--strict', '--pedantic']
    if not args.bootstrap:command.append('--word=host')
    execute = platform.system() == 'Linux' and platform.machine().lower() in ('x86_64', 'amd64')
    passed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-runtime-') as directory:
        work = Path(directory)
        parts = [NATIVE/n for n in ('buffered_io.b','decimal16.b','diagnostics.b','ic.b')]
        parts += [ROOT/n for n in ('x64.b','labels.b','ops.b','scalar.b','memory.b','calls.b',
                                   'runtime/emit.b','runtime/path.b','fixtures/runtime/primitives.b')]
        (work/'emit.b').write_text('\n'.join(p.read_text() for p in parts))
        subprocess.run([*command,str(work/'emit.b'),'-o',str(work/'emit')],check=True,timeout=180)
        subprocess.run([*command,str(ROOT/'elfimage.b'),'-o',str(work/'image')],check=True,timeout=180)
        env = dict(os.environ, PATH='')

        def check(name, op, arguments, data=b'', expected=0, after=None, prefix=b'', stderr=b'', status=0, stdin=b'', fds=()):
            nonlocal passed
            build = subprocess.run([str(work/'emit'),str(op),str(len(arguments)),str(len(data)),*map(str,arguments)],
                                   cwd=work,env=env,capture_output=True,timeout=30)
            assert (build.returncode,build.stderr)==(0,b''),(name,build)
            (work/'code').write_bytes(build.stdout);(work/'data').write_bytes(data)
            image = subprocess.run([str(work/'image'),'code','data','0','0'],cwd=work,env=env,capture_output=True,timeout=30)
            assert (image.returncode,image.stderr)==(0,b''),(name,image)
            if execute:
                (work/'program').write_bytes(image.stdout);(work/'program').chmod(0o700)
                run = subprocess.run([str(work/'program')],cwd=work,env=env,input=stdin,capture_output=True,
                                     timeout=10,pass_fds=fds,umask=0o022)
                if expected is None:
                    want = prefix
                else:
                    assert run.returncode == status, (name, run)
                    assert len(run.stdout) >= len(prefix) + 8, (name, run)
                    assert run.stdout.startswith(prefix),(name,run)
                    result = struct.unpack('<q',run.stdout[len(prefix):len(prefix)+8])[0]
                    if callable(expected):assert expected(result),(name,result)
                    else:assert result==expected,(name,result,expected)
                    want = prefix+struct.pack('<q',result)+(data if after is None else after)
                assert (run.returncode,run.stdout,run.stderr)==(status,want,stderr),(name,run,want)
            passed += 1

        for index in (0,1,7,8,15):check('char-'+str(index),0,['p0',index],bytes(range(16)),index)
        for index,value in ((0,255),(7,256),(8,-257),(15,9223372036854775807)):
            data=bytes(range(16));after=bytearray(data);after[index]=value&255
            check('lchar-'+str(index),1,['p0',index,value],data,value,bytes(after))
        check('short-read',2,[0,'p0',8],b'abcdefgh',3,b'XYZdefgh',stdin=b'XYZ')
        check('offset-read',2,[0,'p8',3],b'abcdefghijklmnop',3,b'abcdefghXYZlmnop',stdin=b'XYZ')
        check('read-eof',2,[0,'p0',8],b'abcdefgh',0)
        check('char-extra',0,['p0',7,123],bytes(range(16)),7)
        check('char-negative-offset',0,['p8',-1],bytes(range(16)),7)
        check('read-negative-count',2,[0,'p0',-1],b'abcdefgh',-1)
        check('read-zero',2,[0,0,0],b'',0)
        check('read-failed',2,[-1,'p0',8],b'abcdefgh',-1)
        check('stdout-write',3,[1,'p0',6],b'hello\n',6,prefix=b'hello\n')
        check('stderr-write',3,[2,'p0',6],b'hello\n',6,stderr=b'hello\n')
        check('write-failed',3,[-1,'p0',6],b'hello\n',-1)
        check('write-negative-count',3,[1,'p0',-1],b'hello',-1)
        check('write-zero',3,[1,0,0],expected=0)
        check('close',4,[0],expected=0)
        check('close-failed',4,[-1],expected=-1)
        check('seek-failed',5,[-1,0,0],expected=-1)
        check('exit-empty',6,[],expected=None,status=0)
        check('exit-status',6,[42],expected=None,status=42)
        for op,count in enumerate((2,3,3,3,1,3,0,2,2,2,1)):
            if count:check('missing-'+str(op),op,[0]*(count-1),expected=None,status=77)
        for value in [*range(64),64,384,420,-1,4294967310,-9223372036854775808]:
            result = value&0xffffffff
            if 0 <= value <=63:
                result=sum(output for bit,output in ((32,2048),(16,73),(8,256),(4,128),(2,36),(1,18)) if value&bit)
            check('mode-'+str(value),11,[value],expected=result)
        if execute:
            (work/'file').write_bytes(b'hello')
            for mode in (0,1,2,-1):check('open-flags-'+str(mode),12,['p0',mode],b'file\4tail',int(mode!=0))
            check('open-nul',7,['p0',0],b'file\0tail',lambda n:n>=0)
            check('open-extra',7,['p0',0,99],b'file\4',lambda n:n>=0)
            check('open-empty',7,['p0',0],b'\4',-1)
            check('open-missing',7,['p0',0],b'missing\4',-1)
            check('open-null',7,[0,0],expected=-1)
            (work/'filex').write_bytes(b'hello')
            check('long-path',7,['p0',0],b'./'*2045+b'filex\4',lambda n:n>=0)
            check('overlong-path',7,['p0',0],b'./'*2045+b'filexx\4',-1)
            for mode,permissions in ((0o16,0o644),(0o14,0o600),(0o600,0o600)):
                path=work/'created';path.unlink(missing_ok=True)
                check('creat-'+str(mode),8,['p0',mode],b'created\4',lambda n:n>=0)
                assert path.stat().st_mode&0o777==permissions
            check('chmod',9,['p0',0o14],b'created\4',0)
            assert (work/'created').stat().st_mode&0o777==0o600
            check('unlink',10,['p0'],b'created\4',0)
            assert not (work/'created').exists()
            check('unlink-missing',10,['p0'],b'created\4',-1)
            descriptor=os.open(work/'file',os.O_RDONLY)
            try:
                check('seek-position',5,[descriptor,3,0],expected=0,fds=(descriptor,))
                assert os.lseek(descriptor,0,os.SEEK_CUR)==3
                check('seek-bad-origin',5,[descriptor,0,77],expected=-1,fds=(descriptor,))
                assert os.lseek(descriptor,0,os.SEEK_CUR)==3
                check('seek-negative',5,[descriptor,-1,0],expected=-1,fds=(descriptor,))
                assert os.lseek(descriptor,0,os.SEEK_CUR)==3
                check('seek-relative',5,[descriptor,-1,1],expected=0,fds=(descriptor,))
                assert os.lseek(descriptor,0,os.SEEK_CUR)==2
                check('seek-end',5,[descriptor,-1,2],expected=0,fds=(descriptor,))
                assert os.lseek(descriptor,0,os.SEEK_CUR)==4
                check('seek-wide',5,[descriptor,4294967296,0],expected=0,fds=(descriptor,))
                assert os.lseek(descriptor,0,os.SEEK_CUR)==4294967296
            finally:os.close(descriptor)
        for op in range(20,28):
            run=subprocess.run([str(work/'emit'),str(op),'0','0'],cwd=work,env=env,capture_output=True,timeout=30)
            assert run.returncode!=0 and run.stderr,(op,run)
            passed += 1
    print(f'{passed} native runtime checks passed')
    if not execute:print('SKIP: native execution requires Linux x86-64')


if __name__=='__main__':main()
