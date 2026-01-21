#!/bin/bash
# BCC Master Test Suite
# Runs all test categories: basic, conformance, and word semantics
#
# Usage:
#   ./run_all_tests.sh              # Run all tests
#   ./run_all_tests.sh --quick      # Skip slow tests
#   ./run_all_tests.sh --verbose    # Verbose output

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BCC="${SCRIPT_DIR}/../bcc"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Options
VERBOSE=""
QUICK=0

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--verbose)
            VERBOSE="--verbose"
            shift
            ;;
        -q|--quick)
            QUICK=1
            shift
            ;;
        -h|--help)
            echo "BCC Master Test Suite"
            echo ""
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  -v, --verbose    Show detailed output"
            echo "  -q, --quick      Skip slow tests (word semantics modes)"
            echo "  -h, --help       Show this help"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Check compiler exists
if [[ ! -x "$BCC" ]]; then
    echo -e "${RED}Error: Compiler not found at $BCC${NC}"
    echo "Run 'make' first"
    exit 1
fi

echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║          BCC - B Compiler Master Test Suite                  ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

TOTAL_PASSED=0
TOTAL_FAILED=0
TOTAL_SKIPPED=0

# ============================================================================
# Section 1: Basic Tests (compile, run, programs, ast, multifile)
# ============================================================================
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Section 1: Basic Tests${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

if [[ -x "${SCRIPT_DIR}/run_tests.sh" ]]; then
    output=$("${SCRIPT_DIR}/run_tests.sh" $VERBOSE 2>&1)
    echo "$output" | grep -E "^(PASS|FAIL|SKIP|Results):"
    
    # Extract counts
    results=$(echo "$output" | grep "^Results:")
    if [[ -n "$results" ]]; then
        passed=$(echo "$results" | grep -oP '\d+(?= passed)')
        failed=$(echo "$results" | grep -oP '\d+(?= failed)')
        skipped=$(echo "$results" | grep -oP '\d+(?= skipped)')
        TOTAL_PASSED=$((TOTAL_PASSED + ${passed:-0}))
        TOTAL_FAILED=$((TOTAL_FAILED + ${failed:-0}))
        TOTAL_SKIPPED=$((TOTAL_SKIPPED + ${skipped:-0}))
    fi
else
    echo -e "${YELLOW}Warning: run_tests.sh not found${NC}"
fi

echo ""

# ============================================================================
# Section 2: Conformance Tests
# ============================================================================
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Section 2: Conformance Tests${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

if [[ -x "${SCRIPT_DIR}/run_conformance.sh" ]]; then
    output=$("${SCRIPT_DIR}/run_conformance.sh" $VERBOSE 2>&1)
    echo "$output" | grep -E "^(PASS|FAIL|SKIP|Results):"
    
    # Extract counts
    results=$(echo "$output" | grep "^Results:")
    if [[ -n "$results" ]]; then
        passed=$(echo "$results" | grep -oP '\d+(?= passed)')
        failed=$(echo "$results" | grep -oP '\d+(?= failed)')
        skipped=$(echo "$results" | grep -oP '\d+(?= skipped)')
        TOTAL_PASSED=$((TOTAL_PASSED + ${passed:-0}))
        TOTAL_FAILED=$((TOTAL_FAILED + ${failed:-0}))
        TOTAL_SKIPPED=$((TOTAL_SKIPPED + ${skipped:-0}))
    fi
else
    echo -e "${YELLOW}Warning: run_conformance.sh not found${NC}"
fi

echo ""

# ============================================================================
# Section 3: Word Semantics Tests
# ============================================================================
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Section 3: Word Semantics Tests${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

if [[ $QUICK -eq 1 ]]; then
    echo -e "${YELLOW}Skipped (--quick mode)${NC}"
elif [[ -x "${SCRIPT_DIR}/test_word_semantics.sh" ]]; then
    output=$("${SCRIPT_DIR}/test_word_semantics.sh" 2>&1)
    echo "$output" | grep -E "^(PASS|FAIL|Results):"
    
    # Extract counts
    results=$(echo "$output" | grep "^Results:")
    if [[ -n "$results" ]]; then
        passed=$(echo "$results" | grep -oP '\d+(?= passed)')
        failed=$(echo "$results" | grep -oP '\d+(?= failed)')
        TOTAL_PASSED=$((TOTAL_PASSED + ${passed:-0}))
        TOTAL_FAILED=$((TOTAL_FAILED + ${failed:-0}))
    fi
else
    echo -e "${YELLOW}Warning: test_word_semantics.sh not found${NC}"
fi

echo ""

# ============================================================================
# Final Summary
# ============================================================================
echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║                      FINAL SUMMARY                           ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "  ${GREEN}Passed:${NC}  $TOTAL_PASSED"
echo -e "  ${RED}Failed:${NC}  $TOTAL_FAILED"
echo -e "  ${YELLOW}Skipped:${NC} $TOTAL_SKIPPED"
echo ""

if [[ $TOTAL_FAILED -eq 0 ]]; then
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                    ALL TESTS PASSED! ✓                       ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    exit 0
else
    echo -e "${RED}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║                    SOME TESTS FAILED ✗                       ║${NC}"
    echo -e "${RED}╚══════════════════════════════════════════════════════════════╝${NC}"
    exit 1
fi

