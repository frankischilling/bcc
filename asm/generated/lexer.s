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
	.section	.rodata.str1.1
.LC25:
	.string	"empty character constant"
	.section	.rodata.str1.8
	.align 8
.LC26:
	.string	"C-style compound assignments (op=) are not allowed in strict B mode (use =op)"
	.align 8
.LC27:
	.string	"|| is not part of Thompson B72 (use | or a conditional expression)"
	.section	.rodata.str1.1
.LC28:
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
	je	.L583
	movq	%rdx, %rcx
.L147:
	cmpq	%r15, %rcx
	jnb	.L629
.L146:
	movzbl	(%rdi,%rcx), %eax
	movzbl	%al, %r10d
	testb	$8, (%r8,%r10,2)
	jne	.L149
	cmpb	$95, %al
	je	.L151
	cmpb	$46, %al
	jne	.L630
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
.L629:
	testb	$8, (%r8)
	jne	.L147
	movq	g_compilation_arena(%rip), %rax
	testq	%rax, %rax
	je	.L409
.L408:
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
	jne	.L442
	cmpb	$102, 1(%r12)
	je	.L631
.L442:
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
.L583:
	.cfi_restore_state
	movq	8(%rsp), %xmm0
	pshufd	$0xe5, %xmm0, %xmm1
	movd	%xmm0, 16(%rsp)
	movd	%xmm1, %r13d
	testb	$8, %ah
	jne	.L632
	cmpl	$34, %ebp
	je	.L633
	cmpl	$39, %ebp
	je	.L634
	cmpl	$43, %ebp
	je	.L635
	cmpl	$45, %ebp
	jne	.L636
	leaq	1(%rdx), %rax
	cmpq	%r10, %rax
	jnb	.L251
	leaq	(%rdi,%rax), %rsi
	movzbl	(%rsi), %ecx
	cmpb	$45, %cl
	je	.L637
	testb	$8, g_extensions(%rip)
	je	.L638
	cmpb	$61, %cl
	je	.L639
.L251:
	cmpq	%r10, %r11
	jb	.L640
	.p2align 4
	.p2align 3
