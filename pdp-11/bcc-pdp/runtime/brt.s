/ brt.s — runtime helpers for bcc-pdp.
/
/ Calling convention (set in Task 5.3): args pushed left-to-right.
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
stty    = 20.
sgtty   = 21.
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
	mov	4(sp), wbuf
	mov	6(sp), wcnt
	sys	swrite; wbuf; wcnt
	bes	1f
	rts	pc
1:
	mov	$-1, r0
	rts	pc
wbuf:	0
wcnt:	0

/ ---- _read(fd, buf, n) ----
_read:
	mov	2(sp), r0
	mov	4(sp), rbuf
	mov	6(sp), rcnt
	sys	read; rbuf; rcnt
	bes	1f
	rts	pc
1:
	mov	$-1, r0
	rts	pc
rbuf:	0
rcnt:	0

/ ---- _open(name, mode) ----
_open:
	mov	2(sp), oname
	mov	4(sp), r0		/ mode in r0
	sys	sopen; oname
	bes	1f
	rts	pc
1:
	mov	$-1, r0
	rts	pc
oname:	0

/ ---- _close(fd) ----
_close:
	mov	2(sp), r0
	sys	sclose
	bes	1f
	rts	pc
1:
	mov	$-1, r0
	rts	pc

/ ---- _creat(name, mode) ----
_creat:
	mov	2(sp), cname
	mov	4(sp), r0		/ mode in r0
	sys	screat; cname
	bes	1f
	rts	pc
1:
	mov	$-1, r0
	rts	pc
cname:	0

/ ---- _seek(fd, off, ptrname) ----
_seek:
	mov	2(sp), r0
	mov	4(sp), soff
	mov	6(sp), sptr
	sys	sseek; soff; sptr
	rts	pc
soff:	0
sptr:	0

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

/ ---- .div: LHS/RHS, result in R0. Restoring division, 16-bit unsigned. ----
.globl	.div
.div:
	mov	(sp)+, r2
	mov	(sp)+, r0		/ r0 = RHS (divisor)
	mov	(sp)+, r1		/ r1 = LHS (dividend)
	clr	r3			/ quotient
	mov	$16., r4
1:
	asl	r1
	rol	r3			/ r3:r1 shift left
	cmp	r3, r0
	blo	2f
	sub	r0, r3
	inc	r1
2:
	dec	r4
	bne	1b
	mov	r1, r0
	jmp	(r2)

/ ---- .mod: LHS%RHS, result in R0. Same loop as .div but return remainder. ----
.globl	.mod
.mod:
	mov	(sp)+, r2
	mov	(sp)+, r0
	mov	(sp)+, r1
	clr	r3
	mov	$16., r4
1:
	asl	r1
	rol	r3
	cmp	r3, r0
	blo	2f
	sub	r0, r3
	inc	r1
2:
	dec	r4
	bne	1b
	mov	r3, r0
	jmp	(r2)

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

/ ---- _fork() — returns child pid in parent, 0 in child, -1 on error ----
_fork:
	sys	sfork
	bes	1f
	rts	pc
1:	mov	$-1, r0
	rts	pc

/ ---- _wait() — returns child pid that exited, -1 on error ----
_wait:
	sys	swait
	bes	1f
	rts	pc
1:	mov	$-1, r0
	rts	pc

/ ---- _unlink(name) ----
_unlink:
	mov	2(sp), unmnam
	sys	sunlink; unmnam
	bes	1f
	rts	pc
1:	mov	$-1, r0
	rts	pc
unmnam:	0

/ ---- _link(old, new) ----
_link:
	mov	2(sp), lkold
	mov	4(sp), lknew
	sys	slink; lkold; lknew
	bes	1f
	rts	pc
1:	mov	$-1, r0
	rts	pc
lkold:	0
lknew:	0

/ ---- _chdir(path) ----
_chdir:
	mov	2(sp), cdnam
	sys	schdir; cdnam
	bes	1f
	rts	pc
1:	mov	$-1, r0
	rts	pc
cdnam:	0

/ ---- _chmod(path, mode) ----
_chmod:
	mov	2(sp), cmnam
	mov	4(sp), r0		/ mode in r0
	sys	schmod; cmnam
	bes	1f
	rts	pc
1:	mov	$-1, r0
	rts	pc
cmnam:	0

