
.text
	.globl	_printn
_printn:
	.+2
	mov	r5, -(sp)
	mov	sp, r5
	sub	$B30000f, sp
	mov	6.(r5), r0
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
	mov	6.(r5), r0
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
	mov	4.(r5), r0
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
	mov	_putchar, r0
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
	mov	4.(r5), r0
	mov	r0, -(sp)
	mov	6.(r5), r0
	mov	r0, -(sp)
	jsr	pc, .div
	neg	r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	-2.(r5), r0
	tst	r0
	bne	1f
	jmp	B8
1:
	mov	_printn, r0
	mov	r0, -(sp)
	mov	-2.(r5), r0
	mov	r0, -(sp)
	mov	6.(r5), r0
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
	mov	4.(r5), r0
	mov	r0, -(sp)
	mov	6.(r5), r0
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
	mov	4.(r5), r0
	mov	r0, -(sp)
	mov	6.(r5), r0
	mov	r0, -(sp)
	jsr	pc, .div
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	-2.(r5), r0
	tst	r0
	bne	1f
	jmp	B10
1:
	mov	_printn, r0
	mov	r0, -(sp)
	mov	-2.(r5), r0
	mov	r0, -(sp)
	mov	6.(r5), r0
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
	mov	4.(r5), r0
	mov	r0, -(sp)
	mov	6.(r5), r0
	mov	r0, -(sp)
	jsr	pc, .mod
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B9:
	mov	-2.(r5), r0
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
	mov	_putchar, r0
	mov	r0, -(sp)
	mov	-2.(r5), r0
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
	mov	_putchar, r0
	mov	r0, -(sp)
	mov	-2.(r5), r0
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
	mov	_getchar, r0
	mov	r0, -(sp)
	clr	-(sp)
	mov	2.(sp), r0
	jsr	pc, (r0)
	add	$4., sp
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	-4.(r5), r0
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
	mov	_lchar, r0
	mov	r0, -(sp)
	mov	4.(r5), r0
	mov	r0, -(sp)
	mov	-2.(r5), r0
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
	mov	-2.(r5), r0
	jmp	B30001
B19:
	mov	-4.(r5), r0
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
	mov	_lchar, r0
	mov	r0, -(sp)
	mov	4.(r5), r0
	mov	r0, -(sp)
	mov	-2.(r5), r0
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
	mov	-2.(r5), r0
	jmp	B30001
B22:
	mov	_lchar, r0
	mov	r0, -(sp)
	mov	4.(r5), r0
	mov	r0, -(sp)
	mov	-2.(r5), r0
	mov	r0, -(sp)
	mov	-4.(r5), r0
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
	mov	-2.(r5), r0
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
	mov	_char, r0
	mov	r0, -(sp)
	mov	4.(r5), r0
	mov	r0, -(sp)
	mov	-8.(r5), r0
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
	mov	-6.(r5), r0
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
	mov	_putchar, r0
	mov	r0, -(sp)
	mov	-6.(r5), r0
	mov	r0, -(sp)
	mov	2.(sp), r0
	jsr	pc, (r0)
	add	$4., sp
	mov	r5, r0
	sub	$8., r0
	asr	r0
	mov	r0, -(sp)
	mov	-8.(r5), r0
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
	mov	-8.(r5), r0
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
	mov	-2.(r5), r0
	asl	r0
	mov	(r0), r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$2., r0
	asr	r0
	mov	r0, -(sp)
	mov	-2.(r5), r0
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
	mov	_char, r0
	mov	r0, -(sp)
	mov	4.(r5), r0
	mov	r0, -(sp)
	mov	-8.(r5), r0
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
	mov	-8.(r5), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	-6.(r5), r0
	mov	r0, -(sp)
	mov	$100., r0
	cmp	(sp)+, r0
	bne	B30
	mov	$1, r0
	jmp	B31
B30:
	clr	r0
B31:
	mov	r0, -(sp)
	mov	-6.(r5), r0
	mov	r0, -(sp)
	mov	$111., r0
	cmp	(sp)+, r0
	bne	B32
	mov	$1, r0
	jmp	B33
B32:
	clr	r0
B33:
	mov	(sp)+, r1
	bis	r1, r0
	tst	r0
	bne	1f
	jmp	B34
1:
	mov	-4.(r5), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	bge	B35
	mov	$1, r0
	jmp	B36
B35:
	clr	r0
B36:
	tst	r0
	bne	1f
	jmp	B37
1:
	mov	-4.(r5), r0
	neg	r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	blt	B38
	mov	$1, r0
	jmp	B39
