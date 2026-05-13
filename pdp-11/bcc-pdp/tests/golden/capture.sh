#!/bin/sh
# Capture current pipeline's b1-output assembly for golden regression.
set -eu
cd "$(dirname "$0")/../.."

make >/dev/null

HERE=$(pwd)
AROOT=$HERE/build/aroot
APOUT=$HERE/../unix-v1/tools/apout/apout
B00=$HERE/build/b00
B01=$HERE/build/b01
B1=$HERE/build/b1

cases="hello:tests/run/t01_hello.b
fact:examples/fact.b
fib:examples/fib.b
sieve:examples/sieve.b
printn:tests/run/t12_printn.b"

for kv in $cases; do
    name=${kv%%:*}
    src=${kv#*:}
    cp "$src" "$AROOT/_g.b"
    (
        cd "$AROOT"
        APOUT_ROOT=. "$APOUT" "$B00" -o _g.ic _g.b 2>/dev/null
    ) || {
        echo "skip $name: b00 failed"
        rm -f "$AROOT/_g.b"
        continue
    }
    (
        cd "$AROOT"
        APOUT_ROOT=. "$APOUT" "$B01" -i _g.ic -o _g.r2 2>/dev/null
        APOUT_ROOT=. "$APOUT" "$B1" -i _g.r2 -o _g.s 2>/dev/null
    )
    cp "$AROOT/_g.s" "tests/golden/$name.s.golden"
    echo "captured $name"
done
rm -f "$AROOT/_g.b" "$AROOT/_g.ic" "$AROOT/_g.r2" "$AROOT/_g.s"
