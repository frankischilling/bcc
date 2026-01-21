// util.c
#include "bcc.h"
#include <unistd.h>

// Global arena for compilation
Arena *g_compilation_arena = NULL;

// Include search paths (-I options)
Vec g_include_paths;

// Already included files (for caching)
Vec g_included_files;

// Currently parsing files (for recursion detection)
Vec g_parsing_files;

// Developer flags
int g_no_line = 0;
int g_verbose_errors = 0;

// Dialect and extension flags
int g_strict = 0;                     // Default: modern mode (extensions allowed)
unsigned g_extensions = EXT_ALL;      // Default: all extensions enabled
int g_pedantic = 0;                   // Default: don't error on extensions

// Resolve an include path, checking:
// 1. As given (absolute or relative to cwd)
// 2. Relative to current file's directory
// 3. In include search paths (-I)
char *resolve_include_path(const char *include_name, const char *current_file) {
    // First, try the path as given
    if (access(include_name, F_OK) == 0) {
        return sdup(include_name);
    }

    // If current_file is provided, try relative to its directory
    if (current_file) {
        char *dir_end = strrchr(current_file, '/');
        if (dir_end) {
            size_t dir_len = dir_end - current_file + 1;
            char *dir_path = (char*)malloc(dir_len + strlen(include_name) + 1);
            if (!dir_path) dief("out of memory");
            memcpy(dir_path, current_file, dir_len);
            strcpy(dir_path + dir_len, include_name);
            if (access(dir_path, F_OK) == 0) {
                char *result = sdup(dir_path);
                free(dir_path);
                return result;
            }
            free(dir_path);
        }
    }

    // Try each include search path
    for (size_t i = 0; i < g_include_paths.len; i++) {
        const char *search_path = (const char*)g_include_paths.data[i];
        char *full_path = (char*)malloc(strlen(search_path) + strlen(include_name) + 2);
        if (!full_path) dief("out of memory");
        sprintf(full_path, "%s/%s", search_path, include_name);
        if (access(full_path, F_OK) == 0) {
            char *result = sdup(full_path);
            free(full_path);
            return result;
        }
        free(full_path);
    }

    return NULL; // not found
}

// Dump token stream for debugging
void dump_token_stream(Parser *P) {
    printf("Tokens:\n");
    
    // Create a completely separate lexer by re-reading the file
    size_t len;
    char *src = read_file_all(P->L.filename, &len);
    if (!src) {
        printf("  (cannot re-read file for token dump)\n");
        return;
    }
    
    Lexer temp_lexer;
    temp_lexer.src = src;
    temp_lexer.len = len;
    temp_lexer.i = 0;
    temp_lexer.line = 1;
    temp_lexer.col = 1;
    temp_lexer.filename = P->L.filename;
    
    Token tok = lx_next(&temp_lexer);
    
    while (tok.kind != TK_EOF) {
        printf("  %s", tk_name(tok.kind));
        if (tok.lexeme) {
            printf(" '%s'", tok.lexeme);
        }
        if (tok.kind == TK_NUM) {
            printf(" %ld", tok.num);
        }
        printf(" at %s:%d:%d\n", tok.filename, tok.line, tok.col);
        tok = lx_next(&temp_lexer);
    }
    printf("\n");
    
    free(src);
}

// Forward declarations for AST dumping
void dump_expr(Expr *e, int indent);
void dump_stmt(Stmt *s, int indent);
void dump_type(Expr *e, int indent);

// Dump AST for debugging
void dump_ast_program(Program *prog) {
    printf("AST:\n");
    for (size_t i = 0; i < prog->tops.len; i++) {
        Top *t = (Top*)prog->tops.data[i];
        printf("Top level %zu:\n", i);
        switch (t->kind) {
            case TOP_GAUTO:
                printf("  GAUTO\n");
                break;
            case TOP_FUNC:
                printf("  FUNC %s\n", t->as.fn->name);
                dump_stmt(t->as.fn->body, 2);
                break;
            case TOP_EXTERN_DEF:
                printf("  EXTERN_DEF\n");
                break;
            case TOP_EXTERN_DECL:
                printf("  EXTERN_DECL\n");
                break;
        }
    }
    printf("\n");
}

