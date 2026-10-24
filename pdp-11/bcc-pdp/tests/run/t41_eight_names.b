/* Preserve eight-character names and case distinctions through V1 as. */
abcdefg 11;
_abcdefg 22;
ptrs[2] abcdefg, _abcdefg;
Case 41;
caseval 42;

putcha() { return(43); }
CASE() { return(44); }
abcdefg1() { return(31); }
abcdefg2() { return(32); }
_call123() { return(33); }

main() {
    extrn abcdefg, _abcdefg, ptrs, abcdefg1, abcdefg2, _call123;
    extrn putchar, Case, caseval, putcha, CASE;
    if (abcdefg != 11 | _abcdefg != 22) return(1);
    if (*ptrs[0] != 11 | *ptrs[1] != 22) return(2);
    if (abcdefg1() != 31 | abcdefg2() != 32 | _call123() != 33) return(3);
    if (Case != 41 | caseval != 42 | putcha() != 43 | CASE() != 44) return(4);
    putchar('O'); putchar('K'); putchar('*n');
    return(0);
}
