	.file	"emitter.c"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC46:
	.string	"static const word __b_str%zu[] = {"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC47:
	.string	"0x%0*lx"
.LC48:
	.string	"};\n"
	.text
	.p2align 4
	.type	emit_string_pool, @function
emit_string_pool:
.LFB15:
	.cfi_startproc
	cmpq	$0, 8+string_pool(%rip)
	je	.L25
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
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movq	$0, 8(%rsp)
	.p2align 4
	.p2align 3
.L13:
	movq	string_pool(%rip), %rax
	movq	8(%rsp), %rdx
	movq	(%rax,%rdx,8), %rax
	movq	(%rax), %r15
	cmpb	$0, (%r15)
	je	.L3
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 4
	.p2align 3
.L4:
	movq	%r14, %rax
	addq	$1, %r14
	cmpb	$0, (%r15,%r14)
	jne	.L4
	movq	8(%rsp), %rdx
	leaq	9(%rax), %rbx
	leaq	.LC46(%rip), %rsi
	xorl	%eax, %eax
	movq	%rbp, %rdi
	call	fprintf@PLT
	shrq	$3, %rbx
	je	.L7
.L6:
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L8:
	leaq	0(,%r13,8), %rsi
	xorl	%ecx, %ecx
	xorl	%r12d, %r12d
	jmp	.L11
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L30:
	movzbl	(%r15,%rsi), %eax
.L10:
	movzbl	%al, %eax
	addq	$1, %rsi
	salq	%cl, %rax
	addl	$8, %ecx
	orq	%rax, %r12
	cmpl	$64, %ecx
	je	.L29
.L11:
	cmpq	%r14, %rsi
	jb	.L30
	cmpq	%rsi, %r14
	sete	%al
	sall	$2, %eax
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L29:
	testq	%r13, %r13
	je	.L12
	movq	%rbp, %rsi
	movl	$44, %edi
	call	fputc@PLT
.L12:
	movq	%r12, %rcx
	movl	$16, %edx
	movq	%rbp, %rdi
	xorl	%eax, %eax
	leaq	.LC47(%rip), %rsi
	addq	$1, %r13
	call	fprintf@PLT
	cmpq	%r13, %rbx
	jne	.L8
.L7:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC48(%rip), %rdi
	call	fwrite@PLT
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	8+string_pool(%rip), %rax
	jb	.L13
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
.L3:
	.cfi_restore_state
	movq	8(%rsp), %rdx
	movq	%rbp, %rdi
	xorl	%eax, %eax
	xorl	%r14d, %r14d
	leaq	.LC46(%rip), %rsi
	movl	$1, %ebx
	call	fprintf@PLT
	jmp	.L6
.L25:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.cfi_endproc
.LFE15:
	.size	emit_string_pool, .-emit_string_pool
	.section	.rodata.str1.1
.LC49:
	.string	"="
.LC50:
	.string	"+="
.LC51:
	.string	"-="
.LC52:
	.string	"*="
.LC53:
	.string	"/="
.LC54:
	.string	"%="
.LC55:
	.string	"<<="
.LC56:
	.string	">>="
.LC57:
	.string	"&="
.LC58:
	.string	"|="
	.text
	.p2align 4
	.type	assignment_op_to_c, @function
