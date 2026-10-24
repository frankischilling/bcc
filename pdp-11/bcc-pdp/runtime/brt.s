/ brt.s — runtime helpers for bcc-pdp.
/
/ Calls place the leftmost argument nearest the return address.
/ Helper called via `jsr pc, _name`; args at 2(sp), 4(sp), ...
/ Result returned in r0. Helpers preserve no callee-save regs.

/ Syscall numbers (V1 manual section II)
sexit   = 1.
sfork   = 2.
read    = 3.
swrite  = 4.
sopen   = 5.
sclose  = 6.
swait   = 7.
screat  = 8.
slink   = 9.
sunlink = 10.
sexec   = 11.
schdir  = 12.
stime   = 13.
smkdir  = 14.
schmod  = 15.
schown  = 16.
sbreak  = 17.
sstat   = 18.
sseek   = 19.
stty    = 31.
sgtty   = 32.
ssetuid = 23.
sgetuid = 24.
sstime  = 25.
sfstat  = 28.

.globl	_putchar
.globl	_getchar
.globl	_write
.globl	_read
.globl	_open
.globl	_close
.globl	_creat
.globl	_seek
.globl	_exit
.globl	_putstr
.globl	_char
.globl	_lchar
.globl	_fork
.globl	_wait
.globl	_unlink
.globl	_link
.globl	_chdir
.globl	_chmod
.globl	_chown
.globl	_stat
.globl	_fstat
.globl	_setuid
.globl	_getuid
.globl	_time
.globl	_stty
.globl	_gtty
.globl	_execl
.globl	_execv
.globl	_mkdir
.globl	_makdir
.globl	_ctime

/ B word marker for end-of-string ('*e' in B source, 04 octal)
EOT = 4

/ ---- _exit(code) ----
_exit:
	mov	2(sp), r0
	sys	sexit

/ ---- _putchar(c) ----
_putchar:
	mov	2(sp), pcbuf
	mov	$1, r0			/ fd = stdout
	tstb	pcbuf+1
	beq	1f
	swab	pcbuf			/ packed pair: high byte first
	sys	swrite; pcbuf; 2.
	rts	pc
1:
	sys	swrite; pcbuf; 1.
	rts	pc
pcbuf:	0

/ ---- _getchar() -> int (char, or *e on EOF) ----
_getchar:
	clr	r0			/ fd = stdin
	sys	read; gcbuf; 1.
	bes	1f
	tst	r0
	beq	2f			/ EOF
	movb	gcbuf, r0
	bic	$177400, r0
	rts	pc
1:
2:
	mov	$EOT, r0
	rts	pc
gcbuf:	0

/ ---- _write(fd, buf, n) ----
_write:
	mov	2(sp), r0
	mov	4(sp), 0f
	mov	6(sp), 0f+2
	sys	write; 0:..; ..
	bes	1f
	rts	pc
1:
	mov	$-1, r0
	rts	pc

/ ---- _read(fd, buf, n) ----
_read:
	mov	2(sp), r0
	mov	4(sp), 0f
	mov	6(sp), 0f+2
	sys	read; 0:..; ..
	bes	1f
	rts	pc
1:
	mov	$-1, r0
	rts	pc

/ ---- _open(path, mode): convert the B terminator before the syscall. ----
_open:
	mov	2(sp), r0
	jsr	pc, .path1
	bes	9f
	mov	4(sp), 0f+2
	sys	sopen; 0:.bp1; ..
	bes	9f
	rts	pc
9:
	mov	$-1, r0
	rts	pc

/ ---- _close(fd) ----
_close:
	mov	2(sp), r0
	sys	sclose
	bes	1f
	rts	pc
1:
	mov	$-1, r0
	rts	pc

/ ---- _creat(path, mode): convert the B terminator before the syscall. ----
_creat:
	mov	2(sp), r0
	jsr	pc, .path1
	bes	9f
	mov	4(sp), 0f+2
	sys	screat; 0:.bp1; ..
	bes	9f
	rts	pc
9:
	mov	$-1, r0
	rts	pc

/ ---- _seek(fd, offset, origin) ----
_seek:
	mov	2(sp), r0
	mov	4(sp), 0f
	mov	6(sp), 0f+2
	sys	sseek; 0:..; ..
	bes	9f
	clr	r0
	rts	pc
9:
	mov	$-1, r0
	rts	pc

/ ---- _putstr(s) — print chars until EOT (04) ----
_putstr:
	mov	2(sp), r1
1:
	movb	(r1)+, r0
	cmpb	r0, $EOT
	beq	2f
	bic	$177400, r0
	mov	r0, -(sp)
	jsr	pc, _putchar
	tst	(sp)+
	br	1b
2:
	rts	pc


/ ---- .mul: TOS = LHS, R0 = RHS (caller pushed both). Helper pops both. ----
.globl	.mul
.mul:
	mov	(sp)+, r2		/ r2 = return PC
	mov	(sp)+, r0		/ r0 = RHS
	mov	(sp)+, r1		/ r1 = LHS
	clr	r3
	mov	$16., r4
