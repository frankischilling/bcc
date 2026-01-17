// sem.c - semantic analysis (symbol table + scoping)

#include "bcc.h"

// ===================== Symbol Table Implementation =====================

// Forward declarations
static void sem_add_builtin_functions(SemState *st);
static void sem_check_switch_fallthrough(SemState *st, Stmt *switch_stmt);

static Symbol *symbol_new(SymbolKind kind, const char *name, int line, int col) {
    Symbol *sym = xmalloc(sizeof(*sym));
    sym->kind = kind;
    sym->name = sdup(name);
    sym->line = line;
    sym->col = col;
    sym->is_extern = 0;
    return sym;
}

static void symbol_free(Symbol *sym) {
    // Don't free if arena-allocated - the arena will handle it
    (void)sym; // suppress unused parameter warning
}

static Scope *scope_new(Scope *parent) {
    Scope *s = xmalloc(sizeof(*s));
    s->parent = parent;
    s->symbols.data = NULL;
    s->symbols.len = 0;
    s->symbols.cap = 0;
    return s;
}

static void scope_free(Scope *s) {
    // Don't free if arena-allocated - the arena will handle it
    (void)s; // suppress unused parameter warning
}

static SemState *sem_state_new(const char *filename) {
    SemState *st = xmalloc(sizeof(*st));
    st->filename = filename;
    st->current = scope_new(NULL); // global scope
    st->extern_names.data = NULL;
    st->extern_names.len = 0;
    st->extern_names.cap = 0;
    st->function_names.data = NULL;
    st->function_names.len = 0;
    st->function_names.cap = 0;
    st->implicit_statics.data = NULL;
    st->implicit_statics.len = 0;
    st->implicit_statics.cap = 0;

    // Add builtin functions
    sem_add_builtin_functions(st);

    return st;
}

static void sem_state_free(SemState *st) {
    // Don't free anything if arena-allocated - the arena will handle it
    (void)st; // suppress unused parameter warning
}

// Find symbol in current scope or parent scopes
static Symbol *scope_find(Scope *scope, const char *name) {
    for (Scope *s = scope; s; s = s->parent) {
        for (size_t i = 0; i < s->symbols.len; i++) {
            Symbol *sym = s->symbols.data[i];
            if (strcmp(sym->name, name) == 0) {
                return sym;
            }
        }
    }
    return NULL;
}

// Check if symbol exists in current scope only
static int scope_has_in_current(Scope *scope, const char *name) {
    for (size_t i = 0; i < scope->symbols.len; i++) {
        Symbol *sym = scope->symbols.data[i];
        if (strcmp(sym->name, name) == 0) {
            return 1;
        }
    }
    return 0;
}

// Add symbol to current scope
static void scope_add(Scope *scope, Symbol *sym) {
    vec_push(&scope->symbols, sym);
}

static void sem_add_builtin_functions(SemState *st) {
    // Add runtime library functions to global scope
    const char *builtins[] = {
        "print", "putchar", "getchar", "exit", "alloc",
        /* B library functions */
        "char", "lchar", "getchr", "putchr", "getstr", "putstr", "flush", "reread", "printf", "printn", "putnum",
        "open", "close", "read", "write", "creat", "seek", "openr", "openw",
        "fork", "wait", "execl", "execv",
        "chdir", "chmod", "chown", "link", "unlink", "stat", "fstat",
        "time", "ctime", "getuid", "setuid", "makdir", "intr",
        "system", "callf",
        "gtty", "stty",
        "argc", "argv",
        NULL
    };

    for (int i = 0; builtins[i]; i++) {
        vec_push(&st->function_names, sdup(builtins[i]));
        Symbol *sym = symbol_new(SYM_FUNC, builtins[i], 0, 0);
        scope_add(st->current, sym);
    }
}

// Push new scope
static void sem_push_scope(SemState *st) {
    st->current = scope_new(st->current);
}

// Pop current scope
static void sem_pop_scope(SemState *st) {
    if (!st->current->parent) {
        dief("internal: cannot pop global scope");
    }
    Scope *old = st->current;
    st->current = old->parent;
    scope_free(old);
}