void dump_expr(Expr *e, int indent) {
    for (int i = 0; i < indent; i++) printf(" ");
    if (!e) {
        printf("(null)\n");
        return;
    }
    switch (e->kind) {
        case EX_NUM:
            printf("NUM %ld\n", e->as.num);
            break;
        case EX_STR:
            printf("STR \"%s\"\n", e->as.str);
            break;
        case EX_VAR:
            printf("VAR %s\n", e->as.var);
            break;
        case EX_UNARY:
            printf("UNARY %s\n", tk_name(e->as.unary.op));
            dump_expr(e->as.unary.rhs, indent + 2);
            break;
        case EX_BINARY:
            printf("BINARY %s\n", tk_name(e->as.bin.op));
            dump_expr(e->as.bin.lhs, indent + 2);
            dump_expr(e->as.bin.rhs, indent + 2);
            break;
        case EX_ASSIGN:
            printf("ASSIGN %s\n", tk_name(e->as.assign.op));
            dump_expr(e->as.assign.lhs, indent + 2);
            dump_expr(e->as.assign.rhs, indent + 2);
            break;
        case EX_INDEX:
            printf("INDEX\n");
            dump_expr(e->as.index.base, indent + 2);
            dump_expr(e->as.index.idx, indent + 2);
            break;
        case EX_POST:
            printf("POST %s\n", tk_name(e->as.post.op));
            dump_expr(e->as.post.lhs, indent + 2);
            break;
        default:
            printf("EXPR kind %d\n", e->kind);
    }
}

void dump_stmt(Stmt *s, int indent) {
    for (int i = 0; i < indent; i++) printf(" ");
    if (!s) {
        printf("(null)\n");
        return;
    }
    switch (s->kind) {
        case ST_EMPTY:
            printf("EMPTY\n");
            break;
        case ST_BLOCK:
            printf("BLOCK\n");
            for (size_t i = 0; i < s->as.block.items.len; i++) {
                dump_stmt((Stmt*)s->as.block.items.data[i], indent + 2);
            }
            break;
        case ST_AUTO:
            printf("AUTO\n");
            break;
        case ST_IF:
            printf("IF\n");
            dump_expr(s->as.ifs.cond, indent + 2);
            dump_stmt(s->as.ifs.then_s, indent + 2);
            if (s->as.ifs.else_s) {
                for (int i = 0; i < indent + 2; i++) printf(" ");
                printf("ELSE\n");
                dump_stmt(s->as.ifs.else_s, indent + 2);
            }
            break;
        case ST_WHILE:
            printf("WHILE\n");
            dump_expr(s->as.whiles.cond, indent + 2);
            dump_stmt(s->as.whiles.body, indent + 2);
            break;
        case ST_RETURN:
            printf("RETURN\n");
            if (s->as.ret.val) {
                dump_expr(s->as.ret.val, indent + 2);
            }
            break;
        case ST_EXPR:
            printf("EXPR\n");
            dump_expr(s->as.expr.e, indent + 2);
            break;
        default:
            printf("STMT kind %d\n", s->kind);
    }
}

void dief(const char *fmt_s, ...) {
    va_list ap;
    va_start(ap, fmt_s);
    fprintf(stderr, "bcc: ");
    vfprintf(stderr, fmt_s, ap);
    fprintf(stderr, "\n");
    va_end(ap);
    exit(1);
}

