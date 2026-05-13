#!/bin/sh
# Verify installed V1 compiler binaries fit in 16 KB user space.
#
# Checks:
#   - magic == 0407
#   - text+data     <= 16384
#   - text+data+bss <= 16384

set -eu
cd "$(dirname "$0")/.."

make >/dev/null
tools/install_v1.sh >/dev/null

python3 - <<'PY'
import pathlib
import struct
import sys

LIMIT = 16384
fail = 0
for name in ("b00", "b01", "b1", "b"):
    path = pathlib.Path("../unix-v1/fs/root/bin") / name
    if not path.exists():
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
