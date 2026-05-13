/* cmp.b - byte-compare two files named on argv.  Exit 0 if same, 1 if differ. */
buf1[64];
buf2[64];

main() {
	extrn argv, open, read, close, write, exit, char, buf1, buf2;
	auto fd1, fd2, n1, n2, i;

	if (argv[0] < 2) {
		write(2, "usage: cmp f1 f2*n", 18);
		exit(1);
	}
	fd1 = open(argv[1], 0);
	fd2 = open(argv[2], 0);
	if (fd1 < 0) { write(2, "cmp: open f1*n", 14); exit(1); }
	if (fd2 < 0) { write(2, "cmp: open f2*n", 14); exit(1); }

	while (1) {
		n1 = read(fd1, buf1, 128);
		n2 = read(fd2, buf2, 128);
		if (n1 != n2) goto diff;
		if (n1 <= 0) goto same;
		i = 0;
		while (i < n1) {
			if (char(buf1, i) != char(buf2, i)) goto diff;
			i = i + 1;
		}
	}
diff:
	close(fd1); close(fd2);
	write(1, "differ*n", 8);
	exit(1);
same:
	close(fd1); close(fd2);
	write(1, "same*n", 6);
	exit(0);
}
