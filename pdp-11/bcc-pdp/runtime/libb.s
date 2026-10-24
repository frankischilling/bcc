
.text
	.globl	_printn
_printn:
	.+2
	mov	r5, -(sp)
	mov	sp, r5
	sub	$B30000f, sp
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$2., r0
	cmp	(sp)+, r0
	bge	B0
	mov	$1, r0
	jmp	B1
B0:
	clr	r0
B1:
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$16., r0
	cmp	(sp)+, r0
	ble	B2
	mov	$1, r0
	jmp	B3
B2:
	clr	r0
B3:
	mov	(sp)+, r1
	bis	r1, r0
	tst	r0
	bne	1f
	jmp	B4
1:
	mov	$1., r0
	neg	r0
	jmp	B30000
B4:
	mov	r5, r0
	add	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	bge	B5
	mov	$1, r0
	jmp	B6
B5:
	clr	r0
B6:
	tst	r0
	bne	1f
	jmp	B7
1:
	mov	$_putchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$45., r0
	mov	r0, -(sp)
	mov	2.(sp), r0
	jsr	pc, (r0)
	add	$4., sp
	mov	r5, r0
	sub	$2., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	jsr	pc, .div
	neg	r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	tst	r0
	bne	1f
	jmp	B8
1:
	mov	$_printn, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	mov	4.(sp), r0
	jsr	pc, (r0)
	add	$6., sp
B8:
	mov	r5, r0
	sub	$2., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	jsr	pc, .mod
	neg	r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	jmp	B9
B7:
	mov	r5, r0
	sub	$2., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	jsr	pc, .div
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	tst	r0
	bne	1f
	jmp	B10
1:
	mov	$_printn, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	mov	4.(sp), r0
	jsr	pc, (r0)
	add	$6., sp
B10:
	mov	r5, r0
	sub	$2., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	jsr	pc, .mod
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B9:
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$10., r0
	cmp	(sp)+, r0
	bge	B11
	mov	$1, r0
	jmp	B12
B11:
	clr	r0
B12:
	tst	r0
	bne	1f
	jmp	B13
1:
	mov	$_putchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$48., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	r0, -(sp)
	mov	2.(sp), r0
	jsr	pc, (r0)
	add	$4., sp
	jmp	B14
B13:
	mov	$_putchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$10., r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	r0, -(sp)
	mov	$65., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	r0, -(sp)
	mov	2.(sp), r0
	jsr	pc, (r0)
	add	$4., sp
B14:
	mov	$0., r0
	jmp	B30000
B30000:
	mov	r5, sp
	mov	(sp)+, r5
	rts	pc
B30000f = 2.

.text
	.globl	_getstr
_getstr:
	.+2
	mov	r5, -(sp)
	mov	sp, r5
	sub	$B30001f, sp
	mov	r5, r0
	sub	$2., r0
	asr	r0
	mov	r0, -(sp)
	mov	$0., r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B15:
	mov	$1., r0
	tst	r0
	bne	1f
	jmp	B16
1:
	mov	r5, r0
	sub	$4., r0
	asr	r0
	mov	r0, -(sp)
	mov	$_getchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	jsr	pc, (r0)
	add	$2., sp
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$4., r0
	cmp	(sp)+, r0
	bne	B17
	mov	$1, r0
	jmp	B18
B17:
	clr	r0
B18:
	tst	r0
	bne	1f
	jmp	B19
1:
	mov	$_lchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$4., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	mov	6.(sp), r0
	jsr	pc, (r0)
	add	$8., sp
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	jmp	B30001
B19:
	mov	r5, r0
	sub	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$10., r0
	cmp	(sp)+, r0
	bne	B20
	mov	$1, r0
	jmp	B21
B20:
	clr	r0
B21:
	tst	r0
	bne	1f
	jmp	B22
1:
	mov	$_lchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$4., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	mov	6.(sp), r0
	jsr	pc, (r0)
	add	$8., sp
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	jmp	B30001
B22:
	mov	$_lchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	mov	6.(sp), r0
	jsr	pc, (r0)
	add	$8., sp
	mov	r5, r0
	sub	$2., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	jmp	B15
