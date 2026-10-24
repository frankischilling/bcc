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
.LFB35:
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
.LFE35:
	.size	assignment_op_to_c, .-assignment_op_to_c
	.p2align 4
	.type	collect_cases, @function
collect_cases:
.LFB44:
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
.LFE44:
	.size	collect_cases, .-collect_cases
	.p2align 4
	.type	collect_function_labels, @function
collect_function_labels:
.LFB40:
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
.LFE40:
	.size	collect_function_labels, .-collect_function_labels
	.p2align 4
	.type	collect_function_autos, @function
collect_function_autos:
.LFB55:
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
.LFE55:
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
.LFB75:
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
.LFE75:
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
	je	.L262
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
	je	.L263
	.p2align 4
	.p2align 3
.L211:
	movq	%r12, %rdi
	call	strlen@PLT
	leaq	14(%rax), %rdi
	call	xmalloc@PLT
	movl	$98, %edx
	movq	%rax, %r13
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L264
.L214:
	xorl	%eax, %eax
	movq	%r12, %rcx
	leaq	.LC18(%rip), %rsi
	movq	%r13, %rdi
	call	sprintf@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L265
.L229:
	leaq	8+c_keywords(%rip), %rbp
	leaq	.LC14(%rip), %rsi
	jmp	.L218
	.p2align 4,,10
	.p2align 3
.L266:
	movq	0(%rbp), %rsi
	addq	$8, %rbp
	testq	%rsi, %rsi
	je	.L219
.L218:
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L266
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
	je	.L267
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
.L269:
	addq	$1, %rbp
	cmpq	%rbp, %r12
	je	.L268
