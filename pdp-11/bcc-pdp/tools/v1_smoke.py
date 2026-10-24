#!/usr/bin/env python3
"""v1_smoke.py PROG.b

Boot UNIX V1 in simh, login as root, compile PROG.b with `b`, run ./a.out,
and print captured stdout. PROG.b must already exist in unix-v1/fs/root and
have been baked into rk0.dsk (run tools/install_v1.sh + tools/rebuild_v1.sh
first if you changed sources).

Default PROG is hi.b. A CPU halt is a failure, not successful completion.
Use --expected FILE to compare the console output (CRLF normalized to LF).
"""

import argparse
import os
from pathlib import Path
import tempfile
import re
import socket
import sys
import time

import pexpect
from v1_image import inspect

HERE = os.path.dirname(os.path.abspath(__file__))
V1 = os.path.normpath(os.path.join(HERE, "..", "..", "unix-v1"))
PDP11 = os.path.join(V1, "tools", "pdp11")
PORT = 5555
TRACE = False
SIMH = None
STOPPED = False

PROG = "hi.b"


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
        if SIMH is not None:
            state = SIMH.expect([r"Breakpoint", r"HALT instruction", pexpect.TIMEOUT, pexpect.EOF], timeout=0)
            if state in (0, 1):
                global STOPPED
                STOPPED = True
                raise RuntimeError("guest stopped before reaching its expected console prompt")
            if state == 3:
                raise RuntimeError("simulator exited before reaching its expected console prompt")
        try:
            chunk = sock.recv(4096)
        except socket.timeout:
            continue
        if not chunk:
            raise RuntimeError(f"socket EOF waiting for {pat!r}; got {bytes(buf)!r}")
        buf.extend(strip_iac(chunk))
        if TRACE:
            sys.stderr.write(strip_iac(chunk).decode("latin-1"))
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
    """Collect DCI output until the program returns to the shell."""
    global STOPPED
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
            idx = simh.expect([r"HALT instruction", r"Breakpoint", pexpect.TIMEOUT, pexpect.EOF], timeout=0)
        except pexpect.ExceptionPexpect:
            idx = 2
        if idx in (0, 1):
            STOPPED = True
            raise RuntimeError(f"CPU stopped instead of returning to the shell: {bytes(buf)!r}")
        if idx == 3:
            raise RuntimeError("simh exited while running ./a.out")

        time.sleep(0.05)

    raise TimeoutError(f"timeout waiting for ./a.out; got {bytes(buf)!r}")


