	.file	"emitter.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"static word __b_str%zu[] = {"
.LC1:
	.string	"0x%0*lx"
.LC2:
	.string	"};\n"
	.text
	.p2align 4
	.type	emit_string_pool, @function
emit_string_pool:
.LFB15:
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	cmpq	$0, 8+string_pool(%rip)
	movq	%rdi, (%rsp)
	je	.L1
	xorl	%r14d, %r14d
	movq	%r14, 24(%rsp)
	.p2align 4
	.p2align 3
.L12:
	leaq	string_pool(%rip), %rax
	movq	24(%rsp), %rdi
	cmpl	$16, current_word_bits(%rip)
	movl	$8, %r13d
	movq	(%rax), %rax
	leaq	.LC0(%rip), %rsi
	movq	(%rax,%rdi,8), %rax
	movq	8(%rax), %r15
	movq	(%rax), %rbp
	movl	$2, %eax
	cmove	%rax, %r13
	xorl	%ebx, %ebx
	movq	%r13, %rax
	addq	%r15, %rax
	setc	%bl
	xorl	%edx, %edx
	divq	%r13
	movq	%rdi, %rdx
	movq	(%rsp), %rdi
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	call	fprintf@PLT
	testq	%rbx, %rbx
	jne	.L6
	leal	(%r13,%r13), %eax
	xorl	%ebx, %ebx
	movq	%r13, %r14
	movl	%eax, 20(%rsp)
	.p2align 4
	.p2align 3
.L7:
	movq	%r14, %rsi
	xorl	%r12d, %r12d
	xorl	%ecx, %ecx
	subq	%r13, %rsi
	jmp	.L10
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L22:
	movzbl	0(%rbp,%rsi), %eax
.L9:
	movzbl	%al, %eax
	addq	$1, %rsi
	salq	%cl, %rax
	addl	$8, %ecx
	orq	%rax, %r12
	cmpq	%r14, %rsi
	je	.L21
.L10:
	cmpq	%r15, %rsi
	jb	.L22
	cmpq	%rsi, %r15
	sete	%al
	sall	$2, %eax
	jmp	.L9
	.p2align 4,,10
	.p2align 3
.L21:
	testq	%rbx, %rbx
	je	.L11
	movq	(%rsp), %rsi
	movl	$44, %edi
	call	fputc@PLT
.L11:
	movl	20(%rsp), %edx
	movq	(%rsp), %rdi
	movq	%r12, %rcx
	xorl	%eax, %eax
	leaq	.LC1(%rip), %rsi
	addq	$1, %rbx
	addq	%r13, %r14
	call	fprintf@PLT
	movq	8(%rsp), %rax
	cmpq	%rax, %rbx
	jb	.L7
.L6:
	movq	(%rsp), %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC2(%rip), %rdi
	call	fwrite@PLT
	addq	$1, 24(%rsp)
	movq	24(%rsp), %rax
	cmpq	8+string_pool(%rip), %rax
	jb	.L12
.L1:
	addq	$40, %rsp
	.cfi_def_cfa_offset 56
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
	.cfi_endproc
.LFE15:
	.size	emit_string_pool, .-emit_string_pool
	.section	.rodata.str1.1
.LC3:
	.string	"="
.LC4:
	.string	"+="
.LC5:
	.string	"-="
.LC6:
	.string	"*="
.LC7:
	.string	"/="
.LC8:
	.string	"%="
.LC9:
	.string	"<<="
.LC10:
	.string	">>="
.LC11:
	.string	"&="
.LC12:
	.string	"|="
	.text
	.p2align 4
	.type	assignment_op_to_c, @function
assignment_op_to_c:
.LFB32:
	.cfi_startproc
	leal	-21(%rdi), %eax
	cmpl	$25, %eax
	ja	.L24
	leaq	.L26(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L26:
	.long	.L35-.L26
	.long	.L24-.L26
	.long	.L24-.L26
	.long	.L24-.L26
	.long	.L24-.L26
	.long	.L24-.L26
	.long	.L24-.L26
	.long	.L24-.L26
	.long	.L24-.L26
	.long	.L24-.L26
	.long	.L24-.L26
	.long	.L24-.L26
	.long	.L24-.L26
	.long	.L24-.L26
	.long	.L24-.L26
	.long	.L24-.L26
	.long	.L24-.L26
	.long	.L36-.L26
	.long	.L33-.L26
	.long	.L32-.L26
	.long	.L31-.L26
	.long	.L30-.L26
	.long	.L29-.L26
	.long	.L28-.L26
	.long	.L27-.L26
	.long	.L25-.L26
	.text
	.p2align 4,,10
	.p2align 3
.L24:
	jmp	tk_name@PLT
	.p2align 4,,10
	.p2align 3
.L33:
	leaq	.LC5(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L32:
	leaq	.LC6(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L31:
	leaq	.LC7(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L30:
	leaq	.LC8(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L29:
	leaq	.LC9(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L28:
	leaq	.LC10(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L27:
	leaq	.LC11(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L25:
	leaq	.LC12(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L36:
	leaq	.LC4(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L35:
	leaq	.LC3(%rip), %rax
	ret
	.cfi_endproc
.LFE32:
	.size	assignment_op_to_c, .-assignment_op_to_c
	.p2align 4
	.type	get_string_id, @function
get_string_id:
.LFB14:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rdi, %r15
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movq	8+string_pool(%rip), %r13
	testq	%r13, %r13
	je	.L38
	movq	string_pool(%rip), %r14
	xorl	%ebx, %ebx
	jmp	.L41
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L39:
	addq	$1, %rbx
	cmpq	%r13, %rbx
	je	.L38
.L41:
	movq	(%r14,%rbx,8), %rbp
	cmpq	%r12, 8(%rbp)
	jne	.L39
	movq	0(%rbp), %rdi
	movq	%r12, %rdx
	movq	%r15, %rsi
	call	memcmp@PLT
	testl	%eax, %eax
	jne	.L39
	movl	16(%rbp), %eax
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
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
.L38:
	.cfi_restore_state
	leaq	1(%r12), %rbp
	movl	$24, %edi
	call	xmalloc@PLT
	movq	%rbp, %rdi
	movq	%rax, %rbx
	call	xmalloc@PLT
	movq	%rbp, %rdx
	movq	%r15, %rsi
	movq	%rax, %rdi
	call	memcpy@PLT
	movq	%r12, 8(%rbx)
	movq	%rbx, %rsi
	leaq	string_pool(%rip), %rdi
	movq	%rax, (%rbx)
	movq	8+string_pool(%rip), %rax
	movl	%eax, 16(%rbx)
	call	vec_push@PLT
	movl	16(%rbx), %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
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
	.cfi_endproc
.LFE14:
	.size	get_string_id, .-get_string_id
	.p2align 4
	.type	collect_strings_expr, @function
collect_strings_expr:
.LFB28:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L71
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L52(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L49:
	cmpl	$10, (%rbx)
	ja	.L47
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L52:
	.long	.L47-.L52
	.long	.L60-.L52
	.long	.L47-.L52
	.long	.L59-.L52
	.long	.L51-.L52
	.long	.L75-.L52
	.long	.L75-.L52
	.long	.L74-.L52
	.long	.L74-.L52
	.long	.L53-.L52
	.long	.L51-.L52
	.text
	.p2align 4,,10
	.p2align 3
.L51:
	movq	32(%rbx), %rdi
	call	collect_strings_expr
.L75:
	movq	40(%rbx), %rbx
.L62:
	testq	%rbx, %rbx
	jne	.L49
.L47:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L53:
	.cfi_restore_state
	movq	32(%rbx), %rdi
	call	collect_strings_expr
.L74:
	movq	40(%rbx), %rdi
	call	collect_strings_expr
	movq	48(%rbx), %rbx
	jmp	.L62
	.p2align 4,,10
	.p2align 3
.L59:
	movq	32(%rbx), %rdi
	call	collect_strings_expr
	cmpq	$0, 48(%rbx)
	je	.L47
	xorl	%ebp, %ebp
.L61:
	movq	40(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_expr
	cmpq	48(%rbx), %rbp
	jb	.L61
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L60:
	.cfi_restore_state
	movq	24(%rbx), %rsi
	movq	32(%rbx), %rdi
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	jmp	get_string_id
	.p2align 4,,10
	.p2align 3
.L71:
	ret
	.cfi_endproc
.LFE28:
	.size	collect_strings_expr, .-collect_strings_expr
	.p2align 4
	.type	collect_strings_init, @function
collect_strings_init:
.LFB29:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L85
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movl	(%rdi), %eax
	testl	%eax, %eax
	je	.L88
	cmpl	$1, %eax
	je	.L89
.L76:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L88:
	.cfi_restore_state
	movq	16(%rdi), %rdi
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	jmp	collect_strings_expr
	.p2align 4,,10
	.p2align 3
.L89:
	.cfi_restore_state
	cmpq	$0, 24(%rdi)
	je	.L76
	xorl	%ebp, %ebp
.L79:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_init
	cmpq	24(%rbx), %rbp
	jb	.L79
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L85:
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE29:
	.size	collect_strings_init, .-collect_strings_init
	.p2align 4
	.type	collect_strings_stmt, @function
collect_strings_stmt:
.LFB30:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L113
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L95(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L92:
	cmpl	$12, (%rbx)
	ja	.L90
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L95:
	.long	.L90-.L95
	.long	.L102-.L95
	.long	.L90-.L95
	.long	.L101-.L95
	.long	.L94-.L95
	.long	.L98-.L95
	.long	.L98-.L95
	.long	.L90-.L95
	.long	.L90-.L95
	.long	.L90-.L95
	.long	.L98-.L95
	.long	.L96-.L95
	.long	.L94-.L95
	.text
	.p2align 4,,10
	.p2align 3
.L98:
	movq	16(%rbx), %rdi
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	jmp	collect_strings_expr
	.p2align 4,,10
	.p2align 3
.L102:
	.cfi_restore_state
	cmpq	$0, 24(%rbx)
	je	.L90
	xorl	%ebp, %ebp
.L103:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_stmt
	cmpq	24(%rbx), %rbp
	jb	.L103
.L90:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L94:
	.cfi_restore_state
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rbx
.L104:
	testq	%rbx, %rbx
	jne	.L92
	jmp	.L90
	.p2align 4,,10
	.p2align 3
.L96:
	movq	24(%rbx), %rbx
	jmp	.L104
	.p2align 4,,10
	.p2align 3
.L101:
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rdi
	call	collect_strings_stmt
	movq	32(%rbx), %rbx
	jmp	.L104
	.p2align 4,,10
	.p2align 3
.L113:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE30:
	.size	collect_strings_stmt, .-collect_strings_stmt
	.p2align 4
	.type	collect_strings_program, @function
collect_strings_program:
.LFB31:
	.cfi_startproc
	cmpq	$0, 8(%rdi)
	je	.L126
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	xorl	%ebx, %ebx
	jmp	.L123
	.p2align 4,,10
	.p2align 3
.L119:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L129
.L123:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L130
	cmpl	$2, %eax
	je	.L131
	testl	%eax, %eax
	jne	.L119
	movq	8(%rdx), %rdi
	addq	$1, %rbx
	call	collect_strings_stmt
	cmpq	8(%rbp), %rbx
	jb	.L123
.L129:
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
.L130:
	.cfi_restore_state
	movq	8(%rdx), %rax
	movq	32(%rax), %rdi
	call	collect_strings_stmt
	jmp	.L119
	.p2align 4,,10
	.p2align 3
.L131:
	movq	8(%rdx), %r12
	movq	48(%r12), %rdi
	call	collect_strings_init
	movq	24(%r12), %rdi
	testq	%rdi, %rdi
	je	.L119
	call	collect_strings_expr
	jmp	.L119
	.p2align 4,,10
	.p2align 3
.L126:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE31:
	.size	collect_strings_program, .-collect_strings_program
	.p2align 4
	.type	collect_cases, @function
collect_cases:
.LFB41:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L154
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	leaq	.L137(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
.L134:
	cmpl	$13, (%rbx)
	ja	.L132
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L137:
	.long	.L132-.L137
	.long	.L141-.L137
	.long	.L132-.L137
	.long	.L140-.L137
	.long	.L139-.L137
	.long	.L132-.L137
	.long	.L132-.L137
	.long	.L132-.L137
	.long	.L132-.L137
	.long	.L132-.L137
	.long	.L132-.L137
	.long	.L139-.L137
	.long	.L132-.L137
	.long	.L136-.L137
	.text
	.p2align 4,,10
	.p2align 3
.L141:
	xorl	%r12d, %r12d
	cmpq	$0, 24(%rbx)
	je	.L132
.L142:
	movq	16(%rbx), %rax
	movq	%rbp, %rsi
	movq	(%rax,%r12,8), %rdi
	addq	$1, %r12
	call	collect_cases
	cmpq	24(%rbx), %r12
	jb	.L142
.L132:
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
.L139:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L143:
	testq	%rbx, %rbx
	jne	.L134
	jmp	.L132
	.p2align 4,,10
	.p2align 3
.L136:
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 8
	jmp	vec_push@PLT
	.p2align 4,,10
	.p2align 3
.L140:
	.cfi_restore_state
	movq	24(%rbx), %rdi
	movq	%rbp, %rsi
	call	collect_cases
	movq	32(%rbx), %rbx
	jmp	.L143
	.p2align 4,,10
	.p2align 3
.L154:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE41:
	.size	collect_cases, .-collect_cases
	.p2align 4
	.type	collect_function_labels, @function
collect_function_labels:
.LFB37:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L179
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L162(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L159:
	cmpl	$12, (%rbx)
	ja	.L157
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L162:
	.long	.L157-.L162
	.long	.L166-.L162
	.long	.L157-.L162
	.long	.L165-.L162
	.long	.L161-.L162
	.long	.L157-.L162
	.long	.L157-.L162
	.long	.L157-.L162
	.long	.L157-.L162
	.long	.L157-.L162
	.long	.L157-.L162
	.long	.L163-.L162
	.long	.L161-.L162
	.text
	.p2align 4,,10
	.p2align 3
.L166:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L157
.L167:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_function_labels
	cmpq	24(%rbx), %rbp
	jb	.L167
.L157:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L161:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L168:
	testq	%rbx, %rbx
	jne	.L159
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L163:
	.cfi_restore_state
	movq	16(%rbx), %rsi
	leaq	function_labels(%rip), %rdi
	call	vec_push@PLT
	movq	24(%rbx), %rbx
	jmp	.L168
	.p2align 4,,10
	.p2align 3
.L165:
	movq	24(%rbx), %rdi
	call	collect_function_labels
	movq	32(%rbx), %rbx
	jmp	.L168
	.p2align 4,,10
	.p2align 3
.L179:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE37:
	.size	collect_function_labels, .-collect_function_labels
	.section	.rodata.str1.1
.LC13:
	.string	"auto"
.LC14:
	.string	"__empty"
.LC15:
	.string	"%02X"
.LC16:
	.string	"_%02X"
.LC17:
	.string	"%s_%d"
.LC18:
	.string	"b_%s"
	.text
	.p2align 4
	.type	get_mangled_name, @function
get_mangled_name:
.LFB21:
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
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	testq	%rdi, %rdi
	je	.L217
	movq	8+name_map(%rip), %r12
	movq	%rdi, %r13
	testq	%r12, %r12
	je	.L185
	movq	name_map(%rip), %r14
	xorl	%ebx, %ebx
	jmp	.L187
	.p2align 4,,10
	.p2align 3
.L186:
	addq	$1, %rbx
	cmpq	%r12, %rbx
	je	.L185
.L187:
	movq	(%r14,%rbx,8), %rbp
	movq	%r13, %rsi
	movq	0(%rbp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L186
	movq	8(%rbp), %r12
.L183:
	addq	$24, %rsp
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
.L185:
	.cfi_restore_state
	cmpb	$0, 0(%r13)
	je	.L238
	movq	%r13, %rdi
	call	strlen@PLT
	leaq	16(,%rax,4), %rdi
	movq	%rax, (%rsp)
	call	xmalloc@PLT
	movzbl	0(%r13), %edx
	movq	(%rsp), %rcx
	movq	%rax, %r12
	leaq	1(%rax), %r14
	leal	-65(%rdx), %eax
	cmpb	$57, %al
	ja	.L190
	movabsq	$288230372997595135, %rsi
	btq	%rax, %rsi
	jnc	.L190
	movb	%dl, (%r12)
.L194:
	leaq	1(%r13), %rbx
	leaq	0(%r13,%rcx), %r15
	movabsq	$288230372997595135, %rbp
	cmpq	$1, %rcx
	ja	.L204
	jmp	.L196
	.p2align 4,,10
	.p2align 3
.L197:
	leal	-65(%rdx), %eax
	cmpb	$57, %al
	ja	.L200
	btq	%rax, %rbp
	jnc	.L200
.L198:
	movb	%dl, (%r14)
	addq	$1, %r14
.L203:
	addq	$1, %rbx
	cmpq	%rbx, %r15
	je	.L196
.L204:
	movzbl	(%rbx), %edx
	cmpb	$57, %dl
	jg	.L197
	cmpb	$47, %dl
	jg	.L198
	cmpb	$46, %dl
	jne	.L200
	addq	$1, %rbx
	movb	$95, (%r14)
	addq	$1, %r14
	cmpq	%rbx, %r15
	jne	.L204
.L196:
	movb	$0, (%r14)
	jmp	.L189
	.p2align 4,,10
	.p2align 3
.L238:
	leaq	.LC14(%rip), %rdi
	call	sdup@PLT
	movq	%rax, %r12
.L189:
	leaq	8+c_keywords(%rip), %rbx
	leaq	.LC13(%rip), %rsi
	jmp	.L206
	.p2align 4,,10
	.p2align 3
.L239:
	movq	(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L207
.L206:
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L239
	movq	%r12, %rdi
	call	strlen@PLT
	leaq	3(%rax), %rdi
	call	xmalloc@PLT
	movq	%r12, %rdx
	leaq	.LC18(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %rbx
	xorl	%eax, %eax
	call	sprintf@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L240
.L216:
	movq	%rbx, %r12
.L207:
	movq	8+name_map(%rip), %rbp
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
	testq	%rbp, %rbp
	je	.L208
	movq	name_map(%rip), %r14
	xorl	%ebx, %ebx
	jmp	.L210
	.p2align 4,,10
	.p2align 3
.L242:
	addq	$1, %rbx
	cmpq	%rbx, %rbp
	je	.L241
.L210:
	movq	(%r14,%rbx,8), %rax
	movq	%r12, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L242
	movq	%r12, %rdi
	call	strlen@PLT
	leaq	16(%rax), %rdi
	call	xmalloc@PLT
	movl	$2, %ecx
	movq	%rax, %rbp
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
	.p2align 4
	.p2align 3
.L212:
	leal	1(%rcx), %eax
	movq	%r12, %rdx
	leaq	.LC17(%rip), %rsi
	movq	%rbp, %rdi
	movl	%eax, 12(%rsp)
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	8+name_map(%rip), %rbx
	testq	%rbx, %rbx
	je	.L211
	movq	(%rsp), %rax
	xorl	%r15d, %r15d
	movq	(%rax), %r14
	jmp	.L213
	.p2align 4,,10
	.p2align 3
.L243:
	addq	$1, %r15
	cmpq	%rbx, %r15
	je	.L211
.L213:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L243
	movl	12(%rsp), %ecx
	jmp	.L212
	.p2align 4,,10
	.p2align 3
.L241:
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
.L208:
	movl	$16, %edi
	call	xmalloc@PLT
	movq	%r13, %rdi
	movq	%rax, %rbx
	call	sdup@PLT
	movq	%r12, 8(%rbx)
	movq	(%rsp), %rdi
	movq	%rbx, %rsi
	movq	%rax, (%rbx)
	call	vec_push@PLT
	jmp	.L183
.L190:
	movb	$95, (%r12)
	movzbl	0(%r13), %eax
	cmpb	$46, %al
	jne	.L244
	movb	$95, 1(%r12)
	leaq	2(%r12), %r14
	jmp	.L194
	.p2align 4,,10
	.p2align 3
.L200:
	movq	%r14, %rdi
	leaq	.LC16(%rip), %rsi
	xorl	%eax, %eax
	addq	$3, %r14
	call	sprintf@PLT
	jmp	.L203
	.p2align 4,,10
	.p2align 3
.L211:
	cmpq	$0, g_compilation_arena(%rip)
	je	.L245
.L214:
	movq	%rbp, %r12
	jmp	.L208
.L217:
	xorl	%r12d, %r12d
	jmp	.L183
.L244:
	movzbl	%al, %edx
	movq	%r14, %rdi
	leaq	.LC15(%rip), %rsi
	xorl	%eax, %eax
	movq	%rcx, (%rsp)
	leaq	3(%r12), %r14
	call	sprintf@PLT
	movq	(%rsp), %rcx
	jmp	.L194
.L240:
	movq	%r12, %rdi
	call	free@PLT
	jmp	.L216
.L245:
	movq	%r12, %rdi
	call	free@PLT
	jmp	.L214
	.cfi_endproc
.LFE21:
	.size	get_mangled_name, .-get_mangled_name
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC19:
	.string	"    (void)B_PTR_N(&%s, sizeof(%s));\n"
	.align 8
.LC20:
	.string	"    (void)B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.align 8
.LC21:
	.string	"    (void)B_PTR_N(__%s_blob, sizeof(__%s_blob));\n"
	.text
	.p2align 4
	.type	emit_global_regions.part.0, @function
emit_global_regions.part.0:
.LFB60:
	.cfi_startproc
	cmpq	$0, 8(%rsi)
	je	.L259
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	.LC19(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	xorl	%ebx, %ebx
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	jmp	.L253
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L249:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L262
.L253:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$2, (%rax)
	jne	.L249
	movq	8(%rax), %r15
	movq	8(%r15), %rdi
	call	get_mangled_name
	movq	%r14, %rsi
	movq	%r13, %rdi
	movq	%rax, %rcx
	movq	%rax, %rdx
	movq	%rax, %r12
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	16(%r15), %eax
	cmpl	$2, %eax
	je	.L263
	cmpl	$1, %eax
	jne	.L249
	movq	48(%r15), %rax
	testq	%rax, %rax
	je	.L252
	cmpl	$1, (%rax)
	je	.L264
.L252:
	movq	%r12, %rcx
	movq	%r12, %rdx
	leaq	.LC21(%rip), %rsi
	movq	%r13, %rdi
	xorl	%eax, %eax
	addq	$1, %rbx
	call	fprintf@PLT
	cmpq	8(%rbp), %rbx
	jb	.L253
.L262:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
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
.L263:
	.cfi_restore_state
	movq	%r12, %rcx
	movq	%r12, %rdx
	leaq	.LC20(%rip), %rsi
	movq	%r13, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L249
	.p2align 4,,10
	.p2align 3
.L264:
	cmpq	$1, 24(%rax)
	jne	.L252
	movq	16(%rax), %rax
	movq	(%rax), %rax
	movl	(%rax), %edx
	testl	%edx, %edx
	jne	.L252
	movq	16(%rax), %rax
	cmpl	$1, (%rax)
	jne	.L252
	jmp	.L249
	.p2align 4,,10
	.p2align 3
.L259:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.cfi_endproc
.LFE60:
	.size	emit_global_regions.part.0, .-emit_global_regions.part.0
	.section	.rodata.str1.1
.LC22:
	.string	"main"
.LC23:
	.string	"b_main"
.LC24:
	.string	"extern word "
.LC25:
	.string	"();\n"
	.text
	.p2align 4
	.type	emit_known_external_function_prototypes, @function
emit_known_external_function_prototypes:
.LFB26:
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	cmpq	$0, 8+g_known_functions(%rip)
	movq	%rdi, 24(%rsp)
	movq	%rsi, 8(%rsp)
	je	.L265
	movl	$0, 20(%rsp)
	xorl	%ebp, %ebp
	leaq	g_known_functions(%rip), %r13
	.p2align 4
	.p2align 3
.L271:
	movq	0(%r13), %rax
	leaq	.LC22(%rip), %rsi
	movq	(%rax,%rbp,8), %rbx
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L267
	leaq	.LC23(%rip), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L267
	movq	8(%rsp), %rax
	movq	8(%rax), %r14
	movq	(%rax), %r12
	testq	%r14, %r14
	je	.L268
	xorl	%r15d, %r15d
	jmp	.L270
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L269:
	addq	$1, %r15
	cmpq	%r15, %r14
	je	.L268
.L270:
	movq	(%r12,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L269
	movq	8(%rax), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L269
	.p2align 4
	.p2align 3
.L267:
	addq	$1, %rbp
	cmpq	8+g_known_functions(%rip), %rbp
	jb	.L271
.L293:
	movl	20(%rsp), %eax
	testl	%eax, %eax
	jne	.L292
.L265:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
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
.L268:
	.cfi_restore_state
	movq	24(%rsp), %r14
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC24(%rip), %rdi
	addq	$1, %rbp
	movq	%r14, %rcx
	call	fwrite@PLT
	movq	%rbx, %rdi
	call	get_mangled_name
	movq	%r14, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%r14, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC25(%rip), %rdi
	call	fwrite@PLT
	cmpq	8+g_known_functions(%rip), %rbp
	movl	$1, 20(%rsp)
	jb	.L271
	jmp	.L293
.L292:
	movq	24(%rsp), %rsi
	addq	$40, %rsp
	.cfi_def_cfa_offset 56
	movl	$10, %edi
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
	jmp	fputc@PLT
	.cfi_endproc
.LFE26:
	.size	emit_known_external_function_prototypes, .-emit_known_external_function_prototypes
	.section	.rodata.str1.1
.LC26:
	.string	"char"
.LC27:
	.string	"__b_user_main"
	.text
	.p2align 4
	.type	emit_function_name, @function
emit_function_name:
.LFB24:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	leaq	.LC22(%rip), %rsi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rbp, %rdi
	leaq	8+names.0(%rip), %rbx
	call	strcmp@PLT
	leaq	.LC26(%rip), %rsi
	testl	%eax, %eax
	jne	.L297
	jmp	.L304
	.p2align 4,,10
	.p2align 3
.L306:
	movq	(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L305
.L297:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L306
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbp, %rdx
	movq	%r12, %rdi
	popq	%rbp
	.cfi_def_cfa_offset 16
	leaq	.LC18(%rip), %rsi
	xorl	%eax, %eax
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L305:
	.cfi_restore_state
	movq	%rbp, %rdi
	call	get_mangled_name
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%r12, %rsi
	popq	%rbp
	.cfi_def_cfa_offset 16
	movq	%rax, %rdi
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	fputs@PLT
	.p2align 4,,10
	.p2align 3
.L304:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	movq	%r12, %rcx
	popq	%rbp
	.cfi_def_cfa_offset 16
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC27(%rip), %rdi
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	fwrite@PLT
	.cfi_endproc
.LFE24:
	.size	emit_function_name, .-emit_function_name
	.p2align 4
	.type	edge_words_total.part.0.isra.0, @function
edge_words_total.part.0.isra.0:
.LFB67:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movl	$1, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	testq	%rsi, %rsi
	cmovne	%rsi, %r13
	je	.L311
	movq	%rdi, %r12
	movq	%rsi, %rbp
	xorl	%ebx, %ebx
.L310:
	movq	(%r12,%rbx,8), %rax
	testq	%rax, %rax
	je	.L309
	cmpl	$1, (%rax)
	je	.L317
.L309:
	addq	$1, %rbx
	cmpq	%rbp, %rbx
	jne	.L310
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%r13, %rax
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
.L317:
	.cfi_restore_state
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r13
	jmp	.L309
	.p2align 4,,10
	.p2align 3
.L311:
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	movl	$1, %r13d
	popq	%rbx
	.cfi_def_cfa_offset 32
	movq	%r13, %rax
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE67:
	.size	edge_words_total.part.0.isra.0, .-edge_words_total.part.0.isra.0
	.section	.rodata.str1.1
.LC28:
	.string	"  "
	.text
	.p2align 4
	.globl	emit_indent
	.type	emit_indent, @function
emit_indent:
.LFB33:
	.cfi_startproc
	testl	%esi, %esi
	jle	.L323
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	leaq	.LC28(%rip), %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movl	%esi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	xorl	%ebx, %ebx
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	.p2align 4
	.p2align 3
.L320:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L320
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
	.p2align 4,,10
	.p2align 3
.L323:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	ret
	.cfi_endproc
.LFE33:
	.size	emit_indent, .-emit_indent
	.section	.rodata.str1.1
.LC29:
	.string	"#line %d \"%s\"\n"
	.text
	.p2align 4
	.globl	emit_line_directive
	.type	emit_line_directive, @function
emit_line_directive:
.LFB34:
	.cfi_startproc
	movl	g_no_line(%rip), %eax
	testl	%eax, %eax
	jne	.L326
	testq	%rdx, %rdx
	jne	.L334
.L326:
	ret
	.p2align 4,,10
	.p2align 3
.L334:
	movq	%rdx, %rcx
	xorl	%eax, %eax
	movl	%esi, %edx
	leaq	.LC29(%rip), %rsi
	jmp	fprintf@PLT
	.cfi_endproc
.LFE34:
	.size	emit_line_directive, .-emit_line_directive
	.section	.rodata.str1.1
.LC30:
	.string	"\\n"
.LC31:
	.string	"\\t"
.LC32:
	.string	"\\x%02x"
	.text
	.p2align 4
	.globl	emit_c_string
	.type	emit_c_string, @function
emit_c_string:
.LFB35:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	leaq	.LC30(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	leaq	.LC32(%rip), %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rsi, %rbp
	movq	%rdi, %rsi
	movl	$34, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	call	fputc@PLT
	movzbl	0(%rbp), %ebx
	testb	%bl, %bl
	jne	.L336
	jmp	.L343
	.p2align 4,,10
	.p2align 3
.L351:
	movq	%r13, %rsi
	movq	%r12, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L339:
	movzbl	1(%rbp), %ebx
	addq	$1, %rbp
	testb	%bl, %bl
	je	.L343
.L336:
	cmpb	$92, %bl
	je	.L344
	cmpb	$34, %bl
	je	.L344
	cmpb	$10, %bl
	je	.L349
	cmpb	$9, %bl
	je	.L350
	movzbl	%bl, %edx
	cmpb	$31, %bl
	jbe	.L351
	movq	%r12, %rsi
	movl	%edx, %edi
	addq	$1, %rbp
	call	fputc@PLT
	movzbl	0(%rbp), %ebx
	testb	%bl, %bl
	jne	.L336
.L343:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%r12, %rsi
	popq	%rbp
	.cfi_def_cfa_offset 32
	movl	$34, %edi
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	fputc@PLT
	.p2align 4,,10
	.p2align 3
.L344:
	.cfi_restore_state
	movq	%r12, %rsi
	movl	$92, %edi
	call	fputc@PLT
	movzbl	%bl, %edi
	movq	%r12, %rsi
	call	fputc@PLT
	jmp	.L339
	.p2align 4,,10
	.p2align 3
.L349:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	jmp	.L339
	.p2align 4,,10
	.p2align 3
.L350:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
	jmp	.L339
	.cfi_endproc
.LFE35:
	.size	emit_c_string, .-emit_c_string
	.section	.rodata.str1.1
.LC33:
	.string	"preinc"
.LC34:
	.string	"predec"
.LC35:
	.string	"postinc"
.LC36:
	.string	"postdec"
.LC37:
	.string	"WAND"
.LC38:
	.string	"WOR"
.LC39:
	.string	"WADD"
.LC40:
	.string	"WSUB"
.LC41:
	.string	"WMUL"
.LC42:
	.string	"WSHR"
.LC43:
	.string	"WSHL"
.LC44:
	.string	"WMOD"
.LC45:
	.string	"WDIV"
.LC46:
	.string	"add_assign"
.LC47:
	.string	"or_assign"
.LC48:
	.string	"and_assign"
.LC49:
	.string	"rsh_assign"
.LC50:
	.string	"lsh_assign"
.LC51:
	.string	"mod_assign"
.LC52:
	.string	"div_assign"
.LC53:
	.string	"mul_assign"
.LC54:
	.string	"sub_assign"
.LC55:
	.string	"WVAL((word)%ld)"
	.section	.rodata.str1.8
	.align 8
.LC56:
	.string	"B_PTR_N(__b_str%d, sizeof(__b_str%d))"
	.section	.rodata.str1.1
.LC57:
	.string	"__b_label_value_%d"
.LC58:
	.string	"B_FUNCTION("
.LC59:
	.string	"((word (*)())B_FUNCTION_CPTR("
.LC60:
	.string	"))("
.LC61:
	.string	", "
.LC62:
	.string	"callf"
.LC63:
	.string	"b_callf_dispatch(%zu"
.LC64:
	.string	"malloc"
.LC65:
	.string	"printf"
.LC66:
	.string	"calloc"
.LC67:
	.string	"realloc"
.LC68:
	.string	"B_PTR("
.LC69:
	.string	"fprintf"
.LC70:
	.string	"dprintf"
.LC71:
	.string	"sprintf"
.LC72:
	.string	"snprintf"
.LC73:
	.string	"-+ #0"
.LC74:
	.string	"exit"
.LC75:
	.string	"strlen"
.LC76:
	.string	"atoi"
.LC77:
	.string	"memmove"
.LC78:
	.string	"tcgetattr"
.LC79:
	.string	"tcsetattr"
.LC80:
	.string	"ioctl"
.LC81:
	.string	"memset"
.LC82:
	.string	"memcpy"
.LC83:
	.string	"__b_cstr("
.LC84:
	.string	"B_CPTR("
	.section	.rodata.str1.8
	.align 8
.LC85:
	.string	"(size_t)(sizeof(word) * (uword)("
	.section	.rodata.str1.1
.LC86:
	.string	"))"
.LC87:
	.string	"B_INDEX("
.LC88:
	.string	"B_DEREF("
.LC89:
	.string	"B_ADDR("
.LC90:
	.string	"b_"
.LC91:
	.string	"(&("
.LC92:
	.string	"WNEG("
.LC93:
	.string	"({ word __b_left_%u = "
.LC94:
	.string	"; word __b_right_%u = "
	.section	.rodata.str1.8
	.align 8
.LC95:
	.string	"; (word)%s(__b_left_%u, __b_right_%u); })"
	.section	.rodata.str1.1
.LC96:
	.string	"%s("
.LC97:
	.string	" %s "
.LC98:
	.string	" = ("
.LC99:
	.string	"), "
.LC100:
	.string	" ? "
.LC101:
	.string	" : "
	.text
	.p2align 4
	.globl	emit_expr
	.type	emit_expr, @function
emit_expr:
.LFB44:
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
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	cmpl	$10, (%rsi)
	movq	%rdi, (%rsp)
	ja	.L352
	movl	(%rsi), %eax
	movq	%rdx, %r14
	leaq	.L355(%rip), %rdx
	movq	%rsi, %r15
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L355:
	.long	.L365-.L355
	.long	.L364-.L355
	.long	.L363-.L355
	.long	.L362-.L355
	.long	.L361-.L355
	.long	.L360-.L355
	.long	.L359-.L355
	.long	.L358-.L355
	.long	.L357-.L355
	.long	.L356-.L355
	.long	.L354-.L355
	.text
	.p2align 4,,10
	.p2align 3
.L356:
	movq	(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	32(%r15), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC100(%rip), %rdi
	call	fwrite@PLT
	movq	40(%r15), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$3, %edx
	leaq	.LC101(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
.L733:
	movq	%r14, %rdx
.L734:
	movq	%rbx, %rdi
	call	emit_expr
.L731:
	movq	%rbx, %rsi
.L732:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	$41, %edi
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
	jmp	fputc@PLT
	.p2align 4,,10
	.p2align 3
.L354:
	.cfi_restore_state
	movq	(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
.L735:
	movq	32(%r15), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC61(%rip), %rdi
.L736:
	call	fwrite@PLT
	movq	40(%r15), %rsi
	jmp	.L733
	.p2align 4,,10
	.p2align 3
.L365:
	movq	32(%rsi), %rdx
	movq	(%rsp), %rdi
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC55(%rip), %rsi
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
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L364:
	.cfi_restore_state
	movq	32(%r15), %rdi
	movq	24(%rsi), %rsi
	call	get_string_id
	movq	(%rsp), %rdi
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC56(%rip), %rsi
	popq	%rbx
	.cfi_def_cfa_offset 48
	movl	%eax, %edx
	popq	%rbp
	.cfi_def_cfa_offset 40
	movl	%eax, %ecx
	popq	%r12
	.cfi_def_cfa_offset 32
	xorl	%eax, %eax
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L363:
	.cfi_restore_state
	movq	8+function_labels(%rip), %r13
	movq	32(%rsi), %r12
	testq	%r13, %r13
	je	.L366
	movq	function_labels(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L371
	.p2align 4,,10
	.p2align 3
.L367:
	addq	$1, %rbp
	cmpq	%r13, %rbp
	je	.L702
.L371:
	movq	(%r14,%rbp,8), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L367
	movl	%ebp, %edx
	addl	$1, %edx
	je	.L702
	movq	(%rsp), %rdi
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC57(%rip), %rsi
	xorl	%eax, %eax
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
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L362:
	.cfi_restore_state
	movl	16(%rsi), %r9d
	testl	%r9d, %r9d
	jne	.L739
	movq	32(%rsi), %rax
	cmpl	$2, (%rax)
	movq	32(%rax), %rbp
	je	.L740
	movl	$0, 44(%rsp)
	xorl	%r13d, %r13d
	movb	$0, 43(%rsp)
	movq	$0, 8(%rsp)
.L378:
	movq	(%rsp), %rdi
	movq	%rbp, %rsi
	call	emit_function_name
.L392:
	movq	(%rsp), %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	48(%r15), %rdx
	movq	8(%rsp), %rcx
	cmpq	%rdx, %rcx
	jnb	.L393
	cmpb	$0, 43(%rsp)
	je	.L393
	movq	40(%r15), %rax
	movq	(%rax,%rcx,8), %rax
	testq	%rax, %rax
	je	.L420
	cmpl	$1, (%rax)
	je	.L741
.L420:
	movq	$0, 32(%rsp)
.L396:
	movq	%r14, 24(%rsp)
	xorl	%r12d, %r12d
	movq	(%rsp), %r14
	movq	%rdx, 16(%rsp)
	testq	%r13, %r13
	je	.L534
.L746:
	movq	8(%rsp), %rax
	movl	current_byteptr(%rip), %ebp
	cmpq	%rax, %r12
	sete	%al
	testb	%al, 43(%rsp)
	jne	.L423
	movq	32(%rsp), %rax
	testq	%rax, %rax
	je	.L424
	movl	(%rax,%r12,4), %ebx
	testl	%ebx, %ebx
	jne	.L423
.L424:
	leaq	.LC75(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L427
	testq	%r12, %r12
	je	.L742
.L428:
	leaq	.LC77(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L430
	cmpq	$1, %r12
	jbe	.L743
.L432:
	leaq	.LC79(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L435
	cmpq	$2, %r12
	je	.L436
.L431:
	leaq	.LC81(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testq	%r12, %r12
	sete	48(%rsp)
	testl	%eax, %eax
	movzbl	48(%rsp), %ecx
	sete	%al
	andb	%cl, %al
	movl	%eax, %edx
	jne	.L744
	leaq	.LC82(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L443
	cmpq	$1, %r12
	jbe	.L444
.L442:
	leaq	.LC67(%rip), %rax
	movq	%r13, %rdi
	movq	%rax, %rsi
	movq	%rax, 56(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L445
	movb	$0, 48(%rsp)
.L446:
	leaq	.LC66(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	andb	48(%rsp), %al
	xorl	$1, %eax
	movzbl	%al, %eax
	andl	%eax, %ebx
	testl	%ebp, %ebp
	jne	.L445
	leaq	.LC64(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L552
	cmpb	$0, 48(%rsp)
	je	.L552
.L451:
	testl	%ebx, %ebx
	jne	.L450
.L452:
	movq	%r14, %rcx
	movl	$32, %edx
	movl	$1, %esi
	leaq	.LC85(%rip), %rdi
	call	fwrite@PLT
	movq	40(%r15), %rax
	movq	24(%rsp), %rdx
	movq	%r14, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC86(%rip), %rdi
	call	fwrite@PLT
.L497:
	testl	%ebx, %ebx
	jne	.L745
.L455:
	addq	$1, %r12
	cmpq	%r12, 16(%rsp)
	je	.L456
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC61(%rip), %rdi
	call	fwrite@PLT
	testq	%r13, %r13
	jne	.L746
.L534:
	xorl	%ebx, %ebx
.L422:
	movq	40(%r15), %rax
	movq	24(%rsp), %rdx
	movq	%r14, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
	jmp	.L497
	.p2align 4,,10
	.p2align 3
.L361:
	movq	(%rsp), %rbx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC87(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	jmp	.L735
	.p2align 4,,10
	.p2align 3
.L360:
	movl	32(%rsi), %ebp
	cmpl	$32, %ebp
	je	.L747
	cmpl	$53, %ebp
	je	.L748
	leal	-36(%rbp), %eax
	cmpl	$1, %eax
	jbe	.L749
	movq	(%rsp), %rbx
	cmpl	$31, %ebp
	jne	.L466
	movl	current_word_bits(%rip), %r9d
	testl	%r9d, %r9d
	jne	.L750
.L466:
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movl	%ebp, %edi
	call	tk_name@PLT
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	40(%r15), %rsi
	movq	%r14, %rdx
	jmp	.L737
	.p2align 4,,10
	.p2align 3
.L359:
	movq	40(%rsi), %rbp
	movl	32(%rsi), %r12d
	testq	%rbp, %rbp
	je	.L467
	movl	0(%rbp), %eax
	cmpl	$4, %eax
	je	.L468
	cmpl	$5, %eax
	jne	.L467
	cmpl	$32, 32(%rbp)
	je	.L468
	.p2align 4
	.p2align 3
.L467:
	movl	current_word_bits(%rip), %r8d
	testl	%r8d, %r8d
	je	.L469
.L468:
	movq	(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC90(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	cmpl	$36, %r12d
	movq	%rbx, %rcx
	movl	$7, %edx
	leaq	.LC35(%rip), %rax
	leaq	.LC36(%rip), %rdi
	movl	$1, %esi
	cmove	%rax, %rdi
	call	fwrite@PLT
	movl	$3, %edx
	movq	%rbx, %rcx
	movl	$1, %esi
	leaq	.LC91(%rip), %rdi
	call	fwrite@PLT
	movq	%r14, %rdx
	movq	%rbp, %rsi
.L737:
	movq	%rbx, %rdi
	call	emit_expr
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$2, %edx
	popq	%rbx
	.cfi_def_cfa_offset 48
	movl	$1, %esi
	leaq	.LC86(%rip), %rdi
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
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L358:
	.cfi_restore_state
	movl	32(%rsi), %ebp
	leal	-53(%rbp), %eax
	cmpl	$1, %eax
	jbe	.L751
	movl	current_word_bits(%rip), %edi
	testl	%edi, %edi
	je	.L473
	leal	-28(%rbp), %eax
	cmpl	$6, %eax
	ja	.L473
	leaq	.L475(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L475:
	.long	.L542-.L475
	.long	.L480-.L475
	.long	.L479-.L475
	.long	.L478-.L475
	.long	.L477-.L475
	.long	.L476-.L475
	.long	.L474-.L475
	.text
	.p2align 4,,10
	.p2align 3
.L357:
	movl	32(%rsi), %ebp
	movq	40(%rsi), %r12
	movq	48(%rsi), %r13
	leal	-47(%rbp), %eax
	cmpl	$5, %eax
	jbe	.L752
	cmpl	$21, %ebp
	je	.L483
	testq	%r12, %r12
	je	.L484
	movl	(%r12), %eax
	cmpl	$4, %eax
	je	.L485
	cmpl	$5, %eax
	je	.L753
.L484:
	movl	current_word_bits(%rip), %esi
	testl	%esi, %esi
	je	.L483
.L485:
	leal	-38(%rbp), %eax
	cmpl	$8, %eax
	ja	.L483
	leaq	.L488(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L488:
	.long	.L496-.L488
	.long	.L495-.L488
	.long	.L494-.L488
	.long	.L493-.L488
	.long	.L492-.L488
	.long	.L491-.L488
	.long	.L490-.L488
	.long	.L543-.L488
	.long	.L487-.L488
	.text
.L366:
	cmpl	$0, 12(%rsi)
	jne	.L369
	testq	%r12, %r12
	jne	.L370
.L352:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
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
.L702:
	.cfi_restore_state
	movl	12(%r15), %edx
	testl	%edx, %edx
	je	.L370
.L369:
	movq	(%rsp), %rbx
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC58(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	32(%r15), %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	jmp	.L731
	.p2align 4,,10
	.p2align 3
.L370:
	movq	%r12, %rdi
	call	get_mangled_name
	movq	(%rsp), %rsi
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	movq	%rax, %rdi
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
	jmp	fputs@PLT
	.p2align 4,,10
	.p2align 3
.L473:
	.cfi_restore_state
	movq	(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	40(%r15), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	%ebp, %edi
	call	tk_name@PLT
	leaq	.LC97(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r15), %rsi
	jmp	.L733
	.p2align 4,,10
	.p2align 3
.L740:
	leaq	.LC62(%rip), %rsi
	movq	%rbp, %rdi
	leaq	8+names.0(%rip), %r12
	call	strcmp@PLT
	leaq	.LC26(%rip), %rsi
	testl	%eax, %eax
	jne	.L383
	jmp	.L754
	.p2align 4,,10
	.p2align 3
.L756:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L755
.L383:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L756
	leaq	.LC64(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L549
	leaq	.LC66(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L549
	leaq	.LC65(%rip), %rsi
	movq	%rbp, %rdi
	movl	$1, %r12d
	call	strcmp@PLT
	orl	$1, %eax
	movl	%eax, 44(%rsp)
.L388:
	movq	%rbp, %rdi
	leaq	.LC67(%rip), %rsi
	call	strcmp@PLT
	movl	44(%rsp), %edi
	movl	%eax, %ebx
	testl	%edi, %edi
	jne	.L389
	movb	$1, 43(%rsp)
	movq	%rbp, %r13
	movq	$0, 8(%rsp)
	testl	%eax, %eax
	jne	.L378
.L385:
	movq	(%rsp), %rcx
	movl	$6, %edx
	movl	$1, %esi
	movq	%rbp, %r13
	leaq	.LC68(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r15), %rax
	movb	$1, 43(%rsp)
	movq	$0, 8(%rsp)
	movl	$1, 44(%rsp)
	movq	32(%rax), %rbp
	jmp	.L378
	.p2align 4,,10
	.p2align 3
.L469:
	movq	(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	%rbp, %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edi
	call	tk_name@PLT
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	jmp	.L731
	.p2align 4,,10
	.p2align 3
.L749:
	movq	40(%rsi), %r12
	testq	%r12, %r12
	je	.L462
	movl	(%r12), %eax
	cmpl	$4, %eax
	je	.L463
	cmpl	$5, %eax
	je	.L757
.L462:
	movl	current_word_bits(%rip), %r10d
	testl	%r10d, %r10d
	je	.L464
.L463:
	movq	(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC90(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	cmpl	$36, %ebp
	movq	%rbx, %rcx
	movl	$6, %edx
	leaq	.LC33(%rip), %rax
	leaq	.LC34(%rip), %rdi
	movl	$1, %esi
	cmove	%rax, %rdi
	call	fwrite@PLT
	movl	$3, %edx
	movq	%rbx, %rcx
	movl	$1, %esi
	leaq	.LC91(%rip), %rdi
	call	fwrite@PLT
	movq	%r14, %rdx
	movq	%r12, %rsi
	jmp	.L737
.L480:
	leaq	.LC42(%rip), %rdx
	.p2align 4
	.p2align 3
.L481:
	movq	(%rsp), %rbx
	leaq	.LC96(%rip), %rsi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	call	fprintf@PLT
	movq	40(%r15), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC61(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
	jmp	.L733
.L542:
	leaq	.LC43(%rip), %rdx
	jmp	.L481
.L474:
	leaq	.LC44(%rip), %rdx
	jmp	.L481
.L479:
	leaq	.LC39(%rip), %rdx
	jmp	.L481
.L476:
	leaq	.LC45(%rip), %rdx
	jmp	.L481
.L477:
	leaq	.LC41(%rip), %rdx
	jmp	.L481
.L478:
	leaq	.LC40(%rip), %rdx
	jmp	.L481
.L543:
	leaq	.LC48(%rip), %rbp
	.p2align 4
	.p2align 3
.L489:
	movq	(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC90(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC91(%rip), %rdi
	call	fwrite@PLT
	movq	%r14, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	$3, %edx
	movq	%rbx, %rcx
	movl	$1, %esi
	leaq	.LC99(%rip), %rdi
	call	fwrite@PLT
	movq	%r14, %rdx
	movq	%r13, %rsi
	jmp	.L734
.L487:
	leaq	.LC47(%rip), %rbp
	jmp	.L489
.L496:
	leaq	.LC46(%rip), %rbp
	jmp	.L489
.L494:
	leaq	.LC53(%rip), %rbp
	jmp	.L489
.L495:
	leaq	.LC54(%rip), %rbp
	jmp	.L489
.L490:
	leaq	.LC49(%rip), %rbp
	jmp	.L489
.L491:
	leaq	.LC50(%rip), %rbp
	jmp	.L489
.L492:
	leaq	.LC51(%rip), %rbp
	jmp	.L489
.L493:
	leaq	.LC52(%rip), %rbp
	jmp	.L489
	.p2align 4,,10
	.p2align 3
.L423:
	testl	%ebp, %ebp
	je	.L758
.L426:
	movq	%r14, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC83(%rip), %rdi
	call	fwrite@PLT
.L454:
	movl	$1, %ebx
	jmp	.L422
	.p2align 4,,10
	.p2align 3
.L745:
	movq	%r14, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L455
	.p2align 4,,10
	.p2align 3
.L758:
	testq	%r12, %r12
	sete	%bl
.L429:
	leaq	.LC64(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L551
	testb	%bl, %bl
	jne	.L449
.L551:
	leaq	.LC67(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L759
	cmpq	$1, %r12
	jne	.L426
.L449:
	movq	%r14, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC83(%rip), %rdi
	call	fwrite@PLT
.L453:
	movl	$1, %ebx
	jmp	.L452
	.p2align 4,,10
	.p2align 3
.L456:
	movq	(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	movl	44(%rsp), %r11d
	testl	%r11d, %r11d
	jne	.L419
.L458:
	movq	32(%rsp), %rax
	testq	%rax, %rax
	je	.L352
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rax, %rdi
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
	jmp	free@PLT
	.p2align 4,,10
	.p2align 3
.L483:
	.cfi_restore_state
	movq	(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	%r14, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%ebp, %edi
	call	assignment_op_to_c
	leaq	.LC97(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%r14, %rdx
	movq	%r13, %rsi
	jmp	.L734
	.p2align 4,,10
	.p2align 3
.L393:
	testq	%r13, %r13
	je	.L417
	leaq	.LC74(%rip), %rsi
	movq	%r13, %rdi
	movq	%rdx, 16(%rsp)
	call	strcmp@PLT
	movq	16(%rsp), %rdx
	testl	%eax, %eax
	jne	.L417
	testq	%rdx, %rdx
	jne	.L420
	movq	(%rsp), %rbx
	movl	$48, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	movl	44(%rsp), %r13d
	testl	%r13d, %r13d
	je	.L352
.L421:
	xorl	%r12d, %r12d
	movq	%r12, 32(%rsp)
	.p2align 4
	.p2align 3
.L419:
	movq	(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L458
	.p2align 4,,10
	.p2align 3
.L759:
	leaq	.LC66(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L426
	cmpq	$1, %r12
	je	.L449
	jmp	.L426
	.p2align 4,,10
	.p2align 3
.L427:
	leaq	.LC76(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%bl
	testq	%r12, %r12
	sete	%al
	andb	%al, %bl
	je	.L428
	testl	%ebp, %ebp
	je	.L429
	jmp	.L426
	.p2align 4,,10
	.p2align 3
.L752:
	movq	(%rsp), %rbx
	leaq	CSWTCH.160(%rip), %rdx
	movl	$40, %edi
	movl	(%rdx,%rax,4), %ebp
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	%r14, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC98(%rip), %rdi
	call	fwrite@PLT
	movq	%r14, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%ebp, %edi
	call	tk_name@PLT
	leaq	.LC97(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%r14, %rdx
	movq	%r13, %rsi
	jmp	.L737
	.p2align 4,,10
	.p2align 3
.L739:
	movq	(%rsp), %rbx
	movl	$29, %edx
	movl	$1, %esi
	xorl	%ebp, %ebp
	leaq	.LC59(%rip), %rdi
	leaq	.LC61(%rip), %r12
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	32(%r15), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC60(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 48(%r15)
	je	.L376
.L375:
	movq	40(%r15), %rax
	movq	%r14, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	emit_expr
	cmpq	48(%r15), %rbp
	jnb	.L376
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	jmp	.L375
.L380:
	movq	(%rsp), %rbx
	leaq	-1(%r13), %rdx
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	leaq	.LC63(%rip), %rsi
	leaq	.LC61(%rip), %r12
	movq	%rbx, %rdi
	call	fprintf@PLT
	.p2align 4
	.p2align 3
.L381:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movq	40(%r15), %rax
	movq	%r14, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	emit_expr
	cmpq	%rbp, %r13
	jne	.L381
.L376:
	movq	(%rsp), %rsi
	jmp	.L732
	.p2align 4,,10
	.p2align 3
.L430:
	leaq	.LC78(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L432
	cmpq	$1, %r12
	jne	.L432
	leaq	.LC82(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L725
.L444:
	testl	%ebp, %ebp
	jne	.L441
	movq	%r12, %rax
	xorq	$1, %rax
	movl	%eax, %edx
	andl	$1, %edx
.L440:
	leaq	.LC64(%rip), %rsi
	movq	%r13, %rdi
	movb	%dl, 48(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L553
	movzbl	48(%rsp), %edx
	testb	%dl, %dl
	jne	.L450
.L553:
	leaq	.LC67(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L727
	leaq	.LC66(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L441
.L727:
	cmpq	$1, %r12
	je	.L450
	.p2align 4
	.p2align 3
.L441:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC84(%rip), %rdi
	call	fwrite@PLT
	jmp	.L454
	.p2align 4,,10
	.p2align 3
.L417:
	testq	%rdx, %rdx
	jne	.L420
	movq	(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	movl	44(%rsp), %ebp
	testl	%ebp, %ebp
	je	.L352
	jmp	.L421
.L725:
	movb	$0, 48(%rsp)
	movl	$1, %ebx
.L443:
	leaq	.LC67(%rip), %rax
	movq	%r13, %rdi
	movq	%rax, %rsi
	movq	%rax, 56(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L446
	movzbl	48(%rsp), %eax
	orl	%eax, %ebx
	testl	%ebp, %ebp
	jne	.L445
	leaq	.LC64(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L504
	cmpb	$0, 48(%rsp)
	jne	.L451
.L504:
	cmpq	$1, %r12
	je	.L451
	.p2align 4
	.p2align 3
.L445:
	testl	%ebx, %ebx
	jne	.L441
	jmp	.L422
.L755:
	leaq	.LC64(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	leaq	.LC65(%rip), %rsi
	movq	%rbp, %rdi
	movl	%eax, %r12d
	call	strcmp@PLT
	movl	%eax, 44(%rsp)
	testl	%r12d, %r12d
	jne	.L384
	testl	%eax, %eax
	je	.L385
.L730:
	movl	$0, 44(%rsp)
.L386:
	leaq	.LC69(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L547
	leaq	.LC70(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L547
	leaq	.LC71(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L547
	leaq	.LC72(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L548
	xorl	%eax, %eax
	movb	$0, 43(%rsp)
	movq	%rax, 8(%rsp)
.L510:
	movq	(%rsp), %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC68(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r15), %rax
	movl	44(%rsp), %ecx
	movq	32(%rax), %rdx
	testl	%ecx, %ecx
	je	.L529
	cmpl	$2, (%rax)
	je	.L509
	movq	%rbp, %r13
	movq	%rdx, %rbp
	jmp	.L378
	.p2align 4,,10
	.p2align 3
.L751:
	movl	expression_id(%rip), %eax
	movq	(%rsp), %rbx
	leaq	.LC93(%rip), %rsi
	leal	1(%rax), %r12d
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movl	%r12d, %edx
	movl	%r12d, expression_id(%rip)
	call	fprintf@PLT
	movq	40(%r15), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC94(%rip), %rsi
	call	fprintf@PLT
	movq	48(%r15), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	cmpl	$53, %ebp
	movl	%r12d, %r8d
	movl	%r12d, %ecx
	leaq	.LC37(%rip), %rax
	leaq	.LC38(%rip), %rdx
	movq	%rbx, %rdi
	cmove	%rax, %rdx
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC95(%rip), %rsi
	xorl	%eax, %eax
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
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L435:
	.cfi_restore_state
	leaq	.LC80(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	cmpq	$2, %r12
	jne	.L550
	testl	%eax, %eax
	je	.L436
.L550:
	xorl	%ebx, %ebx
	jmp	.L431
.L436:
	leaq	.LC82(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L725
	movl	$1, %ebx
	jmp	.L442
.L753:
	cmpl	$32, 32(%r12)
	jne	.L484
	jmp	.L485
.L747:
	movq	(%rsp), %rbx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC88(%rip), %rdi
	movq	%rbx, %rcx
	jmp	.L736
.L742:
	testl	%ebp, %ebp
	jne	.L426
	movl	$1, %ebx
	jmp	.L429
.L748:
	movq	(%rsp), %rbx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC89(%rip), %rdi
	movq	%rbx, %rcx
	jmp	.L736
.L750:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC92(%rip), %rdi
	jmp	.L736
.L389:
	leaq	.LC69(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	movb	$1, 43(%rsp)
	movq	$1, 8(%rsp)
	testl	%eax, %eax
	jne	.L760
.L390:
	testl	%ebx, %ebx
	je	.L761
	testl	%r12d, %r12d
	je	.L762
	movl	$0, 44(%rsp)
	movq	%rbp, %rdx
.L509:
	movq	(%rsp), %rdi
	leaq	.LC18(%rip), %rsi
	xorl	%eax, %eax
	movq	%rbp, %r13
	call	fprintf@PLT
	jmp	.L392
.L754:
	movq	48(%r15), %r13
	testq	%r13, %r13
	jne	.L380
	movq	(%rsp), %rdi
	xorl	%edx, %edx
	leaq	.LC63(%rip), %rsi
	call	fprintf@PLT
	jmp	.L376
.L384:
	leaq	.LC66(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L523
	movl	44(%rsp), %r8d
	testl	%r8d, %r8d
	je	.L385
	jmp	.L730
.L450:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC84(%rip), %rdi
	call	fwrite@PLT
	jmp	.L453
.L744:
	testl	%ebp, %ebp
	je	.L440
	jmp	.L441
.L549:
	movl	$1, 44(%rsp)
	jmp	.L386
.L547:
	movb	$1, 43(%rsp)
	movq	$1, 8(%rsp)
	jmp	.L510
.L743:
	movl	$1, %ebx
	jmp	.L431
.L741:
	movq	%rdx, %rdi
	movl	$4, %esi
	movq	%rdx, 16(%rsp)
	movq	32(%rax), %rbp
	call	calloc@PLT
	movq	16(%rsp), %rdx
	testq	%rax, %rax
	movq	%rax, 32(%rsp)
	je	.L420
	movq	8(%rsp), %rax
	xorl	%r12d, %r12d
	leaq	1(%rax), %rcx
	movzbl	0(%rbp), %eax
	testb	%al, %al
	je	.L396
	movq	%r13, 16(%rsp)
	movq	%rcx, %r13
	movq	%r14, 24(%rsp)
	movq	%rbp, %r14
	movq	%rdx, %rbp
	.p2align 4
	.p2align 3
.L395:
	cmpb	$37, %al
	jne	.L721
	addq	$1, %r12
	movzbl	(%r14,%r12), %ebx
	cmpb	$37, %bl
	je	.L721
	testb	%bl, %bl
	jne	.L398
	jmp	.L718
	.p2align 4,,10
	.p2align 3
.L401:
	addq	$1, %r12
	movzbl	(%r14,%r12), %ebx
	testb	%bl, %bl
	je	.L400
.L398:
	movsbl	%bl, %esi
	leaq	.LC73(%rip), %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L401
	cmpb	$42, %bl
	jne	.L400
	cmpq	%rbp, %r13
	adcq	$0, %r13
	addq	$1, %r12
	movzbl	(%r14,%r12), %edi
.L405:
	cmpb	$46, %dil
	je	.L763
.L407:
	cmpb	$104, %dil
	je	.L764
	cmpb	$108, %dil
	je	.L765
	testb	%dil, %dil
	je	.L718
	leaq	1(%r12), %rax
	cmpb	$115, %dil
	jne	.L413
	cmpq	%rbp, %r13
	jnb	.L413
	movq	32(%rsp), %rcx
	movl	$1, (%rcx,%r13,4)
	.p2align 4
	.p2align 3
.L413:
	addq	$1, %r13
.L397:
	movq	%rax, %r12
	movzbl	(%r14,%rax), %eax
	testb	%al, %al
	jne	.L395
.L718:
	movq	16(%rsp), %r13
	movq	24(%rsp), %r14
	movq	%rbp, %rdx
	jmp	.L396
	.p2align 4,,10
	.p2align 3
.L721:
	leaq	1(%r12), %rax
	jmp	.L397
.L400:
	movzbl	(%r14,%r12), %ebx
	testb	%bl, %bl
	je	.L718
	call	__ctype_b_loc@PLT
	movq	(%rax), %rax
	jmp	.L403
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L406:
	addq	$1, %r12
	movzbl	(%r14,%r12), %ebx
	testb	%bl, %bl
	je	.L718
.L403:
	testb	$8, 1(%rax,%rbx,2)
	jne	.L406
	movzbl	(%r14,%r12), %edi
	jmp	.L405
.L763:
	movzbl	1(%r14,%r12), %ebx
	leaq	1(%r12), %rsi
	movq	%rsi, 48(%rsp)
	cmpb	$42, %bl
	jne	.L766
	cmpq	%rbp, %r13
	adcq	$0, %r13
	addq	$2, %r12
	movzbl	(%r14,%r12), %edi
	jmp	.L407
.L764:
	cmpb	$104, 1(%r14,%r12)
	leaq	1(%r12), %rax
	jne	.L413
.L533:
	leaq	2(%r12), %rax
	jmp	.L413
.L765:
	cmpb	$108, 1(%r14,%r12)
	leaq	1(%r12), %rax
	jne	.L413
	jmp	.L533
.L464:
	movl	%ebp, %edi
	call	tk_name@PLT
	movq	(%rsp), %rbx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	call	fputs@PLT
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	%r14, %rdx
	movq	%r12, %rsi
	jmp	.L734
.L757:
	cmpl	$32, 32(%r12)
	jne	.L462
	jmp	.L463
.L523:
	xorl	%r12d, %r12d
	jmp	.L388
.L766:
	testb	%bl, %bl
	je	.L718
	call	__ctype_b_loc@PLT
	movq	48(%rsp), %rsi
	movq	(%rax), %rax
	jmp	.L409
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L411:
	addq	$1, %rsi
	movzbl	(%r14,%rsi), %ebx
	testb	%bl, %bl
	je	.L718
.L409:
	testb	$8, 1(%rax,%rbx,2)
	jne	.L411
	movzbl	(%r14,%rsi), %edi
	movq	%rsi, %r12
	jmp	.L407
.L760:
	leaq	.LC70(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L390
	leaq	.LC71(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L390
	leaq	.LC72(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	movq	$2, 8(%rsp)
	testl	%eax, %eax
	je	.L390
	xorl	%esi, %esi
	movb	$0, 43(%rsp)
	movq	%rsi, 8(%rsp)
	jmp	.L390
.L548:
	movb	$1, 43(%rsp)
	movq	$2, 8(%rsp)
	jmp	.L510
.L529:
	movq	%rbp, %r13
	movl	$1, 44(%rsp)
	movq	%rdx, %rbp
	jmp	.L378
.L552:
	movq	56(%rsp), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L504
	leaq	.LC66(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	cmpq	$1, %r12
	jne	.L445
	testl	%eax, %eax
	jne	.L445
	jmp	.L451
.L762:
	xorl	%ecx, %ecx
	movq	%rbp, %r13
	movl	%ecx, 44(%rsp)
	jmp	.L378
.L761:
	movl	%r12d, 44(%rsp)
	jmp	.L510
	.cfi_endproc
.LFE44:
	.size	emit_expr, .-emit_expr
	.p2align 4
	.globl	emit_ival_expr
	.type	emit_ival_expr, @function
emit_ival_expr:
.LFB45:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rsi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	cmpl	$2, (%rsi)
	je	.L774
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	emit_expr
	.p2align 4,,10
	.p2align 3
.L774:
	.cfi_restore_state
	movq	%rdi, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC89(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L769
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L769:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbp, %rsi
	movl	$41, %edi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	fputc@PLT
	.cfi_endproc
.LFE45:
	.size	emit_ival_expr, .-emit_ival_expr
	.p2align 4
	.globl	init_list_length
	.type	init_list_length, @function
init_list_length:
.LFB46:
	.cfi_startproc
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L775
	cmpl	$1, (%rdi)
	je	.L779
.L775:
	ret
	.p2align 4,,10
	.p2align 3
.L779:
	movq	24(%rdi), %rax
	ret
	.cfi_endproc
.LFE46:
	.size	init_list_length, .-init_list_length
	.p2align 4
	.globl	try_eval_const_expr
	.type	try_eval_const_expr, @function
try_eval_const_expr:
.LFB47:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L812
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	movl	(%rdi), %eax
	cmpl	$7, %eax
	je	.L782
	ja	.L783
	testl	%eax, %eax
	je	.L784
	cmpl	$5, %eax
	jne	.L792
	movq	40(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L780
	movl	32(%rbx), %eax
	cmpl	$31, %eax
	je	.L788
	cmpl	$35, %eax
	je	.L789
	.p2align 4
	.p2align 3
.L792:
	xorl	%eax, %eax
.L780:
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
.L783:
	.cfi_restore_state
	cmpl	$10, %eax
	jne	.L792
	movq	32(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L780
	movq	40(%rbx), %rdi
	movq	%rbp, %rsi
	call	try_eval_const_expr
	jmp	.L780
	.p2align 4,,10
	.p2align 3
.L812:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L784:
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	movq	32(%rdi), %rax
	movq	%rax, (%rsi)
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movl	$1, %eax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L782:
	.cfi_restore_state
	movq	40(%rdi), %rdi
	movq	%rsp, %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L792
	movq	48(%rbx), %rdi
	leaq	8(%rsp), %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L792
	movl	32(%rbx), %eax
	subl	$22, %eax
	cmpl	$33, %eax
	ja	.L792
	leaq	.L795(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L795:
	.long	.L808-.L795
	.long	.L807-.L795
	.long	.L806-.L795
	.long	.L805-.L795
	.long	.L804-.L795
	.long	.L803-.L795
	.long	.L792-.L795
	.long	.L792-.L795
	.long	.L802-.L795
	.long	.L801-.L795
	.long	.L800-.L795
	.long	.L799-.L795
	.long	.L798-.L795
	.long	.L792-.L795
	.long	.L792-.L795
	.long	.L792-.L795
	.long	.L792-.L795
	.long	.L792-.L795
	.long	.L792-.L795
	.long	.L792-.L795
	.long	.L792-.L795
	.long	.L792-.L795
	.long	.L792-.L795
	.long	.L792-.L795
	.long	.L792-.L795
	.long	.L792-.L795
	.long	.L792-.L795
	.long	.L792-.L795
	.long	.L792-.L795
	.long	.L792-.L795
	.long	.L792-.L795
	.long	.L797-.L795
	.long	.L796-.L795
	.long	.L794-.L795
	.text
	.p2align 4,,10
	.p2align 3
.L789:
	xorl	%eax, %eax
	cmpq	$0, 8(%rsp)
	sete	%al
	movq	%rax, 0(%rbp)
.L810:
	movl	$1, %eax
	jmp	.L780
.L794:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L810
.L796:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L810
.L797:
	movq	(%rsp), %rax
	andq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L810
.L798:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L792
	movq	(%rsp), %rax
	cqto
	idivq	%rcx
	movq	%rdx, 0(%rbp)
	jmp	.L810
.L799:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L792
	movq	(%rsp), %rax
	cqto
	idivq	%rcx
	movq	%rax, 0(%rbp)
	jmp	.L810
.L800:
	movq	(%rsp), %rax
	imulq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L810
.L801:
	movq	(%rsp), %rax
	subq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L810
.L802:
	movq	8(%rsp), %rax
	addq	(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L810
.L803:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setge	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L810
.L804:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setg	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L810
.L805:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setle	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L810
.L806:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setl	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L810
.L807:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L810
.L808:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	sete	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L810
	.p2align 4,,10
	.p2align 3
.L788:
	movq	8(%rsp), %rax
	negq	%rax
	movq	%rax, 0(%rbp)
	jmp	.L810
	.cfi_endproc
.LFE47:
	.size	try_eval_const_expr, .-try_eval_const_expr
	.p2align 4
	.globl	nested_base_len
	.type	nested_base_len, @function
nested_base_len:
.LFB48:
	.cfi_startproc
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L834
	cmpl	$1, (%rdi)
	je	.L838
.L834:
	ret
	.p2align 4,,10
	.p2align 3
.L838:
	movq	24(%rdi), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmove	%rdx, %rax
	ret
	.cfi_endproc
.LFE48:
	.size	nested_base_len, .-nested_base_len
	.p2align 4
	.globl	edge_words_total
	.type	edge_words_total, @function
edge_words_total:
.LFB49:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L839
	cmpl	$1, (%rdi)
	je	.L844
.L839:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L844:
	movq	24(%rdi), %rsi
	movq	16(%rdi), %rdi
	jmp	edge_words_total.part.0.isra.0
	.cfi_endproc
.LFE49:
	.size	edge_words_total, .-edge_words_total
	.p2align 4
	.globl	edge_tail_words_top
	.type	edge_tail_words_top, @function
edge_tail_words_top:
.LFB50:
	.cfi_startproc
	xorl	%r9d, %r9d
	testq	%rdi, %rdi
	je	.L857
	cmpl	$1, (%rdi)
	jne	.L857
	movq	24(%rdi), %rcx
	movq	16(%rdi), %r8
	testq	%rcx, %rcx
	je	.L857
	xorl	%edx, %edx
	jmp	.L858
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L860:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L857
.L858:
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L860
	cmpl	$1, (%rax)
	jne	.L860
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
.L861:
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r9
.L847:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L864
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L847
	cmpl	$1, (%rax)
	jne	.L847
	jmp	.L861
	.p2align 4,,10
	.p2align 3
.L857:
	.cfi_def_cfa_offset 8
	movq	%r9, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L864:
	.cfi_def_cfa_offset 16
	movq	%r9, %rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE50:
	.size	edge_tail_words_top, .-edge_tail_words_top
	.section	.rodata.str1.1
.LC102:
	.string	"%s[%zu] = "
.LC103:
	.string	";\n"
.LC104:
	.string	"%s[%zu] = B_ADDR(%s[%zu]);\n"
	.text
	.p2align 4
	.globl	emit_edge_list_init
	.type	emit_edge_list_init, @function
emit_edge_list_init:
.LFB51:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%r8, %r15
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	testq	%rcx, %rcx
	je	.L866
	cmpl	$1, (%rcx)
	movq	%rcx, %r11
	jne	.L866
	cmpq	$0, 24(%rcx)
	je	.L866
	movq	%rsi, (%rsp)
	movq	%rdi, %rbx
	movl	%r9d, %ebp
	xorl	%r13d, %r13d
	movq	%r8, 8(%rsp)
	movq	%rdx, %r15
.L876:
	movq	16(%r11), %rax
	movq	(%rax,%r13,8), %r14
	testq	%r14, %r14
	je	.L870
	movl	(%r14), %eax
	testl	%eax, %eax
	je	.L894
	cmpl	$1, %eax
	je	.L895
.L870:
	addq	$1, %r13
	addq	$1, %r15
	cmpq	24(%r11), %r13
	jb	.L876
	movq	8(%rsp), %r15
.L866:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r15, %rax
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
.L894:
	.cfi_restore_state
	xorl	%r12d, %r12d
	testl	%ebp, %ebp
	jle	.L871
	movq	%r11, 16(%rsp)
	.p2align 4
	.p2align 3
.L869:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC28(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L869
	movq	16(%rsp), %r11
.L871:
	movq	(%rsp), %rdx
	movq	%r15, %rcx
	leaq	.LC102(%rip), %rsi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	movq	%r11, 16(%rsp)
	call	fprintf@PLT
	movq	16(%r14), %rsi
	movq	96(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_ival_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC103(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rsp), %r11
	jmp	.L870
	.p2align 4,,10
	.p2align 3
.L895:
	movq	24(%r14), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmovne	%rax, %rdx
	xorl	%r12d, %r12d
	movq	%rdx, 16(%rsp)
	testl	%ebp, %ebp
	jle	.L875
	movq	%r11, 24(%rsp)
	.p2align 4
	.p2align 3
.L872:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC28(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L872
	movq	24(%rsp), %r11
.L875:
	movq	8(%rsp), %r12
	movq	(%rsp), %r8
	movq	%r15, %rcx
	movq	%rbx, %rdi
	leaq	.LC104(%rip), %rsi
	xorl	%eax, %eax
	movq	%r11, 24(%rsp)
	movq	%r8, %rdx
	movq	%r12, %r9
	call	fprintf@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 104
	movq	%r12, %rdx
	movl	%ebp, %r9d
	pushq	104(%rsp)
	.cfi_def_cfa_offset 112
	movq	32(%rsp), %rcx
	movq	%rbx, %rdi
	movq	16(%rsp), %rsi
	leaq	(%r12,%rcx), %r8
	movq	%r14, %rcx
	call	emit_edge_list_init
	cmpl	$1, (%r14)
	movq	%rax, %rdx
	popq	%rax
	.cfi_def_cfa_offset 104
	popq	%rcx
	.cfi_def_cfa_offset 96
	movq	24(%rsp), %r11
	jne	.L873
	movq	24(%r14), %rsi
	movq	16(%r14), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, 8(%rsp)
.L873:
	movq	8(%rsp), %rax
	cmpq	%rdx, %rax
	cmovnb	%rax, %rdx
	movq	%rdx, 8(%rsp)
	jmp	.L870
	.cfi_endproc
.LFE51:
	.size	emit_edge_list_init, .-emit_edge_list_init
	.section	.rodata.str1.1
.LC105:
	.string	"<"
.LC106:
	.string	"<="
.LC107:
	.string	">"
.LC108:
	.string	">="
.LC109:
	.string	"??"
.LC110:
	.string	"while ("
.LC111:
	.string	")\n"
.LC112:
	.string	"if ("
.LC113:
	.string	"switch ("
.LC114:
	.string	") {\n"
.LC115:
	.string	"continue;\n"
.LC116:
	.string	"break;\n"
.LC117:
	.string	"return"
.LC118:
	.string	"{\n"
.LC119:
	.string	"return "
.LC120:
	.string	"}\n"
.LC121:
	.string	"word __%s_store[("
.LC122:
	.string	") + 1];\n"
.LC123:
	.string	"word %s;\n"
	.section	.rodata.str1.8
	.align 8
.LC124:
	.string	"(void)B_LOCAL_PTR_N(&%s, sizeof(%s));\n"
	.align 8
.LC125:
	.string	"%s = B_LOCAL_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC126:
	.string	"word %s = 0;\n"
.LC127:
	.string	"else\n"
	.section	.rodata.str1.8
	.align 8
.LC128:
	.string	"case %zu: goto __b_label_%zu;\n"
	.align 8
.LC129:
	.string	"default: fputs(\"bcc: invalid label value\\n\", stderr); abort();\n"
	.section	.rodata.str1.1
.LC130:
	.string	"__bsw%d_case%zu"
.LC131:
	.string	"for(;;) {\n"
.LC132:
	.string	"word __sw = "
.LC133:
	.string	"__bsw%d_end"
.LC134:
	.string	"goto __bsw%d_dispatch;\n"
.LC135:
	.string	"goto __bsw%d_end;\n"
.LC136:
	.string	"__sw %s (word)%ld"
	.section	.rodata.str1.8
	.align 8
.LC137:
	.string	"(__sw >= (word)%ld && __sw <= (word)%ld)"
	.section	.rodata.str1.1
.LC138:
	.string	"__sw == (word)%ld"
.LC139:
	.string	") goto "
.LC140:
	.string	"__bsw%d_end:\n"
.LC141:
	.string	"__b_label_%d:\n"
.LC142:
	.string	"__bsw%d_dispatch:\n"
	.text
	.p2align 4
	.globl	emit_stmt
	.type	emit_stmt, @function
emit_stmt:
.LFB52:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rdi, %r15
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	leaq	.L901(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	%ecx, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$248, %rsp
	.cfi_def_cfa_offset 304
	testq	%r8, %r8
	movl	%edx, 8(%rsp)
	movq	%r8, 16(%rsp)
	setne	24(%rsp)
.L897:
	movl	g_no_line(%rip), %eax
	testl	%eax, %eax
	jne	.L898
	cmpb	$0, 24(%rsp)
	jne	.L1192
.L898:
	cmpl	$12, (%rbx)
	ja	.L896
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L901:
	.long	.L912-.L901
	.long	.L911-.L901
	.long	.L910-.L901
	.long	.L909-.L901
	.long	.L908-.L901
	.long	.L907-.L901
	.long	.L906-.L901
	.long	.L896-.L901
	.long	.L905-.L901
	.long	.L904-.L901
	.long	.L903-.L901
	.long	.L902-.L901
	.long	.L900-.L901
	.text
	.p2align 4,,10
	.p2align 3
.L1192:
	movl	4(%rbx), %edx
	movq	16(%rsp), %rcx
	movq	%r15, %rdi
	xorl	%eax, %eax
	leaq	.LC29(%rip), %rsi
	call	fprintf@PLT
	jmp	.L898
	.p2align 4,,10
	.p2align 3
.L900:
	movl	g_switch_id(%rip), %eax
	xorl	%ebp, %ebp
	leaq	.LC130(%rip), %r14
	addl	$1, %eax
	movl	%eax, 32(%rsp)
	movl	%eax, g_switch_id(%rip)
	xorl	%eax, %eax
	call	vec_new@PLT
	movq	%rax, %r12
	xorl	%eax, %eax
	call	vec_new@PLT
	movq	24(%rbx), %rdi
	movq	%r12, %rsi
	movq	%rax, 40(%rsp)
	call	collect_cases
	leaq	112(%rsp), %rax
	cmpq	$0, 8(%r12)
	movq	%rax, 24(%rsp)
	je	.L989
	movq	%rbx, 56(%rsp)
	movq	24(%rsp), %r13
	movq	%r15, 48(%rsp)
	movq	%rbp, %r15
	movq	40(%rsp), %rbp
	.p2align 4
	.p2align 3
.L986:
	movl	$16, %edi
	call	xmalloc@PLT
	movl	32(%rsp), %ecx
	movq	%r15, %r8
	movq	%r14, %rdx
	movq	%rax, %rbx
	movq	(%r12), %rax
	movl	$128, %esi
	movq	%r13, %rdi
	movq	(%rax,%r15,8), %rax
	addq	$1, %r15
	movq	%rax, (%rbx)
	xorl	%eax, %eax
	call	snprintf@PLT
	movq	%r13, %rdi
	call	strlen@PLT
	movq	g_compilation_arena(%rip), %rdi
	xorl	%edx, %edx
	movq	%r13, %rsi
	movq	%rax, %rcx
	call	arena_xstrdup_range@PLT
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	movq	%rax, 8(%rbx)
	call	vec_push@PLT
	cmpq	8(%r12), %r15
	jb	.L986
	movq	48(%rsp), %r15
	movq	56(%rsp), %rbx
.L989:
	movl	8(%rsp), %edx
	movl	8(%rsp), %r14d
	xorl	%ebp, %ebp
	leaq	.LC28(%rip), %r13
	testl	%edx, %edx
	jle	.L1193
	.p2align 4
	.p2align 3
.L987:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r14d
	jne	.L987
	movq	%r15, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC131(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r14d
.L990:
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 48(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L993:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L993
	movq	48(%rsp), %rbx
	movq	%r15, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC132(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	leaq	.LC103(%rip), %rax
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ecx
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC133(%rip), %rdx
	movl	$64, %esi
	call	snprintf@PLT
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 56(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L994:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L994
	movl	32(%rsp), %edx
	leaq	.LC134(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	56(%rsp), %rbx
	call	fprintf@PLT
	movq	24(%rsp), %rax
	movl	%r14d, %edx
	movq	%r15, %rdi
	movq	24(%rbx), %rsi
	movq	16(%rsp), %r8
	xorl	%ebx, %ebx
	movl	$1, 80(%rsp)
	movq	%rax, 88(%rsp)
	movq	g_ctrl(%rip), %rax
	movq	40(%rsp), %rcx
	movq	%rax, 96(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, g_ctrl(%rip)
	call	emit_stmt_switchctx
	movq	96(%rsp), %rax
	movl	8(%rsp), %ebp
	movq	%rax, g_ctrl(%rip)
	.p2align 4
	.p2align 3
.L995:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L995
	leaq	.LC135(%rip), %rax
	movl	32(%rsp), %edx
	movq	%r15, %rdi
	xorl	%ebx, %ebx
	movq	%rax, 64(%rsp)
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	8(%rsp), %ebp
	.p2align 4
	.p2align 3
.L996:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L996
	movl	32(%rsp), %edx
	xorl	%eax, %eax
	leaq	.LC142(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r12)
	leal	2(%rax), %ebx
	je	.L998
.L1034:
	leaq	.LC112(%rip), %rax
	movq	%r12, 16(%rsp)
	xorl	%r13d, %r13d
	leaq	.LC28(%rip), %rbp
	movq	%rax, 56(%rsp)
	movl	%r14d, 76(%rsp)
	.p2align 4
	.p2align 3
.L1012:
	movq	16(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r13,8), %r14
	movq	40(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1059
	xorl	%eax, %eax
	jmp	.L1003
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1002:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1059
.L1003:
	movq	(%rsi,%rax,8), %rdx
	cmpq	(%rdx), %r14
	jne	.L1002
	movq	8(%rdx), %rax
	movq	%rax, 24(%rsp)
.L1001:
	xorl	%r12d, %r12d
	testl	%ebx, %ebx
	jle	.L1007
	.p2align 4
	.p2align 3
.L1004:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%ebx, %r12d
	jne	.L1004
.L1007:
	movq	56(%rsp), %rdi
	movl	$1, %esi
	movq	%r15, %rcx
	movl	$4, %edx
	call	fwrite@PLT
	movl	20(%r14), %eax
	movq	24(%r14), %rsi
	testl	%eax, %eax
	je	.L1194
	leaq	.LC107(%rip), %rdx
	cmpl	$26, %eax
	je	.L1008
	ja	.L1009
	leaq	.LC105(%rip), %rdx
	cmpl	$24, %eax
	je	.L1008
	cmpl	$25, %eax
	leaq	.LC109(%rip), %rdx
	leaq	.LC106(%rip), %rax
	cmove	%rax, %rdx
.L1008:
	movq	%rsi, %rcx
	movq	%r15, %rdi
	xorl	%eax, %eax
	leaq	.LC136(%rip), %rsi
	call	fprintf@PLT
.L1010:
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	addq	$1, %r13
	leaq	.LC139(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rsp), %rdi
	movq	%r15, %rsi
	call	fputs@PLT
	movq	48(%rsp), %rdi
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	16(%rsp), %rax
	cmpq	8(%rax), %r13
	jb	.L1012
	movl	76(%rsp), %r14d
	leaq	.LC28(%rip), %r13
	testl	%ebx, %ebx
	jle	.L1195
.L998:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1014:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1014
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	movl	8(%rsp), %r12d
	testl	%r14d, %r14d
	jle	.L1167
	.p2align 4
	.p2align 3
.L1015:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jg	.L1015
.L1167:
	movl	32(%rsp), %edx
	leaq	.LC140(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	.p2align 4
	.p2align 3
.L1019:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1019
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	xorl	%ebx, %ebx
	leaq	.LC116(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	jle	.L1021
	.p2align 4
	.p2align 3
.L1022:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1022
.L1021:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
.L896:
	addq	$248, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
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
.L912:
	.cfi_restore_state
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	leaq	.LC28(%rip), %r13
	testl	%ebp, %ebp
	jle	.L1191
	.p2align 4
	.p2align 3
.L936:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L936
.L1191:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC103(%rip), %rdi
.L1190:
	addq	$248, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
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
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L911:
	.cfi_restore_state
	movl	8(%rsp), %r9d
	movl	8(%rsp), %r14d
	xorl	%r12d, %r12d
	leaq	.LC28(%rip), %r13
	testl	%r9d, %r9d
	jle	.L1196
	.p2align 4
	.p2align 3
.L934:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r14d
	jne	.L934
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L939
.L938:
	movl	8(%rsp), %edi
	xorl	%r13d, %r13d
	addl	$1, %edi
	movl	%edi, 40(%rsp)
.L946:
	movq	16(%rbx), %rdx
	movq	(%rdx,%r13,8), %r12
	testl	%ebp, %ebp
	je	.L1049
	subq	$1, %rax
	xorl	%ecx, %ecx
	cmpq	%r13, %rax
	je	.L1197
.L941:
	movq	16(%rsp), %r8
	movl	40(%rsp), %edx
	movq	%r12, %rsi
	movq	%r15, %rdi
	call	emit_stmt
.L944:
	movq	24(%rbx), %rax
	addq	$1, %r13
	cmpq	%rax, %r13
	jb	.L946
	movl	8(%rsp), %r8d
	leaq	.LC28(%rip), %r13
	testl	%r8d, %r8d
	jle	.L948
.L939:
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L949:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L949
.L948:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	jmp	.L1190
	.p2align 4,,10
	.p2align 3
.L910:
	xorl	%ecx, %ecx
	cmpq	$0, 24(%rbx)
	leaq	.LC28(%rip), %rbp
	je	.L896
	movq	%rbx, 24(%rsp)
	movl	8(%rsp), %r12d
	movq	%rcx, %r14
	.p2align 4
	.p2align 3
.L933:
	movq	24(%rsp), %rax
	movq	16(%rax), %rax
	movq	(%rax,%r14,8), %rbx
	movq	(%rbx), %rdi
	call	get_mangled_name
	cmpq	$0, 8(%rbx)
	movq	%rax, 8(%rsp)
	je	.L1198
	testl	%r12d, %r12d
	jle	.L953
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L954:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%r13d, %r12d
	jne	.L954
	movq	8(%rsp), %rdx
	leaq	.LC121(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	8(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	xorl	%ebx, %ebx
	call	emit_expr
	movq	%r15, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	call	fwrite@PLT
	.p2align 4
	.p2align 3
.L955:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L955
	movq	8(%rsp), %rdx
	xorl	%eax, %eax
	leaq	.LC123(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L1199
.L956:
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L959:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L959
.L958:
	movq	8(%rsp), %rcx
	leaq	.LC125(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	%rcx, %r8
	movq	%rcx, %rdx
	call	fprintf@PLT
.L960:
	movq	24(%rsp), %rax
	addq	$1, %r14
	cmpq	24(%rax), %r14
	jb	.L933
	jmp	.L896
	.p2align 4,,10
	.p2align 3
.L1199:
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L957:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L957
	movq	8(%rsp), %rcx
	leaq	.LC124(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	%rcx, %rdx
	call	fprintf@PLT
	jmp	.L956
	.p2align 4,,10
	.p2align 3
.L909:
	movl	8(%rsp), %eax
	xorl	%r14d, %r14d
	leaq	.LC28(%rip), %r13
	testl	%eax, %eax
	jle	.L966
	.p2align 4
	.p2align 3
.L919:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%r14d, 8(%rsp)
	jne	.L919
.L966:
	movq	%r15, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC112(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC111(%rip), %rdi
	call	fwrite@PLT
	testl	%ebp, %ebp
	jne	.L920
.L921:
	movq	24(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L967
	cmpl	$1, (%rsi)
	movl	8(%rsp), %edx
	je	.L968
.L967:
	movl	8(%rsp), %eax
	leal	1(%rax), %edx
.L968:
	movq	16(%rsp), %r8
	movl	%ebp, %ecx
	movq	%r15, %rdi
	call	emit_stmt
	cmpq	$0, 32(%rbx)
	je	.L896
	movl	8(%rsp), %ecx
	xorl	%ebp, %ebp
	leaq	.LC28(%rip), %r13
	testl	%ecx, %ecx
	jle	.L972
	.p2align 4
	.p2align 3
.L969:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, 8(%rsp)
	jne	.L969
.L972:
	movq	%r15, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC127(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L917
	jmp	.L918
	.p2align 4,,10
	.p2align 3
.L908:
	movl	8(%rsp), %eax
	xorl	%ebp, %ebp
	leaq	.LC28(%rip), %r13
	testl	%eax, %eax
	jle	.L974
	.p2align 4
	.p2align 3
.L916:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, 8(%rsp)
	jne	.L916
.L974:
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC110(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC111(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L918
.L917:
	cmpl	$1, (%rbx)
	je	.L973
.L918:
	addl	$1, 8(%rsp)
.L973:
	xorl	%ebp, %ebp
	jmp	.L897
	.p2align 4,,10
	.p2align 3
.L907:
	movl	8(%rsp), %r10d
	movl	8(%rsp), %r12d
	xorl	%ebp, %ebp
	leaq	.LC28(%rip), %r13
	testl	%r10d, %r10d
	jle	.L975
	.p2align 4
	.p2align 3
.L930:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L930
.L975:
	movq	%r15, %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%rbx)
	je	.L1191
	movq	%r15, %rsi
	movl	$32, %edi
	call	fputc@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	jmp	.L1191
	.p2align 4,,10
	.p2align 3
.L905:
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	leaq	.LC28(%rip), %r13
	testl	%ebp, %ebp
	jle	.L977
	movl	8(%rsp), %ebp
	.p2align 4
	.p2align 3
.L926:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L926
.L977:
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC116(%rip), %rdi
	jmp	.L1190
	.p2align 4,,10
	.p2align 3
.L906:
	movl	8(%rsp), %r11d
	movl	8(%rsp), %r14d
	xorl	%r12d, %r12d
	leaq	.LC28(%rip), %r13
	testl	%r11d, %r11d
	jle	.L976
	.p2align 4
	.p2align 3
.L927:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r14d
	jne	.L927
.L976:
	testl	%ebp, %ebp
	jne	.L1200
.L929:
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	jmp	.L1191
	.p2align 4,,10
	.p2align 3
.L903:
	movl	8(%rsp), %r14d
	movl	8(%rsp), %r12d
	xorl	%ebp, %ebp
	leaq	.LC28(%rip), %r13
	testl	%r14d, %r14d
	jle	.L979
	.p2align 4
	.p2align 3
.L922:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L922
.L979:
	movq	%r15, %rcx
	movl	$8, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC113(%rip), %rdi
	leaq	.LC128(%rip), %r13
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	%r15, %rdi
	movq	16(%rsp), %rdx
	leaq	.LC28(%rip), %rbp
	call	emit_expr
	movq	%r15, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC114(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	movl	8(%rsp), %r14d
	je	.L924
	.p2align 4
	.p2align 3
.L923:
	xorl	%ebx, %ebx
	testl	%r14d, %r14d
	js	.L981
	.p2align 4
	.p2align 3
.L980:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r14d
	jge	.L980
.L981:
	addq	$1, %r12
	xorl	%eax, %eax
	movq	%r13, %rsi
	movq	%r15, %rdi
	movq	%r12, %rcx
	movq	%r12, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %r12
	jb	.L923
.L924:
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	js	.L982
	xorl	%ebx, %ebx
	leaq	.LC28(%rip), %r13
	.p2align 4
	.p2align 3
.L983:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jge	.L983
	movq	%r15, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC129(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	je	.L948
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L985:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L985
	jmp	.L948
	.p2align 4,,10
	.p2align 3
.L904:
	movl	8(%rsp), %r12d
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	leaq	.LC28(%rip), %r13
	testl	%r12d, %r12d
	jle	.L978
	.p2align 4
	.p2align 3
.L925:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L925
.L978:
	movq	%r15, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	jmp	.L1190
	.p2align 4,,10
	.p2align 3
.L902:
	movl	8(%rsp), %eax
	xorl	%ebp, %ebp
	leaq	.LC28(%rip), %r13
	testl	%eax, %eax
	jle	.L1201
	.p2align 4
	.p2align 3
.L913:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, 8(%rsp)
	jne	.L913
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 32(%rsp)
	testq	%rbp, %rbp
	je	.L1202
.L914:
	movq	function_labels(%rip), %r14
	xorl	%r13d, %r13d
	jmp	.L1027
	.p2align 4,,10
	.p2align 3
.L1025:
	addq	$1, %r13
	cmpq	%rbp, %r13
	je	.L915
.L1027:
	movq	(%r14,%r13,8), %rsi
	movq	32(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1025
	leal	1(%r13), %edx
.L1026:
	leaq	.LC141(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	8(%rsp), %eax
	leaq	.LC28(%rip), %r13
	leal	1(%rax), %ebp
	testl	%ebp, %ebp
	jle	.L1030
.L1028:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1029:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, 8(%rsp)
	jne	.L1029
.L1030:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC103(%rip), %rdi
	call	fwrite@PLT
	movl	%ebp, 8(%rsp)
	movq	24(%rbx), %rbx
	xorl	%ebp, %ebp
	jmp	.L897
	.p2align 4,,10
	.p2align 3
.L1059:
	movq	$0, 24(%rsp)
	jmp	.L1001
	.p2align 4,,10
	.p2align 3
.L1194:
	movl	16(%r14), %eax
	testl	%eax, %eax
	je	.L1011
	movq	32(%r14), %rcx
	movq	%rsi, %rdx
	movq	%r15, %rdi
	xorl	%eax, %eax
	leaq	.LC137(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1010
	.p2align 4,,10
	.p2align 3
.L1198:
	xorl	%ebx, %ebx
	testl	%r12d, %r12d
	jle	.L1203
	.p2align 4
	.p2align 3
.L951:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L951
	movq	8(%rsp), %rdx
	xorl	%eax, %eax
	leaq	.LC126(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L960
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L964:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L964
.L962:
	movq	8(%rsp), %rcx
	leaq	.LC124(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	%rcx, %rdx
	call	fprintf@PLT
	jmp	.L960
.L1197:
	cmpl	$6, (%r12)
	movl	%ebp, %ecx
	jne	.L941
	movl	g_no_line(%rip), %edi
	testl	%edi, %edi
	jne	.L942
	cmpb	$0, 24(%rsp)
	je	.L942
	movl	4(%r12), %edx
	movq	16(%rsp), %rcx
	movq	%r15, %rdi
	xorl	%eax, %eax
	leaq	.LC29(%rip), %rsi
	call	fprintf@PLT
.L942:
	movl	8(%rsp), %esi
	leaq	.LC28(%rip), %rax
	xorl	%r14d, %r14d
	movq	%rax, 32(%rsp)
	testl	%esi, %esi
	js	.L945
	.p2align 4
	.p2align 3
.L943:
	movq	32(%rsp), %rdi
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r14d
	call	fwrite@PLT
	cmpl	%r14d, 8(%rsp)
	jge	.L943
.L945:
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC119(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r12), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC103(%rip), %rdi
	call	fwrite@PLT
	jmp	.L944
	.p2align 4,,10
	.p2align 3
.L1011:
	movq	%rsi, %rdx
	movq	%r15, %rdi
	leaq	.LC138(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1010
	.p2align 4,,10
	.p2align 3
.L1049:
	xorl	%ecx, %ecx
	jmp	.L941
	.p2align 4,,10
	.p2align 3
.L1009:
	cmpl	$27, %eax
	leaq	.LC109(%rip), %rdx
	leaq	.LC108(%rip), %rax
	cmove	%rax, %rdx
	jmp	.L1008
.L953:
	movq	8(%rsp), %r13
	leaq	.LC121(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	%r13, %rdx
	call	fprintf@PLT
	movq	8(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	movq	%r15, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	call	fwrite@PLT
	xorl	%eax, %eax
	movq	%r13, %rdx
	movq	%r15, %rdi
	leaq	.LC123(%rip), %rsi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L958
	movq	8(%rsp), %rcx
	leaq	.LC124(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	%rcx, %rdx
	call	fprintf@PLT
	jmp	.L958
.L920:
	xorl	%ebp, %ebp
	cmpq	$0, 32(%rbx)
	sete	%bpl
	jmp	.L921
.L1195:
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	xorl	%eax, %eax
	movq	%r15, %rdi
	call	fprintf@PLT
	testl	%r14d, %r14d
	jle	.L1189
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
.L1189:
	movl	32(%rsp), %edx
	movq	%r15, %rdi
	leaq	.LC140(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC116(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1021
.L1201:
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 32(%rsp)
	testq	%rbp, %rbp
	jne	.L914
.L915:
	xorl	%edx, %edx
	jmp	.L1026
.L1200:
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC119(%rip), %rdi
	call	fwrite@PLT
	jmp	.L929
.L1203:
	movq	8(%rsp), %rdx
	xorl	%eax, %eax
	leaq	.LC126(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L960
	jmp	.L962
.L982:
	movq	%r15, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC129(%rip), %rdi
	call	fwrite@PLT
	jmp	.L948
.L1196:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	jne	.L938
	jmp	.L948
.L1193:
	movq	%r15, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC131(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r14d
	testl	%eax, %eax
	je	.L990
	movq	%r15, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC132(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	leaq	.LC103(%rip), %rax
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ebp
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC133(%rip), %rdx
	movl	$64, %esi
	movl	%ebp, %ecx
	call	snprintf@PLT
	movl	%ebp, %edx
	leaq	.LC134(%rip), %rsi
	xorl	%eax, %eax
	movq	%r15, %rdi
	call	fprintf@PLT
	movq	24(%rsp), %rax
	movl	%r14d, %edx
	movq	%r15, %rdi
	movq	24(%rbx), %rsi
	movq	16(%rsp), %r8
	movl	$1, 80(%rsp)
	movq	%rax, 88(%rsp)
	movq	g_ctrl(%rip), %rax
	movq	40(%rsp), %rcx
	movq	%rax, 96(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, g_ctrl(%rip)
	call	emit_stmt_switchctx
	movq	96(%rsp), %rax
	movl	%ebp, %edx
	movq	%r15, %rdi
	movq	%rax, g_ctrl(%rip)
	leaq	.LC135(%rip), %rax
	movq	%rax, %rsi
	movq	%rax, 64(%rsp)
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%eax, %eax
	movl	%ebp, %edx
	leaq	.LC142(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r12)
	leal	2(%rax), %ebx
	jne	.L1034
	cmpl	$1, %ebx
	je	.L998
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1189
	.p2align 4,,10
	.p2align 3
.L1202:
	xorl	%edx, %edx
	leaq	.LC141(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %ebp
	jmp	.L1028
	.cfi_endproc
.LFE52:
	.size	emit_stmt, .-emit_stmt
	.section	.rodata.str1.1
.LC143:
	.string	"%s:\n"
	.text
	.p2align 4
	.type	emit_stmt_switchctx, @function
emit_stmt_switchctx:
.LFB42:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.L1209(%rip), %r15
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	%edx, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movq	%rcx, 8(%rsp)
	movq	%r8, (%rsp)
	testq	%rsi, %rsi
	je	.L1204
.L1205:
	cmpl	$13, 0(%r13)
	ja	.L1207
	movl	0(%r13), %eax
	movslq	(%r15,%rax,4), %rax
	addq	%r15, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1209:
	.long	.L1207-.L1209
	.long	.L1213-.L1209
	.long	.L1207-.L1209
	.long	.L1212-.L1209
	.long	.L1211-.L1209
	.long	.L1207-.L1209
	.long	.L1207-.L1209
	.long	.L1207-.L1209
	.long	.L1207-.L1209
	.long	.L1207-.L1209
	.long	.L1207-.L1209
	.long	.L1210-.L1209
	.long	.L1207-.L1209
	.long	.L1208-.L1209
	.text
	.p2align 4,,10
	.p2align 3
.L1207:
	movq	(%rsp), %r8
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%ebp, %edx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	xorl	%ecx, %ecx
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
	jmp	emit_stmt
	.p2align 4,,10
	.p2align 3
.L1208:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1257
	xorl	%eax, %eax
	jmp	.L1227
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1226:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1257
.L1227:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%r13, (%rdx)
	jne	.L1226
	movq	8(%rdx), %r14
.L1225:
	xorl	%r13d, %r13d
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1291
	.p2align 4
	.p2align 3
.L1228:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1228
	movq	%r14, %rdx
	leaq	.LC143(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1231:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jle	.L1231
.L1230:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC103(%rip), %rdi
	jmp	.L1290
	.p2align 4,,10
	.p2align 3
.L1210:
	xorl	%r14d, %r14d
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1292
	.p2align 4
	.p2align 3
.L1214:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1214
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L1293
.L1215:
	movq	function_labels(%rip), %r14
	xorl	%r12d, %r12d
	jmp	.L1235
	.p2align 4,,10
	.p2align 3
.L1233:
	addq	$1, %r12
	cmpq	%r12, 24(%rsp)
	je	.L1216
.L1235:
	movq	(%r14,%r12,8), %rsi
	movq	16(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1233
	leal	1(%r12), %edx
.L1234:
	leaq	.LC141(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	leaq	.LC28(%rip), %r12
	movl	%eax, 16(%rsp)
	testl	%eax, %eax
	jle	.L1294
.L1236:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1238:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, %ebp
	jne	.L1238
	movl	16(%rsp), %ebp
.L1239:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC103(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	jne	.L1205
	jmp	.L1204
	.p2align 4,,10
	.p2align 3
.L1211:
	xorl	%r14d, %r14d
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1251
	.p2align 4
	.p2align 3
.L1217:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1217
.L1251:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC110(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC111(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	je	.L1204
.L1218:
	xorl	%eax, %eax
	cmpl	$1, 0(%r13)
	setne	%al
	addl	%eax, %ebp
	jmp	.L1205
	.p2align 4,,10
	.p2align 3
.L1212:
	xorl	%r14d, %r14d
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1246
	.p2align 4
	.p2align 3
.L1220:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1220
.L1246:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC112(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC111(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %rsi
	testq	%rsi, %rsi
	je	.L1222
	cmpl	$1, (%rsi)
	movl	%ebp, %edx
	je	.L1247
.L1222:
	leal	1(%rbp), %edx
.L1247:
	movq	(%rsp), %r8
	movq	8(%rsp), %rcx
	movq	%rbx, %rdi
	call	emit_stmt_switchctx
	cmpq	$0, 32(%r13)
	je	.L1204
	xorl	%r14d, %r14d
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1250
	.p2align 4
	.p2align 3
.L1248:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1248
.L1250:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC127(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r13), %r13
	testq	%r13, %r13
	jne	.L1218
.L1204:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
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
.L1213:
	.cfi_restore_state
	xorl	%r15d, %r15d
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1295
	.p2align 4
	.p2align 3
.L1223:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebp, %r15d
	jne	.L1223
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	je	.L1241
.L1240:
	leal	1(%rbp), %r12d
	xorl	%r15d, %r15d
.L1243:
	movq	16(%r13), %rax
	movq	(%rsp), %r8
	movl	%r12d, %edx
	movq	%rbx, %rdi
	movq	8(%rsp), %rcx
	movq	(%rax,%r15,8), %rsi
	addq	$1, %r15
	call	emit_stmt_switchctx
	cmpq	24(%r13), %r15
	jb	.L1243
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1242
.L1241:
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1245:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1245
.L1242:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
.L1290:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
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
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L1257:
	.cfi_restore_state
	xorl	%r14d, %r14d
	jmp	.L1225
	.p2align 4,,10
	.p2align 3
.L1292:
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	jne	.L1215
	.p2align 4
	.p2align 3
.L1216:
	xorl	%edx, %edx
	jmp	.L1234
.L1293:
	xorl	%edx, %edx
	leaq	.LC141(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	movl	%eax, 16(%rsp)
	jmp	.L1236
	.p2align 4,,10
	.p2align 3
.L1291:
	xorl	%eax, %eax
	movq	%r14, %rdx
	leaq	.LC143(%rip), %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	testl	%ebp, %ebp
	jne	.L1230
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	jmp	.L1230
	.p2align 4,,10
	.p2align 3
.L1294:
	movl	%eax, %ebp
	jmp	.L1239
	.p2align 4,,10
	.p2align 3
.L1295:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	jne	.L1240
	jmp	.L1242
	.cfi_endproc
.LFE42:
	.size	emit_stmt_switchctx, .-emit_stmt_switchctx
	.section	.rodata.str1.1
.LC144:
	.string	"{\n    B_FRAME;\n"
	.section	.rodata.str1.8
	.align 8
.LC145:
	.string	"    (void)B_LOCAL_PTR_N(&%s, sizeof(%s));\n"
	.align 8
.LC146:
	.string	"    static word __b_label_value_%zu = %zu;\n"
	.text
	.p2align 4
	.type	emit_function_body, @function
emit_function_body:
.LFB53:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rdx, %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	32(%rsi), %rdi
	movq	$0, 8+function_labels(%rip)
	call	collect_function_labels
	movq	%rbp, %rcx
	movl	$15, %edx
	movl	$1, %esi
	leaq	.LC144(%rip), %rdi
	call	fwrite@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L1304
.L1297:
	cmpq	$0, 8+function_labels(%rip)
	je	.L1299
	xorl	%ebx, %ebx
	leaq	.LC146(%rip), %r14
	.p2align 4
	.p2align 3
.L1300:
	addq	$1, %rbx
	xorl	%eax, %eax
	movq	%r14, %rsi
	movq	%rbp, %rdi
	movq	%rbx, %rcx
	movq	%rbx, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %rbx
	jb	.L1300
.L1299:
	movq	32(%r12), %rsi
	movq	%r13, %r8
	movq	%rbp, %rdi
	movl	$1, %ecx
	movl	$1, %edx
	call	emit_stmt
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	movq	$0, 8+function_labels(%rip)
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1304:
	.cfi_restore_state
	cmpq	$0, 16(%r12)
	je	.L1297
	xorl	%r14d, %r14d
	leaq	.LC145(%rip), %rbx
	.p2align 4
	.p2align 3
.L1298:
	movq	8(%r12), %rax
	movq	(%rax,%r14,8), %rdi
	addq	$1, %r14
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	movq	%rax, %rdx
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	fprintf@PLT
	cmpq	16(%r12), %r14
	jb	.L1298
	jmp	.L1297
	.cfi_endproc
.LFE53:
	.size	emit_function_body, .-emit_function_body
	.section	.rodata.str1.1
.LC147:
	.string	"#define BCC_USE_CURSES 1\n"
	.section	.rodata.str1.8
	.align 8
.LC148:
	.ascii	"#define _DEFAULT_SOURCE 1\n#define _XOPEN_SOURCE 700\n#defin"
	.ascii	"e _POSIX_C_SOURCE 200809L\n#include <stdio.h>\n#include <std"
	.ascii	"lib.h>\n#include <stdint.h>\n#include <inttypes.h>\n#include"
	.ascii	" <stdarg.h>\n#include <string.h>\n#include <time.h>\n#includ"
	.ascii	"e <unistd.h>\n#include <sys/stat.h>\n#include <sys/types.h>\n"
	.ascii	"#include <fcntl.h>\n#include <unistd.h>\n#include <sys/wait."
	.ascii	"h>\n#include <signal.h>\n#include <termios.h>\n#include <sys"
	.ascii	"/ioctl.h>\n#include <ctype.h>\n#include <errno.h>\n#include "
	.ascii	"<dlfcn.h>\n#include <math.h>\n#include <stddef.h>\n#ifdef BC"
	.ascii	"C_USE_CURSES\n#include <ncurses.h>\n#include <panel.h>\n#end"
	.ascii	"if\n\n/* Undefine common macros that might conflict with B v"
	.ascii	"ariable names */\n#undef TRUE\n#undef FALSE\n#undef TCSAFLUS"
	.ascii	"H\n#undef FIONREAD\n#undef TIOCGWINSZ\n\ntypedef intptr_t  w"
	.ascii	"ord;\ntypedef uintptr_t uword;\n\n/* Endianness check: char("
	.ascii	")/lchar() in B_BYTEPTR=0 mode pack bytes with\n * byte 0 at "
	.ascii	"the LSB (PDP-11/little-endian convention). The shift-based\n"
	.ascii	" * implementation works on word VALUES so it's consistent ac"
	.ascii	"ross architectures,\n * but string literals compiled on one "
	.ascii	"endianness may look wrong on another.\n * Warn if running on"
	.ascii	" big-endian to alert users to potential issues.\n */\n#if !d"
	.ascii	"efined(__BYTE_ORDER__) || __BYTE_ORDER__ != __ORDER_LITTLE_E"
	.ascii	"NDIAN__\n  #if !B_BYTEPTR\n    #warning \"B_BYTEPTR=0 mode u"
	.ascii	"ses little-endian"
	.string	" byte packing; results may differ on big-endian hosts\"\n  #endif\n#endif\n\n/*\n  Pointer model:\n    B_BYTEPTR=1  -> pointers are byte addresses (matches your formulas)\n    B_BYTEPTR=0  -> pointers are word addresses (closer to Thompson B: E1[E2]==*(E1+E2))\n*/\n"
	.section	.rodata.str1.1
.LC149:
	.string	"#define B_BYTEPTR %d\n"
.LC150:
	.string	"#define WORD_BITS %d\n"
	.section	.rodata.str1.8
	.align 8
.LC151:
	.ascii	"/*\n  Word size emulation:\n    WORD_BITS=0   -> host native"
	.ascii	" (no wrapping)\n    WORD_BITS=16  -> wrap arithmetic like PD"
	.ascii	"P-11 16-bit words\n    WORD_BITS=32  -> wrap arithmetic at 3"
	.ascii	"2 bits\n  WVAL(x) sign-extends to word width after masking.\n"
	.ascii	"*/\n#if WORD_BITS == 16\n  #define WORD_MASK 0xFFFFU\n  #def"
	.ascii	"ine WVAL(x) ((word)(int16_t)((x) & WORD_MASK))\n  #define SH"
	.ascii	"IFT_MASK 15\n#elif WORD_BITS == 32\n  #define WORD_MASK 0xFF"
	.ascii	"FFFFFFU\n  #define WVAL(x) ((word)(int32_t)((x) & WORD_MASK)"
	.ascii	")\n  #define SHIFT_MASK 31\n#else\n  #define WORD_MASK (~(uw"
	.ascii	"ord)0)\n  #define WVAL(x) (x)\n  #define SHIFT_MASK ((int)(s"
	.ascii	"izeof(word)*8 - 1))\n#endif\n\n/*\n * Safe arithmetic macros"
	.ascii	" - avoid host-C undefined behavior:\n *   - All arithmetic d"
	.ascii	"one in unsigned to prevent signed overflow UB\n *   - Shift "
	.ascii	"counts masked to valid range to prevent shift >= width UB\n "
	.ascii	"*   - Results wrapped with WVAL() for proper word semantics\n"
	.ascii	" */\n#define WADD(a,b) WVAL((uword)(a) + (uword)(b))\n#defin"
	.ascii	"e WSUB(a,b) WVAL((uword)(a) - (uword)(b))\n#define WMUL(a,b)"
	.ascii	" WVAL((uword)(a) * (uword)(b))\n#define WDIV(a,b) __b_word_d"
	.ascii	"iv((a),(b))\n#define WMOD(a,b) __b_word_mod((a),(b))\n#defin"
	.ascii	"e WSHL(a,n) WVAL(((uword)(a) & WORD_MASK) << ((uword)(n) & S"
	.ascii	"HIFT_MASK))\n#de"
	.string	"fine WSHR(a,n) WVAL(((uword)(a) & WORD_MASK) >> ((uword)(n) & SHIFT_MASK))\n#define WAND(a,b) WVAL((uword)(a) & (uword)(b))\n#define WOR(a,b)  WVAL((uword)(a) | (uword)(b))\n#define WXOR(a,b) WVAL((uword)(a) ^ (uword)(b))\n#define WNEG(a)   WVAL(-(uword)(a))\n\n"
	.section	.rodata.str1.1
.LC152:
	.string	"%s/btarget.h"
.LC153:
	.string	"#define B_TARGET_DEFINE\n"
	.section	.rodata.str1.8
	.align 8
.LC154:
	.ascii	"static int rd_fd = 0;  /* current input fd */\nstatic int wr"
	.ascii	"_fd = 1;  /* current output fd */\nstatic word rd_unit = 0; "
	.ascii	"/* exposed to B if needed */\nstatic word wr_unit = (word)-1"
	.ascii	";\nstatic void __b_sync_rd(void){\n    if (rd_unit < 0) {\n "
	.ascii	"       if (rd_fd != 0 && rd_fd > 2) close(rd_fd);\n        r"
	.ascii	"d_fd = 0;\n    } else if (rd_fd != (int)rd_unit) {\n        "
	.ascii	"rd_fd = (int)rd_unit;\n    }\n}\nstatic void __b_sync_wr(voi"
	.ascii	"d){\n    if (wr_unit < 0) {\n        if (wr_fd != 1 && wr_fd"
	.ascii	" > 2) close(wr_fd);\n        wr_fd = 1;\n    } else if (wr_f"
	.ascii	"d != (int)wr_unit) {\n        wr_fd = (int)wr_unit;\n    }\n"
	.ascii	"}\nstatic word b_print(word x){\n    __b_sync_wr();\n    cha"
	.ascii	"r buf[64];\n    int n = snprintf(buf, sizeof(buf), \"%\" PRI"
	.ascii	"dPTR \"\\n\", (intptr_t)x);\n    if (n > 0) (void)write(wr_f"
	.ascii	"d, buf, (size_t)n);\n    return x;\n}\n\nstatic word b_putch"
	.ascii	"ar(word x){\n    __b_sync_wr();\n    unsigned char c = (unsi"
	.ascii	"gned char)(x & 0xFF);\n    (void)write(wr_fd, &c, 1);\n    r"
	.ascii	"eturn x;\n}\nstatic word b_getchar(void){ __b_sync_rd(); uns"
	.ascii	"igned char c; ssize_t n = read(rd_fd, &c, 1); if (n == 1) re"
	.ascii	"turn (word)c; if (rd_fd != 0) { close(rd_fd); rd_fd = 0; rd_"
	.ascii	"unit = -1; return b_getchar(); } return (word)004; }\nstatic"
	.ascii	" word b_exit(word code){ exit((int)code); return 0; }\nstati"
	.ascii	"c word b_abort(void){ abort(); return 0; }\nstatic word b_fr"
	.ascii	"ee(word p){ void *host = B_CPTR(p); B_FORGET(host); free(hos"
	.ascii	"t); return 0; }\n\n/* Sign-extend 16-bit value to full word "
	.ascii	"size. Used by 16-bit B programs on 64-bit hosts. */\nstatic "
	.ascii	"word sx64(word x){\n    return (word)(int16_t)(x & 0xFFFF);\n"
	.ascii	"}\n\n/* Command line argument support */\nstatic int __b_arg"
	.ascii	"c;\nstatic char **__b_argv;\n\n/* argv strings converted to "
	.ascii	"B strings (packed words, 004 terminator) */\nstatic word *__"
	.ascii	"b_argvb;\n\nstatic void __b_setargs(int argc, char **argv);\n"
	.ascii	"static word b_argc(void);\nstatic word b_argv(word i);\n\n/*"
	.ascii	" Command line reread buffer */\nstatic word b_reread(void);\n"
	.ascii	"\n/* Helper functions for complex lvalue operations (avoid G"
	.ascii	"NU C extensions) */\n/* All use safe W* macros to avoid host"
	.ascii	"-C undefined behavior"
	.ascii	" */\nstatic word b_preinc(word *p) { return (*p = WADD(*p, 1"
	.ascii	")); }\nstatic word b_predec(word *p) { return (*p = WSUB(*p,"
	.ascii	" 1)); }\nstatic word b_postinc(word *p) { word old = WVAL(*p"
	.ascii	"); *p = WADD(*p, 1); return old; }\nstatic word b_postdec(wo"
	.ascii	"rd *p) { word old = WVAL(*p); *p = WSUB(*p, 1); return old; "
	.ascii	"}\nstatic word b_add_assign(word *p, word v) { return (*p = "
	.ascii	"WADD(*p, v)); }\nstatic word b_sub_assign(word *p, word v) {"
	.ascii	" return (*p = WSUB(*p, v)); }\nstatic word b_mul_assign(word"
	.ascii	" *p, word v) { return (*p = WMUL(*p, v)); }\nstatic word b_d"
	.ascii	"iv_assign(word *p, word v) { return (*p = WDIV(*p, v)); }\ns"
	.ascii	"tatic word b_mod_assign(word *p, word v) { return (*p = WMOD"
	.ascii	"(*p, v)); }\nstatic word b_lsh_assign(word *p, word v) { ret"
	.ascii	"urn (*p = WSHL(*p, v)); }\nstatic word b_rsh_assign(word *p,"
	.ascii	" word v) { return (*p = WSHR(*p, v)); }\nstatic word b_and_a"
	.ascii	"ssign(word *p, word v) { return (*p = WAND(*p, v)); }\nstati"
	.ascii	"c word b_or_assign(word *p, word v) { return (*p = WOR(*p, v"
	.ascii	")); }\nstatic word b_xor_assign(word *p, word v) { return (*"
	.ascii	"p = WXOR(*p, v)); }\n\nstatic word b_alloc(word nwords){\n  "
	.ascii	"  size_t bytes = (size_t)nwords * sizeof(word);\n    void *p"
	.ascii	" = malloc(bytes);\n    if (!p) { fprintf(stderr, \"alloc: ou"
	.ascii	"t of memory\\n\"); exit(1); }\n    return B_PTR_N(p, bytes);"
	.ascii	"\n}\n\n/* B library functions - compatible with Thompson's /"
	.ascii	"etc/libb.a */\n/* String manipulation functions */\nstatic i"
	.ascii	"nline word b_load(word addr){ return B_DEREF(addr); }\nstati"
	.ascii	"c inline void b_store(word addr, word v){ B_DEREF(addr) = WV"
	.ascii	"AL(v);\n}\n\n/* B string access - byte packing within words."
	.ascii	"\n *\n * In B_BYTEPTR=0 mode, bytes are packed into words wi"
	.ascii	"th byte 0 at the LSB.\n * This matches PDP-11 (little-endian"
	.ascii	") conventions. The shift-based approach\n * operates on word"
	.ascii	" VALUES (not memory layout), making it consistent across\n *"
	.ascii	" architectures: char(s,0) always returns the least-significa"
	.ascii	"nt byte of the\n * word at address s, regardless of host end"
	.ascii	"ianness.\n *\n * Note: This only works correctly when ALL by"
	.ascii	"te access goes through char()/lchar().\n * Mixing direct mem"
	.ascii	"o"
	.ascii	"ry access (like C's *(char*)ptr) with B word operations will"
	.ascii	"\n * give different results on big-endian hosts.\n */\nstati"
	.ascii	"c word b_char(word s, word i){\n#if B_BYTEPTR && WORD_BITS !"
	.ascii	"= 16\n    const unsigned char *p = (const unsigned char*)B_C"
	.ascii	"PTR(s);\n    return (word)p[(size_t)i];\n#else\n    const uw"
	.ascii	"ord W = (uword)B_WORD_BYTES;\n    uword wi = (uword)i / W;\n"
	.ascii	"    uword bi = (uword)i % W;\n    uword w  = (uword)B_INDEX("
	.ascii	"s, wi);\n    return (word)((w >> (bi * 8)) & 0xFF);\n#endif\n"
	.ascii	"}\n\nstatic word b_lchar(word s, word i, word c){\n#if B_BYT"
	.ascii	"EPTR && WORD_BITS != 16\n    unsigned char *p = (unsigned ch"
	.ascii	"ar*)B_CPTR(s);\n    p[(size_t)i] = (unsigned char)(c & 0xFF)"
	.ascii	";\n    return c;\n#else\n    const uword W = (uword)B_WORD_B"
	.ascii	"YTES;\n    uword wi = (uword)i / W;\n    uword bi = (uword)i"
	.ascii	" % W;\n\n    word addr = B_ADDR(B_INDEX(s, wi));\n    uword "
	.ascii	"w   = (uword)b_load(addr);\n\n    uword mask = (uword)0xFF <"
	.ascii	"< (bi * 8);\n    w = (w & ~mask) | (((uword)c & 0xFF) << (bi"
	.ascii	" * 8));\n\n    b_store(addr, (word)w);\n    return c;\n#endi"
	.ascii	"f\n}\n\n/* Command line argument support implementation */\n"
	.ascii	"static word __b_pack_cstr(const char *s){\n    size_t n = st"
	.ascii	"rlen(s);                 /* bytes, excluding NUL */\n    siz"
	.ascii	"e_t W = B_WORD_BYTES;              /* bytes per word */\n   "
	.ascii	" size_t total = n + 1;                 /* +1 for 004 termina"
	.ascii	"tor */\n    size_t words = (total + W - 1) / W;\n\n    word "
	.ascii	"bp = b_alloc((word)words);       /* B pointer to word storag"
	.ascii	"e */\n\n    /* write bytes into the B string using lchar (ha"
	.ascii	"ndles packing for B_BYTEPTR=0) */\n    for (size_t i = 0; i "
	.ascii	"< n; i++){\n        b_lchar(bp, (word)i, (word)(unsigned cha"
	.ascii	"r)s[i]);\n    }\n    b_lchar(bp, (word)n, (word)004);\n    r"
	.ascii	"eturn bp;\n}\n\nstatic void __b_bstr_to_cstr(word s, char *b"
	.ascii	"uf, size_t max){\n    size_t i = 0;\n    while (i + 1 < max)"
	.ascii	" {\n        word ch = b_char(s, (word)i);\n        if (ch =="
	.ascii	" 004 || ch == 0) break;\n        buf[i++] = (char)(ch & 0xFF"
	.ascii	");\n    }\n    buf[i] = 0;\n}\n\n/* Convert a B string (004-"
	.ascii	"terminated) into a temporary NUL-terminated C string */\nsta"
	.ascii	"tic const char *__b_cstr"
	.ascii	"(word s){\n    static char *slots[4];\n    static size_t cap"
	.ascii	"s[4];\n    static int next = 0;\n\n    if (s == 0) return \""
	.ascii	"\";\n\n    size_t len = 0;\n    for (;; len++) {\n        wo"
	.ascii	"rd ch = b_char(s, (word)len);\n        if (ch == 004 || ch ="
	.ascii	"= 0) break;\n    }\n\n    int idx = next;\n    next = (next "
	.ascii	"+ 1) & 3; /* simple ring buffer to survive multiple args */\n"
	.ascii	"\n    size_t need = len + 1;\n    if (need > caps[idx]) {\n "
	.ascii	"       size_t ncap = need < 64 ? 64 : need;\n        char *n"
	.ascii	"b = (char*)realloc(slots[idx], ncap);\n        if (!nb) { fp"
	.ascii	"rintf(stderr, \"cstr: out of memory\\n\"); exit(1); }\n     "
	.ascii	"   slots[idx] = nb;\n        caps[idx] = ncap;\n    }\n\n   "
	.ascii	" for (size_t i = 0; i < len; i++) slots[idx][i] = (char)(b_c"
	.ascii	"har(s, (word)i) & 0xFF);\n    slots[idx][len] = 0;\n    retu"
	.ascii	"rn slots[idx];\n}\n\n/* Duplicate a B string into a freshly "
	.ascii	"allocated C string */\nstatic char *__b_dup_bstr(word s){\n "
	.ascii	"   size_t cap = 64;\n    char *buf = (char*)malloc(cap);\n  "
	.ascii	"  if (!buf) { fprintf(stderr, \"system: out of memory\\n\");"
	.ascii	" exit(1); }\n\n    size_t i = 0;\n    for (;;) {\n        wo"
	.ascii	"rd ch = b_char(s, (word)i);\n        if (ch == 004 || ch == "
	.ascii	"0) break;\n        if (i + 1 >= cap) {\n            size_t n"
	.ascii	"cap = cap * 2;\n            char *nbuf = (char*)realloc(buf,"
	.ascii	" ncap);\n            if (!nbuf) { free(buf); fprintf(stderr,"
	.ascii	" \"system: out of memory\\n\"); exit(1); }\n            buf "
	.ascii	"= nbuf;\n            cap = ncap;\n        }\n        buf[i++"
	.ascii	"] = (char)(ch & 0xFF);\n    }\n    buf[i] = 0;\n    return b"
	.ascii	"uf;\n}\n\nstatic void __b_setargs(int argc, char **argv){\n "
	.ascii	"   __b_argc = argc;\n    __b_argv = argv;\n\n    __b_argvb ="
	.ascii	" (word*)malloc(sizeof(word) * (size_t)argc);\n    if (!__b_a"
	.ascii	"rgvb) { fprintf(stderr, \"argv: out of memory\\n\"); exit(1)"
	.ascii	"; }\n\n    for (int i = 0; i < argc; i++){\n        __b_argv"
	.ascii	"b[i] = __b_pack_cstr(argv[i]);\n    }\n}\n\nstatic word b_ar"
	.ascii	"gc(void) { return (word)__b_argc; }\n\nstatic word b_argv(wo"
	.ascii	"rd i) {\n    int idx = (int)i;\n    if (idx < 0 || idx >= __"
	.ascii	"b_argc) return 0;\n    return __b_argvb[idx];\n}\n\nstatic w"
	.ascii	"ord b_reread(void) {\n    /* If no args, nothin"
	.ascii	"g to reread */\n    if (__b_argc <= 1) {\n        return 0;\n"
	.ascii	"    }\n\n    /* Compute total length of joined argv[0..] wit"
	.ascii	"h spaces + newline */\n    size_t total = 1; /* for trailing"
	.ascii	" newline */\n    for (int i = 0; i < __b_argc; i++) {\n     "
	.ascii	"   total += strlen(__b_argv[i]);\n        if (i + 1 < __b_ar"
	.ascii	"gc) total += 1; /* space */\n    }\n    \n    char *buf = (c"
	.ascii	"har*)malloc(total + 1);\n    if (!buf) { fprintf(stderr, \"r"
	.ascii	"eread: out of memory\\n\"); exit(1); }\n    \n    size_t pos"
	.ascii	" = 0;\n    for (int i = 0; i < __b_argc; i++) {\n        siz"
	.ascii	"e_t len = strlen(__b_argv[i]);\n        memcpy(buf + pos, __"
	.ascii	"b_argv[i], len);\n        pos += len;\n        if (i + 1 < _"
	.ascii	"_b_argc) buf[pos++] = ' ';\n    }\n    buf[pos++] = '\\n';\n"
	.ascii	"    buf[pos] = '\\0';\n    \n    int p[2];\n    if (pipe(p) "
	.ascii	"!= 0) { free(buf); fprintf(stderr, \"reread: pipe failed\\n\""
	.ascii	"); exit(1); }\n    ssize_t wn = write(p[1], buf, pos);\n    "
	.ascii	"(void)wn;\n    close(p[1]);\n    free(buf);\n    \n    /* Cl"
	.ascii	"ose previous rd fd if it wasn't the terminal */\n    if (rd_"
	.ascii	"fd != 0 && rd_fd != p[0]) close(rd_fd);\n    rd_fd = p[0];\n"
	.ascii	"    rd_unit = (word)0;\n    __b_sync_rd();\n    return 0;\n}"
	.ascii	"\n\n/* I/O functions */\nstatic word b_getchr(void) {\n    _"
	.ascii	"_b_sync_rd();\n    unsigned char c;\n    ssize_t n = read(rd"
	.ascii	"_fd, &c, 1);\n    if (n == 1) return (word)c;\n    if (rd_fd"
	.ascii	" != 0) {\n        close(rd_fd);\n        rd_fd = 0;\n       "
	.ascii	" rd_unit = -1;\n        return b_getchr();\n    }\n    retur"
	.ascii	"n (word)004; /* Return *e on EOF */\n}\nstatic word b_putchr"
	.ascii	"(word w) {\n    __b_sync_wr();\n    unsigned char c = (unsig"
	.ascii	"ned char)(w & 0xFF);\n    (void)write(wr_fd, &c, 1);\n    re"
	.ascii	"turn w;\n}\nstatic word b_putstr(word s) {\n    __b_sync_wr("
	.ascii	");\n    word i = 0;\n    for (;;) {\n        word ch = b_cha"
	.ascii	"r(s, i++);\n        if (ch == 004 || ch == 0) break;\n      "
	.ascii	"  b_putchar(ch);\n    }\n    return s;\n}\nstatic word b_get"
	.ascii	"str(word buf) {\n    __b_sync_rd();\n    size_t i = 0;\n    "
	.ascii	"unsigned char c;\n    for (;;) {\n        ssize_t n = read(r"
	.ascii	"d_fd, &c, 1);\n        if (n == 1 && c != '\\n' && c != '\\r"
	.ascii	"') {\n            b_lchar(buf, (word)i, (word"
	.ascii	")c);\n            i++;\n            continue;\n        }\n  "
	.ascii	"      if (n == 1) break; /* newline */\n        if (rd_fd !="
	.ascii	" 0) {\n            close(rd_fd);\n            rd_fd = 0;\n  "
	.ascii	"          rd_unit = -1;\n            continue; /* retry on t"
	.ascii	"erminal */\n        }\n        break; /* EOF */\n    }\n    "
	.ascii	"b_lchar(buf, (word)i, (word)004);\n    return buf;\n}\nstati"
	.ascii	"c word b_flush(void){\n    __b_sync_wr();\n    if (wr_fd == "
	.ascii	"1) {\n        fflush(stdout);\n    } else {\n        fsync(w"
	.ascii	"r_fd);\n    }\n    return 0;\n}\n\n#include <stdarg.h>\n\n/*"
	.ascii	" Print number in specified base (from B manual) */\nstatic v"
	.ascii	"oid b_printn_u(word n, word base) {\n    // recursion like o"
	.ascii	"ld implementations\n    word a = (word)((uword)n / (uword)ba"
	.ascii	"se);\n    if (a) b_printn_u(a, base);\n    b_putchar((word)("
	.ascii	"(uword)n % (uword)base) + '0');\n}\n\nstatic word b_printf(w"
	.ascii	"ord fmt, ...){\n    va_list ap;\n    va_start(ap, fmt);\n\n "
	.ascii	"   word i = 0;\n    for (;;){\n        word ch = b_char(fmt,"
	.ascii	" i++);\n        if (ch == 004 || ch == 0) break;  /* '*e' or"
	.ascii	" NUL terminator */\n        if (ch != '%'){ b_putchar(ch); c"
	.ascii	"ontinue; }\n\n        word code = b_char(fmt, i++);\n       "
	.ascii	" if (code == 004) break;\n\n        word arg = va_arg(ap, wo"
	.ascii	"rd);\n\n        switch ((int)code){\n        case 'd': {\n#i"
	.ascii	"f WORD_BITS == 16\n            int16_t v = (int16_t)arg;\n  "
	.ascii	"          if (v < 0){ b_putchar('-'); v = (int16_t)-v; }\n  "
	.ascii	"          if (v) b_printn_u((word)(uword)(uint16_t)v, 10);\n"
	.ascii	"#elif WORD_BITS == 32\n            int32_t v = (int32_t)arg;"
	.ascii	"\n            if (v < 0){ b_putchar('-'); v = -v; }\n       "
	.ascii	"     if (v) b_printn_u((word)(uword)(uint32_t)v, 10);\n#else"
	.ascii	"\n            word v = arg;\n            if (v < 0){ b_putch"
	.ascii	"ar('-'); v = -v; }\n            if (v) b_printn_u((word)(uwo"
	.ascii	"rd)v, 10);\n#endif\n            else b_putchar('0');\n      "
	.ascii	"      break;\n        }\n        case 'o': {\n#if WORD_BITS "
	.ascii	"== 16\n            uint16_t v = (uint16_t)arg;\n#elif WORD_B"
	.ascii	"ITS == 32\n            uint32_t v = (uint32_t)arg;\n#else\n "
	.ascii	"           uword v = (uword)arg;\n#endif\n            if (v)"
	.ascii	" b_printn_u((word)(uword)v, 8);\n     "
	.ascii	"       else b_putchar('0');\n            break;\n        }\n"
	.ascii	"        case 'u': {\n            uword v = (uword)arg;\n    "
	.ascii	"        if (v) b_printn_u((word)v, 10);\n            else b_"
	.ascii	"putchar('0');\n            break;\n        }\n        case '"
	.ascii	"p': {\n            uword v = (uword)arg;\n            b_putc"
	.ascii	"har('0'); b_putchar('x');\n            int started = 0;\n   "
	.ascii	"         for (int shift = (int)(sizeof(uword)*8 - 4); shift "
	.ascii	">= 0; shift -= 4) {\n                int nib = (int)((v >> s"
	.ascii	"hift) & 0xF);\n                if (!started && nib == 0 && s"
	.ascii	"hift > 0) continue;\n                started = 1;\n         "
	.ascii	"       b_putchar((word)(nib < 10 ? ('0' + nib) : ('a' + nib "
	.ascii	"- 10)));\n            }\n            if (!started) b_putchar"
	.ascii	"('0');\n            break;\n        }\n        case 'z': {\n"
	.ascii	"            word mod = b_char(fmt, i++);\n            if (mo"
	.ascii	"d == 'u') {\n                uword v = (uword)arg;\n        "
	.ascii	"        if (v) b_printn_u((word)v, 10);\n                els"
	.ascii	"e b_putchar('0');\n            } else if (mod == 'd') {\n   "
	.ascii	"             long v = (long)arg;\n                if (v < 0)"
	.ascii	" { b_putchar('-'); v = -v; }\n                if (v) b_print"
	.ascii	"n_u((word)(uword)v, 10);\n                else b_putchar('0'"
	.ascii	");\n            } else {\n                b_putchar('%'); b_"
	.ascii	"putchar('z'); b_putchar(mod);\n            }\n            br"
	.ascii	"eak;\n        }\n        case 'c':\n            b_putchar(ar"
	.ascii	"g);\n            break;\n        case 's': {\n            wo"
	.ascii	"rd j = 0;\n            for (;;){\n                word sc = "
	.ascii	"b_char(arg, j++);\n                if (sc == 004 || sc == 0)"
	.ascii	" break;  /* Handle both *e and NUL termination */\n         "
	.ascii	"       b_putchar(sc);\n            }\n            break;\n  "
	.ascii	"      }\n        default:\n            b_putchar('%'); b_put"
	.ascii	"char(code);\n            break;\n        }\n    }\n\n    va_"
	.ascii	"end(ap);\n    return 0;\n}\n\n/* File I/O functions - with a"
	.ascii	"ctual implementations */\n#include <fcntl.h>\nstatic word b_"
	.ascii	"open(word name, word mode){\n    const char *p = __b_cstr(na"
	.ascii	"me);\n    int flags = ((int)mode == 0) ? O_RDONLY : O_WRONLY"
	.ascii	";\n    return (word)open("
	.ascii	"p, flags);\n}\nstatic word b_openr(word fd, word name){\n   "
	.ascii	" char buf[512];\n    __b_bstr_to_cstr(name, buf, sizeof(buf)"
	.ascii	");\n    int target = (int)fd;\n    if (target < 0 || buf[0] "
	.ascii	"== '\\0') {\n        rd_fd = 0; rd_unit = -1; return 0;\n   "
	.ascii	" }\n    int newfd = open(buf, O_RDONLY);\n    if (rd_fd != 0"
	.ascii	" && rd_fd != target) close(rd_fd);\n    if (newfd < 0) { rd_"
	.ascii	"fd = -1; rd_unit = (word)target; return -1; }\n    if (newfd"
	.ascii	" != target) {\n        if (dup2(newfd, target) < 0) { close("
	.ascii	"newfd); return -1; }\n        close(newfd);\n        newfd ="
	.ascii	" target;\n    }\n    rd_fd = newfd;\n    rd_unit = (word)tar"
	.ascii	"get;\n    return (word)newfd;\n}\nstatic word b_openw(word f"
	.ascii	"d, word name){\n    char buf[512];\n    __b_bstr_to_cstr(nam"
	.ascii	"e, buf, sizeof(buf));\n    int target = (int)fd;\n    if (ta"
	.ascii	"rget < 0 || buf[0] == '\\0') {\n        wr_fd = 1; wr_unit ="
	.ascii	" -1; return 1;\n    }\n    int newfd = open(buf, O_WRONLY | "
	.ascii	"O_CREAT | O_TRUNC, 0666);\n    if (newfd < 0) return -1;\n  "
	.ascii	"  if (wr_fd != 1 && wr_fd != target && wr_fd != newfd) close"
	.ascii	"(wr_fd);\n    if (newfd != target) {\n        if (dup2(newfd"
	.ascii	", target) < 0) { close(newfd); return -1; }\n        close(n"
	.ascii	"ewfd);\n        newfd = target;\n    }\n    wr_fd = newfd;\n"
	.ascii	"    wr_unit = (word)target;\n    return (word)newfd;\n}\nsta"
	.ascii	"tic word b_close(word fd) {\n    int cfd = (int)fd;\n    wor"
	.ascii	"d r = (word)close(cfd);\n    if (r == 0) {\n        if (cfd "
	.ascii	"== rd_fd || cfd == (int)rd_unit) { rd_fd = 0; rd_unit = -1; "
	.ascii	"}\n        if (cfd == wr_fd || cfd == (int)wr_unit) { wr_fd "
	.ascii	"= 1; wr_unit = -1; }\n    }\n    return r;\n}\nstatic word b"
	.ascii	"_read(word fd, word buf, word n) {\n#if WORD_BITS == 16\n   "
	.ascii	" if (n < 0) return -1;\n    unsigned char *bytes = malloc(n "
	.ascii	"? (size_t)n : 1);\n    if (!bytes) return -1;\n    ssize_t c"
	.ascii	"ount = read((int)fd, bytes, (size_t)n);\n    for (ssize_t i "
	.ascii	"= 0; i < count; i++) b_lchar(buf, (word)i, bytes[i]);\n    f"
	.ascii	"ree(bytes);\n    return WVAL(count);\n#else\n    char *p = ("
	.ascii	"char*)B_CPTR(buf);\n    if ((size_t)n < sizeof(word)) memset"
	.ascii	"(p, 0, sizeof(word));\n    return (word)read((int)fd, p, (si"
	.ascii	"ze_t)n);\n#endif\n}\nstati"
	.ascii	"c word b_write(word fd, word buf, word n) {\n#if WORD_BITS ="
	.ascii	"= 16\n    if (n < 0) return -1;\n    unsigned char *bytes = "
	.ascii	"malloc(n ? (size_t)n : 1);\n    if (!bytes) return -1;\n    "
	.ascii	"for (word i = 0; i < n; i++) bytes[i] = (unsigned char)b_cha"
	.ascii	"r(buf, i);\n    ssize_t count = write((int)fd, bytes, (size_"
	.ascii	"t)n);\n    free(bytes);\n    return WVAL(count);\n#else\n   "
	.ascii	" return (word)write((int)fd, B_CPTR(buf), (size_t)n);\n#endi"
	.ascii	"f\n}\nstatic word b_creat(word name, word mode) {\n    const"
	.ascii	" char *p = __b_cstr(name);\n    return (word)creat(p, (mode_"
	.ascii	"t)mode);\n}\nstatic word b_seek(word fd, word offset, word w"
	.ascii	"hence) {\n    off_t r = lseek((int)fd, (off_t)offset, (int)w"
	.ascii	"hence);\n    return (r < 0) ? (word)-1 : (word)0;\n}\n\n/* P"
	.ascii	"rocess control functions - with actual implementations */\ns"
	.ascii	"tatic word b_fork(void) {\n    return (word)fork();\n}\nstat"
	.ascii	"ic word __b_wait_status;\n\nstatic word b_wait(void) {\n    "
	.ascii	"int st = 0;\n    pid_t pid = wait(&st);\n    __b_wait_status"
	.ascii	" = (word)st;\n    return (word)pid;\n}\n/* B72 section 8 pas"
	.ascii	"ses exactly count argument strings, including arg0. */\nstat"
	.ascii	"ic word b_execv(word path, word argv, word count) {\n    if "
	.ascii	"(count < 0 || count > 255 || (count && !argv)) return -1;\n "
	.ascii	"   char *name = __b_dup_bstr(path);\n    if (!name) return -"
	.ascii	"1;\n    char *arguments[256];\n    word *values = count ? (w"
	.ascii	"ord*)B_CPTR(argv) : NULL;\n    size_t n = (size_t)count, i ="
	.ascii	" 0;\n    for (; i < n; i++) {\n        if (!values[i]) break"
	.ascii	";\n        arguments[i] = __b_dup_bstr(values[i]);\n        "
	.ascii	"if (!arguments[i]) break;\n    }\n    if (i == n) {\n       "
	.ascii	" arguments[n] = NULL;\n        execv(name, arguments);\n    "
	.ascii	"}\n    while (i) free(arguments[--i]);\n    free(name);\n   "
	.ascii	" return -1;\n}\n\nstatic word b_execl(word path, ...) {\n   "
	.ascii	" char *name = __b_dup_bstr(path);\n    if (!name) return -1;"
	.ascii	"\n    char *arguments[256];\n    size_t n = 0;\n    int comp"
	.ascii	"lete = 0;\n    va_list ap;\n    va_start(ap, path);\n    whi"
	.ascii	"le (n < 255) {\n        word value = va_arg(ap, word);\n    "
	.ascii	"    if (!value) { complete = 1; break; }\n        arguments["
	.ascii	"n] = __b_dup_bstr(value);\n "
	.ascii	"       if (!arguments[n]) break;\n        n++;\n    }\n    v"
	.ascii	"a_end(ap);\n    if (complete) {\n        arguments[n] = NULL"
	.ascii	";\n        execv(name, arguments);\n    }\n    while (n) fre"
	.ascii	"e(arguments[--n]);\n    free(name);\n    return -1;\n}\n\nst"
	.ascii	"atic word b_system(word cmd) {\n    /* Split arguments witho"
	.ascii	"ut invoking a shell or expanding their contents. */\n    cha"
	.ascii	"r *line = __b_dup_bstr(cmd);\n    if (!line) return -1;\n   "
	.ascii	" char *argv[128];\n    size_t argc = 0;\n    char *p = line,"
	.ascii	" *q = line;\n    while (*p) {\n        while (*p && isspace("
	.ascii	"(unsigned char)*p)) p++;\n        if (!*p) break;\n        i"
	.ascii	"f (argc + 1 >= sizeof(argv)/sizeof(argv[0])) { free(line); r"
	.ascii	"eturn -1; }\n        argv[argc++] = q;\n        int quote = "
	.ascii	"0;\n        while (*p && (quote || !isspace((unsigned char)*"
	.ascii	"p))) {\n            unsigned char c = (unsigned char)*p++;\n"
	.ascii	"            if (c == '\\\\' && quote != '\\'') {\n          "
	.ascii	"      if (!*p) { free(line); return -1; }\n                *"
	.ascii	"q++ = *p++;\n            } else if (c == '\\'' || c == '\"')"
	.ascii	" {\n                if (!quote) quote = c;\n                "
	.ascii	"else if (quote == c) quote = 0;\n                else *q++ ="
	.ascii	" (char)c;\n            } else *q++ = (char)c;\n        }\n  "
	.ascii	"      if (quote) { free(line); return -1; }\n        if (*p)"
	.ascii	" p++;\n        *q++ = 0;\n    }\n    if (argc == 0) { free(l"
	.ascii	"ine); return -1; }\n    argv[argc] = NULL;\n    pid_t pid = "
	.ascii	"fork();\n    if (pid == 0) {\n        execvp(argv[0], argv);"
	.ascii	"\n        _exit(127);\n    }\n    if (pid < 0) { free(line);"
	.ascii	" return -1; }\n    int st = 0;\n    pid_t w;\n    do { w = w"
	.ascii	"aitpid(pid, &st, 0); } while (w < 0 && errno == EINTR);\n   "
	.ascii	" free(line);\n    if (w < 0) return -1;\n    return (word)st"
	.ascii	";\n}\n\nstatic word b_usleep(word usec) {\n    usleep((useco"
	.ascii	"nds_t)usec);\n    return 0;\n}\n\nstatic word b_callf_dispat"
	.ascii	"ch(int nargs, word name, ...) {\n    static int __b_callf_dl"
	.ascii	"_done = 0;\n    if (!__b_callf_dl_done) {\n        __b_callf"
	.ascii	"_dl_done = 1;\n        const char *env = getenv(\"B_CALLF_LI"
	.ascii	"B\");\n        if (env && *env) {\n            const char *p"
	.ascii	" = env;\n            while (*p) {\n  "
	.ascii	"              const char *start = p;\n                while "
	.ascii	"(*p && *p != ':') p++;\n                size_t len = (size_t"
	.ascii	")(p - start);\n                if (len) {\n                 "
	.ascii	"   char *path = (char*)malloc(len + 1);\n                   "
	.ascii	" if (path) {\n                        memcpy(path, start, le"
	.ascii	"n);\n                        path[len] = '\\0';\n           "
	.ascii	"             (void)dlopen(path, RTLD_NOW | RTLD_GLOBAL);\n  "
	.ascii	"                      free(path);\n                    }\n  "
	.ascii	"              }\n                if (*p == ':') p++;\n      "
	.ascii	"      }\n        }\n    }\n    if (nargs < 0 || nargs > 10) "
	.ascii	"return -1;\n    if (name == 0) return -1;\n \n    char sym[2"
	.ascii	"56];\n    __b_bstr_to_cstr(name, sym, sizeof(sym));\n \n    "
	.ascii	"void *fn = dlsym(RTLD_DEFAULT, sym);\n    if (!fn) {\n      "
	.ascii	"  size_t len = strlen(sym);\n        if (len + 2 < sizeof(sy"
	.ascii	"m)) {\n            sym[len] = '_'; sym[len + 1] = '\\0';\n  "
	.ascii	"          fn = dlsym(RTLD_DEFAULT, sym);\n            sym[le"
	.ascii	"n] = '\\0';\n        }\n    }\n    if (!fn) return -1;\n \n "
	.ascii	"   void *args[10] = {0};\n    va_list ap;\n    va_start(ap, "
	.ascii	"name);\n    for (int i = 0; i < nargs && i < 10; i++) {\n   "
	.ascii	"     word w = va_arg(ap, word);\n        args[i] = B_CPTR(w)"
	.ascii	";\n    }\n    va_end(ap);\n \n    word r = 0;\n    switch (n"
	.ascii	"args) {\n    case 0: r = ((word (*)(void))fn)(); break;\n   "
	.ascii	" case 1: r = ((word (*)(void*))fn)(args[0]); break;\n    cas"
	.ascii	"e 2: r = ((word (*)(void*, void*))fn)(args[0], args[1]); bre"
	.ascii	"ak;\n    case 3: r = ((word (*)(void*, void*, void*))fn)(arg"
	.ascii	"s[0], args[1], args[2]); break;\n    case 4: r = ((word (*)("
	.ascii	"void*, void*, void*, void*))fn)(args[0], args[1], args[2], a"
	.ascii	"rgs[3]); break;\n    case 5: r = ((word (*)(void*, void*, vo"
	.ascii	"id*, void*, void*))fn)(args[0], args[1], args[2], args[3], a"
	.ascii	"rgs[4]); break;\n    case 6: r = ((word (*)(void*, void*, vo"
	.ascii	"id*, void*, void*, void*))fn)(args[0], args[1], args[2], arg"
	.ascii	"s[3], args[4], args[5]); break;\n    case 7: r = ((word (*)("
	.ascii	"void*, void*, void*, void*, void*, void*, void*))fn)(args[0]"
	.ascii	", args[1], args[2], args[3], args[4], args[5], args[6]); bre"
	.ascii	"ak;\n    case 8"
	.ascii	": r = ((word (*)(void*, void*, void*, void*, void*, void*, v"
	.ascii	"oid*, void*))fn)(args[0], args[1], args[2], args[3], args[4]"
	.ascii	", args[5], args[6], args[7]); break;\n    case 9: r = ((word"
	.ascii	" (*)(void*, void*, void*, void*, void*, void*, void*, void*,"
	.ascii	" void*))fn)(args[0], args[1], args[2], args[3], args[4], arg"
	.ascii	"s[5], args[6], args[7], args[8]); break;\n    case 10: r = ("
	.ascii	"(word (*)(void*, void*, void*, void*, void*, void*, void*, v"
	.ascii	"oid*, void*, void*))fn)(args[0], args[1], args[2], args[3], "
	.ascii	"args[4], args[5], args[6], args[7], args[8], args[9]); break"
	.ascii	";\n    default: return -1;\n    }\n    return r;\n}\n\n/* Sy"
	.ascii	"stem functions - with actual implementations where possible "
	.ascii	"*/\nstatic word b_time(word tvp) {\n    time_t now = time(NU"
	.ascii	"LL);\n    if (tvp) {\n        uint16_t lo = (uint16_t)(now &"
	.ascii	" 0xFFFF);\n        uint16_t hi = (uint16_t)((now >> 16) & 0x"
	.ascii	"FFFF);\n        word *tv = (word*)B_CPTR(tvp);\n        tv[0"
	.ascii	"] = (word)(uword)lo;\n        tv[1] = (word)(uword)hi;\n    "
	.ascii	"}\n    return 0;\n}\n\nstatic word b_ctime(word tvp) {\n    "
	.ascii	"static word bufw[32];\n    word bp = B_PTR_N(bufw, sizeof(bu"
	.ascii	"fw));\n    word *tv = (word*)B_CPTR(tvp);\n    time_t t = (t"
	.ascii	"ime_t)((uint16_t)tv[0]) | ((time_t)((uint16_t)tv[1]) << 16);"
	.ascii	"\n\n    const char *cs = ctime(&t);\n    if (!cs) return 0;\n"
	.ascii	"\n    size_t i = 0;\n    while (cs[i] && cs[i] != '\\n' && i"
	.ascii	" < 63) {\n        b_lchar(bp, (word)i, (word)(unsigned char)"
	.ascii	"cs[i]);\n        i++;\n    }\n    b_lchar(bp, (word)i, 004);"
	.ascii	"\n    return bp;\n}\nstatic word b_getuid(void) {\n    retur"
	.ascii	"n (word)getuid();\n}\nstatic word b_chdir(word path) {\n    "
	.ascii	"const char *p = __b_cstr(path);\n    return (word)chdir(p);\n"
	.ascii	"}\nstatic word b_unlink(word path) {\n    const char *p = __"
	.ascii	"b_cstr(path);\n    return (word)unlink(p);\n}\n\n/* System f"
	.ascii	"unctions with actual implementations */\nstatic word b_chmod"
	.ascii	"(word path, word mode) {\n    const char *p = __b_cstr(path)"
	.ascii	";\n    return (word)chmod(p, (mode_t)mode);\n}\nstatic word "
	.ascii	"b_chown(word path, word owner) {\n    const char *p = __b_cs"
	.ascii	"tr(path);\n    return (word)chown(p, (uid_t)owner, (gid_t)-1"
	.ascii	");\n}\nstatic word"
	.ascii	" b_link(word old, word new) {\n    const char *o = __b_cstr("
	.ascii	"old);\n    const char *n = __b_cstr(new);\n    return (word)"
	.ascii	"link(o, n);\n}\nstatic word b_stat(word path, word bufp) {\n"
	.ascii	"    const char *p = __b_cstr(path);\n    struct stat st;\n  "
	.ascii	"  if (stat(p, &st) != 0) return -1;\n    if (bufp) {\n      "
	.ascii	"  unsigned char *b = (unsigned char*)B_CPTR(bufp);\n        "
	.ascii	"for (int i = 0; i < 20*sizeof(word); i++) b[i] = 0;\n       "
	.ascii	" size_t n = sizeof(st);\n        if (n > 20*sizeof(word)) n "
	.ascii	"= 20*sizeof(word);\n        memcpy(b, &st, n);\n    }\n    r"
	.ascii	"eturn 0;\n}\n\nstatic word b_fstat(word fd, word bufp) {\n  "
	.ascii	"  struct stat st;\n    if (fstat((int)fd, &st) != 0) return "
	.ascii	"-1;\n    if (bufp) {\n        unsigned char *b = (unsigned c"
	.ascii	"har*)B_CPTR(bufp);\n        for (int i = 0; i < 20*sizeof(wo"
	.ascii	"rd); i++) b[i] = 0;\n        size_t n = sizeof(st);\n       "
	.ascii	" if (n > 20*sizeof(word)) n = 20*sizeof(word);\n        memc"
	.ascii	"py(b, &st, n);\n    }\n    return 0;\n}\nstatic word b_setui"
	.ascii	"d(word uid) {\n    return (word)setuid((uid_t)uid);\n}\nstat"
	.ascii	"ic word b_makdir(word path, word mode) {\n    const char *p "
	.ascii	"= __b_cstr(path);\n    return (word)mkdir(p, (mode_t)mode);\n"
	.ascii	"}\n\n/* printn(number, base) - print number in specified bas"
	.ascii	"e (from B manual) */\nstatic word b_printn(word n, word base"
	.ascii	") {\n    // Handle negative numbers for decimal only\n    if"
	.ascii	" (base == 10 && (int16_t)n < 0) {\n        b_putchar('-');\n"
	.ascii	"        n = (word)(-(int16_t)n);\n    }\n    b_printn_u(n, b"
	.ascii	"ase);\n    return n;\n}\nstatic word b_putnum(word n) {\n   "
	.ascii	" b_printn(n, (word)10);\n    return n;\n}\nstatic volatile s"
	.ascii	"ig_atomic_t __b_got_intr = 0;\n\nstatic void __b_sigint(int "
	.ascii	"sig){ (void)sig; __b_got_intr = 1; }\n\nstatic word b_gtty(w"
	.ascii	"ord fd, word ttstat){\n    struct termios t;\n    if (tcgeta"
	.ascii	"ttr((int)fd, &t) < 0) return -1;\n\n    word *vec = (word*)B"
	.ascii	"_CPTR(ttstat);\n    vec[0] = (word)t.c_iflag;\n    vec[1] = "
	.ascii	"(word)t.c_oflag;\n    vec[2] = (word)t.c_lflag;\n    return "
	.ascii	"0;\n}\n\nstatic word b_stty(word fd, word ttstat){\n    stru"
	.ascii	"ct termios t;\n    if (tcgetattr((int)fd, &t) < 0) return -1"
	.ascii	";\n\n    word *vec = (word*)B_C"
	.ascii	"PTR(ttstat);\n    t.c_iflag = (tcflag_t)vec[0];\n    t.c_ofl"
	.ascii	"ag = (tcflag_t)vec[1];\n    t.c_lflag = (tcflag_t)vec[2];\n "
	.ascii	"   return (word)tcsetattr((int)fd, TCSANOW, &t);\n}\nstatic "
	.ascii	"word b_intr(word on) {\n    /* Set up interrupt handling */\n"
	.ascii	"    /* on != 0: catch interrupts, on =="
	.string	" 0: restore default */\n    if (on) {\n        __b_got_intr = 0;\n        if (signal(SIGINT, __b_sigint) == SIG_ERR) return -1;\n    } else {\n        if (signal(SIGINT, SIG_DFL) == SIG_ERR) return -1;\n    }\n    return 0;\n}\n\n/* Builtin aliases for B source */\n\n"
	.section	.rodata.str1.1
.LC155:
	.string	"static void __b_init(void) {\n"
	.section	.rodata.str1.8
	.align 8
.LC156:
	.string	"    setvbuf(stdout, NULL, _IONBF, 0);\n"
	.section	.rodata.str1.1
.LC157:
	.string	"static word __%s_blob[%zu];\n"
.LC158:
	.string	"static word __%s_store[%zu];\n"
.LC159:
	.string	"static word %s;\n"
.LC160:
	.string	"}\n\n"
.LC161:
	.string	"    %s = "
.LC162:
	.string	"    %s = __%s_blob[0];\n"
	.section	.rodata.str1.8
	.align 8
.LC163:
	.string	"    %s = B_PTR_N(__%s_blob, sizeof(__%s_blob));\n"
	.align 8
.LC164:
	.string	"    %s = B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC165:
	.string	"__%s_store"
.LC166:
	.string	"static word __b_user_main("
.LC167:
	.string	");\n"
.LC168:
	.string	"word "
.LC169:
	.string	"word"
.LC170:
	.string	"word __b_user_main("
	.section	.rodata.str1.8
	.align 8
.LC171:
	.string	"int main(int argc, char **argv){\n"
	.section	.rodata.str1.1
.LC172:
	.string	"    __b_setargs(argc, argv);\n"
.LC173:
	.string	"    __b_init();\n"
	.section	.rodata.str1.8
	.align 8
.LC174:
	.string	"    return (int)__b_user_main();\n"
	.align 8
.LC175:
	.string	"    return (int)__b_user_main((word)argc);\n"
	.align 8
.LC176:
	.string	"    return (int)__b_user_main((word)argc, B_PTR_N(__b_argvb, sizeof(word) * (size_t)argc));\n"
	.section	.rodata.str1.1
.LC177:
	.string	"__%s_blob"
	.text
	.p2align 4
	.globl	emit_program_c
	.type	emit_program_c, @function
emit_program_c:
.LFB55:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pxor	%xmm0, %xmm0
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movl	%ecx, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	%r9d, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	movq	%rsi, %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$296, %rsp
	.cfi_def_cfa_offset 352
	movl	%ecx, current_byteptr(%rip)
	movq	%rdx, (%rsp)
	movl	%r9d, current_word_bits(%rip)
	movq	$0, string_pool(%rip)
	movq	$0, 8+name_map(%rip)
	movups	%xmm0, 8+string_pool(%rip)
	call	collect_strings_program
	movl	g_use_curses(%rip), %ecx
	testl	%ecx, %ecx
	jne	.L1458
.L1306:
	movq	%rbp, %rcx
	movl	$1546, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbp, %rdi
	setne	%dl
	leaq	.LC149(%rip), %rsi
	leaq	32(%rsp), %r13
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%r12d, %edx
	movq	%rbp, %rdi
	xorl	%eax, %eax
	leaq	.LC150(%rip), %rsi
	call	fprintf@PLT
	movq	%rbp, %rcx
	movl	$1441, %edx
	movl	$1, %esi
	leaq	.LC151(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC152(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r13, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbp, %rcx
	movl	$24, %edx
	movl	$1, %esi
	leaq	.LC153(%rip), %rdi
	movq	%rax, %r12
	call	fwrite@PLT
	movq	32(%rsp), %rdx
	movq	%rbp, %rcx
	movq	%r12, %rdi
	movl	$1, %esi
	call	fwrite@PLT
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	movq	%r12, %rdi
	call	free@PLT
	movq	%rbp, %rcx
	movl	$26528, %edx
	movl	$1, %esi
	leaq	.LC154(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1459
.L1307:
	xorl	%r12d, %r12d
	cmpq	$0, 8(%rbx)
	jne	.L1308
	jmp	.L1338
	.p2align 4,,10
	.p2align 3
.L1311:
	cmpl	$3, %eax
	je	.L1460
	cmpl	$2, %eax
	je	.L1461
.L1312:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L1338
.L1308:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rdx
	movl	(%rdx), %eax
	testl	%eax, %eax
	jne	.L1311
	movq	8(%rdx), %rsi
	movq	(%rsp), %r8
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbp, %rdi
	addq	$1, %r12
	call	emit_stmt
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	8(%rbx), %r12
	jb	.L1308
	.p2align 4
	.p2align 3
.L1338:
	movq	%rbp, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC155(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$38, %edx
	movl	$1, %esi
	leaq	.LC156(%rip), %rdi
	call	fwrite@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L1309
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	emit_global_regions.part.0
.L1309:
	xorl	%r12d, %r12d
	cmpq	$0, 8(%rbx)
	jne	.L1339
	jmp	.L1358
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1343:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L1358
.L1339:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$2, (%rax)
	jne	.L1343
	movq	8(%rax), %r14
	movq	8(%r14), %rdi
	call	get_mangled_name
	movq	%rax, %r15
	movl	16(%r14), %eax
	testl	%eax, %eax
	jne	.L1344
	movq	48(%r14), %rax
	testq	%rax, %rax
	je	.L1343
	movl	(%rax), %eax
	testl	%eax, %eax
	jne	.L1343
	movq	%r15, %rdx
	leaq	.LC161(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r14), %rax
.L1457:
	movq	16(%rax), %rsi
	movq	(%rsp), %rdx
	movq	%rbp, %rdi
	addq	$1, %r12
	call	emit_ival_expr
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC103(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%rbx), %r12
	jb	.L1339
	.p2align 4
	.p2align 3
.L1358:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC160(%rip), %rdi
	leaq	.LC169(%rip), %r15
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	emit_known_external_function_prototypes
	cmpq	$0, 8(%rbx)
	jne	.L1340
	jmp	.L1341
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1361:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L1341
.L1340:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$1, (%rax)
	jne	.L1361
	movq	8(%rax), %r14
	leaq	.LC22(%rip), %rsi
	movq	(%r14), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1362
	leaq	.LC23(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1363
.L1362:
	movq	%rbp, %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC166(%rip), %rdi
	call	fwrite@PLT
.L1366:
	xorl	%r13d, %r13d
	cmpq	$0, 16(%r14)
	jne	.L1364
	jmp	.L1367
	.p2align 4,,10
	.p2align 3
.L1462:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC61(%rip), %rdi
	call	fwrite@PLT
.L1364:
	movq	%rbp, %rcx
	movl	$4, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
	addq	$1, %r13
	cmpq	16(%r14), %r13
	jb	.L1462
.L1367:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC167(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%rbx), %r12
	jb	.L1340
	.p2align 4
	.p2align 3
.L1341:
	movq	%rbp, %rsi
	movl	$10, %edi
	xorl	%r12d, %r12d
	call	fputc@PLT
	cmpq	$0, 8(%rbx)
	movq	$0, 16(%rsp)
	movl	$0, 8(%rsp)
	je	.L1305
	.p2align 5
	.p2align 4
	.p2align 3
.L1359:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$1, (%rax)
	je	.L1463
.L1369:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jb	.L1359
	movl	8(%rsp), %edi
	testl	%edi, %edi
	jne	.L1464
.L1305:
	addq	$296, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
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
.L1461:
	.cfi_restore_state
	movq	8(%rdx), %r15
	movq	8(%r15), %rdi
	call	get_mangled_name
	movq	%rax, %r14
	movl	16(%r15), %eax
	cmpl	$1, %eax
	jne	.L1315
	movq	48(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1386
	cmpl	$1, (%rdi)
	jne	.L1386
	movq	24(%rdi), %r10
	cmpq	$1, %r10
	jne	.L1317
	movq	16(%rdi), %rax
	movq	(%rax), %rax
	movl	(%rax), %edx
	testl	%edx, %edx
	jne	.L1317
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L1317
	cmpl	$1, (%rax)
	je	.L1456
.L1317:
	call	edge_tail_words_top
	leaq	(%r10,%rax), %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	jmp	.L1316
	.p2align 4,,10
	.p2align 3
.L1344:
	cmpl	$1, %eax
	je	.L1465
	cmpl	$2, %eax
	jne	.L1343
	movq	%r15, %r8
	movq	%r15, %rcx
	movq	%r15, %rdx
	movq	%rbp, %rdi
	leaq	.LC164(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r14), %rax
	testq	%rax, %rax
	je	.L1343
	cmpl	$1, (%rax)
	jne	.L1343
	movl	32(%r14), %r10d
	movq	24(%rax), %r8
	testl	%r10d, %r10d
	jne	.L1354
	movq	24(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1354
	movq	$0, 32(%rsp)
	movq	%r13, %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1354
	movq	32(%rsp), %rax
	xorl	%edx, %edx
	testq	%rax, %rax
	cmovs	%rdx, %rax
	addq	$1, %rax
	cmpq	%rax, %r8
	cmovb	%rax, %r8
.L1353:
	movq	%r15, %rcx
	movl	$256, %esi
	movq	%r13, %rdi
	movq	%r8, 8(%rsp)
	leaq	.LC165(%rip), %rdx
	xorl	%eax, %eax
	call	snprintf@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 360
	movq	48(%r14), %rcx
	xorl	%edx, %edx
	pushq	8(%rsp)
	.cfi_def_cfa_offset 368
	movq	24(%rsp), %r8
	movq	%r13, %rsi
	movq	%rbp, %rdi
	movl	$2, %r9d
	call	emit_edge_list_init
	popq	%r8
	.cfi_def_cfa_offset 360
	popq	%r9
	.cfi_def_cfa_offset 352
	jmp	.L1343
	.p2align 4,,10
	.p2align 3
.L1460:
	movq	8(%rdx), %r14
	leaq	.LC24(%rip), %rdi
	movq	%rbp, %rcx
	movl	$12, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1314
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1314:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC103(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1312
	.p2align 4,,10
	.p2align 3
.L1463:
	movq	8(%rax), %r15
	leaq	.LC22(%rip), %rsi
	movq	(%r15), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1370
	leaq	.LC23(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1371
.L1370:
	movq	16(%r15), %rax
	movq	%rbp, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC170(%rip), %rdi
	movq	%rax, 16(%rsp)
	call	fwrite@PLT
	movl	$1, 8(%rsp)
.L1372:
	xorl	%r14d, %r14d
	cmpq	$0, 16(%r15)
	leaq	.LC168(%rip), %r13
	jne	.L1374
	jmp	.L1376
	.p2align 4,,10
	.p2align 3
.L1466:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC61(%rip), %rdi
	call	fwrite@PLT
.L1374:
	movq	%r13, %rdi
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r15), %rax
	movq	(%rax,%r14,8), %rdi
	testq	%rdi, %rdi
	je	.L1375
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1375:
	addq	$1, %r14
	cmpq	16(%r15), %r14
	jb	.L1466
.L1376:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC111(%rip), %rdi
	call	fwrite@PLT
	movq	(%rsp), %rdx
	movq	%r15, %rsi
	movq	%rbp, %rdi
	call	emit_function_body
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1369
	.p2align 4,,10
	.p2align 3
.L1315:
	cmpl	$2, %eax
	je	.L1467
	movl	4(%r15), %eax
	movq	%r14, %rdx
	testl	%eax, %eax
	je	.L1337
	leaq	.LC159(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1312
	.p2align 4,,10
	.p2align 3
.L1386:
	movl	$1, %ecx
.L1316:
	movq	%r14, %rdx
	leaq	.LC157(%rip), %rsi
.L1455:
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L1456:
	movq	%r14, %rdx
	leaq	.LC123(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1312
	.p2align 4,,10
	.p2align 3
.L1465:
	movq	48(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1348
	cmpl	$1, (%rdi)
	je	.L1468
.L1348:
	movq	%r15, %rcx
	movq	%r15, %rdx
	leaq	.LC162(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1343
	.p2align 4,,10
	.p2align 3
.L1464:
	movq	%rbp, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC171(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC172(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC173(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%rsp)
	je	.L1380
	cmpq	$1, 16(%rsp)
	je	.L1469
	cmpq	$2, 16(%rsp)
	jne	.L1380
	movq	%rbp, %rcx
	movl	$92, %edx
	movl	$1, %esi
	leaq	.LC176(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1378
	.p2align 4,,10
	.p2align 3
.L1458:
	movq	%rbp, %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC147(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1306
	.p2align 4,,10
	.p2align 3
.L1459:
	movq	%rbp, %rdi
	call	emit_string_pool
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1307
	.p2align 4,,10
	.p2align 3
.L1363:
	leaq	.LC168(%rip), %r13
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1365
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1365:
	movq	%rbp, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1366
	.p2align 4,,10
	.p2align 3
.L1380:
	movq	%rbp, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC174(%rip), %rdi
	call	fwrite@PLT
.L1378:
	addq	$296, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC120(%rip), %rdi
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
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L1467:
	.cfi_restore_state
	movq	48(%r15), %r8
	movl	32(%r15), %eax
	testq	%r8, %r8
	je	.L1470
	cmpl	$1, (%r8)
	je	.L1322
	testl	%eax, %eax
	jne	.L1320
	movq	24(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1320
	movq	$0, 32(%rsp)
	movq	%r13, %rsi
	call	try_eval_const_expr
	movl	$1, %ecx
	testl	%eax, %eax
	je	.L1324
	movq	32(%rsp), %rax
	leaq	1(%rax), %rcx
	testq	%rax, %rax
	movl	$1, %eax
	cmovs	%rax, %rcx
.L1331:
	cmpl	$1, (%r8)
	jne	.L1324
.L1336:
	movq	%r8, %rdi
	movq	%rcx, 8(%rsp)
	call	edge_tail_words_top
	movq	8(%rsp), %rcx
	addq	%rax, %rcx
	movl	$1, %eax
	cmove	%rax, %rcx
	jmp	.L1324
	.p2align 4,,10
	.p2align 3
.L1337:
	leaq	.LC123(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1312
	.p2align 4,,10
	.p2align 3
.L1371:
	leaq	.LC168(%rip), %r13
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1373
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1373:
	movq	%rbp, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1372
.L1470:
	testl	%eax, %eax
	je	.L1471
.L1320:
	movl	$1, %ecx
.L1324:
	movq	%r14, %rdx
	leaq	.LC158(%rip), %rsi
	jmp	.L1455
.L1468:
	movq	24(%rdi), %rax
	movq	%rax, 8(%rsp)
	cmpq	$1, %rax
	je	.L1472
	call	edge_tail_words_top
	leaq	.LC177(%rip), %rdx
	movl	$256, %esi
	movq	%r13, %rdi
	movq	%rax, %r10
	movq	8(%rsp), %rax
	movq	%r10, 24(%rsp)
	leaq	(%rax,%r10), %rcx
	xorl	%eax, %eax
	movq	%rcx, 16(%rsp)
	movq	%r15, %rcx
	call	snprintf@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 360
	movq	48(%r14), %rcx
	xorl	%edx, %edx
	pushq	8(%rsp)
	.cfi_def_cfa_offset 368
	movq	24(%rsp), %r8
	movq	%r13, %rsi
	movq	%rbp, %rdi
	movl	$2, %r9d
	call	emit_edge_list_init
	popq	%rcx
	.cfi_def_cfa_offset 360
	popq	%rsi
	.cfi_def_cfa_offset 352
	cmpq	$1, 16(%rsp)
	movq	24(%rsp), %r10
	je	.L1348
	cmpq	$1, 8(%rsp)
	ja	.L1383
	testq	%r10, %r10
	je	.L1348
.L1383:
	movq	%r15, %r8
	movq	%r15, %rcx
	movq	%r15, %rdx
	movq	%rbp, %rdi
	leaq	.LC163(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1343
.L1469:
	movq	%rbp, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC175(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1378
.L1471:
	movq	24(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1320
	movq	$0, 32(%rsp)
	movq	%r13, %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1320
	movq	32(%rsp), %rax
	xorl	%edx, %edx
	testq	%rax, %rax
	cmovs	%rdx, %rax
	leaq	1(%rax), %rcx
	jmp	.L1324
.L1322:
	movq	24(%r8), %rcx
	testl	%eax, %eax
	jne	.L1454
	movq	24(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1454
	movq	%r13, %rsi
	movq	%rcx, 8(%rsp)
	movq	$0, 32(%rsp)
	call	try_eval_const_expr
	movq	8(%rsp), %rcx
	testl	%eax, %eax
	je	.L1333
	movq	32(%rsp), %rsi
	testq	%rcx, %rcx
	movl	$1, %edx
	cmovne	%rcx, %rdx
	leaq	1(%rsi), %rax
	cmpq	%rax, %rcx
	cmovnb	%rcx, %rax
	testq	%rsi, %rsi
	movq	%rdx, %rcx
	cmovns	%rax, %rcx
	jmp	.L1331
.L1354:
	testq	%r8, %r8
	movl	$1, %eax
	cmove	%rax, %r8
	jmp	.L1353
.L1472:
	movq	16(%rdi), %rax
	movq	(%rax), %rax
	movl	(%rax), %r11d
	testl	%r11d, %r11d
	jne	.L1350
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L1350
	cmpl	$1, (%rax)
	je	.L1473
.L1350:
	call	edge_tail_words_top
	movq	%r15, %rcx
	movl	$256, %esi
	movq	%r13, %rdi
	movq	%rax, 8(%rsp)
	leaq	.LC177(%rip), %rdx
	xorl	%eax, %eax
	call	snprintf@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 360
	movq	48(%r14), %rcx
	xorl	%edx, %edx
	pushq	8(%rsp)
	.cfi_def_cfa_offset 368
	movl	$2, %r9d
	movq	%r13, %rsi
	movq	%rbp, %rdi
	movl	$1, %r8d
	call	emit_edge_list_init
	popq	%rax
	.cfi_def_cfa_offset 360
	popq	%rdx
	.cfi_def_cfa_offset 352
	movq	8(%rsp), %r10
	testq	%r10, %r10
	jne	.L1383
	jmp	.L1348
	.p2align 4,,10
	.p2align 3
.L1454:
	testq	%rcx, %rcx
	movl	$1, %eax
	cmove	%rax, %rcx
	jmp	.L1336
.L1333:
	testq	%rcx, %rcx
	jne	.L1331
	movl	$1, %ecx
	jmp	.L1336
	.p2align 4,,10
	.p2align 3
.L1473:
	movq	%r15, %rdx
	leaq	.LC161(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r14), %rax
	movq	16(%rax), %rax
	movq	(%rax), %rax
	jmp	.L1457
	.cfi_endproc
.LFE55:
	.size	emit_program_c, .-emit_program_c
	.section	.rodata.str1.8
	.align 8
.LC178:
	.string	"/* Generated by BCC - B Compiler */\n"
	.section	.rodata.str1.1
.LC179:
	.string	"#include \"libb.h\"\n\n"
	.section	.rodata.str1.8
	.align 8
.LC180:
	.string	"#include <ncurses.h>\n#include <panel.h>\n\n"
	.align 8
.LC181:
	.string	"\nstatic void __b_init_file_%p(void) {\n"
	.section	.rodata.str1.1
.LC182:
	.string	"    __b_init_file_%p();\n"
	.section	.rodata.str1.8
	.align 8
.LC183:
	.string	"    word *__b_argvb_ptr = (word*)B_CPTR(b_argv(0));\n"
	.align 8
.LC184:
	.string	"    return (int)__b_user_main((word)argc, B_PTR(__b_argvb_ptr - 1));\n"
	.align 8
.LC185:
	.string	"void __b_init_file_%p_export(void) __attribute__((constructor));\n"
	.align 8
.LC186:
	.string	"void __b_init_file_%p_export(void) { __b_init_file_%p(); }\n"
	.text
	.p2align 4
	.globl	emit_program_c_ext
	.type	emit_program_c_ext, @function
emit_program_c_ext:
.LFB56:
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
	movl	%ecx, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	%r9d, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$296, %rsp
	.cfi_def_cfa_offset 352
	movl	352(%rsp), %esi
	movq	%rdx, (%rsp)
	testl	%esi, %esi
	je	.L1627
	pxor	%xmm0, %xmm0
	movq	%rbx, %rdi
	movl	%r9d, current_word_bits(%rip)
	movups	%xmm0, 8+string_pool(%rip)
	movl	%ecx, current_byteptr(%rip)
	movq	$0, string_pool(%rip)
	movq	$0, 8+name_map(%rip)
	call	collect_strings_program
	movq	%rbp, %rcx
	movl	$36, %edx
	movl	$1, %esi
	leaq	.LC178(%rip), %rdi
	call	fwrite@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbp, %rdi
	setne	%dl
	leaq	.LC149(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%r12d, %edx
	movq	%rbp, %rdi
	xorl	%eax, %eax
	leaq	.LC150(%rip), %rsi
	call	fprintf@PLT
	movq	%rbp, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC179(%rip), %rdi
	call	fwrite@PLT
	movl	g_use_curses(%rip), %ecx
	testl	%ecx, %ecx
	jne	.L1628
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1629
.L1477:
	xorl	%r12d, %r12d
	cmpq	$0, 8(%rbx)
	jne	.L1478
	jmp	.L1508
	.p2align 4,,10
	.p2align 3
.L1481:
	cmpl	$3, %eax
	je	.L1630
	cmpl	$2, %eax
	je	.L1631
.L1482:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L1508
.L1478:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rdx
	movl	(%rdx), %eax
	testl	%eax, %eax
	jne	.L1481
	movq	8(%rdx), %rsi
	movq	(%rsp), %r8
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbp, %rdi
	addq	$1, %r12
	call	emit_stmt
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	8(%rbx), %r12
	jb	.L1478
	.p2align 4
	.p2align 3
.L1508:
	xorl	%eax, %eax
	movq	%rbx, %rdx
	leaq	.LC181(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L1632
.L1479:
	xorl	%r12d, %r12d
	cmpq	$0, 8(%rbx)
	jne	.L1509
	jmp	.L1528
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1513:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L1528
.L1509:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$2, (%rax)
	jne	.L1513
	movq	8(%rax), %r15
	movq	8(%r15), %rdi
	call	get_mangled_name
	movq	%rax, %r13
	movl	16(%r15), %eax
	testl	%eax, %eax
	jne	.L1514
	movq	48(%r15), %rax
	testq	%rax, %rax
	je	.L1513
	movl	(%rax), %r14d
	testl	%r14d, %r14d
	jne	.L1513
	movq	%r13, %rdx
	leaq	.LC161(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r15), %rax
.L1626:
	movq	16(%rax), %rsi
	movq	(%rsp), %rdx
	movq	%rbp, %rdi
	addq	$1, %r12
	call	emit_ival_expr
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC103(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%rbx), %r12
	jb	.L1509
	.p2align 4
	.p2align 3
.L1528:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC160(%rip), %rdi
	leaq	.LC169(%rip), %r15
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	emit_known_external_function_prototypes
	cmpq	$0, 8(%rbx)
	jne	.L1510
	jmp	.L1511
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1531:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L1511
.L1510:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$1, (%rax)
	jne	.L1531
	movq	8(%rax), %r14
	leaq	.LC22(%rip), %rsi
	movq	(%r14), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1532
	leaq	.LC23(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1533
.L1532:
	movq	%rbp, %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC166(%rip), %rdi
	call	fwrite@PLT
.L1536:
	xorl	%r13d, %r13d
	cmpq	$0, 16(%r14)
	jne	.L1534
	jmp	.L1537
	.p2align 4,,10
	.p2align 3
.L1633:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC61(%rip), %rdi
	call	fwrite@PLT
.L1534:
	movq	%rbp, %rcx
	movl	$4, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
	addq	$1, %r13
	cmpq	16(%r14), %r13
	jb	.L1633
.L1537:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC167(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%rbx), %r12
	jb	.L1510
	.p2align 4
	.p2align 3
.L1511:
	movq	%rbp, %rsi
	movl	$10, %edi
	xorl	%r12d, %r12d
	call	fputc@PLT
	cmpq	$0, 8(%rbx)
	movq	$0, 8(%rsp)
	movl	$0, 16(%rsp)
	je	.L1530
	.p2align 5
	.p2align 4
	.p2align 3
.L1529:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$1, (%rax)
	je	.L1634
.L1538:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jb	.L1529
	movl	16(%rsp), %edi
	testl	%edi, %edi
	je	.L1530
	movq	%rbp, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC171(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC172(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC173(%rip), %rdi
	call	fwrite@PLT
	xorl	%eax, %eax
	movq	%rbx, %rdx
	movq	%rbp, %rdi
	leaq	.LC182(%rip), %rsi
	call	fprintf@PLT
	cmpq	$0, 8(%rsp)
	je	.L1549
	cmpq	$1, 8(%rsp)
	je	.L1635
	cmpq	$2, 8(%rsp)
	jne	.L1549
	movq	%rbp, %rcx
	movl	$52, %edx
	movl	$1, %esi
	leaq	.LC183(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC184(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1547
	.p2align 4,,10
	.p2align 3
.L1631:
	movq	8(%rdx), %r14
	movq	8(%r14), %rdi
	call	get_mangled_name
	movq	%rax, %r13
	movl	16(%r14), %eax
	cmpl	$1, %eax
	jne	.L1485
	movq	48(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1555
	cmpl	$1, (%rdi)
	jne	.L1555
	movq	24(%rdi), %r10
	cmpq	$1, %r10
	jne	.L1487
	movq	16(%rdi), %rax
	movq	(%rax), %rax
	movl	(%rax), %edx
	testl	%edx, %edx
	jne	.L1487
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L1487
	cmpl	$1, (%rax)
	je	.L1625
.L1487:
	call	edge_tail_words_top
	leaq	(%r10,%rax), %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	jmp	.L1486
	.p2align 4,,10
	.p2align 3
.L1514:
	cmpl	$1, %eax
	je	.L1636
	cmpl	$2, %eax
	jne	.L1513
	movq	%r13, %r8
	movq	%r13, %rcx
	movq	%r13, %rdx
	movq	%rbp, %rdi
	leaq	.LC164(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r15), %rax
	testq	%rax, %rax
	je	.L1513
	cmpl	$1, (%rax)
	jne	.L1513
	movl	32(%r15), %r10d
	movq	24(%rax), %r14
	testl	%r10d, %r10d
	jne	.L1524
	movq	24(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1524
	movq	$0, 32(%rsp)
	leaq	32(%rsp), %r10
	movq	%r10, %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1525
	movq	32(%rsp), %rax
	xorl	%edx, %edx
	testq	%rax, %rax
	cmovs	%rdx, %rax
	addq	$1, %rax
	cmpq	%rax, %r14
	cmovb	%rax, %r14
.L1523:
	movq	%r10, %rdi
	movq	%r13, %rcx
	movl	$256, %esi
	movq	%r10, 8(%rsp)
	leaq	.LC165(%rip), %rdx
	xorl	%eax, %eax
	call	snprintf@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 360
	movq	48(%r15), %rcx
	movq	%r14, %r8
	pushq	8(%rsp)
	.cfi_def_cfa_offset 368
	movq	24(%rsp), %rsi
	xorl	%edx, %edx
	movq	%rbp, %rdi
	movl	$2, %r9d
	call	emit_edge_list_init
	popq	%r8
	.cfi_def_cfa_offset 360
	popq	%r9
	.cfi_def_cfa_offset 352
	jmp	.L1513
	.p2align 4,,10
	.p2align 3
.L1485:
	cmpl	$2, %eax
	je	.L1637
	movl	4(%r14), %r15d
	movq	%r13, %rdx
	testl	%r15d, %r15d
	je	.L1507
	leaq	.LC159(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1482
	.p2align 4,,10
	.p2align 3
.L1632:
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	emit_global_regions.part.0
	jmp	.L1479
	.p2align 4,,10
	.p2align 3
.L1530:
	movq	%rbx, %rdx
	movq	%rbp, %rdi
	leaq	.LC185(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%rbx, %rcx
	movq	%rbx, %rdx
	movq	%rbp, %rdi
	addq	$296, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC186(%rip), %rsi
	xorl	%eax, %eax
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
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L1629:
	.cfi_restore_state
	movq	%rbp, %rdi
	call	emit_string_pool
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1477
	.p2align 4,,10
	.p2align 3
.L1628:
	movq	%rbp, %rcx
	movl	$41, %edx
	movl	$1, %esi
	leaq	.LC180(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	je	.L1477
	jmp	.L1629
	.p2align 4,,10
	.p2align 3
.L1636:
	movq	48(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1518
	cmpl	$1, (%rdi)
	je	.L1638
.L1518:
	movq	%r13, %rcx
	movq	%r13, %rdx
	leaq	.LC162(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1513
	.p2align 4,,10
	.p2align 3
.L1555:
	movl	$1, %ecx
.L1486:
	movq	%r13, %rdx
	leaq	.LC157(%rip), %rsi
.L1624:
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L1625:
	movq	%r13, %rdx
	leaq	.LC123(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1482
	.p2align 4,,10
	.p2align 3
.L1630:
	movq	8(%rdx), %r13
	leaq	.LC24(%rip), %rdi
	movq	%rbp, %rcx
	movl	$12, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r13), %rdi
	testq	%rdi, %rdi
	je	.L1484
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1484:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC103(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1482
	.p2align 4,,10
	.p2align 3
.L1634:
	movq	8(%rax), %r15
	leaq	.LC22(%rip), %rsi
	movq	(%r15), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1539
	leaq	.LC23(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1540
.L1539:
	movq	16(%r15), %rax
	movq	%rbp, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC170(%rip), %rdi
	movq	%rax, 8(%rsp)
	call	fwrite@PLT
	movl	$1, 16(%rsp)
.L1541:
	xorl	%r14d, %r14d
	cmpq	$0, 16(%r15)
	leaq	.LC168(%rip), %r13
	jne	.L1543
	jmp	.L1545
	.p2align 4,,10
	.p2align 3
.L1639:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC61(%rip), %rdi
	call	fwrite@PLT
.L1543:
	movq	%r13, %rdi
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r15), %rax
	movq	(%rax,%r14,8), %rdi
	testq	%rdi, %rdi
	je	.L1544
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1544:
	addq	$1, %r14
	cmpq	16(%r15), %r14
	jb	.L1639
.L1545:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC111(%rip), %rdi
	call	fwrite@PLT
	movq	(%rsp), %rdx
	movq	%r15, %rsi
	movq	%rbp, %rdi
	call	emit_function_body
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1538
	.p2align 4,,10
	.p2align 3
.L1627:
	addq	$296, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rsi
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
	jmp	emit_program_c
	.p2align 4,,10
	.p2align 3
.L1549:
	.cfi_restore_state
	movq	%rbp, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC174(%rip), %rdi
	call	fwrite@PLT
.L1547:
	addq	$296, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC120(%rip), %rdi
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
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L1533:
	.cfi_restore_state
	leaq	.LC168(%rip), %r13
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1535
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1535:
	movq	%rbp, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1536
	.p2align 4,,10
	.p2align 3
.L1507:
	leaq	.LC123(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1482
.L1638:
	movq	24(%rdi), %r14
	cmpq	$1, %r14
	je	.L1640
	call	edge_tail_words_top
	leaq	32(%rsp), %r10
	movq	%r13, %rcx
	leaq	.LC177(%rip), %rdx
	movq	%rax, %r11
	leaq	(%r14,%rax), %rax
	movq	%r10, %rdi
	movl	$256, %esi
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	movq	%r11, 24(%rsp)
	movq	%r10, 16(%rsp)
	call	snprintf@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 360
	movq	48(%r15), %rcx
	xorl	%edx, %edx
	pushq	8(%rsp)
	.cfi_def_cfa_offset 368
	movq	32(%rsp), %rsi
	movq	%r14, %r8
	movq	%rbp, %rdi
	movl	$2, %r9d
	call	emit_edge_list_init
	popq	%rcx
	.cfi_def_cfa_offset 360
	popq	%rsi
	.cfi_def_cfa_offset 352
	cmpq	$1, 8(%rsp)
	movq	24(%rsp), %r11
	je	.L1518
	cmpq	$1, %r14
	ja	.L1552
	testq	%r11, %r11
	je	.L1518
.L1552:
	movq	%r13, %r8
	movq	%r13, %rcx
	movq	%r13, %rdx
	movq	%rbp, %rdi
	leaq	.LC163(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1513
	.p2align 4,,10
	.p2align 3
.L1637:
	movq	48(%r14), %r8
	movl	32(%r14), %eax
	testq	%r8, %r8
	je	.L1641
	cmpl	$1, (%r8)
	je	.L1492
	testl	%eax, %eax
	jne	.L1490
	movq	24(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1490
	movq	$0, 32(%rsp)
	leaq	32(%rsp), %r10
	movq	%r10, %rsi
	call	try_eval_const_expr
	movl	$1, %ecx
	testl	%eax, %eax
	je	.L1494
	movq	32(%rsp), %rax
	leaq	1(%rax), %rcx
	testq	%rax, %rax
	movl	$1, %eax
	cmovs	%rax, %rcx
.L1501:
	cmpl	$1, (%r8)
	jne	.L1494
.L1506:
	movq	%r8, %rdi
	movq	%rcx, 8(%rsp)
	call	edge_tail_words_top
	movq	8(%rsp), %rcx
	addq	%rax, %rcx
	movl	$1, %eax
	cmove	%rax, %rcx
	jmp	.L1494
	.p2align 4,,10
	.p2align 3
.L1540:
	leaq	.LC168(%rip), %r13
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1542
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1542:
	movq	%rbp, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1541
.L1635:
	movq	%rbp, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC175(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1547
.L1490:
	movl	$1, %ecx
.L1494:
	movq	%r13, %rdx
	leaq	.LC158(%rip), %rsi
	jmp	.L1624
.L1641:
	testl	%eax, %eax
	jne	.L1490
	movq	24(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1490
	movq	$0, 32(%rsp)
	leaq	32(%rsp), %r10
	movq	%r10, %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1490
	movq	32(%rsp), %rax
	xorl	%edx, %edx
	testq	%rax, %rax
	cmovs	%rdx, %rax
	leaq	1(%rax), %rcx
	jmp	.L1494
.L1492:
	movq	24(%r8), %rcx
	testl	%eax, %eax
	jne	.L1623
	movq	24(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1623
	leaq	32(%rsp), %r10
	movq	%rcx, 8(%rsp)
	movq	$0, 32(%rsp)
	movq	%r10, %rsi
	call	try_eval_const_expr
	movq	8(%rsp), %rcx
	testl	%eax, %eax
	je	.L1503
	movq	32(%rsp), %rsi
	testq	%rcx, %rcx
	movl	$1, %edx
	cmovne	%rcx, %rdx
	leaq	1(%rsi), %rax
	cmpq	%rax, %rcx
	cmovnb	%rcx, %rax
	testq	%rsi, %rsi
	movq	%rdx, %rcx
	cmovns	%rax, %rcx
	jmp	.L1501
.L1640:
	movq	16(%rdi), %rax
	movq	(%rax), %rax
	movl	(%rax), %r11d
	testl	%r11d, %r11d
	jne	.L1520
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L1520
	cmpl	$1, (%rax)
	je	.L1642
.L1520:
	call	edge_tail_words_top
	leaq	32(%rsp), %r10
	movq	%r13, %rcx
	leaq	.LC177(%rip), %rdx
	movq	%r10, %rdi
	movl	$256, %esi
	movq	%rax, %r14
	xorl	%eax, %eax
	movq	%r10, 8(%rsp)
	call	snprintf@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 360
	movq	48(%r15), %rcx
	xorl	%edx, %edx
	pushq	8(%rsp)
	.cfi_def_cfa_offset 368
	movq	24(%rsp), %rsi
	movl	$2, %r9d
	movq	%rbp, %rdi
	movl	$1, %r8d
	call	emit_edge_list_init
	popq	%rax
	.cfi_def_cfa_offset 360
	popq	%rdx
	.cfi_def_cfa_offset 352
	testq	%r14, %r14
	jne	.L1552
	jmp	.L1518
	.p2align 4,,10
	.p2align 3
.L1623:
	testq	%rcx, %rcx
	movl	$1, %eax
	cmove	%rax, %rcx
	jmp	.L1506
.L1524:
	testq	%r14, %r14
	movl	$1, %eax
	leaq	32(%rsp), %r10
	cmove	%rax, %r14
	jmp	.L1523
.L1525:
	testq	%r14, %r14
	movl	$1, %eax
	cmove	%rax, %r14
	jmp	.L1523
.L1503:
	testq	%rcx, %rcx
	jne	.L1501
	movl	$1, %ecx
	jmp	.L1506
	.p2align 4,,10
	.p2align 3
.L1642:
	movq	%r13, %rdx
	leaq	.LC161(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r15), %rax
	movq	16(%rax), %rax
	movq	(%rax), %rax
	jmp	.L1626
	.cfi_endproc
.LFE56:
	.size	emit_program_c_ext, .-emit_program_c_ext
	.section	.rodata
	.align 16
	.type	CSWTCH.160, @object
	.size	CSWTCH.160, 24
CSWTCH.160:
	.long	24
	.long	25
	.long	26
	.long	27
	.long	22
	.long	23
	.section	.rodata.str1.1
.LC187:
	.string	"lchar"
.LC188:
	.string	"getchar"
.LC189:
	.string	"getchr"
.LC190:
	.string	"putchr"
.LC191:
	.string	"getstr"
.LC192:
	.string	"putstr"
.LC193:
	.string	"flush"
.LC194:
	.string	"reread"
.LC195:
	.string	"printn"
.LC196:
	.string	"putnum"
.LC197:
	.string	"print"
.LC198:
	.string	"putchar"
.LC199:
	.string	"abort"
.LC200:
	.string	"free"
.LC201:
	.string	"alloc"
.LC202:
	.string	"open"
.LC203:
	.string	"close"
.LC204:
	.string	"read"
.LC205:
	.string	"write"
.LC206:
	.string	"creat"
.LC207:
	.string	"seek"
.LC208:
	.string	"openr"
.LC209:
	.string	"openw"
.LC210:
	.string	"fork"
.LC211:
	.string	"wait"
.LC212:
	.string	"execl"
.LC213:
	.string	"execv"
.LC214:
	.string	"chdir"
.LC215:
	.string	"chmod"
.LC216:
	.string	"chown"
.LC217:
	.string	"link"
.LC218:
	.string	"unlink"
.LC219:
	.string	"stat"
.LC220:
	.string	"fstat"
.LC221:
	.string	"time"
.LC222:
	.string	"ctime"
.LC223:
	.string	"getuid"
.LC224:
	.string	"setuid"
.LC225:
	.string	"makdir"
.LC226:
	.string	"intr"
.LC227:
	.string	"gtty"
.LC228:
	.string	"stty"
.LC229:
	.string	"system"
.LC230:
	.string	"usleep"
.LC231:
	.string	"argc"
.LC232:
	.string	"argv"
	.section	.data.rel.ro.local,"aw"
	.align 32
	.type	names.0, @object
	.size	names.0, 408
names.0:
	.quad	.LC26
	.quad	.LC187
	.quad	.LC188
	.quad	.LC189
	.quad	.LC190
	.quad	.LC191
	.quad	.LC192
	.quad	.LC193
	.quad	.LC194
	.quad	.LC65
	.quad	.LC195
	.quad	.LC196
	.quad	.LC197
	.quad	.LC198
	.quad	.LC74
	.quad	.LC199
	.quad	.LC200
	.quad	.LC201
	.quad	.LC202
	.quad	.LC203
	.quad	.LC204
	.quad	.LC205
	.quad	.LC206
	.quad	.LC207
	.quad	.LC208
	.quad	.LC209
	.quad	.LC210
	.quad	.LC211
	.quad	.LC212
	.quad	.LC213
	.quad	.LC214
	.quad	.LC215
	.quad	.LC216
	.quad	.LC217
	.quad	.LC218
	.quad	.LC219
	.quad	.LC220
	.quad	.LC221
	.quad	.LC222
	.quad	.LC223
	.quad	.LC224
	.quad	.LC225
	.quad	.LC226
	.quad	.LC227
	.quad	.LC228
	.quad	.LC229
	.quad	.LC230
	.quad	.LC62
	.quad	.LC231
	.quad	.LC232
	.quad	0
	.globl	g_libb_path
	.bss
	.align 8
	.type	g_libb_path, @object
	.size	g_libb_path, 8
g_libb_path:
	.zero	8
	.local	g_switch_id
	.comm	g_switch_id,4,4
	.local	g_ctrl
	.comm	g_ctrl,8,8
	.local	expression_id
	.comm	expression_id,4,4
	.local	function_labels
	.comm	function_labels,24,16
	.local	current_byteptr
	.comm	current_byteptr,4,4
	.section	.rodata.str1.1
.LC233:
	.string	"break"
.LC234:
	.string	"case"
.LC235:
	.string	"const"
.LC236:
	.string	"continue"
.LC237:
	.string	"default"
.LC238:
	.string	"do"
.LC239:
	.string	"double"
.LC240:
	.string	"else"
.LC241:
	.string	"enum"
.LC242:
	.string	"extern"
.LC243:
	.string	"float"
.LC244:
	.string	"for"
.LC245:
	.string	"goto"
.LC246:
	.string	"if"
.LC247:
	.string	"inline"
.LC248:
	.string	"int"
.LC249:
	.string	"long"
.LC250:
	.string	"register"
.LC251:
	.string	"restrict"
.LC252:
	.string	"short"
.LC253:
	.string	"signed"
.LC254:
	.string	"sizeof"
.LC255:
	.string	"static"
.LC256:
	.string	"struct"
.LC257:
	.string	"switch"
.LC258:
	.string	"typedef"
.LC259:
	.string	"union"
.LC260:
	.string	"unsigned"
.LC261:
	.string	"void"
.LC262:
	.string	"volatile"
.LC263:
	.string	"while"
.LC264:
	.string	"_Bool"
.LC265:
	.string	"_Complex"
.LC266:
	.string	"_Imaginary"
.LC267:
	.string	"_Alignas"
.LC268:
	.string	"_Alignof"
.LC269:
	.string	"_Atomic"
.LC270:
	.string	"_Generic"
.LC271:
	.string	"_Noreturn"
.LC272:
	.string	"_Static_assert"
.LC273:
	.string	"_Thread_local"
.LC274:
	.string	"NULL"
.LC275:
	.string	"true"
.LC276:
	.string	"false"
.LC277:
	.string	"bool"
.LC278:
	.string	"B_PTR"
.LC279:
	.string	"B_ADDR"
.LC280:
	.string	"B_DEREF"
	.section	.data.rel.ro.local
	.align 32
	.type	c_keywords, @object
	.size	c_keywords, 424
c_keywords:
	.quad	.LC13
	.quad	.LC233
	.quad	.LC234
	.quad	.LC26
	.quad	.LC235
	.quad	.LC236
	.quad	.LC237
	.quad	.LC238
	.quad	.LC239
	.quad	.LC240
	.quad	.LC241
	.quad	.LC242
	.quad	.LC243
	.quad	.LC244
	.quad	.LC245
	.quad	.LC246
	.quad	.LC247
	.quad	.LC248
	.quad	.LC249
	.quad	.LC250
	.quad	.LC251
	.quad	.LC117
	.quad	.LC252
	.quad	.LC253
	.quad	.LC254
	.quad	.LC255
	.quad	.LC256
	.quad	.LC257
	.quad	.LC258
	.quad	.LC259
	.quad	.LC260
	.quad	.LC261
	.quad	.LC262
	.quad	.LC263
	.quad	.LC264
	.quad	.LC265
	.quad	.LC266
	.quad	.LC267
	.quad	.LC268
	.quad	.LC269
	.quad	.LC270
	.quad	.LC271
	.quad	.LC272
	.quad	.LC273
	.quad	.LC274
	.quad	.LC275
	.quad	.LC276
	.quad	.LC277
	.quad	.LC169
	.quad	.LC278
	.quad	.LC279
	.quad	.LC280
	.quad	0
	.local	name_map
	.comm	name_map,24,16
	.local	string_pool
	.comm	string_pool,24,16
	.local	current_word_bits
	.comm	current_word_bits,4,4
	.section	.note.GNU-stack,"",@progbits
