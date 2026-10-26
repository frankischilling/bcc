#!/bin/sh
# Compile the B-written record reader inside Unix V1, then check its output.
set -eu
HERE=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT
trap 'exit 130' INT
trap 'exit 143' TERM HUP
cat "$HERE/src/io.b" "$HERE/src/ic.b" "$HERE/tests/ic_reader.b" > "$WORK/reader.b"
printf '%s\n' '-32768' > "$WORK/reader.out"
bash "$HERE/../tools/v1-run.sh" "$WORK/reader.b" --timings --workdir /usr/tmp
cat "$HERE/src/io.b" "$HERE/src/ic.b" "$HERE/tests/ic_blocks.b" > "$WORK/blocks.b"
printf '%s\n' 'records ok' > "$WORK/blocks.out"
bash "$HERE/../tools/v1-run.sh" "$WORK/blocks.b" --timings --workdir /usr/tmp
bash "$HERE/../tools/v1-run.sh" "$HERE/experiments/paged.b" --timings --workdir /usr/tmp
