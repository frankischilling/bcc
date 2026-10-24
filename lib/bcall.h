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

#ifdef B_CALL_DEFINE
#ifndef B_CALL_STORAGE
#define B_CALL_STORAGE
#endif
B_CALL_STORAGE struct __bcc_call_frame *__bcc_current_call;
B_CALL_STORAGE struct __bcc_source_function *__bcc_source_functions;
B_CALL_STORAGE struct __bcc_library_binding *__bcc_source_bindings;
#else
extern struct __bcc_call_frame *__bcc_current_call;
extern struct __bcc_source_function *__bcc_source_functions;
extern struct __bcc_library_binding *__bcc_source_bindings;
#endif

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

static inline void __bcc_register_binding(struct __bcc_library_binding *node) {
    if (node->registered) return;
    node->registered = 1;
    node->next = __bcc_source_bindings;
    __bcc_source_bindings = node;
}

static inline word *__bcc_source_binding(const char *name) {
    for (struct __bcc_library_binding *node = __bcc_source_bindings; node; node = node->next)
        if (node->name && !strcmp(node->name, name)) return node->cell;
    return NULL;
}

static inline word __bcc_library_value(const char *name, word fallback) {
    word *cell = __bcc_source_binding(name);
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
    if (__bcc_is_source_function(function)) return __bcc_invoke_source(function, 0, NULL);
    return ((word (*)())B_FUNCTION_CPTR(function))();
}

static inline word __bcc_call1(word function, word a) {
    if (__bcc_is_source_function(function)) return __bcc_invoke_source(function, 1, &a);
    return ((word (*)())B_FUNCTION_CPTR(function))(a);
}

static inline word __bcc_call2(word function, word a, word b) {
    word arguments[2] = {a, b};
    if (__bcc_is_source_function(function)) return __bcc_invoke_source(function, 2, arguments);
    return ((word (*)())B_FUNCTION_CPTR(function))(a, b);
}

static inline word __bcc_call3(word function, word a, word b, word c) {
    word arguments[3] = {a, b, c};
    if (__bcc_is_source_function(function)) return __bcc_invoke_source(function, 3, arguments);
    return ((word (*)())B_FUNCTION_CPTR(function))(a, b, c);
}

static inline word __bcc_library_call0(const char *name, word (*fallback)(void)) {
    word *cell = __bcc_source_binding(name);
    return cell ? __bcc_call0(*cell) : fallback();
}

static inline word __bcc_library_call1(const char *name, word (*fallback)(word), word a) {
    word *cell = __bcc_source_binding(name);
    return cell ? __bcc_call1(*cell, a) : fallback(a);
}

static inline word __bcc_library_call2(const char *name, word (*fallback)(word, word), word a, word b) {
    word *cell = __bcc_source_binding(name);
    return cell ? __bcc_call2(*cell, a, b) : fallback(a, b);
}

static inline word __bcc_library_call3(const char *name, word (*fallback)(word, word, word), word a, word b, word c) {
    word *cell = __bcc_source_binding(name);
    return cell ? __bcc_call3(*cell, a, b, c) : fallback(a, b, c);
}

#endif
