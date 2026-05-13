/* bstmt.c -- statements & definitions.  Strict 1972 kbman conformance.
 *
 * Grammar (kbman §2 canonical):
 *   program     := { defn }
 *   defn        := NAME '[' [const] ']' { ival {',' ival} } ';'        (vector)
 *                | NAME { ival {',' ival} } ';'                         (simple)
 *                | NAME '(' [args] ')' stmt                             (function)
 *   ival        := constant | name
 *   decl        := 'auto'  NAME [NUM] {',' NAME [NUM]} ';'
 *                | 'extrn' NAME {',' NAME} ';'
 *   stmt        := ';' | '{' stmt* '}'
 *                | 'if' '(' rvalue ')' stmt ['else' stmt]
 *                | 'while' '(' rvalue ')' stmt
 *                | 'switch' rvalue stmt                                 (no parens! kbman §5.4)
 *                | 'case' constant ':' stmt
 *                | 'return' [ '(' rvalue ')' ] ';'
 *                | 'goto' rvalue ';'                                    (computed; label or addr)
 *                | NAME ':' stmt
 *                | rvalue ';'
 *
 * Token codes used in arms below (V1 cc has no preprocessor):
 *   0 T_EOF  1 T_NAME  2 T_NUM
 *  10 T_AUTO 11 T_EXTRN 12 T_IF 13 T_ELSE 14 T_WHILE
 *  15 T_RET 16 T_GOTO 19 T_SWITCH 20 T_CASE
 * Symbol classes: 1 C_AUTO 2 C_ARG 3 C_EXTRN 4 C_INTERN 5 C_LABEL
 *                 6 C_VECT 7 C_GVECT
 *
 * Per-switch case table (alternating const, label).  Outer switches save
 * + restore via swsav stack.  kbman §13: case overflow is fatal `>c`.
 */

swc[64];          /* current switch's (const, label) pairs, 32 max */
nswc 0;
swsav[16];        /* saved nswc for nested switches */
swdpt 0;
brkl 0;
contl 0;
hasbrk 0;
hascont 0;

cpname(dst, src) char dst[]; char src[]; {
	int i;
	i = 0;
	while (1) {
		if (i >= 8) break;
		if (src[i] == 0) break;
		dst[i] = src[i];
		i = i + 1;
	}
	while (i < 9) {
		dst[i] = 0;
		i = i + 1;
	}
}

prog() {
	extern tok, tnam;
	int tok;
	char tnam[];
	char name[10];
	while (tok != 0) {                       /* T_EOF */
		if (tok != 1) fatal("expected name at top level");   /* T_NAME */
		cpname(name, tnam);
		gettok();
		if (tok == '(') fdef(name);
		else            gdef(name);
	}
}

gconst() {
	extern tok, tval;
	int tok, tval;
	int neg, v;
	neg = 0;
	if (tok == '-') {
		neg = 1;
		gettok();
	}
	if (tok != 2) if (tok != 4) fatal("expected constant");
	v = tval;
	gettok();
	if (neg) v = -v;
	return (v);
}

/* gival -- read one ival (kbman §7.0): constant OR name (address-of).
 *   On entry: tok positioned at first ival token.
 *   kinds[idx] := 0 const, 1 name.
 *   On const: vals[idx] := value.
 *   On name : nm[idx*10..+9] := name string.
 */
gival(idx, kinds, vals, nm) int kinds[]; int vals[]; char nm[]; {
	extern tok, tnam;
	int tok;
	char tnam[];
	if (tok == 1) {                     /* T_NAME */
		kinds[idx] = 1;
		cpname(&nm[idx * 10], tnam);
		gettok();
		return;
	}
	kinds[idx] = 0;
	vals[idx]  = gconst();
}

/* Stream-emit the data section for a global definition.
 *   name        -- external symbol
 *   n           -- declared/effective vector size (>= ninit)
 *   ninit       -- number of explicit initializers
 *   kinds, vals -- per-init kind+value (for kind 0)
 *   nm          -- per-init name buffer (for kind 1), 10 bytes/entry
 */
emitg(name, n, ninit, kinds, vals, nm) char name[]; int kinds[]; int vals[]; char nm[]; {
	int i;
	cggvb(name, n);
	i = 0;
	while (i < ninit) {
		if (kinds[i] == 1) cggvn(&nm[i * 10]);
		else               cggvc(vals[i]);
		i = i + 1;
	}
	while (i < n) {
		cggvc(0);
		i = i + 1;
	}
	cggve();
}

