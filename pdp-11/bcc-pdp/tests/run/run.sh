#!/bin/sh
# Tier 2 end-to-end: compile each tests/run/*.b through bcc-pdp,
# link with runtime, run under apout, diff stdout against *.out.
#
# Conventions:
#   <name>.b           - source program
#   <name>.out         - expected stdout (positive test)
#   <name>.args        - optional whitespace-separated argv (one line)
#   <name>.reject      - present means compilation MUST fail (negative test);
#                        the .reject file's contents are an expected substring
#                        of stderr/stdout from the failing b00 run.

set -eu
cd "$(dirname "$0")/../.."
fail=0

for src in tests/run/*.b; do
    case=$(basename "$src" .b)
    rej="tests/run/$case.reject"
    if [ -f "$rej" ]; then
        # Negative test: run b00 directly, expect non-zero exit.
        AROOT=build/aroot
        cp "$src" "$AROOT/_rej.b"
        if (cd "$AROOT" && APOUT_ROOT=. ../../../unix-v1/tools/apout/apout \
             ../../build/b00 -o /tmp/_rej.ic _rej.b) >"$AROOT/_rej.log" 2>&1; then
            echo "FAIL $case (expected b00 to reject, but it accepted)"
            fail=1
        else
            need=$(cat "$rej")
            if grep -q "$need" "$AROOT/_rej.log"; then
                echo "PASS $case (rejected with: $need)"
            else
                echo "FAIL $case (rejected, but not with '$need')"
                cat "$AROOT/_rej.log" | head -5
                fail=1
            fi
        fi
        rm -f "$AROOT/_rej.b" "$AROOT/_rej.log"
        continue
    fi

    exp="tests/run/$case.out"
    [ -f "$exp" ] || { echo "MISSING $case.out"; fail=1; continue; }
    args=""
    [ -f "tests/run/$case.args" ] && args=$(cat "tests/run/$case.args")

    # shellcheck disable=SC2086
    got=$(tools/run-apout.sh "$src" $args 2>/dev/null || true)
    if [ "$got" = "$(cat "$exp")" ]; then
        echo "PASS $case"
    else
        echo "FAIL $case"
        diff <(echo "$got") "$exp" | head -20
        fail=1
    fi
done

exit $fail
