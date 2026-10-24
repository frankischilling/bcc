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
	.string	"backslash escapes are not allowed in strict B mode (use --extensions or *-escapes)"
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
	.string	"// comments are not allowed in strict B mode (use --extensions or /* */)"
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
	.section	.rodata.str1.1
.LC6:
	.string	"out of memory"
.LC7:
	.string	"auto"
.LC8:
	.string	"else"
.LC9:
	.string	"while"
.LC10:
	.string	"return"
.LC11:
	.string	"extrn"
.LC12:
	.string	"break"
.LC13:
	.string	"continue"
.LC14:
	.string	"goto"
.LC15:
	.string	"switch"
.LC16:
	.string	"case"
.LC17:
	.string	"default"
	.section	.rodata.str1.8
	.align 8
.LC18:
	.string	"hexadecimal literals are not allowed in strict B mode (use --extensions or octal)"
	.section	.rodata.str1.1
.LC19:
	.string	"bad octal digit '%c'"
.LC20:
	.string	"bad number"
.LC21:
	.string	"unterminated string"
.LC22:
	.string	"character constant too long"
	.section	.rodata.str1.8
	.align 8
.LC23:
	.string	"unterminated character constant"
	.align 8
.LC24:
	.string	"character constants longer than 2 bytes are not allowed in strict B72 mode"
	.align 8
.LC25:
	.string	"C-style compound assignments (op=) are not allowed in strict B mode (use =op)"
	.align 8
.LC26:
	.string	"|| is not part of Thompson B72 (use | or a conditional expression)"
	.section	.rodata.str1.1
.LC27:
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
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$136, %rsp
	.cfi_def_cfa_offset 192
	movq	%rdi, 16(%rsp)
	movq	%rsi, %rdi
	call	lx_skip_ws_and_comments
	movq	16(%rbx), %rdx
	movq	8(%rbx), %r15
	movq	24(%rbx), %rax
	movq	16(%rsp), %r9
	cmpq	%r15, %rdx
	movq	%rax, 8(%rsp)
	jnb	.L138
	movq	(%rbx), %rdi
	leaq	(%rdi,%rdx), %rsi
	movzbl	(%rsi), %ebp
	movl	%ebp, %r12d
	testl	%ebp, %ebp
	je	.L138
	movq	%rdi, 56(%rsp)
	movq	%rdx, 48(%rsp)
	movq	%r9, 40(%rsp)
	movq	%rdx, 32(%rsp)
	movq	%rsi, 16(%rsp)
	movq	%r15, 24(%rsp)
	call	__ctype_b_loc@PLT
	movq	16(%rsp), %rsi
	movq	24(%rsp), %r10
	movq	(%rax), %r8
	movzbl	%bpl, %eax
	movq	32(%rsp), %r11
	movq	40(%rsp), %r9
	movq	48(%rsp), %rdx
	movzwl	(%r8,%rax,2), %eax
	movq	56(%rsp), %rdi
	movl	%eax, %ecx
	shrw	$10, %cx
	andl	$1, %ecx
	cmpl	$95, %ebp
	sete	%r13b
	orb	%r13b, %cl
	je	.L580
	movq	%rdx, %rcx
.L147:
	cmpq	%r15, %rcx
	jnb	.L618
.L146:
	movzbl	(%rdi,%rcx), %eax
	movzbl	%al, %r10d
	testb	$8, (%r8,%r10,2)
	jne	.L149
	cmpb	$95, %al
	je	.L151
	cmpb	$46, %al
	jne	.L619
.L151:
	addq	$1, %rcx
	movq	%rcx, 16(%rbx)
.L144:
	movl	28(%rbx), %eax
	addl	$1, %eax
.L145:
	movl	%eax, 28(%rbx)
	cmpq	%r15, %rcx
	jb	.L146
.L618:
	testb	$8, (%r8)
	jne	.L147
	movq	g_compilation_arena(%rip), %rax
	testq	%rax, %rax
	je	.L407
.L406:
	movq	%rdi, %rsi
	movq	%rax, %rdi
	movq	%r9, 16(%rsp)
	xorl	%ebp, %ebp
	call	arena_xstrdup_range@PLT
	movq	16(%rsp), %r9
	movq	%rax, %r12
.L153:
	leaq	.LC7(%rip), %rsi
	movq	%r12, %rdi
	movq	%r9, 16(%rsp)
	call	strcmp@PLT
	movq	16(%rsp), %r9
	movl	%eax, %edx
	movl	$5, %eax
	testl	%edx, %edx
	je	.L156
	cmpb	$105, (%r12)
	jne	.L440
	cmpb	$102, 1(%r12)
	je	.L620
