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
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movq	8+g_known_variables(%rip), %rax
	testq	%rax, %rax
	je	.L138
	movq	g_known_variables(%rip), %rbx
	xorl	%ebp, %ebp
	leaq	(%rbx,%rax,8), %r13
	.p2align 4
	.p2align 3
.L125:
	movq	(%rbx), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	addq	$8, %rbx
	movzbl	%al, %eax
	orl	%eax, %ebp
	cmpq	%r13, %rbx
	jne	.L125
.L124:
	movq	current_program(%rip), %r13
	testq	%r13, %r13
	je	.L126
	movq	8(%r13), %r14
	xorl	%ebx, %ebx
	jmp	.L127
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L128:
	addq	$1, %rbx
.L127:
	cmpq	%rbx, %r14
	je	.L126
	movq	0(%r13), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$2, (%rax)
	jne	.L128
	movq	8(%rax), %rax
	movq	%r12, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L128
.L129:
	movl	$1, %ebp
	jmp	.L123
	.p2align 4,,10
	.p2align 3
.L126:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L131
.L133:
	xorl	%ebp, %ebp
.L123:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%ebp, %eax
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
.L131:
	.cfi_restore_state
	movq	%r12, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	je	.L140
	testb	$1, %bpl
	je	.L133
.L140:
	movq	current_program(%rip), %r13
	testq	%r13, %r13
	je	.L123
	movq	8(%r13), %r14
	xorl	%ebx, %ebx
	jmp	.L135
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L136:
	addq	$1, %rbx
