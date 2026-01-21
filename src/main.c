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

/* Run gcc with multiple C files for linking */
int run_gcc_multi(Vec *cfiles, const char *out_exe, int compile_only, int debug, int wall, int wextra, int werror, Vec *extra_args) {
    /* Dynamic argv: flags + cfiles + extra_args + libs + NULL */
    size_t max_args = 32 + cfiles->len + (extra_args ? extra_args->len : 0);
    const char **argv = (const char**)malloc(max_args * sizeof(char*));
    if (!argv) dief("out of memory");

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

    /* Add all C files */
    for (size_t i = 0; i < cfiles->len; i++) {
        argv[n++] = (const char*)cfiles->data[i];
    }

    /* Add extra arguments */
    if (extra_args) {
        for (size_t i = 0; i < extra_args->len; i++) {
            argv[n++] = (const char*)extra_args->data[i];
        }
    }

    if (!compile_only) { argv[n++] = "-ldl"; argv[n++] = "-lm"; }
    argv[n++] = NULL;

    pid_t pid = fork();
    if (pid < 0) { free(argv); return 1; }
    if (pid == 0) { execvp("gcc", (char *const*)argv); _exit(127); }

    int st = 0;
    if (waitpid(pid, &st, 0) < 0) { free(argv); return 1; }
    free(argv);
    if (WIFEXITED(st)) return WEXITSTATUS(st);
    return 1;
}

/* Compile a single .b file to C, returning the path to the generated .c file */
char *compile_b_to_c(const char *in_path, int byteptr, int no_line, int verbose,
                     int dump_tokens, int dump_ast, int dump_c,
                     int emit_c, const char *emit_c_path) {
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
    next(&P);

    if (verbose) fprintf(stderr, "Lexing...\n");
    if (dump_tokens) {
        dump_token_stream(&P);
        free(src);
        return NULL;
    }

    if (verbose) fprintf(stderr, "Parsing...\n");
    Program *prog = parse_program_ast(&P);
    tok_free(&P.cur);

    if (dump_ast) {
        dump_ast_program(prog);
        if (!dump_c) {
            free(src);
            return NULL;
        }
    }

    if (verbose) fprintf(stderr, "Semantic analysis...\n");
    sem_check_program(prog, in_path);

    if (verbose) fprintf(stderr, "Code generation...\n");

    /* Determine output C file path */
    char *cfile;
    FILE *out;

    if (emit_c && emit_c_path) {
        /* --emit-c: use specified path (e.g., foo.b -> foo.b.c) */
        /* Use strdup not sdup - cfile will be free'd later */
        cfile = strdup(emit_c_path);
        if (!cfile) dief("out of memory");
        out = fopen(cfile, "w");
        if (!out) dief("cannot open '%s': %s", cfile, strerror(errno));
    } else {
        /* Generate temp file */
        char tmpc_tmpl[] = "/tmp/bcc_XXXXXX";
        int fd = mkstemp(tmpc_tmpl);
        if (fd < 0) dief("mkstemp failed: %s", strerror(errno));
        out = fdopen(fd, "wb");
        if (!out) dief("fdopen failed");

        /* Rename to .c extension */
        cfile = (char*)malloc(strlen(tmpc_tmpl) + 3);
        if (!cfile) dief("out of memory");
        sprintf(cfile, "%s.c", tmpc_tmpl);
        fclose(out);
        if (rename(tmpc_tmpl, cfile) != 0) dief("rename temp failed: %s", strerror(errno));
        out = fopen(cfile, "w");
        if (!out) dief("cannot reopen '%s': %s", cfile, strerror(errno));
    }

    emit_program_c(out, prog, in_path, byteptr, no_line);
    fclose(out);

    if (dump_c) {
        /* Also dump to stdout if requested */
        FILE *f = fopen(cfile, "r");
        if (f) {
            int ch;
            while ((ch = fgetc(f)) != EOF) putchar(ch);
            fclose(f);
        }
    }

    free(src);
    return cfile;
}

