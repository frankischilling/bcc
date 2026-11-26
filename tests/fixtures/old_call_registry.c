/* The three-field registry emitted before named library bindings existed.
 * The adjacent word is unrelated data, not another field of the record. */
#include <stddef.h>
#include <stdint.h>

typedef intptr_t word;
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
extern struct __bcc_call_frame *__bcc_current_call;
extern struct __bcc_source_function *__bcc_source_functions;

static word old_body(void) {
    if (!__bcc_current_call || __bcc_current_call->count != 1) return -1;
    return __bcc_current_call->arguments[0] + 1;
}
word __bcc_user_b_oldfn[1] = {(word)(uintptr_t)old_body};
static struct {
    struct __bcc_source_function record;
    uintptr_t unrelated_data;
} fixture = {{(void *)old_body, NULL, 1}, 1};

static void __attribute__((constructor(102))) register_old_function(void) {
    fixture.record.next = __bcc_source_functions;
    __bcc_source_functions = &fixture.record;
}