B16:
B30001:
	mov	r5, sp
	mov	(sp)+, r5
	rts	pc
B30001f = 4.

.text
	.globl	_printf
_printf:
	.+2
	mov	r5, -(sp)
	mov	sp, r5
	sub	$B30002f, sp
	mov	r5, r0
	sub	$8., r0
	asr	r0
	mov	r0, -(sp)
	mov	$0., r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B30003:
B23:
	mov	r5, r0
	sub	$6., r0
	asr	r0
	mov	r0, -(sp)
	mov	$_char, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$8., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	mov	4.(sp), r0
	jsr	pc, (r0)
	add	$6., sp
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r0, -(sp)
	mov	$37., r0
	cmp	(sp)+, r0
	beq	B25
	mov	$1, r0
	jmp	B26
B25:
	clr	r0
B26:
	tst	r0
	bne	1f
	jmp	B24
1:
	mov	r5, r0
	sub	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$4., r0
	cmp	(sp)+, r0
	bne	B27
	mov	$1, r0
	jmp	B28
B27:
	clr	r0
B28:
	tst	r0
	bne	1f
	jmp	B29
1:
	mov	$0., r0
	jmp	B30002
B29:
	mov	r5, r0
	sub	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	bne	B30
	mov	$1, r0
	jmp	B31
B30:
	clr	r0
B31:
	tst	r0
	bne	1f
	jmp	B32
1:
	mov	$0., r0
	jmp	B30002
B32:
	mov	$_putchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	2.(sp), r0
	jsr	pc, (r0)
	add	$4., sp
	mov	r5, r0
	sub	$8., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$8., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	jmp	B23
B24:
	mov	r5, r0
	sub	$8., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$8., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$4., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	asl	r0
	mov	(r0), r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$6., r0
	asr	r0
	mov	r0, -(sp)
	mov	$_char, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$8., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	mov	4.(sp), r0
	jsr	pc, (r0)
	add	$6., sp
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$8., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$8., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$100., r0
	cmp	(sp)+, r0
	bne	B33
	mov	$1, r0
	jmp	B34
B33:
	clr	r0
B34:
	tst	r0
	bne	1f
	jmp	B35
1:
	mov	$_printn, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$10., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	mov	4.(sp), r0
	jsr	pc, (r0)
	add	$6., sp
	jmp	B30003
B35:
	mov	r5, r0
	sub	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$111., r0
	cmp	(sp)+, r0
	bne	B36
	mov	$1, r0
	jmp	B37
B36:
	clr	r0
B37:
	tst	r0
	bne	1f
	jmp	B38
1:
	mov	$_printn, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$8., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	mov	4.(sp), r0
	jsr	pc, (r0)
	add	$6., sp
	jmp	B30003
B38:
	mov	r5, r0
	sub	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$99., r0
	cmp	(sp)+, r0
	bne	B39
	mov	$1, r0
	jmp	B40
B39:
	clr	r0
B40:
	tst	r0
	bne	1f
	jmp	B41
1:
	mov	$_putchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	2.(sp), r0
	jsr	pc, (r0)
	add	$4., sp
	jmp	B30003
B41:
	mov	r5, r0
	sub	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$115., r0
	cmp	(sp)+, r0
	bne	B42
	mov	$1, r0
	jmp	B43
B42:
	clr	r0
B43:
	tst	r0
	bne	1f
	jmp	B44
1:
	mov	r5, r0
	sub	$10., r0
	asr	r0
	mov	r0, -(sp)
	mov	$0., r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B45:
	mov	r5, r0
	sub	$6., r0
	asr	r0
	mov	r0, -(sp)
	mov	$_char, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$10., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	mov	4.(sp), r0
	jsr	pc, (r0)
	add	$6., sp
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r0, -(sp)
	mov	$4., r0
	cmp	(sp)+, r0
	beq	B47
	mov	$1, r0
	jmp	B48
