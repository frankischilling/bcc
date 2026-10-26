	.file	"parser.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"internal: null const expr"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"non-constant unary op in const expr at %d:%d"
	.align 8
.LC2:
	.string	"division by zero in const expr at %d:%d"
	.align 8
.LC3:
	.string	"mod by zero in const expr at %d:%d"
	.align 8
.LC4:
	.string	"non-constant binary op in const expr at %d:%d"
	.align 8
.LC5:
	.string	"non-constant expression in const expr at %d:%d"
	.text
	.p2align 4
	.type	eval_const_expr, @function
eval_const_expr:
.LFB36:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movl	%esi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	testq	%rdi, %rdi
	je	.L84
.L2:
	movl	(%rbx), %eax
	cmpl	$5, %eax
	je	.L3
	cmpl	$7, %eax
	je	.L4
	testl	%eax, %eax
	jne	.L5
	movq	48(%rbx), %rsi
	cmpl	$63, %ebp
	jg	.L1
.L77:
	movq	$-1, %rax
	movl	%ebp, %ecx
	salq	%cl, %rax
	notq	%rax
	andq	%rax, %rsi
	leal	-1(%rbp), %eax
	btq	%rax, %rsi
	jnc	.L1
	movl	$1, %eax
	salq	%cl, %rax
	subq	%rax, %rsi
