// bcc.h - B compiler header file

#ifndef BCC_H
#define BCC_H

#define _POSIX_C_SOURCE 200809L
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdarg.h>
#include <errno.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stddef.h>
#include <stdint.h>
#include <inttypes.h>

// ===================== Error Codes =====================

typedef enum {
    ERR_BRACE_IMBALANCE,    // $) -- {} imbalance
    ERR_PAREN_IMBALANCE,    // () -- () imbalance
    ERR_COMMENT_IMBALANCE,  // */ -- /* */ imbalance
    ERR_BRACKET_IMBALANCE,  // [] -- [] imbalance
    ERR_CASE_OVERFLOW,      // >c -- case table overflow (fatal)
    ERR_EXPR_STACK_OVERFLOW,// >e -- expression stack overflow (fatal)
    ERR_LABEL_OVERFLOW,     // >i -- label table overflow (fatal)
    ERR_SYMBOL_OVERFLOW,    // >s -- symbol table overflow (fatal)
    ERR_EXPR_SYNTAX,        // ex -- expression syntax
    ERR_RVALUE_LVALUE,      // lv -- rvalue where lvalue expected
    ERR_REDECLARATION,      // rd name -- name redeclaration
    ERR_STMT_SYNTAX,        // sx keyword -- statement syntax
    ERR_UNDEFINED_NAME,     // un name -- undefined name
    ERR_EXTERNAL_SYNTAX,    // xx -- external syntax
} ErrorCode;

const char *get_error_code(ErrorCode code);
const char *get_error_message(ErrorCode code);

// ===================== Token Types =====================

typedef enum {
    TK_EOF = 0,
    TK_ID,
    TK_NUM,
    TK_STR,
    TK_CHR,

    // keywords
    TK_AUTO,
    TK_IF,
    TK_ELSE,
    TK_WHILE,
    TK_RETURN,
    TK_BREAK,
    TK_CONTINUE,
    TK_EXTRN,

    // operators / punctuation
    TK_LPAREN, TK_RPAREN,
    TK_LBRACE, TK_RBRACE,
    TK_COMMA, TK_SEMI,

    // brackets
    TK_LBRACK, TK_RBRACK,   // [ ]

    TK_ASSIGN,   // =
    TK_EQ,       // ==
    TK_NE,       // !=
    TK_LT,       // <
    TK_LE,       // <=
    TK_GT,       // >
    TK_GE,       // >=
    TK_LSHIFT,   // <<
    TK_RSHIFT,   // >>
    TK_PLUS,     // +
    TK_MINUS,    // -
    TK_STAR,     // *
    TK_SLASH,    // /
    TK_PERCENT,  // %
    TK_BANG,     // !

    // ++ / --
    TK_PLUSPLUS,            // ++
    TK_MINUSMINUS,          // --

    // compound assigns
    TK_PLUSEQ,              // +=
    TK_MINUSEQ,             // -=
    TK_STAREQ,              // *=
    TK_SLASHEQ,             // /=
    TK_PERCENTEQ,           // %=
    TK_LSHIFTEQ,            // <<=
    TK_RSHIFTEQ,            // >>=
    TK_ANDEQ,               // &=
    TK_OREQ,                // |=
    TK_LTEQ,                // =<
    TK_LEEQ,                // =<=
    TK_GTEQ,                // =>
    TK_GEEQ,                // =>=
    TK_EQEQ,                // ===
    TK_NEEQ,                // =!=

    // single-char &
    TK_AMP,                // &
    TK_BAR,                // |
    TK_BARBAR,             // ||
    TK_QUESTION,           // ?

    TK_COLON,              // :

    // additional keywords
    TK_GOTO,
    TK_SWITCH,
    TK_CASE,
    TK_DEFAULT
} TokenKind;

typedef struct {
    TokenKind kind;
    char *lexeme;     // for IDs / STR
    int owns_lexeme;  // 1 if lexeme should be freed, 0 if arena-allocated
    long num;         // for NUM
    int line, col;
    const char *filename;
} Token;

typedef struct {
    const char *src;
    size_t len;
    size_t i;
    int line, col;
    const char *filename;
} Lexer;

// ===================== AST Types =====================

typedef struct Vec {
    void **data;
    size_t len, cap;
} Vec;

typedef struct Expr Expr;
typedef struct Stmt Stmt;

typedef enum {
    EX_NUM, EX_STR, EX_VAR,
    EX_CALL,          // callee(args)
    EX_INDEX,         // base[idx]
    EX_UNARY,         // prefix ops (- ! * & ++ --)
    EX_POST,          // postfix ops (x++ x--)
    EX_BINARY,
    EX_ASSIGN,        // =, +=, -=, ...
    EX_TERNARY,       // condition ? true : false
    EX_COMMA          // a, b
} ExprKind;

struct Expr {
    ExprKind kind;
    int line, col;
    union {
        long num;          // EX_NUM
        char *str;         // EX_STR
        char *var;         // EX_VAR

