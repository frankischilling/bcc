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
	.string	"__bcc_bs_"
.LC7:
	.string	"identifier is too long"
.LC8:
	.string	"%02x"
.LC9:
	.string	"%02X"
.LC10:
	.string	"_%02X"
.LC11:
	.string	"__bcc_user_%c_%s"
.LC12:
	.string	"%s_%d"
.LC13:
	.string	"__bcc_keyword_%s"
.LC14:
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
	je	.L222
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
	je	.L259
	movq	%rbx, %rdi
	call	strlen@PLT
	movl	$8, %esi
	movq	%rbx, %rdi
	movq	%rax, %r15
	call	strchr@PLT
	testq	%rax, %rax
	je	.L260
.L182:
	movabsq	$9223372036854775802, %rax
	cmpq	%r15, %rax
	jb	.L261
	leaq	10(%r15,%r15), %r13
	movq	%r13, %rdi
	call	xmalloc@PLT
	movq	%rax, %r14
	movabsq	$8314312742553149279, %rax
	movq	%rax, (%r14)
	movb	$95, 8(%r14)
	testq	%r15, %r15
	je	.L181
.L185:
	leaq	-1(%r14,%r13), %r15
	movq	%rbx, %r12
	leaq	9(%r14), %rbp
	leaq	.LC8(%rip), %r13
	.p2align 4
	.p2align 3
.L187:
	movzbl	(%r12), %edx
	movq	%rbp, %rdi
	movq	%r13, %rsi
	xorl	%eax, %eax
	addq	$2, %rbp
	addq	$1, %r12
	call	sprintf@PLT
	cmpq	%r15, %rbp
	jne	.L187
.L181:
	movl	g_strict(%rip), %edx
	testl	%edx, %edx
	jne	.L203
	movq	%rbx, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L203
	leaq	8+names.0(%rip), %rbp
	leaq	.LC3(%rip), %rsi
	jmp	.L204
	.p2align 4,,10
	.p2align 3
.L263:
	movq	0(%rbp), %rsi
	addq	$8, %rbp
	testq	%rsi, %rsi
	je	.L262
.L204:
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L263
	.p2align 4
	.p2align 3
.L203:
	movq	%r14, %rdi
	call	strlen@PLT
	leaq	14(%rax), %rdi
	call	xmalloc@PLT
	movl	$98, %edx
	movq	%rax, %r13
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L264
.L206:
	xorl	%eax, %eax
	movq	%r14, %rcx
	leaq	.LC11(%rip), %rsi
	movq	%r13, %rdi
	call	sprintf@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L265
.L221:
	leaq	8+c_keywords(%rip), %rbp
	leaq	.LC4(%rip), %rsi
	jmp	.L210
	.p2align 4,,10
	.p2align 3
.L266:
	movq	0(%rbp), %rsi
	addq	$8, %rbp
	testq	%rsi, %rsi
	je	.L211
