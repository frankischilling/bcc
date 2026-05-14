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
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbx, 24(%rsp)
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	testq	%rdi, %rdi
	je	.L36
.L2:
	movl	(%rbx), %eax
	cmpl	$5, %eax
	je	.L3
	cmpl	$7, %eax
	je	.L34
	testl	%eax, %eax
	jne	.L5
	movq	16(%rbx), %rcx
.L1:
	movq	24(%rsp), %rbx
	movq	%rcx, %rax
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L34:
	.cfi_restore_state
	movq	%r14, 32(%rsp)
	.cfi_offset 14, -16
.L4:
	movq	24(%rbx), %rdi
	call	eval_const_expr
	movq	32(%rbx), %rdi
	movq	%rax, %r14
	call	eval_const_expr
	movq	%rax, %r8
	movl	16(%rbx), %eax
	subl	$22, %eax
	cmpl	$33, %eax
	ja	.L10
	leaq	.L12(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
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
	movq	32(%rsp), %r14
	.cfi_restore 14
.L5:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	xorl	%eax, %eax
	leaq	.LC5(%rip), %rdi
	call	dief@PLT
	xorl	%ecx, %ecx
	movq	24(%rsp), %rbx
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L3:
	.cfi_restore_state
	movq	24(%rbx), %rdi
	call	eval_const_expr
	movq	%rax, %rdx
	movl	16(%rbx), %eax
	movq	%rdx, %rcx
	negq	%rcx
	cmpl	$31, %eax
	je	.L1
	cmpl	$35, %eax
	jne	.L32
	xorl	%ecx, %ecx
	testq	%rdx, %rdx
	sete	%cl
	jmp	.L1
	.p2align 4,,10
	.p2align 3
.L36:
	leaq	.LC0(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L2
	.p2align 4,,10
	.p2align 3
.L32:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	leaq	.LC1(%rip), %rdi
	xorl	%eax, %eax
	movq	%r14, 32(%rsp)
	.cfi_offset 14, -16
	call	dief@PLT
	jmp	.L4
.L25:
	xorl	%ecx, %ecx
	cmpq	%r8, %r14
	movq	32(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	sete	%cl
	jmp	.L1
.L24:
	.cfi_restore_state
	xorl	%ecx, %ecx
	cmpq	%r8, %r14
	movq	32(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	setne	%cl
	jmp	.L1
.L23:
	.cfi_restore_state
	xorl	%ecx, %ecx
	cmpq	%r8, %r14
	movq	32(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	setl	%cl
	jmp	.L1
.L22:
	.cfi_restore_state
	xorl	%ecx, %ecx
	cmpq	%r8, %r14
	movq	32(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	setle	%cl
	jmp	.L1
.L21:
	.cfi_restore_state
	xorl	%ecx, %ecx
	cmpq	%r8, %r14
	movq	32(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	setg	%cl
	jmp	.L1
.L20:
	.cfi_restore_state
	xorl	%ecx, %ecx
	cmpq	%r8, %r14
	movq	32(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	setge	%cl
	jmp	.L1
.L19:
	.cfi_restore_state
	leaq	(%r14,%r8), %rcx
	movq	32(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	jmp	.L1
.L18:
	.cfi_restore_state
	movq	%r14, %rcx
	movq	32(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	subq	%r8, %rcx
	jmp	.L1
.L17:
	.cfi_restore_state
	movq	%r14, %rcx
	movq	32(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	imulq	%r8, %rcx
	jmp	.L1
.L16:
	.cfi_restore_state
	testq	%r8, %r8
	je	.L37
.L26:
	movq	%r14, %rax
	movq	32(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	cqto
	idivq	%r8
	movq	%rax, %rcx
	jmp	.L1
.L15:
	.cfi_restore_state
	testq	%r8, %r8
	je	.L38
.L27:
	movq	%r14, %rax
	movq	32(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	cqto
	idivq	%r8
	movq	%rdx, %rcx
	jmp	.L1
.L13:
	.cfi_restore_state
	movq	%r14, %rcx
	movq	32(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	orq	%r8, %rcx
	jmp	.L1
.L14:
	.cfi_restore_state
	movq	%r14, %rcx
	movq	32(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	andq	%r8, %rcx
	jmp	.L1
.L11:
	.cfi_restore_state
	xorl	%ecx, %ecx
	orq	%r14, %r8
	movq	32(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	setne	%cl
	jmp	.L1
.L37:
	.cfi_restore_state
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	leaq	.LC2(%rip), %rdi
	xorl	%eax, %eax
	movq	%r8, 8(%rsp)
	call	dief@PLT
	movq	8(%rsp), %r8
	jmp	.L26
.L38:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	leaq	.LC3(%rip), %rdi
	xorl	%eax, %eax
	movq	%r8, 8(%rsp)
	call	dief@PLT
	movq	8(%rsp), %r8
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
	subq	$64, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rbx
	movq	%rbx, 56(%rsp)
	movq	%rdi, %rbx
	addq	$40, %rdi
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
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L42
	addq	$64, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L42:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$88, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rbx
	movq	%rbx, 72(%rsp)
	movq	%rdi, %rbx
	movl	40(%rdi), %edi
	leaq	40(%rbx), %rbp
	cmpl	%esi, %edi
	je	.L44
	movl	%esi, 12(%rsp)
	call	tk_name@PLT
	movl	12(%rsp), %edi
	movq	%rax, (%rsp)
	call	tk_name@PLT
	movq	88(%rbx), %rsi
	movq	(%rsp), %r8
	movq	%rbp, %rdi
	movq	%rax, %rcx
	leaq	.LC6(%rip), %rdx
	xorl	%eax, %eax
	call	error_at@PLT
.L44:
	movq	%rbp, %rdi
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L47
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L47:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE15:
	.size	expect, .-expect
	.p2align 4
	.globl	accept
	.type	accept, @function
accept:
.LFB16:
	.cfi_startproc
	subq	$88, %rsp
	.cfi_def_cfa_offset 96
	movq	%fs:40, %rdx
	movq	%rdx, 72(%rsp)
	xorl	%edx, %edx
	cmpl	%esi, 40(%rdi)
	je	.L53
.L48:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L54
	movl	%edx, %eax
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L53:
	.cfi_restore_state
	movq	%rdi, %rax
	leaq	40(%rdi), %rdi
	movq	%rax, 8(%rsp)
	call	tok_free@PLT
	movq	8(%rsp), %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movq	8(%rsp), %rax
	movl	$1, %edx
	movups	%xmm0, 40(%rax)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rax)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rax)
	jmp	.L48
.L54:
	call	__stack_chk_fail@PLT
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$120, %rsp
	.cfi_def_cfa_offset 144
	movdqu	(%rdi), %xmm0
	movq	g_compilation_arena(%rip), %rbx
	movq	%fs:40, %rax
	movq	%rax, 104(%rsp)
	xorl	%eax, %eax
	movq	32(%rdi), %rax
	movq	%rsp, %rsi
	movq	$0, g_compilation_arena(%rip)
	movaps	%xmm0, (%rsp)
	movdqu	16(%rdi), %xmm0
	leaq	48(%rsp), %rdi
	movq	%rax, 32(%rsp)
	movaps	%xmm0, 16(%rsp)
	call	lx_next@PLT
	leaq	48(%rsp), %rdi
	movl	48(%rsp), %ebp
	call	tok_free@PLT
	movq	%rbx, g_compilation_arena(%rip)
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L64
	addq	$120, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movl	%ebp, %eax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L64:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
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
	subq	$104, %rsp
	.cfi_def_cfa_offset 112
	movl	$12, %esi
	movq	%rbp, 80(%rsp)
	movq	%r13, 96(%rsp)
	movq	%rbx, 72(%rsp)
	.cfi_offset 6, -32
	.cfi_offset 13, -16
	.cfi_offset 3, -40
	movq	%fs:40, %rbx
	movq	%rbx, 56(%rsp)
	movq	%rdi, %rbx
	movq	%rbx, %rdi
	movq	72(%rbx), %rbp
	call	expect
	movl	$40, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movl	$7, (%rax)
	movq	%rax, %r13
	movq	$0, 16(%rax)
	movq	%rbp, 4(%rax)
	leaq	40(%rbx), %rbp
	movups	%xmm0, 24(%rax)
.L68:
	cmpl	$1, 40(%rbx)
	je	.L66
	movl	76(%rbx), %edx
	movl	72(%rbx), %esi
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L66:
	movq	48(%rbx), %rdi
	call	sdup@PLT
	leaq	16(%r13), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movq	%rbp, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm1
	movups	%xmm1, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	cmpl	$17, (%rsp)
	je	.L71
	movl	$18, %esi
	movq	%rbx, %rdi
	call	expect
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L72
	movq	%r13, %rax
	movq	72(%rsp), %rbx
	movq	80(%rsp), %rbp
	movq	96(%rsp), %r13
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L71:
	.cfi_restore_state
	movq	%rbp, %rdi
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
	jmp	.L68
.L72:
	movq	%r12, 88(%rsp)
	.cfi_offset 12, -24
	call	__stack_chk_fail@PLT
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
	movq	72(%rdi), %rax
	movq	%rax, 8(%rsp)
	call	expect
	movl	100(%rbx), %eax
	testl	%eax, %eax
	je	.L76
.L74:
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
.L76:
	.cfi_restore_state
	movl	8(%rsp), %esi
	movl	12(%rsp), %edx
	leaq	.LC8(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L74
	.cfi_endproc
.LFE40:
	.size	parse_default, .-parse_default
	.p2align 4
	.globl	parse_expr
	.type	parse_expr, @function
parse_expr:
.LFB52:
	.cfi_startproc
	subq	$104, %rsp
	.cfi_def_cfa_offset 112
	movq	%rbx, 80(%rsp)
	.cfi_offset 3, -32
	movq	%fs:40, %rbx
	movq	%rbx, 72(%rsp)
	movq	%rdi, %rbx
	call	parse_assignment
	movq	%rax, %rdx
	cmpl	$17, 40(%rbx)
	je	.L84
.L77:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L85
	movq	80(%rsp), %rbx
	movq	%rdx, %rax
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L84:
	.cfi_restore_state
	movq	%r14, 88(%rsp)
	movq	%rax, %rcx
	.cfi_offset 14, -24
.L79:
	leaq	40(%rbx), %rdi
	movq	%rcx, 8(%rsp)
	movq	%rdx, (%rsp)
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
	call	parse_assignment
	movq	(%rsp), %rdx
	movl	$48, %edi
	movq	%rax, %r14
	movq	4(%rdx), %rsi
	movq	%rsi, (%rsp)
	call	xmalloc@PLT
	movq	(%rsp), %rsi
	movq	8(%rsp), %rcx
	movl	$10, (%rax)
	movq	%rax, %rdx
	movq	%rsi, 4(%rax)
	movq	%rcx, 16(%rax)
	movq	%r14, 24(%rax)
	cmpl	$17, 40(%rbx)
	je	.L82
	movq	88(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	jmp	.L77
	.p2align 4,,10
	.p2align 3
.L82:
	.cfi_restore_state
	movq	%rdx, %rcx
	jmp	.L79
.L85:
	.cfi_restore 14
	movq	%r14, 88(%rsp)
	movq	%r15, 96(%rsp)
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	call	__stack_chk_fail@PLT
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
	.text
	.p2align 4
	.globl	parse_auto_decl
	.type	parse_auto_decl, @function
parse_auto_decl:
.LFB26:
	.cfi_startproc
	subq	$120, %rsp
	.cfi_def_cfa_offset 128
	movl	$5, %esi
	movq	%rbp, 88(%rsp)
	movq	%r12, 96(%rsp)
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	movq	72(%rdi), %r12
	movq	%rbx, 80(%rsp)
	.cfi_offset 3, -48
	movq	%fs:40, %rbx
	movq	%rbx, 72(%rsp)
	movq	%rdi, %rbx
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
	je	.L94
	movl	76(%rbx), %edx
	movl	72(%rbx), %esi
	xorl	%eax, %eax
	leaq	.LC9(%rip), %rdi
	call	dief@PLT
	movl	40(%rbx), %eax
.L94:
	cmpl	$1, %eax
	je	.L88
	movl	76(%rbx), %edx
	movl	72(%rbx), %esi
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L88:
	movl	$16, %edi
	call	xmalloc@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L103
.L89:
	movq	48(%rbx), %rdi
	call	sdup@PLT
	leaq	40(%rbx), %rdi
	movq	$0, 8(%r12)
	movq	%rax, (%r12)
	call	tok_free@PLT
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movd	%xmm0, %eax
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	cmpl	$19, %eax
	je	.L90
	cmpl	$2, %eax
	je	.L104
.L92:
	movq	%r12, %rsi
	leaq	16(%rbp), %rdi
	call	vec_push@PLT
	cmpl	$17, 40(%rbx)
	je	.L105
	movl	$18, %esi
	movq	%rbx, %rdi
	call	expect
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L106
	movq	%rbp, %rax
	movq	80(%rsp), %rbx
	movq	88(%rsp), %rbp
	movq	96(%rsp), %r12
	addq	$120, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L104:
	.cfi_restore_state
	movq	72(%rbx), %rdx
	movl	$48, %edi
	movq	%rdx, 8(%rsp)
	call	xmalloc@PLT
	movq	8(%rsp), %rdx
	leaq	40(%rbx), %rdi
	movl	$0, (%rax)
	movq	%rdx, 4(%rax)
	movq	64(%rbx), %rdx
	movq	%rax, 8(%r12)
	movq	%rdx, 16(%rax)
	call	tok_free@PLT
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	jmp	.L92
	.p2align 4,,10
	.p2align 3
.L103:
	leaq	.LC11(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L89
	.p2align 4,,10
	.p2align 3
.L105:
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm1
	movd	%xmm0, %eax
	movups	%xmm1, 56(%rbx)
	movdqu	48(%rsp), %xmm1
	movups	%xmm1, 72(%rbx)
	jmp	.L94
	.p2align 4,,10
	.p2align 3
.L90:
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
	call	parse_expr
	movl	$20, %esi
	movq	%rbx, %rdi
	movq	%rax, 8(%r12)
	call	expect
	jmp	.L92
.L106:
	movq	%r13, 104(%rsp)
	movq	%r14, 112(%rsp)
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	call	__stack_chk_fail@PLT
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
	subq	$88, %rsp
	.cfi_def_cfa_offset 96
	movl	$12, %esi
	movq	%rbx, 64(%rsp)
	movq	%rbp, 72(%rsp)
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	movq	%fs:40, %rbp
	movq	%rbp, 56(%rsp)
	movq	%rdi, %rbp
	call	expect
	cmpl	$1, 40(%rbp)
	je	.L108
	movl	76(%rbp), %edx
	movl	72(%rbp), %esi
	leaq	.LC12(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L108:
	movl	$56, %edi
	call	xmalloc@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L115
.L109:
	pxor	%xmm0, %xmm0
	movq	$0, 48(%rbx)
	movups	%xmm0, (%rbx)
	movups	%xmm0, 16(%rbx)
	movups	%xmm0, 32(%rbx)
	movq	48(%rbp), %rdi
	call	sdup@PLT
	leaq	40(%rbp), %rdi
	movq	%rax, 8(%rbx)
	call	tok_free@PLT
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbp)
	movdqu	16(%rsp), %xmm1
	movd	%xmm0, %eax
	movups	%xmm1, 56(%rbp)
	movdqu	32(%rsp), %xmm1
	movups	%xmm1, 72(%rbp)
	cmpl	$13, %eax
	je	.L116
.L110:
	movl	$0, (%rbx)
	movl	$0, 16(%rbx)
	movq	$0, 24(%rbx)
	movl	$0, 32(%rbx)
	movq	$0, 40(%rbx)
	movq	$0, 48(%rbx)
	cmpl	$19, %eax
	je	.L117
.L111:
	movl	$18, %esi
	movq	%rbp, %rdi
	call	expect
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L118
	movq	%rbx, %rax
	movq	72(%rsp), %rbp
	movq	64(%rsp), %rbx
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L115:
	.cfi_restore_state
	leaq	.LC11(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L109
	.p2align 4,,10
	.p2align 3
.L116:
	leaq	40(%rbp), %rdi
	call	tok_free@PLT
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	xorl	%eax, %eax
	leaq	.LC13(%rip), %rdi
	movups	%xmm0, 40(%rbp)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbp)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbp)
	movl	76(%rbp), %edx
	movl	72(%rbp), %esi
	call	dief@PLT
	movl	40(%rbp), %eax
	jmp	.L110
	.p2align 4,,10
	.p2align 3
.L117:
	leaq	40(%rbp), %rdi
	call	tok_free@PLT
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbp)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbp)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbp)
	movl	$2, 16(%rbx)
	cmpl	$20, 40(%rbp)
	je	.L119
	movq	%rbp, %rdi
	call	parse_expr
	movl	$20, %esi
	movq	%rbp, %rdi
	movq	%rax, 24(%rbx)
	call	expect
	jmp	.L111
	.p2align 4,,10
	.p2align 3
.L119:
	leaq	40(%rbp), %rdi
	call	tok_free@PLT
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbp)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbp)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbp)
	movl	$1, 32(%rbx)
	jmp	.L111
.L118:
	movq	%r12, 80(%rsp)
	.cfi_offset 12, -16
	call	__stack_chk_fail@PLT
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
	movq	72(%rdi), %r12
	call	expect
	cmpl	$18, 40(%rbx)
	je	.L121
	movq	%rbx, %rdi
	call	parse_expr
	movq	%rax, %rbp
.L121:
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
.LC14:
	.string	"case outside switch at %d:%d"
	.text
	.p2align 4
	.globl	parse_case
	.type	parse_case, @function
parse_case:
.LFB39:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	$60, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	movq	72(%rdi), %rax
	movq	%rax, 8(%rsp)
	call	expect
	movl	100(%rbx), %eax
	testl	%eax, %eax
	je	.L128
.L126:
	movq	%rbx, %rdi
	call	parse_expr
	movq	%rax, %rdi
	call	eval_const_expr
	movq	%rbx, %rdi
	movl	$57, %esi
	movq	%rax, %rbp
	call	expect
	movl	$40, %edi
	call	xmalloc@PLT
	movq	8(%rsp), %rcx
	movl	$13, (%rax)
	movq	%rcx, 4(%rax)
	movq	$0, 16(%rax)
	movq	%rbp, 24(%rax)
	movq	%rbp, 32(%rax)
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L128:
	.cfi_restore_state
	movl	8(%rsp), %esi
	movl	12(%rsp), %edx
	leaq	.LC14(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L126
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
	movq	72(%rdi), %r13
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
	addl	$1, 96(%rbx)
	movq	%rbx, %rdi
	call	parse_stmt
	subl	$1, 96(%rbx)
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
.LC15:
	.string	"label expression must be an identifier at %d:%d"
	.align 8
.LC16:
	.string	"expected label after goto at %d:%d"
	.text
	.p2align 4
	.globl	parse_stmt
	.type	parse_stmt, @function
parse_stmt:
.LFB42:
	.cfi_startproc
	subq	$216, %rsp
	.cfi_def_cfa_offset 224
	movl	40(%rdi), %eax
	movq	%rbx, 184(%rsp)
	.cfi_offset 3, -40
	movq	%fs:40, %rbx
	movq	%rbx, 168(%rsp)
	movq	%rdi, %rbx
	cmpl	$1, %eax
	je	.L174
	cmpl	$18, %eax
	je	.L141
.L175:
	subl	$5, %eax
	cmpl	$56, %eax
	ja	.L142
	leaq	.L144(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L144:
	.long	.L155-.L144
	.long	.L154-.L144
	.long	.L142-.L144
	.long	.L153-.L144
	.long	.L152-.L144
	.long	.L151-.L144
	.long	.L150-.L144
	.long	.L149-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L148-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L142-.L144
	.long	.L147-.L144
	.long	.L146-.L144
	.long	.L145-.L144
	.long	.L143-.L144
	.text
	.p2align 4,,10
	.p2align 3
.L174:
	movdqu	(%rbx), %xmm0
	movq	32(%rbx), %rax
	leaq	64(%rsp), %rsi
	leaq	112(%rsp), %rdi
	movq	%r14, 200(%rsp)
	movq	%rax, 96(%rsp)
	movq	g_compilation_arena(%rip), %rax
	movaps	%xmm0, 64(%rsp)
	movdqu	16(%rbx), %xmm0
	movq	%rax, (%rsp)
	movaps	%xmm0, 80(%rsp)
	movq	$0, g_compilation_arena(%rip)
	.cfi_offset 14, -24
	call	lx_next@PLT
	leaq	112(%rsp), %rdi
	movl	112(%rsp), %r14d
	call	tok_free@PLT
	movq	(%rsp), %rax
	movq	%rax, g_compilation_arena(%rip)
	cmpl	$57, %r14d
	je	.L133
	movl	40(%rbx), %eax
	movq	200(%rsp), %r14
	.cfi_restore 14
	cmpl	$18, %eax
	jne	.L175
	.p2align 4
	.p2align 3
.L141:
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movl	$40, %edi
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	%xmm0, (%rsp)
	call	xmalloc@PLT
	movq	(%rsp), %rdx
	movl	$0, (%rax)
	movq	%rax, %rbx
	movq	%rdx, 4(%rax)
	jmp	.L131
	.p2align 4,,10
	.p2align 3
.L142:
	movq	72(%rbx), %rdx
	movq	%rbx, %rdi
	movq	%r14, 200(%rsp)
	movq	%rdx, (%rsp)
	.cfi_offset 14, -24
	call	parse_expr
	movq	%rbx, %rdi
	movl	$18, %esi
	movq	%rax, %r14
	call	expect
	movl	$40, %edi
	call	xmalloc@PLT
	movq	(%rsp), %rdx
	movl	$6, (%rax)
	movq	%rax, %rbx
	movq	%rdx, 4(%rax)
	movq	%r14, 16(%rax)
	movq	200(%rsp), %r14
	.cfi_restore 14
	.p2align 4
	.p2align 3
.L131:
	movq	168(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L173
	movq	%rbx, %rax
	movq	184(%rsp), %rbx
	addq	$216, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L155:
	.cfi_restore_state
	movq	168(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L173
	movq	%rbx, %rdi
	movq	184(%rsp), %rbx
	addq	$216, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	parse_auto_decl
	.p2align 4,,10
	.p2align 3
.L154:
	.cfi_restore_state
	movq	168(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L173
	movq	%rbx, %rdi
	movq	184(%rsp), %rbx
	addq	$216, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	parse_if
	.p2align 4,,10
	.p2align 3
.L153:
	.cfi_restore_state
	movq	168(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L173
	movq	%rbx, %rdi
	movq	184(%rsp), %rbx
	addq	$216, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	parse_while
	.p2align 4,,10
	.p2align 3
.L152:
	.cfi_restore_state
	movq	168(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L173
	movq	%rbx, %rdi
	movq	184(%rsp), %rbx
	addq	$216, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	parse_return
	.p2align 4,,10
	.p2align 3
.L151:
	.cfi_restore_state
	movq	72(%rbx), %rdx
	leaq	40(%rbx), %rdi
	movq	%rdx, (%rsp)
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
	call	expect
	movl	$40, %edi
	call	xmalloc@PLT
	movq	(%rsp), %rdx
	movl	$8, (%rax)
	movq	%rax, %rbx
	movq	%rdx, 4(%rax)
	jmp	.L131
	.p2align 4,,10
	.p2align 3
.L150:
	movq	72(%rbx), %rdx
	leaq	40(%rbx), %rdi
	movq	%rdx, (%rsp)
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
	call	expect
	movl	$40, %edi
	call	xmalloc@PLT
	movq	(%rsp), %rdx
	movl	$9, (%rax)
	movq	%rax, %rbx
	movq	%rdx, 4(%rax)
	jmp	.L131
	.p2align 4,,10
	.p2align 3
.L149:
	movq	168(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L173
	movq	%rbx, %rdi
	movq	184(%rsp), %rbx
	addq	$216, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	parse_extrn_stmt
	.p2align 4,,10
	.p2align 3
.L148:
	.cfi_restore_state
	movq	168(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L173
	movq	%rbx, %rdi
	movq	184(%rsp), %rbx
	addq	$216, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	parse_block
	.p2align 4,,10
	.p2align 3
.L147:
	.cfi_restore_state
	movq	72(%rbx), %rax
	movl	$58, %esi
	movq	%rbx, %rdi
	movq	%r15, 208(%rsp)
	movq	%r14, 200(%rsp)
	.cfi_offset 15, -16
	.cfi_offset 14, -24
	movq	%rax, %r15
	call	expect
	cmpl	$1, 40(%rbx)
	jne	.L176
.L162:
	movq	48(%rbx), %rdi
	call	sdup@PLT
	leaq	40(%rbx), %rdi
	movq	%rax, %r14
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
	call	expect
	movl	$40, %edi
	call	xmalloc@PLT
	movq	%r15, 4(%rax)
	movq	%rax, %rbx
	movq	208(%rsp), %r15
	.cfi_restore 15
	movq	%r14, 16(%rax)
	movq	200(%rsp), %r14
	.cfi_restore 14
	movl	$10, (%rax)
	jmp	.L131
	.p2align 4,,10
	.p2align 3
.L146:
	movq	72(%rbx), %rax
	movl	$59, %esi
	movq	%rbx, %rdi
	movq	%r15, 208(%rsp)
	movq	%rbp, 192(%rsp)
	movq	%r14, 200(%rsp)
	.cfi_offset 15, -16
	.cfi_offset 6, -32
	.cfi_offset 14, -24
	movq	%rax, %r15
	call	expect
	cmpl	$13, 40(%rbx)
	je	.L163
	movq	%rbx, %rdi
	call	parse_expr
	movq	%rax, %rbp
.L164:
	addl	$1, 100(%rbx)
	movq	%rbx, %rdi
	call	parse_stmt
	subl	$1, 100(%rbx)
	movl	$40, %edi
	movq	%rax, %r14
	call	xmalloc@PLT
	movq	%r15, 4(%rax)
	movq	%rax, %rbx
	movq	208(%rsp), %r15
	.cfi_restore 15
	movq	%rbp, 16(%rax)
	movq	192(%rsp), %rbp
	.cfi_restore 6
	movq	%r14, 24(%rax)
	movq	200(%rsp), %r14
	.cfi_restore 14
	movl	$12, (%rax)
	jmp	.L131
	.p2align 4,,10
	.p2align 3
.L145:
	movq	168(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L173
	movq	%rbx, %rdi
	movq	184(%rsp), %rbx
	addq	$216, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	parse_case
	.p2align 4,,10
	.p2align 3
.L143:
	.cfi_restore_state
	movq	168(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L173
	movq	%rbx, %rdi
	movq	184(%rsp), %rbx
	addq	$216, %rsp
	.cfi_def_cfa_offset 8
	jmp	parse_default
	.p2align 4,,10
	.p2align 3
.L176:
	.cfi_def_cfa_offset 224
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movl	76(%rbx), %edx
	movl	72(%rbx), %esi
	leaq	.LC16(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L162
	.p2align 4,,10
	.p2align 3
.L133:
	.cfi_restore 15
	movq	72(%rbx), %rax
	movq	%rbx, %rdi
	movq	%r15, 208(%rsp)
	movq	%rax, (%rsp)
	.cfi_offset 15, -16
	call	parse_expr
	movl	$57, %esi
	movq	%rbx, %rdi
	movq	%rax, %r14
	movq	%rax, %r15
	call	expect
	cmpl	$2, (%r14)
	je	.L134
	movl	(%rsp), %esi
	movl	4(%rsp), %edx
	leaq	.LC15(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L134:
	movl	40(%rbx), %eax
	cmpl	$16, %eax
	je	.L135
	ja	.L136
	cmpl	$1, %eax
	jne	.L138
	movdqu	(%rbx), %xmm0
	movq	32(%rbx), %rax
	leaq	64(%rsp), %rsi
	leaq	112(%rsp), %rdi
	movq	%rax, 96(%rsp)
	movq	g_compilation_arena(%rip), %rax
	movaps	%xmm0, 64(%rsp)
	movdqu	16(%rbx), %xmm0
	movq	%rax, 8(%rsp)
	movaps	%xmm0, 80(%rsp)
	movq	$0, g_compilation_arena(%rip)
	call	lx_next@PLT
	leaq	112(%rsp), %rdi
	movl	112(%rsp), %r14d
	call	tok_free@PLT
	movq	8(%rsp), %rax
	movq	%rax, g_compilation_arena(%rip)
	cmpl	$57, %r14d
	je	.L135
.L138:
	movq	%rbx, %rdi
	call	parse_stmt
	movq	%rax, %rdx
.L139:
	movl	$40, %edi
	movq	%rdx, 8(%rsp)
	call	xmalloc@PLT
	movq	%rax, %rbx
	movl	$11, (%rax)
	movq	(%rsp), %rax
	movq	%rax, 4(%rbx)
	movq	16(%r15), %rdi
	call	sdup@PLT
	movq	8(%rsp), %rdx
	movq	200(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	movq	%rax, 16(%rbx)
	movq	208(%rsp), %r15
	.cfi_restore 15
	movq	%rdx, 24(%rbx)
	jmp	.L131
.L136:
	.cfi_restore_state
	subl	$60, %eax
	cmpl	$1, %eax
	ja	.L138
.L135:
	movq	72(%rbx), %rbx
	movl	$40, %edi
	call	xmalloc@PLT
	movl	$0, (%rax)
	movq	%rax, %rdx
	movq	%rbx, 4(%rax)
	jmp	.L139
.L163:
	.cfi_offset 6, -32
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
	call	parse_expr
	movl	$14, %esi
	movq	%rbx, %rdi
	movq	%rax, %rbp
	call	expect
	jmp	.L164
.L173:
	.cfi_restore 6
	.cfi_restore 14
	.cfi_restore 15
	movq	%rbp, 192(%rsp)
	movq	%r14, 200(%rsp)
	movq	%r15, 208(%rsp)
	.cfi_offset 6, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	call	__stack_chk_fail@PLT
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
	movq	72(%rdi), %r12
	call	expect
	xorl	%eax, %eax
	call	vec_new@PLT
	movq	%rax, %rbp
	movl	40(%rbx), %eax
	cmpl	$16, %eax
	jne	.L180
	jmp	.L178
	.p2align 4,,10
	.p2align 3
.L179:
	movq	%rbx, %rdi
	call	parse_stmt
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movl	40(%rbx), %eax
	cmpl	$16, %eax
	je	.L178
.L180:
	testl	%eax, %eax
	jne	.L179
	leaq	.LC17(%rip), %rdi
	call	dief@PLT
	jmp	.L179
	.p2align 4,,10
	.p2align 3
.L178:
	movq	%rbx, %rdi
	movl	$16, %esi
	call	expect
	movl	$40, %edi
	call	xmalloc@PLT
	movdqu	0(%rbp), %xmm0
	movl	$1, (%rax)
	movups	%xmm0, 16(%rax)
	movq	16(%rbp), %rdx
	movq	%r12, 4(%rax)
	movq	%rdx, 32(%rax)
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
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
	subq	$104, %rsp
	.cfi_def_cfa_offset 112
	movq	%rbx, 72(%rsp)
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	movq	%rbp, 80(%rsp)
	movq	%r12, 88(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	cmpl	$1, 40(%rdi)
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	je	.L187
	movl	76(%rdi), %edx
	movl	72(%rdi), %esi
	leaq	.LC18(%rip), %rdi
	call	dief@PLT
.L187:
	movl	$40, %edi
	leaq	40(%rbx), %r12
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
	call	expect
	movl	40(%rbx), %eax
	cmpl	$14, %eax
	je	.L188
.L190:
	cmpl	$1, %eax
	jne	.L201
.L189:
	movq	48(%rbx), %rdi
	call	sdup@PLT
	leaq	8(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm2
	movups	%xmm2, 40(%rbx)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	cmpl	$17, (%rsp)
	je	.L202
.L188:
	movl	$14, %esi
	movq	%rbx, %rdi
	call	expect
	cmpl	$15, 40(%rbx)
	je	.L203
	movq	%rbx, %rdi
	movq	%r13, 96(%rsp)
	.cfi_offset 13, -16
	movq	72(%rbx), %r13
	call	parse_stmt
	movl	$40, %edi
	movq	%rax, %r12
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%r12, %rsi
	movq	%r13, 4(%rax)
	leaq	16(%rax), %rdi
	movq	%rax, %rbx
	movl	$1, (%rax)
	movq	$0, 16(%rax)
	movups	%xmm0, 24(%rax)
	call	vec_push@PLT
	movq	96(%rsp), %r13
	.cfi_restore 13
.L192:
	movq	%rbx, 32(%rbp)
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L204
	movq	%rbp, %rax
	movq	72(%rsp), %rbx
	movq	80(%rsp), %rbp
	movq	88(%rsp), %r12
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L201:
	.cfi_restore_state
	movl	76(%rbx), %edx
	movl	72(%rbx), %esi
	leaq	.LC19(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L189
	.p2align 4,,10
	.p2align 3
.L203:
	movq	%rbx, %rdi
	call	parse_block
	movq	%rax, %rbx
	jmp	.L192
	.p2align 4,,10
	.p2align 3
.L202:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%rsp, %rdi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	16(%rsp), %xmm1
	movd	%xmm0, %eax
	movups	%xmm1, 56(%rbx)
	movdqu	32(%rsp), %xmm1
	movups	%xmm1, 72(%rbx)
	jmp	.L190
.L204:
	movq	%r13, 96(%rsp)
	.cfi_offset 13, -16
	call	__stack_chk_fail@PLT
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
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	xorl	%ebp, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$64, %rsp
	.cfi_def_cfa_offset 112
	movq	72(%rdi), %r14
	movq	%fs:40, %rbx
	movq	%rbx, 56(%rsp)
	movq	%rdi, %rbx
	call	expect
	movl	$13, %esi
	movq	%rbx, %rdi
	call	expect
	movq	%rbx, %rdi
	call	parse_expr
	movl	$14, %esi
	movq	%rbx, %rdi
	movq	%rax, %r13
	call	expect
	movq	%rbx, %rdi
	call	parse_stmt
	movq	%rax, %r12
	cmpl	$7, 40(%rbx)
	je	.L211
.L206:
	movl	$40, %edi
	call	xmalloc@PLT
	movl	$3, (%rax)
	movq	%r14, 4(%rax)
	movq	%r13, 16(%rax)
	movq	%r12, 24(%rax)
	movq	%rbp, 32(%rax)
	movq	56(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L212
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
.L211:
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
	call	parse_stmt
	movq	%rax, %rbp
	jmp	.L206
.L212:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE31:
	.size	parse_if, .-parse_if
	.p2align 4
	.globl	parse_primary
	.type	parse_primary, @function
parse_primary:
.LFB46:
	.cfi_startproc
	subq	$104, %rsp
	.cfi_def_cfa_offset 112
	movq	%r13, 96(%rsp)
	.cfi_offset 13, -16
	movq	72(%rdi), %r13
	movq	%rbx, 72(%rsp)
	movq	%rbp, 80(%rsp)
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	movq	%fs:40, %rbx
	movq	%rbx, 56(%rsp)
	movq	%rdi, %rbx
	cmpl	$13, 40(%rdi)
	ja	.L214
	movl	40(%rbx), %eax
	leaq	.L216(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L216:
	.long	.L214-.L216
	.long	.L219-.L216
	.long	.L217-.L216
	.long	.L218-.L216
	.long	.L217-.L216
	.long	.L214-.L216
	.long	.L214-.L216
	.long	.L214-.L216
	.long	.L214-.L216
	.long	.L214-.L216
	.long	.L214-.L216
	.long	.L214-.L216
	.long	.L214-.L216
	.long	.L215-.L216
	.text
	.p2align 4,,10
	.p2align 3
.L214:
	movq	88(%rbx), %rsi
	xorl	%ecx, %ecx
	movl	$8, %edx
	leaq	40(%rbx), %rdi
	xorl	%ebp, %ebp
	call	error_at_code@PLT
.L213:
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L225
	movq	%rbp, %rax
	movq	72(%rsp), %rbx
	movq	80(%rsp), %rbp
	movq	96(%rsp), %r13
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L217:
	.cfi_restore_state
	movl	$48, %edi
	call	xmalloc@PLT
	movl	$0, (%rax)
	movq	%rax, %rbp
	movq	%r13, 4(%rax)
	movq	64(%rbx), %rax
.L223:
	movq	%rax, 16(%rbp)
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
	jmp	.L213
	.p2align 4,,10
	.p2align 3
.L219:
	movl	$48, %edi
	call	xmalloc@PLT
	movl	$2, (%rax)
	movq	%rax, %rbp
.L224:
	movq	%r13, 4(%rbp)
	movq	48(%rbx), %rdi
	call	sdup@PLT
	jmp	.L223
	.p2align 4,,10
	.p2align 3
.L215:
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
	call	parse_expr
	movl	$14, %esi
	movq	%rbx, %rdi
	movq	%rax, %rbp
	call	expect
	jmp	.L213
	.p2align 4,,10
	.p2align 3
.L218:
	movl	$48, %edi
	call	xmalloc@PLT
	movl	$1, (%rax)
	movq	%rax, %rbp
	jmp	.L224
.L225:
	movq	%r12, 88(%rsp)
	.cfi_offset 12, -24
	call	__stack_chk_fail@PLT
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
	subq	$104, %rsp
	.cfi_def_cfa_offset 112
	movq	%rbp, 88(%rsp)
	movq	%rbx, 80(%rsp)
	.cfi_offset 6, -24
	.cfi_offset 3, -32
	movq	%fs:40, %rbx
	movq	%rbx, 72(%rsp)
	movq	%rdi, %rbx
	call	parse_primary
	movq	%rax, %rbp
.L227:
	movl	40(%rbx), %r8d
	cmpl	$13, %r8d
	je	.L228
	cmpl	$19, %r8d
	je	.L248
	leal	-36(%r8), %eax
	cmpl	$1, %eax
	jbe	.L249
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L250
	movq	%rbp, %rax
	movq	80(%rsp), %rbx
	movq	88(%rsp), %rbp
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L228:
	.cfi_restore_state
	leaq	40(%rbx), %rdi
	movq	%r14, 96(%rsp)
	.cfi_offset 14, -16
	leaq	40(%rbx), %r14
	call	tok_free@PLT
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movl	$48, %edi
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movq	4(%rbp), %rcx
	movq	%rcx, (%rsp)
	call	xmalloc@PLT
	movq	(%rsp), %rcx
	pxor	%xmm0, %xmm0
	movl	$3, (%rax)
	movq	%rax, %rdx
	movq	%rcx, 4(%rax)
	movq	%rbp, 16(%rax)
	movq	$0, 24(%rax)
	movups	%xmm0, 32(%rax)
	cmpl	$14, 40(%rbx)
	je	.L231
	leaq	24(%rax), %rbp
.L232:
	movq	%rbx, %rdi
	movq	%rdx, (%rsp)
	call	parse_assignment
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	cmpl	$17, 40(%rbx)
	je	.L251
	movl	$14, %esi
	movq	%rbx, %rdi
	call	expect
	movq	(%rsp), %rdx
.L233:
	movq	96(%rsp), %r14
	.cfi_restore 14
	movq	%rdx, %rbp
	jmp	.L227
	.p2align 4,,10
	.p2align 3
.L249:
	leaq	40(%rbx), %rdi
	movl	%r8d, (%rsp)
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	testq	%rbp, %rbp
	movl	(%rsp), %r8d
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	je	.L237
	movl	0(%rbp), %eax
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L238
	cmpl	$5, %eax
	je	.L252
.L237:
	movl	8(%rbp), %ecx
	movl	4(%rbp), %edx
	movl	%r8d, %edi
	movl	%r8d, (%rsp)
	movl	%ecx, 12(%rsp)
	movl	%edx, 8(%rsp)
	call	tk_name@PLT
	movl	12(%rsp), %ecx
	movl	8(%rsp), %edx
	leaq	.LC20(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
	movl	(%rsp), %r8d
.L238:
	movq	4(%rbp), %rdx
	movl	$48, %edi
	movl	%r8d, 8(%rsp)
	movq	%rdx, (%rsp)
	call	xmalloc@PLT
	movq	(%rsp), %rdx
	movl	8(%rsp), %r8d
	movq	%rbp, 24(%rax)
	movq	%rax, %rbp
	movl	$6, (%rax)
	movq	%rdx, 4(%rax)
	movl	%r8d, 16(%rax)
	jmp	.L227
	.p2align 4,,10
	.p2align 3
.L248:
	leaq	40(%rbx), %rdi
	movq	%r14, 96(%rsp)
	.cfi_offset 14, -16
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
	call	parse_expr
	movl	$20, %esi
	movq	%rbx, %rdi
	movq	%rax, %r14
	call	expect
	movq	4(%rbp), %rdx
	movl	$48, %edi
	movq	%rdx, (%rsp)
	call	xmalloc@PLT
	movq	(%rsp), %rdx
	movq	%rbp, 16(%rax)
	movq	%rax, %rbp
	movq	%r14, 24(%rax)
	movq	96(%rsp), %r14
	.cfi_restore 14
	movl	$4, (%rax)
	movq	%rdx, 4(%rax)
	jmp	.L227
	.p2align 4,,10
	.p2align 3
.L252:
	cmpl	$32, 16(%rbp)
	jne	.L237
	jmp	.L238
	.p2align 4,,10
	.p2align 3
.L251:
	.cfi_offset 14, -16
	movq	%r14, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movq	(%rsp), %rdx
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	jmp	.L232
	.p2align 4,,10
	.p2align 3
.L231:
	movq	%r14, %rdi
	movq	%rax, (%rsp)
	call	tok_free@PLT
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movq	(%rsp), %rdx
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	jmp	.L233
.L250:
	.cfi_restore 14
	movq	%r14, 96(%rsp)
	.cfi_offset 14, -16
	call	__stack_chk_fail@PLT
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
	subq	$120, %rsp
	.cfi_def_cfa_offset 128
	movq	%rbp, 96(%rsp)
	.cfi_offset 6, -32
	movl	40(%rdi), %ebp
	movq	%rbx, 88(%rsp)
	leal	-31(%rbp), %eax
	.cfi_offset 3, -40
	movq	%fs:40, %rbx
	movq	%rbx, 72(%rsp)
	movq	%rdi, %rbx
	cmpl	$22, %eax
	ja	.L254
	movl	$4194419, %edx
	btq	%rax, %rdx
	jnc	.L254
	movq	72(%rbx), %rax
	leaq	40(%rbx), %rdi
	movq	%r14, 104(%rsp)
	movq	%r15, 112(%rsp)
	movq	%rax, %xmm1
	movq	%rax, 8(%rsp)
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movl	%eax, %r15d
	pshufd	$0xe5, %xmm1, %xmm2
	movd	%xmm2, %r14d
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
	call	parse_unary
	movq	%rax, %rbx
	leal	-36(%rbp), %eax
	cmpl	$1, %eax
	jbe	.L275
	cmpl	$53, %ebp
	je	.L276
.L259:
	movl	$48, %edi
	call	xmalloc@PLT
	movq	8(%rsp), %rcx
	movl	$5, (%rax)
	movq	%rcx, 4(%rax)
	movl	%ebp, 16(%rax)
	movq	%rbx, 24(%rax)
	movq	72(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L277
	movq	104(%rsp), %r14
	.cfi_restore 14
	movq	112(%rsp), %r15
	.cfi_restore 15
	movq	88(%rsp), %rbx
	movq	96(%rsp), %rbp
	addq	$120, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L254:
	.cfi_def_cfa_offset 128
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L278
	movq	96(%rsp), %rbp
	movq	%rbx, %rdi
	movq	88(%rsp), %rbx
	addq	$120, %rsp
	.cfi_def_cfa_offset 8
	jmp	parse_postfix
	.p2align 4,,10
	.p2align 3
.L275:
	.cfi_def_cfa_offset 128
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	testq	%rbx, %rbx
	je	.L258
	movl	(%rbx), %eax
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L259
	cmpl	$5, %eax
	je	.L279
.L258:
	movl	%ebp, %edi
	call	tk_name@PLT
	movl	%r14d, %ecx
	movl	%r15d, %edx
	leaq	.LC21(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L259
	.p2align 4,,10
	.p2align 3
.L276:
	testq	%rbx, %rbx
	je	.L260
	movl	(%rbx), %eax
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L259
	cmpl	$5, %eax
	je	.L280
.L260:
	movl	%r14d, %edx
	movl	%r15d, %esi
	leaq	.LC22(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L259
.L278:
	.cfi_restore 14
	.cfi_restore 15
	movq	%r14, 104(%rsp)
	movq	%r15, 112(%rsp)
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	call	__stack_chk_fail@PLT
	.p2align 4,,10
	.p2align 3
.L279:
	cmpl	$32, 16(%rbx)
	jne	.L258
	jmp	.L259
	.p2align 4,,10
	.p2align 3
.L280:
	cmpl	$32, 16(%rbx)
	jne	.L260
	jmp	.L259
.L277:
	call	__stack_chk_fail@PLT
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
	leaq	CSWTCH.5(%rip), %r14
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
	movl	%esi, 12(%rsp)
	movq	%fs:40, %rbp
	movq	%rbp, 72(%rsp)
	movq	%rdx, %rbp
.L287:
	movl	40(%rbx), %r12d
	xorl	%r13d, %r13d
	leal	-22(%r12), %eax
	cmpl	$33, %eax
	ja	.L282
	movsbl	(%r14,%rax), %r13d
.L282:
	cmpl	%r13d, 12(%rsp)
	jg	.L292
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movq	%rbx, %rdi
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	call	parse_unary
	movq	%rax, %r15
	movl	40(%rbx), %eax
	leal	-22(%rax), %ecx
	cmpl	$33, %ecx
	ja	.L286
	movsbl	(%r14,%rcx), %eax
	cmpl	%eax, %r13d
	jl	.L293
.L286:
	movq	4(%rbp), %r13
	movl	$48, %edi
	call	xmalloc@PLT
	movq	%rbp, 24(%rax)
	movq	%rax, %rbp
	movl	$7, (%rax)
	movq	%r13, 4(%rax)
	movl	%r12d, 16(%rax)
	movq	%r15, 32(%rax)
	jmp	.L287
	.p2align 4,,10
	.p2align 3
.L292:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L294
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
.L293:
	.cfi_restore_state
	movq	%r15, %rdx
	leal	1(%r13), %esi
	movq	%rbx, %rdi
	call	parse_bin_rhs
	movq	%rax, %r15
	jmp	.L286
.L294:
	call	__stack_chk_fail@PLT
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
	subq	$136, %rsp
	.cfi_def_cfa_offset 144
	movq	%rbx, 88(%rsp)
	movq	%r12, 104(%rsp)
	movq	%rbp, 96(%rsp)
	.cfi_offset 3, -56
	.cfi_offset 12, -40
	.cfi_offset 6, -48
	movq	%fs:40, %rbp
	movq	%rbp, 72(%rsp)
	movq	%rdi, %rbp
	call	parse_unary
	movl	$1, %esi
	movq	%rax, %rdx
	movq	%rbp, %rdi
	call	parse_bin_rhs
	movl	40(%rbp), %r12d
	movq	%rax, %rbx
	cmpl	$56, %r12d
	je	.L321
	cmpl	$21, %r12d
	je	.L299
	leal	-38(%r12), %eax
	cmpl	$14, %eax
	ja	.L295
.L299:
	leaq	40(%rbp), %rdi
	movq	%r14, 120(%rsp)
	movq	%r15, 128(%rsp)
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%rbp, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 40(%rbp)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbp)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbp)
	testq	%rbx, %rbx
	je	.L300
.L304:
	movl	(%rbx), %eax
	leal	-2(%rax), %edx
	andl	$-3, %edx
	je	.L320
	cmpl	$5, %eax
	je	.L322
.L300:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movl	%r12d, %edi
	movl	%ecx, 12(%rsp)
	movl	%edx, (%rsp)
	call	tk_name@PLT
	movl	12(%rsp), %ecx
	movl	(%rsp), %edx
	leaq	.LC23(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
.L320:
	movq	%rbp, %rdi
	movq	%rbx, %r15
	call	parse_assignment
	movq	4(%rbx), %rbp
	movl	$48, %edi
	movq	%rax, %r14
	call	xmalloc@PLT
	movl	$8, (%rax)
	movq	%rax, %rbx
	movq	%rbp, 4(%rax)
	movl	%r12d, 16(%rax)
	movq	%r15, 24(%rax)
	movq	128(%rsp), %r15
	.cfi_restore 15
	movq	%r14, 32(%rax)
	movq	120(%rsp), %r14
	.cfi_restore 14
.L295:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L323
	movq	%rbx, %rax
	movq	96(%rsp), %rbp
	movq	88(%rsp), %rbx
	movq	104(%rsp), %r12
	addq	$136, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L322:
	.cfi_def_cfa_offset 144
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	cmpl	$32, 16(%rbx)
	jne	.L300
	jmp	.L320
	.p2align 4,,10
	.p2align 3
.L321:
	.cfi_restore 14
	.cfi_restore 15
	leaq	40(%rbp), %rdi
	movq	%r13, 112(%rsp)
	.cfi_offset 13, -32
	leaq	40(%rbp), %r13
	movq	%r14, 120(%rsp)
	movq	%r15, 128(%rsp)
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	call	tok_free@PLT
	movq	%rbp, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movq	%rbp, %rdi
	movups	%xmm0, 40(%rbp)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbp)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbp)
	call	parse_assignment
	movl	$57, %esi
	movq	%rbp, %rdi
	movq	%rax, %r14
	call	expect
	movq	%rbp, %rdi
	call	parse_assignment
	movq	4(%rbx), %r12
	movl	$48, %edi
	movq	%rax, %r15
	call	xmalloc@PLT
	movq	%r12, 4(%rax)
	movl	40(%rbp), %r12d
	movl	$9, (%rax)
	movq	%rbx, 16(%rax)
	movq	%r14, 24(%rax)
	movq	%r15, 32(%rax)
	cmpl	$21, %r12d
	je	.L297
	leal	-38(%r12), %edx
	movq	%rax, %rbx
	cmpl	$14, %edx
	ja	.L324
.L297:
	movq	%r13, %rdi
	movq	%rax, (%rsp)
	call	tok_free@PLT
	movq	%rbp, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movq	(%rsp), %rbx
	movq	112(%rsp), %r13
	.cfi_remember_state
	.cfi_restore 13
	movups	%xmm0, 40(%rbp)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbp)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbp)
	jmp	.L304
	.p2align 4,,10
	.p2align 3
.L324:
	.cfi_restore_state
	movq	112(%rsp), %r13
	.cfi_restore 13
	movq	120(%rsp), %r14
	.cfi_restore 14
	movq	128(%rsp), %r15
	.cfi_restore 15
	jmp	.L295
.L323:
	movq	%r13, 112(%rsp)
	movq	%r14, 120(%rsp)
	movq	%r15, 128(%rsp)
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE50:
	.size	parse_assignment, .-parse_assignment
	.p2align 4
	.globl	parse_init_list
	.type	parse_init_list, @function
parse_init_list:
.LFB43:
	.cfi_startproc
	subq	$120, %rsp
	.cfi_def_cfa_offset 128
	movl	$15, %esi
	movq	%rbp, 96(%rsp)
	movq	%r12, 104(%rsp)
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	movq	72(%rdi), %r12
	movq	%rbx, 88(%rsp)
	.cfi_offset 3, -40
	movq	%fs:40, %rbx
	movq	%rbx, 72(%rsp)
	movq	%rdi, %rbx
	call	expect
	movl	$40, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movl	$1, (%rax)
	movq	%rax, %rbp
	movq	%r12, 4(%rax)
	movq	$0, 16(%rax)
	movups	%xmm0, 24(%rax)
	movl	40(%rbx), %eax
	cmpl	$16, %eax
	je	.L334
.L327:
	cmpl	$15, %eax
	je	.L335
	movq	%r13, 112(%rsp)
	movl	$40, %edi
	.cfi_offset 13, -16
	movq	72(%rbx), %r13
	call	xmalloc@PLT
	movq	%rbx, %rdi
	movq	%r13, 4(%rax)
	movl	$0, (%rax)
	movq	%rax, 8(%rsp)
	call	parse_assignment
	movq	8(%rsp), %rsi
	leaq	16(%rbp), %rdi
	movq	112(%rsp), %r13
	.cfi_restore 13
	movq	%rax, 16(%rsi)
	call	vec_push@PLT
	cmpl	$17, 40(%rbx)
	je	.L336
.L331:
	movl	$16, %esi
	movq	%rbx, %rdi
	call	expect
.L325:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L337
	movq	%rbp, %rax
	movq	88(%rsp), %rbx
	movq	96(%rsp), %rbp
	movq	104(%rsp), %r12
	addq	$120, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L335:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	parse_init_list
	leaq	16(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	cmpl	$17, 40(%rbx)
	jne	.L331
.L336:
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm1
	movd	%xmm0, %eax
	movups	%xmm1, 56(%rbx)
	movdqu	48(%rsp), %xmm1
	movups	%xmm1, 72(%rbx)
	jmp	.L327
	.p2align 4,,10
	.p2align 3
.L334:
	leaq	40(%rbx), %rdi
	call	tok_free@PLT
	leaq	16(%rsp), %rdi
	movq	%rbx, %rsi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	jmp	.L325
.L337:
	movq	%r13, 112(%rsp)
	.cfi_offset 13, -16
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE43:
	.size	parse_init_list, .-parse_init_list
	.p2align 4
	.globl	parse_init_elem
	.type	parse_init_elem, @function
parse_init_elem:
.LFB44:
	.cfi_startproc
	cmpl	$15, 40(%rdi)
	je	.L342
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
	movq	72(%rdi), %r12
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
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L342:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
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
	subq	$120, %rsp
	.cfi_def_cfa_offset 128
	movq	%r12, 88(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	movl	40(%rdi), %eax
	cmpl	$53, %eax
	.cfi_offset 12, -40
	ja	.L344
	movabsq	$9007205697200158, %rdx
	btq	%rax, %rdx
	jnc	.L344
	movq	%rbx, 72(%rsp)
	.cfi_offset 3, -56
	movq	72(%rdi), %rbx
	movq	%rbp, 80(%rsp)
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	movl	$40, %edi
	movq	%r13, 96(%rsp)
	movq	%r14, 104(%rsp)
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movl	$1, (%rax)
	movq	%rax, %r12
	leaq	16(%rax), %r13
	movq	%rbx, 4(%rax)
	movq	$0, 16(%rax)
	movups	%xmm0, 24(%rax)
.L348:
	cmpl	$15, 40(%rbp)
	je	.L355
	movq	72(%rbp), %r14
	movl	$40, %edi
	call	xmalloc@PLT
	movq	%rbp, %rdi
	movl	$0, (%rax)
	movq	%rax, %rbx
	movq	%r14, 4(%rax)
	call	parse_assignment
	movq	%rax, 16(%rbx)
.L346:
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	vec_push@PLT
	cmpl	$17, 40(%rbp)
	je	.L356
	movq	72(%rsp), %rbx
	.cfi_restore 3
	movq	80(%rsp), %rbp
	.cfi_restore 6
	movq	96(%rsp), %r13
	.cfi_restore 13
	movq	104(%rsp), %r14
	.cfi_restore 14
	jmp	.L343
	.p2align 4,,10
	.p2align 3
.L344:
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L343:
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L357
	movq	%r12, %rax
	movq	88(%rsp), %r12
	addq	$120, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L355:
	.cfi_def_cfa_offset 128
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	movq	%rbp, %rdi
	call	parse_init_list
	movq	%rax, %rbx
	jmp	.L346
	.p2align 4,,10
	.p2align 3
.L356:
	leaq	40(%rbp), %rdi
	call	tok_free@PLT
	movq	%rsp, %rdi
	movq	%rbp, %rsi
	call	lx_next@PLT
	movdqu	(%rsp), %xmm0
	movups	%xmm0, 40(%rbp)
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 56(%rbp)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 72(%rbp)
	jmp	.L348
.L357:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 13
	.cfi_restore 14
	movq	%rbx, 72(%rsp)
	movq	%rbp, 80(%rsp)
	movq	%r13, 96(%rsp)
	movq	%r14, 104(%rsp)
	movq	%r15, 112(%rsp)
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	call	__stack_chk_fail@PLT
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
	xorl	%eax, %eax
	cmpl	$1, 40(%rdi)
	je	.L359
	movl	76(%rdi), %edx
	movl	72(%rdi), %esi
	leaq	.LC24(%rip), %rdi
	call	dief@PLT
.L359:
	movl	$56, %edi
	call	xmalloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L379
.L360:
	pxor	%xmm0, %xmm0
	movq	$0, 48(%rbp)
	leaq	40(%rbx), %r12
	movups	%xmm0, 0(%rbp)
	movups	%xmm0, 16(%rbp)
	movups	%xmm0, 32(%rbp)
	movq	48(%rbx), %rdi
	call	sdup@PLT
	movq	%r12, %rdi
	movq	%rax, 8(%rbp)
	call	tok_free@PLT
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movd	%xmm0, %eax
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	cmpl	$19, %eax
	je	.L361
	cmpl	$15, %eax
	je	.L380
	cmpl	$18, %eax
	je	.L381
	cmpl	$21, %eax
	je	.L382
	movq	%rbx, %rdi
	call	parse_comma_init_list
	testq	%rax, %rax
	je	.L372
	cmpl	$2, 16(%rbp)
	je	.L377
	movl	$1, 16(%rbp)
.L377:
	movq	%rax, 48(%rbp)
	movl	$18, %esi
	movq	%rbx, %rdi
	call	expect
.L358:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L383
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
.L379:
	.cfi_restore_state
	leaq	.LC11(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L360
	.p2align 4,,10
	.p2align 3
.L361:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movl	$2, 16(%rbp)
	cmpl	$20, 40(%rbx)
	je	.L384
	movq	%rbx, %rdi
	call	parse_expr
	movl	$20, %esi
	movq	%rbx, %rdi
	movq	%rax, 24(%rbp)
	call	expect
.L365:
	movq	%rbx, %rdi
	cmpl	$15, 40(%rbx)
	je	.L378
	call	parse_comma_init_list
	jmp	.L377
	.p2align 4,,10
	.p2align 3
.L380:
	movl	$1, 16(%rbp)
	movq	%rbx, %rdi
.L378:
	call	parse_init_list
	jmp	.L377
	.p2align 4,,10
	.p2align 3
.L381:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movl	$0, 16(%rbp)
	movq	$0, 48(%rbp)
	jmp	.L358
	.p2align 4,,10
	.p2align 3
.L372:
	movq	8(%rbp), %rsi
	movl	76(%rbx), %ecx
	leaq	.LC25(%rip), %rdi
	xorl	%eax, %eax
	movl	72(%rbx), %edx
	xorl	%ebp, %ebp
	call	dief@PLT
	jmp	.L358
	.p2align 4,,10
	.p2align 3
.L382:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movl	$40, %edi
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movl	$0, 16(%rbp)
	movq	72(%rbx), %rdx
	movq	%rdx, 8(%rsp)
	call	xmalloc@PLT
	movq	8(%rsp), %rdx
	movq	%rbx, %rdi
	movl	$0, (%rax)
	movq	%rax, %r12
	movq	%rdx, 4(%rax)
	call	parse_expr
	movl	$18, %esi
	movq	%rbx, %rdi
	movq	%rax, 16(%r12)
	movq	%r12, 48(%rbp)
	call	expect
	jmp	.L358
	.p2align 4,,10
	.p2align 3
.L384:
	movq	%r12, %rdi
	call	tok_free@PLT
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	call	lx_next@PLT
	movdqu	16(%rsp), %xmm0
	movups	%xmm0, 40(%rbx)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 56(%rbx)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 72(%rbx)
	movl	$1, 32(%rbp)
	jmp	.L365
.L383:
	call	__stack_chk_fail@PLT
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
	subq	$152, %rsp
	.cfi_def_cfa_offset 160
	movq	%r12, 128(%rsp)
	movq	%rbx, 112(%rsp)
	.cfi_offset 12, -32
	.cfi_offset 3, -48
	movq	%fs:40, %rbx
	movq	%rbx, 104(%rsp)
	movq	%rdi, %rbx
	movl	$24, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	$0, (%rax)
	movq	%rax, %r12
	movups	%xmm0, 8(%rax)
	movl	40(%rbx), %edx
	testl	%edx, %edx
	je	.L385
	movq	%rbp, 120(%rsp)
	movq	%r13, 136(%rsp)
	movq	%r14, 144(%rsp)
	.cfi_offset 6, -40
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	jmp	.L392
	.p2align 4,,10
	.p2align 3
.L390:
	call	tk_name@PLT
	leaq	.LC26(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
.L388:
	movq	%rbp, %rsi
	movq	%r12, %rdi
	call	vec_push@PLT
	movl	40(%rbx), %eax
	testl	%eax, %eax
	je	.L396
.L392:
	movl	$16, %edi
	call	xmalloc@PLT
	movl	40(%rbx), %edi
	movq	%rax, %rbp
	cmpl	$12, %edi
	je	.L397
	cmpl	$5, %edi
	je	.L398
	cmpl	$1, %edi
	jne	.L390
	movdqu	(%rbx), %xmm0
	movq	32(%rbx), %rax
	movq	%rsp, %rsi
	leaq	48(%rsp), %rdi
	movq	g_compilation_arena(%rip), %r14
	movq	$0, g_compilation_arena(%rip)
	movaps	%xmm0, (%rsp)
	movdqu	16(%rbx), %xmm0
	movq	%rax, 32(%rsp)
	movaps	%xmm0, 16(%rsp)
	call	lx_next@PLT
	movl	48(%rsp), %r13d
	leaq	48(%rsp), %rdi
	call	tok_free@PLT
	movq	%r14, g_compilation_arena(%rip)
	cmpl	$13, %r13d
	je	.L399
	movl	$2, 0(%rbp)
	movq	%rbx, %rdi
	call	parse_extern_var_def
	movq	%rax, 8(%rbp)
	jmp	.L388
	.p2align 4,,10
	.p2align 3
.L397:
	movl	$3, (%rax)
	movq	%rbx, %rdi
	call	parse_extern_decl
	movq	%rax, 8(%rbp)
	jmp	.L388
	.p2align 4,,10
	.p2align 3
.L398:
	movl	$0, (%rax)
	movq	%rbx, %rdi
	call	parse_auto_decl
	movq	%rax, 8(%rbp)
	jmp	.L388
	.p2align 4,,10
	.p2align 3
.L396:
	movq	120(%rsp), %rbp
	.cfi_restore 6
	movq	136(%rsp), %r13
	.cfi_restore 13
	movq	144(%rsp), %r14
	.cfi_restore 14
.L385:
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L400
	movq	%r12, %rax
	movq	112(%rsp), %rbx
	movq	128(%rsp), %r12
	addq	$152, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L399:
	.cfi_def_cfa_offset 160
	.cfi_offset 6, -40
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	movl	$1, 0(%rbp)
	movq	%rbx, %rdi
	call	parse_function
	movq	%rax, 8(%rbp)
	jmp	.L388
.L400:
	.cfi_restore 6
	.cfi_restore 13
	.cfi_restore 14
	movq	%rbp, 120(%rsp)
	movq	%r13, 136(%rsp)
	movq	%r14, 144(%rsp)
	.cfi_offset 6, -40
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE25:
	.size	parse_program_ast, .-parse_program_ast
	.section	.rodata
	.align 32
	.type	CSWTCH.5, @object
	.size	CSWTCH.5, 34
CSWTCH.5:
	.byte	5
	.byte	5
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	8
	.byte	8
	.byte	8
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
	.ident	"GCC: (GNU) 16.1.1 20260430"
	.section	.note.GNU-stack,"",@progbits
