#!/bin/bash
# B Compiler Test Suite
# Usage: ./run_tests.sh [--verbose] [--filter PATTERN]

# Don't use set -e - we handle errors ourselves

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BCC="${SCRIPT_DIR}/../bcc"
VERBOSE=0
FILTER=""
PASSED=0
FAILED=0
SKIPPED=0

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--verbose) VERBOSE=1; shift ;;
        -f|--filter) FILTER="$2"; shift 2 ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
done

log() {
    if [[ $VERBOSE -eq 1 ]]; then
        echo "$@"
    fi
}

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

skip() {
    echo -e "${YELLOW}SKIP${NC}: $1"
    ((SKIPPED++))
}

# Check if test matches filter
matches_filter() {
    if [[ -z "$FILTER" ]]; then
        return 0
    fi
    [[ "$1" == *"$FILTER"* ]]
}

# ============ Compile-only tests ============
# These tests should compile without errors
run_compile_tests() {
    echo "=== Compile-only tests ==="
    for f in "$SCRIPT_DIR"/compile/*.b; do
        [[ -f "$f" ]] || continue
        name=$(basename "$f" .b)
        matches_filter "compile/$name" || continue

        log "Testing: compile/$name"

        # Check for expected failure
        if [[ -f "${f%.b}.fail" ]]; then
            # Should fail to compile
            if "$BCC" "$f" -o /tmp/test_$$ 2>/dev/null; then
                rm -f /tmp/test_$$
                fail "compile/$name" "Expected compilation to fail"
            else
                pass "compile/$name (expected fail)"
            fi
        else
            # Should succeed
            if "$BCC" "$f" -o /tmp/test_$$ 2>/tmp/compile_err_$$; then
                rm -f /tmp/test_$$
                pass "compile/$name"
            else
                fail "compile/$name" "$(head -3 /tmp/compile_err_$$)"
            fi
            rm -f /tmp/compile_err_$$
        fi
    done
}

# ============ Run tests ============
# These tests run and check output/exit code
run_run_tests() {
    echo "=== Run tests ==="
    for f in "$SCRIPT_DIR"/run/*.b; do
        [[ -f "$f" ]] || continue
        name=$(basename "$f" .b)
        matches_filter "run/$name" || continue

        log "Testing: run/$name"

        expected_out="${f%.b}.out"
        expected_exit="${f%.b}.exit"
        input_file="${f%.b}.in"

        # Compile
        if ! "$BCC" "$f" -o /tmp/test_$$ 2>/tmp/compile_err_$$; then
            fail "run/$name" "Compilation failed: $(head -1 /tmp/compile_err_$$)"
            rm -f /tmp/compile_err_$$
            continue
        fi
        rm -f /tmp/compile_err_$$

        # Run with optional input
        if [[ -f "$input_file" ]]; then
            /tmp/test_$$ < "$input_file" > /tmp/actual_out_$$ 2>&1
        else
            /tmp/test_$$ > /tmp/actual_out_$$ 2>&1
        fi
        actual_exit=$?

        # Check exit code
        if [[ -f "$expected_exit" ]]; then
            expected_exit_code=$(cat "$expected_exit")
            if [[ "$actual_exit" -ne "$expected_exit_code" ]]; then
                fail "run/$name" "Exit code: expected $expected_exit_code, got $actual_exit"
                rm -f /tmp/test_$$ /tmp/actual_out_$$
                continue
            fi
        fi

        # Check output
        if [[ -f "$expected_out" ]]; then
            if ! diff -q "$expected_out" /tmp/actual_out_$$ >/dev/null 2>&1; then
                fail "run/$name" "Output mismatch"
                if [[ $VERBOSE -eq 1 ]]; then
                    echo "  Expected:"
                    head -5 "$expected_out" | sed 's/^/    /'
                    echo "  Got:"
                    head -5 /tmp/actual_out_$$ | sed 's/^/    /'
                fi
                rm -f /tmp/test_$$ /tmp/actual_out_$$
                continue
            fi
        fi

        pass "run/$name"
        rm -f /tmp/test_$$ /tmp/actual_out_$$
    done
}

# ============ Program tests ============
# Larger known-good programs
run_program_tests() {
    echo "=== Program tests ==="
    for f in "$SCRIPT_DIR"/programs/*.b; do
        [[ -f "$f" ]] || continue
        name=$(basename "$f" .b)
        matches_filter "programs/$name" || continue

        log "Testing: programs/$name"

        expected_out="${f%.b}.out"
        expected_exit="${f%.b}.exit"
        input_file="${f%.b}.in"

        # Compile
        if ! "$BCC" "$f" -o /tmp/test_$$ 2>/tmp/compile_err_$$; then
            fail "programs/$name" "Compilation failed: $(head -1 /tmp/compile_err_$$)"
            rm -f /tmp/compile_err_$$
            continue
        fi
        rm -f /tmp/compile_err_$$

        # Run with optional input
        if [[ -f "$input_file" ]]; then
            timeout 5 /tmp/test_$$ < "$input_file" > /tmp/actual_out_$$ 2>&1
        else
            timeout 5 /tmp/test_$$ > /tmp/actual_out_$$ 2>&1
        fi
        actual_exit=$?

        # Check exit code
        if [[ -f "$expected_exit" ]]; then
            expected_exit_code=$(cat "$expected_exit")
            if [[ "$actual_exit" -ne "$expected_exit_code" ]]; then
                fail "programs/$name" "Exit code: expected $expected_exit_code, got $actual_exit"
                rm -f /tmp/test_$$ /tmp/actual_out_$$
                continue
            fi
        fi

        # Check output
        if [[ -f "$expected_out" ]]; then
            if ! diff -q "$expected_out" /tmp/actual_out_$$ >/dev/null 2>&1; then
                fail "programs/$name" "Output mismatch"
                rm -f /tmp/test_$$ /tmp/actual_out_$$
                continue
            fi
        fi

        pass "programs/$name"
        rm -f /tmp/test_$$ /tmp/actual_out_$$
    done
}

# ============ AST snapshot tests ============
# Check --dump-ast output matches golden file
run_ast_tests() {
    echo "=== AST snapshot tests ==="
    for f in "$SCRIPT_DIR"/ast/*.b; do
        [[ -f "$f" ]] || continue
        name=$(basename "$f" .b)
        matches_filter "ast/$name" || continue

        log "Testing: ast/$name"

        golden="${f%.b}.ast"

        if [[ ! -f "$golden" ]]; then
            skip "ast/$name (no golden file)"
            continue
        fi

        # Get AST dump
        "$BCC" "$f" --dump-ast > /tmp/actual_ast_$$ 2>&1

        if ! diff -q "$golden" /tmp/actual_ast_$$ >/dev/null 2>&1; then
            fail "ast/$name" "AST mismatch"
            if [[ $VERBOSE -eq 1 ]]; then
                diff "$golden" /tmp/actual_ast_$$ | head -20
            fi
            rm -f /tmp/actual_ast_$$
            continue
        fi

        pass "ast/$name"
        rm -f /tmp/actual_ast_$$
    done
}

# ============ Multi-file tests ============
run_multifile_tests() {
    echo "=== Multi-file tests ==="
    for dir in "$SCRIPT_DIR"/multifile/*/; do
        [[ -d "$dir" ]] || continue
        name=$(basename "$dir")
        matches_filter "multifile/$name" || continue

        log "Testing: multifile/$name"

        # Find all .b files in directory
        files=("$dir"/*.b)
        if [[ ${#files[@]} -eq 0 ]]; then
            skip "multifile/$name (no .b files)"
            continue
        fi

        expected_out="$dir/expected.out"
        expected_exit="$dir/expected.exit"
        input_file="$dir/input.in"

        # Compile all files
        if ! "$BCC" "${files[@]}" -o /tmp/test_$$ 2>/tmp/compile_err_$$; then
            fail "multifile/$name" "Compilation failed: $(head -1 /tmp/compile_err_$$)"
            rm -f /tmp/compile_err_$$
            continue
        fi
        rm -f /tmp/compile_err_$$

        # Run
        if [[ -f "$input_file" ]]; then
            timeout 5 /tmp/test_$$ < "$input_file" > /tmp/actual_out_$$ 2>&1
        else
            timeout 5 /tmp/test_$$ > /tmp/actual_out_$$ 2>&1
        fi
        actual_exit=$?

        # Check exit code
        if [[ -f "$expected_exit" ]]; then
            expected_exit_code=$(cat "$expected_exit")
            if [[ "$actual_exit" -ne "$expected_exit_code" ]]; then
                fail "multifile/$name" "Exit code: expected $expected_exit_code, got $actual_exit"
                rm -f /tmp/test_$$ /tmp/actual_out_$$
                continue
            fi
        fi

        # Check output
        if [[ -f "$expected_out" ]]; then
            if ! diff -q "$expected_out" /tmp/actual_out_$$ >/dev/null 2>&1; then
                fail "multifile/$name" "Output mismatch"
                rm -f /tmp/test_$$ /tmp/actual_out_$$
                continue
            fi
        fi

        pass "multifile/$name"
        rm -f /tmp/test_$$ /tmp/actual_out_$$
    done
}

# ============ Main ============
echo "B Compiler Test Suite"
echo "====================="
echo ""

# Make sure compiler exists
if [[ ! -x "$BCC" ]]; then
    echo "Error: Compiler not found at $BCC"
    echo "Run 'make' first"
    exit 1
fi

run_compile_tests
echo ""
run_run_tests
echo ""
run_program_tests
echo ""
run_ast_tests
echo ""
run_multifile_tests

echo ""
echo "====================="
echo -e "Results: ${GREEN}$PASSED passed${NC}, ${RED}$FAILED failed${NC}, ${YELLOW}$SKIPPED skipped${NC}"

if [[ $FAILED -gt 0 ]]; then
    exit 1
fi
exit 0
