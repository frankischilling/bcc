// emitter.c - C code emitter

#include "bcc.h"

// ===================== String Pool for Thompson-Accurate Strings =====================

typedef struct {
    const char *str;
    int id;
} StringEntry;

static Vec string_pool;  // Vec<StringEntry>

static int get_string_id(const char *s) {
    for (size_t i = 0; i < string_pool.len; i++) {
        StringEntry *e = (StringEntry*)string_pool.data[i];
        if (strcmp(e->str, s) == 0) return e->id;
    }

    StringEntry *e = xmalloc(sizeof(StringEntry));
    e->str = sdup(s);
    e->id = (int)string_pool.len;
    vec_push(&string_pool, e);
    return e->id;
}

static void emit_string_pool(FILE *out) {
    for (size_t i = 0; i < string_pool.len; i++) {
        StringEntry *e = (StringEntry*)string_pool.data[i];
        const unsigned char *s = (const unsigned char*)e->str;

        size_t n = 0;
        while (s[n]) n++;                 // length excluding NUL

        size_t total_bytes = n + 1;       // +1 for 004 terminator
        size_t W = sizeof(intptr_t);       // bytes per word on this host (matches typedef)
        size_t words_needed = (total_bytes + W - 1) / W;

        fprintf(out, "static const word __b_str%zu[] = {", i);

        for (size_t wi = 0; wi < words_needed; wi++) {
            uintptr_t w = 0;
            for (size_t bi = 0; bi < W; bi++) {
                size_t byte_idx = wi * W + bi;
                unsigned char b;

                if (byte_idx < n)       b = s[byte_idx];
                else if (byte_idx == n) b = 004;
                else                    b = 0;

                w |= (uintptr_t)b << (8 * bi);
            }

            if (wi) fputc(',', out);
            fprintf(out, "0x%0*" PRIxPTR, (int)(W * 2), w);
        }

        fprintf(out, "};\n");
    }
}

// String collection prepass
static void collect_strings_expr(Expr *e);
static void collect_strings_init(Init *in);
static void collect_strings_stmt(Stmt *s);

static void collect_strings_expr(Expr *e) {
    if (!e) return;
    switch (e->kind) {
        case EX_STR:
            (void)get_string_id(e->as.str);
            return;
        case EX_CALL:
            collect_strings_expr(e->as.call.callee);
            for (size_t i = 0; i < e->as.call.args.len; i++)
                collect_strings_expr((Expr*)e->as.call.args.data[i]);
            return;
        case EX_INDEX:
            collect_strings_expr(e->as.index.base);
            collect_strings_expr(e->as.index.idx);
            return;
        case EX_UNARY:
            collect_strings_expr(e->as.unary.rhs);
            return;
        case EX_POST:
            collect_strings_expr(e->as.post.lhs);
            return;
        case EX_BINARY:
            collect_strings_expr(e->as.bin.lhs);
            collect_strings_expr(e->as.bin.rhs);
            return;
        case EX_ASSIGN:
            collect_strings_expr(e->as.assign.lhs);
            collect_strings_expr(e->as.assign.rhs);
            return;
        case EX_TERNARY:
            collect_strings_expr(e->as.ternary.cond);
            collect_strings_expr(e->as.ternary.true_expr);
            collect_strings_expr(e->as.ternary.false_expr);
            return;
        case EX_COMMA:
            collect_strings_expr(e->as.comma.lhs);
            collect_strings_expr(e->as.comma.rhs);
            return;
        default:
            return;
    }
}

static void collect_strings_init(Init *in) {
    if (!in) return;
    if (in->kind == INIT_EXPR) {
        collect_strings_expr(in->as.expr);
    } else if (in->kind == INIT_LIST) {
        for (size_t i = 0; i < in->as.list.len; i++)
            collect_strings_init((Init*)in->as.list.data[i]);
    }
}

static void collect_strings_stmt(Stmt *s) {
    if (!s) return;
    switch (s->kind) {
        case ST_BLOCK:
            for (size_t i = 0; i < s->as.block.items.len; i++)
                collect_strings_stmt((Stmt*)s->as.block.items.data[i]);
            return;
        case ST_IF:
            collect_strings_expr(s->as.ifs.cond);
            collect_strings_stmt(s->as.ifs.then_s);
            collect_strings_stmt(s->as.ifs.else_s);
            return;
        case ST_WHILE:
            collect_strings_expr(s->as.whiles.cond);
            collect_strings_stmt(s->as.whiles.body);
            return;
        case ST_RETURN:
            collect_strings_expr(s->as.ret.val);
            return;
        case ST_EXPR:
            collect_strings_expr(s->as.expr.e);
            return;
        case ST_SWITCH:
            collect_strings_expr(s->as.switch_.expr);
            collect_strings_stmt(s->as.switch_.body);
            return;
        case ST_LABEL:
            collect_strings_stmt(s->as.label_.stmt);
            return;
        case ST_CASE:
            // if your case holds exprs, add them here
            return;
        default:
            return;
    }
}

static void collect_strings_program(Program *prog) {
    for (size_t i = 0; i < prog->tops.len; i++) {
        Top *t = (Top*)prog->tops.data[i];
        if (t->kind == TOP_FUNC) {
            collect_strings_stmt(t->as.fn->body);
        } else if (t->kind == TOP_EXTERN_DEF) {
            ExternItem *it = t->as.ext_def;
            collect_strings_init(it->as.var.init);
            // also collect from bounds if those can contain expressions
            if (it->as.var.bound) collect_strings_expr(it->as.var.bound);
        } else if (t->kind == TOP_GAUTO) {
            collect_strings_stmt(t->as.gauto);
        }
    }
}

// ===================== C Emitter (walk AST) =====================

// Convert B-style assignment operators to C-style for code generation
static const char *assignment_op_to_c(TokenKind op) {
    switch (op) {
        case TK_ASSIGN: return "=";
        case TK_PLUSEQ: return "+=";
        case TK_MINUSEQ: return "-=";
        case TK_STAREQ: return "*=";
        case TK_SLASHEQ: return "/=";
        case TK_PERCENTEQ: return "%=";
        case TK_LSHIFTEQ: return "<<=";
        case TK_RSHIFTEQ: return ">>=";
        case TK_ANDEQ: return "&=";
        case TK_OREQ: return "|=";
        default: return tk_name(op);
    }
}

void emit_indent(FILE *out, int n) {
    for (int i = 0; i < n; i++) fputs("  ", out);
}

void emit_line_directive(FILE *out, int line, const char *filename) {
    if (!g_no_line && filename) {
        fprintf(out, "#line %d \"%s\"\n", line, filename);
    }
}

void emit_c_string(FILE *out, const char *s) {
    fputc('"', out);
    for (const unsigned char *p = (const unsigned char*)s; *p; p++) {
        unsigned char c = *p;
        if (c == '\\' || c == '"') { fputc('\\', out); fputc(c, out); }
        else if (c == '\n') fputs("\\n", out);
        else if (c == '\t') fputs("\\t", out);
        else if (c < 32) fprintf(out, "\\x%02x", c);
        else fputc(c, out);
    }
    fputc('"', out);
}

static int current_byteptr;
void emit_expr(FILE *out, Expr *e, const char *filename);

static int stmt_is_block(const Stmt *s) {
    return s && s->kind == ST_BLOCK;
}

// Check if expression is a complex lvalue (indexing or dereference, not simple variable)
static int is_complex_lvalue(Expr *e) {
    if (!e) return 0;
    return e->kind == EX_INDEX || (e->kind == EX_UNARY && e->as.unary.op == TK_STAR);
}

typedef enum { CTRL_LOOP, CTRL_SWITCH } CtrlKind;

typedef struct CtrlFrame {
    CtrlKind kind;
    const char *switch_end;   // only valid for CTRL_SWITCH
    struct CtrlFrame *prev;
} CtrlFrame;

static CtrlFrame *g_ctrl = NULL;


typedef struct {
    Stmt *node;
    char *label;
} CaseMap;

static int g_switch_id = 0;

static const char *lookup_case_label(Vec *maps, Stmt *node) {
    for (size_t i = 0; i < maps->len; i++) {
        CaseMap *m = maps->data[i];
        if (m->node == node) return m->label;
    }
    return NULL;
}

