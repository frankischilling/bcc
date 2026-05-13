#!/usr/bin/env python3
"""v1_smoke.py PROG.b

Boot UNIX V1 in simh, login as root, compile PROG.b with `b`, run ./a.out,
and print captured stdout. PROG.b must already exist in unix-v1/fs/root and
have been baked into rk0.dsk (run tools/install_v1.sh + tools/rebuild_v1.sh
first if you changed sources).

Default PROG is hi.b. Exit status is 0 if compile + run reached HALT (the
current B runtime's exit path) without timing out.
"""

import os
import re
import socket
import sys
import time

import pexpect

HERE = os.path.dirname(os.path.abspath(__file__))
V1 = os.path.normpath(os.path.join(HERE, "..", "..", "unix-v1"))
PDP11 = os.path.join(V1, "tools", "pdp11")
PORT = 5555

PROG = sys.argv[1] if len(sys.argv) > 1 else "hi.b"


def strip_iac(buf: bytes) -> bytes:
    out = bytearray()
    i = 0
    while i < len(buf):
        b = buf[i]
        if b == 0xFF and i + 2 < len(buf):
            i += 3
            continue
        out.append(b)
        i += 1
    return bytes(out)


def recv_until(sock: socket.socket, pat: bytes, timeout: float) -> bytes:
    rx = re.compile(pat)
    buf = bytearray()
    deadline = time.time() + timeout
    sock.settimeout(1.0)
    while time.time() < deadline:
        try:
            chunk = sock.recv(4096)
        except socket.timeout:
            continue
        if not chunk:
            raise RuntimeError(f"socket EOF waiting for {pat!r}; got {bytes(buf)!r}")
        buf.extend(strip_iac(chunk))
        if rx.search(buf):
            return bytes(buf)
    raise TimeoutError(f"timeout waiting for {pat!r}; got {bytes(buf)!r}")


def drain(sock: socket.socket, idle: float = 0.5) -> bytes:
    """Read until no data for `idle` seconds."""
    buf = bytearray()
    sock.settimeout(idle)
    while True:
        try:
            chunk = sock.recv(4096)
        except socket.timeout:
            return bytes(buf)
        if not chunk:
            return bytes(buf)
        buf.extend(strip_iac(chunk))


def run_until_done(sock: socket.socket, simh: pexpect.spawn, timeout: float) -> bytes:
    """Collect DCI output until the program halts or returns to the shell."""
    buf = bytearray()
    deadline = time.time() + timeout
    sock.setblocking(False)

    while time.time() < deadline:
        try:
            chunk = sock.recv(4096)
        except BlockingIOError:
            chunk = b""
        except socket.timeout:
            chunk = b""
        if chunk:
            buf.extend(strip_iac(chunk))
            if re.search(rb"# ", buf):
                return bytes(buf)

        try:
            idx = simh.expect([r"HALT instruction", pexpect.TIMEOUT, pexpect.EOF], timeout=0)
        except pexpect.ExceptionPexpect:
            idx = 1
        if idx == 0:
            try:
                buf.extend(drain(sock, idle=0.25))
            except OSError:
                pass
            return bytes(buf)
        if idx == 2:
            raise RuntimeError("simh exited while running ./a.out")

        time.sleep(0.05)

    raise TimeoutError(f"timeout waiting for ./a.out; got {bytes(buf)!r}")


def main() -> int:
    simh = pexpect.spawn(PDP11, ["simh.cfg"], cwd=V1, encoding="latin-1", timeout=30)
    try:
        simh.expect(r"Listening on port %d" % PORT)
    except pexpect.ExceptionPexpect:
        sys.stderr.write("simh failed to listen:\n" + simh.before + "\n")
        simh.terminate(force=True)
        return 2

    # simh listens but kernel still booting; connect with retry.
    sock = None
    for _ in range(20):
        try:
            sock = socket.create_connection(("127.0.0.1", PORT), timeout=5)
            break
        except OSError:
            time.sleep(0.25)
    if sock is None:
        sys.stderr.write("could not connect to simh dci\n")
        simh.terminate(force=True)
        return 2

    try:
        recv_until(sock, rb"login:", timeout=60)
        sock.sendall(b"root\n")
        recv_until(sock, rb"# ", timeout=30)

        sock.sendall(b"rm a.out\n")
        recv_until(sock, rb"# ", timeout=30)

        sock.sendall(f"b ./{PROG}\n".encode())
        compile_out = recv_until(sock, rb"# ", timeout=600)

        sock.sendall(b"ls a.out\n")
        ls_out = recv_until(sock, rb"# ", timeout=30)
        if not re.search(rb"(^|[\r\n])a\.out[\r\n]", ls_out):
            sys.stderr.write(compile_out.decode("latin-1", errors="replace"))
            sys.stderr.write(ls_out.decode("latin-1", errors="replace"))
            sys.stderr.write("compile did not create a.out\n")
            return 1

        sock.sendall(b"./a.out\n")
        out = run_until_done(sock, simh, timeout=60)
    finally:
        try:
            sock.close()
        except OSError:
            pass
        simh.sendcontrol("e")
        try:
            simh.expect(r"sim>", timeout=5)
        except pexpect.ExceptionPexpect:
            pass
        simh.sendline("quit")
        try:
            simh.expect(pexpect.EOF, timeout=10)
        except pexpect.ExceptionPexpect:
            simh.terminate(force=True)

    text = out.decode("latin-1", errors="replace")
    # Strip the echoed "./a.out" and a returned shell prompt if present.
    text = re.sub(r"^\.?/?a\.out\s*\r?\n", "", text)
    text = re.sub(r"\r?\n?#\s*$", "", text)
    sys.stdout.write(text)
    if not text.endswith("\n"):
        sys.stdout.write("\n")
    return 0


if __name__ == "__main__":
    sys.exit(main())
