	.file	"parser.c"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"syntax nesting limit exceeded at %d:%d"
	.text
	.p2align 4
	.type	enter_parse.part.0.isra.0, @function
enter_parse.part.0.isra.0:
.LFB97:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	popq	%rax
	.cfi_def_cfa_offset 8
	xorl	%eax, %eax
	movl	%esi, %edx
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	%edi, %esi
	leaq	.LC0(%rip), %rdi
	call	dief@PLT
	.cfi_endproc
.LFE97:
	.size	enter_parse.part.0.isra.0, .-enter_parse.part.0.isra.0
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"internal: null const expr"
	.section	.rodata.str1.8
	.align 8
.LC2:
	.string	"non-constant unary op in const expr at %d:%d"
	.align 8
.LC3:
	.string	"division by zero in const expr at %d:%d"
	.align 8
.LC4:
	.string	"mod by zero in const expr at %d:%d"
	.align 8
.LC5:
	.string	"non-constant binary op in const expr at %d:%d"
	.align 8
.LC6:
	.string	"non-constant expression in const expr at %d:%d"
	.text
	.p2align 4
	.type	eval_const_expr, @function
eval_const_expr:
.LFB73:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	testq	%rdi, %rdi
	je	.L103
	movl	(%rdi), %eax
	movq	%rdi, %rbx
	movl	%esi, %r12d
	movl	%edx, %ebp
	cmpl	$7, %eax
	je	.L6
	ja	.L7
	testl	%eax, %eax
	je	.L8
	cmpl	$5, %eax
	jne	.L10
	movq	56(%rdi), %rdi
	call	eval_const_expr
	movl	48(%rbx), %edx
	cmpl	$31, %edx
	je	.L13
	cmpl	$35, %edx
	jne	.L104
	xorl	%ebp, %ebp
	testq	%rax, %rax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	sete	%bpl
	movq	%rbp, %rax
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	.cfi_restore_state
	cmpl	$9, %eax
	jne	.L10
	movq	48(%rdi), %rdi
	movl	%ebp, %r13d
	andl	$1, %r13d
	call	eval_const_expr
	xorl	%edx, %edx
	movq	56(%rbx), %rdi
	movl	%r12d, %esi
	testq	%rax, %rax
	movq	%rax, %r14
	setne	%dl
	andl	%ebp, %edx
	call	eval_const_expr
	xorl	%edx, %edx
	testq	%r14, %r14
	movq	64(%rbx), %rdi
	sete	%dl
	movl	%r12d, %esi
	movq	%rax, %rbp
	andl	%r13d, %edx
	call	eval_const_expr
	testq	%r14, %r14
	cmove	%rax, %rbp
.L4:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbp, %rax
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L6:
	.cfi_restore_state
	movq	56(%rdi), %rdi
	call	eval_const_expr
	xorl	%edx, %edx
	movq	%rax, %r13
	testl	%ebp, %ebp
	je	.L17
	cmpl	$55, 48(%rbx)
	setne	%dl
	testq	%rax, %rax
	sete	%al
	orl	%eax, %edx
	movzbl	%dl, %edx
