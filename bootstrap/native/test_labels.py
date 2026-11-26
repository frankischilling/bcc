#!/usr/bin/env python3
"""Check two-pass B label resolution and execute B-built branch fixtures."""
import argparse
import os
from pathlib import Path
import platform
import struct
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[1]
HARNESS = r'''
mode 0;
emit(pass) {
    extrn mode;
    auto i,id;
    if(mode==0 | mode==28) {
        id=0;i=0;
        while(i<2) {
            xmark(id);xbranch(i,id+1);xret();xmark(id+1);xbranch(i,id);
            id=id+2;i++;
        }
        i=0;while(i<16) {
            xmark(id);xcond(i,id+1);xret();xmark(id+1);xcond(i,id);
            id=id+2;i++;
        }
        return;
    }
    if(mode==1) {xbranch(1,1);return;}
    if(mode==2) {xmark(0);xmark(0);return;}
    if(mode==3) {xmark(-1);return;}
    if(mode==4) {xmark(4096);return;}
    if(mode==5) {xbranch(0,-1);return;}
    if(mode==6) {xcond(0,4096);return;}
    if(mode==7) {xbranch(-1,0);return;}
    if(mode==8) {xbranch(2,0);return;}
    if(mode==9) {xcond(-1,0);return;}
    if(mode==10) {xcond(16,0);return;}
    if(mode==11) {if(pass==1) xmark(0);xret();return;}
    if(mode==12) {if(pass==2) xmark(1);xret();return;}
    if(mode==13) {
        if(pass==1) {xmark(0);xret();} else {xret();xmark(0);}
        return;
    }
    if(mode==14) {xmark(0);xret();if(pass==2) xret();return;}
    if(mode==23) {xmark(0);if(pass==2) xmark(0);xret();return;}
    if(mode==24) {xmark(0);if(pass==2) xbranch(1,1);xret();return;}
    if(mode==29) {
        i=0;while(i<4096) xmark(i++);
        i=0;while(i<4096) xbranch(1,i++);
        return;
    }
    if(mode==30) {
        xbranch(1,1);xmark(2);xmovim(0,42);xret();
        xmark(1);xbranch(0,2);xmov(7,0);xmovim(0,60);xsys();return;
    }
    if(mode==31) {
        xmovim(0,0);xmovim(1,5);xmovim(2,1);xmark(0);
        xbin(0,0,2);xbin(3,1,2);xcond(5,0);
        xmov(7,0);xmovim(0,60);xsys();return;
    }
    if(mode==32) {
        xbranch(1,4095);i=0;while(i<1024) {xret();i++;}
        xmark(4095);xmovim(7,23);xmovim(0,60);xsys();return;
    }
    xmark(0);xret();
}
once(output) {
    extrn mode,creat;
    auto fd;
    fd=creat("layout.bin",0600);xstart(fd);
    if(mode==15) xmark(0);
    if(mode==16) xlblbeg(2);
    if(mode==17) xlblbeg(0);
    if(mode==18) xlblbeg(3);
    if(mode==21) xlblend();
    if(mode==25) xret();
    xlblbeg(1);
    if(mode==19) xlblbeg(1);
    if(mode==20) xlblbeg(2);
    emit(1);xlblend();
    if(mode==22) xlblend();
    xfinish();xstart(output);
    if(mode==26) xlblbeg(1);
    xlblbeg(2);emit(2);xlblend();
    if(mode==27) {xfinish();xstart(creat("third.bin",0600));xlblbeg(2);}
    xfinish();
}
main() {
    extrn argv,char,mode,creat;
    auto s,c,i;
    s=argv[2];i=0;
    while((c=char(s,i++))>='0' & c<='9') mode=mode*10+c-'0';
    if(mode==28) once(creat("previous.bin",0600));
    once(1);return(0);
}
'''


def expected():
    output = bytearray()
    for kind in (0, 1):
        output += bytes([232 + kind]) + struct.pack('<i', 1) + b'\xc3'
        output += bytes([232 + kind]) + struct.pack('<i', -11)
    for condition in range(16):
        output += bytes([15, 128 + condition]) + struct.pack('<i', 1) + b'\xc3'
        output += bytes([15, 128 + condition]) + struct.pack('<i', -13)
    return bytes(output)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=PROJECT / 'bcc')
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    compiler = [str(args.compiler.resolve()), '--strict', '--pedantic']
    if not args.bootstrap:
        compiler.append('--word=host')
    passed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-x64-labels-') as directory:
        work = Path(directory)
        env = dict(os.environ, PATH=str(work / 'no-external-tools'))
        source = work / 'labels.b'
        source.write_text((ROOT / 'x64.b').read_text() + (ROOT / 'labels.b').read_text() + HARNESS)
        emitter = work / 'emitter'
        subprocess.run([*compiler, str(source), '-o', str(emitter)], check=True, timeout=180)
        for mode in range(33):
            result = subprocess.run([str(emitter), str(mode)], cwd=work, env=env,
                                    capture_output=True, timeout=30)
            if 1 <= mode <= 27:
                assert result.returncode != 0 and b'x64' in result.stderr, (mode, result)
            else:
                assert (result.returncode, result.stderr) == (0, b''), (mode, result)
                if mode in (0, 28):
                    assert result.stdout == expected(), (mode, result.stdout)
                    if mode == 28:
                        assert (work / 'previous.bin').read_bytes() == expected()
                elif mode == 29:
                    reference = b''.join(b'\xe9' + struct.pack('<i', -5 * (i + 1)) for i in range(4096))
                    assert result.stdout == reference, 'label capacity'
                else:
                    (work / f'code-{mode}').write_bytes(result.stdout)
            passed += 1
        if platform.system() == 'Linux' and platform.machine().lower() in ('x86_64', 'amd64'):
            writer = work / 'elfimage'
            subprocess.run([*compiler, str(ROOT / 'elfimage.b'), '-o', str(writer)], check=True, timeout=180)
            (work / 'data').write_bytes(b'')
            for mode, status in ((30, 42), (31, 5), (32, 23)):
                result = subprocess.run([str(writer), f'code-{mode}', 'data', '0', '0'],
                                        cwd=work, env=env, capture_output=True, timeout=30)
                assert (result.returncode, result.stderr) == (0, b''), result
                binary = work / 'image'
                binary.write_bytes(result.stdout)
                binary.chmod(0o700)
                result = subprocess.run([str(binary)], capture_output=True, timeout=5)
                assert (result.returncode, result.stdout, result.stderr) == (status, b'', b''), (mode, result)
                passed += 1
        else:
            print('SKIP: executable checks require Linux x86-64', flush=True)
    print(f'{passed} label-resolution checks passed', flush=True)


if __name__ == '__main__':
    main()
