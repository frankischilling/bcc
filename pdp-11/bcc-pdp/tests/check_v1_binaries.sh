#!/bin/sh
# Verify native compiler images and their minimum stack reserves.
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

sys.path.insert(0, 'tools')
from compile_native import validate_image

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
    reserve = 512 if name == "b00" else 256
    bad = []
    try:
        validate_image(path.read_bytes(), reserve)
    except ValueError as error:
        bad.append(str(error))
    msg += f" reserve={reserve}"
    if bad:
        print(f"FAIL {msg}  [{','.join(bad)}]")
        fail = 1
    else:
        print(f"PASS {msg}")

sys.exit(fail)
PY
