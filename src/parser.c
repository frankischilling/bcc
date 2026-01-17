// parser.c - parser implementation

#include "bcc.h"

void next(Parser *P) {
    tok_free(&P->cur);
    P->cur = lx_next(&P->L);
}


void expect(Parser *P, TokenKind k) {
    if (P->cur.kind != k) {
        error_at(&P->cur, P->source, "expected %s, got %s", tk_name(k), tk_name(P->cur.kind));
    }
    next(P);
}

int accept(Parser *P, TokenKind k) {
    if (P->cur.kind == k) { next(P); return 1; }
    return 0;
}

Expr *new_expr(ExprKind k, int line, int col) {
    Expr *e = (Expr*)xmalloc(sizeof(*e));
    e->kind = k; e->line = line; e->col = col;
    return e;
}

Stmt *new_stmt(StmtKind k, int line, int col) {
    Stmt *s = (Stmt*)xmalloc(sizeof(*s));
    s->kind = k; s->line = line; s->col = col;
    return s;
}

Init *new_init(InitKind k, int line, int col){
    Init *in = (Init*)xmalloc(sizeof(*in));
    in->kind = k; in->line = line; in->col = col;
    return in;
}

static int is_assign_op(TokenKind k) {
    switch (k) {
        case TK_ASSIGN:
        case TK_PLUSEQ:
        case TK_MINUSEQ:
        case TK_STAREQ:
        case TK_SLASHEQ:
        case TK_PERCENTEQ:
        case TK_LSHIFTEQ:
        case TK_RSHIFTEQ:
        case TK_ANDEQ:
        case TK_OREQ:
        case TK_LTEQ:
        case TK_LEEQ:
        case TK_GTEQ:
        case TK_GEEQ:
        case TK_EQEQ:
        case TK_NEEQ:
            return 1;
        default:
            return 0;
    }
}

static int is_lvalue(Expr *e) {
    if (!e) return 0;
    if (e->kind == EX_VAR) return 1;
    if (e->kind == EX_INDEX) return 1;
    if (e->kind == EX_UNARY && e->as.unary.op == TK_STAR) return 1; // *p
    return 0;
}

static int is_unary(TokenKind k) {
    return (k == TK_MINUS || k == TK_BANG || k == TK_STAR || k == TK_AMP ||
            k == TK_PLUSPLUS || k == TK_MINUSMINUS);
}

static int precedence(TokenKind k) {
    switch (k) {
        case TK_BARBAR: return 2;   // logical OR
        case TK_EQ:
        case TK_NE:      return 3;
        case TK_LT:
        case TK_LE:
        case TK_GT:
        case TK_GE:      return 4;
        case TK_PLUS:
        case TK_MINUS:
        case TK_LSHIFT:
        case TK_RSHIFT:  return 5;
        case TK_STAR:
        case TK_SLASH:
        case TK_PERCENT: return 6;
        case TK_BAR:     return 7;   // bitwise OR
        case TK_AMP:     return 8;   // bitwise AND
        default:         return 0;
    }
}

TokenKind peek_next_kind(Parser *P){
    Lexer L2 = P->L;

    Arena *saved = g_compilation_arena;
    g_compilation_arena = NULL;

    Token t = lx_next(&L2);
    TokenKind k = t.kind;
    tok_free(&t);

    g_compilation_arena = saved;
    return k;
}

// ===================== AST + Parser (build nodes) =====================