static void collect_cases(Stmt *s, Vec *cases) {
    if (!s) return;

    switch (s->kind) {
        case ST_SWITCH:
            // do not descend into nested switches
            return;

        case ST_CASE:
            vec_push(cases, s);
            // case statements don't have bodies to collect from
            return;

        case ST_LABEL:
            collect_cases(s->as.label_.stmt, cases);
            return;

        case ST_BLOCK:
            for (size_t i = 0; i < s->as.block.items.len; i++)
                collect_cases(s->as.block.items.data[i], cases);
            return;

        case ST_IF:
            collect_cases(s->as.ifs.then_s, cases);
            collect_cases(s->as.ifs.else_s, cases);
            return;

        case ST_WHILE:
            collect_cases(s->as.whiles.body, cases);
            return;

        default:
            return;
    }
}

// Switch-body emitter (so case/default emit internal labels)
static void emit_stmt_switchctx(FILE *out, Stmt *s, int indent, Vec *maps, const char *filename);

static void emit_stmt_switchctx(FILE *out, Stmt *s, int indent, Vec *maps, const char *filename) {
    if (!s) return;

    switch (s->kind) {
        case ST_CASE: {
            const char *lab = lookup_case_label(maps, s);
            emit_indent(out, indent);
            fprintf(out, "%s:\n", lab);
            emit_indent(out, indent + 1);
            fputs(";\n", out);
            // case statements don't have bodies to emit
            return;
        }

        case ST_LABEL:
            emit_indent(out, indent);
            fprintf(out, "%s:\n", s->as.label_.name);
            emit_indent(out, indent + 1);
            fputs(";\n", out);
            emit_stmt_switchctx(out, s->as.label_.stmt, indent + 1, maps, filename);
            return;

        case ST_BLOCK:
            emit_indent(out, indent);
            fputs("{\n", out);
            for (size_t i = 0; i < s->as.block.items.len; i++)
                emit_stmt_switchctx(out, s->as.block.items.data[i], indent + 1, maps, filename);
            emit_indent(out, indent);
            fputs("}\n", out);
            return;

        case ST_IF:
            emit_indent(out, indent);
            fputs("if (", out);
            emit_expr(out, s->as.ifs.cond, filename);
            fputs(")\n", out);
            emit_stmt_switchctx(out, s->as.ifs.then_s,
                                stmt_is_block(s->as.ifs.then_s) ? indent : indent + 1, maps, filename);
            if (s->as.ifs.else_s) {
                emit_indent(out, indent);
                fputs("else\n", out);
                emit_stmt_switchctx(out, s->as.ifs.else_s,
                                    stmt_is_block(s->as.ifs.else_s) ? indent : indent + 1, maps, filename);
            }
            return;

        case ST_WHILE:
        case ST_SWITCH:
            // nested constructs: let normal emitter handle them
            emit_stmt(out, s, indent, 0, filename);
            return;

        default:
            emit_stmt(out, s, indent, 0, filename);
            return;
    }
}

static void emit_switch(FILE *out, Stmt *s, int indent, const char *filename) {
    int sid = ++g_switch_id;
    // fprintf(stderr, "DEBUG: emit_switch sid=%d\n", sid);

    Vec *cases = vec_new();
    Vec *maps  = vec_new();

    collect_cases(s->as.switch_.body, cases);

    // assign labels
    for (size_t i = 0; i < cases->len; i++) {
        CaseMap *m = xmalloc(sizeof(*m));
        m->node = cases->data[i];
        char buf[128];
        snprintf(buf, sizeof(buf), "__bsw%d_case%zu", sid, i);
        size_t label_len = strlen(buf);
        m->label = arena_xstrdup_range(g_compilation_arena, buf, 0, label_len);
        //fprintf(stderr, "DEBUG: created label '%s' for case %zu, sid=%d\n", m->label, i, sid);
        vec_push(maps, m);
    }

    emit_indent(out, indent);
    fputs("for(;;) {\n", out);

    emit_indent(out, indent + 1);
    fputs("word __sw = ", out);
    emit_expr(out, s->as.switch_.expr, filename);
    fputs(";\n", out);

        char end_label_buf[64];
        snprintf(end_label_buf, sizeof(end_label_buf), "__bsw%d_end", sid);
        char *end_label = end_label_buf;

    emit_indent(out, indent + 1);
    fprintf(out, "goto __bsw%d_dispatch;\n", sid);

    // body (contains labels)
    CtrlFrame frame = { CTRL_SWITCH, end_label, g_ctrl };
    g_ctrl = &frame;
    emit_stmt_switchctx(out, s->as.switch_.body, indent + 1, maps, filename);
    g_ctrl = frame.prev;

    emit_indent(out, indent + 1);
    fprintf(out, "goto __bsw%d_end;\n", sid);

    emit_indent(out, indent + 1);
    fprintf(out, "__bsw%d_dispatch:\n", sid);

    // dispatch in source order
    for (size_t i = 0; i < cases->len; i++) {
        Stmt *cs = cases->data[i];
        const char *lab = lookup_case_label(maps, cs);

        emit_indent(out, indent + 2);
        fputs("if (", out);

        if (cs->as.case_.relop != TK_EOF) {
            // bound case: < <= > >=
            const char *op = NULL;
            switch (cs->as.case_.relop) {
            case TK_LT: op = "<"; break;
            case TK_LE: op = "<="; break;
            case TK_GT: op = ">"; break;
            case TK_GE: op = ">="; break;
            default: op = "??"; break;
            }
            fprintf(out, "__sw %s (word)%" PRId64 "", op, (int64_t)cs->as.case_.lo);
        } else if (cs->as.case_.has_range) {
            fprintf(out,
                "(__sw >= (word)%" PRId64 " && __sw <= (word)%" PRId64 ")",
                (int64_t)cs->as.case_.lo, (int64_t)cs->as.case_.hi);
        } else {
            fprintf(out, "__sw == (word)%" PRId64 "", (int64_t)cs->as.case_.lo);
        }

        fputs(") goto ", out);
        fputs(lab, out);
        fputs(";\n", out);
    }

    // no-match: go to end
    emit_indent(out, indent + 2);
    fprintf(out, "goto __bsw%d_end;\n", sid);

    emit_indent(out, indent + 1);
    fprintf(out, "__bsw%d_end:\n", sid);

    emit_indent(out, indent + 2);
    fputs("break;\n", out);

    emit_indent(out, indent);
    fputs("}\n", out);
}



