/* blit.c -- streaming literal emitter for b1.
 *
 * No interning. Each `Slit <len> <bytes>` IC record produces a fresh
 * S<k>: .byte block immediately, with a branch-around so function
 * control flow cannot fall into literal bytes.
 */

nstr 0;

litinl(len, bytes) char bytes[]; {
	extern nstr;
	int nstr;
	int id, j, b;
	id = nstr;
	if (id >= 256) fatal("string pool full");
	nstr = nstr + 1;
	outs("\n.text\n");
	outs("\tbr\tLS");
	outd(id);
	outc('\n');
	outs("S");
	outd(id);
	outs(":\n\t.byte\t");
	j = 0;
	while (j < len) {
		if (j) outc(',');
		b = bytes[j] & 0377;
		outd(b);
		outc('.');
		j = j + 1;
	}
	outc('\n');
	outs("\t.even\n");
	outs("LS");
	outd(id);
	outs(":\n");
	return (id);
}

emitl() { }