Program *parse_program_ast(Parser *P) {
    Program *prog = (Program*)xmalloc(sizeof(*prog));
    prog->tops.data = NULL; prog->tops.len = 0; prog->tops.cap = 0;

    while (P->cur.kind != TK_EOF) {

        Top *t = (Top*)xmalloc(sizeof(*t));

        if (P->cur.kind == TK_EXTRN) {
            t->kind = TOP_EXTERN_DECL;
            t->as.ext_decl = parse_extern_decl(P);
        } else if (P->cur.kind == TK_AUTO) {
            t->kind = TOP_GAUTO;
            t->as.gauto = parse_auto_decl(P); // ST_AUTO
        } else if (P->cur.kind == TK_ID) {
            // Check if this is a function (name(...)) or external definition
            TokenKind next = peek_next_kind(P);
            int is_function = (next == TK_LPAREN);

            if (is_function) {
                t->kind = TOP_FUNC;
                t->as.fn = parse_function(P);
            } else {
                t->kind = TOP_EXTERN_DEF;
                t->as.ext_def = parse_extern_var_def(P);
            }
        } else {
            dief("unexpected token at top level: %s", tk_name(P->cur.kind));
        }
        vec_push(&prog->tops, t);
    }
    return prog;
}
Stmt *parse_auto_decl(Parser *P) {
    int line = P->cur.line, col = P->cur.col;
    expect(P, TK_AUTO);

    Stmt *s = new_stmt(ST_AUTO, line, col);
    s->as.autodecl.decls.data = NULL; s->as.autodecl.decls.len = 0; s->as.autodecl.decls.cap = 0;

    if (P->cur.kind != TK_ID) dief("expected identifier after auto at %d:%d", P->cur.line, P->cur.col);

    for (;;) {
        if (P->cur.kind != TK_ID) dief("expected identifier in auto decl at %d:%d", P->cur.line, P->cur.col);

        DeclItem *item = (DeclItem*)xmalloc(sizeof(DeclItem));
        if (!item) dief("out of memory");
        item->name = sdup(P->cur.lexeme);
        item->size = NULL;

        next(P);

        // Reject bracket syntax - B uses name constant, not name[constant]
        if (P->cur.kind == TK_LBRACK) {
            dief("B syntax error: use 'auto name constant' not 'auto name[constant]' at %d:%d", P->cur.line, P->cur.col);
        }

        // Check for vector syntax: name constant (B style, no brackets)
        if (P->cur.kind == TK_NUM) {
            item->size = new_expr(EX_NUM, P->cur.line, P->cur.col);
            item->size->as.num = P->cur.num;
            next(P);
        }

        vec_push(&s->as.autodecl.decls, item);

        if (accept(P, TK_COMMA)) continue;
        break;
    }

    expect(P, TK_SEMI);
    return s;
}
Func *parse_function(Parser *P) {
    if (P->cur.kind != TK_ID) dief("expected function name at %d:%d", P->cur.line, P->cur.col);
    Func *f = (Func*)xmalloc(sizeof(*f));
    f->name = sdup(P->cur.lexeme);
    f->params.data = NULL; f->params.len = 0; f->params.cap = 0;
    next(P);

    expect(P, TK_LPAREN);
    if (P->cur.kind != TK_RPAREN) {
        for (;;) {
            if (P->cur.kind != TK_ID) dief("expected parameter name at %d:%d", P->cur.line, P->cur.col);
            vec_push(&f->params, sdup(P->cur.lexeme));
            next(P);
            if (accept(P, TK_COMMA)) continue;
            break;
        }
    }
    expect(P, TK_RPAREN);

    f->body = parse_block(P);
    return f;
}
ExternItem *parse_extern_var_def(Parser *P){
    if (P->cur.kind != TK_ID) dief("expected identifier at %d:%d", P->cur.line, P->cur.col);

    ExternItem *it = xmalloc(sizeof(*it));
    if(!it) dief("out of memory");
    memset(it, 0, sizeof(*it));
    it->is_func = 0;  // variable definition
    it->is_implicit_static = 0; // explicit declaration
    it->name = sdup(P->cur.lexeme);
    next(P);

    // VECTOR: name[...]
    if (accept(P, TK_LBRACK)) {
        it->as.var.vkind = EXTVAR_VECTOR;

        if (accept(P, TK_RBRACK)) {
            it->as.var.has_empty = 1;   // []
        } else {
            it->as.var.bound = parse_expr(P);  // later: require const-foldable
            expect(P, TK_RBRACK);
        }

        if (P->cur.kind == TK_LBRACE) {
            it->as.var.init = parse_init_list(P);
        } else {
            // Check for B-style comma-separated initializers: name[const] ival, ival...
            it->as.var.init = parse_comma_init_list(P);
        }

        expect(P, TK_SEMI);
        return it;
    }

    // BLOB: name { ... }
    if (P->cur.kind == TK_LBRACE) {
        it->as.var.vkind = EXTVAR_BLOB;
        it->as.var.init  = parse_init_list(P);
        expect(P, TK_SEMI);
        return it;
    }

    // SCALAR: name;
    if (accept(P, TK_SEMI)) {
        it->as.var.vkind = EXTVAR_SCALAR;
        it->as.var.init  = NULL;
        return it;
    }

    // Optional: keep your extension "name = expr;"
    if (accept(P, TK_ASSIGN)) {
        it->as.var.vkind = EXTVAR_SCALAR;
        Init *in = new_init(INIT_EXPR, P->cur.line, P->cur.col);
        in->as.expr = parse_expr(P);
        it->as.var.init = in;
        expect(P, TK_SEMI);
        return it;
    }

    // B-style: name ival, ival... (comma-separated initializers)
    // This can be for scalars or vectors
    Init *comma_init = parse_comma_init_list(P);
    if (comma_init) {
        // If we have a vector, set the initializer
        if (it->as.var.vkind == EXTVAR_VECTOR) {
            it->as.var.init = comma_init;
        } else {
            // For scalars with multiple initializers, treat as blob
            it->as.var.vkind = EXTVAR_BLOB;
            it->as.var.init = comma_init;
        }
        expect(P, TK_SEMI);
        return it;
    }

    dief("bad external definition after '%s' at %d:%d", it->name, P->cur.line, P->cur.col);
    return NULL;
}
ExternItem *parse_extern_decl(Parser *P) {
    expect(P, TK_EXTRN);

    if (P->cur.kind != TK_ID) dief("expected identifier after extrn at %d:%d", P->cur.line, P->cur.col);

    ExternItem *item = (ExternItem*)xmalloc(sizeof(*item));
    if (!item) dief("out of memory");
    memset(item, 0, sizeof(*item));
    item->is_implicit_static = 0; // explicit declaration
    item->name = sdup(P->cur.lexeme);

    next(P);

    // Check for function syntax: extrn name(...)
    if (accept(P, TK_LPAREN)) {
        dief("extrn declarations are only allowed for variables, not functions at %d:%d", P->cur.line, P->cur.col);
    }

    {
        // Variable declaration
        item->is_func = 0;
        item->as.var.vkind = EXTVAR_SCALAR;  // default, may be updated below
        item->as.var.bound = NULL;
        item->as.var.has_empty = 0;
        item->as.var.bound_const = 0;
        item->as.var.init = NULL;  // declarations have no initializer

        // Check for vector syntax: extrn name[expr]
        if (accept(P, TK_LBRACK)) {
            item->as.var.vkind = EXTVAR_VECTOR;
            if (accept(P, TK_RBRACK)) {
                item->as.var.has_empty = 1;
            } else {
                item->as.var.bound = parse_expr(P);
                expect(P, TK_RBRACK);
            }
        }
    }

    expect(P, TK_SEMI);
    return item;
}
Stmt *parse_block(Parser *P) {
    int line = P->cur.line, col = P->cur.col;
    expect(P, TK_LBRACE);

    Vec *items = vec_new();
    while (P->cur.kind != TK_RBRACE) {
        if (P->cur.kind == TK_EOF) dief("unexpected EOF in block");
        vec_push(items, parse_stmt(P));
    }
    expect(P, TK_RBRACE);

    Stmt *b = new_stmt(ST_BLOCK, line, col);
    b->as.block.items = *items;
    return b;
}
Stmt *parse_if(Parser *P) {
    int line = P->cur.line, col = P->cur.col;
    expect(P, TK_IF);
    expect(P, TK_LPAREN);
    Expr *cond = parse_expr(P);
    expect(P, TK_RPAREN);

    Stmt *then_s = parse_stmt(P);
    Stmt *else_s = NULL;
    if (accept(P, TK_ELSE)) else_s = parse_stmt(P);

    Stmt *s = new_stmt(ST_IF, line, col);
    s->as.ifs.cond = cond;
    s->as.ifs.then_s = then_s;
    s->as.ifs.else_s = else_s;
    return s;
}
Stmt *parse_while(Parser *P) {
    int line = P->cur.line, col = P->cur.col;
    expect(P, TK_WHILE);
    expect(P, TK_LPAREN);
    Expr *cond = parse_expr(P);
    expect(P, TK_RPAREN);

    P->loop_depth++;
    Stmt *body = parse_stmt(P);
    P->loop_depth--;

    Stmt *s = new_stmt(ST_WHILE, line, col);
    s->as.whiles.cond = cond;
    s->as.whiles.body = body;
    return s;
}
Stmt *parse_return(Parser *P) {
    int line = P->cur.line, col = P->cur.col;
    expect(P, TK_RETURN);

    Expr *val = NULL;
    if (P->cur.kind != TK_SEMI) val = parse_expr(P);
    expect(P, TK_SEMI);

    Stmt *s = new_stmt(ST_RETURN, line, col);
    s->as.ret.val = val;
    return s;
}
Stmt *parse_extrn_stmt(Parser *P){
    int line=P->cur.line, col=P->cur.col;
    expect(P, TK_EXTRN);

    Stmt *s = new_stmt(ST_EXTRN, line, col);
    s->as.extrn.names.data=NULL; s->as.extrn.names.len=0; s->as.extrn.names.cap=0;

    if (P->cur.kind != TK_ID) dief("expected identifier after extrn at %d:%d", P->cur.line, P->cur.col);

    for(;;){
        if (P->cur.kind != TK_ID) dief("expected identifier in extrn at %d:%d", P->cur.line, P->cur.col);
        vec_push(&s->as.extrn.names, sdup(P->cur.lexeme));
        next(P);
        if (accept(P, TK_COMMA)) continue;
        break;
    }
    expect(P, TK_SEMI);
    return s;
}