.L222:
	movq	(%r14,%rbp,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L269
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
.L270:
	addq	$1, %r15
	cmpq	%rbp, %r15
	je	.L223
.L225:
	movq	(%r14,%r15,8), %rax
	movq	%r12, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L270
	movl	12(%rsp), %ecx
	jmp	.L224
	.p2align 4,,10
	.p2align 3
.L262:
	leaq	.LC15(%rip), %rdi
	call	sdup@PLT
	movl	g_strict(%rip), %edx
	movq	%rax, %r12
	testl	%edx, %edx
	jne	.L211
.L263:
	leaq	8+names.0(%rip), %rbp
	leaq	.LC13(%rip), %rsi
	jmp	.L212
	.p2align 4,,10
	.p2align 3
.L272:
	movq	0(%rbp), %rsi
	addq	$8, %rbp
	testq	%rsi, %rsi
	je	.L271
.L212:
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L272
	jmp	.L211
	.p2align 4,,10
	.p2align 3
.L268:
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
	.p2align 4,,10
	.p2align 3
.L264:
	leaq	8+names.0(%rip), %rbp
	leaq	.LC13(%rip), %rsi
	jmp	.L215
	.p2align 4,,10
	.p2align 3
.L274:
	movq	0(%rbp), %rsi
	addq	$8, %rbp
	testq	%rsi, %rsi
	je	.L273
.L215:
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L274
	movl	$114, %edx
	jmp	.L214
.L196:
	movb	$95, (%r12)
	movzbl	(%rbx), %eax
	cmpb	$46, %al
	jne	.L275
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
.L271:
	movl	$6, %edx
	leaq	.LC21(%rip), %rsi
	movq	%rbx, %rdi
	movq	%r12, %r13
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L229
	jmp	.L211
	.p2align 4,,10
	.p2align 3
.L223:
	cmpq	$0, g_compilation_arena(%rip)
	je	.L276
.L226:
	movq	%r12, %r13
	jmp	.L220
.L273:
	movl	$120, %edx
	jmp	.L214
.L230:
	xorl	%r13d, %r13d
	jmp	.L189
.L265:
	movq	%r12, %rdi
	call	free@PLT
	jmp	.L229
.L275:
	movzbl	%al, %edx
	movq	%r14, %rdi
	leaq	.LC16(%rip), %rsi
	xorl	%eax, %eax
	movq	%rcx, (%rsp)
	leaq	3(%r12), %r14
	call	sprintf@PLT
	movq	(%rsp), %rcx
	jmp	.L200
.L267:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L228
.L276:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L226
	.cfi_endproc
.LFE24:
	.size	get_mangled_name, .-get_mangled_name
	.section	.rodata.str1.1
.LC22:
	.string	"main"
.LC23:
	.string	"__b_user_main"
.LC24:
	.string	"b_%s"
	.text
	.p2align 4
	.type	emit_function_name, @function
emit_function_name:
.LFB27:
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
	jne	.L280
	jmp	.L287
	.p2align 4,,10
	.p2align 3
.L288:
	movq	(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L281
.L280:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L288
	movq	%rbp, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L289
.L281:
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
.L287:
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
.L289:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	movq	%rbp, %rdx
	movq	%r12, %rdi
	popq	%rbp
	.cfi_def_cfa_offset 16
	leaq	.LC24(%rip), %rsi
	xorl	%eax, %eax
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	fprintf@PLT
	.cfi_endproc
.LFE27:
	.size	emit_function_name, .-emit_function_name
	.section	.rodata.str1.1
.LC25:
	.string	"B_ADDR("
.LC26:
	.string	"argv"
.LC27:
	.string	"b_argv_vector"
.LC28:
	.string	"__b_external_%s"
.LC29:
	.string	"[0]"
	.text
	.p2align 4
	.type	emit_ival_expr.part.0, @function
emit_ival_expr.part.0:
.LFB71:
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
	leaq	.LC25(%rip), %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	call	fwrite@PLT
	movq	40(%r12), %rbx
	leaq	.LC26(%rip), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L323
.L291:
	movq	%rbx, %rdi
	call	global_data_kind
	movq	%rbx, %rdi
	cmpl	$2, %eax
	je	.L324
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	40(%r12), %rdi
	call	global_data_kind
	cmpl	$1, %eax
	je	.L325
.L300:
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
.L323:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L291
	movq	8+g_known_variables(%rip), %r14
	testq	%r14, %r14
	je	.L292
	movq	g_known_variables(%rip), %r15
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L293:
	movq	(%r15,%r13,8), %rdi
	movq	%rbx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L291
	addq	$1, %r13
	cmpq	%r14, %r13
	jne	.L293
.L292:
	movq	current_program(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L294
	movq	8(%rax), %rax
	xorl	%r13d, %r13d
	movq	%rax, 16(%rsp)
	jmp	.L295
	.p2align 4,,10
	.p2align 3
.L296:
	testl	%eax, %eax
	je	.L326
.L297:
	addq	$1, %r13
.L295:
	cmpq	%r13, 16(%rsp)
	je	.L294
	movq	24(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r13,8), %rdx
	movl	(%rdx), %eax
	cmpl	$2, %eax
	jne	.L296
	movq	8(%rdx), %rax
	movq	%rbx, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L297
	jmp	.L291
	.p2align 4,,10
	.p2align 3
.L324:
	call	get_mangled_name
	leaq	.LC28(%rip), %rsi
	movq	%rbp, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L300
.L294:
	movq	%rbp, %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC27(%rip), %rdi
	call	fwrite@PLT
	jmp	.L300
	.p2align 4,,10
	.p2align 3
.L326:
	movq	8(%rdx), %rax
	movq	24(%rax), %rcx
	movq	%rcx, 8(%rsp)
	testq	%rcx, %rcx
	je	.L297
	movq	16(%rax), %r14
	xorl	%r15d, %r15d
	jmp	.L298
	.p2align 4,,10
	.p2align 3
.L327:
	movq	8(%rsp), %rax
	addq	$1, %r15
	cmpq	%rax, %r15
	je	.L297
.L298:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L327
	jmp	.L291
	.p2align 4,,10
	.p2align 3
.L325:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC29(%rip), %rdi
	call	fwrite@PLT
	jmp	.L300
	.cfi_endproc
.LFE71:
	.size	emit_ival_expr.part.0, .-emit_ival_expr.part.0
	.section	.rodata.str1.1
.LC30:
	.string	"extern word "
.LC31:
	.string	"();\n"
.LC32:
	.string	"b_main"
.LC33:
	.string	"static word __b_user_main("
.LC34:
	.string	"word "
.LC35:
	.string	"word"
.LC36:
	.string	", "
.LC37:
	.string	");\n"
	.text
	.p2align 4
	.type	emit_function_prototypes, @function
emit_function_prototypes:
.LFB61:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rsi, %r14
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
	cmpq	$0, 8+external_calls(%rip)
	je	.L329
	xorl	%ebp, %ebp
	leaq	.LC30(%rip), %r15
	leaq	external_calls(%rip), %r13
	leaq	.LC31(%rip), %r12
	.p2align 4
	.p2align 3
.L331:
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	0(%r13), %rax
	movq	(%rax,%rbp,8), %rdi
	testq	%rdi, %rdi
	je	.L330
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L330:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addq	$1, %rbp
	cmpq	8+external_calls(%rip), %rbp
	jb	.L331
.L329:
	cmpq	$0, 8+g_known_functions(%rip)
	je	.L339
	movl	$0, 12(%rsp)
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L337:
	leaq	g_known_functions(%rip), %rax
	leaq	.LC22(%rip), %rsi
	movq	(%rax), %rax
	movq	(%rax,%r12,8), %rbp
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L333
	leaq	.LC32(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L333
	movq	8(%r14), %rcx
	movq	(%r14), %r15
	testq	%rcx, %rcx
	je	.L334
	xorl	%r13d, %r13d
	jmp	.L336
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L335:
	addq	$1, %r13
	cmpq	%r13, %rcx
	je	.L334
.L336:
	movq	(%r15,%r13,8), %rax
	cmpl	$1, (%rax)
	jne	.L335
	movq	8(%rax), %rax
	movq	%rbp, %rsi
	movq	%rcx, (%rsp)
	movq	(%rax), %rdi
	call	strcmp@PLT
	movq	(%rsp), %rcx
	testl	%eax, %eax
	jne	.L335
	.p2align 4
	.p2align 3
.L333:
	addq	$1, %r12
	cmpq	8+g_known_functions(%rip), %r12
	jb	.L337
.L381:
	movl	12(%rsp), %eax
	testl	%eax, %eax
	je	.L339
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
.L339:
	cmpq	$0, 8(%r14)
	je	.L328
	xorl	%r12d, %r12d
	leaq	.LC35(%rip), %r15
	jmp	.L348
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L341:
	addq	$1, %r12
	cmpq	8(%r14), %r12
	jnb	.L328
.L348:
	movq	(%r14), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$1, (%rax)
	jne	.L341
	movq	8(%rax), %r13
	leaq	.LC22(%rip), %rsi
	movq	0(%r13), %rbp
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L342
	leaq	.LC32(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L343
.L342:
	movq	%rbx, %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC33(%rip), %rdi
	call	fwrite@PLT
.L347:
	xorl	%ebp, %ebp
	cmpq	$0, 16(%r13)
	jne	.L344
	jmp	.L345
	.p2align 4,,10
	.p2align 3
.L380:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
.L344:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
	addq	$1, %rbp
	cmpq	16(%r13), %rbp
	jb	.L380
.L345:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC37(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r14), %r12
	jb	.L348
.L328:
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
.L334:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC30(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
	cmpq	8+g_known_functions(%rip), %r12
	movl	$1, 12(%rsp)
	jb	.L337
	jmp	.L381
	.p2align 4,,10
	.p2align 3
.L343:
	leaq	.LC34(%rip), %rdi
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	0(%r13), %rdi
	testq	%rdi, %rdi
	je	.L346
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L346:
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L347
	.cfi_endproc
.LFE61:
	.size	emit_function_prototypes, .-emit_function_prototypes
	.p2align 4
	.type	collect_strings_expr, @function
collect_strings_expr:
.LFB31:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L421
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
	leaq	.L387(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
.L384:
	cmpl	$10, (%rbx)
	ja	.L382
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L387:
	.long	.L382-.L387
	.long	.L395-.L387
	.long	.L382-.L387
	.long	.L394-.L387
	.long	.L386-.L387
	.long	.L425-.L387
	.long	.L425-.L387
	.long	.L424-.L387
	.long	.L424-.L387
	.long	.L388-.L387
	.long	.L386-.L387
	.text
	.p2align 4,,10
	.p2align 3
.L386:
	movq	40(%rbx), %rdi
	call	collect_strings_expr
.L425:
	movq	48(%rbx), %rbx
.L402:
	testq	%rbx, %rbx
	jne	.L384
.L382:
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
.L388:
	.cfi_restore_state
	movq	40(%rbx), %rdi
	call	collect_strings_expr
.L424:
	movq	48(%rbx), %rdi
	call	collect_strings_expr
	movq	56(%rbx), %rbx
	jmp	.L402
	.p2align 4,,10
	.p2align 3
.L394:
	movl	g_strict(%rip), %edx
	movq	40(%rbx), %rbp
	testl	%edx, %edx
	jne	.L426
.L396:
	movq	%rbp, %rdi
	call	collect_strings_expr
	cmpq	$0, 56(%rbx)
	je	.L382
	xorl	%ebp, %ebp
.L401:
	movq	48(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_expr
	cmpq	56(%rbx), %rbp
	jb	.L401
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
.L395:
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
.L426:
	.cfi_restore_state
	movl	24(%rbx), %eax
	testl	%eax, %eax
	jne	.L396
	cmpl	$2, 0(%rbp)
	jne	.L396
	movq	40(%rbp), %r13
	leaq	8+names.0(%rip), %r12
	leaq	.LC13(%rip), %rsi
	jmp	.L397
	.p2align 4,,10
	.p2align 3
.L428:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L427
.L397:
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L428
	jmp	.L396
	.p2align 4,,10
	.p2align 3
.L421:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L427:
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
	jne	.L396
	movq	8+external_calls(%rip), %rax
	testq	%rax, %rax
	je	.L399
	movq	external_calls(%rip), %r12
	leaq	(%r12,%rax,8), %r15
	.p2align 4
	.p2align 3
.L400:
	movq	(%r12), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	addq	$8, %r12
	movzbl	%al, %eax
	orl	%eax, %r14d
	cmpq	%r15, %r12
	jne	.L400
	testl	%r14d, %r14d
	jne	.L396
.L399:
	movq	%r13, %rdi
	call	sdup@PLT
	leaq	external_calls(%rip), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movq	40(%rbx), %rbp
	jmp	.L396
	.cfi_endproc
.LFE31:
	.size	collect_strings_expr, .-collect_strings_expr
	.p2align 4
	.type	collect_strings_init, @function
collect_strings_init:
.LFB32:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L438
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
	je	.L441
	cmpl	$1, %eax
	je	.L442
.L429:
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
.L441:
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
.L442:
	.cfi_restore_state
	cmpq	$0, 24(%rdi)
	je	.L429
	xorl	%ebp, %ebp
.L432:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_init
	cmpq	24(%rbx), %rbp
	jb	.L432
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L438:
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE32:
	.size	collect_strings_init, .-collect_strings_init
	.p2align 4
	.type	collect_strings_stmt, @function
collect_strings_stmt:
.LFB33:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L466
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L448(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L445:
	cmpl	$12, (%rbx)
	ja	.L443
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L448:
	.long	.L443-.L448
	.long	.L455-.L448
	.long	.L443-.L448
	.long	.L454-.L448
	.long	.L447-.L448
	.long	.L451-.L448
	.long	.L451-.L448
	.long	.L443-.L448
	.long	.L443-.L448
	.long	.L443-.L448
	.long	.L451-.L448
	.long	.L449-.L448
	.long	.L447-.L448
	.text
	.p2align 4,,10
	.p2align 3
.L451:
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
.L455:
	.cfi_restore_state
	cmpq	$0, 24(%rbx)
	je	.L443
	xorl	%ebp, %ebp
.L456:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_stmt
	cmpq	24(%rbx), %rbp
	jb	.L456
.L443:
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
.L447:
	.cfi_restore_state
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rbx
.L457:
	testq	%rbx, %rbx
	jne	.L445
	jmp	.L443
	.p2align 4,,10
	.p2align 3
.L449:
	movq	24(%rbx), %rbx
	jmp	.L457
	.p2align 4,,10
	.p2align 3
.L454:
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rdi
	call	collect_strings_stmt
	movq	32(%rbx), %rbx
	jmp	.L457
	.p2align 4,,10
	.p2align 3
.L466:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE33:
	.size	collect_strings_stmt, .-collect_strings_stmt
	.p2align 4
	.type	collect_strings_program, @function
collect_strings_program:
.LFB34:
	.cfi_startproc
	cmpq	$0, 8(%rdi)
	je	.L479
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
	jmp	.L476
	.p2align 4,,10
	.p2align 3
.L472:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L482
.L476:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L483
	cmpl	$2, %eax
	je	.L484
	testl	%eax, %eax
	jne	.L472
	movq	8(%rdx), %rdi
	addq	$1, %rbx
	call	collect_strings_stmt
	cmpq	8(%rbp), %rbx
	jb	.L476
.L482:
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
.L483:
	.cfi_restore_state
	movq	8(%rdx), %rax
	movq	32(%rax), %rdi
	call	collect_strings_stmt
	jmp	.L472
	.p2align 4,,10
	.p2align 3
.L484:
	movq	8(%rdx), %r12
	movq	56(%r12), %rdi
	call	collect_strings_init
	movq	32(%r12), %rdi
	testq	%rdi, %rdi
	je	.L472
	call	collect_strings_expr
	jmp	.L472
	.p2align 4,,10
	.p2align 3
.L479:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE34:
	.size	collect_strings_program, .-collect_strings_program
	.section	.rodata.str1.1
.LC38:
	.string	"  "
	.text
	.p2align 4
	.globl	emit_indent
	.type	emit_indent, @function
emit_indent:
.LFB36:
	.cfi_startproc
	testl	%esi, %esi
	jle	.L490
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	leaq	.LC38(%rip), %r13
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
.L487:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L487
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
.L490:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	ret
	.cfi_endproc
.LFE36:
	.size	emit_indent, .-emit_indent
	.section	.rodata.str1.1
.LC39:
	.string	"#line %d \"%s\"\n"
	.text
	.p2align 4
	.globl	emit_line_directive
	.type	emit_line_directive, @function
emit_line_directive:
.LFB37:
	.cfi_startproc
	movl	g_no_line(%rip), %eax
	testl	%eax, %eax
	jne	.L493
	testq	%rdx, %rdx
	jne	.L501
.L493:
	ret
	.p2align 4,,10
	.p2align 3
.L501:
	movq	%rdx, %rcx
	xorl	%eax, %eax
	movl	%esi, %edx
	leaq	.LC39(%rip), %rsi
	jmp	fprintf@PLT
	.cfi_endproc
.LFE37:
	.size	emit_line_directive, .-emit_line_directive
	.section	.rodata.str1.1
.LC40:
	.string	"\\n"
.LC41:
	.string	"\\t"
.LC42:
	.string	"\\x%02x"
	.text
	.p2align 4
	.globl	emit_c_string
	.type	emit_c_string, @function
emit_c_string:
.LFB38:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	leaq	.LC40(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	leaq	.LC42(%rip), %r13
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
	jne	.L503
	jmp	.L510
	.p2align 4,,10
	.p2align 3
.L518:
	movq	%r13, %rsi
	movq	%r12, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L506:
	movzbl	1(%rbp), %ebx
	addq	$1, %rbp
	testb	%bl, %bl
	je	.L510
.L503:
	cmpb	$92, %bl
	je	.L511
	cmpb	$34, %bl
	je	.L511
	cmpb	$10, %bl
	je	.L516
	cmpb	$9, %bl
	je	.L517
	movzbl	%bl, %edx
	cmpb	$31, %bl
	jbe	.L518
	movq	%r12, %rsi
	movl	%edx, %edi
	addq	$1, %rbp
	call	fputc@PLT
	movzbl	0(%rbp), %ebx
	testb	%bl, %bl
	jne	.L503
.L510:
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
.L511:
	.cfi_restore_state
	movq	%r12, %rsi
	movl	$92, %edi
	call	fputc@PLT
	movzbl	%bl, %edi
	movq	%r12, %rsi
	call	fputc@PLT
	jmp	.L506
	.p2align 4,,10
	.p2align 3
.L516:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	jmp	.L506
	.p2align 4,,10
	.p2align 3
.L517:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC41(%rip), %rdi
	call	fwrite@PLT
	jmp	.L506
	.cfi_endproc
.LFE38:
	.size	emit_c_string, .-emit_c_string
	.section	.rodata.str1.1
.LC43:
	.string	"preinc"
.LC44:
	.string	"predec"
.LC45:
	.string	"postinc"
.LC46:
	.string	"postdec"
.LC47:
	.string	"WAND"
.LC48:
	.string	"WOR"
.LC49:
	.string	"WADD"
.LC50:
	.string	"WSUB"
.LC51:
	.string	"WMUL"
.LC52:
	.string	"WSHR"
.LC53:
	.string	"WSHL"
.LC54:
	.string	"WMOD"
.LC55:
	.string	"WDIV"
.LC56:
	.string	"add_assign"
.LC57:
	.string	"or_assign"
.LC58:
	.string	"and_assign"
.LC59:
	.string	"rsh_assign"
.LC60:
	.string	"lsh_assign"
.LC61:
	.string	"mod_assign"
.LC62:
	.string	"div_assign"
.LC63:
	.string	"mul_assign"
.LC64:
	.string	"sub_assign"
.LC65:
	.string	"WVAL((word)%ld)"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC66:
	.string	"B_PTR_N(__b_str%d, sizeof(__b_str%d))"
	.section	.rodata.str1.1
.LC67:
	.string	"__b_label_value_%d"
.LC68:
	.string	"B_FUNCTION("
.LC69:
	.string	"((word (*)())B_FUNCTION_CPTR("
.LC70:
	.string	"))("
.LC71:
	.string	"callf"
.LC72:
	.string	"b_callf_dispatch(%zu"
.LC73:
	.string	"printf"
.LC74:
	.string	"malloc"
.LC75:
	.string	"calloc"
.LC76:
	.string	"realloc"
.LC77:
	.string	"B_PTR("
.LC78:
	.string	"-+ #0"
.LC79:
	.string	"exit"
.LC80:
	.string	"strlen"
.LC81:
	.string	"atoi"
.LC82:
	.string	"memmove"
.LC83:
	.string	"tcgetattr"
.LC84:
	.string	"tcsetattr"
.LC85:
	.string	"ioctl"
.LC86:
	.string	"memset"
.LC87:
	.string	"memcpy"
.LC88:
	.string	"__b_cstr("
.LC89:
	.string	"B_CPTR("
	.section	.rodata.str1.8
	.align 8
.LC90:
	.string	"(size_t)(sizeof(word) * (uword)("
	.section	.rodata.str1.1
.LC91:
	.string	"))"
.LC92:
	.string	"B_INDEX("
.LC93:
	.string	"B_DEREF("
.LC94:
	.string	"b_"
.LC95:
	.string	"(&("
.LC96:
	.string	"WNEG("
.LC97:
	.string	"({ word __b_left_%u = "
.LC98:
	.string	"; word __b_right_%u = "
	.section	.rodata.str1.8
	.align 8
.LC99:
	.string	"; (word)%s(__b_left_%u, __b_right_%u); })"
	.section	.rodata.str1.1
.LC100:
	.string	"%s("
.LC101:
	.string	" %s "
.LC102:
	.string	" = ("
.LC103:
	.string	"), "
.LC104:
	.string	" ? "
.LC105:
	.string	" : "
.LC106:
	.string	"snprintf"
.LC107:
	.string	"sprintf"
.LC108:
	.string	"fprintf"
.LC109:
	.string	"dprintf"
	.text
	.p2align 4
	.globl	emit_expr
	.type	emit_expr, @function
emit_expr:
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
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	cmpl	$10, (%rsi)
	movq	%rdi, (%rsp)
	ja	.L519
	movl	(%rsi), %eax
	movq	%rdx, %rbp
	leaq	.L522(%rip), %rdx
	movq	%rsi, %r15
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L522:
	.long	.L532-.L522
	.long	.L531-.L522
	.long	.L530-.L522
	.long	.L529-.L522
	.long	.L528-.L522
	.long	.L527-.L522
	.long	.L526-.L522
	.long	.L525-.L522
	.long	.L524-.L522
	.long	.L523-.L522
	.long	.L521-.L522
	.text
	.p2align 4,,10
	.p2align 3
.L523:
	movq	(%rsp), %rbx
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
	leaq	.LC104(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$3, %edx
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	movq	56(%r15), %rsi
.L934:
	movq	%rbp, %rdx
.L935:
	movq	%rbx, %rdi
	call	emit_expr
.L936:
	movq	%rbx, %rsi
.L939:
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
.L521:
	.cfi_restore_state
	movq	(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
.L938:
	movq	40(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
.L937:
	call	fwrite@PLT
	movq	48(%r15), %rsi
	jmp	.L934
	.p2align 4,,10
	.p2align 3
.L532:
	movq	40(%rsi), %rdx
	leaq	.LC65(%rip), %rsi
.L932:
	movq	(%rsp), %rdi
	addq	$72, %rsp
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
.L531:
	.cfi_restore_state
	movq	40(%r15), %rdi
	movq	32(%rsi), %rsi
	call	get_string_id
	movq	(%rsp), %rdi
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC66(%rip), %rsi
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
.L530:
	.cfi_restore_state
	movq	8+function_labels(%rip), %r13
	movq	40(%rsi), %r12
	testq	%r13, %r13
	je	.L533
	movq	function_labels(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L536
	.p2align 4,,10
	.p2align 3
.L534:
	addq	$1, %rbp
	cmpq	%r13, %rbp
	je	.L533
.L536:
	movq	(%r14,%rbp,8), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L534
	movl	%ebp, %edx
	addl	$1, %edx
	je	.L533
	movq	(%rsp), %rdi
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC67(%rip), %rsi
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
.L529:
	.cfi_restore_state
	movl	24(%rsi), %r11d
	testl	%r11d, %r11d
	jne	.L944
	movq	40(%rsi), %rax
	cmpl	$2, (%rax)
	movq	40(%rax), %r13
	je	.L945
	movb	$0, 34(%rsp)
	xorl	%ebx, %ebx
	xorl	%r12d, %r12d
	movb	$0, 35(%rsp)
	movq	$0, 16(%rsp)
	movq	$0, 8(%rsp)
.L546:
	movq	(%rsp), %rdi
	movq	%r13, %rsi
	call	emit_function_name
.L563:
	movq	(%rsp), %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	56(%r15), %r14
	movq	16(%rsp), %rcx
	cmpq	%r14, %rcx
	jnb	.L564
	cmpb	$0, 35(%rsp)
	je	.L564
	movq	48(%r15), %rax
	movq	(%rax,%rcx,8), %rax
	testq	%rax, %rax
	je	.L591
	cmpl	$1, (%rax)
	je	.L946
.L591:
	movq	$0, 24(%rsp)
.L567:
	movl	%ebx, 36(%rsp)
	movq	(%rsp), %r13
	xorl	%r12d, %r12d
.L630:
	cmpb	$0, 34(%rsp)
	je	.L700
	movl	g_strict(%rip), %ebx
	testl	%ebx, %ebx
	je	.L947
.L700:
	xorl	%ebx, %ebx
.L593:
	movq	48(%r15), %rax
	movq	%rbp, %rdx
	movq	%r13, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
.L670:
	testl	%ebx, %ebx
	jne	.L948
.L628:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L629
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
	jmp	.L630
	.p2align 4,,10
	.p2align 3
.L528:
	movq	(%rsp), %rbx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC92(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	jmp	.L938
	.p2align 4,,10
	.p2align 3
.L527:
	movl	40(%rsi), %r12d
	cmpl	$32, %r12d
	je	.L949
	cmpl	$53, %r12d
	je	.L950
	leal	-36(%r12), %eax
	cmpl	$1, %eax
	jbe	.L951
	movq	(%rsp), %rbx
	cmpl	$31, %r12d
	jne	.L639
	movl	current_word_bits(%rip), %esi
	testl	%esi, %esi
	jne	.L952
.L639:
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
	jmp	.L940
	.p2align 4,,10
	.p2align 3
.L526:
	movq	48(%rsi), %r12
	movl	40(%rsi), %r13d
	testq	%r12, %r12
	je	.L640
	movl	(%r12), %eax
	cmpl	$4, %eax
	je	.L641
	cmpl	$5, %eax
	jne	.L640
	cmpl	$32, 40(%r12)
	je	.L641
	.p2align 4
	.p2align 3
.L640:
	movl	current_word_bits(%rip), %ecx
	testl	%ecx, %ecx
	je	.L642
.L641:
	movq	(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC94(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	cmpl	$36, %r13d
	movq	%rbx, %rcx
	movl	$7, %edx
	leaq	.LC45(%rip), %rax
	leaq	.LC46(%rip), %rdi
	movl	$1, %esi
	cmove	%rax, %rdi
	call	fwrite@PLT
	movl	$3, %edx
	movq	%rbx, %rcx
	movl	$1, %esi
	leaq	.LC95(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r12, %rsi
.L940:
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC91(%rip), %rdi
.L933:
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
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L525:
	.cfi_restore_state
	movl	40(%rsi), %r12d
	leal	-53(%r12), %eax
	cmpl	$1, %eax
	jbe	.L953
	movl	current_word_bits(%rip), %edx
	testl	%edx, %edx
	je	.L646
	leal	-28(%r12), %eax
	cmpl	$6, %eax
	ja	.L646
	leaq	.L648(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L648:
	.long	.L711-.L648
	.long	.L653-.L648
	.long	.L652-.L648
	.long	.L651-.L648
	.long	.L650-.L648
	.long	.L649-.L648
	.long	.L647-.L648
	.text
	.p2align 4,,10
	.p2align 3
.L524:
	movl	40(%rsi), %r12d
	movq	48(%rsi), %r13
	movq	56(%rsi), %r14
	leal	-47(%r12), %eax
	cmpl	$5, %eax
	jbe	.L954
	cmpl	$21, %r12d
	je	.L656
	testq	%r13, %r13
	je	.L657
	movl	0(%r13), %eax
	cmpl	$4, %eax
	je	.L658
	cmpl	$5, %eax
	je	.L955
.L657:
	movl	current_word_bits(%rip), %eax
	testl	%eax, %eax
	je	.L656
.L658:
	leal	-38(%r12), %eax
	cmpl	$8, %eax
	ja	.L656
	leaq	.L661(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L661:
	.long	.L669-.L661
	.long	.L668-.L661
	.long	.L667-.L661
	.long	.L666-.L661
	.long	.L665-.L661
	.long	.L664-.L661
	.long	.L663-.L661
	.long	.L712-.L661
	.long	.L660-.L661
	.text
	.p2align 4,,10
	.p2align 3
.L588:
	testq	%r14, %r14
	jne	.L591
	movq	(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	jne	.L592
.L519:
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
.L533:
	.cfi_restore_state
	movl	16(%r15), %ebp
	testl	%ebp, %ebp
	jne	.L956
	movl	12(%r15), %ebx
	testl	%ebx, %ebx
	jne	.L957
	movl	20(%r15), %eax
	cmpl	$2, %eax
	je	.L958
	testq	%r12, %r12
	je	.L540
	movq	%r12, %rdi
	call	get_mangled_name
	movq	(%rsp), %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movl	20(%r15), %eax
.L540:
	cmpl	$1, %eax
	jne	.L519
	movq	(%rsp), %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC29(%rip), %rdi
	jmp	.L933
	.p2align 4,,10
	.p2align 3
.L947:
	movq	8(%rsp), %rdi
	call	source_function
	movl	%eax, %edx
	testl	%eax, %eax
	jne	.L593
	movq	16(%rsp), %rax
	movl	current_byteptr(%rip), %ebx
	cmpq	%rax, %r12
	sete	%al
	testb	%al, 35(%rsp)
	jne	.L594
	movq	24(%rsp), %rax
	testq	%rax, %rax
	je	.L595
	movl	(%rax,%r12,4), %r8d
	testl	%r8d, %r8d
	jne	.L594
.L595:
	movq	8(%rsp), %rdi
	leaq	.LC80(%rip), %rsi
	movl	%edx, 40(%rsp)
	call	strcmp@PLT
	movl	40(%rsp), %edx
	testl	%eax, %eax
	jne	.L598
	testq	%r12, %r12
	je	.L594
.L599:
	movq	8(%rsp), %rdi
	leaq	.LC82(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L600
	cmpq	$1, %r12
	jbe	.L959
.L602:
	movq	8(%rsp), %rdi
	leaq	.LC84(%rip), %rsi
	call	strcmp@PLT
	movl	%eax, 40(%rsp)
	testl	%eax, %eax
	jne	.L605
	cmpq	$2, %r12
	je	.L606
.L601:
	movq	8(%rsp), %rdi
	leaq	.LC86(%rip), %rsi
	call	strcmp@PLT
	testq	%r12, %r12
	movl	%eax, %edx
	sete	%al
	movb	%al, 48(%rsp)
	testl	%edx, %edx
	jne	.L609
	testb	%al, %al
	jne	.L929
.L609:
	movq	8(%rsp), %rdi
	leaq	.LC87(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L613
	cmpq	$1, %r12
	jbe	.L929
.L612:
	leaq	.LC76(%rip), %rcx
	movq	8(%rsp), %rdi
	movq	%rcx, %rsi
	movq	%rcx, 56(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L704
	movb	$0, 48(%rsp)
	leaq	.LC76(%rip), %rcx
.L616:
	movq	8(%rsp), %rdi
	leaq	.LC75(%rip), %rsi
	movq	%rcx, 56(%rsp)
	call	strcmp@PLT
	movq	56(%rsp), %rcx
	testl	%eax, %eax
	movl	40(%rsp), %eax
	sete	%dl
	andb	48(%rsp), %dl
	xorl	$1, %edx
	movzbl	%dl, %edx
	andl	%eax, %edx
	testl	%ebx, %ebx
	jne	.L615
	movq	8(%rsp), %rdi
	leaq	.LC74(%rip), %rsi
	movq	%rcx, 56(%rsp)
	movl	%edx, 40(%rsp)
	call	strcmp@PLT
	movl	40(%rsp), %edx
	movq	56(%rsp), %rcx
	testl	%eax, %eax
	jne	.L729
	cmpb	$0, 48(%rsp)
	je	.L729
.L723:
	movl	%edx, %ebx
.L922:
	testl	%edx, %edx
	jne	.L625
.L624:
	movq	%r13, %rcx
	movl	$32, %edx
	movl	$1, %esi
	leaq	.LC90(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rax
	movq	%rbp, %rdx
	movq	%r13, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC91(%rip), %rdi
	call	fwrite@PLT
	jmp	.L670
	.p2align 4,,10
	.p2align 3
.L646:
	movq	(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edi
	call	tk_name@PLT
	leaq	.LC101(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	56(%r15), %rsi
	jmp	.L934
	.p2align 4,,10
	.p2align 3
.L945:
	leaq	.LC71(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L960
.L547:
	leaq	8+names.0(%rip), %r12
	leaq	.LC13(%rip), %rsi
	jmp	.L551
	.p2align 4,,10
	.p2align 3
.L962:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L961
.L551:
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L962
	movq	%r13, %rdi
	call	source_function
	xorl	$1, %eax
	movl	%eax, %ebx
.L689:
	leaq	.LC73(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	movl	g_strict(%rip), %r10d
	orl	%ebx, %eax
	movl	%eax, %r14d
	testl	%r10d, %r10d
	je	.L552
	testl	%eax, %eax
	je	.L553
.L692:
	movb	$0, 35(%rsp)
	movq	$0, 16(%rsp)
.L554:
	testl	%ebx, %ebx
	je	.L963
	movq	%r13, %rdx
	xorl	%ebx, %ebx
.L677:
	movq	(%rsp), %rdi
	leaq	.LC24(%rip), %rsi
	xorl	%eax, %eax
	movl	$1, %r12d
	call	fprintf@PLT
	movq	%r13, 8(%rsp)
	movb	$1, 34(%rsp)
	jmp	.L563
	.p2align 4,,10
	.p2align 3
.L956:
	movq	(%rsp), %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC27(%rip), %rdi
	jmp	.L933
	.p2align 4,,10
	.p2align 3
.L642:
	movq	(%rsp), %rbx
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
	jmp	.L936
	.p2align 4,,10
	.p2align 3
.L951:
	movq	48(%rsi), %r13
	testq	%r13, %r13
	je	.L635
	movl	0(%r13), %eax
	cmpl	$4, %eax
	je	.L636
	cmpl	$5, %eax
	je	.L964
.L635:
	movl	current_word_bits(%rip), %edi
	testl	%edi, %edi
	je	.L637
.L636:
	movq	(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC94(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	cmpl	$36, %r12d
	movq	%rbx, %rcx
	movl	$6, %edx
	leaq	.LC43(%rip), %rax
	leaq	.LC44(%rip), %rdi
	movl	$1, %esi
	cmove	%rax, %rdi
	call	fwrite@PLT
	movl	$3, %edx
	movq	%rbx, %rcx
	movl	$1, %esi
	leaq	.LC95(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	jmp	.L940
.L653:
	leaq	.LC52(%rip), %rdx
	.p2align 4
	.p2align 3
.L654:
	movq	(%rsp), %rbx
	leaq	.LC100(%rip), %rsi
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
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
	movq	56(%r15), %rsi
	jmp	.L934
.L711:
	leaq	.LC53(%rip), %rdx
	jmp	.L654
.L647:
	leaq	.LC54(%rip), %rdx
	jmp	.L654
.L649:
	leaq	.LC55(%rip), %rdx
	jmp	.L654
.L650:
	leaq	.LC51(%rip), %rdx
	jmp	.L654
.L651:
	leaq	.LC50(%rip), %rdx
	jmp	.L654
.L652:
	leaq	.LC49(%rip), %rdx
	jmp	.L654
.L712:
	leaq	.LC58(%rip), %r12
	.p2align 4
	.p2align 3
.L662:
	movq	(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC94(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC95(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	$3, %edx
	movq	%rbx, %rcx
	movl	$1, %esi
	leaq	.LC103(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	jmp	.L935
.L660:
	leaq	.LC57(%rip), %r12
	jmp	.L662
.L669:
	leaq	.LC56(%rip), %r12
	jmp	.L662
.L667:
	leaq	.LC63(%rip), %r12
	jmp	.L662
.L668:
	leaq	.LC64(%rip), %r12
	jmp	.L662
.L663:
	leaq	.LC59(%rip), %r12
	jmp	.L662
.L664:
	leaq	.LC60(%rip), %r12
	jmp	.L662
.L665:
	leaq	.LC61(%rip), %r12
	jmp	.L662
.L666:
	leaq	.LC62(%rip), %r12
	jmp	.L662
	.p2align 4,,10
	.p2align 3
.L948:
	movq	%r13, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L628
	.p2align 4,,10
	.p2align 3
.L629:
	movl	36(%rsp), %ebx
	movq	(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	jne	.L590
.L631:
	movq	24(%rsp), %rax
	testq	%rax, %rax
	je	.L519
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
.L656:
	.cfi_restore_state
	movq	(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edi
	call	assignment_op_to_c
	leaq	.LC101(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	jmp	.L935
	.p2align 4,,10
	.p2align 3
.L564:
	testb	%r12b, %r12b
	je	.L588
	movq	8(%rsp), %rdi
	leaq	.LC79(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L588
	testq	%r14, %r14
	jne	.L591
	movq	(%rsp), %r14
	movl	$48, %edi
	movq	%r14, %rsi
	call	fputc@PLT
	movq	%r14, %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	je	.L519
.L592:
	movq	$0, 24(%rsp)
	.p2align 4
	.p2align 3
.L590:
	movq	(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L631
	.p2align 4,,10
	.p2align 3
.L594:
	testl	%ebx, %ebx
	je	.L596
.L597:
	movq	%r13, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC88(%rip), %rdi
	call	fwrite@PLT
.L627:
	movl	$1, %ebx
	jmp	.L593
	.p2align 4,,10
	.p2align 3
.L944:
	movq	(%rsp), %rbx
	movl	$29, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC69(%rip), %rdi
	leaq	.LC36(%rip), %r13
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	40(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC70(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 56(%r15)
	je	.L544
.L543:
	movq	48(%r15), %rax
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	emit_expr
	cmpq	56(%r15), %r12
	jnb	.L544
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	jmp	.L543
.L548:
	movq	(%rsp), %rbx
	leaq	-1(%r14), %rdx
	xorl	%eax, %eax
	xorl	%r12d, %r12d
	leaq	.LC72(%rip), %rsi
	leaq	.LC36(%rip), %r13
	movq	%rbx, %rdi
	call	fprintf@PLT
.L549:
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
	jne	.L549
	.p2align 4
	.p2align 3
.L544:
	movq	(%rsp), %rsi
	jmp	.L939
	.p2align 4,,10
	.p2align 3
.L954:
	movq	(%rsp), %rbx
	leaq	CSWTCH.169(%rip), %rdx
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
	leaq	.LC102(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edi
	call	tk_name@PLT
	leaq	.LC101(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	jmp	.L940
	.p2align 4,,10
	.p2align 3
.L953:
	movl	expression_id(%rip), %eax
	movq	(%rsp), %rbx
	leaq	.LC97(%rip), %rsi
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
	leaq	.LC98(%rip), %rsi
	call	fprintf@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	cmpl	$53, %r12d
	movl	%r13d, %r8d
	movl	%r13d, %ecx
	leaq	.LC47(%rip), %rax
	leaq	.LC48(%rip), %rdx
	movq	%rbx, %rdi
	cmove	%rax, %rdx
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC99(%rip), %rsi
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
.L957:
	.cfi_restore_state
	movq	(%rsp), %rbx
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC68(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	40(%r15), %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	jmp	.L936
.L598:
	movq	8(%rsp), %rdi
	leaq	.LC81(%rip), %rsi
	movl	%edx, 40(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L599
	testq	%r12, %r12
	jne	.L599
	testl	%ebx, %ebx
	movl	40(%rsp), %edx
	jne	.L597
	.p2align 4
	.p2align 3
.L596:
	movq	8(%rsp), %rdi
	leaq	.LC74(%rip), %rsi
	movl	%edx, 40(%rsp)
	call	strcmp@PLT
	testq	%r12, %r12
	movl	40(%rsp), %edx
	jne	.L728
	testl	%eax, %eax
	je	.L924
.L728:
	movl	$1, %ebx
	leaq	.LC76(%rip), %rcx
.L673:
	movq	8(%rsp), %rdi
	movq	%rcx, %rsi
	movl	%edx, 40(%rsp)
	call	strcmp@PLT
	movl	40(%rsp), %edx
	testl	%eax, %eax
	jne	.L619
	cmpq	$1, %r12
	je	.L965
.L621:
	testl	%ebx, %ebx
	jne	.L597
.L615:
	xorl	%ebx, %ebx
	testl	%edx, %edx
	je	.L593
.L611:
	movq	%r13, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC89(%rip), %rdi
	call	fwrite@PLT
	jmp	.L627
.L955:
	cmpl	$32, 40(%r13)
	jne	.L657
	jmp	.L658
.L949:
	movq	(%rsp), %rbx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC93(%rip), %rdi
	movq	%rbx, %rcx
	jmp	.L937
.L961:
	xorl	%ebx, %ebx
	jmp	.L689
.L950:
	movq	(%rsp), %rbx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC25(%rip), %rdi
	movq	%rbx, %rcx
	jmp	.L937
.L952:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC96(%rip), %rdi
	jmp	.L937
.L960:
	movq	%r13, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L547
	movq	56(%r15), %r14
	testq	%r14, %r14
	jne	.L548
	movq	(%rsp), %rdi
	xorl	%edx, %edx
	leaq	.LC72(%rip), %rsi
	call	fprintf@PLT
	jmp	.L544
.L552:
	movq	%r13, %rdi
	call	source_function
	movl	%eax, %r12d
	testl	%eax, %eax
	jne	.L692
	leaq	.LC74(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L556
	leaq	.LC75(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L556
	leaq	.LC76(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L556
	testl	%r14d, %r14d
	je	.L966
	leaq	.LC108(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L725
	leaq	.LC109(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L725
	leaq	.LC107(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L680
.L725:
	movb	$1, 35(%rsp)
	movq	$1, 16(%rsp)
	jmp	.L554
	.p2align 4,,10
	.p2align 3
.L600:
	movq	8(%rsp), %rdi
	leaq	.LC83(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L602
	cmpq	$1, %r12
	jne	.L602
	movq	8(%rsp), %rdi
	leaq	.LC87(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L920
	testl	%ebx, %ebx
	jne	.L611
	leaq	.LC76(%rip), %rcx
	movq	8(%rsp), %rdi
	movq	%rcx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L722
	xorl	%ebx, %ebx
	movl	$1, %edx
.L619:
	movq	8(%rsp), %rdi
	leaq	.LC75(%rip), %rsi
	movl	%edx, 40(%rsp)
	call	strcmp@PLT
	movl	40(%rsp), %edx
	testl	%eax, %eax
	jne	.L621
	cmpq	$1, %r12
	jne	.L621
	testl	%ebx, %ebx
	jne	.L924
	xorl	%ebx, %ebx
	jmp	.L922
.L958:
	movq	%r12, %rdi
	call	get_mangled_name
	leaq	.LC28(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L932
.L553:
	movq	%r13, %rdi
	xorl	%ebx, %ebx
	xorl	%r12d, %r12d
	call	source_function
	movq	%r13, 8(%rsp)
	xorl	$1, %eax
	movb	$1, 34(%rsp)
	movq	$0, 16(%rsp)
	andl	$1, %eax
	movb	%al, 35(%rsp)
	jmp	.L546
.L946:
	movl	$4, %esi
	movq	%r14, %rdi
	movq	40(%rax), %r12
	call	calloc@PLT
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L591
	movq	16(%rsp), %rax
	xorl	%r13d, %r13d
	leaq	1(%rax), %rsi
	movzbl	(%r12), %eax
	testb	%al, %al
	je	.L567
	movl	%ebx, 36(%rsp)
	movq	%rsi, %rbx
	movq	%rbp, 40(%rsp)
	movq	%r12, %rbp
	.p2align 4
	.p2align 3
.L566:
	cmpb	$37, %al
	jne	.L916
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r12d
	cmpb	$37, %r12b
	je	.L916
	testb	%r12b, %r12b
	jne	.L569
	jmp	.L914
	.p2align 4,,10
	.p2align 3
.L572:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r12d
	testb	%r12b, %r12b
	je	.L571
.L569:
	movsbl	%r12b, %esi
	leaq	.LC78(%rip), %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L572
	cmpb	$42, %r12b
	jne	.L571
	cmpq	%r14, %rbx
	adcq	$0, %rbx
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %edi
.L576:
	cmpb	$46, %dil
	je	.L967
.L578:
	cmpb	$104, %dil
	je	.L968
	cmpb	$108, %dil
	je	.L969
	testb	%dil, %dil
	je	.L914
	leaq	1(%r13), %rax
	cmpb	$115, %dil
	jne	.L584
	cmpq	%r14, %rbx
	jnb	.L584
	movq	24(%rsp), %rcx
	movl	$1, (%rcx,%rbx,4)
	.p2align 4
	.p2align 3
.L584:
	addq	$1, %rbx
.L568:
	movq	%rax, %r13
	movzbl	0(%rbp,%rax), %eax
	testb	%al, %al
	jne	.L566
.L914:
	movl	36(%rsp), %ebx
	movq	40(%rsp), %rbp
	jmp	.L567
	.p2align 4,,10
	.p2align 3
.L916:
	leaq	1(%r13), %rax
	jmp	.L568
.L571:
	movzbl	0(%rbp,%r13), %r12d
	testb	%r12b, %r12b
	je	.L914
	call	__ctype_b_loc@PLT
	movq	(%rax), %rax
	jmp	.L574
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L577:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r12d
	testb	%r12b, %r12b
	je	.L914
.L574:
	testb	$8, 1(%rax,%r12,2)
	jne	.L577
	movzbl	0(%rbp,%r13), %edi
	jmp	.L576
.L968:
	cmpb	$104, 1(%rbp,%r13)
	leaq	1(%r13), %rax
	jne	.L584
.L698:
	leaq	2(%r13), %rax
	jmp	.L584
.L967:
	movzbl	1(%rbp,%r13), %r12d
	leaq	1(%r13), %rcx
	movq	%rcx, 48(%rsp)
	cmpb	$42, %r12b
	jne	.L970
	cmpq	%r14, %rbx
	adcq	$0, %rbx
	addq	$2, %r13
	movzbl	0(%rbp,%r13), %edi
	jmp	.L578
.L969:
	cmpb	$108, 1(%rbp,%r13)
	leaq	1(%r13), %rax
	jne	.L584
	jmp	.L698
.L637:
	movl	%r12d, %edi
	call	tk_name@PLT
	movq	(%rsp), %rbx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	call	fputs@PLT
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	jmp	.L935
.L964:
	cmpl	$32, 40(%r13)
	jne	.L635
	jmp	.L636
.L556:
	testl	%r14d, %r14d
	je	.L971
	leaq	.LC108(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L726
	leaq	.LC109(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L726
	leaq	.LC107(%rip), %rsi
	movq	%r13, %rdi
	movl	$1, %r12d
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L680
.L726:
	movb	$1, 35(%rsp)
	movq	$1, 16(%rsp)
.L679:
	movq	(%rsp), %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC77(%rip), %rdi
	call	fwrite@PLT
	movq	40(%r15), %rax
	movq	40(%rax), %rdx
	testl	%ebx, %ebx
	je	.L694
	cmpl	$2, (%rax)
	je	.L677
	movq	%r13, 8(%rsp)
	movl	$1, %r12d
	movq	%rdx, %r13
	movb	$1, 34(%rsp)
	jmp	.L546
.L970:
	testb	%r12b, %r12b
	je	.L914
	call	__ctype_b_loc@PLT
	movq	48(%rsp), %rcx
	movq	(%rax), %rax
	jmp	.L580
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L582:
	addq	$1, %rcx
	movzbl	0(%rbp,%rcx), %r12d
	testb	%r12b, %r12b
	je	.L914
.L580:
	testb	$8, 1(%rax,%r12,2)
	jne	.L582
	movzbl	0(%rbp,%rcx), %edi
	movq	%rcx, %r13
	jmp	.L578
.L680:
	leaq	.LC106(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L715
	movb	$1, 35(%rsp)
	movq	$2, 16(%rsp)
.L678:
	testl	%r12d, %r12d
	jne	.L679
	jmp	.L554
.L920:
	movb	$0, 48(%rsp)
	movl	$1, 40(%rsp)
.L613:
	leaq	.LC76(%rip), %rcx
	movq	8(%rsp), %rdi
	movq	%rcx, %rsi
	movq	%rcx, 56(%rsp)
	call	strcmp@PLT
	leaq	.LC76(%rip), %rcx
	testl	%eax, %eax
	jne	.L616
	movzbl	48(%rsp), %edx
	movl	40(%rsp), %eax
	orl	%eax, %edx
	testl	%ebx, %ebx
	jne	.L615
	movq	8(%rsp), %rdi
	leaq	.LC74(%rip), %rsi
	movl	%edx, 40(%rsp)
	call	strcmp@PLT
	movl	40(%rsp), %edx
	testl	%eax, %eax
	jne	.L685
	cmpb	$0, 48(%rsp)
	movl	%edx, %ebx
	jne	.L922
.L685:
	cmpq	$1, %r12
	jne	.L615
	jmp	.L723
	.p2align 4,,10
	.p2align 3
.L605:
	movq	8(%rsp), %rdi
	leaq	.LC85(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L727
	cmpq	$2, %r12
	je	.L606
.L727:
	movl	$0, 40(%rsp)
	jmp	.L601
.L965:
	testl	%ebx, %ebx
	je	.L723
.L924:
	movq	%r13, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC88(%rip), %rdi
	call	fwrite@PLT
.L623:
	movl	$1, %ebx
	jmp	.L624
.L929:
	testl	%ebx, %ebx
	jne	.L611
	movq	8(%rsp), %rdi
	leaq	.LC74(%rip), %rsi
	call	strcmp@PLT
	testb	$1, %r12b
	jne	.L730
	testl	%eax, %eax
	je	.L625
.L730:
	xorl	%ebx, %ebx
	movl	$1, %edx
	leaq	.LC76(%rip), %rcx
	jmp	.L673
.L971:
	movq	(%rsp), %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC77(%rip), %rdi
	xorl	%r12d, %r12d
	movl	$1, %ebx
	call	fwrite@PLT
	movq	40(%r15), %rax
	movq	%r13, 8(%rsp)
	movb	$1, 34(%rsp)
	movb	$1, 35(%rsp)
	movq	40(%rax), %r13
	movq	$0, 16(%rsp)
	jmp	.L546
.L715:
	movb	$0, 35(%rsp)
	movq	$0, 16(%rsp)
	jmp	.L678
.L625:
	movq	%r13, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC89(%rip), %rdi
	call	fwrite@PLT
	jmp	.L623
.L606:
	movq	8(%rsp), %rdi
	leaq	.LC87(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L920
	movl	$1, 40(%rsp)
	jmp	.L612
.L704:
	movl	40(%rsp), %edx
	jmp	.L615
.L959:
	movl	$1, 40(%rsp)
	jmp	.L601
.L722:
	movl	$1, %edx
	jmp	.L723
.L966:
	xorl	%r9d, %r9d
	movq	%r13, 8(%rsp)
	xorl	%ebx, %ebx
	xorl	%r12d, %r12d
	movb	$1, 34(%rsp)
	movb	$1, 35(%rsp)
	movq	%r9, 16(%rsp)
	jmp	.L546
.L694:
	movq	%r13, 8(%rsp)
	xorl	%r12d, %r12d
	movq	%rdx, %r13
	movl	$1, %ebx
	movb	$1, 34(%rsp)
	jmp	.L546
.L963:
	movq	%r13, 8(%rsp)
	xorl	%r12d, %r12d
	movb	$1, 34(%rsp)
	jmp	.L546
.L729:
	xorl	%ebx, %ebx
	jmp	.L673
	.cfi_endproc
.LFE47:
	.size	emit_expr, .-emit_expr
	.section	.rodata.str1.1
.LC110:
	.string	"word __%s_store[("
.LC111:
	.string	")];\n"
.LC112:
	.string	"word %s = 0;\n"
	.section	.rodata.str1.8
	.align 8
.LC113:
	.string	"(void)B_LOCAL_PTR_N(&%s, sizeof(%s));\n"
	.text
	.p2align 4
	.type	emit_auto_storage, @function
emit_auto_storage:
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
	je	.L973
	testl	%r13d, %r13d
	jle	.L974
	xorl	%r12d, %r12d
	leaq	.LC38(%rip), %r14
	.p2align 4
	.p2align 3
.L975:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r13d
	jne	.L975
.L974:
	movq	%r15, %rdx
	leaq	.LC110(%rip), %rsi
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
	leaq	.LC111(%rip), %rdi
	call	fwrite@PLT
.L973:
	testl	%r13d, %r13d
	jle	.L976
	xorl	%ebx, %ebx
	leaq	.LC38(%rip), %r14
	.p2align 4
	.p2align 3
.L977:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %r12d
	leal	1(%rbx), %ebx
	cmpl	%ebx, %r13d
	jne	.L977
	xorl	%eax, %eax
	movq	%r15, %rdx
	leaq	.LC112(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L988
.L972:
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
.L988:
	.cfi_restore_state
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L982:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %r12d
	jne	.L982
.L979:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r15, %rcx
	movq	%r15, %rdx
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC113(%rip), %rsi
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
.L976:
	.cfi_restore_state
	xorl	%eax, %eax
	movq	%r15, %rdx
	leaq	.LC112(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L972
	jmp	.L979
	.cfi_endproc
.LFE56:
	.size	emit_auto_storage, .-emit_auto_storage
	.p2align 4
	.globl	emit_ival_expr
	.type	emit_ival_expr, @function
emit_ival_expr:
.LFB48:
	.cfi_startproc
	cmpl	$2, (%rsi)
	je	.L991
	jmp	emit_expr
	.p2align 4,,10
	.p2align 3
.L991:
	jmp	emit_ival_expr.part.0
	.cfi_endproc
.LFE48:
	.size	emit_ival_expr, .-emit_ival_expr
	.p2align 4
	.globl	init_list_length
	.type	init_list_length, @function
init_list_length:
.LFB49:
	.cfi_startproc
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L992
	cmpl	$1, (%rdi)
	je	.L996
.L992:
	ret
	.p2align 4,,10
	.p2align 3
.L996:
	movq	24(%rdi), %rax
	ret
	.cfi_endproc
.LFE49:
	.size	init_list_length, .-init_list_length
	.p2align 4
	.globl	try_eval_const_expr
	.type	try_eval_const_expr, @function
try_eval_const_expr:
.LFB50:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L1029
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
	je	.L999
	ja	.L1000
	testl	%eax, %eax
	je	.L1001
	cmpl	$5, %eax
	jne	.L1009
	movq	48(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L997
	movl	40(%rbx), %eax
	cmpl	$31, %eax
	je	.L1005
	cmpl	$35, %eax
	je	.L1006
	.p2align 4
	.p2align 3
.L1009:
	xorl	%eax, %eax
.L997:
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
.L1000:
	.cfi_restore_state
	cmpl	$10, %eax
	jne	.L1009
	movq	40(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L997
	movq	48(%rbx), %rdi
	movq	%rbp, %rsi
	call	try_eval_const_expr
	jmp	.L997
	.p2align 4,,10
	.p2align 3
.L1029:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L1001:
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
.L999:
	.cfi_restore_state
	movq	48(%rdi), %rdi
	movq	%rsp, %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1009
	movq	56(%rbx), %rdi
	leaq	8(%rsp), %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1009
	movl	40(%rbx), %eax
	subl	$22, %eax
	cmpl	$33, %eax
	ja	.L1009
	leaq	.L1012(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1012:
	.long	.L1025-.L1012
	.long	.L1024-.L1012
	.long	.L1023-.L1012
	.long	.L1022-.L1012
	.long	.L1021-.L1012
	.long	.L1020-.L1012
	.long	.L1009-.L1012
	.long	.L1009-.L1012
	.long	.L1019-.L1012
	.long	.L1018-.L1012
	.long	.L1017-.L1012
	.long	.L1016-.L1012
	.long	.L1015-.L1012
	.long	.L1009-.L1012
	.long	.L1009-.L1012
	.long	.L1009-.L1012
	.long	.L1009-.L1012
	.long	.L1009-.L1012
	.long	.L1009-.L1012
	.long	.L1009-.L1012
	.long	.L1009-.L1012
	.long	.L1009-.L1012
	.long	.L1009-.L1012
	.long	.L1009-.L1012
	.long	.L1009-.L1012
	.long	.L1009-.L1012
	.long	.L1009-.L1012
	.long	.L1009-.L1012
	.long	.L1009-.L1012
	.long	.L1009-.L1012
	.long	.L1009-.L1012
	.long	.L1014-.L1012
	.long	.L1013-.L1012
	.long	.L1011-.L1012
	.text
	.p2align 4,,10
	.p2align 3
.L1006:
	xorl	%eax, %eax
	cmpq	$0, 8(%rsp)
	sete	%al
	movq	%rax, 0(%rbp)
.L1027:
	movl	$1, %eax
	jmp	.L997
.L1011:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1027
.L1013:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1027
.L1014:
	movq	(%rsp), %rax
	andq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1027
.L1015:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L1009
	movq	(%rsp), %rax
	cqto
	idivq	%rcx
	movq	%rdx, 0(%rbp)
	jmp	.L1027
.L1016:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L1009
	movq	(%rsp), %rax
	cqto
	idivq	%rcx
	movq	%rax, 0(%rbp)
	jmp	.L1027
.L1017:
	movq	(%rsp), %rax
	imulq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1027
.L1018:
	movq	(%rsp), %rax
	subq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1027
.L1019:
	movq	8(%rsp), %rax
	addq	(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1027
.L1020:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setge	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1027
.L1021:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setg	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1027
.L1022:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setle	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1027
.L1023:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setl	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1027
.L1024:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1027
.L1025:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	sete	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1027
	.p2align 4,,10
	.p2align 3
.L1005:
	movq	8(%rsp), %rax
	negq	%rax
	movq	%rax, 0(%rbp)
	jmp	.L1027
	.cfi_endproc
.LFE50:
	.size	try_eval_const_expr, .-try_eval_const_expr
	.p2align 4
	.globl	nested_base_len
	.type	nested_base_len, @function
nested_base_len:
.LFB51:
	.cfi_startproc
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L1051
	cmpl	$1, (%rdi)
	je	.L1055
.L1051:
	ret
	.p2align 4,,10
	.p2align 3
.L1055:
	movq	24(%rdi), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmove	%rdx, %rax
	ret
	.cfi_endproc
.LFE51:
	.size	nested_base_len, .-nested_base_len
	.p2align 4
	.globl	edge_words_total
	.type	edge_words_total, @function
edge_words_total:
.LFB52:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L1056
	cmpl	$1, (%rdi)
	je	.L1061
.L1056:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L1061:
	movq	24(%rdi), %rsi
	movq	16(%rdi), %rdi
	jmp	edge_words_total.part.0.isra.0
	.cfi_endproc
.LFE52:
	.size	edge_words_total, .-edge_words_total
	.p2align 4
	.globl	edge_tail_words_top
	.type	edge_tail_words_top, @function
edge_tail_words_top:
.LFB53:
	.cfi_startproc
	xorl	%r9d, %r9d
	testq	%rdi, %rdi
	je	.L1074
	cmpl	$1, (%rdi)
	jne	.L1074
	movq	24(%rdi), %rcx
	movq	16(%rdi), %r8
	testq	%rcx, %rcx
	je	.L1074
	xorl	%edx, %edx
	jmp	.L1075
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1077:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L1074
.L1075:
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L1077
	cmpl	$1, (%rax)
	jne	.L1077
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
.L1078:
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r9
.L1064:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L1081
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L1064
	cmpl	$1, (%rax)
	jne	.L1064
	jmp	.L1078
	.p2align 4,,10
	.p2align 3
.L1074:
	.cfi_def_cfa_offset 8
	movq	%r9, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1081:
	.cfi_def_cfa_offset 16
	movq	%r9, %rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE53:
	.size	edge_tail_words_top, .-edge_tail_words_top
	.section	.rodata.str1.1
.LC114:
	.string	"%s[%zu] = "
.LC115:
	.string	";\n"
.LC116:
	.string	"%s[%zu] = B_ADDR(%s[%zu]);\n"
	.text
	.p2align 4
	.globl	emit_edge_list_init
	.type	emit_edge_list_init, @function
emit_edge_list_init:
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
	je	.L1083
	cmpl	$1, (%rcx)
	movq	%rcx, %r15
	jne	.L1083
	cmpq	$0, 24(%rcx)
	je	.L1083
	movq	%rsi, (%rsp)
	movq	%rdi, %rbx
	movl	%r9d, %ebp
	xorl	%r13d, %r13d
	movq	%r8, 8(%rsp)
.L1096:
	movq	16(%r15), %rax
	movq	(%rax,%r13,8), %r10
	testq	%r10, %r10
	je	.L1091
	movl	(%r10), %eax
	testl	%eax, %eax
	je	.L1115
	cmpl	$1, %eax
	je	.L1116
.L1091:
	addq	$1, %r13
	addq	$1, %r12
	cmpq	24(%r15), %r13
	jb	.L1096
	movq	8(%rsp), %rdx
.L1083:
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
.L1115:
	.cfi_restore_state
	xorl	%r14d, %r14d
	testl	%ebp, %ebp
	jle	.L1089
	movq	%r12, 16(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L1086:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC38(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1086
	movq	16(%rsp), %r12
	movq	%r14, %r10
.L1089:
	movq	(%rsp), %rdx
	leaq	.LC114(%rip), %rsi
	xorl	%eax, %eax
	movq	%r12, %rcx
	movq	%rbx, %rdi
	movq	%r10, 16(%rsp)
	call	fprintf@PLT
	movq	16(%rsp), %r10
	movq	16(%r10), %rsi
	cmpl	$2, (%rsi)
	je	.L1117
	movq	96(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L1090:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1091
	.p2align 4,,10
	.p2align 3
.L1116:
	movq	24(%r10), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmovne	%rax, %rdx
	xorl	%r14d, %r14d
	movq	%rdx, 16(%rsp)
	testl	%ebp, %ebp
	jle	.L1095
	movq	%r12, 24(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L1092:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC38(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1092
	movq	24(%rsp), %r12
	movq	%r14, %r10
.L1095:
	movq	8(%rsp), %r14
	movq	(%rsp), %r8
	movq	%r12, %rcx
	movq	%rbx, %rdi
	leaq	.LC116(%rip), %rsi
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
	jne	.L1093
	movq	24(%r10), %rsi
	movq	16(%r10), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, 8(%rsp)
.L1093:
	movq	8(%rsp), %rax
	cmpq	%rdx, %rax
	cmovnb	%rax, %rdx
	movq	%rdx, 8(%rsp)
	jmp	.L1091
	.p2align 4,,10
	.p2align 3
.L1117:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1090
	.cfi_endproc
.LFE54:
	.size	emit_edge_list_init, .-emit_edge_list_init
	.section	.rodata.str1.8
	.align 8
.LC117:
	.string	"static void __attribute__((constructor(101))) __b_register_globals(void) {\n"
	.align 8
.LC118:
	.string	"    (void)B_PTR_N(%s, sizeof(%s));\n"
	.align 8
.LC119:
	.string	"    (void)B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC120:
	.string	"}\n"
	.section	.rodata.str1.8
	.align 8
.LC121:
	.string	"static void __b_initialize_globals(void) {\n"
	.align 8
.LC122:
	.string	"    %s[0] = B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC123:
	.string	"__%s_store"
.LC124:
	.string	"    %s[0] = "
	.section	.rodata.str1.8
	.align 8
.LC125:
	.string	"}\nstatic struct __bcc_initializer __bcc_module = {__b_initialize_globals, 0, 0};\nstatic void __attribute__((constructor(102))) __bcc_register_module(void) {\n    __bcc_register_initializer(&__bcc_module);\n}\n\n"
	.text
	.p2align 4
	.type	emit_global_initializers, @function
emit_global_initializers:
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
	movq	%rdx, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	cmpl	$16, current_word_bits(%rip)
	je	.L1153
.L1119:
	movq	%r12, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC121(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%rbp)
	je	.L1125
	xorl	%ebx, %ebx
	jmp	.L1136
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1127:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L1125
.L1136:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$2, (%rax)
	jne	.L1127
	movq	8(%rax), %r14
	movq	16(%r14), %rdi
	call	get_mangled_name
	cmpl	$2, 24(%r14)
	movq	56(%r14), %r15
	movq	%rax, %r10
	je	.L1154
	testq	%r15, %r15
	je	.L1127
	movl	(%r15), %eax
	cmpl	$1, %eax
	je	.L1155
	testl	%eax, %eax
	jne	.L1127
	leaq	.LC124(%rip), %rsi
	movq	%r10, %rdx
	movq	%r12, %rdi
	call	fprintf@PLT
	movq	16(%r15), %rsi
	cmpl	$2, (%rsi)
	je	.L1156
	movq	%r13, %rdx
	movq	%r12, %rdi
	call	emit_expr
.L1135:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addq	$1, %rbx
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%rbp), %rbx
	jb	.L1136
.L1125:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rcx
	movl	$207, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC125(%rip), %rdi
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
.L1154:
	.cfi_restore_state
	movq	%rax, 8(%rsp)
	movq	%rax, %r8
	movq	%rax, %rcx
	movq	%rax, %rdx
	leaq	.LC122(%rip), %rsi
	xorl	%eax, %eax
	movq	%r12, %rdi
	call	fprintf@PLT
	testq	%r15, %r15
	je	.L1127
	cmpl	$1, (%r15)
	movq	8(%rsp), %r10
	jne	.L1127
	movq	%r10, %rsi
	leaq	.LC123(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	xorl	%r8d, %r8d
	movq	%rax, %rsi
	movq	56(%r14), %rax
	testq	%rax, %rax
	je	.L1130
	cmpl	$1, (%rax)
	je	.L1157
.L1130:
	cmpq	$0, 32(%r14)
	je	.L1131
	movq	48(%r14), %rax
	movq	%r8, %rdx
	cmpq	%rax, %r8
	cmovb	%rax, %r8
	testq	%rax, %rax
	cmovle	%rdx, %r8
.L1131:
	subq	$8, %rsp
	.cfi_def_cfa_offset 88
	movq	%r15, %rcx
	movl	$1, %r9d
	pushq	%r13
	.cfi_def_cfa_offset 96
	xorl	%edx, %edx
	movq	%r12, %rdi
	call	emit_edge_list_init
	popq	%rcx
	.cfi_def_cfa_offset 88
	popq	%rsi
	.cfi_def_cfa_offset 80
	jmp	.L1127
	.p2align 4,,10
	.p2align 3
.L1155:
	subq	$8, %rsp
	.cfi_def_cfa_offset 88
	movq	24(%r15), %r8
	xorl	%edx, %edx
	movl	$1, %r9d
	pushq	%r13
	.cfi_def_cfa_offset 96
	movq	%r15, %rcx
	movq	%r10, %rsi
	movq	%r12, %rdi
	call	emit_edge_list_init
	popq	%rax
	.cfi_def_cfa_offset 88
	popq	%rdx
	.cfi_def_cfa_offset 80
	jmp	.L1127
	.p2align 4,,10
	.p2align 3
.L1153:
	movq	%rdi, %rcx
	movl	$75, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%rbp)
	je	.L1120
	xorl	%ebx, %ebx
	jmp	.L1124
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1122:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L1120
.L1124:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$2, (%rax)
	jne	.L1122
	movq	8(%rax), %r14
	movq	16(%r14), %rdi
	call	get_mangled_name
	leaq	.LC118(%rip), %rsi
	movq	%r12, %rdi
	movq	%rax, %rcx
	movq	%rax, %rdx
	movq	%rax, %r15
	xorl	%eax, %eax
	call	fprintf@PLT
	cmpl	$2, 24(%r14)
	jne	.L1122
	movq	%r15, %rcx
	movq	%r15, %rdx
	leaq	.LC119(%rip), %rsi
	movq	%r12, %rdi
	xorl	%eax, %eax
	addq	$1, %rbx
	call	fprintf@PLT
	cmpq	8(%rbp), %rbx
	jb	.L1124
	.p2align 4
	.p2align 3
.L1120:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1119
.L1156:
	movq	%r12, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1135
.L1157:
	movq	24(%rax), %r8
	jmp	.L1130
	.cfi_endproc
.LFE63:
	.size	emit_global_initializers, .-emit_global_initializers
	.section	.rodata.str1.1
.LC126:
	.string	"<"
.LC127:
	.string	"<="
.LC128:
	.string	">"
.LC129:
	.string	">="
.LC130:
	.string	"??"
.LC131:
	.string	"while ("
.LC132:
	.string	")\n"
.LC133:
	.string	"if ("
.LC134:
	.string	"switch ("
.LC135:
	.string	") {\n"
.LC136:
	.string	"continue;\n"
.LC137:
	.string	"break;\n"
.LC138:
	.string	"return"
.LC139:
	.string	"{\n"
.LC140:
	.string	"return "
	.section	.rodata.str1.8
	.align 8
.LC141:
	.string	"%s = B_LOCAL_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC142:
	.string	"else\n"
.LC143:
	.string	" 0"
	.section	.rodata.str1.8
	.align 8
.LC144:
	.string	"case %zu: goto __b_label_%zu;\n"
	.align 8
.LC145:
	.string	"default: fputs(\"bcc: invalid label value\\n\", stderr); abort();\n"
	.section	.rodata.str1.1
.LC146:
	.string	"__bsw%d_case%zu"
.LC147:
	.string	"for(;;) {\n"
.LC148:
	.string	"word __sw = "
.LC149:
	.string	"__bsw%d_end"
.LC150:
	.string	"goto __bsw%d_dispatch;\n"
.LC151:
	.string	"goto __bsw%d_end;\n"
.LC152:
	.string	"__sw %s (word)%ld"
	.section	.rodata.str1.8
	.align 8
.LC153:
	.string	"(__sw >= (word)%ld && __sw <= (word)%ld)"
	.section	.rodata.str1.1
.LC154:
	.string	"__sw == (word)%ld"
.LC155:
	.string	") goto "
.LC156:
	.string	"__bsw%d_end:\n"
.LC157:
	.string	"__b_label_%d:\n"
.LC158:
	.string	"__bsw%d_dispatch:\n"
	.text
	.p2align 4
	.globl	emit_stmt
	.type	emit_stmt, @function
emit_stmt:
.LFB57:
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
.L1159:
	movl	g_no_line(%rip), %r10d
	testl	%r10d, %r10d
	jne	.L1160
	cmpb	$0, 24(%rsp)
	jne	.L1444
.L1160:
	cmpl	$12, (%rbx)
	ja	.L1158
	movl	(%rbx), %eax
	leaq	.L1163(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1163:
	.long	.L1174-.L1163
	.long	.L1173-.L1163
	.long	.L1172-.L1163
	.long	.L1171-.L1163
	.long	.L1170-.L1163
	.long	.L1169-.L1163
	.long	.L1168-.L1163
	.long	.L1158-.L1163
	.long	.L1167-.L1163
	.long	.L1166-.L1163
	.long	.L1165-.L1163
	.long	.L1164-.L1163
	.long	.L1162-.L1163
	.text
	.p2align 4,,10
	.p2align 3
.L1444:
	movl	4(%rbx), %edx
	movq	16(%rsp), %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC39(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1160
	.p2align 4,,10
	.p2align 3
.L1162:
	movl	g_switch_id(%rip), %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	leaq	.LC146(%rip), %r12
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
	je	.L1244
	movq	%rbx, 56(%rsp)
	movq	24(%rsp), %r13
	movq	%r14, 48(%rsp)
	movq	%rbp, %r14
	movq	40(%rsp), %rbp
	.p2align 4
	.p2align 3
.L1241:
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
	jb	.L1241
	movq	48(%rsp), %r14
	movq	56(%rsp), %rbx
.L1244:
	movl	8(%rsp), %edx
	movl	8(%rsp), %r12d
	xorl	%ebp, %ebp
	leaq	.LC38(%rip), %r13
	testl	%edx, %edx
	jle	.L1445
	.p2align 4
	.p2align 3
.L1242:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1242
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC147(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r12d
.L1245:
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 48(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1248:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1248
	movq	48(%rsp), %rbx
	movq	%r14, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	leaq	.LC115(%rip), %rax
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ecx
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC149(%rip), %rdx
	movl	$64, %esi
	call	snprintf@PLT
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 56(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1249:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1249
	movl	32(%rsp), %edx
	leaq	.LC150(%rip), %rsi
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
.L1250:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1250
	leaq	.LC151(%rip), %rax
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
.L1251:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1251
	movl	32(%rsp), %edx
	xorl	%eax, %eax
	leaq	.LC158(%rip), %rsi
	movq	%r14, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r15)
	leal	2(%rax), %ebx
	je	.L1253
.L1290:
	leaq	.LC133(%rip), %rax
	movq	%r15, 16(%rsp)
	xorl	%edi, %edi
	leaq	.LC38(%rip), %rbp
	movq	%rax, 56(%rsp)
	movl	%r12d, 76(%rsp)
	movq	%rdi, %r12
	.p2align 4
	.p2align 3
.L1267:
	movq	16(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r12,8), %r13
	movq	40(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1316
	xorl	%eax, %eax
	jmp	.L1258
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1257:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1316
.L1258:
	movq	(%rsi,%rax,8), %rdx
	cmpq	(%rdx), %r13
	jne	.L1257
	movq	8(%rdx), %rax
	movq	%rax, 24(%rsp)
.L1256:
	xorl	%r15d, %r15d
	testl	%ebx, %ebx
	jle	.L1262
	.p2align 4
	.p2align 3
.L1259:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebx, %r15d
	jne	.L1259
.L1262:
	movq	56(%rsp), %rdi
	movl	$1, %esi
	movq	%r14, %rcx
	movl	$4, %edx
	call	fwrite@PLT
	movl	20(%r13), %eax
	movq	24(%r13), %rsi
	testl	%eax, %eax
	je	.L1446
	leaq	.LC128(%rip), %rdx
	cmpl	$26, %eax
	je	.L1263
	ja	.L1264
	leaq	.LC126(%rip), %rdx
	cmpl	$24, %eax
	je	.L1263
	cmpl	$25, %eax
	leaq	.LC130(%rip), %rdx
	leaq	.LC127(%rip), %rax
	cmove	%rax, %rdx
.L1263:
	movq	%rsi, %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC152(%rip), %rsi
	call	fprintf@PLT
.L1265:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC155(%rip), %rdi
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
	jb	.L1267
	movl	76(%rsp), %r12d
	leaq	.LC38(%rip), %r13
	testl	%ebx, %ebx
	jle	.L1447
.L1253:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1269:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1269
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	testl	%r12d, %r12d
	jle	.L1420
	movl	8(%rsp), %r12d
	.p2align 4
	.p2align 3
.L1270:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jg	.L1270
.L1420:
	movl	32(%rsp), %edx
	leaq	.LC156(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	.p2align 4
	.p2align 3
.L1274:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1274
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	xorl	%ebx, %ebx
	leaq	.LC137(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	jle	.L1276
	.p2align 4
	.p2align 3
.L1277:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1277
.L1276:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
.L1158:
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
.L1174:
	.cfi_restore_state
	movl	%r12d, %ebp
	xorl	%ebx, %ebx
	leaq	.LC38(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1443
	.p2align 4
	.p2align 3
.L1198:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1198
.L1443:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
.L1442:
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
.L1173:
	.cfi_restore_state
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%r12d, %r12d
	movl	8(%rsp), %r15d
	leaq	.LC38(%rip), %r13
	testl	%eax, %eax
	jle	.L1448
	.p2align 4
	.p2align 3
.L1196:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1196
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC139(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L1202
.L1201:
	movl	8(%rsp), %edi
	xorl	%r13d, %r13d
	addl	$1, %edi
	movl	%edi, 40(%rsp)
.L1209:
	movq	16(%rbx), %rdx
	movq	(%rdx,%r13,8), %r12
	testl	%ebp, %ebp
	je	.L1305
	subq	$1, %rax
	xorl	%ecx, %ecx
	cmpq	%r13, %rax
	je	.L1449
.L1204:
	movq	16(%rsp), %r8
	movl	40(%rsp), %edx
	movq	%r12, %rsi
	movq	%r14, %rdi
	call	emit_stmt
.L1207:
	movq	24(%rbx), %rax
	addq	$1, %r13
	cmpq	%rax, %r13
	jb	.L1209
	movl	8(%rsp), %r9d
	leaq	.LC38(%rip), %r13
	testl	%r9d, %r9d
	jle	.L1211
.L1202:
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1212:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1212
.L1211:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	jmp	.L1442
	.p2align 4,,10
	.p2align 3
.L1172:
	xorl	%r13d, %r13d
	cmpq	$0, 24(%rbx)
	movl	%r12d, 8(%rsp)
	leaq	.LC38(%rip), %rbp
	movl	8(%rsp), %r12d
	je	.L1158
	.p2align 4
	.p2align 3
.L1195:
	movq	16(%rbx), %rax
	movq	(%rax,%r13,8), %r15
	movq	(%r15), %rdi
	call	get_mangled_name
	movl	g_strict(%rip), %esi
	movq	%rax, 8(%rsp)
	testl	%esi, %esi
	je	.L1450
	cmpq	$0, 8(%r15)
	je	.L1287
.L1286:
	xorl	%r15d, %r15d
	testl	%r12d, %r12d
	jle	.L1217
	.p2align 4
	.p2align 3
.L1215:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1215
.L1217:
	movq	8(%rsp), %rcx
	leaq	.LC141(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	movq	%rcx, %r8
	movq	%rcx, %rdx
	call	fprintf@PLT
.L1216:
	addq	$1, %r13
	cmpq	24(%rbx), %r13
	jb	.L1195
	jmp	.L1158
	.p2align 4,,10
	.p2align 3
.L1171:
	xorl	%r15d, %r15d
	leaq	.LC38(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1221
	.p2align 4
	.p2align 3
.L1181:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1181
.L1221:
	movq	%r14, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC133(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC132(%rip), %rdi
	call	fwrite@PLT
	testl	%ebp, %ebp
	jne	.L1182
.L1183:
	movq	24(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L1222
	cmpl	$1, (%rsi)
	movl	%r12d, %edx
	je	.L1223
.L1222:
	leal	1(%r12), %edx
.L1223:
	movq	16(%rsp), %r8
	movl	%ebp, %ecx
	movq	%r14, %rdi
	call	emit_stmt
	cmpq	$0, 32(%rbx)
	je	.L1158
	xorl	%ebp, %ebp
	leaq	.LC38(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1227
	.p2align 4
	.p2align 3
.L1224:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1224
.L1227:
	movq	%r14, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC142(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L1179
	jmp	.L1180
	.p2align 4,,10
	.p2align 3
.L1170:
	xorl	%ebp, %ebp
	leaq	.LC38(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1229
	.p2align 4
	.p2align 3
.L1178:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1178
.L1229:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC131(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC132(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L1180
.L1179:
	cmpl	$1, (%rbx)
	je	.L1228
.L1180:
	addl	$1, %r12d
.L1228:
	xorl	%ebp, %ebp
	jmp	.L1159
	.p2align 4,,10
	.p2align 3
.L1169:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	movl	8(%rsp), %r12d
	leaq	.LC38(%rip), %r13
	testl	%eax, %eax
	jle	.L1230
	.p2align 4
	.p2align 3
.L1192:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1192
.L1230:
	movq	%r14, %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC138(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%rbx)
	je	.L1451
	movq	%r14, %rsi
	movl	$32, %edi
	call	fputc@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	jmp	.L1443
	.p2align 4,,10
	.p2align 3
.L1167:
	movl	%r12d, 8(%rsp)
	xorl	%ebx, %ebx
	movl	8(%rsp), %ebp
	leaq	.LC38(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1232
	.p2align 4
	.p2align 3
.L1188:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1188
.L1232:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC137(%rip), %rdi
	jmp	.L1442
	.p2align 4,,10
	.p2align 3
.L1168:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%r12d, %r12d
	movl	8(%rsp), %r15d
	leaq	.LC38(%rip), %r13
	testl	%eax, %eax
	jle	.L1231
	.p2align 4
	.p2align 3
.L1189:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1189
.L1231:
	testl	%ebp, %ebp
	jne	.L1452
.L1191:
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	jmp	.L1443
	.p2align 4,,10
	.p2align 3
.L1165:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	movl	8(%rsp), %r12d
	leaq	.LC38(%rip), %r13
	testl	%eax, %eax
	jle	.L1234
	.p2align 4
	.p2align 3
.L1184:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1184
.L1234:
	movq	%r14, %rcx
	movl	$8, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC134(%rip), %rdi
	leaq	.LC144(%rip), %r13
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	%r14, %rdi
	movq	16(%rsp), %rdx
	leaq	.LC38(%rip), %rbp
	call	emit_expr
	movq	%r14, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC135(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	movl	8(%rsp), %r15d
	je	.L1186
	.p2align 4
	.p2align 3
.L1185:
	xorl	%ebx, %ebx
	testl	%r15d, %r15d
	js	.L1236
	.p2align 4
	.p2align 3
.L1235:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r15d
	jge	.L1235
.L1236:
	addq	$1, %r12
	xorl	%eax, %eax
	movq	%r13, %rsi
	movq	%r14, %rdi
	movq	%r12, %rcx
	movq	%r12, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %r12
	jb	.L1185
.L1186:
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	js	.L1237
	xorl	%ebx, %ebx
	leaq	.LC38(%rip), %r13
	.p2align 4
	.p2align 3
.L1238:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jge	.L1238
	movq	%r14, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	je	.L1211
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1240:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1240
	jmp	.L1211
	.p2align 4,,10
	.p2align 3
.L1166:
	movl	%r12d, 8(%rsp)
	xorl	%ebx, %ebx
	movl	8(%rsp), %ebp
	leaq	.LC38(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1233
	.p2align 4
	.p2align 3
.L1187:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1187
.L1233:
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC136(%rip), %rdi
	jmp	.L1442
	.p2align 4,,10
	.p2align 3
.L1164:
	xorl	%ebp, %ebp
	leaq	.LC38(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1453
	.p2align 4
	.p2align 3
.L1175:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1175
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 8(%rsp)
	testq	%rbp, %rbp
	je	.L1454
.L1176:
	movq	function_labels(%rip), %r15
	xorl	%r13d, %r13d
	jmp	.L1282
	.p2align 4,,10
	.p2align 3
.L1280:
	addq	$1, %r13
	cmpq	%rbp, %r13
	je	.L1177
.L1282:
	movq	(%r15,%r13,8), %rsi
	movq	8(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1280
	leal	1(%r13), %edx
.L1281:
	leaq	.LC157(%rip), %rsi
	movq	%r14, %rdi
	leal	1(%r12), %r15d
	xorl	%eax, %eax
	call	fprintf@PLT
	leaq	.LC38(%rip), %r13
	testl	%r15d, %r15d
	jle	.L1285
.L1283:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1284:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jne	.L1284
.L1285:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movl	%r15d, %r12d
	leaq	.LC115(%rip), %rdi
	xorl	%ebp, %ebp
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	jmp	.L1159
	.p2align 4,,10
	.p2align 3
.L1316:
	movq	$0, 24(%rsp)
	jmp	.L1256
	.p2align 4,,10
	.p2align 3
.L1446:
	movl	16(%r13), %eax
	testl	%eax, %eax
	je	.L1266
	movq	32(%r13), %rcx
	movq	%rsi, %rdx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC153(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1265
	.p2align 4,,10
	.p2align 3
.L1450:
	movq	16(%rsp), %rcx
	movl	%r12d, %edx
	movq	%r15, %rsi
	movq	%r14, %rdi
	call	emit_auto_storage
	cmpq	$0, 8(%r15)
	jne	.L1286
	movl	g_strict(%rip), %ecx
	testl	%ecx, %ecx
	je	.L1216
	.p2align 4
	.p2align 3
.L1287:
	xorl	%r15d, %r15d
	testl	%r12d, %r12d
	jle	.L1219
	.p2align 4
	.p2align 3
.L1218:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1218
.L1219:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1216
.L1449:
	cmpl	$6, (%r12)
	movl	%ebp, %ecx
	jne	.L1204
	movl	g_no_line(%rip), %r8d
	testl	%r8d, %r8d
	jne	.L1205
	cmpb	$0, 24(%rsp)
	je	.L1205
	movl	4(%r12), %edx
	movq	16(%rsp), %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC39(%rip), %rsi
	call	fprintf@PLT
.L1205:
	movl	8(%rsp), %edi
	leaq	.LC38(%rip), %rax
	xorl	%r15d, %r15d
	movq	%rax, 32(%rsp)
	testl	%edi, %edi
	js	.L1208
	.p2align 4
	.p2align 3
.L1206:
	movq	32(%rsp), %rdi
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r15d
	call	fwrite@PLT
	cmpl	%r15d, 8(%rsp)
	jge	.L1206
.L1208:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC140(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r12), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1207
	.p2align 4,,10
	.p2align 3
.L1266:
	movq	%rsi, %rdx
	movq	%r14, %rdi
	leaq	.LC154(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1265
	.p2align 4,,10
	.p2align 3
.L1305:
	xorl	%ecx, %ecx
	jmp	.L1204
	.p2align 4,,10
	.p2align 3
.L1264:
	cmpl	$27, %eax
	leaq	.LC130(%rip), %rdx
	leaq	.LC129(%rip), %rax
	cmove	%rax, %rdx
	jmp	.L1263
.L1182:
	xorl	%ebp, %ebp
	cmpq	$0, 32(%rbx)
	sete	%bpl
	jmp	.L1183
.L1447:
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	xorl	%eax, %eax
	movq	%r14, %rdi
	call	fprintf@PLT
	testl	%r12d, %r12d
	jle	.L1441
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
.L1441:
	movl	32(%rsp), %edx
	movq	%r14, %rdi
	leaq	.LC156(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC137(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1276
.L1453:
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 8(%rsp)
	testq	%rbp, %rbp
	jne	.L1176
.L1177:
	xorl	%edx, %edx
	jmp	.L1281
.L1452:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC140(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1191
.L1451:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC143(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1443
.L1237:
	movq	%r14, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1211
.L1448:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC139(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	jne	.L1201
	jmp	.L1211
.L1445:
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC147(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r12d
	testl	%eax, %eax
	je	.L1245
	movq	%r14, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	leaq	.LC115(%rip), %rax
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ebp
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC149(%rip), %rdx
	movl	$64, %esi
	movl	%ebp, %ecx
	call	snprintf@PLT
	movl	%ebp, %edx
	leaq	.LC150(%rip), %rsi
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
	leaq	.LC151(%rip), %rax
	movq	%rax, %rsi
	movq	%rax, 64(%rsp)
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%eax, %eax
	movl	%ebp, %edx
	leaq	.LC158(%rip), %rsi
	movq	%r14, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r15)
	leal	2(%rax), %ebx
	jne	.L1290
	cmpl	$1, %ebx
	je	.L1253
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1441
	.p2align 4,,10
	.p2align 3
.L1454:
	xorl	%edx, %edx
	leaq	.LC157(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%r12), %r15d
	jmp	.L1283
	.cfi_endproc
.LFE57:
	.size	emit_stmt, .-emit_stmt
	.section	.rodata.str1.1
.LC159:
	.string	"%s:\n"
	.text
	.p2align 4
	.type	emit_stmt_switchctx, @function
emit_stmt_switchctx:
.LFB45:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.L1460(%rip), %r15
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
	je	.L1455
.L1456:
	cmpl	$13, 0(%r13)
	ja	.L1458
	movl	0(%r13), %eax
	movslq	(%r15,%rax,4), %rax
	addq	%r15, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1460:
	.long	.L1458-.L1460
	.long	.L1464-.L1460
	.long	.L1458-.L1460
	.long	.L1463-.L1460
	.long	.L1462-.L1460
	.long	.L1458-.L1460
	.long	.L1458-.L1460
	.long	.L1458-.L1460
	.long	.L1458-.L1460
	.long	.L1458-.L1460
	.long	.L1458-.L1460
	.long	.L1461-.L1460
	.long	.L1458-.L1460
	.long	.L1459-.L1460
	.text
	.p2align 4,,10
	.p2align 3
.L1458:
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
.L1459:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1508
	xorl	%eax, %eax
	jmp	.L1478
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1477:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1508
.L1478:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%r13, (%rdx)
	jne	.L1477
	movq	8(%rdx), %r14
.L1476:
	xorl	%r13d, %r13d
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1542
	.p2align 4
	.p2align 3
.L1479:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1479
	movq	%r14, %rdx
	leaq	.LC159(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1482:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jle	.L1482
.L1481:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	jmp	.L1541
	.p2align 4,,10
	.p2align 3
.L1461:
	xorl	%r14d, %r14d
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1543
	.p2align 4
	.p2align 3
.L1465:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1465
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L1544
.L1466:
	movq	function_labels(%rip), %r14
	xorl	%r12d, %r12d
	jmp	.L1486
	.p2align 4,,10
	.p2align 3
.L1484:
	addq	$1, %r12
	cmpq	%r12, 24(%rsp)
	je	.L1467
.L1486:
	movq	(%r14,%r12,8), %rsi
	movq	16(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1484
	leal	1(%r12), %edx
.L1485:
	leaq	.LC157(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	leaq	.LC38(%rip), %r12
	movl	%eax, 16(%rsp)
	testl	%eax, %eax
	jle	.L1545
.L1487:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1489:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, %ebp
	jne	.L1489
	movl	16(%rsp), %ebp
.L1490:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	jne	.L1456
	jmp	.L1455
	.p2align 4,,10
	.p2align 3
.L1462:
	xorl	%r14d, %r14d
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1502
	.p2align 4
	.p2align 3
.L1468:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1468
.L1502:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC131(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC132(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	je	.L1455
.L1469:
	xorl	%eax, %eax
	cmpl	$1, 0(%r13)
	setne	%al
	addl	%eax, %ebp
	jmp	.L1456
	.p2align 4,,10
	.p2align 3
.L1463:
	xorl	%r14d, %r14d
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1497
	.p2align 4
	.p2align 3
.L1471:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1471
.L1497:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC133(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC132(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %rsi
	testq	%rsi, %rsi
	je	.L1473
	cmpl	$1, (%rsi)
	movl	%ebp, %edx
	je	.L1498
.L1473:
	leal	1(%rbp), %edx
.L1498:
	movq	(%rsp), %r8
	movq	8(%rsp), %rcx
	movq	%rbx, %rdi
	call	emit_stmt_switchctx
	cmpq	$0, 32(%r13)
	je	.L1455
	xorl	%r14d, %r14d
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1501
	.p2align 4
	.p2align 3
.L1499:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1499
.L1501:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC142(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r13), %r13
	testq	%r13, %r13
	jne	.L1469
.L1455:
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
.L1464:
	.cfi_restore_state
	xorl	%r15d, %r15d
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1546
	.p2align 4
	.p2align 3
.L1474:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebp, %r15d
	jne	.L1474
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC139(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	je	.L1492
.L1491:
	leal	1(%rbp), %r12d
	xorl	%r15d, %r15d
.L1494:
	movq	16(%r13), %rax
	movq	(%rsp), %r8
	movl	%r12d, %edx
	movq	%rbx, %rdi
	movq	8(%rsp), %rcx
	movq	(%rax,%r15,8), %rsi
	addq	$1, %r15
	call	emit_stmt_switchctx
	cmpq	24(%r13), %r15
	jb	.L1494
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1493
.L1492:
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1496:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1496
.L1493:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
.L1541:
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
.L1508:
	.cfi_restore_state
	xorl	%r14d, %r14d
	jmp	.L1476
	.p2align 4,,10
	.p2align 3
.L1543:
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	jne	.L1466
	.p2align 4
	.p2align 3
.L1467:
	xorl	%edx, %edx
	jmp	.L1485
.L1544:
	xorl	%edx, %edx
	leaq	.LC157(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	movl	%eax, 16(%rsp)
	jmp	.L1487
	.p2align 4,,10
	.p2align 3
.L1542:
	xorl	%eax, %eax
	movq	%r14, %rdx
	leaq	.LC159(%rip), %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	testl	%ebp, %ebp
	jne	.L1481
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	jmp	.L1481
	.p2align 4,,10
	.p2align 3
.L1545:
	movl	%eax, %ebp
	jmp	.L1490
	.p2align 4,,10
	.p2align 3
.L1546:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC139(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	jne	.L1491
	jmp	.L1493
	.cfi_endproc
.LFE45:
	.size	emit_stmt_switchctx, .-emit_stmt_switchctx
	.section	.rodata.str1.1
.LC160:
	.string	"static "
.LC161:
	.string	""
	.section	.rodata.str1.8
	.align 8
.LC162:
	.string	"#ifndef %s\nextern word %s[];\n#define __b_external_%s (%s[0])\n#else\n#define __b_external_%s (%s)\n#endif\n"
	.section	.rodata.str1.1
.LC163:
	.string	"extern word %s[];\n"
.LC164:
	.string	"%sword %s[%zu];\n"
.LC165:
	.string	"static word __%s_store[%zu];\n"
	.text
	.p2align 4
	.type	emit_global_declarations, @function
emit_global_declarations:
.LFB62:
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
	je	.L1547
	movq	%rdi, %rbp
	movq	%rsi, %r12
	xorl	%ebx, %ebx
	jmp	.L1561
	.p2align 4,,10
	.p2align 3
.L1550:
	addq	$1, %rbx
	cmpq	8(%r12), %rbx
	jnb	.L1547
.L1561:
	movq	(%r12), %rax
	movq	(%rax,%rbx,8), %r14
	movl	(%r14), %eax
	testl	%eax, %eax
	je	.L1579
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L1550
	movq	8(%r14), %r13
	movq	16(%r13), %rdi
	call	get_mangled_name
	cmpl	$3, (%r14)
	movq	%rax, %r15
	je	.L1580
	cmpl	$1, 24(%r13)
	movl	$1, %r8d
	jne	.L1555
	movq	56(%r13), %rdi
	movl	$1, %r11d
	testq	%rdi, %rdi
	je	.L1556
	cmpl	$1, (%rdi)
	je	.L1581
.L1556:
	call	edge_tail_words_top
	leaq	(%rax,%r11), %r8
	movl	$1, %eax
	testq	%r8, %r8
	cmove	%rax, %r8
.L1555:
	movl	4(%r13), %eax
	leaq	.LC161(%rip), %rdx
	testl	%eax, %eax
	je	.L1557
	leaq	.LC160(%rip), %rdx
.L1557:
	xorl	%eax, %eax
	movq	%r15, %rcx
	leaq	.LC164(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$2, 24(%r13)
	jne	.L1550
	movq	56(%r13), %rdi
	xorl	%r11d, %r11d
	testq	%rdi, %rdi
	je	.L1558
	cmpl	$1, (%rdi)
	je	.L1582
.L1558:
	cmpq	$0, 32(%r13)
	je	.L1559
	movq	48(%r13), %rax
	movq	%r11, %rdx
	cmpq	%rax, %r11
	cmovb	%rax, %r11
	testq	%rax, %rax
	cmovle	%rdx, %r11
.L1559:
	call	edge_tail_words_top
	movq	%r15, %rdx
	leaq	.LC165(%rip), %rsi
	movq	%rbp, %rdi
	leaq	(%rax,%r11), %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	xorl	%eax, %eax
	addq	$1, %rbx
	call	fprintf@PLT
	cmpq	8(%r12), %rbx
	jb	.L1561
.L1547:
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
.L1579:
	.cfi_restore_state
	movq	8(%r14), %rsi
	movq	(%rsp), %r8
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbp, %rdi
	call	emit_stmt
	jmp	.L1550
	.p2align 4,,10
	.p2align 3
.L1580:
	movq	16(%r13), %rdx
	movq	%rdx, %rdi
	movq	%rdx, 8(%rsp)
	call	global_data_kind
	testl	%eax, %eax
	je	.L1550
	movl	8(%r13), %esi
	testl	%esi, %esi
	je	.L1554
	movq	8(%rsp), %rdx
	movq	%r15, %rcx
	movq	%r15, %r9
	movq	%r15, %r8
	leaq	.LC162(%rip), %rsi
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
	jmp	.L1550
	.p2align 4,,10
	.p2align 3
.L1581:
	movq	24(%rdi), %r11
	jmp	.L1556
	.p2align 4,,10
	.p2align 3
.L1554:
	movq	%r15, %rdx
	leaq	.LC163(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1550
.L1582:
	movq	24(%rdi), %r11
	jmp	.L1558
	.cfi_endproc
.LFE62:
	.size	emit_global_declarations, .-emit_global_declarations
	.section	.rodata.str1.1
.LC166:
	.string	"{\n    B_FRAME;\n"
	.section	.rodata.str1.8
	.align 8
.LC167:
	.string	"    (void)B_LOCAL_PTR_N(&%s, sizeof(%s));\n"
	.align 8
.LC168:
	.string	"    static word __b_label_value_%zu = %zu;\n"
	.section	.rodata.str1.1
.LC169:
	.string	"    return 0;\n}\n"
	.text
	.p2align 4
	.type	emit_function_body, @function
emit_function_body:
.LFB58:
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
	leaq	.LC166(%rip), %rdi
	call	fwrite@PLT
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L1596
.L1584:
	cmpl	$16, current_word_bits(%rip)
	je	.L1597
.L1588:
	cmpq	$0, 8+function_labels(%rip)
	je	.L1590
	xorl	%ebx, %ebx
	leaq	.LC168(%rip), %r14
	.p2align 4
	.p2align 3
.L1591:
	addq	$1, %rbx
	xorl	%eax, %eax
	movq	%r14, %rsi
	movq	%rbp, %rdi
	movq	%rbx, %rcx
	movq	%rbx, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %rbx
	jb	.L1591
.L1590:
	movq	32(%r12), %rsi
	movq	%r13, %r8
	movq	%rbp, %rdi
	movl	$1, %ecx
	movl	$1, %edx
	call	emit_stmt
	movq	%rbp, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC169(%rip), %rdi
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
.L1597:
	.cfi_restore_state
	cmpq	$0, 16(%r12)
	je	.L1588
	xorl	%r14d, %r14d
	leaq	.LC167(%rip), %rbx
	.p2align 4
	.p2align 3
.L1589:
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
	jb	.L1589
	jmp	.L1588
	.p2align 4,,10
	.p2align 3
.L1596:
	movq	32(%r12), %rdi
	pxor	%xmm0, %xmm0
	movq	%rsp, %rsi
	movq	$0, 16(%rsp)
	movaps	%xmm0, (%rsp)
	call	collect_function_autos
	cmpq	$0, 8(%rsp)
	je	.L1585
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1586:
	movq	(%rsp), %rax
	movq	%r13, %rcx
	movl	$1, %edx
	movq	%rbp, %rdi
	movq	(%rax,%rbx,8), %rsi
	addq	$1, %rbx
	call	emit_auto_storage
	cmpq	8(%rsp), %rbx
	jb	.L1586
.L1585:
	cmpq	$0, g_compilation_arena(%rip)
	jne	.L1584
	movq	(%rsp), %rdi
	call	free@PLT
	jmp	.L1584
	.cfi_endproc
.LFE58:
	.size	emit_function_body, .-emit_function_body
	.section	.rodata.str1.1
.LC170:
	.string	"#define BCC_USE_CURSES 1\n"
	.section	.rodata.str1.8
	.align 8
.LC171:
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
.LC172:
	.string	"#define __bcc_strict_runtime %d\n"
	.section	.rodata.str1.1
.LC173:
	.string	"#define B_BYTEPTR %d\n"
.LC174:
	.string	"#define WORD_BITS %d\n"
	.section	.rodata.str1.8
	.align 8
.LC175:
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
.LC176:
	.string	"%s/btarget.h"
	.section	.rodata.str1.8
	.align 8
.LC177:
	.string	"#define B_TARGET_DEFINE\n#define B_TARGET_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC178:
	.string	"%s/binit.h"
	.section	.rodata.str1.8
	.align 8
.LC179:
	.string	"#define B_INIT_DEFINE\n#define B_INIT_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC180:
	.string	"%s/bunix.h"
	.section	.rodata.str1.8
	.align 8
.LC181:
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
	.ascii	"c(word nwords){\n    size_t bytes = (size_t)nwords * sizeof("
	.ascii	"word);\n    void *p = malloc(bytes);\n    if (!p) { fprintf("
	.ascii	"stderr, \"alloc: out of memory\\n\"); exit(1); }\n    return"
	.ascii	" B_PTR_N(p, bytes);\n}\n\n/* Host B runtime functions and co"
	.ascii	"mpatibility helpers */\n/* String manipulation functions */\n"
	.ascii	"static inline word b_load(word addr){ return B_DEREF(addr); "
	.ascii	"}\nstatic inline void b_store(word addr, word v){ B_DEREF(ad"
	.ascii	"dr) = WVAL(v);\n}\n\n/* B string access - byte packing withi"
	.ascii	"n words.\n *\n * In B_BYTEPTR=0 mode, bytes are packed into "
	.ascii	"words with byte 0 at the LSB.\n * This matches PDP-11 (littl"
	.ascii	"e-en"
	.ascii	"dian) conventions. The shift-based approach\n * operates on "
	.ascii	"word VALUES (not memory layout), making it consistent across"
	.ascii	"\n * architectures: char(s,0) always returns the least-signi"
	.ascii	"ficant byte of the\n * word at address s, regardless of host"
	.ascii	" endianness.\n *\n * Note: This only works correctly when AL"
	.ascii	"L byte access goes through char()/lchar().\n * Mixing direct"
	.ascii	" memory access (like C's *(char*)ptr) with B word operations"
	.ascii	" will\n * give different results on big-endian hosts.\n */\n"
	.ascii	"static word b_char(word s, word i){\n#if B_BYTEPTR && WORD_B"
	.ascii	"ITS != 16\n    const unsigned char *p = (const unsigned char"
	.ascii	"*)B_CPTR(s);\n    return (word)p[(size_t)i];\n#else\n    con"
	.ascii	"st uword W = (uword)B_WORD_BYTES;\n    uword wi = (uword)i /"
	.ascii	" W;\n    uword bi = (uword)i % W;\n    uword w  = (uword)B_I"
	.ascii	"NDEX(s, wi);\n    return (word)((w >> (bi * 8)) & 0xFF);\n#e"
	.ascii	"ndif\n}\n\nstatic word b_lchar(word s, word i, word c){\n#if"
	.ascii	" B_BYTEPTR && WORD_BITS != 16\n    unsigned char *p = (unsig"
	.ascii	"ned char*)B_CPTR(s);\n    p[(size_t)i] = (unsigned char)(c &"
	.ascii	" 0xFF);\n    return c;\n#else\n    const uword W = (uword)B_"
	.ascii	"WORD_BYTES;\n    uword wi = (uword)i / W;\n    uword bi = (u"
	.ascii	"word)i % W;\n\n    word addr = B_ADDR(B_INDEX(s, wi));\n    "
	.ascii	"uword w   = (uword)b_load(addr);\n\n    uword mask = (uword)"
	.ascii	"0xFF << (bi * 8);\n    w = (w & ~mask) | (((uword)c & 0xFF) "
	.ascii	"<< (bi * 8));\n\n    b_store(addr, (word)w);\n    return c;\n"
	.ascii	"#endif\n}\n\n/* Command line argument support implementation"
	.ascii	" */\nstatic word __b_pack_cstr(const char *s){\n    size_t n"
	.ascii	" = strlen(s);                 /* bytes, excluding NUL */\n  "
	.ascii	"  size_t W = B_WORD_BYTES;              /* bytes per word */"
	.ascii	"\n    size_t total = n + 1;                 /* +1 for 004 te"
	.ascii	"rminator */\n    size_t words = (total + W - 1) / W;\n\n    "
	.ascii	"word bp = b_alloc((word)words);       /* B pointer to word s"
	.ascii	"torage */\n\n    /* write bytes into the B string using lcha"
	.ascii	"r (handles packing for B_BYTEPTR=0) */\n    for (size_t i = "
	.ascii	"0; i < n; i++){\n        b_lchar(bp, (word)i, (word)(unsigne"
	.ascii	"d char)s[i]);\n    }\n    b_lchar(bp, (word)n, (word)004);\n"
	.ascii	"    return bp;\n}"
	.ascii	"\n\nstatic void __b_bstr_to_cstr(word s, char *buf, size_t m"
	.ascii	"ax){\n    size_t i = 0;\n    while (i + 1 < max) {\n        "
	.ascii	"word ch = b_char(s, (word)i);\n        if (ch == 004 || ch ="
	.ascii	"= 0) break;\n        buf[i++] = (char)(ch & 0xFF);\n    }\n "
	.ascii	"   buf[i] = 0;\n}\n\n/* Convert a B string (004-terminated) "
	.ascii	"into a temporary NUL-terminated C string */\nstatic const ch"
	.ascii	"ar *__b_cstr(word s){\n    static char *slots[4];\n    stati"
	.ascii	"c size_t caps[4];\n    static int next = 0;\n\n    if (s == "
	.ascii	"0) return \"\";\n\n    size_t len = 0;\n    for (;; len++) {"
	.ascii	"\n        word ch = b_char(s, (word)len);\n        if (ch =="
	.ascii	" 004 || ch == 0) break;\n    }\n\n    int idx = next;\n    n"
	.ascii	"ext = (next + 1) & 3; /* simple ring buffer to survive multi"
	.ascii	"ple args */\n\n    size_t need = len + 1;\n    if (need > ca"
	.ascii	"ps[idx]) {\n        size_t ncap = need < 64 ? 64 : need;\n  "
	.ascii	"      char *nb = (char*)realloc(slots[idx], ncap);\n        "
	.ascii	"if (!nb) { fprintf(stderr, \"cstr: out of memory\\n\"); exit"
	.ascii	"(1); }\n        slots[idx] = nb;\n        caps[idx] = ncap;\n"
	.ascii	"    }\n\n    for (size_t i = 0; i < len; i++) slots[idx][i] "
	.ascii	"= (char)(b_char(s, (word)i) & 0xFF);\n    slots[idx][len] = "
	.ascii	"0;\n    return slots[idx];\n}\n\n/* Duplicate a B string int"
	.ascii	"o a freshly allocated C string */\nstatic char *__b_dup_bstr"
	.ascii	"(word s){\n    size_t cap = 64;\n    char *buf = (char*)mall"
	.ascii	"oc(cap);\n    if (!buf) { fprintf(stderr, \"system: out of m"
	.ascii	"emory\\n\"); exit(1); }\n\n    size_t i = 0;\n    for (;;) {"
	.ascii	"\n        word ch = b_char(s, (word)i);\n        if (ch == 0"
	.ascii	"04 || ch == 0) break;\n        if (i + 1 >= cap) {\n        "
	.ascii	"    size_t ncap = cap * 2;\n            char *nbuf = (char*)"
	.ascii	"realloc(buf, ncap);\n            if (!nbuf) { free(buf); fpr"
	.ascii	"intf(stderr, \"system: out of memory\\n\"); exit(1); }\n    "
	.ascii	"        buf = nbuf;\n            cap = ncap;\n        }\n   "
	.ascii	"     buf[i++] = (char)(ch & 0xFF);\n    }\n    buf[i] = 0;\n"
	.ascii	"    return buf;\n}\n\nstatic void __b_setargs(int argc, char"
	.ascii	" **argv){\n    __b_argc = argc;\n    __b_argv = argv;\n\n   "
	.ascii	" __b_argvb = (word*)malloc(sizeof(word) * ((size_t)argc + 1)"
	.ascii	");\n    if (!__b_argvb) { fprintf(stderr,"
	.ascii	" \"argv: out of memory\\n\"); exit(1); }\n\n    word *vector"
	.ascii	" = (word*)malloc(sizeof(word) * ((size_t)argc + 1));\n    if"
	.ascii	" (!vector) { fprintf(stderr, \"argv: out of memory\\n\"); ex"
	.ascii	"it(1); }\n    vector[0] = WVAL(argc);\n    for (int i = 0; i"
	.ascii	" < argc; i++){\n        __b_argvb[i] = __b_pack_cstr(argv[i]"
	.ascii	");\n        vector[i+1] = __b_pack_cstr(argv[i]);\n        b"
	.ascii	"_lchar(vector[i+1], (word)strlen(argv[i]), 0);\n    }\n    b"
	.ascii	"_argv_vector = B_PTR_N(vector, sizeof(word) * ((size_t)argc "
	.ascii	"+ 1));\n}\nstatic word __b_argvalues(void) {\n    return __b"
	.ascii	"_argc ? B_PTR_N(__b_argvb, sizeof(word) * (size_t)__b_argc) "
	.ascii	": 0;\n}\n\nstatic word b_argc(void) { return (word)__b_argc;"
	.ascii	" }\n\nstatic word b_argv(word i) {\n    int idx = (int)i;\n "
	.ascii	"   if (idx < 0 || idx >= __b_argc) return 0;\n    return __b"
	.ascii	"_argvb[idx];\n}\n\nstatic word b_reread(void) {\n    /* If n"
	.ascii	"o args, nothing to reread */\n    if (__b_argc <= 1) {\n    "
	.ascii	"    return 0;\n    }\n\n    /* Compute total length of joine"
	.ascii	"d argv[0..] with spaces + newline */\n    size_t total = 1; "
	.ascii	"/* for trailing newline */\n    for (int i = 0; i < __b_argc"
	.ascii	"; i++) {\n        total += strlen(__b_argv[i]);\n        if "
	.ascii	"(i + 1 < __b_argc) total += 1; /* space */\n    }\n    \n   "
	.ascii	" char *buf = (char*)malloc(total + 1);\n    if (!buf) { fpri"
	.ascii	"ntf(stderr, \"reread: out of memory\\n\"); exit(1); }\n    \n"
	.ascii	"    size_t pos = 0;\n    for (int i = 0; i < __b_argc; i++) "
	.ascii	"{\n        size_t len = strlen(__b_argv[i]);\n        memcpy"
	.ascii	"(buf + pos, __b_argv[i], len);\n        pos += len;\n       "
	.ascii	" if (i + 1 < __b_argc) buf[pos++] = ' ';\n    }\n    buf[pos"
	.ascii	"++] = '\\n';\n    buf[pos] = '\\0';\n    \n    int p[2];\n  "
	.ascii	"  if (pipe(p) != 0) { free(buf); fprintf(stderr, \"reread: p"
	.ascii	"ipe failed\\n\"); exit(1); }\n    ssize_t wn = write(p[1], b"
	.ascii	"uf, pos);\n    (void)wn;\n    close(p[1]);\n    free(buf);\n"
	.ascii	"    \n    /* Close previous rd fd if it wasn't the terminal "
	.ascii	"*/\n    if (rd_fd != 0 && rd_fd != p[0]) close(rd_fd);\n    "
	.ascii	"rd_fd = p[0];\n    rd_unit = (word)0;\n    __b_sync_rd();\n "
	.ascii	"   return 0;\n}\n\n/* I/O functions */\nstatic word b_getchr"
	.ascii	"(void) {\n    __b_sync_rd();\n    unsigne"
	.ascii	"d char c;\n    ssize_t n = read(rd_fd, &c, 1);\n    if (n =="
	.ascii	" 1) return (word)c;\n    if (rd_fd != 0) {\n        close(rd"
	.ascii	"_fd);\n        rd_fd = 0;\n        rd_unit = -1;\n        re"
	.ascii	"turn b_getchr();\n    }\n    return (word)004; /* Return *e "
	.ascii	"on EOF */\n}\nstatic word b_putchr(word w) {\n    __b_sync_w"
	.ascii	"r();\n    unsigned char c = (unsigned char)(w & 0xFF);\n    "
	.ascii	"(void)write(wr_fd, &c, 1);\n    return w;\n}\nstatic word b_"
	.ascii	"putstr(word s) {\n    __b_sync_wr();\n    word i = 0;\n    f"
	.ascii	"or (;;) {\n        word ch = b_char(s, i++);\n        if (ch"
	.ascii	" == 004 || (!__bcc_strict_runtime && ch == 0)) break;\n     "
	.ascii	"   b_putchar(ch);\n    }\n    return s;\n}\nstatic word b_ge"
	.ascii	"tstr(word buf) {\n    __b_sync_rd();\n    size_t i = 0;\n   "
	.ascii	" unsigned char c;\n    for (;;) {\n        ssize_t n = read("
	.ascii	"rd_fd, &c, 1);\n        if (n == 1 && c != '\\n' && c != '\\"
	.ascii	"r') {\n            b_lchar(buf, (word)i, (word)c);\n        "
	.ascii	"    i++;\n            continue;\n        }\n        if (n =="
	.ascii	" 1) break; /* newline */\n        if (rd_fd != 0) {\n       "
	.ascii	"     close(rd_fd);\n            rd_fd = 0;\n            rd_u"
	.ascii	"nit = -1;\n            continue; /* retry on terminal */\n  "
	.ascii	"      }\n  "
	.string	"      break; /* EOF */\n    }\n    b_lchar(buf, (word)i, (word)004);\n    return buf;\n}\nstatic word b_flush(void){\n    __b_sync_wr();\n    if (wr_fd == 1) {\n        fflush(stdout);\n    } else {\n        fsync(wr_fd);\n    }\n    return 0;\n}\n\n#include <stdarg.h>\n\n"
	.section	.rodata.str1.1
.LC182:
	.string	"%s/bformat.h"
	.section	.rodata.str1.8
	.align 8
.LC183:
	.string	"#define __bcc_format_linkage static\n"
	.align 8
.LC184:
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
.LC185:
	.string	"word __b_user_main("
	.section	.rodata.str1.8
	.align 8
.LC186:
	.string	"int main(int argc, char **argv){\n"
	.section	.rodata.str1.1
.LC187:
	.string	"    __b_setargs(argc, argv);\n"
.LC188:
	.string	"    __b_init();\n"
	.section	.rodata.str1.8
	.align 8
.LC189:
	.string	"    return (int)__b_user_main();\n"
	.align 8
.LC190:
	.string	"    return (int)__b_user_main((word)argc);\n"
	.align 8
.LC191:
	.string	"    return (int)__b_user_main((word)argc, __b_argvalues());\n"
	.text
	.p2align 4
	.globl	emit_program_c
	.type	emit_program_c, @function
emit_program_c:
.LFB64:
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
	jne	.L1631
.L1599:
	movq	%rbx, %rcx
	movl	$1529, %edx
	movl	$1, %esi
	leaq	.LC171(%rip), %rdi
	call	fwrite@PLT
	movl	g_strict(%rip), %ecx
	xorl	%edx, %edx
	movq	%rbx, %rdi
	leaq	.LC172(%rip), %rsi
	testl	%ecx, %ecx
	setne	%dl
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbx, %rdi
	setne	%dl
	leaq	.LC173(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%ebp, %edx
	leaq	.LC174(%rip), %rsi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	leaq	40(%rsp), %rbp
	call	fprintf@PLT
	movq	%rbx, %rcx
	movl	$1441, %edx
	movl	$1, %esi
	leaq	.LC175(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC176(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$73, %edx
	movl	$1, %esi
	leaq	.LC177(%rip), %rdi
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
	leaq	.LC178(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC179(%rip), %rdi
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
	leaq	.LC180(%rip), %rdi
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
	movl	$11360, %edx
	movl	$1, %esi
	leaq	.LC181(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC182(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$36, %edx
	movl	$1, %esi
	leaq	.LC183(%rip), %rdi
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
	leaq	.LC184(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1632
.L1600:
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
	je	.L1598
	movq	$0, 24(%rsp)
	xorl	%ebp, %ebp
	movl	$0, 20(%rsp)
	.p2align 5
	.p2align 4
	.p2align 3
.L1610:
	movq	(%r12), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$1, (%rax)
	je	.L1633
.L1602:
	addq	$1, %rbp
	cmpq	8(%r12), %rbp
	jb	.L1610
	movl	20(%rsp), %eax
	testl	%eax, %eax
	jne	.L1634
.L1598:
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
.L1633:
	.cfi_restore_state
	movq	8(%rax), %r14
	leaq	.LC22(%rip), %rsi
	movq	(%r14), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1603
	leaq	.LC32(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1604
.L1603:
	movq	16(%r14), %rax
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC185(%rip), %rdi
	movq	%rax, 24(%rsp)
	call	fwrite@PLT
	movl	$1, 20(%rsp)
.L1605:
	cmpq	$0, 16(%r14)
	je	.L1607
	xorl	%r13d, %r13d
	leaq	.LC34(%rip), %r15
	jmp	.L1609
	.p2align 4,,10
	.p2align 3
.L1635:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
.L1609:
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r14), %rax
	movq	(%rax,%r13,8), %rdi
	testq	%rdi, %rdi
	je	.L1608
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1608:
	addq	$1, %r13
	cmpq	16(%r14), %r13
	jb	.L1635
.L1607:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC132(%rip), %rdi
	call	fwrite@PLT
	movq	8(%rsp), %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_function_body
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1602
	.p2align 4,,10
	.p2align 3
.L1634:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC186(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC187(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC188(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%rsp)
	je	.L1616
	cmpq	$1, 24(%rsp)
	je	.L1636
	cmpq	$2, 24(%rsp)
	jne	.L1616
	movq	%rbx, %rcx
	movl	$60, %edx
	movl	$1, %esi
	leaq	.LC191(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1614
	.p2align 4,,10
	.p2align 3
.L1632:
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1600
	.p2align 4,,10
	.p2align 3
.L1631:
	movq	%rbx, %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC170(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1599
	.p2align 4,,10
	.p2align 3
.L1616:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC189(%rip), %rdi
	call	fwrite@PLT
.L1614:
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
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
.L1604:
	.cfi_restore_state
	leaq	.LC34(%rip), %r15
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
	movq	(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1606
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1606:
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1605
.L1636:
	movq	%rbx, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC190(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1614
	.cfi_endproc
.LFE64:
	.size	emit_program_c, .-emit_program_c
	.section	.rodata.str1.8
	.align 8
.LC192:
	.string	"/* Generated by BCC - B Compiler */\n"
	.section	.rodata.str1.1
.LC193:
	.string	"#include \"libb.h\"\n\n"
	.section	.rodata.str1.8
	.align 8
.LC194:
	.string	"#include <ncurses.h>\n#include <panel.h>\n\n"
	.text
	.p2align 4
	.globl	emit_program_c_ext
	.type	emit_program_c_ext, @function
emit_program_c_ext:
.LFB65:
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
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movl	%r9d, %ebx
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movl	96(%rsp), %edi
	movq	%rdx, 8(%rsp)
	testl	%edi, %edi
	je	.L1671
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
	movq	%rbp, %rcx
	movl	$36, %edx
	movl	$1, %esi
	leaq	.LC192(%rip), %rdi
	call	fwrite@PLT
	movl	g_strict(%rip), %ecx
	xorl	%edx, %edx
	movq	%rbp, %rdi
	leaq	.LC172(%rip), %rsi
	testl	%ecx, %ecx
	setne	%dl
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbp, %rdi
	setne	%dl
	leaq	.LC173(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%ebx, %edx
	leaq	.LC174(%rip), %rsi
	xorl	%eax, %eax
	movq	%rbp, %rdi
	call	fprintf@PLT
	movl	$1, %esi
	movq	%rbp, %rcx
	movl	$19, %edx
	leaq	.LC193(%rip), %rdi
	call	fwrite@PLT
	movl	g_use_curses(%rip), %esi
	testl	%esi, %esi
	jne	.L1672
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1673
.L1640:
	movq	%r12, %rsi
	movq	%rbp, %rdi
	call	emit_function_prototypes
	movq	8(%rsp), %rbx
	movq	%r12, %rsi
	movq	%rbp, %rdi
	movq	%rbx, %rdx
	call	emit_global_declarations
	movq	%rbx, %rdx
	movq	%r12, %rsi
	movq	%rbp, %rdi
	call	emit_global_initializers
	cmpq	$0, 8(%r12)
	je	.L1637
	movq	$0, 24(%rsp)
	xorl	%ebx, %ebx
	movl	$0, 20(%rsp)
	.p2align 5
	.p2align 4
	.p2align 3
.L1650:
	movq	(%r12), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$1, (%rax)
	je	.L1674
.L1642:
	addq	$1, %rbx
	cmpq	8(%r12), %rbx
	jb	.L1650
	movl	20(%rsp), %eax
	testl	%eax, %eax
	jne	.L1675
.L1637:
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
.L1673:
	.cfi_restore_state
	movq	%rbp, %rdi
	call	emit_string_pool
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1640
	.p2align 4,,10
	.p2align 3
.L1672:
	movq	%rbp, %rcx
	movl	$41, %edx
	movl	$1, %esi
	leaq	.LC194(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	je	.L1640
	jmp	.L1673
	.p2align 4,,10
	.p2align 3
.L1675:
	movq	%rbp, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC186(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC187(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC188(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%rsp)
	je	.L1656
	cmpq	$1, 24(%rsp)
	je	.L1676
	cmpq	$2, 24(%rsp)
	je	.L1677
.L1656:
	movq	%rbp, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC189(%rip), %rdi
	call	fwrite@PLT
.L1654:
	addq	$40, %rsp
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
.L1674:
	.cfi_restore_state
	movq	8(%rax), %r14
	leaq	.LC22(%rip), %rsi
	movq	(%r14), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1643
	leaq	.LC32(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1644
.L1643:
	movq	16(%r14), %rax
	movq	%rbp, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC185(%rip), %rdi
	movq	%rax, 24(%rsp)
	call	fwrite@PLT
	movl	$1, 20(%rsp)
.L1645:
	cmpq	$0, 16(%r14)
	je	.L1647
	xorl	%r13d, %r13d
	leaq	.LC34(%rip), %r15
	jmp	.L1649
	.p2align 4,,10
	.p2align 3
.L1678:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
.L1649:
	movq	%r15, %rdi
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r14), %rax
	movq	(%rax,%r13,8), %rdi
	testq	%rdi, %rdi
	je	.L1648
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1648:
	addq	$1, %r13
	cmpq	16(%r14), %r13
	jb	.L1678
.L1647:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC132(%rip), %rdi
	call	fwrite@PLT
	movq	8(%rsp), %rdx
	movq	%r14, %rsi
	movq	%rbp, %rdi
	call	emit_function_body
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1642
	.p2align 4,,10
	.p2align 3
.L1671:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rdi
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
.L1644:
	.cfi_restore_state
	leaq	.LC34(%rip), %r15
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
	movq	(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1646
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1646:
	movq	%rbp, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1645
.L1677:
	movq	%rbp, %rcx
	movl	$60, %edx
	movl	$1, %esi
	leaq	.LC191(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1654
.L1676:
	movq	%rbp, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC190(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1654
	.cfi_endproc
.LFE65:
	.size	emit_program_c_ext, .-emit_program_c_ext
	.section	.rodata
	.align 16
	.type	CSWTCH.169, @object
	.size	CSWTCH.169, 24
CSWTCH.169:
	.long	24
	.long	25
	.long	26
	.long	27
	.long	22
	.long	23
	.section	.rodata.str1.1
.LC195:
	.string	"lchar"
.LC196:
	.string	"getchar"
.LC197:
	.string	"getchr"
.LC198:
	.string	"putchr"
.LC199:
	.string	"getstr"
.LC200:
	.string	"putstr"
.LC201:
	.string	"flush"
.LC202:
	.string	"reread"
.LC203:
	.string	"printn"
.LC204:
	.string	"putnum"
.LC205:
	.string	"print"
.LC206:
	.string	"putchar"
.LC207:
	.string	"abort"
.LC208:
	.string	"free"
.LC209:
	.string	"alloc"
.LC210:
	.string	"open"
.LC211:
	.string	"close"
.LC212:
	.string	"read"
.LC213:
	.string	"write"
.LC214:
	.string	"creat"
.LC215:
	.string	"seek"
.LC216:
	.string	"openr"
.LC217:
	.string	"openw"
.LC218:
	.string	"fork"
.LC219:
	.string	"wait"
.LC220:
	.string	"execl"
.LC221:
	.string	"execv"
.LC222:
	.string	"chdir"
.LC223:
	.string	"chmod"
.LC224:
	.string	"chown"
.LC225:
	.string	"link"
.LC226:
	.string	"unlink"
.LC227:
	.string	"stat"
.LC228:
	.string	"fstat"
.LC229:
	.string	"time"
.LC230:
	.string	"ctime"
.LC231:
	.string	"getuid"
.LC232:
	.string	"setuid"
.LC233:
	.string	"makdir"
.LC234:
	.string	"mkdir"
.LC235:
	.string	"intr"
.LC236:
	.string	"gtty"
.LC237:
	.string	"stty"
.LC238:
	.string	"system"
.LC239:
	.string	"usleep"
.LC240:
	.string	"argc"
	.section	.data.rel.ro.local,"aw"
	.align 32
	.type	names.0, @object
	.size	names.0, 416
names.0:
	.quad	.LC13
	.quad	.LC195
	.quad	.LC196
	.quad	.LC197
	.quad	.LC198
	.quad	.LC199
	.quad	.LC200
	.quad	.LC201
	.quad	.LC202
	.quad	.LC73
	.quad	.LC203
	.quad	.LC204
	.quad	.LC205
	.quad	.LC206
	.quad	.LC79
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
	.quad	.LC231
	.quad	.LC232
	.quad	.LC233
	.quad	.LC234
	.quad	.LC235
	.quad	.LC236
	.quad	.LC237
	.quad	.LC238
	.quad	.LC239
	.quad	.LC71
	.quad	.LC240
	.quad	.LC26
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
.LC241:
	.string	"break"
.LC242:
	.string	"case"
.LC243:
	.string	"const"
.LC244:
	.string	"continue"
.LC245:
	.string	"default"
.LC246:
	.string	"do"
.LC247:
	.string	"double"
.LC248:
	.string	"else"
.LC249:
	.string	"enum"
.LC250:
	.string	"extern"
.LC251:
	.string	"float"
.LC252:
	.string	"for"
.LC253:
	.string	"goto"
.LC254:
	.string	"if"
.LC255:
	.string	"inline"
.LC256:
	.string	"int"
.LC257:
	.string	"long"
.LC258:
	.string	"register"
.LC259:
	.string	"restrict"
.LC260:
	.string	"short"
.LC261:
	.string	"signed"
.LC262:
	.string	"sizeof"
.LC263:
	.string	"static"
.LC264:
	.string	"struct"
.LC265:
	.string	"switch"
.LC266:
	.string	"typedef"
.LC267:
	.string	"union"
.LC268:
	.string	"unsigned"
.LC269:
	.string	"void"
.LC270:
	.string	"volatile"
.LC271:
	.string	"while"
.LC272:
	.string	"_Bool"
.LC273:
	.string	"_Complex"
.LC274:
	.string	"_Imaginary"
.LC275:
	.string	"_Alignas"
.LC276:
	.string	"_Alignof"
.LC277:
	.string	"_Atomic"
.LC278:
	.string	"_Generic"
.LC279:
	.string	"_Noreturn"
.LC280:
	.string	"_Static_assert"
.LC281:
	.string	"_Thread_local"
.LC282:
	.string	"NULL"
.LC283:
	.string	"true"
.LC284:
	.string	"false"
.LC285:
	.string	"bool"
.LC286:
	.string	"B_PTR"
.LC287:
	.string	"B_ADDR"
.LC288:
	.string	"B_DEREF"
	.section	.data.rel.ro.local
	.align 32
	.type	c_keywords, @object
	.size	c_keywords, 424
c_keywords:
	.quad	.LC14
	.quad	.LC241
	.quad	.LC242
	.quad	.LC13
	.quad	.LC243
	.quad	.LC244
	.quad	.LC245
	.quad	.LC246
	.quad	.LC247
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
	.quad	.LC138
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
	.quad	.LC278
	.quad	.LC279
	.quad	.LC280
	.quad	.LC281
	.quad	.LC282
	.quad	.LC283
	.quad	.LC284
	.quad	.LC285
	.quad	.LC35
	.quad	.LC286
	.quad	.LC287
	.quad	.LC288
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
