#!/bin/bash
# Word Semantics Test Suite
# Tests that word operations are free of host-C undefined behavior
#
# This script tests the B compiler's word arithmetic against edge cases
# that would cause UB in a naive C implementation.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BCC="${SCRIPT_DIR}/../bcc"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
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
        echo "  Reason: $2"
    fi
    ((FAILED++))
}

# Make sure compiler exists
if [[ ! -x "$BCC" ]]; then
    echo "Error: Compiler not found at $BCC"
    echo "Run 'make' first"
    exit 1
fi

echo "Word Semantics Test Suite"
echo "========================="
echo ""

# Create a temporary test file for edge cases
TEST_B=$(mktemp --suffix=.b)
trap "rm -f $TEST_B /tmp/word_test_*" EXIT

# Test 1: Large shift counts in 16-bit mode
echo "=== 16-bit Mode Tests ==="

cat > "$TEST_B" << 'EOF'
main() {
    auto a, r;
    /* Large shift should be masked to valid range */
    a = 1;
    r = a << 20;  /* 20 & 15 = 4, so result is 16 */
    if (r != 16) return(1);
    return(0);
}
EOF

if "$BCC" --word=16 "$TEST_B" -o /tmp/word_test_1 2>/dev/null; then
    result=$(/tmp/word_test_1 2>&1; echo $?)
    exit_code=$(echo "$result" | tail -1)
    if [[ "$exit_code" == "0" ]]; then
        pass "16-bit: large shift count (20) masked to valid range"
    else
        fail "16-bit: large shift count" "exit code $exit_code"
    fi
else
    fail "16-bit: large shift count" "compilation failed"
fi

# Test 2: 1 << 15 in 16-bit mode should give -32768
cat > "$TEST_B" << 'EOF'
main() {
    auto a;
    a = 1 << 15;
    if (a != -32768) return(1);
    return(0);
}
EOF

if "$BCC" --word=16 "$TEST_B" -o /tmp/word_test_2 2>/dev/null; then
    result=$(/tmp/word_test_2 2>&1; echo $?)
    exit_code=$(echo "$result" | tail -1)
    if [[ "$exit_code" == "0" ]]; then
        pass "16-bit: 1 << 15 == -32768"
    else
        fail "16-bit: 1 << 15" "exit code $exit_code"
    fi
else
    fail "16-bit: 1 << 15" "compilation failed"
fi

# Test 3: -1 >> 1 should be positive (logical shift)
cat > "$TEST_B" << 'EOF'
main() {
    auto a;
    a = -1 >> 1;
    /* -1 as unsigned 16-bit is 0xFFFF, >> 1 gives 0x7FFF = 32767 */
    if (a != 32767) return(1);
    return(0);
}
EOF

if "$BCC" --word=16 "$TEST_B" -o /tmp/word_test_3 2>/dev/null; then
    result=$(/tmp/word_test_3 2>&1; echo $?)
    exit_code=$(echo "$result" | tail -1)
    if [[ "$exit_code" == "0" ]]; then
        pass "16-bit: -1 >> 1 == 32767 (logical shift)"
    else
        fail "16-bit: -1 >> 1" "exit code $exit_code"
    fi
else
    fail "16-bit: -1 >> 1" "compilation failed"
fi

# Test 4: Overflow wrapping in 16-bit
cat > "$TEST_B" << 'EOF'
main() {
    auto a;
    a = 32767 + 1;  /* Should wrap to -32768 */
    if (a != -32768) return(1);
    return(0);
}
EOF

if "$BCC" --word=16 "$TEST_B" -o /tmp/word_test_4 2>/dev/null; then
    result=$(/tmp/word_test_4 2>&1; echo $?)
    exit_code=$(echo "$result" | tail -1)
    if [[ "$exit_code" == "0" ]]; then
        pass "16-bit: 32767 + 1 == -32768 (overflow wrap)"
    else
        fail "16-bit: overflow wrap" "exit code $exit_code"
    fi
else
    fail "16-bit: overflow wrap" "compilation failed"
fi

# Test 5: Negation of minimum value in 16-bit
cat > "$TEST_B" << 'EOF'
main() {
    auto a;
    a = -(-32768);  /* -(-32768) in 16-bit wraps back to -32768 */
    if (a != -32768) return(1);
    return(0);
}
EOF

