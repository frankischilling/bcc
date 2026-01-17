/* main.c - main driver and file I/O */

#include "bcc.h"

char *read_file_all(const char *path, size_t *out_len) {
    FILE *f = fopen(path, "rb");
    if (!f) dief("cannot open '%s': %s", path, strerror(errno));
    if (fseek(f, 0, SEEK_END) != 0) dief("fseek failed");
    long n = ftell(f);
    if (n < 0) dief("ftell failed");
    if (fseek(f, 0, SEEK_SET) != 0) dief("fseek failed");

    char *buf = (char*)malloc((size_t)n + 1);
    if (!buf) dief("out of memory");
    size_t r = fread(buf, 1, (size_t)n, f);
    fclose(f);
    if (r != (size_t)n) dief("read failed for '%s'", path);
    buf[n] = 0;
    if (out_len) *out_len = (size_t)n;
    return buf;
}


int run_gcc(const char *cfile, const char *out_exe, int compile_only, int debug, int wall, int wextra, int werror) {
    const char *argv[32];
    int n = 0;
    argv[n++] = "gcc";
    argv[n++] = "-std=c99";
    if (!compile_only) argv[n++] = "-O2";
    if (wall)   argv[n++] = "-Wall";
    if (wextra) argv[n++] = "-Wextra";
    if (werror) argv[n++] = "-Werror";
    if (debug)  argv[n++] = "-g";

    if (compile_only) {
        argv[n++] = "-c";
    } else {
        argv[n++] = "-o";
        argv[n++] = out_exe;
    }
    argv[n++] = cfile;
    argv[n++] = NULL;

    pid_t pid = fork();
    if (pid < 0) return 1;
    if (pid == 0) { execvp("gcc", (char *const*)argv); _exit(127); }

    int st = 0;
    if (waitpid(pid, &st, 0) < 0) return 1;
    if (WIFEXITED(st)) return WEXITSTATUS(st);
    return 1;
}