// Check if name is declared as extern
static int is_extern_name(SemState *st, const char *name) {
    for (size_t i = 0; i < st->extern_names.len; i++) {
        if (strcmp(st->extern_names.data[i], name) == 0) {
            return 1;
        }
    }
    return 0;
}

// Check if function is defined
static int is_function_name(SemState *st, const char *name) {
    for (size_t i = 0; i < st->function_names.len; i++) {
        if (strcmp(st->function_names.data[i], name) == 0) {
            return 1;
        }
    }
    return 0;
}

// Check if name is in implicit statics list
static int is_implicit_static(SemState *st, const char *name) {
    for (size_t i = 0; i < st->implicit_statics.len; i++) {
        if (strcmp(st->implicit_statics.data[i], name) == 0) {
            return 1;
        }
    }
    return 0;
}

// ===================== Semantic Checking Functions =====================

// Forward declarations
static void sem_check_expr(SemState *st, Expr *e);
static void sem_check_lvalue(SemState *st, Expr *e);

// Check lvalue expressions (must be assignable variables)
static void sem_check_lvalue(SemState *st, Expr *e) {
    if (!e) return;

    switch (e->kind) {
        case EX_VAR: {
            Symbol *sym = scope_find(st->current, e->as.var);
            if (!sym) {
                if (!is_extern_name(st, e->as.var) && !is_implicit_static(st, e->as.var)) {
                    // Undeclared variable used as lvalue - add to implicit statics
                    vec_push(&st->implicit_statics, sdup(e->as.var));
                }
            } else if (sym->kind != SYM_VAR) {
                dief("'%s' is not a variable at %d:%d", e->as.var, e->line, e->col);
            }
            break;
        }

        case EX_INDEX:
            sem_check_lvalue(st, e->as.index.base);
            sem_check_expr(st, e->as.index.idx);
            break;

        case EX_UNARY:
            if (e->as.unary.op == TK_STAR) {
                sem_check_expr(st, e->as.unary.rhs);
            } else {
                dief("invalid lvalue at %d:%d", e->line, e->col);
            }
            break;

        default:
            dief("invalid lvalue at %d:%d", e->line, e->col);
    }
}

// Check expressions
static void sem_check_expr(SemState *st, Expr *e) {
    if (!e) return;

    switch (e->kind) {
        case EX_VAR: {
            // Check if variable is declared or extern
            Symbol *sym = scope_find(st->current, e->as.var);
            if (!sym && !is_extern_name(st, e->as.var) && !is_implicit_static(st, e->as.var)) {
                // Undeclared variable - add to implicit statics
                vec_push(&st->implicit_statics, sdup(e->as.var));
            }
            break;
        }

        case EX_CALL: {
            // Check if callee is a function/variable before recursing
            if (e->as.call.callee->kind == EX_VAR) {
                const char *fname = e->as.call.callee->as.var;
                Symbol *sym = scope_find(st->current, fname);
                if (!sym) {
                    // Not found as variable, check if it's a function or extern
                    if (!is_function_name(st, fname) && !is_extern_name(st, fname)) {
                        error_at_location(st->filename, e->line, e->col, ERR_UNDEFINED_NAME, fname);
                    }
                } else if (sym->kind != SYM_VAR && sym->kind != SYM_FUNC) {
                    dief("'%s' is not callable at %d:%d", fname, e->line, e->col);
                }
            } else {
                // Complex callee expression - check it recursively
                sem_check_expr(st, e->as.call.callee);
            }

            for (size_t i = 0; i < e->as.call.args.len; i++) {
                sem_check_expr(st, e->as.call.args.data[i]);
            }
            break;
        }

        case EX_INDEX:
            sem_check_expr(st, e->as.index.base);
            sem_check_expr(st, e->as.index.idx);
            break;

        case EX_UNARY:
            if (e->as.unary.op == TK_PLUSPLUS || e->as.unary.op == TK_MINUSMINUS) {
                sem_check_lvalue(st, e->as.unary.rhs);
            } else {
                sem_check_expr(st, e->as.unary.rhs);
            }
            break;

        case EX_BINARY:
            sem_check_expr(st, e->as.bin.lhs);
            sem_check_expr(st, e->as.bin.rhs);
            break;

        case EX_ASSIGN:
            sem_check_lvalue(st, e->as.assign.lhs);
            sem_check_expr(st, e->as.assign.rhs);
            break;

        case EX_COMMA:
            sem_check_expr(st, e->as.comma.lhs);
            sem_check_expr(st, e->as.comma.rhs);
            break;

        case EX_TERNARY:
            sem_check_expr(st, e->as.ternary.cond);
            sem_check_expr(st, e->as.ternary.true_expr);
            sem_check_expr(st, e->as.ternary.false_expr);
            break;

        case EX_NUM:
        case EX_STR:
        case EX_POST:
            sem_check_lvalue(st, e->as.post.lhs);
            break;
    }
}