static int64_t eval_const_expr(Expr *e) {
    if (!e) dief("internal: null const expr");

    switch (e->kind) {
    case EX_NUM:
        return (int64_t)e->as.num;

    case EX_UNARY: {
        int64_t v = eval_const_expr(e->as.unary.rhs);
        switch (e->as.unary.op) {
        case TK_MINUS: return -v;
        case TK_BANG:  return !v;
        default:
            dief("non-constant unary op in const expr at %d:%d", e->line, e->col);
            /* fallthrough */
        }
    }

    case EX_BINARY: {
        int64_t a = eval_const_expr(e->as.bin.lhs);
        int64_t b = eval_const_expr(e->as.bin.rhs);

        switch (e->as.bin.op) {
        case TK_PLUS: return a + b;
        case TK_MINUS: return a - b;
        case TK_STAR: return a * b;
        case TK_SLASH:
            if (b == 0) dief("division by zero in const expr at %d:%d", e->line, e->col);
            return a / b;
        case TK_PERCENT:
            if (b == 0) dief("mod by zero in const expr at %d:%d", e->line, e->col);
            return a % b;

        case TK_AMP: return a & b;
        case TK_BAR: return a | b;
        case TK_BARBAR: return (a != 0) || (b != 0) ? 1 : 0;

        case TK_EQ: return a == b;
        case TK_NE: return a != b;
        case TK_LT: return a < b;
        case TK_LE: return a <= b;
        case TK_GT: return a > b;
        case TK_GE: return a >= b;

        default:
            dief("non-constant binary op in const expr at %d:%d", e->line, e->col);
            /* fallthrough */
        }
    }

    default:
        dief("non-constant expression in const expr at %d:%d", e->line, e->col);
        return 0; // unreachable, but suppresses warning
}
}

