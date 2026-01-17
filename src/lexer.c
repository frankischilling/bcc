/* lexer.c - tokenizer/lexer implementation */

#include "bcc.h"

static int lx_peek(Lexer *L) {
    if (L->i >= L->len) return 0;
    return (unsigned char)L->src[L->i];
}

static int lx_peek2(Lexer *L) {
    if (L->i + 1 >= L->len) return 0;
    return (unsigned char)L->src[L->i + 1];
}

static int lx_get(Lexer *L) {
    int c = lx_peek(L);
    if (!c) return 0;
    L->i++;
    if (c == '\n') { L->line++; L->col = 1; }
    else L->col++;
    return c;
}

/* Parse B escape sequence (*), returns the character value */
static int parse_escape(Lexer *L, int line, int col) {
    int e = lx_get(L);
    if (!e) error_at_location(L->filename, line, col, ERR_EXPR_SYNTAX, "unterminated escape sequence");

    switch (e) {
        case '0': return '\0';    /* *0 - null */
        case 'e': return '\4';    /* *e - escape/end marker (EOT, octal 004) */
        case '(': return '(';     /* *( - left parenthesis */
        case ')': return ')';     /* *) - right parenthesis */
        case 't': return '\t';    /* *t - tab */
        case '*': return '*';     /* ** - asterisk */
        case '\'': return '\'';   /* *' - single quote */
        case '"': return '"';     /* *" - double quote */
        case 'n': return '\n';    /* *n - newline */
        default: {
            char msg[64];
            snprintf(msg, sizeof(msg), "unknown escape sequence *%c", e);
            error_at_location(L->filename, line, col, ERR_EXPR_SYNTAX, msg);
            return e; /* unreachable */
        }
    }
}

void lx_skip_ws_and_comments(Lexer *L) {
    for (;;) {
        int c = lx_peek(L);
        /* whitespace */
        while (c && isspace(c)) { lx_get(L); c = lx_peek(L); }

        /* PL/I-style comment */
        if (c == '/' && lx_peek2(L) == '*') {
            lx_get(L); lx_get(L);
            for (;;) {
                int a = lx_peek(L);
                if (!a) error_at_location(L->filename, L->line, L->col, ERR_COMMENT_IMBALANCE, "unterminated /* comment");
                if (a == '*' && lx_peek2(L) == '/') { lx_get(L); lx_get(L); break; }
                lx_get(L);
            }
            continue;
        }

        /* C++-style comment */
        if (c == '/' && lx_peek2(L) == '/') {
            lx_get(L); lx_get(L);  /* consume // */
            while ((c = lx_peek(L)) && c != '\n') {
                lx_get(L);
            }
            continue;
        }

        break;
    }
}

Token mk_tok(TokenKind k, int line, int col, const char *filename) {
    Token t;
    t.kind = k;
    t.lexeme = NULL;
    t.owns_lexeme = 0;  /* default: doesn't own lexeme */
    t.num = 0;
    t.line = line;
    t.col = col;
    t.filename = filename;
    return t;
}

static TokenKind kw_kind(const char *s) {
    if (strcmp(s, "auto") == 0) return TK_AUTO;
    if (strcmp(s, "if") == 0) return TK_IF;
    if (strcmp(s, "else") == 0) return TK_ELSE;
    if (strcmp(s, "while") == 0) return TK_WHILE;
    if (strcmp(s, "return") == 0) return TK_RETURN;
    if (strcmp(s, "extrn") == 0) return TK_EXTRN;
    if (strcmp(s, "break") == 0) return TK_BREAK;
    if (strcmp(s, "continue") == 0) return TK_CONTINUE;
    if (strcmp(s, "goto") == 0) return TK_GOTO;
    if (strcmp(s, "switch") == 0) return TK_SWITCH;
    if (strcmp(s, "case") == 0) return TK_CASE;
    if (strcmp(s, "default") == 0) return TK_DEFAULT;
    return TK_ID;
}

