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
	je	.L10
	addl	$1, 28(%rdi)
.L1:
	movl	%edx, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L10:
	addl	$1, 24(%rdi)
	movl	$1, 28(%rdi)
	jmp	.L1
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
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %r9
	movl	%esi, %r11d
	subq	$96, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rbx
	movq	%rbx, 88(%rsp)
	movl	%edx, %ebx
	movq	16(%rdi), %rdx
	cmpq	8(%rdi), %rdx
	jnb	.L12
	movq	(%rdi), %rax
	movzbl	(%rax,%rdx), %r10d
	movl	%r10d, %eax
	testl	%r10d, %r10d
	je	.L12
	addq	$1, %rdx
	movq	%rdx, 16(%rdi)
	cmpl	$10, %r10d
	je	.L33
	addl	$1, 28(%rdi)
	cmpb	$48, %r10b
	jg	.L15
	cmpb	$33, %r10b
	jle	.L23
	subl	$34, %eax
	cmpb	$14, %al
	ja	.L23
	leaq	.L17(%rip), %rdx
	movzbl	%al, %eax
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L17:
	.long	.L22-.L17
	.long	.L23-.L17
	.long	.L23-.L17
	.long	.L23-.L17
	.long	.L23-.L17
	.long	.L21-.L17
	.long	.L20-.L17
	.long	.L19-.L17
	.long	.L18-.L17
	.long	.L23-.L17
	.long	.L23-.L17
	.long	.L23-.L17
	.long	.L23-.L17
	.long	.L23-.L17
	.long	.L25-.L17
	.text
	.p2align 4,,10
	.p2align 3
.L12:
	movq	32(%r9), %rdi
	movl	%r11d, %esi
	leaq	.LC0(%rip), %r8
	movl	%ebx, %edx
	movl	$8, %ecx
	movq	%r9, (%rsp)
	movl	%r11d, 8(%rsp)
	call	error_at_location@PLT
	movl	8(%rsp), %r11d
	movq	(%rsp), %r9
	xorl	%r10d, %r10d
.L23:
	movl	%r10d, %ecx
	leaq	.LC1(%rip), %rdx
	xorl	%eax, %eax
	movq	%r9, (%rsp)
	movl	$64, %esi
	leaq	16(%rsp), %rdi
	movl	%r10d, 8(%rsp)
	movl	%r11d, 12(%rsp)
	call	snprintf@PLT
	movq	(%rsp), %r9
	movl	12(%rsp), %esi
	movl	%ebx, %edx
	leaq	16(%rsp), %r8
	movl	$8, %ecx
	movq	32(%r9), %rdi
	call	error_at_location@PLT
	movl	8(%rsp), %r10d
	.p2align 4
	.p2align 3
.L11:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L34
	addq	$96, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	movl	%r10d, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L18:
	.cfi_restore_state
	movl	$42, %r10d
	jmp	.L11
	.p2align 4,,10
	.p2align 3
.L19:
	movl	$41, %r10d
	jmp	.L11
	.p2align 4,,10
	.p2align 3
.L21:
	movl	$39, %r10d
	jmp	.L11
	.p2align 4,,10
	.p2align 3
.L22:
	movl	$34, %r10d
	jmp	.L11
	.p2align 4,,10
	.p2align 3
.L15:
	cmpb	$110, %r10b
	je	.L26
	cmpb	$116, %r10b
	je	.L27
	cmpb	$101, %r10b
	jne	.L23
	movl	$4, %r10d
	jmp	.L11
	.p2align 4,,10
	.p2align 3
.L33:
	addl	$1, 24(%rdi)
	movl	$1, 28(%rdi)
	jmp	.L23
	.p2align 4,,10
	.p2align 3
.L27:
	movl	$9, %r10d
	jmp	.L11
	.p2align 4,,10
	.p2align 3
.L26:
	movl	$10, %r10d
	jmp	.L11
	.p2align 4,,10
	.p2align 3
.L25:
	xorl	%r10d, %r10d
	jmp	.L11
	.p2align 4,,10
	.p2align 3
.L20:
	movl	$40, %r10d
	jmp	.L11
.L34:
	call	__stack_chk_fail@PLT
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
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %r9
	movl	%esi, %r11d
	subq	$96, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rbx
	movq	%rbx, 88(%rsp)
	movl	%edx, %ebx
	testb	$4, g_extensions(%rip)
	je	.L58
	movq	16(%rdi), %rax
	cmpq	8(%rdi), %rax
	jnb	.L39
	movq	(%rdi), %rdx
	movzbl	(%rdx,%rax), %r10d
	testl	%r10d, %r10d
	je	.L39
	addq	$1, %rax
	movq	%rax, 16(%rdi)
	cmpl	$10, %r10d
	je	.L59
	addl	$1, 28(%rdi)
	cmpb	$92, %r10b
	je	.L37
	jle	.L60
	cmpb	$114, %r10b
	je	.L48
	cmpb	$116, %r10b
	je	.L49
	cmpb	$110, %r10b
	jne	.L43
	movl	$10, %r10d
.L35:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L61
	addq	$96, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	movl	%r10d, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L39:
	.cfi_restore_state
	movq	32(%r9), %rdi
	movl	%r11d, %esi
	leaq	.LC0(%rip), %r8
	movl	%ebx, %edx
	movl	$8, %ecx
	movq	%r9, (%rsp)
	movl	%r11d, 8(%rsp)
	call	error_at_location@PLT
	movq	(%rsp), %r9
	movl	8(%rsp), %r11d
	xorl	%r10d, %r10d
.L43:
	movl	%r10d, %ecx
	leaq	.LC3(%rip), %rdx
	xorl	%eax, %eax
	movq	%r9, (%rsp)
	movl	$64, %esi
	leaq	16(%rsp), %rdi
	movl	%r10d, 8(%rsp)
	movl	%r11d, 12(%rsp)
	call	snprintf@PLT
	movq	(%rsp), %r9
	movl	12(%rsp), %esi
	movl	%ebx, %edx
	leaq	16(%rsp), %r8
	movl	$8, %ecx
	movq	32(%r9), %rdi
	call	error_at_location@PLT
	movl	8(%rsp), %r10d
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L58:
	movl	g_pedantic(%rip), %eax
	testl	%eax, %eax
	jne	.L62
.L37:
	movl	$92, %r10d
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L60:
	cmpb	$39, %r10b
	je	.L45
	cmpb	$48, %r10b
	je	.L46
	cmpb	$34, %r10b
	jne	.L43
	movl	$34, %r10d
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L62:
	movq	32(%rdi), %rdi
	leaq	.LC2(%rip), %r8
	movl	$8, %ecx
	movl	%ebx, %edx
	call	error_at_location@PLT
	movl	$92, %r10d
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L59:
	addl	$1, 24(%rdi)
	movl	$1, 28(%rdi)
	jmp	.L43
	.p2align 4,,10
	.p2align 3
.L49:
	movl	$9, %r10d
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L48:
	movl	$13, %r10d
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L46:
	xorl	%r10d, %r10d
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L45:
	movl	$39, %r10d
	jmp	.L35
.L61:
	call	__stack_chk_fail@PLT
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	16(%rdi), %rax
	movq	%rbp, 16(%rsp)
	.cfi_offset 6, -32
	movq	8(%rdi), %rbp
	movq	%rbx, 8(%rsp)
	.cfi_offset 3, -40
	movq	%rdi, %rbx
.L64:
	cmpq	%rbp, %rax
	jnb	.L63
	movq	%r13, 32(%rsp)
	.cfi_offset 13, -16
	movq	(%rbx), %r13
	movq	%r12, 24(%rsp)
	.cfi_offset 12, -24
	movzbl	0(%r13,%rax), %r12d
	testl	%r12d, %r12d
	je	.L134
	call	__ctype_b_loc@PLT
	movq	(%rax), %rsi
	.p2align 4
	.p2align 3
.L66:
	movl	%r12d, %eax
	testb	$32, 1(%rsi,%rax,2)
	je	.L138
	movq	16(%rbx), %rax
	cmpq	%rbp, %rax
	jnb	.L134
	movzbl	0(%r13,%rax), %edx
	testl	%edx, %edx
	je	.L134
	leaq	1(%rax), %rcx
	movq	%rcx, 16(%rbx)
	cmpl	$10, %edx
	je	.L139
	movl	28(%rbx), %edi
	leal	1(%rdi), %edx
.L68:
	movl	%edx, 28(%rbx)
	cmpq	%rbp, %rcx
	jnb	.L134
	movzbl	1(%r13,%rax), %r12d
	testl	%r12d, %r12d
	jne	.L66
	.p2align 4
	.p2align 3
.L134:
	movq	24(%rsp), %r12
	.cfi_restore 12
	movq	32(%rsp), %r13
	.cfi_restore 13
