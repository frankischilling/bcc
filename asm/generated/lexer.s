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
	.section	.rodata.str1.1
.LC2:
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
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$64, %rsp
	.cfi_def_cfa_offset 112
	testb	$4, g_extensions(%rip)
	je	.L32
	movq	16(%rdi), %rax
	movq	%rdi, %rbx
	movl	%esi, %r13d
	movl	%edx, %r12d
	cmpq	8(%rdi), %rax
	jnb	.L33
	movq	(%rdi), %rdx
	movzbl	(%rdx,%rax), %ebp
	testl	%ebp, %ebp
	je	.L33
	addq	$1, %rax
	movq	%rax, 16(%rdi)
	cmpl	$10, %ebp
	je	.L52
	addl	$1, 28(%rdi)
	cmpb	$92, %bpl
	je	.L32
	jle	.L53
	cmpb	$114, %bpl
	je	.L42
	cmpb	$116, %bpl
	je	.L43
	cmpb	$110, %bpl
	jne	.L35
	movl	$10, %ebp
	jmp	.L31
	.p2align 4,,10
	.p2align 3
.L33:
	movq	32(%rbx), %rdi
	leaq	.LC0(%rip), %r8
	movl	%r12d, %edx
	xorl	%ebp, %ebp
	movl	$8, %ecx
	movl	%r13d, %esi
	call	error_at_location@PLT
.L35:
	movl	%ebp, %ecx
	leaq	.LC2(%rip), %rdx
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
.L32:
	.cfi_restore_state
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
.L53:
	.cfi_restore_state
	cmpb	$39, %bpl
	je	.L39
	cmpb	$48, %bpl
	je	.L40
	cmpb	$34, %bpl
	jne	.L35
	movl	$34, %ebp
	jmp	.L31
	.p2align 4,,10
	.p2align 3
.L52:
	addl	$1, 24(%rdi)
	movl	$1, 28(%rdi)
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L40:
	xorl	%ebp, %ebp
	jmp	.L31
	.p2align 4,,10
	.p2align 3
.L39:
	movl	$39, %ebp
	jmp	.L31
	.p2align 4,,10
	.p2align 3
.L43:
	movl	$9, %ebp
	jmp	.L31
	.p2align 4,,10
	.p2align 3
.L42:
	movl	$13, %ebp
	jmp	.L31
	.cfi_endproc
.LFE18:
	.size	parse_backslash_escape, .-parse_backslash_escape
	.section	.rodata.str1.1
.LC3:
	.string	"unterminated /* comment"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC4:
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
	leaq	.LC4(%rip), %r8
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
	leaq	.LC3(%rip), %r8
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
	.section	.rodata.str1.1
.LC5:
	.string	"NUL byte outside a literal"
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
	subq	$136, %rsp
	.cfi_def_cfa_offset 192
	call	lx_skip_ws_and_comments
	movq	24(%rbx), %rax
	movq	16(%rbx), %r13
	movq	8(%rbx), %r12
	movq	%rax, 8(%rsp)
	cmpq	%r12, %r13
	jnb	.L602
	movq	(%rbx), %rdx
	movq	%rax, %xmm0
	movl	%eax, 20(%rsp)
	pshufd	$0xe5, %xmm0, %xmm1
	movd	%xmm1, %r14d
	leaq	(%rdx,%r13), %rcx
	movzbl	(%rcx), %r15d
	testl	%r15d, %r15d
	je	.L608
	movq	%rdx, 40(%rsp)
	movq	%rcx, 24(%rsp)
	movb	%r15b, 32(%rsp)
	movq	%r13, 56(%rsp)
	movq	%r12, 48(%rsp)
	call	__ctype_b_loc@PLT
	movzbl	32(%rsp), %edi
	movq	24(%rsp), %rcx
	movq	(%rax), %rax
	movq	40(%rsp), %rdx
	movq	%rdi, %r9
	movzwl	(%rax,%rdi,2), %edi
	testw	$1024, %di
	jne	.L412
	cmpl	$95, %r15d
	movq	48(%rsp), %r10
	movq	56(%rsp), %rsi
	sete	%r8b
	cmpl	$8, %r15d
	sete	%r11b
	orb	%r11b, %r8b
	jne	.L412
	testw	$2048, %di
	je	.L162
	cmpl	$48, %r15d
	jne	.L427
	leaq	1(%r13), %rdi
	movq	%rdi, %rsi
	cmpq	%r12, %rdi
	jnb	.L164
	leaq	(%rdx,%rdi), %r10
	movzbl	(%r10), %r9d
	andl	$-33, %r9d
	cmpb	$88, %r9b
	je	.L609
.L164:
	movq	%rdi, 16(%rbx)
	leal	1(%r14), %r8d
	.p2align 4
	.p2align 3
.L180:
	movl	%r8d, 28(%rbx)
.L186:
	cmpq	%r12, %rsi
	jnb	.L184
	movzbl	(%rdx,%rsi), %edi
	movzbl	%dil, %r9d
	testb	$8, 1(%rax,%r9,2)
	je	.L595
	testl	%edi, %edi
	je	.L186
	addq	$1, %rsi
	addl	$1, %r8d
	movq	%rsi, 16(%rbx)
	cmpl	$10, %edi
	jne	.L180
	addl	$1, 24(%rbx)
	movl	$1, %r8d
	jmp	.L180
	.p2align 4,,10
	.p2align 3
.L608:
	movq	32(%rbx), %rdi
	movl	20(%rsp), %esi
	movl	$8, %ecx
	movl	%r14d, %edx
	leaq	.LC5(%rip), %r8
	call	error_at_location@PLT
.L602:
	movl	$0, 0(%rbp)
	movq	32(%rbx), %rax
.L601:
	movq	8(%rsp), %rcx
	movq	$0, 8(%rbp)
	movq	$0, 16(%rbp)
	movl	$0, 24(%rbp)
	movq	$0, 32(%rbp)
	movq	%rcx, 40(%rbp)
	movq	%rax, 48(%rbp)
.L137:
	addq	$136, %rsp
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
.L412:
	.cfi_restore_state
	movq	%r13, %r15
.L148:
	cmpq	%r12, %r15
	jnb	.L610
.L147:
	movzbl	(%rdx,%r15), %esi
	movzbl	%sil, %edi
	testb	$8, (%rax,%rdi,2)
	jne	.L150
	cmpb	$95, %sil
	je	.L152
	cmpb	$46, %sil
	je	.L152
	cmpb	$8, %sil
	jne	.L149
.L152:
	addq	$1, %r15
	movq	%r15, 16(%rbx)
.L144:
	movl	28(%rbx), %edi
	leal	1(%rdi), %esi