assignment_op_to_c:
.LFB30:
	.cfi_startproc
	leal	-21(%rdi), %eax
	cmpl	$25, %eax
	ja	.L32
	leaq	.L34(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L34:
	.long	.L43-.L34
	.long	.L32-.L34
	.long	.L32-.L34
	.long	.L32-.L34
	.long	.L32-.L34
	.long	.L32-.L34
	.long	.L32-.L34
	.long	.L32-.L34
	.long	.L32-.L34
	.long	.L32-.L34
	.long	.L32-.L34
	.long	.L32-.L34
	.long	.L32-.L34
	.long	.L32-.L34
	.long	.L32-.L34
	.long	.L32-.L34
	.long	.L32-.L34
	.long	.L44-.L34
	.long	.L41-.L34
	.long	.L40-.L34
	.long	.L39-.L34
	.long	.L38-.L34
	.long	.L37-.L34
	.long	.L36-.L34
	.long	.L35-.L34
	.long	.L33-.L34
	.text
	.p2align 4,,10
	.p2align 3
.L44:
	leaq	.LC50(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L32:
	jmp	tk_name@PLT
	.p2align 4,,10
	.p2align 3
.L41:
	leaq	.LC51(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L40:
	leaq	.LC52(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L39:
	leaq	.LC53(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L38:
	leaq	.LC54(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L37:
	leaq	.LC55(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L36:
	leaq	.LC56(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L35:
	leaq	.LC57(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L33:
	leaq	.LC58(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L43:
	leaq	.LC49(%rip), %rax
	ret
	.cfi_endproc
.LFE30:
	.size	assignment_op_to_c, .-assignment_op_to_c
	.p2align 4
	.type	collect_cases, @function
collect_cases:
.LFB37:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L66
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	leaq	.L49(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
.L47:
	cmpl	$13, (%rbx)
	ja	.L45
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L49:
	.long	.L45-.L49
	.long	.L53-.L49
	.long	.L45-.L49
	.long	.L52-.L49
	.long	.L51-.L49
	.long	.L45-.L49
	.long	.L45-.L49
	.long	.L45-.L49
	.long	.L45-.L49
	.long	.L45-.L49
	.long	.L45-.L49
	.long	.L51-.L49
	.long	.L45-.L49
	.long	.L48-.L49
	.text
	.p2align 4,,10
	.p2align 3
.L53:
	xorl	%r12d, %r12d
	cmpq	$0, 24(%rbx)
	je	.L45
.L54:
	movq	16(%rbx), %rax
	movq	%rbp, %rsi
	movq	(%rax,%r12,8), %rdi
	addq	$1, %r12
	call	collect_cases
	cmpq	24(%rbx), %r12
	jb	.L54
.L45:
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
.L51:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L55:
	testq	%rbx, %rbx
	jne	.L47
	jmp	.L45
	.p2align 4,,10
	.p2align 3
.L48:
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
.L52:
	.cfi_restore_state
	movq	24(%rbx), %rdi
	movq	%rbp, %rsi
	call	collect_cases
	movq	32(%rbx), %rbx
	jmp	.L55
	.p2align 4,,10
	.p2align 3
.L66:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE37:
	.size	collect_cases, .-collect_cases
	.p2align 4
	.type	get_string_id, @function
get_string_id:
.LFB14:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%r13, 24(%rsp)
	.cfi_offset 13, -24
	movq	8+string_pool(%rip), %r13
	movq	%r12, 16(%rsp)
	.cfi_offset 12, -32
	movq	%rdi, %r12
	movq	%rbx, (%rsp)
	testq	%r13, %r13
	.cfi_offset 3, -48
	je	.L70
	movq	%r14, 32(%rsp)
	xorl	%ebx, %ebx
	.cfi_offset 14, -16
	movq	string_pool(%rip), %r14
	movq	%rbp, 8(%rsp)
	.cfi_offset 6, -40
	jmp	.L73
	.p2align 4,,10
	.p2align 3
.L71:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L79
.L73:
	movq	(%r14,%rbx,8), %rbp
	movq	%r12, %rsi
	movq	0(%rbp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L71
	movl	8(%rbp), %eax
	movq	32(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	movq	8(%rsp), %rbp
	.cfi_restore 6
	jmp	.L69
	.p2align 4,,10
	.p2align 3
.L79:
	.cfi_restore_state
	movq	8(%rsp), %rbp
	.cfi_restore 6
	movq	32(%rsp), %r14
	.cfi_restore 14
.L70:
	movl	$16, %edi
	call	xmalloc@PLT
	movq	%r12, %rdi
	movq	%rax, %rbx
	call	sdup@PLT
	movq	%rbx, %rsi
	leaq	string_pool(%rip), %rdi
	movq	%rax, (%rbx)
	movq	8+string_pool(%rip), %rax
	movl	%eax, 8(%rbx)
	call	vec_push@PLT
	movl	8(%rbx), %eax
.L69:
	movq	(%rsp), %rbx
	movq	16(%rsp), %r12
	movq	24(%rsp), %r13
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE14:
	.size	get_string_id, .-get_string_id
	.p2align 4
	.type	collect_strings_expr, @function
collect_strings_expr:
.LFB26:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L103
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L84(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L82:
	cmpl	$10, (%rbx)
	ja	.L80
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L84:
	.long	.L80-.L84
	.long	.L92-.L84
	.long	.L80-.L84
	.long	.L91-.L84
	.long	.L83-.L84
	.long	.L107-.L84
	.long	.L107-.L84
	.long	.L106-.L84
	.long	.L106-.L84
	.long	.L85-.L84
	.long	.L83-.L84
	.text
	.p2align 4,,10
	.p2align 3
.L83:
	movq	16(%rbx), %rdi
	call	collect_strings_expr
.L107:
	movq	24(%rbx), %rbx
.L94:
	testq	%rbx, %rbx
	jne	.L82
.L80:
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
	movq	16(%rbx), %rdi
	call	collect_strings_expr
.L106:
	movq	24(%rbx), %rdi
	call	collect_strings_expr
	movq	32(%rbx), %rbx
	jmp	.L94
	.p2align 4,,10
	.p2align 3
.L91:
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	cmpq	$0, 32(%rbx)
	je	.L80
	xorl	%ebp, %ebp
.L93:
	movq	24(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_expr
	cmpq	32(%rbx), %rbp
	jb	.L93
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
.L92:
	.cfi_restore_state
	movq	16(%rbx), %rdi
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
.L103:
	ret
	.cfi_endproc
.LFE26:
	.size	collect_strings_expr, .-collect_strings_expr
	.p2align 4
	.type	collect_strings_init, @function
collect_strings_init:
.LFB27:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L117
	movl	(%rdi), %eax
	testl	%eax, %eax
	je	.L120
	cmpl	$1, %eax
	je	.L121
.L117:
	ret
	.p2align 4,,10
	.p2align 3
.L120:
	movq	16(%rdi), %rdi
	jmp	collect_strings_expr
	.p2align 4,,10
	.p2align 3
.L121:
	cmpq	$0, 24(%rdi)
	je	.L117
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	xorl	%ebp, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L111:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_init
	cmpq	24(%rbx), %rbp
	jb	.L111
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE27:
	.size	collect_strings_init, .-collect_strings_init
	.p2align 4
	.type	collect_strings_stmt, @function
collect_strings_stmt:
.LFB28:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L143
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L126(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L124:
	cmpl	$12, (%rbx)
	ja	.L122
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L126:
	.long	.L122-.L126
	.long	.L132-.L126
	.long	.L122-.L126
	.long	.L131-.L126
	.long	.L125-.L126
	.long	.L128-.L126
	.long	.L128-.L126
	.long	.L122-.L126
	.long	.L122-.L126
	.long	.L122-.L126
	.long	.L122-.L126
	.long	.L127-.L126
	.long	.L125-.L126
	.text
	.p2align 4,,10
	.p2align 3
.L132:
	cmpq	$0, 24(%rbx)
	je	.L122
	xorl	%ebp, %ebp
.L133:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_stmt
	cmpq	24(%rbx), %rbp
	jb	.L133
.L122:
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
.L128:
	.cfi_restore_state
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
.L125:
	.cfi_restore_state
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rbx
.L134:
	testq	%rbx, %rbx
	jne	.L124
	jmp	.L122
	.p2align 4,,10
	.p2align 3
.L127:
	movq	24(%rbx), %rbx
	jmp	.L134
	.p2align 4,,10
	.p2align 3
.L131:
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rdi
	call	collect_strings_stmt
	movq	32(%rbx), %rbx
	jmp	.L134
	.p2align 4,,10
	.p2align 3
.L143:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE28:
	.size	collect_strings_stmt, .-collect_strings_stmt
	.p2align 4
	.type	collect_strings_program, @function
collect_strings_program:
.LFB29:
	.cfi_startproc
	cmpq	$0, 8(%rdi)
	je	.L157
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
	jmp	.L151
	.p2align 4,,10
	.p2align 3
.L149:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L160
.L151:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L161
	cmpl	$2, %eax
	je	.L162
	testl	%eax, %eax
	jne	.L149
	movq	8(%rdx), %rdi
	addq	$1, %rbx
	call	collect_strings_stmt
	cmpq	8(%rbp), %rbx
	jb	.L151
.L160:
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
.L161:
	.cfi_restore_state
	movq	8(%rdx), %rax
	movq	32(%rax), %rdi
	call	collect_strings_stmt
	jmp	.L149
	.p2align 4,,10
	.p2align 3
.L162:
	movq	8(%rdx), %r12
	movq	48(%r12), %rdi
	call	collect_strings_init
	movq	24(%r12), %rdi
	testq	%rdi, %rdi
	je	.L149
	call	collect_strings_expr
	jmp	.L149
	.p2align 4,,10
	.p2align 3
.L157:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE29:
	.size	collect_strings_program, .-collect_strings_program
	.section	.rodata.str1.1
.LC59:
	.string	"auto"
.LC60:
	.string	"__empty"
.LC61:
	.string	"%02X"
.LC62:
	.string	"_%02X"
.LC63:
	.string	"%s_%d"
.LC64:
	.string	"b_%s"
	.text
	.p2align 4
	.type	get_mangled_name, @function
get_mangled_name:
.LFB21:
	.cfi_startproc
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movq	%rbp, 32(%rsp)
	testq	%rdi, %rdi
	.cfi_offset 6, -48
	je	.L194
	movq	%r12, 40(%rsp)
	.cfi_offset 12, -40
	movq	8+name_map(%rip), %r12
	movq	%r13, 48(%rsp)
	.cfi_offset 13, -32
	movq	%rdi, %r13
	movq	%rbx, 24(%rsp)
	movq	%r14, 56(%rsp)
	testq	%r12, %r12
	.cfi_offset 3, -56
	.cfi_offset 14, -24
	je	.L165
	movq	name_map(%rip), %r14
	xorl	%ebx, %ebx
	jmp	.L167
	.p2align 4,,10
	.p2align 3
.L166:
	addq	$1, %rbx
	cmpq	%r12, %rbx
	je	.L165
.L167:
	movq	(%r14,%rbx,8), %rbp
	movq	%r13, %rsi
	movq	0(%rbp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L166
	movq	8(%rbp), %rbp
	movq	24(%rsp), %rbx
	.cfi_restore 3
	movq	40(%rsp), %r12
	.cfi_restore 12
	movq	48(%rsp), %r13
	.cfi_restore 13
	movq	56(%rsp), %r14
	.cfi_restore 14
.L163:
	movq	%rbp, %rax
	movq	32(%rsp), %rbp
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L165:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -56
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	cmpb	$0, 0(%r13)
	je	.L211
	movq	%r13, %rdi
	call	strlen@PLT
	leaq	16(,%rax,4), %rdi
	movq	%rax, %r14
	call	xmalloc@PLT
	movzbl	0(%r13), %edx
	movq	%rax, %rbp
	leaq	1(%rax), %r12
	leal	-65(%rdx), %eax
	cmpb	$57, %al
	ja	.L170
	movabsq	$288230372997595135, %rcx
	btq	%rax, %rcx
	jnc	.L170
	movb	%dl, 0(%rbp)
.L174:
	cmpq	$1, %r14
	jbe	.L175
	movq	%r15, 64(%rsp)
	leaq	1(%r13), %rbx
	addq	%r13, %r14
	.cfi_offset 15, -16
	movabsq	$149533581247487, %r15
	jmp	.L182
	.p2align 4,,10
	.p2align 3
.L213:
	cmpb	$47, %dl
	jle	.L177
	leal	-48(%rdx), %eax
	btq	%rax, %r15
	jnc	.L179
.L178:
	movb	%dl, (%r12)
	addq	$1, %r12
.L181:
	addq	$1, %rbx
	cmpq	%rbx, %r14
	je	.L212
.L182:
	movzbl	(%rbx), %edx
	cmpb	$95, %dl
	jle	.L213
	leal	-97(%rdx), %eax
	cmpb	$25, %al
	jbe	.L178
.L179:
	movq	%r12, %rdi
	leaq	.LC62(%rip), %rsi
	xorl	%eax, %eax
	addq	$1, %rbx
	call	sprintf@PLT
	addq	$3, %r12
	cmpq	%rbx, %r14
	jne	.L182
.L212:
	movq	64(%rsp), %r15
	.cfi_restore 15
.L175:
	movb	$0, (%r12)
	jmp	.L169
	.p2align 4,,10
	.p2align 3
.L211:
	leaq	.LC60(%rip), %rdi
	call	sdup@PLT
	movq	%rax, %rbp
.L169:
	leaq	c_keywords(%rip), %rbx
	leaq	.LC59(%rip), %rsi
	jmp	.L184
	.p2align 4,,10
	.p2align 3
.L214:
	movq	8(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L193
.L184:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L214
	movq	%rbp, %rdi
	call	strlen@PLT
	leaq	3(%rax), %rdi
	call	xmalloc@PLT
	movq	%rbp, %rdx
	leaq	.LC64(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %rbx
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	%rbp, %rdi
	movq	%rbx, %rbp
	call	free@PLT
.L193:
	movq	8+name_map(%rip), %r12
	testq	%r12, %r12
	je	.L210
	movq	name_map(%rip), %r14
	xorl	%ebx, %ebx
	jmp	.L188
	.p2align 4,,10
	.p2align 3
.L215:
	addq	$1, %rbx
	cmpq	%r12, %rbx
	je	.L210
.L188:
	movq	(%r14,%rbx,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L215
	movq	%rbp, %rdi
	movq	%r15, 64(%rsp)
	.cfi_offset 15, -16
	call	strlen@PLT
	leaq	16(%rax), %rdi
	call	xmalloc@PLT
	movl	$2, 4(%rsp)
	movq	%rax, %r12
	leaq	name_map(%rip), %rax
	movq	%rax, 8(%rsp)
	.p2align 4
	.p2align 3
.L191:
	movl	4(%rsp), %r15d
	movq	%rbp, %rdx
	movq	%r12, %rdi
	xorl	%eax, %eax
	leaq	.LC63(%rip), %rsi
	movl	%r15d, %ecx
	call	sprintf@PLT
	movq	8(%rsp), %rax
	movq	8(%rax), %rbx
	testq	%rbx, %rbx
	je	.L190
	addl	$1, %r15d
	xorl	%r14d, %r14d
	movl	%r15d, 4(%rsp)
	movq	(%rax), %r15
	.p2align 4
	.p2align 3
.L192:
	movq	(%r15,%r14,8), %rax
	movq	%r12, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L191
	addq	$1, %r14
	cmpq	%r14, %rbx
	jne	.L192
.L190:
	movq	%rbp, %rdi
	movq	%r12, %rbp
	call	free@PLT
	movq	64(%rsp), %r15
	.cfi_restore 15
	jmp	.L186
	.p2align 4,,10
	.p2align 3
.L210:
	leaq	name_map(%rip), %rax
	movq	%rax, 8(%rsp)
.L186:
	movl	$16, %edi
	call	xmalloc@PLT
	movq	%r13, %rdi
	movq	%rax, %rbx
	call	sdup@PLT
	movq	%rbp, 8(%rbx)
	movq	8(%rsp), %rdi
	movq	%rbx, %rsi
	movq	%rax, (%rbx)
	call	vec_push@PLT
	movq	%rbp, %rax
	movq	24(%rsp), %rbx
	.cfi_remember_state
	.cfi_restore 3
	movq	40(%rsp), %r12
	.cfi_restore 12
	movq	48(%rsp), %r13
	.cfi_restore 13
	movq	56(%rsp), %r14
	.cfi_restore 14
	movq	32(%rsp), %rbp
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	ret
.L170:
	.cfi_restore_state
	movb	$95, 0(%rbp)
	movzbl	0(%r13), %eax
	cmpb	$46, %al
	jne	.L216
	movb	$95, 1(%rbp)
	leaq	2(%rbp), %r12
	jmp	.L174
	.p2align 4,,10
	.p2align 3
.L177:
	.cfi_offset 15, -16
	cmpb	$46, %dl
	jne	.L179
	movb	$95, (%r12)
	addq	$1, %r12
	jmp	.L181
.L194:
	.cfi_restore 3
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	xorl	%ebp, %ebp
	jmp	.L163
.L216:
	.cfi_offset 3, -56
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	movzbl	%al, %edx
	movq	%r12, %rdi
	leaq	.LC61(%rip), %rsi
	xorl	%eax, %eax
	call	sprintf@PLT
	leaq	3(%rbp), %r12
	jmp	.L174
	.cfi_endproc
.LFE21:
	.size	get_mangled_name, .-get_mangled_name
	.section	.rodata.str1.1
.LC65:
	.string	"main"
.LC66:
	.string	"b_main"
.LC67:
	.string	"extern word "
.LC68:
	.string	"();\n"
	.text
	.p2align 4
	.type	emit_known_external_function_prototypes, @function
emit_known_external_function_prototypes:
.LFB24:
	.cfi_startproc
	cmpq	$0, 8+g_known_functions(%rip)
	je	.L240
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
	leaq	g_known_functions(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	xorl	%ebp, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movq	%rsi, 8(%rsp)
	movq	%rdi, 24(%rsp)
	movl	$0, 20(%rsp)
	.p2align 4
	.p2align 3
.L224:
	movq	(%r12), %rax
	leaq	.LC65(%rip), %rsi
	movq	(%rax,%rbp,8), %rbx
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L222
	leaq	.LC66(%rip), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L222
	movq	8(%rsp), %rax
	movq	8(%rax), %r13
	testq	%r13, %r13
	je	.L220
	movq	(%rax), %r14
	xorl	%r15d, %r15d
	jmp	.L223
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L221:
	addq	$1, %r15
	cmpq	%r15, %r13
	je	.L220
.L223:
	movq	(%r14,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L221
	movq	8(%rax), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L221
	.p2align 4
	.p2align 3
.L222:
	addq	$1, %rbp
	cmpq	8(%r12), %rbp
	jb	.L224
.L244:
	movl	20(%rsp), %eax
	testl	%eax, %eax
	jne	.L243
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
.L220:
	.cfi_restore_state
	movq	24(%rsp), %r14
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC67(%rip), %rdi
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
	leaq	.LC68(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 20(%rsp)
	cmpq	8(%r12), %rbp
	jb	.L224
	jmp	.L244
.L243:
	movq	24(%rsp), %rsi
	addq	$40, %rsp
	.cfi_def_cfa_offset 56
	movl	$10, %edi
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
.L240:
	ret
	.cfi_endproc
.LFE24:
	.size	emit_known_external_function_prototypes, .-emit_known_external_function_prototypes
	.p2align 4
	.type	edge_words_total.part.0.isra.0, @function
edge_words_total.part.0.isra.0:
.LFB62:
	.cfi_startproc
	movl	$1, %r9d
	testq	%rsi, %rsi
	je	.L258
	cmovne	%rsi, %r9
	movq	%rsi, %rcx
	movq	%rdi, %r8
	xorl	%edx, %edx
.L259:
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L261
	cmpl	$1, (%rax)
	je	.L263
.L261:
	addq	$1, %rdx
	cmpq	%rcx, %rdx
	jne	.L259
.L258:
	movq	%r9, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L263:
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
.L262:
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	movq	%rcx, 24(%rsp)
	movq	%r8, 16(%rsp)
	movq	%r9, 8(%rsp)
	movq	%rdx, (%rsp)
	call	edge_words_total.part.0.isra.0
	movq	8(%rsp), %r9
	movq	24(%rsp), %rcx
	movq	16(%rsp), %r8
	movq	(%rsp), %rdx
	addq	%rax, %r9
.L249:
	addq	$1, %rdx
	cmpq	%rcx, %rdx
	je	.L265
.L250:
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L249
	cmpl	$1, (%rax)
	je	.L262
	addq	$1, %rdx
	cmpq	%rcx, %rdx
	jne	.L250
.L265:
	movq	%r9, %rax
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE62:
	.size	edge_words_total.part.0.isra.0, .-edge_words_total.part.0.isra.0
	.section	.rodata.str1.1
.LC69:
	.string	"  "
	.text
	.p2align 4
	.globl	emit_indent
	.type	emit_indent, @function
emit_indent:
.LFB31:
	.cfi_startproc
	testl	%esi, %esi
	jle	.L271
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movl	%esi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L268:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %ebx
	leaq	.LC69(%rip), %rdi
	call	fwrite@PLT
	cmpl	%ebx, %ebp
	jne	.L268
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L271:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE31:
	.size	emit_indent, .-emit_indent
	.section	.rodata.str1.1
.LC70:
	.string	"#line %d \"%s\"\n"
	.text
	.p2align 4
	.globl	emit_line_directive
	.type	emit_line_directive, @function
emit_line_directive:
.LFB32:
	.cfi_startproc
	movl	g_no_line(%rip), %eax
	testl	%eax, %eax
	jne	.L274
	testq	%rdx, %rdx
	jne	.L282
.L274:
	ret
	.p2align 4,,10
	.p2align 3
.L282:
	movq	%rdx, %rcx
	xorl	%eax, %eax
	movl	%esi, %edx
	leaq	.LC70(%rip), %rsi
	jmp	fprintf@PLT
	.cfi_endproc
.LFE32:
	.size	emit_line_directive, .-emit_line_directive
	.section	.rodata.str1.1
.LC71:
	.string	"\\n"
.LC72:
	.string	"\\t"
.LC73:
	.string	"\\x%02x"
	.text
	.p2align 4
	.globl	emit_c_string
	.type	emit_c_string, @function
emit_c_string:
.LFB33:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	movq	%rdi, %rsi
	movl	$34, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	call	fputc@PLT
	movzbl	0(%rbp), %ebx
	testb	%bl, %bl
	jne	.L291
	jmp	.L284
	.p2align 4,,10
	.p2align 3
.L300:
	leaq	.LC73(%rip), %rsi
	movq	%r12, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L287:
	movzbl	1(%rbp), %ebx
	addq	$1, %rbp
	testb	%bl, %bl
	je	.L284
.L291:
	cmpb	$92, %bl
	je	.L292
	cmpb	$34, %bl
	je	.L292
	cmpb	$10, %bl
	je	.L298
	cmpb	$9, %bl
	je	.L299
	movzbl	%bl, %edx
	cmpb	$31, %bl
	jbe	.L300
	movq	%r12, %rsi
	movl	%edx, %edi
	addq	$1, %rbp
	call	fputc@PLT
	movzbl	0(%rbp), %ebx
	testb	%bl, %bl
	jne	.L291
.L284:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%r12, %rsi
	popq	%rbp
	.cfi_def_cfa_offset 16
	movl	$34, %edi
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	fputc@PLT
	.p2align 4,,10
	.p2align 3
.L292:
	.cfi_restore_state
	movq	%r12, %rsi
	movl	$92, %edi
	call	fputc@PLT
	movzbl	%bl, %edi
	movq	%r12, %rsi
	call	fputc@PLT
	jmp	.L287
	.p2align 4,,10
	.p2align 3
.L298:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC71(%rip), %rdi
	call	fwrite@PLT
	jmp	.L287
	.p2align 4,,10
	.p2align 3
.L299:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC72(%rip), %rdi
	call	fwrite@PLT
	jmp	.L287
	.cfi_endproc
.LFE33:
	.size	emit_c_string, .-emit_c_string
	.section	.rodata.str1.1
.LC0:
	.string	"char"
.LC74:
	.string	"preinc"
.LC75:
	.string	"predec"
.LC76:
	.string	"postinc"
.LC77:
	.string	"postdec"
.LC78:
	.string	"WADD"
.LC79:
	.string	"WOR"
.LC80:
	.string	"WAND"
.LC81:
	.string	"WSHR"
.LC82:
	.string	"WSHL"
.LC83:
	.string	"WMOD"
.LC84:
	.string	"WDIV"
.LC85:
	.string	"WMUL"
.LC86:
	.string	"WSUB"
.LC87:
	.string	"add_assign"
.LC88:
	.string	"or_assign"
.LC89:
	.string	"and_assign"
.LC90:
	.string	"rsh_assign"
.LC91:
	.string	"lsh_assign"
.LC92:
	.string	"mod_assign"
.LC93:
	.string	"div_assign"
.LC94:
	.string	"mul_assign"
.LC95:
	.string	"sub_assign"
.LC96:
	.string	"((word)%ld)"
.LC97:
	.string	"B_PTR(__b_str%d)"
.LC42:
	.string	"callf"
.LC98:
	.string	"b_callf_dispatch(%zu"
.LC99:
	.string	", "
.LC101:
	.string	"malloc"
.LC8:
	.string	"printf"
.LC102:
	.string	"calloc"
.LC103:
	.string	"realloc"
.LC104:
	.string	"B_PTR("
.LC105:
	.string	"fprintf"
.LC106:
	.string	"dprintf"
.LC107:
	.string	"sprintf"
.LC108:
	.string	"snprintf"
.LC109:
	.string	"-+ #0"
.LC12:
	.string	"exit"
.LC110:
	.string	"strlen"
.LC111:
	.string	"atoi"
.LC112:
	.string	"memmove"
.LC113:
	.string	"tcgetattr"
.LC114:
	.string	"tcsetattr"
.LC115:
	.string	"ioctl"
.LC116:
	.string	"memset"
.LC117:
	.string	"memcpy"
.LC118:
	.string	"__b_cstr("
.LC119:
	.string	"B_CPTR("
	.section	.rodata.str1.8
	.align 8
.LC120:
	.string	"(size_t)(sizeof(word) * (uword)("
	.section	.rodata.str1.1
.LC121:
	.string	"))"
.LC122:
	.string	"B_INDEX("
.LC123:
	.string	"b_char("
.LC124:
	.string	"B_DEREF("
.LC125:
	.string	"(("
.LC126:
	.string	"uword)("
.LC127:
	.string	") * sizeof(word)"
.LC128:
	.string	" + (uword)("
.LC129:
	.string	") * sizeof(word))"
.LC130:
	.string	"B_ADDR("
.LC131:
	.string	"b_"
.LC132:
	.string	"(&("
.LC133:
	.string	"WNEG("
.LC134:
	.string	"%s("
.LC135:
	.string	" %s "
.LC136:
	.string	" = ("
.LC137:
	.string	"), "
.LC138:
	.string	" ? "
.LC139:
	.string	" : "
.LC1:
	.string	"lchar"
.LC2:
	.string	"getchr"
.LC3:
	.string	"putchr"
.LC4:
	.string	"getstr"
.LC5:
	.string	"putstr"
.LC6:
	.string	"flush"
.LC7:
	.string	"reread"
.LC9:
	.string	"printn"
.LC10:
	.string	"putnum"
.LC11:
	.string	"putchar"
.LC13:
	.string	"abort"
.LC14:
	.string	"free"
.LC15:
	.string	"open"
.LC16:
	.string	"close"
.LC17:
	.string	"read"
.LC18:
	.string	"write"
.LC19:
	.string	"creat"
.LC20:
	.string	"seek"
.LC21:
	.string	"openr"
.LC22:
	.string	"openw"
.LC23:
	.string	"fork"
.LC24:
	.string	"wait"
.LC25:
	.string	"execl"
.LC26:
	.string	"execv"
.LC27:
	.string	"chdir"
.LC28:
	.string	"chmod"
.LC29:
	.string	"chown"
.LC30:
	.string	"link"
.LC31:
	.string	"unlink"
.LC32:
	.string	"stat"
.LC33:
	.string	"fstat"
.LC34:
	.string	"time"
.LC35:
	.string	"ctime"
.LC36:
	.string	"getuid"
.LC37:
	.string	"setuid"
.LC38:
	.string	"makdir"
.LC39:
	.string	"intr"
.LC40:
	.string	"system"
.LC41:
	.string	"usleep"
.LC43:
	.string	"argc"
.LC44:
	.string	"argv"
	.data
	.align 32
.LC100:
	.quad	.LC0
	.quad	.LC1
	.quad	.LC2
	.quad	.LC3
	.quad	.LC4
	.quad	.LC5
	.quad	.LC6
	.quad	.LC7
	.quad	.LC8
	.quad	.LC9
	.quad	.LC10
	.quad	.LC11
	.quad	.LC12
	.quad	.LC13
	.quad	.LC14
	.quad	.LC15
	.quad	.LC16
	.quad	.LC17
	.quad	.LC18
	.quad	.LC19
	.quad	.LC20
	.quad	.LC21
	.quad	.LC22
	.quad	.LC23
	.quad	.LC24
	.quad	.LC25
	.quad	.LC26
	.quad	.LC27
	.quad	.LC28
	.quad	.LC29
	.quad	.LC30
	.quad	.LC31
	.quad	.LC32
	.quad	.LC33
	.quad	.LC34
	.quad	.LC35
	.quad	.LC36
	.quad	.LC37
	.quad	.LC38
	.quad	.LC39
	.quad	.LC40
	.quad	.LC41
	.quad	.LC42
	.quad	.LC43
	.quad	.LC44
	.quad	0
	.text
	.p2align 4
	.globl	emit_expr
	.type	emit_expr, @function
emit_expr:
.LFB40:
	.cfi_startproc
	subq	$504, %rsp
	.cfi_def_cfa_offset 512
	movq	%rbx, 456(%rsp)
	movq	%rbp, 464(%rsp)
	movq	%r14, 488(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 440(%rsp)
	xorl	%eax, %eax
	cmpl	$10, (%rsi)
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 14, -24
	ja	.L301
	movl	(%rsi), %eax
	movq	%rdx, %rbp
	leaq	.L304(%rip), %rdx
	movq	%rdi, %rbx
	movq	%rsi, %r14
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L304:
	.long	.L314-.L304
	.long	.L313-.L304
	.long	.L312-.L304
	.long	.L311-.L304
	.long	.L310-.L304
	.long	.L309-.L304
	.long	.L308-.L304
	.long	.L307-.L304
	.long	.L306-.L304
	.long	.L305-.L304
	.long	.L303-.L304
	.text
	.p2align 4,,10
	.p2align 3
.L305:
	movq	%rdi, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	16(%r14), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC138(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r14), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$3, %edx
	leaq	.LC139(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r14), %rsi
.L706:
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	440(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L698
	movq	%rbx, %rsi
	movl	$41, %edi
.L697:
	movq	456(%rsp), %rbx
	movq	464(%rsp), %rbp
	movq	488(%rsp), %r14
	addq	$504, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	fputc@PLT
	.p2align 4,,10
	.p2align 3
.L303:
	.cfi_restore_state
	movq	%rdi, %rsi
	movl	$40, %edi
	call	fputc@PLT
.L705:
	movq	16(%r14), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC99(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r14), %rsi
	jmp	.L706
	.p2align 4,,10
	.p2align 3
.L314:
	movq	440(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L698
	movq	16(%rsi), %rdx
	movq	456(%rsp), %rbx
	xorl	%eax, %eax
	leaq	.LC96(%rip), %rsi
	movq	464(%rsp), %rbp
	movq	488(%rsp), %r14
	addq	$504, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L313:
	.cfi_restore_state
	movq	16(%rsi), %rdi
	call	get_string_id
	movq	440(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L698
	movq	464(%rsp), %rbp
	movq	488(%rsp), %r14
	movq	%rbx, %rdi
	movl	%eax, %edx
	movq	456(%rsp), %rbx
	leaq	.LC97(%rip), %rsi
	xorl	%eax, %eax
	addq	$504, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L312:
	.cfi_restore_state
	movq	16(%rsi), %rdi
	testq	%rdi, %rdi
	je	.L301
	call	get_mangled_name
	movq	440(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L698
	movq	464(%rsp), %rbp
	movq	488(%rsp), %r14
	movq	%rbx, %rsi
	movq	%rax, %rdi
	movq	456(%rsp), %rbx
	addq	$504, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	fputs@PLT
	.p2align 4,,10
	.p2align 3
.L311:
	.cfi_restore_state
	movq	16(%rsi), %rcx
	movq	%r12, 472(%rsp)
	movq	%r13, 480(%rsp)
	movq	%r15, 496(%rsp)
	cmpl	$2, (%rcx)
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 15, -16
	je	.L710
	movb	$0, 43(%rsp)
	xorl	%r15d, %r15d
	xorl	%r13d, %r13d
	movl	$0, 44(%rsp)
.L318:
	movq	%rbp, %rdx
	movq	%rcx, %rsi
	movq	%rbx, %rdi
	call	emit_expr
.L334:
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	32(%r14), %rcx
	cmpq	%rcx, %r15
	jnb	.L335
	cmpb	$0, 43(%rsp)
	je	.L335
	movq	24(%r14), %rax
	movq	(%rax,%r15,8), %rax
	movq	%rax, 32(%rsp)
	testq	%rax, %rax
	je	.L336
	cmpl	$1, (%rax)
	je	.L711
	movq	$0, 32(%rsp)
.L336:
	movq	%rcx, 8(%rsp)
	xorl	%r12d, %r12d
	movq	%rbp, 16(%rsp)
	testq	%r13, %r13
	je	.L499
.L713:
	cmpq	%r12, %r15
	movl	current_byteptr(%rip), %ecx
	sete	%al
	andb	43(%rsp), %al
	movl	%ecx, (%rsp)
	movb	%al, 24(%rsp)
	jne	.L366
	movq	32(%rsp), %rax
	testq	%rax, %rax
	je	.L367
	movl	(%rax,%r12,4), %edx
	testl	%edx, %edx
	je	.L367
	testl	%ecx, %ecx
	je	.L368
	.p2align 4
	.p2align 3
.L369:
	movq	%rbx, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
.L396:
	movl	$1, %ebp
.L365:
	movq	24(%r14), %rax
	movq	16(%rsp), %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
.L468:
	testl	%ebp, %ebp
	jne	.L712
.L402:
	addq	$1, %r12
	cmpq	%r12, 8(%rsp)
	je	.L363
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC99(%rip), %rdi
	call	fwrite@PLT
	testq	%r13, %r13
	jne	.L713
.L499:
	xorl	%ebp, %ebp
	jmp	.L365
	.p2align 4,,10
	.p2align 3
.L310:
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 15
	movq	%rdi, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	call	fwrite@PLT
	jmp	.L705
	.p2align 4,,10
	.p2align 3
.L309:
	movq	%r12, 472(%rsp)
	.cfi_offset 12, -40
	movl	16(%rsi), %r12d
	cmpl	$32, %r12d
	je	.L714
	cmpl	$53, %r12d
	je	.L715
	leal	-36(%r12), %eax
	cmpl	$1, %eax
	jbe	.L716
	cmpl	$31, %r12d
	jne	.L425
	movl	current_word_bits(%rip), %esi
	testl	%esi, %esi
	jne	.L717
.L425:
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
	movq	24(%r14), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	440(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L700
	movq	472(%rsp), %r12
	.cfi_restore 12
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC121(%rip), %rdi
	jmp	.L702
	.p2align 4,,10
	.p2align 3
.L308:
	movq	%r12, 472(%rsp)
	.cfi_offset 12, -40
	movq	24(%rsi), %r12
	movq	%r13, 480(%rsp)
	.cfi_offset 13, -32
	movl	16(%rsi), %r13d
	testq	%r12, %r12
	je	.L428
	movl	(%r12), %eax
	cmpl	$4, %eax
	je	.L429
	cmpl	$5, %eax
	jne	.L428
	cmpl	$32, 16(%r12)
	je	.L429
	.p2align 4
	.p2align 3
.L428:
	movl	current_word_bits(%rip), %ecx
	testl	%ecx, %ecx
	je	.L430
.L429:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC131(%rip), %rdi
	call	fwrite@PLT
	cmpl	$36, %r13d
	movq	%rbx, %rcx
	movl	$7, %edx
	leaq	.LC76(%rip), %rax
	leaq	.LC77(%rip), %rdi
	movl	$1, %esi
	cmove	%rax, %rdi
	call	fwrite@PLT
	movl	$3, %edx
	movl	$1, %esi
	movq	%rbx, %rcx
	leaq	.LC132(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movq	440(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L699
.L448:
	movq	472(%rsp), %r12
	.cfi_restore 12
	movq	480(%rsp), %r13
	.cfi_restore 13
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC121(%rip), %rdi
.L702:
	movq	456(%rsp), %rbx
	movq	464(%rsp), %rbp
	movq	488(%rsp), %r14
	addq	$504, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L307:
	.cfi_restore_state
	movl	current_word_bits(%rip), %edx
	movq	%r12, 472(%rsp)
	.cfi_remember_state
	.cfi_offset 12, -40
	movl	16(%rsi), %r12d
	testl	%edx, %edx
	je	.L434
	leal	-28(%r12), %eax
	cmpl	$26, %eax
	ja	.L434
	leaq	.L436(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L436:
	.long	.L444-.L436
	.long	.L443-.L436
	.long	.L442-.L436
	.long	.L441-.L436
	.long	.L440-.L436
	.long	.L439-.L436
	.long	.L438-.L436
	.long	.L434-.L436
	.long	.L434-.L436
	.long	.L434-.L436
	.long	.L434-.L436
	.long	.L434-.L436
	.long	.L434-.L436
	.long	.L434-.L436
	.long	.L434-.L436
	.long	.L434-.L436
	.long	.L434-.L436
	.long	.L434-.L436
	.long	.L434-.L436
	.long	.L434-.L436
	.long	.L434-.L436
	.long	.L434-.L436
	.long	.L434-.L436
	.long	.L434-.L436
	.long	.L434-.L436
	.long	.L505-.L436
	.long	.L435-.L436
	.text
	.p2align 4,,10
	.p2align 3
.L306:
	.cfi_restore_state
	movq	%r12, 472(%rsp)
	.cfi_offset 12, -40
	movl	16(%rsi), %r12d
	movq	%r13, 480(%rsp)
	movq	32(%rsi), %r14
	leal	-47(%r12), %eax
	.cfi_offset 13, -32
	movq	24(%rsi), %r13
	cmpl	$5, %eax
	jbe	.L718
	cmpl	$21, %r12d
	je	.L449
	testq	%r13, %r13
	je	.L450
	movl	0(%r13), %eax
	cmpl	$4, %eax
	je	.L451
	cmpl	$5, %eax
	je	.L719
.L450:
	movl	current_word_bits(%rip), %eax
	testl	%eax, %eax
	je	.L449
.L451:
	leal	-38(%r12), %eax
	cmpl	$8, %eax
	ja	.L449
	leaq	.L454(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L454:
	.long	.L462-.L454
	.long	.L461-.L454
	.long	.L460-.L454
	.long	.L459-.L454
	.long	.L458-.L454
	.long	.L457-.L454
	.long	.L456-.L454
	.long	.L506-.L454
	.long	.L453-.L454
	.text
	.p2align 4,,10
	.p2align 3
.L691:
	.cfi_offset 15, -16
	movq	472(%rsp), %r12
	.cfi_restore 12
	movq	480(%rsp), %r13
	.cfi_restore 13
	movq	496(%rsp), %r15
	.cfi_restore 15
.L301:
	movq	440(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L698
	movq	456(%rsp), %rbx
	movq	464(%rsp), %rbp
	movq	488(%rsp), %r14
	addq	$504, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L335:
	.cfi_def_cfa_offset 512
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 15, -16
	movq	$0, 32(%rsp)
	testq	%r13, %r13
	je	.L362
.L361:
	leaq	.LC12(%rip), %rsi
	movq	%r13, %rdi
	movq	%rcx, (%rsp)
	call	strcmp@PLT
	movq	(%rsp), %rcx
	testl	%eax, %eax
	jne	.L362
	testq	%rcx, %rcx
	jne	.L336
	movq	%rbx, %rsi
	movl	$48, %edi
	call	fputc@PLT
	.p2align 4
	.p2align 3
.L363:
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	movl	44(%rsp), %r9d
	testl	%r9d, %r9d
	je	.L404
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
.L404:
	cmpq	$0, 32(%rsp)
	je	.L691
	movq	440(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L701
	movq	32(%rsp), %rdi
	movq	472(%rsp), %r12
	.cfi_restore 12
	movq	480(%rsp), %r13
	.cfi_restore 13
	movq	496(%rsp), %r15
	.cfi_restore 15
	movq	456(%rsp), %rbx
	movq	464(%rsp), %rbp
	movq	488(%rsp), %r14
	addq	$504, %rsp
	.cfi_def_cfa_offset 8
	jmp	free@PLT
	.p2align 4,,10
	.p2align 3
.L434:
	.cfi_def_cfa_offset 512
	.cfi_offset 12, -40
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	24(%r14), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edi
	call	tk_name@PLT
	leaq	.LC135(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
.L708:
	movq	32(%r14), %rsi
.L707:
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	440(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L700
.L446:
	movq	472(%rsp), %r12
	.cfi_restore 12
	movq	%rbx, %rsi
	movl	$41, %edi
	jmp	.L697
	.p2align 4,,10
	.p2align 3
.L430:
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	movq	%rbx, %rsi
	movl	$40, %edi
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
	movq	440(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L699
	.p2align 4
	.p2align 3
.L465:
	movq	472(%rsp), %r12
	.cfi_restore 12
	movq	480(%rsp), %r13
	.cfi_restore 13
	movq	%rbx, %rsi
	movl	$41, %edi
	jmp	.L697
	.p2align 4,,10
	.p2align 3
.L715:
	.cfi_offset 12, -40
	movq	24(%rsi), %rax
	movq	%rdi, %rcx
	cmpl	$4, (%rax)
	je	.L720
	movl	$1, %esi
	movl	$7, %edx
	leaq	.LC130(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r14), %rsi
	jmp	.L707
.L506:
	.cfi_offset 13, -32
	leaq	.LC89(%rip), %r12
	.p2align 4
	.p2align 3
.L455:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC131(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC132(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC137(%rip), %rdi
	call	fwrite@PLT
.L709:
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movq	440(%rsp), %rax
	subq	%fs:40, %rax
	je	.L465
.L699:
	movq	%r15, 496(%rsp)
	.cfi_offset 15, -16
.L701:
	call	__stack_chk_fail@PLT
.L453:
	.cfi_restore 15
	leaq	.LC88(%rip), %r12
	jmp	.L455
.L462:
	leaq	.LC87(%rip), %r12
	jmp	.L455
.L460:
	leaq	.LC94(%rip), %r12
	jmp	.L455
.L461:
	leaq	.LC95(%rip), %r12
	jmp	.L455
.L456:
	leaq	.LC90(%rip), %r12
	jmp	.L455
.L457:
	leaq	.LC91(%rip), %r12
	jmp	.L455
.L458:
	leaq	.LC92(%rip), %r12
	jmp	.L455
.L459:
	leaq	.LC93(%rip), %r12
	jmp	.L455
.L438:
	.cfi_restore 13
	leaq	.LC83(%rip), %rdx
	.p2align 4
	.p2align 3
.L437:
	movq	%rbx, %rdi
	leaq	.LC134(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	24(%r14), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC99(%rip), %rdi
	call	fwrite@PLT
	jmp	.L708
.L439:
	leaq	.LC84(%rip), %rdx
	jmp	.L437
.L440:
	leaq	.LC85(%rip), %rdx
	jmp	.L437
.L441:
	leaq	.LC86(%rip), %rdx
	jmp	.L437
.L442:
	leaq	.LC78(%rip), %rdx
	jmp	.L437
.L443:
	leaq	.LC81(%rip), %rdx
	jmp	.L437
.L444:
	leaq	.LC82(%rip), %rdx
	jmp	.L437
.L505:
	leaq	.LC80(%rip), %rdx
	jmp	.L437
.L435:
	leaq	.LC79(%rip), %rdx
	jmp	.L437
	.p2align 4,,10
	.p2align 3
.L366:
	.cfi_offset 13, -32
	.cfi_offset 15, -16
	movl	(%rsp), %r10d
	testl	%r10d, %r10d
	jne	.L369
.L368:
	testq	%r12, %r12
	sete	%bpl
.L372:
	leaq	.LC101(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L510
	testb	%bpl, %bpl
	jne	.L483
.L510:
	leaq	.LC103(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L721
	cmpq	$1, %r12
	jne	.L369
.L483:
	movq	%rbx, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
.L397:
	movl	$1, %ebp
.L398:
	movq	%rbx, %rcx
	movl	$32, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r14), %rax
	movq	16(%rsp), %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC121(%rip), %rdi
	call	fwrite@PLT
	jmp	.L468
	.p2align 4,,10
	.p2align 3
.L712:
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L402
	.p2align 4,,10
	.p2align 3
.L367:
	leaq	.LC110(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L370
	testq	%r12, %r12
	je	.L722
.L371:
	leaq	.LC112(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L373
	cmpq	$1, %r12
	jbe	.L723
.L375:
	leaq	.LC114(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	movl	%eax, %ebp
	testl	%eax, %eax
	jne	.L378
	cmpq	$2, %r12
	je	.L379
.L374:
	leaq	.LC116(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testq	%r12, %r12
	sete	24(%rsp)
	testl	%eax, %eax
	sete	%al
	andb	24(%rsp), %al
	movl	%eax, %edx
	jne	.L724
	leaq	.LC117(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L389
	cmpq	$1, %r12
	jbe	.L387
	leaq	.LC103(%rip), %rax
	movq	%r13, %rdi
	movq	%rax, %rsi
	movq	%rax, 48(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L392
	movb	$0, 24(%rsp)
.L393:
	leaq	.LC102(%rip), %rdx
	movq	%r13, %rdi
	movq	%rdx, %rsi
	movq	%rdx, 56(%rsp)
	call	strcmp@PLT
	movl	(%rsp), %r11d
	leaq	.LC102(%rip), %rdx
	testl	%eax, %eax
	sete	%al
	andb	24(%rsp), %al
	xorl	$1, %eax
	movzbl	%al, %eax
	andl	%eax, %ebp
	testl	%r11d, %r11d
	jne	.L392
	leaq	.LC101(%rip), %rsi
	movq	%r13, %rdi
	movq	%rdx, (%rsp)
	call	strcmp@PLT
	movq	(%rsp), %rdx
	testl	%eax, %eax
	jne	.L511
	cmpb	$0, 24(%rsp)
	je	.L511
.L473:
	testl	%ebp, %ebp
	je	.L398
.L400:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC119(%rip), %rdi
	call	fwrite@PLT
	jmp	.L397
	.p2align 4,,10
	.p2align 3
.L721:
	leaq	.LC102(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L369
	cmpq	$1, %r12
	je	.L483
	jmp	.L369
	.p2align 4,,10
	.p2align 3
.L449:
	.cfi_restore 15
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edi
	call	assignment_op_to_c
	leaq	.LC135(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L709
	.p2align 4,,10
	.p2align 3
.L373:
	.cfi_offset 15, -16
	leaq	.LC113(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L375
	cmpq	$1, %r12
	jne	.L375
	leaq	.LC117(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L386
.L387:
	movl	(%rsp), %eax
	testl	%eax, %eax
	jne	.L384
	movq	%r12, %rax
	xorq	$1, %rax
	movl	%eax, %edx
	andl	$1, %edx
.L383:
	leaq	.LC101(%rip), %rsi
	movq	%r13, %rdi
	movb	%dl, (%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L512
	cmpb	$0, (%rsp)
	jne	.L400
.L512:
	leaq	.LC103(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L478
	movl	$1, %ebp
	leaq	.LC102(%rip), %rdx
.L476:
	movq	%rdx, %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L392
.L704:
	cmpq	$1, %r12
	je	.L473
	.p2align 4
	.p2align 3
.L392:
	testl	%ebp, %ebp
	je	.L365
.L384:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC119(%rip), %rdi
	call	fwrite@PLT
	jmp	.L396
	.p2align 4,,10
	.p2align 3
.L370:
	leaq	.LC111(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%bpl
	testq	%r12, %r12
	sete	%al
	andb	%al, %bpl
	je	.L371
	movl	(%rsp), %eax
	testl	%eax, %eax
	je	.L372
	jmp	.L369
	.p2align 4,,10
	.p2align 3
.L714:
	.cfi_restore 13
	.cfi_restore 15
	movq	24(%rsi), %rax
	cmpl	$7, (%rax)
	jne	.L408
	cmpl	$30, 16(%rax)
	jne	.L408
	movq	24(%rax), %r12
	movq	%r13, 480(%rsp)
	.cfi_offset 13, -32
	movq	32(%rax), %r13
	cmpl	$1, (%r12)
	je	.L502
	cmpl	$1, 0(%r13)
	je	.L409
	movq	480(%rsp), %r13
	.cfi_restore 13
.L408:
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$8, %edx
	leaq	.LC124(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r14), %rsi
	jmp	.L707
	.p2align 4,,10
	.p2align 3
.L710:
	.cfi_offset 13, -32
	.cfi_offset 15, -16
	movq	16(%rcx), %r13
	leaq	.LC42(%rip), %rsi
	movq	%rcx, (%rsp)
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L725
	leaq	.LC100(%rip), %rsi
	movl	$368, %edx
	leaq	64(%rsp), %rdi
	movq	%rbx, %r15
	call	memcpy@PLT
	leaq	64(%rsp), %rbx
	movq	(%rsp), %r12
	leaq	.LC0(%rip), %rsi
	jmp	.L324
	.p2align 4,,10
	.p2align 3
.L727:
	movq	8(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L726
.L324:
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L727
	leaq	.LC101(%rip), %rsi
	movq	%r13, %rdi
	movq	%r12, (%rsp)
	movq	%r15, %rbx
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L488
	leaq	.LC102(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L488
	leaq	.LC8(%rip), %rsi
	movq	%r13, %rdi
	movl	$1, %r12d
	call	strcmp@PLT
	movq	(%rsp), %rcx
	orl	$1, %eax
	movl	%eax, 44(%rsp)
.L326:
	leaq	.LC103(%rip), %rsi
	movq	%r13, %rdi
	movq	%rcx, (%rsp)
	call	strcmp@PLT
	movl	44(%rsp), %r8d
	movq	(%rsp), %rcx
	movl	%eax, 8(%rsp)
	testl	%r8d, %r8d
	jne	.L329
	movb	$1, 43(%rsp)
	xorl	%r15d, %r15d
	testl	%eax, %eax
	jne	.L318
.L327:
	movq	%rbx, %rcx
	movl	$6, %edx
	movl	$1, %esi
	xorl	%r15d, %r15d
	leaq	.LC104(%rip), %rdi
	call	fwrite@PLT
	movb	$1, 43(%rsp)
	movq	16(%r14), %rcx
	movl	$1, 44(%rsp)
	jmp	.L318
.L711:
	movq	16(%rax), %r8
	movq	%rcx, %rdi
	movl	$4, %esi
	movq	%rcx, (%rsp)
	movq	%r8, 8(%rsp)
	call	calloc@PLT
	movq	(%rsp), %rcx
	testq	%rax, %rax
	movq	%rax, 32(%rsp)
	je	.L336
	movq	8(%rsp), %r8
	movzbl	(%r8), %eax
	testb	%al, %al
	je	.L336
	movq	%r14, 16(%rsp)
	leaq	1(%r15), %r12
	movq	%r13, (%rsp)
	xorl	%r13d, %r13d
	movq	%rbx, 8(%rsp)
	movq	%rcx, %rbx
	movq	%rbp, 24(%rsp)
	movq	%r8, %rbp
	.p2align 4
	.p2align 3
.L359:
	cmpb	$37, %al
	jne	.L693
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	cmpb	$37, %r14b
	je	.L693
	testb	%r14b, %r14b
	jne	.L339
	jmp	.L688
	.p2align 4,,10
	.p2align 3
.L341:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	testb	%r14b, %r14b
	je	.L340
.L339:
	movsbl	%r14b, %esi
	leaq	.LC109(%rip), %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L341
	cmpb	$42, %r14b
	jne	.L340
	cmpq	%rbx, %r12
	adcq	$0, %r12
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
.L346:
	cmpb	$46, %r14b
	je	.L728
.L347:
	cmpb	$104, %r14b
	je	.L729
	cmpb	$108, %r14b
	jne	.L352
	leaq	1(%r13), %rax
	cmpb	$108, 1(%rbp,%r13)
	je	.L497
.L355:
	addq	$1, %r12
.L338:
	movq	%rax, %r13
	movzbl	0(%rbp,%rax), %eax
	testb	%al, %al
	jne	.L359
	movq	(%rsp), %r13
	movq	%rbx, %rcx
	movq	16(%rsp), %r14
	movq	8(%rsp), %rbx
	movq	24(%rsp), %rbp
	testq	%r13, %r13
	je	.L336
	.p2align 4
	.p2align 3
.L362:
	testq	%rcx, %rcx
	jne	.L336
	jmp	.L363
.L386:
	movl	$1, %ebp
.L389:
	leaq	.LC103(%rip), %rax
	movq	%r13, %rdi
	movq	%rax, %rsi
	movq	%rax, 48(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L393
	movzbl	24(%rsp), %eax
	orl	%eax, %ebp
	movl	(%rsp), %eax
	testl	%eax, %eax
	jne	.L392
	leaq	.LC101(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L704
	cmpb	$0, 24(%rsp)
	jne	.L473
	jmp	.L704
	.p2align 4,,10
	.p2align 3
.L718:
	.cfi_restore 15
	leaq	CSWTCH.111(%rip), %rdx
	movq	%rdi, %rsi
	movl	$40, %edi
	movl	(%rdx,%rax,4), %r12d
	call	fputc@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC136(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edi
	call	tk_name@PLT
	leaq	.LC135(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movq	440(%rsp), %rax
	subq	%fs:40, %rax
	je	.L448
	jmp	.L699
	.p2align 4,,10
	.p2align 3
.L378:
	.cfi_offset 15, -16
	leaq	.LC115(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L509
	cmpq	$2, %r12
	je	.L379
.L509:
	xorl	%ebp, %ebp
	jmp	.L374
.L379:
	leaq	.LC117(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L386
	leaq	.LC103(%rip), %rax
	movq	%r13, %rdi
	movq	%rax, %rsi
	movq	%rax, 48(%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L384
	movl	$1, %ebp
	jmp	.L393
	.p2align 4,,10
	.p2align 3
.L726:
	leaq	.LC101(%rip), %rsi
	movq	%r13, %rdi
	movq	%r12, (%rsp)
	movq	%r15, %rbx
	call	strcmp@PLT
	leaq	.LC8(%rip), %rsi
	movq	%r13, %rdi
	movl	%eax, %r12d
	call	strcmp@PLT
	movl	%eax, 44(%rsp)
	testl	%r12d, %r12d
	je	.L325
	leaq	.LC102(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	movq	(%rsp), %rcx
	testl	%eax, %eax
	je	.L325
	xorl	%r12d, %r12d
	jmp	.L326
	.p2align 4,,10
	.p2align 3
.L325:
	movl	44(%rsp), %r9d
	testl	%r9d, %r9d
	je	.L327
	movl	$0, 44(%rsp)
.L328:
	leaq	.LC105(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L480
	leaq	.LC106(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L480
	leaq	.LC107(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L480
	leaq	.LC108(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	cmpl	$1, %eax
	setb	43(%rsp)
	sbbq	%rax, %rax
	andl	$2, %eax
	movq	%rax, %r15
.L482:
	movq	%rbx, %rcx
	movl	$1, %esi
	movl	$6, %edx
	leaq	.LC104(%rip), %rdi
	call	fwrite@PLT
	movl	44(%rsp), %esi
	movq	16(%r14), %rcx
	testl	%esi, %esi
	je	.L494
	cmpl	$2, (%rcx)
	jne	.L318
	movq	16(%rcx), %rdx
.L479:
	leaq	.LC64(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L334
	.p2align 4,,10
	.p2align 3
.L716:
	.cfi_restore 13
	.cfi_restore 15
	movq	%r13, 480(%rsp)
	.cfi_offset 13, -32
	movq	24(%rsi), %r13
	testq	%r13, %r13
	je	.L419
	movl	0(%r13), %eax
	cmpl	$4, %eax
	je	.L420
	cmpl	$5, %eax
	je	.L730
.L419:
	movl	current_word_bits(%rip), %edi
	testl	%edi, %edi
	je	.L421
.L420:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC131(%rip), %rdi
	call	fwrite@PLT
	cmpl	$36, %r12d
	movq	%rbx, %rcx
	movl	$6, %edx
	leaq	.LC74(%rip), %rax
	leaq	.LC75(%rip), %rdi
	movl	$1, %esi
	cmove	%rax, %rdi
	call	fwrite@PLT
	movl	$3, %edx
	movl	$1, %esi
	movq	%rbx, %rcx
	leaq	.LC132(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movq	440(%rsp), %rax
	subq	%fs:40, %rax
	je	.L448
	jmp	.L699
	.p2align 4,,10
	.p2align 3
.L722:
	.cfi_offset 15, -16
	movl	(%rsp), %eax
	testl	%eax, %eax
	jne	.L369
	movl	$1, %ebp
	jmp	.L372
.L719:
	.cfi_restore 15
	cmpl	$32, 16(%r13)
	jne	.L450
	jmp	.L451
.L488:
	.cfi_offset 15, -16
	movl	$1, 44(%rsp)
	jmp	.L328
.L724:
	movl	(%rsp), %eax
	testl	%eax, %eax
	je	.L383
	jmp	.L384
.L480:
	movb	$1, 43(%rsp)
	movl	$1, %r15d
	jmp	.L482
.L723:
	movl	$1, %ebp
	jmp	.L374
.L725:
	movq	32(%r14), %r13
	leaq	.LC98(%rip), %rsi
	movq	%rbx, %rdi
	cmpq	$1, %r13
	movq	%r13, %rdx
	adcq	$-1, %rdx
	call	fprintf@PLT
	testq	%r13, %r13
	je	.L320
	xorl	%r12d, %r12d
.L321:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC99(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r14), %rax
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	emit_expr
	cmpq	%r12, %r13
	jne	.L321
.L320:
	movq	440(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L701
	movq	472(%rsp), %r12
	.cfi_remember_state
	.cfi_restore 12
	movq	480(%rsp), %r13
	.cfi_restore 13
	movq	%rbx, %rsi
	movl	$41, %edi
	movq	496(%rsp), %r15
	.cfi_restore 15
	jmp	.L697
	.p2align 4,,10
	.p2align 3
.L693:
	.cfi_restore_state
	leaq	1(%r13), %rax
	jmp	.L338
	.p2align 4,,10
	.p2align 3
.L340:
	movzbl	0(%rbp,%r13), %r14d
	testb	%r14b, %r14b
	je	.L343
	call	__ctype_b_loc@PLT
	movq	(%rax), %rax
	jmp	.L344
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L348:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	testb	%r14b, %r14b
	je	.L688
.L344:
	movzbl	%r14b, %ecx
	testb	$8, 1(%rax,%rcx,2)
	jne	.L348
	movzbl	0(%rbp,%r13), %r14d
	jmp	.L346
.L729:
	leaq	1(%r13), %rax
	cmpb	$104, 1(%rbp,%r13)
	jne	.L355
.L497:
	leaq	2(%r13), %rax
	jmp	.L355
.L728:
	movzbl	1(%rbp,%r13), %r14d
	leaq	1(%r13), %rsi
	cmpb	$42, %r14b
	jne	.L731
	cmpq	%rbx, %r12
	adcq	$0, %r12
	addq	$2, %r13
	movzbl	0(%rbp,%r13), %r14d
	jmp	.L347
.L688:
	movq	%rbx, %rcx
	movq	(%rsp), %r13
	movq	8(%rsp), %rbx
	movq	16(%rsp), %r14
	movq	24(%rsp), %rbp
	jmp	.L336
.L717:
	.cfi_restore 13
	.cfi_restore 15
	movq	%rdi, %rcx
	movl	$1, %esi
	movl	$5, %edx
	leaq	.LC133(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r14), %rsi
	jmp	.L707
.L352:
	.cfi_offset 13, -32
	.cfi_offset 15, -16
	testb	%r14b, %r14b
	je	.L688
	leaq	1(%r13), %rax
	cmpb	$115, %r14b
	jne	.L355
	cmpq	%rbx, %r12
	jnb	.L355
	movq	32(%rsp), %rcx
	movl	$1, (%rcx,%r12,4)
	jmp	.L355
.L502:
	.cfi_restore 15
	movq	%r13, %rax
	movq	%r12, %r13
	movq	%rax, %r12
.L409:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC123(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbx, %rcx
	leaq	.LC99(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movq	440(%rsp), %rax
	subq	%fs:40, %rax
	je	.L465
	jmp	.L699
	.p2align 4,,10
	.p2align 3
.L720:
	.cfi_restore 13
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC104(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC125(%rip), %rdi
	call	fwrite@PLT
	movl	current_byteptr(%rip), %r8d
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC126(%rip), %rdi
	testl	%r8d, %r8d
	jne	.L414
	call	fwrite@PLT
	movq	24(%r14), %rax
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	movq	16(%rax), %rsi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC127(%rip), %rdi
	call	fwrite@PLT
.L415:
	movq	%rbx, %rcx
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC128(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r14), %rax
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	movq	24(%rax), %rsi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC129(%rip), %rdi
	call	fwrite@PLT
	movq	440(%rsp), %rax
	subq	%fs:40, %rax
	je	.L446
.L700:
	movq	%r13, 480(%rsp)
	.cfi_offset 13, -32
	jmp	.L699
	.p2align 4,,10
	.p2align 3
.L329:
	.cfi_offset 15, -16
	leaq	.LC105(%rip), %rsi
	movq	%r13, %rdi
	movq	%rcx, (%rsp)
	call	strcmp@PLT
	movq	(%rsp), %rcx
	testl	%eax, %eax
	jne	.L732
.L330:
	movb	$1, 43(%rsp)
	movl	$1, %r15d
.L332:
	movl	8(%rsp), %edi
	testl	%edi, %edi
	je	.L733
	movl	$0, 44(%rsp)
	movq	%r13, %rdx
	testl	%r12d, %r12d
	jne	.L479
	jmp	.L318
.L731:
	testb	%r14b, %r14b
	je	.L688
	movq	%rsi, 48(%rsp)
	call	__ctype_b_loc@PLT
	movq	48(%rsp), %r13
	movq	(%rax), %rax
	jmp	.L350
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L353:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	testb	%r14b, %r14b
	je	.L688
.L350:
	movzbl	%r14b, %ecx
	testb	$8, 1(%rax,%rcx,2)
	jne	.L353
	movzbl	0(%rbp,%r13), %r14d
	jmp	.L347
.L478:
	cmpq	$1, %r12
	jne	.L384
	jmp	.L400
.L421:
	.cfi_restore 15
	movl	%r12d, %edi
	call	tk_name@PLT
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movq	440(%rsp), %rax
	subq	%fs:40, %rax
	je	.L465
	jmp	.L699
	.p2align 4,,10
	.p2align 3
.L730:
	cmpl	$32, 16(%r13)
	jne	.L419
	jmp	.L420
.L414:
	.cfi_restore 13
	call	fwrite@PLT
	movq	24(%r14), %rax
	movq	%rbx, %rdi
	movq	%rbp, %rdx
	movq	16(%rax), %rsi
	call	emit_expr
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L415
.L732:
	.cfi_offset 13, -32
	.cfi_offset 15, -16
	leaq	.LC106(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	movq	(%rsp), %rcx
	testl	%eax, %eax
	je	.L330
	leaq	.LC107(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	movq	(%rsp), %rcx
	testl	%eax, %eax
	je	.L330
	leaq	.LC108(%rip), %rsi
	movq	%r13, %rdi
	movq	%rcx, (%rsp)
	call	strcmp@PLT
	movq	(%rsp), %rcx
	testl	%eax, %eax
	je	.L493
	movb	$0, 43(%rsp)
	xorl	%r15d, %r15d
	jmp	.L332
.L698:
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 15
	movq	%r12, 472(%rsp)
	.cfi_offset 12, -40
	jmp	.L700
.L494:
	.cfi_offset 13, -32
	.cfi_offset 15, -16
	movl	$1, 44(%rsp)
	jmp	.L318
.L511:
	movq	48(%rsp), %rsi
	movq	%r13, %rdi
	movq	%rdx, (%rsp)
	call	strcmp@PLT
	movq	(%rsp), %rdx
	testl	%eax, %eax
	jne	.L476
	jmp	.L704
.L733:
	movl	%r12d, 44(%rsp)
	jmp	.L482
.L343:
	movq	(%rsp), %r13
	movq	%rbx, %rcx
	movq	16(%rsp), %r14
	movq	8(%rsp), %rbx
	movq	24(%rsp), %rbp
	testq	%r13, %r13
	jne	.L361
	jmp	.L336
.L493:
	movb	$1, 43(%rsp)
	movl	$2, %r15d
	jmp	.L332
	.cfi_endproc
.LFE40:
	.size	emit_expr, .-emit_expr
	.p2align 4
	.globl	emit_ival_expr
	.type	emit_ival_expr, @function
emit_ival_expr:
.LFB41:
	.cfi_startproc
	cmpl	$2, (%rsi)
	je	.L743
	jmp	emit_expr
	.p2align 4,,10
	.p2align 3
.L743:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rcx
	movq	%rdi, %rbx
	movl	$7, %edx
	leaq	.LC130(%rip), %rdi
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	movq	%rsi, 8(%rsp)
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%rsp), %r8
	movq	16(%r8), %rdi
	testq	%rdi, %rdi
	je	.L736
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L736:
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	movq	%rbx, %rsi
	movl	$41, %edi
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	jmp	fputc@PLT
	.cfi_endproc
.LFE41:
	.size	emit_ival_expr, .-emit_ival_expr
	.p2align 4
	.globl	init_list_length
	.type	init_list_length, @function
init_list_length:
.LFB42:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L747
	cmpl	$1, (%rdi)
	je	.L748
.L747:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L748:
	movq	24(%rdi), %rax
	ret
	.cfi_endproc
.LFE42:
	.size	init_list_length, .-init_list_length
	.p2align 4
	.globl	try_eval_const_expr
	.type	try_eval_const_expr, @function
try_eval_const_expr:
.LFB43:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L756
	movl	(%rdi), %eax
	movq	%rbx, 48(%rsp)
	movq	%rdi, %rdx
	.cfi_offset 3, -16
	movq	%rsi, %rbx
	cmpl	$7, %eax
	je	.L752
	ja	.L753
	testl	%eax, %eax
	je	.L754
	cmpl	$5, %eax
	jne	.L805
	movq	24(%rdi), %rdi
	leaq	32(%rsp), %rsi
	movq	%rdx, 8(%rsp)
	movq	$0, 32(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L804
	movq	8(%rsp), %rdx
	movl	16(%rdx), %eax
	cmpl	$31, %eax
	je	.L759
	cmpl	$35, %eax
	jne	.L763
	xorl	%eax, %eax
	cmpq	$0, 32(%rsp)
	sete	%al
	movq	%rax, (%rbx)
.L779:
	movq	48(%rsp), %rbx
	.cfi_remember_state
	.cfi_restore 3
	movl	$1, %eax
	jmp	.L749
	.p2align 4,,10
	.p2align 3
.L753:
	.cfi_restore_state
	cmpl	$10, %eax
	jne	.L805
	movq	16(%rdi), %rdi
	leaq	32(%rsp), %rsi
	movq	%rdx, 8(%rsp)
	movq	$0, 32(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L804
	movq	8(%rsp), %rdx
	movq	%rbx, %rsi
	movq	24(%rdx), %rdi
	call	try_eval_const_expr
	movq	48(%rsp), %rbx
	.cfi_remember_state
	.cfi_restore 3
	jmp	.L749
	.p2align 4,,10
	.p2align 3
.L805:
	.cfi_restore_state
	movq	48(%rsp), %rbx
	.cfi_restore 3
.L756:
	xorl	%eax, %eax
.L749:
	movq	40(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L806
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L752:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -16
	movq	24(%rdi), %rdi
	leaq	24(%rsp), %rsi
	movq	$0, 24(%rsp)
	movq	$0, 32(%rsp)
	movq	%rdx, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L804
	movq	8(%rsp), %rdx
	leaq	32(%rsp), %rsi
	movq	32(%rdx), %rdi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L804
	movq	8(%rsp), %rdx
	movl	16(%rdx), %eax
	subl	$22, %eax
	cmpl	$33, %eax
	jbe	.L807
.L763:
	movq	48(%rsp), %rbx
	.cfi_remember_state
	.cfi_restore 3
	xorl	%eax, %eax
	jmp	.L749
	.p2align 4,,10
	.p2align 3
.L804:
	.cfi_restore_state
	movq	48(%rsp), %rbx
	.cfi_remember_state
	.cfi_restore 3
	jmp	.L749
	.p2align 4,,10
	.p2align 3
.L754:
	.cfi_restore_state
	movq	16(%rdi), %rax
	movq	48(%rsp), %rbx
	.cfi_remember_state
	.cfi_restore 3
	movq	%rax, (%rsi)
	movl	$1, %eax
	jmp	.L749
	.p2align 4,,10
	.p2align 3
.L807:
	.cfi_restore_state
	leaq	.L765(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L765:
	.long	.L778-.L765
	.long	.L777-.L765
	.long	.L776-.L765
	.long	.L775-.L765
	.long	.L774-.L765
	.long	.L773-.L765
	.long	.L763-.L765
	.long	.L763-.L765
	.long	.L772-.L765
	.long	.L771-.L765
	.long	.L770-.L765
	.long	.L769-.L765
	.long	.L768-.L765
	.long	.L763-.L765
	.long	.L763-.L765
	.long	.L763-.L765
	.long	.L763-.L765
	.long	.L763-.L765
	.long	.L763-.L765
	.long	.L763-.L765
	.long	.L763-.L765
	.long	.L763-.L765
	.long	.L763-.L765
	.long	.L763-.L765
	.long	.L763-.L765
	.long	.L763-.L765
	.long	.L763-.L765
	.long	.L763-.L765
	.long	.L763-.L765
	.long	.L763-.L765
	.long	.L763-.L765
	.long	.L767-.L765
	.long	.L766-.L765
	.long	.L764-.L765
	.text
.L764:
	movq	24(%rsp), %rax
	orq	32(%rsp), %rax
	setne	%al
	movzbl	%al, %eax
	movq	%rax, (%rbx)
	jmp	.L779
.L766:
	movq	24(%rsp), %rax
	orq	32(%rsp), %rax
	movq	%rax, (%rbx)
	jmp	.L779
.L767:
	movq	24(%rsp), %rax
	andq	32(%rsp), %rax
	movq	%rax, (%rbx)
	jmp	.L779
.L768:
	movq	32(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L763
	movq	24(%rsp), %rax
	cqto
	idivq	%rcx
	movq	%rdx, (%rbx)
	jmp	.L779
.L769:
	movq	32(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L763
	movq	24(%rsp), %rax
	cqto
	idivq	%rcx
	movq	%rax, (%rbx)
	jmp	.L779
.L770:
	movq	24(%rsp), %rax
	imulq	32(%rsp), %rax
	movq	%rax, (%rbx)
	jmp	.L779
.L771:
	movq	24(%rsp), %rax
	subq	32(%rsp), %rax
	movq	%rax, (%rbx)
	jmp	.L779
.L772:
	movq	32(%rsp), %rax
	addq	24(%rsp), %rax
	movq	%rax, (%rbx)
	jmp	.L779
.L773:
	movq	32(%rsp), %rax
	cmpq	%rax, 24(%rsp)
	setge	%al
	movzbl	%al, %eax
	movq	%rax, (%rbx)
	jmp	.L779
.L774:
	movq	32(%rsp), %rax
	cmpq	%rax, 24(%rsp)
	setg	%al
	movzbl	%al, %eax
	movq	%rax, (%rbx)
	jmp	.L779
.L775:
	movq	32(%rsp), %rax
	cmpq	%rax, 24(%rsp)
	setle	%al
	movzbl	%al, %eax
	movq	%rax, (%rbx)
	jmp	.L779
.L776:
	movq	32(%rsp), %rax
	cmpq	%rax, 24(%rsp)
	setl	%al
	movzbl	%al, %eax
	movq	%rax, (%rbx)
	jmp	.L779
.L777:
	movq	32(%rsp), %rax
	cmpq	%rax, 24(%rsp)
	setne	%al
	movzbl	%al, %eax
	movq	%rax, (%rbx)
	jmp	.L779
.L778:
	movq	32(%rsp), %rax
	cmpq	%rax, 24(%rsp)
	sete	%al
	movzbl	%al, %eax
	movq	%rax, (%rbx)
	jmp	.L779
	.p2align 4,,10
	.p2align 3
.L759:
	movq	32(%rsp), %rax
	negq	%rax
	movq	%rax, (%rbx)
	jmp	.L779
.L806:
	.cfi_restore 3
	movq	%rbx, 48(%rsp)
	.cfi_offset 3, -16
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE43:
	.size	try_eval_const_expr, .-try_eval_const_expr
	.p2align 4
	.globl	nested_base_len
	.type	nested_base_len, @function
nested_base_len:
.LFB44:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L811
	cmpl	$1, (%rdi)
	je	.L812
.L811:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L812:
	movq	24(%rdi), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmove	%rdx, %rax
	ret
	.cfi_endproc
.LFE44:
	.size	nested_base_len, .-nested_base_len
	.p2align 4
	.globl	edge_words_total
	.type	edge_words_total, @function
edge_words_total:
.LFB45:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L815
	cmpl	$1, (%rdi)
	je	.L817
.L815:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L817:
	movq	24(%rdi), %rsi
	movq	16(%rdi), %rdi
	jmp	edge_words_total.part.0.isra.0
	.cfi_endproc
.LFE45:
	.size	edge_words_total, .-edge_words_total
	.p2align 4
	.globl	edge_tail_words_top
	.type	edge_tail_words_top, @function
edge_tail_words_top:
.LFB46:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L826
	cmpl	$1, (%rdi)
	jne	.L826
	movq	24(%rdi), %r11
	testq	%r11, %r11
	je	.L826
	movq	16(%rdi), %rdx
	xorl	%ecx, %ecx
	xorl	%r10d, %r10d
	jmp	.L833
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L835:
	addq	$1, %r10
	cmpq	%r10, %r11
	je	.L832
.L833:
	movq	(%rdx,%r10,8), %rax
	testq	%rax, %rax
	je	.L835
	cmpl	$1, (%rax)
	jne	.L835
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
.L836:
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	movq	%rcx, 8(%rsp)
	movq	%rdx, (%rsp)
	call	edge_words_total.part.0.isra.0
	movq	8(%rsp), %rcx
	movq	(%rsp), %rdx
	addq	%rax, %rcx
.L824:
	addq	$1, %r10
	cmpq	%r10, %r11
	je	.L839
	movq	(%rdx,%r10,8), %rax
	testq	%rax, %rax
	je	.L824
	cmpl	$1, (%rax)
	jne	.L824
	jmp	.L836
	.p2align 4,,10
	.p2align 3
.L826:
	.cfi_def_cfa_offset 8
	xorl	%ecx, %ecx
.L832:
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L839:
	.cfi_def_cfa_offset 32
	movq	%rcx, %rax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE46:
	.size	edge_tail_words_top, .-edge_tail_words_top
	.section	.rodata.str1.1
.LC140:
	.string	"%s[%zu] = "
.LC141:
	.string	";\n"
.LC142:
	.string	"%s[%zu] = B_ADDR(%s[%zu]);\n"
	.text
	.p2align 4
	.globl	emit_edge_list_init
	.type	emit_edge_list_init, @function
emit_edge_list_init:
.LFB47:
	.cfi_startproc
	subq	$88, %rsp
	.cfi_def_cfa_offset 96
	testq	%rcx, %rcx
	je	.L841
	cmpl	$1, (%rcx)
	jne	.L841
	cmpq	$0, 24(%rcx)
	je	.L841
	movq	%r13, 64(%rsp)
	movq	%rcx, %r11
	movq	%r15, 80(%rsp)
	movq	%rsi, 8(%rsp)
	movq	%r8, (%rsp)
	movq	%rbx, 40(%rsp)
	.cfi_offset 13, -32
	.cfi_offset 15, -16
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	movq	%rbp, 48(%rsp)
	.cfi_offset 6, -48
	movl	%r9d, %ebp
	movq	%r12, 56(%rsp)
	.cfi_offset 12, -40
	movq	%rdx, %r12
	movq	%r14, 72(%rsp)
	.cfi_offset 14, -24
	xorl	%r14d, %r14d
.L852:
	movq	16(%r11), %rax
	movq	(%rax,%r14,8), %r15
	testq	%r15, %r15
	je	.L848
	movl	(%r15), %eax
	testl	%eax, %eax
	je	.L863
	cmpl	$1, %eax
	je	.L864
.L848:
	addq	$1, %r14
	addq	$1, %r12
	cmpq	24(%r11), %r14
	jb	.L852
	movq	(%rsp), %rax
	movq	40(%rsp), %rbx
	.cfi_restore 3
	movq	48(%rsp), %rbp
	.cfi_restore 6
	movq	56(%rsp), %r12
	.cfi_restore 12
	movq	64(%rsp), %r13
	.cfi_restore 13
	movq	72(%rsp), %r14
	.cfi_restore 14
	movq	80(%rsp), %r15
	.cfi_restore 15
	addq	$88, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L841:
	.cfi_def_cfa_offset 96
	movq	%r8, (%rsp)
	movq	(%rsp), %rax
	addq	$88, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L863:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	testl	%ebp, %ebp
	jle	.L846
	movq	%r12, 16(%rsp)
	movq	%r11, %r13
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L847:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC69(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L847
	movq	16(%rsp), %r12
	movq	%r13, %r11
.L846:
	movq	8(%rsp), %rdx
	movq	%r12, %rcx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC140(%rip), %rsi
	movq	%r11, 16(%rsp)
	call	fprintf@PLT
	movq	16(%r15), %rsi
	movq	96(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_ival_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC141(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rsp), %r11
	jmp	.L848
	.p2align 4,,10
	.p2align 3
.L864:
	movq	24(%r15), %r13
	movl	$1, %eax
	testq	%r13, %r13
	cmovne	%r13, %rax
	movq	%rax, 16(%rsp)
	testl	%ebp, %ebp
	jle	.L849
	movq	%r12, 24(%rsp)
	movq	%r11, %r13
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L850:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC69(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L850
	movq	24(%rsp), %r12
	movq	%r13, %r11
.L849:
	movq	(%rsp), %r13
	movq	8(%rsp), %r8
	movq	%r12, %rcx
	movq	%rbx, %rdi
	leaq	.LC142(%rip), %rsi
	xorl	%eax, %eax
	movq	%r11, 24(%rsp)
	movq	%r13, %r9
	movq	%r8, %rdx
	call	fprintf@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 104
	movq	%r13, %rdx
	movl	%ebp, %r9d
	pushq	104(%rsp)
	.cfi_def_cfa_offset 112
	movq	32(%rsp), %rax
	movq	%r15, %rcx
	movq	%rbx, %rdi
	movq	24(%rsp), %rsi
	leaq	(%rax,%r13), %r8
	movq	%r13, 16(%rsp)
	call	emit_edge_list_init
	cmpl	$1, (%r15)
	movq	%rax, %r13
	popq	%rax
	.cfi_def_cfa_offset 104
	popq	%rdx
	.cfi_def_cfa_offset 96
	movq	24(%rsp), %r11
	jne	.L851
	movq	24(%r15), %rsi
	movq	16(%r15), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, (%rsp)
.L851:
	movq	(%rsp), %rax
	cmpq	%r13, %rax
	cmovnb	%rax, %r13
	movq	%r13, (%rsp)
	jmp	.L848
	.cfi_endproc
.LFE47:
	.size	emit_edge_list_init, .-emit_edge_list_init
	.section	.rodata.str1.1
.LC143:
	.string	"<"
.LC144:
	.string	"<="
.LC145:
	.string	">"
.LC146:
	.string	">="
.LC147:
	.string	"??"
.LC148:
	.string	"{\n"
.LC149:
	.string	"return "
.LC150:
	.string	"return ((word)0);\n"
.LC151:
	.string	"}\n"
.LC152:
	.string	"word __%s_store[("
.LC153:
	.string	") + 1];\n"
.LC154:
	.string	"word %s;\n"
.LC155:
	.string	"%s = B_ADDR(__%s_store[0]);\n"
.LC156:
	.string	"word %s = 0;\n"
.LC157:
	.string	"if ("
.LC158:
	.string	")\n"
.LC159:
	.string	"else\n"
.LC160:
	.string	"while ("
.LC161:
	.string	"break;\n"
.LC162:
	.string	"continue;\n"
.LC163:
	.string	"goto %s;\n"
.LC164:
	.string	"__bsw%d_case%zu"
.LC165:
	.string	"for(;;) {\n"
.LC166:
	.string	"word __sw = "
.LC167:
	.string	"__bsw%d_end"
.LC168:
	.string	"goto __bsw%d_dispatch;\n"
.LC169:
	.string	"goto __bsw%d_end;\n"
.LC170:
	.string	"__sw %s (word)%ld"
	.section	.rodata.str1.8
	.align 8
.LC171:
	.string	"(__sw >= (word)%ld && __sw <= (word)%ld)"
	.section	.rodata.str1.1
.LC172:
	.string	"__sw == (word)%ld"
.LC173:
	.string	") goto "
.LC174:
	.string	"__bsw%d_end:\n"
.LC175:
	.string	"%s:\n"
.LC176:
	.string	"__bsw%d_dispatch:\n"
	.text
	.p2align 4
	.globl	emit_stmt
	.type	emit_stmt, @function
emit_stmt:
.LFB48:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.L870(%rip), %r15
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movl	%edx, %r14d
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	%ecx, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$248, %rsp
	.cfi_def_cfa_offset 304
	movq	%r8, (%rsp)
	movq	%fs:40, %rax
	movq	%rax, 232(%rsp)
	xorl	%eax, %eax
	testq	%r8, %r8
	setne	8(%rsp)
.L866:
	movl	g_no_line(%rip), %esi
	testl	%esi, %esi
	jne	.L867
	cmpb	$0, 8(%rsp)
	jne	.L1124
.L867:
	cmpl	$12, 0(%rbp)
	ja	.L865
	movl	0(%rbp), %eax
	movslq	(%r15,%rax,4), %rax
	addq	%r15, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L870:
	.long	.L881-.L870
	.long	.L880-.L870
	.long	.L879-.L870
	.long	.L878-.L870
	.long	.L877-.L870
	.long	.L876-.L870
	.long	.L875-.L870
	.long	.L865-.L870
	.long	.L874-.L870
	.long	.L873-.L870
	.long	.L872-.L870
	.long	.L871-.L870
	.long	.L869-.L870
	.text
	.p2align 4,,10
	.p2align 3
.L1124:
	movl	4(%rbp), %edx
	movq	(%rsp), %rcx
	leaq	.LC70(%rip), %rsi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	call	fprintf@PLT
	jmp	.L867
	.p2align 4,,10
	.p2align 3
.L869:
	movl	g_switch_id(%rip), %eax
	leaq	96(%rsp), %r12
	addl	$1, %eax
	movl	%eax, 36(%rsp)
	movl	%eax, g_switch_id(%rip)
	xorl	%eax, %eax
	call	vec_new@PLT
	movq	%rax, 40(%rsp)
	movq	%rax, %r15
	xorl	%eax, %eax
	call	vec_new@PLT
	movq	24(%rbp), %rdi
	movq	%r15, %rsi
	movq	%rax, 8(%rsp)
	call	collect_cases
	cmpq	$0, 8(%r15)
	je	.L946
	movq	40(%rsp), %r15
	movq	8(%rsp), %r13
	movl	%r14d, 24(%rsp)
	movq	%rbx, 48(%rsp)
	movl	36(%rsp), %ebx
	movq	%rbp, 16(%rsp)
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L947:
	movl	$16, %edi
	call	xmalloc@PLT
	movq	%rbp, %r8
	movl	%ebx, %ecx
	movl	$128, %esi
	movq	%rax, %r14
	movq	(%r15), %rax
	leaq	.LC164(%rip), %rdx
	movq	%r12, %rdi
	movq	(%rax,%rbp,8), %rax
	addq	$1, %rbp
	movq	%rax, (%r14)
	xorl	%eax, %eax
	call	snprintf@PLT
	movq	%r12, %rdi
	call	strlen@PLT
	movq	g_compilation_arena(%rip), %rdi
	xorl	%edx, %edx
	movq	%r12, %rsi
	movq	%rax, %rcx
	call	arena_xstrdup_range@PLT
	movq	%r14, %rsi
	movq	%r13, %rdi
	movq	%rax, 8(%r14)
	call	vec_push@PLT
	cmpq	8(%r15), %rbp
	jb	.L947
	movq	16(%rsp), %rbp
	movl	24(%rsp), %r14d
	movq	48(%rsp), %rbx
.L946:
	testl	%r14d, %r14d
	jle	.L948
	xorl	%r15d, %r15d
	leaq	.LC69(%rip), %r13
	.p2align 4
	.p2align 3
.L949:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r14d
	jne	.L949
	movq	%rbx, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC165(%rip), %rdi
	leal	1(%r14), %r15d
	call	fwrite@PLT
.L950:
	movq	%rbp, 16(%rsp)
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L952:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r15d
	jne	.L952
	movq	16(%rsp), %rbp
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC166(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbp), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	leaq	.LC141(%rip), %rax
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 16(%rsp)
	call	fwrite@PLT
	movl	36(%rsp), %ecx
	movl	$64, %esi
	xorl	%eax, %eax
	leaq	.LC167(%rip), %rdx
	movq	%r12, %rdi
	call	snprintf@PLT
	movq	%rbp, 24(%rsp)
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L953:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r15d
	jne	.L953
	movl	36(%rsp), %edx
	movq	24(%rsp), %rbp
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC168(%rip), %rsi
	call	fprintf@PLT
	movq	24(%rbp), %rsi
	movq	(%rsp), %r8
	movl	%r15d, %edx
	movq	8(%rsp), %rcx
	movq	%rbx, %rdi
	movq	%r12, 72(%rsp)
	xorl	%ebp, %ebp
	movq	g_ctrl(%rip), %rax
	movl	$1, 64(%rsp)
	movq	%rax, 80(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, g_ctrl(%rip)
	call	emit_stmt_switchctx
	movq	80(%rsp), %rax
	movq	%rax, g_ctrl(%rip)
	.p2align 4
	.p2align 3
.L954:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r15d
	jne	.L954
	leaq	.LC169(%rip), %rax
	movl	36(%rsp), %edx
	movq	%rbx, %rdi
	xorl	%ebp, %ebp
	movq	%rax, 48(%rsp)
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	.p2align 4
	.p2align 3
.L955:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r15d
	jne	.L955
	movl	36(%rsp), %edx
	leaq	.LC176(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leal	2(%r14), %ebp
	call	fprintf@PLT
	movq	40(%rsp), %rax
	cmpq	$0, 8(%rax)
	je	.L970
.L986:
	leaq	.LC157(%rip), %rax
	movl	%r14d, 56(%rsp)
	movq	40(%rsp), %r13
	xorl	%r12d, %r12d
	movq	%rax, 24(%rsp)
	movl	%r15d, 60(%rsp)
	.p2align 4
	.p2align 3
.L968:
	movq	0(%r13), %rax
	movq	(%rax,%r12,8), %r14
	movq	8(%rsp), %rax
	movq	8(%rax), %rcx
	testq	%rcx, %rcx
	je	.L957
	movq	(%rax), %rsi
	xorl	%eax, %eax
	jmp	.L960
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L958:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L957
.L960:
	movq	(%rsi,%rax,8), %rdx
	cmpq	(%rdx), %r14
	jne	.L958
	movq	8(%rdx), %rax
	movq	%rax, (%rsp)
.L959:
	testl	%ebp, %ebp
	jle	.L961
	xorl	%r15d, %r15d
	.p2align 4
	.p2align 3
.L962:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r15d
	leaq	.LC69(%rip), %rdi
	call	fwrite@PLT
	cmpl	%ebp, %r15d
	jne	.L962
.L961:
	movq	24(%rsp), %rdi
	movl	$4, %edx
	movq	%rbx, %rcx
	movl	$1, %esi
	call	fwrite@PLT
	movl	20(%r14), %eax
	movq	24(%r14), %rdx
	testl	%eax, %eax
	je	.L963
	cmpl	$26, %eax
	je	.L1004
	ja	.L965
	leaq	.LC143(%rip), %rsi
	cmpl	$24, %eax
	je	.L964
	cmpl	$25, %eax
	leaq	.LC147(%rip), %rsi
	leaq	.LC144(%rip), %rax
	cmove	%rax, %rsi
.L964:
	movq	%rdx, %rcx
	movq	%rbx, %rdi
	movq	%rsi, %rdx
	xorl	%eax, %eax
	leaq	.LC170(%rip), %rsi
	call	fprintf@PLT
.L966:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	addq	$1, %r12
	leaq	.LC173(%rip), %rdi
	call	fwrite@PLT
	movq	(%rsp), %rdi
	movq	%rbx, %rsi
	call	fputs@PLT
	movq	16(%rsp), %rdi
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	call	fwrite@PLT
	cmpq	8(%r13), %r12
	jb	.L968
	movl	56(%rsp), %r14d
	movl	60(%rsp), %r15d
	testl	%ebp, %ebp
	jle	.L972
	leaq	.LC69(%rip), %r13
.L970:
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L973:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%ebp, %r12d
	jne	.L973
	movl	36(%rsp), %edx
	movq	48(%rsp), %rsi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	call	fprintf@PLT
	testl	%r15d, %r15d
	jle	.L1118
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L975:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%r12d, %eax
	addl	$1, %r12d
	cmpl	%eax, %r14d
	jg	.L975
.L1118:
	movl	36(%rsp), %edx
	leaq	.LC174(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	xorl	%r12d, %r12d
	call	fprintf@PLT
	.p2align 4
	.p2align 3
.L976:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%ebp, %r12d
	jne	.L976
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC161(%rip), %rdi
	call	fwrite@PLT
	testl	%r14d, %r14d
	jle	.L978
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L979:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r14d
	jne	.L979
.L978:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC151(%rip), %rdi
	call	fwrite@PLT
.L865:
	movq	232(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1121
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
.L881:
	.cfi_restore_state
	testl	%r14d, %r14d
	jle	.L1123
	xorl	%ebp, %ebp
	leaq	.LC69(%rip), %r13
	.p2align 4
	.p2align 3
.L902:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r14d
	jne	.L902
.L1123:
	movq	232(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1121
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC141(%rip), %rdi
.L1120:
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
.L880:
	.cfi_restore_state
	xorl	%r15d, %r15d
	leaq	.LC69(%rip), %r13
	testl	%r14d, %r14d
	jle	.L900
	.p2align 4
	.p2align 3
.L899:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r14d
	jne	.L899
.L900:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbp), %rax
	testq	%rax, %rax
	je	.L904
	leal	1(%r14), %edi
	movl	%r14d, 16(%rsp)
	xorl	%r13d, %r13d
	movl	%edi, 36(%rsp)
.L911:
	movq	16(%rbp), %rdx
	movq	(%rdx,%r13,8), %r15
	testl	%r12d, %r12d
	je	.L905
	subq	$1, %rax
	xorl	%ecx, %ecx
	cmpq	%r13, %rax
	je	.L1125
.L906:
	movq	(%rsp), %r8
	movl	36(%rsp), %edx
	movq	%r15, %rsi
	movq	%rbx, %rdi
	call	emit_stmt
.L910:
	movq	24(%rbp), %rax
	addq	$1, %r13
	cmpq	%rax, %r13
	jb	.L911
	movl	16(%rsp), %r14d
	testl	%r12d, %r12d
	je	.L914
	testq	%rax, %rax
	je	.L913
	movq	16(%rbp), %rdx
	movq	-8(%rdx,%rax,8), %rax
	testq	%rax, %rax
	je	.L913
	movl	(%rax), %eax
	subl	$5, %eax
	cmpl	$1, %eax
	jbe	.L914
.L913:
	xorl	%ebp, %ebp
	leaq	.LC69(%rip), %r13
	testl	%r14d, %r14d
	js	.L1126
	.p2align 4
	.p2align 3
.L916:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r14d
	jge	.L916
	movq	%rbx, %rcx
	movl	$18, %edx
	movl	$1, %esi
	leaq	.LC150(%rip), %rdi
	call	fwrite@PLT
.L914:
	testl	%r14d, %r14d
	jle	.L919
	xorl	%ebp, %ebp
	leaq	.LC69(%rip), %r13
	.p2align 4
	.p2align 3
.L920:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r14d
	jne	.L920
.L919:
	movq	232(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1121
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC151(%rip), %rdi
	jmp	.L1120
	.p2align 4,,10
	.p2align 3
.L879:
	xorl	%r15d, %r15d
	cmpq	$0, 24(%rbp)
	je	.L865
	.p2align 4
	.p2align 3
.L898:
	movq	16(%rbp), %rax
	movq	(%rax,%r15,8), %r13
	movq	0(%r13), %rdi
	call	get_mangled_name
	movq	%rax, 8(%rsp)
	cmpq	$0, 8(%r13)
	je	.L1127
	testl	%r14d, %r14d
	jle	.L925
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L926:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC69(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %r14d
	jne	.L926
	movq	8(%rsp), %rdx
	leaq	.LC152(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	8(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	xorl	%r13d, %r13d
	call	emit_expr
	movq	%rbx, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC153(%rip), %rdi
	call	fwrite@PLT
	.p2align 4
	.p2align 3
.L927:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r13d
	leaq	.LC69(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r13d, %r14d
	jne	.L927
	movq	8(%rsp), %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	xorl	%r13d, %r13d
	leaq	.LC154(%rip), %rsi
	call	fprintf@PLT
	.p2align 4
	.p2align 3
.L928:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r13d
	leaq	.LC69(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r13d, %r14d
	jne	.L928
.L983:
	movq	8(%rsp), %rcx
	leaq	.LC155(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movq	%rcx, %rdx
	call	fprintf@PLT
.L929:
	addq	$1, %r15
	cmpq	24(%rbp), %r15
	jb	.L898
	jmp	.L865
	.p2align 4,,10
	.p2align 3
.L878:
	xorl	%r8d, %r8d
	leaq	.LC69(%rip), %r13
	testl	%r14d, %r14d
	jle	.L887
	.p2align 4
	.p2align 3
.L886:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	movl	%r8d, 16(%rsp)
	call	fwrite@PLT
	movl	16(%rsp), %r8d
	addl	$1, %r8d
	cmpl	%r8d, %r14d
	jne	.L886
.L887:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC157(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbp), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC158(%rip), %rdi
	call	fwrite@PLT
	testl	%r12d, %r12d
	jne	.L1128
.L930:
	movq	24(%rbp), %rsi
	testq	%rsi, %rsi
	je	.L931
	movl	%r14d, %edx
	cmpl	$1, (%rsi)
	je	.L932
.L931:
	leal	1(%r14), %edx
.L932:
	movq	(%rsp), %r8
	movl	%r12d, %ecx
	movq	%rbx, %rdi
	call	emit_stmt
	cmpq	$0, 32(%rbp)
	je	.L865
	testl	%r14d, %r14d
	jle	.L933
	xorl	%r12d, %r12d
	leaq	.LC69(%rip), %r13
	.p2align 4
	.p2align 3
.L934:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r14d
	jne	.L934
.L933:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC159(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbp), %rbp
	testq	%rbp, %rbp
	jne	.L1117
	jmp	.L937
	.p2align 4,,10
	.p2align 3
.L877:
	xorl	%r12d, %r12d
	leaq	.LC69(%rip), %r13
	testl	%r14d, %r14d
	jle	.L885
	.p2align 4
	.p2align 3
.L884:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r14d
	jne	.L884
.L885:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC160(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbp), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC158(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbp), %rbp
	testq	%rbp, %rbp
	je	.L937
.L1117:
	cmpl	$1, 0(%rbp)
	je	.L936
.L937:
	addl	$1, %r14d
.L936:
	xorl	%r12d, %r12d
	jmp	.L866
	.p2align 4,,10
	.p2align 3
.L874:
	xorl	%ebp, %ebp
	leaq	.LC69(%rip), %r13
	testl	%r14d, %r14d
	jle	.L893
	.p2align 4
	.p2align 3
.L892:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r14d
	jne	.L892
.L893:
	movq	232(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1121
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC161(%rip), %rdi
	jmp	.L1120
	.p2align 4,,10
	.p2align 3
.L876:
	xorl	%r12d, %r12d
	leaq	.LC69(%rip), %r13
	testl	%r14d, %r14d
	jle	.L897
	.p2align 4
	.p2align 3
.L896:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r14d
	jne	.L896
.L897:
	cmpq	$0, 16(%rbp)
	je	.L938
.L1122:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC149(%rip), %rdi
	call	fwrite@PLT
	jmp	.L941
	.p2align 4,,10
	.p2align 3
.L872:
	xorl	%r12d, %r12d
	leaq	.LC69(%rip), %r13
	testl	%r14d, %r14d
	jle	.L889
	.p2align 4
	.p2align 3
.L888:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r14d
	jne	.L888
.L889:
	movq	232(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1121
	movq	16(%rbp), %rdx
	addq	$248, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rdi
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC163(%rip), %rsi
	popq	%rbp
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
.L875:
	.cfi_restore_state
	xorl	%r15d, %r15d
	leaq	.LC69(%rip), %r13
	testl	%r14d, %r14d
	jle	.L895
	.p2align 4
	.p2align 3
.L894:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r14d
	jne	.L894
.L895:
	testl	%r12d, %r12d
	jne	.L1122
.L941:
	movq	16(%rbp), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	jmp	.L1123
	.p2align 4,,10
	.p2align 3
.L873:
	xorl	%ebp, %ebp
	leaq	.LC69(%rip), %r13
	testl	%r14d, %r14d
	jle	.L891
	.p2align 4
	.p2align 3
.L890:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r14d
	jne	.L890
.L891:
	movq	232(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1121
	movq	%rbx, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC162(%rip), %rdi
	jmp	.L1120
	.p2align 4,,10
	.p2align 3
.L871:
	xorl	%r12d, %r12d
	leaq	.LC69(%rip), %r13
	testl	%r14d, %r14d
	jle	.L1129
	.p2align 4
	.p2align 3
.L882:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r14d
	jne	.L882
	movq	16(%rbp), %rdx
	leaq	.LC175(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leal	1(%r14), %r12d
	call	fprintf@PLT
.L980:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L982:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%r14d, %r12d
	jne	.L982
.L981:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movl	%r12d, %r14d
	leaq	.LC141(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbp), %rbp
	jmp	.L936
	.p2align 4,,10
	.p2align 3
.L957:
	movq	$0, (%rsp)
	jmp	.L959
	.p2align 4,,10
	.p2align 3
.L963:
	movl	16(%r14), %eax
	testl	%eax, %eax
	je	.L967
	movq	32(%r14), %rcx
	leaq	.LC171(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L966
.L1125:
	cmpl	$6, (%r15)
	je	.L1130
.L905:
	movl	%r12d, %ecx
	jmp	.L906
	.p2align 4,,10
	.p2align 3
.L1127:
	xorl	%r13d, %r13d
	testl	%r14d, %r14d
	jle	.L924
	.p2align 4
	.p2align 3
.L923:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r13d
	leaq	.LC69(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r13d, %r14d
	jne	.L923
.L924:
	movq	8(%rsp), %rdx
	leaq	.LC156(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L929
	.p2align 4,,10
	.p2align 3
.L967:
	leaq	.LC172(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L966
	.p2align 4,,10
	.p2align 3
.L965:
	cmpl	$27, %eax
	leaq	.LC147(%rip), %rsi
	leaq	.LC146(%rip), %rax
	cmove	%rax, %rsi
	jmp	.L964
	.p2align 4,,10
	.p2align 3
.L1004:
	leaq	.LC145(%rip), %rsi
	jmp	.L964
.L925:
	movq	8(%rsp), %r12
	movq	%rbx, %rdi
	leaq	.LC152(%rip), %rsi
	xorl	%eax, %eax
	movq	%r12, %rdx
	call	fprintf@PLT
	movq	8(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC153(%rip), %rdi
	call	fwrite@PLT
	movq	%r12, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC154(%rip), %rsi
	call	fprintf@PLT
	jmp	.L983
.L1128:
	xorl	%r12d, %r12d
	cmpq	$0, 32(%rbp)
	sete	%r12b
	jmp	.L930
.L1130:
	movl	g_no_line(%rip), %ecx
	testl	%ecx, %ecx
	jne	.L907
	cmpb	$0, 8(%rsp)
	je	.L907
	movl	4(%r15), %edx
	movq	(%rsp), %rcx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC70(%rip), %rsi
	call	fprintf@PLT
.L907:
	movl	16(%rsp), %edx
	testl	%edx, %edx
	js	.L908
	leaq	.LC69(%rip), %rax
	xorl	%r14d, %r14d
	movq	%rax, 24(%rsp)
	.p2align 4
	.p2align 3
.L909:
	movq	24(%rsp), %rdi
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r14d
	call	fwrite@PLT
	cmpl	%r14d, 16(%rsp)
	jge	.L909
.L908:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC149(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r15), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC141(%rip), %rdi
	call	fwrite@PLT
	jmp	.L910
.L938:
	movq	232(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1121
	movq	%rbx, %rcx
	movl	$18, %edx
	movl	$1, %esi
	leaq	.LC150(%rip), %rdi
	jmp	.L1120
.L904:
	testl	%r12d, %r12d
	jne	.L913
	jmp	.L914
.L1129:
	movq	16(%rbp), %rdx
	leaq	.LC175(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leal	1(%r14), %r12d
	call	fprintf@PLT
	testl	%r14d, %r14d
	jne	.L981
	jmp	.L980
	.p2align 4,,10
	.p2align 3
.L948:
	movq	%rbx, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC165(%rip), %rdi
	leal	1(%r14), %r15d
	call	fwrite@PLT
	testl	%r14d, %r14d
	je	.L1131
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC166(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbp), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	leaq	.LC141(%rip), %rax
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 16(%rsp)
	call	fwrite@PLT
	movl	36(%rsp), %r13d
	movq	%r12, %rdi
	xorl	%eax, %eax
	leaq	.LC167(%rip), %rdx
	movl	$64, %esi
	movl	%r13d, %ecx
	call	snprintf@PLT
	movl	%r13d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC168(%rip), %rsi
	call	fprintf@PLT
	movq	24(%rbp), %rsi
	movq	(%rsp), %r8
	movl	%r15d, %edx
	movq	g_ctrl(%rip), %rax
	movq	8(%rsp), %rcx
	movq	%rbx, %rdi
	movl	$1, 64(%rsp)
	movq	%r12, 72(%rsp)
	leal	2(%r14), %ebp
	movq	%rax, 80(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, g_ctrl(%rip)
	call	emit_stmt_switchctx
	movq	80(%rsp), %rax
	movl	%r13d, %edx
	movq	%rbx, %rdi
	leaq	.LC169(%rip), %rsi
	movq	%rax, g_ctrl(%rip)
	xorl	%eax, %eax
	movq	%rsi, 48(%rsp)
	call	fprintf@PLT
	movl	%r13d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC176(%rip), %rsi
	call	fprintf@PLT
	movq	40(%rsp), %rax
	cmpq	$0, 8(%rax)
	jne	.L986
	leaq	.LC69(%rip), %r13
	cmpl	$1, %ebp
	je	.L970
	movl	36(%rsp), %edx
	movq	48(%rsp), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L1119:
	movl	36(%rsp), %edx
	movq	%rbx, %rdi
	leaq	.LC174(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC161(%rip), %rdi
	call	fwrite@PLT
	jmp	.L978
.L972:
	movl	36(%rsp), %edx
	movq	48(%rsp), %rsi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	call	fprintf@PLT
	testl	%r15d, %r15d
	jle	.L1119
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC69(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1119
.L1126:
	movq	%rbx, %rcx
	movl	$18, %edx
	movl	$1, %esi
	leaq	.LC150(%rip), %rdi
	call	fwrite@PLT
	jmp	.L919
.L1121:
	call	__stack_chk_fail@PLT
.L1131:
	leaq	.LC69(%rip), %r13
	jmp	.L950
	.cfi_endproc
.LFE48:
	.size	emit_stmt, .-emit_stmt
	.p2align 4
	.type	emit_stmt_switchctx, @function
emit_stmt_switchctx:
.LFB38:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L1212
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movq	%r12, 40(%rsp)
	movq	%r8, (%rsp)
	movq	%rcx, 8(%rsp)
	movq	%rbx, 24(%rsp)
	.cfi_offset 12, -40
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	movq	%rbp, 32(%rsp)
	.cfi_offset 6, -48
	movl	%edx, %ebp
	movq	%r13, 48(%rsp)
	.cfi_offset 13, -32
	movq	%rsi, %r13
	movq	%r15, 64(%rsp)
	.cfi_offset 15, -16
	leaq	.L1137(%rip), %r15
.L1134:
	cmpl	$13, 0(%r13)
	ja	.L1135
	movl	0(%r13), %eax
	movslq	(%r15,%rax,4), %rax
	addq	%r15, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1137:
	.long	.L1135-.L1137
	.long	.L1141-.L1137
	.long	.L1135-.L1137
	.long	.L1140-.L1137
	.long	.L1139-.L1137
	.long	.L1135-.L1137
	.long	.L1135-.L1137
	.long	.L1135-.L1137
	.long	.L1135-.L1137
	.long	.L1135-.L1137
	.long	.L1135-.L1137
	.long	.L1138-.L1137
	.long	.L1135-.L1137
	.long	.L1136-.L1137
	.text
	.p2align 4,,10
	.p2align 3
.L1135:
	movq	(%rsp), %r8
	movq	40(%rsp), %r12
	movl	%ebp, %edx
	movq	%r13, %rsi
	movq	32(%rsp), %rbp
	movq	48(%rsp), %r13
	movq	%rbx, %rdi
	xorl	%ecx, %ecx
	movq	24(%rsp), %rbx
	movq	64(%rsp), %r15
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 15
	.cfi_def_cfa_offset 8
	jmp	emit_stmt
	.p2align 4,,10
	.p2align 3
.L1136:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	%r14, 56(%rsp)
	movq	8(%rax), %rcx
	testq	%rcx, %rcx
	.cfi_offset 14, -24
	je	.L1154
	movq	8(%rsp), %rax
	movq	(%rax), %rsi
	xorl	%eax, %eax
	jmp	.L1153
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1152:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1154
.L1153:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%r13, (%rdx)
	jne	.L1152
	movq	8(%rdx), %r14
.L1151:
	testl	%ebp, %ebp
	jle	.L1155
	xorl	%r13d, %r13d
	leaq	.LC69(%rip), %r12
	.p2align 4
	.p2align 3
.L1156:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1156
	movq	%r14, %rdx
	leaq	.LC175(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1157:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jle	.L1157
.L1159:
	movq	56(%rsp), %r14
	.cfi_restore 14
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC141(%rip), %rdi
	jmp	.L1217
	.p2align 4,,10
	.p2align 3
.L1138:
	movq	%r14, 56(%rsp)
	leaq	.LC69(%rip), %r12
	.cfi_offset 14, -24
	xorl	%r14d, %r14d
	testl	%ebp, %ebp
	jle	.L1218
	.p2align 4
	.p2align 3
.L1142:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1142
	movq	16(%r13), %rdx
	leaq	.LC175(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	addl	$1, %r14d
	call	fprintf@PLT
.L1160:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1162:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r14d
	jne	.L1162
.L1177:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movl	%r14d, %ebp
	leaq	.LC141(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	je	.L1132
	movq	56(%rsp), %r14
	.cfi_restore 14
	jmp	.L1134
	.p2align 4,,10
	.p2align 3
.L1139:
	movq	%r14, 56(%rsp)
	leaq	.LC69(%rip), %r12
	.cfi_offset 14, -24
	xorl	%r14d, %r14d
	testl	%ebp, %ebp
	jle	.L1145
	.p2align 4
	.p2align 3
.L1144:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1144
.L1145:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC160(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC158(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	testq	%r13, %r13
	je	.L1132
.L1216:
	xorl	%eax, %eax
	cmpl	$1, 0(%r13)
	movq	56(%rsp), %r14
	.cfi_restore 14
	setne	%al
	addl	%eax, %ebp
	jmp	.L1134
	.p2align 4,,10
	.p2align 3
.L1140:
	movq	%r14, 56(%rsp)
	.cfi_offset 14, -24
	leaq	.LC69(%rip), %r12
	xorl	%r14d, %r14d
	testl	%ebp, %ebp
	jle	.L1147
	.p2align 4
	.p2align 3
.L1146:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1146
.L1147:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC157(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rsi
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC158(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %rsi
	testq	%rsi, %rsi
	je	.L1168
	movl	%ebp, %edx
	cmpl	$1, (%rsi)
	je	.L1169
.L1168:
	leal	1(%rbp), %edx
.L1169:
	movq	(%rsp), %r8
	movq	8(%rsp), %rcx
	movq	%rbx, %rdi
	call	emit_stmt_switchctx
	cmpq	$0, 32(%r13)
	je	.L1132
	testl	%ebp, %ebp
	jle	.L1170
	xorl	%r14d, %r14d
	leaq	.LC69(%rip), %r12
	.p2align 4
	.p2align 3
.L1171:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1171
.L1170:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC159(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r13), %r13
	testq	%r13, %r13
	jne	.L1216
.L1132:
	movq	56(%rsp), %r14
	.cfi_restore 14
	movq	24(%rsp), %rbx
	movq	32(%rsp), %rbp
	movq	40(%rsp), %r12
	movq	48(%rsp), %r13
	movq	64(%rsp), %r15
	addq	$72, %rsp
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1141:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 15, -16
	xorl	%r15d, %r15d
	leaq	.LC69(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1219
	.p2align 4
	.p2align 3
.L1148:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%ebp, %r15d
	jne	.L1148
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	je	.L1164
.L1172:
	leal	1(%rbp), %r12d
	xorl	%r15d, %r15d
.L1165:
	movq	16(%r13), %rax
	movq	(%rsp), %r8
	movl	%r12d, %edx
	movq	%rbx, %rdi
	movq	8(%rsp), %rcx
	movq	(%rax,%r15,8), %rsi
	addq	$1, %r15
	call	emit_stmt_switchctx
	cmpq	24(%r13), %r15
	jb	.L1165
	testl	%ebp, %ebp
	jle	.L1166
	leaq	.LC69(%rip), %r12
.L1164:
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1167:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1167
.L1166:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC151(%rip), %rdi
.L1217:
	movq	24(%rsp), %rbx
	movq	32(%rsp), %rbp
	movq	40(%rsp), %r12
	movq	48(%rsp), %r13
	movq	64(%rsp), %r15
	addq	$72, %rsp
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 15
	.cfi_def_cfa_offset 8
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L1154:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	xorl	%r14d, %r14d
	jmp	.L1151
	.p2align 4,,10
	.p2align 3
.L1155:
	xorl	%eax, %eax
	movq	%r14, %rdx
	leaq	.LC175(%rip), %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	testl	%ebp, %ebp
	jne	.L1159
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC69(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1159
	.p2align 4,,10
	.p2align 3
.L1218:
	movq	16(%r13), %rdx
	leaq	.LC175(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leal	1(%rbp), %r14d
	call	fprintf@PLT
	testl	%ebp, %ebp
	jne	.L1177
	jmp	.L1160
	.p2align 4,,10
	.p2align 3
.L1219:
	.cfi_restore 14
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	jne	.L1172
	jmp	.L1166
	.p2align 4,,10
	.p2align 3
.L1212:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 15
	ret
	.cfi_endproc
.LFE38:
	.size	emit_stmt_switchctx, .-emit_stmt_switchctx
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
	.ascii	"/ioctl.h>\n#include <ctype.h>\n#include <dlfcn.h>\n#include "
	.ascii	"<math.h>\n#include <stddef.h>\n#include <ncurses.h>\n#includ"
	.ascii	"e <panel.h>\n\n/* Undefine common macros that might conflict"
	.ascii	" with B variable names */\n#undef TRUE\n#undef FALSE\n#undef"
	.ascii	" TCSAFLUSH\n#undef FIONREAD\n#undef TIOCGWINSZ\n\ntypedef in"
	.ascii	"tptr_t  word;\ntypedef uintptr_t uword;\n\n/* Endianness che"
	.ascii	"ck: char()/lchar() in B_BYTEPTR=0 mode pack bytes with\n * b"
	.ascii	"yte 0 at the LSB (PDP-11/little-endian convention). The shif"
	.ascii	"t-based\n * implementation works on word VALUES so it's cons"
	.ascii	"istent across architectures,\n * but string literals compile"
	.ascii	"d on one endianness may look wrong on another.\n * Warn if r"
	.ascii	"unning on big-endian to alert users to potential issues.\n *"
	.ascii	"/\n#if !defined(__BYTE_ORDER__) || __BYTE_ORDER__ != __ORDER"
	.ascii	"_LITTLE_ENDIAN__\n  #if !B_BYTEPTR\n    #warning \"B_BYTEPTR"
	.ascii	"=0 mode uses little-endian"
	.string	" byte packing; results may differ on big-endian hosts\"\n  #endif\n#endif\n\n/*\n  Pointer model:\n    B_BYTEPTR=1  -> pointers are byte addresses (matches your formulas)\n    B_BYTEPTR=0  -> pointers are word addresses (closer to Thompson B: E1[E2]==*(E1+E2))\n*/\n"
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
	.ascii	" WVAL((uword)(a) * (uword)(b))\n#define WDIV(a,b) WVAL((uwor"
	.ascii	"d)(a) / (uword)(b))\n#define WMOD(a,b) WVAL((uword)(a) % (uw"
	.ascii	"ord)(b))\n#define WSHL(a,n) WVAL(((uword)(a) & WORD_MASK) <<"
	.ascii	" ((uword)(n) & SHIFT_MASK))\n#de"
	.string	"fine WSHR(a,n) WVAL(((uword)(a) & WORD_MASK) >> ((uword)(n) & SHIFT_MASK))\n#define WAND(a,b) WVAL((uword)(a) & (uword)(b))\n#define WOR(a,b)  WVAL((uword)(a) | (uword)(b))\n#define WXOR(a,b) WVAL((uword)(a) ^ (uword)(b))\n#define WNEG(a)   WVAL(-(uword)(a))\n\n"
	.align 8
.LC181:
	.ascii	"#if B_BYTEPTR\n  /* Byte-addressed pointers: addresses are b"
	.ascii	"ytes; array elements are word-sized. */\n  #define B_DEREF(p"
	.ascii	")   (*(word*)(uword)(p))\n  #define B_ADDR(x)    B_PTR(&(x))"
	.ascii	"\n  #define B_INDEX(a,i) (*(word*)((uword)(a) + (uword)(i) *"
	.ascii	" sizeof(word)))\n  #define B_PTR(p)     ((word)(uword)(p))\n"
	.ascii	"#else\n  #define B_DEREF(p)   (*(word*)(uword)((uword)(p) * "
	.ascii	"sizeof(word)))\n  #define B_ADDR(x)    B_PTR(&(x))\n  #defin"
	.ascii	"e B_INDEX(a,i) B_DEREF((a) + (i))\n  #define B_PTR(p)     (("
	.ascii	"word)((uword)(p) / sizeof(word)))\n#endif\n\n#define B_STR(s"
	.ascii	")     B_PTR((const char*)(s))\n\n/* Convert B pointer (word)"
	.ascii	" to C pointer */\n#if B_BYTEPTR\n  #define B_CPTR(p) ((void*"
	.ascii	")(uword)(p))\n#else\n  #define B_CPTR(p) ((void*)((uword)(p)"
	.ascii	" * sizeof(word)))\n#endif\n\nstatic int rd_fd = 0;  /* curre"
	.ascii	"nt input fd */\nstatic int wr_fd = 1;  /* current output fd "
	.ascii	"*/\nstatic word rd_unit = 0; /* exposed to B if needed */\ns"
	.ascii	"tatic word wr_unit = (word)-1;\nstatic void __b_sync_rd(void"
	.ascii	"){\n    if (rd_unit < 0) {\n        if (rd_fd != 0 && rd_fd "
	.ascii	"> 2) close(rd_fd);\n        rd_fd = 0;\n    } else if (rd_fd"
	.ascii	" != (int)rd_unit) {\n        rd_fd = (int)rd_unit;\n    }\n}"
	.ascii	"\nstatic void __b_sync_wr(void){\n    if (wr_unit < 0) {\n  "
	.ascii	"      if (wr_fd != 1 && wr_fd > 2) close(wr_fd);\n        wr"
	.ascii	"_fd = 1;\n    } else if (wr_fd != (int)wr_unit) {\n        w"
	.ascii	"r_fd = (int)wr_unit;\n    }\n}\nstatic word b_print(word x){"
	.ascii	"\n    __b_sync_wr();\n    char buf[64];\n    int n = snprint"
	.ascii	"f(buf, sizeof(buf), \"%\" PRIdPTR \"\\n\", (intptr_t)x);\n  "
	.ascii	"  if (n > 0) (void)write(wr_fd, buf, (size_t)n);\n    return"
	.ascii	" x;\n}\n\nstatic word b_putchar(word x){\n    __b_sync_wr();"
	.ascii	"\n    unsigned char c = (unsigned char)(x & 0xFF);\n    (voi"
	.ascii	"d)write(wr_fd, &c, 1);\n    return x;\n}\nstatic word b_getc"
	.ascii	"har(void){ __b_sync_rd(); unsigned char c; ssize_t n = read("
	.ascii	"rd_fd, &c, 1); if (n == 1) return (word)c; if (rd_fd != 0) {"
	.ascii	" close(rd_fd); rd_fd = 0; rd_unit = -1; return b_getchar(); "
	.ascii	"} return (word)004; }\nstatic word b_exit(word code){ exit(("
	.ascii	"int)code); return 0; }\nstatic word b_abort(void){ abort(); "
	.ascii	"return 0; }\nstatic word b_free(word p){ free(B_CPTR(p)); re"
	.ascii	"turn 0; }\n\n/* Sign-extend 16-bit value to full word size. "
	.ascii	"Used by 16-bit B programs on 64-bit hosts. */\nstatic word s"
	.ascii	"x64(word x){\n    return (word)(int16_t)(x & 0xFFFF);\n}\n\n"
	.ascii	"/* Command line argument support */\nstatic int __b_argc;\ns"
	.ascii	"tatic char **__b_argv;\n\n/* argv strings converted to B str"
	.ascii	"ings (packed words, 004 terminator) */\nstatic word *__b_arg"
	.ascii	"vb;\n\nstatic void __b_setargs(int argc, char **argv);\nstat"
	.ascii	"ic word b_argc(void);\nstatic word b_argv(word i);\n\n/* Com"
	.ascii	"mand line reread buffer */\nstatic word b_reread(void);\n\n/"
	.ascii	"* Helper functions for complex lvalue operations (avoid GNU "
	.ascii	"C extensions) */\n/* All use safe W* macros to avoid host-C "
	.ascii	"undefined behavior */\nstatic word b_preinc(word *p) { retur"
	.ascii	"n (*p = WADD(*p, 1)); }\nstatic word b_predec(word *p) { ret"
	.ascii	"urn (*p = WSUB(*p, 1)); }\nstatic word b_postinc(word *p) { "
	.ascii	"word old = WVAL(*p); *p = WADD(*p, 1); return old; }\nstatic"
	.ascii	" word b_postdec(word *p) { word old = WVAL(*p); *p = WSUB(*p"
	.ascii	", 1); return old; }\nstatic word b_add_assign(word *p, word "
	.ascii	"v) { return (*p = WADD(*p, v)); }\nstatic word b_sub_assign("
	.ascii	"word *p, word v) { return (*p = WSUB(*p, v)); }\nstatic word"
	.ascii	" b_mul_assign(word *p, word v) { return (*p = WMUL(*p, v)); "
	.ascii	"}\nstatic word b_div_assign(word *p, word v) { return (*p = "
	.ascii	"WDIV(*p, v)); }\nstatic word b_mod_assign(word *p, word v) {"
	.ascii	" return (*p = WMOD(*p, v)); }\nstatic word b_lsh_assign(word"
	.ascii	" *p, word v) { return (*p = WSHL(*p, v)); }\nstatic word b_r"
	.ascii	"sh_assign(word *p, word v) { return (*p = WSHR(*p, v)); }\ns"
	.ascii	"tatic word b_and_assign(word *p, word v) { return (*p = WAND"
	.ascii	"(*p, v)); }\nstatic word b_or_assign(word *p, word v) { retu"
	.ascii	"rn (*p = WOR(*p, v)); }\nstatic word b_xor_assign(word *p, w"
	.ascii	"ord v) { return (*p = WXOR(*p, v)); }\n\nstatic word b_alloc"
	.ascii	"(word nwords){\n    size_t bytes = (size_t)nwords * sizeof(w"
	.ascii	"ord);\n    void *p = malloc(bytes);\n    if (!p) { fprintf(s"
	.ascii	"tderr, \"alloc: out of memory\\n\"); exit(1); }\n    return "
	.ascii	"B_PTR(p);\n}\n\n/* B library functions - compatible with Tho"
	.ascii	"mpson's /etc/libb.a */\n/* String manipulation functions */\n"
	.ascii	"static inline word b_load(word addr){ return B_DEREF(addr); "
	.ascii	"}\nstatic inline void b_store(word addr, word v){\n#if B_BYT"
	.ascii	"EPTR\n    *(word*)(uword)addr = v;\n#else\n    *(word*)(uwor"
	.ascii	"d)((uword)addr * sizeof(word)) = v;\n#endif\n}\n\n/* B strin"
	.ascii	"g access - byte packing within words.\n *\n * In B_BYTEPTR=0"
	.ascii	" mode, bytes are packed into words with byte 0 at the LSB.\n"
	.ascii	" * This matches PDP-11 (little-endian) conventions. The shif"
	.ascii	"t-based approach\n * operates on word VALUES (not memory lay"
	.ascii	"out), making it consistent across\n * architectures: char(s,"
	.ascii	"0) always returns the least-significant byte of the\n * word"
	.ascii	" at address s, regardless of host endianness.\n *\n * Note: "
	.ascii	"This only works correctly when ALL byte access goes through "
	.ascii	"char()/lchar().\n * Mixing direct memory access (like C's *("
	.ascii	"char*)ptr) with B word operations will\n * give different re"
	.ascii	"sults on big-endian hosts.\n */\nstatic word b_char(word s, "
	.ascii	"word i){\n#if B_BYTEPTR\n    const unsigned char *p = (const"
	.ascii	" unsigned char*)B_CPTR(s);\n    return (word)p[(size_t)i];\n"
	.ascii	"#else\n    const uword W = (uword)sizeof(word);\n    uword w"
	.ascii	"i = (uword)i / W;\n    uword bi = (uword)i % W;\n    uword w"
	.ascii	"  = (uword)b_load((word)(s + (word)wi));\n    return (word)("
	.ascii	"(w >> (bi * 8)) & 0xFF);\n#endif\n}\n\nstatic word b_lchar(w"
	.ascii	"ord s, word i, word c){\n#if B_BYTEPTR\n    unsigned char *p"
	.ascii	" = (unsigned char*)B_CPTR(s);\n    p[(size_t)i] = (unsigned "
	.ascii	"char)(c & 0xFF);\n    return c;\n#else\n    const uword W = "
	.ascii	"(uword)sizeof(word);\n    uword wi = (uword)i / W;\n    uwor"
	.ascii	"d bi = (uword)i % W;\n\n    word addr = (word)(s + (word)wi)"
	.ascii	";\n    uword w   = (uword)b_load(addr);\n\n    uword mask = "
	.ascii	"(uword)0xFF << (bi * 8);\n    w = (w & ~mask) | (((uword)c &"
	.ascii	" 0xFF) << (bi * 8));\n\n    b_store(addr, (word)w);\n    ret"
	.ascii	"urn c;\n#endif\n}\n\n/* Command line argument support implem"
	.ascii	"entation */\nstatic word __b_pack_cstr(const char *s){\n    "
	.ascii	"size_t n = strlen(s);                 /* bytes, excluding NU"
	.ascii	"L */\n    size_t W = sizeof(word);              /* bytes per"
	.ascii	" word */\n    size_t total = n + 1;                 /* +1 fo"
	.ascii	"r 004 terminator */\n    size_t words = (total + W - 1) / W;"
	.ascii	"\n\n    word bp = b_alloc((word)words);       /* B pointer t"
	.ascii	"o word storage */\n\n    /* write bytes into the B string us"
	.ascii	"ing lchar (handles packing for B_BYTEPTR=0) */\n    for (siz"
	.ascii	"e_t i = 0; i < n; i++){\n        b_lchar(bp, (word)i, (word)"
	.ascii	"(unsigned char)s[i]);\n    }\n    b_lchar(bp, (word)n, (word"
	.ascii	")004);\n    return bp;\n}\n\nstatic void __b_bstr_to_cstr(wo"
	.ascii	"rd s, char *buf, size_t max){\n    size_t i = 0;\n    while "
	.ascii	"(i + 1 < max) {\n        word ch = b_char(s, (word)i);\n    "
	.ascii	"    if (ch == 004 || ch == 0) break;\n        buf[i++] = (ch"
	.ascii	"ar)(ch & 0xFF);\n    }\n    buf[i] = 0;\n}\n\n/* Convert a B"
	.ascii	" string (004-terminated) into a temporary NUL-terminated C s"
	.ascii	"tring */\nstatic const char *__b_cstr(word s){\n    static c"
	.ascii	"har *slots[4];\n    static size_t caps[4];\n    static int n"
	.ascii	"ext = 0;\n\n    if (s == 0) return \"\";\n\n    size_t len ="
	.ascii	" 0;\n    for (;; len++) {\n        word ch = b_char(s, (word"
	.ascii	")len);\n        if (ch == 004 || ch == 0) break;\n    }\n\n "
	.ascii	"   int idx = next;\n    next = (next + 1) & 3; /* simple rin"
	.ascii	"g buffer to survive multiple args */\n\n    size_t need = le"
	.ascii	"n + 1;\n    if (need > caps[idx]) {\n        size_t ncap = n"
	.ascii	"eed < 64 ? 64 : need;\n        char *nb = (char*)realloc(slo"
	.ascii	"ts[idx], ncap);\n        if (!nb) { fprintf(stderr, \"cstr: "
	.ascii	"out of memory\\n\"); exit(1); }\n        slots[idx] = nb;\n "
	.ascii	"       caps[idx] = ncap;\n    }\n\n    for (size_t i = 0; i "
	.ascii	"< len; i++) slots[idx][i] = (char)(b_char(s, (word)i) & 0xFF"
	.ascii	");\n    slots[idx][len] = 0;\n    return slots[idx];\n}\n\n/"
	.ascii	"* Duplicate a B string into a freshly allocated C string */\n"
	.ascii	"static char *__b_dup_bstr(word s){\n    size_t cap = 64;\n  "
	.ascii	"  char *buf = (char*)malloc(cap);\n    if (!buf) { fprintf(s"
	.ascii	"tderr, \"system: out of memory\\n\"); exit(1); }\n\n    size"
	.ascii	"_t i = 0;\n    for (;;) {\n        word ch = b_char(s, (word"
	.ascii	")i);\n        if (ch == 004 || ch == 0) break;\n        if ("
	.ascii	"i + 1 >= cap) {\n            size_t ncap = cap * 2;\n       "
	.ascii	"     char *nbuf = (char*)realloc(buf, ncap);\n            if"
	.ascii	" (!nbuf) { free(buf); fprintf(stderr, \"system: out of memor"
	.ascii	"y\\n\"); exit(1); }\n            buf = nbuf;\n            ca"
	.ascii	"p = ncap;\n        }\n        buf[i++] = (char)(ch & 0xFF);\n"
	.ascii	"    }\n    buf[i] = 0;\n    return buf;\n}\n\nstatic void __"
	.ascii	"b_setargs(int argc, char **argv){\n    __b_argc = argc;\n   "
	.ascii	" __b_argv = argv;\n\n    __b_argvb = (word*)malloc(sizeof(wo"
	.ascii	"rd) * (size_t)argc);\n    if (!__b_argvb) { fprintf(stderr, "
	.ascii	"\"argv: out of memory\\n\"); exit(1); }\n\n    for (int i = "
	.ascii	"0; i < argc; i++){\n        __b_argvb[i] = __b_pack_cstr(arg"
	.ascii	"v[i]);\n    }\n}\n\nstatic word b_argc(void) { return (word)"
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
	.ascii	" b_getchr(void) {\n    __b_sync_rd();\n    unsigned char c;\n"
	.ascii	"    ssize_t n = read(rd_fd, &c, 1);\n    if (n == 1) return "
	.ascii	"(word)c;\n    if (rd_fd != 0) {\n        close(rd_fd);\n    "
	.ascii	"    rd_fd = 0;\n        rd_unit = -1;\n        return b_getc"
	.ascii	"hr();\n    }\n    return (word)004; /* Return *e on EOF */\n"
	.ascii	"}\nstatic word b_putchr(word w) {\n    __b_sync_wr();\n    u"
	.ascii	"nsigned char c = (unsigned char)(w & 0xFF);\n    (void)write"
	.ascii	"(wr_fd, &c, 1);\n    return w;\n}\nstatic word b_putstr(word"
	.ascii	" s) {\n    __b_sync_wr();\n    word i = 0;\n    for (;;) {\n"
	.ascii	"        word ch = b_char(s, i++);\n        if (ch == 004 || "
	.ascii	"ch == 0) break;\n        b_putchar(ch);\n    }\n    return s"
	.ascii	";\n}\nstatic word b_getstr(word buf) {\n    __b_sync_rd();\n"
	.ascii	"    size_t i = 0;\n    unsigned char c;\n    for (;;) {\n   "
	.ascii	"     ssize_t n = read(rd_fd, &c, 1);\n        if (n == 1 && "
	.ascii	"c != '\\n' && c != '\\r') {\n            b_lchar(buf, (word)"
	.ascii	"i, (word)c);\n            i++;\n            continue;\n     "
	.ascii	"   }\n        if (n == 1) break; /* newline */\n        if ("
	.ascii	"rd_fd != 0) {\n            close(rd_fd);\n            rd_fd "
	.ascii	"= 0;\n            rd_unit = -1;\n            continue; /* re"
	.ascii	"try on terminal */\n        }\n        break; /* EOF */\n   "
	.ascii	" }\n    b_lchar(buf, (word)i, (word)004);\n    return buf;\n"
	.ascii	"}\nstatic word b_flush(void){\n    __b_sync_wr();\n    if (w"
	.ascii	"r_fd == 1) {\n        fflush(stdout);\n    } else {\n       "
	.ascii	" fsync(wr_fd);\n    }\n    return 0;\n}\n\n#include <stdarg."
	.ascii	"h>\n\n/* Print number in specified base (from B manual) */\n"
	.ascii	"static void b_printn_u(word n, word base) {\n    // recursio"
	.ascii	"n like old implementations\n    word a = (word)((uword)n / ("
	.ascii	"uword)base);\n    if (a) b_printn_u(a, base);\n    b_putchar"
	.ascii	"((word)((uword)n % (uword)base) + '0');\n}\n\nstatic word b_"
	.ascii	"printf(word fmt, ...){\n    va_list ap;\n    va_start(ap, fm"
	.ascii	"t);\n\n    word i = 0;\n    for (;;){\n        word ch = b_c"
	.ascii	"har(fmt, i++);\n        if (ch == 004 || ch == 0) break;  /*"
	.ascii	" '*e' or NUL terminator */\n        if (ch != '%'){ b_putcha"
	.ascii	"r(ch); continue; }\n\n        word code = b_char(fmt, i++);\n"
	.ascii	"        if (code == 004) break;\n\n        word arg = va_arg"
	.ascii	"(ap, word);\n\n        switch ((int)code){\n        case 'd'"
	.ascii	": {\n#if WORD_BITS == 16\n            int16_t v = (int16_t)a"
	.ascii	"rg;\n            if (v < 0){ b_putchar('-'); v = (int16_t)-v"
	.ascii	"; }\n            if (v) b_printn_u((word)(uword)(uint16_t)v,"
	.ascii	" 10);\n#elif WORD_BITS == 32\n            int32_t v = (int32"
	.ascii	"_t)arg;\n            if (v < 0){ b_putchar('-'); v = -v; }\n"
	.ascii	"            if (v) b_printn_u((word)(uword)(uint32_t)v, 10);"
	.ascii	"\n#else\n            word v = arg;\n            if (v < 0){ "
	.ascii	"b_putchar('-'); v = -v; }\n            if (v) b_printn_u((wo"
	.ascii	"rd)(uword)v, 10);\n#endif\n            else b_putchar('0');\n"
	.ascii	"            break;\n        }\n        case 'o': {\n#if WORD"
	.ascii	"_BITS == 16\n            uint16_t v = (uint16_t)arg;\n#elif "
	.ascii	"WORD_BITS == 32\n            uint32_t v = (uint32_t)arg;\n#e"
	.ascii	"lse\n            uword v = (uword)arg;\n#endif\n            "
	.ascii	"if (v) b_printn_u((word)(uword)v, 8);\n            else b_pu"
	.ascii	"tchar('0');\n            break;\n        }\n        case 'u'"
	.ascii	": {\n            uword v = (uword)arg;\n            if (v) b"
	.ascii	"_printn_u((word)v, 10);\n            else b_putchar('0');\n "
	.ascii	"           break;\n        }\n        case 'p': {\n         "
	.ascii	"   uword v = (uword)arg;\n            b_putchar('0'); b_putc"
	.ascii	"har('x');\n            int started = 0;\n            for (in"
	.ascii	"t shift = (int)(sizeof(uword)*8 - 4); shift >= 0; shift -= 4"
	.ascii	") {\n                int nib = (int)((v >> shift) & 0xF);\n "
	.ascii	"               if (!started && nib == 0 && shift > 0) contin"
	.ascii	"ue;\n                started = 1;\n                b_putchar"
	.ascii	"((word)(nib < 10 ? ('0' + nib) : ('a' + nib - 10)));\n      "
	.ascii	"      }\n            if (!started) b_putchar('0');\n        "
	.ascii	"    break;\n        }\n        case 'z': {\n            word"
	.ascii	" mod = b_char(fmt, i++);\n            if (mod == 'u') {\n   "
	.ascii	"             uword v = (uword)arg;\n                if (v) b"
	.ascii	"_printn_u((word)v, 10);\n                else b_putchar('0')"
	.ascii	";\n            } else if (mod == 'd') {\n                lon"
	.ascii	"g v = (long)arg;\n                if (v < 0) { b_putchar('-'"
	.ascii	"); v = -v; }\n                if (v) b_printn_u((word)(uword"
	.ascii	")v, 10);\n                else b_putchar('0');\n            "
	.ascii	"} else {\n                b_putchar('%'); b_putchar('z'); b_"
	.ascii	"putchar(mod);\n            }\n            break;\n        }\n"
	.ascii	"        case 'c':\n            b_putchar(arg);\n            "
	.ascii	"break;\n        case 's': {\n            word j = 0;\n      "
	.ascii	"      for (;;){\n                word sc = b_char(arg, j++);"
	.ascii	"\n                if (sc == 004 || sc == 0) break;  /* Handl"
	.ascii	"e both *e and NUL termination */\n                b_putchar("
	.ascii	"sc);\n            }\n            break;\n        }\n        "
	.ascii	"default:\n            b_putchar('%'); b_putchar(code);\n    "
	.ascii	"        break;\n        }\n    }\n\n    va_end(ap);\n    ret"
	.ascii	"urn 0;\n}\n\n/* File I/O functions - with actual implementat"
	.ascii	"ions */\n#include <fcntl.h>\nstatic word b_open(word name, w"
	.ascii	"ord mode){\n    const char *p = (const char*)B_CPTR(name);\n"
	.ascii	"    int flags = ((int)mode == 0) ? O_RDONLY : O_WRONLY;\n   "
	.ascii	" return (word)open(p, flags);\n}\nstatic word b_openr(word f"
	.ascii	"d, word name){\n    char buf[512];\n    __b_bstr_to_cstr(nam"
	.ascii	"e, buf, sizeof(buf));\n    int target = (int)fd;\n    if (ta"
	.ascii	"rget < 0 || buf[0] == '\\0') {\n        rd_fd = 0; rd_unit ="
	.ascii	" -1; return 0;\n    }\n    int newfd = open(buf, O_RDONLY);\n"
	.ascii	"    if (rd_fd != 0 && rd_fd != target) close(rd_fd);\n    if"
	.ascii	" (newfd < 0) { rd_fd = -1; rd_unit = (word)target; return -1"
	.ascii	"; }\n    if (newfd != target) {\n        if (dup2(newfd, tar"
	.ascii	"get) < 0) { close(newfd); return -1; }\n        close(newfd)"
	.ascii	";\n        newfd = target;\n    }\n    rd_fd = newfd;\n    r"
	.ascii	"d_unit = (word)target;\n    return (word)newfd;\n}\nstatic w"
	.ascii	"ord b_openw(word fd, word name){\n    char buf[512];\n    __"
	.ascii	"b_bstr_to_cstr(name, buf, sizeof(buf));\n    int target = (i"
	.ascii	"nt)fd;\n    if (target < 0 || buf[0] == '\\0') {\n        wr"
	.ascii	"_fd = 1; wr_unit = -1; return 1;\n    }\n    int newfd = ope"
	.ascii	"n(buf, O_WRONLY | O_CREAT | O_TRUNC, 0666);\n    if (newfd <"
	.ascii	" 0) return -1;\n    if (wr_fd != 1 && wr_fd != target && wr_"
	.ascii	"fd != newfd) close(wr_fd);\n    if (newfd != target) {\n    "
	.ascii	"    if (dup2(newfd, target) < 0) { close(newfd); return -1; "
	.ascii	"}\n        close(newfd);\n        newfd = target;\n    }\n  "
	.ascii	"  wr_fd = newfd;\n    wr_unit = (word)target;\n    return (w"
	.ascii	"ord)newfd;\n}\nstatic word b_close(word fd) {\n    int cfd ="
	.ascii	" (int)fd;\n    word r = (word)close(cfd);\n    if (r == 0) {"
	.ascii	"\n        if (cfd == rd_fd || cfd == (int)rd_unit) { rd_fd ="
	.ascii	" 0; rd_unit = -1; }\n        if (cfd == wr_fd || cfd == (int"
	.ascii	")wr_unit) { wr_fd = 1; wr_unit = -1; }\n    }\n    return r;"
	.ascii	"\n}\nstatic word b_read(word fd, word buf, word n) {\n    ch"
	.ascii	"ar *p = (char*)B_CPTR(buf);\n    if ((size_t)n < sizeof(word"
	.ascii	")) memset(p, 0, sizeof("
	.ascii	"word));\n    return (word)read((int)fd, p, (size_t)n);\n}\ns"
	.ascii	"tatic word b_write(word fd, word buf, word n) {\n    const c"
	.ascii	"har *p = (const char*)B_CPTR(buf);\n    return (word)write(("
	.ascii	"int)fd, p, (size_t)n);\n}\nstatic word b_creat(word name, wo"
	.ascii	"rd mode) {\n    const char *p = (const char*)B_CPTR(name);\n"
	.ascii	"    return (word)creat(p, (mode_t)mode);\n}\nstatic word b_s"
	.ascii	"eek(word fd, word offset, word whence) {\n    off_t r = lsee"
	.ascii	"k((int)fd, (off_t)offset, (int)whence);\n    return (r < 0) "
	.ascii	"? (word)-1 : (word)0;\n}\n\n/* Process control functions - w"
	.ascii	"ith actual implementations */\nstatic word b_fork(void) {\n "
	.ascii	"   return (word)fork();\n}\nstatic word __b_wait_status;\n\n"
	.ascii	"static word b_wait(void) {\n    int st = 0;\n    pid_t pid ="
	.ascii	" wait(&st);\n    __b_wait_status = (word)st;\n    return (wo"
	.ascii	"rd)pid;\n}\nstatic word b_execl(word path, ...) {\n    const"
	.ascii	" char *p = (const char*)B_CPTR(path);\n\n    char *argv[64];"
	.ascii	"\n    int i = 0;\n    argv[i++] = (char*)p;\n\n    va_list a"
	.ascii	"p;\n    va_start(ap, path);\n    for (; i < 63; ) {\n       "
	.ascii	" word w = va_arg(ap, word);\n        if (w == 0) break;\n   "
	.ascii	"     argv[i++] = (char*)B_CPTR(w);\n    }\n    va_end(ap);\n"
	.ascii	"\n    argv[i] = NULL;\n    execv(p, argv);\n    return -1; /"
	.ascii	"* Only reached on error */\n}\n\nstatic word b_execv(word pa"
	.ascii	"th, word argv) {\n    /* Note: Manual specifies execv(path, "
	.ascii	"argv, count) with counted vector */\n    /* Current implemen"
	.ascii	"tation uses null-terminated vector for compatibility */\n   "
	.ascii	" const char *p = (const char*)B_CPTR(path);\n    word *av = "
	.ascii	"(word*)B_CPTR(argv);\n\n    char *cargv[256];\n    int i = 0"
	.ascii	";\n    for (; i < 255 && av[i] != 0; i++) cargv[i] = (char*)"
	.ascii	"B_CPTR(av[i]);\n    cargv[i] = NULL;\n\n    execv(p, cargv);"
	.ascii	"\n    return -1; /* Only reached on error */\n}\n\nstatic wo"
	.ascii	"rd b_system(word cmd) {\n    /* TSS-style: treat the string "
	.ascii	"as a literal command line (no shell expansion) */\n    char "
	.ascii	"*line = __b_dup_bstr(cmd);\n    if (!line) return -1;\n\n   "
	.ascii	" char *argv[128];\n    size_t argc = 0;\n    char *p = line;"
	.ascii	"\n\n    while (*p) {\n        while (*p && isspace((unsigned"
	.ascii	" char)*p)) p++;\n        if (!*p) break;\n        if (argc +"
	.ascii	" 1 >= sizeof(argv)/sizeof(argv[0])) { free(line); return -1;"
	.ascii	" }\n        argv[argc++] = p;\n        while (*p && !isspace"
	.ascii	"((unsigned char)*p)) p++;\n        if (*p) { *p = 0; p++; }\n"
	.ascii	"    }\n\n    if (argc == 0) { free(line); return -1; }\n    "
	.ascii	"argv[argc] = NULL;\n\n    pid_t pid = fork();\n    if (pid ="
	.ascii	"= 0) {\n        execvp(argv[0], argv);\n        _exit(127);\n"
	.ascii	"    }\n    if (pid < 0) { free(line); return -1; }\n\n    in"
	.ascii	"t st = 0;\n    pid_t w = waitpid(pid, &st, 0);\n    free(lin"
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
	.ascii	"        args[i] = B_CPTR(w);\n    }\n    va_end(ap);\n \n   "
	.ascii	" word r = 0;\n    switch (nargs) {\n    case 0: r = ((word ("
	.ascii	"*)(void))fn)(); break;\n    case 1: r = ((word (*)(void*))fn"
	.ascii	")(args[0]); break;\n    case 2: r = ((word (*)(void*, void*)"
	.ascii	")fn)(args[0], args[1]); break;\n    case 3: r = ((word (*)(v"
	.ascii	"oid*, void*, void*))fn)(args[0], args[1], args[2]); break;\n"
	.ascii	"    case 4: r = ((word (*)(void*, void*, void*, void*))fn)(a"
	.ascii	"rgs[0], args[1], args[2], args[3]); break;\n    case 5: r = "
	.ascii	"((word (*)(void*, void*, void*, void*, void*))fn)(args[0], a"
	.ascii	"rgs[1], args[2], args[3], args[4]); break;\n    case 6: r = "
	.ascii	"((word (*)(void*, void*, void*, void*, void*, void*))fn)(arg"
	.ascii	"s[0], args[1], args[2], args[3], args[4], args[5]); break;\n"
	.ascii	"    case 7: r = ((word (*)(void*, void*, void*, void*, void*"
	.ascii	", void*, void*))fn)(args[0], args[1], args[2], args[3], args"
	.ascii	"[4], args[5], args[6]); break;\n    case 8: r = ((word (*)(v"
	.ascii	"oid*, void*, void*, void*, void*, void*, void*, void*))fn)(a"
	.ascii	"rgs[0], args[1], args[2], args[3], args[4], args[5], args[6]"
	.ascii	", args[7]); break;\n    case 9: r = ((word (*)(void*, void*,"
	.ascii	" void*, void*, void*, void*, void*, void*, void*))fn)(args[0"
	.ascii	"], args[1], args[2], args[3], args[4], args[5], args[6], arg"
	.ascii	"s[7], args[8]); break;\n    case 10: r = ((word (*)(void*, v"
	.ascii	"oid*, void*, void*, void*, void*, void*, void*, void*, void*"
	.ascii	"))fn)(args[0], args[1], args[2], args[3], args[4], args[5], "
	.ascii	"args[6], args[7], args[8], args[9]); break;\n    default: re"
	.ascii	"turn -1;\n    }\n    return r;\n}\n\n/* System functions - w"
	.ascii	"ith actual implementations where possible */\nstatic word b_"
	.ascii	"time(word tvp) {\n    time_t now = time(NULL);\n    if (tvp)"
	.ascii	" {\n        uint16_t lo = (uint16_t)(now & 0xFFFF);\n       "
	.ascii	" uint16_t hi = (uint16_t)((now >> 16) & 0xFFFF);\n        wo"
	.ascii	"rd *tv = (word*)B_CPTR(tvp);\n        tv[0] = (word)(uword)l"
	.ascii	"o;\n        tv[1] = (word)(uword)hi;\n    }\n    return 0;\n"
	.ascii	"}\n\nstatic word b_ctime(word tvp) {\n    static word bufw[3"
	.ascii	"2];               // 32 words = 64 bytes worth of chars\n   "
	.ascii	" word *tv = (word*)B_CPTR(tvp);\n    time_t t = (time_t)((ui"
	.ascii	"nt16_t)tv[0]) | ((time_t)((uint16_t)tv[1]) << 16);\n\n    co"
	.ascii	"nst char *cs = ctime(&t);\n    if (!cs) return 0;\n\n    siz"
	.ascii	"e_t i = 0;\n    while (cs[i] && cs[i] != '\\n' && i < 63) {\n"
	.ascii	"        b_lchar(B_PTR(bufw), (word)i, (word)(unsigned char)c"
	.ascii	"s[i]);\n        i++;\n    }\n    b_lchar(B_PTR(bufw), (word)"
	.ascii	"i, 004);\n    return B_PTR(bufw);\n}\nstatic word b_getuid(v"
	.ascii	"oid) {\n    return (word)getuid();\n}\nstatic word b_chdir(w"
	.ascii	"ord path) {\n    const char *p = (const char*)B_CPTR(path);\n"
	.ascii	"    return (word)chdir(p);\n}\nstatic word b_unlink(word pat"
	.ascii	"h) {\n    const char *p = (const char*)B_CPTR(path);\n    re"
	.ascii	"turn (word)unlink(p);\n}\n\n/* System functions with actual "
	.ascii	"implementations */\nstatic word b_chmod(word path, word mode"
	.ascii	") {\n    const char *p = (const char*)B_CPTR(path);\n    ret"
	.ascii	"urn (word)chmod(p, (mode_t)mode);\n}\nstatic word b_chown(wo"
	.ascii	"rd path, word owner) {\n    const char *p = (const char*)B_C"
	.ascii	"PTR(path);\n    return (word)chown(p, (uid_t)owner, (gid_t)-"
	.ascii	"1);\n}\nstatic word b_link(word old, word new) {\n    const "
	.ascii	"char *o = (const char*)B_CPTR(old);\n    const char *n = (co"
	.ascii	"nst char*)B_CPTR(new);\n    return (word)link(o, n);\n}\nsta"
	.ascii	"tic word b_stat(word path, word bufp) {\n    const char *p ="
	.ascii	" (const char*)B_CPTR(path);\n    struct stat st;\n    if (st"
	.ascii	"at(p, &st) != 0) return -1;\n    if (bufp) {\n        unsign"
	.ascii	"ed char *b = (unsigned char*)B_CPTR(bufp);\n        for (int"
	.ascii	" i = 0; i < 20*sizeof(word); i++) b[i] = 0;\n        size_t "
	.ascii	"n = sizeof(st);\n        if (n > 20*sizeof(word)) n = 20*siz"
	.ascii	"eof(word);\n        memcpy(b, &st, n);\n    }\n    return 0;"
	.ascii	"\n}\n\nstatic word b_fstat(word fd, word bufp) {\n    struct"
	.ascii	" stat st;\n    if (fstat((int)fd, &st) != 0) return -1;\n   "
	.ascii	" if (bufp) {\n        unsigned char *b = (unsigned char*)B_C"
	.ascii	"PTR(bufp);\n        for (int i = 0; i < 20*sizeof(word); i++"
	.ascii	") b[i] = 0;\n        size_t n = sizeof(st);\n        if (n >"
	.ascii	" 20*sizeof(word)) n = 20*sizeof(word);\n        memcpy(b, &s"
	.ascii	"t, n);\n    }\n    return 0;\n}\nstatic word b_setuid(word u"
	.ascii	"id) {\n    return (word)setuid((uid_t)uid);\n}\nstatic word "
	.ascii	"b_makdir(word path, word mode) {\n    const char *p = (const"
	.ascii	" char*)B_CPTR(path);\n    return (word)mkdir(p, (mode_t)mode"
	.ascii	");\n}\n\n/* printn(number, base) - print number in specified"
	.ascii	" base (from B manual) */\nstatic word b_printn(word n, word "
	.ascii	"base) {\n    // Handle negative numbers for decimal only\n  "
	.ascii	"  if (base == 10 && (int16_t)n < 0) {\n        b_putchar('-'"
	.ascii	");\n        n = (word)(-(int16_t)n);\n    }\n    b_printn_u("
	.ascii	"n, base);\n    return n;\n}\nstatic word b_putnum(word n) {\n"
	.ascii	"    b_printn(n, (word)10);\n    return n;\n}\nstatic volatil"
	.ascii	"e sig_atomic_t __b_got_intr = 0;\n\nstatic void __b_sigint(i"
	.ascii	"nt sig){ (void)sig; __b_got_intr = 1; }\n\nstatic word b_gtt"
	.ascii	"y(word fd, word ttstat){\n    struct termios t;\n    if (tcg"
	.ascii	"etattr((int)fd, &t) < 0) return -1;\n\n    word *vec = (word"
	.ascii	"*)B_CPTR(ttstat);\n    vec[0] = (word)t.c_iflag;\n    vec[1]"
	.ascii	" = (word)t.c_oflag;\n    vec[2] = (word)t.c_lflag;\n    retu"
	.ascii	"rn 0;\n}\n\nstatic word b_stty(word fd, word ttstat){\n    s"
	.ascii	"truct termios t;\n    if (tcgetattr((int)fd, &t) < 0) return"
	.ascii	" -1;\n\n    word *vec = (word*)B_CPTR(ttstat);\n    t.c_ifla"
	.ascii	"g = (tcflag_t)vec[0];\n    t.c_oflag = (tcflag_t)vec[1];\n  "
	.ascii	"  t.c_lflag = (tcflag_t)vec[2];\n    return (word)tcsetattr("
	.ascii	"(int)fd, TCSANOW, &t);\n}\nstatic word b_intr(word on) {\n  "
	.ascii	"  /* Set up interrupt handling */\n    /* on != 0: catch int"
	.ascii	"errupts, on =="
	.string	" 0: restore default */\n    if (on) {\n        __b_got_intr = 0;\n        if (signal(SIGINT, __b_sigint) == SIG_ERR) return -1;\n    } else {\n        if (signal(SIGINT, SIG_DFL) == SIG_ERR) return -1;\n    }\n    return 0;\n}\n\n/* Builtin aliases for B source */\n\n"
	.section	.rodata.str1.1
.LC182:
	.string	"static word __%s_blob[%zu];\n"
.LC183:
	.string	"static word __%s_store[%zu];\n"
.LC184:
	.string	"static word %s;\n"
.LC185:
	.string	"static void __b_init(void) {\n"
	.section	.rodata.str1.8
	.align 8
.LC186:
	.string	"    setvbuf(stdout, NULL, _IONBF, 0);\n"
	.section	.rodata.str1.1
.LC187:
	.string	"    %s = "
.LC188:
	.string	"    %s = __%s_blob[0];\n"
	.section	.rodata.str1.8
	.align 8
.LC189:
	.string	"    %s = B_ADDR(__%s_blob[0]);\n"
	.align 8
.LC190:
	.string	"    %s = B_ADDR(__%s_store[0]);\n"
	.section	.rodata.str1.1
.LC191:
	.string	"__%s_store"
.LC192:
	.string	"}\n\n"
.LC193:
	.string	"static word __b_user_main("
.LC194:
	.string	"word "
.LC195:
	.string	"word"
.LC196:
	.string	");\n"
.LC197:
	.string	"word __b_user_main("
	.section	.rodata.str1.8
	.align 8
.LC198:
	.string	"int main(int argc, char **argv){\n"
	.section	.rodata.str1.1
.LC199:
	.string	"    __b_setargs(argc, argv);\n"
.LC200:
	.string	"    __b_init();\n"
	.section	.rodata.str1.8
	.align 8
.LC201:
	.string	"    return (int)__b_user_main();\n"
	.align 8
.LC202:
	.string	"    return (int)__b_user_main((word)argc);\n"
	.align 8
.LC203:
	.string	"    return (int)__b_user_main((word)argc, B_PTR(__b_argvb));\n"
	.section	.rodata.str1.1
.LC204:
	.string	"__%s_blob"
	.text
	.p2align 4
	.globl	emit_program_c
	.type	emit_program_c, @function
emit_program_c:
.LFB49:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pxor	%xmm0, %xmm0
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
	movl	%ecx, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	movq	%rsi, %rdi
	subq	$328, %rsp
	.cfi_def_cfa_offset 384
	movq	%rdx, 8(%rsp)
	movq	%fs:40, %rbp
	movq	%rbp, 312(%rsp)
	movl	%r9d, %ebp
	movl	%r9d, current_word_bits(%rip)
	movups	%xmm0, 8+string_pool(%rip)
	movl	%ecx, current_byteptr(%rip)
	movq	$0, string_pool(%rip)
	movq	$0, 8+name_map(%rip)
	call	collect_strings_program
	movq	%rbx, %rcx
	movl	$1498, %edx
	movl	$1, %esi
	leaq	.LC177(%rip), %rdi
	call	fwrite@PLT
	xorl	%edx, %edx
	testl	%r12d, %r12d
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
	movq	%rbx, %rcx
	movl	$1457, %edx
	movl	$1, %esi
	leaq	.LC180(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$25952, %edx
	movl	$1, %esi
	leaq	.LC181(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1368
.L1221:
	cmpq	$0, 8(%r14)
	je	.L1222
	xorl	%ebp, %ebp
	jmp	.L1252
	.p2align 4,,10
	.p2align 3
.L1223:
	cmpl	$3, %eax
	je	.L1369
	cmpl	$2, %eax
	je	.L1370
.L1224:
	addq	$1, %rbp
	cmpq	8(%r14), %rbp
	jnb	.L1222
.L1252:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rdx
	movl	(%rdx), %eax
	testl	%eax, %eax
	jne	.L1223
	movq	8(%rdx), %rsi
	movq	8(%rsp), %r8
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbx, %rdi
	addq	$1, %rbp
	call	emit_stmt
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	8(%r14), %rbp
	jb	.L1252
	.p2align 4
	.p2align 3
.L1222:
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC185(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$38, %edx
	movl	$1, %esi
	leaq	.LC186(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%r14)
	je	.L1253
	xorl	%ebp, %ebp
	jmp	.L1265
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1254:
	addq	$1, %rbp
	cmpq	8(%r14), %rbp
	jnb	.L1253
.L1265:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$2, (%rax)
	jne	.L1254
	movq	8(%rax), %r13
	movq	8(%r13), %rdi
	call	get_mangled_name
	movq	%rax, %r15
	movl	16(%r13), %eax
	testl	%eax, %eax
	jne	.L1255
	movq	48(%r13), %rax
	testq	%rax, %rax
	je	.L1254
	movl	(%rax), %r12d
	testl	%r12d, %r12d
	jne	.L1254
	movq	%r15, %rdx
	leaq	.LC187(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r13), %rax
.L1366:
	movq	16(%rax), %rsi
	movq	8(%rsp), %rdx
	movq	%rbx, %rdi
	addq	$1, %rbp
	call	emit_ival_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC141(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r14), %rbp
	jb	.L1265
	.p2align 4
	.p2align 3
.L1253:
	movl	$1, %esi
	leaq	.LC192(%rip), %rdi
	movq	%rbx, %rcx
	movl	$3, %edx
	call	fwrite@PLT
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_known_external_function_prototypes
	cmpq	$0, 8(%r14)
	je	.L1266
	xorl	%ebp, %ebp
	jmp	.L1275
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1267:
	addq	$1, %rbp
	cmpq	8(%r14), %rbp
	jnb	.L1266
.L1275:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$1, (%rax)
	jne	.L1267
	movq	8(%rax), %r12
	leaq	.LC65(%rip), %rsi
	movq	(%r12), %r13
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1268
	leaq	.LC66(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1269
.L1268:
	movq	%rbx, %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC193(%rip), %rdi
	call	fwrite@PLT
.L1270:
	xorl	%r13d, %r13d
	cmpq	$0, 16(%r12)
	je	.L1273
.L1272:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	addq	$1, %r13
	leaq	.LC195(%rip), %rdi
	call	fwrite@PLT
	cmpq	16(%r12), %r13
	jnb	.L1273
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC99(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1272
	.p2align 4,,10
	.p2align 3
.L1370:
	movq	8(%rdx), %r12
	movq	8(%r12), %rdi
	call	get_mangled_name
	movq	%rax, %r13
	movl	16(%r12), %eax
	cmpl	$1, %eax
	jne	.L1227
	movq	48(%r12), %rdi
	testq	%rdi, %rdi
	je	.L1228
	cmpl	$1, (%rdi)
	jne	.L1228
	movq	24(%rdi), %r12
	cmpq	$1, %r12
	jne	.L1229
	movq	16(%rdi), %rax
	movq	(%rax), %rax
	movl	(%rax), %r15d
	testl	%r15d, %r15d
	jne	.L1229
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L1229
	cmpl	$1, (%rax)
	je	.L1365
.L1229:
	call	edge_tail_words_top
	leaq	(%r12,%rax), %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	jmp	.L1293
	.p2align 4,,10
	.p2align 3
.L1273:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	addq	$1, %rbp
	leaq	.LC196(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r14), %rbp
	jb	.L1275
	.p2align 4
	.p2align 3
.L1266:
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	$0, 8(%r14)
	je	.L1220
	movq	$0, 24(%rsp)
	xorl	%r15d, %r15d
	movl	$0, 16(%rsp)
	.p2align 5
	.p2align 4
	.p2align 3
.L1286:
	movq	(%r14), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$1, (%rax)
	je	.L1371
.L1277:
	addq	$1, %r15
	cmpq	8(%r14), %r15
	jb	.L1286
	movl	16(%rsp), %edi
	testl	%edi, %edi
	jne	.L1372
.L1220:
	movq	312(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1367
	addq	$328, %rsp
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
.L1255:
	.cfi_restore_state
	cmpl	$1, %eax
	je	.L1373
	cmpl	$2, %eax
	jne	.L1254
	movq	%r15, %rcx
	movq	%r15, %rdx
	leaq	.LC190(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r13), %rax
	testq	%rax, %rax
	je	.L1254
	cmpl	$1, (%rax)
	jne	.L1254
	movl	32(%r13), %r10d
	movq	24(%rax), %rcx
	testl	%r10d, %r10d
	jne	.L1261
	movq	24(%r13), %rdi
	testq	%rdi, %rdi
	je	.L1261
	leaq	40(%rsp), %rsi
	movq	%rcx, 16(%rsp)
	movl	$1, %r12d
	movq	$0, 40(%rsp)
	call	try_eval_const_expr
	movq	16(%rsp), %rcx
	testq	%rcx, %rcx
	cmovne	%rcx, %r12
	testl	%eax, %eax
	je	.L1264
	movq	40(%rsp), %rax
	xorl	%edx, %edx
	testq	%rax, %rax
	cmovns	%rax, %rdx
	movq	%rdx, %r12
	addq	$1, %r12
	cmpq	%rcx, %r12
	cmovb	%rcx, %r12
.L1264:
	leaq	48(%rsp), %rdi
	movq	%r15, %rcx
	movl	$256, %esi
	leaq	.LC191(%rip), %rdx
	xorl	%eax, %eax
	call	snprintf@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 392
	movq	48(%r13), %rcx
	movq	%r12, %r8
	pushq	16(%rsp)
	.cfi_def_cfa_offset 400
	movl	$2, %r9d
	xorl	%edx, %edx
	movq	%rbx, %rdi
	leaq	64(%rsp), %rsi
	call	emit_edge_list_init
	popq	%r8
	.cfi_def_cfa_offset 392
	popq	%r9
	.cfi_def_cfa_offset 384
	jmp	.L1254
	.p2align 4,,10
	.p2align 3
.L1369:
	movq	8(%rdx), %r12
	leaq	.LC67(%rip), %rdi
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r12), %rdi
	testq	%rdi, %rdi
	je	.L1226
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1226:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC141(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1224
	.p2align 4,,10
	.p2align 3
.L1371:
	movq	8(%rax), %r12
	leaq	.LC65(%rip), %rsi
	movq	(%r12), %rbp
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1278
	leaq	.LC66(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1279
.L1278:
	movq	16(%r12), %rax
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC197(%rip), %rdi
	movq	%rax, 24(%rsp)
	call	fwrite@PLT
	movl	$1, 16(%rsp)
.L1280:
	xorl	%ebp, %ebp
	leaq	.LC194(%rip), %r13
	cmpq	$0, 16(%r12)
	je	.L1283
.L1282:
	movq	%r13, %rdi
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r12), %rax
	movq	(%rax,%rbp,8), %rdi
	testq	%rdi, %rdi
	je	.L1284
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1284:
	addq	$1, %rbp
	cmpq	16(%r12), %rbp
	jnb	.L1283
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC99(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1282
	.p2align 4,,10
	.p2align 3
.L1283:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC158(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r12), %rsi
	movq	%rbx, %rdi
	xorl	%edx, %edx
	movq	8(%rsp), %r8
	movl	$1, %ecx
	call	emit_stmt
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1277
	.p2align 4,,10
	.p2align 3
.L1227:
	cmpl	$2, %eax
	je	.L1374
	movq	%r13, %rdx
	movl	4(%r12), %r13d
	testl	%r13d, %r13d
	je	.L1251
	leaq	.LC184(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1224
	.p2align 4,,10
	.p2align 3
.L1228:
	movl	$1, %ecx
.L1293:
	movq	%r13, %rdx
	leaq	.LC182(%rip), %rsi
.L1364:
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L1365:
	movq	%r13, %rdx
	leaq	.LC154(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1224
	.p2align 4,,10
	.p2align 3
.L1373:
	movq	48(%r13), %rdi
	testq	%rdi, %rdi
	je	.L1257
	cmpl	$1, (%rdi)
	je	.L1375
.L1257:
	movq	%r15, %rcx
	movq	%r15, %rdx
	leaq	.LC188(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1254
	.p2align 4,,10
	.p2align 3
.L1368:
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1221
	.p2align 4,,10
	.p2align 3
.L1372:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC198(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC199(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC200(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%rsp)
	je	.L1290
	cmpq	$1, 24(%rsp)
	je	.L1376
	cmpq	$2, 24(%rsp)
	jne	.L1290
	movq	%rbx, %rcx
	movl	$61, %edx
	movl	$1, %esi
	leaq	.LC203(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1288
	.p2align 4,,10
	.p2align 3
.L1269:
	leaq	.LC194(%rip), %r13
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	(%r12), %rdi
	testq	%rdi, %rdi
	je	.L1271
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1271:
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1270
	.p2align 4,,10
	.p2align 3
.L1290:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC201(%rip), %rdi
	call	fwrite@PLT
.L1288:
	movq	312(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1367
	addq	$328, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC151(%rip), %rdi
	popq	%rbp
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
.L1374:
	.cfi_restore_state
	movq	48(%r12), %r15
	movl	32(%r12), %eax
	testq	%r15, %r15
	je	.L1377
	cmpl	$1, (%r15)
	je	.L1234
	testl	%eax, %eax
	jne	.L1232
	movq	24(%r12), %rdi
	testq	%rdi, %rdi
	je	.L1232
	movq	$0, 40(%rsp)
	leaq	40(%rsp), %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1232
	movq	40(%rsp), %rax
	leaq	1(%rax), %rcx
	testq	%rax, %rax
	movl	$1, %eax
	cmovs	%rax, %rcx
.L1248:
	cmpl	$1, (%r15)
	jne	.L1249
.L1241:
	movq	%r15, %rdi
	movq	%rcx, 16(%rsp)
	call	edge_tail_words_top
	movq	16(%rsp), %rcx
	addq	%rax, %rcx
	movl	$1, %eax
	cmove	%rax, %rcx
	jmp	.L1249
	.p2align 4,,10
	.p2align 3
.L1251:
	leaq	.LC154(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1224
	.p2align 4,,10
	.p2align 3
.L1279:
	leaq	.LC194(%rip), %r13
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movq	(%r12), %rdi
	testq	%rdi, %rdi
	je	.L1281
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1281:
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1280
.L1377:
	testl	%eax, %eax
	je	.L1378
.L1232:
	movl	$1, %ecx
.L1249:
	movq	%r13, %rdx
	leaq	.LC183(%rip), %rsi
	jmp	.L1364
.L1375:
	movq	24(%rdi), %r12
	cmpq	$1, %r12
	je	.L1379
	call	edge_tail_words_top
	leaq	48(%rsp), %rdi
	movq	%r15, %rcx
	leaq	.LC204(%rip), %rdx
	movq	%rax, %r11
	leaq	(%r12,%rax), %rax
	movl	$256, %esi
	movq	%rax, 16(%rsp)
	xorl	%eax, %eax
	movq	%r11, 24(%rsp)
	call	snprintf@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 392
	movq	48(%r13), %rcx
	xorl	%edx, %edx
	pushq	16(%rsp)
	.cfi_def_cfa_offset 400
	movl	$2, %r9d
	movq	%r12, %r8
	movq	%rbx, %rdi
	leaq	64(%rsp), %rsi
	call	emit_edge_list_init
	popq	%rcx
	.cfi_def_cfa_offset 392
	popq	%rsi
	.cfi_def_cfa_offset 384
	cmpq	$1, 16(%rsp)
	movq	24(%rsp), %r11
	je	.L1257
	cmpq	$1, %r12
	ja	.L1260
	testq	%r11, %r11
	je	.L1257
.L1260:
	movq	%r15, %rcx
	movq	%r15, %rdx
	leaq	.LC189(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1254
.L1376:
	movq	%rbx, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC202(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1288
.L1378:
	movq	24(%r12), %rdi
	testq	%rdi, %rdi
	je	.L1232
	movq	$0, 40(%rsp)
	leaq	40(%rsp), %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1232
	movq	40(%rsp), %rax
	xorl	%edx, %edx
	testq	%rax, %rax
	cmovs	%rdx, %rax
	leaq	1(%rax), %rcx
	jmp	.L1249
.L1234:
	movq	24(%r15), %rcx
	testl	%eax, %eax
	jne	.L1236
	movq	24(%r12), %rdi
	testq	%rdi, %rdi
	je	.L1236
	leaq	40(%rsp), %rsi
	movq	%rcx, 16(%rsp)
	movq	$0, 40(%rsp)
	call	try_eval_const_expr
	movq	16(%rsp), %rcx
	testl	%eax, %eax
	je	.L1246
	movq	40(%rsp), %rsi
	testq	%rcx, %rcx
	movl	$1, %edx
	cmovne	%rcx, %rdx
	leaq	1(%rsi), %rax
	cmpq	%rax, %rcx
	cmovnb	%rcx, %rax
	testq	%rsi, %rsi
	movq	%rdx, %rcx
	cmovns	%rax, %rcx
	jmp	.L1248
.L1379:
	movq	16(%rdi), %rax
	movq	(%rax), %rax
	movl	(%rax), %r11d
	testl	%r11d, %r11d
	jne	.L1259
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L1259
	cmpl	$1, (%rax)
	je	.L1380
.L1259:
	call	edge_tail_words_top
	leaq	48(%rsp), %rdi
	movq	%r15, %rcx
	leaq	.LC204(%rip), %rdx
	movl	$256, %esi
	movq	%rax, %r12
	xorl	%eax, %eax
	call	snprintf@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 392
	movq	48(%r13), %rcx
	xorl	%edx, %edx
	pushq	16(%rsp)
	.cfi_def_cfa_offset 400
	movl	$2, %r9d
	movl	$1, %r8d
	movq	%rbx, %rdi
	leaq	64(%rsp), %rsi
	call	emit_edge_list_init
	popq	%rax
	.cfi_def_cfa_offset 392
	popq	%rdx
	.cfi_def_cfa_offset 384
	testq	%r12, %r12
	jne	.L1260
	jmp	.L1257
	.p2align 4,,10
	.p2align 3
.L1261:
	testq	%rcx, %rcx
	movl	$1, %r12d
	cmovne	%rcx, %r12
	jmp	.L1264
.L1236:
	testq	%rcx, %rcx
	movl	$1, %eax
	cmove	%rax, %rcx
	jmp	.L1241
.L1246:
	testq	%rcx, %rcx
	jne	.L1248
	movl	$1, %ecx
	jmp	.L1241
	.p2align 4,,10
	.p2align 3
.L1380:
	movq	%r15, %rdx
	leaq	.LC187(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r13), %rax
	movq	16(%rax), %rax
	movq	(%rax), %rax
	jmp	.L1366
.L1367:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE49:
	.size	emit_program_c, .-emit_program_c
	.section	.rodata.str1.8
	.align 8
.LC205:
	.string	"/* Generated by BCC - B Compiler */\n"
	.section	.rodata.str1.1
.LC206:
	.string	"#include \"libb.h\"\n\n"
.LC207:
	.string	"#include <ncurses.h>\n"
.LC208:
	.string	"#include <panel.h>\n\n"
	.section	.rodata.str1.8
	.align 8
.LC209:
	.string	"\nstatic void __b_init_file_%p(void) {\n"
	.section	.rodata.str1.1
.LC210:
	.string	"    __b_init_file_%p();\n"
	.section	.rodata.str1.8
	.align 8
.LC211:
	.string	"    word *__b_argvb_ptr = (word*)B_CPTR(b_argv(0));\n"
	.align 8
.LC212:
	.string	"    return (int)__b_user_main((word)argc, B_PTR(__b_argvb_ptr - 1));\n"
	.align 8
.LC213:
	.string	"void __b_init_file_%p_export(void) __attribute__((constructor));\n"
	.align 8
.LC214:
	.string	"void __b_init_file_%p_export(void) { __b_init_file_%p(); }\n"
	.text
	.p2align 4
	.globl	emit_program_c_ext
	.type	emit_program_c_ext, @function
emit_program_c_ext:
.LFB50:
	.cfi_startproc
	subq	$376, %rsp
	.cfi_def_cfa_offset 384
	movq	%rbx, 328(%rsp)
	movl	384(%rsp), %eax
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	movq	%r12, 344(%rsp)
	.cfi_offset 12, -40
	movl	%ecx, %r12d
	movq	%r13, 352(%rsp)
	.cfi_offset 13, -32
	movq	%rsi, %r13
	movq	%rbp, 336(%rsp)
	movq	%rdx, 8(%rsp)
	.cfi_offset 6, -48
	movq	%fs:40, %rbp
	movq	%rbp, 312(%rsp)
	movl	%r9d, %ebp
	testl	%eax, %eax
	je	.L1532
	pxor	%xmm0, %xmm0
	movq	%rsi, %rdi
	movl	%ecx, current_byteptr(%rip)
	movups	%xmm0, 8+string_pool(%rip)
	movq	%r14, 360(%rsp)
	movq	%r15, 368(%rsp)
	movl	%ebp, current_word_bits(%rip)
	movq	$0, string_pool(%rip)
	movq	$0, 8+name_map(%rip)
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	call	collect_strings_program
	movq	%rbx, %rcx
	movl	$36, %edx
	movl	$1, %esi
	leaq	.LC205(%rip), %rdi
	call	fwrite@PLT
	xorl	%edx, %edx
	testl	%r12d, %r12d
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
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC206(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$21, %edx
	movl	$1, %esi
	leaq	.LC207(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$20, %edx
	movl	$1, %esi
	leaq	.LC208(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1533
.L1384:
	cmpq	$0, 8(%r13)
	je	.L1385
	xorl	%ebp, %ebp
	jmp	.L1415
	.p2align 4,,10
	.p2align 3
.L1386:
	cmpl	$3, %eax
	je	.L1534
	cmpl	$2, %eax
	je	.L1535
.L1387:
	addq	$1, %rbp
	cmpq	8(%r13), %rbp
	jnb	.L1385
.L1415:
	movq	0(%r13), %rax
	movq	(%rax,%rbp,8), %rdx
	movl	(%rdx), %eax
	testl	%eax, %eax
	jne	.L1386
	movq	8(%rdx), %rsi
	movq	8(%rsp), %r8
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbx, %rdi
	addq	$1, %rbp
	call	emit_stmt
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	8(%r13), %rbp
	jb	.L1415
	.p2align 4
	.p2align 3
.L1385:
	xorl	%eax, %eax
	movq	%r13, %rdx
	leaq	.LC209(%rip), %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	cmpq	$0, 8(%r13)
	je	.L1416
	xorl	%ebp, %ebp
	jmp	.L1428
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1417:
	addq	$1, %rbp
	cmpq	8(%r13), %rbp
	jnb	.L1416
.L1428:
	movq	0(%r13), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$2, (%rax)
	jne	.L1417
	movq	8(%rax), %r14
	movq	8(%r14), %rdi
	call	get_mangled_name
	movq	%rax, %r15
	movl	16(%r14), %eax
	testl	%eax, %eax
	jne	.L1418
	movq	48(%r14), %rax
	testq	%rax, %rax
	je	.L1417
	movl	(%rax), %r12d
	testl	%r12d, %r12d
	jne	.L1417
	movq	%r15, %rdx
	leaq	.LC187(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r14), %rax
.L1530:
	movq	16(%rax), %rsi
	movq	8(%rsp), %rdx
	movq	%rbx, %rdi
	addq	$1, %rbp
	call	emit_ival_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC141(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r13), %rbp
	jb	.L1428
	.p2align 4
	.p2align 3
.L1416:
	movl	$1, %esi
	leaq	.LC192(%rip), %rdi
	movq	%rbx, %rcx
	movl	$3, %edx
	call	fwrite@PLT
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_known_external_function_prototypes
	cmpq	$0, 8(%r13)
	je	.L1429
	xorl	%ebp, %ebp
	jmp	.L1438
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1430:
	addq	$1, %rbp
	cmpq	8(%r13), %rbp
	jnb	.L1429
.L1438:
	movq	0(%r13), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$1, (%rax)
	jne	.L1430
	movq	8(%rax), %r12
	leaq	.LC65(%rip), %rsi
	movq	(%r12), %r14
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1431
	leaq	.LC66(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1432
.L1431:
	movq	%rbx, %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC193(%rip), %rdi
	call	fwrite@PLT
.L1433:
	xorl	%r14d, %r14d
	cmpq	$0, 16(%r12)
	je	.L1436
.L1435:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	addq	$1, %r14
	leaq	.LC195(%rip), %rdi
	call	fwrite@PLT
	cmpq	16(%r12), %r14
	jnb	.L1436
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC99(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1435
	.p2align 4,,10
	.p2align 3
.L1535:
	movq	8(%rdx), %r12
	movq	8(%r12), %rdi
	call	get_mangled_name
	movq	%rax, %r14
	movl	16(%r12), %eax
	cmpl	$1, %eax
	jne	.L1390
	movq	48(%r12), %rdi
	testq	%rdi, %rdi
	je	.L1391
	cmpl	$1, (%rdi)
	jne	.L1391
	movq	24(%rdi), %r12
	cmpq	$1, %r12
	jne	.L1392
	movq	16(%rdi), %rax
	movq	(%rax), %rax
	movl	(%rax), %r15d
	testl	%r15d, %r15d
	jne	.L1392
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L1392
	cmpl	$1, (%rax)
	je	.L1529
.L1392:
	call	edge_tail_words_top
	leaq	(%r12,%rax), %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	jmp	.L1457
	.p2align 4,,10
	.p2align 3
.L1436:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	addq	$1, %rbp
	leaq	.LC196(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r13), %rbp
	jb	.L1438
	.p2align 4
	.p2align 3
.L1429:
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	$0, 8(%r13)
	je	.L1439
	movq	$0, 16(%rsp)
	xorl	%r15d, %r15d
	movl	$0, 24(%rsp)
	.p2align 5
	.p2align 4
	.p2align 3
.L1449:
	movq	0(%r13), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$1, (%rax)
	je	.L1536
.L1440:
	addq	$1, %r15
	cmpq	8(%r13), %r15
	jb	.L1449
	movl	24(%rsp), %edi
	testl	%edi, %edi
	je	.L1439
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC198(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC199(%rip), %rdi
	call	fwrite@PLT
	movl	$16, %edx
	movl	$1, %esi
	movq	%rbx, %rcx
	leaq	.LC200(%rip), %rdi
	call	fwrite@PLT
	xorl	%eax, %eax
	movq	%r13, %rdx
	movq	%rbx, %rdi
	leaq	.LC210(%rip), %rsi
	call	fprintf@PLT
	cmpq	$0, 16(%rsp)
	je	.L1453
	cmpq	$1, 16(%rsp)
	je	.L1537
	cmpq	$2, 16(%rsp)
	jne	.L1453
	movq	%rbx, %rcx
	movl	$52, %edx
	movl	$1, %esi
	leaq	.LC211(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC212(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1451
	.p2align 4,,10
	.p2align 3
.L1418:
	cmpl	$1, %eax
	je	.L1538
	cmpl	$2, %eax
	jne	.L1417
	movq	%r15, %rcx
	movq	%r15, %rdx
	leaq	.LC190(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r14), %rax
	testq	%rax, %rax
	je	.L1417
	cmpl	$1, (%rax)
	jne	.L1417
	movl	32(%r14), %r10d
	movq	24(%rax), %rcx
	testl	%r10d, %r10d
	jne	.L1424
	movq	24(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1424
	leaq	40(%rsp), %rsi
	movq	%rcx, 16(%rsp)
	movl	$1, %r12d
	movq	$0, 40(%rsp)
	call	try_eval_const_expr
	movq	16(%rsp), %rcx
	testq	%rcx, %rcx
	cmovne	%rcx, %r12
	testl	%eax, %eax
	je	.L1427
	movq	40(%rsp), %rax
	xorl	%edx, %edx
	testq	%rax, %rax
	cmovns	%rax, %rdx
	movq	%rdx, %r12
	addq	$1, %r12
	cmpq	%rcx, %r12
	cmovb	%rcx, %r12
.L1427:
	leaq	48(%rsp), %rdi
	movq	%r15, %rcx
	movl	$256, %esi
	leaq	.LC191(%rip), %rdx
	xorl	%eax, %eax
	call	snprintf@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 392
	movq	48(%r14), %rcx
	movq	%r12, %r8
	pushq	16(%rsp)
	.cfi_def_cfa_offset 400
	movl	$2, %r9d
	xorl	%edx, %edx
	movq	%rbx, %rdi
	leaq	64(%rsp), %rsi
	call	emit_edge_list_init
	popq	%r8
	.cfi_def_cfa_offset 392
	popq	%r9
	.cfi_def_cfa_offset 384
	jmp	.L1417
	.p2align 4,,10
	.p2align 3
.L1390:
	cmpl	$2, %eax
	je	.L1539
	movq	%r14, %rdx
	movl	4(%r12), %r14d
	testl	%r14d, %r14d
	je	.L1414
	leaq	.LC184(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1387
	.p2align 4,,10
	.p2align 3
.L1439:
	xorl	%eax, %eax
	movq	%r13, %rdx
	leaq	.LC213(%rip), %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	movq	312(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1531
	movq	360(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	movq	%r13, %rcx
	movq	%r13, %rdx
	xorl	%eax, %eax
	movq	368(%rsp), %r15
	.cfi_restore 15
	movq	336(%rsp), %rbp
	movq	%rbx, %rdi
	leaq	.LC214(%rip), %rsi
	movq	328(%rsp), %rbx
	movq	344(%rsp), %r12
	movq	352(%rsp), %r13
	addq	$376, %rsp
	.cfi_def_cfa_offset 8
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L1533:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1384
	.p2align 4,,10
	.p2align 3
.L1538:
	movq	48(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1420
	cmpl	$1, (%rdi)
	je	.L1540
.L1420:
	movq	%r15, %rcx
	movq	%r15, %rdx
	leaq	.LC188(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1417
	.p2align 4,,10
	.p2align 3
.L1391:
	movl	$1, %ecx
.L1457:
	movq	%r14, %rdx
	leaq	.LC182(%rip), %rsi
.L1528:
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L1529:
	movq	%r14, %rdx
	leaq	.LC154(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1387
	.p2align 4,,10
	.p2align 3
.L1534:
	movq	8(%rdx), %r12
	leaq	.LC67(%rip), %rdi
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r12), %rdi
	testq	%rdi, %rdi
	je	.L1389
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1389:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC141(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1387
	.p2align 4,,10
	.p2align 3
.L1536:
	movq	8(%rax), %r12
	leaq	.LC65(%rip), %rsi
	movq	(%r12), %rbp
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L1441
	leaq	.LC66(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1442
.L1441:
	movq	16(%r12), %rax
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC197(%rip), %rdi
	movq	%rax, 16(%rsp)
	call	fwrite@PLT
	movl	$1, 24(%rsp)
.L1443:
	xorl	%ebp, %ebp
	leaq	.LC194(%rip), %r14
	cmpq	$0, 16(%r12)
	je	.L1446
.L1445:
	movq	%r14, %rdi
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r12), %rax
	movq	(%rax,%rbp,8), %rdi
	testq	%rdi, %rdi
	je	.L1447
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1447:
	addq	$1, %rbp
	cmpq	16(%r12), %rbp
	jnb	.L1446
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC99(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1445
	.p2align 4,,10
	.p2align 3
.L1446:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC158(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r12), %rsi
	movq	%rbx, %rdi
	xorl	%edx, %edx
	movq	8(%rsp), %r8
	movl	$1, %ecx
	call	emit_stmt
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1440
	.p2align 4,,10
	.p2align 3
.L1532:
	.cfi_restore 14
	.cfi_restore 15
	movq	312(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1541
	movq	8(%rsp), %rdx
	movq	328(%rsp), %rbx
	movl	%ebp, %r9d
	movq	344(%rsp), %r12
	movq	336(%rsp), %rbp
	movq	352(%rsp), %r13
	addq	$376, %rsp
	.cfi_def_cfa_offset 8
	jmp	emit_program_c
	.p2align 4,,10
	.p2align 3
.L1453:
	.cfi_def_cfa_offset 384
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC201(%rip), %rdi
	call	fwrite@PLT
.L1451:
	movq	312(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1531
	movq	360(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	movq	368(%rsp), %r15
	.cfi_restore 15
	movq	%rbx, %rcx
	movl	$2, %edx
	movq	328(%rsp), %rbx
	movq	336(%rsp), %rbp
	movl	$1, %esi
	leaq	.LC151(%rip), %rdi
	movq	344(%rsp), %r12
	movq	352(%rsp), %r13
	addq	$376, %rsp
	.cfi_def_cfa_offset 8
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L1432:
	.cfi_restore_state
	leaq	.LC194(%rip), %r14
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movq	(%r12), %rdi
	testq	%rdi, %rdi
	je	.L1434
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1434:
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1433
	.p2align 4,,10
	.p2align 3
.L1414:
	leaq	.LC154(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1387
.L1540:
	movq	24(%rdi), %r12
	cmpq	$1, %r12
	je	.L1542
	call	edge_tail_words_top
	leaq	48(%rsp), %rdi
	movq	%r15, %rcx
	leaq	.LC204(%rip), %rdx
	movq	%rax, %r11
	leaq	(%r12,%rax), %rax
	movl	$256, %esi
	movq	%rax, 16(%rsp)
	xorl	%eax, %eax
	movq	%r11, 24(%rsp)
	call	snprintf@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 392
	movq	48(%r14), %rcx
	xorl	%edx, %edx
	pushq	16(%rsp)
	.cfi_def_cfa_offset 400
	movl	$2, %r9d
	movq	%r12, %r8
	movq	%rbx, %rdi
	leaq	64(%rsp), %rsi
	call	emit_edge_list_init
	popq	%rcx
	.cfi_def_cfa_offset 392
	popq	%rsi
	.cfi_def_cfa_offset 384
	cmpq	$1, 16(%rsp)
	movq	24(%rsp), %r11
	je	.L1420
	cmpq	$1, %r12
	ja	.L1423
	testq	%r11, %r11
	je	.L1420
.L1423:
	movq	%r15, %rcx
	movq	%r15, %rdx
	leaq	.LC189(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1417
	.p2align 4,,10
	.p2align 3
.L1539:
	movq	48(%r12), %r15
	movl	32(%r12), %eax
	testq	%r15, %r15
	je	.L1543
	cmpl	$1, (%r15)
	je	.L1397
	testl	%eax, %eax
	jne	.L1395
	movq	24(%r12), %rdi
	testq	%rdi, %rdi
	je	.L1395
	movq	$0, 40(%rsp)
	leaq	40(%rsp), %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1395
	movq	40(%rsp), %rax
	leaq	1(%rax), %rcx
	testq	%rax, %rax
	movl	$1, %eax
	cmovs	%rax, %rcx
.L1411:
	cmpl	$1, (%r15)
	jne	.L1412
.L1404:
	movq	%r15, %rdi
	movq	%rcx, 16(%rsp)
	call	edge_tail_words_top
	movq	16(%rsp), %rcx
	addq	%rax, %rcx
	movl	$1, %eax
	cmove	%rax, %rcx
	jmp	.L1412
	.p2align 4,,10
	.p2align 3
.L1395:
	movl	$1, %ecx
.L1412:
	movq	%r14, %rdx
	leaq	.LC183(%rip), %rsi
	jmp	.L1528
	.p2align 4,,10
	.p2align 3
.L1442:
	leaq	.LC194(%rip), %r14
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movq	(%r12), %rdi
	testq	%rdi, %rdi
	je	.L1444
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1444:
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1443
.L1537:
	movq	%rbx, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC202(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1451
.L1543:
	testl	%eax, %eax
	jne	.L1395
	movq	24(%r12), %rdi
	testq	%rdi, %rdi
	je	.L1395
	movq	$0, 40(%rsp)
	leaq	40(%rsp), %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1395
	movq	40(%rsp), %rax
	xorl	%edx, %edx
	testq	%rax, %rax
	cmovs	%rdx, %rax
	leaq	1(%rax), %rcx
	jmp	.L1412
.L1397:
	movq	24(%r15), %rcx
	testl	%eax, %eax
	jne	.L1399
	movq	24(%r12), %rdi
	testq	%rdi, %rdi
	je	.L1399
	leaq	40(%rsp), %rsi
	movq	%rcx, 16(%rsp)
	movq	$0, 40(%rsp)
	call	try_eval_const_expr
	movq	16(%rsp), %rcx
	testl	%eax, %eax
	je	.L1409
	movq	40(%rsp), %rsi
	testq	%rcx, %rcx
	movl	$1, %edx
	cmovne	%rcx, %rdx
	leaq	1(%rsi), %rax
	cmpq	%rax, %rcx
	cmovnb	%rcx, %rax
	testq	%rsi, %rsi
	movq	%rdx, %rcx
	cmovns	%rax, %rcx
	jmp	.L1411
.L1542:
	movq	16(%rdi), %rax
	movq	(%rax), %rax
	movl	(%rax), %r11d
	testl	%r11d, %r11d
	jne	.L1422
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L1422
	cmpl	$1, (%rax)
	je	.L1544
.L1422:
	call	edge_tail_words_top
	leaq	48(%rsp), %rdi
	movq	%r15, %rcx
	leaq	.LC204(%rip), %rdx
	movl	$256, %esi
	movq	%rax, %r12
	xorl	%eax, %eax
	call	snprintf@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 392
	movq	48(%r14), %rcx
	xorl	%edx, %edx
	pushq	16(%rsp)
	.cfi_def_cfa_offset 400
	movl	$2, %r9d
	movl	$1, %r8d
	movq	%rbx, %rdi
	leaq	64(%rsp), %rsi
	call	emit_edge_list_init
	popq	%rax
	.cfi_def_cfa_offset 392
	popq	%rdx
	.cfi_def_cfa_offset 384
	testq	%r12, %r12
	jne	.L1423
	jmp	.L1420
	.p2align 4,,10
	.p2align 3
.L1424:
	testq	%rcx, %rcx
	movl	$1, %r12d
	cmovne	%rcx, %r12
	jmp	.L1427
.L1399:
	testq	%rcx, %rcx
	movl	$1, %eax
	cmove	%rax, %rcx
	jmp	.L1404
.L1409:
	testq	%rcx, %rcx
	jne	.L1411
	movl	$1, %ecx
	jmp	.L1404
	.p2align 4,,10
	.p2align 3
.L1544:
	movq	%r15, %rdx
	leaq	.LC187(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	48(%r14), %rax
	movq	16(%rax), %rax
	movq	(%rax), %rax
	jmp	.L1530
.L1541:
	.cfi_restore 14
	.cfi_restore 15
	movq	%r14, 360(%rsp)
	movq	%r15, 368(%rsp)
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	call	__stack_chk_fail@PLT
.L1531:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE50:
	.size	emit_program_c_ext, .-emit_program_c_ext
	.section	.rodata.str1.8
	.align 8
.LC215:
	.string	"# B compiler - generated assembly\n"
	.section	.rodata.str1.1
.LC216:
	.string	".intel_syntax noprefix\n"
.LC217:
	.string	".data\n"
.LC218:
	.string	".text\n"
.LC219:
	.string	".global main\n"
.LC220:
	.string	"main:\n"
.LC221:
	.string	":\n"
.LC222:
	.string	"    push rbp\n"
.LC223:
	.string	"    mov rbp, rsp\n"
.LC224:
	.string	"    sub rsp, 8\n"
.LC225:
	.string	"    mov rax, %ld\n"
.LC226:
	.string	"    leave\n"
.LC227:
	.string	"    ret\n"
	.text
	.p2align 4
	.globl	emit_program_asm
	.type	emit_program_asm, @function
emit_program_asm:
.LFB52:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rdi, %rcx
	movl	$34, %edx
	movq	%rbp, 8(%rsp)
	.cfi_offset 6, -40
	movq	%rdi, %rbp
	leaq	.LC215(%rip), %rdi
	movq	%r12, 16(%rsp)
	.cfi_offset 12, -32
	movq	%rsi, %r12
	movl	$1, %esi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$23, %edx
	movl	$1, %esi
	leaq	.LC216(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC217(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC218(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC219(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%r12)
	je	.L1545
	movq	%rbx, (%rsp)
	.cfi_offset 3, -48
	xorl	%ebx, %ebx
	movq	%r13, 24(%rsp)
	movq	%r14, 32(%rsp)
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	jmp	.L1553
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1547:
	addq	$1, %rbx
	cmpq	8(%r12), %rbx
	jnb	.L1566
.L1553:
	movq	(%r12), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$1, (%rax)
	jne	.L1547
	movq	8(%rax), %r13
	leaq	.LC65(%rip), %rsi
	movq	0(%r13), %r14
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1548
	movq	%rbp, %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC220(%rip), %rdi
	call	fwrite@PLT
.L1549:
	movq	%rbp, %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC222(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC223(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$15, %edx
	movl	$1, %esi
	leaq	.LC224(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r13), %rax
	testq	%rax, %rax
	je	.L1550
	cmpl	$1, (%rax)
	je	.L1567
.L1550:
	movq	%rbp, %rcx
	movl	$10, %edx
	movl	$1, %esi
	addq	$1, %rbx
	leaq	.LC226(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC227(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	8(%r12), %rbx
	jb	.L1553
.L1566:
	movq	(%rsp), %rbx
	.cfi_restore 3
	movq	24(%rsp), %r13
	.cfi_restore 13
	movq	32(%rsp), %r14
	.cfi_restore 14
.L1545:
	movq	8(%rsp), %rbp
	movq	16(%rsp), %r12
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1548:
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	movq	%r14, %rdi
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC221(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1549
	.p2align 4,,10
	.p2align 3
.L1567:
	movq	24(%rax), %rcx
	testq	%rcx, %rcx
	je	.L1550
	movq	16(%rax), %rsi
	xorl	%eax, %eax
	jmp	.L1552
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1551:
	addq	$1, %rax
	cmpq	%rcx, %rax
	je	.L1550
.L1552:
	movq	(%rsi,%rax,8), %rdx
	cmpl	$5, (%rdx)
	jne	.L1551
	movq	16(%rdx), %rdx
	testq	%rdx, %rdx
	je	.L1551
	movq	16(%rdx), %rdx
	leaq	.LC225(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1550
	.cfi_endproc
.LFE52:
	.size	emit_program_asm, .-emit_program_asm
	.section	.rodata.cst32,"aM",@progbits,32
	.align 16
	.type	CSWTCH.111, @object
	.size	CSWTCH.111, 24
CSWTCH.111:
	.long	24
	.long	25
	.long	26
	.long	27
	.long	22
	.long	23
	.zero	8
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
	.local	current_word_bits
	.comm	current_word_bits,4,4
	.local	current_byteptr
	.comm	current_byteptr,4,4
	.section	.rodata.str1.1
.LC228:
	.string	"break"
.LC229:
	.string	"case"
.LC230:
	.string	"const"
.LC231:
	.string	"continue"
.LC232:
	.string	"default"
.LC233:
	.string	"do"
.LC234:
	.string	"double"
.LC235:
	.string	"else"
.LC236:
	.string	"enum"
.LC237:
	.string	"extern"
.LC238:
	.string	"float"
.LC239:
	.string	"for"
.LC240:
	.string	"goto"
.LC241:
	.string	"if"
.LC242:
	.string	"inline"
.LC243:
	.string	"int"
.LC244:
	.string	"long"
.LC245:
	.string	"register"
.LC246:
	.string	"restrict"
.LC247:
	.string	"return"
.LC248:
	.string	"short"
.LC249:
	.string	"signed"
.LC250:
	.string	"sizeof"
.LC251:
	.string	"static"
.LC252:
	.string	"struct"
.LC253:
	.string	"switch"
.LC254:
	.string	"typedef"
.LC255:
	.string	"union"
.LC256:
	.string	"unsigned"
.LC257:
	.string	"void"
.LC258:
	.string	"volatile"
.LC259:
	.string	"while"
.LC260:
	.string	"_Bool"
.LC261:
	.string	"_Complex"
.LC262:
	.string	"_Imaginary"
.LC263:
	.string	"_Alignas"
.LC264:
	.string	"_Alignof"
.LC265:
	.string	"_Atomic"
.LC266:
	.string	"_Generic"
.LC267:
	.string	"_Noreturn"
.LC268:
	.string	"_Static_assert"
.LC269:
	.string	"_Thread_local"
.LC270:
	.string	"NULL"
.LC271:
	.string	"true"
.LC272:
	.string	"false"
.LC273:
	.string	"bool"
.LC274:
	.string	"B_PTR"
.LC275:
	.string	"B_ADDR"
.LC276:
	.string	"B_DEREF"
	.section	.data.rel.ro.local,"aw"
	.align 32
	.type	c_keywords, @object
	.size	c_keywords, 424
c_keywords:
	.quad	.LC59
	.quad	.LC228
	.quad	.LC229
	.quad	.LC0
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
	.quad	.LC195
	.quad	.LC274
	.quad	.LC275
	.quad	.LC276
	.quad	0
	.local	name_map
	.comm	name_map,24,16
	.local	string_pool
	.comm	string_pool,24,16
	.ident	"GCC: (GNU) 16.1.1 20260430"
	.section	.note.GNU-stack,"",@progbits
