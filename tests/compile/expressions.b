/* Expression tests */
main() {
    auto a, b, c;

    /* Arithmetic */
    a = 1 + 2;
    a = 3 - 1;
    a = 4 * 5;
    a = 10 / 2;
    a = 7 % 3;

    /* Comparison */
    b = a < 10;
    b = a > 5;
    b = a <= 10;
    b = a >= 5;
    b = a == 5;
    b = a != 5;

    /* Logical */
    c = a & b;
    c = a | b;
    c = !a;

    /* Shift */
    c = a << 2;
    c = a >> 1;

    /* Unary */
    c = -a;
    c = *(&a);

    /* Ternary */
    c = a ? b : 0;

    /* Compound assignment */
    a =+ 1;
    a =- 1;
    a =* 2;
    a =/ 2;
    a =% 3;

    /* Increment/decrement */
    ++a;
    --a;
    a++;
    a--;

    return(0);
}
