/* Nested control flow conformance test
 * Tests complex nesting of if/else/while/switch/goto
 */

/* Deeply nested if/else */
nested_if(a, b, c) {
    if (a > 0) {
        if (b > 0) {
            if (c > 0) {
                return(1);  /* all positive */
            } else {
                return(2);  /* a,b positive, c not */
            }
        } else {
            if (c > 0) {
                return(3);  /* a,c positive, b not */
            } else {
                return(4);  /* only a positive */
            }
        }
    } else {
        if (b > 0) {
            if (c > 0) {
                return(5);  /* b,c positive, a not */
            } else {
                return(6);  /* only b positive */
            }
        } else {
            if (c > 0) {
                return(7);  /* only c positive */
            } else {
                return(8);  /* none positive */
            }
        }
    }
}

/* Nested while loops */
sum_matrix() {
    auto i, j, sum;
    sum = 0;
    i = 0;
    while (i < 3) {
        j = 0;
        while (j < 4) {
            sum =+ i * 4 + j;  /* Sum of 0..11 */
            j =+ 1;
        }
        i =+ 1;
    }
    return(sum);  /* 0+1+2+...+11 = 66 */
}

/* While with break */
first_div_by_7(n) {
    auto i;
    i = 1;
    while (i <= n) {
        if (i % 7 == 0)
            return(i);
        i =+ 1;
    }
    return(-1);
}

/* While with continue-like behavior using goto */
count_odd(n) {
    auto i, count;
    count = 0;
    i = 0;
    while (i < n) {
        i =+ 1;
        if (i % 2 == 0)
            goto next;
        count =+ 1;
    next:
        ;  /* empty statement for label */
    }
    return(count);
}

/* Switch inside while */
state_machine(input, len) {
    auto state, i, c, count;
    state = 0;
    count = 0;
    i = 0;
    while (i < len) {
        c = char(input, i);
        switch (state) {
        case 0:
            if (c == 'a')
                state = 1;
        case 1:
            if (c == 'b') {
                state = 2;
                count =+ 1;
            } else if (c != 'a') {
                state = 0;
            }
        case 2:
            if (c == 'a')
                state = 1;
            else
                state = 0;
        }
        i =+ 1;
    }
    return(count);
}

/* Mutual recursion - define is_odd first since is_even calls it */
is_odd(n) {
    if (n == 0)
        return(0);
    return(is_even(n - 1));
}

is_even(n) {
    if (n == 0)
        return(1);
    return(is_odd(n - 1));
}

/* Deeply nested function calls */
add(a, b) { return(a + b); }
mul(a, b) { return(a * b); }

complex_calc(x) {
    return(add(mul(x, x), add(mul(x, 2), 1)));
    /* x^2 + 2x + 1 = (x+1)^2 */
}

main() {
    auto buf[10];

    /* Test 1-8: Nested if/else coverage */
    if (nested_if(1, 1, 1) != 1) return(1);
    if (nested_if(1, 1, 0) != 2) return(2);
    if (nested_if(1, 0, 1) != 3) return(3);
    if (nested_if(1, 0, 0) != 4) return(4);
    if (nested_if(0, 1, 1) != 5) return(5);
    if (nested_if(0, 1, 0) != 6) return(6);
    if (nested_if(0, 0, 1) != 7) return(7);
    if (nested_if(0, 0, 0) != 8) return(8);

    /* Test 9: Nested while loops */
    if (sum_matrix() != 66) return(9);

    /* Test 10-11: While with early return */
    if (first_div_by_7(20) != 7) return(10);
    if (first_div_by_7(6) != -1) return(11);

    /* Test 12: Goto-based continue */
    if (count_odd(10) != 5) return(12);

    /* Test 13-14: Mutual recursion */
    if (is_even(10) != 1) return(13);
    if (is_odd(10) != 0) return(14);
    if (is_even(7) != 0) return(15);
    if (is_odd(7) != 1) return(16);

    /* Test 17-19: Nested function calls */
    if (complex_calc(0) != 1) return(17);   /* 0+0+1 = 1 */
    if (complex_calc(1) != 4) return(18);   /* 1+2+1 = 4 */
    if (complex_calc(3) != 16) return(19);  /* 9+6+1 = 16 */

    /* Test 20: Complex while condition */
    auto i, sum;
    i = 0;
    sum = 0;
    while (i < 10 & sum < 20) {
        sum =+ i;
        i =+ 1;
    }
    /* i=0: sum=0, i=1: sum=1, i=2: sum=3, i=3: sum=6, i=4: sum=10, i=5: sum=15, i=6: sum=21 > 20 */
    if (sum != 21) return(20);

    /* Test 21: If-else chain */
    i = 5;
    if (i == 1)
        sum = 10;
    else if (i == 2)
        sum = 20;
    else if (i == 3)
        sum = 30;
    else if (i == 4)
        sum = 40;
    else if (i == 5)
        sum = 50;
    else
        sum = 99;
    if (sum != 50) return(21);

    /* Test 22: Empty while body */
    i = 0;
    while (++i < 5)
        ;
    if (i != 5) return(22);

    /* Test 23: While with complex update */
    i = 100;
    while ((i = i / 2) > 5)
        ;
    if (i != 3) return(23);  /* 100->50->25->12->6->3 */

    return(0);
}

