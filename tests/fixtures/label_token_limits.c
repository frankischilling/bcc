#define B_CALL_DEFINE
#include "libb.h"
int main(int argc, char **argv) {
    (void)argv;
    if (__bcc_new_label() != 2 || __bcc_new_label() != 3) return 2;
    __bcc_label_serial = WORD_MASK - 2;
    if (__bcc_new_label() != WVAL(WORD_MASK)) return 3;
    if (argc > 1) __bcc_new_label();
    return 0;
}
