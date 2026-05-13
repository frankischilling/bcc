#!/usr/bin/env python3
"""Run V1 commands inside SIMH non-interactively.

Boots simh (from ../unix-v1/simh.cfg), connects to the DCI console on
TCP port 5555, logs in as root, runs each argv command (one per arg),
captures the output back to stdout, then shuts simh down cleanly.

    tools/simh_run.py "b /hi.b" "./a.out"

Each arg is one shell line typed at the V1 # prompt.  Output of all
commands is printed to host stdout.  Exit code is 0 on success.
"""

import os
import select
import socket
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
V1   = os.path.normpath(os.path.join(HERE, "../../unix-v1"))
PORT = 5555

# --- telnet IAC handling: strip command sequences from server stream
def strip_iac(buf):
    out = bytearray()
    i = 0
    while i < len(buf):
        b = buf[i]
        if b == 0xff and i + 1 < len(buf):
            cmd = buf[i+1]
            if cmd in (251, 252, 253, 254) and i + 2 < len(buf):  # WILL/WONT/DO/DONT
                i += 3
                continue
            if cmd == 0xff:
                out.append(0xff)
                i += 2
                continue
            i += 2
            continue
        out.append(b)
        i += 1
    return bytes(out)

def read_until(sock, pat, timeout=30):
    buf = b""
    deadline = time.time() + timeout
    while time.time() < deadline:
        sock.settimeout(max(0.1, deadline - time.time()))
        try:
            chunk = sock.recv(4096)
        except socket.timeout:
            continue
        if not chunk:
            break
        buf += chunk
        cleaned = strip_iac(buf)
        if pat in cleaned:
            return cleaned
    return strip_iac(buf)

def send_line(sock, s):
    sock.sendall(s.encode() + b"\r")

def main():
    cmds = sys.argv[1:]
    if not cmds:
        print("usage: simh_run.py CMD [CMD ...]", file=sys.stderr)
        return 1

    simh = subprocess.Popen(
        ["tools/pdp11", "simh.cfg"],
        cwd=V1,
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        bufsize=0,
    )

    # Wait for simh to be listening on the console port
    try:
        boot_log = b""
        while True:
            r, _, _ = select.select([simh.stdout], [], [], 30)
            if not r:
                print("simh: no output after 30s", file=sys.stderr)
                break
            line = simh.stdout.readline()
            if not line:
                break
            boot_log += line
            if b"Listening on port" in line:
                break
        # Give V1 a moment to finish booting (init, login prompt)
        time.sleep(2)

        sock = socket.create_connection(("localhost", PORT))

        # Read up to login prompt
        out = read_until(sock, b"login:", 30)
        sys.stdout.write(out.decode("latin-1"))
        sys.stdout.flush()

        send_line(sock, "root")
        out = read_until(sock, b"# ", 20)
        sys.stdout.write(out.decode("latin-1"))
        sys.stdout.flush()

        for cmd in cmds:
            send_line(sock, cmd)
            out = read_until(sock, b"# ", 60)
            sys.stdout.write(out.decode("latin-1"))
            sys.stdout.flush()

        sock.close()
    finally:
        # Halt the CPU (Ctrl-E is simh's default WRU) and quit
        try:
            simh.stdin.write(b"\x05")
            simh.stdin.flush()
            time.sleep(0.5)
            simh.stdin.write(b"quit\r\n")
            simh.stdin.flush()
        except (BrokenPipeError, OSError):
            pass
        try:
            simh.wait(timeout=5)
        except subprocess.TimeoutExpired:
            simh.kill()
            simh.wait()

    return 0

if __name__ == "__main__":
    sys.exit(main())
