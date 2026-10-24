/ bmain.s — crt0 for bcc-pdp programs.
/ Runs at process start; populates _argv[] with argc + argv ptrs (kbman §8),
/ then passes argc/argv to _main, returns _main's value to kernel via sys exit.

/ syscall numbers (V1 manual section II)
exit  = 1.
write = 4.

/ origin required by fixaout.py for 0407 -> 0405 conversion
.. = 40014

.globl	start
.globl	_main
.globl	_argv

start:
	/ kernel layout at start: SP -> argc, argv[0], argv[1], ..., 0
	/ argv[0] is the program name, argv[1..argc-1] are the user args.
	mov	sp, r0
	mov	(r0)+, r1	/ r1 = argc; r0 = &argv[0]

	/ Populate _argv[] (kbman §8: predefined external).
	/ _argv[0] includes the program name, stored at _argv[1].
	mov	r1, r3		/ r3 = remaining count
	mov	$_argv+4, r2	/ r2 = &_argv[1]
	cmp	r3, $31.
	blos	1f
	mov	$31., r3	/ truncate to vector capacity
1:
	mov	r3, _argv+2	/ report only the entries that fit
3:
	tst	r3
	beq	2f
	mov	(r0)+, (r2)+
	dec	r3
	br	3b
2:

	/ Old-style direct push of argc/argv on stack for backwards compat
	mov	$_argv+6, -(sp)	/ compatibility main: skip count and program name
	mov	_argv+2, r0
	dec	r0			/ compatibility main receives user-arg count
	bge	4f
	clr	r0			/ exec may supply an empty argument vector
4:
	mov	r0, -(sp)
	jsr	pc, *_main
	add	$4, sp		/ drop pushed args
	sys	exit		/ kernel reads r0 as exit status

/ Predefined _argv pointer cell plus 32 data words: [argc, ptr1, ptr2, ..., ptr31].
/ Storage cells inline (V1 as has no .bss; data after `sys exit` is unreachable).
.globl	_argv
_argv:
	.+2
	0;0;0;0;0;0;0;0
	0;0;0;0;0;0;0;0
	0;0;0;0;0;0;0;0
	0;0;0;0;0;0;0;0