.L145:
	movl	%esi, 28(%rbx)
	cmpq	%r12, %r15
	jb	.L147
.L610:
	testb	$8, (%rax)
	jne	.L148
.L149:
	movl	g_strict(%rip), %r12d
	testl	%r12d, %r12d
	je	.L153
	movq	%r15, %rdx
	subq	%r13, %rdx
	cmpq	$8, %rdx
	ja	.L611
.L154:
	movl	$46, %esi
	movq	%rcx, %rdi
	call	memchr@PLT
	testq	%rax, %rax
	je	.L153
	movq	32(%rbx), %rdi
	movl	20(%rsp), %esi
	movl	$8, %ecx
	movl	%r14d, %edx
	leaq	.LC7(%rip), %r8
	call	error_at_location@PLT
	movq	16(%rbx), %r15
.L153:
	movq	g_compilation_arena(%rip), %rdi
	testq	%rdi, %rdi
	je	.L155
	movq	(%rbx), %rsi
	movq	%r13, %rdx
	movq	%r15, %rcx
	xorl	%r13d, %r13d
	call	arena_xstrdup_range@PLT
	movq	%rax, %r12
.L156:
	leaq	.LC9(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$5, %eax
	testl	%edx, %edx
	je	.L159
	cmpb	$105, (%r12)
	jne	.L438
	cmpb	$102, 1(%r12)
	je	.L612
.L438:
	leaq	.LC10(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$7, %eax
	testl	%edx, %edx
	je	.L159
	leaq	.LC11(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$8, %eax
	testl	%edx, %edx
	je	.L159
	leaq	.LC12(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$9, %eax
	testl	%edx, %edx
	je	.L159
	leaq	.LC13(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$12, %eax
	testl	%edx, %edx
	je	.L159
	movl	g_extensions(%rip), %r14d
	andl	$64, %r14d
	jne	.L613
.L161:
	leaq	.LC16(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$58, %eax
	testl	%edx, %edx
	je	.L159
	leaq	.LC17(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$59, %eax
	testl	%edx, %edx
	je	.L159
	leaq	.LC18(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$60, %eax
	testl	%edx, %edx
	je	.L159
	movl	$1, %eax
	testl	%r14d, %r14d
	je	.L159
	leaq	.LC19(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	cmpl	$1, %eax
	sbbl	%eax, %eax
	andl	$60, %eax
	addl	$1, %eax
	.p2align 4
	.p2align 3
.L159:
	movl	%eax, 0(%rbp)
	movq	32(%rbx), %rdx
	movq	8(%rsp), %rax
	movq	%r12, 8(%rbp)
	movq	$0, 16(%rbp)
	movl	%r13d, 24(%rbp)
	movq	$0, 32(%rbp)
	movq	%rax, 40(%rbp)
	movq	%rdx, 48(%rbp)
	jmp	.L137
	.p2align 4,,10
	.p2align 3
.L150:
	testl	%esi, %esi
	je	.L148
	addq	$1, %r15
	movq	%r15, 16(%rbx)
	cmpl	$10, %esi
	jne	.L144
	addl	$1, 24(%rbx)
	movl	$1, %esi
	jmp	.L145
	.p2align 4,,10
	.p2align 3
.L155:
	cmpq	%r15, %r13
	jnb	.L413
	subq	%r13, %r15
	leaq	1(%r15), %rdi
.L157:
	call	malloc@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L614
.L158:
	movq	(%rbx), %rsi
	movq	%r15, %rdx
	movq	%r12, %rdi
	addq	%r13, %rsi
	movl	$1, %r13d
	call	memcpy@PLT
	movb	$0, (%r12,%r15)
	jmp	.L156
	.p2align 4,,10
	.p2align 3
.L162:
	cmpl	$34, %r15d
	je	.L615
	cmpl	$39, %r15d
	je	.L616
	cmpl	$43, %r15d
	je	.L617
	cmpl	$45, %r15d
	je	.L252
	movl	24(%rbx), %r8d
	testb	$8, g_extensions(%rip)
	jne	.L253
	movl	g_pedantic(%rip), %ecx
	testl	%ecx, %ecx
	je	.L283
	cmpb	$47, %r9b
	jg	.L284
	cmpb	$36, %r9b
	jg	.L618
.L285:
	cmpl	$33, %r15d
	jne	.L338
	leaq	1(%r13), %rdi
	cmpq	%r12, %rdi
	jnb	.L338
.L352:
	leaq	(%rdx,%rdi), %rax
	cmpb	$61, (%rax)
	je	.L619
.L354:
	cmpq	%r12, %r13
	jb	.L338
.L353:
	movl	$35, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
	.p2align 4,,10
	.p2align 3
.L413:
	movl	$1, %edi
	xorl	%r15d, %r15d
	jmp	.L157
	.p2align 4,,10
	.p2align 3
.L612:
	cmpb	$0, 2(%r12)
	movl	$6, %eax
	je	.L159
	jmp	.L438
	.p2align 4,,10
	.p2align 3
.L427:
	movq	%r13, %rsi
	.p2align 4
	.p2align 3
.L192:
	cmpq	%r12, %rsi
	jnb	.L190
.L621:
	movzbl	(%rdx,%rsi), %edi
	movzbl	%dil, %r9d
	testb	$8, 1(%rax,%r9,2)
	je	.L594
	testl	%edi, %edi
	je	.L192
	addq	$1, %rsi
	movq	%rsi, 16(%rbx)
	cmpl	$10, %edi
	je	.L620
	movl	28(%rbx), %edi
	addl	$1, %edi
.L189:
	movl	%edi, 28(%rbx)
	cmpq	%r12, %rsi
	jb	.L621
.L190:
	testb	$8, 1(%rax)
	jne	.L192
.L594:
	movl	$10, %r12d
.L178:
	cmpq	%rsi, %r13
	jnb	.L428
	subq	%r13, %rsi
	movq	%rsi, %r15
	leaq	1(%rsi), %rdi
.L193:
	movq	%rcx, 40(%rsp)
	movb	%r8b, 24(%rsp)
	call	malloc@PLT
	movzbl	24(%rsp), %r8d
	movq	40(%rsp), %rcx
	testq	%rax, %rax
	movq	%rax, 32(%rsp)
	je	.L622
.L194:
	movq	32(%rsp), %r13
	movq	%r15, %rdx
	movq	%rcx, %rsi
	movb	%r8b, 24(%rsp)
	movq	%r13, %rdi
	call	memcpy@PLT
	movb	$0, 0(%r13,%r15)
	call	__errno_location@PLT
	movzbl	24(%rsp), %r8d
	movq	%rax, 40(%rsp)
	movl	$0, (%rax)
	testb	%r8b, %r8b
	je	.L195
	testq	%r15, %r15
	je	.L429
	leaq	(%r15,%r13), %r9
	movq	%rbp, 48(%rsp)
	xorl	%r12d, %r12d
	movq	%r9, %rbp
	jmp	.L198
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L197:
	leal	-48(%r15), %eax
	addq	$1, %r13
	leaq	(%rax,%r12,8), %r12
	cmpq	%rbp, %r13
	je	.L623
.L198:
	movsbl	0(%r13), %r15d
	movl	%r15d, %eax
	subl	$48, %eax
	cmpb	$9, %al
	jbe	.L197
	leaq	64(%rsp), %r8
	movl	%r15d, %ecx
	movl	$64, %esi
	xorl	%eax, %eax
	movq	%r8, %rdi
	leaq	.LC21(%rip), %rdx
	movq	%r8, 24(%rsp)
	call	snprintf@PLT
	movq	32(%rbx), %rdi
	movl	20(%rsp), %esi
	movl	%r14d, %edx
	movq	24(%rsp), %r8
	movl	$8, %ecx
	call	error_at_location@PLT
	jmp	.L197
	.p2align 4,,10
	.p2align 3
.L613:
	leaq	.LC14(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$10, %eax
	testl	%edx, %edx
	je	.L159
	leaq	.LC15(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$11, %eax
	testl	%edx, %edx
	jne	.L161
	jmp	.L159
	.p2align 4,,10
	.p2align 3
.L617:
	leaq	1(%rsi), %rdi
	cmpq	%r10, %rdi
	jnb	.L624
	leaq	(%rdx,%rdi), %rax
	cmpb	$43, (%rax)
	je	.L625
	testb	$8, g_extensions(%rip)
	jne	.L626
	movl	g_pedantic(%rip), %eax
	testl	%eax, %eax
	jne	.L403
.L338:
	movzbl	(%rdx,%rsi), %eax
	testl	%eax, %eax
	jne	.L627
.L375:
	subl	$33, %r9d
	cmpb	$92, %r9b
	ja	.L377
	leaq	.L379(%rip), %rdx
	movzbl	%r9b, %r9d
	movslq	(%rdx,%r9,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L379:
	.long	.L353-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L395-.L379
	.long	.L394-.L379
	.long	.L377-.L379
	.long	.L393-.L379
	.long	.L392-.L379
	.long	.L391-.L379
	.long	.L390-.L379
	.long	.L389-.L379
	.long	.L388-.L379
	.long	.L377-.L379
	.long	.L387-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L386-.L379
	.long	.L385-.L379
	.long	.L361-.L379
	.long	.L350-.L379
	.long	.L384-.L379
	.long	.L383-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L382-.L379
	.long	.L377-.L379
	.long	.L381-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L377-.L379
	.long	.L380-.L379
	.long	.L340-.L379
	.long	.L378-.L379
	.text
.L377:
	leaq	64(%rsp), %r12
	movl	%r15d, %ecx
	movl	$64, %esi
	xorl	%eax, %eax
	movq	%r12, %rdi
	leaq	.LC30(%rip), %rdx
	call	snprintf@PLT
	movq	32(%rbx), %rdi
	movl	20(%rsp), %esi
	movq	%r12, %r8
	movl	$8, %ecx
	movl	%r14d, %edx
	call	error_at_location@PLT
	jmp	.L602
.L378:
	movl	$16, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L380:
	movl	$15, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L381:
	movl	$20, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L382:
	movl	$19, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L383:
	movl	$56, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L663:
	movq	(%rbx), %rdx
	cmpb	$61, 1(%rdx,%r13)
	je	.L628
	cmpq	%r12, %r13
	jb	.L374
.L384:
	movl	$26, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L385:
	movl	$18, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L386:
	movl	$57, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L387:
	movl	$33, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L388:
	movl	$31, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L389:
	movl	$17, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L390:
	movl	$30, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L391:
	movl	$32, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L392:
	movl	$14, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L393:
	movl	$13, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L394:
	movl	$53, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L395:
	movl	$34, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
	.p2align 4,,10
	.p2align 3
.L184:
	testb	$8, 1(%rax)
	jne	.L186
.L595:
	movl	$1, %r8d
	movl	$8, %r12d
	jmp	.L178
	.p2align 4,,10
	.p2align 3
.L620:
	addl	$1, 24(%rbx)
	movl	$1, %edi
	jmp	.L189
	.p2align 4,,10
	.p2align 3
.L623:
	movq	48(%rsp), %rbp
	movq	%r12, %r15
.L199:
	movq	32(%rsp), %rdi
	call	free@PLT
	movq	40(%rsp), %rax
	movl	(%rax), %r9d
	testl	%r9d, %r9d
	jne	.L629
.L201:
	movq	32(%rbx), %rax
	movq	8(%rsp), %rcx
	movl	$2, 0(%rbp)
	movq	$0, 8(%rbp)
	movq	$0, 16(%rbp)
	movl	$0, 24(%rbp)
	movq	%r15, 32(%rbp)
	movq	%rcx, 40(%rbp)
	movq	%rax, 48(%rbp)
	jmp	.L137
	.p2align 4,,10
	.p2align 3
.L611:
	movq	32(%rbx), %rdi
	movl	20(%rsp), %esi
	movl	$8, %ecx
	movl	%r14d, %edx
	leaq	.LC6(%rip), %r8
	call	error_at_location@PLT
	movl	g_strict(%rip), %r11d
	movq	16(%rbx), %r15
	testl	%r11d, %r11d
	je	.L153
	movq	(%rbx), %rcx
	movq	%r15, %rdx
	subq	%r13, %rdx
	addq	%r13, %rcx
	jmp	.L154
	.p2align 4,,10
	.p2align 3
.L428:
	movl	$1, %edi
	xorl	%r15d, %r15d
	jmp	.L193
	.p2align 4,,10
	.p2align 3
.L195:
	movq	32(%rsp), %rdi
	xorl	%esi, %esi
	movl	%r12d, %edx
	call	strtoull@PLT
	movq	%rax, %r15
	movq	40(%rsp), %rax
	cmpl	$34, (%rax)
	jne	.L199
	movq	32(%rbx), %rdi
	movl	20(%rsp), %esi
	movl	$8, %ecx
	movl	%r14d, %edx
	leaq	.LC22(%rip), %r8
	call	error_at_location@PLT
	jmp	.L199
	.p2align 4,,10
	.p2align 3
.L629:
	movq	32(%rbx), %rdi
	movl	20(%rsp), %esi
	movl	$8, %ecx
	movl	%r14d, %edx
	leaq	.LC22(%rip), %r8
	call	error_at_location@PLT
	jmp	.L201
	.p2align 4,,10
	.p2align 3
.L252:
	leaq	1(%r13), %rdi
	cmpq	%r10, %rdi
	jnb	.L255
	leaq	(%rdx,%rdi), %rcx
	movzbl	(%rcx), %eax
	cmpb	$45, %al
	je	.L630
	testb	$8, g_extensions(%rip)
	je	.L631
	cmpb	$61, %al
	je	.L632
.L255:
	cmpq	%r10, %rsi
	jnb	.L375
	movq	(%rbx), %rdx
	jmp	.L338
	.p2align 4,,10
	.p2align 3
.L609:
	testb	$1, g_extensions(%rip)
	jne	.L165
	movl	g_pedantic(%rip), %r10d
	testl	%r10d, %r10d
	jne	.L633
	movq	%rdi, 16(%rbx)
.L168:
	addl	$1, 28(%rbx)
.L167:
	movl	$2, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L283:
	cmpl	$61, %r15d
	je	.L270
	cmpl	$60, %r15d
	jne	.L328
	leaq	1(%r13), %rdi
	cmpq	%r12, %rdi
	jnb	.L329
.L607:
	addq	%rdi, %rdx
	cmpb	$60, (%rdx)
	je	.L634
	cmpb	$61, (%rdx)
	je	.L276
	movl	$60, %eax
.L341:
	movq	%rdi, 16(%rbx)
	cmpl	$10, %eax
	jne	.L363
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L375
.L253:
	cmpl	$42, %r15d
	je	.L635
	cmpl	$47, %r15d
	jne	.L262
	leaq	1(%r13), %rdi
	cmpq	%r12, %rdi
	jnb	.L255
	cmpb	$61, 1(%rdx,%r13)
	jne	.L255
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$41, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
	.p2align 4,,10
	.p2align 3
.L615:
	leaq	1(%rsi), %r12
	leal	1(%r14), %eax
	movl	$1, %edi
	movq	%r10, 24(%rsp)
	movq	%r12, 16(%rbx)
	movl	%eax, 28(%rbx)
	call	malloc@PLT
	movq	24(%rsp), %r10
	testq	%rax, %rax
	movq	%rax, %r15
	je	.L636
.L203:
	xorl	%r13d, %r13d
	movl	$1, %r9d
	movq	%rbp, 32(%rsp)
	movq	%r13, %rax
	movl	%r14d, 24(%rsp)
	movq	%r15, %r13
	movq	%r9, %rbp
	movq	%rax, %r15
	jmp	.L217
	.p2align 4,,10
	.p2align 3
.L641:
	movq	(%rbx), %rcx
	movzbl	(%rcx,%r12), %eax
	movl	%eax, %r14d
	testl	%eax, %eax
	je	.L204
	addq	$1, %r12
	movq	%r12, 16(%rbx)
	cmpl	$10, %eax
	je	.L637
	addl	$1, 28(%rbx)
	cmpl	$34, %eax
	je	.L638
	cmpl	$42, %eax
	je	.L639
	cmpl	$92, %eax
	jne	.L206
	movl	24(%rsp), %edx
	movl	20(%rsp), %esi
	movq	%rbx, %rdi
	call	parse_backslash_escape
	movl	%eax, %r14d
	.p2align 4
	.p2align 3
.L206:
	leaq	2(%r15), %rax
	cmpq	%rax, %rbp
	jb	.L640
.L214:
	movq	16(%rbx), %r12
	movq	8(%rbx), %r10
	movb	%r14b, 0(%r13,%r15)
	addq	$1, %r15
.L217:
	cmpq	%r10, %r12
	jb	.L641
.L204:
	movq	32(%rbx), %rdi
	movl	24(%rsp), %edx
	movl	$8, %ecx
	xorl	%r14d, %r14d
	movl	20(%rsp), %esi
	leaq	.LC23(%rip), %r8
	call	error_at_location@PLT
	jmp	.L206
	.p2align 4,,10
	.p2align 3
.L639:
	movl	$42, %r14d
	cmpq	%r10, %r12
	jnb	.L206
	movzbl	(%rcx,%r12), %eax
	cmpb	$48, %al
	jg	.L210
	cmpb	$33, %al
	jle	.L206
	movabsq	$289738493788160, %rcx
	btq	%rax, %rcx
	jnc	.L206
.L212:
	movl	24(%rsp), %edx
	movl	20(%rsp), %esi
	movq	%rbx, %rdi
	call	parse_escape
	movl	%eax, %r14d
	jmp	.L206
	.p2align 4,,10
	.p2align 3
.L640:
	leaq	8(%rbp,%rbp), %rbp
	movq	%r13, %rdi
	movq	%rbp, %rsi
	call	realloc@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	jne	.L214
	leaq	.LC8(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L214
	.p2align 4,,10
	.p2align 3
.L637:
	addl	$1, 24(%rbx)
	movl	$10, %r14d
	movl	$1, 28(%rbx)
	jmp	.L206
.L616:
	addq	$1, %rsi
	leal	1(%r14), %eax
	movl	20(%rsp), %r15d
	xorl	%r13d, %r13d
	movq	%rsi, 16(%rbx)
	movl	%eax, 28(%rbx)
	movq	$0, 64(%rsp)
	movq	$0, 72(%rsp)
	cmpq	%r10, %rsi
	jnb	.L220
	.p2align 4
	.p2align 3
.L646:
	movq	(%rbx), %rax
	movzbl	(%rax,%rsi), %r12d
	testl	%r12d, %r12d
	je	.L220
	addq	$1, %rsi
	movq	%rsi, 16(%rbx)
	cmpl	$10, %r12d
	je	.L642
	addl	$1, 28(%rbx)
	cmpl	$39, %r12d
	je	.L643
	cmpq	$1, %r13
	jbe	.L230
	testb	$32, g_extensions(%rip)
	je	.L223
.L231:
	cmpq	$4, %r13
	je	.L644
.L230:
	cmpl	$42, %r12d
	je	.L645
	cmpl	$92, %r12d
	jne	.L596
	movl	%r14d, %edx
	movl	%r15d, %esi
	movq	%rbx, %rdi
	call	parse_backslash_escape
	movl	%eax, %r12d
.L596:
	movq	16(%rbx), %rsi
	movq	8(%rbx), %r10
.L222:
	movl	%r12d, 64(%rsp,%r13,4)
	addq	$1, %r13
	cmpq	%r10, %rsi
	jb	.L646
.L220:
	movq	32(%rbx), %rdi
	movl	$8, %ecx
	movl	%r14d, %edx
	movl	%r15d, %esi
	leaq	.LC25(%rip), %r8
	call	error_at_location@PLT
	cmpq	$1, %r13
	jbe	.L229
	testb	$32, g_extensions(%rip)
	je	.L433
	cmpq	$4, %r13
	je	.L647
.L229:
	movq	16(%rbx), %rsi
	movq	8(%rbx), %r10
	xorl	%r12d, %r12d
	jmp	.L222
.L645:
	movq	16(%rbx), %rsi
	movq	8(%rbx), %r10
	cmpq	%r10, %rsi
	jnb	.L222
	movq	(%rbx), %rdx
	movzbl	(%rdx,%rsi), %eax
	cmpb	$39, %al
	je	.L235
	jle	.L648
	cmpb	$116, %al
	jg	.L222
	cmpb	$100, %al
	jg	.L238
	cmpb	$42, %al
	jle	.L237
	cmpb	$48, %al
	jne	.L222
.L237:
	movl	%r15d, %esi
	movl	%r14d, %edx
	movq	%rbx, %rdi
	call	parse_escape
	movq	16(%rbx), %rsi
	movq	8(%rbx), %r10
	movl	%eax, %r12d
	jmp	.L222
.L643:
	testl	%r13d, %r13d
	je	.L649
	movslq	%r13d, %rax
	leaq	64(%rsp), %rdx
	leaq	(%rdx,%rax,4), %rsi
	xorl	%eax, %eax
	.p2align 5
	.p2align 4
	.p2align 3
.L243:
	movl	(%rdx), %ecx
	salq	$8, %rax
	addq	$4, %rdx
	orq	%rcx, %rax
	cmpq	%rdx, %rsi
	jne	.L243
.L242:
	movq	%rax, 32(%rbp)
	movq	32(%rbx), %rdx
	movq	8(%rsp), %rax
	movl	$4, 0(%rbp)
	movq	$0, 8(%rbp)
	movq	$0, 16(%rbp)
	movl	$0, 24(%rbp)
	movq	%rax, 40(%rbp)
	movq	%rdx, 48(%rbp)
	jmp	.L137
.L262:
	cmpl	$37, %r15d
	jne	.L263
	leaq	1(%r13), %rdi
	cmpq	%r12, %rdi
	jnb	.L255
	cmpb	$61, 1(%rdx,%r13)
	jne	.L255
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$42, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L679:
	cmpl	$61, %r15d
	jne	.L650
.L270:
	leaq	1(%r13), %rdi
	cmpq	%r12, %rdi
	jnb	.L293
	leaq	(%rdx,%rdi), %rcx
	movzbl	(%rcx), %r11d
	movl	%r11d, %eax
	cmpb	$43, %r11b
	je	.L651
	cmpb	$60, %r11b
	jg	.L297
	cmpb	$36, %r11b
	jle	.L298
	subl	$37, %eax
	cmpb	$23, %al
	ja	.L299
	leaq	.L301(%rip), %r10
	movzbl	%al, %eax
	movslq	(%r10,%rax,4), %rax
	addq	%r10, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L301:
	.long	.L306-.L301
	.long	.L305-.L301
	.long	.L299-.L301
	.long	.L299-.L301
	.long	.L299-.L301
	.long	.L304-.L301
	.long	.L299-.L301
	.long	.L299-.L301
	.long	.L303-.L301
	.long	.L299-.L301
	.long	.L302-.L301
	.long	.L299-.L301
	.long	.L299-.L301
	.long	.L299-.L301
	.long	.L299-.L301
	.long	.L299-.L301
	.long	.L299-.L301
	.long	.L299-.L301
	.long	.L299-.L301
	.long	.L299-.L301
	.long	.L299-.L301
	.long	.L299-.L301
	.long	.L299-.L301
	.long	.L300-.L301
	.text
.L299:
	cmpl	$61, %r11d
	je	.L652
.L324:
	cmpq	%r12, %rdi
	jnb	.L293
	cmpb	$61, (%rcx)
	jne	.L338
	leal	1(%r14), %eax
	movq	%rdi, 16(%rbx)
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L348
	addq	$1, %rdi
	movq	%rdi, 16(%rbx)
	cmpl	$10, %eax
	je	.L653
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L348:
	movl	$22, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L300:
	movzbl	2(%rdx,%r13), %eax
	movq	%rbx, %rdi
	cmpb	$60, %al
	je	.L605
	cmpb	$61, %al
	je	.L654
	call	lx_get
	call	lx_get
	movl	$47, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L302:
	leal	1(%r14), %eax
	movq	%rdi, 16(%rbx)
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L313
	addq	$2, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L655
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L313:
	movl	$41, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L303:
	leal	1(%r14), %eax
	movq	%rdi, 16(%rbx)
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L309
	addq	$2, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L656
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L309:
	movl	$39, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L304:
	leal	1(%r14), %eax
	movq	%rdi, 16(%rbx)
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L311
	addq	$2, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L657
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L311:
	movl	$40, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L305:
	leal	1(%r14), %eax
	movq	%rdi, 16(%rbx)
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L317
	addq	$2, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L658
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L317:
	movl	$45, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L306:
	leal	1(%r14), %eax
	movq	%rdi, 16(%rbx)
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L315
	addq	$2, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L659
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L315:
	movl	$42, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L624:
	testb	$8, g_extensions(%rip)
	jne	.L255
	movl	g_pedantic(%rip), %r8d
	testl	%r8d, %r8d
	je	.L338
	jmp	.L255
	.p2align 4,,10
	.p2align 3
.L210:
	subl	$101, %eax
	cmpb	$15, %al
	ja	.L206
	movl	$33281, %ecx
	btq	%rax, %rcx
	jc	.L212
	jmp	.L206
.L433:
	xorl	%r12d, %r12d
.L223:
	movq	32(%rbx), %rdi
	movl	$8, %ecx
	movl	%r14d, %edx
	movl	%r15d, %esi
	leaq	.LC26(%rip), %r8
	call	error_at_location@PLT
	jmp	.L231
.L165:
	movq	%rdi, 16(%rbx)
	leal	1(%r14), %edi
	movl	%edi, 28(%rbx)
	movzbl	(%r10), %edi
	testl	%edi, %edi
	je	.L179
	leaq	2(%r13), %rsi
	leal	2(%r14), %r9d
	movq	%rsi, 16(%rbx)
	cmpl	$10, %edi
	jne	.L171
	movl	20(%rsp), %edi
	movl	$1, %r9d
	addl	$1, %edi
	movl	%edi, 24(%rbx)
.L171:
	movl	%r9d, 28(%rbx)
	.p2align 4
	.p2align 3
.L179:
	cmpq	%r12, %rsi
	jnb	.L176
.L661:
	movzbl	(%rdx,%rsi), %edi
	movzbl	%dil, %r9d
	testb	$16, 1(%rax,%r9,2)
	je	.L593
	testl	%edi, %edi
	je	.L179
	addq	$1, %rsi
	movq	%rsi, 16(%rbx)
	cmpl	$10, %edi
	je	.L660
	movl	28(%rbx), %edi
	addl	$1, %edi
.L175:
	movl	%edi, 28(%rbx)
	cmpq	%r12, %rsi
	jb	.L661
.L176:
	testb	$16, 1(%rax)
	jne	.L179
.L593:
	movl	$16, %r12d
	jmp	.L178
.L660:
	addl	$1, 24(%rbx)
	movl	$1, %edi
	jmp	.L175
.L642:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	cmpq	$1, %r13
	jbe	.L222
	testb	$32, g_extensions(%rip)
	je	.L223
	cmpq	$4, %r13
	jne	.L222
	movq	32(%rbx), %rdi
	movl	$8, %ecx
	movl	%r14d, %edx
	movl	%r15d, %esi
	leaq	.LC24(%rip), %r8
	call	error_at_location@PLT
	jmp	.L596
	.p2align 4,,10
	.p2align 3
.L631:
	movl	g_pedantic(%rip), %edi
	testl	%edi, %edi
	je	.L255
.L403:
	cmpb	$61, 1(%rdx,%r13)
	jne	.L255
.L286:
	movl	20(%rsp), %esi
	movq	32(%rbx), %rdi
	movl	$8, %ecx
	movl	%r14d, %edx
	leaq	.LC28(%rip), %r8
	movb	%r9b, 24(%rsp)
	call	error_at_location@PLT
	movq	16(%rbx), %r13
	movq	8(%rbx), %r12
	cmpl	$124, %r15d
	movzbl	24(%rsp), %r9d
	movq	%r13, %rsi
	movq	%r12, %r10
	jne	.L246
	leaq	1(%r13), %rdi
	cmpq	%r12, %rdi
	jnb	.L266
	movq	(%rbx), %rdx
.L339:
	movzbl	(%rdx,%rdi), %eax
.L288:
	cmpb	$124, %al
	je	.L662
.L342:
	movq	%r13, %rsi
	movq	%r12, %r10
	jmp	.L255
.L329:
	addl	$1, 28(%rbx)
	movq	%rdi, 16(%rbx)
.L361:
	movl	$24, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L263:
	cmpl	$38, %r15d
	jne	.L264
	leaq	1(%r13), %rdi
	cmpq	%r12, %rdi
	jnb	.L255
	cmpb	$61, 1(%rdx,%r13)
	jne	.L255
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$45, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L638:
	movq	g_compilation_arena(%rip), %rdi
	movq	%r15, %rax
	movq	%r13, %r15
	movq	32(%rsp), %rbp
	movb	$0, (%r15,%rax)
	movq	%rax, %r13
	movl	$1, %eax
	testq	%rdi, %rdi
	je	.L218
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
.L218:
	movl	%eax, 24(%rbp)
	movq	32(%rbx), %rdx
	movq	8(%rsp), %rax
	movl	$3, 0(%rbp)
	movq	%r15, 8(%rbp)
	movq	%r13, 16(%rbp)
	movq	$0, 32(%rbp)
	movq	%rax, 40(%rbp)
	movq	%rdx, 48(%rbp)
	jmp	.L137
.L635:
	leaq	1(%r13), %rdi
	cmpq	%r12, %rdi
	jnb	.L255
	cmpb	$61, 1(%rdx,%r13)
	jne	.L255
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$40, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L429:
	xorl	%r15d, %r15d
	jmp	.L199
.L626:
	cmpb	$61, (%rdx,%rdi)
	jne	.L255
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$38, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L633:
	movq	32(%rbx), %rdi
	movl	20(%rsp), %esi
	movl	$8, %ecx
	movl	%r14d, %edx
	leaq	.LC20(%rip), %r8
	call	error_at_location@PLT
	movq	16(%rbx), %rax
	cmpq	8(%rbx), %rax
	jnb	.L167
	movq	(%rbx), %rdx
	movzbl	(%rdx,%rax), %edx
	testl	%edx, %edx
	je	.L167
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	jne	.L168
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L167
.L264:
	cmpl	$124, %r15d
	jne	.L265
	leaq	1(%r13), %rdi
	cmpq	%r12, %rdi
	jnb	.L266
	cmpb	$61, 1(%rdx,%r13)
	jne	.L339
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$46, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L618:
	movl	$1379, %eax
	salq	$37, %rax
	btq	%r9, %rax
	jnc	.L285
	leaq	1(%r13), %rdi
	cmpq	%r12, %rdi
	jnb	.L246
	cmpb	$61, 1(%rdx,%r13)
	je	.L286
.L246:
	cmpl	$62, %r15d
	jne	.L255
	leaq	1(%r13), %rdi
.L281:
	cmpq	%r12, %rdi
	jb	.L663
	cmpq	%r12, %r13
	jnb	.L384
	movq	(%rbx), %rdx
.L374:
	movzbl	(%rdx,%r13), %eax
	testl	%eax, %eax
	jne	.L341
	jmp	.L384
.L265:
	cmpl	$60, %r15d
	jne	.L664
	leaq	1(%r13), %rdi
	cmpq	%r12, %rdi
	jnb	.L329
	cmpb	$60, 1(%rdx,%r13)
	je	.L275
	addq	%rdi, %rdx
	cmpb	$61, (%rdx)
	je	.L276
	movq	%rdi, 16(%rbx)
.L363:
	addl	$1, 28(%rbx)
	jmp	.L375
.L662:
	testb	$16, g_extensions(%rip)
	jne	.L665
	movl	g_pedantic(%rip), %edx
	testl	%edx, %edx
	je	.L342
	movl	20(%rsp), %esi
	movq	32(%rbx), %rdi
	movl	$8, %ecx
	movl	%r14d, %edx
	leaq	.LC29(%rip), %r8
	movb	%r9b, 24(%rsp)
	call	error_at_location@PLT
	movq	16(%rbx), %rsi
	movq	8(%rbx), %r10
	movzbl	24(%rsp), %r9d
	jmp	.L255
.L649:
	movq	32(%rbx), %rdi
	movl	20(%rsp), %esi
	movl	$8, %ecx
	movl	%r14d, %edx
	leaq	.LC27(%rip), %r8
	call	error_at_location@PLT
	xorl	%eax, %eax
	jmp	.L242
.L284:
	cmpb	$124, %r9b
	jne	.L283
	leaq	1(%r13), %rax
	cmpq	%r12, %rax
	jb	.L666
	addl	$1, 28(%rbx)
	movq	%rax, 16(%rbx)
.L340:
	movl	$54, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L235:
	leaq	1(%rsi), %rax
	cmpq	%r10, %rax
	jnb	.L222
	cmpb	$39, 1(%rdx,%rsi)
	jne	.L222
	jmp	.L237
.L644:
	movq	32(%rbx), %rdi
	movl	$8, %ecx
	movl	%r14d, %edx
	movl	%r15d, %esi
	leaq	.LC24(%rip), %r8
	call	error_at_location@PLT
	jmp	.L230
.L293:
	addl	$1, 28(%rbx)
	movq	%rdi, 16(%rbx)
.L350:
	movl	$21, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L328:
	cmpl	$62, %r15d
	jne	.L248
	leaq	1(%r13), %rdi
	cmpq	%r12, %rdi
	jnb	.L374
.L598:
	addq	%rdi, %rdx
	cmpb	$62, (%rdx)
	jne	.L281
	leal	1(%r14), %eax
	movq	%rdi, 16(%rbx)
	movl	%eax, 28(%rbx)
	movzbl	(%rdx), %eax
	testl	%eax, %eax
	je	.L334
	addq	$1, %rdi
	movq	%rdi, 16(%rbx)
	cmpl	$10, %eax
	je	.L667
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L334:
	movl	$29, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L297:
	cmpb	$124, %r11b
	jne	.L668
	leal	1(%r14), %eax
	movq	%rdi, 16(%rbx)
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L319
	addq	$2, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L669
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L319:
	movl	$46, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L625:
	leal	1(%r14), %edx
	movq	%rdi, 16(%rbx)
	movl	%edx, 28(%rbx)
	movzbl	(%rax), %eax
	testl	%eax, %eax
	je	.L250
	addq	$2, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L670
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L250:
	movl	$36, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L648:
	cmpb	$34, %al
	jne	.L222
	jmp	.L237
.L630:
	leal	1(%r14), %eax
	movq	%rdi, 16(%rbx)
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L257
	addq	$2, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L671
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L257:
	movl	$37, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L238:
	subl	$101, %eax
	movl	$33281, %edx
	btq	%rax, %rdx
	jc	.L237
	jmp	.L222
.L628:
	cmpq	%r12, %r13
	jnb	.L369
	movzbl	(%rdx,%r13), %eax
	testl	%eax, %eax
	je	.L370
	movq	%rdi, 16(%rbx)
	cmpl	$10, %eax
	je	.L672
	addl	$1, 28(%rbx)
	movq	%rdi, %r13
.L370:
	movzbl	(%rdx,%r13), %eax
	testl	%eax, %eax
	je	.L369
	addq	$1, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L673
	addl	$1, 28(%rbx)
.L369:
	movl	$27, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L266:
	cmpq	%r12, %r13
	jnb	.L340
	movq	(%rbx), %rax
	movzbl	(%rax,%r13), %eax
	testl	%eax, %eax
	je	.L340
	jmp	.L341
	.p2align 4,,10
	.p2align 3
.L647:
	movq	32(%rbx), %rdi
	movl	$8, %ecx
	movl	%r14d, %edx
	movl	%r15d, %esi
	leaq	.LC24(%rip), %r8
	xorl	%r12d, %r12d
	call	error_at_location@PLT
	jmp	.L596
.L634:
	leal	1(%r14), %eax
	movq	%rdi, 16(%rbx)
	movl	%eax, 28(%rbx)
	movzbl	(%rdx), %eax
	testl	%eax, %eax
	je	.L332
	addq	$1, %rdi
	movq	%rdi, 16(%rbx)
	cmpl	$10, %eax
	je	.L674
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L332:
	movl	$28, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L651:
	leal	1(%r14), %eax
	movq	%rdi, 16(%rbx)
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L295
	addq	$2, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L675
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L295:
	movl	$38, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L652:
	cmpb	$61, 2(%rdx,%r13)
	jne	.L324
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$51, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
	.p2align 4,,10
	.p2align 3
.L619:
	cmpq	%r12, %r13
	jnb	.L356
	movzbl	(%rdx,%r13), %edx
	testl	%edx, %edx
	je	.L356
	movq	%rdi, 16(%rbx)
	cmpl	$10, %edx
	je	.L676
	movl	28(%rbx), %ecx
	leal	1(%rcx), %edx
.L359:
	movl	%edx, 28(%rbx)
	movzbl	(%rax), %eax
	testl	%eax, %eax
	je	.L356
	addq	$1, %rdi
	movq	%rdi, 16(%rbx)
	cmpl	$10, %eax
	je	.L677
	addl	$1, 28(%rbx)
.L356:
	movl	$23, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L632:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$39, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L275:
	leaq	2(%r13), %rax
	cmpq	%r12, %rax
	jnb	.L607
	cmpb	$61, 2(%rdx,%r13)
	jne	.L607
	movq	%rbx, %rdi
.L605:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$43, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L665:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$55, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L276:
	leal	1(%r14), %eax
	movq	%rdi, 16(%rbx)
	movl	%eax, 28(%rbx)
	movzbl	(%rdx), %eax
	testl	%eax, %eax
	je	.L364
	addq	$1, %rdi
	movq	%rdi, 16(%rbx)
	cmpl	$10, %eax
	je	.L678
	addl	$2, %r14d
	movl	%r14d, 28(%rbx)
.L364:
	movl	$25, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L669:
	movl	20(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L319
.L659:
	movl	20(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L315
.L671:
	movl	20(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L257
.L670:
	movl	20(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L250
.L675:
	movl	20(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L295
.L658:
	movl	20(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L317
.L657:
	movl	20(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L311
.L656:
	movl	20(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L309
.L655:
	movl	20(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L313
.L653:
	addl	$1, %r8d
	movl	$1, 28(%rbx)
	movl	%r8d, 24(%rbx)
	jmp	.L348
.L674:
	movl	20(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L332
.L677:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L356
.L676:
	addl	$1, 24(%rbx)
	movl	$1, %edx
	jmp	.L359
.L667:
	addl	$1, %r8d
	movl	$1, 28(%rbx)
	movl	%r8d, 24(%rbx)
	jmp	.L334
.L672:
	addl	$1, 24(%rbx)
	movq	%rdi, %r13
	movl	$1, 28(%rbx)
	jmp	.L370
.L678:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L364
.L673:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L369
.L664:
	cmpl	$62, %r15d
	jne	.L679
	leaq	1(%r13), %rdi
	cmpq	%r12, %rdi
	jnb	.L374
	cmpb	$62, 1(%rdx,%r13)
	jne	.L281
	leaq	2(%r13), %rax
	cmpq	%r12, %rax
	jnb	.L598
	cmpb	$61, 2(%rdx,%r13)
	jne	.L598
	movq	%rbx, %rdi
.L604:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$44, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L636:
	leaq	.LC8(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	16(%rbx), %r12
	movq	8(%rbx), %r10
	jmp	.L203
.L627:
	leaq	1(%rsi), %rdi
	jmp	.L341
.L666:
	movzbl	1(%rdx,%r13), %eax
	cmpb	$61, %al
	jne	.L288
	jmp	.L286
.L668:
	cmpl	$62, %r11d
	jne	.L299
	movzbl	2(%rdx,%r13), %eax
	movq	%rbx, %rdi
	cmpb	$62, %al
	je	.L604
	cmpb	$61, %al
	je	.L680
	call	lx_get
	call	lx_get
	movl	$49, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L680:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$50, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L248:
	cmpl	$124, %r15d
	jne	.L285
	leaq	1(%r13), %rdi
	cmpq	%r12, %rdi
	jb	.L339
	movzbl	(%rdx,%r13), %eax
	testl	%eax, %eax
	je	.L340
	jmp	.L341
.L298:
	cmpl	$33, %r11d
	jne	.L324
	cmpb	$61, 2(%rdx,%r13)
	jne	.L324
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$52, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L654:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$48, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L601
.L614:
	leaq	.LC8(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L158
.L622:
	leaq	.LC8(%rip), %rdi
	call	dief@PLT
	movq	(%rbx), %rcx
	movzbl	24(%rsp), %r8d
	addq	%r13, %rcx
	jmp	.L194
.L650:
	cmpl	$33, %r15d
	jne	.L255
	leaq	1(%r13), %rdi
	cmpq	%r12, %rdi
	jb	.L352
	jmp	.L354
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
	je	.L682
	movl	24(%rbx), %eax
	testl	%eax, %eax
	jne	.L687
.L682:
	movq	$0, 8(%rbx)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L687:
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
	ja	.L689
	leaq	.L691(%rip), %rdx
	movl	%edi, %edi
	movslq	(%rdx,%rdi,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L691:
	.long	.L752-.L691
	.long	.L753-.L691
	.long	.L750-.L691
	.long	.L749-.L691
	.long	.L748-.L691
	.long	.L747-.L691
	.long	.L746-.L691
	.long	.L745-.L691
	.long	.L744-.L691
	.long	.L743-.L691
	.long	.L742-.L691
	.long	.L741-.L691
	.long	.L740-.L691
	.long	.L739-.L691
	.long	.L738-.L691
	.long	.L737-.L691
	.long	.L736-.L691
	.long	.L735-.L691
	.long	.L734-.L691
	.long	.L733-.L691
	.long	.L732-.L691
	.long	.L731-.L691
	.long	.L730-.L691
	.long	.L729-.L691
	.long	.L728-.L691
	.long	.L727-.L691
	.long	.L726-.L691
	.long	.L725-.L691
	.long	.L724-.L691
	.long	.L723-.L691
	.long	.L722-.L691
	.long	.L721-.L691
	.long	.L720-.L691
	.long	.L719-.L691
	.long	.L718-.L691
	.long	.L717-.L691
	.long	.L716-.L691
	.long	.L715-.L691
	.long	.L714-.L691
	.long	.L713-.L691
	.long	.L712-.L691
	.long	.L711-.L691
	.long	.L710-.L691
	.long	.L709-.L691
	.long	.L708-.L691
	.long	.L707-.L691
	.long	.L706-.L691
	.long	.L705-.L691
	.long	.L704-.L691
	.long	.L703-.L691
	.long	.L702-.L691
	.long	.L701-.L691
	.long	.L700-.L691
	.long	.L699-.L691
	.long	.L698-.L691
	.long	.L697-.L691
	.long	.L696-.L691
	.long	.L695-.L691
	.long	.L694-.L691
	.long	.L693-.L691
	.long	.L692-.L691
	.long	.L690-.L691
	.text
	.p2align 4,,10
	.p2align 3
.L753:
	leaq	.LC32(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L752:
	leaq	.LC31(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L690:
	leaq	.LC19(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L707:
	leaq	.LC70(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L708:
	leaq	.LC69(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L709:
	leaq	.LC68(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L710:
	leaq	.LC67(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L711:
	leaq	.LC66(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L712:
	leaq	.LC65(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L713:
	leaq	.LC64(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L714:
	leaq	.LC63(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L715:
	leaq	.LC62(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L716:
	leaq	.LC61(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L717:
	leaq	.LC57(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L718:
	leaq	.LC56(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L719:
	leaq	.LC55(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L720:
	leaq	.LC54(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L721:
	leaq	.LC53(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L698:
	leaq	.LC79(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L699:
	leaq	.LC78(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L700:
	leaq	.LC77(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L701:
	leaq	.LC76(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L702:
	leaq	.LC75(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L703:
	leaq	.LC74(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L704:
	leaq	.LC73(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L705:
	leaq	.LC72(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L694:
	leaq	.LC16(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L695:
	leaq	.LC81(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L696:
	leaq	.LC58(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L697:
	leaq	.LC80(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L692:
	leaq	.LC18(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L706:
	leaq	.LC71(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L748:
	leaq	.LC35(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L749:
	leaq	.LC34(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L744:
	leaq	.LC11(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L745:
	leaq	.LC10(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L746:
	leaq	.LC36(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L747:
	leaq	.LC9(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L736:
	leaq	.LC40(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L737:
	leaq	.LC39(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L738:
	leaq	.LC38(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L739:
	leaq	.LC37(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L740:
	leaq	.LC13(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L741:
	leaq	.LC15(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L742:
	leaq	.LC14(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L743:
	leaq	.LC12(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L693:
	leaq	.LC17(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L750:
	leaq	.LC33(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L722:
	leaq	.LC52(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L723:
	leaq	.LC51(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L724:
	leaq	.LC50(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L725:
	leaq	.LC49(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L726:
	leaq	.LC48(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L727:
	leaq	.LC47(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L728:
	leaq	.LC46(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L729:
	leaq	.LC45(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L730:
	leaq	.LC44(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L731:
	leaq	.LC43(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L732:
	leaq	.LC60(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L733:
	leaq	.LC59(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L734:
	leaq	.LC42(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L735:
	leaq	.LC41(%rip), %rax
	ret
.L689:
	leaq	.LC82(%rip), %rax
	ret
	.cfi_endproc
.LFE24:
	.size	tk_name, .-tk_name
	.section	.note.GNU-stack,"",@progbits