.L378:
	subl	$33, %r12d
	cmpb	$92, %r12b
	ja	.L380
	leaq	.L382(%rip), %rdx
	movzbl	%r12b, %r12d
	movslq	(%rdx,%r12,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L382:
	.long	.L356-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L398-.L382
	.long	.L397-.L382
	.long	.L380-.L382
	.long	.L396-.L382
	.long	.L395-.L382
	.long	.L394-.L382
	.long	.L393-.L382
	.long	.L392-.L382
	.long	.L391-.L382
	.long	.L380-.L382
	.long	.L390-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L389-.L382
	.long	.L388-.L382
	.long	.L364-.L382
	.long	.L353-.L382
	.long	.L387-.L382
	.long	.L386-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L385-.L382
	.long	.L380-.L382
	.long	.L384-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L380-.L382
	.long	.L383-.L382
	.long	.L343-.L382
	.long	.L381-.L382
	.text
	.p2align 4,,10
	.p2align 3
.L632:
	cmpl	$48, %ebp
	jne	.L431
	leaq	1(%rdx), %rbp
	cmpq	%r15, %rbp
	jnb	.L161
	leaq	(%rdi,%rbp), %r10
	movzbl	(%r10), %eax
	andl	$-33, %eax
	cmpb	$88, %al
	je	.L641
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
	je	.L604
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
.L431:
	movq	%rdx, %rbp
	.p2align 4
	.p2align 3
.L189:
	cmpq	%r15, %rbp
	jnb	.L187
.L643:
	movzbl	(%rdi,%rbp), %eax
	movzbl	%al, %r10d
	testb	$8, 1(%r8,%r10,2)
	je	.L603
	testl	%eax, %eax
	je	.L189
	addq	$1, %rbp
	movq	%rbp, 16(%rbx)
	cmpl	$10, %eax
	je	.L642
	movl	28(%rbx), %eax
	addl	$1, %eax
.L186:
	movl	%eax, 28(%rbx)
	cmpq	%r15, %rbp
	jb	.L643
.L187:
	testb	$8, 1(%r8)
	jne	.L189
.L603:
	movl	$10, %r14d
.L175:
	cmpq	%rbp, %rdx
	jb	.L644
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
	je	.L645
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
	je	.L433
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
	je	.L646
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
.L642:
	addl	$1, 24(%rbx)
	movl	$1, %eax
	jmp	.L186
	.p2align 4,,10
	.p2align 3
.L409:
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
	je	.L647
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
.L644:
	subq	%rdx, %rbp
	leaq	1(%rbp), %rdi
	jmp	.L190
	.p2align 4,,10
	.p2align 3
.L631:
	cmpb	$0, 2(%r12)
	movl	$6, %eax
	je	.L156
	jmp	.L442
	.p2align 4,,10
	.p2align 3
.L636:
	movl	24(%rbx), %esi
	testb	$8, g_extensions(%rip)
	jne	.L249
	movl	g_pedantic(%rip), %r8d
	testl	%r8d, %r8d
	je	.L287
	cmpb	$47, %bpl
	jg	.L288
	cmpb	$36, %bpl
	jg	.L648
.L289:
	cmpl	$33, %ebp
	jne	.L341
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L341
.L355:
	leaq	(%rdi,%rax), %rcx
	cmpb	$61, (%rcx)
	je	.L649
.L357:
	cmpq	%r15, %rdx
	jb	.L341
.L356:
	movl	$35, (%r9)
	movq	32(%rbx), %rax
	.p2align 4
	.p2align 3
.L610:
	movq	8(%rsp), %rsi
	movq	$0, 8(%r9)
	movq	$0, 16(%r9)
	movl	$0, 24(%r9)
	movq	$0, 32(%r9)
	movq	%rsi, 40(%r9)
	movq	%rax, 48(%r9)
	jmp	.L137
	.p2align 4,,10
	.p2align 3
.L380:
	leaq	64(%rsp), %r12
	movl	%ebp, %ecx
	leaq	.LC28(%rip), %rdx
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
	jmp	.L610
.L398:
	movl	$34, (%r9)
	movq	32(%rbx), %rax
	.p2align 4
	.p2align 3
.L611:
	movq	8(%rsp), %rdx
	movq	$0, 8(%r9)
	movq	$0, 16(%r9)
	movl	$0, 24(%r9)
	movq	$0, 32(%r9)
	movq	%rdx, 40(%r9)
	movq	%rax, 48(%r9)
	jmp	.L137
.L394:
	movl	$32, (%r9)
	movq	32(%rbx), %rax
	jmp	.L611
.L395:
	movl	$14, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L396:
	movl	$13, (%r9)
	movq	32(%rbx), %rax
	jmp	.L611
.L397:
	movl	$53, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L388:
	movl	$18, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L389:
	movl	$57, (%r9)
	movq	32(%rbx), %rax
	jmp	.L611
.L390:
	movl	$33, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L391:
	movl	$31, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L392:
	movl	$17, (%r9)
	movq	32(%rbx), %rax
	jmp	.L611
.L393:
	movl	$30, (%r9)
	movq	32(%rbx), %rax
	jmp	.L611
.L381:
	movl	$16, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L383:
	movl	$15, (%r9)
	movq	32(%rbx), %rax
	jmp	.L611
.L384:
	movl	$20, (%r9)
	movq	32(%rbx), %rax
	jmp	.L611
.L385:
	movl	$19, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L386:
	movl	$56, (%r9)
	movq	32(%rbx), %rax
	jmp	.L611
.L685:
	movq	(%rbx), %rdi
	cmpb	$61, 1(%rdi,%rdx)
	je	.L650
	cmpq	%r15, %rdx
	jb	.L377
.L387:
	movl	$26, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
	.p2align 4,,10
	.p2align 3
.L181:
	testb	$8, 1(%r8)
	jne	.L183
.L604:
	movl	$1, %ecx
	movl	$8, %r14d
	jmp	.L175
	.p2align 4,,10
	.p2align 3
.L646:
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
	jne	.L651
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
.L651:
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
.L635:
	leaq	1(%r11), %rax
	cmpq	%r10, %rax
	jnb	.L652
	leaq	(%rdi,%rax), %rcx
	cmpb	$43, (%rcx)
	je	.L653
	testb	$8, g_extensions(%rip)
	jne	.L654
	movl	g_pedantic(%rip), %eax
	testl	%eax, %eax
	jne	.L406
.L341:
	movzbl	(%rdi,%r11), %edx
	testl	%edx, %edx
	je	.L378
	leaq	1(%r11), %rax
	.p2align 4
	.p2align 3
.L344:
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	jne	.L366
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L378
	.p2align 4,,10
	.p2align 3
.L641:
	testb	$1, g_extensions(%rip)
	jne	.L162
	movl	g_pedantic(%rip), %eax
	testl	%eax, %eax
	jne	.L655
	movq	%rbp, 16(%rbx)
.L165:
	addl	$1, 28(%rbx)
.L164:
	movl	$2, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L287:
	cmpl	$61, %ebp
	je	.L274
	cmpl	$60, %ebp
	jne	.L331
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L332
.L620:
	addq	%rax, %rdi
	cmpb	$60, (%rdi)
	je	.L656
	cmpb	$61, (%rdi)
	je	.L280
	movl	$60, %edx
	jmp	.L344
	.p2align 4,,10
	.p2align 3
.L249:
	cmpl	$42, %ebp
	je	.L657
	cmpl	$47, %ebp
	jne	.L264
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L251
	addq	%rax, %rdi
	cmpb	$61, (%rdi)
	jne	.L251
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rdi), %eax
	testl	%eax, %eax
	je	.L317
