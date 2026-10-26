/ Startup for word-addressed B programs. Kernel argv strings may be odd-aligned.
exit = 1.
write = 4.
.. = 40014
.globl start
.globl _main
.globl _argv
.globl .bend

start:
	mov	sp, r0
	mov	(r0)+, r1
	bic	$1, sp		/ keep copies and B frames word-aligned
	/ Reserve the complete count-prefixed vector before copying strings.
	cmp	r1, $8190.
	bhi	.argerr
	mov	r1, r2
	inc	r2
	asl	r2
	mov	sp, r5
	sub	r2, r5
	bcs	.argerr
	cmp	r5, $.bend+8
	blos	.argerr
	mov	r5, sp
	mov	r5, r2
	mov	r5, _argv
	asr	_argv
	mov	r1, (r2)+
.arglp:
	tst	r1
	beq	.argdn
	mov	(r0)+, r3
	mov	r3, r4
.argln:
	tstb	(r4)+
	bne	.argln
	sub	r3, r4
	inc	r4
	beq	.argerr
	bic	$1, r4
	mov	sp, r5
	sub	r4, r5
	bcs	.argerr
	cmp	r5, $.bend+8
	blos	.argerr
	mov	r5, sp
	mov	sp, r4
.argcp:
	movb	(r3)+, (r4)+
	bne	.argcp
	mov	sp, r4
	asr	r4
	mov	r4, (r2)+
	dec	r1
	br	.arglp
.argdn:
	/ Optional main parameters exclude the program name.
	clr	r5
	mov	_argv, r0
	add	$2, r0
	mov	r0, -(sp)
	mov	_argv, r0
	asl	r0
	mov	(r0), r0
	dec	r0
	bge	1f
	clr	r0
1:
	mov	r0, -(sp)
	jsr	pc, *_main
	add	$4, sp
	sys	exit
.argerr:
	mov	$1, r0
	sys	write; .argmsg; 22.
	mov	$1, r0
	sys	exit
.argmsg: <bcc: argument storage\n>
.even

/ Writable pointer cell; startup allocates its vector on the process stack.
_argv:
	0
