#!/usr/bin/env python3
"""Execute native B-word operation fixtures built by the B encoding tools."""
import argparse
import itertools
import os
from pathlib import Path
import platform
import struct
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[1]
VALUES = [-(1 << 63), -(1 << 63) + 1, -123456789, -65, -64, -63, -1,
          0, 1, 2, 7, 63, 64, 65, 123456789, (1 << 63) - 1]
OPS = [43, 45, 42, 47, 37, 38, 124, 94, 60, 62, 100, 101, 102, 103, 104, 105]
HARNESS = r'''
op;left;right;unary;base;fail;bulk;
num(s) {
    extrn char;
    auto i,n,c,neg;
    i=0;n=0;neg=0;if(char(s,0)=='-') {neg=1;i++;}
    while((c=char(s,i++))>='0' & c<='9') n=n*10+c-'0';
    if(neg) return(-n);return(n);
}
keptreg(r) {return(r==3 | r==5 | r==6 | r==7 | r==9 | r==10 | r>=12);}
save() {
    auto r;
    r=0;while(r<16) {if(keptreg(r)) xmovim(r,123456789+r);r++;}
    xmov(11,4);
}
check(bad) {
    auto r;
    r=0;while(r<16) {
        if(keptreg(r)) {xmovim(2,123456789+r);xbin(5,r,2);xcond(5,bad);}
        r++;
    }
    xbin(5,4,11);xcond(5,bad);
}
report(status) {
    /* Write a status/result pair, then restore the case's stack pointer. */
    xstack(0,0);xmovim(0,status);xstack(0,0);
    xmov(6,4);xmovim(0,1);xmovim(7,1);xmovim(2,16);xsys();
    xmovim(2,16);xbin(0,4,2);
}
one(b,f,bad,done) {
    extrn op,left,right,unary;
    save();
    if(unary) {xmovim(0,left);xunop(op);}
    else {xmovim(1,left);xmovim(0,right);xbinary(op,b,f);}
    check(bad);report(0);xbranch(1,done);
    xmark(f);check(bad);xmovim(0,0);report(77);xbranch(1,done);
    xmark(bad);xmovim(0,60);xmovim(7,78);xsys();xmark(done);
}
emit() {
    extrn bulk,unary,vals,left,right,base,fail;
    auto i,j,index;
    if(bulk) {
        i=0;index=0;
        while(i<16) {
            j=0;
            while(j<16) {
                left=vals[i];right=vals[j];
                one(index*5,index*5+2,index*5+3,index*5+4);
                index++;j++;
                if(unary) j=16;
            }
            i++;
        }
    } else one(base,fail,3,4);
    xmovim(0,60);xmovim(7,0);xsys();
}
main() {
    extrn argv,vals,op,left,right,unary,base,fail,bulk,creat;
    op=num(argv[2]);left=vals[num(argv[3])];right=vals[num(argv[4])];
    unary=num(argv[5]);base=num(argv[6]);fail=num(argv[7]);bulk=num(argv[8]);
    xstart(creat("layout",0600));xlblbeg(1);emit();xlblend();xfinish();
    xstart(1);xlblbeg(2);emit();xlblend();xfinish();return(0);
}
'''


REFERENCE = r'''
calc(op,x,y) {
    if(op==43) return(x+y);if(op==45) return(x-y);
    if(op==42) return(x*y);
    if(op==47 | op==37) if(!y) return(0);
    if(op==47) return(x/y);if(op==37) return(x%y);
    if(op==38) return(x&y);if(op==124) return(x|y);
    if(op==94) return((x|y)&(-1-(x&y)));
    if(op==60) return(x<y);if(op==62) return(x>y);
    if(op==100) return(x==y);if(op==101) return(x!=y);
    if(op==102) return(x<=y);if(op==103) return(x>=y);
    if(op==104) return(x<<y);return(x>>y);
}
main() {
    extrn vals,ops,write;
    auto k,i,j,value;
    k=0;while(k<16) {
        i=0;while(i<16) {
            j=0;while(j<16) {
                value=calc(ops[k],vals[i],vals[j]);
                if(write(1,&value,8)!=8) return(1);j++;
            }
            i++;
        }
        k++;
    }
    k=0;while(k<3) {
        i=0;while(i<16) {
            if(k==0) value= -vals[i];
            else if(k==1) value= !vals[i];
            else value= -1-vals[i];
            if(write(1,&value,8)!=8) return(1);i++;
        }
        k++;
    }
    return(0);
}
'''