.L628:
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L658
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L317:
	movl	$41, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
	.p2align 4,,10
	.p2align 3
.L633:
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
	je	.L659
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
.L664:
	movq	(%rbx), %rcx
	movzbl	(%rcx,%rbp), %eax
	movl	%eax, %r13d
	testl	%eax, %eax
	je	.L200
	addq	$1, %rbp
	movq	%rbp, 16(%rbx)
	cmpl	$10, %eax
	je	.L660
	addl	$1, 28(%rbx)
	cmpl	$34, %eax
	je	.L661
	cmpl	$42, %eax
	je	.L662
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
	jb	.L663
.L210:
	movq	16(%rbx), %rbp
	movq	8(%rbx), %r10
	movb	%r13b, (%r12,%r15)
	addq	$1, %r15
.L213:
	cmpq	%r10, %rbp
	jb	.L664
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
.L662:
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
.L663:
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
.L660:
	addl	$1, 24(%rbx)
	movl	$10, %r13d
	movl	$1, 28(%rbx)
	jmp	.L202
	.p2align 4,,10
	.p2align 3
.L634:
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
.L669:
	movq	(%rbx), %rax
	movzbl	(%rax,%r11), %ebp
	testl	%ebp, %ebp
	je	.L216
	addq	$1, %r11
	movq	%r11, 16(%rbx)
	cmpl	$10, %ebp
	je	.L665
	addl	$1, 28(%rbx)
	cmpl	$39, %ebp
	je	.L666
	cmpq	$1, %r12
	jbe	.L226
	testb	$32, g_extensions(%rip)
	je	.L219
.L227:
	cmpq	$4, %r12
	je	.L667
.L226:
	cmpl	$42, %ebp
	je	.L668
	cmpl	$92, %ebp
	jne	.L605
	movl	%r13d, %edx
	movl	%r14d, %esi
	movq	%rbx, %rdi
	call	parse_backslash_escape
	movl	%eax, %ebp
.L605:
	movq	16(%rbx), %r11
	movq	8(%rbx), %r10
.L218:
	movl	%ebp, 64(%rsp,%r12,4)
	addq	$1, %r12
	cmpq	%r10, %r11
	jb	.L669
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
	je	.L437
	cmpq	$4, %r12
	je	.L670
.L225:
	movq	16(%rbx), %r11
	movq	8(%rbx), %r10
	xorl	%ebp, %ebp
	jmp	.L218
	.p2align 4,,10
	.p2align 3
.L668:
	movq	16(%rbx), %r11
	movq	8(%rbx), %r10
	cmpq	%r10, %r11
	jnb	.L218
	movq	(%rbx), %rdx
	movzbl	(%rdx,%r11), %eax
	cmpb	$39, %al
	je	.L231
	jle	.L671
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
.L264:
	cmpl	$37, %ebp
	jne	.L267
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L251
	cmpb	$61, 1(%rdi,%rdx)
	jne	.L251
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$42, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L701:
	cmpl	$61, %ebp
	jne	.L672
	.p2align 4
	.p2align 3
.L274:
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L297
	leaq	(%rdi,%rax), %r8
	movzbl	(%r8), %r10d
	movl	%r10d, %ecx
	cmpb	$43, %r10b
	je	.L673
	cmpb	$60, %r10b
	jg	.L301
	cmpb	$36, %r10b
	jle	.L302
	subl	$37, %ecx
	cmpb	$23, %cl
	ja	.L303
	leaq	.L305(%rip), %r10
	movzbl	%cl, %ecx
	movslq	(%r10,%rcx,4), %rcx
	addq	%r10, %rcx
	jmp	*%rcx
	.section	.rodata
	.align 4
	.align 4