void emit_expr(FILE *out, Expr *e, const char *filename) {
    // Don't emit line directives in the middle of expressions
    // They should only be at statement boundaries
    switch (e->kind) {
        case EX_NUM:
            fprintf(out, "((word)%ld)", e->as.num);
            return;
        case EX_STR: {
            int id = get_string_id(e->as.str);
            fprintf(out, "((word)((uword)&__b_str%d / sizeof(word)))", id);
            return;
        }
        case EX_VAR: fputs(e->as.var, out); return;

        case EX_CALL: {
            // Check if callee is a builtin function that needs b_ prefix
            if (e->as.call.callee->kind == EX_VAR) {
                const char *name = e->as.call.callee->as.var;
                // List of builtin functions that have b_ versions
                const char *b_funcs[] = {
                    "char", "lchar", "getchr", "putchr", "printf", "printn", "putnum", "exit",
                    "open", "close", "read", "write", "creat", "seek",
                    "fork", "wait", "execl", "execv",
                    "chdir", "chmod", "chown", "link", "unlink", "stat", "fstat",
                    "time", "ctime", "getuid", "setuid", "makdir", "intr",
                    "argc", "argv",
                    NULL
                };
                for (int i = 0; b_funcs[i]; i++) {
                    if (strcmp(name, b_funcs[i]) == 0) {
                        fputs("b_", out);
                        break;
                    }
                }
            }
            emit_expr(out, e->as.call.callee, filename);
            fputc('(', out);
            for (size_t i = 0; i < e->as.call.args.len; i++) {
                if (i) fputs(", ", out);
                emit_expr(out, (Expr*)e->as.call.args.data[i], filename);
            }
            fputc(')', out);
            return;
        }

        case EX_INDEX: {
            fputs("B_INDEX(", out);
            emit_expr(out, e->as.index.base, filename);
            fputs(", ", out);
            emit_expr(out, e->as.index.idx, filename);
            fputc(')', out);
            return;
        }

        case EX_UNARY: {
            TokenKind op = e->as.unary.op;

            if (op == TK_STAR) {
                fputs("B_DEREF(", out);
                emit_expr(out, e->as.unary.rhs, filename);
                fputc(')', out);
                return;
            }
            if (op == TK_AMP) {
                // Special case: &arr[i] should give address of array element
                if (e->as.unary.rhs->kind == EX_INDEX) {
                    // For &arr[i], compute the address that arr[i] would access
                    // In word addressing mode: (arr + i) * sizeof(word)
                    // In byte addressing mode: arr + i * sizeof(word)
                    fputs("B_PTR(", out);
                    if (current_byteptr) {
                        // Byte addressing: arr + i * sizeof(word)
                        fputs("(uword)(", out);
                        emit_expr(out, e->as.unary.rhs->as.index.base, filename);
                        fputs(") + (uword)(", out);
                        emit_expr(out, e->as.unary.rhs->as.index.idx, filename);
                        fputs(") * sizeof(word)", out);
                    } else {
                        // Word addressing: (arr + i) * sizeof(word)
                        fputs("((uword)(", out);
                        emit_expr(out, e->as.unary.rhs->as.index.base, filename);
                        fputs(") + (uword)(", out);
                        emit_expr(out, e->as.unary.rhs->as.index.idx, filename);
                        fputs(")) * sizeof(word)", out);
                    }
                    fputc(')', out);
                } else {
                    fputs("B_ADDR(", out);
                    emit_expr(out, e->as.unary.rhs, filename);
                    fputc(')', out);
                }
                return;
            }

            /* keep the rest normal, but parenthesize to avoid precedence surprises */
            if (op == TK_PLUSPLUS || op == TK_MINUSMINUS) {
                Expr *rhs = e->as.unary.rhs;
                if (is_complex_lvalue(rhs)) {
                    // Use helper function to avoid double evaluation
                    fputs("b_", out);
                    fputs(op == TK_PLUSPLUS ? "preinc" : "predec", out);
                    fputs("(&(", out);
                    emit_expr(out, rhs, filename);
                    fputs("))", out);
                } else {
                    fputs(tk_name(op), out);
                    fputc('(', out);
                    emit_expr(out, rhs, filename);
                    fputc(')', out);
                }
                return;
            }

            fputc('(', out);
            fputs(tk_name(op), out);
            fputc('(', out);
            emit_expr(out, e->as.unary.rhs, filename);
            fputs("))", out);
            return;
        }

        case EX_POST: {
            // postfix ops
            TokenKind op = e->as.post.op;
            Expr *lhs = e->as.post.lhs;
            if (is_complex_lvalue(lhs)) {
                // Use helper function to avoid double evaluation
                fputs("b_", out);
                fputs(op == TK_PLUSPLUS ? "postinc" : "postdec", out);
                fputs("(&(", out);
                emit_expr(out, lhs, filename);
                fputs("))", out);
            } else {
                fputc('(', out);
                emit_expr(out, lhs, filename);
                fputs(tk_name(op), out);
                fputc(')', out);
            }
            return;
        }

        case EX_BINARY: {
            TokenKind op = e->as.bin.op;
            // For arithmetic operations that should wrap at 16 bits (B semantics)
            if (op == TK_STAR || op == TK_PLUS || op == TK_MINUS || op == TK_LSHIFT || op == TK_RSHIFT) {
                const char *cop;
                switch (op) {
                    case TK_STAR: cop = "*"; break;
                    case TK_PLUS: cop = "+"; break;
                    case TK_MINUS: cop = "-"; break;
                    case TK_LSHIFT: cop = "<<"; break;
                    case TK_RSHIFT: cop = ">>"; break;
                    default: cop = "?"; break;
                }
                fputs("(word)(int16_t)((uint16_t)(", out);
                emit_expr(out, e->as.bin.lhs, filename);
                fprintf(out, ") %s (uint16_t)(", cop);
                emit_expr(out, e->as.bin.rhs, filename);
                fputs("))", out);
            } else {
                fputc('(', out);
                emit_expr(out, e->as.bin.lhs, filename);
                fprintf(out, " %s ", tk_name(op));
                emit_expr(out, e->as.bin.rhs, filename);
                fputc(')', out);
            }
            return;
        }

        case EX_ASSIGN: {
            TokenKind op = e->as.assign.op;
            Expr *lhs = e->as.assign.lhs;
            Expr *rhs = e->as.assign.rhs;

            // Handle relational assignments: x =< y becomes x = (x < y), etc.
            TokenKind rel_op = TK_EOF;  // invalid default
            switch (op) {
            case TK_LTEQ: rel_op = TK_LT; break;
            case TK_LEEQ: rel_op = TK_LE; break;
            case TK_GTEQ: rel_op = TK_GT; break;
            case TK_GEEQ: rel_op = TK_GE; break;
            case TK_EQEQ: rel_op = TK_EQ; break;
            case TK_NEEQ: rel_op = TK_NE; break;
            default: break;
            }
            if (rel_op != TK_EOF) {
                // Relational assignment: lhs = (lhs rel_op rhs)
                fputc('(', out);
                emit_expr(out, lhs, filename);
                fputs(" = (", out);
                emit_expr(out, lhs, filename);
                fprintf(out, " %s ", tk_name(rel_op));
                emit_expr(out, rhs, filename);
                fputs("))", out);
                return;
            }

            // For compound assignments on complex lvalues, use helper function to avoid double evaluation
            if (op != TK_ASSIGN && is_complex_lvalue(lhs)) {
                const char *helper_name = NULL;
                switch (op) {
                case TK_PLUSEQ: helper_name = "add_assign"; break;
                case TK_MINUSEQ: helper_name = "sub_assign"; break;
                case TK_STAREQ: helper_name = "mul_assign"; break;
                case TK_SLASHEQ: helper_name = "div_assign"; break;
                case TK_PERCENTEQ: helper_name = "mod_assign"; break;
                case TK_LSHIFTEQ: helper_name = "lsh_assign"; break;
                case TK_RSHIFTEQ: helper_name = "rsh_assign"; break;
                case TK_ANDEQ: helper_name = "and_assign"; break;
                case TK_OREQ: helper_name = "or_assign"; break;
                default: break;
                }
                if (helper_name) {
                    fputs("b_", out);
                    fputs(helper_name, out);
                    fputs("(&(", out);
                    emit_expr(out, lhs, filename);
                    fputs("), ", out);
                    emit_expr(out, rhs, filename);
                    fputc(')', out);
                } else {
                    // Fallback for any missing helpers
                    fputc('(', out);
                    emit_expr(out, lhs, filename);
                    fprintf(out, " %s ", assignment_op_to_c(op));
                    emit_expr(out, rhs, filename);
                    fputc(')', out);
                }
            } else {
                fputc('(', out);
                emit_expr(out, lhs, filename);
                fprintf(out, " %s ", assignment_op_to_c(op));
                emit_expr(out, rhs, filename);
                fputc(')', out);
            }
            return;
        }

        case EX_TERNARY:
            fputc('(', out);
            emit_expr(out, e->as.ternary.cond, filename);
            fputs(" ? ", out);
            emit_expr(out, e->as.ternary.true_expr, filename);
            fputs(" : ", out);
            emit_expr(out, e->as.ternary.false_expr, filename);
            fputc(')', out);
            return;

        case EX_COMMA:
            fputc('(', out);
            emit_expr(out, e->as.comma.lhs, filename);
            fputs(", ", out);
            emit_expr(out, e->as.comma.rhs, filename);
            fputc(')', out);
            return;
    }
}

void emit_ival_expr(FILE *out, Expr *e, const char *filename){
    if (e->kind == EX_VAR) {
        fputs("B_ADDR(", out);
        fputs(e->as.var, out);
        fputc(')', out);
        return;
    }
    // everything else uses your normal emit_expr
    emit_expr(out, e, filename);
}

size_t init_list_length(Init *in) {
    if (!in || in->kind != INIT_LIST) return 0;
    return in->as.list.len;
}

