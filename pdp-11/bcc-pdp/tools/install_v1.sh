#!/bin/sh
# install_v1.sh -- deploy b00 + b01 + b1 + driver + runtime into the V1 fs.
#
# Install the small driver on root and the passes/runtime/sources on /usr.
# The root disk must leave space for the kernel's fixed swap slots.

set -eu

HERE="$(cd "$(dirname "$0")/.." && pwd)"
V1="$(cd "$HERE/../unix-v1" && pwd)"
. "$HERE/tools/native-lock.sh"

# Rebuild changed sources and reject unsafe images before staging anything.
(cd "$HERE" && make)
PYTHONPATH="$HERE/tools" python3 - "$HERE/build" <<'PY_CHECK'
from pathlib import Path
import sys
from compile_native import validate_image
for name in ('b00', 'b01', 'b1', 'b'):
    validate_image((Path(sys.argv[1])/name).read_bytes(), 512 if name == 'b00' else 256)
PY_CHECK

ROOT=$V1/fs/root
USR=$V1/fs/usr

# Drop stale single-binary deploy if present.
rm -f "$ROOT/bin/bcc" "$ROOT/bin/b.sh"

# Keep the small driver on root; compiler passes belong on the larger /usr disk.
mkdir -p "$USR/lib/bcc" "$USR/tmp"
for name in b00 b01 b1; do
    install -m 755 "$HERE/build/$name" "$USR/lib/bcc/$name"
    rm -f "$ROOT/bin/$name"
done
install -m 755 "$HERE/build/b" "$ROOT/bin/b"
install -m 644 "$HERE/build/libb.raw.s" "$USR/lib/bcc/libb.ref"

# Runtime + self-host sources live on /usr (rk0:lib + rk0:src/bcc).
mkdir -p "$USR/lib"
install -m 644 "$HERE/runtime/bmain.s" "$USR/lib/bmain.s"
install -m 644 "$HERE/runtime/brt.s"   "$USR/lib/brt.s"
install -m 644 "$HERE/runtime/libb.b"  "$USR/lib/libb.b"
[ -f "$HERE/runtime/libb.s" ] && install -m 644 "$HERE/runtime/libb.s" "$USR/lib/libb.s" || true

# Wipe old sources so renames (b0.c -> b00drv.c, btab.c split, etc.) don't
# leave stale copies that would foul a self-host `cc *.c`.
rm -rf "$USR/src/bcc" "$ROOT/usr/src/bcc"
mkdir -p "$USR/src/bcc"
for f in "$HERE/src"/*.c; do
	install -m 644 "$f" "$USR/src/bcc/$(basename "$f")"
done
mkdir -p "$USR/src/bcc/examples"
for f in "$HERE/examples"/*.b; do
	install -m 644 "$f" "$USR/src/bcc/examples/$(basename "$f")"
done

echo "installed:"
echo "  $ROOT/bin/b"
echo "  $USR/lib/bcc/{b00,b01,b1}"
echo "  $USR/lib/{bmain.s,brt.s}"
echo "  $USR/src/bcc/*.c"
echo "  $USR/src/bcc/examples/*.b"
echo
echo "Now run:"
echo "  $HERE/tools/rebuild_v1.sh     # repack rk0.dsk / rf0.dsk"
echo "  (cd $V1 && make run)         # boot simh"
