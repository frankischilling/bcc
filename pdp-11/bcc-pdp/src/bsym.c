/* bsym.c -- symbol table + label counter.  (Carved out of btab.c.)
 *
 * V1 as truncates linker symbols to 6 chars after the _ prefix.
 * Globals here use unique 6-char-stable prefixes:
 *   snam  -- symbol name bytes, 10 ints/symbol (max 8 char name + null)
 *   scls  -- symbol class
 *   soff  -- symbol offset
 *   nsy   -- count of symbols
 *   fnst  -- index of first per-fn entry
 */

snam[2000];
scls[200];
soff[200];
nsy 0;
fnst 0;

/* compare two C strings (NUL terminated); return 1 if equal */
nameq(a, b) char a[]; char b[]; {
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

/* copy up to 8 chars + NUL into snam at byte offset base */
nmcpy(base, src) char src[]; {
	extern snam;
	char snam[];
	int i;
	i = 0;
	while (1) {
		if (i >= 8) break;
		if (src[i] == 0) break;
		snam[base + i] = src[i];
		i = i + 1;
	}
	while (i < 9) {
		snam[base + i] = 0;
		i = i + 1;
	}
}

/* return -1 if not found, else symbol index */
symfnd(name) char name[]; {
	extern snam, nsy;
	char snam[];
	int   nsy;
	int i;
	int base;
	i = nsy - 1;
	while (i >= 0) {
		base = i * 10;
		if (nameq(&snam[base], name)) return (i);
		i = i - 1;
	}
	return (-1);
}

symadd(name, cls, off) char name[]; {
	extern snam, scls, soff, nsy;
	char snam[];
	int   scls[], soff[], nsy;
	int idx;
	if (nsy >= 200) fatal("symbol table full");
	idx = nsy;
	nmcpy(idx * 10, name);
	scls[idx] = cls;
	soff[idx] = off;
	nsy = nsy + 1;
	return (idx);
}

symtrn() {
	extern nsy, fnst;
	int nsy, fnst;
	nsy = fnst;
}
