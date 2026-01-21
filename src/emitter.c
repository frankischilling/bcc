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

// ===================== Name Mangling for C-safe Identifiers =====================

typedef struct {
    const char *original;
    char *mangled;
} NameEntry;

static Vec name_map;  // Vec<NameEntry*>

// C keywords to avoid
static const char *c_keywords[] = {
    "auto", "break", "case", "char", "const", "continue", "default", "do",
    "double", "else", "enum", "extern", "float", "for", "goto", "if",
    "inline", "int", "long", "register", "restrict", "return", "short",
    "signed", "sizeof", "static", "struct", "switch", "typedef", "union",
    "unsigned", "void", "volatile", "while", "_Bool", "_Complex", "_Imaginary",
    // C11 keywords
    "_Alignas", "_Alignof", "_Atomic", "_Generic", "_Noreturn", "_Static_assert", "_Thread_local",
    // Common macros/reserved
    "NULL", "true", "false", "bool",
    // B runtime functions we use
    "word", "B_PTR", "B_ADDR", "B_DEREF",
    NULL
};

static int is_c_keyword(const char *name) {
    for (int i = 0; c_keywords[i]; i++) {
        if (strcmp(name, c_keywords[i]) == 0) return 1;
    }
    return 0;
}

// Check if a character is valid in a C identifier (not first position)
static int is_c_ident_char(char c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
           (c >= '0' && c <= '9') || c == '_';
}

// Check if a character is valid as first character of C identifier
static int is_c_ident_first(char c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_';
}

// Mangle a name to be C-safe
static char *mangle_name_raw(const char *original) {
    if (!original || !original[0]) return sdup("__empty");

    // Calculate needed size (worst case: each char becomes _XX + prefix + suffix)
    size_t len = strlen(original);
    size_t max_len = len * 4 + 16;
    char *result = xmalloc(max_len);
    char *p = result;

    // Handle first character
    if (!is_c_ident_first(original[0])) {
        *p++ = '_';
        if (original[0] == '.') {
            *p++ = '_';
        } else {
            p += sprintf(p, "%02X", (unsigned char)original[0]);
        }
    } else {
        *p++ = original[0];
    }

    // Handle rest of characters
    for (size_t i = 1; i < len; i++) {
        char c = original[i];
        if (is_c_ident_char(c)) {
            *p++ = c;
        } else if (c == '.') {
            *p++ = '_';
        } else {
            // Encode as hex
            p += sprintf(p, "_%02X", (unsigned char)c);
        }
    }
    *p = '\0';

    return result;
}

// Check if mangled name already exists in map
static int mangled_exists(const char *mangled) {
    for (size_t i = 0; i < name_map.len; i++) {
        NameEntry *e = (NameEntry*)name_map.data[i];
        if (strcmp(e->mangled, mangled) == 0) return 1;
    }
    return 0;
}

// Get or create mangled name for an identifier
static const char *get_mangled_name(const char *original) {
    if (!original) return NULL;

    // Check if we already have this name
    for (size_t i = 0; i < name_map.len; i++) {
        NameEntry *e = (NameEntry*)name_map.data[i];
        if (strcmp(e->original, original) == 0) return e->mangled;
    }

    // Create new mangled name
    char *mangled = mangle_name_raw(original);

    // Check if it's a C keyword
    if (is_c_keyword(mangled)) {
        char *prefixed = xmalloc(strlen(mangled) + 3);
        sprintf(prefixed, "b_%s", mangled);
        free(mangled);
        mangled = prefixed;
    }

    // Handle collisions by adding suffix
    if (mangled_exists(mangled)) {
        int suffix = 2;
        char *unique = xmalloc(strlen(mangled) + 16);
        do {
            sprintf(unique, "%s_%d", mangled, suffix++);
        } while (mangled_exists(unique));
        free(mangled);
        mangled = unique;
    }

    // Add to map
    NameEntry *e = xmalloc(sizeof(NameEntry));
    e->original = sdup(original);
    e->mangled = mangled;
    vec_push(&name_map, e);

    return mangled;
}

// Emit a B identifier as a C-safe name
static void emit_name(FILE *out, const char *name) {
    if (!name) return;
    fputs(get_mangled_name(name), out);
}