.L305:
	.long	.L310-.L305
	.long	.L309-.L305
	.long	.L303-.L305
	.long	.L303-.L305
	.long	.L303-.L305
	.long	.L308-.L305
	.long	.L303-.L305
	.long	.L303-.L305
	.long	.L307-.L305
	.long	.L303-.L305
	.long	.L306-.L305
	.long	.L303-.L305
	.long	.L303-.L305
	.long	.L303-.L305
	.long	.L303-.L305
	.long	.L303-.L305
	.long	.L303-.L305
	.long	.L303-.L305
	.long	.L303-.L305
	.long	.L303-.L305
	.long	.L303-.L305
	.long	.L303-.L305
	.long	.L303-.L305
	.long	.L304-.L305
	.text
	.p2align 4,,10
	.p2align 3
.L303:
	cmpq	%r15, %rax
	jnb	.L297
	cmpb	$61, (%r8)
	jne	.L341
	leal	1(%r13), %edx
	movq	%rax, 16(%rbx)
	movl	%edx, 28(%rbx)
	movzbl	(%r8), %edx
	testl	%edx, %edx
	je	.L351
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L674
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L351:
	movl	$22, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L304:
	movzbl	2(%rdi,%rdx), %eax
	movq	%rbx, %rdi
	cmpb	$60, %al
	je	.L614
	cmpb	$61, %al
	je	.L675
	call	lx_get
	call	lx_get
	movl	$47, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L306:
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	jne	.L628
	jmp	.L317
.L307:
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	je	.L313
.L624:
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L676
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L313:
	movl	$39, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L309:
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	je	.L321
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L677
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L321:
	movl	$45, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L308:
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	je	.L315
.L626:
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L678
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L315:
	movl	$40, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L310:
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	je	.L319
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L679
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L319:
	movl	$42, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L652:
	testb	$8, g_extensions(%rip)
	jne	.L251
	movl	g_pedantic(%rip), %r15d
	testl	%r15d, %r15d
	je	.L341
	jmp	.L251
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
.L437:
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
.L681:
	movzbl	(%rdi,%rbp), %eax
	movzbl	%al, %r10d
	testb	$16, 1(%r8,%r10,2)
	je	.L602
	testl	%eax, %eax
	je	.L176
	addq	$1, %rbp
	movq	%rbp, 16(%rbx)
	cmpl	$10, %eax
	je	.L680
	movl	28(%rbx), %eax
	addl	$1, %eax
.L172:
	movl	%eax, 28(%rbx)
	cmpq	%r15, %rbp
	jb	.L681
.L173:
	testb	$16, 1(%r8)
	jne	.L176
.L602:
	movl	$16, %r14d
	jmp	.L175
	.p2align 4,,10
	.p2align 3
.L680:
	addl	$1, 24(%rbx)
	movl	$1, %eax
	jmp	.L172
.L665:
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
	jmp	.L605
	.p2align 4,,10
	.p2align 3
.L638:
	movl	g_pedantic(%rip), %r14d
	testl	%r14d, %r14d
	je	.L251
.L406:
	cmpb	$61, 1(%rdi,%rdx)
	jne	.L251
.L290:
	movq	32(%rbx), %rdi
	movl	16(%rsp), %esi
	movl	%r13d, %edx
	movl	$8, %ecx
	leaq	.LC26(%rip), %r8
	movq	%r9, 24(%rsp)
	call	error_at_location@PLT
	movq	16(%rbx), %rdx
	movq	8(%rbx), %r15
	cmpl	$124, %ebp
	movq	24(%rsp), %r9
	movq	%rdx, %r11
	movq	%r15, %r10
	jne	.L242
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L270
	movq	(%rbx), %rdi
.L342:
	movzbl	(%rdi,%rax), %eax
.L292:
	cmpb	$124, %al
	je	.L682
.L345:
	movq	%rdx, %r11
	movq	%r15, %r10
	jmp	.L251
.L332:
	addl	$1, 28(%rbx)
	movq	%rax, 16(%rbx)
.L364:
	movl	$24, (%r9)
	movq	32(%rbx), %rax
	jmp	.L611
.L267:
	cmpl	$38, %ebp
	jne	.L268
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L251
	cmpb	$61, 1(%rdi,%rdx)
	jne	.L251
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$45, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L661:
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
.L657:
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L251
	addq	%rax, %rdi
	cmpb	$61, (%rdi)
	jne	.L251
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rdi), %eax
	testl	%eax, %eax
	jne	.L626
	jmp	.L315
	.p2align 4,,10
	.p2align 3
