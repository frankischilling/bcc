/* bdrv.c -- /bin/b: compiler driver inside V1 Unix.
 *
 * Usage:  b [-x] src.b
 *
 * Chains:   b00 -o /tmp/b.r1 src.b
 *           b01 -i /tmp/b.r1 -o /tmp/b.r2
 *           b1  -i /tmp/b.r2 -o /tmp/b.s
 *           as /usr/lib/bmain.s /usr/lib/brt.s /tmp/b.s
 * Leaves a.out in the current directory.
 *
 * Written in V1 last1120c dialect (same as the bcc-pdp sources):
 * no `char *` declarators, no `**`, no preprocessor, no `for`, etc.
 * Helper sa() lets us store a string-literal address into an int slot
 * (V1 cc rejects the direct assignment but accepts it through a fn arg).
 */

b0arg[8];
b1arg[8];
asarg[8];

/* set int-slot to value, where value is a char[] (i.e. pointer).
 * V1 cc treats arr[i] = char[]-typed-arg as int = int, which works. */
sa(arr, i, val) int arr[]; char val[]; {
	arr[i] = val;
}

main(argc, argv) int argv[]; {
	extern b0arg, b1arg, asarg;
	int b0arg[], b1arg[], asarg[];
	char src[];
	int i, ext;
	if (argc < 2) {
		write(2, "usage: b [-x] src.b\n", 20);
		exit(1);
	}
	i = 1;
	ext = 0;
	src = argv[i];
	if (src[0] == '-') if (src[1] == 'x') if (src[2] == 0) {
		ext = 1;
		i = i + 1;
		if (i >= argc) {
			write(2, "usage: b [-x] src.b\n", 20);
			exit(1);
		}
		src = argv[i];
	}

	sa(b0arg, 0, "b00");
	if (ext) {
		sa(b0arg, 1, "-x");
		sa(b0arg, 2, "-o");
		sa(b0arg, 3, "/tmp/b.r1");
		sa(b0arg, 4, src);
		b0arg[5] = 0;
	} else {
		sa(b0arg, 1, "-o");
		sa(b0arg, 2, "/tmp/b.r1");
		sa(b0arg, 3, src);
		b0arg[4] = 0;
	}
	run("/bin/b00", b0arg);

	sa(b1arg, 0, "b01");
	sa(b1arg, 1, "-i");
	sa(b1arg, 2, "/tmp/b.r1");
	sa(b1arg, 3, "-o");
	sa(b1arg, 4, "/tmp/b.r2");
	b1arg[5] = 0;
	run("/bin/b01", b1arg);

	sa(b1arg, 0, "b1");
	sa(b1arg, 1, "-i");
	sa(b1arg, 2, "/tmp/b.r2");
	sa(b1arg, 3, "-o");
	sa(b1arg, 4, "/tmp/b.s");
	b1arg[5] = 0;
	run("/bin/b1", b1arg);

	sa(asarg, 0, "as");
	sa(asarg, 1, "/usr/lib/bmain.s");
	sa(asarg, 2, "/usr/lib/brt.s");
	sa(asarg, 3, "/usr/lib/libb.s");
	sa(asarg, 4, "/tmp/b.s");
	asarg[5] = 0;
	run("/bin/as", asarg);

	/* /bin/as is the V2 assembler emitting 0407 a.out; V1 kernel exec
	 * needs 0405.  Rewrite the header in place. */
	fixout("a.out");

	/* V1 as leaves a.out without the exec bit set. */
	chmod("a.out", 036);   /* exec+ownr+ownw+wrldr */

	unlink("/tmp/b.r1");
	unlink("/tmp/b.r2");
	unlink("/tmp/b.s");
	exit(0);
}

/* Convert 0407 -> 0405 a.out (same as host tools/fixaout.py).
 * Original header (8 words / 16 bytes):
 *   0:magic 2:a_text 4:a_data 6:a_bss 8:a_syms 10:a_entry 12:unused 14:flag
 * New 0405 header (6 words / 12 bytes):
 *   [0405, 12+a_text, 0, 0, a_syms, 0]
 * Then text+data unchanged (was at byte 16, now at byte 12). */
fixout(name) char name[]; {
	int fdin, fdout, hdr[8], nhdr[6], n;
	char buf[512];
	fdin = open(name, 0);
	if (fdin < 0) return;
	n = read(fdin, hdr, 16);
	if (n != 16) { close(fdin); return; }
	nhdr[0] = 0405;
	nhdr[1] = 12 + hdr[1];
	nhdr[2] = 0;
	nhdr[3] = 0;
	nhdr[4] = hdr[4];
	nhdr[5] = 0;
	fdout = creat("/tmp/b.aout", 036);
	if (fdout < 0) { close(fdin); return; }
	write(fdout, nhdr, 12);
	n = read(fdin, buf, 512);
	while (n > 0) {
		write(fdout, buf, n);
		n = read(fdin, buf, 512);
	}
	close(fdin);
	close(fdout);
	unlink(name);
	link("/tmp/b.aout", name);
	unlink("/tmp/b.aout");
}

run(prog, args) char prog[]; int args[]; {
	int p;
	p = fork();
	if (p == 0) {
		execv(prog, args);
		write(1, "b: exec failed\n", 15);
		exit(1);
	}
	/* V1 wait() returns the pid of any dead child in r0; the exit
	 * status is not exposed via a pointer arg in V1 libc. */
	while (wait() != p);
}
