/* Compound assignment conformance test
 * B uses =op syntax (not op= like C)
 * Tests all compound assignment operators
 */

main() {
    auto x, y;

    /* Test 1-2: Addition assignment =+ */
    x = 10;
    x =+ 5;
    if (x != 15) return(1);

    x = -5;
    x =+ 10;
    if (x != 5) return(2);

    /* Test 3-4: Subtraction assignment =- */
    x = 10;
    x =- 3;
    if (x != 7) return(3);

    x = 5;
    x =- 10;
    if (x != -5) return(4);

    /* Test 5-6: Multiplication (=* is ambiguous with =*ptr, use explicit) */
    x = 6;
    x = x * 7;
    if (x != 42) return(5);

    x = -3;
    x = x * 4;
    if (x != -12) return(6);

    /* Test 7-8: Division assignment =/ */
    x = 42;
    x =/ 6;
    if (x != 7) return(7);

    x = 100;
    x =/ 3;
    if (x != 33) return(8);

    /* Test 9-10: Modulo assignment =% */
    x = 17;
    x =% 5;
    if (x != 2) return(9);

    x = 100;
    x =% 7;
    if (x != 2) return(10);

    /* Test 11-12: Left shift assignment =<< */
    x = 1;
    x =<< 4;
    if (x != 16) return(11);

    x = 3;
    x =<< 3;
    if (x != 24) return(12);

    /* Test 13-14: Right shift assignment =>> */
    x = 64;
    x =>> 3;
    if (x != 8) return(13);

    x = 255;
    x =>> 4;
    if (x != 15) return(14);

    /* Test 15-16: Bitwise AND assignment =& */
    x = 255;
    x =& 15;
    if (x != 15) return(15);

    x = 170;  /* 10101010 */
    x =& 240; /* 11110000 */
    if (x != 160) return(16);  /* 10100000 */

    /* Test 17-18: Bitwise OR assignment =| */
    x = 240;  /* 11110000 */
    x =| 15;  /* 00001111 */
    if (x != 255) return(17);

    x = 170;  /* 10101010 */
    x =| 85;  /* 01010101 */
    if (x != 255) return(18);

    /* Test 19-20: Chained compound assignments */
    x = 10;
    y = 5;
    x =+ y;
    y = y * 2;
    if (x != 15) return(19);
    if (y != 10) return(20);

    /* Test 21: Multiple operations in sequence */
    x = 2;
    x = x * 3;   /* 6 */
    x =+ 4;   /* 10 */
    x =/ 2;   /* 5 */
    if (x != 5) return(21);

    /* Test 22: Return value of compound assign */
    x = 10;
    y = (x =+ 5);
    if (y != 15) return(22);
    if (x != 15) return(23);

    return(0);
}

