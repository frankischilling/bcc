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
.LFB33:
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
.LFE33:
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
	je	.L57
	movq	string_pool(%rip), %r14
	xorl	%ebx, %ebx
	jmp	.L60
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L58:
	addq	$1, %rbx
	cmpq	%r13, %rbx
	je	.L57
.L60:
	movq	(%r14,%rbx,8), %rbp
	cmpq	%r12, 8(%rbp)
	jne	.L58
	movq	0(%rbp), %rdi
	movq	%r12, %rdx
	movq	%r15, %rsi
	call	memcmp@PLT
	testl	%eax, %eax
	jne	.L58
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
.L57:
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
.LFB29:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L90
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L71(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L68:
	cmpl	$10, (%rbx)
	ja	.L66
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L71:
	.long	.L66-.L71
	.long	.L79-.L71
	.long	.L66-.L71
	.long	.L78-.L71
	.long	.L70-.L71
	.long	.L94-.L71
	.long	.L94-.L71
	.long	.L93-.L71
	.long	.L93-.L71
	.long	.L72-.L71
	.long	.L70-.L71
	.text
	.p2align 4,,10
	.p2align 3
.L70:
	movq	32(%rbx), %rdi
	call	collect_strings_expr
.L94:
	movq	40(%rbx), %rbx
.L81:
	testq	%rbx, %rbx
	jne	.L68
.L66:
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
.L72:
	.cfi_restore_state
	movq	32(%rbx), %rdi
	call	collect_strings_expr
.L93:
	movq	40(%rbx), %rdi
	call	collect_strings_expr
	movq	48(%rbx), %rbx
	jmp	.L81
	.p2align 4,,10
	.p2align 3
.L78:
	movq	32(%rbx), %rdi
	call	collect_strings_expr
	cmpq	$0, 48(%rbx)
	je	.L66
	xorl	%ebp, %ebp
.L80:
	movq	40(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_expr
	cmpq	48(%rbx), %rbp
	jb	.L80
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
.L79:
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
.L90:
	ret
	.cfi_endproc
.LFE29:
	.size	collect_strings_expr, .-collect_strings_expr
	.p2align 4
	.type	collect_strings_init, @function
collect_strings_init:
.LFB30:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L104
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
	je	.L107
	cmpl	$1, %eax
	je	.L108
.L95:
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
.L107:
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
.L108:
	.cfi_restore_state
	cmpq	$0, 24(%rdi)
	je	.L95
	xorl	%ebp, %ebp
.L98:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_init
	cmpq	24(%rbx), %rbp
	jb	.L98
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L104:
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE30:
	.size	collect_strings_init, .-collect_strings_init
	.p2align 4
	.type	collect_strings_stmt, @function
collect_strings_stmt:
.LFB31:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L132
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L114(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L111:
	cmpl	$12, (%rbx)
	ja	.L109
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L114:
	.long	.L109-.L114
	.long	.L121-.L114
	.long	.L109-.L114
	.long	.L120-.L114
	.long	.L113-.L114
	.long	.L117-.L114
	.long	.L117-.L114
	.long	.L109-.L114
	.long	.L109-.L114
	.long	.L109-.L114
	.long	.L117-.L114
	.long	.L115-.L114
	.long	.L113-.L114
	.text
	.p2align 4,,10
	.p2align 3
.L117:
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
.L121:
	.cfi_restore_state
	cmpq	$0, 24(%rbx)
	je	.L109
	xorl	%ebp, %ebp
.L122:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_stmt
	cmpq	24(%rbx), %rbp
	jb	.L122
.L109:
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
.L113:
	.cfi_restore_state
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rbx
.L123:
	testq	%rbx, %rbx
	jne	.L111
	jmp	.L109
	.p2align 4,,10
	.p2align 3
.L115:
	movq	24(%rbx), %rbx
	jmp	.L123
	.p2align 4,,10
	.p2align 3
.L120:
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rdi
	call	collect_strings_stmt
	movq	32(%rbx), %rbx
	jmp	.L123
	.p2align 4,,10
	.p2align 3
.L132:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE31:
	.size	collect_strings_stmt, .-collect_strings_stmt
	.p2align 4
	.type	collect_strings_program, @function
collect_strings_program:
.LFB32:
	.cfi_startproc
	cmpq	$0, 8(%rdi)
	je	.L145
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
	jmp	.L142
	.p2align 4,,10
	.p2align 3
.L138:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L148
.L142:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L149
	cmpl	$2, %eax
	je	.L150
	testl	%eax, %eax
	jne	.L138
	movq	8(%rdx), %rdi
	addq	$1, %rbx
	call	collect_strings_stmt
	cmpq	8(%rbp), %rbx
	jb	.L142
.L148:
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
.L149:
	.cfi_restore_state
	movq	8(%rdx), %rax
	movq	32(%rax), %rdi
	call	collect_strings_stmt
	jmp	.L138
	.p2align 4,,10
	.p2align 3
.L150:
	movq	8(%rdx), %r12
	movq	48(%r12), %rdi
	call	collect_strings_init
	movq	24(%r12), %rdi
	testq	%rdi, %rdi
	je	.L138
	call	collect_strings_expr
	jmp	.L138
	.p2align 4,,10
	.p2align 3
.L145:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE32:
	.size	collect_strings_program, .-collect_strings_program
	.p2align 4
	.type	collect_cases, @function
collect_cases:
.LFB42:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L173
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	leaq	.L156(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
.L153:
	cmpl	$13, (%rbx)
	ja	.L151
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L156:
	.long	.L151-.L156
	.long	.L160-.L156
	.long	.L151-.L156
	.long	.L159-.L156
	.long	.L158-.L156
	.long	.L151-.L156
	.long	.L151-.L156
	.long	.L151-.L156
	.long	.L151-.L156
	.long	.L151-.L156
	.long	.L151-.L156
	.long	.L158-.L156
	.long	.L151-.L156
	.long	.L155-.L156
	.text
	.p2align 4,,10
	.p2align 3
.L160:
	xorl	%r12d, %r12d
	cmpq	$0, 24(%rbx)
	je	.L151
.L161:
	movq	16(%rbx), %rax
	movq	%rbp, %rsi
	movq	(%rax,%r12,8), %rdi
	addq	$1, %r12
	call	collect_cases
	cmpq	24(%rbx), %r12
	jb	.L161
.L151:
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
.L158:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L162:
	testq	%rbx, %rbx
	jne	.L153
	jmp	.L151
	.p2align 4,,10
	.p2align 3
.L155:
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
.L159:
	.cfi_restore_state
	movq	24(%rbx), %rdi
	movq	%rbp, %rsi
	call	collect_cases
	movq	32(%rbx), %rbx
	jmp	.L162
	.p2align 4,,10
	.p2align 3
.L173:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE42:
	.size	collect_cases, .-collect_cases
	.p2align 4
	.type	collect_function_labels, @function
collect_function_labels:
.LFB38:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L198
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L181(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L178:
	cmpl	$12, (%rbx)
	ja	.L176
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L181:
	.long	.L176-.L181
	.long	.L185-.L181
	.long	.L176-.L181
	.long	.L184-.L181
	.long	.L180-.L181
	.long	.L176-.L181
	.long	.L176-.L181
	.long	.L176-.L181
	.long	.L176-.L181
	.long	.L176-.L181
	.long	.L176-.L181
	.long	.L182-.L181
	.long	.L180-.L181
	.text
	.p2align 4,,10
	.p2align 3
.L185:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L176
.L186:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_function_labels
	cmpq	24(%rbx), %rbp
	jb	.L186
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
.L180:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L187:
	testq	%rbx, %rbx
	jne	.L178
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
.L182:
	.cfi_restore_state
	movq	16(%rbx), %rsi
	leaq	function_labels(%rip), %rdi
	call	vec_push@PLT
	movq	24(%rbx), %rbx
	jmp	.L187
	.p2align 4,,10
	.p2align 3
.L184:
	movq	24(%rbx), %rdi
	call	collect_function_labels
	movq	32(%rbx), %rbx
	jmp	.L187
	.p2align 4,,10
	.p2align 3
.L198:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE38:
	.size	collect_function_labels, .-collect_function_labels
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
	je	.L206
	movq	%rdi, %r12
	movq	%rsi, %rbp
	xorl	%ebx, %ebx
.L205:
	movq	(%r12,%rbx,8), %rax
	testq	%rax, %rax
	je	.L204
	cmpl	$1, (%rax)
	je	.L212
.L204:
	addq	$1, %rbx
	cmpq	%rbp, %rbx
	jne	.L205
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
.L212:
	.cfi_restore_state
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r13
	jmp	.L204
	.p2align 4,,10
	.p2align 3
.L206:
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
.LC13:
	.string	"char"
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
	.string	"b_%s"
.LC21:
	.string	"__bcc_user_"
	.text
	.p2align 4
	.type	get_mangled_name, @function
get_mangled_name:
.LFB22:
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
	je	.L254
	movq	8+name_map(%rip), %r13
	movq	%rdi, %rbx
	testq	%r13, %r13
	je	.L215
	movq	name_map(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L217
	.p2align 4,,10
	.p2align 3
.L216:
	addq	$1, %rbp
	cmpq	%r13, %rbp
	je	.L215
.L217:
	movq	(%r14,%rbp,8), %r12
	movq	%rbx, %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L216
	movq	8(%r12), %rbp
.L213:
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
.L215:
	.cfi_restore_state
	cmpb	$0, (%rbx)
	je	.L285
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
	ja	.L220
	movabsq	$288230372997595135, %rsi
	btq	%rax, %rsi
	jnc	.L220
	movb	%dl, 0(%rbp)
.L224:
	leaq	1(%rbx), %r12
	leaq	(%rbx,%rcx), %r15
	movabsq	$288230372997595135, %r13
	cmpq	$1, %rcx
	ja	.L234
	jmp	.L226
	.p2align 4,,10
	.p2align 3
.L227:
	leal	-65(%rdx), %eax
	cmpb	$57, %al
	ja	.L230
	btq	%rax, %r13
	jnc	.L230
.L228:
	movb	%dl, (%r14)
	addq	$1, %r14
.L233:
	addq	$1, %r12
	cmpq	%r12, %r15
	je	.L226
.L234:
	movzbl	(%r12), %edx
	cmpb	$57, %dl
	jg	.L227
	cmpb	$47, %dl
	jg	.L228
	cmpb	$46, %dl
	jne	.L230
	addq	$1, %r12
	movb	$95, (%r14)
	addq	$1, %r14
	cmpq	%r12, %r15
	jne	.L234
.L226:
	movb	$0, (%r14)
	jmp	.L219
	.p2align 4,,10
	.p2align 3
.L285:
	leaq	.LC15(%rip), %rdi
	call	sdup@PLT
	movq	%rax, %rbp
.L219:
	leaq	8+names.0(%rip), %r13
	leaq	.LC13(%rip), %rsi
	movq	%r13, %r12
	jmp	.L236
	.p2align 4,,10
	.p2align 3
.L287:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L286
.L236:
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L287
.L235:
	movq	%rbp, %rdi
	call	strlen@PLT
	leaq	14(%rax), %rdi
	call	xmalloc@PLT
	leaq	.LC13(%rip), %rsi
	movq	%rax, %r12
	jmp	.L239
	.p2align 4,,10
	.p2align 3
.L289:
	movq	0(%r13), %rsi
	addq	$8, %r13
	testq	%rsi, %rsi
	je	.L288
.L239:
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L289
	movl	$114, %edx
.L238:
	xorl	%eax, %eax
	movq	%rbp, %rcx
	leaq	.LC18(%rip), %rsi
	movq	%r12, %rdi
	call	sprintf@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L290
.L240:
	movq	%r12, %rbp
.L253:
	leaq	8+c_keywords(%rip), %r12
	leaq	.LC14(%rip), %rsi
	jmp	.L242
	.p2align 4,,10
	.p2align 3
.L291:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L243
.L242:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L291
	movq	%rbp, %rdi
	call	strlen@PLT
	leaq	3(%rax), %rdi
	call	xmalloc@PLT
	movq	%rbp, %rdx
	leaq	.LC20(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %r12
	xorl	%eax, %eax
	call	sprintf@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L292
.L252:
	movq	%r12, %rbp
.L243:
	movq	8+name_map(%rip), %r13
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
	testq	%r13, %r13
	je	.L244
	movq	name_map(%rip), %r14
	xorl	%r12d, %r12d
	jmp	.L246
	.p2align 4,,10
	.p2align 3
.L294:
	addq	$1, %r12
	cmpq	%r12, %r13
	je	.L293
.L246:
	movq	(%r14,%r12,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L294
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
.L248:
	leal	1(%rcx), %eax
	movq	%rbp, %rdx
	leaq	.LC19(%rip), %rsi
	movq	%r13, %rdi
	movl	%eax, 12(%rsp)
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	8+name_map(%rip), %r12
	testq	%r12, %r12
	je	.L247
	movq	(%rsp), %rax
	xorl	%r15d, %r15d
	movq	(%rax), %r14
	jmp	.L249
	.p2align 4,,10
	.p2align 3
.L295:
	addq	$1, %r15
	cmpq	%r12, %r15
	je	.L247
.L249:
	movq	(%r14,%r15,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L295
	movl	12(%rsp), %ecx
	jmp	.L248
	.p2align 4,,10
	.p2align 3
.L286:
	movl	$11, %edx
	leaq	.LC21(%rip), %rsi
	movq	%rbx, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	je	.L235
	jmp	.L253
	.p2align 4,,10
	.p2align 3
.L293:
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
.L244:
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
	jmp	.L213
.L220:
	movb	$95, 0(%rbp)
	movzbl	(%rbx), %eax
	cmpb	$46, %al
	jne	.L296
	movb	$95, 1(%rbp)
	leaq	2(%rbp), %r14
	jmp	.L224
	.p2align 4,,10
	.p2align 3
.L230:
	movq	%r14, %rdi
	leaq	.LC17(%rip), %rsi
	xorl	%eax, %eax
	addq	$3, %r14
	call	sprintf@PLT
	jmp	.L233
	.p2align 4,,10
	.p2align 3
.L247:
	cmpq	$0, g_compilation_arena(%rip)
	je	.L297
.L250:
	movq	%r13, %rbp
	jmp	.L244
	.p2align 4,,10
	.p2align 3
.L288:
	movl	$120, %edx
	jmp	.L238
.L254:
	xorl	%ebp, %ebp
	jmp	.L213
.L290:
	movq	%rbp, %rdi
	call	free@PLT
	jmp	.L240
.L296:
	movzbl	%al, %edx
	movq	%r14, %rdi
	leaq	.LC16(%rip), %rsi
	xorl	%eax, %eax
	movq	%rcx, (%rsp)
	leaq	3(%rbp), %r14
	call	sprintf@PLT
	movq	(%rsp), %rcx
	jmp	.L224
.L292:
	movq	%rbp, %rdi
	call	free@PLT
	jmp	.L252
.L297:
	movq	%rbp, %rdi
	call	free@PLT
	jmp	.L250
	.cfi_endproc
.LFE22:
	.size	get_mangled_name, .-get_mangled_name
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC22:
	.string	"    (void)B_PTR_N(&%s, sizeof(%s));\n"
	.align 8
.LC23:
	.string	"    (void)B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.align 8
.LC24:
	.string	"    (void)B_PTR_N(__%s_blob, sizeof(__%s_blob));\n"
	.text
	.p2align 4
	.type	emit_global_regions.part.0, @function
emit_global_regions.part.0:
.LFB61:
	.cfi_startproc
	cmpq	$0, 8(%rsi)
	je	.L311
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	.LC22(%rip), %r14
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
	jmp	.L305
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L301:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L314
.L305:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$2, (%rax)
	jne	.L301
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
	je	.L315
	cmpl	$1, %eax
	jne	.L301
	movq	48(%r15), %rax
	testq	%rax, %rax
	je	.L304
	cmpl	$1, (%rax)
	je	.L316
.L304:
	movq	%r12, %rcx
	movq	%r12, %rdx
	leaq	.LC24(%rip), %rsi
	movq	%r13, %rdi
	xorl	%eax, %eax
	addq	$1, %rbx
	call	fprintf@PLT
	cmpq	8(%rbp), %rbx
	jb	.L305
.L314:
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
.L315:
	.cfi_restore_state
	movq	%r12, %rcx
	movq	%r12, %rdx
	leaq	.LC23(%rip), %rsi
	movq	%r13, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L301
	.p2align 4,,10
	.p2align 3
.L316:
	cmpq	$1, 24(%rax)
	jne	.L304
	movq	16(%rax), %rax
	movq	(%rax), %rax
	movl	(%rax), %edx
	testl	%edx, %edx
	jne	.L304
	movq	16(%rax), %rax
	cmpl	$1, (%rax)
	jne	.L304
	jmp	.L301
	.p2align 4,,10
	.p2align 3
.L311:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.cfi_endproc
.LFE61:
	.size	emit_global_regions.part.0, .-emit_global_regions.part.0
	.section	.rodata.str1.1
.LC25:
	.string	"main"
.LC26:
	.string	"b_main"
.LC27:
	.string	"extern word "
.LC28:
	.string	"();\n"
	.text
	.p2align 4
	.type	emit_known_external_function_prototypes, @function
emit_known_external_function_prototypes:
.LFB27:
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
	je	.L317
	movl	$0, 20(%rsp)
	xorl	%ebp, %ebp
	leaq	g_known_functions(%rip), %r13
	.p2align 4
	.p2align 3
.L323:
	movq	0(%r13), %rax
	leaq	.LC25(%rip), %rsi
	movq	(%rax,%rbp,8), %rbx
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L319
	leaq	.LC26(%rip), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L319
	movq	8(%rsp), %rax
	movq	8(%rax), %r14
	movq	(%rax), %r12
	testq	%r14, %r14
	je	.L320
	xorl	%r15d, %r15d
	jmp	.L322
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L321:
	addq	$1, %r15
	cmpq	%r15, %r14
	je	.L320
.L322:
	movq	(%r12,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L321
	movq	8(%rax), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L321
	.p2align 4
	.p2align 3
.L319:
	addq	$1, %rbp
	cmpq	8+g_known_functions(%rip), %rbp
	jb	.L323
.L345:
	movl	20(%rsp), %eax
	testl	%eax, %eax
	jne	.L344
.L317:
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
.L320:
	.cfi_restore_state
	movq	24(%rsp), %r14
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC27(%rip), %rdi
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
	leaq	.LC28(%rip), %rdi
	call	fwrite@PLT
	cmpq	8+g_known_functions(%rip), %rbp
	movl	$1, 20(%rsp)
	jb	.L323
	jmp	.L345
.L344:
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
.LFE27:
	.size	emit_known_external_function_prototypes, .-emit_known_external_function_prototypes
	.section	.rodata.str1.1
.LC29:
	.string	"__b_user_main"
	.text
	.p2align 4
	.type	emit_function_name, @function
emit_function_name:
.LFB25:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	leaq	.LC25(%rip), %rsi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rbp, %rdi
	leaq	8+names.0(%rip), %rbx
	call	strcmp@PLT
	leaq	.LC13(%rip), %rsi
	testl	%eax, %eax
	jne	.L349
	jmp	.L356
	.p2align 4,,10
	.p2align 3
.L357:
	movq	(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L350
.L349:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L357
	movq	%rbp, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L358
.L350:
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
.L356:
	.cfi_restore_state
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%r12, %rcx
	popq	%rbp
	.cfi_def_cfa_offset 16
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC29(%rip), %rdi
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L358:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	movq	%rbp, %rdx
	movq	%r12, %rdi
	popq	%rbp
	.cfi_def_cfa_offset 16
	leaq	.LC20(%rip), %rsi
	xorl	%eax, %eax
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	fprintf@PLT
	.cfi_endproc
.LFE25:
	.size	emit_function_name, .-emit_function_name
	.section	.rodata.str1.1
.LC30:
	.string	"  "
	.text
	.p2align 4
	.globl	emit_indent
	.type	emit_indent, @function
emit_indent:
.LFB34:
	.cfi_startproc
	testl	%esi, %esi
	jle	.L364
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	leaq	.LC30(%rip), %r13
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
.L361:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L361
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
.L364:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	ret
	.cfi_endproc
.LFE34:
	.size	emit_indent, .-emit_indent
	.section	.rodata.str1.1
.LC31:
	.string	"#line %d \"%s\"\n"
	.text
	.p2align 4
	.globl	emit_line_directive
	.type	emit_line_directive, @function
emit_line_directive:
.LFB35:
	.cfi_startproc
	movl	g_no_line(%rip), %eax
	testl	%eax, %eax
	jne	.L367
	testq	%rdx, %rdx
	jne	.L375
.L367:
	ret
	.p2align 4,,10
	.p2align 3
.L375:
	movq	%rdx, %rcx
	xorl	%eax, %eax
	movl	%esi, %edx
	leaq	.LC31(%rip), %rsi
	jmp	fprintf@PLT
	.cfi_endproc
.LFE35:
	.size	emit_line_directive, .-emit_line_directive
	.section	.rodata.str1.1
.LC32:
	.string	"\\n"
.LC33:
	.string	"\\t"
.LC34:
	.string	"\\x%02x"
	.text
	.p2align 4
	.globl	emit_c_string
	.type	emit_c_string, @function
emit_c_string:
.LFB36:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	leaq	.LC32(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	leaq	.LC34(%rip), %r13
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
	jne	.L377
	jmp	.L384
	.p2align 4,,10
	.p2align 3
.L392:
	movq	%r13, %rsi
	movq	%r12, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L380:
	movzbl	1(%rbp), %ebx
	addq	$1, %rbp
	testb	%bl, %bl
	je	.L384
.L377:
	cmpb	$92, %bl
	je	.L385
	cmpb	$34, %bl
	je	.L385
	cmpb	$10, %bl
	je	.L390
	cmpb	$9, %bl
	je	.L391
	movzbl	%bl, %edx
	cmpb	$31, %bl
	jbe	.L392
	movq	%r12, %rsi
	movl	%edx, %edi
	addq	$1, %rbp
	call	fputc@PLT
	movzbl	0(%rbp), %ebx
	testb	%bl, %bl
	jne	.L377
.L384:
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
.L385:
	.cfi_restore_state
	movq	%r12, %rsi
	movl	$92, %edi
	call	fputc@PLT
	movzbl	%bl, %edi
	movq	%r12, %rsi
	call	fputc@PLT
	jmp	.L380
	.p2align 4,,10
	.p2align 3
.L390:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	jmp	.L380
	.p2align 4,,10
	.p2align 3
.L391:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC33(%rip), %rdi
	call	fwrite@PLT
	jmp	.L380
	.cfi_endproc
.LFE36:
	.size	emit_c_string, .-emit_c_string
	.section	.rodata.str1.1
.LC35:
	.string	"preinc"
.LC36:
	.string	"predec"
.LC37:
	.string	"postinc"
.LC38:
	.string	"postdec"
.LC39:
	.string	"WAND"
.LC40:
	.string	"WOR"
.LC41:
	.string	"WADD"
.LC42:
	.string	"WSUB"
.LC43:
	.string	"WMUL"
.LC44:
	.string	"WSHR"
.LC45:
	.string	"WSHL"
.LC46:
	.string	"WMOD"
.LC47:
	.string	"WDIV"
.LC48:
	.string	"add_assign"
.LC49:
	.string	"or_assign"
.LC50:
	.string	"and_assign"
.LC51:
	.string	"rsh_assign"
.LC52:
	.string	"lsh_assign"
.LC53:
	.string	"mod_assign"
.LC54:
	.string	"div_assign"
.LC55:
	.string	"mul_assign"
.LC56:
	.string	"sub_assign"
.LC57:
	.string	"WVAL((word)%ld)"
	.section	.rodata.str1.8
	.align 8
.LC58:
	.string	"B_PTR_N(__b_str%d, sizeof(__b_str%d))"
	.section	.rodata.str1.1
.LC59:
	.string	"__b_label_value_%d"
.LC60:
	.string	"B_FUNCTION("
.LC61:
	.string	"((word (*)())B_FUNCTION_CPTR("
.LC62:
	.string	"))("
.LC63:
	.string	", "
.LC64:
	.string	"callf"
.LC65:
	.string	"b_callf_dispatch(%zu"
.LC66:
	.string	"calloc"
.LC67:
	.string	"realloc"
.LC68:
	.string	"printf"
.LC69:
	.string	"B_PTR("
.LC70:
	.string	"fprintf"
.LC71:
	.string	"dprintf"
.LC72:
	.string	"sprintf"
.LC73:
	.string	"snprintf"
.LC74:
	.string	"-+ #0"
.LC75:
	.string	"exit"
.LC76:
	.string	"strlen"
.LC77:
	.string	"atoi"
.LC78:
	.string	"memmove"
.LC79:
	.string	"tcgetattr"
.LC80:
	.string	"tcsetattr"
.LC81:
	.string	"ioctl"
.LC82:
	.string	"memset"
.LC83:
	.string	"memcpy"
.LC84:
	.string	"__b_cstr("
.LC85:
	.string	"B_CPTR("
	.section	.rodata.str1.8
	.align 8
.LC86:
	.string	"(size_t)(sizeof(word) * (uword)("
	.section	.rodata.str1.1
.LC87:
	.string	"))"
.LC88:
	.string	"B_INDEX("
.LC89:
	.string	"B_DEREF("
.LC90:
	.string	"B_ADDR("
.LC91:
	.string	"b_"
.LC92:
	.string	"(&("
.LC93:
	.string	"WNEG("
.LC94:
	.string	"({ word __b_left_%u = "
.LC95:
	.string	"; word __b_right_%u = "
	.section	.rodata.str1.8
	.align 8
.LC96:
	.string	"; (word)%s(__b_left_%u, __b_right_%u); })"
	.section	.rodata.str1.1
.LC97:
	.string	"%s("
.LC98:
	.string	" %s "
.LC99:
	.string	" = ("
.LC100:
	.string	"), "
.LC101:
	.string	" ? "
.LC102:
	.string	" : "
.LC103:
	.string	"malloc"
	.text
	.p2align 4
	.globl	emit_expr
	.type	emit_expr, @function
emit_expr:
.LFB45:
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
	ja	.L393
	movl	(%rsi), %eax
	movq	%rdx, %r14
	leaq	.L396(%rip), %rdx
	movq	%rsi, %r15
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L396:
	.long	.L406-.L396
	.long	.L405-.L396
	.long	.L404-.L396
	.long	.L403-.L396
	.long	.L402-.L396
	.long	.L401-.L396
	.long	.L400-.L396
	.long	.L399-.L396
	.long	.L398-.L396
	.long	.L397-.L396
	.long	.L395-.L396
	.text
	.p2align 4,,10
	.p2align 3
.L397:
	movq	8(%rsp), %rbx
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
	leaq	.LC101(%rip), %rdi
	call	fwrite@PLT
	movq	40(%r15), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$3, %edx
	leaq	.LC102(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
.L765:
	movq	%r14, %rdx
.L766:
	movq	%rbx, %rdi
	call	emit_expr
.L763:
	movq	%rbx, %rsi
.L764:
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
.L395:
	.cfi_restore_state
	movq	8(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
.L767:
	movq	32(%r15), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC63(%rip), %rdi
.L768:
	call	fwrite@PLT
	movq	40(%r15), %rsi
	jmp	.L765
	.p2align 4,,10
	.p2align 3
.L406:
	movq	32(%rsi), %rdx
	movq	8(%rsp), %rdi
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC57(%rip), %rsi
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
.L405:
	.cfi_restore_state
	movq	32(%r15), %rdi
	movq	24(%rsi), %rsi
	call	get_string_id
	movq	8(%rsp), %rdi
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC58(%rip), %rsi
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
.L404:
	.cfi_restore_state
	movq	8+function_labels(%rip), %r13
	movq	32(%rsi), %r12
	testq	%r13, %r13
	je	.L407
	movq	function_labels(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L412
	.p2align 4,,10
	.p2align 3
.L408:
	addq	$1, %rbp
	cmpq	%r13, %rbp
	je	.L738
.L412:
	movq	(%r14,%rbp,8), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L408
	movl	%ebp, %edx
	addl	$1, %edx
	je	.L738
	movq	8(%rsp), %rdi
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC59(%rip), %rsi
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
.L403:
	.cfi_restore_state
	movl	16(%rsi), %r11d
	testl	%r11d, %r11d
	jne	.L771
	movq	32(%rsi), %rax
	cmpl	$2, (%rax)
	movq	32(%rax), %rbp
	je	.L772
	movb	$0, 47(%rsp)
	xorl	%ebx, %ebx
	xorl	%r13d, %r13d
	movq	$0, 16(%rsp)
.L419:
	movq	8(%rsp), %rdi
	movq	%rbp, %rsi
	call	emit_function_name
.L433:
	movq	8(%rsp), %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	48(%r15), %rdx
	movq	16(%rsp), %rcx
	cmpq	%rdx, %rcx
	jnb	.L434
	cmpb	$0, 47(%rsp)
	je	.L434
	movq	40(%r15), %rax
	movq	(%rax,%rcx,8), %rax
	testq	%rax, %rax
	je	.L461
	cmpl	$1, (%rax)
	je	.L773
.L461:
	movq	$0, 48(%rsp)
.L437:
	movq	%r14, 32(%rsp)
	xorl	%r12d, %r12d
	movq	8(%rsp), %r14
	movl	%ebx, 64(%rsp)
	movq	%rdx, 24(%rsp)
	testq	%r13, %r13
	je	.L578
.L778:
	movq	16(%rsp), %rax
	movl	current_byteptr(%rip), %ebp
	cmpq	%rax, %r12
	sete	%al
	testb	%al, 47(%rsp)
	jne	.L464
	movq	48(%rsp), %rax
	testq	%rax, %rax
	je	.L465
	movl	(%rax,%r12,4), %r9d
	testl	%r9d, %r9d
	jne	.L464
.L465:
	leaq	.LC76(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L468
	testq	%r12, %r12
	je	.L774
.L469:
	leaq	.LC78(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L471
	cmpq	$1, %r12
	jbe	.L775
.L473:
	leaq	.LC80(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L476
	cmpq	$2, %r12
	je	.L477
.L472:
	leaq	.LC82(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testq	%r12, %r12
	sete	56(%rsp)
	testl	%eax, %eax
	movzbl	56(%rsp), %ecx
	sete	%al
	andb	%cl, %al
	movl	%eax, %edx
	jne	.L776
	leaq	.LC83(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L484
	cmpq	$1, %r12
	jbe	.L485
.L483:
	leaq	.LC67(%rip), %rax
	movq	%r13, %rdi
	movq	%rax, %rsi
	movq	%rax, 72(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L486
	movb	$0, 56(%rsp)
.L487:
	leaq	.LC66(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	andb	56(%rsp), %al
	xorl	$1, %eax
	movzbl	%al, %eax
	andl	%eax, %ebx
	testl	%ebp, %ebp
	jne	.L486
	leaq	.LC103(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L592
	cmpb	$0, 56(%rsp)
	je	.L592
.L492:
	testl	%ebx, %ebx
	jne	.L491
.L493:
	movq	%r14, %rcx
	movl	$32, %edx
	movl	$1, %esi
	leaq	.LC86(%rip), %rdi
	call	fwrite@PLT
	movq	40(%r15), %rax
	movq	32(%rsp), %rdx
	movq	%r14, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC87(%rip), %rdi
	call	fwrite@PLT
.L538:
	testl	%ebx, %ebx
	jne	.L777
.L496:
	addq	$1, %r12
	cmpq	%r12, 24(%rsp)
	je	.L497
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC63(%rip), %rdi
	call	fwrite@PLT
	testq	%r13, %r13
	jne	.L778
.L578:
	xorl	%ebx, %ebx
.L463:
	movq	40(%r15), %rax
	movq	32(%rsp), %rdx
	movq	%r14, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
	jmp	.L538
	.p2align 4,,10
	.p2align 3
.L402:
	movq	8(%rsp), %rbx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC88(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	jmp	.L767
	.p2align 4,,10
	.p2align 3
.L401:
	movl	32(%rsi), %ebp
	cmpl	$32, %ebp
	je	.L779
	cmpl	$53, %ebp
	je	.L780
	leal	-36(%rbp), %eax
	cmpl	$1, %eax
	jbe	.L781
	movq	8(%rsp), %rbx
	cmpl	$31, %ebp
	jne	.L507
	movl	current_word_bits(%rip), %edi
	testl	%edi, %edi
	jne	.L782
.L507:
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
	jmp	.L769
	.p2align 4,,10
	.p2align 3
.L400:
	movq	40(%rsi), %rbp
	movl	32(%rsi), %r12d
	testq	%rbp, %rbp
	je	.L508
	movl	0(%rbp), %eax
	cmpl	$4, %eax
	je	.L509
	cmpl	$5, %eax
	jne	.L508
	cmpl	$32, 32(%rbp)
	je	.L509
	.p2align 4
	.p2align 3
.L508:
	movl	current_word_bits(%rip), %esi
	testl	%esi, %esi
	je	.L510
.L509:
	movq	8(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC91(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	cmpl	$36, %r12d
	movq	%rbx, %rcx
	movl	$7, %edx
	leaq	.LC37(%rip), %rax
	leaq	.LC38(%rip), %rdi
	movl	$1, %esi
	cmove	%rax, %rdi
	call	fwrite@PLT
	movl	$3, %edx
	movq	%rbx, %rcx
	movl	$1, %esi
	leaq	.LC92(%rip), %rdi
	call	fwrite@PLT
	movq	%r14, %rdx
	movq	%rbp, %rsi
.L769:
	movq	%rbx, %rdi
	call	emit_expr
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$2, %edx
	popq	%rbx
	.cfi_def_cfa_offset 48
	movl	$1, %esi
	leaq	.LC87(%rip), %rdi
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
.L399:
	.cfi_restore_state
	movl	32(%rsi), %ebp
	leal	-53(%rbp), %eax
	cmpl	$1, %eax
	jbe	.L783
	movl	current_word_bits(%rip), %ecx
	testl	%ecx, %ecx
	je	.L514
	leal	-28(%rbp), %eax
	cmpl	$6, %eax
	ja	.L514
	leaq	.L516(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L516:
	.long	.L586-.L516
	.long	.L521-.L516
	.long	.L520-.L516
	.long	.L519-.L516
	.long	.L518-.L516
	.long	.L517-.L516
	.long	.L515-.L516
	.text
	.p2align 4,,10
	.p2align 3
.L398:
	movl	32(%rsi), %ebp
	movq	40(%rsi), %r12
	movq	48(%rsi), %r13
	leal	-47(%rbp), %eax
	cmpl	$5, %eax
	jbe	.L784
	cmpl	$21, %ebp
	je	.L524
	testq	%r12, %r12
	je	.L525
	movl	(%r12), %eax
	cmpl	$4, %eax
	je	.L526
	cmpl	$5, %eax
	je	.L785
.L525:
	movl	current_word_bits(%rip), %edx
	testl	%edx, %edx
	je	.L524
.L526:
	leal	-38(%rbp), %eax
	cmpl	$8, %eax
	ja	.L524
	leaq	.L529(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L529:
	.long	.L537-.L529
	.long	.L536-.L529
	.long	.L535-.L529
	.long	.L534-.L529
	.long	.L533-.L529
	.long	.L532-.L529
	.long	.L531-.L529
	.long	.L587-.L529
	.long	.L528-.L529
	.text
.L407:
	cmpl	$0, 12(%rsi)
	jne	.L410
	testq	%r12, %r12
	jne	.L411
.L393:
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
.L738:
	.cfi_restore_state
	movl	12(%r15), %eax
	testl	%eax, %eax
	je	.L411
.L410:
	movq	8(%rsp), %rbx
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC60(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	32(%r15), %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	jmp	.L763
	.p2align 4,,10
	.p2align 3
.L411:
	movq	%r12, %rdi
	call	get_mangled_name
	movq	8(%rsp), %rsi
	addq	$88, %rsp
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
.L514:
	.cfi_restore_state
	movq	8(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	40(%r15), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	%ebp, %edi
	call	tk_name@PLT
	leaq	.LC98(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r15), %rsi
	jmp	.L765
	.p2align 4,,10
	.p2align 3
.L772:
	leaq	.LC64(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L786
.L420:
	leaq	8+names.0(%rip), %r12
	leaq	.LC13(%rip), %rsi
	jmp	.L424
	.p2align 4,,10
	.p2align 3
.L788:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L787
.L424:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L788
	movq	%rbp, %rdi
	leaq	.LC103(%rip), %rsi
	call	strcmp@PLT
	movq	%rbp, %rdi
	movl	%eax, %r12d
	call	source_function
	testl	%eax, %eax
	jne	.L564
	testl	%r12d, %r12d
	je	.L551
	movl	$1, %r12d
	.p2align 4
	.p2align 3
.L552:
	leaq	.LC66(%rip), %rsi
	movq	%rbp, %rdi
	movl	$1, %ebx
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L426
	leaq	.LC67(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%ebx, %ebx
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%bl
.L426:
	leaq	.LC68(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	orl	%r12d, %eax
	je	.L789
.L427:
	leaq	.LC70(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L573
	leaq	.LC71(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L573
	leaq	.LC72(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L573
.L562:
	leaq	.LC73(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L574
	movb	$0, 47(%rsp)
	movq	$0, 16(%rsp)
	.p2align 4
	.p2align 3
.L430:
	testl	%ebx, %ebx
	jne	.L561
	movq	%rbp, %rdx
	movq	%rbp, %r13
	testl	%r12d, %r12d
	je	.L419
.L550:
	movq	8(%rsp), %rdi
	leaq	.LC20(%rip), %rsi
	xorl	%eax, %eax
	movq	%rbp, %r13
	call	fprintf@PLT
	jmp	.L433
	.p2align 4,,10
	.p2align 3
.L510:
	movq	8(%rsp), %rbx
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
	jmp	.L763
	.p2align 4,,10
	.p2align 3
.L781:
	movq	40(%rsi), %r12
	testq	%r12, %r12
	je	.L503
	movl	(%r12), %eax
	cmpl	$4, %eax
	je	.L504
	cmpl	$5, %eax
	je	.L790
.L503:
	movl	current_word_bits(%rip), %r8d
	testl	%r8d, %r8d
	je	.L505
.L504:
	movq	8(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC91(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	cmpl	$36, %ebp
	movq	%rbx, %rcx
	movl	$6, %edx
	leaq	.LC35(%rip), %rax
	leaq	.LC36(%rip), %rdi
	movl	$1, %esi
	cmove	%rax, %rdi
	call	fwrite@PLT
	movl	$3, %edx
	movq	%rbx, %rcx
	movl	$1, %esi
	leaq	.LC92(%rip), %rdi
	call	fwrite@PLT
	movq	%r14, %rdx
	movq	%r12, %rsi
	jmp	.L769
.L521:
	leaq	.LC44(%rip), %rdx
	.p2align 4
	.p2align 3
.L522:
	movq	8(%rsp), %rbx
	leaq	.LC97(%rip), %rsi
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
	leaq	.LC63(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
	jmp	.L765
.L586:
	leaq	.LC45(%rip), %rdx
	jmp	.L522
.L515:
	leaq	.LC46(%rip), %rdx
	jmp	.L522
.L520:
	leaq	.LC41(%rip), %rdx
	jmp	.L522
.L517:
	leaq	.LC47(%rip), %rdx
	jmp	.L522
.L518:
	leaq	.LC43(%rip), %rdx
	jmp	.L522
.L519:
	leaq	.LC42(%rip), %rdx
	jmp	.L522
.L587:
	leaq	.LC50(%rip), %rbp
	.p2align 4
	.p2align 3
.L530:
	movq	8(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC91(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC92(%rip), %rdi
	call	fwrite@PLT
	movq	%r14, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	$3, %edx
	movq	%rbx, %rcx
	movl	$1, %esi
	leaq	.LC100(%rip), %rdi
	call	fwrite@PLT
	movq	%r14, %rdx
	movq	%r13, %rsi
	jmp	.L766
.L528:
	leaq	.LC49(%rip), %rbp
	jmp	.L530
.L537:
	leaq	.LC48(%rip), %rbp
	jmp	.L530
.L535:
	leaq	.LC55(%rip), %rbp
	jmp	.L530
.L536:
	leaq	.LC56(%rip), %rbp
	jmp	.L530
.L531:
	leaq	.LC51(%rip), %rbp
	jmp	.L530
.L532:
	leaq	.LC52(%rip), %rbp
	jmp	.L530
.L533:
	leaq	.LC53(%rip), %rbp
	jmp	.L530
.L534:
	leaq	.LC54(%rip), %rbp
	jmp	.L530
	.p2align 4,,10
	.p2align 3
.L464:
	testl	%ebp, %ebp
	je	.L791
.L467:
	movq	%r14, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC84(%rip), %rdi
	call	fwrite@PLT
.L495:
	movl	$1, %ebx
	jmp	.L463
	.p2align 4,,10
	.p2align 3
.L777:
	movq	%r14, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L496
	.p2align 4,,10
	.p2align 3
.L791:
	testq	%r12, %r12
	sete	%bl
.L470:
	leaq	.LC103(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L591
	testb	%bl, %bl
	jne	.L490
.L591:
	leaq	.LC67(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L792
	cmpq	$1, %r12
	jne	.L467
.L490:
	movq	%r14, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC84(%rip), %rdi
	call	fwrite@PLT
.L494:
	movl	$1, %ebx
	jmp	.L493
	.p2align 4,,10
	.p2align 3
.L497:
	movl	64(%rsp), %ebx
	movq	8(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	jne	.L460
.L499:
	movq	48(%rsp), %rax
	testq	%rax, %rax
	je	.L393
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
.L524:
	.cfi_restore_state
	movq	8(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	%r14, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%ebp, %edi
	call	assignment_op_to_c
	leaq	.LC98(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%r14, %rdx
	movq	%r13, %rsi
	jmp	.L766
	.p2align 4,,10
	.p2align 3
.L434:
	testq	%r13, %r13
	je	.L458
	leaq	.LC75(%rip), %rsi
	movq	%r13, %rdi
	movq	%rdx, 24(%rsp)
	call	strcmp@PLT
	movq	24(%rsp), %rdx
	testq	%rdx, %rdx
	jne	.L461
	testl	%eax, %eax
	jne	.L458
	movq	8(%rsp), %r14
	movl	$48, %edi
	movq	%r14, %rsi
	call	fputc@PLT
	movq	%r14, %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	je	.L393
.L462:
	xorl	%r10d, %r10d
	movq	%r10, 48(%rsp)
	.p2align 4
	.p2align 3
.L460:
	movq	8(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L499
	.p2align 4,,10
	.p2align 3
.L792:
	leaq	.LC66(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L467
	cmpq	$1, %r12
	je	.L490
	jmp	.L467
	.p2align 4,,10
	.p2align 3
.L468:
	leaq	.LC77(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%bl
	testq	%r12, %r12
	sete	%al
	andb	%al, %bl
	je	.L469
	testl	%ebp, %ebp
	je	.L470
	jmp	.L467
.L787:
	leaq	.LC103(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	movl	%eax, %r12d
.L564:
	movl	$1, %ebx
	testl	%r12d, %r12d
	je	.L426
	xorl	%r12d, %r12d
	jmp	.L552
	.p2align 4,,10
	.p2align 3
.L471:
	leaq	.LC79(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L473
	cmpq	$1, %r12
	jne	.L473
	leaq	.LC83(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L758
.L485:
	testl	%ebp, %ebp
	jne	.L482
	movq	%r12, %rax
	xorq	$1, %rax
	movl	%eax, %edx
	andl	$1, %edx
.L481:
	leaq	.LC103(%rip), %rsi
	movq	%r13, %rdi
	movb	%dl, 56(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L593
	movzbl	56(%rsp), %edx
	testb	%dl, %dl
	jne	.L491
.L593:
	leaq	.LC67(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L760
	leaq	.LC66(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L482
.L760:
	cmpq	$1, %r12
	je	.L491
	.p2align 4
	.p2align 3
.L482:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC85(%rip), %rdi
	call	fwrite@PLT
	jmp	.L495
	.p2align 4,,10
	.p2align 3
.L458:
	testq	%rdx, %rdx
	jne	.L461
	movq	8(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	je	.L393
	jmp	.L462
	.p2align 4,,10
	.p2align 3
.L771:
	movq	8(%rsp), %rbx
	movl	$29, %edx
	movl	$1, %esi
	xorl	%ebp, %ebp
	leaq	.LC61(%rip), %rdi
	leaq	.LC63(%rip), %r12
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	32(%r15), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC62(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 48(%r15)
	je	.L417
.L416:
	movq	40(%r15), %rax
	movq	%r14, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	emit_expr
	cmpq	48(%r15), %rbp
	jnb	.L417
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	jmp	.L416
.L421:
	movq	8(%rsp), %rbx
	leaq	-1(%r13), %rdx
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	leaq	.LC65(%rip), %rsi
	leaq	.LC63(%rip), %r12
	movq	%rbx, %rdi
	call	fprintf@PLT
.L422:
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
	jne	.L422
	.p2align 4
	.p2align 3
.L417:
	movq	8(%rsp), %rsi
	jmp	.L764
	.p2align 4,,10
	.p2align 3
.L784:
	movq	8(%rsp), %rbx
	leaq	CSWTCH.167(%rip), %rdx
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
	leaq	.LC99(%rip), %rdi
	call	fwrite@PLT
	movq	%r14, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%ebp, %edi
	call	tk_name@PLT
	leaq	.LC98(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%r14, %rdx
	movq	%r13, %rsi
	jmp	.L769
	.p2align 4,,10
	.p2align 3
.L573:
	movb	$1, 47(%rsp)
	movq	$1, 16(%rsp)
	jmp	.L430
.L758:
	movb	$0, 56(%rsp)
	movl	$1, %ebx
.L484:
	leaq	.LC67(%rip), %rax
	movq	%r13, %rdi
	movq	%rax, %rsi
	movq	%rax, 72(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L487
	movzbl	56(%rsp), %eax
	orl	%eax, %ebx
	testl	%ebp, %ebp
	jne	.L486
	leaq	.LC103(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L545
	cmpb	$0, 56(%rsp)
	jne	.L492
.L545:
	cmpq	$1, %r12
	je	.L492
	.p2align 4
	.p2align 3
.L486:
	testl	%ebx, %ebx
	jne	.L482
	jmp	.L463
	.p2align 4,,10
	.p2align 3
.L476:
	leaq	.LC81(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L590
	cmpq	$2, %r12
	je	.L477
.L590:
	xorl	%ebx, %ebx
	jmp	.L472
.L477:
	leaq	.LC83(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L758
	movl	$1, %ebx
	jmp	.L483
	.p2align 4,,10
	.p2align 3
.L783:
	movl	expression_id(%rip), %eax
	movq	8(%rsp), %rbx
	leaq	.LC94(%rip), %rsi
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
	leaq	.LC95(%rip), %rsi
	call	fprintf@PLT
	movq	48(%r15), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	cmpl	$53, %ebp
	movl	%r12d, %r8d
	movl	%r12d, %ecx
	leaq	.LC39(%rip), %rax
	leaq	.LC40(%rip), %rdx
	movq	%rbx, %rdi
	cmove	%rax, %rdx
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC96(%rip), %rsi
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
.L785:
	.cfi_restore_state
	cmpl	$32, 32(%r12)
	jne	.L525
	jmp	.L526
.L779:
	movq	8(%rsp), %rbx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC89(%rip), %rdi
	movq	%rbx, %rcx
	jmp	.L768
.L774:
	testl	%ebp, %ebp
	jne	.L467
	movl	$1, %ebx
	jmp	.L470
.L780:
	movq	8(%rsp), %rbx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC90(%rip), %rdi
	movq	%rbx, %rcx
	jmp	.L768
.L782:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC93(%rip), %rdi
	jmp	.L768
.L786:
	movq	%rbp, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L420
	movq	48(%r15), %r13
	testq	%r13, %r13
	jne	.L421
	movq	8(%rsp), %rdi
	xorl	%edx, %edx
	leaq	.LC65(%rip), %rsi
	call	fprintf@PLT
	jmp	.L417
.L789:
	movq	%rbp, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L569
	testl	%ebx, %ebx
	jne	.L793
	movb	$1, 47(%rsp)
	movq	%rbp, %r13
	movq	$0, 16(%rsp)
	jmp	.L419
.L776:
	testl	%ebp, %ebp
	je	.L481
	jmp	.L482
.L491:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC85(%rip), %rdi
	call	fwrite@PLT
	jmp	.L494
.L775:
	movl	$1, %ebx
	jmp	.L472
.L589:
	movb	$1, 47(%rsp)
	movl	$1, %r12d
	movq	$1, 16(%rsp)
.L561:
	movq	8(%rsp), %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC69(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r15), %rax
	movq	32(%rax), %rdx
	testl	%r12d, %r12d
	je	.L432
.L429:
	cmpl	$2, (%rax)
	je	.L794
.L432:
	movq	%rbp, %r13
	movl	$1, %ebx
	movq	%rdx, %rbp
	jmp	.L419
.L773:
	movq	%rdx, %rdi
	movl	$4, %esi
	movq	%rdx, 24(%rsp)
	movq	32(%rax), %rbp
	call	calloc@PLT
	movq	24(%rsp), %rdx
	testq	%rax, %rax
	movq	%rax, 48(%rsp)
	je	.L461
	movq	16(%rsp), %rax
	xorl	%r12d, %r12d
	leaq	1(%rax), %rcx
	movzbl	0(%rbp), %eax
	testb	%al, %al
	je	.L437
	movq	%r14, 56(%rsp)
	movl	%ebx, 24(%rsp)
	movq	%rcx, %rbx
	movq	%r13, 32(%rsp)
	movq	%rbp, %r13
	movq	%rdx, %rbp
	.p2align 4
	.p2align 3
.L436:
	cmpb	$37, %al
	jne	.L754
	addq	$1, %r12
	movzbl	0(%r13,%r12), %r14d
	cmpb	$37, %r14b
	je	.L754
	testb	%r14b, %r14b
	jne	.L439
	jmp	.L751
	.p2align 4,,10
	.p2align 3
.L442:
	addq	$1, %r12
	movzbl	0(%r13,%r12), %r14d
	testb	%r14b, %r14b
	je	.L441
.L439:
	movsbl	%r14b, %esi
	leaq	.LC74(%rip), %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L442
	cmpb	$42, %r14b
	jne	.L441
	cmpq	%rbp, %rbx
	adcq	$0, %rbx
	addq	$1, %r12
	movzbl	0(%r13,%r12), %edx
.L446:
	cmpb	$46, %dl
	je	.L795
.L448:
	cmpb	$104, %dl
	je	.L796
	cmpb	$108, %dl
	je	.L797
	testb	%dl, %dl
	je	.L751
	leaq	1(%r12), %rax
	cmpb	$115, %dl
	jne	.L454
	cmpq	%rbp, %rbx
	jnb	.L454
	movq	48(%rsp), %rcx
	movl	$1, (%rcx,%rbx,4)
	.p2align 4
	.p2align 3
.L454:
	addq	$1, %rbx
.L438:
	movq	%rax, %r12
	movzbl	0(%r13,%rax), %eax
	testb	%al, %al
	jne	.L436
.L751:
	movl	24(%rsp), %ebx
	movq	32(%rsp), %r13
	movq	%rbp, %rdx
	movq	56(%rsp), %r14
	jmp	.L437
	.p2align 4,,10
	.p2align 3
.L754:
	leaq	1(%r12), %rax
	jmp	.L438
.L441:
	movzbl	0(%r13,%r12), %edx
	testb	%dl, %dl
	movb	%dl, 64(%rsp)
	je	.L751
	call	__ctype_b_loc@PLT
	movzbl	64(%rsp), %edx
	movq	(%rax), %rax
	jmp	.L444
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L447:
	addq	$1, %r12
	movzbl	0(%r13,%r12), %edx
	testb	%dl, %dl
	je	.L751
.L444:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L447
	movzbl	0(%r13,%r12), %edx
	jmp	.L446
.L796:
	cmpb	$104, 1(%r13,%r12)
	leaq	1(%r12), %rax
	jne	.L454
.L577:
	leaq	2(%r12), %rax
	jmp	.L454
.L795:
	movzbl	1(%r13,%r12), %edx
	leaq	1(%r12), %rdi
	movq	%rdi, 64(%rsp)
	cmpb	$42, %dl
	jne	.L798
	cmpq	%rbp, %rbx
	adcq	$0, %rbx
	addq	$2, %r12
	movzbl	0(%r13,%r12), %edx
	jmp	.L448
.L797:
	cmpb	$108, 1(%r13,%r12)
	leaq	1(%r12), %rax
	jne	.L454
	jmp	.L577
.L505:
	movl	%ebp, %edi
	call	tk_name@PLT
	movq	8(%rsp), %rbx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	call	fputs@PLT
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	%r14, %rdx
	movq	%r12, %rsi
	jmp	.L766
.L569:
	xorl	%r12d, %r12d
	jmp	.L427
.L790:
	cmpl	$32, 32(%r12)
	jne	.L503
	jmp	.L504
.L798:
	testb	%dl, %dl
	movb	%dl, 72(%rsp)
	je	.L751
	call	__ctype_b_loc@PLT
	movzbl	72(%rsp), %edx
	movq	64(%rsp), %rdi
	movq	(%rax), %rax
	jmp	.L450
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L452:
	addq	$1, %rdi
	movzbl	0(%r13,%rdi), %edx
	testb	%dl, %dl
	je	.L751
.L450:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L452
	movzbl	0(%r13,%rdi), %edx
	movq	%rdi, %r12
	jmp	.L448
.L551:
	leaq	.LC70(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L560
	leaq	.LC71(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L560
	leaq	.LC72(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L589
	movl	$1, %ebx
	movl	$1, %r12d
	jmp	.L562
.L793:
	movq	8(%rsp), %rcx
	movl	$6, %edx
	movl	$1, %esi
	movq	%rbp, %r13
	leaq	.LC69(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r15), %rax
	movb	$1, 47(%rsp)
	movq	$0, 16(%rsp)
	movq	32(%rax), %rbp
	jmp	.L419
.L560:
	movq	8(%rsp), %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC69(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r15), %rax
	movq	32(%rax), %rdx
	movb	$1, 47(%rsp)
	movq	$1, 16(%rsp)
	jmp	.L429
.L574:
	movb	$1, 47(%rsp)
	movq	$2, 16(%rsp)
	jmp	.L430
.L592:
	movq	72(%rsp), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L545
	leaq	.LC66(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	cmpq	$1, %r12
	jne	.L486
	testl	%eax, %eax
	jne	.L486
	jmp	.L492
.L794:
	movl	$1, %ebx
	jmp	.L550
	.cfi_endproc
.LFE45:
	.size	emit_expr, .-emit_expr
	.p2align 4
	.globl	emit_ival_expr
	.type	emit_ival_expr, @function
emit_ival_expr:
.LFB46:
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
	je	.L806
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
.L806:
	.cfi_restore_state
	movq	%rdi, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC90(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L801
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L801:
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
.LFE46:
	.size	emit_ival_expr, .-emit_ival_expr
	.p2align 4
	.globl	init_list_length
	.type	init_list_length, @function
init_list_length:
.LFB47:
	.cfi_startproc
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L807
	cmpl	$1, (%rdi)
	je	.L811
.L807:
	ret
	.p2align 4,,10
	.p2align 3
.L811:
	movq	24(%rdi), %rax
	ret
	.cfi_endproc
.LFE47:
	.size	init_list_length, .-init_list_length
	.p2align 4
	.globl	try_eval_const_expr
	.type	try_eval_const_expr, @function
try_eval_const_expr:
.LFB48:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L844
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
	je	.L814
	ja	.L815
	testl	%eax, %eax
	je	.L816
	cmpl	$5, %eax
	jne	.L824
	movq	40(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L812
	movl	32(%rbx), %eax
	cmpl	$31, %eax
	je	.L820
	cmpl	$35, %eax
	je	.L821
	.p2align 4
	.p2align 3
.L824:
	xorl	%eax, %eax
.L812:
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
.L815:
	.cfi_restore_state
	cmpl	$10, %eax
	jne	.L824
	movq	32(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L812
	movq	40(%rbx), %rdi
	movq	%rbp, %rsi
	call	try_eval_const_expr
	jmp	.L812
	.p2align 4,,10
	.p2align 3
.L844:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L816:
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
.L814:
	.cfi_restore_state
	movq	40(%rdi), %rdi
	movq	%rsp, %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L824
	movq	48(%rbx), %rdi
	leaq	8(%rsp), %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L824
	movl	32(%rbx), %eax
	subl	$22, %eax
	cmpl	$33, %eax
	ja	.L824
	leaq	.L827(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L827:
	.long	.L840-.L827
	.long	.L839-.L827
	.long	.L838-.L827
	.long	.L837-.L827
	.long	.L836-.L827
	.long	.L835-.L827
	.long	.L824-.L827
	.long	.L824-.L827
	.long	.L834-.L827
	.long	.L833-.L827
	.long	.L832-.L827
	.long	.L831-.L827
	.long	.L830-.L827
	.long	.L824-.L827
	.long	.L824-.L827
	.long	.L824-.L827
	.long	.L824-.L827
	.long	.L824-.L827
	.long	.L824-.L827
	.long	.L824-.L827
	.long	.L824-.L827
	.long	.L824-.L827
	.long	.L824-.L827
	.long	.L824-.L827
	.long	.L824-.L827
	.long	.L824-.L827
	.long	.L824-.L827
	.long	.L824-.L827
	.long	.L824-.L827
	.long	.L824-.L827
	.long	.L824-.L827
	.long	.L829-.L827
	.long	.L828-.L827
	.long	.L826-.L827
	.text
	.p2align 4,,10
	.p2align 3
.L821:
	xorl	%eax, %eax
	cmpq	$0, 8(%rsp)
	sete	%al
	movq	%rax, 0(%rbp)
.L842:
	movl	$1, %eax
	jmp	.L812
.L826:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L842
.L828:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L842
.L829:
	movq	(%rsp), %rax
	andq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L842
.L830:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L824
	movq	(%rsp), %rax
	cqto
	idivq	%rcx
	movq	%rdx, 0(%rbp)
	jmp	.L842
.L831:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L824
	movq	(%rsp), %rax
	cqto
	idivq	%rcx
	movq	%rax, 0(%rbp)
	jmp	.L842
.L832:
	movq	(%rsp), %rax
	imulq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L842
.L833:
	movq	(%rsp), %rax
	subq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L842
.L834:
	movq	8(%rsp), %rax
	addq	(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L842
.L835:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setge	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L842
.L836:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setg	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L842
.L837:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setle	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L842
.L838:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setl	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L842
.L839:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L842
.L840:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	sete	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L842
	.p2align 4,,10
	.p2align 3
.L820:
	movq	8(%rsp), %rax
	negq	%rax
	movq	%rax, 0(%rbp)
	jmp	.L842
	.cfi_endproc
.LFE48:
	.size	try_eval_const_expr, .-try_eval_const_expr
	.p2align 4
	.globl	nested_base_len
	.type	nested_base_len, @function
nested_base_len:
.LFB49:
	.cfi_startproc
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L866
	cmpl	$1, (%rdi)
	je	.L870
.L866:
	ret
	.p2align 4,,10
	.p2align 3
.L870:
	movq	24(%rdi), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmove	%rdx, %rax
	ret
	.cfi_endproc
.LFE49:
	.size	nested_base_len, .-nested_base_len
	.p2align 4
	.globl	edge_words_total
	.type	edge_words_total, @function
edge_words_total:
.LFB50:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L871
	cmpl	$1, (%rdi)
	je	.L876
.L871:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L876:
	movq	24(%rdi), %rsi
	movq	16(%rdi), %rdi
	jmp	edge_words_total.part.0.isra.0
	.cfi_endproc
.LFE50:
	.size	edge_words_total, .-edge_words_total
	.p2align 4
	.globl	edge_tail_words_top
	.type	edge_tail_words_top, @function
edge_tail_words_top:
.LFB51:
	.cfi_startproc
	xorl	%r9d, %r9d
	testq	%rdi, %rdi
	je	.L889
	cmpl	$1, (%rdi)
	jne	.L889
	movq	24(%rdi), %rcx
	movq	16(%rdi), %r8
	testq	%rcx, %rcx
	je	.L889
	xorl	%edx, %edx
	jmp	.L890
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L892:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L889
.L890:
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L892
	cmpl	$1, (%rax)
	jne	.L892
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
.L893:
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r9
.L879:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L896
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L879
	cmpl	$1, (%rax)
	jne	.L879
	jmp	.L893
	.p2align 4,,10
	.p2align 3
.L889:
	.cfi_def_cfa_offset 8
	movq	%r9, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L896:
	.cfi_def_cfa_offset 16
	movq	%r9, %rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE51:
	.size	edge_tail_words_top, .-edge_tail_words_top
	.section	.rodata.str1.1
.LC104:
	.string	"%s[%zu] = "
.LC105:
	.string	";\n"
.LC106:
	.string	"%s[%zu] = B_ADDR(%s[%zu]);\n"
	.text
	.p2align 4
	.globl	emit_edge_list_init
	.type	emit_edge_list_init, @function
emit_edge_list_init:
.LFB52:
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
	je	.L898
	cmpl	$1, (%rcx)
	movq	%rcx, %r11
	jne	.L898
	cmpq	$0, 24(%rcx)
	je	.L898
	movq	%rsi, (%rsp)
	movq	%rdi, %rbx
	movl	%r9d, %ebp
	xorl	%r13d, %r13d
	movq	%r8, 8(%rsp)
	movq	%rdx, %r15
.L908:
	movq	16(%r11), %rax
	movq	(%rax,%r13,8), %r14
	testq	%r14, %r14
	je	.L902
	movl	(%r14), %eax
	testl	%eax, %eax
	je	.L926
	cmpl	$1, %eax
	je	.L927
.L902:
	addq	$1, %r13
	addq	$1, %r15
	cmpq	24(%r11), %r13
	jb	.L908
	movq	8(%rsp), %r15
.L898:
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
.L926:
	.cfi_restore_state
	xorl	%r12d, %r12d
	testl	%ebp, %ebp
	jle	.L903
	movq	%r11, 16(%rsp)
	.p2align 4
	.p2align 3
.L901:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC30(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L901
	movq	16(%rsp), %r11
.L903:
	movq	(%rsp), %rdx
	movq	%r15, %rcx
	leaq	.LC104(%rip), %rsi
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
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rsp), %r11
	jmp	.L902
	.p2align 4,,10
	.p2align 3
.L927:
	movq	24(%r14), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmovne	%rax, %rdx
	xorl	%r12d, %r12d
	movq	%rdx, 16(%rsp)
	testl	%ebp, %ebp
	jle	.L907
	movq	%r11, 24(%rsp)
	.p2align 4
	.p2align 3
.L904:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC30(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L904
	movq	24(%rsp), %r11
.L907:
	movq	8(%rsp), %r12
	movq	(%rsp), %r8
	movq	%r15, %rcx
	movq	%rbx, %rdi
	leaq	.LC106(%rip), %rsi
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
	jne	.L905
	movq	24(%r14), %rsi
	movq	16(%r14), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, 8(%rsp)
.L905:
	movq	8(%rsp), %rax
	cmpq	%rdx, %rax
	cmovnb	%rax, %rdx
	movq	%rdx, 8(%rsp)
	jmp	.L902
	.cfi_endproc
.LFE52:
	.size	emit_edge_list_init, .-emit_edge_list_init
	.section	.rodata.str1.1
.LC107:
	.string	"<"
.LC108:
	.string	"<="
.LC109:
	.string	">"
.LC110:
	.string	">="
.LC111:
	.string	"??"
.LC112:
	.string	"while ("
.LC113:
	.string	")\n"
.LC114:
	.string	"if ("
.LC115:
	.string	"switch ("
.LC116:
	.string	") {\n"
.LC117:
	.string	"continue;\n"
.LC118:
	.string	"break;\n"
.LC119:
	.string	"return"
.LC120:
	.string	"{\n"
.LC121:
	.string	"return "
.LC122:
	.string	"}\n"
.LC123:
	.string	"word __%s_store[("
.LC124:
	.string	") + 1];\n"
.LC125:
	.string	"word %s;\n"
	.section	.rodata.str1.8
	.align 8
.LC126:
	.string	"(void)B_LOCAL_PTR_N(&%s, sizeof(%s));\n"
	.align 8
.LC127:
	.string	"%s = B_LOCAL_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC128:
	.string	"word %s = 0;\n"
.LC129:
	.string	"else\n"
	.section	.rodata.str1.8
	.align 8
.LC130:
	.string	"case %zu: goto __b_label_%zu;\n"
	.align 8
.LC131:
	.string	"default: fputs(\"bcc: invalid label value\\n\", stderr); abort();\n"
	.section	.rodata.str1.1
.LC132:
	.string	"__bsw%d_case%zu"
.LC133:
	.string	"for(;;) {\n"
.LC134:
	.string	"word __sw = "
.LC135:
	.string	"__bsw%d_end"
.LC136:
	.string	"goto __bsw%d_dispatch;\n"
.LC137:
	.string	"goto __bsw%d_end;\n"
.LC138:
	.string	"__sw %s (word)%ld"
	.section	.rodata.str1.8
	.align 8
.LC139:
	.string	"(__sw >= (word)%ld && __sw <= (word)%ld)"
	.section	.rodata.str1.1
.LC140:
	.string	"__sw == (word)%ld"
.LC141:
	.string	") goto "
.LC142:
	.string	"__bsw%d_end:\n"
.LC143:
	.string	"__b_label_%d:\n"
.LC144:
	.string	"__bsw%d_dispatch:\n"
	.text
	.p2align 4
	.globl	emit_stmt
	.type	emit_stmt, @function
emit_stmt:
.LFB53:
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
	leaq	.L933(%rip), %r12
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
.L929:
	movl	g_no_line(%rip), %eax
	testl	%eax, %eax
	jne	.L930
	cmpb	$0, 24(%rsp)
	jne	.L1224
.L930:
	cmpl	$12, (%rbx)
	ja	.L928
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L933:
	.long	.L944-.L933
	.long	.L943-.L933
	.long	.L942-.L933
	.long	.L941-.L933
	.long	.L940-.L933
	.long	.L939-.L933
	.long	.L938-.L933
	.long	.L928-.L933
	.long	.L937-.L933
	.long	.L936-.L933
	.long	.L935-.L933
	.long	.L934-.L933
	.long	.L932-.L933
	.text
	.p2align 4,,10
	.p2align 3
.L1224:
	movl	4(%rbx), %edx
	movq	16(%rsp), %rcx
	movq	%r15, %rdi
	xorl	%eax, %eax
	leaq	.LC31(%rip), %rsi
	call	fprintf@PLT
	jmp	.L930
	.p2align 4,,10
	.p2align 3
.L932:
	movl	g_switch_id(%rip), %eax
	xorl	%ebp, %ebp
	leaq	.LC132(%rip), %r14
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
	je	.L1021
	movq	%rbx, 56(%rsp)
	movq	24(%rsp), %r13
	movq	%r15, 48(%rsp)
	movq	%rbp, %r15
	movq	40(%rsp), %rbp
	.p2align 4
	.p2align 3
.L1018:
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
	jb	.L1018
	movq	48(%rsp), %r15
	movq	56(%rsp), %rbx
.L1021:
	movl	8(%rsp), %edx
	movl	8(%rsp), %r14d
	xorl	%ebp, %ebp
	leaq	.LC30(%rip), %r13
	testl	%edx, %edx
	jle	.L1225
	.p2align 4
	.p2align 3
.L1019:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r14d
	jne	.L1019
	movq	%r15, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC133(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r14d
.L1022:
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 48(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1025:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1025
	movq	48(%rsp), %rbx
	movq	%r15, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC134(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	leaq	.LC105(%rip), %rax
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ecx
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC135(%rip), %rdx
	movl	$64, %esi
	call	snprintf@PLT
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 56(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1026:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1026
	movl	32(%rsp), %edx
	leaq	.LC136(%rip), %rsi
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
.L1027:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1027
	leaq	.LC137(%rip), %rax
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
.L1028:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1028
	movl	32(%rsp), %edx
	xorl	%eax, %eax
	leaq	.LC144(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r12)
	leal	2(%rax), %ebx
	je	.L1030
.L1066:
	leaq	.LC114(%rip), %rax
	movq	%r12, 16(%rsp)
	xorl	%r13d, %r13d
	leaq	.LC30(%rip), %rbp
	movq	%rax, 56(%rsp)
	movl	%r14d, 76(%rsp)
	.p2align 4
	.p2align 3
.L1044:
	movq	16(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r13,8), %r14
	movq	40(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1091
	xorl	%eax, %eax
	jmp	.L1035
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1034:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1091
.L1035:
	movq	(%rsi,%rax,8), %rdx
	cmpq	(%rdx), %r14
	jne	.L1034
	movq	8(%rdx), %rax
	movq	%rax, 24(%rsp)
.L1033:
	xorl	%r12d, %r12d
	testl	%ebx, %ebx
	jle	.L1039
	.p2align 4
	.p2align 3
.L1036:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%ebx, %r12d
	jne	.L1036
.L1039:
	movq	56(%rsp), %rdi
	movl	$1, %esi
	movq	%r15, %rcx
	movl	$4, %edx
	call	fwrite@PLT
	movl	20(%r14), %eax
	movq	24(%r14), %rsi
	testl	%eax, %eax
	je	.L1226
	leaq	.LC109(%rip), %rdx
	cmpl	$26, %eax
	je	.L1040
	ja	.L1041
	leaq	.LC107(%rip), %rdx
	cmpl	$24, %eax
	je	.L1040
	cmpl	$25, %eax
	leaq	.LC111(%rip), %rdx
	leaq	.LC108(%rip), %rax
	cmove	%rax, %rdx
.L1040:
	movq	%rsi, %rcx
	movq	%r15, %rdi
	xorl	%eax, %eax
	leaq	.LC138(%rip), %rsi
	call	fprintf@PLT
.L1042:
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	addq	$1, %r13
	leaq	.LC141(%rip), %rdi
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
	jb	.L1044
	movl	76(%rsp), %r14d
	leaq	.LC30(%rip), %r13
	testl	%ebx, %ebx
	jle	.L1227
.L1030:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1046:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1046
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	movl	8(%rsp), %r12d
	testl	%r14d, %r14d
	jle	.L1199
	.p2align 4
	.p2align 3
.L1047:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jg	.L1047
.L1199:
	movl	32(%rsp), %edx
	leaq	.LC142(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	.p2align 4
	.p2align 3
.L1051:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1051
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	xorl	%ebx, %ebx
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	jle	.L1053
	.p2align 4
	.p2align 3
.L1054:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1054
.L1053:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	call	fwrite@PLT
.L928:
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
.L944:
	.cfi_restore_state
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	leaq	.LC30(%rip), %r13
	testl	%ebp, %ebp
	jle	.L1223
	.p2align 4
	.p2align 3
.L968:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L968
.L1223:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC105(%rip), %rdi
.L1222:
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
.L943:
	.cfi_restore_state
	movl	8(%rsp), %r9d
	movl	8(%rsp), %r14d
	xorl	%r12d, %r12d
	leaq	.LC30(%rip), %r13
	testl	%r9d, %r9d
	jle	.L1228
	.p2align 4
	.p2align 3
.L966:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r14d
	jne	.L966
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L971
.L970:
	movl	8(%rsp), %edi
	xorl	%r13d, %r13d
	addl	$1, %edi
	movl	%edi, 40(%rsp)
.L978:
	movq	16(%rbx), %rdx
	movq	(%rdx,%r13,8), %r12
	testl	%ebp, %ebp
	je	.L1081
	subq	$1, %rax
	xorl	%ecx, %ecx
	cmpq	%r13, %rax
	je	.L1229
.L973:
	movq	16(%rsp), %r8
	movl	40(%rsp), %edx
	movq	%r12, %rsi
	movq	%r15, %rdi
	call	emit_stmt
.L976:
	movq	24(%rbx), %rax
	addq	$1, %r13
	cmpq	%rax, %r13
	jb	.L978
	movl	8(%rsp), %r8d
	leaq	.LC30(%rip), %r13
	testl	%r8d, %r8d
	jle	.L980
.L971:
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L981:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L981
.L980:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	jmp	.L1222
	.p2align 4,,10
	.p2align 3
.L942:
	xorl	%ecx, %ecx
	cmpq	$0, 24(%rbx)
	leaq	.LC30(%rip), %rbp
	je	.L928
	movq	%rbx, 24(%rsp)
	movl	8(%rsp), %r12d
	movq	%rcx, %r14
	.p2align 4
	.p2align 3
.L965:
	movq	24(%rsp), %rax
	movq	16(%rax), %rax
	movq	(%rax,%r14,8), %rbx
	movq	(%rbx), %rdi
	call	get_mangled_name
	cmpq	$0, 8(%rbx)
	movq	%rax, 8(%rsp)
	je	.L1230
	testl	%r12d, %r12d
	jle	.L985
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L986:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%r13d, %r12d
	jne	.L986
	movq	8(%rsp), %rdx
	leaq	.LC123(%rip), %rsi
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
	leaq	.LC124(%rip), %rdi
	call	fwrite@PLT
	.p2align 4
	.p2align 3
.L987:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L987
	movq	8(%rsp), %rdx
	xorl	%eax, %eax
	leaq	.LC125(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L1231
.L988:
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L991:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L991
.L990:
	movq	8(%rsp), %rcx
	leaq	.LC127(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	%rcx, %r8
	movq	%rcx, %rdx
	call	fprintf@PLT
.L992:
	movq	24(%rsp), %rax
	addq	$1, %r14
	cmpq	24(%rax), %r14
	jb	.L965
	jmp	.L928
	.p2align 4,,10
	.p2align 3
.L1231:
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L989:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L989
	movq	8(%rsp), %rcx
	leaq	.LC126(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	%rcx, %rdx
	call	fprintf@PLT
	jmp	.L988
	.p2align 4,,10
	.p2align 3
.L941:
	movl	8(%rsp), %eax
	xorl	%r14d, %r14d
	leaq	.LC30(%rip), %r13
	testl	%eax, %eax
	jle	.L998
	.p2align 4
	.p2align 3
.L951:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%r14d, 8(%rsp)
	jne	.L951
.L998:
	movq	%r15, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC114(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC113(%rip), %rdi
	call	fwrite@PLT
	testl	%ebp, %ebp
	jne	.L952
.L953:
	movq	24(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L999
	cmpl	$1, (%rsi)
	movl	8(%rsp), %edx
	je	.L1000
.L999:
	movl	8(%rsp), %eax
	leal	1(%rax), %edx
.L1000:
	movq	16(%rsp), %r8
	movl	%ebp, %ecx
	movq	%r15, %rdi
	call	emit_stmt
	cmpq	$0, 32(%rbx)
	je	.L928
	movl	8(%rsp), %ecx
	xorl	%ebp, %ebp
	leaq	.LC30(%rip), %r13
	testl	%ecx, %ecx
	jle	.L1004
	.p2align 4
	.p2align 3
.L1001:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, 8(%rsp)
	jne	.L1001
.L1004:
	movq	%r15, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC129(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L949
	jmp	.L950
	.p2align 4,,10
	.p2align 3
.L940:
	movl	8(%rsp), %eax
	xorl	%ebp, %ebp
	leaq	.LC30(%rip), %r13
	testl	%eax, %eax
	jle	.L1006
	.p2align 4
	.p2align 3
.L948:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, 8(%rsp)
	jne	.L948
.L1006:
	movq	%r15, %rcx
	movl	$7, %edx
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
	leaq	.LC113(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L950
.L949:
	cmpl	$1, (%rbx)
	je	.L1005
.L950:
	addl	$1, 8(%rsp)
.L1005:
	xorl	%ebp, %ebp
	jmp	.L929
	.p2align 4,,10
	.p2align 3
.L939:
	movl	8(%rsp), %r10d
	movl	8(%rsp), %r12d
	xorl	%ebp, %ebp
	leaq	.LC30(%rip), %r13
	testl	%r10d, %r10d
	jle	.L1007
	.p2align 4
	.p2align 3
.L962:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L962
.L1007:
	movq	%r15, %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC119(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%rbx)
	je	.L1223
	movq	%r15, %rsi
	movl	$32, %edi
	call	fputc@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	jmp	.L1223
	.p2align 4,,10
	.p2align 3
.L937:
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	leaq	.LC30(%rip), %r13
	testl	%ebp, %ebp
	jle	.L1009
	movl	8(%rsp), %ebp
	.p2align 4
	.p2align 3
.L958:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L958
.L1009:
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	jmp	.L1222
	.p2align 4,,10
	.p2align 3
.L938:
	movl	8(%rsp), %r11d
	movl	8(%rsp), %r14d
	xorl	%r12d, %r12d
	leaq	.LC30(%rip), %r13
	testl	%r11d, %r11d
	jle	.L1008
	.p2align 4
	.p2align 3
.L959:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r14d
	jne	.L959
.L1008:
	testl	%ebp, %ebp
	jne	.L1232
.L961:
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	jmp	.L1223
	.p2align 4,,10
	.p2align 3
.L935:
	movl	8(%rsp), %r14d
	movl	8(%rsp), %r12d
	xorl	%ebp, %ebp
	leaq	.LC30(%rip), %r13
	testl	%r14d, %r14d
	jle	.L1011
	.p2align 4
	.p2align 3
.L954:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L954
.L1011:
	movq	%r15, %rcx
	movl	$8, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC115(%rip), %rdi
	leaq	.LC130(%rip), %r13
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	%r15, %rdi
	movq	16(%rsp), %rdx
	leaq	.LC30(%rip), %rbp
	call	emit_expr
	movq	%r15, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC116(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	movl	8(%rsp), %r14d
	je	.L956
	.p2align 4
	.p2align 3
.L955:
	xorl	%ebx, %ebx
	testl	%r14d, %r14d
	js	.L1013
	.p2align 4
	.p2align 3
.L1012:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r14d
	jge	.L1012
.L1013:
	addq	$1, %r12
	xorl	%eax, %eax
	movq	%r13, %rsi
	movq	%r15, %rdi
	movq	%r12, %rcx
	movq	%r12, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %r12
	jb	.L955
.L956:
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	js	.L1014
	xorl	%ebx, %ebx
	leaq	.LC30(%rip), %r13
	.p2align 4
	.p2align 3
.L1015:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jge	.L1015
	movq	%r15, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC131(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	je	.L980
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1017:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1017
	jmp	.L980
	.p2align 4,,10
	.p2align 3
.L936:
	movl	8(%rsp), %r12d
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	leaq	.LC30(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1010
	.p2align 4
	.p2align 3
.L957:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L957
.L1010:
	movq	%r15, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	jmp	.L1222
	.p2align 4,,10
	.p2align 3
.L934:
	movl	8(%rsp), %eax
	xorl	%ebp, %ebp
	leaq	.LC30(%rip), %r13
	testl	%eax, %eax
	jle	.L1233
	.p2align 4
	.p2align 3
.L945:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, 8(%rsp)
	jne	.L945
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 32(%rsp)
	testq	%rbp, %rbp
	je	.L1234
.L946:
	movq	function_labels(%rip), %r14
	xorl	%r13d, %r13d
	jmp	.L1059
	.p2align 4,,10
	.p2align 3
.L1057:
	addq	$1, %r13
	cmpq	%rbp, %r13
	je	.L947
.L1059:
	movq	(%r14,%r13,8), %rsi
	movq	32(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1057
	leal	1(%r13), %edx
.L1058:
	leaq	.LC143(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	8(%rsp), %eax
	leaq	.LC30(%rip), %r13
	leal	1(%rax), %ebp
	testl	%ebp, %ebp
	jle	.L1062
.L1060:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1061:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, 8(%rsp)
	jne	.L1061
.L1062:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	movl	%ebp, 8(%rsp)
	movq	24(%rbx), %rbx
	xorl	%ebp, %ebp
	jmp	.L929
	.p2align 4,,10
	.p2align 3
.L1091:
	movq	$0, 24(%rsp)
	jmp	.L1033
	.p2align 4,,10
	.p2align 3
.L1226:
	movl	16(%r14), %eax
	testl	%eax, %eax
	je	.L1043
	movq	32(%r14), %rcx
	movq	%rsi, %rdx
	movq	%r15, %rdi
	xorl	%eax, %eax
	leaq	.LC139(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1042
	.p2align 4,,10
	.p2align 3
.L1230:
	xorl	%ebx, %ebx
	testl	%r12d, %r12d
	jle	.L1235
	.p2align 4
	.p2align 3
.L983:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L983
	movq	8(%rsp), %rdx
	xorl	%eax, %eax
	leaq	.LC128(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L992
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L996:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L996
.L994:
	movq	8(%rsp), %rcx
	leaq	.LC126(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	%rcx, %rdx
	call	fprintf@PLT
	jmp	.L992
.L1229:
	cmpl	$6, (%r12)
	movl	%ebp, %ecx
	jne	.L973
	movl	g_no_line(%rip), %edi
	testl	%edi, %edi
	jne	.L974
	cmpb	$0, 24(%rsp)
	je	.L974
	movl	4(%r12), %edx
	movq	16(%rsp), %rcx
	movq	%r15, %rdi
	xorl	%eax, %eax
	leaq	.LC31(%rip), %rsi
	call	fprintf@PLT
.L974:
	movl	8(%rsp), %esi
	leaq	.LC30(%rip), %rax
	xorl	%r14d, %r14d
	movq	%rax, 32(%rsp)
	testl	%esi, %esi
	js	.L977
	.p2align 4
	.p2align 3
.L975:
	movq	32(%rsp), %rdi
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r14d
	call	fwrite@PLT
	cmpl	%r14d, 8(%rsp)
	jge	.L975
.L977:
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC121(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r12), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	jmp	.L976
	.p2align 4,,10
	.p2align 3
.L1043:
	movq	%rsi, %rdx
	movq	%r15, %rdi
	leaq	.LC140(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1042
	.p2align 4,,10
	.p2align 3
.L1081:
	xorl	%ecx, %ecx
	jmp	.L973
	.p2align 4,,10
	.p2align 3
.L1041:
	cmpl	$27, %eax
	leaq	.LC111(%rip), %rdx
	leaq	.LC110(%rip), %rax
	cmove	%rax, %rdx
	jmp	.L1040
.L985:
	movq	8(%rsp), %r13
	leaq	.LC123(%rip), %rsi
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
	leaq	.LC124(%rip), %rdi
	call	fwrite@PLT
	xorl	%eax, %eax
	movq	%r13, %rdx
	movq	%r15, %rdi
	leaq	.LC125(%rip), %rsi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L990
	movq	8(%rsp), %rcx
	leaq	.LC126(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	%rcx, %rdx
	call	fprintf@PLT
	jmp	.L990
.L952:
	xorl	%ebp, %ebp
	cmpq	$0, 32(%rbx)
	sete	%bpl
	jmp	.L953
.L1227:
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	xorl	%eax, %eax
	movq	%r15, %rdi
	call	fprintf@PLT
	testl	%r14d, %r14d
	jle	.L1221
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
.L1221:
	movl	32(%rsp), %edx
	movq	%r15, %rdi
	leaq	.LC142(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1053
.L1233:
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 32(%rsp)
	testq	%rbp, %rbp
	jne	.L946
.L947:
	xorl	%edx, %edx
	jmp	.L1058
.L1232:
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC121(%rip), %rdi
	call	fwrite@PLT
	jmp	.L961
.L1235:
	movq	8(%rsp), %rdx
	xorl	%eax, %eax
	leaq	.LC128(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L992
	jmp	.L994
.L1014:
	movq	%r15, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC131(%rip), %rdi
	call	fwrite@PLT
	jmp	.L980
.L1228:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	jne	.L970
	jmp	.L980
.L1225:
	movq	%r15, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC133(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r14d
	testl	%eax, %eax
	je	.L1022
	movq	%r15, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC134(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	leaq	.LC105(%rip), %rax
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ebp
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC135(%rip), %rdx
	movl	$64, %esi
	movl	%ebp, %ecx
	call	snprintf@PLT
	movl	%ebp, %edx
	leaq	.LC136(%rip), %rsi
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
	leaq	.LC137(%rip), %rax
	movq	%rax, %rsi
	movq	%rax, 64(%rsp)
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%eax, %eax
	movl	%ebp, %edx
	leaq	.LC144(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r12)
	leal	2(%rax), %ebx
	jne	.L1066
	cmpl	$1, %ebx
	je	.L1030
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1221
	.p2align 4,,10
	.p2align 3
.L1234:
	xorl	%edx, %edx
	leaq	.LC143(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %ebp
	jmp	.L1060
	.cfi_endproc
.LFE53:
	.size	emit_stmt, .-emit_stmt
	.section	.rodata.str1.1
.LC145:
	.string	"%s:\n"
	.text
	.p2align 4
	.type	emit_stmt_switchctx, @function
emit_stmt_switchctx:
.LFB43:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.L1241(%rip), %r15
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
	je	.L1236
.L1237:
	cmpl	$13, 0(%r13)
	ja	.L1239
	movl	0(%r13), %eax
	movslq	(%r15,%rax,4), %rax
	addq	%r15, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1241:
	.long	.L1239-.L1241
	.long	.L1245-.L1241
	.long	.L1239-.L1241
	.long	.L1244-.L1241
	.long	.L1243-.L1241
	.long	.L1239-.L1241
	.long	.L1239-.L1241
	.long	.L1239-.L1241
	.long	.L1239-.L1241
	.long	.L1239-.L1241
	.long	.L1239-.L1241
	.long	.L1242-.L1241
	.long	.L1239-.L1241
	.long	.L1240-.L1241
	.text
	.p2align 4,,10
	.p2align 3
.L1239:
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
.L1240:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1289
	xorl	%eax, %eax
	jmp	.L1259
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1258:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1289
.L1259:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%r13, (%rdx)
	jne	.L1258
	movq	8(%rdx), %r14
.L1257:
	xorl	%r13d, %r13d
	leaq	.LC30(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1323
	.p2align 4
	.p2align 3
.L1260:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1260
	movq	%r14, %rdx
	leaq	.LC145(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1263:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jle	.L1263
.L1262:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC105(%rip), %rdi
	jmp	.L1322
	.p2align 4,,10
	.p2align 3
.L1242:
	xorl	%r14d, %r14d
	leaq	.LC30(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1324
	.p2align 4
	.p2align 3
.L1246:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1246
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L1325
.L1247:
	movq	function_labels(%rip), %r14
	xorl	%r12d, %r12d
	jmp	.L1267
	.p2align 4,,10
	.p2align 3
.L1265:
	addq	$1, %r12
	cmpq	%r12, 24(%rsp)
	je	.L1248
.L1267:
	movq	(%r14,%r12,8), %rsi
	movq	16(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1265
	leal	1(%r12), %edx
.L1266:
	leaq	.LC143(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	leaq	.LC30(%rip), %r12
	movl	%eax, 16(%rsp)
	testl	%eax, %eax
	jle	.L1326
.L1268:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1270:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, %ebp
	jne	.L1270
	movl	16(%rsp), %ebp
.L1271:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	jne	.L1237
	jmp	.L1236
	.p2align 4,,10
	.p2align 3
.L1243:
	xorl	%r14d, %r14d
	leaq	.LC30(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1283
	.p2align 4
	.p2align 3
.L1249:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1249
.L1283:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC112(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC113(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	je	.L1236
.L1250:
	xorl	%eax, %eax
	cmpl	$1, 0(%r13)
	setne	%al
	addl	%eax, %ebp
	jmp	.L1237
	.p2align 4,,10
	.p2align 3
.L1244:
	xorl	%r14d, %r14d
	leaq	.LC30(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1278
	.p2align 4
	.p2align 3
.L1252:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1252
.L1278:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC114(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC113(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %rsi
	testq	%rsi, %rsi
	je	.L1254
	cmpl	$1, (%rsi)
	movl	%ebp, %edx
	je	.L1279
.L1254:
	leal	1(%rbp), %edx
.L1279:
	movq	(%rsp), %r8
	movq	8(%rsp), %rcx
	movq	%rbx, %rdi
	call	emit_stmt_switchctx
	cmpq	$0, 32(%r13)
	je	.L1236
	xorl	%r14d, %r14d
	leaq	.LC30(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1282
	.p2align 4
	.p2align 3
.L1280:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1280
.L1282:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC129(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r13), %r13
	testq	%r13, %r13
	jne	.L1250
.L1236:
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
.L1245:
	.cfi_restore_state
	xorl	%r15d, %r15d
	leaq	.LC30(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1327
	.p2align 4
	.p2align 3
.L1255:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebp, %r15d
	jne	.L1255
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	je	.L1273
.L1272:
	leal	1(%rbp), %r12d
	xorl	%r15d, %r15d
.L1275:
	movq	16(%r13), %rax
	movq	(%rsp), %r8
	movl	%r12d, %edx
	movq	%rbx, %rdi
	movq	8(%rsp), %rcx
	movq	(%rax,%r15,8), %rsi
	addq	$1, %r15
	call	emit_stmt_switchctx
	cmpq	24(%r13), %r15
	jb	.L1275
	leaq	.LC30(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1274
.L1273:
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1277:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1277
.L1274:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
.L1322:
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
.L1289:
	.cfi_restore_state
	xorl	%r14d, %r14d
	jmp	.L1257
	.p2align 4,,10
	.p2align 3
.L1324:
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	jne	.L1247
	.p2align 4
	.p2align 3
.L1248:
	xorl	%edx, %edx
	jmp	.L1266
.L1325:
	xorl	%edx, %edx
	leaq	.LC143(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	movl	%eax, 16(%rsp)
	jmp	.L1268
	.p2align 4,,10
	.p2align 3
.L1323:
	xorl	%eax, %eax
	movq	%r14, %rdx
	leaq	.LC145(%rip), %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	testl	%ebp, %ebp
	jne	.L1262
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	jmp	.L1262
	.p2align 4,,10
	.p2align 3
.L1326:
	movl	%eax, %ebp
	jmp	.L1271
	.p2align 4,,10
	.p2align 3
.L1327:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	jne	.L1272
	jmp	.L1274
	.cfi_endproc
.LFE43:
	.size	emit_stmt_switchctx, .-emit_stmt_switchctx
	.section	.rodata.str1.1
.LC146:
	.string	"{\n    B_FRAME;\n"
	.section	.rodata.str1.8
	.align 8
.LC147:
	.string	"    (void)B_LOCAL_PTR_N(&%s, sizeof(%s));\n"
	.align 8
.LC148:
	.string	"    static word __b_label_value_%zu = %zu;\n"
	.text
	.p2align 4
	.type	emit_function_body, @function
emit_function_body:
.LFB54:
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
	leaq	.LC146(%rip), %rdi
	call	fwrite@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L1336
.L1329:
	cmpq	$0, 8+function_labels(%rip)
	je	.L1331
	xorl	%ebx, %ebx
	leaq	.LC148(%rip), %r14
	.p2align 4
	.p2align 3
.L1332:
	addq	$1, %rbx
	xorl	%eax, %eax
	movq	%r14, %rsi
	movq	%rbp, %rdi
	movq	%rbx, %rcx
	movq	%rbx, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %rbx
	jb	.L1332
.L1331:
	movq	32(%r12), %rsi
	movq	%r13, %r8
	movq	%rbp, %rdi
	movl	$1, %ecx
	movl	$1, %edx
	call	emit_stmt
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
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
.L1336:
	.cfi_restore_state
	cmpq	$0, 16(%r12)
	je	.L1329
	xorl	%r14d, %r14d
	leaq	.LC147(%rip), %rbx
	.p2align 4
	.p2align 3
.L1330:
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
	jb	.L1330
	jmp	.L1329
	.cfi_endproc
.LFE54:
	.size	emit_function_body, .-emit_function_body
	.section	.rodata.str1.1
.LC149:
	.string	"#define BCC_USE_CURSES 1\n"
	.section	.rodata.str1.8
	.align 8
.LC150:
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
.LC151:
	.string	"#define B_BYTEPTR %d\n"
.LC152:
	.string	"#define WORD_BITS %d\n"
	.section	.rodata.str1.8
	.align 8
.LC153:
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
.LC154:
	.string	"%s/btarget.h"
	.section	.rodata.str1.8
	.align 8
.LC155:
	.string	"#define B_TARGET_DEFINE\n#define B_TARGET_STORAGE __attribute__((common))\n"
	.align 8
.LC156:
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
	.ascii	"*/\n/* Unix V1 counts 60 Hz ticks since 1971, high word firs"
	.ascii	"t (time(II)). */\nstatic word b_time(word tvp) {\n    struct"
	.ascii	" timespec now;\n    if (clock_gettime(CLOCK_REALTIME, &now) "
	.ascii	"!= 0) return -1;\n    if (tvp) {\n        uint64_t elapsed ="
	.ascii	" (uint64_t)now.tv_sec - UINT64_C(31536000);\n        uint32_"
	.ascii	"t ticks = (uint32_t)(elapsed * 60 + (uint64_t)now.tv_nsec * "
	.ascii	"60 / 1000000000);\n        word *tv = (word*)B_CPTR(tvp);\n "
	.ascii	"       tv[0] = WVAL(ticks >> 16);\n        tv[1] = WVAL(tick"
	.ascii	"s & 65535);\n    }\n    return 0;\n}\n\n/* B72 section 8 spe"
	.ascii	"cifies a caller-owned, 16-byte date buffer. */\nstatic word "
	.ascii	"b_ctime(word tvp, word date) {\n    if (!tvp || !date) retur"
	.ascii	"n -1;\n    word *tv = (word*)B_CPTR(tvp);\n    uint32_t tick"
	.ascii	"s = ((uint32_t)(uint16_t)tv[0] << 16) | (uint16_t)tv[1];\n  "
	.ascii	"  unsigned days = ticks / 5184000U;\n    unsigned seconds = "
	.ascii	"ticks / 60U % 86400U;\n    unsigned year = 1971, month = 0;\n"
	.ascii	"    while (days >= (year % 4 == 0 ? 366U : 365U)) {\n       "
	.ascii	" days -= year % 4 == 0 ? 366U : 365U;\n        year++;\n    "
	.ascii	"}\n    static const unsigned lengths[] = {31,28,31,30,31,30,"
	.ascii	"31,31,30,31,30,31};\n    static const char *months[] = {\"Ja"
	.ascii	"n\",\"Feb\",\"Mar\",\"Apr\",\"May\",\"Jun\",\"Jul\",\"Aug\","
	.ascii	"\"Sep\",\"Oct\",\"Nov\",\"Dec\"};\n    for (;;) {\n        u"
	.ascii	"nsigned length = lengths[month] + (month == 1 && year % 4 =="
	.ascii	" 0);\n        if (days < length) break;\n        days -= len"
	.ascii	"gth;\n        month++;\n "
	.ascii	"   }\n    char text[16];\n    snprintf(text, sizeof(text), \""
	.ascii	"%s %2u %02u:%02u:%02u\", months[month], days + 1,\n         "
	.ascii	"    seconds / 3600, seconds / 60 % 60, seconds % 60);\n    f"
	.ascii	"or (size_t i = 0; i < sizeof(text); i++) b_lchar(date, (word"
	.ascii	")i, (word)(unsigned char)text[i]);\n    return 0;\n}\n\nstat"
	.ascii	"ic word b_getuid(void) {\n    return (word)getuid();\n}\nsta"
	.ascii	"tic word b_chdir(word path) {\n    const char *p = __b_cstr("
	.ascii	"path);\n    return (word)chdir(p);\n}\nstatic word b_unlink("
	.ascii	"word path) {\n    const char *p = __b_cstr(path);\n    retur"
	.ascii	"n (word)unlink(p);\n}\n\n/* System functions with actual imp"
	.ascii	"lementations */\nstatic word b_chmod(word path, word mode) {"
	.ascii	"\n    const char *p = __b_cstr(path);\n    return (word)chmo"
	.ascii	"d(p, (mode_t)mode);\n}\nstatic word b_chown(word path, word "
	.ascii	"owner) {\n    const char *p = __b_cstr(path);\n    return (w"
	.ascii	"ord)chown(p, (uid_t)owner, (gid_t)-1);\n}\nstatic word b_lin"
	.ascii	"k(word old, word new) {\n    const char *o = __b_cstr(old);\n"
	.ascii	"    const char *n = __b_cstr(new);\n    return (word)link(o,"
	.ascii	" n);\n}\nstatic word b_stat(word path, word bufp) {\n    con"
	.ascii	"st char *p = __b_cstr(path);\n    struct stat st;\n    if (s"
	.ascii	"tat(p, &st) != 0) return -1;\n    if (bufp) {\n        unsig"
	.ascii	"ned char *b = (unsigned char*)B_CPTR(bufp);\n        for (in"
	.ascii	"t i = 0; i < 20*sizeof(word); i++) b[i] = 0;\n        size_t"
	.ascii	" n = sizeof(st);\n        if (n > 20*sizeof(word)) n = 20*si"
	.ascii	"zeof(word);\n        memcpy(b, &st, n);\n    }\n    return 0"
	.ascii	";\n}\n\nstatic word b_fstat(word fd, word bufp) {\n    struc"
	.ascii	"t stat st;\n    if (fstat((int)fd, &st) != 0) return -1;\n  "
	.ascii	"  if (bufp) {\n        unsigned char *b = (unsigned char*)B_"
	.ascii	"CPTR(bufp);\n        for (int i = 0; i < 20*sizeof(word); i+"
	.ascii	"+) b[i] = 0;\n        size_t n = sizeof(st);\n        if (n "
	.ascii	"> 20*sizeof(word)) n = 20*sizeof(word);\n        memcpy(b, &"
	.ascii	"st, n);\n    }\n    return 0;\n}\nstatic word b_setuid(word "
	.ascii	"uid) {\n    return (word)setuid((uid_t)uid);\n}\nstatic word"
	.ascii	" b_makdir(word path, word mode) {\n    const char *p = __b_c"
	.ascii	"str(path);\n    return (word)mkdir(p, (mode_t)mode);\n}\n\n/"
	.ascii	"* printn(number, base) - pri"
	.ascii	"nt number in specified base (from B manual) */\nstatic word "
	.ascii	"b_printn(word n, word base) {\n    // Handle negative number"
	.ascii	"s for decimal only\n    if (base == 10 && (int16_t)n < 0) {\n"
	.ascii	"        b_putchar('-');\n        n = (word)(-(int16_t)n);\n "
	.ascii	"   }\n    b_printn_u(n, base);\n    return n;\n}\nstatic wor"
	.ascii	"d b_putnum(word n) {\n    b_printn(n, (word)10);\n    return"
	.ascii	" n;\n}\nstatic volatile sig_atomic_t __b_got_intr = 0;\n\nst"
	.ascii	"atic void __b_sigint(int sig){ (void)sig; __b_got_intr = 1; "
	.ascii	"}\n\nstatic word b_gtty(word fd, word ttstat){\n    struct t"
	.ascii	"ermios t;\n    if (tcgetattr((int)fd, &t) < 0) return -1;\n\n"
	.ascii	"    word *vec = (word*)B_CPTR(ttstat);\n    vec[0] = (word)t"
	.ascii	".c_iflag;\n    vec[1] = (word)t.c_oflag;\n    vec[2] = (word"
	.ascii	")t.c_lflag;\n    return 0;\n}\n\nstatic word b_stty(word fd,"
	.ascii	" word ttstat){\n    struct termios t;\n    if (tcgetattr((in"
	.ascii	"t)fd, &t) < 0) return -1;\n\n    word *vec = (word*)B_CPTR(t"
	.ascii	"tstat);\n    t.c_iflag = (tcflag_t)vec[0];\n    t.c_oflag = "
	.ascii	"(tcflag_t)vec[1];\n    t.c_lflag = (tcflag_t)vec[2];\n    re"
	.ascii	"turn (word)tcsetattr((int)fd, TCSANOW, &t);\n}\nstatic word "
	.ascii	"b_intr(word on) {\n    /* Set up interrupt handling */\n    "
	.ascii	"/* on != 0: catch interrupts, on =="
	.string	" 0: restore default */\n    if (on) {\n        __b_got_intr = 0;\n        if (signal(SIGINT, __b_sigint) == SIG_ERR) return -1;\n    } else {\n        if (signal(SIGINT, SIG_DFL) == SIG_ERR) return -1;\n    }\n    return 0;\n}\n\n/* Builtin aliases for B source */\n\n"
	.section	.rodata.str1.1
.LC157:
	.string	"static void __b_init(void) {\n"
	.section	.rodata.str1.8
	.align 8
.LC158:
	.string	"    setvbuf(stdout, NULL, _IONBF, 0);\n"
	.section	.rodata.str1.1
.LC159:
	.string	"static word __%s_blob[%zu];\n"
.LC160:
	.string	"static word __%s_store[%zu];\n"
.LC161:
	.string	"static word %s;\n"
.LC162:
	.string	"}\n\n"
.LC163:
	.string	"    %s = "
.LC164:
	.string	"    %s = __%s_blob[0];\n"
	.section	.rodata.str1.8
	.align 8
.LC165:
	.string	"    %s = B_PTR_N(__%s_blob, sizeof(__%s_blob));\n"
	.align 8
.LC166:
	.string	"    %s = B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC167:
	.string	"__%s_store"
.LC168:
	.string	"static word __b_user_main("
.LC169:
	.string	");\n"
.LC170:
	.string	"word "
.LC171:
	.string	"word"
.LC172:
	.string	"word __b_user_main("
	.section	.rodata.str1.8
	.align 8
.LC173:
	.string	"int main(int argc, char **argv){\n"
	.section	.rodata.str1.1
.LC174:
	.string	"    __b_setargs(argc, argv);\n"
.LC175:
	.string	"    __b_init();\n"
	.section	.rodata.str1.8
	.align 8
.LC176:
	.string	"    return (int)__b_user_main();\n"
	.align 8
.LC177:
	.string	"    return (int)__b_user_main((word)argc);\n"
	.align 8
.LC178:
	.string	"    return (int)__b_user_main((word)argc, B_PTR_N(__b_argvb, sizeof(word) * (size_t)argc));\n"
	.section	.rodata.str1.1
.LC179:
	.string	"__%s_blob"
	.text
	.p2align 4
	.globl	emit_program_c
	.type	emit_program_c, @function
emit_program_c:
.LFB56:
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
	movq	%rsi, current_program(%rip)
	movl	%r9d, current_word_bits(%rip)
	movq	$0, string_pool(%rip)
	movq	$0, 8+name_map(%rip)
	movups	%xmm0, 8+string_pool(%rip)
	call	collect_strings_program
	movl	g_use_curses(%rip), %ecx
	testl	%ecx, %ecx
	jne	.L1490
.L1338:
	movq	%rbp, %rcx
	movl	$1546, %edx
	movl	$1, %esi
	leaq	.LC150(%rip), %rdi
	call	fwrite@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbp, %rdi
	setne	%dl
	leaq	.LC151(%rip), %rsi
	leaq	32(%rsp), %r13
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%r12d, %edx
	movq	%rbp, %rdi
	xorl	%eax, %eax
	leaq	.LC152(%rip), %rsi
	call	fprintf@PLT
	movq	%rbp, %rcx
	movl	$1441, %edx
	movl	$1, %esi
	leaq	.LC153(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC154(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r13, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbp, %rcx
	movl	$73, %edx
	movl	$1, %esi
	leaq	.LC155(%rip), %rdi
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
	movl	$27392, %edx
	movl	$1, %esi
	leaq	.LC156(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1491
.L1339:
	xorl	%r12d, %r12d
	cmpq	$0, 8(%rbx)
	jne	.L1340
	jmp	.L1370
	.p2align 4,,10
	.p2align 3
.L1343:
	cmpl	$3, %eax
	je	.L1492
	cmpl	$2, %eax
	je	.L1493
.L1344:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L1370
.L1340:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rdx
	movl	(%rdx), %eax
	testl	%eax, %eax
	jne	.L1343
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
	jb	.L1340
	.p2align 4
	.p2align 3
.L1370:
	movq	%rbp, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC157(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$38, %edx
	movl	$1, %esi
	leaq	.LC158(%rip), %rdi
	call	fwrite@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L1341
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	emit_global_regions.part.0
.L1341:
	xorl	%r12d, %r12d
	cmpq	$0, 8(%rbx)
	jne	.L1371
	jmp	.L1390
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1375:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L1390
.L1371:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$2, (%rax)
	jne	.L1375
	movq	8(%rax), %r14
	movq	8(%r14), %rdi
	call	get_mangled_name
	movq	%rax, %r15
	movl	16(%r14), %eax
	testl	%eax, %eax
	jne	.L1376
	movq	48(%r14), %rax
	testq	%rax, %rax
	je	.L1375
	movl	(%rax), %eax
	testl	%eax, %eax
	jne	.L1375
	movq	%r15, %rdx
	leaq	.LC163(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r14), %rax
.L1489:
	movq	16(%rax), %rsi
	movq	(%rsp), %rdx
	movq	%rbp, %rdi
	addq	$1, %r12
	call	emit_ival_expr
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%rbx), %r12
	jb	.L1371
	.p2align 4
	.p2align 3
.L1390:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC162(%rip), %rdi
	leaq	.LC171(%rip), %r15
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	emit_known_external_function_prototypes
	cmpq	$0, 8(%rbx)
	jne	.L1372
	jmp	.L1373
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1393:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L1373
.L1372:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$1, (%rax)
	jne	.L1393
	movq	8(%rax), %r14
	leaq	.LC25(%rip), %rsi
	movq	(%r14), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1394
	leaq	.LC26(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1395
.L1394:
	movq	%rbp, %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC168(%rip), %rdi
	call	fwrite@PLT
.L1398:
	xorl	%r13d, %r13d
	cmpq	$0, 16(%r14)
	jne	.L1396
	jmp	.L1399
	.p2align 4,,10
	.p2align 3
.L1494:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC63(%rip), %rdi
	call	fwrite@PLT
.L1396:
	movq	%rbp, %rcx
	movl	$4, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
	addq	$1, %r13
	cmpq	16(%r14), %r13
	jb	.L1494
.L1399:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC169(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%rbx), %r12
	jb	.L1372
	.p2align 4
	.p2align 3
.L1373:
	movq	%rbp, %rsi
	movl	$10, %edi
	xorl	%r12d, %r12d
	call	fputc@PLT
	cmpq	$0, 8(%rbx)
	movq	$0, 16(%rsp)
	movl	$0, 8(%rsp)
	je	.L1337
	.p2align 5
	.p2align 4
	.p2align 3
.L1391:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$1, (%rax)
	je	.L1495
.L1401:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jb	.L1391
	movl	8(%rsp), %edi
	testl	%edi, %edi
	jne	.L1496
.L1337:
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
.L1493:
	.cfi_restore_state
	movq	8(%rdx), %r15
	movq	8(%r15), %rdi
	call	get_mangled_name
	movq	%rax, %r14
	movl	16(%r15), %eax
	cmpl	$1, %eax
	jne	.L1347
	movq	48(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1418
	cmpl	$1, (%rdi)
	jne	.L1418
	movq	24(%rdi), %r10
	cmpq	$1, %r10
	jne	.L1349
	movq	16(%rdi), %rax
	movq	(%rax), %rax
	movl	(%rax), %edx
	testl	%edx, %edx
	jne	.L1349
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L1349
	cmpl	$1, (%rax)
	je	.L1488
.L1349:
	call	edge_tail_words_top
	leaq	(%r10,%rax), %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	jmp	.L1348
	.p2align 4,,10
	.p2align 3
.L1376:
	cmpl	$1, %eax
	je	.L1497
	cmpl	$2, %eax
	jne	.L1375
	movq	%r15, %r8
	movq	%r15, %rcx
	movq	%r15, %rdx
	movq	%rbp, %rdi
	leaq	.LC166(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r14), %rax
	testq	%rax, %rax
	je	.L1375
	cmpl	$1, (%rax)
	jne	.L1375
	movl	32(%r14), %r10d
	movq	24(%rax), %r8
	testl	%r10d, %r10d
	jne	.L1386
	movq	24(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1386
	movq	$0, 32(%rsp)
	movq	%r13, %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1386
	movq	32(%rsp), %rax
	xorl	%edx, %edx
	testq	%rax, %rax
	cmovs	%rdx, %rax
	addq	$1, %rax
	cmpq	%rax, %r8
	cmovb	%rax, %r8
.L1385:
	movq	%r15, %rcx
	movl	$256, %esi
	movq	%r13, %rdi
	movq	%r8, 8(%rsp)
	leaq	.LC167(%rip), %rdx
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
	jmp	.L1375
	.p2align 4,,10
	.p2align 3
.L1492:
	movq	8(%rdx), %r14
	leaq	.LC27(%rip), %rdi
	movq	%rbp, %rcx
	movl	$12, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1346
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1346:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1344
	.p2align 4,,10
	.p2align 3
.L1495:
	movq	8(%rax), %r15
	leaq	.LC25(%rip), %rsi
	movq	(%r15), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1402
	leaq	.LC26(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1403
.L1402:
	movq	16(%r15), %rax
	movq	%rbp, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC172(%rip), %rdi
	movq	%rax, 16(%rsp)
	call	fwrite@PLT
	movl	$1, 8(%rsp)
.L1404:
	xorl	%r14d, %r14d
	cmpq	$0, 16(%r15)
	leaq	.LC170(%rip), %r13
	jne	.L1406
	jmp	.L1408
	.p2align 4,,10
	.p2align 3
.L1498:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC63(%rip), %rdi
	call	fwrite@PLT
.L1406:
	movq	%r13, %rdi
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r15), %rax
	movq	(%rax,%r14,8), %rdi
	testq	%rdi, %rdi
	je	.L1407
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1407:
	addq	$1, %r14
	cmpq	16(%r15), %r14
	jb	.L1498
.L1408:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC113(%rip), %rdi
	call	fwrite@PLT
	movq	(%rsp), %rdx
	movq	%r15, %rsi
	movq	%rbp, %rdi
	call	emit_function_body
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1401
	.p2align 4,,10
	.p2align 3
.L1347:
	cmpl	$2, %eax
	je	.L1499
	movl	4(%r15), %eax
	movq	%r14, %rdx
	testl	%eax, %eax
	je	.L1369
	leaq	.LC161(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1344
	.p2align 4,,10
	.p2align 3
.L1418:
	movl	$1, %ecx
.L1348:
	movq	%r14, %rdx
	leaq	.LC159(%rip), %rsi
.L1487:
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L1488:
	movq	%r14, %rdx
	leaq	.LC125(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1344
	.p2align 4,,10
	.p2align 3
.L1497:
	movq	48(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1380
	cmpl	$1, (%rdi)
	je	.L1500
.L1380:
	movq	%r15, %rcx
	movq	%r15, %rdx
	leaq	.LC164(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1375
	.p2align 4,,10
	.p2align 3
.L1496:
	movq	%rbp, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC173(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC174(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC175(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%rsp)
	je	.L1412
	cmpq	$1, 16(%rsp)
	je	.L1501
	cmpq	$2, 16(%rsp)
	jne	.L1412
	movq	%rbp, %rcx
	movl	$92, %edx
	movl	$1, %esi
	leaq	.LC178(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1410
	.p2align 4,,10
	.p2align 3
.L1490:
	movq	%rbp, %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC149(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1338
	.p2align 4,,10
	.p2align 3
.L1491:
	movq	%rbp, %rdi
	call	emit_string_pool
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1339
	.p2align 4,,10
	.p2align 3
.L1395:
	leaq	.LC170(%rip), %r13
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1397
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1397:
	movq	%rbp, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1398
	.p2align 4,,10
	.p2align 3
.L1412:
	movq	%rbp, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC176(%rip), %rdi
	call	fwrite@PLT
.L1410:
	addq	$296, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
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
.L1499:
	.cfi_restore_state
	movq	48(%r15), %r8
	movl	32(%r15), %eax
	testq	%r8, %r8
	je	.L1502
	cmpl	$1, (%r8)
	je	.L1354
	testl	%eax, %eax
	jne	.L1352
	movq	24(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1352
	movq	$0, 32(%rsp)
	movq	%r13, %rsi
	call	try_eval_const_expr
	movl	$1, %ecx
	testl	%eax, %eax
	je	.L1356
	movq	32(%rsp), %rax
	leaq	1(%rax), %rcx
	testq	%rax, %rax
	movl	$1, %eax
	cmovs	%rax, %rcx
.L1363:
	cmpl	$1, (%r8)
	jne	.L1356
.L1368:
	movq	%r8, %rdi
	movq	%rcx, 8(%rsp)
	call	edge_tail_words_top
	movq	8(%rsp), %rcx
	addq	%rax, %rcx
	movl	$1, %eax
	cmove	%rax, %rcx
	jmp	.L1356
	.p2align 4,,10
	.p2align 3
.L1369:
	leaq	.LC125(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1344
	.p2align 4,,10
	.p2align 3
.L1403:
	leaq	.LC170(%rip), %r13
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1405
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1405:
	movq	%rbp, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1404
.L1502:
	testl	%eax, %eax
	je	.L1503
.L1352:
	movl	$1, %ecx
.L1356:
	movq	%r14, %rdx
	leaq	.LC160(%rip), %rsi
	jmp	.L1487
.L1500:
	movq	24(%rdi), %rax
	movq	%rax, 8(%rsp)
	cmpq	$1, %rax
	je	.L1504
	call	edge_tail_words_top
	leaq	.LC179(%rip), %rdx
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
	je	.L1380
	cmpq	$1, 8(%rsp)
	ja	.L1415
	testq	%r10, %r10
	je	.L1380
.L1415:
	movq	%r15, %r8
	movq	%r15, %rcx
	movq	%r15, %rdx
	movq	%rbp, %rdi
	leaq	.LC165(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1375
.L1501:
	movq	%rbp, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC177(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1410
.L1503:
	movq	24(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1352
	movq	$0, 32(%rsp)
	movq	%r13, %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1352
	movq	32(%rsp), %rax
	xorl	%edx, %edx
	testq	%rax, %rax
	cmovs	%rdx, %rax
	leaq	1(%rax), %rcx
	jmp	.L1356
.L1354:
	movq	24(%r8), %rcx
	testl	%eax, %eax
	jne	.L1486
	movq	24(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1486
	movq	%r13, %rsi
	movq	%rcx, 8(%rsp)
	movq	$0, 32(%rsp)
	call	try_eval_const_expr
	movq	8(%rsp), %rcx
	testl	%eax, %eax
	je	.L1365
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
	jmp	.L1363
.L1386:
	testq	%r8, %r8
	movl	$1, %eax
	cmove	%rax, %r8
	jmp	.L1385
.L1504:
	movq	16(%rdi), %rax
	movq	(%rax), %rax
	movl	(%rax), %r11d
	testl	%r11d, %r11d
	jne	.L1382
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L1382
	cmpl	$1, (%rax)
	je	.L1505
.L1382:
	call	edge_tail_words_top
	movq	%r15, %rcx
	movl	$256, %esi
	movq	%r13, %rdi
	movq	%rax, 8(%rsp)
	leaq	.LC179(%rip), %rdx
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
	jne	.L1415
	jmp	.L1380
	.p2align 4,,10
	.p2align 3
.L1486:
	testq	%rcx, %rcx
	movl	$1, %eax
	cmove	%rax, %rcx
	jmp	.L1368
.L1365:
	testq	%rcx, %rcx
	jne	.L1363
	movl	$1, %ecx
	jmp	.L1368
	.p2align 4,,10
	.p2align 3
.L1505:
	movq	%r15, %rdx
	leaq	.LC163(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r14), %rax
	movq	16(%rax), %rax
	movq	(%rax), %rax
	jmp	.L1489
	.cfi_endproc
.LFE56:
	.size	emit_program_c, .-emit_program_c
	.section	.rodata.str1.8
	.align 8
.LC180:
	.string	"/* Generated by BCC - B Compiler */\n"
	.section	.rodata.str1.1
.LC181:
	.string	"#include \"libb.h\"\n\n"
	.section	.rodata.str1.8
	.align 8
.LC182:
	.string	"#include <ncurses.h>\n#include <panel.h>\n\n"
	.align 8
.LC183:
	.string	"\nstatic void __b_init_file_%p(void) {\n"
	.section	.rodata.str1.1
.LC184:
	.string	"    __b_init_file_%p();\n"
	.section	.rodata.str1.8
	.align 8
.LC185:
	.string	"    word *__b_argvb_ptr = (word*)B_CPTR(b_argv(0));\n"
	.align 8
.LC186:
	.string	"    return (int)__b_user_main((word)argc, B_PTR(__b_argvb_ptr - 1));\n"
	.align 8
.LC187:
	.string	"void __b_init_file_%p_export(void) __attribute__((constructor));\n"
	.align 8
.LC188:
	.string	"void __b_init_file_%p_export(void) { __b_init_file_%p(); }\n"
	.text
	.p2align 4
	.globl	emit_program_c_ext
	.type	emit_program_c_ext, @function
emit_program_c_ext:
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
	je	.L1659
	pxor	%xmm0, %xmm0
	movq	%rbx, %rdi
	movl	%r9d, current_word_bits(%rip)
	movups	%xmm0, 8+string_pool(%rip)
	movl	%ecx, current_byteptr(%rip)
	movq	%rbx, current_program(%rip)
	movq	$0, string_pool(%rip)
	movq	$0, 8+name_map(%rip)
	call	collect_strings_program
	movq	%rbp, %rcx
	movl	$36, %edx
	movl	$1, %esi
	leaq	.LC180(%rip), %rdi
	call	fwrite@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbp, %rdi
	setne	%dl
	leaq	.LC151(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%r12d, %edx
	movq	%rbp, %rdi
	xorl	%eax, %eax
	leaq	.LC152(%rip), %rsi
	call	fprintf@PLT
	movq	%rbp, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC181(%rip), %rdi
	call	fwrite@PLT
	movl	g_use_curses(%rip), %ecx
	testl	%ecx, %ecx
	jne	.L1660
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1661
.L1509:
	xorl	%r12d, %r12d
	cmpq	$0, 8(%rbx)
	jne	.L1510
	jmp	.L1540
	.p2align 4,,10
	.p2align 3
.L1513:
	cmpl	$3, %eax
	je	.L1662
	cmpl	$2, %eax
	je	.L1663
.L1514:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L1540
.L1510:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rdx
	movl	(%rdx), %eax
	testl	%eax, %eax
	jne	.L1513
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
	jb	.L1510
	.p2align 4
	.p2align 3
.L1540:
	xorl	%eax, %eax
	movq	%rbx, %rdx
	leaq	.LC183(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L1664
.L1511:
	xorl	%r12d, %r12d
	cmpq	$0, 8(%rbx)
	jne	.L1541
	jmp	.L1560
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1545:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L1560
.L1541:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$2, (%rax)
	jne	.L1545
	movq	8(%rax), %r15
	movq	8(%r15), %rdi
	call	get_mangled_name
	movq	%rax, %r13
	movl	16(%r15), %eax
	testl	%eax, %eax
	jne	.L1546
	movq	48(%r15), %rax
	testq	%rax, %rax
	je	.L1545
	movl	(%rax), %r14d
	testl	%r14d, %r14d
	jne	.L1545
	movq	%r13, %rdx
	leaq	.LC163(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r15), %rax
.L1658:
	movq	16(%rax), %rsi
	movq	(%rsp), %rdx
	movq	%rbp, %rdi
	addq	$1, %r12
	call	emit_ival_expr
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%rbx), %r12
	jb	.L1541
	.p2align 4
	.p2align 3
.L1560:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC162(%rip), %rdi
	leaq	.LC171(%rip), %r15
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	emit_known_external_function_prototypes
	cmpq	$0, 8(%rbx)
	jne	.L1542
	jmp	.L1543
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1563:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L1543
.L1542:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$1, (%rax)
	jne	.L1563
	movq	8(%rax), %r14
	leaq	.LC25(%rip), %rsi
	movq	(%r14), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1564
	leaq	.LC26(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1565
.L1564:
	movq	%rbp, %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC168(%rip), %rdi
	call	fwrite@PLT
.L1568:
	xorl	%r13d, %r13d
	cmpq	$0, 16(%r14)
	jne	.L1566
	jmp	.L1569
	.p2align 4,,10
	.p2align 3
.L1665:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC63(%rip), %rdi
	call	fwrite@PLT
.L1566:
	movq	%rbp, %rcx
	movl	$4, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
	addq	$1, %r13
	cmpq	16(%r14), %r13
	jb	.L1665
.L1569:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC169(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%rbx), %r12
	jb	.L1542
	.p2align 4
	.p2align 3
.L1543:
	movq	%rbp, %rsi
	movl	$10, %edi
	xorl	%r12d, %r12d
	call	fputc@PLT
	cmpq	$0, 8(%rbx)
	movq	$0, 8(%rsp)
	movl	$0, 16(%rsp)
	je	.L1562
	.p2align 5
	.p2align 4
	.p2align 3
.L1561:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$1, (%rax)
	je	.L1666
.L1570:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jb	.L1561
	movl	16(%rsp), %edi
	testl	%edi, %edi
	je	.L1562
	movq	%rbp, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC173(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC174(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC175(%rip), %rdi
	call	fwrite@PLT
	xorl	%eax, %eax
	movq	%rbx, %rdx
	movq	%rbp, %rdi
	leaq	.LC184(%rip), %rsi
	call	fprintf@PLT
	cmpq	$0, 8(%rsp)
	je	.L1581
	cmpq	$1, 8(%rsp)
	je	.L1667
	cmpq	$2, 8(%rsp)
	jne	.L1581
	movq	%rbp, %rcx
	movl	$52, %edx
	movl	$1, %esi
	leaq	.LC185(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC186(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1579
	.p2align 4,,10
	.p2align 3
.L1663:
	movq	8(%rdx), %r14
	movq	8(%r14), %rdi
	call	get_mangled_name
	movq	%rax, %r13
	movl	16(%r14), %eax
	cmpl	$1, %eax
	jne	.L1517
	movq	48(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1587
	cmpl	$1, (%rdi)
	jne	.L1587
	movq	24(%rdi), %r10
	cmpq	$1, %r10
	jne	.L1519
	movq	16(%rdi), %rax
	movq	(%rax), %rax
	movl	(%rax), %edx
	testl	%edx, %edx
	jne	.L1519
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L1519
	cmpl	$1, (%rax)
	je	.L1657
.L1519:
	call	edge_tail_words_top
	leaq	(%r10,%rax), %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	jmp	.L1518
	.p2align 4,,10
	.p2align 3
.L1546:
	cmpl	$1, %eax
	je	.L1668
	cmpl	$2, %eax
	jne	.L1545
	movq	%r13, %r8
	movq	%r13, %rcx
	movq	%r13, %rdx
	movq	%rbp, %rdi
	leaq	.LC166(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r15), %rax
	testq	%rax, %rax
	je	.L1545
	cmpl	$1, (%rax)
	jne	.L1545
	movl	32(%r15), %r10d
	movq	24(%rax), %r14
	testl	%r10d, %r10d
	jne	.L1556
	movq	24(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1556
	movq	$0, 32(%rsp)
	leaq	32(%rsp), %r10
	movq	%r10, %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1557
	movq	32(%rsp), %rax
	xorl	%edx, %edx
	testq	%rax, %rax
	cmovs	%rdx, %rax
	addq	$1, %rax
	cmpq	%rax, %r14
	cmovb	%rax, %r14
.L1555:
	movq	%r10, %rdi
	movq	%r13, %rcx
	movl	$256, %esi
	movq	%r10, 8(%rsp)
	leaq	.LC167(%rip), %rdx
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
	jmp	.L1545
	.p2align 4,,10
	.p2align 3
.L1517:
	cmpl	$2, %eax
	je	.L1669
	movl	4(%r14), %r15d
	movq	%r13, %rdx
	testl	%r15d, %r15d
	je	.L1539
	leaq	.LC161(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1514
	.p2align 4,,10
	.p2align 3
.L1664:
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	emit_global_regions.part.0
	jmp	.L1511
	.p2align 4,,10
	.p2align 3
.L1562:
	movq	%rbx, %rdx
	movq	%rbp, %rdi
	leaq	.LC187(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%rbx, %rcx
	movq	%rbx, %rdx
	movq	%rbp, %rdi
	addq	$296, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC188(%rip), %rsi
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
.L1661:
	.cfi_restore_state
	movq	%rbp, %rdi
	call	emit_string_pool
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1509
	.p2align 4,,10
	.p2align 3
.L1660:
	movq	%rbp, %rcx
	movl	$41, %edx
	movl	$1, %esi
	leaq	.LC182(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	je	.L1509
	jmp	.L1661
	.p2align 4,,10
	.p2align 3
.L1668:
	movq	48(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1550
	cmpl	$1, (%rdi)
	je	.L1670
.L1550:
	movq	%r13, %rcx
	movq	%r13, %rdx
	leaq	.LC164(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1545
	.p2align 4,,10
	.p2align 3
.L1587:
	movl	$1, %ecx
.L1518:
	movq	%r13, %rdx
	leaq	.LC159(%rip), %rsi
.L1656:
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L1657:
	movq	%r13, %rdx
	leaq	.LC125(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1514
	.p2align 4,,10
	.p2align 3
.L1662:
	movq	8(%rdx), %r13
	leaq	.LC27(%rip), %rdi
	movq	%rbp, %rcx
	movl	$12, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r13), %rdi
	testq	%rdi, %rdi
	je	.L1516
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1516:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1514
	.p2align 4,,10
	.p2align 3
.L1666:
	movq	8(%rax), %r15
	leaq	.LC25(%rip), %rsi
	movq	(%r15), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1571
	leaq	.LC26(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1572
.L1571:
	movq	16(%r15), %rax
	movq	%rbp, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC172(%rip), %rdi
	movq	%rax, 8(%rsp)
	call	fwrite@PLT
	movl	$1, 16(%rsp)
.L1573:
	xorl	%r14d, %r14d
	cmpq	$0, 16(%r15)
	leaq	.LC170(%rip), %r13
	jne	.L1575
	jmp	.L1577
	.p2align 4,,10
	.p2align 3
.L1671:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC63(%rip), %rdi
	call	fwrite@PLT
.L1575:
	movq	%r13, %rdi
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r15), %rax
	movq	(%rax,%r14,8), %rdi
	testq	%rdi, %rdi
	je	.L1576
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1576:
	addq	$1, %r14
	cmpq	16(%r15), %r14
	jb	.L1671
.L1577:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC113(%rip), %rdi
	call	fwrite@PLT
	movq	(%rsp), %rdx
	movq	%r15, %rsi
	movq	%rbp, %rdi
	call	emit_function_body
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1570
	.p2align 4,,10
	.p2align 3
.L1659:
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
.L1581:
	.cfi_restore_state
	movq	%rbp, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC176(%rip), %rdi
	call	fwrite@PLT
.L1579:
	addq	$296, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
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
.L1565:
	.cfi_restore_state
	leaq	.LC170(%rip), %r13
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1567
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1567:
	movq	%rbp, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1568
	.p2align 4,,10
	.p2align 3
.L1539:
	leaq	.LC125(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1514
.L1670:
	movq	24(%rdi), %r14
	cmpq	$1, %r14
	je	.L1672
	call	edge_tail_words_top
	leaq	32(%rsp), %r10
	movq	%r13, %rcx
	leaq	.LC179(%rip), %rdx
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
	je	.L1550
	cmpq	$1, %r14
	ja	.L1584
	testq	%r11, %r11
	je	.L1550
.L1584:
	movq	%r13, %r8
	movq	%r13, %rcx
	movq	%r13, %rdx
	movq	%rbp, %rdi
	leaq	.LC165(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1545
	.p2align 4,,10
	.p2align 3
.L1669:
	movq	48(%r14), %r8
	movl	32(%r14), %eax
	testq	%r8, %r8
	je	.L1673
	cmpl	$1, (%r8)
	je	.L1524
	testl	%eax, %eax
	jne	.L1522
	movq	24(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1522
	movq	$0, 32(%rsp)
	leaq	32(%rsp), %r10
	movq	%r10, %rsi
	call	try_eval_const_expr
	movl	$1, %ecx
	testl	%eax, %eax
	je	.L1526
	movq	32(%rsp), %rax
	leaq	1(%rax), %rcx
	testq	%rax, %rax
	movl	$1, %eax
	cmovs	%rax, %rcx
.L1533:
	cmpl	$1, (%r8)
	jne	.L1526
.L1538:
	movq	%r8, %rdi
	movq	%rcx, 8(%rsp)
	call	edge_tail_words_top
	movq	8(%rsp), %rcx
	addq	%rax, %rcx
	movl	$1, %eax
	cmove	%rax, %rcx
	jmp	.L1526
	.p2align 4,,10
	.p2align 3
.L1572:
	leaq	.LC170(%rip), %r13
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1574
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1574:
	movq	%rbp, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1573
.L1667:
	movq	%rbp, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC177(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1579
.L1522:
	movl	$1, %ecx
.L1526:
	movq	%r13, %rdx
	leaq	.LC160(%rip), %rsi
	jmp	.L1656
.L1673:
	testl	%eax, %eax
	jne	.L1522
	movq	24(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1522
	movq	$0, 32(%rsp)
	leaq	32(%rsp), %r10
	movq	%r10, %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1522
	movq	32(%rsp), %rax
	xorl	%edx, %edx
	testq	%rax, %rax
	cmovs	%rdx, %rax
	leaq	1(%rax), %rcx
	jmp	.L1526
.L1524:
	movq	24(%r8), %rcx
	testl	%eax, %eax
	jne	.L1655
	movq	24(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1655
	leaq	32(%rsp), %r10
	movq	%rcx, 8(%rsp)
	movq	$0, 32(%rsp)
	movq	%r10, %rsi
	call	try_eval_const_expr
	movq	8(%rsp), %rcx
	testl	%eax, %eax
	je	.L1535
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
	jmp	.L1533
.L1672:
	movq	16(%rdi), %rax
	movq	(%rax), %rax
	movl	(%rax), %r11d
	testl	%r11d, %r11d
	jne	.L1552
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L1552
	cmpl	$1, (%rax)
	je	.L1674
.L1552:
	call	edge_tail_words_top
	leaq	32(%rsp), %r10
	movq	%r13, %rcx
	leaq	.LC179(%rip), %rdx
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
	jne	.L1584
	jmp	.L1550
	.p2align 4,,10
	.p2align 3
.L1655:
	testq	%rcx, %rcx
	movl	$1, %eax
	cmove	%rax, %rcx
	jmp	.L1538
.L1556:
	testq	%r14, %r14
	movl	$1, %eax
	leaq	32(%rsp), %r10
	cmove	%rax, %r14
	jmp	.L1555
.L1557:
	testq	%r14, %r14
	movl	$1, %eax
	cmove	%rax, %r14
	jmp	.L1555
.L1535:
	testq	%rcx, %rcx
	jne	.L1533
	movl	$1, %ecx
	jmp	.L1538
	.p2align 4,,10
	.p2align 3
.L1674:
	movq	%r13, %rdx
	leaq	.LC163(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r15), %rax
	movq	16(%rax), %rax
	movq	(%rax), %rax
	jmp	.L1658
	.cfi_endproc
.LFE57:
	.size	emit_program_c_ext, .-emit_program_c_ext
	.section	.rodata
	.align 16
	.type	CSWTCH.167, @object
	.size	CSWTCH.167, 24
CSWTCH.167:
	.long	24
	.long	25
	.long	26
	.long	27
	.long	22
	.long	23
	.section	.rodata.str1.1
.LC189:
	.string	"lchar"
.LC190:
	.string	"getchar"
.LC191:
	.string	"getchr"
.LC192:
	.string	"putchr"
.LC193:
	.string	"getstr"
.LC194:
	.string	"putstr"
.LC195:
	.string	"flush"
.LC196:
	.string	"reread"
.LC197:
	.string	"printn"
.LC198:
	.string	"putnum"
.LC199:
	.string	"print"
.LC200:
	.string	"putchar"
.LC201:
	.string	"abort"
.LC202:
	.string	"free"
.LC203:
	.string	"alloc"
.LC204:
	.string	"open"
.LC205:
	.string	"close"
.LC206:
	.string	"read"
.LC207:
	.string	"write"
.LC208:
	.string	"creat"
.LC209:
	.string	"seek"
.LC210:
	.string	"openr"
.LC211:
	.string	"openw"
.LC212:
	.string	"fork"
.LC213:
	.string	"wait"
.LC214:
	.string	"execl"
.LC215:
	.string	"execv"
.LC216:
	.string	"chdir"
.LC217:
	.string	"chmod"
.LC218:
	.string	"chown"
.LC219:
	.string	"link"
.LC220:
	.string	"unlink"
.LC221:
	.string	"stat"
.LC222:
	.string	"fstat"
.LC223:
	.string	"time"
.LC224:
	.string	"ctime"
.LC225:
	.string	"getuid"
.LC226:
	.string	"setuid"
.LC227:
	.string	"makdir"
.LC228:
	.string	"intr"
.LC229:
	.string	"gtty"
.LC230:
	.string	"stty"
.LC231:
	.string	"system"
.LC232:
	.string	"usleep"
.LC233:
	.string	"argc"
.LC234:
	.string	"argv"
	.section	.data.rel.ro.local,"aw"
	.align 32
	.type	names.0, @object
	.size	names.0, 408
names.0:
	.quad	.LC13
	.quad	.LC189
	.quad	.LC190
	.quad	.LC191
	.quad	.LC192
	.quad	.LC193
	.quad	.LC194
	.quad	.LC195
	.quad	.LC196
	.quad	.LC68
	.quad	.LC197
	.quad	.LC198
	.quad	.LC199
	.quad	.LC200
	.quad	.LC75
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
	.quad	.LC231
	.quad	.LC232
	.quad	.LC64
	.quad	.LC233
	.quad	.LC234
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
.LC235:
	.string	"break"
.LC236:
	.string	"case"
.LC237:
	.string	"const"
.LC238:
	.string	"continue"
.LC239:
	.string	"default"
.LC240:
	.string	"do"
.LC241:
	.string	"double"
.LC242:
	.string	"else"
.LC243:
	.string	"enum"
.LC244:
	.string	"extern"
.LC245:
	.string	"float"
.LC246:
	.string	"for"
.LC247:
	.string	"goto"
.LC248:
	.string	"if"
.LC249:
	.string	"inline"
.LC250:
	.string	"int"
.LC251:
	.string	"long"
.LC252:
	.string	"register"
.LC253:
	.string	"restrict"
.LC254:
	.string	"short"
.LC255:
	.string	"signed"
.LC256:
	.string	"sizeof"
.LC257:
	.string	"static"
.LC258:
	.string	"struct"
.LC259:
	.string	"switch"
.LC260:
	.string	"typedef"
.LC261:
	.string	"union"
.LC262:
	.string	"unsigned"
.LC263:
	.string	"void"
.LC264:
	.string	"volatile"
.LC265:
	.string	"while"
.LC266:
	.string	"_Bool"
.LC267:
	.string	"_Complex"
.LC268:
	.string	"_Imaginary"
.LC269:
	.string	"_Alignas"
.LC270:
	.string	"_Alignof"
.LC271:
	.string	"_Atomic"
.LC272:
	.string	"_Generic"
.LC273:
	.string	"_Noreturn"
.LC274:
	.string	"_Static_assert"
.LC275:
	.string	"_Thread_local"
.LC276:
	.string	"NULL"
.LC277:
	.string	"true"
.LC278:
	.string	"false"
.LC279:
	.string	"bool"
.LC280:
	.string	"B_PTR"
.LC281:
	.string	"B_ADDR"
.LC282:
	.string	"B_DEREF"
	.section	.data.rel.ro.local
	.align 32
	.type	c_keywords, @object
	.size	c_keywords, 424
c_keywords:
	.quad	.LC14
	.quad	.LC235
	.quad	.LC236
	.quad	.LC13
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
	.quad	.LC119
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
	.quad	.LC278
	.quad	.LC279
	.quad	.LC171
	.quad	.LC280
	.quad	.LC281
	.quad	.LC282
	.quad	0
	.local	name_map
	.comm	name_map,24,16
	.local	string_pool
	.comm	string_pool,24,16
	.local	current_word_bits
	.comm	current_word_bits,4,4
	.section	.note.GNU-stack,"",@progbits
