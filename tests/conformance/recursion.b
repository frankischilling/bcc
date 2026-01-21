/* Recursion conformance test
 * Tests various recursive patterns common in B programs
 */

/* Classic factorial */
fact(n) {
    if (n <= 1)
        return(1);
    return(n * fact(n - 1));
}

/* Fibonacci */
fib(n) {
    if (n <= 1)
        return(n);
    return(fib(n - 1) + fib(n - 2));
}

/* GCD (Euclidean algorithm) */
gcd(a, b) {
    if (b == 0)
        return(a);
    return(gcd(b, a % b));
}

/* Ackermann function (limited) */
ack(m, n) {
    if (m == 0)
        return(n + 1);
    if (n == 0)
        return(ack(m - 1, 1));
    return(ack(m - 1, ack(m, n - 1)));
}

/* Sum of digits */
sum_digits(n) {
    if (n == 0)
        return(0);
    return(n % 10 + sum_digits(n / 10));
}

/* Reverse number */
reverse_helper(n, acc) {
    if (n == 0)
        return(acc);
    return(reverse_helper(n / 10, acc * 10 + n % 10));
}

reverse_num(n) {
    return(reverse_helper(n, 0));
}

/* Power function */
power(base, exp) {
    if (exp == 0)
        return(1);
    if (exp % 2 == 0)
        return(power(base * base, exp / 2));
    return(base * power(base, exp - 1));
}

/* Count ways to climb stairs (1 or 2 steps) */
climb_stairs(n) {
    if (n <= 2)
        return(n);
    return(climb_stairs(n - 1) + climb_stairs(n - 2));
}

/* Binary search (recursive) */
b_bsearch(arr, lo, hi, target) {
    auto mid;
    if (lo > hi)
        return(-1);
    mid = (lo + hi) / 2;
    if (arr[mid] == target)
        return(mid);
    if (arr[mid] > target)
        return(b_bsearch(arr, lo, mid - 1, target));
    return(b_bsearch(arr, mid + 1, hi, target));
}

/* Quicksort partition (for array passed by pointer) */
partition(arr, lo, hi) {
    auto pivot, i, j, temp;
    pivot = arr[hi];
    i = lo - 1;
    j = lo;
    while (j < hi) {
        if (arr[j] < pivot) {
            i =+ 1;
            temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
        }
        j =+ 1;
    }
    temp = arr[i + 1];
    arr[i + 1] = arr[hi];
    arr[hi] = temp;
    return(i + 1);
}

quicksort(arr, lo, hi) {
    auto p;
    if (lo < hi) {
        p = partition(arr, lo, hi);
        quicksort(arr, lo, p - 1);
        quicksort(arr, p + 1, hi);
    }
}

main() {
    auto arr[10];
    auto i;

    /* Test 1-3: Factorial */
    if (fact(0) != 1) return(1);
    if (fact(1) != 1) return(2);
    if (fact(5) != 120) return(3);
    if (fact(7) != 5040) return(4);

    /* Test 5-7: Fibonacci */
    if (fib(0) != 0) return(5);
    if (fib(1) != 1) return(6);
    if (fib(10) != 55) return(7);

    /* Test 8-10: GCD */
    if (gcd(48, 18) != 6) return(8);
    if (gcd(17, 13) != 1) return(9);
    if (gcd(100, 25) != 25) return(10);

    /* Test 11-13: Ackermann (small values only) */
    if (ack(0, 0) != 1) return(11);
    if (ack(1, 1) != 3) return(12);
    if (ack(2, 2) != 7) return(13);

    /* Test 14-15: Sum of digits */
    if (sum_digits(123) != 6) return(14);
    if (sum_digits(9999) != 36) return(15);

    /* Test 16-17: Reverse number */
    if (reverse_num(123) != 321) return(16);
    if (reverse_num(1000) != 1) return(17);

    /* Test 18-19: Power */
    if (power(2, 10) != 1024) return(18);
    if (power(3, 4) != 81) return(19);

    /* Test 20: Climb stairs */
    if (climb_stairs(5) != 8) return(20);

    /* Test 21-23: Binary search */
    arr[0] = 10;
    arr[1] = 20;
    arr[2] = 30;
    arr[3] = 40;
    arr[4] = 50;
    if (b_bsearch(arr, 0, 4, 30) != 2) return(21);
    if (b_bsearch(arr, 0, 4, 10) != 0) return(22);
    if (b_bsearch(arr, 0, 4, 35) != -1) return(23);

    /* Test 24-25: Quicksort */
    arr[0] = 5;
    arr[1] = 2;
    arr[2] = 8;
    arr[3] = 1;
    arr[4] = 9;
    arr[5] = 3;
    arr[6] = 7;
    arr[7] = 4;
    arr[8] = 6;
    arr[9] = 0;
    quicksort(arr, 0, 9);
    
    /* Verify sorted */
    i = 0;
    while (i < 10) {
        if (arr[i] != i) return(24);
        i =+ 1;
    }

    return(0);
}