.L433:
	xorl	%ebp, %ebp
	jmp	.L193
.L666:
	movq	%r15, %r9
	testl	%r12d, %r12d
	je	.L683
	movslq	%r12d, %rax
	leaq	64(%rsp), %rdx
	leaq	(%rdx,%rax,4), %rsi
	xorl	%eax, %eax
	.p2align 5
	.p2align 4
	.p2align 3
.L239:
	movl	(%rdx), %ecx
	salq	$8, %rax
	addq	$4, %rdx
	orq	%rcx, %rax
	cmpq	%rdx, %rsi
	jne	.L239
.L238:
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
.L654:
	cmpb	$61, (%rcx)
	jne	.L251
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L299
.L622:
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L684
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L299:
	movl	$38, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L655:
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
.L268:
	cmpl	$124, %ebp
	jne	.L269
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L270
	cmpb	$61, 1(%rdi,%rdx)
	jne	.L342
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$46, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L648:
	movl	$1379, %eax
	salq	$37, %rax
	btq	%rbp, %rax
	jnc	.L289
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L242
	cmpb	$61, 1(%rdi,%rdx)
	je	.L290
.L242:
	cmpl	$62, %ebp
	jne	.L251
	leaq	1(%rdx), %rax
.L285:
	cmpq	%r15, %rax
	jb	.L685
	cmpq	%r15, %rdx
	jnb	.L387
	movq	(%rbx), %rdi
.L377:
	movzbl	(%rdi,%rdx), %edx
	testl	%edx, %edx
	jne	.L344
	jmp	.L387
.L269:
	cmpl	$60, %ebp
	jne	.L686
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L332
	cmpb	$60, 1(%rdi,%rdx)
	je	.L279
	addq	%rax, %rdi
	cmpb	$61, (%rdi)
	je	.L280
	movq	%rax, 16(%rbx)
.L366:
	addl	$1, 28(%rbx)
	jmp	.L378
.L682:
	testb	$16, g_extensions(%rip)
	jne	.L687
	movl	g_pedantic(%rip), %ecx
	testl	%ecx, %ecx
	je	.L345
	movq	32(%rbx), %rdi
	movl	16(%rsp), %esi
	movl	$8, %ecx
	movl	%r13d, %edx
	leaq	.LC27(%rip), %r8
	movq	%r9, 24(%rsp)
	call	error_at_location@PLT
	movq	16(%rbx), %r11
	movq	8(%rbx), %r10
	movq	24(%rsp), %r9
	jmp	.L251
.L683:
	movq	32(%rbx), %rdi
	movl	16(%rsp), %esi
	movl	$8, %ecx
	movl	%r13d, %edx
	leaq	.LC25(%rip), %r8
	movq	%r15, 24(%rsp)
	call	error_at_location@PLT
	movq	24(%rsp), %r9
	xorl	%eax, %eax
	jmp	.L238
.L231:
	leaq	1(%r11), %rax
	cmpq	%r10, %rax
	jnb	.L218
	cmpb	$39, 1(%rdx,%r11)
	jne	.L218
	jmp	.L233
.L288:
	cmpb	$124, %bpl
	jne	.L287
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jb	.L688
	addl	$1, 28(%rbx)
	movq	%rax, 16(%rbx)
.L343:
	movl	$54, (%r9)
	movq	32(%rbx), %rax
	jmp	.L611
.L667:
	movq	32(%rbx), %rdi
	movl	$8, %ecx
	movl	%r13d, %edx
	movl	%r14d, %esi
	leaq	.LC22(%rip), %r8
	call	error_at_location@PLT
	jmp	.L226
.L297:
	addl	$1, 28(%rbx)
	movq	%rax, 16(%rbx)
.L353:
	movl	$21, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L331:
	cmpl	$62, %ebp
	jne	.L244
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L377
.L607:
	addq	%rax, %rdi
	cmpb	$62, (%rdi)
	jne	.L285
	leal	1(%r13), %edx
	movq	%rax, 16(%rbx)
	movl	%edx, 28(%rbx)
	movzbl	(%rdi), %edx
	testl	%edx, %edx
	je	.L337
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L689
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L337:
	movl	$29, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L671:
	cmpb	$34, %al
	jne	.L218
	jmp	.L233
