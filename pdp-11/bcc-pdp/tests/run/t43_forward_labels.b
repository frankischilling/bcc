/* Forward label values belong to the current function. */
first(n) {
    auto dest, choices 2;
    choices[0] = bad;
    choices[1] = done;
    dest = choices[n];
    goto(dest);
    bad: return(1);
    done: return(0);
}
second(n) {
    auto dest;
    dest = n ? done : bad;
    goto dest;
    bad: return(1);
    done: return(0);
}
main() {
    extrn first, second, putchar;
    if (first(1) | second(1)) return(1);
    putchar('O'); putchar('K'); putchar('*n');
    return(0);
}
