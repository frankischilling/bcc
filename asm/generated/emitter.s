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
.LFB31:
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
	movq	40(%rbx), %rdi
	call	collect_strings_expr
.L94:
	movq	48(%rbx), %rbx
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
	movq	40(%rbx), %rdi
	call	collect_strings_expr
.L93:
	movq	48(%rbx), %rdi
	call	collect_strings_expr
	movq	56(%rbx), %rbx
	jmp	.L81
	.p2align 4,,10
	.p2align 3
.L78:
	movq	40(%rbx), %rdi
	call	collect_strings_expr
	cmpq	$0, 56(%rbx)
	je	.L66
	xorl	%ebp, %ebp
.L80:
	movq	48(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_expr
	cmpq	56(%rbx), %rbp
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
.L90:
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
.LFE32:
	.size	collect_strings_init, .-collect_strings_init
	.p2align 4
	.type	collect_strings_stmt, @function
collect_strings_stmt:
.LFB33:
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
.LFE33:
	.size	collect_strings_stmt, .-collect_strings_stmt
	.p2align 4
	.type	collect_strings_program, @function
collect_strings_program:
.LFB34:
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
	movq	56(%r12), %rdi
	call	collect_strings_init
	movq	32(%r12), %rdi
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
.LFE34:
	.size	collect_strings_program, .-collect_strings_program
	.p2align 4
	.type	collect_cases, @function
collect_cases:
.LFB44:
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
.LFE44:
	.size	collect_cases, .-collect_cases
	.p2align 4
	.type	collect_function_labels, @function
collect_function_labels:
.LFB40:
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
.LFE40:
	.size	collect_function_labels, .-collect_function_labels
	.p2align 4
	.type	edge_words_total.part.0.isra.0, @function
edge_words_total.part.0.isra.0:
.LFB72:
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
.LFE72:
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
	je	.L226
	movq	g_known_variables(%rip), %rbx
	xorl	%r12d, %r12d
	leaq	(%rbx,%rax,8), %r13
	.p2align 4
	.p2align 3
.L215:
	movq	(%rbx), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	addq	$8, %rbx
	movzbl	%al, %eax
	orl	%eax, %r12d
	cmpq	%rbx, %r13
	jne	.L215
.L214:
	movq	current_program(%rip), %r13
	testq	%r13, %r13
	je	.L216
	movq	8(%r13), %r14
	xorl	%ebx, %ebx
	jmp	.L217
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L218:
	addq	$1, %rbx
.L217:
	cmpq	%rbx, %r14
	je	.L216
	movq	0(%r13), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$2, (%rax)
	jne	.L218
	movq	8(%rax), %rax
	movq	%rbp, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L218
.L227:
	movl	$1, %r12d
.L213:
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
.L216:
	.cfi_restore_state
	movq	%rbp, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L228
	leaq	8+names.0(%rip), %rbx
	leaq	.LC13(%rip), %rsi
	jmp	.L222
	.p2align 4,,10
	.p2align 3
.L243:
	movq	(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L223
.L222:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L243
	cmpl	$1, %r12d
	jne	.L213
.L223:
	testq	%r13, %r13
	je	.L213
	movq	8(%r13), %r14
	testq	%r14, %r14
	je	.L213
	movq	0(%r13), %r13
	xorl	%ebx, %ebx
	jmp	.L225
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L224:
	addq	$1, %rbx
	cmpq	%r14, %rbx
	je	.L213
.L225:
	movq	0(%r13,%rbx,8), %rax
	cmpl	$3, (%rax)
	jne	.L224
	movq	8(%rax), %r15
	movq	%rbp, %rsi
	movq	16(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L224
	movl	8(%r15), %eax
	movl	$2, %r12d
	testl	%eax, %eax
	jne	.L213
	jmp	.L227
	.p2align 4,,10
	.p2align 3
.L228:
	xorl	%r12d, %r12d
	jmp	.L213
	.p2align 4,,10
	.p2align 3
.L226:
	xorl	%r12d, %r12d
	jmp	.L214
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
	je	.L285
	movq	8+name_map(%rip), %r13
	movq	%rdi, %rbx
	testq	%r13, %r13
	je	.L246
	movq	name_map(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L248
	.p2align 4,,10
	.p2align 3
.L247:
	addq	$1, %rbp
	cmpq	%r13, %rbp
	je	.L246
.L248:
	movq	(%r14,%rbp,8), %r12
	movq	%rbx, %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L247
	movq	8(%r12), %rbp
.L244:
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
.L246:
	.cfi_restore_state
	cmpb	$0, (%rbx)
	je	.L316
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
	ja	.L251
	movabsq	$288230372997595135, %rsi
	btq	%rax, %rsi
	jnc	.L251
	movb	%dl, 0(%rbp)
.L255:
	leaq	1(%rbx), %r12
	leaq	(%rbx,%rcx), %r15
	movabsq	$288230372997595135, %r13
	cmpq	$1, %rcx
	ja	.L265
	jmp	.L257
	.p2align 4,,10
	.p2align 3
.L258:
	leal	-65(%rdx), %eax
	cmpb	$57, %al
	ja	.L261
	btq	%rax, %r13
	jnc	.L261
.L259:
	movb	%dl, (%r14)
	addq	$1, %r14
.L264:
	addq	$1, %r12
	cmpq	%r12, %r15
	je	.L257
.L265:
	movzbl	(%r12), %edx
	cmpb	$57, %dl
	jg	.L258
	cmpb	$47, %dl
	jg	.L259
	cmpb	$46, %dl
	jne	.L261
	addq	$1, %r12
	movb	$95, (%r14)
	addq	$1, %r14
	cmpq	%r12, %r15
	jne	.L265
.L257:
	movb	$0, (%r14)
	jmp	.L250
	.p2align 4,,10
	.p2align 3
.L316:
	leaq	.LC15(%rip), %rdi
	call	sdup@PLT
	movq	%rax, %rbp
.L250:
	leaq	8+names.0(%rip), %r13
	leaq	.LC13(%rip), %rsi
	movq	%r13, %r12
	jmp	.L267
	.p2align 4,,10
	.p2align 3
.L318:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L317
.L267:
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L318
.L266:
	movq	%rbp, %rdi
	call	strlen@PLT
	leaq	14(%rax), %rdi
	call	xmalloc@PLT
	leaq	.LC13(%rip), %rsi
	movq	%rax, %r12
	jmp	.L270
	.p2align 4,,10
	.p2align 3
.L320:
	movq	0(%r13), %rsi
	addq	$8, %r13
	testq	%rsi, %rsi
	je	.L319
.L270:
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L320
	movl	$114, %edx
.L269:
	xorl	%eax, %eax
	movq	%rbp, %rcx
	leaq	.LC18(%rip), %rsi
	movq	%r12, %rdi
	call	sprintf@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L321
.L271:
	movq	%r12, %rbp
.L284:
	leaq	8+c_keywords(%rip), %r12
	leaq	.LC14(%rip), %rsi
	jmp	.L273
	.p2align 4,,10
	.p2align 3
.L322:
	movq	(%r12), %rsi
	addq	$8, %r12
	testq	%rsi, %rsi
	je	.L274
.L273:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L322
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
	je	.L323
.L283:
	movq	%r12, %rbp
.L274:
	movq	8+name_map(%rip), %r13
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
	testq	%r13, %r13
	je	.L275
	movq	name_map(%rip), %r14
	xorl	%r12d, %r12d
	jmp	.L277
	.p2align 4,,10
	.p2align 3
.L325:
	addq	$1, %r12
	cmpq	%r12, %r13
	je	.L324
.L277:
	movq	(%r14,%r12,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L325
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
.L279:
	leal	1(%rcx), %eax
	movq	%rbp, %rdx
	leaq	.LC19(%rip), %rsi
	movq	%r13, %rdi
	movl	%eax, 12(%rsp)
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	8+name_map(%rip), %r12
	testq	%r12, %r12
	je	.L278
	movq	(%rsp), %rax
	xorl	%r15d, %r15d
	movq	(%rax), %r14
	jmp	.L280
	.p2align 4,,10
	.p2align 3
.L326:
	addq	$1, %r15
	cmpq	%r12, %r15
	je	.L278
.L280:
	movq	(%r14,%r15,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L326
	movl	12(%rsp), %ecx
	jmp	.L279
	.p2align 4,,10
	.p2align 3
.L317:
	movl	$6, %edx
	leaq	.LC21(%rip), %rsi
	movq	%rbx, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	je	.L266
	jmp	.L284
	.p2align 4,,10
	.p2align 3
.L324:
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
.L275:
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
	jmp	.L244
.L251:
	movb	$95, 0(%rbp)
	movzbl	(%rbx), %eax
	cmpb	$46, %al
	jne	.L327
	movb	$95, 1(%rbp)
	leaq	2(%rbp), %r14
	jmp	.L255
	.p2align 4,,10
	.p2align 3
.L261:
	movq	%r14, %rdi
	leaq	.LC17(%rip), %rsi
	xorl	%eax, %eax
	addq	$3, %r14
	call	sprintf@PLT
	jmp	.L264
	.p2align 4,,10
	.p2align 3
.L278:
	cmpq	$0, g_compilation_arena(%rip)
	je	.L328
.L281:
	movq	%r13, %rbp
	jmp	.L275
	.p2align 4,,10
	.p2align 3
.L319:
	movl	$120, %edx
	jmp	.L269
.L285:
	xorl	%ebp, %ebp
	jmp	.L244
.L321:
	movq	%rbp, %rdi
	call	free@PLT
	jmp	.L271
.L327:
	movzbl	%al, %edx
	movq	%r14, %rdi
	leaq	.LC16(%rip), %rsi
	xorl	%eax, %eax
	movq	%rcx, (%rsp)
	leaq	3(%rbp), %r14
	call	sprintf@PLT
	movq	(%rsp), %rcx
	jmp	.L255
.L323:
	movq	%rbp, %rdi
	call	free@PLT
	jmp	.L283
.L328:
	movq	%rbp, %rdi
	call	free@PLT
	jmp	.L281
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
	jne	.L332
	jmp	.L339
	.p2align 4,,10
	.p2align 3
.L340:
	movq	(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L333
.L332:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L340
	movq	%rbp, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L341
.L333:
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
.L339:
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
.L341:
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
.LFB59:
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
	je	.L350
	movl	$0, 12(%rsp)
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L348:
	leaq	g_known_functions(%rip), %rax
	leaq	.LC22(%rip), %rsi
	movq	(%rax), %rax
	movq	(%rax,%r12,8), %rbx
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L344
	leaq	.LC25(%rip), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L344
	movq	8(%r14), %rcx
	movq	(%r14), %r15
	testq	%rcx, %rcx
	je	.L345
	xorl	%r13d, %r13d
	jmp	.L347
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L346:
	addq	$1, %r13
	cmpq	%r13, %rcx
	je	.L345
.L347:
	movq	(%r15,%r13,8), %rax
	cmpl	$1, (%rax)
	jne	.L346
	movq	8(%rax), %rax
	movq	%rbx, %rsi
	movq	%rcx, (%rsp)
	movq	(%rax), %rdi
	call	strcmp@PLT
	movq	(%rsp), %rcx
	testl	%eax, %eax
	jne	.L346
	.p2align 4
	.p2align 3
.L344:
	addq	$1, %r12
	cmpq	8+g_known_functions(%rip), %r12
	jb	.L348
.L388:
	movl	12(%rsp), %eax
	testl	%eax, %eax
	je	.L350
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
.L350:
	cmpq	$0, 8(%r14)
	je	.L342
	xorl	%r12d, %r12d
	leaq	.LC30(%rip), %r15
	jmp	.L359
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L352:
	addq	$1, %r12
	cmpq	8(%r14), %r12
	jnb	.L342
.L359:
	movq	(%r14), %rax
	movq	(%rax,%r12,8), %rax
	cmpl	$1, (%rax)
	jne	.L352
	movq	8(%rax), %r13
	leaq	.LC22(%rip), %rsi
	movq	0(%r13), %rbx
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L353
	leaq	.LC25(%rip), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L354
.L353:
	movq	%rbp, %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC28(%rip), %rdi
	call	fwrite@PLT
.L358:
	xorl	%ebx, %ebx
	cmpq	$0, 16(%r13)
	jne	.L355
	jmp	.L356
	.p2align 4,,10
	.p2align 3
.L387:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
.L355:
	movq	%rbp, %rcx
	movl	$4, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
	addq	$1, %rbx
	cmpq	16(%r13), %rbx
	jb	.L387
.L356:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC32(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r14), %r12
	jb	.L359
.L342:
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
.L345:
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
	jb	.L348
	jmp	.L388
	.p2align 4,,10
	.p2align 3
.L354:
	leaq	.LC29(%rip), %rdi
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	0(%r13), %rdi
	testq	%rdi, %rdi
	je	.L357
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L357:
	movq	%rbp, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L358
	.cfi_endproc
.LFE59:
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
.LFB68:
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
	je	.L422
.L390:
	movq	%rbx, %rdi
	call	global_data_kind
	movq	%rbx, %rdi
	cmpl	$2, %eax
	je	.L423
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	40(%r12), %rdi
	call	global_data_kind
	cmpl	$1, %eax
	je	.L424
.L399:
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
.L422:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L390
	movq	8+g_known_variables(%rip), %r14
	testq	%r14, %r14
	je	.L391
	movq	g_known_variables(%rip), %r15
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L392:
	movq	(%r15,%r13,8), %rdi
	movq	%rbx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L390
	addq	$1, %r13
	cmpq	%r14, %r13
	jne	.L392
.L391:
	movq	current_program(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L393
	movq	8(%rax), %rax
	xorl	%r13d, %r13d
	movq	%rax, 16(%rsp)
	jmp	.L394
	.p2align 4,,10
	.p2align 3
.L395:
	testl	%eax, %eax
	je	.L425
.L396:
	addq	$1, %r13
.L394:
	cmpq	%r13, 16(%rsp)
	je	.L393
	movq	24(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r13,8), %rdx
	movl	(%rdx), %eax
	cmpl	$2, %eax
	jne	.L395
	movq	8(%rdx), %rax
	movq	%rbx, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L396
	jmp	.L390
	.p2align 4,,10
	.p2align 3
.L423:
	call	get_mangled_name
	leaq	.LC36(%rip), %rsi
	movq	%rbp, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L399
.L393:
	movq	%rbp, %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC35(%rip), %rdi
	call	fwrite@PLT
	jmp	.L399
	.p2align 4,,10
	.p2align 3
.L425:
	movq	8(%rdx), %rax
	movq	24(%rax), %rcx
	movq	%rcx, 8(%rsp)
	testq	%rcx, %rcx
	je	.L396
	movq	16(%rax), %r14
	xorl	%r15d, %r15d
	jmp	.L397
	.p2align 4,,10
	.p2align 3
.L426:
	movq	8(%rsp), %rax
	addq	$1, %r15
	cmpq	%rax, %r15
	je	.L396
.L397:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L426
	jmp	.L390
	.p2align 4,,10
	.p2align 3
.L424:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC37(%rip), %rdi
	call	fwrite@PLT
	jmp	.L399
	.cfi_endproc
.LFE68:
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
	jle	.L432
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
.L429:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L429
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
.L432:
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
	jne	.L435
	testq	%rdx, %rdx
	jne	.L443
.L435:
	ret
	.p2align 4,,10
	.p2align 3
.L443:
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
	jne	.L445
	jmp	.L452
	.p2align 4,,10
	.p2align 3
.L460:
	movq	%r13, %rsi
	movq	%r12, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L448:
	movzbl	1(%rbp), %ebx
	addq	$1, %rbp
	testb	%bl, %bl
	je	.L452
.L445:
	cmpb	$92, %bl
	je	.L453
	cmpb	$34, %bl
	je	.L453
	cmpb	$10, %bl
	je	.L458
	cmpb	$9, %bl
	je	.L459
	movzbl	%bl, %edx
	cmpb	$31, %bl
	jbe	.L460
	movq	%r12, %rsi
	movl	%edx, %edi
	addq	$1, %rbp
	call	fputc@PLT
	movzbl	0(%rbp), %ebx
	testb	%bl, %bl
	jne	.L445
.L452:
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
.L453:
	.cfi_restore_state
	movq	%r12, %rsi
	movl	$92, %edi
	call	fputc@PLT
	movzbl	%bl, %edi
	movq	%r12, %rsi
	call	fputc@PLT
	jmp	.L448
	.p2align 4,,10
	.p2align 3
.L458:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	jmp	.L448
	.p2align 4,,10
	.p2align 3
.L459:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC41(%rip), %rdi
	call	fwrite@PLT
	jmp	.L448
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
	ja	.L461
	movl	(%rsi), %eax
	movq	%rdx, %rbp
	leaq	.L464(%rip), %rdx
	movq	%rsi, %r15
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L464:
	.long	.L474-.L464
	.long	.L473-.L464
	.long	.L472-.L464
	.long	.L471-.L464
	.long	.L470-.L464
	.long	.L469-.L464
	.long	.L468-.L464
	.long	.L467-.L464
	.long	.L466-.L464
	.long	.L465-.L464
	.long	.L463-.L464
	.text
	.p2align 4,,10
	.p2align 3
.L465:
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
.L815:
	movq	%rbp, %rdx
.L816:
	movq	%rbx, %rdi
	call	emit_expr
.L817:
	movq	%rbx, %rsi
.L820:
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
.L463:
	.cfi_restore_state
	movq	(%rsp), %rbx
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
.L819:
	movq	40(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rdi
.L818:
	call	fwrite@PLT
	movq	48(%r15), %rsi
	jmp	.L815
	.p2align 4,,10
	.p2align 3
.L474:
	movq	40(%rsi), %rdx
	leaq	.LC65(%rip), %rsi
.L813:
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
.L473:
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
.L472:
	.cfi_restore_state
	movq	8+function_labels(%rip), %r13
	movq	40(%rsi), %r12
	testq	%r13, %r13
	je	.L475
	movq	function_labels(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L478
	.p2align 4,,10
	.p2align 3
.L476:
	addq	$1, %rbp
	cmpq	%r13, %rbp
	je	.L475
.L478:
	movq	(%r14,%rbp,8), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L476
	movl	%ebp, %edx
	addl	$1, %edx
	je	.L475
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
.L471:
	.cfi_restore_state
	movl	24(%rsi), %r10d
	testl	%r10d, %r10d
	jne	.L825
	movq	40(%rsi), %rax
	cmpl	$2, (%rax)
	movq	40(%rax), %r12
	je	.L826
	movb	$0, 39(%rsp)
	xorl	%ebx, %ebx
	xorl	%r14d, %r14d
	movq	$0, 8(%rsp)
.L488:
	movq	(%rsp), %rdi
	movq	%r12, %rsi
	call	emit_function_name
.L498:
	movq	(%rsp), %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	56(%r15), %rdx
	movq	8(%rsp), %rcx
	cmpq	%rdx, %rcx
	jnb	.L499
	cmpb	$0, 39(%rsp)
	je	.L499
	movq	48(%r15), %rax
	movq	(%rax,%rcx,8), %rax
	testq	%rax, %rax
	je	.L527
	cmpl	$1, (%rax)
	je	.L827
.L527:
	movq	$0, 40(%rsp)
.L502:
	movq	%rdx, 16(%rsp)
	movq	(%rsp), %r12
	xorl	%r13d, %r13d
	movl	%ebx, 56(%rsp)
	movq	%rbp, 24(%rsp)
	testq	%r14, %r14
	je	.L637
.L832:
	movq	8(%rsp), %rax
	movl	current_byteptr(%rip), %ebp
	cmpq	%rax, %r13
	sete	%al
	testb	%al, 39(%rsp)
	jne	.L530
	movq	40(%rsp), %rax
	testq	%rax, %rax
	je	.L531
	movl	(%rax,%r13,4), %r8d
	testl	%r8d, %r8d
	jne	.L530
.L531:
	leaq	.LC84(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L534
	testq	%r13, %r13
	je	.L828
.L535:
	leaq	.LC86(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L537
	cmpq	$1, %r13
	jbe	.L829
.L539:
	leaq	.LC88(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L542
	cmpq	$2, %r13
	je	.L543
.L538:
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
	jne	.L830
	leaq	.LC91(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L550
	cmpq	$1, %r13
	jbe	.L551
.L549:
	leaq	.LC75(%rip), %rax
	movq	%r14, %rdi
	movq	%rax, %rsi
	movq	%rax, 64(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L552
	movb	$0, 48(%rsp)
.L553:
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
	jne	.L552
	leaq	.LC73(%rip), %rsi
	movq	%r14, %rdi
	movq	%rdx, 72(%rsp)
	call	strcmp@PLT
	movq	72(%rsp), %rdx
	testl	%eax, %eax
	jne	.L650
	cmpb	$0, 48(%rsp)
	je	.L650
.L558:
	testl	%ebx, %ebx
	jne	.L557
.L559:
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
.L604:
	testl	%ebx, %ebx
	jne	.L831
.L562:
	addq	$1, %r13
	cmpq	%r13, 16(%rsp)
	je	.L563
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
	testq	%r14, %r14
	jne	.L832
.L637:
	xorl	%ebx, %ebx
.L529:
	movq	48(%r15), %rax
	movq	24(%rsp), %rdx
	movq	%r12, %rdi
	movq	(%rax,%r13,8), %rsi
	call	emit_expr
	jmp	.L604
	.p2align 4,,10
	.p2align 3
.L470:
	movq	(%rsp), %rbx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC96(%rip), %rdi
	movq	%rbx, %rcx
	call	fwrite@PLT
	jmp	.L819
	.p2align 4,,10
	.p2align 3
.L469:
	movl	40(%rsi), %r12d
	cmpl	$32, %r12d
	je	.L833
	cmpl	$53, %r12d
	je	.L834
	leal	-36(%r12), %eax
	cmpl	$1, %eax
	jbe	.L835
	movq	(%rsp), %rbx
	cmpl	$31, %r12d
	jne	.L573
	movl	current_word_bits(%rip), %esi
	testl	%esi, %esi
	jne	.L836
.L573:
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
	jmp	.L821
	.p2align 4,,10
	.p2align 3
.L468:
	movq	48(%rsi), %r12
	movl	40(%rsi), %r13d
	testq	%r12, %r12
	je	.L574
	movl	(%r12), %eax
	cmpl	$4, %eax
	je	.L575
	cmpl	$5, %eax
	jne	.L574
	cmpl	$32, 40(%r12)
	je	.L575
	.p2align 4
	.p2align 3
.L574:
	movl	current_word_bits(%rip), %ecx
	testl	%ecx, %ecx
	je	.L576
.L575:
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
.L821:
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC95(%rip), %rdi
.L814:
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
.L467:
	.cfi_restore_state
	movl	40(%rsi), %r12d
	leal	-53(%r12), %eax
	cmpl	$1, %eax
	jbe	.L837
	movl	current_word_bits(%rip), %edx
	testl	%edx, %edx
	je	.L580
	leal	-28(%r12), %eax
	cmpl	$6, %eax
	ja	.L580
	leaq	.L582(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L582:
	.long	.L645-.L582
	.long	.L587-.L582
	.long	.L586-.L582
	.long	.L585-.L582
	.long	.L584-.L582
	.long	.L583-.L582
	.long	.L581-.L582
	.text
	.p2align 4,,10
	.p2align 3
.L466:
	movl	40(%rsi), %r12d
	movq	48(%rsi), %r13
	movq	56(%rsi), %r14
	leal	-47(%r12), %eax
	cmpl	$5, %eax
	jbe	.L838
	cmpl	$21, %r12d
	je	.L590
	testq	%r13, %r13
	je	.L591
	movl	0(%r13), %eax
	cmpl	$4, %eax
	je	.L592
	cmpl	$5, %eax
	je	.L839
.L591:
	movl	current_word_bits(%rip), %eax
	testl	%eax, %eax
	je	.L590
.L592:
	leal	-38(%r12), %eax
	cmpl	$8, %eax
	ja	.L590
	leaq	.L595(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L595:
	.long	.L603-.L595
	.long	.L602-.L595
	.long	.L601-.L595
	.long	.L600-.L595
	.long	.L599-.L595
	.long	.L598-.L595
	.long	.L597-.L595
	.long	.L646-.L595
	.long	.L594-.L595
	.text
	.p2align 4,,10
	.p2align 3
.L524:
	testq	%rdx, %rdx
	jne	.L527
	movq	(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	jne	.L528
.L461:
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
.L475:
	.cfi_restore_state
	movl	16(%r15), %ebx
	testl	%ebx, %ebx
	jne	.L840
	movl	12(%r15), %r11d
	testl	%r11d, %r11d
	jne	.L841
	movl	20(%r15), %eax
	cmpl	$2, %eax
	je	.L842
	testq	%r12, %r12
	je	.L482
	movq	%r12, %rdi
	call	get_mangled_name
	movq	(%rsp), %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movl	20(%r15), %eax
.L482:
	cmpl	$1, %eax
	jne	.L461
	movq	(%rsp), %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC37(%rip), %rdi
	jmp	.L814
	.p2align 4,,10
	.p2align 3
.L580:
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
	jmp	.L815
	.p2align 4,,10
	.p2align 3
.L826:
	leaq	.LC71(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L843
.L489:
	leaq	8+names.0(%rip), %r13
	leaq	.LC13(%rip), %rsi
	jmp	.L493
	.p2align 4,,10
	.p2align 3
.L845:
	movq	0(%r13), %rsi
	addq	$8, %r13
	testq	%rsi, %rsi
	je	.L844
.L493:
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L845
	movq	%r12, %rdi
	call	source_function
	xorl	$1, %eax
	movl	%eax, %ebx
.L622:
	leaq	.LC73(%rip), %rsi
	movq	%r12, %rdi
	movl	$1, %r13d
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L494
	leaq	.LC74(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L494
	leaq	.LC75(%rip), %rsi
	movq	%r12, %rdi
	xorl	%r13d, %r13d
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%r13b
.L494:
	leaq	.LC76(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	orl	%ebx, %eax
	je	.L846
.L495:
	leaq	.LC78(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L630
	leaq	.LC79(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L630
	leaq	.LC80(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L630
	leaq	.LC81(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L631
	movb	$0, 39(%rsp)
	movq	$0, 8(%rsp)
	.p2align 4
	.p2align 3
.L496:
	testl	%r13d, %r13d
	jne	.L847
	movq	%r12, %rdx
	movq	%r12, %r14
	testl	%ebx, %ebx
	je	.L488
.L615:
	movq	(%rsp), %rdi
	leaq	.LC24(%rip), %rsi
	xorl	%eax, %eax
	movq	%r12, %r14
	movl	%r13d, %ebx
	call	fprintf@PLT
	jmp	.L498
	.p2align 4,,10
	.p2align 3
.L840:
	movq	(%rsp), %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC35(%rip), %rdi
	jmp	.L814
	.p2align 4,,10
	.p2align 3
.L576:
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
	jmp	.L817
	.p2align 4,,10
	.p2align 3
.L835:
	movq	48(%rsi), %r13
	testq	%r13, %r13
	je	.L569
	movl	0(%r13), %eax
	cmpl	$4, %eax
	je	.L570
	cmpl	$5, %eax
	je	.L848
.L569:
	movl	current_word_bits(%rip), %edi
	testl	%edi, %edi
	je	.L571
.L570:
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
	jmp	.L821
.L587:
	leaq	.LC52(%rip), %rdx
	.p2align 4
	.p2align 3
.L588:
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
	jmp	.L815
.L645:
	leaq	.LC53(%rip), %rdx
	jmp	.L588
.L581:
	leaq	.LC54(%rip), %rdx
	jmp	.L588
.L586:
	leaq	.LC49(%rip), %rdx
	jmp	.L588
.L583:
	leaq	.LC55(%rip), %rdx
	jmp	.L588
.L584:
	leaq	.LC51(%rip), %rdx
	jmp	.L588
.L585:
	leaq	.LC50(%rip), %rdx
	jmp	.L588
.L646:
	leaq	.LC58(%rip), %r12
	.p2align 4
	.p2align 3
.L596:
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
	jmp	.L816
.L594:
	leaq	.LC57(%rip), %r12
	jmp	.L596
.L603:
	leaq	.LC56(%rip), %r12
	jmp	.L596
.L601:
	leaq	.LC63(%rip), %r12
	jmp	.L596
.L602:
	leaq	.LC64(%rip), %r12
	jmp	.L596
.L597:
	leaq	.LC59(%rip), %r12
	jmp	.L596
.L598:
	leaq	.LC60(%rip), %r12
	jmp	.L596
.L599:
	leaq	.LC61(%rip), %r12
	jmp	.L596
.L600:
	leaq	.LC62(%rip), %r12
	jmp	.L596
	.p2align 4,,10
	.p2align 3
.L530:
	testl	%ebp, %ebp
	je	.L849
.L533:
	movq	%r12, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC92(%rip), %rdi
	call	fwrite@PLT
.L561:
	movl	$1, %ebx
	jmp	.L529
	.p2align 4,,10
	.p2align 3
.L831:
	movq	%r12, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L562
	.p2align 4,,10
	.p2align 3
.L849:
	testq	%r13, %r13
	sete	%bl
.L536:
	leaq	.LC73(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L649
	testb	%bl, %bl
	jne	.L556
.L649:
	leaq	.LC75(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L850
	cmpq	$1, %r13
	jne	.L533
.L556:
	movq	%r12, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC92(%rip), %rdi
	call	fwrite@PLT
.L560:
	movl	$1, %ebx
	jmp	.L559
	.p2align 4,,10
	.p2align 3
.L563:
	movl	56(%rsp), %ebx
	movq	(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	jne	.L526
.L565:
	movq	40(%rsp), %rax
	testq	%rax, %rax
	je	.L461
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
.L590:
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
	jmp	.L816
	.p2align 4,,10
	.p2align 3
.L499:
	testq	%r14, %r14
	je	.L524
	leaq	.LC83(%rip), %rsi
	movq	%r14, %rdi
	movq	%rdx, 16(%rsp)
	call	strcmp@PLT
	movq	16(%rsp), %rdx
	testl	%eax, %eax
	jne	.L524
	testq	%rdx, %rdx
	jne	.L527
	movq	(%rsp), %r14
	movl	$48, %edi
	movq	%r14, %rsi
	call	fputc@PLT
	movq	%r14, %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%ebx, %ebx
	je	.L461
.L528:
	xorl	%r9d, %r9d
	movq	%r9, 40(%rsp)
	.p2align 4
	.p2align 3
.L526:
	movq	(%rsp), %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L565
	.p2align 4,,10
	.p2align 3
.L537:
	leaq	.LC87(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L539
	cmpq	$1, %r13
	jne	.L539
	leaq	.LC91(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L810
.L551:
	testl	%ebp, %ebp
	jne	.L548
	movq	%r13, %rax
	xorq	$1, %rax
	movl	%eax, %edx
	andl	$1, %edx
.L547:
	leaq	.LC73(%rip), %rsi
	movq	%r14, %rdi
	movb	%dl, 48(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L651
	movzbl	48(%rsp), %edx
	testb	%dl, %dl
	jne	.L557
.L651:
	leaq	.LC75(%rip), %rsi
	movq	%r14, %rdi
	movl	$1, %ebx
	call	strcmp@PLT
	leaq	.LC74(%rip), %rdx
	testl	%eax, %eax
	je	.L851
.L612:
	movq	%rdx, %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L552
.L824:
	cmpq	$1, %r13
	je	.L558
	.p2align 4
	.p2align 3
.L552:
	testl	%ebx, %ebx
	je	.L529
.L548:
	movq	%r12, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC93(%rip), %rdi
	call	fwrite@PLT
	jmp	.L561
	.p2align 4,,10
	.p2align 3
.L850:
	leaq	.LC74(%rip), %rdx
	movq	%r14, %rdi
	movq	%rdx, %rsi
	call	strcmp@PLT
	cmpq	$1, %r13
	jne	.L533
	testl	%eax, %eax
	je	.L556
	jmp	.L533
	.p2align 4,,10
	.p2align 3
.L534:
	leaq	.LC85(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%bl
	testq	%r13, %r13
	sete	%al
	andb	%al, %bl
	je	.L535
	testl	%ebp, %ebp
	je	.L536
	jmp	.L533
	.p2align 4,,10
	.p2align 3
.L825:
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
	je	.L486
.L485:
	movq	48(%r15), %rax
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	emit_expr
	cmpq	56(%r15), %r12
	jnb	.L486
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	jmp	.L485
.L490:
	movq	(%rsp), %rbx
	leaq	-1(%r14), %rdx
	xorl	%eax, %eax
	xorl	%r12d, %r12d
	leaq	.LC72(%rip), %rsi
	leaq	.LC31(%rip), %r13
	movq	%rbx, %rdi
	call	fprintf@PLT
.L491:
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
	jne	.L491
	.p2align 4
	.p2align 3
.L486:
	movq	(%rsp), %rsi
	jmp	.L820
	.p2align 4,,10
	.p2align 3
.L838:
	movq	(%rsp), %rbx
	leaq	CSWTCH.150(%rip), %rdx
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
	jmp	.L821
	.p2align 4,,10
	.p2align 3
.L630:
	movb	$1, 39(%rsp)
	movq	$1, 8(%rsp)
	jmp	.L496
.L810:
	movb	$0, 48(%rsp)
	movl	$1, %ebx
.L550:
	leaq	.LC75(%rip), %rax
	movq	%r14, %rdi
	movq	%rax, %rsi
	movq	%rax, 64(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L553
	movzbl	48(%rsp), %eax
	orl	%eax, %ebx
	testl	%ebp, %ebp
	jne	.L552
	leaq	.LC73(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L824
	cmpb	$0, 48(%rsp)
	jne	.L558
	jmp	.L824
	.p2align 4,,10
	.p2align 3
.L542:
	leaq	.LC89(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L648
	cmpq	$2, %r13
	je	.L543
.L648:
	xorl	%ebx, %ebx
	jmp	.L538
.L543:
	leaq	.LC91(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L810
	movl	$1, %ebx
	jmp	.L549
	.p2align 4,,10
	.p2align 3
.L837:
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
.L841:
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
	jmp	.L817
.L839:
	cmpl	$32, 40(%r13)
	jne	.L591
	jmp	.L592
.L833:
	movq	(%rsp), %rbx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC97(%rip), %rdi
	movq	%rbx, %rcx
	jmp	.L818
.L828:
	testl	%ebp, %ebp
	jne	.L533
	movl	$1, %ebx
	jmp	.L536
.L844:
	xorl	%ebx, %ebx
	jmp	.L622
.L834:
	movq	(%rsp), %rbx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC33(%rip), %rdi
	movq	%rbx, %rcx
	jmp	.L818
.L836:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC100(%rip), %rdi
	jmp	.L818
.L843:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L489
	movq	56(%r15), %r14
	testq	%r14, %r14
	jne	.L490
	movq	(%rsp), %rdi
	xorl	%edx, %edx
	leaq	.LC72(%rip), %rsi
	call	fprintf@PLT
	jmp	.L486
.L846:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L495
	testl	%r13d, %r13d
	jne	.L852
	movb	$1, 39(%rsp)
	movq	%r12, %r14
	xorl	%ebx, %ebx
	movq	$0, 8(%rsp)
	jmp	.L488
.L851:
	cmpq	$1, %r13
	jne	.L548
.L557:
	movq	%r12, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC93(%rip), %rdi
	call	fwrite@PLT
	jmp	.L560
.L830:
	testl	%ebp, %ebp
	je	.L547
	jmp	.L548
.L847:
	movq	(%rsp), %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC77(%rip), %rdi
	call	fwrite@PLT
	movq	40(%r15), %rax
	movq	40(%rax), %rdx
	testl	%ebx, %ebx
	je	.L632
	cmpl	$2, (%rax)
	je	.L853
	movq	%r12, %r14
	movq	%rdx, %r12
	jmp	.L488
.L842:
	movq	%r12, %rdi
	call	get_mangled_name
	leaq	.LC36(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L813
.L829:
	movl	$1, %ebx
	jmp	.L538
.L827:
	movq	%rdx, %rdi
	movl	$4, %esi
	movq	%rdx, 16(%rsp)
	movq	40(%rax), %r12
	call	calloc@PLT
	movq	16(%rsp), %rdx
	testq	%rax, %rax
	movq	%rax, 40(%rsp)
	je	.L527
	movq	8(%rsp), %rax
	xorl	%r13d, %r13d
	leaq	1(%rax), %rsi
	movzbl	(%r12), %eax
	testb	%al, %al
	je	.L502
	movq	%r14, 24(%rsp)
	movl	%ebx, 16(%rsp)
	movq	%rsi, %rbx
	movq	%rbp, 48(%rsp)
	movq	%r12, %rbp
	movq	%rdx, %r12
	.p2align 4
	.p2align 3
.L501:
	cmpb	$37, %al
	jne	.L806
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	cmpb	$37, %r14b
	je	.L806
	testb	%r14b, %r14b
	jne	.L504
	jmp	.L804
	.p2align 4,,10
	.p2align 3
.L507:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	testb	%r14b, %r14b
	je	.L506
.L504:
	movsbl	%r14b, %esi
	leaq	.LC82(%rip), %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L507
	cmpb	$42, %r14b
	jne	.L506
	cmpq	%r12, %rbx
	adcq	$0, %rbx
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %edx
.L511:
	cmpb	$46, %dl
	je	.L854
.L514:
	cmpb	$104, %dl
	je	.L855
	cmpb	$108, %dl
	jne	.L521
	cmpb	$108, 1(%rbp,%r13)
	leaq	1(%r13), %rax
	je	.L636
.L519:
	addq	$1, %rbx
.L503:
	movq	%rax, %r13
	movzbl	0(%rbp,%rax), %eax
	testb	%al, %al
	jne	.L501
.L804:
	movl	16(%rsp), %ebx
	movq	24(%rsp), %r14
	movq	%r12, %rdx
	movq	48(%rsp), %rbp
	jmp	.L502
	.p2align 4,,10
	.p2align 3
.L806:
	leaq	1(%r13), %rax
	jmp	.L503
.L506:
	movzbl	0(%rbp,%r13), %edx
	testb	%dl, %dl
	movb	%dl, 56(%rsp)
	je	.L804
	call	__ctype_b_loc@PLT
	movzbl	56(%rsp), %edx
	movq	(%rax), %rax
	jmp	.L509
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L513:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %edx
	testb	%dl, %dl
	je	.L804
.L509:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L513
	movzbl	0(%rbp,%r13), %edx
	jmp	.L511
.L855:
	cmpb	$104, 1(%rbp,%r13)
	leaq	1(%r13), %rax
	jne	.L519
.L636:
	leaq	2(%r13), %rax
	jmp	.L519
.L854:
	movzbl	1(%rbp,%r13), %edx
	leaq	1(%r13), %rdi
	movq	%rdi, 56(%rsp)
	cmpb	$42, %dl
	jne	.L856
	cmpq	%r12, %rbx
	adcq	$0, %rbx
	addq	$2, %r13
	movzbl	0(%rbp,%r13), %edx
	jmp	.L514
.L521:
	testb	%dl, %dl
	je	.L804
	leaq	1(%r13), %rax
	cmpb	$115, %dl
	jne	.L519
	cmpq	%r12, %rbx
	jnb	.L519
	movq	40(%rsp), %rcx
	movl	$1, (%rcx,%rbx,4)
	jmp	.L519
.L571:
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
	jmp	.L816
.L848:
	cmpl	$32, 40(%r13)
	jne	.L569
	jmp	.L570
.L856:
	testb	%dl, %dl
	movb	%dl, 64(%rsp)
	je	.L804
	call	__ctype_b_loc@PLT
	movzbl	64(%rsp), %edx
	movq	56(%rsp), %rdi
	movq	(%rax), %rax
	jmp	.L516
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L518:
	addq	$1, %rdi
	movzbl	0(%rbp,%rdi), %edx
	testb	%dl, %dl
	je	.L804
.L516:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L518
	movzbl	0(%rbp,%rdi), %edx
	movq	%rdi, %r13
	jmp	.L514
.L852:
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
	jmp	.L488
.L631:
	movb	$1, 39(%rsp)
	movq	$2, 8(%rsp)
	jmp	.L496
.L632:
	movq	%r12, %r14
	movl	%r13d, %ebx
	movq	%rdx, %r12
	jmp	.L488
.L650:
	movq	64(%rsp), %rsi
	movq	%r14, %rdi
	movq	%rdx, 48(%rsp)
	call	strcmp@PLT
	movq	48(%rsp), %rdx
	testl	%eax, %eax
	jne	.L612
	jmp	.L824
.L853:
	movl	%ebx, %r13d
	jmp	.L615
	.cfi_endproc
.LFE47:
	.size	emit_expr, .-emit_expr
	.p2align 4
	.globl	emit_ival_expr
	.type	emit_ival_expr, @function
emit_ival_expr:
.LFB48:
	.cfi_startproc
	cmpl	$2, (%rsi)
	je	.L859
	jmp	emit_expr
	.p2align 4,,10
	.p2align 3
.L859:
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
	je	.L860
	cmpl	$1, (%rdi)
	je	.L864
.L860:
	ret
	.p2align 4,,10
	.p2align 3
.L864:
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
	je	.L897
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
	je	.L867
	ja	.L868
	testl	%eax, %eax
	je	.L869
	cmpl	$5, %eax
	jne	.L877
	movq	48(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L865
	movl	40(%rbx), %eax
	cmpl	$31, %eax
	je	.L873
	cmpl	$35, %eax
	je	.L874
	.p2align 4
	.p2align 3
.L877:
	xorl	%eax, %eax
.L865:
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
.L868:
	.cfi_restore_state
	cmpl	$10, %eax
	jne	.L877
	movq	40(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L865
	movq	48(%rbx), %rdi
	movq	%rbp, %rsi
	call	try_eval_const_expr
	jmp	.L865
	.p2align 4,,10
	.p2align 3
.L897:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L869:
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
.L867:
	.cfi_restore_state
	movq	48(%rdi), %rdi
	movq	%rsp, %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L877
	movq	56(%rbx), %rdi
	leaq	8(%rsp), %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L877
	movl	40(%rbx), %eax
	subl	$22, %eax
	cmpl	$33, %eax
	ja	.L877
	leaq	.L880(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L880:
	.long	.L893-.L880
	.long	.L892-.L880
	.long	.L891-.L880
	.long	.L890-.L880
	.long	.L889-.L880
	.long	.L888-.L880
	.long	.L877-.L880
	.long	.L877-.L880
	.long	.L887-.L880
	.long	.L886-.L880
	.long	.L885-.L880
	.long	.L884-.L880
	.long	.L883-.L880
	.long	.L877-.L880
	.long	.L877-.L880
	.long	.L877-.L880
	.long	.L877-.L880
	.long	.L877-.L880
	.long	.L877-.L880
	.long	.L877-.L880
	.long	.L877-.L880
	.long	.L877-.L880
	.long	.L877-.L880
	.long	.L877-.L880
	.long	.L877-.L880
	.long	.L877-.L880
	.long	.L877-.L880
	.long	.L877-.L880
	.long	.L877-.L880
	.long	.L877-.L880
	.long	.L877-.L880
	.long	.L882-.L880
	.long	.L881-.L880
	.long	.L879-.L880
	.text
	.p2align 4,,10
	.p2align 3
.L874:
	xorl	%eax, %eax
	cmpq	$0, 8(%rsp)
	sete	%al
	movq	%rax, 0(%rbp)
.L895:
	movl	$1, %eax
	jmp	.L865
.L879:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L895
.L881:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L895
.L882:
	movq	(%rsp), %rax
	andq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L895
.L883:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L877
	movq	(%rsp), %rax
	cqto
	idivq	%rcx
	movq	%rdx, 0(%rbp)
	jmp	.L895
.L884:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L877
	movq	(%rsp), %rax
	cqto
	idivq	%rcx
	movq	%rax, 0(%rbp)
	jmp	.L895
.L885:
	movq	(%rsp), %rax
	imulq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L895
.L886:
	movq	(%rsp), %rax
	subq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L895
.L887:
	movq	8(%rsp), %rax
	addq	(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L895
.L888:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setge	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L895
.L889:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setg	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L895
.L890:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setle	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L895
.L891:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setl	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L895
.L892:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L895
.L893:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	sete	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L895
	.p2align 4,,10
	.p2align 3
.L873:
	movq	8(%rsp), %rax
	negq	%rax
	movq	%rax, 0(%rbp)
	jmp	.L895
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
	je	.L919
	cmpl	$1, (%rdi)
	je	.L923
.L919:
	ret
	.p2align 4,,10
	.p2align 3
.L923:
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
	je	.L924
	cmpl	$1, (%rdi)
	je	.L929
.L924:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L929:
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
	je	.L942
	cmpl	$1, (%rdi)
	jne	.L942
	movq	24(%rdi), %rcx
	movq	16(%rdi), %r8
	testq	%rcx, %rcx
	je	.L942
	xorl	%edx, %edx
	jmp	.L943
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L945:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L942
.L943:
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L945
	cmpl	$1, (%rax)
	jne	.L945
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
.L946:
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r9
.L932:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L949
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L932
	cmpl	$1, (%rax)
	jne	.L932
	jmp	.L946
	.p2align 4,,10
	.p2align 3
.L942:
	.cfi_def_cfa_offset 8
	movq	%r9, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L949:
	.cfi_def_cfa_offset 16
	movq	%r9, %rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE53:
	.size	edge_tail_words_top, .-edge_tail_words_top
	.section	.rodata.str1.1
.LC110:
	.string	"%s[%zu] = "
.LC111:
	.string	";\n"
.LC112:
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
	je	.L951
	cmpl	$1, (%rcx)
	movq	%rcx, %r15
	jne	.L951
	cmpq	$0, 24(%rcx)
	je	.L951
	movq	%rsi, (%rsp)
	movq	%rdi, %rbx
	movl	%r9d, %ebp
	xorl	%r13d, %r13d
	movq	%r8, 8(%rsp)
.L964:
	movq	16(%r15), %rax
	movq	(%rax,%r13,8), %r10
	testq	%r10, %r10
	je	.L959
	movl	(%r10), %eax
	testl	%eax, %eax
	je	.L983
	cmpl	$1, %eax
	je	.L984
.L959:
	addq	$1, %r13
	addq	$1, %r12
	cmpq	24(%r15), %r13
	jb	.L964
	movq	8(%rsp), %rdx
.L951:
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
.L983:
	.cfi_restore_state
	xorl	%r14d, %r14d
	testl	%ebp, %ebp
	jle	.L957
	movq	%r12, 16(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L954:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC38(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L954
	movq	16(%rsp), %r12
	movq	%r14, %r10
.L957:
	movq	(%rsp), %rdx
	leaq	.LC110(%rip), %rsi
	xorl	%eax, %eax
	movq	%r12, %rcx
	movq	%rbx, %rdi
	movq	%r10, 16(%rsp)
	call	fprintf@PLT
	movq	16(%rsp), %r10
	movq	16(%r10), %rsi
	cmpl	$2, (%rsi)
	je	.L985
	movq	96(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L958:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC111(%rip), %rdi
	call	fwrite@PLT
	jmp	.L959
	.p2align 4,,10
	.p2align 3
.L984:
	movq	24(%r10), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmovne	%rax, %rdx
	xorl	%r14d, %r14d
	movq	%rdx, 16(%rsp)
	testl	%ebp, %ebp
	jle	.L963
	movq	%r12, 24(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L960:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC38(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L960
	movq	24(%rsp), %r12
	movq	%r14, %r10
.L963:
	movq	8(%rsp), %r14
	movq	(%rsp), %r8
	movq	%r12, %rcx
	movq	%rbx, %rdi
	leaq	.LC112(%rip), %rsi
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
	jne	.L961
	movq	24(%r10), %rsi
	movq	16(%r10), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, 8(%rsp)
.L961:
	movq	8(%rsp), %rax
	cmpq	%rdx, %rax
	cmovnb	%rax, %rdx
	movq	%rdx, 8(%rsp)
	jmp	.L959
	.p2align 4,,10
	.p2align 3
.L985:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L958
	.cfi_endproc
.LFE54:
	.size	emit_edge_list_init, .-emit_edge_list_init
	.section	.rodata.str1.8
	.align 8
.LC113:
	.string	"static void __attribute__((constructor(101))) __b_register_globals(void) {\n"
	.align 8
.LC114:
	.string	"    (void)B_PTR_N(%s, sizeof(%s));\n"
	.align 8
.LC115:
	.string	"    (void)B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC116:
	.string	"}\n"
	.section	.rodata.str1.8
	.align 8
.LC117:
	.string	"static void __b_initialize_globals(void) {\n"
	.align 8
.LC118:
	.string	"    %s[0] = B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC119:
	.string	"__%s_store"
.LC120:
	.string	"    %s[0] = "
	.section	.rodata.str1.8
	.align 8
.LC121:
	.string	"}\nstatic struct __bcc_initializer __bcc_module = {__b_initialize_globals, 0, 0};\nstatic void __attribute__((constructor(102))) __bcc_register_module(void) {\n    __bcc_register_initializer(&__bcc_module);\n}\n\n"
	.text
	.p2align 4
	.type	emit_global_initializers, @function
emit_global_initializers:
.LFB61:
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
	je	.L1021
.L987:
	movq	%r12, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%rbp)
	je	.L993
	xorl	%ebx, %ebx
	jmp	.L1004
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L995:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L993
.L1004:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$2, (%rax)
	jne	.L995
	movq	8(%rax), %r14
	movq	16(%r14), %rdi
	call	get_mangled_name
	cmpl	$2, 24(%r14)
	movq	56(%r14), %r15
	movq	%rax, %r10
	je	.L1022
	testq	%r15, %r15
	je	.L995
	movl	(%r15), %eax
	cmpl	$1, %eax
	je	.L1023
	testl	%eax, %eax
	jne	.L995
	leaq	.LC120(%rip), %rsi
	movq	%r10, %rdx
	movq	%r12, %rdi
	call	fprintf@PLT
	movq	16(%r15), %rsi
	cmpl	$2, (%rsi)
	je	.L1024
	movq	%r13, %rdx
	movq	%r12, %rdi
	call	emit_expr
.L1003:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addq	$1, %rbx
	leaq	.LC111(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%rbp), %rbx
	jb	.L1004
.L993:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rcx
	movl	$207, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC121(%rip), %rdi
	popq	%rbp
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
.L1022:
	.cfi_restore_state
	movq	%rax, 8(%rsp)
	movq	%rax, %r8
	movq	%rax, %rcx
	movq	%rax, %rdx
	leaq	.LC118(%rip), %rsi
	xorl	%eax, %eax
	movq	%r12, %rdi
	call	fprintf@PLT
	testq	%r15, %r15
	je	.L995
	cmpl	$1, (%r15)
	movq	8(%rsp), %r10
	jne	.L995
	movq	%r10, %rsi
	leaq	.LC119(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	xorl	%r8d, %r8d
	movq	%rax, %rsi
	movq	56(%r14), %rax
	testq	%rax, %rax
	je	.L998
	cmpl	$1, (%rax)
	je	.L1025
.L998:
	cmpq	$0, 32(%r14)
	je	.L999
	movq	48(%r14), %rax
	movq	%r8, %rdx
	cmpq	%rax, %r8
	cmovb	%rax, %r8
	testq	%rax, %rax
	cmovle	%rdx, %r8
.L999:
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
	jmp	.L995
	.p2align 4,,10
	.p2align 3
.L1023:
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
	jmp	.L995
	.p2align 4,,10
	.p2align 3
.L1021:
	movq	%rdi, %rcx
	movl	$75, %edx
	movl	$1, %esi
	leaq	.LC113(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%rbp)
	je	.L988
	xorl	%ebx, %ebx
	jmp	.L992
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L990:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L988
.L992:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$2, (%rax)
	jne	.L990
	movq	8(%rax), %r14
	movq	16(%r14), %rdi
	call	get_mangled_name
	leaq	.LC114(%rip), %rsi
	movq	%r12, %rdi
	movq	%rax, %rcx
	movq	%rax, %rdx
	movq	%rax, %r15
	xorl	%eax, %eax
	call	fprintf@PLT
	cmpl	$2, 24(%r14)
	jne	.L990
	movq	%r15, %rcx
	movq	%r15, %rdx
	leaq	.LC115(%rip), %rsi
	movq	%r12, %rdi
	xorl	%eax, %eax
	addq	$1, %rbx
	call	fprintf@PLT
	cmpq	8(%rbp), %rbx
	jb	.L992
	.p2align 4
	.p2align 3
.L988:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC116(%rip), %rdi
	call	fwrite@PLT
	jmp	.L987
.L1024:
	movq	%r12, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1003
.L1025:
	movq	24(%rax), %r8
	jmp	.L998
	.cfi_endproc
.LFE61:
	.size	emit_global_initializers, .-emit_global_initializers
	.section	.rodata.str1.1
.LC122:
	.string	"<"
.LC123:
	.string	"<="
.LC124:
	.string	">"
.LC125:
	.string	">="
.LC126:
	.string	"??"
.LC127:
	.string	"while ("
.LC128:
	.string	")\n"
.LC129:
	.string	"if ("
.LC130:
	.string	"switch ("
.LC131:
	.string	") {\n"
.LC132:
	.string	"continue;\n"
.LC133:
	.string	"break;\n"
.LC134:
	.string	"return"
.LC135:
	.string	"{\n"
.LC136:
	.string	"return "
.LC137:
	.string	"word __%s_store[("
.LC138:
	.string	")];\n"
.LC139:
	.string	"word %s;\n"
	.section	.rodata.str1.8
	.align 8
.LC140:
	.string	"(void)B_LOCAL_PTR_N(&%s, sizeof(%s));\n"
	.align 8
.LC141:
	.string	"%s = B_LOCAL_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC142:
	.string	"word %s = 0;\n"
.LC143:
	.string	"else\n"
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
.LFB55:
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
	leaq	.L1031(%rip), %r12
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
.L1027:
	movl	g_no_line(%rip), %eax
	testl	%eax, %eax
	jne	.L1028
	cmpb	$0, 24(%rsp)
	jne	.L1322
.L1028:
	cmpl	$12, (%rbx)
	ja	.L1026
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1031:
	.long	.L1042-.L1031
	.long	.L1041-.L1031
	.long	.L1040-.L1031
	.long	.L1039-.L1031
	.long	.L1038-.L1031
	.long	.L1037-.L1031
	.long	.L1036-.L1031
	.long	.L1026-.L1031
	.long	.L1035-.L1031
	.long	.L1034-.L1031
	.long	.L1033-.L1031
	.long	.L1032-.L1031
	.long	.L1030-.L1031
	.text
	.p2align 4,,10
	.p2align 3
.L1322:
	movl	4(%rbx), %edx
	movq	16(%rsp), %rcx
	movq	%r15, %rdi
	xorl	%eax, %eax
	leaq	.LC39(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1028
	.p2align 4,,10
	.p2align 3
.L1030:
	movl	g_switch_id(%rip), %eax
	xorl	%ebp, %ebp
	leaq	.LC146(%rip), %r14
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
	je	.L1119
	movq	%rbx, 56(%rsp)
	movq	24(%rsp), %r13
	movq	%r15, 48(%rsp)
	movq	%rbp, %r15
	movq	40(%rsp), %rbp
	.p2align 4
	.p2align 3
.L1116:
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
	jb	.L1116
	movq	48(%rsp), %r15
	movq	56(%rsp), %rbx
.L1119:
	movl	8(%rsp), %edx
	movl	8(%rsp), %r14d
	xorl	%ebp, %ebp
	leaq	.LC38(%rip), %r13
	testl	%edx, %edx
	jle	.L1323
	.p2align 4
	.p2align 3
.L1117:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r14d
	jne	.L1117
	movq	%r15, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC147(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r14d
.L1120:
	xorl	%r8d, %r8d
	movl	8(%rsp), %ebp
	movq	%rbx, 48(%rsp)
	movl	%r8d, %ebx
	.p2align 4
	.p2align 3
.L1123:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1123
	movq	48(%rsp), %rbx
	movq	%r15, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	leaq	.LC111(%rip), %rax
	movq	%r15, %rcx
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
.L1124:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1124
	movl	32(%rsp), %edx
	leaq	.LC150(%rip), %rsi
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
.L1125:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1125
	leaq	.LC151(%rip), %rax
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
.L1126:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1126
	movl	32(%rsp), %edx
	xorl	%eax, %eax
	leaq	.LC158(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r12)
	leal	2(%rax), %ebx
	je	.L1128
.L1164:
	leaq	.LC129(%rip), %rax
	movq	%r12, 16(%rsp)
	xorl	%r13d, %r13d
	leaq	.LC38(%rip), %rbp
	movq	%rax, 56(%rsp)
	movl	%r14d, 76(%rsp)
	.p2align 4
	.p2align 3
.L1142:
	movq	16(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r13,8), %r14
	movq	40(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1189
	xorl	%eax, %eax
	jmp	.L1133
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1132:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1189
.L1133:
	movq	(%rsi,%rax,8), %rdx
	cmpq	(%rdx), %r14
	jne	.L1132
	movq	8(%rdx), %rax
	movq	%rax, 24(%rsp)
.L1131:
	xorl	%r12d, %r12d
	testl	%ebx, %ebx
	jle	.L1137
	.p2align 4
	.p2align 3
.L1134:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%ebx, %r12d
	jne	.L1134
.L1137:
	movq	56(%rsp), %rdi
	movl	$1, %esi
	movq	%r15, %rcx
	movl	$4, %edx
	call	fwrite@PLT
	movl	20(%r14), %eax
	movq	24(%r14), %rsi
	testl	%eax, %eax
	je	.L1324
	leaq	.LC124(%rip), %rdx
	cmpl	$26, %eax
	je	.L1138
	ja	.L1139
	leaq	.LC122(%rip), %rdx
	cmpl	$24, %eax
	je	.L1138
	cmpl	$25, %eax
	leaq	.LC126(%rip), %rdx
	leaq	.LC123(%rip), %rax
	cmove	%rax, %rdx
.L1138:
	movq	%rsi, %rcx
	movq	%r15, %rdi
	xorl	%eax, %eax
	leaq	.LC152(%rip), %rsi
	call	fprintf@PLT
.L1140:
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	addq	$1, %r13
	leaq	.LC155(%rip), %rdi
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
	jb	.L1142
	movl	76(%rsp), %r14d
	leaq	.LC38(%rip), %r13
	testl	%ebx, %ebx
	jle	.L1325
.L1128:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1144:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1144
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	movl	8(%rsp), %r12d
	testl	%r14d, %r14d
	jle	.L1297
	.p2align 4
	.p2align 3
.L1145:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r12d
	jg	.L1145
.L1297:
	movl	32(%rsp), %edx
	leaq	.LC156(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	call	fprintf@PLT
	.p2align 4
	.p2align 3
.L1149:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1149
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	xorl	%ebx, %ebx
	leaq	.LC133(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	jle	.L1151
	.p2align 4
	.p2align 3
.L1152:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1152
.L1151:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC116(%rip), %rdi
	call	fwrite@PLT
.L1026:
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
.L1042:
	.cfi_restore_state
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	leaq	.LC38(%rip), %r13
	testl	%ebp, %ebp
	jle	.L1321
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
.L1321:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC111(%rip), %rdi
.L1320:
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
.L1041:
	.cfi_restore_state
	movl	8(%rsp), %r9d
	movl	8(%rsp), %r14d
	xorl	%r12d, %r12d
	leaq	.LC38(%rip), %r13
	testl	%r9d, %r9d
	jle	.L1326
	.p2align 4
	.p2align 3
.L1064:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r14d
	jne	.L1064
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC135(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L1069
.L1068:
	movl	8(%rsp), %edi
	xorl	%r13d, %r13d
	addl	$1, %edi
	movl	%edi, 40(%rsp)
.L1076:
	movq	16(%rbx), %rdx
	movq	(%rdx,%r13,8), %r12
	testl	%ebp, %ebp
	je	.L1179
	subq	$1, %rax
	xorl	%ecx, %ecx
	cmpq	%r13, %rax
	je	.L1327
.L1071:
	movq	16(%rsp), %r8
	movl	40(%rsp), %edx
	movq	%r12, %rsi
	movq	%r15, %rdi
	call	emit_stmt
.L1074:
	movq	24(%rbx), %rax
	addq	$1, %r13
	cmpq	%rax, %r13
	jb	.L1076
	movl	8(%rsp), %r8d
	leaq	.LC38(%rip), %r13
	testl	%r8d, %r8d
	jle	.L1078
.L1069:
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1079:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1079
.L1078:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC116(%rip), %rdi
	jmp	.L1320
	.p2align 4,,10
	.p2align 3
.L1040:
	xorl	%ecx, %ecx
	cmpq	$0, 24(%rbx)
	leaq	.LC38(%rip), %rbp
	je	.L1026
	movq	%rbx, 24(%rsp)
	movl	8(%rsp), %r12d
	movq	%rcx, %r14
	.p2align 4
	.p2align 3
.L1063:
	movq	24(%rsp), %rax
	movq	16(%rax), %rax
	movq	(%rax,%r14,8), %rbx
	movq	(%rbx), %rdi
	call	get_mangled_name
	cmpq	$0, 8(%rbx)
	movq	%rax, 8(%rsp)
	je	.L1328
	testl	%r12d, %r12d
	jle	.L1083
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1084:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%r13d, %r12d
	jne	.L1084
	movq	8(%rsp), %rdx
	leaq	.LC137(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	8(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	xorl	%ebx, %ebx
	call	emit_expr
	movq	%r15, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC138(%rip), %rdi
	call	fwrite@PLT
	.p2align 4
	.p2align 3
.L1085:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L1085
	movq	8(%rsp), %rdx
	xorl	%eax, %eax
	leaq	.LC139(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L1329
.L1086:
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1089:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L1089
.L1088:
	movq	8(%rsp), %rcx
	leaq	.LC141(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	%rcx, %r8
	movq	%rcx, %rdx
	call	fprintf@PLT
.L1090:
	movq	24(%rsp), %rax
	addq	$1, %r14
	cmpq	24(%rax), %r14
	jb	.L1063
	jmp	.L1026
	.p2align 4,,10
	.p2align 3
.L1329:
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1087:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L1087
	movq	8(%rsp), %rcx
	leaq	.LC140(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	%rcx, %rdx
	call	fprintf@PLT
	jmp	.L1086
	.p2align 4,,10
	.p2align 3
.L1039:
	movl	8(%rsp), %eax
	xorl	%r14d, %r14d
	leaq	.LC38(%rip), %r13
	testl	%eax, %eax
	jle	.L1096
	.p2align 4
	.p2align 3
.L1049:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%r14d, 8(%rsp)
	jne	.L1049
.L1096:
	movq	%r15, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC129(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC128(%rip), %rdi
	call	fwrite@PLT
	testl	%ebp, %ebp
	jne	.L1050
.L1051:
	movq	24(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L1097
	cmpl	$1, (%rsi)
	movl	8(%rsp), %edx
	je	.L1098
.L1097:
	movl	8(%rsp), %eax
	leal	1(%rax), %edx
.L1098:
	movq	16(%rsp), %r8
	movl	%ebp, %ecx
	movq	%r15, %rdi
	call	emit_stmt
	cmpq	$0, 32(%rbx)
	je	.L1026
	movl	8(%rsp), %ecx
	xorl	%ebp, %ebp
	leaq	.LC38(%rip), %r13
	testl	%ecx, %ecx
	jle	.L1102
	.p2align 4
	.p2align 3
.L1099:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, 8(%rsp)
	jne	.L1099
.L1102:
	movq	%r15, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC143(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L1047
	jmp	.L1048
	.p2align 4,,10
	.p2align 3
.L1038:
	movl	8(%rsp), %eax
	xorl	%ebp, %ebp
	leaq	.LC38(%rip), %r13
	testl	%eax, %eax
	jle	.L1104
	.p2align 4
	.p2align 3
.L1046:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, 8(%rsp)
	jne	.L1046
.L1104:
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC127(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC128(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L1048
.L1047:
	cmpl	$1, (%rbx)
	je	.L1103
.L1048:
	addl	$1, 8(%rsp)
.L1103:
	xorl	%ebp, %ebp
	jmp	.L1027
	.p2align 4,,10
	.p2align 3
.L1037:
	movl	8(%rsp), %r10d
	movl	8(%rsp), %r12d
	xorl	%ebp, %ebp
	leaq	.LC38(%rip), %r13
	testl	%r10d, %r10d
	jle	.L1105
	.p2align 4
	.p2align 3
.L1060:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1060
.L1105:
	movq	%r15, %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC134(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%rbx)
	je	.L1321
	movq	%r15, %rsi
	movl	$32, %edi
	call	fputc@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	jmp	.L1321
	.p2align 4,,10
	.p2align 3
.L1035:
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	leaq	.LC38(%rip), %r13
	testl	%ebp, %ebp
	jle	.L1107
	movl	8(%rsp), %ebp
	.p2align 4
	.p2align 3
.L1056:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1056
.L1107:
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC133(%rip), %rdi
	jmp	.L1320
	.p2align 4,,10
	.p2align 3
.L1036:
	movl	8(%rsp), %r11d
	movl	8(%rsp), %r14d
	xorl	%r12d, %r12d
	leaq	.LC38(%rip), %r13
	testl	%r11d, %r11d
	jle	.L1106
	.p2align 4
	.p2align 3
.L1057:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r14d
	jne	.L1057
.L1106:
	testl	%ebp, %ebp
	jne	.L1330
.L1059:
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	jmp	.L1321
	.p2align 4,,10
	.p2align 3
.L1033:
	movl	8(%rsp), %r14d
	movl	8(%rsp), %r12d
	xorl	%ebp, %ebp
	leaq	.LC38(%rip), %r13
	testl	%r14d, %r14d
	jle	.L1109
	.p2align 4
	.p2align 3
.L1052:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jne	.L1052
.L1109:
	movq	%r15, %rcx
	movl	$8, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC130(%rip), %rdi
	leaq	.LC144(%rip), %r13
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	%r15, %rdi
	movq	16(%rsp), %rdx
	leaq	.LC38(%rip), %rbp
	call	emit_expr
	movq	%r15, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC131(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	movl	8(%rsp), %r14d
	je	.L1054
	.p2align 4
	.p2align 3
.L1053:
	xorl	%ebx, %ebx
	testl	%r14d, %r14d
	js	.L1111
	.p2align 4
	.p2align 3
.L1110:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r14d
	jge	.L1110
.L1111:
	addq	$1, %r12
	xorl	%eax, %eax
	movq	%r13, %rsi
	movq	%r15, %rdi
	movq	%r12, %rcx
	movq	%r12, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %r12
	jb	.L1053
.L1054:
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	js	.L1112
	xorl	%ebx, %ebx
	leaq	.LC38(%rip), %r13
	.p2align 4
	.p2align 3
.L1113:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jge	.L1113
	movq	%r15, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	je	.L1078
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1115:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1115
	jmp	.L1078
	.p2align 4,,10
	.p2align 3
.L1034:
	movl	8(%rsp), %r12d
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	leaq	.LC38(%rip), %r13
	testl	%r12d, %r12d
	jle	.L1108
	.p2align 4
	.p2align 3
.L1055:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1055
.L1108:
	movq	%r15, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC132(%rip), %rdi
	jmp	.L1320
	.p2align 4,,10
	.p2align 3
.L1032:
	movl	8(%rsp), %eax
	xorl	%ebp, %ebp
	leaq	.LC38(%rip), %r13
	testl	%eax, %eax
	jle	.L1331
	.p2align 4
	.p2align 3
.L1043:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, 8(%rsp)
	jne	.L1043
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 32(%rsp)
	testq	%rbp, %rbp
	je	.L1332
.L1044:
	movq	function_labels(%rip), %r14
	xorl	%r13d, %r13d
	jmp	.L1157
	.p2align 4,,10
	.p2align 3
.L1155:
	addq	$1, %r13
	cmpq	%rbp, %r13
	je	.L1045
.L1157:
	movq	(%r14,%r13,8), %rsi
	movq	32(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1155
	leal	1(%r13), %edx
.L1156:
	leaq	.LC157(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	8(%rsp), %eax
	leaq	.LC38(%rip), %r13
	leal	1(%rax), %ebp
	testl	%ebp, %ebp
	jle	.L1160
.L1158:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1159:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, 8(%rsp)
	jne	.L1159
.L1160:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC111(%rip), %rdi
	call	fwrite@PLT
	movl	%ebp, 8(%rsp)
	movq	24(%rbx), %rbx
	xorl	%ebp, %ebp
	jmp	.L1027
	.p2align 4,,10
	.p2align 3
.L1189:
	movq	$0, 24(%rsp)
	jmp	.L1131
	.p2align 4,,10
	.p2align 3
.L1324:
	movl	16(%r14), %eax
	testl	%eax, %eax
	je	.L1141
	movq	32(%r14), %rcx
	movq	%rsi, %rdx
	movq	%r15, %rdi
	xorl	%eax, %eax
	leaq	.LC153(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1140
	.p2align 4,,10
	.p2align 3
.L1328:
	xorl	%ebx, %ebx
	testl	%r12d, %r12d
	jle	.L1333
	.p2align 4
	.p2align 3
.L1081:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L1081
	movq	8(%rsp), %rdx
	xorl	%eax, %eax
	leaq	.LC142(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L1090
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1094:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r12d
	jne	.L1094
.L1092:
	movq	8(%rsp), %rcx
	leaq	.LC140(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	%rcx, %rdx
	call	fprintf@PLT
	jmp	.L1090
.L1327:
	cmpl	$6, (%r12)
	movl	%ebp, %ecx
	jne	.L1071
	movl	g_no_line(%rip), %edi
	testl	%edi, %edi
	jne	.L1072
	cmpb	$0, 24(%rsp)
	je	.L1072
	movl	4(%r12), %edx
	movq	16(%rsp), %rcx
	movq	%r15, %rdi
	xorl	%eax, %eax
	leaq	.LC39(%rip), %rsi
	call	fprintf@PLT
.L1072:
	movl	8(%rsp), %esi
	leaq	.LC38(%rip), %rax
	xorl	%r14d, %r14d
	movq	%rax, 32(%rsp)
	testl	%esi, %esi
	js	.L1075
	.p2align 4
	.p2align 3
.L1073:
	movq	32(%rsp), %rdi
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r14d
	call	fwrite@PLT
	cmpl	%r14d, 8(%rsp)
	jge	.L1073
.L1075:
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC136(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r12), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC111(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1074
	.p2align 4,,10
	.p2align 3
.L1141:
	movq	%rsi, %rdx
	movq	%r15, %rdi
	leaq	.LC154(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1140
	.p2align 4,,10
	.p2align 3
.L1179:
	xorl	%ecx, %ecx
	jmp	.L1071
	.p2align 4,,10
	.p2align 3
.L1139:
	cmpl	$27, %eax
	leaq	.LC126(%rip), %rdx
	leaq	.LC125(%rip), %rax
	cmove	%rax, %rdx
	jmp	.L1138
.L1083:
	movq	8(%rsp), %r13
	leaq	.LC137(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	%r13, %rdx
	call	fprintf@PLT
	movq	8(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	movq	%r15, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC138(%rip), %rdi
	call	fwrite@PLT
	xorl	%eax, %eax
	movq	%r13, %rdx
	movq	%r15, %rdi
	leaq	.LC139(%rip), %rsi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L1088
	movq	8(%rsp), %rcx
	leaq	.LC140(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	movq	%rcx, %rdx
	call	fprintf@PLT
	jmp	.L1088
.L1050:
	xorl	%ebp, %ebp
	cmpq	$0, 32(%rbx)
	sete	%bpl
	jmp	.L1051
.L1325:
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	xorl	%eax, %eax
	movq	%r15, %rdi
	call	fprintf@PLT
	testl	%r14d, %r14d
	jle	.L1319
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
.L1319:
	movl	32(%rsp), %edx
	movq	%r15, %rdi
	leaq	.LC156(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC133(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1151
.L1331:
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %rbp
	movq	%rax, 32(%rsp)
	testq	%rbp, %rbp
	jne	.L1044
.L1045:
	xorl	%edx, %edx
	jmp	.L1156
.L1330:
	movq	%r15, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC136(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1059
.L1333:
	movq	8(%rsp), %rdx
	xorl	%eax, %eax
	leaq	.LC142(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L1090
	jmp	.L1092
.L1112:
	movq	%r15, %rcx
	movl	$63, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1078
.L1326:
	movq	%r15, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC135(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	jne	.L1068
	jmp	.L1078
.L1323:
	movq	%r15, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC147(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %r14d
	testl	%eax, %eax
	je	.L1120
	movq	%r15, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r15, %rdi
	call	emit_expr
	leaq	.LC111(%rip), %rax
	movq	%r15, %rcx
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
	leaq	.LC151(%rip), %rax
	movq	%rax, %rsi
	movq	%rax, 64(%rsp)
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%eax, %eax
	movl	%ebp, %edx
	leaq	.LC158(%rip), %rsi
	movq	%r15, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	cmpq	$0, 8(%r12)
	leal	2(%rax), %ebx
	jne	.L1164
	cmpl	$1, %ebx
	je	.L1128
	movl	32(%rsp), %edx
	movq	64(%rsp), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1319
	.p2align 4,,10
	.p2align 3
.L1332:
	xorl	%edx, %edx
	leaq	.LC157(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %ebp
	jmp	.L1158
	.cfi_endproc
.LFE55:
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
	leaq	.L1339(%rip), %r15
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
	je	.L1334
.L1335:
	cmpl	$13, 0(%r13)
	ja	.L1337
	movl	0(%r13), %eax
	movslq	(%r15,%rax,4), %rax
	addq	%r15, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1339:
	.long	.L1337-.L1339
	.long	.L1343-.L1339
	.long	.L1337-.L1339
	.long	.L1342-.L1339
	.long	.L1341-.L1339
	.long	.L1337-.L1339
	.long	.L1337-.L1339
	.long	.L1337-.L1339
	.long	.L1337-.L1339
	.long	.L1337-.L1339
	.long	.L1337-.L1339
	.long	.L1340-.L1339
	.long	.L1337-.L1339
	.long	.L1338-.L1339
	.text
	.p2align 4,,10
	.p2align 3
.L1337:
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
.L1338:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1387
	xorl	%eax, %eax
	jmp	.L1357
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1356:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1387
.L1357:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%r13, (%rdx)
	jne	.L1356
	movq	8(%rdx), %r14
.L1355:
	xorl	%r13d, %r13d
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1421
	.p2align 4
	.p2align 3
.L1358:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1358
	movq	%r14, %rdx
	leaq	.LC159(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1361:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jle	.L1361
.L1360:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC111(%rip), %rdi
	jmp	.L1420
	.p2align 4,,10
	.p2align 3
.L1340:
	xorl	%r14d, %r14d
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1422
	.p2align 4
	.p2align 3
.L1344:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1344
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L1423
.L1345:
	movq	function_labels(%rip), %r14
	xorl	%r12d, %r12d
	jmp	.L1365
	.p2align 4,,10
	.p2align 3
.L1363:
	addq	$1, %r12
	cmpq	%r12, 24(%rsp)
	je	.L1346
.L1365:
	movq	(%r14,%r12,8), %rsi
	movq	16(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1363
	leal	1(%r12), %edx
.L1364:
	leaq	.LC157(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	leaq	.LC38(%rip), %r12
	movl	%eax, 16(%rsp)
	testl	%eax, %eax
	jle	.L1424
.L1366:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1368:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, %ebp
	jne	.L1368
	movl	16(%rsp), %ebp
.L1369:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC111(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	jne	.L1335
	jmp	.L1334
	.p2align 4,,10
	.p2align 3
.L1341:
	xorl	%r14d, %r14d
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1381
	.p2align 4
	.p2align 3
.L1347:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1347
.L1381:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC127(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC128(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	je	.L1334
.L1348:
	xorl	%eax, %eax
	cmpl	$1, 0(%r13)
	setne	%al
	addl	%eax, %ebp
	jmp	.L1335
	.p2align 4,,10
	.p2align 3
.L1342:
	xorl	%r14d, %r14d
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1376
	.p2align 4
	.p2align 3
.L1350:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1350
.L1376:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC129(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC128(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %rsi
	testq	%rsi, %rsi
	je	.L1352
	cmpl	$1, (%rsi)
	movl	%ebp, %edx
	je	.L1377
.L1352:
	leal	1(%rbp), %edx
.L1377:
	movq	(%rsp), %r8
	movq	8(%rsp), %rcx
	movq	%rbx, %rdi
	call	emit_stmt_switchctx
	cmpq	$0, 32(%r13)
	je	.L1334
	xorl	%r14d, %r14d
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1380
	.p2align 4
	.p2align 3
.L1378:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1378
.L1380:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC143(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r13), %r13
	testq	%r13, %r13
	jne	.L1348
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
	ret
	.p2align 4,,10
	.p2align 3
.L1343:
	.cfi_restore_state
	xorl	%r15d, %r15d
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1425
	.p2align 4
	.p2align 3
.L1353:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebp, %r15d
	jne	.L1353
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC135(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	je	.L1371
.L1370:
	leal	1(%rbp), %r12d
	xorl	%r15d, %r15d
.L1373:
	movq	16(%r13), %rax
	movq	(%rsp), %r8
	movl	%r12d, %edx
	movq	%rbx, %rdi
	movq	8(%rsp), %rcx
	movq	(%rax,%r15,8), %rsi
	addq	$1, %r15
	call	emit_stmt_switchctx
	cmpq	24(%r13), %r15
	jb	.L1373
	leaq	.LC38(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1372
.L1371:
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1375:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1375
.L1372:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC116(%rip), %rdi
.L1420:
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
.L1387:
	.cfi_restore_state
	xorl	%r14d, %r14d
	jmp	.L1355
	.p2align 4,,10
	.p2align 3
.L1422:
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	jne	.L1345
	.p2align 4
	.p2align 3
.L1346:
	xorl	%edx, %edx
	jmp	.L1364
.L1423:
	xorl	%edx, %edx
	leaq	.LC157(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	movl	%eax, 16(%rsp)
	jmp	.L1366
	.p2align 4,,10
	.p2align 3
.L1421:
	xorl	%eax, %eax
	movq	%r14, %rdx
	leaq	.LC159(%rip), %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	testl	%ebp, %ebp
	jne	.L1360
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	jmp	.L1360
	.p2align 4,,10
	.p2align 3
.L1424:
	movl	%eax, %ebp
	jmp	.L1369
	.p2align 4,,10
	.p2align 3
.L1425:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC135(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	jne	.L1370
	jmp	.L1372
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
	je	.L1426
	movq	%rdi, %rbp
	movq	%rsi, %r12
	xorl	%ebx, %ebx
	jmp	.L1440
	.p2align 4,,10
	.p2align 3
.L1429:
	addq	$1, %rbx
	cmpq	8(%r12), %rbx
	jnb	.L1426
.L1440:
	movq	(%r12), %rax
	movq	(%rax,%rbx,8), %r14
	movl	(%r14), %eax
	testl	%eax, %eax
	je	.L1458
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L1429
	movq	8(%r14), %r13
	movq	16(%r13), %rdi
	call	get_mangled_name
	cmpl	$3, (%r14)
	movq	%rax, %r15
	je	.L1459
	cmpl	$1, 24(%r13)
	movl	$1, %r8d
	jne	.L1434
	movq	56(%r13), %rdi
	movl	$1, %r11d
	testq	%rdi, %rdi
	je	.L1435
	cmpl	$1, (%rdi)
	je	.L1460
.L1435:
	call	edge_tail_words_top
	leaq	(%rax,%r11), %r8
	movl	$1, %eax
	testq	%r8, %r8
	cmove	%rax, %r8
.L1434:
	movl	4(%r13), %eax
	leaq	.LC161(%rip), %rdx
	testl	%eax, %eax
	je	.L1436
	leaq	.LC160(%rip), %rdx
.L1436:
	xorl	%eax, %eax
	movq	%r15, %rcx
	leaq	.LC164(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$2, 24(%r13)
	jne	.L1429
	movq	56(%r13), %rdi
	xorl	%r11d, %r11d
	testq	%rdi, %rdi
	je	.L1437
	cmpl	$1, (%rdi)
	je	.L1461
.L1437:
	cmpq	$0, 32(%r13)
	je	.L1438
	movq	48(%r13), %rax
	movq	%r11, %rdx
	cmpq	%rax, %r11
	cmovb	%rax, %r11
	testq	%rax, %rax
	cmovle	%rdx, %r11
.L1438:
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
	jb	.L1440
.L1426:
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
.L1458:
	.cfi_restore_state
	movq	8(%r14), %rsi
	movq	8(%rsp), %r8
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbp, %rdi
	call	emit_stmt
	jmp	.L1429
	.p2align 4,,10
	.p2align 3
.L1459:
	movq	16(%r13), %rdi
	call	global_data_kind
	testl	%eax, %eax
	je	.L1429
	movl	8(%r13), %esi
	testl	%esi, %esi
	je	.L1433
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
	jmp	.L1429
	.p2align 4,,10
	.p2align 3
.L1460:
	movq	24(%rdi), %r11
	jmp	.L1435
	.p2align 4,,10
	.p2align 3
.L1433:
	movq	%r15, %rdx
	leaq	.LC163(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1429
.L1461:
	movq	24(%rdi), %r11
	jmp	.L1437
	.cfi_endproc
.LFE60:
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
	.text
	.p2align 4
	.type	emit_function_body, @function
emit_function_body:
.LFB56:
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
	leaq	.LC166(%rip), %rdi
	call	fwrite@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L1470
.L1463:
	cmpq	$0, 8+function_labels(%rip)
	je	.L1465
	xorl	%ebx, %ebx
	leaq	.LC168(%rip), %r14
	.p2align 4
	.p2align 3
.L1466:
	addq	$1, %rbx
	xorl	%eax, %eax
	movq	%r14, %rsi
	movq	%rbp, %rdi
	movq	%rbx, %rcx
	movq	%rbx, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %rbx
	jb	.L1466
.L1465:
	movq	32(%r12), %rsi
	movq	%r13, %r8
	movq	%rbp, %rdi
	movl	$1, %ecx
	movl	$1, %edx
	call	emit_stmt
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC116(%rip), %rdi
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
.L1470:
	.cfi_restore_state
	cmpq	$0, 16(%r12)
	je	.L1463
	xorl	%r14d, %r14d
	leaq	.LC167(%rip), %rbx
	.p2align 4
	.p2align 3
.L1464:
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
	jb	.L1464
	jmp	.L1463
	.cfi_endproc
.LFE56:
	.size	emit_function_body, .-emit_function_body
	.section	.rodata.str1.1
.LC169:
	.string	"#define BCC_USE_CURSES 1\n"
	.section	.rodata.str1.8
	.align 8
.LC170:
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
.LC171:
	.string	"#define B_BYTEPTR %d\n"
.LC172:
	.string	"#define WORD_BITS %d\n"
	.section	.rodata.str1.8
	.align 8
.LC173:
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
.LC174:
	.string	"%s/btarget.h"
	.section	.rodata.str1.8
	.align 8
.LC175:
	.string	"#define B_TARGET_DEFINE\n#define B_TARGET_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC176:
	.string	"%s/binit.h"
	.section	.rodata.str1.8
	.align 8
.LC177:
	.string	"#define B_INIT_DEFINE\n#define B_INIT_STORAGE __attribute__((common))\n"
	.align 8
.LC178:
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
	.ascii	" B_PTR_N(p, bytes);\n}\n\n/* B library functions - compatibl"
	.ascii	"e with Thompson's /etc/libb.a */\n/* String manipulation fun"
	.ascii	"ctions */\nstatic inline word b_load(word addr){ return B_DE"
	.ascii	"REF(addr); }\nstatic inline void b_store(word addr, word v){"
	.ascii	" B_DEREF(addr) = WVAL(v);\n}\n\n/* B string access - byte pa"
	.ascii	"cking within words.\n *\n * In B_BYTEPTR=0 mode, bytes are p"
	.ascii	"acked into words with byte 0 at the LSB.\n * This matches PD"
	.ascii	"P-11 "
	.ascii	"(little-endian) conventions. The shift-based approach\n * op"
	.ascii	"erates on word VALUES (not memory layout), making it consist"
	.ascii	"ent across\n * architectures: char(s,0) always returns the l"
	.ascii	"east-significant byte of the\n * word at address s, regardle"
	.ascii	"ss of host endianness.\n *\n * Note: This only works correct"
	.ascii	"ly when ALL byte access goes through char()/lchar().\n * Mix"
	.ascii	"ing direct memory access (like C's *(char*)ptr) with B word "
	.ascii	"operations will\n * give different results on big-endian hos"
	.ascii	"ts.\n */\nstatic word b_char(word s, word i){\n#if B_BYTEPTR"
	.ascii	" && WORD_BITS != 16\n    const unsigned char *p = (const uns"
	.ascii	"igned char*)B_CPTR(s);\n    return (word)p[(size_t)i];\n#els"
	.ascii	"e\n    const uword W = (uword)B_WORD_BYTES;\n    uword wi = "
	.ascii	"(uword)i / W;\n    uword bi = (uword)i % W;\n    uword w  = "
	.ascii	"(uword)B_INDEX(s, wi);\n    return (word)((w >> (bi * 8)) & "
	.ascii	"0xFF);\n#endif\n}\n\nstatic word b_lchar(word s, word i, wor"
	.ascii	"d c){\n#if B_BYTEPTR && WORD_BITS != 16\n    unsigned char *"
	.ascii	"p = (unsigned char*)B_CPTR(s);\n    p[(size_t)i] = (unsigned"
	.ascii	" char)(c & 0xFF);\n    return c;\n#else\n    const uword W ="
	.ascii	" (uword)B_WORD_BYTES;\n    uword wi = (uword)i / W;\n    uwo"
	.ascii	"rd bi = (uword)i % W;\n\n    word addr = B_ADDR(B_INDEX(s, w"
	.ascii	"i));\n    uword w   = (uword)b_load(addr);\n\n    uword mask"
	.ascii	" = (uword)0xFF << (bi * 8);\n    w = (w & ~mask) | (((uword)"
	.ascii	"c & 0xFF) << (bi * 8));\n\n    b_store(addr, (word)w);\n    "
	.ascii	"return c;\n#endif\n}\n\n/* Command line argument support imp"
	.ascii	"lementation */\nstatic word __b_pack_cstr(const char *s){\n "
	.ascii	"   size_t n = strlen(s);                 /* bytes, excluding"
	.ascii	" NUL */\n    size_t W = B_WORD_BYTES;              /* bytes "
	.ascii	"per word */\n    size_t total = n + 1;                 /* +1"
	.ascii	" for 004 terminator */\n    size_t words = (total + W - 1) /"
	.ascii	" W;\n\n    word bp = b_alloc((word)words);       /* B pointe"
	.ascii	"r to word storage */\n\n    /* write bytes into the B string"
	.ascii	" using lchar (handles packing for B_BYTEPTR=0) */\n    for ("
	.ascii	"size_t i = 0; i < n; i++){\n        b_lchar(bp, (word)i, (wo"
	.ascii	"rd)(unsigned char)s[i]);\n    }\n    b_lchar(bp, (word)n, (w"
	.ascii	"ord)004);\n    re"
	.ascii	"turn bp;\n}\n\nstatic void __b_bstr_to_cstr(word s, char *bu"
	.ascii	"f, size_t max){\n    size_t i = 0;\n    while (i + 1 < max) "
	.ascii	"{\n        word ch = b_char(s, (word)i);\n        if (ch == "
	.ascii	"004 || ch == 0) break;\n        buf[i++] = (char)(ch & 0xFF)"
	.ascii	";\n    }\n    buf[i] = 0;\n}\n\n/* Convert a B string (004-t"
	.ascii	"erminated) into a temporary NUL-terminated C string */\nstat"
	.ascii	"ic const char *__b_cstr(word s){\n    static char *slots[4];"
	.ascii	"\n    static size_t caps[4];\n    static int next = 0;\n\n  "
	.ascii	"  if (s == 0) return \"\";\n\n    size_t len = 0;\n    for ("
	.ascii	";; len++) {\n        word ch = b_char(s, (word)len);\n      "
	.ascii	"  if (ch == 004 || ch == 0) break;\n    }\n\n    int idx = n"
	.ascii	"ext;\n    next = (next + 1) & 3; /* simple ring buffer to su"
	.ascii	"rvive multiple args */\n\n    size_t need = len + 1;\n    if"
	.ascii	" (need > caps[idx]) {\n        size_t ncap = need < 64 ? 64 "
	.ascii	": need;\n        char *nb = (char*)realloc(slots[idx], ncap)"
	.ascii	";\n        if (!nb) { fprintf(stderr, \"cstr: out of memory\\"
	.ascii	"n\"); exit(1); }\n        slots[idx] = nb;\n        caps[idx"
	.ascii	"] = ncap;\n    }\n\n    for (size_t i = 0; i < len; i++) slo"
	.ascii	"ts[idx][i] = (char)(b_char(s, (word)i) & 0xFF);\n    slots[i"
	.ascii	"dx][len] = 0;\n    return slots[idx];\n}\n\n/* Duplicate a B"
	.ascii	" string into a freshly allocated C string */\nstatic char *_"
	.ascii	"_b_dup_bstr(word s){\n    size_t cap = 64;\n    char *buf = "
	.ascii	"(char*)malloc(cap);\n    if (!buf) { fprintf(stderr, \"syste"
	.ascii	"m: out of memory\\n\"); exit(1); }\n\n    size_t i = 0;\n   "
	.ascii	" for (;;) {\n        word ch = b_char(s, (word)i);\n        "
	.ascii	"if (ch == 004 || ch == 0) break;\n        if (i + 1 >= cap) "
	.ascii	"{\n            size_t ncap = cap * 2;\n            char *nbu"
	.ascii	"f = (char*)realloc(buf, ncap);\n            if (!nbuf) { fre"
	.ascii	"e(buf); fprintf(stderr, \"system: out of memory\\n\"); exit("
	.ascii	"1); }\n            buf = nbuf;\n            cap = ncap;\n   "
	.ascii	"     }\n        buf[i++] = (char)(ch & 0xFF);\n    }\n    bu"
	.ascii	"f[i] = 0;\n    return buf;\n}\n\nstatic void __b_setargs(int"
	.ascii	" argc, char **argv){\n    __b_argc = argc;\n    __b_argv = a"
	.ascii	"rgv;\n\n    __b_argvb = (word*)malloc(sizeof(word) * ((size_"
	.ascii	"t)argc + 1));\n    if (!__b_argvb) { fprin"
	.ascii	"tf(stderr, \"argv: out of memory\\n\"); exit(1); }\n\n    wo"
	.ascii	"rd *vector = (word*)malloc(sizeof(word) * ((size_t)argc + 1)"
	.ascii	");\n    if (!vector) { fprintf(stderr, \"argv: out of memory"
	.ascii	"\\n\"); exit(1); }\n    vector[0] = WVAL(argc);\n    for (in"
	.ascii	"t i = 0; i < argc; i++){\n        __b_argvb[i] = __b_pack_cs"
	.ascii	"tr(argv[i]);\n        vector[i+1] = __b_pack_cstr(argv[i]);\n"
	.ascii	"        b_lchar(vector[i+1], (word)strlen(argv[i]), 0);\n   "
	.ascii	" }\n    b_argv_vector = B_PTR_N(vector, sizeof(word) * ((siz"
	.ascii	"e_t)argc + 1));\n}\nstatic word __b_argvalues(void) {\n    r"
	.ascii	"eturn __b_argc ? B_PTR_N(__b_argvb, sizeof(word) * (size_t)_"
	.ascii	"_b_argc) : 0;\n}\n\nstatic word b_argc(void) { return (word)"
	.ascii	"__b_argc; }\n\nstatic word b_argv(word i) {\n    int idx = ("
	.ascii	"int)i;\n    if (idx < 0 || idx >= __b_argc) return 0;\n    r"
	.ascii	"eturn __b_argvb[idx];\n}\n\nstatic word b_reread(void) {\n  "
	.ascii	"  /* If no args, nothing to reread */\n    if (__b_argc <= 1"
	.ascii	") {\n        return 0;\n    }\n\n    /* Compute total length"
	.ascii	" of joined argv[0..] with spaces + newline */\n    size_t to"
	.ascii	"tal = 1; /* for trailing newline */\n    for (int i = 0; i <"
	.ascii	" __b_argc; i++) {\n        total += strlen(__b_argv[i]);\n  "
	.ascii	"      if (i + 1 < __b_argc) total += 1; /* space */\n    }\n"
	.ascii	"    \n    char *buf = (char*)malloc(total + 1);\n    if (!bu"
	.ascii	"f) { fprintf(stderr, \"reread: out of memory\\n\"); exit(1);"
	.ascii	" }\n    \n    size_t pos = 0;\n    for (int i = 0; i < __b_a"
	.ascii	"rgc; i++) {\n        size_t len = strlen(__b_argv[i]);\n    "
	.ascii	"    memcpy(buf + pos, __b_argv[i], len);\n        pos += len"
	.ascii	";\n        if (i + 1 < __b_argc) buf[pos++] = ' ';\n    }\n "
	.ascii	"   buf[pos++] = '\\n';\n    buf[pos] = '\\0';\n    \n    int"
	.ascii	" p[2];\n    if (pipe(p) != 0) { free(buf); fprintf(stderr, \""
	.ascii	"reread: pipe failed\\n\"); exit(1); }\n    ssize_t wn = writ"
	.ascii	"e(p[1], buf, pos);\n    (void)wn;\n    close(p[1]);\n    fre"
	.ascii	"e(buf);\n    \n    /* Close previous rd fd if it wasn't the "
	.ascii	"terminal */\n    if (rd_fd != 0 && rd_fd != p[0]) close(rd_f"
	.ascii	"d);\n    rd_fd = p[0];\n    rd_unit = (word)0;\n    __b_sync"
	.ascii	"_rd();\n    return 0;\n}\n\n/* I/O functions */\nstatic word"
	.ascii	" b_getchr(void) {\n    __b_sync_rd();\n "
	.ascii	"   unsigned char c;\n    ssize_t n = read(rd_fd, &c, 1);\n  "
	.ascii	"  if (n == 1) return (word)c;\n    if (rd_fd != 0) {\n      "
	.ascii	"  close(rd_fd);\n        rd_fd = 0;\n        rd_unit = -1;\n"
	.ascii	"        return b_getchr();\n    }\n    return (word)004; /* "
	.ascii	"Return *e on EOF */\n}\nstatic word b_putchr(word w) {\n    "
	.ascii	"__b_sync_wr();\n    unsigned char c = (unsigned char)(w & 0x"
	.ascii	"FF);\n    (void)write(wr_fd, &c, 1);\n    return w;\n}\nstat"
	.ascii	"ic word b_putstr(word s) {\n    __b_sync_wr();\n    word i ="
	.ascii	" 0;\n    for (;;) {\n        word ch = b_char(s, i++);\n    "
	.ascii	"    if (ch == 004 || ch == 0) break;\n        b_putchar(ch);"
	.ascii	"\n    }\n    return s;\n}\nstatic word b_getstr(word buf) {\n"
	.ascii	"    __b_sync_rd();\n    size_t i = 0;\n    unsigned char c;\n"
	.ascii	"    for (;;) {\n        ssize_t n = read(rd_fd, &c, 1);\n   "
	.ascii	"     if (n == 1 && c != '\\n' && c != '\\r') {\n            "
	.ascii	"b_lchar(buf, (word)i, (word)c);\n            i++;\n         "
	.ascii	"   continue;\n        }\n        if (n == 1) break; /* newli"
	.ascii	"ne */\n        if (rd_fd != 0) {\n            close(rd_fd);\n"
	.ascii	"            rd_fd = 0;\n            rd_unit = -1;\n         "
	.ascii	"   continue; /* retry on terminal */\n        }\n        bre"
	.ascii	"ak; /* EOF */\n    }\n    b_lchar(buf, (word)i, (word)004);\n"
	.ascii	"    return buf;\n}\nstatic word b_flush(void){\n    __b_sync"
	.ascii	"_wr();\n    if (wr_fd == 1) {\n        fflush(stdout);\n    "
	.ascii	"} else {\n        fsync(wr_fd);\n    }\n    return 0;\n}\n\n"
	.ascii	"#include <stdarg.h>\n\n/* Print number in specified base (fr"
	.ascii	"om B manual) */\nstatic void b_printn_u(word n, word base) {"
	.ascii	"\n    // recursion like old implementations\n    word a = (w"
	.ascii	"ord)((uword)n / (uword)base);\n    if (a) b_printn_u(a, base"
	.ascii	");\n    b_putchar((word)((uword)n % (uword)base) + '0');\n}\n"
	.ascii	"\nstatic word b_printf(word fmt, ...){\n    va_list ap;\n   "
	.ascii	" va_start(ap, fmt);\n\n    word i = 0;\n    for (;;){\n     "
	.ascii	"   word ch = b_char(fmt, i++);\n        if (ch == 004 || ch "
	.ascii	"== 0) break;  /* '*e' or NUL terminator */\n        if (ch !"
	.ascii	"= '%'){ b_putchar(ch); continue; }\n\n        word code = b_"
	.ascii	"char(fmt, i++);\n        if (code == 004) break;\n\n        "
	.ascii	"word arg = va_arg(ap, word);\n\n        sw"
	.ascii	"itch ((int)code){\n        case 'd': {\n#if WORD_BITS == 16\n"
	.ascii	"            int16_t v = (int16_t)arg;\n            if (v < 0"
	.ascii	"){ b_putchar('-'); v = (int16_t)-v; }\n            if (v) b_"
	.ascii	"printn_u((word)(uword)(uint16_t)v, 10);\n#elif WORD_BITS == "
	.ascii	"32\n            int32_t v = (int32_t)arg;\n            if (v"
	.ascii	" < 0){ b_putchar('-'); v = -v; }\n            if (v) b_print"
	.ascii	"n_u((word)(uword)(uint32_t)v, 10);\n#else\n            word "
	.ascii	"v = arg;\n            if (v < 0){ b_putchar('-'); v = -v; }\n"
	.ascii	"            if (v) b_printn_u((word)(uword)v, 10);\n#endif\n"
	.ascii	"            else b_putchar('0');\n            break;\n      "
	.ascii	"  }\n        case 'o': {\n#if WORD_BITS == 16\n            u"
	.ascii	"int16_t v = (uint16_t)arg;\n#elif WORD_BITS == 32\n         "
	.ascii	"   uint32_t v = (uint32_t)arg;\n#else\n            uword v ="
	.ascii	" (uword)arg;\n#endif\n            if (v) b_printn_u((word)(u"
	.ascii	"word)v, 8);\n            else b_putchar('0');\n            b"
	.ascii	"reak;\n        }\n        case 'u': {\n            uword v ="
	.ascii	" (uword)arg;\n            if (v) b_printn_u((word)v, 10);\n "
	.ascii	"           else b_putchar('0');\n            break;\n       "
	.ascii	" }\n        case 'p': {\n            uword v = (uword)arg;\n"
	.ascii	"            b_putchar('0'); b_putchar('x');\n            int"
	.ascii	" started = 0;\n            for (int shift = (int)(sizeof(uwo"
	.ascii	"rd)*8 - 4); shift >= 0; shift -= 4) {\n                int n"
	.ascii	"ib = (int)((v >> shift) & 0xF);\n                if (!starte"
	.ascii	"d && nib == 0 && shift > 0) continue;\n                start"
	.ascii	"ed = 1;\n                b_putchar((word)(nib < 10 ? ('0' + "
	.ascii	"nib) : ('a' + nib - 10)));\n            }\n            if (!"
	.ascii	"started) b_putchar('0');\n            break;\n        }\n   "
	.ascii	"     case 'z': {\n            word mod = b_char(fmt, i++);\n"
	.ascii	"            if (mod == 'u') {\n                uword v = (uw"
	.ascii	"ord)arg;\n                if (v) b_printn_u((word)v, 10);\n "
	.ascii	"               else b_putchar('0');\n            } else if ("
	.ascii	"mod == 'd') {\n                long v = (long)arg;\n        "
	.ascii	"        if (v < 0) { b_putchar('-'); v = -v; }\n            "
	.ascii	"    if (v) b_printn_u((word)(uword)v, 10);\n                "
	.ascii	"else b_putchar('0"
	.ascii	"');\n            } else {\n                b_putchar('%'); b"
	.ascii	"_putchar('z'); b_putchar(mod);\n            }\n            b"
	.ascii	"reak;\n        }\n        case 'c':\n            b_putchar(a"
	.ascii	"rg);\n            break;\n        case 's': {\n            w"
	.ascii	"ord j = 0;\n            for (;;){\n                word sc ="
	.ascii	" b_char(arg, j++);\n                if (sc == 004 || sc == 0"
	.ascii	") break;  /* Handle both *e and NUL termination */\n        "
	.ascii	"        b_putchar(sc);\n            }\n            break;\n "
	.ascii	"       }\n        default:\n            b_putchar('%'); b_pu"
	.ascii	"tchar(code);\n            break;\n        }\n    }\n\n    va"
	.ascii	"_end(ap);\n    return 0;\n}\n\n/* File I/O functions - with "
	.ascii	"actual implementations */\n#include <fcntl.h>\nstatic word b"
	.ascii	"_open(word name, word mode){\n    const char *p = __b_cstr(n"
	.ascii	"ame);\n    int flags = ((int)mode == 0) ? O_RDONLY : O_WRONL"
	.ascii	"Y;\n    return (word)open(p, flags);\n}\nstatic word b_openr"
	.ascii	"(word fd, word name){\n    char buf[512];\n    __b_bstr_to_c"
	.ascii	"str(name, buf, sizeof(buf));\n    int target = (int)fd;\n   "
	.ascii	" if (target < 0 || buf[0] == '\\0') {\n        rd_fd = 0; rd"
	.ascii	"_unit = -1; return 0;\n    }\n    int newfd = open(buf, O_RD"
	.ascii	"ONLY);\n    if (rd_fd != 0 && rd_fd != target) close(rd_fd);"
	.ascii	"\n    if (newfd < 0) { rd_fd = -1; rd_unit = (word)target; r"
	.ascii	"eturn -1; }\n    if (newfd != target) {\n        if (dup2(ne"
	.ascii	"wfd, target) < 0) { close(newfd); return -1; }\n        clos"
	.ascii	"e(newfd);\n        newfd = target;\n    }\n    rd_fd = newfd"
	.ascii	";\n    rd_unit = (word)target;\n    return (word)newfd;\n}\n"
	.ascii	"static word b_openw(word fd, word name){\n    char buf[512];"
	.ascii	"\n    __b_bstr_to_cstr(name, buf, sizeof(buf));\n    int tar"
	.ascii	"get = (int)fd;\n    if (target < 0 || buf[0] == '\\0') {\n  "
	.ascii	"      wr_fd = 1; wr_unit = -1; return 1;\n    }\n    int new"
	.ascii	"fd = open(buf, O_WRONLY | O_CREAT | O_TRUNC, 0666);\n    if "
	.ascii	"(newfd < 0) return -1;\n    if (wr_fd != 1 && wr_fd != targe"
	.ascii	"t && wr_fd != newfd) close(wr_fd);\n    if (newfd != target)"
	.ascii	" {\n        if (dup2(newfd, target) < 0) { close(newfd); ret"
	.ascii	"urn -1; }\n        close(newfd);\n        newfd = target;\n "
	.ascii	"   }\n    wr_fd = newfd;\n    wr"
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
	.ascii	" < count; i++) b_lchar(buf, (word)i, bytes[i]);\n    free(by"
	.ascii	"tes);\n    return WVAL(count);\n#else\n    char *p = (char*)"
	.ascii	"B_CPTR(buf);\n    if ((size_t)n < sizeof(word)) memset(p, 0,"
	.ascii	" sizeof(word));\n    return (word)read((int)fd, p, (size_t)n"
	.ascii	");\n#endif\n}\nstatic word b_write(word fd, word buf, word n"
	.ascii	") {\n#if WORD_BITS == 16\n    if (n < 0) return -1;\n    uns"
	.ascii	"igned char *bytes = malloc(n ? (size_t)n : 1);\n    if (!byt"
	.ascii	"es) return -1;\n    for (word i = 0; i < n; i++) bytes[i] = "
	.ascii	"(unsigned char)b_char(buf, i);\n    ssize_t count = write((i"
	.ascii	"nt)fd, bytes, (size_t)n);\n    free(bytes);\n    return WVAL"
	.ascii	"(count);\n#else\n    return (word)write((int)fd, B_CPTR(buf)"
	.ascii	", (size_t)n);\n#endif\n}\nstatic word b_creat(word name, wor"
	.ascii	"d mode) {\n    const char *p = __b_cstr(name);\n    return ("
	.ascii	"word)creat(p, (mode_t)mode);\n}\nstatic word b_seek(word fd,"
	.ascii	" word offset, word whence) {\n    off_t r = lseek((int)fd, ("
	.ascii	"off_t)offset, (int)whence);\n    return (r < 0) ? (word)-1 :"
	.ascii	" (word)0;\n}\n\n/* Process control functions - with actual i"
	.ascii	"mplementations */\nstatic word b_fork(void) {\n    return (w"
	.ascii	"ord)fork();\n}\nstatic word __b_wait_status;\n\nstatic word "
	.ascii	"b_wait(void) {\n    int st = 0;\n    pid_t pid = wait(&st);\n"
	.ascii	"    __b_wait_status = (word)st;\n    return (word)pid;\n}\n/"
	.ascii	"* B72 section 8 passes exactly count argument strings, inclu"
	.ascii	"ding arg0. */\nstatic word b_execv(word path, word argv, wor"
	.ascii	"d count) {\n    if (count < 0 || count > 255 || (count && !a"
	.ascii	"rgv)) return -1;\n    c"
	.ascii	"har *name = __b_dup_bstr(path);\n    if (!name) return -1;\n"
	.ascii	"    char *arguments[256];\n    word *values = count ? (word*"
	.ascii	")B_CPTR(argv) : NULL;\n    size_t n = (size_t)count, i = 0;\n"
	.ascii	"    for (; i < n; i++) {\n        if (!values[i]) break;\n  "
	.ascii	"      arguments[i] = __b_dup_bstr(values[i]);\n        if (!"
	.ascii	"arguments[i]) break;\n    }\n    if (i == n) {\n        argu"
	.ascii	"ments[n] = NULL;\n        execv(name, arguments);\n    }\n  "
	.ascii	"  while (i) free(arguments[--i]);\n    free(name);\n    retu"
	.ascii	"rn -1;\n}\n\nstatic word b_execl(word path, ...) {\n    char"
	.ascii	" *name = __b_dup_bstr(path);\n    if (!name) return -1;\n   "
	.ascii	" char *arguments[256];\n    size_t n = 0;\n    int complete "
	.ascii	"= 0;\n    va_list ap;\n    va_start(ap, path);\n    while (n"
	.ascii	" < 255) {\n        word value = va_arg(ap, word);\n        i"
	.ascii	"f (!value) { complete = 1; break; }\n        arguments[n] = "
	.ascii	"__b_dup_bstr(value);\n        if (!arguments[n]) break;\n   "
	.ascii	"     n++;\n    }\n    va_end(ap);\n    if (complete) {\n    "
	.ascii	"    arguments[n] = NULL;\n        execv(name, arguments);\n "
	.ascii	"   }\n    while (n) free(arguments[--n]);\n    free(name);\n"
	.ascii	"    return -1;\n}\n\nstatic word b_system(word cmd) {\n    /"
	.ascii	"* Split arguments without invoking a shell or expanding thei"
	.ascii	"r contents. */\n    char *line = __b_dup_bstr(cmd);\n    if "
	.ascii	"(!line) return -1;\n    char *argv[128];\n    size_t argc = "
	.ascii	"0;\n    char *p = line, *q = line;\n    while (*p) {\n      "
	.ascii	"  while (*p && isspace((unsigned char)*p)) p++;\n        if "
	.ascii	"(!*p) break;\n        if (argc + 1 >= sizeof(argv)/sizeof(ar"
	.ascii	"gv[0])) { free(line); return -1; }\n        argv[argc++] = q"
	.ascii	";\n        int quote = 0;\n        while (*p && (quote || !i"
	.ascii	"sspace((unsigned char)*p))) {\n            unsigned char c ="
	.ascii	" (unsigned char)*p++;\n            if (c == '\\\\' && quote "
	.ascii	"!= '\\'') {\n                if (!*p) { free(line); return -"
	.ascii	"1; }\n                *q++ = *p++;\n            } else if (c"
	.ascii	" == '\\'' || c == '\"') {\n                if (!quote) quote"
	.ascii	" = c;\n                else if (quote == c) quote = 0;\n    "
	.ascii	"            else *q++ = (char)c;\n            } else *q++ = "
	.ascii	"(char)c;\n        }\n        if "
	.ascii	"(quote) { free(line); return -1; }\n        if (*p) p++;\n  "
	.ascii	"      *q++ = 0;\n    }\n    if (argc == 0) { free(line); ret"
	.ascii	"urn -1; }\n    argv[argc] = NULL;\n    pid_t pid = fork();\n"
	.ascii	"    if (pid == 0) {\n        execvp(argv[0], argv);\n       "
	.ascii	" _exit(127);\n    }\n    if (pid < 0) { free(line); return -"
	.ascii	"1; }\n    int st = 0;\n    pid_t w;\n    do { w = waitpid(pi"
	.ascii	"d, &st, 0); } while (w < 0 && errno == EINTR);\n    free(lin"
	.ascii	"e);\n    if (w < 0) return -1;\n    return (word)st;\n}\n\ns"
	.ascii	"tatic word b_usleep(word usec) {\n    usleep((useconds_t)use"
	.ascii	"c);\n    return 0;\n}\n\nstatic word b_callf_dispatch(int na"
	.ascii	"rgs, word name, ...) {\n    static int __b_callf_dl_done = 0"
	.ascii	";\n    if (!__b_callf_dl_done) {\n        __b_callf_dl_done "
	.ascii	"= 1;\n        const char *env = getenv(\"B_CALLF_LIB\");\n  "
	.ascii	"      if (env && *env) {\n            const char *p = env;\n"
	.ascii	"            while (*p) {\n                const char *start "
	.ascii	"= p;\n                while (*p && *p != ':') p++;\n        "
	.ascii	"        size_t len = (size_t)(p - start);\n                i"
	.ascii	"f (len) {\n                    char *path = (char*)malloc(le"
	.ascii	"n + 1);\n                    if (path) {\n                  "
	.ascii	"      memcpy(path, start, len);\n                        pat"
	.ascii	"h[len] = '\\0';\n                        (void)dlopen(path, "
	.ascii	"RTLD_NOW | RTLD_GLOBAL);\n                        free(path)"
	.ascii	";\n                    }\n                }\n               "
	.ascii	" if (*p == ':') p++;\n            }\n        }\n    }\n    i"
	.ascii	"f (nargs < 0 || nargs > 10) return -1;\n    if (name == 0) r"
	.ascii	"eturn -1;\n \n    char sym[256];\n    __b_bstr_to_cstr(name,"
	.ascii	" sym, sizeof(sym));\n \n    void *fn = dlsym(RTLD_DEFAULT, s"
	.ascii	"ym);\n    if (!fn) {\n        size_t len = strlen(sym);\n   "
	.ascii	"     if (len + 2 < sizeof(sym)) {\n            sym[len] = '_"
	.ascii	"'; sym[len + 1] = '\\0';\n            fn = dlsym(RTLD_DEFAUL"
	.ascii	"T, sym);\n            sym[len] = '\\0';\n        }\n    }\n "
	.ascii	"   if (!fn) return -1;\n \n    void *args[10] = {0};\n    va"
	.ascii	"_list ap;\n    va_start(ap, name);\n    for (int i = 0; i < "
	.ascii	"nargs && i < 10; i++) {\n        word w = va_arg(ap, word);\n"
	.ascii	"        args[i] = B_CPTR(w);\n    }\n"
	.ascii	"    va_end(ap);\n \n    word r = 0;\n    switch (nargs) {\n "
	.ascii	"   case 0: r = ((word (*)(void))fn)(); break;\n    case 1: r"
	.ascii	" = ((word (*)(void*))fn)(args[0]); break;\n    case 2: r = ("
	.ascii	"(word (*)(void*, void*))fn)(args[0], args[1]); break;\n    c"
	.ascii	"ase 3: r = ((word (*)(void*, void*, void*))fn)(args[0], args"
	.ascii	"[1], args[2]); break;\n    case 4: r = ((word (*)(void*, voi"
	.ascii	"d*, void*, void*))fn)(args[0], args[1], args[2], args[3]); b"
	.ascii	"reak;\n    case 5: r = ((word (*)(void*, void*, void*, void*"
	.ascii	", void*))fn)(args[0], args[1], args[2], args[3], args[4]); b"
	.ascii	"reak;\n    case 6: r = ((word (*)(void*, void*, void*, void*"
	.ascii	", void*, void*))fn)(args[0], args[1], args[2], args[3], args"
	.ascii	"[4], args[5]); break;\n    case 7: r = ((word (*)(void*, voi"
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
	.ascii	"(ticks & 65535);\n    }\n    return 0;\n}\n\n/* B72 sec"
	.ascii	"tion 8 specifies a caller-owned, 16-byte date buffer. */\nst"
	.ascii	"atic word b_ctime(word tvp, word date) {\n    if (!tvp || !d"
	.ascii	"ate) return -1;\n    word *tv = (word*)B_CPTR(tvp);\n    uin"
	.ascii	"t32_t ticks = ((uint32_t)(uint16_t)tv[0] << 16) | (uint16_t)"
	.ascii	"tv[1];\n    unsigned days = ticks / 5184000U;\n    unsigned "
	.ascii	"seconds = ticks / 60U % 86400U;\n    unsigned year = 1971, m"
	.ascii	"onth = 0;\n    while (days >= (year % 4 == 0 ? 366U : 365U))"
	.ascii	" {\n        days -= year % 4 == 0 ? 366U : 365U;\n        ye"
	.ascii	"ar++;\n    }\n    static const unsigned lengths[] = {31,28,3"
	.ascii	"1,30,31,30,31,31,30,31,30,31};\n    static const char *month"
	.ascii	"s[] = {\"Jan\",\"Feb\",\"Mar\",\"Apr\",\"May\",\"Jun\",\"Jul"
	.ascii	"\",\"Aug\",\"Sep\",\"Oct\",\"Nov\",\"Dec\"};\n    for (;;) {"
	.ascii	"\n        unsigned length = lengths[month] + (month == 1 && "
	.ascii	"year % 4 == 0);\n        if (days < length) break;\n        "
	.ascii	"days -= length;\n        month++;\n    }\n    char text[16];"
	.ascii	"\n    snprintf(text, sizeof(text), \"%s %2u %02u:%02u:%02u\""
	.ascii	", months[month], days + 1,\n             seconds / 3600, sec"
	.ascii	"onds / 60 % 60, seconds % 60);\n    for (size_t i = 0; i < s"
	.ascii	"izeof(text); i++) b_lchar(date, (word)i, (word)(unsigned cha"
	.ascii	"r)text[i]);\n    return 0;\n}\n\nstatic word b_getuid(void) "
	.ascii	"{\n    return (word)getuid();\n}\nstatic word b_chdir(word p"
	.ascii	"ath) {\n    const char *p = __b_cstr(path);\n    return (wor"
	.ascii	"d)chdir(p);\n}\nstatic word b_unlink(word path) {\n    const"
	.ascii	" char *p = __b_cstr(path);\n    return (word)unlink(p);\n}\n"
	.ascii	"\n/* System functions with actual implementations */\nstatic"
	.ascii	" word b_chmod(word path, word mode) {\n    const char *p = _"
	.ascii	"_b_cstr(path);\n    return (word)chmod(p, (mode_t)mode);\n}\n"
	.ascii	"static word b_chown(word path, word owner) {\n    const char"
	.ascii	" *p = __b_cstr(path);\n    return (word)chown(p, (uid_t)owne"
	.ascii	"r, (gid_t)-1);\n}\nstatic word b_link(word old, word new) {\n"
	.ascii	"    const char *o = __b_cstr(old);\n    const char *n = __b_"
	.ascii	"cstr(new);\n    return (word)link(o, n);\n}\nstatic word b_s"
	.ascii	"tat(word path, word bufp) {\n    const char *p = __b_cstr(pa"
	.ascii	"th);\n    struct stat st;\n    if (stat(p, &st) != 0) return"
	.ascii	" -1;\n    if (bufp) {\n        unsigned ch"
	.ascii	"ar *b = (unsigned char*)B_CPTR(bufp);\n        for (int i = "
	.ascii	"0; i < 20*sizeof(word); i++) b[i] = 0;\n        size_t n = s"
	.ascii	"izeof(st);\n        if (n > 20*sizeof(word)) n = 20*sizeof(w"
	.ascii	"ord);\n        memcpy(b, &st, n);\n    }\n    return 0;\n}\n"
	.ascii	"\nstatic word b_fstat(word fd, word bufp) {\n    struct stat"
	.ascii	" st;\n    if (fstat((int)fd, &st) != 0) return -1;\n    if ("
	.ascii	"bufp) {\n        unsigned char *b = (unsigned char*)B_CPTR(b"
	.ascii	"ufp);\n        for (int i = 0; i < 20*sizeof(word); i++) b[i"
	.ascii	"] = 0;\n        size_t n = sizeof(st);\n        if (n > 20*s"
	.ascii	"izeof(word)) n = 20*sizeof(word);\n        memcpy(b, &st, n)"
	.ascii	";\n    }\n    return 0;\n}\nstatic word b_setuid(word uid) {"
	.ascii	"\n    return (word)setuid((uid_t)uid);\n}\nstatic word b_mak"
	.ascii	"dir(word path, word mode) {\n    const char *p = __b_cstr(pa"
	.ascii	"th);\n    return (word)mkdir(p, (mode_t)mode);\n}\n\n/* prin"
	.ascii	"tn(number, base) - print number in specified base (from B ma"
	.ascii	"nual) */\nstatic word b_printn(word n, word base) {\n    // "
	.ascii	"Handle negative numbers for decimal only\n    if (base == 10"
	.ascii	" && (int16_t)n < 0) {\n        b_putchar('-');\n        n = "
	.ascii	"(word)(-(int16_t)n);\n    }\n    b_printn_u(n, base);\n    r"
	.ascii	"eturn n;\n}\nstatic word b_putnum(word n) {\n    b_printn(n,"
	.ascii	" (word)10);\n    return n;\n}\nstatic volatile sig_atomic_t "
	.ascii	"__b_got_intr = 0;\n\nstatic void __b_sigint(int sig){ (void)"
	.ascii	"sig; __b_got_intr = 1; }\n\nstatic word b_gtty(word fd, word"
	.ascii	" ttstat){\n    struct termios t;\n    if (tcgetattr((int)fd,"
	.ascii	" &t) < 0) return -1;\n\n    word *vec = (word*)B_CPTR(ttstat"
	.ascii	");\n    vec[0] = (word)t.c_iflag;\n    vec[1] = (word)t.c_of"
	.ascii	"lag;\n    vec[2] = (word)t.c_lflag;\n    return 0;\n}\n\nsta"
	.ascii	"tic word b_stty(word fd, word ttstat){\n    struct termios t"
	.ascii	";\n    if (tcgetattr((int)fd, &t) < 0) return -1;\n\n    wor"
	.ascii	"d *vec = (word*)B_CPTR(ttstat);\n    t.c_iflag = (tcflag_t)v"
	.ascii	"ec[0];\n    t.c_oflag = (tcflag_t)vec[1];\n    t.c_lflag = ("
	.ascii	"tcflag_t)vec[2];\n    return (word)tcsetattr((int)fd, TCSANO"
	.ascii	"W, &t);\n}\nstatic word b_intr(word on) {\n    /* Set up int"
	.ascii	"errupt handling */\n    /* on != 0: catch interrupts, on == "
	.ascii	"0: restore default */\n    if ("
	.string	"on) {\n        __b_got_intr = 0;\n        if (signal(SIGINT, __b_sigint) == SIG_ERR) return -1;\n    } else {\n        if (signal(SIGINT, SIG_DFL) == SIG_ERR) return -1;\n    }\n    return 0;\n}\n\n/* Builtin aliases for B source */\n\n"
	.section	.rodata.str1.1
.LC179:
	.string	"word __b_user_main("
	.section	.rodata.str1.8
	.align 8
.LC180:
	.string	"int main(int argc, char **argv){\n"
	.section	.rodata.str1.1
.LC181:
	.string	"    __b_setargs(argc, argv);\n"
.LC182:
	.string	"    __b_init();\n"
	.section	.rodata.str1.8
	.align 8
.LC183:
	.string	"    return (int)__b_user_main();\n"
	.align 8
.LC184:
	.string	"    return (int)__b_user_main((word)argc);\n"
	.align 8
.LC185:
	.string	"    return (int)__b_user_main((word)argc, __b_argvalues());\n"
	.text
	.p2align 4
	.globl	emit_program_c
	.type	emit_program_c, @function
emit_program_c:
.LFB62:
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
	movl	g_use_curses(%rip), %edx
	testl	%edx, %edx
	jne	.L1504
.L1472:
	movq	%rbx, %rcx
	movl	$1546, %edx
	movl	$1, %esi
	leaq	.LC170(%rip), %rdi
	call	fwrite@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbx, %rdi
	setne	%dl
	leaq	.LC171(%rip), %rsi
	leaq	40(%rsp), %r13
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%ebp, %edx
	leaq	.LC172(%rip), %rsi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	call	fprintf@PLT
	movq	%rbx, %rcx
	movl	$1441, %edx
	movl	$1, %esi
	leaq	.LC173(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC174(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r13, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$73, %edx
	movl	$1, %esi
	leaq	.LC175(%rip), %rdi
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
	movq	g_libb_path(%rip), %rsi
	leaq	.LC176(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r13, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC177(%rip), %rdi
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
	movl	$28225, %edx
	movl	$1, %esi
	leaq	.LC178(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1505
.L1473:
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
	je	.L1471
	movq	$0, 24(%rsp)
	xorl	%ebp, %ebp
	movl	$0, 20(%rsp)
	.p2align 5
	.p2align 4
	.p2align 3
.L1483:
	movq	(%r12), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$1, (%rax)
	je	.L1506
.L1475:
	addq	$1, %rbp
	cmpq	8(%r12), %rbp
	jb	.L1483
	movl	20(%rsp), %eax
	testl	%eax, %eax
	jne	.L1507
.L1471:
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
.L1506:
	.cfi_restore_state
	movq	8(%rax), %r14
	leaq	.LC22(%rip), %rsi
	movq	(%r14), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1476
	leaq	.LC25(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1477
.L1476:
	movq	16(%r14), %rax
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC179(%rip), %rdi
	movq	%rax, 24(%rsp)
	call	fwrite@PLT
	movl	$1, 20(%rsp)
.L1478:
	cmpq	$0, 16(%r14)
	je	.L1480
	xorl	%r13d, %r13d
	leaq	.LC29(%rip), %r15
	jmp	.L1482
	.p2align 4,,10
	.p2align 3
.L1508:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
.L1482:
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r14), %rax
	movq	(%rax,%r13,8), %rdi
	testq	%rdi, %rdi
	je	.L1481
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1481:
	addq	$1, %r13
	cmpq	16(%r14), %r13
	jb	.L1508
.L1480:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC128(%rip), %rdi
	call	fwrite@PLT
	movq	8(%rsp), %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_function_body
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1475
	.p2align 4,,10
	.p2align 3
.L1507:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC180(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC181(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC182(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%rsp)
	je	.L1489
	cmpq	$1, 24(%rsp)
	je	.L1509
	cmpq	$2, 24(%rsp)
	jne	.L1489
	movq	%rbx, %rcx
	movl	$60, %edx
	movl	$1, %esi
	leaq	.LC185(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1487
	.p2align 4,,10
	.p2align 3
.L1505:
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1473
	.p2align 4,,10
	.p2align 3
.L1504:
	movq	%rbx, %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC169(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1472
	.p2align 4,,10
	.p2align 3
.L1489:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC183(%rip), %rdi
	call	fwrite@PLT
.L1487:
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$2, %edx
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
.L1477:
	.cfi_restore_state
	leaq	.LC29(%rip), %r15
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
	movq	(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1479
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1479:
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1478
.L1509:
	movq	%rbx, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC184(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1487
	.cfi_endproc
.LFE62:
	.size	emit_program_c, .-emit_program_c
	.section	.rodata.str1.8
	.align 8
.LC186:
	.string	"/* Generated by BCC - B Compiler */\n"
	.section	.rodata.str1.1
.LC187:
	.string	"#include \"libb.h\"\n\n"
	.section	.rodata.str1.8
	.align 8
.LC188:
	.string	"#include <ncurses.h>\n#include <panel.h>\n\n"
	.text
	.p2align 4
	.globl	emit_program_c_ext
	.type	emit_program_c_ext, @function
emit_program_c_ext:
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
	movl	96(%rsp), %ecx
	movq	%rdx, 8(%rsp)
	testl	%ecx, %ecx
	je	.L1544
	pxor	%xmm0, %xmm0
	movq	%rsi, %rdi
	movl	%r9d, current_word_bits(%rip)
	movups	%xmm0, 8+string_pool(%rip)
	movq	%rsi, current_program(%rip)
	movl	%r13d, current_byteptr(%rip)
	movq	$0, string_pool(%rip)
	movq	$0, 8+name_map(%rip)
	call	collect_strings_program
	movq	%rbp, %rcx
	movl	$36, %edx
	movl	$1, %esi
	leaq	.LC186(%rip), %rdi
	call	fwrite@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbp, %rdi
	setne	%dl
	leaq	.LC171(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%ebx, %edx
	leaq	.LC172(%rip), %rsi
	xorl	%eax, %eax
	movq	%rbp, %rdi
	call	fprintf@PLT
	movl	$19, %edx
	movq	%rbp, %rcx
	movl	$1, %esi
	leaq	.LC187(%rip), %rdi
	call	fwrite@PLT
	movl	g_use_curses(%rip), %edx
	testl	%edx, %edx
	jne	.L1545
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1546
.L1513:
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
	je	.L1510
	movq	$0, 24(%rsp)
	xorl	%ebx, %ebx
	movl	$0, 20(%rsp)
	.p2align 5
	.p2align 4
	.p2align 3
.L1523:
	movq	(%r12), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$1, (%rax)
	je	.L1547
.L1515:
	addq	$1, %rbx
	cmpq	8(%r12), %rbx
	jb	.L1523
	movl	20(%rsp), %eax
	testl	%eax, %eax
	jne	.L1548
.L1510:
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
.L1546:
	.cfi_restore_state
	movq	%rbp, %rdi
	call	emit_string_pool
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1513
	.p2align 4,,10
	.p2align 3
.L1545:
	movq	%rbp, %rcx
	movl	$41, %edx
	movl	$1, %esi
	leaq	.LC188(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	je	.L1513
	jmp	.L1546
	.p2align 4,,10
	.p2align 3
.L1548:
	movq	%rbp, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC180(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC181(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC182(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%rsp)
	je	.L1529
	cmpq	$1, 24(%rsp)
	je	.L1549
	cmpq	$2, 24(%rsp)
	je	.L1550
.L1529:
	movq	%rbp, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC183(%rip), %rdi
	call	fwrite@PLT
.L1527:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rcx
	movl	$2, %edx
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
.L1547:
	.cfi_restore_state
	movq	8(%rax), %r14
	leaq	.LC22(%rip), %rsi
	movq	(%r14), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1516
	leaq	.LC25(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1517
.L1516:
	movq	16(%r14), %rax
	movq	%rbp, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC179(%rip), %rdi
	movq	%rax, 24(%rsp)
	call	fwrite@PLT
	movl	$1, 20(%rsp)
.L1518:
	cmpq	$0, 16(%r14)
	je	.L1520
	xorl	%r13d, %r13d
	leaq	.LC29(%rip), %r15
	jmp	.L1522
	.p2align 4,,10
	.p2align 3
.L1551:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
.L1522:
	movq	%r15, %rdi
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r14), %rax
	movq	(%rax,%r13,8), %rdi
	testq	%rdi, %rdi
	je	.L1521
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1521:
	addq	$1, %r13
	cmpq	16(%r14), %r13
	jb	.L1551
.L1520:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC128(%rip), %rdi
	call	fwrite@PLT
	movq	8(%rsp), %rdx
	movq	%r14, %rsi
	movq	%rbp, %rdi
	call	emit_function_body
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1515
	.p2align 4,,10
	.p2align 3
.L1544:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%r13d, %ecx
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
.L1517:
	.cfi_restore_state
	leaq	.LC29(%rip), %r15
	movq	%rbp, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
	movq	(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1519
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1519:
	movq	%rbp, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1518
.L1550:
	movq	%rbp, %rcx
	movl	$60, %edx
	movl	$1, %esi
	leaq	.LC185(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1527
.L1549:
	movq	%rbp, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC184(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1527
	.cfi_endproc
.LFE63:
	.size	emit_program_c_ext, .-emit_program_c_ext
	.section	.rodata
	.align 16
	.type	CSWTCH.150, @object
	.size	CSWTCH.150, 24
CSWTCH.150:
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
	.quad	.LC76
	.quad	.LC197
	.quad	.LC198
	.quad	.LC199
	.quad	.LC200
	.quad	.LC83
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
	.quad	.LC71
	.quad	.LC233
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
	.quad	.LC134
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
	.quad	.LC30
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
