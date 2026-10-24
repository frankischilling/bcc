	.file	"lexer.c"
	.text
	.p2align 4
	.type	lx_get, @function
lx_get:
.LFB16:
	.cfi_startproc
	movq	16(%rdi), %rax
	xorl	%edx, %edx
	cmpq	8(%rdi), %rax
	jnb	.L1
	movq	(%rdi), %rdx
	movzbl	(%rdx,%rax), %edx
	testl	%edx, %edx
	je	.L1
	addq	$1, %rax
	movq	%rax, 16(%rdi)
	cmpl	$10, %edx
	je	.L9
	addl	$1, 28(%rdi)
.L1:
	movl	%edx, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L9:
	addl	$1, 24(%rdi)
	movl	%edx, %eax
	movl	$1, 28(%rdi)
	ret
	.cfi_endproc
.LFE16:
	.size	lx_get, .-lx_get
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"unterminated escape sequence"
.LC1:
	.string	"unknown escape sequence *%c"
	.text
	.p2align 4
	.type	parse_escape, @function
parse_escape:
.LFB17:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movl	%edx, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movl	%esi, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %rbx
	subq	$64, %rsp
	.cfi_def_cfa_offset 112
	movq	16(%rdi), %rdx
	cmpq	8(%rdi), %rdx
	jnb	.L11
	movq	(%rdi), %rax
	movzbl	(%rax,%rdx), %ebp
	movl	%ebp, %eax
	testl	%ebp, %ebp
	je	.L11
	addq	$1, %rdx
	movq	%rdx, 16(%rdi)
	cmpl	$10, %ebp
	je	.L30
	addl	$1, 28(%rdi)
	cmpb	$48, %bpl
	jg	.L14
	cmpb	$33, %bpl
	jle	.L13
	subl	$34, %eax
	cmpb	$14, %al
	ja	.L13
	leaq	.L16(%rip), %rdx
	movzbl	%al, %eax
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L16:
	.long	.L21-.L16
	.long	.L13-.L16
	.long	.L13-.L16
	.long	.L13-.L16
	.long	.L13-.L16
	.long	.L20-.L16
	.long	.L19-.L16
	.long	.L18-.L16
	.long	.L17-.L16
	.long	.L13-.L16
	.long	.L13-.L16
	.long	.L13-.L16
	.long	.L13-.L16
	.long	.L13-.L16
	.long	.L22-.L16
	.text
	.p2align 4,,10
	.p2align 3
.L11:
	movq	32(%rbx), %rdi
	leaq	.LC0(%rip), %r8
	movl	%r13d, %edx
	xorl	%ebp, %ebp
	movl	$8, %ecx
	movl	%r12d, %esi
	call	error_at_location@PLT
.L13:
	movl	%ebp, %ecx
	leaq	.LC1(%rip), %rdx
	movl	$64, %esi
	xorl	%eax, %eax
	movq	%rsp, %rdi
	call	snprintf@PLT
	movq	32(%rbx), %rdi
	movq	%rsp, %r8
	movl	%r13d, %edx
	movl	$8, %ecx
	movl	%r12d, %esi
	call	error_at_location@PLT
.L10:
	addq	$64, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movl	%ebp, %eax
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
.L17:
	.cfi_restore_state
	addq	$64, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movl	$42, %ebp
	popq	%rbx
	.cfi_def_cfa_offset 40
	movl	%ebp, %eax
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
.L18:
	.cfi_restore_state
	addq	$64, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movl	$125, %ebp
	popq	%rbx
	.cfi_def_cfa_offset 40
	movl	%ebp, %eax
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
.L20:
	.cfi_restore_state
	addq	$64, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movl	$39, %ebp
	popq	%rbx
	.cfi_def_cfa_offset 40
	movl	%ebp, %eax
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
.L21:
	.cfi_restore_state
	addq	$64, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movl	$34, %ebp
	popq	%rbx
	.cfi_def_cfa_offset 40
	movl	%ebp, %eax
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
.L14:
	.cfi_restore_state
	cmpb	$110, %bpl
	je	.L23
	cmpb	$116, %bpl
	je	.L24
	cmpb	$101, %bpl
	jne	.L13
	movl	$4, %ebp
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L30:
	addl	$1, 24(%rdi)
	movl	$1, 28(%rdi)
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L24:
	movl	$9, %ebp
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L23:
	movl	$10, %ebp
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L22:
	xorl	%ebp, %ebp
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L19:
	movl	$123, %ebp
	jmp	.L10
	.cfi_endproc
.LFE17:
	.size	parse_escape, .-parse_escape
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC2:
	.string	"backslash escapes are not allowed in strict B mode (use *-escapes or omit --strict)"
	.section	.rodata.str1.1
.LC3:
	.string	"unknown escape sequence \\%c"
	.text
	.p2align 4
	.type	parse_backslash_escape, @function
parse_backslash_escape:
.LFB18:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movl	%esi, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movl	%edx, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %rbx
	subq	$64, %rsp
	.cfi_def_cfa_offset 112
	testb	$4, g_extensions(%rip)
	je	.L50
	movq	16(%rdi), %rax
	cmpq	8(%rdi), %rax
	jnb	.L34
	movq	(%rdi), %rdx
	movzbl	(%rdx,%rax), %ebp
	testl	%ebp, %ebp
	je	.L34
	addq	$1, %rax
	movq	%rax, 16(%rdi)
	cmpl	$10, %ebp
	je	.L51
	addl	$1, 28(%rdi)
	cmpb	$92, %bpl
	je	.L33
	jle	.L52
	cmpb	$114, %bpl
	je	.L43
	cmpb	$116, %bpl
	je	.L44
	cmpb	$110, %bpl
	jne	.L36
	movl	$10, %ebp
	jmp	.L31
	.p2align 4,,10
	.p2align 3
.L34:
	movq	32(%rbx), %rdi
	leaq	.LC0(%rip), %r8
	movl	%r12d, %edx
	xorl	%ebp, %ebp
	movl	$8, %ecx
	movl	%r13d, %esi
	call	error_at_location@PLT
.L36:
	movl	%ebp, %ecx
	leaq	.LC3(%rip), %rdx
	movl	$64, %esi
	xorl	%eax, %eax
	movq	%rsp, %rdi
	call	snprintf@PLT
	movq	32(%rbx), %rdi
	movq	%rsp, %r8
	movl	%r12d, %edx
	movl	$8, %ecx
	movl	%r13d, %esi
	call	error_at_location@PLT
.L31:
	addq	$64, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movl	%ebp, %eax
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
.L50:
	.cfi_restore_state
	movl	g_pedantic(%rip), %eax
	testl	%eax, %eax
	jne	.L53
.L33:
	addq	$64, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movl	$92, %ebp
	popq	%rbx
	.cfi_def_cfa_offset 40
	movl	%ebp, %eax
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
.L52:
	.cfi_restore_state
	cmpb	$39, %bpl
	je	.L40
	cmpb	$48, %bpl
	je	.L41
	cmpb	$34, %bpl
	jne	.L36
	movl	$34, %ebp
	jmp	.L31
	.p2align 4,,10
	.p2align 3
.L51:
	addl	$1, 24(%rdi)
	movl	$1, 28(%rdi)
	jmp	.L36
	.p2align 4,,10
	.p2align 3
.L53:
	movq	32(%rdi), %rdi
	leaq	.LC2(%rip), %r8
	movl	$8, %ecx
	call	error_at_location@PLT
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L41:
	xorl	%ebp, %ebp
	jmp	.L31
	.p2align 4,,10
	.p2align 3
.L40:
	movl	$39, %ebp
	jmp	.L31
	.p2align 4,,10
	.p2align 3
.L44:
	movl	$9, %ebp
	jmp	.L31
	.p2align 4,,10
	.p2align 3
.L43:
	movl	$13, %ebp
	jmp	.L31
	.cfi_endproc
.LFE18:
	.size	parse_backslash_escape, .-parse_backslash_escape
	.section	.rodata.str1.1
.LC4:
	.string	"unterminated /* comment"
	.section	.rodata.str1.8
	.align 8
.LC5:
	.string	"// comments are not allowed in strict B mode (use /* */ or omit --strict)"
	.text
	.p2align 4
	.globl	lx_skip_ws_and_comments
	.type	lx_skip_ws_and_comments, @function
lx_skip_ws_and_comments:
.LFB19:
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
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	movq	8(%rdi), %rbp
	movq	16(%rdi), %rax
.L55:
	cmpq	%rbp, %rax
	jnb	.L54
	movq	(%rbx), %r13
	movzbl	0(%r13,%rax), %r12d
	testl	%r12d, %r12d
	je	.L54
	call	__ctype_b_loc@PLT
	movq	(%rax), %rsi
	.p2align 4
	.p2align 3
