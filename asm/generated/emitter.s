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
	.p2align 4
	.type	collect_cases, @function
collect_cases:
.LFB45:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	leaq	.L47(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
.L44:
	cmpl	$13, (%rbx)
	ja	.L42
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L47:
	.long	.L42-.L47
	.long	.L51-.L47
	.long	.L42-.L47
	.long	.L50-.L47
	.long	.L49-.L47
	.long	.L42-.L47
	.long	.L42-.L47
	.long	.L42-.L47
	.long	.L42-.L47
	.long	.L42-.L47
	.long	.L42-.L47
	.long	.L49-.L47
	.long	.L42-.L47
	.long	.L46-.L47
	.text
	.p2align 4,,10
	.p2align 3
.L51:
	xorl	%r12d, %r12d
	cmpq	$0, 24(%rbx)
	je	.L42
.L52:
	movq	16(%rbx), %rax
	movq	%rbp, %rsi
	movq	(%rax,%r12,8), %rdi
	addq	$1, %r12
	call	collect_cases
	cmpq	24(%rbx), %r12
	jb	.L52
.L42:
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
.L49:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L53:
	testq	%rbx, %rbx
	jne	.L44
	jmp	.L42
	.p2align 4,,10
	.p2align 3
.L46:
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
.L50:
	.cfi_restore_state
	movq	24(%rbx), %rdi
	movq	%rbp, %rsi
	call	collect_cases
	movq	32(%rbx), %rbx
	jmp	.L53
	.p2align 4,,10
	.p2align 3
.L64:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE45:
	.size	collect_cases, .-collect_cases
	.p2align 4
	.type	collect_function_labels, @function
collect_function_labels:
.LFB42:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L89
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L72(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L69:
	cmpl	$12, (%rbx)
	ja	.L67
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L72:
	.long	.L67-.L72
	.long	.L76-.L72
	.long	.L67-.L72
	.long	.L75-.L72
	.long	.L71-.L72
	.long	.L67-.L72
	.long	.L67-.L72
	.long	.L67-.L72
	.long	.L67-.L72
	.long	.L67-.L72
	.long	.L67-.L72
	.long	.L73-.L72
	.long	.L71-.L72
	.text
	.p2align 4,,10
	.p2align 3
.L76:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L67
.L77:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_function_labels
	cmpq	24(%rbx), %rbp
	jb	.L77
.L67:
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
.L71:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L78:
	testq	%rbx, %rbx
	jne	.L69
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
.L73:
	.cfi_restore_state
	movq	16(%rbx), %rsi
	leaq	function_labels(%rip), %rdi
	call	vec_push@PLT
	movq	24(%rbx), %rbx
	jmp	.L78
	.p2align 4,,10
	.p2align 3
.L75:
	movq	24(%rbx), %rdi
	call	collect_function_labels
	movq	32(%rbx), %rbx
	jmp	.L78
	.p2align 4,,10
	.p2align 3
.L89:
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
	je	.L120
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	leaq	.L98(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
.L95:
	cmpl	$12, (%rbx)
	ja	.L93
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L98:
	.long	.L93-.L98
	.long	.L103-.L98
	.long	.L102-.L98
	.long	.L101-.L98
	.long	.L99-.L98
	.long	.L93-.L98
	.long	.L93-.L98
	.long	.L93-.L98
	.long	.L93-.L98
	.long	.L93-.L98
	.long	.L93-.L98
	.long	.L99-.L98
	.long	.L99-.L98
	.text
	.p2align 4,,10
	.p2align 3
.L102:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L93
	.p2align 4
	.p2align 3
.L104:
	movq	16(%rbx), %rax
	movq	%r12, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	vec_push@PLT
	cmpq	24(%rbx), %rbp
	jb	.L104
.L93:
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
.L99:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L106:
	testq	%rbx, %rbx
	jne	.L95
	jmp	.L93
	.p2align 4,,10
	.p2align 3
.L101:
	movq	24(%rbx), %rdi
	movq	%r12, %rsi
	call	collect_function_autos
	movq	32(%rbx), %rbx
	jmp	.L106
	.p2align 4,,10
	.p2align 3
.L103:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L93
.L105:
	movq	16(%rbx), %rax
	movq	%r12, %rsi
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_function_autos
	cmpq	24(%rbx), %rbp
	jb	.L105
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L120:
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
	je	.L124
	movq	string_pool(%rip), %rsi
	xorl	%eax, %eax
	jmp	.L127
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L125:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L124
.L127:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%rbx, (%rdx)
	jne	.L125
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
.L124:
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
	je	.L137
	movq	%rdi, %r12
	movq	%rsi, %rbp
	xorl	%ebx, %ebx
.L136:
	movq	(%r12,%rbx,8), %rax
	testq	%rax, %rax
	je	.L135
	cmpl	$1, (%rax)
	je	.L143
.L135:
	addq	$1, %rbx
	cmpq	%rbp, %rbx
	jne	.L136
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
.L143:
	.cfi_restore_state
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r13
	jmp	.L135
	.p2align 4,,10
	.p2align 3
.L137:
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
.LC3:
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
	je	.L157
	movq	g_known_variables(%rip), %rbx
	xorl	%r12d, %r12d
	leaq	(%rbx,%rax,8), %r13
	.p2align 4
	.p2align 3
.L146:
	movq	(%rbx), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	addq	$8, %rbx
	movzbl	%al, %eax
	orl	%eax, %r12d
	cmpq	%rbx, %r13
	jne	.L146
.L145:
	movq	current_program(%rip), %r13
	testq	%r13, %r13
	je	.L147
	movq	8(%r13), %r14
	xorl	%ebx, %ebx
	jmp	.L148
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L149:
	addq	$1, %rbx
.L148:
	cmpq	%rbx, %r14
	je	.L147
	movq	0(%r13), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$2, (%rax)
	jne	.L149
	movq	8(%rax), %rax
	movq	%rbp, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L149
.L158:
	movl	$1, %r12d
.L144:
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
.L147:
	.cfi_restore_state
	movq	%rbp, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L159
	leaq	8+names.0(%rip), %rbx
	leaq	.LC3(%rip), %rsi
	jmp	.L153
	.p2align 4,,10
	.p2align 3
.L174:
	movq	(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L154
.L153:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L174
	cmpl	$1, %r12d
	jne	.L144
.L154:
	testq	%r13, %r13
	je	.L144
	movq	8(%r13), %r14
	testq	%r14, %r14
	je	.L144
	movq	0(%r13), %r13
	xorl	%ebx, %ebx
	jmp	.L156
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L155:
	addq	$1, %rbx
	cmpq	%r14, %rbx
	je	.L144
.L156:
	movq	0(%r13,%rbx,8), %rax
	cmpl	$3, (%rax)
	jne	.L155
	movq	8(%rax), %r15
	movq	%rbp, %rsi
	movq	16(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L155
	movl	8(%r15), %eax
	movl	$2, %r12d
	testl	%eax, %eax
	jne	.L144
	jmp	.L158
	.p2align 4,,10
	.p2align 3
.L159:
	xorl	%r12d, %r12d
	jmp	.L144
	.p2align 4,,10
	.p2align 3
.L157:
	xorl	%r12d, %r12d
	jmp	.L145
	.cfi_endproc
.LFE23:
	.size	global_data_kind, .-global_data_kind
	.section	.rodata.str1.1
.LC4:
	.string	"auto"
.LC5:
	.string	"__empty"
.LC6:
	.string	"%02X"
.LC7:
	.string	"_%02X"
.LC8:
	.string	"__bcc_user_%c_%s"
.LC9:
	.string	"%s_%d"
.LC10:
	.string	"__bcc_keyword_%s"
.LC11:
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
	je	.L216
	movq	8+name_map(%rip), %r13
	movq	%rdi, %rbx
	testq	%r13, %r13
	je	.L177
	movq	name_map(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L179
	.p2align 4,,10
	.p2align 3
.L178:
	addq	$1, %rbp
	cmpq	%r13, %rbp
	je	.L177
.L179:
	movq	(%r14,%rbp,8), %r12
	movq	%rbx, %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L178
	movq	8(%r12), %r13
.L175:
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
.L177:
	.cfi_restore_state
	cmpb	$0, (%rbx)
	je	.L249
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
	ja	.L182
	movabsq	$288230372997595135, %rsi
	btq	%rax, %rsi
	jnc	.L182
	movb	%dl, (%r12)
.L186:
	leaq	1(%rbx), %rbp
	leaq	(%rbx,%rcx), %r15
	movabsq	$288230372997595135, %r13
	cmpq	$1, %rcx
	ja	.L196
	jmp	.L188
	.p2align 4,,10
	.p2align 3
.L189:
	leal	-65(%rdx), %eax
	cmpb	$57, %al
	ja	.L192
	btq	%rax, %r13
	jnc	.L192
.L190:
	movb	%dl, (%r14)
	addq	$1, %r14
.L195:
	addq	$1, %rbp
	cmpq	%rbp, %r15
	je	.L188
.L196:
	movzbl	0(%rbp), %edx
	cmpb	$57, %dl
	jg	.L189
	cmpb	$47, %dl
	jg	.L190
	cmpb	$46, %dl
	jne	.L192
	addq	$1, %rbp
	movb	$95, (%r14)
	addq	$1, %r14
	cmpq	%rbp, %r15
	jne	.L196
.L188:
	movb	$0, (%r14)
	movl	g_strict(%rip), %edx
	testl	%edx, %edx
	je	.L250
.L197:
	movq	%r12, %rdi
	call	strlen@PLT
	leaq	14(%rax), %rdi
	call	xmalloc@PLT
	movl	$98, %edx
	movq	%rax, %r13
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L251
.L200:
	xorl	%eax, %eax
	movq	%r12, %rcx
	leaq	.LC8(%rip), %rsi
	movq	%r13, %rdi
	call	sprintf@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L252
.L215:
	leaq	8+c_keywords(%rip), %rbp
	leaq	.LC4(%rip), %rsi
	jmp	.L204
	.p2align 4,,10
	.p2align 3
.L253:
	movq	0(%rbp), %rsi
	addq	$8, %rbp
	testq	%rsi, %rsi
	je	.L205
.L204:
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L253
	movq	%r13, %rdi
	call	strlen@PLT
	leaq	15(%rax), %rdi
	call	xmalloc@PLT
	movq	%r13, %rdx
	leaq	.LC10(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %rbp
	xorl	%eax, %eax
	call	sprintf@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L254
.L214:
	movq	%rbp, %r13
.L205:
	movq	8+name_map(%rip), %r12
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
	testq	%r12, %r12
	je	.L206
	movq	name_map(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L208
	.p2align 4,,10
	.p2align 3
.L256:
	addq	$1, %rbp
	cmpq	%rbp, %r12
	je	.L255
.L208:
	movq	(%r14,%rbp,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L256
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
.L210:
	leal	1(%rcx), %eax
	movq	%r13, %rdx
	leaq	.LC9(%rip), %rsi
	movq	%r12, %rdi
	movl	%eax, 12(%rsp)
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	8+name_map(%rip), %rbp
	testq	%rbp, %rbp
	je	.L209
	movq	(%rsp), %rax
	xorl	%r15d, %r15d
	movq	(%rax), %r14
	jmp	.L211
	.p2align 4,,10
	.p2align 3
.L257:
	addq	$1, %r15
	cmpq	%rbp, %r15
	je	.L209
.L211:
	movq	(%r14,%r15,8), %rax
	movq	%r12, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L257
	movl	12(%rsp), %ecx
	jmp	.L210
	.p2align 4,,10
	.p2align 3
.L249:
	leaq	.LC5(%rip), %rdi
	call	sdup@PLT
	movl	g_strict(%rip), %edx
	movq	%rax, %r12
	testl	%edx, %edx
	jne	.L197
.L250:
	movq	%rbx, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L197
	leaq	8+names.0(%rip), %rbp
	leaq	.LC3(%rip), %rsi
	jmp	.L198
	.p2align 4,,10
	.p2align 3
.L259:
	movq	0(%rbp), %rsi
	addq	$8, %rbp
	testq	%rsi, %rsi
	je	.L258
.L198:
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L259
	jmp	.L197
	.p2align 4,,10
	.p2align 3
.L255:
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
.L206:
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
	jmp	.L175
.L182:
	movb	$95, (%r12)
	movzbl	(%rbx), %eax
	cmpb	$46, %al
	jne	.L260
	movb	$95, 1(%r12)
	leaq	2(%r12), %r14
	jmp	.L186
	.p2align 4,,10
	.p2align 3
.L192:
	movq	%r14, %rdi
	leaq	.LC7(%rip), %rsi
	xorl	%eax, %eax
	addq	$3, %r14
	call	sprintf@PLT
	jmp	.L195
	.p2align 4,,10
	.p2align 3
.L209:
	cmpq	$0, g_compilation_arena(%rip)
	je	.L261
.L212:
	movq	%r12, %r13
	jmp	.L206
	.p2align 4,,10
	.p2align 3
.L251:
	movq	%rbx, %rdi
	call	source_function
	movl	$102, %edx
	testl	%eax, %eax
	jne	.L200
	leaq	8+names.0(%rip), %rbp
	leaq	.LC3(%rip), %rsi
	jmp	.L201
	.p2align 4,,10
	.p2align 3
.L263:
	movq	0(%rbp), %rsi
	addq	$8, %rbp
	testq	%rsi, %rsi
	je	.L262
.L201:
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L263
	movl	$114, %edx
	jmp	.L200
.L216:
	xorl	%r13d, %r13d
	jmp	.L175
.L252:
	movq	%r12, %rdi
	call	free@PLT
	jmp	.L215
.L258:
	movl	$6, %edx
	leaq	.LC11(%rip), %rsi
	movq	%rbx, %rdi
	movq	%r12, %r13
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L215
	jmp	.L197
.L260:
	movzbl	%al, %edx
	movq	%r14, %rdi
	leaq	.LC6(%rip), %rsi
	xorl	%eax, %eax
	movq	%rcx, (%rsp)
	leaq	3(%r12), %r14
	call	sprintf@PLT
	movq	(%rsp), %rcx
	jmp	.L186
.L262:
	movl	$120, %edx
	jmp	.L200
.L261:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L212
.L254:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L214
	.cfi_endproc
.LFE24:
	.size	get_mangled_name, .-get_mangled_name
	.section	.rodata.str1.1
.LC12:
	.string	"main"
.LC13:
	.string	"__b_user_main"
.LC14:
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
	leaq	.LC12(%rip), %rsi
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
	jne	.L265
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movl	$13, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 16
	leaq	.LC13(%rip), %rdi
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L265:
	.cfi_restore_state
	movl	$1, %esi
	movl	$11, %edx
	leaq	.LC14(%rip), %rdi
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
.LC15:
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
	leaq	.LC12(%rip), %rsi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rbp, %rdi
	leaq	8+names.0(%rip), %rbx
	call	strcmp@PLT
	leaq	.LC3(%rip), %rsi
	testl	%eax, %eax
	jne	.L270
	jmp	.L277
	.p2align 4,,10
	.p2align 3
.L278:
	movq	(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L271
.L270:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L278
	movq	%rbp, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L279
.L271:
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
.L277:
	.cfi_restore_state
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%r12, %rcx
	popq	%rbp
	.cfi_def_cfa_offset 16
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC13(%rip), %rdi
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L279:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	movq	%rbp, %rdx
	movq	%r12, %rdi
	popq	%rbp
	.cfi_def_cfa_offset 16
	leaq	.LC15(%rip), %rsi
	xorl	%eax, %eax
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	fprintf@PLT
	.cfi_endproc
.LFE29:
	.size	emit_function_name, .-emit_function_name
	.section	.rodata.str1.1
.LC16:
	.string	"extern word "
.LC17:
	.string	"[];\n"
.LC18:
	.string	"word "
.LC19:
	.string	"[1];\n"
.LC20:
	.string	"static word "
.LC21:
	.string	"void"
.LC22:
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
	je	.L281
	xorl	%ebp, %ebp
	leaq	.LC16(%rip), %r15
	leaq	external_calls(%rip), %r14
	leaq	.LC17(%rip), %r13
	.p2align 4
	.p2align 3
.L283:
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rdi
	testq	%rdi, %rdi
	je	.L282
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L282:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addq	$1, %rbp
	cmpq	8+external_calls(%rip), %rbp
	jb	.L283
.L281:
	cmpq	$0, 8+g_known_functions(%rip)
	je	.L292
	movl	$0, 12(%rsp)
	movq	$0, (%rsp)
	.p2align 4
	.p2align 3
.L290:
	leaq	g_known_functions(%rip), %rax
	movq	(%rsp), %rdx
	movq	8(%r12), %r13
	movq	(%rax), %rax
	movq	(%r12), %r14
	movq	(%rax,%rdx,8), %rbp
	testq	%r13, %r13
	je	.L285
	xorl	%r15d, %r15d
	jmp	.L288
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L286:
	addq	$1, %r15
	cmpq	%r15, %r13
	je	.L285
.L288:
	movq	(%r14,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L286
	movq	8(%rax), %rax
	movq	%rbp, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L286
.L287:
	addq	$1, (%rsp)
	movq	(%rsp), %rax
	cmpq	8+g_known_functions(%rip), %rax
	jb	.L290
	movl	12(%rsp), %eax
	testl	%eax, %eax
	je	.L292
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
.L292:
	cmpq	$0, 8(%r12)
	je	.L280
	xorl	%r13d, %r13d
	leaq	.LC18(%rip), %r15
	leaq	.LC19(%rip), %r14
	jmp	.L296
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L294:
	addq	$1, %r13
	cmpq	8(%r12), %r13
	jnb	.L280
.L296:
	movq	(%r12), %rax
	movq	(%rax,%r13,8), %rax
	cmpl	$1, (%rax)
	jne	.L294
	movq	8(%rax), %rbp
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	0(%rbp), %rdi
	testq	%rdi, %rdi
	je	.L295
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L295:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	addq	$1, %r13
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC20(%rip), %rdi
	call	fwrite@PLT
	movq	0(%rbp), %rsi
	movq	%rbx, %rdi
	call	emit_function_body_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC21(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC22(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r12), %r13
	jb	.L296
.L280:
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
.L285:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC16(%rip), %rdi
	call	fwrite@PLT
	testq	%rbp, %rbp
	je	.L289
	movq	%rbp, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L289:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC17(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 12(%rsp)
	jmp	.L287
	.cfi_endproc
.LFE63:
	.size	emit_function_prototypes, .-emit_function_prototypes
	.section	.rodata.str1.1
.LC23:
	.string	"B_ADDR("
.LC24:
	.string	"argv"
.LC25:
	.string	"b_argv_vector"
.LC26:
	.string	"__b_external_%s"
.LC27:
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
	leaq	.LC23(%rip), %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	call	fwrite@PLT
	movq	48(%r12), %rbx
	leaq	.LC24(%rip), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L354
.L321:
	movq	%rbx, %rdi
	call	global_data_kind
	movq	%rbx, %rdi
	cmpl	$2, %eax
	je	.L355
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	48(%r12), %rbx
	movq	%rbx, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L356
.L332:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC27(%rip), %rdi
	call	fwrite@PLT
.L330:
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
.L354:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L321
	movq	8+g_known_variables(%rip), %r14
	testq	%r14, %r14
	je	.L322
	movq	g_known_variables(%rip), %r15
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L323:
	movq	(%r15,%r13,8), %rdi
	movq	%rbx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L321
	addq	$1, %r13
	cmpq	%r14, %r13
	jne	.L323
.L322:
	movq	current_program(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L324
	movq	8(%rax), %rax
	xorl	%r13d, %r13d
	movq	%rax, 16(%rsp)
	jmp	.L325
	.p2align 4,,10
	.p2align 3
.L326:
	testl	%eax, %eax
	je	.L357
.L327:
	addq	$1, %r13
.L325:
	cmpq	%r13, 16(%rsp)
	je	.L324
	movq	24(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r13,8), %rdx
	movl	(%rdx), %eax
	cmpl	$2, %eax
	jne	.L326
	movq	8(%rdx), %rax
	movq	%rbx, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L327
	jmp	.L321
	.p2align 4,,10
	.p2align 3
.L356:
	movq	%rbx, %rdi
	call	global_data_kind
	cmpl	$1, %eax
	jne	.L330
	jmp	.L332
	.p2align 4,,10
	.p2align 3
.L355:
	call	get_mangled_name
	leaq	.LC26(%rip), %rsi
	movq	%rbp, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L330
.L324:
	movq	%rbp, %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC25(%rip), %rdi
	call	fwrite@PLT
	jmp	.L330
	.p2align 4,,10
	.p2align 3
.L357:
	movq	8(%rdx), %rax
	movq	24(%rax), %rcx
	movq	%rcx, 8(%rsp)
	testq	%rcx, %rcx
	je	.L327
	movq	16(%rax), %r14
	xorl	%r15d, %r15d
	jmp	.L328
	.p2align 4,,10
	.p2align 3
.L358:
	movq	8(%rsp), %rax
	addq	$1, %r15
	cmpq	%rax, %r15
	je	.L327
.L328:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L358
	jmp	.L321
	.cfi_endproc
.LFE74:
	.size	emit_ival_expr.part.0, .-emit_ival_expr.part.0
	.p2align 4
	.type	collect_strings_expr, @function
collect_strings_expr:
.LFB33:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L398
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
	leaq	.L364(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
.L361:
	cmpl	$10, (%rbx)
	ja	.L359
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L364:
	.long	.L359-.L364
	.long	.L372-.L364
	.long	.L359-.L364
	.long	.L371-.L364
	.long	.L363-.L364
	.long	.L402-.L364
	.long	.L402-.L364
	.long	.L401-.L364
	.long	.L401-.L364
	.long	.L365-.L364
	.long	.L363-.L364
	.text
	.p2align 4,,10
	.p2align 3
.L363:
	movq	48(%rbx), %rdi
	call	collect_strings_expr
.L402:
	movq	56(%rbx), %rbx
.L379:
	testq	%rbx, %rbx
	jne	.L361
.L359:
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
.L365:
	.cfi_restore_state
	movq	48(%rbx), %rdi
	call	collect_strings_expr
.L401:
	movq	56(%rbx), %rdi
	call	collect_strings_expr
	movq	64(%rbx), %rbx
	jmp	.L379
	.p2align 4,,10
	.p2align 3
.L371:
	movl	g_strict(%rip), %edx
	movq	48(%rbx), %rbp
	testl	%edx, %edx
	jne	.L403
.L373:
	movq	%rbp, %rdi
	call	collect_strings_expr
	cmpq	$0, 64(%rbx)
	je	.L359
	xorl	%ebp, %ebp
.L378:
	movq	56(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_expr
	cmpq	64(%rbx), %rbp
	jb	.L378
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
.L372:
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
.L403:
	.cfi_restore_state
	movl	24(%rbx), %eax
	testl	%eax, %eax
	jne	.L373
	cmpl	$2, 0(%rbp)
	jne	.L373
	movq	48(%rbp), %r13
	leaq	8+names.0(%rip), %r12
	leaq	.LC3(%rip), %rsi
	jmp	.L374
	.p2align 4,,10
	.p2align 3
.L405:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L404
.L374:
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L405
	jmp	.L373
	.p2align 4,,10
	.p2align 3
.L398:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L404:
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
	jne	.L373
	movq	8+external_calls(%rip), %rax
	testq	%rax, %rax
	je	.L376
	movq	external_calls(%rip), %r12
	leaq	(%r12,%rax,8), %r15
	.p2align 4
	.p2align 3
.L377:
	movq	(%r12), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	addq	$8, %r12
	movzbl	%al, %eax
	orl	%eax, %r14d
	cmpq	%r15, %r12
	jne	.L377
	testl	%r14d, %r14d
	jne	.L373
.L376:
	movq	%r13, %rdi
	call	sdup@PLT
	leaq	external_calls(%rip), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movq	48(%rbx), %rbp
	jmp	.L373
	.cfi_endproc
.LFE33:
	.size	collect_strings_expr, .-collect_strings_expr
	.p2align 4
	.type	collect_strings_init, @function
collect_strings_init:
.LFB34:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L415
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
	je	.L418
	cmpl	$1, %eax
	je	.L419
.L406:
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
.L418:
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
.L419:
	.cfi_restore_state
	cmpq	$0, 24(%rdi)
	je	.L406
	xorl	%ebp, %ebp
.L409:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_init
	cmpq	24(%rbx), %rbp
	jb	.L409
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L415:
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
	je	.L443
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L425(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L422:
	cmpl	$12, (%rbx)
	ja	.L420
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L425:
	.long	.L420-.L425
	.long	.L432-.L425
	.long	.L420-.L425
	.long	.L431-.L425
	.long	.L424-.L425
	.long	.L428-.L425
	.long	.L428-.L425
	.long	.L420-.L425
	.long	.L420-.L425
	.long	.L420-.L425
	.long	.L428-.L425
	.long	.L426-.L425
	.long	.L424-.L425
	.text
	.p2align 4,,10
	.p2align 3
.L428:
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
.L432:
	.cfi_restore_state
	cmpq	$0, 24(%rbx)
	je	.L420
	xorl	%ebp, %ebp
.L433:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_stmt
	cmpq	24(%rbx), %rbp
	jb	.L433
.L420:
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
.L424:
	.cfi_restore_state
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rbx
.L434:
	testq	%rbx, %rbx
	jne	.L422
	jmp	.L420
	.p2align 4,,10
	.p2align 3
.L426:
	movq	24(%rbx), %rbx
	jmp	.L434
	.p2align 4,,10
	.p2align 3
.L431:
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rdi
	call	collect_strings_stmt
	movq	32(%rbx), %rbx
	jmp	.L434
	.p2align 4,,10
	.p2align 3
.L443:
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
	je	.L456
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
	jmp	.L453
	.p2align 4,,10
	.p2align 3
.L449:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L459
.L453:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L460
	cmpl	$2, %eax
	je	.L461
	testl	%eax, %eax
	jne	.L449
	movq	8(%rdx), %rdi
	addq	$1, %rbx
	call	collect_strings_stmt
	cmpq	8(%rbp), %rbx
	jb	.L453
.L459:
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
.L460:
	.cfi_restore_state
	movq	8(%rdx), %rax
	movq	32(%rax), %rdi
	call	collect_strings_stmt
	jmp	.L449
	.p2align 4,,10
	.p2align 3
.L461:
	movq	8(%rdx), %r12
	movq	56(%r12), %rdi
	call	collect_strings_init
	movq	32(%r12), %rdi
	testq	%rdi, %rdi
	je	.L449
	call	collect_strings_expr
	jmp	.L449
	.p2align 4,,10
	.p2align 3
.L456:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE36:
	.size	collect_strings_program, .-collect_strings_program
	.section	.rodata.str1.1
.LC28:
	.string	"  "
	.text
	.p2align 4
	.globl	emit_indent
	.type	emit_indent, @function
emit_indent:
.LFB38:
	.cfi_startproc
	testl	%esi, %esi
	jle	.L467
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
.L464:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L464
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
.L467:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	ret
	.cfi_endproc
.LFE38:
	.size	emit_indent, .-emit_indent
	.section	.rodata.str1.1
.LC29:
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
	jne	.L470
	testq	%rdx, %rdx
	jne	.L478
.L470:
	ret
	.p2align 4,,10
	.p2align 3
.L478:
	movq	%rdx, %rcx
	xorl	%eax, %eax
	movl	%esi, %edx
	leaq	.LC29(%rip), %rsi
	jmp	fprintf@PLT
	.cfi_endproc
.LFE39:
	.size	emit_line_directive, .-emit_line_directive
	.section	.rodata.str1.1
.LC30:
	.string	"\\n"
.LC31:
	.string	"\\t"
.LC32:
	.string	"\\%03o"
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
	jne	.L480
	jmp	.L487
	.p2align 4,,10
	.p2align 3
.L495:
	movq	%r13, %rsi
	movq	%r12, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L483:
	movzbl	1(%rbp), %ebx
	addq	$1, %rbp
	testb	%bl, %bl
	je	.L487
.L480:
	cmpb	$92, %bl
	je	.L488
	cmpb	$34, %bl
	je	.L488
	cmpb	$10, %bl
	je	.L493
	cmpb	$9, %bl
	je	.L494
	movzbl	%bl, %edx
	cmpb	$31, %bl
	jbe	.L495
	movq	%r12, %rsi
	movl	%edx, %edi
	addq	$1, %rbp
	call	fputc@PLT
	movzbl	0(%rbp), %ebx
	testb	%bl, %bl
	jne	.L480
.L487:
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
.L488:
	.cfi_restore_state
	movq	%r12, %rsi
	movl	$92, %edi
	call	fputc@PLT
	movzbl	%bl, %edi
	movq	%r12, %rsi
	call	fputc@PLT
	jmp	.L483
	.p2align 4,,10
	.p2align 3
.L493:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	jmp	.L483
	.p2align 4,,10
	.p2align 3
.L494:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
	jmp	.L483
	.cfi_endproc
.LFE40:
	.size	emit_c_string, .-emit_c_string
	.section	.rodata.str1.1
.LC33:
	.string	"b_preinc(&("
.LC34:
	.string	"b_predec(&("
.LC35:
	.string	"b_postinc(&("
.LC36:
	.string	"b_postdec(&("
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
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC56:
	.string	"B_PTR_N(__b_str%d, sizeof(__b_str%d))"
	.section	.rodata.str1.1
.LC57:
	.string	"__b_label_value_%d"
.LC58:
	.string	"__bcc_parameters[%zu]"
.LC59:
	.string	"callf"
.LC60:
	.string	"b_callf_dispatch(%zu"
.LC61:
	.string	", "
	.section	.rodata.str1.8
	.align 8
.LC62:
	.string	"({ word *__bcc_binding_%u = __bcc_source_binding("
	.align 8
.LC63:
	.string	"); word __bcc_result_%u; if (__bcc_binding_%u) __bcc_result_%u = "
	.section	.rodata.str1.1
.LC64:
	.string	"; else __bcc_result_%u = "
.LC65:
	.string	"printf"
.LC66:
	.string	"malloc"
.LC67:
	.string	"calloc"
.LC68:
	.string	"realloc"
.LC69:
	.string	"B_PTR("
.LC70:
	.string	"-+ #0"
.LC71:
	.string	"exit"
.LC72:
	.string	"strlen"
.LC73:
	.string	"atoi"
.LC74:
	.string	"memmove"
.LC75:
	.string	"tcgetattr"
.LC76:
	.string	"tcsetattr"
.LC77:
	.string	"ioctl"
.LC78:
	.string	"memset"
.LC79:
	.string	"memcpy"
.LC80:
	.string	"__b_cstr("
.LC81:
	.string	"B_CPTR("
	.section	.rodata.str1.8
	.align 8
.LC82:
	.string	"(size_t)(sizeof(word) * (uword)("
	.section	.rodata.str1.1
.LC83:
	.string	"))"
.LC84:
	.string	"; __bcc_result_%u; })"
.LC85:
	.string	"B_INDEX("
.LC86:
	.string	"B_DEREF("
.LC87:
	.string	"WNEG("
.LC88:
	.string	"({ word __b_left_%u = "
.LC89:
	.string	"; word __b_right_%u = "
	.section	.rodata.str1.8
	.align 8
.LC90:
	.string	"; (word)%s(__b_left_%u, __b_right_%u); })"
	.section	.rodata.str1.1
.LC91:
	.string	" %s "
.LC92:
	.string	"%s("
.LC93:
	.string	"({ word *__b_dest_%u = &("
.LC94:
	.string	"); word __b_rhs_%u = ("
	.section	.rodata.str1.8
	.align 8
.LC95:
	.string	"); *__b_dest_%u = (*__b_dest_%u %s __b_rhs_%u); })"
	.section	.rodata.str1.1
.LC96:
	.string	"b_"
.LC97:
	.string	"(&("
.LC98:
	.string	"), "
.LC99:
	.string	"="
.LC100:
	.string	" ? "
.LC101:
	.string	" : "
.LC102:
	.string	"snprintf"
.LC103:
	.string	"sprintf"
.LC104:
	.string	"fprintf"
.LC105:
	.string	"B_FUNCTION("
.LC106:
	.string	"__bcc_library_value("
.LC107:
	.string	"dprintf"
	.text
	.p2align 4
	.globl	emit_expr
	.type	emit_expr, @function
emit_expr:
.LFB49:
	.cfi_startproc
	cmpl	$10, (%rsi)
	ja	.L905
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
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
	movq	%rdx, %rbp
	leaq	.L499(%rip), %rdx
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movl	(%rsi), %eax
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L499:
	.long	.L509-.L499
	.long	.L508-.L499
	.long	.L507-.L499
	.long	.L506-.L499
	.long	.L505-.L499
	.long	.L504-.L499
	.long	.L503-.L499
	.long	.L502-.L499
	.long	.L501-.L499
	.long	.L500-.L499
	.long	.L498-.L499
	.text
	.p2align 4,,10
	.p2align 3
.L500:
	movq	%rdi, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC100(%rip), %rdi
	call	fwrite@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC101(%rip), %rdi
.L928:
	call	fwrite@PLT
	movq	64(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L922:
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rsi
	movl	$41, %edi
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
	jmp	fputc@PLT
	.p2align 4,,10
	.p2align 3
.L498:
	.cfi_restore_state
	movq	%rdi, %rsi
	movl	$40, %edi
	call	fputc@PLT
.L929:
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC61(%rip), %rdi
.L930:
	call	fwrite@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	jmp	.L922
	.p2align 4,,10
	.p2align 3
.L509:
	movq	48(%rsi), %rdx
	leaq	.LC55(%rip), %rsi
.L919:
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rdi
	xorl	%eax, %eax
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
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L508:
	.cfi_restore_state
	movq	48(%r15), %rdi
	movq	40(%rsi), %rsi
	call	get_string_id
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rdi
	leaq	.LC56(%rip), %rsi
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 48
	movl	%eax, %edx
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 40
	movl	%eax, %ecx
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 32
	xorl	%eax, %eax
	popq	%r13
	.cfi_restore 13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_restore 14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_restore 15
	.cfi_def_cfa_offset 8
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L507:
	.cfi_restore_state
	movq	8+function_labels(%rip), %r13
	movq	48(%rsi), %r12
	testq	%r13, %r13
	je	.L510
	movq	function_labels(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L513
	.p2align 4,,10
	.p2align 3
.L511:
	addq	$1, %rbp
	cmpq	%r13, %rbp
	je	.L510
.L513:
	movq	(%r14,%rbp,8), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L511
	movl	%ebp, %edx
	leaq	.LC57(%rip), %rsi
	addl	$1, %edx
	je	.L510
.L920:
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rdi
	xorl	%eax, %eax
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
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L506:
	.cfi_restore_state
	movq	48(%rsi), %r13
	movl	24(%rsi), %eax
	cmpl	$2, 0(%r13)
	movl	%eax, 12(%rsp)
	je	.L524
	testl	%eax, %eax
	jne	.L677
	movb	$0, 34(%rsp)
	movq	48(%r13), %rsi
	xorl	%r12d, %r12d
	xorl	%r14d, %r14d
	movb	$0, 35(%rsp)
	movq	$0, 16(%rsp)
	movl	$0, 36(%rsp)
.L539:
	movq	%rbx, %rdi
	call	emit_function_name
.L552:
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	64(%r15), %rdx
	movq	16(%rsp), %rcx
	cmpq	%rdx, %rcx
	jnb	.L553
	cmpb	$0, 35(%rsp)
	je	.L553
	movq	56(%r15), %rax
	movq	(%rax,%rcx,8), %rax
	testq	%rax, %rax
	je	.L580
	cmpl	$1, (%rax)
	je	.L936
.L580:
	movq	$0, 48(%rsp)
.L556:
	xorl	%r12d, %r12d
	cmpb	$0, 34(%rsp)
	movq	%r14, 24(%rsp)
	movq	%rdx, %r13
	je	.L685
.L939:
	movl	g_strict(%rip), %r14d
	testl	%r14d, %r14d
	je	.L937
.L685:
	xorl	%r14d, %r14d
.L582:
	movq	56(%r15), %rax
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
.L652:
	testl	%r14d, %r14d
	jne	.L938
.L617:
	addq	$1, %r12
	cmpq	%r12, %r13
	je	.L618
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC61(%rip), %rdi
	call	fwrite@PLT
	cmpb	$0, 34(%rsp)
	jne	.L939
	jmp	.L685
	.p2align 4,,10
	.p2align 3
.L505:
	movq	%rdi, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC85(%rip), %rdi
	call	fwrite@PLT
	jmp	.L929
	.p2align 4,,10
	.p2align 3
.L504:
	movl	48(%rsi), %r12d
	cmpl	$32, %r12d
	je	.L940
	cmpl	$53, %r12d
	je	.L941
	leal	-36(%r12), %eax
	cmpl	$1, %eax
	jbe	.L942
	cmpl	$31, %r12d
	je	.L943
	movq	%rdi, %rsi
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
	jmp	.L923
	.p2align 4,,10
	.p2align 3
.L503:
	cmpl	$36, 48(%rsi)
	movq	56(%rsi), %r12
	leaq	.LC36(%rip), %rdi
	jne	.L627
	leaq	.LC35(%rip), %rdi
.L627:
	movl	$12, %edx
	movl	$1, %esi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r12, %rsi
.L923:
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC83(%rip), %rdi
.L921:
	addq	$88, %rsp
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
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L502:
	.cfi_restore_state
	movl	48(%rsi), %r12d
	leal	-53(%r12), %eax
	cmpl	$1, %eax
	jbe	.L944
	leal	-28(%r12), %eax
	cmpl	$6, %eax
	ja	.L630
	leaq	.L632(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L632:
	.long	.L693-.L632
	.long	.L637-.L632
	.long	.L636-.L632
	.long	.L635-.L632
	.long	.L634-.L632
	.long	.L633-.L632
	.long	.L631-.L632
	.text
	.p2align 4,,10
	.p2align 3
.L501:
	movl	48(%rsi), %r12d
	movq	56(%rsi), %r13
	movq	64(%rsi), %r14
	leal	-47(%r12), %eax
	cmpl	$5, %eax
	jbe	.L945
	cmpl	$21, %r12d
	je	.L640
	leal	-38(%r12), %eax
	cmpl	$8, %eax
	ja	.L641
	leaq	.L643(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L643:
	.long	.L651-.L643
	.long	.L650-.L643
	.long	.L649-.L643
	.long	.L648-.L643
	.long	.L647-.L643
	.long	.L646-.L643
	.long	.L645-.L643
	.long	.L694-.L643
	.long	.L642-.L643
	.text
	.p2align 4,,10
	.p2align 3
.L510:
	movq	32(%r15), %rdx
	testq	%rdx, %rdx
	jne	.L946
	movl	16(%r15), %ebp
	testl	%ebp, %ebp
	jne	.L947
	movl	12(%r15), %r11d
	testl	%r11d, %r11d
	jne	.L948
	movl	20(%r15), %eax
	cmpl	$2, %eax
	je	.L949
	testq	%r12, %r12
	je	.L523
	movq	%r12, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movl	20(%r15), %eax
.L523:
	cmpl	$1, %eax
	je	.L518
.L496:
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
.L677:
	.cfi_restore_state
	xorl	%r14d, %r14d
.L525:
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r14, %rcx
	movq	%rbp, %rdx
	movq	%r15, %rsi
	movq	%rbx, %rdi
	xorl	%r8d, %r8d
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
	jmp	emit_b_call
	.p2align 4,,10
	.p2align 3
.L946:
	.cfi_restore_state
	subq	$1, %rdx
	leaq	.LC58(%rip), %rsi
	jmp	.L919
	.p2align 4,,10
	.p2align 3
.L942:
	cmpl	$36, %r12d
	leaq	.LC33(%rip), %rax
	movl	$11, %edx
	movq	%rbx, %rcx
	leaq	.LC34(%rip), %rdi
	movl	$1, %esi
	cmove	%rax, %rdi
	call	fwrite@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	jmp	.L923
	.p2align 4,,10
	.p2align 3
.L637:
	leaq	.LC42(%rip), %rdx
	.p2align 4
	.p2align 3
.L638:
	leaq	.LC92(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC61(%rip), %rdi
	jmp	.L928
	.p2align 4,,10
	.p2align 3
.L693:
	leaq	.LC43(%rip), %rdx
	jmp	.L638
	.p2align 4,,10
	.p2align 3
.L631:
	leaq	.LC44(%rip), %rdx
	jmp	.L638
	.p2align 4,,10
	.p2align 3
.L636:
	leaq	.LC39(%rip), %rdx
	jmp	.L638
	.p2align 4,,10
	.p2align 3
.L634:
	leaq	.LC41(%rip), %rdx
	jmp	.L638
	.p2align 4,,10
	.p2align 3
.L635:
	leaq	.LC40(%rip), %rdx
	jmp	.L638
	.p2align 4,,10
	.p2align 3
.L633:
	leaq	.LC45(%rip), %rdx
	jmp	.L638
.L694:
	leaq	.LC48(%rip), %r12
	.p2align 4
	.p2align 3
.L644:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC96(%rip), %rdi
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
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC98(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	jmp	.L922
.L642:
	leaq	.LC47(%rip), %r12
	jmp	.L644
.L651:
	leaq	.LC46(%rip), %r12
	jmp	.L644
.L649:
	leaq	.LC53(%rip), %r12
	jmp	.L644
.L650:
	leaq	.LC54(%rip), %r12
	jmp	.L644
.L645:
	leaq	.LC49(%rip), %r12
	jmp	.L644
.L646:
	leaq	.LC50(%rip), %r12
	jmp	.L644
.L647:
	leaq	.LC51(%rip), %r12
	jmp	.L644
.L648:
	leaq	.LC52(%rip), %r12
	jmp	.L644
	.p2align 4,,10
	.p2align 3
.L938:
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L617
	.p2align 4,,10
	.p2align 3
.L937:
	movq	24(%rsp), %rdi
	call	source_function
	movl	%eax, 40(%rsp)
	testl	%eax, %eax
	jne	.L582
	movq	16(%rsp), %rax
	movl	current_byteptr(%rip), %ecx
	cmpq	%rax, %r12
	movl	%ecx, 56(%rsp)
	sete	%al
	andb	35(%rsp), %al
	movb	%al, 64(%rsp)
	jne	.L583
	movq	48(%rsp), %rax
	testq	%rax, %rax
	je	.L584
	movl	(%rax,%r12,4), %eax
	testl	%eax, %eax
	je	.L584
	testl	%ecx, %ecx
	je	.L585
	.p2align 4
	.p2align 3
.L586:
	movq	%rbx, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC80(%rip), %rdi
	call	fwrite@PLT
.L616:
	movl	$1, %r14d
	jmp	.L582
	.p2align 4,,10
	.p2align 3
.L618:
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	movl	12(%rsp), %r8d
	testl	%r8d, %r8d
	jne	.L579
.L620:
	movq	48(%rsp), %rax
	testq	%rax, %rax
	je	.L578
	movq	%rax, %rdi
	call	free@PLT
.L578:
	movl	36(%rsp), %edi
	testl	%edi, %edi
	je	.L496
	movl	36(%rsp), %edx
	leaq	.LC84(%rip), %rsi
	jmp	.L920
	.p2align 4,,10
	.p2align 3
.L524:
	movq	48(%r13), %r14
	testq	%r14, %r14
	je	.L950
	movl	12(%rsp), %r9d
	testl	%r9d, %r9d
	jne	.L677
	movq	%r14, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L525
	movl	g_strict(%rip), %r8d
	testl	%r8d, %r8d
	je	.L529
	leaq	8+names.0(%rip), %r12
	leaq	.LC3(%rip), %rsi
	jmp	.L530
	.p2align 4,,10
	.p2align 3
.L951:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L525
.L530:
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L951
.L529:
	leaq	.LC59(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L675
	.p2align 4
	.p2align 3
.L531:
	leaq	8+names.0(%rip), %r12
	leaq	.LC3(%rip), %rsi
	jmp	.L536
	.p2align 4,,10
	.p2align 3
.L953:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L952
.L536:
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L953
	movq	%r14, %rdi
	call	source_function
	movl	%eax, 12(%rsp)
	testl	%eax, %eax
	je	.L954
	movl	g_strict(%rip), %eax
	movl	%eax, 12(%rsp)
	testl	%eax, %eax
	je	.L955
.L672:
	leaq	.LC65(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	movl	%eax, 12(%rsp)
	testl	%eax, %eax
	je	.L540
	movb	$1, 34(%rsp)
	movq	%r14, %rsi
	xorl	%r12d, %r12d
	movb	$0, 35(%rsp)
	movq	$0, 16(%rsp)
	movl	$0, 12(%rsp)
	movl	$0, 36(%rsp)
	jmp	.L539
	.p2align 4,,10
	.p2align 3
.L553:
	testb	%r12b, %r12b
	je	.L577
	leaq	.LC71(%rip), %rsi
	movq	%r14, %rdi
	movq	%rdx, 24(%rsp)
	call	strcmp@PLT
	movq	24(%rsp), %rdx
	testl	%eax, %eax
	jne	.L577
	testq	%rdx, %rdx
	jne	.L580
	movq	%rbx, %rsi
	movl	$48, %edi
	call	fputc@PLT
.L910:
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	movl	12(%rsp), %eax
	testl	%eax, %eax
	je	.L578
	movq	$0, 48(%rsp)
	.p2align 4
	.p2align 3
.L579:
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L620
	.p2align 4,,10
	.p2align 3
.L577:
	testq	%rdx, %rdx
	jne	.L580
	jmp	.L910
	.p2align 4,,10
	.p2align 3
.L945:
	leaq	CSWTCH.183(%rip), %rdx
	leaq	.LC93(%rip), %rsi
	movl	(%rdx,%rax,4), %r15d
	movl	expression_id(%rip), %eax
	leal	1(%rax), %r12d
	xorl	%eax, %eax
	movl	%r12d, %edx
	movl	%r12d, expression_id(%rip)
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC94(%rip), %rsi
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r15d, %edi
	call	tk_name@PLT
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%r12d, %r9d
	movl	%r12d, %ecx
	movq	%rax, %r8
	movl	%r12d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 48
	leaq	.LC95(%rip), %rsi
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
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L943:
	.cfi_restore_state
	movq	%rdi, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC87(%rip), %rdi
	jmp	.L930
.L952:
	movl	g_strict(%rip), %r12d
	testl	%r12d, %r12d
	jne	.L672
	movl	$0, 36(%rsp)
.L663:
	movq	%r14, %rdi
	call	source_function
	testq	%r14, %r14
	movl	%eax, 24(%rsp)
	setne	34(%rsp)
	testl	%eax, %eax
	jne	.L678
	leaq	.LC65(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	leaq	.LC66(%rip), %rsi
	movq	%r14, %rdi
	orl	%r12d, %eax
	movl	%eax, 12(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L543
	leaq	.LC67(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L543
	leaq	.LC68(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L543
	cmpl	$0, 12(%rsp)
	je	.L956
	leaq	.LC104(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L704
	leaq	.LC107(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L704
	leaq	.LC103(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L660
.L704:
	movb	$1, 35(%rsp)
	movq	$1, 16(%rsp)
.L541:
	xorl	%eax, %eax
	movq	48(%r13), %rsi
	movq	%r13, %rdx
	movl	%eax, 12(%rsp)
.L551:
	testl	%r12d, %r12d
	je	.L679
	cmpl	$2, (%rdx)
	movzbl	34(%rsp), %r12d
	jne	.L539
.L664:
	movq	%rsi, %rdx
	movq	%rbx, %rdi
	leaq	.LC15(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movzbl	34(%rsp), %r12d
	jmp	.L552
	.p2align 4,,10
	.p2align 3
.L640:
	movq	%rdi, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	leaq	.LC99(%rip), %rdx
.L927:
	movq	%rbx, %rdi
	leaq	.LC91(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	jmp	.L922
	.p2align 4,,10
	.p2align 3
.L583:
	movl	56(%rsp), %r11d
	testl	%r11d, %r11d
	jne	.L586
.L585:
	movq	24(%rsp), %rdi
	leaq	.LC66(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L708
	testq	%r12, %r12
	je	.L653
.L708:
	movl	$1, 56(%rsp)
	xorl	%r14d, %r14d
	leaq	.LC68(%rip), %rdx
.L655:
	movq	24(%rsp), %rdi
	movq	%rdx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L933
.L608:
	movq	24(%rsp), %rdi
	leaq	.LC67(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L610
.L933:
	cmpq	$1, %r12
	je	.L957
.L610:
	movl	56(%rsp), %r9d
	testl	%r9d, %r9d
	jne	.L586
.L604:
	testl	%r14d, %r14d
	je	.L582
.L600:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC81(%rip), %rdi
	call	fwrite@PLT
	jmp	.L616
	.p2align 4,,10
	.p2align 3
.L944:
	movl	expression_id(%rip), %eax
	leaq	.LC88(%rip), %rsi
	leal	1(%rax), %r13d
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
	leaq	.LC89(%rip), %rsi
	call	fprintf@PLT
	movq	64(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	cmpl	$53, %r12d
	movl	%r13d, %r8d
	movl	%r13d, %ecx
	leaq	.LC37(%rip), %rax
	leaq	.LC38(%rip), %rdx
	movq	%rbx, %rdi
	cmove	%rax, %rdx
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC90(%rip), %rsi
	xorl	%eax, %eax
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
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L947:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC25(%rip), %rdi
	jmp	.L921
.L940:
	movq	%rdi, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC86(%rip), %rdi
	jmp	.L930
.L630:
	movq	%rdi, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edi
	call	tk_name@PLT
	movq	%rbx, %rdi
	leaq	.LC91(%rip), %rsi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	64(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	jmp	.L922
.L941:
	movq	%rdi, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC23(%rip), %rdi
	jmp	.L930
.L950:
	movl	12(%rsp), %r10d
	testl	%r10d, %r10d
	jne	.L525
	xorl	%edi, %edi
	leaq	.LC59(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L531
	xorl	%edi, %edi
	call	source_function
	testl	%eax, %eax
	jne	.L531
.L675:
	movq	64(%r15), %r14
	testq	%r14, %r14
	jne	.L532
	xorl	%edx, %edx
	leaq	.LC60(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L922
.L948:
	movq	%r12, %rdi
	leaq	8+names.0(%rip), %rbp
	call	source_function
	leaq	.LC3(%rip), %rsi
	testl	%eax, %eax
	jne	.L958
	.p2align 4
	.p2align 3
.L520:
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L519
	movq	0(%rbp), %rsi
	addq	$8, %rbp
	testq	%rsi, %rsi
	jne	.L520
	movq	%rbx, %rcx
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	jmp	.L922
.L584:
	movq	24(%rsp), %rdi
	leaq	.LC72(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L925
	movq	24(%rsp), %rdi
	leaq	.LC73(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L588
.L925:
	testq	%r12, %r12
	je	.L583
.L588:
	movq	24(%rsp), %rdi
	leaq	.LC74(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L589
	cmpq	$1, %r12
	jbe	.L959
.L591:
	movq	24(%rsp), %rdi
	leaq	.LC76(%rip), %rsi
	call	strcmp@PLT
	movl	%eax, %r14d
	testl	%eax, %eax
	jne	.L594
	cmpq	$2, %r12
	je	.L595
.L590:
	movq	24(%rsp), %rdi
	leaq	.LC78(%rip), %rsi
	call	strcmp@PLT
	testq	%r12, %r12
	movl	%eax, %edx
	sete	%al
	movb	%al, 64(%rsp)
	testl	%edx, %edx
	jne	.L598
	testb	%al, %al
	jne	.L916
.L598:
	movq	24(%rsp), %rdi
	leaq	.LC79(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L602
	cmpq	$1, %r12
	jbe	.L916
.L601:
	leaq	.LC68(%rip), %rdx
	movq	24(%rsp), %rdi
	movq	%rdx, %rsi
	movq	%rdx, 64(%rsp)
	call	strcmp@PLT
	leaq	.LC68(%rip), %rdx
	testl	%eax, %eax
	je	.L604
.L605:
	movq	24(%rsp), %rdi
	leaq	.LC67(%rip), %rsi
	movq	%rdx, 64(%rsp)
	call	strcmp@PLT
	testq	%r12, %r12
	movq	64(%rsp), %rdx
	sete	%cl
	testl	%eax, %eax
	sete	%al
	andl	%ecx, %eax
	xorl	$1, %eax
	movzbl	%al, %eax
	andl	%eax, %r14d
	movl	56(%rsp), %eax
	testl	%eax, %eax
	jne	.L604
	movq	24(%rsp), %rdi
	leaq	.LC66(%rip), %rsi
	movq	%rdx, 64(%rsp)
	movb	%cl, 56(%rsp)
	call	strcmp@PLT
	movq	64(%rsp), %rdx
	testl	%eax, %eax
	jne	.L709
	movzbl	56(%rsp), %ecx
	testb	%cl, %cl
	je	.L709
.L611:
	testl	%r14d, %r14d
	jne	.L614
	movl	$0, 40(%rsp)
.L613:
	movq	%rbx, %rcx
	movl	$32, %edx
	movl	$1, %esi
	leaq	.LC82(%rip), %rdi
	call	fwrite@PLT
	movq	56(%r15), %rax
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC83(%rip), %rdi
	call	fwrite@PLT
	movl	40(%rsp), %eax
	orl	%eax, %r14d
	jmp	.L652
.L641:
	movq	%rdi, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edi
	call	tk_name@PLT
	movq	%rax, %rdx
	jmp	.L927
.L958:
	testq	%r12, %r12
	je	.L518
	movq	%r12, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L518:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC27(%rip), %rdi
	jmp	.L921
.L540:
	movq	%r14, %rdi
	xorl	%r12d, %r12d
	call	source_function
	movb	$1, 34(%rsp)
	movq	%r14, %rsi
	xorl	$1, %eax
	movl	$0, 36(%rsp)
	movq	$0, 16(%rsp)
	andl	$1, %eax
	movb	%al, 35(%rsp)
	jmp	.L539
.L519:
	movq	%rbx, %rcx
	movl	$20, %edx
	movl	$1, %esi
	leaq	.LC106(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
	movq	%rbx, %rdi
	call	emit_c_string
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC61(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L922
.L936:
	movq	%rdx, %rdi
	movl	$4, %esi
	movq	%rdx, 24(%rsp)
	movq	48(%rax), %r12
	call	calloc@PLT
	movq	24(%rsp), %rdx
	testq	%rax, %rax
	movq	%rax, 48(%rsp)
	je	.L580
	movq	16(%rsp), %rax
	xorl	%r13d, %r13d
	leaq	1(%rax), %rsi
	movzbl	(%r12), %eax
	testb	%al, %al
	je	.L556
	movq	%r14, 24(%rsp)
	movq	%rbx, 40(%rsp)
	movq	%rsi, %rbx
	movq	%rbp, 56(%rsp)
	movq	%r12, %rbp
	movq	%rdx, %r12
	.p2align 4
	.p2align 3
.L555:
	cmpb	$37, %al
	jne	.L908
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	cmpb	$37, %r14b
	je	.L908
	testb	%r14b, %r14b
	jne	.L558
	jmp	.L903
	.p2align 4,,10
	.p2align 3
.L561:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	testb	%r14b, %r14b
	je	.L560
.L558:
	movsbl	%r14b, %esi
	leaq	.LC70(%rip), %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L561
	cmpb	$42, %r14b
	jne	.L560
	cmpq	%r12, %rbx
	adcq	$0, %rbx
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %edx
.L565:
	cmpb	$46, %dl
	je	.L960
.L567:
	cmpb	$104, %dl
	je	.L961
	cmpb	$108, %dl
	je	.L962
	testb	%dl, %dl
	je	.L903
	leaq	1(%r13), %rax
	cmpb	$115, %dl
	jne	.L573
	cmpq	%r12, %rbx
	jnb	.L573
	movq	48(%rsp), %rcx
	movl	$1, (%rcx,%rbx,4)
	.p2align 4
	.p2align 3
.L573:
	addq	$1, %rbx
.L557:
	movq	%rax, %r13
	movzbl	0(%rbp,%rax), %eax
	testb	%al, %al
	jne	.L555
.L903:
	movq	24(%rsp), %r14
	movq	40(%rsp), %rbx
	movq	%r12, %rdx
	movq	56(%rsp), %rbp
	jmp	.L556
	.p2align 4,,10
	.p2align 3
.L908:
	leaq	1(%r13), %rax
	jmp	.L557
.L560:
	movzbl	0(%rbp,%r13), %edx
	testb	%dl, %dl
	movb	%dl, 64(%rsp)
	je	.L903
	call	__ctype_b_loc@PLT
	movzbl	64(%rsp), %edx
	movq	(%rax), %rax
	jmp	.L563
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L566:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %edx
	testb	%dl, %dl
	je	.L903
.L563:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L566
	movzbl	0(%rbp,%r13), %edx
	jmp	.L565
.L961:
	cmpb	$104, 1(%rbp,%r13)
	leaq	1(%r13), %rax
	jne	.L573
.L683:
	leaq	2(%r13), %rax
	jmp	.L573
.L960:
	movzbl	1(%rbp,%r13), %edx
	leaq	1(%r13), %rdi
	movq	%rdi, 64(%rsp)
	cmpb	$42, %dl
	jne	.L963
	cmpq	%r12, %rbx
	adcq	$0, %rbx
	addq	$2, %r13
	movzbl	0(%rbp,%r13), %edx
	jmp	.L567
.L962:
	cmpb	$108, 1(%rbp,%r13)
	leaq	1(%r13), %rax
	jne	.L573
	jmp	.L683
.L543:
	movl	12(%rsp), %esi
	testl	%esi, %esi
	je	.L964
	leaq	.LC104(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L705
	leaq	.LC107(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L705
	leaq	.LC103(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L705
	movl	$1, 24(%rsp)
.L660:
	leaq	.LC102(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L695
	movb	$1, 35(%rsp)
	movq	$2, 16(%rsp)
.L659:
	cmpl	$0, 24(%rsp)
	je	.L541
.L550:
	movl	$6, %edx
	movl	$1, %esi
	movq	%rbx, %rcx
	leaq	.LC69(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rdx
	movl	$1, 12(%rsp)
	movq	48(%rdx), %rsi
	jmp	.L551
.L589:
	movq	24(%rsp), %rdi
	leaq	.LC75(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L591
	cmpq	$1, %r12
	jne	.L591
	movq	24(%rsp), %rdi
	leaq	.LC79(%rip), %rsi
	movl	$1, %r14d
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L602
	cmpl	$0, 56(%rsp)
	jne	.L600
	leaq	.LC68(%rip), %rdx
	movq	24(%rsp), %rdi
	movq	%rdx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L614
	xorl	%eax, %eax
	movl	$1, %r14d
	movl	%eax, 56(%rsp)
	jmp	.L608
	.p2align 4,,10
	.p2align 3
.L949:
	movq	%r12, %rdi
	call	get_mangled_name
	leaq	.LC26(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L919
.L963:
	testb	%dl, %dl
	movb	%dl, 72(%rsp)
	je	.L903
	call	__ctype_b_loc@PLT
	movzbl	72(%rsp), %edx
	movq	64(%rsp), %rdi
	movq	(%rax), %rax
	jmp	.L569
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L571:
	addq	$1, %rdi
	movzbl	0(%rbp,%rdi), %edx
	testb	%dl, %dl
	je	.L903
.L569:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L571
	movzbl	0(%rbp,%rdi), %edx
	movq	%rdi, %r13
	jmp	.L567
.L957:
	movl	56(%rsp), %r10d
	testl	%r10d, %r10d
	je	.L611
	movq	%rbx, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC80(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 40(%rsp)
	jmp	.L613
.L595:
	movq	24(%rsp), %rdi
	leaq	.LC79(%rip), %rsi
	movl	$1, %r14d
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L601
.L602:
	leaq	.LC68(%rip), %rdx
	movq	24(%rsp), %rdi
	movq	%rdx, %rsi
	movq	%rdx, 72(%rsp)
	call	strcmp@PLT
	leaq	.LC68(%rip), %rdx
	testl	%eax, %eax
	jne	.L605
	movzbl	64(%rsp), %eax
	orl	%eax, %r14d
	cmpl	$0, 56(%rsp)
	jne	.L604
	movq	24(%rsp), %rdi
	leaq	.LC66(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L667
	cmpb	$0, 64(%rsp)
	jne	.L611
.L667:
	cmpq	$1, %r12
	jne	.L604
	jmp	.L611
	.p2align 4,,10
	.p2align 3
.L678:
	movb	$0, 35(%rsp)
	movq	$0, 16(%rsp)
	jmp	.L541
.L594:
	movq	24(%rsp), %rdi
	leaq	.LC77(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L707
	cmpq	$2, %r12
	je	.L595
.L707:
	xorl	%r14d, %r14d
	jmp	.L590
.L954:
	movl	expression_id(%rip), %eax
	leaq	.LC62(%rip), %rsi
	movq	%rbx, %rdi
	addl	$1, %eax
	movl	%eax, %r13d
	movl	%eax, %edx
	movl	%eax, 36(%rsp)
	movl	%eax, expression_id(%rip)
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_c_string
	movl	%r13d, %r8d
	movl	%r13d, %ecx
	movl	%r13d, %edx
	leaq	.LC63(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%r13d, %r8d
	xorl	%ecx, %ecx
	movq	%rbp, %rdx
	movq	%r15, %rsi
	movq	%rbx, %rdi
	call	emit_b_call
	movl	%r13d, %edx
	xorl	%eax, %eax
	movq	%rbx, %rdi
	leaq	.LC64(%rip), %rsi
	call	fprintf@PLT
	movq	48(%r15), %r13
	cmpl	$2, 0(%r13)
	movq	48(%r13), %rsi
	je	.L538
	movb	$0, 34(%rsp)
	xorl	%r12d, %r12d
	xorl	%r14d, %r14d
	movb	$0, 35(%rsp)
	movq	$0, 16(%rsp)
	jmp	.L539
.L705:
	movb	$1, 35(%rsp)
	movq	$1, 16(%rsp)
	jmp	.L550
.L916:
	movl	56(%rsp), %eax
	testl	%eax, %eax
	jne	.L600
	movq	24(%rsp), %rdi
	leaq	.LC66(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L710
	testb	$1, %r12b
	je	.L614
.L710:
	xorl	%ecx, %ecx
	movl	$1, %r14d
	leaq	.LC68(%rip), %rdx
	movl	%ecx, 56(%rsp)
	jmp	.L655
.L955:
	movb	$1, 34(%rsp)
	movq	48(%r13), %rsi
	xorl	%r12d, %r12d
	movb	$0, 35(%rsp)
	movq	$0, 16(%rsp)
	movl	$0, 36(%rsp)
	jmp	.L539
.L695:
	xorl	%edx, %edx
	movb	$0, 35(%rsp)
	movq	%rdx, 16(%rsp)
	jmp	.L659
.L532:
	leaq	-1(%r14), %rdx
	leaq	.LC60(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%r12d, %r12d
	leaq	.LC61(%rip), %r13
.L534:
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
	jne	.L534
	jmp	.L922
.L964:
	movq	%rbx, %rcx
	movl	$1, %esi
	movl	$6, %edx
	xorl	%r12d, %r12d
	leaq	.LC69(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rax
	xorl	%ecx, %ecx
	movb	$1, 35(%rsp)
	movq	%rcx, 16(%rsp)
	movl	$1, 12(%rsp)
	movq	48(%rax), %rsi
	jmp	.L539
.L614:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	movl	$1, %r14d
	leaq	.LC81(%rip), %rdi
	call	fwrite@PLT
	jmp	.L613
.L959:
	movl	$1, %r14d
	jmp	.L590
.L653:
	movq	%rbx, %rcx
	movl	$9, %edx
	movl	$1, %esi
	xorl	%r14d, %r14d
	leaq	.LC80(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 40(%rsp)
	jmp	.L613
.L538:
	cmpl	$0, g_strict(%rip)
	je	.L702
	testq	%rsi, %rsi
	movb	$0, 35(%rsp)
	movq	%rsi, %r14
	setne	34(%rsp)
	xorl	%edx, %edx
	movq	%rdx, 16(%rsp)
	jmp	.L664
.L702:
	movq	%rsi, %r14
	movl	$1, %r12d
	jmp	.L663
.L956:
	xorl	%edi, %edi
	movb	$1, 35(%rsp)
	movq	48(%r13), %rsi
	xorl	%r12d, %r12d
	movq	%rdi, 16(%rsp)
	jmp	.L539
.L679:
	xorl	%r12d, %r12d
	jmp	.L539
.L709:
	xorl	%esi, %esi
	movl	%esi, 56(%rsp)
	jmp	.L655
.L905:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.cfi_endproc
.LFE49:
	.size	emit_expr, .-emit_expr
	.section	.rodata.str1.1
.LC108:
	.string	"({ word __bcc_callee_%u = "
.LC109:
	.string	"*__bcc_binding_%u"
.LC110:
	.string	"; word __bcc_args_%u[%zu] = {"
	.section	.rodata.str1.8
	.align 8
.LC111:
	.string	"}; __bcc_is_source_function(__bcc_callee_%u) ? __bcc_invoke_source(__bcc_callee_%u, %zu, __bcc_args_%u) : ((word (*)())B_FUNCTION_CPTR(__bcc_callee_%u))("
	.section	.rodata.str1.1
.LC112:
	.string	"__bcc_args_%u[%zu]"
.LC113:
	.string	"); })"
	.text
	.p2align 4
	.type	emit_b_call, @function
emit_b_call:
.LFB48:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rcx, %r15
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdx, %r14
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
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movl	expression_id(%rip), %eax
	movq	64(%rsi), %rbp
	leaq	.LC108(%rip), %rsi
	movl	%r8d, 12(%rsp)
	leal	1(%rax), %r12d
	xorl	%eax, %eax
	movl	%r12d, %edx
	movl	%r12d, expression_id(%rip)
	call	fprintf@PLT
	movl	12(%rsp), %r8d
	testl	%r8d, %r8d
	jne	.L976
	testq	%r15, %r15
	je	.L968
	movq	%r15, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC27(%rip), %rdi
	call	fwrite@PLT
.L967:
	testq	%rbp, %rbp
	movl	$1, %ecx
	movl	%r12d, %edx
	movq	%rbx, %rdi
	cmovne	%rbp, %rcx
	leaq	.LC110(%rip), %rsi
	xorl	%eax, %eax
	xorl	%r15d, %r15d
	call	fprintf@PLT
	testq	%rbp, %rbp
	jne	.L969
	jmp	.L977
	.p2align 4,,10
	.p2align 3
.L978:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC61(%rip), %rdi
	call	fwrite@PLT
.L969:
	movq	56(%r13), %rax
	movq	%r14, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r15,8), %rsi
	addq	$1, %r15
	call	emit_expr
	cmpq	%r15, %rbp
	jne	.L978
	subq	$8, %rsp
	.cfi_def_cfa_offset 88
	movl	%r12d, %edx
	movl	%r12d, %r9d
	movq	%rbp, %r8
	pushq	%r12
	.cfi_def_cfa_offset 96
	movl	%r12d, %ecx
	leaq	.LC111(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	xorl	%r13d, %r13d
	leaq	.LC112(%rip), %r14
	leaq	.LC61(%rip), %r15
	call	fprintf@PLT
	popq	%rax
	.cfi_def_cfa_offset 88
	popq	%rdx
	.cfi_def_cfa_offset 80
	jmp	.L972
	.p2align 4,,10
	.p2align 3
.L979:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
.L972:
	movq	%r13, %rcx
	movl	%r12d, %edx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	addq	$1, %r13
	call	fprintf@PLT
	cmpq	%r13, %rbp
	jne	.L979
.L970:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC113(%rip), %rdi
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
.L968:
	.cfi_restore_state
	movq	48(%r13), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	jmp	.L967
	.p2align 4,,10
	.p2align 3
.L977:
	movq	%rbx, %rsi
	movl	$48, %edi
	call	fputc@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 88
	movl	%r12d, %ecx
	movl	%r12d, %r9d
	pushq	%r12
	.cfi_def_cfa_offset 96
	leaq	.LC111(%rip), %rsi
	xorl	%r8d, %r8d
	movl	%r12d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	popq	%rcx
	.cfi_def_cfa_offset 88
	popq	%rsi
	.cfi_def_cfa_offset 80
	jmp	.L970
	.p2align 4,,10
	.p2align 3
.L976:
	movl	%r8d, %edx
	leaq	.LC109(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L967
	.cfi_endproc
.LFE48:
	.size	emit_b_call, .-emit_b_call
	.section	.rodata.str1.1
.LC114:
	.string	"word __%s_store[("
.LC115:
	.string	")];\n"
.LC116:
	.string	"word %s = 0;\n"
	.section	.rodata.str1.8
	.align 8
.LC117:
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
	je	.L981
	testl	%r13d, %r13d
	jle	.L982
	xorl	%r12d, %r12d
	leaq	.LC28(%rip), %r14
	.p2align 4
	.p2align 3
.L983:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r13d
	jne	.L983
.L982:
	movq	%r15, %rdx
	leaq	.LC114(%rip), %rsi
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
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
.L981:
	testl	%r13d, %r13d
	jle	.L984
	xorl	%ebx, %ebx
	leaq	.LC28(%rip), %r14
	.p2align 4
	.p2align 3
.L985:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %r12d
	leal	1(%rbx), %ebx
	cmpl	%ebx, %r13d
	jne	.L985
	xorl	%eax, %eax
	movq	%r15, %rdx
	leaq	.LC116(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L996
.L980:
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
.L996:
	.cfi_restore_state
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L990:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %r12d
	jne	.L990
.L987:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r15, %rcx
	movq	%r15, %rdx
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC117(%rip), %rsi
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
.L984:
	.cfi_restore_state
	xorl	%eax, %eax
	movq	%r15, %rdx
	leaq	.LC116(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L980
	jmp	.L987
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
	je	.L999
	jmp	emit_expr
	.p2align 4,,10
	.p2align 3
.L999:
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
	je	.L1000
	cmpl	$1, (%rdi)
	je	.L1004
.L1000:
	ret
	.p2align 4,,10
	.p2align 3
.L1004:
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
	je	.L1041
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
	je	.L1007
	ja	.L1008
	testl	%eax, %eax
	je	.L1009
	cmpl	$5, %eax
	jne	.L1017
	movq	56(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1005
	movl	48(%rbx), %eax
	cmpl	$31, %eax
	je	.L1013
	cmpl	$35, %eax
	je	.L1014
	.p2align 4
	.p2align 3
.L1017:
	xorl	%eax, %eax
.L1005:
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
.L1008:
	.cfi_restore_state
	cmpl	$10, %eax
	jne	.L1017
	movq	48(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1005
	movq	56(%rbx), %rdi
	movq	%rbp, %rsi
	call	try_eval_const_expr
	jmp	.L1005
	.p2align 4,,10
	.p2align 3
.L1041:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L1009:
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
.L1007:
	.cfi_restore_state
	movq	56(%rdi), %rdi
	movq	%rsp, %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1017
	movq	64(%rbx), %rdi
	leaq	8(%rsp), %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1017
	movl	48(%rbx), %eax
	subl	$22, %eax
	cmpl	$33, %eax
	ja	.L1017
	leaq	.L1020(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1020:
	.long	.L1033-.L1020
	.long	.L1032-.L1020
	.long	.L1031-.L1020
	.long	.L1030-.L1020
	.long	.L1029-.L1020
	.long	.L1028-.L1020
	.long	.L1017-.L1020
	.long	.L1017-.L1020
	.long	.L1027-.L1020
	.long	.L1026-.L1020
	.long	.L1025-.L1020
	.long	.L1024-.L1020
	.long	.L1023-.L1020
	.long	.L1017-.L1020
	.long	.L1017-.L1020
	.long	.L1017-.L1020
	.long	.L1017-.L1020
	.long	.L1017-.L1020
	.long	.L1017-.L1020
	.long	.L1017-.L1020
	.long	.L1017-.L1020
	.long	.L1017-.L1020
	.long	.L1017-.L1020
	.long	.L1017-.L1020
	.long	.L1017-.L1020
	.long	.L1017-.L1020
	.long	.L1017-.L1020
	.long	.L1017-.L1020
	.long	.L1017-.L1020
	.long	.L1017-.L1020
	.long	.L1017-.L1020
	.long	.L1022-.L1020
	.long	.L1021-.L1020
	.long	.L1019-.L1020
	.text
	.p2align 4,,10
	.p2align 3
.L1014:
	xorl	%eax, %eax
	cmpq	$0, 8(%rsp)
	sete	%al
	movq	%rax, 0(%rbp)
.L1035:
	movl	$1, %eax
	jmp	.L1005
.L1019:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1035
.L1021:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1035
.L1022:
	movq	(%rsp), %rax
	andq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1035
.L1023:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L1017
	movq	(%rsp), %rax
	cmpq	$-1, %rcx
	jne	.L1045
	movabsq	$-9223372036854775808, %rdx
	cmpq	%rdx, %rax
	je	.L1043
.L1045:
	cqto
	idivq	%rcx
.L1038:
	movq	%rdx, 0(%rbp)
	jmp	.L1035
.L1024:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L1017
	movq	(%rsp), %rdx
	cmpq	$-1, %rcx
	jne	.L1044
	movabsq	$-9223372036854775808, %rax
	cmpq	%rax, %rdx
	je	.L1066
.L1044:
	movq	%rdx, %rax
	cqto
	idivq	%rcx
.L1066:
	movq	%rax, 0(%rbp)
	jmp	.L1035
.L1025:
	movq	(%rsp), %rax
	imulq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1035
.L1026:
	movq	(%rsp), %rax
	subq	8(%rsp), %rax
	jmp	.L1066
.L1027:
	movq	8(%rsp), %rax
	addq	(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1035
.L1028:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setge	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1035
.L1029:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setg	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1035
.L1030:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setle	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1035
.L1031:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setl	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1035
.L1032:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1035
.L1033:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	sete	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1035
	.p2align 4,,10
	.p2align 3
.L1013:
	movq	8(%rsp), %rax
	negq	%rax
	movq	%rax, 0(%rbp)
	jmp	.L1035
.L1043:
	xorl	%edx, %edx
	jmp	.L1038
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
	je	.L1069
	cmpl	$1, (%rdi)
	je	.L1073
.L1069:
	ret
	.p2align 4,,10
	.p2align 3
.L1073:
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
	je	.L1074
	cmpl	$1, (%rdi)
	je	.L1079
.L1074:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L1079:
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
	je	.L1092
	cmpl	$1, (%rdi)
	jne	.L1092
	movq	24(%rdi), %rcx
	movq	16(%rdi), %r8
	testq	%rcx, %rcx
	je	.L1092
	xorl	%edx, %edx
	jmp	.L1093
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1095:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L1092
.L1093:
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L1095
	cmpl	$1, (%rax)
	jne	.L1095
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
.L1096:
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r9
.L1082:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L1099
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L1082
	cmpl	$1, (%rax)
	jne	.L1082
	jmp	.L1096
	.p2align 4,,10
	.p2align 3
.L1092:
	.cfi_def_cfa_offset 8
	movq	%r9, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1099:
	.cfi_def_cfa_offset 16
	movq	%r9, %rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE55:
	.size	edge_tail_words_top, .-edge_tail_words_top
	.section	.rodata.str1.1
.LC118:
	.string	"%s[%zu] = "
.LC119:
	.string	";\n"
.LC120:
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
	je	.L1101
	cmpl	$1, (%rcx)
	movq	%rcx, %r15
	jne	.L1101
	cmpq	$0, 24(%rcx)
	je	.L1101
	movq	%rsi, (%rsp)
	movq	%rdi, %rbx
	movl	%r9d, %ebp
	xorl	%r13d, %r13d
	movq	%r8, 8(%rsp)
.L1114:
	movq	16(%r15), %rax
	movq	(%rax,%r13,8), %r10
	testq	%r10, %r10
	je	.L1109
	movl	(%r10), %eax
	testl	%eax, %eax
	je	.L1133
	cmpl	$1, %eax
	je	.L1134
.L1109:
	addq	$1, %r13
	addq	$1, %r12
	cmpq	24(%r15), %r13
	jb	.L1114
	movq	8(%rsp), %rdx
.L1101:
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
.L1133:
	.cfi_restore_state
	xorl	%r14d, %r14d
	testl	%ebp, %ebp
	jle	.L1107
	movq	%r12, 16(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L1104:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC28(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1104
	movq	16(%rsp), %r12
	movq	%r14, %r10
.L1107:
	movq	(%rsp), %rdx
	leaq	.LC118(%rip), %rsi
	xorl	%eax, %eax
	movq	%r12, %rcx
	movq	%rbx, %rdi
	movq	%r10, 16(%rsp)
	call	fprintf@PLT
	movq	16(%rsp), %r10
	movq	16(%r10), %rsi
	cmpl	$2, (%rsi)
	je	.L1135
	movq	96(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L1108:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC119(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1109
	.p2align 4,,10
	.p2align 3
.L1134:
	movq	24(%r10), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmovne	%rax, %rdx
	xorl	%r14d, %r14d
	movq	%rdx, 16(%rsp)
	testl	%ebp, %ebp
	jle	.L1113
	movq	%r12, 24(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L1110:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC28(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1110
	movq	24(%rsp), %r12
	movq	%r14, %r10
.L1113:
	movq	8(%rsp), %r14
	movq	(%rsp), %r8
	movq	%r12, %rcx
	movq	%rbx, %rdi
	leaq	.LC120(%rip), %rsi
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
	jne	.L1111
	movq	24(%r10), %rsi
	movq	16(%r10), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, 8(%rsp)
.L1111:
	movq	8(%rsp), %rax
	cmpq	%rdx, %rax
	cmovnb	%rax, %rdx
	movq	%rdx, 8(%rsp)
	jmp	.L1109
	.p2align 4,,10
	.p2align 3
.L1135:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1108
	.cfi_endproc
.LFE56:
	.size	emit_edge_list_init, .-emit_edge_list_init
	.section	.rodata.str1.8
	.align 8
.LC121:
	.string	"static void __attribute__((constructor(101))) __b_register_globals(void) {\n"
	.section	.rodata.str1.1
.LC122:
	.string	"}\n"
	.section	.rodata.str1.8
	.align 8
.LC123:
	.string	"    (void)B_PTR_N(%s, sizeof(%s));\n"
	.align 8
.LC124:
	.string	"    (void)B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.align 8
.LC125:
	.string	"static void __attribute__((constructor(102))) __bcc_bind_functions(void) {\n"
	.align 8
.LC126:
	.string	"static void __b_initialize_globals(void) {\n"
	.section	.rodata.str1.1
.LC127:
	.string	"    "
.LC128:
	.string	" = B_FUNCTION("
	.section	.rodata.str1.8
	.align 8
.LC129:
	.string	"    static struct __bcc_source_function __bcc_function_%zu = {(void*)"
	.align 8
.LC130:
	.string	", 0, 0};\n    __bcc_register_function(&__bcc_function_%zu);\n"
	.align 8
.LC131:
	.string	"    static struct __bcc_library_binding __bcc_binding_%zu = {"
	.align 8
.LC132:
	.string	", 0, 0};\n    __bcc_register_binding(&__bcc_binding_%zu);\n"
	.align 8
.LC133:
	.string	"    static struct __bcc_library_binding __bcc_data_%zu = {"
	.align 8
.LC134:
	.string	", 0, 0};\n    __bcc_register_binding(&__bcc_data_%zu);\n"
	.align 8
.LC135:
	.string	"}\nstatic struct __bcc_initializer __bcc_module = {__b_initialize_globals, 0, 0};\nstatic void __attribute__((constructor(102))) __bcc_register_module(void) {\n    __bcc_register_initializer(&__bcc_module);\n}\n\n"
	.align 8
.LC136:
	.string	"    %s[0] = B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC137:
	.string	"__%s_store"
.LC138:
	.string	"    %s[0] = "
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
	cmpl	$16, current_word_bits(%rip)
	movq	%rdx, 8(%rsp)
	movq	%rax, (%rsp)
	je	.L1201
.L1137:
	movq	%rbx, %rcx
	movl	$75, %edx
	movl	$1, %esi
	xorl	%ebp, %ebp
	leaq	.LC125(%rip), %rdi
	leaq	.LC127(%rip), %r15
	call	fwrite@PLT
	cmpq	$0, 8(%r14)
	leaq	.LC128(%rip), %r13
	jne	.L1144
	jmp	.L1150
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1147:
	movq	8(%r14), %rax
	addq	$1, %rbp
	cmpq	%rax, %rbp
	jnb	.L1202
.L1144:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %r12
	cmpl	$1, (%r12)
	jne	.L1147
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r12), %rax
	movq	(%rax), %rdi
	testq	%rdi, %rdi
	je	.L1148
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1148:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC27(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$14, %edx
	movq	%r13, %rdi
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r12), %rax
	movq	%rbx, %rdi
	movq	(%rax), %rsi
	call	emit_function_body_name
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC22(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC129(%rip), %rsi
	call	fprintf@PLT
	movq	8(%r12), %rax
	movq	%rbx, %rdi
	movq	(%rax), %rsi
	call	emit_function_body_name
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC130(%rip), %rsi
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC131(%rip), %rsi
	call	fprintf@PLT
	movq	8(%r12), %rax
	movq	%rbx, %rdi
	movq	(%rax), %rsi
	call	emit_c_string
	leaq	.LC61(%rip), %rdi
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r12), %rax
	movq	(%rax), %rdi
	testq	%rdi, %rdi
	je	.L1149
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1149:
	movq	%rbp, %rdx
	leaq	.LC132(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	8(%r14), %rax
	addq	$1, %rbp
	cmpq	%rax, %rbp
	jb	.L1144
.L1202:
	testq	%rax, %rax
	je	.L1150
	xorl	%r15d, %r15d
	leaq	.LC61(%rip), %r13
	leaq	.LC134(%rip), %r12
	.p2align 4
	.p2align 3
.L1153:
	movq	(%r14), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$2, (%rax)
	jne	.L1151
	movq	8(%rax), %rax
	movl	4(%rax), %edi
	testl	%edi, %edi
	jne	.L1151
	movq	16(%rax), %rbp
	movq	%r15, %rdx
	leaq	.LC133(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	emit_c_string
	movq	%rbx, %rcx
	movl	$2, %edx
	movq	%r13, %rdi
	movl	$1, %esi
	call	fwrite@PLT
	testq	%rbp, %rbp
	je	.L1152
	movq	%rbp, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1152:
	movq	%r15, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L1151:
	addq	$1, %r15
	cmpq	8(%r14), %r15
	jb	.L1153
.L1150:
	movq	(%rsp), %rdi
	movq	%rbx, %rcx
	movl	$2, %edx
	xorl	%ebp, %ebp
	movl	$1, %esi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC126(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%r14)
	jne	.L1145
	jmp	.L1146
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1155:
	addq	$1, %rbp
	cmpq	8(%r14), %rbp
	jnb	.L1146
.L1145:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$2, (%rax)
	jne	.L1155
	movq	8(%rax), %r12
	movq	16(%r12), %rdi
	call	get_mangled_name
	cmpl	$2, 24(%r12)
	movq	56(%r12), %r13
	movq	%rax, %r15
	je	.L1203
	testq	%r13, %r13
	je	.L1155
	movl	0(%r13), %eax
	cmpl	$1, %eax
	je	.L1204
	testl	%eax, %eax
	jne	.L1155
	leaq	.LC138(%rip), %rsi
	movq	%r15, %rdx
	movq	%rbx, %rdi
	call	fprintf@PLT
	movq	16(%r13), %rsi
	cmpl	$2, (%rsi)
	je	.L1205
	movq	8(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L1163:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addq	$1, %rbp
	leaq	.LC119(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r14), %rbp
	jb	.L1145
.L1146:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$207, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC135(%rip), %rdi
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
.L1203:
	.cfi_restore_state
	movq	%rax, %r8
	movq	%rax, %rcx
	movq	%rax, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC136(%rip), %rsi
	call	fprintf@PLT
	testq	%r13, %r13
	je	.L1155
	cmpl	$1, 0(%r13)
	jne	.L1155
	movq	%r15, %rsi
	leaq	.LC137(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	xorl	%r8d, %r8d
	movq	%rax, %rsi
	movq	56(%r12), %rax
	testq	%rax, %rax
	je	.L1158
	cmpl	$1, (%rax)
	je	.L1206
.L1158:
	cmpq	$0, 32(%r12)
	je	.L1159
	movq	48(%r12), %rax
	movq	%r8, %rdx
	cmpq	%rax, %r8
	cmovb	%rax, %r8
	testq	%rax, %rax
	cmovle	%rdx, %r8
.L1159:
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
	jmp	.L1155
	.p2align 4,,10
	.p2align 3
.L1204:
	subq	$8, %rsp
	.cfi_def_cfa_offset 88
	movq	24(%r13), %r8
	xorl	%edx, %edx
	movl	$1, %r9d
	pushq	16(%rsp)
	.cfi_def_cfa_offset 96
	movq	%r13, %rcx
	movq	%r15, %rsi
	movq	%rbx, %rdi
	call	emit_edge_list_init
	popq	%rax
	.cfi_def_cfa_offset 88
	popq	%rdx
	.cfi_def_cfa_offset 80
	jmp	.L1155
	.p2align 4,,10
	.p2align 3
.L1201:
	movq	%rdi, %rcx
	movl	$75, %edx
	movl	$1, %esi
	xorl	%ebp, %ebp
	leaq	.LC121(%rip), %rdi
	leaq	.LC123(%rip), %r12
	call	fwrite@PLT
	cmpq	$0, 8(%r14)
	jne	.L1138
	.p2align 4
	.p2align 3
.L1143:
	leaq	.LC122(%rip), %rax
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, (%rsp)
	call	fwrite@PLT
	jmp	.L1137
	.p2align 4,,10
	.p2align 3
.L1209:
	movq	8(%rdx), %r15
	movq	16(%r15), %rdi
	call	get_mangled_name
	movq	%r12, %rsi
	movq	%rbx, %rdi
	movq	%rax, %rcx
	movq	%rax, %rdx
	movq	%rax, %r13
	xorl	%eax, %eax
	call	fprintf@PLT
	cmpl	$2, 24(%r15)
	je	.L1207
.L1140:
	addq	$1, %rbp
	cmpq	8(%r14), %rbp
	jnb	.L1143
.L1138:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L1208
	cmpl	$2, %eax
	jne	.L1140
	jmp	.L1209
	.p2align 4,,10
	.p2align 3
.L1207:
	movq	%r13, %rcx
	movq	%r13, %rdx
	leaq	.LC124(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1140
	.p2align 4,,10
	.p2align 3
.L1208:
	movq	8(%rdx), %rax
	movq	(%rax), %rdi
	call	get_mangled_name
	movq	%r12, %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1140
.L1205:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1163
.L1206:
	movq	24(%rax), %r8
	jmp	.L1158
	.cfi_endproc
.LFE65:
	.size	emit_global_initializers, .-emit_global_initializers
	.section	.rodata.str1.1
.LC139:
	.string	"<"
.LC140:
	.string	"<="
.LC141:
	.string	">"
.LC142:
	.string	">="
.LC143:
	.string	"??"
.LC144:
	.string	"while ("
.LC145:
	.string	")\n"
.LC146:
	.string	"if ("
.LC147:
	.string	"switch ("
.LC148:
	.string	") {\n"
.LC149:
	.string	"continue;\n"
.LC150:
	.string	"break;\n"
.LC151:
	.string	"return"
.LC152:
	.string	"{\n"
.LC153:
	.string	"return "
	.section	.rodata.str1.8
	.align 8
.LC154:
	.string	"%s = B_LOCAL_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC155:
	.string	"else\n"
.LC156:
	.string	" 0"
	.section	.rodata.str1.8
	.align 8
.LC157:
	.string	"case %zu: goto __b_label_%zu;\n"
	.align 8
.LC158:
	.string	"default: fputs(\"bcc: invalid label value\\n\", stderr); abort();\n"
	.section	.rodata.str1.1
.LC159:
	.string	"__bsw%d_case%zu"
.LC160:
	.string	"for(;;) {\n"
.LC161:
	.string	"word __sw = "
.LC162:
	.string	"__bsw%d_end"
.LC163:
	.string	"goto __bsw%d_dispatch;\n"
.LC164:
	.string	"goto __bsw%d_end;\n"
.LC165:
	.string	"__sw %s (word)%ld"
	.section	.rodata.str1.8
	.align 8
.LC166:
	.string	"(__sw >= (word)%ld && __sw <= (word)%ld)"
	.section	.rodata.str1.1
.LC167:
	.string	"__sw == (word)%ld"
.LC168:
	.string	") goto "
.LC169:
	.string	"__bsw%d_end:\n"
.LC170:
	.string	"__b_label_%d:\n"
.LC171:
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
.L1211:
	movl	g_no_line(%rip), %r10d
	testl	%r10d, %r10d
	jne	.L1212
	cmpb	$0, 24(%rsp)
	jne	.L1496
.L1212:
	cmpl	$12, (%rbx)
	ja	.L1210
	movl	(%rbx), %eax
	leaq	.L1215(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1215:
	.long	.L1226-.L1215
	.long	.L1225-.L1215
	.long	.L1224-.L1215
	.long	.L1223-.L1215
	.long	.L1222-.L1215
	.long	.L1221-.L1215
	.long	.L1220-.L1215
	.long	.L1210-.L1215
	.long	.L1219-.L1215
	.long	.L1218-.L1215
	.long	.L1217-.L1215
	.long	.L1216-.L1215
	.long	.L1214-.L1215
	.text
	.p2align 4,,10
	.p2align 3
.L1496:
	movl	4(%rbx), %edx
	movq	16(%rsp), %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC29(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1212
	.p2align 4,,10
	.p2align 3
.L1214:
	movl	g_switch_id(%rip), %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	leaq	.LC159(%rip), %r12
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
	je	.L1296
	movq	%rbx, 56(%rsp)
	movq	24(%rsp), %r13
	movq	%r14, 48(%rsp)
	movq	%rbp, %r14
	movq	40(%rsp), %rbp
	.p2align 4
	.p2align 3
.L1293:
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
	jb	.L1293
	movq	48(%rsp), %r14
	movq	56(%rsp), %rbx
.L1296:
	movl	8(%rsp), %edx
	movl	8(%rsp), %r12d
	xorl	%ebp, %ebp
	leaq	.LC28(%rip), %r13
	testl	%edx, %edx
	jle	.L1497
	.p2align 4
	.p2align 3
.L1294:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1294
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC160(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r12d
.L1297:
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 48(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1300:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1300
	movq	48(%rsp), %rbx
	movq	%r14, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC161(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	leaq	.LC119(%rip), %rax
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ecx
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC162(%rip), %rdx
	movl	$64, %esi
	call	snprintf@PLT
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 56(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1301:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1301
	movl	32(%rsp), %edx
	leaq	.LC163(%rip), %rsi
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
.L1302:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1302
	leaq	.LC164(%rip), %rax
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
.L1303:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1303
	movl	32(%rsp), %edx
	xorl	%eax, %eax
	leaq	.LC171(%rip), %rsi
	movq	%r14, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r15)
	leal	2(%rax), %ebx
	je	.L1305
.L1342:
	leaq	.LC146(%rip), %rax
	movq	%r15, 16(%rsp)
	xorl	%edi, %edi
	leaq	.LC28(%rip), %rbp
	movq	%rax, 56(%rsp)
	movl	%r12d, 76(%rsp)
	movq	%rdi, %r12
	.p2align 4
	.p2align 3
.L1319:
	movq	16(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r12,8), %r13
	movq	40(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1368
	xorl	%eax, %eax
	jmp	.L1310
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1309:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1368
.L1310:
	movq	(%rsi,%rax,8), %rdx
	cmpq	(%rdx), %r13
	jne	.L1309
	movq	8(%rdx), %rax
	movq	%rax, 24(%rsp)
.L1308:
	xorl	%r15d, %r15d
	testl	%ebx, %ebx
	jle	.L1314
	.p2align 4
	.p2align 3
.L1311:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebx, %r15d
	jne	.L1311
.L1314:
	movq	56(%rsp), %rdi
	movl	$1, %esi
	movq	%r14, %rcx
	movl	$4, %edx
	call	fwrite@PLT
	movl	20(%r13), %eax
	movq	24(%r13), %rsi
	testl	%eax, %eax
	je	.L1498
	leaq	.LC141(%rip), %rdx
	cmpl	$26, %eax
	je	.L1315
	ja	.L1316
	leaq	.LC139(%rip), %rdx
	cmpl	$24, %eax
	je	.L1315
	cmpl	$25, %eax
	leaq	.LC143(%rip), %rdx
	leaq	.LC140(%rip), %rax
	cmove	%rax, %rdx
.L1315:
	movq	%rsi, %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC165(%rip), %rsi
	call	fprintf@PLT
.L1317:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC168(%rip), %rdi
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
	jb	.L1319
	movl	76(%rsp), %r12d
	leaq	.LC28(%rip), %r13
	testl	%ebx, %ebx
	jle	.L1499
.L1305:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1321:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1321
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	testl	%r12d, %r12d
	jle	.L1472
	movl	8(%rsp), %r12d
	.p2align 4
	.p2align 3
.L1322:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jg	.L1322
.L1472:
	movl	32(%rsp), %edx
	leaq	.LC169(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	.p2align 4
	.p2align 3
.L1326:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1326
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	xorl	%ebx, %ebx
	leaq	.LC150(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	jle	.L1328
	.p2align 4
	.p2align 3
.L1329:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1329
.L1328:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	call	fwrite@PLT
.L1210:
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
.L1226:
	.cfi_restore_state
	movl	%r12d, %ebp
	xorl	%ebx, %ebx
	leaq	.LC28(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1495
	.p2align 4
	.p2align 3
.L1250:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1250
.L1495:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC119(%rip), %rdi
.L1494:
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
.L1225:
	.cfi_restore_state
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%r12d, %r12d
	movl	8(%rsp), %r15d
	leaq	.LC28(%rip), %r13
	testl	%eax, %eax
	jle	.L1500
	.p2align 4
	.p2align 3
.L1248:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1248
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC152(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L1254
.L1253:
	movl	8(%rsp), %edi
	xorl	%r13d, %r13d
	addl	$1, %edi
	movl	%edi, 40(%rsp)
.L1261:
	movq	16(%rbx), %rdx
	movq	(%rdx,%r13,8), %r12
	testl	%ebp, %ebp
	je	.L1357
	subq	$1, %rax
	xorl	%ecx, %ecx
	cmpq	%r13, %rax
	je	.L1501
.L1256:
	movq	16(%rsp), %r8
	movl	40(%rsp), %edx
	movq	%r12, %rsi
	movq	%r14, %rdi
	call	emit_stmt
.L1259:
	movq	24(%rbx), %rax
	addq	$1, %r13
	cmpq	%rax, %r13
	jb	.L1261
	movl	8(%rsp), %r9d
	leaq	.LC28(%rip), %r13
	testl	%r9d, %r9d
	jle	.L1263
.L1254:
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1264:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1264
.L1263:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	jmp	.L1494
	.p2align 4,,10
	.p2align 3
.L1224:
	xorl	%r13d, %r13d
	cmpq	$0, 24(%rbx)
	movl	%r12d, 8(%rsp)
	leaq	.LC28(%rip), %rbp
	movl	8(%rsp), %r12d
	je	.L1210
	.p2align 4
	.p2align 3
.L1247:
	movq	16(%rbx), %rax
	movq	(%rax,%r13,8), %r15
	movq	(%r15), %rdi
	call	get_mangled_name
	movl	g_strict(%rip), %esi
	movq	%rax, 8(%rsp)
	testl	%esi, %esi
	je	.L1502
	cmpq	$0, 8(%r15)
	je	.L1339
.L1338:
	xorl	%r15d, %r15d
	testl	%r12d, %r12d
	jle	.L1269
	.p2align 4
	.p2align 3
.L1267:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1267
.L1269:
	movq	8(%rsp), %rcx
	leaq	.LC154(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	movq	%rcx, %r8
	movq	%rcx, %rdx
	call	fprintf@PLT
.L1268:
	addq	$1, %r13
	cmpq	24(%rbx), %r13
	jb	.L1247
	jmp	.L1210
	.p2align 4,,10
	.p2align 3
.L1223:
	xorl	%r15d, %r15d
	leaq	.LC28(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1273
	.p2align 4
	.p2align 3
.L1233:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1233
.L1273:
	movq	%r14, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC146(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	testl	%ebp, %ebp
	jne	.L1234
.L1235:
	movq	24(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L1274
	cmpl	$1, (%rsi)
	movl	%r12d, %edx
	je	.L1275
.L1274:
	leal	1(%r12), %edx
.L1275:
	movq	16(%rsp), %r8
	movl	%ebp, %ecx
	movq	%r14, %rdi
	call	emit_stmt
	cmpq	$0, 32(%rbx)
	je	.L1210
	xorl	%ebp, %ebp
	leaq	.LC28(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1279
	.p2align 4
	.p2align 3
.L1276:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1276
.L1279:
	movq	%r14, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC155(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L1231
	jmp	.L1232
	.p2align 4,,10
	.p2align 3
.L1222:
	xorl	%ebp, %ebp
	leaq	.LC28(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1281
	.p2align 4
	.p2align 3
.L1230:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1230
.L1281:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC144(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L1232
.L1231:
	cmpl	$1, (%rbx)
	je	.L1280
.L1232:
	addl	$1, %r12d
.L1280:
	xorl	%ebp, %ebp
	jmp	.L1211
	.p2align 4,,10
	.p2align 3
.L1221:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	movl	8(%rsp), %r12d
	leaq	.LC28(%rip), %r13
	testl	%eax, %eax
	jle	.L1282
	.p2align 4
	.p2align 3
.L1244:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1244
.L1282:
	movq	%r14, %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC151(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%rbx)
	je	.L1503
	movq	%r14, %rsi
	movl	$32, %edi
	call	fputc@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	jmp	.L1495
	.p2align 4,,10
	.p2align 3
.L1219:
	movl	%r12d, 8(%rsp)
	xorl	%ebx, %ebx
	movl	8(%rsp), %ebp
	leaq	.LC28(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1284
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
.L1284:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC150(%rip), %rdi
	jmp	.L1494
	.p2align 4,,10
	.p2align 3
.L1220:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%r12d, %r12d
	movl	8(%rsp), %r15d
	leaq	.LC28(%rip), %r13
	testl	%eax, %eax
	jle	.L1283
	.p2align 4
	.p2align 3
.L1241:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1241
.L1283:
	testl	%ebp, %ebp
	jne	.L1504
.L1243:
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	jmp	.L1495
	.p2align 4,,10
	.p2align 3
.L1217:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	movl	8(%rsp), %r12d
	leaq	.LC28(%rip), %r13
	testl	%eax, %eax
	jle	.L1286
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
.L1286:
	movq	%r14, %rcx
	movl	$8, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC147(%rip), %rdi
	leaq	.LC157(%rip), %r13
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	%r14, %rdi
	movq	16(%rsp), %rdx
	leaq	.LC28(%rip), %rbp
	call	emit_expr
	movq	%r14, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	movl	8(%rsp), %r15d
	je	.L1238
	.p2align 4
	.p2align 3
.L1237:
	xorl	%ebx, %ebx
	testl	%r15d, %r15d
	js	.L1288
	.p2align 4
	.p2align 3
.L1287:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r15d
	jge	.L1287
.L1288:
	addq	$1, %r12
	xorl	%eax, %eax
	movq	%r13, %rsi
	movq	%r14, %rdi
	movq	%r12, %rcx
	movq	%r12, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %r12
	jb	.L1237
.L1238:
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	js	.L1289
	xorl	%ebx, %ebx
	leaq	.LC28(%rip), %r13
	.p2align 4
	.p2align 3
.L1290:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jge	.L1290
	movq	%r14, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC158(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	je	.L1263
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1292:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1292
	jmp	.L1263
	.p2align 4,,10
	.p2align 3
.L1218:
	movl	%r12d, 8(%rsp)
	xorl	%ebx, %ebx
	movl	8(%rsp), %ebp
	leaq	.LC28(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1285
	.p2align 4
	.p2align 3
.L1239:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1239
.L1285:
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC149(%rip), %rdi
	jmp	.L1494
	.p2align 4,,10
	.p2align 3
.L1216:
	xorl	%ebp, %ebp
	leaq	.LC28(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1505
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
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 8(%rsp)
	testq	%rbp, %rbp
	je	.L1506
.L1228:
	movq	function_labels(%rip), %r15
	xorl	%r13d, %r13d
	jmp	.L1334
	.p2align 4,,10
	.p2align 3
.L1332:
	addq	$1, %r13
	cmpq	%rbp, %r13
	je	.L1229
.L1334:
	movq	(%r15,%r13,8), %rsi
	movq	8(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1332
	leal	1(%r13), %edx
.L1333:
	leaq	.LC170(%rip), %rsi
	movq	%r14, %rdi
	leal	1(%r12), %r15d
	xorl	%eax, %eax
	call	fprintf@PLT
	leaq	.LC28(%rip), %r13
	testl	%r15d, %r15d
	jle	.L1337
.L1335:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1336:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jne	.L1336
.L1337:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movl	%r15d, %r12d
	leaq	.LC119(%rip), %rdi
	xorl	%ebp, %ebp
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	jmp	.L1211
	.p2align 4,,10
	.p2align 3
.L1368:
	movq	$0, 24(%rsp)
	jmp	.L1308
	.p2align 4,,10
	.p2align 3
.L1498:
	movl	16(%r13), %eax
	testl	%eax, %eax
	je	.L1318
	movq	32(%r13), %rcx
	movq	%rsi, %rdx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC166(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1317
	.p2align 4,,10
	.p2align 3
.L1502:
	movq	16(%rsp), %rcx
	movl	%r12d, %edx
	movq	%r15, %rsi
	movq	%r14, %rdi
	call	emit_auto_storage
	cmpq	$0, 8(%r15)
	jne	.L1338
	movl	g_strict(%rip), %ecx
	testl	%ecx, %ecx
	je	.L1268
	.p2align 4
	.p2align 3
.L1339:
	xorl	%r15d, %r15d
	testl	%r12d, %r12d
	jle	.L1271
	.p2align 4
	.p2align 3
.L1270:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1270
.L1271:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC119(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1268
.L1501:
	cmpl	$6, (%r12)
	movl	%ebp, %ecx
	jne	.L1256
	movl	g_no_line(%rip), %r8d
	testl	%r8d, %r8d
	jne	.L1257
	cmpb	$0, 24(%rsp)
	je	.L1257
	movl	4(%r12), %edx
	movq	16(%rsp), %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC29(%rip), %rsi
	call	fprintf@PLT
.L1257:
	movl	8(%rsp), %edi
	leaq	.LC28(%rip), %rax
	xorl	%r15d, %r15d
	movq	%rax, 32(%rsp)
	testl	%edi, %edi
	js	.L1260
	.p2align 4
	.p2align 3
.L1258:
	movq	32(%rsp), %rdi
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r15d
	call	fwrite@PLT
	cmpl	%r15d, 8(%rsp)
	jge	.L1258
.L1260:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC153(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r12), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC119(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1259
	.p2align 4,,10
	.p2align 3
.L1318:
	movq	%rsi, %rdx
	movq	%r14, %rdi
	leaq	.LC167(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1317
	.p2align 4,,10
	.p2align 3
.L1357:
	xorl	%ecx, %ecx
	jmp	.L1256
	.p2align 4,,10
	.p2align 3
.L1316:
	cmpl	$27, %eax
	leaq	.LC143(%rip), %rdx
	leaq	.LC142(%rip), %rax
	cmove	%rax, %rdx
	jmp	.L1315
.L1234:
	xorl	%ebp, %ebp
	cmpq	$0, 32(%rbx)
	sete	%bpl
	jmp	.L1235
.L1499:
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	xorl	%eax, %eax
	movq	%r14, %rdi
	call	fprintf@PLT
	testl	%r12d, %r12d
	jle	.L1493
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
.L1493:
	movl	32(%rsp), %edx
	movq	%r14, %rdi
	leaq	.LC169(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC150(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1328
.L1505:
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 8(%rsp)
	testq	%rbp, %rbp
	jne	.L1228
.L1229:
	xorl	%edx, %edx
	jmp	.L1333
.L1504:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC153(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1243
.L1503:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC156(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1495
.L1289:
	movq	%r14, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC158(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1263
.L1500:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC152(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	jne	.L1253
	jmp	.L1263
.L1497:
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC160(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r12d
	testl	%eax, %eax
	je	.L1297
	movq	%r14, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC161(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	leaq	.LC119(%rip), %rax
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ebp
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC162(%rip), %rdx
	movl	$64, %esi
	movl	%ebp, %ecx
	call	snprintf@PLT
	movl	%ebp, %edx
	leaq	.LC163(%rip), %rsi
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
	leaq	.LC164(%rip), %rax
	movq	%rax, %rsi
	movq	%rax, 64(%rsp)
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%eax, %eax
	movl	%ebp, %edx
	leaq	.LC171(%rip), %rsi
	movq	%r14, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r15)
	leal	2(%rax), %ebx
	jne	.L1342
	cmpl	$1, %ebx
	je	.L1305
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1493
	.p2align 4,,10
	.p2align 3
.L1506:
	xorl	%edx, %edx
	leaq	.LC170(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%r12), %r15d
	jmp	.L1335
	.cfi_endproc
.LFE59:
	.size	emit_stmt, .-emit_stmt
	.section	.rodata.str1.1
.LC172:
	.string	"%s:\n"
	.text
	.p2align 4
	.type	emit_stmt_switchctx, @function
emit_stmt_switchctx:
.LFB46:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.L1512(%rip), %r15
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
	je	.L1507
.L1508:
	cmpl	$13, 0(%r13)
	ja	.L1510
	movl	0(%r13), %eax
	movslq	(%r15,%rax,4), %rax
	addq	%r15, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1512:
	.long	.L1510-.L1512
	.long	.L1516-.L1512
	.long	.L1510-.L1512
	.long	.L1515-.L1512
	.long	.L1514-.L1512
	.long	.L1510-.L1512
	.long	.L1510-.L1512
	.long	.L1510-.L1512
	.long	.L1510-.L1512
	.long	.L1510-.L1512
	.long	.L1510-.L1512
	.long	.L1513-.L1512
	.long	.L1510-.L1512
	.long	.L1511-.L1512
	.text
	.p2align 4,,10
	.p2align 3
.L1510:
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
.L1511:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1560
	xorl	%eax, %eax
	jmp	.L1530
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1529:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1560
.L1530:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%r13, (%rdx)
	jne	.L1529
	movq	8(%rdx), %r14
.L1528:
	xorl	%r13d, %r13d
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1594
	.p2align 4
	.p2align 3
.L1531:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1531
	movq	%r14, %rdx
	leaq	.LC172(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1534:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jle	.L1534
.L1533:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC119(%rip), %rdi
	jmp	.L1593
	.p2align 4,,10
	.p2align 3
.L1513:
	xorl	%r14d, %r14d
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1595
	.p2align 4
	.p2align 3
.L1517:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1517
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L1596
.L1518:
	movq	function_labels(%rip), %r14
	xorl	%r12d, %r12d
	jmp	.L1538
	.p2align 4,,10
	.p2align 3
.L1536:
	addq	$1, %r12
	cmpq	%r12, 24(%rsp)
	je	.L1519
.L1538:
	movq	(%r14,%r12,8), %rsi
	movq	16(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1536
	leal	1(%r12), %edx
.L1537:
	leaq	.LC170(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	leaq	.LC28(%rip), %r12
	movl	%eax, 16(%rsp)
	testl	%eax, %eax
	jle	.L1597
.L1539:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1541:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, %ebp
	jne	.L1541
	movl	16(%rsp), %ebp
.L1542:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC119(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	jne	.L1508
	jmp	.L1507
	.p2align 4,,10
	.p2align 3
.L1514:
	xorl	%r14d, %r14d
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1554
	.p2align 4
	.p2align 3
.L1520:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1520
.L1554:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC144(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	je	.L1507
.L1521:
	xorl	%eax, %eax
	cmpl	$1, 0(%r13)
	setne	%al
	addl	%eax, %ebp
	jmp	.L1508
	.p2align 4,,10
	.p2align 3
.L1515:
	xorl	%r14d, %r14d
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1549
	.p2align 4
	.p2align 3
.L1523:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1523
.L1549:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC146(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %rsi
	testq	%rsi, %rsi
	je	.L1525
	cmpl	$1, (%rsi)
	movl	%ebp, %edx
	je	.L1550
.L1525:
	leal	1(%rbp), %edx
.L1550:
	movq	(%rsp), %r8
	movq	8(%rsp), %rcx
	movq	%rbx, %rdi
	call	emit_stmt_switchctx
	cmpq	$0, 32(%r13)
	je	.L1507
	xorl	%r14d, %r14d
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1553
	.p2align 4
	.p2align 3
.L1551:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1551
.L1553:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC155(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r13), %r13
	testq	%r13, %r13
	jne	.L1521
.L1507:
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
.L1516:
	.cfi_restore_state
	xorl	%r15d, %r15d
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1598
	.p2align 4
	.p2align 3
.L1526:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebp, %r15d
	jne	.L1526
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC152(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	je	.L1544
.L1543:
	leal	1(%rbp), %r12d
	xorl	%r15d, %r15d
.L1546:
	movq	16(%r13), %rax
	movq	(%rsp), %r8
	movl	%r12d, %edx
	movq	%rbx, %rdi
	movq	8(%rsp), %rcx
	movq	(%rax,%r15,8), %rsi
	addq	$1, %r15
	call	emit_stmt_switchctx
	cmpq	24(%r13), %r15
	jb	.L1546
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1545
.L1544:
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1548:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1548
.L1545:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
.L1593:
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
.L1560:
	.cfi_restore_state
	xorl	%r14d, %r14d
	jmp	.L1528
	.p2align 4,,10
	.p2align 3
.L1595:
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	jne	.L1518
	.p2align 4
	.p2align 3
.L1519:
	xorl	%edx, %edx
	jmp	.L1537
.L1596:
	xorl	%edx, %edx
	leaq	.LC170(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	movl	%eax, 16(%rsp)
	jmp	.L1539
	.p2align 4,,10
	.p2align 3
.L1594:
	xorl	%eax, %eax
	movq	%r14, %rdx
	leaq	.LC172(%rip), %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	testl	%ebp, %ebp
	jne	.L1533
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	jmp	.L1533
	.p2align 4,,10
	.p2align 3
.L1597:
	movl	%eax, %ebp
	jmp	.L1542
	.p2align 4,,10
	.p2align 3
.L1598:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC152(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	jne	.L1543
	jmp	.L1545
	.cfi_endproc
.LFE46:
	.size	emit_stmt_switchctx, .-emit_stmt_switchctx
	.section	.rodata.str1.1
.LC173:
	.string	"static "
.LC174:
	.string	""
	.section	.rodata.str1.8
	.align 8
.LC175:
	.string	"#ifndef %s\nextern word %s[];\n#define __b_external_%s (%s[0])\n#else\n#define __b_external_%s (%s)\n#endif\n"
	.section	.rodata.str1.1
.LC176:
	.string	"extern word %s[];\n"
.LC177:
	.string	"%sword %s[%zu];\n"
.LC178:
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
	je	.L1599
	movq	%rdi, %rbp
	movq	%rsi, %r12
	xorl	%ebx, %ebx
	jmp	.L1613
	.p2align 4,,10
	.p2align 3
.L1602:
	addq	$1, %rbx
	cmpq	8(%r12), %rbx
	jnb	.L1599
.L1613:
	movq	(%r12), %rax
	movq	(%rax,%rbx,8), %r14
	movl	(%r14), %eax
	testl	%eax, %eax
	je	.L1631
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L1602
	movq	8(%r14), %r13
	movq	16(%r13), %rdi
	call	get_mangled_name
	cmpl	$3, (%r14)
	movq	%rax, %r15
	je	.L1632
	cmpl	$1, 24(%r13)
	movl	$1, %r8d
	jne	.L1607
	movq	56(%r13), %rdi
	movl	$1, %r11d
	testq	%rdi, %rdi
	je	.L1608
	cmpl	$1, (%rdi)
	je	.L1633
.L1608:
	call	edge_tail_words_top
	leaq	(%rax,%r11), %r8
	movl	$1, %eax
	testq	%r8, %r8
	cmove	%rax, %r8
.L1607:
	movl	4(%r13), %eax
	leaq	.LC174(%rip), %rdx
	testl	%eax, %eax
	je	.L1609
	leaq	.LC173(%rip), %rdx
.L1609:
	xorl	%eax, %eax
	movq	%r15, %rcx
	leaq	.LC177(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$2, 24(%r13)
	jne	.L1602
	movq	56(%r13), %rdi
	xorl	%r11d, %r11d
	testq	%rdi, %rdi
	je	.L1610
	cmpl	$1, (%rdi)
	je	.L1634
.L1610:
	cmpq	$0, 32(%r13)
	je	.L1611
	movq	48(%r13), %rax
	movq	%r11, %rdx
	cmpq	%rax, %r11
	cmovb	%rax, %r11
	testq	%rax, %rax
	cmovle	%rdx, %r11
.L1611:
	call	edge_tail_words_top
	movq	%r15, %rdx
	leaq	.LC178(%rip), %rsi
	movq	%rbp, %rdi
	leaq	(%rax,%r11), %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	xorl	%eax, %eax
	addq	$1, %rbx
	call	fprintf@PLT
	cmpq	8(%r12), %rbx
	jb	.L1613
.L1599:
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
.L1631:
	.cfi_restore_state
	movq	8(%r14), %rsi
	movq	(%rsp), %r8
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbp, %rdi
	call	emit_stmt
	jmp	.L1602
	.p2align 4,,10
	.p2align 3
.L1632:
	movq	16(%r13), %rdx
	movq	%rdx, %rdi
	movq	%rdx, 8(%rsp)
	call	global_data_kind
	testl	%eax, %eax
	je	.L1602
	movl	8(%r13), %esi
	testl	%esi, %esi
	je	.L1606
	movq	8(%rsp), %rdx
	movq	%r15, %rcx
	movq	%r15, %r9
	movq	%r15, %r8
	leaq	.LC175(%rip), %rsi
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
	jmp	.L1602
	.p2align 4,,10
	.p2align 3
.L1633:
	movq	24(%rdi), %r11
	jmp	.L1608
	.p2align 4,,10
	.p2align 3
.L1606:
	movq	%r15, %rdx
	leaq	.LC176(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1602
.L1634:
	movq	24(%rdi), %r11
	jmp	.L1610
	.cfi_endproc
.LFE64:
	.size	emit_global_declarations, .-emit_global_declarations
	.section	.rodata.str1.1
.LC179:
	.string	"{\n    B_FRAME;\n"
	.section	.rodata.str1.8
	.align 8
.LC180:
	.string	"    size_t __bcc_count = __bcc_current_call ? __bcc_current_call->count : 0;\n"
	.align 8
.LC181:
	.string	"    if (__bcc_count < %zu) __bcc_count = %zu;\n"
	.align 8
.LC182:
	.string	"    word __bcc_parameters[__bcc_count];\n    for (size_t __bcc_i = 0; __bcc_i < __bcc_count; ++__bcc_i)\n        __bcc_parameters[__bcc_i] = __bcc_current_call && __bcc_i < __bcc_current_call->count\n            ? __bcc_current_call->arguments[__bcc_i] : 0;\n"
	.align 8
.LC183:
	.string	"    (void)B_LOCAL_PTR_N(__bcc_parameters, sizeof(__bcc_parameters));\n"
	.align 8
.LC184:
	.string	"    static word __b_label_value_%zu = %zu;\n"
	.section	.rodata.str1.1
.LC185:
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
	movq	%rsi, %r14
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rdx, %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
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
	leaq	.LC179(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%r14)
	jne	.L1648
.L1637:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L1649
.L1639:
	cmpq	$0, 8+function_labels(%rip)
	je	.L1643
	xorl	%ebx, %ebx
	leaq	.LC184(%rip), %r12
	.p2align 4
	.p2align 3
.L1644:
	addq	$1, %rbx
	xorl	%eax, %eax
	movq	%r12, %rsi
	movq	%rbp, %rdi
	movq	%rbx, %rcx
	movq	%rbx, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %rbx
	jb	.L1644
.L1643:
	movq	32(%r14), %rsi
	movq	%r13, %r8
	movq	%rbp, %rdi
	movl	$1, %ecx
	movl	$1, %edx
	call	emit_stmt
	movq	%rbp, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC185(%rip), %rdi
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
.L1648:
	.cfi_restore_state
	movq	%rbp, %rcx
	movl	$77, %edx
	movl	$1, %esi
	leaq	.LC180(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r14), %rdx
	movq	%rbp, %rdi
	xorl	%eax, %eax
	leaq	.LC181(%rip), %rsi
	movq	%rdx, %rcx
	call	fprintf@PLT
	movq	%rbp, %rcx
	movl	$255, %edx
	movl	$1, %esi
	leaq	.LC182(%rip), %rdi
	call	fwrite@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L1637
	movq	%rbp, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC183(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1637
	.p2align 4,,10
	.p2align 3
.L1649:
	movq	32(%r14), %rdi
	pxor	%xmm0, %xmm0
	movq	%rsp, %rsi
	movq	$0, 16(%rsp)
	movaps	%xmm0, (%rsp)
	call	collect_function_autos
	cmpq	$0, 8(%rsp)
	je	.L1640
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1641:
	movq	(%rsp), %rax
	movq	%r13, %rcx
	movl	$1, %edx
	movq	%rbp, %rdi
	movq	(%rax,%rbx,8), %rsi
	addq	$1, %rbx
	call	emit_auto_storage
	cmpq	8(%rsp), %rbx
	jb	.L1641
.L1640:
	cmpq	$0, g_compilation_arena(%rip)
	jne	.L1639
	movq	(%rsp), %rdi
	call	free@PLT
	jmp	.L1639
	.cfi_endproc
.LFE60:
	.size	emit_function_body, .-emit_function_body
	.section	.rodata.str1.1
.LC186:
	.string	"#define BCC_USE_CURSES 1\n"
	.section	.rodata.str1.8
	.align 8
.LC187:
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
.LC188:
	.string	"#define __bcc_strict_runtime %d\n"
	.section	.rodata.str1.1
.LC189:
	.string	"#define B_BYTEPTR %d\n"
.LC190:
	.string	"#define WORD_BITS %d\n"
	.section	.rodata.str1.8
	.align 8
.LC191:
	.ascii	"/*\n  Word size emulation:\n    WORD_BITS=0   -> wrap at the"
	.ascii	" host pointer width\n    WORD_BITS=16  -> wrap arithmetic li"
	.ascii	"ke PDP-11 16-bit words\n    WORD_BITS=32  -> wrap arithmetic"
	.ascii	" at 32 bits\n  WVAL(x) sign-extends to word width after mask"
	.ascii	"ing.\n*/\n#if WORD_BITS == 16\n  #define WORD_MASK 0xFFFFU\n"
	.ascii	"  #define WVAL(x) ((word)(int16_t)((x) & WORD_MASK))\n  #def"
	.ascii	"ine SHIFT_MASK 15\n#elif WORD_BITS == 32\n  #define WORD_MAS"
	.ascii	"K 0xFFFFFFFFU\n  #define WVAL(x) ((word)(int32_t)((x) & WORD"
	.ascii	"_MASK))\n  #define SHIFT_MASK 31\n#else\n  #define WORD_MASK"
	.ascii	" (~(uword)0)\n  #define WVAL(x) ((word)(x))\n  #define SHIFT"
	.ascii	"_MASK ((int)(sizeof(word)*8 - 1))\n#endif\n\n/*\n * Safe ari"
	.ascii	"thmetic macros - avoid host-C undefined behavior:\n *   - Al"
	.ascii	"l arithmetic done in unsigned to prevent signed overflow UB\n"
	.ascii	" *   - Shift counts masked to valid range to prevent shift >"
	.ascii	"= width UB\n *   - Results wrapped with WVAL() for proper wo"
	.ascii	"rd semantics\n */\n#define WADD(a,b) WVAL((uword)(a) + (uwor"
	.ascii	"d)(b))\n#define WSUB(a,b) WVAL((uword)(a) - (uword)(b))\n#de"
	.ascii	"fine WMUL(a,b) WVAL((uword)(a) * (uword)(b))\n#define WDIV(a"
	.ascii	",b) __b_word_div((a),(b))\n#define WMOD(a,b) __b_word_mod((a"
	.ascii	"),(b))\n#defi"
	.string	"ne WSHL(a,n) __b_word_shl((a),(n))\n#define WSHR(a,n) __b_word_shr((a),(n))\n#define WAND(a,b) WVAL((uword)(a) & (uword)(b))\n#define WOR(a,b)  WVAL((uword)(a) | (uword)(b))\n#define WXOR(a,b) WVAL((uword)(a) ^ (uword)(b))\n#define WNEG(a)   WVAL(-(uword)(a))\n\n"
	.section	.rodata.str1.1
.LC192:
	.string	"%s/btarget.h"
	.section	.rodata.str1.8
	.align 8
.LC193:
	.string	"#define B_TARGET_DEFINE\n#define B_TARGET_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC194:
	.string	"%s/binit.h"
	.section	.rodata.str1.8
	.align 8
.LC195:
	.string	"#define B_INIT_DEFINE\n#define B_INIT_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC196:
	.string	"%s/bcall.h"
	.section	.rodata.str1.8
	.align 8
.LC197:
	.string	"#define B_CALL_DEFINE\n#define B_CALL_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC198:
	.string	"%s/bunix.h"
	.section	.rodata.str1.8
	.align 8
.LC199:
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
	.ascii	"n __b_argvb[idx];\n}\n\nstatic word b_reread(void) {\n    if"
	.ascii	" (__b_argc <= 1) return 0;\n\n    /* A pipe can block before"
	.ascii	" its reader starts. Stage the replay in an\n       anonymous"
	.ascii	" seekable file instead, preserving empty argument fields. */"
	.ascii	"\n    FILE *stream = tmpfile();\n    if (!stream) {\n       "
	.ascii	" fprintf(stderr, \"reread: cannot create replay file\\n\");\n"
	.ascii	"        exit(1);\n    }\n    for (int i = 0; i < __b_argc; +"
	.ascii	"+i) {\n        size_t length = strlen(__b_argv[i]);\n       "
	.ascii	" if (fwrite(__b_argv[i], 1, length, stream) != length ||\n  "
	.ascii	"          fputc(i + 1 < __b_argc ? ' ' : '\\n', stream) == E"
	.ascii	"OF)\n            goto failed;\n    }\n    if (fflush(stream)"
	.ascii	" != 0 || fseek(stream, 0, SEEK_SET) != 0) goto failed;\n    "
	.ascii	"int descriptor = dup(fileno(stream));\n    if (descriptor < "
	.ascii	"0) goto failed;\n    fclose(stream);\n    __b_sync_rd();\n  "
	.ascii	"  if (rd_fd != 0) close(rd_fd);\n    rd_fd = descriptor;\n  "
	.ascii	"  rd_unit = (word)descriptor;\n    return 0;\n\nfailed:\n   "
	.ascii	" fclose(stream);\n    fprintf(stderr, \"reread: cannot stage"
	.ascii	" command line\\n\");\n    exit(1);\n}\n\n/* I/O functions */"
	.ascii	"\nstatic word b_getchr(void) {\n  "
	.ascii	"  __b_sync_rd();\n    unsigned char c;\n    ssize_t n = read"
	.ascii	"(rd_fd, &c, 1);\n    if (n == 1) return (word)c;\n    if (rd"
	.ascii	"_fd != 0) {\n        close(rd_fd);\n        rd_fd = 0;\n    "
	.ascii	"    rd_unit = -1;\n        return b_getchr();\n    }\n    re"
	.ascii	"turn (word)004; /* Return *e on EOF */\n}\nstatic word b_put"
	.ascii	"chr(word w) {\n    __b_sync_wr();\n    unsigned char c = (un"
	.ascii	"signed char)(w & 0xFF);\n    (void)write(wr_fd, &c, 1);\n   "
	.ascii	" return w;\n}\nstatic word b_putstr(word s) {\n    __b_sync_"
	.ascii	"wr();\n    word i = 0;\n    for (;;) {\n        word ch = __"
	.ascii	"bcc_library_call2(\"char\", b_char, s, i++);\n        if (ch"
	.ascii	" == 004 || (!__bcc_strict_runtime && ch == 0)) break;\n     "
	.ascii	"   __bcc_library_call1(\"putchar\", b_putchar, ch);\n    }\n"
	.ascii	"    return s;\n}\nstatic word b_getstr(word buf) {\n    word"
	.ascii	" i = 0;\n    for (;;) {\n        word c = __bcc_library_call"
	.ascii	"0(\"getchar\", b_getchar);\n        if (c == 004 || c == '\\"
	.ascii	"n' || (!__bcc_strict_runtime && c == '\\r')) break;\n       "
	.ascii	" __bcc_library_call3(\"lchar\", b_lchar, buf, i++, c);\n    "
	.ascii	"}\n    __bcc_librar"
	.string	"y_call3(\"lchar\", b_lchar, buf, i, 004);\n    return __bcc_strict_runtime ? i : buf;\n}\nstatic word b_flush(void){\n    __b_sync_wr();\n    if (wr_fd == 1) {\n        fflush(stdout);\n    } else {\n        fsync(wr_fd);\n    }\n    return 0;\n}\n\n#include <stdarg.h>\n\n"
	.section	.rodata.str1.1
.LC200:
	.string	"%s/bformat.h"
	.section	.rodata.str1.8
	.align 8
.LC201:
	.string	"#define __bcc_format_linkage static\n"
	.align 8
.LC202:
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
	.ascii	"   __bcc_library_call2(\"printn\", "
	.ascii	"b_printn, n, (word)10);\n    return n;\n}\nstatic volatile s"
	.ascii	"ig_atomic_t __b_got_intr = 0;\n\nstatic void __b_sigint(int "
	.ascii	"sig){ (void)sig; __b_got_intr = 1; }\n\nstatic word b_gtty(w"
	.ascii	"ord fd, word ttstat){\n    struct termios t;\n    if (tcgeta"
	.ascii	"ttr((int)fd, &t) < 0) return -1;\n\n    word *vec = (word*)B"
	.ascii	"_CPTR(ttstat);\n    vec[0] = (word)t.c_iflag;\n    vec[1] = "
	.ascii	"(word)t.c_oflag;\n    vec[2] = (word)t.c_lflag;\n    return "
	.ascii	"0;\n}\n\nstatic word b_stty(word fd, word ttstat){\n    stru"
	.ascii	"ct termios t;\n    if (tcgetattr((int)fd, &t) < 0) return -1"
	.ascii	";\n\n    word *vec = (word*)B_CPTR(ttstat);\n    t.c_iflag ="
	.ascii	" (tcflag_t)vec[0];\n    t.c_oflag = (tcflag_t)vec[1];\n    t"
	.ascii	".c_lflag = (tcflag_t)vec[2];\n    return (word)tcsetattr((in"
	.ascii	"t)fd, TCSANOW, &t);\n}\nstatic word b_intr(word on) {\n    /"
	.ascii	"* Set up interrupt handling */\n    /* on != 0: catch interr"
	.ascii	"upts, on =="
	.string	" 0: restore default */\n    if (on) {\n        __b_got_intr = 0;\n        if (signal(SIGINT, __b_sigint) == SIG_ERR) return -1;\n    } else {\n        if (signal(SIGINT, SIG_DFL) == SIG_ERR) return -1;\n    }\n    return 0;\n}\n\n/* Builtin aliases for B source */\n\n"
	.section	.rodata.str1.1
.LC203:
	.string	"word __b_user_main("
.LC204:
	.string	"void)\n"
	.section	.rodata.str1.8
	.align 8
.LC205:
	.string	"int main(int argc, char **argv){\n"
	.section	.rodata.str1.1
.LC206:
	.string	"    __b_setargs(argc, argv);\n"
.LC207:
	.string	"    __b_init();\n"
	.section	.rodata.str1.8
	.align 8
.LC208:
	.string	"    return (int)__bcc_call%zu("
	.section	.rodata.str1.1
.LC209:
	.string	", (word)argc"
.LC210:
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
	movl	%r9d, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	movq	%rsi, %rdi
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movaps	%xmm0, external_calls(%rip)
	pxor	%xmm0, %xmm0
	movq	%rdx, 8(%rsp)
	movq	%rsi, current_program(%rip)
	movl	%ecx, current_byteptr(%rip)
	movl	%r9d, current_word_bits(%rip)
	movq	$0, 16+external_calls(%rip)
	movq	$0, string_pool(%rip)
	movq	$0, 8+name_map(%rip)
	movups	%xmm0, 8+string_pool(%rip)
	call	collect_strings_program
	movl	g_use_curses(%rip), %edx
	testl	%edx, %edx
	jne	.L1672
.L1651:
	movq	%rbx, %rcx
	movl	$1529, %edx
	movl	$1, %esi
	leaq	.LC187(%rip), %rdi
	call	fwrite@PLT
	movl	g_strict(%rip), %eax
	xorl	%edx, %edx
	movq	%rbx, %rdi
	leaq	.LC188(%rip), %rsi
	testl	%eax, %eax
	setne	%dl
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbx, %rdi
	setne	%dl
	leaq	.LC189(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%r12d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC190(%rip), %rsi
	leaq	24(%rsp), %r12
	call	fprintf@PLT
	movq	%rbx, %rcx
	movl	$1378, %edx
	movl	$1, %esi
	leaq	.LC191(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC192(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$73, %edx
	movl	$1, %esi
	leaq	.LC193(%rip), %rdi
	movq	%rax, %r13
	call	fwrite@PLT
	movq	24(%rsp), %rdx
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
	leaq	.LC194(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC195(%rip), %rdi
	movq	%rax, %r13
	call	fwrite@PLT
	movq	24(%rsp), %rdx
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
	leaq	.LC196(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	movq	%rax, %r14
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC197(%rip), %rdi
	movq	%rax, %r13
	call	fwrite@PLT
	movq	24(%rsp), %rdx
	movq	%rbx, %rcx
	movq	%r13, %rdi
	movl	$1, %esi
	call	fwrite@PLT
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	movq	%r13, %rdi
	call	free@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L1673
.L1652:
	movq	g_libb_path(%rip), %rsi
	leaq	.LC198(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	24(%rsp), %rdx
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
	movl	$11250, %edx
	movl	$1, %esi
	leaq	.LC199(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC200(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$36, %edx
	movl	$1, %esi
	leaq	.LC201(%rip), %rdi
	movq	%rax, %r12
	call	fwrite@PLT
	movq	24(%rsp), %rdx
	movq	%rbx, %rcx
	movq	%r12, %rdi
	movl	$1, %esi
	call	fwrite@PLT
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	movq	%r12, %rdi
	call	free@PLT
	movq	%rbx, %rcx
	movl	$13077, %edx
	movl	$1, %esi
	leaq	.LC202(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1674
.L1653:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	emit_function_prototypes
	movq	8(%rsp), %r14
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	movq	%r14, %rdx
	call	emit_global_declarations
	movq	%r14, %rdx
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	emit_global_initializers
	cmpq	$0, 8(%rbp)
	je	.L1650
	xorl	%r15d, %r15d
	xorl	%r13d, %r13d
	xorl	%r14d, %r14d
	jmp	.L1658
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1655:
	addq	$1, %r15
	cmpq	8(%rbp), %r15
	jnb	.L1675
.L1658:
	movq	0(%rbp), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L1655
	movq	8(%rax), %r12
	leaq	.LC12(%rip), %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1656
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	movq	16(%r12), %r13
	leaq	.LC203(%rip), %rdi
	movl	$1, %r14d
	call	fwrite@PLT
.L1657:
	movq	%rbx, %rcx
	movl	$6, %edx
	movl	$1, %esi
	addq	$1, %r15
	leaq	.LC204(%rip), %rdi
	call	fwrite@PLT
	movq	8(%rsp), %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_function_body
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	8(%rbp), %r15
	jb	.L1658
.L1675:
	testl	%r14d, %r14d
	jne	.L1676
.L1650:
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
.L1656:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC20(%rip), %rdi
	call	fwrite@PLT
	movq	(%r12), %rsi
	movq	%rbx, %rdi
	call	emit_function_body_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1657
	.p2align 4,,10
	.p2align 3
.L1672:
	movq	%rbx, %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC186(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1651
	.p2align 4,,10
	.p2align 3
.L1676:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC205(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC206(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC207(%rip), %rdi
	call	fwrite@PLT
	movl	$2, %edx
	leaq	.LC208(%rip), %rsi
	movq	%rbx, %rdi
	cmpq	%rdx, %r13
	cmovbe	%r13, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	leaq	.LC12(%rip), %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC27(%rip), %rdi
	call	fwrite@PLT
	testq	%r13, %r13
	jne	.L1677
.L1662:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC22(%rip), %rdi
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
.L1674:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1653
	.p2align 4,,10
	.p2align 3
.L1673:
	movq	%r14, %rdi
	call	free@PLT
	jmp	.L1652
	.p2align 4,,10
	.p2align 3
.L1677:
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC209(%rip), %rdi
	call	fwrite@PLT
	cmpq	$1, %r13
	je	.L1662
	movq	%rbx, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC210(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1662
	.cfi_endproc
.LFE66:
	.size	emit_program_c, .-emit_program_c
	.section	.rodata.str1.8
	.align 8
.LC211:
	.string	"/* Generated by BCC - B Compiler */\n"
	.section	.rodata.str1.1
.LC212:
	.string	"#include \"libb.h\"\n\n"
	.section	.rodata.str1.8
	.align 8
.LC213:
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
	movq	%rsi, %r14
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
	movq	%rdx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movl	80(%rsp), %edi
	testl	%edi, %edi
	je	.L1700
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
	leaq	.LC211(%rip), %rdi
	call	fwrite@PLT
	movl	g_strict(%rip), %ecx
	xorl	%edx, %edx
	movq	%rbx, %rdi
	leaq	.LC188(%rip), %rsi
	testl	%ecx, %ecx
	setne	%dl
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbx, %rdi
	setne	%dl
	leaq	.LC189(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%r12d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC190(%rip), %rsi
	call	fprintf@PLT
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$19, %edx
	leaq	.LC212(%rip), %rdi
	call	fwrite@PLT
	movl	g_use_curses(%rip), %esi
	testl	%esi, %esi
	jne	.L1701
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1702
.L1681:
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_function_prototypes
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_global_declarations
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_global_initializers
	cmpq	$0, 8(%r14)
	je	.L1678
	movl	$0, 12(%rsp)
	xorl	%r15d, %r15d
	xorl	%r13d, %r13d
	jmp	.L1686
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1683:
	addq	$1, %r15
	cmpq	8(%r14), %r15
	jnb	.L1703
.L1686:
	movq	(%r14), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L1683
	movq	8(%rax), %r12
	leaq	.LC12(%rip), %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1684
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	movq	16(%r12), %r13
	leaq	.LC203(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 12(%rsp)
.L1685:
	movq	%rbx, %rcx
	movl	$6, %edx
	movl	$1, %esi
	addq	$1, %r15
	leaq	.LC204(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_function_body
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	8(%r14), %r15
	jb	.L1686
.L1703:
	movl	12(%rsp), %eax
	testl	%eax, %eax
	jne	.L1704
.L1678:
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
.L1684:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC20(%rip), %rdi
	call	fwrite@PLT
	movq	(%r12), %rsi
	movq	%rbx, %rdi
	call	emit_function_body_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1685
	.p2align 4,,10
	.p2align 3
.L1702:
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1681
	.p2align 4,,10
	.p2align 3
.L1701:
	movq	%rbx, %rcx
	movl	$41, %edx
	movl	$1, %esi
	leaq	.LC213(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	je	.L1681
	jmp	.L1702
	.p2align 4,,10
	.p2align 3
.L1704:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC205(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC206(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC207(%rip), %rdi
	call	fwrite@PLT
	movl	$2, %edx
	leaq	.LC208(%rip), %rsi
	movq	%rbx, %rdi
	cmpq	%rdx, %r13
	cmovbe	%r13, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	leaq	.LC12(%rip), %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC27(%rip), %rdi
	call	fwrite@PLT
	testq	%r13, %r13
	jne	.L1705
.L1690:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC22(%rip), %rdi
	call	fwrite@PLT
	addq	$24, %rsp
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
	addq	$24, %rsp
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
.L1705:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC209(%rip), %rdi
	call	fwrite@PLT
	cmpq	$1, %r13
	je	.L1690
	movq	%rbx, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC210(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1690
	.cfi_endproc
.LFE67:
	.size	emit_program_c_ext, .-emit_program_c_ext
	.section	.rodata
	.align 16
	.type	CSWTCH.183, @object
	.size	CSWTCH.183, 24
CSWTCH.183:
	.long	24
	.long	25
	.long	26
	.long	27
	.long	22
	.long	23
	.section	.rodata.str1.1
.LC214:
	.string	"lchar"
.LC215:
	.string	"getchar"
.LC216:
	.string	"getchr"
.LC217:
	.string	"putchr"
.LC218:
	.string	"getstr"
.LC219:
	.string	"putstr"
.LC220:
	.string	"flush"
.LC221:
	.string	"reread"
.LC222:
	.string	"printn"
.LC223:
	.string	"putnum"
.LC224:
	.string	"print"
.LC225:
	.string	"putchar"
.LC226:
	.string	"abort"
.LC227:
	.string	"free"
.LC228:
	.string	"alloc"
.LC229:
	.string	"open"
.LC230:
	.string	"close"
.LC231:
	.string	"read"
.LC232:
	.string	"write"
.LC233:
	.string	"creat"
.LC234:
	.string	"seek"
.LC235:
	.string	"openr"
.LC236:
	.string	"openw"
.LC237:
	.string	"fork"
.LC238:
	.string	"wait"
.LC239:
	.string	"execl"
.LC240:
	.string	"execv"
.LC241:
	.string	"chdir"
.LC242:
	.string	"chmod"
.LC243:
	.string	"chown"
.LC244:
	.string	"link"
.LC245:
	.string	"unlink"
.LC246:
	.string	"stat"
.LC247:
	.string	"fstat"
.LC248:
	.string	"time"
.LC249:
	.string	"ctime"
.LC250:
	.string	"getuid"
.LC251:
	.string	"setuid"
.LC252:
	.string	"makdir"
.LC253:
	.string	"mkdir"
.LC254:
	.string	"intr"
.LC255:
	.string	"gtty"
.LC256:
	.string	"stty"
.LC257:
	.string	"system"
.LC258:
	.string	"usleep"
.LC259:
	.string	"argc"
	.section	.data.rel.ro.local,"aw"
	.align 32
	.type	names.0, @object
	.size	names.0, 416
names.0:
	.quad	.LC3
	.quad	.LC214
	.quad	.LC215
	.quad	.LC216
	.quad	.LC217
	.quad	.LC218
	.quad	.LC219
	.quad	.LC220
	.quad	.LC221
	.quad	.LC65
	.quad	.LC222
	.quad	.LC223
	.quad	.LC224
	.quad	.LC225
	.quad	.LC71
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
	.quad	.LC59
	.quad	.LC259
	.quad	.LC24
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
.LC260:
	.string	"break"
.LC261:
	.string	"case"
.LC262:
	.string	"const"
.LC263:
	.string	"continue"
.LC264:
	.string	"default"
.LC265:
	.string	"do"
.LC266:
	.string	"double"
.LC267:
	.string	"else"
.LC268:
	.string	"enum"
.LC269:
	.string	"extern"
.LC270:
	.string	"float"
.LC271:
	.string	"for"
.LC272:
	.string	"goto"
.LC273:
	.string	"if"
.LC274:
	.string	"inline"
.LC275:
	.string	"int"
.LC276:
	.string	"long"
.LC277:
	.string	"register"
.LC278:
	.string	"restrict"
.LC279:
	.string	"short"
.LC280:
	.string	"signed"
.LC281:
	.string	"sizeof"
.LC282:
	.string	"static"
.LC283:
	.string	"struct"
.LC284:
	.string	"switch"
.LC285:
	.string	"typedef"
.LC286:
	.string	"union"
.LC287:
	.string	"unsigned"
.LC288:
	.string	"volatile"
.LC289:
	.string	"while"
.LC290:
	.string	"_Bool"
.LC291:
	.string	"_Complex"
.LC292:
	.string	"_Imaginary"
.LC293:
	.string	"_Alignas"
.LC294:
	.string	"_Alignof"
.LC295:
	.string	"_Atomic"
.LC296:
	.string	"_Generic"
.LC297:
	.string	"_Noreturn"
.LC298:
	.string	"_Static_assert"
.LC299:
	.string	"_Thread_local"
.LC300:
	.string	"NULL"
.LC301:
	.string	"true"
.LC302:
	.string	"false"
.LC303:
	.string	"bool"
.LC304:
	.string	"word"
.LC305:
	.string	"B_PTR"
.LC306:
	.string	"B_ADDR"
.LC307:
	.string	"B_DEREF"
	.section	.data.rel.ro.local
	.align 32
	.type	c_keywords, @object
	.size	c_keywords, 424
c_keywords:
	.quad	.LC4
	.quad	.LC260
	.quad	.LC261
	.quad	.LC3
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
	.quad	.LC151
	.quad	.LC279
	.quad	.LC280
	.quad	.LC281
	.quad	.LC282
	.quad	.LC283
	.quad	.LC284
	.quad	.LC285
	.quad	.LC286
	.quad	.LC287
	.quad	.LC21
	.quad	.LC288
	.quad	.LC289
	.quad	.LC290
	.quad	.LC291
	.quad	.LC292
	.quad	.LC293
	.quad	.LC294
	.quad	.LC295
	.quad	.LC296
	.quad	.LC297
	.quad	.LC298
	.quad	.LC299
	.quad	.LC300
	.quad	.LC301
	.quad	.LC302
	.quad	.LC303
	.quad	.LC304
	.quad	.LC305
	.quad	.LC306
	.quad	.LC307
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
