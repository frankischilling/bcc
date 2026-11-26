#!/bin/bash
# Historical strict-mode tests for Thompson B72 compatibility.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BCC="${SCRIPT_DIR}/../bcc"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

PASSED=0
FAILED=0

pass() {
    echo -e "${GREEN}PASS${NC}: $1"
    ((PASSED++))
}

fail() {
    echo -e "${RED}FAIL${NC}: $1"
    if [[ -n "$2" ]]; then
        echo "  $2"
    fi
    ((FAILED++))
}

tmpdir=$(mktemp -d /tmp/bcc_strict_XXXXXX)
trap 'rm -rf "$tmpdir"' EXIT

strict_ok="$tmpdir/strict_ok.b"
logical_or="$tmpdir/logical_or.b"
long_char="$tmpdir/long_char.b"

cat > "$strict_ok" <<'BEOF'
main() {
    auto x;
    x = 1 | 0;
    return(x);
}
BEOF

cat > "$logical_or" <<'BEOF'
main() {
    return(0 || 1);
}
BEOF

cat > "$long_char" <<'BEOF'
main() {
    return('abc');
}
BEOF

if "$BCC" --strict --pedantic "$strict_ok" -o "$tmpdir/strict_ok" 2>"$tmpdir/strict_ok.err"; then
    "$tmpdir/strict_ok"
    rc=$?
    if [[ $rc -eq 1 ]]; then
        pass "strict B72 accepts standard bitwise OR"
    else
        fail "strict B72 accepts standard bitwise OR" "exit code $rc"
    fi
else
    fail "strict B72 accepts standard bitwise OR" "$(head -1 "$tmpdir/strict_ok.err")"
fi

if "$BCC" "$logical_or" -o "$tmpdir/logical_or_default" 2>"$tmpdir/logical_or_default.err"; then
    pass "default mode accepts logical OR extension"
else
    fail "default mode accepts logical OR extension" "$(head -1 "$tmpdir/logical_or_default.err")"
fi

if "$BCC" --strict --pedantic --verbose-errors "$logical_or" -o "$tmpdir/logical_or_strict" 2>"$tmpdir/logical_or_strict.err"; then
    fail "strict B72 rejects logical OR extension" "compiled successfully"
else
    if grep -q "not part of Thompson B72" "$tmpdir/logical_or_strict.err"; then
        pass "strict B72 rejects logical OR extension"
    else
        fail "strict B72 rejects logical OR extension" "$(head -1 "$tmpdir/logical_or_strict.err")"
    fi
fi

if "$BCC" "$long_char" -o "$tmpdir/long_char_default" 2>"$tmpdir/long_char_default.err"; then
    pass "default mode accepts long character constant extension"
else
    fail "default mode accepts long character constant extension" "$(head -1 "$tmpdir/long_char_default.err")"
fi

if "$BCC" --strict --pedantic --verbose-errors "$long_char" -o "$tmpdir/long_char_strict" 2>"$tmpdir/long_char_strict.err"; then
    fail "strict B72 rejects long character constants" "compiled successfully"
else
    if grep -q "longer than 2 bytes" "$tmpdir/long_char_strict.err"; then
        pass "strict B72 rejects long character constants"
    else
        fail "strict B72 rejects long character constants" "$(head -1 "$tmpdir/long_char_strict.err")"
    fi
fi

echo "Results: $PASSED passed, $FAILED failed"

if [[ $FAILED -gt 0 ]]; then
    exit 1
fi
exit 0
