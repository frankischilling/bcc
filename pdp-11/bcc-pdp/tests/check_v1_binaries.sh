#!/bin/sh
# Verify built V1 compiler binaries fit in 16 KB user space.
#
# Checks:
#   - magic == 0407
#   - text+data     <= 16384
#   - text+data+bss <= 16384

set -eu
cd "$(dirname "$0")/.."
HERE=$(pwd)
. "$HERE/tools/native-lock.sh"

make >/dev/null

python3 - <<'PY'
import pathlib
import struct
import sys

LIMIT = 16384
fail = 0
for name in ("b00", "b01", "b1", "b"):
    path = pathlib.Path("build") / name
    if not path.is_file() or path.stat().st_size < 16:
        print(f"FAIL {path}: missing or truncated binary")
        fail = 1
        continue
    magic, text, data, bss = struct.unpack("<4H", path.read_bytes()[:8])
    td = text + data
    tdb = td + bss
    msg = (
        f"{path}: magic={magic:04o} text={text} data={data} "
        f"bss={bss} t+d={td} t+d+b={tdb}"
    )
    bad = []
    if magic != 0o407:
        bad.append("magic!=0407")
    if td > LIMIT:
        bad.append("t+d>16K")
    if tdb > LIMIT:
        bad.append("t+d+b>16K")
    if bad:
        print(f"FAIL {msg}  [{','.join(bad)}]")
        fail = 1
    else:
        print(f"PASS {msg}")

sys.exit(fail)
PY
