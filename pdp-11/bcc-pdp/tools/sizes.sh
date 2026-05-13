#!/bin/sh
# sizes.sh -- decode a.out (0407) headers and report text/data/bss/totals.
# Usage: tools/sizes.sh build/b00 build/b01 build/b1 build/b
set -eu

python3 - "$@" <<'PY'
import pathlib
import struct
import sys

LIMIT = 16384
hdr = "{:<24}  text={:>5}  data={:>5}  bss={:>5}  t+d={:>5}  t+d+b={:>5}  {}"
print(hdr.format("binary", "", "", "", "", "", "status"))
fail = 0
for p in sys.argv[1:]:
    path = pathlib.Path(p)
    data = path.read_bytes()
    magic, text, data_, bss = struct.unpack("<4H", data[:8])
    td = text + data_
    tdb = td + bss
    flags = []
    if magic != 0o407:
        flags.append("magic!=0407")
    if td > LIMIT:
        flags.append("t+d>16K")
    if tdb > LIMIT:
        flags.append("t+d+b>16K")
    status = ",".join(flags) if flags else "OK"
    if flags:
        fail = 1
    print(hdr.format(str(path), text, data_, bss, td, tdb, status))
sys.exit(fail)
PY