.L210:
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L266
	movq	%r13, %rdi
	call	strlen@PLT
	leaq	15(%rax), %rdi
	call	xmalloc@PLT
	movq	%r13, %rdx
	leaq	.LC13(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %rbp
	xorl	%eax, %eax
	call	sprintf@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L267
.L220:
	movq	%rbp, %r13
.L211:
	movq	8+name_map(%rip), %r12
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
	testq	%r12, %r12
	je	.L212
	movq	name_map(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L214
	.p2align 4,,10
	.p2align 3
.L269:
	addq	$1, %rbp
	cmpq	%rbp, %r12
	je	.L268
.L214:
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
.L216:
	leal	1(%rcx), %eax
	movq	%r13, %rdx
	leaq	.LC12(%rip), %rsi
	movq	%r12, %rdi
	movl	%eax, 12(%rsp)
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	8+name_map(%rip), %rbp
	testq	%rbp, %rbp
	je	.L215
	movq	(%rsp), %rax
	xorl	%r15d, %r15d
	movq	(%rax), %r14
	jmp	.L217
	.p2align 4,,10
	.p2align 3
.L270:
	addq	$1, %r15
	cmpq	%rbp, %r15
	je	.L215
.L217:
	movq	(%r14,%r15,8), %rax
	movq	%r12, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L270
	movl	12(%rsp), %ecx
	jmp	.L216
.L260:
	movl	$9, %edx
	leaq	.LC6(%rip), %rsi
	movq	%rbx, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	je	.L182
	leaq	16(,%r15,4), %rdi
	call	xmalloc@PLT
	movzbl	(%rbx), %edx
	movq	%rax, %r14
	leaq	1(%rax), %r13
	leal	-65(%rdx), %eax
	cmpb	$57, %al
	ja	.L188
	movabsq	$288230372997595135, %rcx
	btq	%rax, %rcx
	jnc	.L188
	movb	%dl, (%r14)
.L192:
	leaq	1(%rbx), %rbp
	leaq	(%rbx,%r15), %rcx
	movabsq	$288230372997595135, %r12
	cmpq	$1, %r15
	ja	.L202
	jmp	.L194
	.p2align 4,,10
	.p2align 3
.L195:
	leal	-65(%rax), %edx
	cmpb	$57, %dl
	ja	.L198
	btq	%rdx, %r12
	jnc	.L198
.L196:
	movb	%al, 0(%r13)
	addq	$1, %r13
.L201:
	addq	$1, %rbp
	cmpq	%rcx, %rbp
	je	.L194
.L202:
	movzbl	0(%rbp), %eax
	cmpb	$57, %al
	jg	.L195
	cmpb	$47, %al
	jg	.L196
	cmpb	$46, %al
	jne	.L198
	movb	$95, 0(%r13)
	addq	$1, %r13
	jmp	.L201
.L261:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	leaq	10(%r15,%r15), %r13
	call	dief@PLT
	movq	%r13, %rdi
	call	xmalloc@PLT
	movq	%rax, %r14
	movabsq	$8314312742553149279, %rax
	movq	%rax, (%r14)
	movb	$95, 8(%r14)
	jmp	.L185
	.p2align 4,,10
	.p2align 3
.L268:
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
.L212:
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
	.p2align 4,,10
	.p2align 3
.L259:
	leaq	.LC5(%rip), %rdi
	call	sdup@PLT
	movq	%rax, %r14
	jmp	.L181
	.p2align 4,,10
	.p2align 3
.L215:
	cmpq	$0, g_compilation_arena(%rip)
	je	.L271
.L218:
	movq	%r12, %r13
	jmp	.L212
	.p2align 4,,10
	.p2align 3
.L264:
	movq	%rbx, %rdi
	call	source_function
	movl	$102, %edx
	testl	%eax, %eax
	jne	.L206
	leaq	8+names.0(%rip), %rbp
	leaq	.LC3(%rip), %rsi
	jmp	.L207
	.p2align 4,,10
	.p2align 3
.L273:
	movq	0(%rbp), %rsi
	addq	$8, %rbp
	testq	%rsi, %rsi
	je	.L272
.L207:
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L273
	movl	$114, %edx
	jmp	.L206
.L222:
	xorl	%r13d, %r13d
	jmp	.L175
.L265:
	movq	%r14, %rdi
	call	free@PLT
	jmp	.L221
.L262:
	movl	$6, %edx
	leaq	.LC14(%rip), %rsi
	movq	%rbx, %rdi
	movq	%r14, %r13
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L221
	jmp	.L203
.L188:
	movb	$95, (%r14)
	movzbl	(%rbx), %eax
	cmpb	$46, %al
	jne	.L274
	movb	$95, 1(%r14)
	leaq	2(%r14), %r13
	jmp	.L192
.L198:
	movzbl	%al, %edx
	movq	%r13, %rdi
	leaq	.LC10(%rip), %rsi
	xorl	%eax, %eax
	movq	%rcx, (%rsp)
	addq	$3, %r13
	call	sprintf@PLT
	movq	(%rsp), %rcx
	jmp	.L201
.L194:
	movb	$0, 0(%r13)
	jmp	.L181
.L272:
	movl	$120, %edx
	jmp	.L206
.L267:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L220
.L271:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L218
.L274:
	movzbl	%al, %edx
	movq	%r13, %rdi
	leaq	.LC9(%rip), %rsi
	xorl	%eax, %eax
	call	sprintf@PLT
	leaq	3(%r14), %r13
	jmp	.L192
	.cfi_endproc
.LFE24:
	.size	get_mangled_name, .-get_mangled_name
	.section	.rodata.str1.1
.LC15:
	.string	"main"
.LC16:
	.string	"__b_user_main"
.LC17:
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
	leaq	.LC15(%rip), %rsi
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
	jne	.L276
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movl	$13, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 16
	leaq	.LC16(%rip), %rdi
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L276:
	.cfi_restore_state
	movl	$1, %esi
	movl	$11, %edx
	leaq	.LC17(%rip), %rdi
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
.LC18:
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
	leaq	.LC15(%rip), %rsi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rbp, %rdi
	leaq	8+names.0(%rip), %rbx
	call	strcmp@PLT
	leaq	.LC3(%rip), %rsi
	testl	%eax, %eax
	jne	.L281
	jmp	.L288
	.p2align 4,,10
	.p2align 3
.L289:
	movq	(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L282
.L281:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L289
	movq	%rbp, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L290
.L282:
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
.L288:
	.cfi_restore_state
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%r12, %rcx
	popq	%rbp
	.cfi_def_cfa_offset 16
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC16(%rip), %rdi
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L290:
	.cfi_restore_state
	popq	%rbx
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
	.cfi_endproc
.LFE29:
	.size	emit_function_name, .-emit_function_name
	.section	.rodata.str1.1
.LC19:
	.string	"extern word "
.LC20:
	.string	"[];\n"
.LC21:
	.string	"word "
.LC22:
	.string	"[1];\n"
.LC23:
	.string	"static word "
.LC24:
	.string	"void"
.LC25:
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
	je	.L292
	xorl	%ebp, %ebp
	leaq	.LC19(%rip), %r15
	leaq	external_calls(%rip), %r14
	leaq	.LC20(%rip), %r13
	.p2align 4
	.p2align 3
.L294:
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rdi
	testq	%rdi, %rdi
	je	.L293
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L293:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addq	$1, %rbp
	cmpq	8+external_calls(%rip), %rbp
	jb	.L294
.L292:
	cmpq	$0, 8+g_known_functions(%rip)
	je	.L303
	movl	$0, 12(%rsp)
	movq	$0, (%rsp)
	.p2align 4
	.p2align 3
.L301:
	leaq	g_known_functions(%rip), %rax
	movq	(%rsp), %rdx
	movq	8(%r12), %r13
	movq	(%rax), %rax
	movq	(%r12), %r14
	movq	(%rax,%rdx,8), %rbp
	testq	%r13, %r13
	je	.L296
	xorl	%r15d, %r15d
	jmp	.L299
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L297:
	addq	$1, %r15
	cmpq	%r15, %r13
	je	.L296
.L299:
	movq	(%r14,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L297
	movq	8(%rax), %rax
	movq	%rbp, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L297
.L298:
	addq	$1, (%rsp)
	movq	(%rsp), %rax
	cmpq	8+g_known_functions(%rip), %rax
	jb	.L301
	movl	12(%rsp), %eax
	testl	%eax, %eax
	je	.L303
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
.L303:
	cmpq	$0, 8(%r12)
	je	.L291
	xorl	%r13d, %r13d
	leaq	.LC21(%rip), %r15
	leaq	.LC22(%rip), %r14
	jmp	.L307
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L305:
	addq	$1, %r13
	cmpq	8(%r12), %r13
	jnb	.L291
.L307:
	movq	(%r12), %rax
	movq	(%rax,%r13,8), %rax
	cmpl	$1, (%rax)
	jne	.L305
	movq	8(%rax), %rbp
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	0(%rbp), %rdi
	testq	%rdi, %rdi
	je	.L306
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L306:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	addq	$1, %r13
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC23(%rip), %rdi
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
	leaq	.LC24(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC25(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r12), %r13
	jb	.L307
.L291:
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
.L296:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC19(%rip), %rdi
	call	fwrite@PLT
	testq	%rbp, %rbp
	je	.L300
	movq	%rbp, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L300:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC20(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 12(%rsp)
	jmp	.L298
	.cfi_endproc
.LFE63:
	.size	emit_function_prototypes, .-emit_function_prototypes
	.section	.rodata.str1.1
.LC26:
	.string	"B_ADDR("
.LC27:
	.string	"argv"
.LC28:
	.string	"b_argv_vector"
.LC29:
	.string	"__b_external_%s"
.LC30:
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
	leaq	.LC26(%rip), %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	call	fwrite@PLT
	movq	48(%r12), %rbx
	leaq	.LC27(%rip), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L365
.L332:
	movq	%rbx, %rdi
	call	global_data_kind
	movq	%rbx, %rdi
	cmpl	$2, %eax
	je	.L366
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	48(%r12), %rbx
	movq	%rbx, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L367
.L343:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC30(%rip), %rdi
	call	fwrite@PLT
.L341:
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
.L365:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L332
	movq	8+g_known_variables(%rip), %r14
	testq	%r14, %r14
	je	.L333
	movq	g_known_variables(%rip), %r15
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L334:
	movq	(%r15,%r13,8), %rdi
	movq	%rbx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L332
	addq	$1, %r13
	cmpq	%r14, %r13
	jne	.L334
.L333:
	movq	current_program(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L335
	movq	8(%rax), %rax
	xorl	%r13d, %r13d
	movq	%rax, 16(%rsp)
	jmp	.L336
	.p2align 4,,10
	.p2align 3
.L337:
	testl	%eax, %eax
	je	.L368
.L338:
	addq	$1, %r13
.L336:
	cmpq	%r13, 16(%rsp)
	je	.L335
	movq	24(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r13,8), %rdx
	movl	(%rdx), %eax
	cmpl	$2, %eax
	jne	.L337
	movq	8(%rdx), %rax
	movq	%rbx, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L338
	jmp	.L332
	.p2align 4,,10
	.p2align 3
.L367:
	movq	%rbx, %rdi
	call	global_data_kind
	cmpl	$1, %eax
	jne	.L341
	jmp	.L343
	.p2align 4,,10
	.p2align 3
.L366:
	call	get_mangled_name
	leaq	.LC29(%rip), %rsi
	movq	%rbp, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L341
.L335:
	movq	%rbp, %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC28(%rip), %rdi
	call	fwrite@PLT
	jmp	.L341
	.p2align 4,,10
	.p2align 3
.L368:
	movq	8(%rdx), %rax
	movq	24(%rax), %rcx
	movq	%rcx, 8(%rsp)
	testq	%rcx, %rcx
	je	.L338
	movq	16(%rax), %r14
	xorl	%r15d, %r15d
	jmp	.L339
	.p2align 4,,10
	.p2align 3
.L369:
	movq	8(%rsp), %rax
	addq	$1, %r15
	cmpq	%rax, %r15
	je	.L338
.L339:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L369
	jmp	.L332
	.cfi_endproc
.LFE74:
	.size	emit_ival_expr.part.0, .-emit_ival_expr.part.0
	.p2align 4
	.type	collect_strings_expr, @function
collect_strings_expr:
.LFB33:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L409
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
	leaq	.L375(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
.L372:
	cmpl	$10, (%rbx)
	ja	.L370
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L375:
	.long	.L370-.L375
	.long	.L383-.L375
	.long	.L370-.L375
	.long	.L382-.L375
	.long	.L374-.L375
	.long	.L413-.L375
	.long	.L413-.L375
	.long	.L412-.L375
	.long	.L412-.L375
	.long	.L376-.L375
	.long	.L374-.L375
	.text
	.p2align 4,,10
	.p2align 3
.L374:
	movq	48(%rbx), %rdi
	call	collect_strings_expr
.L413:
	movq	56(%rbx), %rbx
.L390:
	testq	%rbx, %rbx
	jne	.L372
.L370:
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
.L376:
	.cfi_restore_state
	movq	48(%rbx), %rdi
	call	collect_strings_expr
.L412:
	movq	56(%rbx), %rdi
	call	collect_strings_expr
	movq	64(%rbx), %rbx
	jmp	.L390
	.p2align 4,,10
	.p2align 3
.L382:
	movl	g_strict(%rip), %edx
	movq	48(%rbx), %rbp
	testl	%edx, %edx
	jne	.L414
.L384:
	movq	%rbp, %rdi
	call	collect_strings_expr
	cmpq	$0, 64(%rbx)
	je	.L370
	xorl	%ebp, %ebp
.L389:
	movq	56(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_expr
	cmpq	64(%rbx), %rbp
	jb	.L389
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
.L383:
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
.L414:
	.cfi_restore_state
	movl	24(%rbx), %eax
	testl	%eax, %eax
	jne	.L384
	cmpl	$2, 0(%rbp)
	jne	.L384
	movq	48(%rbp), %r13
	leaq	8+names.0(%rip), %r12
	leaq	.LC3(%rip), %rsi
	jmp	.L385
	.p2align 4,,10
	.p2align 3
.L416:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L415
.L385:
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L416
	jmp	.L384
	.p2align 4,,10
	.p2align 3
.L409:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L415:
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
	jne	.L384
	movq	8+external_calls(%rip), %rax
	testq	%rax, %rax
	je	.L387
	movq	external_calls(%rip), %r12
	leaq	(%r12,%rax,8), %r15
	.p2align 4
	.p2align 3
.L388:
	movq	(%r12), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	addq	$8, %r12
	movzbl	%al, %eax
	orl	%eax, %r14d
	cmpq	%r15, %r12
	jne	.L388
	testl	%r14d, %r14d
	jne	.L384
.L387:
	movq	%r13, %rdi
	call	sdup@PLT
	leaq	external_calls(%rip), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movq	48(%rbx), %rbp
	jmp	.L384
	.cfi_endproc
.LFE33:
	.size	collect_strings_expr, .-collect_strings_expr
	.p2align 4
	.type	collect_strings_init, @function
collect_strings_init:
.LFB34:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L426
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
	je	.L429
	cmpl	$1, %eax
	je	.L430
.L417:
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
.L429:
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
.L430:
	.cfi_restore_state
	cmpq	$0, 24(%rdi)
	je	.L417
	xorl	%ebp, %ebp
.L420:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_init
	cmpq	24(%rbx), %rbp
	jb	.L420
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L426:
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
	je	.L454
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L436(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L433:
	cmpl	$12, (%rbx)
	ja	.L431
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L436:
	.long	.L431-.L436
	.long	.L443-.L436
	.long	.L431-.L436
	.long	.L442-.L436
	.long	.L435-.L436
	.long	.L439-.L436
	.long	.L439-.L436
	.long	.L431-.L436
	.long	.L431-.L436
	.long	.L431-.L436
	.long	.L439-.L436
	.long	.L437-.L436
	.long	.L435-.L436
	.text
	.p2align 4,,10
	.p2align 3
.L439:
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
.L443:
	.cfi_restore_state
	cmpq	$0, 24(%rbx)
	je	.L431
	xorl	%ebp, %ebp
.L444:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_stmt
	cmpq	24(%rbx), %rbp
	jb	.L444
.L431:
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
.L435:
	.cfi_restore_state
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rbx
.L445:
	testq	%rbx, %rbx
	jne	.L433
	jmp	.L431
	.p2align 4,,10
	.p2align 3
.L437:
	movq	24(%rbx), %rbx
	jmp	.L445
	.p2align 4,,10
	.p2align 3
.L442:
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rdi
	call	collect_strings_stmt
	movq	32(%rbx), %rbx
	jmp	.L445
	.p2align 4,,10
	.p2align 3
.L454:
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
	je	.L467
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
	jmp	.L464
	.p2align 4,,10
	.p2align 3
.L460:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L470
.L464:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L471
	cmpl	$2, %eax
	je	.L472
	testl	%eax, %eax
	jne	.L460
	movq	8(%rdx), %rdi
	addq	$1, %rbx
	call	collect_strings_stmt
	cmpq	8(%rbp), %rbx
	jb	.L464
.L470:
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
.L471:
	.cfi_restore_state
	movq	8(%rdx), %rax
	movq	32(%rax), %rdi
	call	collect_strings_stmt
	jmp	.L460
	.p2align 4,,10
	.p2align 3
.L472:
	movq	8(%rdx), %r12
	movq	56(%r12), %rdi
	call	collect_strings_init
	movq	32(%r12), %rdi
	testq	%rdi, %rdi
	je	.L460
	call	collect_strings_expr
	jmp	.L460
	.p2align 4,,10
	.p2align 3
.L467:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE36:
	.size	collect_strings_program, .-collect_strings_program
	.section	.rodata.str1.1
.LC31:
	.string	"  "
	.text
	.p2align 4
	.globl	emit_indent
	.type	emit_indent, @function
emit_indent:
.LFB38:
	.cfi_startproc
	testl	%esi, %esi
	jle	.L478
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	leaq	.LC31(%rip), %r13
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
.L475:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L475
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
.L478:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	ret
	.cfi_endproc
.LFE38:
	.size	emit_indent, .-emit_indent
	.section	.rodata.str1.1
.LC32:
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
	jne	.L481
	testq	%rdx, %rdx
	jne	.L489
.L481:
	ret
	.p2align 4,,10
	.p2align 3
.L489:
	movq	%rdx, %rcx
	xorl	%eax, %eax
	movl	%esi, %edx
	leaq	.LC32(%rip), %rsi
	jmp	fprintf@PLT
	.cfi_endproc
.LFE39:
	.size	emit_line_directive, .-emit_line_directive
	.section	.rodata.str1.1
.LC33:
	.string	"\\n"
.LC34:
	.string	"\\t"
.LC35:
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
	leaq	.LC33(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	leaq	.LC35(%rip), %r13
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
	jne	.L491
	jmp	.L498
	.p2align 4,,10
	.p2align 3
.L506:
	movq	%r13, %rsi
	movq	%r12, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L494:
	movzbl	1(%rbp), %ebx
	addq	$1, %rbp
	testb	%bl, %bl
	je	.L498
.L491:
	cmpb	$92, %bl
	je	.L499
	cmpb	$34, %bl
	je	.L499
	cmpb	$10, %bl
	je	.L504
	cmpb	$9, %bl
	je	.L505
	movzbl	%bl, %edx
	cmpb	$31, %bl
	jbe	.L506
	movq	%r12, %rsi
	movl	%edx, %edi
	addq	$1, %rbp
	call	fputc@PLT
	movzbl	0(%rbp), %ebx
	testb	%bl, %bl
	jne	.L491
.L498:
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
.L499:
	.cfi_restore_state
	movq	%r12, %rsi
	movl	$92, %edi
	call	fputc@PLT
	movzbl	%bl, %edi
	movq	%r12, %rsi
	call	fputc@PLT
	jmp	.L494
	.p2align 4,,10
	.p2align 3
.L504:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	jmp	.L494
	.p2align 4,,10
	.p2align 3
.L505:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC34(%rip), %rdi
	call	fwrite@PLT
	jmp	.L494
	.cfi_endproc
.LFE40:
	.size	emit_c_string, .-emit_c_string
	.section	.rodata.str1.1
.LC36:
	.string	"b_preinc(&("
.LC37:
	.string	"b_predec(&("
.LC38:
	.string	"b_postinc(&("
.LC39:
	.string	"b_postdec(&("
.LC40:
	.string	"WAND"
.LC41:
	.string	"WOR"
.LC42:
	.string	"WADD"
.LC43:
	.string	"WSUB"
.LC44:
	.string	"WMUL"
.LC45:
	.string	"WSHR"
.LC46:
	.string	"WSHL"
.LC47:
	.string	"WMOD"
.LC48:
	.string	"WDIV"
.LC49:
	.string	"add_assign"
.LC50:
	.string	"or_assign"
.LC51:
	.string	"and_assign"
.LC52:
	.string	"rsh_assign"
.LC53:
	.string	"lsh_assign"
.LC54:
	.string	"mod_assign"
.LC55:
	.string	"div_assign"
.LC56:
	.string	"mul_assign"
.LC57:
	.string	"sub_assign"
.LC58:
	.string	"WVAL((word)%ld)"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC59:
	.string	"B_PTR_N(__b_str%d, sizeof(__b_str%d))"
	.section	.rodata.str1.1
.LC60:
	.string	"__b_label_value_%d"
.LC61:
	.string	"__bcc_parameters[%zu]"
.LC62:
	.string	"callf"
.LC63:
	.string	"b_callf_dispatch(%zu"
.LC64:
	.string	", "
	.section	.rodata.str1.8
	.align 8
.LC65:
	.string	"({ word *__bcc_binding_%u = __bcc_source_binding("
	.align 8
.LC66:
	.string	"); word __bcc_result_%u; if (__bcc_binding_%u) __bcc_result_%u = "
	.section	.rodata.str1.1
.LC67:
	.string	"; else __bcc_result_%u = "
.LC68:
	.string	"printf"
.LC69:
	.string	"malloc"
.LC70:
	.string	"calloc"
.LC71:
	.string	"realloc"
.LC72:
	.string	"B_PTR("
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
	.string	"; __bcc_result_%u; })"
.LC88:
	.string	"B_INDEX("
.LC89:
	.string	"B_DEREF("
.LC90:
	.string	"WNEG("
.LC91:
	.string	"({ word __b_left_%u = "
.LC92:
	.string	"; word __b_right_%u = "
	.section	.rodata.str1.8
	.align 8
.LC93:
	.string	"; (word)%s(__b_left_%u, __b_right_%u); })"
	.section	.rodata.str1.1
.LC94:
	.string	" %s "
.LC95:
	.string	"%s("
.LC96:
	.string	"({ word *__b_dest_%u = &("
.LC97:
	.string	"); word __b_rhs_%u = ("
	.section	.rodata.str1.8
	.align 8
.LC98:
	.string	"); *__b_dest_%u = (*__b_dest_%u %s __b_rhs_%u); })"
	.section	.rodata.str1.1
.LC99:
	.string	"b_"
.LC100:
	.string	"(&("
.LC101:
	.string	"), "
.LC102:
	.string	"="
.LC103:
	.string	" ? "
.LC104:
	.string	" : "
.LC105:
	.string	"snprintf"
.LC106:
	.string	"sprintf"
.LC107:
	.string	"fprintf"
.LC108:
	.string	"B_FUNCTION("
.LC109:
	.string	"__bcc_library_value("
.LC110:
	.string	"dprintf"
	.text
	.p2align 4
	.globl	emit_expr
	.type	emit_expr, @function
emit_expr:
.LFB49:
	.cfi_startproc
	cmpl	$10, (%rsi)
	ja	.L916
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
	leaq	.L510(%rip), %rdx
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
.L510:
	.long	.L520-.L510
	.long	.L519-.L510
	.long	.L518-.L510
	.long	.L517-.L510
	.long	.L516-.L510
	.long	.L515-.L510
	.long	.L514-.L510
	.long	.L513-.L510
	.long	.L512-.L510
	.long	.L511-.L510
	.long	.L509-.L510
	.text
	.p2align 4,,10
	.p2align 3
.L511:
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
	leaq	.LC103(%rip), %rdi
	call	fwrite@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC104(%rip), %rdi
.L939:
	call	fwrite@PLT
	movq	64(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L933:
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
.L509:
	.cfi_restore_state
	movq	%rdi, %rsi
	movl	$40, %edi
	call	fputc@PLT
.L940:
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC64(%rip), %rdi
.L941:
	call	fwrite@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	jmp	.L933
	.p2align 4,,10
	.p2align 3
.L520:
	movq	48(%rsi), %rdx
	leaq	.LC58(%rip), %rsi
.L930:
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
.L519:
	.cfi_restore_state
	movq	48(%r15), %rdi
	movq	40(%rsi), %rsi
	call	get_string_id
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rdi
	leaq	.LC59(%rip), %rsi
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
.L518:
	.cfi_restore_state
	movq	8+function_labels(%rip), %r13
	movq	48(%rsi), %r12
	testq	%r13, %r13
	je	.L521
	movq	function_labels(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L524
	.p2align 4,,10
	.p2align 3
.L522:
	addq	$1, %rbp
	cmpq	%r13, %rbp
	je	.L521
.L524:
	movq	(%r14,%rbp,8), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L522
	movl	%ebp, %edx
	leaq	.LC60(%rip), %rsi
	addl	$1, %edx
	je	.L521
.L931:
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
.L517:
	.cfi_restore_state
	movq	48(%rsi), %r13
	movl	24(%rsi), %eax
	cmpl	$2, 0(%r13)
	movl	%eax, 12(%rsp)
	je	.L535
	testl	%eax, %eax
	jne	.L688
	movb	$0, 34(%rsp)
	movq	48(%r13), %rsi
	xorl	%r12d, %r12d
	xorl	%r14d, %r14d
	movb	$0, 35(%rsp)
	movq	$0, 16(%rsp)
	movl	$0, 36(%rsp)
.L550:
	movq	%rbx, %rdi
	call	emit_function_name
.L563:
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	64(%r15), %rdx
	movq	16(%rsp), %rcx
	cmpq	%rdx, %rcx
	jnb	.L564
	cmpb	$0, 35(%rsp)
	je	.L564
	movq	56(%r15), %rax
	movq	(%rax,%rcx,8), %rax
	testq	%rax, %rax
	je	.L591
	cmpl	$1, (%rax)
	je	.L947
.L591:
	movq	$0, 48(%rsp)
.L567:
	xorl	%r12d, %r12d
	cmpb	$0, 34(%rsp)
	movq	%r14, 24(%rsp)
	movq	%rdx, %r13
	je	.L696
.L950:
	movl	g_strict(%rip), %r14d
	testl	%r14d, %r14d
	je	.L948
.L696:
	xorl	%r14d, %r14d
.L593:
	movq	56(%r15), %rax
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
.L663:
	testl	%r14d, %r14d
	jne	.L949
.L628:
	addq	$1, %r12
	cmpq	%r12, %r13
	je	.L629
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC64(%rip), %rdi
	call	fwrite@PLT
	cmpb	$0, 34(%rsp)
	jne	.L950
	jmp	.L696
	.p2align 4,,10
	.p2align 3
.L516:
	movq	%rdi, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC88(%rip), %rdi
	call	fwrite@PLT
	jmp	.L940
	.p2align 4,,10
	.p2align 3
.L515:
	movl	48(%rsi), %r12d
	cmpl	$32, %r12d
	je	.L951
	cmpl	$53, %r12d
	je	.L952
	leal	-36(%r12), %eax
	cmpl	$1, %eax
	jbe	.L953
	cmpl	$31, %r12d
	je	.L954
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
	jmp	.L934
	.p2align 4,,10
	.p2align 3
.L514:
	cmpl	$36, 48(%rsi)
	movq	56(%rsi), %r12
	leaq	.LC39(%rip), %rdi
	jne	.L638
	leaq	.LC38(%rip), %rdi
.L638:
	movl	$12, %edx
	movl	$1, %esi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r12, %rsi
.L934:
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC86(%rip), %rdi
.L932:
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
.L513:
	.cfi_restore_state
	movl	48(%rsi), %r12d
	leal	-53(%r12), %eax
	cmpl	$1, %eax
	jbe	.L955
	leal	-28(%r12), %eax
	cmpl	$6, %eax
	ja	.L641
	leaq	.L643(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L643:
	.long	.L704-.L643
	.long	.L648-.L643
	.long	.L647-.L643
	.long	.L646-.L643
	.long	.L645-.L643
	.long	.L644-.L643
	.long	.L642-.L643
	.text
	.p2align 4,,10
	.p2align 3
.L512:
	movl	48(%rsi), %r12d
	movq	56(%rsi), %r13
	movq	64(%rsi), %r14
	leal	-47(%r12), %eax
	cmpl	$5, %eax
	jbe	.L956
	cmpl	$21, %r12d
	je	.L651
	leal	-38(%r12), %eax
	cmpl	$8, %eax
	ja	.L652
	leaq	.L654(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L654:
	.long	.L662-.L654
	.long	.L661-.L654
	.long	.L660-.L654
	.long	.L659-.L654
	.long	.L658-.L654
	.long	.L657-.L654
	.long	.L656-.L654
	.long	.L705-.L654
	.long	.L653-.L654
	.text
	.p2align 4,,10
	.p2align 3
.L521:
	movq	32(%r15), %rdx
	testq	%rdx, %rdx
	jne	.L957
	movl	16(%r15), %ebp
	testl	%ebp, %ebp
	jne	.L958
	movl	12(%r15), %r11d
	testl	%r11d, %r11d
	jne	.L959
	movl	20(%r15), %eax
	cmpl	$2, %eax
	je	.L960
	testq	%r12, %r12
	je	.L534
	movq	%r12, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movl	20(%r15), %eax
.L534:
	cmpl	$1, %eax
	je	.L529
.L507:
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
.L688:
	.cfi_restore_state
	xorl	%r14d, %r14d
.L536:
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
.L957:
	.cfi_restore_state
	subq	$1, %rdx
	leaq	.LC61(%rip), %rsi
	jmp	.L930
	.p2align 4,,10
	.p2align 3
.L953:
	cmpl	$36, %r12d
	leaq	.LC36(%rip), %rax
	movl	$11, %edx
	movq	%rbx, %rcx
	leaq	.LC37(%rip), %rdi
	movl	$1, %esi
	cmove	%rax, %rdi
	call	fwrite@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	jmp	.L934
	.p2align 4,,10
	.p2align 3
.L648:
	leaq	.LC45(%rip), %rdx
	.p2align 4
	.p2align 3
.L649:
	leaq	.LC95(%rip), %rsi
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
	leaq	.LC64(%rip), %rdi
	jmp	.L939
	.p2align 4,,10
	.p2align 3
.L704:
	leaq	.LC46(%rip), %rdx
	jmp	.L649
	.p2align 4,,10
	.p2align 3
.L642:
	leaq	.LC47(%rip), %rdx
	jmp	.L649
	.p2align 4,,10
	.p2align 3
.L647:
	leaq	.LC42(%rip), %rdx
	jmp	.L649
	.p2align 4,,10
	.p2align 3
.L645:
	leaq	.LC44(%rip), %rdx
	jmp	.L649
	.p2align 4,,10
	.p2align 3
.L646:
	leaq	.LC43(%rip), %rdx
	jmp	.L649
	.p2align 4,,10
	.p2align 3
.L644:
	leaq	.LC48(%rip), %rdx
	jmp	.L649
.L705:
	leaq	.LC51(%rip), %r12
	.p2align 4
	.p2align 3
.L655:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC99(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC100(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC101(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	jmp	.L933
.L653:
	leaq	.LC50(%rip), %r12
	jmp	.L655
.L662:
	leaq	.LC49(%rip), %r12
	jmp	.L655
.L660:
	leaq	.LC56(%rip), %r12
	jmp	.L655
.L661:
	leaq	.LC57(%rip), %r12
	jmp	.L655
.L656:
	leaq	.LC52(%rip), %r12
	jmp	.L655
.L657:
	leaq	.LC53(%rip), %r12
	jmp	.L655
.L658:
	leaq	.LC54(%rip), %r12
	jmp	.L655
.L659:
	leaq	.LC55(%rip), %r12
	jmp	.L655
	.p2align 4,,10
	.p2align 3
.L949:
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L628
	.p2align 4,,10
	.p2align 3
.L948:
	movq	24(%rsp), %rdi
	call	source_function
	movl	%eax, 40(%rsp)
	testl	%eax, %eax
	jne	.L593
	movq	16(%rsp), %rax
	movl	current_byteptr(%rip), %ecx
	cmpq	%rax, %r12
	movl	%ecx, 56(%rsp)
	sete	%al
	andb	35(%rsp), %al
	movb	%al, 64(%rsp)
	jne	.L594
	movq	48(%rsp), %rax
	testq	%rax, %rax
	je	.L595
	movl	(%rax,%r12,4), %eax
	testl	%eax, %eax
	je	.L595
	testl	%ecx, %ecx
	je	.L596
	.p2align 4
	.p2align 3
.L597:
	movq	%rbx, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC83(%rip), %rdi
	call	fwrite@PLT
.L627:
	movl	$1, %r14d
	jmp	.L593
	.p2align 4,,10
	.p2align 3
.L629:
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	movl	12(%rsp), %r8d
	testl	%r8d, %r8d
	jne	.L590
.L631:
	movq	48(%rsp), %rax
	testq	%rax, %rax
	je	.L589
	movq	%rax, %rdi
	call	free@PLT
.L589:
	movl	36(%rsp), %edi
	testl	%edi, %edi
	je	.L507
	movl	36(%rsp), %edx
	leaq	.LC87(%rip), %rsi
	jmp	.L931
	.p2align 4,,10
	.p2align 3
.L535:
	movq	48(%r13), %r14
	testq	%r14, %r14
	je	.L961
	movl	12(%rsp), %r9d
	testl	%r9d, %r9d
	jne	.L688
	movq	%r14, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L536
	movl	g_strict(%rip), %r8d
	testl	%r8d, %r8d
	je	.L540
	leaq	8+names.0(%rip), %r12
	leaq	.LC3(%rip), %rsi
	jmp	.L541
	.p2align 4,,10
	.p2align 3
.L962:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L536
.L541:
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L962
.L540:
	leaq	.LC62(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L686
	.p2align 4
	.p2align 3
.L542:
	leaq	8+names.0(%rip), %r12
	leaq	.LC3(%rip), %rsi
	jmp	.L547
	.p2align 4,,10
	.p2align 3
.L964:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L963
.L547:
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L964
	movq	%r14, %rdi
	call	source_function
	movl	%eax, 12(%rsp)
	testl	%eax, %eax
	je	.L965
	movl	g_strict(%rip), %eax
	movl	%eax, 12(%rsp)
	testl	%eax, %eax
	je	.L966
.L683:
	leaq	.LC68(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	movl	%eax, 12(%rsp)
	testl	%eax, %eax
	je	.L551
	movb	$1, 34(%rsp)
	movq	%r14, %rsi
	xorl	%r12d, %r12d
	movb	$0, 35(%rsp)
	movq	$0, 16(%rsp)
	movl	$0, 12(%rsp)
	movl	$0, 36(%rsp)
	jmp	.L550
	.p2align 4,,10
	.p2align 3
.L564:
	testb	%r12b, %r12b
	je	.L588
	leaq	.LC74(%rip), %rsi
	movq	%r14, %rdi
	movq	%rdx, 24(%rsp)
	call	strcmp@PLT
	movq	24(%rsp), %rdx
	testl	%eax, %eax
	jne	.L588
	testq	%rdx, %rdx
	jne	.L591
	movq	%rbx, %rsi
	movl	$48, %edi
	call	fputc@PLT
.L921:
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	movl	12(%rsp), %eax
	testl	%eax, %eax
	je	.L589
	movq	$0, 48(%rsp)
	.p2align 4
	.p2align 3
.L590:
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L631
	.p2align 4,,10
	.p2align 3
.L588:
	testq	%rdx, %rdx
	jne	.L591
	jmp	.L921
	.p2align 4,,10
	.p2align 3
.L956:
	leaq	CSWTCH.183(%rip), %rdx
	leaq	.LC96(%rip), %rsi
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
	leaq	.LC97(%rip), %rsi
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
	leaq	.LC98(%rip), %rsi
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
.L954:
	.cfi_restore_state
	movq	%rdi, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC90(%rip), %rdi
	jmp	.L941
.L963:
	movl	g_strict(%rip), %r12d
	testl	%r12d, %r12d
	jne	.L683
	movl	$0, 36(%rsp)
.L674:
	movq	%r14, %rdi
	call	source_function
	testq	%r14, %r14
	movl	%eax, 24(%rsp)
	setne	34(%rsp)
	testl	%eax, %eax
	jne	.L689
	leaq	.LC68(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	leaq	.LC69(%rip), %rsi
	movq	%r14, %rdi
	orl	%r12d, %eax
	movl	%eax, 12(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L554
	leaq	.LC70(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L554
	leaq	.LC71(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L554
	cmpl	$0, 12(%rsp)
	je	.L967
	leaq	.LC107(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L715
	leaq	.LC110(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L715
	leaq	.LC106(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L671
.L715:
	movb	$1, 35(%rsp)
	movq	$1, 16(%rsp)
.L552:
	xorl	%eax, %eax
	movq	48(%r13), %rsi
	movq	%r13, %rdx
	movl	%eax, 12(%rsp)
.L562:
	testl	%r12d, %r12d
	je	.L690
	cmpl	$2, (%rdx)
	movzbl	34(%rsp), %r12d
	jne	.L550
.L675:
	movq	%rsi, %rdx
	movq	%rbx, %rdi
	leaq	.LC18(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movzbl	34(%rsp), %r12d
	jmp	.L563
	.p2align 4,,10
	.p2align 3
.L651:
	movq	%rdi, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	leaq	.LC102(%rip), %rdx
.L938:
	movq	%rbx, %rdi
	leaq	.LC94(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	jmp	.L933
	.p2align 4,,10
	.p2align 3
.L594:
	movl	56(%rsp), %r11d
	testl	%r11d, %r11d
	jne	.L597
.L596:
	movq	24(%rsp), %rdi
	leaq	.LC69(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L719
	testq	%r12, %r12
	je	.L664
.L719:
	movl	$1, 56(%rsp)
	xorl	%r14d, %r14d
	leaq	.LC71(%rip), %rdx
.L666:
	movq	24(%rsp), %rdi
	movq	%rdx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L944
.L619:
	movq	24(%rsp), %rdi
	leaq	.LC70(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L621
.L944:
	cmpq	$1, %r12
	je	.L968
.L621:
	movl	56(%rsp), %r9d
	testl	%r9d, %r9d
	jne	.L597
.L615:
	testl	%r14d, %r14d
	je	.L593
.L611:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC84(%rip), %rdi
	call	fwrite@PLT
	jmp	.L627
	.p2align 4,,10
	.p2align 3
.L955:
	movl	expression_id(%rip), %eax
	leaq	.LC91(%rip), %rsi
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
	leaq	.LC92(%rip), %rsi
	call	fprintf@PLT
	movq	64(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	cmpl	$53, %r12d
	movl	%r13d, %r8d
	movl	%r13d, %ecx
	leaq	.LC40(%rip), %rax
	leaq	.LC41(%rip), %rdx
	movq	%rbx, %rdi
	cmove	%rax, %rdx
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC93(%rip), %rsi
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
.L958:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC28(%rip), %rdi
	jmp	.L932
.L951:
	movq	%rdi, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC89(%rip), %rdi
	jmp	.L941
.L641:
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
	leaq	.LC94(%rip), %rsi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	64(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	jmp	.L933
.L952:
	movq	%rdi, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC26(%rip), %rdi
	jmp	.L941
.L961:
	movl	12(%rsp), %r10d
	testl	%r10d, %r10d
	jne	.L536
	xorl	%edi, %edi
	leaq	.LC62(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L542
	xorl	%edi, %edi
	call	source_function
	testl	%eax, %eax
	jne	.L542
.L686:
	movq	64(%r15), %r14
	testq	%r14, %r14
	jne	.L543
	xorl	%edx, %edx
	leaq	.LC63(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L933
.L959:
	movq	%r12, %rdi
	leaq	8+names.0(%rip), %rbp
	call	source_function
	leaq	.LC3(%rip), %rsi
	testl	%eax, %eax
	jne	.L969
	.p2align 4
	.p2align 3
.L531:
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L530
	movq	0(%rbp), %rsi
	addq	$8, %rbp
	testq	%rsi, %rsi
	jne	.L531
	movq	%rbx, %rcx
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC108(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	jmp	.L933
.L595:
	movq	24(%rsp), %rdi
	leaq	.LC75(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L936
	movq	24(%rsp), %rdi
	leaq	.LC76(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L599
.L936:
	testq	%r12, %r12
	je	.L594
.L599:
	movq	24(%rsp), %rdi
	leaq	.LC77(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L600
	cmpq	$1, %r12
	jbe	.L970
.L602:
	movq	24(%rsp), %rdi
	leaq	.LC79(%rip), %rsi
	call	strcmp@PLT
	movl	%eax, %r14d
	testl	%eax, %eax
	jne	.L605
	cmpq	$2, %r12
	je	.L606
.L601:
	movq	24(%rsp), %rdi
	leaq	.LC81(%rip), %rsi
	call	strcmp@PLT
	testq	%r12, %r12
	movl	%eax, %edx
	sete	%al
	movb	%al, 64(%rsp)
	testl	%edx, %edx
	jne	.L609
	testb	%al, %al
	jne	.L927
.L609:
	movq	24(%rsp), %rdi
	leaq	.LC82(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L613
	cmpq	$1, %r12
	jbe	.L927
.L612:
	leaq	.LC71(%rip), %rdx
	movq	24(%rsp), %rdi
	movq	%rdx, %rsi
	movq	%rdx, 64(%rsp)
	call	strcmp@PLT
	leaq	.LC71(%rip), %rdx
	testl	%eax, %eax
	je	.L615
.L616:
	movq	24(%rsp), %rdi
	leaq	.LC70(%rip), %rsi
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
	jne	.L615
	movq	24(%rsp), %rdi
	leaq	.LC69(%rip), %rsi
	movq	%rdx, 64(%rsp)
	movb	%cl, 56(%rsp)
	call	strcmp@PLT
	movq	64(%rsp), %rdx
	testl	%eax, %eax
	jne	.L720
	movzbl	56(%rsp), %ecx
	testb	%cl, %cl
	je	.L720
.L622:
	testl	%r14d, %r14d
	jne	.L625
	movl	$0, 40(%rsp)
.L624:
	movq	%rbx, %rcx
	movl	$32, %edx
	movl	$1, %esi
	leaq	.LC85(%rip), %rdi
	call	fwrite@PLT
	movq	56(%r15), %rax
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC86(%rip), %rdi
	call	fwrite@PLT
	movl	40(%rsp), %eax
	orl	%eax, %r14d
	jmp	.L663
.L652:
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
	jmp	.L938
.L969:
	testq	%r12, %r12
	je	.L529
	movq	%r12, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L529:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC30(%rip), %rdi
	jmp	.L932
.L551:
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
	jmp	.L550
.L530:
	movq	%rbx, %rcx
	movl	$20, %edx
	movl	$1, %esi
	leaq	.LC109(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
	movq	%rbx, %rdi
	call	emit_c_string
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC64(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC108(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L933
.L947:
	movq	%rdx, %rdi
	movl	$4, %esi
	movq	%rdx, 24(%rsp)
	movq	48(%rax), %r12
	call	calloc@PLT
	movq	24(%rsp), %rdx
	testq	%rax, %rax
	movq	%rax, 48(%rsp)
	je	.L591
	movq	16(%rsp), %rax
	xorl	%r13d, %r13d
	leaq	1(%rax), %rsi
	movzbl	(%r12), %eax
	testb	%al, %al
	je	.L567
	movq	%r14, 24(%rsp)
	movq	%rbx, 40(%rsp)
	movq	%rsi, %rbx
	movq	%rbp, 56(%rsp)
	movq	%r12, %rbp
	movq	%rdx, %r12
	.p2align 4
	.p2align 3
.L566:
	cmpb	$37, %al
	jne	.L919
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	cmpb	$37, %r14b
	je	.L919
	testb	%r14b, %r14b
	jne	.L569
	jmp	.L914
	.p2align 4,,10
	.p2align 3
.L572:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	testb	%r14b, %r14b
	je	.L571
.L569:
	movsbl	%r14b, %esi
	leaq	.LC73(%rip), %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L572
	cmpb	$42, %r14b
	jne	.L571
	cmpq	%r12, %rbx
	adcq	$0, %rbx
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %edx
.L576:
	cmpb	$46, %dl
	je	.L971
.L578:
	cmpb	$104, %dl
	je	.L972
	cmpb	$108, %dl
	je	.L973
	testb	%dl, %dl
	je	.L914
	leaq	1(%r13), %rax
	cmpb	$115, %dl
	jne	.L584
	cmpq	%r12, %rbx
	jnb	.L584
	movq	48(%rsp), %rcx
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
	movq	24(%rsp), %r14
	movq	40(%rsp), %rbx
	movq	%r12, %rdx
	movq	56(%rsp), %rbp
	jmp	.L567
	.p2align 4,,10
	.p2align 3
.L919:
	leaq	1(%r13), %rax
	jmp	.L568
.L571:
	movzbl	0(%rbp,%r13), %edx
	testb	%dl, %dl
	movb	%dl, 64(%rsp)
	je	.L914
	call	__ctype_b_loc@PLT
	movzbl	64(%rsp), %edx
	movq	(%rax), %rax
	jmp	.L574
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L577:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %edx
	testb	%dl, %dl
	je	.L914
.L574:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L577
	movzbl	0(%rbp,%r13), %edx
	jmp	.L576
.L972:
	cmpb	$104, 1(%rbp,%r13)
	leaq	1(%r13), %rax
	jne	.L584
.L694:
	leaq	2(%r13), %rax
	jmp	.L584
.L971:
	movzbl	1(%rbp,%r13), %edx
	leaq	1(%r13), %rdi
	movq	%rdi, 64(%rsp)
	cmpb	$42, %dl
	jne	.L974
	cmpq	%r12, %rbx
	adcq	$0, %rbx
	addq	$2, %r13
	movzbl	0(%rbp,%r13), %edx
	jmp	.L578
.L973:
	cmpb	$108, 1(%rbp,%r13)
	leaq	1(%r13), %rax
	jne	.L584
	jmp	.L694
.L554:
	movl	12(%rsp), %esi
	testl	%esi, %esi
	je	.L975
	leaq	.LC107(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L716
	leaq	.LC110(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L716
	leaq	.LC106(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L716
	movl	$1, 24(%rsp)
.L671:
	leaq	.LC105(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L706
	movb	$1, 35(%rsp)
	movq	$2, 16(%rsp)
.L670:
	cmpl	$0, 24(%rsp)
	je	.L552
.L561:
	movl	$6, %edx
	movl	$1, %esi
	movq	%rbx, %rcx
	leaq	.LC72(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rdx
	movl	$1, 12(%rsp)
	movq	48(%rdx), %rsi
	jmp	.L562
.L600:
	movq	24(%rsp), %rdi
	leaq	.LC78(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L602
	cmpq	$1, %r12
	jne	.L602
	movq	24(%rsp), %rdi
	leaq	.LC82(%rip), %rsi
	movl	$1, %r14d
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L613
	cmpl	$0, 56(%rsp)
	jne	.L611
	leaq	.LC71(%rip), %rdx
	movq	24(%rsp), %rdi
	movq	%rdx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L625
	xorl	%eax, %eax
	movl	$1, %r14d
	movl	%eax, 56(%rsp)
	jmp	.L619
	.p2align 4,,10
	.p2align 3
.L960:
	movq	%r12, %rdi
	call	get_mangled_name
	leaq	.LC29(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L930
.L974:
	testb	%dl, %dl
	movb	%dl, 72(%rsp)
	je	.L914
	call	__ctype_b_loc@PLT
	movzbl	72(%rsp), %edx
	movq	64(%rsp), %rdi
	movq	(%rax), %rax
	jmp	.L580
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L582:
	addq	$1, %rdi
	movzbl	0(%rbp,%rdi), %edx
	testb	%dl, %dl
	je	.L914
.L580:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L582
	movzbl	0(%rbp,%rdi), %edx
	movq	%rdi, %r13
	jmp	.L578
.L968:
	movl	56(%rsp), %r10d
	testl	%r10d, %r10d
	je	.L622
	movq	%rbx, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC83(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 40(%rsp)
	jmp	.L624
.L606:
	movq	24(%rsp), %rdi
	leaq	.LC82(%rip), %rsi
	movl	$1, %r14d
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L612
.L613:
	leaq	.LC71(%rip), %rdx
	movq	24(%rsp), %rdi
	movq	%rdx, %rsi
	movq	%rdx, 72(%rsp)
	call	strcmp@PLT
	leaq	.LC71(%rip), %rdx
	testl	%eax, %eax
	jne	.L616
	movzbl	64(%rsp), %eax
	orl	%eax, %r14d
	cmpl	$0, 56(%rsp)
	jne	.L615
	movq	24(%rsp), %rdi
	leaq	.LC69(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L678
	cmpb	$0, 64(%rsp)
	jne	.L622
.L678:
	cmpq	$1, %r12
	jne	.L615
	jmp	.L622
	.p2align 4,,10
	.p2align 3
.L689:
	movb	$0, 35(%rsp)
	movq	$0, 16(%rsp)
	jmp	.L552
.L605:
	movq	24(%rsp), %rdi
	leaq	.LC80(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L718
	cmpq	$2, %r12
	je	.L606
.L718:
	xorl	%r14d, %r14d
	jmp	.L601
.L965:
	movl	expression_id(%rip), %eax
	leaq	.LC65(%rip), %rsi
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
	leaq	.LC66(%rip), %rsi
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
	leaq	.LC67(%rip), %rsi
	call	fprintf@PLT
	movq	48(%r15), %r13
	cmpl	$2, 0(%r13)
	movq	48(%r13), %rsi
	je	.L549
	movb	$0, 34(%rsp)
	xorl	%r12d, %r12d
	xorl	%r14d, %r14d
	movb	$0, 35(%rsp)
	movq	$0, 16(%rsp)
	jmp	.L550
.L716:
	movb	$1, 35(%rsp)
	movq	$1, 16(%rsp)
	jmp	.L561
.L927:
	movl	56(%rsp), %eax
	testl	%eax, %eax
	jne	.L611
	movq	24(%rsp), %rdi
	leaq	.LC69(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L721
	testb	$1, %r12b
	je	.L625
.L721:
	xorl	%ecx, %ecx
	movl	$1, %r14d
	leaq	.LC71(%rip), %rdx
	movl	%ecx, 56(%rsp)
	jmp	.L666
.L966:
	movb	$1, 34(%rsp)
	movq	48(%r13), %rsi
	xorl	%r12d, %r12d
	movb	$0, 35(%rsp)
	movq	$0, 16(%rsp)
	movl	$0, 36(%rsp)
	jmp	.L550
.L706:
	xorl	%edx, %edx
	movb	$0, 35(%rsp)
	movq	%rdx, 16(%rsp)
	jmp	.L670
.L543:
	leaq	-1(%r14), %rdx
	leaq	.LC63(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%r12d, %r12d
	leaq	.LC64(%rip), %r13
.L545:
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
	jne	.L545
	jmp	.L933
.L975:
	movq	%rbx, %rcx
	movl	$1, %esi
	movl	$6, %edx
	xorl	%r12d, %r12d
	leaq	.LC72(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rax
	xorl	%ecx, %ecx
	movb	$1, 35(%rsp)
	movq	%rcx, 16(%rsp)
	movl	$1, 12(%rsp)
	movq	48(%rax), %rsi
	jmp	.L550
.L625:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	movl	$1, %r14d
	leaq	.LC84(%rip), %rdi
	call	fwrite@PLT
	jmp	.L624
.L970:
	movl	$1, %r14d
	jmp	.L601
.L664:
	movq	%rbx, %rcx
	movl	$9, %edx
	movl	$1, %esi
	xorl	%r14d, %r14d
	leaq	.LC83(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 40(%rsp)
	jmp	.L624
.L549:
	cmpl	$0, g_strict(%rip)
	je	.L713
	testq	%rsi, %rsi
	movb	$0, 35(%rsp)
	movq	%rsi, %r14
	setne	34(%rsp)
	xorl	%edx, %edx
	movq	%rdx, 16(%rsp)
	jmp	.L675
.L713:
	movq	%rsi, %r14
	movl	$1, %r12d
	jmp	.L674
.L967:
	xorl	%edi, %edi
	movb	$1, 35(%rsp)
	movq	48(%r13), %rsi
	xorl	%r12d, %r12d
	movq	%rdi, 16(%rsp)
	jmp	.L550
.L690:
	xorl	%r12d, %r12d
	jmp	.L550
.L720:
	xorl	%esi, %esi
	movl	%esi, 56(%rsp)
	jmp	.L666
.L916:
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
.LC111:
	.string	"({ word __bcc_callee_%u = "
.LC112:
	.string	"*__bcc_binding_%u"
.LC113:
	.string	"; word __bcc_args_%u[%zu] = {"
	.section	.rodata.str1.8
	.align 8
.LC114:
	.string	"}; __bcc_is_source_function(__bcc_callee_%u) ? __bcc_invoke_source(__bcc_callee_%u, %zu, __bcc_args_%u) : ((word (*)())B_FUNCTION_CPTR(__bcc_callee_%u))("
	.section	.rodata.str1.1
.LC115:
	.string	"__bcc_args_%u[%zu]"
.LC116:
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
	leaq	.LC111(%rip), %rsi
	movl	%r8d, 12(%rsp)
	leal	1(%rax), %r12d
	xorl	%eax, %eax
	movl	%r12d, %edx
	movl	%r12d, expression_id(%rip)
	call	fprintf@PLT
	movl	12(%rsp), %r8d
	testl	%r8d, %r8d
	jne	.L987
	testq	%r15, %r15
	je	.L979
	movq	%r15, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC30(%rip), %rdi
	call	fwrite@PLT
.L978:
	testq	%rbp, %rbp
	movl	$1, %ecx
	movl	%r12d, %edx
	movq	%rbx, %rdi
	cmovne	%rbp, %rcx
	leaq	.LC113(%rip), %rsi
	xorl	%eax, %eax
	xorl	%r15d, %r15d
	call	fprintf@PLT
	testq	%rbp, %rbp
	jne	.L980
	jmp	.L988
	.p2align 4,,10
	.p2align 3
.L989:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC64(%rip), %rdi
	call	fwrite@PLT
.L980:
	movq	56(%r13), %rax
	movq	%r14, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r15,8), %rsi
	addq	$1, %r15
	call	emit_expr
	cmpq	%r15, %rbp
	jne	.L989
	subq	$8, %rsp
	.cfi_def_cfa_offset 88
	movl	%r12d, %edx
	movl	%r12d, %r9d
	movq	%rbp, %r8
	pushq	%r12
	.cfi_def_cfa_offset 96
	movl	%r12d, %ecx
	leaq	.LC114(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	xorl	%r13d, %r13d
	leaq	.LC115(%rip), %r14
	leaq	.LC64(%rip), %r15
	call	fprintf@PLT
	popq	%rax
	.cfi_def_cfa_offset 88
	popq	%rdx
	.cfi_def_cfa_offset 80
	jmp	.L983
	.p2align 4,,10
	.p2align 3
.L990:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
.L983:
	movq	%r13, %rcx
	movl	%r12d, %edx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	addq	$1, %r13
	call	fprintf@PLT
	cmpq	%r13, %rbp
	jne	.L990
.L981:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC116(%rip), %rdi
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
.L979:
	.cfi_restore_state
	movq	48(%r13), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	jmp	.L978
	.p2align 4,,10
	.p2align 3
.L988:
	movq	%rbx, %rsi
	movl	$48, %edi
	call	fputc@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 88
	movl	%r12d, %ecx
	movl	%r12d, %r9d
	pushq	%r12
	.cfi_def_cfa_offset 96
	leaq	.LC114(%rip), %rsi
	xorl	%r8d, %r8d
	movl	%r12d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	popq	%rcx
	.cfi_def_cfa_offset 88
	popq	%rsi
	.cfi_def_cfa_offset 80
	jmp	.L981
	.p2align 4,,10
	.p2align 3
.L987:
	movl	%r8d, %edx
	leaq	.LC112(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L978
	.cfi_endproc
.LFE48:
	.size	emit_b_call, .-emit_b_call
	.section	.rodata.str1.1
.LC117:
	.string	"word __%s_store[("
.LC118:
	.string	")];\n"
.LC119:
	.string	"word %s = 0;\n"
	.section	.rodata.str1.8
	.align 8
.LC120:
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
	je	.L992
	testl	%r13d, %r13d
	jle	.L993
	xorl	%r12d, %r12d
	leaq	.LC31(%rip), %r14
	.p2align 4
	.p2align 3
.L994:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r13d
	jne	.L994
.L993:
	movq	%r15, %rdx
	leaq	.LC117(%rip), %rsi
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
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
.L992:
	testl	%r13d, %r13d
	jle	.L995
	xorl	%ebx, %ebx
	leaq	.LC31(%rip), %r14
	.p2align 4
	.p2align 3
.L996:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %r12d
	leal	1(%rbx), %ebx
	cmpl	%ebx, %r13d
	jne	.L996
	xorl	%eax, %eax
	movq	%r15, %rdx
	leaq	.LC119(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L1007
.L991:
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
.L1007:
	.cfi_restore_state
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1001:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %r12d
	jne	.L1001
.L998:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r15, %rcx
	movq	%r15, %rdx
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC120(%rip), %rsi
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
.L995:
	.cfi_restore_state
	xorl	%eax, %eax
	movq	%r15, %rdx
	leaq	.LC119(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L991
	jmp	.L998
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
	je	.L1010
	jmp	emit_expr
	.p2align 4,,10
	.p2align 3
.L1010:
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
	je	.L1011
	cmpl	$1, (%rdi)
	je	.L1015
.L1011:
	ret
	.p2align 4,,10
	.p2align 3
.L1015:
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
	je	.L1052
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
	je	.L1018
	ja	.L1019
	testl	%eax, %eax
	je	.L1020
	cmpl	$5, %eax
	jne	.L1028
	movq	56(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1016
	movl	48(%rbx), %eax
	cmpl	$31, %eax
	je	.L1024
	cmpl	$35, %eax
	je	.L1025
	.p2align 4
	.p2align 3
.L1028:
	xorl	%eax, %eax
.L1016:
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
.L1019:
	.cfi_restore_state
	cmpl	$10, %eax
	jne	.L1028
	movq	48(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1016
	movq	56(%rbx), %rdi
	movq	%rbp, %rsi
	call	try_eval_const_expr
	jmp	.L1016
	.p2align 4,,10
	.p2align 3
.L1052:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L1020:
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
.L1018:
	.cfi_restore_state
	movq	56(%rdi), %rdi
	movq	%rsp, %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1028
	movq	64(%rbx), %rdi
	leaq	8(%rsp), %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1028
	movl	48(%rbx), %eax
	subl	$22, %eax
	cmpl	$33, %eax
	ja	.L1028
	leaq	.L1031(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1031:
	.long	.L1044-.L1031
	.long	.L1043-.L1031
	.long	.L1042-.L1031
	.long	.L1041-.L1031
	.long	.L1040-.L1031
	.long	.L1039-.L1031
	.long	.L1028-.L1031
	.long	.L1028-.L1031
	.long	.L1038-.L1031
	.long	.L1037-.L1031
	.long	.L1036-.L1031
	.long	.L1035-.L1031
	.long	.L1034-.L1031
	.long	.L1028-.L1031
	.long	.L1028-.L1031
	.long	.L1028-.L1031
	.long	.L1028-.L1031
	.long	.L1028-.L1031
	.long	.L1028-.L1031
	.long	.L1028-.L1031
	.long	.L1028-.L1031
	.long	.L1028-.L1031
	.long	.L1028-.L1031
	.long	.L1028-.L1031
	.long	.L1028-.L1031
	.long	.L1028-.L1031
	.long	.L1028-.L1031
	.long	.L1028-.L1031
	.long	.L1028-.L1031
	.long	.L1028-.L1031
	.long	.L1028-.L1031
	.long	.L1033-.L1031
	.long	.L1032-.L1031
	.long	.L1030-.L1031
	.text
	.p2align 4,,10
	.p2align 3
.L1025:
	xorl	%eax, %eax
	cmpq	$0, 8(%rsp)
	sete	%al
	movq	%rax, 0(%rbp)
.L1046:
	movl	$1, %eax
	jmp	.L1016
.L1030:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1046
.L1032:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1046
.L1033:
	movq	(%rsp), %rax
	andq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1046
.L1034:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L1028
	movq	(%rsp), %rax
	cmpq	$-1, %rcx
	jne	.L1056
	movabsq	$-9223372036854775808, %rdx
	cmpq	%rdx, %rax
	je	.L1054
.L1056:
	cqto
	idivq	%rcx
.L1049:
	movq	%rdx, 0(%rbp)
	jmp	.L1046
.L1035:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L1028
	movq	(%rsp), %rdx
	cmpq	$-1, %rcx
	jne	.L1055
	movabsq	$-9223372036854775808, %rax
	cmpq	%rax, %rdx
	je	.L1077
.L1055:
	movq	%rdx, %rax
	cqto
	idivq	%rcx
.L1077:
	movq	%rax, 0(%rbp)
	jmp	.L1046
.L1036:
	movq	(%rsp), %rax
	imulq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1046
.L1037:
	movq	(%rsp), %rax
	subq	8(%rsp), %rax
	jmp	.L1077
.L1038:
	movq	8(%rsp), %rax
	addq	(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1046
.L1039:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setge	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1046
.L1040:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setg	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1046
.L1041:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setle	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1046
.L1042:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setl	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1046
.L1043:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1046
.L1044:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	sete	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1046
	.p2align 4,,10
	.p2align 3
.L1024:
	movq	8(%rsp), %rax
	negq	%rax
	movq	%rax, 0(%rbp)
	jmp	.L1046
.L1054:
	xorl	%edx, %edx
	jmp	.L1049
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
	je	.L1080
	cmpl	$1, (%rdi)
	je	.L1084
.L1080:
	ret
	.p2align 4,,10
	.p2align 3
.L1084:
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
	je	.L1085
	cmpl	$1, (%rdi)
	je	.L1090
.L1085:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L1090:
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
	je	.L1103
	cmpl	$1, (%rdi)
	jne	.L1103
	movq	24(%rdi), %rcx
	movq	16(%rdi), %r8
	testq	%rcx, %rcx
	je	.L1103
	xorl	%edx, %edx
	jmp	.L1104
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1106:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L1103
.L1104:
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L1106
	cmpl	$1, (%rax)
	jne	.L1106
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
.L1107:
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r9
.L1093:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L1110
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L1093
	cmpl	$1, (%rax)
	jne	.L1093
	jmp	.L1107
	.p2align 4,,10
	.p2align 3
.L1103:
	.cfi_def_cfa_offset 8
	movq	%r9, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1110:
	.cfi_def_cfa_offset 16
	movq	%r9, %rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE55:
	.size	edge_tail_words_top, .-edge_tail_words_top
	.section	.rodata.str1.1
.LC121:
	.string	"%s[%zu] = "
.LC122:
	.string	";\n"
.LC123:
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
	je	.L1112
	cmpl	$1, (%rcx)
	movq	%rcx, %r15
	jne	.L1112
	cmpq	$0, 24(%rcx)
	je	.L1112
	movq	%rsi, (%rsp)
	movq	%rdi, %rbx
	movl	%r9d, %ebp
	xorl	%r13d, %r13d
	movq	%r8, 8(%rsp)
.L1125:
	movq	16(%r15), %rax
	movq	(%rax,%r13,8), %r10
	testq	%r10, %r10
	je	.L1120
	movl	(%r10), %eax
	testl	%eax, %eax
	je	.L1144
	cmpl	$1, %eax
	je	.L1145
.L1120:
	addq	$1, %r13
	addq	$1, %r12
	cmpq	24(%r15), %r13
	jb	.L1125
	movq	8(%rsp), %rdx
.L1112:
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
.L1144:
	.cfi_restore_state
	xorl	%r14d, %r14d
	testl	%ebp, %ebp
	jle	.L1118
	movq	%r12, 16(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L1115:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1115
	movq	16(%rsp), %r12
	movq	%r14, %r10
.L1118:
	movq	(%rsp), %rdx
	leaq	.LC121(%rip), %rsi
	xorl	%eax, %eax
	movq	%r12, %rcx
	movq	%rbx, %rdi
	movq	%r10, 16(%rsp)
	call	fprintf@PLT
	movq	16(%rsp), %r10
	movq	16(%r10), %rsi
	cmpl	$2, (%rsi)
	je	.L1146
	movq	96(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L1119:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1120
	.p2align 4,,10
	.p2align 3
.L1145:
	movq	24(%r10), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmovne	%rax, %rdx
	xorl	%r14d, %r14d
	movq	%rdx, 16(%rsp)
	testl	%ebp, %ebp
	jle	.L1124
	movq	%r12, 24(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L1121:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1121
	movq	24(%rsp), %r12
	movq	%r14, %r10
.L1124:
	movq	8(%rsp), %r14
	movq	(%rsp), %r8
	movq	%r12, %rcx
	movq	%rbx, %rdi
	leaq	.LC123(%rip), %rsi
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
	jne	.L1122
	movq	24(%r10), %rsi
	movq	16(%r10), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, 8(%rsp)
.L1122:
	movq	8(%rsp), %rax
	cmpq	%rdx, %rax
	cmovnb	%rax, %rdx
	movq	%rdx, 8(%rsp)
	jmp	.L1120
	.p2align 4,,10
	.p2align 3
.L1146:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1119
	.cfi_endproc
.LFE56:
	.size	emit_edge_list_init, .-emit_edge_list_init
	.section	.rodata.str1.8
	.align 8
.LC124:
	.string	"static void __attribute__((constructor(101))) __b_register_globals(void) {\n"
	.section	.rodata.str1.1
.LC125:
	.string	"}\n"
	.section	.rodata.str1.8
	.align 8
.LC126:
	.string	"    (void)B_PTR_N(%s, sizeof(%s));\n"
	.align 8
.LC127:
	.string	"    (void)B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.align 8
.LC128:
	.string	"static void __attribute__((constructor(102))) __bcc_bind_functions(void) {\n"
	.align 8
.LC129:
	.string	"static void __b_initialize_globals(void) {\n"
	.section	.rodata.str1.1
.LC130:
	.string	"    "
.LC131:
	.string	" = B_FUNCTION("
	.section	.rodata.str1.8
	.align 8
.LC132:
	.string	"    static struct __bcc_source_function __bcc_function_%zu = {(void*)"
	.align 8
.LC133:
	.string	", 0, 0};\n    __bcc_register_function(&__bcc_function_%zu);\n"
	.align 8
.LC134:
	.string	"    static struct __bcc_library_binding __bcc_binding_%zu = {"
	.align 8
.LC135:
	.string	", 0, 0};\n    __bcc_register_binding(&__bcc_binding_%zu);\n"
	.align 8
.LC136:
	.string	"    static struct __bcc_library_binding __bcc_data_%zu = {"
	.align 8
.LC137:
	.string	", 0, 0};\n    __bcc_register_binding(&__bcc_data_%zu);\n"
	.align 8
.LC138:
	.string	"}\nstatic struct __bcc_initializer __bcc_module = {__b_initialize_globals, 0, 0};\nstatic void __attribute__((constructor(102))) __bcc_register_module(void) {\n    __bcc_register_initializer(&__bcc_module);\n}\n\n"
	.align 8
.LC139:
	.string	"    %s[0] = B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC140:
	.string	"__%s_store"
.LC141:
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
	leaq	.LC125(%rip), %rax
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
	je	.L1212
.L1148:
	movq	%rbx, %rcx
	movl	$75, %edx
	movl	$1, %esi
	xorl	%ebp, %ebp
	leaq	.LC128(%rip), %rdi
	leaq	.LC130(%rip), %r15
	call	fwrite@PLT
	cmpq	$0, 8(%r14)
	leaq	.LC131(%rip), %r13
	jne	.L1155
	jmp	.L1161
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1158:
	movq	8(%r14), %rax
	addq	$1, %rbp
	cmpq	%rax, %rbp
	jnb	.L1213
.L1155:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %r12
	cmpl	$1, (%r12)
	jne	.L1158
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r12), %rax
	movq	(%rax), %rdi
	testq	%rdi, %rdi
	je	.L1159
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1159:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC30(%rip), %rdi
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
	leaq	.LC25(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC132(%rip), %rsi
	call	fprintf@PLT
	movq	8(%r12), %rax
	movq	%rbx, %rdi
	movq	(%rax), %rsi
	call	emit_function_body_name
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC133(%rip), %rsi
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC134(%rip), %rsi
	call	fprintf@PLT
	movq	8(%r12), %rax
	movq	%rbx, %rdi
	movq	(%rax), %rsi
	call	emit_c_string
	leaq	.LC64(%rip), %rdi
	movq	%rbx, %rcx
	movl	$2, %edx
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
	movq	%rbp, %rdx
	leaq	.LC135(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	8(%r14), %rax
	addq	$1, %rbp
	cmpq	%rax, %rbp
	jb	.L1155
.L1213:
	testq	%rax, %rax
	je	.L1161
	xorl	%r15d, %r15d
	leaq	.LC64(%rip), %r13
	leaq	.LC137(%rip), %r12
	.p2align 4
	.p2align 3
.L1164:
	movq	(%r14), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$2, (%rax)
	jne	.L1162
	movq	8(%rax), %rax
	movl	4(%rax), %edi
	testl	%edi, %edi
	jne	.L1162
	movq	16(%rax), %rbp
	movq	%r15, %rdx
	leaq	.LC136(%rip), %rsi
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
	je	.L1163
	movq	%rbp, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1163:
	movq	%r15, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L1162:
	addq	$1, %r15
	cmpq	8(%r14), %r15
	jb	.L1164
.L1161:
	movq	(%rsp), %rdi
	movq	%rbx, %rcx
	movl	$2, %edx
	xorl	%ebp, %ebp
	movl	$1, %esi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC129(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%r14)
	jne	.L1156
	jmp	.L1157
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1166:
	addq	$1, %rbp
	cmpq	8(%r14), %rbp
	jnb	.L1157
.L1156:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$2, (%rax)
	jne	.L1166
	movq	8(%rax), %r12
	movq	16(%r12), %rdi
	call	get_mangled_name
	cmpl	$2, 24(%r12)
	movq	56(%r12), %r13
	movq	%rax, %r15
	je	.L1214
	testq	%r13, %r13
	je	.L1166
	movl	0(%r13), %eax
	cmpl	$1, %eax
	je	.L1215
	testl	%eax, %eax
	jne	.L1166
	leaq	.LC141(%rip), %rsi
	movq	%r15, %rdx
	movq	%rbx, %rdi
	call	fprintf@PLT
	movq	16(%r13), %rsi
	cmpl	$2, (%rsi)
	je	.L1216
	movq	8(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L1174:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addq	$1, %rbp
	leaq	.LC122(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r14), %rbp
	jb	.L1156
.L1157:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$207, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC138(%rip), %rdi
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
.L1214:
	.cfi_restore_state
	movq	%rax, %r8
	movq	%rax, %rcx
	movq	%rax, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC139(%rip), %rsi
	call	fprintf@PLT
	testq	%r13, %r13
	je	.L1166
	cmpl	$1, 0(%r13)
	jne	.L1166
	movq	%r15, %rsi
	leaq	.LC140(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	xorl	%r8d, %r8d
	movq	%rax, %rsi
	movq	56(%r12), %rax
	testq	%rax, %rax
	je	.L1169
	cmpl	$1, (%rax)
	je	.L1217
.L1169:
	cmpq	$0, 32(%r12)
	je	.L1170
	movq	48(%r12), %rax
	movq	%r8, %rdx
	cmpq	%rax, %r8
	cmovb	%rax, %r8
	testq	%rax, %rax
	cmovle	%rdx, %r8
.L1170:
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
	jmp	.L1166
	.p2align 4,,10
	.p2align 3
.L1215:
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
	jmp	.L1166
	.p2align 4,,10
	.p2align 3
.L1212:
	movq	%rdi, %rcx
	movl	$75, %edx
	movl	$1, %esi
	xorl	%ebp, %ebp
	leaq	.LC124(%rip), %rdi
	leaq	.LC126(%rip), %r12
	call	fwrite@PLT
	cmpq	$0, 8(%r14)
	jne	.L1149
	.p2align 4
	.p2align 3
.L1154:
	leaq	.LC125(%rip), %rax
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, (%rsp)
	call	fwrite@PLT
	jmp	.L1148
	.p2align 4,,10
	.p2align 3
.L1220:
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
	je	.L1218
.L1151:
	addq	$1, %rbp
	cmpq	8(%r14), %rbp
	jnb	.L1154
.L1149:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L1219
	cmpl	$2, %eax
	jne	.L1151
	jmp	.L1220
	.p2align 4,,10
	.p2align 3
.L1218:
	movq	%r13, %rcx
	movq	%r13, %rdx
	leaq	.LC127(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1151
	.p2align 4,,10
	.p2align 3
.L1219:
	movq	8(%rdx), %rax
	movq	(%rax), %rdi
	call	get_mangled_name
	movq	%r12, %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1151
.L1216:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1174
.L1217:
	movq	24(%rax), %r8
	jmp	.L1169
	.cfi_endproc
.LFE65:
	.size	emit_global_initializers, .-emit_global_initializers
	.section	.rodata.str1.1
.LC142:
	.string	"<"
.LC143:
	.string	"<="
.LC144:
	.string	">"
.LC145:
	.string	">="
.LC146:
	.string	"??"
.LC147:
	.string	"while ("
.LC148:
	.string	")\n"
.LC149:
	.string	"if ("
.LC150:
	.string	"switch ("
.LC151:
	.string	") {\n"
.LC152:
	.string	"continue;\n"
.LC153:
	.string	"break;\n"
.LC154:
	.string	"return"
.LC155:
	.string	"{\n"
.LC156:
	.string	"return "
	.section	.rodata.str1.8
	.align 8
.LC157:
	.string	"%s = B_LOCAL_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC158:
	.string	"else\n"
.LC159:
	.string	" 0"
	.section	.rodata.str1.8
	.align 8
.LC160:
	.string	"case %zu: goto __b_label_%zu;\n"
	.align 8
.LC161:
	.string	"default: fputs(\"bcc: invalid label value\\n\", stderr); abort();\n"
	.section	.rodata.str1.1
.LC162:
	.string	"__bsw%d_case%zu"
.LC163:
	.string	"for(;;) {\n"
.LC164:
	.string	"word __sw = "
.LC165:
	.string	"__bsw%d_end"
.LC166:
	.string	"goto __bsw%d_dispatch;\n"
.LC167:
	.string	"goto __bsw%d_end;\n"
.LC168:
	.string	"__sw %s (word)%ld"
	.section	.rodata.str1.8
	.align 8
.LC169:
	.string	"(__sw >= (word)%ld && __sw <= (word)%ld)"
	.section	.rodata.str1.1
.LC170:
	.string	"__sw == (word)%ld"
.LC171:
	.string	") goto "
.LC172:
	.string	"__bsw%d_end:\n"
.LC173:
	.string	"__b_label_%d:\n"
.LC174:
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
.L1222:
	movl	g_no_line(%rip), %r10d
	testl	%r10d, %r10d
	jne	.L1223
	cmpb	$0, 24(%rsp)
	jne	.L1507
.L1223:
	cmpl	$12, (%rbx)
	ja	.L1221
	movl	(%rbx), %eax
	leaq	.L1226(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1226:
	.long	.L1237-.L1226
	.long	.L1236-.L1226
	.long	.L1235-.L1226
	.long	.L1234-.L1226
	.long	.L1233-.L1226
	.long	.L1232-.L1226
	.long	.L1231-.L1226
	.long	.L1221-.L1226
	.long	.L1230-.L1226
	.long	.L1229-.L1226
	.long	.L1228-.L1226
	.long	.L1227-.L1226
	.long	.L1225-.L1226
	.text
	.p2align 4,,10
	.p2align 3
.L1507:
	movl	4(%rbx), %edx
	movq	16(%rsp), %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC32(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1223
	.p2align 4,,10
	.p2align 3
.L1225:
	movl	g_switch_id(%rip), %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	leaq	.LC162(%rip), %r12
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
	je	.L1307
	movq	%rbx, 56(%rsp)
	movq	24(%rsp), %r13
	movq	%r14, 48(%rsp)
	movq	%rbp, %r14
	movq	40(%rsp), %rbp
	.p2align 4
	.p2align 3
.L1304:
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
	jb	.L1304
	movq	48(%rsp), %r14
	movq	56(%rsp), %rbx
.L1307:
	movl	8(%rsp), %edx
	movl	8(%rsp), %r12d
	xorl	%ebp, %ebp
	leaq	.LC31(%rip), %r13
	testl	%edx, %edx
	jle	.L1508
	.p2align 4
	.p2align 3
.L1305:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1305
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC163(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r12d
.L1308:
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 48(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1311:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1311
	movq	48(%rsp), %rbx
	movq	%r14, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC164(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	leaq	.LC122(%rip), %rax
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ecx
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC165(%rip), %rdx
	movl	$64, %esi
	call	snprintf@PLT
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 56(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1312:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1312
	movl	32(%rsp), %edx
	leaq	.LC166(%rip), %rsi
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
.L1313:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1313
	leaq	.LC167(%rip), %rax
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
.L1314:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1314
	movl	32(%rsp), %edx
	xorl	%eax, %eax
	leaq	.LC174(%rip), %rsi
	movq	%r14, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r15)
	leal	2(%rax), %ebx
	je	.L1316
.L1353:
	leaq	.LC149(%rip), %rax
	movq	%r15, 16(%rsp)
	xorl	%edi, %edi
	leaq	.LC31(%rip), %rbp
	movq	%rax, 56(%rsp)
	movl	%r12d, 76(%rsp)
	movq	%rdi, %r12
	.p2align 4
	.p2align 3
.L1330:
	movq	16(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r12,8), %r13
	movq	40(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1379
	xorl	%eax, %eax
	jmp	.L1321
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1320:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1379
.L1321:
	movq	(%rsi,%rax,8), %rdx
	cmpq	(%rdx), %r13
	jne	.L1320
	movq	8(%rdx), %rax
	movq	%rax, 24(%rsp)
.L1319:
	xorl	%r15d, %r15d
	testl	%ebx, %ebx
	jle	.L1325
	.p2align 4
	.p2align 3
.L1322:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebx, %r15d
	jne	.L1322
.L1325:
	movq	56(%rsp), %rdi
	movl	$1, %esi
	movq	%r14, %rcx
	movl	$4, %edx
	call	fwrite@PLT
	movl	20(%r13), %eax
	movq	24(%r13), %rsi
	testl	%eax, %eax
	je	.L1509
	leaq	.LC144(%rip), %rdx
	cmpl	$26, %eax
	je	.L1326
	ja	.L1327
	leaq	.LC142(%rip), %rdx
	cmpl	$24, %eax
	je	.L1326
	cmpl	$25, %eax
	leaq	.LC146(%rip), %rdx
	leaq	.LC143(%rip), %rax
	cmove	%rax, %rdx
.L1326:
	movq	%rsi, %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC168(%rip), %rsi
	call	fprintf@PLT
.L1328:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC171(%rip), %rdi
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
	jb	.L1330
	movl	76(%rsp), %r12d
	leaq	.LC31(%rip), %r13
	testl	%ebx, %ebx
	jle	.L1510
.L1316:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1332:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1332
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	testl	%r12d, %r12d
	jle	.L1483
	movl	8(%rsp), %r12d
	.p2align 4
	.p2align 3
.L1333:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jg	.L1333
.L1483:
	movl	32(%rsp), %edx
	leaq	.LC172(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	.p2align 4
	.p2align 3
.L1337:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1337
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	xorl	%ebx, %ebx
	leaq	.LC153(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	jle	.L1339
	.p2align 4
	.p2align 3
.L1340:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1340
.L1339:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC125(%rip), %rdi
	call	fwrite@PLT
.L1221:
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
.L1237:
	.cfi_restore_state
	movl	%r12d, %ebp
	xorl	%ebx, %ebx
	leaq	.LC31(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1506
	.p2align 4
	.p2align 3
.L1261:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1261
.L1506:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
.L1505:
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
.L1236:
	.cfi_restore_state
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%r12d, %r12d
	movl	8(%rsp), %r15d
	leaq	.LC31(%rip), %r13
	testl	%eax, %eax
	jle	.L1511
	.p2align 4
	.p2align 3
.L1259:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1259
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC155(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L1265
.L1264:
	movl	8(%rsp), %edi
	xorl	%r13d, %r13d
	addl	$1, %edi
	movl	%edi, 40(%rsp)
.L1272:
	movq	16(%rbx), %rdx
	movq	(%rdx,%r13,8), %r12
	testl	%ebp, %ebp
	je	.L1368
	subq	$1, %rax
	xorl	%ecx, %ecx
	cmpq	%r13, %rax
	je	.L1512
.L1267:
	movq	16(%rsp), %r8
	movl	40(%rsp), %edx
	movq	%r12, %rsi
	movq	%r14, %rdi
	call	emit_stmt
.L1270:
	movq	24(%rbx), %rax
	addq	$1, %r13
	cmpq	%rax, %r13
	jb	.L1272
	movl	8(%rsp), %r9d
	leaq	.LC31(%rip), %r13
	testl	%r9d, %r9d
	jle	.L1274
.L1265:
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1275:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1275
.L1274:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC125(%rip), %rdi
	jmp	.L1505
	.p2align 4,,10
	.p2align 3
.L1235:
	xorl	%r13d, %r13d
	cmpq	$0, 24(%rbx)
	movl	%r12d, 8(%rsp)
	leaq	.LC31(%rip), %rbp
	movl	8(%rsp), %r12d
	je	.L1221
	.p2align 4
	.p2align 3
.L1258:
	movq	16(%rbx), %rax
	movq	(%rax,%r13,8), %r15
	movq	(%r15), %rdi
	call	get_mangled_name
	movl	g_strict(%rip), %esi
	movq	%rax, 8(%rsp)
	testl	%esi, %esi
	je	.L1513
	cmpq	$0, 8(%r15)
	je	.L1350
.L1349:
	xorl	%r15d, %r15d
	testl	%r12d, %r12d
	jle	.L1280
	.p2align 4
	.p2align 3
.L1278:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1278
.L1280:
	movq	8(%rsp), %rcx
	leaq	.LC157(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	movq	%rcx, %r8
	movq	%rcx, %rdx
	call	fprintf@PLT
.L1279:
	addq	$1, %r13
	cmpq	24(%rbx), %r13
	jb	.L1258
	jmp	.L1221
	.p2align 4,,10
	.p2align 3
.L1234:
	xorl	%r15d, %r15d
	leaq	.LC31(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1284
	.p2align 4
	.p2align 3
.L1244:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1244
.L1284:
	movq	%r14, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC149(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	testl	%ebp, %ebp
	jne	.L1245
.L1246:
	movq	24(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L1285
	cmpl	$1, (%rsi)
	movl	%r12d, %edx
	je	.L1286
.L1285:
	leal	1(%r12), %edx
.L1286:
	movq	16(%rsp), %r8
	movl	%ebp, %ecx
	movq	%r14, %rdi
	call	emit_stmt
	cmpq	$0, 32(%rbx)
	je	.L1221
	xorl	%ebp, %ebp
	leaq	.LC31(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1290
	.p2align 4
	.p2align 3
.L1287:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1287
.L1290:
	movq	%r14, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC158(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L1242
	jmp	.L1243
	.p2align 4,,10
	.p2align 3
.L1233:
	xorl	%ebp, %ebp
	leaq	.LC31(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1292
	.p2align 4
	.p2align 3
.L1241:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1241
.L1292:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC147(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L1243
.L1242:
	cmpl	$1, (%rbx)
	je	.L1291
.L1243:
	addl	$1, %r12d
.L1291:
	xorl	%ebp, %ebp
	jmp	.L1222
	.p2align 4,,10
	.p2align 3
.L1232:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	movl	8(%rsp), %r12d
	leaq	.LC31(%rip), %r13
	testl	%eax, %eax
	jle	.L1293
	.p2align 4
	.p2align 3
.L1255:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1255
.L1293:
	movq	%r14, %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC154(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%rbx)
	je	.L1514
	movq	%r14, %rsi
	movl	$32, %edi
	call	fputc@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	jmp	.L1506
	.p2align 4,,10
	.p2align 3
.L1230:
	movl	%r12d, 8(%rsp)
	xorl	%ebx, %ebx
	movl	8(%rsp), %ebp
	leaq	.LC31(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1295
	.p2align 4
	.p2align 3
.L1251:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1251
.L1295:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC153(%rip), %rdi
	jmp	.L1505
	.p2align 4,,10
	.p2align 3
.L1231:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%r12d, %r12d
	movl	8(%rsp), %r15d
	leaq	.LC31(%rip), %r13
	testl	%eax, %eax
	jle	.L1294
	.p2align 4
	.p2align 3
.L1252:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1252
.L1294:
	testl	%ebp, %ebp
	jne	.L1515
.L1254:
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	jmp	.L1506
	.p2align 4,,10
	.p2align 3
.L1228:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	movl	8(%rsp), %r12d
	leaq	.LC31(%rip), %r13
	testl	%eax, %eax
	jle	.L1297
	.p2align 4
	.p2align 3
.L1247:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1247
.L1297:
	movq	%r14, %rcx
	movl	$8, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC150(%rip), %rdi
	leaq	.LC160(%rip), %r13
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	%r14, %rdi
	movq	16(%rsp), %rdx
	leaq	.LC31(%rip), %rbp
	call	emit_expr
	movq	%r14, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC151(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	movl	8(%rsp), %r15d
	je	.L1249
	.p2align 4
	.p2align 3
.L1248:
	xorl	%ebx, %ebx
	testl	%r15d, %r15d
	js	.L1299
	.p2align 4
	.p2align 3
.L1298:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r15d
	jge	.L1298
.L1299:
	addq	$1, %r12
	xorl	%eax, %eax
	movq	%r13, %rsi
	movq	%r14, %rdi
	movq	%r12, %rcx
	movq	%r12, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %r12
	jb	.L1248
.L1249:
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	js	.L1300
	xorl	%ebx, %ebx
	leaq	.LC31(%rip), %r13
	.p2align 4
	.p2align 3
.L1301:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jge	.L1301
	movq	%r14, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC161(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	je	.L1274
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1303:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1303
	jmp	.L1274
	.p2align 4,,10
	.p2align 3
.L1229:
	movl	%r12d, 8(%rsp)
	xorl	%ebx, %ebx
	movl	8(%rsp), %ebp
	leaq	.LC31(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1296
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
.L1296:
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC152(%rip), %rdi
	jmp	.L1505
	.p2align 4,,10
	.p2align 3
.L1227:
	xorl	%ebp, %ebp
	leaq	.LC31(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1516
	.p2align 4
	.p2align 3
.L1238:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1238
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 8(%rsp)
	testq	%rbp, %rbp
	je	.L1517
.L1239:
	movq	function_labels(%rip), %r15
	xorl	%r13d, %r13d
	jmp	.L1345
	.p2align 4,,10
	.p2align 3
.L1343:
	addq	$1, %r13
	cmpq	%rbp, %r13
	je	.L1240
.L1345:
	movq	(%r15,%r13,8), %rsi
	movq	8(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1343
	leal	1(%r13), %edx
.L1344:
	leaq	.LC173(%rip), %rsi
	movq	%r14, %rdi
	leal	1(%r12), %r15d
	xorl	%eax, %eax
	call	fprintf@PLT
	leaq	.LC31(%rip), %r13
	testl	%r15d, %r15d
	jle	.L1348
.L1346:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1347:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jne	.L1347
.L1348:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movl	%r15d, %r12d
	leaq	.LC122(%rip), %rdi
	xorl	%ebp, %ebp
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	jmp	.L1222
	.p2align 4,,10
	.p2align 3
.L1379:
	movq	$0, 24(%rsp)
	jmp	.L1319
	.p2align 4,,10
	.p2align 3
.L1509:
	movl	16(%r13), %eax
	testl	%eax, %eax
	je	.L1329
	movq	32(%r13), %rcx
	movq	%rsi, %rdx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC169(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1328
	.p2align 4,,10
	.p2align 3
.L1513:
	movq	16(%rsp), %rcx
	movl	%r12d, %edx
	movq	%r15, %rsi
	movq	%r14, %rdi
	call	emit_auto_storage
	cmpq	$0, 8(%r15)
	jne	.L1349
	movl	g_strict(%rip), %ecx
	testl	%ecx, %ecx
	je	.L1279
	.p2align 4
	.p2align 3
.L1350:
	xorl	%r15d, %r15d
	testl	%r12d, %r12d
	jle	.L1282
	.p2align 4
	.p2align 3
.L1281:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1281
.L1282:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1279
.L1512:
	cmpl	$6, (%r12)
	movl	%ebp, %ecx
	jne	.L1267
	movl	g_no_line(%rip), %r8d
	testl	%r8d, %r8d
	jne	.L1268
	cmpb	$0, 24(%rsp)
	je	.L1268
	movl	4(%r12), %edx
	movq	16(%rsp), %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC32(%rip), %rsi
	call	fprintf@PLT
.L1268:
	movl	8(%rsp), %edi
	leaq	.LC31(%rip), %rax
	xorl	%r15d, %r15d
	movq	%rax, 32(%rsp)
	testl	%edi, %edi
	js	.L1271
	.p2align 4
	.p2align 3
.L1269:
	movq	32(%rsp), %rdi
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r15d
	call	fwrite@PLT
	cmpl	%r15d, 8(%rsp)
	jge	.L1269
.L1271:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC156(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r12), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1270
	.p2align 4,,10
	.p2align 3
.L1329:
	movq	%rsi, %rdx
	movq	%r14, %rdi
	leaq	.LC170(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1328
	.p2align 4,,10
	.p2align 3
.L1368:
	xorl	%ecx, %ecx
	jmp	.L1267
	.p2align 4,,10
	.p2align 3
.L1327:
	cmpl	$27, %eax
	leaq	.LC146(%rip), %rdx
	leaq	.LC145(%rip), %rax
	cmove	%rax, %rdx
	jmp	.L1326
.L1245:
	xorl	%ebp, %ebp
	cmpq	$0, 32(%rbx)
	sete	%bpl
	jmp	.L1246
.L1510:
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	xorl	%eax, %eax
	movq	%r14, %rdi
	call	fprintf@PLT
	testl	%r12d, %r12d
	jle	.L1504
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
.L1504:
	movl	32(%rsp), %edx
	movq	%r14, %rdi
	leaq	.LC172(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC153(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1339
.L1516:
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 8(%rsp)
	testq	%rbp, %rbp
	jne	.L1239
.L1240:
	xorl	%edx, %edx
	jmp	.L1344
.L1515:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC156(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1254
.L1514:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC159(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1506
.L1300:
	movq	%r14, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC161(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1274
.L1511:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC155(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	jne	.L1264
	jmp	.L1274
.L1508:
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC163(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r12d
	testl	%eax, %eax
	je	.L1308
	movq	%r14, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC164(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	leaq	.LC122(%rip), %rax
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ebp
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC165(%rip), %rdx
	movl	$64, %esi
	movl	%ebp, %ecx
	call	snprintf@PLT
	movl	%ebp, %edx
	leaq	.LC166(%rip), %rsi
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
	leaq	.LC167(%rip), %rax
	movq	%rax, %rsi
	movq	%rax, 64(%rsp)
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%eax, %eax
	movl	%ebp, %edx
	leaq	.LC174(%rip), %rsi
	movq	%r14, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r15)
	leal	2(%rax), %ebx
	jne	.L1353
	cmpl	$1, %ebx
	je	.L1316
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1504
	.p2align 4,,10
	.p2align 3
.L1517:
	xorl	%edx, %edx
	leaq	.LC173(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%r12), %r15d
	jmp	.L1346
	.cfi_endproc
.LFE59:
	.size	emit_stmt, .-emit_stmt
	.section	.rodata.str1.1
.LC175:
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
	leaq	.L1523(%rip), %r15
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
	je	.L1518
.L1519:
	cmpl	$13, 0(%r13)
	ja	.L1521
	movl	0(%r13), %eax
	movslq	(%r15,%rax,4), %rax
	addq	%r15, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1523:
	.long	.L1521-.L1523
	.long	.L1527-.L1523
	.long	.L1521-.L1523
	.long	.L1526-.L1523
	.long	.L1525-.L1523
	.long	.L1521-.L1523
	.long	.L1521-.L1523
	.long	.L1521-.L1523
	.long	.L1521-.L1523
	.long	.L1521-.L1523
	.long	.L1521-.L1523
	.long	.L1524-.L1523
	.long	.L1521-.L1523
	.long	.L1522-.L1523
	.text
	.p2align 4,,10
	.p2align 3
.L1521:
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
.L1522:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1571
	xorl	%eax, %eax
	jmp	.L1541
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1540:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1571
.L1541:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%r13, (%rdx)
	jne	.L1540
	movq	8(%rdx), %r14
.L1539:
	xorl	%r13d, %r13d
	leaq	.LC31(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1605
	.p2align 4
	.p2align 3
.L1542:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1542
	movq	%r14, %rdx
	leaq	.LC175(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1545:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jle	.L1545
.L1544:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	jmp	.L1604
	.p2align 4,,10
	.p2align 3
.L1524:
	xorl	%r14d, %r14d
	leaq	.LC31(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1606
	.p2align 4
	.p2align 3
.L1528:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1528
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L1607
.L1529:
	movq	function_labels(%rip), %r14
	xorl	%r12d, %r12d
	jmp	.L1549
	.p2align 4,,10
	.p2align 3
.L1547:
	addq	$1, %r12
	cmpq	%r12, 24(%rsp)
	je	.L1530
.L1549:
	movq	(%r14,%r12,8), %rsi
	movq	16(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1547
	leal	1(%r12), %edx
.L1548:
	leaq	.LC173(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	leaq	.LC31(%rip), %r12
	movl	%eax, 16(%rsp)
	testl	%eax, %eax
	jle	.L1608
.L1550:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1552:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, %ebp
	jne	.L1552
	movl	16(%rsp), %ebp
.L1553:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	jne	.L1519
	jmp	.L1518
	.p2align 4,,10
	.p2align 3
.L1525:
	xorl	%r14d, %r14d
	leaq	.LC31(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1565
	.p2align 4
	.p2align 3
.L1531:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1531
.L1565:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC147(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	je	.L1518
.L1532:
	xorl	%eax, %eax
	cmpl	$1, 0(%r13)
	setne	%al
	addl	%eax, %ebp
	jmp	.L1519
	.p2align 4,,10
	.p2align 3
.L1526:
	xorl	%r14d, %r14d
	leaq	.LC31(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1560
	.p2align 4
	.p2align 3
.L1534:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1534
.L1560:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC149(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %rsi
	testq	%rsi, %rsi
	je	.L1536
	cmpl	$1, (%rsi)
	movl	%ebp, %edx
	je	.L1561
.L1536:
	leal	1(%rbp), %edx
.L1561:
	movq	(%rsp), %r8
	movq	8(%rsp), %rcx
	movq	%rbx, %rdi
	call	emit_stmt_switchctx
	cmpq	$0, 32(%r13)
	je	.L1518
	xorl	%r14d, %r14d
	leaq	.LC31(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1564
	.p2align 4
	.p2align 3
.L1562:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1562
.L1564:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC158(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r13), %r13
	testq	%r13, %r13
	jne	.L1532
.L1518:
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
.L1527:
	.cfi_restore_state
	xorl	%r15d, %r15d
	leaq	.LC31(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1609
	.p2align 4
	.p2align 3
.L1537:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebp, %r15d
	jne	.L1537
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC155(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	je	.L1555
.L1554:
	leal	1(%rbp), %r12d
	xorl	%r15d, %r15d
.L1557:
	movq	16(%r13), %rax
	movq	(%rsp), %r8
	movl	%r12d, %edx
	movq	%rbx, %rdi
	movq	8(%rsp), %rcx
	movq	(%rax,%r15,8), %rsi
	addq	$1, %r15
	call	emit_stmt_switchctx
	cmpq	24(%r13), %r15
	jb	.L1557
	leaq	.LC31(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1556
.L1555:
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1559:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1559
.L1556:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC125(%rip), %rdi
.L1604:
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
.L1571:
	.cfi_restore_state
	xorl	%r14d, %r14d
	jmp	.L1539
	.p2align 4,,10
	.p2align 3
.L1606:
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	jne	.L1529
	.p2align 4
	.p2align 3
.L1530:
	xorl	%edx, %edx
	jmp	.L1548
.L1607:
	xorl	%edx, %edx
	leaq	.LC173(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	movl	%eax, 16(%rsp)
	jmp	.L1550
	.p2align 4,,10
	.p2align 3
.L1605:
	xorl	%eax, %eax
	movq	%r14, %rdx
	leaq	.LC175(%rip), %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	testl	%ebp, %ebp
	jne	.L1544
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	jmp	.L1544
	.p2align 4,,10
	.p2align 3
.L1608:
	movl	%eax, %ebp
	jmp	.L1553
	.p2align 4,,10
	.p2align 3
.L1609:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC155(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	jne	.L1554
	jmp	.L1556
	.cfi_endproc
.LFE46:
	.size	emit_stmt_switchctx, .-emit_stmt_switchctx
	.section	.rodata.str1.1
.LC176:
	.string	"static "
.LC177:
	.string	""
	.section	.rodata.str1.8
	.align 8
.LC178:
	.string	"#ifndef %s\nextern word %s[];\n#define __b_external_%s (%s[0])\n#else\n#define __b_external_%s (%s)\n#endif\n"
	.section	.rodata.str1.1
.LC179:
	.string	"extern word %s[];\n"
.LC180:
	.string	"%sword %s[%zu];\n"
.LC181:
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
	je	.L1610
	movq	%rdi, %rbp
	movq	%rsi, %r12
	xorl	%ebx, %ebx
	jmp	.L1624
	.p2align 4,,10
	.p2align 3
.L1613:
	addq	$1, %rbx
	cmpq	8(%r12), %rbx
	jnb	.L1610
.L1624:
	movq	(%r12), %rax
	movq	(%rax,%rbx,8), %r14
	movl	(%r14), %eax
	testl	%eax, %eax
	je	.L1642
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L1613
	movq	8(%r14), %r13
	movq	16(%r13), %rdi
	call	get_mangled_name
	cmpl	$3, (%r14)
	movq	%rax, %r15
	je	.L1643
	cmpl	$1, 24(%r13)
	movl	$1, %r8d
	jne	.L1618
	movq	56(%r13), %rdi
	movl	$1, %r11d
	testq	%rdi, %rdi
	je	.L1619
	cmpl	$1, (%rdi)
	je	.L1644
.L1619:
	call	edge_tail_words_top
	leaq	(%rax,%r11), %r8
	movl	$1, %eax
	testq	%r8, %r8
	cmove	%rax, %r8
.L1618:
	movl	4(%r13), %eax
	leaq	.LC177(%rip), %rdx
	testl	%eax, %eax
	je	.L1620
	leaq	.LC176(%rip), %rdx
.L1620:
	xorl	%eax, %eax
	movq	%r15, %rcx
	leaq	.LC180(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$2, 24(%r13)
	jne	.L1613
	movq	56(%r13), %rdi
	xorl	%r11d, %r11d
	testq	%rdi, %rdi
	je	.L1621
	cmpl	$1, (%rdi)
	je	.L1645
.L1621:
	cmpq	$0, 32(%r13)
	je	.L1622
	movq	48(%r13), %rax
	movq	%r11, %rdx
	cmpq	%rax, %r11
	cmovb	%rax, %r11
	testq	%rax, %rax
	cmovle	%rdx, %r11
.L1622:
	call	edge_tail_words_top
	movq	%r15, %rdx
	leaq	.LC181(%rip), %rsi
	movq	%rbp, %rdi
	leaq	(%rax,%r11), %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	xorl	%eax, %eax
	addq	$1, %rbx
	call	fprintf@PLT
	cmpq	8(%r12), %rbx
	jb	.L1624
.L1610:
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
.L1642:
	.cfi_restore_state
	movq	8(%r14), %rsi
	movq	(%rsp), %r8
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbp, %rdi
	call	emit_stmt
	jmp	.L1613
	.p2align 4,,10
	.p2align 3
.L1643:
	movq	16(%r13), %rdx
	movq	%rdx, %rdi
	movq	%rdx, 8(%rsp)
	call	global_data_kind
	testl	%eax, %eax
	je	.L1613
	movl	8(%r13), %esi
	testl	%esi, %esi
	je	.L1617
	movq	8(%rsp), %rdx
	movq	%r15, %rcx
	movq	%r15, %r9
	movq	%r15, %r8
	leaq	.LC178(%rip), %rsi
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
	jmp	.L1613
	.p2align 4,,10
	.p2align 3
.L1644:
	movq	24(%rdi), %r11
	jmp	.L1619
	.p2align 4,,10
	.p2align 3
.L1617:
	movq	%r15, %rdx
	leaq	.LC179(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1613
.L1645:
	movq	24(%rdi), %r11
	jmp	.L1621
	.cfi_endproc
.LFE64:
	.size	emit_global_declarations, .-emit_global_declarations
	.section	.rodata.str1.1
.LC182:
	.string	"{\n    B_FRAME;\n"
	.section	.rodata.str1.8
	.align 8
.LC183:
	.string	"    size_t __bcc_count = __bcc_current_call ? __bcc_current_call->count : 0;\n"
	.align 8
.LC184:
	.string	"    if (__bcc_count < %zu) __bcc_count = %zu;\n"
	.align 8
.LC185:
	.string	"    word __bcc_parameters[__bcc_count];\n    for (size_t __bcc_i = 0; __bcc_i < __bcc_count; ++__bcc_i)\n        __bcc_parameters[__bcc_i] = __bcc_current_call && __bcc_i < __bcc_current_call->count\n            ? __bcc_current_call->arguments[__bcc_i] : 0;\n"
	.align 8
.LC186:
	.string	"    (void)B_LOCAL_PTR_N(__bcc_parameters, sizeof(__bcc_parameters));\n"
	.align 8
.LC187:
	.string	"    static word __b_label_value_%zu = %zu;\n"
	.section	.rodata.str1.1
.LC188:
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
	leaq	.LC182(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%r14)
	jne	.L1659
.L1648:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L1660
.L1650:
	cmpq	$0, 8+function_labels(%rip)
	je	.L1654
	xorl	%ebx, %ebx
	leaq	.LC187(%rip), %r12
	.p2align 4
	.p2align 3
.L1655:
	addq	$1, %rbx
	xorl	%eax, %eax
	movq	%r12, %rsi
	movq	%rbp, %rdi
	movq	%rbx, %rcx
	movq	%rbx, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %rbx
	jb	.L1655
.L1654:
	movq	32(%r14), %rsi
	movq	%r13, %r8
	movq	%rbp, %rdi
	movl	$1, %ecx
	movl	$1, %edx
	call	emit_stmt
	movq	%rbp, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC188(%rip), %rdi
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
.L1659:
	.cfi_restore_state
	movq	%rbp, %rcx
	movl	$77, %edx
	movl	$1, %esi
	leaq	.LC183(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r14), %rdx
	movq	%rbp, %rdi
	xorl	%eax, %eax
	leaq	.LC184(%rip), %rsi
	movq	%rdx, %rcx
	call	fprintf@PLT
	movq	%rbp, %rcx
	movl	$255, %edx
	movl	$1, %esi
	leaq	.LC185(%rip), %rdi
	call	fwrite@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L1648
	movq	%rbp, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC186(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1648
	.p2align 4,,10
	.p2align 3
.L1660:
	movq	32(%r14), %rdi
	pxor	%xmm0, %xmm0
	movq	%rsp, %rsi
	movq	$0, 16(%rsp)
	movaps	%xmm0, (%rsp)
	call	collect_function_autos
	cmpq	$0, 8(%rsp)
	je	.L1651
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1652:
	movq	(%rsp), %rax
	movq	%r13, %rcx
	movl	$1, %edx
	movq	%rbp, %rdi
	movq	(%rax,%rbx,8), %rsi
	addq	$1, %rbx
	call	emit_auto_storage
	cmpq	8(%rsp), %rbx
	jb	.L1652
.L1651:
	cmpq	$0, g_compilation_arena(%rip)
	jne	.L1650
	movq	(%rsp), %rdi
	call	free@PLT
	jmp	.L1650
	.cfi_endproc
.LFE60:
	.size	emit_function_body, .-emit_function_body
	.section	.rodata.str1.1
.LC189:
	.string	"#define BCC_USE_CURSES 1\n"
	.section	.rodata.str1.8
	.align 8
.LC190:
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
.LC191:
	.string	"#define __bcc_strict_runtime %d\n"
	.section	.rodata.str1.1
.LC192:
	.string	"#define B_BYTEPTR %d\n"
.LC193:
	.string	"#define WORD_BITS %d\n"
	.section	.rodata.str1.8
	.align 8
.LC194:
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
.LC195:
	.string	"%s/btarget.h"
	.section	.rodata.str1.8
	.align 8
.LC196:
	.string	"#define B_TARGET_DEFINE\n#define B_TARGET_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC197:
	.string	"%s/binit.h"
	.section	.rodata.str1.8
	.align 8
.LC198:
	.string	"#define B_INIT_DEFINE\n#define B_INIT_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC199:
	.string	"%s/bcall.h"
	.section	.rodata.str1.8
	.align 8
.LC200:
	.string	"#define B_CALL_DEFINE\n#define B_CALL_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC201:
	.string	"%s/bunix.h"
	.section	.rodata.str1.8
	.align 8
.LC202:
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
.LC203:
	.string	"%s/bformat.h"
	.section	.rodata.str1.8
	.align 8
.LC204:
	.string	"#define __bcc_format_linkage static\n"
	.align 8
.LC205:
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
.LC206:
	.string	"word __b_user_main("
.LC207:
	.string	"void)\n"
	.section	.rodata.str1.8
	.align 8
.LC208:
	.string	"int main(int argc, char **argv){\n"
	.section	.rodata.str1.1
.LC209:
	.string	"    __b_setargs(argc, argv);\n"
.LC210:
	.string	"    __b_init();\n"
	.section	.rodata.str1.8
	.align 8
.LC211:
	.string	"    return (int)__bcc_call%zu("
	.section	.rodata.str1.1
.LC212:
	.string	", (word)argc"
.LC213:
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
	jne	.L1683
.L1662:
	movq	%rbx, %rcx
	movl	$1529, %edx
	movl	$1, %esi
	leaq	.LC190(%rip), %rdi
	call	fwrite@PLT
	movl	g_strict(%rip), %eax
	xorl	%edx, %edx
	movq	%rbx, %rdi
	leaq	.LC191(%rip), %rsi
	testl	%eax, %eax
	setne	%dl
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbx, %rdi
	setne	%dl
	leaq	.LC192(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%r12d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC193(%rip), %rsi
	leaq	24(%rsp), %r12
	call	fprintf@PLT
	movq	%rbx, %rcx
	movl	$1378, %edx
	movl	$1, %esi
	leaq	.LC194(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC195(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$73, %edx
	movl	$1, %esi
	leaq	.LC196(%rip), %rdi
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
	leaq	.LC197(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC198(%rip), %rdi
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
	leaq	.LC199(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	movq	%rax, %r14
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC200(%rip), %rdi
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
	je	.L1684
.L1663:
	movq	g_libb_path(%rip), %rsi
	leaq	.LC201(%rip), %rdi
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
	leaq	.LC202(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC203(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$36, %edx
	movl	$1, %esi
	leaq	.LC204(%rip), %rdi
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
	leaq	.LC205(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1685
.L1664:
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
	je	.L1661
	xorl	%r15d, %r15d
	xorl	%r13d, %r13d
	xorl	%r14d, %r14d
	jmp	.L1669
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1666:
	addq	$1, %r15
	cmpq	8(%rbp), %r15
	jnb	.L1686
.L1669:
	movq	0(%rbp), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L1666
	movq	8(%rax), %r12
	leaq	.LC15(%rip), %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1667
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	movq	16(%r12), %r13
	leaq	.LC206(%rip), %rdi
	movl	$1, %r14d
	call	fwrite@PLT
.L1668:
	movq	%rbx, %rcx
	movl	$6, %edx
	movl	$1, %esi
	addq	$1, %r15
	leaq	.LC207(%rip), %rdi
	call	fwrite@PLT
	movq	8(%rsp), %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_function_body
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	8(%rbp), %r15
	jb	.L1669
.L1686:
	testl	%r14d, %r14d
	jne	.L1687
.L1661:
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
.L1667:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC23(%rip), %rdi
	call	fwrite@PLT
	movq	(%r12), %rsi
	movq	%rbx, %rdi
	call	emit_function_body_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1668
	.p2align 4,,10
	.p2align 3
.L1683:
	movq	%rbx, %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC189(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1662
	.p2align 4,,10
	.p2align 3
.L1687:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC208(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC209(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC210(%rip), %rdi
	call	fwrite@PLT
	movl	$2, %edx
	leaq	.LC211(%rip), %rsi
	movq	%rbx, %rdi
	cmpq	%rdx, %r13
	cmovbe	%r13, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	leaq	.LC15(%rip), %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC30(%rip), %rdi
	call	fwrite@PLT
	testq	%r13, %r13
	jne	.L1688
.L1673:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC25(%rip), %rdi
	call	fwrite@PLT
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$2, %edx
	popq	%rbx
	.cfi_def_cfa_offset 48
	movl	$1, %esi
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
.L1685:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1664
	.p2align 4,,10
	.p2align 3
.L1684:
	movq	%r14, %rdi
	call	free@PLT
	jmp	.L1663
	.p2align 4,,10
	.p2align 3
.L1688:
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC212(%rip), %rdi
	call	fwrite@PLT
	cmpq	$1, %r13
	je	.L1673
	movq	%rbx, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC213(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1673
	.cfi_endproc
.LFE66:
	.size	emit_program_c, .-emit_program_c
	.section	.rodata.str1.8
	.align 8
.LC214:
	.string	"/* Generated by BCC - B Compiler */\n"
	.section	.rodata.str1.1
.LC215:
	.string	"#include \"libb.h\"\n\n"
	.section	.rodata.str1.8
	.align 8
.LC216:
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
	je	.L1711
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
	leaq	.LC214(%rip), %rdi
	call	fwrite@PLT
	movl	g_strict(%rip), %ecx
	xorl	%edx, %edx
	movq	%rbx, %rdi
	leaq	.LC191(%rip), %rsi
	testl	%ecx, %ecx
	setne	%dl
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbx, %rdi
	setne	%dl
	leaq	.LC192(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%r12d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC193(%rip), %rsi
	call	fprintf@PLT
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$19, %edx
	leaq	.LC215(%rip), %rdi
	call	fwrite@PLT
	movl	g_use_curses(%rip), %esi
	testl	%esi, %esi
	jne	.L1712
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1713
.L1692:
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
	je	.L1689
	movl	$0, 12(%rsp)
	xorl	%r15d, %r15d
	xorl	%r13d, %r13d
	jmp	.L1697
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1694:
	addq	$1, %r15
	cmpq	8(%r14), %r15
	jnb	.L1714
.L1697:
	movq	(%r14), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L1694
	movq	8(%rax), %r12
	leaq	.LC15(%rip), %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1695
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	movq	16(%r12), %r13
	leaq	.LC206(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 12(%rsp)
.L1696:
	movq	%rbx, %rcx
	movl	$6, %edx
	movl	$1, %esi
	addq	$1, %r15
	leaq	.LC207(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_function_body
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	8(%r14), %r15
	jb	.L1697
.L1714:
	movl	12(%rsp), %eax
	testl	%eax, %eax
	jne	.L1715
.L1689:
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
.L1695:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC23(%rip), %rdi
	call	fwrite@PLT
	movq	(%r12), %rsi
	movq	%rbx, %rdi
	call	emit_function_body_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1696
	.p2align 4,,10
	.p2align 3
.L1713:
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1692
	.p2align 4,,10
	.p2align 3
.L1712:
	movq	%rbx, %rcx
	movl	$41, %edx
	movl	$1, %esi
	leaq	.LC216(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	je	.L1692
	jmp	.L1713
	.p2align 4,,10
	.p2align 3
.L1715:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC208(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC209(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC210(%rip), %rdi
	call	fwrite@PLT
	movl	$2, %edx
	leaq	.LC211(%rip), %rsi
	movq	%rbx, %rdi
	cmpq	%rdx, %r13
	cmovbe	%r13, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	leaq	.LC15(%rip), %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC30(%rip), %rdi
	call	fwrite@PLT
	testq	%r13, %r13
	jne	.L1716
.L1701:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC25(%rip), %rdi
	call	fwrite@PLT
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$2, %edx
	popq	%rbx
	.cfi_def_cfa_offset 48
	movl	$1, %esi
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
.L1711:
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
.L1716:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC212(%rip), %rdi
	call	fwrite@PLT
	cmpq	$1, %r13
	je	.L1701
	movq	%rbx, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC213(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1701
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
.LC217:
	.string	"lchar"
.LC218:
	.string	"getchar"
.LC219:
	.string	"getchr"
.LC220:
	.string	"putchr"
.LC221:
	.string	"getstr"
.LC222:
	.string	"putstr"
.LC223:
	.string	"flush"
.LC224:
	.string	"reread"
.LC225:
	.string	"printn"
.LC226:
	.string	"putnum"
.LC227:
	.string	"print"
.LC228:
	.string	"putchar"
.LC229:
	.string	"abort"
.LC230:
	.string	"free"
.LC231:
	.string	"alloc"
.LC232:
	.string	"open"
.LC233:
	.string	"close"
.LC234:
	.string	"read"
.LC235:
	.string	"write"
.LC236:
	.string	"creat"
.LC237:
	.string	"seek"
.LC238:
	.string	"openr"
.LC239:
	.string	"openw"
.LC240:
	.string	"fork"
.LC241:
	.string	"wait"
.LC242:
	.string	"execl"
.LC243:
	.string	"execv"
.LC244:
	.string	"chdir"
.LC245:
	.string	"chmod"
.LC246:
	.string	"chown"
.LC247:
	.string	"link"
.LC248:
	.string	"unlink"
.LC249:
	.string	"stat"
.LC250:
	.string	"fstat"
.LC251:
	.string	"time"
.LC252:
	.string	"ctime"
.LC253:
	.string	"getuid"
.LC254:
	.string	"setuid"
.LC255:
	.string	"makdir"
.LC256:
	.string	"mkdir"
.LC257:
	.string	"intr"
.LC258:
	.string	"gtty"
.LC259:
	.string	"stty"
.LC260:
	.string	"system"
.LC261:
	.string	"usleep"
.LC262:
	.string	"argc"
	.section	.data.rel.ro.local,"aw"
	.align 32
	.type	names.0, @object
	.size	names.0, 416
names.0:
	.quad	.LC3
	.quad	.LC217
	.quad	.LC218
	.quad	.LC219
	.quad	.LC220
	.quad	.LC221
	.quad	.LC222
	.quad	.LC223
	.quad	.LC224
	.quad	.LC68
	.quad	.LC225
	.quad	.LC226
	.quad	.LC227
	.quad	.LC228
	.quad	.LC74
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
	.quad	.LC259
	.quad	.LC260
	.quad	.LC261
	.quad	.LC62
	.quad	.LC262
	.quad	.LC27
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
.LC263:
	.string	"break"
.LC264:
	.string	"case"
.LC265:
	.string	"const"
.LC266:
	.string	"continue"
.LC267:
	.string	"default"
.LC268:
	.string	"do"
.LC269:
	.string	"double"
.LC270:
	.string	"else"
.LC271:
	.string	"enum"
.LC272:
	.string	"extern"
.LC273:
	.string	"float"
.LC274:
	.string	"for"
.LC275:
	.string	"goto"
.LC276:
	.string	"if"
.LC277:
	.string	"inline"
.LC278:
	.string	"int"
.LC279:
	.string	"long"
.LC280:
	.string	"register"
.LC281:
	.string	"restrict"
.LC282:
	.string	"short"
.LC283:
	.string	"signed"
.LC284:
	.string	"sizeof"
.LC285:
	.string	"static"
.LC286:
	.string	"struct"
.LC287:
	.string	"switch"
.LC288:
	.string	"typedef"
.LC289:
	.string	"union"
.LC290:
	.string	"unsigned"
.LC291:
	.string	"volatile"
.LC292:
	.string	"while"
.LC293:
	.string	"_Bool"
.LC294:
	.string	"_Complex"
.LC295:
	.string	"_Imaginary"
.LC296:
	.string	"_Alignas"
.LC297:
	.string	"_Alignof"
.LC298:
	.string	"_Atomic"
.LC299:
	.string	"_Generic"
.LC300:
	.string	"_Noreturn"
.LC301:
	.string	"_Static_assert"
.LC302:
	.string	"_Thread_local"
.LC303:
	.string	"NULL"
.LC304:
	.string	"true"
.LC305:
	.string	"false"
.LC306:
	.string	"bool"
.LC307:
	.string	"word"
.LC308:
	.string	"B_PTR"
.LC309:
	.string	"B_ADDR"
.LC310:
	.string	"B_DEREF"
	.section	.data.rel.ro.local
	.align 32
	.type	c_keywords, @object
	.size	c_keywords, 424
c_keywords:
	.quad	.LC4
	.quad	.LC263
	.quad	.LC264
	.quad	.LC3
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
	.quad	.LC154
	.quad	.LC282
	.quad	.LC283
	.quad	.LC284
	.quad	.LC285
	.quad	.LC286
	.quad	.LC287
	.quad	.LC288
	.quad	.LC289
	.quad	.LC290
	.quad	.LC24
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
	.quad	.LC308
	.quad	.LC309
	.quad	.LC310
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