static Stmt *parse_label(Parser *P) {
    int line = P->cur.line, col = P->cur.col;

    Expr *lab = parse_expr(P);
    expect(P, TK_COLON);

    // For now: restrict to identifier labels for C emission
    if (lab->kind != EX_VAR) {
        dief("label expression must be an identifier at %d:%d", line, col);
    }

    Stmt *inner = parse_stmt(P);

    Stmt *s = new_stmt(ST_LABEL, line, col);
    s->as.label_.name = sdup(lab->as.var);
    s->as.label_.stmt = inner;
    return s;
}

static Stmt *parse_goto(Parser *P) {
    int line = P->cur.line, col = P->cur.col;
    expect(P, TK_GOTO);

    if (P->cur.kind != TK_ID) dief("expected label after goto at %d:%d", P->cur.line, P->cur.col);
    char *target = sdup(P->cur.lexeme);
    next(P);

    expect(P, TK_SEMI);

    Stmt *s = new_stmt(ST_GOTO, line, col);
    s->as.goto_.target = target;
    return s;
}



static Expr *parse_paren_or_bare_expr(Parser *P) {
    if (accept(P, TK_LPAREN)) {
        Expr *e = parse_expr(P);
        expect(P, TK_RPAREN);
        return e;
    }
    return parse_expr(P);
}




