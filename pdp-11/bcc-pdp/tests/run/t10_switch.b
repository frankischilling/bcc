/* t10 -- switch with fall-through (no break in 1972 B).
 * For input 1: prints "ABC", input 2: "BC", input 3: "C".
 * Output for testfn(1), testfn(2), testfn(3) == "ABCBCC\n".
 */
testfn(n) {
	extrn putchar;
	switch n {
	case 1:
		putchar('A');
	case 2:
		putchar('B');
	case 3:
		putchar('C');
	}
}

main() {
	extrn testfn, putchar;
	testfn(1);
	testfn(2);
	testfn(3);
	putchar('*n');
}