B47:
	clr	r0
B48:
	tst	r0
	bne	1f
	jmp	B46
1:
	mov	r5, r0
	sub	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	bne	B49
	mov	$1, r0
	jmp	B50
B49:
	clr	r0
B50:
	tst	r0
	bne	1f
	jmp	B51
1:
	jmp	B30003
B51:
	mov	$_putchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	2.(sp), r0
	jsr	pc, (r0)
	add	$4., sp
	mov	r5, r0
	sub	$10., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$10., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	jmp	B45
B46:
	jmp	B30003
B44:
	mov	$_putchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$37., r0
	mov	r0, -(sp)
	mov	2.(sp), r0
	jsr	pc, (r0)
	add	$4., sp
	mov	r5, r0
	sub	$8., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$8., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	jmp	B30003
B30002:
	mov	r5, sp
	mov	(sp)+, r5
	rts	pc
B30002f = 10.

.text
	.globl	___ctge
___ctge:
	.+2
	mov	r5, -(sp)
	mov	sp, r5
	sub	$B30004f, sp
	mov	r5, r0
	add	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	bge	B52
	mov	$1, r0
	jmp	B53
B52:
	clr	r0
B53:
	tst	r0
	bne	1f
	jmp	B54
1:
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	blt	B55
	mov	$1, r0
	jmp	B56
B55:
	clr	r0
B56:
	tst	r0
	bne	1f
	jmp	B57
1:
	mov	$1., r0
	jmp	B30004
B57:
	jmp	B58
B54:
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	bge	B59
	mov	$1, r0
	jmp	B60
B59:
	clr	r0
B60:
	tst	r0
	bne	1f
	jmp	B61
1:
	mov	$0., r0
	jmp	B30004
B61:
B58:
	mov	r5, r0
	add	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	cmp	(sp)+, r0
	blt	B62
	mov	$1, r0
	jmp	B63
B62:
	clr	r0
B63:
	jmp	B30004
B30004:
	mov	r5, sp
	mov	(sp)+, r5
	rts	pc
B30004f = 0.

.text
	.globl	J0
J0:
	.+2
	mov	r5, -(sp)
	mov	sp, r5
	sub	$B30005f, sp
	mov	$_lchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$48., r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$8., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$10., r0
	mov	r0, -(sp)
	jsr	pc, .div
	mov	(sp)+, r1
	add	r1, r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	mov	6.(sp), r0
	jsr	pc, (r0)
	add	$8., sp
	mov	$_lchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	r0, -(sp)
	mov	$48., r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$8., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$10., r0
	mov	r0, -(sp)
	jsr	pc, .mod
	mov	(sp)+, r1
	add	r1, r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	mov	6.(sp), r0
	jsr	pc, (r0)
	add	$8., sp
B30005:
	mov	r5, sp
	mov	(sp)+, r5
	rts	pc
B30005f = 0.

.text
	.globl	J1
J1:
	[.+2-start+40014]\/2
	31.
	28.
	31.
	30.
	31.
	30.
	31.
	31.
	30.
	31.
	30.
	31.
	.even

.text
	.globl	_ctime
_ctime:
	.+2
	mov	r5, -(sp)
	mov	sp, r5
	sub	$B30006f, sp
	mov	r5, r0
	sub	$2., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$0., r0
	mov	(sp)+, r1
	add	r1, r0
	asl	r0
	mov	(r0), r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$4., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	asl	r0
	mov	(r0), r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$6., r0
	asr	r0
	mov	r0, -(sp)
	mov	$0., r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B64:
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	bge	B66
	mov	$1, r0
	jmp	B67
B66:
	clr	r0
B67:
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$79., r0
	cmp	(sp)+, r0
	ble	B68
	mov	$1, r0
	jmp	B69
B68:
	clr	r0
B69:
	mov	(sp)+, r1
	bis	r1, r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$79., r0
	cmp	(sp)+, r0
	bne	B70
	mov	$1, r0
	jmp	B71
B70:
	clr	r0