Stmt *parse_case(Parser *P) {
    int line = P->cur.line, col = P->cur.col;
    expect(P, TK_CASE);

    if (P->switch_depth == 0)
        dief("case outside switch at %d:%d", line, col);

    Expr *a = parse_expr(P);
    int64_t val = eval_const_expr(a);

    expect(P, TK_COLON);

    Stmt *s = new_stmt(ST_CASE, line, col);
    s->as.case_.relop = TK_EOF;  // No relational operators in B
    s->as.case_.has_range = 0;   // No ranges in B
    s->as.case_.lo = val;
    s->as.case_.hi = val;
    return s;
}

Stmt *parse_default(Parser *P) {
    int line = P->cur.line, col = P->cur.col;
    expect(P, TK_DEFAULT);

    if (P->switch_depth == 0)
        dief("default outside switch at %d:%d", line, col);

    expect(P, TK_COLON);

    Stmt *s = new_stmt(ST_CASE, line, col);
    s->as.case_.relop = TK_EOF;
    s->as.case_.has_range = 0;
    s->as.case_.lo = -1;  // Special marker for default case
    s->as.case_.hi = -1;
    return s;
}


static Stmt *parse_switch(Parser *P) {
    int line = P->cur.line, col = P->cur.col;
    expect(P, TK_SWITCH);

    Expr *val = parse_paren_or_bare_expr(P);

    P->switch_depth++;
    Stmt *body = parse_stmt(P);
    P->switch_depth--;

    Stmt *s = new_stmt(ST_SWITCH, line, col);
    s->as.switch_.expr = val;
    s->as.switch_.body = body;
    return s;
}

Stmt *parse_stmt(Parser *P) {
    // label: ID ':' stmt
    if (P->cur.kind == TK_ID && peek_next_kind(P) == TK_COLON) {
        return parse_label(P);
    }

    if (accept(P, TK_SEMI)) {
        return new_stmt(ST_EMPTY, P->cur.line, P->cur.col);
    }

    switch (P->cur.kind) {
        case TK_LBRACE:  return parse_block(P);
        case TK_AUTO:    return parse_auto_decl(P);
        case TK_EXTRN:   return parse_extrn_stmt(P);
        case TK_IF:      return parse_if(P);
        case TK_WHILE:   return parse_while(P);
        case TK_RETURN:  return parse_return(P);

        case TK_GOTO:    return parse_goto(P);

        case TK_SWITCH:  return parse_switch(P);
        case TK_CASE:    return parse_case(P);
        case TK_DEFAULT: return parse_default(P);

        default: break;
    }

    int line = P->cur.line, col = P->cur.col;
    Expr *e = parse_expr(P);
    expect(P, TK_SEMI);

    Stmt *s = new_stmt(ST_EXPR, line, col);
    s->as.expr.e = e;
    return s;
}
Init *parse_init_elem(Parser *P);

