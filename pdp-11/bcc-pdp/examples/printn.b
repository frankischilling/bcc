/* printn.b - kbman §9.1 verbatim demo.  Print 12345 in base 10 and 8.
 * Output:  12345*n30071*n
 */
main() {
	extrn putchar, printn;
	printn(12345, 10);
	putchar('*n');
	printn(12345, 8);
	putchar('*n');
}