def expected(op, x, y, unary):
    if unary:
        return {45: -x, 33: int(x == 0), 126: ~x}[op]
    if op == 43:
        return x + y
    if op == 45:
        return x - y
    if op == 42:
        return x * y
    if op in (47, 37):
        quotient = abs(x) // abs(y)
        if (x < 0) != (y < 0):
            quotient = -quotient
        return quotient if op == 47 else x - quotient * y
    if op == 38:
        return x & y
    if op == 124:
        return x | y
    if op == 94:
        return x ^ y
    if op == 60:
        return int(x < y)
    if op == 62:
        return int(x > y)
    if op == 100:
        return int(x == y)
    if op == 101:
        return int(x != y)
    if op == 102:
        return int(x <= y)
    if op == 103:
        return int(x >= y)
    if y == 64:
        return 0
    y &= 63
    return x << y if op == 104 else (x & ((1 << 64) - 1)) >> y


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=PROJECT / 'bcc')
    parser.add_argument('--bootstrap', action='store_true')
    args = parser.parse_args()
    compiler = [str(args.compiler.resolve()), '--strict', '--pedantic']
    if not args.bootstrap:
        compiler.append('--word=host')
    execute = platform.system() == 'Linux' and platform.machine().lower() in ('x86_64', 'amd64')
    passed = 0
    with tempfile.TemporaryDirectory(prefix='bcc-native-ops-') as directory:
        work = Path(directory)
        env = dict(os.environ, PATH=str(work / 'no-external-tools'))
        library = ''.join((ROOT / name).read_text() for name in ('x64.b', 'labels.b', 'ops.b'))
        numbers = ','.join('(-9223372036854775807-1)' if x == -(1 << 63) else str(x) for x in VALUES)
        source = work / 'emitter.b'
        source.write_text(library + '\nvals[] ' + numbers + ';\n' + HARNESS)
        emitter = work / 'emitter'
        writer = work / 'writer'
        for source, binary in ((source, emitter), (ROOT / 'elfimage.b', writer)):
            subprocess.run([*compiler, str(source), '-o', str(binary)], check=True, timeout=180)
        (work / 'data').write_bytes(b'')
        # Check the oracle against ordinary B expressions, not the encoder.
        reference_source = work / 'reference.b'
        reference_source.write_text('vals[] ' + numbers + ';\nops[] ' +
                                    ','.join(map(str, OPS)) + ';\n' + REFERENCE)
        reference_binary = work / 'reference'
        subprocess.run([*compiler, str(reference_source), '-o', str(reference_binary)],
                       check=True, timeout=180)
        reference = subprocess.run([str(reference_binary)], capture_output=True, timeout=30)
        assert (reference.returncode, reference.stderr) == (0, b''), reference
        words = []
        for op in OPS:
            for x, y in itertools.product(VALUES, repeat=2):
                words.append(0 if op in (47, 37) and y == 0 else expected(op, x, y, False))
        for op in (45, 33, 126):
            words.extend(expected(op, x, 0, True) for x in VALUES)
        reference_bytes = b''.join((word & ((1 << 64) - 1)).to_bytes(8, sys.byteorder) for word in words)
        assert reference.stdout == reference_bytes, 'ordinary B reference differs from arithmetic oracle'
        passed += 1

        def generate(op, i, j, unary=0, base=0, fail=2, bulk=0):
            return subprocess.run([str(emitter), *map(str, (op, i, j, unary, base, fail, bulk))],
                                  cwd=work, env=env, capture_output=True, timeout=30)

        def check(op, pairs, unary=0, base=0, fail=2, bulk=0):
            nonlocal passed
            i, j = pairs[0]
            result = generate(op, i, j, unary, base, fail, bulk)
            assert (result.returncode, result.stderr) == (0, b''), (op, i, j, result)
            (work / 'code').write_bytes(result.stdout)
            image = subprocess.run([str(writer), 'code', 'data', '0', '0'], cwd=work,
                                   env=env, capture_output=True, timeout=30)
            assert (image.returncode, image.stderr) == (0, b''), image
            if execute:
                binary = work / 'program'
                binary.write_bytes(image.stdout)
                binary.chmod(0o700)
                result = subprocess.run([str(binary)], capture_output=True, timeout=5)
                assert result.returncode == 0 and not result.stderr, (op, unary, result)
                assert len(result.stdout) == len(pairs) * 16, (op, len(result.stdout), len(pairs))
                for index, (i, j) in enumerate(pairs):
                    x, y = VALUES[i], VALUES[j]
                    reference = ((77, 0) if not unary and op in (47, 37) and y == 0 else
                                 (0, expected(op, x, y, unary) & ((1 << 64) - 1)))
                    actual = struct.unpack_from('<QQ', result.stdout, index * 16)
                    assert actual == reference, (op, x, y, unary, actual, reference)
            passed += len(pairs)

        # Batch one operator per image instead of starting thousands of
        # instrumented emitters and ELF writers. Every operand pair still runs.
        pairs = list(itertools.product(range(len(VALUES)), repeat=2))
        for op in OPS:
            check(op, pairs, bulk=1)
            print(f'PASS: binary operation {op}', flush=True)
        for op in (45, 33, 126):
            check(op, [(i, 0) for i in range(len(VALUES))], unary=1, bulk=1)
        for op in (47, 37, 104, 105):
            check(op, [(0, 6)], base=4094, fail=4093)
        invalid = [(999, 0, 0, 0, 0, 2), (0, 0, 0, 1, 0, 2)]
        invalid += [(op, 0, 0, 0, base, 2) for op in (47, 37, 104, 105) for base in (-1, 4095)]
        invalid += [(op, 0, 0, 0, 0, fail) for op in (47, 37) for fail in (-1, 4096, 0, 1)]
        for arguments in invalid:
            result = generate(*arguments)
            assert result.returncode != 0 and b'x64:' in result.stderr, (arguments, result)
            passed += 1
    if not execute:
        print('SKIP: native execution requires Linux x86-64; only construction/rejection checked', flush=True)
    print(f'{passed} native-operation checks passed', flush=True)


if __name__ == '__main__':
    main()
