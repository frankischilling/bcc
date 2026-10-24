#!/bin/sh
# build-apout-root.sh -- materialize a unified V1 root for apout cc.
#
# V1's fs is split into fs/root (/) and fs/usr (/usr).  apout's APOUT_ROOT
# points at a single dir.  This script builds build/aroot/ that merges
# fs/root + fs/usr + a copy of crt0.o (which V1 cc's ld needs).
#
# Make tracks the compiler, runtime, and filesystem inputs.

set -eu

HERE="$(cd "$(dirname "$0")/.." && pwd)"
V1="$(cd "$HERE/../unix-v1" && pwd)"
AROOT="$HERE/build/aroot"
STAMP="$HERE/build/.aroot.stamp"

mkdir -p "$HERE/build"

rm -rf "$AROOT"
mkdir -p "$AROOT"

# Isolate writable build files from the pinned restoration checkout.
cp -a "$V1/fs/root/." "$AROOT/"
# Replace empty /usr with merge of fs/usr
rm -rf "$AROOT/usr"
cp -a "$V1/fs/usr" "$AROOT/usr"
# Install crt0.o (kernel build artifact, needed for V1 ld)
cp "$HERE/build/crt0.o" "$AROOT/usr/lib/crt0.o"
# Stage the bcc runtime into /usr/lib so /bin/b can find them inside apout.
cp "$HERE/runtime/bmain.s" "$AROOT/usr/lib/bmain.s"
cp "$HERE/runtime/brt.s"   "$AROOT/usr/lib/brt.s"
# /tmp is required by V1 cc for ctm files, and /bin/b uses /tmp/b.ic and /tmp/b.s
mkdir -p "$AROOT/tmp"

touch "$STAMP"
echo "built apout root: $AROOT"