B71:
	mov	r0, -(sp)
	mov	$___ctge, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$6656., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	mov	4.(sp), r0
	jsr	pc, (r0)
	add	$6., sp
	mov	(sp)+, r1
	com	r0
	bic	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	bis	r1, r0
	tst	r0
	bne	1f
	jmp	B65
1:
	mov	$___ctge, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$6656., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	mov	4.(sp), r0
	jsr	pc, (r0)
	add	$6., sp
	tst	r0
	bne	B72
	mov	$1, r0
	jmp	B73
B72:
	clr	r0
B73:
	tst	r0
	bne	1f
	jmp	B74
1:
	mov	r5, r0
	sub	$2., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B74:
	mov	r5, r0
	sub	$4., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$6656., r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$79., r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$6., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	jmp	B64
B65:
	mov	r5, r0
	sub	$8., r0
	asr	r0
	mov	r0, -(sp)
	mov	$0., r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B75:
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	beq	B77
	mov	$1, r0
	jmp	B78
B77:
	clr	r0
B78:
	mov	r0, -(sp)
	mov	$___ctge, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$3600., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	mov	4.(sp), r0
	jsr	pc, (r0)
	add	$6., sp
	mov	(sp)+, r1
	bis	r1, r0
	tst	r0
	bne	1f
	jmp	B76
1:
	mov	$___ctge, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$3600., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	mov	4.(sp), r0
	jsr	pc, (r0)
	add	$6., sp
	tst	r0
	bne	B79
	mov	$1, r0
	jmp	B80
B79:
	clr	r0
B80:
	tst	r0
	bne	1f
	jmp	B81
1:
	mov	r5, r0
	sub	$2., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B81:
	mov	r5, r0
	sub	$4., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$3600., r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$8., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$8., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	jmp	B75
B76:
	mov	r5, r0
	sub	$10., r0
	asr	r0
	mov	r0, -(sp)
	mov	$1971., r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$14., r0
	asr	r0
	mov	r0, -(sp)
	mov	$365., r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B82:
	mov	r5, r0
	sub	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$14., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	cmp	(sp)+, r0
	blt	B84
	mov	$1, r0
	jmp	B85
B84:
	clr	r0
B85:
	tst	r0
	bne	1f
	jmp	B83
1:
	mov	r5, r0
	sub	$6., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$14., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$10., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$10., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$14., r0
	asr	r0
	mov	r0, -(sp)
	mov	$365., r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$10., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$4., r0
	mov	r0, -(sp)
	jsr	pc, .mod
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	bne	B86
	mov	$1, r0
	jmp	B87
B86:
	clr	r0
B87:
	tst	r0
	bne	1f
	jmp	B88
1:
	mov	r5, r0
	sub	$14., r0
	asr	r0
	mov	r0, -(sp)
	mov	$366., r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B88:
	jmp	B82
B83:
	mov	r5, r0
	sub	$12., r0
	asr	r0
	mov	r0, -(sp)
	mov	$0., r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$14., r0
	asr	r0
	mov	r0, -(sp)
	mov	$J1, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$12., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	(sp)+, r1
	add	r1, r0
	asl	r0
	mov	(r0), r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B89:
	mov	r5, r0
	sub	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$14., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	cmp	(sp)+, r0
	blt	B91
	mov	$1, r0
	jmp	B92
B91:
	clr	r0
B92:
	tst	r0
	bne	1f
	jmp	B90
1:
	mov	r5, r0
	sub	$6., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$14., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$12., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$12., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$14., r0
	asr	r0
	mov	r0, -(sp)
	mov	$J1, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$12., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	(sp)+, r1
	add	r1, r0
	asl	r0
	mov	(r0), r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$12., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	cmp	(sp)+, r0
	bne	B93
	mov	$1, r0
	jmp	B94
B93:
	clr	r0
B94:
	mov	r0, -(sp)
	mov	r5, r0
	sub	$10., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$4., r0
	mov	r0, -(sp)
	jsr	pc, .mod
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	bne	B95
	mov	$1, r0
	jmp	B96
