/* Pointer conformance test
 * Tests B's pointer/address semantics
 * All values are words, pointers are just word values
 */

/* Swap two values via pointers */
swap(p, q) {
    auto temp;
    temp = *p;
    *p = *q;
    *q = temp;
}

/* Increment value through pointer */
inc_ptr(p) {
    *p =+ 1;
    return(*p);
}

/* Sum array using indexing (pointer arithmetic is byte-based) */
sum_arr(arr, n) {
    auto sum, i;
    sum = 0;
    i = 0;
    while (i < n) {
        sum =+ arr[i];
        i =+ 1;
    }
    return(sum);
}

/* Fill array using indexing */
fill_arr(arr, n, val) {
    auto i;
    i = 0;
    while (i < n) {
        arr[i] = val;
        i =+ 1;
    }
}

main() {
    auto x, y, z;
    auto arr[10];
    auto p, q;

    /* Test 1-2: Basic address-of and dereference */
    x = 42;
    p = &x;
    if (*p != 42) return(1);
    *p = 99;
    if (x != 99) return(2);

    /* Test 3-4: Swap using pointers */
    x = 10;
    y = 20;
    swap(&x, &y);
    if (x != 20) return(3);
    if (y != 10) return(4);

    /* Test 5: Increment through pointer */
    x = 5;
    inc_ptr(&x);
    if (x != 6) return(5);

    /* Test 6: Return value of inc_ptr */
    x = 10;
    if (inc_ptr(&x) != 11) return(6);

    /* Test 7: Pointer comparison */
    x = 1;
    y = 2;
    p = &x;
    q = &y;
    if (p == q) return(7);  /* Different addresses */

    /* Test 8: Same pointer */
    q = p;
    if (p != q) return(8);

    /* Test 9-10: Array via pointer */
    arr[0] = 100;
    arr[1] = 200;
    arr[2] = 300;
    p = arr;
    if (*p != 100) return(9);
    if (p[1] != 200) return(10);
    if (p[2] != 300) return(11);

    /* Test 12: Pointer via indexing (more reliable than arithmetic) */
    p = arr;
    if (p[2] != 300) return(12);

    /* Test 13: Address comparison */
    p = &arr[0];
    q = &arr[1];
    if (p >= q) return(13);  /* arr[0] address should be less than arr[1] */

    /* Test 14: Sum array */
    arr[0] = 1;
    arr[1] = 2;
    arr[2] = 3;
    arr[3] = 4;
    arr[4] = 5;
    if (sum_arr(arr, 5) != 15) return(14);

    /* Test 15: Fill array */
    fill_arr(arr, 5, 42);
    if (arr[0] != 42) return(15);
    if (arr[4] != 42) return(16);

    /* Test 17: Array element access */
    arr[0] = 10;
    arr[1] = 20;
    arr[2] = 30;
    p = arr;
    x = p[0];
    if (x != 10) return(17);
    x = p[1];
    if (x != 20) return(18);

    /* Test 19: Array element modification */
    p[2] = 99;
    if (arr[2] != 99) return(19);

    /* Test 20: Index into pointer */
    if (p[0] != 10) return(20);
    if (p[1] != 20) return(21);

    /* Test 22: NULL-like pointer (0) */
    p = 0;
    /* Can't dereference, but can compare */
    if (p != 0) return(22);

    return(0);
}

