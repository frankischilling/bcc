arr[] { 1, 2, 3, 4, 5 };

main() {
    auto i, sum;
    sum = 0;
    i = 0;
    while (i < 5) {
        sum = sum + arr[i];
        i = i + 1;
    }
    return(sum);
}