        struct { Expr *callee; Vec args; } call;              // EX_CALL (args: Expr*)
        struct { Expr *base; Expr *idx; } index;              // EX_INDEX

        struct { TokenKind op; Expr *rhs; } unary;            // EX_UNARY (prefix)
        struct { TokenKind op; Expr *lhs; } post;             // EX_POST  (postfix)

        struct { TokenKind op; Expr *lhs, *rhs; } bin;         // EX_BINARY

        struct { TokenKind op; Expr *lhs, *rhs; } assign;      // EX_ASSIGN (op: =, +=, ...)
        struct { Expr *cond; Expr *true_expr; Expr *false_expr; } ternary; // EX_TERNARY
        struct { Expr *lhs, *rhs; } comma;                     // EX_COMMA
    } as;
};

typedef enum {
    ST_EMPTY, ST_BLOCK, ST_AUTO, ST_IF, ST_WHILE, ST_RETURN, ST_EXPR, ST_EXTRN,
    ST_BREAK, ST_CONTINUE, ST_GOTO, ST_LABEL, ST_SWITCH, ST_CASE
} StmtKind;

// Declaration item: either simple variable or vector
typedef struct {
    char *name;
    Expr *size;  // NULL for simple variables, size expression for vectors
} DeclItem;

struct Stmt {
    StmtKind kind;
    int line, col;
    union {
        struct { Vec items; } block;                           // items: Stmt*
        struct { Vec decls; } autodecl;                        // decls: DeclItem*
        struct { Expr *cond; Stmt *then_s; Stmt *else_s; } ifs;
        struct { Expr *cond; Stmt *body; } whiles;
        struct { Expr *val; } ret;                             // val may be NULL
        struct { Expr *e; } expr;
        struct { Vec names; } extrn;                           // names: char*

        struct { char *target; } goto_;
        struct { char *name; Stmt *stmt; } label_;
        struct { Expr *expr; Stmt *body; } switch_;
        struct { int has_range; TokenKind relop; int64_t lo; int64_t hi; } case_;
    } as;
};

typedef struct Func {
    char *name;
    Vec params;                                                // char*
    Stmt *body;                                                // ST_BLOCK
} Func;

// Initializer tree for external definitions
typedef enum { INIT_EXPR, INIT_LIST } InitKind;

typedef struct Init Init;
struct Init {
    InitKind kind;
    int line, col;
    union {
        Expr *expr;   // INIT_EXPR
        Vec  list;    // INIT_LIST: elements are Init*
    } as;
};

// External definition/declaration item
typedef enum { EXTVAR_SCALAR, EXTVAR_BLOB, EXTVAR_VECTOR } ExtVarKind;

typedef struct {
    int is_func;           // 1 if function declaration, 0 if variable
    int is_implicit_static; // 1 if created for undeclared variable
    char *name;

    union {
        // for variables:
        struct {
            ExtVarKind vkind;
            // for VECTOR only:
            Expr *bound;      // NULL for []
            int  has_empty;   // 1 if [] form used
            long bound_const; // folded const-expr value (upper bound), valid when bound!=NULL
            // initializer tree:
            Init *init;       // NULL means no init
        } var;

        // for functions:
        struct {
            Vec params;       // parameter names (char*), empty for foo()
        } func;
    } as;
} ExternItem;

typedef enum {
    TOP_GAUTO,     // auto declarations (for compatibility)
    TOP_FUNC,      // function definitions
    TOP_EXTERN_DEF, // external definitions (name = value; or name[expr] = {init};)
    TOP_EXTERN_DECL // external declarations (extrn name; or extrn name[expr];)
} TopKind;

typedef struct Top {
    TopKind kind;
    union {
        Stmt *gauto;                                           // ST_AUTO
        Func *fn;
        ExternItem *ext_def;                                   // external definition
        ExternItem *ext_decl;                                  // external declaration
    } as;
} Top;

typedef struct Program {
    Vec tops;                                                  // Top*
} Program;

// ===================== Semantic Analysis (Symbol Table) =====================

typedef enum {
    SYM_VAR,      // variable (auto or extern)
    SYM_FUNC,     // function definition
    SYM_LABEL     // goto label
} SymbolKind;

typedef struct Symbol {
    SymbolKind kind;
    char *name;
    int line, col;        // declaration location
    int is_extern;        // for variables: declared with extrn
    union {
        struct {
            int has_size;     // 0 for scalars, 1 for vectors
            Expr *size_expr;  // size expression (may be NULL for [])
        } var;
        struct {
            Vec params;       // parameter names (char*)
        } func;
    } as;
} Symbol;

typedef struct Scope {
    struct Scope *parent;
    Vec symbols;           // Symbol*
} Scope;

typedef struct {
    Scope *current;
    const char *filename;  // source filename for error reporting
    Vec extern_names;      // char* - names declared as extern
    Vec function_names;    // char* - defined functions
    Vec implicit_statics;  // char* - undeclared variables that become static
} SemState;

