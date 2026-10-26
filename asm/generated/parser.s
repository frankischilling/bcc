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
.LFB35:
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
	testq	%rdi, %rdi
	je	.L35
.L2:
	movl	(%rbx), %eax
	cmpl	$5, %eax
	je	.L3
	cmpl	$7, %eax
	je	.L4
	testl	%eax, %eax
	jne	.L5
	movq	48(%rbx), %rbp
.L1:
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
.L32:
	.cfi_restore_state
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	leaq	.LC1(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L4:
	movq	56(%rbx), %rdi
	call	eval_const_expr
	movq	64(%rbx), %rdi
	movq	%rax, %rbp
	call	eval_const_expr
	movq	%rax, %r12
	movl	48(%rbx), %eax
	leal	-22(%rax), %edx
	cmpl	$33, %edx
	ja	.L10
	leaq	.L12(%rip), %rcx
	movslq	(%rcx,%rdx,4), %rax
	addq	%rcx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L12:
	.long	.L25-.L12
	.long	.L24-.L12
	.long	.L23-.L12
	.long	.L22-.L12
	.long	.L21-.L12
	.long	.L20-.L12
	.long	.L10-.L12
	.long	.L10-.L12
	.long	.L19-.L12
	.long	.L18-.L12
	.long	.L17-.L12
	.long	.L16-.L12
	.long	.L15-.L12
	.long	.L10-.L12
	.long	.L10-.L12
	.long	.L10-.L12
	.long	.L10-.L12
	.long	.L10-.L12
	.long	.L10-.L12
	.long	.L10-.L12
	.long	.L10-.L12
	.long	.L10-.L12
	.long	.L10-.L12
	.long	.L10-.L12
	.long	.L10-.L12
	.long	.L10-.L12
	.long	.L10-.L12
	.long	.L10-.L12
	.long	.L10-.L12
	.long	.L10-.L12
	.long	.L10-.L12
	.long	.L14-.L12
	.long	.L13-.L12
	.long	.L11-.L12
	.text
	.p2align 4,,10
	.p2align 3
.L10:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	leaq	.LC4(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L5:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	leaq	.LC5(%rip), %rdi
	call	dief@PLT
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
.L3:
	.cfi_restore_state
	movq	56(%rbx), %rdi
	call	eval_const_expr
	movl	48(%rbx), %edx
	movq	%rax, %rbp
	negq	%rbp
	cmpl	$31, %edx
	je	.L1
	cmpl	$35, %edx
	jne	.L32
	xorl	%ebp, %ebp
	testq	%rax, %rax
	sete	%bpl
	jmp	.L1
	.p2align 4,,10
	.p2align 3
.L35:
	leaq	.LC0(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L2
.L25:
	cmpq	%r12, %rbp
	sete	%bpl
	movzbl	%bpl, %ebp
	jmp	.L1
.L24:
	cmpq	%r12, %rbp
	setne	%bpl
	movzbl	%bpl, %ebp
	jmp	.L1
.L23:
	cmpq	%r12, %rbp
	setl	%bpl
	movzbl	%bpl, %ebp
	jmp	.L1
.L22:
	cmpq	%r12, %rbp
	setle	%bpl
	movzbl	%bpl, %ebp
	jmp	.L1
.L21:
	cmpq	%r12, %rbp
	setg	%bpl
	movzbl	%bpl, %ebp
	jmp	.L1
.L20:
	cmpq	%r12, %rbp
	setge	%bpl
	movzbl	%bpl, %ebp
	jmp	.L1
.L19:
	addq	%r12, %rbp
	jmp	.L1
.L18:
	subq	%r12, %rbp
	jmp	.L1
.L17:
	imulq	%r12, %rbp
	jmp	.L1
.L16:
	testq	%r12, %r12
	je	.L36
.L26:
	movq	%rbp, %rax
	cqto
	idivq	%r12
	movq	%rax, %rbp
	jmp	.L1
.L15:
	testq	%r12, %r12
	je	.L37
.L27:
	movq	%rbp, %rax
	cqto
	idivq	%r12
	movq	%rdx, %rbp
	jmp	.L1
.L13:
	orq	%r12, %rbp
	jmp	.L1
.L14:
	andq	%r12, %rbp
	jmp	.L1
.L11:
	orq	%rbp, %r12
	setne	%bpl
	movzbl	%bpl, %ebp
	jmp	.L1
.L36:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	leaq	.LC2(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L26
.L37:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	leaq	.LC3(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L27
	.cfi_endproc
.LFE35:
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
	je	.L41
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
.L41:
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
	je	.L52
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L52:
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
.L64:
	cmpl	$1, 40(%rbx)
	je	.L62
	movl	84(%rbx), %edx
	movl	80(%rbx), %esi
	movq	%r15, %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L62:
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
	je	.L68
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
.L68:
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
	jmp	.L64
	.cfi_endproc
.LFE34:
	.size	parse_extrn_stmt, .-parse_extrn_stmt
	.p2align 4
	.globl	parse_expr
	.type	parse_expr, @function
parse_expr:
.LFB53:
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
	je	.L75
.L69:
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
.L75:
	.cfi_restore_state
	leaq	16(%rsp), %rax
	leaq	40(%rbx), %r13
	movq	%rax, 8(%rsp)
.L70:
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
	jne	.L69
	jmp	.L70
	.cfi_endproc
.LFE53:
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
	je	.L77
	movl	84(%rbx), %edx
	movl	80(%rbx), %esi
	xorl	%eax, %eax
	leaq	.LC8(%rip), %rdi
	call	dief@PLT
	movl	40(%rbx), %eax
.L77:
	leaq	40(%rbx), %r13
	leaq	16(%rsp), %r14
	leaq	16(%rbp), %r15
.L85:
	cmpl	$1, %eax
	je	.L78
	movl	84(%rbx), %edx
	movl	80(%rbx), %esi
	leaq	.LC9(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L78:
	movl	$16, %edi
	call	xmalloc@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L95
.L79:
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
	je	.L80
	subl	$2, %eax
	andl	$-3, %eax
	je	.L96
.L82:
	movq	%r12, %rsi
	movq	%r15, %rdi
	call	vec_push@PLT
	cmpl	$17, 40(%rbx)
	je	.L97
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
.L96:
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
	jmp	.L82
	.p2align 4,,10
	.p2align 3
.L95:
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L79
	.p2align 4,,10
	.p2align 3
.L97:
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
	jmp	.L85
	.p2align 4,,10
	.p2align 3
.L80:
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
	je	.L98
.L83:
	movq	%rbx, %rdi
	call	parse_expr
	movl	$20, %esi
	movq	%rbx, %rdi
	movq	%rax, 8(%r12)
	call	expect
	jmp	.L82
	.p2align 4,,10
	.p2align 3
.L98:
	movq	96(%rbx), %rsi
	leaq	.LC11(%rip), %rdx
	movq	%r13, %rdi
	xorl	%eax, %eax
	call	error_at@PLT
	jmp	.L83
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
	je	.L100
	movl	84(%r13), %edx
	movl	80(%r13), %esi
	leaq	.LC12(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L100:
	movl	$64, %edi
	call	xmalloc@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L106
.L101:
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
	je	.L107
.L102:
	movl	$0, (%rbx)
	movl	$0, 24(%rbx)
	movq	$0, 32(%rbx)
	movl	$0, 40(%rbx)
	movq	$0, 48(%rbx)
	movq	$0, 56(%rbx)
	cmpl	$19, %eax
	je	.L108
.L103:
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
.L106:
	.cfi_restore_state
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L101
	.p2align 4,,10
	.p2align 3
.L107:
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
	jmp	.L102
	.p2align 4,,10
	.p2align 3
.L108:
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
	je	.L109
	movq	%r13, %rdi
	call	parse_expr
	movl	$20, %esi
	movq	%r13, %rdi
	movq	%rax, 32(%rbx)
	call	expect
	jmp	.L103
	.p2align 4,,10
	.p2align 3
.L109:
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
	jmp	.L103
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
	je	.L111
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L112
	movl	$13, %esi
	movq	%rbx, %rdi
	call	expect
	movq	%rbx, %rdi
	call	parse_expr
	movl	$14, %esi
	movq	%rbx, %rdi
	movq	%rax, %rbp
	call	expect
.L111:
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
.L112:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	parse_expr
	movq	%rax, %rbp
	jmp	.L111
	.cfi_endproc
.LFE33:
	.size	parse_return, .-parse_return
	.section	.rodata.str1.1
.LC14:
	.string	"case outside switch at %d:%d"
	.text
	.p2align 4
	.globl	parse_case
	.type	parse_case, @function
parse_case:
.LFB40:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	$60, %esi
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$40, %rsp
	.cfi_def_cfa_offset 64
	movq	80(%rdi), %rax
	movq	%rax, 8(%rsp)
	call	expect
	movl	108(%rbp), %eax
	testl	%eax, %eax
	je	.L118
.L116:
	movq	%rbp, %rdi
	call	parse_expr
	movq	%rax, %rdi
	call	eval_const_expr
	movl	$57, %esi
	movq	%rbp, %rdi
	movq	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm0
	movaps	%xmm0, 16(%rsp)
	call	expect
	movl	$48, %edi
	call	xmalloc@PLT
	movdqa	16(%rsp), %xmm0
	movq	%rbp, %rdi
	movq	%rax, %rbx
	movl	$13, (%rax)
	movq	8(%rsp), %rax
	movq	$0, 16(%rbx)
	movq	%rax, 4(%rbx)
	movups	%xmm0, 24(%rbx)
	call	parse_case_body
	movq	%rax, 40(%rbx)
	addq	$40, %rsp
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
.L118:
	.cfi_restore_state
	movq	8(%rsp), %xmm1
	leaq	.LC14(%rip), %rdi
	xorl	%eax, %eax
	pshufd	$0xe5, %xmm1, %xmm2
	movd	%xmm1, %esi
	movd	%xmm2, %edx
	call	dief@PLT
	jmp	.L116
	.cfi_endproc
.LFE40:
	.size	parse_case, .-parse_case
	.section	.rodata.str1.8
	.align 8
.LC15:
	.string	"label expression must be an identifier at %d:%d"
	.text
	.p2align 4
	.globl	parse_stmt
	.type	parse_stmt, @function
parse_stmt:
.LFB43:
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
	je	.L148
	cmpl	$18, %eax
	je	.L126
.L149:
	subl	$5, %eax
	cmpl	$56, %eax
	ja	.L127
	leaq	.L129(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L129:
	.long	.L134-.L129
	.long	.L139-.L129
	.long	.L127-.L129
	.long	.L138-.L129
	.long	.L137-.L129
	.long	.L136-.L129
	.long	.L135-.L129
	.long	.L134-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L133-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L127-.L129
	.long	.L132-.L129
	.long	.L131-.L129
	.long	.L130-.L129
	.long	.L128-.L129
	.text
	.p2align 4,,10
	.p2align 3
.L148:
	call	peek_next_kind
	cmpl	$57, %eax
	je	.L121
	movl	40(%rbx), %eax
	cmpl	$18, %eax
	jne	.L149
.L126:
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
.L127:
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
.L119:
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
.L134:
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
	jmp	.L145
	.p2align 4,,10
	.p2align 3
.L151:
	cmpl	$12, %eax
	jne	.L150
.L145:
	cmpl	$5, %eax
	je	.L146
	movq	%rbx, %rdi
	call	parse_extrn_stmt
	movq	%rax, %rsi
.L141:
	movq	%r12, %rdi
	call	vec_push@PLT
	movl	40(%rbx), %eax
	cmpl	$5, %eax
	jne	.L151
.L146:
	movq	%rbx, %rdi
	call	parse_auto_decl
	movq	%rax, %rsi
	jmp	.L141
	.p2align 4,,10
	.p2align 3
.L136:
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
	jmp	.L119
	.p2align 4,,10
	.p2align 3
.L135:
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
	jmp	.L119
	.p2align 4,,10
	.p2align 3
.L133:
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
.L128:
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
.L131:
	.cfi_restore_state
	movl	$59, %esi
	movq	%rbx, %rdi
	movq	80(%rbx), %r14
	call	expect
	cmpl	$13, 40(%rbx)
	je	.L143
	movq	%rbx, %rdi
	call	parse_expr
	movq	%rax, %r13
.L144:
	addl	$1, 108(%rbx)
	movq	%rbx, %rdi
	call	parse_stmt
	subl	$1, 108(%rbx)
	movl	$48, %edi
	movq	%rax, %r12
	call	xmalloc@PLT
	movl	$12, (%rax)
	movq	%rax, %rbp
	movq	%r14, 4(%rax)
	movq	%r13, 16(%rax)
	movq	%r12, 24(%rax)
	jmp	.L119
	.p2align 4,,10
	.p2align 3
.L130:
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
.L132:
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
	jmp	.L119
	.p2align 4,,10
	.p2align 3
.L138:
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
.L137:
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
.L139:
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
.L150:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	parse_stmt
	movq	%r12, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L119
	.p2align 4,,10
	.p2align 3
.L121:
	movq	80(%rbx), %rax
	movq	%rbx, %rdi
	movq	%rax, 8(%rsp)
	call	parse_expr
	movl	$57, %esi
	movq	%rbx, %rdi
	movq	%rax, %r12
	call	expect
	cmpl	$2, (%r12)
	je	.L122
	movq	8(%rsp), %xmm1
	leaq	.LC15(%rip), %rdi
	xorl	%eax, %eax
	pshufd	$0xe5, %xmm1, %xmm2
	movd	%xmm1, %esi
	movd	%xmm2, %edx
	call	dief@PLT
.L122:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L123
	cmpl	$16, 40(%rbx)
	je	.L152
.L123:
	movq	%rbx, %rdi
	call	parse_stmt
	movq	%rax, %rbx
.L124:
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
	jmp	.L119
.L143:
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
	jmp	.L144
.L152:
	movq	80(%rbx), %rbp
	movl	$48, %edi
	call	xmalloc@PLT
	movl	$0, (%rax)
	movq	%rax, %rbx
	movq	%rbp, 4(%rax)
	jmp	.L124
	.cfi_endproc
.LFE43:
	.size	parse_stmt, .-parse_stmt
	.section	.rodata.str1.1
.LC16:
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
	je	.L154
	leaq	.LC16(%rip), %r12
	jmp	.L159
	.p2align 4,,10
	.p2align 3
.L155:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L156
	movl	40(%rbx), %eax
	cmpl	$5, %eax
	je	.L165
	cmpl	$12, %eax
	je	.L166
.L156:
	movq	%rbx, %rdi
	call	parse_stmt
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
.L158:
	movl	40(%rbx), %eax
	cmpl	$16, %eax
	je	.L154
.L159:
	testl	%eax, %eax
	jne	.L155
	movq	%r12, %rdi
	call	dief@PLT
	jmp	.L155
	.p2align 4,,10
	.p2align 3
.L154:
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
.L166:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	parse_extrn_stmt
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L158
	.p2align 4,,10
	.p2align 3
.L165:
	movq	%rbx, %rdi
	call	parse_auto_decl
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L158
	.cfi_endproc
.LFE30:
	.size	parse_block, .-parse_block
	.section	.rodata.str1.8
	.align 8
.LC17:
	.string	"expected function name at %d:%d"
	.align 8
.LC18:
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
	je	.L168
	movl	84(%rdi), %edx
	movl	80(%rdi), %esi
	xorl	%eax, %eax
	leaq	.LC17(%rip), %rdi
	call	dief@PLT
.L168:
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
	je	.L169
	leaq	8(%rbp), %r14
.L171:
	cmpl	$1, %eax
	jne	.L181
.L170:
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
	je	.L182
.L169:
	movl	$14, %esi
	movq	%rbx, %rdi
	call	expect
	cmpl	$15, 40(%rbx)
	je	.L183
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
.L173:
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
.L181:
	.cfi_restore_state
	movl	84(%rbx), %edx
	movl	80(%rbx), %esi
	leaq	.LC18(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L170
	.p2align 4,,10
	.p2align 3
.L183:
	movq	%rbx, %rdi
	call	parse_block
	movq	%rax, %rbx
	jmp	.L173
	.p2align 4,,10
	.p2align 3
.L182:
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
	jmp	.L171
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
	je	.L189
.L185:
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
.L189:
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
	jmp	.L185
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
	addl	$1, 104(%rbx)
	movq	%rbx, %rdi
	call	parse_stmt
	subl	$1, 104(%rbx)
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
.LFB39:
	.cfi_startproc
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L193
	movl	40(%rdi), %eax
	cmpl	$16, %eax
	je	.L198
	cmpl	$5, %eax
	je	.L201
	cmpl	$12, %eax
	je	.L202
.L193:
	jmp	parse_stmt
	.p2align 4,,10
	.p2align 3
.L202:
	jmp	parse_extrn_stmt
	.p2align 4,,10
	.p2align 3
.L198:
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
.L201:
	.cfi_restore 3
	jmp	parse_auto_decl
	.cfi_endproc
.LFE39:
	.size	parse_case_body, .-parse_case_body
	.section	.rodata.str1.8
	.align 8
.LC19:
	.string	"default outside switch at %d:%d"
	.text
	.p2align 4
	.globl	parse_default
	.type	parse_default, @function
parse_default:
.LFB41:
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
	movl	108(%rbp), %eax
	testl	%eax, %eax
	je	.L206
.L204:
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
.L206:
	.cfi_restore_state
	movq	8(%rsp), %xmm1
	leaq	.LC19(%rip), %rdi
	xorl	%eax, %eax
	pshufd	$0xe5, %xmm1, %xmm2
	movd	%xmm1, %esi
	movd	%xmm2, %edx
	call	dief@PLT
	jmp	.L204
	.cfi_endproc
.LFE41:
	.size	parse_default, .-parse_default
	.p2align 4
	.globl	parse_primary
	.type	parse_primary, @function
parse_primary:
.LFB47:
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
	ja	.L208
	movl	40(%rdi), %eax
	leaq	.L210(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L210:
	.long	.L208-.L210
	.long	.L213-.L210
	.long	.L211-.L210
	.long	.L212-.L210
	.long	.L211-.L210
	.long	.L208-.L210
	.long	.L208-.L210
	.long	.L208-.L210
	.long	.L208-.L210
	.long	.L208-.L210
	.long	.L208-.L210
	.long	.L208-.L210
	.long	.L208-.L210
	.long	.L209-.L210
	.text
	.p2align 4,,10
	.p2align 3
.L208:
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
.L211:
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
.L216:
	movq	%rax, 48(%rbp)
.L217:
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
.L213:
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
	jmp	.L216
	.p2align 4,,10
	.p2align 3
.L209:
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
.L212:
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
	jmp	.L217
	.cfi_endproc
.LFE47:
	.size	parse_primary, .-parse_primary
	.section	.rodata.str1.8
	.align 8
.LC20:
	.string	"postfix %s requires an lvalue at %d:%d"
	.text
	.p2align 4
	.globl	parse_postfix
	.type	parse_postfix, @function
parse_postfix:
.LFB48:
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
.L219:
	movl	40(%rbx), %r12d
	cmpl	$13, %r12d
	je	.L220
	cmpl	$19, %r12d
	je	.L240
	leal	-36(%r12), %eax
	cmpl	$1, %eax
	jbe	.L241
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
.L220:
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
	je	.L242
.L223:
	movq	%rbx, %rdi
	call	parse_assignment
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	cmpl	$17, 40(%rbx)
	je	.L225
	movl	$14, %esi
	movq	%rbx, %rdi
	call	expect
.L224:
	movq	%r12, %rbp
	jmp	.L219
	.p2align 4,,10
	.p2align 3
.L241:
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
	je	.L228
	movl	0(%rbp), %eax
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L229
	cmpl	$5, %eax
	je	.L243
.L228:
	movl	8(%rbp), %r14d
	movl	4(%rbp), %r13d
	movl	%r12d, %edi
	call	tk_name@PLT
	leaq	.LC20(%rip), %rdi
	movq	%rax, %rsi
	movl	%r14d, %ecx
	movl	%r13d, %edx
	xorl	%eax, %eax
	call	dief@PLT
.L229:
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
	jmp	.L219
	.p2align 4,,10
	.p2align 3
.L240:
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
	jmp	.L219
	.p2align 4,,10
	.p2align 3
.L243:
	cmpl	$32, 48(%rbp)
	jne	.L228
	jmp	.L229
	.p2align 4,,10
	.p2align 3
.L225:
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
	jmp	.L223
	.p2align 4,,10
	.p2align 3
.L242:
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
	jmp	.L224
	.cfi_endproc
.LFE48:
	.size	parse_postfix, .-parse_postfix
	.section	.rodata.str1.8
	.align 8
.LC21:
	.string	"prefix %s requires an lvalue at %d:%d"
	.section	.rodata.str1.1
.LC22:
	.string	"& requires an lvalue at %d:%d"
	.text
	.p2align 4
	.globl	parse_unary
	.type	parse_unary, @function
parse_unary:
.LFB49:
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
	ja	.L245
	movabsq	$9007446215360512, %rax
	btq	%rbp, %rax
	jnc	.L245
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
	jbe	.L264
	cmpl	$53, %ebp
	je	.L265
.L249:
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
.L245:
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
.L264:
	.cfi_restore_state
	testq	%rbx, %rbx
	je	.L248
	movl	(%rbx), %eax
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L249
	cmpl	$5, %eax
	je	.L266
.L248:
	movl	%ebp, %edi
	call	tk_name@PLT
	movl	%r13d, %ecx
	movl	%r12d, %edx
	leaq	.LC21(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L249
	.p2align 4,,10
	.p2align 3
.L265:
	testq	%rbx, %rbx
	je	.L250
	movl	(%rbx), %eax
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L249
	cmpl	$5, %eax
	je	.L267
.L250:
	movl	%r13d, %edx
	movl	%r12d, %esi
	leaq	.LC22(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L249
	.p2align 4,,10
	.p2align 3
.L266:
	cmpl	$32, 48(%rbx)
	jne	.L248
	jmp	.L249
	.p2align 4,,10
	.p2align 3
.L267:
	cmpl	$32, 48(%rbx)
	jne	.L250
	jmp	.L249
	.cfi_endproc
.LFE49:
	.size	parse_unary, .-parse_unary
	.p2align 4
	.globl	parse_bin_rhs
	.type	parse_bin_rhs, @function
parse_bin_rhs:
.LFB50:
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
	leaq	CSWTCH.16(%rip), %r13
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
	ja	.L269
.L278:
	movsbl	0(%r13,%rax), %r12d
.L269:
	cmpl	%r12d, 12(%rsp)
	jg	.L274
.L279:
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
	ja	.L271
	movsbl	0(%r13,%rax), %eax
	cmpl	%eax, %r12d
	jl	.L277
.L271:
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
	jbe	.L278
	cmpl	%r12d, 12(%rsp)
	jle	.L279
.L274:
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
.L277:
	.cfi_restore_state
	movq	%r15, %rdx
	leal	1(%r12), %esi
	movq	%r14, %rdi
	call	parse_bin_rhs
	movq	%rax, %r15
	jmp	.L271
	.cfi_endproc
.LFE50:
	.size	parse_bin_rhs, .-parse_bin_rhs
	.section	.rodata.str1.8
	.align 8
.LC23:
	.string	"left side of '%s' must be an lvalue at %d:%d"
	.text
	.p2align 4
	.globl	parse_assignment
	.type	parse_assignment, @function
parse_assignment:
.LFB51:
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
	je	.L302
	cmpl	$21, %ebp
	je	.L284
	leal	-38(%rbp), %eax
	cmpl	$14, %eax
	ja	.L280
.L284:
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
	je	.L285
.L287:
	movl	(%rbx), %eax
	movq	%rbx, %r13
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L286
	cmpl	$5, %eax
	je	.L303
.L285:
	movl	4(%rbx), %r13d
	movl	8(%rbx), %r14d
	movl	%ebp, %edi
	call	tk_name@PLT
	leaq	.LC23(%rip), %rdi
	movq	%rax, %rsi
	movl	%r13d, %edx
	movl	%r14d, %ecx
	xorl	%eax, %eax
	call	dief@PLT
	movq	%rbx, %r13
.L286:
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
.L280:
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
.L303:
	.cfi_restore_state
	cmpl	$32, 48(%rbx)
	jne	.L285
	jmp	.L286
	.p2align 4,,10
	.p2align 3
.L302:
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
	je	.L282
	leal	-38(%rbp), %eax
	movq	%r13, %rbx
	cmpl	$14, %eax
	ja	.L280
.L282:
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
	jmp	.L287
	.cfi_endproc
.LFE51:
	.size	parse_assignment, .-parse_assignment
	.p2align 4
	.globl	parse_init_list
	.type	parse_init_list, @function
parse_init_list:
.LFB44:
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
	je	.L314
.L305:
	cmpl	$15, %eax
	je	.L315
	movq	80(%rbx), %r14
	movl	$40, %edi
	call	xmalloc@PLT
	movq	%rbx, %rdi
	movl	$0, (%rax)
	movq	%rax, %r12
	movq	%r14, 4(%rax)
	call	parse_assignment
	movq	%rax, 16(%r12)
.L308:
	movq	%r12, %rsi
	movq	%r13, %rdi
	call	vec_push@PLT
	cmpl	$17, 40(%rbx)
	je	.L309
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
.L315:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	parse_init_list
	movq	%rax, %r12
	jmp	.L308
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
.L309:
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
	jmp	.L305
	.cfi_endproc
.LFE44:
	.size	parse_init_list, .-parse_init_list
	.p2align 4
	.globl	parse_init_elem
	.type	parse_init_elem, @function
parse_init_elem:
.LFB45:
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
	je	.L319
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
.L319:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	parse_init_list
	.cfi_endproc
.LFE45:
	.size	parse_init_elem, .-parse_init_elem
	.p2align 4
	.globl	parse_comma_init_list
	.type	parse_comma_init_list, @function
parse_comma_init_list:
.LFB46:
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
	ja	.L320
	movabsq	$9007205697200158, %rdx
	btq	%rax, %rdx
	jnc	.L320
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
	je	.L329
.L322:
	movq	80(%rbp), %r15
	movl	$40, %edi
	call	xmalloc@PLT
	movq	%rbp, %rdi
	movl	$0, (%rax)
	movq	%rax, %rbx
	movq	%r15, 4(%rax)
	call	parse_assignment
	movq	%rax, 16(%rbx)
.L323:
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	vec_push@PLT
	cmpl	$17, 40(%rbp)
	je	.L330
.L320:
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
.L330:
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
	jne	.L322
.L329:
	movq	%rbp, %rdi
	call	parse_init_list
	movq	%rax, %rbx
	jmp	.L323
	.cfi_endproc
.LFE46:
	.size	parse_comma_init_list, .-parse_comma_init_list
	.section	.rodata.str1.1
.LC24:
	.string	"expected identifier at %d:%d"
	.section	.rodata.str1.8
	.align 8
.LC25:
	.string	"external '=' initializer is outside Thompson B72"
	.align 8
.LC26:
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
	je	.L332
	movl	84(%rdi), %edx
	movl	80(%rdi), %esi
	xorl	%eax, %eax
	leaq	.LC24(%rip), %rdi
	call	dief@PLT
.L332:
	movl	$64, %edi
	call	xmalloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L355
.L333:
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
	je	.L334
	cmpl	$15, %eax
	je	.L356
	cmpl	$18, %eax
	je	.L357
	cmpl	$21, %eax
	je	.L358
	movq	%rbx, %rdi
	call	parse_comma_init_list
	testq	%rax, %rax
	je	.L359
	cmpl	$2, 24(%rbp)
	je	.L353
	movl	$1, 24(%rbp)
.L353:
	movq	%rax, 56(%rbp)
	movl	$18, %esi
	movq	%rbx, %rdi
	call	expect
.L331:
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
.L355:
	.cfi_restore_state
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L333
	.p2align 4,,10
	.p2align 3
.L334:
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
	je	.L360
	movq	%rbx, %rdi
	call	parse_expr
	movl	$20, %esi
	movq	%rbx, %rdi
	movq	%rax, 32(%rbp)
	call	expect
.L338:
	cmpl	$15, 40(%rbx)
	movq	%rbx, %rdi
	je	.L354
	call	parse_comma_init_list
	jmp	.L353
	.p2align 4,,10
	.p2align 3
.L356:
	movl	$1, 24(%rbp)
	movq	%rbx, %rdi
.L354:
	call	parse_init_list
	jmp	.L353
	.p2align 4,,10
	.p2align 3
.L357:
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
	jmp	.L331
	.p2align 4,,10
	.p2align 3
.L359:
	movq	16(%rbp), %rsi
	movl	84(%rbx), %ecx
	leaq	.LC26(%rip), %rdi
	xorl	%eax, %eax
	movl	80(%rbx), %edx
	xorl	%ebp, %ebp
	call	dief@PLT
	jmp	.L331
	.p2align 4,,10
	.p2align 3
.L358:
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
	jne	.L361
.L346:
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
	jmp	.L331
	.p2align 4,,10
	.p2align 3
.L361:
	movq	96(%rbx), %rsi
	leaq	.LC25(%rip), %rdx
	movq	%r12, %rdi
	xorl	%eax, %eax
	call	error_at@PLT
	jmp	.L346
	.p2align 4,,10
	.p2align 3
.L360:
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
	jmp	.L338
	.cfi_endproc
.LFE28:
	.size	parse_extern_var_def, .-parse_extern_var_def
	.section	.rodata.str1.8
	.align 8
.LC27:
	.string	"top-level auto is outside Thompson B72"
	.align 8
.LC28:
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
	je	.L362
	leaq	.LC28(%rip), %r13
	jmp	.L370
	.p2align 4,,10
	.p2align 3
.L366:
	cmpl	$1, %edi
	je	.L373
	call	tk_name@PLT
	movq	%r13, %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
.L365:
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	vec_push@PLT
	movl	40(%rbp), %eax
	testl	%eax, %eax
	je	.L362
.L370:
	movl	$16, %edi
	call	xmalloc@PLT
	movl	40(%rbp), %edi
	movq	%rax, %rbx
	cmpl	$12, %edi
	je	.L374
	cmpl	$5, %edi
	jne	.L366
	movl	g_strict(%rip), %edx
	testl	%edx, %edx
	jne	.L375
.L367:
	movl	$0, (%rbx)
	movq	%rbp, %rdi
	call	parse_auto_decl
	movq	%rax, 8(%rbx)
	jmp	.L365
	.p2align 4,,10
	.p2align 3
.L374:
	movl	$3, (%rax)
	movq	%rbp, %rdi
	call	parse_extern_decl
	movq	%rax, 8(%rbx)
	jmp	.L365
	.p2align 4,,10
	.p2align 3
.L373:
	movq	%rbp, %rdi
	call	peek_next_kind
	cmpl	$13, %eax
	je	.L376
	movl	$2, (%rbx)
	movq	%rbp, %rdi
	call	parse_extern_var_def
	movq	%rax, 8(%rbx)
	jmp	.L365
	.p2align 4,,10
	.p2align 3
.L362:
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
.L375:
	.cfi_restore_state
	movq	96(%rbp), %rsi
	leaq	40(%rbp), %rdi
	leaq	.LC27(%rip), %rdx
	xorl	%eax, %eax
	call	error_at@PLT
	jmp	.L367
	.p2align 4,,10
	.p2align 3
.L376:
	movl	$1, (%rbx)
	movq	%rbp, %rdi
	call	parse_function
	movq	%rax, 8(%rbx)
	jmp	.L365
	.cfi_endproc
.LFE25:
	.size	parse_program_ast, .-parse_program_ast
	.section	.rodata
	.align 32
	.type	CSWTCH.16, @object
	.size	CSWTCH.16, 34
CSWTCH.16:
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
