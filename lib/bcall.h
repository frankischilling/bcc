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

#ifdef B_CALL_DEFINE
#ifndef B_CALL_STORAGE
#define B_CALL_STORAGE
#endif
B_CALL_STORAGE struct __bcc_call_frame *__bcc_current_call;
B_CALL_STORAGE struct __bcc_source_function *__bcc_source_functions;
#else
extern struct __bcc_call_frame *__bcc_current_call;
extern struct __bcc_source_function *__bcc_source_functions;
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
        if (node->code == code) return 1;
    return 0;
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

#endif
