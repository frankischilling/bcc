/* bexpr.c -- expression parser.  Precedence-climbing, immediate codegen.
 * Strict 1972 kbman conformance by default: no ~ ^ && ||.
 * b00 -x enables those post-1972 compatibility extensions.
 *
 * lvalue convention: primary returns 1 if R0 holds an address (lvalue),
 * 0 if R0 holds a value (rvalue).  exprv coerces lvalues via cgdrf
 * unless an assignment follows.
 *
 * Token codes (V1 cc no preprocessor, literals here):
 *   1 T_NAME  2 T_NUM  3 T_STR  4 T_CHAR
 *   100 T_EQ 101 T_NE 102 T_LE 103 T_GE 104 T_SHL 105 T_SHR
 *   106 T_INC 107 T_DEC
 *   130..136 =+ =- =* =/ =% =& =|         (138..139 =<< =>>)
 *   140..145 === =!= =< =<= => =>=
 * Symbol classes: 1 C_AUTO 2 C_ARG 3 C_EXTRN 4 C_INTERN 5 C_LABEL
 *                 6 C_VECT 7 C_GVECT
 *
 * C_VECT (vector auto): v's stack slot holds a pointer to the data area.
 * Bare v rvalue = pointer value.  v[i] dereferences v first, then indexes.
 */

/* binop_info returns: rprc (precedence) and rop (op token) in globals */
rprc 0;
rop 0;

binfo() {
	extern tok, rprc, rop;
	int tok, rprc, rop;
	int t;
	t = tok;
	/* kbman §4.2..4.10 binding order, lowest first.
	 * Extension-only: || && ^ use lower, C-like precedence. */
	if (t == 109) { rprc = 1; rop = t; return (1); }  /* || */
	if (t == 108) { rprc = 2; rop = t; return (1); }  /* && */
	if (t == '|') { rprc = 3; rop = '|'; return (1); }
	if (t == '^') { rprc = 4; rop = '^'; return (1); }
	if (t == '&') { rprc = 5; rop = '&'; return (1); }
	if (t == 100) { rprc = 6; rop = t; return (1); }   /* == */
	if (t == 101) { rprc = 6; rop = t; return (1); }   /* != */
	if (t == '<') { rprc = 7; rop = t; return (1); }
	if (t == '>') { rprc = 7; rop = t; return (1); }
	if (t == 102) { rprc = 7; rop = t; return (1); }   /* <= */
	if (t == 103) { rprc = 7; rop = t; return (1); }   /* >= */
	if (t == 104) { rprc = 8; rop = t; return (1); }   /* << */
	if (t == 105) { rprc = 8; rop = t; return (1); }   /* >> */
	if (t == '+') { rprc = 9; rop = t; return (1); }
	if (t == '-') { rprc = 9; rop = t; return (1); }
	if (t == '*') { rprc = 10; rop = t; return (1); }
	if (t == '/') { rprc = 10; rop = t; return (1); }
	if (t == '%') { rprc = 10; rop = t; return (1); }
	return (0);
}

/* Map full assign token (130..145) to its underlying binary op token.
 * Returns 0 for the bare '=' (caller filters that). */
aeqop(t) {
	if (t == 130) return ('+');
	if (t == 131) return ('-');
	if (t == 132) return ('*');
	if (t == 133) return ('/');
	if (t == 134) return ('%');
	if (t == 135) return ('&');
	if (t == 136) return ('|');
	if (t == 137) return ('^');
	if (t == 138) return (104);   /* T_SHL */
	if (t == 139) return (105);   /* T_SHR */
	if (t == 140) return (100);   /* T_EQ  (===) */
	if (t == 141) return (101);   /* T_NE  (=!=) */
	if (t == 142) return ('<');
	if (t == 143) return (102);   /* T_LE  (=<=) */
	if (t == 144) return ('>');
	if (t == 145) return (103);   /* T_GE  (=>=) */
	fatal("aeqop: bad token");
	return (0);
}

isasn() {
	extern tok;
	int tok;
	if (tok == '=') return (1);
	if (tok >= 130) if (tok <= 145) return (1);
	return (0);
}

