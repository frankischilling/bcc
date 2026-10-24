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
	movq	32(%rbx), %rbp
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
	movq	40(%rbx), %rdi
	call	eval_const_expr
	movq	48(%rbx), %rdi
	movq	%rax, %rbp
	call	eval_const_expr
	movq	%rax, %r12
	movl	32(%rbx), %eax
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
	movq	40(%rbx), %rdi
	call	eval_const_expr
	movl	32(%rbx), %edx
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
	movl	$64, %edi
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
	movl	$0, 60(%rax)
	movl	%r12d, (%rax)
	movl	%ebp, 4(%rax)
	movl	%ebx, 8(%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 28(%rax)
	movups	%xmm0, 44(%rax)
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
	movl	$40, %edi
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
	.section	.rodata.str1.8
	.align 8
.LC8:
	.string	"default outside switch at %d:%d"
	.text
	.p2align 4
	.globl	parse_default
	.type	parse_default, @function
parse_default:
.LFB40:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$61, %esi
	movq	%rdi, %rbx
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	movq	80(%rdi), %rax
	movq	%rax, 8(%rsp)
	call	expect
	movl	108(%rbx), %eax
	testl	%eax, %eax
	je	.L72
.L70:
	movq	%rbx, %rdi
	movl	$57, %esi
	call	expect
	movl	$40, %edi
	call	xmalloc@PLT
	movq	8(%rsp), %rcx
	pcmpeqd	%xmm0, %xmm0
	movl	$13, (%rax)
	movq	%rcx, 4(%rax)
	movq	$0, 16(%rax)
	movups	%xmm0, 24(%rax)
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L72:
	.cfi_restore_state
	movq	8(%rsp), %xmm1
	leaq	.LC8(%rip), %rdi
	xorl	%eax, %eax
	pshufd	$0xe5, %xmm1, %xmm2
	movd	%xmm1, %esi
	movd	%xmm2, %edx
	call	dief@PLT
	jmp	.L70
	.cfi_endproc
.LFE40:
	.size	parse_default, .-parse_default
	.p2align 4
	.globl	parse_expr
	.type	parse_expr, @function
parse_expr:
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
	je	.L79
.L73:
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
.L79:
	.cfi_restore_state
	leaq	16(%rsp), %rax
	leaq	40(%rbx), %r14
	movq	%rax, 8(%rsp)
.L74:
	movq	%r14, %rdi
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
	movq	4(%rbp), %r13
	movl	$64, %edi
	movq	%rax, %r12
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 28(%rax)
	movq	%rax, %rbp
	movups	%xmm0, 44(%rax)
	movl	$0, 60(%rax)
	movq	%r13, 4(%rax)
	movups	%xmm0, 12(%rax)
	cmpl	$17, 40(%rbx)
	movl	$10, (%rax)
	movq	%r15, 32(%rax)
	movq	%r12, 40(%rax)
	jne	.L73
	jmp	.L74
	.cfi_endproc
.LFE52:
	.size	parse_expr, .-parse_expr
	.section	.rodata.str1.8
	.align 8
.LC9:
	.string	"expected identifier after auto at %d:%d"
	.align 8
.LC10:
	.string	"expected identifier in auto decl at %d:%d"
	.section	.rodata.str1.1
.LC11:
	.string	"out of memory"
	.section	.rodata.str1.8
	.align 8
.LC12:
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
	movl	$40, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movl	$2, (%rax)
	movq	%rax, %rbp
	movq	%r12, 4(%rax)
	movq	$0, 16(%rax)
	movups	%xmm0, 24(%rax)
	movl	40(%rbx), %eax
	cmpl	$1, %eax
	je	.L81
	movl	84(%rbx), %edx
	movl	80(%rbx), %esi
	xorl	%eax, %eax
	leaq	.LC9(%rip), %rdi
	call	dief@PLT
	movl	40(%rbx), %eax
.L81:
	leaq	40(%rbx), %r13
	leaq	16(%rsp), %r14
	leaq	16(%rbp), %r15
.L89:
	cmpl	$1, %eax
	je	.L82
	movl	84(%rbx), %edx
	movl	80(%rbx), %esi
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L82:
	movl	$16, %edi
	call	xmalloc@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L99
.L83:
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
	je	.L84
	cmpl	$2, %eax
	je	.L100
.L86:
	movq	%r12, %rsi
	movq	%r15, %rdi
	call	vec_push@PLT
	cmpl	$17, 40(%rbx)
	je	.L101
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
.L100:
	.cfi_restore_state
	movq	80(%rbx), %rcx
	movl	$64, %edi
	movq	%rcx, 8(%rsp)
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	8(%rsp), %rcx
	movq	%r13, %rdi
	movups	%xmm0, 28(%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 44(%rax)
	movl	$0, 60(%rax)
	movq	72(%rbx), %rdx
	movl	$0, (%rax)
	movq	%rcx, 4(%rax)
	movq	%rax, 8(%r12)
	movq	%rdx, 32(%rax)
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
	jmp	.L86
	.p2align 4,,10
	.p2align 3
.L99:
	leaq	.LC11(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L83
	.p2align 4,,10
	.p2align 3
.L101:
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
	jmp	.L89
	.p2align 4,,10
	.p2align 3
.L84:
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
	je	.L102
.L87:
	movq	%rbx, %rdi
	call	parse_expr
	movl	$20, %esi
	movq	%rbx, %rdi
	movq	%rax, 8(%r12)
	call	expect
	jmp	.L86
	.p2align 4,,10
	.p2align 3
.L102:
	movq	96(%rbx), %rsi
	leaq	.LC12(%rip), %rdx
	movq	%r13, %rdi
	xorl	%eax, %eax
	call	error_at@PLT
	jmp	.L87
	.cfi_endproc
.LFE26:
	.size	parse_auto_decl, .-parse_auto_decl
	.section	.rodata.str1.8
	.align 8
.LC13:
	.string	"expected identifier after extrn at %d:%d"
	.align 8
.LC14:
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
	je	.L104
	movl	84(%r13), %edx
	movl	80(%r13), %esi
	leaq	.LC13(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L104:
	movl	$56, %edi
	call	xmalloc@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L110
.L105:
	pxor	%xmm0, %xmm0
	movq	$0, 48(%rbx)
	leaq	40(%r13), %r12
	movq	%rsp, %rbp
	movups	%xmm0, (%rbx)
	movups	%xmm0, 16(%rbx)
	movups	%xmm0, 32(%rbx)
	movq	48(%r13), %rdi
	call	sdup@PLT
	movq	%r12, %rdi
	movq	%rax, 8(%rbx)
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
	je	.L111
.L106:
	movl	$0, (%rbx)
	movl	$0, 16(%rbx)
	movq	$0, 24(%rbx)
	movl	$0, 32(%rbx)
	movq	$0, 40(%rbx)
	movq	$0, 48(%rbx)
	cmpl	$19, %eax
	je	.L112
.L107:
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
.L110:
	.cfi_restore_state
	leaq	.LC11(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L105
	.p2align 4,,10
	.p2align 3
.L111:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%r13, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	leaq	.LC14(%rip), %rdi
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
	jmp	.L106
	.p2align 4,,10
	.p2align 3
.L112:
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
	movl	$2, 16(%rbx)
	je	.L113
	movq	%r13, %rdi
	call	parse_expr
	movl	$20, %esi
	movq	%r13, %rdi
	movq	%rax, 24(%rbx)
	call	expect
	jmp	.L107
	.p2align 4,,10
	.p2align 3
.L113:
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
	movl	$1, 32(%rbx)
	jmp	.L107
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
	je	.L115
	movq	%rbx, %rdi
	call	parse_expr
	movq	%rax, %rbp
.L115:
	movq	%rbx, %rdi
	movl	$18, %esi
	call	expect
	movl	$40, %edi
	call	xmalloc@PLT
	movl	$5, (%rax)
	movq	%r12, 4(%rax)
	movq	%rbp, 16(%rax)
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE33:
	.size	parse_return, .-parse_return
	.section	.rodata.str1.1
.LC15:
	.string	"case outside switch at %d:%d"
	.text
	.p2align 4
	.globl	parse_case
	.type	parse_case, @function
parse_case:
.LFB39:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$60, %esi
	movq	%rdi, %rbx
	subq	$32, %rsp
	.cfi_def_cfa_offset 48
	movq	80(%rdi), %rax
	movq	%rax, 8(%rsp)
	call	expect
	movl	108(%rbx), %eax
	testl	%eax, %eax
	je	.L122
.L120:
	movq	%rbx, %rdi
	call	parse_expr
	movq	%rax, %rdi
	call	eval_const_expr
	movq	%rbx, %rdi
	movl	$57, %esi
	movq	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm0
	movaps	%xmm0, 16(%rsp)
	call	expect
	movl	$40, %edi
	call	xmalloc@PLT
	movq	8(%rsp), %rcx
	movdqa	16(%rsp), %xmm0
	movl	$13, (%rax)
	movq	%rcx, 4(%rax)
	movq	$0, 16(%rax)
	movups	%xmm0, 24(%rax)
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L122:
	.cfi_restore_state
	movq	8(%rsp), %xmm1
	leaq	.LC15(%rip), %rdi
	xorl	%eax, %eax
	pshufd	$0xe5, %xmm1, %xmm2
	movd	%xmm1, %esi
	movd	%xmm2, %edx
	call	dief@PLT
	jmp	.L120
	.cfi_endproc
.LFE39:
	.size	parse_case, .-parse_case
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
	movl	$40, %edi
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
	.section	.rodata.str1.8
	.align 8
.LC16:
	.string	"label expression must be an identifier at %d:%d"
	.text
	.p2align 4
	.globl	parse_stmt
	.type	parse_stmt, @function
parse_stmt:
.LFB42:
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
	movl	40(%rdi), %eax
	cmpl	$1, %eax
	je	.L156
	cmpl	$18, %eax
	je	.L135
.L157:
	subl	$5, %eax
	cmpl	$56, %eax
	ja	.L136
	leaq	.L138(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L138:
	.long	.L149-.L138
	.long	.L148-.L138
	.long	.L136-.L138
	.long	.L147-.L138
	.long	.L146-.L138
	.long	.L145-.L138
	.long	.L144-.L138
	.long	.L143-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L142-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L136-.L138
	.long	.L141-.L138
	.long	.L140-.L138
	.long	.L139-.L138
	.long	.L137-.L138
	.text
	.p2align 4,,10
	.p2align 3
.L156:
	call	peek_next_kind
	cmpl	$57, %eax
	je	.L127
	movl	40(%rbx), %eax
	cmpl	$18, %eax
	jne	.L157
.L135:
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movl	$40, %edi
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	64(%rsp), %rax
	movq	80(%rbx), %rbp
	movq	%rax, 88(%rbx)
	call	xmalloc@PLT
	movl	$0, (%rax)
	movq	%rax, %rbx
	movq	%rbp, 4(%rax)
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
.L136:
	.cfi_restore_state
	movq	%rbx, %rdi
	movq	80(%rbx), %r12
	call	parse_expr
	movq	%rbx, %rdi
	movl	$18, %esi
	movq	%rax, %rbp
	call	expect
	movl	$40, %edi
	call	xmalloc@PLT
	movl	$6, (%rax)
	movq	%rax, %rbx
	movq	%r12, 4(%rax)
	movq	%rbp, 16(%rax)
.L125:
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
.L149:
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
	jmp	parse_auto_decl
	.p2align 4,,10
	.p2align 3
.L148:
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
	jmp	parse_if
	.p2align 4,,10
	.p2align 3
.L147:
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
	jmp	parse_while
	.p2align 4,,10
	.p2align 3
.L146:
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
	jmp	parse_return
	.p2align 4,,10
	.p2align 3
.L145:
	.cfi_restore_state
	leaq	40(%rbx), %rdi
	movq	80(%rbx), %rbp
	call	tok_free@PLT
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movq	%rbx, %rdi
	movl	$18, %esi
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	call	expect
	movl	$40, %edi
	call	xmalloc@PLT
	movl	$8, (%rax)
	movq	%rax, %rbx
	movq	%rbp, 4(%rax)
	jmp	.L125
	.p2align 4,,10
	.p2align 3
.L144:
	leaq	40(%rbx), %rdi
	movq	80(%rbx), %rbp
	call	tok_free@PLT
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movq	%rbx, %rdi
	movl	$18, %esi
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	64(%rsp), %rax
	movq	%rax, 88(%rbx)
	call	expect
	movl	$40, %edi
	call	xmalloc@PLT
	movl	$9, (%rax)
	movq	%rax, %rbx
	movq	%rbp, 4(%rax)
	jmp	.L125
	.p2align 4,,10
	.p2align 3
.L143:
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
	jmp	parse_extrn_stmt
	.p2align 4,,10
	.p2align 3
.L142:
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
	jmp	parse_block
	.p2align 4,,10
	.p2align 3
.L141:
	.cfi_restore_state
	movl	$58, %esi
	movq	%rbx, %rdi
	movq	80(%rbx), %r12
	call	expect
	movq	%rbx, %rdi
	call	parse_expr
	movq	%rbx, %rdi
	movl	$18, %esi
	movq	%rax, %rbp
	call	expect
	movl	$40, %edi
	call	xmalloc@PLT
	movl	$10, (%rax)
	movq	%rax, %rbx
	movq	%r12, 4(%rax)
	movq	%rbp, 16(%rax)
	jmp	.L125
	.p2align 4,,10
	.p2align 3
.L140:
	movl	$59, %esi
	movq	%rbx, %rdi
	movq	80(%rbx), %r13
	call	expect
	cmpl	$13, 40(%rbx)
	je	.L150
	movq	%rbx, %rdi
	call	parse_expr
	movq	%rax, %r12
.L151:
	addl	$1, 108(%rbx)
	movq	%rbx, %rdi
	call	parse_stmt
	subl	$1, 108(%rbx)
	movl	$40, %edi
	movq	%rax, %rbp
	call	xmalloc@PLT
	movl	$12, (%rax)
	movq	%rax, %rbx
	movq	%r13, 4(%rax)
	movq	%r12, 16(%rax)
	movq	%rbp, 24(%rax)
	jmp	.L125
	.p2align 4,,10
	.p2align 3
.L139:
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
	jmp	parse_case
	.p2align 4,,10
	.p2align 3
.L137:
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
	jmp	parse_default
	.p2align 4,,10
	.p2align 3
.L127:
	.cfi_restore_state
	movq	80(%rbx), %rax
	movq	%rbx, %rdi
	movq	%rax, 8(%rsp)
	call	parse_expr
	movl	$57, %esi
	movq	%rbx, %rdi
	movq	%rax, %r12
	call	expect
	cmpl	$2, (%r12)
	je	.L128
	movq	8(%rsp), %xmm1
	leaq	.LC16(%rip), %rdi
	xorl	%eax, %eax
	pshufd	$0xe5, %xmm1, %xmm2
	movd	%xmm1, %esi
	movd	%xmm2, %edx
	call	dief@PLT
.L128:
	movl	40(%rbx), %eax
	leal	-60(%rax), %edx
	cmpl	$1, %edx
	jbe	.L133
	cmpl	$16, %eax
	je	.L133
	cmpl	$1, %eax
	je	.L158
.L132:
	movq	%rbx, %rdi
	call	parse_stmt
	movq	%rax, %rbp
.L131:
	movl	$40, %edi
	call	xmalloc@PLT
	movq	%rax, %rbx
	movl	$11, (%rax)
	movq	8(%rsp), %rax
	movq	%rax, 4(%rbx)
	movq	32(%r12), %rdi
	call	sdup@PLT
	movq	%rbp, 24(%rbx)
	movq	%rax, 16(%rbx)
	jmp	.L125
.L158:
	movq	%rbx, %rdi
	call	peek_next_kind
	cmpl	$57, %eax
	jne	.L132
	.p2align 4
	.p2align 3
.L133:
	movq	80(%rbx), %rbx
	movl	$40, %edi
	call	xmalloc@PLT
	movl	$0, (%rax)
	movq	%rax, %rbp
	movq	%rbx, 4(%rax)
	jmp	.L131
.L150:
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
	movq	%rax, %r12
	call	expect
	jmp	.L151
	.cfi_endproc
.LFE42:
	.size	parse_stmt, .-parse_stmt
	.section	.rodata.str1.1
.LC17:
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
	je	.L160
	leaq	.LC17(%rip), %r12
	jmp	.L162
	.p2align 4,,10
	.p2align 3
.L161:
	movq	%rbx, %rdi
	call	parse_stmt
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movl	40(%rbx), %eax
	cmpl	$16, %eax
	je	.L160
.L162:
	testl	%eax, %eax
	jne	.L161
	movq	%r12, %rdi
	call	dief@PLT
	jmp	.L161
	.p2align 4,,10
	.p2align 3
.L160:
	movq	%rbx, %rdi
	movl	$16, %esi
	call	expect
	movl	$40, %edi
	call	xmalloc@PLT
	movdqu	0(%rbp), %xmm0
	movl	$1, (%rax)
	movups	%xmm0, 16(%rax)
	movq	16(%rbp), %rdx
	movq	%r13, 4(%rax)
	movq	%rdx, 32(%rax)
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
.LFE30:
	.size	parse_block, .-parse_block
	.section	.rodata.str1.8
	.align 8
.LC18:
	.string	"expected function name at %d:%d"
	.align 8
.LC19:
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
	je	.L169
	movl	84(%rdi), %edx
	movl	80(%rdi), %esi
	xorl	%eax, %eax
	leaq	.LC18(%rip), %rdi
	call	dief@PLT
.L169:
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
	je	.L170
	leaq	8(%rbp), %r14
.L172:
	cmpl	$1, %eax
	jne	.L182
.L171:
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
	je	.L183
.L170:
	movl	$14, %esi
	movq	%rbx, %rdi
	call	expect
	cmpl	$15, 40(%rbx)
	je	.L184
	movq	%rbx, %rdi
	movq	80(%rbx), %r13
	call	parse_stmt
	movl	$40, %edi
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
.L174:
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
.L182:
	.cfi_restore_state
	movl	84(%rbx), %edx
	movl	80(%rbx), %esi
	leaq	.LC19(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L171
	.p2align 4,,10
	.p2align 3
.L184:
	movq	%rbx, %rdi
	call	parse_block
	movq	%rax, %rbx
	jmp	.L174
	.p2align 4,,10
	.p2align 3
.L183:
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
	jmp	.L172
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
	je	.L190
.L186:
	movl	$40, %edi
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
.L190:
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
	jmp	.L186
	.cfi_endproc
.LFE31:
	.size	parse_if, .-parse_if
	.p2align 4
	.globl	parse_primary
	.type	parse_primary, @function
parse_primary:
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
	movq	%rdi, %rbx
	subq	$64, %rsp
	.cfi_def_cfa_offset 96
	cmpl	$13, 40(%rdi)
	movq	80(%rdi), %r12
	ja	.L192
	movl	40(%rdi), %eax
	leaq	.L194(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L194:
	.long	.L192-.L194
	.long	.L197-.L194
	.long	.L195-.L194
	.long	.L196-.L194
	.long	.L195-.L194
	.long	.L192-.L194
	.long	.L192-.L194
	.long	.L192-.L194
	.long	.L192-.L194
	.long	.L192-.L194
	.long	.L192-.L194
	.long	.L192-.L194
	.long	.L192-.L194
	.long	.L193-.L194
	.text
	.p2align 4,,10
	.p2align 3
.L192:
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
.L195:
	.cfi_restore_state
	movl	$64, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movl	$0, 60(%rax)
	movq	%rax, %rbp
	movl	$0, (%rax)
	movq	%r12, 4(%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 28(%rax)
	movups	%xmm0, 44(%rax)
	movq	72(%rbx), %rax
.L200:
	movq	%rax, 32(%rbp)
.L201:
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
.L197:
	.cfi_restore_state
	movl	$64, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movl	$0, 60(%rax)
	movq	%rax, %rbp
	movq	%r12, 4(%rax)
	movl	$2, (%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 28(%rax)
	movups	%xmm0, 44(%rax)
	movq	48(%rbx), %rdi
	call	sdup@PLT
	jmp	.L200
	.p2align 4,,10
	.p2align 3
.L193:
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
.L196:
	.cfi_restore_state
	movl	$64, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 12(%rax)
	movq	%rax, %rbp
	movups	%xmm0, 28(%rax)
	movups	%xmm0, 44(%rax)
	movl	$0, 60(%rax)
	movq	56(%rbx), %rdi
	movq	%r12, 4(%rax)
	movq	%rdi, 24(%rax)
	addq	$1, %rdi
	movl	$1, (%rax)
	call	xmalloc@PLT
	movq	48(%rbx), %rsi
	movq	%rax, 32(%rbp)
	movq	%rax, %rdi
	movq	24(%rbp), %rax
	leaq	1(%rax), %rdx
	call	memcpy@PLT
	jmp	.L201
	.cfi_endproc
.LFE46:
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
.L203:
	movl	40(%rbx), %r12d
	cmpl	$13, %r12d
	je	.L204
	cmpl	$19, %r12d
	je	.L224
	leal	-36(%r12), %eax
	cmpl	$1, %eax
	jbe	.L225
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
.L204:
	.cfi_restore_state
	leaq	40(%rbx), %r14
	movq	%rsp, %r13
	movq	%r14, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movl	$64, %edi
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
	movups	%xmm0, 28(%rax)
	movq	%rax, %r12
	movl	$0, 60(%rax)
	movq	%r15, 4(%rax)
	movups	%xmm0, 12(%rax)
	movups	%xmm0, 44(%rax)
	cmpl	$14, 40(%rbx)
	movq	%rbp, 32(%rax)
	leaq	40(%rax), %rbp
	movl	$3, (%rax)
	je	.L226
.L207:
	movq	%rbx, %rdi
	call	parse_assignment
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	cmpl	$17, 40(%rbx)
	je	.L209
	movl	$14, %esi
	movq	%rbx, %rdi
	call	expect
.L208:
	movq	%r12, %rbp
	jmp	.L203
	.p2align 4,,10
	.p2align 3
.L225:
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
	je	.L212
	movl	0(%rbp), %eax
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L213
	cmpl	$5, %eax
	je	.L227
.L212:
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
.L213:
	movq	4(%rbp), %r13
	movl	$64, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 28(%rax)
	movups	%xmm0, 44(%rax)
	movl	$0, 60(%rax)
	movq	%rbp, 40(%rax)
	movq	%rax, %rbp
	movl	$6, (%rax)
	movq	%r13, 4(%rax)
	movl	%r12d, 32(%rax)
	movups	%xmm0, 12(%rax)
	jmp	.L203
	.p2align 4,,10
	.p2align 3
.L224:
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
	movl	$64, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 28(%rax)
	movups	%xmm0, 44(%rax)
	movq	%rbp, 32(%rax)
	movq	%rax, %rbp
	movl	$0, 60(%rax)
	movl	$4, (%rax)
	movq	%r13, 4(%rax)
	movq	%r12, 40(%rax)
	movups	%xmm0, 12(%rax)
	jmp	.L203
	.p2align 4,,10
	.p2align 3
.L227:
	cmpl	$32, 32(%rbp)
	jne	.L212
	jmp	.L213
	.p2align 4,,10
	.p2align 3
.L209:
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
	jmp	.L207
	.p2align 4,,10
	.p2align 3
.L226:
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
	jmp	.L208
	.cfi_endproc
.LFE47:
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
.LFB48:
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
	ja	.L229
	movabsq	$9007446215360512, %rax
	btq	%rbp, %rax
	jnc	.L229
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
	jbe	.L248
	cmpl	$53, %ebp
	je	.L249
.L233:
	movl	$64, %edi
	call	xmalloc@PLT
	movq	8(%rsp), %rcx
	pxor	%xmm0, %xmm0
	movups	%xmm0, 28(%rax)
	movups	%xmm0, 44(%rax)
	movl	$0, 60(%rax)
	movl	$5, (%rax)
	movq	%rcx, 4(%rax)
	movl	%ebp, 32(%rax)
	movq	%rbx, 40(%rax)
	movups	%xmm0, 12(%rax)
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
.L229:
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
.L248:
	.cfi_restore_state
	testq	%rbx, %rbx
	je	.L232
	movl	(%rbx), %eax
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L233
	cmpl	$5, %eax
	je	.L250
.L232:
	movl	%ebp, %edi
	call	tk_name@PLT
	movl	%r13d, %ecx
	movl	%r12d, %edx
	leaq	.LC21(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L233
	.p2align 4,,10
	.p2align 3
.L249:
	testq	%rbx, %rbx
	je	.L234
	movl	(%rbx), %eax
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L233
	cmpl	$5, %eax
	je	.L251
.L234:
	movl	%r13d, %edx
	movl	%r12d, %esi
	leaq	.LC22(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L233
	.p2align 4,,10
	.p2align 3
.L250:
	cmpl	$32, 32(%rbx)
	jne	.L232
	jmp	.L233
	.p2align 4,,10
	.p2align 3
.L251:
	cmpl	$32, 32(%rbx)
	jne	.L234
	jmp	.L233
	.cfi_endproc
.LFE48:
	.size	parse_unary, .-parse_unary
	.p2align 4
	.globl	parse_bin_rhs
	.type	parse_bin_rhs, @function
parse_bin_rhs:
.LFB49:
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
	leaq	CSWTCH.6(%rip), %r13
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
	ja	.L253
.L262:
	movsbl	0(%r13,%rax), %r12d
.L253:
	cmpl	%r12d, 12(%rsp)
	jg	.L258
.L263:
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
	ja	.L255
	movsbl	0(%r13,%rax), %eax
	cmpl	%eax, %r12d
	jl	.L261
.L255:
	movq	4(%rbx), %r12
	movl	$64, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 28(%rax)
	movups	%xmm0, 44(%rax)
	movq	%r12, 4(%rax)
	xorl	%r12d, %r12d
	movl	$0, 60(%rax)
	movl	%ebp, 32(%rax)
	movups	%xmm0, 12(%rax)
	movl	40(%r14), %ebp
	movq	%rbx, 40(%rax)
	movq	%rax, %rbx
	movl	$7, (%rax)
	movq	%r15, 48(%rax)
	leal	-22(%rbp), %eax
	cmpl	$33, %eax
	jbe	.L262
	cmpl	%r12d, 12(%rsp)
	jle	.L263
.L258:
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
.L261:
	.cfi_restore_state
	movq	%r15, %rdx
	leal	1(%r12), %esi
	movq	%r14, %rdi
	call	parse_bin_rhs
	movq	%rax, %r15
	jmp	.L255
	.cfi_endproc
.LFE49:
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
.LFB50:
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
	je	.L286
	cmpl	$21, %ebp
	je	.L268
	leal	-38(%rbp), %eax
	cmpl	$14, %eax
	ja	.L264
.L268:
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
	je	.L269
.L271:
	movl	(%rbx), %eax
	movq	%rbx, %r13
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L270
	cmpl	$5, %eax
	je	.L287
.L269:
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
.L270:
	movq	%r12, %rdi
	call	parse_assignment
	movq	4(%rbx), %r14
	movl	$64, %edi
	movq	%rax, %r12
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 28(%rax)
	movq	%rax, %rbx
	movups	%xmm0, 44(%rax)
	movl	$0, 60(%rax)
	movl	$8, (%rax)
	movq	%r14, 4(%rax)
	movl	%ebp, 32(%rax)
	movq	%r13, 40(%rax)
	movq	%r12, 48(%rax)
	movups	%xmm0, 12(%rax)
.L264:
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
.L287:
	.cfi_restore_state
	cmpl	$32, 32(%rbx)
	jne	.L269
	jmp	.L270
	.p2align 4,,10
	.p2align 3
.L286:
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
	movl	$64, %edi
	movq	%rax, %rbp
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 28(%rax)
	movq	%rax, %r13
	movups	%xmm0, 44(%rax)
	movl	$0, 60(%rax)
	movq	%r15, 4(%rax)
	movq	%rbp, 48(%rax)
	movups	%xmm0, 12(%rax)
	movl	40(%r12), %ebp
	movl	$9, (%rax)
	movq	%rbx, 32(%rax)
	movq	%r14, 40(%rax)
	cmpl	$21, %ebp
	je	.L266
	leal	-38(%rbp), %eax
	movq	%r13, %rbx
	cmpl	$14, %eax
	ja	.L264
.L266:
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
	jmp	.L271
	.cfi_endproc
.LFE50:
	.size	parse_assignment, .-parse_assignment
	.p2align 4
	.globl	parse_init_list
	.type	parse_init_list, @function
parse_init_list:
.LFB43:
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
	je	.L298
.L289:
	cmpl	$15, %eax
	je	.L299
	movq	80(%rbx), %r14
	movl	$40, %edi
	call	xmalloc@PLT
	movq	%rbx, %rdi
	movl	$0, (%rax)
	movq	%rax, %r12
	movq	%r14, 4(%rax)
	call	parse_assignment
	movq	%rax, 16(%r12)
.L292:
	movq	%r12, %rsi
	movq	%r13, %rdi
	call	vec_push@PLT
	cmpl	$17, 40(%rbx)
	je	.L293
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
.L299:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	parse_init_list
	movq	%rax, %r12
	jmp	.L292
	.p2align 4,,10
	.p2align 3
.L298:
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
.L293:
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
	jmp	.L289
	.cfi_endproc
.LFE43:
	.size	parse_init_list, .-parse_init_list
	.p2align 4
	.globl	parse_init_elem
	.type	parse_init_elem, @function
parse_init_elem:
.LFB44:
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
	je	.L303
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
.L303:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	parse_init_list
	.cfi_endproc
.LFE44:
	.size	parse_init_elem, .-parse_init_elem
	.p2align 4
	.globl	parse_comma_init_list
	.type	parse_comma_init_list, @function
parse_comma_init_list:
.LFB45:
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
	ja	.L304
	movabsq	$9007205697200158, %rdx
	btq	%rax, %rdx
	jnc	.L304
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
	je	.L313
.L306:
	movq	80(%rbp), %r15
	movl	$40, %edi
	call	xmalloc@PLT
	movq	%rbp, %rdi
	movl	$0, (%rax)
	movq	%rax, %rbx
	movq	%r15, 4(%rax)
	call	parse_assignment
	movq	%rax, 16(%rbx)
.L307:
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	vec_push@PLT
	cmpl	$17, 40(%rbp)
	je	.L314
.L304:
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
.L314:
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
	jne	.L306
.L313:
	movq	%rbp, %rdi
	call	parse_init_list
	movq	%rax, %rbx
	jmp	.L307
	.cfi_endproc
.LFE45:
	.size	parse_comma_init_list, .-parse_comma_init_list
	.section	.rodata.str1.1
.LC24:
	.string	"expected identifier at %d:%d"
	.section	.rodata.str1.8
	.align 8
.LC25:
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
	je	.L316
	movl	84(%rdi), %edx
	movl	80(%rdi), %esi
	xorl	%eax, %eax
	leaq	.LC24(%rip), %rdi
	call	dief@PLT
.L316:
	movl	$56, %edi
	call	xmalloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L335
.L317:
	pxor	%xmm0, %xmm0
	movq	$0, 48(%rbp)
	leaq	40(%rbx), %r13
	movups	%xmm0, 0(%rbp)
	movups	%xmm0, 16(%rbp)
	movups	%xmm0, 32(%rbp)
	movq	48(%rbx), %rdi
	call	sdup@PLT
	movq	%r13, %rdi
	movq	%rax, 8(%rbp)
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
	je	.L318
	cmpl	$15, %eax
	je	.L336
	cmpl	$18, %eax
	je	.L337
	cmpl	$21, %eax
	je	.L338
	movq	%rbx, %rdi
	call	parse_comma_init_list
	testq	%rax, %rax
	je	.L329
	cmpl	$2, 16(%rbp)
	je	.L333
	movl	$1, 16(%rbp)
.L333:
	movq	%rax, 48(%rbp)
	movl	$18, %esi
	movq	%rbx, %rdi
	call	expect
.L315:
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
.L335:
	.cfi_restore_state
	leaq	.LC11(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L317
	.p2align 4,,10
	.p2align 3
.L318:
	movq	%r13, %rdi
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
	movl	$2, 16(%rbp)
	je	.L339
	movq	%rbx, %rdi
	call	parse_expr
	movl	$20, %esi
	movq	%rbx, %rdi
	movq	%rax, 24(%rbp)
	call	expect
.L322:
	cmpl	$15, 40(%rbx)
	movq	%rbx, %rdi
	je	.L334
	call	parse_comma_init_list
	jmp	.L333
	.p2align 4,,10
	.p2align 3
.L336:
	movl	$1, 16(%rbp)
	movq	%rbx, %rdi
.L334:
	call	parse_init_list
	jmp	.L333
	.p2align 4,,10
	.p2align 3
.L337:
	movq	%r13, %rdi
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
	movl	$0, 16(%rbp)
	movq	$0, 48(%rbp)
	jmp	.L315
	.p2align 4,,10
	.p2align 3
.L329:
	movq	8(%rbp), %rsi
	movl	84(%rbx), %ecx
	leaq	.LC25(%rip), %rdi
	xorl	%eax, %eax
	movl	80(%rbx), %edx
	xorl	%ebp, %ebp
	call	dief@PLT
	jmp	.L315
	.p2align 4,,10
	.p2align 3
.L338:
	movq	%r13, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movl	$40, %edi
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	48(%rsp), %rax
	movq	%rax, 88(%rbx)
	movl	$0, 16(%rbp)
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
	movq	%r12, 48(%rbp)
	call	expect
	jmp	.L315
	.p2align 4,,10
	.p2align 3
.L339:
	movq	%r13, %rdi
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
	movl	$1, 32(%rbp)
	jmp	.L322
	.cfi_endproc
.LFE28:
	.size	parse_extern_var_def, .-parse_extern_var_def
	.section	.rodata.str1.8
	.align 8
.LC26:
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
	movl	40(%rbp), %edx
	pxor	%xmm0, %xmm0
	movq	$0, (%rax)
	movq	%rax, %r12
	movups	%xmm0, 8(%rax)
	testl	%edx, %edx
	je	.L340
	leaq	.LC26(%rip), %r13
	jmp	.L347
	.p2align 4,,10
	.p2align 3
.L345:
	call	tk_name@PLT
	movq	%r13, %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
.L343:
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	vec_push@PLT
	movl	40(%rbp), %eax
	testl	%eax, %eax
	je	.L340
.L347:
	movl	$16, %edi
	call	xmalloc@PLT
	movl	40(%rbp), %edi
	movq	%rax, %rbx
	cmpl	$12, %edi
	je	.L350
	cmpl	$5, %edi
	je	.L351
	cmpl	$1, %edi
	jne	.L345
	movq	%rbp, %rdi
	call	peek_next_kind
	cmpl	$13, %eax
	je	.L352
	movl	$2, (%rbx)
	movq	%rbp, %rdi
	call	parse_extern_var_def
	movq	%rax, 8(%rbx)
	jmp	.L343
	.p2align 4,,10
	.p2align 3
.L350:
	movl	$3, (%rax)
	movq	%rbp, %rdi
	call	parse_extern_decl
	movq	%rax, 8(%rbx)
	jmp	.L343
	.p2align 4,,10
	.p2align 3
.L351:
	movl	$0, (%rax)
	movq	%rbp, %rdi
	call	parse_auto_decl
	movq	%rax, 8(%rbx)
	jmp	.L343
	.p2align 4,,10
	.p2align 3
.L340:
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
.L352:
	.cfi_restore_state
	movl	$1, (%rbx)
	movq	%rbp, %rdi
	call	parse_function
	movq	%rax, 8(%rbx)
	jmp	.L343
	.cfi_endproc
.LFE25:
	.size	parse_program_ast, .-parse_program_ast
	.section	.rodata
	.align 32
	.type	CSWTCH.6, @object
	.size	CSWTCH.6, 34
CSWTCH.6:
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
