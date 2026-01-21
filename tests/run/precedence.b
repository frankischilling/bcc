/*
 * Operator Precedence Torture Test Suite
 * ======================================
 * Tests all operator precedence and associativity rules for B.
 * Each test prints expected value followed by actual value.
 * If they differ, precedence is broken.
 */

/* Test counter */
tests;
fails;

check(name, expected, actual) {
    tests =+ 1;
    if (expected != actual) {
        fails =+ 1;
        printf("FAIL %s: expected %d, got %d*n", name, expected, actual);
    }
}

/* ===== MULTIPLICATIVE vs ADDITIVE ===== */
test_mult_add() {
    auto a, b, c;

    /* * binds tighter than + */
    a = 2 + 3 * 4;        /* should be 2 + (3*4) = 14 */
    check("2+3*4", 14, a);

    a = 2 * 3 + 4;        /* should be (2*3) + 4 = 10 */
    check("2*3+4", 10, a);

    /* / binds tighter than - */
    a = 10 - 6 / 2;       /* should be 10 - (6/2) = 7 */
    check("10-6/2", 7, a);

    /* % binds same as * */
    a = 10 + 7 % 3;       /* should be 10 + (7%3) = 11 */
    check("10+7%3", 11, a);

    /* Multiple multiplicative: left-to-right */
    a = 100 / 10 / 2;     /* should be (100/10)/2 = 5 */
    check("100/10/2", 5, a);

    a = 100 / 10 * 2;     /* should be (100/10)*2 = 20 */
    check("100/10*2", 20, a);
}

/* ===== SHIFT vs ADDITIVE ===== */
test_shift() {
    auto a;

    /* In B, shifts are at SAME level as +/- (unlike C!) */
    /* This means: 1 + 2 << 3 parses as (1 + 2) << 3 in B */
    /* But we follow left-to-right at same level */
    a = 1 << 3;           /* 8 */
    check("1<<3", 8, a);

    a = 8 >> 2;           /* 2 */
    check("8>>2", 2, a);

    /* Shifts at same level as add, left-to-right */
    a = 1 + 1 << 2;       /* (1+1) << 2 = 8 */
    check("1+1<<2", 8, a);

    a = 16 >> 2 - 1;      /* (16>>2) - 1 = 3 */
    check("16>>2-1", 3, a);

    /* Multiple shifts: left-to-right */
    a = 1 << 2 << 1;      /* (1<<2)<<1 = 8 */
    check("1<<2<<1", 8, a);
}

/* ===== RELATIONAL vs ARITHMETIC ===== */
test_relational() {
    auto a;

    /* Relational binds looser than arithmetic */
    a = 2 + 2 == 4;       /* (2+2) == 4 = 1 */
    check("2+2==4", 1, a);

    a = 3 * 2 < 10;       /* (3*2) < 10 = 1 */
    check("3*2<10", 1, a);

    a = 5 > 3 + 1;        /* 5 > (3+1) = 1 */
    check("5>3+1", 1, a);

    /* Equality vs relational: equality binds looser */
    a = 1 < 2 == 1;       /* (1<2) == 1 = 1 */
    check("1<2==1", 1, a);

    a = 2 > 1 != 0;       /* (2>1) != 0 = 1 */
    check("2>1!=0", 1, a);

    /* Chained relationals (left-to-right) */
    a = 1 < 2 < 3;        /* ((1<2) < 3) = (1 < 3) = 1 */
    check("1<2<3", 1, a);
}

/* ===== BITWISE vs RELATIONAL ===== */
test_bitwise() {
    auto a;

    /* & binds tighter than | */
    a = 1 | 2 & 3;        /* 1 | (2&3) = 1 | 2 = 3 */
    check("1|2&3", 3, a);

    a = 3 & 2 | 1;        /* (3&2) | 1 = 2 | 1 = 3 */
    check("3&2|1", 3, a);

    /* Bitwise binds looser than equality */
    a = 1 == 1 & 1;       /* (1==1) & 1 = 1 & 1 = 1 */
    check("1==1&1", 1, a);

    /* || binds loosest among binary ops */
    a = 0 || 1;           /* 1 */
    check("0||1", 1, a);

    a = 0 | 0 || 1;       /* (0|0) || 1 = 0 || 1 = 1 */
    check("0|0||1", 1, a);
}

/* ===== UNARY OPERATORS ===== */
test_unary() {
    auto a, b, p;

    /* Unary minus */
    a = -3 + 5;           /* (-3) + 5 = 2 */
    check("-3+5", 2, a);

    a = 5 + -3;           /* 5 + (-3) = 2 */
    check("5+-3", 2, a);

    /* Unary minus with multiply */
    a = -2 * 3;           /* (-2) * 3 = -6 */
    check("-2*3", -6, a);

    a = 2 * -3;           /* 2 * (-3) = -6 */
    check("2*-3", -6, a);

    /* Logical NOT */
    a = !0;               /* 1 */
    check("!0", 1, a);

    a = !5;               /* 0 */
    check("!5", 0, a);

    a = !0 + 1;           /* (!0) + 1 = 2 */
    check("!0+1", 2, a);

    /* Double negation */
    a = - -5;             /* -(-5) = 5 */
    check("--5", 5, a);

    a = !!1;              /* !(!1) = !(0) = 1 */
    check("!!1", 1, a);
}