gdef(name) char name[]; {
	extern tok, tval;
	int tok, tval;
	int vals[128];
	int kinds[128];
	char nm[1280];        /* 128 entries × 10 bytes per name */
	int n, ninit;

	if (tok == '[') {
		gettok();
		n = 0;                          /* kbman §7.2: missing size -> 0 */
		if (tok == 2) {
			n = tval;
			gettok();
		}
		if (tok != ']') fatal("expected ] in global vector");
		gettok();

		ninit = 0;
		while (tok != ';') {
			if (tok == 0) fatal("unexpected EOF in global vector");
			if (ninit >= 128) fatal("too many vector initializers");
			gival(ninit, kinds, vals, nm);
			ninit = ninit + 1;
			if (tok == ',') {
				gettok();
				continue;
			}
			if (tok != ';') fatal("expected , or ; in global vector");
		}
		if (n < ninit) n = ninit;
		cgagvec(name);
		emitg(name, n, ninit, kinds, vals, nm);
		gettok();
		return;
	}

	/* Simple defn: name {ival,...} ;  -- no '=' (kbman §7.1) */
	ninit = 0;
	while (tok != ';') {
		if (tok == 0) fatal("unexpected EOF in global");
		if (ninit >= 128) fatal("too many global initializers");
		gival(ninit, kinds, vals, nm);
		ninit = ninit + 1;
		if (tok == ',') {
			gettok();
			continue;
		}
		if (tok != ';') fatal("expected , or ; in global");
	}
	if (ninit == 0) emitg(name, 1, 0, kinds, vals, nm);
	else            emitg(name, ninit, ninit, kinds, vals, nm);
	gettok();
}

fdef(name) char name[]; {
	extern tok, tval, tnam, extflg;
	int  tok, tval, extflg;
	char tnam[];
	int nargs, nlocals, sz;
	char saved[10];

	if (tok != '(') fatal("expected ( after function name");
	gettok();

	outs("Adef ");
	outs(name);
	outc('\n');

	nargs = 0;
	while (tok == 1) {                       /* T_NAME */
		cgaarg(tnam, nargs);
		nargs = nargs + 1;
		gettok();
		if (tok == ',') gettok();
	}
	if (tok != ')') fatal("expected ) in arg list");
	gettok();

	if (tok != '{') {
		stmt();
		cgepi();
		return;
	}
	gettok();

	nlocals = 0;
	while (1) {
		if (tok == 10) {                     /* T_AUTO */
			gettok();
			while (tok == 1) {
				cpname(saved, tnam);
				sz = 1;
				cgaauto(saved);
				gettok();
				if (tok == '[') {
					if (!extflg) fatal("auto [] requires -x");
					gettok();
					if (tok != 2) fatal("expected vector size");
					sz = tval + 1;
					gettok();
					if (tok != ']') fatal("expected ] after vector size");
					gettok();
					cgavecsz(saved, sz);
				}
				if (tok == 2) {              /* T_NUM */
					sz = tval + 1;
					gettok();
					cgavecsz(saved, sz);
				}
				nlocals = nlocals + sz;
				if (tok == ',') gettok();
			}
			if (tok != ';') fatal("expected ; after auto");
			gettok();
			continue;
		}
		if (tok == 11) {                     /* T_EXTRN */
			gettok();
			while (tok == 1) {
				cgaextrn(tnam);
				gettok();
				if (tok == ',') gettok();
			}
			if (tok != ';') fatal("expected ; after extrn");
			gettok();
			continue;
		}
		break;
	}

	while (tok != '}') {
		if (tok == 0) fatal("unexpected EOF in function body");
		stmt();
	}
	gettok();                                /* consume } */

	cgepi();
}