.L1:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rsi, %rax
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
.L3:
	.cfi_restore_state
	movq	56(%rbx), %rdi
	movl	%ebp, %esi
	call	eval_const_expr
	movl	48(%rbx), %edx
	cmpl	$31, %edx
	je	.L7
	cmpl	$35, %edx
	je	.L8
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	leaq	.LC1(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L4:
	movq	56(%rbx), %rdi
	movl	%ebp, %esi
	call	eval_const_expr
	movq	64(%rbx), %rdi
	movl	%ebp, %esi
	movq	%rax, %r12
	call	eval_const_expr
	movq	%rax, %r13
	movl	48(%rbx), %eax
	leal	-22(%rax), %edx
	cmpl	$33, %edx
	ja	.L11
	leaq	.L13(%rip), %rcx
	movslq	(%rcx,%rdx,4), %rax
	addq	%rcx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L13:
	.long	.L26-.L13
	.long	.L25-.L13
	.long	.L24-.L13
	.long	.L23-.L13
	.long	.L22-.L13
	.long	.L21-.L13
	.long	.L11-.L13
	.long	.L11-.L13
	.long	.L20-.L13
	.long	.L19-.L13
	.long	.L18-.L13
	.long	.L17-.L13
	.long	.L16-.L13
	.long	.L11-.L13
	.long	.L11-.L13
	.long	.L11-.L13
	.long	.L11-.L13
	.long	.L11-.L13
	.long	.L11-.L13
	.long	.L11-.L13
	.long	.L11-.L13
	.long	.L11-.L13
	.long	.L11-.L13
	.long	.L11-.L13
	.long	.L11-.L13
	.long	.L11-.L13
	.long	.L11-.L13
	.long	.L11-.L13
	.long	.L11-.L13
	.long	.L11-.L13
	.long	.L11-.L13
	.long	.L15-.L13
	.long	.L14-.L13
	.long	.L12-.L13
	.text
	.p2align 4,,10
	.p2align 3
.L11:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	leaq	.LC4(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4
	.p2align 3
.L5:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	leaq	.LC5(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L35:
	xorl	%esi, %esi
	jmp	.L1
	.p2align 4,,10
	.p2align 3
.L7:
	negq	%rax
	movq	%rax, %rsi
	cmpl	$63, %ebp
	jg	.L1
	jmp	.L77
	.p2align 4,,10
	.p2align 3
.L84:
	leaq	.LC0(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L2
	.p2align 4,,10
	.p2align 3
.L8:
	xorl	%esi, %esi
	testq	%rax, %rax
	sete	%sil
	jmp	.L1
.L21:
	xorl	%esi, %esi
	cmpq	%r13, %r12
	setge	%sil
	jmp	.L1
.L20:
	leaq	(%r12,%r13), %rsi
	cmpl	$63, %ebp
	jg	.L1
	jmp	.L77
.L19:
	movq	%r12, %rsi
	subq	%r13, %rsi
	cmpl	$63, %ebp
	jg	.L1
	jmp	.L77
.L18:
	movq	%r12, %rsi
	imulq	%r13, %rsi
	cmpl	$63, %ebp
	jg	.L1
	jmp	.L77
.L17:
	testq	%r13, %r13
	je	.L85
	movabsq	$-9223372036854775808, %rsi
	cmpq	%rsi, %r12
	jne	.L31
	cmpq	$-1, %r13
	je	.L1
.L31:
	movq	%r12, %rax
	cqto
	idivq	%r13
	movq	%rax, %rsi
	cmpl	$63, %ebp
	jg	.L1
	jmp	.L77
.L16:
	testq	%r13, %r13
	je	.L86
	movabsq	$-9223372036854775808, %rax
	cmpq	%rax, %r12
	jne	.L34
	cmpq	$-1, %r13
	je	.L35
.L34:
	movq	%r12, %rax
	cqto
	idivq	%r13
	movq	%rdx, %rsi
	cmpl	$63, %ebp
	jg	.L1
	jmp	.L77
.L22:
	xorl	%esi, %esi
	cmpq	%r13, %r12
	setg	%sil
	jmp	.L1
.L12:
	xorl	%esi, %esi
	orq	%r12, %r13
	setne	%sil
	jmp	.L1
.L23:
	xorl	%esi, %esi
	cmpq	%r13, %r12
	setle	%sil
	jmp	.L1
.L14:
	movq	%r12, %rsi
	orq	%r13, %rsi
	jmp	.L1
.L15:
	movq	%r12, %rsi
	andq	%r13, %rsi
	jmp	.L1
.L26:
	xorl	%esi, %esi
	cmpq	%r13, %r12
	sete	%sil
	jmp	.L1
.L25:
	xorl	%esi, %esi
	cmpq	%r13, %r12
	setne	%sil
	jmp	.L1
.L24:
	xorl	%esi, %esi
	cmpq	%r13, %r12
	setl	%sil
	jmp	.L1
.L86:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	leaq	.LC3(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L34
.L85:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	leaq	.LC2(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L31
	.cfi_endproc
.LFE36:
	.size	eval_const_expr, .-eval_const_expr
	.p2align 4
	.globl	next
	.type	next, @function
next:
.LFB14:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	leaq	40(%rdi), %rdi
	subq	$64, %rsp
	.cfi_def_cfa_offset 80
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	addq	$64, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE14:
	.size	next, .-next
	.section	.rodata.str1.1
.LC6:
	.string	"expected %s, got %s"
	.text
	.p2align 4
	.globl	expect
	.type	expect, @function
expect:
.LFB15:
	.cfi_startproc
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
	leaq	40(%rbx), %r12
	subq	$72, %rsp
	.cfi_def_cfa_offset 112
	movl	40(%rdi), %edi
	cmpl	%esi, %edi
	je	.L90
	movl	%esi, %ebp
	call	tk_name@PLT
	movl	%ebp, %edi
	movq	%rax, %r13
	call	tk_name@PLT
	movq	96(%rbx), %rsi
	movq	%r13, %r8
	movq	%r12, %rdi
	movq	%rax, %rcx
	leaq	.LC6(%rip), %rdx
	xorl	%eax, %eax
	call	error_at@PLT
.L90:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	addq	$72, %rsp
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
	.cfi_endproc
.LFE15:
	.size	expect, .-expect
	.p2align 4
	.globl	accept
	.type	accept, @function
accept:
.LFB16:
	.cfi_startproc
	cmpl	%esi, 40(%rdi)
	je	.L101
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L101:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	leaq	40(%rdi), %rdi
	subq	$64, %rsp
	.cfi_def_cfa_offset 80
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	addq	$64, %rsp
	.cfi_def_cfa_offset 16
	movl	$1, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE16:
	.size	accept, .-accept
	.p2align 4
	.globl	new_expr
	.type	new_expr, @function
new_expr:
.LFB17:
	.cfi_startproc
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
	movl	$0, 76(%rax)
	movl	%r12d, (%rax)
	movl	%ebp, 4(%rax)
	movl	%ebx, 8(%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 28(%rax)
	movups	%xmm0, 44(%rax)
	movups	%xmm0, 60(%rax)
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE17:
	.size	new_expr, .-new_expr
	.p2align 4
	.globl	new_stmt
	.type	new_stmt, @function
new_stmt:
.LFB18:
	.cfi_startproc
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
.LFE18:
	.size	new_stmt, .-new_stmt
	.p2align 4
	.globl	new_init
	.type	new_init, @function
new_init:
.LFB19:
	.cfi_startproc
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
.LFE19:
	.size	new_init, .-new_init
	.p2align 4
	.globl	peek_next_kind
	.type	peek_next_kind, @function
peek_next_kind:
.LFB24:
	.cfi_startproc
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
	movq	32(%rdi), %rax
	leaq	48(%rsp), %rbx
	movq	g_compilation_arena(%rip), %r12
	movq	%rsp, %rsi
	movq	$0, g_compilation_arena(%rip)
	movaps	%xmm0, (%rsp)
	movdqu	16(%rdi), %xmm0
	movq	%rbx, %rdi
	movq	%rax, 32(%rsp)
	movaps	%xmm0, 16(%rsp)
	call	lx_next@PLT
	movl	48(%rsp), %ebp
	movq	%rbx, %rdi
	call	tok_free@PLT
	movq	%r12, g_compilation_arena(%rip)
	addq	$112, %rsp
	.cfi_def_cfa_offset 32
	movl	%ebp, %eax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	peek_next_kind, .-peek_next_kind
	.section	.rodata.str1.8
	.align 8
.LC7:
	.string	"expected identifier in extrn at %d:%d"
	.text
	.p2align 4
	.globl	parse_extrn_stmt
	.type	parse_extrn_stmt, @function
parse_extrn_stmt:
.LFB34:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	$12, %esi
	leaq	.LC7(%rip), %r15
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
	leaq	40(%rbx), %r12
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movq	80(%rdi), %rbp
	call	expect
	movl	$48, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movl	$7, (%rax)
	movq	%rax, %r14
	leaq	16(%rax), %r13
	movq	$0, 16(%rax)
	movq	%rbp, 4(%rax)
	movq	%rsp, %rbp
	movups	%xmm0, 24(%rax)
.L113:
	cmpl	$1, 40(%rbx)
	je	.L111
	movl	84(%rbx), %edx
	movl	80(%rbx), %esi
	movq	%r15, %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L111:
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
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movd	%xmm0, %eax
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rdx
	movq	%rdx, 88(%rbx)
	cmpl	$17, %eax
	je	.L117
	movq	%rbx, %rdi
	movl	$18, %esi
	call	expect
	addq	$72, %rsp
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
.L117:
	.cfi_restore_state
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	jmp	.L113
	.cfi_endproc
.LFE34:
	.size	parse_extrn_stmt, .-parse_extrn_stmt
	.p2align 4
	.globl	parse_expr
	.type	parse_expr, @function
parse_expr:
.LFB54:
	.cfi_startproc
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
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	call	parse_assignment
	cmpl	$17, 40(%rbx)
	movq	%rax, %rbp
	je	.L124
.L118:
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
.L124:
	.cfi_restore_state
	leaq	16(%rsp), %rax
	leaq	40(%rbx), %r13
	movq	%rax, 8(%rsp)
.L119:
	movq	%r13, %rdi
	movq	%rbp, %r15
	call	tok_free@PLT
	movq	8(%rsp), %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm1
	movq	%rbx, %rdi
	movups	%xmm1, 40(%rbx)
	movdqu	32(%rsp), %xmm1
	movups	%xmm1, 56(%rbx)
	movdqu	48(%rsp), %xmm1
	movups	%xmm1, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	call	parse_assignment
	movq	4(%rbp), %r12
	movl	$80, %edi
	movq	%rax, %r14
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 44(%rax)
	movq	%rax, %rbp
	movups	%xmm0, 60(%rax)
	movl	$0, 76(%rax)
	movq	%r12, 4(%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 28(%rax)
	cmpl	$17, 40(%rbx)
	movl	$10, (%rax)
	movq	%r15, 48(%rax)
	movq	%r14, 56(%rax)
	jne	.L118
	jmp	.L119
	.cfi_endproc
.LFE54:
	.size	parse_expr, .-parse_expr
	.section	.rodata.str1.8
	.align 8
.LC8:
	.string	"expected identifier after auto at %d:%d"
	.align 8
.LC9:
	.string	"expected identifier in auto decl at %d:%d"
	.section	.rodata.str1.1
.LC10:
	.string	"out of memory"
	.section	.rodata.str1.8
	.align 8
.LC11:
	.string	"bracketed auto vectors are outside Thompson B72; use auto name size"
	.text
	.p2align 4
	.globl	parse_auto_decl
	.type	parse_auto_decl, @function
parse_auto_decl:
.LFB26:
	.cfi_startproc
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
	call	expect
	movl	$48, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movl	$2, (%rax)
	movq	%rax, %rbp
	movq	%r12, 4(%rax)
	movq	$0, 16(%rax)
	movups	%xmm0, 24(%rax)
	movl	40(%rbx), %eax
	cmpl	$1, %eax
	je	.L126
	movl	84(%rbx), %edx
	movl	80(%rbx), %esi
	xorl	%eax, %eax
	leaq	.LC8(%rip), %rdi
	call	dief@PLT
	movl	40(%rbx), %eax
.L126:
	leaq	40(%rbx), %r13
	leaq	16(%rsp), %r14
	leaq	16(%rbp), %r15
.L134:
	cmpl	$1, %eax
	je	.L127
	movl	84(%rbx), %edx
	movl	80(%rbx), %esi
	leaq	.LC9(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L127:
	movl	$16, %edi
	call	xmalloc@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L144
.L128:
	movq	48(%rbx), %rdi
	call	sdup@PLT
	movq	%r13, %rdi
	movq	$0, 8(%r12)
	movq	%rax, (%r12)
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r14, %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movd	%xmm0, %eax
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	64(%rsp), %rdx
	movq	%rdx, 88(%rbx)
	cmpl	$19, %eax
	je	.L129
	subl	$2, %eax
	andl	$-3, %eax
	je	.L145
.L131:
	movq	%r12, %rsi
	movq	%r15, %rdi
	call	vec_push@PLT
	cmpl	$17, 40(%rbx)
	je	.L146
	movq	%rbx, %rdi
	movl	$18, %esi
	call	expect
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
.L145:
	.cfi_restore_state
	movq	80(%rbx), %rcx
	movl	$80, %edi
	movq	%rcx, 8(%rsp)
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	8(%rsp), %rcx
	movq	%r13, %rdi
	movups	%xmm0, 44(%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 28(%rax)
	movups	%xmm0, 60(%rax)
	movl	$0, 76(%rax)
	movq	72(%rbx), %rdx
	movl	$0, (%rax)
	movq	%rcx, 4(%rax)
	movq	%rax, 8(%r12)
	movq	%rdx, 48(%rax)
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r14, %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	jmp	.L131
	.p2align 4,,10
	.p2align 3
.L144:
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L128
	.p2align 4,,10
	.p2align 3
.L146:
	movq	%r13, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r14, %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movd	%xmm0, %eax
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	64(%rsp), %rdx
	movq	%rdx, 88(%rbx)
	jmp	.L134
	.p2align 4,,10
	.p2align 3
.L129:
	movq	%r13, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r14, %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	testb	$-128, g_extensions(%rip)
	je	.L147
.L132:
	movq	%rbx, %rdi
	call	parse_expr
	movl	$20, %esi
	movq	%rbx, %rdi
	movq	%rax, 8(%r12)
	call	expect
	jmp	.L131
	.p2align 4,,10
	.p2align 3
.L147:
	movq	96(%rbx), %rsi
	leaq	.LC11(%rip), %rdx
	movq	%r13, %rdi
	xorl	%eax, %eax
	call	error_at@PLT
	jmp	.L132
	.cfi_endproc
.LFE26:
	.size	parse_auto_decl, .-parse_auto_decl
	.section	.rodata.str1.8
	.align 8
.LC12:
	.string	"expected identifier after extrn at %d:%d"
	.align 8
.LC13:
	.string	"extrn declarations are only allowed for variables, not functions at %d:%d"
	.text
	.p2align 4
	.globl	parse_extern_decl
	.type	parse_extern_decl, @function
parse_extern_decl:
.LFB29:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movl	$12, %esi
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$72, %rsp
	.cfi_def_cfa_offset 112
	call	expect
	cmpl	$1, 40(%r13)
	je	.L149
	movl	84(%r13), %edx
	movl	80(%r13), %esi
	leaq	.LC12(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L149:
	movl	$64, %edi
	call	xmalloc@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L155
.L150:
	pxor	%xmm0, %xmm0
	leaq	40(%r13), %r12
	movq	%rsp, %rbp
	movups	%xmm0, (%rbx)
	movups	%xmm0, 16(%rbx)
	movups	%xmm0, 32(%rbx)
	movups	%xmm0, 48(%rbx)
	movq	48(%r13), %rdi
	call	sdup@PLT
	movq	%r12, %rdi
	movq	%rax, 16(%rbx)
	call	tok_free@PLT
	movq	%r13, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%r13)
	movd	%xmm0, %eax
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%r13)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%r13)
	movq	48(%rsp), %rdx
	movq	%rdx, 88(%r13)
	cmpl	$13, %eax
	je	.L156
.L151:
	movl	$0, (%rbx)
	movl	$0, 24(%rbx)
	movq	$0, 32(%rbx)
	movl	$0, 40(%rbx)
	movq	$0, 48(%rbx)
	movq	$0, 56(%rbx)
	cmpl	$19, %eax
	je	.L157
.L152:
	movq	%r13, %rdi
	movl	$18, %esi
	call	expect
	addq	$72, %rsp
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
.L155:
	.cfi_restore_state
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L150
	.p2align 4,,10
	.p2align 3
.L156:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%r13, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	leaq	.LC13(%rip), %rdi
	movups	%xmm0, 40(%r13)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%r13)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%r13)
	movq	48(%rsp), %rax
	movl	84(%r13), %edx
	movl	80(%r13), %esi
	movq	%rax, 88(%r13)
	xorl	%eax, %eax
	call	dief@PLT
	movl	40(%r13), %eax
	jmp	.L151
	.p2align 4,,10
	.p2align 3
.L157:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%r13)
	movdqu	16(%rsp), %xmm0
	cmpl	$20, 40(%r13)
	movups	%xmm0, 56(%r13)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%r13)
	movq	48(%rsp), %rax
	movq	%rax, 88(%r13)
	movl	$2, 24(%rbx)
	je	.L158
	movq	%r13, %rdi
	call	parse_expr
	movl	$20, %esi
	movq	%r13, %rdi
	movq	%rax, 32(%rbx)
	call	expect
	jmp	.L152
	.p2align 4,,10
	.p2align 3
.L158:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%r13)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%r13)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%r13)
	movq	48(%rsp), %rax
	movq	%rax, 88(%r13)
	movl	$1, 40(%rbx)
	jmp	.L152
	.cfi_endproc
.LFE29:
	.size	parse_extern_decl, .-parse_extern_decl
	.p2align 4
	.globl	parse_return
	.type	parse_return, @function
parse_return:
.LFB33:
	.cfi_startproc
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
	je	.L160
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L161
	movl	$13, %esi
	movq	%rbx, %rdi
	call	expect
	movq	%rbx, %rdi
	call	parse_expr
	movl	$14, %esi
	movq	%rbx, %rdi
	movq	%rax, %rbp
	call	expect
.L160:
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
.L161:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	parse_expr
	movq	%rax, %rbp
	jmp	.L160
	.cfi_endproc
.LFE33:
	.size	parse_return, .-parse_return
	.p2align 4
	.globl	parse_primary
	.type	parse_primary, @function
parse_primary:
.LFB48:
	.cfi_startproc
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
	subq	$64, %rsp
	.cfi_def_cfa_offset 96
	cmpl	$13, 40(%rdi)
	movq	80(%rdi), %r12
	ja	.L165
	movl	40(%rdi), %eax
	leaq	.L167(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L167:
	.long	.L165-.L167
	.long	.L170-.L167
	.long	.L168-.L167
	.long	.L169-.L167
	.long	.L168-.L167
	.long	.L165-.L167
	.long	.L165-.L167
	.long	.L165-.L167
	.long	.L165-.L167
	.long	.L165-.L167
	.long	.L165-.L167
	.long	.L165-.L167
	.long	.L165-.L167
	.long	.L166-.L167
	.text
	.p2align 4,,10
	.p2align 3
.L165:
	movq	96(%rbx), %rsi
	leaq	40(%rbx), %rdi
	xorl	%ecx, %ecx
	movl	$8, %edx
	xorl	%ebp, %ebp
	call	error_at_code@PLT
	addq	$64, %rsp
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
.L168:
	.cfi_restore_state
	movl	$80, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movl	$0, 76(%rax)
	movq	%rax, %rbp
	movl	$0, (%rax)
	movq	%r12, 4(%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 28(%rax)
	movups	%xmm0, 44(%rax)
	movups	%xmm0, 60(%rax)
	movq	72(%rbx), %rax
.L173:
	movq	%rax, 48(%rbp)
.L174:
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	addq	$64, %rsp
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
.L170:
	.cfi_restore_state
	movl	$80, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movl	$0, 76(%rax)
	movq	%rax, %rbp
	movq	%r12, 4(%rax)
	movl	$2, (%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 28(%rax)
	movups	%xmm0, 44(%rax)
	movups	%xmm0, 60(%rax)
	movq	48(%rbx), %rdi
	call	sdup@PLT
	jmp	.L173
	.p2align 4,,10
	.p2align 3
.L166:
	leaq	40(%rdi), %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movq	%rbx, %rdi
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	call	parse_expr
	movq	%rbx, %rdi
	movl	$14, %esi
	movq	%rax, %rbp
	call	expect
	addq	$64, %rsp
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
.L169:
	.cfi_restore_state
	movl	$80, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 28(%rax)
	movq	%rax, %rbp
	movups	%xmm0, 44(%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 60(%rax)
	movl	$0, 76(%rax)
	movq	56(%rbx), %rdi
	movq	%r12, 4(%rax)
	movq	%rdi, 40(%rax)
	addq	$1, %rdi
	movl	$1, (%rax)
	call	xmalloc@PLT
	movq	48(%rbx), %rsi
	movq	%rax, 48(%rbp)
	movq	%rax, %rdi
	movq	40(%rbp), %rax
	leaq	1(%rax), %rdx
	call	memcpy@PLT
	jmp	.L174
	.cfi_endproc
.LFE48:
	.size	parse_primary, .-parse_primary
	.section	.rodata.str1.1
.LC14:
	.string	"case outside switch at %d:%d"
.LC15:
	.string	"invalid constant word width"
	.section	.rodata.str1.8
	.align 8
.LC16:
	.string	"expected literal case constant"
	.text
	.p2align 4
	.globl	parse_case
	.type	parse_case, @function
parse_case:
.LFB41:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movl	$60, %esi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	subq	$96, %rsp
	.cfi_def_cfa_offset 128
	movq	80(%rdi), %rax
	movq	%rax, 8(%rsp)
	call	expect
	movl	112(%rbx), %edx
	testl	%edx, %edx
	je	.L198
.L176:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L177
	movl	40(%rbx), %eax
	cmpl	$31, %eax
	je	.L199
	subl	$2, %eax
	andl	$-3, %eax
	jne	.L200
.L197:
	movq	%rbx, %rdi
	call	parse_primary
	movq	%rax, %rbp
.L181:
	movl	104(%rbx), %esi
	testl	%esi, %esi
	je	.L188
	leal	-16(%rsi), %eax
	andl	$-17, %eax
	jne	.L201
.L182:
	movq	%rbp, %rdi
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
	movq	%rax, %rbp
	movl	$13, (%rax)
	movq	8(%rsp), %rax
	movq	$0, 16(%rbp)
	movq	%rax, 4(%rbp)
	movups	%xmm0, 24(%rbp)
	call	parse_case_body
	movq	%rax, 40(%rbp)
	addq	$96, %rsp
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
.L188:
	.cfi_restore_state
	movl	$64, %esi
	jmp	.L182
	.p2align 4,,10
	.p2align 3
.L177:
	movq	%rbx, %rdi
	call	parse_expr
	movq	%rax, %rbp
	jmp	.L181
	.p2align 4,,10
	.p2align 3
.L198:
	movq	8(%rsp), %xmm1
	leaq	.LC14(%rip), %rdi
	xorl	%eax, %eax
	pshufd	$0xe5, %xmm1, %xmm2
	movd	%xmm1, %esi
	movd	%xmm2, %edx
	call	dief@PLT
	jmp	.L176
	.p2align 4,,10
	.p2align 3
.L200:
	movq	96(%rbx), %rsi
	leaq	40(%rbx), %rdi
	leaq	.LC16(%rip), %rdx
	xorl	%eax, %eax
	call	error_at@PLT
	jmp	.L197
	.p2align 4,,10
	.p2align 3
.L199:
	leaq	40(%rbx), %rbp
	movq	%rbp, %rdi
	call	tok_free@PLT
	leaq	32(%rsp), %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movd	%xmm0, %eax
	movdqu	48(%rsp), %xmm0
	subl	$2, %eax
	movups	%xmm0, 56(%rbx)
	movdqu	64(%rsp), %xmm0
	andl	$-3, %eax
	movups	%xmm0, 72(%rbx)
	movq	80(%rsp), %rdx
	movq	%rdx, 88(%rbx)
	jne	.L202
.L196:
	movq	%rbx, %rdi
	call	parse_primary
	movl	$80, %edi
	movq	%rax, %r12
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movl	$0, 76(%rax)
	movq	%rax, %rbp
	movl	$5, (%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 28(%rax)
	movups	%xmm0, 44(%rax)
	movups	%xmm0, 60(%rax)
	movq	8(%rsp), %rax
	movl	$31, 48(%rbp)
	movq	%rax, 4(%rbp)
	movq	%r12, 56(%rbp)
	jmp	.L181
	.p2align 4,,10
	.p2align 3
.L202:
	movq	96(%rbx), %rsi
	leaq	.LC16(%rip), %rdx
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	error_at@PLT
	jmp	.L196
.L201:
	cmpl	$64, %esi
	je	.L182
	leaq	.LC15(%rip), %rdi
	xorl	%eax, %eax
	movl	%esi, 16(%rsp)
	call	dief@PLT
	movl	16(%rsp), %esi
	jmp	.L182
	.cfi_endproc
.LFE41:
	.size	parse_case, .-parse_case
	.section	.rodata.str1.8
	.align 8
.LC17:
	.string	"label expression must be an identifier at %d:%d"
	.text
	.p2align 4
	.globl	parse_stmt
	.type	parse_stmt, @function
parse_stmt:
.LFB44:
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
	subq	$80, %rsp
	.cfi_def_cfa_offset 128
	movl	40(%rdi), %eax
	cmpl	$1, %eax
	je	.L232
	cmpl	$18, %eax
	je	.L210
.L233:
	subl	$5, %eax
	cmpl	$56, %eax
	ja	.L211
	leaq	.L213(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L213:
	.long	.L218-.L213
	.long	.L223-.L213
	.long	.L211-.L213
	.long	.L222-.L213
	.long	.L221-.L213
	.long	.L220-.L213
	.long	.L219-.L213
	.long	.L218-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L217-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L211-.L213
	.long	.L216-.L213
	.long	.L215-.L213
	.long	.L214-.L213
	.long	.L212-.L213
	.text
	.p2align 4,,10
	.p2align 3
.L232:
	call	peek_next_kind
	cmpl	$57, %eax
	je	.L205
	movl	40(%rbx), %eax
	cmpl	$18, %eax
	jne	.L233
.L210:
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movl	$48, %edi
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	movq	80(%rbx), %rbx
	call	xmalloc@PLT
	movl	$0, (%rax)
	movq	%rax, %rbp
	movq	%rbx, 4(%rax)
	addq	$80, %rsp
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
.L211:
	.cfi_restore_state
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
.L203:
	addq	$80, %rsp
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
.L218:
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
	jmp	.L229
	.p2align 4,,10
	.p2align 3
.L235:
	cmpl	$12, %eax
	jne	.L234
.L229:
	cmpl	$5, %eax
	je	.L230
	movq	%rbx, %rdi
	call	parse_extrn_stmt
	movq	%rax, %rsi
.L225:
	movq	%r12, %rdi
	call	vec_push@PLT
	movl	40(%rbx), %eax
	cmpl	$5, %eax
	jne	.L235
.L230:
	movq	%rbx, %rdi
	call	parse_auto_decl
	movq	%rax, %rsi
	jmp	.L225
	.p2align 4,,10
	.p2align 3
.L220:
	leaq	40(%rbx), %rdi
	movq	80(%rbx), %r12
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movl	$18, %esi
	movq	%rbx, %rdi
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	call	expect
	movl	$48, %edi
	call	xmalloc@PLT
	movl	$8, (%rax)
	movq	%rax, %rbp
	movq	%r12, 4(%rax)
	jmp	.L203
	.p2align 4,,10
	.p2align 3
.L219:
	leaq	40(%rbx), %rdi
	movq	80(%rbx), %r12
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movl	$18, %esi
	movq	%rbx, %rdi
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	call	expect
	movl	$48, %edi
	call	xmalloc@PLT
	movl	$9, (%rax)
	movq	%rax, %rbp
	movq	%r12, 4(%rax)
	jmp	.L203
	.p2align 4,,10
	.p2align 3
.L217:
	addq	$80, %rsp
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
.L212:
	.cfi_restore_state
	addq	$80, %rsp
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
.L215:
	.cfi_restore_state
	movl	$59, %esi
	movq	%rbx, %rdi
	movq	80(%rbx), %r14
	call	expect
	cmpl	$13, 40(%rbx)
	je	.L227
	movq	%rbx, %rdi
	call	parse_expr
	movq	%rax, %r13
.L228:
	addl	$1, 112(%rbx)
	movq	%rbx, %rdi
	call	parse_stmt
	subl	$1, 112(%rbx)
	movl	$48, %edi
	movq	%rax, %r12
	call	xmalloc@PLT
	movl	$12, (%rax)
	movq	%rax, %rbp
	movq	%r14, 4(%rax)
	movq	%r13, 16(%rax)
	movq	%r12, 24(%rax)
	jmp	.L203
	.p2align 4,,10
	.p2align 3
.L214:
	addq	$80, %rsp
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
.L216:
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
	jmp	.L203
	.p2align 4,,10
	.p2align 3
.L222:
	addq	$80, %rsp
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
.L221:
	.cfi_restore_state
	addq	$80, %rsp
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
.L223:
	.cfi_restore_state
	addq	$80, %rsp
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
.L234:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	parse_stmt
	movq	%r12, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L203
	.p2align 4,,10
	.p2align 3
.L205:
	movq	80(%rbx), %rax
	movq	%rbx, %rdi
	movq	%rax, 8(%rsp)
	call	parse_expr
	movl	$57, %esi
	movq	%rbx, %rdi
	movq	%rax, %r12
	call	expect
	cmpl	$2, (%r12)
	je	.L206
	movq	8(%rsp), %xmm1
	leaq	.LC17(%rip), %rdi
	xorl	%eax, %eax
	pshufd	$0xe5, %xmm1, %xmm2
	movd	%xmm1, %esi
	movd	%xmm2, %edx
	call	dief@PLT
.L206:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L207
	cmpl	$16, 40(%rbx)
	je	.L236
.L207:
	movq	%rbx, %rdi
	call	parse_stmt
	movq	%rax, %rbx
.L208:
	movl	$48, %edi
	call	xmalloc@PLT
	movq	%rax, %rbp
	movl	$11, (%rax)
	movq	8(%rsp), %rax
	movq	%rax, 4(%rbp)
	movq	48(%r12), %rdi
	call	sdup@PLT
	movq	%rbx, 24(%rbp)
	movq	%rax, 16(%rbp)
	jmp	.L203
.L227:
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movq	%rbx, %rdi
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	call	parse_expr
	movl	$14, %esi
	movq	%rbx, %rdi
	movq	%rax, %r13
	call	expect
	jmp	.L228
.L236:
	movq	80(%rbx), %rbp
	movl	$48, %edi
	call	xmalloc@PLT
	movl	$0, (%rax)
	movq	%rax, %rbx
	movq	%rbp, 4(%rax)
	jmp	.L208
	.cfi_endproc
.LFE44:
	.size	parse_stmt, .-parse_stmt
	.section	.rodata.str1.1
.LC18:
	.string	"unexpected EOF in block"
	.text
	.p2align 4
	.globl	parse_block
	.type	parse_block, @function
parse_block:
.LFB30:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movl	$15, %esi
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
	movq	80(%rdi), %r13
	call	expect
	xorl	%eax, %eax
	call	vec_new@PLT
	movq	%rax, %rbp
	movl	40(%rbx), %eax
	cmpl	$16, %eax
	je	.L238
	leaq	.LC18(%rip), %r12
	jmp	.L243
	.p2align 4,,10
	.p2align 3
.L239:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L240
	movl	40(%rbx), %eax
	cmpl	$5, %eax
	je	.L249
	cmpl	$12, %eax
	je	.L250
.L240:
	movq	%rbx, %rdi
	call	parse_stmt
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
.L242:
	movl	40(%rbx), %eax
	cmpl	$16, %eax
	je	.L238
.L243:
	testl	%eax, %eax
	jne	.L239
	movq	%r12, %rdi
	call	dief@PLT
	jmp	.L239
	.p2align 4,,10
	.p2align 3
.L238:
	movq	%rbx, %rdi
	movl	$16, %esi
	call	expect
	movl	$48, %edi
	call	xmalloc@PLT
	movdqu	0(%rbp), %xmm0
	movl	$1, (%rax)
	movups	%xmm0, 16(%rax)
	movq	16(%rbp), %rdx
	movq	%r13, 4(%rax)
	movq	%rdx, 32(%rax)
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
	.p2align 4,,10
	.p2align 3
.L250:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	parse_extrn_stmt
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L242
	.p2align 4,,10
	.p2align 3
.L249:
	movq	%rbx, %rdi
	call	parse_auto_decl
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L242
	.cfi_endproc
.LFE30:
	.size	parse_block, .-parse_block
	.section	.rodata.str1.8
	.align 8
.LC19:
	.string	"expected function name at %d:%d"
	.align 8
.LC20:
	.string	"expected parameter name at %d:%d"
	.text
	.p2align 4
	.globl	parse_function
	.type	parse_function, @function
parse_function:
.LFB27:
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
	subq	$64, %rsp
	.cfi_def_cfa_offset 112
	cmpl	$1, 40(%rdi)
	je	.L252
	movl	84(%rdi), %edx
	movl	80(%rdi), %esi
	xorl	%eax, %eax
	leaq	.LC19(%rip), %rdi
	call	dief@PLT
.L252:
	movl	$40, %edi
	leaq	40(%rbx), %r12
	movq	%rsp, %r13
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
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movl	$13, %esi
	movq	%rbx, %rdi
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	call	expect
	movl	40(%rbx), %eax
	cmpl	$14, %eax
	je	.L253
	leaq	8(%rbp), %r14
.L255:
	cmpl	$1, %eax
	jne	.L265
.L254:
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
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movd	%xmm0, %eax
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rdx
	movq	%rdx, 88(%rbx)
	cmpl	$17, %eax
	je	.L266
.L253:
	movl	$14, %esi
	movq	%rbx, %rdi
	call	expect
	cmpl	$15, 40(%rbx)
	je	.L267
	movq	%rbx, %rdi
	movq	80(%rbx), %r13
	call	parse_stmt
	movl	$48, %edi
	movq	%rax, %r12
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%r12, %rsi
	movl	$1, (%rax)
	leaq	16(%rax), %rdi
	movq	%rax, %rbx
	movq	%r13, 4(%rax)
	movq	$0, 16(%rax)
	movups	%xmm0, 24(%rax)
	call	vec_push@PLT
.L257:
	movq	%rbx, 32(%rbp)
	addq	$64, %rsp
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
.L265:
	.cfi_restore_state
	movl	84(%rbx), %edx
	movl	80(%rbx), %esi
	leaq	.LC20(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L254
	.p2align 4,,10
	.p2align 3
.L267:
	movq	%rbx, %rdi
	call	parse_block
	movq	%rax, %rbx
	jmp	.L257
	.p2align 4,,10
	.p2align 3
.L266:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movd	%xmm0, %eax
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rdx
	movq	%rdx, 88(%rbx)
	jmp	.L255
	.cfi_endproc
.LFE27:
	.size	parse_function, .-parse_function
	.p2align 4
	.globl	parse_if
	.type	parse_if, @function
parse_if:
.LFB31:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movl	$6, %esi
	xorl	%r14d, %r14d
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
	subq	$64, %rsp
	.cfi_def_cfa_offset 112
	movq	80(%rdi), %r13
	call	expect
	movl	$13, %esi
	movq	%rbx, %rdi
	call	expect
	movq	%rbx, %rdi
	call	parse_expr
	movl	$14, %esi
	movq	%rbx, %rdi
	movq	%rax, %r12
	call	expect
	movq	%rbx, %rdi
	call	parse_stmt
	cmpl	$7, 40(%rbx)
	movq	%rax, %rbp
	je	.L273
.L269:
	movl	$48, %edi
	call	xmalloc@PLT
	movl	$3, (%rax)
	movq	%r13, 4(%rax)
	movq	%r12, 16(%rax)
	movq	%rbp, 24(%rax)
	movq	%r14, 32(%rax)
	addq	$64, %rsp
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
.L273:
	.cfi_restore_state
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movq	%rbx, %rdi
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	call	parse_stmt
	movq	%rax, %r14
	jmp	.L269
	.cfi_endproc
.LFE31:
	.size	parse_if, .-parse_if
	.p2align 4
	.globl	parse_while
	.type	parse_while, @function
parse_while:
.LFB32:
	.cfi_startproc
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
	movq	80(%rdi), %r13
	call	expect
	movl	$13, %esi
	movq	%rbx, %rdi
	call	expect
	movq	%rbx, %rdi
	call	parse_expr
	movl	$14, %esi
	movq	%rbx, %rdi
	movq	%rax, %r12
	call	expect
	addl	$1, 108(%rbx)
	movq	%rbx, %rdi
	call	parse_stmt
	subl	$1, 108(%rbx)
	movl	$48, %edi
	movq	%rax, %rbp
	call	xmalloc@PLT
	movl	$4, (%rax)
	movq	%r13, 4(%rax)
	movq	%r12, 16(%rax)
	movq	%rbp, 24(%rax)
	addq	$8, %rsp
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
	.cfi_endproc
.LFE32:
	.size	parse_while, .-parse_while
	.p2align 4
	.type	parse_case_body, @function
parse_case_body:
.LFB40:
	.cfi_startproc
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L277
	movl	40(%rdi), %eax
	cmpl	$16, %eax
	je	.L282
	cmpl	$5, %eax
	je	.L285
	cmpl	$12, %eax
	je	.L286
.L277:
	jmp	parse_stmt
	.p2align 4,,10
	.p2align 3
.L286:
	jmp	parse_extrn_stmt
	.p2align 4,,10
	.p2align 3
.L282:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	80(%rdi), %rbx
	movl	$48, %edi
	call	xmalloc@PLT
	movl	$0, (%rax)
	movq	%rbx, 4(%rax)
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L285:
	.cfi_restore 3
	jmp	parse_auto_decl
	.cfi_endproc
.LFE40:
	.size	parse_case_body, .-parse_case_body
	.section	.rodata.str1.8
	.align 8
.LC21:
	.string	"default outside switch at %d:%d"
	.text
	.p2align 4
	.globl	parse_default
	.type	parse_default, @function
parse_default:
.LFB42:
	.cfi_startproc
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
	movl	112(%rbp), %eax
	testl	%eax, %eax
	je	.L290
.L288:
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
	.p2align 4,,10
	.p2align 3
.L290:
	.cfi_restore_state
	movq	8(%rsp), %xmm1
	leaq	.LC21(%rip), %rdi
	xorl	%eax, %eax
	pshufd	$0xe5, %xmm1, %xmm2
	movd	%xmm1, %esi
	movd	%xmm2, %edx
	call	dief@PLT
	jmp	.L288
	.cfi_endproc
.LFE42:
	.size	parse_default, .-parse_default
	.section	.rodata.str1.8
	.align 8
.LC22:
	.string	"postfix %s requires an lvalue at %d:%d"
	.text
	.p2align 4
	.globl	parse_postfix
	.type	parse_postfix, @function
parse_postfix:
.LFB49:
	.cfi_startproc
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
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	call	parse_primary
	movq	%rax, %rbp
.L292:
	movl	40(%rbx), %r12d
	cmpl	$13, %r12d
	je	.L293
	cmpl	$19, %r12d
	je	.L313
	leal	-36(%r12), %eax
	cmpl	$1, %eax
	jbe	.L314
	addq	$72, %rsp
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
.L293:
	.cfi_restore_state
	leaq	40(%rbx), %r14
	movq	%rsp, %r13
	movq	%r14, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movl	$80, %edi
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	movq	4(%rbp), %r15
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 44(%rax)
	movq	%rax, %r12
	movl	$0, 76(%rax)
	movq	%r15, 4(%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 28(%rax)
	movups	%xmm0, 60(%rax)
	cmpl	$14, 40(%rbx)
	movq	%rbp, 48(%rax)
	leaq	56(%rax), %rbp
	movl	$3, (%rax)
	je	.L315
.L296:
	movq	%rbx, %rdi
	call	parse_assignment
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	cmpl	$17, 40(%rbx)
	je	.L298
	movl	$14, %esi
	movq	%rbx, %rdi
	call	expect
.L297:
	movq	%r12, %rbp
	jmp	.L292
	.p2align 4,,10
	.p2align 3
.L314:
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	testq	%rbp, %rbp
	je	.L301
	movl	0(%rbp), %eax
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L302
	cmpl	$5, %eax
	je	.L316
.L301:
	movl	8(%rbp), %r14d
	movl	4(%rbp), %r13d
	movl	%r12d, %edi
	call	tk_name@PLT
	leaq	.LC22(%rip), %rdi
	movq	%rax, %rsi
	movl	%r14d, %ecx
	movl	%r13d, %edx
	xorl	%eax, %eax
	call	dief@PLT
.L302:
	movq	4(%rbp), %r13
	movl	$80, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 44(%rax)
	movups	%xmm0, 60(%rax)
	movl	$0, 76(%rax)
	movq	%rbp, 56(%rax)
	movq	%rax, %rbp
	movl	$6, (%rax)
	movq	%r13, 4(%rax)
	movl	%r12d, 48(%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 28(%rax)
	jmp	.L292
	.p2align 4,,10
	.p2align 3
.L313:
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movq	%rbx, %rdi
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	call	parse_expr
	movl	$20, %esi
	movq	%rbx, %rdi
	movq	%rax, %r12
	call	expect
	movq	4(%rbp), %r13
	movl	$80, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 44(%rax)
	movups	%xmm0, 60(%rax)
	movq	%rbp, 48(%rax)
	movq	%rax, %rbp
	movl	$0, 76(%rax)
	movl	$4, (%rax)
	movq	%r13, 4(%rax)
	movq	%r12, 56(%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 28(%rax)
	jmp	.L292
	.p2align 4,,10
	.p2align 3
.L316:
	cmpl	$32, 48(%rbp)
	jne	.L301
	jmp	.L302
	.p2align 4,,10
	.p2align 3
.L298:
	movq	%r14, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	jmp	.L296
	.p2align 4,,10
	.p2align 3
.L315:
	movq	%r14, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	jmp	.L297
	.cfi_endproc
.LFE49:
	.size	parse_postfix, .-parse_postfix
	.section	.rodata.str1.8
	.align 8
.LC23:
	.string	"prefix %s requires an lvalue at %d:%d"
	.section	.rodata.str1.1
.LC24:
	.string	"& requires an lvalue at %d:%d"
	.text
	.p2align 4
	.globl	parse_unary
	.type	parse_unary, @function
parse_unary:
.LFB50:
	.cfi_startproc
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
	movl	40(%rdi), %ebp
	cmpl	$53, %ebp
	ja	.L318
	movabsq	$9007446215360512, %rax
	btq	%rbp, %rax
	jnc	.L318
	movq	80(%rdi), %rax
	leaq	40(%rdi), %rdi
	movq	%rax, %xmm1
	movq	%rax, 8(%rsp)
	movl	%eax, %r12d
	pshufd	$0xe5, %xmm1, %xmm2
	movd	%xmm2, %r13d
	call	tok_free@PLT
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movq	%rbx, %rdi
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	call	parse_unary
	movq	%rax, %rbx
	leal	-36(%rbp), %eax
	cmpl	$1, %eax
	jbe	.L337
	cmpl	$53, %ebp
	je	.L338
.L322:
	movl	$80, %edi
	call	xmalloc@PLT
	movq	8(%rsp), %rcx
	pxor	%xmm0, %xmm0
	movups	%xmm0, 44(%rax)
	movups	%xmm0, 60(%rax)
	movl	$0, 76(%rax)
	movl	$5, (%rax)
	movq	%rcx, 4(%rax)
	movl	%ebp, 48(%rax)
	movq	%rbx, 56(%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 28(%rax)
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
	ret
	.p2align 4,,10
	.p2align 3
.L318:
	.cfi_restore_state
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	parse_postfix
	.p2align 4,,10
	.p2align 3
.L337:
	.cfi_restore_state
	testq	%rbx, %rbx
	je	.L321
	movl	(%rbx), %eax
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L322
	cmpl	$5, %eax
	je	.L339
.L321:
	movl	%ebp, %edi
	call	tk_name@PLT
	movl	%r13d, %ecx
	movl	%r12d, %edx
	leaq	.LC23(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L322
	.p2align 4,,10
	.p2align 3
.L338:
	testq	%rbx, %rbx
	je	.L323
	movl	(%rbx), %eax
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L322
	cmpl	$5, %eax
	je	.L340
.L323:
	movl	%r13d, %edx
	movl	%r12d, %esi
	leaq	.LC24(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L322
	.p2align 4,,10
	.p2align 3
.L339:
	cmpl	$32, 48(%rbx)
	jne	.L321
	jmp	.L322
	.p2align 4,,10
	.p2align 3
.L340:
	cmpl	$32, 48(%rbx)
	jne	.L323
	jmp	.L322
	.cfi_endproc
.LFE50:
	.size	parse_unary, .-parse_unary
	.p2align 4
	.globl	parse_bin_rhs
	.type	parse_bin_rhs, @function
parse_bin_rhs:
.LFB51:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdi, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	leaq	CSWTCH.27(%rip), %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	xorl	%r12d, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdx, %rbx
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movl	40(%r14), %ebp
	movl	%esi, 12(%rsp)
	leal	-22(%rbp), %eax
	cmpl	$33, %eax
	ja	.L342
.L351:
	movsbl	0(%r13,%rax), %r12d
.L342:
	cmpl	%r12d, 12(%rsp)
	jg	.L347
.L352:
	leaq	40(%r14), %rdi
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%r14, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movq	%r14, %rdi
	movups	%xmm0, 40(%r14)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%r14)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%r14)
	movq	64(%rsp), %rax
	movq	%rax, 88(%r14)
	call	parse_unary
	movq	%rax, %r15
	movl	40(%r14), %eax
	subl	$22, %eax
	cmpl	$33, %eax
	ja	.L344
	movsbl	0(%r13,%rax), %eax
	cmpl	%eax, %r12d
	jl	.L350
.L344:
	movq	4(%rbx), %r12
	movl	$80, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 44(%rax)
	movups	%xmm0, 60(%rax)
	movq	%r12, 4(%rax)
	xorl	%r12d, %r12d
	movl	$0, 76(%rax)
	movl	%ebp, 48(%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 28(%rax)
	movl	40(%r14), %ebp
	movq	%rbx, 56(%rax)
	movq	%rax, %rbx
	movl	$7, (%rax)
	movq	%r15, 64(%rax)
	leal	-22(%rbp), %eax
	cmpl	$33, %eax
	jbe	.L351
	cmpl	%r12d, 12(%rsp)
	jle	.L352
.L347:
	addq	$88, %rsp
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
.L350:
	.cfi_restore_state
	movq	%r15, %rdx
	leal	1(%r12), %esi
	movq	%r14, %rdi
	call	parse_bin_rhs
	movq	%rax, %r15
	jmp	.L344
	.cfi_endproc
.LFE51:
	.size	parse_bin_rhs, .-parse_bin_rhs
	.section	.rodata.str1.8
	.align 8
.LC25:
	.string	"left side of '%s' must be an lvalue at %d:%d"
	.text
	.p2align 4
	.globl	parse_assignment
	.type	parse_assignment, @function
parse_assignment:
.LFB52:
	.cfi_startproc
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
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	call	parse_unary
	movl	$1, %esi
	movq	%r12, %rdi
	movq	%rax, %rdx
	call	parse_bin_rhs
	movl	40(%r12), %ebp
	movq	%rax, %rbx
	cmpl	$56, %ebp
	je	.L375
	cmpl	$21, %ebp
	je	.L357
	leal	-38(%rbp), %eax
	cmpl	$14, %eax
	ja	.L353
.L357:
	leaq	40(%r12), %rdi
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%r12, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 40(%r12)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%r12)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%r12)
	movq	64(%rsp), %rax
	movq	%rax, 88(%r12)
	testq	%rbx, %rbx
	je	.L358
.L360:
	movl	(%rbx), %eax
	movq	%rbx, %r13
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L359
	cmpl	$5, %eax
	je	.L376
.L358:
	movl	4(%rbx), %r13d
	movl	8(%rbx), %r14d
	movl	%ebp, %edi
	call	tk_name@PLT
	leaq	.LC25(%rip), %rdi
	movq	%rax, %rsi
	movl	%r13d, %edx
	movl	%r14d, %ecx
	xorl	%eax, %eax
	call	dief@PLT
	movq	%rbx, %r13
.L359:
	movq	%r12, %rdi
	call	parse_assignment
	movq	4(%rbx), %r14
	movl	$80, %edi
	movq	%rax, %r12
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 44(%rax)
	movq	%rax, %rbx
	movups	%xmm0, 60(%rax)
	movl	$0, 76(%rax)
	movl	$8, (%rax)
	movq	%r14, 4(%rax)
	movl	%ebp, 48(%rax)
	movq	%r13, 56(%rax)
	movq	%r12, 64(%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 28(%rax)
.L353:
	addq	$88, %rsp
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
.L376:
	.cfi_restore_state
	cmpl	$32, 48(%rbx)
	jne	.L358
	jmp	.L359
	.p2align 4,,10
	.p2align 3
.L375:
	leaq	40(%r12), %rax
	movq	%rax, %rdi
	movq	%rax, (%rsp)
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%r12, %rsi
	movq	%rdi, 8(%rsp)
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movq	%r12, %rdi
	movups	%xmm0, 40(%r12)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%r12)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%r12)
	movq	64(%rsp), %rax
	movq	%rax, 88(%r12)
	call	parse_assignment
	movl	$57, %esi
	movq	%r12, %rdi
	movq	%rax, %r14
	call	expect
	movq	%r12, %rdi
	call	parse_assignment
	movq	4(%rbx), %r15
	movl	$80, %edi
	movq	%rax, %rbp
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 44(%rax)
	movq	%rax, %r13
	movups	%xmm0, 60(%rax)
	movl	$0, 76(%rax)
	movq	%r15, 4(%rax)
	movq	%rbp, 64(%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 28(%rax)
	movl	40(%r12), %ebp
	movl	$9, (%rax)
	movq	%rbx, 48(%rax)
	movq	%r14, 56(%rax)
	cmpl	$21, %ebp
	je	.L355
	leal	-38(%rbp), %eax
	movq	%r13, %rbx
	cmpl	$14, %eax
	ja	.L353
.L355:
	movq	(%rsp), %rdi
	movq	%r13, %rbx
	call	tok_free@PLT
	movq	8(%rsp), %rdi
	movq	%r12, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 40(%r12)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%r12)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%r12)
	movq	64(%rsp), %rax
	movq	%rax, 88(%r12)
	jmp	.L360
	.cfi_endproc
.LFE52:
	.size	parse_assignment, .-parse_assignment
	.p2align 4
	.globl	parse_init_list
	.type	parse_init_list, @function
parse_init_list:
.LFB45:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movl	$15, %esi
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
	subq	$64, %rsp
	.cfi_def_cfa_offset 112
	movq	80(%rdi), %r12
	call	expect
	movl	$40, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%rax, %rbp
	movl	$1, (%rax)
	movq	%r12, 4(%rax)
	leaq	16(%rbp), %r13
	movq	$0, 16(%rax)
	movups	%xmm0, 24(%rax)
	movl	40(%rbx), %eax
	cmpl	$16, %eax
	je	.L387
.L378:
	cmpl	$15, %eax
	je	.L388
	movq	80(%rbx), %r14
	movl	$40, %edi
	call	xmalloc@PLT
	movq	%rbx, %rdi
	movl	$0, (%rax)
	movq	%rax, %r12
	movq	%r14, 4(%rax)
	call	parse_assignment
	movq	%rax, 16(%r12)
.L381:
	movq	%r12, %rsi
	movq	%r13, %rdi
	call	vec_push@PLT
	cmpl	$17, 40(%rbx)
	je	.L382
	movq	%rbx, %rdi
	movl	$16, %esi
	call	expect
	addq	$64, %rsp
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
.L388:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	parse_init_list
	movq	%rax, %r12
	jmp	.L381
	.p2align 4,,10
	.p2align 3
.L387:
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	addq	$64, %rsp
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
.L382:
	.cfi_restore_state
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movd	%xmm0, %eax
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rdx
	movq	%rdx, 88(%rbx)
	jmp	.L378
	.cfi_endproc
.LFE45:
	.size	parse_init_list, .-parse_init_list
	.p2align 4
	.globl	parse_init_elem
	.type	parse_init_elem, @function
parse_init_elem:
.LFB46:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	cmpl	$15, 40(%rdi)
	movq	%rdi, %rbx
	je	.L392
	movq	80(%rdi), %r12
	movl	$40, %edi
	call	xmalloc@PLT
	movq	%rbx, %rdi
	movq	%r12, 4(%rax)
	movq	%rax, %rbp
	movl	$0, (%rax)
	call	parse_assignment
	movq	%rax, 16(%rbp)
	movq	%rbp, %rax
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
.L392:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	parse_init_list
	.cfi_endproc
.LFE46:
	.size	parse_init_elem, .-parse_init_elem
	.p2align 4
	.globl	parse_comma_init_list
	.type	parse_comma_init_list, @function
parse_comma_init_list:
.LFB47:
	.cfi_startproc
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
	xorl	%r12d, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movl	40(%rdi), %eax
	cmpl	$53, %eax
	ja	.L393
	movabsq	$9007205697200158, %rdx
	btq	%rax, %rdx
	jnc	.L393
	movq	80(%rdi), %rbx
	movq	%rdi, %rbp
	movl	$40, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	leaq	40(%rbp), %r14
	movq	%rbx, 4(%rax)
	cmpl	$15, 40(%rbp)
	movq	%rax, %r12
	leaq	16(%rax), %r13
	movl	$1, (%rax)
	movq	$0, 16(%rax)
	movups	%xmm0, 24(%rax)
	je	.L402
.L395:
	movq	80(%rbp), %r15
	movl	$40, %edi
	call	xmalloc@PLT
	movq	%rbp, %rdi
	movl	$0, (%rax)
	movq	%rax, %rbx
	movq	%r15, 4(%rax)
	call	parse_assignment
	movq	%rax, 16(%rbx)
.L396:
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	vec_push@PLT
	cmpl	$17, 40(%rbp)
	je	.L403
.L393:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rax
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
.L403:
	.cfi_restore_state
	movq	%r14, %rdi
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbp, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbp)
	movdqu	16(%rsp), %xmm0
	cmpl	$15, 40(%rbp)
	movups	%xmm0, 56(%rbp)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbp)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbp)
	jne	.L395
.L402:
	movq	%rbp, %rdi
	call	parse_init_list
	movq	%rax, %rbx
	jmp	.L396
	.cfi_endproc
.LFE47:
	.size	parse_comma_init_list, .-parse_comma_init_list
	.section	.rodata.str1.1
.LC26:
	.string	"expected identifier at %d:%d"
	.section	.rodata.str1.8
	.align 8
.LC27:
	.string	"external '=' initializer is outside Thompson B72"
	.align 8
.LC28:
	.string	"bad external definition after '%s' at %d:%d"
	.text
	.p2align 4
	.globl	parse_extern_var_def
	.type	parse_extern_var_def, @function
parse_extern_var_def:
.LFB28:
	.cfi_startproc
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
	subq	$72, %rsp
	.cfi_def_cfa_offset 112
	cmpl	$1, 40(%rdi)
	je	.L405
	movl	84(%rdi), %edx
	movl	80(%rdi), %esi
	xorl	%eax, %eax
	leaq	.LC26(%rip), %rdi
	call	dief@PLT
.L405:
	movl	$64, %edi
	call	xmalloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L428
.L406:
	pxor	%xmm0, %xmm0
	leaq	40(%rbx), %r12
	movups	%xmm0, 0(%rbp)
	movups	%xmm0, 16(%rbp)
	movups	%xmm0, 32(%rbp)
	movups	%xmm0, 48(%rbp)
	movq	48(%rbx), %rdi
	call	sdup@PLT
	movq	%r12, %rdi
	movq	%rax, 16(%rbp)
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movd	%xmm0, %eax
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rdx
	movq	%rdx, 88(%rbx)
	cmpl	$19, %eax
	je	.L407
	cmpl	$15, %eax
	je	.L429
	cmpl	$18, %eax
	je	.L430
	cmpl	$21, %eax
	je	.L431
	movq	%rbx, %rdi
	call	parse_comma_init_list
	testq	%rax, %rax
	je	.L432
	cmpl	$2, 24(%rbp)
	je	.L426
	movl	$1, 24(%rbp)
.L426:
	movq	%rax, 56(%rbp)
	movl	$18, %esi
	movq	%rbx, %rdi
	call	expect
.L404:
	addq	$72, %rsp
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
.L428:
	.cfi_restore_state
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L406
	.p2align 4,,10
	.p2align 3
.L407:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	cmpl	$20, 40(%rbx)
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	movl	$2, 24(%rbp)
	je	.L433
	movq	%rbx, %rdi
	call	parse_expr
	movl	$20, %esi
	movq	%rbx, %rdi
	movq	%rax, 32(%rbp)
	call	expect
.L411:
	cmpl	$15, 40(%rbx)
	movq	%rbx, %rdi
	je	.L427
	call	parse_comma_init_list
	jmp	.L426
	.p2align 4,,10
	.p2align 3
.L429:
	movl	$1, 24(%rbp)
	movq	%rbx, %rdi
.L427:
	call	parse_init_list
	jmp	.L426
	.p2align 4,,10
	.p2align 3
.L430:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	movl	$0, 24(%rbp)
	movq	$0, 56(%rbp)
	jmp	.L404
	.p2align 4,,10
	.p2align 3
.L432:
	movq	16(%rbp), %rsi
	movl	84(%rbx), %ecx
	leaq	.LC28(%rip), %rdi
	xorl	%eax, %eax
	movl	80(%rbx), %edx
	xorl	%ebp, %ebp
	call	dief@PLT
	jmp	.L404
	.p2align 4,,10
	.p2align 3
.L431:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L434
.L419:
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
	jmp	.L404
	.p2align 4,,10
	.p2align 3
.L434:
	movq	96(%rbx), %rsi
	leaq	.LC27(%rip), %rdx
	movq	%r12, %rdi
	xorl	%eax, %eax
	call	error_at@PLT
	jmp	.L419
	.p2align 4,,10
	.p2align 3
.L433:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	movl	$1, 40(%rbp)
	jmp	.L411
	.cfi_endproc
.LFE28:
	.size	parse_extern_var_def, .-parse_extern_var_def
	.section	.rodata.str1.8
	.align 8
.LC29:
	.string	"top-level auto is outside Thompson B72"
	.align 8
.LC30:
	.string	"unexpected token at top level: %s"
	.text
	.p2align 4
	.globl	parse_program_ast
	.type	parse_program_ast, @function
parse_program_ast:
.LFB25:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %rbp
	movl	$24, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	call	xmalloc@PLT
	movl	40(%rbp), %ecx
	pxor	%xmm0, %xmm0
	movq	$0, (%rax)
	movq	%rax, %r12
	movups	%xmm0, 8(%rax)
	testl	%ecx, %ecx
	je	.L435
	leaq	.LC30(%rip), %r13
	jmp	.L443
	.p2align 4,,10
	.p2align 3
.L439:
	cmpl	$1, %edi
	je	.L446
	call	tk_name@PLT
	movq	%r13, %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
.L438:
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	vec_push@PLT
	movl	40(%rbp), %eax
	testl	%eax, %eax
	je	.L435
.L443:
	movl	$16, %edi
	call	xmalloc@PLT
	movl	40(%rbp), %edi
	movq	%rax, %rbx
	cmpl	$12, %edi
	je	.L447
	cmpl	$5, %edi
	jne	.L439
	movl	g_strict(%rip), %edx
	testl	%edx, %edx
	jne	.L448
.L440:
	movl	$0, (%rbx)
	movq	%rbp, %rdi
	call	parse_auto_decl
	movq	%rax, 8(%rbx)
	jmp	.L438
	.p2align 4,,10
	.p2align 3
.L447:
	movl	$3, (%rax)
	movq	%rbp, %rdi
	call	parse_extern_decl
	movq	%rax, 8(%rbx)
	jmp	.L438
	.p2align 4,,10
	.p2align 3
.L446:
	movq	%rbp, %rdi
	call	peek_next_kind
	cmpl	$13, %eax
	je	.L449
	movl	$2, (%rbx)
	movq	%rbp, %rdi
	call	parse_extern_var_def
	movq	%rax, 8(%rbx)
	jmp	.L438
	.p2align 4,,10
	.p2align 3
.L435:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%r12, %rax
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
.L448:
	.cfi_restore_state
	movq	96(%rbp), %rsi
	leaq	40(%rbp), %rdi
	leaq	.LC29(%rip), %rdx
	xorl	%eax, %eax
	call	error_at@PLT
	jmp	.L440
	.p2align 4,,10
	.p2align 3
.L449:
	movl	$1, (%rbx)
	movq	%rbp, %rdi
	call	parse_function
	movq	%rax, 8(%rbx)
	jmp	.L438
	.cfi_endproc
.LFE25:
	.size	parse_program_ast, .-parse_program_ast
	.section	.rodata
	.align 32
	.type	CSWTCH.27, @object
	.size	CSWTCH.27, 34
CSWTCH.27:
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