void error_at(Token *tok, const char *src, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);

    if (g_verbose_errors) {
        // Verbose format
        fprintf(stderr, "%s:%d:%d: ", tok->filename, tok->line, tok->col);
        vfprintf(stderr, fmt, ap);
        fprintf(stderr, "\n");
    } else {
        // Historic 2-letter code format (use "sx" for general syntax errors)
        fprintf(stderr, "sx %s:%d\n", tok->filename, tok->line);
    }
    va_end(ap);

    // Find the line containing the error
    const char *line_start = src;
    int current_line = 1;
    for (size_t i = 0; i < strlen(src) && current_line < tok->line; i++) {
        if (src[i] == '\n') {
            current_line++;
            line_start = &src[i + 1];
        }
    }

    // Find the end of the line
    const char *line_end = line_start;
    while (*line_end && *line_end != '\n') {
        line_end++;
    }

    // Print the line
    fprintf(stderr, "    ");
    for (const char *p = line_start; p < line_end; p++) {
        fputc(*p, stderr);
    }
    fprintf(stderr, "\n");

    // Print the caret
    fprintf(stderr, "    ");
    for (int i = 1; i < tok->col; i++) {
        fputc(' ', stderr);
    }
    fprintf(stderr, "^\n");

    exit(1);
}

void error_at_code(Token *tok, const char *src, ErrorCode code, const char *extra_info) {
    if (g_verbose_errors) {
        // Use verbose error message format
        fprintf(stderr, "%s:%d:%d: error: %s", tok->filename, tok->line, tok->col, get_error_message(code));
        if (extra_info && *extra_info) {
            fprintf(stderr, " '%s'", extra_info);
        }
        fprintf(stderr, "\n");
    } else {
        // Use historic two-letter code format
        fprintf(stderr, "%s %s:%d\n", get_error_code(code), tok->filename, tok->line);
    }

    // Find the line containing the error
    const char *line_start = src;
    int current_line = 1;
    for (size_t i = 0; i < strlen(src) && current_line < tok->line; i++) {
        if (src[i] == '\n') {
            current_line++;
            line_start = &src[i + 1];
        }
    }

    // Find the end of the line
    const char *line_end = line_start;
    while (*line_end && *line_end != '\n') {
        line_end++;
    }

    // Print the line
    fprintf(stderr, "    ");
    for (const char *p = line_start; p < line_end; p++) {
        fputc(*p, stderr);
    }
    fprintf(stderr, "\n");

    // Print the caret
    fprintf(stderr, "    ");
    for (int i = 1; i < tok->col; i++) {
        fputc(' ', stderr);
    }
    fprintf(stderr, "^\n");

    exit(1);
}

void error_at_location(const char *filename, int line, int col, ErrorCode code, const char *extra_info) {
    if (g_verbose_errors) {
        // Use verbose error message format
        fprintf(stderr, "%s:%d:%d: error: %s", filename, line, col, get_error_message(code));
        if (extra_info && *extra_info) {
            fprintf(stderr, " '%s'", extra_info);
        }
        fprintf(stderr, "\n");
    } else {
        // Use historic two-letter code format
        fprintf(stderr, "%s %s:%d\n", get_error_code(code), filename, line);
    }

    exit(1);
}

char *xstrdup_range(const char *s, size_t a, size_t b) {
    size_t n = (b > a) ? (b - a) : 0;
    if (g_compilation_arena) {
        return arena_xstrdup_range(g_compilation_arena, s, a, b);
    }
    char *p = (char*)malloc(n + 1);
    if (!p) dief("out of memory");
    memcpy(p, s + a, n);
    p[n] = 0;
    return p;
}

char *sdup(const char *s) {
    if (!s) return NULL;
    if (g_compilation_arena) {
        return arena_sdup(g_compilation_arena, s);
    }
    size_t n = strlen(s);
    char *p = (char*)malloc(n + 1);
    if (!p) dief("out of memory");
    memcpy(p, s, n + 1);
    return p;
}

