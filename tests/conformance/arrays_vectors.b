/* Array/vector conformance test
 * Tests B's array (vector) semantics
 * Arrays are word-indexed, elements are words
 */

/* Global array */
global_arr[10];

/* Initialize global array */
init_global() {
    auto i;
    i = 0;
    while (i < 10) {
        global_arr[i] = i * 10;
        i =+ 1;
    }
}

/* Sum array elements */
sum_array(arr, n) {
    auto i, sum;
    sum = 0;
    i = 0;
    while (i < n) {
        sum =+ arr[i];
        i =+ 1;
    }
    return(sum);
}

/* Reverse array in place */
reverse(arr, n) {
    auto i, j, temp;
    i = 0;
    j = n - 1;
    while (i < j) {
        temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
        i =+ 1;
        j =- 1;
    }
}

/* Find max element */
find_max(arr, n) {
    auto i, max;
    max = arr[0];
    i = 1;
    while (i < n) {
        if (arr[i] > max)
            max = arr[i];
        i =+ 1;
    }
    return(max);
}

main() {
    auto local_arr[20];
    auto i, x;

    /* Test 1: Basic array write/read */
    local_arr[0] = 42;
    if (local_arr[0] != 42) return(1);

    /* Test 2: Sequential access */
    i = 0;
    while (i < 10) {
        local_arr[i] = i * i;
        i =+ 1;
    }
    if (local_arr[0] != 0) return(2);
    if (local_arr[3] != 9) return(3);
    if (local_arr[9] != 81) return(4);

    /* Test 5: Array sum */
    /* 0 + 1 + 4 + 9 + 16 + 25 + 36 + 49 + 64 + 81 = 285 */
    if (sum_array(local_arr, 10) != 285) return(5);

    /* Test 6: Global array */
    init_global();
    if (global_arr[0] != 0) return(6);
    if (global_arr[5] != 50) return(7);
    if (global_arr[9] != 90) return(8);

    /* Test 9: Global array sum = 0+10+20+...+90 = 450 */
    if (sum_array(global_arr, 10) != 450) return(9);

    /* Test 10: Array reversal */
    local_arr[0] = 1;
    local_arr[1] = 2;
    local_arr[2] = 3;
    local_arr[3] = 4;
    local_arr[4] = 5;
    reverse(local_arr, 5);
    if (local_arr[0] != 5) return(10);
    if (local_arr[1] != 4) return(11);
    if (local_arr[2] != 3) return(12);
    if (local_arr[4] != 1) return(13);

    /* Test 14: Find max */
    local_arr[0] = 10;
    local_arr[1] = 50;
    local_arr[2] = 30;
    local_arr[3] = 90;
    local_arr[4] = 20;
    if (find_max(local_arr, 5) != 90) return(14);

    /* Test 15: Negative indices (if supported) */
    /* Actually B doesn't check bounds, so arr[-1] is UB but should compile */

    /* Test 16: Array element as function arg */
    local_arr[0] = 7;
    local_arr[1] = 8;
    x = local_arr[0] * local_arr[1];
    if (x != 56) return(16);

    /* Test 17: Array with computed index */
    i = 3;
    local_arr[i] = 100;
    local_arr[i + 1] = 200;
    if (local_arr[3] != 100) return(17);
    if (local_arr[4] != 200) return(18);

    /* Test 19: Array address arithmetic */
    /* In B, array name IS the address of first element */
    local_arr[0] = 111;
    local_arr[1] = 222;
    local_arr[2] = 333;
    x = local_arr;  /* array name is already pointer */
    if (*x != 111) return(19);
    if (x[1] != 222) return(20);
    if (x[2] != 333) return(21);

    /* Test 22: Modify through pointer */
    x[0] = 999;
    if (local_arr[0] != 999) return(22);

    return(0);
}

