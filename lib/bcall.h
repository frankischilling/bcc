/* Source functions use explicit argument frames rather than the host C ABI. */
#ifndef BCC_BCALL_H
#define BCC_BCALL_H

struct __bcc_call_frame {
    size_t count;
    const word *arguments;
    struct __bcc_call_frame *previous;
};

struct __bcc_source_function {
    void *code;
    struct __bcc_source_function *next;
    int registered;
};

/* Keep named bindings separate from the original three-field call records. */
struct __bcc_library_binding {
    const char *name;
    word *cell;
    struct __bcc_library_binding *next;
    int registered;
};

/* Runtime code keeps its original value while its public cell can change. */
struct __bcc_builtin_record {
    const char *name;
    word *cell;
    word code;
    word (*invoke)(size_t, const word *);
    struct __bcc_builtin_record *next;
    int registered;
    struct __bcc_builtin_record *code_next, *name_next;
};

#ifdef B_CALL_DEFINE
#ifndef B_CALL_STORAGE
#define B_CALL_STORAGE
#endif
B_CALL_STORAGE uword __bcc_label_serial;
B_CALL_STORAGE struct __bcc_call_frame *__bcc_current_call;
B_CALL_STORAGE struct __bcc_source_function *__bcc_source_functions;
B_CALL_STORAGE struct __bcc_library_binding *__bcc_source_bindings;
B_CALL_STORAGE struct __bcc_builtin_record *__bcc_builtin_functions;
B_CALL_STORAGE struct __bcc_builtin_record *__bcc_builtin_codes[256];
B_CALL_STORAGE struct __bcc_builtin_record *__bcc_builtin_names[64];
#else
extern uword __bcc_label_serial;
extern struct __bcc_call_frame *__bcc_current_call;
extern struct __bcc_source_function *__bcc_source_functions;
extern struct __bcc_library_binding *__bcc_source_bindings;
extern struct __bcc_builtin_record *__bcc_builtin_functions;
extern struct __bcc_builtin_record *__bcc_builtin_codes[256];
extern struct __bcc_builtin_record *__bcc_builtin_names[64];
#endif

/* Label tokens share one namespace and fit the selected B word model. */
static inline word __bcc_new_label(void) {
    if (__bcc_label_serial >= WORD_MASK - 1) {
        fputs("bcc: label token space exhausted\n", stderr);
        exit(1);
    }
    ++__bcc_label_serial;
    return WVAL(__bcc_label_serial + 1);
}

static inline void __bcc_register_function(struct __bcc_source_function *node) {
    if (node->registered) return;
    node->registered = 1;
    node->next = __bcc_source_functions;
    __bcc_source_functions = node;
}

static inline int __bcc_is_source_function(word function) {
    void *code = B_FUNCTION_CPTR(function);
    for (struct __bcc_source_function *node = __bcc_source_functions; node; node = node->next)
        if (node->code && node->code == code) return 1;
    return 0;
}

static inline unsigned __bcc_builtin_name_hash(const char *name) {
    unsigned hash = 0;
    while (*name) hash = hash * 33 + (unsigned char)*name++;
    return hash & 63;
}

static inline unsigned __bcc_builtin_code_hash(word code) {
    uword bits = (uword)code;
    return (unsigned)((bits >> 3) ^ (bits >> 11)) & 255;
}

static inline void __bcc_register_binding(struct __bcc_library_binding *node) {
    if (node->registered) return;
    node->registered = 1;
    node->next = __bcc_source_bindings;
    __bcc_source_bindings = node;
    unsigned hash = __bcc_builtin_name_hash(node->name);
    for (struct __bcc_builtin_record *entry = __bcc_builtin_names[hash]; entry; entry = entry->name_next)
        if (!strcmp(entry->name, node->name)) entry->cell = node->cell;
}

static inline word *__bcc_source_binding(const char *name) {
    for (struct __bcc_library_binding *node = __bcc_source_bindings; node; node = node->next)
        if (node->name && !strcmp(node->name, name)) return node->cell;
    return NULL;
}

static inline word *__bcc_binding_cell(const char *name) {
    unsigned hash = __bcc_builtin_name_hash(name);
    for (struct __bcc_builtin_record *node = __bcc_builtin_names[hash]; node; node = node->name_next)
        if (!strcmp(node->name, name)) return node->cell;
    return __bcc_source_binding(name);
}

static inline int __bcc_try_builtin(word function, size_t count, const word *arguments, word *result) {
    unsigned hash = __bcc_builtin_code_hash(function);
    for (struct __bcc_builtin_record *node = __bcc_builtin_codes[hash]; node; node = node->code_next) {
        if (node->code == function) {
            *result = node->invoke(count, arguments);
            return 1;
        }
    }
    return 0;
}

static inline word __bcc_library_value(const char *name, word fallback) {
    word *cell = __bcc_binding_cell(name);
    return cell ? *cell : fallback;
}

static inline word __bcc_invoke_source(word function, size_t count, const word *arguments) {
    struct __bcc_call_frame frame = {count, arguments, __bcc_current_call};
    __bcc_current_call = &frame;
    word result = ((word (*)(void))B_FUNCTION_CPTR(function))();
    __bcc_current_call = frame.previous;
    return result;
}

static inline word __bcc_call0(word function) {
    word result;
    if (__bcc_try_builtin(function, 0, NULL, &result)) return result;
    if (__bcc_is_source_function(function)) return __bcc_invoke_source(function, 0, NULL);
    return ((word (*)())B_FUNCTION_CPTR(function))();
}

static inline word __bcc_call1(word function, word a) {
    word result;
    if (__bcc_try_builtin(function, 1, &a, &result)) return result;
    if (__bcc_is_source_function(function)) return __bcc_invoke_source(function, 1, &a);
    return ((word (*)())B_FUNCTION_CPTR(function))(a);
}

static inline word __bcc_call2(word function, word a, word b) {
    word arguments[2] = {a, b};
    word result;
    if (__bcc_try_builtin(function, 2, arguments, &result)) return result;
    if (__bcc_is_source_function(function)) return __bcc_invoke_source(function, 2, arguments);
    return ((word (*)())B_FUNCTION_CPTR(function))(a, b);
}

static inline word __bcc_call3(word function, word a, word b, word c) {
    word arguments[3] = {a, b, c};
    word result;
    if (__bcc_try_builtin(function, 3, arguments, &result)) return result;
    if (__bcc_is_source_function(function)) return __bcc_invoke_source(function, 3, arguments);
    return ((word (*)())B_FUNCTION_CPTR(function))(a, b, c);
}

static inline word __bcc_library_call0(const char *name, word (*fallback)(void)) {
    word *cell = __bcc_binding_cell(name);
    return cell ? __bcc_call0(*cell) : fallback();
}

static inline word __bcc_library_call1(const char *name, word (*fallback)(word), word a) {
    word *cell = __bcc_binding_cell(name);
    return cell ? __bcc_call1(*cell, a) : fallback(a);
}

static inline word __bcc_library_call2(const char *name, word (*fallback)(word, word), word a, word b) {
    word *cell = __bcc_binding_cell(name);
    return cell ? __bcc_call2(*cell, a, b) : fallback(a, b);
}

static inline word __bcc_library_call3(const char *name, word (*fallback)(word, word, word), word a, word b, word c) {
    word *cell = __bcc_binding_cell(name);
    return cell ? __bcc_call3(*cell, a, b, c) : fallback(a, b, c);
}

#endif