typedef struct {
    Lexer L;
    Token cur;
    const char *source;  // source code for error reporting
    int loop_depth;
    int switch_depth;
} Parser;

// ===================== Utility Functions =====================

void dief(const char *fmt, ...);
void error_at(Token *tok, const char *src, const char *fmt, ...);
void error_at_code(Token *tok, const char *src, ErrorCode code, const char *extra_info);
void error_at_location(const char *filename, int line, int col, ErrorCode code, const char *extra_info);
char *xstrdup_range(const char *s, size_t a, size_t b);
char *sdup(const char *s);
Vec *vec_new();
void vec_push(Vec *v, void *p);
char *fmt(const char *fmt, ...);
void *xmalloc(size_t n);

// ===================== Lexer =====================

void lx_skip_ws_and_comments(Lexer *L);
Token lx_next(Lexer *L);
Token mk_tok(TokenKind k, int line, int col, const char *filename);
void tok_free(Token *t);
const char *tk_name(TokenKind k);

// ===================== Parser =====================

void next(Parser *P);
void expect(Parser *P, TokenKind k);
int accept(Parser *P, TokenKind k);
TokenKind peek_next_kind(Parser *P);

Expr *parse_expr(Parser *P);
Expr *parse_assignment(Parser *P);
Expr *parse_unary(Parser *P);
Expr *parse_postfix(Parser *P);
Expr *parse_primary(Parser *P);
Expr *parse_bin_rhs(Parser *P, int min_prec, Expr *lhs);

Stmt *parse_stmt(Parser *P);
Stmt *parse_block(Parser *P);
Stmt *parse_auto_decl(Parser *P);
Stmt *parse_if(Parser *P);
Stmt *parse_while(Parser *P);
Stmt *parse_return(Parser *P);
Stmt *parse_extrn_stmt(Parser *P);

Init *parse_init_list(Parser *P);
Init *parse_init_elem(Parser *P);
Init *parse_comma_init_list(Parser *P);

Func *parse_function(Parser *P);
ExternItem *parse_extern_var_def(Parser *P);
ExternItem *parse_extern_decl(Parser *P);
Program *parse_program_ast(Parser *P);

Expr *new_expr(ExprKind k, int line, int col);
Stmt *new_stmt(StmtKind k, int line, int col);
Init *new_init(InitKind k, int line, int col);

// ===================== Emitter =====================

void emit_program_c(FILE *out, Program *prog, const char *filename, int byteptr, int no_line);
void emit_program_asm(FILE *out, Program *prog);
void emit_expr(FILE *out, Expr *e, const char *filename);
void emit_ival_expr(FILE *out, Expr *e, const char *filename);
void emit_stmt(FILE *out, Stmt *s, int indent, int is_function_body, const char *filename);
void emit_indent(FILE *out, int n);
void emit_c_string(FILE *out, const char *s);

// ===================== Semantic Analysis =====================

void sem_check_program(Program *prog, const char *filename);

// ===================== Arena Allocator =====================

#define ARENA_CHUNK_SIZE (64 * 1024)  // 64KB chunks

typedef struct ArenaChunk {
    struct ArenaChunk *next;
    size_t used, cap;
    unsigned char data[];
} ArenaChunk;

typedef struct Arena {
    ArenaChunk *first_chunk;
    ArenaChunk *current_chunk;
} Arena;

Arena *arena_new(void);
void arena_free(Arena *arena);
void arena_reset(Arena *arena);
void *arena_alloc(Arena *arena, size_t size);
char *arena_sdup(Arena *arena, const char *s);
char *arena_xstrdup_range(Arena *arena, const char *s, size_t a, size_t b);
char *arena_fmt(Arena *arena, const char *fmt, ...);

// Arena marking for backtracking
typedef struct ArenaMark {
    ArenaChunk *chunk;
    size_t used;
} ArenaMark;

ArenaMark arena_mark(Arena *arena);
void arena_rewind(Arena *arena, ArenaMark mark);

// Global arena for compilation
extern Arena *g_compilation_arena;

// Include system globals
extern Vec g_include_paths;
extern Vec g_included_files;
extern Vec g_parsing_files;

// Developer flags
extern int g_no_line;
extern int g_verbose_errors;
int try_eval_const_expr(Expr *e, long *out);
size_t nested_base_len(Init *list);
size_t edge_words_total(Init *list);
size_t edge_tail_words_top(Init *root);
size_t emit_edge_list_init(FILE *out, const char *arr,
                          size_t base, Init *list,
                          size_t cursor, int indent, const char *filename);

// ===================== Main/File I/O =====================

char *read_file_all(const char *path, size_t *out_len);
char *resolve_include_path(const char *include_name, const char *current_file);
void dump_token_stream(Parser *P);
void dump_ast_program(Program *prog);
int run_gcc(const char *cfile, const char *out_exe, int compile_only, int debug, int wall, int wextra, int werror, Vec *extra_args);

#endif // BCC_H
