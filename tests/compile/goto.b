/* Goto and labels */
main() {
    auto i;
    i = 0;

loop:
    i = i + 1;
    if (i < 10)
        goto loop;

    goto end;
    i = 999;  /* Should be skipped */

end:
    return(i);
}