B38:
	clr	r0
B39:
	tst	r0
	bne	1f
	jmp	B40
1:
	mov	_putchar, r0
	mov	r0, -(sp)
	mov	$45., r0
	mov	r0, -(sp)
	mov	2.(sp), r0
	jsr	pc, (r0)
	add	$4., sp
	mov	r5, r0
	sub	$4., r0
	asr	r0
	mov	r0, -(sp)
	mov	-4.(r5), r0
	neg	r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B40:
B37:
	mov	-6.(r5), r0
	mov	r0, -(sp)
	mov	$100., r0
	cmp	(sp)+, r0
	bne	B41
	mov	$1, r0
	jmp	B42
B41:
	clr	r0
B42:
	tst	r0
	bne	1f
	jmp	B43
1:
	mov	_printn, r0
	mov	r0, -(sp)
	mov	-4.(r5), r0
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
	jmp	B44
B43:
	mov	_printn, r0
	mov	r0, -(sp)
	mov	-4.(r5), r0
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
B44:
	mov	$B30003v, r0
	clc
	ror	r0
	asl	r0
	mov	(r0), r0
	jmp	(r0)
B34:
	mov	-6.(r5), r0
	mov	r0, -(sp)
	mov	$99., r0
	cmp	(sp)+, r0
	bne	B45
	mov	$1, r0
	jmp	B46
B45:
	clr	r0
B46:
	tst	r0
	bne	1f
	jmp	B47
1:
	mov	_putchar, r0
	mov	r0, -(sp)
	mov	-4.(r5), r0
	mov	r0, -(sp)
	mov	2.(sp), r0
	jsr	pc, (r0)
	add	$4., sp
	mov	$B30003v, r0
	clc
	ror	r0
	asl	r0
	mov	(r0), r0
	jmp	(r0)
B47:
	mov	-6.(r5), r0
	mov	r0, -(sp)
	mov	$115., r0
	cmp	(sp)+, r0
	bne	B48
	mov	$1, r0
	jmp	B49
B48:
	clr	r0
B49:
	tst	r0
	bne	1f
	jmp	B50
1:
	mov	r5, r0
	sub	$10., r0
	asr	r0
	mov	r0, -(sp)
	mov	$0., r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B51:
	mov	r5, r0
	sub	$6., r0
	asr	r0
	mov	r0, -(sp)
	mov	_char, r0
	mov	r0, -(sp)
	mov	-4.(r5), r0
	mov	r0, -(sp)
	mov	-10.(r5), r0
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
	beq	B53
	mov	$1, r0
	jmp	B54
B53:
	clr	r0
B54:
	tst	r0
	bne	1f
	jmp	B52
1:
	mov	_putchar, r0
	mov	r0, -(sp)
	mov	-6.(r5), r0
	mov	r0, -(sp)
	mov	2.(sp), r0
	jsr	pc, (r0)
	add	$4., sp
	mov	r5, r0
	sub	$10., r0
	asr	r0
	mov	r0, -(sp)
	mov	-10.(r5), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	jmp	B51
B52:
	mov	$B30003v, r0
	clc
	ror	r0
	asl	r0
	mov	(r0), r0
	jmp	(r0)
B50:
	mov	_putchar, r0
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
	mov	-8.(r5), r0
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
	mov	-2.(r5), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	$B30003v, r0
	clc
	ror	r0
	asl	r0
	mov	(r0), r0
	jmp	(r0)
B30002:
	mov	r5, sp
	mov	(sp)+, r5
	rts	pc
B30002f = 10.
B30003v:	B30003

.text
	.globl	___ctge
___ctge:
	.+2
	mov	r5, -(sp)
	mov	sp, r5
	sub	$B30004f, sp
	mov	4.(r5), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	bge	B55
	mov	$1, r0
	jmp	B56
B55:
	clr	r0
B56:
	tst	r0
	bne	1f
	jmp	B57
1:
	mov	6.(r5), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	blt	B58
	mov	$1, r0
	jmp	B59
B58:
	clr	r0
B59:
	tst	r0
	bne	1f
	jmp	B60
1:
	mov	$1., r0
	jmp	B30004
B60:
	jmp	B61
B57:
	mov	6.(r5), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	bge	B62
	mov	$1, r0
	jmp	B63
B62:
	clr	r0
B63:
	tst	r0
	bne	1f
	jmp	B64
1:
	mov	$0., r0
	jmp	B30004
