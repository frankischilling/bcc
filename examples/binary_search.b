/* Binary search over a sorted global vector. */

values[] { 3, 5, 8, 13, 21, 34, 55, 89 };

find(a, n, key) {
    auto lo, hi, mid;

    lo = 0;
    hi = n - 1;

    while (lo <= hi) {
        mid = (lo + hi) / 2;
        if (a[mid] == key)
            return(mid);
        if (a[mid] < key)
            lo = mid + 1;
        else
            hi = mid - 1;
    }

    return(-1);
}

main() {
    extrn printf;

    auto key, pos;
    key = 34;
    pos = find(values, 8, key);

    if (pos >= 0)
        printf("%d found at index %d*n", key, pos);
    else
        printf("%d not found*n", key);

    return(0);
}
