
.text
	.globl	_printn
_printn:
	mov	r5, -(sp)
	mov	sp, r5
	sub	$2., sp
	mov	r5, r0
	add	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	bge	B0
	mov	$1, r0
	jmp	B1
B0:
	clr	r0
B1:
	tst	r0
	bne	1f
	jmp	B2
1:
	mov	$45., r0
	mov	r0, -(sp)
	jsr	pc, _putchar
	tst	(sp)+
	mov	r5, r0
	add	$4., r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	mov	(r0), r0
	neg	r0
	mov	(sp)+, r1
	mov	r0, (r1)
B2:
	mov	r5, r0
	sub	$2., r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	jsr	pc, .div
	mov	(sp)+, r1
	mov	r0, (r1)
	tst	r0
	bne	1f
	jmp	B3
1:
	mov	r5, r0
	sub	$2., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	jsr	pc, _printn
	add	$4., sp
B3:
	mov	r5, r0
	sub	$2., r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	jsr	pc, .mod
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$2., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$10., r0
	cmp	(sp)+, r0
	bge	B4
	mov	$1, r0
	jmp	B5
B4:
	clr	r0
B5:
	tst	r0
	bne	1f
	jmp	B6
1:
	mov	r5, r0
	sub	$2., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$48., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	r0, -(sp)
	jsr	pc, _putchar
	tst	(sp)+
	jmp	B7
B6:
	mov	r5, r0
	sub	$2., r0
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
	jsr	pc, _putchar
	tst	(sp)+
B7:
B30000:
	mov	r5, sp
	mov	(sp)+, r5
	rts	pc

.text
	.globl	_getstr
_getstr:
	mov	r5, -(sp)
	mov	sp, r5
	sub	$4., sp
	mov	r5, r0
	sub	$2., r0
	mov	r0, -(sp)
	mov	$0., r0
	mov	(sp)+, r1
	mov	r0, (r1)
B8:
	mov	$1., r0
	tst	r0
	bne	1f
	jmp	B9
1:
	mov	r5, r0
	sub	$4., r0
	mov	r0, -(sp)
	jsr	pc, _getchar
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$4., r0
	cmp	(sp)+, r0
	bne	B10
	mov	$1, r0
	jmp	B11
B10:
	clr	r0
B11:
	tst	r0
	bne	1f
	jmp	B12
1:
	mov	r5, r0
	add	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$4., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	jsr	pc, _lchar
	add	$6., sp
	mov	r5, r0
	sub	$2., r0
	mov	(r0), r0
	jmp	B30001
B12:
	mov	r5, r0
	sub	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$10., r0
	cmp	(sp)+, r0
	bne	B13
	mov	$1, r0
	jmp	B14
B13:
	clr	r0
B14:
	tst	r0
	bne	1f
	jmp	B15
1:
	mov	r5, r0
	add	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$4., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	jsr	pc, _lchar
	add	$6., sp
	mov	r5, r0
	sub	$2., r0
	mov	(r0), r0
	jmp	B30001
B15:
	mov	r5, r0
	add	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	jsr	pc, _lchar
	add	$6., sp
	mov	r5, r0
	sub	$2., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	jmp	B8
B9:
B30001:
	mov	r5, sp
	mov	(sp)+, r5
	rts	pc

.text
	.globl	_printf
_printf:
	mov	r5, -(sp)
	mov	sp, r5
	sub	$10., sp
	mov	r5, r0
	sub	$8., r0
	mov	r0, -(sp)
	mov	$0., r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$2., r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	mov	(sp)+, r1
	mov	r0, (r1)
B30003:
B16:
	mov	r5, r0
	sub	$6., r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$8., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	jsr	pc, _char
	add	$4., sp
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r0, -(sp)
	mov	$37., r0
	cmp	(sp)+, r0
	beq	B18
	mov	$1, r0
	jmp	B19
B18:
	clr	r0
B19:
	tst	r0
	bne	1f
	jmp	B17
1:
	mov	r5, r0
	sub	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$4., r0
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
	mov	$0., r0
	jmp	B30002
B22:
	mov	r5, r0
	sub	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	bne	B23
	mov	$1, r0
	jmp	B24
B23:
	clr	r0
B24:
	tst	r0
	bne	1f
	jmp	B25
1:
	mov	$0., r0
	jmp	B30002