/* ===== DEREFERENCE AND ADDRESS-OF ===== */
test_deref_addr() {
    auto x, p, pp;

    x = 42;
    p = &x;

    /* *p gets value */
    check("*&x", 42, *p);

    /* Chained: &*p should equal p */
    check("&*p==p", 1, &*p == p);

    /* *& cancels */
    check("*&x==x", 1, *&x == x);

    /* Dereference with arithmetic */
    *p = *p + 1;          /* x becomes 43 */
    check("*p+1", 43, x);

    /* Address arithmetic (B allows this) */
    x = 100;
    check("*p", 100, *p);
}

/* ===== INCREMENT/DECREMENT ===== */
test_incdec() {
    auto a, b;

    /* Prefix increment */
    a = 5;
    b = ++a;              /* a becomes 6, b gets 6 */
    check("++a (a)", 6, a);
    check("++a (result)", 6, b);

    /* Postfix increment */
    a = 5;
    b = a++;              /* b gets 5, a becomes 6 */
    check("a++ (result)", 5, b);
    check("a++ (a)", 6, a);

    /* Prefix decrement */
    a = 5;
    b = --a;              /* a becomes 4, b gets 4 */
    check("--a (a)", 4, a);
    check("--a (result)", 4, b);

    /* Postfix decrement */
    a = 5;
    b = a--;              /* b gets 5, a becomes 4 */
    check("a-- (result)", 5, b);
    check("a-- (a)", 4, a);

    /* Increment in expression */
    a = 5;
    b = a++ + 10;         /* b = 5 + 10 = 15, a = 6 */
    check("a+++10 (result)", 15, b);
    check("a+++10 (a)", 6, a);

    /* Prefix in expression */
    a = 5;
    b = ++a + 10;         /* a = 6, b = 6 + 10 = 16 */
    check("++a+10 (result)", 16, b);
    check("++a+10 (a)", 6, a);
}

/* ===== ASSIGNMENT ===== */
test_assignment() {
    auto a, b, c;

    /* Simple assignment */
    a = 5;
    check("a=5", 5, a);

    /* Assignment returns value */
    b = (a = 10);
    check("b=(a=10) a", 10, a);
    check("b=(a=10) b", 10, b);

    /* Chained assignment (right-to-left) */
    a = b = c = 7;        /* c=7, then b=7, then a=7 */
    check("a=b=c=7 (a)", 7, a);
    check("a=b=c=7 (b)", 7, b);
    check("a=b=c=7 (c)", 7, c);

    /* Assignment vs equality: = binds looser than == */
    a = 5;
    b = a == 5;           /* b = (a == 5) = 1 */
    check("b=a==5", 1, b);
    check("a unchanged", 5, a);
}

/* ===== COMPOUND ASSIGNMENT (B-style =op) ===== */
test_compound() {
    auto a;

    a = 10;
    a =+ 5;               /* a = a + 5 = 15 */
    check("a=+5", 15, a);

    a = 10;
    a =- 3;               /* a = a - 3 = 7 */
    check("a=-3", 7, a);

    a = 10;
    a = a * 2;            /* a = a * 2 = 20 */
    check("a=a*2", 20, a);

    a = 10;
    a =/ 2;               /* a = a / 2 = 5 */
    check("a=/2", 5, a);

    a = 10;
    a =% 3;               /* a = a % 3 = 1 */
    check("a=%3", 1, a);

    a = 1;
    a =<< 3;              /* a = a << 3 = 8 */
    check("a=<<3", 8, a);

    a = 8;
    a =>> 2;              /* a = a >> 2 = 2 */
    check("a=>>2", 2, a);

    a = 7;
    a =& 3;               /* a = a & 3 = 3 */
    check("a=&3", 3, a);

    a = 5;
    a =| 2;               /* a = a | 2 = 7 */
    check("a=|2", 7, a);
}

/* ===== TERNARY OPERATOR ===== */
test_ternary() {
    auto a, b;

    /* Basic ternary */
    a = 1 ? 10 : 20;      /* 10 */
    check("1?10:20", 10, a);

    a = 0 ? 10 : 20;      /* 20 */
    check("0?10:20", 20, a);

    /* Ternary with expressions */
    a = 5;
    b = a > 3 ? 100 : 200;
    check("a>3?100:200", 100, b);

    /* Nested ternary (right-to-left) */
    a = 1 ? 2 ? 3 : 4 : 5;  /* 1 ? (2 ? 3 : 4) : 5 = 3 */
    check("1?2?3:4:5", 3, a);

    a = 0 ? 2 ? 3 : 4 : 5;  /* 0 ? ... : 5 = 5 */
    check("0?2?3:4:5", 5, a);

    /* Ternary vs assignment: ternary binds tighter */
    a = 1;
    b = 0;
    a = b ? 10 : 20;      /* a = (b ? 10 : 20) = 20 */
    check("a=b?10:20", 20, a);
}