Token lx_next(Lexer *L) {
    lx_skip_ws_and_comments(L);
    int line = L->line, col = L->col;
    int c = lx_peek(L);
    if (!c) return mk_tok(TK_EOF, line, col, L->filename);

    /* identifiers / keywords */
    if (isalpha(c) || c == '_') {
        size_t start = L->i;
        while (isalnum(lx_peek(L)) || lx_peek(L) == '_' || lx_peek(L) == '.') lx_get(L);
        char *s;
        int owns_lexeme;
        if (g_compilation_arena) {
            s = arena_xstrdup_range(g_compilation_arena, L->src, start, L->i);
            owns_lexeme = 0;  /* arena-allocated */
        } else {
            size_t n = (L->i > start) ? (L->i - start) : 0;
            s = (char*)malloc(n + 1);
            if (!s) dief("out of memory");
            memcpy(s, L->src + start, n);
            s[n] = 0;
            owns_lexeme = 1;  /* malloc'd */
        }
        TokenKind k = kw_kind(s);
        Token t = mk_tok(k, line, col, L->filename);
        t.lexeme = s;
        t.owns_lexeme = owns_lexeme;
        return t;
    }

    /* numbers (decimal, octal) */
    if (isdigit(c)) {
        size_t start = L->i;
        int base = 10;

        if (c == '0') {
            lx_get(L); /* leading '0' */
            base = 8;
            /* B allows octal constants to contain digits 0-9 (e.g., 09 == octal 011) */
            while (isdigit(lx_peek(L))) lx_get(L);
        } else {
            while (isdigit(lx_peek(L))) lx_get(L);
        }

        /* Parse number from source directly */
        size_t n = (L->i > start) ? (L->i - start) : 0;
        char *s = (char*)malloc(n + 1);
        if (!s) dief("out of memory");
        memcpy(s, L->src + start, n);
        s[n] = 0;

        errno = 0;
        long v;
        if (base == 8) {
            /* B octal: allow digits 0-9 but interpret as octal (e.g., 09 == 011 octal == 9 decimal) */
            v = 0;
            for (size_t i = 0; i < n; i++) {
                char digit = s[i];
                if (digit < '0' || digit > '9') {
                    char msg[64];
                    snprintf(msg, sizeof(msg), "bad octal digit '%c'", digit);
                    error_at_location(L->filename, line, col, ERR_EXPR_SYNTAX, msg);
                }
                v = v * 8 + (digit - '0');
            }
        } else {
            v = strtol(s, NULL, base);
        }
        free(s); /* Always free the temporary string */
        if (errno) error_at_location(L->filename, line, col, ERR_EXPR_SYNTAX, "bad number");
        Token t = mk_tok(TK_NUM, line, col, L->filename);
        t.num = v;
        return t;
    }

    /* strings (B style: packed chars ending with *e) */
    if (c == '"') {
        lx_get(L);
        char *buf = (char*)malloc(1);
        size_t cap = 1, n = 0;
        if (!buf) dief("out of memory");
        for (;;) {
            int ch = lx_get(L);
            if (!ch) error_at_location(L->filename, line, col, ERR_EXPR_SYNTAX, "unterminated string");
            if (ch == '"') break;
            if (ch == '*') {
                ch = parse_escape(L, line, col);
            }
            if (n + 2 > cap) {
                cap = cap * 2 + 8;
                buf = (char*)realloc(buf, cap);
                if (!buf) dief("out of memory");
            }
            buf[n++] = (char)ch;
        }
        buf[n] = 0;

        int owns_lexeme;
        /* Use arena allocation if available */
        if (g_compilation_arena) {
            char *arena_buf = arena_alloc(g_compilation_arena, n + 1);
            memcpy(arena_buf, buf, n + 1);
            free(buf);
            buf = arena_buf;
            owns_lexeme = 0;  /* arena-allocated */
        } else {
            owns_lexeme = 1;  /* malloc'd */
        }

        Token t = mk_tok(TK_STR, line, col, L->filename);
        t.lexeme = buf;
        t.owns_lexeme = owns_lexeme;
        return t;
    }

    /* character constants (B style: up to 4 chars packed into a word) */
    if (c == '\'') {
        lx_get(L); /* consume opening ' */
        int chars[4] = {0, 0, 0, 0};
        int count = 0;
        for (;;) {
            int ch = lx_get(L);
            if (!ch) error_at_location(L->filename, line, col, ERR_EXPR_SYNTAX, "unterminated character constant");
            if (ch == '\'') break;
            if (count >= 4) error_at_location(L->filename, line, col, ERR_EXPR_SYNTAX, "character constant too long");

            if (ch == '*') {
                ch = parse_escape(L, line, col);
            }

            chars[count++] = ch & 0xFF;
        }
        /* Pack 1-4 characters into word (right-justified, zero-filled) */
        long val = chars[0];
        if (count > 1) val |= ((long)chars[1] << 8);
        if (count > 2) val |= ((long)chars[2] << 16);
        if (count > 3) val |= ((long)chars[3] << 24);
        Token t = mk_tok(TK_CHR, line, col, L->filename);
        t.num = val;
        return t;
    }

    /* 2-char operators */
    if (c == '+' && lx_peek2(L) == '+') { lx_get(L); lx_get(L); return mk_tok(TK_PLUSPLUS, line, col, L->filename); }
    if (c == '-' && lx_peek2(L) == '-') { lx_get(L); lx_get(L); return mk_tok(TK_MINUSMINUS, line, col, L->filename); }

    // B-style assignment operators: =op instead of op=
    if (c == '=') {
        int next = lx_peek2(L);
        if (next == '+') { lx_get(L); lx_get(L); return mk_tok(TK_PLUSEQ, line, col, L->filename); }
        if (next == '-') { lx_get(L); lx_get(L); return mk_tok(TK_MINUSEQ, line, col, L->filename); }
        if (next == '*') { lx_get(L); lx_get(L); return mk_tok(TK_STAREQ, line, col, L->filename); }
        if (next == '/') { lx_get(L); lx_get(L); return mk_tok(TK_SLASHEQ, line, col, L->filename); }
        if (next == '%') { lx_get(L); lx_get(L); return mk_tok(TK_PERCENTEQ, line, col, L->filename); }
        if (next == '&') { lx_get(L); lx_get(L); return mk_tok(TK_ANDEQ, line, col, L->filename); }
        if (next == '|') { lx_get(L); lx_get(L); return mk_tok(TK_OREQ, line, col, L->filename); }
        // Shift assignment operators: =<< and =>>
        if (next == '<') {
            int third = lx_peek(L) ? (unsigned char)L->src[L->i + 2] : 0;
            if (third == '<') { lx_get(L); lx_get(L); lx_get(L); return mk_tok(TK_LSHIFTEQ, line, col, L->filename); }
        }
        if (next == '>') {
            int third = lx_peek(L) ? (unsigned char)L->src[L->i + 2] : 0;
            if (third == '>') { lx_get(L); lx_get(L); lx_get(L); return mk_tok(TK_RSHIFTEQ, line, col, L->filename); }
        }
        // Relational assignment operators
        // Check for 3-character sequences first
        if (next == '<' && lx_peek(L) && (unsigned char)L->src[L->i + 2] == '=') {
            lx_get(L); lx_get(L); lx_get(L); return mk_tok(TK_LEEQ, line, col, L->filename);
        }
        if (next == '>' && lx_peek(L) && (unsigned char)L->src[L->i + 2] == '=') {
            lx_get(L); lx_get(L); lx_get(L); return mk_tok(TK_GEEQ, line, col, L->filename);
        }
        if (next == '=' && lx_peek(L) && (unsigned char)L->src[L->i + 2] == '=') {
            lx_get(L); lx_get(L); lx_get(L); return mk_tok(TK_EQEQ, line, col, L->filename);
        }
        if (next == '!' && lx_peek(L) && (unsigned char)L->src[L->i + 2] == '=') {
            lx_get(L); lx_get(L); lx_get(L); return mk_tok(TK_NEEQ, line, col, L->filename);
        }
        // Then check for 2-character sequences
        if (next == '<') {
            lx_get(L); lx_get(L); return mk_tok(TK_LTEQ, line, col, L->filename);
        }
        if (next == '>') {
            lx_get(L); lx_get(L); return mk_tok(TK_GTEQ, line, col, L->filename);
        }
    }

    if (c == '<' && lx_peek2(L) == '<') { lx_get(L); lx_get(L); return mk_tok(TK_LSHIFT, line, col, L->filename); }
    if (c == '>' && lx_peek2(L) == '>') { lx_get(L); lx_get(L); return mk_tok(TK_RSHIFT, line, col, L->filename); }
    if (c == '|' && lx_peek2(L) == '|') { lx_get(L); lx_get(L); return mk_tok(TK_BARBAR, line, col, L->filename); }


    if (c == '=' && lx_peek2(L) == '=') { lx_get(L); lx_get(L); return mk_tok(TK_EQ, line, col, L->filename); }
    if (c == '!' && lx_peek2(L) == '=') { lx_get(L); lx_get(L); return mk_tok(TK_NE, line, col, L->filename); }
    if (c == '<' && lx_peek2(L) == '=') { lx_get(L); lx_get(L); return mk_tok(TK_LE, line, col, L->filename); }
    if (c == '>' && lx_peek2(L) == '=') { lx_get(L); lx_get(L); return mk_tok(TK_GE, line, col, L->filename); }

    /* 1-char tokens */
    lx_get(L);
    switch (c) {
        case '(': return mk_tok(TK_LPAREN, line, col, L->filename);
        case ')': return mk_tok(TK_RPAREN, line, col, L->filename);
        case '{': return mk_tok(TK_LBRACE, line, col, L->filename);
        case '}': return mk_tok(TK_RBRACE, line, col, L->filename);
        case ',': return mk_tok(TK_COMMA, line, col, L->filename);
        case ';': return mk_tok(TK_SEMI, line, col, L->filename);
        case ':': return mk_tok(TK_COLON, line, col, L->filename);
        case '=': return mk_tok(TK_ASSIGN, line, col, L->filename);
        case '<': return mk_tok(TK_LT, line, col, L->filename);
        case '>': return mk_tok(TK_GT, line, col, L->filename);
        case '+': return mk_tok(TK_PLUS, line, col, L->filename);
        case '-': return mk_tok(TK_MINUS, line, col, L->filename);
        case '*': return mk_tok(TK_STAR, line, col, L->filename);
        case '/': return mk_tok(TK_SLASH, line, col, L->filename);
        case '%': return mk_tok(TK_PERCENT, line, col, L->filename);
        case '!': return mk_tok(TK_BANG, line, col, L->filename);
        case '?': return mk_tok(TK_QUESTION, line, col, L->filename);
        case '[': return mk_tok(TK_LBRACK, line, col, L->filename);
        case ']': return mk_tok(TK_RBRACK, line, col, L->filename);
        case '&': return mk_tok(TK_AMP, line, col, L->filename);
        case '|': return mk_tok(TK_BAR, line, col, L->filename);
        default:
            {
                char msg[64];
                snprintf(msg, sizeof(msg), "unexpected character '%c'", c);
                error_at_location(L->filename, line, col, ERR_EXPR_SYNTAX, msg);
            }
    }
    return mk_tok(TK_EOF, line, col, L->filename);
}

