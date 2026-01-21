main() {
    auto result;
    result = 0;

    if (5 < 10) result = result + 1;
    if (10 > 5) result = result + 1;
    if (5 <= 5) result = result + 1;
    if (5 >= 5) result = result + 1;
    if (5 == 5) result = result + 1;
    if (5 != 6) result = result + 1;

    /* All 6 should pass */
    return(result);
}
