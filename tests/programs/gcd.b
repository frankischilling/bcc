/* GCD using Euclidean algorithm */

gcd(a, b) {
    while (b != 0) {
        auto t;
        t = b;
        b = a % b;
        a = t;
    }
    return(a);
}

main() {
    auto result;
    result = 0;

    /* gcd(48, 18) = 6 */
    if (gcd(48, 18) == 6) result = result + 1;

    /* gcd(54, 24) = 6 */
    if (gcd(54, 24) == 6) result = result + 1;

    /* gcd(17, 13) = 1 (coprime) */
    if (gcd(17, 13) == 1) result = result + 1;

    /* gcd(100, 25) = 25 */
    if (gcd(100, 25) == 25) result = result + 1;

    return(result);
}
