/* blex1.c -- b1's mini scanner for IC records.
 *
 * One record per line.  After getln() returns the next line in buf,
 * b1drv parses tokens via the helpers here: nxti() for decimal ints,
 * nxtnam() for 8-char names.  bcur is the cursor into buf.
 */

bcur 0;
icfd 0;

/* Read one line from icfd into buf (max-1 chars).  NUL-terminate.
 * Newline NOT included.  Return 0 on EOF (empty line), 1 otherwise. */
getln(buf, max) char buf[]; {
	extern icfd;
	int icfd;
	char b[2];
	int i, n;
	i = 0;
	while (i < max - 1) {
		n = read(icfd, b, 1);
		if (n <= 0) {
			buf[i] = 0;
			if (i == 0) return (0);
			return (1);
		}
		if (b[0] == '\n') {
			buf[i] = 0;
			return (1);
		}
		buf[i] = b[0];
		i = i + 1;
	}
	buf[i] = 0;
	return (1);
}

icini(fd) {
	extern icfd, bcur;
	int icfd, bcur;
	icfd = fd;
	bcur = 0;
}

icrst() {
	extern bcur;
	int bcur;
	bcur = 0;
}

/* Skip spaces.  Return current char (0 = EOL). */
skpws(buf) char buf[]; {
	extern bcur;
	int bcur;
	while (buf[bcur] == ' ') bcur = bcur + 1;
	return (buf[bcur]);
}

/* Parse decimal int from buf at bcur.  Advance bcur past it. */
nxti(buf) char buf[]; {
	extern bcur;
	int bcur;
	int v, neg;
	skpws(buf);
	neg = 0;
	if (buf[bcur] == '-') { neg = 1; bcur = bcur + 1; }
	v = 0;
	while (buf[bcur] >= '0') if (buf[bcur] <= '9') {
		v = v * 10 + (buf[bcur] - '0');
		bcur = bcur + 1;
		continue;
	} else break;
	if (neg) v = -v;
	return (v);
}

/* Copy next whitespace-delimited token into name (8 chars + NUL). */
nxtnam(buf, name) char buf[]; char name[]; {
	extern bcur;
	int bcur;
	int i;
	skpws(buf);
	i = 0;
	while (i < 8) {
		if (buf[bcur] == 0) break;
		if (buf[bcur] == ' ') break;
		name[i] = buf[bcur];
		bcur = bcur + 1;
		i = i + 1;
	}
	while (i <= 8) {
		name[i] = 0;
		i = i + 1;
	}
}

/* Compare null-terminated strings; return 1 if equal. */
tageq(a, b) char a[]; char b[]; {
	int i;
	i = 0;
	while (1) {
		if (a[i] == 0) break;
		if (b[i] == 0) break;
		if (a[i] != b[i]) return (0);
		i = i + 1;
	}
	if (a[i] != 0) return (0);
	if (b[i] != 0) return (0);
	return (1);
}
