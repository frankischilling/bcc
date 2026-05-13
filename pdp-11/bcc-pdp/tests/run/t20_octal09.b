/* t20 -- kbman permits 8 and 9 in octal constants: 09 == 011 == decimal 9. */
main() {
	extrn printn, putchar;
	printn(09, 10);
	putchar('*n');
}