stmt() {
	extern tok, tnam, tval, tstr, swc, nswc, swsav, swdpt;
	extern extflg, brkl, contl, hasbrk, hascont;
	int  tok, tval, tstr, nswc, swdpt, extflg, brkl, contl, hasbrk, hascont;
	char tnam[];
	int  swc[], swsav[];
	int lel, laf, ltp, len;
	int ldisp, lpop, lend, konst, lcase, savn, i;
	int ob, oc, ohb, ohc;
	char saved[10];
	int svval, svstr;

	if (tok == '{') {
		gettok();
		while (tok != '}') {
			if (tok == 0) fatal("unexpected EOF in block");
			stmt();
		}
		gettok();
		return;
	}
	if (tok == ';') { gettok(); return; }

	if (tok == 12) {                         /* T_IF */
		gettok();
		if (tok != '(') fatal("expected ( after if");
		gettok();
		expr();
		if (tok != ')') fatal("expected )");
		gettok();
		lel = newl();
		cgbrf(lel);
		stmt();
		if (tok == 13) {                     /* T_ELSE */
			gettok();
			laf = newl();
			cgjmp(laf);
			cglab(lel);
			stmt();
			cglab(laf);
		} else {
			cglab(lel);
		}
		return;
	}

	if (tok == 14) {                         /* T_WHILE */
		gettok();
		if (tok != '(') fatal("expected ( after while");
		gettok();
		ltp = newl();
		len = newl();
		cglab(ltp);
		expr();
		if (tok != ')') fatal("expected )");
		gettok();
		cgbrf(len);
		ob = brkl; oc = contl; ohb = hasbrk; ohc = hascont;
		brkl = len; contl = ltp; hasbrk = 1; hascont = 1;
		stmt();
		brkl = ob; contl = oc; hasbrk = ohb; hascont = ohc;
		cgjmp(ltp);
		cglab(len);
		return;
	}

	if (tok == 19) {                         /* T_SWITCH (kbman §5.4) */
		gettok();
		ldisp = newl();
		lpop  = newl();
		lend  = newl();
		expr();                          /* switch rvalue (no parens!) */
		cgswb(ldisp);
		/* push outer switch table state */
		if (swdpt >= 16) fatal("switch nesting too deep");
		swsav[swdpt] = nswc;
		swdpt = swdpt + 1;
		savn = nswc;
		nswc = 0;
		ob = brkl; ohb = hasbrk;
		brkl = lpop; hasbrk = 1;
		stmt();                          /* body; cases emit labels + table entries */
		brkl = ob; hasbrk = ohb;
		cgswe(ldisp, lpop, lend, nswc, swc);
		swdpt = swdpt - 1;
		nswc = swsav[swdpt];
		/* shift swc entries back is unnecessary -- nested switches always
		 * complete cgswe before outer parsing resumes. */
		return;
	}

	if (tok == 20) {                         /* T_CASE (kbman §5.4) */
		gettok();
		konst = gconst();
		if (tok != ':') fatal("expected : after case constant");
		gettok();
		if (nswc >= 32) fatal(">c");     /* kbman case overflow */
		lcase = newl();
		swc[2 * nswc]     = konst;
		swc[2 * nswc + 1] = lcase;
		nswc = nswc + 1;
		cglab(lcase);
		stmt();
		return;
	}

	if (tok == 15) {                         /* T_RET */
		gettok();
		if (tok == '(') {
			gettok();
			expr();
			if (tok != ')') fatal("expected )");
			gettok();
		} else {
			cgnst(0);
		}
		if (tok != ';') fatal("expected ; after return");
		gettok();
		cgret();
		return;
	}

	if (tok == 17) {                         /* T_BREAK extension */
		if (!extflg) fatal("break removed in strict 1972 mode");
		if (!hasbrk) fatal("break outside loop/switch");
		gettok();
		if (tok != ';') fatal("expected ; after break");
		gettok();
		cgjmp(brkl);
		return;
	}

	if (tok == 18) {                         /* T_CONT extension */
		if (!extflg) fatal("continue removed in strict 1972 mode");
		if (!hascont) fatal("continue outside loop");
		gettok();
		if (tok != ';') fatal("expected ; after continue");
		gettok();
		cgjmp(contl);
		return;
	}

	if (tok == 16) {                         /* T_GOTO  (kbman §5.5) */
		gettok();
		if (tok == 1) {
			cpname(saved, tnam);
			svval = tval;
			svstr = tstr;
			gettok();
			if (tok == ';') {
				cgrlbl(saved);
				gettok();
				return;
			}
			pushtok();
			tok = 1;
			cpname(tnam, saved);
			tval = svval;
			tstr = svstr;
		}
		expr();                          /* eval addr to r0 */
		if (tok != ';') fatal("expected ; after goto");
		gettok();
		cggor();                          /* jmp (r0) */
		return;
	}

	/* NAME ':' stmt  vs  expr starting with NAME.  Peek via pushtok. */
	if (tok == 1) {                          /* T_NAME */
		cpname(saved, tnam);
		svval = tval;
		svstr = tstr;
		gettok();
		if (tok == ':') {
			cgrdef(saved);
			gettok();
			stmt();
			return;
		}
		/* Not a label: rewind one token and restore NAME state. */
		pushtok();
		tok = 1;
		cpname(tnam, saved);
		tval = svval;
		tstr = svstr;
	}

	expr();
	if (tok != ';') fatal("expected ; after expression");
	gettok();
}
