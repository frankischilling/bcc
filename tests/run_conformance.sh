#!/bin/bash
# B Compiler Conformance Test Suite
# 
# This script runs comprehensive conformance tests that validate B language
# semantics including char/lchar, arrays, switch fallthrough, compound
# assignments, pointers, strings, and complex expressions.
#
# Usage:
#   ./run_conformance.sh                    # Run all tests
#   ./run_conformance.sh --verbose          # Verbose output
#   ./run_conformance.sh --filter NAME      # Run tests matching NAME
#   ./run_conformance.sh --word=16          # Run in 16-bit mode
#   ./run_conformance.sh --generate-golden  # Generate reference outputs
#   ./run_conformance.sh --diff-test        # Compare against golden outputs

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BCC="${SCRIPT_DIR}/../bcc"
CONFORMANCE_DIR="${SCRIPT_DIR}/conformance"
GOLDEN_DIR="${SCRIPT_DIR}/conformance/golden"

# Options
VERBOSE=0
FILTER=""
WORD_MODE=""
GENERATE_GOLDEN=0
DIFF_TEST=0

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Counters
PASSED=0
FAILED=0
SKIPPED=0

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--verbose)
            VERBOSE=1
            shift
            ;;
        -f|--filter)
            FILTER="$2"
            shift 2
            ;;
        --word=*)
            WORD_MODE="${1#*=}"
            shift
            ;;
        --generate-golden)
            GENERATE_GOLDEN=1
            shift
            ;;
        --diff-test)
            DIFF_TEST=1
            shift
            ;;
        -h|--help)
            echo "B Compiler Conformance Test Suite"
            echo ""
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  -v, --verbose         Show detailed output"
            echo "  -f, --filter NAME     Run only tests matching NAME"
            echo "  --word=N              Set word mode (host, 16, 32)"
            echo "  --generate-golden     Generate golden reference outputs"
            echo "  --diff-test           Compare outputs against golden files"
            echo "  -h, --help            Show this help"
            echo ""
            echo "Tests:"
            echo "  char_lchar        - Byte access with char()/lchar()"
            echo "  switch_fallthrough - Switch statement fallthrough"
            echo "  compound_assign   - B-style compound assignments (=+, =-, etc)"
            echo "  arrays_vectors    - Array/vector operations"
            echo "  strings           - String manipulation"
            echo "  pointers          - Pointer arithmetic and dereferencing"
            echo "  expressions       - Complex expression evaluation"
            echo "  control_flow      - Nested control structures"
            echo "  recursion         - Recursive algorithms"
            echo "  operators         - All B operators"
            echo "  globals           - Global variable semantics"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
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
        echo "       $2"
    fi
    ((FAILED++))
}

skip() {
    echo -e "${YELLOW}SKIP${NC}: $1"
    ((SKIPPED++))
}

matches_filter() {
    if [[ -z "$FILTER" ]]; then
        return 0
    fi
    [[ "$1" == *"$FILTER"* ]]
}

# Build compiler flags
BCC_FLAGS=""
if [[ -n "$WORD_MODE" ]]; then
    BCC_FLAGS="--word=$WORD_MODE"
fi

# Check compiler exists
if [[ ! -x "$BCC" ]]; then
    echo "Error: Compiler not found at $BCC"
    echo "Run 'make' first"
    exit 1
fi

# Create golden directory if generating
if [[ $GENERATE_GOLDEN -eq 1 ]]; then
    mkdir -p "$GOLDEN_DIR"
fi

echo "B Compiler Conformance Test Suite"
echo "=================================="
if [[ -n "$WORD_MODE" ]]; then
    echo "Word mode: $WORD_MODE"
fi
echo ""