void tok_free(Token *t) {
    /* Free lexeme only if we own it (i.e., it was malloc'd) */
    if (t->lexeme && t->owns_lexeme) {
        free(t->lexeme);
    }
    t->lexeme = NULL;
}

// IMPORTANT: This function must have a case for every TokenKind enum value.
// When adding new tokens to TokenKind, add corresponding cases here to avoid
// confusing "?" output in debug messages and error reports.
const char *tk_name(TokenKind k) {
    switch (k) {
        case TK_EOF: return "EOF";
        case TK_ID: return "identifier";
        case TK_NUM: return "number";
        case TK_STR: return "string";
        case TK_CHR: return "character";
        case TK_AUTO: return "auto";
        case TK_IF: return "if";
        case TK_ELSE: return "else";
        case TK_WHILE: return "while";
        case TK_RETURN: return "return";
        case TK_BREAK: return "break";
        case TK_CONTINUE: return "continue";
        case TK_EXTRN: return "extrn";
        case TK_LPAREN: return "(";
        case TK_RPAREN: return ")";
        case TK_LBRACE: return "{";
        case TK_RBRACE: return "}";
        case TK_COMMA: return ",";
        case TK_SEMI: return ";";
        case TK_ASSIGN: return "=";
        case TK_EQ: return "==";
        case TK_NE: return "!=";
        case TK_LT: return "<";
        case TK_LE: return "<=";
        case TK_GT: return ">";
        case TK_GE: return ">=";
        case TK_LSHIFT: return "<<";
        case TK_RSHIFT: return ">>";
        case TK_PLUS: return "+";
        case TK_MINUS: return "-";
        case TK_STAR: return "*";
        case TK_SLASH: return "/";
        case TK_PERCENT: return "%";
        case TK_BANG: return "!";
        case TK_QUESTION: return "?";

        case TK_LBRACK: return "[";
        case TK_RBRACK: return "]";
        case TK_PLUSPLUS: return "++";
        case TK_MINUSMINUS: return "--";
        case TK_PLUSEQ: return "=+";
        case TK_MINUSEQ: return "=-";
        case TK_STAREQ: return "=*";
        case TK_SLASHEQ: return "=/";
        case TK_PERCENTEQ: return "=%";
        case TK_LSHIFTEQ: return "=<<";
        case TK_RSHIFTEQ: return "=>>";
        case TK_ANDEQ: return "=&";
        case TK_OREQ: return "=|";
        case TK_LTEQ: return "=<";
        case TK_LEEQ: return "=<=";
        case TK_GTEQ: return "=>";
        case TK_GEEQ: return "=>=";
        case TK_EQEQ: return "===";
        case TK_NEEQ: return "=!=";
        case TK_AMP: return "&";
        case TK_BAR: return "|";
        case TK_BARBAR: return "||";

        case TK_COLON: return ":";
        case TK_GOTO: return "goto";
        case TK_SWITCH: return "switch";
        case TK_CASE: return "case";
        case TK_DEFAULT: return "default";

        default: return "<unknown token>";
    }
}