B64:
B61:
	mov	4.(r5), r0
	mov	r0, -(sp)
	mov	6.(r5), r0
	cmp	(sp)+, r0
	blt	B65
	mov	$1, r0
	jmp	B66
B65:
	clr	r0
B66:
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
	mov	_lchar, r0
	mov	r0, -(sp)
	mov	4.(r5), r0
	mov	r0, -(sp)
	mov	6.(r5), r0
	mov	r0, -(sp)
	mov	$48., r0
	mov	r0, -(sp)
	mov	8.(r5), r0
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
	mov	_lchar, r0
	mov	r0, -(sp)
	mov	4.(r5), r0
	mov	r0, -(sp)
	mov	6.(r5), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	r0, -(sp)
	mov	$48., r0
	mov	r0, -(sp)
	mov	8.(r5), r0
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
	mov	4.(r5), r0
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
	mov	4.(r5), r0
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
B67:
	mov	-2.(r5), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	bge	B69
	mov	$1, r0
	jmp	B70
B69:
	clr	r0
B70:
	mov	r0, -(sp)
	mov	-2.(r5), r0
	mov	r0, -(sp)
	mov	$79., r0
	cmp	(sp)+, r0
	ble	B71
	mov	$1, r0
	jmp	B72
B71:
	clr	r0
B72:
	mov	(sp)+, r1
	bis	r1, r0
	mov	r0, -(sp)
	mov	-2.(r5), r0
	mov	r0, -(sp)
	mov	$79., r0
	cmp	(sp)+, r0
	bne	B73
	mov	$1, r0
	jmp	B74
B73:
	clr	r0
B74:
	mov	r0, -(sp)
	mov	___ctge, r0
	mov	r0, -(sp)
	mov	-4.(r5), r0
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
	jmp	B68
1:
	mov	___ctge, r0
	mov	r0, -(sp)
	mov	-4.(r5), r0
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
	bne	B75
	mov	$1, r0
	jmp	B76
B75:
	clr	r0
B76:
	tst	r0
	bne	1f
	jmp	B77
1:
	mov	r5, r0
	sub	$2., r0
	asr	r0
	mov	r0, -(sp)
	mov	-2.(r5), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B77:
	mov	r5, r0
	sub	$4., r0
	asr	r0
	mov	r0, -(sp)
	mov	-4.(r5), r0
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
	mov	-2.(r5), r0
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
	mov	-6.(r5), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	jmp	B67
B68:
	mov	r5, r0
	sub	$8., r0
	asr	r0
	mov	r0, -(sp)
	mov	$0., r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B78:
	mov	-2.(r5), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	beq	B80
	mov	$1, r0
	jmp	B81
B80:
	clr	r0
B81:
	mov	r0, -(sp)
	mov	___ctge, r0
	mov	r0, -(sp)
	mov	-4.(r5), r0
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
	jmp	B79
1:
	mov	___ctge, r0
	mov	r0, -(sp)
	mov	-4.(r5), r0
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
	bne	B82
	mov	$1, r0
	jmp	B83
B82:
	clr	r0
B83:
	tst	r0
	bne	1f
	jmp	B84
1:
	mov	r5, r0
	sub	$2., r0
	asr	r0
	mov	r0, -(sp)
	mov	-2.(r5), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B84:
	mov	r5, r0
	sub	$4., r0
	asr	r0
	mov	r0, -(sp)
	mov	-4.(r5), r0
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
	mov	-8.(r5), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	jmp	B78
B79:
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
B85:
	mov	-6.(r5), r0
	mov	r0, -(sp)
	mov	-14.(r5), r0
	cmp	(sp)+, r0
	blt	B87
	mov	$1, r0
	jmp	B88
B87:
	clr	r0
B88:
	tst	r0
	bne	1f
	jmp	B86
1:
	mov	r5, r0
	sub	$6., r0
	asr	r0
	mov	r0, -(sp)
	mov	-6.(r5), r0
	mov	r0, -(sp)
	mov	-14.(r5), r0
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
	mov	-10.(r5), r0
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
	mov	-10.(r5), r0
	mov	r0, -(sp)
	mov	$4., r0
	mov	r0, -(sp)
	jsr	pc, .mod
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	bne	B89
	mov	$1, r0
	jmp	B90
B89:
	clr	r0
B90:
	tst	r0
	bne	1f
	jmp	B91
1:
	mov	r5, r0
	sub	$14., r0
	asr	r0
	mov	r0, -(sp)
	mov	$366., r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B91:
	jmp	B85