1:
	asr	r0
	bcc	2f
	add	r1, r3
2:
	asl	r1
	dec	r4
	bne	1b
	mov	r3, r0
	jmp	(r2)

/ Signed division truncates toward zero; the loop divides unsigned magnitudes.
/ Save R5 because it is the caller's frame pointer.
.globl .div
.div:
	mov (sp)+, r2
	mov (sp)+, r0
	mov (sp)+, r1
	mov r5, -(sp)
	clr r5
	tst r1
	bge 1f
	neg r1
	inc r5
1:
	tst r0
	bge 2f
	neg r0
	inc r5
2:
	clr r3
	mov $16., r4
3:
	asl r1
	rol r3
	cmp r3, r0
	blo 4f
	sub r0, r3
	inc r1
4:
	dec r4
	bne 3b
	bit $1, r5
	beq 5f
	neg r1
5:
	mov r1, r0
	mov (sp)+, r5
	jmp (r2)

/ Remainders follow the dividend's sign for the chosen truncation rule.
.globl .mod
.mod:
	mov (sp)+, r2
	mov (sp)+, r0
	mov (sp)+, r1
	mov r5, -(sp)
	clr r5
	tst r1
	bge 1f
	neg r1
	inc r5
1:
	tst r0
	bge 2f
	neg r0
2:
	clr r3
	mov $16., r4
3:
	asl r1
	rol r3
	cmp r3, r0
	blo 4f
	sub r0, r3
	inc r1
4:
	dec r4
	bne 3b
	tst r5
	beq 5f
	neg r3
5:
	mov r3, r0
	mov (sp)+, r5
	jmp (r2)

/ ---- .shl: LHS << RHS, result in R0. ----
.globl	.shl
.shl:
	mov	(sp)+, r2
	mov	(sp)+, r0		/ r0 = shift count
	mov	(sp)+, r1		/ r1 = value
	tst	r0
	beq	2f
1:
	asl	r1
	dec	r0
	bne	1b
2:
	mov	r1, r0
	jmp	(r2)

/ ---- .shr: LHS >> RHS, result in R0. Logical shift (unsigned). ----
.globl	.shr
.shr:
	mov	(sp)+, r2
	mov	(sp)+, r0
	mov	(sp)+, r1
	tst	r0
	beq	2f
1:
	clc
	ror	r1
	dec	r0
	bne	1b
2:
	mov	r1, r0
	jmp	(r2)

/ ---- .xor: LHS ^ RHS, result in R0. PDP-11 has no xor; use bic+bis.
/ Kept for backward compat though strict 1972 lexer no longer emits ^. ----
.globl	.xor
.xor:
	mov	(sp)+, r2
	mov	(sp)+, r0
	mov	(sp)+, r1
	mov	r0, r3
	mov	r1, r4
	bic	r0, r1			/ r1 = LHS & ~RHS
	bic	r4, r3			/ r3 = RHS & ~LHS
	bis	r1, r3			/ r3 = (LHS&~RHS) | (RHS&~LHS) = XOR
	mov	r3, r0
	jmp	(r2)


/ =========== kbman §8 library: char, lchar ===========
/ This compiler is byte-addressed (deviation from kbman §12 word-addressed
/ model — see README).  So a "string" rvalue is a byte address.
/ char(s, i) = the i-th byte; lchar(s, i, c) sets it.

/ ---- _char(s, i) -> int (byte zero-extended) ----
_char:
	mov	2(sp), r0		/ r0 = s (byte addr of string base)
	add	4(sp), r0		/ r0 = &s[i]
	clr	r1
	bisb	(r0), r1		/ r1 = zero-extended byte
	mov	r1, r0
	rts	pc

/ ---- _lchar(s, i, c) ----
_lchar:
	mov	2(sp), r0
	add	4(sp), r0		/ r0 = &s[i]
	mov	6(sp), r1		/ r1 = c
	movb	r1, (r0)
	rts	pc


/ =========== kbman §8 library: V1 syscall wrappers ===========

/ ---- _fork(): the parent skips the instruction after sys fork. ----
_fork:
	sys	sfork
	br	1f
	bcc	2f
	mov	$-1, r0
	rts	pc
1:
	clr	r0
2:
	rts	pc

_wait:
	sys	swait
	bes	9f
	rts	pc
9:
	mov	$-1, r0
	rts	pc

_unlink:
	mov	2(sp), r0
	jsr	pc, .path1
	bes	9f
	sys	sunlink; .bp1
	bes	9f
	clr	r0
	rts	pc
9:
	mov	$-1, r0
	rts	pc

_chdir:
	mov	2(sp), r0
	jsr	pc, .path1
	bes	9f
	sys	schdir; .bp1
	bes	9f
	clr	r0
	rts	pc
9:
	mov	$-1, r0
	rts	pc

