#!/usr/bin/env python3
"""Compare the B x86-64 encoder with an independent assembler and execute images."""
import argparse
import os
from pathlib import Path
import platform
import shutil
import shlex
import struct
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[1]
REGS = ['rax', 'rcx', 'rdx', 'rbx', 'rsp', 'rbp', 'rsi', 'rdi'] + [f'r{i}' for i in range(8, 16)]
BYTE = ['al', 'cl', 'dl', 'bl', 'spl', 'bpl', 'sil', 'dil'] + [f'r{i}b' for i in range(8, 16)]
OPS = ['add', 'or', 'and', 'sub', 'xor', 'cmp', 'test']
COND = ['o', 'no', 'b', 'ae', 'e', 'ne', 'be', 'a', 's', 'ns', 'p', 'np', 'l', 'ge', 'le', 'g']
OFFSETS = [-2147483648, -129, -1, 0, 127, 128, 2147483647]
COUNTS = [0, 1, 2, 63, 64, 255]
DRIVER = '''
offs[] -2147483648,-129,-1,0,127,128,2147483647;
counts[] 0,1,2,63,64,255;
main(){
 extrn offs,counts;auto d,s,k,i;
 xstart(1);d=0;
 while(d<16){s=0;while(s<16){
  xmov(d,s);k=0;while(k<7){xbin(k,d,s);k++;}
  xmul(d,s);xmovzx(d,s);i=0;
  while(i<7){xload(d,s,offs[i]);xstore(s,offs[i],d);xlea(d,s,offs[i]);
   xloadb(d,s,offs[i]);xstoreb(s,offs[i],d);i++;}
  s++;}
  xmovim(d,0);xmovim(d,-1);xmovim(d,9223372036854775807);
  xmovim(d,-9223372036854775807-1);
  k=0;while(k<3){xunary(k,d);xshiftc(k,d);i=0;
   while(i<6){xshift(k,d,counts[i]);i++;}k++;}
  xstack(0,d);xstack(1,d);xjump(0,d);xjump(1,d);
  k=0;while(k<16){xset(k,d);k++;}d++;}
 i=0;while(i<7){xrel(0,offs[i]);xrel(1,offs[i]);k=0;
  while(k<16){xjcc(k,offs[i]);k++;}i++;}
 xcqo();xret();xsys();xfinish();return(0);
}
'''