B25:
	mov	r5, r0
	sub	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	jsr	pc, _putchar
	tst	(sp)+
	mov	r5, r0
	sub	$8., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$8., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	jmp	B16
B17:
	mov	r5, r0
	sub	$8., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$8., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$4., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	mov	(r0), r0
	mov	(r0), r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$2., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$2., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$6., r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$8., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	jsr	pc, _char
	add	$4., sp
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$8., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$8., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$100., r0
	cmp	(sp)+, r0
	bne	B26
	mov	$1, r0
	jmp	B27
B26:
	clr	r0
B27:
	tst	r0
	bne	1f
	jmp	B28
1:
	mov	r5, r0
	sub	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$10., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	jsr	pc, _printn
	add	$4., sp
	jmp	B30003
B28:
	mov	r5, r0
	sub	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$111., r0
	cmp	(sp)+, r0
	bne	B29
	mov	$1, r0
	jmp	B30
B29:
	clr	r0
B30:
	tst	r0
	bne	1f
	jmp	B31
1:
	mov	r5, r0
	sub	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$8., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	jsr	pc, _printn
	add	$4., sp
	jmp	B30003
B31:
	mov	r5, r0
	sub	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$99., r0
	cmp	(sp)+, r0
	bne	B32
	mov	$1, r0
	jmp	B33
B32:
	clr	r0
B33:
	tst	r0
	bne	1f
	jmp	B34
1:
	mov	r5, r0
	sub	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	jsr	pc, _putchar
	tst	(sp)+
	jmp	B30003
B34:
	mov	r5, r0
	sub	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$115., r0
	cmp	(sp)+, r0
	bne	B35
	mov	$1, r0
	jmp	B36
B35:
	clr	r0
B36:
	tst	r0
	bne	1f
	jmp	B37
1:
	mov	r5, r0
	sub	$10., r0
	mov	r0, -(sp)
	mov	$0., r0
	mov	(sp)+, r1
	mov	r0, (r1)
B38:
	mov	r5, r0
	sub	$6., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$10., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	jsr	pc, _char
	add	$4., sp
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r0, -(sp)
	mov	$4., r0
	cmp	(sp)+, r0
	beq	B40
	mov	$1, r0
	jmp	B41
B40:
	clr	r0
B41:
	tst	r0
	bne	1f
	jmp	B39
1:
	mov	r5, r0
	sub	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$0., r0
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
	jmp	B30003
B44:
	mov	r5, r0
	sub	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	jsr	pc, _putchar
	tst	(sp)+
	mov	r5, r0
	sub	$10., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$10., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	jmp	B38
B39:
	jmp	B30003
B37:
	mov	$37., r0
	mov	r0, -(sp)
	jsr	pc, _putchar
	tst	(sp)+
	mov	r5, r0
	sub	$8., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$8., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$2., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$2., r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	jmp	B30003
B30002:
	mov	r5, sp
	mov	(sp)+, r5
	rts	pc

.text
	.globl	___ctge
___ctge:
	mov	r5, -(sp)
	mov	sp, r5
	mov	r5, r0
	add	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	bge	B45
	mov	$1, r0
	jmp	B46
B45:
	clr	r0
B46:
	tst	r0
	bne	1f
	jmp	B47
1:
	mov	r5, r0
	add	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	blt	B48
	mov	$1, r0
	jmp	B49
B48:
	clr	r0
B49:
	tst	r0
	bne	1f
	jmp	B50
1:
	mov	$1., r0
	jmp	B30004
B50:
	jmp	B51
B47:
	mov	r5, r0
	add	$6., r0
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
	mov	$0., r0
	jmp	B30004
B54:
B51:
	mov	r5, r0
	add	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	mov	(r0), r0
	cmp	(sp)+, r0
	blt	B55
	mov	$1, r0
	jmp	B56
B55:
	clr	r0
B56:
	jmp	B30004
B30004:
	mov	r5, sp
	mov	(sp)+, r5
	rts	pc

.text
	.globl	___ctdig
___ctdig:
	mov	r5, -(sp)
	mov	sp, r5
	mov	r5, r0
	add	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$48., r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$8., r0
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
	jsr	pc, _lchar
	add	$6., sp
	mov	r5, r0
	add	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$6., r0
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
	jsr	pc, _lchar
	add	$6., sp