_link:
	mov	2(sp), r0
	jsr	pc, .path1
	bes	9f
	mov	4(sp), r0
	jsr	pc, .path2
	bes	9f
	sys	slink; .bp1; .bp2
	bes	9f
	clr	r0
	rts	pc
9:
	mov	$-1, r0
	rts	pc

_chmod:
	mov	2(sp), r0
	jsr	pc, .path1
	bes	9f
	mov	4(sp), 0f+2
	sys	schmod; 0:.bp1; ..
	bes	9f
	clr	r0
	rts	pc
9:
	mov	$-1, r0
	rts	pc

_chown:
	mov	2(sp), r0
	jsr	pc, .path1
	bes	9f
	mov	4(sp), 0f+2
	sys	schown; 0:.bp1; ..
	bes	9f
	clr	r0
	rts	pc
9:
	mov	$-1, r0
	rts	pc

_stat:
	mov	2(sp), r0
	jsr	pc, .path1
	bes	9f
	mov	4(sp), 0f+2
	sys	sstat; 0:.bp1; ..
	bes	9f
	clr	r0
	rts	pc
9:
	mov	$-1, r0
	rts	pc

_makdir:
_mkdir:
	mov	2(sp), r0
	jsr	pc, .path1
	bes	9f
	mov	4(sp), 0f+2
	sys	smkdir; 0:.bp1; ..
	bes	9f
	clr	r0
	rts	pc
9:
	mov	$-1, r0
	rts	pc

_fstat:
	mov	2(sp), r0
	mov	4(sp), 0f
	sys	sfstat; 0:..
	bes	9f
	clr	r0
	rts	pc
9:
	mov	$-1, r0
	rts	pc

_stty:
	mov	2(sp), r0
	mov	4(sp), 0f
	sys	stty; 0:..
	bes	9f
	clr	r0
	rts	pc
9:
	mov	$-1, r0
	rts	pc

_gtty:
	mov	2(sp), r0
	mov	4(sp), 0f
	sys	sgtty; 0:..
	bes	9f
	clr	r0
	rts	pc
9:
	mov	$-1, r0
	rts	pc

_setuid:
	mov	2(sp), r0
	sys	ssetuid
	bes	9f
	clr	r0
	rts	pc
9:
	mov	$-1, r0
	rts	pc

_getuid:
	sys	sgetuid
	rts	pc

/ V1 time returns the high and low words in the KE11 AC and MQ registers.
_time:
	sys	stime
	mov	2(sp), r2
	mov	ac, (r2)+
	mov	mq, (r2)
	clr	r0
	rts	pc

/ B72 execv takes a counted vector, not a zero-terminated B vector.
_execv:
	mov	2(sp), r0
	jsr	pc, .path1
	bes	9f
	mov	6(sp), r3
	blt	9f
	cmp	r3, $64.
	bhi	9f
	mov	r3, .ecnt
	mov	4(sp), r4
	mov	$.earg, .evp
	mov	$.estr, r1
	mov	$512., r2
1:
	tst	.ecnt
	beq	2f
	tst	r4
	beq	9f
	mov	(r4)+, r0
	mov	.evp, r3
	mov	r1, (r3)+
	mov	r3, .evp
	jsr	pc, .strz
	bes	9f
	dec	.ecnt
	br	1b
2:
	mov	.evp, r3
	clr	(r3)
	sys	sexec; .bp1; .earg
9:
	mov	$-1, r0
	rts	pc

/ The variadic arguments already form a contiguous vector on the stack.
_execl:
	mov	sp, r1
	add	$4, r1
	clr	r2
1:
	tst	(r1)+
	beq	2f
	inc	r2
	cmp	r2, $64.
	bhi	9f
	br	1b
2:
	mov	2(sp), r3
	mov	sp, r0
	add	$4, r0
	mov	r2, -(sp)
	mov	r0, -(sp)
	mov	r3, -(sp)
	jsr	pc, _execv
	add	$6, sp
	rts	pc
9:
	mov	$-1, r0
	rts	pc

/ Convert a B byte string to NUL-terminated syscall storage.
/ R0 source, R1 destination, R2 remaining bytes; R4 and R5 are preserved.
.path1:
	mov	$.bp1, r1
	mov	$256., r2
	br	.strz
.path2:
	mov	$.bp2, r1
	mov	$256., r2
.strz:
	tst	r0
	beq	9f
1:
	tst	r2
	beq	9f
	movb	(r0)+, r3
	beq	2f
	cmpb	r3, $4
	beq	2f
	movb	r3, (r1)+
	dec	r2
	br	1b
2:
	clrb	(r1)+
	dec	r2
	clc
	rts	pc
9:
	sec
	rts	pc
.even
.ecnt: 0
.evp: 0
.earg: .=.+130.
.estr: .=.+512.
.bp1: .=.+256.
.bp2: .=.+256.

/ _ctime is implemented in runtime/libb.b.
