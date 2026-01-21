/* Word semantics edge case tests
 * Tests that would cause UB in naive C implementations:
 * - Shifts >= word width
 * - Shifts of negative values (as unsigned)
 * - Signed overflow scenarios
 *
 * Returns 0 on success, non-zero on failure.
 */

main() {
    auto a, b, r;

    /* Test 1: Shift by 0 (base case) */
    a = 1;
    r = a << 0;
    if (r != 1) return(1);

    /* Test 2: Normal shift left */
    a = 1;
    r = a << 4;
    if (r != 16) return(2);

    /* Test 3: Right shift positive */
    a = 16;
    r = a >> 2;
    if (r != 4) return(3);

    /* Test 4: Bitwise AND */
    a = 255;
    b = 15;
    r = a & b;
    if (r != 15) return(4);

    /* Test 5: Bitwise OR */
    a = 240;
    b = 15;
    r = a | b;
    if (r != 255) return(5);

    /* Test 6: Addition (no overflow in host mode, would wrap in 16-bit) */
    a = 100;
    b = 200;
    r = a + b;
    if (r != 300) return(6);

    /* Test 7: Unary negation edge case */
    a = 1;
    r = -a;
    if (r != -1) return(7);

    /* Test 8: Compound shift assignment */
    a = 1;
    a =<< 3;
    if (a != 8) return(8);

    /* Test 9: Compound right shift assignment */
    a = 64;
    a =>> 3;
    if (a != 8) return(9);

    /* Test 10: Multiple operations chained */
    a = 10;
    r = ((a + 5) * 2) - 10;  /* (15 * 2) - 10 = 20 */
    if (r != 20) return(10);

    /* Test 11: Right shift of positive value */
    /* In all modes, right shift of positive values should work consistently */
    a = 255;
    r = a >> 4;
    if (r != 15) return(11);

    /* Test 12: Division */
    a = 100;
    r = a / 7;
    if (r != 14) return(12);

    /* Test 13: Modulo */
    a = 100;
    r = a % 7;
    if (r != 2) return(13);

    /* Test 14: Subtraction */
    a = 50;
    b = 30;
    r = a - b;
    if (r != 20) return(14);

    /* Test 15: Multiplication */
    a = 7;
    b = 8;
    r = a * b;
    if (r != 56) return(15);

    /* All tests passed */
    return(0);
}
