/* Operator conformance test
 * Tests all B operators with edge cases
 */

main() {
    auto a, b, x;

    /* ============ Arithmetic Operators ============ */

    /* Test 1-3: Addition */
    if (5 + 3 != 8) return(1);
    if (-5 + 3 != -2) return(2);
    if (-5 + -3 != -8) return(3);

    /* Test 4-6: Subtraction */
    if (10 - 3 != 7) return(4);
    if (3 - 10 != -7) return(5);
    if (-5 - -3 != -2) return(6);

    /* Test 7-9: Multiplication */
    if (6 * 7 != 42) return(7);
    if (-6 * 7 != -42) return(8);
    if (-6 * -7 != 42) return(9);

    /* Test 10-12: Division */
    if (42 / 6 != 7) return(10);
    if (43 / 6 != 7) return(11);  /* truncates */
    if (-42 / 6 != -7) return(12);

    /* Test 13-15: Modulo */
    if (17 % 5 != 2) return(13);
    if (15 % 5 != 0) return(14);
    if (3 % 5 != 3) return(15);

    /* ============ Bitwise Operators ============ */

    /* Test 16-18: Bitwise AND */
    if ((255 & 15) != 15) return(16);
    if ((170 & 85) != 0) return(17);   /* 10101010 & 01010101 */
    if ((255 & 0) != 0) return(18);

    /* Test 19-21: Bitwise OR */
    if ((240 | 15) != 255) return(19);
    if ((170 | 85) != 255) return(20);
    if ((0 | 0) != 0) return(21);

    /* Test 22-24: Left Shift */
    if ((1 << 0) != 1) return(22);
    if ((1 << 4) != 16) return(23);
    if ((3 << 2) != 12) return(24);

    /* Test 25-27: Right Shift (logical in B with safe macros) */
    if ((16 >> 2) != 4) return(25);
    if ((255 >> 4) != 15) return(26);
    if ((1 >> 1) != 0) return(27);

    /* ============ Comparison Operators ============ */

    /* Test 28-30: Less Than */
    if ((3 < 5) != 1) return(28);
    if ((5 < 3) != 0) return(29);
    if ((3 < 3) != 0) return(30);

    /* Test 31-33: Less Than or Equal */
    if ((3 <= 5) != 1) return(31);
    if ((5 <= 3) != 0) return(32);
    if ((3 <= 3) != 1) return(33);

    /* Test 34-36: Greater Than */
    if ((5 > 3) != 1) return(34);
    if ((3 > 5) != 0) return(35);
    if ((3 > 3) != 0) return(36);

    /* Test 37-39: Greater Than or Equal */
    if ((5 >= 3) != 1) return(37);
    if ((3 >= 5) != 0) return(38);
    if ((3 >= 3) != 1) return(39);

    /* Test 40-42: Equal */
    if ((3 == 3) != 1) return(40);
    if ((3 == 4) != 0) return(41);
    if ((0 == 0) != 1) return(42);

    /* Test 43-45: Not Equal */
    if ((3 != 4) != 1) return(43);
    if ((3 != 3) != 0) return(44);
    if ((0 != 1) != 1) return(45);

    /* ============ Unary Operators ============ */

    /* Test 46-48: Unary Minus */
    x = 5;
    if (-x != -5) return(46);
    if (-(-x) != 5) return(47);
    if (-0 != 0) return(48);

    /* Test 49-51: Logical NOT */
    if (!0 != 1) return(49);
    if (!1 != 0) return(50);
    if (!42 != 0) return(51);

    /* Test 52-54: Pre-increment */
    x = 5;
    if (++x != 6) return(52);
    if (x != 6) return(53);
    x = -1;
    if (++x != 0) return(54);

    /* Test 55-57: Post-increment */
    x = 5;
    if (x++ != 5) return(55);
    if (x != 6) return(56);
    x = -1;
    if (x++ != -1) return(57);

    /* Test 58-60: Pre-decrement */
    x = 5;
    if (--x != 4) return(58);
    if (x != 4) return(59);
    x = 0;
    if (--x != -1) return(60);

    /* Test 61-63: Post-decrement */
    x = 5;
    if (x-- != 5) return(61);
    if (x != 4) return(62);
    x = 0;
    if (x-- != 0) return(63);

    /* ============ Address/Dereference ============ */

    /* Test 64-66: Address-of and Dereference */
    x = 42;
    a = &x;
    if (*a != 42) return(64);
    *a = 99;
    if (x != 99) return(65);
    b = &a;
    if (**b != 99) return(66);

    /* ============ Ternary Operator ============ */

    /* Test 67-69: Ternary */
    if ((1 ? 10 : 20) != 10) return(67);
    if ((0 ? 10 : 20) != 20) return(68);
    x = 5;
    if ((x > 3 ? x * 2 : x / 2) != 10) return(69);

    /* ============ Logical OR (||) ============ */

    /* Test 70-72: Logical OR */
    if ((0 || 0) != 0) return(70);
    if ((1 || 0) != 1) return(71);
    if ((0 || 1) != 1) return(72);

    /* ============ Edge Cases ============ */

    /* Test 73: Division by large number */
    if (1000000 / 1000 != 1000) return(73);

    /* Test 74: Multiplication overflow check (host mode) */
    /* In host mode, no overflow; just verify it doesn't crash */
    x = 10000 * 10000;  /* 100,000,000 */
    if (x != 100000000) return(74);

    /* Test 75: Chained comparisons (B evaluates left-to-right) */
    /* 1 < 2 = 1, 1 < 3 = 1 */
    x = 1 < 2 < 3;
    if (x != 1) return(75);

    return(0);
}