Init *parse_init_list(Parser *P){
    int line=P->cur.line, col=P->cur.col;
    expect(P, TK_LBRACE);

    Init *in = new_init(INIT_LIST, line, col);
    in->as.list.data=NULL; in->as.list.len=0; in->as.list.cap=0;

    if (!accept(P, TK_RBRACE)) {
        for(;;){
            Init *e = parse_init_elem(P);
            vec_push(&in->as.list, e);
            if (accept(P, TK_COMMA)) continue;
            expect(P, TK_RBRACE);
            break;
        }
    }
    return in;
}

Init *parse_init_elem(Parser *P){
    if (P->cur.kind == TK_LBRACE) return parse_init_list(P);

    int line=P->cur.line, col=P->cur.col;
    Init *in = new_init(INIT_EXPR, line, col);

    // IMPORTANT: initializer element is ASSIGNMENT-expr, not comma-expr
    in->as.expr = parse_assignment(P);
    return in;
}

// Parse comma-separated initializers for B-style external definitions: ival, ival...
Init *parse_comma_init_list(Parser *P){
    int line=P->cur.line, col=P->cur.col;

    // Check if this looks like a comma initializer (starts with a valid initializer expression)
    // We need to be careful not to consume tokens if this isn't actually a comma list
    if (P->cur.kind == TK_NUM || P->cur.kind == TK_CHR || P->cur.kind == TK_STR ||
        P->cur.kind == TK_ID || P->cur.kind == TK_AMP || P->cur.kind == TK_STAR ||
        P->cur.kind == TK_LPAREN || P->cur.kind == TK_MINUS) {

        Init *in = new_init(INIT_LIST, line, col);
        in->as.list.data=NULL; in->as.list.len=0; in->as.list.cap=0;

        for(;;){
            Init *e = parse_init_elem(P);
            vec_push(&in->as.list, e);
            if (!accept(P, TK_COMMA)) break;
        }
        return in;
    }
    return NULL;
}
Expr *parse_primary(Parser *P) {
    int line = P->cur.line, col = P->cur.col;

    if (P->cur.kind == TK_NUM || P->cur.kind == TK_CHR) {
        Expr *e = new_expr(EX_NUM, line, col);
        e->as.num = P->cur.num;
        next(P);
        return e;
    }
    if (P->cur.kind == TK_STR) {
        Expr *e = new_expr(EX_STR, line, col);
        e->as.str = sdup(P->cur.lexeme);
        next(P);
        return e;
    }
    if (P->cur.kind == TK_ID) {
        Expr *e = new_expr(EX_VAR, line, col);
        e->as.var = sdup(P->cur.lexeme);
        next(P);
        return e;
    }
    if (accept(P, TK_LPAREN)) {
        Expr *e = parse_expr(P);     // allow comma operator inside ()
        expect(P, TK_RPAREN);
        return e;
    }

    error_at_code(&P->cur, P->source, ERR_EXPR_SYNTAX, NULL);
    return NULL;
}
Expr *parse_postfix(Parser *P) {
    Expr *e = parse_primary(P);

    for (;;) {
        // call: e '(' args ')'
        if (accept(P, TK_LPAREN)) {
            Expr *c = new_expr(EX_CALL, e->line, e->col);
            c->as.call.callee = e;
            c->as.call.args.data = NULL; c->as.call.args.len = 0; c->as.call.args.cap = 0;

            if (!accept(P, TK_RPAREN)) {
                for (;;) {
                    // IMPORTANT: argument is ASSIGNMENT-expr (no comma operator as separator)
                    Expr *arg = parse_assignment(P);
                    vec_push(&c->as.call.args, arg);

                    if (accept(P, TK_COMMA)) continue;
                    expect(P, TK_RPAREN);
                    break;
                }
            }
            e = c;
            continue;
        }

        // indexing: e '[' expr ']'
        if (accept(P, TK_LBRACK)) {
            Expr *idx = parse_expr(P);   // allow comma operator inside []
            expect(P, TK_RBRACK);

            Expr *ix = new_expr(EX_INDEX, e->line, e->col);
            ix->as.index.base = e;
            ix->as.index.idx = idx;
            e = ix;
            continue;
        }

        // postfix ++/--
        if (P->cur.kind == TK_PLUSPLUS || P->cur.kind == TK_MINUSMINUS) {
            TokenKind op = P->cur.kind;
            next(P);

            if (!is_lvalue(e)) {
                dief("postfix %s requires an lvalue at %d:%d", tk_name(op), e->line, e->col);
            }

            Expr *p = new_expr(EX_POST, e->line, e->col);
            p->as.post.op = op;
            p->as.post.lhs = e;
            e = p;
            continue;
        }

        break;
    }

    return e;
}
Expr *parse_unary(Parser *P) {
    int line = P->cur.line, col = P->cur.col;

    if (is_unary(P->cur.kind)) {
        TokenKind op = P->cur.kind;
        next(P);
        Expr *rhs = parse_unary(P);

        // prefix ++/-- require lvalue
        if ((op == TK_PLUSPLUS || op == TK_MINUSMINUS) && !is_lvalue(rhs)) {
            dief("prefix %s requires an lvalue at %d:%d", tk_name(op), line, col);
        }

        // & requires lvalue
        if (op == TK_AMP && !is_lvalue(rhs)) {
            dief("& requires an lvalue at %d:%d", line, col);
        }

        Expr *e = new_expr(EX_UNARY, line, col);
        e->as.unary.op = op;
        e->as.unary.rhs = rhs;
        return e;
    }

    return parse_postfix(P);
}
Expr *parse_bin_rhs(Parser *P, int min_prec, Expr *lhs) {
    for (;;) {
        int prec = precedence(P->cur.kind);
        if (prec < min_prec) return lhs;

        TokenKind op = P->cur.kind;
        next(P);

        Expr *rhs = parse_unary(P);

        int next_prec = precedence(P->cur.kind);
        if (next_prec > prec) {
            rhs = parse_bin_rhs(P, prec + 1, rhs);
        }

        Expr *b = new_expr(EX_BINARY, lhs->line, lhs->col);
        b->as.bin.op = op;
        b->as.bin.lhs = lhs;
        b->as.bin.rhs = rhs;
        lhs = b;
    }
}
static Expr *parse_conditional(Parser *P);