.L58:
	movslq	%r12d, %rax
	testb	$32, 1(%rsi,%rax,2)
	je	.L125
	movq	16(%rbx), %rax
	cmpq	%rbp, %rax
	jnb	.L54
	movzbl	0(%r13,%rax), %edx
	testl	%edx, %edx
	je	.L54
	leaq	1(%rax), %rcx
	movq	%rcx, 16(%rbx)
	cmpl	$10, %edx
	je	.L126
	movl	28(%rbx), %edi
	leal	1(%rdi), %edx
.L61:
	movl	%edx, 28(%rbx)
	cmpq	%rbp, %rcx
	jnb	.L54
	movzbl	1(%r13,%rax), %r12d
	testl	%r12d, %r12d
	jne	.L58
.L54:
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
.L126:
	.cfi_restore_state
	addl	$1, 24(%rbx)
	movl	$1, %edx
	jmp	.L61
	.p2align 4,,10
	.p2align 3
.L125:
	cmpl	$47, %r12d
	jne	.L54
	movq	16(%rbx), %rax
	leaq	1(%rax), %rdx
	cmpq	%rbp, %rdx
	jnb	.L54
	leaq	0(%r13,%rdx), %rsi
	movzbl	(%rsi), %ecx
	cmpb	$42, %cl
	je	.L127
	cmpb	$47, %cl
	jne	.L54
	testb	$2, g_extensions(%rip)
	jne	.L84
	movl	g_pedantic(%rip), %eax
	testl	%eax, %eax
	je	.L54
	movl	28(%rbx), %edx
	movl	24(%rbx), %esi
	leaq	.LC5(%rip), %r8
	movl	$8, %ecx
	movq	32(%rbx), %rdi
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
	jmp	error_at_location@PLT
	.p2align 4,,10
	.p2align 3
.L84:
	.cfi_restore_state
	cmpq	%rbp, %rax
	jnb	.L54
	movzbl	0(%r13,%rax), %ecx
	testl	%ecx, %ecx
	je	.L91
	movq	%rdx, 16(%rbx)
	cmpl	$10, %ecx
	je	.L128
	addl	$1, 28(%rbx)
	movzbl	(%rsi), %ecx
.L87:
	testl	%ecx, %ecx
	je	.L129
	addq	$2, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %ecx
	je	.L130
	movl	28(%rbx), %edi
	leal	1(%rdi), %edx
.L90:
	movl	%edx, 28(%rbx)
	cmpq	%rbp, %rax
	jnb	.L54
.L91:
	movzbl	0(%r13,%rax), %edx
	testl	%edx, %edx
	je	.L101
	cmpl	$10, %edx
	je	.L101
	addq	$1, %rax
	addl	$1, 28(%rbx)
	movq	%rax, 16(%rbx)
	cmpq	%rbp, %rax
	jne	.L91
	jmp	.L55
.L127:
	cmpq	%rbp, %rax
	jnb	.L71
	movzbl	0(%r13,%rax), %ecx
	testl	%ecx, %ecx
	je	.L71
	movq	%rdx, 16(%rbx)
	cmpl	$10, %ecx
	je	.L131
	addl	$1, 28(%rbx)
	movzbl	(%rsi), %ecx
.L68:
	testl	%ecx, %ecx
	je	.L132
	addq	$2, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %ecx
	je	.L133
	movl	28(%rbx), %edi
	leal	1(%rdi), %edx
.L70:
	movl	%edx, 28(%rbx)
	.p2align 4
	.p2align 3
.L71:
	cmpq	%rbp, %rax
	jnb	.L72
.L135:
	movq	(%rbx), %rcx
	movzbl	(%rcx,%rax), %edx
	testl	%edx, %edx
	je	.L72
	cmpl	$42, %edx
	jne	.L76
	leaq	1(%rax), %rdx
	cmpq	%rbp, %rdx
	jnb	.L77
	addq	%rdx, %rcx
	cmpb	$47, (%rcx)
	je	.L134
	movq	%rdx, 16(%rbx)
	movq	%rdx, %rax
.L80:
	addl	$1, 28(%rbx)
	cmpq	%rbp, %rax
	jb	.L135
	.p2align 4
	.p2align 3
.L72:
	movl	28(%rbx), %edx
	movl	24(%rbx), %esi
	leaq	.LC4(%rip), %r8
	movl	$2, %ecx
	movq	32(%rbx), %rdi
	call	error_at_location@PLT
	movq	16(%rbx), %rax
	movq	8(%rbx), %rbp
	cmpq	%rbp, %rax
	jnb	.L71
	movq	(%rbx), %rdx
	movzbl	(%rdx,%rax), %edx
	testl	%edx, %edx
	je	.L71
.L76:
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	jne	.L80
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L71
	.p2align 4,,10
	.p2align 3
.L77:
	movq	%rdx, 16(%rbx)
	movq	%rdx, %rax
	jmp	.L80
.L134:
	movl	28(%rbx), %esi
	movq	%rdx, 16(%rbx)
	leal	1(%rsi), %edi
	movl	%edi, 28(%rbx)
	movzbl	(%rcx), %ecx
	testl	%ecx, %ecx
	je	.L97
	addq	$2, %rax
	addl	$2, %esi
	movq	%rax, 16(%rbx)
	cmpl	$10, %ecx
	jne	.L83
	addl	$1, 24(%rbx)
	movl	$1, %esi
.L83:
	movl	%esi, 28(%rbx)
	jmp	.L55
.L128:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	movzbl	(%rsi), %ecx
	jmp	.L87
.L97:
	movq	%rdx, %rax
	jmp	.L55
.L130:
	addl	$1, 24(%rbx)
	movl	$1, %edx
	jmp	.L90
.L101:
	movq	16(%rbx), %rax
	jmp	.L55
.L133:
	addl	$1, 24(%rbx)
	movl	$1, %edx
	jmp	.L70
.L131:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	movzbl	(%rsi), %ecx
	jmp	.L68
.L129:
	movq	%rdx, %rax
	jmp	.L91
.L132:
	movq	%rdx, %rax
	jmp	.L71
	.cfi_endproc
.LFE19:
	.size	lx_skip_ws_and_comments, .-lx_skip_ws_and_comments
	.p2align 4
	.globl	mk_tok
	.type	mk_tok, @function
mk_tok:
.LFB20:
	.cfi_startproc
	movl	%esi, (%rdi)
	movq	%rdi, %rax
	movq	$0, 8(%rdi)
	movq	$0, 16(%rdi)
	movl	$0, 24(%rdi)
	movq	$0, 32(%rdi)
	movl	%edx, 40(%rdi)
	movl	%ecx, 44(%rdi)
	movq	%r8, 48(%rdi)
	ret
	.cfi_endproc
.LFE20:
	.size	mk_tok, .-mk_tok
	.section	.rodata.str1.8
	.align 8
.LC6:
	.string	"B72 names cannot exceed 8 characters"
	.align 8
.LC7:
	.string	"dots are not allowed in B72 names"
	.section	.rodata.str1.1
.LC8:
	.string	"out of memory"
.LC9:
	.string	"auto"
.LC10:
	.string	"else"
.LC11:
	.string	"while"
.LC12:
	.string	"return"
.LC13:
	.string	"extrn"
.LC14:
	.string	"break"
.LC15:
	.string	"continue"
.LC16:
	.string	"goto"
.LC17:
	.string	"switch"
.LC18:
	.string	"case"
.LC19:
	.string	"default"
	.section	.rodata.str1.8
	.align 8
.LC20:
	.string	"hexadecimal literals are not allowed in strict B mode (use octal or omit --strict)"
	.section	.rodata.str1.1
.LC21:
	.string	"bad octal digit '%c'"
.LC22:
	.string	"bad number"
.LC23:
	.string	"unterminated string"
.LC24:
	.string	"character constant too long"
	.section	.rodata.str1.8
	.align 8
.LC25:
	.string	"unterminated character constant"
	.align 8
.LC26:
	.string	"character constants longer than 2 bytes are not allowed in strict B72 mode"
	.section	.rodata.str1.1
.LC27:
	.string	"empty character constant"
	.section	.rodata.str1.8
	.align 8
.LC28:
	.string	"C-style compound assignments (op=) are not allowed in strict B mode (use =op)"
	.align 8
.LC29:
	.string	"|| is not part of Thompson B72 (use | or a conditional expression)"
	.section	.rodata.str1.1
.LC30:
	.string	"unexpected character '%c'"
	.text
	.p2align 4
	.globl	lx_next
	.type	lx_next, @function
