/* bstmt.c -- statements and definitions for the selected B72 dialect.
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
 * kbman §13: each switch accepts at most 32 cases (`>c` on overflow).
 */

/* Each switch streams a forward-linked dispatch chain. */
nswc 0;
swdpt 0;
swdisp 0;
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

/* Include the pointer cell when budgeting an automatic vector. */
vsize() {
	extern tval;
	int tval;
	if (tval < 0 | tval > 8190) fatal("bad vector size");
	return (tval + 1);
}

/* Emit one ival (kbman §7.0): constant OR name (address-of). */
gival() {
	extern tok, tnam, tstrbuf, tstrlen;
	int tok, tstrlen;
	char tnam[], tstrbuf[];
	if (tok == 3) {
		cgslt(tstrbuf, tstrlen, 1);
		gettok();
		return;
	}
	if (tok == 1) {                     /* T_NAME */
		cggvn(tnam);
		gettok();
		return;
	}
	cggvc(gconst());
}

gdef(name) char name[]; {
	extern tok, tval;
	int tok, tval;
	int n, ninit;

	if (tok == '[') {
		gettok();
		n = 0;                          /* kbman §7.2: missing size -> 0 */
		if (tok == 2 | tok == 4) {
			n = vsize() - 1;
			gettok();
		}
		if (tok != ']') fatal("expected ] in global vector");
		gettok();

		cgagvec(name);
		cggvp(name, n);
		ninit = 0;
		while (tok != ';') {
			if (tok == 0) fatal("unexpected EOF in global vector");
			if (ninit >= 128) fatal("too many vector initializers");
			gival();
			ninit = ninit + 1;
			if (tok == ',') {
				gettok();
				continue;
			}
			if (tok != ';') fatal("expected , or ; in global vector");
		}
		cggve();
		gettok();
		return;
	}

	/* Simple defn: name {ival,...} ;  -- no '=' (kbman §7.1) */
	cggvb(name, 0);
	ninit = 0;
	while (tok != ';') {
		if (tok == 0) fatal("unexpected EOF in global");
		if (ninit >= 128) fatal("too many global initializers");
		gival();
		ninit = ninit + 1;
		if (tok == ',') {
			gettok();
			continue;
		}
		if (tok != ';') fatal("expected , or ; in global");
	}
	if (ninit == 0) cggvc(0);
	cggve();
	gettok();
}

nlocal 0;

/* Declarations are statements, not just a function-body prefix. */
decl() {
    extern tok, tval, tnam, extflg, nlocal;
    int tok, tval, extflg, nlocal;
    char tnam[];
    char saved[10];
    int kind, sz;
    kind = tok;
    gettok();
    while (1) {
        if (tok != 1) fatal("expected declaration name");
        cpname(saved, tnam);
        gettok();
        if (kind == 11) cgaextrn(saved);
        else {
            cgaauto(saved);
            sz = 1;
            if (tok == '[') {
                if (!extflg) fatal("auto [] requires -x");
                gettok();
                if (tok != 2) if (tok != 4) fatal("expected vector size");
                sz = vsize(); gettok();
                if (tok != ']') fatal("expected ] after vector size");
                gettok(); cgavecsz(saved, sz);
            } else if (tok == 2 | tok == 4) {
                sz = vsize(); gettok(); cgavecsz(saved, sz);
            }
            if (nlocal > 8191 - sz) fatal("auto frame too large");
            nlocal = nlocal + sz;
        }
        if (tok != ',') break;
        gettok();
    }
    if (tok != ';') fatal("expected ; after declaration");
    gettok();
}

fdef(name) char name[]; {
    extern tok, tnam, nlocal;
    int tok, nlocal;
    char tnam[];
    int nargs;
    if (tok != '(') fatal("expected ( after function name");
    gettok();
    outs("Adef "); outs(name); outc('\n');
    nargs = 0;
    if (tok != ')') {
        while (1) {
            if (tok != 1) fatal("expected parameter name");
            cgaarg(tnam, nargs); nargs = nargs + 1;
            gettok();
            if (tok != ',') break;
            gettok();
        }
    }
    if (tok != ')') fatal("expected ) in arg list");
    gettok();
    nlocal = 0;
    stmt();
    cgepi();
}

stmt() {
	extern tok, tnam, tval, tstr, nswc, swdpt, swdisp;
	extern extflg, brkl, contl, hasbrk, hascont;
	int  tok, tval, tstr, nswc, swdpt, swdisp, extflg, brkl, contl, hasbrk, hascont;
	char tnam[];
    /* Branches share six local words. Separate locals for every arm would
     * consume the small V1 stack at every nested statement. */
    int first, second, save1, save2, save3, save4;
	char saved[10];

    stkchk();
again:
    while (tok == 10 | tok == 11) decl();

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
		first = newl();
		cgbrf(first);
		stmt();
		if (tok == 13) {                     /* T_ELSE */
			gettok();
			second = newl();
			cgjmp(second);
			cglab(first);
			stmt();
			cglab(second);
		} else {
			cglab(first);
		}
		return;
	}

	if (tok == 14) {                         /* T_WHILE */
		gettok();
		if (tok != '(') fatal("expected ( after while");
		gettok();
		first = newl();
		second = newl();
		cglab(first);
		expr();
		if (tok != ')') fatal("expected )");
		gettok();
		cgbrf(second);
		save1 = brkl; save2 = contl; save3 = hasbrk; save4 = hascont;
		brkl = second; contl = first; hasbrk = 1; hascont = 1;
		stmt();
		brkl = save1; contl = save2; hasbrk = save3; hascont = save4;
		cgjmp(first);
		cglab(second);
		return;
	}

	if (tok == 19) {                         /* T_SWITCH */
		gettok();
		first = newl();
		second = newl();
		expr();
		cgswb(first);
		if (swdpt >= 16) fatal("switch nesting too deep");
		swdpt = swdpt + 1;
		save1 = nswc; save2 = swdisp;
		nswc = 0; swdisp = first;
		save3 = brkl; save4 = hasbrk;
		brkl = second; hasbrk = 1;
		stmt();
		cgswe(swdisp, second);
		brkl = save3; hasbrk = save4;
		nswc = save1; swdisp = save2;
		swdpt = swdpt - 1;
		return;
	}

	if (tok == 20) {                         /* T_CASE */
		if (swdpt == 0) fatal("case outside switch");
		gettok();
		first = gconst();
		if (tok != ':') fatal("expected : after case constant");
		gettok();
		if (nswc >= 32) fatal(">c");
		second = newl(); save1 = newl();
		cgswc(swdisp, second, first, save1);
		swdisp = second;
		nswc = nswc + 1;
		goto again;
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
			save1 = tval;
			save2 = tstr;
			gettok();
			if (tok == ';') {
				cgrlbl(saved);
				gettok();
				return;
			}
			pushtok();
			tok = 1;
			cpname(tnam, saved);
			tval = save1;
			tstr = save2;
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
		save1 = tval;
		save2 = tstr;
		gettok();
		if (tok == ':') {
			cgrdef(saved);
			gettok();
			goto again;
		}
		/* Not a label: rewind one token and restore NAME state. */
		pushtok();
		tok = 1;
		cpname(tnam, saved);
		tval = save1;
		tstr = save2;
	}

	expr();
	if (tok != ';') fatal("expected ; after expression");
	gettok();
}