Expr *parse_assignment(Parser *P) {
    Expr *lhs = parse_conditional(P);

    if (is_assign_op(P->cur.kind)) {
        TokenKind op = P->cur.kind;
        next(P);

        if (!is_lvalue(lhs)) {
            dief("left side of '%s' must be an lvalue at %d:%d", tk_name(op), lhs->line, lhs->col);
        }

        Expr *rhs = parse_assignment(P);

        Expr *a = new_expr(EX_ASSIGN, lhs->line, lhs->col);
        a->as.assign.op = op;
        a->as.assign.lhs = lhs;
        a->as.assign.rhs = rhs;
        return a;
    }

    return lhs;
}

static Expr *parse_conditional(Parser *P) {
    Expr *e = parse_unary(P);
    e = parse_bin_rhs(P, 1, e);

    // Handle ternary operator: condition ? true_expr : false_expr
    if (accept(P, TK_QUESTION)) {
        Expr *true_expr = parse_assignment(P);  // assignment expressions allowed in branches
        expect(P, TK_COLON);
        Expr *false_expr = parse_assignment(P);

        Expr *ternary = new_expr(EX_TERNARY, e->line, e->col);
        ternary->as.ternary.cond = e;
        ternary->as.ternary.true_expr = true_expr;
        ternary->as.ternary.false_expr = false_expr;
        e = ternary;
    }

    return e;
}

Expr *parse_expr(Parser *P) {
    Expr *e = parse_assignment(P);

    while (accept(P, TK_COMMA)) {
        Expr *rhs = parse_assignment(P);
        Expr *c = new_expr(EX_COMMA, e->line, e->col);
        c->as.comma.lhs = e;
        c->as.comma.rhs = rhs;
        e = c;
    }

    return e;
}