char *fmt(const char *fmt_s, ...) {
    va_list ap, ap2;
    va_start(ap, fmt_s);
    va_copy(ap2, ap);
    int n = vsnprintf(NULL, 0, fmt_s, ap);
    va_end(ap);
    if (n < 0) dief("fmt: vsnprintf failed");

    if (g_compilation_arena) {
        va_start(ap, fmt_s);
        char *buf = arena_fmt(g_compilation_arena, fmt_s, ap);
        va_end(ap);
        return buf;
    }

    char *buf = (char*)malloc((size_t)n + 1);
    if (!buf) dief("out of memory");
    vsnprintf(buf, (size_t)n + 1, fmt_s, ap2);
    va_end(ap2);
    return buf;
}

Vec *vec_new(void) {
    if (g_compilation_arena) {
        Vec *v = (Vec*)arena_alloc(g_compilation_arena, sizeof(*v));
        memset(v, 0, sizeof(*v));
        return v;
    }
    Vec *v = (Vec*)calloc(1, sizeof(*v));
    if (!v) dief("out of memory");
    return v;
}

void vec_push(Vec *v, void *p) {
    if (v->len == v->cap) {
        size_t newcap = v->cap ? v->cap * 2 : 8;
        if (g_compilation_arena) {
            // For arena allocation, allocate new space and copy
            void **nd = (void**)arena_alloc(g_compilation_arena, newcap * sizeof(void*));
            if (v->data) {
                memcpy(nd, v->data, v->len * sizeof(void*));
            }
            v->data = nd;
        } else {
            void **nd = (void**)realloc(v->data, newcap * sizeof(void*));
            if (!nd) dief("out of memory");
            v->data = nd;
        }
        v->cap = newcap;
    }
    v->data[v->len++] = p;
}

void *xmalloc(size_t n) {
    if (g_compilation_arena) {
        return arena_alloc(g_compilation_arena, n);
    }
    void *p = malloc(n);
    if (!p) dief("out of memory");
    return p;
}

// ===================== Error Code Functions =====================

const char *get_error_code(ErrorCode code) {
    switch (code) {
        case ERR_BRACE_IMBALANCE:   return "$)";
        case ERR_PAREN_IMBALANCE:   return "()";
        case ERR_COMMENT_IMBALANCE: return "*/";
        case ERR_BRACKET_IMBALANCE: return "[]";
        case ERR_CASE_OVERFLOW:     return ">c";
        case ERR_EXPR_STACK_OVERFLOW: return ">e";
        case ERR_LABEL_OVERFLOW:    return ">i";
        case ERR_SYMBOL_OVERFLOW:   return ">s";
        case ERR_EXPR_SYNTAX:       return "ex";
        case ERR_RVALUE_LVALUE:     return "lv";
        case ERR_REDECLARATION:     return "rd";
        case ERR_STMT_SYNTAX:       return "sx";
        case ERR_UNDEFINED_NAME:    return "un";
        case ERR_EXTERNAL_SYNTAX:   return "xx";
        default:                    return "??";
    }
}

const char *get_error_message(ErrorCode code) {
    switch (code) {
        case ERR_BRACE_IMBALANCE:   return "{} imbalance";
        case ERR_PAREN_IMBALANCE:   return "() imbalance";
        case ERR_COMMENT_IMBALANCE: return "/* */ imbalance";
        case ERR_BRACKET_IMBALANCE: return "[] imbalance";
        case ERR_CASE_OVERFLOW:     return "case table overflow (fatal)";
        case ERR_EXPR_STACK_OVERFLOW: return "expression stack overflow (fatal)";
        case ERR_LABEL_OVERFLOW:    return "label table overflow (fatal)";
        case ERR_SYMBOL_OVERFLOW:   return "symbol table overflow (fatal)";
        case ERR_EXPR_SYNTAX:       return "expression syntax";
        case ERR_RVALUE_LVALUE:     return "rvalue where lvalue expected";
        case ERR_REDECLARATION:     return "name redeclaration";
        case ERR_STMT_SYNTAX:       return "statement syntax";
        case ERR_UNDEFINED_NAME:    return "undefined name";
        case ERR_EXTERNAL_SYNTAX:   return "external syntax";
        default:                    return "unknown error";
    }
}