/* ===== COMMA OPERATOR ===== */
test_comma() {
    auto a, b;

    /* Comma evaluates left, returns right */
    a = (1, 2, 3);        /* a = 3 */
    check("(1,2,3)", 3, a);

    /* Comma with side effects */
    a = 0;
    b = (a = 5, a + 1);   /* a=5, then b=6 */
    check("(a=5,a+1) a", 5, a);
    check("(a=5,a+1) b", 6, b);

    /* Comma is lowest precedence */
    a = 1, b = 2;         /* separate statements due to precedence */
    check("a=1,b=2 (a)", 1, a);
    check("a=1,b=2 (b)", 2, b);
}

/* ===== NASTY COMBINATIONS ===== */
test_nasty() {
    auto a, b, c, p;

    /* Mix of everything */
    a = 2 + 3 * 4 - 5;    /* 2 + 12 - 5 = 9 */
    check("2+3*4-5", 9, a);

    /* Note: B has no XOR (^) operator */
    a = 1 | 2 & 3;        /* 1 | (2 & 3) = 1 | 2 = 3 */
    check("1|2&3 (nasty)", 3, a);

    /* Unary in binary context */
    a = 5;
    b = - - -a;           /* -(-(- 5)) = -(-(-5)) = -5 */
    check("---a", -5, b);

    /* Postfix with binary */
    a = 5;
    b = a++ * 2;          /* 5 * 2 = 10, then a = 6 */
    check("a++*2 (result)", 10, b);
    check("a++*2 (a)", 6, a);

    /* Prefix with binary */
    a = 5;
    b = ++a * 2;          /* a=6, then 6*2=12 */
    check("++a*2 (result)", 12, b);

    /* Deref with increment */
    a = 10;
    p = &a;
    b = (*p)++;           /* b = 10, a = 11 */
    check("(*p)++ (result)", 10, b);
    check("(*p)++ (a)", 11, a);

    /* Complex assignment chain */
    a = b = c = 0;
    a = (b = 1) + (c = 2);  /* b=1, c=2, a=3 */
    check("a=(b=1)+(c=2) a", 3, a);
    check("a=(b=1)+(c=2) b", 1, b);
    check("a=(b=1)+(c=2) c", 2, c);

    /* Ternary in arithmetic */
    a = 5 + (1 ? 10 : 20) * 2;  /* 5 + 10*2 = 25 */
    check("5+(1?10:20)*2", 25, a);

    /* Relational chain */
    a = 1 < 2 < 3 < 4;    /* (((1<2)<3)<4) = ((1<3)<4) = (1<4) = 1 */
    check("1<2<3<4", 1, a);

    /* Equality with arithmetic */
    a = 2 * 3 == 6;       /* (2*3) == 6 = 1 */
    check("2*3==6", 1, a);

    a = 2 == 3 * 0;       /* 2 == (3*0) = 2 == 0 = 0 */
    check("2==3*0", 0, a);
}

/* ===== B-SPECIFIC: NO LOGICAL AND ===== */
test_no_logical_and() {
    auto a;

    /* B has || but NO && - must use nested ternary or bitwise & */

    /* Simulating && with ternary: a && b == a ? b : 0 */
    a = 1 ? (1 ? 1 : 0) : 0;  /* true && true = 1 */
    check("1&&1 (via ternary)", 1, a);

    a = 1 ? (0 ? 1 : 0) : 0;  /* true && false = 0 */
    check("1&&0 (via ternary)", 0, a);

    a = 0 ? (1 ? 1 : 0) : 0;  /* false && true = 0 */
    check("0&&1 (via ternary)", 0, a);

    /* Using bitwise & (works for 0/1 values) */
    a = 1 & 1;            /* 1 */
    check("1&1", 1, a);

    a = 1 & 0;            /* 0 */
    check("1&0", 0, a);
}

main() {
    tests = 0;
    fails = 0;

    printf("=== B Operator Precedence Torture Tests ===*n*n");

    test_mult_add();
    test_shift();
    test_relational();
    test_bitwise();
    test_unary();
    test_deref_addr();
    test_incdec();
    test_assignment();
    test_compound();
    test_ternary();
    test_comma();
    test_nasty();
    test_no_logical_and();

    printf("*n=== Results: %d tests, %d failures ===*n", tests, fails);

    if (fails > 0) {
        printf("FAILED*n");
        return 1;
    }
    printf("ALL PASSED*n");
    return 0;
}