.L63:
	movq	8(%rsp), %rbx
	movq	16(%rsp), %rbp
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L138:
	.cfi_def_cfa_offset 48
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	cmpl	$47, %r12d
	jne	.L134
	movq	16(%rbx), %rax
	leaq	1(%rax), %rdx
	cmpq	%rbp, %rdx
	jnb	.L134
	leaq	0(%r13,%rdx), %rsi
	movzbl	(%rsi), %ecx
	cmpb	$42, %cl
	je	.L140
	cmpb	$47, %cl
	jne	.L134
	testb	$2, g_extensions(%rip)
	jne	.L90
	movl	g_pedantic(%rip), %eax
	testl	%eax, %eax
	je	.L134
	movl	28(%rbx), %edx
	movl	24(%rbx), %esi
	movl	$8, %ecx
	leaq	.LC5(%rip), %r8
	movq	32(%rbx), %rdi
	movq	24(%rsp), %r12
	.cfi_remember_state
	.cfi_restore 12
	movq	32(%rsp), %r13
	.cfi_restore 13
	movq	8(%rsp), %rbx
	movq	16(%rsp), %rbp
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	jmp	error_at_location@PLT
	.p2align 4,,10
	.p2align 3
.L139:
	.cfi_restore_state
	addl	$1, 24(%rbx)
	movl	$1, %edx
	jmp	.L68
	.p2align 4,,10
	.p2align 3
.L90:
	cmpq	%rbp, %rax
	jnb	.L134
	movzbl	0(%r13,%rax), %ecx
	testl	%ecx, %ecx
	je	.L96
	movq	%rdx, 16(%rbx)
	cmpl	$10, %ecx
	je	.L141
	addl	$1, 28(%rbx)
	movzbl	(%rsi), %ecx
.L93:
	testl	%ecx, %ecx
	je	.L142
	addq	$2, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %ecx
	je	.L143
	movl	28(%rbx), %edi
	leal	1(%rdi), %edx
.L95:
	movl	%edx, 28(%rbx)
	cmpq	%rbp, %rax
	jnb	.L134
.L96:
	movzbl	0(%r13,%rax), %edx
	testl	%edx, %edx
	je	.L135
	cmpl	$10, %edx
	je	.L135
	addq	$1, %rax
	addl	$1, 28(%rbx)
	movq	%rax, 16(%rbx)
	cmpq	%rax, %rbp
	jne	.L96
.L136:
	movq	24(%rsp), %r12
	.cfi_remember_state
	.cfi_restore 12
	movq	32(%rsp), %r13
	.cfi_restore 13
	jmp	.L64
.L140:
	.cfi_restore_state
	cmpq	%rbp, %rax
	jnb	.L89
	movzbl	0(%r13,%rax), %ecx
	testl	%ecx, %ecx
	je	.L89
	movq	%rdx, 16(%rbx)
	cmpl	$10, %ecx
	je	.L144
	addl	$1, 28(%rbx)
	movzbl	(%rsi), %ecx
.L73:
	testl	%ecx, %ecx
	je	.L145
	addq	$2, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %ecx
	jne	.L85
	jmp	.L137
	.p2align 4,,10
	.p2align 3
.L77:
	movl	28(%rbx), %edx
	movl	24(%rbx), %esi
	leaq	.LC4(%rip), %r8
	movl	$2, %ecx
	movq	32(%rbx), %rdi
	call	error_at_location@PLT
	movq	16(%rbx), %rax
	movq	8(%rbx), %rbp
	cmpq	%rbp, %rax
	jnb	.L89
	movq	(%rbx), %rdx
	movzbl	(%rdx,%rax), %edx
	testl	%edx, %edx
	je	.L89
.L81:
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	jne	.L85
.L137:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	.p2align 4
	.p2align 3
.L89:
	cmpq	%rbp, %rax
	jnb	.L77
.L147:
	movq	(%rbx), %rcx
	movzbl	(%rcx,%rax), %edx
	testl	%edx, %edx
	je	.L77
	cmpl	$42, %edx
	jne	.L81
	leaq	1(%rax), %rdx
	cmpq	%rbp, %rdx
	jnb	.L82
	addq	%rdx, %rcx
	cmpb	$47, (%rcx)
	je	.L146
	movq	%rdx, 16(%rbx)
	movq	%rdx, %rax
.L85:
	addl	$1, 28(%rbx)
	cmpq	%rbp, %rax
	jb	.L147
	jmp	.L77
	.p2align 4,,10
	.p2align 3
.L82:
	movq	%rdx, 16(%rbx)
	movq	%rdx, %rax
	jmp	.L85
.L146:
	movl	28(%rbx), %esi
	movq	%rdx, 16(%rbx)
	leal	1(%rsi), %edi
	movl	%edi, 28(%rbx)
	movzbl	(%rcx), %ecx
	testl	%ecx, %ecx
	je	.L101
	addq	$2, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %ecx
	je	.L148
	addl	$2, %esi
	movq	24(%rsp), %r12
	.cfi_remember_state
	.cfi_restore 12
	movq	32(%rsp), %r13
	.cfi_restore 13
	movl	%esi, 28(%rbx)
	jmp	.L64
.L101:
	.cfi_restore_state
	movq	%rdx, %rax
	jmp	.L136
.L141:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	movzbl	(%rsi), %ecx
	jmp	.L93
.L135:
	movq	16(%rbx), %rax
	movq	24(%rsp), %r12
	.cfi_remember_state
	.cfi_restore 12
	movq	32(%rsp), %r13
	.cfi_restore 13
	jmp	.L64
.L143:
	.cfi_restore_state
	addl	$1, 24(%rbx)
	movl	$1, %edx
	jmp	.L95
.L148:
	addl	$1, 24(%rbx)
	movq	24(%rsp), %r12
	.cfi_remember_state
	.cfi_restore 12
	movl	$1, 28(%rbx)
	movq	32(%rsp), %r13
	.cfi_restore 13
	jmp	.L64
.L144:
	.cfi_restore_state
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	movzbl	(%rsi), %ecx
	jmp	.L73
.L142:
	movq	%rdx, %rax
	jmp	.L96
.L145:
	movq	%rdx, %rax
	jmp	.L89
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
	movl	$0, 16(%rdi)
	movq	$0, 24(%rdi)
	movl	%edx, 32(%rdi)
	movl	%ecx, 36(%rdi)
	movq	%r8, 40(%rdi)
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
	subq	$200, %rsp
	.cfi_def_cfa_offset 208
	movq	%rbp, 160(%rsp)
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	movq	%rsi, %rdi
	movq	%r12, 168(%rsp)
	movq	%rbx, 152(%rsp)
	.cfi_offset 12, -40
	.cfi_offset 3, -56
	movq	%fs:40, %rbx
	movq	%rbx, 136(%rsp)
	movq	%rsi, %rbx
	call	lx_skip_ws_and_comments
	movq	24(%rbx), %rax
	movq	16(%rbx), %r12
	movq	8(%rbx), %rdx
	movq	%rax, (%rsp)
	cmpq	%rdx, %r12
	jnb	.L151
	movq	(%rbx), %rdi
	movq	%r13, 176(%rsp)
	leaq	(%rdi,%r12), %rsi
	.cfi_offset 13, -32
	movzbl	(%rsi), %r13d
	testl	%r13d, %r13d
	je	.L662
	movq	%rdx, 40(%rsp)
	movq	%rdi, 32(%rsp)
	movq	%rdx, 24(%rsp)
	movq	%rsi, 8(%rsp)
	movb	%r13b, 16(%rsp)
	call	__ctype_b_loc@PLT
	movq	8(%rsp), %rsi
	movq	24(%rsp), %r11
	movq	(%rax), %r8
	movzbl	16(%rsp), %eax
	movq	32(%rsp), %rdi
	movq	40(%rsp), %rdx
	movq	%rax, %r10
	movzwl	(%r8,%rax,2), %eax
	movl	%eax, %ecx
	shrw	$10, %cx
	andl	$1, %ecx
	cmpl	$95, %r13d
	sete	%r9b
	orb	%r9b, %cl
	je	.L616
	movq	%r12, %rcx
.L154:
	cmpq	%rdx, %rcx
	jnb	.L663
.L159:
	movzbl	(%rdi,%rcx), %eax
	movzbl	%al, %r9d
	testb	$8, (%r8,%r9,2)
	jne	.L161
	cmpb	$95, %al
	je	.L162
	cmpb	$46, %al
	jne	.L664
.L162:
	addq	$1, %rcx
	movq	%rcx, 16(%rbx)
.L157:
	addl	$1, 28(%rbx)
	cmpq	%rdx, %rcx
	jb	.L159
.L663:
	testb	$8, (%r8)
	jne	.L154
	movq	g_compilation_arena(%rip), %rax
	testq	%rax, %rax
	je	.L665