// ---- constant folding (small but useful) ----
int try_eval_const_expr(Expr *e, long *out) {
    if (!e) return 0;
    switch (e->kind) {
        case EX_NUM:
            *out = e->as.num;
            return 1;
        case EX_UNARY: {
            long v = 0;
            if (!try_eval_const_expr(e->as.unary.rhs, &v)) return 0;
            switch (e->as.unary.op) {
                case TK_MINUS: *out = -v; return 1;
                case TK_BANG:  *out = (!v); return 1;
                default: return 0; // *, &, ++, -- not foldable here
            }
        }
        case EX_BINARY: {
            long a = 0, b = 0;
            if (!try_eval_const_expr(e->as.bin.lhs, &a)) return 0;
            if (!try_eval_const_expr(e->as.bin.rhs, &b)) return 0;
            switch (e->as.bin.op) {
                case TK_PLUS:    *out = (long)((unsigned long)a + (unsigned long)b); return 1;
                case TK_MINUS:   *out = (long)((unsigned long)a - (unsigned long)b); return 1;
                case TK_STAR:    *out = (long)((unsigned long)a * (unsigned long)b); return 1;
                case TK_SLASH:   if (b == 0) return 0; *out = a / b; return 1;
                case TK_PERCENT: if (b == 0) return 0; *out = a % b; return 1;
                case TK_LT:      *out = (a <  b); return 1;
                case TK_LE:      *out = (a <= b); return 1;
                case TK_GT:      *out = (a >  b); return 1;
                case TK_GE:      *out = (a >= b); return 1;
                case TK_EQ:      *out = (a == b); return 1;
                case TK_NE:      *out = (a != b); return 1;
                case TK_AMP:     *out = a & b; return 1;
                case TK_BAR:     *out = a | b; return 1;
                case TK_BARBAR: *out = (a != 0) || (b != 0) ? 1 : 0; return 1;
                default: return 0;
            }
        }
        case EX_COMMA: {
            // fold comma by folding RHS (after folding LHS for validity)
            long tmp = 0;
            if (!try_eval_const_expr(e->as.comma.lhs, &tmp)) return 0;
            return try_eval_const_expr(e->as.comma.rhs, out);
        }
        default:
            return 0;
    }
}

// ---- edge vectors (nested { ... } inside initializers) ----
size_t nested_base_len(Init *list) {
    // Nested edge vectors need a real address even if empty: reserve 1 word.
    if (!list || list->kind != INIT_LIST) return 0;
    return list->as.list.len ? list->as.list.len : 1;
}

size_t edge_words_total(Init *list) {
    // Total words needed to represent this list as a subvector, including all nested subvectors.
    if (!list || list->kind != INIT_LIST) return 0;
    size_t total = nested_base_len(list);
    for (size_t i = 0; i < list->as.list.len; i++) {
        Init *e = (Init*)list->as.list.data[i];
        if (e && e->kind == INIT_LIST) total += edge_words_total(e);
    }
    return total;
}

size_t edge_tail_words_top(Init *root) {
    // Tail words needed beyond the root list slots: sum of nested subvector allocations.
    if (!root || root->kind != INIT_LIST) return 0;
    size_t tail = 0;
    for (size_t i = 0; i < root->as.list.len; i++) {
        Init *e = (Init*)root->as.list.data[i];
        if (e && e->kind == INIT_LIST) tail += edge_words_total(e);
    }
    return tail;
}

size_t emit_edge_list_init(FILE *out, const char *arr,
                                  size_t base, Init *list,
                                  size_t cursor, int indent, const char *filename) {
    if (!list || list->kind != INIT_LIST) return cursor;
    for (size_t j = 0; j < list->as.list.len; j++) {
        Init *elem = (Init*)list->as.list.data[j];
        if (!elem) continue;

        if (elem->kind == INIT_EXPR) {
            emit_indent(out, indent);
            fprintf(out, "%s[%zu] = ", arr, base + j);
            emit_ival_expr(out, elem->as.expr, filename);
            fputs(";\n", out);
        } else if (elem->kind == INIT_LIST) {
            size_t sub_base = cursor;
            size_t sub_bl   = nested_base_len(elem);

            // parent slot gets pointer to the subvector start
            emit_indent(out, indent);
            fprintf(out, "%s[%zu] = B_ADDR(%s[%zu]);\n", arr, base + j, arr, sub_base);

            // recursively init the subvector in-place; its own tail starts after its base len
            size_t sub_cursor = sub_base + sub_bl;
            cursor = emit_edge_list_init(out, arr, sub_base, elem, sub_cursor, indent, filename);

            // ensure we advance by the full reserved size (esp. empty lists)
            size_t need_end = sub_base + edge_words_total(elem);
            if (cursor < need_end) cursor = need_end;
        }
    }
    return cursor;
}

void emit_stmt(FILE *out, Stmt *s, int indent, int is_function_body, const char *filename);

void emit_stmt(FILE *out, Stmt *s, int indent, int is_function_body, const char *filename) {
    emit_line_directive(out, s->line, filename);
    switch (s->kind) {
        case ST_EMPTY:
            emit_indent(out, indent); fputs(";\n", out); return;

        case ST_BLOCK: {
            emit_indent(out, indent); fputs("{\n", out);
            for (size_t i = 0; i < s->as.block.items.len; i++) {
                int is_last_in_function = is_function_body && (i == s->as.block.items.len - 1);
                Stmt *stmt = (Stmt*)s->as.block.items.data[i];
                if (is_last_in_function && stmt->kind == ST_EXPR) {
                    // Implicit return: last expression in function body
                    emit_line_directive(out, stmt->line, filename);
                    emit_indent(out, indent + 1);
                    fputs("return ", out);
                    emit_expr(out, stmt->as.expr.e, filename);
                    fputs(";\n", out);
                } else {
                    // Pass is_function_body to the last statement so implicit returns work in nested constructs
                    int stmt_is_function_body = is_last_in_function ? is_function_body : 0;
                    emit_stmt(out, stmt, indent + 1, stmt_is_function_body, filename);
                }
            }
            emit_indent(out, indent); fputs("}\n", out);
            return;
        }

        case ST_AUTO: {
            for (size_t i = 0; i < s->as.autodecl.decls.len; i++) {
                DeclItem *item = (DeclItem*)s->as.autodecl.decls.data[i];

                if (item->size) {
                    // Vector: emit backing storage
                    emit_indent(out, indent);
                    fprintf(out, "word __%s_store[(", item->name);
                    emit_expr(out, item->size, filename);
                    fprintf(out, ") + 1];\n"); // B bound is last index

                    // Emit pointer variable
                    emit_indent(out, indent);
                    fprintf(out, "word %s;\n", item->name);

                    // Emit initialization (will be moved to init function later)
                    emit_indent(out, indent);
                    fprintf(out, "%s = B_ADDR(__%s_store[0]);\n", item->name, item->name);
                } else {
                    // Simple variable
                    emit_indent(out, indent);
                    fprintf(out, "word %s;\n", item->name);
                }
            }
            return;
        }

        case ST_IF: {
            emit_indent(out, indent); fputs("if (", out);
            emit_expr(out, s->as.ifs.cond, filename);
            fputs(")\n", out);

            // If this if is the last statement in a function and has no else,
            // treat the then branch as if it's in a function body for implicit returns
            int then_is_function_body = is_function_body && !s->as.ifs.else_s;
            int then_ind = stmt_is_block(s->as.ifs.then_s) ? indent : indent + 1;
            emit_stmt(out, s->as.ifs.then_s, then_ind, then_is_function_body, filename);

            if (s->as.ifs.else_s) {
                emit_indent(out, indent); fputs("else\n", out);
                int else_ind = stmt_is_block(s->as.ifs.else_s) ? indent : indent + 1;
                emit_stmt(out, s->as.ifs.else_s, else_ind, 0, filename);
            }
            return;
        }

        case ST_WHILE: {
            emit_indent(out, indent); fputs("while (", out);
            emit_expr(out, s->as.whiles.cond, filename);
            fputs(")\n", out);

            int body_ind = stmt_is_block(s->as.whiles.body) ? indent : indent + 1;
            emit_stmt(out, s->as.whiles.body, body_ind, 0, filename);
            return;
        }

        case ST_RETURN:
            emit_indent(out, indent); fputs("return", out);
            if (s->as.ret.val) { fputc(' ', out); emit_expr(out, s->as.ret.val, filename); }
            fputs(";\n", out);
            return;

        case ST_EXPR:
            emit_indent(out, indent);
            if (is_function_body) {
                // Implicit return: expression in function body position
                fputs("return ", out);
            }
            emit_expr(out, s->as.expr.e, filename);
            fputs(";\n", out);
            return;

        case ST_EXTRN:
            // extrn declarations - emit as extern declarations
            for (size_t i = 0; i < s->as.extrn.names.len; i++) {
                emit_indent(out, indent);
                fprintf(out, "extern word %s;\n", (char*)s->as.extrn.names.data[i]);
            }
            return;

        case ST_GOTO:
            emit_indent(out, indent);
            fprintf(out, "goto %s;\n", s->as.goto_.target);
            return;

        case ST_SWITCH:
            emit_switch(out, s, indent, filename);
            return;

        case ST_LABEL:
            emit_indent(out, indent);
            fprintf(out, "%s:\n", s->as.label_.name);
            emit_indent(out, indent + 1);
            fputs(";\n", out);
            emit_stmt(out, s->as.label_.stmt, indent + 1, 0, filename);
            return;

        case ST_CASE:
            // These are internal-only: if they ever reach emit_stmt() directly, that's a bug.
            dief("ST_CASE should not reach emit_stmt directly");
            return;
    }
}

