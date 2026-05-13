#!/bin/sh
# run-apout.sh INPUT.b [args...]
#
# 1) Build runtime/libb.s from libb.b if stale.
# 2) Compile INPUT.b through b00 (lex+parse -> raw IC) under apout.
# 3) Copy/resolve raw IC through b01 under apout.
# 4) Translate IC -> V1 as via b1 under apout.
# 4) Assemble (bmain + brt + libb + prog) via V1 as under apout.
# 5) Run the resulting V1 a.out under apout, forwarding extra args.

set -eu

SRC=${1:?usage: run-apout.sh INPUT.b [args...]}
shift || true
case "$SRC" in /*) ;; *) SRC="$(pwd)/$SRC" ;; esac

HERE="$(cd "$(dirname "$0")/.." && pwd)"
V1="$(cd "$HERE/../unix-v1" && pwd)"
APOUT=$V1/tools/apout/apout
AROOT=$HERE/build/aroot
B00=$HERE/build/b00
B01=$HERE/build/b01
B1=$HERE/build/b1
B00FLAGS=${B00FLAGS:-${B0FLAGS:-}}

[ -x "$APOUT" ] || { echo "missing apout: $APOUT" >&2; exit 1; }
[ -x "$B00"   ] || { echo "missing b00: run 'make' first" >&2; exit 1; }
[ -x "$B01"   ] || { echo "missing b01: run 'make' first" >&2; exit 1; }
[ -x "$B1"    ] || { echo "missing b1: run 'make' first" >&2; exit 1; }

# 1) Build libb.s if missing or older than libb.b.
LIBB_B=$HERE/runtime/libb.b
LIBB_S=$HERE/runtime/libb.s
if [ ! -f "$LIBB_S" ] || [ "$LIBB_B" -nt "$LIBB_S" ] \
   || [ "$B00" -nt "$LIBB_S" ] || [ "$B01" -nt "$LIBB_S" ] || [ "$B1" -nt "$LIBB_S" ]; then
	cp "$LIBB_B" "$AROOT/libb.b"
	(
		cd "$AROOT"
		APOUT_ROOT=. "$APOUT" "$B00" -o libb.ic libb.b
		APOUT_ROOT=. "$APOUT" "$B01" -i libb.ic -o libb.r2
		APOUT_ROOT=. "$APOUT" "$B1" -i libb.r2 -o libb.s
	)
	chmod 644 "$AROOT/libb.s"
	cp "$AROOT/libb.s" "$LIBB_S"
	rm -f "$AROOT/libb.b" "$AROOT/libb.ic" "$AROOT/libb.r2" "$AROOT/libb.s"
fi

# Stage source into aroot.
SRCNAME=$(basename "$SRC")
cp "$SRC" "$AROOT/$SRCNAME"

# 2) b00: .b -> prog.ic
(
	cd "$AROOT"
	# shellcheck disable=SC2086
	APOUT_ROOT=. "$APOUT" "$B00" $B00FLAGS -o prog.ic "$SRCNAME"
)
chmod 644 "$AROOT/prog.ic"

# 3) b01: prog.ic -> prog.r2
(
	cd "$AROOT"
	APOUT_ROOT=. "$APOUT" "$B01" -i prog.ic -o prog.r2
)
chmod 644 "$AROOT/prog.r2"

# 4) b1: prog.r2 -> prog.s
(
	cd "$AROOT"
	APOUT_ROOT=. "$APOUT" "$B1" -i prog.r2 -o prog.s
)
chmod 644 "$AROOT/prog.s"

rm -f "$AROOT/$SRCNAME" "$AROOT/prog.ic" "$AROOT/prog.r2"

# Stage runtime + .s into V1 dir for tools/as (which expects fs/root relative).
cp "$HERE/runtime/bmain.s" "$V1/bmain.s"
cp "$HERE/runtime/brt.s"   "$V1/brt.s"
cp "$LIBB_S"               "$V1/libb.s"
cp "$AROOT/prog.s"         "$V1/prog.s"
chmod 644 "$V1/bmain.s" "$V1/brt.s" "$V1/libb.s" "$V1/prog.s"
rm -f "$AROOT/prog.s"

# 5-6) Assemble and run, forwarding leftover args to a.out.
(
	cd "$V1"
	tools/as bmain.s brt.s libb.s prog.s > /dev/null
	chmod +x a.out
	if [ "$#" -gt 0 ]; then
		APOUT_ROOT=fs/root tools/apout/apout a.out "$@"
	else
		APOUT_ROOT=fs/root tools/apout/apout a.out
	fi
	STATUS=$?
	rm -f bmain.s brt.s libb.s prog.s a.out
	exit $STATUS
	)