.L135:
	cmpq	%rbx, %r14
	je	.L123
	movq	0(%r13), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$3, (%rax)
	jne	.L136
	movq	8(%rax), %r15
	movq	%r12, %rsi
	movq	16(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L136
	movl	8(%r15), %eax
	movl	$2, %ebp
	testl	%eax, %eax
	jne	.L123
	jmp	.L129
.L138:
	xorl	%ebp, %ebp
	jmp	.L124
	.cfi_endproc
.LFE23:
	.size	global_data_kind, .-global_data_kind
	.section	.rodata.str1.1
.LC3:
	.string	"argv"
	.text
	.p2align 4
	.type	predefined_argv, @function
predefined_argv:
.LFB22:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.LC3(%rip), %rsi
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
	xorl	%ebx, %ebx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L184
.L155:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%ebx, %eax
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
.L184:
	.cfi_restore_state
	movq	%rbp, %rdi
	movl	%eax, %ebx
	call	source_function
	testl	%eax, %eax
	jne	.L155
	movq	8+g_known_variables(%rip), %r13
	testq	%r13, %r13
	je	.L157
	movq	g_known_variables(%rip), %r14
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L158:
	movq	(%r14,%r12,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	je	.L155
	addq	$1, %r12
	cmpq	%r13, %r12
	jne	.L158
.L157:
	movq	current_program(%rip), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L165
	movq	8(%rax), %rax
	xorl	%r12d, %r12d
	movq	%rax, (%rsp)
	jmp	.L159
	.p2align 4,,10
	.p2align 3
.L160:
	testl	%eax, %eax
	je	.L185
.L161:
	addq	$1, %r12
.L159:
	cmpq	%r12, (%rsp)
	je	.L165
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r12,8), %rdx
	movl	(%rdx), %eax
	cmpl	$2, %eax
	jne	.L160
	movq	8(%rdx), %rax
	movq	%rbp, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L161
	jmp	.L155
	.p2align 4,,10
	.p2align 3
.L185:
	movq	8(%rdx), %rax
	movq	24(%rax), %r13
	testq	%r13, %r13
	je	.L161
	movq	16(%rax), %r14
	xorl	%r15d, %r15d
	jmp	.L162
	.p2align 4,,10
	.p2align 3
.L186:
	addq	$1, %r15
	cmpq	%r13, %r15
	je	.L161
.L162:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L186
	jmp	.L155
.L165:
	movl	$1, %ebx
	jmp	.L155
	.cfi_endproc
.LFE22:
	.size	predefined_argv, .-predefined_argv
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
	je	.L188
	movq	string_pool(%rip), %rsi
	xorl	%eax, %eax
	jmp	.L191
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L189:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L188
.L191:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%rbx, (%rdx)
	jne	.L189
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
.L188:
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
	.type	collect_strings_expr, @function
collect_strings_expr:
.LFB33:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L233
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
	leaq	.L202(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %rbx
.L199:
	cmpl	$10, (%rbx)
	ja	.L197
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L202:
	.long	.L197-.L202
	.long	.L210-.L202
	.long	.L197-.L202
	.long	.L209-.L202
	.long	.L201-.L202
	.long	.L237-.L202
	.long	.L237-.L202
	.long	.L236-.L202
	.long	.L236-.L202
	.long	.L203-.L202
	.long	.L201-.L202
	.text
	.p2align 4,,10
	.p2align 3
.L201:
	movq	48(%rbx), %rdi
	call	collect_strings_expr
.L237:
	movq	56(%rbx), %rbx
.L217:
	testq	%rbx, %rbx
	jne	.L199
.L197:
	popq	%rbx
	.cfi_remember_state
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
.L203:
	.cfi_restore_state
	movq	48(%rbx), %rdi
	call	collect_strings_expr
.L236:
	movq	56(%rbx), %rdi
	call	collect_strings_expr
	movq	64(%rbx), %rbx
	jmp	.L217
	.p2align 4,,10
	.p2align 3
.L209:
	movl	g_strict(%rip), %edx
	movq	48(%rbx), %rdi
	testl	%edx, %edx
	jne	.L239
.L211:
	call	collect_strings_expr
	cmpq	$0, 64(%rbx)
	je	.L197
	xorl	%ebp, %ebp
.L216:
	movq	56(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_expr
	cmpq	64(%rbx), %rbp
	jb	.L216
	popq	%rbx
	.cfi_remember_state
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
.L210:
	.cfi_restore_state
	movq	40(%rbx), %rsi
	movq	48(%rbx), %rdi
	popq	%rbx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_restore 13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_restore 14
	.cfi_def_cfa_offset 8
	jmp	get_string_id
	.p2align 4,,10
	.p2align 3
.L239:
	.cfi_restore_state
	movl	24(%rbx), %eax
	testl	%eax, %eax
	jne	.L211
	cmpl	$2, (%rdi)
	jne	.L211
	movq	48(%rdi), %r13
	movq	%r13, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	je	.L212
.L238:
	movq	48(%rbx), %rdi
	jmp	.L211
	.p2align 4,,10
	.p2align 3
.L233:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	ret
.L212:
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	movq	%r13, %rdi
	call	source_function
	movl	%eax, %r12d
	testl	%eax, %eax
	jne	.L238
	movq	8+external_calls(%rip), %rax
	testq	%rax, %rax
	je	.L214
	movq	external_calls(%rip), %rbp
	leaq	0(%rbp,%rax,8), %r14
.L215:
	movq	0(%rbp), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	addq	$8, %rbp
	movzbl	%al, %eax
	orl	%eax, %r12d
	cmpq	%r14, %rbp
	jne	.L215
	testl	%r12d, %r12d
	jne	.L238
.L214:
	movq	%r13, %rdi
	call	sdup@PLT
	leaq	external_calls(%rip), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L238
	.cfi_endproc
.LFE33:
	.size	collect_strings_expr, .-collect_strings_expr
	.p2align 4
	.type	collect_strings_init, @function
collect_strings_init:
.LFB34:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L249
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
	je	.L252
	cmpl	$1, %eax
	je	.L253
.L240:
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
.L252:
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
.L253:
	.cfi_restore_state
	cmpq	$0, 24(%rdi)
	je	.L240
	xorl	%ebp, %ebp
.L243:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_init
	cmpq	24(%rbx), %rbp
	jb	.L243
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L249:
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
	je	.L277
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L259(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L256:
	cmpl	$12, (%rbx)
	ja	.L254
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L259:
	.long	.L254-.L259
	.long	.L266-.L259
	.long	.L254-.L259
	.long	.L265-.L259
	.long	.L258-.L259
	.long	.L262-.L259
	.long	.L262-.L259
	.long	.L254-.L259
	.long	.L254-.L259
	.long	.L254-.L259
	.long	.L262-.L259
	.long	.L260-.L259
	.long	.L258-.L259
	.text
	.p2align 4,,10
	.p2align 3
.L262:
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
.L266:
	.cfi_restore_state
	cmpq	$0, 24(%rbx)
	je	.L254
	xorl	%ebp, %ebp
.L267:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_stmt
	cmpq	24(%rbx), %rbp
	jb	.L267
.L254:
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
.L258:
	.cfi_restore_state
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rbx
.L268:
	testq	%rbx, %rbx
	jne	.L256
	jmp	.L254
	.p2align 4,,10
	.p2align 3
.L260:
	movq	24(%rbx), %rbx
	jmp	.L268
	.p2align 4,,10
	.p2align 3
.L265:
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rdi
	call	collect_strings_stmt
	movq	32(%rbx), %rbx
	jmp	.L268
	.p2align 4,,10
	.p2align 3
.L277:
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
	je	.L290
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
	jmp	.L287
	.p2align 4,,10
	.p2align 3
.L283:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L293
.L287:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L294
	cmpl	$2, %eax
	je	.L295
	testl	%eax, %eax
	jne	.L283
	movq	8(%rdx), %rdi
	addq	$1, %rbx
	call	collect_strings_stmt
	cmpq	8(%rbp), %rbx
	jb	.L287
.L293:
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
.L294:
	.cfi_restore_state
	movq	8(%rdx), %rax
	movq	32(%rax), %rdi
	call	collect_strings_stmt
	jmp	.L283
	.p2align 4,,10
	.p2align 3
.L295:
	movq	8(%rdx), %r12
	movq	56(%r12), %rdi
	call	collect_strings_init
	movq	32(%r12), %rdi
	testq	%rdi, %rdi
	je	.L283
	call	collect_strings_expr
	jmp	.L283
	.p2align 4,,10
	.p2align 3
.L290:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE36:
	.size	collect_strings_program, .-collect_strings_program
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
	.string	"__bcc_"
.LC12:
	.string	"__bcc_user_%c_%s"
.LC13:
	.string	"%s_%d"
.LC14:
	.string	"__bcc_keyword_%s"
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
	je	.L342
	movq	8+name_map(%rip), %r13
	movq	%rdi, %rbp
	testq	%r13, %r13
	je	.L298
	movq	name_map(%rip), %r14
	xorl	%ebx, %ebx
	jmp	.L300
	.p2align 4,,10
	.p2align 3
.L299:
	addq	$1, %rbx
	cmpq	%r13, %rbx
	je	.L298
.L300:
	movq	(%r14,%rbx,8), %r12
	movq	%rbp, %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L299
	movq	8(%r12), %r13
.L296:
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
.L298:
	.cfi_restore_state
	cmpb	$0, 0(%rbp)
	je	.L372
	movq	%rbp, %rdi
	call	strlen@PLT
	movl	$8, %esi
	movq	%rbp, %rdi
	movq	%rax, %r15
	call	strchr@PLT
	testq	%rax, %rax
	je	.L373
.L303:
	movabsq	$9223372036854775802, %rax
	cmpq	%r15, %rax
	jb	.L374
	leaq	10(%r15,%r15), %r13
	movq	%r13, %rdi
	call	xmalloc@PLT
	movq	%rax, %r14
	movabsq	$8314312742553149279, %rax
	movq	%rax, (%r14)
	movb	$95, 8(%r14)
	testq	%r15, %r15
	je	.L302
.L306:
	leaq	-1(%r14,%r13), %r15
	movq	%rbp, %r12
	leaq	9(%r14), %rbx
	leaq	.LC8(%rip), %r13
	.p2align 4
	.p2align 3
.L308:
	movzbl	(%r12), %edx
	movq	%rbx, %rdi
	movq	%r13, %rsi
	xorl	%eax, %eax
	addq	$2, %rbx
	addq	$1, %r12
	call	sprintf@PLT
	cmpq	%rbx, %r15
	jne	.L308
.L302:
	movl	g_strict(%rip), %edx
	testl	%edx, %edx
	jne	.L327
	movq	%rbp, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L375
.L327:
	movq	%r14, %rdi
	call	strlen@PLT
	leaq	14(%rax), %rdi
	call	xmalloc@PLT
	movl	$98, %edx
	movq	%rax, %r13
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L376
.L326:
	xorl	%eax, %eax
	movq	%r14, %rcx
	leaq	.LC12(%rip), %rsi
	movq	%r13, %rdi
	call	sprintf@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L377
.L328:
	leaq	8+c_keywords(%rip), %rbx
	leaq	.LC4(%rip), %rsi
	jmp	.L331
	.p2align 4,,10
	.p2align 3
.L378:
	movq	(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L332
.L331:
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L378
	movq	%r13, %rdi
	call	strlen@PLT
	leaq	15(%rax), %rdi
	call	xmalloc@PLT
	movq	%r13, %rdx
	leaq	.LC14(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %rbx
	xorl	%eax, %eax
	call	sprintf@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L379
.L341:
	movq	%rbx, %r13
.L332:
	movq	8+name_map(%rip), %r12
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
	testq	%r12, %r12
	je	.L333
	movq	name_map(%rip), %r14
	xorl	%ebx, %ebx
	jmp	.L335
	.p2align 4,,10
	.p2align 3
.L381:
	addq	$1, %rbx
	cmpq	%rbx, %r12
	je	.L380
.L335:
	movq	(%r14,%rbx,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L381
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
.L337:
	leal	1(%rcx), %eax
	movq	%r13, %rdx
	leaq	.LC13(%rip), %rsi
	movq	%r12, %rdi
	movl	%eax, 12(%rsp)
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	8+name_map(%rip), %rbx
	testq	%rbx, %rbx
	je	.L336
	movq	(%rsp), %rax
	xorl	%r15d, %r15d
	movq	(%rax), %r14
	jmp	.L338
	.p2align 4,,10
	.p2align 3
.L382:
	addq	$1, %r15
	cmpq	%rbx, %r15
	je	.L336
.L338:
	movq	(%r14,%r15,8), %rax
	movq	%r12, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L382
	movl	12(%rsp), %ecx
	jmp	.L337
.L373:
	movl	$9, %edx
	leaq	.LC6(%rip), %rsi
	movq	%rbp, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	je	.L303
	leaq	16(,%r15,4), %rdi
	call	xmalloc@PLT
	movzbl	0(%rbp), %edx
	movq	%rax, %r14
	leaq	1(%rax), %r13
	leal	-65(%rdx), %eax
	cmpb	$57, %al
	ja	.L309
	movabsq	$288230372997595135, %rcx
	btq	%rax, %rcx
	jnc	.L309
	movb	%dl, (%r14)
.L313:
	leaq	1(%rbp), %rbx
	leaq	0(%rbp,%r15), %rcx
	movabsq	$288230372997595135, %r12
	cmpq	$1, %r15
	ja	.L323
	jmp	.L315
	.p2align 4,,10
	.p2align 3
.L316:
	leal	-65(%rax), %edx
	cmpb	$57, %dl
	ja	.L319
	btq	%rdx, %r12
	jnc	.L319
.L317:
	movb	%al, 0(%r13)
	addq	$1, %r13
.L322:
	addq	$1, %rbx
	cmpq	%rbx, %rcx
	je	.L315
.L323:
	movzbl	(%rbx), %eax
	cmpb	$57, %al
	jg	.L316
	cmpb	$47, %al
	jg	.L317
	cmpb	$46, %al
	jne	.L319
	movb	$95, 0(%r13)
	addq	$1, %r13
	jmp	.L322
.L374:
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
	jmp	.L306
	.p2align 4,,10
	.p2align 3
.L380:
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
.L333:
	movl	$16, %edi
	call	xmalloc@PLT
	movq	%rbp, %rdi
	movq	%rax, %rbx
	call	sdup@PLT
	movq	%r13, 8(%rbx)
	movq	(%rsp), %rdi
	movq	%rbx, %rsi
	movq	%rax, (%rbx)
	call	vec_push@PLT
	jmp	.L296
	.p2align 4,,10
	.p2align 3
.L372:
	leaq	.LC5(%rip), %rdi
	call	sdup@PLT
	movq	%rax, %r14
	jmp	.L302
	.p2align 4,,10
	.p2align 3
.L336:
	cmpq	$0, g_compilation_arena(%rip)
	je	.L383
.L339:
	movq	%r12, %r13
	jmp	.L333
	.p2align 4,,10
	.p2align 3
.L376:
	movq	%rbp, %rdi
	call	source_function
	movl	$102, %edx
	testl	%eax, %eax
	jne	.L326
	movq	%rbp, %rdi
	call	b_library_function@PLT
	cmpl	$1, %eax
	sbbl	%edx, %edx
	andl	$6, %edx
	addl	$114, %edx
	jmp	.L326
.L342:
	xorl	%r13d, %r13d
	jmp	.L296
.L377:
	movq	%r14, %rdi
	call	free@PLT
	jmp	.L328
.L375:
	movq	%rbp, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	jne	.L327
	movl	$6, %edx
	leaq	.LC11(%rip), %rsi
	movq	%rbp, %rdi
	movq	%r14, %r13
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L328
	jmp	.L327
.L309:
	movb	$95, (%r14)
	movzbl	0(%rbp), %eax
	cmpb	$46, %al
	jne	.L384
	movb	$95, 1(%r14)
	leaq	2(%r14), %r13
	jmp	.L313
.L319:
	movzbl	%al, %edx
	movq	%r13, %rdi
	leaq	.LC10(%rip), %rsi
	xorl	%eax, %eax
	movq	%rcx, (%rsp)
	addq	$3, %r13
	call	sprintf@PLT
	movq	(%rsp), %rcx
	jmp	.L322
.L315:
	movb	$0, 0(%r13)
	jmp	.L302
.L379:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L341
.L383:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L339
.L384:
	movzbl	%al, %edx
	movq	%r13, %rdi
	leaq	.LC9(%rip), %rsi
	xorl	%eax, %eax
	call	sprintf@PLT
	leaq	3(%r14), %r13
	jmp	.L313
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
	jne	.L386
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
.L386:
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
	.string	"extern word "
.LC19:
	.string	"[];\n"
.LC20:
	.string	"word "
.LC21:
	.string	"[1];\n"
.LC22:
	.string	"static word "
.LC23:
	.string	"void"
.LC24:
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
	je	.L389
	xorl	%ebp, %ebp
	leaq	.LC18(%rip), %r15
	leaq	external_calls(%rip), %r14
	leaq	.LC19(%rip), %r13
	.p2align 4
	.p2align 3
.L391:
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rdi
	testq	%rdi, %rdi
	je	.L390
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L390:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addq	$1, %rbp
	cmpq	8+external_calls(%rip), %rbp
	jb	.L391
.L389:
	cmpq	$0, 8+g_known_functions(%rip)
	je	.L400
	movl	$0, 12(%rsp)
	movq	$0, (%rsp)
	.p2align 4
	.p2align 3
.L398:
	leaq	g_known_functions(%rip), %rax
	movq	(%rsp), %rdx
	movq	8(%r12), %r13
	movq	(%rax), %rax
	movq	(%r12), %r14
	movq	(%rax,%rdx,8), %rbp
	testq	%r13, %r13
	je	.L393
	xorl	%r15d, %r15d
	jmp	.L396
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L394:
	addq	$1, %r15
	cmpq	%r15, %r13
	je	.L393
.L396:
	movq	(%r14,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L394
	movq	8(%rax), %rax
	movq	%rbp, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L394
.L395:
	addq	$1, (%rsp)
	movq	(%rsp), %rax
	cmpq	8+g_known_functions(%rip), %rax
	jb	.L398
	movl	12(%rsp), %eax
	testl	%eax, %eax
	je	.L400
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
.L400:
	cmpq	$0, 8(%r12)
	je	.L388
	xorl	%r13d, %r13d
	leaq	.LC20(%rip), %r15
	leaq	.LC21(%rip), %r14
	jmp	.L404
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L402:
	addq	$1, %r13
	cmpq	8(%r12), %r13
	jnb	.L388
.L404:
	movq	(%r12), %rax
	movq	(%rax,%r13,8), %rax
	cmpl	$1, (%rax)
	jne	.L402
	movq	8(%rax), %rbp
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	0(%rbp), %rdi
	testq	%rdi, %rdi
	je	.L403
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L403:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	addq	$1, %r13
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC22(%rip), %rdi
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
	leaq	.LC23(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC24(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r12), %r13
	jb	.L404
.L388:
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
.L393:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC18(%rip), %rdi
	call	fwrite@PLT
	testq	%rbp, %rbp
	je	.L397
	movq	%rbp, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L397:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC19(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 12(%rsp)
	jmp	.L395
	.cfi_endproc
.LFE63:
	.size	emit_function_prototypes, .-emit_function_prototypes
	.section	.rodata.str1.1
.LC25:
	.string	"b_%s"
	.text
	.p2align 4
	.type	emit_function_name, @function
emit_function_name:
.LFB29:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rsi, %rbx
	leaq	.LC15(%rip), %rsi
	movq	%rbx, %rdi
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L429
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbp, %rcx
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
.L429:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	je	.L430
	movq	%rbx, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L435
.L430:
	movq	%rbx, %rdi
	call	get_mangled_name
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbp, %rsi
	popq	%rbx
	.cfi_def_cfa_offset 16
	movq	%rax, %rdi
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	fputs@PLT
	.p2align 4,,10
	.p2align 3
.L435:
	.cfi_restore_state
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbx, %rdx
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 16
	leaq	.LC25(%rip), %rsi
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	fprintf@PLT
	.cfi_endproc
.LFE29:
	.size	emit_function_name, .-emit_function_name
	.p2align 4
	.type	edge_words_total.part.0.isra.0, @function
edge_words_total.part.0.isra.0:
.LFB80:
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
	je	.L440
	movq	%rdi, %r12
	movq	%rsi, %rbp
	xorl	%ebx, %ebx
.L439:
	movq	(%r12,%rbx,8), %rax
	testq	%rax, %rax
	je	.L438
	cmpl	$1, (%rax)
	je	.L446
.L438:
	addq	$1, %rbx
	cmpq	%rbp, %rbx
	jne	.L439
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
.L446:
	.cfi_restore_state
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r13
	jmp	.L438
	.p2align 4,,10
	.p2align 3
.L440:
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
.LFE80:
	.size	edge_words_total.part.0.isra.0, .-edge_words_total.part.0.isra.0
	.section	.rodata.str1.1
.LC26:
	.string	"  "
	.text
	.p2align 4
	.globl	emit_indent
	.type	emit_indent, @function
emit_indent:
.LFB38:
	.cfi_startproc
	testl	%esi, %esi
	jle	.L452
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	leaq	.LC26(%rip), %r13
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
.L449:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L449
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
.L452:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	ret
	.cfi_endproc
.LFE38:
	.size	emit_indent, .-emit_indent
	.section	.rodata.str1.1
.LC27:
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
	jne	.L455
	testq	%rdx, %rdx
	jne	.L463
.L455:
	ret
	.p2align 4,,10
	.p2align 3
.L463:
	movq	%rdx, %rcx
	xorl	%eax, %eax
	movl	%esi, %edx
	leaq	.LC27(%rip), %rsi
	jmp	fprintf@PLT
	.cfi_endproc
.LFE39:
	.size	emit_line_directive, .-emit_line_directive
	.section	.rodata.str1.1
.LC28:
	.string	"\\n"
.LC29:
	.string	"\\t"
.LC30:
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
	leaq	.LC28(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	leaq	.LC30(%rip), %r13
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
	jne	.L465
	jmp	.L472
	.p2align 4,,10
	.p2align 3
.L480:
	movq	%r13, %rsi
	movq	%r12, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L468:
	movzbl	1(%rbp), %ebx
	addq	$1, %rbp
	testb	%bl, %bl
	je	.L472
.L465:
	cmpb	$92, %bl
	je	.L473
	cmpb	$34, %bl
	je	.L473
	cmpb	$10, %bl
	je	.L478
	cmpb	$9, %bl
	je	.L479
	movzbl	%bl, %edx
	cmpb	$31, %bl
	jbe	.L480
	movq	%r12, %rsi
	movl	%edx, %edi
	addq	$1, %rbp
	call	fputc@PLT
	movzbl	0(%rbp), %ebx
	testb	%bl, %bl
	jne	.L465
.L472:
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
.L473:
	.cfi_restore_state
	movq	%r12, %rsi
	movl	$92, %edi
	call	fputc@PLT
	movzbl	%bl, %edi
	movq	%r12, %rsi
	call	fputc@PLT
	jmp	.L468
	.p2align 4,,10
	.p2align 3
.L478:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	jmp	.L468
	.p2align 4,,10
	.p2align 3
.L479:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC29(%rip), %rdi
	call	fwrite@PLT
	jmp	.L468
	.cfi_endproc
.LFE40:
	.size	emit_c_string, .-emit_c_string
	.section	.rodata.str1.1
.LC31:
	.string	"B_ADDR(*__bcc_binding_cell("
.LC32:
	.string	"))"
.LC33:
	.string	"B_ADDR("
.LC34:
	.string	"b_argv_vector"
.LC35:
	.string	"__b_external_%s"
.LC36:
	.string	"[0]"
	.text
	.p2align 4
	.type	emit_ival_expr.part.0, @function
emit_ival_expr.part.0:
.LFB75:
	.cfi_startproc
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
	movq	48(%rsi), %rdi
	movq	%rsi, %rbx
	call	b_library_function@PLT
	testl	%eax, %eax
	je	.L482
	movq	48(%rbx), %rdi
	call	predefined_argv
	testl	%eax, %eax
	je	.L499
.L482:
	leaq	.LC33(%rip), %rdi
	movq	%rbp, %rcx
	movl	$7, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	48(%rbx), %r12
	movq	%r12, %rdi
	call	predefined_argv
	testl	%eax, %eax
	jne	.L500
	movq	%r12, %rdi
	call	global_data_kind
	movq	48(%rbx), %r12
	cmpl	$2, %eax
	je	.L501
	testq	%r12, %r12
	je	.L486
	movq	%r12, %rdi
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	48(%rbx), %r12
.L486:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L487
.L488:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
	jmp	.L484
	.p2align 4,,10
	.p2align 3
.L500:
	movq	%rbp, %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC34(%rip), %rdi
	call	fwrite@PLT
.L484:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbp, %rsi
	movl	$41, %edi
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	fputc@PLT
	.p2align 4,,10
	.p2align 3
.L499:
	.cfi_restore_state
	movq	%rbp, %rcx
	movl	$27, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	emit_c_string
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbp, %rcx
	movl	$2, %edx
	popq	%rbp
	.cfi_def_cfa_offset 16
	movl	$1, %esi
	leaq	.LC32(%rip), %rdi
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L487:
	.cfi_restore_state
	movq	%r12, %rdi
	call	global_data_kind
	cmpl	$1, %eax
	jne	.L484
	jmp	.L488
	.p2align 4,,10
	.p2align 3
.L501:
	movq	%r12, %rdi
	call	get_mangled_name
	leaq	.LC35(%rip), %rsi
	movq	%rbp, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L484
	.cfi_endproc
.LFE75:
	.size	emit_ival_expr.part.0, .-emit_ival_expr.part.0
	.section	.rodata.str1.1
.LC37:
	.string	"b_preinc(&("
.LC38:
	.string	"b_predec(&("
.LC39:
	.string	"b_postinc(&("
.LC40:
	.string	"b_postdec(&("
.LC41:
	.string	"WAND"
.LC42:
	.string	"WOR"
.LC43:
	.string	"WADD"
.LC44:
	.string	"WSUB"
.LC45:
	.string	"WMUL"
.LC46:
	.string	"WSHR"
.LC47:
	.string	"WSHL"
.LC48:
	.string	"WMOD"
.LC49:
	.string	"WDIV"
.LC50:
	.string	"="
.LC51:
	.string	"add_assign"
.LC52:
	.string	"or_assign"
.LC53:
	.string	"and_assign"
.LC54:
	.string	"rsh_assign"
.LC55:
	.string	"lsh_assign"
.LC56:
	.string	"mod_assign"
.LC57:
	.string	"div_assign"
.LC58:
	.string	"mul_assign"
.LC59:
	.string	"sub_assign"
.LC60:
	.string	"WVAL((word)%ld)"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC61:
	.string	"B_PTR_N(__b_str%d, sizeof(__b_str%d))"
	.section	.rodata.str1.1
.LC62:
	.string	"__b_label_value_%d"
.LC63:
	.string	"__bcc_parameters[%zu]"
.LC64:
	.string	"(*__bcc_binding_cell("
.LC65:
	.string	"B_FUNCTION("
	.section	.rodata.str1.8
	.align 8
.LC66:
	.string	"({ word *__bcc_binding_%u = __bcc_binding_cell("
	.section	.rodata.str1.1
.LC67:
	.string	"); "
.LC68:
	.string	"; })"
.LC69:
	.string	"printf"
.LC70:
	.string	"malloc"
.LC71:
	.string	"calloc"
.LC72:
	.string	"realloc"
.LC73:
	.string	"B_PTR("
.LC74:
	.string	"-+ #0"
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
	.string	", "
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
	.align 8
.LC98:
	.string	"*__b_dest_%u %s __b_rhs_%u; })"
	.align 8
.LC99:
	.string	"b_%s(__b_dest_%u, __b_rhs_%u); })"
	.section	.rodata.str1.1
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
	.string	"dprintf"
	.text
	.p2align 4
	.globl	emit_expr
	.type	emit_expr, @function
emit_expr:
.LFB49:
	.cfi_startproc
	cmpl	$10, (%rsi)
	ja	.L865
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
	leaq	.L505(%rip), %rdx
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movl	(%rsi), %eax
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L505:
	.long	.L515-.L505
	.long	.L514-.L505
	.long	.L513-.L505
	.long	.L512-.L505
	.long	.L511-.L505
	.long	.L510-.L505
	.long	.L509-.L505
	.long	.L508-.L505
	.long	.L507-.L505
	.long	.L506-.L505
	.long	.L504-.L505
	.text
	.p2align 4,,10
	.p2align 3
.L506:
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
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$3, %edx
	leaq	.LC101(%rip), %rdi
	call	fwrite@PLT
	movq	64(%r15), %rsi
.L879:
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L880:
	addq	$72, %rsp
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
.L504:
	.cfi_restore_state
	movq	%rdi, %rsi
	movl	$40, %edi
	call	fputc@PLT
.L883:
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC86(%rip), %rdi
.L882:
	call	fwrite@PLT
	movq	56(%r15), %rsi
	jmp	.L879
	.p2align 4,,10
	.p2align 3
.L515:
	movq	48(%rsi), %rdx
	leaq	.LC60(%rip), %rsi
.L877:
	addq	$72, %rsp
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
.L514:
	.cfi_restore_state
	movq	48(%r15), %rdi
	movq	40(%rsi), %rsi
	call	get_string_id
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rdi
	leaq	.LC61(%rip), %rsi
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
.L513:
	.cfi_restore_state
	movq	8+function_labels(%rip), %r13
	movq	48(%rsi), %r12
	testq	%r13, %r13
	je	.L516
	movq	function_labels(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L519
	.p2align 4,,10
	.p2align 3
.L517:
	addq	$1, %rbp
	cmpq	%r13, %rbp
	je	.L516
.L519:
	movq	(%r14,%rbp,8), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L517
	movl	%ebp, %edx
	addl	$1, %edx
	je	.L516
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rdi
	leaq	.LC62(%rip), %rsi
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
.L512:
	.cfi_restore_state
	movq	48(%rsi), %rax
	movl	24(%rsi), %edx
	cmpl	$2, (%rax)
	je	.L893
	testl	%edx, %edx
	jne	.L534
	movq	48(%rax), %r12
.L664:
	xorl	%r14d, %r14d
.L538:
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	64(%r15), %rdx
	testq	%rdx, %rdx
	je	.L880
	movq	$0, 16(%rsp)
	movl	$0, 32(%rsp)
	movb	$0, 39(%rsp)
	movq	$0, 24(%rsp)
.L554:
	movq	%rbp, (%rsp)
	xorl	%r12d, %r12d
	movq	%rdx, %r13
.L614:
	testq	%r14, %r14
	je	.L676
	movl	g_strict(%rip), %ebp
	testl	%ebp, %ebp
	je	.L894
.L676:
	xorl	%ebp, %ebp
.L577:
	movq	56(%r15), %rax
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
.L646:
	testl	%ebp, %ebp
	jne	.L895
.L612:
	addq	$1, %r12
	cmpq	%r13, %r12
	jnb	.L613
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC86(%rip), %rdi
	call	fwrite@PLT
	jmp	.L614
	.p2align 4,,10
	.p2align 3
.L511:
	movq	%rdi, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC87(%rip), %rdi
	call	fwrite@PLT
	jmp	.L883
	.p2align 4,,10
	.p2align 3
.L510:
	movl	48(%rsi), %r12d
	cmpl	$32, %r12d
	je	.L896
	cmpl	$53, %r12d
	je	.L897
	leal	-36(%r12), %eax
	cmpl	$1, %eax
	jbe	.L898
	cmpl	$31, %r12d
	je	.L899
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
	jmp	.L884
	.p2align 4,,10
	.p2align 3
.L509:
	cmpl	$36, 48(%rsi)
	movq	56(%rsi), %r12
	leaq	.LC40(%rip), %rdi
	jne	.L621
	leaq	.LC39(%rip), %rdi
.L621:
	movl	$12, %edx
	movl	$1, %esi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r12, %rsi
.L884:
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC32(%rip), %rdi
.L878:
	addq	$72, %rsp
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
.L508:
	.cfi_restore_state
	movl	48(%rsi), %r12d
	leal	-53(%r12), %eax
	cmpl	$1, %eax
	jbe	.L900
	leal	-28(%r12), %eax
	cmpl	$6, %eax
	ja	.L624
	leaq	.L626(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L626:
	.long	.L684-.L626
	.long	.L631-.L626
	.long	.L630-.L626
	.long	.L629-.L626
	.long	.L628-.L626
	.long	.L627-.L626
	.long	.L625-.L626
	.text
	.p2align 4,,10
	.p2align 3
.L507:
	movl	48(%rsi), %r8d
	movl	expression_id(%rip), %ecx
	movq	56(%rsi), %r13
	movq	64(%rsi), %r14
	leal	-47(%r8), %eax
	leal	1(%rcx), %r12d
	cmpl	$5, %eax
	jbe	.L901
	movl	%r12d, %edx
	leaq	.LC95(%rip), %rsi
	xorl	%eax, %eax
	movl	%r8d, (%rsp)
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
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC67(%rip), %rdi
	call	fwrite@PLT
	movl	(%rsp), %r8d
	leal	-38(%r8), %eax
	cmpl	$8, %eax
	ja	.L634
	leaq	.L636(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L636:
	.long	.L644-.L636
	.long	.L643-.L636
	.long	.L642-.L636
	.long	.L641-.L636
	.long	.L640-.L636
	.long	.L639-.L636
	.long	.L638-.L636
	.long	.L685-.L636
	.long	.L635-.L636
	.text
	.p2align 4,,10
	.p2align 3
.L516:
	movq	32(%r15), %rdx
	testq	%rdx, %rdx
	jne	.L902
	movl	16(%r15), %eax
	testl	%eax, %eax
	jne	.L903
	movl	12(%r15), %eax
	testl	%eax, %eax
	jne	.L904
	movl	20(%r15), %eax
	cmpl	$2, %eax
	je	.L905
	testq	%r12, %r12
	je	.L527
	movq	%r12, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movl	20(%r15), %eax
.L527:
	cmpl	$1, %eax
	je	.L524
.L502:
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
.L894:
	.cfi_restore_state
	movq	%r14, %rdi
	call	source_function
	movl	%eax, 8(%rsp)
	testl	%eax, %eax
	jne	.L577
	movq	16(%rsp), %rax
	movl	current_byteptr(%rip), %ecx
	cmpq	%rax, %r12
	movl	%ecx, 40(%rsp)
	sete	%al
	andb	39(%rsp), %al
	movb	%al, 48(%rsp)
	jne	.L578
	movq	24(%rsp), %rax
	testq	%rax, %rax
	je	.L579
	movl	(%rax,%r12,4), %eax
	testl	%eax, %eax
	je	.L579
	testl	%ecx, %ecx
	je	.L580
	.p2align 4
	.p2align 3
.L581:
	movq	%rbx, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC83(%rip), %rdi
	call	fwrite@PLT
.L611:
	movl	$1, %ebp
	jmp	.L577
.L529:
	xorl	%r12d, %r12d
	testl	%edx, %edx
	je	.L533
	.p2align 4
	.p2align 3
.L534:
	xorl	%r13d, %r13d
.L531:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r13, %rcx
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
.L902:
	.cfi_restore_state
	subq	$1, %rdx
	leaq	.LC63(%rip), %rsi
	jmp	.L877
	.p2align 4,,10
	.p2align 3
.L898:
	cmpl	$36, %r12d
	leaq	.LC37(%rip), %rax
	movl	$11, %edx
	movq	%rbx, %rcx
	leaq	.LC38(%rip), %rdi
	movl	$1, %esi
	cmove	%rax, %rdi
	call	fwrite@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	jmp	.L884
	.p2align 4,,10
	.p2align 3
.L631:
	leaq	.LC46(%rip), %rdx
	.p2align 4
	.p2align 3
.L632:
	leaq	.LC94(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC86(%rip), %rdi
	call	fwrite@PLT
	movq	64(%r15), %rsi
	jmp	.L879
	.p2align 4,,10
	.p2align 3
.L684:
	leaq	.LC47(%rip), %rdx
	jmp	.L632
	.p2align 4,,10
	.p2align 3
.L630:
	leaq	.LC43(%rip), %rdx
	jmp	.L632
	.p2align 4,,10
	.p2align 3
.L625:
	leaq	.LC48(%rip), %rdx
	jmp	.L632
	.p2align 4,,10
	.p2align 3
.L628:
	leaq	.LC45(%rip), %rdx
	jmp	.L632
	.p2align 4,,10
	.p2align 3
.L629:
	leaq	.LC44(%rip), %rdx
	jmp	.L632
	.p2align 4,,10
	.p2align 3
.L627:
	leaq	.LC49(%rip), %rdx
	jmp	.L632
.L635:
	leaq	.LC52(%rip), %rdx
	.p2align 4
	.p2align 3
.L637:
	movl	%r12d, %r8d
	movl	%r12d, %ecx
	leaq	.LC99(%rip), %rsi
.L881:
	addq	$72, %rsp
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
.L685:
	.cfi_restore_state
	leaq	.LC53(%rip), %rdx
	jmp	.L637
.L638:
	leaq	.LC54(%rip), %rdx
	jmp	.L637
.L641:
	leaq	.LC57(%rip), %rdx
	jmp	.L637
.L642:
	leaq	.LC58(%rip), %rdx
	jmp	.L637
.L643:
	leaq	.LC59(%rip), %rdx
	jmp	.L637
.L644:
	leaq	.LC51(%rip), %rdx
	jmp	.L637
.L639:
	leaq	.LC55(%rip), %rdx
	jmp	.L637
.L640:
	leaq	.LC56(%rip), %rdx
	jmp	.L637
	.p2align 4,,10
	.p2align 3
.L895:
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L612
	.p2align 4,,10
	.p2align 3
.L613:
	movl	$41, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movl	32(%rsp), %edi
	testl	%edi, %edi
	je	.L615
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
.L615:
	movq	24(%rsp), %rax
	testq	%rax, %rax
	je	.L502
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rax, %rdi
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
	jmp	free@PLT
	.p2align 4,,10
	.p2align 3
.L901:
	.cfi_restore_state
	leaq	CSWTCH.186(%rip), %rdx
	leaq	.LC95(%rip), %rsi
	movl	%r12d, expression_id(%rip)
	movl	(%rdx,%rax,4), %r15d
	movl	%r12d, %edx
	xorl	%eax, %eax
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
	addq	$72, %rsp
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
	leaq	.LC97(%rip), %rsi
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
.L893:
	.cfi_restore_state
	movq	48(%rax), %r13
	testq	%r13, %r13
	je	.L529
	testl	%edx, %edx
	jne	.L534
	movq	%r13, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L531
	movl	g_strict(%rip), %eax
	movq	%r13, %r12
	testl	%eax, %eax
	jne	.L906
	.p2align 4
	.p2align 3
.L533:
	movq	%r12, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	jne	.L907
.L537:
	movq	48(%r15), %rax
	cmpl	$2, (%rax)
	movq	48(%rax), %r12
	jne	.L664
	movl	g_strict(%rip), %r14d
	leaq	.LC69(%rip), %rsi
	movq	%r12, %rdi
	movl	%r14d, 32(%rsp)
	call	strcmp@PLT
	movl	%eax, %r13d
	testl	%r14d, %r14d
	je	.L539
	testl	%eax, %eax
	je	.L540
.L874:
	movq	%r12, %r14
	jmp	.L538
	.p2align 4,,10
	.p2align 3
.L899:
	movq	%rdi, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC89(%rip), %rdi
	jmp	.L882
	.p2align 4,,10
	.p2align 3
.L578:
	movl	40(%rsp), %r10d
	testl	%r10d, %r10d
	jne	.L581
.L580:
	leaq	.LC70(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testq	%r12, %r12
	jne	.L699
	testl	%eax, %eax
	je	.L647
.L699:
	movl	$1, 40(%rsp)
	xorl	%ebp, %ebp
	leaq	.LC72(%rip), %rdx
.L649:
	movq	%rdx, %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L892
.L603:
	leaq	.LC71(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L605
.L892:
	cmpq	$1, %r12
	je	.L908
.L605:
	movl	40(%rsp), %r8d
	testl	%r8d, %r8d
	jne	.L581
.L599:
	testl	%ebp, %ebp
	je	.L577
.L595:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC84(%rip), %rdi
	call	fwrite@PLT
	jmp	.L611
	.p2align 4,,10
	.p2align 3
.L900:
	movl	expression_id(%rip), %eax
	leaq	.LC90(%rip), %rsi
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
	leaq	.LC91(%rip), %rsi
	call	fprintf@PLT
	movq	64(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	cmpl	$53, %r12d
	movl	%r13d, %r8d
	movl	%r13d, %ecx
	leaq	.LC42(%rip), %rdx
	leaq	.LC41(%rip), %rax
	cmove	%rax, %rdx
	leaq	.LC92(%rip), %rsi
	jmp	.L881
	.p2align 4,,10
	.p2align 3
.L903:
	movq	%rbx, %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC34(%rip), %rdi
	jmp	.L878
.L896:
	movq	%rdi, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC88(%rip), %rdi
	jmp	.L882
.L624:
	movq	%rdi, %rsi
	movl	$40, %edi
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
	jmp	.L879
.L897:
	movq	%rdi, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC33(%rip), %rdi
	jmp	.L882
.L904:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L909
	movq	%r12, %rdi
	call	b_library_function@PLT
	movq	%rbx, %rcx
	testl	%eax, %eax
	je	.L525
	movl	$21, %edx
	movl	$1, %esi
	leaq	.LC64(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
	movq	%rbx, %rdi
	call	emit_c_string
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC32(%rip), %rdi
	jmp	.L878
.L579:
	leaq	.LC75(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L888
	leaq	.LC76(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L583
.L888:
	testq	%r12, %r12
	je	.L578
.L583:
	leaq	.LC77(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L584
	cmpq	$1, %r12
	jbe	.L910
.L586:
	leaq	.LC79(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	movl	%eax, %ebp
	testl	%eax, %eax
	jne	.L589
	cmpq	$2, %r12
	je	.L590
.L585:
	leaq	.LC81(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testq	%r12, %r12
	movl	%eax, %edx
	sete	%al
	movb	%al, 48(%rsp)
	testl	%edx, %edx
	jne	.L593
	testb	%al, %al
	jne	.L873
.L593:
	leaq	.LC82(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L597
	cmpq	$1, %r12
	jbe	.L873
.L596:
	leaq	.LC72(%rip), %rdx
	movq	%r14, %rdi
	movq	%rdx, %rsi
	movq	%rdx, 48(%rsp)
	call	strcmp@PLT
	leaq	.LC72(%rip), %rdx
	testl	%eax, %eax
	je	.L599
.L600:
	leaq	.LC71(%rip), %rsi
	movq	%r14, %rdi
	movq	%rdx, 48(%rsp)
	call	strcmp@PLT
	testq	%r12, %r12
	movl	40(%rsp), %r11d
	movq	48(%rsp), %rdx
	sete	%cl
	testl	%eax, %eax
	sete	%al
	andl	%ecx, %eax
	xorl	$1, %eax
	movzbl	%al, %eax
	andl	%eax, %ebp
	testl	%r11d, %r11d
	jne	.L599
	leaq	.LC70(%rip), %rsi
	movq	%r14, %rdi
	movq	%rdx, 48(%rsp)
	movb	%cl, 40(%rsp)
	call	strcmp@PLT
	movq	48(%rsp), %rdx
	testl	%eax, %eax
	jne	.L700
	movzbl	40(%rsp), %ecx
	testb	%cl, %cl
	je	.L700
.L606:
	testl	%ebp, %ebp
	jne	.L609
	movl	$0, 8(%rsp)
.L608:
	movq	%rbx, %rcx
	movl	$32, %edx
	movl	$1, %esi
	leaq	.LC85(%rip), %rdi
	call	fwrite@PLT
	movq	56(%r15), %rax
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC32(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	orl	%eax, %ebp
	jmp	.L646
.L539:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L541
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movb	$0, 39(%rsp)
	movq	64(%r15), %rdx
	movq	$0, 16(%rsp)
.L542:
	testq	%rdx, %rdx
	je	.L911
	.p2align 4
	.p2align 3
.L674:
	movq	$0, 24(%rsp)
	movq	%r12, %r14
	jmp	.L554
.L634:
	leaq	.LC50(%rip), %rcx
	cmpl	$21, %r8d
	je	.L645
	movl	%r8d, %edi
	call	tk_name@PLT
	movq	%rax, %rcx
.L645:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%r12d, %r8d
	movl	%r12d, %edx
	movq	%rbx, %rdi
	leaq	.LC98(%rip), %rsi
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 48
	xorl	%eax, %eax
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
.L909:
	.cfi_restore_state
	testq	%r12, %r12
	je	.L524
	movq	%r12, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L524:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	jmp	.L878
.L540:
	movq	%r12, %rdi
	call	source_function
	movl	%eax, 32(%rsp)
	testl	%eax, %eax
	jne	.L874
.L669:
	movq	$0, 16(%rsp)
	movq	%r12, %rsi
	movl	$1, %r13d
.L546:
	movq	%rbx, %rdi
	call	emit_function_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	64(%r15), %rdx
	movq	16(%rsp), %rcx
	cmpq	%rdx, %rcx
	setb	%al
	andb	%r13b, %al
	movb	%al, 39(%rsp)
	je	.L671
	movq	56(%r15), %rax
	movq	(%rax,%rcx,8), %rax
	testq	%rax, %rax
	je	.L674
	cmpl	$1, (%rax)
	jne	.L674
	movq	%rdx, %rdi
	movl	$4, %esi
	movq	%rdx, (%rsp)
	movq	48(%rax), %r13
	call	calloc@PLT
	movq	(%rsp), %rdx
	testq	%rax, %rax
	movq	%rax, 24(%rsp)
	je	.L674
	movq	16(%rsp), %rax
	leaq	1(%rax), %rsi
	movzbl	0(%r13), %eax
	testb	%al, %al
	je	.L556
	movq	%r12, (%rsp)
	xorl	%r14d, %r14d
	movq	%rbx, 8(%rsp)
	movq	%rsi, %rbx
	movq	%rbp, 40(%rsp)
	movq	%r13, %rbp
	movq	%rdx, %r13
	.p2align 4
	.p2align 3
.L575:
	cmpb	$37, %al
	jne	.L868
	addq	$1, %r14
	movzbl	0(%rbp,%r14), %r12d
	cmpb	$37, %r12b
	je	.L868
	testb	%r12b, %r12b
	jne	.L558
	jmp	.L863
	.p2align 4,,10
	.p2align 3
.L560:
	addq	$1, %r14
	movzbl	0(%rbp,%r14), %r12d
	testb	%r12b, %r12b
	je	.L559
.L558:
	movsbl	%r12b, %esi
	leaq	.LC74(%rip), %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L560
	cmpb	$42, %r12b
	jne	.L559
	cmpq	%r13, %rbx
	adcq	$0, %rbx
	addq	$1, %r14
	movzbl	0(%rbp,%r14), %edx
.L564:
	cmpb	$46, %dl
	je	.L912
.L566:
	cmpb	$104, %dl
	je	.L913
	cmpb	$108, %dl
	je	.L914
	testb	%dl, %dl
	je	.L863
	leaq	1(%r14), %rax
	cmpb	$115, %dl
	jne	.L572
	cmpq	%r13, %rbx
	jnb	.L572
	movq	24(%rsp), %rcx
	movl	$1, (%rcx,%rbx,4)
	.p2align 4
	.p2align 3
.L572:
	addq	$1, %rbx
.L557:
	movq	%rax, %r14
	movzbl	0(%rbp,%rax), %eax
	testb	%al, %al
	jne	.L575
.L863:
	movq	(%rsp), %r12
	movq	8(%rsp), %rbx
	movq	%r13, %rdx
	movq	40(%rsp), %rbp
.L556:
	movq	%r12, %r14
	jmp	.L554
	.p2align 4,,10
	.p2align 3
.L868:
	leaq	1(%r14), %rax
	jmp	.L557
.L559:
	movzbl	0(%rbp,%r14), %edx
	testb	%dl, %dl
	movb	%dl, 48(%rsp)
	je	.L863
	call	__ctype_b_loc@PLT
	movzbl	48(%rsp), %edx
	movq	(%rax), %rax
	jmp	.L562
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L565:
	addq	$1, %r14
	movzbl	0(%rbp,%r14), %edx
	testb	%dl, %dl
	je	.L863
.L562:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L565
	movzbl	0(%rbp,%r14), %edx
	jmp	.L564
.L913:
	cmpb	$104, 1(%rbp,%r14)
	leaq	1(%r14), %rax
	jne	.L572
.L673:
	leaq	2(%r14), %rax
	jmp	.L572
.L912:
	movzbl	1(%rbp,%r14), %edx
	leaq	1(%r14), %rdi
	movq	%rdi, 48(%rsp)
	cmpb	$42, %dl
	jne	.L915
	cmpq	%r13, %rbx
	adcq	$0, %rbx
	addq	$2, %r14
	movzbl	0(%rbp,%r14), %edx
	jmp	.L566
.L914:
	cmpb	$108, 1(%rbp,%r14)
	leaq	1(%r14), %rax
	jne	.L572
	jmp	.L673
.L907:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L537
	movl	expression_id(%rip), %eax
	leaq	.LC66(%rip), %rsi
	movq	%rbx, %rdi
	leal	1(%rax), %r12d
	xorl	%eax, %eax
	movl	%r12d, %edx
	movl	%r12d, expression_id(%rip)
	call	fprintf@PLT
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_c_string
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC67(%rip), %rdi
	call	fwrite@PLT
	xorl	%ecx, %ecx
	movq	%rbp, %rdx
	movq	%r15, %rsi
	movq	%rbx, %rdi
	movl	%r12d, %r8d
	call	emit_b_call
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC68(%rip), %rdi
	jmp	.L878
.L525:
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC65(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	jmp	.L880
.L541:
	leaq	.LC70(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L544
	leaq	.LC71(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L544
	leaq	.LC72(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L544
	testl	%r13d, %r13d
	je	.L669
	leaq	.LC104(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, 32(%rsp)
	testl	%eax, %eax
	je	.L697
	leaq	.LC105(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, 32(%rsp)
	testl	%eax, %eax
	je	.L697
	leaq	.LC103(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, 32(%rsp)
	testl	%eax, %eax
	je	.L697
	xorl	%edx, %edx
	movl	%edx, 32(%rsp)
.L655:
	leaq	.LC102(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L688
	movq	$2, 16(%rsp)
	movl	$1, %r13d
.L654:
	cmpl	$0, 32(%rsp)
	je	.L916
.L548:
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$6, %edx
	leaq	.LC73(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rax
	movl	$1, 32(%rsp)
	movq	48(%rax), %rsi
	jmp	.L546
.L905:
	movq	%r12, %rdi
	call	get_mangled_name
	leaq	.LC35(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L877
.L544:
	testl	%r13d, %r13d
	je	.L917
	leaq	.LC104(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L696
	leaq	.LC105(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L918
.L696:
	movq	$1, 16(%rsp)
	movl	$1, %r13d
	jmp	.L548
.L584:
	leaq	.LC78(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L586
	cmpq	$1, %r12
	jne	.L586
	leaq	.LC82(%rip), %rsi
	movq	%r14, %rdi
	movl	$1, %ebp
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L597
	cmpl	$0, 40(%rsp)
	jne	.L595
	leaq	.LC72(%rip), %rdx
	movq	%r14, %rdi
	movq	%rdx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L609
	xorl	%eax, %eax
	movl	$1, %ebp
	movl	%eax, 40(%rsp)
	jmp	.L603
	.p2align 4,,10
	.p2align 3
.L915:
	testb	%dl, %dl
	movb	%dl, 56(%rsp)
	je	.L863
	call	__ctype_b_loc@PLT
	movzbl	56(%rsp), %edx
	movq	48(%rsp), %rdi
	movq	(%rax), %rax
	jmp	.L568
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L570:
	addq	$1, %rdi
	movzbl	0(%rbp,%rdi), %edx
	testb	%dl, %dl
	je	.L863
.L568:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L570
	movzbl	0(%rbp,%rdi), %edx
	movq	%rdi, %r14
	jmp	.L566
.L589:
	leaq	.LC80(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L698
	cmpq	$2, %r12
	jne	.L698
.L590:
	leaq	.LC82(%rip), %rsi
	movq	%r14, %rdi
	movl	$1, %ebp
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L596
.L597:
	leaq	.LC72(%rip), %rdx
	movq	%r14, %rdi
	movq	%rdx, %rsi
	movq	%rdx, 56(%rsp)
	call	strcmp@PLT
	leaq	.LC72(%rip), %rdx
	testl	%eax, %eax
	jne	.L600
	movzbl	48(%rsp), %eax
	orl	%eax, %ebp
	cmpl	$0, 40(%rsp)
	jne	.L599
	leaq	.LC70(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L660
	cmpb	$0, 48(%rsp)
	jne	.L606
.L660:
	cmpq	$1, %r12
	jne	.L599
	jmp	.L606
	.p2align 4,,10
	.p2align 3
.L698:
	xorl	%ebp, %ebp
	jmp	.L585
.L908:
	movl	40(%rsp), %r9d
	testl	%r9d, %r9d
	je	.L606
	movq	%rbx, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC83(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 8(%rsp)
	jmp	.L608
.L873:
	movl	40(%rsp), %ebp
	testl	%ebp, %ebp
	jne	.L595
	leaq	.LC70(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testb	$1, %r12b
	jne	.L701
	testl	%eax, %eax
	je	.L609
.L701:
	xorl	%ecx, %ecx
	movl	$1, %ebp
	leaq	.LC72(%rip), %rdx
	movl	%ecx, 40(%rsp)
	jmp	.L649
.L906:
	movq	%r13, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	je	.L531
	cmpl	$0, 24(%r15)
	jne	.L534
	movq	48(%r15), %rax
	cmpl	$2, (%rax)
	movq	48(%rax), %r12
	jne	.L664
	jmp	.L533
.L688:
	movq	$0, 16(%rsp)
	xorl	%r13d, %r13d
	jmp	.L654
.L609:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	movl	$1, %ebp
	leaq	.LC84(%rip), %rdi
	call	fwrite@PLT
	jmp	.L608
.L917:
	xorl	%eax, %eax
	movl	$1, %r13d
	movq	%rax, 16(%rsp)
	jmp	.L548
.L910:
	movl	$1, %ebp
	jmp	.L585
.L647:
	movq	%rbx, %rcx
	movl	$9, %edx
	movl	$1, %esi
	xorl	%ebp, %ebp
	leaq	.LC83(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 8(%rsp)
	jmp	.L608
.L918:
	leaq	.LC103(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L696
	movl	$1, 32(%rsp)
	jmp	.L655
.L697:
	movq	$1, 16(%rsp)
	movq	%r12, %rsi
	movl	$1, %r13d
	jmp	.L546
.L916:
	movq	%r12, %rsi
	jmp	.L546
.L671:
	movb	%r13b, 39(%rsp)
	jmp	.L542
.L865:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L911:
	.cfi_def_cfa_offset 128
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	cmpl	$0, 32(%rsp)
	je	.L502
	jmp	.L880
.L700:
	xorl	%esi, %esi
	movl	%esi, 40(%rsp)
	jmp	.L649
	.cfi_endproc
.LFE49:
	.size	emit_expr, .-emit_expr
	.section	.rodata.str1.1
.LC106:
	.string	"({ word __bcc_callee_%u = "
.LC107:
	.string	"*__bcc_binding_%u"
.LC108:
	.string	"; word __bcc_args_%u[%zu] = {"
	.section	.rodata.str1.8
	.align 8
.LC109:
	.ascii	"}; word __bcc_builtin_result_%u; __b"
	.string	"cc_try_builtin(__bcc_callee_%u, %zu, __bcc_args_%u, &__bcc_builtin_result_%u) ? __bcc_builtin_result_%u : __bcc_is_source_function(__bcc_callee_%u) ? __bcc_invoke_source(__bcc_callee_%u, %zu, __bcc_args_%u) : ((word (*)())B_FUNCTION_CPTR(__bcc_callee_%u))("
	.section	.rodata.str1.1
.LC110:
	.string	"__bcc_args_%u[%zu]"
.LC111:
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
	movq	64(%rsi), %r12
	leaq	.LC106(%rip), %rsi
	movl	%r8d, 12(%rsp)
	leal	1(%rax), %ebp
	xorl	%eax, %eax
	movl	%ebp, %edx
	movl	%ebp, expression_id(%rip)
	call	fprintf@PLT
	movl	12(%rsp), %r8d
	testl	%r8d, %r8d
	jne	.L930
	testq	%r15, %r15
	je	.L922
	movq	%r15, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
.L921:
	testq	%r12, %r12
	movl	$1, %ecx
	movl	%ebp, %edx
	movq	%rbx, %rdi
	cmovne	%r12, %rcx
	leaq	.LC108(%rip), %rsi
	xorl	%eax, %eax
	xorl	%r15d, %r15d
	call	fprintf@PLT
	testq	%r12, %r12
	jne	.L923
	jmp	.L931
	.p2align 4,,10
	.p2align 3
.L932:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC86(%rip), %rdi
	call	fwrite@PLT
.L923:
	movq	56(%r13), %rax
	movq	%r14, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r15,8), %rsi
	addq	$1, %r15
	call	emit_expr
	cmpq	%r15, %r12
	jne	.L932
	subq	$8, %rsp
	.cfi_def_cfa_offset 88
	movl	%ebp, %r9d
	movq	%r12, %r8
	movl	%ebp, %ecx
	pushq	%rbp
	.cfi_def_cfa_offset 96
	movl	%ebp, %edx
	leaq	.LC109(%rip), %rsi
	movq	%rbx, %rdi
	pushq	%rbp
	.cfi_def_cfa_offset 104
	xorl	%eax, %eax
	xorl	%r13d, %r13d
	leaq	.LC110(%rip), %r14
	pushq	%r12
	.cfi_def_cfa_offset 112
	leaq	.LC86(%rip), %r15
	pushq	%rbp
	.cfi_def_cfa_offset 120
	pushq	%rbp
	.cfi_def_cfa_offset 128
	pushq	%rbp
	.cfi_def_cfa_offset 136
	pushq	%rbp
	.cfi_def_cfa_offset 144
	call	fprintf@PLT
	addq	$64, %rsp
	.cfi_def_cfa_offset 80
	jmp	.L926
	.p2align 4,,10
	.p2align 3
.L933:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
.L926:
	movq	%r13, %rcx
	movl	%ebp, %edx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	addq	$1, %r13
	call	fprintf@PLT
	cmpq	%r13, %r12
	jne	.L933
.L924:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC111(%rip), %rdi
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
.L922:
	.cfi_restore_state
	movq	48(%r13), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	jmp	.L921
	.p2align 4,,10
	.p2align 3
.L931:
	movq	%rbx, %rsi
	movl	$48, %edi
	call	fputc@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 88
	movl	%ebp, %r9d
	xorl	%r8d, %r8d
	pushq	%rbp
	.cfi_def_cfa_offset 96
	movl	%ebp, %ecx
	movl	%ebp, %edx
	leaq	.LC109(%rip), %rsi
	pushq	%rbp
	.cfi_def_cfa_offset 104
	movq	%rbx, %rdi
	xorl	%eax, %eax
	pushq	$0
	.cfi_def_cfa_offset 112
	pushq	%rbp
	.cfi_def_cfa_offset 120
	pushq	%rbp
	.cfi_def_cfa_offset 128
	pushq	%rbp
	.cfi_def_cfa_offset 136
	pushq	%rbp
	.cfi_def_cfa_offset 144
	call	fprintf@PLT
	addq	$64, %rsp
	.cfi_def_cfa_offset 80
	jmp	.L924
	.p2align 4,,10
	.p2align 3
.L930:
	movl	%r8d, %edx
	leaq	.LC107(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L921
	.cfi_endproc
.LFE48:
	.size	emit_b_call, .-emit_b_call
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
	je	.L935
	testl	%r13d, %r13d
	jle	.L936
	xorl	%r12d, %r12d
	leaq	.LC26(%rip), %r14
	.p2align 4
	.p2align 3
.L937:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r13d
	jne	.L937
.L936:
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
.L935:
	testl	%r13d, %r13d
	jle	.L938
	xorl	%ebx, %ebx
	leaq	.LC26(%rip), %r14
	.p2align 4
	.p2align 3
.L939:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %r12d
	leal	1(%rbx), %ebx
	cmpl	%ebx, %r13d
	jne	.L939
	xorl	%eax, %eax
	movq	%r15, %rdx
	leaq	.LC114(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L950
.L934:
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
.L950:
	.cfi_restore_state
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L944:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %r12d
	jne	.L944
.L941:
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
.L938:
	.cfi_restore_state
	xorl	%eax, %eax
	movq	%r15, %rdx
	leaq	.LC114(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L934
	jmp	.L941
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
	je	.L953
	jmp	emit_expr
	.p2align 4,,10
	.p2align 3
.L953:
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
	je	.L954
	cmpl	$1, (%rdi)
	je	.L958
.L954:
	ret
	.p2align 4,,10
	.p2align 3
.L958:
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
	je	.L995
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
	je	.L961
	ja	.L962
	testl	%eax, %eax
	je	.L963
	cmpl	$5, %eax
	jne	.L971
	movq	56(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L959
	movl	48(%rbx), %eax
	cmpl	$31, %eax
	je	.L967
	cmpl	$35, %eax
	je	.L968
	.p2align 4
	.p2align 3
.L971:
	xorl	%eax, %eax
.L959:
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
.L962:
	.cfi_restore_state
	cmpl	$10, %eax
	jne	.L971
	movq	48(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L959
	movq	56(%rbx), %rdi
	movq	%rbp, %rsi
	call	try_eval_const_expr
	jmp	.L959
	.p2align 4,,10
	.p2align 3
.L995:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L963:
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
.L961:
	.cfi_restore_state
	movq	56(%rdi), %rdi
	movq	%rsp, %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L971
	movq	64(%rbx), %rdi
	leaq	8(%rsp), %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L971
	movl	48(%rbx), %eax
	subl	$22, %eax
	cmpl	$33, %eax
	ja	.L971
	leaq	.L974(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L974:
	.long	.L987-.L974
	.long	.L986-.L974
	.long	.L985-.L974
	.long	.L984-.L974
	.long	.L983-.L974
	.long	.L982-.L974
	.long	.L971-.L974
	.long	.L971-.L974
	.long	.L981-.L974
	.long	.L980-.L974
	.long	.L979-.L974
	.long	.L978-.L974
	.long	.L977-.L974
	.long	.L971-.L974
	.long	.L971-.L974
	.long	.L971-.L974
	.long	.L971-.L974
	.long	.L971-.L974
	.long	.L971-.L974
	.long	.L971-.L974
	.long	.L971-.L974
	.long	.L971-.L974
	.long	.L971-.L974
	.long	.L971-.L974
	.long	.L971-.L974
	.long	.L971-.L974
	.long	.L971-.L974
	.long	.L971-.L974
	.long	.L971-.L974
	.long	.L971-.L974
	.long	.L971-.L974
	.long	.L976-.L974
	.long	.L975-.L974
	.long	.L973-.L974
	.text
	.p2align 4,,10
	.p2align 3
.L968:
	xorl	%eax, %eax
	cmpq	$0, 8(%rsp)
	sete	%al
	movq	%rax, 0(%rbp)
.L989:
	movl	$1, %eax
	jmp	.L959
.L973:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L989
.L975:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L989
.L976:
	movq	(%rsp), %rax
	andq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L989
.L977:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L971
	movq	(%rsp), %rax
	cmpq	$-1, %rcx
	jne	.L999
	movabsq	$-9223372036854775808, %rdx
	cmpq	%rdx, %rax
	je	.L997
.L999:
	cqto
	idivq	%rcx
.L992:
	movq	%rdx, 0(%rbp)
	jmp	.L989
.L978:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L971
	movq	(%rsp), %rdx
	cmpq	$-1, %rcx
	jne	.L998
	movabsq	$-9223372036854775808, %rax
	cmpq	%rax, %rdx
	je	.L1020
.L998:
	movq	%rdx, %rax
	cqto
	idivq	%rcx
.L1020:
	movq	%rax, 0(%rbp)
	jmp	.L989
.L979:
	movq	(%rsp), %rax
	imulq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L989
.L980:
	movq	(%rsp), %rax
	subq	8(%rsp), %rax
	jmp	.L1020
.L981:
	movq	8(%rsp), %rax
	addq	(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L989
.L982:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setge	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L989
.L983:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setg	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L989
.L984:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setle	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L989
.L985:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setl	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L989
.L986:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L989
.L987:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	sete	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L989
	.p2align 4,,10
	.p2align 3
.L967:
	movq	8(%rsp), %rax
	negq	%rax
	movq	%rax, 0(%rbp)
	jmp	.L989
.L997:
	xorl	%edx, %edx
	jmp	.L992
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
	je	.L1023
	cmpl	$1, (%rdi)
	je	.L1027
.L1023:
	ret
	.p2align 4,,10
	.p2align 3
.L1027:
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
	je	.L1028
	cmpl	$1, (%rdi)
	je	.L1033
.L1028:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L1033:
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
	je	.L1046
	cmpl	$1, (%rdi)
	jne	.L1046
	movq	24(%rdi), %rcx
	movq	16(%rdi), %r8
	testq	%rcx, %rcx
	je	.L1046
	xorl	%edx, %edx
	jmp	.L1047
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1049:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L1046
.L1047:
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L1049
	cmpl	$1, (%rax)
	jne	.L1049
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
.L1050:
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r9
.L1036:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L1053
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L1036
	cmpl	$1, (%rax)
	jne	.L1036
	jmp	.L1050
	.p2align 4,,10
	.p2align 3
.L1046:
	.cfi_def_cfa_offset 8
	movq	%r9, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1053:
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
	je	.L1055
	cmpl	$1, (%rcx)
	movq	%rcx, %r15
	jne	.L1055
	cmpq	$0, 24(%rcx)
	je	.L1055
	movq	%rsi, (%rsp)
	movq	%rdi, %rbx
	movl	%r9d, %ebp
	xorl	%r13d, %r13d
	movq	%r8, 8(%rsp)
.L1068:
	movq	16(%r15), %rax
	movq	(%rax,%r13,8), %r10
	testq	%r10, %r10
	je	.L1063
	movl	(%r10), %eax
	testl	%eax, %eax
	je	.L1087
	cmpl	$1, %eax
	je	.L1088
.L1063:
	addq	$1, %r13
	addq	$1, %r12
	cmpq	24(%r15), %r13
	jb	.L1068
	movq	8(%rsp), %rdx
.L1055:
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
.L1087:
	.cfi_restore_state
	xorl	%r14d, %r14d
	testl	%ebp, %ebp
	jle	.L1061
	movq	%r12, 16(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L1058:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC26(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1058
	movq	16(%rsp), %r12
	movq	%r14, %r10
.L1061:
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
	je	.L1089
	movq	96(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L1062:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1063
	.p2align 4,,10
	.p2align 3
.L1088:
	movq	24(%r10), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmovne	%rax, %rdx
	xorl	%r14d, %r14d
	movq	%rdx, 16(%rsp)
	testl	%ebp, %ebp
	jle	.L1067
	movq	%r12, 24(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L1064:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC26(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1064
	movq	24(%rsp), %r12
	movq	%r14, %r10
.L1067:
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
	jne	.L1065
	movq	24(%r10), %rsi
	movq	16(%r10), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, 8(%rsp)
.L1065:
	movq	8(%rsp), %rax
	cmpq	%rdx, %rax
	cmovnb	%rax, %rdx
	movq	%rdx, 8(%rsp)
	jmp	.L1063
	.p2align 4,,10
	.p2align 3
.L1089:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1062
	.cfi_endproc
.LFE56:
	.size	emit_edge_list_init, .-emit_edge_list_init
	.section	.rodata.str1.8
	.align 8
.LC119:
	.string	"static void __attribute__((constructor(101))) __b_register_globals(void) {\n"
	.section	.rodata.str1.1
.LC120:
	.string	"}\n"
	.section	.rodata.str1.8
	.align 8
.LC121:
	.string	"    (void)B_PTR_N(%s, sizeof(%s));\n"
	.align 8
.LC122:
	.string	"    (void)B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.align 8
.LC123:
	.string	"static void __attribute__((constructor(102))) __bcc_bind_functions(void) {\n"
	.align 8
.LC124:
	.string	"static void __b_initialize_globals(void) {\n"
	.section	.rodata.str1.1
.LC125:
	.string	"    "
.LC126:
	.string	" = B_FUNCTION("
	.section	.rodata.str1.8
	.align 8
.LC127:
	.string	"    static struct __bcc_source_function __bcc_function_%zu = {(void*)"
	.align 8
.LC128:
	.string	", 0, 0};\n    __bcc_register_function(&__bcc_function_%zu);\n"
	.align 8
.LC129:
	.string	"    static struct __bcc_library_binding __bcc_binding_%zu = {"
	.align 8
.LC130:
	.string	", 0, 0};\n    __bcc_register_binding(&__bcc_binding_%zu);\n"
	.align 8
.LC131:
	.string	"    static struct __bcc_library_binding __bcc_data_%zu = {"
	.align 8
.LC132:
	.string	", 0, 0};\n    __bcc_register_binding(&__bcc_data_%zu);\n"
	.align 8
.LC133:
	.string	"}\nstatic struct __bcc_initializer __bcc_module = {__b_initialize_globals, 0, 0};\nstatic void __attribute__((constructor(102))) __bcc_register_module(void) {\n    __bcc_register_initializer(&__bcc_module);\n}\n\n"
	.align 8
.LC134:
	.string	"    %s[0] = B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC135:
	.string	"__%s_store"
.LC136:
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
	leaq	.LC120(%rip), %rax
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
	je	.L1155
.L1091:
	movq	%rbx, %rcx
	movl	$75, %edx
	movl	$1, %esi
	xorl	%ebp, %ebp
	leaq	.LC123(%rip), %rdi
	leaq	.LC125(%rip), %r15
	call	fwrite@PLT
	cmpq	$0, 8(%r14)
	leaq	.LC126(%rip), %r13
	jne	.L1098
	jmp	.L1104
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1101:
	movq	8(%r14), %rax
	addq	$1, %rbp
	cmpq	%rax, %rbp
	jnb	.L1156
.L1098:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %r12
	cmpl	$1, (%r12)
	jne	.L1101
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r12), %rax
	movq	(%rax), %rdi
	testq	%rdi, %rdi
	je	.L1102
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1102:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
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
	leaq	.LC24(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC127(%rip), %rsi
	call	fprintf@PLT
	movq	8(%r12), %rax
	movq	%rbx, %rdi
	movq	(%rax), %rsi
	call	emit_function_body_name
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC128(%rip), %rsi
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC129(%rip), %rsi
	call	fprintf@PLT
	movq	8(%r12), %rax
	movq	%rbx, %rdi
	movq	(%rax), %rsi
	call	emit_c_string
	leaq	.LC86(%rip), %rdi
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r12), %rax
	movq	(%rax), %rdi
	testq	%rdi, %rdi
	je	.L1103
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1103:
	movq	%rbp, %rdx
	leaq	.LC130(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	8(%r14), %rax
	addq	$1, %rbp
	cmpq	%rax, %rbp
	jb	.L1098
.L1156:
	testq	%rax, %rax
	je	.L1104
	xorl	%r15d, %r15d
	leaq	.LC86(%rip), %r13
	leaq	.LC132(%rip), %r12
	.p2align 4
	.p2align 3
.L1107:
	movq	(%r14), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$2, (%rax)
	jne	.L1105
	movq	8(%rax), %rax
	movl	4(%rax), %edi
	testl	%edi, %edi
	jne	.L1105
	movq	16(%rax), %rbp
	movq	%r15, %rdx
	leaq	.LC131(%rip), %rsi
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
	je	.L1106
	movq	%rbp, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1106:
	movq	%r15, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L1105:
	addq	$1, %r15
	cmpq	8(%r14), %r15
	jb	.L1107
.L1104:
	movq	(%rsp), %rdi
	movq	%rbx, %rcx
	movl	$2, %edx
	xorl	%ebp, %ebp
	movl	$1, %esi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC124(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%r14)
	jne	.L1099
	jmp	.L1100
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1109:
	addq	$1, %rbp
	cmpq	8(%r14), %rbp
	jnb	.L1100
.L1099:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$2, (%rax)
	jne	.L1109
	movq	8(%rax), %r12
	movq	16(%r12), %rdi
	call	get_mangled_name
	cmpl	$2, 24(%r12)
	movq	56(%r12), %r13
	movq	%rax, %r15
	je	.L1157
	testq	%r13, %r13
	je	.L1109
	movl	0(%r13), %eax
	cmpl	$1, %eax
	je	.L1158
	testl	%eax, %eax
	jne	.L1109
	leaq	.LC136(%rip), %rsi
	movq	%r15, %rdx
	movq	%rbx, %rdi
	call	fprintf@PLT
	movq	16(%r13), %rsi
	cmpl	$2, (%rsi)
	je	.L1159
	movq	8(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L1117:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addq	$1, %rbp
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r14), %rbp
	jb	.L1099
.L1100:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$207, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC133(%rip), %rdi
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
.L1157:
	.cfi_restore_state
	movq	%rax, %r8
	movq	%rax, %rcx
	movq	%rax, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC134(%rip), %rsi
	call	fprintf@PLT
	testq	%r13, %r13
	je	.L1109
	cmpl	$1, 0(%r13)
	jne	.L1109
	movq	%r15, %rsi
	leaq	.LC135(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	xorl	%r8d, %r8d
	movq	%rax, %rsi
	movq	56(%r12), %rax
	testq	%rax, %rax
	je	.L1112
	cmpl	$1, (%rax)
	je	.L1160
.L1112:
	cmpq	$0, 32(%r12)
	je	.L1113
	movq	48(%r12), %rax
	movq	%r8, %rdx
	cmpq	%rax, %r8
	cmovb	%rax, %r8
	testq	%rax, %rax
	cmovle	%rdx, %r8
.L1113:
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
	jmp	.L1109
	.p2align 4,,10
	.p2align 3
.L1158:
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
	jmp	.L1109
	.p2align 4,,10
	.p2align 3
.L1155:
	movq	%rdi, %rcx
	movl	$75, %edx
	movl	$1, %esi
	xorl	%ebp, %ebp
	leaq	.LC119(%rip), %rdi
	leaq	.LC121(%rip), %r12
	call	fwrite@PLT
	cmpq	$0, 8(%r14)
	jne	.L1092
	.p2align 4
	.p2align 3
.L1097:
	leaq	.LC120(%rip), %rax
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, (%rsp)
	call	fwrite@PLT
	jmp	.L1091
	.p2align 4,,10
	.p2align 3
.L1163:
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
	je	.L1161
.L1094:
	addq	$1, %rbp
	cmpq	8(%r14), %rbp
	jnb	.L1097
.L1092:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L1162
	cmpl	$2, %eax
	jne	.L1094
	jmp	.L1163
	.p2align 4,,10
	.p2align 3
.L1161:
	movq	%r13, %rcx
	movq	%r13, %rdx
	leaq	.LC122(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1094
	.p2align 4,,10
	.p2align 3
.L1162:
	movq	8(%rdx), %rax
	movq	(%rax), %rdi
	call	get_mangled_name
	movq	%r12, %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1094
	.p2align 4,,10
	.p2align 3
.L1159:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1117
.L1160:
	movq	24(%rax), %r8
	jmp	.L1112
	.cfi_endproc
.LFE65:
	.size	emit_global_initializers, .-emit_global_initializers
	.section	.rodata.str1.1
.LC137:
	.string	"<"
.LC138:
	.string	"<="
.LC139:
	.string	">"
.LC140:
	.string	">="
.LC141:
	.string	"??"
.LC142:
	.string	"while ("
.LC143:
	.string	")\n"
.LC144:
	.string	"if ("
.LC145:
	.string	"{ word __bcc_target = "
.LC146:
	.string	"continue;\n"
.LC147:
	.string	"break;\n"
.LC148:
	.string	"return"
.LC149:
	.string	"{\n"
.LC150:
	.string	"return "
	.section	.rodata.str1.8
	.align 8
.LC151:
	.string	"%s = B_LOCAL_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC152:
	.string	"else\n"
.LC153:
	.string	" 0"
	.section	.rodata.str1.8
	.align 8
.LC154:
	.string	"if (__bcc_target == __bcc_label_target_%zu) goto __b_label_%zu;\n"
	.align 8
.LC155:
	.string	"fputs(\"bcc: invalid label value\\n\", stderr); abort();\n"
	.section	.rodata.str1.1
.LC156:
	.string	"__bsw%d_case%zu"
.LC157:
	.string	"for(;;) {\n"
.LC158:
	.string	"word __sw = "
.LC159:
	.string	"__bsw%d_end"
.LC160:
	.string	"goto __bsw%d_dispatch;\n"
.LC161:
	.string	"goto __bsw%d_end;\n"
.LC162:
	.string	"__sw %s (word)%ld"
	.section	.rodata.str1.8
	.align 8
.LC163:
	.string	"(__sw >= (word)%ld && __sw <= (word)%ld)"
	.section	.rodata.str1.1
.LC164:
	.string	"__sw == (word)%ld"
.LC165:
	.string	") goto "
.LC166:
	.string	"__bsw%d_end:\n"
.LC167:
	.string	"__b_label_%d:\n"
.LC168:
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
.L1165:
	movl	g_no_line(%rip), %r10d
	testl	%r10d, %r10d
	jne	.L1166
	cmpb	$0, 24(%rsp)
	jne	.L1450
.L1166:
	cmpl	$12, (%rbx)
	ja	.L1164
	movl	(%rbx), %eax
	leaq	.L1169(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1169:
	.long	.L1180-.L1169
	.long	.L1179-.L1169
	.long	.L1178-.L1169
	.long	.L1177-.L1169
	.long	.L1176-.L1169
	.long	.L1175-.L1169
	.long	.L1174-.L1169
	.long	.L1164-.L1169
	.long	.L1173-.L1169
	.long	.L1172-.L1169
	.long	.L1171-.L1169
	.long	.L1170-.L1169
	.long	.L1168-.L1169
	.text
	.p2align 4,,10
	.p2align 3
.L1450:
	movl	4(%rbx), %edx
	movq	16(%rsp), %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC27(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1166
	.p2align 4,,10
	.p2align 3
.L1168:
	movl	g_switch_id(%rip), %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	leaq	.LC156(%rip), %r12
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
	je	.L1250
	movq	%rbx, 56(%rsp)
	movq	24(%rsp), %r13
	movq	%r14, 48(%rsp)
	movq	%rbp, %r14
	movq	40(%rsp), %rbp
	.p2align 4
	.p2align 3
.L1247:
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
	jb	.L1247
	movq	48(%rsp), %r14
	movq	56(%rsp), %rbx
.L1250:
	movl	8(%rsp), %edx
	movl	8(%rsp), %r12d
	xorl	%ebp, %ebp
	leaq	.LC26(%rip), %r13
	testl	%edx, %edx
	jle	.L1451
	.p2align 4
	.p2align 3
.L1248:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1248
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC157(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r12d
.L1251:
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 48(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1254:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1254
	movq	48(%rsp), %rbx
	movq	%r14, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC158(%rip), %rdi
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
	leaq	.LC159(%rip), %rdx
	movl	$64, %esi
	call	snprintf@PLT
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 56(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1255:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1255
	movl	32(%rsp), %edx
	leaq	.LC160(%rip), %rsi
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
.L1256:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1256
	leaq	.LC161(%rip), %rax
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
.L1257:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1257
	movl	32(%rsp), %edx
	xorl	%eax, %eax
	leaq	.LC168(%rip), %rsi
	movq	%r14, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r15)
	leal	2(%rax), %ebx
	je	.L1259
.L1296:
	leaq	.LC144(%rip), %rax
	movq	%r15, 16(%rsp)
	xorl	%edi, %edi
	leaq	.LC26(%rip), %rbp
	movq	%rax, 56(%rsp)
	movl	%r12d, 76(%rsp)
	movq	%rdi, %r12
	.p2align 4
	.p2align 3
.L1273:
	movq	16(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r12,8), %r13
	movq	40(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1322
	xorl	%eax, %eax
	jmp	.L1264
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1263:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1322
.L1264:
	movq	(%rsi,%rax,8), %rdx
	cmpq	(%rdx), %r13
	jne	.L1263
	movq	8(%rdx), %rax
	movq	%rax, 24(%rsp)
.L1262:
	xorl	%r15d, %r15d
	testl	%ebx, %ebx
	jle	.L1268
	.p2align 4
	.p2align 3
.L1265:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebx, %r15d
	jne	.L1265
.L1268:
	movq	56(%rsp), %rdi
	movl	$1, %esi
	movq	%r14, %rcx
	movl	$4, %edx
	call	fwrite@PLT
	movl	20(%r13), %eax
	movq	24(%r13), %rsi
	testl	%eax, %eax
	je	.L1452
	leaq	.LC139(%rip), %rdx
	cmpl	$26, %eax
	je	.L1269
	ja	.L1270
	leaq	.LC137(%rip), %rdx
	cmpl	$24, %eax
	je	.L1269
	cmpl	$25, %eax
	leaq	.LC141(%rip), %rdx
	leaq	.LC138(%rip), %rax
	cmove	%rax, %rdx
.L1269:
	movq	%rsi, %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC162(%rip), %rsi
	call	fprintf@PLT
.L1271:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC165(%rip), %rdi
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
	jb	.L1273
	movl	76(%rsp), %r12d
	leaq	.LC26(%rip), %r13
	testl	%ebx, %ebx
	jle	.L1453
.L1259:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1275:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1275
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	testl	%r12d, %r12d
	jle	.L1426
	movl	8(%rsp), %r12d
	.p2align 4
	.p2align 3
.L1276:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jg	.L1276
.L1426:
	movl	32(%rsp), %edx
	leaq	.LC166(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
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
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	xorl	%ebx, %ebx
	leaq	.LC147(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	jle	.L1282
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
.L1282:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
.L1164:
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
.L1180:
	.cfi_restore_state
	movl	%r12d, %ebp
	xorl	%ebx, %ebx
	leaq	.LC26(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1449
	.p2align 4
	.p2align 3
.L1204:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1204
.L1449:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
.L1448:
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
.L1179:
	.cfi_restore_state
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%r12d, %r12d
	movl	8(%rsp), %r15d
	leaq	.LC26(%rip), %r13
	testl	%eax, %eax
	jle	.L1454
	.p2align 4
	.p2align 3
.L1202:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1202
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC149(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L1208
.L1207:
	movl	8(%rsp), %edi
	xorl	%r13d, %r13d
	addl	$1, %edi
	movl	%edi, 40(%rsp)
.L1215:
	movq	16(%rbx), %rdx
	movq	(%rdx,%r13,8), %r12
	testl	%ebp, %ebp
	je	.L1311
	subq	$1, %rax
	xorl	%ecx, %ecx
	cmpq	%r13, %rax
	je	.L1455
.L1210:
	movq	16(%rsp), %r8
	movl	40(%rsp), %edx
	movq	%r12, %rsi
	movq	%r14, %rdi
	call	emit_stmt
.L1213:
	movq	24(%rbx), %rax
	addq	$1, %r13
	cmpq	%rax, %r13
	jb	.L1215
	movl	8(%rsp), %r9d
	leaq	.LC26(%rip), %r13
	testl	%r9d, %r9d
	jle	.L1217
.L1208:
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1218:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1218
.L1217:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	jmp	.L1448
	.p2align 4,,10
	.p2align 3
.L1178:
	xorl	%r13d, %r13d
	cmpq	$0, 24(%rbx)
	movl	%r12d, 8(%rsp)
	leaq	.LC26(%rip), %rbp
	movl	8(%rsp), %r12d
	je	.L1164
	.p2align 4
	.p2align 3
.L1201:
	movq	16(%rbx), %rax
	movq	(%rax,%r13,8), %r15
	movq	(%r15), %rdi
	call	get_mangled_name
	movl	g_strict(%rip), %esi
	movq	%rax, 8(%rsp)
	testl	%esi, %esi
	je	.L1456
	cmpq	$0, 8(%r15)
	je	.L1293
.L1292:
	xorl	%r15d, %r15d
	testl	%r12d, %r12d
	jle	.L1223
	.p2align 4
	.p2align 3
.L1221:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1221
.L1223:
	movq	8(%rsp), %rcx
	leaq	.LC151(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	movq	%rcx, %r8
	movq	%rcx, %rdx
	call	fprintf@PLT
.L1222:
	addq	$1, %r13
	cmpq	24(%rbx), %r13
	jb	.L1201
	jmp	.L1164
	.p2align 4,,10
	.p2align 3
.L1177:
	xorl	%r15d, %r15d
	leaq	.LC26(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1227
	.p2align 4
	.p2align 3
.L1187:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1187
.L1227:
	movq	%r14, %rcx
	movl	$4, %edx
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
	leaq	.LC143(%rip), %rdi
	call	fwrite@PLT
	testl	%ebp, %ebp
	jne	.L1188
.L1189:
	movq	24(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L1228
	cmpl	$1, (%rsi)
	movl	%r12d, %edx
	je	.L1229
.L1228:
	leal	1(%r12), %edx
.L1229:
	movq	16(%rsp), %r8
	movl	%ebp, %ecx
	movq	%r14, %rdi
	call	emit_stmt
	cmpq	$0, 32(%rbx)
	je	.L1164
	xorl	%ebp, %ebp
	leaq	.LC26(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1233
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
.L1233:
	movq	%r14, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC152(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L1185
	jmp	.L1186
	.p2align 4,,10
	.p2align 3
.L1176:
	xorl	%ebp, %ebp
	leaq	.LC26(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1235
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
.L1235:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC142(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC143(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L1186
.L1185:
	cmpl	$1, (%rbx)
	je	.L1234
.L1186:
	addl	$1, %r12d
.L1234:
	xorl	%ebp, %ebp
	jmp	.L1165
	.p2align 4,,10
	.p2align 3
.L1175:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	movl	8(%rsp), %r12d
	leaq	.LC26(%rip), %r13
	testl	%eax, %eax
	jle	.L1236
	.p2align 4
	.p2align 3
.L1198:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1198
.L1236:
	movq	%r14, %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%rbx)
	je	.L1457
	movq	%r14, %rsi
	movl	$32, %edi
	call	fputc@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	jmp	.L1449
	.p2align 4,,10
	.p2align 3
.L1173:
	movl	%r12d, 8(%rsp)
	xorl	%ebx, %ebx
	movl	8(%rsp), %ebp
	leaq	.LC26(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1238
	.p2align 4
	.p2align 3
.L1194:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1194
.L1238:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC147(%rip), %rdi
	jmp	.L1448
	.p2align 4,,10
	.p2align 3
.L1174:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%r12d, %r12d
	movl	8(%rsp), %r15d
	leaq	.LC26(%rip), %r13
	testl	%eax, %eax
	jle	.L1237
	.p2align 4
	.p2align 3
.L1195:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1195
.L1237:
	testl	%ebp, %ebp
	jne	.L1458
.L1197:
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	jmp	.L1449
	.p2align 4,,10
	.p2align 3
.L1171:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	movl	8(%rsp), %r12d
	leaq	.LC26(%rip), %r13
	testl	%eax, %eax
	jle	.L1240
	.p2align 4
	.p2align 3
.L1190:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1190
.L1240:
	movq	%r14, %rcx
	movl	$22, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC145(%rip), %rdi
	leaq	.LC154(%rip), %r13
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	%r14, %rdi
	movq	16(%rsp), %rdx
	leaq	.LC26(%rip), %rbp
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	movl	8(%rsp), %r15d
	je	.L1192
	.p2align 4
	.p2align 3
.L1191:
	xorl	%ebx, %ebx
	testl	%r15d, %r15d
	js	.L1242
	.p2align 4
	.p2align 3
.L1241:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r15d
	jge	.L1241
.L1242:
	addq	$1, %r12
	xorl	%eax, %eax
	movq	%r13, %rsi
	movq	%r14, %rdi
	movq	%r12, %rcx
	movq	%r12, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %r12
	jb	.L1191
.L1192:
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	js	.L1243
	xorl	%ebx, %ebx
	leaq	.LC26(%rip), %r13
	.p2align 4
	.p2align 3
.L1244:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jge	.L1244
	movq	%r14, %rcx
	movl	$54, %edx
	movl	$1, %esi
	leaq	.LC155(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	je	.L1217
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1246:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1246
	jmp	.L1217
	.p2align 4,,10
	.p2align 3
.L1172:
	movl	%r12d, 8(%rsp)
	xorl	%ebx, %ebx
	movl	8(%rsp), %ebp
	leaq	.LC26(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1239
	.p2align 4
	.p2align 3
.L1193:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1193
.L1239:
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC146(%rip), %rdi
	jmp	.L1448
	.p2align 4,,10
	.p2align 3
.L1170:
	xorl	%ebp, %ebp
	leaq	.LC26(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1459
	.p2align 4
	.p2align 3
.L1181:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1181
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 8(%rsp)
	testq	%rbp, %rbp
	je	.L1460
.L1182:
	movq	function_labels(%rip), %r15
	xorl	%r13d, %r13d
	jmp	.L1288
	.p2align 4,,10
	.p2align 3
.L1286:
	addq	$1, %r13
	cmpq	%rbp, %r13
	je	.L1183
.L1288:
	movq	(%r15,%r13,8), %rsi
	movq	8(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1286
	leal	1(%r13), %edx
.L1287:
	leaq	.LC167(%rip), %rsi
	movq	%r14, %rdi
	leal	1(%r12), %r15d
	xorl	%eax, %eax
	call	fprintf@PLT
	leaq	.LC26(%rip), %r13
	testl	%r15d, %r15d
	jle	.L1291
.L1289:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1290:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jne	.L1290
.L1291:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movl	%r15d, %r12d
	leaq	.LC117(%rip), %rdi
	xorl	%ebp, %ebp
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	jmp	.L1165
	.p2align 4,,10
	.p2align 3
.L1322:
	movq	$0, 24(%rsp)
	jmp	.L1262
	.p2align 4,,10
	.p2align 3
.L1452:
	movl	16(%r13), %eax
	testl	%eax, %eax
	je	.L1272
	movq	32(%r13), %rcx
	movq	%rsi, %rdx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC163(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1271
	.p2align 4,,10
	.p2align 3
.L1456:
	movq	16(%rsp), %rcx
	movl	%r12d, %edx
	movq	%r15, %rsi
	movq	%r14, %rdi
	call	emit_auto_storage
	cmpq	$0, 8(%r15)
	jne	.L1292
	movl	g_strict(%rip), %ecx
	testl	%ecx, %ecx
	je	.L1222
	.p2align 4
	.p2align 3
.L1293:
	xorl	%r15d, %r15d
	testl	%r12d, %r12d
	jle	.L1225
	.p2align 4
	.p2align 3
.L1224:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1224
.L1225:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1222
.L1455:
	cmpl	$6, (%r12)
	movl	%ebp, %ecx
	jne	.L1210
	movl	g_no_line(%rip), %r8d
	testl	%r8d, %r8d
	jne	.L1211
	cmpb	$0, 24(%rsp)
	je	.L1211
	movl	4(%r12), %edx
	movq	16(%rsp), %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC27(%rip), %rsi
	call	fprintf@PLT
.L1211:
	movl	8(%rsp), %edi
	leaq	.LC26(%rip), %rax
	xorl	%r15d, %r15d
	movq	%rax, 32(%rsp)
	testl	%edi, %edi
	js	.L1214
	.p2align 4
	.p2align 3
.L1212:
	movq	32(%rsp), %rdi
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r15d
	call	fwrite@PLT
	cmpl	%r15d, 8(%rsp)
	jge	.L1212
.L1214:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC150(%rip), %rdi
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
	jmp	.L1213
	.p2align 4,,10
	.p2align 3
.L1272:
	movq	%rsi, %rdx
	movq	%r14, %rdi
	leaq	.LC164(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1271
	.p2align 4,,10
	.p2align 3
.L1311:
	xorl	%ecx, %ecx
	jmp	.L1210
	.p2align 4,,10
	.p2align 3
.L1270:
	cmpl	$27, %eax
	leaq	.LC141(%rip), %rdx
	leaq	.LC140(%rip), %rax
	cmove	%rax, %rdx
	jmp	.L1269
.L1188:
	xorl	%ebp, %ebp
	cmpq	$0, 32(%rbx)
	sete	%bpl
	jmp	.L1189
.L1453:
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	xorl	%eax, %eax
	movq	%r14, %rdi
	call	fprintf@PLT
	testl	%r12d, %r12d
	jle	.L1447
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
.L1447:
	movl	32(%rsp), %edx
	movq	%r14, %rdi
	leaq	.LC166(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC147(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1282
.L1459:
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 8(%rsp)
	testq	%rbp, %rbp
	jne	.L1182
.L1183:
	xorl	%edx, %edx
	jmp	.L1287
.L1458:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC150(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1197
.L1457:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC153(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1449
.L1243:
	movq	%r14, %rcx
	movl	$54, %edx
	movl	$1, %esi
	leaq	.LC155(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1217
.L1454:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC149(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	jne	.L1207
	jmp	.L1217
.L1451:
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC157(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r12d
	testl	%eax, %eax
	je	.L1251
	movq	%r14, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC158(%rip), %rdi
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
	leaq	.LC159(%rip), %rdx
	movl	$64, %esi
	movl	%ebp, %ecx
	call	snprintf@PLT
	movl	%ebp, %edx
	leaq	.LC160(%rip), %rsi
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
	leaq	.LC161(%rip), %rax
	movq	%rax, %rsi
	movq	%rax, 64(%rsp)
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%eax, %eax
	movl	%ebp, %edx
	leaq	.LC168(%rip), %rsi
	movq	%r14, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r15)
	leal	2(%rax), %ebx
	jne	.L1296
	cmpl	$1, %ebx
	je	.L1259
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1447
	.p2align 4,,10
	.p2align 3
.L1460:
	xorl	%edx, %edx
	leaq	.LC167(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%r12), %r15d
	jmp	.L1289
	.cfi_endproc
.LFE59:
	.size	emit_stmt, .-emit_stmt
	.section	.rodata.str1.1
.LC169:
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
	leaq	.L1466(%rip), %r15
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
	je	.L1461
.L1462:
	cmpl	$13, 0(%r13)
	ja	.L1464
	movl	0(%r13), %eax
	movslq	(%r15,%rax,4), %rax
	addq	%r15, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1466:
	.long	.L1464-.L1466
	.long	.L1470-.L1466
	.long	.L1464-.L1466
	.long	.L1469-.L1466
	.long	.L1468-.L1466
	.long	.L1464-.L1466
	.long	.L1464-.L1466
	.long	.L1464-.L1466
	.long	.L1464-.L1466
	.long	.L1464-.L1466
	.long	.L1464-.L1466
	.long	.L1467-.L1466
	.long	.L1464-.L1466
	.long	.L1465-.L1466
	.text
	.p2align 4,,10
	.p2align 3
.L1464:
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
.L1465:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1514
	xorl	%eax, %eax
	jmp	.L1484
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1483:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1514
.L1484:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%r13, (%rdx)
	jne	.L1483
	movq	8(%rdx), %r14
.L1482:
	xorl	%r13d, %r13d
	leaq	.LC26(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1548
	.p2align 4
	.p2align 3
.L1485:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1485
	movq	%r14, %rdx
	leaq	.LC169(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1488:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jle	.L1488
.L1487:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	jmp	.L1547
	.p2align 4,,10
	.p2align 3
.L1467:
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1549
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
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L1550
.L1472:
	movq	function_labels(%rip), %r14
	xorl	%r12d, %r12d
	jmp	.L1492
	.p2align 4,,10
	.p2align 3
.L1490:
	addq	$1, %r12
	cmpq	%r12, 24(%rsp)
	je	.L1473
.L1492:
	movq	(%r14,%r12,8), %rsi
	movq	16(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1490
	leal	1(%r12), %edx
.L1491:
	leaq	.LC167(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	leaq	.LC26(%rip), %r12
	movl	%eax, 16(%rsp)
	testl	%eax, %eax
	jle	.L1551
.L1493:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1495:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, %ebp
	jne	.L1495
	movl	16(%rsp), %ebp
.L1496:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	jne	.L1462
	jmp	.L1461
	.p2align 4,,10
	.p2align 3
.L1468:
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1508
	.p2align 4
	.p2align 3
.L1474:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1474
.L1508:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC142(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC143(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	je	.L1461
.L1475:
	xorl	%eax, %eax
	cmpl	$1, 0(%r13)
	setne	%al
	addl	%eax, %ebp
	jmp	.L1462
	.p2align 4,,10
	.p2align 3
.L1469:
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1503
	.p2align 4
	.p2align 3
.L1477:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1477
.L1503:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC144(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC143(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %rsi
	testq	%rsi, %rsi
	je	.L1479
	cmpl	$1, (%rsi)
	movl	%ebp, %edx
	je	.L1504
.L1479:
	leal	1(%rbp), %edx
.L1504:
	movq	(%rsp), %r8
	movq	8(%rsp), %rcx
	movq	%rbx, %rdi
	call	emit_stmt_switchctx
	cmpq	$0, 32(%r13)
	je	.L1461
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1507
	.p2align 4
	.p2align 3
.L1505:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1505
.L1507:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC152(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r13), %r13
	testq	%r13, %r13
	jne	.L1475
.L1461:
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
.L1470:
	.cfi_restore_state
	xorl	%r15d, %r15d
	leaq	.LC26(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1552
	.p2align 4
	.p2align 3
.L1480:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebp, %r15d
	jne	.L1480
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC149(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	je	.L1498
.L1497:
	leal	1(%rbp), %r12d
	xorl	%r15d, %r15d
.L1500:
	movq	16(%r13), %rax
	movq	(%rsp), %r8
	movl	%r12d, %edx
	movq	%rbx, %rdi
	movq	8(%rsp), %rcx
	movq	(%rax,%r15,8), %rsi
	addq	$1, %r15
	call	emit_stmt_switchctx
	cmpq	24(%r13), %r15
	jb	.L1500
	leaq	.LC26(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1499
.L1498:
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1502:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1502
.L1499:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
.L1547:
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
.L1514:
	.cfi_restore_state
	xorl	%r14d, %r14d
	jmp	.L1482
	.p2align 4,,10
	.p2align 3
.L1549:
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	jne	.L1472
	.p2align 4
	.p2align 3
.L1473:
	xorl	%edx, %edx
	jmp	.L1491
.L1550:
	xorl	%edx, %edx
	leaq	.LC167(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	movl	%eax, 16(%rsp)
	jmp	.L1493
	.p2align 4,,10
	.p2align 3
.L1548:
	xorl	%eax, %eax
	movq	%r14, %rdx
	leaq	.LC169(%rip), %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	testl	%ebp, %ebp
	jne	.L1487
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	jmp	.L1487
	.p2align 4,,10
	.p2align 3
.L1551:
	movl	%eax, %ebp
	jmp	.L1496
	.p2align 4,,10
	.p2align 3
.L1552:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC149(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	jne	.L1497
	jmp	.L1499
	.cfi_endproc
.LFE46:
	.size	emit_stmt_switchctx, .-emit_stmt_switchctx
	.section	.rodata.str1.1
.LC170:
	.string	"static "
.LC171:
	.string	""
	.section	.rodata.str1.8
	.align 8
.LC172:
	.string	"#ifndef %s\nextern word %s[];\n#define __b_external_%s (%s[0])\n#else\n#define __b_external_%s (%s)\n#endif\n"
	.section	.rodata.str1.1
.LC173:
	.string	"extern word %s[];\n"
.LC174:
	.string	"%sword %s[%zu];\n"
.LC175:
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
	movq	%rdx, 8(%rsp)
	je	.L1553
	movq	%rdi, %rbp
	movq	%rsi, %r12
	xorl	%ebx, %ebx
	jmp	.L1567
	.p2align 4,,10
	.p2align 3
.L1556:
	addq	$1, %rbx
	cmpq	8(%r12), %rbx
	jnb	.L1553
.L1567:
	movq	(%r12), %rax
	movq	(%rax,%rbx,8), %r14
	movl	(%r14), %eax
	testl	%eax, %eax
	je	.L1585
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L1556
	movq	8(%r14), %r13
	movq	16(%r13), %rdi
	call	get_mangled_name
	cmpl	$3, (%r14)
	movq	%rax, %r15
	je	.L1586
	cmpl	$1, 24(%r13)
	movl	$1, %r8d
	jne	.L1561
	movq	56(%r13), %rdi
	movl	$1, %r11d
	testq	%rdi, %rdi
	je	.L1562
	cmpl	$1, (%rdi)
	je	.L1587
.L1562:
	call	edge_tail_words_top
	leaq	(%rax,%r11), %r8
	movl	$1, %eax
	testq	%r8, %r8
	cmove	%rax, %r8
.L1561:
	movl	4(%r13), %eax
	leaq	.LC171(%rip), %rdx
	testl	%eax, %eax
	je	.L1563
	leaq	.LC170(%rip), %rdx
.L1563:
	xorl	%eax, %eax
	movq	%r15, %rcx
	leaq	.LC174(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$2, 24(%r13)
	jne	.L1556
	movq	56(%r13), %rdi
	xorl	%r11d, %r11d
	testq	%rdi, %rdi
	je	.L1564
	cmpl	$1, (%rdi)
	je	.L1588
.L1564:
	cmpq	$0, 32(%r13)
	je	.L1565
	movq	48(%r13), %rax
	movq	%r11, %rdx
	cmpq	%rax, %r11
	cmovb	%rax, %r11
	testq	%rax, %rax
	cmovle	%rdx, %r11
.L1565:
	call	edge_tail_words_top
	movq	%r15, %rdx
	leaq	.LC175(%rip), %rsi
	movq	%rbp, %rdi
	leaq	(%rax,%r11), %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	xorl	%eax, %eax
	addq	$1, %rbx
	call	fprintf@PLT
	cmpq	8(%r12), %rbx
	jb	.L1567
.L1553:
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
.L1585:
	.cfi_restore_state
	movq	8(%r14), %rsi
	movq	8(%rsp), %r8
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbp, %rdi
	call	emit_stmt
	jmp	.L1556
	.p2align 4,,10
	.p2align 3
.L1586:
	movq	16(%r13), %rdi
	call	global_data_kind
	testl	%eax, %eax
	je	.L1556
	movl	8(%r13), %esi
	testl	%esi, %esi
	je	.L1560
	movq	16(%r13), %rdx
	movq	%r15, %rcx
	movq	%r15, %r9
	movq	%r15, %r8
	leaq	.LC172(%rip), %rsi
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
	jmp	.L1556
	.p2align 4,,10
	.p2align 3
.L1587:
	movq	24(%rdi), %r11
	jmp	.L1562
	.p2align 4,,10
	.p2align 3
.L1560:
	movq	%r15, %rdx
	leaq	.LC173(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1556
.L1588:
	movq	24(%rdi), %r11
	jmp	.L1564
	.cfi_endproc
.LFE64:
	.size	emit_global_declarations, .-emit_global_declarations
	.section	.rodata.str1.1
.LC176:
	.string	"{\n    B_FRAME;\n"
	.section	.rodata.str1.8
	.align 8
.LC177:
	.string	"    size_t __bcc_count = __bcc_current_call ? __bcc_current_call->count : 0;\n"
	.align 8
.LC178:
	.string	"    if (__bcc_count < %zu) __bcc_count = %zu;\n"
	.align 8
.LC179:
	.string	"    word __bcc_parameters[__bcc_count];\n    for (size_t __bcc_i = 0; __bcc_i < __bcc_count; ++__bcc_i)\n        __bcc_parameters[__bcc_i] = __bcc_current_call && __bcc_i < __bcc_current_call->count\n            ? __bcc_current_call->arguments[__bcc_i] : 0;\n"
	.align 8
.LC180:
	.string	"    (void)B_LOCAL_PTR_N(__bcc_parameters, sizeof(__bcc_parameters));\n"
	.align 8
.LC181:
	.string	"    static int __bcc_labels_ready;\n"
	.align 8
.LC182:
	.string	"    static word __bcc_label_target_%zu;\n"
	.align 8
.LC183:
	.string	"    static word __b_label_value_%zu;\n"
	.align 8
.LC184:
	.string	"    if (!__bcc_labels_ready) {\n"
	.align 8
.LC185:
	.string	"        __bcc_label_target_%zu = __bcc_new_label();\n"
	.align 8
.LC186:
	.string	"        __b_label_value_%zu = __bcc_label_target_%zu;\n"
	.align 8
.LC187:
	.string	"        __bcc_labels_ready = 1;\n    }\n"
	.section	.rodata.str1.1
.LC188:
	.string	"    return 0;\n}\n"
	.text
	.p2align 4
	.type	emit_function_body, @function
emit_function_body:
.LFB60:
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
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdx, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movq	32(%rsi), %rdi
	movq	$0, 8+function_labels(%rip)
	call	collect_function_labels
	movq	%rbx, %rcx
	movl	$15, %edx
	movl	$1, %esi
	leaq	.LC176(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%r13)
	jne	.L1606
.L1591:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L1607
.L1593:
	cmpq	$0, 8+function_labels(%rip)
	jne	.L1608
.L1597:
	movq	32(%r13), %rsi
	movq	%r12, %r8
	movq	%rbx, %rdi
	movl	$1, %ecx
	movl	$1, %edx
	call	emit_stmt
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC188(%rip), %rdi
	call	fwrite@PLT
	movq	$0, 8+function_labels(%rip)
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
.L1606:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$77, %edx
	movl	$1, %esi
	leaq	.LC177(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC178(%rip), %rsi
	movq	%rdx, %rcx
	call	fprintf@PLT
	movq	%rbx, %rcx
	movl	$255, %edx
	movl	$1, %esi
	leaq	.LC179(%rip), %rdi
	call	fwrite@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L1591
	movq	%rbx, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC180(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1591
	.p2align 4,,10
	.p2align 3
.L1608:
	movq	%rbx, %rcx
	movl	$35, %edx
	movl	$1, %esi
	leaq	.LC181(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	je	.L1598
	xorl	%ebp, %ebp
	leaq	.LC182(%rip), %r15
	leaq	.LC183(%rip), %r14
	.p2align 4
	.p2align 3
.L1599:
	addq	$1, %rbp
	movq	%r15, %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movq	%rbp, %rdx
	call	fprintf@PLT
	xorl	%eax, %eax
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %rbp
	jb	.L1599
.L1598:
	movq	%rbx, %rcx
	movl	$31, %edx
	movl	$1, %esi
	leaq	.LC184(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	je	.L1600
	xorl	%ebp, %ebp
	leaq	.LC185(%rip), %r15
	leaq	.LC186(%rip), %r14
	.p2align 4
	.p2align 3
.L1601:
	addq	$1, %rbp
	movq	%r15, %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movq	%rbp, %rdx
	call	fprintf@PLT
	xorl	%eax, %eax
	movq	%rbp, %rcx
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %rbp
	jb	.L1601
.L1600:
	movq	%rbx, %rcx
	movl	$38, %edx
	movl	$1, %esi
	leaq	.LC187(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1597
	.p2align 4,,10
	.p2align 3
.L1607:
	movq	32(%r13), %rdi
	pxor	%xmm0, %xmm0
	movq	%rsp, %rsi
	movq	$0, 16(%rsp)
	movaps	%xmm0, (%rsp)
	call	collect_function_autos
	cmpq	$0, 8(%rsp)
	je	.L1594
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1595:
	movq	(%rsp), %rax
	movq	%r12, %rcx
	movl	$1, %edx
	movq	%rbx, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	emit_auto_storage
	cmpq	8(%rsp), %rbp
	jb	.L1595
.L1594:
	cmpq	$0, g_compilation_arena(%rip)
	jne	.L1593
	movq	(%rsp), %rdi
	call	free@PLT
	jmp	.L1593
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
	.ascii	"izers();\n}\nint b_rd_fd __attribute__((weak)) = 0;\n#define"
	.ascii	" rd_fd b_rd_fd\nint b_wr_fd __attribute__((weak)) = 1;\n#def"
	.ascii	"ine wr_fd b_wr_fd\nword b_rd_unit __attribute__((weak)) = 0;"
	.ascii	"\n#define rd_unit b_rd_unit\nword b_wr_unit __attribute__((w"
	.ascii	"eak)) = (word)-1;\n#define wr_unit b_wr_unit\nstatic void __"
	.ascii	"b_sync_rd(void){\n    if (rd_unit < 0) {\n        if (rd_fd "
	.ascii	"!= 0 && rd_fd > 2) close(rd_fd);\n        rd_fd = 0;\n    } "
	.ascii	"else if (rd_fd != (int)rd_unit) {\n        rd_fd = (int)rd_u"
	.ascii	"nit;\n    }\n}\nstatic void __b_sync_wr(void){\n    if (wr_u"
	.ascii	"nit < 0) {\n        if (wr_fd != 1 && wr_fd > 2) close(wr_fd"
	.ascii	");\n        wr_fd = 1;\n    } else if (wr_fd != (int)wr_unit"
	.ascii	") {\n        wr_fd = (int)wr_unit;\n    }\n}\nstatic word b_"
	.ascii	"print(word x){\n    __b_sync_wr();\n    char buf[64];\n    i"
	.ascii	"nt n = snprintf(buf, sizeof(buf), \"%\" PRIdPTR \"\\n\", (in"
	.ascii	"tptr_t)x);\n    if (n > 0) (void)write(wr_fd, buf, (size_t)n"
	.ascii	");\n    return x;\n}\n\nstatic word b_putchar(word x){\n    "
	.ascii	"__b_sync_wr();\n    unsigned char bytes[2] = {(unsigned char"
	.ascii	")((uword)x >> 8), (unsigned char)x};\n    size_t start = byt"
	.ascii	"es[0] ? 0 : 1;\n    (void)write(wr_fd, bytes + start, 2 - st"
	.ascii	"art);\n    return x;\n}\nstatic word b_getchar(void){ __b_sy"
	.ascii	"nc_rd(); unsigned char c; ssize_t n = read(rd_fd, &c, 1); if"
	.ascii	" (n == 1) return (word)c; if (rd_fd != 0) { close(rd_fd); rd"
	.ascii	"_fd = 0; rd_unit = -1; return b_getchar(); } return (word)00"
	.ascii	"4; }\nstatic word b_exit(word code){ exit((int)code); return"
	.ascii	" 0; }\nstatic word b_abort(void){ abort(); return 0; }\nstat"
	.ascii	"ic word b_free(word p){ void *host = B_CPTR(p); B_FORGET(hos"
	.ascii	"t); free(host); return 0; }\n\n/* Sign-extend 16-bit value t"
	.ascii	"o full word size. Used by 16-bit B programs on 64-bit hosts."
	.ascii	" */\nstatic word sx64(word x){\n    return (word)(int16_t)(x"
	.ascii	" & 0xFFFF);\n}\n\n/* Command line argument support */\nint _"
	.ascii	"_b_argc __attribute__((common));\nchar **__b_argv __attribut"
	.ascii	"e__((common));\n\n/* argv"
	.ascii	" strings converted to B strings (packed words, 004 terminato"
	.ascii	"r) */\nword *__b_argvb __attribute__((common));\nword b_argv"
	.ascii	"_vector __attribute__((common));\n\nstatic void __b_setargs("
	.ascii	"int argc, char **argv);\nstatic word b_argc(void);\nstatic w"
	.ascii	"ord b_argv(word i);\n\n/* Command line reread buffer */\nsta"
	.ascii	"tic word b_reread(void);\n\n/* Helper functions for complex "
	.ascii	"lvalue operations (avoid GNU C extensions) */\n/* All use sa"
	.ascii	"fe W* macros to avoid host-C undefined behavior */\nstatic w"
	.ascii	"ord b_preinc(word *p) { return (*p = WADD(*p, 1)); }\nstatic"
	.ascii	" word b_predec(word *p) { return (*p = WSUB(*p, 1)); }\nstat"
	.ascii	"ic word b_postinc(word *p) { word old = WVAL(*p); *p = WADD("
	.ascii	"*p, 1); return old; }\nstatic word b_postdec(word *p) { word"
	.ascii	" old = WVAL(*p); *p = WSUB(*p, 1); return old; }\nstatic wor"
	.ascii	"d b_add_assign(word *p, word v) { return (*p = WADD(*p, v));"
	.ascii	" }\nstatic word b_sub_assign(word *p, word v) { return (*p ="
	.ascii	" WSUB(*p, v)); }\nstatic word b_mul_assign(word *p, word v) "
	.ascii	"{ return (*p = WMUL(*p, v)); }\nstatic word b_div_assign(wor"
	.ascii	"d *p, word v) { return (*p = WDIV(*p, v)); }\nstatic word b_"
	.ascii	"mod_assign(word *p, word v) { return (*p = WMOD(*p, v)); }\n"
	.ascii	"static word b_lsh_assign(word *p, word v) { return (*p = WSH"
	.ascii	"L(*p, v)); }\nstatic word b_rsh_assign(word *p, word v) { re"
	.ascii	"turn (*p = WSHR(*p, v)); }\nstatic word b_and_assign(word *p"
	.ascii	", word v) { return (*p = WAND(*p, v)); }\nstatic word b_or_a"
	.ascii	"ssign(word *p, word v) { return (*p = WOR(*p, v)); }\nstatic"
	.ascii	" word b_xor_assign(word *p, word v) { return (*p = WXOR(*p, "
	.ascii	"v)); }\n\nstatic word b_alloc(word nwords){\n    nwords = WV"
	.ascii	"AL(nwords);\n    if (nwords < 0 || (uword)nwords > SIZE_MAX "
	.ascii	"/ sizeof(word)) {\n        fprintf(stderr, \"alloc: invalid "
	.ascii	"size\\n\"); exit(1);\n    }\n    size_t bytes = nwords ? (si"
	.ascii	"ze_t)nwords * sizeof(word) : sizeof(word);\n    void *p = ma"
	.ascii	"lloc(bytes);\n    if (!p) { fprintf(stderr, \"alloc: out of "
	.ascii	"memory\\n\"); exit(1); }\n    return B_PTR_N(p, bytes);\n}\n"
	.ascii	"\n/* Host B runtime functions and compatibility helpers */\n"
	.ascii	"/* String manipulation functions */\nstatic inline word b_lo"
	.ascii	"ad(word"
	.ascii	" addr){ return B_DEREF(addr); }\nstatic inline void b_store("
	.ascii	"word addr, word v){ B_DEREF(addr) = WVAL(v);\n}\n\n/* B stri"
	.ascii	"ng access - byte packing within words.\n *\n * In B_BYTEPTR="
	.ascii	"0 mode, bytes are packed into words with byte 0 at the LSB.\n"
	.ascii	" * This matches PDP-11 (little-endian) conventions. The shif"
	.ascii	"t-based approach\n * operates on word VALUES (not memory lay"
	.ascii	"out), making it consistent across\n * architectures: char(s,"
	.ascii	"0) always returns the least-significant byte of the\n * word"
	.ascii	" at address s, regardless of host endianness.\n *\n * Note: "
	.ascii	"This only works correctly when ALL byte access goes through "
	.ascii	"char()/lchar().\n * Mixing direct memory access (like C's *("
	.ascii	"char*)ptr) with B word operations will\n * give different re"
	.ascii	"sults on big-endian hosts.\n */\nstatic word b_char(word s, "
	.ascii	"word i){\n#if B_BYTEPTR && WORD_BITS != 16\n    const unsign"
	.ascii	"ed char *p = (const unsigned char*)B_CPTR(s);\n    return (w"
	.ascii	"ord)p[(size_t)i];\n#else\n    const uword W = (uword)B_WORD_"
	.ascii	"BYTES;\n    uword wi = (uword)i / W;\n    uword bi = (uword)"
	.ascii	"i % W;\n    uword w  = (uword)B_INDEX(s, wi);\n    return (w"
	.ascii	"ord)((w >> (bi * 8)) & 0xFF);\n#endif\n}\n\nstatic word b_lc"
	.ascii	"har(word s, word i, word c){\n#if B_BYTEPTR && WORD_BITS != "
	.ascii	"16\n    unsigned char *p = (unsigned char*)B_CPTR(s);\n    p"
	.ascii	"[(size_t)i] = (unsigned char)(c & 0xFF);\n    return c;\n#el"
	.ascii	"se\n    const uword W = (uword)B_WORD_BYTES;\n    uword wi ="
	.ascii	" (uword)i / W;\n    uword bi = (uword)i % W;\n\n    word add"
	.ascii	"r = B_ADDR(B_INDEX(s, wi));\n    uword w   = (uword)b_load(a"
	.ascii	"ddr);\n\n    uword mask = (uword)0xFF << (bi * 8);\n    w = "
	.ascii	"(w & ~mask) | (((uword)c & 0xFF) << (bi * 8));\n\n#if WORD_B"
	.ascii	"ITS == 32\n    B_DEREF(addr) = (word)w;\n#else\n    b_store("
	.ascii	"addr, (word)w);\n#endif\n    return c;\n#endif\n}\n\n/* Comm"
	.ascii	"and line argument support implementation */\nstatic word __b"
	.ascii	"_pack_cstr(const char *s){\n    size_t n = strlen(s);       "
	.ascii	"          /* bytes, excluding NUL */\n    size_t W = B_WORD_"
	.ascii	"BYTES;              /* bytes per word */\n    size_t total ="
	.ascii	" n + 1;                 /* +1 for 004 terminator */\n    siz"
	.ascii	"e_t words = (total"
	.ascii	" + W - 1) / W;\n\n    word bp = b_alloc((word)words);       "
	.ascii	"/* B pointer to word storage */\n\n    /* write bytes into t"
	.ascii	"he B string using lchar (handles packing for B_BYTEPTR=0) */"
	.ascii	"\n    for (size_t i = 0; i < n; i++){\n        b_lchar(bp, ("
	.ascii	"word)i, (word)(unsigned char)s[i]);\n    }\n    b_lchar(bp, "
	.ascii	"(word)n, (word)004);\n    return bp;\n}\n\nstatic void __b_b"
	.ascii	"str_to_cstr(word s, char *buf, size_t max){\n    size_t i = "
	.ascii	"0;\n    while (i + 1 < max) {\n        word ch = b_char(s, ("
	.ascii	"word)i);\n        if (ch == 004 || ch == 0) break;\n        "
	.ascii	"buf[i++] = (char)(ch & 0xFF);\n    }\n    buf[i] = 0;\n}\n\n"
	.ascii	"/* Convert a B string (004-terminated) into a temporary NUL-"
	.ascii	"terminated C string */\nstatic const char *__b_cstr(word s){"
	.ascii	"\n    static char *slots[4];\n    static size_t caps[4];\n  "
	.ascii	"  static int next = 0;\n\n    if (s == 0) return \"\";\n\n  "
	.ascii	"  size_t len = 0;\n    for (;; len++) {\n        word ch = b"
	.ascii	"_char(s, (word)len);\n        if (ch == 004 || ch == 0) brea"
	.ascii	"k;\n    }\n\n    int idx = next;\n    next = (next + 1) & 3;"
	.ascii	" /* simple ring buffer to survive multiple args */\n\n    si"
	.ascii	"ze_t need = len + 1;\n    if (need > caps[idx]) {\n        s"
	.ascii	"ize_t ncap = need < 64 ? 64 : need;\n        char *nb = (cha"
	.ascii	"r*)realloc(slots[idx], ncap);\n        if (!nb) { fprintf(st"
	.ascii	"derr, \"cstr: out of memory\\n\"); exit(1); }\n        slots"
	.ascii	"[idx] = nb;\n        caps[idx] = ncap;\n    }\n\n    for (si"
	.ascii	"ze_t i = 0; i < len; i++) slots[idx][i] = (char)(b_char(s, ("
	.ascii	"word)i) & 0xFF);\n    slots[idx][len] = 0;\n    return slots"
	.ascii	"[idx];\n}\n\n/* Duplicate a B string into a freshly allocate"
	.ascii	"d C string */\nstatic char *__b_dup_bstr(word s){\n    size_"
	.ascii	"t cap = 64;\n    char *buf = (char*)malloc(cap);\n    if (!b"
	.ascii	"uf) { fprintf(stderr, \"system: out of memory\\n\"); exit(1)"
	.ascii	"; }\n\n    size_t i = 0;\n    for (;;) {\n        word ch = "
	.ascii	"b_char(s, (word)i);\n        if (ch == 004 || ch == 0) break"
	.ascii	";\n        if (i + 1 >= cap) {\n            size_t ncap = ca"
	.ascii	"p * 2;\n            char *nbuf = (char*)realloc(buf, ncap);\n"
	.ascii	"            if (!nbuf) { free(buf); fprintf(stderr, \"system"
	.ascii	": out of memory\\n\"); exit(1); }\n  "
	.ascii	"          buf = nbuf;\n            cap = ncap;\n        }\n "
	.ascii	"       buf[i++] = (char)(ch & 0xFF);\n    }\n    buf[i] = 0;"
	.ascii	"\n    return buf;\n}\n\nstatic void __b_setargs(int argc, ch"
	.ascii	"ar **argv){\n    __b_argc = argc;\n    __b_argv = argv;\n\n "
	.ascii	"   __b_argvb = (word*)malloc(sizeof(word) * ((size_t)argc + "
	.ascii	"1));\n    if (!__b_argvb) { fprintf(stderr, \"argv: out of m"
	.ascii	"emory\\n\"); exit(1); }\n\n    word *vector = (word*)malloc("
	.ascii	"sizeof(word) * ((size_t)argc + 1));\n    if (!vector) { fpri"
	.ascii	"ntf(stderr, \"argv: out of memory\\n\"); exit(1); }\n    vec"
	.ascii	"tor[0] = WVAL(argc);\n    for (int i = 0; i < argc; i++){\n "
	.ascii	"       __b_argvb[i] = __b_pack_cstr(argv[i]);\n        vecto"
	.ascii	"r[i+1] = __b_pack_cstr(argv[i]);\n        b_lchar(vector[i+1"
	.ascii	"], (word)strlen(argv[i]), 0);\n    }\n    b_argv_vector = B_"
	.ascii	"PTR_N(vector, sizeof(word) * ((size_t)argc + 1));\n}\nstatic"
	.ascii	" word __b_argvalues(void) {\n    return __b_argc ? B_PTR_N(_"
	.ascii	"_b_argvb, sizeof(word) * (size_t)__b_argc) : 0;\n}\n\nstatic"
	.ascii	" word b_argc(void) { return (word)__b_argc; }\n\nstatic word"
	.ascii	" b_argv(word i) {\n    int idx = (int)i;\n    if (idx < 0 ||"
	.ascii	" idx >= __b_argc) return 0;\n    return __b_argvb[idx];\n}\n"
	.ascii	"\nstatic word b_reread(void) {\n    if (__b_argc <= 1) retur"
	.ascii	"n 0;\n\n    /* A pipe can block before its reader starts. St"
	.ascii	"age the replay in an\n       anonymous seekable file instead"
	.ascii	", preserving empty argument fields. */\n    FILE *stream = t"
	.ascii	"mpfile();\n    if (!stream) {\n        fprintf(stderr, \"rer"
	.ascii	"ead: cannot create replay file\\n\");\n        exit(1);\n   "
	.ascii	" }\n    for (int i = 0; i < __b_argc; ++i) {\n        size_t"
	.ascii	" length = strlen(__b_argv[i]);\n        if (fwrite(__b_argv["
	.ascii	"i], 1, length, stream) != length ||\n            fputc(i + 1"
	.ascii	" < __b_argc ? ' ' : '\\n', stream) == EOF)\n            goto"
	.ascii	" failed;\n    }\n    if (fflush(stream) != 0 || fseek(stream"
	.ascii	", 0, SEEK_SET) != 0) goto failed;\n    int descriptor = dup("
	.ascii	"fileno(stream));\n    if (descriptor < 0) goto failed;\n    "
	.ascii	"fclose(stream);\n    __b_sync_rd();\n    if (rd_fd != 0) clo"
	.ascii	"se(rd_fd);\n    rd_fd = descriptor;\n    rd_unit = (word)des"
	.ascii	"criptor;\n    return 0;\n\nfailed:"
	.ascii	"\n    fclose(stream);\n    fprintf(stderr, \"reread: cannot "
	.ascii	"stage command line\\n\");\n    exit(1);\n}\n\n/* I/O functio"
	.ascii	"ns */\nstatic word b_getchr(void) {\n    __b_sync_rd();\n   "
	.ascii	" unsigned char c;\n    ssize_t n = read(rd_fd, &c, 1);\n    "
	.ascii	"if (n == 1) return (word)c;\n    if (rd_fd != 0) {\n        "
	.ascii	"close(rd_fd);\n        rd_fd = 0;\n        rd_unit = -1;\n  "
	.ascii	"      return b_getchr();\n    }\n    return (word)004; /* Re"
	.ascii	"turn *e on EOF */\n}\nstatic word b_putchr(word w) {\n    __"
	.ascii	"b_sync_wr();\n    unsigned char c = (unsigned char)(w & 0xFF"
	.ascii	");\n    (void)write(wr_fd, &c, 1);\n    return w;\n}\nstatic"
	.ascii	" word b_putstr(word s) {\n    __b_sync_wr();\n    word i = 0"
	.ascii	";\n    for (;;) {\n        word ch = __bcc_library_call2(\"c"
	.ascii	"har\", b_char, s, i++);\n        if (ch == 004 || (!__bcc_st"
	.ascii	"rict_runtime && ch == 0)) break;\n        __bcc_library_call"
	.ascii	"1(\"putchar\", b_putchar, ch);\n    }\n    return s;\n}\nsta"
	.ascii	"tic word b_getstr(word buf) {\n    word i = 0;\n    for (;;)"
	.ascii	" {\n        word c = __bcc_library_call0(\"getchar\", b_getc"
	.ascii	"har);\n        if (c == 004 || c == '\\n' || (!__bcc_strict_"
	.ascii	"runtime && c == '\\r')) break;\n        __bcc_library_call3("
	.ascii	"\"lchar\", b_lchar, buf, i++, c);\n    }\n    __bcc_librar"
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
	.ascii	"   const char *p = __b_cstr(name);\n    int flags = (mode =="
	.ascii	" 0) ? O_RDONLY : O_WRONLY;\n    return (word)open(p, flags);"
	.ascii	"\n}\nstatic word b_openr(word fd, word name){\n    char buf["
	.ascii	"512];\n    __b_bstr_to_cstr(name, buf, sizeof(buf));\n    in"
	.ascii	"t target = (int)fd;\n    if (target < 0 || buf[0] == '\\0') "
	.ascii	"{\n        rd_fd = 0; rd_unit = -1; return 0;\n    }\n    in"
	.ascii	"t newfd = open(buf, O_RDONLY);\n    if (rd_fd != 0 && rd_fd "
	.ascii	"!= target) close(rd_fd);\n    if (newfd < 0) { rd_fd = -1; r"
	.ascii	"d_unit = (word)target; return -1; }\n    if (newfd != target"
	.ascii	") {\n        if (dup2(newfd, target) < 0) { close(newfd); re"
	.ascii	"turn -1; }\n        close(newfd);\n        newfd = target;\n"
	.ascii	"    }\n    rd_fd = newfd;\n    rd_unit = (word)target;\n    "
	.ascii	"return (word)newfd;\n}\nstatic word b_openw(word fd, word na"
	.ascii	"me){\n    char buf[512];\n    __b_bstr_to_cstr(name, buf, si"
	.ascii	"zeof(buf));\n    int target = (int)fd;\n    if (target < 0 |"
	.ascii	"| buf[0] == '\\0') {\n        wr_fd = 1; wr_unit = -1; retur"
	.ascii	"n 1;\n    }\n    int newfd = open(buf, O_WRONLY | O_CREAT | "
	.ascii	"O_TRUNC, 0666);\n    if (newfd < 0) return -1;\n    if (wr_f"
	.ascii	"d != 1 && wr_fd != target && wr_fd != newfd) close(wr_fd);\n"
	.ascii	"    if (newfd != target) {\n        if (dup2(newfd, target) "
	.ascii	"< 0) { close(newfd); return -1; }\n        close(newfd);\n  "
	.ascii	"      newfd = target;\n    }\n    wr_fd = newfd;\n    wr_uni"
	.ascii	"t = (word)target;\n    return (word)newfd;\n}\nstatic word b"
	.ascii	"_close(word fd) {\n    int cfd = (int)fd;\n    word r = (wor"
	.ascii	"d)close(cfd);\n    if (r == 0) {\n        if (cfd == rd_fd |"
	.ascii	"| cfd == (int)rd_unit) { rd_fd = 0; rd_unit = -1; }\n       "
	.ascii	" if (cfd == wr_fd || cfd == (int)wr_unit) { wr_fd = 1; wr_un"
	.ascii	"it = -1; }\n    }\n    return r;\n}\nstatic word b_read(word"
	.ascii	" fd, word buf, word n) {\n#if WORD_BITS == 16\n    if (n < 0"
	.ascii	") return -1;\n    unsigned char *bytes = malloc(n ? (size_t)"
	.ascii	"n : 1);\n    if (!bytes) return -1;\n    ssize_t count = rea"
	.ascii	"d((int)fd, bytes, (size_t)n);\n    for (ssize_t i = 0; i < c"
	.ascii	"ount; i++) b_lchar(buf"
	.ascii	", (word)i, bytes[i]);\n    free(bytes);\n    return WVAL(cou"
	.ascii	"nt);\n#else\n    char *p = (char*)B_CPTR(buf);\n    return ("
	.ascii	"word)read((int)fd, p, (size_t)n);\n#endif\n}\nstatic word b_"
	.ascii	"write(word fd, word buf, word n) {\n#if WORD_BITS == 16\n   "
	.ascii	" if (n < 0) return -1;\n    unsigned char *bytes = malloc(n "
	.ascii	"? (size_t)n : 1);\n    if (!bytes) return -1;\n    for (word"
	.ascii	" i = 0; i < n; i++) bytes[i] = (unsigned char)b_char(buf, i)"
	.ascii	";\n    ssize_t count = write((int)fd, bytes, (size_t)n);\n  "
	.ascii	"  free(bytes);\n    return WVAL(count);\n#else\n    return ("
	.ascii	"word)write((int)fd, B_CPTR(buf), (size_t)n);\n#endif\n}\nsta"
	.ascii	"tic word b_creat(word name, word mode) {\n    const char *p "
	.ascii	"= __b_cstr(name);\n    return (word)creat(p, __bcc_unix_mode"
	.ascii	"(mode, 0));\n}\nstatic word b_seek(word fd, word offset, wor"
	.ascii	"d whence) {\n    return __bcc_unix_seek(fd, offset, whence);"
	.ascii	"\n}\n\n/* Process control functions - with actual implementa"
	.ascii	"tions */\nstatic word b_fork(void) {\n    return (word)fork("
	.ascii	");\n}\nstatic word __b_wait_status;\n\nstatic word b_wait(vo"
	.ascii	"id) {\n    int st = 0;\n    pid_t pid = wait(&st);\n    __b_"
	.ascii	"wait_status = (word)st;\n    return (word)pid;\n}\n/* B72 se"
	.ascii	"ction 8 passes exactly count argument strings, including arg"
	.ascii	"0. */\nstatic word b_execv(word path, word argv, word count)"
	.ascii	" {\n    if (count < 0 || count > 255 || (count && !argv)) re"
	.ascii	"turn -1;\n    char *name = __b_dup_bstr(path);\n    if (!nam"
	.ascii	"e) return -1;\n    char *arguments[256];\n    word *values ="
	.ascii	" count ? (word*)B_CPTR(argv) : NULL;\n    size_t n = (size_t"
	.ascii	")count, i = 0;\n    for (; i < n; i++) {\n        if (!value"
	.ascii	"s[i]) break;\n        arguments[i] = __b_dup_bstr(values[i])"
	.ascii	";\n        if (!arguments[i]) break;\n    }\n    if (i == n)"
	.ascii	" {\n        arguments[n] = NULL;\n        execv(name, argume"
	.ascii	"nts);\n    }\n    while (i) free(arguments[--i]);\n    free("
	.ascii	"name);\n    return -1;\n}\n\nstatic word b_execl(word path, "
	.ascii	"...) {\n    char *name = __b_dup_bstr(path);\n    if (!name)"
	.ascii	" return -1;\n    char *arguments[256];\n    size_t n = 0;\n "
	.ascii	"   int complete = 0;\n    va_list ap;\n    va_start(ap, path"
	.ascii	");\n    while (n < 255) {\n     "
	.ascii	"   word value = va_arg(ap, word);\n        if (!value) { com"
	.ascii	"plete = 1; break; }\n        arguments[n] = __b_dup_bstr(val"
	.ascii	"ue);\n        if (!arguments[n]) break;\n        n++;\n    }"
	.ascii	"\n    va_end(ap);\n    if (complete) {\n        arguments[n]"
	.ascii	" = NULL;\n        execv(name, arguments);\n    }\n    while "
	.ascii	"(n) free(arguments[--n]);\n    free(name);\n    return -1;\n"
	.ascii	"}\n\nstatic word b_system(word cmd) {\n    /* Split argument"
	.ascii	"s without invoking a shell or expanding their contents. */\n"
	.ascii	"    char *line = __b_dup_bstr(cmd);\n    if (!line) return -"
	.ascii	"1;\n    char *argv[128];\n    size_t argc = 0;\n    char *p "
	.ascii	"= line, *q = line;\n    while (*p) {\n        while (*p && i"
	.ascii	"sspace((unsigned char)*p)) p++;\n        if (!*p) break;\n  "
	.ascii	"      if (argc + 1 >= sizeof(argv)/sizeof(argv[0])) { free(l"
	.ascii	"ine); return -1; }\n        argv[argc++] = q;\n        int q"
	.ascii	"uote = 0;\n        while (*p && (quote || !isspace((unsigned"
	.ascii	" char)*p))) {\n            unsigned char c = (unsigned char)"
	.ascii	"*p++;\n            if (c == '\\\\' && quote != '\\'') {\n   "
	.ascii	"             if (!*p) { free(line); return -1; }\n          "
	.ascii	"      *q++ = *p++;\n            } else if (c == '\\'' || c ="
	.ascii	"= '\"') {\n                if (!quote) quote = c;\n         "
	.ascii	"       else if (quote == c) quote = 0;\n                else"
	.ascii	" *q++ = (char)c;\n            } else *q++ = (char)c;\n      "
	.ascii	"  }\n        if (quote) { free(line); return -1; }\n        "
	.ascii	"if (*p) p++;\n        *q++ = 0;\n    }\n    if (argc == 0) {"
	.ascii	" free(line); return -1; }\n    argv[argc] = NULL;\n    pid_t"
	.ascii	" pid = fork();\n    if (pid == 0) {\n        execvp(argv[0],"
	.ascii	" argv);\n        _exit(127);\n    }\n    if (pid < 0) { free"
	.ascii	"(line); return -1; }\n    int st = 0;\n    pid_t w;\n    do "
	.ascii	"{ w = waitpid(pid, &st, 0); } while (w < 0 && errno == EINTR"
	.ascii	");\n    free(line);\n    if (w < 0) return -1;\n    return ("
	.ascii	"word)st;\n}\n\nstatic word b_usleep(word usec) {\n    usleep"
	.ascii	"((useconds_t)usec);\n    return 0;\n}\n\nstatic word b_callf"
	.ascii	"_dispatch(int nargs, word name, ...) {\n    static int __b_c"
	.ascii	"allf_dl_done = 0;\n    if (!__b_callf_dl_done) {\n        __"
	.ascii	"b_callf_dl_done = 1;\n        cons"
	.ascii	"t char *env = getenv(\"B_CALLF_LIB\");\n        if (env && *"
	.ascii	"env) {\n            const char *p = env;\n            while "
	.ascii	"(*p) {\n                const char *start = p;\n            "
	.ascii	"    while (*p && *p != ':') p++;\n                size_t len"
	.ascii	" = (size_t)(p - start);\n                if (len) {\n       "
	.ascii	"             char *path = (char*)malloc(len + 1);\n         "
	.ascii	"           if (path) {\n                        memcpy(path,"
	.ascii	" start, len);\n                        path[len] = '\\0';\n "
	.ascii	"                       (void)dlopen(path, RTLD_NOW | RTLD_GL"
	.ascii	"OBAL);\n                        free(path);\n               "
	.ascii	"     }\n                }\n                if (*p == ':') p+"
	.ascii	"+;\n            }\n        }\n    }\n    if (nargs < 0 || na"
	.ascii	"rgs > 10) return -1;\n    if (name == 0) return -1;\n \n    "
	.ascii	"char sym[256];\n    __b_bstr_to_cstr(name, sym, sizeof(sym))"
	.ascii	";\n \n    void *fn = dlsym(RTLD_DEFAULT, sym);\n    if (!fn)"
	.ascii	" {\n        size_t len = strlen(sym);\n        if (len + 2 <"
	.ascii	" sizeof(sym)) {\n            sym[len] = '_'; sym[len + 1] = "
	.ascii	"'\\0';\n            fn = dlsym(RTLD_DEFAULT, sym);\n        "
	.ascii	"    sym[len] = '\\0';\n        }\n    }\n    if (!fn) return"
	.ascii	" -1;\n \n    void *args[10] = {0};\n    va_list ap;\n    va_"
	.ascii	"start(ap, name);\n    for (int i = 0; i < nargs && i < 10; i"
	.ascii	"++) {\n        word w = va_arg(ap, word);\n        args[i] ="
	.ascii	" B_CPTR(w);\n    }\n    va_end(ap);\n \n    word r = 0;\n   "
	.ascii	" switch (nargs) {\n    case 0: r = ((word (*)(void))fn)(); b"
	.ascii	"reak;\n    case 1: r = ((word (*)(void*))fn)(args[0]); break"
	.ascii	";\n    case 2: r = ((word (*)(void*, void*))fn)(args[0], arg"
	.ascii	"s[1]); break;\n    case 3: r = ((word (*)(void*, void*, void"
	.ascii	"*))fn)(args[0], args[1], args[2]); break;\n    case 4: r = ("
	.ascii	"(word (*)(void*, void*, void*, void*))fn)(args[0], args[1], "
	.ascii	"args[2], args[3]); break;\n    case 5: r = ((word (*)(void*,"
	.ascii	" void*, void*, void*, void*))fn)(args[0], args[1], args[2], "
	.ascii	"args[3], args[4]); break;\n    case 6: r = ((word (*)(void*,"
	.ascii	" void*, void*, void*, void*, void*))fn)(args[0], args[1], ar"
	.ascii	"gs[2], args[3], args[4], args[5]); break;\n    case 7: r = ("
	.ascii	"(word (*)(void*, voi"
	.ascii	"d*, void*, void*, void*, void*, void*))fn)(args[0], args[1],"
	.ascii	" args[2], args[3], args[4], args[5], args[6]); break;\n    c"
	.ascii	"ase 8: r = ((word (*)(void*, void*, void*, void*, void*, voi"
	.ascii	"d*, void*, void*))fn)(args[0], args[1], args[2], args[3], ar"
	.ascii	"gs[4], args[5], args[6], args[7]); break;\n    case 9: r = ("
	.ascii	"(word (*)(void*, void*, void*, void*, void*, void*, void*, v"
	.ascii	"oid*, void*))fn)(args[0], args[1], args[2], args[3], args[4]"
	.ascii	", args[5], args[6], args[7], args[8]); break;\n    case 10: "
	.ascii	"r = ((word (*)(void*, void*, void*, void*, void*, void*, voi"
	.ascii	"d*, void*, void*, void*))fn)(args[0], args[1], args[2], args"
	.ascii	"[3], args[4], args[5], args[6], args[7], args[8], args[9]); "
	.ascii	"break;\n    default: return -1;\n    }\n    return r;\n}\n\n"
	.ascii	"/* System functions - with actual implementations where poss"
	.ascii	"ible */\n/* Unix V1 counts 60 Hz ticks since 1971, high word"
	.ascii	" first (time(II)). */\nstatic word b_time(word tvp) {\n    s"
	.ascii	"truct timespec now;\n    if (clock_gettime(CLOCK_REALTIME, &"
	.ascii	"now) != 0) return -1;\n    if (tvp) {\n        uint64_t elap"
	.ascii	"sed = (uint64_t)now.tv_sec - UINT64_C(31536000);\n        ui"
	.ascii	"nt32_t ticks = (uint32_t)(elapsed * 60 + (uint64_t)now.tv_ns"
	.ascii	"ec * 60 / 1000000000);\n        word *tv = (word*)B_CPTR(tvp"
	.ascii	");\n        tv[0] = WVAL(ticks >> 16);\n        tv[1] = WVAL"
	.ascii	"(ticks & 65535);\n    }\n    return 0;\n}\n\n/* B72 section "
	.ascii	"8 specifies a caller-owned, 16-byte date buffer. */\nstatic "
	.ascii	"word b_ctime(word tvp, word date) {\n    if (!tvp || !date) "
	.ascii	"return -1;\n    word *tv = (word*)B_CPTR(tvp);\n    uint32_t"
	.ascii	" ticks = ((uint32_t)(uint16_t)tv[0] << 16) | (uint16_t)tv[1]"
	.ascii	";\n    unsigned days = ticks / 5184000U;\n    unsigned secon"
	.ascii	"ds = ticks / 60U % 86400U;\n    unsigned year = 1971, month "
	.ascii	"= 0;\n    while (days >= (year % 4 == 0 ? 366U : 365U)) {\n "
	.ascii	"       days -= year % 4 == 0 ? 366U : 365U;\n        year++;"
	.ascii	"\n    }\n    static const unsigned lengths[] = {31,28,31,30,"
	.ascii	"31,30,31,31,30,31,30,31};\n    static const char *months[] ="
	.ascii	" {\"Jan\",\"Feb\",\"Mar\",\"Apr\",\"May\",\"Jun\",\"Jul\",\""
	.ascii	"Aug\",\"Sep\",\"Oct\",\"Nov\",\"Dec\"};\n    for (;;) {\n   "
	.ascii	"     unsigned length = "
	.ascii	"lengths[month] + (month == 1 && year % 4 == 0);\n        if "
	.ascii	"(days < length) break;\n        days -= length;\n        mon"
	.ascii	"th++;\n    }\n    char text[16];\n    snprintf(text, sizeof("
	.ascii	"text), \"%s %2u %02u:%02u:%02u\", months[month], days + 1,\n"
	.ascii	"             seconds / 3600, seconds / 60 % 60, seconds % 60"
	.ascii	");\n    for (size_t i = 0; i < sizeof(text); i++) b_lchar(da"
	.ascii	"te, (word)i, (word)(unsigned char)text[i]);\n    return 0;\n"
	.ascii	"}\n\nstatic word b_getuid(void) {\n    return (word)getuid()"
	.ascii	";\n}\nstatic word b_chdir(word path) {\n    const char *p = "
	.ascii	"__b_cstr(path);\n    return (word)chdir(p);\n}\nstatic word "
	.ascii	"b_unlink(word path) {\n    const char *p = __b_cstr(path);\n"
	.ascii	"    return (word)unlink(p);\n}\n\n/* System functions with a"
	.ascii	"ctual implementations */\nstatic word b_chmod(word path, wor"
	.ascii	"d mode) {\n    const char *p = __b_cstr(path);\n    return ("
	.ascii	"word)chmod(p, __bcc_unix_mode(mode, 0));\n}\nstatic word b_c"
	.ascii	"hown(word path, word owner) {\n    const char *p = __b_cstr("
	.ascii	"path);\n    return (word)chown(p, (uid_t)owner, (gid_t)-1);\n"
	.ascii	"}\nstatic word b_link(word old, word new) {\n    const char "
	.ascii	"*o = __b_cstr(old);\n    const char *n = __b_cstr(new);\n   "
	.ascii	" return (word)link(o, n);\n}\nstatic word b_stat(word path, "
	.ascii	"word bufp) {\n    if (!bufp) { errno = EFAULT; return -1; }\n"
	.ascii	"    const char *p = __b_cstr(path);\n    struct stat st;\n  "
	.ascii	"  if (stat(p, &st) != 0) return -1;\n    __bcc_unix_stat((wo"
	.ascii	"rd*)B_CPTR(bufp), &st);\n    return 0;\n}\n\nstatic word b_f"
	.ascii	"stat(word fd, word bufp) {\n    if (!bufp) { errno = EFAULT;"
	.ascii	" return -1; }\n    struct stat st;\n    if (fstat((int)fd, &"
	.ascii	"st) != 0) return -1;\n    __bcc_unix_stat((word*)B_CPTR(bufp"
	.ascii	"), &st);\n    return 0;\n}\n\nstatic word b_setuid(word uid)"
	.ascii	" {\n    return (word)setuid((uid_t)uid);\n}\nstatic word b_m"
	.ascii	"akdir(word path, word mode) {\n    const char *p = __b_cstr("
	.ascii	"path);\n    return (word)mkdir(p, __bcc_unix_mode(mode, 1));"
	.ascii	"\n}\n\nstatic word b_mkdir(word path, word mode) { return b_"
	.ascii	"makdir(path, mode); }\nstatic word b_putnum(word n) {\n    _"
	.ascii	"_bcc_library_call2(\"printn\", b_printn, n, (word)10);\n    "
	.ascii	"return n;\n}\nstatic word b_gt"
	.ascii	"ty(word fd, word ttstat){\n    if (!ttstat) { errno = EFAULT"
	.ascii	"; return -1; }\n    struct termios t;\n    if (tcgetattr((in"
	.ascii	"t)fd, &t) < 0) return -1;\n\n    word *vec = (word*)B_CPTR(t"
	.ascii	"tstat);\n    vec[0] = (word)t.c_iflag;\n    vec[1] = (word)t"
	.ascii	".c_oflag;\n    vec[2] = (word)t.c_lflag;\n    return 0;\n}\n"
	.ascii	"\nstatic word b_stty(word fd, word ttstat){\n    if (!ttstat"
	.ascii	") { errno = EFAULT; return -1; }\n    struct termios t;\n   "
	.ascii	" if (tcgetattr((int)fd, &t) < 0) return -1;\n\n    word *vec"
	.ascii	" = (word*)B_CPTR(ttstat);\n    t.c_iflag = (tcflag_t)vec[0];"
	.ascii	"\n    t.c_oflag = (tcflag_t)vec[1];\n    t.c_lflag = (tcflag"
	.ascii	"_t)vec[2];\n    return (word)tcse"
	.string	"tattr((int)fd, TCSANOW, &t);\n}\nstatic word b_intr(word mode) {\n    if (mode != 0 && mode != 1) { errno = ENOSYS; return -1; }\n    if (signal(SIGINT, mode == 0 ? SIG_IGN : SIG_DFL) == SIG_ERR) return -1;\n    return 0;\n}\n\n/* Builtin aliases for B source */\n\n"
	.section	.rodata.str1.1
.LC206:
	.string	"%s/bprimitives.h"
	.section	.rodata.str1.8
	.align 8
.LC207:
	.string	"#define B_BUILTIN_STORAGE __attribute__((weak))\n"
	.section	.rodata.str1.1
.LC208:
	.string	"word __b_user_main("
.LC209:
	.string	"void)\n"
	.section	.rodata.str1.8
	.align 8
.LC210:
	.string	"int main(int argc, char **argv){\n"
	.section	.rodata.str1.1
.LC211:
	.string	"    __b_setargs(argc, argv);\n"
.LC212:
	.string	"    __b_init();\n"
	.section	.rodata.str1.8
	.align 8
.LC213:
	.string	"    return (int)__bcc_call%zu("
	.section	.rodata.str1.1
.LC214:
	.string	", (word)argc"
.LC215:
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
	jne	.L1632
.L1610:
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
	je	.L1633
.L1611:
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
	movl	$11398, %edx
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
	movq	%rbx, %rcx
	movl	$12868, %edx
	movl	$1, %esi
	leaq	.LC205(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC206(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	movq	%rax, %r13
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$48, %edx
	movl	$1, %esi
	leaq	.LC207(%rip), %rdi
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
	cmpq	$0, g_compilation_arena(%rip)
	je	.L1634
.L1612:
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1635
.L1613:
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
	jmp	.L1618
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1615:
	addq	$1, %r15
	cmpq	8(%rbp), %r15
	jnb	.L1636
.L1618:
	movq	0(%rbp), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L1615
	movq	8(%rax), %r12
	leaq	.LC15(%rip), %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1616
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	movq	16(%r12), %r13
	leaq	.LC208(%rip), %rdi
	movl	$1, %r14d
	call	fwrite@PLT
.L1617:
	movq	%rbx, %rcx
	movl	$6, %edx
	movl	$1, %esi
	addq	$1, %r15
	leaq	.LC209(%rip), %rdi
	call	fwrite@PLT
	movq	8(%rsp), %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_function_body
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	8(%rbp), %r15
	jb	.L1618
.L1636:
	testl	%r14d, %r14d
	jne	.L1637
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
.L1616:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC22(%rip), %rdi
	call	fwrite@PLT
	movq	(%r12), %rsi
	movq	%rbx, %rdi
	call	emit_function_body_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1617
	.p2align 4,,10
	.p2align 3
.L1632:
	movq	%rbx, %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC189(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1610
	.p2align 4,,10
	.p2align 3
.L1637:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC210(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC211(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC212(%rip), %rdi
	call	fwrite@PLT
	movl	$2, %edx
	leaq	.LC213(%rip), %rsi
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
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
	testq	%r13, %r13
	jne	.L1638
.L1622:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC24(%rip), %rdi
	call	fwrite@PLT
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$2, %edx
	popq	%rbx
	.cfi_def_cfa_offset 48
	movl	$1, %esi
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
.L1635:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1613
	.p2align 4,,10
	.p2align 3
.L1634:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L1612
	.p2align 4,,10
	.p2align 3
.L1633:
	movq	%r14, %rdi
	call	free@PLT
	jmp	.L1611
	.p2align 4,,10
	.p2align 3
.L1638:
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC214(%rip), %rdi
	call	fwrite@PLT
	cmpq	$1, %r13
	je	.L1622
	movq	%rbx, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC215(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1622
	.cfi_endproc
.LFE66:
	.size	emit_program_c, .-emit_program_c
	.section	.rodata.str1.8
	.align 8
.LC216:
	.string	"/* Generated by BCC - B Compiler */\n"
	.section	.rodata.str1.1
.LC217:
	.string	"#include \"libb.h\"\n\n"
	.section	.rodata.str1.8
	.align 8
.LC218:
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
	je	.L1661
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
	leaq	.LC216(%rip), %rdi
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
	leaq	.LC217(%rip), %rdi
	call	fwrite@PLT
	movl	g_use_curses(%rip), %esi
	testl	%esi, %esi
	jne	.L1662
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1663
.L1642:
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
	je	.L1639
	movl	$0, 12(%rsp)
	xorl	%r15d, %r15d
	xorl	%r13d, %r13d
	jmp	.L1647
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1644:
	addq	$1, %r15
	cmpq	8(%r14), %r15
	jnb	.L1664
.L1647:
	movq	(%r14), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L1644
	movq	8(%rax), %r12
	leaq	.LC15(%rip), %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1645
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	movq	16(%r12), %r13
	leaq	.LC208(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 12(%rsp)
.L1646:
	movq	%rbx, %rcx
	movl	$6, %edx
	movl	$1, %esi
	addq	$1, %r15
	leaq	.LC209(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_function_body
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	8(%r14), %r15
	jb	.L1647
.L1664:
	movl	12(%rsp), %eax
	testl	%eax, %eax
	jne	.L1665
.L1639:
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
.L1645:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC22(%rip), %rdi
	call	fwrite@PLT
	movq	(%r12), %rsi
	movq	%rbx, %rdi
	call	emit_function_body_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1646
	.p2align 4,,10
	.p2align 3
.L1663:
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1642
	.p2align 4,,10
	.p2align 3
.L1662:
	movq	%rbx, %rcx
	movl	$41, %edx
	movl	$1, %esi
	leaq	.LC218(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	je	.L1642
	jmp	.L1663
	.p2align 4,,10
	.p2align 3
.L1665:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC210(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC211(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC212(%rip), %rdi
	call	fwrite@PLT
	movl	$2, %edx
	leaq	.LC213(%rip), %rsi
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
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
	testq	%r13, %r13
	jne	.L1666
.L1651:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC24(%rip), %rdi
	call	fwrite@PLT
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$2, %edx
	popq	%rbx
	.cfi_def_cfa_offset 48
	movl	$1, %esi
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
.L1661:
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
.L1666:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC214(%rip), %rdi
	call	fwrite@PLT
	cmpq	$1, %r13
	je	.L1651
	movq	%rbx, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC215(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1651
	.cfi_endproc
.LFE67:
	.size	emit_program_c_ext, .-emit_program_c_ext
	.section	.rodata
	.align 16
	.type	CSWTCH.186, @object
	.size	CSWTCH.186, 24
CSWTCH.186:
	.long	24
	.long	25
	.long	26
	.long	27
	.long	22
	.long	23
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
.LC219:
	.string	"break"
.LC220:
	.string	"case"
.LC221:
	.string	"char"
.LC222:
	.string	"const"
.LC223:
	.string	"continue"
.LC224:
	.string	"default"
.LC225:
	.string	"do"
.LC226:
	.string	"double"
.LC227:
	.string	"else"
.LC228:
	.string	"enum"
.LC229:
	.string	"extern"
.LC230:
	.string	"float"
.LC231:
	.string	"for"
.LC232:
	.string	"goto"
.LC233:
	.string	"if"
.LC234:
	.string	"inline"
.LC235:
	.string	"int"
.LC236:
	.string	"long"
.LC237:
	.string	"register"
.LC238:
	.string	"restrict"
.LC239:
	.string	"short"
.LC240:
	.string	"signed"
.LC241:
	.string	"sizeof"
.LC242:
	.string	"static"
.LC243:
	.string	"struct"
.LC244:
	.string	"switch"
.LC245:
	.string	"typedef"
.LC246:
	.string	"union"
.LC247:
	.string	"unsigned"
.LC248:
	.string	"volatile"
.LC249:
	.string	"while"
.LC250:
	.string	"_Bool"
.LC251:
	.string	"_Complex"
.LC252:
	.string	"_Imaginary"
.LC253:
	.string	"_Alignas"
.LC254:
	.string	"_Alignof"
.LC255:
	.string	"_Atomic"
.LC256:
	.string	"_Generic"
.LC257:
	.string	"_Noreturn"
.LC258:
	.string	"_Static_assert"
.LC259:
	.string	"_Thread_local"
.LC260:
	.string	"NULL"
.LC261:
	.string	"true"
.LC262:
	.string	"false"
.LC263:
	.string	"bool"
.LC264:
	.string	"word"
.LC265:
	.string	"B_PTR"
.LC266:
	.string	"B_ADDR"
.LC267:
	.string	"B_DEREF"
	.section	.data.rel.ro.local,"aw"
	.align 32
	.type	c_keywords, @object
	.size	c_keywords, 424
c_keywords:
	.quad	.LC4
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
	.quad	.LC148
	.quad	.LC239
	.quad	.LC240
	.quad	.LC241
	.quad	.LC242
	.quad	.LC243
	.quad	.LC244
	.quad	.LC245
	.quad	.LC246
	.quad	.LC247
	.quad	.LC23
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
	.quad	.LC265
	.quad	.LC266
	.quad	.LC267
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