B86:
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
	mov	J1, r0
	mov	r0, -(sp)
	mov	-12.(r5), r0
	mov	(sp)+, r1
	add	r1, r0
	asl	r0
	mov	(r0), r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B92:
	mov	-6.(r5), r0
	mov	r0, -(sp)
	mov	-14.(r5), r0
	cmp	(sp)+, r0
	blt	B94
	mov	$1, r0
	jmp	B95
B94:
	clr	r0
B95:
	tst	r0
	bne	1f
	jmp	B93
1:
	mov	r5, r0
	sub	$6., r0
	asr	r0
	mov	r0, -(sp)
	mov	-6.(r5), r0
	mov	r0, -(sp)
	mov	-14.(r5), r0
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
	mov	-12.(r5), r0
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
	mov	J1, r0
	mov	r0, -(sp)
	mov	-12.(r5), r0
	mov	(sp)+, r1
	add	r1, r0
	asl	r0
	mov	(r0), r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	mov	-12.(r5), r0
	mov	r0, -(sp)
	mov	$1., r0
	cmp	(sp)+, r0
	bne	B96
	mov	$1, r0
	jmp	B97
B96:
	clr	r0
B97:
	mov	r0, -(sp)
	mov	-10.(r5), r0
	mov	r0, -(sp)
	mov	$4., r0
	mov	r0, -(sp)
	jsr	pc, .mod
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	bne	B98
	mov	$1, r0
	jmp	B99
B98:
	clr	r0
B99:
	mov	(sp)+, r1
	com	r0
	bic	r0, r1
	mov	r1, r0
	tst	r0
	bne	1f
	jmp	B100
1:
	mov	r5, r0
	sub	$14., r0
	asr	r0
	mov	r0, -(sp)
	mov	-14.(r5), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
B100:
	jmp	B92
B93:
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
B101:
	mov	-18.(r5), r0
	mov	r0, -(sp)
	mov	$3., r0
	cmp	(sp)+, r0
	bge	B103
	mov	$1, r0
	jmp	B104
B103:
	clr	r0
B104:
	tst	r0
	bne	1f
	jmp	B102
1:
	mov	_lchar, r0
	mov	r0, -(sp)
	mov	6.(r5), r0
	mov	r0, -(sp)
	mov	-18.(r5), r0
	mov	r0, -(sp)
	mov	_char, r0
	mov	r0, -(sp)
	mov	-16.(r5), r0
	mov	r0, -(sp)
	mov	-12.(r5), r0
	mov	r0, -(sp)
	mov	$3., r0
	mov	r0, -(sp)
	jsr	pc, .mul
	mov	r0, -(sp)
	mov	-18.(r5), r0
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
	mov	-18.(r5), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	asl	r1
	mov	r0, (r1)
	jmp	B101
B102:
	mov	_lchar, r0
	mov	r0, -(sp)
	mov	6.(r5), r0
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
	mov	J0, r0
	mov	r0, -(sp)
	mov	6.(r5), r0
	mov	r0, -(sp)
	mov	$4., r0
	mov	r0, -(sp)
	mov	-6.(r5), r0
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
	mov	-6.(r5), r0
	mov	r0, -(sp)
	mov	$9., r0
	cmp	(sp)+, r0
	bge	B105
	mov	$1, r0
	jmp	B106
B105:
	clr	r0
B106:
	tst	r0
	bne	1f
	jmp	B107
1:
	mov	_lchar, r0
	mov	r0, -(sp)
	mov	6.(r5), r0
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
B107:
	mov	_lchar, r0
	mov	r0, -(sp)
	mov	6.(r5), r0
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
	mov	J0, r0
	mov	r0, -(sp)
	mov	6.(r5), r0
	mov	r0, -(sp)
	mov	$7., r0
	mov	r0, -(sp)
	mov	-8.(r5), r0
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
	mov	_lchar, r0
	mov	r0, -(sp)
	mov	6.(r5), r0
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
	mov	J0, r0
	mov	r0, -(sp)
	mov	6.(r5), r0
	mov	r0, -(sp)
	mov	$10., r0
	mov	r0, -(sp)
	mov	-8.(r5), r0
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
	mov	_lchar, r0
	mov	r0, -(sp)
	mov	6.(r5), r0
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
	mov	J0, r0
	mov	r0, -(sp)
	mov	6.(r5), r0
	mov	r0, -(sp)
	mov	$13., r0
	mov	r0, -(sp)
	mov	-4.(r5), r0
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
	mov	_lchar, r0
	mov	r0, -(sp)
	mov	6.(r5), r0
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