B95:
	clr	r0
B96:
	mov	(sp)+, r1
	com	r0
	bic	r0, r1
	mov	r1, r0
	tst	r0
	bne	1f
	jmp	B97
1:
	mov	r5, r0
	sub	$14., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$14., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B97:
	jmp	B89
B90:
	mov	r5, r0
	sub	$16., r0
	asr	r0
	mov	r0, -(sp)

.text
	jmp	LC0
C0:
	.byte	74.,97.,110.,70.,101.,98.,77.,97.,114.,65.,112.,114.,77.,97.,121.,74.,117.,110.,74.,117.,108.,65.,117.,103.,83.,101.,112.,79.,99.,116.,78.,111.,118.,68.,101.,99.,4.
	.even
LC0:
	mov	$C0, r0
	asr	r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$18., r0
	asr	r0
	mov	r0, -(sp)
	mov	$0., r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B98:
	mov	r5, r0
	sub	$18., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$3., r0
	cmp	(sp)+, r0
	bge	B100
	mov	$1, r0
	jmp	B101
B100:
	clr	r0
B101:
	tst	r0
	bne	1f
	jmp	B99
1:
	mov	$_lchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$18., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$_char, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$16., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$12., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$3., r0
	mov	r0, -(sp)
	jsr	pc, .mul
	mov	r0, -(sp)
	mov	r5, r0
	sub	$18., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	(sp)+, r1
	add	r1, r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	mov	4.(sp), r0
	jsr	pc, (r0)
	add	$6., sp
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	mov	6.(sp), r0
	jsr	pc, (r0)
	add	$8., sp
	mov	r5, r0
	sub	$18., r0
	asr	r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$18., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	jmp	B98
B99:
	mov	$_lchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$3., r0
	mov	r0, -(sp)
	mov	$32., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	mov	6.(sp), r0
	jsr	pc, (r0)
	add	$8., sp
	mov	$J0, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$4., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	mov	6.(sp), r0
	jsr	pc, (r0)
	add	$8., sp
	mov	r5, r0
	sub	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$9., r0
	cmp	(sp)+, r0
	bge	B102
	mov	$1, r0
	jmp	B103
B102:
	clr	r0
B103:
	tst	r0
	bne	1f
	jmp	B104
1:
	mov	$_lchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$4., r0
	mov	r0, -(sp)
	mov	$32., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	mov	6.(sp), r0
	jsr	pc, (r0)
	add	$8., sp
B104:
	mov	$_lchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$6., r0
	mov	r0, -(sp)
	mov	$32., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	mov	6.(sp), r0
	jsr	pc, (r0)
	add	$8., sp
	mov	$J0, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$7., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$8., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$60., r0
	mov	r0, -(sp)
	jsr	pc, .div
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	mov	6.(sp), r0
	jsr	pc, (r0)
	add	$8., sp
	mov	$_lchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$9., r0
	mov	r0, -(sp)
	mov	$58., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	mov	6.(sp), r0
	jsr	pc, (r0)
	add	$8., sp
	mov	$J0, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$10., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$8., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$60., r0
	mov	r0, -(sp)
	jsr	pc, .mod
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	mov	6.(sp), r0
	jsr	pc, (r0)
	add	$8., sp
	mov	$_lchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$12., r0
	mov	r0, -(sp)
	mov	$58., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	mov	6.(sp), r0
	jsr	pc, (r0)
	add	$8., sp
	mov	$J0, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$13., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$60., r0
	mov	r0, -(sp)
	jsr	pc, .div
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	mov	6.(sp), r0
	jsr	pc, (r0)
	add	$8., sp
	mov	$_lchar, r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	asr	r0
	asl	r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$15., r0
	mov	r0, -(sp)
	mov	$0., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	mov	6.(sp), r0
	jsr	pc, (r0)
	add	$8., sp
	mov	$0., r0
	jmp	B30006
B30006:
	mov	r5, sp
	mov	(sp)+, r5
	rts	pc
B30006f = 18.