int main(int argc, char **argv) {
    int emit_c_only = 0;
    int emit_asm_only = 0; /* --asm flag */
    int compile_only = 0;  /* -c flag */
    int emit_c_to_file = 0; /* -E flag */
    int keep_c = 0;        /* --keep-c flag */
    int emit_c = 0;        /* --emit-c flag (a.b -> a.b.c naming) */
    int debug = 0;         /* -g flag */
    int wall = 1;          /* -Wall (default on) */
    int wextra = 1;        /* -Wextra (default on) */
    int werror = 0;        /* -Werror */
    int byteptr = 1;       /* --byteptr flag (default on for byte-addressed programs) */
    int dump_tokens = 0;   /* --dump-tokens */
    int dump_ast = 0;      /* --dump-ast */
    int dump_c = 0;        /* --dump-c */
    int no_line = 1;       /* --no-line */
    int verbose_errors = 0; /* --verbose-errors */
    int verbose = 0;       /* -v flag */
    Vec extra_gcc_args;    /* extra arguments to pass to gcc */
    Vec in_paths;          /* input .b files */
    const char *out_path = NULL;

    /* Initialize compilation arena */
    g_compilation_arena = arena_new();

    /* Initialize vectors */
    memset(&extra_gcc_args, 0, sizeof(extra_gcc_args));
    memset(&in_paths, 0, sizeof(in_paths));

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
        } else if (strcmp(argv[i], "--emit-c") == 0) {
            emit_c = 1;
            keep_c = 1; /* --emit-c implies keeping the C files */
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
        } else if (strcmp(argv[i], "-l") == 0) {
            if (i + 1 >= argc) dief("missing value after -l");
            const char *lib_name = argv[++i];
            size_t len = strlen(lib_name) + 3;
            char *lib_arg = (char*)malloc(len);
            if (!lib_arg) dief("out of memory");
            snprintf(lib_arg, len, "-l%s", lib_name);
            vec_push(&extra_gcc_args, lib_arg);
        } else if (strcmp(argv[i], "-X") == 0) {
            if (i + 1 >= argc) dief("missing value after -X");
            vec_push(&extra_gcc_args, sdup(argv[++i]));
        } else if (argv[i][0] == '-') {
            dief("unknown option: %s", argv[i]);
        } else {
            /* Input file */
            vec_push(&in_paths, argv[i]);
        }
    }

    /* Set developer flags */
    g_no_line = no_line;
    g_verbose_errors = verbose_errors;

    if (in_paths.len == 0) {
        fprintf(stderr, "usage:\n");
        fprintf(stderr, "  %s [options] input.b ... [-o out]\n", argv[0]);
        fprintf(stderr, "\n");
        fprintf(stderr, "Multi-file compilation:\n");
        fprintf(stderr, "  %s a.b b.b c.b -o prog    compile and link multiple .b files\n", argv[0]);
        fprintf(stderr, "\n");
        fprintf(stderr, "options:\n");
        fprintf(stderr, "  -S          emit C code to stdout (single file only)\n");
        fprintf(stderr, "  --asm       emit assembly code to stdout (single file only)\n");
        fprintf(stderr, "  -c          compile to object file(s), don't link\n");
        fprintf(stderr, "  -E          emit C code to file (single file only)\n");
        fprintf(stderr, "  --keep-c    keep generated C files\n");
        fprintf(stderr, "  --emit-c    use a.b -> a.b.c naming for C files (implies --keep-c)\n");
        fprintf(stderr, "  -g          include debug information\n");
        fprintf(stderr, "  -l LIB      pass library to linker (can be repeated)\n");
        fprintf(stderr, "  -X FLAG     pass FLAG directly to gcc (can be repeated)\n");
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

        arena_free(g_compilation_arena);
        g_compilation_arena = NULL;
        return 2;
    }

    /* Default output path */
    if (!out_path) {
        out_path = "a.out";
    }

    /* Single-file special modes that emit to stdout */
    if (emit_c_only || emit_asm_only) {
        if (in_paths.len > 1) {
            dief("-S and --asm only work with a single input file");
        }
        const char *in_path = (const char*)in_paths.data[0];

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
        next(&P);

        Program *prog = parse_program_ast(&P);
        tok_free(&P.cur);
        sem_check_program(prog, in_path);

        if (emit_c_only) {
            emit_program_c(stdout, prog, in_path, byteptr, no_line);
        } else {
            emit_program_asm(stdout, prog);
        }

        free(src);
        arena_free(g_compilation_arena);
        g_compilation_arena = NULL;
        return 0;
    }

    /* Single-file -E mode */
    if (emit_c_to_file) {
        if (in_paths.len > 1) {
            dief("-E only works with a single input file");
        }
        const char *in_path = (const char*)in_paths.data[0];

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
        next(&P);

        Program *prog = parse_program_ast(&P);
        tok_free(&P.cur);
        sem_check_program(prog, in_path);

        FILE *out = fopen(out_path, "w");
        if (!out) dief("cannot open '%s': %s", out_path, strerror(errno));
        emit_program_c(out, prog, in_path, byteptr, no_line);
        fclose(out);

        free(src);
        arena_free(g_compilation_arena);
        g_compilation_arena = NULL;
        return 0;
    }

    /* Multi-file compilation */
    Vec cfiles;
    memset(&cfiles, 0, sizeof(cfiles));

    for (size_t i = 0; i < in_paths.len; i++) {
        const char *in_path = (const char*)in_paths.data[i];

        /* Determine C output path */
        char *emit_c_path = NULL;
        if (emit_c) {
            /* a.b -> a.b.c */
            size_t plen = strlen(in_path);
            emit_c_path = (char*)malloc(plen + 3);
            if (!emit_c_path) dief("out of memory");
            sprintf(emit_c_path, "%s.c", in_path);
        }

        char *cfile = compile_b_to_c(in_path, byteptr, no_line, verbose,
                                     dump_tokens, dump_ast, dump_c,
                                     emit_c, emit_c_path);

        if (emit_c_path) free(emit_c_path);

        if (!cfile) {
            /* compile_b_to_c returns NULL for --dump-tokens/--dump-ast without --dump-c */
            arena_free(g_compilation_arena);
            g_compilation_arena = NULL;
            return 0;
        }

        vec_push(&cfiles, cfile);
        if (verbose) fprintf(stderr, "Compiled %s -> %s\n", in_path, cfile);
    }

    /* Link all C files with gcc */
    if (verbose) fprintf(stderr, "Linking %zu file(s)...\n", cfiles.len);

    int rc = run_gcc_multi(&cfiles, out_path, compile_only, debug, wall, wextra, werror, &extra_gcc_args);

    if (rc != 0) {
        fprintf(stderr, "gcc failed (exit %d)\n", rc);
        if (!keep_c) {
            fprintf(stderr, "Generated C files:\n");
            for (size_t i = 0; i < cfiles.len; i++) {
                fprintf(stderr, "  %s\n", (char*)cfiles.data[i]);
            }
        }
        /* Don't clean up C files on failure so user can inspect */
        arena_free(g_compilation_arena);
        g_compilation_arena = NULL;
        return 1;
    }

    /* Clean up temp C files unless --keep-c */
    for (size_t i = 0; i < cfiles.len; i++) {
        char *cfile = (char*)cfiles.data[i];
        if (!keep_c) {
            unlink(cfile);
        } else if (verbose) {
            fprintf(stderr, "Kept: %s\n", cfile);
        }
        free(cfile);
    }

    arena_free(g_compilation_arena);
    g_compilation_arena = NULL;
    return 0;
}
