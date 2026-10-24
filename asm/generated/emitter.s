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
.LFB34:
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
.LFE34:
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
.LFB30:
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
.LFE30:
	.size	collect_strings_expr, .-collect_strings_expr
	.p2align 4
	.type	collect_strings_init, @function
collect_strings_init:
.LFB31:
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
.LFE31:
	.size	collect_strings_init, .-collect_strings_init
	.p2align 4
	.type	collect_strings_stmt, @function
collect_strings_stmt:
.LFB32:
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
.LFE32:
	.size	collect_strings_stmt, .-collect_strings_stmt
	.p2align 4
	.type	collect_strings_program, @function
collect_strings_program:
.LFB33:
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
.LFE33:
	.size	collect_strings_program, .-collect_strings_program
	.p2align 4
	.type	collect_cases, @function
collect_cases:
.LFB43:
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
.LFE43:
	.size	collect_cases, .-collect_cases
	.p2align 4
	.type	collect_function_labels, @function
collect_function_labels:
.LFB39:
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
.LFE39:
	.size	collect_function_labels, .-collect_function_labels
	.p2align 4
	.type	edge_words_total.part.0.isra.0, @function
edge_words_total.part.0.isra.0:
.LFB68:
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
.LFE68:
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
.LFE23:
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
.LFB62:
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
.LFE62:
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
.LFB28:
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
.LFE28:
	.size	emit_known_external_function_prototypes, .-emit_known_external_function_prototypes
	.section	.rodata.str1.1
.LC29:
	.string	"__b_user_main"
	.text
	.p2align 4
	.type	emit_function_name, @function
emit_function_name:
.LFB26:
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
.LFE26:
	.size	emit_function_name, .-emit_function_name
	.section	.rodata.str1.1
.LC30:
	.string	"B_ADDR("
.LC31:
	.string	"argv"
.LC32:
	.string	"b_argv_vector"
	.text
	.p2align 4
	.type	emit_ival_expr.part.0, @function
