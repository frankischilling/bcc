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
	movq	40(%r12), %rbx
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
	movq	40(%r12), %rbx
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
	movq	40(%rbx), %rdi
	call	collect_strings_expr
.L421:
	movq	48(%rbx), %rbx
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
	movq	40(%rbx), %rdi
	call	collect_strings_expr
.L420:
	movq	48(%rbx), %rdi
	call	collect_strings_expr
	movq	56(%rbx), %rbx
	jmp	.L398
	.p2align 4,,10
	.p2align 3
.L390:
	movl	g_strict(%rip), %edx
	movq	40(%rbx), %rbp
	testl	%edx, %edx
	jne	.L422
.L392:
	movq	%rbp, %rdi
	call	collect_strings_expr
	cmpq	$0, 56(%rbx)
	je	.L378
	xorl	%ebp, %ebp
.L397:
	movq	48(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_expr
	cmpq	56(%rbx), %rbp
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
	movq	32(%rbx), %rsi
	movq	40(%rbx), %rdi
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
	movq	40(%rbp), %r13
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
	movq	40(%rbx), %rbp
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
	.string	"B_FUNCTION("
.LC71:
	.string	"((word (*)())B_FUNCTION_CPTR("
.LC72:
	.string	"))("
.LC73:
	.string	"callf"
.LC74:
	.string	"b_callf_dispatch(%zu"
.LC75:
	.string	"printf"
.LC76:
	.string	"malloc"
.LC77:
	.string	"calloc"
.LC78:
	.string	"realloc"
.LC79:
	.string	"B_PTR("
.LC80:
	.string	"-+ #0"
.LC81:
	.string	"exit"
.LC82:
	.string	"strlen"
.LC83:
	.string	"atoi"
.LC84:
	.string	"memmove"
.LC85:
	.string	"tcgetattr"
.LC86:
	.string	"tcsetattr"
.LC87:
	.string	"ioctl"
.LC88:
	.string	"memset"
.LC89:
	.string	"memcpy"
.LC90:
	.string	"__b_cstr("
.LC91:
	.string	"B_CPTR("
	.section	.rodata.str1.8
	.align 8
.LC92:
	.string	"(size_t)(sizeof(word) * (uword)("
	.section	.rodata.str1.1
.LC93:
	.string	"))"
.LC94:
	.string	"B_INDEX("
.LC95:
	.string	"B_DEREF("
.LC96:
	.string	"b_"
.LC97:
	.string	"(&("
.LC98:
	.string	"WNEG("
.LC99:
	.string	"({ word __b_left_%u = "
.LC100:
	.string	"; word __b_right_%u = "
	.section	.rodata.str1.8
	.align 8
.LC101:
	.string	"; (word)%s(__b_left_%u, __b_right_%u); })"
	.section	.rodata.str1.1
.LC102:
	.string	"%s("
.LC103:
	.string	" %s "
.LC104:
	.string	" = ("
.LC105:
	.string	"), "
.LC106:
	.string	" ? "
.LC107:
	.string	" : "
.LC108:
	.string	"snprintf"
.LC109:
	.string	"sprintf"
.LC110:
	.string	"fprintf"
.LC111:
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
	movq	40(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC106(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$3, %edx
	leaq	.LC107(%rip), %rdi
	call	fwrite@PLT
	movq	56(%r15), %rsi
.L964:
	movq	%rbp, %rdx
.L965:
	movq	%rbx, %rdi
	call	emit_expr
.L966:
	movq	%rbx, %rsi
.L969:
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
.L968:
	movq	40(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC33(%rip), %rdi
.L967:
	call	fwrite@PLT
	movq	48(%r15), %rsi
	jmp	.L964
	.p2align 4,,10
	.p2align 3
.L528:
	movq	40(%rsi), %rdx
	leaq	.LC67(%rip), %rsi
.L962:
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
	movq	40(%r15), %rdi
	movq	32(%rsi), %rsi
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
	movq	40(%rsi), %r12
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
	movq	40(%rsi), %rax
	movl	24(%rsi), %ebx
	cmpl	$2, (%rax)
	je	.L539
	testl	%ebx, %ebx
	jne	.L540
	movb	$0, 38(%rsp)
	movq	40(%rax), %rsi
	xorl	%r12d, %r12d
	xorl	%r14d, %r14d
	movb	$0, 39(%rsp)
	movq	$0, 24(%rsp)
.L563:
	movq	8(%rsp), %rdi
	call	emit_function_name
.L570:
	movq	8(%rsp), %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	56(%r15), %rdx
	movq	24(%rsp), %rcx
	cmpq	%rdx, %rcx
	jnb	.L571
	cmpb	$0, 39(%rsp)
	je	.L571
	movq	48(%r15), %rax
	movq	(%rax,%rcx,8), %rax
	testq	%rax, %rax
	je	.L598
	cmpl	$1, (%rax)
	je	.L974
.L598:
	movq	$0, 40(%rsp)
.L574:
	movl	%ebx, 48(%rsp)
	movq	8(%rsp), %r13
	xorl	%r12d, %r12d
	movq	%r14, 16(%rsp)
	movq	%rdx, %r14
.L637:
	cmpb	$0, 38(%rsp)
	je	.L712
	movl	g_strict(%rip), %ebx
	testl	%ebx, %ebx
	je	.L975
.L712:
	xorl	%ebx, %ebx
.L600:
	movq	48(%r15), %rax
	movq	%rbp, %rdx
	movq	%r13, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
.L677:
	testl	%ebx, %ebx
	jne	.L976
.L635:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L636
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC33(%rip), %rdi
	call	fwrite@PLT
	jmp	.L637
	.p2align 4,,10
	.p2align 3
.L524:
	movq	8(%rsp), %rbx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC94(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	jmp	.L968
	.p2align 4,,10
	.p2align 3
.L523:
	movl	40(%rsi), %r12d
	cmpl	$32, %r12d
	je	.L977
	cmpl	$53, %r12d
	je	.L978
	leal	-36(%r12), %eax
	cmpl	$1, %eax
	jbe	.L979
	movq	8(%rsp), %rbx
	cmpl	$31, %r12d
	jne	.L646
	movl	current_word_bits(%rip), %edi
	testl	%edi, %edi
	jne	.L980
.L646:
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
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	jmp	.L970
	.p2align 4,,10
	.p2align 3
.L522:
	movq	48(%rsi), %r12
	movl	40(%rsi), %r13d
	testq	%r12, %r12
	je	.L647
	movl	(%r12), %eax
	cmpl	$4, %eax
	je	.L648
	cmpl	$5, %eax
	jne	.L647
	cmpl	$32, 40(%r12)
	je	.L648
	.p2align 4
	.p2align 3
.L647:
	movl	current_word_bits(%rip), %esi
	testl	%esi, %esi
	je	.L649
.L648:
	movq	8(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC96(%rip), %rdi
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
	leaq	.LC97(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r12, %rsi
.L970:
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC93(%rip), %rdi
.L963:
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
	movl	40(%rsi), %r12d
	leal	-53(%r12), %eax
	cmpl	$1, %eax
	jbe	.L981
	movl	current_word_bits(%rip), %ecx
	testl	%ecx, %ecx
	je	.L653
	leal	-28(%r12), %eax
	cmpl	$6, %eax
	ja	.L653
	leaq	.L655(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L655:
	.long	.L723-.L655
	.long	.L660-.L655
	.long	.L659-.L655
	.long	.L658-.L655
	.long	.L657-.L655
	.long	.L656-.L655
	.long	.L654-.L655
	.text
	.p2align 4,,10
	.p2align 3
.L520:
	movl	40(%rsi), %r12d
	movq	48(%rsi), %r13
	movq	56(%rsi), %r14
	leal	-47(%r12), %eax
	cmpl	$5, %eax
	jbe	.L982
	cmpl	$21, %r12d
	je	.L663
	testq	%r13, %r13
	je	.L664
	movl	0(%r13), %eax
	cmpl	$4, %eax
	je	.L665
	cmpl	$5, %eax
	je	.L983
.L664:
	movl	current_word_bits(%rip), %edx
	testl	%edx, %edx
	je	.L663
.L665:
	leal	-38(%r12), %eax
	cmpl	$8, %eax
	ja	.L663
	leaq	.L668(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L668:
	.long	.L676-.L668
	.long	.L675-.L668
	.long	.L674-.L668
	.long	.L673-.L668
	.long	.L672-.L668
	.long	.L671-.L668
	.long	.L670-.L668
	.long	.L724-.L668
	.long	.L667-.L668
	.text
	.p2align 4,,10
	.p2align 3
.L595:
	testq	%rdx, %rdx
	jne	.L598
	movq	8(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	jne	.L599
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
	movl	16(%r15), %ebp
	testl	%ebp, %ebp
	jne	.L984
	movl	12(%r15), %ebx
	testl	%ebx, %ebx
	jne	.L985
	movl	20(%r15), %eax
	cmpl	$2, %eax
	je	.L986
	testq	%r12, %r12
	je	.L538
	movq	%r12, %rdi
	call	get_mangled_name
	movq	8(%rsp), %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movl	20(%r15), %eax
.L538:
	cmpl	$1, %eax
	jne	.L515
.L536:
	movq	8(%rsp), %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC39(%rip), %rdi
	jmp	.L963
	.p2align 4,,10
	.p2align 3
.L975:
	movq	16(%rsp), %rdi
	call	source_function
	movl	%eax, %edx
	testl	%eax, %eax
	jne	.L600
	cmpq	%r12, 24(%rsp)
	movl	current_byteptr(%rip), %ebx
	sete	%al
	testb	%al, 39(%rsp)
	jne	.L601
	movq	40(%rsp), %rax
	testq	%rax, %rax
	je	.L602
	movl	(%rax,%r12,4), %r9d
	testl	%r9d, %r9d
	jne	.L601
.L602:
	movq	16(%rsp), %rdi
	leaq	.LC82(%rip), %rsi
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	movl	56(%rsp), %edx
	testl	%eax, %eax
	jne	.L605
	testq	%r12, %r12
	je	.L601
.L606:
	movq	16(%rsp), %rdi
	leaq	.LC84(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L607
	cmpq	$1, %r12
	jbe	.L987
.L609:
	movq	16(%rsp), %rdi
	leaq	.LC86(%rip), %rsi
	call	strcmp@PLT
	movl	%eax, 56(%rsp)
	testl	%eax, %eax
	jne	.L612
	cmpq	$2, %r12
	je	.L613
.L608:
	movq	16(%rsp), %rdi
	leaq	.LC88(%rip), %rsi
	call	strcmp@PLT
	testq	%r12, %r12
	movl	%eax, %edx
	sete	%al
	movb	%al, 64(%rsp)
	testl	%edx, %edx
	jne	.L616
	testb	%al, %al
	jne	.L959
.L616:
	movq	16(%rsp), %rdi
	leaq	.LC89(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L620
	cmpq	$1, %r12
	jbe	.L959
.L619:
	leaq	.LC78(%rip), %rcx
	movq	16(%rsp), %rdi
	movq	%rcx, %rsi
	movq	%rcx, 72(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L716
	movb	$0, 64(%rsp)
	leaq	.LC78(%rip), %rcx
.L623:
	movq	16(%rsp), %rdi
	leaq	.LC77(%rip), %rsi
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
	jne	.L622
	movq	16(%rsp), %rdi
	leaq	.LC76(%rip), %rsi
	movq	%rcx, 72(%rsp)
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	movl	56(%rsp), %edx
	movq	72(%rsp), %rcx
	testl	%eax, %eax
	jne	.L744
	cmpb	$0, 64(%rsp)
	je	.L744
.L735:
	movl	%edx, %ebx
.L952:
	testl	%edx, %edx
	jne	.L632
.L631:
	movq	%r13, %rcx
	movl	$32, %edx
	movl	$1, %esi
	leaq	.LC92(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rax
	movq	%rbp, %rdx
	movq	%r13, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC93(%rip), %rdi
	call	fwrite@PLT
	jmp	.L677
	.p2align 4,,10
	.p2align 3
.L653:
	movq	8(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edi
	call	tk_name@PLT
	leaq	.LC103(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	56(%r15), %rsi
	jmp	.L964
	.p2align 4,,10
	.p2align 3
.L984:
	movq	8(%rsp), %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC37(%rip), %rdi
	jmp	.L963
	.p2align 4,,10
	.p2align 3
.L649:
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
	jmp	.L966
	.p2align 4,,10
	.p2align 3
.L979:
	movq	48(%rsi), %r13
	testq	%r13, %r13
	je	.L642
	movl	0(%r13), %eax
	cmpl	$4, %eax
	je	.L643
	cmpl	$5, %eax
	je	.L988
.L642:
	movl	current_word_bits(%rip), %r8d
	testl	%r8d, %r8d
	je	.L644
.L643:
	movq	8(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC96(%rip), %rdi
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
	leaq	.LC97(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	jmp	.L970
	.p2align 4,,10
	.p2align 3
.L540:
	movq	8(%rsp), %rbx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC71(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	40(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L544:
	movq	8(%rsp), %rbx
	movl	$3, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC72(%rip), %rdi
	leaq	.LC33(%rip), %r13
	movq	%rbx, %rcx
	call	fwrite@PLT
	cmpq	$0, 56(%r15)
	je	.L550
.L549:
	movq	48(%r15), %rax
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	emit_expr
	cmpq	56(%r15), %r12
	jnb	.L550
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	jmp	.L549
.L660:
	leaq	.LC54(%rip), %rdx
	.p2align 4
	.p2align 3
.L661:
	movq	8(%rsp), %rbx
	leaq	.LC102(%rip), %rsi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	call	fprintf@PLT
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC33(%rip), %rdi
	call	fwrite@PLT
	movq	56(%r15), %rsi
	jmp	.L964
.L723:
	leaq	.LC55(%rip), %rdx
	jmp	.L661
.L654:
	leaq	.LC56(%rip), %rdx
	jmp	.L661
.L659:
	leaq	.LC51(%rip), %rdx
	jmp	.L661
.L656:
	leaq	.LC57(%rip), %rdx
	jmp	.L661
.L657:
	leaq	.LC53(%rip), %rdx
	jmp	.L661
.L658:
	leaq	.LC52(%rip), %rdx
	jmp	.L661
.L724:
	leaq	.LC60(%rip), %r12
	.p2align 4
	.p2align 3
.L669:
	movq	8(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC96(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC97(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	$3, %edx
	movq	%rbx, %rcx
	movl	$1, %esi
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	jmp	.L965
.L667:
	leaq	.LC59(%rip), %r12
	jmp	.L669
.L676:
	leaq	.LC58(%rip), %r12
	jmp	.L669
.L674:
	leaq	.LC65(%rip), %r12
	jmp	.L669
.L675:
	leaq	.LC66(%rip), %r12
	jmp	.L669
.L670:
	leaq	.LC61(%rip), %r12
	jmp	.L669
.L671:
	leaq	.LC62(%rip), %r12
	jmp	.L669
.L672:
	leaq	.LC63(%rip), %r12
	jmp	.L669
.L673:
	leaq	.LC64(%rip), %r12
	jmp	.L669
	.p2align 4,,10
	.p2align 3
.L976:
	movq	%r13, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L635
	.p2align 4,,10
	.p2align 3
.L636:
	movl	48(%rsp), %ebx
	movq	8(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	jne	.L597
.L638:
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
.L663:
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
	leaq	.LC103(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	jmp	.L965
	.p2align 4,,10
	.p2align 3
.L571:
	testb	%r12b, %r12b
	je	.L595
	leaq	.LC81(%rip), %rsi
	movq	%r14, %rdi
	movq	%rdx, 16(%rsp)
	call	strcmp@PLT
	movq	16(%rsp), %rdx
	testl	%eax, %eax
	jne	.L595
	testq	%rdx, %rdx
	jne	.L598
	movq	8(%rsp), %r14
	movl	$48, %edi
	movq	%r14, %rsi
	call	fputc@PLT
	movq	%r14, %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	je	.L515
.L599:
	movq	$0, 40(%rsp)
	.p2align 4
	.p2align 3
.L597:
	movq	8(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L638
	.p2align 4,,10
	.p2align 3
.L539:
	movq	40(%rax), %r14
	testq	%r14, %r14
	je	.L989
	testl	%ebx, %ebx
	jne	.L540
	movq	%r14, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L548
	movl	g_strict(%rip), %r11d
	testl	%r11d, %r11d
	je	.L546
	leaq	8+names.0(%rip), %r12
	leaq	.LC13(%rip), %rsi
	jmp	.L547
	.p2align 4,,10
	.p2align 3
.L990:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L548
.L547:
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L990
.L546:
	leaq	.LC73(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L702
	.p2align 4
	.p2align 3
.L552:
	leaq	8+names.0(%rip), %r12
	leaq	.LC13(%rip), %rsi
	jmp	.L556
	.p2align 4,,10
	.p2align 3
.L992:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L991
.L556:
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L992
	movq	%r14, %rdi
	movl	g_strict(%rip), %r12d
	call	source_function
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L993
	testl	%r12d, %r12d
	je	.L690
	movb	$0, 39(%rsp)
	movq	%r14, %rsi
	movq	$0, 24(%rsp)
.L684:
	movq	8(%rsp), %rdi
	movq	%rsi, %rdx
	xorl	%eax, %eax
	movl	$1, %r12d
	leaq	.LC25(%rip), %rsi
	call	fprintf@PLT
	movb	$1, 38(%rsp)
	jmp	.L570
.L553:
	movq	8(%rsp), %rbx
	leaq	-1(%r14), %rdx
	xorl	%eax, %eax
	xorl	%r12d, %r12d
	leaq	.LC74(%rip), %rsi
	leaq	.LC33(%rip), %r13
	movq	%rbx, %rdi
	call	fprintf@PLT
.L554:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	48(%r15), %rax
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	emit_expr
	cmpq	%r12, %r14
	jne	.L554
	.p2align 4
	.p2align 3
.L550:
	movq	8(%rsp), %rsi
	jmp	.L969
	.p2align 4,,10
	.p2align 3
.L601:
	testl	%ebx, %ebx
	je	.L603
.L604:
	movq	%r13, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC90(%rip), %rdi
	call	fwrite@PLT
.L634:
	movl	$1, %ebx
	jmp	.L600
	.p2align 4,,10
	.p2align 3
.L982:
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
	leaq	.LC104(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edi
	call	tk_name@PLT
	leaq	.LC103(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	jmp	.L970
.L991:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L994
.L698:
	leaq	.LC75(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	je	.L558
.L741:
	movq	$0, 24(%rsp)
	movb	$0, 39(%rsp)
.L559:
	movb	$1, 38(%rsp)
	movq	%r14, %rsi
	xorl	%r12d, %r12d
	xorl	%ebx, %ebx
	jmp	.L563
	.p2align 4,,10
	.p2align 3
.L981:
	movl	expression_id(%rip), %eax
	movq	8(%rsp), %rbx
	leaq	.LC99(%rip), %rsi
	leal	1(%rax), %r13d
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movl	%r13d, %edx
	movl	%r13d, expression_id(%rip)
	call	fprintf@PLT
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r13d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC100(%rip), %rsi
	call	fprintf@PLT
	movq	56(%r15), %rsi
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
	leaq	.LC101(%rip), %rsi
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
.L985:
	.cfi_restore_state
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L995
	movq	8(%rsp), %rbx
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC70(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	40(%r15), %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	jmp	.L966
.L605:
	movq	16(%rsp), %rdi
	leaq	.LC83(%rip), %rsi
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L606
	testq	%r12, %r12
	jne	.L606
	testl	%ebx, %ebx
	movl	56(%rsp), %edx
	jne	.L604
	.p2align 4
	.p2align 3
.L603:
	movq	16(%rsp), %rdi
	leaq	.LC76(%rip), %rsi
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	testq	%r12, %r12
	movl	56(%rsp), %edx
	jne	.L743
	testl	%eax, %eax
	je	.L954
.L743:
	movl	$1, %ebx
	leaq	.LC78(%rip), %rcx
.L680:
	movq	16(%rsp), %rdi
	movq	%rcx, %rsi
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	movl	56(%rsp), %edx
	testl	%eax, %eax
	jne	.L626
	cmpq	$1, %r12
	je	.L996
.L628:
	testl	%ebx, %ebx
	jne	.L604
.L622:
	xorl	%ebx, %ebx
	testl	%edx, %edx
	je	.L600
.L618:
	movq	%r13, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC91(%rip), %rdi
	call	fwrite@PLT
	jmp	.L634
.L983:
	cmpl	$32, 40(%r13)
	jne	.L664
	jmp	.L665
.L977:
	movq	8(%rsp), %rbx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC95(%rip), %rdi
	movq	%rbx, %rcx
	jmp	.L967
.L989:
	testl	%ebx, %ebx
	jne	.L540
	xorl	%edi, %edi
	leaq	.LC73(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L552
	xorl	%edi, %edi
	call	source_function
	testl	%eax, %eax
	jne	.L552
.L702:
	movq	56(%r15), %r14
	testq	%r14, %r14
	jne	.L553
	movq	8(%rsp), %rdi
	xorl	%edx, %edx
	leaq	.LC74(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L550
.L978:
	movq	8(%rsp), %rbx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC35(%rip), %rdi
	movq	%rbx, %rcx
	jmp	.L967
.L548:
	movq	8(%rsp), %rbx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC71(%rip), %rdi
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
	jmp	.L544
.L980:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC98(%rip), %rdi
	jmp	.L967
.L607:
	movq	16(%rsp), %rdi
	leaq	.LC85(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L609
	cmpq	$1, %r12
	jne	.L609
	movq	16(%rsp), %rdi
	leaq	.LC89(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L950
	testl	%ebx, %ebx
	jne	.L618
	leaq	.LC78(%rip), %rcx
	movq	16(%rsp), %rdi
	movq	%rcx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L734
	xorl	%ebx, %ebx
	movl	$1, %edx
.L626:
	movq	16(%rsp), %rdi
	leaq	.LC77(%rip), %rsi
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	cmpq	$1, %r12
	movl	56(%rsp), %edx
	jne	.L628
	testl	%eax, %eax
	jne	.L628
	testl	%ebx, %ebx
	jne	.L954
	xorl	%ebx, %ebx
	jmp	.L952
.L994:
	movq	%r14, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L741
	leaq	.LC76(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	leaq	.LC75(%rip), %rsi
	movq	%r14, %rdi
	movl	%eax, %ebx
	call	strcmp@PLT
	movl	%eax, %r12d
	testl	%ebx, %ebx
	je	.L561
	leaq	.LC77(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	je	.L561
	xorl	%ebx, %ebx
.L697:
	leaq	.LC78(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L561
	testl	%r12d, %r12d
	je	.L997
	leaq	.LC110(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L738
	leaq	.LC111(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L738
	leaq	.LC109(%rip), %rsi
	movq	%r14, %rdi
	xorl	%r12d, %r12d
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L687
.L738:
	movb	$1, 39(%rsp)
	movq	$1, 24(%rsp)
.L569:
	testl	%ebx, %ebx
	je	.L559
	movq	%r14, %rsi
	xorl	%ebx, %ebx
	jmp	.L684
	.p2align 4,,10
	.p2align 3
.L558:
	movq	%r14, %rdi
	xorl	%r12d, %r12d
	call	source_function
	movb	$1, 38(%rsp)
	movq	%r14, %rsi
	movq	$0, 24(%rsp)
	xorl	$1, %eax
	andl	$1, %eax
	movb	%al, 39(%rsp)
	jmp	.L563
.L974:
	movq	%rdx, %rdi
	movl	$4, %esi
	movq	%rdx, 16(%rsp)
	movq	40(%rax), %r12
	call	calloc@PLT
	movq	16(%rsp), %rdx
	testq	%rax, %rax
	movq	%rax, 40(%rsp)
	je	.L598
	movq	24(%rsp), %rax
	xorl	%r13d, %r13d
	leaq	1(%rax), %rsi
	movzbl	(%r12), %eax
	testb	%al, %al
	je	.L574
	movq	%r14, 48(%rsp)
	movl	%ebx, 16(%rsp)
	movq	%rsi, %rbx
	movq	%rbp, 56(%rsp)
	movq	%r12, %rbp
	movq	%rdx, %r12
	.p2align 4
	.p2align 3
.L573:
	cmpb	$37, %al
	jne	.L946
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	cmpb	$37, %r14b
	je	.L946
	testb	%r14b, %r14b
	jne	.L576
	jmp	.L944
	.p2align 4,,10
	.p2align 3
.L579:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	testb	%r14b, %r14b
	je	.L578
.L576:
	movsbl	%r14b, %esi
	leaq	.LC80(%rip), %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L579
	cmpb	$42, %r14b
	jne	.L578
	cmpq	%r12, %rbx
	adcq	$0, %rbx
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %edx
.L583:
	cmpb	$46, %dl
	je	.L998
.L585:
	cmpb	$104, %dl
	je	.L999
	cmpb	$108, %dl
	je	.L1000
	testb	%dl, %dl
	je	.L944
	leaq	1(%r13), %rax
	cmpq	%r12, %rbx
	jnb	.L591
	cmpb	$115, %dl
	jne	.L591
	movq	40(%rsp), %rcx
	movl	$1, (%rcx,%rbx,4)
	.p2align 4
	.p2align 3
.L591:
	addq	$1, %rbx
.L575:
	movq	%rax, %r13
	movzbl	0(%rbp,%rax), %eax
	testb	%al, %al
	jne	.L573
.L944:
	movl	16(%rsp), %ebx
	movq	48(%rsp), %r14
	movq	%r12, %rdx
	movq	56(%rsp), %rbp
	jmp	.L574
	.p2align 4,,10
	.p2align 3
.L946:
	leaq	1(%r13), %rax
	jmp	.L575
.L578:
	movzbl	0(%rbp,%r13), %edx
	testb	%dl, %dl
	movb	%dl, 64(%rsp)
	je	.L944
	call	__ctype_b_loc@PLT
	movzbl	64(%rsp), %edx
	movq	(%rax), %rax
	jmp	.L581
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L584:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %edx
	testb	%dl, %dl
	je	.L944
.L581:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L584
	movzbl	0(%rbp,%r13), %edx
	jmp	.L583
.L999:
	cmpb	$104, 1(%rbp,%r13)
	leaq	1(%r13), %rax
	jne	.L591
.L710:
	leaq	2(%r13), %rax
	jmp	.L591
.L998:
	movzbl	1(%rbp,%r13), %edx
	leaq	1(%r13), %rdi
	movq	%rdi, 64(%rsp)
	cmpb	$42, %dl
	jne	.L1001
	cmpq	%r12, %rbx
	adcq	$0, %rbx
	addq	$2, %r13
	movzbl	0(%rbp,%r13), %edx
	jmp	.L585
.L1000:
	cmpb	$108, 1(%rbp,%r13)
	leaq	1(%r13), %rax
	jne	.L591
	jmp	.L710
.L986:
	movq	%r12, %rdi
	call	get_mangled_name
	leaq	.LC38(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L962
.L995:
	testq	%r12, %r12
	je	.L536
	movq	%r12, %rdi
	call	get_mangled_name
	movq	8(%rsp), %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	jmp	.L536
.L644:
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
	jmp	.L965
.L993:
	testl	%r12d, %r12d
	jne	.L698
	jmp	.L741
.L988:
	cmpl	$32, 40(%r13)
	jne	.L642
	jmp	.L643
.L1001:
	testb	%dl, %dl
	movb	%dl, 72(%rsp)
	je	.L944
	call	__ctype_b_loc@PLT
	movzbl	72(%rsp), %edx
	movq	64(%rsp), %rdi
	movq	(%rax), %rax
	jmp	.L587
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L589:
	addq	$1, %rdi
	movzbl	0(%rbp,%rdi), %edx
	testb	%dl, %dl
	je	.L944
.L587:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L589
	movzbl	0(%rbp,%rdi), %edx
	movq	%rdi, %r13
	jmp	.L585
.L1003:
	leaq	.LC109(%rip), %rsi
	movq	%r14, %rdi
	movl	$1, %r12d
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L737
.L687:
	leaq	.LC108(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L727
	movb	$1, 39(%rsp)
	movq	$2, 24(%rsp)
.L685:
	testl	%r12d, %r12d
	je	.L569
.L686:
	movq	8(%rsp), %rcx
	movl	$1, %esi
	movl	$6, %edx
	leaq	.LC79(%rip), %rdi
	call	fwrite@PLT
	movq	40(%r15), %rax
	movq	40(%rax), %rsi
	testl	%ebx, %ebx
	je	.L706
	cmpl	$2, (%rax)
	je	.L684
	movb	$1, 38(%rsp)
	movl	$1, %r12d
	jmp	.L563
.L561:
	testl	%r12d, %r12d
	je	.L1002
.L930:
	leaq	.LC110(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L737
	leaq	.LC111(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1003
.L737:
	movb	$1, 39(%rsp)
	movq	$1, 24(%rsp)
	jmp	.L686
.L950:
	movb	$0, 64(%rsp)
	movl	$1, 56(%rsp)
.L620:
	leaq	.LC78(%rip), %rcx
	movq	16(%rsp), %rdi
	movq	%rcx, %rsi
	movq	%rcx, 72(%rsp)
	call	strcmp@PLT
	leaq	.LC78(%rip), %rcx
	testl	%eax, %eax
	jne	.L623
	movzbl	64(%rsp), %edx
	movl	56(%rsp), %eax
	orl	%eax, %edx
	testl	%ebx, %ebx
	jne	.L622
	movq	16(%rsp), %rdi
	leaq	.LC76(%rip), %rsi
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	movl	56(%rsp), %edx
	testl	%eax, %eax
	jne	.L693
	cmpb	$0, 64(%rsp)
	movl	%edx, %ebx
	jne	.L952
.L693:
	cmpq	$1, %r12
	jne	.L622
	jmp	.L735
	.p2align 4,,10
	.p2align 3
.L612:
	movq	16(%rsp), %rdi
	leaq	.LC87(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L742
	cmpq	$2, %r12
	je	.L613
.L742:
	movl	$0, 56(%rsp)
	jmp	.L608
.L996:
	testl	%ebx, %ebx
	je	.L735
.L954:
	movq	%r13, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC90(%rip), %rdi
	call	fwrite@PLT
.L630:
	movl	$1, %ebx
	jmp	.L631
.L959:
	testl	%ebx, %ebx
	jne	.L618
	movq	16(%rsp), %rdi
	leaq	.LC76(%rip), %rsi
	call	strcmp@PLT
	testb	$1, %r12b
	jne	.L745
	testl	%eax, %eax
	je	.L632
.L745:
	xorl	%ebx, %ebx
	movl	$1, %edx
	leaq	.LC78(%rip), %rcx
	jmp	.L680
.L1002:
	movq	8(%rsp), %rcx
	movl	$1, %esi
	movl	$6, %edx
	leaq	.LC79(%rip), %rdi
	xorl	%r12d, %r12d
	movl	$1, %ebx
	call	fwrite@PLT
	movq	40(%r15), %rax
	movb	$1, 38(%rsp)
	movb	$1, 39(%rsp)
	movq	$0, 24(%rsp)
	movq	40(%rax), %rsi
	jmp	.L563
.L727:
	movb	$0, 39(%rsp)
	movq	$0, 24(%rsp)
	jmp	.L685
.L690:
	leaq	.LC76(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L739
	leaq	.LC77(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L739
	leaq	.LC75(%rip), %rsi
	movq	%r14, %rdi
	movl	$1, %ebx
	call	strcmp@PLT
	orl	$1, %eax
	movl	%eax, %r12d
	jmp	.L697
.L632:
	movq	%r13, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC91(%rip), %rdi
	call	fwrite@PLT
	jmp	.L630
.L613:
	movq	16(%rsp), %rdi
	leaq	.LC89(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L950
	movl	$1, 56(%rsp)
	jmp	.L619
.L716:
	movl	56(%rsp), %edx
	jmp	.L622
.L987:
	movl	$1, 56(%rsp)
	jmp	.L608
.L739:
	movl	$1, %ebx
	jmp	.L930
.L734:
	movl	$1, %edx
	jmp	.L735
.L997:
	xorl	%r10d, %r10d
	movb	$1, 38(%rsp)
	movq	%r14, %rsi
	xorl	%ebx, %ebx
	movb	$1, 39(%rsp)
	xorl	%r12d, %r12d
	movq	%r10, 24(%rsp)
	jmp	.L563
.L706:
	movb	$1, 38(%rsp)
	xorl	%r12d, %r12d
	movl	$1, %ebx
	jmp	.L563
.L744:
	xorl	%ebx, %ebx
	jmp	.L680
	.cfi_endproc
.LFE49:
	.size	emit_expr, .-emit_expr
	.section	.rodata.str1.1
.LC112:
	.string	"word __%s_store[("
.LC113:
	.string	")];\n"
.LC114:
	.string	"word %s = 0;\n"
	.section	.rodata.str1.8
	.align 8
.LC115:
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
	je	.L1005
	testl	%r13d, %r13d
	jle	.L1006
	xorl	%r12d, %r12d
	leaq	.LC40(%rip), %r14
	.p2align 4
	.p2align 3
.L1007:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r13d
	jne	.L1007
.L1006:
	movq	%r15, %rdx
	leaq	.LC112(%rip), %rsi
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
	leaq	.LC113(%rip), %rdi
	call	fwrite@PLT
.L1005:
	testl	%r13d, %r13d
	jle	.L1008
	xorl	%ebx, %ebx
	leaq	.LC40(%rip), %r14
	.p2align 4
	.p2align 3
.L1009:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %r12d
	leal	1(%rbx), %ebx
	cmpl	%ebx, %r13d
	jne	.L1009
	xorl	%eax, %eax
	movq	%r15, %rdx
	leaq	.LC114(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L1020
.L1004:
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
.L1020:
	.cfi_restore_state
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1014:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %r12d
	jne	.L1014
.L1011:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r15, %rcx
	movq	%r15, %rdx
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC115(%rip), %rsi
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
.L1008:
	.cfi_restore_state
	xorl	%eax, %eax
	movq	%r15, %rdx
	leaq	.LC114(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L1004
	jmp	.L1011
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
	je	.L1023
	jmp	emit_expr
	.p2align 4,,10
	.p2align 3
.L1023:
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
	je	.L1024
	cmpl	$1, (%rdi)
	je	.L1028
.L1024:
	ret
	.p2align 4,,10
	.p2align 3
.L1028:
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
	je	.L1061
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
	je	.L1031
	ja	.L1032
	testl	%eax, %eax
	je	.L1033
	cmpl	$5, %eax
	jne	.L1041
	movq	48(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1029
	movl	40(%rbx), %eax
	cmpl	$31, %eax
	je	.L1037
	cmpl	$35, %eax
	je	.L1038
	.p2align 4
	.p2align 3
.L1041:
	xorl	%eax, %eax
.L1029:
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
.L1032:
	.cfi_restore_state
	cmpl	$10, %eax
	jne	.L1041
	movq	40(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1029
	movq	48(%rbx), %rdi
	movq	%rbp, %rsi
	call	try_eval_const_expr
	jmp	.L1029
	.p2align 4,,10
	.p2align 3
.L1061:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L1033:
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	movq	40(%rdi), %rax
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
.L1031:
	.cfi_restore_state
	movq	48(%rdi), %rdi
	movq	%rsp, %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1041
	movq	56(%rbx), %rdi
	leaq	8(%rsp), %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1041
	movl	40(%rbx), %eax
	subl	$22, %eax
	cmpl	$33, %eax
	ja	.L1041
	leaq	.L1044(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1044:
	.long	.L1057-.L1044
	.long	.L1056-.L1044
	.long	.L1055-.L1044
	.long	.L1054-.L1044
	.long	.L1053-.L1044
	.long	.L1052-.L1044
	.long	.L1041-.L1044
	.long	.L1041-.L1044
	.long	.L1051-.L1044
	.long	.L1050-.L1044
	.long	.L1049-.L1044
	.long	.L1048-.L1044
	.long	.L1047-.L1044
	.long	.L1041-.L1044
	.long	.L1041-.L1044
	.long	.L1041-.L1044
	.long	.L1041-.L1044
	.long	.L1041-.L1044
	.long	.L1041-.L1044
	.long	.L1041-.L1044
	.long	.L1041-.L1044
	.long	.L1041-.L1044
	.long	.L1041-.L1044
	.long	.L1041-.L1044
	.long	.L1041-.L1044
	.long	.L1041-.L1044
	.long	.L1041-.L1044
	.long	.L1041-.L1044
	.long	.L1041-.L1044
	.long	.L1041-.L1044
	.long	.L1041-.L1044
	.long	.L1046-.L1044
	.long	.L1045-.L1044
	.long	.L1043-.L1044
	.text
	.p2align 4,,10
	.p2align 3
.L1038:
	xorl	%eax, %eax
	cmpq	$0, 8(%rsp)
	sete	%al
	movq	%rax, 0(%rbp)
.L1059:
	movl	$1, %eax
	jmp	.L1029
.L1043:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1059
.L1045:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1059
.L1046:
	movq	(%rsp), %rax
	andq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1059
.L1047:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L1041
	movq	(%rsp), %rax
	cqto
	idivq	%rcx
	movq	%rdx, 0(%rbp)
	jmp	.L1059
.L1048:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L1041
	movq	(%rsp), %rax
	cqto
	idivq	%rcx
	movq	%rax, 0(%rbp)
	jmp	.L1059
.L1049:
	movq	(%rsp), %rax
	imulq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1059
.L1050:
	movq	(%rsp), %rax
	subq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1059
.L1051:
	movq	8(%rsp), %rax
	addq	(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1059
.L1052:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setge	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1059
.L1053:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setg	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1059
.L1054:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setle	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1059
.L1055:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setl	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1059
.L1056:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1059
.L1057:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	sete	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1059
	.p2align 4,,10
	.p2align 3
.L1037:
	movq	8(%rsp), %rax
	negq	%rax
	movq	%rax, 0(%rbp)
	jmp	.L1059
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
	je	.L1083
	cmpl	$1, (%rdi)
	je	.L1087
.L1083:
	ret
	.p2align 4,,10
	.p2align 3
.L1087:
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
	je	.L1088
	cmpl	$1, (%rdi)
	je	.L1093
.L1088:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L1093:
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
	je	.L1106
	cmpl	$1, (%rdi)
	jne	.L1106
	movq	24(%rdi), %rcx
	movq	16(%rdi), %r8
	testq	%rcx, %rcx
	je	.L1106
	xorl	%edx, %edx
	jmp	.L1107
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1109:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L1106
.L1107:
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L1109
	cmpl	$1, (%rax)
	jne	.L1109
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
.L1110:
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r9
.L1096:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L1113
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L1096
	cmpl	$1, (%rax)
	jne	.L1096
	jmp	.L1110
	.p2align 4,,10
	.p2align 3
.L1106:
	.cfi_def_cfa_offset 8
	movq	%r9, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1113:
	.cfi_def_cfa_offset 16
	movq	%r9, %rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE55:
	.size	edge_tail_words_top, .-edge_tail_words_top
	.section	.rodata.str1.1
.LC116:
	.string	"%s[%zu] = "
.LC117:
	.string	";\n"
.LC118:
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
	je	.L1115
	cmpl	$1, (%rcx)
	movq	%rcx, %r15
	jne	.L1115
	cmpq	$0, 24(%rcx)
	je	.L1115
	movq	%rsi, (%rsp)
	movq	%rdi, %rbx
	movl	%r9d, %ebp
	xorl	%r13d, %r13d
	movq	%r8, 8(%rsp)
.L1128:
	movq	16(%r15), %rax
	movq	(%rax,%r13,8), %r10
	testq	%r10, %r10
	je	.L1123
	movl	(%r10), %eax
	testl	%eax, %eax
	je	.L1147
	cmpl	$1, %eax
	je	.L1148
.L1123:
	addq	$1, %r13
	addq	$1, %r12
	cmpq	24(%r15), %r13
	jb	.L1128
	movq	8(%rsp), %rdx
.L1115:
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
.L1147:
	.cfi_restore_state
	xorl	%r14d, %r14d
	testl	%ebp, %ebp
	jle	.L1121
	movq	%r12, 16(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L1118:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC40(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1118
	movq	16(%rsp), %r12
	movq	%r14, %r10
.L1121:
	movq	(%rsp), %rdx
	leaq	.LC116(%rip), %rsi
	xorl	%eax, %eax
	movq	%r12, %rcx
	movq	%rbx, %rdi
	movq	%r10, 16(%rsp)
	call	fprintf@PLT
	movq	16(%rsp), %r10
	movq	16(%r10), %rsi
	cmpl	$2, (%rsi)
	je	.L1149
	movq	96(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L1122:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1123
	.p2align 4,,10
	.p2align 3
.L1148:
	movq	24(%r10), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmovne	%rax, %rdx
	xorl	%r14d, %r14d
	movq	%rdx, 16(%rsp)
	testl	%ebp, %ebp
	jle	.L1127
	movq	%r12, 24(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L1124:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC40(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1124
	movq	24(%rsp), %r12
	movq	%r14, %r10
.L1127:
	movq	8(%rsp), %r14
	movq	(%rsp), %r8
	movq	%r12, %rcx
	movq	%rbx, %rdi
	leaq	.LC118(%rip), %rsi
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
	jne	.L1125
	movq	24(%r10), %rsi
	movq	16(%r10), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, 8(%rsp)
.L1125:
	movq	8(%rsp), %rax
	cmpq	%rdx, %rax
	cmovnb	%rax, %rdx
	movq	%rdx, 8(%rsp)
	jmp	.L1123
	.p2align 4,,10
	.p2align 3
.L1149:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1122
	.cfi_endproc
.LFE56:
	.size	emit_edge_list_init, .-emit_edge_list_init
	.section	.rodata.str1.8
	.align 8
.LC119:
	.string	"static void __attribute__((constructor(101))) __b_register_globals(void) {\n"
	.align 8
.LC120:
	.string	"    (void)B_PTR_N(%s, sizeof(%s));\n"
	.align 8
.LC121:
	.string	"    (void)B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC122:
	.string	"}\n"
	.section	.rodata.str1.8
	.align 8
.LC123:
	.string	"static void __attribute__((constructor(102))) __bcc_bind_functions(void) {\n"
	.section	.rodata.str1.1
.LC124:
	.string	"    "
.LC125:
	.string	" = B_FUNCTION("
	.section	.rodata.str1.8
	.align 8
.LC126:
	.string	"static void __b_initialize_globals(void) {\n"
	.align 8
.LC127:
	.string	"    %s[0] = B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC128:
	.string	"__%s_store"
.LC129:
	.string	"    %s[0] = "
	.section	.rodata.str1.8
	.align 8
.LC130:
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
	leaq	.LC122(%rip), %rax
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
	je	.L1195
.L1151:
	movq	%rbx, %rcx
	movl	$75, %edx
	movl	$1, %esi
	leaq	.LC123(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%r15)
	je	.L1158
	xorl	%ebp, %ebp
	leaq	.LC124(%rip), %r14
	leaq	.LC39(%rip), %r13
	jmp	.L1161
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1159:
	addq	$1, %rbp
	cmpq	8(%r15), %rbp
	jnb	.L1158
.L1161:
	movq	(%r15), %rax
	movq	(%rax,%rbp,8), %r12
	cmpl	$1, (%r12)
	jne	.L1159
	movq	%r14, %rdi
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r12), %rax
	movq	(%rax), %rdi
	testq	%rdi, %rdi
	je	.L1160
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1160:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	addq	$1, %rbp
	movl	$14, %edx
	movl	$1, %esi
	leaq	.LC125(%rip), %rdi
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
	jb	.L1161
.L1158:
	movq	(%rsp), %rdi
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC126(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%r15)
	je	.L1162
	xorl	%ebp, %ebp
	jmp	.L1173
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1164:
	addq	$1, %rbp
	cmpq	8(%r15), %rbp
	jnb	.L1162
.L1173:
	movq	(%r15), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$2, (%rax)
	jne	.L1164
	movq	8(%rax), %r12
	movq	16(%r12), %rdi
	call	get_mangled_name
	cmpl	$2, 24(%r12)
	movq	56(%r12), %r13
	movq	%rax, %r14
	je	.L1196
	testq	%r13, %r13
	je	.L1164
	movl	0(%r13), %eax
	cmpl	$1, %eax
	je	.L1197
	testl	%eax, %eax
	jne	.L1164
	leaq	.LC129(%rip), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	fprintf@PLT
	movq	16(%r13), %rsi
	cmpl	$2, (%rsi)
	je	.L1198
	movq	8(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L1172:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addq	$1, %rbp
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r15), %rbp
	jb	.L1173
.L1162:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$207, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC130(%rip), %rdi
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
.L1196:
	.cfi_restore_state
	movq	%rax, %r8
	movq	%rax, %rcx
	movq	%rax, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC127(%rip), %rsi
	call	fprintf@PLT
	testq	%r13, %r13
	je	.L1164
	cmpl	$1, 0(%r13)
	jne	.L1164
	movq	%r14, %rsi
	leaq	.LC128(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	xorl	%r8d, %r8d
	movq	%rax, %rsi
	movq	56(%r12), %rax
	testq	%rax, %rax
	je	.L1167
	cmpl	$1, (%rax)
	je	.L1199
.L1167:
	cmpq	$0, 32(%r12)
	je	.L1168
	movq	48(%r12), %rax
	movq	%r8, %rdx
	cmpq	%rax, %r8
	cmovb	%rax, %r8
	testq	%rax, %rax
	cmovle	%rdx, %r8
.L1168:
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
	jmp	.L1164
	.p2align 4,,10
	.p2align 3
.L1197:
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
	jmp	.L1164
	.p2align 4,,10
	.p2align 3
.L1195:
	movq	%rdi, %rcx
	movl	$75, %edx
	movl	$1, %esi
	leaq	.LC119(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%r15)
	je	.L1152
	xorl	%ebp, %ebp
	leaq	.LC120(%rip), %r12
	jmp	.L1157
	.p2align 4,,10
	.p2align 3
.L1154:
	addq	$1, %rbp
	cmpq	8(%r15), %rbp
	jnb	.L1152
.L1157:
	movq	(%r15), %rax
	movq	(%rax,%rbp,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L1200
	cmpl	$2, %eax
	jne	.L1154
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
	jne	.L1154
	movq	%r13, %rcx
	movq	%r13, %rdx
	leaq	.LC121(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	addq	$1, %rbp
	call	fprintf@PLT
	cmpq	8(%r15), %rbp
	jb	.L1157
	.p2align 4
	.p2align 3
.L1152:
	leaq	.LC122(%rip), %rax
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, (%rsp)
	call	fwrite@PLT
	jmp	.L1151
	.p2align 4,,10
	.p2align 3
.L1200:
	movq	8(%rdx), %rax
	movq	(%rax), %rdi
	call	get_mangled_name
	movq	%r12, %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1154
.L1198:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1172
.L1199:
	movq	24(%rax), %r8
	jmp	.L1167
	.cfi_endproc
.LFE65:
	.size	emit_global_initializers, .-emit_global_initializers
	.section	.rodata.str1.1
.LC131:
	.string	"<"
.LC132:
	.string	"<="
.LC133:
	.string	">"
.LC134:
	.string	">="
.LC135:
	.string	"??"
.LC136:
	.string	"while ("
.LC137:
	.string	")\n"
.LC138:
	.string	"if ("
.LC139:
	.string	"switch ("
.LC140:
	.string	") {\n"
.LC141:
	.string	"continue;\n"
.LC142:
	.string	"break;\n"
.LC143:
	.string	"return"
.LC144:
	.string	"{\n"
.LC145:
	.string	"return "
	.section	.rodata.str1.8
	.align 8
.LC146:
	.string	"%s = B_LOCAL_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC147:
	.string	"else\n"
.LC148:
	.string	" 0"
	.section	.rodata.str1.8
	.align 8
.LC149:
	.string	"case %zu: goto __b_label_%zu;\n"
	.align 8
.LC150:
	.string	"default: fputs(\"bcc: invalid label value\\n\", stderr); abort();\n"
	.section	.rodata.str1.1
.LC151:
	.string	"__bsw%d_case%zu"
.LC152:
	.string	"for(;;) {\n"
.LC153:
	.string	"word __sw = "
.LC154:
	.string	"__bsw%d_end"
.LC155:
	.string	"goto __bsw%d_dispatch;\n"
.LC156:
	.string	"goto __bsw%d_end;\n"
.LC157:
	.string	"__sw %s (word)%ld"
	.section	.rodata.str1.8
	.align 8
.LC158:
	.string	"(__sw >= (word)%ld && __sw <= (word)%ld)"
	.section	.rodata.str1.1
.LC159:
	.string	"__sw == (word)%ld"
.LC160:
	.string	") goto "
.LC161:
	.string	"__bsw%d_end:\n"
.LC162:
	.string	"__b_label_%d:\n"
.LC163:
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
.L1202:
	movl	g_no_line(%rip), %r10d
	testl	%r10d, %r10d
	jne	.L1203
	cmpb	$0, 24(%rsp)
	jne	.L1487
.L1203:
	cmpl	$12, (%rbx)
	ja	.L1201
	movl	(%rbx), %eax
	leaq	.L1206(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1206:
	.long	.L1217-.L1206
	.long	.L1216-.L1206
	.long	.L1215-.L1206
	.long	.L1214-.L1206
	.long	.L1213-.L1206
	.long	.L1212-.L1206
	.long	.L1211-.L1206
	.long	.L1201-.L1206
	.long	.L1210-.L1206
	.long	.L1209-.L1206
	.long	.L1208-.L1206
	.long	.L1207-.L1206
	.long	.L1205-.L1206
	.text
	.p2align 4,,10
	.p2align 3
.L1487:
	movl	4(%rbx), %edx
	movq	16(%rsp), %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC41(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1203
	.p2align 4,,10
	.p2align 3
.L1205:
	movl	g_switch_id(%rip), %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	leaq	.LC151(%rip), %r12
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
	je	.L1287
	movq	%rbx, 56(%rsp)
	movq	24(%rsp), %r13
	movq	%r14, 48(%rsp)
	movq	%rbp, %r14
	movq	40(%rsp), %rbp
	.p2align 4
	.p2align 3
.L1284:
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
	jb	.L1284
	movq	48(%rsp), %r14
	movq	56(%rsp), %rbx
.L1287:
	movl	8(%rsp), %edx
	movl	8(%rsp), %r12d
	xorl	%ebp, %ebp
	leaq	.LC40(%rip), %r13
	testl	%edx, %edx
	jle	.L1488
	.p2align 4
	.p2align 3
.L1285:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1285
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC152(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r12d
.L1288:
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 48(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1291:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1291
	movq	48(%rsp), %rbx
	movq	%r14, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC153(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	leaq	.LC117(%rip), %rax
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ecx
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC154(%rip), %rdx
	movl	$64, %esi
	call	snprintf@PLT
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 56(%rsp)
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
	movl	32(%rsp), %edx
	leaq	.LC155(%rip), %rsi
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
	leaq	.LC156(%rip), %rax
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
	movl	32(%rsp), %edx
	xorl	%eax, %eax
	leaq	.LC163(%rip), %rsi
	movq	%r14, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r15)
	leal	2(%rax), %ebx
	je	.L1296
.L1333:
	leaq	.LC138(%rip), %rax
	movq	%r15, 16(%rsp)
	xorl	%edi, %edi
	leaq	.LC40(%rip), %rbp
	movq	%rax, 56(%rsp)
	movl	%r12d, 76(%rsp)
	movq	%rdi, %r12
	.p2align 4
	.p2align 3
.L1310:
	movq	16(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r12,8), %r13
	movq	40(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1359
	xorl	%eax, %eax
	jmp	.L1301
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1300:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1359
.L1301:
	movq	(%rsi,%rax,8), %rdx
	cmpq	(%rdx), %r13
	jne	.L1300
	movq	8(%rdx), %rax
	movq	%rax, 24(%rsp)
.L1299:
	xorl	%r15d, %r15d
	testl	%ebx, %ebx
	jle	.L1305
	.p2align 4
	.p2align 3
.L1302:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebx, %r15d
	jne	.L1302
.L1305:
	movq	56(%rsp), %rdi
	movl	$1, %esi
	movq	%r14, %rcx
	movl	$4, %edx
	call	fwrite@PLT
	movl	20(%r13), %eax
	movq	24(%r13), %rsi
	testl	%eax, %eax
	je	.L1489
	leaq	.LC133(%rip), %rdx
	cmpl	$26, %eax
	je	.L1306
	ja	.L1307
	leaq	.LC131(%rip), %rdx
	cmpl	$24, %eax
	je	.L1306
	cmpl	$25, %eax
	leaq	.LC135(%rip), %rdx
	leaq	.LC132(%rip), %rax
	cmove	%rax, %rdx
.L1306:
	movq	%rsi, %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC157(%rip), %rsi
	call	fprintf@PLT
.L1308:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC160(%rip), %rdi
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
	jb	.L1310
	movl	76(%rsp), %r12d
	leaq	.LC40(%rip), %r13
	testl	%ebx, %ebx
	jle	.L1490
.L1296:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1312:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1312
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	testl	%r12d, %r12d
	jle	.L1463
	movl	8(%rsp), %r12d
	.p2align 4
	.p2align 3
.L1313:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jg	.L1313
.L1463:
	movl	32(%rsp), %edx
	leaq	.LC161(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	.p2align 4
	.p2align 3
.L1317:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1317
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	xorl	%ebx, %ebx
	leaq	.LC142(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	jle	.L1319
	.p2align 4
	.p2align 3
.L1320:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1320
.L1319:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	call	fwrite@PLT
.L1201:
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
.L1217:
	.cfi_restore_state
	movl	%r12d, %ebp
	xorl	%ebx, %ebx
	leaq	.LC40(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1486
	.p2align 4
	.p2align 3
.L1241:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1241
.L1486:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
.L1485:
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
.L1216:
	.cfi_restore_state
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%r12d, %r12d
	movl	8(%rsp), %r15d
	leaq	.LC40(%rip), %r13
	testl	%eax, %eax
	jle	.L1491
	.p2align 4
	.p2align 3
.L1239:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1239
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC144(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L1245
.L1244:
	movl	8(%rsp), %edi
	xorl	%r13d, %r13d
	addl	$1, %edi
	movl	%edi, 40(%rsp)
.L1252:
	movq	16(%rbx), %rdx
	movq	(%rdx,%r13,8), %r12
	testl	%ebp, %ebp
	je	.L1348
	subq	$1, %rax
	xorl	%ecx, %ecx
	cmpq	%r13, %rax
	je	.L1492
.L1247:
	movq	16(%rsp), %r8
	movl	40(%rsp), %edx
	movq	%r12, %rsi
	movq	%r14, %rdi
	call	emit_stmt
.L1250:
	movq	24(%rbx), %rax
	addq	$1, %r13
	cmpq	%rax, %r13
	jb	.L1252
	movl	8(%rsp), %r9d
	leaq	.LC40(%rip), %r13
	testl	%r9d, %r9d
	jle	.L1254
.L1245:
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1255:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1255
.L1254:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	jmp	.L1485
	.p2align 4,,10
	.p2align 3
.L1215:
	xorl	%r13d, %r13d
	cmpq	$0, 24(%rbx)
	movl	%r12d, 8(%rsp)
	leaq	.LC40(%rip), %rbp
	movl	8(%rsp), %r12d
	je	.L1201
	.p2align 4
	.p2align 3
.L1238:
	movq	16(%rbx), %rax
	movq	(%rax,%r13,8), %r15
	movq	(%r15), %rdi
	call	get_mangled_name
	movl	g_strict(%rip), %esi
	movq	%rax, 8(%rsp)
	testl	%esi, %esi
	je	.L1493
	cmpq	$0, 8(%r15)
	je	.L1330
.L1329:
	xorl	%r15d, %r15d
	testl	%r12d, %r12d
	jle	.L1260
	.p2align 4
	.p2align 3
.L1258:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1258
.L1260:
	movq	8(%rsp), %rcx
	leaq	.LC146(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	movq	%rcx, %r8
	movq	%rcx, %rdx
	call	fprintf@PLT
.L1259:
	addq	$1, %r13
	cmpq	24(%rbx), %r13
	jb	.L1238
	jmp	.L1201
	.p2align 4,,10
	.p2align 3
.L1214:
	xorl	%r15d, %r15d
	leaq	.LC40(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1264
	.p2align 4
	.p2align 3
.L1224:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1224
.L1264:
	movq	%r14, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC138(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC137(%rip), %rdi
	call	fwrite@PLT
	testl	%ebp, %ebp
	jne	.L1225
.L1226:
	movq	24(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L1265
	cmpl	$1, (%rsi)
	movl	%r12d, %edx
	je	.L1266
.L1265:
	leal	1(%r12), %edx
.L1266:
	movq	16(%rsp), %r8
	movl	%ebp, %ecx
	movq	%r14, %rdi
	call	emit_stmt
	cmpq	$0, 32(%rbx)
	je	.L1201
	xorl	%ebp, %ebp
	leaq	.LC40(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1270
	.p2align 4
	.p2align 3
.L1267:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1267
.L1270:
	movq	%r14, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC147(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L1222
	jmp	.L1223
	.p2align 4,,10
	.p2align 3
.L1213:
	xorl	%ebp, %ebp
	leaq	.LC40(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1272
	.p2align 4
	.p2align 3
.L1221:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1221
.L1272:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC136(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC137(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L1223
.L1222:
	cmpl	$1, (%rbx)
	je	.L1271
.L1223:
	addl	$1, %r12d
.L1271:
	xorl	%ebp, %ebp
	jmp	.L1202
	.p2align 4,,10
	.p2align 3
.L1212:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	movl	8(%rsp), %r12d
	leaq	.LC40(%rip), %r13
	testl	%eax, %eax
	jle	.L1273
	.p2align 4
	.p2align 3
.L1235:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1235
.L1273:
	movq	%r14, %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC143(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%rbx)
	je	.L1494
	movq	%r14, %rsi
	movl	$32, %edi
	call	fputc@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	jmp	.L1486
	.p2align 4,,10
	.p2align 3
.L1210:
	movl	%r12d, 8(%rsp)
	xorl	%ebx, %ebx
	movl	8(%rsp), %ebp
	leaq	.LC40(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1275
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
.L1275:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC142(%rip), %rdi
	jmp	.L1485
	.p2align 4,,10
	.p2align 3
.L1211:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%r12d, %r12d
	movl	8(%rsp), %r15d
	leaq	.LC40(%rip), %r13
	testl	%eax, %eax
	jle	.L1274
	.p2align 4
	.p2align 3
.L1232:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1232
.L1274:
	testl	%ebp, %ebp
	jne	.L1495
.L1234:
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	jmp	.L1486
	.p2align 4,,10
	.p2align 3
.L1208:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	movl	8(%rsp), %r12d
	leaq	.LC40(%rip), %r13
	testl	%eax, %eax
	jle	.L1277
	.p2align 4
	.p2align 3
.L1227:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1227
.L1277:
	movq	%r14, %rcx
	movl	$8, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC139(%rip), %rdi
	leaq	.LC149(%rip), %r13
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	%r14, %rdi
	movq	16(%rsp), %rdx
	leaq	.LC40(%rip), %rbp
	call	emit_expr
	movq	%r14, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC140(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	movl	8(%rsp), %r15d
	je	.L1229
	.p2align 4
	.p2align 3
.L1228:
	xorl	%ebx, %ebx
	testl	%r15d, %r15d
	js	.L1279
	.p2align 4
	.p2align 3
.L1278:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r15d
	jge	.L1278
.L1279:
	addq	$1, %r12
	xorl	%eax, %eax
	movq	%r13, %rsi
	movq	%r14, %rdi
	movq	%r12, %rcx
	movq	%r12, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %r12
	jb	.L1228
.L1229:
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	js	.L1280
	xorl	%ebx, %ebx
	leaq	.LC40(%rip), %r13
	.p2align 4
	.p2align 3
.L1281:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jge	.L1281
	movq	%r14, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC150(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	je	.L1254
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1283:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1283
	jmp	.L1254
	.p2align 4,,10
	.p2align 3
.L1209:
	movl	%r12d, 8(%rsp)
	xorl	%ebx, %ebx
	movl	8(%rsp), %ebp
	leaq	.LC40(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1276
	.p2align 4
	.p2align 3
.L1230:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1230
.L1276:
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC141(%rip), %rdi
	jmp	.L1485
	.p2align 4,,10
	.p2align 3
.L1207:
	xorl	%ebp, %ebp
	leaq	.LC40(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1496
	.p2align 4
	.p2align 3
.L1218:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1218
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 8(%rsp)
	testq	%rbp, %rbp
	je	.L1497
.L1219:
	movq	function_labels(%rip), %r15
	xorl	%r13d, %r13d
	jmp	.L1325
	.p2align 4,,10
	.p2align 3
.L1323:
	addq	$1, %r13
	cmpq	%rbp, %r13
	je	.L1220
.L1325:
	movq	(%r15,%r13,8), %rsi
	movq	8(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1323
	leal	1(%r13), %edx
.L1324:
	leaq	.LC162(%rip), %rsi
	movq	%r14, %rdi
	leal	1(%r12), %r15d
	xorl	%eax, %eax
	call	fprintf@PLT
	leaq	.LC40(%rip), %r13
	testl	%r15d, %r15d
	jle	.L1328
.L1326:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1327:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jne	.L1327
.L1328:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movl	%r15d, %r12d
	leaq	.LC117(%rip), %rdi
	xorl	%ebp, %ebp
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	jmp	.L1202
	.p2align 4,,10
	.p2align 3
.L1359:
	movq	$0, 24(%rsp)
	jmp	.L1299
	.p2align 4,,10
	.p2align 3
.L1489:
	movl	16(%r13), %eax
	testl	%eax, %eax
	je	.L1309
	movq	32(%r13), %rcx
	movq	%rsi, %rdx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC158(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1308
	.p2align 4,,10
	.p2align 3
.L1493:
	movq	16(%rsp), %rcx
	movl	%r12d, %edx
	movq	%r15, %rsi
	movq	%r14, %rdi
	call	emit_auto_storage
	cmpq	$0, 8(%r15)
	jne	.L1329
	movl	g_strict(%rip), %ecx
	testl	%ecx, %ecx
	je	.L1259
	.p2align 4
	.p2align 3
.L1330:
	xorl	%r15d, %r15d
	testl	%r12d, %r12d
	jle	.L1262
	.p2align 4
	.p2align 3
.L1261:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1261
.L1262:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1259
.L1492:
	cmpl	$6, (%r12)
	movl	%ebp, %ecx
	jne	.L1247
	movl	g_no_line(%rip), %r8d
	testl	%r8d, %r8d
	jne	.L1248
	cmpb	$0, 24(%rsp)
	je	.L1248
	movl	4(%r12), %edx
	movq	16(%rsp), %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC41(%rip), %rsi
	call	fprintf@PLT
.L1248:
	movl	8(%rsp), %edi
	leaq	.LC40(%rip), %rax
	xorl	%r15d, %r15d
	movq	%rax, 32(%rsp)
	testl	%edi, %edi
	js	.L1251
	.p2align 4
	.p2align 3
.L1249:
	movq	32(%rsp), %rdi
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r15d
	call	fwrite@PLT
	cmpl	%r15d, 8(%rsp)
	jge	.L1249
.L1251:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r12), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1250
	.p2align 4,,10
	.p2align 3
.L1309:
	movq	%rsi, %rdx
	movq	%r14, %rdi
	leaq	.LC159(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1308
	.p2align 4,,10
	.p2align 3
.L1348:
	xorl	%ecx, %ecx
	jmp	.L1247
	.p2align 4,,10
	.p2align 3
.L1307:
	cmpl	$27, %eax
	leaq	.LC135(%rip), %rdx
	leaq	.LC134(%rip), %rax
	cmove	%rax, %rdx
	jmp	.L1306
.L1225:
	xorl	%ebp, %ebp
	cmpq	$0, 32(%rbx)
	sete	%bpl
	jmp	.L1226
.L1490:
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	xorl	%eax, %eax
	movq	%r14, %rdi
	call	fprintf@PLT
	testl	%r12d, %r12d
	jle	.L1484
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
.L1484:
	movl	32(%rsp), %edx
	movq	%r14, %rdi
	leaq	.LC161(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC142(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1319
.L1496:
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 8(%rsp)
	testq	%rbp, %rbp
	jne	.L1219
.L1220:
	xorl	%edx, %edx
	jmp	.L1324
.L1495:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1234
.L1494:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1486
.L1280:
	movq	%r14, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC150(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1254
.L1491:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC144(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	jne	.L1244
	jmp	.L1254
.L1488:
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC152(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r12d
	testl	%eax, %eax
	je	.L1288
	movq	%r14, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC153(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	leaq	.LC117(%rip), %rax
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ebp
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC154(%rip), %rdx
	movl	$64, %esi
	movl	%ebp, %ecx
	call	snprintf@PLT
	movl	%ebp, %edx
	leaq	.LC155(%rip), %rsi
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
	leaq	.LC156(%rip), %rax
	movq	%rax, %rsi
	movq	%rax, 64(%rsp)
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%eax, %eax
	movl	%ebp, %edx
	leaq	.LC163(%rip), %rsi
	movq	%r14, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r15)
	leal	2(%rax), %ebx
	jne	.L1333
	cmpl	$1, %ebx
	je	.L1296
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1484
	.p2align 4,,10
	.p2align 3
.L1497:
	xorl	%edx, %edx
	leaq	.LC162(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%r12), %r15d
	jmp	.L1326
	.cfi_endproc
.LFE59:
	.size	emit_stmt, .-emit_stmt
	.section	.rodata.str1.1
.LC164:
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
	leaq	.L1503(%rip), %r15
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
	je	.L1498
.L1499:
	cmpl	$13, 0(%r13)
	ja	.L1501
	movl	0(%r13), %eax
	movslq	(%r15,%rax,4), %rax
	addq	%r15, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1503:
	.long	.L1501-.L1503
	.long	.L1507-.L1503
	.long	.L1501-.L1503
	.long	.L1506-.L1503
	.long	.L1505-.L1503
	.long	.L1501-.L1503
	.long	.L1501-.L1503
	.long	.L1501-.L1503
	.long	.L1501-.L1503
	.long	.L1501-.L1503
	.long	.L1501-.L1503
	.long	.L1504-.L1503
	.long	.L1501-.L1503
	.long	.L1502-.L1503
	.text
	.p2align 4,,10
	.p2align 3
.L1501:
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
.L1502:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1551
	xorl	%eax, %eax
	jmp	.L1521
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1520:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1551
.L1521:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%r13, (%rdx)
	jne	.L1520
	movq	8(%rdx), %r14
.L1519:
	xorl	%r13d, %r13d
	leaq	.LC40(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1585
	.p2align 4
	.p2align 3
.L1522:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1522
	movq	%r14, %rdx
	leaq	.LC164(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1525:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jle	.L1525
.L1524:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	jmp	.L1584
	.p2align 4,,10
	.p2align 3
.L1504:
	xorl	%r14d, %r14d
	leaq	.LC40(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1586
	.p2align 4
	.p2align 3
.L1508:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1508
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L1587
.L1509:
	movq	function_labels(%rip), %r14
	xorl	%r12d, %r12d
	jmp	.L1529
	.p2align 4,,10
	.p2align 3
.L1527:
	addq	$1, %r12
	cmpq	%r12, 24(%rsp)
	je	.L1510
.L1529:
	movq	(%r14,%r12,8), %rsi
	movq	16(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1527
	leal	1(%r12), %edx
.L1528:
	leaq	.LC162(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	leaq	.LC40(%rip), %r12
	movl	%eax, 16(%rsp)
	testl	%eax, %eax
	jle	.L1588
.L1530:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1532:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, %ebp
	jne	.L1532
	movl	16(%rsp), %ebp
.L1533:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	jne	.L1499
	jmp	.L1498
	.p2align 4,,10
	.p2align 3
.L1505:
	xorl	%r14d, %r14d
	leaq	.LC40(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1545
	.p2align 4
	.p2align 3
.L1511:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1511
.L1545:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC136(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC137(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	je	.L1498
.L1512:
	xorl	%eax, %eax
	cmpl	$1, 0(%r13)
	setne	%al
	addl	%eax, %ebp
	jmp	.L1499
	.p2align 4,,10
	.p2align 3
.L1506:
	xorl	%r14d, %r14d
	leaq	.LC40(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1540
	.p2align 4
	.p2align 3
.L1514:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1514
.L1540:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC138(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC137(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %rsi
	testq	%rsi, %rsi
	je	.L1516
	cmpl	$1, (%rsi)
	movl	%ebp, %edx
	je	.L1541
.L1516:
	leal	1(%rbp), %edx
.L1541:
	movq	(%rsp), %r8
	movq	8(%rsp), %rcx
	movq	%rbx, %rdi
	call	emit_stmt_switchctx
	cmpq	$0, 32(%r13)
	je	.L1498
	xorl	%r14d, %r14d
	leaq	.LC40(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1544
	.p2align 4
	.p2align 3
.L1542:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1542
.L1544:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC147(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r13), %r13
	testq	%r13, %r13
	jne	.L1512
.L1498:
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
.L1507:
	.cfi_restore_state
	xorl	%r15d, %r15d
	leaq	.LC40(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1589
	.p2align 4
	.p2align 3
.L1517:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebp, %r15d
	jne	.L1517
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC144(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	je	.L1535
.L1534:
	leal	1(%rbp), %r12d
	xorl	%r15d, %r15d
.L1537:
	movq	16(%r13), %rax
	movq	(%rsp), %r8
	movl	%r12d, %edx
	movq	%rbx, %rdi
	movq	8(%rsp), %rcx
	movq	(%rax,%r15,8), %rsi
	addq	$1, %r15
	call	emit_stmt_switchctx
	cmpq	24(%r13), %r15
	jb	.L1537
	leaq	.LC40(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1536
.L1535:
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1539:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1539
.L1536:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
.L1584:
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
.L1551:
	.cfi_restore_state
	xorl	%r14d, %r14d
	jmp	.L1519
	.p2align 4,,10
	.p2align 3
.L1586:
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	jne	.L1509
	.p2align 4
	.p2align 3
.L1510:
	xorl	%edx, %edx
	jmp	.L1528
.L1587:
	xorl	%edx, %edx
	leaq	.LC162(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	movl	%eax, 16(%rsp)
	jmp	.L1530
	.p2align 4,,10
	.p2align 3
.L1585:
	xorl	%eax, %eax
	movq	%r14, %rdx
	leaq	.LC164(%rip), %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	testl	%ebp, %ebp
	jne	.L1524
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	jmp	.L1524
	.p2align 4,,10
	.p2align 3
.L1588:
	movl	%eax, %ebp
	jmp	.L1533
	.p2align 4,,10
	.p2align 3
.L1589:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC144(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	jne	.L1534
	jmp	.L1536
	.cfi_endproc
.LFE47:
	.size	emit_stmt_switchctx, .-emit_stmt_switchctx
	.section	.rodata.str1.1
.LC165:
	.string	"static "
.LC166:
	.string	""
	.section	.rodata.str1.8
	.align 8
.LC167:
	.string	"#ifndef %s\nextern word %s[];\n#define __b_external_%s (%s[0])\n#else\n#define __b_external_%s (%s)\n#endif\n"
	.section	.rodata.str1.1
.LC168:
	.string	"extern word %s[];\n"
.LC169:
	.string	"%sword %s[%zu];\n"
.LC170:
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
	je	.L1590
	movq	%rdi, %rbp
	movq	%rsi, %r12
	xorl	%ebx, %ebx
	jmp	.L1604
	.p2align 4,,10
	.p2align 3
.L1593:
	addq	$1, %rbx
	cmpq	8(%r12), %rbx
	jnb	.L1590
.L1604:
	movq	(%r12), %rax
	movq	(%rax,%rbx,8), %r14
	movl	(%r14), %eax
	testl	%eax, %eax
	je	.L1622
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L1593
	movq	8(%r14), %r13
	movq	16(%r13), %rdi
	call	get_mangled_name
	cmpl	$3, (%r14)
	movq	%rax, %r15
	je	.L1623
	cmpl	$1, 24(%r13)
	movl	$1, %r8d
	jne	.L1598
	movq	56(%r13), %rdi
	movl	$1, %r11d
	testq	%rdi, %rdi
	je	.L1599
	cmpl	$1, (%rdi)
	je	.L1624
.L1599:
	call	edge_tail_words_top
	leaq	(%rax,%r11), %r8
	movl	$1, %eax
	testq	%r8, %r8
	cmove	%rax, %r8
.L1598:
	movl	4(%r13), %eax
	leaq	.LC166(%rip), %rdx
	testl	%eax, %eax
	je	.L1600
	leaq	.LC165(%rip), %rdx
.L1600:
	xorl	%eax, %eax
	movq	%r15, %rcx
	leaq	.LC169(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$2, 24(%r13)
	jne	.L1593
	movq	56(%r13), %rdi
	xorl	%r11d, %r11d
	testq	%rdi, %rdi
	je	.L1601
	cmpl	$1, (%rdi)
	je	.L1625
.L1601:
	cmpq	$0, 32(%r13)
	je	.L1602
	movq	48(%r13), %rax
	movq	%r11, %rdx
	cmpq	%rax, %r11
	cmovb	%rax, %r11
	testq	%rax, %rax
	cmovle	%rdx, %r11
.L1602:
	call	edge_tail_words_top
	movq	%r15, %rdx
	leaq	.LC170(%rip), %rsi
	movq	%rbp, %rdi
	leaq	(%rax,%r11), %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	xorl	%eax, %eax
	addq	$1, %rbx
	call	fprintf@PLT
	cmpq	8(%r12), %rbx
	jb	.L1604
.L1590:
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
.L1622:
	.cfi_restore_state
	movq	8(%r14), %rsi
	movq	(%rsp), %r8
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbp, %rdi
	call	emit_stmt
	jmp	.L1593
	.p2align 4,,10
	.p2align 3
.L1623:
	movq	16(%r13), %rdx
	movq	%rdx, %rdi
	movq	%rdx, 8(%rsp)
	call	global_data_kind
	testl	%eax, %eax
	je	.L1593
	movl	8(%r13), %esi
	testl	%esi, %esi
	je	.L1597
	movq	8(%rsp), %rdx
	movq	%r15, %rcx
	movq	%r15, %r9
	movq	%r15, %r8
	leaq	.LC167(%rip), %rsi
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
	jmp	.L1593
	.p2align 4,,10
	.p2align 3
.L1624:
	movq	24(%rdi), %r11
	jmp	.L1599
	.p2align 4,,10
	.p2align 3
.L1597:
	movq	%r15, %rdx
	leaq	.LC168(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1593
.L1625:
	movq	24(%rdi), %r11
	jmp	.L1601
	.cfi_endproc
.LFE64:
	.size	emit_global_declarations, .-emit_global_declarations
	.section	.rodata.str1.1
.LC171:
	.string	"{\n    B_FRAME;\n"
	.section	.rodata.str1.8
	.align 8
.LC172:
	.string	"    (void)B_LOCAL_PTR_N(&%s, sizeof(%s));\n"
	.align 8
.LC173:
	.string	"    static word __b_label_value_%zu = %zu;\n"
	.section	.rodata.str1.1
.LC174:
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
	movq	%rbp, %rcx
	movl	$15, %edx
	movl	$1, %esi
	leaq	.LC171(%rip), %rdi
	call	fwrite@PLT
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L1639
.L1627:
	cmpl	$16, current_word_bits(%rip)
	je	.L1640
.L1631:
	cmpq	$0, 8+function_labels(%rip)
	je	.L1633
	xorl	%ebx, %ebx
	leaq	.LC173(%rip), %r14
	.p2align 4
	.p2align 3
.L1634:
	addq	$1, %rbx
	xorl	%eax, %eax
	movq	%r14, %rsi
	movq	%rbp, %rdi
	movq	%rbx, %rcx
	movq	%rbx, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %rbx
	jb	.L1634
.L1633:
	movq	32(%r12), %rsi
	movq	%r13, %r8
	movq	%rbp, %rdi
	movl	$1, %ecx
	movl	$1, %edx
	call	emit_stmt
	movq	%rbp, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC174(%rip), %rdi
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
.L1640:
	.cfi_restore_state
	cmpq	$0, 16(%r12)
	je	.L1631
	xorl	%r14d, %r14d
	leaq	.LC172(%rip), %rbx
	.p2align 4
	.p2align 3
.L1632:
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
	jb	.L1632
	jmp	.L1631
	.p2align 4,,10
	.p2align 3
.L1639:
	movq	32(%r12), %rdi
	pxor	%xmm0, %xmm0
	movq	%rsp, %rsi
	movq	$0, 16(%rsp)
	movaps	%xmm0, (%rsp)
	call	collect_function_autos
	cmpq	$0, 8(%rsp)
	je	.L1628
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1629:
	movq	(%rsp), %rax
	movq	%r13, %rcx
	movl	$1, %edx
	movq	%rbp, %rdi
	movq	(%rax,%rbx,8), %rsi
	addq	$1, %rbx
	call	emit_auto_storage
	cmpq	8(%rsp), %rbx
	jb	.L1629
.L1628:
	cmpq	$0, g_compilation_arena(%rip)
	jne	.L1627
	movq	(%rsp), %rdi
	call	free@PLT
	jmp	.L1627
	.cfi_endproc
.LFE60:
	.size	emit_function_body, .-emit_function_body
	.section	.rodata.str1.1
.LC175:
	.string	"#define BCC_USE_CURSES 1\n"
	.section	.rodata.str1.8
	.align 8
.LC176:
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
.LC177:
	.string	"#define __bcc_strict_runtime %d\n"
	.section	.rodata.str1.1
.LC178:
	.string	"#define B_BYTEPTR %d\n"
.LC179:
	.string	"#define WORD_BITS %d\n"
	.section	.rodata.str1.8
	.align 8
.LC180:
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
.LC181:
	.string	"%s/btarget.h"
	.section	.rodata.str1.8
	.align 8
.LC182:
	.string	"#define B_TARGET_DEFINE\n#define B_TARGET_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC183:
	.string	"%s/binit.h"
	.section	.rodata.str1.8
	.align 8
.LC184:
	.string	"#define B_INIT_DEFINE\n#define B_INIT_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC185:
	.string	"%s/bunix.h"
	.section	.rodata.str1.8
	.align 8
.LC186:
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
.LC187:
	.string	"%s/bformat.h"
	.section	.rodata.str1.8
	.align 8
.LC188:
	.string	"#define __bcc_format_linkage static\n"
	.align 8
.LC189:
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
.LC190:
	.string	"word __b_user_main("
	.section	.rodata.str1.8
	.align 8
.LC191:
	.string	"int main(int argc, char **argv){\n"
	.section	.rodata.str1.1
.LC192:
	.string	"    __b_setargs(argc, argv);\n"
.LC193:
	.string	"    __b_init();\n"
	.section	.rodata.str1.8
	.align 8
.LC194:
	.string	"    return (int)((word (*)())B_FUNCTION_CPTR("
	.section	.rodata.str1.1
.LC195:
	.string	"(word)argc"
.LC196:
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
	jne	.L1665
.L1642:
	movq	%rbx, %rcx
	movl	$1529, %edx
	movl	$1, %esi
	leaq	.LC176(%rip), %rdi
	call	fwrite@PLT
	movl	g_strict(%rip), %ecx
	xorl	%edx, %edx
	movq	%rbx, %rdi
	leaq	.LC177(%rip), %rsi
	testl	%ecx, %ecx
	setne	%dl
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbx, %rdi
	setne	%dl
	leaq	.LC178(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%ebp, %edx
	leaq	.LC179(%rip), %rsi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	leaq	40(%rsp), %rbp
	call	fprintf@PLT
	movq	%rbx, %rcx
	movl	$1441, %edx
	movl	$1, %esi
	leaq	.LC180(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC181(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$73, %edx
	movl	$1, %esi
	leaq	.LC182(%rip), %rdi
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
	leaq	.LC183(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$69, %edx
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
	leaq	.LC186(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC187(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$36, %edx
	movl	$1, %esi
	leaq	.LC188(%rip), %rdi
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
	leaq	.LC189(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1666
.L1643:
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
	je	.L1641
	movq	$0, 24(%rsp)
	xorl	%ebp, %ebp
	movl	$0, 20(%rsp)
	.p2align 5
	.p2align 4
	.p2align 3
.L1651:
	movq	(%r12), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$1, (%rax)
	je	.L1667
.L1645:
	addq	$1, %rbp
	cmpq	8(%r12), %rbp
	jb	.L1651
	movl	20(%rsp), %eax
	testl	%eax, %eax
	jne	.L1668
.L1641:
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
.L1667:
	.cfi_restore_state
	movq	8(%rax), %r14
	leaq	.LC22(%rip), %rsi
	movq	(%r14), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1669
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
.L1647:
	cmpq	$0, 16(%r14)
	je	.L1648
	xorl	%r13d, %r13d
	leaq	.LC29(%rip), %r15
	jmp	.L1650
	.p2align 4,,10
	.p2align 3
.L1670:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC33(%rip), %rdi
	call	fwrite@PLT
.L1650:
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r14), %rax
	movq	(%rax,%r13,8), %rdi
	testq	%rdi, %rdi
	je	.L1649
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1649:
	addq	$1, %r13
	cmpq	16(%r14), %r13
	jb	.L1670
.L1648:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC137(%rip), %rdi
	call	fwrite@PLT
	movq	8(%rsp), %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_function_body
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1645
	.p2align 4,,10
	.p2align 3
.L1669:
	movq	16(%r14), %rax
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC190(%rip), %rdi
	movq	%rax, 24(%rsp)
	call	fwrite@PLT
	movl	$1, 20(%rsp)
	jmp	.L1647
	.p2align 4,,10
	.p2align 3
.L1668:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC191(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC192(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC193(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$45, %edx
	movl	$1, %esi
	leaq	.LC194(%rip), %rdi
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
	leaq	.LC72(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%rsp)
	jne	.L1671
.L1655:
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
	leaq	.LC122(%rip), %rdi
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
.L1666:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1643
	.p2align 4,,10
	.p2align 3
.L1665:
	movq	%rbx, %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC175(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1642
	.p2align 4,,10
	.p2align 3
.L1671:
	movq	%rbx, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC195(%rip), %rdi
	call	fwrite@PLT
	cmpq	$2, 24(%rsp)
	jne	.L1655
	movq	%rbx, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC196(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1655
	.cfi_endproc
.LFE66:
	.size	emit_program_c, .-emit_program_c
	.section	.rodata.str1.8
	.align 8
.LC197:
	.string	"/* Generated by BCC - B Compiler */\n"
	.section	.rodata.str1.1
.LC198:
	.string	"#include \"libb.h\"\n\n"
	.section	.rodata.str1.8
	.align 8
.LC199:
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
	je	.L1697
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
	leaq	.LC197(%rip), %rdi
	call	fwrite@PLT
	movl	g_strict(%rip), %ecx
	xorl	%edx, %edx
	movq	%rbx, %rdi
	leaq	.LC177(%rip), %rsi
	testl	%ecx, %ecx
	setne	%dl
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbx, %rdi
	setne	%dl
	leaq	.LC178(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%ebp, %edx
	leaq	.LC179(%rip), %rsi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	call	fprintf@PLT
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$19, %edx
	leaq	.LC198(%rip), %rdi
	call	fwrite@PLT
	movl	g_use_curses(%rip), %esi
	testl	%esi, %esi
	jne	.L1698
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1699
.L1675:
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
	je	.L1672
	movq	$0, 24(%rsp)
	xorl	%ebp, %ebp
	movl	$0, 20(%rsp)
	.p2align 5
	.p2align 4
	.p2align 3
.L1683:
	movq	(%r12), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$1, (%rax)
	je	.L1700
.L1677:
	addq	$1, %rbp
	cmpq	8(%r12), %rbp
	jb	.L1683
	movl	20(%rsp), %eax
	testl	%eax, %eax
	jne	.L1701
.L1672:
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
.L1699:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1675
	.p2align 4,,10
	.p2align 3
.L1698:
	movq	%rbx, %rcx
	movl	$41, %edx
	movl	$1, %esi
	leaq	.LC199(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	je	.L1675
	jmp	.L1699
	.p2align 4,,10
	.p2align 3
.L1701:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC191(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC192(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC193(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$45, %edx
	movl	$1, %esi
	leaq	.LC194(%rip), %rdi
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
	leaq	.LC72(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%rsp)
	jne	.L1702
.L1687:
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
	leaq	.LC122(%rip), %rdi
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
.L1700:
	.cfi_restore_state
	movq	8(%rax), %r14
	leaq	.LC22(%rip), %rsi
	movq	(%r14), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1678
	movq	16(%r14), %rax
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC190(%rip), %rdi
	movq	%rax, 24(%rsp)
	call	fwrite@PLT
	movl	$1, 20(%rsp)
.L1679:
	cmpq	$0, 16(%r14)
	je	.L1680
	xorl	%r13d, %r13d
	leaq	.LC29(%rip), %r15
	jmp	.L1682
	.p2align 4,,10
	.p2align 3
.L1703:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC33(%rip), %rdi
	call	fwrite@PLT
.L1682:
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r14), %rax
	movq	(%rax,%r13,8), %rdi
	testq	%rdi, %rdi
	je	.L1681
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1681:
	addq	$1, %r13
	cmpq	16(%r14), %r13
	jb	.L1703
.L1680:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC137(%rip), %rdi
	call	fwrite@PLT
	movq	8(%rsp), %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_function_body
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1677
	.p2align 4,,10
	.p2align 3
.L1697:
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
.L1678:
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
	jmp	.L1679
	.p2align 4,,10
	.p2align 3
.L1702:
	movq	%rbx, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC195(%rip), %rdi
	call	fwrite@PLT
	cmpq	$2, 24(%rsp)
	jne	.L1687
	movq	%rbx, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC196(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1687
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
.LC200:
	.string	"lchar"
.LC201:
	.string	"getchar"
.LC202:
	.string	"getchr"
.LC203:
	.string	"putchr"
.LC204:
	.string	"getstr"
.LC205:
	.string	"putstr"
.LC206:
	.string	"flush"
.LC207:
	.string	"reread"
.LC208:
	.string	"printn"
.LC209:
	.string	"putnum"
.LC210:
	.string	"print"
.LC211:
	.string	"putchar"
.LC212:
	.string	"abort"
.LC213:
	.string	"free"
.LC214:
	.string	"alloc"
.LC215:
	.string	"open"
.LC216:
	.string	"close"
.LC217:
	.string	"read"
.LC218:
	.string	"write"
.LC219:
	.string	"creat"
.LC220:
	.string	"seek"
.LC221:
	.string	"openr"
.LC222:
	.string	"openw"
.LC223:
	.string	"fork"
.LC224:
	.string	"wait"
.LC225:
	.string	"execl"
.LC226:
	.string	"execv"
.LC227:
	.string	"chdir"
.LC228:
	.string	"chmod"
.LC229:
	.string	"chown"
.LC230:
	.string	"link"
.LC231:
	.string	"unlink"
.LC232:
	.string	"stat"
.LC233:
	.string	"fstat"
.LC234:
	.string	"time"
.LC235:
	.string	"ctime"
.LC236:
	.string	"getuid"
.LC237:
	.string	"setuid"
.LC238:
	.string	"makdir"
.LC239:
	.string	"mkdir"
.LC240:
	.string	"intr"
.LC241:
	.string	"gtty"
.LC242:
	.string	"stty"
.LC243:
	.string	"system"
.LC244:
	.string	"usleep"
.LC245:
	.string	"argc"
	.section	.data.rel.ro.local,"aw"
	.align 32
	.type	names.0, @object
	.size	names.0, 416
names.0:
	.quad	.LC13
	.quad	.LC200
	.quad	.LC201
	.quad	.LC202
	.quad	.LC203
	.quad	.LC204
	.quad	.LC205
	.quad	.LC206
	.quad	.LC207
	.quad	.LC75
	.quad	.LC208
	.quad	.LC209
	.quad	.LC210
	.quad	.LC211
	.quad	.LC81
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
	.quad	.LC73
	.quad	.LC245
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
.LC246:
	.string	"break"
.LC247:
	.string	"case"
.LC248:
	.string	"const"
.LC249:
	.string	"continue"
.LC250:
	.string	"default"
.LC251:
	.string	"do"
.LC252:
	.string	"double"
.LC253:
	.string	"else"
.LC254:
	.string	"enum"
.LC255:
	.string	"extern"
.LC256:
	.string	"float"
.LC257:
	.string	"for"
.LC258:
	.string	"goto"
.LC259:
	.string	"if"
.LC260:
	.string	"inline"
.LC261:
	.string	"int"
.LC262:
	.string	"long"
.LC263:
	.string	"register"
.LC264:
	.string	"restrict"
.LC265:
	.string	"short"
.LC266:
	.string	"signed"
.LC267:
	.string	"sizeof"
.LC268:
	.string	"static"
.LC269:
	.string	"struct"
.LC270:
	.string	"switch"
.LC271:
	.string	"typedef"
.LC272:
	.string	"union"
.LC273:
	.string	"unsigned"
.LC274:
	.string	"void"
.LC275:
	.string	"volatile"
.LC276:
	.string	"while"
.LC277:
	.string	"_Bool"
.LC278:
	.string	"_Complex"
.LC279:
	.string	"_Imaginary"
.LC280:
	.string	"_Alignas"
.LC281:
	.string	"_Alignof"
.LC282:
	.string	"_Atomic"
.LC283:
	.string	"_Generic"
.LC284:
	.string	"_Noreturn"
.LC285:
	.string	"_Static_assert"
.LC286:
	.string	"_Thread_local"
.LC287:
	.string	"NULL"
.LC288:
	.string	"true"
.LC289:
	.string	"false"
.LC290:
	.string	"bool"
.LC291:
	.string	"B_PTR"
.LC292:
	.string	"B_ADDR"
.LC293:
	.string	"B_DEREF"
	.section	.data.rel.ro.local
	.align 32
	.type	c_keywords, @object
	.size	c_keywords, 424
c_keywords:
	.quad	.LC14
	.quad	.LC246
	.quad	.LC247
	.quad	.LC13
	.quad	.LC248
	.quad	.LC249
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
	.quad	.LC143
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
	.quad	.LC32
	.quad	.LC291
	.quad	.LC292
	.quad	.LC293
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