lx_next:
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
	movq	%rdi, %rbp
	movq	%rsi, %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$120, %rsp
	.cfi_def_cfa_offset 176
	call	lx_skip_ws_and_comments
	movq	24(%rbx), %rax
	movq	16(%rbx), %r13
	movq	8(%rbx), %r12
	movq	%rax, (%rsp)
	cmpq	%r12, %r13
	jnb	.L613
	movq	(%rbx), %rdx
	leaq	(%rdx,%r13), %r8
	movzbl	(%r8), %r15d
	testl	%r15d, %r15d
	je	.L613
	movq	(%rsp), %xmm0
	movq	%rdx, 32(%rsp)
	movq	%r8, 16(%rsp)
	pshufd	$0xe5, %xmm0, %xmm1
	movq	%r13, 24(%rsp)
	movb	%r15b, 8(%rsp)
	movd	%xmm1, 40(%rsp)
	movd	%xmm0, 44(%rsp)
	call	__ctype_b_loc@PLT
	movzbl	8(%rsp), %ecx
	movq	16(%rsp), %r8
	movq	(%rax), %rax
	movq	24(%rsp), %rdi
	movq	%rcx, %r9
	movq	32(%rsp), %rdx
	movzwl	(%rax,%rcx,2), %r10d
	movl	%r10d, %ecx
	shrw	$10, %cx
	andl	$1, %ecx
	cmpl	$95, %r15d
	sete	%r11b
	orb	%r11b, %cl
	je	.L587
	movq	%r13, %r15
.L147:
	cmpq	%r12, %r15
	jnb	.L631
.L146:
	movzbl	(%rdx,%r15), %ecx
	movzbl	%cl, %esi
	testb	$8, (%rax,%rsi,2)
	jne	.L149
	cmpb	$95, %cl
	je	.L151
	cmpb	$46, %cl
	jne	.L148
.L151:
	addq	$1, %r15
	movq	%r15, 16(%rbx)
.L144:
	movl	28(%rbx), %ecx
	addl	$1, %ecx
.L145:
	movl	%ecx, 28(%rbx)
	cmpq	%r12, %r15
	jb	.L146
.L631:
	testb	$8, (%rax)
	jne	.L147
.L148:
	movl	g_strict(%rip), %r12d
	testl	%r12d, %r12d
	je	.L152
	movq	%r15, %rdx
	subq	%r13, %rdx
	cmpq	$8, %rdx
	ja	.L632
.L153:
	movl	$46, %esi
	movq	%r8, %rdi
	call	memchr@PLT
	testq	%rax, %rax
	je	.L152
	movq	32(%rbx), %rdi
	movl	40(%rsp), %edx
	leaq	.LC7(%rip), %r8
	movl	$8, %ecx
	movl	44(%rsp), %esi
	call	error_at_location@PLT
	movq	16(%rbx), %r15
.L152:
	movq	g_compilation_arena(%rip), %rdi
	testq	%rdi, %rdi
	je	.L154
	movq	(%rbx), %rsi
	movq	%r13, %rdx
	movq	%r15, %rcx
	xorl	%r13d, %r13d
	call	arena_xstrdup_range@PLT
	movq	%rax, %r12