int main(int argc, char **argv) {
    int emit_c_only = 0;
    int emit_asm_only = 0; /* --asm flag */
    int compile_only = 0;  /* -c flag */
    int emit_c_to_file = 0; /* -E flag */
    int keep_c = 0;        /* --keep-c flag */
    int debug = 0;         /* -g flag */
    int wall = 1;          /* -Wall (default on) */
    int wextra = 1;        /* -Wextra (default on) */
    int werror = 0;        /* -Werror */
    int byteptr = 0;       /* --byteptr flag */
    int dump_tokens = 0;   /* --dump-tokens */
    int dump_ast = 0;      /* --dump-ast */
    int dump_c = 0;        /* --dump-c */
    int no_line = 1;       /* --no-line */
    int verbose_errors = 0; /* --verbose-errors */
    int verbose = 0;       /* -v flag */
    const char *in_path = NULL;
    const char *out_path = "a.out";

    /* Initialize compilation arena */
    g_compilation_arena = arena_new();

    /* Initialize include paths (vec_new already zeros them) */
    /* No need to call vec_init */

    /* Parse arguments */
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-S") == 0) {
            emit_c_only = 1;
        } else if (strcmp(argv[i], "--asm") == 0) {
            emit_asm_only = 1;
        } else if (strcmp(argv[i], "-c") == 0) {
            compile_only = 1;
        } else if (strcmp(argv[i], "-E") == 0) {
            emit_c_to_file = 1;
        } else if (strcmp(argv[i], "--keep-c") == 0) {
            keep_c = 1;
        } else if (strcmp(argv[i], "-g") == 0) {
            debug = 1;
        } else if (strcmp(argv[i], "-Wall") == 0) {
            wall = 1;
        } else if (strcmp(argv[i], "-Wno-all") == 0) {
            wall = 0;
        } else if (strcmp(argv[i], "-Wextra") == 0) {
            wextra = 1;
        } else if (strcmp(argv[i], "-Wno-extra") == 0) {
            wextra = 0;
        } else if (strcmp(argv[i], "-Werror") == 0) {
            werror = 1;
        } else if (strcmp(argv[i], "--byteptr") == 0) {
            byteptr = 1;
        } else if (strcmp(argv[i], "--dump-tokens") == 0) {
            dump_tokens = 1;
        } else if (strcmp(argv[i], "--dump-ast") == 0) {
            dump_ast = 1;
        } else if (strcmp(argv[i], "--dump-c") == 0) {
            dump_c = 1;
        } else if (strcmp(argv[i], "--no-line") == 0) {
            no_line = 1;
        } else if (strcmp(argv[i], "--verbose-errors") == 0) {
            verbose_errors = 1;
        } else if (strcmp(argv[i], "-v") == 0) {
            verbose = 1;
        } else if (strcmp(argv[i], "-o") == 0) {
            if (i + 1 >= argc) dief("missing value after -o");
            out_path = argv[++i];
        } else if (!in_path) {
            in_path = argv[i];
        } else {
            dief("unknown extra argument: %s", argv[i]);
        }
    }

    /* Set developer flags */
    g_no_line = no_line;
    g_verbose_errors = verbose_errors;

    if (!in_path) {
        fprintf(stderr, "usage:\n");
        fprintf(stderr, "  %s [options] input.b [-o out]\n", argv[0]);
        fprintf(stderr, "options:\n");
        fprintf(stderr, "  -S          emit C code to stdout\n");
        fprintf(stderr, "  --asm       emit assembly code to stdout\n");
        fprintf(stderr, "  -c          compile to object file\n");
        fprintf(stderr, "  -E          emit C code to file\n");
        fprintf(stderr, "  --keep-c    don't delete temporary C file\n");
        fprintf(stderr, "  -g          include debug information\n");
        fprintf(stderr, "  -Wall       enable all warnings (default)\n");
        fprintf(stderr, "  -Wno-all    disable all warnings\n");
        fprintf(stderr, "  -Wextra     enable extra warnings (default)\n");
        fprintf(stderr, "  -Wno-extra  disable extra warnings\n");
        fprintf(stderr, "  -Werror     treat warnings as errors\n");
        fprintf(stderr, "  --byteptr   use byte-addressed pointers\n");
        fprintf(stderr, "  -v          verbose compilation output\n");
        fprintf(stderr, "\n");
        fprintf(stderr, "  --dump-tokens  show tokenized input\n");
        fprintf(stderr, "  --dump-ast     show parsed AST\n");
        fprintf(stderr, "  --dump-c       emit generated C even when compiling\n");
        fprintf(stderr, "  --no-line      disable #line directives\n");
        fprintf(stderr, "  --verbose-errors use verbose error messages instead of 2-letter codes\n");

        /* Cleanup compilation arena */
        arena_free(g_compilation_arena);
        g_compilation_arena = NULL;

        return 2;
    }

    if (verbose) fprintf(stderr, "Reading %s...\n", in_path);
    size_t len = 0;
    char *src = read_file_all(in_path, &len);

    Parser P;
    memset(&P, 0, sizeof(P));
    P.L.src = src;
    P.L.len = len;
    P.L.i = 0;
    P.L.line = 1;
    P.L.col = 1;
    P.L.filename = in_path;
    P.source = src;
    P.cur = mk_tok(TK_EOF, 1, 1, in_path);
    next(&P); // prime token

    if (verbose) fprintf(stderr, "Lexing...\n");
    if (dump_tokens) {
        dump_token_stream(&P);
        // Always exit after dumping tokens, as combining with other dumps causes issues
        free(src);
        arena_free(g_compilation_arena);
        g_compilation_arena = NULL;
        return 0;
    }

    if (verbose) fprintf(stderr, "Parsing...\n");
    Program *prog = parse_program_ast(&P);

    tok_free(&P.cur);

    if (dump_ast) {
        dump_ast_program(prog);
        if (!dump_c) {
            // If only dumping AST, exit early
            free(src);
            arena_free(g_compilation_arena);
            g_compilation_arena = NULL;
            return 0;
        }
    }

    if (verbose) fprintf(stderr, "Semantic analysis...\n");
    // Semantic analysis pass
    sem_check_program(prog, in_path);

    if (verbose) fprintf(stderr, "Code generation...\n");
    // Handle different output modes
    if (emit_c_only || dump_c) {
        // -S or --dump-c: emit C to stdout
        emit_program_c(stdout, prog, in_path, byteptr, no_line);
        if (emit_c_only) {
            free(src);
            // Cleanup compilation arena
            arena_free(g_compilation_arena);
            g_compilation_arena = NULL;
            return 0;
        }
        // If --dump-c, continue with compilation
    }

    if (emit_asm_only) {
        // --asm: emit assembly to stdout
        emit_program_asm(stdout, prog);
        free(src);

        // Cleanup compilation arena
        arena_free(g_compilation_arena);
        g_compilation_arena = NULL;

        return 0;
    }

    if (emit_c_to_file) {
        // -E: emit C to file
        FILE *out = fopen(out_path, "w");
        if (!out) dief("cannot open output file '%s': %s", out_path, strerror(errno));
        emit_program_c(out, prog, in_path, byteptr, no_line);
        fclose(out);
        free(src);

        // Cleanup compilation arena
        arena_free(g_compilation_arena);
        g_compilation_arena = NULL;

        return 0;
    }

    // Emit to temp file
    char tmpc_tmpl[] = "/tmp/bcc_out_XXXXXX";
    int fd = mkstemp(tmpc_tmpl);
    if (fd < 0) dief("mkstemp failed: %s", strerror(errno));

    FILE *out = fdopen(fd, "wb");
    if (!out) dief("fdopen failed");

    emit_program_c(out, prog, in_path, byteptr, no_line);
    fclose(out);

    // Rename temp to .c so gcc has nicer behavior
    char *cfile = (char*)malloc(strlen(tmpc_tmpl) + 3);
    if (!cfile) dief("out of memory");
    sprintf(cfile, "%s.c", tmpc_tmpl);
    if (rename(tmpc_tmpl, cfile) != 0) dief("rename temp failed: %s", strerror(errno));

    // Compile with gcc
    int rc = run_gcc(cfile, out_path, compile_only, debug, wall, wextra, werror);
    if (rc != 0) {
        fprintf(stderr, "gcc failed (exit %d). Generated C kept at: %s\n", rc, cfile);
        free(cfile);
        free(src);

        // Cleanup compilation arena
        arena_free(g_compilation_arena);
        g_compilation_arena = NULL;

        return 1;
    }

    // Clean up temp file unless --keep-c was specified
    if (!keep_c) {
        unlink(cfile);
    } else {
        fprintf(stderr, "Generated C kept at: %s\n", cfile);
    }

    free(cfile);
    free(src);

    // Cleanup compilation arena
    arena_free(g_compilation_arena);
    g_compilation_arena = NULL;

    return 0;
}
