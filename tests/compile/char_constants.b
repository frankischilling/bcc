/* Character constant tests */
main() {
    auto c;
    c = 'a';
    c = 'A';
    c = '0';
    c = ' ';
    c = '*n';  /* newline */
    c = '*t';  /* tab */
    c = '**';  /* star */
    c = 'ab';  /* multi-char */
    return(c);
}
