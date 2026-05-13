/* copy.b - copy argv[1] to argv[2] using V1 read/write/creat/open. */
buf[64];

main() {
	extrn argv, open, creat, read, write, close, putstr;
	auto in, out, n;
	if (argv[0] < 2) {
		putstr("usage: copy from to*n");
		return;
	}
	in = open(argv[1], 0);
	if (in < 0) {
		putstr("copy: open*n");
		return;
	}
	out = creat(argv[2], 016);
	if (out < 0) {
		putstr("copy: creat*n");
		close(in);
		return;
	}
	while (1) {
		n = read(in, buf, 128);
		if (n <= 0) goto done;
		write(out, buf, n);
	}
done:
	close(in);
	close(out);
}
