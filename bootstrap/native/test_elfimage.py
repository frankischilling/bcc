#!/usr/bin/env python3
"""Check B-written ELF packaging against independent headers and Linux execution."""
import argparse
import os
from pathlib import Path
import platform
import struct
import shlex
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT.parents[1]
BASE = 0x400000
LIMIT = 16 * 1024 * 1024


def oracle(code, data, bss, entry):
    offset = (4096 + len(code) + 4095) // 4096 * 4096
    ident = b'\x7fELF\x02\x01\x01' + bytes(9)
    header = struct.pack('<16sHHIQQQIHHHHHH', ident, 2, 62, 1, BASE + 4096 + entry,
                         64, 0, 0, 64, 56, 3, 0, 0, 0)
    headers = b''.join(struct.pack('<IIQQQQQQ', *row) for row in
                      [(1, 5, 0, BASE, 0, 4096 + len(code), 4096 + len(code), 4096),
                       (1, 6, offset, BASE + offset, 0, len(data), len(data) + bss, 4096),
                       (0x6474e551, 6, 0, 0, 0, 0, 0, 16)])
    return header + headers + bytes(4096 - len(header + headers)) + code + bytes(offset - 4096 - len(code)) + data


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, default=PROJECT / 'bcc')
    parser.add_argument('--bootstrap', action='store_true')
    parser.add_argument('--close-faults', action='store_true', help='inject delayed close failures on Linux')
    args = parser.parse_args()
    native = platform.system() == 'Linux' and platform.machine() in ('x86_64', 'AMD64')
    passed = skipped = 0
    with tempfile.TemporaryDirectory(prefix='bcc-elf-image-') as directory:
        work = Path(directory)
        close_library = work / 'close-fault.so'
        if args.close_faults:
            fixture = PROJECT / 'tests/fixtures/output_close_fault.c'
            subprocess.run([*shlex.split(os.environ.get('CC', 'cc')), '-shared', '-fPIC',
                            str(fixture), '-o', str(close_library), '-ldl'], check=True, timeout=60)
        for word in (('host',) if args.bootstrap else ('host', '32')):
            writer = work / ('writer-' + word)
            command = [str(args.compiler.resolve()), '--strict', '--pedantic']
            if not args.bootstrap:
                command.append('--word=' + word)
            subprocess.run([*command, str(ROOT / 'elfimage.b'), '-o', str(writer)], check=True, timeout=180)
            env = dict(os.environ, PATH=str(work / 'no-external-tools'))

            def package(code, data=b'', bss=0, entry=0):
                (work / 'code').write_bytes(code)
                (work / 'data').write_bytes(data)
                return subprocess.run([str(writer), 'code', 'data', str(bss), str(entry)],
                                      cwd=work, env=env, capture_output=True, timeout=30)

            exit42 = bytes.fromhex('b83c000000bf2a0000000f05')
            # These fixtures call Linux directly and have no runtime or interpreter.
            cases = [('exit', exit42, b'', 0, 0, 42, b''),
                     ('entry', bytes(17) + exit42, b'', 0, 17, 42, b''),
                     ('text-boundary', exit42 + bytes(4096 - len(exit42)), b'', 0, 0, 42, b''),
                     ('text-next-page', exit42 + bytes(4097 - len(exit42)), b'', 0, 0, 42, b''),
                     ('binary-data', exit42, bytes(range(256)) * 5, 4097, 0, 42, b'')]
            hello = b'B-built ELF\n'
            write_hello = (bytes.fromhex('b801000000bf01000000be') + struct.pack('<I', BASE + 8192) +
                           b'\xba' + struct.pack('<I', len(hello)) + bytes.fromhex('0f05b83c00000031ff0f05'))
            cases.append(('write-data', write_hello, hello, 0, 0, 0, hello))
            for name, value, store in [('zero-bss', 0, False), ('write-bss', 37, True)]:
                address = struct.pack('<I', BASE + 8192 + 1)
                code = (bytes.fromhex('c70425') + address + struct.pack('<I', value)) if store else b''
                code += bytes.fromhex('8b3c25') + address + bytes.fromhex('b83c0000000f05')
                cases.append((name, code, b'Z', 4096, 0, value, b''))
            for name, code, data, bss, entry, status, output in cases:
                result = package(code, data, bss, entry)
                assert (result.returncode, result.stderr) == (0, b''), (word, name, result.stderr)
                assert result.stdout == oracle(code, data, bss, entry), (word, name)
                passed += 1
                if native:
                    binary = work / 'program'
                    binary.write_bytes(result.stdout)
                    binary.chmod(0o700)
                    run = subprocess.run([str(binary)], capture_output=True, timeout=10, env=env)
                    assert (run.returncode, run.stdout, run.stderr) == (status, output, b''), (word, name, run)
                    passed += 1
                else:
                    skipped += 1
            for code, bss, entry in [(b'', '0', '0'), (exit42, '-1', '0'),
                                     (exit42, '', '0'), (exit42, '1x', '0'),
                                     (exit42, str(LIMIT + 1), '0'), (exit42, '0', '-1'),
                                     (exit42, '0', str(len(exit42))), (exit42, '0', '99999999999999999999')]:
                result = package(code, bss=bss, entry=entry)
                assert result.returncode and not result.stdout and result.stderr.endswith(b'\n')
                passed += 1
            (work / 'code').write_bytes(exit42)
            (work / 'data').write_bytes(b'')
            for code, data in [('missing', 'data'), ('code', 'missing'), ('.', 'data'), ('code', '.')]:
                result = subprocess.run([str(writer), code, data, '0', '0'], cwd=work,
                                        capture_output=True, env=env, timeout=30)
                assert result.returncode and not result.stdout
                passed += 1
            # Oversized inputs are rejected before an ELF header is written.
            with (work / 'large').open('wb') as stream:
                stream.truncate(LIMIT + 1)
            for code, data in [('large', 'data'), ('code', 'large')]:
                result = subprocess.run([str(writer), code, data, '0', '0'], cwd=work,
                                        capture_output=True, env=env, timeout=60)
                assert result.returncode and not result.stdout
                passed += 1
            if Path('/dev/full').exists():
                with open('/dev/full', 'wb') as full:
                    result = subprocess.run([str(writer), 'code', 'data', '0', '0'], cwd=work,
                                            stdout=full, stderr=subprocess.PIPE, env=env, timeout=30)
                assert result.returncode and result.stderr.endswith(b'\n')
                passed += 1
            result = subprocess.run([str(writer)], cwd=work, env=env, capture_output=True, timeout=30)
            assert result.returncode and not result.stdout
            assert result.stderr == b'usage: elfimage code data bss entry > output\n'
            passed += 1
            if args.close_faults:
                for name in ('code', 'data', 'output'):
                    failing = dict(env, LD_PRELOAD=str(close_library), BCC_FAIL_CLOSE=str(work / name))
                    with (work / 'output').open('wb') as output:
                        result = subprocess.run([str(writer), 'code', 'data', '0', '0'], cwd=work,
                                                stdout=output, stderr=subprocess.PIPE, env=failing, timeout=30)
                    assert result.returncode and result.stderr.endswith(b'\n'), (word, name)
                    passed += 1
            result = subprocess.run([str(writer), 'code', 'data', '0', '0'], cwd=work,
                                    capture_output=True, env=env, timeout=30,
                                    preexec_fn=lambda: os.closerange(0, 1))
            assert result.returncode == 0 and result.stdout == oracle(exit42, b'', 0, 0)
            assert not result.stderr
            passed += 1
            print(f'PASS: ELF writer/{word}/headers, loading, limits and I/O', flush=True)
        if not args.bootstrap:
            binary = work / 'writer-16'
            subprocess.run([str(args.compiler.resolve()), '--strict', '--pedantic', '--word=16',
                            str(ROOT / 'elfimage.b'), '-o', str(binary)], check=True, timeout=180)
            result = subprocess.run([str(binary), 'code', 'data', '0', '0'], cwd=work,
                                    capture_output=True, timeout=30)
            assert result.returncode and not result.stdout
            passed += 1
    print(f'Results: {passed} passed, 0 failed, {skipped} execution checks skipped')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
