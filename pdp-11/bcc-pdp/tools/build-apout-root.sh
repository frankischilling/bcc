#!/bin/sh
# build-apout-root.sh -- materialize a unified V1 root for apout cc.
#
# V1's fs is split into fs/root (/) and fs/usr (/usr).  apout's APOUT_ROOT
# points at a single dir.  This script builds build/aroot/ that merges
# fs/root + fs/usr + a copy of crt0.o (which V1 cc's ld needs).
#
# Idempotent: only rebuilds if any input is newer than the output stamp.

set -eu

HERE="$(cd "$(dirname "$0")/.." && pwd)"
V1="$(cd "$HERE/../unix-v1" && pwd)"
AROOT="$HERE/build/aroot"
STAMP="$HERE/build/.aroot.stamp"

mkdir -p "$HERE/build"

NEWER=0
for src in "$V1/fs/root" "$V1/fs/usr" "$V1/build/usr/lib/crt0.o"; do
	if [ ! -e "$STAMP" ] || [ "$src" -nt "$STAMP" ]; then
		NEWER=1
	fi
done

if [ "$NEWER" = "0" ] && [ -d "$AROOT" ]; then
	exit 0
fi

rm -rf "$AROOT"
mkdir -p "$AROOT"

# Symlink-copy fs/root structure (cp -as)
cp -as "$V1/fs/root/." "$AROOT/"
# Replace empty /usr with merge of fs/usr
rm -rf "$AROOT/usr"
cp -as "$V1/fs/usr" "$AROOT/usr"
# Install crt0.o (kernel build artifact, needed for V1 ld)
cp "$V1/build/usr/lib/crt0.o" "$AROOT/usr/lib/crt0.o"
# Stage the bcc runtime into /usr/lib so /bin/b can find them inside apout.
cp "$HERE/runtime/bmain.s" "$AROOT/usr/lib/bmain.s"
cp "$HERE/runtime/brt.s"   "$AROOT/usr/lib/brt.s"
# /tmp is required by V1 cc for ctm files, and /bin/b uses /tmp/b.ic and /tmp/b.s
mkdir -p "$AROOT/tmp"

touch "$STAMP"
echo "built apout root: $AROOT"