.L430:
	movq	%r12, %rdx
	movq	%rdi, %rsi
	movq	%rax, %rdi
	xorl	%r12d, %r12d
	call	arena_xstrdup_range@PLT
	movq	%rax, %r13
.L164:
	leaq	.LC7(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	movl	$5, %eax
	je	.L167
	cmpb	$105, 0(%r13)
	jne	.L462
	cmpb	$102, 1(%r13)
	je	.L666
.L462:
	leaq	.LC8(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	movl	$7, %eax
	je	.L167
	leaq	.LC9(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	movl	$8, %eax
	je	.L167
	leaq	.LC10(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	movl	$9, %eax
	je	.L167
	leaq	.LC11(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	movl	$12, %eax
	je	.L167
	leaq	.LC12(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	movl	$10, %eax
	je	.L167
	leaq	.LC13(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	movl	$11, %eax
	je	.L167
	leaq	.LC14(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	movl	$58, %eax
	je	.L167
	leaq	.LC15(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	movl	$59, %eax
	je	.L167
	leaq	.LC16(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	movl	$60, %eax
	je	.L167
	leaq	.LC17(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	cmpl	$1, %eax
	sbbl	%eax, %eax
	andl	$60, %eax
	addl	$1, %eax
	.p2align 4
	.p2align 3
.L167:
	movl	%eax, 0(%rbp)
	movq	32(%rbx), %rdx
	movq	(%rsp), %rax
	movq	%r13, 8(%rbp)
	movl	%r12d, 16(%rbp)
	movq	176(%rsp), %r13
	.cfi_remember_state
	.cfi_restore 13
	movq	$0, 24(%rbp)
	movq	%rax, 32(%rbp)
	movq	%rdx, 40(%rbp)
	jmp	.L150
	.p2align 4,,10
	.p2align 3
.L662:
	.cfi_restore_state
	movq	176(%rsp), %r13
	.cfi_restore 13
.L151:
	movq	32(%rbx), %rax
	movq	(%rsp), %rsi
	movl	$0, 0(%rbp)
	movq	$0, 8(%rbp)
	movl	$0, 16(%rbp)
	movq	$0, 24(%rbp)
	movq	%rsi, 32(%rbp)
	movq	%rax, 40(%rbp)
.L150:
	movq	136(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L667
	movq	%rbp, %rax
	movq	152(%rsp), %rbx
	movq	160(%rsp), %rbp
	movq	168(%rsp), %r12
	addq	$200, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L616:
	.cfi_def_cfa_offset 208
	.cfi_offset 13, -32
	movq	(%rsp), %xmm0
	movq	%r15, 192(%rsp)
	pshufd	$0xe5, %xmm0, %xmm1
	movd	%xmm0, 8(%rsp)
	.cfi_offset 15, -16
	movd	%xmm1, %r15d
	testb	$8, %ah
	jne	.L668
	movq	%r14, 184(%rsp)
	.cfi_offset 14, -24
	movq	%r12, %r14
	cmpl	$34, %r13d
	je	.L669
	cmpl	$39, %r13d
	je	.L670
	cmpl	$43, %r13d
	je	.L671
	cmpl	$45, %r13d
	jne	.L672
	leaq	1(%r12), %rax
	cmpq	%r11, %rax
	jnb	.L372
	leaq	(%rdi,%rax), %rcx
	movzbl	(%rcx), %edx
	cmpb	$45, %dl
	je	.L673
	testb	$8, g_extensions(%rip)
	je	.L674
	cmpb	$61, %dl
	je	.L675
	.p2align 4
	.p2align 3
.L372:
	cmpq	%r11, %r14
	jb	.L676
	.p2align 4
	.p2align 3
.L401:
	subl	$33, %r10d
	cmpb	$92, %r10b
	ja	.L402
	leaq	.L404(%rip), %rdx
	movzbl	%r10b, %r10d
	movslq	(%rdx,%r10,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L404:
	.long	.L381-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L420-.L404
	.long	.L419-.L404
	.long	.L402-.L404
	.long	.L418-.L404
	.long	.L417-.L404
	.long	.L416-.L404
	.long	.L415-.L404
	.long	.L414-.L404
	.long	.L413-.L404
	.long	.L402-.L404
	.long	.L412-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L411-.L404
	.long	.L410-.L404
	.long	.L386-.L404
	.long	.L375-.L404
	.long	.L398-.L404
	.long	.L409-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L408-.L404
	.long	.L402-.L404
	.long	.L407-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L402-.L404
	.long	.L406-.L404
	.long	.L405-.L404
	.long	.L403-.L404
	.text
	.p2align 4,,10
	.p2align 3
.L668:
	.cfi_restore 14
	cmpl	$48, %r13d
	jne	.L456
	leaq	1(%r12), %rax
	cmpq	%rdx, %rax
	jnb	.L171
	leaq	(%rdi,%rax), %r10
	movzbl	(%r10), %r9d
	andl	$-33, %r9d
	cmpb	$88, %r9b
	je	.L677
.L171:
	leal	1(%r15), %ecx
	movq	%r14, 184(%rsp)
	movq	%rax, 16(%rbx)
	movl	%ecx, 28(%rbx)
	.cfi_offset 14, -24
	.p2align 4
	.p2align 3
.L188:
	cmpq	%rdx, %rax
	jnb	.L678
.L193:
	movzbl	(%rdi,%rax), %ecx
	movzbl	%cl, %r9d
	testb	$8, 1(%r8,%r9,2)
	je	.L195
	testl	%ecx, %ecx
	je	.L188
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %ecx
	je	.L679
	addl	$1, 28(%rbx)
	cmpq	%rdx, %rax
	jb	.L193
.L678:
	testb	$8, 1(%r8)
	jne	.L188
.L195:
	movl	$8, 32(%rsp)
	movl	$1, %ecx
	jmp	.L185
	.p2align 4,,10
	.p2align 3
.L161:
	.cfi_restore 14
	.cfi_restore 15
	testl	%eax, %eax
	je	.L154
	addq	$1, %rcx
	movq	%rcx, 16(%rbx)
	cmpl	$10, %eax
	jne	.L157
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L154
	.p2align 4,,10
	.p2align 3
.L456:
	.cfi_offset 15, -16
	movq	%r14, 184(%rsp)
	movq	%r12, %rax
	.cfi_offset 14, -24
	.p2align 4
	.p2align 3
.L170:
	cmpq	%rdx, %rax
	jnb	.L680
.L200:
	movzbl	(%rdi,%rax), %r9d
	movzbl	%r9b, %r10d
	testb	$8, 1(%r8,%r10,2)
	je	.L202
	testl	%r9d, %r9d
	je	.L170
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %r9d
	je	.L681
	addl	$1, 28(%rbx)
	cmpq	%rdx, %rax
	jb	.L200
.L680:
	testb	$8, 1(%r8)
	jne	.L170
.L202:
	movl	$10, 32(%rsp)
.L185:
	cmpq	%rax, %r12
	jb	.L682
	movl	$1, %edi
	xorl	%r14d, %r14d
.L203:
	movb	%cl, 24(%rsp)
	movq	%rsi, 16(%rsp)
	call	malloc@PLT
	movq	16(%rsp), %rsi
	movzbl	24(%rsp), %ecx
	testq	%rax, %rax
	movq	%rax, %r13
	je	.L683
.L204:
	movq	%r14, %rdx
	movq	%r13, %rdi
	movb	%cl, 16(%rsp)
	movq	%r14, %r12
	call	memcpy@PLT
	movb	$0, 0(%r13,%r14)
	call	__errno_location@PLT
	movl	$0, (%rax)
	movq	%rax, %r14
	cmpb	$0, 16(%rsp)
	je	.L205
	testq	%r12, %r12
	je	.L458
	leaq	(%r12,%r13), %r11
	movq	%r13, %r10
	xorl	%r12d, %r12d
	jmp	.L208
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L207:
	subl	$48, %r9d
	addq	$1, %r10
	movslq	%r9d, %r9
	leaq	(%r9,%r12,8), %r12
	cmpq	%r10, %r11
	je	.L206
.L208:
	movsbl	(%r10), %r9d
	movl	%r9d, %eax
	subl	$48, %eax
	cmpb	$9, %al
	jbe	.L207
	movl	%r9d, %ecx
	movl	$64, %esi
	leaq	64(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC19(%rip), %rdx
	movq	%r10, 32(%rsp)
	movq	%r11, 24(%rsp)
	movl	%r9d, 16(%rsp)
	call	snprintf@PLT
	movq	32(%rbx), %rdi
	movl	8(%rsp), %esi
	movl	%r15d, %edx
	leaq	64(%rsp), %r8
	movl	$8, %ecx
	call	error_at_location@PLT
	movq	32(%rsp), %r10
	movq	24(%rsp), %r11
	movl	16(%rsp), %r9d
	jmp	.L207
	.p2align 4,,10
	.p2align 3
.L665:
	.cfi_restore 14
	.cfi_restore 15
	movq	%r15, 192(%rsp)
	.cfi_offset 15, -16
.L431:
	subq	%r12, %rcx
	movq	%rcx, %r15
	leaq	1(%rcx), %rdi
.L165:
	movq	%rsi, 8(%rsp)
	call	malloc@PLT
	movq	8(%rsp), %rsi
	testq	%rax, %rax
	movq	%rax, %r13
	je	.L684
.L166:
	movq	%r15, %rdx
	movq	%r13, %rdi
	movl	$1, %r12d
	call	memcpy@PLT
	movb	$0, 0(%r13,%r15)
	movq	192(%rsp), %r15
	.cfi_restore 15
	jmp	.L164
	.p2align 4,,10
	.p2align 3
.L682:
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	subq	%r12, %rax
	movq	%rax, %r14
	leaq	1(%rax), %rdi
	jmp	.L203
	.p2align 4,,10
	.p2align 3
.L666:
	.cfi_restore 14
	.cfi_restore 15
	movl	$6, %eax
	cmpb	$0, 2(%r13)
	je	.L167
	jmp	.L462
	.p2align 4,,10
	.p2align 3
.L672:
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movl	24(%rbx), %esi
	testb	$8, g_extensions(%rip)
	jne	.L264
	movl	g_pedantic(%rip), %r8d
	testl	%r8d, %r8d
	je	.L308
	cmpb	$47, %r10b
	jg	.L309
	cmpb	$36, %r10b
	jg	.L685
.L363:
	cmpl	$33, %r13d
	jne	.L372
	leaq	1(%r12), %rax
	cmpq	%rdx, %rax
	jnb	.L686
	movq	(%rbx), %rdi
	leaq	(%rdi,%rax), %rcx
	cmpb	$61, (%rcx)
	jne	.L687
	cmpq	%rdx, %r12
	jnb	.L382
	movzbl	(%rdi,%r12), %edx
	testl	%edx, %edx
	je	.L382
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L688
	movl	28(%rbx), %eax
	addl	$1, %eax
.L384:
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L382
	addq	$2, %r12
	movq	%r12, 16(%rbx)
	cmpl	$10, %eax
	je	.L689
	addl	$1, 28(%rbx)
.L382:
	movl	$23, 0(%rbp)
	movq	32(%rbx), %rax
	.p2align 4
	.p2align 3
.L639:
	movq	$0, 8(%rbp)
	movl	$0, 16(%rbp)
	movq	$0, 24(%rbp)
.L640:
	movq	(%rsp), %rsi
	movq	%rax, 40(%rbp)
	movq	176(%rsp), %r13
	.cfi_remember_state
	.cfi_restore 13
	movq	184(%rsp), %r14
	.cfi_restore 14
	movq	%rsi, 32(%rbp)
	movq	192(%rsp), %r15
	.cfi_restore 15
	jmp	.L150
	.p2align 4,,10
	.p2align 3
.L402:
	.cfi_restore_state
	movl	%r13d, %ecx
	movl	$64, %esi
	leaq	64(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC27(%rip), %rdx
	call	snprintf@PLT
	movq	32(%rbx), %rdi
	movl	8(%rsp), %esi
	movl	%r15d, %edx
	leaq	64(%rsp), %r8
	movl	$8, %ecx
	call	error_at_location@PLT
	movl	$0, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L420:
	movl	$34, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L416:
	movl	$32, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L417:
	movl	$14, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L418:
	movl	$13, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L419:
	movl	$53, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L410:
	movl	$18, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L411:
	movl	$57, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L412:
	movl	$33, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L413:
	movl	$31, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L414:
	movl	$17, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L415:
	movl	$30, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L403:
	movl	$16, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L406:
	movl	$15, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L407:
	movl	$20, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L408:
	movl	$19, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L409:
	movl	$56, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L702:
	cmpl	$62, %r13d
	jne	.L690
	leaq	1(%r12), %rax
	cmpq	%rdx, %rax
	jnb	.L399
	cmpb	$62, 1(%rdi,%r12)
	je	.L691
.L306:
	cmpq	%rdx, %rax
	jnb	.L393
.L434:
	cmpb	$61, (%rdi,%rax)
	je	.L692
.L393:
	cmpq	%rdx, %r12
	jb	.L399
.L398:
	movl	$26, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L405:
	movl	$54, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L686:
	cmpq	%rdx, %r12
	jnb	.L381
	movq	(%rbx), %rdx
	movzbl	(%rdx,%r12), %edx
	testl	%edx, %edx
	jne	.L376
.L381:
	movl	$35, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L458:
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L206:
	movq	%r13, %rdi
	call	free@PLT
	movl	(%r14), %r10d
	testl	%r10d, %r10d
	jne	.L693
.L210:
	movl	$2, 0(%rbp)
	movq	32(%rbx), %rax
	movq	$0, 8(%rbp)
	movl	$0, 16(%rbp)
	movq	%r12, 24(%rbp)
	jmp	.L640
	.p2align 4,,10
	.p2align 3
.L681:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L170
	.p2align 4,,10
	.p2align 3
.L205:
	movl	32(%rsp), %edx
	xorl	%esi, %esi
	movq	%r13, %rdi
	call	strtoull@PLT
	movq	%rax, %r12
	cmpl	$34, (%r14)
	jne	.L206
	movq	32(%rbx), %rdi
	movl	8(%rsp), %esi
	movl	$8, %ecx
	movl	%r15d, %edx
	leaq	.LC20(%rip), %r8
	call	error_at_location@PLT
	jmp	.L206
	.p2align 4,,10
	.p2align 3
.L693:
	movq	32(%rbx), %rdi
	movl	8(%rsp), %esi
	movl	$8, %ecx
	movl	%r15d, %edx
	leaq	.LC20(%rip), %r8
	call	error_at_location@PLT
	jmp	.L210
	.p2align 4,,10
	.p2align 3
.L671:
	leaq	1(%r12), %rax
	cmpq	%r11, %rax
	jnb	.L694
	leaq	(%rdi,%rax), %rcx
	cmpb	$43, (%rcx)
	je	.L695
	testb	$8, g_extensions(%rip)
	jne	.L696
.L259:
	movl	g_pedantic(%rip), %ecx
	testl	%ecx, %ecx
	je	.L372
	cmpq	%rdx, %rax
	jnb	.L372
	cmpb	$61, (%rdi,%rax)
	jne	.L372
.L270:
	movq	32(%rbx), %rdi
	movl	8(%rsp), %esi
	movl	%r15d, %edx
	movl	$8, %ecx
	leaq	.LC25(%rip), %r8
	movb	%r10b, 16(%rsp)
	call	error_at_location@PLT
	movq	16(%rbx), %r12
	movq	8(%rbx), %rdx
	movzbl	16(%rsp), %r10d
	movq	%r12, %r14
	movq	%rdx, %r11
.L312:
	cmpl	$124, %r13d
	jne	.L363
	leaq	1(%r12), %rax
	cmpq	%rdx, %rax
	jb	.L697
	cmpq	%rdx, %r12
	jnb	.L405
	movq	(%rbx), %rdi
.L289:
	movzbl	(%rdi,%r12), %edx
	testl	%edx, %edx
	je	.L405
	.p2align 4
	.p2align 3
.L376:
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	jne	.L303
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L401
	.p2align 4,,10
	.p2align 3
.L677:
	.cfi_restore 14
	testb	$1, g_extensions(%rip)
	jne	.L172
	movl	g_pedantic(%rip), %r11d
	testl	%r11d, %r11d
	jne	.L173
	movq	%rax, 16(%rbx)
.L174:
	addl	$1, 28(%rbx)
.L175:
	movq	32(%rbx), %rax
	movq	(%rsp), %rsi
	movl	$2, 0(%rbp)
	movq	$0, 8(%rbp)
	movq	176(%rsp), %r13
	.cfi_restore 13
	movl	$0, 16(%rbp)
	movq	192(%rsp), %r15
	.cfi_restore 15
	movq	$0, 24(%rbp)
	movq	%rsi, 32(%rbp)
	movq	%rax, 40(%rbp)
	jmp	.L150
.L308:
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	cmpl	$61, %r13d
	je	.L635
	cmpl	$60, %r13d
	jne	.L355
	leaq	1(%r12), %rax
	cmpq	%rdx, %rax
	jnb	.L356
.L638:
	addq	%rax, %rdi
	cmpb	$60, (%rdi)
	je	.L698
	movl	$60, %edx
	cmpb	$61, (%rdi)
	jne	.L376
	movq	%rax, 16(%rbx)
.L302:
	leal	1(%r15), %edx
	movl	%edx, 28(%rbx)
	movzbl	(%rdi), %edx
	testl	%edx, %edx
	je	.L391
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L699
	leal	2(%r15), %eax
	movl	%eax, 28(%rbx)
.L391:
	movl	$25, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
	.p2align 4,,10
	.p2align 3
.L679:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L188
	.p2align 4,,10
	.p2align 3
.L264:
	cmpl	$42, %r13d
	je	.L700
	cmpl	$47, %r13d
	jne	.L279
	leaq	1(%r12), %rax
	cmpq	%rdx, %rax
	jnb	.L372
	addq	%rax, %rdi
	cmpb	$61, (%rdi)
	jne	.L372
	movq	%rax, 16(%rbx)
	leal	1(%r15), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rdi), %eax
	testl	%eax, %eax
	je	.L335
.L655:
	addq	$2, %r12
	movq	%r12, 16(%rbx)
	cmpl	$10, %eax
	je	.L701
	leal	2(%r15), %eax
	movl	%eax, 28(%rbx)
.L335:
	movl	$41, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L288:
	cmpl	$60, %r13d
	jne	.L702
	leaq	1(%r12), %rax
	cmpq	%rdx, %rax
	jnb	.L356
	cmpb	$60, 1(%rdi,%r12)
	je	.L703
	addq	%rax, %rdi
	cmpb	$61, (%rdi)
	movq	%rax, 16(%rbx)
	je	.L302
.L303:
	addl	$1, 28(%rbx)
	jmp	.L401
	.p2align 4,,10
	.p2align 3
.L669:
	leal	1(%r15), %eax
	leaq	1(%r12), %r13
	movl	$1, %edi
	movq	%r11, 16(%rsp)
	movq	%r13, 16(%rbx)
	movl	%eax, 28(%rbx)
	call	malloc@PLT
	movq	16(%rsp), %r11
	testq	%rax, %rax
	movq	%rax, %r10
	je	.L704
.L212:
	xorl	%r12d, %r12d
	movl	$1, %r14d
	jmp	.L228
	.p2align 4,,10
	.p2align 3
.L709:
	movq	(%rbx), %rcx
	movzbl	(%rcx,%r13), %eax
	movl	%eax, %edx
	testl	%eax, %eax
	je	.L213
	addq	$1, %r13
	movq	%r13, 16(%rbx)
	cmpl	$10, %eax
	je	.L705
	addl	$1, 28(%rbx)
	cmpl	$34, %eax
	je	.L706
	cmpl	$42, %eax
	je	.L707
	cmpl	$92, %eax
	jne	.L215
	movl	8(%rsp), %esi
	movl	%r15d, %edx
	movq	%rbx, %rdi
	movq	%r10, 16(%rsp)
	call	parse_backslash_escape
	movq	16(%rsp), %r10
	movl	%eax, %edx
	.p2align 4
	.p2align 3
.L215:
	leaq	2(%r12), %rax
	cmpq	%rax, %r14
	jb	.L708
.L225:
	movq	16(%rbx), %r13
	movq	8(%rbx), %r11
	movb	%dl, (%r10,%r12)
	addq	$1, %r12
.L228:
	cmpq	%r11, %r13
	jb	.L709
.L213:
	movq	32(%rbx), %rdi
	movl	8(%rsp), %esi
	movl	%r15d, %edx
	movl	$8, %ecx
	leaq	.LC21(%rip), %r8
	movq	%r10, 16(%rsp)
	call	error_at_location@PLT
	movq	16(%rsp), %r10
	xorl	%edx, %edx
	jmp	.L215
	.p2align 4,,10
	.p2align 3
.L707:
	cmpq	%r11, %r13
	jnb	.L222
	movzbl	(%rcx,%r13), %eax
	cmpb	$48, %al
	jg	.L220
	cmpb	$33, %al
	jg	.L710
.L222:
	movl	$42, %edx
	jmp	.L215
	.p2align 4,,10
	.p2align 3
.L708:
	leaq	8(%r14,%r14), %rax
	movq	%r10, %rdi
	movb	%dl, 16(%rsp)
	movq	%rax, %rsi
	movq	%rax, %r14
	call	realloc@PLT
	movzbl	16(%rsp), %edx
	testq	%rax, %rax
	movq	%rax, %r10
	jne	.L225
	movq	%rax, 16(%rsp)
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	movb	%dl, 24(%rsp)
	call	dief@PLT
	movzbl	24(%rsp), %edx
	movq	16(%rsp), %r10
	jmp	.L225
	.p2align 4,,10
	.p2align 3
.L706:
	movq	g_compilation_arena(%rip), %rdi
	movb	$0, (%r10,%r12)
	movl	$1, %eax
	testq	%rdi, %rdi
	je	.L229
	leaq	1(%r12), %rsi
	movq	%r10, 8(%rsp)
	call	arena_alloc@PLT
	movq	8(%rsp), %rsi
	leaq	1(%r12), %rdx
	movq	%rax, %rdi
	movq	%rax, %r13
	call	memcpy@PLT
	movq	8(%rsp), %rdi
	call	free@PLT
	movq	%r13, %r10
	xorl	%eax, %eax
.L229:
	movl	$3, 0(%rbp)
	movq	32(%rbx), %rdx
	movq	%r10, 8(%rbp)
	movl	%eax, 16(%rbp)
	movq	$0, 24(%rbp)
.L641:
	movq	(%rsp), %rax
	movq	%rdx, 40(%rbp)
	movq	176(%rsp), %r13
	.cfi_remember_state
	.cfi_restore 13
	movq	184(%rsp), %r14
	.cfi_restore 14
	movq	%rax, 32(%rbp)
	movq	192(%rsp), %r15
	.cfi_restore 15
	jmp	.L150
	.p2align 4,,10
	.p2align 3
.L670:
	.cfi_restore_state
	leaq	1(%r12), %rax
	leal	1(%r15), %edx
	xorl	%r13d, %r13d
	movq	$0, 48(%rsp)
	movq	%rax, 16(%rbx)
	movl	%edx, 28(%rbx)
	movq	$0, 56(%rsp)
	cmpq	%r11, %rax
	jnb	.L231
.L715:
	movq	(%rbx), %rdx
	movzbl	(%rdx,%rax), %r12d
	testl	%r12d, %r12d
	je	.L231
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %r12d
	je	.L711
	addl	$1, 28(%rbx)
	cmpl	$39, %r12d
	je	.L712
	cmpq	$1, %r13
	jbe	.L243
	testb	$32, g_extensions(%rip)
	je	.L241
.L244:
	cmpq	$4, %r13
	je	.L713
.L243:
	cmpl	$42, %r12d
	je	.L714
	cmpl	$92, %r12d
	jne	.L634
	movl	8(%rsp), %esi
	movl	%r15d, %edx
	movq	%rbx, %rdi
	call	parse_backslash_escape
	movl	%eax, %r12d
.L634:
	movq	16(%rbx), %rax
	movq	8(%rbx), %r11
.L234:
	movl	%r12d, 48(%rsp,%r13,4)
	addq	$1, %r13
	cmpq	%r11, %rax
	jb	.L715
.L231:
	movq	32(%rbx), %rdi
	movl	8(%rsp), %esi
	movl	$8, %ecx
	movl	%r15d, %edx
	leaq	.LC23(%rip), %r8
	call	error_at_location@PLT
	cmpq	$1, %r13
	jbe	.L242
	testb	$32, g_extensions(%rip)
	je	.L460
	cmpq	$4, %r13
	je	.L716
.L242:
	movq	16(%rbx), %rax
	movq	8(%rbx), %r11
	xorl	%r12d, %r12d
	jmp	.L234
	.p2align 4,,10
	.p2align 3
.L714:
	movq	16(%rbx), %rax
	movq	8(%rbx), %r11
	cmpq	%r11, %rax
	jnb	.L234
	movq	(%rbx), %rdx
	movzbl	(%rdx,%rax), %edx
	cmpb	$48, %dl
	jg	.L248
	cmpb	$33, %dl
	jle	.L234
	subl	$34, %edx
	movl	$16833, %ecx
	btq	%rdx, %rcx
	jnc	.L234
.L251:
	movl	8(%rsp), %esi
	movl	%r15d, %edx
	movq	%rbx, %rdi
	call	parse_escape
	movq	8(%rbx), %r11
	movl	%eax, %r12d
	movq	16(%rbx), %rax
	jmp	.L234
.L712:
	movslq	48(%rsp), %rax
	cmpl	$1, %r13d
	jle	.L255
	movslq	52(%rsp), %rdx
	salq	$8, %rdx
	orq	%rdx, %rax
	cmpl	$2, %r13d
	je	.L255
	movslq	56(%rsp), %rdx
	salq	$16, %rdx
	orq	%rdx, %rax
	cmpl	$4, %r13d
	jne	.L255
	movslq	60(%rsp), %rdx
	salq	$24, %rdx
	orq	%rdx, %rax
	.p2align 4
	.p2align 3
.L255:
	movl	$4, 0(%rbp)
	movq	32(%rbx), %rdx
	movq	$0, 8(%rbp)
	movl	$0, 16(%rbp)
	movq	%rax, 24(%rbp)
	jmp	.L641
	.p2align 4,,10
	.p2align 3
.L705:
	addl	$1, 24(%rbx)
	movl	$10, %edx
	movl	$1, 28(%rbx)
	jmp	.L215
.L279:
	cmpl	$37, %r13d
	jne	.L282
	leaq	1(%r12), %rax
	cmpq	%rdx, %rax
	jnb	.L372
	addq	%rax, %rdi
	cmpb	$61, (%rdi)
	jne	.L372
	movq	%rax, 16(%rbx)
	leal	1(%r15), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rdi), %eax
	testl	%eax, %eax
	je	.L337
.L657:
	addq	$2, %r12
	movq	%r12, 16(%rbx)
	cmpl	$10, %eax
	je	.L717
	leal	2(%r15), %eax
	movl	%eax, 28(%rbx)
.L337:
	movl	$42, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L690:
	cmpl	$61, %r13d
	jne	.L363
	.p2align 4
	.p2align 3
.L635:
	leaq	1(%r12), %rax
	cmpq	%rdx, %rax
	jnb	.L318
	leaq	(%rdi,%rax), %r8
	movzbl	(%r8), %r11d
	movl	%r11d, %ecx
	cmpb	$43, %r11b
	je	.L718
	cmpb	$60, %r11b
	jg	.L322
	cmpb	$36, %r11b
	jle	.L323
	subl	$37, %ecx
	cmpb	$23, %cl
	ja	.L324
	leaq	.L326(%rip), %r9
	movzbl	%cl, %ecx
	movslq	(%r9,%rcx,4), %rcx
	addq	%r9, %rcx
	jmp	*%rcx
	.section	.rodata
	.align 4
	.align 4
.L326:
	.long	.L330-.L326
	.long	.L329-.L326
	.long	.L324-.L326
	.long	.L324-.L326
	.long	.L324-.L326
	.long	.L324-.L326
	.long	.L324-.L326
	.long	.L324-.L326
	.long	.L328-.L326
	.long	.L324-.L326
	.long	.L327-.L326
	.long	.L324-.L326
	.long	.L324-.L326
	.long	.L324-.L326
	.long	.L324-.L326
	.long	.L324-.L326
	.long	.L324-.L326
	.long	.L324-.L326
	.long	.L324-.L326
	.long	.L324-.L326
	.long	.L324-.L326
	.long	.L324-.L326
	.long	.L324-.L326
	.long	.L325-.L326
	.text
.L324:
	cmpl	$61, %r11d
	je	.L347
.L323:
	cmpl	$33, %r11d
	je	.L719
.L349:
	cmpq	%rdx, %rax
	jnb	.L318
	cmpb	$61, (%r8)
	je	.L374
	movzbl	(%rdi,%r12), %edx
	testl	%edx, %edx
	jne	.L376
.L375:
	movl	$21, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L325:
	movzbl	2(%rdi,%r12), %edx
	leaq	2(%r12), %rcx
	cmpb	$60, %dl
	je	.L643
	cmpb	$61, %dl
	je	.L720
	movq	%rax, 16(%rbx)
	leal	1(%r15), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	je	.L350
	movq	%rcx, 16(%rbx)
	cmpl	$10, %eax
	je	.L721
	leal	2(%r15), %eax
	movl	%eax, 28(%rbx)
.L350:
	movl	$47, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L327:
	movq	%rax, 16(%rbx)
	leal	1(%r15), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	jne	.L655
	jmp	.L335
.L328:
	movq	%rax, 16(%rbx)
	leal	1(%r15), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	je	.L333
.L653:
	addq	$2, %r12
	movq	%r12, 16(%rbx)
	cmpl	$10, %eax
	je	.L722
	leal	2(%r15), %eax
	movl	%eax, 28(%rbx)
.L333:
	movl	$39, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L329:
	movq	%rax, 16(%rbx)
	leal	1(%r15), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	je	.L339
.L659:
	addq	$2, %r12
	movq	%r12, 16(%rbx)
	cmpl	$10, %eax
	je	.L723
	leal	2(%r15), %eax
	movl	%eax, 28(%rbx)
.L339:
	movl	$45, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L330:
	movq	%rax, 16(%rbx)
	leal	1(%r15), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	jne	.L657
	jmp	.L337
	.p2align 4,,10
	.p2align 3
.L694:
	testb	$8, g_extensions(%rip)
	jne	.L372
	jmp	.L259
.L220:
	subl	$101, %eax
	cmpb	$15, %al
	ja	.L222
	movl	$33281, %edx
	btq	%rax, %rdx
	jnc	.L222
.L223:
	movl	8(%rsp), %esi
	movl	%r15d, %edx
	movq	%rbx, %rdi
	movq	%r10, 16(%rsp)
	call	parse_escape
	movq	16(%rsp), %r10
	movl	%eax, %edx
	jmp	.L215
.L460:
	xorl	%r12d, %r12d
.L241:
	movq	32(%rbx), %rdi
	movl	8(%rsp), %esi
	movl	$8, %ecx
	movl	%r15d, %edx
	leaq	.LC24(%rip), %r8
	call	error_at_location@PLT
	jmp	.L244
.L172:
	.cfi_restore 14
	leal	1(%r15), %r9d
	movq	%r14, 184(%rsp)
	movq	%rax, 16(%rbx)
	movl	%r9d, 28(%rbx)
	movzbl	(%r10), %r9d
	testl	%r9d, %r9d
	.cfi_offset 14, -24
	je	.L179
	leaq	2(%r12), %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %r9d
	je	.L724
	leal	2(%r15), %r9d
	movl	%r9d, 28(%rbx)
	.p2align 4
	.p2align 3
.L179:
	cmpq	%rdx, %rax
	jnb	.L725
.L184:
	movzbl	(%rdi,%rax), %r9d
	movzbl	%r9b, %r10d
	testb	$16, 1(%r8,%r10,2)
	je	.L187
	testl	%r9d, %r9d
	je	.L179
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %r9d
	je	.L726
	addl	$1, 28(%rbx)
	cmpq	%rdx, %rax
	jb	.L184
.L725:
	testb	$16, 1(%r8)
	jne	.L179
.L187:
	movl	$16, 32(%rsp)
	jmp	.L185
.L674:
	movl	g_pedantic(%rip), %r9d
	testl	%r9d, %r9d
	je	.L372
	cmpb	$61, 1(%rdi,%r12)
	jne	.L372
	jmp	.L270
.L282:
	cmpl	$38, %r13d
	jne	.L285
	leaq	1(%r12), %rax
	cmpq	%rdx, %rax
	jnb	.L372
	addq	%rax, %rdi
	cmpb	$61, (%rdi)
	jne	.L372
	movq	%rax, 16(%rbx)
	leal	1(%r15), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rdi), %eax
	testl	%eax, %eax
	jne	.L659
	jmp	.L339
	.p2align 4,,10
	.p2align 3
.L700:
	leaq	1(%r12), %rax
	cmpq	%rdx, %rax
	jnb	.L372
	addq	%rax, %rdi
	cmpb	$61, (%rdi)
	jne	.L372
	movq	%rax, 16(%rbx)
	leal	1(%r15), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rdi), %eax
	testl	%eax, %eax
	je	.L277
	addq	$2, %r12
	movq	%r12, 16(%rbx)
	cmpl	$10, %eax
	je	.L727
	leal	2(%r15), %eax
	movl	%eax, 28(%rbx)
.L277:
	movl	$40, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L726:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L179
.L696:
	cmpb	$61, (%rcx)
	jne	.L372
	movq	%rax, 16(%rbx)
	leal	1(%r15), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L320
.L651:
	addq	$2, %r12
	movq	%r12, 16(%rbx)
	cmpl	$10, %eax
	je	.L728
	leal	2(%r15), %eax
	movl	%eax, 28(%rbx)
.L320:
	movl	$38, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L173:
	.cfi_restore 14
	movq	32(%rbx), %rdi
	movl	8(%rsp), %esi
	movl	$8, %ecx
	movl	%r15d, %edx
	leaq	.LC18(%rip), %r8
	call	error_at_location@PLT
	movq	16(%rbx), %rax
	cmpq	8(%rbx), %rax
	jnb	.L175
	movq	(%rbx), %rdx
	movzbl	(%rdx,%rax), %edx
	testl	%edx, %edx
	je	.L175
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	jne	.L174
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L175
.L710:
	.cfi_offset 14, -24
	subl	$34, %eax
	movl	$16865, %edx
	btq	%rax, %rdx
	jnc	.L222
	jmp	.L223
.L711:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	cmpq	$1, %r13
	jbe	.L234
	testb	$32, g_extensions(%rip)
	je	.L241
	cmpq	$4, %r13
	jne	.L234
	movq	32(%rbx), %rdi
	movl	8(%rsp), %esi
	movl	$8, %ecx
	movl	%r15d, %edx
	leaq	.LC22(%rip), %r8
	call	error_at_location@PLT
	jmp	.L634
	.p2align 4,,10
	.p2align 3
.L285:
	cmpl	$124, %r13d
	jne	.L288
	leaq	1(%r12), %rax
	cmpq	%rdx, %rax
	jnb	.L289
	leaq	(%rdi,%rax), %rcx
	cmpb	$61, (%rcx)
	je	.L729
.L435:
	movzbl	(%rdi,%rax), %ecx
.L311:
	cmpb	$124, %cl
	je	.L730
.L365:
	movq	%r12, %r14
	movq	%rdx, %r11
	jmp	.L372
.L356:
	addl	$1, 28(%rbx)
	movq	%rax, 16(%rbx)
.L386:
	movl	$24, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L248:
	subl	$101, %edx
	cmpb	$15, %dl
	ja	.L234
	movl	$33281, %ecx
	btq	%rdx, %rcx
	jc	.L251
	jmp	.L234
.L730:
	testb	$16, g_extensions(%rip)
	jne	.L731
	movl	g_pedantic(%rip), %esi
	testl	%esi, %esi
	je	.L365
	movq	32(%rbx), %rdi
	movl	8(%rsp), %esi
	movl	$8, %ecx
	movl	%r15d, %edx
	leaq	.LC26(%rip), %r8
	movb	%r10b, 16(%rsp)
	call	error_at_location@PLT
	movq	16(%rbx), %r14
	movq	8(%rbx), %r11
	movzbl	16(%rsp), %r10d
	jmp	.L372
.L713:
	movq	32(%rbx), %rdi
	movl	8(%rsp), %esi
	movl	$8, %ecx
	movl	%r15d, %edx
	leaq	.LC22(%rip), %r8
	call	error_at_location@PLT
	jmp	.L243
.L309:
	cmpb	$124, %r10b
	jne	.L308
	leaq	1(%r12), %rax
	cmpq	%rdx, %rax
	jnb	.L312
	movzbl	1(%rdi,%r12), %ecx
	cmpb	$61, %cl
	jne	.L311
	jmp	.L270
	.p2align 4,,10
	.p2align 3
.L322:
	cmpb	$124, %r11b
	jne	.L732
	movq	%rax, 16(%rbx)
	leal	1(%r15), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	je	.L341
.L661:
	addq	$2, %r12
	movq	%r12, 16(%rbx)
	cmpl	$10, %eax
	je	.L733
	leal	2(%r15), %eax
	movl	%eax, 28(%rbx)
.L341:
	movl	$46, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L355:
	cmpl	$62, %r13d
	jne	.L312
	leaq	1(%r12), %rax
	cmpq	%rdx, %rax
	jnb	.L399
	leaq	(%rdi,%rax), %rcx
	cmpb	$62, (%rcx)
	jne	.L434
.L360:
	leal	1(%r15), %r8d
.L425:
	movq	%rax, 16(%rbx)
	movl	%r8d, 28(%rbx)
	movzbl	(%rcx), %edx
	testl	%edx, %edx
	je	.L361
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L734
	addl	$1, %r8d
	movl	%r8d, 28(%rbx)
.L361:
	movl	$29, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
	.p2align 4,,10
	.p2align 3
.L399:
	movzbl	(%rdi,%r12), %edx
	testl	%edx, %edx
	jne	.L376
	jmp	.L398
	.p2align 4,,10
	.p2align 3
.L695:
	movq	%rax, 16(%rbx)
	leal	1(%r15), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L261
	addq	$2, %r12
	movq	%r12, 16(%rbx)
	cmpl	$10, %eax
	je	.L735
	leal	2(%r15), %eax
	movl	%eax, 28(%rbx)
.L261:
	movl	$36, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L673:
	movq	%rax, 16(%rbx)
	leal	1(%r15), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	je	.L267
	addq	$2, %r12
	movq	%r12, 16(%rbx)
	cmpl	$10, %eax
	je	.L736
	leal	2(%r15), %eax
	movl	%eax, 28(%rbx)
.L267:
	movl	$37, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L692:
	cmpq	%rdx, %r12
	jnb	.L394
	movzbl	(%rdi,%r12), %edx
	testl	%edx, %edx
	je	.L395
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L737
	addl	$1, 28(%rbx)
	movq	%rax, %r12
.L395:
	movzbl	(%rdi,%r12), %eax
	testl	%eax, %eax
	je	.L394
	addq	$1, %r12
	movq	%r12, 16(%rbx)
	cmpl	$10, %eax
	je	.L738
	addl	$1, 28(%rbx)
.L394:
	movl	$27, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L716:
	movq	32(%rbx), %rdi
	movl	8(%rsp), %esi
	movl	$8, %ecx
	movl	%r15d, %edx
	leaq	.LC22(%rip), %r8
	xorl	%r12d, %r12d
	call	error_at_location@PLT
	jmp	.L634
.L347:
	cmpb	$61, 2(%rdi,%r12)
	jne	.L349
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$51, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
	.p2align 4,,10
	.p2align 3
.L719:
	cmpb	$61, 2(%rdi,%r12)
	jne	.L349
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$52, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
	.p2align 4,,10
	.p2align 3
.L697:
	movq	(%rbx), %rdi
	jmp	.L435
.L718:
	movq	%rax, 16(%rbx)
	leal	1(%r15), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	jne	.L651
	jmp	.L320
.L675:
	movq	%rax, 16(%rbx)
	leal	1(%r15), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	jne	.L653
	jmp	.L333
.L318:
	addl	$1, 28(%rbx)
	movq	%rax, 16(%rbx)
	jmp	.L375
.L729:
	movq	%rax, 16(%rbx)
	leal	1(%r15), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%rcx), %eax
	testl	%eax, %eax
	jne	.L661
	jmp	.L341
.L698:
	leal	1(%r15), %edx
	movq	%rax, 16(%rbx)
	movl	%edx, 28(%rbx)
	movzbl	(%rdi), %edx
	testl	%edx, %edx
	je	.L358
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L739
	leal	2(%r15), %eax
	movl	%eax, 28(%rbx)
.L358:
	movl	$28, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L374:
	leal	1(%r15), %edx
	movq	%rax, 16(%rbx)
	movl	%edx, 28(%rbx)
	movzbl	(%r8), %edx
	testl	%edx, %edx
	je	.L377
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L740
	leal	2(%r15), %eax
	movl	%eax, 28(%rbx)
.L377:
	movl	$22, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L703:
	leaq	2(%r12), %rcx
	cmpq	%rdx, %rcx
	jnb	.L638
	cmpb	$61, 2(%rdi,%r12)
	jne	.L638
.L643:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$43, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L731:
	cmpq	%rdx, %r12
	jnb	.L367
	movzbl	(%rdi,%r12), %edx
	testl	%edx, %edx
	je	.L368
	movq	%rax, 16(%rbx)
	cmpl	$10, %edx
	je	.L741
	addl	$1, 28(%rbx)
	movq	%rax, %r12
.L368:
	movzbl	(%rdi,%r12), %eax
	testl	%eax, %eax
	je	.L367
	addq	$1, %r12
	movq	%r12, 16(%rbx)
	cmpl	$10, %eax
	je	.L742
	addl	$1, 28(%rbx)
.L367:
	movl	$55, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L724:
	movl	8(%rsp), %r11d
	movl	$1, 28(%rbx)
	leal	1(%r11), %r9d
	movl	%r9d, 24(%rbx)
	jmp	.L179
.L667:
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	movq	%r13, 176(%rsp)
	movq	%r14, 184(%rsp)
	movq	%r15, 192(%rsp)
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	call	__stack_chk_fail@PLT
.L733:
	movl	8(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L341
.L701:
	movl	8(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L335
.L723:
	movl	8(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L339
.L722:
	movl	8(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L333
.L717:
	movl	8(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L337
.L728:
	movl	8(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L320
.L736:
	movl	8(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L267
.L735:
	movl	8(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L261
.L737:
	addl	$1, 24(%rbx)
	movq	%rax, %r12
	movl	$1, 28(%rbx)
	jmp	.L395
.L738:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L394
.L740:
	addl	$1, %esi
	movl	$1, 28(%rbx)
	movl	%esi, 24(%rbx)
	jmp	.L377
.L689:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L382
.L688:
	addl	$1, 24(%rbx)
	movl	$1, %eax
	jmp	.L384
.L741:
	addl	$1, 24(%rbx)
	movq	%rax, %r12
	movl	$1, 28(%rbx)
	jmp	.L368
.L742:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L367
.L699:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L391
.L734:
	addl	$1, %esi
	movl	$1, 28(%rbx)
	movl	%esi, 24(%rbx)
	jmp	.L361
.L720:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$48, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L721:
	movl	8(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L350
.L727:
	movl	8(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L277
.L739:
	movl	8(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L358
.L691:
	leaq	2(%r12), %rcx
	cmpq	%rdx, %rcx
	jb	.L438
	leaq	(%rdi,%rax), %rcx
	leal	1(%r15), %r8d
	cmpb	$62, (%rcx)
	je	.L425
	jmp	.L306
	.p2align 4,,10
	.p2align 3
.L438:
	cmpb	$61, 2(%rdi,%r12)
	je	.L642
	leaq	(%rdi,%rax), %rcx
	cmpb	$62, (%rcx)
	je	.L360
	jmp	.L306
.L642:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$44, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L685:
	leal	-37(%r10), %eax
	movl	$1379, %ecx
	btq	%rax, %rcx
	jnc	.L372
	leaq	1(%r12), %rax
	cmpq	%rdx, %rax
	jnb	.L363
	cmpb	$61, 1(%rdi,%r12)
	je	.L270
	cmpl	$62, %r13d
	je	.L306
	jmp	.L372
.L732:
	cmpl	$62, %r11d
	jne	.L324
	movzbl	2(%rdi,%r12), %edx
	leaq	2(%r12), %rcx
	cmpb	$62, %dl
	je	.L642
	cmpb	$61, %dl
	je	.L743
	movq	%rax, 16(%rbx)
	leal	1(%r15), %eax
	movl	%eax, 28(%rbx)
	movzbl	(%r8), %eax
	testl	%eax, %eax
	je	.L353
	movq	%rcx, 16(%rbx)
	cmpl	$10, %eax
	je	.L744
	leal	2(%r15), %eax
	movl	%eax, 28(%rbx)
.L353:
	movl	$49, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L743:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$50, 0(%rbp)
	movq	32(%rbx), %rax
	jmp	.L639
.L744:
	movl	8(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	jmp	.L353
.L687:
	cmpq	%rdx, %r12
	jnb	.L381
	jmp	.L400
.L676:
	movq	(%rbx), %rdi
.L400:
	movzbl	(%rdi,%r14), %edx
	testl	%edx, %edx
	je	.L401
	leaq	1(%r14), %rax
	jmp	.L376
.L664:
	.cfi_restore 14
	.cfi_restore 15
	movq	g_compilation_arena(%rip), %rax
	movq	%r15, 192(%rsp)
	.cfi_offset 15, -16
	testq	%rax, %rax
	je	.L163
	movq	192(%rsp), %r15
	.cfi_remember_state
	.cfi_restore 15
	jmp	.L430
	.p2align 4,,10
	.p2align 3
.L163:
	.cfi_restore_state
	cmpq	%rcx, %r12
	jb	.L431
	movl	$1, %edi
	xorl	%r15d, %r15d
	jmp	.L165
.L704:
	.cfi_offset 14, -24
	movq	%rax, 16(%rsp)
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	16(%rbx), %r13
	movq	8(%rbx), %r11
	movq	16(%rsp), %r10
	jmp	.L212
.L683:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	movb	%cl, 16(%rsp)
	call	dief@PLT
	movq	(%rbx), %rsi
	movzbl	16(%rsp), %ecx
	addq	%r12, %rsi
	jmp	.L204
.L684:
	.cfi_restore 14
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	(%rbx), %rsi
	addq	%r12, %rsi
	jmp	.L166
	.cfi_endproc
.LFE22:
	.size	lx_next, .-lx_next
	.p2align 4
	.globl	tok_free
	.type	tok_free, @function
tok_free:
.LFB23:
	.cfi_startproc
	movq	%rdi, %rax
	movq	8(%rdi), %rdi
	testq	%rdi, %rdi
	je	.L751
	movl	16(%rax), %edx
	testl	%edx, %edx
	jne	.L754
.L751:
	movq	$0, 8(%rax)
	ret
	.p2align 4,,10
	.p2align 3
.L754:
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rax, 8(%rsp)
	call	free@PLT
	movq	8(%rsp), %rax
	movq	$0, 8(%rax)
	addq	$24, %rsp
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
	ja	.L756
	leaq	.L758(%rip), %rdx
	movl	%edi, %edi
	movslq	(%rdx,%rdi,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L758:
	.long	.L819-.L758
	.long	.L820-.L758
	.long	.L817-.L758
	.long	.L816-.L758
	.long	.L815-.L758
	.long	.L814-.L758
	.long	.L813-.L758
	.long	.L812-.L758
	.long	.L811-.L758
	.long	.L810-.L758
	.long	.L809-.L758
	.long	.L808-.L758
	.long	.L807-.L758
	.long	.L806-.L758
	.long	.L805-.L758
	.long	.L804-.L758
	.long	.L803-.L758
	.long	.L802-.L758
	.long	.L801-.L758
	.long	.L800-.L758
	.long	.L799-.L758
	.long	.L798-.L758
	.long	.L797-.L758
	.long	.L796-.L758
	.long	.L795-.L758
	.long	.L794-.L758
	.long	.L793-.L758
	.long	.L792-.L758
	.long	.L791-.L758
	.long	.L790-.L758
	.long	.L789-.L758
	.long	.L788-.L758
	.long	.L787-.L758
	.long	.L786-.L758
	.long	.L785-.L758
	.long	.L784-.L758
	.long	.L783-.L758
	.long	.L782-.L758
	.long	.L781-.L758
	.long	.L780-.L758
	.long	.L779-.L758
	.long	.L778-.L758
	.long	.L777-.L758
	.long	.L776-.L758
	.long	.L775-.L758
	.long	.L774-.L758
	.long	.L773-.L758
	.long	.L772-.L758
	.long	.L771-.L758
	.long	.L770-.L758
	.long	.L769-.L758
	.long	.L768-.L758
	.long	.L767-.L758
	.long	.L766-.L758
	.long	.L765-.L758
	.long	.L764-.L758
	.long	.L763-.L758
	.long	.L762-.L758
	.long	.L761-.L758
	.long	.L760-.L758
	.long	.L759-.L758
	.long	.L757-.L758
	.text
	.p2align 4,,10
	.p2align 3
.L820:
	leaq	.LC29(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L819:
	leaq	.LC28(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L757:
	leaq	.LC17(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L759:
	leaq	.LC16(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L760:
	leaq	.LC15(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L761:
	leaq	.LC14(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L762:
	leaq	.LC78(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L763:
	leaq	.LC55(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L764:
	leaq	.LC77(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L765:
	leaq	.LC76(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L766:
	leaq	.LC75(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L767:
	leaq	.LC74(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L768:
	leaq	.LC73(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L769:
	leaq	.LC72(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L770:
	leaq	.LC71(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L771:
	leaq	.LC70(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L772:
	leaq	.LC69(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L773:
	leaq	.LC68(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L774:
	leaq	.LC67(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L775:
	leaq	.LC66(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L776:
	leaq	.LC65(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L777:
	leaq	.LC64(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L778:
	leaq	.LC63(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L779:
	leaq	.LC62(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L780:
	leaq	.LC61(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L781:
	leaq	.LC60(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L782:
	leaq	.LC59(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L783:
	leaq	.LC58(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L784:
	leaq	.LC54(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L785:
	leaq	.LC53(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L786:
	leaq	.LC52(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L787:
	leaq	.LC51(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L788:
	leaq	.LC50(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L789:
	leaq	.LC49(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L790:
	leaq	.LC48(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L791:
	leaq	.LC47(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L792:
	leaq	.LC46(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L793:
	leaq	.LC45(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L794:
	leaq	.LC44(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L795:
	leaq	.LC43(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L796:
	leaq	.LC42(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L797:
	leaq	.LC41(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L798:
	leaq	.LC40(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L799:
	leaq	.LC57(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L800:
	leaq	.LC56(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L801:
	leaq	.LC39(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L802:
	leaq	.LC38(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L803:
	leaq	.LC37(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L804:
	leaq	.LC36(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L805:
	leaq	.LC35(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L806:
	leaq	.LC34(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L807:
	leaq	.LC11(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L808:
	leaq	.LC13(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L809:
	leaq	.LC12(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L810:
	leaq	.LC10(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L811:
	leaq	.LC9(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L812:
	leaq	.LC8(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L813:
	leaq	.LC33(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L814:
	leaq	.LC7(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L815:
	leaq	.LC32(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L816:
	leaq	.LC31(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L817:
	leaq	.LC30(%rip), %rax
	ret
.L756:
	leaq	.LC79(%rip), %rax
	ret
	.cfi_endproc
.LFE24:
	.size	tk_name, .-tk_name
	.ident	"GCC: (GNU) 16.1.1 20260430"
	.section	.note.GNU-stack,"",@progbits
