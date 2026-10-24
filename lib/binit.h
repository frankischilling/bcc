/* Register each file at load time; run its initializers after argument setup. */
#ifndef BCC_BINIT_H
#define BCC_BINIT_H

struct __bcc_initializer {
    void (*initialize)(void);
    struct __bcc_initializer *next;
    int state; /* 0: unregistered, 1: pending, 2: initialized */
};

#ifdef B_INIT_DEFINE
#ifndef B_INIT_STORAGE
#define B_INIT_STORAGE
#endif
B_INIT_STORAGE struct __bcc_initializer *__bcc_initializers_head;
B_INIT_STORAGE struct __bcc_initializer *__bcc_initializers_tail;
B_INIT_STORAGE int __bcc_runtime_initialized;
#else
extern struct __bcc_initializer *__bcc_initializers_head;
extern struct __bcc_initializer *__bcc_initializers_tail;
extern int __bcc_runtime_initialized;
#endif

static inline void __bcc_register_initializer(struct __bcc_initializer *node) {
    if (node->state) return;
    node->state = 1;
    node->next = 0;
    if (__bcc_initializers_tail) __bcc_initializers_tail->next = node;
    else __bcc_initializers_head = node;
    __bcc_initializers_tail = node;
}

static inline void __bcc_run_initializers(void) {
    for (struct __bcc_initializer *node = __bcc_initializers_head; node; node = node->next) {
        if (node->state == 1) {
            node->state = 2;
            node->initialize();
        }
    }
}

#endif
