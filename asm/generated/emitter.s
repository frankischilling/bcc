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
.LFB56:
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
.LFE56:
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
.LFB77:
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
.LFE77:
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
.LFE62:
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
.LFB73:
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
.LFE73:
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
	.string	"B_FUNCTION("
.LC60:
	.string	"({ word __bcc_callee_%u = "
.LC61:
	.string	"; word __bcc_args_%u[%zu] = {"
	.section	.rodata.str1.8
	.align 8
.LC62:
	.string	"}; __bcc_is_source_function(__bcc_callee_%u) ? __bcc_invoke_source(__bcc_callee_%u, %zu, __bcc_args_%u) : ((word (*)())B_FUNCTION_CPTR(__bcc_callee_%u))("
	.section	.rodata.str1.1
.LC63:
	.string	", "
.LC64:
	.string	"__bcc_args_%u[%zu]"
.LC65:
	.string	"); })"
.LC66:
	.string	"callf"
.LC67:
	.string	"b_callf_dispatch(%zu"
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
	.string	"B_INDEX("
.LC88:
	.string	"B_DEREF("
.LC89:
	.string	"WNEG("
.LC90:
	.string	"({ word __b_left_%u = "
.LC91:
	.string	"; word __b_right_%u = "
	.section	.rodata.str1.8
	.align 8
.LC92:
	.string	"; (word)%s(__b_left_%u, __b_right_%u); })"
	.section	.rodata.str1.1
.LC93:
	.string	" %s "
.LC94:
	.string	"%s("
.LC95:
	.string	"({ word *__b_dest_%u = &("
.LC96:
	.string	"); word __b_rhs_%u = ("
	.section	.rodata.str1.8
	.align 8
.LC97:
	.string	"); *__b_dest_%u = (*__b_dest_%u %s __b_rhs_%u); })"
	.section	.rodata.str1.1
.LC98:
	.string	"b_"
.LC99:
	.string	"(&("
.LC100:
	.string	"), "
.LC101:
	.string	"="
.LC102:
	.string	" ? "
.LC103:
	.string	" : "
.LC104:
	.string	"snprintf"
.LC105:
	.string	"sprintf"
.LC106:
	.string	"fprintf"
.LC107:
	.string	"dprintf"
	.text
	.p2align 4
	.globl	emit_expr
	.type	emit_expr, @function
emit_expr:
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
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	cmpl	$10, (%rsi)
	movq	%rdi, 8(%rsp)
	ja	.L496
	movl	(%rsi), %eax
	movq	%rdx, %rbp
	leaq	.L499(%rip), %rdx
	movq	%rsi, %r15
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
	leaq	.LC102(%rip), %rdi
	call	fwrite@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$3, %edx
	leaq	.LC103(%rip), %rdi
	call	fwrite@PLT
	movq	64(%r15), %rsi
.L921:
	movq	%rbp, %rdx
.L922:
	movq	%rbx, %rdi
	call	emit_expr
.L923:
	movq	%rbx, %rsi