// Clear the name map (call at start of each compilation unit)
// Note: entries are arena-allocated, so we just reset the length
static void clear_name_map(void) {
    name_map.len = 0;
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
static int current_word_bits;
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
            emit_indent(out, indent);
            fputs("while (", out);
            emit_expr(out, s->as.whiles.cond, filename);
            fputs(")\n", out);
            emit_stmt_switchctx(out, s->as.whiles.body,
                                stmt_is_block(s->as.whiles.body) ? indent : indent + 1, maps, filename);
            return;

        case ST_SWITCH:
            // nested switches: let normal emitter handle them
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
            fprintf(out, "B_PTR(__b_str%d)", id);
            return;
        }
        case EX_VAR: {
            emit_name(out, e->as.var);
            return;
        }

        case EX_CALL: {
            int used_builtin_prefix = 0;
            int printf_like = 0;
            size_t fmt_index = 0;
            int *printf_wrap_s = NULL;

            // Check if callee is a builtin function that needs b_ prefix
            if (e->as.call.callee->kind == EX_VAR) {
                const char *name = e->as.call.callee->as.var;
                if (strcmp(name, "callf") == 0) {
                    size_t nargs = e->as.call.args.len;
                    size_t extra = (nargs > 0) ? (nargs - 1) : 0; /* args after name */
                    fprintf(out, "b_callf_dispatch(%zu", extra);
                    for (size_t i = 0; i < nargs; i++) {
                        fputs(", ", out);
                        emit_expr(out, (Expr*)e->as.call.args.data[i], filename);
                    }
                    fputc(')', out);
                    return;
                }
                // List of builtin functions that have b_ versions
                const char *b_funcs[] = {
                    "char", "lchar", "getchr", "putchr", "getstr", "putstr", "flush", "reread", "printf", "printn", "putnum", "putchar", "exit", "abort", "free",
                    "open", "close", "read", "write", "creat", "seek", "openr", "openw",
                    "fork", "wait", "execl", "execv",
                    "chdir", "chmod", "chown", "link", "unlink", "stat", "fstat",
                    "time", "ctime", "getuid", "setuid", "makdir", "intr",
                    "system", "usleep",
                    "callf",
                    "argc", "argv",
                    NULL
                };
                for (int i = 0; b_funcs[i]; i++) {
                    if (strcmp(name, b_funcs[i]) == 0) {
                        used_builtin_prefix = 1;
                        break;
                    }
                }
            }
            const char *cname = NULL;
            int wrap_ret_ptr = 0;
            if (e->as.call.callee->kind == EX_VAR) {
                cname = e->as.call.callee->as.var;
                if (strcmp(cname, "malloc") == 0 || strcmp(cname, "calloc") == 0 || strcmp(cname, "realloc") == 0) {
                    wrap_ret_ptr = 1; // return a C pointer: convert to B pointer
                }
                if (strcmp(cname, "printf") == 0 && !used_builtin_prefix) { printf_like = 1; fmt_index = 0; }
                else if (strcmp(cname, "fprintf") == 0 || strcmp(cname, "dprintf") == 0) { printf_like = 1; fmt_index = 1; }
                else if (strcmp(cname, "sprintf") == 0) { printf_like = 1; fmt_index = 1; }
                else if (strcmp(cname, "snprintf") == 0) { printf_like = 1; fmt_index = 2; }
            }

            if (wrap_ret_ptr) fputs("B_PTR(", out);
            /* For builtin functions, emit b_<name> directly to avoid double-mangling */
            if (used_builtin_prefix && e->as.call.callee->kind == EX_VAR) {
                fprintf(out, "b_%s", e->as.call.callee->as.var);
            } else {
                emit_expr(out, e->as.call.callee, filename);
            }
            fputc('(', out);
            size_t nargs = e->as.call.args.len;

            if (printf_like && fmt_index < nargs) {
                Expr *fmt_expr = (Expr*)e->as.call.args.data[fmt_index];
                if (fmt_expr && fmt_expr->kind == EX_STR) {
                    const char *fmt = fmt_expr->as.str;
                    printf_wrap_s = (int*)calloc(nargs, sizeof(int));
                    if (printf_wrap_s) {
                        size_t arg_pos = fmt_index + 1; /* first vararg position */
                        for (size_t fi = 0; fmt[fi]; fi++) {
                            if (fmt[fi] != '%') continue;
                            fi++;
                            if (fmt[fi] == '%') continue;
                            while (fmt[fi] && strchr("-+ #0", fmt[fi])) fi++;
                            if (fmt[fi] == '*') { if (arg_pos < nargs) arg_pos++; fi++; }
                            else while (fmt[fi] && isdigit((unsigned char)fmt[fi])) fi++;
                            if (fmt[fi] == '.') {
                                fi++;
                                if (fmt[fi] == '*') { if (arg_pos < nargs) arg_pos++; fi++; }
                                else while (fmt[fi] && isdigit((unsigned char)fmt[fi])) fi++;
                            }
                            if (fmt[fi] == 'h' && fmt[fi+1] == 'h') fi++;
                            else if (fmt[fi] == 'l' && fmt[fi+1] == 'l') fi++;
                            else if (fmt[fi] == 'h' || fmt[fi] == 'l' || fmt[fi] == 'z' || fmt[fi] == 'j' || fmt[fi] == 't' || fmt[fi] == 'L') {
                                /* single-char length modifier */ ;
                            }
                            if (!fmt[fi]) break;
                            if (fmt[fi] == 's' && arg_pos < nargs) printf_wrap_s[arg_pos] = 1;
                            arg_pos++;
                        }
                    }
                }
            }

            int add_exit_zero = (cname && strcmp(cname, "exit") == 0 && nargs == 0);
            if (add_exit_zero) {
                fputs("0", out);
            }
            for (size_t i = 0; i < nargs; i++) {
                if (i || add_exit_zero) fputs(", ", out);

                // Apply B_CPTR to pointer arguments for common C library functions we call from B
                int wrap_arg_ptr = 0;
                int wrap_arg_cstr = 0;
                int scale_word_size = 0;
                if (cname) {
                    if (printf_like && i == fmt_index) wrap_arg_cstr = 1; /* format string */
                    else if (printf_wrap_s && printf_wrap_s[i]) wrap_arg_cstr = 1;
                    else if (strcmp(cname, "strlen") == 0 && i == 0) wrap_arg_cstr = 1;
                    else if (strcmp(cname, "atoi") == 0 && i == 0) wrap_arg_cstr = 1;
                    else if (strcmp(cname, "memmove") == 0 && (i == 0 || i == 1)) wrap_arg_ptr = 1;
                    else if (strcmp(cname, "tcgetattr") == 0 && i == 1) wrap_arg_ptr = 1;
                    else if (strcmp(cname, "tcsetattr") == 0 && i == 2) wrap_arg_ptr = 1;
                    else if (strcmp(cname, "ioctl") == 0 && i == 2) wrap_arg_ptr = 1;

                    if (!wrap_arg_cstr) {
                        if (strcmp(cname, "memset") == 0 && i == 0) wrap_arg_ptr = 1;
                        else if (strcmp(cname, "memcpy") == 0 && (i == 0 || i == 1)) wrap_arg_ptr = 1;
                        else if (strcmp(cname, "realloc") == 0 && i == 0) wrap_arg_ptr = 1;
                        else if (strcmp(cname, "calloc") == 0 && i == 0) wrap_arg_ptr = 0; // first arg is count
                    }

                    // For malloc/calloc/realloc size arguments in word-addressing mode,
                    // scale by sizeof(word) to avoid under-allocation.
                    if (!current_byteptr) {
                        if ((strcmp(cname, "malloc") == 0 && i == 0) ||
                            (strcmp(cname, "realloc") == 0 && i == 1) ||
                            (strcmp(cname, "calloc") == 0 && i == 1)) {
                            scale_word_size = 1;
                        }
                    }
                }

                if (wrap_arg_cstr) fputs("__b_cstr(", out);
                else if (wrap_arg_ptr) fputs("B_CPTR(", out);
                if (scale_word_size) {
                    fputs("(size_t)(sizeof(word) * (uword)(", out);
                }

                emit_expr(out, (Expr*)e->as.call.args.data[i], filename);

                if (scale_word_size) fputs("))", out);
                if (wrap_arg_cstr || wrap_arg_ptr) fputc(')', out);
            }
            fputc(')', out);
            if (wrap_ret_ptr) fputc(')', out);
            if (printf_wrap_s) free(printf_wrap_s);
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
                /* Check if this is string character access: *(string + offset) or *(offset + string) */
                Expr *rhs = e->as.unary.rhs;
                if (rhs->kind == EX_BINARY && rhs->as.bin.op == TK_PLUS) {
                    Expr *lhs_inner = rhs->as.bin.lhs;
                    Expr *rhs_inner = rhs->as.bin.rhs;
                    Expr *str_expr = NULL;
                    Expr *idx_expr = NULL;

                    if (lhs_inner->kind == EX_STR) {
                        str_expr = lhs_inner;
                        idx_expr = rhs_inner;
                    } else if (rhs_inner->kind == EX_STR) {
                        str_expr = rhs_inner;
                        idx_expr = lhs_inner;
                    }

                    if (str_expr) {
                        /* Use b_char() for string character access */
                        fputs("b_char(", out);
                        emit_expr(out, str_expr, filename);
                        fputs(", ", out);
                        emit_expr(out, idx_expr, filename);
                        fputc(')', out);
                        return;
                    }
                }
                /* Default: word dereference */
                fputs("B_DEREF(", out);
                emit_expr(out, e->as.unary.rhs, filename);
                fputc(')', out);
                return;
            }
            if (op == TK_AMP) {
                // Special case: &arr[i] should give address of array element
                if (e->as.unary.rhs->kind == EX_INDEX) {
                    // For &arr[i], compute the byte address of element i, then wrap back to a B pointer.
                    fputs("B_PTR(", out);
                    fputs("((", out);
                    if (!current_byteptr) {
                        fputs("uword)(", out);
                        emit_expr(out, e->as.unary.rhs->as.index.base, filename);
                        fputs(") * sizeof(word)", out);
                    } else {
                        fputs("uword)(", out);
                        emit_expr(out, e->as.unary.rhs->as.index.base, filename);
                        fputc(')', out);
                    }
                    fputs(" + (uword)(", out);
                    emit_expr(out, e->as.unary.rhs->as.index.idx, filename);
                    fputs(") * sizeof(word))", out);
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
                /* Use helper function for complex lvalues OR when in non-host mode (for proper wrapping) */
                if (is_complex_lvalue(rhs) || current_word_bits != 0) {
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

            /* Use safe WNEG macro for unary negation to avoid signed overflow UB */
            if (op == TK_MINUS && current_word_bits != 0) {
                fputs("WNEG(", out);
                emit_expr(out, e->as.unary.rhs, filename);
                fputc(')', out);
            } else {
                fputc('(', out);
                fputs(tk_name(op), out);
                fputc('(', out);
                emit_expr(out, e->as.unary.rhs, filename);
                fputs("))", out);
            }
            return;
        }

        case EX_POST: {
            // postfix ops
            TokenKind op = e->as.post.op;
            Expr *lhs = e->as.post.lhs;
            /* Use helper function for complex lvalues OR when in non-host mode (for proper wrapping) */
            if (is_complex_lvalue(lhs) || current_word_bits != 0) {
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
            /* Use safe W* macros to avoid host-C undefined behavior */
            const char *wmacro = NULL;
            if (current_word_bits != 0) {
                switch (op) {
                case TK_PLUS:   wmacro = "WADD"; break;
                case TK_MINUS:  wmacro = "WSUB"; break;
                case TK_STAR:   wmacro = "WMUL"; break;
                case TK_SLASH:  wmacro = "WDIV"; break;
                case TK_PERCENT: wmacro = "WMOD"; break;
                case TK_LSHIFT: wmacro = "WSHL"; break;
                case TK_RSHIFT: wmacro = "WSHR"; break;
                case TK_AMP:    wmacro = "WAND"; break;
                case TK_BAR:    wmacro = "WOR"; break;
                default: break;
                }
            }
            if (wmacro) {
                fprintf(out, "%s(", wmacro);
                emit_expr(out, e->as.bin.lhs, filename);
                fputs(", ", out);
                emit_expr(out, e->as.bin.rhs, filename);
                fputc(')', out);
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

            // For compound assignments, use helper function when:
            // - complex lvalue (to avoid double evaluation), OR
            // - non-host mode (to ensure proper word wrapping)
            if (op != TK_ASSIGN && (is_complex_lvalue(lhs) || current_word_bits != 0)) {
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
        emit_name(out, e->as.var);
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
                const char *mname = get_mangled_name(item->name);

                if (item->size) {
                    // Vector: emit backing storage
                    emit_indent(out, indent);
                    fprintf(out, "word __%s_store[(", mname);
                    emit_expr(out, item->size, filename);
                    fprintf(out, ") + 1];\n"); // B bound is last index

                    // Emit pointer variable
                    emit_indent(out, indent);
                    fprintf(out, "word %s;\n", mname);

                    // Emit initialization (will be moved to init function later)
                    emit_indent(out, indent);
                    fprintf(out, "%s = B_ADDR(__%s_store[0]);\n", mname, mname);
                } else {
                    // Simple variable
                    emit_indent(out, indent);
                    fprintf(out, "word %s = 0;\n", mname);
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
            // extrn declarations are hints for the compiler; nothing to emit
            return;
        case ST_BREAK:
            emit_indent(out, indent);
            fputs("break;\n", out);
            return;
        case ST_CONTINUE:
            emit_indent(out, indent);
            fputs("continue;\n", out);
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
            // Case statements should normally be handled by switch context, but in complex
            // nesting like Duff's device, they might reach here. For now, just skip them.
            // The labels will be emitted by the switch context emitter.
            return;
    }
}

// Forward declaration for assembly emitter
void emit_program_asm(FILE *out, Program *prog);

void emit_program_c(FILE *out, Program *prog, const char *filename, int byteptr, int no_line, int word_bits) {
    current_byteptr = byteptr;
    current_word_bits = word_bits;
    string_pool.data = NULL;
    string_pool.len = 0;
    string_pool.cap = 0;

    // Clear name mangling map for fresh compilation
    clear_name_map();

    collect_strings_program(prog);
    fputs(
        "#define _DEFAULT_SOURCE 1\n"
        "#define _XOPEN_SOURCE 700\n"
        "#define _POSIX_C_SOURCE 200809L\n"
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
        "#include <unistd.h>\n"
        "#include <sys/wait.h>\n"
        "#include <signal.h>\n"
        "#include <termios.h>\n"
        "#include <sys/ioctl.h>\n"
        "#include <ctype.h>\n"
        "#include <dlfcn.h>\n"
        "#include <math.h>\n"
        "#include <stddef.h>\n"
        "#include <ncurses.h>\n"
        "#include <panel.h>\n"
        "\n"
        "/* Undefine common macros that might conflict with B variable names */\n"
        "#undef TRUE\n"
        "#undef FALSE\n"
        "#undef TCSAFLUSH\n"
        "#undef FIONREAD\n"
        "#undef TIOCGWINSZ\n"
        "\n"
        "typedef intptr_t  word;\n"
        "typedef uintptr_t uword;\n"
        "\n"
        "/* Endianness check: char()/lchar() in B_BYTEPTR=0 mode pack bytes with\n"
        " * byte 0 at the LSB (PDP-11/little-endian convention). The shift-based\n"
        " * implementation works on word VALUES so it's consistent across architectures,\n"
        " * but string literals compiled on one endianness may look wrong on another.\n"
        " * Warn if running on big-endian to alert users to potential issues.\n"
        " */\n"
        "#if !defined(__BYTE_ORDER__) || __BYTE_ORDER__ != __ORDER_LITTLE_ENDIAN__\n"
        "  #if !B_BYTEPTR\n"
        "    #warning \"B_BYTEPTR=0 mode uses little-endian byte packing; results may differ on big-endian hosts\"\n"
        "  #endif\n"
        "#endif\n"
        "\n"
        "/*\n"
        "  Pointer model:\n"
        "    B_BYTEPTR=1  -> pointers are byte addresses (matches your formulas)\n"
        "    B_BYTEPTR=0  -> pointers are word addresses (closer to Thompson B: E1[E2]==*(E1+E2))\n"
        "*/\n",
        out
    );
    fprintf(out, "#define B_BYTEPTR %d\n", byteptr ? 1 : 0);
    fprintf(out, "#define WORD_BITS %d\n", word_bits);
    fputs(
        "/*\n"
        "  Word size emulation:\n"
        "    WORD_BITS=0   -> host native (no wrapping)\n"
        "    WORD_BITS=16  -> wrap arithmetic like PDP-11 16-bit words\n"
        "    WORD_BITS=32  -> wrap arithmetic at 32 bits\n"
        "  WVAL(x) sign-extends to word width after masking.\n"
        "*/\n"
        "#if WORD_BITS == 16\n"
        "  #define WORD_MASK 0xFFFFU\n"
        "  #define WVAL(x) ((word)(int16_t)((x) & WORD_MASK))\n"
        "  #define SHIFT_MASK 15\n"
        "#elif WORD_BITS == 32\n"
        "  #define WORD_MASK 0xFFFFFFFFU\n"
        "  #define WVAL(x) ((word)(int32_t)((x) & WORD_MASK))\n"
        "  #define SHIFT_MASK 31\n"
        "#else\n"
        "  #define WORD_MASK (~(uword)0)\n"
        "  #define WVAL(x) (x)\n"
        "  #define SHIFT_MASK ((int)(sizeof(word)*8 - 1))\n"
        "#endif\n"
        "\n"
        "/*\n"
        " * Safe arithmetic macros - avoid host-C undefined behavior:\n"
        " *   - All arithmetic done in unsigned to prevent signed overflow UB\n"
        " *   - Shift counts masked to valid range to prevent shift >= width UB\n"
        " *   - Results wrapped with WVAL() for proper word semantics\n"
        " */\n"
        "#define WADD(a,b) WVAL((uword)(a) + (uword)(b))\n"
        "#define WSUB(a,b) WVAL((uword)(a) - (uword)(b))\n"
        "#define WMUL(a,b) WVAL((uword)(a) * (uword)(b))\n"
        "#define WDIV(a,b) WVAL((uword)(a) / (uword)(b))\n"
        "#define WMOD(a,b) WVAL((uword)(a) % (uword)(b))\n"
        "#define WSHL(a,n) WVAL(((uword)(a) & WORD_MASK) << ((uword)(n) & SHIFT_MASK))\n"
        "#define WSHR(a,n) WVAL(((uword)(a) & WORD_MASK) >> ((uword)(n) & SHIFT_MASK))\n"
        "#define WAND(a,b) WVAL((uword)(a) & (uword)(b))\n"
        "#define WOR(a,b)  WVAL((uword)(a) | (uword)(b))\n"
        "#define WXOR(a,b) WVAL((uword)(a) ^ (uword)(b))\n"
        "#define WNEG(a)   WVAL(-(uword)(a))\n"
        "\n",
        out
    );
    fputs(
        "#if B_BYTEPTR\n"
        "  /* Byte-addressed pointers: addresses are bytes; array elements are word-sized. */\n"
        "  #define B_DEREF(p)   (*(word*)(uword)(p))\n"
        "  #define B_ADDR(x)    B_PTR(&(x))\n"
        "  #define B_INDEX(a,i) (*(word*)((uword)(a) + (uword)(i) * sizeof(word)))\n"
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
"static int rd_fd = 0;  /* current input fd */\n"
"static int wr_fd = 1;  /* current output fd */\n"
"static word rd_unit = 0; /* exposed to B if needed */\n"
"static word wr_unit = (word)-1;\n"
"static void __b_sync_rd(void){\n"
"    if (rd_unit < 0) {\n"
"        if (rd_fd != 0 && rd_fd > 2) close(rd_fd);\n"
"        rd_fd = 0;\n"
"    } else if (rd_fd != (int)rd_unit) {\n"
"        rd_fd = (int)rd_unit;\n"
"    }\n"
"}\n"
"static void __b_sync_wr(void){\n"
"    if (wr_unit < 0) {\n"
"        if (wr_fd != 1 && wr_fd > 2) close(wr_fd);\n"
"        wr_fd = 1;\n"
"    } else if (wr_fd != (int)wr_unit) {\n"
"        wr_fd = (int)wr_unit;\n"
"    }\n"
"}\n"
"static word b_print(word x){\n"
"    __b_sync_wr();\n"
"    char buf[64];\n"
"    int n = snprintf(buf, sizeof(buf), \"%\" PRIdPTR \"\\n\", (intptr_t)x);\n"
"    if (n > 0) (void)write(wr_fd, buf, (size_t)n);\n"
"    return x;\n"
"}\n"
        "\n"
"static word b_putchar(word x){\n"
"    __b_sync_wr();\n"
"    unsigned char c = (unsigned char)(x & 0xFF);\n"
"    (void)write(wr_fd, &c, 1);\n"
"    return x;\n"
"}\n"
"static word b_getchar(void){ __b_sync_rd(); unsigned char c; ssize_t n = read(rd_fd, &c, 1); if (n == 1) return (word)c; if (rd_fd != 0) { close(rd_fd); rd_fd = 0; rd_unit = -1; return b_getchar(); } return (word)004; }\n"
"static word b_exit(word code){ exit((int)code); return 0; }\n"
"static word b_abort(void){ abort(); return 0; }\n"
"static word b_free(word p){ free(B_CPTR(p)); return 0; }\n"
        "\n"
        "/* Sign-extend 16-bit value to full word size. Used by 16-bit B programs on 64-bit hosts. */\n"
        "static word sx64(word x){\n"
        "    return (word)(int16_t)(x & 0xFFFF);\n"
        "}\n"
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
"/* Command line reread buffer */\n"
"static word b_reread(void);\n"
        "\n"
        "/* Helper functions for complex lvalue operations (avoid GNU C extensions) */\n"
        "/* All use safe W* macros to avoid host-C undefined behavior */\n"
        "static word b_preinc(word *p) { return (*p = WADD(*p, 1)); }\n"
        "static word b_predec(word *p) { return (*p = WSUB(*p, 1)); }\n"
        "static word b_postinc(word *p) { word old = WVAL(*p); *p = WADD(*p, 1); return old; }\n"
        "static word b_postdec(word *p) { word old = WVAL(*p); *p = WSUB(*p, 1); return old; }\n"
        "static word b_add_assign(word *p, word v) { return (*p = WADD(*p, v)); }\n"
        "static word b_sub_assign(word *p, word v) { return (*p = WSUB(*p, v)); }\n"
        "static word b_mul_assign(word *p, word v) { return (*p = WMUL(*p, v)); }\n"
        "static word b_div_assign(word *p, word v) { return (*p = WDIV(*p, v)); }\n"
        "static word b_mod_assign(word *p, word v) { return (*p = WMOD(*p, v)); }\n"
        "static word b_lsh_assign(word *p, word v) { return (*p = WSHL(*p, v)); }\n"
        "static word b_rsh_assign(word *p, word v) { return (*p = WSHR(*p, v)); }\n"
        "static word b_and_assign(word *p, word v) { return (*p = WAND(*p, v)); }\n"
        "static word b_or_assign(word *p, word v) { return (*p = WOR(*p, v)); }\n"
        "static word b_xor_assign(word *p, word v) { return (*p = WXOR(*p, v)); }\n"
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
        "/* B string access - byte packing within words.\n"
        " *\n"
        " * In B_BYTEPTR=0 mode, bytes are packed into words with byte 0 at the LSB.\n"
        " * This matches PDP-11 (little-endian) conventions. The shift-based approach\n"
        " * operates on word VALUES (not memory layout), making it consistent across\n"
        " * architectures: char(s,0) always returns the least-significant byte of the\n"
        " * word at address s, regardless of host endianness.\n"
        " *\n"
        " * Note: This only works correctly when ALL byte access goes through char()/lchar().\n"
        " * Mixing direct memory access (like C's *(char*)ptr) with B word operations will\n"
        " * give different results on big-endian hosts.\n"
        " */\n"
        "static word b_char(word s, word i){\n"
        "#if B_BYTEPTR\n"
        "    const unsigned char *p = (const unsigned char*)B_CPTR(s);\n"
        "    return (word)p[(size_t)i];\n"
        "#else\n"
        "    const uword W = (uword)sizeof(word);\n"
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
"static void __b_bstr_to_cstr(word s, char *buf, size_t max){\n"
"    size_t i = 0;\n"
"    while (i + 1 < max) {\n"
"        word ch = b_char(s, (word)i);\n"
"        if (ch == 004 || ch == 0) break;\n"
"        buf[i++] = (char)(ch & 0xFF);\n"
"    }\n"
"    buf[i] = 0;\n"
"}\n"
"\n"
"/* Convert a B string (004-terminated) into a temporary NUL-terminated C string */\n"
"static const char *__b_cstr(word s){\n"
"    static char *slots[4];\n"
"    static size_t caps[4];\n"
"    static int next = 0;\n"
"\n"
"    if (s == 0) return \"\";\n"
"\n"
"    size_t len = 0;\n"
"    for (;; len++) {\n"
"        word ch = b_char(s, (word)len);\n"
"        if (ch == 004 || ch == 0) break;\n"
"    }\n"
"\n"
"    int idx = next;\n"
"    next = (next + 1) & 3; /* simple ring buffer to survive multiple args */\n"
"\n"
"    size_t need = len + 1;\n"
"    if (need > caps[idx]) {\n"
"        size_t ncap = need < 64 ? 64 : need;\n"
"        char *nb = (char*)realloc(slots[idx], ncap);\n"
"        if (!nb) { fprintf(stderr, \"cstr: out of memory\\n\"); exit(1); }\n"
"        slots[idx] = nb;\n"
"        caps[idx] = ncap;\n"
"    }\n"
"\n"
"    for (size_t i = 0; i < len; i++) slots[idx][i] = (char)(b_char(s, (word)i) & 0xFF);\n"
"    slots[idx][len] = 0;\n"
"    return slots[idx];\n"
"}\n"
"\n"
"/* Duplicate a B string into a freshly allocated C string */\n"
"static char *__b_dup_bstr(word s){\n"
"    size_t cap = 64;\n"
"    char *buf = (char*)malloc(cap);\n"
"    if (!buf) { fprintf(stderr, \"system: out of memory\\n\"); exit(1); }\n"
"\n"
"    size_t i = 0;\n"
"    for (;;) {\n"
"        word ch = b_char(s, (word)i);\n"
"        if (ch == 004 || ch == 0) break;\n"
"        if (i + 1 >= cap) {\n"
"            size_t ncap = cap * 2;\n"
"            char *nbuf = (char*)realloc(buf, ncap);\n"
"            if (!nbuf) { free(buf); fprintf(stderr, \"system: out of memory\\n\"); exit(1); }\n"
"            buf = nbuf;\n"
"            cap = ncap;\n"
"        }\n"
"        buf[i++] = (char)(ch & 0xFF);\n"
"    }\n"
"    buf[i] = 0;\n"
"    return buf;\n"
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
"static word b_reread(void) {\n"
"    /* If no args, nothing to reread */\n"
"    if (__b_argc <= 1) {\n"
"        return 0;\n"
"    }\n"
"\n"
"    /* Compute total length of joined argv[0..] with spaces + newline */\n"
"    size_t total = 1; /* for trailing newline */\n"
"    for (int i = 0; i < __b_argc; i++) {\n"
"        total += strlen(__b_argv[i]);\n"
"        if (i + 1 < __b_argc) total += 1; /* space */\n"
"    }\n"
"    \n"
"    char *buf = (char*)malloc(total + 1);\n"
"    if (!buf) { fprintf(stderr, \"reread: out of memory\\n\"); exit(1); }\n"
"    \n"
"    size_t pos = 0;\n"
"    for (int i = 0; i < __b_argc; i++) {\n"
"        size_t len = strlen(__b_argv[i]);\n"
"        memcpy(buf + pos, __b_argv[i], len);\n"
"        pos += len;\n"
"        if (i + 1 < __b_argc) buf[pos++] = ' ';\n"
"    }\n"
"    buf[pos++] = '\\n';\n"
"    buf[pos] = '\\0';\n"
"    \n"
"    int p[2];\n"
"    if (pipe(p) != 0) { free(buf); fprintf(stderr, \"reread: pipe failed\\n\"); exit(1); }\n"
"    ssize_t wn = write(p[1], buf, pos);\n"
"    (void)wn;\n"
"    close(p[1]);\n"
"    free(buf);\n"
"    \n"
"    /* Close previous rd fd if it wasn't the terminal */\n"
"    if (rd_fd != 0 && rd_fd != p[0]) close(rd_fd);\n"
"    rd_fd = p[0];\n"
"    rd_unit = (word)0;\n"
"    __b_sync_rd();\n"
"    return 0;\n"
"}\n"
        "\n"
        "/* I/O functions */\n"
"static word b_getchr(void) {\n"
"    __b_sync_rd();\n"
"    unsigned char c;\n"
"    ssize_t n = read(rd_fd, &c, 1);\n"
"    if (n == 1) return (word)c;\n"
"    if (rd_fd != 0) {\n"
"        close(rd_fd);\n"
"        rd_fd = 0;\n"
"        rd_unit = -1;\n"
"        return b_getchr();\n"
"    }\n"
"    return (word)004; /* Return *e on EOF */\n"
"}\n"
"static word b_putchr(word w) {\n"
"    __b_sync_wr();\n"
"    unsigned char c = (unsigned char)(w & 0xFF);\n"
"    (void)write(wr_fd, &c, 1);\n"
"    return w;\n"
"}\n"
"static word b_putstr(word s) {\n"
"    __b_sync_wr();\n"
"    word i = 0;\n"
"    for (;;) {\n"
"        word ch = b_char(s, i++);\n"
"        if (ch == 004 || ch == 0) break;\n"
"        b_putchar(ch);\n"
        "    }\n"
        "    return s;\n"
        "}\n"
"static word b_getstr(word buf) {\n"
"    __b_sync_rd();\n"
"    size_t i = 0;\n"
"    unsigned char c;\n"
"    for (;;) {\n"
"        ssize_t n = read(rd_fd, &c, 1);\n"
"        if (n == 1 && c != '\\n' && c != '\\r') {\n"
"            b_lchar(buf, (word)i, (word)c);\n"
"            i++;\n"
"            continue;\n"
"        }\n"
"        if (n == 1) break; /* newline */\n"
"        if (rd_fd != 0) {\n"
"            close(rd_fd);\n"
"            rd_fd = 0;\n"
"            rd_unit = -1;\n"
"            continue; /* retry on terminal */\n"
"        }\n"
"        break; /* EOF */\n"
"    }\n"
"    b_lchar(buf, (word)i, (word)004);\n"
"    return buf;\n"
"}\n"
"static word b_flush(void){\n"
"    __b_sync_wr();\n"
"    if (wr_fd == 1) {\n"
"        fflush(stdout);\n"
"    } else {\n"
"        fsync(wr_fd);\n"
"    }\n"
        "    return 0;\n"
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
        "#if WORD_BITS == 16\n"
        "            int16_t v = (int16_t)arg;\n"
        "            if (v < 0){ b_putchar('-'); v = (int16_t)-v; }\n"
        "            if (v) b_printn_u((word)(uword)(uint16_t)v, 10);\n"
        "#elif WORD_BITS == 32\n"
        "            int32_t v = (int32_t)arg;\n"
        "            if (v < 0){ b_putchar('-'); v = -v; }\n"
        "            if (v) b_printn_u((word)(uword)(uint32_t)v, 10);\n"
        "#else\n"
        "            word v = arg;\n"
        "            if (v < 0){ b_putchar('-'); v = -v; }\n"
        "            if (v) b_printn_u((word)(uword)v, 10);\n"
        "#endif\n"
        "            else b_putchar('0');\n"
        "            break;\n"
        "        }\n"
        "        case 'o': {\n"
        "#if WORD_BITS == 16\n"
        "            uint16_t v = (uint16_t)arg;\n"
        "#elif WORD_BITS == 32\n"
        "            uint32_t v = (uint32_t)arg;\n"
        "#else\n"
        "            uword v = (uword)arg;\n"
        "#endif\n"
        "            if (v) b_printn_u((word)(uword)v, 8);\n"
        "            else b_putchar('0');\n"
        "            break;\n"
        "        }\n"
        "        case 'u': {\n"
        "            uword v = (uword)arg;\n"
        "            if (v) b_printn_u((word)v, 10);\n"
        "            else b_putchar('0');\n"
        "            break;\n"
        "        }\n"
        "        case 'p': {\n"
        "            uword v = (uword)arg;\n"
        "            b_putchar('0'); b_putchar('x');\n"
        "            int started = 0;\n"
        "            for (int shift = (int)(sizeof(uword)*8 - 4); shift >= 0; shift -= 4) {\n"
        "                int nib = (int)((v >> shift) & 0xF);\n"
        "                if (!started && nib == 0 && shift > 0) continue;\n"
        "                started = 1;\n"
        "                b_putchar((word)(nib < 10 ? ('0' + nib) : ('a' + nib - 10)));\n"
        "            }\n"
        "            if (!started) b_putchar('0');\n"
        "            break;\n"
        "        }\n"
        "        case 'z': {\n"
        "            word mod = b_char(fmt, i++);\n"
        "            if (mod == 'u') {\n"
        "                uword v = (uword)arg;\n"
        "                if (v) b_printn_u((word)v, 10);\n"
        "                else b_putchar('0');\n"
        "            } else if (mod == 'd') {\n"
        "                long v = (long)arg;\n"
        "                if (v < 0) { b_putchar('-'); v = -v; }\n"
        "                if (v) b_printn_u((word)(uword)v, 10);\n"
        "                else b_putchar('0');\n"
        "            } else {\n"
        "                b_putchar('%'); b_putchar('z'); b_putchar(mod);\n"
        "            }\n"
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
"static word b_openr(word fd, word name){\n"
"    char buf[512];\n"
"    __b_bstr_to_cstr(name, buf, sizeof(buf));\n"
"    int target = (int)fd;\n"
"    if (target < 0 || buf[0] == '\\0') {\n"
"        rd_fd = 0; rd_unit = -1; return 0;\n"
"    }\n"
"    int newfd = open(buf, O_RDONLY);\n"
"    if (rd_fd != 0 && rd_fd != target) close(rd_fd);\n"
"    if (newfd < 0) { rd_fd = -1; rd_unit = (word)target; return -1; }\n"
"    if (newfd != target) {\n"
"        if (dup2(newfd, target) < 0) { close(newfd); return -1; }\n"
"        close(newfd);\n"
"        newfd = target;\n"
"    }\n"
"    rd_fd = newfd;\n"
"    rd_unit = (word)target;\n"
"    return (word)newfd;\n"
"}\n"
"static word b_openw(word fd, word name){\n"
"    char buf[512];\n"
"    __b_bstr_to_cstr(name, buf, sizeof(buf));\n"
"    int target = (int)fd;\n"
"    if (target < 0 || buf[0] == '\\0') {\n"
"        wr_fd = 1; wr_unit = -1; return 1;\n"
"    }\n"
"    int newfd = open(buf, O_WRONLY | O_CREAT | O_TRUNC, 0666);\n"
"    if (newfd < 0) return -1;\n"
"    if (wr_fd != 1 && wr_fd != target && wr_fd != newfd) close(wr_fd);\n"
"    if (newfd != target) {\n"
"        if (dup2(newfd, target) < 0) { close(newfd); return -1; }\n"
"        close(newfd);\n"
"        newfd = target;\n"
"    }\n"
"    wr_fd = newfd;\n"
"    wr_unit = (word)target;\n"
"    return (word)newfd;\n"
"}\n"
"static word b_close(word fd) {\n"
"    int cfd = (int)fd;\n"
"    word r = (word)close(cfd);\n"
"    if (r == 0) {\n"
"        if (cfd == rd_fd || cfd == (int)rd_unit) { rd_fd = 0; rd_unit = -1; }\n"
"        if (cfd == wr_fd || cfd == (int)wr_unit) { wr_fd = 1; wr_unit = -1; }\n"
"    }\n"
"    return r;\n"
"}\n"
"static word b_read(word fd, word buf, word n) {\n"
"    char *p = (char*)B_CPTR(buf);\n"
"    if ((size_t)n < sizeof(word)) memset(p, 0, sizeof(word));\n"
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
        "static word __b_wait_status;\n"
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
"static word b_system(word cmd) {\n"
"    /* TSS-style: treat the string as a literal command line (no shell expansion) */\n"
"    char *line = __b_dup_bstr(cmd);\n"
"    if (!line) return -1;\n"
"\n"
"    char *argv[128];\n"
"    size_t argc = 0;\n"
"    char *p = line;\n"
"\n"
"    while (*p) {\n"
"        while (*p && isspace((unsigned char)*p)) p++;\n"
"        if (!*p) break;\n"
"        if (argc + 1 >= sizeof(argv)/sizeof(argv[0])) { free(line); return -1; }\n"
"        argv[argc++] = p;\n"
"        while (*p && !isspace((unsigned char)*p)) p++;\n"
"        if (*p) { *p = 0; p++; }\n"
"    }\n"
"\n"
"    if (argc == 0) { free(line); return -1; }\n"
"    argv[argc] = NULL;\n"
"\n"
"    pid_t pid = fork();\n"
"    if (pid == 0) {\n"
"        execvp(argv[0], argv);\n"
"        _exit(127);\n"
"    }\n"
"    if (pid < 0) { free(line); return -1; }\n"
"\n"
"    int st = 0;\n"
"    pid_t w = waitpid(pid, &st, 0);\n"
"    free(line);\n"
"    if (w < 0) return -1;\n"
"    return (word)st;\n"
"}\n"
"\n"
"static word b_usleep(word usec) {\n"
"    usleep((useconds_t)usec);\n"
"    return 0;\n"
"}\n"
"\n"
"static word b_callf_dispatch(int nargs, word name, ...) {\n"
"    static int __b_callf_dl_done = 0;\n"
"    if (!__b_callf_dl_done) {\n"
"        __b_callf_dl_done = 1;\n"
"        const char *env = getenv(\"B_CALLF_LIB\");\n"
"        if (env && *env) {\n"
"            const char *p = env;\n"
"            while (*p) {\n"
"                const char *start = p;\n"
"                while (*p && *p != ':') p++;\n"
"                size_t len = (size_t)(p - start);\n"
"                if (len) {\n"
"                    char *path = (char*)malloc(len + 1);\n"
"                    if (path) {\n"
"                        memcpy(path, start, len);\n"
"                        path[len] = '\\0';\n"
"                        (void)dlopen(path, RTLD_NOW | RTLD_GLOBAL);\n"
"                        free(path);\n"
"                    }\n"
"                }\n"
"                if (*p == ':') p++;\n"
"            }\n"
"        }\n"
"    }\n"
"    if (nargs < 0 || nargs > 10) return -1;\n"
"    if (name == 0) return -1;\n"
" \n"
"    char sym[256];\n"
"    __b_bstr_to_cstr(name, sym, sizeof(sym));\n"
" \n"
"    void *fn = dlsym(RTLD_DEFAULT, sym);\n"
"    if (!fn) {\n"
"        size_t len = strlen(sym);\n"
"        if (len + 2 < sizeof(sym)) {\n"
"            sym[len] = '_'; sym[len + 1] = '\\0';\n"
"            fn = dlsym(RTLD_DEFAULT, sym);\n"
"            sym[len] = '\\0';\n"
"        }\n"
"    }\n"
"    if (!fn) return -1;\n"
" \n"
"    void *args[10] = {0};\n"
"    va_list ap;\n"
"    va_start(ap, name);\n"
"    for (int i = 0; i < nargs && i < 10; i++) {\n"
"        word w = va_arg(ap, word);\n"
"        args[i] = B_CPTR(w);\n"
"    }\n"
"    va_end(ap);\n"
" \n"
"    word r = 0;\n"
"    switch (nargs) {\n"
"    case 0: r = ((word (*)(void))fn)(); break;\n"
"    case 1: r = ((word (*)(void*))fn)(args[0]); break;\n"
"    case 2: r = ((word (*)(void*, void*))fn)(args[0], args[1]); break;\n"
"    case 3: r = ((word (*)(void*, void*, void*))fn)(args[0], args[1], args[2]); break;\n"
"    case 4: r = ((word (*)(void*, void*, void*, void*))fn)(args[0], args[1], args[2], args[3]); break;\n"
"    case 5: r = ((word (*)(void*, void*, void*, void*, void*))fn)(args[0], args[1], args[2], args[3], args[4]); break;\n"
"    case 6: r = ((word (*)(void*, void*, void*, void*, void*, void*))fn)(args[0], args[1], args[2], args[3], args[4], args[5]); break;\n"
"    case 7: r = ((word (*)(void*, void*, void*, void*, void*, void*, void*))fn)(args[0], args[1], args[2], args[3], args[4], args[5], args[6]); break;\n"
"    case 8: r = ((word (*)(void*, void*, void*, void*, void*, void*, void*, void*))fn)(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]); break;\n"
"    case 9: r = ((word (*)(void*, void*, void*, void*, void*, void*, void*, void*, void*))fn)(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]); break;\n"
"    case 10: r = ((word (*)(void*, void*, void*, void*, void*, void*, void*, void*, void*, void*))fn)(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9]); break;\n"
"    default: return -1;\n"
"    }\n"
"    return r;\n"
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
        "\n",
        out
    );

    // Emit Thompson B packed strings (works for both pointer modes)
    if (string_pool.len > 0) {
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
            fputs("extern word ", out);
            emit_name(out, item->name);
            fputs(";\n", out);
            continue;
        }

        if (t->kind == TOP_EXTERN_DEF) {
            ExternItem *item = t->as.ext_def;
            const char *mname = get_mangled_name(item->name);
            if (item->as.var.vkind == EXTVAR_BLOB) {
                int is_single_str =
                    item->as.var.init &&
                    item->as.var.init->kind == INIT_LIST &&
                    item->as.var.init->as.list.len == 1 &&
                    ((Init*)item->as.var.init->as.list.data[0])->kind == INIT_EXPR &&
                    ((Init*)item->as.var.init->as.list.data[0])->as.expr &&
                    ((Init*)item->as.var.init->as.list.data[0])->as.expr->kind == EX_STR;

                if (is_single_str) {
                    fprintf(out, "word %s;\n", mname);
                    continue;
                }

                // Blob external: contiguous words at &name
                size_t base_len = (item->as.var.init && item->as.var.init->kind == INIT_LIST) ? init_list_length(item->as.var.init) : 1;
                size_t tail     = (item->as.var.init && item->as.var.init->kind == INIT_LIST) ? edge_tail_words_top(item->as.var.init) : 0;
                size_t total    = base_len + tail;
                if (total == 0) total = 1;
                fprintf(out, "static word __%s_blob[%zu];\n", mname, total);
                fprintf(out, "word %s;\n", mname);
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

                fprintf(out, "static word __%s_store[%zu];\n", mname, total);
                fprintf(out, "word %s;\n", mname);
            } else {
                // Scalar external
                if (item->is_implicit_static) {
                    fprintf(out, "static word %s;\n", mname);
                } else {
                    fprintf(out, "word %s;\n", mname);
                }
            }
            continue;
        }
    }

    // Emit __b_init function
    fputs("static void __b_init(void) {\n", out);
    fputs("    setvbuf(stdout, NULL, _IONBF, 0);\n", out);
    for (size_t i = 0; i < prog->tops.len; i++) {
        Top *t = (Top*)prog->tops.data[i];
        if (t->kind == TOP_EXTERN_DEF) {
            ExternItem *item = t->as.ext_def;
            const char *mname = get_mangled_name(item->name);

            if (item->as.var.vkind == EXTVAR_SCALAR && item->as.var.init && item->as.var.init->kind == INIT_EXPR) {
                fprintf(out, "    %s = ", mname);
                emit_ival_expr(out, item->as.var.init->as.expr, filename);
                fputs(";\n", out);
            } else if (item->as.var.vkind == EXTVAR_BLOB) {
                int is_single_str =
                    item->as.var.init &&
                    item->as.var.init->kind == INIT_LIST &&
                    item->as.var.init->as.list.len == 1 &&
                    ((Init*)item->as.var.init->as.list.data[0])->kind == INIT_EXPR &&
                    ((Init*)item->as.var.init->as.list.data[0])->as.expr &&
                    ((Init*)item->as.var.init->as.list.data[0])->as.expr->kind == EX_STR;
                if (is_single_str) {
                    fprintf(out, "    %s = ", mname);
                    emit_ival_expr(out, ((Init*)item->as.var.init->as.list.data[0])->as.expr, filename);
                    fputs(";\n", out);
                    continue;
                }
                // Set blob pointer to backing store (or scalar if size 1)
                size_t base_len = (item->as.var.init && item->as.var.init->kind == INIT_LIST) ? init_list_length(item->as.var.init) : 1;
                size_t tail     = (item->as.var.init && item->as.var.init->kind == INIT_LIST) ? edge_tail_words_top(item->as.var.init) : 0;
                size_t total    = base_len + tail;
                // Initialize blob elements + edge subvectors in tail if present
                if (item->as.var.init && item->as.var.init->kind == INIT_LIST) {
                    char buf[256];
                    snprintf(buf, sizeof(buf), "__%s_blob", mname);
                    (void)emit_edge_list_init(out, buf, 0, item->as.var.init, base_len, 2, filename);
                }
                if (total == 1 || (base_len <= 1 && tail == 0)) {
                    fprintf(out, "    %s = __%s_blob[0];\n", mname, mname);
                } else {
                    fprintf(out, "    %s = B_ADDR(__%s_blob[0]);\n", mname, mname);
                }
            } else if (item->as.var.vkind == EXTVAR_VECTOR) {
                // Set vector pointer
                fprintf(out, "    %s = B_ADDR(__%s_store[0]);\n", mname, mname);
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
                        snprintf(buf, sizeof(buf), "__%s_store", mname);
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
                /* No 'static' - functions need external linkage for multi-file */
                fputs("word ", out);
                emit_name(out, f->name);
                fputc('(', out);
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
    size_t main_param_count = 0;
    for (size_t i = 0; i < prog->tops.len; i++) {
        Top *t = (Top*)prog->tops.data[i];

        if (t->kind == TOP_FUNC) {
            Func *f = t->as.fn;
            if (strcmp(f->name, "main") == 0 || strcmp(f->name, "b_main") == 0) {
                has_main = 1;
                main_param_count = f->params.len;
                // Rename main to __b_user_main
                fprintf(out, "word __b_user_main(");
            } else {
                fputs("word ", out);
                emit_name(out, f->name);
                fputc('(', out);
            }
            for (size_t p = 0; p < f->params.len; p++) {
                if (p) fputs(", ", out);
                fputs("word ", out);
                emit_name(out, (char*)f->params.data[p]);
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
        if (main_param_count == 0) {
            fputs("    return (int)__b_user_main();\n", out);
        } else if (main_param_count == 1) {
            fputs("    return (int)__b_user_main((word)argc);\n", out);
        } else if (main_param_count == 2) {
            fputs("    return (int)__b_user_main((word)argc, B_PTR(__b_argvb));\n", out);
        } else {
            // For more parameters, we don't support yet
            fputs("    return (int)__b_user_main();\n", out);
        }
        fputs("}\n", out);
    }
}

// ===================== External Runtime Emitter =====================

// Global for libb path (set by main.c)
const char *g_libb_path = NULL;

void emit_program_c_ext(FILE *out, Program *prog, const char *filename, int byteptr, int no_line, int word_bits, int use_libb) {
    if (!use_libb) {
        // Fall back to inline runtime
        emit_program_c(out, prog, filename, byteptr, no_line, word_bits);
        return;
    }

    current_byteptr = byteptr;
    current_word_bits = word_bits;
    string_pool.data = NULL;
    string_pool.len = 0;
    string_pool.cap = 0;

    // Clear name mangling map for fresh compilation
    clear_name_map();

    collect_strings_program(prog);

    // Emit minimal preamble - configuration defines before including libb.h
    fprintf(out, "/* Generated by BCC - B Compiler */\n");
    fprintf(out, "#define B_BYTEPTR %d\n", byteptr ? 1 : 0);
    fprintf(out, "#define WORD_BITS %d\n", word_bits);
    fprintf(out, "#include \"libb.h\"\n\n");

    // Emit ncurses/panel if needed (libb.h doesn't include these heavy deps)
    fputs("#include <ncurses.h>\n", out);
    fputs("#include <panel.h>\n\n", out);

    // Emit Thompson B packed strings (still per-file)
    if (string_pool.len > 0) {
        emit_string_pool(out);
        fputc('\n', out);
    }

    // First pass: emit all global declarations and storage
    for (size_t i = 0; i < prog->tops.len; i++) {
        Top *t = (Top*)prog->tops.data[i];

        if (t->kind == TOP_GAUTO) {
            emit_stmt(out, t->as.gauto, 0, 0, filename);
            fputc('\n', out);
            continue;
        }

        if (t->kind == TOP_EXTERN_DECL) {
            ExternItem *item = t->as.ext_decl;
            fputs("extern word ", out);
            emit_name(out, item->name);
            fputs(";\n", out);
            continue;
        }

        if (t->kind == TOP_EXTERN_DEF) {
            ExternItem *item = t->as.ext_def;
            const char *mname = get_mangled_name(item->name);
            if (item->as.var.vkind == EXTVAR_BLOB) {
                int is_single_str =
                    item->as.var.init &&
                    item->as.var.init->kind == INIT_LIST &&
                    item->as.var.init->as.list.len == 1 &&
                    ((Init*)item->as.var.init->as.list.data[0])->kind == INIT_EXPR &&
                    ((Init*)item->as.var.init->as.list.data[0])->as.expr &&
                    ((Init*)item->as.var.init->as.list.data[0])->as.expr->kind == EX_STR;

                if (is_single_str) {
                    fprintf(out, "word %s;\n", mname);
                    continue;
                }

                size_t base_len = (item->as.var.init && item->as.var.init->kind == INIT_LIST) ? init_list_length(item->as.var.init) : 1;
                size_t tail     = (item->as.var.init && item->as.var.init->kind == INIT_LIST) ? edge_tail_words_top(item->as.var.init) : 0;
                size_t total    = base_len + tail;
                if (total == 0) total = 1;
                fprintf(out, "static word __%s_blob[%zu];\n", mname, total);
                fprintf(out, "word %s;\n", mname);
            } else if (item->as.var.vkind == EXTVAR_VECTOR) {
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

                fprintf(out, "static word __%s_store[%zu];\n", mname, total);
                fprintf(out, "word %s;\n", mname);
            } else {
                if (item->is_implicit_static) {
                    fprintf(out, "static word %s;\n", mname);
                } else {
                    fprintf(out, "word %s;\n", mname);
                }
            }
            continue;
        }
    }

    // Emit per-file __b_init_file function for this file's globals
    // Create a safe init function name from program pointer (unique per compilation)
    fprintf(out, "\nstatic void __b_init_file_%p(void) {\n", (void*)prog);
    for (size_t i = 0; i < prog->tops.len; i++) {
        Top *t = (Top*)prog->tops.data[i];
        if (t->kind == TOP_EXTERN_DEF) {
            ExternItem *item = t->as.ext_def;
            const char *mname = get_mangled_name(item->name);

            if (item->as.var.vkind == EXTVAR_SCALAR && item->as.var.init && item->as.var.init->kind == INIT_EXPR) {
                fprintf(out, "    %s = ", mname);
                emit_ival_expr(out, item->as.var.init->as.expr, filename);
                fputs(";\n", out);
            } else if (item->as.var.vkind == EXTVAR_BLOB) {
                int is_single_str =
                    item->as.var.init &&
                    item->as.var.init->kind == INIT_LIST &&
                    item->as.var.init->as.list.len == 1 &&
                    ((Init*)item->as.var.init->as.list.data[0])->kind == INIT_EXPR &&
                    ((Init*)item->as.var.init->as.list.data[0])->as.expr &&
                    ((Init*)item->as.var.init->as.list.data[0])->as.expr->kind == EX_STR;
                if (is_single_str) {
                    fprintf(out, "    %s = ", mname);
                    emit_ival_expr(out, ((Init*)item->as.var.init->as.list.data[0])->as.expr, filename);
                    fputs(";\n", out);
                    continue;
                }
                size_t base_len = (item->as.var.init && item->as.var.init->kind == INIT_LIST) ? init_list_length(item->as.var.init) : 1;
                size_t tail     = (item->as.var.init && item->as.var.init->kind == INIT_LIST) ? edge_tail_words_top(item->as.var.init) : 0;
                size_t total    = base_len + tail;
                if (item->as.var.init && item->as.var.init->kind == INIT_LIST) {
                    char buf[256];
                    snprintf(buf, sizeof(buf), "__%s_blob", mname);
                    (void)emit_edge_list_init(out, buf, 0, item->as.var.init, base_len, 2, filename);
                }
                if (total == 1 || (base_len <= 1 && tail == 0)) {
                    fprintf(out, "    %s = __%s_blob[0];\n", mname, mname);
                } else {
                    fprintf(out, "    %s = B_ADDR(__%s_blob[0]);\n", mname, mname);
                }
            } else if (item->as.var.vkind == EXTVAR_VECTOR) {
                fprintf(out, "    %s = B_ADDR(__%s_store[0]);\n", mname, mname);
                if (item->as.var.init && item->as.var.init->kind == INIT_LIST) {
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

                    char buf[256];
                    snprintf(buf, sizeof(buf), "__%s_store", mname);
                    (void)emit_edge_list_init(out, buf, 0, item->as.var.init, outer_len, 2, filename);
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
                fputs("word ", out);
                emit_name(out, f->name);
                fputc('(', out);
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
    size_t main_param_count = 0;
    for (size_t i = 0; i < prog->tops.len; i++) {
        Top *t = (Top*)prog->tops.data[i];

        if (t->kind == TOP_FUNC) {
            Func *f = t->as.fn;
            if (strcmp(f->name, "main") == 0 || strcmp(f->name, "b_main") == 0) {
                has_main = 1;
                main_param_count = f->params.len;
                fprintf(out, "word __b_user_main(");
            } else {
                fputs("word ", out);
                emit_name(out, f->name);
                fputc('(', out);
            }
            for (size_t p = 0; p < f->params.len; p++) {
                if (p) fputs(", ", out);
                fputs("word ", out);
                emit_name(out, (char*)f->params.data[p]);
            }
            fputs(")\n", out);
            emit_stmt(out, f->body, 0, 1, filename);
            fputc('\n', out);
            continue;
        }
    }

    // Emit wrapper main if user defined main
    if (has_main) {
        fputs("int main(int argc, char **argv){\n", out);
        fputs("    __b_setargs(argc, argv);\n", out);
        fputs("    __b_init();\n", out);
        fprintf(out, "    __b_init_file_%p();\n", (void*)prog);
        if (main_param_count == 0) {
            fputs("    return (int)__b_user_main();\n", out);
        } else if (main_param_count == 1) {
            fputs("    return (int)__b_user_main((word)argc);\n", out);
        } else if (main_param_count == 2) {
            fputs("    word *__b_argvb_ptr = (word*)B_CPTR(b_argv(0));\n", out);
            fputs("    return (int)__b_user_main((word)argc, B_PTR(__b_argvb_ptr - 1));\n", out);
        } else {
            fputs("    return (int)__b_user_main();\n", out);
        }
        fputs("}\n", out);
    } else {
        // If no main in this file, we still need to call the per-file init
        // This will be called from the file that has main()
        // Export the init function for linking
        fprintf(out, "void __b_init_file_%p_export(void) __attribute__((constructor));\n", (void*)prog);
        fprintf(out, "void __b_init_file_%p_export(void) { __b_init_file_%p(); }\n", (void*)prog, (void*)prog);
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
                emit_name(out, f->name);
                fputs(":\n", out);
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
