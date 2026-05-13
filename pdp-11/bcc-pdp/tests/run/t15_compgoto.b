/* t15 -- computed goto: label-as-rvalue (kbman §5.5).
 * Loops via backward goto-through-variable.  Label must be defined before
 * referenced as rvalue (single-pass compiler limitation, documented).
 * Output: XX\n
 */
main() {
	extrn putchar;
	auto p, first;
	first = 1;
loop:
	putchar('X');
	p = loop;             /* loop is backward - already defined */
	if (first == 0) {
		putchar('*n');
		return;
	}
	first = 0;
	goto p;               /* computed goto via auto holding label addr */
}