.L17:
	movq	64(%rbx), %rdi
	movl	%r12d, %esi
	call	eval_const_expr
	movl	48(%rbx), %esi
	movq	%rax, %rcx
	leal	-22(%rsi), %eax
	cmpl	$33, %eax
	ja	.L18
	leaq	.L20(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L20:
	.long	.L34-.L20
	.long	.L33-.L20
	.long	.L32-.L20
	.long	.L31-.L20
	.long	.L30-.L20
	.long	.L29-.L20
	.long	.L28-.L20
	.long	.L28-.L20
	.long	.L27-.L20
	.long	.L26-.L20
	.long	.L25-.L20
	.long	.L24-.L20
	.long	.L23-.L20
	.long	.L18-.L20
	.long	.L18-.L20
	.long	.L18-.L20
	.long	.L18-.L20
	.long	.L18-.L20
	.long	.L18-.L20
	.long	.L18-.L20
	.long	.L18-.L20
	.long	.L18-.L20
	.long	.L18-.L20
	.long	.L18-.L20
	.long	.L18-.L20
	.long	.L18-.L20
	.long	.L18-.L20
	.long	.L18-.L20
	.long	.L18-.L20
	.long	.L18-.L20
	.long	.L18-.L20
	.long	.L22-.L20
	.long	.L21-.L20
	.long	.L19-.L20
	.text
	.p2align 4,,10
	.p2align 3
.L8:
	movq	48(%rdi), %rbp
	cmpl	$63, %esi
	jg	.L4
.L97:
	movq	$-1, %rax
	movl	%r12d, %ecx
	salq	%cl, %rax
	notq	%rax
	andq	%rax, %rbp
	leal	-1(%r12), %eax
	btq	%rax, %rbp
	jnc	.L4
	movl	$1, %eax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	salq	%cl, %rax
	subq	%rax, %rbp
	movq	%rbp, %rax
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L13:
	.cfi_restore_state
	negq	%rax
	movq	%rax, %rbp
	cmpl	$63, %r12d
	jg	.L4
	jmp	.L97
.L18:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	leaq	.LC5(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4,,10
	.p2align 3
.L28:
	movslq	%r12d, %rax
	xorl	%ebp, %ebp
	cmpq	%rcx, %rax
	je	.L4
	leal	-1(%r12), %edx
	movl	%ecx, %eax
	andl	%edx, %eax
	cmpl	$63, %r12d
	jle	.L42
	movl	%eax, %ecx
	movq	%r13, %rdx
	movq	%r13, %rdi
	salq	%cl, %rdx
	shrq	%cl, %rdi
	cmpl	$28, %esi
	cmovne	%rdi, %rdx
	movq	%rdx, %rbp
	jmp	.L4
.L27:
	leaq	0(%r13,%rcx), %rbp
	cmpl	$63, %r12d
	jg	.L4
	jmp	.L97
.L19:
	xorl	%ebp, %ebp
	orq	%r13, %rcx
	setne	%bpl
	jmp	.L4
.L25:
	movq	%r13, %rbp
	imulq	%rcx, %rbp
	cmpl	$63, %r12d
	jg	.L4
	jmp	.L97
.L26:
	movq	%r13, %rbp
	subq	%rcx, %rbp
	cmpl	$63, %r12d
	jg	.L4
	jmp	.L97
.L21:
	movq	%r13, %rbp
	orq	%rcx, %rbp
	jmp	.L4
.L22:
	movq	%r13, %rbp
	andq	%rcx, %rbp
	jmp	.L4
.L23:
	testl	%ebp, %ebp
	je	.L50
	testq	%rcx, %rcx
	je	.L105
	movabsq	$-9223372036854775808, %rax
	cmpq	%rax, %r13
	jne	.L54
	xorl	%ebp, %ebp
	cmpq	$-1, %rcx
	je	.L4
.L54:
	movq	%r13, %rax
	cqto
	idivq	%rcx
	movq	%rdx, %rbp
	cmpl	$63, %r12d
	jg	.L4
	jmp	.L97
.L24:
	testl	%ebp, %ebp
	je	.L50
	testq	%rcx, %rcx
	je	.L106
	movabsq	$-9223372036854775808, %rdi
	cmpq	%rdi, %r13
	jne	.L53
	movq	%rdi, %rbp
	cmpq	$-1, %rcx
	je	.L4
.L53:
	movq	%r13, %rax
	cqto
	idivq	%rcx
	movq	%rax, %rbp
	cmpl	$63, %r12d
	jg	.L4
	jmp	.L97
.L29:
	xorl	%ebp, %ebp
	cmpq	%rcx, %r13
	setge	%bpl
	jmp	.L4
.L30:
	xorl	%ebp, %ebp
	cmpq	%rcx, %r13
	setg	%bpl
	jmp	.L4
.L31:
	xorl	%ebp, %ebp
	cmpq	%rcx, %r13
	setle	%bpl
	jmp	.L4
.L32:
	xorl	%ebp, %ebp
	cmpq	%rcx, %r13
	setl	%bpl
	jmp	.L4
.L33:
	xorl	%ebp, %ebp
	cmpq	%rcx, %r13
	setne	%bpl
	jmp	.L4
.L34:
	xorl	%ebp, %ebp
	cmpq	%rcx, %r13
	sete	%bpl
	jmp	.L4
	.p2align 4,,10
	.p2align 3
.L50:
	xorl	%ebp, %ebp
	jmp	.L4
.L42:
	movl	%r12d, %ecx
	movq	$-1, %rdi
	salq	%cl, %rdi
	movl	%eax, %ecx
	notq	%rdi
	andq	%rdi, %r13
	movq	%r13, %r8
	shrq	%cl, %r13
	salq	%cl, %r8
	cmpl	$28, %esi
	movq	%r8, %rax
	cmovne	%r13, %rax
	andq	%rax, %rdi
	btq	%rdx, %rdi
	movq	%rdi, %rbp
	jnc	.L4
	movl	$1, %eax
	movl	%r12d, %ecx
	salq	%cl, %rax
	subq	%rax, %rbp
	jmp	.L4
.L10:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L103:
	leaq	.LC1(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L104:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	leaq	.LC2(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L106:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	leaq	.LC3(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L105:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	leaq	.LC4(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.cfi_endproc
.LFE73:
	.size	eval_const_expr, .-eval_const_expr
	.p2align 4
	.globl	next
	.type	next, @function
next:
.LFB51:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	addq	$40, %rdi
	subq	$80, %rsp
	.cfi_def_cfa_offset 96
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm1
	movups	%xmm1, 56(%rbx)
	movdqu	32(%rsp), %xmm2
	movups	%xmm2, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L110
	addq	$80, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L110:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE51:
	.size	next, .-next
	.section	.rodata.str1.1
.LC7:
	.string	"expected %s, got %s"
	.text
	.p2align 4
	.globl	expect
	.type	expect, @function
expect:
.LFB52:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$104, %rsp
	.cfi_def_cfa_offset 128
	movl	40(%rdi), %edi
	movq	%fs:40, %rax
	movq	%rax, 88(%rsp)
	xorl	%eax, %eax
	cmpl	%esi, %edi
	jne	.L115
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm1
	movups	%xmm1, 56(%rbx)
	movdqu	48(%rsp), %xmm2
	movups	%xmm2, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L116
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L115:
	.cfi_restore_state
	movl	%esi, 12(%rsp)
	call	tk_name@PLT
	movl	12(%rsp), %edi
	movq	%rax, %rbp
	call	tk_name@PLT
	movq	104(%rbx), %rsi
	leaq	40(%rbx), %rdi
	movq	%rbp, %r8
	movq	%rax, %rcx
	leaq	.LC7(%rip), %rdx
	xorl	%eax, %eax
	call	error_at@PLT
.L116:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE52:
	.size	expect, .-expect
	.p2align 4
	.globl	accept
	.type	accept, @function
accept:
.LFB53:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$80, %rsp
	.cfi_def_cfa_offset 96
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	cmpl	%esi, 40(%rdi)
	je	.L122
.L117:
	movq	72(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L123
	addq	$80, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L122:
	.cfi_restore_state
	movq	%rdi, %rbx
	leaq	40(%rdi), %rdi
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm1
	movups	%xmm1, 56(%rbx)
	movdqu	32(%rsp), %xmm2
	movups	%xmm2, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	movl	$1, %eax
	jmp	.L117
.L123:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE53:
	.size	accept, .-accept
	.p2align 4
	.globl	new_expr
	.type	new_expr, @function
new_expr:
.LFB54:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movl	%edi, %r12d
	movl	$80, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movl	%esi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movl	%edx, %ebx
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movl	%r12d, (%rax)
	movl	%ebp, 4(%rax)
	movl	%ebx, 8(%rax)
	movl	$1, 12(%rax)
	movups	%xmm0, 16(%rax)
	movups	%xmm0, 32(%rax)
	movups	%xmm0, 48(%rax)
	movups	%xmm0, 64(%rax)
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE54:
	.size	new_expr, .-new_expr
	.p2align 4
	.globl	new_stmt
	.type	new_stmt, @function
new_stmt:
.LFB55:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movl	%edi, %r12d
	movl	$48, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movl	%esi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movl	%edx, %ebx
	call	xmalloc@PLT
	movl	%r12d, (%rax)
	movl	%ebp, 4(%rax)
	movl	%ebx, 8(%rax)
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE55:
	.size	new_stmt, .-new_stmt
	.p2align 4
	.globl	new_init
	.type	new_init, @function
new_init:
.LFB56:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movl	%edi, %r12d
	movl	$40, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movl	%esi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movl	%edx, %ebx
	call	xmalloc@PLT
	movl	%r12d, (%rax)
	movl	%ebp, 4(%rax)
	movl	%ebx, 8(%rax)
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE56:
	.size	new_init, .-new_init
	.p2align 4
	.globl	peek_next_kind
	.type	peek_next_kind, @function
peek_next_kind:
.LFB61:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$112, %rsp
	.cfi_def_cfa_offset 144
	movdqu	(%rdi), %xmm0
	movdqu	16(%rdi), %xmm1
	movq	%fs:40, %rax
	movq	%rax, 104(%rsp)
	xorl	%eax, %eax
	leaq	48(%rsp), %rbx
	movq	32(%rdi), %rax
	movq	%rsp, %rsi
	movq	g_compilation_arena(%rip), %rbp
	movq	%rbx, %rdi
	movaps	%xmm0, (%rsp)
	movq	%rax, 32(%rsp)
	movaps	%xmm1, 16(%rsp)
	movq	$0, g_compilation_arena(%rip)
	call	lx_next@PLT
	movq	%rbx, %rdi
	movl	48(%rsp), %r12d
	call	tok_free@PLT
	movq	%rbp, g_compilation_arena(%rip)
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L133
	addq	$112, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movl	%r12d, %eax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L133:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE61:
	.size	peek_next_kind, .-peek_next_kind
	.section	.rodata.str1.8
	.align 8
.LC8:
	.string	"expected identifier in extrn at %d:%d"
	.text
	.p2align 4
	.globl	parse_extrn_stmt
	.type	parse_extrn_stmt, @function
parse_extrn_stmt:
.LFB71:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movl	$12, %esi
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %rbx
	subq	$80, %rsp
	.cfi_def_cfa_offset 128
	movq	80(%rdi), %rbp
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	call	expect
	movl	$48, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%rbp, 4(%rax)
	cmpl	$1, 40(%rbx)
	movl	$7, (%rax)
	movq	$0, 16(%rax)
	movups	%xmm0, 24(%rax)
	jne	.L137
	movq	%rax, %r14
	leaq	16(%rax), %r13
	leaq	40(%rbx), %r12
	movq	%rsp, %rbp
	.p2align 4,,10
	.p2align 3
.L135:
	movq	48(%rbx), %rdi
	call	sdup@PLT
	movq	%r13, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm1
	movl	(%rsp), %eax
	movups	%xmm1, 40(%rbx)
	movdqu	16(%rsp), %xmm2
	movups	%xmm2, 56(%rbx)
	movdqu	32(%rsp), %xmm3
	movups	%xmm3, 72(%rbx)
	movq	48(%rsp), %rdx
	movq	%rdx, 88(%rbx)
	cmpl	$17, %eax
	je	.L136
	movl	$18, %esi
	movq	%rbx, %rdi
	call	expect
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L142
	addq	$80, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movq	%r14, %rax
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L136:
	.cfi_restore_state
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm4
	movl	(%rsp), %eax
	movups	%xmm4, 40(%rbx)
	movdqu	16(%rsp), %xmm5
	movups	%xmm5, 56(%rbx)
	movdqu	32(%rsp), %xmm6
	movups	%xmm6, 72(%rbx)
	movq	48(%rsp), %rdx
	movq	%rdx, 88(%rbx)
	cmpl	$1, %eax
	je	.L135
.L137:
	movl	84(%rbx), %edx
	movl	80(%rbx), %esi
	leaq	.LC8(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L142:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE71:
	.size	parse_extrn_stmt, .-parse_extrn_stmt
	.section	.rodata.str1.8
	.align 8
.LC9:
	.string	"comma expression is outside Thompson B72"
	.align 8
.LC10:
	.string	"expression nesting limit exceeded at %d:%d"
	.text
	.p2align 4
	.globl	parse_expr
	.type	parse_expr, @function
parse_expr:
.LFB93:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$104, %rsp
	.cfi_def_cfa_offset 160
	movq	%fs:40, %rax
	movq	%rax, 88(%rsp)
	xorl	%eax, %eax
	call	parse_assignment
	movq	%rax, %rbx
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L144
	cmpl	$17, 40(%rbp)
	je	.L160
.L143:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L161
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L144:
	.cfi_restore_state
	cmpl	$17, 40(%rbp)
	jne	.L143
	leaq	16(%rsp), %rax
	leaq	40(%rbp), %r13
	movq	%rax, (%rsp)
.L147:
	movq	%r13, %rdi
	movq	%rbx, %r15
	call	tok_free@PLT
	movq	(%rsp), %rdi
	movq	%rbp, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm1
	movq	%rbp, %rdi
	movups	%xmm1, 40(%rbp)
	movdqu	32(%rsp), %xmm2
	movups	%xmm2, 56(%rbp)
	movdqu	48(%rsp), %xmm3
	movups	%xmm3, 72(%rbp)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbp)
	call	parse_assignment
	movq	4(%rbx), %r12
	movl	$80, %edi
	movq	%rax, %r14
	movl	8(%rbx), %eax
	movl	%eax, 8(%rsp)
	movl	4(%rbx), %eax
	movl	%eax, 12(%rsp)
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movl	$10, (%rax)
	movq	%rax, %rbx
	movq	%r12, 4(%rax)
	movl	$1, 12(%rax)
	movq	%r15, 48(%rax)
	movq	%r14, 56(%rax)
	movups	%xmm0, 16(%rax)
	movups	%xmm0, 32(%rax)
	movups	%xmm0, 64(%rax)
	movl	12(%r15), %eax
	cmpl	$511, %eax
	ja	.L159
	testl	%eax, %eax
	je	.L149
	addl	$1, %eax
	movl	%eax, 12(%rbx)
.L149:
	movl	12(%r14), %eax
	cmpl	$511, %eax
	ja	.L159
	cmpl	12(%rbx), %eax
	jb	.L151
	addl	$1, %eax
	movl	%eax, 12(%rbx)
.L151:
	cmpl	$17, 40(%rbp)
	jne	.L143
	jmp	.L147
.L160:
	movq	104(%rbp), %rsi
	leaq	40(%rbp), %rdi
	leaq	.LC9(%rip), %rdx
	xorl	%eax, %eax
	call	error_at@PLT
.L161:
	call	__stack_chk_fail@PLT
.L159:
	movl	8(%rsp), %edx
	movl	12(%rsp), %esi
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.cfi_endproc
.LFE93:
	.size	parse_expr, .-parse_expr
	.section	.rodata.str1.8
	.align 8
.LC11:
	.string	"expected identifier after auto at %d:%d"
	.align 8
.LC12:
	.string	"expected identifier in auto decl at %d:%d"
	.section	.rodata.str1.1
.LC13:
	.string	"out of memory"
	.section	.rodata.str1.8
	.align 8
.LC14:
	.string	"bracketed auto vectors are outside Thompson B72; use auto name size"
	.text
	.p2align 4
	.globl	parse_auto_decl
	.type	parse_auto_decl, @function
parse_auto_decl:
.LFB63:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	$5, %esi
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movq	80(%rdi), %r12
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	call	expect
	movl	$48, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%r12, 4(%rax)
	cmpl	$1, 40(%rbx)
	movl	$2, (%rax)
	movq	$0, 16(%rax)
	movups	%xmm0, 24(%rax)
	jne	.L173
	movq	%rax, %rbp
	leaq	40(%rbx), %r14
.L163:
	movl	$16, %edi
	call	xmalloc@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L176
	movq	48(%rbx), %rdi
	movq	%rsp, %r13
	call	sdup@PLT
	movq	%r14, %rdi
	movq	$0, 8(%r12)
	movq	%rax, (%r12)
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm1
	movl	(%rsp), %eax
	movups	%xmm1, 40(%rbx)
	movdqu	16(%rsp), %xmm2
	movups	%xmm2, 56(%rbx)
	movdqu	32(%rsp), %xmm3
	movups	%xmm3, 72(%rbx)
	movq	48(%rsp), %rdx
	movq	%rdx, 88(%rbx)
	cmpl	$19, %eax
	je	.L165
	subl	$2, %eax
	andl	$-3, %eax
	je	.L177
.L167:
	leaq	16(%rbp), %rdi
	movq	%r12, %rsi
	call	vec_push@PLT
	cmpl	$17, 40(%rbx)
	je	.L169
	movl	$18, %esi
	movq	%rbx, %rdi
	call	expect
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L178
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L177:
	.cfi_restore_state
	movl	$80, %edi
	movq	80(%rbx), %r15
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%r14, %rdi
	movups	%xmm0, (%rax)
	movups	%xmm0, 48(%rax)
	movups	%xmm0, 16(%rax)
	movups	%xmm0, 32(%rax)
	movups	%xmm0, 64(%rax)
	movq	72(%rbx), %rdx
	movq	%r15, 4(%rax)
	movl	$1, 12(%rax)
	movq	%rax, 8(%r12)
	movq	%rdx, 48(%rax)
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm4
	movups	%xmm4, 40(%rbx)
	movdqu	16(%rsp), %xmm5
	movups	%xmm5, 56(%rbx)
	movdqu	32(%rsp), %xmm6
	movups	%xmm6, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	jmp	.L167
	.p2align 4,,10
	.p2align 3
.L165:
	movq	%r14, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm7
	movups	%xmm7, 40(%rbx)
	movdqu	16(%rsp), %xmm7
	movups	%xmm7, 56(%rbx)
	movdqu	32(%rsp), %xmm7
	movups	%xmm7, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	testb	$-128, g_extensions(%rip)
	je	.L179
	movq	%rbx, %rdi
	call	parse_expr
	movl	$20, %esi
	movq	%rbx, %rdi
	movq	%rax, 8(%r12)
	call	expect
	jmp	.L167
	.p2align 4,,10
	.p2align 3
.L169:
	movq	%r14, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm4
	movl	(%rsp), %eax
	movups	%xmm4, 40(%rbx)
	movdqu	16(%rsp), %xmm5
	movups	%xmm5, 56(%rbx)
	movdqu	32(%rsp), %xmm6
	movups	%xmm6, 72(%rbx)
	movq	48(%rsp), %rdx
	movq	%rdx, 88(%rbx)
	cmpl	$1, %eax
	je	.L163
	movl	84(%rbx), %edx
	movl	80(%rbx), %esi
	leaq	.LC12(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L176:
	leaq	.LC13(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L173:
	movl	84(%rbx), %edx
	movl	80(%rbx), %esi
	leaq	.LC11(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L178:
	call	__stack_chk_fail@PLT
.L179:
	movq	104(%rbx), %rsi
	leaq	.LC14(%rip), %rdx
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	error_at@PLT
	.cfi_endproc
.LFE63:
	.size	parse_auto_decl, .-parse_auto_decl
	.section	.rodata.str1.8
	.align 8
.LC15:
	.string	"expected identifier after extrn at %d:%d"
	.align 8
.LC16:
	.string	"extrn declarations are only allowed for variables, not functions at %d:%d"
	.text
	.p2align 4
	.globl	parse_extern_decl
	.type	parse_extern_decl, @function
parse_extern_decl:
.LFB66:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movl	$12, %esi
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$88, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	call	expect
	cmpl	$1, 40(%rbp)
	jne	.L189
	movl	$64, %edi
	call	xmalloc@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L190
	pxor	%xmm0, %xmm0
	leaq	40(%rbp), %r13
	movq	%rsp, %r12
	movups	%xmm0, (%rax)
	movups	%xmm0, 16(%rax)
	movups	%xmm0, 32(%rax)
	movups	%xmm0, 48(%rax)
	movq	48(%rbp), %rdi
	call	sdup@PLT
	movq	%r13, %rdi
	movq	%rax, 16(%rbx)
	call	tok_free@PLT
	movq	%rbp, %rsi
	movq	%r12, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm1
	movl	(%rsp), %eax
	movups	%xmm1, 40(%rbp)
	movdqu	16(%rsp), %xmm2
	movups	%xmm2, 56(%rbp)
	movdqu	32(%rsp), %xmm3
	movups	%xmm3, 72(%rbp)
	movq	48(%rsp), %rdx
	movq	%rdx, 88(%rbp)
	cmpl	$13, %eax
	je	.L183
	movl	$0, (%rbx)
	movl	$0, 24(%rbx)
	movq	$0, 32(%rbx)
	movl	$0, 40(%rbx)
	movq	$0, 48(%rbx)
	movq	$0, 56(%rbx)
	cmpl	$19, %eax
	je	.L191
.L185:
	movl	$18, %esi
	movq	%rbp, %rdi
	call	expect
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L192
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L183:
	.cfi_restore_state
	movq	%r13, %rdi
	call	tok_free@PLT
	movq	%rbp, %rsi
	movq	%r12, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm4
	leaq	.LC16(%rip), %rdi
	movups	%xmm4, 40(%rbp)
	movdqu	16(%rsp), %xmm5
	movups	%xmm5, 56(%rbp)
	movdqu	32(%rsp), %xmm6
	movups	%xmm6, 72(%rbp)
	movq	48(%rsp), %rax
	movl	84(%rbp), %edx
	movl	80(%rbp), %esi
	movq	%rax, 88(%rbp)
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4,,10
	.p2align 3
.L191:
	movq	%r13, %rdi
	call	tok_free@PLT
	movq	%rbp, %rsi
	movq	%r12, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm7
	movups	%xmm7, 40(%rbp)
	movdqu	16(%rsp), %xmm7
	cmpl	$20, 40(%rbp)
	movups	%xmm7, 56(%rbp)
	movdqu	32(%rsp), %xmm4
	movups	%xmm4, 72(%rbp)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbp)
	movl	$2, 24(%rbx)
	je	.L193
	movq	%rbp, %rdi
	call	parse_expr
	movl	$20, %esi
	movq	%rbp, %rdi
	movq	%rax, 32(%rbx)
	call	expect
	jmp	.L185
	.p2align 4,,10
	.p2align 3
.L193:
	movq	%r13, %rdi
	call	tok_free@PLT
	movq	%rbp, %rsi
	movq	%r12, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm5
	movups	%xmm5, 40(%rbp)
	movdqu	16(%rsp), %xmm6
	movups	%xmm6, 56(%rbp)
	movdqu	32(%rsp), %xmm5
	movups	%xmm5, 72(%rbp)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbp)
	movl	$1, 40(%rbx)
	jmp	.L185
.L190:
	leaq	.LC13(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L189:
	movl	84(%rbp), %edx
	movl	80(%rbp), %esi
	leaq	.LC15(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L192:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE66:
	.size	parse_extern_decl, .-parse_extern_decl
	.p2align 4
	.globl	parse_return
	.type	parse_return, @function
parse_return:
.LFB70:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movl	$9, %esi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	xorl	%ebp, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movq	80(%rdi), %r12
	call	expect
	cmpl	$18, 40(%rbx)
	je	.L195
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L196
	movl	$13, %esi
	movq	%rbx, %rdi
	call	expect
	movq	%rbx, %rdi
	call	parse_expr
	movl	$14, %esi
	movq	%rbx, %rdi
	movq	%rax, %rbp
	call	expect
.L195:
	movq	%rbx, %rdi
	movl	$18, %esi
	call	expect
	movl	$48, %edi
	call	xmalloc@PLT
	movl	$5, (%rax)
	movq	%r12, 4(%rax)
	movq	%rbp, 16(%rax)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L196:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	parse_expr
	movq	%rax, %rbp
	jmp	.L195
	.cfi_endproc
.LFE70:
	.size	parse_return, .-parse_return
	.p2align 4
	.globl	parse_primary
	.type	parse_primary, @function
parse_primary:
.LFB85:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	subq	$80, %rsp
	.cfi_def_cfa_offset 112
	movq	80(%rdi), %r12
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	cmpl	$13, 40(%rdi)
	ja	.L200
	movl	40(%rdi), %eax
	leaq	.L202(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L202:
	.long	.L200-.L202
	.long	.L205-.L202
	.long	.L203-.L202
	.long	.L204-.L202
	.long	.L203-.L202
	.long	.L200-.L202
	.long	.L200-.L202
	.long	.L200-.L202
	.long	.L200-.L202
	.long	.L200-.L202
	.long	.L200-.L202
	.long	.L200-.L202
	.long	.L200-.L202
	.long	.L201-.L202
	.text
	.p2align 4,,10
	.p2align 3
.L203:
	movl	$80, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	leaq	40(%rbx), %rdi
	movups	%xmm0, (%rax)
	movq	%rax, %rbp
	movups	%xmm0, 16(%rax)
	movups	%xmm0, 32(%rax)
	movups	%xmm0, 48(%rax)
	movups	%xmm0, 64(%rax)
	movq	%r12, 4(%rax)
	movl	$1, 12(%rax)
	movq	72(%rbx), %rax
	movq	%rax, 48(%rbp)
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm1
	movups	%xmm1, 40(%rbx)
	movdqu	16(%rsp), %xmm2
	movups	%xmm2, 56(%rbx)
	movdqu	32(%rsp), %xmm3
	movups	%xmm3, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
.L199:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L209
	addq	$80, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%rbp, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L205:
	.cfi_restore_state
	movl	$80, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movl	$2, (%rax)
	movq	%rax, %rbp
	movq	%r12, 4(%rax)
	movl	$1, 12(%rax)
	movups	%xmm0, 16(%rax)
	movups	%xmm0, 32(%rax)
	movups	%xmm0, 48(%rax)
	movups	%xmm0, 64(%rax)
	movq	48(%rbx), %rdi
	call	sdup@PLT
	leaq	40(%rbx), %rdi
	movq	%rax, 48(%rbp)
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm7
	movups	%xmm7, 40(%rbx)
	movdqu	16(%rsp), %xmm1
	movups	%xmm1, 56(%rbx)
	movdqu	32(%rsp), %xmm2
	movups	%xmm2, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	jmp	.L199
	.p2align 4,,10
	.p2align 3
.L201:
	leaq	40(%rdi), %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm3
	movq	%rbx, %rdi
	movups	%xmm3, 40(%rbx)
	movdqu	16(%rsp), %xmm4
	movups	%xmm4, 56(%rbx)
	movdqu	32(%rsp), %xmm5
	movups	%xmm5, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	call	parse_expr
	movl	$14, %esi
	movq	%rbx, %rdi
	movq	%rax, %rbp
	call	expect
	jmp	.L199
	.p2align 4,,10
	.p2align 3
.L204:
	movl	$80, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 32(%rax)
	movq	%rax, %rbp
	movups	%xmm0, 16(%rax)
	movups	%xmm0, 48(%rax)
	movups	%xmm0, 64(%rax)
	movq	56(%rbx), %rdi
	movl	$1, (%rax)
	movq	%rdi, 40(%rax)
	addq	$1, %rdi
	movq	%r12, 4(%rax)
	movl	$1, 12(%rax)
	call	xmalloc@PLT
	movq	48(%rbx), %rsi
	movq	%rax, %rdi
	movq	%rax, 48(%rbp)
	movq	40(%rbp), %rax
	leaq	1(%rax), %rdx
	call	memcpy@PLT
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm4
	movups	%xmm4, 40(%rbx)
	movdqu	16(%rsp), %xmm5
	movups	%xmm5, 56(%rbx)
	movdqu	32(%rsp), %xmm6
	movups	%xmm6, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	jmp	.L199
.L200:
	movq	104(%rbx), %rsi
	leaq	40(%rbx), %rdi
	xorl	%ecx, %ecx
	movl	$8, %edx
	call	error_at_code@PLT
.L209:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE85:
	.size	parse_primary, .-parse_primary
	.section	.rodata.str1.8
	.align 8
.LC17:
	.string	"label expression must be an identifier at %d:%d"
	.text
	.p2align 4
	.type	parse_stmt_inner, @function
parse_stmt_inner:
.LFB80:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %rbx
	subq	$96, %rsp
	.cfi_def_cfa_offset 144
	movq	%fs:40, %rax
	movq	%rax, 88(%rsp)
	movl	40(%rdi), %eax
	cmpl	$1, %eax
	je	.L250
	cmpl	$18, %eax
	je	.L218
.L251:
	subl	$5, %eax
	cmpl	$56, %eax
	ja	.L219
	leaq	.L221(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L221:
	.long	.L226-.L221
	.long	.L231-.L221
	.long	.L219-.L221
	.long	.L230-.L221
	.long	.L229-.L221
	.long	.L228-.L221
	.long	.L227-.L221
	.long	.L226-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L225-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L219-.L221
	.long	.L224-.L221
	.long	.L223-.L221
	.long	.L222-.L221
	.long	.L220-.L221
	.text
	.p2align 4,,10
	.p2align 3
.L250:
	call	peek_next_kind
	cmpl	$57, %eax
	je	.L212
	movl	40(%rbx), %eax
	cmpl	$18, %eax
	jne	.L251
	.p2align 4,,10
	.p2align 3
.L218:
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm1
	movl	$48, %edi
	movups	%xmm1, 40(%rbx)
	movdqu	32(%rsp), %xmm2
	movups	%xmm2, 56(%rbx)
	movdqu	48(%rsp), %xmm3
	movups	%xmm3, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	movq	80(%rbx), %rbx
	call	xmalloc@PLT
	movl	$0, (%rax)
	movq	%rax, %rbp
	movq	%rbx, 4(%rax)
	jmp	.L210
	.p2align 4,,10
	.p2align 3
.L219:
	movq	%rbx, %rdi
	movq	80(%rbx), %r13
	call	parse_expr
	movl	$18, %esi
	movq	%rbx, %rdi
	movq	%rax, %r12
	call	expect
	movl	$48, %edi
	call	xmalloc@PLT
	movl	$6, (%rax)
	movq	%rax, %rbp
	movq	%r13, 4(%rax)
	movq	%r12, 16(%rax)
	.p2align 4,,10
	.p2align 3
.L210:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L248
	addq	$96, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movq	%rbp, %rax
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L226:
	.cfi_restore_state
	movq	80(%rbx), %r12
	movl	$48, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%r12, 4(%rax)
	leaq	16(%rax), %r12
	movq	%rax, %rbp
	movl	$1, (%rax)
	movups	%xmm0, 16(%rax)
	movq	$0, 16(%r12)
	movl	40(%rbx), %eax
	jmp	.L244
	.p2align 4,,10
	.p2align 3
.L253:
	cmpl	$12, %eax
	jne	.L252
.L244:
	cmpl	$5, %eax
	je	.L245
	movq	%rbx, %rdi
	call	parse_extrn_stmt
	movq	%rax, %rsi
.L234:
	movq	%r12, %rdi
	call	vec_push@PLT
	movl	40(%rbx), %eax
	cmpl	$5, %eax
	jne	.L253
.L245:
	movq	%rbx, %rdi
	call	parse_auto_decl
	movq	%rax, %rsi
	jmp	.L234
	.p2align 4,,10
	.p2align 3
.L228:
	leaq	40(%rbx), %rdi
	movq	80(%rbx), %r12
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm4
	movl	$18, %esi
	movq	%rbx, %rdi
	movups	%xmm4, 40(%rbx)
	movdqu	32(%rsp), %xmm5
	movups	%xmm5, 56(%rbx)
	movdqu	48(%rsp), %xmm6
	movups	%xmm6, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	call	expect
	movl	$48, %edi
	call	xmalloc@PLT
	movl	$8, (%rax)
	movq	%rax, %rbp
	movq	%r12, 4(%rax)
	jmp	.L210
	.p2align 4,,10
	.p2align 3
.L227:
	leaq	40(%rbx), %rdi
	movq	80(%rbx), %r12
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm7
	movl	$18, %esi
	movq	%rbx, %rdi
	movups	%xmm7, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm4
	movups	%xmm4, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	call	expect
	movl	$48, %edi
	call	xmalloc@PLT
	movl	$9, (%rax)
	movq	%rax, %rbp
	movq	%r12, 4(%rax)
	jmp	.L210
	.p2align 4,,10
	.p2align 3
.L225:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L248
	addq	$96, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	parse_block
	.p2align 4,,10
	.p2align 3
.L220:
	.cfi_restore_state
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L248
	addq	$96, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	parse_default
	.p2align 4,,10
	.p2align 3
.L223:
	.cfi_restore_state
	movl	$59, %esi
	movq	%rbx, %rdi
	movq	80(%rbx), %r12
	call	expect
	movq	%rbx, %rdi
	call	parse_expr
	movl	96(%rbx), %edx
	addl	$1, 120(%rbx)
	movq	%rax, %r13
	cmpl	$511, %edx
	ja	.L249
	addl	$1, %edx
	movq	%rbx, %rdi
	movl	%edx, 96(%rbx)
	call	parse_stmt_inner
	subl	$1, 96(%rbx)
	movl	$48, %edi
	subl	$1, 120(%rbx)
	movq	%rax, %r14
	call	xmalloc@PLT
	movl	$12, (%rax)
	movq	%rax, %rbp
	movq	%r12, 4(%rax)
	movq	%r13, 16(%rax)
	movq	%r14, 24(%rax)
	jmp	.L210
	.p2align 4,,10
	.p2align 3
.L222:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L248
	addq	$96, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	parse_case
	.p2align 4,,10
	.p2align 3
.L224:
	.cfi_restore_state
	movl	$58, %esi
	movq	%rbx, %rdi
	movq	80(%rbx), %r13
	call	expect
	movq	%rbx, %rdi
	call	parse_expr
	movl	$18, %esi
	movq	%rbx, %rdi
	movq	%rax, %r12
	call	expect
	movl	$48, %edi
	call	xmalloc@PLT
	movl	$10, (%rax)
	movq	%rax, %rbp
	movq	%r13, 4(%rax)
	movq	%r12, 16(%rax)
	jmp	.L210
	.p2align 4,,10
	.p2align 3
.L230:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L248
	addq	$96, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	parse_while
	.p2align 4,,10
	.p2align 3
.L229:
	.cfi_restore_state
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L248
	addq	$96, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	parse_return
	.p2align 4,,10
	.p2align 3
.L231:
	.cfi_restore_state
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L248
	addq	$96, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	parse_if
	.p2align 4,,10
	.p2align 3
.L252:
	.cfi_restore_state
	movl	96(%rbx), %eax
	cmpl	$511, %eax
	ja	.L249
	addl	$1, %eax
	movq	%rbx, %rdi
	movl	%eax, 96(%rbx)
	call	parse_stmt_inner
	subl	$1, 96(%rbx)
	movq	%r12, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L210
	.p2align 4,,10
	.p2align 3
.L212:
	movq	80(%rbx), %rax
	movq	%rbx, %rdi
	movq	%rax, 8(%rsp)
	call	parse_expr
	movl	$57, %esi
	movq	%rbx, %rdi
	movq	%rax, %r12
	call	expect
	cmpl	$2, (%r12)
	jne	.L254
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L214
	cmpl	$16, 40(%rbx)
	je	.L255
.L214:
	movl	96(%rbx), %eax
	cmpl	$511, %eax
	ja	.L249
	addl	$1, %eax
	movq	%rbx, %rdi
	movl	%eax, 96(%rbx)
	call	parse_stmt_inner
	subl	$1, 96(%rbx)
	movq	%rax, %r13
.L215:
	movl	$48, %edi
	call	xmalloc@PLT
	movq	%rax, %rbp
	movl	$11, (%rax)
	movq	8(%rsp), %rax
	movq	%rax, 4(%rbp)
	movq	48(%r12), %rdi
	call	sdup@PLT
	movq	%r13, 24(%rbp)
	movq	%rax, 16(%rbp)
	jmp	.L210
.L255:
	movq	80(%rbx), %rbx
	movl	$48, %edi
	call	xmalloc@PLT
	movl	$0, (%rax)
	movq	%rax, %r13
	movq	%rbx, 4(%rax)
	jmp	.L215
.L248:
	call	__stack_chk_fail@PLT
.L249:
	movl	84(%rbx), %esi
	movl	80(%rbx), %edi
	call	enter_parse.part.0.isra.0
.L254:
	movq	8(%rsp), %xmm5
	leaq	.LC17(%rip), %rdi
	xorl	%eax, %eax
	pshufd	$0xe5, %xmm5, %xmm6
	movd	%xmm5, %esi
	movd	%xmm6, %edx
	call	dief@PLT
	.cfi_endproc
.LFE80:
	.size	parse_stmt_inner, .-parse_stmt_inner
	.p2align 4
	.globl	parse_stmt
	.type	parse_stmt, @function
parse_stmt:
.LFB81:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	96(%rdi), %eax
	movq	%rdi, %rbx
	cmpl	$511, %eax
	ja	.L259
	addl	$1, %eax
	movl	%eax, 96(%rdi)
	call	parse_stmt_inner
	subl	$1, 96(%rbx)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L259:
	.cfi_restore_state
	movl	84(%rdi), %esi
	movl	80(%rdi), %edi
	call	enter_parse.part.0.isra.0
	.cfi_endproc
.LFE81:
	.size	parse_stmt, .-parse_stmt
	.section	.rodata.str1.1
.LC18:
	.string	"unexpected EOF in block"
	.text
	.p2align 4
	.globl	parse_block
	.type	parse_block, @function
parse_block:
.LFB67:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movl	$15, %esi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movq	80(%rdi), %r12
	call	expect
	xorl	%eax, %eax
	call	vec_new@PLT
	movq	%rax, %rbp
.L273:
	movl	40(%rbx), %eax
	cmpl	$16, %eax
	je	.L261
.L278:
	testl	%eax, %eax
	je	.L274
	movl	g_strict(%rip), %edx
	testl	%edx, %edx
	jne	.L263
	cmpl	$5, %eax
	je	.L275
	cmpl	$12, %eax
	je	.L276
.L263:
	movl	96(%rbx), %eax
	cmpl	$511, %eax
	ja	.L277
	addl	$1, %eax
	movq	%rbx, %rdi
	movl	%eax, 96(%rbx)
	call	parse_stmt_inner
	subl	$1, 96(%rbx)
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movl	40(%rbx), %eax
	cmpl	$16, %eax
	jne	.L278
.L261:
	movq	%rbx, %rdi
	movl	$16, %esi
	call	expect
	movl	$48, %edi
	call	xmalloc@PLT
	movdqu	0(%rbp), %xmm0
	movl	$1, (%rax)
	movups	%xmm0, 16(%rax)
	movq	16(%rbp), %rdx
	movq	%r12, 4(%rax)
	movq	%rdx, 32(%rax)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L276:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	parse_extrn_stmt
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L273
	.p2align 4,,10
	.p2align 3
.L275:
	movq	%rbx, %rdi
	call	parse_auto_decl
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L273
.L274:
	leaq	.LC18(%rip), %rdi
	call	dief@PLT
.L277:
	movl	84(%rbx), %edx
	movl	80(%rbx), %esi
	leaq	.LC0(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.cfi_endproc
.LFE67:
	.size	parse_block, .-parse_block
	.p2align 4
	.globl	parse_while
	.type	parse_while, @function
parse_while:
.LFB69:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movl	$8, %esi
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	movq	80(%rdi), %r12
	call	expect
	movl	$13, %esi
	movq	%rbx, %rdi
	call	expect
	movq	%rbx, %rdi
	call	parse_expr
	movl	$14, %esi
	movq	%rbx, %rdi
	movq	%rax, %rbp
	call	expect
	movl	96(%rbx), %eax
	addl	$1, 116(%rbx)
	cmpl	$511, %eax
	ja	.L282
	addl	$1, %eax
	movq	%rbx, %rdi
	movl	%eax, 96(%rbx)
	call	parse_stmt_inner
	subl	$1, 96(%rbx)
	movl	$48, %edi
	subl	$1, 116(%rbx)
	movq	%rax, %r13
	call	xmalloc@PLT
	movl	$4, (%rax)
	movq	%r12, 4(%rax)
	movq	%rbp, 16(%rax)
	movq	%r13, 24(%rax)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L282:
	.cfi_restore_state
	movl	84(%rbx), %esi
	movl	80(%rbx), %edi
	call	enter_parse.part.0.isra.0
	.cfi_endproc
.LFE69:
	.size	parse_while, .-parse_while
	.p2align 4
	.type	parse_case_body, @function
parse_case_body:
.LFB76:
	.cfi_startproc
	movl	g_strict(%rip), %eax
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	testl	%eax, %eax
	jne	.L284
	movl	40(%rdi), %eax
	cmpl	$16, %eax
	je	.L290
	cmpl	$5, %eax
	je	.L291
	cmpl	$12, %eax
	je	.L292
.L284:
	movl	96(%rbx), %eax
	cmpl	$511, %eax
	ja	.L293
	addl	$1, %eax
	movq	%rbx, %rdi
	movl	%eax, 96(%rbx)
	call	parse_stmt_inner
	subl	$1, 96(%rbx)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L292:
	.cfi_restore_state
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	parse_extrn_stmt
	.p2align 4,,10
	.p2align 3
.L290:
	.cfi_restore_state
	movq	80(%rdi), %rbx
	movl	$48, %edi
	call	xmalloc@PLT
	movl	$0, (%rax)
	movq	%rbx, 4(%rax)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L291:
	.cfi_restore_state
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	parse_auto_decl
.L293:
	.cfi_restore_state
	movl	84(%rbx), %esi
	movl	80(%rbx), %edi
	call	enter_parse.part.0.isra.0
	.cfi_endproc
.LFE76:
	.size	parse_case_body, .-parse_case_body
	.section	.rodata.str1.1
.LC19:
	.string	"case outside switch at %d:%d"
	.section	.rodata.str1.8
	.align 8
.LC20:
	.string	"expected literal case constant"
	.section	.rodata.str1.1
.LC21:
	.string	"invalid constant word width"
	.text
	.p2align 4
	.globl	parse_case
	.type	parse_case, @function
parse_case:
.LFB77:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	$60, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$120, %rsp
	.cfi_def_cfa_offset 144
	movq	%fs:40, %rax
	movq	%rax, 104(%rsp)
	xorl	%eax, %eax
	movq	80(%rdi), %rax
	movq	%rax, 8(%rsp)
	call	expect
	movl	120(%rbx), %edx
	testl	%edx, %edx
	je	.L315
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L296
	movl	40(%rbx), %eax
	cmpl	$31, %eax
	je	.L316
	subl	$2, %eax
	leaq	40(%rbx), %rbp
	andl	$-3, %eax
	jne	.L301
	movq	%rbx, %rdi
	call	parse_primary
	movq	%rax, %rdi
.L300:
	movl	112(%rbx), %esi
	testl	%esi, %esi
	je	.L304
	leal	-16(%rsi), %eax
	andl	$-17, %eax
	jne	.L317
.L299:
	movl	$1, %edx
	call	eval_const_expr
	movl	$57, %esi
	movq	%rbx, %rdi
	movq	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm0
	movaps	%xmm0, 16(%rsp)
	call	expect
	movl	$48, %edi
	call	xmalloc@PLT
	movdqa	16(%rsp), %xmm0
	movq	%rbx, %rdi
	movl	$13, (%rax)
	movq	%rax, %rbp
	movq	8(%rsp), %rax
	movq	$0, 16(%rbp)
	movq	%rax, 4(%rbp)
	movups	%xmm0, 24(%rbp)
	call	parse_case_body
	movq	%rax, 40(%rbp)
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L318
	addq	$120, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbp, %rax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L304:
	.cfi_restore_state
	movl	$64, %esi
	jmp	.L299
	.p2align 4,,10
	.p2align 3
.L296:
	movq	%rbx, %rdi
	call	parse_expr
	movq	%rax, %rdi
	jmp	.L300
	.p2align 4,,10
	.p2align 3
.L301:
	movq	104(%rbx), %rsi
	leaq	.LC20(%rip), %rdx
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	error_at@PLT
	.p2align 4,,10
	.p2align 3
.L317:
	cmpl	$64, %esi
	je	.L299
	leaq	.LC21(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4,,10
	.p2align 3
.L316:
	leaq	40(%rbx), %rbp
	movq	%rbp, %rdi
	call	tok_free@PLT
	leaq	32(%rsp), %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	32(%rsp), %xmm1
	movl	32(%rsp), %eax
	movups	%xmm1, 40(%rbx)
	movdqu	48(%rsp), %xmm2
	subl	$2, %eax
	andl	$-3, %eax
	movups	%xmm2, 56(%rbx)
	movdqu	64(%rsp), %xmm3
	movups	%xmm3, 72(%rbx)
	movq	80(%rsp), %rdx
	movq	%rdx, 88(%rbx)
	jne	.L301
	movq	%rbx, %rdi
	call	parse_primary
	movl	$80, %edi
	movq	%rax, %rbp
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movl	$5, (%rax)
	movq	%rax, %rdi
	movups	%xmm0, 16(%rax)
	movups	%xmm0, 32(%rax)
	movups	%xmm0, 48(%rax)
	movups	%xmm0, 64(%rax)
	movq	8(%rsp), %rax
	movl	$1, 12(%rdi)
	movq	%rax, 4(%rdi)
	movl	$31, 48(%rdi)
	movq	%rbp, 56(%rdi)
	jmp	.L300
.L315:
	movq	8(%rsp), %xmm4
	leaq	.LC19(%rip), %rdi
	xorl	%eax, %eax
	pshufd	$0xe5, %xmm4, %xmm5
	movd	%xmm4, %esi
	movd	%xmm5, %edx
	call	dief@PLT
.L318:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE77:
	.size	parse_case, .-parse_case
	.section	.rodata.str1.8
	.align 8
.LC22:
	.string	"default outside switch at %d:%d"
	.text
	.p2align 4
	.globl	parse_default
	.type	parse_default, @function
parse_default:
.LFB78:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	$61, %esi
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	movq	80(%rdi), %rax
	movq	%rax, 8(%rsp)
	call	expect
	movl	120(%rbp), %eax
	testl	%eax, %eax
	je	.L322
	movl	$57, %esi
	movq	%rbp, %rdi
	call	expect
	movl	$48, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%rbp, %rdi
	movq	%rax, %rbx
	movl	$13, (%rax)
	movq	8(%rsp), %rax
	movups	%xmm0, 24(%rbx)
	movq	%rax, 4(%rbx)
	movabsq	$261993005056, %rax
	movq	%rax, 16(%rbx)
	call	parse_case_body
	movq	%rax, 40(%rbx)
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L322:
	.cfi_restore_state
	movq	8(%rsp), %xmm1
	leaq	.LC22(%rip), %rdi
	xorl	%eax, %eax
	pshufd	$0xe5, %xmm1, %xmm2
	movd	%xmm1, %esi
	movd	%xmm2, %edx
	call	dief@PLT
	.cfi_endproc
.LFE78:
	.size	parse_default, .-parse_default
	.section	.rodata.str1.8
	.align 8
.LC23:
	.string	"expected function name at %d:%d"
	.align 8
.LC24:
	.string	"expected parameter name at %d:%d"
	.text
	.p2align 4
	.globl	parse_function
	.type	parse_function, @function
parse_function:
.LFB64:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %rbx
	subq	$96, %rsp
	.cfi_def_cfa_offset 144
	movq	%fs:40, %rax
	movq	%rax, 88(%rsp)
	xorl	%eax, %eax
	cmpl	$1, 40(%rdi)
	jne	.L337
	movl	$40, %edi
	leaq	40(%rbx), %r12
	leaq	16(%rsp), %r13
	call	xmalloc@PLT
	movq	48(%rbx), %rdi
	movq	%rax, %rbp
	call	sdup@PLT
	movq	$0, 8(%rbp)
	pxor	%xmm0, %xmm0
	movq	%r12, %rdi
	movq	%rax, 0(%rbp)
	movups	%xmm0, 16(%rbp)
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm1
	movl	$13, %esi
	movq	%rbx, %rdi
	movups	%xmm1, 40(%rbx)
	movdqu	32(%rsp), %xmm2
	movups	%xmm2, 56(%rbx)
	movdqu	48(%rsp), %xmm3
	movups	%xmm3, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	call	expect
	movl	40(%rbx), %eax
	cmpl	$14, %eax
	je	.L325
	cmpl	$1, %eax
	jne	.L327
	leaq	8(%rbp), %r14
.L326:
	movq	48(%rbx), %rdi
	call	sdup@PLT
	movq	%r14, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm4
	movl	16(%rsp), %eax
	movups	%xmm4, 40(%rbx)
	movdqu	32(%rsp), %xmm5
	movups	%xmm5, 56(%rbx)
	movdqu	48(%rsp), %xmm6
	movups	%xmm6, 72(%rbx)
	movq	64(%rsp), %rdx
	movq	%rdx, 88(%rbx)
	cmpl	$17, %eax
	je	.L338
.L325:
	movl	$14, %esi
	movq	%rbx, %rdi
	call	expect
	cmpl	$15, 40(%rbx)
	je	.L339
	movl	96(%rbx), %eax
	movq	80(%rbx), %xmm0
	cmpl	$511, %eax
	ja	.L340
	addl	$1, %eax
	movq	%rbx, %rdi
	movq	%xmm0, 8(%rsp)
	movl	%eax, 96(%rbx)
	call	parse_stmt_inner
	subl	$1, 96(%rbx)
	movl	$48, %edi
	movq	%rax, %r12
	call	xmalloc@PLT
	movq	8(%rsp), %xmm0
	movq	%r12, %rsi
	movl	$1, (%rax)
	leaq	16(%rax), %rdi
	movq	%rax, %rbx
	movq	$0, 16(%rax)
	movq	%xmm0, 4(%rax)
	pxor	%xmm0, %xmm0
	movups	%xmm0, 24(%rax)
	call	vec_push@PLT
.L329:
	movq	%rbx, 32(%rbp)
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L341
	addq	$96, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movq	%rbp, %rax
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L339:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	parse_block
	movq	%rax, %rbx
	jmp	.L329
	.p2align 4,,10
	.p2align 3
.L338:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm7
	movl	16(%rsp), %eax
	movups	%xmm7, 40(%rbx)
	movdqu	32(%rsp), %xmm7
	movups	%xmm7, 56(%rbx)
	movdqu	48(%rsp), %xmm7
	movups	%xmm7, 72(%rbx)
	movq	64(%rsp), %rdx
	movq	%rdx, 88(%rbx)
	cmpl	$1, %eax
	je	.L326
.L327:
	movl	84(%rbx), %edx
	movl	80(%rbx), %esi
	leaq	.LC24(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L341:
	call	__stack_chk_fail@PLT
.L337:
	movl	84(%rdi), %edx
	movl	80(%rdi), %esi
	leaq	.LC23(%rip), %rdi
	call	dief@PLT
.L340:
	pshufd	$0xe5, %xmm0, %xmm7
	movd	%xmm0, %edi
	movd	%xmm7, %esi
	call	enter_parse.part.0.isra.0
	.cfi_endproc
.LFE64:
	.size	parse_function, .-parse_function
	.p2align 4
	.globl	parse_if
	.type	parse_if, @function
parse_if:
.LFB68:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movl	$6, %esi
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %rbx
	subq	$80, %rsp
	.cfi_def_cfa_offset 128
	movq	80(%rdi), %r12
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	call	expect
	movl	$13, %esi
	movq	%rbx, %rdi
	call	expect
	movq	%rbx, %rdi
	call	parse_expr
	movl	$14, %esi
	movq	%rbx, %rdi
	movq	%rax, %rbp
	call	expect
	movl	96(%rbx), %eax
	cmpl	$511, %eax
	ja	.L349
	addl	$1, %eax
	movq	%rbx, %rdi
	xorl	%r14d, %r14d
	movl	%eax, 96(%rbx)
	call	parse_stmt_inner
	subl	$1, 96(%rbx)
	cmpl	$7, 40(%rbx)
	movq	%rax, %r13
	je	.L350
.L344:
	movl	$48, %edi
	call	xmalloc@PLT
	movl	$3, (%rax)
	movq	%r12, 4(%rax)
	movq	%rbp, 16(%rax)
	movq	%r13, 24(%rax)
	movq	%r14, 32(%rax)
	movq	72(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L351
	addq	$80, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L350:
	.cfi_restore_state
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm1
	movups	%xmm1, 56(%rbx)
	movdqu	32(%rsp), %xmm2
	movups	%xmm2, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	movl	96(%rbx), %eax
	cmpl	$511, %eax
	ja	.L349
	addl	$1, %eax
	movq	%rbx, %rdi
	movl	%eax, 96(%rbx)
	call	parse_stmt_inner
	subl	$1, 96(%rbx)
	movq	%rax, %r14
	jmp	.L344
.L351:
	call	__stack_chk_fail@PLT
.L349:
	movl	84(%rbx), %esi
	movl	80(%rbx), %edi
	call	enter_parse.part.0.isra.0
	.cfi_endproc
.LFE68:
	.size	parse_if, .-parse_if
	.section	.rodata.str1.8
	.align 8
.LC25:
	.string	"postfix %s requires an lvalue at %d:%d"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB26:
	.text
.LHOTB26:
	.p2align 4
	.globl	parse_postfix
	.type	parse_postfix, @function
parse_postfix:
.LFB86:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$104, %rsp
	.cfi_def_cfa_offset 160
	movq	%fs:40, %rax
	movq	%rax, 88(%rsp)
	xorl	%eax, %eax
	call	parse_primary
	movq	%rax, %r14
	leaq	40(%rbx), %rax
	movq	%rax, (%rsp)
.L353:
	movl	40(%rbx), %r15d
	cmpl	$13, %r15d
	je	.L354
.L397:
	cmpl	$19, %r15d
	je	.L396
	leal	-36(%r15), %eax
	cmpl	$1, %eax
	ja	.L352
	movq	(%rsp), %rdi
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm1
	movups	%xmm1, 40(%rbx)
	movdqu	32(%rsp), %xmm2
	movups	%xmm2, 56(%rbx)
	movdqu	48(%rsp), %xmm3
	movups	%xmm3, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	testq	%r14, %r14
	je	.L370
	movl	(%r14), %eax
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L371
	cmpl	$5, %eax
	je	.L372
.L373:
	movl	8(%r14), %ebp
	movl	4(%r14), %ebx
	movl	%r15d, %edi
	call	tk_name@PLT
	leaq	.LC25(%rip), %rdi
	movq	%rax, %rsi
	movl	%ebp, %ecx
	movl	%ebx, %edx
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4,,10
	.p2align 3
.L372:
	cmpl	$32, 48(%r14)
	jne	.L373
	.p2align 4,,10
	.p2align 3
.L371:
	movq	4(%r14), %rbp
	movl	$80, %edi
	movl	8(%r14), %r13d
	movl	4(%r14), %r12d
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 48(%rax)
	movl	$6, (%rax)
	movq	%rbp, 4(%rax)
	movl	$1, 12(%rax)
	movl	%r15d, 48(%rax)
	movq	%r14, 56(%rax)
	movups	%xmm0, 16(%rax)
	movups	%xmm0, 32(%rax)
	movups	%xmm0, 64(%rax)
	movl	12(%r14), %edx
	cmpl	$511, %edx
	ja	.L394
	testl	%edx, %edx
	je	.L375
.L395:
	addl	$1, %edx
	movl	%edx, 12(%rax)
.L375:
	movl	40(%rbx), %r15d
	movq	%rax, %r14
	cmpl	$13, %r15d
	jne	.L397
.L354:
	movq	(%rsp), %rdi
	leaq	16(%rsp), %r12
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm4
	movl	$80, %edi
	movl	4(%r14), %r13d
	movups	%xmm4, 40(%rbx)
	movdqu	32(%rsp), %xmm5
	movups	%xmm5, 56(%rbx)
	movdqu	48(%rsp), %xmm6
	movups	%xmm6, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	movl	8(%r14), %eax
	movq	4(%r14), %rbp
	movl	%eax, 12(%rsp)
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 48(%rax)
	movq	%rax, %r15
	movl	$3, (%rax)
	movq	%rbp, 4(%rax)
	movl	$1, 12(%rax)
	movq	%r14, 48(%rax)
	movups	%xmm0, 16(%rax)
	movups	%xmm0, 32(%rax)
	movups	%xmm0, 64(%rax)
	movl	12(%r14), %eax
	cmpl	$511, %eax
	ja	.L398
	testl	%eax, %eax
	je	.L358
	addl	$1, %eax
	movl	%eax, 12(%r15)
.L358:
	cmpl	$14, 40(%rbx)
	leaq	56(%r15), %r14
	je	.L399
.L359:
	movq	%rbx, %rdi
	call	parse_assignment
	movq	%r14, %rdi
	movq	%rax, %r13
	movq	%rax, %rsi
	call	vec_push@PLT
	movl	12(%r13), %eax
	cmpl	$511, %eax
	ja	.L400
	cmpl	12(%r15), %eax
	jb	.L362
	addl	$1, %eax
	movl	%eax, 12(%r15)
.L362:
	cmpl	$17, 40(%rbx)
	je	.L363
	movl	$14, %esi
	movq	%rbx, %rdi
	call	expect
.L360:
	movq	%r15, %r14
	jmp	.L353
	.p2align 4,,10
	.p2align 3
.L396:
	movq	(%rsp), %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm7
	movq	%rbx, %rdi
	movups	%xmm7, 40(%rbx)
	movdqu	32(%rsp), %xmm7
	movups	%xmm7, 56(%rbx)
	movdqu	48(%rsp), %xmm4
	movups	%xmm4, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	call	parse_expr
	movl	$20, %esi
	movq	%rbx, %rdi
	movq	%rax, %r15
	call	expect
	movq	4(%r14), %rbp
	movl	$80, %edi
	movl	8(%r14), %r13d
	movl	4(%r14), %r12d
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movl	$4, (%rax)
	movq	%rbp, 4(%rax)
	movl	$1, 12(%rax)
	movq	%r14, 48(%rax)
	movq	%r15, 56(%rax)
	movups	%xmm0, 16(%rax)
	movups	%xmm0, 32(%rax)
	movups	%xmm0, 64(%rax)
	movl	12(%r14), %edx
	cmpl	$511, %edx
	ja	.L394
	testl	%edx, %edx
	je	.L366
	addl	$1, %edx
	movl	%edx, 12(%rax)
.L366:
	movl	12(%r15), %edx
	cmpl	$511, %edx
	ja	.L394
	cmpl	12(%rax), %edx
	jb	.L375
	jmp	.L395
	.p2align 4,,10
	.p2align 3
.L352:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L401
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r14, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L399:
	.cfi_restore_state
	movq	(%rsp), %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm5
	movups	%xmm5, 40(%rbx)
	movdqu	32(%rsp), %xmm6
	movups	%xmm6, 56(%rbx)
	movdqu	48(%rsp), %xmm5
	movups	%xmm5, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	jmp	.L360
	.p2align 4,,10
	.p2align 3
.L363:
	movq	(%rsp), %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm6
	movups	%xmm6, 40(%rbx)
	movdqu	32(%rsp), %xmm5
	movups	%xmm5, 56(%rbx)
	movdqu	48(%rsp), %xmm6
	movups	%xmm6, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	jmp	.L359
.L394:
	movl	%r13d, %edx
	movl	%r12d, %esi
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L400:
	movl	8(%r15), %eax
	movl	4(%r15), %esi
	leaq	.LC10(%rip), %rdi
	movl	%eax, %edx
	xorl	%eax, %eax
	call	dief@PLT
.L398:
	movl	12(%rsp), %edx
	movl	%r13d, %esi
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L401:
	call	__stack_chk_fail@PLT
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	parse_postfix.cold, @function
parse_postfix.cold:
.LFSB86:
.L370:
	.cfi_def_cfa_offset 160
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movl	8, %eax
	ud2
	.cfi_endproc
.LFE86:
	.text
	.size	parse_postfix, .-parse_postfix
	.section	.text.unlikely
	.size	parse_postfix.cold, .-parse_postfix.cold
.LCOLDE26:
	.text
.LHOTE26:
	.section	.rodata.str1.8
	.align 8
.LC27:
	.string	"prefix %s requires an lvalue at %d:%d"
	.section	.rodata.str1.1
.LC28:
	.string	"& requires an lvalue at %d:%d"
	.text
	.p2align 4
	.globl	parse_unary
	.type	parse_unary, @function
parse_unary:
.LFB88:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %rbx
	subq	$96, %rsp
	.cfi_def_cfa_offset 144
	movq	%fs:40, %rax
	movq	%rax, 88(%rsp)
	movl	96(%rdi), %eax
	cmpl	$511, %eax
	ja	.L430
	movl	40(%rdi), %ebp
	addl	$1, %eax
	movq	80(%rdi), %xmm0
	movl	%eax, 96(%rdi)
	cmpl	$53, %ebp
	ja	.L404
	movabsq	$9007446215360512, %rax
	btq	%rbp, %rax
	jnc	.L404
	leaq	40(%rdi), %rdi
	pshufd	$0xe5, %xmm0, %xmm2
	movd	%xmm0, %r12d
	movq	%xmm0, 8(%rsp)
	movd	%xmm2, %r13d
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm3
	movq	%rbx, %rdi
	movups	%xmm3, 40(%rbx)
	movdqu	32(%rsp), %xmm4
	movups	%xmm4, 56(%rbx)
	movdqu	48(%rsp), %xmm5
	movups	%xmm5, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	call	parse_unary
	movq	8(%rsp), %xmm0
	movq	%rax, %r14
	leal	-36(%rbp), %eax
	cmpl	$1, %eax
	jbe	.L431
	cmpl	$53, %ebp
	jne	.L409
	testq	%r14, %r14
	je	.L410
	movl	(%r14), %eax
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L409
	cmpl	$5, %eax
	je	.L432
.L410:
	movl	%r13d, %edx
	movl	%r12d, %esi
	leaq	.LC28(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4,,10
	.p2align 3
.L404:
	movq	%rbx, %rdi
	call	parse_postfix
.L406:
	subl	$1, 96(%rbx)
	movq	88(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L433
	addq	$96, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L432:
	.cfi_restore_state
	cmpl	$32, 48(%r14)
	jne	.L410
	.p2align 4,,10
	.p2align 3
.L409:
	movl	$80, %edi
	movq	%xmm0, 8(%rsp)
	call	xmalloc@PLT
	movq	8(%rsp), %xmm0
	pxor	%xmm1, %xmm1
	movups	%xmm1, 48(%rax)
	movl	$5, (%rax)
	movl	$1, 12(%rax)
	movl	%ebp, 48(%rax)
	movq	%r14, 56(%rax)
	movups	%xmm1, 16(%rax)
	movups	%xmm1, 32(%rax)
	movups	%xmm1, 64(%rax)
	movq	%xmm0, 4(%rax)
	movl	12(%r14), %edx
	cmpl	$511, %edx
	ja	.L434
	testl	%edx, %edx
	je	.L406
	addl	$1, %edx
	movl	%edx, 12(%rax)
	jmp	.L406
	.p2align 4,,10
	.p2align 3
.L431:
	testq	%r14, %r14
	je	.L408
	movl	(%r14), %eax
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L409
	cmpl	$5, %eax
	je	.L435
.L408:
	movl	%ebp, %edi
	call	tk_name@PLT
	movl	%r13d, %ecx
	movl	%r12d, %edx
	leaq	.LC27(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4,,10
	.p2align 3
.L435:
	cmpl	$32, 48(%r14)
	jne	.L408
	jmp	.L409
.L433:
	call	__stack_chk_fail@PLT
.L430:
	movl	84(%rdi), %esi
	movl	80(%rdi), %edi
	call	enter_parse.part.0.isra.0
.L434:
	movl	%r13d, %edx
	movl	%r12d, %esi
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.cfi_endproc
.LFE88:
	.size	parse_unary, .-parse_unary
	.p2align 4
	.globl	parse_bin_rhs
	.type	parse_bin_rhs, @function
parse_bin_rhs:
.LFB89:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rdi, %r15
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdx, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	xorl	%r13d, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	leaq	CSWTCH.37(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$104, %rsp
	.cfi_def_cfa_offset 160
	movl	40(%r15), %ebx
	movl	%esi, 4(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 88(%rsp)
	xorl	%eax, %eax
	leal	-22(%rbx), %eax
	cmpl	$33, %eax
	ja	.L438
.L456:
	movsbl	(%r12,%rax), %r13d
.L438:
	cmpl	%r13d, 4(%rsp)
	jg	.L454
.L439:
	leaq	40(%r15), %rdi
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%r15, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm1
	movq	%r15, %rdi
	movups	%xmm1, 40(%r15)
	movdqu	32(%rsp), %xmm2
	movups	%xmm2, 56(%r15)
	movdqu	48(%rsp), %xmm3
	movups	%xmm3, 72(%r15)
	movq	64(%rsp), %rax
	movq	%rax, 88(%r15)
	call	parse_unary
	movq	%rax, %rbp
	movl	40(%r15), %eax
	subl	$22, %eax
	cmpl	$33, %eax
	ja	.L440
	movsbl	(%r12,%rax), %eax
	cmpl	%eax, %r13d
	jl	.L455
.L440:
	movl	8(%r14), %eax
	movq	4(%r14), %r13
	movl	$80, %edi
	movl	%eax, 8(%rsp)
	movl	4(%r14), %eax
	movl	%eax, 12(%rsp)
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 48(%rax)
	movups	%xmm0, 64(%rax)
	movl	$7, (%rax)
	movq	%r13, 4(%rax)
	movl	$1, 12(%rax)
	movl	%ebx, 48(%rax)
	movq	%r14, 56(%rax)
	movq	%rbp, 64(%rax)
	movups	%xmm0, 16(%rax)
	movups	%xmm0, 32(%rax)
	movl	12(%r14), %ecx
	cmpl	$511, %ecx
	ja	.L452
	testl	%ecx, %ecx
	je	.L442
	addl	$1, %ecx
	movl	%ecx, 12(%rax)
.L442:
	movl	12(%rbp), %edx
	cmpl	$511, %edx
	ja	.L452
	cmpl	12(%rax), %edx
	jb	.L444
	addl	$1, %edx
	movl	%edx, 12(%rax)
.L444:
	movl	40(%r15), %ebx
	movq	%rax, %r14
	xorl	%r13d, %r13d
	leal	-22(%rbx), %eax
	cmpl	$33, %eax
	jbe	.L456
	cmpl	%r13d, 4(%rsp)
	jle	.L439
.L454:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L457
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r14, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L455:
	.cfi_restore_state
	movq	%rbp, %rdx
	leal	1(%r13), %esi
	movq	%r15, %rdi
	call	parse_bin_rhs
	movq	%rax, %rbp
	jmp	.L440
.L452:
	movl	8(%rsp), %edx
	movl	12(%rsp), %esi
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L457:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE89:
	.size	parse_bin_rhs, .-parse_bin_rhs
	.section	.rodata.str1.8
	.align 8
.LC29:
	.string	"left side of '%s' must be an lvalue at %d:%d"
	.text
	.p2align 4
	.globl	parse_assignment
	.type	parse_assignment, @function
parse_assignment:
.LFB91:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$104, %rsp
	.cfi_def_cfa_offset 160
	movq	%fs:40, %rax
	movq	%rax, 88(%rsp)
	movl	96(%rdi), %eax
	cmpl	$511, %eax
	ja	.L502
	addl	$1, %eax
	movl	%eax, 96(%rdi)
	call	parse_unary
	movl	$1, %esi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	call	parse_bin_rhs
	movl	40(%rbx), %r14d
	movq	%rax, %rbp
	cmpl	$56, %r14d
	je	.L503
	cmpl	$21, %r14d
	je	.L467
	leal	-38(%r14), %eax
	cmpl	$14, %eax
	ja	.L468
.L467:
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm3
	movups	%xmm3, 40(%rbx)
	movdqu	32(%rsp), %xmm4
	movups	%xmm4, 56(%rbx)
	movdqu	48(%rsp), %xmm5
	movups	%xmm5, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	testq	%rbp, %rbp
	je	.L469
.L475:
	movl	0(%rbp), %eax
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L470
	cmpl	$5, %eax
	jne	.L469
	cmpl	$32, 48(%rbp)
	je	.L470
.L469:
	movl	8(%rbp), %r12d
	movl	4(%rbp), %ebx
	movl	%r14d, %edi
	call	tk_name@PLT
	leaq	.LC29(%rip), %rdi
	movq	%rax, %rsi
	movl	%r12d, %ecx
	movl	%ebx, %edx
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4,,10
	.p2align 3
.L470:
	movq	%rbx, %rdi
	call	parse_assignment
	movq	4(%rbp), %xmm1
	movl	$80, %edi
	movq	%rax, %r15
	pshufd	$0xe5, %xmm1, %xmm2
	movd	%xmm1, %r12d
	movq	%xmm1, (%rsp)
	movd	%xmm2, %r13d
	call	xmalloc@PLT
	movq	(%rsp), %xmm1
	pxor	%xmm0, %xmm0
	movups	%xmm0, 48(%rax)
	movups	%xmm0, 64(%rax)
	movl	$8, (%rax)
	movl	$1, 12(%rax)
	movl	%r14d, 48(%rax)
	movq	%rbp, 56(%rax)
	movq	%r15, 64(%rax)
	movups	%xmm0, 16(%rax)
	movups	%xmm0, 32(%rax)
	movq	%xmm1, 4(%rax)
	movl	12(%rbp), %edx
	cmpl	$511, %edx
	ja	.L501
	testl	%edx, %edx
	je	.L472
	addl	$1, %edx
	movl	%edx, 12(%rax)
.L472:
	movl	12(%r15), %edx
	cmpl	$511, %edx
	ja	.L501
	cmpl	12(%rax), %edx
	jb	.L478
	addl	$1, %edx
	movl	%edx, 12(%rax)
.L478:
	movq	%rax, %rbp
.L468:
	subl	$1, 96(%rbx)
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L504
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L503:
	.cfi_restore_state
	leaq	40(%rbx), %r12
	leaq	16(%rsp), %r13
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm6
	movq	%rbx, %rdi
	movups	%xmm6, 40(%rbx)
	movdqu	32(%rsp), %xmm7
	movups	%xmm7, 56(%rbx)
	movdqu	48(%rsp), %xmm6
	movups	%xmm6, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	call	parse_assignment
	movl	$57, %esi
	movq	%rbx, %rdi
	movq	%rax, %r15
	call	expect
	movq	%rbx, %rdi
	call	parse_assignment
	movq	4(%rbp), %xmm0
	movl	$80, %edi
	movq	%rax, %r14
	pshufd	$0xe5, %xmm0, %xmm7
	movd	%xmm0, 12(%rsp)
	movq	%xmm0, (%rsp)
	movd	%xmm7, 8(%rsp)
	call	xmalloc@PLT
	movq	(%rsp), %xmm0
	pxor	%xmm1, %xmm1
	movups	%xmm1, 64(%rax)
	movl	$9, (%rax)
	movl	$1, 12(%rax)
	movq	%rbp, 48(%rax)
	movq	%r15, 56(%rax)
	movq	%r14, 64(%rax)
	movups	%xmm1, 16(%rax)
	movups	%xmm1, 32(%rax)
	movq	%xmm0, 4(%rax)
	movl	12(%rbp), %esi
	cmpl	$511, %esi
	ja	.L500
	testl	%esi, %esi
	je	.L462
	addl	$1, %esi
	movl	%esi, 12(%rax)
.L462:
	movl	12(%r15), %ecx
	cmpl	$511, %ecx
	ja	.L500
	cmpl	12(%rax), %ecx
	jb	.L464
	addl	$1, %ecx
	movl	%ecx, 12(%rax)
.L464:
	movl	12(%r14), %edx
	cmpl	$511, %edx
	ja	.L500
	cmpl	12(%rax), %edx
	jb	.L466
	addl	$1, %edx
	movl	%edx, 12(%rax)
.L466:
	movl	40(%rbx), %r14d
	cmpl	$21, %r14d
	je	.L476
	leal	-38(%r14), %edx
	cmpl	$14, %edx
	ja	.L478
.L476:
	movq	%r12, %rdi
	movq	%rax, (%rsp)
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm6
	movq	(%rsp), %rbp
	movups	%xmm6, 40(%rbx)
	movdqu	32(%rsp), %xmm7
	movups	%xmm7, 56(%rbx)
	movdqu	48(%rsp), %xmm6
	movups	%xmm6, 72(%rbx)
	movq	64(%rsp), %rdx
	movq	%rdx, 88(%rbx)
	jmp	.L475
.L502:
	movl	84(%rdi), %esi
	movl	80(%rdi), %edi
	call	enter_parse.part.0.isra.0
.L501:
	movl	%r13d, %edx
	movl	%r12d, %esi
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L504:
	call	__stack_chk_fail@PLT
.L500:
	movl	8(%rsp), %edx
	movl	12(%rsp), %esi
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.cfi_endproc
.LFE91:
	.size	parse_assignment, .-parse_assignment
	.section	.rodata.str1.8
	.align 8
.LC30:
	.string	"expected initializer constant or name"
	.text
	.p2align 4
	.globl	parse_init_elem
	.type	parse_init_elem, @function
parse_init_elem:
.LFB83:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	subq	$88, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	cmpl	$15, 40(%rdi)
	je	.L524
	movq	80(%rdi), %r12
	movl	$40, %edi
	call	xmalloc@PLT
	movl	$0, (%rax)
	movq	%rax, %rbp
	movq	%r12, 4(%rax)
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L508
	movl	40(%rbx), %eax
	cmpl	$31, %eax
	je	.L509
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L520
	andl	$-3, %eax
	cmpl	$1, %eax
	jne	.L525
.L520:
	movq	%rbx, %rdi
	call	parse_primary
.L514:
	movq	%rax, 16(%rbp)
	movl	40(%rbx), %eax
	subl	$17, %eax
	cmpl	$1, %eax
	ja	.L526
.L505:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L523
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbp, %rax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L508:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	parse_assignment
	movq	%rax, 16(%rbp)
	jmp	.L505
	.p2align 4,,10
	.p2align 3
.L524:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L523
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	parse_init_list
	.p2align 4,,10
	.p2align 3
.L509:
	.cfi_restore_state
	leaq	40(%rbx), %r13
	movq	%r13, %rdi
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm1
	movl	(%rsp), %eax
	movups	%xmm1, 40(%rbx)
	movdqu	16(%rsp), %xmm2
	subl	$2, %eax
	andl	$-3, %eax
	movups	%xmm2, 56(%rbx)
	movdqu	32(%rsp), %xmm3
	movups	%xmm3, 72(%rbx)
	movq	48(%rsp), %rdx
	movq	%rdx, 88(%rbx)
	je	.L512
.L513:
	movq	104(%rbx), %rsi
	leaq	.LC30(%rip), %rdx
	movq	%r13, %rdi
	xorl	%eax, %eax
	call	error_at@PLT
	.p2align 4,,10
	.p2align 3
.L512:
	movq	%rbx, %rdi
	call	parse_primary
	movl	$80, %edi
	movq	%rax, 16(%rbp)
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 48(%rax)
	movups	%xmm0, 16(%rax)
	movups	%xmm0, 32(%rax)
	movups	%xmm0, 64(%rax)
	movq	16(%rbp), %rdx
	movl	$5, (%rax)
	movq	%r12, 4(%rax)
	movl	$1, 12(%rax)
	movl	$31, 48(%rax)
	movq	%rdx, 56(%rax)
	jmp	.L514
.L523:
	call	__stack_chk_fail@PLT
.L526:
	movq	104(%rbx), %rsi
	leaq	40(%rbx), %rdi
	leaq	.LC30(%rip), %rdx
	xorl	%eax, %eax
	call	error_at@PLT
.L525:
	leaq	40(%rbx), %r13
	jmp	.L513
	.cfi_endproc
.LFE83:
	.size	parse_init_elem, .-parse_init_elem
	.section	.rodata.str1.8
	.align 8
.LC31:
	.string	"braced external initializer is outside Thompson B72"
	.text
	.p2align 4
	.globl	parse_init_list
	.type	parse_init_list, @function
parse_init_list:
.LFB82:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	subq	$80, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	movl	96(%rdi), %eax
	cmpl	$511, %eax
	ja	.L537
	addl	$1, %eax
	movl	%eax, 96(%rdi)
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L538
	movl	$15, %esi
	movq	80(%rdi), %r12
	call	expect
	movl	$40, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%r12, 4(%rax)
	cmpl	$16, 40(%rbx)
	movq	%rax, %rbp
	leaq	16(%rax), %r12
	movl	$1, (%rax)
	movq	$0, 16(%rax)
	movups	%xmm0, 24(%rax)
	je	.L539
.L530:
	movq	%rbx, %rdi
	call	parse_init_elem
	movq	%r12, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	cmpl	$17, 40(%rbx)
	je	.L532
	movl	$16, %esi
	movq	%rbx, %rdi
	call	expect
.L531:
	subl	$1, 96(%rbx)
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L540
	addq	$80, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%rbp, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L539:
	.cfi_restore_state
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm1
	movups	%xmm1, 40(%rbx)
	movdqu	16(%rsp), %xmm2
	movups	%xmm2, 56(%rbx)
	movdqu	32(%rsp), %xmm3
	movups	%xmm3, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	jmp	.L531
	.p2align 4,,10
	.p2align 3
.L532:
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm4
	movups	%xmm4, 40(%rbx)
	movdqu	16(%rsp), %xmm5
	movups	%xmm5, 56(%rbx)
	movdqu	32(%rsp), %xmm6
	movups	%xmm6, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	jmp	.L530
.L540:
	call	__stack_chk_fail@PLT
.L538:
	movq	104(%rdi), %rsi
	leaq	.LC31(%rip), %rdx
	leaq	40(%rdi), %rdi
	xorl	%eax, %eax
	call	error_at@PLT
.L537:
	movl	84(%rdi), %esi
	movl	80(%rdi), %edi
	call	enter_parse.part.0.isra.0
	.cfi_endproc
.LFE82:
	.size	parse_init_list, .-parse_init_list
	.p2align 4
	.globl	parse_comma_init_list
	.type	parse_comma_init_list, @function
parse_comma_init_list:
.LFB84:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	xorl	%ebp, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$88, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	movl	40(%rdi), %eax
	cmpl	$53, %eax
	ja	.L541
	movabsq	$9007205697200158, %rdx
	btq	%rax, %rdx
	jnc	.L541
	movq	80(%rdi), %r12
	movq	%rdi, %rbx
	movl	$40, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	leaq	40(%rbx), %r13
	movl	$1, (%rax)
	movq	%rax, %rbp
	movq	$0, 16(%rax)
	movq	%r12, 4(%rax)
	leaq	16(%rax), %r12
	movups	%xmm0, 24(%rax)
.L543:
	movq	%rbx, %rdi
	call	parse_init_elem
	movq	%r12, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	cmpl	$17, 40(%rbx)
	je	.L549
.L541:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L550
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbp, %rax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L549:
	.cfi_restore_state
	movq	%r13, %rdi
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm1
	movups	%xmm1, 40(%rbx)
	movdqu	16(%rsp), %xmm2
	movups	%xmm2, 56(%rbx)
	movdqu	32(%rsp), %xmm3
	movups	%xmm3, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	jmp	.L543
.L550:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE84:
	.size	parse_comma_init_list, .-parse_comma_init_list
	.section	.rodata.str1.1
.LC32:
	.string	"expected identifier at %d:%d"
	.section	.rodata.str1.8
	.align 8
.LC33:
	.string	"negative vector bound at %d:%d"
	.align 8
.LC34:
	.string	"expected literal vector bound constant at %d:%d"
	.align 8
.LC35:
	.string	"external '=' initializer is outside Thompson B72"
	.align 8
.LC36:
	.string	"bad external definition after '%s' at %d:%d"
	.text
	.p2align 4
	.globl	parse_extern_var_def
	.type	parse_extern_var_def, @function
parse_extern_var_def:
.LFB65:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	subq	$88, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	cmpl	$1, 40(%rdi)
	jne	.L581
	movl	$64, %edi
	call	xmalloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L582
	pxor	%xmm0, %xmm0
	leaq	40(%rbx), %r12
	movq	%rsp, %r13
	movups	%xmm0, (%rax)
	movups	%xmm0, 16(%rax)
	movups	%xmm0, 32(%rax)
	movups	%xmm0, 48(%rax)
	movq	48(%rbx), %rdi
	call	sdup@PLT
	movq	%r12, %rdi
	movq	%rax, 16(%rbp)
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm1
	movl	(%rsp), %eax
	movups	%xmm1, 40(%rbx)
	movdqu	16(%rsp), %xmm2
	movups	%xmm2, 56(%rbx)
	movdqu	32(%rsp), %xmm3
	movups	%xmm3, 72(%rbx)
	movq	48(%rsp), %rdx
	movq	%rdx, 88(%rbx)
	cmpl	$19, %eax
	je	.L554
	cmpl	$15, %eax
	je	.L583
	cmpl	$18, %eax
	je	.L584
	cmpl	$21, %eax
	je	.L585
	movq	%rbx, %rdi
	call	parse_comma_init_list
	testq	%rax, %rax
	je	.L586
	cmpl	$2, 24(%rbp)
	je	.L578
	movl	$1, 24(%rbp)
.L578:
	movq	%rax, 56(%rbp)
	movl	$18, %esi
	movq	%rbx, %rdi
	call	expect
.L551:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L587
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbp, %rax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L554:
	.cfi_restore_state
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm4
	movups	%xmm4, 40(%rbx)
	movdqu	16(%rsp), %xmm5
	movups	%xmm5, 56(%rbx)
	movdqu	32(%rsp), %xmm6
	movups	%xmm6, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	movl	40(%rbx), %eax
	movl	$2, 24(%rbp)
	cmpl	$20, %eax
	je	.L588
	movl	g_strict(%rip), %edx
	testl	%edx, %edx
	je	.L559
	cmpl	$31, %eax
	je	.L589
	subl	$2, %eax
	andl	$-3, %eax
	jne	.L579
	movq	%rbx, %rdi
	call	parse_primary
	cmpl	$20, 40(%rbx)
	movq	%rax, 32(%rbp)
	jne	.L579
.L562:
	movl	$20, %esi
	movq	%rbx, %rdi
	call	expect
.L558:
	cmpl	$15, 40(%rbx)
	movq	%rbx, %rdi
	je	.L580
	call	parse_comma_init_list
	jmp	.L578
	.p2align 4,,10
	.p2align 3
.L583:
	movl	$1, 24(%rbp)
	movq	%rbx, %rdi
.L580:
	call	parse_init_list
	jmp	.L578
	.p2align 4,,10
	.p2align 3
.L584:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm7
	movups	%xmm7, 40(%rbx)
	movdqu	16(%rsp), %xmm7
	movups	%xmm7, 56(%rbx)
	movdqu	32(%rsp), %xmm4
	movups	%xmm4, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	movl	$0, 24(%rbp)
	movq	$0, 56(%rbp)
	jmp	.L551
	.p2align 4,,10
	.p2align 3
.L585:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm5
	movups	%xmm5, 40(%rbx)
	movdqu	16(%rsp), %xmm6
	movups	%xmm6, 56(%rbx)
	movdqu	32(%rsp), %xmm7
	movups	%xmm7, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L590
	movl	$0, 24(%rbp)
	movl	$40, %edi
	movq	80(%rbx), %r13
	call	xmalloc@PLT
	movq	%rbx, %rdi
	movq	%r13, 4(%rax)
	movq	%rax, %r12
	movl	$0, (%rax)
	call	parse_expr
	movl	$18, %esi
	movq	%rbx, %rdi
	movq	%rax, 16(%r12)
	movq	%r12, 56(%rbp)
	call	expect
	jmp	.L551
	.p2align 4,,10
	.p2align 3
.L559:
	movq	%rbx, %rdi
	call	parse_expr
	movq	%rax, 32(%rbp)
	jmp	.L562
	.p2align 4,,10
	.p2align 3
.L588:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm5
	movups	%xmm5, 40(%rbx)
	movdqu	16(%rsp), %xmm6
	movups	%xmm6, 56(%rbx)
	movdqu	32(%rsp), %xmm4
	movups	%xmm4, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	movl	$1, 40(%rbp)
	jmp	.L558
.L581:
	movl	84(%rdi), %edx
	movl	80(%rdi), %esi
	leaq	.LC32(%rip), %rdi
	call	dief@PLT
.L587:
	call	__stack_chk_fail@PLT
.L582:
	leaq	.LC13(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L586:
	movl	84(%rbx), %ecx
	movl	80(%rbx), %edx
	leaq	.LC36(%rip), %rdi
	xorl	%eax, %eax
	movq	16(%rbp), %rsi
	call	dief@PLT
.L579:
	movl	84(%rbx), %edx
	movl	80(%rbx), %esi
	leaq	.LC34(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L590:
	movq	104(%rbx), %rsi
	leaq	.LC35(%rip), %rdx
	movq	%r12, %rdi
	xorl	%eax, %eax
	call	error_at@PLT
.L589:
	movl	84(%rbx), %edx
	movl	80(%rbx), %esi
	leaq	.LC33(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.cfi_endproc
.LFE65:
	.size	parse_extern_var_def, .-parse_extern_var_def
	.section	.rodata.str1.8
	.align 8
.LC37:
	.string	"top-level external declaration is outside Thompson B72"
	.align 8
.LC38:
	.string	"top-level auto is outside Thompson B72"
	.align 8
.LC39:
	.string	"unexpected token at top level: %s"
	.text
	.p2align 4
	.globl	parse_program_ast
	.type	parse_program_ast, @function
parse_program_ast:
.LFB62:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp
	movl	$24, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	call	xmalloc@PLT
	movl	40(%rbp), %esi
	pxor	%xmm0, %xmm0
	movq	$0, (%rax)
	movq	%rax, %r12
	movups	%xmm0, 8(%rax)
	testl	%esi, %esi
	jne	.L600
	jmp	.L591
	.p2align 4,,10
	.p2align 3
.L593:
	cmpl	$5, %edi
	je	.L603
	cmpl	$1, %edi
	jne	.L598
	movq	%rbp, %rdi
	call	peek_next_kind
	cmpl	$13, %eax
	je	.L604
	movl	$2, (%rbx)
	movq	%rbp, %rdi
	call	parse_extern_var_def
	movq	%rax, 8(%rbx)
.L595:
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	vec_push@PLT
	movl	40(%rbp), %eax
	testl	%eax, %eax
	je	.L591
.L600:
	movl	$16, %edi
	call	xmalloc@PLT
	movl	40(%rbp), %edi
	movq	%rax, %rbx
	cmpl	$12, %edi
	jne	.L593
	movl	g_strict(%rip), %ecx
	testl	%ecx, %ecx
	jne	.L605
	movl	$3, (%rax)
	movq	%rbp, %rdi
	call	parse_extern_decl
	movq	%rax, 8(%rbx)
	jmp	.L595
	.p2align 4,,10
	.p2align 3
.L603:
	movl	g_strict(%rip), %edx
	testl	%edx, %edx
	jne	.L606
	movl	$0, (%rax)
	movq	%rbp, %rdi
	call	parse_auto_decl
	movq	%rax, 8(%rbx)
	jmp	.L595
	.p2align 4,,10
	.p2align 3
.L604:
	movl	$1, (%rbx)
	movq	%rbp, %rdi
	call	parse_function
	movq	%rax, 8(%rbx)
	jmp	.L595
	.p2align 4,,10
	.p2align 3
.L591:
	movq	%r12, %rax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L598:
	.cfi_restore_state
	call	tk_name@PLT
	leaq	.LC39(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
.L606:
	movq	104(%rbp), %rsi
	leaq	40(%rbp), %rdi
	leaq	.LC38(%rip), %rdx
	xorl	%eax, %eax
	call	error_at@PLT
.L605:
	movq	104(%rbp), %rsi
	leaq	40(%rbp), %rdi
	leaq	.LC37(%rip), %rdx
	xorl	%eax, %eax
	call	error_at@PLT
	.cfi_endproc
.LFE62:
	.size	parse_program_ast, .-parse_program_ast
	.section	.rodata
	.align 32
	.type	CSWTCH.37, @object
	.size	CSWTCH.37, 34
CSWTCH.37:
	.byte	5
	.byte	5
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	7
	.byte	7
	.byte	8
	.byte	8
	.byte	9
	.byte	9
	.byte	9
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	4
	.byte	3
	.byte	1
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