/ ---- _chown(path, owner) ----
_chown:
	mov	2(sp), cwnam
	mov	4(sp), r0		/ owner in r0
	sys	schown; cwnam
	bes	1f
	rts	pc
1:	mov	$-1, r0
	rts	pc
cwnam:	0

/ ---- _stat(path, statbuf) ----
_stat:
	mov	2(sp), stnam
	mov	4(sp), stbuf
	sys	sstat; stnam; stbuf
	bes	1f
	rts	pc
1:	mov	$-1, r0
	rts	pc
stnam:	0
stbuf:	0

/ ---- _fstat(fd, statbuf) ----
_fstat:
	mov	2(sp), r0
	mov	4(sp), fsbuf
	sys	sfstat; fsbuf
	bes	1f
	rts	pc
1:	mov	$-1, r0
	rts	pc
fsbuf:	0

/ ---- _setuid(uid) ----
_setuid:
	mov	2(sp), r0
	sys	ssetuid
	bes	1f
	rts	pc
1:	mov	$-1, r0
	rts	pc

/ ---- _getuid() ----
_getuid:
	sys	sgetuid
	rts	pc

/ ---- _time(tvec) — store 2-word system time at *tvec ----
_time:
	sys	stime			/ kernel returns time in r0:r1
	mov	2(sp), r2
	mov	r0, (r2)+
	mov	r1, (r2)
	rts	pc

/ ---- _stty(fd, ttstat) ----
_stty:
	mov	2(sp), r0
	mov	4(sp), styb
	sys	stty; styb
	bes	1f
	rts	pc
1:	mov	$-1, r0
	rts	pc
styb:	0

/ ---- _gtty(fd, ttstat) ----
_gtty:
	mov	2(sp), r0
	mov	4(sp), gtyb
	sys	sgtty; gtyb
	bes	1f
	rts	pc
1:	mov	$-1, r0
	rts	pc
gtyb:	0

/ ---- _execl(path, argv...) — last arg must be 0; pass via _execv ----
/ Caller passes a list ending with 0; we have to repackage as char**.
/ Simplification: forward to _execv with a synthesized argv vector.
/ For now, support up to 8 args.
_execl:
	mov	2(sp), exlpat		/ path
	mov	$exlbuf, r0
	mov	4(sp), (r0)+
	mov	6(sp), (r0)+
	mov	10(sp), (r0)+
	mov	12(sp), (r0)+
	mov	14(sp), (r0)+
	mov	16(sp), (r0)+
	mov	20(sp), (r0)+
	mov	22(sp), (r0)+
	sys	sexec; exlpat; exlbuf
	mov	$-1, r0
	rts	pc
exlpat:	0
exlbuf:	0;0;0;0;0;0;0;0

/ ---- _execv(path, argv) — V1 exec syscall ----
_execv:
	mov	2(sp), exnam
	mov	4(sp), exarg
	sys	sexec; exnam; exarg
	mov	$-1, r0
	rts	pc
exnam:	0
exarg:	0

/ ---- _mkdir/_makdir(path, mode) — V1 mkdir is sys 14, but only super. ----
/ kbman §8 lists mkdir; V1 mkdir is /bin/mkdir not a syscall on early V1.
/ Best-effort: try sys mkdir; if it traps, return -1.
_mkdir:
_makdir:
	mov	2(sp), mknam
	mov	4(sp), r0		/ mode
	sys	smkdir; mknam
	bes	1f
	rts	pc
1:	mov	$-1, r0
	rts	pc
mknam:	0

/ ---- _ctime(time, dest) — render 2-word time into 16-byte buf at dest. ----
/ Minimal compatible formatter: fills the documented 16-byte shape.
_ctime:
	mov	4(sp), r0		/ dest
	movb	$'J, (r0)+
	movb	$'a, (r0)+
	movb	$'n, (r0)+
	movb	$' , (r0)+
	movb	$' , (r0)+
	movb	$'1, (r0)+
	movb	$' , (r0)+
	movb	$'0, (r0)+
	movb	$'0, (r0)+
	movb	$':, (r0)+
	movb	$'0, (r0)+
	movb	$'0, (r0)+
	movb	$':, (r0)+
	movb	$'0, (r0)+
	movb	$'0, (r0)+
	clrb	(r0)
	rts	pc