// Forward declaration for assembly emitter
void emit_program_asm(FILE *out, Program *prog);

void emit_program_c(FILE *out, Program *prog, const char *filename, int byteptr, int no_line) {
    current_byteptr = byteptr;
    string_pool.data = NULL;
    string_pool.len = 0;
    string_pool.cap = 0;

    collect_strings_program(prog);
    fputs(
        "#include <stdio.h>\n"
        "#include <stdlib.h>\n"
        "#include <stdint.h>\n"
        "#include <inttypes.h>\n"
        "#include <stdarg.h>\n"
        "#include <string.h>\n"
        "#include <time.h>\n"
        "#include <unistd.h>\n"
        "#include <sys/stat.h>\n"
        "#include <sys/types.h>\n"
        "#include <fcntl.h>\n"
        "#include <sys/wait.h>\n"
        "#include <signal.h>\n"
        "#include <termios.h>\n"
        "#include <sys/ioctl.h>\n"
        "\n"
        "typedef intptr_t  word;\n"
        "typedef uintptr_t uword;\n"
        "\n"
        "/*\n"
        "  Pointer model:\n"
        "    B_BYTEPTR=1  -> pointers are byte addresses (matches your formulas)\n"
        "    B_BYTEPTR=0  -> pointers are word addresses (closer to Thompson B: E1[E2]==*(E1+E2))\n"
        "*/\n",
        out
    );
    fprintf(out, "#define B_BYTEPTR %d\n", byteptr ? 1 : 0);
    fputs(
        "#if B_BYTEPTR\n"
        "  #define B_DEREF(p)   (*(word*)(uword)(p))\n"
        "  #define B_ADDR(x)    B_PTR(&(x))\n"
        "  #define B_INDEX(a,i) (*(word*)(uword)((uword)(a) + (uword)(i)*sizeof(word)))\n"
        "  #define B_PTR(p)     ((word)(uword)(p))\n"
        "#else\n"
        "  #define B_DEREF(p)   (*(word*)(uword)((uword)(p) * sizeof(word)))\n"
        "  #define B_ADDR(x)    B_PTR(&(x))\n"
        "  #define B_INDEX(a,i) B_DEREF((a) + (i))\n"
        "  #define B_PTR(p)     ((word)((uword)(p) / sizeof(word)))\n"
        "#endif\n"
        "\n"
        "#define B_STR(s)     B_PTR((const char*)(s))\n"
        "\n"
        "/* Convert B pointer (word) to C pointer */\n"
        "#if B_BYTEPTR\n"
        "  #define B_CPTR(p) ((void*)(uword)(p))\n"
        "#else\n"
        "  #define B_CPTR(p) ((void*)((uword)(p) * sizeof(word)))\n"
        "#endif\n"
        "\n"
        "static word b_print(word x){ printf(\"%\" PRIdPTR \"\\n\", (intptr_t)x); return x; }\n"
        "static word b_putchar(word x){ putchar((int)x); return x; }\n"
        "static word b_getchar(void){ return (word)getchar(); }\n"
        "static word b_exit(void){ exit(0); return 0; }\n"
        "\n"
        "/* Command line argument support */\n"
        "static int __b_argc;\n"
        "static char **__b_argv;\n"
        "\n"
        "/* argv strings converted to B strings (packed words, 004 terminator) */\n"
        "static word *__b_argvb;\n"
        "\n"
        "static void __b_setargs(int argc, char **argv);\n"
        "static word b_argc(void);\n"
        "static word b_argv(word i);\n"
        "\n"
        "/* Helper functions for complex lvalue operations (avoid GNU C extensions) */\n"
        "static word b_preinc(word *p) { return (*p = (word)(((uword)*p + 1) & 0xFFFF)); }\n"
        "static word b_predec(word *p) { return (*p = (word)(((uword)*p - 1) & 0xFFFF)); }\n"
        "static word b_postinc(word *p) { word old = *p; *p = (word)(((uword)*p + 1) & 0xFFFF); return old; }\n"
        "static word b_postdec(word *p) { word old = *p; *p = (word)(((uword)*p - 1) & 0xFFFF); return old; }\n"
        "static word b_add_assign(word *p, word v) { return (*p = (word)(((uword)*p + (uword)v) & 0xFFFF)); }\n"
        "static word b_sub_assign(word *p, word v) { return (*p = (word)(((uword)*p - (uword)v) & 0xFFFF)); }\n"
        "static word b_mul_assign(word *p, word v) { return (*p = (word)(((uword)*p * (uword)v) & 0xFFFF)); }\n"
        "static word b_div_assign(word *p, word v) { return (*p = (word)(((uword)*p / (uword)v) & 0xFFFF)); }\n"
        "static word b_mod_assign(word *p, word v) { return (*p = (word)(((uword)*p % (uword)v) & 0xFFFF)); }\n"
        "static word b_lsh_assign(word *p, word v) { return (*p = (word)(((uword)*p << (uword)v) & 0xFFFF)); }\n"
        "static word b_rsh_assign(word *p, word v) { return (*p = (word)(((uword)*p >> (uword)v) & 0xFFFF)); }\n"
        "static word b_and_assign(word *p, word v) { return (*p = (word)((uword)*p & (uword)v)); }\n"
        "static word b_or_assign(word *p, word v) { return (*p = (word)((uword)*p | (uword)v)); }\n"
        "static word b_xor_assign(word *p, word v) { return (*p = (word)((uword)*p ^ (uword)v)); }\n"
        "\n"
        "static word b_alloc(word nwords){\n"
        "    size_t bytes = (size_t)nwords * sizeof(word);\n"
        "    void *p = malloc(bytes);\n"
        "    if (!p) { fprintf(stderr, \"alloc: out of memory\\n\"); exit(1); }\n"
        "    return B_PTR(p);\n"
        "}\n"
        "\n"
        "/* B library functions - compatible with Thompson's /etc/libb.a */\n"
        "/* String manipulation functions */\n"
        "static inline word b_load(word addr){ return B_DEREF(addr); }\n"
        "static inline void b_store(word addr, word v){\n"
        "#if B_BYTEPTR\n"
        "    *(word*)(uword)addr = v;\n"
        "#else\n"
        "    *(word*)(uword)((uword)addr * sizeof(word)) = v;\n"
        "#endif\n"
        "}\n"
        "\n"
        "/* B string access - compatible with C strings (byte addressing) */\n"
        "static word b_char(word s, word i){\n"
        "#if B_BYTEPTR\n"
        "    const unsigned char *p = (const unsigned char*)B_CPTR(s);\n"
        "    return (word)p[(size_t)i];\n"
        "#else\n"
        "    const uword W = (uword)sizeof(word);          // bytes per word on this host\n"
        "    uword wi = (uword)i / W;\n"
        "    uword bi = (uword)i % W;\n"
        "    uword w  = (uword)b_load((word)(s + (word)wi));\n"
        "    return (word)((w >> (bi * 8)) & 0xFF);\n"
        "#endif\n"
        "}\n"
        "\n"
        "static word b_lchar(word s, word i, word c){\n"
        "#if B_BYTEPTR\n"
        "    unsigned char *p = (unsigned char*)B_CPTR(s);\n"
        "    p[(size_t)i] = (unsigned char)(c & 0xFF);\n"
        "    return c;\n"
        "#else\n"
        "    const uword W = (uword)sizeof(word);\n"
        "    uword wi = (uword)i / W;\n"
        "    uword bi = (uword)i % W;\n"
        "\n"
        "    word addr = (word)(s + (word)wi);\n"
        "    uword w   = (uword)b_load(addr);\n"
        "\n"
        "    uword mask = (uword)0xFF << (bi * 8);\n"
        "    w = (w & ~mask) | (((uword)c & 0xFF) << (bi * 8));\n"
        "\n"
        "    b_store(addr, (word)w);\n"
        "    return c;\n"
        "#endif\n"
        "}\n"
        "\n"
        "/* Command line argument support implementation */\n"
        "static word __b_pack_cstr(const char *s){\n"
        "    size_t n = strlen(s);                 /* bytes, excluding NUL */\n"
        "    size_t W = sizeof(word);              /* bytes per word */\n"
        "    size_t total = n + 1;                 /* +1 for 004 terminator */\n"
        "    size_t words = (total + W - 1) / W;\n"
        "\n"
        "    word bp = b_alloc((word)words);       /* B pointer to word storage */\n"
        "\n"
        "    /* write bytes into the B string using lchar (handles packing for B_BYTEPTR=0) */\n"
        "    for (size_t i = 0; i < n; i++){\n"
        "        b_lchar(bp, (word)i, (word)(unsigned char)s[i]);\n"
        "    }\n"
        "    b_lchar(bp, (word)n, (word)004);\n"
        "    return bp;\n"
        "}\n"
        "\n"
        "static void __b_setargs(int argc, char **argv){\n"
        "    __b_argc = argc;\n"
        "    __b_argv = argv;\n"
        "\n"
        "    __b_argvb = (word*)malloc(sizeof(word) * (size_t)argc);\n"
        "    if (!__b_argvb) { fprintf(stderr, \"argv: out of memory\\n\"); exit(1); }\n"
        "\n"
        "    for (int i = 0; i < argc; i++){\n"
        "        __b_argvb[i] = __b_pack_cstr(argv[i]);\n"
        "    }\n"
        "}\n"
        "\n"
        "static word b_argc(void) { return (word)__b_argc; }\n"
        "\n"
        "static word b_argv(word i) {\n"
        "    int idx = (int)i;\n"
        "    if (idx < 0 || idx >= __b_argc) return 0;\n"
        "    return __b_argvb[idx];\n"
        "}\n"
        "\n"
        "/* I/O functions */\n"
        "static word b_getchr(void) {\n"
        "    unsigned char c;\n"
        "    ssize_t n = read(0, &c, 1);\n"
        "    return (n == 1) ? (word)c : (word)004; /* Return *e on EOF */\n"
        "}\n"
        "static word b_putchr(word w) {\n"
        "    unsigned char c = (unsigned char)(w & 0xFF);\n"
        "    (void)write(1, &c, 1);\n"
        "    return w;\n"
        "}\n"
        "\n"
        "#include <stdarg.h>\n"
        "\n"
        "/* Print number in specified base (from B manual) */\n"
        "static void b_printn_u(word n, word base) {\n"
        "    // recursion like old implementations\n"
        "    word a = (word)((uword)n / (uword)base);\n"
        "    if (a) b_printn_u(a, base);\n"
        "    b_putchar((word)((uword)n % (uword)base) + '0');\n"
        "}\n"
        "\n"
        "static word b_printf(word fmt, ...){\n"
        "    va_list ap;\n"
        "    va_start(ap, fmt);\n"
        "\n"
        "    word i = 0;\n"
        "    for (;;){\n"
        "        word ch = b_char(fmt, i++);\n"
        "        if (ch == 004 || ch == 0) break;  /* '*e' or NUL terminator */\n"
        "        if (ch != '%'){ b_putchar(ch); continue; }\n"
        "\n"
        "        word code = b_char(fmt, i++);\n"
        "        if (code == 004) break;\n"
        "\n"
        "        word arg = va_arg(ap, word);\n"
        "\n"
        "        switch ((int)code){\n"
        "        case 'd': {\n"
        "            int16_t v = (int16_t)arg;\n"
        "            if (v < 0){ b_putchar('-'); v = (int16_t)-v; }\n"
        "            if (v) b_printn_u((word)(uword)(uint16_t)v, 10);\n"
        "            else b_putchar('0');\n"
        "            break;\n"
        "        }\n"
        "        case 'o': {\n"
        "            uint16_t v = (uint16_t)arg;\n"
        "            if (v) b_printn_u((word)(uword)v, 8);\n"
        "            else b_putchar('0');\n"
        "            break;\n"
        "        }\n"
        "        case 'c':\n"
        "            b_putchar(arg);\n"
        "            break;\n"
        "        case 's': {\n"
        "            word j = 0;\n"
        "            for (;;){\n"
        "                word sc = b_char(arg, j++);\n"
        "                if (sc == 004 || sc == 0) break;  /* Handle both *e and NUL termination */\n"
        "                b_putchar(sc);\n"
        "            }\n"
        "            break;\n"
        "        }\n"
        "        default:\n"
        "            b_putchar('%'); b_putchar(code);\n"
        "            break;\n"
        "        }\n"
        "    }\n"
        "\n"
        "    va_end(ap);\n"
        "    return 0;\n"
        "}\n"
        "\n"
        "/* File I/O functions - with actual implementations */\n"
        "#include <fcntl.h>\n"
        "static word b_open(word name, word mode){\n"
        "    const char *p = (const char*)B_CPTR(name);\n"
        "    int flags = ((int)mode == 0) ? O_RDONLY : O_WRONLY;\n"
        "    return (word)open(p, flags);\n"
        "}\n"
        "static word b_close(word fd) {\n"
        "    return (word)close((int)fd);\n"
        "}\n"
        "static word b_read(word fd, word buf, word n) {\n"
        "    char *p = (char*)B_CPTR(buf);\n"
        "    return (word)read((int)fd, p, (size_t)n);\n"
        "}\n"
        "static word b_write(word fd, word buf, word n) {\n"
        "    const char *p = (const char*)B_CPTR(buf);\n"
        "    return (word)write((int)fd, p, (size_t)n);\n"
        "}\n"
        "static word b_creat(word name, word mode) {\n"
        "    const char *p = (const char*)B_CPTR(name);\n"
        "    return (word)creat(p, (mode_t)mode);\n"
        "}\n"
        "static word b_seek(word fd, word offset, word whence) {\n"
        "    off_t r = lseek((int)fd, (off_t)offset, (int)whence);\n"
        "    return (r < 0) ? (word)-1 : (word)0;\n"
        "}\n"
        "\n"
        "/* Process control functions - with actual implementations */\n"
        "static word b_fork(void) {\n"
        "    return (word)fork();\n"
        "}\n"
        "word __b_wait_status;\n"
        "\n"
        "static word b_wait(void) {\n"
        "    int st = 0;\n"
        "    pid_t pid = wait(&st);\n"
        "    __b_wait_status = (word)st;\n"
        "    return (word)pid;\n"
        "}\n"
        "static word b_execl(word path, ...) {\n"
        "    const char *p = (const char*)B_CPTR(path);\n"
        "\n"
        "    char *argv[64];\n"
        "    int i = 0;\n"
        "    argv[i++] = (char*)p;\n"
        "\n"
        "    va_list ap;\n"
        "    va_start(ap, path);\n"
        "    for (; i < 63; ) {\n"
        "        word w = va_arg(ap, word);\n"
        "        if (w == 0) break;\n"
        "        argv[i++] = (char*)B_CPTR(w);\n"
        "    }\n"
        "    va_end(ap);\n"
        "\n"
        "    argv[i] = NULL;\n"
        "    execv(p, argv);\n"
        "    return -1; /* Only reached on error */\n"
        "}\n"
        "\n"
        "static word b_execv(word path, word argv) {\n"
        "    /* Note: Manual specifies execv(path, argv, count) with counted vector */\n"
        "    /* Current implementation uses null-terminated vector for compatibility */\n"
        "    const char *p = (const char*)B_CPTR(path);\n"
        "    word *av = (word*)B_CPTR(argv);\n"
        "\n"
        "    char *cargv[256];\n"
        "    int i = 0;\n"
        "    for (; i < 255 && av[i] != 0; i++) cargv[i] = (char*)B_CPTR(av[i]);\n"
        "    cargv[i] = NULL;\n"
        "\n"
        "    execv(p, cargv);\n"
        "    return -1; /* Only reached on error */\n"
        "}\n"
        "\n"
        "/* System functions - with actual implementations where possible */\n"
        "static word b_time(word tvp) {\n"
        "    time_t now = time(NULL);\n"
        "    if (tvp) {\n"
        "        uint16_t lo = (uint16_t)(now & 0xFFFF);\n"
        "        uint16_t hi = (uint16_t)((now >> 16) & 0xFFFF);\n"
        "        word *tv = (word*)B_CPTR(tvp);\n"
        "        tv[0] = (word)(uword)lo;\n"
        "        tv[1] = (word)(uword)hi;\n"
        "    }\n"
        "    return 0;\n"
        "}\n"
        "\n"
        "static word b_ctime(word tvp) {\n"
        "    static word bufw[32];               // 32 words = 64 bytes worth of chars\n"
        "    word *tv = (word*)B_CPTR(tvp);\n"
        "    time_t t = (time_t)((uint16_t)tv[0]) | ((time_t)((uint16_t)tv[1]) << 16);\n"
        "\n"
        "    const char *cs = ctime(&t);\n"
        "    if (!cs) return 0;\n"
        "\n"
        "    size_t i = 0;\n"
        "    while (cs[i] && cs[i] != '\\n' && i < 63) {\n"
        "        b_lchar(B_PTR(bufw), (word)i, (word)(unsigned char)cs[i]);\n"
        "        i++;\n"
        "    }\n"
        "    b_lchar(B_PTR(bufw), (word)i, 004);\n"
        "    return B_PTR(bufw);\n"
        "}\n"
        "static word b_getuid(void) {\n"
        "    return (word)getuid();\n"
        "}\n"
        "static word b_chdir(word path) {\n"
        "    const char *p = (const char*)B_CPTR(path);\n"
        "    return (word)chdir(p);\n"
        "}\n"
        "static word b_unlink(word path) {\n"
        "    const char *p = (const char*)B_CPTR(path);\n"
        "    return (word)unlink(p);\n"
        "}\n"
        "\n"
        "/* System functions with actual implementations */\n"
        "static word b_chmod(word path, word mode) {\n"
        "    const char *p = (const char*)B_CPTR(path);\n"
        "    return (word)chmod(p, (mode_t)mode);\n"
        "}\n"
        "static word b_chown(word path, word owner) {\n"
        "    const char *p = (const char*)B_CPTR(path);\n"
        "    return (word)chown(p, (uid_t)owner, (gid_t)-1);\n"
        "}\n"
        "static word b_link(word old, word new) {\n"
        "    const char *o = (const char*)B_CPTR(old);\n"
        "    const char *n = (const char*)B_CPTR(new);\n"
        "    return (word)link(o, n);\n"
        "}\n"
        "static word b_stat(word path, word bufp) {\n"
        "    const char *p = (const char*)B_CPTR(path);\n"
        "    struct stat st;\n"
        "    if (stat(p, &st) != 0) return -1;\n"
        "    if (bufp) {\n"
        "        unsigned char *b = (unsigned char*)B_CPTR(bufp);\n"
        "        for (int i = 0; i < 20*sizeof(word); i++) b[i] = 0;\n"
        "        size_t n = sizeof(st);\n"
        "        if (n > 20*sizeof(word)) n = 20*sizeof(word);\n"
        "        memcpy(b, &st, n);\n"
        "    }\n"
        "    return 0;\n"
        "}\n"
        "\n"
        "static word b_fstat(word fd, word bufp) {\n"
        "    struct stat st;\n"
        "    if (fstat((int)fd, &st) != 0) return -1;\n"
        "    if (bufp) {\n"
        "        unsigned char *b = (unsigned char*)B_CPTR(bufp);\n"
        "        for (int i = 0; i < 20*sizeof(word); i++) b[i] = 0;\n"
        "        size_t n = sizeof(st);\n"
        "        if (n > 20*sizeof(word)) n = 20*sizeof(word);\n"
        "        memcpy(b, &st, n);\n"
        "    }\n"
        "    return 0;\n"
        "}\n"
        "static word b_setuid(word uid) {\n"
        "    return (word)setuid((uid_t)uid);\n"
        "}\n"
        "static word b_makdir(word path, word mode) {\n"
        "    const char *p = (const char*)B_CPTR(path);\n"
        "    return (word)mkdir(p, (mode_t)mode);\n"
        "}\n"
        "\n"
        "/* printn(number, base) - print number in specified base (from B manual) */\n"
        "static word b_printn(word n, word base) {\n"
        "    // Handle negative numbers for decimal only\n"
        "    if (base == 10 && (int16_t)n < 0) {\n"
        "        b_putchar('-');\n"
        "        n = (word)(-(int16_t)n);\n"
        "    }\n"
        "    b_printn_u(n, base);\n"
        "    return n;\n"
        "}\n"
        "static word b_putnum(word n) {\n"
        "    b_printn(n, (word)10);\n"
        "    return n;\n"
        "}\n"
        "static volatile sig_atomic_t __b_got_intr = 0;\n"
        "\n"
        "static void __b_sigint(int sig){ (void)sig; __b_got_intr = 1; }\n"
        "\n"
        "static word b_gtty(word fd, word ttstat){\n"
        "    struct termios t;\n"
        "    if (tcgetattr((int)fd, &t) < 0) return -1;\n"
        "\n"
        "    word *vec = (word*)B_CPTR(ttstat);\n"
        "    vec[0] = (word)t.c_iflag;\n"
        "    vec[1] = (word)t.c_oflag;\n"
        "    vec[2] = (word)t.c_lflag;\n"
        "    return 0;\n"
        "}\n"
        "\n"
        "static word b_stty(word fd, word ttstat){\n"
        "    struct termios t;\n"
        "    if (tcgetattr((int)fd, &t) < 0) return -1;\n"
        "\n"
        "    word *vec = (word*)B_CPTR(ttstat);\n"
        "    t.c_iflag = (tcflag_t)vec[0];\n"
        "    t.c_oflag = (tcflag_t)vec[1];\n"
        "    t.c_lflag = (tcflag_t)vec[2];\n"
        "    return (word)tcsetattr((int)fd, TCSANOW, &t);\n"
        "}\n"
        "static word b_intr(word on) {\n"
        "    /* Set up interrupt handling */\n"
        "    /* on != 0: catch interrupts, on == 0: restore default */\n"
        "    if (on) {\n"
        "        __b_got_intr = 0;\n"
        "        if (signal(SIGINT, __b_sigint) == SIG_ERR) return -1;\n"
        "    } else {\n"
        "        if (signal(SIGINT, SIG_DFL) == SIG_ERR) return -1;\n"
        "    }\n"
        "    return 0;\n"
        "}\n"
        "\n"
        "/* Builtin aliases for B source */\n"
        "#define print   b_print\n"
        "\n",
        out
    );

    // Emit Thompson B packed strings
    if (!current_byteptr && string_pool.len > 0) {
        emit_string_pool(out);
        fputc('\n', out);
    }

    // First pass: emit all global declarations and storage
    for (size_t i = 0; i < prog->tops.len; i++) {
        Top *t = (Top*)prog->tops.data[i];

        if (t->kind == TOP_GAUTO) {
            emit_stmt(out, t->as.gauto, 0, 0, filename); // not a function body
            fputc('\n', out);
            continue;
        }

        if (t->kind == TOP_EXTERN_DECL) {
            ExternItem *item = t->as.ext_decl;
            fprintf(out, "extern word %s;\n", item->name);
            continue;
        }

        if (t->kind == TOP_EXTERN_DEF) {
            ExternItem *item = t->as.ext_def;
            if (item->as.var.vkind == EXTVAR_BLOB) {
                // Blob external: contiguous words at &name
                size_t base_len = (item->as.var.init && item->as.var.init->kind == INIT_LIST) ? init_list_length(item->as.var.init) : 1;
                size_t tail     = (item->as.var.init && item->as.var.init->kind == INIT_LIST) ? edge_tail_words_top(item->as.var.init) : 0;
                size_t total    = base_len + tail;
                if (total == 0) total = 1;
                fprintf(out, "static word __%s_blob[%zu];\n", item->name, total);
                fprintf(out, "#define %s (__%s_blob[0])\n", item->name, item->name);
            } else if (item->as.var.vkind == EXTVAR_VECTOR) {
                // Vector external: pointer + backing store
                size_t init_len = (item->as.var.init && item->as.var.init->kind == INIT_LIST) ? init_list_length(item->as.var.init) : 0;
                size_t outer_len = 1;

                if (item->as.var.has_empty) {
                    outer_len = init_len ? init_len : 1;
                } else if (item->as.var.bound) {
                    long bv = 0;
                    if (try_eval_const_expr(item->as.var.bound, &bv)) {
                        if (bv < 0) bv = 0;
                        outer_len = (size_t)(bv + 1);
                    } else {
                        outer_len = init_len ? init_len : 1;
                    }
                    if (init_len > outer_len) outer_len = init_len;
                } else {
                    outer_len = init_len ? init_len : 1;
                }

                size_t tail = (item->as.var.init && item->as.var.init->kind == INIT_LIST) ? edge_tail_words_top(item->as.var.init) : 0;
                size_t total = outer_len + tail;
                if (total == 0) total = 1;

                fprintf(out, "static word __%s_store[%zu];\n", item->name, total);
                fprintf(out, "word %s;\n", item->name);
            } else {
                // Scalar external
                if (item->is_implicit_static) {
                    fprintf(out, "static word %s;\n", item->name);
                } else {
                    fprintf(out, "word %s;\n", item->name);
                }
            }
            continue;
        }
    }

    // Emit __b_init function
    fputs("static void __b_init(void) {\n", out);
    for (size_t i = 0; i < prog->tops.len; i++) {
        Top *t = (Top*)prog->tops.data[i];
        if (t->kind == TOP_EXTERN_DEF) {
            ExternItem *item = t->as.ext_def;
            
            if (item->as.var.vkind == EXTVAR_SCALAR && item->as.var.init && item->as.var.init->kind == INIT_EXPR) {
                fprintf(out, "    %s = ", item->name);
                emit_ival_expr(out, item->as.var.init->as.expr, filename);
                fputs(";\n", out);
            } else if (item->as.var.vkind == EXTVAR_BLOB && item->as.var.init && item->as.var.init->kind == INIT_LIST) {
                // Initialize blob elements + edge subvectors in tail
                size_t base_len = init_list_length(item->as.var.init);
                {
                    char buf[256];
                    snprintf(buf, sizeof(buf), "__%s_blob", item->name);
                    (void)emit_edge_list_init(out, buf, 0, item->as.var.init, base_len, 2, filename);
                }
            } else if (item->as.var.vkind == EXTVAR_VECTOR) {
                // Set vector pointer
                fprintf(out, "    %s = B_ADDR(__%s_store[0]);\n", item->name, item->name);
                // Initialize vector elements if present
                if (item->as.var.init && item->as.var.init->kind == INIT_LIST) {
                    // outer_len is where the tail cursor starts (reserved outer slots)
                    size_t init_len = init_list_length(item->as.var.init);
                    size_t outer_len = 1;
                    if (item->as.var.has_empty) outer_len = init_len ? init_len : 1;
                    else if (item->as.var.bound) {
                        long bv = 0;
                        if (try_eval_const_expr(item->as.var.bound, &bv)) {
                            if (bv < 0) bv = 0;
                            outer_len = (size_t)(bv + 1);
                        } else outer_len = init_len ? init_len : 1;
                        if (init_len > outer_len) outer_len = init_len;
                    } else outer_len = init_len ? init_len : 1;

                    {
                        char buf[256];
                        snprintf(buf, sizeof(buf), "__%s_store", item->name);
                        (void)emit_edge_list_init(out, buf, 0, item->as.var.init, outer_len, 2, filename);
                    }
                }
            }
        }
    }

    fputs("}\n\n", out);

    // Emit function prototypes for C99 compatibility
    for (size_t i = 0; i < prog->tops.len; i++) {
        Top *t = (Top*)prog->tops.data[i];
        if (t->kind == TOP_FUNC) {
            Func *f = t->as.fn;
            if (strcmp(f->name, "main") == 0 || strcmp(f->name, "b_main") == 0) {
                fprintf(out, "static word __b_user_main(");
            } else {
                fprintf(out, "static word %s(", f->name);
            }
            for (size_t p = 0; p < f->params.len; p++) {
                if (p) fputs(", ", out);
                fputs("word", out);
            }
            fputs(");\n", out);
        }
    }
    fputc('\n', out);

    // Second pass: emit all functions
    int has_main = 0;
    for (size_t i = 0; i < prog->tops.len; i++) {
        Top *t = (Top*)prog->tops.data[i];

        if (t->kind == TOP_FUNC) {
            Func *f = t->as.fn;
            if (strcmp(f->name, "main") == 0 || strcmp(f->name, "b_main") == 0) {
                has_main = 1;
                // Rename main to __b_user_main
                fprintf(out, "word __b_user_main(");
            } else {
                fprintf(out, "word %s(", f->name);
            }
            for (size_t p = 0; p < f->params.len; p++) {
                if (p) fputs(", ", out);
                fprintf(out, "word %s", (char*)f->params.data[p]);
            }
            fputs(")\n", out);
            emit_stmt(out, f->body, 0, 1, filename); // function body
            fputc('\n', out);
            continue;
        }
    }

    // Emit wrapper main if user defined main
    if (has_main) {
        fputs("int main(int argc, char **argv){\n", out);
        fputs("    __b_setargs(argc, argv);\n", out);
        fputs("    __b_init();\n", out);
        fputs("    return (int)__b_user_main();\n", out);
        fputs("}\n", out);
    }
}

