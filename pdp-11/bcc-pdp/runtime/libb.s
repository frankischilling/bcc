
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
