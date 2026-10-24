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
	.type	collect_strings_expr, @function
collect_strings_expr:
.LFB31:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L171
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L152(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L149:
	cmpl	$10, (%rbx)
	ja	.L147
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L152:
	.long	.L147-.L152
	.long	.L160-.L152
	.long	.L147-.L152
	.long	.L159-.L152
	.long	.L151-.L152
	.long	.L175-.L152
	.long	.L175-.L152
	.long	.L174-.L152
	.long	.L174-.L152
	.long	.L153-.L152
	.long	.L151-.L152
	.text
	.p2align 4,,10
	.p2align 3
.L151:
	movq	40(%rbx), %rdi
	call	collect_strings_expr
.L175:
	movq	48(%rbx), %rbx
.L162:
	testq	%rbx, %rbx
	jne	.L149
.L147:
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
.L153:
	.cfi_restore_state
	movq	40(%rbx), %rdi
	call	collect_strings_expr
.L174:
	movq	48(%rbx), %rdi
	call	collect_strings_expr
	movq	56(%rbx), %rbx
	jmp	.L162
	.p2align 4,,10
	.p2align 3
.L159:
	movq	40(%rbx), %rdi
	call	collect_strings_expr
	cmpq	$0, 56(%rbx)
	je	.L147
	xorl	%ebp, %ebp
.L161:
	movq	48(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_expr
	cmpq	56(%rbx), %rbp
	jb	.L161
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
.L160:
	.cfi_restore_state
	movq	32(%rbx), %rsi
	movq	40(%rbx), %rdi
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
.L171:
	ret
	.cfi_endproc
.LFE31:
	.size	collect_strings_expr, .-collect_strings_expr
	.p2align 4
	.type	collect_strings_init, @function
collect_strings_init:
.LFB32:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L185
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
	je	.L188
	cmpl	$1, %eax
	je	.L189
.L176:
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
.L188:
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
.L189:
	.cfi_restore_state
	cmpq	$0, 24(%rdi)
	je	.L176
	xorl	%ebp, %ebp
.L179:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_init
	cmpq	24(%rbx), %rbp
	jb	.L179
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L185:
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
	je	.L213
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L195(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L192:
	cmpl	$12, (%rbx)
	ja	.L190
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L195:
	.long	.L190-.L195
	.long	.L202-.L195
	.long	.L190-.L195
	.long	.L201-.L195
	.long	.L194-.L195
	.long	.L198-.L195
	.long	.L198-.L195
	.long	.L190-.L195
	.long	.L190-.L195
	.long	.L190-.L195
	.long	.L198-.L195
	.long	.L196-.L195
	.long	.L194-.L195
	.text
	.p2align 4,,10
	.p2align 3
.L198:
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
.L202:
	.cfi_restore_state
	cmpq	$0, 24(%rbx)
	je	.L190
	xorl	%ebp, %ebp
.L203:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_stmt
	cmpq	24(%rbx), %rbp
	jb	.L203
.L190:
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
.L194:
	.cfi_restore_state
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rbx
.L204:
	testq	%rbx, %rbx
	jne	.L192
	jmp	.L190
	.p2align 4,,10
	.p2align 3
.L196:
	movq	24(%rbx), %rbx
	jmp	.L204
	.p2align 4,,10
	.p2align 3
.L201:
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rdi
	call	collect_strings_stmt
	movq	32(%rbx), %rbx
	jmp	.L204
	.p2align 4,,10
	.p2align 3
.L213:
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
	je	.L226
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
	jmp	.L223
	.p2align 4,,10
	.p2align 3
.L219:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L229
.L223:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L230
	cmpl	$2, %eax
	je	.L231
	testl	%eax, %eax
	jne	.L219
	movq	8(%rdx), %rdi
	addq	$1, %rbx
	call	collect_strings_stmt
	cmpq	8(%rbp), %rbx
	jb	.L223
.L229:
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
.L230:
	.cfi_restore_state
	movq	8(%rdx), %rax
	movq	32(%rax), %rdi
	call	collect_strings_stmt
	jmp	.L219
	.p2align 4,,10
	.p2align 3
.L231:
	movq	8(%rdx), %r12
	movq	56(%r12), %rdi
	call	collect_strings_init
	movq	32(%r12), %rdi
	testq	%rdi, %rdi
	je	.L219
	call	collect_strings_expr
	jmp	.L219
	.p2align 4,,10
	.p2align 3
.L226:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE34:
	.size	collect_strings_program, .-collect_strings_program
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
	je	.L236
	movq	%rdi, %r12
	movq	%rsi, %rbp
	xorl	%ebx, %ebx
.L235:
	movq	(%r12,%rbx,8), %rax
	testq	%rax, %rax
	je	.L234
	cmpl	$1, (%rax)
	je	.L242
.L234:
	addq	$1, %rbx
	cmpq	%rbp, %rbx
	jne	.L235
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
.L242:
	.cfi_restore_state
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r13
	jmp	.L234
	.p2align 4,,10
	.p2align 3
.L236:
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
	je	.L256
	movq	g_known_variables(%rip), %rbx
	xorl	%r12d, %r12d
	leaq	(%rbx,%rax,8), %r13
	.p2align 4
	.p2align 3
.L245:
	movq	(%rbx), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	addq	$8, %rbx
	movzbl	%al, %eax
	orl	%eax, %r12d
	cmpq	%rbx, %r13
	jne	.L245
.L244:
	movq	current_program(%rip), %r13
	testq	%r13, %r13
	je	.L246
	movq	8(%r13), %r14
	xorl	%ebx, %ebx
	jmp	.L247
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L248:
	addq	$1, %rbx
.L247:
	cmpq	%rbx, %r14
	je	.L246
	movq	0(%r13), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$2, (%rax)
	jne	.L248
	movq	8(%rax), %rax
	movq	%rbp, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L248
.L257:
	movl	$1, %r12d
.L243:
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
.L246:
	.cfi_restore_state
	movq	%rbp, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L258
	leaq	8+names.0(%rip), %rbx
	leaq	.LC13(%rip), %rsi
	jmp	.L252
	.p2align 4,,10
	.p2align 3
.L273:
	movq	(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L253
.L252:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L273
	cmpl	$1, %r12d
	jne	.L243
.L253:
	testq	%r13, %r13
	je	.L243
	movq	8(%r13), %r14
	testq	%r14, %r14
	je	.L243
	movq	0(%r13), %r13
	xorl	%ebx, %ebx
	jmp	.L255
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L254:
	addq	$1, %rbx
	cmpq	%r14, %rbx
	je	.L243
.L255:
	movq	0(%r13,%rbx,8), %rax
	cmpl	$3, (%rax)
	jne	.L254
	movq	8(%rax), %r15
	movq	%rbp, %rsi
	movq	16(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L254
	movl	8(%r15), %eax
	movl	$2, %r12d
	testl	%eax, %eax
	jne	.L243
	jmp	.L257
	.p2align 4,,10
	.p2align 3
.L258:
	xorl	%r12d, %r12d
	jmp	.L243
	.p2align 4,,10
	.p2align 3
.L256:
	xorl	%r12d, %r12d
	jmp	.L244
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
	je	.L315
	movq	8+name_map(%rip), %r13
	movq	%rdi, %rbx
	testq	%r13, %r13
	je	.L276
	movq	name_map(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L278
	.p2align 4,,10
	.p2align 3
.L277:
	addq	$1, %rbp
	cmpq	%r13, %rbp
	je	.L276
.L278:
	movq	(%r14,%rbp,8), %r12
	movq	%rbx, %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L277
	movq	8(%r12), %rbp
.L274:
	addq	$24, %rsp
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
.L276:
	.cfi_restore_state
	cmpb	$0, (%rbx)
	je	.L346
	movq	%rbx, %rdi
	call	strlen@PLT
	leaq	16(,%rax,4), %rdi
	movq	%rax, (%rsp)
	call	xmalloc@PLT
	movzbl	(%rbx), %edx
	movq	(%rsp), %rcx
	movq	%rax, %rbp
	leaq	1(%rax), %r14
	leal	-65(%rdx), %eax
	cmpb	$57, %al
	ja	.L281
	movabsq	$288230372997595135, %rsi
	btq	%rax, %rsi
	jnc	.L281
	movb	%dl, 0(%rbp)
.L285:
	leaq	1(%rbx), %r12
	leaq	(%rbx,%rcx), %r15
	movabsq	$288230372997595135, %r13
	cmpq	$1, %rcx
	ja	.L295
	jmp	.L287
	.p2align 4,,10
	.p2align 3
.L288:
	leal	-65(%rdx), %eax
	cmpb	$57, %al
	ja	.L291
	btq	%rax, %r13
	jnc	.L291
.L289:
	movb	%dl, (%r14)
	addq	$1, %r14
.L294:
	addq	$1, %r12
	cmpq	%r12, %r15
	je	.L287
.L295:
	movzbl	(%r12), %edx
	cmpb	$57, %dl
	jg	.L288
	cmpb	$47, %dl
	jg	.L289
	cmpb	$46, %dl
	jne	.L291
	addq	$1, %r12
	movb	$95, (%r14)
	addq	$1, %r14
	cmpq	%r12, %r15
	jne	.L295
.L287:
	movb	$0, (%r14)
	jmp	.L280
	.p2align 4,,10
	.p2align 3
.L346:
	leaq	.LC15(%rip), %rdi
	call	sdup@PLT
	movq	%rax, %rbp
.L280:
	leaq	8+names.0(%rip), %r13
	leaq	.LC13(%rip), %rsi
	movq	%r13, %r12
	jmp	.L297
	.p2align 4,,10
	.p2align 3
.L348:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L347
.L297:
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L348
.L296:
	movq	%rbp, %rdi
	call	strlen@PLT
	leaq	14(%rax), %rdi
	call	xmalloc@PLT
	leaq	.LC13(%rip), %rsi
	movq	%rax, %r12
	jmp	.L300
	.p2align 4,,10
	.p2align 3
.L350:
	movq	0(%r13), %rsi
	addq	$8, %r13
	testq	%rsi, %rsi
	je	.L349
.L300:
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L350
	movl	$114, %edx
.L299:
	xorl	%eax, %eax
	movq	%rbp, %rcx
	leaq	.LC18(%rip), %rsi
	movq	%r12, %rdi
	call	sprintf@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L351
.L301:
	movq	%r12, %rbp
.L314:
	leaq	8+c_keywords(%rip), %r12
	leaq	.LC14(%rip), %rsi
	jmp	.L303
	.p2align 4,,10
	.p2align 3
.L352:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L304
.L303:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L352
	movq	%rbp, %rdi
	call	strlen@PLT
	leaq	15(%rax), %rdi
	call	xmalloc@PLT
	movq	%rbp, %rdx
	leaq	.LC20(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %r12
	xorl	%eax, %eax
	call	sprintf@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L353
.L313:
	movq	%r12, %rbp
.L304:
	movq	8+name_map(%rip), %r13
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
	testq	%r13, %r13
	je	.L305
	movq	name_map(%rip), %r14
	xorl	%r12d, %r12d
	jmp	.L307
	.p2align 4,,10
	.p2align 3
.L355:
	addq	$1, %r12
	cmpq	%r12, %r13
	je	.L354
.L307:
	movq	(%r14,%r12,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L355
	movq	%rbp, %rdi
	call	strlen@PLT
	leaq	16(%rax), %rdi
	call	xmalloc@PLT
	movl	$2, %ecx
	movq	%rax, %r13
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
	.p2align 4
	.p2align 3
.L309:
	leal	1(%rcx), %eax
	movq	%rbp, %rdx
	leaq	.LC19(%rip), %rsi
	movq	%r13, %rdi
	movl	%eax, 12(%rsp)
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	8+name_map(%rip), %r12
	testq	%r12, %r12
	je	.L308
	movq	(%rsp), %rax
	xorl	%r15d, %r15d
	movq	(%rax), %r14
	jmp	.L310
	.p2align 4,,10
	.p2align 3
.L356:
	addq	$1, %r15
	cmpq	%r12, %r15
	je	.L308
.L310:
	movq	(%r14,%r15,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L356
	movl	12(%rsp), %ecx
	jmp	.L309
	.p2align 4,,10
	.p2align 3
.L347:
	movl	$6, %edx
	leaq	.LC21(%rip), %rsi
	movq	%rbx, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	je	.L296
	jmp	.L314
	.p2align 4,,10
	.p2align 3
.L354:
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
.L305:
	movl	$16, %edi
	call	xmalloc@PLT
	movq	%rbx, %rdi
	movq	%rax, %r12
	call	sdup@PLT
	movq	%rbp, 8(%r12)
	movq	(%rsp), %rdi
	movq	%r12, %rsi
	movq	%rax, (%r12)
	call	vec_push@PLT
	jmp	.L274
.L281:
	movb	$95, 0(%rbp)
	movzbl	(%rbx), %eax
	cmpb	$46, %al
	jne	.L357
	movb	$95, 1(%rbp)
	leaq	2(%rbp), %r14
	jmp	.L285
	.p2align 4,,10
	.p2align 3
.L291:
	movq	%r14, %rdi
	leaq	.LC17(%rip), %rsi
	xorl	%eax, %eax
	addq	$3, %r14
	call	sprintf@PLT
	jmp	.L294
	.p2align 4,,10
	.p2align 3
.L308:
	cmpq	$0, g_compilation_arena(%rip)
	je	.L358
.L311:
	movq	%r13, %rbp
	jmp	.L305
	.p2align 4,,10
	.p2align 3
.L349:
	movl	$120, %edx
	jmp	.L299
.L315:
	xorl	%ebp, %ebp
	jmp	.L274
.L351:
	movq	%rbp, %rdi
	call	free@PLT
	jmp	.L301
.L357:
	movzbl	%al, %edx
	movq	%r14, %rdi
	leaq	.LC16(%rip), %rsi
	xorl	%eax, %eax
	movq	%rcx, (%rsp)
	leaq	3(%rbp), %r14
	call	sprintf@PLT
	movq	(%rsp), %rcx
	jmp	.L285
.L353:
	movq	%rbp, %rdi
	call	free@PLT
	jmp	.L313
.L358:
	movq	%rbp, %rdi
	call	free@PLT
	jmp	.L311
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
	jne	.L362
	jmp	.L369
	.p2align 4,,10
	.p2align 3
.L370:
	movq	(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L363
.L362:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L370
	movq	%rbp, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L371
.L363:
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
.L369:
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
.L371:
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
	.string	"b_main"
.LC26:
	.string	"extern word "
.LC27:
	.string	"();\n"
.LC28:
	.string	"static word __b_user_main("
.LC29:
	.string	"word "
.LC30:
	.string	"word"
.LC31:
	.string	", "
.LC32:
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
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	cmpq	$0, 8+g_known_functions(%rip)
	je	.L380
	movl	$0, 12(%rsp)
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L378:
	leaq	g_known_functions(%rip), %rax
	leaq	.LC22(%rip), %rsi
	movq	(%rax), %rax
	movq	(%rax,%r12,8), %rbx
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L374
	leaq	.LC25(%rip), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L374
	movq	8(%r14), %rcx
	movq	(%r14), %r15
	testq	%rcx, %rcx
	je	.L375
	xorl	%r13d, %r13d
	jmp	.L377
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L376:
	addq	$1, %r13
	cmpq	%r13, %rcx
	je	.L375
.L377:
	movq	(%r15,%r13,8), %rax
	cmpl	$1, (%rax)
	jne	.L376
	movq	8(%rax), %rax
	movq	%rbx, %rsi
	movq	%rcx, (%rsp)
	movq	(%rax), %rdi
	call	strcmp@PLT
	movq	(%rsp), %rcx
	testl	%eax, %eax
	jne	.L376
	.p2align 4
	.p2align 3
.L374:
	addq	$1, %r12
	cmpq	8+g_known_functions(%rip), %r12
	jb	.L378
.L418:
	movl	12(%rsp), %eax
	testl	%eax, %eax
	je	.L380
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
.L380:
	cmpq	$0, 8(%r14)
	je	.L372
	xorl	%r12d, %r12d
	leaq	.LC30(%rip), %r15
	jmp	.L389
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L382:
	addq	$1, %r12
	cmpq	8(%r14), %r12
	jnb	.L372
.L389:
	movq	(%r14), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$1, (%rax)
	jne	.L382
	movq	8(%rax), %r13
	leaq	.LC22(%rip), %rsi
	movq	0(%r13), %rbx
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L383
	leaq	.LC25(%rip), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L384
.L383:
	movq	%rbp, %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC28(%rip), %rdi
	call	fwrite@PLT
.L388:
	xorl	%ebx, %ebx
	cmpq	$0, 16(%r13)
	jne	.L385
	jmp	.L386
	.p2align 4,,10
	.p2align 3
.L417:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
.L385:
	movq	%rbp, %rcx
	movl	$4, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
	addq	$1, %rbx
	cmpq	16(%r13), %rbx
	jb	.L417
.L386:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC32(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r14), %r12
	jb	.L389
.L372:
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
.L375:
	.cfi_restore_state
	movq	%rbp, %rcx
	movl	$12, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC26(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rdi
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbp, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC27(%rip), %rdi
	call	fwrite@PLT
	cmpq	8+g_known_functions(%rip), %r12
	movl	$1, 12(%rsp)
	jb	.L378
	jmp	.L418
	.p2align 4,,10
	.p2align 3
.L384:
	leaq	.LC29(%rip), %rdi
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	0(%r13), %rdi
	testq	%rdi, %rdi
	je	.L387
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L387:
	movq	%rbp, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L388
	.cfi_endproc
.LFE61:
	.size	emit_function_prototypes, .-emit_function_prototypes
	.section	.rodata.str1.1
.LC33:
	.string	"B_ADDR("
.LC34:
	.string	"argv"
.LC35:
	.string	"b_argv_vector"
.LC36:
	.string	"__b_external_%s"
.LC37:
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
	leaq	.LC33(%rip), %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	call	fwrite@PLT
	movq	40(%r12), %rbx
	leaq	.LC34(%rip), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L452
.L420:
	movq	%rbx, %rdi
	call	global_data_kind
	movq	%rbx, %rdi
	cmpl	$2, %eax
	je	.L453
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	40(%r12), %rdi
	call	global_data_kind
	cmpl	$1, %eax
	je	.L454
.L429:
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
.L452:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L420
	movq	8+g_known_variables(%rip), %r14
	testq	%r14, %r14
	je	.L421
	movq	g_known_variables(%rip), %r15
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L422:
	movq	(%r15,%r13,8), %rdi
	movq	%rbx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L420
	addq	$1, %r13
	cmpq	%r14, %r13
	jne	.L422
.L421:
	movq	current_program(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L423
	movq	8(%rax), %rax
	xorl	%r13d, %r13d
	movq	%rax, 16(%rsp)
	jmp	.L424
	.p2align 4,,10
	.p2align 3
.L425:
	testl	%eax, %eax
	je	.L455
.L426:
	addq	$1, %r13
.L424:
	cmpq	%r13, 16(%rsp)
	je	.L423
	movq	24(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r13,8), %rdx
	movl	(%rdx), %eax
	cmpl	$2, %eax
	jne	.L425
	movq	8(%rdx), %rax
	movq	%rbx, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L426
	jmp	.L420
	.p2align 4,,10
	.p2align 3
.L453:
	call	get_mangled_name
	leaq	.LC36(%rip), %rsi
	movq	%rbp, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L429
.L423:
	movq	%rbp, %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC35(%rip), %rdi
	call	fwrite@PLT
	jmp	.L429
	.p2align 4,,10
	.p2align 3
.L455:
	movq	8(%rdx), %rax
	movq	24(%rax), %rcx
	movq	%rcx, 8(%rsp)
	testq	%rcx, %rcx
	je	.L426
	movq	16(%rax), %r14
	xorl	%r15d, %r15d
	jmp	.L427
	.p2align 4,,10
	.p2align 3
.L456:
	movq	8(%rsp), %rax
	addq	$1, %r15
	cmpq	%rax, %r15
	je	.L426
.L427:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L456
	jmp	.L420
	.p2align 4,,10
	.p2align 3
.L454:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC37(%rip), %rdi
	call	fwrite@PLT
	jmp	.L429
	.cfi_endproc
.LFE71:
	.size	emit_ival_expr.part.0, .-emit_ival_expr.part.0
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
	jle	.L462
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
.L459:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L459
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
.L462:
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
	jne	.L465
	testq	%rdx, %rdx
	jne	.L473
.L465:
	ret
	.p2align 4,,10
	.p2align 3
.L473:
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
	jne	.L475
	jmp	.L482
	.p2align 4,,10
	.p2align 3
.L490:
	movq	%r13, %rsi
	movq	%r12, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L478:
	movzbl	1(%rbp), %ebx
	addq	$1, %rbp
	testb	%bl, %bl
	je	.L482
.L475:
	cmpb	$92, %bl
	je	.L483
	cmpb	$34, %bl
	je	.L483
	cmpb	$10, %bl
	je	.L488
	cmpb	$9, %bl
	je	.L489
	movzbl	%bl, %edx
	cmpb	$31, %bl
	jbe	.L490
	movq	%r12, %rsi
	movl	%edx, %edi
	addq	$1, %rbp
	call	fputc@PLT
	movzbl	0(%rbp), %ebx
	testb	%bl, %bl
	jne	.L475
.L482:
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
.L483:
	.cfi_restore_state
	movq	%r12, %rsi
	movl	$92, %edi
	call	fputc@PLT
	movzbl	%bl, %edi
	movq	%r12, %rsi
	call	fputc@PLT
	jmp	.L478
	.p2align 4,,10
	.p2align 3
.L488:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	jmp	.L478
	.p2align 4,,10
	.p2align 3
.L489:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC41(%rip), %rdi
	call	fwrite@PLT
	jmp	.L478
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
	.string	"malloc"
.LC74:
	.string	"calloc"
.LC75:
	.string	"realloc"
.LC76:
	.string	"printf"
.LC77:
	.string	"B_PTR("
.LC78:
	.string	"fprintf"
.LC79:
	.string	"dprintf"
.LC80:
	.string	"sprintf"
.LC81:
	.string	"snprintf"
.LC82:
	.string	"-+ #0"
.LC83:
	.string	"exit"
.LC84:
	.string	"strlen"
.LC85:
	.string	"atoi"
.LC86:
	.string	"memmove"
.LC87:
	.string	"tcgetattr"
.LC88:
	.string	"tcsetattr"
.LC89:
	.string	"ioctl"
.LC90:
	.string	"memset"
.LC91:
	.string	"memcpy"
.LC92:
	.string	"__b_cstr("
.LC93:
	.string	"B_CPTR("
	.section	.rodata.str1.8
	.align 8
.LC94:
	.string	"(size_t)(sizeof(word) * (uword)("
	.section	.rodata.str1.1
.LC95:
	.string	"))"
.LC96:
	.string	"B_INDEX("
.LC97:
	.string	"B_DEREF("
.LC98:
	.string	"b_"
.LC99:
	.string	"(&("
.LC100:
	.string	"WNEG("
.LC101:
	.string	"({ word __b_left_%u = "
.LC102:
	.string	"; word __b_right_%u = "
	.section	.rodata.str1.8
	.align 8
.LC103:
	.string	"; (word)%s(__b_left_%u, __b_right_%u); })"
	.section	.rodata.str1.1
.LC104:
	.string	"%s("
.LC105:
	.string	" %s "
.LC106:
	.string	" = ("
.LC107:
	.string	"), "
.LC108:
	.string	" ? "
.LC109:
	.string	" : "
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
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	cmpl	$10, (%rsi)
	movq	%rdi, (%rsp)
	ja	.L491
	movl	(%rsi), %eax
	movq	%rdx, %rbp
	leaq	.L494(%rip), %rdx
	movq	%rsi, %r15
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L494:
	.long	.L504-.L494
	.long	.L503-.L494
	.long	.L502-.L494
	.long	.L501-.L494
	.long	.L500-.L494
	.long	.L499-.L494
	.long	.L498-.L494
	.long	.L497-.L494
	.long	.L496-.L494
	.long	.L495-.L494
	.long	.L493-.L494
	.text
	.p2align 4,,10
	.p2align 3
.L495:
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
	leaq	.LC108(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$3, %edx
	leaq	.LC109(%rip), %rdi
	call	fwrite@PLT
	movq	56(%r15), %rsi
.L845:
	movq	%rbp, %rdx
.L846:
	movq	%rbx, %rdi
	call	emit_expr
.L847:
	movq	%rbx, %rsi
.L850:
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
.L493:
	.cfi_restore_state
	movq	(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
.L849:
	movq	40(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rdi
.L848:
	call	fwrite@PLT
	movq	48(%r15), %rsi
	jmp	.L845
	.p2align 4,,10
	.p2align 3
.L504:
	movq	40(%rsi), %rdx
	leaq	.LC65(%rip), %rsi
.L843:
	movq	(%rsp), %rdi
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
.L503:
	.cfi_restore_state
	movq	40(%r15), %rdi
	movq	32(%rsi), %rsi
	call	get_string_id
	movq	(%rsp), %rdi
	addq	$88, %rsp
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
.L502:
	.cfi_restore_state
	movq	8+function_labels(%rip), %r13
	movq	40(%rsi), %r12
	testq	%r13, %r13
	je	.L505
	movq	function_labels(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L508
	.p2align 4,,10
	.p2align 3
.L506:
	addq	$1, %rbp
	cmpq	%r13, %rbp
	je	.L505
.L508:
	movq	(%r14,%rbp,8), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L506
	movl	%ebp, %edx
	addl	$1, %edx
	je	.L505
	movq	(%rsp), %rdi
	addq	$88, %rsp
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
.L501:
	.cfi_restore_state
	movl	24(%rsi), %r10d
	testl	%r10d, %r10d
	jne	.L855
	movq	40(%rsi), %rax
	cmpl	$2, (%rax)
	movq	40(%rax), %r12
	je	.L856
	movb	$0, 39(%rsp)
	xorl	%ebx, %ebx
	xorl	%r14d, %r14d
	movq	$0, 8(%rsp)
.L518:
	movq	(%rsp), %rdi
	movq	%r12, %rsi
	call	emit_function_name
.L528:
	movq	(%rsp), %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	56(%r15), %rdx
	movq	8(%rsp), %rcx
	cmpq	%rdx, %rcx
	jnb	.L529
	cmpb	$0, 39(%rsp)
	je	.L529
	movq	48(%r15), %rax
	movq	(%rax,%rcx,8), %rax
	testq	%rax, %rax
	je	.L557
	cmpl	$1, (%rax)
	je	.L857
.L557:
	movq	$0, 40(%rsp)
.L532:
	movq	%rdx, 16(%rsp)
	movq	(%rsp), %r12
	xorl	%r13d, %r13d
	movl	%ebx, 56(%rsp)
	movq	%rbp, 24(%rsp)
	testq	%r14, %r14
	je	.L667
.L862:
	movq	8(%rsp), %rax
	movl	current_byteptr(%rip), %ebp
	cmpq	%rax, %r13
	sete	%al
	testb	%al, 39(%rsp)
	jne	.L560
	movq	40(%rsp), %rax
	testq	%rax, %rax
	je	.L561
	movl	(%rax,%r13,4), %r8d
	testl	%r8d, %r8d
	jne	.L560
.L561:
	leaq	.LC84(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L564
	testq	%r13, %r13
	je	.L858
.L565:
	leaq	.LC86(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L567
	cmpq	$1, %r13
	jbe	.L859
.L569:
	leaq	.LC88(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L572
	cmpq	$2, %r13
	je	.L573
.L568:
	leaq	.LC90(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testq	%r13, %r13
	sete	48(%rsp)
	testl	%eax, %eax
	movzbl	48(%rsp), %ecx
	sete	%al
	andb	%cl, %al
	movl	%eax, %edx
	jne	.L860
	leaq	.LC91(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L580
	cmpq	$1, %r13
	jbe	.L581
.L579:
	leaq	.LC75(%rip), %rax
	movq	%r14, %rdi
	movq	%rax, %rsi
	movq	%rax, 64(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L582
	movb	$0, 48(%rsp)
.L583:
	leaq	.LC74(%rip), %rdx
	movq	%r14, %rdi
	movq	%rdx, %rsi
	movq	%rdx, 72(%rsp)
	call	strcmp@PLT
	leaq	.LC74(%rip), %rdx
	testl	%eax, %eax
	sete	%al
	andb	48(%rsp), %al
	xorl	$1, %eax
	movzbl	%al, %eax
	andl	%eax, %ebx
	testl	%ebp, %ebp
	jne	.L582
	leaq	.LC73(%rip), %rsi
	movq	%r14, %rdi
	movq	%rdx, 72(%rsp)
	call	strcmp@PLT
	movq	72(%rsp), %rdx
	testl	%eax, %eax
	jne	.L680
	cmpb	$0, 48(%rsp)
	je	.L680
.L588:
	testl	%ebx, %ebx
	jne	.L587
.L589:
	movq	%r12, %rcx
	movl	$32, %edx
	movl	$1, %esi
	leaq	.LC94(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rax
	movq	24(%rsp), %rdx
	movq	%r12, %rdi
	movq	(%rax,%r13,8), %rsi
	call	emit_expr
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC95(%rip), %rdi
	call	fwrite@PLT
.L634:
	testl	%ebx, %ebx
	jne	.L861
.L592:
	addq	$1, %r13
	cmpq	%r13, 16(%rsp)
	je	.L593
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
	testq	%r14, %r14
	jne	.L862
.L667:
	xorl	%ebx, %ebx
.L559:
	movq	48(%r15), %rax
	movq	24(%rsp), %rdx
	movq	%r12, %rdi
	movq	(%rax,%r13,8), %rsi
	call	emit_expr
	jmp	.L634
	.p2align 4,,10
	.p2align 3
.L500:
	movq	(%rsp), %rbx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC96(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	jmp	.L849
	.p2align 4,,10
	.p2align 3
.L499:
	movl	40(%rsi), %r12d
	cmpl	$32, %r12d
	je	.L863
	cmpl	$53, %r12d
	je	.L864
	leal	-36(%r12), %eax
	cmpl	$1, %eax
	jbe	.L865
	movq	(%rsp), %rbx
	cmpl	$31, %r12d
	jne	.L603
	movl	current_word_bits(%rip), %esi
	testl	%esi, %esi
	jne	.L866
.L603:
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
	jmp	.L851
	.p2align 4,,10
	.p2align 3
.L498:
	movq	48(%rsi), %r12
	movl	40(%rsi), %r13d
	testq	%r12, %r12
	je	.L604
	movl	(%r12), %eax
	cmpl	$4, %eax
	je	.L605
	cmpl	$5, %eax
	jne	.L604
	cmpl	$32, 40(%r12)
	je	.L605
	.p2align 4
	.p2align 3
.L604:
	movl	current_word_bits(%rip), %ecx
	testl	%ecx, %ecx
	je	.L606
.L605:
	movq	(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC98(%rip), %rdi
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
	leaq	.LC99(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r12, %rsi
.L851:
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC95(%rip), %rdi
.L844:
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
.L497:
	.cfi_restore_state
	movl	40(%rsi), %r12d
	leal	-53(%r12), %eax
	cmpl	$1, %eax
	jbe	.L867
	movl	current_word_bits(%rip), %edx
	testl	%edx, %edx
	je	.L610
	leal	-28(%r12), %eax
	cmpl	$6, %eax
	ja	.L610
	leaq	.L612(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L612:
	.long	.L675-.L612
	.long	.L617-.L612
	.long	.L616-.L612
	.long	.L615-.L612
	.long	.L614-.L612
	.long	.L613-.L612
	.long	.L611-.L612
	.text
	.p2align 4,,10
	.p2align 3
.L496:
	movl	40(%rsi), %r12d
	movq	48(%rsi), %r13
	movq	56(%rsi), %r14
	leal	-47(%r12), %eax
	cmpl	$5, %eax
	jbe	.L868
	cmpl	$21, %r12d
	je	.L620
	testq	%r13, %r13
	je	.L621
	movl	0(%r13), %eax
	cmpl	$4, %eax
	je	.L622
	cmpl	$5, %eax
	je	.L869
.L621:
	movl	current_word_bits(%rip), %eax
	testl	%eax, %eax
	je	.L620
.L622:
	leal	-38(%r12), %eax
	cmpl	$8, %eax
	ja	.L620
	leaq	.L625(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L625:
	.long	.L633-.L625
	.long	.L632-.L625
	.long	.L631-.L625
	.long	.L630-.L625
	.long	.L629-.L625
	.long	.L628-.L625
	.long	.L627-.L625
	.long	.L676-.L625
	.long	.L624-.L625
	.text
	.p2align 4,,10
	.p2align 3
.L554:
	testq	%rdx, %rdx
	jne	.L557
	movq	(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	jne	.L558
.L491:
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
.L505:
	.cfi_restore_state
	movl	16(%r15), %ebx
	testl	%ebx, %ebx
	jne	.L870
	movl	12(%r15), %r11d
	testl	%r11d, %r11d
	jne	.L871
	movl	20(%r15), %eax
	cmpl	$2, %eax
	je	.L872
	testq	%r12, %r12
	je	.L512
	movq	%r12, %rdi
	call	get_mangled_name
	movq	(%rsp), %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movl	20(%r15), %eax
.L512:
	cmpl	$1, %eax
	jne	.L491
	movq	(%rsp), %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC37(%rip), %rdi
	jmp	.L844
	.p2align 4,,10
	.p2align 3
.L610:
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
	leaq	.LC105(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	56(%r15), %rsi
	jmp	.L845
	.p2align 4,,10
	.p2align 3
.L856:
	leaq	.LC71(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L873
.L519:
	leaq	8+names.0(%rip), %r13
	leaq	.LC13(%rip), %rsi
	jmp	.L523
	.p2align 4,,10
	.p2align 3
.L875:
	movq	0(%r13), %rsi
	addq	$8, %r13
	testq	%rsi, %rsi
	je	.L874
.L523:
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L875
	movq	%r12, %rdi
	call	source_function
	xorl	$1, %eax
	movl	%eax, %ebx
.L652:
	leaq	.LC73(%rip), %rsi
	movq	%r12, %rdi
	movl	$1, %r13d
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L524
	leaq	.LC74(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L524
	leaq	.LC75(%rip), %rsi
	movq	%r12, %rdi
	xorl	%r13d, %r13d
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%r13b
.L524:
	leaq	.LC76(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	orl	%ebx, %eax
	je	.L876
.L525:
	leaq	.LC78(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L660
	leaq	.LC79(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L660
	leaq	.LC80(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L660
	leaq	.LC81(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L661
	movb	$0, 39(%rsp)
	movq	$0, 8(%rsp)
	.p2align 4
	.p2align 3
.L526:
	testl	%r13d, %r13d
	jne	.L877
	movq	%r12, %rdx
	movq	%r12, %r14
	testl	%ebx, %ebx
	je	.L518
.L645:
	movq	(%rsp), %rdi
	leaq	.LC24(%rip), %rsi
	xorl	%eax, %eax
	movq	%r12, %r14
	movl	%r13d, %ebx
	call	fprintf@PLT
	jmp	.L528
	.p2align 4,,10
	.p2align 3
.L870:
	movq	(%rsp), %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC35(%rip), %rdi
	jmp	.L844
	.p2align 4,,10
	.p2align 3
.L606:
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
	jmp	.L847
	.p2align 4,,10
	.p2align 3
.L865:
	movq	48(%rsi), %r13
	testq	%r13, %r13
	je	.L599
	movl	0(%r13), %eax
	cmpl	$4, %eax
	je	.L600
	cmpl	$5, %eax
	je	.L878
.L599:
	movl	current_word_bits(%rip), %edi
	testl	%edi, %edi
	je	.L601
.L600:
	movq	(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC98(%rip), %rdi
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
	leaq	.LC99(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	jmp	.L851
.L617:
	leaq	.LC52(%rip), %rdx
	.p2align 4
	.p2align 3
.L618:
	movq	(%rsp), %rbx
	leaq	.LC104(%rip), %rsi
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
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
	movq	56(%r15), %rsi
	jmp	.L845
.L675:
	leaq	.LC53(%rip), %rdx
	jmp	.L618
.L611:
	leaq	.LC54(%rip), %rdx
	jmp	.L618
.L616:
	leaq	.LC49(%rip), %rdx
	jmp	.L618
.L613:
	leaq	.LC55(%rip), %rdx
	jmp	.L618
.L614:
	leaq	.LC51(%rip), %rdx
	jmp	.L618
.L615:
	leaq	.LC50(%rip), %rdx
	jmp	.L618
.L676:
	leaq	.LC58(%rip), %r12
	.p2align 4
	.p2align 3
.L626:
	movq	(%rsp), %rbx
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
	leaq	.LC107(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	jmp	.L846
.L624:
	leaq	.LC57(%rip), %r12
	jmp	.L626
.L633:
	leaq	.LC56(%rip), %r12
	jmp	.L626
.L631:
	leaq	.LC63(%rip), %r12
	jmp	.L626
.L632:
	leaq	.LC64(%rip), %r12
	jmp	.L626
.L627:
	leaq	.LC59(%rip), %r12
	jmp	.L626
.L628:
	leaq	.LC60(%rip), %r12
	jmp	.L626
.L629:
	leaq	.LC61(%rip), %r12
	jmp	.L626
.L630:
	leaq	.LC62(%rip), %r12
	jmp	.L626
	.p2align 4,,10
	.p2align 3
.L560:
	testl	%ebp, %ebp
	je	.L879
.L563:
	movq	%r12, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC92(%rip), %rdi
	call	fwrite@PLT
.L591:
	movl	$1, %ebx
	jmp	.L559
	.p2align 4,,10
	.p2align 3
.L861:
	movq	%r12, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L592
	.p2align 4,,10
	.p2align 3
.L879:
	testq	%r13, %r13
	sete	%bl
.L566:
	leaq	.LC73(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L679
	testb	%bl, %bl
	jne	.L586
.L679:
	leaq	.LC75(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L880
	cmpq	$1, %r13
	jne	.L563
.L586:
	movq	%r12, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC92(%rip), %rdi
	call	fwrite@PLT
.L590:
	movl	$1, %ebx
	jmp	.L589
	.p2align 4,,10
	.p2align 3
.L593:
	movl	56(%rsp), %ebx
	movq	(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	jne	.L556
.L595:
	movq	40(%rsp), %rax
	testq	%rax, %rax
	je	.L491
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
.L620:
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
	leaq	.LC105(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	jmp	.L846
	.p2align 4,,10
	.p2align 3
.L529:
	testq	%r14, %r14
	je	.L554
	leaq	.LC83(%rip), %rsi
	movq	%r14, %rdi
	movq	%rdx, 16(%rsp)
	call	strcmp@PLT
	movq	16(%rsp), %rdx
	testl	%eax, %eax
	jne	.L554
	testq	%rdx, %rdx
	jne	.L557
	movq	(%rsp), %r14
	movl	$48, %edi
	movq	%r14, %rsi
	call	fputc@PLT
	movq	%r14, %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	je	.L491
.L558:
	xorl	%r9d, %r9d
	movq	%r9, 40(%rsp)
	.p2align 4
	.p2align 3
.L556:
	movq	(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L595
	.p2align 4,,10
	.p2align 3
.L567:
	leaq	.LC87(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L569
	cmpq	$1, %r13
	jne	.L569
	leaq	.LC91(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L840
.L581:
	testl	%ebp, %ebp
	jne	.L578
	movq	%r13, %rax
	xorq	$1, %rax
	movl	%eax, %edx
	andl	$1, %edx
.L577:
	leaq	.LC73(%rip), %rsi
	movq	%r14, %rdi
	movb	%dl, 48(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L681
	movzbl	48(%rsp), %edx
	testb	%dl, %dl
	jne	.L587
.L681:
	leaq	.LC75(%rip), %rsi
	movq	%r14, %rdi
	movl	$1, %ebx
	call	strcmp@PLT
	leaq	.LC74(%rip), %rdx
	testl	%eax, %eax
	je	.L881
.L642:
	movq	%rdx, %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L582
.L854:
	cmpq	$1, %r13
	je	.L588
	.p2align 4
	.p2align 3
.L582:
	testl	%ebx, %ebx
	je	.L559
.L578:
	movq	%r12, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC93(%rip), %rdi
	call	fwrite@PLT
	jmp	.L591
	.p2align 4,,10
	.p2align 3
.L880:
	leaq	.LC74(%rip), %rdx
	movq	%r14, %rdi
	movq	%rdx, %rsi
	call	strcmp@PLT
	cmpq	$1, %r13
	jne	.L563
	testl	%eax, %eax
	je	.L586
	jmp	.L563
	.p2align 4,,10
	.p2align 3
.L564:
	leaq	.LC85(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%bl
	testq	%r13, %r13
	sete	%al
	andb	%al, %bl
	je	.L565
	testl	%ebp, %ebp
	je	.L566
	jmp	.L563
	.p2align 4,,10
	.p2align 3
.L855:
	movq	(%rsp), %rbx
	movl	$29, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC69(%rip), %rdi
	leaq	.LC31(%rip), %r13
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
	je	.L516
.L515:
	movq	48(%r15), %rax
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	emit_expr
	cmpq	56(%r15), %r12
	jnb	.L516
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	jmp	.L515
.L520:
	movq	(%rsp), %rbx
	leaq	-1(%r14), %rdx
	xorl	%eax, %eax
	xorl	%r12d, %r12d
	leaq	.LC72(%rip), %rsi
	leaq	.LC31(%rip), %r13
	movq	%rbx, %rdi
	call	fprintf@PLT
.L521:
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
	jne	.L521
	.p2align 4
	.p2align 3
.L516:
	movq	(%rsp), %rsi
	jmp	.L850
	.p2align 4,,10
	.p2align 3
.L868:
	movq	(%rsp), %rbx
	leaq	CSWTCH.160(%rip), %rdx
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
	leaq	.LC106(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edi
	call	tk_name@PLT
	leaq	.LC105(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	jmp	.L851
	.p2align 4,,10
	.p2align 3
.L660:
	movb	$1, 39(%rsp)
	movq	$1, 8(%rsp)
	jmp	.L526
.L840:
	movb	$0, 48(%rsp)
	movl	$1, %ebx
.L580:
	leaq	.LC75(%rip), %rax
	movq	%r14, %rdi
	movq	%rax, %rsi
	movq	%rax, 64(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L583
	movzbl	48(%rsp), %eax
	orl	%eax, %ebx
	testl	%ebp, %ebp
	jne	.L582
	leaq	.LC73(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L854
	cmpb	$0, 48(%rsp)
	jne	.L588
	jmp	.L854
	.p2align 4,,10
	.p2align 3
.L572:
	leaq	.LC89(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L678
	cmpq	$2, %r13
	je	.L573
.L678:
	xorl	%ebx, %ebx
	jmp	.L568
.L573:
	leaq	.LC91(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L840
	movl	$1, %ebx
	jmp	.L579
	.p2align 4,,10
	.p2align 3
.L867:
	movl	expression_id(%rip), %eax
	movq	(%rsp), %rbx
	leaq	.LC101(%rip), %rsi
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
	leaq	.LC102(%rip), %rsi
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
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC103(%rip), %rsi
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
.L871:
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
	jmp	.L847
.L869:
	cmpl	$32, 40(%r13)
	jne	.L621
	jmp	.L622
.L863:
	movq	(%rsp), %rbx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC97(%rip), %rdi
	movq	%rbx, %rcx
	jmp	.L848
.L858:
	testl	%ebp, %ebp
	jne	.L563
	movl	$1, %ebx
	jmp	.L566
.L874:
	xorl	%ebx, %ebx
	jmp	.L652
.L864:
	movq	(%rsp), %rbx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC33(%rip), %rdi
	movq	%rbx, %rcx
	jmp	.L848
.L866:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC100(%rip), %rdi
	jmp	.L848
.L873:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L519
	movq	56(%r15), %r14
	testq	%r14, %r14
	jne	.L520
	movq	(%rsp), %rdi
	xorl	%edx, %edx
	leaq	.LC72(%rip), %rsi
	call	fprintf@PLT
	jmp	.L516
.L876:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L525
	testl	%r13d, %r13d
	jne	.L882
	movb	$1, 39(%rsp)
	movq	%r12, %r14
	xorl	%ebx, %ebx
	movq	$0, 8(%rsp)
	jmp	.L518
.L881:
	cmpq	$1, %r13
	jne	.L578
.L587:
	movq	%r12, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC93(%rip), %rdi
	call	fwrite@PLT
	jmp	.L590
.L860:
	testl	%ebp, %ebp
	je	.L577
	jmp	.L578
.L877:
	movq	(%rsp), %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC77(%rip), %rdi
	call	fwrite@PLT
	movq	40(%r15), %rax
	movq	40(%rax), %rdx
	testl	%ebx, %ebx
	je	.L662
	cmpl	$2, (%rax)
	je	.L883
	movq	%r12, %r14
	movq	%rdx, %r12
	jmp	.L518
.L872:
	movq	%r12, %rdi
	call	get_mangled_name
	leaq	.LC36(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L843
.L859:
	movl	$1, %ebx
	jmp	.L568
.L857:
	movq	%rdx, %rdi
	movl	$4, %esi
	movq	%rdx, 16(%rsp)
	movq	40(%rax), %r12
	call	calloc@PLT
	movq	16(%rsp), %rdx
	testq	%rax, %rax
	movq	%rax, 40(%rsp)
	je	.L557
	movq	8(%rsp), %rax
	xorl	%r13d, %r13d
	leaq	1(%rax), %rsi
	movzbl	(%r12), %eax
	testb	%al, %al
	je	.L532
	movq	%r14, 24(%rsp)
	movl	%ebx, 16(%rsp)
	movq	%rsi, %rbx
	movq	%rbp, 48(%rsp)
	movq	%r12, %rbp
	movq	%rdx, %r12
	.p2align 4
	.p2align 3
.L531:
	cmpb	$37, %al
	jne	.L836
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	cmpb	$37, %r14b
	je	.L836
	testb	%r14b, %r14b
	jne	.L534
	jmp	.L834
	.p2align 4,,10
	.p2align 3
.L537:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	testb	%r14b, %r14b
	je	.L536
.L534:
	movsbl	%r14b, %esi
	leaq	.LC82(%rip), %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L537
	cmpb	$42, %r14b
	jne	.L536
	cmpq	%r12, %rbx
	adcq	$0, %rbx
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %edx
.L541:
	cmpb	$46, %dl
	je	.L884
.L544:
	cmpb	$104, %dl
	je	.L885
	cmpb	$108, %dl
	jne	.L551
	cmpb	$108, 1(%rbp,%r13)
	leaq	1(%r13), %rax
	je	.L666
.L549:
	addq	$1, %rbx
.L533:
	movq	%rax, %r13
	movzbl	0(%rbp,%rax), %eax
	testb	%al, %al
	jne	.L531
.L834:
	movl	16(%rsp), %ebx
	movq	24(%rsp), %r14
	movq	%r12, %rdx
	movq	48(%rsp), %rbp
	jmp	.L532
	.p2align 4,,10
	.p2align 3
.L836:
	leaq	1(%r13), %rax
	jmp	.L533
.L536:
	movzbl	0(%rbp,%r13), %edx
	testb	%dl, %dl
	movb	%dl, 56(%rsp)
	je	.L834
	call	__ctype_b_loc@PLT
	movzbl	56(%rsp), %edx
	movq	(%rax), %rax
	jmp	.L539
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L543:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %edx
	testb	%dl, %dl
	je	.L834
.L539:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L543
	movzbl	0(%rbp,%r13), %edx
	jmp	.L541
.L885:
	cmpb	$104, 1(%rbp,%r13)
	leaq	1(%r13), %rax
	jne	.L549
.L666:
	leaq	2(%r13), %rax
	jmp	.L549
.L884:
	movzbl	1(%rbp,%r13), %edx
	leaq	1(%r13), %rdi
	movq	%rdi, 56(%rsp)
	cmpb	$42, %dl
	jne	.L886
	cmpq	%r12, %rbx
	adcq	$0, %rbx
	addq	$2, %r13
	movzbl	0(%rbp,%r13), %edx
	jmp	.L544
.L551:
	testb	%dl, %dl
	je	.L834
	leaq	1(%r13), %rax
	cmpb	$115, %dl
	jne	.L549
	cmpq	%r12, %rbx
	jnb	.L549
	movq	40(%rsp), %rcx
	movl	$1, (%rcx,%rbx,4)
	jmp	.L549
.L601:
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
	jmp	.L846
.L878:
	cmpl	$32, 40(%r13)
	jne	.L599
	jmp	.L600
.L886:
	testb	%dl, %dl
	movb	%dl, 64(%rsp)
	je	.L834
	call	__ctype_b_loc@PLT
	movzbl	64(%rsp), %edx
	movq	56(%rsp), %rdi
	movq	(%rax), %rax
	jmp	.L546
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L548:
	addq	$1, %rdi
	movzbl	0(%rbp,%rdi), %edx
	testb	%dl, %dl
	je	.L834
.L546:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L548
	movzbl	0(%rbp,%rdi), %edx
	movq	%rdi, %r13
	jmp	.L544
.L882:
	movq	(%rsp), %rcx
	movl	$6, %edx
	movq	%r12, %r14
	movl	%r13d, %ebx
	movl	$1, %esi
	leaq	.LC77(%rip), %rdi
	call	fwrite@PLT
	movq	40(%r15), %rax
	movb	$1, 39(%rsp)
	movq	$0, 8(%rsp)
	movq	40(%rax), %r12
	jmp	.L518
.L661:
	movb	$1, 39(%rsp)
	movq	$2, 8(%rsp)
	jmp	.L526
.L662:
	movq	%r12, %r14
	movl	%r13d, %ebx
	movq	%rdx, %r12
	jmp	.L518
.L680:
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	movq	%rdx, 48(%rsp)
	call	strcmp@PLT
	movq	48(%rsp), %rdx
	testl	%eax, %eax
	jne	.L642
	jmp	.L854
.L883:
	movl	%ebx, %r13d
	jmp	.L645
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
	je	.L888
	testl	%r13d, %r13d
	jle	.L889
	xorl	%r12d, %r12d
	leaq	.LC38(%rip), %r14
	.p2align 4
	.p2align 3
.L890:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r13d
	jne	.L890
.L889:
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
.L888:
	testl	%r13d, %r13d
	jle	.L891
	xorl	%ebx, %ebx
	leaq	.LC38(%rip), %r14
	.p2align 4
	.p2align 3
.L892:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %r12d
	leal	1(%rbx), %ebx
	cmpl	%ebx, %r13d
	jne	.L892
	xorl	%eax, %eax
	movq	%r15, %rdx
	leaq	.LC112(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L903
.L887:
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
.L903:
	.cfi_restore_state
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L897:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %r12d
	jne	.L897
.L894:
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
.L891:
	.cfi_restore_state
	xorl	%eax, %eax
	movq	%r15, %rdx
	leaq	.LC112(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L887
	jmp	.L894
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
	je	.L906
	jmp	emit_expr
	.p2align 4,,10
	.p2align 3
.L906:
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
	je	.L907
	cmpl	$1, (%rdi)
	je	.L911
.L907:
	ret
	.p2align 4,,10
	.p2align 3
.L911:
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
	je	.L944
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
	je	.L914
	ja	.L915
	testl	%eax, %eax
	je	.L916
	cmpl	$5, %eax
	jne	.L924
	movq	48(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L912
	movl	40(%rbx), %eax
	cmpl	$31, %eax
	je	.L920
	cmpl	$35, %eax
	je	.L921
	.p2align 4
	.p2align 3
.L924:
	xorl	%eax, %eax
.L912:
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
.L915:
	.cfi_restore_state
	cmpl	$10, %eax
	jne	.L924
	movq	40(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L912
	movq	48(%rbx), %rdi
	movq	%rbp, %rsi
	call	try_eval_const_expr
	jmp	.L912
	.p2align 4,,10
	.p2align 3
.L944:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L916:
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
.L914:
	.cfi_restore_state
	movq	48(%rdi), %rdi
	movq	%rsp, %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L924
	movq	56(%rbx), %rdi
	leaq	8(%rsp), %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L924
	movl	40(%rbx), %eax
	subl	$22, %eax
	cmpl	$33, %eax
	ja	.L924
	leaq	.L927(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L927:
	.long	.L940-.L927
	.long	.L939-.L927
	.long	.L938-.L927
	.long	.L937-.L927
	.long	.L936-.L927
	.long	.L935-.L927
	.long	.L924-.L927
	.long	.L924-.L927
	.long	.L934-.L927
	.long	.L933-.L927
	.long	.L932-.L927
	.long	.L931-.L927
	.long	.L930-.L927
	.long	.L924-.L927
	.long	.L924-.L927
	.long	.L924-.L927
	.long	.L924-.L927
	.long	.L924-.L927
	.long	.L924-.L927
	.long	.L924-.L927
	.long	.L924-.L927
	.long	.L924-.L927
	.long	.L924-.L927
	.long	.L924-.L927
	.long	.L924-.L927
	.long	.L924-.L927
	.long	.L924-.L927
	.long	.L924-.L927
	.long	.L924-.L927
	.long	.L924-.L927
	.long	.L924-.L927
	.long	.L929-.L927
	.long	.L928-.L927
	.long	.L926-.L927
	.text
	.p2align 4,,10
	.p2align 3
.L921:
	xorl	%eax, %eax
	cmpq	$0, 8(%rsp)
	sete	%al
	movq	%rax, 0(%rbp)
.L942:
	movl	$1, %eax
	jmp	.L912
.L926:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L942
.L928:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L942
.L929:
	movq	(%rsp), %rax
	andq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L942
.L930:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L924
	movq	(%rsp), %rax
	cqto
	idivq	%rcx
	movq	%rdx, 0(%rbp)
	jmp	.L942
.L931:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L924
	movq	(%rsp), %rax
	cqto
	idivq	%rcx
	movq	%rax, 0(%rbp)
	jmp	.L942
.L932:
	movq	(%rsp), %rax
	imulq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L942
.L933:
	movq	(%rsp), %rax
	subq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L942
.L934:
	movq	8(%rsp), %rax
	addq	(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L942
.L935:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setge	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L942
.L936:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setg	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L942
.L937:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setle	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L942
.L938:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setl	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L942
.L939:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L942
.L940:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	sete	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L942
	.p2align 4,,10
	.p2align 3
.L920:
	movq	8(%rsp), %rax
	negq	%rax
	movq	%rax, 0(%rbp)
	jmp	.L942
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
	je	.L966
	cmpl	$1, (%rdi)
	je	.L970
.L966:
	ret
	.p2align 4,,10
	.p2align 3
.L970:
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
	je	.L971
	cmpl	$1, (%rdi)
	je	.L976
.L971:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L976:
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
	je	.L989
	cmpl	$1, (%rdi)
	jne	.L989
	movq	24(%rdi), %rcx
	movq	16(%rdi), %r8
	testq	%rcx, %rcx
	je	.L989
	xorl	%edx, %edx
	jmp	.L990
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L992:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L989
.L990:
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L992
	cmpl	$1, (%rax)
	jne	.L992
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
.L993:
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r9
.L979:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L996
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L979
	cmpl	$1, (%rax)
	jne	.L979
	jmp	.L993
	.p2align 4,,10
	.p2align 3
.L989:
	.cfi_def_cfa_offset 8
	movq	%r9, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L996:
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
	je	.L998
	cmpl	$1, (%rcx)
	movq	%rcx, %r15
	jne	.L998
	cmpq	$0, 24(%rcx)
	je	.L998
	movq	%rsi, (%rsp)
	movq	%rdi, %rbx
	movl	%r9d, %ebp
	xorl	%r13d, %r13d
	movq	%r8, 8(%rsp)
.L1011:
	movq	16(%r15), %rax
	movq	(%rax,%r13,8), %r10
	testq	%r10, %r10
	je	.L1006
	movl	(%r10), %eax
	testl	%eax, %eax
	je	.L1030
	cmpl	$1, %eax
	je	.L1031
.L1006:
	addq	$1, %r13
	addq	$1, %r12
	cmpq	24(%r15), %r13
	jb	.L1011
	movq	8(%rsp), %rdx
.L998:
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
.L1030:
	.cfi_restore_state
	xorl	%r14d, %r14d
	testl	%ebp, %ebp
	jle	.L1004
	movq	%r12, 16(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L1001:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC38(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1001
	movq	16(%rsp), %r12
	movq	%r14, %r10
.L1004:
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
	je	.L1032
	movq	96(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L1005:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1006
	.p2align 4,,10
	.p2align 3
.L1031:
	movq	24(%r10), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmovne	%rax, %rdx
	xorl	%r14d, %r14d
	movq	%rdx, 16(%rsp)
	testl	%ebp, %ebp
	jle	.L1010
	movq	%r12, 24(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L1007:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC38(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1007
	movq	24(%rsp), %r12
	movq	%r14, %r10
.L1010:
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
	jne	.L1008
	movq	24(%r10), %rsi
	movq	16(%r10), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, 8(%rsp)
.L1008:
	movq	8(%rsp), %rax
	cmpq	%rdx, %rax
	cmovnb	%rax, %rdx
	movq	%rdx, 8(%rsp)
	jmp	.L1006
	.p2align 4,,10
	.p2align 3
.L1032:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1005
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
	je	.L1068
.L1034:
	movq	%r12, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC121(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%rbp)
	je	.L1040
	xorl	%ebx, %ebx
	jmp	.L1051
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1042:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L1040
.L1051:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$2, (%rax)
	jne	.L1042
	movq	8(%rax), %r14
	movq	16(%r14), %rdi
	call	get_mangled_name
	cmpl	$2, 24(%r14)
	movq	56(%r14), %r15
	movq	%rax, %r10
	je	.L1069
	testq	%r15, %r15
	je	.L1042
	movl	(%r15), %eax
	cmpl	$1, %eax
	je	.L1070
	testl	%eax, %eax
	jne	.L1042
	leaq	.LC124(%rip), %rsi
	movq	%r10, %rdx
	movq	%r12, %rdi
	call	fprintf@PLT
	movq	16(%r15), %rsi
	cmpl	$2, (%rsi)
	je	.L1071
	movq	%r13, %rdx
	movq	%r12, %rdi
	call	emit_expr
.L1050:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addq	$1, %rbx
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%rbp), %rbx
	jb	.L1051
.L1040:
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
.L1069:
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
	je	.L1042
	cmpl	$1, (%r15)
	movq	8(%rsp), %r10
	jne	.L1042
	movq	%r10, %rsi
	leaq	.LC123(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	xorl	%r8d, %r8d
	movq	%rax, %rsi
	movq	56(%r14), %rax
	testq	%rax, %rax
	je	.L1045
	cmpl	$1, (%rax)
	je	.L1072
.L1045:
	cmpq	$0, 32(%r14)
	je	.L1046
	movq	48(%r14), %rax
	movq	%r8, %rdx
	cmpq	%rax, %r8
	cmovb	%rax, %r8
	testq	%rax, %rax
	cmovle	%rdx, %r8
.L1046:
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
	jmp	.L1042
	.p2align 4,,10
	.p2align 3
.L1070:
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
	jmp	.L1042
	.p2align 4,,10
	.p2align 3
.L1068:
	movq	%rdi, %rcx
	movl	$75, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%rbp)
	je	.L1035
	xorl	%ebx, %ebx
	jmp	.L1039
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1037:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L1035
.L1039:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$2, (%rax)
	jne	.L1037
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
	jne	.L1037
	movq	%r15, %rcx
	movq	%r15, %rdx
	leaq	.LC119(%rip), %rsi
	movq	%r12, %rdi
	xorl	%eax, %eax
	addq	$1, %rbx
	call	fprintf@PLT
	cmpq	8(%rbp), %rbx
	jb	.L1039
	.p2align 4
	.p2align 3
.L1035:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1034
.L1071:
	movq	%r12, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1050
.L1072:
	movq	24(%rax), %r8
	jmp	.L1045
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
.L1074:
	movl	g_no_line(%rip), %r10d
	testl	%r10d, %r10d
	jne	.L1075
	cmpb	$0, 24(%rsp)
	jne	.L1359
.L1075:
	cmpl	$12, (%rbx)
	ja	.L1073
	movl	(%rbx), %eax
	leaq	.L1078(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1078:
	.long	.L1089-.L1078
	.long	.L1088-.L1078
	.long	.L1087-.L1078
	.long	.L1086-.L1078
	.long	.L1085-.L1078
	.long	.L1084-.L1078
	.long	.L1083-.L1078
	.long	.L1073-.L1078
	.long	.L1082-.L1078
	.long	.L1081-.L1078
	.long	.L1080-.L1078
	.long	.L1079-.L1078
	.long	.L1077-.L1078
	.text
	.p2align 4,,10
	.p2align 3
.L1359:
	movl	4(%rbx), %edx
	movq	16(%rsp), %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC39(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1075
	.p2align 4,,10
	.p2align 3
.L1077:
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
	je	.L1159
	movq	%rbx, 56(%rsp)
	movq	24(%rsp), %r13
	movq	%r14, 48(%rsp)
	movq	%rbp, %r14
	movq	40(%rsp), %rbp
	.p2align 4
	.p2align 3
.L1156:
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
	jb	.L1156
	movq	48(%rsp), %r14
	movq	56(%rsp), %rbx
.L1159:
	movl	8(%rsp), %edx
	movl	8(%rsp), %r12d
	xorl	%ebp, %ebp
	leaq	.LC38(%rip), %r13
	testl	%edx, %edx
	jle	.L1360
	.p2align 4
	.p2align 3
.L1157:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1157
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC147(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r12d
.L1160:
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 48(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1163:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1163
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
.L1164:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1164
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
.L1165:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1165
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
.L1166:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1166
	movl	32(%rsp), %edx
	xorl	%eax, %eax
	leaq	.LC158(%rip), %rsi
	movq	%r14, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r15)
	leal	2(%rax), %ebx
	je	.L1168
.L1205:
	leaq	.LC133(%rip), %rax
	movq	%r15, 16(%rsp)
	xorl	%edi, %edi
	leaq	.LC38(%rip), %rbp
	movq	%rax, 56(%rsp)
	movl	%r12d, 76(%rsp)
	movq	%rdi, %r12
	.p2align 4
	.p2align 3
.L1182:
	movq	16(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r12,8), %r13
	movq	40(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1231
	xorl	%eax, %eax
	jmp	.L1173
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1172:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1231
.L1173:
	movq	(%rsi,%rax,8), %rdx
	cmpq	(%rdx), %r13
	jne	.L1172
	movq	8(%rdx), %rax
	movq	%rax, 24(%rsp)
.L1171:
	xorl	%r15d, %r15d
	testl	%ebx, %ebx
	jle	.L1177
	.p2align 4
	.p2align 3
.L1174:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebx, %r15d
	jne	.L1174
.L1177:
	movq	56(%rsp), %rdi
	movl	$1, %esi
	movq	%r14, %rcx
	movl	$4, %edx
	call	fwrite@PLT
	movl	20(%r13), %eax
	movq	24(%r13), %rsi
	testl	%eax, %eax
	je	.L1361
	leaq	.LC128(%rip), %rdx
	cmpl	$26, %eax
	je	.L1178
	ja	.L1179
	leaq	.LC126(%rip), %rdx
	cmpl	$24, %eax
	je	.L1178
	cmpl	$25, %eax
	leaq	.LC130(%rip), %rdx
	leaq	.LC127(%rip), %rax
	cmove	%rax, %rdx
.L1178:
	movq	%rsi, %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC152(%rip), %rsi
	call	fprintf@PLT
.L1180:
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
	jb	.L1182
	movl	76(%rsp), %r12d
	leaq	.LC38(%rip), %r13
	testl	%ebx, %ebx
	jle	.L1362
.L1168:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1184:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1184
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	testl	%r12d, %r12d
	jle	.L1335
	movl	8(%rsp), %r12d
	.p2align 4
	.p2align 3
.L1185:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jg	.L1185
.L1335:
	movl	32(%rsp), %edx
	leaq	.LC156(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	.p2align 4
	.p2align 3
.L1189:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1189
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	xorl	%ebx, %ebx
	leaq	.LC137(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	jle	.L1191
	.p2align 4
	.p2align 3
.L1192:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1192
.L1191:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
.L1073:
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
.L1089:
	.cfi_restore_state
	movl	%r12d, %ebp
	xorl	%ebx, %ebx
	leaq	.LC38(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1358
	.p2align 4
	.p2align 3
.L1113:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1113
.L1358:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
.L1357:
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
.L1088:
	.cfi_restore_state
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%r12d, %r12d
	movl	8(%rsp), %r15d
	leaq	.LC38(%rip), %r13
	testl	%eax, %eax
	jle	.L1363
	.p2align 4
	.p2align 3
.L1111:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1111
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC139(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L1117
.L1116:
	movl	8(%rsp), %edi
	xorl	%r13d, %r13d
	addl	$1, %edi
	movl	%edi, 40(%rsp)
.L1124:
	movq	16(%rbx), %rdx
	movq	(%rdx,%r13,8), %r12
	testl	%ebp, %ebp
	je	.L1220
	subq	$1, %rax
	xorl	%ecx, %ecx
	cmpq	%r13, %rax
	je	.L1364
.L1119:
	movq	16(%rsp), %r8
	movl	40(%rsp), %edx
	movq	%r12, %rsi
	movq	%r14, %rdi
	call	emit_stmt
.L1122:
	movq	24(%rbx), %rax
	addq	$1, %r13
	cmpq	%rax, %r13
	jb	.L1124
	movl	8(%rsp), %r9d
	leaq	.LC38(%rip), %r13
	testl	%r9d, %r9d
	jle	.L1126
.L1117:
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1127:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1127
.L1126:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	jmp	.L1357
	.p2align 4,,10
	.p2align 3
.L1087:
	xorl	%r13d, %r13d
	cmpq	$0, 24(%rbx)
	movl	%r12d, 8(%rsp)
	leaq	.LC38(%rip), %rbp
	movl	8(%rsp), %r12d
	je	.L1073
	.p2align 4
	.p2align 3
.L1110:
	movq	16(%rbx), %rax
	movq	(%rax,%r13,8), %r15
	movq	(%r15), %rdi
	call	get_mangled_name
	movl	g_strict(%rip), %esi
	movq	%rax, 8(%rsp)
	testl	%esi, %esi
	je	.L1365
	cmpq	$0, 8(%r15)
	je	.L1202
.L1201:
	xorl	%r15d, %r15d
	testl	%r12d, %r12d
	jle	.L1132
	.p2align 4
	.p2align 3
.L1130:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1130
.L1132:
	movq	8(%rsp), %rcx
	leaq	.LC141(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	movq	%rcx, %r8
	movq	%rcx, %rdx
	call	fprintf@PLT
.L1131:
	addq	$1, %r13
	cmpq	24(%rbx), %r13
	jb	.L1110
	jmp	.L1073
	.p2align 4,,10
	.p2align 3
.L1086:
	xorl	%r15d, %r15d
	leaq	.LC38(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1136
	.p2align 4
	.p2align 3
.L1096:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1096
.L1136:
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
	jne	.L1097
.L1098:
	movq	24(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L1137
	cmpl	$1, (%rsi)
	movl	%r12d, %edx
	je	.L1138
.L1137:
	leal	1(%r12), %edx
.L1138:
	movq	16(%rsp), %r8
	movl	%ebp, %ecx
	movq	%r14, %rdi
	call	emit_stmt
	cmpq	$0, 32(%rbx)
	je	.L1073
	xorl	%ebp, %ebp
	leaq	.LC38(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1142
	.p2align 4
	.p2align 3
.L1139:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1139
.L1142:
	movq	%r14, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC142(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L1094
	jmp	.L1095
	.p2align 4,,10
	.p2align 3
.L1085:
	xorl	%ebp, %ebp
	leaq	.LC38(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1144
	.p2align 4
	.p2align 3
.L1093:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1093
.L1144:
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
	je	.L1095
.L1094:
	cmpl	$1, (%rbx)
	je	.L1143
.L1095:
	addl	$1, %r12d
.L1143:
	xorl	%ebp, %ebp
	jmp	.L1074
	.p2align 4,,10
	.p2align 3
.L1084:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	movl	8(%rsp), %r12d
	leaq	.LC38(%rip), %r13
	testl	%eax, %eax
	jle	.L1145
	.p2align 4
	.p2align 3
.L1107:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1107
.L1145:
	movq	%r14, %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC138(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%rbx)
	je	.L1366
	movq	%r14, %rsi
	movl	$32, %edi
	call	fputc@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	jmp	.L1358
	.p2align 4,,10
	.p2align 3
.L1082:
	movl	%r12d, 8(%rsp)
	xorl	%ebx, %ebx
	movl	8(%rsp), %ebp
	leaq	.LC38(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1147
	.p2align 4
	.p2align 3
.L1103:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1103
.L1147:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC137(%rip), %rdi
	jmp	.L1357
	.p2align 4,,10
	.p2align 3
.L1083:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%r12d, %r12d
	movl	8(%rsp), %r15d
	leaq	.LC38(%rip), %r13
	testl	%eax, %eax
	jle	.L1146
	.p2align 4
	.p2align 3
.L1104:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1104
.L1146:
	testl	%ebp, %ebp
	jne	.L1367
.L1106:
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	jmp	.L1358
	.p2align 4,,10
	.p2align 3
.L1080:
	movl	%r12d, %eax
	movl	%r12d, 8(%rsp)
	xorl	%ebp, %ebp
	movl	8(%rsp), %r12d
	leaq	.LC38(%rip), %r13
	testl	%eax, %eax
	jle	.L1149
	.p2align 4
	.p2align 3
.L1099:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1099
.L1149:
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
	je	.L1101
	.p2align 4
	.p2align 3
.L1100:
	xorl	%ebx, %ebx
	testl	%r15d, %r15d
	js	.L1151
	.p2align 4
	.p2align 3
.L1150:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r15d
	jge	.L1150
.L1151:
	addq	$1, %r12
	xorl	%eax, %eax
	movq	%r13, %rsi
	movq	%r14, %rdi
	movq	%r12, %rcx
	movq	%r12, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %r12
	jb	.L1100
.L1101:
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	js	.L1152
	xorl	%ebx, %ebx
	leaq	.LC38(%rip), %r13
	.p2align 4
	.p2align 3
.L1153:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jge	.L1153
	movq	%r14, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	je	.L1126
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1155:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1155
	jmp	.L1126
	.p2align 4,,10
	.p2align 3
.L1081:
	movl	%r12d, 8(%rsp)
	xorl	%ebx, %ebx
	movl	8(%rsp), %ebp
	leaq	.LC38(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1148
	.p2align 4
	.p2align 3
.L1102:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1102
.L1148:
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC136(%rip), %rdi
	jmp	.L1357
	.p2align 4,,10
	.p2align 3
.L1079:
	xorl	%ebp, %ebp
	leaq	.LC38(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1368
	.p2align 4
	.p2align 3
.L1090:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1090
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 8(%rsp)
	testq	%rbp, %rbp
	je	.L1369
.L1091:
	movq	function_labels(%rip), %r15
	xorl	%r13d, %r13d
	jmp	.L1197
	.p2align 4,,10
	.p2align 3
.L1195:
	addq	$1, %r13
	cmpq	%rbp, %r13
	je	.L1092
.L1197:
	movq	(%r15,%r13,8), %rsi
	movq	8(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1195
	leal	1(%r13), %edx
.L1196:
	leaq	.LC157(%rip), %rsi
	movq	%r14, %rdi
	leal	1(%r12), %r15d
	xorl	%eax, %eax
	call	fprintf@PLT
	leaq	.LC38(%rip), %r13
	testl	%r15d, %r15d
	jle	.L1200
.L1198:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1199:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jne	.L1199
.L1200:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movl	%r15d, %r12d
	leaq	.LC115(%rip), %rdi
	xorl	%ebp, %ebp
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	jmp	.L1074
	.p2align 4,,10
	.p2align 3
.L1231:
	movq	$0, 24(%rsp)
	jmp	.L1171
	.p2align 4,,10
	.p2align 3
.L1361:
	movl	16(%r13), %eax
	testl	%eax, %eax
	je	.L1181
	movq	32(%r13), %rcx
	movq	%rsi, %rdx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC153(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1180
	.p2align 4,,10
	.p2align 3
.L1365:
	movq	16(%rsp), %rcx
	movl	%r12d, %edx
	movq	%r15, %rsi
	movq	%r14, %rdi
	call	emit_auto_storage
	cmpq	$0, 8(%r15)
	jne	.L1201
	movl	g_strict(%rip), %ecx
	testl	%ecx, %ecx
	je	.L1131
	.p2align 4
	.p2align 3
.L1202:
	xorl	%r15d, %r15d
	testl	%r12d, %r12d
	jle	.L1134
	.p2align 4
	.p2align 3
.L1133:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1133
.L1134:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1131
.L1364:
	cmpl	$6, (%r12)
	movl	%ebp, %ecx
	jne	.L1119
	movl	g_no_line(%rip), %r8d
	testl	%r8d, %r8d
	jne	.L1120
	cmpb	$0, 24(%rsp)
	je	.L1120
	movl	4(%r12), %edx
	movq	16(%rsp), %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC39(%rip), %rsi
	call	fprintf@PLT
.L1120:
	movl	8(%rsp), %edi
	leaq	.LC38(%rip), %rax
	xorl	%r15d, %r15d
	movq	%rax, 32(%rsp)
	testl	%edi, %edi
	js	.L1123
	.p2align 4
	.p2align 3
.L1121:
	movq	32(%rsp), %rdi
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r15d
	call	fwrite@PLT
	cmpl	%r15d, 8(%rsp)
	jge	.L1121
.L1123:
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
	jmp	.L1122
	.p2align 4,,10
	.p2align 3
.L1181:
	movq	%rsi, %rdx
	movq	%r14, %rdi
	leaq	.LC154(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1180
	.p2align 4,,10
	.p2align 3
.L1220:
	xorl	%ecx, %ecx
	jmp	.L1119
	.p2align 4,,10
	.p2align 3
.L1179:
	cmpl	$27, %eax
	leaq	.LC130(%rip), %rdx
	leaq	.LC129(%rip), %rax
	cmove	%rax, %rdx
	jmp	.L1178
.L1097:
	xorl	%ebp, %ebp
	cmpq	$0, 32(%rbx)
	sete	%bpl
	jmp	.L1098
.L1362:
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	xorl	%eax, %eax
	movq	%r14, %rdi
	call	fprintf@PLT
	testl	%r12d, %r12d
	jle	.L1356
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
.L1356:
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
	jmp	.L1191
.L1368:
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 8(%rsp)
	testq	%rbp, %rbp
	jne	.L1091
.L1092:
	xorl	%edx, %edx
	jmp	.L1196
.L1367:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC140(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1106
.L1366:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC143(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1358
.L1152:
	movq	%r14, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1126
.L1363:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC139(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	jne	.L1116
	jmp	.L1126
.L1360:
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC147(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r12d
	testl	%eax, %eax
	je	.L1160
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
	jne	.L1205
	cmpl	$1, %ebx
	je	.L1168
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1356
	.p2align 4,,10
	.p2align 3
.L1369:
	xorl	%edx, %edx
	leaq	.LC157(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%r12), %r15d
	jmp	.L1198
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
	leaq	.L1375(%rip), %r15
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
	je	.L1370
.L1371:
	cmpl	$13, 0(%r13)
	ja	.L1373
	movl	0(%r13), %eax
	movslq	(%r15,%rax,4), %rax
	addq	%r15, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1375:
	.long	.L1373-.L1375
	.long	.L1379-.L1375
	.long	.L1373-.L1375
	.long	.L1378-.L1375
	.long	.L1377-.L1375
	.long	.L1373-.L1375
	.long	.L1373-.L1375
	.long	.L1373-.L1375
	.long	.L1373-.L1375
	.long	.L1373-.L1375
	.long	.L1373-.L1375
	.long	.L1376-.L1375
	.long	.L1373-.L1375
	.long	.L1374-.L1375
	.text
	.p2align 4,,10
	.p2align 3
.L1373:
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
.L1374:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1423
	xorl	%eax, %eax
	jmp	.L1393
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1392:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1423
.L1393:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%r13, (%rdx)
	jne	.L1392
	movq	8(%rdx), %r14
.L1391:
	xorl	%r13d, %r13d
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1457
	.p2align 4
	.p2align 3
.L1394:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1394
	movq	%r14, %rdx
	leaq	.LC159(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1397:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jle	.L1397
.L1396:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	jmp	.L1456
	.p2align 4,,10
	.p2align 3
.L1376:
	xorl	%r14d, %r14d
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1458
	.p2align 4
	.p2align 3
.L1380:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1380
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L1459
.L1381:
	movq	function_labels(%rip), %r14
	xorl	%r12d, %r12d
	jmp	.L1401
	.p2align 4,,10
	.p2align 3
.L1399:
	addq	$1, %r12
	cmpq	%r12, 24(%rsp)
	je	.L1382
.L1401:
	movq	(%r14,%r12,8), %rsi
	movq	16(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1399
	leal	1(%r12), %edx
.L1400:
	leaq	.LC157(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	leaq	.LC38(%rip), %r12
	movl	%eax, 16(%rsp)
	testl	%eax, %eax
	jle	.L1460
.L1402:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1404:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, %ebp
	jne	.L1404
	movl	16(%rsp), %ebp
.L1405:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	jne	.L1371
	jmp	.L1370
	.p2align 4,,10
	.p2align 3
.L1377:
	xorl	%r14d, %r14d
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1417
	.p2align 4
	.p2align 3
.L1383:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1383
.L1417:
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
	je	.L1370
.L1384:
	xorl	%eax, %eax
	cmpl	$1, 0(%r13)
	setne	%al
	addl	%eax, %ebp
	jmp	.L1371
	.p2align 4,,10
	.p2align 3
.L1378:
	xorl	%r14d, %r14d
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1412
	.p2align 4
	.p2align 3
.L1386:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1386
.L1412:
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
	je	.L1388
	cmpl	$1, (%rsi)
	movl	%ebp, %edx
	je	.L1413
.L1388:
	leal	1(%rbp), %edx
.L1413:
	movq	(%rsp), %r8
	movq	8(%rsp), %rcx
	movq	%rbx, %rdi
	call	emit_stmt_switchctx
	cmpq	$0, 32(%r13)
	je	.L1370
	xorl	%r14d, %r14d
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1416
	.p2align 4
	.p2align 3
.L1414:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1414
.L1416:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC142(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r13), %r13
	testq	%r13, %r13
	jne	.L1384
.L1370:
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
.L1379:
	.cfi_restore_state
	xorl	%r15d, %r15d
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1461
	.p2align 4
	.p2align 3
.L1389:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebp, %r15d
	jne	.L1389
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC139(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	je	.L1407
.L1406:
	leal	1(%rbp), %r12d
	xorl	%r15d, %r15d
.L1409:
	movq	16(%r13), %rax
	movq	(%rsp), %r8
	movl	%r12d, %edx
	movq	%rbx, %rdi
	movq	8(%rsp), %rcx
	movq	(%rax,%r15,8), %rsi
	addq	$1, %r15
	call	emit_stmt_switchctx
	cmpq	24(%r13), %r15
	jb	.L1409
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1408
.L1407:
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1411:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1411
.L1408:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
.L1456:
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
.L1423:
	.cfi_restore_state
	xorl	%r14d, %r14d
	jmp	.L1391
	.p2align 4,,10
	.p2align 3
.L1458:
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	jne	.L1381
	.p2align 4
	.p2align 3
.L1382:
	xorl	%edx, %edx
	jmp	.L1400
.L1459:
	xorl	%edx, %edx
	leaq	.LC157(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	movl	%eax, 16(%rsp)
	jmp	.L1402
	.p2align 4,,10
	.p2align 3
.L1457:
	xorl	%eax, %eax
	movq	%r14, %rdx
	leaq	.LC159(%rip), %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	testl	%ebp, %ebp
	jne	.L1396
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	jmp	.L1396
	.p2align 4,,10
	.p2align 3
.L1460:
	movl	%eax, %ebp
	jmp	.L1405
	.p2align 4,,10
	.p2align 3
.L1461:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC139(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	jne	.L1406
	jmp	.L1408
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
	movq	%rdx, 8(%rsp)
	je	.L1462
	movq	%rdi, %rbp
	movq	%rsi, %r12
	xorl	%ebx, %ebx
	jmp	.L1476
	.p2align 4,,10
	.p2align 3
.L1465:
	addq	$1, %rbx
	cmpq	8(%r12), %rbx
	jnb	.L1462
.L1476:
	movq	(%r12), %rax
	movq	(%rax,%rbx,8), %r14
	movl	(%r14), %eax
	testl	%eax, %eax
	je	.L1494
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L1465
	movq	8(%r14), %r13
	movq	16(%r13), %rdi
	call	get_mangled_name
	cmpl	$3, (%r14)
	movq	%rax, %r15
	je	.L1495
	cmpl	$1, 24(%r13)
	movl	$1, %r8d
	jne	.L1470
	movq	56(%r13), %rdi
	movl	$1, %r11d
	testq	%rdi, %rdi
	je	.L1471
	cmpl	$1, (%rdi)
	je	.L1496
.L1471:
	call	edge_tail_words_top
	leaq	(%rax,%r11), %r8
	movl	$1, %eax
	testq	%r8, %r8
	cmove	%rax, %r8
.L1470:
	movl	4(%r13), %eax
	leaq	.LC161(%rip), %rdx
	testl	%eax, %eax
	je	.L1472
	leaq	.LC160(%rip), %rdx
.L1472:
	xorl	%eax, %eax
	movq	%r15, %rcx
	leaq	.LC164(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$2, 24(%r13)
	jne	.L1465
	movq	56(%r13), %rdi
	xorl	%r11d, %r11d
	testq	%rdi, %rdi
	je	.L1473
	cmpl	$1, (%rdi)
	je	.L1497
.L1473:
	cmpq	$0, 32(%r13)
	je	.L1474
	movq	48(%r13), %rax
	movq	%r11, %rdx
	cmpq	%rax, %r11
	cmovb	%rax, %r11
	testq	%rax, %rax
	cmovle	%rdx, %r11
.L1474:
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
	jb	.L1476
.L1462:
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
.L1494:
	.cfi_restore_state
	movq	8(%r14), %rsi
	movq	8(%rsp), %r8
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbp, %rdi
	call	emit_stmt
	jmp	.L1465
	.p2align 4,,10
	.p2align 3
.L1495:
	movq	16(%r13), %rdi
	call	global_data_kind
	testl	%eax, %eax
	je	.L1465
	movl	8(%r13), %esi
	testl	%esi, %esi
	je	.L1469
	pushq	%r15
	.cfi_def_cfa_offset 88
	movq	%r15, %rcx
	movq	%r15, %rdx
	movq	%r15, %r9
	pushq	%r15
	.cfi_def_cfa_offset 96
	movq	%r15, %r8
	leaq	.LC162(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	popq	%rdx
	.cfi_def_cfa_offset 88
	popq	%rcx
	.cfi_def_cfa_offset 80
	jmp	.L1465
	.p2align 4,,10
	.p2align 3
.L1496:
	movq	24(%rdi), %r11
	jmp	.L1471
	.p2align 4,,10
	.p2align 3
.L1469:
	movq	%r15, %rdx
	leaq	.LC163(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1465
.L1497:
	movq	24(%rdi), %r11
	jmp	.L1473
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
	jne	.L1511
.L1499:
	cmpl	$16, current_word_bits(%rip)
	je	.L1512
.L1503:
	cmpq	$0, 8+function_labels(%rip)
	je	.L1505
	xorl	%ebx, %ebx
	leaq	.LC168(%rip), %r14
	.p2align 4
	.p2align 3
.L1506:
	addq	$1, %rbx
	xorl	%eax, %eax
	movq	%r14, %rsi
	movq	%rbp, %rdi
	movq	%rbx, %rcx
	movq	%rbx, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %rbx
	jb	.L1506
.L1505:
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
.L1512:
	.cfi_restore_state
	cmpq	$0, 16(%r12)
	je	.L1503
	xorl	%r14d, %r14d
	leaq	.LC167(%rip), %rbx
	.p2align 4
	.p2align 3
.L1504:
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
	jb	.L1504
	jmp	.L1503
	.p2align 4,,10
	.p2align 3
.L1511:
	movq	32(%r12), %rdi
	pxor	%xmm0, %xmm0
	movq	%rsp, %rsi
	movq	$0, 16(%rsp)
	movaps	%xmm0, (%rsp)
	call	collect_function_autos
	cmpq	$0, 8(%rsp)
	je	.L1500
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1501:
	movq	(%rsp), %rax
	movq	%r13, %rcx
	movl	$1, %edx
	movq	%rbp, %rdi
	movq	(%rax,%rbx,8), %rsi
	addq	$1, %rbx
	call	emit_auto_storage
	cmpq	8(%rsp), %rbx
	jb	.L1501
.L1500:
	cmpq	$0, g_compilation_arena(%rip)
	jne	.L1499
	movq	(%rsp), %rdi
	call	free@PLT
	jmp	.L1499
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
	.ascii	"1));\n}\n\nstatic word b_putnum(word n) {\n    b_printn(n, ("
	.ascii	"word)10);\n    return n;\n}\nstatic volatile sig_atomic_t __"
	.ascii	"b_got_intr = 0;\n\nstatic void __b_si"
	.ascii	"gint(int sig){ (void)sig; __b_got_intr = 1; }\n\nstatic word"
	.ascii	" b_gtty(word fd, word ttstat){\n    struct termios t;\n    i"
	.ascii	"f (tcgetattr((int)fd, &t) < 0) return -1;\n\n    word *vec ="
	.ascii	" (word*)B_CPTR(ttstat);\n    vec[0] = (word)t.c_iflag;\n    "
	.ascii	"vec[1] = (word)t.c_oflag;\n    vec[2] = (word)t.c_lflag;\n  "
	.ascii	"  return 0;\n}\n\nstatic word b_stty(word fd, word ttstat){\n"
	.ascii	"    struct termios t;\n    if (tcgetattr((int)fd, &t) < 0) r"
	.ascii	"eturn -1;\n\n    word *vec = (word*)B_CPTR(ttstat);\n    t.c"
	.ascii	"_iflag = (tcflag_t)vec[0];\n    t.c_oflag = (tcflag_t)vec[1]"
	.ascii	";\n    t.c_lflag = (tcflag_t)vec[2];\n    return (word)tcset"
	.ascii	"attr((int)fd, TCSANOW, &t);\n}\nstatic word b_intr(word on) "
	.ascii	"{\n    /* Set up interrupt handling */\n    /* on != 0: catc"
	.ascii	"h interrupts, on =="
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
	movq	%rsi, current_program(%rip)
	movq	%rdx, 8(%rsp)
	movl	%ecx, current_byteptr(%rip)
	movl	%r9d, current_word_bits(%rip)
	movq	$0, string_pool(%rip)
	movq	$0, 8+name_map(%rip)
	movups	%xmm0, 8+string_pool(%rip)
	call	collect_strings_program
	movl	g_use_curses(%rip), %esi
	testl	%esi, %esi
	jne	.L1546
.L1514:
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
	movl	$12971, %edx
	movl	$1, %esi
	leaq	.LC184(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1547
.L1515:
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
	je	.L1513
	movq	$0, 24(%rsp)
	xorl	%ebp, %ebp
	movl	$0, 20(%rsp)
	.p2align 5
	.p2align 4
	.p2align 3
.L1525:
	movq	(%r12), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$1, (%rax)
	je	.L1548
.L1517:
	addq	$1, %rbp
	cmpq	8(%r12), %rbp
	jb	.L1525
	movl	20(%rsp), %eax
	testl	%eax, %eax
	jne	.L1549
.L1513:
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
.L1548:
	.cfi_restore_state
	movq	8(%rax), %r14
	leaq	.LC22(%rip), %rsi
	movq	(%r14), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1518
	leaq	.LC25(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1519
.L1518:
	movq	16(%r14), %rax
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC185(%rip), %rdi
	movq	%rax, 24(%rsp)
	call	fwrite@PLT
	movl	$1, 20(%rsp)
.L1520:
	cmpq	$0, 16(%r14)
	je	.L1522
	xorl	%r13d, %r13d
	leaq	.LC29(%rip), %r15
	jmp	.L1524
	.p2align 4,,10
	.p2align 3
.L1550:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
.L1524:
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r14), %rax
	movq	(%rax,%r13,8), %rdi
	testq	%rdi, %rdi
	je	.L1523
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1523:
	addq	$1, %r13
	cmpq	16(%r14), %r13
	jb	.L1550
.L1522:
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
	jmp	.L1517
	.p2align 4,,10
	.p2align 3
.L1549:
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
	je	.L1531
	cmpq	$1, 24(%rsp)
	je	.L1551
	cmpq	$2, 24(%rsp)
	jne	.L1531
	movq	%rbx, %rcx
	movl	$60, %edx
	movl	$1, %esi
	leaq	.LC191(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1529
	.p2align 4,,10
	.p2align 3
.L1547:
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1515
	.p2align 4,,10
	.p2align 3
.L1546:
	movq	%rbx, %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC170(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1514
	.p2align 4,,10
	.p2align 3
.L1531:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC189(%rip), %rdi
	call	fwrite@PLT
.L1529:
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
.L1519:
	.cfi_restore_state
	leaq	.LC29(%rip), %r15
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
	movq	(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1521
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1521:
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1520
.L1551:
	movq	%rbx, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC190(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1529
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
	je	.L1586
	pxor	%xmm0, %xmm0
	movq	%rsi, %rdi
	movl	%r9d, current_word_bits(%rip)
	movups	%xmm0, 8+string_pool(%rip)
	movq	%rsi, current_program(%rip)
	movl	%ecx, current_byteptr(%rip)
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
	jne	.L1587
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1588
.L1555:
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
	je	.L1552
	movq	$0, 24(%rsp)
	xorl	%ebx, %ebx
	movl	$0, 20(%rsp)
	.p2align 5
	.p2align 4
	.p2align 3
.L1565:
	movq	(%r12), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$1, (%rax)
	je	.L1589
.L1557:
	addq	$1, %rbx
	cmpq	8(%r12), %rbx
	jb	.L1565
	movl	20(%rsp), %eax
	testl	%eax, %eax
	jne	.L1590
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
	ret
	.p2align 4,,10
	.p2align 3
.L1588:
	.cfi_restore_state
	movq	%rbp, %rdi
	call	emit_string_pool
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1555
	.p2align 4,,10
	.p2align 3
.L1587:
	movq	%rbp, %rcx
	movl	$41, %edx
	movl	$1, %esi
	leaq	.LC194(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	je	.L1555
	jmp	.L1588
	.p2align 4,,10
	.p2align 3
.L1590:
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
	je	.L1571
	cmpq	$1, 24(%rsp)
	je	.L1591
	cmpq	$2, 24(%rsp)
	je	.L1592
.L1571:
	movq	%rbp, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC189(%rip), %rdi
	call	fwrite@PLT
.L1569:
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
.L1589:
	.cfi_restore_state
	movq	8(%rax), %r14
	leaq	.LC22(%rip), %rsi
	movq	(%r14), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1558
	leaq	.LC25(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1559
.L1558:
	movq	16(%r14), %rax
	movq	%rbp, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC185(%rip), %rdi
	movq	%rax, 24(%rsp)
	call	fwrite@PLT
	movl	$1, 20(%rsp)
.L1560:
	cmpq	$0, 16(%r14)
	je	.L1562
	xorl	%r13d, %r13d
	leaq	.LC29(%rip), %r15
	jmp	.L1564
	.p2align 4,,10
	.p2align 3
.L1593:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
.L1564:
	movq	%r15, %rdi
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r14), %rax
	movq	(%rax,%r13,8), %rdi
	testq	%rdi, %rdi
	je	.L1563
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1563:
	addq	$1, %r13
	cmpq	16(%r14), %r13
	jb	.L1593
.L1562:
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
	jmp	.L1557
	.p2align 4,,10
	.p2align 3
.L1586:
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
.L1559:
	.cfi_restore_state
	leaq	.LC29(%rip), %r15
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
	movq	(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1561
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1561:
	movq	%rbp, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1560
.L1592:
	movq	%rbp, %rcx
	movl	$60, %edx
	movl	$1, %esi
	leaq	.LC191(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1569
.L1591:
	movq	%rbp, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC190(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1569
	.cfi_endproc
.LFE65:
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
	.string	"intr"
.LC235:
	.string	"gtty"
.LC236:
	.string	"stty"
.LC237:
	.string	"system"
.LC238:
	.string	"usleep"
.LC239:
	.string	"argc"
	.section	.data.rel.ro.local,"aw"
	.align 32
	.type	names.0, @object
	.size	names.0, 408
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
	.quad	.LC76
	.quad	.LC203
	.quad	.LC204
	.quad	.LC205
	.quad	.LC206
	.quad	.LC83
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
	.quad	.LC71
	.quad	.LC239
	.quad	.LC34
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
.LC240:
	.string	"break"
.LC241:
	.string	"case"
.LC242:
	.string	"const"
.LC243:
	.string	"continue"
.LC244:
	.string	"default"
.LC245:
	.string	"do"
.LC246:
	.string	"double"
.LC247:
	.string	"else"
.LC248:
	.string	"enum"
.LC249:
	.string	"extern"
.LC250:
	.string	"float"
.LC251:
	.string	"for"
.LC252:
	.string	"goto"
.LC253:
	.string	"if"
.LC254:
	.string	"inline"
.LC255:
	.string	"int"
.LC256:
	.string	"long"
.LC257:
	.string	"register"
.LC258:
	.string	"restrict"
.LC259:
	.string	"short"
.LC260:
	.string	"signed"
.LC261:
	.string	"sizeof"
.LC262:
	.string	"static"
.LC263:
	.string	"struct"
.LC264:
	.string	"switch"
.LC265:
	.string	"typedef"
.LC266:
	.string	"union"
.LC267:
	.string	"unsigned"
.LC268:
	.string	"void"
.LC269:
	.string	"volatile"
.LC270:
	.string	"while"
.LC271:
	.string	"_Bool"
.LC272:
	.string	"_Complex"
.LC273:
	.string	"_Imaginary"
.LC274:
	.string	"_Alignas"
.LC275:
	.string	"_Alignof"
.LC276:
	.string	"_Atomic"
.LC277:
	.string	"_Generic"
.LC278:
	.string	"_Noreturn"
.LC279:
	.string	"_Static_assert"
.LC280:
	.string	"_Thread_local"
.LC281:
	.string	"NULL"
.LC282:
	.string	"true"
.LC283:
	.string	"false"
.LC284:
	.string	"bool"
.LC285:
	.string	"B_PTR"
.LC286:
	.string	"B_ADDR"
.LC287:
	.string	"B_DEREF"
	.section	.data.rel.ro.local
	.align 32
	.type	c_keywords, @object
	.size	c_keywords, 424
c_keywords:
	.quad	.LC14
	.quad	.LC240
	.quad	.LC241
	.quad	.LC13
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
	.quad	.LC138
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
	.quad	.LC278
	.quad	.LC279
	.quad	.LC280
	.quad	.LC281
	.quad	.LC282
	.quad	.LC283
	.quad	.LC284
	.quad	.LC30
	.quad	.LC285
	.quad	.LC286
	.quad	.LC287
	.quad	0
	.local	name_map
	.comm	name_map,24,16
	.local	string_pool
	.comm	string_pool,24,16
	.local	current_word_bits
	.comm	current_word_bits,4,4
	.section	.note.GNU-stack,"",@progbits