B30005:
	mov	r5, sp
	mov	(sp)+, r5
	rts	pc

.text
	.globl	___ctmon
___ctmon:
	.+2
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
	mov	r5, -(sp)
	mov	sp, r5
	sub	$18., sp
	mov	r5, r0
	sub	$2., r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$0., r0
	asl	r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(r0), r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$4., r0
	mov	r0, -(sp)
	mov	r5, r0
	add	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	asl	r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(r0), r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$6., r0
	mov	r0, -(sp)
	mov	$0., r0
	mov	(sp)+, r1
	mov	r0, (r1)
B57:
	mov	r5, r0
	sub	$2., r0
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
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$79., r0
	cmp	(sp)+, r0
	ble	B61
	mov	$1, r0
	jmp	B62
B61:
	clr	r0
B62:
	mov	(sp)+, r1
	bis	r1, r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$79., r0
	cmp	(sp)+, r0
	bne	B63
	mov	$1, r0
	jmp	B64
B63:
	clr	r0
B64:
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$6656., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	jsr	pc, ___ctge
	add	$4., sp
	mov	(sp)+, r1
	com	r0
	bic	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	bis	r1, r0
	tst	r0
	bne	1f
	jmp	B58
1:
	mov	r5, r0
	sub	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$6656., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	jsr	pc, ___ctge
	add	$4., sp
	tst	r0
	bne	B65
	mov	$1, r0
	jmp	B66
B65:
	clr	r0
B66:
	tst	r0
	bne	1f
	jmp	B67
1:
	mov	r5, r0
	sub	$2., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
B67:
	mov	r5, r0
	sub	$4., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$6656., r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$2., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$79., r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$6., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	jmp	B57
B58:
	mov	r5, r0
	sub	$8., r0
	mov	r0, -(sp)
	mov	$0., r0
	mov	(sp)+, r1
	mov	r0, (r1)
B68:
	mov	r5, r0
	sub	$2., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	beq	B70
	mov	$1, r0
	jmp	B71
B70:
	clr	r0
B71:
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$3600., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	jsr	pc, ___ctge
	add	$4., sp
	mov	(sp)+, r1
	bis	r1, r0
	tst	r0
	bne	1f
	jmp	B69
1:
	mov	r5, r0
	sub	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$3600., r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	jsr	pc, ___ctge
	add	$4., sp
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
	mov	r0, -(sp)
	mov	r5, r0
	sub	$2., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
B74:
	mov	r5, r0
	sub	$4., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$3600., r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$8., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$8., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	jmp	B68
B69:
	mov	r5, r0
	sub	$10., r0
	mov	r0, -(sp)
	mov	$1971., r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$14., r0
	mov	r0, -(sp)
	mov	$365., r0
	mov	(sp)+, r1
	mov	r0, (r1)
B75:
	mov	r5, r0
	sub	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$14., r0
	mov	(r0), r0
	cmp	(sp)+, r0
	blt	B77
	mov	$1, r0
	jmp	B78
B77:
	clr	r0
B78:
	tst	r0
	bne	1f
	jmp	B76
1:
	mov	r5, r0
	sub	$6., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$14., r0
	mov	(r0), r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$10., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$10., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$14., r0
	mov	r0, -(sp)
	mov	$365., r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$10., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$4., r0
	mov	r0, -(sp)
	jsr	pc, .mod
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
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
	sub	$14., r0
	mov	r0, -(sp)
	mov	$366., r0
	mov	(sp)+, r1
	mov	r0, (r1)
B81:
	jmp	B75
B76:
	mov	r5, r0
	sub	$12., r0
	mov	r0, -(sp)
	mov	$0., r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$14., r0
	mov	r0, -(sp)
	mov	$___ctmon, r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$12., r0
	mov	(r0), r0
	asl	r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(r0), r0
	mov	(sp)+, r1
	mov	r0, (r1)
B82:
	mov	r5, r0
	sub	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$14., r0
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
	mov	r0, -(sp)
	mov	r5, r0
	sub	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$14., r0
	mov	(r0), r0
	mov	(sp)+, r1
	sub	r0, r1
	mov	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$12., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$12., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$14., r0
	mov	r0, -(sp)
	mov	$___ctmon, r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$12., r0
	mov	(r0), r0
	asl	r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(r0), r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$12., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	cmp	(sp)+, r0
	bne	B86
	mov	$1, r0
	jmp	B87
