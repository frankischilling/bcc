#!/bin/sh
# install_v1.sh -- deploy b00 + b01 + b1 + driver + runtime into the V1 fs.
#
# Builds compiler passes with V1 cc (via apout) if not already built, then drops:
#   build/b00                  -> fs/root/bin/b00
#   build/b01                  -> fs/root/bin/b01
#   build/b1                   -> fs/root/bin/b1
#   tools/b.sh                 -> fs/root/bin/b      (driver, +x)
#   runtime/bmain.s, brt.s     -> fs/root/usr/lib/
#   src/*.c                    -> fs/root/usr/src/bcc/  (for self-host)
#
# After this, run pdp-11/unix-v1/tools/rebuild_v1.sh to repack rk0/rf0,
# then `make run` in pdp-11/unix-v1 to boot simh.  Inside V1:
#   b prog.b
#   mv a.out prog

set -eu

HERE="$(cd "$(dirname "$0")/.." && pwd)"
V1="$(cd "$HERE/../unix-v1" && pwd)"

# Ensure binaries are built.
if [ ! -x "$HERE/build/b00" ] || [ ! -x "$HERE/build/b01" ] || [ ! -x "$HERE/build/b1" ]; then
	(cd "$HERE" && make)
fi

ROOT=$V1/fs/root
USR=$V1/fs/usr

# Drop stale single-binary deploy if present.
rm -f "$ROOT/bin/bcc" "$ROOT/bin/b.sh"

# Binaries live on the root partition (/bin -> rf0:bin).
install -m 755 "$HERE/build/b00" "$ROOT/bin/b00"
install -m 755 "$HERE/build/b01" "$ROOT/bin/b01"
install -m 755 "$HERE/build/b1" "$ROOT/bin/b1"
install -m 755 "$HERE/build/b"  "$ROOT/bin/b"

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
echo "  $ROOT/bin/{b00,b01,b1,b}"
echo "  $USR/lib/{bmain.s,brt.s}"
echo "  $USR/src/bcc/*.c"
echo "  $USR/src/bcc/examples/*.b"
echo
echo "Now run:"
echo "  $HERE/tools/rebuild_v1.sh     # repack rk0.dsk / rf0.dsk"
echo "  (cd $V1 && make run)         # boot simh"