.L440:
	leaq	.LC8(%rip), %rsi
	movq	%r12, %rdi
	movq	%r9, 16(%rsp)
	call	strcmp@PLT
	movq	16(%rsp), %r9
	movl	%eax, %edx
	movl	$7, %eax
	testl	%edx, %edx
	je	.L156
	leaq	.LC9(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movq	16(%rsp), %r9
	movl	%eax, %edx
	movl	$8, %eax
	testl	%edx, %edx
	je	.L156
	leaq	.LC10(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movq	16(%rsp), %r9
	movl	%eax, %edx
	movl	$9, %eax
	testl	%edx, %edx
	je	.L156
	leaq	.LC11(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movq	16(%rsp), %r9
	movl	%eax, %edx
	movl	$12, %eax
	testl	%edx, %edx
	je	.L156
	movl	g_extensions(%rip), %r13d
	andl	$64, %r13d
	je	.L158
	leaq	.LC12(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movq	16(%rsp), %r9
	movl	%eax, %edx
	movl	$10, %eax
	testl	%edx, %edx
	je	.L156
	leaq	.LC13(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movq	16(%rsp), %r9
	movl	%eax, %edx
	movl	$11, %eax
	testl	%edx, %edx
	je	.L156
.L158:
	leaq	.LC14(%rip), %rsi
	movq	%r12, %rdi
	movq	%r9, 16(%rsp)
	call	strcmp@PLT
	movq	16(%rsp), %r9
	movl	%eax, %edx
	movl	$58, %eax
	testl	%edx, %edx
	je	.L156
	leaq	.LC15(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movq	16(%rsp), %r9
	movl	%eax, %edx
	movl	$59, %eax
	testl	%edx, %edx
	je	.L156
	leaq	.LC16(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movq	16(%rsp), %r9
	movl	%eax, %edx
	movl	$60, %eax
	testl	%edx, %edx
	je	.L156
	movl	$1, %eax
	testl	%r13d, %r13d
	je	.L156
	leaq	.LC17(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movq	16(%rsp), %r9
	cmpl	$1, %eax
	sbbl	%eax, %eax
	andl	$60, %eax
	addl	$1, %eax
	.p2align 4
	.p2align 3
.L156:
	movl	%eax, (%r9)
	movq	32(%rbx), %rdx
	movq	8(%rsp), %rax
	movq	%r12, 8(%r9)
	movq	$0, 16(%r9)
	movl	%ebp, 24(%r9)
	movq	$0, 32(%r9)
	movq	%rax, 40(%r9)
	movq	%rdx, 48(%r9)
	jmp	.L137
	.p2align 4,,10
	.p2align 3
.L138:
	movq	32(%rbx), %rax
	movq	8(%rsp), %rcx
	movl	$0, (%r9)
	movq	$0, 8(%r9)
	movq	$0, 16(%r9)
	movl	$0, 24(%r9)
	movq	$0, 32(%r9)
	movq	%rcx, 40(%r9)
	movq	%rax, 48(%r9)
.L137:
	addq	$136, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r9, %rax
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
.L580:
	.cfi_restore_state
	movq	8(%rsp), %xmm0
	pshufd	$0xe5, %xmm0, %xmm1
	movd	%xmm0, 16(%rsp)
	movd	%xmm1, %r13d
	testb	$8, %ah
	jne	.L621
	cmpl	$34, %ebp
	je	.L622
	cmpl	$39, %ebp
	je	.L623
	cmpl	$43, %ebp
	je	.L624
	cmpl	$45, %ebp
	jne	.L625
	leaq	1(%rdx), %rax
	cmpq	%r10, %rax
	jnb	.L249
	leaq	(%rdi,%rax), %rsi
	movzbl	(%rsi), %ecx
	cmpb	$45, %cl
	je	.L626
	testb	$8, g_extensions(%rip)
	je	.L627
	cmpb	$61, %cl
	je	.L628
.L249:
	cmpq	%r10, %r11
	jb	.L629
	.p2align 4
	.p2align 3
.L376:
	subl	$33, %r12d
	cmpb	$92, %r12b
	ja	.L378
	leaq	.L380(%rip), %rdx
	movzbl	%r12b, %r12d
	movslq	(%rdx,%r12,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L380:
	.long	.L354-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L396-.L380
	.long	.L395-.L380
	.long	.L378-.L380
	.long	.L394-.L380
	.long	.L393-.L380
	.long	.L392-.L380
	.long	.L391-.L380
	.long	.L390-.L380
	.long	.L389-.L380
	.long	.L378-.L380
	.long	.L388-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L387-.L380
	.long	.L386-.L380
	.long	.L362-.L380
	.long	.L351-.L380
	.long	.L385-.L380
	.long	.L384-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L383-.L380
	.long	.L378-.L380
	.long	.L382-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L378-.L380
	.long	.L381-.L380
	.long	.L341-.L380
	.long	.L379-.L380
	.text
	.p2align 4,,10
	.p2align 3
.L621:
	cmpl	$48, %ebp
	jne	.L429
	leaq	1(%rdx), %rbp
	cmpq	%r15, %rbp
	jnb	.L161
	leaq	(%rdi,%rbp), %r10
	movzbl	(%r10), %eax
	andl	$-33, %eax
	cmpb	$88, %al
	je	.L630
.L161:
	movq	%rbp, 16(%rbx)
	leal	1(%r13), %ecx
	.p2align 4
	.p2align 3
.L177:
	movl	%ecx, 28(%rbx)
.L183:
	cmpq	%r15, %rbp
	jnb	.L181
	movzbl	(%rdi,%rbp), %eax
	movzbl	%al, %r10d
	testb	$8, 1(%r8,%r10,2)
	je	.L601
	testl	%eax, %eax
	je	.L183
	addq	$1, %rbp
	addl	$1, %ecx
	movq	%rbp, 16(%rbx)
	cmpl	$10, %eax
	jne	.L177
	addl	$1, 24(%rbx)
	movl	$1, %ecx
	jmp	.L177
	.p2align 4,,10
	.p2align 3
.L149:
	testl	%eax, %eax
	je	.L147
	addq	$1, %rcx
	movq	%rcx, 16(%rbx)
	cmpl	$10, %eax
	jne	.L144
	addl	$1, 24(%rbx)
	movl	$1, %eax
	jmp	.L145
	.p2align 4,,10
	.p2align 3
.L429:
	movq	%rdx, %rbp
	.p2align 4
	.p2align 3
.L189:
	cmpq	%r15, %rbp
	jnb	.L187
.L632:
	movzbl	(%rdi,%rbp), %eax
	movzbl	%al, %r10d
	testb	$8, 1(%r8,%r10,2)
	je	.L600
	testl	%eax, %eax
	je	.L189
	addq	$1, %rbp
	movq	%rbp, 16(%rbx)
	cmpl	$10, %eax
	je	.L631
	movl	28(%rbx), %eax
	addl	$1, %eax
.L186:
	movl	%eax, 28(%rbx)
	cmpq	%r15, %rbp
	jb	.L632
.L187:
	testb	$8, 1(%r8)
	jne	.L189
.L600:
	movl	$10, %r14d
.L175:
	cmpq	%rbp, %rdx
	jb	.L633
	movl	$1, %edi
	xorl	%ebp, %ebp
.L190:
	movq	%rdx, 48(%rsp)
	movq	%r9, 40(%rsp)
	movb	%cl, 32(%rsp)
	movq	%rsi, 24(%rsp)
	call	malloc@PLT
	movq	24(%rsp), %rsi
	movzbl	32(%rsp), %ecx
	testq	%rax, %rax
	movq	40(%rsp), %r9
	movq	48(%rsp), %rdx
	movq	%rax, %r12
	je	.L634
.L191:
	movq	%rbp, %rdx
	movq	%r12, %rdi
	movq	%r9, 40(%rsp)
	movb	%cl, 24(%rsp)
	call	memcpy@PLT
	movb	$0, (%r12,%rbp)
	call	__errno_location@PLT
	movzbl	24(%rsp), %ecx
	movq	40(%rsp), %r9
	movq	%rax, 32(%rsp)
	testb	%cl, %cl
	movl	$0, (%rax)
	je	.L192
	testq	%rbp, %rbp
	je	.L431
	movq	%r12, %r10
	leaq	0(%rbp,%r12), %r15
	xorl	%ebp, %ebp
	movq	%r12, 40(%rsp)
	movl	%r13d, 24(%rsp)
	movq	%rbp, %r12
	movq	%r10, %rbp
	movq	%r9, 48(%rsp)
	jmp	.L195
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L194:
	subl	$48, %r14d
	addq	$1, %rbp
	movslq	%r14d, %r14
	leaq	(%r14,%r12,8), %r12
	cmpq	%rbp, %r15
	je	.L635
.L195:
	movsbl	0(%rbp), %r14d
	movl	%r14d, %eax
	subl	$48, %eax
	cmpb	$9, %al
	jbe	.L194
	leaq	64(%rsp), %r13
	movl	%r14d, %ecx
	movl	$64, %esi
	xorl	%eax, %eax
	movq	%r13, %rdi
	leaq	.LC19(%rip), %rdx
	call	snprintf@PLT
	movq	32(%rbx), %rdi
	movl	24(%rsp), %edx
	movq	%r13, %r8
	movl	16(%rsp), %esi
	movl	$8, %ecx
	call	error_at_location@PLT
	jmp	.L194
	.p2align 4,,10
	.p2align 3
.L631:
	addl	$1, 24(%rbx)
	movl	$1, %eax
	jmp	.L186
	.p2align 4,,10
	.p2align 3
.L407:
	subq	%rdx, %rcx
	movq	%rcx, %rbp
	leaq	1(%rcx), %rdi
.L154:
	movq	%rdx, 32(%rsp)
	movq	%r9, 24(%rsp)
	movq	%rsi, 16(%rsp)
	call	malloc@PLT
	movq	16(%rsp), %rsi
	movq	24(%rsp), %r9
	testq	%rax, %rax
	movq	32(%rsp), %rdx
	movq	%rax, %r12
	je	.L636
.L155:
	movq	%rbp, %rdx
	movq	%r12, %rdi
	movq	%r9, 16(%rsp)
	call	memcpy@PLT
	movb	$0, (%r12,%rbp)
	movq	16(%rsp), %r9
	movl	$1, %ebp
	jmp	.L153
	.p2align 4,,10
	.p2align 3
.L633:
	subq	%rdx, %rbp
	leaq	1(%rbp), %rdi
	jmp	.L190
	.p2align 4,,10
	.p2align 3
.L620:
	cmpb	$0, 2(%r12)
	movl	$6, %eax
	je	.L156
	jmp	.L440
	.p2align 4,,10
	.p2align 3
.L625:
	movl	24(%rbx), %esi
	testb	$8, g_extensions(%rip)
	jne	.L247
	movl	g_pedantic(%rip), %r8d
	testl	%r8d, %r8d
	je	.L285
	cmpb	$47, %bpl
	jg	.L286
	cmpb	$36, %bpl
	jg	.L637
.L287:
	cmpl	$33, %ebp
	jne	.L339
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L339
.L353:
	leaq	(%rdi,%rax), %rcx
	cmpb	$61, (%rcx)
	je	.L638
.L355:
	cmpq	%r15, %rdx
	jb	.L339
.L354:
	movl	$35, (%r9)
	movq	32(%rbx), %rax
	.p2align 4
	.p2align 3
.L607:
	movq	8(%rsp), %rdx
	movq	$0, 8(%r9)
	movq	$0, 16(%r9)
	movl	$0, 24(%r9)
	movq	$0, 32(%r9)
	movq	%rdx, 40(%r9)
	movq	%rax, 48(%r9)
	jmp	.L137
	.p2align 4,,10
	.p2align 3
.L378:
	leaq	64(%rsp), %r12
	movl	%ebp, %ecx
	leaq	.LC27(%rip), %rdx
	xorl	%eax, %eax
	movl	$64, %esi
	movq	%r12, %rdi
	movq	%r9, 24(%rsp)
	call	snprintf@PLT
	movq	32(%rbx), %rdi
	movl	16(%rsp), %esi
	movq	%r12, %r8
	movl	$8, %ecx
	movl	%r13d, %edx
	call	error_at_location@PLT
	movq	24(%rsp), %r9
	movq	32(%rbx), %rax
	movl	$0, (%r9)
	jmp	.L607
.L396:
	movl	$34, (%r9)
	movq	32(%rbx), %rax
	.p2align 4
	.p2align 3
.L608:
	movq	8(%rsp), %rsi
	movq	$0, 8(%r9)
	movq	$0, 16(%r9)
	movl	$0, 24(%r9)
	movq	$0, 32(%r9)
	movq	%rsi, 40(%r9)
	movq	%rax, 48(%r9)
	jmp	.L137
.L392:
	movl	$32, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L393:
	movl	$14, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L394:
	movl	$13, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L395:
	movl	$53, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L386:
	movl	$18, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L387:
	movl	$57, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L388:
	movl	$33, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L389:
	movl	$31, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L390:
	movl	$17, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L391:
	movl	$30, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L379:
	movl	$16, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L381:
	movl	$15, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L382:
	movl	$20, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L383:
	movl	$19, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L384:
	movl	$56, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L675:
	movq	(%rbx), %rdi
	cmpb	$61, 1(%rdi,%rdx)
	je	.L639
	cmpq	%r15, %rdx
	jb	.L375
.L385:
	movl	$26, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
	.p2align 4,,10
	.p2align 3
.L181:
	testb	$8, 1(%r8)
	jne	.L183
.L601:
	movl	$1, %ecx
	movl	$8, %r14d
	jmp	.L175
	.p2align 4,,10
	.p2align 3
.L635:
	movq	%r12, %rbp
	movl	24(%rsp), %r13d
	movq	40(%rsp), %r12
	movq	48(%rsp), %r9
.L193:
	movq	%r12, %rdi
	movq	%r9, 24(%rsp)
	call	free@PLT
	movq	32(%rsp), %rax
	movq	24(%rsp), %r9
	movl	(%rax), %eax
	testl	%eax, %eax
	jne	.L640
.L197:
	movq	32(%rbx), %rax
	movq	8(%rsp), %rdx
	movl	$2, (%r9)
	movq	$0, 8(%r9)
	movq	$0, 16(%r9)
	movl	$0, 24(%r9)
	movq	%rbp, 32(%r9)
	movq	%rdx, 40(%r9)
	movq	%rax, 48(%r9)
	jmp	.L137
	.p2align 4,,10
	.p2align 3
.L192:
	xorl	%esi, %esi
	movl	%r14d, %edx
	movq	%r12, %rdi
	movq	%r9, 24(%rsp)
	call	strtoull@PLT
	movq	24(%rsp), %r9
	movq	%rax, %rbp
	movq	32(%rsp), %rax
	cmpl	$34, (%rax)
	jne	.L193
	movq	32(%rbx), %rdi
	movl	16(%rsp), %esi
	movl	$8, %ecx
	movl	%r13d, %edx
	leaq	.LC20(%rip), %r8
	call	error_at_location@PLT
	movq	24(%rsp), %r9
	jmp	.L193
	.p2align 4,,10
	.p2align 3
.L640:
	movq	32(%rbx), %rdi
	movl	16(%rsp), %esi
	movl	$8, %ecx
	movl	%r13d, %edx
	leaq	.LC20(%rip), %r8
	call	error_at_location@PLT
	movq	24(%rsp), %r9
	jmp	.L197
	.p2align 4,,10
	.p2align 3
.L624:
	leaq	1(%r11), %rax
	cmpq	%r10, %rax
	jnb	.L641
	leaq	(%rdi,%rax), %rcx
	cmpb	$43, (%rcx)
	je	.L642
	testb	$8, g_extensions(%rip)
	jne	.L643
	movl	g_pedantic(%rip), %eax
	testl	%eax, %eax
	jne	.L404
.L339:
	movzbl	(%rdi,%r11), %edx
	testl	%edx, %edx
	je	.L376
	leaq	1(%r11), %rax
	.p2align 4
	.p2align 3
.L342:
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	jne	.L364
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L376
	.p2align 4,,10
	.p2align 3
.L630:
	testb	$1, g_extensions(%rip)
	jne	.L162
	movl	g_pedantic(%rip), %eax
	testl	%eax, %eax
	jne	.L644
	movq	%rbp, 16(%rbx)
.L165:
	addl	$1, 28(%rbx)
.L164:
	movl	$2, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L285:
	cmpl	$61, %ebp
	je	.L272
	cmpl	$60, %ebp
	jne	.L329
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L330
.L613:
	addq	%rax, %rdi
	cmpb	$60, (%rdi)
	je	.L645
	cmpb	$61, (%rdi)
	je	.L278
	movl	$60, %edx
	jmp	.L342
	.p2align 4,,10
	.p2align 3
.L247:
	cmpl	$42, %ebp
	je	.L646
	cmpl	$47, %ebp
	jne	.L262
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L249
	addq	%rax, %rdi
	cmpb	$61, (%rdi)
	jne	.L249
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rdi), %eax
	testl	%eax, %eax
	je	.L263
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L647
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L263:
	movl	$41, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
	.p2align 4,,10
	.p2align 3
.L622:
	leaq	1(%r11), %rbp
	leal	1(%r13), %eax
	movl	$1, %edi
	movq	%r9, 32(%rsp)
	movq	%rbp, 16(%rbx)
	movl	%eax, 28(%rbx)
	movq	%r10, 24(%rsp)
	call	malloc@PLT
	movq	24(%rsp), %r10
	movq	32(%rsp), %r9
	testq	%rax, %rax
	movq	%rax, %r15
	je	.L648
.L199:
	xorl	%r12d, %r12d
	movl	%r13d, 24(%rsp)
	movl	$1, %r14d
	movq	%r12, %rax
	movq	%r9, 32(%rsp)
	movq	%r15, %r12
	movq	%rax, %r15
	jmp	.L213
	.p2align 4,,10
	.p2align 3
.L653:
	movq	(%rbx), %rcx
	movzbl	(%rcx,%rbp), %eax
	movl	%eax, %r13d
	testl	%eax, %eax
	je	.L200
	addq	$1, %rbp
	movq	%rbp, 16(%rbx)
	cmpl	$10, %eax
	je	.L649
	addl	$1, 28(%rbx)
	cmpl	$34, %eax
	je	.L650
	cmpl	$42, %eax
	je	.L651
	cmpl	$92, %eax
	jne	.L202
	movl	24(%rsp), %edx
	movl	16(%rsp), %esi
	movq	%rbx, %rdi
	call	parse_backslash_escape
	movl	%eax, %r13d
	.p2align 4
	.p2align 3
.L202:
	leaq	2(%r15), %rax
	cmpq	%rax, %r14
	jb	.L652
.L210:
	movq	16(%rbx), %rbp
	movq	8(%rbx), %r10
	movb	%r13b, (%r12,%r15)
	addq	$1, %r15
.L213:
	cmpq	%r10, %rbp
	jb	.L653
.L200:
	movq	32(%rbx), %rdi
	movl	24(%rsp), %edx
	movl	$8, %ecx
	xorl	%r13d, %r13d
	movl	16(%rsp), %esi
	leaq	.LC21(%rip), %r8
	call	error_at_location@PLT
	jmp	.L202
	.p2align 4,,10
	.p2align 3
.L651:
	movl	$42, %r13d
	cmpq	%r10, %rbp
	jnb	.L202
	movzbl	(%rcx,%rbp), %eax
	cmpb	$48, %al
	jg	.L206
	cmpb	$33, %al
	jle	.L202
	movabsq	$289738493788160, %rcx
	btq	%rax, %rcx
	jnc	.L202
.L208:
	movl	24(%rsp), %edx
	movl	16(%rsp), %esi
	movq	%rbx, %rdi
	call	parse_escape
	movl	%eax, %r13d
	jmp	.L202
	.p2align 4,,10
	.p2align 3
.L652:
	leaq	8(%r14,%r14), %r14
	movq	%r12, %rdi
	movq	%r14, %rsi
	call	realloc@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	jne	.L210
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L210
	.p2align 4,,10
	.p2align 3
.L649:
	addl	$1, 24(%rbx)
	movl	$10, %r13d
	movl	$1, 28(%rbx)
	jmp	.L202
	.p2align 4,,10
	.p2align 3
.L623:
	addq	$1, %r11
	leal	1(%r13), %eax
	movl	16(%rsp), %r14d
	xorl	%r12d, %r12d
	movq	%r11, 16(%rbx)
	movq	%r9, %r15
	movl	%eax, 28(%rbx)
	movq	$0, 64(%rsp)
	movq	$0, 72(%rsp)
	cmpq	%r10, %r11
	jnb	.L216
.L658:
	movq	(%rbx), %rax
	movzbl	(%rax,%r11), %ebp
	testl	%ebp, %ebp
	je	.L216
	addq	$1, %r11
	movq	%r11, 16(%rbx)
	cmpl	$10, %ebp
	je	.L654
	addl	$1, 28(%rbx)
	cmpl	$39, %ebp
	je	.L655
	cmpq	$1, %r12
	jbe	.L226
	testb	$32, g_extensions(%rip)
	je	.L219
.L227:
	cmpq	$4, %r12
	je	.L656
.L226:
	cmpl	$42, %ebp
	je	.L657
	cmpl	$92, %ebp
	jne	.L602
	movl	%r13d, %edx
	movl	%r14d, %esi
	movq	%rbx, %rdi
	call	parse_backslash_escape
	movl	%eax, %ebp
.L602:
	movq	16(%rbx), %r11
	movq	8(%rbx), %r10
.L218:
	movl	%ebp, 64(%rsp,%r12,4)
	addq	$1, %r12
	cmpq	%r10, %r11
	jb	.L658
.L216:
	movq	32(%rbx), %rdi
	movl	$8, %ecx
	movl	%r13d, %edx
	movl	%r14d, %esi
	leaq	.LC23(%rip), %r8
	call	error_at_location@PLT
	cmpq	$1, %r12
	jbe	.L225
	testb	$32, g_extensions(%rip)
	je	.L435
	cmpq	$4, %r12
	je	.L659
.L225:
	movq	16(%rbx), %r11
	movq	8(%rbx), %r10
	xorl	%ebp, %ebp
	jmp	.L218
	.p2align 4,,10
	.p2align 3
.L657:
	movq	16(%rbx), %r11
	movq	8(%rbx), %r10
	cmpq	%r10, %r11
	jnb	.L218
	movq	(%rbx), %rdx
	movzbl	(%rdx,%r11), %eax
	cmpb	$39, %al
	je	.L231
	jle	.L660
	cmpb	$116, %al
	jg	.L218
	cmpb	$100, %al
	jg	.L234
	cmpb	$42, %al
	jle	.L233
	cmpb	$48, %al
	jne	.L218
.L233:
	movl	%r13d, %edx
	movl	%r14d, %esi
	movq	%rbx, %rdi
	call	parse_escape
	movq	16(%rbx), %r11
	movq	8(%rbx), %r10
	movl	%eax, %ebp
	jmp	.L218
.L262:
	cmpl	$37, %ebp
	jne	.L265
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L249
	cmpb	$61, 1(%rdi,%rdx)
	jne	.L249
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$42, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L693:
	cmpl	$61, %ebp
	jne	.L661
	.p2align 4
	.p2align 3
.L272:
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L295
	leaq	(%rdi,%rax), %r8
	movzbl	(%r8), %r10d
	movl	%r10d, %ecx
	cmpb	$43, %r10b
	je	.L662
	cmpb	$60, %r10b
	jg	.L299
	cmpb	$36, %r10b
	jle	.L300
	subl	$37, %ecx
	cmpb	$23, %cl
	ja	.L301
	leaq	.L303(%rip), %r10
	movzbl	%cl, %ecx
	movslq	(%r10,%rcx,4), %rcx
	addq	%r10, %rcx
	jmp	*%rcx
	.section	.rodata
	.align 4
	.align 4
.L303:
	.long	.L308-.L303
	.long	.L307-.L303
	.long	.L301-.L303
	.long	.L301-.L303
	.long	.L301-.L303
	.long	.L306-.L303
	.long	.L301-.L303
	.long	.L301-.L303
	.long	.L305-.L303
	.long	.L301-.L303
	.long	.L304-.L303
	.long	.L301-.L303
	.long	.L301-.L303
	.long	.L301-.L303
	.long	.L301-.L303
	.long	.L301-.L303
	.long	.L301-.L303
	.long	.L301-.L303
	.long	.L301-.L303
	.long	.L301-.L303
	.long	.L301-.L303
	.long	.L301-.L303
	.long	.L301-.L303
	.long	.L302-.L303
	.text
	.p2align 4,,10
	.p2align 3
.L301:
	cmpq	%r15, %rax
	jnb	.L295
	cmpb	$61, (%r8)
	jne	.L339
	leal	1(%r13), %edx
	movq	%rax, 16(%rbx)
	movl	%edx, 28(%rbx)
	movzbl	(%r8), %edx
	testl	%edx, %edx
	je	.L349
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L663
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L349:
	movl	$22, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L302:
	movzbl	2(%rdi,%rdx), %eax
	movq	%rbx, %rdi
	cmpb	$60, %al
	je	.L664
	cmpb	$61, %al
	je	.L665
	call	lx_get
	call	lx_get
	movl	$47, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L304:
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	je	.L315
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L666
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L315:
	movl	$41, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L305:
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	je	.L311
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L667
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L311:
	movl	$39, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L306:
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	je	.L313
.L617:
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L668
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L313:
	movl	$40, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L307:
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	je	.L319
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L669
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L319:
	movl	$45, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L308:
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	je	.L317
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L670
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L317:
	movl	$42, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L641:
	testb	$8, g_extensions(%rip)
	jne	.L249
	movl	g_pedantic(%rip), %r15d
	testl	%r15d, %r15d
	je	.L339
	jmp	.L249
	.p2align 4,,10
	.p2align 3
.L206:
	subl	$101, %eax
	cmpb	$15, %al
	ja	.L202
	movl	$33281, %ecx
	btq	%rax, %rcx
	jc	.L208
	jmp	.L202
.L435:
	xorl	%ebp, %ebp
.L219:
	movq	32(%rbx), %rdi
	movl	$8, %ecx
	movl	%r13d, %edx
	movl	%r14d, %esi
	leaq	.LC24(%rip), %r8
	call	error_at_location@PLT
	jmp	.L227
.L162:
	leal	1(%r13), %eax
	movq	%rbp, 16(%rbx)
	movl	%eax, 28(%rbx)
	movzbl	(%r10), %eax
	testl	%eax, %eax
	je	.L176
	leaq	2(%rdx), %rbp
	leal	2(%r13), %r10d
	movq	%rbp, 16(%rbx)
	cmpl	$10, %eax
	jne	.L168
	movl	16(%rsp), %eax
	movl	$1, %r10d
	addl	$1, %eax
	movl	%eax, 24(%rbx)
.L168:
	movl	%r10d, 28(%rbx)
	.p2align 4
	.p2align 3
.L176:
	cmpq	%r15, %rbp
	jnb	.L173
.L672:
	movzbl	(%rdi,%rbp), %eax
	movzbl	%al, %r10d
	testb	$16, 1(%r8,%r10,2)
	je	.L599
	testl	%eax, %eax
	je	.L176
	addq	$1, %rbp
	movq	%rbp, 16(%rbx)
	cmpl	$10, %eax
	je	.L671
	movl	28(%rbx), %eax
	addl	$1, %eax
.L172:
	movl	%eax, 28(%rbx)
	cmpq	%r15, %rbp
	jb	.L672
.L173:
	testb	$16, 1(%r8)
	jne	.L176
.L599:
	movl	$16, %r14d
	jmp	.L175
	.p2align 4,,10
	.p2align 3
.L671:
	addl	$1, 24(%rbx)
	movl	$1, %eax
	jmp	.L172
.L654:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	cmpq	$1, %r12
	jbe	.L218
	testb	$32, g_extensions(%rip)
	je	.L219
	cmpq	$4, %r12
	jne	.L218
	movq	32(%rbx), %rdi
	movl	$8, %ecx
	movl	%r13d, %edx
	movl	%r14d, %esi
	leaq	.LC22(%rip), %r8
	call	error_at_location@PLT
	jmp	.L602
	.p2align 4,,10
	.p2align 3
.L627:
	movl	g_pedantic(%rip), %r14d
	testl	%r14d, %r14d
	je	.L249
.L404:
	cmpb	$61, 1(%rdi,%rdx)
	jne	.L249
.L288:
	movq	32(%rbx), %rdi
	movl	16(%rsp), %esi
	movl	%r13d, %edx
	movl	$8, %ecx
	leaq	.LC25(%rip), %r8
	movq	%r9, 24(%rsp)
	call	error_at_location@PLT
	movq	16(%rbx), %rdx
	movq	8(%rbx), %r15
	cmpl	$124, %ebp
	movq	24(%rsp), %r9
	movq	%rdx, %r11
	movq	%r15, %r10
	jne	.L240
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L268
	movq	(%rbx), %rdi
.L340:
	movzbl	(%rdi,%rax), %eax
.L290:
	cmpb	$124, %al
	je	.L673
.L343:
	movq	%rdx, %r11
	movq	%r15, %r10
	jmp	.L249
.L330:
	addl	$1, 28(%rbx)
	movq	%rax, 16(%rbx)
.L362:
	movl	$24, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L265:
	cmpl	$38, %ebp
	jne	.L266
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L249
	cmpb	$61, 1(%rdi,%rdx)
	jne	.L249
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$45, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L650:
	movq	g_compilation_arena(%rip), %rdi
	movq	%r15, %rax
	movq	%r12, %r15
	movq	32(%rsp), %r9
	movb	$0, (%r15,%rax)
	movq	%rax, %r12
	movl	$1, %eax
	testq	%rdi, %rdi
	je	.L214
	leaq	1(%r12), %r13
	movq	%r9, 16(%rsp)
	movq	%r13, %rsi
	call	arena_alloc@PLT
	movq	%r15, %rsi
	movq	%r13, %rdx
	movq	%rax, %rdi
	movq	%rax, %rbp
	call	memcpy@PLT
	movq	%r15, %rdi
	movq	%rbp, %r15
	call	free@PLT
	movq	16(%rsp), %r9
	xorl	%eax, %eax
.L214:
	movl	%eax, 24(%r9)
	movq	32(%rbx), %rdx
	movq	8(%rsp), %rax
	movl	$3, (%r9)
	movq	%r15, 8(%r9)
	movq	%r12, 16(%r9)
	movq	$0, 32(%r9)
	movq	%rax, 40(%r9)
	movq	%rdx, 48(%r9)
	jmp	.L137
.L646:
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L249
	addq	%rax, %rdi
	cmpb	$61, (%rdi)
	jne	.L249
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rdi), %eax
	testl	%eax, %eax
	jne	.L617
	jmp	.L313
	.p2align 4,,10
	.p2align 3
.L431:
	xorl	%ebp, %ebp
	jmp	.L193
.L655:
	movslq	64(%rsp), %rax
	movq	%r15, %r9
	cmpl	$1, %r12d
	jle	.L237
	movslq	68(%rsp), %rdx
	salq	$8, %rdx
	orq	%rdx, %rax
	cmpl	$2, %r12d
	je	.L237
	movslq	72(%rsp), %rdx
	salq	$16, %rdx
	orq	%rdx, %rax
	cmpl	$4, %r12d
	jne	.L237
	movslq	76(%rsp), %rdx
	salq	$24, %rdx
	orq	%rdx, %rax
.L237:
	movq	%rax, 32(%r9)
	movq	32(%rbx), %rdx
	movq	8(%rsp), %rax
	movl	$4, (%r9)
	movq	$0, 8(%r9)
	movq	$0, 16(%r9)
	movl	$0, 24(%r9)
	movq	%rax, 40(%r9)
	movq	%rdx, 48(%r9)
	jmp	.L137
.L643:
	cmpb	$61, (%rcx)
	jne	.L249
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L297
.L615:
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L674
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L297:
	movl	$38, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L644:
	movq	32(%rbx), %rdi
	movl	16(%rsp), %esi
	movl	$8, %ecx
	movl	%r13d, %edx
	leaq	.LC18(%rip), %r8
	movq	%r9, 24(%rsp)
	call	error_at_location@PLT
	movq	16(%rbx), %rax
	cmpq	8(%rbx), %rax
	movq	24(%rsp), %r9
	jnb	.L164
	movq	(%rbx), %rdx
	movzbl	(%rdx,%rax), %edx
	testl	%edx, %edx
	je	.L164
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	jne	.L165
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L164
.L266:
	cmpl	$124, %ebp
	jne	.L267
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L268
	cmpb	$61, 1(%rdi,%rdx)
	jne	.L340
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$46, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L637:
	movl	$1379, %eax
	salq	$37, %rax
	btq	%rbp, %rax
	jnc	.L287
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L240
	cmpb	$61, 1(%rdi,%rdx)
	je	.L288
.L240:
	cmpl	$62, %ebp
	jne	.L249
	leaq	1(%rdx), %rax
.L283:
	cmpq	%r15, %rax
	jb	.L675
	cmpq	%r15, %rdx
	jnb	.L385
	movq	(%rbx), %rdi
.L375:
	movzbl	(%rdi,%rdx), %edx
	testl	%edx, %edx
	jne	.L342
	jmp	.L385
.L267:
	cmpl	$60, %ebp
	jne	.L676
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L330
	cmpb	$60, 1(%rdi,%rdx)
	je	.L277
	addq	%rax, %rdi
	cmpb	$61, (%rdi)
	je	.L278
	movq	%rax, 16(%rbx)
.L364:
	addl	$1, 28(%rbx)
	jmp	.L376
.L673:
	testb	$16, g_extensions(%rip)
	jne	.L677
	movl	g_pedantic(%rip), %ecx
	testl	%ecx, %ecx
	je	.L343
	movq	32(%rbx), %rdi
	movl	16(%rsp), %esi
	movl	$8, %ecx
	movl	%r13d, %edx
	leaq	.LC26(%rip), %r8
	movq	%r9, 24(%rsp)
	call	error_at_location@PLT
	movq	16(%rbx), %r11
	movq	8(%rbx), %r10
	movq	24(%rsp), %r9
	jmp	.L249
.L286:
	cmpb	$124, %bpl
	jne	.L285
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jb	.L678
	addl	$1, 28(%rbx)
	movq	%rax, 16(%rbx)
.L341:
	movl	$54, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L231:
	leaq	1(%r11), %rax
	cmpq	%r10, %rax
	jnb	.L218
	cmpb	$39, 1(%rdx,%r11)
	jne	.L218
	jmp	.L233
.L656:
	movq	32(%rbx), %rdi
	movl	$8, %ecx
	movl	%r13d, %edx
	movl	%r14d, %esi
	leaq	.LC22(%rip), %r8
	call	error_at_location@PLT
	jmp	.L226
.L295:
	addl	$1, 28(%rbx)
	movq	%rax, 16(%rbx)
.L351:
	movl	$21, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L329:
	cmpl	$62, %ebp
	jne	.L242
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L375
.L604:
	addq	%rax, %rdi
	cmpb	$62, (%rdi)
	jne	.L283
	leal	1(%r13), %edx
	movq	%rax, 16(%rbx)
	movl	%edx, 28(%rbx)
	movzbl	(%rdi), %edx
	testl	%edx, %edx
	je	.L335
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L679
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L335:
	movl	$29, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L660:
	cmpb	$34, %al
	jne	.L218
	jmp	.L233
.L642:
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L244
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L680
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L244:
	movl	$36, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L299:
	cmpb	$124, %r10b
	jne	.L681
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	je	.L321
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L682
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L321:
	movl	$46, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L626:
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rsi), %eax
	testl	%eax, %eax
	je	.L251
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L683
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L251:
	movl	$37, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L234:
	subl	$101, %eax
	movl	$33281, %edx
	btq	%rax, %rdx
	jc	.L233
	jmp	.L218
.L639:
	cmpq	%r15, %rdx
	jnb	.L370
	movzbl	(%rdi,%rdx), %ecx
	testl	%ecx, %ecx
	je	.L371
	movq	%rax, 16(%rbx)
	cmpl	$10, %ecx
	je	.L684
	addl	$1, 28(%rbx)
	movq	%rax, %rdx
.L371:
	movzbl	(%rdi,%rdx), %eax
	testl	%eax, %eax
	je	.L370
	addq	$1, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L685
	addl	$1, 28(%rbx)
.L370:
	movl	$27, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L268:
	cmpq	%r15, %rdx
	jnb	.L341
	movq	(%rbx), %rcx
	movzbl	(%rcx,%rdx), %edx
	testl	%edx, %edx
	je	.L341
	jmp	.L342
	.p2align 4,,10
	.p2align 3
.L659:
	movq	32(%rbx), %rdi
	leaq	.LC22(%rip), %r8
	movl	%r13d, %edx
	xorl	%ebp, %ebp
	movl	$8, %ecx
	movl	%r14d, %esi
	call	error_at_location@PLT
	jmp	.L602
.L645:
	leal	1(%r13), %edx
	movq	%rax, 16(%rbx)
	movl	%edx, 28(%rbx)
	movzbl	(%rdi), %edx
	testl	%edx, %edx
	je	.L333
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L686
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L333:
	movl	$28, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L638:
	cmpq	%r15, %rdx
	jnb	.L357
	movzbl	(%rdi,%rdx), %edx
	testl	%edx, %edx
	je	.L357
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L687
	movl	28(%rbx), %esi
	leal	1(%rsi), %edx
.L360:
	movl	%edx, 28(%rbx)
	movzbl	(%rcx), %edx
	testl	%edx, %edx
	je	.L357
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L688
	addl	$1, 28(%rbx)
.L357:
	movl	$23, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L662:
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	jne	.L615
	jmp	.L297
.L628:
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rsi), %eax
	testl	%eax, %eax
	je	.L257
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L689
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L257:
	movl	$39, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L278:
	leal	1(%r13), %edx
	movq	%rax, 16(%rbx)
	movl	%edx, 28(%rbx)
	movzbl	(%rdi), %edx
	testl	%edx, %edx
	je	.L365
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L690
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L365:
	movl	$25, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L277:
	leaq	2(%rdx), %rcx
	cmpq	%r15, %rcx
	jnb	.L613
	cmpb	$61, 2(%rdi,%rdx)
	jne	.L613
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$43, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L677:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$55, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L668:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L313
.L669:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L319
.L667:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L311
.L666:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L315
.L670:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L317
.L674:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L297
.L682:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L321
.L683:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L251
.L680:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L244
.L684:
	addl	$1, 24(%rbx)
	movq	%rax, %rdx
	movl	$1, 28(%rbx)
	jmp	.L371
.L685:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L370
.L686:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L333
.L688:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L357
.L687:
	addl	$1, 24(%rbx)
	movl	$1, %edx
	jmp	.L360
.L663:
	addl	$1, %esi
	movl	$1, 28(%rbx)
	movl	%esi, 24(%rbx)
	jmp	.L349
.L690:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L365
.L679:
	addl	$1, %esi
	movl	$1, 28(%rbx)
	movl	%esi, 24(%rbx)
	jmp	.L335
.L689:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L257
.L647:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L263
.L665:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$48, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L664:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$43, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L242:
	cmpl	$124, %ebp
	jne	.L287
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jb	.L340
	movzbl	(%rdi,%rdx), %edx
	testl	%edx, %edx
	je	.L341
	jmp	.L342
.L300:
	cmpl	$33, %r10d
	jne	.L301
	cmpb	$61, 2(%rdi,%rdx)
	jne	.L301
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$52, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L681:
	cmpl	$62, %r10d
	je	.L324
	cmpl	$61, %r10d
	jne	.L301
	cmpb	$61, 2(%rdi,%rdx)
	jne	.L301
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$51, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
	.p2align 4,,10
	.p2align 3
.L324:
	movzbl	2(%rdi,%rdx), %eax
	movq	%rbx, %rdi
	cmpb	$62, %al
	je	.L691
	cmpb	$61, %al
	je	.L692
	call	lx_get
	call	lx_get
	movl	$49, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L691:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$44, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L692:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$50, (%r9)
	movq	32(%rbx), %rax
	jmp	.L607
.L629:
	movq	(%rbx), %rdi
	jmp	.L339
.L676:
	cmpl	$62, %ebp
	jne	.L693
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L375
	cmpb	$62, 1(%rdi,%rdx)
	jne	.L283
	leaq	2(%rdx), %rcx
	cmpq	%r15, %rcx
	jnb	.L604
	cmpb	$61, 2(%rdi,%rdx)
	jne	.L604
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$44, (%r9)
	movq	32(%rbx), %rax
	jmp	.L608
.L619:
	movq	g_compilation_arena(%rip), %rax
	testq	%rax, %rax
	jne	.L406
	cmpq	%rcx, %rdx
	jb	.L407
	movl	$1, %edi
	xorl	%ebp, %ebp
	jmp	.L154
.L648:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	movq	%r9, 24(%rsp)
	call	dief@PLT
	movq	16(%rbx), %rbp
	movq	8(%rbx), %r10
	movq	24(%rsp), %r9
	jmp	.L199
.L634:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	movq	%r9, 32(%rsp)
	movb	%cl, 24(%rsp)
	movq	%rdx, 40(%rsp)
	call	dief@PLT
	movq	40(%rsp), %rsi
	movq	32(%rsp), %r9
	movzbl	24(%rsp), %ecx
	addq	(%rbx), %rsi
	jmp	.L191
.L661:
	cmpl	$33, %ebp
	jne	.L249
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jb	.L353
	jmp	.L355
.L678:
	movzbl	1(%rdi,%rdx), %eax
	cmpb	$61, %al
	jne	.L290
	jmp	.L288
.L636:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	movq	%r9, 16(%rsp)
	movq	%rdx, 24(%rsp)
	call	dief@PLT
	movq	24(%rsp), %rsi
	movq	16(%rsp), %r9
	addq	(%rbx), %rsi
	jmp	.L155
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
	je	.L695
	movl	24(%rbx), %eax
	testl	%eax, %eax
	jne	.L700
.L695:
	movq	$0, 8(%rbx)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L700:
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
.LC28:
	.string	"EOF"
.LC29:
	.string	"identifier"
.LC30:
	.string	"number"
.LC31:
	.string	"string"
.LC32:
	.string	"character"
.LC33:
	.string	"if"
.LC34:
	.string	"("
.LC35:
	.string	")"
.LC36:
	.string	"{"
.LC37:
	.string	"}"
.LC38:
	.string	","
.LC39:
	.string	";"
.LC40:
	.string	"="
.LC41:
	.string	"=="
.LC42:
	.string	"!="
.LC43:
	.string	"<"
.LC44:
	.string	"<="
.LC45:
	.string	">"
.LC46:
	.string	">="
.LC47:
	.string	"<<"
.LC48:
	.string	">>"
.LC49:
	.string	"+"
.LC50:
	.string	"-"
.LC51:
	.string	"*"
.LC52:
	.string	"/"
.LC53:
	.string	"%"
.LC54:
	.string	"!"
.LC55:
	.string	"?"
.LC56:
	.string	"["
.LC57:
	.string	"]"
.LC58:
	.string	"++"
.LC59:
	.string	"--"
.LC60:
	.string	"=+"
.LC61:
	.string	"=-"
.LC62:
	.string	"=*"
.LC63:
	.string	"=/"
.LC64:
	.string	"=%"
.LC65:
	.string	"=<<"
.LC66:
	.string	"=>>"
.LC67:
	.string	"=&"
.LC68:
	.string	"=|"
.LC69:
	.string	"=<"
.LC70:
	.string	"=<="
.LC71:
	.string	"=>"
.LC72:
	.string	"=>="
.LC73:
	.string	"==="
.LC74:
	.string	"=!="
.LC75:
	.string	"&"
.LC76:
	.string	"|"
.LC77:
	.string	"||"
.LC78:
	.string	":"
.LC79:
	.string	"<unknown token>"
	.text
	.p2align 4
	.globl	tk_name
	.type	tk_name, @function
tk_name:
.LFB24:
	.cfi_startproc
	cmpl	$61, %edi
	ja	.L702
	leaq	.L704(%rip), %rdx
	movl	%edi, %edi
	movslq	(%rdx,%rdi,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L704:
	.long	.L765-.L704
	.long	.L766-.L704
	.long	.L763-.L704
	.long	.L762-.L704
	.long	.L761-.L704
	.long	.L760-.L704
	.long	.L759-.L704
	.long	.L758-.L704
	.long	.L757-.L704
	.long	.L756-.L704
	.long	.L755-.L704
	.long	.L754-.L704
	.long	.L753-.L704
	.long	.L752-.L704
	.long	.L751-.L704
	.long	.L750-.L704
	.long	.L749-.L704
	.long	.L748-.L704
	.long	.L747-.L704
	.long	.L746-.L704
	.long	.L745-.L704
	.long	.L744-.L704
	.long	.L743-.L704
	.long	.L742-.L704
	.long	.L741-.L704
	.long	.L740-.L704
	.long	.L739-.L704
	.long	.L738-.L704
	.long	.L737-.L704
	.long	.L736-.L704
	.long	.L735-.L704
	.long	.L734-.L704
	.long	.L733-.L704
	.long	.L732-.L704
	.long	.L731-.L704
	.long	.L730-.L704
	.long	.L729-.L704
	.long	.L728-.L704
	.long	.L727-.L704
	.long	.L726-.L704
	.long	.L725-.L704
	.long	.L724-.L704
	.long	.L723-.L704
	.long	.L722-.L704
	.long	.L721-.L704
	.long	.L720-.L704
	.long	.L719-.L704
	.long	.L718-.L704
	.long	.L717-.L704
	.long	.L716-.L704
	.long	.L715-.L704
	.long	.L714-.L704
	.long	.L713-.L704
	.long	.L712-.L704
	.long	.L711-.L704
	.long	.L710-.L704
	.long	.L709-.L704
	.long	.L708-.L704
	.long	.L707-.L704
	.long	.L706-.L704
	.long	.L705-.L704
	.long	.L703-.L704
	.text
	.p2align 4,,10
	.p2align 3
.L766:
	leaq	.LC29(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L765:
	leaq	.LC28(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L703:
	leaq	.LC17(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L720:
	leaq	.LC67(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L721:
	leaq	.LC66(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L722:
	leaq	.LC65(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L723:
	leaq	.LC64(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L724:
	leaq	.LC63(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L725:
	leaq	.LC62(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L726:
	leaq	.LC61(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L727:
	leaq	.LC60(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L728:
	leaq	.LC59(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L729:
	leaq	.LC58(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L730:
	leaq	.LC54(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L731:
	leaq	.LC53(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L732:
	leaq	.LC52(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L733:
	leaq	.LC51(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L734:
	leaq	.LC50(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L711:
	leaq	.LC76(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L712:
	leaq	.LC75(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L713:
	leaq	.LC74(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L714:
	leaq	.LC73(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L715:
	leaq	.LC72(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L716:
	leaq	.LC71(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L717:
	leaq	.LC70(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L718:
	leaq	.LC69(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L707:
	leaq	.LC14(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L708:
	leaq	.LC78(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L709:
	leaq	.LC55(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L710:
	leaq	.LC77(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L705:
	leaq	.LC16(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L719:
	leaq	.LC68(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L761:
	leaq	.LC32(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L762:
	leaq	.LC31(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L757:
	leaq	.LC9(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L758:
	leaq	.LC8(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L759:
	leaq	.LC33(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L760:
	leaq	.LC7(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L749:
	leaq	.LC37(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L750:
	leaq	.LC36(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L751:
	leaq	.LC35(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L752:
	leaq	.LC34(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L753:
	leaq	.LC11(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L754:
	leaq	.LC13(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L755:
	leaq	.LC12(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L756:
	leaq	.LC10(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L706:
	leaq	.LC15(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L763:
	leaq	.LC30(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L735:
	leaq	.LC49(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L736:
	leaq	.LC48(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L737:
	leaq	.LC47(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L738:
	leaq	.LC46(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L739:
	leaq	.LC45(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L740:
	leaq	.LC44(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L741:
	leaq	.LC43(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L742:
	leaq	.LC42(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L743:
	leaq	.LC41(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L744:
	leaq	.LC40(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L745:
	leaq	.LC57(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L746:
	leaq	.LC56(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L747:
	leaq	.LC39(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L748:
	leaq	.LC38(%rip), %rax
	ret
.L702:
	leaq	.LC79(%rip), %rax
	ret
	.cfi_endproc
.LFE24:
	.size	tk_name, .-tk_name
	.section	.note.GNU-stack,"",@progbits
