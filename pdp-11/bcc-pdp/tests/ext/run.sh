#!/bin/sh
# Extension-mode end-to-end tests.  These must compile only with b00 -x.

set -eu
cd "$(dirname "$0")/../.."
fail=0

for src in tests/ext/*.b; do
	case=$(basename "$src" .b)
	exp="tests/ext/$case.out"
	[ -f "$exp" ] || { echo "MISSING $case.out"; fail=1; continue; }
	got=$(B0FLAGS=-x tools/run-apout.sh "$src" 2>/dev/null || true)
	if [ "$got" = "$(cat "$exp")" ]; then
		echo "PASS $case"
	else
		echo "FAIL $case"
		diff <(echo "$got") "$exp" | head -20
		fail=1
	fi
done

exit $fail