// ===================== Assembly Emitter (experimental) =====================

static int asm_label_id = 0;

static void emit_asm_label(FILE *out, const char *prefix) {
    fprintf(out, ".L%s%d:\n", prefix, asm_label_id++);
}

void emit_program_asm(FILE *out, Program *prog) {
    // Generate x86_64 assembly in GAS syntax
    fprintf(out, "# B compiler - generated assembly\n");
    fprintf(out, ".intel_syntax noprefix\n");
    fprintf(out, ".data\n");

    // Global variables would go here, but for now we skip them

    fprintf(out, ".text\n");
    fprintf(out, ".global main\n");

    // Find and emit functions
    for (size_t i = 0; i < prog->tops.len; i++) {
        Top *t = prog->tops.data[i];
        if (t->kind == TOP_FUNC) {
            Func *f = t->as.fn;

            // Function label
            if (strcmp(f->name, "main") == 0) {
                fprintf(out, "main:\n");
            } else {
                fprintf(out, "%s:\n", f->name);
            }

            // Function prologue
            fprintf(out, "    push rbp\n");
            fprintf(out, "    mov rbp, rsp\n");

            // Allocate space for locals (simplified - assume 8 bytes per local)
            // In a real implementation, we'd track local variables properly
            fprintf(out, "    sub rsp, 8\n");

            // Emit function body (very basic)
            if (f->body && f->body->kind == ST_BLOCK) {
                for (size_t j = 0; j < f->body->as.block.items.len; j++) {
                    Stmt *stmt = f->body->as.block.items.data[j];
                    if (stmt->kind == ST_RETURN && stmt->as.ret.val) {
                        // Very basic return handling
                        fprintf(out, "    mov rax, %ld\n", stmt->as.ret.val->as.num);
                        break; // For now, just handle the first return
                    }
                }
            }

            // Function epilogue
            fprintf(out, "    leave\n");
            fprintf(out, "    ret\n");
            fprintf(out, "\n");
        }
    }
}