.L653:
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L246
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L690
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L246:
	movl	$36, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L301:
	cmpb	$124, %r10b
	jne	.L691
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	je	.L323
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L692
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L323:
	movl	$46, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L637:
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rsi), %eax
	testl	%eax, %eax
	je	.L253
	addq	$2, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L693
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L253:
	movl	$37, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L234:
	subl	$101, %eax
	movl	$33281, %edx
	btq	%rax, %rdx
	jc	.L233
	jmp	.L218
.L650:
	cmpq	%r15, %rdx
	jnb	.L372
	movzbl	(%rdi,%rdx), %ecx
	testl	%ecx, %ecx
	je	.L373
	movq	%rax, 16(%rbx)
	cmpl	$10, %ecx
	je	.L694
	addl	$1, 28(%rbx)
	movq	%rax, %rdx
.L373:
	movzbl	(%rdi,%rdx), %eax
	testl	%eax, %eax
	je	.L372
	addq	$1, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %eax
	je	.L695
	addl	$1, 28(%rbx)
.L372:
	movl	$27, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L270:
	cmpq	%r15, %rdx
	jnb	.L343
	movq	(%rbx), %rcx
	movzbl	(%rcx,%rdx), %edx
	testl	%edx, %edx
	je	.L343
	jmp	.L344
	.p2align 4,,10
	.p2align 3
.L670:
	movq	32(%rbx), %rdi
	leaq	.LC22(%rip), %r8
	movl	%r13d, %edx
	xorl	%ebp, %ebp
	movl	$8, %ecx
	movl	%r14d, %esi
	call	error_at_location@PLT
	jmp	.L605
.L656:
	leal	1(%r13), %edx
	movq	%rax, 16(%rbx)
	movl	%edx, 28(%rbx)
	movzbl	(%rdi), %edx
	testl	%edx, %edx
	je	.L335
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L696
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L335:
	movl	$28, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L649:
	cmpq	%r15, %rdx
	jnb	.L359
	movzbl	(%rdi,%rdx), %edx
	testl	%edx, %edx
	je	.L359
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L697
	movl	28(%rbx), %edx
	addl	$1, %edx
.L362:
	movl	%edx, 28(%rbx)
	movzbl	(%rcx), %edx
	testl	%edx, %edx
	je	.L359
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L698
	addl	$1, 28(%rbx)
.L359:
	movl	$23, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L673:
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	jne	.L622
	jmp	.L299
.L639:
	movq	%rax, 16(%rbx)
	leal	1(%r13), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rsi), %eax
	testl	%eax, %eax
	jne	.L624
	jmp	.L313
.L280:
	leal	1(%r13), %edx
	movq	%rax, 16(%rbx)
	movl	%edx, 28(%rbx)
	movzbl	(%rdi), %edx
	testl	%edx, %edx
	je	.L367
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L699
	addl	$2, %r13d
	movl	%r13d, 28(%rbx)
.L367:
	movl	$25, (%r9)
	movq	32(%rbx), %rax
	jmp	.L611
.L279:
	leaq	2(%rdx), %rcx
	cmpq	%r15, %rcx
	jnb	.L620
	cmpb	$61, 2(%rdi,%rdx)
	jne	.L620
	movq	%rbx, %rdi
.L614:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$43, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L687:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$55, (%r9)
	movq	32(%rbx), %rax
	jmp	.L611
.L658:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L317
.L676:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L313
.L678:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L315
.L677:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L321
.L679:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L319
.L692:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L323
.L684:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L299
.L695:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L372
.L693:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L253
.L694:
	addl	$1, 24(%rbx)
	movq	%rax, %rdx
	movl	$1, 28(%rbx)
	jmp	.L373
.L690:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L246
.L674:
	addl	$1, %esi
	movl	$1, 28(%rbx)
	movl	%esi, 24(%rbx)
	jmp	.L351
.L689:
	addl	$1, %esi
	movl	$1, 28(%rbx)
	movl	%esi, 24(%rbx)
	jmp	.L337
