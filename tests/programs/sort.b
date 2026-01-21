/* Bubble sort test */
arr[] { 5, 2, 8, 1, 9, 3, 7, 4, 6, 0 };

sort(a, n) {
    auto i, j, t;
    i = 0;
    while (i < n - 1) {
        j = 0;
        while (j < n - i - 1) {
            if (a[j] > a[j + 1]) {
                t = a[j];
                a[j] = a[j + 1];
                a[j + 1] = t;
            }
            j = j + 1;
        }
        i = i + 1;
    }
}

printnum(n) {
    if (n >= 10)
        printnum(n / 10);
    putchar('0' + n % 10);
}

main() {
    auto i;
    sort(arr, 10);

    i = 0;
    while (i < 10) {
        printnum(arr[i]);
        putchar(' ');
        i = i + 1;
    }
    putchar('*n');

    /* Return sum of first 3 elements to verify sort */
    return(arr[0] + arr[1] + arr[2]);
}
