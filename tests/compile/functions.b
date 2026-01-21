/* Function tests */
add(a, b) {
    return(a + b);
}

mul(x, y)
    return(x * y);

factorial(n) {
    if (n <= 1)
        return(1);
    return(n * factorial(n - 1));
}

noargs() {
    return(42);
}

manyargs(a, b, c, d, e) {
    return(a + b + c + d + e);
}

main() {
    auto x;
    x = add(1, 2);
    x = mul(3, 4);
    x = factorial(5);
    x = noargs();
    x = manyargs(1, 2, 3, 4, 5);
    return(x);
}