.L699:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L367
.L696:
	movl	16(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L335
.L698:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L359
.L697:
	addl	$1, 24(%rbx)
	movl	$1, %edx
	jmp	.L362
.L675:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$48, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L244:
	cmpl	$124, %ebp
	jne	.L289
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jb	.L342
	movzbl	(%rdi,%rdx), %edx
	testl	%edx, %edx
	je	.L343
	jmp	.L344
.L630:
	movq	g_compilation_arena(%rip), %rax
	testq	%rax, %rax
	jne	.L408
	cmpq	%rcx, %rdx
	jb	.L409
	movl	$1, %edi
	xorl	%ebp, %ebp
	jmp	.L154
.L647:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	movq	%r9, 16(%rsp)
	movq	%rdx, 24(%rsp)
	call	dief@PLT
	movq	24(%rsp), %rsi
	movq	16(%rsp), %r9
	addq	(%rbx), %rsi
	jmp	.L155
.L640:
	movq	(%rbx), %rdi
	jmp	.L341
.L691:
	cmpl	$62, %r10d
	je	.L326
	cmpl	$61, %r10d
	jne	.L303
	cmpb	$61, 2(%rdi,%rdx)
	jne	.L303
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$51, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
	.p2align 4,,10
	.p2align 3
.L326:
	movzbl	2(%rdi,%rdx), %eax
	movq	%rbx, %rdi
	cmpb	$62, %al
	je	.L613
	cmpb	$61, %al
	je	.L700
	call	lx_get
	call	lx_get
	movl	$49, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L686:
	cmpl	$62, %ebp
	jne	.L701
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jnb	.L377
	cmpb	$62, 1(%rdi,%rdx)
	jne	.L285
	leaq	2(%rdx), %rcx
	cmpq	%r15, %rcx
	jnb	.L607
	cmpb	$61, 2(%rdi,%rdx)
	jne	.L607
	movq	%rbx, %rdi
.L613:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$44, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L700:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$50, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L659:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	movq	%r9, 24(%rsp)
	call	dief@PLT
	movq	16(%rbx), %rbp
	movq	8(%rbx), %r10
	movq	24(%rsp), %r9
	jmp	.L199
.L645:
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
.L688:
	movzbl	1(%rdi,%rdx), %eax
	cmpb	$61, %al
	jne	.L292
	jmp	.L290
.L302:
	cmpl	$33, %r10d
	jne	.L303
	cmpb	$61, 2(%rdi,%rdx)
	jne	.L303
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$52, (%r9)
	movq	32(%rbx), %rax
	jmp	.L610
.L672:
	cmpl	$33, %ebp
	jne	.L251
	leaq	1(%rdx), %rax
	cmpq	%r15, %rax
	jb	.L355
	jmp	.L357
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
	je	.L703
	movl	24(%rbx), %eax
	testl	%eax, %eax
	jne	.L708
.L703:
	movq	$0, 8(%rbx)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L708:
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
.LC29:
	.string	"EOF"
.LC30:
	.string	"identifier"
.LC31:
	.string	"number"
.LC32:
	.string	"string"
.LC33:
	.string	"character"
.LC34:
	.string	"if"
.LC35:
	.string	"("
.LC36:
	.string	")"
.LC37:
	.string	"{"
.LC38:
	.string	"}"
.LC39:
	.string	","
.LC40:
	.string	";"
.LC41:
	.string	"="
.LC42:
	.string	"=="
.LC43:
	.string	"!="
.LC44:
	.string	"<"
.LC45:
	.string	"<="
.LC46:
	.string	">"
.LC47:
	.string	">="
.LC48:
	.string	"<<"
.LC49:
	.string	">>"
.LC50:
	.string	"+"
.LC51:
	.string	"-"
.LC52:
	.string	"*"
.LC53:
	.string	"/"
.LC54:
	.string	"%"
.LC55:
	.string	"!"
.LC56:
	.string	"?"
.LC57:
	.string	"["
.LC58:
	.string	"]"
.LC59:
	.string	"++"
.LC60:
	.string	"--"
.LC61:
	.string	"=+"
.LC62:
	.string	"=-"
.LC63:
	.string	"=*"
.LC64:
	.string	"=/"
.LC65:
	.string	"=%"
.LC66:
	.string	"=<<"
.LC67:
	.string	"=>>"
.LC68:
	.string	"=&"
.LC69:
	.string	"=|"
.LC70:
	.string	"=<"
.LC71:
	.string	"=<="
.LC72:
	.string	"=>"
.LC73:
	.string	"=>="
.LC74:
	.string	"==="
.LC75:
	.string	"=!="
.LC76:
	.string	"&"
.LC77:
	.string	"|"
.LC78:
	.string	"||"
.LC79:
	.string	":"
.LC80:
	.string	"<unknown token>"
	.text
	.p2align 4
	.globl	tk_name
	.type	tk_name, @function
tk_name:
.LFB24:
	.cfi_startproc
	cmpl	$61, %edi
	ja	.L710
	leaq	.L712(%rip), %rdx
	movl	%edi, %edi
	movslq	(%rdx,%rdi,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L712:
	.long	.L773-.L712
	.long	.L774-.L712
	.long	.L771-.L712
	.long	.L770-.L712
	.long	.L769-.L712
	.long	.L768-.L712
	.long	.L767-.L712
	.long	.L766-.L712
	.long	.L765-.L712
	.long	.L764-.L712
	.long	.L763-.L712
	.long	.L762-.L712
	.long	.L761-.L712
	.long	.L760-.L712
	.long	.L759-.L712
	.long	.L758-.L712
	.long	.L757-.L712
	.long	.L756-.L712
	.long	.L755-.L712
	.long	.L754-.L712
	.long	.L753-.L712
	.long	.L752-.L712
	.long	.L751-.L712
	.long	.L750-.L712
	.long	.L749-.L712
	.long	.L748-.L712
	.long	.L747-.L712
	.long	.L746-.L712
	.long	.L745-.L712
	.long	.L744-.L712
	.long	.L743-.L712
	.long	.L742-.L712
	.long	.L741-.L712
	.long	.L740-.L712
	.long	.L739-.L712
	.long	.L738-.L712
	.long	.L737-.L712
	.long	.L736-.L712
	.long	.L735-.L712
	.long	.L734-.L712
	.long	.L733-.L712
	.long	.L732-.L712
	.long	.L731-.L712
	.long	.L730-.L712
	.long	.L729-.L712
	.long	.L728-.L712
	.long	.L727-.L712
	.long	.L726-.L712
	.long	.L725-.L712
	.long	.L724-.L712
	.long	.L723-.L712
	.long	.L722-.L712
	.long	.L721-.L712
	.long	.L720-.L712
	.long	.L719-.L712
	.long	.L718-.L712
	.long	.L717-.L712
	.long	.L716-.L712
	.long	.L715-.L712
	.long	.L714-.L712
	.long	.L713-.L712
	.long	.L711-.L712
	.text
	.p2align 4,,10
	.p2align 3
.L774:
	leaq	.LC30(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L773:
	leaq	.LC29(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L711:
	leaq	.LC17(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L728:
	leaq	.LC68(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L729:
	leaq	.LC67(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L730:
	leaq	.LC66(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L731:
	leaq	.LC65(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L732:
	leaq	.LC64(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L733:
	leaq	.LC63(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L734:
	leaq	.LC62(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L735:
	leaq	.LC61(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L736:
	leaq	.LC60(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L737:
	leaq	.LC59(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L738:
	leaq	.LC55(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L739:
	leaq	.LC54(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L740:
	leaq	.LC53(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L741:
	leaq	.LC52(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L742:
	leaq	.LC51(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L719:
	leaq	.LC77(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L720:
	leaq	.LC76(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L721:
	leaq	.LC75(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L722:
	leaq	.LC74(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L723:
	leaq	.LC73(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L724:
	leaq	.LC72(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L725:
	leaq	.LC71(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L726:
	leaq	.LC70(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L715:
	leaq	.LC14(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L716:
	leaq	.LC79(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L717:
	leaq	.LC56(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L718:
	leaq	.LC78(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L713:
	leaq	.LC16(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L727:
	leaq	.LC69(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L769:
	leaq	.LC33(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L770:
	leaq	.LC32(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L765:
	leaq	.LC9(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L766:
	leaq	.LC8(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L767:
	leaq	.LC34(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L768:
	leaq	.LC7(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L757:
	leaq	.LC38(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L758:
	leaq	.LC37(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L759:
	leaq	.LC36(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L760:
	leaq	.LC35(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L761:
	leaq	.LC11(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L762:
	leaq	.LC13(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L763:
	leaq	.LC12(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L764:
	leaq	.LC10(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L714:
	leaq	.LC15(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L771:
	leaq	.LC31(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L743:
	leaq	.LC50(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L744:
	leaq	.LC49(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L745:
	leaq	.LC48(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L746:
	leaq	.LC47(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L747:
	leaq	.LC46(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L748:
	leaq	.LC45(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L749:
	leaq	.LC44(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L750:
	leaq	.LC43(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L751:
	leaq	.LC42(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L752:
	leaq	.LC41(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L753:
	leaq	.LC58(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L754:
	leaq	.LC57(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L755:
	leaq	.LC40(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L756:
	leaq	.LC39(%rip), %rax
	ret
.L710:
	leaq	.LC80(%rip), %rax
	ret
	.cfi_endproc
.LFE24:
	.size	tk_name, .-tk_name
	.section	.note.GNU-stack,"",@progbits