emit_ival_expr.part.0:
.LFB64:
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
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	movl	$1, %esi
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movq	%rdi, (%rsp)
	leaq	.LC30(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rbx
	leaq	.LC31(%rip), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L382
.L360:
	movq	%rbx, %rdi
	call	get_mangled_name
	movq	(%rsp), %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L367:
	movq	(%rsp), %rsi
	addq	$24, %rsp
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
.L382:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L360
	movq	current_program(%rip), %r14
	testq	%r14, %r14
	je	.L361
	movq	8(%r14), %rax
	xorl	%ebp, %ebp
	movq	%rax, 8(%rsp)
	jmp	.L362
	.p2align 4,,10
	.p2align 3
.L363:
	testl	%eax, %eax
	je	.L383
.L364:
	addq	$1, %rbp
.L362:
	cmpq	%rbp, 8(%rsp)
	je	.L361
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rdx
	movl	(%rdx), %eax
	cmpl	$2, %eax
	jne	.L363
	movq	8(%rdx), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L364
	jmp	.L360
	.p2align 4,,10
	.p2align 3
.L383:
	movq	8(%rdx), %rax
	movq	24(%rax), %r13
	testq	%r13, %r13
	je	.L364
	movq	16(%rax), %r12
	xorl	%r15d, %r15d
	jmp	.L365
	.p2align 4,,10
	.p2align 3
.L384:
	addq	$1, %r15
	cmpq	%r13, %r15
	je	.L364
.L365:
	movq	(%r12,%r15,8), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L384
	jmp	.L360
	.p2align 4,,10
	.p2align 3
.L361:
	movq	(%rsp), %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC32(%rip), %rdi
	call	fwrite@PLT
	jmp	.L367
	.cfi_endproc
.LFE64:
	.size	emit_ival_expr.part.0, .-emit_ival_expr.part.0
	.section	.rodata.str1.1
.LC33:
	.string	"  "
	.text
	.p2align 4
	.globl	emit_indent
	.type	emit_indent, @function
emit_indent:
.LFB35:
	.cfi_startproc
	testl	%esi, %esi
	jle	.L390
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	leaq	.LC33(%rip), %r13
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
.L387:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L387
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
.L390:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	ret
	.cfi_endproc
.LFE35:
	.size	emit_indent, .-emit_indent
	.section	.rodata.str1.1
.LC34:
	.string	"#line %d \"%s\"\n"
	.text
	.p2align 4
	.globl	emit_line_directive
	.type	emit_line_directive, @function
emit_line_directive:
.LFB36:
	.cfi_startproc
	movl	g_no_line(%rip), %eax
	testl	%eax, %eax
	jne	.L393
	testq	%rdx, %rdx
	jne	.L401
.L393:
	ret
	.p2align 4,,10
	.p2align 3
.L401:
	movq	%rdx, %rcx
	xorl	%eax, %eax
	movl	%esi, %edx
	leaq	.LC34(%rip), %rsi
	jmp	fprintf@PLT
	.cfi_endproc
.LFE36:
	.size	emit_line_directive, .-emit_line_directive
	.section	.rodata.str1.1
.LC35:
	.string	"\\n"
.LC36:
	.string	"\\t"
.LC37:
	.string	"\\x%02x"
	.text
	.p2align 4
	.globl	emit_c_string
	.type	emit_c_string, @function
emit_c_string:
.LFB37:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	leaq	.LC35(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	leaq	.LC37(%rip), %r13
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
	jne	.L403
	jmp	.L410
	.p2align 4,,10
	.p2align 3
.L418:
	movq	%r13, %rsi
	movq	%r12, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L406:
	movzbl	1(%rbp), %ebx
	addq	$1, %rbp
	testb	%bl, %bl
	je	.L410
.L403:
	cmpb	$92, %bl
	je	.L411
	cmpb	$34, %bl
	je	.L411
	cmpb	$10, %bl
	je	.L416
	cmpb	$9, %bl
	je	.L417
	movzbl	%bl, %edx
	cmpb	$31, %bl
	jbe	.L418
	movq	%r12, %rsi
	movl	%edx, %edi
	addq	$1, %rbp
	call	fputc@PLT
	movzbl	0(%rbp), %ebx
	testb	%bl, %bl
	jne	.L403
.L410:
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
.L411:
	.cfi_restore_state
	movq	%r12, %rsi
	movl	$92, %edi
	call	fputc@PLT
	movzbl	%bl, %edi
	movq	%r12, %rsi
	call	fputc@PLT
	jmp	.L406
	.p2align 4,,10
	.p2align 3
.L416:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	jmp	.L406
	.p2align 4,,10
	.p2align 3
.L417:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
	jmp	.L406
	.cfi_endproc
.LFE37:
	.size	emit_c_string, .-emit_c_string
	.section	.rodata.str1.1
.LC38:
	.string	"preinc"
.LC39:
	.string	"predec"
.LC40:
	.string	"postinc"
.LC41:
	.string	"postdec"
.LC42:
	.string	"WAND"
.LC43:
	.string	"WOR"
.LC44:
	.string	"WADD"
.LC45:
	.string	"WSUB"
.LC46:
	.string	"WMUL"
.LC47:
	.string	"WSHR"
.LC48:
	.string	"WSHL"
.LC49:
	.string	"WMOD"
.LC50:
	.string	"WDIV"
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
	.section	.rodata.str1.8
	.align 8
.LC61:
	.string	"B_PTR_N(__b_str%d, sizeof(__b_str%d))"
	.section	.rodata.str1.1
.LC62:
	.string	"__b_label_value_%d"
.LC63:
	.string	"B_FUNCTION("
.LC64:
	.string	"((word (*)())B_FUNCTION_CPTR("
.LC65:
	.string	"))("
.LC66:
	.string	", "
.LC67:
	.string	"callf"
.LC68:
	.string	"b_callf_dispatch(%zu"
.LC69:
	.string	"malloc"
.LC70:
	.string	"calloc"
.LC71:
	.string	"realloc"
.LC72:
	.string	"printf"
.LC73:
	.string	"B_PTR("
.LC74:
	.string	"fprintf"
.LC75:
	.string	"dprintf"
.LC76:
	.string	"sprintf"
.LC77:
	.string	"snprintf"
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
	.text
	.p2align 4
	.globl	emit_expr
	.type	emit_expr, @function
emit_expr:
.LFB46:
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
	ja	.L419
	movl	(%rsi), %eax
	movq	%rdx, %rbp
	leaq	.L422(%rip), %rdx
	movq	%rsi, %r15
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L422:
	.long	.L432-.L422
	.long	.L431-.L422
	.long	.L430-.L422
	.long	.L429-.L422
	.long	.L428-.L422
	.long	.L427-.L422
	.long	.L426-.L422
	.long	.L425-.L422
	.long	.L424-.L422
	.long	.L423-.L422
	.long	.L421-.L422
	.text
	.p2align 4,,10
	.p2align 3
.L423:
	movq	(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	32(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC104(%rip), %rdi
	call	fwrite@PLT
	movq	40(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$3, %edx
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
.L774:
	movq	%rbp, %rdx
.L775:
	movq	%rbx, %rdi
	call	emit_expr
.L773:
	movq	%rbx, %rsi
.L777:
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
.L421:
	.cfi_restore_state
	movq	(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
.L779:
	movq	32(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC66(%rip), %rdi
.L778:
	call	fwrite@PLT
	movq	40(%r15), %rsi
	jmp	.L774
	.p2align 4,,10
	.p2align 3
.L432:
	movq	32(%rsi), %rdx
	movq	(%rsp), %rdi
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC60(%rip), %rsi
	popq	%rbp
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
.L431:
	.cfi_restore_state
	movq	32(%r15), %rdi
	movq	24(%rsi), %rsi
	call	get_string_id
	movq	(%rsp), %rdi
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC61(%rip), %rsi
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
.L430:
	.cfi_restore_state
	movq	8+function_labels(%rip), %r13
	movq	32(%rsi), %r12
	testq	%r13, %r13
	je	.L433
	movq	function_labels(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L437
	.p2align 4,,10
	.p2align 3
.L434:
	addq	$1, %rbp
	cmpq	%r13, %rbp
	je	.L750
.L437:
	movq	(%r14,%rbp,8), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L434
	movl	%ebp, %edx
	addl	$1, %edx
	je	.L750
	movq	(%rsp), %rdi
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC62(%rip), %rsi
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
.L429:
	.cfi_restore_state
	movl	20(%rsi), %r10d
	testl	%r10d, %r10d
	jne	.L781
	movq	32(%rsi), %rax
	cmpl	$2, (%rax)
	movq	32(%rax), %r12
	je	.L782
	movb	$0, 39(%rsp)
	xorl	%ebx, %ebx
	xorl	%r14d, %r14d
	movq	$0, 8(%rsp)
.L448:
	movq	(%rsp), %rdi
	movq	%r12, %rsi
	call	emit_function_name
.L458:
	movq	(%rsp), %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	48(%r15), %rdx
	movq	8(%rsp), %rcx
	cmpq	%rdx, %rcx
	jnb	.L459
	cmpb	$0, 39(%rsp)
	je	.L459
	movq	40(%r15), %rax
	movq	(%rax,%rcx,8), %rax
	testq	%rax, %rax
	je	.L486
	cmpl	$1, (%rax)
	je	.L783
.L486:
	movq	$0, 40(%rsp)
.L462:
	movq	%rdx, 16(%rsp)
	movq	(%rsp), %r12
	xorl	%r13d, %r13d
	movl	%ebx, 56(%rsp)
	movq	%rbp, 24(%rsp)
	testq	%r14, %r14
	je	.L597
.L788:
	movq	8(%rsp), %rax
	movl	current_byteptr(%rip), %ebp
	cmpq	%rax, %r13
	sete	%al
	testb	%al, 39(%rsp)
	jne	.L489
	movq	40(%rsp), %rax
	testq	%rax, %rax
	je	.L490
	movl	(%rax,%r13,4), %r8d
	testl	%r8d, %r8d
	jne	.L489
.L490:
	leaq	.LC80(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L493
	testq	%r13, %r13
	je	.L784
.L494:
	leaq	.LC82(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L496
	cmpq	$1, %r13
	jbe	.L785
.L498:
	leaq	.LC84(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L501
	cmpq	$2, %r13
	je	.L502
.L497:
	leaq	.LC86(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testq	%r13, %r13
	sete	48(%rsp)
	testl	%eax, %eax
	movzbl	48(%rsp), %ecx
	sete	%al
	andb	%cl, %al
	movl	%eax, %edx
	jne	.L786
	leaq	.LC87(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L509
	cmpq	$1, %r13
	jbe	.L510
.L508:
	leaq	.LC71(%rip), %rax
	movq	%r14, %rdi
	movq	%rax, %rsi
	movq	%rax, 64(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L511
	movb	$0, 48(%rsp)
.L512:
	leaq	.LC70(%rip), %rdx
	movq	%r14, %rdi
	movq	%rdx, %rsi
	movq	%rdx, 72(%rsp)
	call	strcmp@PLT
	leaq	.LC70(%rip), %rdx
	testl	%eax, %eax
	sete	%al
	andb	48(%rsp), %al
	xorl	$1, %eax
	movzbl	%al, %eax
	andl	%eax, %ebx
	testl	%ebp, %ebp
	jne	.L511
	leaq	.LC69(%rip), %rsi
	movq	%r14, %rdi
	movq	%rdx, 72(%rsp)
	call	strcmp@PLT
	movq	72(%rsp), %rdx
	testl	%eax, %eax
	jne	.L610
	cmpb	$0, 48(%rsp)
	je	.L610
.L517:
	testl	%ebx, %ebx
	jne	.L516
.L518:
	movq	%r12, %rcx
	movl	$32, %edx
	movl	$1, %esi
	leaq	.LC90(%rip), %rdi
	call	fwrite@PLT
	movq	40(%r15), %rax
	movq	24(%rsp), %rdx
	movq	%r12, %rdi
	movq	(%rax,%r13,8), %rsi
	call	emit_expr
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC91(%rip), %rdi
	call	fwrite@PLT
.L563:
	testl	%ebx, %ebx
	jne	.L787
.L521:
	addq	$1, %r13
	cmpq	%r13, 16(%rsp)
	je	.L522
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC66(%rip), %rdi
	call	fwrite@PLT
	testq	%r14, %r14
	jne	.L788
.L597:
	xorl	%ebx, %ebx
.L488:
	movq	40(%r15), %rax
	movq	24(%rsp), %rdx
	movq	%r12, %rdi
	movq	(%rax,%r13,8), %rsi
	call	emit_expr
	jmp	.L563
	.p2align 4,,10
	.p2align 3
.L428:
	movq	(%rsp), %rbx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC92(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	jmp	.L779
	.p2align 4,,10
	.p2align 3
.L427:
	movl	32(%rsi), %r12d
	cmpl	$32, %r12d
	je	.L789
	cmpl	$53, %r12d
	je	.L790
	leal	-36(%r12), %eax
	cmpl	$1, %eax
	jbe	.L791
	movq	(%rsp), %rbx
	cmpl	$31, %r12d
	jne	.L532
	movl	current_word_bits(%rip), %esi
	testl	%esi, %esi
	jne	.L792
.L532:
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
	movq	40(%r15), %rsi
	movq	%rbp, %rdx
	jmp	.L776
	.p2align 4,,10
	.p2align 3
.L426:
	movq	40(%rsi), %r12
	movl	32(%rsi), %r13d
	testq	%r12, %r12
	je	.L533
	movl	(%r12), %eax
	cmpl	$4, %eax
	je	.L534
	cmpl	$5, %eax
	jne	.L533
	cmpl	$32, 32(%r12)
	je	.L534
	.p2align 4
	.p2align 3
.L533:
	movl	current_word_bits(%rip), %ecx
	testl	%ecx, %ecx
	je	.L535
.L534:
	movq	(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC94(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	cmpl	$36, %r13d
	movq	%rbx, %rcx
	movl	$7, %edx
	leaq	.LC40(%rip), %rax
	leaq	.LC41(%rip), %rdi
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
.L776:
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC91(%rip), %rdi
.L772:
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
.L425:
	.cfi_restore_state
	movl	32(%rsi), %r12d
	leal	-53(%r12), %eax
	cmpl	$1, %eax
	jbe	.L793
	movl	current_word_bits(%rip), %edx
	testl	%edx, %edx
	je	.L539
	leal	-28(%r12), %eax
	cmpl	$6, %eax
	ja	.L539
	leaq	.L541(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L541:
	.long	.L605-.L541
	.long	.L546-.L541
	.long	.L545-.L541
	.long	.L544-.L541
	.long	.L543-.L541
	.long	.L542-.L541
	.long	.L540-.L541
	.text
	.p2align 4,,10
	.p2align 3
.L424:
	movl	32(%rsi), %r12d
	movq	40(%rsi), %r13
	movq	48(%rsi), %r14
	leal	-47(%r12), %eax
	cmpl	$5, %eax
	jbe	.L794
	cmpl	$21, %r12d
	je	.L549
	testq	%r13, %r13
	je	.L550
	movl	0(%r13), %eax
	cmpl	$4, %eax
	je	.L551
	cmpl	$5, %eax
	je	.L795
.L550:
	movl	current_word_bits(%rip), %eax
	testl	%eax, %eax
	je	.L549
.L551:
	leal	-38(%r12), %eax
	cmpl	$8, %eax
	ja	.L549
	leaq	.L554(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L554:
	.long	.L562-.L554
	.long	.L561-.L554
	.long	.L560-.L554
	.long	.L559-.L554
	.long	.L558-.L554
	.long	.L557-.L554
	.long	.L556-.L554
	.long	.L606-.L554
	.long	.L553-.L554
	.text
	.p2align 4,,10
	.p2align 3
.L483:
	testq	%rdx, %rdx
	jne	.L486
	movq	(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	jne	.L487
.L419:
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
.L750:
	.cfi_restore_state
	movl	16(%r15), %r13d
	testl	%r13d, %r13d
	jne	.L439
	movl	12(%r15), %ebp
	testl	%ebp, %ebp
	jne	.L440
.L441:
	movq	%r12, %rdi
	call	get_mangled_name
	movq	(%rsp), %rsi
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
.L539:
	.cfi_restore_state
	movq	(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	40(%r15), %rsi
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
	movq	48(%r15), %rsi
	jmp	.L774
	.p2align 4,,10
	.p2align 3
.L782:
	leaq	.LC67(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L796
.L449:
	leaq	8+names.0(%rip), %r13
	leaq	.LC13(%rip), %rsi
	jmp	.L453
	.p2align 4,,10
	.p2align 3
.L798:
	movq	0(%r13), %rsi
	addq	$8, %r13
	testq	%rsi, %rsi
	je	.L797
.L453:
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L798
	movq	%r12, %rdi
	call	source_function
	xorl	$1, %eax
	movl	%eax, %ebx
.L582:
	leaq	.LC69(%rip), %rsi
	movq	%r12, %rdi
	movl	$1, %r13d
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L454
	leaq	.LC70(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L454
	leaq	.LC71(%rip), %rsi
	movq	%r12, %rdi
	xorl	%r13d, %r13d
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%r13b
.L454:
	leaq	.LC72(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	orl	%ebx, %eax
	je	.L799
.L455:
	leaq	.LC74(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L590
	leaq	.LC75(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L590
	leaq	.LC76(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L590
	leaq	.LC77(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L591
	movb	$0, 39(%rsp)
	movq	$0, 8(%rsp)
	.p2align 4
	.p2align 3
.L456:
	testl	%r13d, %r13d
	jne	.L800
	movq	%r12, %rdx
	movq	%r12, %r14
	testl	%ebx, %ebx
	je	.L448
.L574:
	movq	(%rsp), %rdi
	leaq	.LC20(%rip), %rsi
	xorl	%eax, %eax
	movq	%r12, %r14
	movl	%r13d, %ebx
	call	fprintf@PLT
	jmp	.L458
	.p2align 4,,10
	.p2align 3
.L535:
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
	jmp	.L773
	.p2align 4,,10
	.p2align 3
.L791:
	movq	40(%rsi), %r13
	testq	%r13, %r13
	je	.L528
	movl	0(%r13), %eax
	cmpl	$4, %eax
	je	.L529
	cmpl	$5, %eax
	je	.L801
.L528:
	movl	current_word_bits(%rip), %edi
	testl	%edi, %edi
	je	.L530
.L529:
	movq	(%rsp), %rbx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC94(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	cmpl	$36, %r12d
	movq	%rbx, %rcx
	movl	$6, %edx
	leaq	.LC38(%rip), %rax
	leaq	.LC39(%rip), %rdi
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
	jmp	.L776
	.p2align 4,,10
	.p2align 3
.L439:
	movq	(%rsp), %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC32(%rip), %rdi
	jmp	.L772
.L546:
	leaq	.LC47(%rip), %rdx
	.p2align 4
	.p2align 3
.L547:
	movq	(%rsp), %rbx
	leaq	.LC100(%rip), %rsi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	call	fprintf@PLT
	movq	40(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC66(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
	jmp	.L774
.L605:
	leaq	.LC48(%rip), %rdx
	jmp	.L547
.L545:
	leaq	.LC44(%rip), %rdx
	jmp	.L547
.L540:
	leaq	.LC49(%rip), %rdx
	jmp	.L547
.L542:
	leaq	.LC50(%rip), %rdx
	jmp	.L547
.L543:
	leaq	.LC46(%rip), %rdx
	jmp	.L547
.L544:
	leaq	.LC45(%rip), %rdx
	jmp	.L547
.L553:
	leaq	.LC52(%rip), %r12
	.p2align 4
	.p2align 3
.L555:
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
	jmp	.L775
.L606:
	leaq	.LC53(%rip), %r12
	jmp	.L555
.L562:
	leaq	.LC51(%rip), %r12
	jmp	.L555
.L560:
	leaq	.LC58(%rip), %r12
	jmp	.L555
.L561:
	leaq	.LC59(%rip), %r12
	jmp	.L555
.L556:
	leaq	.LC54(%rip), %r12
	jmp	.L555
.L557:
	leaq	.LC55(%rip), %r12
	jmp	.L555
.L558:
	leaq	.LC56(%rip), %r12
	jmp	.L555
.L559:
	leaq	.LC57(%rip), %r12
	jmp	.L555
	.p2align 4,,10
	.p2align 3
.L489:
	testl	%ebp, %ebp
	je	.L802
.L492:
	movq	%r12, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC88(%rip), %rdi
	call	fwrite@PLT
.L520:
	movl	$1, %ebx
	jmp	.L488
	.p2align 4,,10
	.p2align 3
.L787:
	movq	%r12, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L521
	.p2align 4,,10
	.p2align 3
.L802:
	testq	%r13, %r13
	sete	%bl
.L495:
	leaq	.LC69(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L609
	testb	%bl, %bl
	jne	.L515
.L609:
	leaq	.LC71(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L803
	cmpq	$1, %r13
	jne	.L492
.L515:
	movq	%r12, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC88(%rip), %rdi
	call	fwrite@PLT
.L519:
	movl	$1, %ebx
	jmp	.L518
	.p2align 4,,10
	.p2align 3
.L522:
	movl	56(%rsp), %ebx
	movq	(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	jne	.L485
.L524:
	movq	40(%rsp), %rax
	testq	%rax, %rax
	je	.L419
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
.L549:
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
	jmp	.L775
	.p2align 4,,10
	.p2align 3
.L459:
	testq	%r14, %r14
	je	.L483
	leaq	.LC79(%rip), %rsi
	movq	%r14, %rdi
	movq	%rdx, 16(%rsp)
	call	strcmp@PLT
	movq	16(%rsp), %rdx
	testl	%eax, %eax
	jne	.L483
	testq	%rdx, %rdx
	jne	.L486
	movq	(%rsp), %r14
	movl	$48, %edi
	movq	%r14, %rsi
	call	fputc@PLT
	movq	%r14, %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	je	.L419
.L487:
	xorl	%r9d, %r9d
	movq	%r9, 40(%rsp)
	.p2align 4
	.p2align 3
.L485:
	movq	(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L524
	.p2align 4,,10
	.p2align 3
.L496:
	leaq	.LC83(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L498
	cmpq	$1, %r13
	jne	.L498
	leaq	.LC87(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L769
.L510:
	testl	%ebp, %ebp
	jne	.L507
	movq	%r13, %rax
	xorq	$1, %rax
	movl	%eax, %edx
	andl	$1, %edx
.L506:
	leaq	.LC69(%rip), %rsi
	movq	%r14, %rdi
	movb	%dl, 48(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L611
	movzbl	48(%rsp), %edx
	testb	%dl, %dl
	jne	.L516
.L611:
	leaq	.LC71(%rip), %rsi
	movq	%r14, %rdi
	movl	$1, %ebx
	call	strcmp@PLT
	leaq	.LC70(%rip), %rdx
	testl	%eax, %eax
	je	.L804
.L571:
	movq	%rdx, %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	cmpq	$1, %r13
	jne	.L511
	testl	%eax, %eax
	je	.L517
	.p2align 4
	.p2align 3
.L511:
	testl	%ebx, %ebx
	je	.L488
.L507:
	movq	%r12, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC89(%rip), %rdi
	call	fwrite@PLT
	jmp	.L520
	.p2align 4,,10
	.p2align 3
.L803:
	leaq	.LC70(%rip), %rdx
	movq	%r14, %rdi
	movq	%rdx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L492
	cmpq	$1, %r13
	je	.L515
	jmp	.L492
	.p2align 4,,10
	.p2align 3
.L493:
	leaq	.LC81(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%bl
	testq	%r13, %r13
	sete	%al
	andb	%al, %bl
	je	.L494
	testl	%ebp, %ebp
	je	.L495
	jmp	.L492
	.p2align 4,,10
	.p2align 3
.L781:
	movq	(%rsp), %rbx
	movl	$29, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC64(%rip), %rdi
	leaq	.LC66(%rip), %r13
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	32(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC65(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 48(%r15)
	je	.L446
.L445:
	movq	40(%r15), %rax
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	emit_expr
	cmpq	48(%r15), %r12
	jnb	.L446
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	jmp	.L445
.L450:
	movq	(%rsp), %rbx
	leaq	-1(%r14), %rdx
	xorl	%eax, %eax
	xorl	%r12d, %r12d
	leaq	.LC68(%rip), %rsi
	leaq	.LC66(%rip), %r13
	movq	%rbx, %rdi
	call	fprintf@PLT
.L451:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	40(%r15), %rax
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	emit_expr
	cmpq	%r12, %r14
	jne	.L451
	.p2align 4
	.p2align 3
.L446:
	movq	(%rsp), %rsi
	jmp	.L777
	.p2align 4,,10
	.p2align 3
.L794:
	movq	(%rsp), %rbx
	leaq	CSWTCH.171(%rip), %rdx
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
	jmp	.L776
	.p2align 4,,10
	.p2align 3
.L590:
	movb	$1, 39(%rsp)
	movq	$1, 8(%rsp)
	jmp	.L456
.L769:
	movb	$0, 48(%rsp)
	movl	$1, %ebx
.L509:
	leaq	.LC71(%rip), %rax
	movq	%r14, %rdi
	movq	%rax, %rsi
	movq	%rax, 64(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L512
	movzbl	48(%rsp), %eax
	orl	%eax, %ebx
	testl	%ebp, %ebp
	jne	.L511
	leaq	.LC69(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L570
	cmpb	$0, 48(%rsp)
	jne	.L517
.L570:
	cmpq	$1, %r13
	jne	.L511
	jmp	.L517
	.p2align 4,,10
	.p2align 3
.L501:
	leaq	.LC85(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L608
	cmpq	$2, %r13
	je	.L502
.L608:
	xorl	%ebx, %ebx
	jmp	.L497
.L502:
	leaq	.LC87(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L769
	movl	$1, %ebx
	jmp	.L508
	.p2align 4,,10
	.p2align 3
.L793:
	movl	expression_id(%rip), %eax
	movq	(%rsp), %rbx
	leaq	.LC97(%rip), %rsi
	leal	1(%rax), %r13d
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movl	%r13d, %edx
	movl	%r13d, expression_id(%rip)
	call	fprintf@PLT
	movq	40(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r13d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC98(%rip), %rsi
	call	fprintf@PLT
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	cmpl	$53, %r12d
	movl	%r13d, %r8d
	movl	%r13d, %ecx
	leaq	.LC42(%rip), %rax
	leaq	.LC43(%rip), %rdx
	movq	%rbx, %rdi
	cmove	%rax, %rdx
	addq	$88, %rsp
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
.L440:
	.cfi_restore_state
	movq	(%rsp), %rbx
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC63(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	movq	32(%r15), %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	jmp	.L773
.L795:
	cmpl	$32, 32(%r13)
	jne	.L550
	jmp	.L551
.L789:
	movq	(%rsp), %rbx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC93(%rip), %rdi
	movq	%rbx, %rcx
	jmp	.L778
.L784:
	testl	%ebp, %ebp
	jne	.L492
	movl	$1, %ebx
	jmp	.L495
.L797:
	xorl	%ebx, %ebx
	jmp	.L582
.L790:
	movq	(%rsp), %rbx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC30(%rip), %rdi
	movq	%rbx, %rcx
	jmp	.L778
.L792:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC96(%rip), %rdi
	jmp	.L778
.L796:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L449
	movq	48(%r15), %r14
	testq	%r14, %r14
	jne	.L450
	movq	(%rsp), %rdi
	xorl	%edx, %edx
	leaq	.LC68(%rip), %rsi
	call	fprintf@PLT
	jmp	.L446
.L799:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L455
	testl	%r13d, %r13d
	jne	.L805
	movb	$1, 39(%rsp)
	movq	%r12, %r14
	xorl	%ebx, %ebx
	movq	$0, 8(%rsp)
	jmp	.L448
.L786:
	testl	%ebp, %ebp
	je	.L506
	jmp	.L507
.L804:
	cmpq	$1, %r13
	jne	.L507
.L516:
	movq	%r12, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC89(%rip), %rdi
	call	fwrite@PLT
	jmp	.L519
.L800:
	movq	(%rsp), %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC73(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r15), %rax
	movq	32(%rax), %rdx
	testl	%ebx, %ebx
	je	.L592
	cmpl	$2, (%rax)
	je	.L806
	movq	%r12, %r14
	movq	%rdx, %r12
	jmp	.L448
.L785:
	movl	$1, %ebx
	jmp	.L497
.L433:
	movl	16(%rsi), %ebx
	testl	%ebx, %ebx
	jne	.L439
	movl	12(%rsi), %r11d
	testl	%r11d, %r11d
	jne	.L440
	testq	%r12, %r12
	je	.L419
	jmp	.L441
.L783:
	movq	%rdx, %rdi
	movl	$4, %esi
	movq	%rdx, 16(%rsp)
	movq	32(%rax), %r12
	call	calloc@PLT
	movq	16(%rsp), %rdx
	testq	%rax, %rax
	movq	%rax, 40(%rsp)
	je	.L486
	movq	8(%rsp), %rax
	xorl	%r13d, %r13d
	leaq	1(%rax), %rsi
	movzbl	(%r12), %eax
	testb	%al, %al
	je	.L462
	movq	%r14, 24(%rsp)
	movl	%ebx, 16(%rsp)
	movq	%rsi, %rbx
	movq	%rbp, 48(%rsp)
	movq	%r12, %rbp
	movq	%rdx, %r12
	.p2align 4
	.p2align 3
.L461:
	cmpb	$37, %al
	jne	.L765
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	cmpb	$37, %r14b
	je	.L765
	testb	%r14b, %r14b
	jne	.L464
	jmp	.L762
	.p2align 4,,10
	.p2align 3
.L467:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	testb	%r14b, %r14b
	je	.L466
.L464:
	movsbl	%r14b, %esi
	leaq	.LC78(%rip), %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L467
	cmpb	$42, %r14b
	jne	.L466
	cmpq	%r12, %rbx
	adcq	$0, %rbx
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %edx
.L471:
	cmpb	$46, %dl
	je	.L807
.L473:
	cmpb	$104, %dl
	je	.L808
	cmpb	$108, %dl
	je	.L809
	testb	%dl, %dl
	je	.L762
	leaq	1(%r13), %rax
	cmpb	$115, %dl
	jne	.L479
	cmpq	%r12, %rbx
	jnb	.L479
	movq	40(%rsp), %rcx
	movl	$1, (%rcx,%rbx,4)
	.p2align 4
	.p2align 3
.L479:
	addq	$1, %rbx
.L463:
	movq	%rax, %r13
	movzbl	0(%rbp,%rax), %eax
	testb	%al, %al
	jne	.L461
.L762:
	movl	16(%rsp), %ebx
	movq	24(%rsp), %r14
	movq	%r12, %rdx
	movq	48(%rsp), %rbp
	jmp	.L462
	.p2align 4,,10
	.p2align 3
.L765:
	leaq	1(%r13), %rax
	jmp	.L463
.L466:
	movzbl	0(%rbp,%r13), %edx
	testb	%dl, %dl
	movb	%dl, 56(%rsp)
	je	.L762
	call	__ctype_b_loc@PLT
	movzbl	56(%rsp), %edx
	movq	(%rax), %rax
	jmp	.L469
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L472:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %edx
	testb	%dl, %dl
	je	.L762
.L469:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L472
	movzbl	0(%rbp,%r13), %edx
	jmp	.L471
.L808:
	cmpb	$104, 1(%rbp,%r13)
	leaq	1(%r13), %rax
	jne	.L479
.L596:
	leaq	2(%r13), %rax
	jmp	.L479
.L807:
	movzbl	1(%rbp,%r13), %edx
	leaq	1(%r13), %rdi
	movq	%rdi, 56(%rsp)
	cmpb	$42, %dl
	jne	.L810
	cmpq	%r12, %rbx
	adcq	$0, %rbx
	addq	$2, %r13
	movzbl	0(%rbp,%r13), %edx
	jmp	.L473
.L809:
	cmpb	$108, 1(%rbp,%r13)
	leaq	1(%r13), %rax
	jne	.L479
	jmp	.L596
.L530:
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
	jmp	.L775
.L801:
	cmpl	$32, 32(%r13)
	jne	.L528
	jmp	.L529
.L810:
	testb	%dl, %dl
	movb	%dl, 64(%rsp)
	je	.L762
	call	__ctype_b_loc@PLT
	movzbl	64(%rsp), %edx
	movq	56(%rsp), %rdi
	movq	(%rax), %rax
	jmp	.L475
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L477:
	addq	$1, %rdi
	movzbl	0(%rbp,%rdi), %edx
	testb	%dl, %dl
	je	.L762
.L475:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L477
	movzbl	0(%rbp,%rdi), %edx
	movq	%rdi, %r13
	jmp	.L473
.L805:
	movq	(%rsp), %rcx
	movl	$6, %edx
	movq	%r12, %r14
	movl	%r13d, %ebx
	movl	$1, %esi
	leaq	.LC73(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r15), %rax
	movb	$1, 39(%rsp)
	movq	$0, 8(%rsp)
	movq	32(%rax), %r12
	jmp	.L448
.L591:
	movb	$1, 39(%rsp)
	movq	$2, 8(%rsp)
	jmp	.L456
.L592:
	movq	%r12, %r14
	movl	%r13d, %ebx
	movq	%rdx, %r12
	jmp	.L448
.L610:
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	movq	%rdx, 48(%rsp)
	call	strcmp@PLT
	movq	48(%rsp), %rdx
	testl	%eax, %eax
	jne	.L571
	jmp	.L570
.L806:
	movl	%ebx, %r13d
	jmp	.L574
	.cfi_endproc
.LFE46:
	.size	emit_expr, .-emit_expr
	.p2align 4
	.globl	emit_ival_expr
	.type	emit_ival_expr, @function
emit_ival_expr:
.LFB47:
	.cfi_startproc
	cmpl	$2, (%rsi)
	je	.L813
	jmp	emit_expr
	.p2align 4,,10
	.p2align 3
.L813:
	jmp	emit_ival_expr.part.0
	.cfi_endproc
.LFE47:
	.size	emit_ival_expr, .-emit_ival_expr
	.p2align 4
	.globl	init_list_length
	.type	init_list_length, @function
init_list_length:
.LFB48:
	.cfi_startproc
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L814
	cmpl	$1, (%rdi)
	je	.L818
.L814:
	ret
	.p2align 4,,10
	.p2align 3
.L818:
	movq	24(%rdi), %rax
	ret
	.cfi_endproc
.LFE48:
	.size	init_list_length, .-init_list_length
	.p2align 4
	.globl	try_eval_const_expr
	.type	try_eval_const_expr, @function
try_eval_const_expr:
.LFB49:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L851
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
	je	.L821
	ja	.L822
	testl	%eax, %eax
	je	.L823
	cmpl	$5, %eax
	jne	.L831
	movq	40(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L819
	movl	32(%rbx), %eax
	cmpl	$31, %eax
	je	.L827
	cmpl	$35, %eax
	je	.L828
	.p2align 4
	.p2align 3
.L831:
	xorl	%eax, %eax
.L819:
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
.L822:
	.cfi_restore_state
	cmpl	$10, %eax
	jne	.L831
	movq	32(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L819
	movq	40(%rbx), %rdi
	movq	%rbp, %rsi
	call	try_eval_const_expr
	jmp	.L819
	.p2align 4,,10
	.p2align 3
.L851:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L823:
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
.L821:
	.cfi_restore_state
	movq	40(%rdi), %rdi
	movq	%rsp, %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L831
	movq	48(%rbx), %rdi
	leaq	8(%rsp), %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L831
	movl	32(%rbx), %eax
	subl	$22, %eax
	cmpl	$33, %eax
	ja	.L831
	leaq	.L834(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L834:
	.long	.L847-.L834
	.long	.L846-.L834
	.long	.L845-.L834
	.long	.L844-.L834
	.long	.L843-.L834
	.long	.L842-.L834
	.long	.L831-.L834
	.long	.L831-.L834
	.long	.L841-.L834
	.long	.L840-.L834
	.long	.L839-.L834
	.long	.L838-.L834
	.long	.L837-.L834
	.long	.L831-.L834
	.long	.L831-.L834
	.long	.L831-.L834
	.long	.L831-.L834
	.long	.L831-.L834
	.long	.L831-.L834
	.long	.L831-.L834
	.long	.L831-.L834
	.long	.L831-.L834
	.long	.L831-.L834
	.long	.L831-.L834
	.long	.L831-.L834
	.long	.L831-.L834
	.long	.L831-.L834
	.long	.L831-.L834
	.long	.L831-.L834
	.long	.L831-.L834
	.long	.L831-.L834
	.long	.L836-.L834
	.long	.L835-.L834
	.long	.L833-.L834
	.text
	.p2align 4,,10
	.p2align 3
.L828:
	xorl	%eax, %eax
	cmpq	$0, 8(%rsp)
	sete	%al
	movq	%rax, 0(%rbp)
.L849:
	movl	$1, %eax
	jmp	.L819
.L833:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L849
.L835:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L849
.L836:
	movq	(%rsp), %rax
	andq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L849
.L837:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L831
	movq	(%rsp), %rax
	cqto
	idivq	%rcx
	movq	%rdx, 0(%rbp)
	jmp	.L849
.L838:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L831
	movq	(%rsp), %rax
	cqto
	idivq	%rcx
	movq	%rax, 0(%rbp)
	jmp	.L849
.L839:
	movq	(%rsp), %rax
	imulq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L849
.L840:
	movq	(%rsp), %rax
	subq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L849
.L841:
	movq	8(%rsp), %rax
	addq	(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L849
.L842:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setge	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L849
.L843:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setg	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L849
.L844:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setle	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L849
.L845:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setl	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L849
.L846:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L849
.L847:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	sete	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L849
	.p2align 4,,10
	.p2align 3
.L827:
	movq	8(%rsp), %rax
	negq	%rax
	movq	%rax, 0(%rbp)
	jmp	.L849
	.cfi_endproc
.LFE49:
	.size	try_eval_const_expr, .-try_eval_const_expr
	.p2align 4
	.globl	nested_base_len
	.type	nested_base_len, @function
nested_base_len:
.LFB50:
	.cfi_startproc
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L873
	cmpl	$1, (%rdi)
	je	.L877
.L873:
	ret
	.p2align 4,,10
	.p2align 3
.L877:
	movq	24(%rdi), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmove	%rdx, %rax
	ret
	.cfi_endproc
.LFE50:
	.size	nested_base_len, .-nested_base_len
	.p2align 4
	.globl	edge_words_total
	.type	edge_words_total, @function
edge_words_total:
.LFB51:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L878
	cmpl	$1, (%rdi)
	je	.L883
.L878:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L883:
	movq	24(%rdi), %rsi
	movq	16(%rdi), %rdi
	jmp	edge_words_total.part.0.isra.0
	.cfi_endproc
.LFE51:
	.size	edge_words_total, .-edge_words_total
	.p2align 4
	.globl	edge_tail_words_top
	.type	edge_tail_words_top, @function
edge_tail_words_top:
.LFB52:
	.cfi_startproc
	xorl	%r9d, %r9d
	testq	%rdi, %rdi
	je	.L896
	cmpl	$1, (%rdi)
	jne	.L896
	movq	24(%rdi), %rcx
	movq	16(%rdi), %r8
	testq	%rcx, %rcx
	je	.L896
	xorl	%edx, %edx
	jmp	.L897
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L899:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L896
.L897:
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L899
	cmpl	$1, (%rax)
	jne	.L899
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
.L900:
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r9
.L886:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L903
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L886
	cmpl	$1, (%rax)
	jne	.L886
	jmp	.L900
	.p2align 4,,10
	.p2align 3
.L896:
	.cfi_def_cfa_offset 8
	movq	%r9, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L903:
	.cfi_def_cfa_offset 16
	movq	%r9, %rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE52:
	.size	edge_tail_words_top, .-edge_tail_words_top
	.section	.rodata.str1.1
.LC106:
	.string	"%s[%zu] = "
.LC107:
	.string	";\n"
.LC108:
	.string	"%s[%zu] = B_ADDR(%s[%zu]);\n"
	.text
	.p2align 4
	.globl	emit_edge_list_init
	.type	emit_edge_list_init, @function
emit_edge_list_init:
.LFB53:
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
	je	.L905
	cmpl	$1, (%rcx)
	movq	%rcx, %r15
	jne	.L905
	cmpq	$0, 24(%rcx)
	je	.L905
	movq	%rsi, (%rsp)
	movq	%rdi, %rbx
	movl	%r9d, %ebp
	xorl	%r13d, %r13d
	movq	%r8, 8(%rsp)
.L918:
	movq	16(%r15), %rax
	movq	(%rax,%r13,8), %r10
	testq	%r10, %r10
	je	.L913
	movl	(%r10), %eax
	testl	%eax, %eax
	je	.L937
	cmpl	$1, %eax
	je	.L938
.L913:
	addq	$1, %r13
	addq	$1, %r12
	cmpq	24(%r15), %r13
	jb	.L918
	movq	8(%rsp), %rdx
.L905:
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
.L937:
	.cfi_restore_state
	xorl	%r14d, %r14d
	testl	%ebp, %ebp
	jle	.L911
	movq	%r12, 16(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L908:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC33(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L908
	movq	16(%rsp), %r12
	movq	%r14, %r10
.L911:
	movq	(%rsp), %rdx
	leaq	.LC106(%rip), %rsi
	xorl	%eax, %eax
	movq	%r12, %rcx
	movq	%rbx, %rdi
	movq	%r10, 16(%rsp)
	call	fprintf@PLT
	movq	16(%rsp), %r10
	movq	16(%r10), %rsi
	cmpl	$2, (%rsi)
	je	.L939
	movq	96(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L912:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC107(%rip), %rdi
	call	fwrite@PLT
	jmp	.L913
	.p2align 4,,10
	.p2align 3
.L938:
	movq	24(%r10), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmovne	%rax, %rdx
	xorl	%r14d, %r14d
	movq	%rdx, 16(%rsp)
	testl	%ebp, %ebp
	jle	.L917
	movq	%r12, 24(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L914:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC33(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L914
	movq	24(%rsp), %r12
	movq	%r14, %r10
.L917:
	movq	8(%rsp), %r14
	movq	(%rsp), %r8
	movq	%r12, %rcx
	movq	%rbx, %rdi
	leaq	.LC108(%rip), %rsi
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
	jne	.L915
	movq	24(%r10), %rsi
	movq	16(%r10), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, 8(%rsp)
.L915:
	movq	8(%rsp), %rax
	cmpq	%rdx, %rax
	cmovnb	%rax, %rdx
	movq	%rdx, 8(%rsp)
	jmp	.L913
	.p2align 4,,10
	.p2align 3
.L939:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L912
	.cfi_endproc
.LFE53:
	.size	emit_edge_list_init, .-emit_edge_list_init
	.section	.rodata.str1.1
.LC109:
	.string	"<"
.LC110:
	.string	"<="
.LC111:
	.string	">"
.LC112:
	.string	">="
.LC113:
	.string	"??"
.LC114:
	.string	"while ("
.LC115:
	.string	")\n"
.LC116:
	.string	"if ("
.LC117:
	.string	"switch ("
.LC118:
	.string	") {\n"
.LC119:
	.string	"continue;\n"
.LC120:
	.string	"break;\n"
.LC121:
	.string	"return"
.LC122:
	.string	"{\n"
.LC123:
	.string	"return "
.LC124:
	.string	"}\n"
.LC125:
	.string	"word __%s_store[("
.LC126:
	.string	") + 1];\n"
.LC127:
	.string	"word %s;\n"
	.section	.rodata.str1.8
	.align 8
.LC128:
	.string	"(void)B_LOCAL_PTR_N(&%s, sizeof(%s));\n"
	.align 8
.LC129:
	.string	"%s = B_LOCAL_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC130:
	.string	"word %s = 0;\n"
.LC131:
	.string	"else\n"
	.section	.rodata.str1.8
	.align 8
.LC132:
	.string	"case %zu: goto __b_label_%zu;\n"
	.align 8
.LC133:
	.string	"default: fputs(\"bcc: invalid label value\\n\", stderr); abort();\n"
	.section	.rodata.str1.1
.LC134:
	.string	"__bsw%d_case%zu"
.LC135:
	.string	"for(;;) {\n"
.LC136:
	.string	"word __sw = "
.LC137:
	.string	"__bsw%d_end"
.LC138:
	.string	"goto __bsw%d_dispatch;\n"
.LC139:
	.string	"goto __bsw%d_end;\n"
.LC140:
	.string	"__sw %s (word)%ld"
	.section	.rodata.str1.8
	.align 8
.LC141:
	.string	"(__sw >= (word)%ld && __sw <= (word)%ld)"
	.section	.rodata.str1.1
.LC142:
	.string	"__sw == (word)%ld"
.LC143:
	.string	") goto "
.LC144:
	.string	"__bsw%d_end:\n"
.LC145:
	.string	"__b_label_%d:\n"
.LC146:
	.string	"__bsw%d_dispatch:\n"
	.text
	.p2align 4
	.globl	emit_stmt
	.type	emit_stmt, @function
emit_stmt:
.LFB54:
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
	leaq	.L945(%rip), %r12
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
.L941:
	movl	g_no_line(%rip), %eax
	testl	%eax, %eax
	jne	.L942
	cmpb	$0, 24(%rsp)
	jne	.L1236
.L942:
	cmpl	$12, (%rbx)
	ja	.L940
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L945:
	.long	.L956-.L945
	.long	.L955-.L945
	.long	.L954-.L945
	.long	.L953-.L945
	.long	.L952-.L945
	.long	.L951-.L945
	.long	.L950-.L945
	.long	.L940-.L945
	.long	.L949-.L945
	.long	.L948-.L945
	.long	.L947-.L945
	.long	.L946-.L945
	.long	.L944-.L945
	.text
	.p2align 4,,10
	.p2align 3
.L1236:
	movl	4(%rbx), %edx
	movq	16(%rsp), %rcx
	movq	%r15, %rdi
	xorl	%eax, %eax
	leaq	.LC34(%rip), %rsi
	call	fprintf@PLT
	jmp	.L942
	.p2align 4,,10
	.p2align 3
.L944:
	movl	g_switch_id(%rip), %eax
	xorl	%ebp, %ebp
	leaq	.LC134(%rip), %r14
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
	je	.L1033
	movq	%rbx, 56(%rsp)
	movq	24(%rsp), %r13
	movq	%r15, 48(%rsp)
	movq	%rbp, %r15
	movq	40(%rsp), %rbp
	.p2align 4
	.p2align 3
.L1030:
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
	jb	.L1030
	movq	48(%rsp), %r15
	movq	56(%rsp), %rbx
.L1033:
	movl	8(%rsp), %edx
	movl	8(%rsp), %r14d
	xorl	%ebp, %ebp
	leaq	.LC33(%rip), %r13
	testl	%edx, %edx
	jle	.L1237
	.p2align 4
	.p2align 3
.L1031:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r14d
	jne	.L1031
	movq	%r15, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC135(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r14d
.L1034:
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 48(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1037:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1037
	movq	48(%rsp), %rbx
	movq	%r15, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC136(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	leaq	.LC107(%rip), %rax
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ecx
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC137(%rip), %rdx
	movl	$64, %esi
	call	snprintf@PLT
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 56(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1038:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1038
	movl	32(%rsp), %edx
	leaq	.LC138(%rip), %rsi
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
.L1039:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1039
	leaq	.LC139(%rip), %rax
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
.L1040:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1040
	movl	32(%rsp), %edx
	xorl	%eax, %eax
	leaq	.LC146(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r12)
	leal	2(%rax), %ebx
	je	.L1042
.L1078:
	leaq	.LC116(%rip), %rax
	movq	%r12, 16(%rsp)
	xorl	%r13d, %r13d
	leaq	.LC33(%rip), %rbp
	movq	%rax, 56(%rsp)
	movl	%r14d, 76(%rsp)
	.p2align 4
	.p2align 3
.L1056:
	movq	16(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r13,8), %r14
	movq	40(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1103
	xorl	%eax, %eax
	jmp	.L1047
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1046:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1103
.L1047:
	movq	(%rsi,%rax,8), %rdx
	cmpq	(%rdx), %r14
	jne	.L1046
	movq	8(%rdx), %rax
	movq	%rax, 24(%rsp)
.L1045:
	xorl	%r12d, %r12d
	testl	%ebx, %ebx
	jle	.L1051
	.p2align 4
	.p2align 3
.L1048:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%ebx, %r12d
	jne	.L1048
.L1051:
	movq	56(%rsp), %rdi
	movl	$1, %esi
	movq	%r15, %rcx
	movl	$4, %edx
	call	fwrite@PLT
	movl	20(%r14), %eax
	movq	24(%r14), %rsi
	testl	%eax, %eax
	je	.L1238
	leaq	.LC111(%rip), %rdx
	cmpl	$26, %eax
	je	.L1052
	ja	.L1053
	leaq	.LC109(%rip), %rdx
	cmpl	$24, %eax
	je	.L1052
	cmpl	$25, %eax
	leaq	.LC113(%rip), %rdx
	leaq	.LC110(%rip), %rax
	cmove	%rax, %rdx
.L1052:
	movq	%rsi, %rcx
	movq	%r15, %rdi
	xorl	%eax, %eax
	leaq	.LC140(%rip), %rsi
	call	fprintf@PLT
.L1054:
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	addq	$1, %r13
	leaq	.LC143(%rip), %rdi
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
	jb	.L1056
	movl	76(%rsp), %r14d
	leaq	.LC33(%rip), %r13
	testl	%ebx, %ebx
	jle	.L1239
.L1042:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1058:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1058
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	movl	8(%rsp), %r12d
	testl	%r14d, %r14d
	jle	.L1211
	.p2align 4
	.p2align 3
.L1059:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jg	.L1059
.L1211:
	movl	32(%rsp), %edx
	leaq	.LC144(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	.p2align 4
	.p2align 3
.L1063:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1063
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	xorl	%ebx, %ebx
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	jle	.L1065
	.p2align 4
	.p2align 3
.L1066:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1066
.L1065:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC124(%rip), %rdi
	call	fwrite@PLT
.L940:
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
.L956:
	.cfi_restore_state
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	leaq	.LC33(%rip), %r13
	testl	%ebp, %ebp
	jle	.L1235
	.p2align 4
	.p2align 3
.L980:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L980
.L1235:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC107(%rip), %rdi
.L1234:
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
.L955:
	.cfi_restore_state
	movl	8(%rsp), %r9d
	movl	8(%rsp), %r14d
	xorl	%r12d, %r12d
	leaq	.LC33(%rip), %r13
	testl	%r9d, %r9d
	jle	.L1240
	.p2align 4
	.p2align 3
.L978:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r14d
	jne	.L978
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L983
.L982:
	movl	8(%rsp), %edi
	xorl	%r13d, %r13d
	addl	$1, %edi
	movl	%edi, 40(%rsp)
.L990:
	movq	16(%rbx), %rdx
	movq	(%rdx,%r13,8), %r12
	testl	%ebp, %ebp
	je	.L1093
	subq	$1, %rax
	xorl	%ecx, %ecx
	cmpq	%r13, %rax
	je	.L1241
.L985:
	movq	16(%rsp), %r8
	movl	40(%rsp), %edx
	movq	%r12, %rsi
	movq	%r15, %rdi
	call	emit_stmt
.L988:
	movq	24(%rbx), %rax
	addq	$1, %r13
	cmpq	%rax, %r13
	jb	.L990
	movl	8(%rsp), %r8d
	leaq	.LC33(%rip), %r13
	testl	%r8d, %r8d
	jle	.L992
.L983:
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L993:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L993
.L992:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC124(%rip), %rdi
	jmp	.L1234
	.p2align 4,,10
	.p2align 3
.L954:
	xorl	%ecx, %ecx
	cmpq	$0, 24(%rbx)
	leaq	.LC33(%rip), %rbp
	je	.L940
	movq	%rbx, 24(%rsp)
	movl	8(%rsp), %r12d
	movq	%rcx, %r14
	.p2align 4
	.p2align 3
.L977:
	movq	24(%rsp), %rax
	movq	16(%rax), %rax
	movq	(%rax,%r14,8), %rbx
	movq	(%rbx), %rdi
	call	get_mangled_name
	cmpq	$0, 8(%rbx)
	movq	%rax, 8(%rsp)
	je	.L1242
	testl	%r12d, %r12d
	jle	.L997
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L998:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%r13d, %r12d
	jne	.L998
	movq	8(%rsp), %rdx
	leaq	.LC125(%rip), %rsi
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
	leaq	.LC126(%rip), %rdi
	call	fwrite@PLT
	.p2align 4
	.p2align 3
.L999:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L999
	movq	8(%rsp), %rdx
	xorl	%eax, %eax
	leaq	.LC127(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L1243
.L1000:
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1003:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L1003
.L1002:
	movq	8(%rsp), %rcx
	leaq	.LC129(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	%rcx, %r8
	movq	%rcx, %rdx
	call	fprintf@PLT
.L1004:
	movq	24(%rsp), %rax
	addq	$1, %r14
	cmpq	24(%rax), %r14
	jb	.L977
	jmp	.L940
	.p2align 4,,10
	.p2align 3
.L1243:
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1001:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L1001
	movq	8(%rsp), %rcx
	leaq	.LC128(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	%rcx, %rdx
	call	fprintf@PLT
	jmp	.L1000
	.p2align 4,,10
	.p2align 3
.L953:
	movl	8(%rsp), %eax
	xorl	%r14d, %r14d
	leaq	.LC33(%rip), %r13
	testl	%eax, %eax
	jle	.L1010
	.p2align 4
	.p2align 3
.L963:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%r14d, 8(%rsp)
	jne	.L963
.L1010:
	movq	%r15, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC116(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	testl	%ebp, %ebp
	jne	.L964
.L965:
	movq	24(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L1011
	cmpl	$1, (%rsi)
	movl	8(%rsp), %edx
	je	.L1012
.L1011:
	movl	8(%rsp), %eax
	leal	1(%rax), %edx
.L1012:
	movq	16(%rsp), %r8
	movl	%ebp, %ecx
	movq	%r15, %rdi
	call	emit_stmt
	cmpq	$0, 32(%rbx)
	je	.L940
	movl	8(%rsp), %ecx
	xorl	%ebp, %ebp
	leaq	.LC33(%rip), %r13
	testl	%ecx, %ecx
	jle	.L1016
	.p2align 4
	.p2align 3
.L1013:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, 8(%rsp)
	jne	.L1013
.L1016:
	movq	%r15, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC131(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L961
	jmp	.L962
	.p2align 4,,10
	.p2align 3
.L952:
	movl	8(%rsp), %eax
	xorl	%ebp, %ebp
	leaq	.LC33(%rip), %r13
	testl	%eax, %eax
	jle	.L1018
	.p2align 4
	.p2align 3
.L960:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, 8(%rsp)
	jne	.L960
.L1018:
	movq	%r15, %rcx
	movl	$7, %edx
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
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L962
.L961:
	cmpl	$1, (%rbx)
	je	.L1017
.L962:
	addl	$1, 8(%rsp)
.L1017:
	xorl	%ebp, %ebp
	jmp	.L941
	.p2align 4,,10
	.p2align 3
.L951:
	movl	8(%rsp), %r10d
	movl	8(%rsp), %r12d
	xorl	%ebp, %ebp
	leaq	.LC33(%rip), %r13
	testl	%r10d, %r10d
	jle	.L1019
	.p2align 4
	.p2align 3
.L974:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L974
.L1019:
	movq	%r15, %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC121(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%rbx)
	je	.L1235
	movq	%r15, %rsi
	movl	$32, %edi
	call	fputc@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	jmp	.L1235
	.p2align 4,,10
	.p2align 3
.L949:
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	leaq	.LC33(%rip), %r13
	testl	%ebp, %ebp
	jle	.L1021
	movl	8(%rsp), %ebp
	.p2align 4
	.p2align 3
.L970:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L970
.L1021:
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	jmp	.L1234
	.p2align 4,,10
	.p2align 3
.L950:
	movl	8(%rsp), %r11d
	movl	8(%rsp), %r14d
	xorl	%r12d, %r12d
	leaq	.LC33(%rip), %r13
	testl	%r11d, %r11d
	jle	.L1020
	.p2align 4
	.p2align 3
.L971:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r14d
	jne	.L971
.L1020:
	testl	%ebp, %ebp
	jne	.L1244
.L973:
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	jmp	.L1235
	.p2align 4,,10
	.p2align 3
.L947:
	movl	8(%rsp), %r14d
	movl	8(%rsp), %r12d
	xorl	%ebp, %ebp
	leaq	.LC33(%rip), %r13
	testl	%r14d, %r14d
	jle	.L1023
	.p2align 4
	.p2align 3
.L966:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L966
.L1023:
	movq	%r15, %rcx
	movl	$8, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC117(%rip), %rdi
	leaq	.LC132(%rip), %r13
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	%r15, %rdi
	movq	16(%rsp), %rdx
	leaq	.LC33(%rip), %rbp
	call	emit_expr
	movq	%r15, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	movl	8(%rsp), %r14d
	je	.L968
	.p2align 4
	.p2align 3
.L967:
	xorl	%ebx, %ebx
	testl	%r14d, %r14d
	js	.L1025
	.p2align 4
	.p2align 3
.L1024:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r14d
	jge	.L1024
.L1025:
	addq	$1, %r12
	xorl	%eax, %eax
	movq	%r13, %rsi
	movq	%r15, %rdi
	movq	%r12, %rcx
	movq	%r12, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %r12
	jb	.L967
.L968:
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	js	.L1026
	xorl	%ebx, %ebx
	leaq	.LC33(%rip), %r13
	.p2align 4
	.p2align 3
.L1027:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jge	.L1027
	movq	%r15, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC133(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	je	.L992
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1029:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1029
	jmp	.L992
	.p2align 4,,10
	.p2align 3
.L948:
	movl	8(%rsp), %r12d
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	leaq	.LC33(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1022
	.p2align 4
	.p2align 3
.L969:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L969
.L1022:
	movq	%r15, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC119(%rip), %rdi
	jmp	.L1234
	.p2align 4,,10
	.p2align 3
.L946:
	movl	8(%rsp), %eax
	xorl	%ebp, %ebp
	leaq	.LC33(%rip), %r13
	testl	%eax, %eax
	jle	.L1245
	.p2align 4
	.p2align 3
.L957:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, 8(%rsp)
	jne	.L957
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 32(%rsp)
	testq	%rbp, %rbp
	je	.L1246
.L958:
	movq	function_labels(%rip), %r14
	xorl	%r13d, %r13d
	jmp	.L1071
	.p2align 4,,10
	.p2align 3
.L1069:
	addq	$1, %r13
	cmpq	%rbp, %r13
	je	.L959
.L1071:
	movq	(%r14,%r13,8), %rsi
	movq	32(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1069
	leal	1(%r13), %edx
.L1070:
	leaq	.LC145(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	8(%rsp), %eax
	leaq	.LC33(%rip), %r13
	leal	1(%rax), %ebp
	testl	%ebp, %ebp
	jle	.L1074
.L1072:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1073:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, 8(%rsp)
	jne	.L1073
.L1074:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC107(%rip), %rdi
	call	fwrite@PLT
	movl	%ebp, 8(%rsp)
	movq	24(%rbx), %rbx
	xorl	%ebp, %ebp
	jmp	.L941
	.p2align 4,,10
	.p2align 3
.L1103:
	movq	$0, 24(%rsp)
	jmp	.L1045
	.p2align 4,,10
	.p2align 3
.L1238:
	movl	16(%r14), %eax
	testl	%eax, %eax
	je	.L1055
	movq	32(%r14), %rcx
	movq	%rsi, %rdx
	movq	%r15, %rdi
	xorl	%eax, %eax
	leaq	.LC141(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1054
	.p2align 4,,10
	.p2align 3
.L1242:
	xorl	%ebx, %ebx
	testl	%r12d, %r12d
	jle	.L1247
	.p2align 4
	.p2align 3
.L995:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L995
	movq	8(%rsp), %rdx
	xorl	%eax, %eax
	leaq	.LC130(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L1004
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1008:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L1008
.L1006:
	movq	8(%rsp), %rcx
	leaq	.LC128(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	%rcx, %rdx
	call	fprintf@PLT
	jmp	.L1004
.L1241:
	cmpl	$6, (%r12)
	movl	%ebp, %ecx
	jne	.L985
	movl	g_no_line(%rip), %edi
	testl	%edi, %edi
	jne	.L986
	cmpb	$0, 24(%rsp)
	je	.L986
	movl	4(%r12), %edx
	movq	16(%rsp), %rcx
	movq	%r15, %rdi
	xorl	%eax, %eax
	leaq	.LC34(%rip), %rsi
	call	fprintf@PLT
.L986:
	movl	8(%rsp), %esi
	leaq	.LC33(%rip), %rax
	xorl	%r14d, %r14d
	movq	%rax, 32(%rsp)
	testl	%esi, %esi
	js	.L989
	.p2align 4
	.p2align 3
.L987:
	movq	32(%rsp), %rdi
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r14d
	call	fwrite@PLT
	cmpl	%r14d, 8(%rsp)
	jge	.L987
.L989:
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC123(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r12), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC107(%rip), %rdi
	call	fwrite@PLT
	jmp	.L988
	.p2align 4,,10
	.p2align 3
.L1055:
	movq	%rsi, %rdx
	movq	%r15, %rdi
	leaq	.LC142(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1054
	.p2align 4,,10
	.p2align 3
.L1093:
	xorl	%ecx, %ecx
	jmp	.L985
	.p2align 4,,10
	.p2align 3
.L1053:
	cmpl	$27, %eax
	leaq	.LC113(%rip), %rdx
	leaq	.LC112(%rip), %rax
	cmove	%rax, %rdx
	jmp	.L1052
.L997:
	movq	8(%rsp), %r13
	leaq	.LC125(%rip), %rsi
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
	leaq	.LC126(%rip), %rdi
	call	fwrite@PLT
	xorl	%eax, %eax
	movq	%r13, %rdx
	movq	%r15, %rdi
	leaq	.LC127(%rip), %rsi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L1002
	movq	8(%rsp), %rcx
	leaq	.LC128(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	%rcx, %rdx
	call	fprintf@PLT
	jmp	.L1002
.L964:
	xorl	%ebp, %ebp
	cmpq	$0, 32(%rbx)
	sete	%bpl
	jmp	.L965
.L1239:
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	xorl	%eax, %eax
	movq	%r15, %rdi
	call	fprintf@PLT
	testl	%r14d, %r14d
	jle	.L1233
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
.L1233:
	movl	32(%rsp), %edx
	movq	%r15, %rdi
	leaq	.LC144(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1065
.L1245:
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 32(%rsp)
	testq	%rbp, %rbp
	jne	.L958
.L959:
	xorl	%edx, %edx
	jmp	.L1070
.L1244:
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC123(%rip), %rdi
	call	fwrite@PLT
	jmp	.L973
.L1247:
	movq	8(%rsp), %rdx
	xorl	%eax, %eax
	leaq	.LC130(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L1004
	jmp	.L1006
.L1026:
	movq	%r15, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC133(%rip), %rdi
	call	fwrite@PLT
	jmp	.L992
.L1240:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	jne	.L982
	jmp	.L992
.L1237:
	movq	%r15, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC135(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r14d
	testl	%eax, %eax
	je	.L1034
	movq	%r15, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC136(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	leaq	.LC107(%rip), %rax
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ebp
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC137(%rip), %rdx
	movl	$64, %esi
	movl	%ebp, %ecx
	call	snprintf@PLT
	movl	%ebp, %edx
	leaq	.LC138(%rip), %rsi
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
	leaq	.LC139(%rip), %rax
	movq	%rax, %rsi
	movq	%rax, 64(%rsp)
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%eax, %eax
	movl	%ebp, %edx
	leaq	.LC146(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r12)
	leal	2(%rax), %ebx
	jne	.L1078
	cmpl	$1, %ebx
	je	.L1042
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1233
	.p2align 4,,10
	.p2align 3
.L1246:
	xorl	%edx, %edx
	leaq	.LC145(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %ebp
	jmp	.L1072
	.cfi_endproc
.LFE54:
	.size	emit_stmt, .-emit_stmt
	.section	.rodata.str1.1
.LC147:
	.string	"%s:\n"
	.text
	.p2align 4
	.type	emit_stmt_switchctx, @function
emit_stmt_switchctx:
.LFB44:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.L1253(%rip), %r15
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
	je	.L1248
.L1249:
	cmpl	$13, 0(%r13)
	ja	.L1251
	movl	0(%r13), %eax
	movslq	(%r15,%rax,4), %rax
	addq	%r15, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1253:
	.long	.L1251-.L1253
	.long	.L1257-.L1253
	.long	.L1251-.L1253
	.long	.L1256-.L1253
	.long	.L1255-.L1253
	.long	.L1251-.L1253
	.long	.L1251-.L1253
	.long	.L1251-.L1253
	.long	.L1251-.L1253
	.long	.L1251-.L1253
	.long	.L1251-.L1253
	.long	.L1254-.L1253
	.long	.L1251-.L1253
	.long	.L1252-.L1253
	.text
	.p2align 4,,10
	.p2align 3
.L1251:
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
.L1252:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1301
	xorl	%eax, %eax
	jmp	.L1271
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1270:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1301
.L1271:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%r13, (%rdx)
	jne	.L1270
	movq	8(%rdx), %r14
.L1269:
	xorl	%r13d, %r13d
	leaq	.LC33(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1335
	.p2align 4
	.p2align 3
.L1272:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1272
	movq	%r14, %rdx
	leaq	.LC147(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1275:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jle	.L1275
.L1274:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC107(%rip), %rdi
	jmp	.L1334
	.p2align 4,,10
	.p2align 3
.L1254:
	xorl	%r14d, %r14d
	leaq	.LC33(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1336
	.p2align 4
	.p2align 3
.L1258:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1258
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L1337
.L1259:
	movq	function_labels(%rip), %r14
	xorl	%r12d, %r12d
	jmp	.L1279
	.p2align 4,,10
	.p2align 3
.L1277:
	addq	$1, %r12
	cmpq	%r12, 24(%rsp)
	je	.L1260
.L1279:
	movq	(%r14,%r12,8), %rsi
	movq	16(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1277
	leal	1(%r12), %edx
.L1278:
	leaq	.LC145(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	leaq	.LC33(%rip), %r12
	movl	%eax, 16(%rsp)
	testl	%eax, %eax
	jle	.L1338
.L1280:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1282:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, %ebp
	jne	.L1282
	movl	16(%rsp), %ebp
.L1283:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC107(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	jne	.L1249
	jmp	.L1248
	.p2align 4,,10
	.p2align 3
.L1255:
	xorl	%r14d, %r14d
	leaq	.LC33(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1295
	.p2align 4
	.p2align 3
.L1261:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1261
.L1295:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC114(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	je	.L1248
.L1262:
	xorl	%eax, %eax
	cmpl	$1, 0(%r13)
	setne	%al
	addl	%eax, %ebp
	jmp	.L1249
	.p2align 4,,10
	.p2align 3
.L1256:
	xorl	%r14d, %r14d
	leaq	.LC33(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1290
	.p2align 4
	.p2align 3
.L1264:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1264
.L1290:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC116(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %rsi
	testq	%rsi, %rsi
	je	.L1266
	cmpl	$1, (%rsi)
	movl	%ebp, %edx
	je	.L1291
.L1266:
	leal	1(%rbp), %edx
.L1291:
	movq	(%rsp), %r8
	movq	8(%rsp), %rcx
	movq	%rbx, %rdi
	call	emit_stmt_switchctx
	cmpq	$0, 32(%r13)
	je	.L1248
	xorl	%r14d, %r14d
	leaq	.LC33(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1294
	.p2align 4
	.p2align 3
.L1292:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1292
.L1294:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC131(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r13), %r13
	testq	%r13, %r13
	jne	.L1262
.L1248:
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
.L1257:
	.cfi_restore_state
	xorl	%r15d, %r15d
	leaq	.LC33(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1339
	.p2align 4
	.p2align 3
.L1267:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebp, %r15d
	jne	.L1267
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	je	.L1285
.L1284:
	leal	1(%rbp), %r12d
	xorl	%r15d, %r15d
.L1287:
	movq	16(%r13), %rax
	movq	(%rsp), %r8
	movl	%r12d, %edx
	movq	%rbx, %rdi
	movq	8(%rsp), %rcx
	movq	(%rax,%r15,8), %rsi
	addq	$1, %r15
	call	emit_stmt_switchctx
	cmpq	24(%r13), %r15
	jb	.L1287
	leaq	.LC33(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1286
.L1285:
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1289:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1289
.L1286:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC124(%rip), %rdi
.L1334:
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
.L1301:
	.cfi_restore_state
	xorl	%r14d, %r14d
	jmp	.L1269
	.p2align 4,,10
	.p2align 3
.L1336:
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	jne	.L1259
	.p2align 4
	.p2align 3
.L1260:
	xorl	%edx, %edx
	jmp	.L1278
.L1337:
	xorl	%edx, %edx
	leaq	.LC145(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	movl	%eax, 16(%rsp)
	jmp	.L1280
	.p2align 4,,10
	.p2align 3
.L1335:
	xorl	%eax, %eax
	movq	%r14, %rdx
	leaq	.LC147(%rip), %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	testl	%ebp, %ebp
	jne	.L1274
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	jmp	.L1274
	.p2align 4,,10
	.p2align 3
.L1338:
	movl	%eax, %ebp
	jmp	.L1283
	.p2align 4,,10
	.p2align 3
.L1339:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	jne	.L1284
	jmp	.L1286
	.cfi_endproc
.LFE44:
	.size	emit_stmt_switchctx, .-emit_stmt_switchctx
	.section	.rodata.str1.1
.LC148:
	.string	"{\n    B_FRAME;\n"
	.section	.rodata.str1.8
	.align 8
.LC149:
	.string	"    (void)B_LOCAL_PTR_N(&%s, sizeof(%s));\n"
	.align 8
.LC150:
	.string	"    static word __b_label_value_%zu = %zu;\n"
	.text
	.p2align 4
	.type	emit_function_body, @function
emit_function_body:
.LFB55:
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
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L1348
.L1341:
	cmpq	$0, 8+function_labels(%rip)
	je	.L1343
	xorl	%ebx, %ebx
	leaq	.LC150(%rip), %r14
	.p2align 4
	.p2align 3
.L1344:
	addq	$1, %rbx
	xorl	%eax, %eax
	movq	%r14, %rsi
	movq	%rbp, %rdi
	movq	%rbx, %rcx
	movq	%rbx, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %rbx
	jb	.L1344
.L1343:
	movq	32(%r12), %rsi
	movq	%r13, %r8
	movq	%rbp, %rdi
	movl	$1, %ecx
	movl	$1, %edx
	call	emit_stmt
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC124(%rip), %rdi
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
.L1348:
	.cfi_restore_state
	cmpq	$0, 16(%r12)
	je	.L1341
	xorl	%r14d, %r14d
	leaq	.LC149(%rip), %rbx
	.p2align 4
	.p2align 3
.L1342:
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
	jb	.L1342
	jmp	.L1341
	.cfi_endproc
.LFE55:
	.size	emit_function_body, .-emit_function_body
	.section	.rodata.str1.1
.LC151:
	.string	"#define BCC_USE_CURSES 1\n"
	.section	.rodata.str1.8
	.align 8
.LC152:
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
.LC153:
	.string	"#define B_BYTEPTR %d\n"
.LC154:
	.string	"#define WORD_BITS %d\n"
	.section	.rodata.str1.8
	.align 8
.LC155:
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
.LC156:
	.string	"%s/btarget.h"
	.section	.rodata.str1.8
	.align 8
.LC157:
	.string	"#define B_TARGET_DEFINE\n#define B_TARGET_STORAGE __attribute__((common))\n"
	.align 8
.LC158:
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
	.ascii	"ar(word x){\n    __b_sync_wr();\n    unsigned char bytes[2] "
	.ascii	"= {(unsigned char)((uword)x >> 8), (unsigned char)x};\n    s"
	.ascii	"ize_t start = bytes[0] ? 0 : 1;\n    (void)write(wr_fd, byte"
	.ascii	"s + start, 2 - start);\n    return x;\n}\nstatic word b_getc"
	.ascii	"har(void){ __b_sync_rd(); unsigned char c; ssize_t n = read("
	.ascii	"rd_fd, &c, 1); if (n == 1) return (word)c; if (rd_fd != 0) {"
	.ascii	" close(rd_fd); rd_fd = 0; rd_unit = -1; return b_getchar(); "
	.ascii	"} return (word)004; }\nstatic word b_exit(word code){ exit(("
	.ascii	"int)code); return 0; }\nstatic word b_abort(void){ abort(); "
	.ascii	"return 0; }\nstatic word b_free(word p){ void *host = B_CPTR"
	.ascii	"(p); B_FORGET(host); free(host); return 0; }\n\n/* Sign-exte"
	.ascii	"nd 16-bit value to full word size. Used by 16-bit B programs"
	.ascii	" on 64-bit hosts. */\nstatic word sx64(word x){\n    return "
	.ascii	"(word)(int16_t)(x & 0xFFFF);\n}\n\n/* Command line argument "
	.ascii	"support */\nint __b_argc __attribute__((common));\nchar **__"
	.ascii	"b_argv __attribute__((common));\n\n/* argv strings converted"
	.ascii	" to B strings (packed words, 004 terminator) */\nword *__b_a"
	.ascii	"rgvb __attribute__((common));\nword b_argv_vector __attribut"
	.ascii	"e__((common));\n\nstatic void __b_setargs(int argc, char **a"
	.ascii	"rgv);\nstatic word b_argc(void);\nstatic word b_argv(word i)"
	.ascii	";\n\n/* Command line r"
	.ascii	"eread buffer */\nstatic word b_reread(void);\n\n/* Helper fu"
	.ascii	"nctions for complex lvalue operations (avoid GNU C extension"
	.ascii	"s) */\n/* All use safe W* macros to avoid host-C undefined b"
	.ascii	"ehavior */\nstatic word b_preinc(word *p) { return (*p = WAD"
	.ascii	"D(*p, 1)); }\nstatic word b_predec(word *p) { return (*p = W"
	.ascii	"SUB(*p, 1)); }\nstatic word b_postinc(word *p) { word old = "
	.ascii	"WVAL(*p); *p = WADD(*p, 1); return old; }\nstatic word b_pos"
	.ascii	"tdec(word *p) { word old = WVAL(*p); *p = WSUB(*p, 1); retur"
	.ascii	"n old; }\nstatic word b_add_assign(word *p, word v) { return"
	.ascii	" (*p = WADD(*p, v)); }\nstatic word b_sub_assign(word *p, wo"
	.ascii	"rd v) { return (*p = WSUB(*p, v)); }\nstatic word b_mul_assi"
	.ascii	"gn(word *p, word v) { return (*p = WMUL(*p, v)); }\nstatic w"
	.ascii	"ord b_div_assign(word *p, word v) { return (*p = WDIV(*p, v)"
	.ascii	"); }\nstatic word b_mod_assign(word *p, word v) { return (*p"
	.ascii	" = WMOD(*p, v)); }\nstatic word b_lsh_assign(word *p, word v"
	.ascii	") { return (*p = WSHL(*p, v)); }\nstatic word b_rsh_assign(w"
	.ascii	"ord *p, word v) { return (*p = WSHR(*p, v)); }\nstatic word "
	.ascii	"b_and_assign(word *p, word v) { return (*p = WAND(*p, v)); }"
	.ascii	"\nstatic word b_or_assign(word *p, word v) { return (*p = WO"
	.ascii	"R(*p, v)); }\nstatic word b_xor_assign(word *p, word v) { re"
	.ascii	"turn (*p = WXOR(*p, v)); }\n\nstatic word b_alloc(word nword"
	.ascii	"s){\n    size_t bytes = (size_t)nwords * sizeof(word);\n    "
	.ascii	"void *p = malloc(bytes);\n    if (!p) { fprintf(stderr, \"al"
	.ascii	"loc: out of memory\\n\"); exit(1); }\n    return B_PTR_N(p, "
	.ascii	"bytes);\n}\n\n/* B library functions - compatible with Thomp"
	.ascii	"son's /etc/libb.a */\n/* String manipulation functions */\ns"
	.ascii	"tatic inline word b_load(word addr){ return B_DEREF(addr); }"
	.ascii	"\nstatic inline void b_store(word addr, word v){ B_DEREF(add"
	.ascii	"r) = WVAL(v);\n}\n\n/* B string access - byte packing within"
	.ascii	" words.\n *\n * In B_BYTEPTR=0 mode, bytes are packed into w"
	.ascii	"ords with byte 0 at the LSB.\n * This matches PDP-11 (little"
	.ascii	"-endian) conventions. The shift-based approach\n * operates "
	.ascii	"on word VALUES (not memory layout), making it consistent acr"
	.ascii	"oss\n * architectures: char(s,0) always returns the least-si"
	.ascii	"g"
	.ascii	"nificant byte of the\n * word at address s, regardless of ho"
	.ascii	"st endianness.\n *\n * Note: This only works correctly when "
	.ascii	"ALL byte access goes through char()/lchar().\n * Mixing dire"
	.ascii	"ct memory access (like C's *(char*)ptr) with B word operatio"
	.ascii	"ns will\n * give different results on big-endian hosts.\n */"
	.ascii	"\nstatic word b_char(word s, word i){\n#if B_BYTEPTR && WORD"
	.ascii	"_BITS != 16\n    const unsigned char *p = (const unsigned ch"
	.ascii	"ar*)B_CPTR(s);\n    return (word)p[(size_t)i];\n#else\n    c"
	.ascii	"onst uword W = (uword)B_WORD_BYTES;\n    uword wi = (uword)i"
	.ascii	" / W;\n    uword bi = (uword)i % W;\n    uword w  = (uword)B"
	.ascii	"_INDEX(s, wi);\n    return (word)((w >> (bi * 8)) & 0xFF);\n"
	.ascii	"#endif\n}\n\nstatic word b_lchar(word s, word i, word c){\n#"
	.ascii	"if B_BYTEPTR && WORD_BITS != 16\n    unsigned char *p = (uns"
	.ascii	"igned char*)B_CPTR(s);\n    p[(size_t)i] = (unsigned char)(c"
	.ascii	" & 0xFF);\n    return c;\n#else\n    const uword W = (uword)"
	.ascii	"B_WORD_BYTES;\n    uword wi = (uword)i / W;\n    uword bi = "
	.ascii	"(uword)i % W;\n\n    word addr = B_ADDR(B_INDEX(s, wi));\n  "
	.ascii	"  uword w   = (uword)b_load(addr);\n\n    uword mask = (uwor"
	.ascii	"d)0xFF << (bi * 8);\n    w = (w & ~mask) | (((uword)c & 0xFF"
	.ascii	") << (bi * 8));\n\n    b_store(addr, (word)w);\n    return c"
	.ascii	";\n#endif\n}\n\n/* Command line argument support implementat"
	.ascii	"ion */\nstatic word __b_pack_cstr(const char *s){\n    size_"
	.ascii	"t n = strlen(s);                 /* bytes, excluding NUL */\n"
	.ascii	"    size_t W = B_WORD_BYTES;              /* bytes per word "
	.ascii	"*/\n    size_t total = n + 1;                 /* +1 for 004 "
	.ascii	"terminator */\n    size_t words = (total + W - 1) / W;\n\n  "
	.ascii	"  word bp = b_alloc((word)words);       /* B pointer to word"
	.ascii	" storage */\n\n    /* write bytes into the B string using lc"
	.ascii	"har (handles packing for B_BYTEPTR=0) */\n    for (size_t i "
	.ascii	"= 0; i < n; i++){\n        b_lchar(bp, (word)i, (word)(unsig"
	.ascii	"ned char)s[i]);\n    }\n    b_lchar(bp, (word)n, (word)004);"
	.ascii	"\n    return bp;\n}\n\nstatic void __b_bstr_to_cstr(word s, "
	.ascii	"char *buf, size_t max){\n    size_t i = 0;\n    while (i + 1"
	.ascii	" < max) {\n        word ch = b_char(s, (word)i);\n        if"
	.ascii	" (ch == 004 || ch == "
	.ascii	"0) break;\n        buf[i++] = (char)(ch & 0xFF);\n    }\n   "
	.ascii	" buf[i] = 0;\n}\n\n/* Convert a B string (004-terminated) in"
	.ascii	"to a temporary NUL-terminated C string */\nstatic const char"
	.ascii	" *__b_cstr(word s){\n    static char *slots[4];\n    static "
	.ascii	"size_t caps[4];\n    static int next = 0;\n\n    if (s == 0)"
	.ascii	" return \"\";\n\n    size_t len = 0;\n    for (;; len++) {\n"
	.ascii	"        word ch = b_char(s, (word)len);\n        if (ch == 0"
	.ascii	"04 || ch == 0) break;\n    }\n\n    int idx = next;\n    nex"
	.ascii	"t = (next + 1) & 3; /* simple ring buffer to survive multipl"
	.ascii	"e args */\n\n    size_t need = len + 1;\n    if (need > caps"
	.ascii	"[idx]) {\n        size_t ncap = need < 64 ? 64 : need;\n    "
	.ascii	"    char *nb = (char*)realloc(slots[idx], ncap);\n        if"
	.ascii	" (!nb) { fprintf(stderr, \"cstr: out of memory\\n\"); exit(1"
	.ascii	"); }\n        slots[idx] = nb;\n        caps[idx] = ncap;\n "
	.ascii	"   }\n\n    for (size_t i = 0; i < len; i++) slots[idx][i] ="
	.ascii	" (char)(b_char(s, (word)i) & 0xFF);\n    slots[idx][len] = 0"
	.ascii	";\n    return slots[idx];\n}\n\n/* Duplicate a B string into"
	.ascii	" a freshly allocated C string */\nstatic char *__b_dup_bstr("
	.ascii	"word s){\n    size_t cap = 64;\n    char *buf = (char*)mallo"
	.ascii	"c(cap);\n    if (!buf) { fprintf(stderr, \"system: out of me"
	.ascii	"mory\\n\"); exit(1); }\n\n    size_t i = 0;\n    for (;;) {\n"
	.ascii	"        word ch = b_char(s, (word)i);\n        if (ch == 004"
	.ascii	" || ch == 0) break;\n        if (i + 1 >= cap) {\n          "
	.ascii	"  size_t ncap = cap * 2;\n            char *nbuf = (char*)re"
	.ascii	"alloc(buf, ncap);\n            if (!nbuf) { free(buf); fprin"
	.ascii	"tf(stderr, \"system: out of memory\\n\"); exit(1); }\n      "
	.ascii	"      buf = nbuf;\n            cap = ncap;\n        }\n     "
	.ascii	"   buf[i++] = (char)(ch & 0xFF);\n    }\n    buf[i] = 0;\n  "
	.ascii	"  return buf;\n}\n\nstatic void __b_setargs(int argc, char *"
	.ascii	"*argv){\n    __b_argc = argc;\n    __b_argv = argv;\n\n    _"
	.ascii	"_b_argvb = (word*)malloc(sizeof(word) * ((size_t)argc + 1));"
	.ascii	"\n    if (!__b_argvb) { fprintf(stderr, \"argv: out of memor"
	.ascii	"y\\n\"); exit(1); }\n\n    word *vector = (word*)malloc(size"
	.ascii	"of(word) * ((size_t)argc + 1));\n    if (!vector) { fprintf("
	.ascii	"stderr, \"argv: out of memory\\n\"); exit(1)"
	.ascii	"; }\n    vector[0] = WVAL(argc);\n    for (int i = 0; i < ar"
	.ascii	"gc; i++){\n        __b_argvb[i] = __b_pack_cstr(argv[i]);\n "
	.ascii	"       vector[i+1] = __b_pack_cstr(argv[i]);\n        b_lcha"
	.ascii	"r(vector[i+1], (word)strlen(argv[i]), 0);\n    }\n    b_argv"
	.ascii	"_vector = B_PTR_N(vector, sizeof(word) * ((size_t)argc + 1))"
	.ascii	";\n}\nstatic word __b_argvalues(void) {\n    return __b_argc"
	.ascii	" ? B_PTR_N(__b_argvb, sizeof(word) * (size_t)__b_argc) : 0;\n"
	.ascii	"}\n\nstatic word b_argc(void) { return (word)__b_argc; }\n\n"
	.ascii	"static word b_argv(word i) {\n    int idx = (int)i;\n    if "
	.ascii	"(idx < 0 || idx >= __b_argc) return 0;\n    return __b_argvb"
	.ascii	"[idx];\n}\n\nstatic word b_reread(void) {\n    /* If no args"
	.ascii	", nothing to reread */\n    if (__b_argc <= 1) {\n        re"
	.ascii	"turn 0;\n    }\n\n    /* Compute total length of joined argv"
	.ascii	"[0..] with spaces + newline */\n    size_t total = 1; /* for"
	.ascii	" trailing newline */\n    for (int i = 0; i < __b_argc; i++)"
	.ascii	" {\n        total += strlen(__b_argv[i]);\n        if (i + 1"
	.ascii	" < __b_argc) total += 1; /* space */\n    }\n    \n    char "
	.ascii	"*buf = (char*)malloc(total + 1);\n    if (!buf) { fprintf(st"
	.ascii	"derr, \"reread: out of memory\\n\"); exit(1); }\n    \n    s"
	.ascii	"ize_t pos = 0;\n    for (int i = 0; i < __b_argc; i++) {\n  "
	.ascii	"      size_t len = strlen(__b_argv[i]);\n        memcpy(buf "
	.ascii	"+ pos, __b_argv[i], len);\n        pos += len;\n        if ("
	.ascii	"i + 1 < __b_argc) buf[pos++] = ' ';\n    }\n    buf[pos++] ="
	.ascii	" '\\n';\n    buf[pos] = '\\0';\n    \n    int p[2];\n    if "
	.ascii	"(pipe(p) != 0) { free(buf); fprintf(stderr, \"reread: pipe f"
	.ascii	"ailed\\n\"); exit(1); }\n    ssize_t wn = write(p[1], buf, p"
	.ascii	"os);\n    (void)wn;\n    close(p[1]);\n    free(buf);\n    \n"
	.ascii	"    /* Close previous rd fd if it wasn't the terminal */\n  "
	.ascii	"  if (rd_fd != 0 && rd_fd != p[0]) close(rd_fd);\n    rd_fd "
	.ascii	"= p[0];\n    rd_unit = (word)0;\n    __b_sync_rd();\n    ret"
	.ascii	"urn 0;\n}\n\n/* I/O functions */\nstatic word b_getchr(void)"
	.ascii	" {\n    __b_sync_rd();\n    unsigned char c;\n    ssize_t n "
	.ascii	"= read(rd_fd, &c, 1);\n    if (n == 1) return (word)c;\n    "
	.ascii	"if (rd_fd != 0) {\n        close(rd_fd);\n        rd_fd = 0;"
	.ascii	"\n        rd_unit = -1;\n        retur"
	.ascii	"n b_getchr();\n    }\n    return (word)004; /* Return *e on "
	.ascii	"EOF */\n}\nstatic word b_putchr(word w) {\n    __b_sync_wr()"
	.ascii	";\n    unsigned char c = (unsigned char)(w & 0xFF);\n    (vo"
	.ascii	"id)write(wr_fd, &c, 1);\n    return w;\n}\nstatic word b_put"
	.ascii	"str(word s) {\n    __b_sync_wr();\n    word i = 0;\n    for "
	.ascii	"(;;) {\n        word ch = b_char(s, i++);\n        if (ch =="
	.ascii	" 004 || ch == 0) break;\n        b_putchar(ch);\n    }\n    "
	.ascii	"return s;\n}\nstatic word b_getstr(word buf) {\n    __b_sync"
	.ascii	"_rd();\n    size_t i = 0;\n    unsigned char c;\n    for (;;"
	.ascii	") {\n        ssize_t n = read(rd_fd, &c, 1);\n        if (n "
	.ascii	"== 1 && c != '\\n' && c != '\\r') {\n            b_lchar(buf"
	.ascii	", (word)i, (word)c);\n            i++;\n            continue"
	.ascii	";\n        }\n        if (n == 1) break; /* newline */\n    "
	.ascii	"    if (rd_fd != 0) {\n            close(rd_fd);\n          "
	.ascii	"  rd_fd = 0;\n            rd_unit = -1;\n            continu"
	.ascii	"e; /* retry on terminal */\n        }\n        break; /* EOF"
	.ascii	" */\n    }\n    b_lchar(buf, (word)i, (word)004);\n    retur"
	.ascii	"n buf;\n}\nstatic word b_flush(void){\n    __b_sync_wr();\n "
	.ascii	"   if (wr_fd == 1) {\n        fflush(stdout);\n    } else {\n"
	.ascii	"        fsync(wr_fd);\n    }\n    return 0;\n}\n\n#include <"
	.ascii	"stdarg.h>\n\n/* Print number in specified base (from B manua"
	.ascii	"l) */\nstatic void b_printn_u(word n, word base) {\n    // r"
	.ascii	"ecursion like old implementations\n    word a = (word)((uwor"
	.ascii	"d)n / (uword)base);\n    if (a) b_printn_u(a, base);\n    b_"
	.ascii	"putchar((word)((uword)n % (uword)base) + '0');\n}\n\nstatic "
	.ascii	"word b_printf(word fmt, ...){\n    va_list ap;\n    va_start"
	.ascii	"(ap, fmt);\n\n    word i = 0;\n    for (;;){\n        word c"
	.ascii	"h = b_char(fmt, i++);\n        if (ch == 004 || ch == 0) bre"
	.ascii	"ak;  /* '*e' or NUL terminator */\n        if (ch != '%'){ b"
	.ascii	"_putchar(ch); continue; }\n\n        word code = b_char(fmt,"
	.ascii	" i++);\n        if (code == 004) break;\n\n        word arg "
	.ascii	"= va_arg(ap, word);\n\n        switch ((int)code){\n        "
	.ascii	"case 'd': {\n#if WORD_BITS == 16\n            int16_t v = (i"
	.ascii	"nt16_t)arg;\n            if (v < 0){ b_putchar('-'); v = (in"
	.ascii	"t16_t)-v; }\n            if (v) b_printn_u(("
	.ascii	"word)(uword)(uint16_t)v, 10);\n#elif WORD_BITS == 32\n      "
	.ascii	"      int32_t v = (int32_t)arg;\n            if (v < 0){ b_p"
	.ascii	"utchar('-'); v = -v; }\n            if (v) b_printn_u((word)"
	.ascii	"(uword)(uint32_t)v, 10);\n#else\n            word v = arg;\n"
	.ascii	"            if (v < 0){ b_putchar('-'); v = -v; }\n         "
	.ascii	"   if (v) b_printn_u((word)(uword)v, 10);\n#endif\n         "
	.ascii	"   else b_putchar('0');\n            break;\n        }\n    "
	.ascii	"    case 'o': {\n#if WORD_BITS == 16\n            uint16_t v"
	.ascii	" = (uint16_t)arg;\n#elif WORD_BITS == 32\n            uint32"
	.ascii	"_t v = (uint32_t)arg;\n#else\n            uword v = (uword)a"
	.ascii	"rg;\n#endif\n            if (v) b_printn_u((word)(uword)v, 8"
	.ascii	");\n            else b_putchar('0');\n            break;\n  "
	.ascii	"      }\n        case 'u': {\n            uword v = (uword)a"
	.ascii	"rg;\n            if (v) b_printn_u((word)v, 10);\n          "
	.ascii	"  else b_putchar('0');\n            break;\n        }\n     "
	.ascii	"   case 'p': {\n            uword v = (uword)arg;\n         "
	.ascii	"   b_putchar('0'); b_putchar('x');\n            int started "
	.ascii	"= 0;\n            for (int shift = (int)(sizeof(uword)*8 - 4"
	.ascii	"); shift >= 0; shift -= 4) {\n                int nib = (int"
	.ascii	")((v >> shift) & 0xF);\n                if (!started && nib "
	.ascii	"== 0 && shift > 0) continue;\n                started = 1;\n"
	.ascii	"                b_putchar((word)(nib < 10 ? ('0' + nib) : ('"
	.ascii	"a' + nib - 10)));\n            }\n            if (!started) "
	.ascii	"b_putchar('0');\n            break;\n        }\n        case"
	.ascii	" 'z': {\n            word mod = b_char(fmt, i++);\n         "
	.ascii	"   if (mod == 'u') {\n                uword v = (uword)arg;\n"
	.ascii	"                if (v) b_printn_u((word)v, 10);\n           "
	.ascii	"     else b_putchar('0');\n            } else if (mod == 'd'"
	.ascii	") {\n                long v = (long)arg;\n                if"
	.ascii	" (v < 0) { b_putchar('-'); v = -v; }\n                if (v)"
	.ascii	" b_printn_u((word)(uword)v, 10);\n                else b_put"
	.ascii	"char('0');\n            } else {\n                b_putchar("
	.ascii	"'%'); b_putchar('z'); b_putchar(mod);\n            }\n      "
	.ascii	"      break;\n        }\n        case 'c':\n            b_pu"
	.ascii	"tchar(arg);\n        "
	.ascii	"    break;\n        case 's': {\n            word j = 0;\n  "
	.ascii	"          for (;;){\n                word sc = b_char(arg, j"
	.ascii	"++);\n                if (sc == 004 || sc == 0) break;  /* H"
	.ascii	"andle both *e and NUL termination */\n                b_putc"
	.ascii	"har(sc);\n            }\n            break;\n        }\n    "
	.ascii	"    default:\n            b_putchar('%'); b_putchar(code);\n"
	.ascii	"            break;\n        }\n    }\n\n    va_end(ap);\n   "
	.ascii	" return 0;\n}\n\n/* File I/O functions - with actual impleme"
	.ascii	"ntations */\n#include <fcntl.h>\nstatic word b_open(word nam"
	.ascii	"e, word mode){\n    const char *p = __b_cstr(name);\n    int"
	.ascii	" flags = ((int)mode == 0) ? O_RDONLY : O_WRONLY;\n    return"
	.ascii	" (word)open(p, flags);\n}\nstatic word b_openr(word fd, word"
	.ascii	" name){\n    char buf[512];\n    __b_bstr_to_cstr(name, buf,"
	.ascii	" sizeof(buf));\n    int target = (int)fd;\n    if (target < "
	.ascii	"0 || buf[0] == '\\0') {\n        rd_fd = 0; rd_unit = -1; re"
	.ascii	"turn 0;\n    }\n    int newfd = open(buf, O_RDONLY);\n    if"
	.ascii	" (rd_fd != 0 && rd_fd != target) close(rd_fd);\n    if (newf"
	.ascii	"d < 0) { rd_fd = -1; rd_unit = (word)target; return -1; }\n "
	.ascii	"   if (newfd != target) {\n        if (dup2(newfd, target) <"
	.ascii	" 0) { close(newfd); return -1; }\n        close(newfd);\n   "
	.ascii	"     newfd = target;\n    }\n    rd_fd = newfd;\n    rd_unit"
	.ascii	" = (word)target;\n    return (word)newfd;\n}\nstatic word b_"
	.ascii	"openw(word fd, word name){\n    char buf[512];\n    __b_bstr"
	.ascii	"_to_cstr(name, buf, sizeof(buf));\n    int target = (int)fd;"
	.ascii	"\n    if (target < 0 || buf[0] == '\\0') {\n        wr_fd = "
	.ascii	"1; wr_unit = -1; return 1;\n    }\n    int newfd = open(buf,"
	.ascii	" O_WRONLY | O_CREAT | O_TRUNC, 0666);\n    if (newfd < 0) re"
	.ascii	"turn -1;\n    if (wr_fd != 1 && wr_fd != target && wr_fd != "
	.ascii	"newfd) close(wr_fd);\n    if (newfd != target) {\n        if"
	.ascii	" (dup2(newfd, target) < 0) { close(newfd); return -1; }\n   "
	.ascii	"     close(newfd);\n        newfd = target;\n    }\n    wr_f"
	.ascii	"d = newfd;\n    wr_unit = (word)target;\n    return (word)ne"
	.ascii	"wfd;\n}\nstatic word b_close(word fd) {\n    int cfd = (int)"
	.ascii	"fd;\n    word r = (word)close(cfd);\n    if (r == 0) {\n    "
	.ascii	"    if (cfd == rd_fd || cfd == "
	.ascii	"(int)rd_unit) { rd_fd = 0; rd_unit = -1; }\n        if (cfd "
	.ascii	"== wr_fd || cfd == (int)wr_unit) { wr_fd = 1; wr_unit = -1; "
	.ascii	"}\n    }\n    return r;\n}\nstatic word b_read(word fd, word"
	.ascii	" buf, word n) {\n#if WORD_BITS == 16\n    if (n < 0) return "
	.ascii	"-1;\n    unsigned char *bytes = malloc(n ? (size_t)n : 1);\n"
	.ascii	"    if (!bytes) return -1;\n    ssize_t count = read((int)fd"
	.ascii	", bytes, (size_t)n);\n    for (ssize_t i = 0; i < count; i++"
	.ascii	") b_lchar(buf, (word)i, bytes[i]);\n    free(bytes);\n    re"
	.ascii	"turn WVAL(count);\n#else\n    char *p = (char*)B_CPTR(buf);\n"
	.ascii	"    if ((size_t)n < sizeof(word)) memset(p, 0, sizeof(word))"
	.ascii	";\n    return (word)read((int)fd, p, (size_t)n);\n#endif\n}\n"
	.ascii	"static word b_write(word fd, word buf, word n) {\n#if WORD_B"
	.ascii	"ITS == 16\n    if (n < 0) return -1;\n    unsigned char *byt"
	.ascii	"es = malloc(n ? (size_t)n : 1);\n    if (!bytes) return -1;\n"
	.ascii	"    for (word i = 0; i < n; i++) bytes[i] = (unsigned char)b"
	.ascii	"_char(buf, i);\n    ssize_t count = write((int)fd, bytes, (s"
	.ascii	"ize_t)n);\n    free(bytes);\n    return WVAL(count);\n#else\n"
	.ascii	"    return (word)write((int)fd, B_CPTR(buf), (size_t)n);\n#e"
	.ascii	"ndif\n}\nstatic word b_creat(word name, word mode) {\n    co"
	.ascii	"nst char *p = __b_cstr(name);\n    return (word)creat(p, (mo"
	.ascii	"de_t)mode);\n}\nstatic word b_seek(word fd, word offset, wor"
	.ascii	"d whence) {\n    off_t r = lseek((int)fd, (off_t)offset, (in"
	.ascii	"t)whence);\n    return (r < 0) ? (word)-1 : (word)0;\n}\n\n/"
	.ascii	"* Process control functions - with actual implementations */"
	.ascii	"\nstatic word b_fork(void) {\n    return (word)fork();\n}\ns"
	.ascii	"tatic word __b_wait_status;\n\nstatic word b_wait(void) {\n "
	.ascii	"   int st = 0;\n    pid_t pid = wait(&st);\n    __b_wait_sta"
	.ascii	"tus = (word)st;\n    return (word)pid;\n}\n/* B72 section 8 "
	.ascii	"passes exactly count argument strings, including arg0. */\ns"
	.ascii	"tatic word b_execv(word path, word argv, word count) {\n    "
	.ascii	"if (count < 0 || count > 255 || (count && !argv)) return -1;"
	.ascii	"\n    char *name = __b_dup_bstr(path);\n    if (!name) retur"
	.ascii	"n -1;\n    char *arguments[256];\n    word *values = count ?"
	.ascii	" (word*)B_CPTR(argv) : NULL;\n    size_t n = (size_t)count, "
	.ascii	"i = 0;\n    for (;"
	.ascii	" i < n; i++) {\n        if (!values[i]) break;\n        argu"
	.ascii	"ments[i] = __b_dup_bstr(values[i]);\n        if (!arguments["
	.ascii	"i]) break;\n    }\n    if (i == n) {\n        arguments[n] ="
	.ascii	" NULL;\n        execv(name, arguments);\n    }\n    while (i"
	.ascii	") free(arguments[--i]);\n    free(name);\n    return -1;\n}\n"
	.ascii	"\nstatic word b_execl(word path, ...) {\n    char *name = __"
	.ascii	"b_dup_bstr(path);\n    if (!name) return -1;\n    char *argu"
	.ascii	"ments[256];\n    size_t n = 0;\n    int complete = 0;\n    v"
	.ascii	"a_list ap;\n    va_start(ap, path);\n    while (n < 255) {\n"
	.ascii	"        word value = va_arg(ap, word);\n        if (!value) "
	.ascii	"{ complete = 1; break; }\n        arguments[n] = __b_dup_bst"
	.ascii	"r(value);\n        if (!arguments[n]) break;\n        n++;\n"
	.ascii	"    }\n    va_end(ap);\n    if (complete) {\n        argumen"
	.ascii	"ts[n] = NULL;\n        execv(name, arguments);\n    }\n    w"
	.ascii	"hile (n) free(arguments[--n]);\n    free(name);\n    return "
	.ascii	"-1;\n}\n\nstatic word b_system(word cmd) {\n    /* Split arg"
	.ascii	"uments without invoking a shell or expanding their contents."
	.ascii	" */\n    char *line = __b_dup_bstr(cmd);\n    if (!line) ret"
	.ascii	"urn -1;\n    char *argv[128];\n    size_t argc = 0;\n    cha"
	.ascii	"r *p = line, *q = line;\n    while (*p) {\n        while (*p"
	.ascii	" && isspace((unsigned char)*p)) p++;\n        if (!*p) break"
	.ascii	";\n        if (argc + 1 >= sizeof(argv)/sizeof(argv[0])) { f"
	.ascii	"ree(line); return -1; }\n        argv[argc++] = q;\n        "
	.ascii	"int quote = 0;\n        while (*p && (quote || !isspace((uns"
	.ascii	"igned char)*p))) {\n            unsigned char c = (unsigned "
	.ascii	"char)*p++;\n            if (c == '\\\\' && quote != '\\'') {"
	.ascii	"\n                if (!*p) { free(line); return -1; }\n     "
	.ascii	"           *q++ = *p++;\n            } else if (c == '\\'' |"
	.ascii	"| c == '\"') {\n                if (!quote) quote = c;\n    "
	.ascii	"            else if (quote == c) quote = 0;\n               "
	.ascii	" else *q++ = (char)c;\n            } else *q++ = (char)c;\n "
	.ascii	"       }\n        if (quote) { free(line); return -1; }\n   "
	.ascii	"     if (*p) p++;\n        *q++ = 0;\n    }\n    if (argc =="
	.ascii	" 0) { free(line); return -1; }\n    argv[argc] = NULL;\n    "
	.ascii	"pid_t pid = fork();\n    if (pid ="
	.ascii	"= 0) {\n        execvp(argv[0], argv);\n        _exit(127);\n"
	.ascii	"    }\n    if (pid < 0) { free(line); return -1; }\n    int "
	.ascii	"st = 0;\n    pid_t w;\n    do { w = waitpid(pid, &st, 0); } "
	.ascii	"while (w < 0 && errno == EINTR);\n    free(line);\n    if (w"
	.ascii	" < 0) return -1;\n    return (word)st;\n}\n\nstatic word b_u"
	.ascii	"sleep(word usec) {\n    usleep((useconds_t)usec);\n    retur"
	.ascii	"n 0;\n}\n\nstatic word b_callf_dispatch(int nargs, word name"
	.ascii	", ...) {\n    static int __b_callf_dl_done = 0;\n    if (!__"
	.ascii	"b_callf_dl_done) {\n        __b_callf_dl_done = 1;\n        "
	.ascii	"const char *env = getenv(\"B_CALLF_LIB\");\n        if (env "
	.ascii	"&& *env) {\n            const char *p = env;\n            wh"
	.ascii	"ile (*p) {\n                const char *start = p;\n        "
	.ascii	"        while (*p && *p != ':') p++;\n                size_t"
	.ascii	" len = (size_t)(p - start);\n                if (len) {\n   "
	.ascii	"                 char *path = (char*)malloc(len + 1);\n     "
	.ascii	"               if (path) {\n                        memcpy(p"
	.ascii	"ath, start, len);\n                        path[len] = '\\0'"
	.ascii	";\n                        (void)dlopen(path, RTLD_NOW | RTL"
	.ascii	"D_GLOBAL);\n                        free(path);\n           "
	.ascii	"         }\n                }\n                if (*p == ':'"
	.ascii	") p++;\n            }\n        }\n    }\n    if (nargs < 0 |"
	.ascii	"| nargs > 10) return -1;\n    if (name == 0) return -1;\n \n"
	.ascii	"    char sym[256];\n    __b_bstr_to_cstr(name, sym, sizeof(s"
	.ascii	"ym));\n \n    void *fn = dlsym(RTLD_DEFAULT, sym);\n    if ("
	.ascii	"!fn) {\n        size_t len = strlen(sym);\n        if (len +"
	.ascii	" 2 < sizeof(sym)) {\n            sym[len] = '_'; sym[len + 1"
	.ascii	"] = '\\0';\n            fn = dlsym(RTLD_DEFAULT, sym);\n    "
	.ascii	"        sym[len] = '\\0';\n        }\n    }\n    if (!fn) re"
	.ascii	"turn -1;\n \n    void *args[10] = {0};\n    va_list ap;\n   "
	.ascii	" va_start(ap, name);\n    for (int i = 0; i < nargs && i < 1"
	.ascii	"0; i++) {\n        word w = va_arg(ap, word);\n        args["
	.ascii	"i] = B_CPTR(w);\n    }\n    va_end(ap);\n \n    word r = 0;\n"
	.ascii	"    switch (nargs) {\n    case 0: r = ((word (*)(void))fn)()"
	.ascii	"; break;\n    case 1: r = ((word (*)(void*))fn)(args[0]); br"
	.ascii	"eak;\n    case 2: r = ((word (*)(vo"
	.ascii	"id*, void*))fn)(args[0], args[1]); break;\n    case 3: r = ("
	.ascii	"(word (*)(void*, void*, void*))fn)(args[0], args[1], args[2]"
	.ascii	"); break;\n    case 4: r = ((word (*)(void*, void*, void*, v"
	.ascii	"oid*))fn)(args[0], args[1], args[2], args[3]); break;\n    c"
	.ascii	"ase 5: r = ((word (*)(void*, void*, void*, void*, void*))fn)"
	.ascii	"(args[0], args[1], args[2], args[3], args[4]); break;\n    c"
	.ascii	"ase 6: r = ((word (*)(void*, void*, void*, void*, void*, voi"
	.ascii	"d*))fn)(args[0], args[1], args[2], args[3], args[4], args[5]"
	.ascii	"); break;\n    case 7: r = ((word (*)(void*, void*, void*, v"
	.ascii	"oid*, void*, void*, void*))fn)(args[0], args[1], args[2], ar"
	.ascii	"gs[3], args[4], args[5], args[6]); break;\n    case 8: r = ("
	.ascii	"(word (*)(void*, void*, void*, void*, void*, void*, void*, v"
	.ascii	"oid*))fn)(args[0], args[1], args[2], args[3], args[4], args["
	.ascii	"5], args[6], args[7]); break;\n    case 9: r = ((word (*)(vo"
	.ascii	"id*, void*, void*, void*, void*, void*, void*, void*, void*)"
	.ascii	")fn)(args[0], args[1], args[2], args[3], args[4], args[5], a"
	.ascii	"rgs[6], args[7], args[8]); break;\n    case 10: r = ((word ("
	.ascii	"*)(void*, void*, void*, void*, void*, void*, void*, void*, v"
	.ascii	"oid*, void*))fn)(args[0], args[1], args[2], args[3], args[4]"
	.ascii	", args[5], args[6], args[7], args[8], args[9]); break;\n    "
	.ascii	"default: return -1;\n    }\n    return r;\n}\n\n/* System fu"
	.ascii	"nctions - with actual implementations where possible */\n/* "
	.ascii	"Unix V1 counts 60 Hz ticks since 1971, high word first (time"
	.ascii	"(II)). */\nstatic word b_time(word tvp) {\n    struct timesp"
	.ascii	"ec now;\n    if (clock_gettime(CLOCK_REALTIME, &now) != 0) r"
	.ascii	"eturn -1;\n    if (tvp) {\n        uint64_t elapsed = (uint6"
	.ascii	"4_t)now.tv_sec - UINT64_C(31536000);\n        uint32_t ticks"
	.ascii	" = (uint32_t)(elapsed * 60 + (uint64_t)now.tv_nsec * 60 / 10"
	.ascii	"00000000);\n        word *tv = (word*)B_CPTR(tvp);\n        "
	.ascii	"tv[0] = WVAL(ticks >> 16);\n        tv[1] = WVAL(ticks & 655"
	.ascii	"35);\n    }\n    return 0;\n}\n\n/* B72 section 8 specifies "
	.ascii	"a caller-owned, 16-byte date buffer. */\nstatic word b_ctime"
	.ascii	"(word tvp, word date) {\n    if (!tvp || !date) return -1;\n"
	.ascii	"    word *tv = (word*)B_CPTR(tvp);\n    uint32_t tick"
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
	.ascii	"gth;\n        month++;\n    }\n    char text[16];\n    snpri"
	.ascii	"ntf(text, sizeof(text), \"%s %2u %02u:%02u:%02u\", months[mo"
	.ascii	"nth], days + 1,\n             seconds / 3600, seconds / 60 %"
	.ascii	" 60, seconds % 60);\n    for (size_t i = 0; i < sizeof(text)"
	.ascii	"; i++) b_lchar(date, (word)i, (word)(unsigned char)text[i]);"
	.ascii	"\n    return 0;\n}\n\nstatic word b_getuid(void) {\n    retu"
	.ascii	"rn (word)getuid();\n}\nstatic word b_chdir(word path) {\n   "
	.ascii	" const char *p = __b_cstr(path);\n    return (word)chdir(p);"
	.ascii	"\n}\nstatic word b_unlink(word path) {\n    const char *p = "
	.ascii	"__b_cstr(path);\n    return (word)unlink(p);\n}\n\n/* System"
	.ascii	" functions with actual implementations */\nstatic word b_chm"
	.ascii	"od(word path, word mode) {\n    const char *p = __b_cstr(pat"
	.ascii	"h);\n    return (word)chmod(p, (mode_t)mode);\n}\nstatic wor"
	.ascii	"d b_chown(word path, word owner) {\n    const char *p = __b_"
	.ascii	"cstr(path);\n    return (word)chown(p, (uid_t)owner, (gid_t)"
	.ascii	"-1);\n}\nstatic word b_link(word old, word new) {\n    const"
	.ascii	" char *o = __b_cstr(old);\n    const char *n = __b_cstr(new)"
	.ascii	";\n    return (word)link(o, n);\n}\nstatic word b_stat(word "
	.ascii	"path, word bufp) {\n    const char *p = __b_cstr(path);\n   "
	.ascii	" struct stat st;\n    if (stat(p, &st) != 0) return -1;\n   "
	.ascii	" if (bufp) {\n        unsigned char *b = (unsigned char*)B_C"
	.ascii	"PTR(bufp);\n        for (int i = 0; i < 20*sizeof(word); i++"
	.ascii	") b[i] = 0;\n        size_t n = sizeof(st);\n        if (n >"
	.ascii	" 20*sizeof(word)) n = 20*sizeof(word);\n   "
	.ascii	"     memcpy(b, &st, n);\n    }\n    return 0;\n}\n\nstatic w"
	.ascii	"ord b_fstat(word fd, word bufp) {\n    struct stat st;\n    "
	.ascii	"if (fstat((int)fd, &st) != 0) return -1;\n    if (bufp) {\n "
	.ascii	"       unsigned char *b = (unsigned char*)B_CPTR(bufp);\n   "
	.ascii	"     for (int i = 0; i < 20*sizeof(word); i++) b[i] = 0;\n  "
	.ascii	"      size_t n = sizeof(st);\n        if (n > 20*sizeof(word"
	.ascii	")) n = 20*sizeof(word);\n        memcpy(b, &st, n);\n    }\n"
	.ascii	"    return 0;\n}\nstatic word b_setuid(word uid) {\n    retu"
	.ascii	"rn (word)setuid((uid_t)uid);\n}\nstatic word b_makdir(word p"
	.ascii	"ath, word mode) {\n    const char *p = __b_cstr(path);\n    "
	.ascii	"return (word)mkdir(p, (mode_t)mode);\n}\n\n/* printn(number,"
	.ascii	" base) - print number in specified base (from B manual) */\n"
	.ascii	"static word b_printn(word n, word base) {\n    // Handle neg"
	.ascii	"ative numbers for decimal only\n    if (base == 10 && (int16"
	.ascii	"_t)n < 0) {\n        b_putchar('-');\n        n = (word)(-(i"
	.ascii	"nt16_t)n);\n    }\n    b_printn_u(n, base);\n    return n;\n"
	.ascii	"}\nstatic word b_putnum(word n) {\n    b_printn(n, (word)10)"
	.ascii	";\n    return n;\n}\nstatic volatile sig_atomic_t __b_got_in"
	.ascii	"tr = 0;\n\nstatic void __b_sigint(int sig){ (void)sig; __b_g"
	.ascii	"ot_intr = 1; }\n\nstatic word b_gtty(word fd, word ttstat){\n"
	.ascii	"    struct termios t;\n    if (tcgetattr((int)fd, &t) < 0) r"
	.ascii	"eturn -1;\n\n    word *vec = (word*)B_CPTR(ttstat);\n    vec"
	.ascii	"[0] = (word)t.c_iflag;\n    vec[1] = (word)t.c_oflag;\n    v"
	.ascii	"ec[2] = (word)t.c_lflag;\n    return 0;\n}\n\nstatic word b_"
	.ascii	"stty(word fd, word ttstat){\n    struct termios t;\n    if ("
	.ascii	"tcgetattr((int)fd, &t) < 0) return -1;\n\n    word *vec = (w"
	.ascii	"ord*)B_CPTR(ttstat);\n    t.c_iflag = (tcflag_t)vec[0];\n   "
	.ascii	" t.c_oflag = (tcflag_t)vec[1];\n    t.c_lflag = (tcflag_t)ve"
	.ascii	"c[2];\n    return (word)tcsetattr((int)fd, TCSANOW, &t);\n}\n"
	.ascii	"static word b_intr(word on) {\n    /* Set up interrupt handl"
	.ascii	"ing */\n    /* on != 0: catch interrupts, on == 0: restore d"
	.ascii	"efault */\n    if (on) {\n        __b_got_intr = 0;\n       "
	.ascii	" if (signal(SIGINT, __b_sigint) == SIG_ERR) return -1;\n    "
	.ascii	"} else {\n        if (signal(SIGINT, SIG_DFL) == SIG_ERR) re"
	.ascii	"turn -1;\n    }\n    return 0;\n"
	.string	"}\n\n/* Builtin aliases for B source */\n\n"
	.section	.rodata.str1.1
.LC159:
	.string	"static void __b_init(void) {\n"
	.section	.rodata.str1.8
	.align 8
.LC160:
	.string	"    setvbuf(stdout, NULL, _IONBF, 0);\n"
	.section	.rodata.str1.1
.LC161:
	.string	"static word __%s_blob[%zu];\n"
.LC162:
	.string	"static word __%s_store[%zu];\n"
.LC163:
	.string	"static word %s;\n"
.LC164:
	.string	"}\n\n"
.LC165:
	.string	"    %s = "
.LC166:
	.string	"    %s = __%s_blob[0];\n"
	.section	.rodata.str1.8
	.align 8
.LC167:
	.string	"    %s = B_PTR_N(__%s_blob, sizeof(__%s_blob));\n"
	.align 8
.LC168:
	.string	"    %s = B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC169:
	.string	"__%s_store"
.LC170:
	.string	"static word __b_user_main("
.LC171:
	.string	");\n"
.LC172:
	.string	"word "
.LC173:
	.string	"word"
.LC174:
	.string	"word __b_user_main("
	.section	.rodata.str1.8
	.align 8
.LC175:
	.string	"int main(int argc, char **argv){\n"
	.section	.rodata.str1.1
.LC176:
	.string	"    __b_setargs(argc, argv);\n"
.LC177:
	.string	"    __b_init();\n"
	.section	.rodata.str1.8
	.align 8
.LC178:
	.string	"    return (int)__b_user_main();\n"
	.align 8
.LC179:
	.string	"    return (int)__b_user_main((word)argc);\n"
	.align 8
.LC180:
	.string	"    return (int)__b_user_main((word)argc, __b_argvalues());\n"
	.section	.rodata.str1.1
.LC181:
	.string	"__%s_blob"
	.text
	.p2align 4
	.globl	emit_program_c
	.type	emit_program_c, @function
emit_program_c:
.LFB57:
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
	jne	.L1504
.L1350:
	movq	%rbp, %rcx
	movl	$1546, %edx
	movl	$1, %esi
	leaq	.LC152(%rip), %rdi
	call	fwrite@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbp, %rdi
	setne	%dl
	leaq	.LC153(%rip), %rsi
	leaq	32(%rsp), %r13
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%r12d, %edx
	movq	%rbp, %rdi
	xorl	%eax, %eax
	leaq	.LC154(%rip), %rsi
	call	fprintf@PLT
	movq	%rbp, %rcx
	movl	$1441, %edx
	movl	$1, %esi
	leaq	.LC155(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC156(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r13, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbp, %rcx
	movl	$73, %edx
	movl	$1, %esi
	leaq	.LC157(%rip), %rdi
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
	movl	$28039, %edx
	movl	$1, %esi
	leaq	.LC158(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1505
.L1351:
	xorl	%r12d, %r12d
	cmpq	$0, 8(%rbx)
	jne	.L1352
	jmp	.L1381
	.p2align 4,,10
	.p2align 3
.L1355:
	cmpl	$3, %eax
	je	.L1506
	cmpl	$2, %eax
	je	.L1507
.L1356:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L1381
.L1352:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rdx
	movl	(%rdx), %eax
	testl	%eax, %eax
	jne	.L1355
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
	jb	.L1352
	.p2align 4
	.p2align 3
.L1381:
	movq	%rbp, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC159(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$38, %edx
	movl	$1, %esi
	leaq	.LC160(%rip), %rdi
	call	fwrite@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L1353
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	emit_global_regions.part.0
.L1353:
	xorl	%r12d, %r12d
	cmpq	$0, 8(%rbx)
	jne	.L1382
	jmp	.L1405
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1386:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L1405
.L1382:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$2, (%rax)
	jne	.L1386
	movq	8(%rax), %r14
	movq	8(%r14), %rdi
	call	get_mangled_name
	movq	%rax, %r15
	movl	16(%r14), %eax
	testl	%eax, %eax
	jne	.L1387
	movq	48(%r14), %rax
	testq	%rax, %rax
	je	.L1386
	movl	(%rax), %eax
	testl	%eax, %eax
	jne	.L1386
	leaq	.LC165(%rip), %rsi
	xorl	%eax, %eax
	movq	%r15, %rdx
	movq	%rbp, %rdi
	call	fprintf@PLT
	movq	48(%r14), %rax
	movq	16(%rax), %rsi
	cmpl	$2, (%rsi)
	je	.L1503
.L1389:
	movq	(%rsp), %rdx
	movq	%rbp, %rdi
	call	emit_expr
.L1390:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC107(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%rbx), %r12
	jb	.L1382
	.p2align 4
	.p2align 3
.L1405:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC164(%rip), %rdi
	leaq	.LC173(%rip), %r15
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	emit_known_external_function_prototypes
	cmpq	$0, 8(%rbx)
	jne	.L1383
	jmp	.L1384
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1408:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L1384
.L1383:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$1, (%rax)
	jne	.L1408
	movq	8(%rax), %r14
	leaq	.LC25(%rip), %rsi
	movq	(%r14), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1409
	leaq	.LC26(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1410
.L1409:
	movq	%rbp, %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC170(%rip), %rdi
	call	fwrite@PLT
.L1413:
	xorl	%r13d, %r13d
	cmpq	$0, 16(%r14)
	jne	.L1411
	jmp	.L1414
	.p2align 4,,10
	.p2align 3
.L1508:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC66(%rip), %rdi
	call	fwrite@PLT
.L1411:
	movq	%rbp, %rcx
	movl	$4, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
	addq	$1, %r13
	cmpq	16(%r14), %r13
	jb	.L1508
.L1414:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC171(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%rbx), %r12
	jb	.L1383
	.p2align 4
	.p2align 3
.L1384:
	movq	%rbp, %rsi
	movl	$10, %edi
	xorl	%r12d, %r12d
	call	fputc@PLT
	cmpq	$0, 8(%rbx)
	movq	$0, 16(%rsp)
	movl	$0, 8(%rsp)
	je	.L1349
	.p2align 5
	.p2align 4
	.p2align 3
.L1406:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$1, (%rax)
	je	.L1509
.L1416:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jb	.L1406
	movl	8(%rsp), %edi
	testl	%edi, %edi
	jne	.L1510
.L1349:
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
.L1507:
	.cfi_restore_state
	movq	8(%rdx), %r15
	movq	8(%r15), %rdi
	call	get_mangled_name
	movq	%rax, %r14
	movl	16(%r15), %eax
	cmpl	$1, %eax
	jne	.L1359
	movq	48(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1433
	cmpl	$1, (%rdi)
	jne	.L1433
	movq	24(%rdi), %r10
	cmpq	$1, %r10
	jne	.L1361
	movq	16(%rdi), %rax
	movq	(%rax), %rax
	movl	(%rax), %edx
	testl	%edx, %edx
	jne	.L1361
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L1361
	cmpl	$1, (%rax)
	je	.L1502
.L1361:
	call	edge_tail_words_top
	leaq	(%r10,%rax), %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	jmp	.L1360
	.p2align 4,,10
	.p2align 3
.L1387:
	cmpl	$1, %eax
	je	.L1511
	cmpl	$2, %eax
	jne	.L1386
	movq	%r15, %r8
	movq	%r15, %rcx
	movq	%r15, %rdx
	movq	%rbp, %rdi
	leaq	.LC168(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r14), %rax
	testq	%rax, %rax
	je	.L1386
	cmpl	$1, (%rax)
	jne	.L1386
	movl	32(%r14), %r10d
	movq	24(%rax), %r8
	testl	%r10d, %r10d
	jne	.L1400
	movq	24(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1400
	movq	$0, 32(%rsp)
	movq	%r13, %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1400
	movq	32(%rsp), %rax
	cmpq	%rax, %r8
	movq	%rax, %rdx
	cmovnb	%r8, %rdx
	testq	%rax, %rax
	cmovns	%rdx, %r8
.L1399:
	movq	%r15, %rcx
	movl	$256, %esi
	movq	%r13, %rdi
	movq	%r8, 8(%rsp)
	leaq	.LC169(%rip), %rdx
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
	jmp	.L1386
	.p2align 4,,10
	.p2align 3
.L1506:
	movq	8(%rdx), %r14
	leaq	.LC27(%rip), %rdi
	movq	%rbp, %rcx
	movl	$12, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1358
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1358:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC107(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1356
	.p2align 4,,10
	.p2align 3
.L1509:
	movq	8(%rax), %r15
	leaq	.LC25(%rip), %rsi
	movq	(%r15), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1417
	leaq	.LC26(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1418
.L1417:
	movq	16(%r15), %rax
	movq	%rbp, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC174(%rip), %rdi
	movq	%rax, 16(%rsp)
	call	fwrite@PLT
	movl	$1, 8(%rsp)
.L1419:
	xorl	%r14d, %r14d
	cmpq	$0, 16(%r15)
	leaq	.LC172(%rip), %r13
	jne	.L1421
	jmp	.L1423
	.p2align 4,,10
	.p2align 3
.L1512:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC66(%rip), %rdi
	call	fwrite@PLT
.L1421:
	movq	%r13, %rdi
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r15), %rax
	movq	(%rax,%r14,8), %rdi
	testq	%rdi, %rdi
	je	.L1422
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1422:
	addq	$1, %r14
	cmpq	16(%r15), %r14
	jb	.L1512
.L1423:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	movq	(%rsp), %rdx
	movq	%r15, %rsi
	movq	%rbp, %rdi
	call	emit_function_body
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1416
	.p2align 4,,10
	.p2align 3
.L1359:
	cmpl	$2, %eax
	je	.L1513
	movl	4(%r15), %eax
	movq	%r14, %rdx
	testl	%eax, %eax
	je	.L1380
	leaq	.LC163(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1356
	.p2align 4,,10
	.p2align 3
.L1433:
	movl	$1, %ecx
.L1360:
	movq	%r14, %rdx
	leaq	.LC161(%rip), %rsi
.L1501:
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L1502:
	movq	%r14, %rdx
	leaq	.LC127(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1356
	.p2align 4,,10
	.p2align 3
.L1511:
	movq	48(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1393
	cmpl	$1, (%rdi)
	je	.L1514
.L1393:
	movq	%r15, %rcx
	movq	%r15, %rdx
	leaq	.LC166(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1386
	.p2align 4,,10
	.p2align 3
.L1510:
	movq	%rbp, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC175(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC176(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC177(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%rsp)
	je	.L1427
	cmpq	$1, 16(%rsp)
	je	.L1515
	cmpq	$2, 16(%rsp)
	jne	.L1427
	movq	%rbp, %rcx
	movl	$60, %edx
	movl	$1, %esi
	leaq	.LC180(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1425
	.p2align 4,,10
	.p2align 3
.L1504:
	movq	%rbp, %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC151(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1350
	.p2align 4,,10
	.p2align 3
.L1505:
	movq	%rbp, %rdi
	call	emit_string_pool
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1351
	.p2align 4,,10
	.p2align 3
.L1410:
	leaq	.LC172(%rip), %r13
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1412
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1412:
	movq	%rbp, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1413
	.p2align 4,,10
	.p2align 3
.L1427:
	movq	%rbp, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC178(%rip), %rdi
	call	fwrite@PLT
.L1425:
	addq	$296, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC124(%rip), %rdi
	popq	%rbp
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
.L1513:
	.cfi_restore_state
	movq	48(%r15), %r8
	movl	32(%r15), %eax
	testq	%r8, %r8
	je	.L1516
	cmpl	$1, (%r8)
	je	.L1366
	testl	%eax, %eax
	jne	.L1364
	movq	24(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1364
	movq	$0, 32(%rsp)
	movq	%r13, %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1374
	movq	32(%rsp), %r10
	xorl	%eax, %eax
	testq	%r10, %r10
	cmovs	%rax, %r10
.L1375:
	cmpl	$1, (%r8)
	je	.L1379
.L1429:
	testq	%r10, %r10
	movl	$1, %ecx
	cmovne	%r10, %rcx
	jmp	.L1368
	.p2align 4,,10
	.p2align 3
.L1380:
	leaq	.LC127(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1356
	.p2align 4,,10
	.p2align 3
.L1418:
	leaq	.LC172(%rip), %r13
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1420
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1420:
	movq	%rbp, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1419
.L1516:
	testl	%eax, %eax
	je	.L1517
.L1364:
	movl	$1, %ecx
.L1368:
	movq	%r14, %rdx
	leaq	.LC162(%rip), %rsi
	jmp	.L1501
.L1514:
	movq	24(%rdi), %rax
	movq	%rax, 8(%rsp)
	cmpq	$1, %rax
	je	.L1518
	call	edge_tail_words_top
	leaq	.LC181(%rip), %rdx
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
	je	.L1393
	cmpq	$1, 8(%rsp)
	ja	.L1430
	testq	%r10, %r10
	je	.L1393
.L1430:
	movq	%r15, %r8
	movq	%r15, %rcx
	movq	%r15, %rdx
	movq	%rbp, %rdi
	leaq	.LC167(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1386
.L1515:
	movq	%rbp, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC179(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1425
.L1517:
	movq	24(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1364
	movq	$0, 32(%rsp)
	movq	%r13, %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1364
	movq	32(%rsp), %rcx
	xorl	%eax, %eax
	testq	%rcx, %rcx
	cmovs	%rax, %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	jmp	.L1368
.L1366:
	movq	24(%r8), %r10
	testl	%eax, %eax
	jne	.L1500
	movq	24(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1500
	movq	$0, 32(%rsp)
	movq	%r13, %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1377
	movq	32(%rsp), %rax
	cmpq	%rax, %r10
	movq	%rax, %rdx
	cmovnb	%r10, %rdx
	testq	%rax, %rax
	cmovns	%rdx, %r10
	jmp	.L1375
.L1400:
	testq	%r8, %r8
	movl	$1, %eax
	cmove	%rax, %r8
	jmp	.L1399
.L1519:
	leaq	.LC165(%rip), %rsi
	xorl	%eax, %eax
	movq	%r15, %rdx
	movq	%rbp, %rdi
	call	fprintf@PLT
	movq	48(%r14), %rax
	movq	16(%rax), %rax
	movq	(%rax), %rax
	movq	16(%rax), %rsi
	cmpl	$2, (%rsi)
	jne	.L1389
.L1503:
	movq	%rbp, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1390
.L1518:
	movq	16(%rdi), %rax
	movq	(%rax), %rax
	movl	(%rax), %r11d
	testl	%r11d, %r11d
	jne	.L1395
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L1395
	cmpl	$1, (%rax)
	je	.L1519
.L1395:
	call	edge_tail_words_top
	movq	%r15, %rcx
	movl	$256, %esi
	movq	%r13, %rdi
	movq	%rax, 8(%rsp)
	leaq	.LC181(%rip), %rdx
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
	jne	.L1430
	jmp	.L1393
	.p2align 4,,10
	.p2align 3
.L1500:
	testq	%r10, %r10
	movl	$1, %eax
	cmove	%rax, %r10
.L1379:
	movq	%r8, %rdi
	call	edge_tail_words_top
	leaq	(%rax,%r10), %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	jmp	.L1368
.L1374:
	movl	$1, %r10d
	jmp	.L1429
.L1377:
	testq	%r10, %r10
	jne	.L1375
	movl	$1, %r10d
	jmp	.L1379
	.cfi_endproc
.LFE57:
	.size	emit_program_c, .-emit_program_c
	.section	.rodata.str1.8
	.align 8
.LC182:
	.string	"/* Generated by BCC - B Compiler */\n"
	.section	.rodata.str1.1
.LC183:
	.string	"#include \"libb.h\"\n\n"
	.section	.rodata.str1.8
	.align 8
.LC184:
	.string	"#include <ncurses.h>\n#include <panel.h>\n\n"
	.align 8
.LC185:
	.string	"\nstatic void __b_init_file_%p(void) {\n"
	.section	.rodata.str1.1
.LC186:
	.string	"    __b_init_file_%p();\n"
	.section	.rodata.str1.8
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
	je	.L1675
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
	leaq	.LC182(%rip), %rdi
	call	fwrite@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbp, %rdi
	setne	%dl
	leaq	.LC153(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%r12d, %edx
	movq	%rbp, %rdi
	xorl	%eax, %eax
	leaq	.LC154(%rip), %rsi
	call	fprintf@PLT
	movq	%rbp, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC183(%rip), %rdi
	call	fwrite@PLT
	movl	g_use_curses(%rip), %ecx
	testl	%ecx, %ecx
	jne	.L1676
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1677
.L1523:
	xorl	%r12d, %r12d
	cmpq	$0, 8(%rbx)
	jne	.L1524
	jmp	.L1553
	.p2align 4,,10
	.p2align 3
.L1527:
	cmpl	$3, %eax
	je	.L1678
	cmpl	$2, %eax
	je	.L1679
.L1528:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L1553
.L1524:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rdx
	movl	(%rdx), %eax
	testl	%eax, %eax
	jne	.L1527
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
	jb	.L1524
	.p2align 4
	.p2align 3
.L1553:
	xorl	%eax, %eax
	movq	%rbx, %rdx
	leaq	.LC185(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L1680
.L1525:
	xorl	%r12d, %r12d
	cmpq	$0, 8(%rbx)
	jne	.L1554
	jmp	.L1577
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1558:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L1577
.L1554:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$2, (%rax)
	jne	.L1558
	movq	8(%rax), %r15
	movq	8(%r15), %rdi
	call	get_mangled_name
	movq	%rax, %r13
	movl	16(%r15), %eax
	testl	%eax, %eax
	jne	.L1559
	movq	48(%r15), %rax
	testq	%rax, %rax
	je	.L1558
	movl	(%rax), %r14d
	testl	%r14d, %r14d
	jne	.L1558
	leaq	.LC165(%rip), %rsi
	xorl	%eax, %eax
	movq	%r13, %rdx
	movq	%rbp, %rdi
	call	fprintf@PLT
	movq	48(%r15), %rax
	movq	16(%rax), %rsi
	cmpl	$2, (%rsi)
	je	.L1674
.L1561:
	movq	(%rsp), %rdx
	movq	%rbp, %rdi
	call	emit_expr
.L1562:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC107(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%rbx), %r12
	jb	.L1554
	.p2align 4
	.p2align 3
.L1577:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC164(%rip), %rdi
	leaq	.LC173(%rip), %r15
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	emit_known_external_function_prototypes
	cmpq	$0, 8(%rbx)
	jne	.L1555
	jmp	.L1556
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1580:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L1556
.L1555:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$1, (%rax)
	jne	.L1580
	movq	8(%rax), %r14
	leaq	.LC25(%rip), %rsi
	movq	(%r14), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1581
	leaq	.LC26(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1582
.L1581:
	movq	%rbp, %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC170(%rip), %rdi
	call	fwrite@PLT
.L1585:
	xorl	%r13d, %r13d
	cmpq	$0, 16(%r14)
	jne	.L1583
	jmp	.L1586
	.p2align 4,,10
	.p2align 3
.L1681:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC66(%rip), %rdi
	call	fwrite@PLT
.L1583:
	movq	%rbp, %rcx
	movl	$4, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
	addq	$1, %r13
	cmpq	16(%r14), %r13
	jb	.L1681
.L1586:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC171(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%rbx), %r12
	jb	.L1555
	.p2align 4
	.p2align 3
.L1556:
	movq	%rbp, %rsi
	movl	$10, %edi
	xorl	%r12d, %r12d
	call	fputc@PLT
	cmpq	$0, 8(%rbx)
	movq	$0, 8(%rsp)
	movl	$0, 16(%rsp)
	je	.L1579
	.p2align 5
	.p2align 4
	.p2align 3
.L1578:
	movq	(%rbx), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$1, (%rax)
	je	.L1682
.L1587:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jb	.L1578
	movl	16(%rsp), %edi
	testl	%edi, %edi
	je	.L1579
	movq	%rbp, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC175(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC176(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC177(%rip), %rdi
	call	fwrite@PLT
	xorl	%eax, %eax
	movq	%rbx, %rdx
	movq	%rbp, %rdi
	leaq	.LC186(%rip), %rsi
	call	fprintf@PLT
	cmpq	$0, 8(%rsp)
	je	.L1598
	cmpq	$1, 8(%rsp)
	je	.L1683
	cmpq	$2, 8(%rsp)
	jne	.L1598
	movq	%rbp, %rcx
	movl	$60, %edx
	movl	$1, %esi
	leaq	.LC180(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1596
	.p2align 4,,10
	.p2align 3
.L1679:
	movq	8(%rdx), %r14
	movq	8(%r14), %rdi
	call	get_mangled_name
	movq	%rax, %r13
	movl	16(%r14), %eax
	cmpl	$1, %eax
	jne	.L1531
	movq	48(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1604
	cmpl	$1, (%rdi)
	jne	.L1604
	movq	24(%rdi), %r10
	cmpq	$1, %r10
	jne	.L1533
	movq	16(%rdi), %rax
	movq	(%rax), %rax
	movl	(%rax), %edx
	testl	%edx, %edx
	jne	.L1533
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L1533
	cmpl	$1, (%rax)
	je	.L1673
.L1533:
	call	edge_tail_words_top
	leaq	(%r10,%rax), %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	jmp	.L1532
	.p2align 4,,10
	.p2align 3
.L1559:
	cmpl	$1, %eax
	je	.L1684
	cmpl	$2, %eax
	jne	.L1558
	movq	%r13, %r8
	movq	%r13, %rcx
	movq	%r13, %rdx
	movq	%rbp, %rdi
	leaq	.LC168(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r15), %rax
	testq	%rax, %rax
	je	.L1558
	cmpl	$1, (%rax)
	jne	.L1558
	movl	32(%r15), %r10d
	movq	24(%rax), %r14
	testl	%r10d, %r10d
	jne	.L1572
	movq	24(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1572
	movq	$0, 32(%rsp)
	leaq	32(%rsp), %r10
	movq	%r10, %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1573
	movq	32(%rsp), %rax
	cmpq	%rax, %r14
	movq	%rax, %rdx
	cmovnb	%r14, %rdx
	testq	%rax, %rax
	cmovns	%rdx, %r14
.L1571:
	movq	%r10, %rdi
	movq	%r13, %rcx
	movl	$256, %esi
	movq	%r10, 8(%rsp)
	leaq	.LC169(%rip), %rdx
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
	jmp	.L1558
	.p2align 4,,10
	.p2align 3
.L1531:
	cmpl	$2, %eax
	je	.L1685
	movl	4(%r14), %r15d
	movq	%r13, %rdx
	testl	%r15d, %r15d
	je	.L1552
	leaq	.LC163(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1528
	.p2align 4,,10
	.p2align 3
.L1680:
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	emit_global_regions.part.0
	jmp	.L1525
	.p2align 4,,10
	.p2align 3
.L1579:
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
.L1677:
	.cfi_restore_state
	movq	%rbp, %rdi
	call	emit_string_pool
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1523
	.p2align 4,,10
	.p2align 3
.L1676:
	movq	%rbp, %rcx
	movl	$41, %edx
	movl	$1, %esi
	leaq	.LC184(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	je	.L1523
	jmp	.L1677
	.p2align 4,,10
	.p2align 3
.L1684:
	movq	48(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1565
	cmpl	$1, (%rdi)
	je	.L1686
.L1565:
	movq	%r13, %rcx
	movq	%r13, %rdx
	leaq	.LC166(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1558
	.p2align 4,,10
	.p2align 3
.L1604:
	movl	$1, %ecx
.L1532:
	movq	%r13, %rdx
	leaq	.LC161(%rip), %rsi
.L1672:
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L1673:
	movq	%r13, %rdx
	leaq	.LC127(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1528
	.p2align 4,,10
	.p2align 3
.L1678:
	movq	8(%rdx), %r13
	leaq	.LC27(%rip), %rdi
	movq	%rbp, %rcx
	movl	$12, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r13), %rdi
	testq	%rdi, %rdi
	je	.L1530
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1530:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC107(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1528
	.p2align 4,,10
	.p2align 3
.L1682:
	movq	8(%rax), %r15
	leaq	.LC25(%rip), %rsi
	movq	(%r15), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1588
	leaq	.LC26(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1589
.L1588:
	movq	16(%r15), %rax
	movq	%rbp, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC174(%rip), %rdi
	movq	%rax, 8(%rsp)
	call	fwrite@PLT
	movl	$1, 16(%rsp)
.L1590:
	xorl	%r14d, %r14d
	cmpq	$0, 16(%r15)
	leaq	.LC172(%rip), %r13
	jne	.L1592
	jmp	.L1594
	.p2align 4,,10
	.p2align 3
.L1687:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC66(%rip), %rdi
	call	fwrite@PLT
.L1592:
	movq	%r13, %rdi
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r15), %rax
	movq	(%rax,%r14,8), %rdi
	testq	%rdi, %rdi
	je	.L1593
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1593:
	addq	$1, %r14
	cmpq	16(%r15), %r14
	jb	.L1687
.L1594:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	movq	(%rsp), %rdx
	movq	%r15, %rsi
	movq	%rbp, %rdi
	call	emit_function_body
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1587
	.p2align 4,,10
	.p2align 3
.L1675:
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
.L1598:
	.cfi_restore_state
	movq	%rbp, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC178(%rip), %rdi
	call	fwrite@PLT
.L1596:
	addq	$296, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC124(%rip), %rdi
	popq	%rbp
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
.L1582:
	.cfi_restore_state
	leaq	.LC172(%rip), %r13
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1584
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1584:
	movq	%rbp, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1585
	.p2align 4,,10
	.p2align 3
.L1552:
	leaq	.LC127(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1528
.L1686:
	movq	24(%rdi), %r14
	cmpq	$1, %r14
	je	.L1688
	call	edge_tail_words_top
	leaq	32(%rsp), %r10
	movq	%r13, %rcx
	leaq	.LC181(%rip), %rdx
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
	je	.L1565
	cmpq	$1, %r14
	ja	.L1601
	testq	%r11, %r11
	je	.L1565
.L1601:
	movq	%r13, %r8
	movq	%r13, %rcx
	movq	%r13, %rdx
	movq	%rbp, %rdi
	leaq	.LC167(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1558
	.p2align 4,,10
	.p2align 3
.L1685:
	movq	48(%r14), %r8
	movl	32(%r14), %eax
	testq	%r8, %r8
	je	.L1689
	cmpl	$1, (%r8)
	je	.L1538
	testl	%eax, %eax
	jne	.L1536
	movq	24(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1536
	movq	$0, 32(%rsp)
	leaq	32(%rsp), %r10
	movq	%r10, %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1546
	movq	32(%rsp), %r11
	xorl	%eax, %eax
	testq	%r11, %r11
	cmovs	%rax, %r11
.L1547:
	cmpl	$1, (%r8)
	je	.L1551
.L1600:
	testq	%r11, %r11
	movl	$1, %ecx
	cmovne	%r11, %rcx
	jmp	.L1540
	.p2align 4,,10
	.p2align 3
.L1589:
	leaq	.LC172(%rip), %r13
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	(%r15), %rdi
	testq	%rdi, %rdi
	je	.L1591
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1591:
	movq	%rbp, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1590
.L1683:
	movq	%rbp, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC179(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1596
.L1536:
	movl	$1, %ecx
.L1540:
	movq	%r13, %rdx
	leaq	.LC162(%rip), %rsi
	jmp	.L1672
.L1689:
	testl	%eax, %eax
	jne	.L1536
	movq	24(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1536
	movq	$0, 32(%rsp)
	leaq	32(%rsp), %r10
	movq	%r10, %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1536
	movq	32(%rsp), %rcx
	xorl	%eax, %eax
	testq	%rcx, %rcx
	cmovs	%rax, %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	jmp	.L1540
.L1538:
	movq	24(%r8), %r11
	testl	%eax, %eax
	jne	.L1671
	movq	24(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1671
	movq	$0, 32(%rsp)
	leaq	32(%rsp), %r10
	movq	%r10, %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1549
	movq	32(%rsp), %rax
	cmpq	%rax, %r11
	movq	%rax, %rdx
	cmovnb	%r11, %rdx
	testq	%rax, %rax
	cmovns	%rdx, %r11
	jmp	.L1547
.L1688:
	movq	16(%rdi), %rax
	movq	(%rax), %rax
	movl	(%rax), %r11d
	testl	%r11d, %r11d
	jne	.L1567
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L1567
	cmpl	$1, (%rax)
	je	.L1690
.L1567:
	call	edge_tail_words_top
	leaq	32(%rsp), %r10
	movq	%r13, %rcx
	leaq	.LC181(%rip), %rdx
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
	jne	.L1601
	jmp	.L1565
.L1690:
	leaq	.LC165(%rip), %rsi
	xorl	%eax, %eax
	movq	%r13, %rdx
	movq	%rbp, %rdi
	call	fprintf@PLT
	movq	48(%r15), %rax
	movq	16(%rax), %rax
	movq	(%rax), %rax
	movq	16(%rax), %rsi
	cmpl	$2, (%rsi)
	jne	.L1561
.L1674:
	movq	%rbp, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1562
.L1671:
	testq	%r11, %r11
	movl	$1, %eax
	cmove	%rax, %r11
.L1551:
	movq	%r8, %rdi
	call	edge_tail_words_top
	leaq	(%rax,%r11), %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	jmp	.L1540
.L1572:
	testq	%r14, %r14
	movl	$1, %eax
	leaq	32(%rsp), %r10
	cmove	%rax, %r14
	jmp	.L1571
.L1546:
	movl	$1, %r11d
	jmp	.L1600
.L1573:
	testq	%r14, %r14
	movl	$1, %eax
	cmove	%rax, %r14
	jmp	.L1571
.L1549:
	testq	%r11, %r11
	jne	.L1547
	movl	$1, %r11d
	jmp	.L1551
	.cfi_endproc
.LFE58:
	.size	emit_program_c_ext, .-emit_program_c_ext
	.section	.rodata
	.align 16
	.type	CSWTCH.171, @object
	.size	CSWTCH.171, 24
CSWTCH.171:
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
	.quad	.LC72
	.quad	.LC197
	.quad	.LC198
	.quad	.LC199
	.quad	.LC200
	.quad	.LC79
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
	.quad	.LC67
	.quad	.LC233
	.quad	.LC31
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
.LC234:
	.string	"break"
.LC235:
	.string	"case"
.LC236:
	.string	"const"
.LC237:
	.string	"continue"
.LC238:
	.string	"default"
.LC239:
	.string	"do"
.LC240:
	.string	"double"
.LC241:
	.string	"else"
.LC242:
	.string	"enum"
.LC243:
	.string	"extern"
.LC244:
	.string	"float"
.LC245:
	.string	"for"
.LC246:
	.string	"goto"
.LC247:
	.string	"if"
.LC248:
	.string	"inline"
.LC249:
	.string	"int"
.LC250:
	.string	"long"
.LC251:
	.string	"register"
.LC252:
	.string	"restrict"
.LC253:
	.string	"short"
.LC254:
	.string	"signed"
.LC255:
	.string	"sizeof"
.LC256:
	.string	"static"
.LC257:
	.string	"struct"
.LC258:
	.string	"switch"
.LC259:
	.string	"typedef"
.LC260:
	.string	"union"
.LC261:
	.string	"unsigned"
.LC262:
	.string	"void"
.LC263:
	.string	"volatile"
.LC264:
	.string	"while"
.LC265:
	.string	"_Bool"
.LC266:
	.string	"_Complex"
.LC267:
	.string	"_Imaginary"
.LC268:
	.string	"_Alignas"
.LC269:
	.string	"_Alignof"
.LC270:
	.string	"_Atomic"
.LC271:
	.string	"_Generic"
.LC272:
	.string	"_Noreturn"
.LC273:
	.string	"_Static_assert"
.LC274:
	.string	"_Thread_local"
.LC275:
	.string	"NULL"
.LC276:
	.string	"true"
.LC277:
	.string	"false"
.LC278:
	.string	"bool"
.LC279:
	.string	"B_PTR"
.LC280:
	.string	"B_ADDR"
.LC281:
	.string	"B_DEREF"
	.section	.data.rel.ro.local
	.align 32
	.type	c_keywords, @object
	.size	c_keywords, 424
c_keywords:
	.quad	.LC14
	.quad	.LC234
	.quad	.LC235
	.quad	.LC13
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
	.quad	.LC121
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
	.quad	.LC278
	.quad	.LC173
	.quad	.LC279
	.quad	.LC280
	.quad	.LC281
	.quad	0
	.local	name_map
	.comm	name_map,24,16
	.local	string_pool
	.comm	string_pool,24,16
	.local	current_word_bits
	.comm	current_word_bits,4,4
	.section	.note.GNU-stack,"",@progbits