// Check statements
static void sem_check_stmt(SemState *st, Stmt *s) {
    if (!s) return;

    switch (s->kind) {
        case ST_EMPTY:
            break;

        case ST_BLOCK: {
            sem_push_scope(st);
            for (size_t i = 0; i < s->as.block.items.len; i++) {
                sem_check_stmt(st, s->as.block.items.data[i]);
            }
            sem_pop_scope(st);
            break;
        }

        case ST_AUTO: {
            for (size_t i = 0; i < s->as.autodecl.decls.len; i++) {
                DeclItem *item = s->as.autodecl.decls.data[i];

                if (scope_has_in_current(st->current, item->name)) {
                    error_at_location(st->filename, s->line, s->col, ERR_REDECLARATION, item->name);
                }

                Symbol *sym = symbol_new(SYM_VAR, item->name, s->line, s->col);
                sym->as.var.has_size = (item->size != NULL);
                sym->as.var.size_expr = item->size;
                scope_add(st->current, sym);

                if (item->size) {
                    sem_check_expr(st, item->size);
                }
            }
            break;
        }

        case ST_IF:
            sem_check_expr(st, s->as.ifs.cond);
            sem_check_stmt(st, s->as.ifs.then_s);
            sem_check_stmt(st, s->as.ifs.else_s);
            break;

        case ST_WHILE:
            sem_check_expr(st, s->as.whiles.cond);
            sem_check_stmt(st, s->as.whiles.body);
            break;

        case ST_RETURN:
            if (s->as.ret.val) {
                sem_check_expr(st, s->as.ret.val);
            }
            break;

        case ST_EXPR:
            sem_check_expr(st, s->as.expr.e);
            break;

        case ST_EXTRN:
            // extern statements: record names so we don't treat them as implicit statics
            for (size_t i = 0; i < s->as.extrn.names.len; i++) {
                char *name = s->as.extrn.names.data[i];
                if (!is_extern_name(st, name)) {
                    vec_push(&st->extern_names, sdup(name));
                }
            }
            break;
        case ST_BREAK:
        case ST_CONTINUE:
            // Handled during codegen; no semantic checks yet
            break;

        case ST_GOTO:
            // We'll check labels separately in a pass that collects all labels first
            break;

        case ST_LABEL: {
            if (scope_has_in_current(st->current, s->as.label_.name)) {
                dief("duplicate label '%s' at %d:%d", s->as.label_.name, s->line, s->col);
            }

            Symbol *sym = symbol_new(SYM_LABEL, s->as.label_.name, s->line, s->col);
            scope_add(st->current, sym);

            sem_check_stmt(st, s->as.label_.stmt);
            break;
        }

        case ST_SWITCH:
            sem_check_expr(st, s->as.switch_.expr);
            sem_check_switch_fallthrough(st, s);
            sem_check_stmt(st, s->as.switch_.body);
            break;

        case ST_CASE:
            // These are handled by the switch statement checking
            break;
    }
}

// Check function
static void sem_check_func(SemState *st, Func *f) {
    // Add function parameters to scope
    sem_push_scope(st);

    for (size_t i = 0; i < f->params.len; i++) {
        char *param_name = f->params.data[i];

        if (scope_has_in_current(st->current, param_name)) {
            error_at_location(st->filename, 0, 0, ERR_REDECLARATION, param_name);
        }

        Symbol *sym = symbol_new(SYM_VAR, param_name, 0, 0); // line/col not meaningful for params
        scope_add(st->current, sym);
    }

    // Check function body
    sem_check_stmt(st, f->body);

    sem_pop_scope(st);
}

