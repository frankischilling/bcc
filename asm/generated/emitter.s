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
	movq	16(%rax), %r15
	movq	8(%rax), %rbp
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
	.p2align 4
	.type	source_function, @function
source_function:
.LFB21:
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
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	movq	current_program(%rip), %rax
	testq	%rax, %rax
	je	.L24
	movq	8(%rax), %r12
	testq	%r12, %r12
	je	.L24
	movq	(%rax), %r13
	xorl	%ebx, %ebx
	jmp	.L27
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L25:
	addq	$1, %rbx
	cmpq	%r12, %rbx
	je	.L24
.L27:
	movq	0(%r13,%rbx,8), %rax
	cmpl	$1, (%rax)
	jne	.L25
	movq	8(%rax), %rax
	movq	%rbp, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L25
.L31:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movl	$1, %eax
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
.L24:
	.cfi_restore_state
	movq	8+g_known_functions(%rip), %r12
	testq	%r12, %r12
	je	.L30
	movq	g_known_functions(%rip), %r13
	xorl	%ebx, %ebx
	jmp	.L28
	.p2align 4,,10
	.p2align 3
.L41:
	addq	$1, %rbx
	cmpq	%r12, %rbx
	je	.L30
.L28:
	movq	0(%r13,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L41
	jmp	.L31
	.p2align 4,,10
	.p2align 3
.L30:
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	xorl	%eax, %eax
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
.LFE21:
	.size	source_function, .-source_function
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
.LFB37:
	.cfi_startproc
	leal	-21(%rdi), %eax
	cmpl	$25, %eax
	ja	.L43
	leaq	.L45(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L45:
	.long	.L54-.L45
	.long	.L43-.L45
	.long	.L43-.L45
	.long	.L43-.L45
	.long	.L43-.L45
	.long	.L43-.L45
	.long	.L43-.L45
	.long	.L43-.L45
	.long	.L43-.L45
	.long	.L43-.L45
	.long	.L43-.L45
	.long	.L43-.L45
	.long	.L43-.L45
	.long	.L43-.L45
	.long	.L43-.L45
	.long	.L43-.L45
	.long	.L43-.L45
	.long	.L55-.L45
	.long	.L52-.L45
	.long	.L51-.L45
	.long	.L50-.L45
	.long	.L49-.L45
	.long	.L48-.L45
	.long	.L47-.L45
	.long	.L46-.L45
	.long	.L44-.L45
	.text
	.p2align 4,,10
	.p2align 3
.L43:
	jmp	tk_name@PLT
	.p2align 4,,10
	.p2align 3
.L52:
	leaq	.LC5(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L51:
	leaq	.LC6(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L50:
	leaq	.LC7(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L49:
	leaq	.LC8(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L48:
	leaq	.LC9(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L47:
	leaq	.LC10(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L46:
	leaq	.LC11(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L44:
	leaq	.LC12(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L55:
	leaq	.LC4(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L54:
	leaq	.LC3(%rip), %rax
	ret
	.cfi_endproc
.LFE37:
	.size	assignment_op_to_c, .-assignment_op_to_c
	.p2align 4
	.type	collect_cases, @function
collect_cases:
.LFB46:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L78
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	leaq	.L61(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
.L58:
	cmpl	$13, (%rbx)
	ja	.L56
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L61:
	.long	.L56-.L61
	.long	.L65-.L61
	.long	.L56-.L61
	.long	.L64-.L61
	.long	.L63-.L61
	.long	.L56-.L61
	.long	.L56-.L61
	.long	.L56-.L61
	.long	.L56-.L61
	.long	.L56-.L61
	.long	.L56-.L61
	.long	.L63-.L61
	.long	.L56-.L61
	.long	.L60-.L61
	.text
	.p2align 4,,10
	.p2align 3
.L65:
	xorl	%r12d, %r12d
	cmpq	$0, 24(%rbx)
	je	.L56
.L66:
	movq	16(%rbx), %rax
	movq	%rbp, %rsi
	movq	(%rax,%r12,8), %rdi
	addq	$1, %r12
	call	collect_cases
	cmpq	24(%rbx), %r12
	jb	.L66
.L56:
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
.L63:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L67:
	testq	%rbx, %rbx
	jne	.L58
	jmp	.L56
	.p2align 4,,10
	.p2align 3
.L60:
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
.L64:
	.cfi_restore_state
	movq	24(%rbx), %rdi
	movq	%rbp, %rsi
	call	collect_cases
	movq	32(%rbx), %rbx
	jmp	.L67
	.p2align 4,,10
	.p2align 3
.L78:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE46:
	.size	collect_cases, .-collect_cases
	.p2align 4
	.type	collect_function_labels, @function
collect_function_labels:
.LFB42:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L103
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L86(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L83:
	cmpl	$12, (%rbx)
	ja	.L81
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L86:
	.long	.L81-.L86
	.long	.L90-.L86
	.long	.L81-.L86
	.long	.L89-.L86
	.long	.L85-.L86
	.long	.L81-.L86
	.long	.L81-.L86
	.long	.L81-.L86
	.long	.L81-.L86
	.long	.L81-.L86
	.long	.L81-.L86
	.long	.L87-.L86
	.long	.L85-.L86
	.text
	.p2align 4,,10
	.p2align 3
.L90:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L81
.L91:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_function_labels
	cmpq	24(%rbx), %rbp
	jb	.L91
.L81:
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
.L85:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L92:
	testq	%rbx, %rbx
	jne	.L83
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
.L87:
	.cfi_restore_state
	movq	16(%rbx), %rsi
	leaq	function_labels(%rip), %rdi
	call	vec_push@PLT
	movq	24(%rbx), %rbx
	jmp	.L92
	.p2align 4,,10
	.p2align 3
.L89:
	movq	24(%rbx), %rdi
	call	collect_function_labels
	movq	32(%rbx), %rbx
	jmp	.L92
	.p2align 4,,10
	.p2align 3
.L103:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE42:
	.size	collect_function_labels, .-collect_function_labels
	.p2align 4
	.type	collect_function_autos, @function
collect_function_autos:
.LFB57:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L134
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	leaq	.L112(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
.L109:
	cmpl	$12, (%rbx)
	ja	.L107
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L112:
	.long	.L107-.L112
	.long	.L117-.L112
	.long	.L116-.L112
	.long	.L115-.L112
	.long	.L113-.L112
	.long	.L107-.L112
	.long	.L107-.L112
	.long	.L107-.L112
	.long	.L107-.L112
	.long	.L107-.L112
	.long	.L107-.L112
	.long	.L113-.L112
	.long	.L113-.L112
	.text
	.p2align 4,,10
	.p2align 3
.L116:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L107
	.p2align 4
	.p2align 3
.L118:
	movq	16(%rbx), %rax
	movq	%r12, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	vec_push@PLT
	cmpq	24(%rbx), %rbp
	jb	.L118
.L107:
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
.L113:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L120:
	testq	%rbx, %rbx
	jne	.L109
	jmp	.L107
	.p2align 4,,10
	.p2align 3
.L115:
	movq	24(%rbx), %rdi
	movq	%r12, %rsi
	call	collect_function_autos
	movq	32(%rbx), %rbx
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L117:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L107
.L119:
	movq	16(%rbx), %rax
	movq	%r12, %rsi
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_function_autos
	cmpq	24(%rbx), %rbp
	jb	.L119
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L134:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE57:
	.size	collect_function_autos, .-collect_function_autos
	.p2align 4
	.type	get_string_id, @function
get_string_id:
.LFB14:
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
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	movq	8+string_pool(%rip), %rcx
	testq	%rcx, %rcx
	je	.L138
	movq	string_pool(%rip), %rsi
	xorl	%eax, %eax
	jmp	.L141
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L139:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L138
.L141:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%rbx, (%rdx)
	jne	.L139
	movl	24(%rdx), %eax
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
.L138:
	.cfi_restore_state
	leaq	1(%rbp), %r13
	movl	$32, %edi
	call	xmalloc@PLT
	movq	%r13, %rdi
	movq	%rax, %r12
	call	xmalloc@PLT
	movq	%r13, %rdx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	memcpy@PLT
	movq	%rbx, (%r12)
	movq	%r12, %rsi
	leaq	string_pool(%rip), %rdi
	movq	%rax, 8(%r12)
	movq	8+string_pool(%rip), %rax
	movq	%rbp, 16(%r12)
	movl	%eax, 24(%r12)
	call	vec_push@PLT
	movl	24(%r12), %eax
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
.LFE14:
	.size	get_string_id, .-get_string_id
	.p2align 4
	.type	edge_words_total.part.0.isra.0, @function
edge_words_total.part.0.isra.0:
.LFB78:
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
	je	.L151
	movq	%rdi, %r12
	movq	%rsi, %rbp
	xorl	%ebx, %ebx
.L150:
	movq	(%r12,%rbx,8), %rax
	testq	%rax, %rax
	je	.L149
	cmpl	$1, (%rax)
	je	.L157
.L149:
	addq	$1, %rbx
	cmpq	%rbp, %rbx
	jne	.L150
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
.L157:
	.cfi_restore_state
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r13
	jmp	.L149
	.p2align 4,,10
	.p2align 3
.L151:
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
.LFE78:
	.size	edge_words_total.part.0.isra.0, .-edge_words_total.part.0.isra.0
	.section	.rodata.str1.1
.LC13:
	.string	"char"
	.text
	.p2align 4
	.type	global_data_kind, @function
global_data_kind:
.LFB23:
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
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movq	8+g_known_variables(%rip), %rax
	testq	%rax, %rax
	je	.L171
	movq	g_known_variables(%rip), %rbx
	xorl	%r12d, %r12d
	leaq	(%rbx,%rax,8), %r13
	.p2align 4
	.p2align 3
.L160:
	movq	(%rbx), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	addq	$8, %rbx
	movzbl	%al, %eax
	orl	%eax, %r12d
	cmpq	%rbx, %r13
	jne	.L160
.L159:
	movq	current_program(%rip), %r13
	testq	%r13, %r13
	je	.L161
	movq	8(%r13), %r14
	xorl	%ebx, %ebx
	jmp	.L162
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L163:
	addq	$1, %rbx
.L162:
	cmpq	%rbx, %r14
	je	.L161
	movq	0(%r13), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$2, (%rax)
	jne	.L163
	movq	8(%rax), %rax
	movq	%rbp, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L163
.L172:
	movl	$1, %r12d
.L158:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%r12d, %eax
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
.L161:
	.cfi_restore_state
	movq	%rbp, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L173
	leaq	8+names.0(%rip), %rbx
	leaq	.LC13(%rip), %rsi
	jmp	.L167
	.p2align 4,,10
	.p2align 3
.L188:
	movq	(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L168
.L167:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L188
	cmpl	$1, %r12d
	jne	.L158
.L168:
	testq	%r13, %r13
	je	.L158
	movq	8(%r13), %r14
	testq	%r14, %r14
	je	.L158
	movq	0(%r13), %r13
	xorl	%ebx, %ebx
	jmp	.L170
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L169:
	addq	$1, %rbx
	cmpq	%r14, %rbx
	je	.L158
.L170:
	movq	0(%r13,%rbx,8), %rax
	cmpl	$3, (%rax)
	jne	.L169
	movq	8(%rax), %r15
	movq	%rbp, %rsi
	movq	16(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L169
	movl	8(%r15), %eax
	movl	$2, %r12d
	testl	%eax, %eax
	jne	.L158
	jmp	.L172
	.p2align 4,,10
	.p2align 3
.L173:
	xorl	%r12d, %r12d
	jmp	.L158
	.p2align 4,,10
	.p2align 3
.L171:
	xorl	%r12d, %r12d
	jmp	.L159
	.cfi_endproc
.LFE23:
	.size	global_data_kind, .-global_data_kind
	.section	.rodata.str1.1
.LC14:
	.string	"auto"
.LC15:
	.string	"__empty"
.LC16:
	.string	"%02X"
.LC17:
	.string	"_%02X"
.LC18:
	.string	"__bcc_user_%c_%s"
.LC19:
	.string	"%s_%d"
.LC20:
	.string	"__bcc_keyword_%s"
.LC21:
	.string	"__bcc_"
	.text
	.p2align 4
	.type	get_mangled_name, @function
get_mangled_name:
.LFB24:
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
	je	.L230
	movq	8+name_map(%rip), %r13
	movq	%rdi, %rbx
	testq	%r13, %r13
	je	.L191
	movq	name_map(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L193
	.p2align 4,,10
	.p2align 3
.L192:
	addq	$1, %rbp
	cmpq	%r13, %rbp
	je	.L191
.L193:
	movq	(%r14,%rbp,8), %r12
	movq	%rbx, %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L192
	movq	8(%r12), %r13
.L189:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r13, %rax
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
.L191:
	.cfi_restore_state
	cmpb	$0, (%rbx)
	je	.L263
	movq	%rbx, %rdi
	call	strlen@PLT
	leaq	16(,%rax,4), %rdi
	movq	%rax, (%rsp)
	call	xmalloc@PLT
	movzbl	(%rbx), %edx
	movq	(%rsp), %rcx
	movq	%rax, %r12
	leaq	1(%rax), %r14
	leal	-65(%rdx), %eax
	cmpb	$57, %al
	ja	.L196
	movabsq	$288230372997595135, %rsi
	btq	%rax, %rsi
	jnc	.L196
	movb	%dl, (%r12)
.L200:
	leaq	1(%rbx), %rbp
	leaq	(%rbx,%rcx), %r15
	movabsq	$288230372997595135, %r13
	cmpq	$1, %rcx
	ja	.L210
	jmp	.L202
	.p2align 4,,10
	.p2align 3
.L203:
	leal	-65(%rdx), %eax
	cmpb	$57, %al
	ja	.L206
	btq	%rax, %r13
	jnc	.L206
.L204:
	movb	%dl, (%r14)
	addq	$1, %r14
.L209:
	addq	$1, %rbp
	cmpq	%rbp, %r15
	je	.L202
.L210:
	movzbl	0(%rbp), %edx
	cmpb	$57, %dl
	jg	.L203
	cmpb	$47, %dl
	jg	.L204
	cmpb	$46, %dl
	jne	.L206
	addq	$1, %rbp
	movb	$95, (%r14)
	addq	$1, %r14
	cmpq	%rbp, %r15
	jne	.L210
.L202:
	movb	$0, (%r14)
	movl	g_strict(%rip), %edx
	testl	%edx, %edx
	je	.L264
.L211:
	movq	%r12, %rdi
	call	strlen@PLT
	leaq	14(%rax), %rdi
	call	xmalloc@PLT
	movl	$98, %edx
	movq	%rax, %r13
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L265
.L214:
	xorl	%eax, %eax
	movq	%r12, %rcx
	leaq	.LC18(%rip), %rsi
	movq	%r13, %rdi
	call	sprintf@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L266
.L229:
	leaq	8+c_keywords(%rip), %rbp
	leaq	.LC14(%rip), %rsi
	jmp	.L218
	.p2align 4,,10
	.p2align 3
.L267:
	movq	0(%rbp), %rsi
	addq	$8, %rbp
	testq	%rsi, %rsi
	je	.L219
.L218:
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L267
	movq	%r13, %rdi
	call	strlen@PLT
	leaq	15(%rax), %rdi
	call	xmalloc@PLT
	movq	%r13, %rdx
	leaq	.LC20(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %rbp
	xorl	%eax, %eax
	call	sprintf@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L268
.L228:
	movq	%rbp, %r13
.L219:
	movq	8+name_map(%rip), %r12
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
	testq	%r12, %r12
	je	.L220
	movq	name_map(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L222
	.p2align 4,,10
	.p2align 3
.L270:
	addq	$1, %rbp
	cmpq	%rbp, %r12
	je	.L269
.L222:
	movq	(%r14,%rbp,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L270
	movq	%r13, %rdi
	call	strlen@PLT
	leaq	16(%rax), %rdi
	call	xmalloc@PLT
	movl	$2, %ecx
	movq	%rax, %r12
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
	.p2align 4
	.p2align 3
.L224:
	leal	1(%rcx), %eax
	movq	%r13, %rdx
	leaq	.LC19(%rip), %rsi
	movq	%r12, %rdi
	movl	%eax, 12(%rsp)
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	8+name_map(%rip), %rbp
	testq	%rbp, %rbp
	je	.L223
	movq	(%rsp), %rax
	xorl	%r15d, %r15d
	movq	(%rax), %r14
	jmp	.L225
	.p2align 4,,10
	.p2align 3
.L271:
	addq	$1, %r15
	cmpq	%rbp, %r15
	je	.L223
.L225:
	movq	(%r14,%r15,8), %rax
	movq	%r12, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L271
	movl	12(%rsp), %ecx
	jmp	.L224
	.p2align 4,,10
	.p2align 3
.L263:
	leaq	.LC15(%rip), %rdi
	call	sdup@PLT
	movl	g_strict(%rip), %edx
	movq	%rax, %r12
	testl	%edx, %edx
	jne	.L211
.L264:
	movq	%rbx, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L211
	leaq	8+names.0(%rip), %rbp
	leaq	.LC13(%rip), %rsi
	jmp	.L212
	.p2align 4,,10
	.p2align 3
.L273:
	movq	0(%rbp), %rsi
	addq	$8, %rbp
	testq	%rsi, %rsi
	je	.L272
.L212:
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L273
	jmp	.L211
	.p2align 4,,10
	.p2align 3
.L269:
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
.L220:
	movl	$16, %edi
	call	xmalloc@PLT
	movq	%rbx, %rdi
	movq	%rax, %rbp
	call	sdup@PLT
	movq	%r13, 8(%rbp)
	movq	(%rsp), %rdi
	movq	%rbp, %rsi
	movq	%rax, 0(%rbp)
	call	vec_push@PLT
	jmp	.L189
.L196:
	movb	$95, (%r12)
	movzbl	(%rbx), %eax
	cmpb	$46, %al
	jne	.L274
	movb	$95, 1(%r12)
	leaq	2(%r12), %r14
	jmp	.L200
	.p2align 4,,10
	.p2align 3
.L206:
	movq	%r14, %rdi
	leaq	.LC17(%rip), %rsi
	xorl	%eax, %eax
	addq	$3, %r14
	call	sprintf@PLT
	jmp	.L209
	.p2align 4,,10
	.p2align 3
.L223:
	cmpq	$0, g_compilation_arena(%rip)
	je	.L275
.L226:
	movq	%r12, %r13
	jmp	.L220
	.p2align 4,,10
	.p2align 3
.L265:
	movq	%rbx, %rdi
	call	source_function
	movl	$102, %edx
	testl	%eax, %eax
	jne	.L214
	leaq	8+names.0(%rip), %rbp
	leaq	.LC13(%rip), %rsi
	jmp	.L215
	.p2align 4,,10
	.p2align 3
.L277:
	movq	0(%rbp), %rsi
	addq	$8, %rbp
	testq	%rsi, %rsi
	je	.L276
.L215:
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L277
	movl	$114, %edx
	jmp	.L214
.L230:
	xorl	%r13d, %r13d
	jmp	.L189
.L266:
	movq	%r12, %rdi
	call	free@PLT
	jmp	.L229
.L272:
	movl	$6, %edx
	leaq	.LC21(%rip), %rsi
	movq	%rbx, %rdi
	movq	%r12, %r13
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L229
	jmp	.L211
.L274:
	movzbl	%al, %edx
	movq	%r14, %rdi
	leaq	.LC16(%rip), %rsi
	xorl	%eax, %eax
	movq	%rcx, (%rsp)
	leaq	3(%r12), %r14
	call	sprintf@PLT
	movq	(%rsp), %rcx
	jmp	.L200
.L276:
	movl	$120, %edx
	jmp	.L214
.L275:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L226
.L268:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L228
	.cfi_endproc
.LFE24:
	.size	get_mangled_name, .-get_mangled_name
	.section	.rodata.str1.1
.LC22:
	.string	"main"
.LC23:
	.string	"__b_user_main"
.LC24:
	.string	"__bcc_body_"
	.text
	.p2align 4
	.type	emit_function_body_name, @function
emit_function_body_name:
.LFB27:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsi, %rbp
	leaq	.LC22(%rip), %rsi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	movq	%rbp, %rdi
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	strcmp@PLT
	movq	%rbx, %rcx
	testl	%eax, %eax
	jne	.L279
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movl	$13, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 16
	leaq	.LC23(%rip), %rdi
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L279:
	.cfi_restore_state
	movl	$1, %esi
	movl	$11, %edx
	leaq	.LC24(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdi
	call	get_mangled_name
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbx, %rsi
	movq	%rax, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	fputs@PLT
	.cfi_endproc
.LFE27:
	.size	emit_function_body_name, .-emit_function_body_name
	.section	.rodata.str1.1
.LC25:
	.string	"b_%s"
	.text
	.p2align 4
	.type	emit_function_name, @function
emit_function_name:
.LFB29:
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
	leaq	.LC13(%rip), %rsi
	testl	%eax, %eax
	jne	.L284
	jmp	.L291
	.p2align 4,,10
	.p2align 3
.L292:
	movq	(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L285
.L284:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L292
	movq	%rbp, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L293
.L285:
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
.L291:
	.cfi_restore_state
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%r12, %rcx
	popq	%rbp
	.cfi_def_cfa_offset 16
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC23(%rip), %rdi
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L293:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	movq	%rbp, %rdx
	movq	%r12, %rdi
	popq	%rbp
	.cfi_def_cfa_offset 16
	leaq	.LC25(%rip), %rsi
	xorl	%eax, %eax
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	fprintf@PLT
	.cfi_endproc
.LFE29:
	.size	emit_function_name, .-emit_function_name
	.section	.rodata.str1.1
.LC26:
	.string	"extern word "
.LC27:
	.string	"[];\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC28:
	.string	"main supports at most two host compatibility parameters"
	.section	.rodata.str1.1
.LC29:
	.string	"word "
.LC30:
	.string	"[1];\n"
.LC31:
	.string	"static word "
.LC32:
	.string	"word"
.LC33:
	.string	", "
.LC34:
	.string	");\n"
	.text
	.p2align 4
	.type	emit_function_prototypes, @function
emit_function_prototypes:
.LFB63:
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
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	cmpq	$0, 8+external_calls(%rip)
	je	.L295
	xorl	%ebp, %ebp
	leaq	.LC26(%rip), %r15
	leaq	external_calls(%rip), %r14
	leaq	.LC27(%rip), %r13
	.p2align 4
	.p2align 3
.L297:
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rdi
	testq	%rdi, %rdi
	je	.L296
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L296:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addq	$1, %rbp
	cmpq	8+external_calls(%rip), %rbp
	jb	.L297
.L295:
	cmpq	$0, 8+g_known_functions(%rip)
	je	.L306
	movl	$0, 12(%rsp)
	movq	$0, (%rsp)
	.p2align 4
	.p2align 3
.L304:
	leaq	g_known_functions(%rip), %rax
	movq	(%rsp), %rdx
	movq	8(%r12), %r13
	movq	(%rax), %rax
	movq	(%r12), %r14
	movq	(%rax,%rdx,8), %rbp
	testq	%r13, %r13
	je	.L299
	xorl	%r15d, %r15d
	jmp	.L302
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L300:
	addq	$1, %r15
	cmpq	%r15, %r13
	je	.L299
.L302:
	movq	(%r14,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L300
	movq	8(%rax), %rax
	movq	%rbp, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L300
.L301:
	addq	$1, (%rsp)
	movq	(%rsp), %rax
	cmpq	8+g_known_functions(%rip), %rax
	jb	.L304
	movl	12(%rsp), %eax
	testl	%eax, %eax
	je	.L306
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
.L306:
	cmpq	$0, 8(%r12)
	je	.L294
	xorl	%r13d, %r13d
	jmp	.L313
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L308:
	addq	$1, %r13
	cmpq	8(%r12), %r13
	jnb	.L294
.L313:
	movq	(%r12), %rax
	movq	(%rax,%r13,8), %rax
	cmpl	$1, (%rax)
	jne	.L308
	movq	8(%rax), %r14
	leaq	.LC22(%rip), %rsi
	movq	(%r14), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L309
	cmpq	$2, 16(%r14)
	ja	.L337
.L309:
	leaq	.LC29(%rip), %rdi
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	(%r14), %rdi
	testq	%rdi, %rdi
	je	.L310
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L310:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC30(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
	movq	(%r14), %rsi
	movq	%rbx, %rdi
	call	emit_function_body_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	cmpq	$0, 16(%r14)
	je	.L311
	xorl	%ebp, %ebp
	leaq	.LC32(%rip), %r15
	jmp	.L312
	.p2align 4,,10
	.p2align 3
.L338:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC33(%rip), %rdi
	call	fwrite@PLT
.L312:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
	addq	$1, %rbp
	cmpq	16(%r14), %rbp
	jb	.L338
.L311:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	addq	$1, %r13
	leaq	.LC34(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r12), %r13
	jb	.L313
.L294:
	addq	$24, %rsp
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
.L299:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC26(%rip), %rdi
	call	fwrite@PLT
	testq	%rbp, %rbp
	je	.L303
	movq	%rbp, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L303:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC27(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 12(%rsp)
	jmp	.L301
.L337:
	leaq	.LC28(%rip), %rdi
	call	dief@PLT
	jmp	.L309
	.cfi_endproc
.LFE63:
	.size	emit_function_prototypes, .-emit_function_prototypes
	.section	.rodata.str1.1
.LC35:
	.string	"B_ADDR("
.LC36:
	.string	"argv"
.LC37:
	.string	"b_argv_vector"
.LC38:
	.string	"__b_external_%s"
.LC39:
	.string	"[0]"
	.text
	.p2align 4
	.type	emit_ival_expr.part.0, @function
emit_ival_expr.part.0:
.LFB74:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rdi, %rcx
	movl	$7, %edx
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
	movl	$1, %esi
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	leaq	.LC35(%rip), %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	call	fwrite@PLT
	movq	48(%r12), %rbx
	leaq	.LC36(%rip), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L373
.L340:
	movq	%rbx, %rdi
	call	global_data_kind
	movq	%rbx, %rdi
	cmpl	$2, %eax
	je	.L374
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	48(%r12), %rbx
	movq	%rbx, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L375
.L351:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC39(%rip), %rdi
	call	fwrite@PLT
.L349:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rsi
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
.L373:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L340
	movq	8+g_known_variables(%rip), %r14
	testq	%r14, %r14
	je	.L341
	movq	g_known_variables(%rip), %r15
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L342:
	movq	(%r15,%r13,8), %rdi
	movq	%rbx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L340
	addq	$1, %r13
	cmpq	%r14, %r13
	jne	.L342
.L341:
	movq	current_program(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L343
	movq	8(%rax), %rax
	xorl	%r13d, %r13d
	movq	%rax, 16(%rsp)
	jmp	.L344
	.p2align 4,,10
	.p2align 3
.L345:
	testl	%eax, %eax
	je	.L376
.L346:
	addq	$1, %r13
.L344:
	cmpq	%r13, 16(%rsp)
	je	.L343
	movq	24(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r13,8), %rdx
	movl	(%rdx), %eax
	cmpl	$2, %eax
	jne	.L345
	movq	8(%rdx), %rax
	movq	%rbx, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L346
	jmp	.L340
	.p2align 4,,10
	.p2align 3
.L375:
	movq	%rbx, %rdi
	call	global_data_kind
	cmpl	$1, %eax
	jne	.L349
	jmp	.L351
	.p2align 4,,10
	.p2align 3
.L374:
	call	get_mangled_name
	leaq	.LC38(%rip), %rsi
	movq	%rbp, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L349
.L343:
	movq	%rbp, %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC37(%rip), %rdi
	call	fwrite@PLT
	jmp	.L349
	.p2align 4,,10
	.p2align 3
.L376:
	movq	8(%rdx), %rax
	movq	24(%rax), %rcx
	movq	%rcx, 8(%rsp)
	testq	%rcx, %rcx
	je	.L346
	movq	16(%rax), %r14
	xorl	%r15d, %r15d
	jmp	.L347
	.p2align 4,,10
	.p2align 3
.L377:
	movq	8(%rsp), %rax
	addq	$1, %r15
	cmpq	%rax, %r15
	je	.L346
.L347:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L377
	jmp	.L340
	.cfi_endproc
.LFE74:
	.size	emit_ival_expr.part.0, .-emit_ival_expr.part.0
	.p2align 4
	.type	collect_strings_expr, @function
collect_strings_expr:
.LFB33:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L417
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
	leaq	.L383(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
.L380:
	cmpl	$10, (%rbx)
	ja	.L378
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L383:
	.long	.L378-.L383
	.long	.L391-.L383
	.long	.L378-.L383
	.long	.L390-.L383
	.long	.L382-.L383
	.long	.L421-.L383
	.long	.L421-.L383
	.long	.L420-.L383
	.long	.L420-.L383
	.long	.L384-.L383
	.long	.L382-.L383
	.text
	.p2align 4,,10
	.p2align 3
.L382:
	movq	48(%rbx), %rdi
	call	collect_strings_expr
.L421:
	movq	56(%rbx), %rbx
.L398:
	testq	%rbx, %rbx
	jne	.L380
.L378:
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
.L384:
	.cfi_restore_state
	movq	48(%rbx), %rdi
	call	collect_strings_expr
.L420:
	movq	56(%rbx), %rdi
	call	collect_strings_expr
	movq	64(%rbx), %rbx
	jmp	.L398
	.p2align 4,,10
	.p2align 3
.L390:
	movl	g_strict(%rip), %edx
	movq	48(%rbx), %rbp
	testl	%edx, %edx
	jne	.L422
.L392:
	movq	%rbp, %rdi
	call	collect_strings_expr
	cmpq	$0, 64(%rbx)
	je	.L378
	xorl	%ebp, %ebp
.L397:
	movq	56(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_expr
	cmpq	64(%rbx), %rbp
	jb	.L397
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
.L391:
	.cfi_restore_state
	movq	40(%rbx), %rsi
	movq	48(%rbx), %rdi
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_restore 13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_restore 14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_restore 15
	.cfi_def_cfa_offset 8
	jmp	get_string_id
	.p2align 4,,10
	.p2align 3
.L422:
	.cfi_restore_state
	movl	24(%rbx), %eax
	testl	%eax, %eax
	jne	.L392
	cmpl	$2, 0(%rbp)
	jne	.L392
	movq	48(%rbp), %r13
	leaq	8+names.0(%rip), %r12
	leaq	.LC13(%rip), %rsi
	jmp	.L393
	.p2align 4,,10
	.p2align 3
.L424:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L423
.L393:
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L424
	jmp	.L392
	.p2align 4,,10
	.p2align 3
.L417:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L423:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%r13, %rdi
	call	source_function
	movl	%eax, %r14d
	testl	%eax, %eax
	jne	.L392
	movq	8+external_calls(%rip), %rax
	testq	%rax, %rax
	je	.L395
	movq	external_calls(%rip), %r12
	leaq	(%r12,%rax,8), %r15
	.p2align 4
	.p2align 3
.L396:
	movq	(%r12), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	addq	$8, %r12
	movzbl	%al, %eax
	orl	%eax, %r14d
	cmpq	%r15, %r12
	jne	.L396
	testl	%r14d, %r14d
	jne	.L392
.L395:
	movq	%r13, %rdi
	call	sdup@PLT
	leaq	external_calls(%rip), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movq	48(%rbx), %rbp
	jmp	.L392
	.cfi_endproc
.LFE33:
	.size	collect_strings_expr, .-collect_strings_expr
	.p2align 4
	.type	collect_strings_init, @function
collect_strings_init:
.LFB34:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L434
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
	je	.L437
	cmpl	$1, %eax
	je	.L438
.L425:
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
.L437:
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
.L438:
	.cfi_restore_state
	cmpq	$0, 24(%rdi)
	je	.L425
	xorl	%ebp, %ebp
.L428:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_init
	cmpq	24(%rbx), %rbp
	jb	.L428
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L434:
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE34:
	.size	collect_strings_init, .-collect_strings_init
	.p2align 4
	.type	collect_strings_stmt, @function
collect_strings_stmt:
.LFB35:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L462
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L444(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L441:
	cmpl	$12, (%rbx)
	ja	.L439
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L444:
	.long	.L439-.L444
	.long	.L451-.L444
	.long	.L439-.L444
	.long	.L450-.L444
	.long	.L443-.L444
	.long	.L447-.L444
	.long	.L447-.L444
	.long	.L439-.L444
	.long	.L439-.L444
	.long	.L439-.L444
	.long	.L447-.L444
	.long	.L445-.L444
	.long	.L443-.L444
	.text
	.p2align 4,,10
	.p2align 3
.L447:
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
.L451:
	.cfi_restore_state
	cmpq	$0, 24(%rbx)
	je	.L439
	xorl	%ebp, %ebp
.L452:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_stmt
	cmpq	24(%rbx), %rbp
	jb	.L452
.L439:
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
.L443:
	.cfi_restore_state
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rbx
.L453:
	testq	%rbx, %rbx
	jne	.L441
	jmp	.L439
	.p2align 4,,10
	.p2align 3
.L445:
	movq	24(%rbx), %rbx
	jmp	.L453
	.p2align 4,,10
	.p2align 3
.L450:
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rdi
	call	collect_strings_stmt
	movq	32(%rbx), %rbx
	jmp	.L453
	.p2align 4,,10
	.p2align 3
.L462:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE35:
	.size	collect_strings_stmt, .-collect_strings_stmt
	.p2align 4
	.type	collect_strings_program, @function
collect_strings_program:
.LFB36:
	.cfi_startproc
	cmpq	$0, 8(%rdi)
	je	.L475
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
	jmp	.L472
	.p2align 4,,10
	.p2align 3
.L468:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L478
.L472:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L479
	cmpl	$2, %eax
	je	.L480
	testl	%eax, %eax
	jne	.L468
	movq	8(%rdx), %rdi
	addq	$1, %rbx
	call	collect_strings_stmt
	cmpq	8(%rbp), %rbx
	jb	.L472
.L478:
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
.L479:
	.cfi_restore_state
	movq	8(%rdx), %rax
	movq	32(%rax), %rdi
	call	collect_strings_stmt
	jmp	.L468
	.p2align 4,,10
	.p2align 3
.L480:
	movq	8(%rdx), %r12
	movq	56(%r12), %rdi
	call	collect_strings_init
	movq	32(%r12), %rdi
	testq	%rdi, %rdi
	je	.L468
	call	collect_strings_expr
	jmp	.L468
	.p2align 4,,10
	.p2align 3
.L475:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE36:
	.size	collect_strings_program, .-collect_strings_program
	.section	.rodata.str1.1
.LC40:
	.string	"  "
	.text
	.p2align 4
	.globl	emit_indent
	.type	emit_indent, @function
emit_indent:
.LFB38:
	.cfi_startproc
	testl	%esi, %esi
	jle	.L486
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	leaq	.LC40(%rip), %r13
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
.L483:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L483
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
.L486:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	ret
	.cfi_endproc
.LFE38:
	.size	emit_indent, .-emit_indent
	.section	.rodata.str1.1
.LC41:
	.string	"#line %d \"%s\"\n"
	.text
	.p2align 4
	.globl	emit_line_directive
	.type	emit_line_directive, @function
emit_line_directive:
.LFB39:
	.cfi_startproc
	movl	g_no_line(%rip), %eax
	testl	%eax, %eax
	jne	.L489
	testq	%rdx, %rdx
	jne	.L497
.L489:
	ret
	.p2align 4,,10
	.p2align 3
.L497:
	movq	%rdx, %rcx
	xorl	%eax, %eax
	movl	%esi, %edx
	leaq	.LC41(%rip), %rsi
	jmp	fprintf@PLT
	.cfi_endproc
.LFE39:
	.size	emit_line_directive, .-emit_line_directive
	.section	.rodata.str1.1
.LC42:
	.string	"\\n"
.LC43:
	.string	"\\t"
.LC44:
	.string	"\\x%02x"
	.text
	.p2align 4
	.globl	emit_c_string
	.type	emit_c_string, @function
emit_c_string:
.LFB40:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	leaq	.LC42(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	leaq	.LC44(%rip), %r13
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
	jne	.L499
	jmp	.L506
	.p2align 4,,10
	.p2align 3
.L514:
	movq	%r13, %rsi
	movq	%r12, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L502:
	movzbl	1(%rbp), %ebx
	addq	$1, %rbp
	testb	%bl, %bl
	je	.L506
.L499:
	cmpb	$92, %bl
	je	.L507
	cmpb	$34, %bl
	je	.L507
	cmpb	$10, %bl
	je	.L512
	cmpb	$9, %bl
	je	.L513
	movzbl	%bl, %edx
	cmpb	$31, %bl
	jbe	.L514
	movq	%r12, %rsi
	movl	%edx, %edi
	addq	$1, %rbp
	call	fputc@PLT
	movzbl	0(%rbp), %ebx
	testb	%bl, %bl
	jne	.L499
.L506:
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
.L507:
	.cfi_restore_state
	movq	%r12, %rsi
	movl	$92, %edi
	call	fputc@PLT
	movzbl	%bl, %edi
	movq	%r12, %rsi
	call	fputc@PLT
	jmp	.L502
	.p2align 4,,10
	.p2align 3
.L512:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	jmp	.L502
	.p2align 4,,10
	.p2align 3
.L513:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC43(%rip), %rdi
	call	fwrite@PLT
	jmp	.L502
	.cfi_endproc
.LFE40:
	.size	emit_c_string, .-emit_c_string
	.section	.rodata.str1.1
.LC45:
	.string	"preinc"
.LC46:
	.string	"predec"
.LC47:
	.string	"postinc"
.LC48:
	.string	"postdec"
.LC49:
	.string	"WAND"
.LC50:
	.string	"WOR"
.LC51:
	.string	"WADD"
.LC52:
	.string	"WSUB"
.LC53:
	.string	"WMUL"
.LC54:
	.string	"WSHR"
.LC55:
	.string	"WSHL"
.LC56:
	.string	"WMOD"
.LC57:
	.string	"WDIV"
.LC58:
	.string	"add_assign"
.LC59:
	.string	"or_assign"
.LC60:
	.string	"and_assign"
.LC61:
	.string	"rsh_assign"
.LC62:
	.string	"lsh_assign"
.LC63:
	.string	"mod_assign"
.LC64:
	.string	"div_assign"
.LC65:
	.string	"mul_assign"
.LC66:
	.string	"sub_assign"
.LC67:
	.string	"WVAL((word)%ld)"
	.section	.rodata.str1.8
	.align 8
.LC68:
	.string	"B_PTR_N(__b_str%d, sizeof(__b_str%d))"
	.section	.rodata.str1.1
.LC69:
	.string	"__b_label_value_%d"
.LC70:
	.string	"__bcc_parameters[%zu]"
.LC71:
	.string	"B_FUNCTION("
.LC72:
	.string	"((word (*)())B_FUNCTION_CPTR("
.LC73:
	.string	"))("
.LC74:
	.string	"callf"
.LC75:
	.string	"b_callf_dispatch(%zu"
.LC76:
	.string	"printf"
.LC77:
	.string	"malloc"
.LC78:
	.string	"calloc"
.LC79:
	.string	"realloc"
.LC80:
	.string	"B_PTR("
.LC81:
	.string	"-+ #0"
.LC82:
	.string	"exit"
.LC83:
	.string	"strlen"
.LC84:
	.string	"atoi"
.LC85:
	.string	"memmove"
.LC86:
	.string	"tcgetattr"
.LC87:
	.string	"tcsetattr"
.LC88:
	.string	"ioctl"
.LC89:
	.string	"memset"
.LC90:
	.string	"memcpy"
.LC91:
	.string	"__b_cstr("
.LC92:
	.string	"B_CPTR("
	.section	.rodata.str1.8
	.align 8
.LC93:
	.string	"(size_t)(sizeof(word) * (uword)("
	.section	.rodata.str1.1
.LC94:
	.string	"))"
.LC95:
	.string	"B_INDEX("
.LC96:
	.string	"B_DEREF("
.LC97:
	.string	"b_"
.LC98:
	.string	"(&("
.LC99:
	.string	"WNEG("
.LC100:
	.string	"({ word __b_left_%u = "
.LC101:
	.string	"; word __b_right_%u = "
	.section	.rodata.str1.8
	.align 8
.LC102:
	.string	"; (word)%s(__b_left_%u, __b_right_%u); })"
	.section	.rodata.str1.1
.LC103:
	.string	"%s("
.LC104:
	.string	" %s "
.LC105:
	.string	" = ("
.LC106:
	.string	"), "
.LC107:
	.string	" ? "
.LC108:
	.string	" : "
.LC109:
	.string	"snprintf"
.LC110:
	.string	"sprintf"
.LC111:
	.string	"fprintf"
.LC112:
	.string	"dprintf"
	.text
	.p2align 4
	.globl	emit_expr
	.type	emit_expr, @function
emit_expr:
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
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	cmpl	$10, (%rsi)
	movq	%rdi, 8(%rsp)
	ja	.L515
	movl	(%rsi), %eax
	movq	%rdx, %rbp
	leaq	.L518(%rip), %rdx
	movq	%rsi, %r15
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L518:
	.long	.L528-.L518
	.long	.L527-.L518
	.long	.L526-.L518
	.long	.L525-.L518
	.long	.L524-.L518
	.long	.L523-.L518
	.long	.L522-.L518
	.long	.L521-.L518
	.long	.L520-.L518
	.long	.L519-.L518
	.long	.L517-.L518
	.text
	.p2align 4,,10
	.p2align 3
.L519:
	movq	8(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC107(%rip), %rdi
	call	fwrite@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$3, %edx
	leaq	.LC108(%rip), %rdi
	call	fwrite@PLT
	movq	64(%r15), %rsi
.L965:
	movq	%rbp, %rdx
.L966:
	movq	%rbx, %rdi
	call	emit_expr
.L967:
	movq	%rbx, %rsi
.L970:
	addq	$88, %rsp
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
.L517:
	.cfi_restore_state
	movq	8(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
.L969:
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC33(%rip), %rdi
.L968:
	call	fwrite@PLT
	movq	56(%r15), %rsi
	jmp	.L965
	.p2align 4,,10
	.p2align 3
.L528:
	movq	48(%rsi), %rdx
	leaq	.LC67(%rip), %rsi
.L963:
	movq	8(%rsp), %rdi
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
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
.L527:
	.cfi_restore_state
	movq	48(%r15), %rdi
	movq	40(%rsi), %rsi
	call	get_string_id
	movq	8(%rsp), %rdi
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC68(%rip), %rsi
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
.L526:
	.cfi_restore_state
	movq	8+function_labels(%rip), %r13
	movq	48(%rsi), %r12
	testq	%r13, %r13
	je	.L529
	movq	function_labels(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L532
	.p2align 4,,10
	.p2align 3
.L530:
	addq	$1, %rbp
	cmpq	%r13, %rbp
	je	.L529
.L532:
	movq	(%r14,%rbp,8), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L530
	movl	%ebp, %edx
	addl	$1, %edx
	je	.L529
	movq	8(%rsp), %rdi
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC69(%rip), %rsi
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
.L525:
	.cfi_restore_state
	movq	48(%rsi), %rax
	movl	24(%rsi), %ebx
	cmpl	$2, (%rax)
	je	.L540
	testl	%ebx, %ebx
	jne	.L541
	movb	$0, 38(%rsp)
	movq	48(%rax), %rsi
	xorl	%r12d, %r12d
	xorl	%r14d, %r14d
	movb	$0, 39(%rsp)
	movq	$0, 24(%rsp)
.L564:
	movq	8(%rsp), %rdi
	call	emit_function_name
.L571:
	movq	8(%rsp), %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	64(%r15), %rdx
	movq	24(%rsp), %rcx
	cmpq	%rdx, %rcx
	jnb	.L572
	cmpb	$0, 39(%rsp)
	je	.L572
	movq	56(%r15), %rax
	movq	(%rax,%rcx,8), %rax
	testq	%rax, %rax
	je	.L599
	cmpl	$1, (%rax)
	je	.L975
.L599:
	movq	$0, 40(%rsp)
.L575:
	movl	%ebx, 48(%rsp)
	movq	8(%rsp), %r13
	xorl	%r12d, %r12d
	movq	%r14, 16(%rsp)
	movq	%rdx, %r14
.L638:
	cmpb	$0, 38(%rsp)
	je	.L713
	movl	g_strict(%rip), %ebx
	testl	%ebx, %ebx
	je	.L976
.L713:
	xorl	%ebx, %ebx
.L601:
	movq	56(%r15), %rax
	movq	%rbp, %rdx
	movq	%r13, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
.L678:
	testl	%ebx, %ebx
	jne	.L977
.L636:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L637
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC33(%rip), %rdi
	call	fwrite@PLT
	jmp	.L638
	.p2align 4,,10
	.p2align 3
.L524:
	movq	8(%rsp), %rbx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC95(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	jmp	.L969
	.p2align 4,,10
	.p2align 3
.L523:
	movl	48(%rsi), %r12d
	cmpl	$32, %r12d
	je	.L978
	cmpl	$53, %r12d
	je	.L979
	leal	-36(%r12), %eax
	cmpl	$1, %eax
	jbe	.L980
	movq	8(%rsp), %rbx
	cmpl	$31, %r12d
	jne	.L647
	movl	current_word_bits(%rip), %edi
	testl	%edi, %edi
	jne	.L981
.L647:
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movl	%r12d, %edi
	call	tk_name@PLT
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	jmp	.L971
	.p2align 4,,10
	.p2align 3
.L522:
	movq	56(%rsi), %r12
	movl	48(%rsi), %r13d
	testq	%r12, %r12
	je	.L648
	movl	(%r12), %eax
	cmpl	$4, %eax
	je	.L649
	cmpl	$5, %eax
	jne	.L648
	cmpl	$32, 48(%r12)
	je	.L649
	.p2align 4
	.p2align 3
.L648:
	movl	current_word_bits(%rip), %esi
	testl	%esi, %esi
	je	.L650
.L649:
	movq	8(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC97(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	cmpl	$36, %r13d
	movq	%rbx, %rcx
	movl	$7, %edx
	leaq	.LC47(%rip), %rax
	leaq	.LC48(%rip), %rdi
	movl	$1, %esi
	cmove	%rax, %rdi
	call	fwrite@PLT
	movl	$3, %edx
	movq	%rbx, %rcx
	movl	$1, %esi
	leaq	.LC98(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r12, %rsi
.L971:
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC94(%rip), %rdi
.L964:
	addq	$88, %rsp
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
.L521:
	.cfi_restore_state
	movl	48(%rsi), %r12d
	leal	-53(%r12), %eax
	cmpl	$1, %eax
	jbe	.L982
	movl	current_word_bits(%rip), %ecx
	testl	%ecx, %ecx
	je	.L654
	leal	-28(%r12), %eax
	cmpl	$6, %eax
	ja	.L654
	leaq	.L656(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L656:
	.long	.L724-.L656
	.long	.L661-.L656
	.long	.L660-.L656
	.long	.L659-.L656
	.long	.L658-.L656
	.long	.L657-.L656
	.long	.L655-.L656
	.text
	.p2align 4,,10
	.p2align 3
.L520:
	movl	48(%rsi), %r12d
	movq	56(%rsi), %r13
	movq	64(%rsi), %r14
	leal	-47(%r12), %eax
	cmpl	$5, %eax
	jbe	.L983
	cmpl	$21, %r12d
	je	.L664
	testq	%r13, %r13
	je	.L665
	movl	0(%r13), %eax
	cmpl	$4, %eax
	je	.L666
	cmpl	$5, %eax
	je	.L984
.L665:
	movl	current_word_bits(%rip), %edx
	testl	%edx, %edx
	je	.L664
.L666:
	leal	-38(%r12), %eax
	cmpl	$8, %eax
	ja	.L664
	leaq	.L669(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L669:
	.long	.L677-.L669
	.long	.L676-.L669
	.long	.L675-.L669
	.long	.L674-.L669
	.long	.L673-.L669
	.long	.L672-.L669
	.long	.L671-.L669
	.long	.L725-.L669
	.long	.L668-.L669
	.text
	.p2align 4,,10
	.p2align 3
.L596:
	testq	%rdx, %rdx
	jne	.L599
	movq	8(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	jne	.L600
.L515:
	addq	$88, %rsp
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
.L529:
	.cfi_restore_state
	movq	32(%r15), %rdx
	testq	%rdx, %rdx
	jne	.L985
	movl	16(%r15), %ebp
	testl	%ebp, %ebp
	jne	.L986
	movl	12(%r15), %ebx
	testl	%ebx, %ebx
	jne	.L987
	movl	20(%r15), %eax
	cmpl	$2, %eax
	je	.L988
	testq	%r12, %r12
	je	.L539
	movq	%r12, %rdi
	call	get_mangled_name
	movq	8(%rsp), %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movl	20(%r15), %eax
.L539:
	cmpl	$1, %eax
	jne	.L515
.L537:
	movq	8(%rsp), %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC39(%rip), %rdi
	jmp	.L964
	.p2align 4,,10
	.p2align 3
.L976:
	movq	16(%rsp), %rdi
	call	source_function
	movl	%eax, %edx
	testl	%eax, %eax
	jne	.L601
	cmpq	%r12, 24(%rsp)
	movl	current_byteptr(%rip), %ebx
	sete	%al
	testb	%al, 39(%rsp)
	jne	.L602
	movq	40(%rsp), %rax
	testq	%rax, %rax
	je	.L603
	movl	(%rax,%r12,4), %r9d
	testl	%r9d, %r9d
	jne	.L602
.L603:
	movq	16(%rsp), %rdi
	leaq	.LC83(%rip), %rsi
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	movl	56(%rsp), %edx
	testl	%eax, %eax
	jne	.L606
	testq	%r12, %r12
	je	.L602
.L607:
	movq	16(%rsp), %rdi
	leaq	.LC85(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L608
	cmpq	$1, %r12
	jbe	.L989
.L610:
	movq	16(%rsp), %rdi
	leaq	.LC87(%rip), %rsi
	call	strcmp@PLT
	movl	%eax, 56(%rsp)
	testl	%eax, %eax
	jne	.L613
	cmpq	$2, %r12
	je	.L614
.L609:
	movq	16(%rsp), %rdi
	leaq	.LC89(%rip), %rsi
	call	strcmp@PLT
	testq	%r12, %r12
	movl	%eax, %edx
	sete	%al
	movb	%al, 64(%rsp)
	testl	%edx, %edx
	jne	.L617
	testb	%al, %al
	jne	.L960
.L617:
	movq	16(%rsp), %rdi
	leaq	.LC90(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L621
	cmpq	$1, %r12
	jbe	.L960
.L620:
	leaq	.LC79(%rip), %rcx
	movq	16(%rsp), %rdi
	movq	%rcx, %rsi
	movq	%rcx, 72(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L717
	movb	$0, 64(%rsp)
	leaq	.LC79(%rip), %rcx
.L624:
	movq	16(%rsp), %rdi
	leaq	.LC78(%rip), %rsi
	movq	%rcx, 72(%rsp)
	call	strcmp@PLT
	movq	72(%rsp), %rcx
	testl	%eax, %eax
	movl	56(%rsp), %eax
	sete	%dl
	andb	64(%rsp), %dl
	xorl	$1, %edx
	movzbl	%dl, %edx
	andl	%eax, %edx
	testl	%ebx, %ebx
	jne	.L623
	movq	16(%rsp), %rdi
	leaq	.LC77(%rip), %rsi
	movq	%rcx, 72(%rsp)
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	movl	56(%rsp), %edx
	movq	72(%rsp), %rcx
	testl	%eax, %eax
	jne	.L745
	cmpb	$0, 64(%rsp)
	je	.L745
.L736:
	movl	%edx, %ebx
.L953:
	testl	%edx, %edx
	jne	.L633
.L632:
	movq	%r13, %rcx
	movl	$32, %edx
	movl	$1, %esi
	leaq	.LC93(%rip), %rdi
	call	fwrite@PLT
	movq	56(%r15), %rax
	movq	%rbp, %rdx
	movq	%r13, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC94(%rip), %rdi
	call	fwrite@PLT
	jmp	.L678
	.p2align 4,,10
	.p2align 3
.L654:
	movq	8(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edi
	call	tk_name@PLT
	leaq	.LC104(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	64(%r15), %rsi
	jmp	.L965
	.p2align 4,,10
	.p2align 3
.L985:
	subq	$1, %rdx
	leaq	.LC70(%rip), %rsi
	jmp	.L963
	.p2align 4,,10
	.p2align 3
.L650:
	movq	8(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	%r12, %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r13d, %edi
	call	tk_name@PLT
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	jmp	.L967
	.p2align 4,,10
	.p2align 3
.L980:
	movq	56(%rsi), %r13
	testq	%r13, %r13
	je	.L643
	movl	0(%r13), %eax
	cmpl	$4, %eax
	je	.L644
	cmpl	$5, %eax
	je	.L990
.L643:
	movl	current_word_bits(%rip), %r8d
	testl	%r8d, %r8d
	je	.L645
.L644:
	movq	8(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC97(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	cmpl	$36, %r12d
	movq	%rbx, %rcx
	movl	$6, %edx
	leaq	.LC45(%rip), %rax
	leaq	.LC46(%rip), %rdi
	movl	$1, %esi
	cmove	%rax, %rdi
	call	fwrite@PLT
	movl	$3, %edx
	movq	%rbx, %rcx
	movl	$1, %esi
	leaq	.LC98(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	jmp	.L971
	.p2align 4,,10
	.p2align 3
.L541:
	movq	8(%rsp), %rbx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC72(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L545:
	movq	8(%rsp), %rbx
	movl	$3, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC73(%rip), %rdi
	leaq	.LC33(%rip), %r13
	movq	%rbx, %rcx
	call	fwrite@PLT
	cmpq	$0, 64(%r15)
	je	.L551
.L550:
	movq	56(%r15), %rax
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	emit_expr
	cmpq	64(%r15), %r12
	jnb	.L551
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	jmp	.L550
.L661:
	leaq	.LC54(%rip), %rdx
	.p2align 4
	.p2align 3
.L662:
	movq	8(%rsp), %rbx
	leaq	.LC103(%rip), %rsi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	call	fprintf@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC33(%rip), %rdi
	call	fwrite@PLT
	movq	64(%r15), %rsi
	jmp	.L965
.L724:
	leaq	.LC55(%rip), %rdx
	jmp	.L662
.L655:
	leaq	.LC56(%rip), %rdx
	jmp	.L662
.L660:
	leaq	.LC51(%rip), %rdx
	jmp	.L662
.L657:
	leaq	.LC57(%rip), %rdx
	jmp	.L662
.L658:
	leaq	.LC53(%rip), %rdx
	jmp	.L662
.L659:
	leaq	.LC52(%rip), %rdx
	jmp	.L662
.L725:
	leaq	.LC60(%rip), %r12
	.p2align 4
	.p2align 3
.L670:
	movq	8(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC97(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC98(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	$3, %edx
	movq	%rbx, %rcx
	movl	$1, %esi
	leaq	.LC106(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	jmp	.L966
.L668:
	leaq	.LC59(%rip), %r12
	jmp	.L670
.L677:
	leaq	.LC58(%rip), %r12
	jmp	.L670
.L675:
	leaq	.LC65(%rip), %r12
	jmp	.L670
.L676:
	leaq	.LC66(%rip), %r12
	jmp	.L670
.L671:
	leaq	.LC61(%rip), %r12
	jmp	.L670
.L672:
	leaq	.LC62(%rip), %r12
	jmp	.L670
.L673:
	leaq	.LC63(%rip), %r12
	jmp	.L670
.L674:
	leaq	.LC64(%rip), %r12
	jmp	.L670
	.p2align 4,,10
	.p2align 3
.L977:
	movq	%r13, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L636
	.p2align 4,,10
	.p2align 3
.L637:
	movl	48(%rsp), %ebx
	movq	8(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	jne	.L598
.L639:
	movq	40(%rsp), %rax
	testq	%rax, %rax
	je	.L515
	addq	$88, %rsp
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
.L664:
	.cfi_restore_state
	movq	8(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edi
	call	assignment_op_to_c
	leaq	.LC104(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	jmp	.L966
	.p2align 4,,10
	.p2align 3
.L572:
	testb	%r12b, %r12b
	je	.L596
	leaq	.LC82(%rip), %rsi
	movq	%r14, %rdi
	movq	%rdx, 16(%rsp)
	call	strcmp@PLT
	movq	16(%rsp), %rdx
	testl	%eax, %eax
	jne	.L596
	testq	%rdx, %rdx
	jne	.L599
	movq	8(%rsp), %r14
	movl	$48, %edi
	movq	%r14, %rsi
	call	fputc@PLT
	movq	%r14, %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	je	.L515
.L600:
	movq	$0, 40(%rsp)
	.p2align 4
	.p2align 3
.L598:
	movq	8(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L639
	.p2align 4,,10
	.p2align 3
.L540:
	movq	48(%rax), %r14
	testq	%r14, %r14
	je	.L991
	testl	%ebx, %ebx
	jne	.L541
	movq	%r14, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L549
	movl	g_strict(%rip), %r11d
	testl	%r11d, %r11d
	je	.L547
	leaq	8+names.0(%rip), %r12
	leaq	.LC13(%rip), %rsi
	jmp	.L548
	.p2align 4,,10
	.p2align 3
.L992:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L549
.L548:
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L992
.L547:
	leaq	.LC74(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L703
	.p2align 4
	.p2align 3
.L553:
	leaq	8+names.0(%rip), %r12
	leaq	.LC13(%rip), %rsi
	jmp	.L557
	.p2align 4,,10
	.p2align 3
.L994:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L993
.L557:
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L994
	movq	%r14, %rdi
	movl	g_strict(%rip), %r12d
	call	source_function
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L995
	testl	%r12d, %r12d
	je	.L691
	movb	$0, 39(%rsp)
	movq	%r14, %rsi
	movq	$0, 24(%rsp)
.L685:
	movq	8(%rsp), %rdi
	movq	%rsi, %rdx
	xorl	%eax, %eax
	movl	$1, %r12d
	leaq	.LC25(%rip), %rsi
	call	fprintf@PLT
	movb	$1, 38(%rsp)
	jmp	.L571
.L554:
	movq	8(%rsp), %rbx
	leaq	-1(%r14), %rdx
	xorl	%eax, %eax
	xorl	%r12d, %r12d
	leaq	.LC75(%rip), %rsi
	leaq	.LC33(%rip), %r13
	movq	%rbx, %rdi
	call	fprintf@PLT
.L555:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	56(%r15), %rax
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	emit_expr
	cmpq	%r12, %r14
	jne	.L555
	.p2align 4
	.p2align 3
.L551:
	movq	8(%rsp), %rsi
	jmp	.L970
	.p2align 4,,10
	.p2align 3
.L602:
	testl	%ebx, %ebx
	je	.L604
.L605:
	movq	%r13, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC91(%rip), %rdi
	call	fwrite@PLT
.L635:
	movl	$1, %ebx
	jmp	.L601
	.p2align 4,,10
	.p2align 3
.L983:
	movq	8(%rsp), %rbx
	leaq	CSWTCH.175(%rip), %rdx
	movl	$40, %edi
	movl	(%rdx,%rax,4), %r12d
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edi
	call	tk_name@PLT
	leaq	.LC104(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	jmp	.L971
.L993:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L996
.L699:
	leaq	.LC76(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	je	.L559
.L742:
	movq	$0, 24(%rsp)
	movb	$0, 39(%rsp)
.L560:
	movb	$1, 38(%rsp)
	movq	%r14, %rsi
	xorl	%r12d, %r12d
	xorl	%ebx, %ebx
	jmp	.L564
	.p2align 4,,10
	.p2align 3
.L982:
	movl	expression_id(%rip), %eax
	movq	8(%rsp), %rbx
	leaq	.LC100(%rip), %rsi
	leal	1(%rax), %r13d
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movl	%r13d, %edx
	movl	%r13d, expression_id(%rip)
	call	fprintf@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r13d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC101(%rip), %rsi
	call	fprintf@PLT
	movq	64(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	cmpl	$53, %r12d
	movl	%r13d, %r8d
	movl	%r13d, %ecx
	leaq	.LC49(%rip), %rax
	leaq	.LC50(%rip), %rdx
	movq	%rbx, %rdi
	cmove	%rax, %rdx
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC102(%rip), %rsi
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
.L986:
	.cfi_restore_state
	movq	8(%rsp), %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC37(%rip), %rdi
	jmp	.L964
.L606:
	movq	16(%rsp), %rdi
	leaq	.LC84(%rip), %rsi
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L607
	testq	%r12, %r12
	jne	.L607
	testl	%ebx, %ebx
	movl	56(%rsp), %edx
	jne	.L605
	.p2align 4
	.p2align 3
.L604:
	movq	16(%rsp), %rdi
	leaq	.LC77(%rip), %rsi
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	testq	%r12, %r12
	movl	56(%rsp), %edx
	jne	.L744
	testl	%eax, %eax
	je	.L955
.L744:
	movl	$1, %ebx
	leaq	.LC79(%rip), %rcx
.L681:
	movq	16(%rsp), %rdi
	movq	%rcx, %rsi
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	movl	56(%rsp), %edx
	testl	%eax, %eax
	jne	.L627
	cmpq	$1, %r12
	je	.L997
.L629:
	testl	%ebx, %ebx
	jne	.L605
.L623:
	xorl	%ebx, %ebx
	testl	%edx, %edx
	je	.L601
.L619:
	movq	%r13, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC92(%rip), %rdi
	call	fwrite@PLT
	jmp	.L635
.L984:
	cmpl	$32, 48(%r13)
	jne	.L665
	jmp	.L666
.L978:
	movq	8(%rsp), %rbx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC96(%rip), %rdi
	movq	%rbx, %rcx
	jmp	.L968
.L979:
	movq	8(%rsp), %rbx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC35(%rip), %rdi
	movq	%rbx, %rcx
	jmp	.L968
.L991:
	testl	%ebx, %ebx
	jne	.L541
	xorl	%edi, %edi
	leaq	.LC74(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L553
	xorl	%edi, %edi
	call	source_function
	testl	%eax, %eax
	jne	.L553
.L703:
	movq	64(%r15), %r14
	testq	%r14, %r14
	jne	.L554
	movq	8(%rsp), %rdi
	xorl	%edx, %edx
	leaq	.LC75(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L551
.L549:
	movq	8(%rsp), %rbx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC72(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	%r14, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC39(%rip), %rdi
	call	fwrite@PLT
	jmp	.L545
.L987:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L998
	movq	8(%rsp), %rbx
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC71(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	48(%r15), %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	jmp	.L967
.L981:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC99(%rip), %rdi
	jmp	.L968
.L608:
	movq	16(%rsp), %rdi
	leaq	.LC86(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L610
	cmpq	$1, %r12
	jne	.L610
	movq	16(%rsp), %rdi
	leaq	.LC90(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L951
	testl	%ebx, %ebx
	jne	.L619
	leaq	.LC79(%rip), %rcx
	movq	16(%rsp), %rdi
	movq	%rcx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L735
	xorl	%ebx, %ebx
	movl	$1, %edx
.L627:
	movq	16(%rsp), %rdi
	leaq	.LC78(%rip), %rsi
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	cmpq	$1, %r12
	movl	56(%rsp), %edx
	jne	.L629
	testl	%eax, %eax
	jne	.L629
	testl	%ebx, %ebx
	jne	.L955
	xorl	%ebx, %ebx
	jmp	.L953
.L996:
	movq	%r14, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L742
	leaq	.LC77(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	leaq	.LC76(%rip), %rsi
	movq	%r14, %rdi
	movl	%eax, %ebx
	call	strcmp@PLT
	movl	%eax, %r12d
	testl	%ebx, %ebx
	je	.L562
	leaq	.LC78(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	je	.L562
	xorl	%ebx, %ebx
.L698:
	leaq	.LC79(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L562
	testl	%r12d, %r12d
	je	.L999
	leaq	.LC111(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L738
	leaq	.LC112(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L738
	leaq	.LC110(%rip), %rsi
	movq	%r14, %rdi
	xorl	%r12d, %r12d
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L687
.L738:
	movb	$1, 39(%rsp)
	movq	$1, 24(%rsp)
.L570:
	testl	%ebx, %ebx
	je	.L560
	movq	%r14, %rsi
	xorl	%ebx, %ebx
	jmp	.L685
	.p2align 4,,10
	.p2align 3
.L559:
	movq	%r14, %rdi
	xorl	%r12d, %r12d
	call	source_function
	movb	$1, 38(%rsp)
	movq	%r14, %rsi
	movq	$0, 24(%rsp)
	xorl	$1, %eax
	andl	$1, %eax
	movb	%al, 39(%rsp)
	jmp	.L564
.L975:
	movq	%rdx, %rdi
	movl	$4, %esi
	movq	%rdx, 16(%rsp)
	movq	48(%rax), %r12
	call	calloc@PLT
	movq	16(%rsp), %rdx
	testq	%rax, %rax
	movq	%rax, 40(%rsp)
	je	.L599
	movq	24(%rsp), %rax
	xorl	%r13d, %r13d
	leaq	1(%rax), %rsi
	movzbl	(%r12), %eax
	testb	%al, %al
	je	.L575
	movq	%r14, 48(%rsp)
	movl	%ebx, 16(%rsp)
	movq	%rsi, %rbx
	movq	%rbp, 56(%rsp)
	movq	%r12, %rbp
	movq	%rdx, %r12
	.p2align 4
	.p2align 3
.L574:
	cmpb	$37, %al
	jne	.L947
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	cmpb	$37, %r14b
	je	.L947
	testb	%r14b, %r14b
	jne	.L577
	jmp	.L945
	.p2align 4,,10
	.p2align 3
.L580:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	testb	%r14b, %r14b
	je	.L579
.L577:
	movsbl	%r14b, %esi
	leaq	.LC81(%rip), %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L580
	cmpb	$42, %r14b
	jne	.L579
	cmpq	%r12, %rbx
	adcq	$0, %rbx
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %edx
.L584:
	cmpb	$46, %dl
	je	.L1000
.L586:
	cmpb	$104, %dl
	je	.L1001
	cmpb	$108, %dl
	je	.L1002
	testb	%dl, %dl
	je	.L945
	leaq	1(%r13), %rax
	cmpq	%r12, %rbx
	jnb	.L592
	cmpb	$115, %dl
	jne	.L592
	movq	40(%rsp), %rcx
	movl	$1, (%rcx,%rbx,4)
	.p2align 4
	.p2align 3
.L592:
	addq	$1, %rbx
.L576:
	movq	%rax, %r13
	movzbl	0(%rbp,%rax), %eax
	testb	%al, %al
	jne	.L574
.L945:
	movl	16(%rsp), %ebx
	movq	48(%rsp), %r14
	movq	%r12, %rdx
	movq	56(%rsp), %rbp
	jmp	.L575
	.p2align 4,,10
	.p2align 3
.L947:
	leaq	1(%r13), %rax
	jmp	.L576
.L579:
	movzbl	0(%rbp,%r13), %edx
	testb	%dl, %dl
	movb	%dl, 64(%rsp)
	je	.L945
	call	__ctype_b_loc@PLT
	movzbl	64(%rsp), %edx
	movq	(%rax), %rax
	jmp	.L582
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L585:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %edx
	testb	%dl, %dl
	je	.L945
.L582:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L585
	movzbl	0(%rbp,%r13), %edx
	jmp	.L584
.L1000:
	movzbl	1(%rbp,%r13), %edx
	leaq	1(%r13), %rdi
	movq	%rdi, 64(%rsp)
	cmpb	$42, %dl
	jne	.L1003
	cmpq	%r12, %rbx
	adcq	$0, %rbx
	addq	$2, %r13
	movzbl	0(%rbp,%r13), %edx
	jmp	.L586
.L1001:
	cmpb	$104, 1(%rbp,%r13)
	leaq	1(%r13), %rax
	jne	.L592
.L711:
	leaq	2(%r13), %rax
	jmp	.L592
.L1002:
	cmpb	$108, 1(%rbp,%r13)
	leaq	1(%r13), %rax
	jne	.L592
	jmp	.L711
.L645:
	movl	%r12d, %edi
	call	tk_name@PLT
	movq	8(%rsp), %rbx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	call	fputs@PLT
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	jmp	.L966
.L995:
	testl	%r12d, %r12d
	jne	.L699
	jmp	.L742
.L990:
	cmpl	$32, 48(%r13)
	jne	.L643
	jmp	.L644
.L988:
	movq	%r12, %rdi
	call	get_mangled_name
	leaq	.LC38(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L963
.L998:
	testq	%r12, %r12
	je	.L537
	movq	%r12, %rdi
	call	get_mangled_name
	movq	8(%rsp), %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	jmp	.L537
.L1003:
	testb	%dl, %dl
	movb	%dl, 72(%rsp)
	je	.L945
	call	__ctype_b_loc@PLT
	movzbl	72(%rsp), %edx
	movq	64(%rsp), %rdi
	movq	(%rax), %rax
	jmp	.L588
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L590:
	addq	$1, %rdi
	movzbl	0(%rbp,%rdi), %edx
	testb	%dl, %dl
	je	.L945
.L588:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L590
	movzbl	0(%rbp,%rdi), %edx
	movq	%rdi, %r13
	jmp	.L586
.L687:
	leaq	.LC109(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L728
	movb	$1, 39(%rsp)
	movq	$2, 24(%rsp)
.L686:
	testl	%r12d, %r12d
	je	.L570
.L688:
	movq	8(%rsp), %rcx
	movl	$1, %esi
	movl	$6, %edx
	leaq	.LC80(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rax
	movq	48(%rax), %rsi
	testl	%ebx, %ebx
	je	.L707
	cmpl	$2, (%rax)
	je	.L685
	movb	$1, 38(%rsp)
	movl	$1, %r12d
	jmp	.L564
.L951:
	movb	$0, 64(%rsp)
	movl	$1, 56(%rsp)
.L621:
	leaq	.LC79(%rip), %rcx
	movq	16(%rsp), %rdi
	movq	%rcx, %rsi
	movq	%rcx, 72(%rsp)
	call	strcmp@PLT
	leaq	.LC79(%rip), %rcx
	testl	%eax, %eax
	jne	.L624
	movzbl	64(%rsp), %edx
	movl	56(%rsp), %eax
	orl	%eax, %edx
	testl	%ebx, %ebx
	jne	.L623
	movq	16(%rsp), %rdi
	leaq	.LC77(%rip), %rsi
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	movl	56(%rsp), %edx
	testl	%eax, %eax
	jne	.L694
	cmpb	$0, 64(%rsp)
	movl	%edx, %ebx
	jne	.L953
.L694:
	cmpq	$1, %r12
	jne	.L623
	jmp	.L736
	.p2align 4,,10
	.p2align 3
.L562:
	testl	%r12d, %r12d
	je	.L1004
.L931:
	leaq	.LC111(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L739
	leaq	.LC112(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L739
	leaq	.LC110(%rip), %rsi
	movq	%r14, %rdi
	movl	$1, %r12d
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L687
.L739:
	movb	$1, 39(%rsp)
	movq	$1, 24(%rsp)
	jmp	.L688
.L613:
	movq	16(%rsp), %rdi
	leaq	.LC88(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L743
	cmpq	$2, %r12
	je	.L614
.L743:
	movl	$0, 56(%rsp)
	jmp	.L609
.L997:
	testl	%ebx, %ebx
	je	.L736
.L955:
	movq	%r13, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC91(%rip), %rdi
	call	fwrite@PLT
.L631:
	movl	$1, %ebx
	jmp	.L632
.L960:
	testl	%ebx, %ebx
	jne	.L619
	movq	16(%rsp), %rdi
	leaq	.LC77(%rip), %rsi
	call	strcmp@PLT
	testb	$1, %r12b
	jne	.L746
	testl	%eax, %eax
	je	.L633
.L746:
	xorl	%ebx, %ebx
	movl	$1, %edx
	leaq	.LC79(%rip), %rcx
	jmp	.L681
.L1004:
	movq	8(%rsp), %rcx
	movl	$1, %esi
	movl	$6, %edx
	leaq	.LC80(%rip), %rdi
	xorl	%r12d, %r12d
	movl	$1, %ebx
	call	fwrite@PLT
	movq	48(%r15), %rax
	movb	$1, 38(%rsp)
	movb	$1, 39(%rsp)
	movq	$0, 24(%rsp)
	movq	48(%rax), %rsi
	jmp	.L564
.L728:
	movb	$0, 39(%rsp)
	movq	$0, 24(%rsp)
	jmp	.L686
.L691:
	leaq	.LC77(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L740
	leaq	.LC78(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L740
	leaq	.LC76(%rip), %rsi
	movq	%r14, %rdi
	movl	$1, %ebx
	call	strcmp@PLT
	orl	$1, %eax
	movl	%eax, %r12d
	jmp	.L698
.L633:
	movq	%r13, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC92(%rip), %rdi
	call	fwrite@PLT
	jmp	.L631
.L614:
	movq	16(%rsp), %rdi
	leaq	.LC90(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L951
	movl	$1, 56(%rsp)
	jmp	.L620
.L989:
	movl	$1, 56(%rsp)
	jmp	.L609
.L717:
	movl	56(%rsp), %edx
	jmp	.L623
.L740:
	movl	$1, %ebx
	jmp	.L931
.L735:
	movl	$1, %edx
	jmp	.L736
.L999:
	xorl	%r10d, %r10d
	movb	$1, 38(%rsp)
	movq	%r14, %rsi
	xorl	%ebx, %ebx
	movb	$1, 39(%rsp)
	xorl	%r12d, %r12d
	movq	%r10, 24(%rsp)
	jmp	.L564
.L707:
	movb	$1, 38(%rsp)
	xorl	%r12d, %r12d
	movl	$1, %ebx
	jmp	.L564
.L745:
	xorl	%ebx, %ebx
	jmp	.L681
	.cfi_endproc
.LFE49:
	.size	emit_expr, .-emit_expr
	.section	.rodata.str1.1
.LC113:
	.string	"word __%s_store[("
.LC114:
	.string	")];\n"
.LC115:
	.string	"word %s = 0;\n"
	.section	.rodata.str1.8
	.align 8
.LC116:
	.string	"(void)B_LOCAL_PTR_N(&%s, sizeof(%s));\n"
	.text
	.p2align 4
	.type	emit_auto_storage, @function
emit_auto_storage:
.LFB58:
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
	movl	%edx, %r13d
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
	movq	%rsi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movq	(%rsi), %rdi
	movq	%rcx, 8(%rsp)
	call	get_mangled_name
	cmpq	$0, 8(%rbx)
	movq	%rax, %r15
	je	.L1006
	testl	%r13d, %r13d
	jle	.L1007
	xorl	%r12d, %r12d
	leaq	.LC40(%rip), %r14
	.p2align 4
	.p2align 3
.L1008:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r13d
	jne	.L1008
.L1007:
	movq	%r15, %rdx
	leaq	.LC113(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	8(%rbx), %rsi
	movq	8(%rsp), %rdx
	movq	%rbp, %rdi
	call	emit_expr
	movq	%rbp, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC114(%rip), %rdi
	call	fwrite@PLT
.L1006:
	testl	%r13d, %r13d
	jle	.L1009
	xorl	%ebx, %ebx
	leaq	.LC40(%rip), %r14
	.p2align 4
	.p2align 3
.L1010:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %r12d
	leal	1(%rbx), %ebx
	cmpl	%ebx, %r13d
	jne	.L1010
	xorl	%eax, %eax
	movq	%r15, %rdx
	leaq	.LC115(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L1021
.L1005:
	addq	$24, %rsp
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
.L1021:
	.cfi_restore_state
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1015:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %r12d
	jne	.L1015
.L1012:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r15, %rcx
	movq	%r15, %rdx
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC116(%rip), %rsi
	popq	%rbp
	.cfi_def_cfa_offset 40
	xorl	%eax, %eax
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
.L1009:
	.cfi_restore_state
	xorl	%eax, %eax
	movq	%r15, %rdx
	leaq	.LC115(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L1005
	jmp	.L1012
	.cfi_endproc
.LFE58:
	.size	emit_auto_storage, .-emit_auto_storage
	.p2align 4
	.globl	emit_ival_expr
	.type	emit_ival_expr, @function
emit_ival_expr:
.LFB50:
	.cfi_startproc
	cmpl	$2, (%rsi)
	je	.L1024
	jmp	emit_expr
	.p2align 4,,10
	.p2align 3
.L1024:
	jmp	emit_ival_expr.part.0
	.cfi_endproc
.LFE50:
	.size	emit_ival_expr, .-emit_ival_expr
	.p2align 4
	.globl	init_list_length
	.type	init_list_length, @function
init_list_length:
.LFB51:
	.cfi_startproc
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L1025
	cmpl	$1, (%rdi)
	je	.L1029
.L1025:
	ret
	.p2align 4,,10
	.p2align 3
.L1029:
	movq	24(%rdi), %rax
	ret
	.cfi_endproc
.LFE51:
	.size	init_list_length, .-init_list_length
	.p2align 4
	.globl	try_eval_const_expr
	.type	try_eval_const_expr, @function
try_eval_const_expr:
.LFB52:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L1062
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
	je	.L1032
	ja	.L1033
	testl	%eax, %eax
	je	.L1034
	cmpl	$5, %eax
	jne	.L1042
	movq	56(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1030
	movl	48(%rbx), %eax
	cmpl	$31, %eax
	je	.L1038
	cmpl	$35, %eax
	je	.L1039
	.p2align 4
	.p2align 3
.L1042:
	xorl	%eax, %eax
.L1030:
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
.L1033:
	.cfi_restore_state
	cmpl	$10, %eax
	jne	.L1042
	movq	48(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1030
	movq	56(%rbx), %rdi
	movq	%rbp, %rsi
	call	try_eval_const_expr
	jmp	.L1030
	.p2align 4,,10
	.p2align 3
.L1062:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L1034:
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	movq	48(%rdi), %rax
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
.L1032:
	.cfi_restore_state
	movq	56(%rdi), %rdi
	movq	%rsp, %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1042
	movq	64(%rbx), %rdi
	leaq	8(%rsp), %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1042
	movl	48(%rbx), %eax
	subl	$22, %eax
	cmpl	$33, %eax
	ja	.L1042
	leaq	.L1045(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1045:
	.long	.L1058-.L1045
	.long	.L1057-.L1045
	.long	.L1056-.L1045
	.long	.L1055-.L1045
	.long	.L1054-.L1045
	.long	.L1053-.L1045
	.long	.L1042-.L1045
	.long	.L1042-.L1045
	.long	.L1052-.L1045
	.long	.L1051-.L1045
	.long	.L1050-.L1045
	.long	.L1049-.L1045
	.long	.L1048-.L1045
	.long	.L1042-.L1045
	.long	.L1042-.L1045
	.long	.L1042-.L1045
	.long	.L1042-.L1045
	.long	.L1042-.L1045
	.long	.L1042-.L1045
	.long	.L1042-.L1045
	.long	.L1042-.L1045
	.long	.L1042-.L1045
	.long	.L1042-.L1045
	.long	.L1042-.L1045
	.long	.L1042-.L1045
	.long	.L1042-.L1045
	.long	.L1042-.L1045
	.long	.L1042-.L1045
	.long	.L1042-.L1045
	.long	.L1042-.L1045
	.long	.L1042-.L1045
	.long	.L1047-.L1045
	.long	.L1046-.L1045
	.long	.L1044-.L1045
	.text
	.p2align 4,,10
	.p2align 3
.L1039:
	xorl	%eax, %eax
	cmpq	$0, 8(%rsp)
	sete	%al
	movq	%rax, 0(%rbp)
.L1060:
	movl	$1, %eax
	jmp	.L1030
.L1044:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1060
.L1046:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1060
.L1047:
	movq	(%rsp), %rax
	andq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1060
.L1048:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L1042
	movq	(%rsp), %rax
	cqto
	idivq	%rcx
	movq	%rdx, 0(%rbp)
	jmp	.L1060
.L1049:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L1042
	movq	(%rsp), %rax
	cqto
	idivq	%rcx
	movq	%rax, 0(%rbp)
	jmp	.L1060
.L1050:
	movq	(%rsp), %rax
	imulq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1060
.L1051:
	movq	(%rsp), %rax
	subq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1060
.L1052:
	movq	8(%rsp), %rax
	addq	(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1060
.L1053:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setge	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1060
.L1054:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setg	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1060
.L1055:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setle	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1060
.L1056:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setl	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1060
.L1057:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1060
.L1058:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	sete	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1060
	.p2align 4,,10
	.p2align 3
.L1038:
	movq	8(%rsp), %rax
	negq	%rax
	movq	%rax, 0(%rbp)
	jmp	.L1060
	.cfi_endproc
.LFE52:
	.size	try_eval_const_expr, .-try_eval_const_expr
	.p2align 4
	.globl	nested_base_len
	.type	nested_base_len, @function
nested_base_len:
.LFB53:
	.cfi_startproc
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L1084
	cmpl	$1, (%rdi)
	je	.L1088
.L1084:
	ret
	.p2align 4,,10
	.p2align 3
.L1088:
	movq	24(%rdi), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmove	%rdx, %rax
	ret
	.cfi_endproc
.LFE53:
	.size	nested_base_len, .-nested_base_len
	.p2align 4
	.globl	edge_words_total
	.type	edge_words_total, @function
edge_words_total:
.LFB54:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L1089
	cmpl	$1, (%rdi)
	je	.L1094
.L1089:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L1094:
	movq	24(%rdi), %rsi
	movq	16(%rdi), %rdi
	jmp	edge_words_total.part.0.isra.0
	.cfi_endproc
.LFE54:
	.size	edge_words_total, .-edge_words_total
	.p2align 4
	.globl	edge_tail_words_top
	.type	edge_tail_words_top, @function
edge_tail_words_top:
.LFB55:
	.cfi_startproc
	xorl	%r9d, %r9d
	testq	%rdi, %rdi
	je	.L1107
	cmpl	$1, (%rdi)
	jne	.L1107
	movq	24(%rdi), %rcx
	movq	16(%rdi), %r8
	testq	%rcx, %rcx
	je	.L1107
	xorl	%edx, %edx
	jmp	.L1108
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1110:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L1107
.L1108:
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L1110
	cmpl	$1, (%rax)
	jne	.L1110
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
.L1111:
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r9
.L1097:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L1114
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L1097
	cmpl	$1, (%rax)
	jne	.L1097
	jmp	.L1111
	.p2align 4,,10
	.p2align 3
.L1107:
	.cfi_def_cfa_offset 8
	movq	%r9, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1114:
	.cfi_def_cfa_offset 16
	movq	%r9, %rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE55:
	.size	edge_tail_words_top, .-edge_tail_words_top
	.section	.rodata.str1.1
.LC117:
	.string	"%s[%zu] = "
.LC118:
	.string	";\n"
.LC119:
	.string	"%s[%zu] = B_ADDR(%s[%zu]);\n"
	.text
	.p2align 4
	.globl	emit_edge_list_init
	.type	emit_edge_list_init, @function
emit_edge_list_init:
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
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdx, %r12
	movq	%r8, %rdx
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	testq	%rcx, %rcx
	je	.L1116
	cmpl	$1, (%rcx)
	movq	%rcx, %r15
	jne	.L1116
	cmpq	$0, 24(%rcx)
	je	.L1116
	movq	%rsi, (%rsp)
	movq	%rdi, %rbx
	movl	%r9d, %ebp
	xorl	%r13d, %r13d
	movq	%r8, 8(%rsp)
.L1129:
	movq	16(%r15), %rax
	movq	(%rax,%r13,8), %r10
	testq	%r10, %r10
	je	.L1124
	movl	(%r10), %eax
	testl	%eax, %eax
	je	.L1148
	cmpl	$1, %eax
	je	.L1149
.L1124:
	addq	$1, %r13
	addq	$1, %r12
	cmpq	24(%r15), %r13
	jb	.L1129
	movq	8(%rsp), %rdx
.L1116:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rdx, %rax
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
.L1148:
	.cfi_restore_state
	xorl	%r14d, %r14d
	testl	%ebp, %ebp
	jle	.L1122
	movq	%r12, 16(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L1119:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC40(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1119
	movq	16(%rsp), %r12
	movq	%r14, %r10
.L1122:
	movq	(%rsp), %rdx
	leaq	.LC117(%rip), %rsi
	xorl	%eax, %eax
	movq	%r12, %rcx
	movq	%rbx, %rdi
	movq	%r10, 16(%rsp)
	call	fprintf@PLT
	movq	16(%rsp), %r10
	movq	16(%r10), %rsi
	cmpl	$2, (%rsi)
	je	.L1150
	movq	96(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L1123:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1124
	.p2align 4,,10
	.p2align 3
.L1149:
	movq	24(%r10), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmovne	%rax, %rdx
	xorl	%r14d, %r14d
	movq	%rdx, 16(%rsp)
	testl	%ebp, %ebp
	jle	.L1128
	movq	%r12, 24(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L1125:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC40(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1125
	movq	24(%rsp), %r12
	movq	%r14, %r10
.L1128:
	movq	8(%rsp), %r14
	movq	(%rsp), %r8
	movq	%r12, %rcx
	movq	%rbx, %rdi
	leaq	.LC119(%rip), %rsi
	xorl	%eax, %eax
	movq	%r10, 24(%rsp)
	movq	%r8, %rdx
	movq	%r14, %r9
	call	fprintf@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 104
	movq	%r14, %rdx
	movl	%ebp, %r9d
	pushq	104(%rsp)
	.cfi_def_cfa_offset 112
	movq	32(%rsp), %rcx
	movq	%rbx, %rdi
	movq	40(%rsp), %r10
	movq	16(%rsp), %rsi
	leaq	(%r14,%rcx), %r8
	movq	%r10, %rcx
	movq	%r10, 32(%rsp)
	call	emit_edge_list_init
	movq	%rax, %rdx
	popq	%rax
	.cfi_def_cfa_offset 104
	popq	%rcx
	.cfi_def_cfa_offset 96
	movq	16(%rsp), %r10
	cmpl	$1, (%r10)
	jne	.L1126
	movq	24(%r10), %rsi
	movq	16(%r10), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, 8(%rsp)
.L1126:
	movq	8(%rsp), %rax
	cmpq	%rdx, %rax
	cmovnb	%rax, %rdx
	movq	%rdx, 8(%rsp)
	jmp	.L1124
	.p2align 4,,10
	.p2align 3
.L1150:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1123
	.cfi_endproc
.LFE56:
	.size	emit_edge_list_init, .-emit_edge_list_init
	.section	.rodata.str1.8
	.align 8
.LC120:
	.string	"static void __attribute__((constructor(101))) __b_register_globals(void) {\n"
	.align 8
.LC121:
	.string	"    (void)B_PTR_N(%s, sizeof(%s));\n"
	.align 8
.LC122:
	.string	"    (void)B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC123:
	.string	"}\n"
	.section	.rodata.str1.8
	.align 8
.LC124:
	.string	"static void __attribute__((constructor(102))) __bcc_bind_functions(void) {\n"
	.section	.rodata.str1.1
.LC125:
	.string	"    "
.LC126:
	.string	" = B_FUNCTION("
	.section	.rodata.str1.8
	.align 8
.LC127:
	.string	"static void __b_initialize_globals(void) {\n"
	.align 8
.LC128:
	.string	"    %s[0] = B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC129:
	.string	"__%s_store"
.LC130:
	.string	"    %s[0] = "
	.section	.rodata.str1.8
	.align 8
.LC131:
	.string	"}\nstatic struct __bcc_initializer __bcc_module = {__b_initialize_globals, 0, 0};\nstatic void __attribute__((constructor(102))) __bcc_register_module(void) {\n    __bcc_register_initializer(&__bcc_module);\n}\n\n"
	.text
	.p2align 4
	.type	emit_global_initializers, @function
emit_global_initializers:
.LFB65:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.LC123(%rip), %rax
	movq	%rsi, %r15
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
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	cmpl	$16, current_word_bits(%rip)
	movq	%rdx, 8(%rsp)
	movq	%rax, (%rsp)
	je	.L1196
.L1152:
	movq	%rbx, %rcx
	movl	$75, %edx
	movl	$1, %esi
	leaq	.LC124(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%r15)
	je	.L1159
	xorl	%ebp, %ebp
	leaq	.LC125(%rip), %r14
	leaq	.LC39(%rip), %r13
	jmp	.L1162
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1160:
	addq	$1, %rbp
	cmpq	8(%r15), %rbp
	jnb	.L1159
.L1162:
	movq	(%r15), %rax
	movq	(%rax,%rbp,8), %r12
	cmpl	$1, (%r12)
	jne	.L1160
	movq	%r14, %rdi
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r12), %rax
	movq	(%rax), %rdi
	testq	%rdi, %rdi
	je	.L1161
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1161:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	addq	$1, %rbp
	movl	$14, %edx
	movl	$1, %esi
	leaq	.LC126(%rip), %rdi
	call	fwrite@PLT
	movq	8(%r12), %rax
	movq	%rbx, %rdi
	movq	(%rax), %rsi
	call	emit_function_body_name
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC34(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r15), %rbp
	jb	.L1162
.L1159:
	movq	(%rsp), %rdi
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC127(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%r15)
	je	.L1163
	xorl	%ebp, %ebp
	jmp	.L1174
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1165:
	addq	$1, %rbp
	cmpq	8(%r15), %rbp
	jnb	.L1163
.L1174:
	movq	(%r15), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$2, (%rax)
	jne	.L1165
	movq	8(%rax), %r12
	movq	16(%r12), %rdi
	call	get_mangled_name
	cmpl	$2, 24(%r12)
	movq	56(%r12), %r13
	movq	%rax, %r14
	je	.L1197
	testq	%r13, %r13
	je	.L1165
	movl	0(%r13), %eax
	cmpl	$1, %eax
	je	.L1198
	testl	%eax, %eax
	jne	.L1165
	leaq	.LC130(%rip), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	fprintf@PLT
	movq	16(%r13), %rsi
	cmpl	$2, (%rsi)
	je	.L1199
	movq	8(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L1173:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addq	$1, %rbp
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r15), %rbp
	jb	.L1174
.L1163:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$207, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC131(%rip), %rdi
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
.L1197:
	.cfi_restore_state
	movq	%rax, %r8
	movq	%rax, %rcx
	movq	%rax, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC128(%rip), %rsi
	call	fprintf@PLT
	testq	%r13, %r13
	je	.L1165
	cmpl	$1, 0(%r13)
	jne	.L1165
	movq	%r14, %rsi
	leaq	.LC129(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	xorl	%r8d, %r8d
	movq	%rax, %rsi
	movq	56(%r12), %rax
	testq	%rax, %rax
	je	.L1168
	cmpl	$1, (%rax)
	je	.L1200
.L1168:
	cmpq	$0, 32(%r12)
	je	.L1169
	movq	48(%r12), %rax
	movq	%r8, %rdx
	cmpq	%rax, %r8
	cmovb	%rax, %r8
	testq	%rax, %rax
	cmovle	%rdx, %r8
.L1169:
	subq	$8, %rsp
	.cfi_def_cfa_offset 88
	movq	%r13, %rcx
	movl	$1, %r9d
	pushq	16(%rsp)
	.cfi_def_cfa_offset 96
	xorl	%edx, %edx
	movq	%rbx, %rdi
	call	emit_edge_list_init
	popq	%rcx
	.cfi_def_cfa_offset 88
	popq	%rsi
	.cfi_def_cfa_offset 80
	jmp	.L1165
	.p2align 4,,10
	.p2align 3
.L1198:
	subq	$8, %rsp
	.cfi_def_cfa_offset 88
	movq	24(%r13), %r8
	xorl	%edx, %edx
	movl	$1, %r9d
	pushq	16(%rsp)
	.cfi_def_cfa_offset 96
	movq	%r13, %rcx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_edge_list_init
	popq	%rax
	.cfi_def_cfa_offset 88
	popq	%rdx
	.cfi_def_cfa_offset 80
	jmp	.L1165
	.p2align 4,,10
	.p2align 3
.L1196:
	movq	%rdi, %rcx
	movl	$75, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%r15)
	je	.L1153
	xorl	%ebp, %ebp
	leaq	.LC121(%rip), %r12
	jmp	.L1158
	.p2align 4,,10
	.p2align 3
.L1155:
	addq	$1, %rbp
	cmpq	8(%r15), %rbp
	jnb	.L1153
.L1158:
	movq	(%r15), %rax
	movq	(%rax,%rbp,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L1201
	cmpl	$2, %eax
	jne	.L1155
	movq	8(%rdx), %r14
	movq	16(%r14), %rdi
	call	get_mangled_name
	movq	%r12, %rsi
	movq	%rbx, %rdi
	movq	%rax, %rcx
	movq	%rax, %rdx
	movq	%rax, %r13
	xorl	%eax, %eax
	call	fprintf@PLT
	cmpl	$2, 24(%r14)
	jne	.L1155
	movq	%r13, %rcx
	movq	%r13, %rdx
	leaq	.LC122(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	addq	$1, %rbp
	call	fprintf@PLT
	cmpq	8(%r15), %rbp
	jb	.L1158
	.p2align 4
	.p2align 3
.L1153:
	leaq	.LC123(%rip), %rax
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, (%rsp)
	call	fwrite@PLT
	jmp	.L1152
	.p2align 4,,10
	.p2align 3
.L1201:
	movq	8(%rdx), %rax
	movq	(%rax), %rdi
	call	get_mangled_name
	movq	%r12, %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1155
.L1199:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1173
.L1200:
	movq	24(%rax), %r8
	jmp	.L1168
	.cfi_endproc
.LFE65:
	.size	emit_global_initializers, .-emit_global_initializers
	.section	.rodata.str1.1
.LC132:
	.string	"<"
.LC133:
	.string	"<="
.LC134:
	.string	">"
.LC135:
	.string	">="
.LC136:
	.string	"??"
.LC137:
	.string	"while ("
.LC138:
	.string	")\n"
.LC139:
	.string	"if ("
.LC140:
	.string	"switch ("
.LC141:
	.string	") {\n"
.LC142:
	.string	"continue;\n"
.LC143:
	.string	"break;\n"
.LC144:
	.string	"return"
.LC145:
	.string	"{\n"
.LC146:
	.string	"return "
	.section	.rodata.str1.8
	.align 8
.LC147:
	.string	"%s = B_LOCAL_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC148:
	.string	"else\n"
.LC149:
	.string	" 0"
	.section	.rodata.str1.8
	.align 8
.LC150:
	.string	"case %zu: goto __b_label_%zu;\n"
	.align 8
.LC151:
	.string	"default: fputs(\"bcc: invalid label value\\n\", stderr); abort();\n"
	.section	.rodata.str1.1
.LC152:
	.string	"__bsw%d_case%zu"
.LC153:
	.string	"for(;;) {\n"
.LC154:
	.string	"word __sw = "
.LC155:
	.string	"__bsw%d_end"
.LC156:
	.string	"goto __bsw%d_dispatch;\n"
.LC157:
	.string	"goto __bsw%d_end;\n"
.LC158:
	.string	"__sw %s (word)%ld"
	.section	.rodata.str1.8
	.align 8
.LC159:
	.string	"(__sw >= (word)%ld && __sw <= (word)%ld)"
	.section	.rodata.str1.1
.LC160:
	.string	"__sw == (word)%ld"
.LC161:
	.string	") goto "
.LC162:
	.string	"__bsw%d_end:\n"
.LC163:
	.string	"__b_label_%d:\n"
.LC164:
	.string	"__bsw%d_dispatch:\n"
	.text
	.p2align 4
	.globl	emit_stmt
	.type	emit_stmt, @function
emit_stmt:
.LFB59:
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
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	%edx, %r12d
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
	movq	%r8, 16(%rsp)
	setne	24(%rsp)
.L1203:
	movl	g_no_line(%rip), %r10d
	testl	%r10d, %r10d
	jne	.L1204
	cmpb	$0, 24(%rsp)
	jne	.L1488
.L1204:
	cmpl	$12, (%rbx)
	ja	.L1202
	movl	(%rbx), %eax
	leaq	.L1207(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1207:
	.long	.L1218-.L1207
	.long	.L1217-.L1207
	.long	.L1216-.L1207
	.long	.L1215-.L1207
	.long	.L1214-.L1207
	.long	.L1213-.L1207
	.long	.L1212-.L1207
	.long	.L1202-.L1207
	.long	.L1211-.L1207
	.long	.L1210-.L1207
	.long	.L1209-.L1207
	.long	.L1208-.L1207
	.long	.L1206-.L1207
	.text
	.p2align 4,,10
	.p2align 3
.L1488:
	movl	4(%rbx), %edx
	movq	16(%rsp), %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC41(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1204
	.p2align 4,,10
	.p2align 3
.L1206:
	movl	g_switch_id(%rip), %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	leaq	.LC152(%rip), %r12
	addl	$1, %eax
	movl	%eax, 32(%rsp)
	movl	%eax, g_switch_id(%rip)
	xorl	%eax, %eax
	call	vec_new@PLT
	movq	%rax, %r15
	xorl	%eax, %eax
	call	vec_new@PLT
	movq	24(%rbx), %rdi
	movq	%r15, %rsi
	movq	%rax, 40(%rsp)
	call	collect_cases
	leaq	112(%rsp), %rax
	cmpq	$0, 8(%r15)
	movq	%rax, 24(%rsp)
	je	.L1288
	movq	%rbx, 56(%rsp)
	movq	24(%rsp), %r13
	movq	%r14, 48(%rsp)
	movq	%rbp, %r14
	movq	40(%rsp), %rbp
	.p2align 4
	.p2align 3
.L1285:
	movl	$16, %edi
	call	xmalloc@PLT
	movl	32(%rsp), %ecx
	movq	%r14, %r8
	movq	%r12, %rdx
	movq	%rax, %rbx
	movq	(%r15), %rax
	movl	$128, %esi
	movq	%r13, %rdi
	movq	(%rax,%r14,8), %rax
	addq	$1, %r14
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
	cmpq	8(%r15), %r14
	jb	.L1285
	movq	48(%rsp), %r14
	movq	56(%rsp), %rbx
.L1288:
	movl	8(%rsp), %edx
	movl	8(%rsp), %r12d
	xorl	%ebp, %ebp
	leaq	.LC40(%rip), %r13
	testl	%edx, %edx
	jle	.L1489
	.p2align 4
	.p2align 3
.L1286:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1286
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC153(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r12d
.L1289:
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 48(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1292:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1292
	movq	48(%rsp), %rbx
	movq	%r14, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC154(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	leaq	.LC118(%rip), %rax
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ecx
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC155(%rip), %rdx
	movl	$64, %esi
	call	snprintf@PLT
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 56(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1293:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1293
	movl	32(%rsp), %edx
	leaq	.LC156(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	movq	56(%rsp), %rbx
	call	fprintf@PLT
	movq	24(%rsp), %rax
	movl	%r12d, %edx
	movq	%r14, %rdi
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
.L1294:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1294
	leaq	.LC157(%rip), %rax
	movl	32(%rsp), %edx
	movq	%r14, %rdi
	xorl	%ebx, %ebx
	movq	%rax, 64(%rsp)
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	8(%rsp), %ebp
	.p2align 4
	.p2align 3
.L1295:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1295
	movl	32(%rsp), %edx
	xorl	%eax, %eax
	leaq	.LC164(%rip), %rsi
	movq	%r14, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r15)
	leal	2(%rax), %ebx
	je	.L1297
.L1334:
	leaq	.LC139(%rip), %rax
	movq	%r15, 16(%rsp)
	xorl	%edi, %edi
	leaq	.LC40(%rip), %rbp
	movq	%rax, 56(%rsp)
	movl	%r12d, 76(%rsp)
	movq	%rdi, %r12
	.p2align 4
	.p2align 3
.L1311:
	movq	16(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r12,8), %r13
	movq	40(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1360
	xorl	%eax, %eax
	jmp	.L1302
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1301:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1360
.L1302:
	movq	(%rsi,%rax,8), %rdx
	cmpq	(%rdx), %r13
	jne	.L1301
	movq	8(%rdx), %rax
	movq	%rax, 24(%rsp)
.L1300:
	xorl	%r15d, %r15d
	testl	%ebx, %ebx
	jle	.L1306
	.p2align 4
	.p2align 3
.L1303:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebx, %r15d
	jne	.L1303
.L1306:
	movq	56(%rsp), %rdi
	movl	$1, %esi
	movq	%r14, %rcx
	movl	$4, %edx
	call	fwrite@PLT
	movl	20(%r13), %eax
	movq	24(%r13), %rsi
	testl	%eax, %eax
	je	.L1490
	leaq	.LC134(%rip), %rdx
	cmpl	$26, %eax
	je	.L1307
	ja	.L1308
	leaq	.LC132(%rip), %rdx
	cmpl	$24, %eax
	je	.L1307
	cmpl	$25, %eax
	leaq	.LC136(%rip), %rdx
	leaq	.LC133(%rip), %rax
	cmove	%rax, %rdx
.L1307:
	movq	%rsi, %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC158(%rip), %rsi
	call	fprintf@PLT
.L1309:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC161(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rsp), %rdi
	movq	%r14, %rsi
	call	fputs@PLT
	movq	48(%rsp), %rdi
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	16(%rsp), %rax
	cmpq	8(%rax), %r12
	jb	.L1311
	movl	76(%rsp), %r12d
	leaq	.LC40(%rip), %r13
	testl	%ebx, %ebx
	jle	.L1491
.L1297:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1313:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1313
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	testl	%r12d, %r12d
	jle	.L1464
	movl	8(%rsp), %r12d
	.p2align 4
	.p2align 3
.L1314:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jg	.L1314
.L1464:
	movl	32(%rsp), %edx
	leaq	.LC162(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	.p2align 4
	.p2align 3
.L1318:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1318
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	xorl	%ebx, %ebx
	leaq	.LC143(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	jle	.L1320
	.p2align 4
	.p2align 3
.L1321:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1321
.L1320:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC123(%rip), %rdi
	call	fwrite@PLT
.L1202:
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
.L1218:
	.cfi_restore_state
	movl	%r12d, %ebp
	xorl	%ebx, %ebx
	leaq	.LC40(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1487
	.p2align 4
	.p2align 3
.L1242:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1242
.L1487:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
.L1486:
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
.L1217:
	.cfi_restore_state
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%r12d, %r12d
	movl	8(%rsp), %r15d
	leaq	.LC40(%rip), %r13
	testl	%eax, %eax
	jle	.L1492
	.p2align 4
	.p2align 3
.L1240:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1240
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L1246
.L1245:
	movl	8(%rsp), %edi
	xorl	%r13d, %r13d
	addl	$1, %edi
	movl	%edi, 40(%rsp)
.L1253:
	movq	16(%rbx), %rdx
	movq	(%rdx,%r13,8), %r12
	testl	%ebp, %ebp
	je	.L1349
	subq	$1, %rax
	xorl	%ecx, %ecx
	cmpq	%r13, %rax
	je	.L1493
.L1248:
	movq	16(%rsp), %r8
	movl	40(%rsp), %edx
	movq	%r12, %rsi
	movq	%r14, %rdi
	call	emit_stmt
.L1251:
	movq	24(%rbx), %rax
	addq	$1, %r13
	cmpq	%rax, %r13
	jb	.L1253
	movl	8(%rsp), %r9d
	leaq	.LC40(%rip), %r13
	testl	%r9d, %r9d
	jle	.L1255
.L1246:
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1256:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1256
.L1255:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC123(%rip), %rdi
	jmp	.L1486
	.p2align 4,,10
	.p2align 3
.L1216:
	xorl	%r13d, %r13d
	cmpq	$0, 24(%rbx)
	movl	%r12d, 8(%rsp)
	leaq	.LC40(%rip), %rbp
	movl	8(%rsp), %r12d
	je	.L1202
	.p2align 4
	.p2align 3
.L1239:
	movq	16(%rbx), %rax
	movq	(%rax,%r13,8), %r15
	movq	(%r15), %rdi
	call	get_mangled_name
	movl	g_strict(%rip), %esi
	movq	%rax, 8(%rsp)
	testl	%esi, %esi
	je	.L1494
	cmpq	$0, 8(%r15)
	je	.L1331
.L1330:
	xorl	%r15d, %r15d
	testl	%r12d, %r12d
	jle	.L1261
	.p2align 4
	.p2align 3
.L1259:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1259
.L1261:
	movq	8(%rsp), %rcx
	leaq	.LC147(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	movq	%rcx, %r8
	movq	%rcx, %rdx
	call	fprintf@PLT
.L1260:
	addq	$1, %r13
	cmpq	24(%rbx), %r13
	jb	.L1239
	jmp	.L1202
	.p2align 4,,10
	.p2align 3
.L1215:
	xorl	%r15d, %r15d
	leaq	.LC40(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1265
	.p2align 4
	.p2align 3
.L1225:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1225
.L1265:
	movq	%r14, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC139(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC138(%rip), %rdi
	call	fwrite@PLT
	testl	%ebp, %ebp
	jne	.L1226
.L1227:
	movq	24(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L1266
	cmpl	$1, (%rsi)
	movl	%r12d, %edx
	je	.L1267
.L1266:
	leal	1(%r12), %edx
.L1267:
	movq	16(%rsp), %r8
	movl	%ebp, %ecx
	movq	%r14, %rdi
	call	emit_stmt
	cmpq	$0, 32(%rbx)
	je	.L1202
	xorl	%ebp, %ebp
	leaq	.LC40(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1271
	.p2align 4
	.p2align 3
.L1268:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1268
.L1271:
	movq	%r14, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L1223
	jmp	.L1224
	.p2align 4,,10
	.p2align 3
.L1214:
	xorl	%ebp, %ebp
	leaq	.LC40(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1273
	.p2align 4
	.p2align 3
.L1222:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1222
.L1273:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC137(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC138(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L1224
.L1223:
	cmpl	$1, (%rbx)
	je	.L1272
.L1224:
	addl	$1, %r12d
.L1272:
	xorl	%ebp, %ebp
	jmp	.L1203
	.p2align 4,,10
	.p2align 3
.L1213:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	movl	8(%rsp), %r12d
	leaq	.LC40(%rip), %r13
	testl	%eax, %eax
	jle	.L1274
	.p2align 4
	.p2align 3
.L1236:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1236
.L1274:
	movq	%r14, %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC144(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%rbx)
	je	.L1495
	movq	%r14, %rsi
	movl	$32, %edi
	call	fputc@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	jmp	.L1487
	.p2align 4,,10
	.p2align 3
.L1211:
	movl	%r12d, 8(%rsp)
	xorl	%ebx, %ebx
	movl	8(%rsp), %ebp
	leaq	.LC40(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1276
	.p2align 4
	.p2align 3
.L1232:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1232
.L1276:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC143(%rip), %rdi
	jmp	.L1486
	.p2align 4,,10
	.p2align 3
.L1212:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%r12d, %r12d
	movl	8(%rsp), %r15d
	leaq	.LC40(%rip), %r13
	testl	%eax, %eax
	jle	.L1275
	.p2align 4
	.p2align 3
.L1233:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1233
.L1275:
	testl	%ebp, %ebp
	jne	.L1496
.L1235:
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	jmp	.L1487
	.p2align 4,,10
	.p2align 3
.L1209:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	movl	8(%rsp), %r12d
	leaq	.LC40(%rip), %r13
	testl	%eax, %eax
	jle	.L1278
	.p2align 4
	.p2align 3
.L1228:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1228
.L1278:
	movq	%r14, %rcx
	movl	$8, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC140(%rip), %rdi
	leaq	.LC150(%rip), %r13
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	%r14, %rdi
	movq	16(%rsp), %rdx
	leaq	.LC40(%rip), %rbp
	call	emit_expr
	movq	%r14, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC141(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	movl	8(%rsp), %r15d
	je	.L1230
	.p2align 4
	.p2align 3
.L1229:
	xorl	%ebx, %ebx
	testl	%r15d, %r15d
	js	.L1280
	.p2align 4
	.p2align 3
.L1279:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r15d
	jge	.L1279
.L1280:
	addq	$1, %r12
	xorl	%eax, %eax
	movq	%r13, %rsi
	movq	%r14, %rdi
	movq	%r12, %rcx
	movq	%r12, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %r12
	jb	.L1229
.L1230:
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	js	.L1281
	xorl	%ebx, %ebx
	leaq	.LC40(%rip), %r13
	.p2align 4
	.p2align 3
.L1282:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jge	.L1282
	movq	%r14, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC151(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	je	.L1255
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1284:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1284
	jmp	.L1255
	.p2align 4,,10
	.p2align 3
.L1210:
	movl	%r12d, 8(%rsp)
	xorl	%ebx, %ebx
	movl	8(%rsp), %ebp
	leaq	.LC40(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1277
	.p2align 4
	.p2align 3
.L1231:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1231
.L1277:
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC142(%rip), %rdi
	jmp	.L1486
	.p2align 4,,10
	.p2align 3
.L1208:
	xorl	%ebp, %ebp
	leaq	.LC40(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1497
	.p2align 4
	.p2align 3
.L1219:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1219
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 8(%rsp)
	testq	%rbp, %rbp
	je	.L1498
.L1220:
	movq	function_labels(%rip), %r15
	xorl	%r13d, %r13d
	jmp	.L1326
	.p2align 4,,10
	.p2align 3
.L1324:
	addq	$1, %r13
	cmpq	%rbp, %r13
	je	.L1221
.L1326:
	movq	(%r15,%r13,8), %rsi
	movq	8(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1324
	leal	1(%r13), %edx
.L1325:
	leaq	.LC163(%rip), %rsi
	movq	%r14, %rdi
	leal	1(%r12), %r15d
	xorl	%eax, %eax
	call	fprintf@PLT
	leaq	.LC40(%rip), %r13
	testl	%r15d, %r15d
	jle	.L1329
.L1327:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1328:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jne	.L1328
.L1329:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movl	%r15d, %r12d
	leaq	.LC118(%rip), %rdi
	xorl	%ebp, %ebp
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	jmp	.L1203
	.p2align 4,,10
	.p2align 3
.L1360:
	movq	$0, 24(%rsp)
	jmp	.L1300
	.p2align 4,,10
	.p2align 3
.L1490:
	movl	16(%r13), %eax
	testl	%eax, %eax
	je	.L1310
	movq	32(%r13), %rcx
	movq	%rsi, %rdx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC159(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1309
	.p2align 4,,10
	.p2align 3
.L1494:
	movq	16(%rsp), %rcx
	movl	%r12d, %edx
	movq	%r15, %rsi
	movq	%r14, %rdi
	call	emit_auto_storage
	cmpq	$0, 8(%r15)
	jne	.L1330
	movl	g_strict(%rip), %ecx
	testl	%ecx, %ecx
	je	.L1260
	.p2align 4
	.p2align 3
.L1331:
	xorl	%r15d, %r15d
	testl	%r12d, %r12d
	jle	.L1263
	.p2align 4
	.p2align 3
.L1262:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1262
.L1263:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1260
.L1493:
	cmpl	$6, (%r12)
	movl	%ebp, %ecx
	jne	.L1248
	movl	g_no_line(%rip), %r8d
	testl	%r8d, %r8d
	jne	.L1249
	cmpb	$0, 24(%rsp)
	je	.L1249
	movl	4(%r12), %edx
	movq	16(%rsp), %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC41(%rip), %rsi
	call	fprintf@PLT
.L1249:
	movl	8(%rsp), %edi
	leaq	.LC40(%rip), %rax
	xorl	%r15d, %r15d
	movq	%rax, 32(%rsp)
	testl	%edi, %edi
	js	.L1252
	.p2align 4
	.p2align 3
.L1250:
	movq	32(%rsp), %rdi
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r15d
	call	fwrite@PLT
	cmpl	%r15d, 8(%rsp)
	jge	.L1250
.L1252:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC146(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r12), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1251
	.p2align 4,,10
	.p2align 3
.L1310:
	movq	%rsi, %rdx
	movq	%r14, %rdi
	leaq	.LC160(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1309
	.p2align 4,,10
	.p2align 3
.L1349:
	xorl	%ecx, %ecx
	jmp	.L1248
	.p2align 4,,10
	.p2align 3
.L1308:
	cmpl	$27, %eax
	leaq	.LC136(%rip), %rdx
	leaq	.LC135(%rip), %rax
	cmove	%rax, %rdx
	jmp	.L1307
.L1226:
	xorl	%ebp, %ebp
	cmpq	$0, 32(%rbx)
	sete	%bpl
	jmp	.L1227
.L1491:
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	xorl	%eax, %eax
	movq	%r14, %rdi
	call	fprintf@PLT
	testl	%r12d, %r12d
	jle	.L1485
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
.L1485:
	movl	32(%rsp), %edx
	movq	%r14, %rdi
	leaq	.LC162(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC143(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1320
.L1497:
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 8(%rsp)
	testq	%rbp, %rbp
	jne	.L1220
.L1221:
	xorl	%edx, %edx
	jmp	.L1325
.L1496:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC146(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1235
.L1495:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC149(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1487
.L1281:
	movq	%r14, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC151(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1255
.L1492:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	jne	.L1245
	jmp	.L1255
.L1489:
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC153(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r12d
	testl	%eax, %eax
	je	.L1289
	movq	%r14, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC154(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	leaq	.LC118(%rip), %rax
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ebp
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC155(%rip), %rdx
	movl	$64, %esi
	movl	%ebp, %ecx
	call	snprintf@PLT
	movl	%ebp, %edx
	leaq	.LC156(%rip), %rsi
	xorl	%eax, %eax
	movq	%r14, %rdi
	call	fprintf@PLT
	movq	24(%rsp), %rax
	movl	%r12d, %edx
	movq	%r14, %rdi
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
	movq	%r14, %rdi
	movq	%rax, g_ctrl(%rip)
	leaq	.LC157(%rip), %rax
	movq	%rax, %rsi
	movq	%rax, 64(%rsp)
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%eax, %eax
	movl	%ebp, %edx
	leaq	.LC164(%rip), %rsi
	movq	%r14, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r15)
	leal	2(%rax), %ebx
	jne	.L1334
	cmpl	$1, %ebx
	je	.L1297
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1485
	.p2align 4,,10
	.p2align 3
.L1498:
	xorl	%edx, %edx
	leaq	.LC163(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%r12), %r15d
	jmp	.L1327
	.cfi_endproc
.LFE59:
	.size	emit_stmt, .-emit_stmt
	.section	.rodata.str1.1
.LC165:
	.string	"%s:\n"
	.text
	.p2align 4
	.type	emit_stmt_switchctx, @function
emit_stmt_switchctx:
.LFB47:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.L1504(%rip), %r15
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
	je	.L1499
.L1500:
	cmpl	$13, 0(%r13)
	ja	.L1502
	movl	0(%r13), %eax
	movslq	(%r15,%rax,4), %rax
	addq	%r15, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1504:
	.long	.L1502-.L1504
	.long	.L1508-.L1504
	.long	.L1502-.L1504
	.long	.L1507-.L1504
	.long	.L1506-.L1504
	.long	.L1502-.L1504
	.long	.L1502-.L1504
	.long	.L1502-.L1504
	.long	.L1502-.L1504
	.long	.L1502-.L1504
	.long	.L1502-.L1504
	.long	.L1505-.L1504
	.long	.L1502-.L1504
	.long	.L1503-.L1504
	.text
	.p2align 4,,10
	.p2align 3
.L1502:
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
.L1503:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1552
	xorl	%eax, %eax
	jmp	.L1522
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1521:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1552
.L1522:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%r13, (%rdx)
	jne	.L1521
	movq	8(%rdx), %r14
.L1520:
	xorl	%r13d, %r13d
	leaq	.LC40(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1586
	.p2align 4
	.p2align 3
.L1523:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1523
	movq	%r14, %rdx
	leaq	.LC165(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1526:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jle	.L1526
.L1525:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	jmp	.L1585
	.p2align 4,,10
	.p2align 3
.L1505:
	xorl	%r14d, %r14d
	leaq	.LC40(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1587
	.p2align 4
	.p2align 3
.L1509:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1509
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L1588
.L1510:
	movq	function_labels(%rip), %r14
	xorl	%r12d, %r12d
	jmp	.L1530
	.p2align 4,,10
	.p2align 3
.L1528:
	addq	$1, %r12
	cmpq	%r12, 24(%rsp)
	je	.L1511
.L1530:
	movq	(%r14,%r12,8), %rsi
	movq	16(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1528
	leal	1(%r12), %edx
.L1529:
	leaq	.LC163(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	leaq	.LC40(%rip), %r12
	movl	%eax, 16(%rsp)
	testl	%eax, %eax
	jle	.L1589
.L1531:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1533:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, %ebp
	jne	.L1533
	movl	16(%rsp), %ebp
.L1534:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	jne	.L1500
	jmp	.L1499
	.p2align 4,,10
	.p2align 3
.L1506:
	xorl	%r14d, %r14d
	leaq	.LC40(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1546
	.p2align 4
	.p2align 3
.L1512:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1512
.L1546:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC137(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC138(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	je	.L1499
.L1513:
	xorl	%eax, %eax
	cmpl	$1, 0(%r13)
	setne	%al
	addl	%eax, %ebp
	jmp	.L1500
	.p2align 4,,10
	.p2align 3
.L1507:
	xorl	%r14d, %r14d
	leaq	.LC40(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1541
	.p2align 4
	.p2align 3
.L1515:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1515
.L1541:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC139(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC138(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %rsi
	testq	%rsi, %rsi
	je	.L1517
	cmpl	$1, (%rsi)
	movl	%ebp, %edx
	je	.L1542
.L1517:
	leal	1(%rbp), %edx
.L1542:
	movq	(%rsp), %r8
	movq	8(%rsp), %rcx
	movq	%rbx, %rdi
	call	emit_stmt_switchctx
	cmpq	$0, 32(%r13)
	je	.L1499
	xorl	%r14d, %r14d
	leaq	.LC40(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1545
	.p2align 4
	.p2align 3
.L1543:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1543
.L1545:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r13), %r13
	testq	%r13, %r13
	jne	.L1513
.L1499:
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
.L1508:
	.cfi_restore_state
	xorl	%r15d, %r15d
	leaq	.LC40(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1590
	.p2align 4
	.p2align 3
.L1518:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebp, %r15d
	jne	.L1518
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	je	.L1536
.L1535:
	leal	1(%rbp), %r12d
	xorl	%r15d, %r15d
.L1538:
	movq	16(%r13), %rax
	movq	(%rsp), %r8
	movl	%r12d, %edx
	movq	%rbx, %rdi
	movq	8(%rsp), %rcx
	movq	(%rax,%r15,8), %rsi
	addq	$1, %r15
	call	emit_stmt_switchctx
	cmpq	24(%r13), %r15
	jb	.L1538
	leaq	.LC40(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1537
.L1536:
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1540:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1540
.L1537:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC123(%rip), %rdi
.L1585:
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
.L1552:
	.cfi_restore_state
	xorl	%r14d, %r14d
	jmp	.L1520
	.p2align 4,,10
	.p2align 3
.L1587:
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	jne	.L1510
	.p2align 4
	.p2align 3
.L1511:
	xorl	%edx, %edx
	jmp	.L1529
.L1588:
	xorl	%edx, %edx
	leaq	.LC163(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	movl	%eax, 16(%rsp)
	jmp	.L1531
	.p2align 4,,10
	.p2align 3
.L1586:
	xorl	%eax, %eax
	movq	%r14, %rdx
	leaq	.LC165(%rip), %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	testl	%ebp, %ebp
	jne	.L1525
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	jmp	.L1525
	.p2align 4,,10
	.p2align 3
.L1589:
	movl	%eax, %ebp
	jmp	.L1534
	.p2align 4,,10
	.p2align 3
.L1590:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	jne	.L1535
	jmp	.L1537
	.cfi_endproc
.LFE47:
	.size	emit_stmt_switchctx, .-emit_stmt_switchctx
	.section	.rodata.str1.1
.LC166:
	.string	"static "
.LC167:
	.string	""
	.section	.rodata.str1.8
	.align 8
.LC168:
	.string	"#ifndef %s\nextern word %s[];\n#define __b_external_%s (%s[0])\n#else\n#define __b_external_%s (%s)\n#endif\n"
	.section	.rodata.str1.1
.LC169:
	.string	"extern word %s[];\n"
.LC170:
	.string	"%sword %s[%zu];\n"
.LC171:
	.string	"static word __%s_store[%zu];\n"
	.text
	.p2align 4
	.type	emit_global_declarations, @function
emit_global_declarations:
.LFB64:
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
	cmpq	$0, 8(%rsi)
	movq	%rdx, (%rsp)
	je	.L1591
	movq	%rdi, %rbp
	movq	%rsi, %r12
	xorl	%ebx, %ebx
	jmp	.L1605
	.p2align 4,,10
	.p2align 3
.L1594:
	addq	$1, %rbx
	cmpq	8(%r12), %rbx
	jnb	.L1591
.L1605:
	movq	(%r12), %rax
	movq	(%rax,%rbx,8), %r14
	movl	(%r14), %eax
	testl	%eax, %eax
	je	.L1623
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L1594
	movq	8(%r14), %r13
	movq	16(%r13), %rdi
	call	get_mangled_name
	cmpl	$3, (%r14)
	movq	%rax, %r15
	je	.L1624
	cmpl	$1, 24(%r13)
	movl	$1, %r8d
	jne	.L1599
	movq	56(%r13), %rdi
	movl	$1, %r11d
	testq	%rdi, %rdi
	je	.L1600
	cmpl	$1, (%rdi)
	je	.L1625
.L1600:
	call	edge_tail_words_top
	leaq	(%rax,%r11), %r8
	movl	$1, %eax
	testq	%r8, %r8
	cmove	%rax, %r8
.L1599:
	movl	4(%r13), %eax
	leaq	.LC167(%rip), %rdx
	testl	%eax, %eax
	je	.L1601
	leaq	.LC166(%rip), %rdx
.L1601:
	xorl	%eax, %eax
	movq	%r15, %rcx
	leaq	.LC170(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$2, 24(%r13)
	jne	.L1594
	movq	56(%r13), %rdi
	xorl	%r11d, %r11d
	testq	%rdi, %rdi
	je	.L1602
	cmpl	$1, (%rdi)
	je	.L1626
.L1602:
	cmpq	$0, 32(%r13)
	je	.L1603
	movq	48(%r13), %rax
	movq	%r11, %rdx
	cmpq	%rax, %r11
	cmovb	%rax, %r11
	testq	%rax, %rax
	cmovle	%rdx, %r11
.L1603:
	call	edge_tail_words_top
	movq	%r15, %rdx
	leaq	.LC171(%rip), %rsi
	movq	%rbp, %rdi
	leaq	(%rax,%r11), %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	xorl	%eax, %eax
	addq	$1, %rbx
	call	fprintf@PLT
	cmpq	8(%r12), %rbx
	jb	.L1605
.L1591:
	addq	$24, %rsp
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
.L1623:
	.cfi_restore_state
	movq	8(%r14), %rsi
	movq	(%rsp), %r8
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbp, %rdi
	call	emit_stmt
	jmp	.L1594
	.p2align 4,,10
	.p2align 3
.L1624:
	movq	16(%r13), %rdx
	movq	%rdx, %rdi
	movq	%rdx, 8(%rsp)
	call	global_data_kind
	testl	%eax, %eax
	je	.L1594
	movl	8(%r13), %esi
	testl	%esi, %esi
	je	.L1598
	movq	8(%rsp), %rdx
	movq	%r15, %rcx
	movq	%r15, %r9
	movq	%r15, %r8
	leaq	.LC168(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	pushq	%rdx
	.cfi_def_cfa_offset 88
	pushq	%r15
	.cfi_def_cfa_offset 96
	call	fprintf@PLT
	popq	%rdx
	.cfi_def_cfa_offset 88
	popq	%rcx
	.cfi_def_cfa_offset 80
	jmp	.L1594
	.p2align 4,,10
	.p2align 3
.L1625:
	movq	24(%rdi), %r11
	jmp	.L1600
	.p2align 4,,10
	.p2align 3
.L1598:
	movq	%r15, %rdx
	leaq	.LC169(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1594
.L1626:
	movq	24(%rdi), %r11
	jmp	.L1602
	.cfi_endproc
.LFE64:
	.size	emit_global_declarations, .-emit_global_declarations
	.section	.rodata.str1.1
.LC172:
	.string	"{\n    B_FRAME;\n"
	.section	.rodata.str1.8
	.align 8
.LC173:
	.string	"    word __bcc_parameters[%zu] = {"
	.align 8
.LC174:
	.string	"    (void)B_LOCAL_PTR_N(__bcc_parameters, sizeof(__bcc_parameters));\n"
	.align 8
.LC175:
	.string	"    static word __b_label_value_%zu = %zu;\n"
	.section	.rodata.str1.1
.LC176:
	.string	"    return 0;\n}\n"
	.text
	.p2align 4
	.type	emit_function_body, @function
emit_function_body:
.LFB60:
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
	subq	$32, %rsp
	.cfi_def_cfa_offset 80
	movq	32(%rsi), %rdi
	movq	$0, 8+function_labels(%rip)
	call	collect_function_labels
	movl	$15, %edx
	movq	%rbp, %rcx
	movl	$1, %esi
	leaq	.LC172(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r12), %rdx
	testq	%rdx, %rdx
	jne	.L1646
.L1629:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L1647
.L1634:
	cmpq	$0, 8+function_labels(%rip)
	je	.L1638
	xorl	%ebx, %ebx
	leaq	.LC175(%rip), %r14
	.p2align 4
	.p2align 3
.L1639:
	addq	$1, %rbx
	xorl	%eax, %eax
	movq	%r14, %rsi
	movq	%rbp, %rdi
	movq	%rbx, %rcx
	movq	%rbx, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %rbx
	jb	.L1639
.L1638:
	movq	32(%r12), %rsi
	movq	%r13, %r8
	movq	%rbp, %rdi
	movl	$1, %ecx
	movl	$1, %edx
	call	emit_stmt
	movq	%rbp, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC176(%rip), %rdi
	call	fwrite@PLT
	movq	$0, 8+function_labels(%rip)
	addq	$32, %rsp
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
.L1646:
	.cfi_restore_state
	xorl	%eax, %eax
	leaq	.LC173(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpq	$0, 16(%r12)
	je	.L1630
	xorl	%ebx, %ebx
	leaq	.LC33(%rip), %r14
	jmp	.L1632
	.p2align 4,,10
	.p2align 3
.L1648:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
.L1632:
	movq	8(%r12), %rax
	movq	(%rax,%rbx,8), %rdi
	testq	%rdi, %rdi
	je	.L1631
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1631:
	addq	$1, %rbx
	cmpq	16(%r12), %rbx
	jb	.L1648
.L1630:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC2(%rip), %rdi
	call	fwrite@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L1629
	movq	%rbp, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC174(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1629
	.p2align 4,,10
	.p2align 3
.L1647:
	movq	32(%r12), %rdi
	pxor	%xmm0, %xmm0
	movq	%rsp, %rsi
	movq	$0, 16(%rsp)
	movaps	%xmm0, (%rsp)
	call	collect_function_autos
	cmpq	$0, 8(%rsp)
	je	.L1635
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1636:
	movq	(%rsp), %rax
	movq	%r13, %rcx
	movl	$1, %edx
	movq	%rbp, %rdi
	movq	(%rax,%rbx,8), %rsi
	addq	$1, %rbx
	call	emit_auto_storage
	cmpq	8(%rsp), %rbx
	jb	.L1636
.L1635:
	cmpq	$0, g_compilation_arena(%rip)
	jne	.L1634
	movq	(%rsp), %rdi
	call	free@PLT
	jmp	.L1634
	.cfi_endproc
.LFE60:
	.size	emit_function_body, .-emit_function_body
	.section	.rodata.str1.1
.LC177:
	.string	"#define BCC_USE_CURSES 1\n"
	.section	.rodata.str1.8
	.align 8
.LC178:
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
	.string	"ses little-endian byte packing; results may differ on big-endian hosts\"\n  #endif\n#endif\n\n/*\n  Pointer model:\n    B_BYTEPTR=1  -> pointers are byte addresses; subscripts still index words\n    B_BYTEPTR=0  -> pointers are word addresses: E1[E2]==*(E1+E2)\n*/\n"
	.align 8
.LC179:
	.string	"#define __bcc_strict_runtime %d\n"
	.section	.rodata.str1.1
.LC180:
	.string	"#define B_BYTEPTR %d\n"
.LC181:
	.string	"#define WORD_BITS %d\n"
	.section	.rodata.str1.8
	.align 8
.LC182:
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
.LC183:
	.string	"%s/btarget.h"
	.section	.rodata.str1.8
	.align 8
.LC184:
	.string	"#define B_TARGET_DEFINE\n#define B_TARGET_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC185:
	.string	"%s/binit.h"
	.section	.rodata.str1.8
	.align 8
.LC186:
	.string	"#define B_INIT_DEFINE\n#define B_INIT_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC187:
	.string	"%s/bunix.h"
	.section	.rodata.str1.8
	.align 8
.LC188:
	.ascii	"static void __b_init(void) {\n    if (!__bcc_runtime_initial"
	.ascii	"ized) {\n        setvbuf(stdout, NULL, _IONBF, 0);\n        "
	.ascii	"__bcc_runtime_initialized = 1;\n    }\n    __bcc_run_initial"
	.ascii	"izers();\n}\nstatic int rd_fd = 0;  /* current input fd */\n"
	.ascii	"static int wr_fd = 1;  /* current output fd */\nstatic word "
	.ascii	"rd_unit = 0; /* exposed to B if needed */\nstatic word wr_un"
	.ascii	"it = (word)-1;\nstatic void __b_sync_rd(void){\n    if (rd_u"
	.ascii	"nit < 0) {\n        if (rd_fd != 0 && rd_fd > 2) close(rd_fd"
	.ascii	");\n        rd_fd = 0;\n    } else if (rd_fd != (int)rd_unit"
	.ascii	") {\n        rd_fd = (int)rd_unit;\n    }\n}\nstatic void __"
	.ascii	"b_sync_wr(void){\n    if (wr_unit < 0) {\n        if (wr_fd "
	.ascii	"!= 1 && wr_fd > 2) close(wr_fd);\n        wr_fd = 1;\n    } "
	.ascii	"else if (wr_fd != (int)wr_unit) {\n        wr_fd = (int)wr_u"
	.ascii	"nit;\n    }\n}\nstatic word b_print(word x){\n    __b_sync_w"
	.ascii	"r();\n    char buf[64];\n    int n = snprintf(buf, sizeof(bu"
	.ascii	"f), \"%\" PRIdPTR \"\\n\", (intptr_t)x);\n    if (n > 0) (vo"
	.ascii	"id)write(wr_fd, buf, (size_t)n);\n    return x;\n}\n\nstatic"
	.ascii	" word b_putchar(word x){\n    __b_sync_wr();\n    unsigned c"
	.ascii	"har bytes[2] = {(unsigned char)((uword)x >> 8), (unsigned ch"
	.ascii	"ar)x};\n    size_t start = bytes[0] ? 0 : 1;\n    (void)writ"
	.ascii	"e(wr_fd, bytes + start, 2 - start);\n    return x;\n}\nstati"
	.ascii	"c word b_getchar(void){ __b_sync_rd(); unsigned char c; ssiz"
	.ascii	"e_t n = read(rd_fd, &c, 1); if (n == 1) return (word)c; if ("
	.ascii	"rd_fd != 0) { close(rd_fd); rd_fd = 0; rd_unit = -1; return "
	.ascii	"b_getchar(); } return (word)004; }\nstatic word b_exit(word "
	.ascii	"code){ exit((int)code); return 0; }\nstatic word b_abort(voi"
	.ascii	"d){ abort(); return 0; }\nstatic word b_free(word p){ void *"
	.ascii	"host = B_CPTR(p); B_FORGET(host); free(host); return 0; }\n\n"
	.ascii	"/* Sign-extend 16-bit value to full word size. Used by 16-bi"
	.ascii	"t B programs on 64-bit hosts. */\nstatic word sx64(word x){\n"
	.ascii	"    return (word)(int16_t)(x & 0xFFFF);\n}\n\n/* Command lin"
	.ascii	"e argument support */\nint __b_argc __attribute__((common));"
	.ascii	"\nchar **__b_argv __attribute__((common));\n\n/* argv string"
	.ascii	"s converted to B strings (packed words, 004 terminator) */\n"
	.ascii	"word *__b_argvb __at"
	.ascii	"tribute__((common));\nword b_argv_vector __attribute__((comm"
	.ascii	"on));\n\nstatic void __b_setargs(int argc, char **argv);\nst"
	.ascii	"atic word b_argc(void);\nstatic word b_argv(word i);\n\n/* C"
	.ascii	"ommand line reread buffer */\nstatic word b_reread(void);\n\n"
	.ascii	"/* Helper functions for complex lvalue operations (avoid GNU"
	.ascii	" C extensions) */\n/* All use safe W* macros to avoid host-C"
	.ascii	" undefined behavior */\nstatic word b_preinc(word *p) { retu"
	.ascii	"rn (*p = WADD(*p, 1)); }\nstatic word b_predec(word *p) { re"
	.ascii	"turn (*p = WSUB(*p, 1)); }\nstatic word b_postinc(word *p) {"
	.ascii	" word old = WVAL(*p); *p = WADD(*p, 1); return old; }\nstati"
	.ascii	"c word b_postdec(word *p) { word old = WVAL(*p); *p = WSUB(*"
	.ascii	"p, 1); return old; }\nstatic word b_add_assign(word *p, word"
	.ascii	" v) { return (*p = WADD(*p, v)); }\nstatic word b_sub_assign"
	.ascii	"(word *p, word v) { return (*p = WSUB(*p, v)); }\nstatic wor"
	.ascii	"d b_mul_assign(word *p, word v) { return (*p = WMUL(*p, v));"
	.ascii	" }\nstatic word b_div_assign(word *p, word v) { return (*p ="
	.ascii	" WDIV(*p, v)); }\nstatic word b_mod_assign(word *p, word v) "
	.ascii	"{ return (*p = WMOD(*p, v)); }\nstatic word b_lsh_assign(wor"
	.ascii	"d *p, word v) { return (*p = WSHL(*p, v)); }\nstatic word b_"
	.ascii	"rsh_assign(word *p, word v) { return (*p = WSHR(*p, v)); }\n"
	.ascii	"static word b_and_assign(word *p, word v) { return (*p = WAN"
	.ascii	"D(*p, v)); }\nstatic word b_or_assign(word *p, word v) { ret"
	.ascii	"urn (*p = WOR(*p, v)); }\nstatic word b_xor_assign(word *p, "
	.ascii	"word v) { return (*p = WXOR(*p, v)); }\n\nstatic word b_allo"
	.ascii	"c(word nwords){\n    nwords = WVAL(nwords);\n    if (nwords "
	.ascii	"< 0 || (uword)nwords > SIZE_MAX / sizeof(word)) {\n        f"
	.ascii	"printf(stderr, \"alloc: invalid size\\n\"); exit(1);\n    }\n"
	.ascii	"    size_t bytes = nwords ? (size_t)nwords * sizeof(word) : "
	.ascii	"sizeof(word);\n    void *p = malloc(bytes);\n    if (!p) { f"
	.ascii	"printf(stderr, \"alloc: out of memory\\n\"); exit(1); }\n   "
	.ascii	" return B_PTR_N(p, bytes);\n}\n\n/* Host B runtime functions"
	.ascii	" and compatibility helpers */\n/* String manipulation functi"
	.ascii	"ons */\nstatic inline word b_load(word addr){ return B_DEREF"
	.ascii	"(addr); }\nstatic inline void b_store(word addr, word v){ B_"
	.ascii	"DEREF"
	.ascii	"(addr) = WVAL(v);\n}\n\n/* B string access - byte packing wi"
	.ascii	"thin words.\n *\n * In B_BYTEPTR=0 mode, bytes are packed in"
	.ascii	"to words with byte 0 at the LSB.\n * This matches PDP-11 (li"
	.ascii	"ttle-endian) conventions. The shift-based approach\n * opera"
	.ascii	"tes on word VALUES (not memory layout), making it consistent"
	.ascii	" across\n * architectures: char(s,0) always returns the leas"
	.ascii	"t-significant byte of the\n * word at address s, regardless "
	.ascii	"of host endianness.\n *\n * Note: This only works correctly "
	.ascii	"when ALL byte access goes through char()/lchar().\n * Mixing"
	.ascii	" direct memory access (like C's *(char*)ptr) with B word ope"
	.ascii	"rations will\n * give different results on big-endian hosts."
	.ascii	"\n */\nstatic word b_char(word s, word i){\n#if B_BYTEPTR &&"
	.ascii	" WORD_BITS != 16\n    const unsigned char *p = (const unsign"
	.ascii	"ed char*)B_CPTR(s);\n    return (word)p[(size_t)i];\n#else\n"
	.ascii	"    const uword W = (uword)B_WORD_BYTES;\n    uword wi = (uw"
	.ascii	"ord)i / W;\n    uword bi = (uword)i % W;\n    uword w  = (uw"
	.ascii	"ord)B_INDEX(s, wi);\n    return (word)((w >> (bi * 8)) & 0xF"
	.ascii	"F);\n#endif\n}\n\nstatic word b_lchar(word s, word i, word c"
	.ascii	"){\n#if B_BYTEPTR && WORD_BITS != 16\n    unsigned char *p ="
	.ascii	" (unsigned char*)B_CPTR(s);\n    p[(size_t)i] = (unsigned ch"
	.ascii	"ar)(c & 0xFF);\n    return c;\n#else\n    const uword W = (u"
	.ascii	"word)B_WORD_BYTES;\n    uword wi = (uword)i / W;\n    uword "
	.ascii	"bi = (uword)i % W;\n\n    word addr = B_ADDR(B_INDEX(s, wi))"
	.ascii	";\n    uword w   = (uword)b_load(addr);\n\n    uword mask = "
	.ascii	"(uword)0xFF << (bi * 8);\n    w = (w & ~mask) | (((uword)c &"
	.ascii	" 0xFF) << (bi * 8));\n\n    b_store(addr, (word)w);\n    ret"
	.ascii	"urn c;\n#endif\n}\n\n/* Command line argument support implem"
	.ascii	"entation */\nstatic word __b_pack_cstr(const char *s){\n    "
	.ascii	"size_t n = strlen(s);                 /* bytes, excluding NU"
	.ascii	"L */\n    size_t W = B_WORD_BYTES;              /* bytes per"
	.ascii	" word */\n    size_t total = n + 1;                 /* +1 fo"
	.ascii	"r 004 terminator */\n    size_t words = (total + W - 1) / W;"
	.ascii	"\n\n    word bp = b_alloc((word)words);       /* B pointer t"
	.ascii	"o word storage */\n\n    /* write bytes into the B string us"
	.ascii	"ing lchar (handles"
	.ascii	" packing for B_BYTEPTR=0) */\n    for (size_t i = 0; i < n; "
	.ascii	"i++){\n        b_lchar(bp, (word)i, (word)(unsigned char)s[i"
	.ascii	"]);\n    }\n    b_lchar(bp, (word)n, (word)004);\n    return"
	.ascii	" bp;\n}\n\nstatic void __b_bstr_to_cstr(word s, char *buf, s"
	.ascii	"ize_t max){\n    size_t i = 0;\n    while (i + 1 < max) {\n "
	.ascii	"       word ch = b_char(s, (word)i);\n        if (ch == 004 "
	.ascii	"|| ch == 0) break;\n        buf[i++] = (char)(ch & 0xFF);\n "
	.ascii	"   }\n    buf[i] = 0;\n}\n\n/* Convert a B string (004-termi"
	.ascii	"nated) into a temporary NUL-terminated C string */\nstatic c"
	.ascii	"onst char *__b_cstr(word s){\n    static char *slots[4];\n  "
	.ascii	"  static size_t caps[4];\n    static int next = 0;\n\n    if"
	.ascii	" (s == 0) return \"\";\n\n    size_t len = 0;\n    for (;; l"
	.ascii	"en++) {\n        word ch = b_char(s, (word)len);\n        if"
	.ascii	" (ch == 004 || ch == 0) break;\n    }\n\n    int idx = next;"
	.ascii	"\n    next = (next + 1) & 3; /* simple ring buffer to surviv"
	.ascii	"e multiple args */\n\n    size_t need = len + 1;\n    if (ne"
	.ascii	"ed > caps[idx]) {\n        size_t ncap = need < 64 ? 64 : ne"
	.ascii	"ed;\n        char *nb = (char*)realloc(slots[idx], ncap);\n "
	.ascii	"       if (!nb) { fprintf(stderr, \"cstr: out of memory\\n\""
	.ascii	"); exit(1); }\n        slots[idx] = nb;\n        caps[idx] ="
	.ascii	" ncap;\n    }\n\n    for (size_t i = 0; i < len; i++) slots["
	.ascii	"idx][i] = (char)(b_char(s, (word)i) & 0xFF);\n    slots[idx]"
	.ascii	"[len] = 0;\n    return slots[idx];\n}\n\n/* Duplicate a B st"
	.ascii	"ring into a freshly allocated C string */\nstatic char *__b_"
	.ascii	"dup_bstr(word s){\n    size_t cap = 64;\n    char *buf = (ch"
	.ascii	"ar*)malloc(cap);\n    if (!buf) { fprintf(stderr, \"system: "
	.ascii	"out of memory\\n\"); exit(1); }\n\n    size_t i = 0;\n    fo"
	.ascii	"r (;;) {\n        word ch = b_char(s, (word)i);\n        if "
	.ascii	"(ch == 004 || ch == 0) break;\n        if (i + 1 >= cap) {\n"
	.ascii	"            size_t ncap = cap * 2;\n            char *nbuf ="
	.ascii	" (char*)realloc(buf, ncap);\n            if (!nbuf) { free(b"
	.ascii	"uf); fprintf(stderr, \"system: out of memory\\n\"); exit(1);"
	.ascii	" }\n            buf = nbuf;\n            cap = ncap;\n      "
	.ascii	"  }\n        buf[i++] = (char)(ch & 0xFF);\n    }\n    buf[i"
	.ascii	"] = 0;\n    return buf;\n}\n\nstatic void _"
	.ascii	"_b_setargs(int argc, char **argv){\n    __b_argc = argc;\n  "
	.ascii	"  __b_argv = argv;\n\n    __b_argvb = (word*)malloc(sizeof(w"
	.ascii	"ord) * ((size_t)argc + 1));\n    if (!__b_argvb) { fprintf(s"
	.ascii	"tderr, \"argv: out of memory\\n\"); exit(1); }\n\n    word *"
	.ascii	"vector = (word*)malloc(sizeof(word) * ((size_t)argc + 1));\n"
	.ascii	"    if (!vector) { fprintf(stderr, \"argv: out of memory\\n\""
	.ascii	"); exit(1); }\n    vector[0] = WVAL(argc);\n    for (int i ="
	.ascii	" 0; i < argc; i++){\n        __b_argvb[i] = __b_pack_cstr(ar"
	.ascii	"gv[i]);\n        vector[i+1] = __b_pack_cstr(argv[i]);\n    "
	.ascii	"    b_lchar(vector[i+1], (word)strlen(argv[i]), 0);\n    }\n"
	.ascii	"    b_argv_vector = B_PTR_N(vector, sizeof(word) * ((size_t)"
	.ascii	"argc + 1));\n}\nstatic word __b_argvalues(void) {\n    retur"
	.ascii	"n __b_argc ? B_PTR_N(__b_argvb, sizeof(word) * (size_t)__b_a"
	.ascii	"rgc) : 0;\n}\n\nstatic word b_argc(void) { return (word)__b_"
	.ascii	"argc; }\n\nstatic word b_argv(word i) {\n    int idx = (int)"
	.ascii	"i;\n    if (idx < 0 || idx >= __b_argc) return 0;\n    retur"
	.ascii	"n __b_argvb[idx];\n}\n\nstatic word b_reread(void) {\n    /*"
	.ascii	" If no args, nothing to reread */\n    if (__b_argc <= 1) {\n"
	.ascii	"        return 0;\n    }\n\n    /* Compute total length of j"
	.ascii	"oined argv[0..] with spaces + newline */\n    size_t total ="
	.ascii	" 1; /* for trailing newline */\n    for (int i = 0; i < __b_"
	.ascii	"argc; i++) {\n        total += strlen(__b_argv[i]);\n       "
	.ascii	" if (i + 1 < __b_argc) total += 1; /* space */\n    }\n    \n"
	.ascii	"    char *buf = (char*)malloc(total + 1);\n    if (!buf) { f"
	.ascii	"printf(stderr, \"reread: out of memory\\n\"); exit(1); }\n  "
	.ascii	"  \n    size_t pos = 0;\n    for (int i = 0; i < __b_argc; i"
	.ascii	"++) {\n        size_t len = strlen(__b_argv[i]);\n        me"
	.ascii	"mcpy(buf + pos, __b_argv[i], len);\n        pos += len;\n   "
	.ascii	"     if (i + 1 < __b_argc) buf[pos++] = ' ';\n    }\n    buf"
	.ascii	"[pos++] = '\\n';\n    buf[pos] = '\\0';\n    \n    int p[2];"
	.ascii	"\n    if (pipe(p) != 0) { free(buf); fprintf(stderr, \"rerea"
	.ascii	"d: pipe failed\\n\"); exit(1); }\n    ssize_t wn = write(p[1"
	.ascii	"], buf, pos);\n    (void)wn;\n    close(p[1]);\n    free(buf"
	.ascii	");\n    \n    /* Close previous rd fd if it wasn't the termi"
	.ascii	"nal */\n    if (rd_fd != 0 && rd_f"
	.ascii	"d != p[0]) close(rd_fd);\n    rd_fd = p[0];\n    rd_unit = ("
	.ascii	"word)0;\n    __b_sync_rd();\n    return 0;\n}\n\n/* I/O func"
	.ascii	"tions */\nstatic word b_getchr(void) {\n    __b_sync_rd();\n"
	.ascii	"    unsigned char c;\n    ssize_t n = read(rd_fd, &c, 1);\n "
	.ascii	"   if (n == 1) return (word)c;\n    if (rd_fd != 0) {\n     "
	.ascii	"   close(rd_fd);\n        rd_fd = 0;\n        rd_unit = -1;\n"
	.ascii	"        return b_getchr();\n    }\n    return (word)004; /* "
	.ascii	"Return *e on EOF */\n}\nstatic word b_putchr(word w) {\n    "
	.ascii	"__b_sync_wr();\n    unsigned char c = (unsigned char)(w & 0x"
	.ascii	"FF);\n    (void)write(wr_fd, &c, 1);\n    return w;\n}\nstat"
	.ascii	"ic word b_putstr(word s) {\n    __b_sync_wr();\n    word i ="
	.ascii	" 0;\n    for (;;) {\n        word ch = b_char(s, i++);\n    "
	.ascii	"    if (ch == 004 || (!__bcc_strict_runtime && ch == 0)) bre"
	.ascii	"ak;\n        b_putchar(ch);\n    }\n    return s;\n}\nstatic"
	.ascii	" word b_getstr(word buf) {\n    __b_sync_rd();\n    size_t i"
	.ascii	" = 0;\n    unsigned char c;\n    for (;;) {\n        ssize_t"
	.ascii	" n = read(rd_fd, &c, 1);\n        if (n == 1 && c != '\\n' &"
	.ascii	"& c != '\\r') {\n            b_lchar(buf, (word)i, (word)c);"
	.ascii	"\n            i++;\n            continue;\n        }\n      "
	.ascii	"  if (n == 1) break; /* newline */\n        if (rd_fd != 0) "
	.ascii	"{\n            close(rd_fd);\n            rd_fd = 0;\n      "
	.ascii	"      rd_unit = -1;\n            continue; /* retry on termi"
	.ascii	"nal */\n        }\n  "
	.string	"      break; /* EOF */\n    }\n    b_lchar(buf, (word)i, (word)004);\n    return buf;\n}\nstatic word b_flush(void){\n    __b_sync_wr();\n    if (wr_fd == 1) {\n        fflush(stdout);\n    } else {\n        fsync(wr_fd);\n    }\n    return 0;\n}\n\n#include <stdarg.h>\n\n"
	.section	.rodata.str1.1
.LC189:
	.string	"%s/bformat.h"
	.section	.rodata.str1.8
	.align 8
.LC190:
	.string	"#define __bcc_format_linkage static\n"
	.align 8
.LC191:
	.ascii	"/* File I/O functions - with actual implementations */\n#inc"
	.ascii	"lude <fcntl.h>\nstatic word b_open(word name, word mode){\n "
	.ascii	"   const char *p = __b_cstr(name);\n    int flags = ((int)mo"
	.ascii	"de == 0) ? O_RDONLY : O_WRONLY;\n    return (word)open(p, fl"
	.ascii	"ags);\n}\nstatic word b_openr(word fd, word name){\n    char"
	.ascii	" buf[512];\n    __b_bstr_to_cstr(name, buf, sizeof(buf));\n "
	.ascii	"   int target = (int)fd;\n    if (target < 0 || buf[0] == '\\"
	.ascii	"0') {\n        rd_fd = 0; rd_unit = -1; return 0;\n    }\n  "
	.ascii	"  int newfd = open(buf, O_RDONLY);\n    if (rd_fd != 0 && rd"
	.ascii	"_fd != target) close(rd_fd);\n    if (newfd < 0) { rd_fd = -"
	.ascii	"1; rd_unit = (word)target; return -1; }\n    if (newfd != ta"
	.ascii	"rget) {\n        if (dup2(newfd, target) < 0) { close(newfd)"
	.ascii	"; return -1; }\n        close(newfd);\n        newfd = targe"
	.ascii	"t;\n    }\n    rd_fd = newfd;\n    rd_unit = (word)target;\n"
	.ascii	"    return (word)newfd;\n}\nstatic word b_openw(word fd, wor"
	.ascii	"d name){\n    char buf[512];\n    __b_bstr_to_cstr(name, buf"
	.ascii	", sizeof(buf));\n    int target = (int)fd;\n    if (target <"
	.ascii	" 0 || buf[0] == '\\0') {\n        wr_fd = 1; wr_unit = -1; r"
	.ascii	"eturn 1;\n    }\n    int newfd = open(buf, O_WRONLY | O_CREA"
	.ascii	"T | O_TRUNC, 0666);\n    if (newfd < 0) return -1;\n    if ("
	.ascii	"wr_fd != 1 && wr_fd != target && wr_fd != newfd) close(wr_fd"
	.ascii	");\n    if (newfd != target) {\n        if (dup2(newfd, targ"
	.ascii	"et) < 0) { close(newfd); return -1; }\n        close(newfd);"
	.ascii	"\n        newfd = target;\n    }\n    wr_fd = newfd;\n    wr"
	.ascii	"_unit = (word)target;\n    return (word)newfd;\n}\nstatic wo"
	.ascii	"rd b_close(word fd) {\n    int cfd = (int)fd;\n    word r = "
	.ascii	"(word)close(cfd);\n    if (r == 0) {\n        if (cfd == rd_"
	.ascii	"fd || cfd == (int)rd_unit) { rd_fd = 0; rd_unit = -1; }\n   "
	.ascii	"     if (cfd == wr_fd || cfd == (int)wr_unit) { wr_fd = 1; w"
	.ascii	"r_unit = -1; }\n    }\n    return r;\n}\nstatic word b_read("
	.ascii	"word fd, word buf, word n) {\n#if WORD_BITS == 16\n    if (n"
	.ascii	" < 0) return -1;\n    unsigned char *bytes = malloc(n ? (siz"
	.ascii	"e_t)n : 1);\n    if (!bytes) return -1;\n    ssize_t count ="
	.ascii	" read((int)fd, bytes, (size_t)n);\n    for (ssize_t i = 0; i"
	.ascii	" < count; i++) b_lcha"
	.ascii	"r(buf, (word)i, bytes[i]);\n    free(bytes);\n    return WVA"
	.ascii	"L(count);\n#else\n    char *p = (char*)B_CPTR(buf);\n    ret"
	.ascii	"urn (word)read((int)fd, p, (size_t)n);\n#endif\n}\nstatic wo"
	.ascii	"rd b_write(word fd, word buf, word n) {\n#if WORD_BITS == 16"
	.ascii	"\n    if (n < 0) return -1;\n    unsigned char *bytes = mall"
	.ascii	"oc(n ? (size_t)n : 1);\n    if (!bytes) return -1;\n    for "
	.ascii	"(word i = 0; i < n; i++) bytes[i] = (unsigned char)b_char(bu"
	.ascii	"f, i);\n    ssize_t count = write((int)fd, bytes, (size_t)n)"
	.ascii	";\n    free(bytes);\n    return WVAL(count);\n#else\n    ret"
	.ascii	"urn (word)write((int)fd, B_CPTR(buf), (size_t)n);\n#endif\n}"
	.ascii	"\nstatic word b_creat(word name, word mode) {\n    const cha"
	.ascii	"r *p = __b_cstr(name);\n    return (word)creat(p, __bcc_unix"
	.ascii	"_mode(mode, 0));\n}\nstatic word b_seek(word fd, word offset"
	.ascii	", word whence) {\n    off_t r = lseek((int)fd, (off_t)offset"
	.ascii	", (int)whence);\n    return (r < 0) ? (word)-1 : (word)0;\n}"
	.ascii	"\n\n/* Process control functions - with actual implementatio"
	.ascii	"ns */\nstatic word b_fork(void) {\n    return (word)fork();\n"
	.ascii	"}\nstatic word __b_wait_status;\n\nstatic word b_wait(void) "
	.ascii	"{\n    int st = 0;\n    pid_t pid = wait(&st);\n    __b_wait"
	.ascii	"_status = (word)st;\n    return (word)pid;\n}\n/* B72 sectio"
	.ascii	"n 8 passes exactly count argument strings, including arg0. *"
	.ascii	"/\nstatic word b_execv(word path, word argv, word count) {\n"
	.ascii	"    if (count < 0 || count > 255 || (count && !argv)) return"
	.ascii	" -1;\n    char *name = __b_dup_bstr(path);\n    if (!name) r"
	.ascii	"eturn -1;\n    char *arguments[256];\n    word *values = cou"
	.ascii	"nt ? (word*)B_CPTR(argv) : NULL;\n    size_t n = (size_t)cou"
	.ascii	"nt, i = 0;\n    for (; i < n; i++) {\n        if (!values[i]"
	.ascii	") break;\n        arguments[i] = __b_dup_bstr(values[i]);\n "
	.ascii	"       if (!arguments[i]) break;\n    }\n    if (i == n) {\n"
	.ascii	"        arguments[n] = NULL;\n        execv(name, arguments)"
	.ascii	";\n    }\n    while (i) free(arguments[--i]);\n    free(name"
	.ascii	");\n    return -1;\n}\n\nstatic word b_execl(word path, ...)"
	.ascii	" {\n    char *name = __b_dup_bstr(path);\n    if (!name) ret"
	.ascii	"urn -1;\n    char *arguments[256];\n    size_t n = 0;\n    i"
	.ascii	"nt complete = 0;\n    va_list"
	.ascii	" ap;\n    va_start(ap, path);\n    while (n < 255) {\n      "
	.ascii	"  word value = va_arg(ap, word);\n        if (!value) { comp"
	.ascii	"lete = 1; break; }\n        arguments[n] = __b_dup_bstr(valu"
	.ascii	"e);\n        if (!arguments[n]) break;\n        n++;\n    }\n"
	.ascii	"    va_end(ap);\n    if (complete) {\n        arguments[n] ="
	.ascii	" NULL;\n        execv(name, arguments);\n    }\n    while (n"
	.ascii	") free(arguments[--n]);\n    free(name);\n    return -1;\n}\n"
	.ascii	"\nstatic word b_system(word cmd) {\n    /* Split arguments w"
	.ascii	"ithout invoking a shell or expanding their contents. */\n   "
	.ascii	" char *line = __b_dup_bstr(cmd);\n    if (!line) return -1;\n"
	.ascii	"    char *argv[128];\n    size_t argc = 0;\n    char *p = li"
	.ascii	"ne, *q = line;\n    while (*p) {\n        while (*p && isspa"
	.ascii	"ce((unsigned char)*p)) p++;\n        if (!*p) break;\n      "
	.ascii	"  if (argc + 1 >= sizeof(argv)/sizeof(argv[0])) { free(line)"
	.ascii	"; return -1; }\n        argv[argc++] = q;\n        int quote"
	.ascii	" = 0;\n        while (*p && (quote || !isspace((unsigned cha"
	.ascii	"r)*p))) {\n            unsigned char c = (unsigned char)*p++"
	.ascii	";\n            if (c == '\\\\' && quote != '\\'') {\n       "
	.ascii	"         if (!*p) { free(line); return -1; }\n              "
	.ascii	"  *q++ = *p++;\n            } else if (c == '\\'' || c == '\""
	.ascii	"') {\n                if (!quote) quote = c;\n              "
	.ascii	"  else if (quote == c) quote = 0;\n                else *q++"
	.ascii	" = (char)c;\n            } else *q++ = (char)c;\n        }\n"
	.ascii	"        if (quote) { free(line); return -1; }\n        if (*"
	.ascii	"p) p++;\n        *q++ = 0;\n    }\n    if (argc == 0) { free"
	.ascii	"(line); return -1; }\n    argv[argc] = NULL;\n    pid_t pid "
	.ascii	"= fork();\n    if (pid == 0) {\n        execvp(argv[0], argv"
	.ascii	");\n        _exit(127);\n    }\n    if (pid < 0) { free(line"
	.ascii	"); return -1; }\n    int st = 0;\n    pid_t w;\n    do { w ="
	.ascii	" waitpid(pid, &st, 0); } while (w < 0 && errno == EINTR);\n "
	.ascii	"   free(line);\n    if (w < 0) return -1;\n    return (word)"
	.ascii	"st;\n}\n\nstatic word b_usleep(word usec) {\n    usleep((use"
	.ascii	"conds_t)usec);\n    return 0;\n}\n\nstatic word b_callf_disp"
	.ascii	"atch(int nargs, word name, ...) {\n    static int __b_callf_"
	.ascii	"dl_done = 0;\n    if (!__b_call"
	.ascii	"f_dl_done) {\n        __b_callf_dl_done = 1;\n        const "
	.ascii	"char *env = getenv(\"B_CALLF_LIB\");\n        if (env && *en"
	.ascii	"v) {\n            const char *p = env;\n            while (*"
	.ascii	"p) {\n                const char *start = p;\n              "
	.ascii	"  while (*p && *p != ':') p++;\n                size_t len ="
	.ascii	" (size_t)(p - start);\n                if (len) {\n         "
	.ascii	"           char *path = (char*)malloc(len + 1);\n           "
	.ascii	"         if (path) {\n                        memcpy(path, s"
	.ascii	"tart, len);\n                        path[len] = '\\0';\n   "
	.ascii	"                     (void)dlopen(path, RTLD_NOW | RTLD_GLOB"
	.ascii	"AL);\n                        free(path);\n                 "
	.ascii	"   }\n                }\n                if (*p == ':') p++;"
	.ascii	"\n            }\n        }\n    }\n    if (nargs < 0 || narg"
	.ascii	"s > 10) return -1;\n    if (name == 0) return -1;\n \n    ch"
	.ascii	"ar sym[256];\n    __b_bstr_to_cstr(name, sym, sizeof(sym));\n"
	.ascii	" \n    void *fn = dlsym(RTLD_DEFAULT, sym);\n    if (!fn) {\n"
	.ascii	"        size_t len = strlen(sym);\n        if (len + 2 < siz"
	.ascii	"eof(sym)) {\n            sym[len] = '_'; sym[len + 1] = '\\0"
	.ascii	"';\n            fn = dlsym(RTLD_DEFAULT, sym);\n            "
	.ascii	"sym[len] = '\\0';\n        }\n    }\n    if (!fn) return -1;"
	.ascii	"\n \n    void *args[10] = {0};\n    va_list ap;\n    va_star"
	.ascii	"t(ap, name);\n    for (int i = 0; i < nargs && i < 10; i++) "
	.ascii	"{\n        word w = va_arg(ap, word);\n        args[i] = B_C"
	.ascii	"PTR(w);\n    }\n    va_end(ap);\n \n    word r = 0;\n    swi"
	.ascii	"tch (nargs) {\n    case 0: r = ((word (*)(void))fn)(); break"
	.ascii	";\n    case 1: r = ((word (*)(void*))fn)(args[0]); break;\n "
	.ascii	"   case 2: r = ((word (*)(void*, void*))fn)(args[0], args[1]"
	.ascii	"); break;\n    case 3: r = ((word (*)(void*, void*, void*))f"
	.ascii	"n)(args[0], args[1], args[2]); break;\n    case 4: r = ((wor"
	.ascii	"d (*)(void*, void*, void*, void*))fn)(args[0], args[1], args"
	.ascii	"[2], args[3]); break;\n    case 5: r = ((word (*)(void*, voi"
	.ascii	"d*, void*, void*, void*))fn)(args[0], args[1], args[2], args"
	.ascii	"[3], args[4]); break;\n    case 6: r = ((word (*)(void*, voi"
	.ascii	"d*, void*, void*, void*, void*))fn)(args[0], args[1], args[2"
	.ascii	"], args[3], args[4]"
	.ascii	", args[5]); break;\n    case 7: r = ((word (*)(void*, void*,"
	.ascii	" void*, void*, void*, void*, void*))fn)(args[0], args[1], ar"
	.ascii	"gs[2], args[3], args[4], args[5], args[6]); break;\n    case"
	.ascii	" 8: r = ((word (*)(void*, void*, void*, void*, void*, void*,"
	.ascii	" void*, void*))fn)(args[0], args[1], args[2], args[3], args["
	.ascii	"4], args[5], args[6], args[7]); break;\n    case 9: r = ((wo"
	.ascii	"rd (*)(void*, void*, void*, void*, void*, void*, void*, void"
	.ascii	"*, void*))fn)(args[0], args[1], args[2], args[3], args[4], a"
	.ascii	"rgs[5], args[6], args[7], args[8]); break;\n    case 10: r ="
	.ascii	" ((word (*)(void*, void*, void*, void*, void*, void*, void*,"
	.ascii	" void*, void*, void*))fn)(args[0], args[1], args[2], args[3]"
	.ascii	", args[4], args[5], args[6], args[7], args[8], args[9]); bre"
	.ascii	"ak;\n    default: return -1;\n    }\n    return r;\n}\n\n/* "
	.ascii	"System functions - with actual implementations where possibl"
	.ascii	"e */\n/* Unix V1 counts 60 Hz ticks since 1971, high word fi"
	.ascii	"rst (time(II)). */\nstatic word b_time(word tvp) {\n    stru"
	.ascii	"ct timespec now;\n    if (clock_gettime(CLOCK_REALTIME, &now"
	.ascii	") != 0) return -1;\n    if (tvp) {\n        uint64_t elapsed"
	.ascii	" = (uint64_t)now.tv_sec - UINT64_C(31536000);\n        uint3"
	.ascii	"2_t ticks = (uint32_t)(elapsed * 60 + (uint64_t)now.tv_nsec "
	.ascii	"* 60 / 1000000000);\n        word *tv = (word*)B_CPTR(tvp);\n"
	.ascii	"        tv[0] = WVAL(ticks >> 16);\n        tv[1] = WVAL(tic"
	.ascii	"ks & 65535);\n    }\n    return 0;\n}\n\n/* B72 section 8 sp"
	.ascii	"ecifies a caller-owned, 16-byte date buffer. */\nstatic word"
	.ascii	" b_ctime(word tvp, word date) {\n    if (!tvp || !date) retu"
	.ascii	"rn -1;\n    word *tv = (word*)B_CPTR(tvp);\n    uint32_t tic"
	.ascii	"ks = ((uint32_t)(uint16_t)tv[0] << 16) | (uint16_t)tv[1];\n "
	.ascii	"   unsigned days = ticks / 5184000U;\n    unsigned seconds ="
	.ascii	" ticks / 60U % 86400U;\n    unsigned year = 1971, month = 0;"
	.ascii	"\n    while (days >= (year % 4 == 0 ? 366U : 365U)) {\n     "
	.ascii	"   days -= year % 4 == 0 ? 366U : 365U;\n        year++;\n  "
	.ascii	"  }\n    static const unsigned lengths[] = {31,28,31,30,31,3"
	.ascii	"0,31,31,30,31,30,31};\n    static const char *months[] = {\""
	.ascii	"Jan\",\"Feb\",\"Mar\",\"Apr\",\"May\",\"Jun\",\"Jul\",\"Aug\""
	.ascii	",\"Sep\",\"Oct\""
	.ascii	",\"Nov\",\"Dec\"};\n    for (;;) {\n        unsigned length "
	.ascii	"= lengths[month] + (month == 1 && year % 4 == 0);\n        i"
	.ascii	"f (days < length) break;\n        days -= length;\n        m"
	.ascii	"onth++;\n    }\n    char text[16];\n    snprintf(text, sizeo"
	.ascii	"f(text), \"%s %2u %02u:%02u:%02u\", months[month], days + 1,"
	.ascii	"\n             seconds / 3600, seconds / 60 % 60, seconds % "
	.ascii	"60);\n    for (size_t i = 0; i < sizeof(text); i++) b_lchar("
	.ascii	"date, (word)i, (word)(unsigned char)text[i]);\n    return 0;"
	.ascii	"\n}\n\nstatic word b_getuid(void) {\n    return (word)getuid"
	.ascii	"();\n}\nstatic word b_chdir(word path) {\n    const char *p "
	.ascii	"= __b_cstr(path);\n    return (word)chdir(p);\n}\nstatic wor"
	.ascii	"d b_unlink(word path) {\n    const char *p = __b_cstr(path);"
	.ascii	"\n    return (word)unlink(p);\n}\n\n/* System functions with"
	.ascii	" actual implementations */\nstatic word b_chmod(word path, w"
	.ascii	"ord mode) {\n    const char *p = __b_cstr(path);\n    return"
	.ascii	" (word)chmod(p, __bcc_unix_mode(mode, 0));\n}\nstatic word b"
	.ascii	"_chown(word path, word owner) {\n    const char *p = __b_cst"
	.ascii	"r(path);\n    return (word)chown(p, (uid_t)owner, (gid_t)-1)"
	.ascii	";\n}\nstatic word b_link(word old, word new) {\n    const ch"
	.ascii	"ar *o = __b_cstr(old);\n    const char *n = __b_cstr(new);\n"
	.ascii	"    return (word)link(o, n);\n}\nstatic word b_stat(word pat"
	.ascii	"h, word bufp) {\n    if (!bufp) { errno = EFAULT; return -1;"
	.ascii	" }\n    const char *p = __b_cstr(path);\n    struct stat st;"
	.ascii	"\n    if (stat(p, &st) != 0) return -1;\n    __bcc_unix_stat"
	.ascii	"((word*)B_CPTR(bufp), &st);\n    return 0;\n}\n\nstatic word"
	.ascii	" b_fstat(word fd, word bufp) {\n    if (!bufp) { errno = EFA"
	.ascii	"ULT; return -1; }\n    struct stat st;\n    if (fstat((int)f"
	.ascii	"d, &st) != 0) return -1;\n    __bcc_unix_stat((word*)B_CPTR("
	.ascii	"bufp), &st);\n    return 0;\n}\n\nstatic word b_setuid(word "
	.ascii	"uid) {\n    return (word)setuid((uid_t)uid);\n}\nstatic word"
	.ascii	" b_makdir(word path, word mode) {\n    const char *p = __b_c"
	.ascii	"str(path);\n    return (word)mkdir(p, __bcc_unix_mode(mode, "
	.ascii	"1));\n}\n\nstatic word b_mkdir(word path, word mode) { retur"
	.ascii	"n b_makdir(path, mode); }\nstatic word b_putnum(word n) {\n "
	.ascii	"   b_printn(n, (word)10);\n    ret"
	.ascii	"urn n;\n}\nstatic volatile sig_atomic_t __b_got_intr = 0;\n\n"
	.ascii	"static void __b_sigint(int sig){ (void)sig; __b_got_intr = 1"
	.ascii	"; }\n\nstatic word b_gtty(word fd, word ttstat){\n    struct"
	.ascii	" termios t;\n    if (tcgetattr((int)fd, &t) < 0) return -1;\n"
	.ascii	"\n    word *vec = (word*)B_CPTR(ttstat);\n    vec[0] = (word"
	.ascii	")t.c_iflag;\n    vec[1] = (word)t.c_oflag;\n    vec[2] = (wo"
	.ascii	"rd)t.c_lflag;\n    return 0;\n}\n\nstatic word b_stty(word f"
	.ascii	"d, word ttstat){\n    struct termios t;\n    if (tcgetattr(("
	.ascii	"int)fd, &t) < 0) return -1;\n\n    word *vec = (word*)B_CPTR"
	.ascii	"(ttstat);\n    t.c_iflag = (tcflag_t)vec[0];\n    t.c_oflag "
	.ascii	"= (tcflag_t)vec[1];\n    t.c_lflag = (tcflag_t)vec[2];\n    "
	.ascii	"return (word)tcsetattr((int)fd, TCSANOW, &t);\n}\nstatic wor"
	.ascii	"d b_intr(word on) {\n    /* Set up interrupt handling */\n  "
	.ascii	"  /* on != 0: catch interrupts, on =="
	.string	" 0: restore default */\n    if (on) {\n        __b_got_intr = 0;\n        if (signal(SIGINT, __b_sigint) == SIG_ERR) return -1;\n    } else {\n        if (signal(SIGINT, SIG_DFL) == SIG_ERR) return -1;\n    }\n    return 0;\n}\n\n/* Builtin aliases for B source */\n\n"
	.section	.rodata.str1.1
.LC192:
	.string	"word __b_user_main("
	.section	.rodata.str1.8
	.align 8
.LC193:
	.string	"int main(int argc, char **argv){\n"
	.section	.rodata.str1.1
.LC194:
	.string	"    __b_setargs(argc, argv);\n"
.LC195:
	.string	"    __b_init();\n"
	.section	.rodata.str1.8
	.align 8
.LC196:
	.string	"    return (int)((word (*)())B_FUNCTION_CPTR("
	.section	.rodata.str1.1
.LC197:
	.string	"(word)argc"
.LC198:
	.string	", __b_argvalues()"
	.text
	.p2align 4
	.globl	emit_program_c
	.type	emit_program_c, @function
emit_program_c:
.LFB66:
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
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	%r9d, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	movq	%rsi, %rdi
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movaps	%xmm0, external_calls(%rip)
	pxor	%xmm0, %xmm0
	movq	%rsi, current_program(%rip)
	movq	%rdx, 8(%rsp)
	movl	%ecx, current_byteptr(%rip)
	movl	%r9d, current_word_bits(%rip)
	movq	$0, 16+external_calls(%rip)
	movq	$0, string_pool(%rip)
	movq	$0, 8+name_map(%rip)
	movups	%xmm0, 8+string_pool(%rip)
	call	collect_strings_program
	movl	g_use_curses(%rip), %esi
	testl	%esi, %esi
	jne	.L1673
.L1650:
	movq	%rbx, %rcx
	movl	$1529, %edx
	movl	$1, %esi
	leaq	.LC178(%rip), %rdi
	call	fwrite@PLT
	movl	g_strict(%rip), %ecx
	xorl	%edx, %edx
	movq	%rbx, %rdi
	leaq	.LC179(%rip), %rsi
	testl	%ecx, %ecx
	setne	%dl
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbx, %rdi
	setne	%dl
	leaq	.LC180(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%ebp, %edx
	leaq	.LC181(%rip), %rsi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	leaq	40(%rsp), %rbp
	call	fprintf@PLT
	movq	%rbx, %rcx
	movl	$1441, %edx
	movl	$1, %esi
	leaq	.LC182(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC183(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$73, %edx
	movl	$1, %esi
	leaq	.LC184(%rip), %rdi
	movq	%rax, %r13
	call	fwrite@PLT
	movq	40(%rsp), %rdx
	movq	%rbx, %rcx
	movq	%r13, %rdi
	movl	$1, %esi
	call	fwrite@PLT
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	movq	%r13, %rdi
	call	free@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC185(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC186(%rip), %rdi
	movq	%rax, %r13
	call	fwrite@PLT
	movq	40(%rsp), %rdx
	movq	%rbx, %rcx
	movq	%r13, %rdi
	movl	$1, %esi
	call	fwrite@PLT
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	movq	%r13, %rdi
	call	free@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC187(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	40(%rsp), %rdx
	movq	%rbx, %rcx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, %r13
	call	fwrite@PLT
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	movq	%r13, %rdi
	call	free@PLT
	movq	%rbx, %rcx
	movl	$11541, %edx
	movl	$1, %esi
	leaq	.LC188(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC189(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$36, %edx
	movl	$1, %esi
	leaq	.LC190(%rip), %rdi
	movq	%rax, %rbp
	call	fwrite@PLT
	movq	40(%rsp), %rdx
	movq	%rbx, %rcx
	movq	%rbp, %rdi
	movl	$1, %esi
	call	fwrite@PLT
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	movq	%rbp, %rdi
	call	free@PLT
	movq	%rbx, %rcx
	movl	$13046, %edx
	movl	$1, %esi
	leaq	.LC191(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1674
.L1651:
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_function_prototypes
	movq	8(%rsp), %r15
	movq	%r12, %rsi
	movq	%rbx, %rdi
	movq	%r15, %rdx
	call	emit_global_declarations
	movq	%r15, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_global_initializers
	cmpq	$0, 8(%r12)
	je	.L1649
	movq	$0, 24(%rsp)
	xorl	%ebp, %ebp
	movl	$0, 20(%rsp)
	.p2align 5
	.p2align 4
	.p2align 3
.L1659:
	movq	(%r12), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$1, (%rax)
	je	.L1675
.L1653:
	addq	$1, %rbp
	cmpq	8(%r12), %rbp
	jb	.L1659
	movl	20(%rsp), %eax
	testl	%eax, %eax
	jne	.L1676
.L1649:
	addq	$56, %rsp
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
.L1675:
	.cfi_restore_state
	movq	8(%rax), %r14
	leaq	.LC22(%rip), %rsi
	movq	(%r14), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1677
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
	movq	(%r14), %rsi
	movq	%rbx, %rdi
	call	emit_function_body_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
.L1655:
	cmpq	$0, 16(%r14)
	je	.L1656
	xorl	%r13d, %r13d
	leaq	.LC29(%rip), %r15
	jmp	.L1658
	.p2align 4,,10
	.p2align 3
.L1678:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC33(%rip), %rdi
	call	fwrite@PLT
.L1658:
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r14), %rax
	movq	(%rax,%r13,8), %rdi
	testq	%rdi, %rdi
	je	.L1657
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1657:
	addq	$1, %r13
	cmpq	16(%r14), %r13
	jb	.L1678
.L1656:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC138(%rip), %rdi
	call	fwrite@PLT
	movq	8(%rsp), %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_function_body
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1653
	.p2align 4,,10
	.p2align 3
.L1677:
	movq	16(%r14), %rax
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC192(%rip), %rdi
	movq	%rax, 24(%rsp)
	call	fwrite@PLT
	movl	$1, 20(%rsp)
	jmp	.L1655
	.p2align 4,,10
	.p2align 3
.L1676:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC193(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC194(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC195(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$45, %edx
	movl	$1, %esi
	leaq	.LC196(%rip), %rdi
	call	fwrite@PLT
	leaq	.LC22(%rip), %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC39(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC73(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%rsp)
	jne	.L1679
.L1663:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC34(%rip), %rdi
	call	fwrite@PLT
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$2, %edx
	popq	%rbx
	.cfi_def_cfa_offset 48
	movl	$1, %esi
	leaq	.LC123(%rip), %rdi
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
.L1674:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1651
	.p2align 4,,10
	.p2align 3
.L1673:
	movq	%rbx, %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC177(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1650
	.p2align 4,,10
	.p2align 3
.L1679:
	movq	%rbx, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC197(%rip), %rdi
	call	fwrite@PLT
	cmpq	$2, 24(%rsp)
	jne	.L1663
	movq	%rbx, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC198(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1663
	.cfi_endproc
.LFE66:
	.size	emit_program_c, .-emit_program_c
	.section	.rodata.str1.8
	.align 8
.LC199:
	.string	"/* Generated by BCC - B Compiler */\n"
	.section	.rodata.str1.1
.LC200:
	.string	"#include \"libb.h\"\n\n"
	.section	.rodata.str1.8
	.align 8
.LC201:
	.string	"#include <ncurses.h>\n#include <panel.h>\n\n"
	.text
	.p2align 4
	.globl	emit_program_c_ext
	.type	emit_program_c_ext, @function
emit_program_c_ext:
.LFB67:
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
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	%r9d, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movl	96(%rsp), %edi
	movq	%rdx, 8(%rsp)
	testl	%edi, %edi
	je	.L1705
	pxor	%xmm0, %xmm0
	movq	%rsi, %rdi
	movl	%r9d, current_word_bits(%rip)
	movaps	%xmm0, external_calls(%rip)
	pxor	%xmm0, %xmm0
	movups	%xmm0, 8+string_pool(%rip)
	movq	%rsi, current_program(%rip)
	movl	%ecx, current_byteptr(%rip)
	movq	$0, 16+external_calls(%rip)
	movq	$0, string_pool(%rip)
	movq	$0, 8+name_map(%rip)
	call	collect_strings_program
	movq	%rbx, %rcx
	movl	$36, %edx
	movl	$1, %esi
	leaq	.LC199(%rip), %rdi
	call	fwrite@PLT
	movl	g_strict(%rip), %ecx
	xorl	%edx, %edx
	movq	%rbx, %rdi
	leaq	.LC179(%rip), %rsi
	testl	%ecx, %ecx
	setne	%dl
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbx, %rdi
	setne	%dl
	leaq	.LC180(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%ebp, %edx
	leaq	.LC181(%rip), %rsi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	call	fprintf@PLT
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$19, %edx
	leaq	.LC200(%rip), %rdi
	call	fwrite@PLT
	movl	g_use_curses(%rip), %esi
	testl	%esi, %esi
	jne	.L1706
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1707
.L1683:
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_function_prototypes
	movq	8(%rsp), %r15
	movq	%r12, %rsi
	movq	%rbx, %rdi
	movq	%r15, %rdx
	call	emit_global_declarations
	movq	%r15, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_global_initializers
	cmpq	$0, 8(%r12)
	je	.L1680
	movq	$0, 24(%rsp)
	xorl	%ebp, %ebp
	movl	$0, 20(%rsp)
	.p2align 5
	.p2align 4
	.p2align 3
.L1691:
	movq	(%r12), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$1, (%rax)
	je	.L1708
.L1685:
	addq	$1, %rbp
	cmpq	8(%r12), %rbp
	jb	.L1691
	movl	20(%rsp), %eax
	testl	%eax, %eax
	jne	.L1709
.L1680:
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
.L1707:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1683
	.p2align 4,,10
	.p2align 3
.L1706:
	movq	%rbx, %rcx
	movl	$41, %edx
	movl	$1, %esi
	leaq	.LC201(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	je	.L1683
	jmp	.L1707
	.p2align 4,,10
	.p2align 3
.L1709:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC193(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC194(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC195(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$45, %edx
	movl	$1, %esi
	leaq	.LC196(%rip), %rdi
	call	fwrite@PLT
	leaq	.LC22(%rip), %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC39(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC73(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%rsp)
	jne	.L1710
.L1695:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC34(%rip), %rdi
	call	fwrite@PLT
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$2, %edx
	popq	%rbx
	.cfi_def_cfa_offset 48
	movl	$1, %esi
	leaq	.LC123(%rip), %rdi
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
.L1708:
	.cfi_restore_state
	movq	8(%rax), %r14
	leaq	.LC22(%rip), %rsi
	movq	(%r14), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1686
	movq	16(%r14), %rax
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC192(%rip), %rdi
	movq	%rax, 24(%rsp)
	call	fwrite@PLT
	movl	$1, 20(%rsp)
.L1687:
	cmpq	$0, 16(%r14)
	je	.L1688
	xorl	%r13d, %r13d
	leaq	.LC29(%rip), %r15
	jmp	.L1690
	.p2align 4,,10
	.p2align 3
.L1711:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC33(%rip), %rdi
	call	fwrite@PLT
.L1690:
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r14), %rax
	movq	(%rax,%r13,8), %rdi
	testq	%rdi, %rdi
	je	.L1689
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1689:
	addq	$1, %r13
	cmpq	16(%r14), %r13
	jb	.L1711
.L1688:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC138(%rip), %rdi
	call	fwrite@PLT
	movq	8(%rsp), %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_function_body
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1685
	.p2align 4,,10
	.p2align 3
.L1705:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rdi
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
.L1686:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
	movq	(%r14), %rsi
	movq	%rbx, %rdi
	call	emit_function_body_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1687
	.p2align 4,,10
	.p2align 3
.L1710:
	movq	%rbx, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC197(%rip), %rdi
	call	fwrite@PLT
	cmpq	$2, 24(%rsp)
	jne	.L1695
	movq	%rbx, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC198(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1695
	.cfi_endproc
.LFE67:
	.size	emit_program_c_ext, .-emit_program_c_ext
	.section	.rodata
	.align 16
	.type	CSWTCH.175, @object
	.size	CSWTCH.175, 24
CSWTCH.175:
	.long	24
	.long	25
	.long	26
	.long	27
	.long	22
	.long	23
	.section	.rodata.str1.1
.LC202:
	.string	"lchar"
.LC203:
	.string	"getchar"
.LC204:
	.string	"getchr"
.LC205:
	.string	"putchr"
.LC206:
	.string	"getstr"
.LC207:
	.string	"putstr"
.LC208:
	.string	"flush"
.LC209:
	.string	"reread"
.LC210:
	.string	"printn"
.LC211:
	.string	"putnum"
.LC212:
	.string	"print"
.LC213:
	.string	"putchar"
.LC214:
	.string	"abort"
.LC215:
	.string	"free"
.LC216:
	.string	"alloc"
.LC217:
	.string	"open"
.LC218:
	.string	"close"
.LC219:
	.string	"read"
.LC220:
	.string	"write"
.LC221:
	.string	"creat"
.LC222:
	.string	"seek"
.LC223:
	.string	"openr"
.LC224:
	.string	"openw"
.LC225:
	.string	"fork"
.LC226:
	.string	"wait"
.LC227:
	.string	"execl"
.LC228:
	.string	"execv"
.LC229:
	.string	"chdir"
.LC230:
	.string	"chmod"
.LC231:
	.string	"chown"
.LC232:
	.string	"link"
.LC233:
	.string	"unlink"
.LC234:
	.string	"stat"
.LC235:
	.string	"fstat"
.LC236:
	.string	"time"
.LC237:
	.string	"ctime"
.LC238:
	.string	"getuid"
.LC239:
	.string	"setuid"
.LC240:
	.string	"makdir"
.LC241:
	.string	"mkdir"
.LC242:
	.string	"intr"
.LC243:
	.string	"gtty"
.LC244:
	.string	"stty"
.LC245:
	.string	"system"
.LC246:
	.string	"usleep"
.LC247:
	.string	"argc"
	.section	.data.rel.ro.local,"aw"
	.align 32
	.type	names.0, @object
	.size	names.0, 416
names.0:
	.quad	.LC13
	.quad	.LC202
	.quad	.LC203
	.quad	.LC204
	.quad	.LC205
	.quad	.LC206
	.quad	.LC207
	.quad	.LC208
	.quad	.LC209
	.quad	.LC76
	.quad	.LC210
	.quad	.LC211
	.quad	.LC212
	.quad	.LC213
	.quad	.LC82
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
	.quad	.LC231
	.quad	.LC232
	.quad	.LC233
	.quad	.LC234
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
	.quad	.LC74
	.quad	.LC247
	.quad	.LC36
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
	.local	current_program
	.comm	current_program,8,8
	.section	.rodata.str1.1
.LC248:
	.string	"break"
.LC249:
	.string	"case"
.LC250:
	.string	"const"
.LC251:
	.string	"continue"
.LC252:
	.string	"default"
.LC253:
	.string	"do"
.LC254:
	.string	"double"
.LC255:
	.string	"else"
.LC256:
	.string	"enum"
.LC257:
	.string	"extern"
.LC258:
	.string	"float"
.LC259:
	.string	"for"
.LC260:
	.string	"goto"
.LC261:
	.string	"if"
.LC262:
	.string	"inline"
.LC263:
	.string	"int"
.LC264:
	.string	"long"
.LC265:
	.string	"register"
.LC266:
	.string	"restrict"
.LC267:
	.string	"short"
.LC268:
	.string	"signed"
.LC269:
	.string	"sizeof"
.LC270:
	.string	"static"
.LC271:
	.string	"struct"
.LC272:
	.string	"switch"
.LC273:
	.string	"typedef"
.LC274:
	.string	"union"
.LC275:
	.string	"unsigned"
.LC276:
	.string	"void"
.LC277:
	.string	"volatile"
.LC278:
	.string	"while"
.LC279:
	.string	"_Bool"
.LC280:
	.string	"_Complex"
.LC281:
	.string	"_Imaginary"
.LC282:
	.string	"_Alignas"
.LC283:
	.string	"_Alignof"
.LC284:
	.string	"_Atomic"
.LC285:
	.string	"_Generic"
.LC286:
	.string	"_Noreturn"
.LC287:
	.string	"_Static_assert"
.LC288:
	.string	"_Thread_local"
.LC289:
	.string	"NULL"
.LC290:
	.string	"true"
.LC291:
	.string	"false"
.LC292:
	.string	"bool"
.LC293:
	.string	"B_PTR"
.LC294:
	.string	"B_ADDR"
.LC295:
	.string	"B_DEREF"
	.section	.data.rel.ro.local
	.align 32
	.type	c_keywords, @object
	.size	c_keywords, 424
c_keywords:
	.quad	.LC14
	.quad	.LC248
	.quad	.LC249
	.quad	.LC13
	.quad	.LC250
	.quad	.LC251
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
	.quad	.LC144
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
	.quad	.LC278
	.quad	.LC279
	.quad	.LC280
	.quad	.LC281
	.quad	.LC282
	.quad	.LC283
	.quad	.LC284
	.quad	.LC285
	.quad	.LC286
	.quad	.LC287
	.quad	.LC288
	.quad	.LC289
	.quad	.LC290
	.quad	.LC291
	.quad	.LC292
	.quad	.LC32
	.quad	.LC293
	.quad	.LC294
	.quad	.LC295
	.quad	0
	.local	name_map
	.comm	name_map,24,16
	.local	external_calls
	.comm	external_calls,24,16
	.local	string_pool
	.comm	string_pool,24,16
	.local	current_word_bits
	.comm	current_word_bits,4,4
	.section	.note.GNU-stack,"",@progbits