.L926:
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
.L498:
	.cfi_restore_state
	movq	8(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
.L925:
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC63(%rip), %rdi
.L924:
	call	fwrite@PLT
	movq	56(%r15), %rsi
	jmp	.L921
	.p2align 4,,10
	.p2align 3
.L509:
	movq	48(%rsi), %rdx
	leaq	.LC55(%rip), %rsi
.L919:
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
.L508:
	.cfi_restore_state
	movq	48(%r15), %rdi
	movq	40(%rsi), %rsi
	call	get_string_id
	movq	8(%rsp), %rdi
	addq	$88, %rsp
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
	addl	$1, %edx
	je	.L510
	movq	8(%rsp), %rdi
	addq	$88, %rsp
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
.L506:
	.cfi_restore_state
	movq	48(%rsi), %rax
	movl	24(%rsi), %ebx
	cmpl	$2, (%rax)
	je	.L521
	testl	%ebx, %ebx
	jne	.L522
	movb	$0, 32(%rsp)
	movq	48(%rax), %rsi
	xorl	%r12d, %r12d
	xorl	%r14d, %r14d
	movb	$0, 39(%rsp)
	movq	$0, 24(%rsp)
.L547:
	movq	8(%rsp), %rdi
	call	emit_function_name
.L554:
	movq	8(%rsp), %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	64(%r15), %rdx
	movq	24(%rsp), %rcx
	cmpq	%rdx, %rcx
	jnb	.L555
	cmpb	$0, 39(%rsp)
	je	.L555
	movq	56(%r15), %rax
	movq	(%rax,%rcx,8), %rax
	testq	%rax, %rax
	je	.L582
	cmpl	$1, (%rax)
	je	.L932
.L582:
	movq	$0, 40(%rsp)
.L558:
	movl	%ebx, 48(%rsp)
	movq	8(%rsp), %r13
	xorl	%r12d, %r12d
	movq	%r14, 16(%rsp)
	movq	%rdx, %r14
.L621:
	cmpb	$0, 32(%rsp)
	je	.L688
	movl	g_strict(%rip), %ebx
	testl	%ebx, %ebx
	je	.L933
.L688:
	xorl	%ebx, %ebx
.L584:
	movq	56(%r15), %rax
	movq	%rbp, %rdx
	movq	%r13, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
.L653:
	testl	%ebx, %ebx
	jne	.L934
.L619:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L620
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC63(%rip), %rdi
	call	fwrite@PLT
	jmp	.L621
	.p2align 4,,10
	.p2align 3
.L505:
	movq	8(%rsp), %rbx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC87(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	jmp	.L925
	.p2align 4,,10
	.p2align 3
.L504:
	movl	48(%rsi), %r12d
	cmpl	$32, %r12d
	je	.L935
	cmpl	$53, %r12d
	je	.L936
	leal	-36(%r12), %eax
	cmpl	$1, %eax
	jbe	.L937
	movq	8(%rsp), %rbx
	cmpl	$31, %r12d
	je	.L938
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
	jmp	.L927
	.p2align 4,,10
	.p2align 3
.L503:
	cmpl	$36, 48(%rsi)
	movq	56(%rsi), %r12
	leaq	.LC36(%rip), %rdi
	jne	.L628
	leaq	.LC35(%rip), %rdi
.L628:
	movq	8(%rsp), %rbx
	movl	$12, %edx
	movl	$1, %esi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r12, %rsi
.L927:
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC86(%rip), %rdi
.L920:
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
.L502:
	.cfi_restore_state
	movl	48(%rsi), %r12d
	leal	-53(%r12), %eax
	cmpl	$1, %eax
	jbe	.L939
	leal	-28(%r12), %eax
	cmpl	$6, %eax
	ja	.L631
	leaq	.L633(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L633:
	.long	.L699-.L633
	.long	.L638-.L633
	.long	.L637-.L633
	.long	.L636-.L633
	.long	.L635-.L633
	.long	.L634-.L633
	.long	.L632-.L633
	.text
	.p2align 4,,10
	.p2align 3
.L501:
	movl	48(%rsi), %r12d
	movq	56(%rsi), %r13
	movq	64(%rsi), %r14
	leal	-47(%r12), %eax
	cmpl	$5, %eax
	jbe	.L940
	cmpl	$21, %r12d
	je	.L641
	leal	-38(%r12), %eax
	cmpl	$8, %eax
	ja	.L642
	leaq	.L644(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L644:
	.long	.L652-.L644
	.long	.L651-.L644
	.long	.L650-.L644
	.long	.L649-.L644
	.long	.L648-.L644
	.long	.L647-.L644
	.long	.L646-.L644
	.long	.L700-.L644
	.long	.L643-.L644
	.text
	.p2align 4,,10
	.p2align 3
.L579:
	testq	%rdx, %rdx
	jne	.L582
	movq	8(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	jne	.L583
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
.L510:
	.cfi_restore_state
	movq	32(%r15), %rdx
	testq	%rdx, %rdx
	jne	.L941
	movl	16(%r15), %r13d
	testl	%r13d, %r13d
	jne	.L942
	movl	12(%r15), %ebp
	testl	%ebp, %ebp
	jne	.L943
	movl	20(%r15), %eax
	cmpl	$2, %eax
	je	.L944
	testq	%r12, %r12
	je	.L520
	movq	%r12, %rdi
	call	get_mangled_name
	movq	8(%rsp), %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movl	20(%r15), %eax
.L520:
	cmpl	$1, %eax
	jne	.L496
.L518:
	movq	8(%rsp), %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC27(%rip), %rdi
	jmp	.L920
	.p2align 4,,10
	.p2align 3
.L933:
	movq	16(%rsp), %rdi
	call	source_function
	movl	%eax, %edx
	testl	%eax, %eax
	jne	.L584
	movq	24(%rsp), %rax
	movl	current_byteptr(%rip), %ebx
	cmpq	%rax, %r12
	sete	%al
	testb	%al, 39(%rsp)
	jne	.L585
	movq	40(%rsp), %rax
	testq	%rax, %rax
	je	.L586
	movl	(%rax,%r12,4), %ecx
	testl	%ecx, %ecx
	jne	.L585
.L586:
	movq	16(%rsp), %rdi
	leaq	.LC75(%rip), %rsi
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	movl	56(%rsp), %edx
	testl	%eax, %eax
	jne	.L589
	testq	%r12, %r12
	je	.L585
.L590:
	movq	16(%rsp), %rdi
	leaq	.LC77(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L591
	cmpq	$1, %r12
	jbe	.L945
.L593:
	movq	16(%rsp), %rdi
	leaq	.LC79(%rip), %rsi
	call	strcmp@PLT
	movl	%eax, 56(%rsp)
	testl	%eax, %eax
	jne	.L596
	cmpq	$2, %r12
	je	.L597
.L592:
	movq	16(%rsp), %rdi
	leaq	.LC81(%rip), %rsi
	call	strcmp@PLT
	testq	%r12, %r12
	movl	%eax, %edx
	sete	%al
	movb	%al, 64(%rsp)
	testl	%edx, %edx
	jne	.L600
	testb	%al, %al
	jne	.L916
.L600:
	movq	16(%rsp), %rdi
	leaq	.LC82(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L604
	cmpq	$1, %r12
	jbe	.L916
.L603:
	leaq	.LC71(%rip), %rcx
	movq	16(%rsp), %rdi
	movq	%rcx, %rsi
	movq	%rcx, 72(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L692
	movb	$0, 64(%rsp)
	leaq	.LC71(%rip), %rcx
.L607:
	movq	16(%rsp), %rdi
	leaq	.LC70(%rip), %rsi
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
	jne	.L606
	movq	16(%rsp), %rdi
	leaq	.LC69(%rip), %rsi
	movq	%rcx, 72(%rsp)
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	movl	56(%rsp), %edx
	movq	72(%rsp), %rcx
	testl	%eax, %eax
	jne	.L720
	cmpb	$0, 64(%rsp)
	je	.L720
.L711:
	movl	%edx, %ebx
.L909:
	testl	%edx, %edx
	jne	.L616
.L615:
	movq	%r13, %rcx
	movl	$32, %edx
	movl	$1, %esi
	leaq	.LC85(%rip), %rdi
	call	fwrite@PLT
	movq	56(%r15), %rax
	movq	%rbp, %rdx
	movq	%r13, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC86(%rip), %rdi
	call	fwrite@PLT
	jmp	.L653
	.p2align 4,,10
	.p2align 3
.L941:
	subq	$1, %rdx
	leaq	.LC58(%rip), %rsi
	jmp	.L919
	.p2align 4,,10
	.p2align 3
.L937:
	movq	8(%rsp), %rbx
	cmpl	$36, %r12d
	leaq	.LC33(%rip), %rax
	leaq	.LC34(%rip), %rdi
	cmove	%rax, %rdi
	movl	$11, %edx
	movl	$1, %esi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	jmp	.L927
	.p2align 4,,10
	.p2align 3
.L522:
	movq	8(%rsp), %rbx
	leaq	.LC60(%rip), %rsi
	movl	expression_id(%rip), %eax
	movq	64(%r15), %r13
	leal	1(%rax), %r12d
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movl	%r12d, %edx
	movl	%r12d, expression_id(%rip)
	call	fprintf@PLT
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L527:
	testq	%r13, %r13
	movl	$1, %ecx
	movq	8(%rsp), %rdi
	movl	%r12d, %edx
	cmovne	%r13, %rcx
	leaq	.LC61(%rip), %rsi
	xorl	%eax, %eax
	xorl	%r14d, %r14d
	leaq	.LC63(%rip), %rbx
	call	fprintf@PLT
	testq	%r13, %r13
	je	.L946
	movl	%r12d, 32(%rsp)
	movq	%r14, %r12
	movq	%rbp, %r14
	movq	8(%rsp), %rbp
	.p2align 4
	.p2align 3
.L531:
	movq	56(%r15), %rax
	movq	%r14, %rdx
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	emit_expr
	cmpq	%r13, %r12
	je	.L533
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbx, %rdi
	call	fwrite@PLT
	jmp	.L531
	.p2align 4,,10
	.p2align 3
.L638:
	leaq	.LC42(%rip), %rdx
	.p2align 4
	.p2align 3
.L639:
	movq	8(%rsp), %rbx
	leaq	.LC94(%rip), %rsi
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
	leaq	.LC63(%rip), %rdi
	call	fwrite@PLT
	movq	64(%r15), %rsi
	jmp	.L921
	.p2align 4,,10
	.p2align 3
.L699:
	leaq	.LC43(%rip), %rdx
	jmp	.L639
	.p2align 4,,10
	.p2align 3
.L637:
	leaq	.LC39(%rip), %rdx
	jmp	.L639
	.p2align 4,,10
	.p2align 3
.L632:
	leaq	.LC44(%rip), %rdx
	jmp	.L639
	.p2align 4,,10
	.p2align 3
.L635:
	leaq	.LC41(%rip), %rdx
	jmp	.L639
	.p2align 4,,10
	.p2align 3
.L636:
	leaq	.LC40(%rip), %rdx
	jmp	.L639
	.p2align 4,,10
	.p2align 3
.L634:
	leaq	.LC45(%rip), %rdx
	jmp	.L639
.L643:
	leaq	.LC47(%rip), %r12
	.p2align 4
	.p2align 3
.L645:
	movq	8(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC98(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC99(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	$3, %edx
	movq	%rbx, %rcx
	movl	$1, %esi
	leaq	.LC100(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	jmp	.L922
.L700:
	leaq	.LC48(%rip), %r12
	jmp	.L645
.L652:
	leaq	.LC46(%rip), %r12
	jmp	.L645
.L650:
	leaq	.LC53(%rip), %r12
	jmp	.L645
.L651:
	leaq	.LC54(%rip), %r12
	jmp	.L645
.L646:
	leaq	.LC49(%rip), %r12
	jmp	.L645
.L647:
	leaq	.LC50(%rip), %r12
	jmp	.L645
.L648:
	leaq	.LC51(%rip), %r12
	jmp	.L645
.L649:
	leaq	.LC52(%rip), %r12
	jmp	.L645
	.p2align 4,,10
	.p2align 3
.L934:
	movq	%r13, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L619
	.p2align 4,,10
	.p2align 3
.L620:
	movl	48(%rsp), %ebx
	movq	8(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	jne	.L581
.L622:
	movq	40(%rsp), %rax
	testq	%rax, %rax
	je	.L496
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
.L555:
	.cfi_restore_state
	testb	%r12b, %r12b
	je	.L579
	leaq	.LC74(%rip), %rsi
	movq	%r14, %rdi
	movq	%rdx, 16(%rsp)
	call	strcmp@PLT
	movq	16(%rsp), %rdx
	testl	%eax, %eax
	jne	.L579
	testq	%rdx, %rdx
	jne	.L582
	movq	8(%rsp), %r14
	movl	$48, %edi
	movq	%r14, %rsi
	call	fputc@PLT
	movq	%r14, %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	je	.L496
.L583:
	movq	$0, 40(%rsp)
	.p2align 4
	.p2align 3
.L581:
	movq	8(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L622
	.p2align 4,,10
	.p2align 3
.L521:
	movq	48(%rax), %r14
	testq	%r14, %r14
	je	.L947
	testl	%ebx, %ebx
	jne	.L522
	movq	%r14, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L528
	movl	g_strict(%rip), %ebx
	testl	%ebx, %ebx
	je	.L529
	leaq	8+names.0(%rip), %r12
	leaq	.LC3(%rip), %rsi
	jmp	.L530
	.p2align 4,,10
	.p2align 3
.L948:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L528
.L530:
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L948
.L529:
	leaq	.LC66(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L678
	.p2align 4
	.p2align 3
.L535:
	leaq	8+names.0(%rip), %r12
	leaq	.LC3(%rip), %rsi
	jmp	.L540
	.p2align 4,,10
	.p2align 3
.L950:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L949
.L540:
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L950
	movq	%r14, %rdi
	movl	g_strict(%rip), %r12d
	call	source_function
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L951
	testl	%r12d, %r12d
	je	.L666
	movb	$0, 39(%rsp)
	movq	%r14, %rsi
	movq	$0, 24(%rsp)
.L660:
	movq	8(%rsp), %rdi
	movq	%rsi, %rdx
	xorl	%eax, %eax
	movl	$1, %r12d
	leaq	.LC15(%rip), %rsi
	call	fprintf@PLT
	movb	$1, 32(%rsp)
	jmp	.L554
	.p2align 4,,10
	.p2align 3
.L585:
	testl	%ebx, %ebx
	je	.L587
.L588:
	movq	%r13, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC83(%rip), %rdi
	call	fwrite@PLT
.L618:
	movl	$1, %ebx
	jmp	.L584
	.p2align 4,,10
	.p2align 3
.L940:
	leaq	CSWTCH.181(%rip), %rdx
	movq	8(%rsp), %rbx
	leaq	.LC95(%rip), %rsi
	movl	(%rdx,%rax,4), %r15d
	movl	expression_id(%rip), %eax
	movq	%rbx, %rdi
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
	leaq	.LC96(%rip), %rsi
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
	.cfi_def_cfa_offset 48
	leaq	.LC97(%rip), %rsi
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
.L938:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC89(%rip), %rdi
	jmp	.L924
.L949:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L952
.L674:
	leaq	.LC68(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	je	.L542
.L717:
	movq	$0, 24(%rsp)
	movb	$0, 39(%rsp)
.L543:
	movb	$1, 32(%rsp)
	movq	%r14, %rsi
	xorl	%r12d, %r12d
	xorl	%ebx, %ebx
	jmp	.L547
	.p2align 4,,10
	.p2align 3
.L533:
	movl	32(%rsp), %r12d
	subq	$8, %rsp
	.cfi_def_cfa_offset 152
	movq	%r13, %r8
	xorl	%eax, %eax
	leaq	.LC62(%rip), %rsi
	xorl	%ebp, %ebp
	leaq	.LC64(%rip), %r14
	pushq	%r12
	.cfi_def_cfa_offset 160
	movq	24(%rsp), %rbx
	movl	%r12d, %r9d
	movl	%r12d, %ecx
	movl	%r12d, %edx
	leaq	.LC63(%rip), %r15
	movq	%rbx, %rdi
	call	fprintf@PLT
	popq	%r8
	.cfi_def_cfa_offset 152
	popq	%r9
	.cfi_def_cfa_offset 144
	jmp	.L534
	.p2align 4,,10
	.p2align 3
.L953:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
.L534:
	movq	%rbp, %rcx
	movl	%r12d, %edx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	addq	$1, %rbp
	call	fprintf@PLT
	cmpq	%r13, %rbp
	jne	.L953
.L532:
	movq	8(%rsp), %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC65(%rip), %rdi
	jmp	.L920
	.p2align 4,,10
	.p2align 3
.L641:
	movq	8(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	leaq	.LC101(%rip), %rdx
.L929:
	leaq	.LC93(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	jmp	.L922
	.p2align 4,,10
	.p2align 3
.L939:
	movl	expression_id(%rip), %eax
	movq	8(%rsp), %rbx
	leaq	.LC90(%rip), %rsi
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
	leaq	.LC91(%rip), %rsi
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
	leaq	.LC92(%rip), %rsi
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
.L942:
	.cfi_restore_state
	movq	8(%rsp), %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC25(%rip), %rdi
	jmp	.L920
.L589:
	movq	16(%rsp), %rdi
	leaq	.LC76(%rip), %rsi
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L590
	testq	%r12, %r12
	jne	.L590
	testl	%ebx, %ebx
	movl	56(%rsp), %edx
	jne	.L588
	.p2align 4
	.p2align 3
.L587:
	movq	16(%rsp), %rdi
	leaq	.LC69(%rip), %rsi
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	testq	%r12, %r12
	movl	56(%rsp), %edx
	jne	.L719
	testl	%eax, %eax
	je	.L911
.L719:
	movl	$1, %ebx
	leaq	.LC71(%rip), %rcx
.L656:
	movq	16(%rsp), %rdi
	movq	%rcx, %rsi
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	movl	56(%rsp), %edx
	testl	%eax, %eax
	jne	.L610
	cmpq	$1, %r12
	je	.L954
.L612:
	testl	%ebx, %ebx
	jne	.L588
.L606:
	xorl	%ebx, %ebx
	testl	%edx, %edx
	je	.L584
.L602:
	movq	%r13, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC84(%rip), %rdi
	call	fwrite@PLT
	jmp	.L618
.L935:
	movq	8(%rsp), %rbx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC88(%rip), %rdi
	movq	%rbx, %rcx
	jmp	.L924
.L631:
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
	leaq	.LC93(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	64(%r15), %rsi
	jmp	.L921
.L936:
	movq	8(%rsp), %rbx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC23(%rip), %rdi
	movq	%rbx, %rcx
	jmp	.L924
.L947:
	testl	%ebx, %ebx
	jne	.L522
	xorl	%edi, %edi
	leaq	.LC66(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L535
	xorl	%edi, %edi
	call	source_function
	testl	%eax, %eax
	jne	.L535
.L678:
	movq	64(%r15), %r14
	testq	%r14, %r14
	jne	.L536
	movq	8(%rsp), %rdi
	xorl	%edx, %edx
	leaq	.LC67(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
.L537:
	movq	8(%rsp), %rsi
	jmp	.L926
.L528:
	movq	8(%rsp), %rbx
	leaq	.LC60(%rip), %rsi
	movl	expression_id(%rip), %eax
	movq	64(%r15), %r13
	leal	1(%rax), %r12d
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movl	%r12d, %edx
	movl	%r12d, expression_id(%rip)
	call	fprintf@PLT
	movq	%r14, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC27(%rip), %rdi
	call	fwrite@PLT
	jmp	.L527
.L943:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L955
	movq	8(%rsp), %rbx
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC59(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	48(%r15), %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	jmp	.L923
.L946:
	movq	8(%rsp), %rbx
	movl	$48, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 152
	movl	%r12d, %r9d
	xorl	%r8d, %r8d
	pushq	%r12
	.cfi_def_cfa_offset 160
	movl	%r12d, %ecx
	movl	%r12d, %edx
	leaq	.LC62(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	popq	%r10
	.cfi_def_cfa_offset 152
	popq	%r11
	.cfi_def_cfa_offset 144
	jmp	.L532
.L591:
	movq	16(%rsp), %rdi
	leaq	.LC78(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L593
	cmpq	$1, %r12
	jne	.L593
	movq	16(%rsp), %rdi
	leaq	.LC82(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L907
	testl	%ebx, %ebx
	jne	.L602
	leaq	.LC71(%rip), %rcx
	movq	16(%rsp), %rdi
	movq	%rcx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L710
	xorl	%ebx, %ebx
	movl	$1, %edx
.L610:
	movq	16(%rsp), %rdi
	leaq	.LC70(%rip), %rsi
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	cmpq	$1, %r12
	movl	56(%rsp), %edx
	jne	.L612
	testl	%eax, %eax
	jne	.L612
	testl	%ebx, %ebx
	jne	.L911
	xorl	%ebx, %ebx
	jmp	.L909
.L642:
	movq	8(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edi
	call	tk_name@PLT
	movq	%rax, %rdx
	jmp	.L929
.L952:
	movq	%r14, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L717
	leaq	.LC69(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	leaq	.LC68(%rip), %rsi
	movq	%r14, %rdi
	movl	%eax, %ebx
	call	strcmp@PLT
	movl	%eax, %r12d
	testl	%ebx, %ebx
	je	.L545
	leaq	.LC70(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	je	.L545
	xorl	%ebx, %ebx
.L673:
	leaq	.LC71(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L545
	testl	%r12d, %r12d
	je	.L956
	leaq	.LC106(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L713
	leaq	.LC107(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L713
	leaq	.LC105(%rip), %rsi
	movq	%r14, %rdi
	xorl	%r12d, %r12d
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L662
.L713:
	movb	$1, 39(%rsp)
	movq	$1, 24(%rsp)
.L553:
	testl	%ebx, %ebx
	je	.L543
	movq	%r14, %rsi
	xorl	%ebx, %ebx
	jmp	.L660
	.p2align 4,,10
	.p2align 3
.L542:
	movq	%r14, %rdi
	xorl	%r12d, %r12d
	call	source_function
	movb	$1, 32(%rsp)
	movq	%r14, %rsi
	movq	$0, 24(%rsp)
	xorl	$1, %eax
	andl	$1, %eax
	movb	%al, 39(%rsp)
	jmp	.L547
.L932:
	movq	%rdx, %rdi
	movl	$4, %esi
	movq	%rdx, 16(%rsp)
	movq	48(%rax), %r12
	call	calloc@PLT
	movq	16(%rsp), %rdx
	testq	%rax, %rax
	movq	%rax, 40(%rsp)
	je	.L582
	movq	24(%rsp), %rax
	xorl	%r13d, %r13d
	leaq	1(%rax), %rsi
	movzbl	(%r12), %eax
	testb	%al, %al
	je	.L558
	movq	%r14, 48(%rsp)
	movl	%ebx, 16(%rsp)
	movq	%rsi, %rbx
	movq	%rbp, 56(%rsp)
	movq	%r12, %rbp
	movq	%rdx, %r12
	.p2align 4
	.p2align 3
.L557:
	cmpb	$37, %al
	jne	.L903
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	cmpb	$37, %r14b
	je	.L903
	testb	%r14b, %r14b
	jne	.L560
	jmp	.L901
	.p2align 4,,10
	.p2align 3
.L563:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	testb	%r14b, %r14b
	je	.L562
.L560:
	movsbl	%r14b, %esi
	leaq	.LC73(%rip), %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L563
	cmpb	$42, %r14b
	jne	.L562
	cmpq	%r12, %rbx
	adcq	$0, %rbx
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %edx
.L567:
	cmpb	$46, %dl
	je	.L957
.L569:
	cmpb	$104, %dl
	je	.L958
	cmpb	$108, %dl
	je	.L959
	testb	%dl, %dl
	je	.L901
	leaq	1(%r13), %rax
	cmpq	%r12, %rbx
	jnb	.L575
	cmpb	$115, %dl
	jne	.L575
	movq	40(%rsp), %rcx
	movl	$1, (%rcx,%rbx,4)
	.p2align 4
	.p2align 3
.L575:
	addq	$1, %rbx
.L559:
	movq	%rax, %r13
	movzbl	0(%rbp,%rax), %eax
	testb	%al, %al
	jne	.L557
.L901:
	movl	16(%rsp), %ebx
	movq	48(%rsp), %r14
	movq	%r12, %rdx
	movq	56(%rsp), %rbp
	jmp	.L558
	.p2align 4,,10
	.p2align 3
.L903:
	leaq	1(%r13), %rax
	jmp	.L559
.L562:
	movzbl	0(%rbp,%r13), %edx
	testb	%dl, %dl
	movb	%dl, 64(%rsp)
	je	.L901
	call	__ctype_b_loc@PLT
	movzbl	64(%rsp), %edx
	movq	(%rax), %rax
	jmp	.L565
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L568:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %edx
	testb	%dl, %dl
	je	.L901
.L565:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L568
	movzbl	0(%rbp,%r13), %edx
	jmp	.L567
.L957:
	movzbl	1(%rbp,%r13), %edx
	leaq	1(%r13), %rdi
	movq	%rdi, 64(%rsp)
	cmpb	$42, %dl
	jne	.L960
	cmpq	%r12, %rbx
	adcq	$0, %rbx
	addq	$2, %r13
	movzbl	0(%rbp,%r13), %edx
	jmp	.L569
.L958:
	cmpb	$104, 1(%rbp,%r13)
	leaq	1(%r13), %rax
	jne	.L575
.L686:
	leaq	2(%r13), %rax
	jmp	.L575
.L959:
	cmpb	$108, 1(%rbp,%r13)
	leaq	1(%r13), %rax
	jne	.L575
	jmp	.L686
.L951:
	testl	%r12d, %r12d
	jne	.L674
	jmp	.L717
.L944:
	movq	%r12, %rdi
	call	get_mangled_name
	leaq	.LC26(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L919
.L955:
	testq	%r12, %r12
	je	.L518
	movq	%r12, %rdi
	call	get_mangled_name
	movq	8(%rsp), %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	jmp	.L518
.L960:
	testb	%dl, %dl
	movb	%dl, 72(%rsp)
	je	.L901
	call	__ctype_b_loc@PLT
	movzbl	72(%rsp), %edx
	movq	64(%rsp), %rdi
	movq	(%rax), %rax
	jmp	.L571
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L573:
	addq	$1, %rdi
	movzbl	0(%rbp,%rdi), %edx
	testb	%dl, %dl
	je	.L901
.L571:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L573
	movzbl	0(%rbp,%rdi), %edx
	movq	%rdi, %r13
	jmp	.L569
.L662:
	leaq	.LC104(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L703
	movb	$1, 39(%rsp)
	movq	$2, 24(%rsp)
.L661:
	testl	%r12d, %r12d
	je	.L553
.L663:
	movq	8(%rsp), %rcx
	movl	$1, %esi
	movl	$6, %edx
	leaq	.LC72(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rax
	movq	48(%rax), %rsi
	testl	%ebx, %ebx
	je	.L682
	cmpl	$2, (%rax)
	je	.L660
	movb	$1, 32(%rsp)
	movl	$1, %r12d
	jmp	.L547
.L545:
	testl	%r12d, %r12d
	je	.L961
.L886:
	leaq	.LC106(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L714
	leaq	.LC107(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L714
	leaq	.LC105(%rip), %rsi
	movq	%r14, %rdi
	movl	$1, %r12d
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L662
.L714:
	movb	$1, 39(%rsp)
	movq	$1, 24(%rsp)
	jmp	.L663
.L907:
	movb	$0, 64(%rsp)
	movl	$1, 56(%rsp)
.L604:
	leaq	.LC71(%rip), %rcx
	movq	16(%rsp), %rdi
	movq	%rcx, %rsi
	movq	%rcx, 72(%rsp)
	call	strcmp@PLT
	leaq	.LC71(%rip), %rcx
	testl	%eax, %eax
	jne	.L607
	movzbl	64(%rsp), %edx
	movl	56(%rsp), %eax
	orl	%eax, %edx
	testl	%ebx, %ebx
	jne	.L606
	movq	16(%rsp), %rdi
	leaq	.LC69(%rip), %rsi
	movl	%edx, 56(%rsp)
	call	strcmp@PLT
	movl	56(%rsp), %edx
	testl	%eax, %eax
	jne	.L669
	cmpb	$0, 64(%rsp)
	movl	%edx, %ebx
	jne	.L909
.L669:
	cmpq	$1, %r12
	jne	.L606
	jmp	.L711
	.p2align 4,,10
	.p2align 3
.L596:
	movq	16(%rsp), %rdi
	leaq	.LC80(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L718
	cmpq	$2, %r12
	je	.L597
.L718:
	movl	$0, 56(%rsp)
	jmp	.L592
.L954:
	testl	%ebx, %ebx
	je	.L711
.L911:
	movq	%r13, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC83(%rip), %rdi
	call	fwrite@PLT
.L614:
	movl	$1, %ebx
	jmp	.L615
.L916:
	testl	%ebx, %ebx
	jne	.L602
	movq	16(%rsp), %rdi
	leaq	.LC69(%rip), %rsi
	call	strcmp@PLT
	testb	$1, %r12b
	jne	.L721
	testl	%eax, %eax
	je	.L616
.L721:
	xorl	%ebx, %ebx
	movl	$1, %edx
	leaq	.LC71(%rip), %rcx
	jmp	.L656
.L536:
	movq	8(%rsp), %rbx
	leaq	-1(%r14), %rdx
	xorl	%eax, %eax
	xorl	%r12d, %r12d
	leaq	.LC67(%rip), %rsi
	leaq	.LC63(%rip), %r13
	movq	%rbx, %rdi
	call	fprintf@PLT
.L538:
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
	jne	.L538
	jmp	.L537
.L961:
	movq	8(%rsp), %rcx
	movl	$1, %esi
	movl	$6, %edx
	leaq	.LC72(%rip), %rdi
	xorl	%r12d, %r12d
	movl	$1, %ebx
	call	fwrite@PLT
	movq	48(%r15), %rax
	movb	$1, 32(%rsp)
	movb	$1, 39(%rsp)
	movq	$0, 24(%rsp)
	movq	48(%rax), %rsi
	jmp	.L547
.L703:
	movb	$0, 39(%rsp)
	movq	$0, 24(%rsp)
	jmp	.L661
.L666:
	leaq	.LC69(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L715
	leaq	.LC70(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L715
	leaq	.LC68(%rip), %rsi
	movq	%r14, %rdi
	movl	$1, %ebx
	call	strcmp@PLT
	orl	$1, %eax
	movl	%eax, %r12d
	jmp	.L673
.L616:
	movq	%r13, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC84(%rip), %rdi
	call	fwrite@PLT
	jmp	.L614
.L597:
	movq	16(%rsp), %rdi
	leaq	.LC82(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L907
	movl	$1, 56(%rsp)
	jmp	.L603
.L715:
	movl	$1, %ebx
	jmp	.L886
.L692:
	movl	56(%rsp), %edx
	jmp	.L606
.L945:
	movl	$1, 56(%rsp)
	jmp	.L592
.L710:
	movl	$1, %edx
	jmp	.L711
.L956:
	xorl	%edi, %edi
	movb	$1, 32(%rsp)
	movq	%r14, %rsi
	xorl	%ebx, %ebx
	movb	$1, 39(%rsp)
	xorl	%r12d, %r12d
	movq	%rdi, 24(%rsp)
	jmp	.L547
.L720:
	xorl	%ebx, %ebx
	jmp	.L656
.L682:
	movb	$1, 32(%rsp)
	xorl	%r12d, %r12d
	movl	$1, %ebx
	jmp	.L547
	.cfi_endproc
.LFE48:
	.size	emit_expr, .-emit_expr
	.section	.rodata.str1.1
.LC108:
	.string	"word __%s_store[("
.LC109:
	.string	")];\n"
.LC110:
	.string	"word %s = 0;\n"
	.section	.rodata.str1.8
	.align 8
.LC111:
	.string	"(void)B_LOCAL_PTR_N(&%s, sizeof(%s));\n"
	.text
	.p2align 4
	.type	emit_auto_storage, @function
emit_auto_storage:
.LFB57:
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
	je	.L963
	testl	%r13d, %r13d
	jle	.L964
	xorl	%r12d, %r12d
	leaq	.LC28(%rip), %r14
	.p2align 4
	.p2align 3
.L965:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r13d
	jne	.L965
.L964:
	movq	%r15, %rdx
	leaq	.LC108(%rip), %rsi
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
	leaq	.LC109(%rip), %rdi
	call	fwrite@PLT
.L963:
	testl	%r13d, %r13d
	jle	.L966
	xorl	%ebx, %ebx
	leaq	.LC28(%rip), %r14
	.p2align 4
	.p2align 3
.L967:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %r12d
	leal	1(%rbx), %ebx
	cmpl	%ebx, %r13d
	jne	.L967
	xorl	%eax, %eax
	movq	%r15, %rdx
	leaq	.LC110(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L978
.L962:
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
.L978:
	.cfi_restore_state
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L972:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %r12d
	jne	.L972
.L969:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r15, %rcx
	movq	%r15, %rdx
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC111(%rip), %rsi
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
.L966:
	.cfi_restore_state
	xorl	%eax, %eax
	movq	%r15, %rdx
	leaq	.LC110(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L962
	jmp	.L969
	.cfi_endproc
.LFE57:
	.size	emit_auto_storage, .-emit_auto_storage
	.p2align 4
	.globl	emit_ival_expr
	.type	emit_ival_expr, @function
emit_ival_expr:
.LFB49:
	.cfi_startproc
	cmpl	$2, (%rsi)
	je	.L981
	jmp	emit_expr
	.p2align 4,,10
	.p2align 3
.L981:
	jmp	emit_ival_expr.part.0
	.cfi_endproc
.LFE49:
	.size	emit_ival_expr, .-emit_ival_expr
	.p2align 4
	.globl	init_list_length
	.type	init_list_length, @function
init_list_length:
.LFB50:
	.cfi_startproc
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L982
	cmpl	$1, (%rdi)
	je	.L986
.L982:
	ret
	.p2align 4,,10
	.p2align 3
.L986:
	movq	24(%rdi), %rax
	ret
	.cfi_endproc
.LFE50:
	.size	init_list_length, .-init_list_length
	.p2align 4
	.globl	try_eval_const_expr
	.type	try_eval_const_expr, @function
try_eval_const_expr:
.LFB51:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L1023
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
	je	.L989
	ja	.L990
	testl	%eax, %eax
	je	.L991
	cmpl	$5, %eax
	jne	.L999
	movq	56(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L987
	movl	48(%rbx), %eax
	cmpl	$31, %eax
	je	.L995
	cmpl	$35, %eax
	je	.L996
	.p2align 4
	.p2align 3
.L999:
	xorl	%eax, %eax
.L987:
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
.L990:
	.cfi_restore_state
	cmpl	$10, %eax
	jne	.L999
	movq	48(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L987
	movq	56(%rbx), %rdi
	movq	%rbp, %rsi
	call	try_eval_const_expr
	jmp	.L987
	.p2align 4,,10
	.p2align 3
.L1023:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L991:
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
.L989:
	.cfi_restore_state
	movq	56(%rdi), %rdi
	movq	%rsp, %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L999
	movq	64(%rbx), %rdi
	leaq	8(%rsp), %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L999
	movl	48(%rbx), %eax
	subl	$22, %eax
	cmpl	$33, %eax
	ja	.L999
	leaq	.L1002(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1002:
	.long	.L1015-.L1002
	.long	.L1014-.L1002
	.long	.L1013-.L1002
	.long	.L1012-.L1002
	.long	.L1011-.L1002
	.long	.L1010-.L1002
	.long	.L999-.L1002
	.long	.L999-.L1002
	.long	.L1009-.L1002
	.long	.L1008-.L1002
	.long	.L1007-.L1002
	.long	.L1006-.L1002
	.long	.L1005-.L1002
	.long	.L999-.L1002
	.long	.L999-.L1002
	.long	.L999-.L1002
	.long	.L999-.L1002
	.long	.L999-.L1002
	.long	.L999-.L1002
	.long	.L999-.L1002
	.long	.L999-.L1002
	.long	.L999-.L1002
	.long	.L999-.L1002
	.long	.L999-.L1002
	.long	.L999-.L1002
	.long	.L999-.L1002
	.long	.L999-.L1002
	.long	.L999-.L1002
	.long	.L999-.L1002
	.long	.L999-.L1002
	.long	.L999-.L1002
	.long	.L1004-.L1002
	.long	.L1003-.L1002
	.long	.L1001-.L1002
	.text
	.p2align 4,,10
	.p2align 3
.L996:
	xorl	%eax, %eax
	cmpq	$0, 8(%rsp)
	sete	%al
	movq	%rax, 0(%rbp)
.L1017:
	movl	$1, %eax
	jmp	.L987
.L1001:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1017
.L1003:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1017
.L1004:
	movq	(%rsp), %rax
	andq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1017
.L1005:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L999
	movq	(%rsp), %rax
	cmpq	$-1, %rcx
	jne	.L1027
	movabsq	$-9223372036854775808, %rdx
	cmpq	%rdx, %rax
	je	.L1025
.L1027:
	cqto
	idivq	%rcx
.L1020:
	movq	%rdx, 0(%rbp)
	jmp	.L1017
.L1006:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L999
	movq	(%rsp), %rdx
	cmpq	$-1, %rcx
	jne	.L1026
	movabsq	$-9223372036854775808, %rax
	cmpq	%rax, %rdx
	je	.L1048
.L1026:
	movq	%rdx, %rax
	cqto
	idivq	%rcx
.L1048:
	movq	%rax, 0(%rbp)
	jmp	.L1017
.L1007:
	movq	(%rsp), %rax
	imulq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1017
.L1008:
	movq	(%rsp), %rax
	subq	8(%rsp), %rax
	jmp	.L1048
.L1009:
	movq	8(%rsp), %rax
	addq	(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1017
.L1010:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setge	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1017
.L1011:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setg	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1017
.L1012:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setle	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1017
.L1013:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setl	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1017
.L1014:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1017
.L1015:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	sete	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1017
	.p2align 4,,10
	.p2align 3
.L995:
	movq	8(%rsp), %rax
	negq	%rax
	movq	%rax, 0(%rbp)
	jmp	.L1017
.L1025:
	xorl	%edx, %edx
	jmp	.L1020
	.cfi_endproc
.LFE51:
	.size	try_eval_const_expr, .-try_eval_const_expr
	.p2align 4
	.globl	nested_base_len
	.type	nested_base_len, @function
nested_base_len:
.LFB52:
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
.LFE52:
	.size	nested_base_len, .-nested_base_len
	.p2align 4
	.globl	edge_words_total
	.type	edge_words_total, @function
edge_words_total:
.LFB53:
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
.LFE53:
	.size	edge_words_total, .-edge_words_total
	.p2align 4
	.globl	edge_tail_words_top
	.type	edge_tail_words_top, @function
edge_tail_words_top:
.LFB54:
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
.LFE54:
	.size	edge_tail_words_top, .-edge_tail_words_top
	.section	.rodata.str1.1
.LC112:
	.string	"%s[%zu] = "
.LC113:
	.string	";\n"
.LC114:
	.string	"%s[%zu] = B_ADDR(%s[%zu]);\n"
	.text
	.p2align 4
	.globl	emit_edge_list_init
	.type	emit_edge_list_init, @function
emit_edge_list_init:
.LFB55:
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
	leaq	.LC28(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1086
	movq	16(%rsp), %r12
	movq	%r14, %r10
.L1089:
	movq	(%rsp), %rdx
	leaq	.LC112(%rip), %rsi
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
	leaq	.LC113(%rip), %rdi
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
	leaq	.LC28(%rip), %rdi
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
	leaq	.LC114(%rip), %rsi
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
.LFE55:
	.size	emit_edge_list_init, .-emit_edge_list_init
	.section	.rodata.str1.8
	.align 8
.LC115:
	.string	"static void __attribute__((constructor(101))) __b_register_globals(void) {\n"
	.align 8
.LC116:
	.string	"    (void)B_PTR_N(%s, sizeof(%s));\n"
	.align 8
.LC117:
	.string	"    (void)B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC118:
	.string	"}\n"
	.section	.rodata.str1.8
	.align 8
.LC119:
	.string	"static void __attribute__((constructor(102))) __bcc_bind_functions(void) {\n"
	.section	.rodata.str1.1
.LC120:
	.string	"    "
.LC121:
	.string	" = B_FUNCTION("
	.section	.rodata.str1.8
	.align 8
.LC122:
	.string	"    static struct __bcc_source_function __bcc_function_%zu = {(void*)"
	.align 8
.LC123:
	.string	", 0, 0};\n    __bcc_register_function(&__bcc_function_%zu);\n"
	.align 8
.LC124:
	.string	"static void __b_initialize_globals(void) {\n"
	.align 8
.LC125:
	.string	"    %s[0] = B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC126:
	.string	"__%s_store"
.LC127:
	.string	"    %s[0] = "
	.section	.rodata.str1.8
	.align 8
.LC128:
	.string	"}\nstatic struct __bcc_initializer __bcc_module = {__b_initialize_globals, 0, 0};\nstatic void __attribute__((constructor(102))) __bcc_register_module(void) {\n    __bcc_register_initializer(&__bcc_module);\n}\n\n"
	.text
	.p2align 4
	.type	emit_global_initializers, @function
emit_global_initializers:
.LFB64:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.LC118(%rip), %rax
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
	je	.L1163
.L1119:
	movq	%rbx, %rcx
	movl	$75, %edx
	movl	$1, %esi
	leaq	.LC119(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%r15)
	je	.L1126
	xorl	%ebp, %ebp
	leaq	.LC120(%rip), %r14
	leaq	.LC27(%rip), %r13
	jmp	.L1129
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1127:
	addq	$1, %rbp
	cmpq	8(%r15), %rbp
	jnb	.L1126
.L1129:
	movq	(%r15), %rax
	movq	(%rax,%rbp,8), %r12
	cmpl	$1, (%r12)
	jne	.L1127
	movq	%r14, %rdi
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r12), %rax
	movq	(%rax), %rdi
	testq	%rdi, %rdi
	je	.L1128
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1128:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$14, %edx
	movl	$1, %esi
	leaq	.LC121(%rip), %rdi
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
	leaq	.LC122(%rip), %rsi
	call	fprintf@PLT
	movq	8(%r12), %rax
	movq	%rbx, %rdi
	movq	(%rax), %rsi
	call	emit_function_body_name
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC123(%rip), %rsi
	addq	$1, %rbp
	call	fprintf@PLT
	cmpq	8(%r15), %rbp
	jb	.L1129
.L1126:
	movq	(%rsp), %rdi
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC124(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%r15)
	je	.L1130
	xorl	%ebp, %ebp
	jmp	.L1141
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1132:
	addq	$1, %rbp
	cmpq	8(%r15), %rbp
	jnb	.L1130
.L1141:
	movq	(%r15), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$2, (%rax)
	jne	.L1132
	movq	8(%rax), %r12
	movq	16(%r12), %rdi
	call	get_mangled_name
	cmpl	$2, 24(%r12)
	movq	56(%r12), %r13
	movq	%rax, %r14
	je	.L1164
	testq	%r13, %r13
	je	.L1132
	movl	0(%r13), %eax
	cmpl	$1, %eax
	je	.L1165
	testl	%eax, %eax
	jne	.L1132
	leaq	.LC127(%rip), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	fprintf@PLT
	movq	16(%r13), %rsi
	cmpl	$2, (%rsi)
	je	.L1166
	movq	8(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L1140:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addq	$1, %rbp
	leaq	.LC113(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r15), %rbp
	jb	.L1141
.L1130:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$207, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC128(%rip), %rdi
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
.L1164:
	.cfi_restore_state
	movq	%rax, %r8
	movq	%rax, %rcx
	movq	%rax, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC125(%rip), %rsi
	call	fprintf@PLT
	testq	%r13, %r13
	je	.L1132
	cmpl	$1, 0(%r13)
	jne	.L1132
	movq	%r14, %rsi
	leaq	.LC126(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	xorl	%r8d, %r8d
	movq	%rax, %rsi
	movq	56(%r12), %rax
	testq	%rax, %rax
	je	.L1135
	cmpl	$1, (%rax)
	je	.L1167
.L1135:
	cmpq	$0, 32(%r12)
	je	.L1136
	movq	48(%r12), %rax
	movq	%r8, %rdx
	cmpq	%rax, %r8
	cmovb	%rax, %r8
	testq	%rax, %rax
	cmovle	%rdx, %r8
.L1136:
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
	jmp	.L1132
	.p2align 4,,10
	.p2align 3
.L1165:
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
	jmp	.L1132
	.p2align 4,,10
	.p2align 3
.L1163:
	movq	%rdi, %rcx
	movl	$75, %edx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%r15)
	je	.L1120
	xorl	%ebp, %ebp
	leaq	.LC116(%rip), %r12
	jmp	.L1125
	.p2align 4,,10
	.p2align 3
.L1122:
	addq	$1, %rbp
	cmpq	8(%r15), %rbp
	jnb	.L1120
.L1125:
	movq	(%r15), %rax
	movq	(%rax,%rbp,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L1168
	cmpl	$2, %eax
	jne	.L1122
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
	jne	.L1122
	movq	%r13, %rcx
	movq	%r13, %rdx
	leaq	.LC117(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	addq	$1, %rbp
	call	fprintf@PLT
	cmpq	8(%r15), %rbp
	jb	.L1125
	.p2align 4
	.p2align 3
.L1120:
	leaq	.LC118(%rip), %rax
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, (%rsp)
	call	fwrite@PLT
	jmp	.L1119
	.p2align 4,,10
	.p2align 3
.L1168:
	movq	8(%rdx), %rax
	movq	(%rax), %rdi
	call	get_mangled_name
	movq	%r12, %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1122
.L1166:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1140
.L1167:
	movq	24(%rax), %r8
	jmp	.L1135
	.cfi_endproc
.LFE64:
	.size	emit_global_initializers, .-emit_global_initializers
	.section	.rodata.str1.1
.LC129:
	.string	"<"
.LC130:
	.string	"<="
.LC131:
	.string	">"
.LC132:
	.string	">="
.LC133:
	.string	"??"
.LC134:
	.string	"while ("
.LC135:
	.string	")\n"
.LC136:
	.string	"if ("
.LC137:
	.string	"switch ("
.LC138:
	.string	") {\n"
.LC139:
	.string	"continue;\n"
.LC140:
	.string	"break;\n"
.LC141:
	.string	"return"
.LC142:
	.string	"{\n"
.LC143:
	.string	"return "
	.section	.rodata.str1.8
	.align 8
.LC144:
	.string	"%s = B_LOCAL_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC145:
	.string	"else\n"
.LC146:
	.string	" 0"
	.section	.rodata.str1.8
	.align 8
.LC147:
	.string	"case %zu: goto __b_label_%zu;\n"
	.align 8
.LC148:
	.string	"default: fputs(\"bcc: invalid label value\\n\", stderr); abort();\n"
	.section	.rodata.str1.1
.LC149:
	.string	"__bsw%d_case%zu"
.LC150:
	.string	"for(;;) {\n"
.LC151:
	.string	"word __sw = "
.LC152:
	.string	"__bsw%d_end"
.LC153:
	.string	"goto __bsw%d_dispatch;\n"
.LC154:
	.string	"goto __bsw%d_end;\n"
.LC155:
	.string	"__sw %s (word)%ld"
	.section	.rodata.str1.8
	.align 8
.LC156:
	.string	"(__sw >= (word)%ld && __sw <= (word)%ld)"
	.section	.rodata.str1.1
.LC157:
	.string	"__sw == (word)%ld"
.LC158:
	.string	") goto "
.LC159:
	.string	"__bsw%d_end:\n"
.LC160:
	.string	"__b_label_%d:\n"
.LC161:
	.string	"__bsw%d_dispatch:\n"
	.text
	.p2align 4
	.globl	emit_stmt
	.type	emit_stmt, @function
emit_stmt:
.LFB58:
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
.L1170:
	movl	g_no_line(%rip), %r10d
	testl	%r10d, %r10d
	jne	.L1171
	cmpb	$0, 24(%rsp)
	jne	.L1455
.L1171:
	cmpl	$12, (%rbx)
	ja	.L1169
	movl	(%rbx), %eax
	leaq	.L1174(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1174:
	.long	.L1185-.L1174
	.long	.L1184-.L1174
	.long	.L1183-.L1174
	.long	.L1182-.L1174
	.long	.L1181-.L1174
	.long	.L1180-.L1174
	.long	.L1179-.L1174
	.long	.L1169-.L1174
	.long	.L1178-.L1174
	.long	.L1177-.L1174
	.long	.L1176-.L1174
	.long	.L1175-.L1174
	.long	.L1173-.L1174
	.text
	.p2align 4,,10
	.p2align 3
.L1455:
	movl	4(%rbx), %edx
	movq	16(%rsp), %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC29(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1171
	.p2align 4,,10
	.p2align 3
.L1173:
	movl	g_switch_id(%rip), %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	leaq	.LC149(%rip), %r12
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
	je	.L1255
	movq	%rbx, 56(%rsp)
	movq	24(%rsp), %r13
	movq	%r14, 48(%rsp)
	movq	%rbp, %r14
	movq	40(%rsp), %rbp
	.p2align 4
	.p2align 3
.L1252:
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
	jb	.L1252
	movq	48(%rsp), %r14
	movq	56(%rsp), %rbx
.L1255:
	movl	8(%rsp), %edx
	movl	8(%rsp), %r12d
	xorl	%ebp, %ebp
	leaq	.LC28(%rip), %r13
	testl	%edx, %edx
	jle	.L1456
	.p2align 4
	.p2align 3
.L1253:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1253
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC150(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r12d
.L1256:
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 48(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1259:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1259
	movq	48(%rsp), %rbx
	movq	%r14, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC151(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	leaq	.LC113(%rip), %rax
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ecx
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC152(%rip), %rdx
	movl	$64, %esi
	call	snprintf@PLT
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 56(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1260:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1260
	movl	32(%rsp), %edx
	leaq	.LC153(%rip), %rsi
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
.L1261:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1261
	leaq	.LC154(%rip), %rax
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
.L1262:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1262
	movl	32(%rsp), %edx
	xorl	%eax, %eax
	leaq	.LC161(%rip), %rsi
	movq	%r14, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r15)
	leal	2(%rax), %ebx
	je	.L1264
.L1301:
	leaq	.LC136(%rip), %rax
	movq	%r15, 16(%rsp)
	xorl	%edi, %edi
	leaq	.LC28(%rip), %rbp
	movq	%rax, 56(%rsp)
	movl	%r12d, 76(%rsp)
	movq	%rdi, %r12
	.p2align 4
	.p2align 3
.L1278:
	movq	16(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r12,8), %r13
	movq	40(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1327
	xorl	%eax, %eax
	jmp	.L1269
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1268:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1327
.L1269:
	movq	(%rsi,%rax,8), %rdx
	cmpq	(%rdx), %r13
	jne	.L1268
	movq	8(%rdx), %rax
	movq	%rax, 24(%rsp)
.L1267:
	xorl	%r15d, %r15d
	testl	%ebx, %ebx
	jle	.L1273
	.p2align 4
	.p2align 3
.L1270:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebx, %r15d
	jne	.L1270
.L1273:
	movq	56(%rsp), %rdi
	movl	$1, %esi
	movq	%r14, %rcx
	movl	$4, %edx
	call	fwrite@PLT
	movl	20(%r13), %eax
	movq	24(%r13), %rsi
	testl	%eax, %eax
	je	.L1457
	leaq	.LC131(%rip), %rdx
	cmpl	$26, %eax
	je	.L1274
	ja	.L1275
	leaq	.LC129(%rip), %rdx
	cmpl	$24, %eax
	je	.L1274
	cmpl	$25, %eax
	leaq	.LC133(%rip), %rdx
	leaq	.LC130(%rip), %rax
	cmove	%rax, %rdx
.L1274:
	movq	%rsi, %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC155(%rip), %rsi
	call	fprintf@PLT
.L1276:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC158(%rip), %rdi
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
	jb	.L1278
	movl	76(%rsp), %r12d
	leaq	.LC28(%rip), %r13
	testl	%ebx, %ebx
	jle	.L1458
.L1264:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1280:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1280
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	testl	%r12d, %r12d
	jle	.L1431
	movl	8(%rsp), %r12d
	.p2align 4
	.p2align 3
.L1281:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jg	.L1281
.L1431:
	movl	32(%rsp), %edx
	leaq	.LC159(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	.p2align 4
	.p2align 3
.L1285:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1285
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	xorl	%ebx, %ebx
	leaq	.LC140(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	jle	.L1287
	.p2align 4
	.p2align 3
.L1288:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1288
.L1287:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
.L1169:
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
.L1185:
	.cfi_restore_state
	movl	%r12d, %ebp
	xorl	%ebx, %ebx
	leaq	.LC28(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1454
	.p2align 4
	.p2align 3
.L1209:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1209
.L1454:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC113(%rip), %rdi
.L1453:
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
.L1184:
	.cfi_restore_state
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%r12d, %r12d
	movl	8(%rsp), %r15d
	leaq	.LC28(%rip), %r13
	testl	%eax, %eax
	jle	.L1459
	.p2align 4
	.p2align 3
.L1207:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1207
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC142(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L1213
.L1212:
	movl	8(%rsp), %edi
	xorl	%r13d, %r13d
	addl	$1, %edi
	movl	%edi, 40(%rsp)
.L1220:
	movq	16(%rbx), %rdx
	movq	(%rdx,%r13,8), %r12
	testl	%ebp, %ebp
	je	.L1316
	subq	$1, %rax
	xorl	%ecx, %ecx
	cmpq	%r13, %rax
	je	.L1460
.L1215:
	movq	16(%rsp), %r8
	movl	40(%rsp), %edx
	movq	%r12, %rsi
	movq	%r14, %rdi
	call	emit_stmt
.L1218:
	movq	24(%rbx), %rax
	addq	$1, %r13
	cmpq	%rax, %r13
	jb	.L1220
	movl	8(%rsp), %r9d
	leaq	.LC28(%rip), %r13
	testl	%r9d, %r9d
	jle	.L1222
.L1213:
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1223:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1223
.L1222:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	jmp	.L1453
	.p2align 4,,10
	.p2align 3
.L1183:
	xorl	%r13d, %r13d
	cmpq	$0, 24(%rbx)
	movl	%r12d, 8(%rsp)
	leaq	.LC28(%rip), %rbp
	movl	8(%rsp), %r12d
	je	.L1169
	.p2align 4
	.p2align 3
.L1206:
	movq	16(%rbx), %rax
	movq	(%rax,%r13,8), %r15
	movq	(%r15), %rdi
	call	get_mangled_name
	movl	g_strict(%rip), %esi
	movq	%rax, 8(%rsp)
	testl	%esi, %esi
	je	.L1461
	cmpq	$0, 8(%r15)
	je	.L1298
.L1297:
	xorl	%r15d, %r15d
	testl	%r12d, %r12d
	jle	.L1228
	.p2align 4
	.p2align 3
.L1226:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1226
.L1228:
	movq	8(%rsp), %rcx
	leaq	.LC144(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	movq	%rcx, %r8
	movq	%rcx, %rdx
	call	fprintf@PLT
.L1227:
	addq	$1, %r13
	cmpq	24(%rbx), %r13
	jb	.L1206
	jmp	.L1169
	.p2align 4,,10
	.p2align 3
.L1182:
	xorl	%r15d, %r15d
	leaq	.LC28(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1232
	.p2align 4
	.p2align 3
.L1192:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1192
.L1232:
	movq	%r14, %rcx
	movl	$4, %edx
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
	leaq	.LC135(%rip), %rdi
	call	fwrite@PLT
	testl	%ebp, %ebp
	jne	.L1193
.L1194:
	movq	24(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L1233
	cmpl	$1, (%rsi)
	movl	%r12d, %edx
	je	.L1234
.L1233:
	leal	1(%r12), %edx
.L1234:
	movq	16(%rsp), %r8
	movl	%ebp, %ecx
	movq	%r14, %rdi
	call	emit_stmt
	cmpq	$0, 32(%rbx)
	je	.L1169
	xorl	%ebp, %ebp
	leaq	.LC28(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1238
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
.L1238:
	movq	%r14, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L1190
	jmp	.L1191
	.p2align 4,,10
	.p2align 3
.L1181:
	xorl	%ebp, %ebp
	leaq	.LC28(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1240
	.p2align 4
	.p2align 3
.L1189:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1189
.L1240:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC134(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC135(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L1191
.L1190:
	cmpl	$1, (%rbx)
	je	.L1239
.L1191:
	addl	$1, %r12d
.L1239:
	xorl	%ebp, %ebp
	jmp	.L1170
	.p2align 4,,10
	.p2align 3
.L1180:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	movl	8(%rsp), %r12d
	leaq	.LC28(%rip), %r13
	testl	%eax, %eax
	jle	.L1241
	.p2align 4
	.p2align 3
.L1203:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1203
.L1241:
	movq	%r14, %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC141(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%rbx)
	je	.L1462
	movq	%r14, %rsi
	movl	$32, %edi
	call	fputc@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	jmp	.L1454
	.p2align 4,,10
	.p2align 3
.L1178:
	movl	%r12d, 8(%rsp)
	xorl	%ebx, %ebx
	movl	8(%rsp), %ebp
	leaq	.LC28(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1243
	.p2align 4
	.p2align 3
.L1199:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1199
.L1243:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC140(%rip), %rdi
	jmp	.L1453
	.p2align 4,,10
	.p2align 3
.L1179:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%r12d, %r12d
	movl	8(%rsp), %r15d
	leaq	.LC28(%rip), %r13
	testl	%eax, %eax
	jle	.L1242
	.p2align 4
	.p2align 3
.L1200:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1200
.L1242:
	testl	%ebp, %ebp
	jne	.L1463
.L1202:
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	jmp	.L1454
	.p2align 4,,10
	.p2align 3
.L1176:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	movl	8(%rsp), %r12d
	leaq	.LC28(%rip), %r13
	testl	%eax, %eax
	jle	.L1245
	.p2align 4
	.p2align 3
.L1195:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1195
.L1245:
	movq	%r14, %rcx
	movl	$8, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC137(%rip), %rdi
	leaq	.LC147(%rip), %r13
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	%r14, %rdi
	movq	16(%rsp), %rdx
	leaq	.LC28(%rip), %rbp
	call	emit_expr
	movq	%r14, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC138(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	movl	8(%rsp), %r15d
	je	.L1197
	.p2align 4
	.p2align 3
.L1196:
	xorl	%ebx, %ebx
	testl	%r15d, %r15d
	js	.L1247
	.p2align 4
	.p2align 3
.L1246:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r15d
	jge	.L1246
.L1247:
	addq	$1, %r12
	xorl	%eax, %eax
	movq	%r13, %rsi
	movq	%r14, %rdi
	movq	%r12, %rcx
	movq	%r12, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %r12
	jb	.L1196
.L1197:
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	js	.L1248
	xorl	%ebx, %ebx
	leaq	.LC28(%rip), %r13
	.p2align 4
	.p2align 3
.L1249:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jge	.L1249
	movq	%r14, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	je	.L1222
	xorl	%ebx, %ebx
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
	jmp	.L1222
	.p2align 4,,10
	.p2align 3
.L1177:
	movl	%r12d, 8(%rsp)
	xorl	%ebx, %ebx
	movl	8(%rsp), %ebp
	leaq	.LC28(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1244
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
.L1244:
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC139(%rip), %rdi
	jmp	.L1453
	.p2align 4,,10
	.p2align 3
.L1175:
	xorl	%ebp, %ebp
	leaq	.LC28(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1464
	.p2align 4
	.p2align 3
.L1186:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1186
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 8(%rsp)
	testq	%rbp, %rbp
	je	.L1465
.L1187:
	movq	function_labels(%rip), %r15
	xorl	%r13d, %r13d
	jmp	.L1293
	.p2align 4,,10
	.p2align 3
.L1291:
	addq	$1, %r13
	cmpq	%rbp, %r13
	je	.L1188
.L1293:
	movq	(%r15,%r13,8), %rsi
	movq	8(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1291
	leal	1(%r13), %edx
.L1292:
	leaq	.LC160(%rip), %rsi
	movq	%r14, %rdi
	leal	1(%r12), %r15d
	xorl	%eax, %eax
	call	fprintf@PLT
	leaq	.LC28(%rip), %r13
	testl	%r15d, %r15d
	jle	.L1296
.L1294:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1295:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jne	.L1295
.L1296:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movl	%r15d, %r12d
	leaq	.LC113(%rip), %rdi
	xorl	%ebp, %ebp
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	jmp	.L1170
	.p2align 4,,10
	.p2align 3
.L1327:
	movq	$0, 24(%rsp)
	jmp	.L1267
	.p2align 4,,10
	.p2align 3
.L1457:
	movl	16(%r13), %eax
	testl	%eax, %eax
	je	.L1277
	movq	32(%r13), %rcx
	movq	%rsi, %rdx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC156(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1276
	.p2align 4,,10
	.p2align 3
.L1461:
	movq	16(%rsp), %rcx
	movl	%r12d, %edx
	movq	%r15, %rsi
	movq	%r14, %rdi
	call	emit_auto_storage
	cmpq	$0, 8(%r15)
	jne	.L1297
	movl	g_strict(%rip), %ecx
	testl	%ecx, %ecx
	je	.L1227
	.p2align 4
	.p2align 3
.L1298:
	xorl	%r15d, %r15d
	testl	%r12d, %r12d
	jle	.L1230
	.p2align 4
	.p2align 3
.L1229:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1229
.L1230:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC113(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1227
.L1460:
	cmpl	$6, (%r12)
	movl	%ebp, %ecx
	jne	.L1215
	movl	g_no_line(%rip), %r8d
	testl	%r8d, %r8d
	jne	.L1216
	cmpb	$0, 24(%rsp)
	je	.L1216
	movl	4(%r12), %edx
	movq	16(%rsp), %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC29(%rip), %rsi
	call	fprintf@PLT
.L1216:
	movl	8(%rsp), %edi
	leaq	.LC28(%rip), %rax
	xorl	%r15d, %r15d
	movq	%rax, 32(%rsp)
	testl	%edi, %edi
	js	.L1219
	.p2align 4
	.p2align 3
.L1217:
	movq	32(%rsp), %rdi
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r15d
	call	fwrite@PLT
	cmpl	%r15d, 8(%rsp)
	jge	.L1217
.L1219:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC143(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r12), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC113(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1218
	.p2align 4,,10
	.p2align 3
.L1277:
	movq	%rsi, %rdx
	movq	%r14, %rdi
	leaq	.LC157(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1276
	.p2align 4,,10
	.p2align 3
.L1316:
	xorl	%ecx, %ecx
	jmp	.L1215
	.p2align 4,,10
	.p2align 3
.L1275:
	cmpl	$27, %eax
	leaq	.LC133(%rip), %rdx
	leaq	.LC132(%rip), %rax
	cmove	%rax, %rdx
	jmp	.L1274
.L1193:
	xorl	%ebp, %ebp
	cmpq	$0, 32(%rbx)
	sete	%bpl
	jmp	.L1194
.L1458:
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	xorl	%eax, %eax
	movq	%r14, %rdi
	call	fprintf@PLT
	testl	%r12d, %r12d
	jle	.L1452
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
.L1452:
	movl	32(%rsp), %edx
	movq	%r14, %rdi
	leaq	.LC159(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC140(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1287
.L1464:
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 8(%rsp)
	testq	%rbp, %rbp
	jne	.L1187
.L1188:
	xorl	%edx, %edx
	jmp	.L1292
.L1463:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC143(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1202
.L1462:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC146(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1454
.L1248:
	movq	%r14, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1222
.L1459:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC142(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	jne	.L1212
	jmp	.L1222
.L1456:
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC150(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r12d
	testl	%eax, %eax
	je	.L1256
	movq	%r14, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC151(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	leaq	.LC113(%rip), %rax
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ebp
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC152(%rip), %rdx
	movl	$64, %esi
	movl	%ebp, %ecx
	call	snprintf@PLT
	movl	%ebp, %edx
	leaq	.LC153(%rip), %rsi
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
	leaq	.LC154(%rip), %rax
	movq	%rax, %rsi
	movq	%rax, 64(%rsp)
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%eax, %eax
	movl	%ebp, %edx
	leaq	.LC161(%rip), %rsi
	movq	%r14, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r15)
	leal	2(%rax), %ebx
	jne	.L1301
	cmpl	$1, %ebx
	je	.L1264
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1452
	.p2align 4,,10
	.p2align 3
.L1465:
	xorl	%edx, %edx
	leaq	.LC160(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%r12), %r15d
	jmp	.L1294
	.cfi_endproc
.LFE58:
	.size	emit_stmt, .-emit_stmt
	.section	.rodata.str1.1
.LC162:
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
	leaq	.L1471(%rip), %r15
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
	je	.L1466
.L1467:
	cmpl	$13, 0(%r13)
	ja	.L1469
	movl	0(%r13), %eax
	movslq	(%r15,%rax,4), %rax
	addq	%r15, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1471:
	.long	.L1469-.L1471
	.long	.L1475-.L1471
	.long	.L1469-.L1471
	.long	.L1474-.L1471
	.long	.L1473-.L1471
	.long	.L1469-.L1471
	.long	.L1469-.L1471
	.long	.L1469-.L1471
	.long	.L1469-.L1471
	.long	.L1469-.L1471
	.long	.L1469-.L1471
	.long	.L1472-.L1471
	.long	.L1469-.L1471
	.long	.L1470-.L1471
	.text
	.p2align 4,,10
	.p2align 3
.L1469:
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
.L1470:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1519
	xorl	%eax, %eax
	jmp	.L1489
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1488:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1519
.L1489:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%r13, (%rdx)
	jne	.L1488
	movq	8(%rdx), %r14
.L1487:
	xorl	%r13d, %r13d
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1553
	.p2align 4
	.p2align 3
.L1490:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1490
	movq	%r14, %rdx
	leaq	.LC162(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1493:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jle	.L1493
.L1492:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC113(%rip), %rdi
	jmp	.L1552
	.p2align 4,,10
	.p2align 3
.L1472:
	xorl	%r14d, %r14d
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1554
	.p2align 4
	.p2align 3
.L1476:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1476
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L1555
.L1477:
	movq	function_labels(%rip), %r14
	xorl	%r12d, %r12d
	jmp	.L1497
	.p2align 4,,10
	.p2align 3
.L1495:
	addq	$1, %r12
	cmpq	%r12, 24(%rsp)
	je	.L1478
.L1497:
	movq	(%r14,%r12,8), %rsi
	movq	16(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1495
	leal	1(%r12), %edx
.L1496:
	leaq	.LC160(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	leaq	.LC28(%rip), %r12
	movl	%eax, 16(%rsp)
	testl	%eax, %eax
	jle	.L1556
.L1498:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1500:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, %ebp
	jne	.L1500
	movl	16(%rsp), %ebp
.L1501:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC113(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	jne	.L1467
	jmp	.L1466
	.p2align 4,,10
	.p2align 3
.L1473:
	xorl	%r14d, %r14d
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1513
	.p2align 4
	.p2align 3
.L1479:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1479
.L1513:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC134(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC135(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	je	.L1466
.L1480:
	xorl	%eax, %eax
	cmpl	$1, 0(%r13)
	setne	%al
	addl	%eax, %ebp
	jmp	.L1467
	.p2align 4,,10
	.p2align 3
.L1474:
	xorl	%r14d, %r14d
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1508
	.p2align 4
	.p2align 3
.L1482:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1482
.L1508:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC136(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC135(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %rsi
	testq	%rsi, %rsi
	je	.L1484
	cmpl	$1, (%rsi)
	movl	%ebp, %edx
	je	.L1509
.L1484:
	leal	1(%rbp), %edx
.L1509:
	movq	(%rsp), %r8
	movq	8(%rsp), %rcx
	movq	%rbx, %rdi
	call	emit_stmt_switchctx
	cmpq	$0, 32(%r13)
	je	.L1466
	xorl	%r14d, %r14d
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1512
	.p2align 4
	.p2align 3
.L1510:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1510
.L1512:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r13), %r13
	testq	%r13, %r13
	jne	.L1480
.L1466:
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
.L1475:
	.cfi_restore_state
	xorl	%r15d, %r15d
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1557
	.p2align 4
	.p2align 3
.L1485:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebp, %r15d
	jne	.L1485
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC142(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	je	.L1503
.L1502:
	leal	1(%rbp), %r12d
	xorl	%r15d, %r15d
.L1505:
	movq	16(%r13), %rax
	movq	(%rsp), %r8
	movl	%r12d, %edx
	movq	%rbx, %rdi
	movq	8(%rsp), %rcx
	movq	(%rax,%r15,8), %rsi
	addq	$1, %r15
	call	emit_stmt_switchctx
	cmpq	24(%r13), %r15
	jb	.L1505
	leaq	.LC28(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1504
.L1503:
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1507:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1507
.L1504:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
.L1552:
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
.L1519:
	.cfi_restore_state
	xorl	%r14d, %r14d
	jmp	.L1487
	.p2align 4,,10
	.p2align 3
.L1554:
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	jne	.L1477
	.p2align 4
	.p2align 3
.L1478:
	xorl	%edx, %edx
	jmp	.L1496
.L1555:
	xorl	%edx, %edx
	leaq	.LC160(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	movl	%eax, 16(%rsp)
	jmp	.L1498
	.p2align 4,,10
	.p2align 3
.L1553:
	xorl	%eax, %eax
	movq	%r14, %rdx
	leaq	.LC162(%rip), %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	testl	%ebp, %ebp
	jne	.L1492
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	jmp	.L1492
	.p2align 4,,10
	.p2align 3
.L1556:
	movl	%eax, %ebp
	jmp	.L1501
	.p2align 4,,10
	.p2align 3
.L1557:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC142(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	jne	.L1502
	jmp	.L1504
	.cfi_endproc
.LFE46:
	.size	emit_stmt_switchctx, .-emit_stmt_switchctx
	.section	.rodata.str1.1
.LC163:
	.string	"static "
.LC164:
	.string	""
	.section	.rodata.str1.8
	.align 8
.LC165:
	.string	"#ifndef %s\nextern word %s[];\n#define __b_external_%s (%s[0])\n#else\n#define __b_external_%s (%s)\n#endif\n"
	.section	.rodata.str1.1
.LC166:
	.string	"extern word %s[];\n"
.LC167:
	.string	"%sword %s[%zu];\n"
.LC168:
	.string	"static word __%s_store[%zu];\n"
	.text
	.p2align 4
	.type	emit_global_declarations, @function
emit_global_declarations:
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
	je	.L1558
	movq	%rdi, %rbp
	movq	%rsi, %r12
	xorl	%ebx, %ebx
	jmp	.L1572
	.p2align 4,,10
	.p2align 3
.L1561:
	addq	$1, %rbx
	cmpq	8(%r12), %rbx
	jnb	.L1558
.L1572:
	movq	(%r12), %rax
	movq	(%rax,%rbx,8), %r14
	movl	(%r14), %eax
	testl	%eax, %eax
	je	.L1590
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L1561
	movq	8(%r14), %r13
	movq	16(%r13), %rdi
	call	get_mangled_name
	cmpl	$3, (%r14)
	movq	%rax, %r15
	je	.L1591
	cmpl	$1, 24(%r13)
	movl	$1, %r8d
	jne	.L1566
	movq	56(%r13), %rdi
	movl	$1, %r11d
	testq	%rdi, %rdi
	je	.L1567
	cmpl	$1, (%rdi)
	je	.L1592
.L1567:
	call	edge_tail_words_top
	leaq	(%rax,%r11), %r8
	movl	$1, %eax
	testq	%r8, %r8
	cmove	%rax, %r8
.L1566:
	movl	4(%r13), %eax
	leaq	.LC164(%rip), %rdx
	testl	%eax, %eax
	je	.L1568
	leaq	.LC163(%rip), %rdx
.L1568:
	xorl	%eax, %eax
	movq	%r15, %rcx
	leaq	.LC167(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$2, 24(%r13)
	jne	.L1561
	movq	56(%r13), %rdi
	xorl	%r11d, %r11d
	testq	%rdi, %rdi
	je	.L1569
	cmpl	$1, (%rdi)
	je	.L1593
.L1569:
	cmpq	$0, 32(%r13)
	je	.L1570
	movq	48(%r13), %rax
	movq	%r11, %rdx
	cmpq	%rax, %r11
	cmovb	%rax, %r11
	testq	%rax, %rax
	cmovle	%rdx, %r11
.L1570:
	call	edge_tail_words_top
	movq	%r15, %rdx
	leaq	.LC168(%rip), %rsi
	movq	%rbp, %rdi
	leaq	(%rax,%r11), %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	xorl	%eax, %eax
	addq	$1, %rbx
	call	fprintf@PLT
	cmpq	8(%r12), %rbx
	jb	.L1572
.L1558:
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
.L1590:
	.cfi_restore_state
	movq	8(%r14), %rsi
	movq	(%rsp), %r8
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbp, %rdi
	call	emit_stmt
	jmp	.L1561
	.p2align 4,,10
	.p2align 3
.L1591:
	movq	16(%r13), %rdx
	movq	%rdx, %rdi
	movq	%rdx, 8(%rsp)
	call	global_data_kind
	testl	%eax, %eax
	je	.L1561
	movl	8(%r13), %esi
	testl	%esi, %esi
	je	.L1565
	movq	8(%rsp), %rdx
	movq	%r15, %rcx
	movq	%r15, %r9
	movq	%r15, %r8
	leaq	.LC165(%rip), %rsi
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
	jmp	.L1561
	.p2align 4,,10
	.p2align 3
.L1592:
	movq	24(%rdi), %r11
	jmp	.L1567
	.p2align 4,,10
	.p2align 3
.L1565:
	movq	%r15, %rdx
	leaq	.LC166(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1561
.L1593:
	movq	24(%rdi), %r11
	jmp	.L1569
	.cfi_endproc
.LFE63:
	.size	emit_global_declarations, .-emit_global_declarations
	.section	.rodata.str1.1
.LC169:
	.string	"{\n    B_FRAME;\n"
	.section	.rodata.str1.8
	.align 8
.LC170:
	.string	"    size_t __bcc_count = __bcc_current_call ? __bcc_current_call->count : 0;\n"
	.align 8
.LC171:
	.string	"    if (__bcc_count < %zu) __bcc_count = %zu;\n"
	.align 8
.LC172:
	.string	"    word __bcc_parameters[__bcc_count];\n    for (size_t __bcc_i = 0; __bcc_i < __bcc_count; ++__bcc_i)\n        __bcc_parameters[__bcc_i] = __bcc_current_call && __bcc_i < __bcc_current_call->count\n            ? __bcc_current_call->arguments[__bcc_i] : 0;\n"
	.align 8
.LC173:
	.string	"    (void)B_LOCAL_PTR_N(__bcc_parameters, sizeof(__bcc_parameters));\n"
	.align 8
.LC174:
	.string	"    static word __b_label_value_%zu = %zu;\n"
	.section	.rodata.str1.1
.LC175:
	.string	"    return 0;\n}\n"
	.text
	.p2align 4
	.type	emit_function_body, @function
emit_function_body:
.LFB59:
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
	leaq	.LC169(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%r14)
	jne	.L1607
.L1596:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L1608
.L1598:
	cmpq	$0, 8+function_labels(%rip)
	je	.L1602
	xorl	%ebx, %ebx
	leaq	.LC174(%rip), %r12
	.p2align 4
	.p2align 3
.L1603:
	addq	$1, %rbx
	xorl	%eax, %eax
	movq	%r12, %rsi
	movq	%rbp, %rdi
	movq	%rbx, %rcx
	movq	%rbx, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %rbx
	jb	.L1603
.L1602:
	movq	32(%r14), %rsi
	movq	%r13, %r8
	movq	%rbp, %rdi
	movl	$1, %ecx
	movl	$1, %edx
	call	emit_stmt
	movq	%rbp, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC175(%rip), %rdi
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
.L1607:
	.cfi_restore_state
	movq	%rbp, %rcx
	movl	$77, %edx
	movl	$1, %esi
	leaq	.LC170(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r14), %rdx
	movq	%rbp, %rdi
	xorl	%eax, %eax
	leaq	.LC171(%rip), %rsi
	movq	%rdx, %rcx
	call	fprintf@PLT
	movq	%rbp, %rcx
	movl	$255, %edx
	movl	$1, %esi
	leaq	.LC172(%rip), %rdi
	call	fwrite@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L1596
	movq	%rbp, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC173(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1596
	.p2align 4,,10
	.p2align 3
.L1608:
	movq	32(%r14), %rdi
	pxor	%xmm0, %xmm0
	movq	%rsp, %rsi
	movq	$0, 16(%rsp)
	movaps	%xmm0, (%rsp)
	call	collect_function_autos
	cmpq	$0, 8(%rsp)
	je	.L1599
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1600:
	movq	(%rsp), %rax
	movq	%r13, %rcx
	movl	$1, %edx
	movq	%rbp, %rdi
	movq	(%rax,%rbx,8), %rsi
	addq	$1, %rbx
	call	emit_auto_storage
	cmpq	8(%rsp), %rbx
	jb	.L1600
.L1599:
	cmpq	$0, g_compilation_arena(%rip)
	jne	.L1598
	movq	(%rsp), %rdi
	call	free@PLT
	jmp	.L1598
	.cfi_endproc
.LFE59:
	.size	emit_function_body, .-emit_function_body
	.section	.rodata.str1.1
.LC176:
	.string	"#define BCC_USE_CURSES 1\n"
	.section	.rodata.str1.8
	.align 8
.LC177:
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
.LC178:
	.string	"#define __bcc_strict_runtime %d\n"
	.section	.rodata.str1.1
.LC179:
	.string	"#define B_BYTEPTR %d\n"
.LC180:
	.string	"#define WORD_BITS %d\n"
	.section	.rodata.str1.8
	.align 8
.LC181:
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
.LC182:
	.string	"%s/btarget.h"
	.section	.rodata.str1.8
	.align 8
.LC183:
	.string	"#define B_TARGET_DEFINE\n#define B_TARGET_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC184:
	.string	"%s/binit.h"
	.section	.rodata.str1.8
	.align 8
.LC185:
	.string	"#define B_INIT_DEFINE\n#define B_INIT_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC186:
	.string	"%s/bcall.h"
	.section	.rodata.str1.8
	.align 8
.LC187:
	.string	"#define B_CALL_DEFINE\n#define B_CALL_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC188:
	.string	"%s/bunix.h"
	.section	.rodata.str1.8
	.align 8
.LC189:
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
	.ascii	"wr();\n    word i = 0;\n    for (;;) {\n        word ch = b_"
	.ascii	"char(s, i++);\n        if (ch == 004 || (!__bcc_strict_runti"
	.ascii	"me && ch == 0)) break;\n        b_putchar(ch);\n    }\n    r"
	.ascii	"eturn s;\n}\nstatic word b_getstr(word buf) {\n    __b_sync_"
	.ascii	"rd();\n    size_t i = 0;\n    unsigned char c;\n    for (;;)"
	.ascii	" {\n        ssize_t n = read(rd_fd, &c, 1);\n        if (n ="
	.ascii	"= 1 && c != '\\n' && c != '\\r') {\n            b_lchar(buf,"
	.ascii	" (word)i, (word)c);\n            i++;\n            continue;"
	.ascii	"\n        }\n        if (n == 1) break; /* newline */\n     "
	.ascii	"   if (rd_fd != 0) {\n            close(rd_fd);\n           "
	.ascii	" rd_fd = 0;\n            rd_unit = -1;\n            continue"
	.ascii	"; /* retry on terminal */\n        }\n  "
	.string	"      break; /* EOF */\n    }\n    b_lchar(buf, (word)i, (word)004);\n    return buf;\n}\nstatic word b_flush(void){\n    __b_sync_wr();\n    if (wr_fd == 1) {\n        fflush(stdout);\n    } else {\n        fsync(wr_fd);\n    }\n    return 0;\n}\n\n#include <stdarg.h>\n\n"
	.section	.rodata.str1.1
.LC190:
	.string	"%s/bformat.h"
	.section	.rodata.str1.8
	.align 8
.LC191:
	.string	"#define __bcc_format_linkage static\n"
	.align 8
.LC192:
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
.LC193:
	.string	"word __b_user_main("
.LC194:
	.string	"void)\n"
	.section	.rodata.str1.8
	.align 8
.LC195:
	.string	"int main(int argc, char **argv){\n"
	.section	.rodata.str1.1
.LC196:
	.string	"    __b_setargs(argc, argv);\n"
.LC197:
	.string	"    __b_init();\n"
	.section	.rodata.str1.8
	.align 8
.LC198:
	.string	"    return (int)__bcc_call%zu("
	.section	.rodata.str1.1
.LC199:
	.string	", (word)argc"
.LC200:
	.string	", __b_argvalues()"
	.text
	.p2align 4
	.globl	emit_program_c
	.type	emit_program_c, @function
emit_program_c:
.LFB65:
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
	jne	.L1631
.L1610:
	movq	%rbx, %rcx
	movl	$1529, %edx
	movl	$1, %esi
	leaq	.LC177(%rip), %rdi
	call	fwrite@PLT
	movl	g_strict(%rip), %eax
	xorl	%edx, %edx
	movq	%rbx, %rdi
	leaq	.LC178(%rip), %rsi
	testl	%eax, %eax
	setne	%dl
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbx, %rdi
	setne	%dl
	leaq	.LC179(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%r12d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC180(%rip), %rsi
	leaq	24(%rsp), %r12
	call	fprintf@PLT
	movq	%rbx, %rcx
	movl	$1378, %edx
	movl	$1, %esi
	leaq	.LC181(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC182(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$73, %edx
	movl	$1, %esi
	leaq	.LC183(%rip), %rdi
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
	leaq	.LC184(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC185(%rip), %rdi
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
	leaq	.LC186(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	movq	%rax, %r14
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC187(%rip), %rdi
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
	je	.L1632
.L1611:
	movq	g_libb_path(%rip), %rsi
	leaq	.LC188(%rip), %rdi
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
	movl	$11388, %edx
	movl	$1, %esi
	leaq	.LC189(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC190(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$36, %edx
	movl	$1, %esi
	leaq	.LC191(%rip), %rdi
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
	movl	$13046, %edx
	movl	$1, %esi
	leaq	.LC192(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1633
.L1612:
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
	je	.L1609
	xorl	%r15d, %r15d
	xorl	%r13d, %r13d
	xorl	%r14d, %r14d
	jmp	.L1617
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1614:
	addq	$1, %r15
	cmpq	8(%rbp), %r15
	jnb	.L1634
.L1617:
	movq	0(%rbp), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L1614
	movq	8(%rax), %r12
	leaq	.LC12(%rip), %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1615
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	movq	16(%r12), %r13
	leaq	.LC193(%rip), %rdi
	movl	$1, %r14d
	call	fwrite@PLT
.L1616:
	movq	%rbx, %rcx
	movl	$6, %edx
	movl	$1, %esi
	addq	$1, %r15
	leaq	.LC194(%rip), %rdi
	call	fwrite@PLT
	movq	8(%rsp), %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_function_body
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	8(%rbp), %r15
	jb	.L1617
.L1634:
	testl	%r14d, %r14d
	jne	.L1635
.L1609:
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
.L1615:
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
	jmp	.L1616
	.p2align 4,,10
	.p2align 3
.L1631:
	movq	%rbx, %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC176(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1610
	.p2align 4,,10
	.p2align 3
.L1635:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC195(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC196(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC197(%rip), %rdi
	call	fwrite@PLT
	movl	$2, %edx
	leaq	.LC198(%rip), %rsi
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
	jne	.L1636
.L1621:
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
	leaq	.LC118(%rip), %rdi
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
.L1633:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1612
	.p2align 4,,10
	.p2align 3
.L1632:
	movq	%r14, %rdi
	call	free@PLT
	jmp	.L1611
	.p2align 4,,10
	.p2align 3
.L1636:
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC199(%rip), %rdi
	call	fwrite@PLT
	cmpq	$1, %r13
	je	.L1621
	movq	%rbx, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC200(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1621
	.cfi_endproc
.LFE65:
	.size	emit_program_c, .-emit_program_c
	.section	.rodata.str1.8
	.align 8
.LC201:
	.string	"/* Generated by BCC - B Compiler */\n"
	.section	.rodata.str1.1
.LC202:
	.string	"#include \"libb.h\"\n\n"
	.section	.rodata.str1.8
	.align 8
.LC203:
	.string	"#include <ncurses.h>\n#include <panel.h>\n\n"
	.text
	.p2align 4
	.globl	emit_program_c_ext
	.type	emit_program_c_ext, @function
emit_program_c_ext:
.LFB66:
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
	je	.L1659
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
	leaq	.LC201(%rip), %rdi
	call	fwrite@PLT
	movl	g_strict(%rip), %ecx
	xorl	%edx, %edx
	movq	%rbx, %rdi
	leaq	.LC178(%rip), %rsi
	testl	%ecx, %ecx
	setne	%dl
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbx, %rdi
	setne	%dl
	leaq	.LC179(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%r12d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC180(%rip), %rsi
	call	fprintf@PLT
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$19, %edx
	leaq	.LC202(%rip), %rdi
	call	fwrite@PLT
	movl	g_use_curses(%rip), %esi
	testl	%esi, %esi
	jne	.L1660
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1661
.L1640:
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
	je	.L1637
	movl	$0, 12(%rsp)
	xorl	%r15d, %r15d
	xorl	%r13d, %r13d
	jmp	.L1645
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1642:
	addq	$1, %r15
	cmpq	8(%r14), %r15
	jnb	.L1662
.L1645:
	movq	(%r14), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L1642
	movq	8(%rax), %r12
	leaq	.LC12(%rip), %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1643
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	movq	16(%r12), %r13
	leaq	.LC193(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 12(%rsp)
.L1644:
	movq	%rbx, %rcx
	movl	$6, %edx
	movl	$1, %esi
	addq	$1, %r15
	leaq	.LC194(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_function_body
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	8(%r14), %r15
	jb	.L1645
.L1662:
	movl	12(%rsp), %eax
	testl	%eax, %eax
	jne	.L1663
.L1637:
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
.L1643:
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
	jmp	.L1644
	.p2align 4,,10
	.p2align 3
.L1661:
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1640
	.p2align 4,,10
	.p2align 3
.L1660:
	movq	%rbx, %rcx
	movl	$41, %edx
	movl	$1, %esi
	leaq	.LC203(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	je	.L1640
	jmp	.L1661
	.p2align 4,,10
	.p2align 3
.L1663:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC195(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC196(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC197(%rip), %rdi
	call	fwrite@PLT
	movl	$2, %edx
	leaq	.LC198(%rip), %rsi
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
	jne	.L1664
.L1649:
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
	leaq	.LC118(%rip), %rdi
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
.L1659:
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
.L1664:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC199(%rip), %rdi
	call	fwrite@PLT
	cmpq	$1, %r13
	je	.L1649
	movq	%rbx, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC200(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1649
	.cfi_endproc
.LFE66:
	.size	emit_program_c_ext, .-emit_program_c_ext
	.section	.rodata
	.align 16
	.type	CSWTCH.181, @object
	.size	CSWTCH.181, 24
CSWTCH.181:
	.long	24
	.long	25
	.long	26
	.long	27
	.long	22
	.long	23
	.section	.rodata.str1.1
.LC204:
	.string	"lchar"
.LC205:
	.string	"getchar"
.LC206:
	.string	"getchr"
.LC207:
	.string	"putchr"
.LC208:
	.string	"getstr"
.LC209:
	.string	"putstr"
.LC210:
	.string	"flush"
.LC211:
	.string	"reread"
.LC212:
	.string	"printn"
.LC213:
	.string	"putnum"
.LC214:
	.string	"print"
.LC215:
	.string	"putchar"
.LC216:
	.string	"abort"
.LC217:
	.string	"free"
.LC218:
	.string	"alloc"
.LC219:
	.string	"open"
.LC220:
	.string	"close"
.LC221:
	.string	"read"
.LC222:
	.string	"write"
.LC223:
	.string	"creat"
.LC224:
	.string	"seek"
.LC225:
	.string	"openr"
.LC226:
	.string	"openw"
.LC227:
	.string	"fork"
.LC228:
	.string	"wait"
.LC229:
	.string	"execl"
.LC230:
	.string	"execv"
.LC231:
	.string	"chdir"
.LC232:
	.string	"chmod"
.LC233:
	.string	"chown"
.LC234:
	.string	"link"
.LC235:
	.string	"unlink"
.LC236:
	.string	"stat"
.LC237:
	.string	"fstat"
.LC238:
	.string	"time"
.LC239:
	.string	"ctime"
.LC240:
	.string	"getuid"
.LC241:
	.string	"setuid"
.LC242:
	.string	"makdir"
.LC243:
	.string	"mkdir"
.LC244:
	.string	"intr"
.LC245:
	.string	"gtty"
.LC246:
	.string	"stty"
.LC247:
	.string	"system"
.LC248:
	.string	"usleep"
.LC249:
	.string	"argc"
	.section	.data.rel.ro.local,"aw"
	.align 32
	.type	names.0, @object
	.size	names.0, 416
names.0:
	.quad	.LC3
	.quad	.LC204
	.quad	.LC205
	.quad	.LC206
	.quad	.LC207
	.quad	.LC208
	.quad	.LC209
	.quad	.LC210
	.quad	.LC211
	.quad	.LC68
	.quad	.LC212
	.quad	.LC213
	.quad	.LC214
	.quad	.LC215
	.quad	.LC74
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
	.quad	.LC247
	.quad	.LC248
	.quad	.LC66
	.quad	.LC249
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
.LC250:
	.string	"break"
.LC251:
	.string	"case"
.LC252:
	.string	"const"
.LC253:
	.string	"continue"
.LC254:
	.string	"default"
.LC255:
	.string	"do"
.LC256:
	.string	"double"
.LC257:
	.string	"else"
.LC258:
	.string	"enum"
.LC259:
	.string	"extern"
.LC260:
	.string	"float"
.LC261:
	.string	"for"
.LC262:
	.string	"goto"
.LC263:
	.string	"if"
.LC264:
	.string	"inline"
.LC265:
	.string	"int"
.LC266:
	.string	"long"
.LC267:
	.string	"register"
.LC268:
	.string	"restrict"
.LC269:
	.string	"short"
.LC270:
	.string	"signed"
.LC271:
	.string	"sizeof"
.LC272:
	.string	"static"
.LC273:
	.string	"struct"
.LC274:
	.string	"switch"
.LC275:
	.string	"typedef"
.LC276:
	.string	"union"
.LC277:
	.string	"unsigned"
.LC278:
	.string	"volatile"
.LC279:
	.string	"while"
.LC280:
	.string	"_Bool"
.LC281:
	.string	"_Complex"
.LC282:
	.string	"_Imaginary"
.LC283:
	.string	"_Alignas"
.LC284:
	.string	"_Alignof"
.LC285:
	.string	"_Atomic"
.LC286:
	.string	"_Generic"
.LC287:
	.string	"_Noreturn"
.LC288:
	.string	"_Static_assert"
.LC289:
	.string	"_Thread_local"
.LC290:
	.string	"NULL"
.LC291:
	.string	"true"
.LC292:
	.string	"false"
.LC293:
	.string	"bool"
.LC294:
	.string	"word"
.LC295:
	.string	"B_PTR"
.LC296:
	.string	"B_ADDR"
.LC297:
	.string	"B_DEREF"
	.section	.data.rel.ro.local
	.align 32
	.type	c_keywords, @object
	.size	c_keywords, 424
c_keywords:
	.quad	.LC4
	.quad	.LC250
	.quad	.LC251
	.quad	.LC3
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
	.quad	.LC141
	.quad	.LC269
	.quad	.LC270
	.quad	.LC271
	.quad	.LC272
	.quad	.LC273
	.quad	.LC274
	.quad	.LC275
	.quad	.LC276
	.quad	.LC277
	.quad	.LC21
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
	.quad	.LC293
	.quad	.LC294
	.quad	.LC295
	.quad	.LC296
	.quad	.LC297
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