def assembly():
    lines = ['.text']
    for d, dst in enumerate(REGS):
        for s, src in enumerate(REGS):
            lines.append(f'{{store}} movq %{src}, %{dst}')
            lines += [f'{op}q %{src}, %{dst}' for op in OPS]
            lines += [f'imulq %{src}, %{dst}', f'movzbq %{BYTE[s]}, %{dst}']
            for off in OFFSETS:
                address = f'{off}(%{src})'
                lines += [f'{{disp32}} movq {address}, %{dst}',
                          f'{{disp32}} movq %{dst}, {address}',
                          f'{{disp32}} leaq {address}, %{dst}',
                          f'{{disp32}} movzbq {address}, %{dst}',
                          f'{{disp32}} movb %{BYTE[d]}, {address}']
        lines += [f'movabsq ${value}, %{dst}' for value in (0, -1, 2**63-1, -2**63)]
        for unary, shift in zip(('not', 'neg', 'idiv'), ('shl', 'shr', 'sar')):
            lines += [f'{unary}q %{dst}', f'{shift}q %cl, %{dst}']
            lines += [f'{shift}q ${count}, %{dst}' for count in COUNTS]
        lines += [f'pushq %{dst}', f'popq %{dst}', f'call *%{dst}', f'jmp *%{dst}']
        lines += [f'set{condition} %{BYTE[d]}' for condition in COND]
    for off in OFFSETS:
        lines += [f'call .+({off})+5', f'{{disp32}} jmp .+({off})+5']
        lines += [f'{{disp32}} j{condition} .+({off})+6' for condition in COND]
    lines += ['cqo', 'ret', 'syscall']
    return '\n'.join(lines) + '\n', len(lines) - 1


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=PROJECT / 'bcc')
    parser.add_argument('--bootstrap', action='store_true')
    parser.add_argument('--close-faults', action='store_true')
    args = parser.parse_args()
    for tool in ('as', 'objcopy'):
        if shutil.which(tool) is None:
            parser.error(f'{tool} is needed only for the independent test oracle')
    passed = skipped = 0
    library = (ROOT / 'x64.b').read_text()
    with tempfile.TemporaryDirectory(prefix='bcc-x64-encode-') as directory:
        work = Path(directory)
        compiler = [str(args.compiler.resolve()), '--strict', '--pedantic']
        if not args.bootstrap:
            compiler.append('--word=host')
        env = dict(os.environ, PATH=str(work / 'no-external-tools'))

        def build(body, name):
            source = work / (name + '.b')
            source.write_text(library + '\n' + body)
            binary = work / name
            subprocess.run([*compiler, str(source), '-o', str(binary)], check=True, timeout=180)
            return binary

        generator = build(DRIVER, 'encoder')
        result = subprocess.run([str(generator)], capture_output=True, env=env, timeout=60)
        assert (result.returncode, result.stderr) == (0, b''), result
        text, count = assembly()
        (work / 'reference.s').write_text(text)
        subprocess.run(['as', '--64', str(work / 'reference.s'), '-o', str(work / 'reference.o')], check=True)
        subprocess.run(['objcopy', '-O', 'binary', '-j', '.text', str(work / 'reference.o'), str(work / 'reference.bin')], check=True)
        expected = (work / 'reference.bin').read_bytes()
        if result.stdout != expected:
            first = next((i for i, (a, b) in enumerate(zip(result.stdout, expected)) if a != b), min(len(result.stdout), len(expected)))
            raise AssertionError((first, len(result.stdout), len(expected), result.stdout[first:first+16].hex(), expected[first:first+16].hex()))
        passed += count
        print(f'PASS: {count} instruction encodings, {len(expected)} exact bytes', flush=True)
        bad = ['xmovim(-1,0)', 'xmovim(16,0)', 'xmov(0,16)',
               'xload(16,0,0)', 'xload(0,16,0)', 'xload(0,0,2147483648)',
               'xstore(0,-2147483647-2,0)', 'xlea(0,0,2147483648)',
               'xloadb(0,16,0)', 'xstoreb(0,0,16)', 'xbin(-1,0,0)',
               'xbin(7,0,0)', 'xmul(0,16)', 'xunary(3,0)',
               'xshift(3,0,0)', 'xshift(0,0,-1)', 'xshift(0,0,256)',
               'xshiftc(-1,0)', 'xstack(2,0)', 'xjump(2,0)',
               'xrel(2,0)', 'xrel(0,2147483648)', 'xjcc(16,0)',
               'xjcc(0,-2147483647-2)', 'xset(-1,0)', 'xset(0,16)',
               'xmovzx(0,16)', 'xstart(-1)', 'xstart(4294967297)']
        cases = ''.join(f'case {i}:{{{call};goto done;}}\n' for i, call in enumerate(bad))
        badmain = ('main(){extrn argv,char;auto n,i,c;n=0;i=0;'
                   'while((c=char(argv[2],i++))!=0)n=n*10+c-48;'
                   'xstart(1);switch n {\n' + cases + '}done:xfinish();return(0);}')
        reject = build(badmain, 'reject')
        for i, call in enumerate(bad):
            run = subprocess.run([str(reject), str(i)], capture_output=True, env=env, timeout=10)
            assert run.returncode and not run.stdout and run.stderr.endswith(b'\n'), call
            passed += 1
        if Path('/dev/full').exists():
            with open('/dev/full', 'wb') as full:
                run = subprocess.run([str(generator)], stdout=full, stderr=subprocess.PIPE, env=env, timeout=10)
            assert run.returncode and run.stderr.endswith(b'\n')
            passed += 1
        counter = build('main(){auto i;xstart(1);if(xtell()!=0)xfail();'
                        'i=0;while(i<200){xmovim(0,0);i++;}'
                        'if(xtell()!=2000)xfail();xfinish();return(0);}', 'counter')
        run = subprocess.run([str(counter)], capture_output=True, env=env, timeout=10)
        assert (run.returncode, run.stderr) == (0, b'')
        assert run.stdout == (bytes.fromhex('48b8') + bytes(8)) * 200
        passed += 1
        if args.close_faults:
            shim = work / 'close-fault.so'
            subprocess.run([*shlex.split(os.environ.get('CC', 'cc')), '-shared', '-fPIC',
                            str(PROJECT / 'tests/fixtures/output_close_fault.c'), '-o', str(shim), '-ldl'],
                           check=True, timeout=60)
            with (work / 'failed-output').open('wb') as stream:
                run = subprocess.run([str(generator)], stdout=stream, stderr=subprocess.PIPE,
                                     env=dict(env, LD_PRELOAD=str(shim), BCC_FAIL_CLOSE=str(work / 'failed-output')),
                                     timeout=30)
            assert run.returncode and run.stderr.endswith(b'\n')
            passed += 1
        if not args.bootstrap:
            for word in ('16', '32'):
                binary = work / ('reject-word-' + word)
                subprocess.run([str(args.compiler.resolve()), '--strict', '--pedantic', '--word=' + word,
                                str(work / 'encoder.b'), '-o', str(binary)], check=True, timeout=180)
                run = subprocess.run([str(binary)], capture_output=True, env=env, timeout=10)
                assert run.returncode and not run.stdout
                passed += 1

        writer = work / 'elfimage'
        subprocess.run([*compiler, str(ROOT / 'elfimage.b'), '-o', str(writer)], check=True, timeout=180)
        fixtures = [
            ('exit', 'xmovim(0,60);xmovim(7,42);xsys();', b'', 0, 42, b''),
            ('add', 'xmovim(0,5);xmovim(3,7);xbin(0,0,3);xmov(7,0);xmovim(0,60);xsys();', b'', 0, 12, b''),
            ('division', 'xmovim(0,81);xmovim(3,-7);xcqo();xunary(2,3);xmov(7,0);xmovim(0,60);xsys();', b'', 0, 245, b''),
            ('memory', 'xmovim(12,4202496);xmovim(9,37);xstore(12,8,9);xload(7,12,8);xmovim(0,60);xsys();', b'12345678', 8, 37, b''),
            ('bytes', 'xmovim(12,4202496);xmovim(8,65);xstoreb(12,0,8);xloadb(7,12,0);xmovim(0,60);xsys();', b'Z', 0, 65, b''),
            ('branch', 'xmovim(7,0);xmovim(0,7);xmovim(1,7);xbin(5,0,1);xjcc(4,10);xmovim(7,1);xmovim(0,60);xsys();', b'', 0, 0, b''),
            ('setcc', 'xmovim(7,0);xmovim(0,7);xmovim(1,8);xbin(5,0,1);xset(2,7);xmovzx(7,7);xmovim(0,60);xsys();', b'', 0, 1, b''),
            ('stack', 'xmovim(12,43);xstack(0,12);xmovim(12,0);xstack(1,7);xmovim(0,60);xsys();', b'', 0, 43, b''),
            ('call', 'xrel(0,12);xmovim(0,60);xsys();xmovim(7,37);xret();', b'', 0, 37, b''),
            ('indirect', 'xmovim(0,4198424);xjump(0,0);xmovim(0,60);xsys();xmovim(7,45);xret();', b'', 0, 45, b''),
            ('shift-cl', 'xmovim(0,1);xmovim(1,3);xshiftc(0,0);xmov(7,0);xmovim(0,60);xsys();', b'', 0, 8, b''),
            ('shift-sar', 'xmovim(0,-16);xshift(2,0,2);xmov(7,0);xmovim(0,60);xsys();', b'', 0, 252, b''),
            ('write', 'xmovim(0,1);xmovim(7,1);xmovim(6,4202496);xmovim(2,3);xsys();xmovim(0,60);xmovim(7,0);xsys();', b'Hi\n', 0, 0, b'Hi\n')]
        for name, calls, data, bss, status, output in fixtures:
            emitter = build('main(){xstart(1);' + calls + 'xfinish();return(0);}', 'emit-' + name)
            raw = subprocess.run([str(emitter)], capture_output=True, env=env, timeout=10)
            assert (raw.returncode, raw.stderr) == (0, b''), name
            (work / 'code').write_bytes(raw.stdout)
            (work / 'data').write_bytes(data)
            packaged = subprocess.run([str(writer), str(work / 'code'), str(work / 'data'), str(bss), '0'],
                                     capture_output=True, env=env, timeout=10)
            assert (packaged.returncode, packaged.stderr) == (0, b''), name
            from test_elfimage import oracle
            assert packaged.stdout == oracle(raw.stdout, data, bss, 0), name
            passed += 1
            if platform.system() == 'Linux' and platform.machine() in ('x86_64', 'AMD64'):
                executable = work / 'program'
                executable.write_bytes(packaged.stdout)
                executable.chmod(0o700)
                run = subprocess.run([str(executable)], capture_output=True, env=env, timeout=10)
                assert (run.returncode, run.stdout, run.stderr) == (status, output, b''), (name, run)
                passed += 1
            else:
                skipped += 1
        print('PASS: invalid operands, output failures and B-built executable fixtures', flush=True)

    print(f'Results: {passed} passed, 0 failed, {skipped} skipped')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