.L155:
	leaq	.LC9(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$5, %eax
	testl	%edx, %edx
	je	.L158
	cmpb	$105, (%r12)
	jne	.L443
	cmpb	$102, 1(%r12)
	je	.L633
.L443:
	leaq	.LC10(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$7, %eax
	testl	%edx, %edx
	je	.L158
	leaq	.LC11(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$8, %eax
	testl	%edx, %edx
	je	.L158
	leaq	.LC12(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$9, %eax
	testl	%edx, %edx
	je	.L158
	leaq	.LC13(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$12, %eax
	testl	%edx, %edx
	je	.L158
	movl	g_extensions(%rip), %r14d
	andl	$64, %r14d
	je	.L160
	leaq	.LC14(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$10, %eax
	testl	%edx, %edx
	je	.L158
	leaq	.LC15(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$11, %eax
	testl	%edx, %edx
	je	.L158
.L160:
	leaq	.LC16(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$58, %eax
	testl	%edx, %edx
	je	.L158
	leaq	.LC17(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$59, %eax
	testl	%edx, %edx
	je	.L158
	leaq	.LC18(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$60, %eax
	testl	%edx, %edx
	je	.L158
	movl	$1, %eax
	testl	%r14d, %r14d
	je	.L158
	leaq	.LC19(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	cmpl	$1, %eax
	sbbl	%eax, %eax
	andl	$60, %eax
	addl	$1, %eax
	.p2align 4
	.p2align 3
.L158:
	movl	%eax, 0(%rbp)
	movq	32(%rbx), %rdx
	movq	(%rsp), %rax
	movq	%r12, 8(%rbp)
	movq	$0, 16(%rbp)
	movl	%r13d, 24(%rbp)
	movq	$0, 32(%rbp)
	movq	%rax, 40(%rbp)
	movq	%rdx, 48(%rbp)
	jmp	.L137
	.p2align 4,,10
	.p2align 3
.L383:
	leaq	48(%rsp), %r12
	movl	%r15d, %ecx
	movl	$64, %esi
	xorl	%eax, %eax
	leaq	.LC30(%rip), %rdx
	movq	%r12, %rdi
	call	snprintf@PLT
	movq	32(%rbx), %rdi
	movl	40(%rsp), %edx
	movq	%r12, %r8
	movl	44(%rsp), %esi
	movl	$8, %ecx
	call	error_at_location@PLT
	.p2align 4
	.p2align 3
.L613:
	movl	$0, 0(%rbp)
	movq	32(%rbx), %rax
.L612:
	movq	(%rsp), %rdx
	movq	$0, 8(%rbp)
	movq	$0, 16(%rbp)
	movl	$0, 24(%rbp)
	movq	$0, 32(%rbp)
	movq	%rdx, 40(%rbp)
	movq	%rax, 48(%rbp)
.L137:
	addq	$120, %rsp
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
.L587:
	.cfi_restore_state
	testw	$2048, %r10w
	jne	.L634
	movq	%r12, %r14
	cmpl	$34, %r15d
	je	.L635
	cmpl	$39, %r15d
	je	.L636
	cmpl	$43, %r15d
	je	.L637
	cmpl	$45, %r15d
	jne	.L638
	leaq	1(%r13), %rax
	cmpq	%r12, %rax
	jnb	.L254
	leaq	(%rdx,%rax), %r8
	movzbl	(%r8), %ecx
	cmpb	$45, %cl
	je	.L639
	testb	$8, g_extensions(%rip)
	je	.L640
	cmpb	$61, %cl
	je	.L641
.L254:
	cmpq	%r14, %rdi
	jb	.L642
	.p2align 4
	.p2align 3
.L381:
	subl	$33, %r9d
	cmpb	$92, %r9b
	ja	.L383
	leaq	.L385(%rip), %rdx
	movzbl	%r9b, %r9d
	movslq	(%rdx,%r9,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L385:
	.long	.L359-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L401-.L385
	.long	.L400-.L385
	.long	.L383-.L385
	.long	.L399-.L385
	.long	.L398-.L385
	.long	.L397-.L385
	.long	.L396-.L385
	.long	.L395-.L385
	.long	.L394-.L385
	.long	.L383-.L385
	.long	.L393-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L392-.L385
	.long	.L391-.L385
	.long	.L367-.L385
	.long	.L356-.L385
	.long	.L390-.L385
	.long	.L389-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L388-.L385
	.long	.L383-.L385
	.long	.L387-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L383-.L385
	.long	.L386-.L385
	.long	.L346-.L385
	.long	.L384-.L385
	.text
	.p2align 4,,10
	.p2align 3
.L634:
	cmpl	$48, %r15d
	jne	.L432
	leaq	1(%r13), %rsi
	cmpq	%r12, %rsi
	jnb	.L163
	leaq	(%rdx,%rsi), %r9
	movzbl	(%r9), %edi
	andl	$-33, %edi
	cmpb	$88, %dil
	je	.L643
.L163:
	movl	40(%rsp), %ecx
	movq	%rsi, 16(%rbx)
	leal	1(%rcx), %edi
	.p2align 4
	.p2align 3
.L179:
	movl	%edi, 28(%rbx)
.L185:
	cmpq	%r12, %rsi
	jnb	.L183
	movzbl	(%rdx,%rsi), %ecx
	movzbl	%cl, %r9d
	testb	$8, 1(%rax,%r9,2)
	je	.L606
	testl	%ecx, %ecx
	je	.L185
	addq	$1, %rsi
	addl	$1, %edi
	movq	%rsi, 16(%rbx)
	cmpl	$10, %ecx
	jne	.L179
	addl	$1, 24(%rbx)
	movl	$1, %edi
	jmp	.L179
	.p2align 4,,10
	.p2align 3
.L154:
	cmpq	%r15, %r13
	jb	.L644
	movl	$1, %edi
	xorl	%r15d, %r15d
.L156:
	call	malloc@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L645
.L157:
	movq	(%rbx), %rsi
	movq	%r15, %rdx
	movq	%r12, %rdi
	addq	%r13, %rsi
	movl	$1, %r13d
	call	memcpy@PLT
	movb	$0, (%r12,%r15)
	jmp	.L155
	.p2align 4,,10
	.p2align 3
.L149:
	testl	%ecx, %ecx
	je	.L147
	addq	$1, %r15
	movq	%r15, 16(%rbx)
	cmpl	$10, %ecx
	jne	.L144
	addl	$1, 24(%rbx)
	movl	$1, %ecx
	jmp	.L145
	.p2align 4,,10
	.p2align 3
.L432:
	movq	%r13, %rsi
	.p2align 4
	.p2align 3
.L191:
	cmpq	%r12, %rsi
	jnb	.L189
.L647:
	movzbl	(%rdx,%rsi), %edi
	movzbl	%dil, %r9d
	testb	$8, 1(%rax,%r9,2)
	je	.L605
	testl	%edi, %edi
	je	.L191
	addq	$1, %rsi
	movq	%rsi, 16(%rbx)
	cmpl	$10, %edi
	je	.L646
	movl	28(%rbx), %edi
	addl	$1, %edi
.L188:
	movl	%edi, 28(%rbx)
	cmpq	%r12, %rsi
	jb	.L647
.L189:
	testb	$8, 1(%rax)
	jne	.L191
.L605:
	movl	$10, %r15d
.L177:
	cmpq	%rsi, %r13
	jb	.L648
	movl	$1, %edi
	xorl	%r12d, %r12d
.L192:
	movb	%cl, 16(%rsp)
	movq	%r8, 8(%rsp)
	call	malloc@PLT
	movq	8(%rsp), %r8
	movzbl	16(%rsp), %ecx
	testq	%rax, %rax
	movq	%rax, %r14
	je	.L649
.L193:
	movq	%r12, %rdx
	movq	%r8, %rsi
	movq	%r14, %rdi
	movb	%cl, 16(%rsp)
	call	memcpy@PLT
	movb	$0, (%r14,%r12)
	call	__errno_location@PLT
	movzbl	16(%rsp), %ecx
	movq	%rax, 8(%rsp)
	movl	$0, (%rax)
	testb	%cl, %cl
	je	.L194
	testq	%r12, %r12
	je	.L434
	leaq	(%r12,%r14), %r9
	xorl	%r15d, %r15d
	movq	%rbp, 24(%rsp)
	movq	%r14, %r13
	movq	%r14, 16(%rsp)
	movq	%r15, %r12
	movq	%r9, %rbp
	jmp	.L197
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L196:
	leal	-48(%r15), %eax
	addq	$1, %r13
	leaq	(%rax,%r12,8), %r12
	cmpq	%r13, %rbp
	je	.L650
.L197:
	movsbl	0(%r13), %r15d
	movl	%r15d, %eax
	subl	$48, %eax
	cmpb	$9, %al
	jbe	.L196
	leaq	48(%rsp), %r14
	movl	%r15d, %ecx
	movl	$64, %esi
	xorl	%eax, %eax
	movq	%r14, %rdi
	leaq	.LC21(%rip), %rdx
	call	snprintf@PLT
	movq	32(%rbx), %rdi
	movl	40(%rsp), %edx
	movq	%r14, %r8
	movl	44(%rsp), %esi
	movl	$8, %ecx
	call	error_at_location@PLT
	jmp	.L196
	.p2align 4,,10
	.p2align 3
.L646:
	addl	$1, 24(%rbx)
	movl	$1, %edi
	jmp	.L188
	.p2align 4,,10
	.p2align 3
.L644:
	subq	%r13, %r15
	leaq	1(%r15), %rdi
	jmp	.L156
	.p2align 4,,10
	.p2align 3
.L648:
	subq	%r13, %rsi
	movq	%rsi, %r12
	leaq	1(%rsi), %rdi
	jmp	.L192
	.p2align 4,,10
	.p2align 3
.L633:
	cmpb	$0, 2(%r12)
	movl	$6, %eax
	je	.L158
	jmp	.L443
	.p2align 4,,10
	.p2align 3
.L638:
	movl	24(%rbx), %r8d
	testb	$8, g_extensions(%rip)
	jne	.L252
	movl	g_pedantic(%rip), %ecx
	testl	%ecx, %ecx
	je	.L290
	cmpb	$47, %r9b
	jg	.L291
	cmpb	$36, %r9b
	jg	.L651
.L292:
	cmpl	$33, %r15d
	jne	.L344
	leaq	1(%r13), %rax
	cmpq	%r12, %rax
	jnb	.L344
.L358:
	leaq	(%rdx,%rax), %rcx
	cmpb	$61, (%rcx)
	je	.L652
.L360:
	cmpq	%r12, %r13
	jb	.L344
.L359:
	movl	$35, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L401:
	movl	$34, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L384:
	movl	$16, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L397:
	movl	$32, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L398:
	movl	$14, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L399:
	movl	$13, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L400:
	movl	$53, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L391:
	movl	$18, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L392:
	movl	$57, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L393:
	movl	$33, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L394:
	movl	$31, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L395:
	movl	$17, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L396:
	movl	$30, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L386:
	movl	$15, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L387:
	movl	$20, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L388:
	movl	$19, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L389:
	movl	$56, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L688:
	movq	(%rbx), %rdx
	cmpb	$61, 1(%rdx,%r13)
	je	.L653
	cmpq	%r12, %r13
	jb	.L380
.L390:
	movl	$26, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
	.p2align 4,,10
	.p2align 3
.L183:
	testb	$8, 1(%rax)
	jne	.L185
.L606:
	movl	$1, %ecx
	movl	$8, %r15d
	jmp	.L177
	.p2align 4,,10
	.p2align 3
.L650:
	movq	16(%rsp), %r14
	movq	24(%rsp), %rbp
	movq	%r12, %r15
.L198:
	movq	%r14, %rdi
	call	free@PLT
	movq	8(%rsp), %rax
	movl	(%rax), %r9d
	testl	%r9d, %r9d
	jne	.L654
.L200:
	movq	32(%rbx), %rax
	movq	(%rsp), %rdx
	movl	$2, 0(%rbp)
	movq	$0, 8(%rbp)
	movq	$0, 16(%rbp)
	movl	$0, 24(%rbp)
	movq	%r15, 32(%rbp)
	movq	%rdx, 40(%rbp)
	movq	%rax, 48(%rbp)
	jmp	.L137
	.p2align 4,,10
	.p2align 3
.L632:
	movq	32(%rbx), %rdi
	movl	40(%rsp), %edx
	leaq	.LC6(%rip), %r8
	movl	$8, %ecx
	movl	44(%rsp), %esi
	call	error_at_location@PLT
	movl	g_strict(%rip), %r11d
	movq	16(%rbx), %r15
	testl	%r11d, %r11d
	je	.L152
	movq	(%rbx), %r8
	movq	%r15, %rdx
	subq	%r13, %rdx
	addq	%r13, %r8
	jmp	.L153
	.p2align 4,,10
	.p2align 3
.L194:
	movl	%r15d, %edx
	xorl	%esi, %esi
	movq	%r14, %rdi
	call	strtoull@PLT
	movq	%rax, %r15
	movq	8(%rsp), %rax
	cmpl	$34, (%rax)
	jne	.L198
	movq	32(%rbx), %rdi
	movl	40(%rsp), %edx
	leaq	.LC22(%rip), %r8
	movl	$8, %ecx
	movl	44(%rsp), %esi
	call	error_at_location@PLT
	jmp	.L198
	.p2align 4,,10
	.p2align 3
.L654:
	movq	32(%rbx), %rdi
	movl	40(%rsp), %edx
	leaq	.LC22(%rip), %r8
	movl	$8, %ecx
	movl	44(%rsp), %esi
	call	error_at_location@PLT
	jmp	.L200
	.p2align 4,,10
	.p2align 3
.L637:
	leaq	1(%rdi), %rax
	cmpq	%r12, %rax
	jnb	.L655
	leaq	(%rdx,%rax), %rcx
	cmpb	$43, (%rcx)
	je	.L656
	testb	$8, g_extensions(%rip)
	jne	.L657
	movl	g_pedantic(%rip), %eax
	testl	%eax, %eax
	jne	.L409
.L344:
	movzbl	(%rdx,%rdi), %edx
	testl	%edx, %edx
	je	.L381
	leaq	1(%rdi), %rax
	.p2align 4
	.p2align 3
.L347:
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	jne	.L369
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L381
	.p2align 4,,10
	.p2align 3
.L643:
	testb	$1, g_extensions(%rip)
	jne	.L164
	movl	g_pedantic(%rip), %r10d
	testl	%r10d, %r10d
	jne	.L658
	movq	%rsi, 16(%rbx)
.L167:
	addl	$1, 28(%rbx)
.L166:
	movl	$2, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L290:
	cmpl	$61, %r15d
	je	.L277
	cmpl	$60, %r15d
	jne	.L334
	leaq	1(%r13), %rax
	cmpq	%r12, %rax
	jnb	.L335
.L622:
	addq	%rax, %rdx
	cmpb	$60, (%rdx)
	je	.L659
	cmpb	$61, (%rdx)
	je	.L283
	movl	$60, %edx
	jmp	.L347
	.p2align 4,,10
	.p2align 3
.L252:
	cmpl	$42, %r15d
	je	.L660
	cmpl	$47, %r15d
	jne	.L267
	leaq	1(%r13), %rax
	cmpq	%r12, %rax
	jnb	.L254
	addq	%rax, %rdx
	cmpb	$61, (%rdx)
	jne	.L254
	movq	%rax, 16(%rbx)
	movl	40(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rdx), %eax
	testl	%eax, %eax
	je	.L320
.L630:
	addq	$2, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L661
	movl	40(%rsp), %r14d
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L320:
	movl	$41, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
	.p2align 4,,10
	.p2align 3
.L635:
	movl	40(%rsp), %eax
	leaq	1(%rdi), %r12
	movl	$1, %edi
	movq	%r12, 16(%rbx)
	addl	$1, %eax
	movl	%eax, 28(%rbx)
	call	malloc@PLT
	movq	%rax, %r15
	testq	%rax, %rax
	je	.L662
.L202:
	xorl	%r13d, %r13d
	movl	$1, %r9d
	movq	%rbp, 8(%rsp)
	movq	%r14, %rcx
	movq	%r13, %rax
	movq	%r9, %rbp
	movq	%r15, %r13
	movq	%rax, %r15
	jmp	.L216
	.p2align 4,,10
	.p2align 3
.L667:
	movq	(%rbx), %rsi
	movzbl	(%rsi,%r12), %eax
	movl	%eax, %r14d
	testl	%eax, %eax
	je	.L203
	addq	$1, %r12
	movq	%r12, 16(%rbx)
	cmpl	$10, %eax
	je	.L663
	addl	$1, 28(%rbx)
	cmpl	$34, %eax
	je	.L664
	cmpl	$42, %eax
	je	.L665
	cmpl	$92, %eax
	jne	.L205
	movl	40(%rsp), %edx
	movl	44(%rsp), %esi
	movq	%rbx, %rdi
	call	parse_backslash_escape
	movl	%eax, %r14d
	.p2align 4
	.p2align 3
.L205:
	leaq	2(%r15), %rax
	cmpq	%rax, %rbp
	jb	.L666
.L213:
	movq	16(%rbx), %r12
	movq	8(%rbx), %rcx
	movb	%r14b, 0(%r13,%r15)
	addq	$1, %r15
.L216:
	cmpq	%rcx, %r12
	jb	.L667
.L203:
	movq	32(%rbx), %rdi
	movl	40(%rsp), %edx
	movl	$8, %ecx
	xorl	%r14d, %r14d
	movl	44(%rsp), %esi
	leaq	.LC23(%rip), %r8
	call	error_at_location@PLT
	jmp	.L205
	.p2align 4,,10
	.p2align 3
.L665:
	movl	$42, %r14d
	cmpq	%rcx, %r12
	jnb	.L205
	movzbl	(%rsi,%r12), %eax
	cmpb	$48, %al
	jg	.L209
	cmpb	$33, %al
	jle	.L205
	movabsq	$289738493788160, %rcx
	btq	%rax, %rcx
	jnc	.L205
.L211:
	movl	40(%rsp), %edx
	movl	44(%rsp), %esi
	movq	%rbx, %rdi
	call	parse_escape
	movl	%eax, %r14d
	jmp	.L205
	.p2align 4,,10
	.p2align 3
.L666:
	leaq	8(%rbp,%rbp), %rbp
	movq	%r13, %rdi
	movq	%rbp, %rsi
	call	realloc@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	jne	.L213
	leaq	.LC8(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L213
	.p2align 4,,10
	.p2align 3
.L663:
	addl	$1, 24(%rbx)
	movl	$10, %r14d
	movl	$1, 28(%rbx)
	jmp	.L205
	.p2align 4,,10
	.p2align 3
.L636:
	movl	40(%rsp), %r15d
	addq	$1, %rdi
	xorl	%r13d, %r13d
	movq	$0, 48(%rsp)
	movq	%rdi, 16(%rbx)
	movl	44(%rsp), %r14d
	movq	$0, 56(%rsp)
	leal	1(%r15), %eax
	movl	%eax, 28(%rbx)
	movq	%r12, %rax
	cmpq	%rax, %rdi
	jnb	.L219
.L672:
	movq	(%rbx), %rdx
	movzbl	(%rdx,%rdi), %r12d
	testl	%r12d, %r12d
	je	.L219
	addq	$1, %rdi
	movq	%rdi, 16(%rbx)
	cmpl	$10, %r12d
	je	.L668
	addl	$1, 28(%rbx)
	cmpl	$39, %r12d
	je	.L669
	cmpq	$1, %r13
	jbe	.L229
	testb	$32, g_extensions(%rip)
	je	.L222
.L230:
	cmpq	$4, %r13
	je	.L670
.L229:
	cmpl	$42, %r12d
	je	.L671
	cmpl	$92, %r12d
	jne	.L607
	movl	%r15d, %edx
	movl	%r14d, %esi
	movq	%rbx, %rdi
	call	parse_backslash_escape
	movl	%eax, %r12d
.L607:
	movq	16(%rbx), %rdi
	movq	8(%rbx), %rax
.L221:
	movl	%r12d, 48(%rsp,%r13,4)
	addq	$1, %r13
	cmpq	%rax, %rdi
	jb	.L672
.L219:
	movq	32(%rbx), %rdi
	movl	$8, %ecx
	movl	%r15d, %edx
	movl	%r14d, %esi
	leaq	.LC25(%rip), %r8
	call	error_at_location@PLT
	cmpq	$1, %r13
	jbe	.L228
	testb	$32, g_extensions(%rip)
	je	.L438
	cmpq	$4, %r13
	je	.L673
.L228:
	movq	16(%rbx), %rdi
	movq	8(%rbx), %rax
	xorl	%r12d, %r12d
	jmp	.L221
	.p2align 4,,10
	.p2align 3
.L671:
	movq	16(%rbx), %rdi
	movq	8(%rbx), %rax
	cmpq	%rax, %rdi
	jnb	.L221
	movq	(%rbx), %rcx
	movzbl	(%rcx,%rdi), %edx
	cmpb	$39, %dl
	je	.L234
	jle	.L674
	cmpb	$116, %dl
	jg	.L221
	cmpb	$100, %dl
	jg	.L237
	cmpb	$42, %dl
	jle	.L236
	cmpb	$48, %dl
	jne	.L221
.L236:
	movq	%rbx, %rdi
	movl	%r15d, %edx
	movl	%r14d, %esi
	call	parse_escape
	movq	16(%rbx), %rdi
	movl	%eax, %r12d
	movq	8(%rbx), %rax
	jmp	.L221
.L669:
	testl	%r13d, %r13d
	je	.L675
	movslq	%r13d, %rax
	leaq	48(%rsp), %rdx
	leaq	(%rdx,%rax,4), %rsi
	xorl	%eax, %eax
	.p2align 5
	.p2align 4
	.p2align 3
.L242:
	movl	(%rdx), %ecx
	salq	$8, %rax
	addq	$4, %rdx
	orq	%rcx, %rax
	cmpq	%rdx, %rsi
	jne	.L242
.L241:
	movq	%rax, 32(%rbp)
	movq	32(%rbx), %rdx
	movq	(%rsp), %rax
	movl	$4, 0(%rbp)
	movq	$0, 8(%rbp)
	movq	$0, 16(%rbp)
	movl	$0, 24(%rbp)
	movq	%rax, 40(%rbp)
	movq	%rdx, 48(%rbp)
	jmp	.L137
.L267:
	cmpl	$37, %r15d
	jne	.L270
	leaq	1(%r13), %rax
	cmpq	%r12, %rax
	jnb	.L254
	cmpb	$61, 1(%rdx,%r13)
	jne	.L254
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$42, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L703:
	cmpl	$61, %r15d
	jne	.L676
	.p2align 4
	.p2align 3
.L277:
	leaq	1(%r13), %rax
	cmpq	%r12, %rax
	jnb	.L300
	leaq	(%rdx,%rax), %rsi
	movzbl	(%rsi), %r10d
	movl	%r10d, %ecx
	cmpb	$43, %r10b
	je	.L677
	cmpb	$60, %r10b
	jg	.L304
	cmpb	$36, %r10b
	jle	.L305
	subl	$37, %ecx
	cmpb	$23, %cl
	ja	.L306
	leaq	.L308(%rip), %r10
	movzbl	%cl, %ecx
	movslq	(%r10,%rcx,4), %rcx
	addq	%r10, %rcx
	jmp	*%rcx
	.section	.rodata
	.align 4
	.align 4
.L308:
	.long	.L313-.L308
	.long	.L312-.L308
	.long	.L306-.L308
	.long	.L306-.L308
	.long	.L306-.L308
	.long	.L311-.L308
	.long	.L306-.L308
	.long	.L306-.L308
	.long	.L310-.L308
	.long	.L306-.L308
	.long	.L309-.L308
	.long	.L306-.L308
	.long	.L306-.L308
	.long	.L306-.L308
	.long	.L306-.L308
	.long	.L306-.L308
	.long	.L306-.L308
	.long	.L306-.L308
	.long	.L306-.L308
	.long	.L306-.L308
	.long	.L306-.L308
	.long	.L306-.L308
	.long	.L306-.L308
	.long	.L307-.L308
	.text
	.p2align 4,,10
	.p2align 3
.L306:
	cmpq	%r12, %rax
	jnb	.L300
	cmpb	$61, (%rsi)
	jne	.L344
	movl	40(%rsp), %edx
	movq	%rax, 16(%rbx)
	addl	$1, %edx
	movl	%edx, 28(%rbx)
	movzbl	(%rsi), %edx
	testl	%edx, %edx
	je	.L354
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L678
	movl	40(%rsp), %r14d
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L354:
	movl	$22, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L307:
	movzbl	2(%rdx,%r13), %eax
	movq	%rbx, %rdi
	cmpb	$60, %al
	je	.L616
	cmpb	$61, %al
	je	.L679
	call	lx_get
	call	lx_get
	movl	$47, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L309:
	movq	%rax, 16(%rbx)
	movl	40(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rsi), %eax
	testl	%eax, %eax
	jne	.L630
	jmp	.L320
.L310:
	movq	%rax, 16(%rbx)
	movl	40(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rsi), %eax
	testl	%eax, %eax
	je	.L316
.L626:
	addq	$2, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L680
	movl	40(%rsp), %r14d
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L316:
	movl	$39, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L311:
	movq	%rax, 16(%rbx)
	movl	40(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rsi), %eax
	testl	%eax, %eax
	je	.L318
.L628:
	addq	$2, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L681
	movl	40(%rsp), %r14d
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L318:
	movl	$40, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L312:
	movq	%rax, 16(%rbx)
	movl	40(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rsi), %eax
	testl	%eax, %eax
	je	.L324
	addq	$2, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L682
	movl	40(%rsp), %r14d
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L324:
	movl	$45, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L313:
	movq	%rax, 16(%rbx)
	movl	40(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rsi), %eax
	testl	%eax, %eax
	je	.L322
	addq	$2, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L683
	movl	40(%rsp), %r14d
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L322:
	movl	$42, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L655:
	testb	$8, g_extensions(%rip)
	jne	.L254
	movl	g_pedantic(%rip), %r8d
	testl	%r8d, %r8d
	je	.L344
	jmp	.L254
	.p2align 4,,10
	.p2align 3
.L209:
	subl	$101, %eax
	cmpb	$15, %al
	ja	.L205
	movl	$33281, %ecx
	btq	%rax, %rcx
	jc	.L211
	jmp	.L205
.L438:
	xorl	%r12d, %r12d
.L222:
	movq	32(%rbx), %rdi
	movl	$8, %ecx
	movl	%r15d, %edx
	movl	%r14d, %esi
	leaq	.LC26(%rip), %r8
	call	error_at_location@PLT
	jmp	.L230
.L164:
	movl	40(%rsp), %r11d
	movq	%rsi, 16(%rbx)
	leal	1(%r11), %edi
	movl	%edi, 28(%rbx)
	movzbl	(%r9), %edi
	testl	%edi, %edi
	je	.L178
	leaq	2(%r13), %rsi
	leal	2(%r11), %r9d
	movq	%rsi, 16(%rbx)
	cmpl	$10, %edi
	jne	.L170
	movl	44(%rsp), %edi
	movl	$1, %r9d
	addl	$1, %edi
	movl	%edi, 24(%rbx)
.L170:
	movl	%r9d, 28(%rbx)
	.p2align 4
	.p2align 3
.L178:
	cmpq	%r12, %rsi
	jnb	.L175
.L685:
	movzbl	(%rdx,%rsi), %edi
	movzbl	%dil, %r9d
	testb	$16, 1(%rax,%r9,2)
	je	.L604
	testl	%edi, %edi
	je	.L178
	addq	$1, %rsi
	movq	%rsi, 16(%rbx)
	cmpl	$10, %edi
	je	.L684
	movl	28(%rbx), %edi
	addl	$1, %edi
.L174:
	movl	%edi, 28(%rbx)
	cmpq	%r12, %rsi
	jb	.L685
.L175:
	testb	$16, 1(%rax)
	jne	.L178
.L604:
	movl	$16, %r15d
	jmp	.L177
	.p2align 4,,10
	.p2align 3
.L684:
	addl	$1, 24(%rbx)
	movl	$1, %edi
	jmp	.L174
.L668:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	cmpq	$1, %r13
	jbe	.L221
	testb	$32, g_extensions(%rip)
	je	.L222
	cmpq	$4, %r13
	jne	.L221
	movq	32(%rbx), %rdi
	movl	$8, %ecx
	movl	%r15d, %edx
	movl	%r14d, %esi
	leaq	.LC24(%rip), %r8
	call	error_at_location@PLT
	jmp	.L607
	.p2align 4,,10
	.p2align 3
.L640:
	movl	g_pedantic(%rip), %esi
	testl	%esi, %esi
	je	.L254
.L409:
	cmpb	$61, 1(%rdx,%r13)
	jne	.L254
.L293:
	movq	32(%rbx), %rdi
	movl	40(%rsp), %edx
	leaq	.LC28(%rip), %r8
	movl	$8, %ecx
	movl	44(%rsp), %esi
	movb	%r9b, 8(%rsp)
	call	error_at_location@PLT
	movq	16(%rbx), %r13
	movq	8(%rbx), %r12
	cmpl	$124, %r15d
	movzbl	8(%rsp), %r9d
	movq	%r13, %rdi
	movq	%r12, %r14
	jne	.L245
	leaq	1(%r13), %rax
	cmpq	%r12, %rax
	jnb	.L273
	movq	(%rbx), %rdx
.L345:
	movzbl	(%rdx,%rax), %eax
.L295:
	cmpb	$124, %al
	je	.L686
.L348:
	movq	%r13, %rdi
	movq	%r12, %r14
	jmp	.L254
.L335:
	addl	$1, 28(%rbx)
	movq	%rax, 16(%rbx)
.L367:
	movl	$24, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L270:
	cmpl	$38, %r15d
	jne	.L271
	leaq	1(%r13), %rax
	cmpq	%r12, %rax
	jnb	.L254
	cmpb	$61, 1(%rdx,%r13)
	jne	.L254
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$45, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L664:
	movq	g_compilation_arena(%rip), %rdi
	movq	%r15, %rax
	movq	%r13, %r15
	movq	8(%rsp), %rbp
	movb	$0, (%r15,%rax)
	movq	%rax, %r13
	movl	$1, %eax
	testq	%rdi, %rdi
	je	.L217
	leaq	1(%r13), %r14
	movq	%r14, %rsi
	call	arena_alloc@PLT
	movq	%r15, %rsi
	movq	%r14, %rdx
	movq	%rax, %rdi
	movq	%rax, %r12
	call	memcpy@PLT
	movq	%r15, %rdi
	movq	%r12, %r15
	call	free@PLT
	xorl	%eax, %eax
.L217:
	movl	%eax, 24(%rbp)
	movq	32(%rbx), %rdx
	movq	(%rsp), %rax
	movl	$3, 0(%rbp)
	movq	%r15, 8(%rbp)
	movq	%r13, 16(%rbp)
	movq	$0, 32(%rbp)
	movq	%rax, 40(%rbp)
	movq	%rdx, 48(%rbp)
	jmp	.L137
.L660:
	leaq	1(%r13), %rax
	cmpq	%r12, %rax
	jnb	.L254
	addq	%rax, %rdx
	cmpb	$61, (%rdx)
	jne	.L254
	movq	%rax, 16(%rbx)
	movl	40(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rdx), %eax
	testl	%eax, %eax
	jne	.L628
	jmp	.L318
	.p2align 4,,10
	.p2align 3
.L434:
	xorl	%r15d, %r15d
	jmp	.L198
.L657:
	cmpb	$61, (%rcx)
	jne	.L254
	movq	%rax, 16(%rbx)
	movl	40(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L302
.L624:
	addq	$2, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L687
	movl	40(%rsp), %r14d
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L302:
	movl	$38, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L658:
	movq	32(%rbx), %rdi
	movl	40(%rsp), %edx
	leaq	.LC20(%rip), %r8
	movl	$8, %ecx
	movl	44(%rsp), %esi
	call	error_at_location@PLT
	movq	16(%rbx), %rax
	cmpq	8(%rbx), %rax
	jnb	.L166
	movq	(%rbx), %rdx
	movzbl	(%rdx,%rax), %edx
	testl	%edx, %edx
	je	.L166
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	jne	.L167
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L166
.L271:
	cmpl	$124, %r15d
	jne	.L272
	leaq	1(%r13), %rax
	cmpq	%r12, %rax
	jnb	.L273
	cmpb	$61, 1(%rdx,%r13)
	jne	.L345
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$46, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L651:
	movl	$1379, %eax
	salq	$37, %rax
	btq	%r9, %rax
	jnc	.L292
	leaq	1(%r13), %rax
	cmpq	%r12, %rax
	jnb	.L245
	cmpb	$61, 1(%rdx,%r13)
	je	.L293
.L245:
	cmpl	$62, %r15d
	jne	.L254
	leaq	1(%r13), %rax
.L288:
	cmpq	%r12, %rax
	jb	.L688
	cmpq	%r12, %r13
	jnb	.L390
	movq	(%rbx), %rdx
.L380:
	movzbl	(%rdx,%r13), %edx
	testl	%edx, %edx
	jne	.L347
	jmp	.L390
.L272:
	cmpl	$60, %r15d
	jne	.L689
	leaq	1(%r13), %rax
	cmpq	%r12, %rax
	jnb	.L335
	cmpb	$60, 1(%rdx,%r13)
	je	.L282
	addq	%rax, %rdx
	cmpb	$61, (%rdx)
	je	.L283
	movq	%rax, 16(%rbx)
.L369:
	addl	$1, 28(%rbx)
	jmp	.L381
.L686:
	testb	$16, g_extensions(%rip)
	jne	.L690
	movl	g_pedantic(%rip), %edx
	testl	%edx, %edx
	je	.L348
	movq	32(%rbx), %rdi
	movl	40(%rsp), %edx
	leaq	.LC29(%rip), %r8
	movl	$8, %ecx
	movl	44(%rsp), %esi
	movb	%r9b, 8(%rsp)
	call	error_at_location@PLT
	movq	16(%rbx), %rdi
	movq	8(%rbx), %r14
	movzbl	8(%rsp), %r9d
	jmp	.L254
.L675:
	movq	32(%rbx), %rdi
	movl	40(%rsp), %edx
	leaq	.LC27(%rip), %r8
	movl	$8, %ecx
	movl	44(%rsp), %esi
	call	error_at_location@PLT
	xorl	%eax, %eax
	jmp	.L241
.L291:
	cmpb	$124, %r9b
	jne	.L290
	leaq	1(%r13), %rax
	cmpq	%r12, %rax
	jb	.L691
	addl	$1, 28(%rbx)
	movq	%rax, 16(%rbx)
.L346:
	movl	$54, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L234:
	leaq	1(%rdi), %rdx
	cmpq	%rax, %rdx
	jnb	.L221
	cmpb	$39, 1(%rcx,%rdi)
	jne	.L221
	jmp	.L236
.L670:
	movq	32(%rbx), %rdi
	movl	$8, %ecx
	movl	%r15d, %edx
	movl	%r14d, %esi
	leaq	.LC24(%rip), %r8
	call	error_at_location@PLT
	jmp	.L229
.L300:
	addl	$1, 28(%rbx)
	movq	%rax, 16(%rbx)
.L356:
	movl	$21, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L334:
	cmpl	$62, %r15d
	jne	.L247
	leaq	1(%r13), %rax
	cmpq	%r12, %rax
	jnb	.L380
.L609:
	addq	%rax, %rdx
	cmpb	$62, (%rdx)
	jne	.L288
	movl	40(%rsp), %ecx
	movq	%rax, 16(%rbx)
	addl	$1, %ecx
	movl	%ecx, 28(%rbx)
	movzbl	(%rdx), %edx
	testl	%edx, %edx
	je	.L340
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L692
	movl	40(%rsp), %r14d
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L340:
	movl	$29, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L304:
	cmpb	$124, %r10b
	jne	.L693
	movq	%rax, 16(%rbx)
	movl	40(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rsi), %eax
	testl	%eax, %eax
	je	.L326
	addq	$2, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L694
	movl	40(%rsp), %r14d
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L326:
	movl	$46, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L656:
	movq	%rax, 16(%rbx)
	movl	40(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L249
	addq	$2, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L695
	movl	40(%rsp), %r14d
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L249:
	movl	$36, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L674:
	cmpb	$34, %dl
	jne	.L221
	jmp	.L236
.L639:
	movq	%rax, 16(%rbx)
	movl	40(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	je	.L256
	addq	$2, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L696
	movl	40(%rsp), %r14d
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L256:
	movl	$37, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L237:
	subl	$101, %edx
	movl	$33281, %ecx
	btq	%rdx, %rcx
	jc	.L236
	jmp	.L221
.L653:
	cmpq	%r12, %r13
	jnb	.L375
	movzbl	(%rdx,%r13), %ecx
	testl	%ecx, %ecx
	je	.L376
	movq	%rax, 16(%rbx)
	cmpl	$10, %ecx
	je	.L697
	addl	$1, 28(%rbx)
	movq	%rax, %r13
.L376:
	movzbl	(%rdx,%r13), %eax
	testl	%eax, %eax
	je	.L375
	addq	$1, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L698
	addl	$1, 28(%rbx)
.L375:
	movl	$27, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L273:
	cmpq	%r12, %r13
	jnb	.L346
	movq	(%rbx), %rdx
	movzbl	(%rdx,%r13), %edx
	testl	%edx, %edx
	je	.L346
	jmp	.L347
	.p2align 4,,10
	.p2align 3
.L673:
	movq	32(%rbx), %rdi
	movl	$8, %ecx
	movl	%r15d, %edx
	movl	%r14d, %esi
	leaq	.LC24(%rip), %r8
	xorl	%r12d, %r12d
	call	error_at_location@PLT
	jmp	.L607
.L659:
	movl	40(%rsp), %ecx
	movq	%rax, 16(%rbx)
	addl	$1, %ecx
	movl	%ecx, 28(%rbx)
	movzbl	(%rdx), %edx
	testl	%edx, %edx
	je	.L338
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L699
	movl	40(%rsp), %r14d
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L338:
	movl	$28, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L677:
	movq	%rax, 16(%rbx)
	movl	40(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rsi), %eax
	testl	%eax, %eax
	jne	.L624
	jmp	.L302
.L652:
	cmpq	%r12, %r13
	jnb	.L362
	movzbl	(%rdx,%r13), %edx
	testl	%edx, %edx
	je	.L362
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L700
	movl	28(%rbx), %edx
	addl	$1, %edx
.L365:
	movl	%edx, 28(%rbx)
	movzbl	(%rcx), %edx
	testl	%edx, %edx
	je	.L362
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L701
	addl	$1, 28(%rbx)
.L362:
	movl	$23, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L641:
	movq	%rax, 16(%rbx)
	movl	40(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	jne	.L626
	jmp	.L316
.L282:
	leaq	2(%r13), %rcx
	cmpq	%r12, %rcx
	jnb	.L622
	cmpb	$61, 2(%rdx,%r13)
	movq	%rbx, %rdi
	jne	.L622
.L616:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$43, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L283:
	movl	40(%rsp), %ecx
	movq	%rax, 16(%rbx)
	addl	$1, %ecx
	movl	%ecx, 28(%rbx)
	movzbl	(%rdx), %edx
	testl	%edx, %edx
	je	.L370
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L702
	movl	40(%rsp), %r14d
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L370:
	movl	$25, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L690:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$55, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L661:
	movl	44(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L320
.L681:
	movl	44(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L318
.L680:
	movl	44(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L316
.L682:
	movl	44(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L324
.L683:
	movl	44(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L322
.L687:
	movl	44(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L302
.L694:
	movl	44(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L326
.L696:
	movl	44(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L256
.L695:
	movl	44(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L249
.L697:
	addl	$1, 24(%rbx)
	movq	%rax, %r13
	movl	$1, 28(%rbx)
	jmp	.L376
.L698:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L375
.L678:
	addl	$1, %r8d
	movl	$1, 28(%rbx)
	movl	%r8d, 24(%rbx)
	jmp	.L354
.L692:
	addl	$1, %r8d
	movl	$1, 28(%rbx)
	movl	%r8d, 24(%rbx)
	jmp	.L340
.L702:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L370
.L699:
	movl	44(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L338
.L701:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L362
.L700:
	addl	$1, 24(%rbx)
	movl	$1, %edx
	jmp	.L365
.L679:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$48, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L689:
	cmpl	$62, %r15d
	jne	.L703
	leaq	1(%r13), %rax
	cmpq	%r12, %rax
	jnb	.L380
	cmpb	$62, 1(%rdx,%r13)
	jne	.L288
	leaq	2(%r13), %rcx
	cmpq	%r12, %rcx
	jnb	.L609
	cmpb	$61, 2(%rdx,%r13)
	movq	%rbx, %rdi
	jne	.L609
.L615:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$44, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L691:
	movzbl	1(%rdx,%r13), %eax
	cmpb	$61, %al
	jne	.L295
	jmp	.L293
.L645:
	leaq	.LC8(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L157
.L305:
	cmpl	$33, %r10d
	jne	.L306
	cmpb	$61, 2(%rdx,%r13)
	jne	.L306
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$52, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L662:
	leaq	.LC8(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	16(%rbx), %r12
	movq	8(%rbx), %r14
	jmp	.L202
.L642:
	movq	(%rbx), %rdx
	jmp	.L344
.L693:
	cmpl	$62, %r10d
	je	.L329
	cmpl	$61, %r10d
	jne	.L306
	cmpb	$61, 2(%rdx,%r13)
	jne	.L306
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$51, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
	.p2align 4,,10
	.p2align 3
.L329:
	movzbl	2(%rdx,%r13), %eax
	movq	%rbx, %rdi
	cmpb	$62, %al
	je	.L615
	cmpb	$61, %al
	je	.L704
	call	lx_get
	call	lx_get
	movl	$49, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L704:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$50, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L612
.L649:
	leaq	.LC8(%rip), %rdi
	xorl	%eax, %eax
	movb	%cl, 8(%rsp)
	call	dief@PLT
	movq	(%rbx), %r8
	movzbl	8(%rsp), %ecx
	addq	%r13, %r8
	jmp	.L193
.L247:
	cmpl	$124, %r15d
	jne	.L292
	leaq	1(%r13), %rax
	cmpq	%r12, %rax
	jb	.L345
	movzbl	(%rdx,%r13), %edx
	testl	%edx, %edx
	je	.L346
	jmp	.L347
.L676:
	cmpl	$33, %r15d
	jne	.L254
	leaq	1(%r13), %rax
	cmpq	%r12, %rax
	jb	.L358
	jmp	.L360
	.cfi_endproc
.LFE22:
	.size	lx_next, .-lx_next
	.p2align 4
	.globl	tok_free
	.type	tok_free, @function
tok_free:
.LFB23:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	movq	8(%rdi), %rdi
	testq	%rdi, %rdi
	je	.L706
	movl	24(%rbx), %eax
	testl	%eax, %eax
	jne	.L711
.L706:
	movq	$0, 8(%rbx)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L711:
	.cfi_restore_state
	call	free@PLT
	movq	$0, 8(%rbx)
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	tok_free, .-tok_free
	.section	.rodata.str1.1
.LC31:
	.string	"EOF"
.LC32:
	.string	"identifier"
.LC33:
	.string	"number"
.LC34:
	.string	"string"
.LC35:
	.string	"character"
.LC36:
	.string	"if"
.LC37:
	.string	"("
.LC38:
	.string	")"
.LC39:
	.string	"{"
.LC40:
	.string	"}"
.LC41:
	.string	","
.LC42:
	.string	";"
.LC43:
	.string	"="
.LC44:
	.string	"=="
.LC45:
	.string	"!="
.LC46:
	.string	"<"
.LC47:
	.string	"<="
.LC48:
	.string	">"
.LC49:
	.string	">="
.LC50:
	.string	"<<"
.LC51:
	.string	">>"
.LC52:
	.string	"+"
.LC53:
	.string	"-"
.LC54:
	.string	"*"
.LC55:
	.string	"/"
.LC56:
	.string	"%"
.LC57:
	.string	"!"
.LC58:
	.string	"?"
.LC59:
	.string	"["
.LC60:
	.string	"]"
.LC61:
	.string	"++"
.LC62:
	.string	"--"
.LC63:
	.string	"=+"
.LC64:
	.string	"=-"
.LC65:
	.string	"=*"
.LC66:
	.string	"=/"
.LC67:
	.string	"=%"
.LC68:
	.string	"=<<"
.LC69:
	.string	"=>>"
.LC70:
	.string	"=&"
.LC71:
	.string	"=|"
.LC72:
	.string	"=<"
.LC73:
	.string	"=<="
.LC74:
	.string	"=>"
.LC75:
	.string	"=>="
.LC76:
	.string	"==="
.LC77:
	.string	"=!="
.LC78:
	.string	"&"
.LC79:
	.string	"|"
.LC80:
	.string	"||"
.LC81:
	.string	":"
.LC82:
	.string	"<unknown token>"
	.text
	.p2align 4
	.globl	tk_name
	.type	tk_name, @function
tk_name:
.LFB24:
	.cfi_startproc
	cmpl	$61, %edi
	ja	.L713
	leaq	.L715(%rip), %rdx
	movl	%edi, %edi
	movslq	(%rdx,%rdi,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L715:
	.long	.L776-.L715
	.long	.L777-.L715
	.long	.L774-.L715
	.long	.L773-.L715
	.long	.L772-.L715
	.long	.L771-.L715
	.long	.L770-.L715
	.long	.L769-.L715
	.long	.L768-.L715
	.long	.L767-.L715
	.long	.L766-.L715
	.long	.L765-.L715
	.long	.L764-.L715
	.long	.L763-.L715
	.long	.L762-.L715
	.long	.L761-.L715
	.long	.L760-.L715
	.long	.L759-.L715
	.long	.L758-.L715
	.long	.L757-.L715
	.long	.L756-.L715
	.long	.L755-.L715
	.long	.L754-.L715
	.long	.L753-.L715
	.long	.L752-.L715
	.long	.L751-.L715
	.long	.L750-.L715
	.long	.L749-.L715
	.long	.L748-.L715
	.long	.L747-.L715
	.long	.L746-.L715
	.long	.L745-.L715
	.long	.L744-.L715
	.long	.L743-.L715
	.long	.L742-.L715
	.long	.L741-.L715
	.long	.L740-.L715
	.long	.L739-.L715
	.long	.L738-.L715
	.long	.L737-.L715
	.long	.L736-.L715
	.long	.L735-.L715
	.long	.L734-.L715
	.long	.L733-.L715
	.long	.L732-.L715
	.long	.L731-.L715
	.long	.L730-.L715
	.long	.L729-.L715
	.long	.L728-.L715
	.long	.L727-.L715
	.long	.L726-.L715
	.long	.L725-.L715
	.long	.L724-.L715
	.long	.L723-.L715
	.long	.L722-.L715
	.long	.L721-.L715
	.long	.L720-.L715
	.long	.L719-.L715
	.long	.L718-.L715
	.long	.L717-.L715
	.long	.L716-.L715
	.long	.L714-.L715
	.text
	.p2align 4,,10
	.p2align 3
.L777:
	leaq	.LC32(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L776:
	leaq	.LC31(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L714:
	leaq	.LC19(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L731:
	leaq	.LC70(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L732:
	leaq	.LC69(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L733:
	leaq	.LC68(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L734:
	leaq	.LC67(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L735:
	leaq	.LC66(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L736:
	leaq	.LC65(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L737:
	leaq	.LC64(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L738:
	leaq	.LC63(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L739:
	leaq	.LC62(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L740:
	leaq	.LC61(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L741:
	leaq	.LC57(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L742:
	leaq	.LC56(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L743:
	leaq	.LC55(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L744:
	leaq	.LC54(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L745:
	leaq	.LC53(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L722:
	leaq	.LC79(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L723:
	leaq	.LC78(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L724:
	leaq	.LC77(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L725:
	leaq	.LC76(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L726:
	leaq	.LC75(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L727:
	leaq	.LC74(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L728:
	leaq	.LC73(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L729:
	leaq	.LC72(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L718:
	leaq	.LC16(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L719:
	leaq	.LC81(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L720:
	leaq	.LC58(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L721:
	leaq	.LC80(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L716:
	leaq	.LC18(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L730:
	leaq	.LC71(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L772:
	leaq	.LC35(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L773:
	leaq	.LC34(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L768:
	leaq	.LC11(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L769:
	leaq	.LC10(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L770:
	leaq	.LC36(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L771:
	leaq	.LC9(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L760:
	leaq	.LC40(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L761:
	leaq	.LC39(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L762:
	leaq	.LC38(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L763:
	leaq	.LC37(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L764:
	leaq	.LC13(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L765:
	leaq	.LC15(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L766:
	leaq	.LC14(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L767:
	leaq	.LC12(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L717:
	leaq	.LC17(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L774:
	leaq	.LC33(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L746:
	leaq	.LC52(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L747:
	leaq	.LC51(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L748:
	leaq	.LC50(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L749:
	leaq	.LC49(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L750:
	leaq	.LC48(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L751:
	leaq	.LC47(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L752:
	leaq	.LC46(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L753:
	leaq	.LC45(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L754:
	leaq	.LC44(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L755:
	leaq	.LC43(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L756:
	leaq	.LC60(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L757:
	leaq	.LC59(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L758:
	leaq	.LC42(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L759:
	leaq	.LC41(%rip), %rax
	ret
.L713:
	leaq	.LC82(%rip), %rax
	ret
	.cfi_endproc
.LFE24:
	.size	tk_name, .-tk_name
	.section	.note.GNU-stack,"",@progbits