B86:
	clr	r0
B87:
	mov	r0, -(sp)
	mov	r5, r0
	sub	$10., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$4., r0
	mov	r0, -(sp)
	jsr	pc, .mod
	mov	r0, -(sp)
	mov	$0., r0
	cmp	(sp)+, r0
	bne	B88
	mov	$1, r0
	jmp	B89
B88:
	clr	r0
B89:
	mov	(sp)+, r1
	com	r0
	bic	r0, r1
	mov	r1, r0
	tst	r0
	bne	1f
	jmp	B90
1:
	mov	r5, r0
	sub	$14., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$14., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
B90:
	jmp	B82
B83:
	mov	r5, r0
	sub	$16., r0
	mov	r0, -(sp)

.text
	br	LC0
C0:
	.byte	74.,97.,110.,70.,101.,98.,77.,97.,114.,65.,112.,114.,77.,97.,121.,74.,117.,110.,74.,117.,108.,65.,117.,103.,83.,101.,112.,79.,99.,116.,78.,111.,118.,68.,101.,99.,4.
	.even
LC0:
	mov	$C0, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	mov	r5, r0
	sub	$18., r0
	mov	r0, -(sp)
	mov	$0., r0
	mov	(sp)+, r1
	mov	r0, (r1)
B91:
	mov	r5, r0
	sub	$18., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$3., r0
	cmp	(sp)+, r0
	bge	B93
	mov	$1, r0
	jmp	B94
B93:
	clr	r0
B94:
	tst	r0
	bne	1f
	jmp	B92
1:
	mov	r5, r0
	add	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$18., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$16., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$12., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$3., r0
	mov	r0, -(sp)
	jsr	pc, .mul
	mov	r0, -(sp)
	mov	r5, r0
	sub	$18., r0
	mov	(r0), r0
	mov	(sp)+, r1
	add	r1, r0
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	2.(sp), r1
	mov	r0, 2.(sp)
	mov	r1, 0.(sp)
	jsr	pc, _char
	add	$4., sp
	mov	r0, -(sp)
	mov	0.(sp), r0
	mov	4.(sp), r1
	mov	r0, 4.(sp)
	mov	r1, 0.(sp)
	jsr	pc, _lchar
	add	$6., sp
	mov	r5, r0
	sub	$18., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$18., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$1., r0
	mov	(sp)+, r1
	add	r1, r0
	mov	(sp)+, r1
	mov	r0, (r1)
	jmp	B91
B92:
	mov	r5, r0
	add	$6., r0
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
	jsr	pc, _lchar
	add	$6., sp
	mov	r5, r0
	add	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$4., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$6., r0
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
	jsr	pc, ___ctdig
	add	$6., sp
	mov	r5, r0
	sub	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$9., r0
	cmp	(sp)+, r0
	bge	B95
	mov	$1, r0
	jmp	B96
B95:
	clr	r0
B96:
	tst	r0
	bne	1f
	jmp	B97
1:
	mov	r5, r0
	add	$6., r0
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
	jsr	pc, _lchar
	add	$6., sp
B97:
	mov	r5, r0
	add	$6., r0
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
	jsr	pc, _lchar
	add	$6., sp
	mov	r5, r0
	add	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$7., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$8., r0
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
	jsr	pc, ___ctdig
	add	$6., sp
	mov	r5, r0
	add	$6., r0
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
	jsr	pc, _lchar
	add	$6., sp
	mov	r5, r0
	add	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$10., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$8., r0
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
	jsr	pc, ___ctdig
	add	$6., sp
	mov	r5, r0
	add	$6., r0
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
	jsr	pc, _lchar
	add	$6., sp
	mov	r5, r0
	add	$6., r0
	mov	(r0), r0
	mov	r0, -(sp)
	mov	$13., r0
	mov	r0, -(sp)
	mov	r5, r0
	sub	$4., r0
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
	jsr	pc, ___ctdig
	add	$6., sp
	mov	r5, r0
	add	$6., r0
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
	jsr	pc, _lchar
	add	$6., sp
	mov	$0., r0
	jmp	B30006
B30006:
	mov	r5, sp
	mov	(sp)+, r5
	rts	pc