def main() -> int:
    global PORT, PROG, TRACE, SIMH, STOPPED
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("program", nargs="?", default="hi.b")
    parser.add_argument("--expected", type=Path)
    parser.add_argument("--argument", action="append", default=[], help="simple argument passed to the guest program")
    parser.add_argument("--expect-compile-error", action="store_true")
    parser.add_argument("--trace-stages", action="store_true", help="run each compiler pass directly before checking the driver")
    parser.add_argument("--selfhost", action="store_true", help="rebuild and compare the four compiler binaries inside V1")
    args = parser.parse_args()
    if any(not re.fullmatch(r"[A-Za-z0-9_.-]+", value) for value in args.argument):
        parser.error("guest arguments must be simple shell words")
    run_command = "./a.out" + "".join(" " + value for value in args.argument)
    PROG = args.program
    TRACE = args.trace_stages
    if not re.fullmatch(r"[A-Za-z0-9_.-]+", PROG):
        parser.error("program must be a simple filename in the guest root")
    with socket.socket() as reservation:
        reservation.bind(("127.0.0.1", 0))
        PORT = reservation.getsockname()[1]
    inspect(Path(V1, "images/rf0.dsk").read_bytes())
    config = Path(V1, "simh.cfg").read_text()
    config = re.sub(r"(?m)^att dci .*", f"att dci 127.0.0.1:{PORT}", config)
    symbols = Path(V1, "build/usyms").read_text(errors="replace")
    panic = re.search(r"(?m)^([0-7]+)T panic", symbols)
    if panic:
        config = re.sub(r"(?m)^go ", f"break {panic[1]}\ngo ", config)
    with tempfile.NamedTemporaryFile(mode="w", suffix=".cfg") as script:
        script.write(config)
        script.flush()
        simh = pexpect.spawn(PDP11, [script.name], cwd=V1, encoding="latin-1", timeout=30)
        # SIMH reads the command file before it announces the listener.
        try:
            simh.expect(r"Listening on port [^\r\n]*" + str(PORT))
        except pexpect.ExceptionPexpect:
            sys.stderr.write("simh failed to listen:\n" + simh.before + "\n")
            simh.terminate(force=True)
            return 2
    SIMH = simh
    STOPPED = False
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

        if args.selfhost:
            def command(line, timeout=600):
                sock.sendall(line.encode() + b"\n")
                result = recv_until(sock, rb"# ", timeout=timeout).decode("latin-1").replace("\r\n", "\n")
                if result.startswith(line + "\n"):
                    result = result[len(line) + 1:]
                return re.sub(r"# $", "", result)

            command("chdir /usr/src/bcc")
            builds = {
                "b00": "b00drv.c bstmt.c bexpr.c blex.c bemit0.c butil.c",
                "b01": "b01drv.c blex1.c bsym.c butil.c",
                "b1": "b1drv.c bcg.c bcgnew.c blex1.c blit.c butil.c",
                "b": "bdrv.c bsel.c",
            }
            for name, sources in builds.items():
                destination = "/bin/b" if name == "b" else f"/usr/lib/bcc/{name}"
                command("rm a.out")
                output = command("cc " + sources)
                listing = command("ls a.out")
                if listing.strip() != "a.out":
                    raise RuntimeError(f"in-system {name} build produced no binary: {output!r} {listing!r}")
                comparison = command(f"cmp a.out {destination}")
                if comparison.strip():
                    raise RuntimeError(f"in-system {name} differs from the apout build: {comparison!r}")
                # /usr and /bin are on different filesystems in this image.
                copied = command(f"cp a.out {destination}")
                mode = command(f"chmod 36 {destination}")
                if copied.strip() or mode.strip():
                    raise RuntimeError(f"could not install rebuilt {name}: {copied!r} {mode!r}")
                sys.stderr.write(f"PASS: in-system {name} rebuild matches apout binary\n")
            command("rm /usr/tmp/l.s")
            command("/usr/lib/bcc/b00 -o /usr/tmp/l.r1 /usr/lib/libb.b")
            command("/usr/lib/bcc/b01 -i /usr/tmp/l.r1 -o /usr/tmp/l.r2")
            command("/usr/lib/bcc/b1 -l -i /usr/tmp/l.r2 -o /usr/tmp/l.s")
            comparison = command("cmp /usr/tmp/l.s /usr/lib/bcc/libb.ref")
            if comparison.strip():
                raise RuntimeError(f"in-system B library differs from the apout build: {comparison!r}")
            sys.stderr.write("PASS: in-system B library matches generated assembly\n")
            command("chdir /")

        sock.sendall(b"rm a.out\n")
        recv_until(sock, rb"# ", timeout=30)

        if args.trace_stages:
            for line in [f"/usr/lib/bcc/b00 -o /usr/tmp/b.r1 ./{PROG}",
                         "/usr/lib/bcc/b01 -i /usr/tmp/b.r1 -o /usr/tmp/b.r2",
                         "/usr/lib/bcc/b1 -i /usr/tmp/b.r2 -o /usr/tmp/b.s",
                         "ls /usr/tmp/b.s", "df"]:
                sys.stderr.write("Guest pass: " + line + "\n")
                sock.sendall(line.encode() + b"\n")
                response = recv_until(sock, rb"# ", timeout=90)
                sys.stderr.write(response.decode("latin-1"))

        sys.stderr.write(f"Guest: compiling {PROG}\n")
        verbose = "-v " if args.trace_stages else ""
        sock.sendall(f"b {verbose}./{PROG}\n".encode())
        compile_out = recv_until(sock, rb"# ", timeout=90 if args.trace_stages else 600)

        sock.sendall(b"ls a.out\n")
        ls_out = recv_until(sock, rb"# ", timeout=30)
        produced = bool(re.search(rb"(^|[\r\n])a\.out[\r\n]", ls_out))
        if args.expect_compile_error:
            diagnosed = b"b: pass failed" in compile_out or b"b: assembler failed" in compile_out
            if not produced and diagnosed:
                sys.stderr.write("PASS: guest driver rejected the failed compilation\n")
                return 0
            sys.stderr.write(compile_out.decode("latin-1"))
            sys.stderr.write("expected a diagnosed compiler failure without a.out\n")
            return 1
        if not produced:
            sys.stderr.write(compile_out.decode("latin-1", errors="replace"))
            sys.stderr.write(ls_out.decode("latin-1", errors="replace"))
            sys.stderr.write("compile did not create a.out\n")
            return 1

        sys.stderr.write("Guest: running a.out\n")
        sock.sendall((run_command + "\n").encode("ascii"))
        out = run_until_done(sock, simh, timeout=60)
    except Exception:
        if not STOPPED:
            simh.sendcontrol("e")
        try:
            simh.expect(r"sim>", timeout=5)
            STOPPED = True
            simh.sendline("examine pc,r0,r1,r2,r3,r4,r5,sp")
            simh.expect(r"sim>", timeout=5)
            sys.stderr.write(simh.before)
            simh.sendline("show cpu history=30")
            simh.expect(r"sim>", timeout=5)
            sys.stderr.write(simh.before)
        except pexpect.ExceptionPexpect:
            pass
        raise
    finally:
        try:
            sock.close()
        except OSError:
            pass
        if not STOPPED:
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
    text = re.sub(r"^\.?/?a\.out" + re.escape("".join(" " + value for value in args.argument)) + r"\s*\r?\n", "", text)
    text = re.sub(r"# $", "", text).replace("\r\n", "\n")
    sys.stdout.write(text)
    if args.expected is not None and text.encode("latin-1") != args.expected.read_bytes():
        sys.stderr.write(f"console output differs from {args.expected}: {text!r}\n")
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