/* Returns 1 if R0 holds an lvalue (address), 0 if rvalue. */
primlv() {
	extern tok, tval, tstr, tnam, tstrbuf, tstrlen;
	int  tok, tval, tstr, tstrlen;
	char tnam[], tstrbuf[];
	int nargs, i;
	char name[10];

	if (tok == 2) {                          /* T_NUM */
		cgnst(tval);
		gettok();
		return (0);
	}
	if (tok == 4) {                          /* T_CHAR */
		cgnst(tval);
		gettok();
		return (0);
	}
	if (tok == 3) {                          /* T_STR */
		cgslt(tstrbuf, tstrlen);
		gettok();
		return (0);
	}
	if (tok == '(') {
		gettok();
		exprv();
		if (tok != ')') fatal("expected )");
		gettok();
		return (0);
	}
	if (tok == '&') {
		gettok();
		if (!primlv()) fatal("& requires lvalue");
		return (0);                          /* address is now an rvalue */
	}
	if (tok == '*') {
		gettok();
		if (unary()) cgdrf();                 /* load pointer value into R0 */
		return (1);                          /* result is lvalue at that addr */
	}
	if (tok == 1) {                          /* T_NAME */
		i = 0;
		while (i < 9) {
			name[i] = tnam[i];
			i = i + 1;
		}
		gettok();
		if (tok == '(') {
			nargs = 0;
			gettok();
			if (tok != ')') {
				while (1) {
					exprv();
					cgpsh();
					nargs = nargs + 1;
					if (tok == ')') break;
					if (tok != ',') fatal("expected , in args");
					gettok();
				}
			}
			gettok();
			cgcll(name, nargs);
			return (0);
		}
		cgrname(name);
		if (tok == '[') {
			gettok();
			cgpsh();
			exprv();
			if (tok != ']') fatal("expected ]");
			gettok();
			cgidx();
		}
		if (tok == 106) {                        /* T_INC */
			gettok();
			cgpoi(1);
			return (0);
		}
		if (tok == 107) {                        /* T_DEC */
			gettok();
			cgpoi(0);
			return (0);
		}
		return (1);
	}
	fatal("expected expression");
	return (0);
}

/* Prefix unaries.  Returns 1 if result is still an lvalue. */
unary() {
	extern tok;
	int tok;
	int l1, l2;
	if (tok == '-') {
		gettok();
		if (unary()) cgdrfr();
		cguop('-');
		return (0);
	}
	if (tok == '~') {
		gettok();
		if (unary()) cgdrfr();
		cguop('~');
		return (0);
	}
	if (tok == '!') {
		gettok();
		if (unary()) cgdrfr();
		l1 = newl();
		l2 = newl();
		cguopn(l1, l2);
		return (0);
	}
	if (tok == 106) {                            /* T_INC */
		gettok();
		if (!unary()) fatal("++ requires lvalue");
		cgpri(1);
		return (0);
	}
	if (tok == 107) {                            /* T_DEC */
		gettok();
		if (!unary()) fatal("-- requires lvalue");
		cgpri(0);
		return (0);
	}
	return (primlv());
}

/* Precedence-climbing tail.  R0 already holds LHS rvalue. */
binary(minprc) {
	extern tok, rprc, rop;
	int tok, rprc, rop;
	int prec, op, islv, lfa, lend, lrhs;
	while (binfo()) {
		prec = rprc;
		op = rop;
		if (prec < minprc) return;
		gettok();
		if (op == 108) {                 /* && */
			lfa = newl();
			lend = newl();
			cgbrf(lfa);
			islv = unary();
			if (islv) cgdrfr();
			binary(prec + 1);
			cgbrf(lfa);
			cgnst(1);
			cgjmp(lend);
			cglab(lfa);
			cgnst(0);
			cglab(lend);
			continue;
		}
		if (op == 109) {                 /* || */
			lrhs = newl();
			lfa = newl();
			lend = newl();
			cgbrf(lrhs);
			cgnst(1);
			cgjmp(lend);
			cglab(lrhs);
			islv = unary();
			if (islv) cgdrfr();
			binary(prec + 1);
			cgbrf(lfa);
			cgnst(1);
			cgjmp(lend);
			cglab(lfa);
			cgnst(0);
			cglab(lend);
			continue;
		}
		cgpsh();
		islv = unary();
		if (islv) cgdrfr();
		binary(prec + 1);
		if (iscmp(op)) {
			lfa  = newl();
			lend = newl();
			cgbinc(op, lfa, lend);
		} else {
			cgbin(op);
		}
	}
}

exprv() {
	extern tok;
	int tok;
	int islv, op, bop, le, lend, lfa;
	islv = unary();
	op = 0;
	if (islv) op = isasn();
	if (op) {
		op = tok;
		gettok();
		cgpsh();
		exprv();
		if (op == '=') {
			cgasn();
		} else {
			bop = aeqop(op);
			if (iscmp(bop)) {
				lfa  = newl();
				lend = newl();
				cgcaec(bop, lfa, lend);
			} else {
				cgcae(bop);
			}
		}
		return;
	}
	if (islv) cgdrfr();
	binary(1);
	if (tok == '?') {
		gettok();
		le = newl();
		cgtnq(le);
		exprv();
		if (tok != ':') fatal("expected :");
		gettok();
		lend = newl();
		cgtnc(le, lend);
		exprv();
		cgtne(lend);
	}
}

/* External entry point for statement parser. */
expr() {
	exprv();
}
