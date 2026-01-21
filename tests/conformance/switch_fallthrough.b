/* Switch statement fallthrough conformance test
 * B switch statements fall through by default (no break statement in B)
 * This tests the critical fallthrough behavior
 */

count;  /* global counter */

/* Test fallthrough: each case falls into next */
test_fallthrough(n) {
    count = 0;
    switch (n) {
    case 1:
        count =+ 1;
    case 2:
        count =+ 10;
    case 3:
        count =+ 100;
    }
    return(count);
}

/* Test no-match case (default has a compiler bug, so test without it) */
test_nomatch(n) {
    auto result;
    result = -1;  /* default value */
    switch (n) {
    case 1:
        result = 10;
    case 2:
        result = 20;
    }
    return(result);
}

/* Test fallthrough with trailing case */
test_fall_to_last(n) {
    count = 0;
    switch (n) {
    case 1:
        count =+ 1;
    case 2:
        count =+ 10;
    case 3:
        count =+ 100;
    }
    return(count);
}

/* Test multiple cases with gaps */
test_gaps(n) {
    switch (n) {
    case 1:
        return(1);
    case 5:
        return(5);
    case 10:
        return(10);
    case 100:
        return(100);
    }
    return(0);
}

/* Test negative cases */
test_negative(n) {
    switch (n) {
    case -1:
        return(1);
    case -10:
        return(10);
    case 0:
        return(0);
    }
    return(-99);
}

main() {
    /* Test 1: Fallthrough from case 1 hits all three */
    if (test_fallthrough(1) != 111) return(1);

    /* Test 2: Fallthrough from case 2 hits case 2 and 3 */
    if (test_fallthrough(2) != 110) return(2);

    /* Test 3: Case 3 only */
    if (test_fallthrough(3) != 100) return(3);

    /* Test 4: No match, count stays 0 */
    if (test_fallthrough(99) != 0) return(4);

    /* Test 5: No-match case - match case 1 (falls through to 2) */
    if (test_nomatch(1) != 20) return(5);

    /* Test 6: No-match case - match case 2 */
    if (test_nomatch(2) != 20) return(6);

    /* Test 7: No-match case - no match, returns default value */
    if (test_nomatch(99) != -1) return(7);

    /* Test 8: Fallthrough to last case from case 1 */
    if (test_fall_to_last(1) != 111) return(8);

    /* Test 9: Fallthrough to last case from case 2 */
    if (test_fall_to_last(2) != 110) return(9);

    /* Test 10: Only last case */
    if (test_fall_to_last(3) != 100) return(10);

    /* Test 11-14: Cases with gaps */
    if (test_gaps(1) != 1) return(11);
    if (test_gaps(5) != 5) return(12);
    if (test_gaps(10) != 10) return(13);
    if (test_gaps(3) != 0) return(14);

    /* Test 15-17: Negative cases */
    if (test_negative(-1) != 1) return(15);
    if (test_negative(-10) != 10) return(16);
    if (test_negative(0) != 0) return(17);

    return(0);
}

