#!/bin/sh
# v1-run.sh INPUT.b
#
# Build/install the PDP-11 B compiler into the Unix V1 filesystem, stage
# INPUT.b in /, rebuild the SIMH disk images, boot V1, compile INPUT.b with
# /bin/b, run ./a.out, and print the captured program output.

set -eu

SRC=${1:?usage: v1-run.sh INPUT.b}
case "$SRC" in
	/*) ;;
	*) SRC="$(pwd)/$SRC" ;;
esac

[ -f "$SRC" ] || { echo "missing source: $SRC" >&2; exit 1; }

HERE="$(cd "$(dirname "$0")/.." && pwd)"
V1="$(cd "$HERE/../unix-v1" && pwd)"
BASE=v1.b
STAGE="$V1/fs/root/$BASE"
BACKUP="$HERE/build/v1-run.$$.bak"
HAD_STAGE=0

restore_stage() {
	if [ "$HAD_STAGE" = 1 ]; then
		cp "$BACKUP" "$STAGE"
	else
		rm -f "$STAGE"
	fi
	rm -f "$BACKUP"
}

(cd "$HERE" && make)
if [ -e "$STAGE" ]; then
	cp "$STAGE" "$BACKUP"
	HAD_STAGE=1
else
	: >"$BACKUP"
fi
trap restore_stage EXIT HUP INT TERM

cp "$SRC" "$STAGE"

"$HERE/tools/install_v1.sh" >/dev/null
"$HERE/tools/rebuild_v1.sh" >/dev/null
"$HERE/tools/v1_smoke.py" "$BASE"
