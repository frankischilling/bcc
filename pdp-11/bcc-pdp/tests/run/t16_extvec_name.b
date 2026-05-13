/* t16 -- external vector with name initializers (kbman §7.2).
 * Each entry is a pointer to another external (a packed string here).
 * Iterate strs[0..2] and print each pointed-to string.
 * Output: foo\nbar\nbaz\n
 */
foo 'f','o','o','*n','*e';
bar 'b','a','r','*n','*e';
baz 'b','a','z','*n','*e';

strs[3] foo, bar, baz;

prnt(p) {
	extrn putchar, char;
	auto i, c;
	i = 0;
	while (1) {
		c = char(p, i);
		if (c == 4) return;       /* *e EOT */
		putchar(c);
		i = i + 1;
	}
}

main() {
	extrn strs, prnt;
	auto i;
	i = 0;
	while (i < 3) {
		prnt(strs[i]);
		i = i + 1;
	}
}