# Run conformance tests
run_conformance_tests() {
    echo -e "${BLUE}=== Conformance Tests ===${NC}"
    
    for f in "$CONFORMANCE_DIR"/*.b; do
        [[ -f "$f" ]] || continue
        name=$(basename "$f" .b)
        matches_filter "$name" || continue
        
        expected_exit="${f%.b}.exit"
        expected_out="${f%.b}.out"
        golden_out="$GOLDEN_DIR/${name}.out"
        golden_exit="$GOLDEN_DIR/${name}.exit"
        
        log "Testing: $name"
        
        # Compile
        if ! "$BCC" $BCC_FLAGS "$f" -o /tmp/conf_test_$$ 2>/tmp/conf_err_$$; then
            if [[ $VERBOSE -eq 1 ]]; then
                fail "$name" "Compilation failed"
                cat /tmp/conf_err_$$
            else
                fail "$name" "Compilation failed: $(head -1 /tmp/conf_err_$$)"
            fi
            rm -f /tmp/conf_err_$$
            continue
        fi
        rm -f /tmp/conf_err_$$
        
        # Run
        /tmp/conf_test_$$ > /tmp/conf_out_$$ 2>&1
        actual_exit=$?
        
        # Generate golden output if requested
        if [[ $GENERATE_GOLDEN -eq 1 ]]; then
            cp /tmp/conf_out_$$ "$golden_out"
            echo "$actual_exit" > "$golden_exit"
            echo -e "${BLUE}GENERATED${NC}: $name (exit: $actual_exit)"
            rm -f /tmp/conf_test_$$ /tmp/conf_out_$$
            continue
        fi
        
        # Check exit code
        if [[ -f "$expected_exit" ]]; then
            expected_exit_code=$(cat "$expected_exit")
            if [[ "$actual_exit" -ne "$expected_exit_code" ]]; then
                fail "$name" "Exit code: expected $expected_exit_code, got $actual_exit"
                rm -f /tmp/conf_test_$$ /tmp/conf_out_$$
                continue
            fi
        fi
        
        # Check output if expected file exists
        if [[ -f "$expected_out" ]]; then
            if ! diff -q "$expected_out" /tmp/conf_out_$$ >/dev/null 2>&1; then
                fail "$name" "Output mismatch"
                if [[ $VERBOSE -eq 1 ]]; then
                    echo "Expected:"
                    head -5 "$expected_out" | sed 's/^/  /'
                    echo "Got:"
                    head -5 /tmp/conf_out_$$ | sed 's/^/  /'
                fi
                rm -f /tmp/conf_test_$$ /tmp/conf_out_$$
                continue
            fi
        fi
        
        # Differential testing against golden files
        if [[ $DIFF_TEST -eq 1 && -f "$golden_out" ]]; then
            if ! diff -q "$golden_out" /tmp/conf_out_$$ >/dev/null 2>&1; then
                fail "$name" "Differs from golden output"
                if [[ $VERBOSE -eq 1 ]]; then
                    echo "Diff:"
                    diff "$golden_out" /tmp/conf_out_$$ | head -10
                fi
                rm -f /tmp/conf_test_$$ /tmp/conf_out_$$
                continue
            fi
            if [[ -f "$golden_exit" ]]; then
                golden_exit_code=$(cat "$golden_exit")
                if [[ "$actual_exit" -ne "$golden_exit_code" ]]; then
                    fail "$name" "Exit differs from golden: expected $golden_exit_code, got $actual_exit"
                    rm -f /tmp/conf_test_$$ /tmp/conf_out_$$
                    continue
                fi
            fi
        fi
        
        pass "$name"
        rm -f /tmp/conf_test_$$ /tmp/conf_out_$$
    done
}

# Summary of test categories
show_test_coverage() {
    echo ""
    echo -e "${BLUE}Test Coverage:${NC}"
    echo "  char_lchar        - Byte access within words"
    echo "  switch_fallthrough - B's default fallthrough behavior"
    echo "  compound_assign   - B-style =+, =-, =*, etc."
    echo "  arrays_vectors    - Array indexing and manipulation"
    echo "  strings           - String functions (strlen, strcmp, etc.)"
    echo "  pointers          - Address-of, dereference, arithmetic"
    echo "  expressions       - Precedence, associativity, edge cases"
    echo "  control_flow      - Nested if/while/switch/goto"
    echo "  recursion         - Factorial, fib, quicksort, etc."
    echo "  operators         - All arithmetic/bitwise/comparison ops"
    echo "  globals           - Global variable semantics"
}

run_conformance_tests

if [[ $GENERATE_GOLDEN -eq 1 ]]; then
    echo ""
    echo "Golden outputs generated in $GOLDEN_DIR"
    exit 0
fi

echo ""
echo "=================================="
echo -e "Results: ${GREEN}$PASSED passed${NC}, ${RED}$FAILED failed${NC}, ${YELLOW}$SKIPPED skipped${NC}"

if [[ $VERBOSE -eq 1 ]]; then
    show_test_coverage
fi

if [[ $FAILED -gt 0 ]]; then
    exit 1
fi
exit 0