if "$BCC" --word=16 "$TEST_B" -o /tmp/word_test_5 2>/dev/null; then
    result=$(/tmp/word_test_5 2>&1; echo $?)
    exit_code=$(echo "$result" | tail -1)
    if [[ "$exit_code" == "0" ]]; then
        pass "16-bit: -(-32768) == -32768 (negation edge case)"
    else
        fail "16-bit: negation edge case" "exit code $exit_code"
    fi
else
    fail "16-bit: negation edge case" "compilation failed"
fi

echo ""
echo "=== 32-bit Mode Tests ==="

# Test 6: Large shift counts in 32-bit mode
cat > "$TEST_B" << 'EOF'
main() {
    auto a, r;
    /* Large shift should be masked: 40 & 31 = 8 */
    a = 1;
    r = a << 40;
    if (r != 256) return(1);
    return(0);
}
EOF

if "$BCC" --word=32 "$TEST_B" -o /tmp/word_test_6 2>/dev/null; then
    result=$(/tmp/word_test_6 2>&1; echo $?)
    exit_code=$(echo "$result" | tail -1)
    if [[ "$exit_code" == "0" ]]; then
        pass "32-bit: large shift count (40) masked to valid range"
    else
        fail "32-bit: large shift count" "exit code $exit_code"
    fi
else
    fail "32-bit: large shift count" "compilation failed"
fi

# Test 7: 1 << 31 in 32-bit mode should give -2147483648
cat > "$TEST_B" << 'EOF'
main() {
    auto a;
    a = 1 << 31;
    if (a != -2147483648) return(1);
    return(0);
}
EOF

if "$BCC" --word=32 "$TEST_B" -o /tmp/word_test_7 2>/dev/null; then
    result=$(/tmp/word_test_7 2>&1; echo $?)
    exit_code=$(echo "$result" | tail -1)
    if [[ "$exit_code" == "0" ]]; then
        pass "32-bit: 1 << 31 == -2147483648"
    else
        fail "32-bit: 1 << 31" "exit code $exit_code"
    fi
else
    fail "32-bit: 1 << 31" "compilation failed"
fi

echo ""
echo "=== Host (Native) Mode Tests ==="

# Test 8: Basic operations work in host mode
cat > "$TEST_B" << 'EOF'
main() {
    auto a, b, r;
    a = 100;
    b = 50;
    r = ((a + b) * 2) / 3;  /* (150 * 2) / 3 = 100 */
    if (r != 100) return(1);
    return(0);
}
EOF

if "$BCC" --word=host "$TEST_B" -o /tmp/word_test_8 2>/dev/null; then
    result=$(/tmp/word_test_8 2>&1; echo $?)
    exit_code=$(echo "$result" | tail -1)
    if [[ "$exit_code" == "0" ]]; then
        pass "host: basic arithmetic"
    else
        fail "host: basic arithmetic" "exit code $exit_code"
    fi
else
    fail "host: basic arithmetic" "compilation failed"
fi

# Test 9: Compound shift assignments
cat > "$TEST_B" << 'EOF'
main() {
    auto a;
    a = 1;
    a =<< 4;  /* a = 16 */
    a =>> 2;  /* a = 4 */
    if (a != 4) return(1);
    return(0);
}
EOF

if "$BCC" "$TEST_B" -o /tmp/word_test_9 2>/dev/null; then
    result=$(/tmp/word_test_9 2>&1; echo $?)
    exit_code=$(echo "$result" | tail -1)
    if [[ "$exit_code" == "0" ]]; then
        pass "compound shift assignments"
    else
        fail "compound shift assignments" "exit code $exit_code"
    fi
else
    fail "compound shift assignments" "compilation failed"
fi

# Test 10: Bitwise AND and OR
cat > "$TEST_B" << 'EOF'
main() {
    auto a, b, r;
    a = 255;
    b = 170;  /* 10101010 binary */
    r = a & b;
    if (r != 170) return(1);
    r = a | b;
    if (r != 255) return(2);
    return(0);
}
EOF

if "$BCC" "$TEST_B" -o /tmp/word_test_10 2>/dev/null; then
    result=$(/tmp/word_test_10 2>&1; echo $?)
    exit_code=$(echo "$result" | tail -1)
    if [[ "$exit_code" == "0" ]]; then
        pass "bitwise AND/OR"
    else
        fail "bitwise AND/OR" "exit code $exit_code"
    fi
else
    fail "bitwise AND/OR" "compilation failed"
fi

echo ""
echo "========================="
echo -e "Results: ${GREEN}$PASSED passed${NC}, ${RED}$FAILED failed${NC}"

if [[ $FAILED -gt 0 ]]; then
    exit 1
fi
exit 0