// Check switch fallthrough
static void sem_check_switch_fallthrough(SemState *st, Stmt *switch_stmt) {
    Stmt *body = switch_stmt->as.switch_.body;
    if (!body || body->kind != ST_BLOCK) return;

    int last_was_case = 0;

    for (size_t i = 0; i < body->as.block.items.len; i++) {
        Stmt *stmt = body->as.block.items.data[i];

        if (stmt->kind == ST_CASE) {
            if (last_was_case) {
                fprintf(stderr, "bcc: warning: case label falls through to another case label at %d:%d\n",
                        stmt->line, stmt->col);
            }
            last_was_case = 1;
        } else if (stmt->kind != ST_EMPTY) {
            // Non-empty, non-case statement breaks fallthrough chain
            last_was_case = 0;
        }
        // ST_EMPTY doesn't break the chain
    }
}

// Check top-level items
static void sem_check_top(SemState *st, Top *t) {
    switch (t->kind) {
        case TOP_GAUTO: {
            // Global auto declarations
            Stmt *s = t->as.gauto;
            if (s->kind != ST_AUTO) dief("internal: TOP_GAUTO should be ST_AUTO");

            for (size_t i = 0; i < s->as.autodecl.decls.len; i++) {
                DeclItem *item = s->as.autodecl.decls.data[i];

                if (scope_has_in_current(st->current, item->name)) {
                    error_at_location(st->filename, s->line, s->col, ERR_REDECLARATION, item->name);
                }

                Symbol *sym = symbol_new(SYM_VAR, item->name, s->line, s->col);
                sym->as.var.has_size = (item->size != NULL);
                sym->as.var.size_expr = item->size;
                scope_add(st->current, sym);

                if (item->size) {
                    sem_check_expr(st, item->size);
                }
            }
            break;
        }

        case TOP_FUNC: {
            Func *f = t->as.fn;

            // Record function name
            vec_push(&st->function_names, sdup(f->name));

            // Add function symbol to global scope
            if (scope_has_in_current(st->current, f->name)) {
                error_at_location(st->filename, 0, 0, ERR_REDECLARATION, f->name);
            }

            Symbol *sym = symbol_new(SYM_FUNC, f->name, 0, 0); // line/col not meaningful for functions
            sym->as.func.params = f->params; // shallow copy
            scope_add(st->current, sym);

            sem_check_func(st, f);
            break;
        }

        case TOP_EXTERN_DEF: {
            ExternItem *item = t->as.ext_def;

            if (scope_has_in_current(st->current, item->name)) {
                dief("duplicate extern definition '%s'", item->name);
            }

            Symbol *sym = symbol_new(SYM_VAR, item->name, 0, 0); // line/col not meaningful for externs
            sym->is_extern = 1;
            scope_add(st->current, sym);

            // Record as extern name
            vec_push(&st->extern_names, sdup(item->name));

            // Check vector bounds are constants
            if (item->as.var.vkind == EXTVAR_VECTOR && item->as.var.bound && !item->as.var.has_empty) {
                long bound_val;
                if (!try_eval_const_expr(item->as.var.bound, &bound_val)) {
                    dief("vector bound must be a constant expression in '%s' at %d:%d",
                         item->name, item->as.var.bound->line, item->as.var.bound->col);
                }
                if (bound_val < 0) {
                    dief("vector bound cannot be negative in '%s' at %d:%d",
                         item->name, item->as.var.bound->line, item->as.var.bound->col);
                }
                item->as.var.bound_const = bound_val;
            }

            // Check initializer if present
            if (item->as.var.init) {
                // For now, just check the initializer expressions
                // We could do more sophisticated checking here
            }
            break;
        }

        case TOP_EXTERN_DECL: {
            ExternItem *item = t->as.ext_decl;

            if (scope_has_in_current(st->current, item->name)) {
                error_at_location(st->filename, 0, 0, ERR_REDECLARATION, item->name);
            }

            Symbol *sym = symbol_new(SYM_VAR, item->name, 0, 0);
            sym->is_extern = 1;
            scope_add(st->current, sym);

            // Record as extern name
            vec_push(&st->extern_names, sdup(item->name));
            break;
        }
    }
}

