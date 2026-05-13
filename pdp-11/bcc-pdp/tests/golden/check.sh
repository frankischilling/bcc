#!/bin/sh
# Compare today's pipeline output against golden .s files.
set -eu
cd "$(dirname "$0")/../.."

make >/dev/null

HERE=$(pwd)
AROOT=$HERE/build/aroot
APOUT=$HERE/../unix-v1/tools/apout/apout
B00=$HERE/build/b00
B01=$HERE/build/b01
B1=$HERE/build/b1
fail=0

cases="hello:tests/run/t01_hello.b
fact:examples/fact.b
fib:examples/fib.b
sieve:examples/sieve.b
printn:tests/run/t12_printn.b"

for kv in $cases; do
    name=${kv%%:*}
    src=${kv#*:}
    golden="tests/golden/$name.s.golden"
    [ -f "$golden" ] || {
        echo "MISSING $golden"
        fail=1
        continue
    }
    cp "$src" "$AROOT/_g.b"
    (
        cd "$AROOT"
        APOUT_ROOT=. "$APOUT" "$B00" -o _g.ic _g.b 2>/dev/null
    ) || {
        echo "FAIL $name (b00 failed)"
        fail=1
        continue
    }
    (
        cd "$AROOT"
        APOUT_ROOT=. "$APOUT" "$B01" -i _g.ic -o _g.r2 2>/dev/null
        APOUT_ROOT=. "$APOUT" "$B1" -i _g.r2 -o _g.s 2>/dev/null
    ) || {
        echo "FAIL $name (b1 failed)"
        fail=1
        continue
    }
    if diff -u "$golden" "$AROOT/_g.s" >/dev/null; then
        echo "PASS $name"
    else
        echo "FAIL $name (asm differs)"
        diff -u "$golden" "$AROOT/_g.s" | sed -n '1,40p'
        fail=1
    fi
done

rm -f "$AROOT/_g.b" "$AROOT/_g.ic" "$AROOT/_g.r2" "$AROOT/_g.s"
exit $fail
