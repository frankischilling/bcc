/* Complex expression conformance test
 * Tests B's expression evaluation, precedence, and associativity
 */

main() {
    auto a, b, c, x, y, z;
    auto arr[5];

    /* Test 1-3: Basic precedence (* before +) */
    if (2 + 3 * 4 != 14) return(1);
    if (3 * 4 + 2 != 14) return(2);
    if (10 - 2 * 3 != 4) return(3);

    /* Test 4-5: Parentheses override precedence */
    if ((2 + 3) * 4 != 20) return(4);
    if (2 * (3 + 4) != 14) return(5);

    /* Test 6-7: Division and modulo precedence */
    if (10 / 2 + 3 != 8) return(6);
    if (10 % 3 + 2 != 3) return(7);

    /* Test 8-9: Shift precedence (same as + in B, left-to-right) */
    if (1 << 2 + 1 != 5) return(8);    /* (1 << 2) + 1 = 5 */
    if (1 << (2 + 1) != 8) return(9);  /* 1 << 3 = 8 */

    /* Test 10-11: Bitwise AND/OR precedence */
    if ((6 & 3 | 8) != 10) return(10);  /* (6&3)=2, 2|8=10 */
    if ((6 | 3 & 1) != 7) return(11);   /* (3&1)=1, 6|1=7 */

    /* Test 12-13: Comparison operators */
    if ((3 < 5) != 1) return(12);
    if ((5 < 3) != 0) return(13);

    /* Test 14-15: Equality operators */
    if ((3 == 3) != 1) return(14);
    if ((3 == 4) != 0) return(15);
    if ((3 != 4) != 1) return(16);

    /* Test 17-18: Logical NOT */
    if (!0 != 1) return(17);
    if (!1 != 0) return(18);
    if (!42 != 0) return(19);

    /* Test 20: Ternary operator */
    x = (5 > 3) ? 10 : 20;
    if (x != 10) return(20);
    x = (3 > 5) ? 10 : 20;
    if (x != 20) return(21);

    /* Test 22: Nested ternary */
    a = 1;
    x = a == 1 ? 10 : a == 2 ? 20 : 30;
    if (x != 10) return(22);
    a = 2;
    x = a == 1 ? 10 : a == 2 ? 20 : 30;
    if (x != 20) return(23);
    a = 3;
    x = a == 1 ? 10 : a == 2 ? 20 : 30;
    if (x != 30) return(24);

    /* Test 25: Assignment is right-associative */
    a = b = c = 5;
    if (a != 5) return(25);
    if (b != 5) return(26);
    if (c != 5) return(27);

    /* Test 28: Assignment returns value */
    x = (a = 10) + 5;
    if (x != 15) return(28);
    if (a != 10) return(29);

    /* Test 30: Unary minus */
    x = -5;
    if (x != -5) return(30);
    if (-(-5) != 5) return(31);

    /* Test 32: Complex arithmetic chain */
    x = 2 * 3 + 4 * 5 - 6 / 2;
    /* = 6 + 20 - 3 = 23 */
    if (x != 23) return(32);

    /* Test 33: Nested parentheses */
    x = ((2 + 3) * (4 - 1)) / 3;
    /* = (5 * 3) / 3 = 5 */
    if (x != 5) return(33);

    /* Test 34: Array in expression */
    arr[0] = 10;
    arr[1] = 20;
    arr[2] = 30;
    x = arr[0] + arr[1] * arr[2];
    /* = 10 + 600 = 610 */
    if (x != 610) return(34);

    /* Test 35: Pre-increment in expression */
    x = 5;
    y = ++x * 2;
    if (y != 12) return(35);
    if (x != 6) return(36);

    /* Test 37: Post-increment in expression */
    x = 5;
    y = x++ * 2;
    if (y != 10) return(37);
    if (x != 6) return(38);

    /* Test 39: Simple increment use */
    x = 5;
    y = ++x;
    if (y != 6) return(39);

    /* Test 40: Comma operator */
    x = (1, 2, 3);
    if (x != 3) return(40);

    /* Test 41: Complex expression as array index */
    arr[0] = 100;
    arr[1] = 200;
    arr[2] = 300;
    x = arr[1 + 1];
    if (x != 300) return(41);

    /* Test 42: Function call in expression */
    /* We'll test this with a simple function */

    return(0);
}