// Main semantic checking function
void sem_check_program(Program *prog, const char *filename) {
    SemState *st = sem_state_new(filename);

    // Pre-pass: collect all top-level declarations without checking expressions
    for (size_t i = 0; i < prog->tops.len; i++) {
        Top *t = prog->tops.data[i];
        switch (t->kind) {
            case TOP_GAUTO: {
                // Global auto declarations
                Stmt *s = t->as.gauto;
                if (s->kind != ST_AUTO) dief("internal: TOP_GAUTO should be ST_AUTO");

                for (size_t i = 0; i < s->as.autodecl.decls.len; i++) {
                    DeclItem *item = s->as.autodecl.decls.data[i];

                    if (scope_has_in_current(st->current, item->name)) {
                        error_at_location(st->filename, s->line, s->col, ERR_REDECLARATION, item->name);
                    }

                    Symbol *sym = symbol_new(SYM_VAR, item->name, s->line, s->col);
                    sym->as.var.has_size = (item->size != NULL);
                    sym->as.var.size_expr = item->size;
                    scope_add(st->current, sym);

                    if (item->size) {
                        // Don't check expressions yet
                    }
                }
                break;
            }
            case TOP_FUNC: {
                Func *f = t->as.fn;

                // Record function name
                vec_push(&st->function_names, sdup(f->name));

                // Add function symbol to global scope
                if (scope_has_in_current(st->current, f->name)) {
                    error_at_location(st->filename, 0, 0, ERR_REDECLARATION, f->name);
                }

                Symbol *sym = symbol_new(SYM_FUNC, f->name, 0, 0); // line/col not meaningful for functions
                sym->as.func.params = f->params; // shallow copy
                scope_add(st->current, sym);

                // Don't check function body yet
                break;
            }
            case TOP_EXTERN_DEF: {
                ExternItem *item = t->as.ext_def;

                if (scope_has_in_current(st->current, item->name)) {
                    dief("duplicate extern definition '%s'", item->name);
                }

                Symbol *sym = symbol_new(SYM_VAR, item->name, 0, 0); // line/col not meaningful for externs
                sym->is_extern = 1;
                scope_add(st->current, sym);

                // Don't check expressions yet
                break;
            }
            case TOP_EXTERN_DECL: {
                ExternItem *item = t->as.ext_decl;
                vec_push(&st->extern_names, sdup(item->name));
                // Extern declarations don't create symbols until used
                break;
            }
        }
    }

    // Now check function bodies, collecting implicit static variables
    for (size_t i = 0; i < prog->tops.len; i++) {
        Top *t = prog->tops.data[i];
        if (t->kind == TOP_FUNC) {
            Func *f = t->as.fn;
            sem_check_func(st, f);
        }
    }

    // Add implicit static variables as extern definitions
    for (size_t i = 0; i < st->implicit_statics.len; i++) {
        char *name = st->implicit_statics.data[i];

        // Check if already declared (shouldn't happen but be safe)
        int already_declared = 0;
        for (size_t j = 0; j < prog->tops.len; j++) {
            Top *t = prog->tops.data[j];
            if ((t->kind == TOP_EXTERN_DEF || t->kind == TOP_EXTERN_DECL) &&
                strcmp(((ExternItem*)t->as.ext_def)->name, name) == 0) {
                already_declared = 1;
                break;
            }
        }

        if (!already_declared) {
            // Create a new TOP_EXTERN_DEF for the implicit static variable
            Top *t = (Top*)xmalloc(sizeof(*t));
            t->kind = TOP_EXTERN_DEF;

            ExternItem *item = (ExternItem*)xmalloc(sizeof(*item));
            memset(item, 0, sizeof(*item));
            item->is_func = 0;
            item->is_implicit_static = 1; // implicit static variable
            item->name = sdup(name);
            item->as.var.vkind = EXTVAR_SCALAR;
            item->as.var.init = NULL;

            t->as.ext_def = item;
            vec_push(&prog->tops, t);
        }
    }

    sem_state_free(st);
}
