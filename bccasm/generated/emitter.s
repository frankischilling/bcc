	.file	"emitter.c"
	.text
	.p2align 4
	.type	loop_has_continue, @function
loop_has_continue:
.LFB81:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L13
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	leaq	.L5(%rip), %rdx
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
.L3:
	cmpl	$13, (%rbx)
	ja	.L16
	movl	(%rbx), %eax
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L5:
	.long	.L16-.L5
	.long	.L10-.L5
	.long	.L16-.L5
	.long	.L9-.L5
	.long	.L16-.L5
	.long	.L16-.L5
	.long	.L16-.L5
	.long	.L16-.L5
	.long	.L16-.L5
	.long	.L17-.L5
	.long	.L16-.L5
	.long	.L7-.L5
	.long	.L7-.L5
	.long	.L4-.L5
	.text
	.p2align 4,,10
	.p2align 3
.L7:
	movq	24(%rbx), %rbx
.L12:
	testq	%rbx, %rbx
	jne	.L3
	.p2align 4,,10
	.p2align 3
.L16:
	xorl	%eax, %eax
.L1:
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
.L9:
	.cfi_restore_state
	movq	24(%rbx), %rdi
	call	loop_has_continue
	movl	%eax, %edx
	movl	$1, %eax
	testl	%edx, %edx
	jne	.L1
	movq	32(%rbx), %rdi
	call	loop_has_continue
	testl	%eax, %eax
	setne	%al
	movzbl	%al, %eax
	jmp	.L1
	.p2align 4,,10
	.p2align 3
.L10:
	movq	24(%rbx), %rbp
	testq	%rbp, %rbp
	je	.L16
	movq	16(%rbx), %r12
	xorl	%ebx, %ebx
	jmp	.L11
	.p2align 4,,10
	.p2align 3
.L25:
	addq	$1, %rbx
	cmpq	%rbp, %rbx
	je	.L1
.L11:
	movq	(%r12,%rbx,8), %rdi
	call	loop_has_continue
	testl	%eax, %eax
	je	.L25
.L17:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movl	$1, %eax
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L4:
	.cfi_restore_state
	movq	40(%rbx), %rbx
	jmp	.L12
	.p2align 4,,10
	.p2align 3
.L13:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE81:
	.size	loop_has_continue, .-loop_has_continue
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
.LFB50:
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
	je	.L26
	xorl	%r15d, %r15d
	.p2align 4,,10
	.p2align 3
.L37:
	leaq	string_pool(%rip), %rax
	movq	(%rsp), %rdi
	movq	%r15, %rcx
	movl	$2, %esi
	movq	(%rax), %rax
	cmpl	$16, current_word_bits(%rip)
	movl	$8, %r11d
	movq	(%rax,%r15,8), %rax
	movq	16(%rax), %r14
	movq	8(%rax), %rbp
	movl	$2, %eax
	cmovne	%r11, %rax
	xorl	%ebx, %ebx
	movq	%rax, %r12
	addq	%r14, %rax
	setc	%bl
	xorl	%edx, %edx
	divq	%r12
	leaq	.LC0(%rip), %rdx
	movq	%rax, 16(%rsp)
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	testq	%rbx, %rbx
	jne	.L31
	leal	(%r12,%r12), %esi
	xorl	%r13d, %r13d
	movq	%r15, 24(%rsp)
	movq	%rbp, %r15
	movl	%esi, 12(%rsp)
	movq	%r13, %rbp
	movq	%r14, %r13
	movq	16(%rsp), %r14
	movq	%r12, %rbx
	.p2align 4,,10
	.p2align 3
.L32:
	movq	%rbx, %rdx
	xorl	%r8d, %r8d
	xorl	%ecx, %ecx
	subq	%r12, %rdx
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L47:
	movzbl	(%r15,%rdx), %eax
.L34:
	movzbl	%al, %eax
	addq	$1, %rdx
	salq	%cl, %rax
	addl	$8, %ecx
	orq	%rax, %r8
	cmpq	%rbx, %rdx
	je	.L46
.L35:
	cmpq	%r13, %rdx
	jb	.L47
	sete	%al
	sall	$2, %eax
	jmp	.L34
	.p2align 4,,10
	.p2align 3
.L46:
	testq	%rbp, %rbp
	je	.L36
	movq	(%rsp), %rsi
	movl	$44, %edi
	movq	%r8, 16(%rsp)
	call	fputc@PLT
	movq	16(%rsp), %r8
.L36:
	movl	12(%rsp), %ecx
	movq	(%rsp), %rdi
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC1(%rip), %rdx
	addq	$1, %rbp
	addq	%r12, %rbx
	call	__fprintf_chk@PLT
	cmpq	%r14, %rbp
	jb	.L32
	movq	24(%rsp), %r15
.L31:
	movq	(%rsp), %rdi
	xorl	%eax, %eax
	movl	$2, %esi
	addq	$1, %r15
	leaq	.LC2(%rip), %rdx
	call	__fprintf_chk@PLT
	cmpq	8+string_pool(%rip), %r15
	jb	.L37
.L26:
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
.LFE50:
	.size	emit_string_pool, .-emit_string_pool
	.p2align 4
	.type	source_function, @function
source_function:
.LFB56:
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
	je	.L49
	movq	8(%rax), %r12
	testq	%r12, %r12
	je	.L49
	movq	(%rax), %r13
	xorl	%ebx, %ebx
	jmp	.L54
	.p2align 4,,10
	.p2align 3
.L53:
	addq	$1, %rbx
	cmpq	%r12, %rbx
	je	.L49
.L54:
	movq	0(%r13,%rbx,8), %rax
	cmpl	$1, (%rax)
	jne	.L53
	movq	8(%rax), %rax
	movq	%rbp, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L53
.L57:
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
.L49:
	.cfi_restore_state
	movq	8+g_known_functions(%rip), %r12
	movq	g_known_functions(%rip), %r13
	xorl	%ebx, %ebx
	testq	%r12, %r12
	jne	.L55
	jmp	.L65
	.p2align 4,,10
	.p2align 3
.L66:
	addq	$1, %rbx
	cmpq	%r12, %rbx
	je	.L65
.L55:
	movq	0(%r13,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L66
	jmp	.L57
	.p2align 4,,10
	.p2align 3
.L65:
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
.LFE56:
	.size	source_function, .-source_function
	.p2align 4
	.type	collect_cases, @function
collect_cases:
.LFB79:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L89
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	leaq	.L72(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
.L69:
	cmpl	$13, (%rbx)
	ja	.L67
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L72:
	.long	.L67-.L72
	.long	.L76-.L72
	.long	.L67-.L72
	.long	.L75-.L72
	.long	.L74-.L72
	.long	.L67-.L72
	.long	.L67-.L72
	.long	.L67-.L72
	.long	.L67-.L72
	.long	.L67-.L72
	.long	.L67-.L72
	.long	.L74-.L72
	.long	.L67-.L72
	.long	.L71-.L72
	.text
	.p2align 4,,10
	.p2align 3
.L76:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L67
.L77:
	movq	16(%rbx), %rax
	movq	%r12, %rsi
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_cases
	cmpq	24(%rbx), %rbp
	jb	.L77
.L67:
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
.L74:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L78:
	testq	%rbx, %rbx
	jne	.L69
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
.L71:
	.cfi_restore_state
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	vec_push@PLT
	movq	40(%rbx), %rbx
	jmp	.L78
	.p2align 4,,10
	.p2align 3
.L75:
	movq	24(%rbx), %rdi
	movq	%r12, %rsi
	call	collect_cases
	movq	32(%rbx), %rbx
	jmp	.L78
	.p2align 4,,10
	.p2align 3
.L89:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE79:
	.size	collect_cases, .-collect_cases
	.p2align 4
	.type	collect_function_labels, @function
collect_function_labels:
.LFB77:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L116
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L98(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L95:
	cmpl	$13, (%rbx)
	ja	.L93
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L98:
	.long	.L93-.L98
	.long	.L103-.L98
	.long	.L93-.L98
	.long	.L102-.L98
	.long	.L99-.L98
	.long	.L93-.L98
	.long	.L93-.L98
	.long	.L93-.L98
	.long	.L93-.L98
	.long	.L93-.L98
	.long	.L93-.L98
	.long	.L100-.L98
	.long	.L99-.L98
	.long	.L97-.L98
	.text
	.p2align 4,,10
	.p2align 3
.L103:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L93
.L104:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_function_labels
	cmpq	24(%rbx), %rbp
	jb	.L104
.L93:
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
.L99:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L105:
	testq	%rbx, %rbx
	jne	.L95
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
.L100:
	.cfi_restore_state
	movq	16(%rbx), %rsi
	leaq	function_labels(%rip), %rdi
	call	vec_push@PLT
	movq	24(%rbx), %rbx
	jmp	.L105
	.p2align 4,,10
	.p2align 3
.L97:
	movq	40(%rbx), %rbx
	jmp	.L105
	.p2align 4,,10
	.p2align 3
.L102:
	movq	24(%rbx), %rdi
	call	collect_function_labels
	movq	32(%rbx), %rbx
	jmp	.L105
	.p2align 4,,10
	.p2align 3
.L116:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE77:
	.size	collect_function_labels, .-collect_function_labels
	.p2align 4
	.type	collect_function_autos, @function
collect_function_autos:
.LFB93:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L148
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	leaq	.L125(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
.L122:
	cmpl	$13, (%rbx)
	ja	.L120
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L125:
	.long	.L120-.L125
	.long	.L131-.L125
	.long	.L130-.L125
	.long	.L129-.L125
	.long	.L127-.L125
	.long	.L120-.L125
	.long	.L120-.L125
	.long	.L120-.L125
	.long	.L120-.L125
	.long	.L120-.L125
	.long	.L120-.L125
	.long	.L127-.L125
	.long	.L127-.L125
	.long	.L124-.L125
	.text
	.p2align 4,,10
	.p2align 3
.L130:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L120
	.p2align 4,,10
	.p2align 3
.L132:
	movq	16(%rbx), %rax
	movq	%r12, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	vec_push@PLT
	cmpq	24(%rbx), %rbp
	jb	.L132
.L120:
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
.L127:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L134:
	testq	%rbx, %rbx
	jne	.L122
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L124:
	movq	40(%rbx), %rbx
	jmp	.L134
	.p2align 4,,10
	.p2align 3
.L129:
	movq	24(%rbx), %rdi
	movq	%r12, %rsi
	call	collect_function_autos
	movq	32(%rbx), %rbx
	jmp	.L134
	.p2align 4,,10
	.p2align 3
.L131:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L120
.L133:
	movq	16(%rbx), %rax
	movq	%r12, %rsi
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_function_autos
	cmpq	24(%rbx), %rbp
	jb	.L133
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L148:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE93:
	.size	collect_function_autos, .-collect_function_autos
	.p2align 4
	.type	global_data_kind, @function
global_data_kind:
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
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movq	8+g_known_variables(%rip), %rax
	testq	%rax, %rax
	je	.L167
	movq	g_known_variables(%rip), %rbx
	xorl	%ebp, %ebp
	movl	$1, %r13d
	leaq	(%rbx,%rax,8), %r14
	.p2align 4,,10
	.p2align 3
.L154:
	movq	(%rbx), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	cmove	%r13d, %ebp
	addq	$8, %rbx
	cmpq	%r14, %rbx
	jne	.L154
.L152:
	movq	current_program(%rip), %r13
	testq	%r13, %r13
	je	.L155
	movq	8(%r13), %r14
	xorl	%ebx, %ebx
	jmp	.L156
	.p2align 4,,10
	.p2align 3
.L157:
	addq	$1, %rbx
.L156:
	cmpq	%rbx, %r14
	je	.L155
	movq	0(%r13), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$2, (%rax)
	jne	.L157
	movq	8(%rax), %rax
	movq	%r12, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L157
.L158:
	movl	$1, %ebp
	jmp	.L151
	.p2align 4,,10
	.p2align 3
.L155:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L160
.L162:
	xorl	%ebp, %ebp
.L151:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%ebp, %eax
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
.L160:
	.cfi_restore_state
	movq	%r12, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	je	.L170
	testb	$1, %bpl
	je	.L162
.L170:
	movq	current_program(%rip), %r13
	testq	%r13, %r13
	je	.L151
	movq	8(%r13), %r14
	xorl	%ebx, %ebx
	jmp	.L164
	.p2align 4,,10
	.p2align 3
.L165:
	addq	$1, %rbx
.L164:
	cmpq	%rbx, %r14
	je	.L151
	movq	0(%r13), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$3, (%rax)
	jne	.L165
	movq	8(%rax), %r15
	movq	%r12, %rsi
	movq	16(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L165
	movl	8(%r15), %eax
	movl	$2, %ebp
	testl	%eax, %eax
	jne	.L151
	jmp	.L158
.L167:
	xorl	%ebp, %ebp
	jmp	.L152
	.cfi_endproc
.LFE58:
	.size	global_data_kind, .-global_data_kind
	.section	.rodata.str1.1
.LC3:
	.string	"argv"
	.text
	.p2align 4
	.type	predefined_argv, @function
predefined_argv:
.LFB57:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.LC3(%rip), %rsi
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
	xorl	%ebx, %ebx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L215
.L185:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%ebx, %eax
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
	movq	%rbp, %rdi
	movl	%eax, %ebx
	call	source_function
	testl	%eax, %eax
	jne	.L185
	movq	8+g_known_variables(%rip), %r13
	testq	%r13, %r13
	je	.L187
	movq	g_known_variables(%rip), %r14
	xorl	%r12d, %r12d
	.p2align 4,,10
	.p2align 3
.L188:
	movq	(%r14,%r12,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	je	.L185
	addq	$1, %r12
	cmpq	%r13, %r12
	jne	.L188
.L187:
	movq	current_program(%rip), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L195
	movq	8(%rax), %rax
	xorl	%r12d, %r12d
	movq	%rax, (%rsp)
	.p2align 4,,10
	.p2align 3
.L189:
	cmpq	%r12, (%rsp)
	je	.L195
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r12,8), %rax
	movl	(%rax), %edx
	cmpl	$2, %edx
	je	.L216
	testl	%edx, %edx
	jne	.L191
	movq	8(%rax), %rax
	movq	24(%rax), %r13
	testq	%r13, %r13
	je	.L191
	movq	16(%rax), %r14
	xorl	%r15d, %r15d
	.p2align 4,,10
	.p2align 3
.L192:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	je	.L185
	addq	$1, %r15
	cmpq	%r13, %r15
	jne	.L192
.L191:
	addq	$1, %r12
	jmp	.L189
	.p2align 4,,10
	.p2align 3
.L216:
	movq	8(%rax), %rax
	movq	%rbp, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	je	.L185
	addq	$1, %r12
	jmp	.L189
.L195:
	movl	$1, %ebx
	jmp	.L185
	.cfi_endproc
.LFE57:
	.size	predefined_argv, .-predefined_argv
	.p2align 4
	.type	get_string_id, @function
get_string_id:
.LFB49:
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
	je	.L218
	movq	string_pool(%rip), %rsi
	xorl	%eax, %eax
	jmp	.L221
	.p2align 4,,10
	.p2align 3
.L219:
	addq	$1, %rax
	cmpq	%rcx, %rax
	je	.L218
.L221:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%rbx, (%rdx)
	jne	.L219
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
.L218:
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
.LFE49:
	.size	get_string_id, .-get_string_id
	.p2align 4
	.type	collect_strings_expr, @function
collect_strings_expr:
.LFB68:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L265
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
	leaq	.L232(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
.L229:
	cmpl	$10, (%rbx)
	ja	.L227
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L232:
	.long	.L227-.L232
	.long	.L240-.L232
	.long	.L227-.L232
	.long	.L239-.L232
	.long	.L231-.L232
	.long	.L269-.L232
	.long	.L269-.L232
	.long	.L268-.L232
	.long	.L268-.L232
	.long	.L233-.L232
	.long	.L231-.L232
	.text
	.p2align 4,,10
	.p2align 3
.L231:
	movq	48(%rbx), %rdi
	call	collect_strings_expr
.L269:
	movq	56(%rbx), %rbx
.L248:
	testq	%rbx, %rbx
	jne	.L229
.L227:
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
.L233:
	.cfi_restore_state
	movq	48(%rbx), %rdi
	call	collect_strings_expr
.L268:
	movq	56(%rbx), %rdi
	call	collect_strings_expr
	movq	64(%rbx), %rbx
	jmp	.L248
	.p2align 4,,10
	.p2align 3
.L239:
	movl	g_strict(%rip), %edx
	movq	48(%rbx), %rdi
	testl	%edx, %edx
	jne	.L271
.L241:
	call	collect_strings_expr
	cmpq	$0, 64(%rbx)
	je	.L227
	xorl	%ebp, %ebp
.L247:
	movq	56(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_expr
	cmpq	64(%rbx), %rbp
	jb	.L247
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
.L240:
	.cfi_restore_state
	movq	40(%rbx), %rsi
	movq	48(%rbx), %rdi
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
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
	jmp	get_string_id
	.p2align 4,,10
	.p2align 3
.L271:
	.cfi_restore_state
	movl	28(%rbx), %eax
	testl	%eax, %eax
	jne	.L241
	cmpl	$2, (%rdi)
	jne	.L241
	movq	48(%rdi), %r13
	movq	%r13, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	je	.L242
.L270:
	movq	48(%rbx), %rdi
	jmp	.L241
	.p2align 4,,10
	.p2align 3
.L265:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L242:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%r13, %rdi
	call	source_function
	movl	%eax, %r12d
	testl	%eax, %eax
	jne	.L270
	movq	8+external_calls(%rip), %rax
	testq	%rax, %rax
	je	.L244
	movq	external_calls(%rip), %rbp
	movl	$1, %r14d
	leaq	0(%rbp,%rax,8), %r15
.L246:
	movq	0(%rbp), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	cmove	%r14d, %r12d
	addq	$8, %rbp
	cmpq	%r15, %rbp
	jne	.L246
	testl	%r12d, %r12d
	jne	.L270
.L244:
	movq	%r13, %rdi
	call	sdup@PLT
	leaq	external_calls(%rip), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L270
	.cfi_endproc
.LFE68:
	.size	collect_strings_expr, .-collect_strings_expr
	.p2align 4
	.type	collect_strings_init, @function
collect_strings_init:
.LFB69:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L281
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
	je	.L284
	cmpl	$1, %eax
	je	.L285
.L272:
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
.L284:
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
.L285:
	.cfi_restore_state
	cmpq	$0, 24(%rdi)
	je	.L272
	xorl	%ebp, %ebp
.L275:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_init
	cmpq	24(%rbx), %rbp
	jb	.L275
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L281:
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE69:
	.size	collect_strings_init, .-collect_strings_init
	.p2align 4
	.type	collect_strings_stmt, @function
collect_strings_stmt:
.LFB70:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L310
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L291(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L288:
	cmpl	$13, (%rbx)
	ja	.L286
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L291:
	.long	.L286-.L291
	.long	.L299-.L291
	.long	.L286-.L291
	.long	.L298-.L291
	.long	.L292-.L291
	.long	.L295-.L291
	.long	.L295-.L291
	.long	.L286-.L291
	.long	.L286-.L291
	.long	.L286-.L291
	.long	.L295-.L291
	.long	.L293-.L291
	.long	.L292-.L291
	.long	.L290-.L291
	.text
	.p2align 4,,10
	.p2align 3
.L295:
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
.L299:
	.cfi_restore_state
	cmpq	$0, 24(%rbx)
	je	.L286
	xorl	%ebp, %ebp
.L300:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_stmt
	cmpq	24(%rbx), %rbp
	jb	.L300
.L286:
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
.L292:
	.cfi_restore_state
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rbx
.L301:
	testq	%rbx, %rbx
	jne	.L288
	jmp	.L286
	.p2align 4,,10
	.p2align 3
.L290:
	movq	40(%rbx), %rbx
	jmp	.L301
	.p2align 4,,10
	.p2align 3
.L298:
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rdi
	call	collect_strings_stmt
	movq	32(%rbx), %rbx
	jmp	.L301
	.p2align 4,,10
	.p2align 3
.L293:
	movq	24(%rbx), %rbx
	jmp	.L301
	.p2align 4,,10
	.p2align 3
.L310:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE70:
	.size	collect_strings_stmt, .-collect_strings_stmt
	.p2align 4
	.type	collect_strings_program, @function
collect_strings_program:
.LFB71:
	.cfi_startproc
	cmpq	$0, 8(%rdi)
	je	.L323
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
	jmp	.L320
	.p2align 4,,10
	.p2align 3
.L316:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L326
.L320:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L327
	cmpl	$2, %eax
	je	.L328
	testl	%eax, %eax
	jne	.L316
	movq	8(%rdx), %rdi
	addq	$1, %rbx
	call	collect_strings_stmt
	cmpq	8(%rbp), %rbx
	jb	.L320
.L326:
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
.L327:
	.cfi_restore_state
	movq	8(%rdx), %rax
	movq	32(%rax), %rdi
	call	collect_strings_stmt
	jmp	.L316
	.p2align 4,,10
	.p2align 3
.L328:
	movq	8(%rdx), %r12
	movq	56(%r12), %rdi
	call	collect_strings_init
	movq	32(%r12), %rdi
	testq	%rdi, %rdi
	je	.L316
	call	collect_strings_expr
	jmp	.L316
	.p2align 4,,10
	.p2align 3
.L323:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE71:
	.size	collect_strings_program, .-collect_strings_program
	.section	.rodata.str1.1
.LC4:
	.string	"auto"
.LC5:
	.string	"__empty"
.LC6:
	.string	"__bcc_bs_"
.LC7:
	.string	"identifier is too long"
.LC8:
	.string	"%02x"
.LC9:
	.string	"%02X"
.LC10:
	.string	"_%02X"
.LC11:
	.string	"__bcc_"
.LC12:
	.string	"__bcc_user_%c_%s"
.LC13:
	.string	"%s_%d"
.LC14:
	.string	"__bcc_keyword_%s"
	.text
	.p2align 4
	.type	get_mangled_name, @function
get_mangled_name:
.LFB59:
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
	je	.L374
	movq	8+name_map(%rip), %r13
	movq	%rdi, %rbp
	testq	%r13, %r13
	je	.L331
	movq	name_map(%rip), %r14
	xorl	%ebx, %ebx
	jmp	.L333
	.p2align 4,,10
	.p2align 3
.L332:
	addq	$1, %rbx
	cmpq	%r13, %rbx
	je	.L331
.L333:
	movq	(%r14,%rbx,8), %r12
	movq	%rbp, %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L332
	movq	8(%r12), %r13
.L329:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r13, %rax
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
.L331:
	.cfi_restore_state
	cmpb	$0, 0(%rbp)
	je	.L404
	movq	%rbp, %rdi
	call	strlen@PLT
	movl	$8, %esi
	movq	%rbp, %rdi
	movq	%rax, %rbx
	call	strchr@PLT
	testq	%rax, %rax
	je	.L405
.L336:
	movabsq	$9223372036854775802, %rax
	cmpq	%rbx, %rax
	jb	.L406
	leaq	10(%rbx,%rbx), %r13
	movq	%r13, %rdi
	call	xmalloc@PLT
	movq	%rax, %r14
	movabsq	$8314312742553149279, %rax
	movq	%rax, (%r14)
	movb	$95, 8(%r14)
	testq	%rbx, %rbx
	je	.L335
	leaq	-1(%r14,%r13), %r15
	movq	%rbp, %r12
	leaq	9(%r14), %rbx
	leaq	.LC8(%rip), %r13
	.p2align 4,,10
	.p2align 3
.L340:
	movzbl	(%r12), %r8d
	movq	%rbx, %rdi
	movq	%r13, %rcx
	movl	$2, %esi
	movq	$-1, %rdx
	xorl	%eax, %eax
	addq	$2, %rbx
	addq	$1, %r12
	call	__sprintf_chk@PLT
	cmpq	%rbx, %r15
	jne	.L340
.L335:
	movl	g_strict(%rip), %edx
	testl	%edx, %edx
	jne	.L359
	movq	%rbp, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L407
.L359:
	movq	%r14, %rdi
	call	strlen@PLT
	leaq	14(%rax), %rdi
	call	xmalloc@PLT
	movl	$98, %r8d
	movq	%rax, %r13
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L408
.L358:
	xorl	%eax, %eax
	movq	%r14, %r9
	leaq	.LC12(%rip), %rcx
	movq	%r13, %rdi
	movq	$-1, %rdx
	movl	$2, %esi
	call	__sprintf_chk@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L409
.L360:
	leaq	8+c_keywords(%rip), %rbx
	leaq	.LC4(%rip), %rsi
	jmp	.L363
	.p2align 4,,10
	.p2align 3
.L410:
	movq	(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L364
.L363:
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L410
	movq	%r13, %rdi
	call	strlen@PLT
	leaq	15(%rax), %rdi
	call	xmalloc@PLT
	movq	%r13, %r8
	movl	$2, %esi
	leaq	.LC14(%rip), %rcx
	movq	%rax, %rdi
	movq	%rax, %rbx
	movq	$-1, %rdx
	xorl	%eax, %eax
	call	__sprintf_chk@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L411
.L373:
	movq	%rbx, %r13
	.p2align 4,,10
	.p2align 3
.L364:
	movq	8+name_map(%rip), %r12
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
	testq	%r12, %r12
	je	.L365
	movq	name_map(%rip), %r14
	xorl	%ebx, %ebx
	jmp	.L367
	.p2align 4,,10
	.p2align 3
.L413:
	addq	$1, %rbx
	cmpq	%rbx, %r12
	je	.L412
.L367:
	movq	(%r14,%rbx,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L413
	movq	%r13, %rdi
	call	strlen@PLT
	leaq	16(%rax), %rdi
	call	xmalloc@PLT
	movl	$2, %r9d
	movq	%rax, %r12
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
	.p2align 4,,10
	.p2align 3
.L369:
	leal	1(%r9), %eax
	movq	%r13, %r8
	movl	$2, %esi
	movq	%r12, %rdi
	movl	%eax, 12(%rsp)
	leaq	.LC13(%rip), %rcx
	movq	$-1, %rdx
	xorl	%eax, %eax
	call	__sprintf_chk@PLT
	movq	8+name_map(%rip), %rbx
	testq	%rbx, %rbx
	je	.L368
	movq	(%rsp), %rax
	xorl	%r15d, %r15d
	movq	(%rax), %r14
	jmp	.L370
	.p2align 4,,10
	.p2align 3
.L414:
	addq	$1, %r15
	cmpq	%r15, %rbx
	je	.L368
.L370:
	movq	(%r14,%r15,8), %rax
	movq	%r12, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L414
	movl	12(%rsp), %r9d
	jmp	.L369
	.p2align 4,,10
	.p2align 3
.L412:
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
.L365:
	movl	$16, %edi
	call	xmalloc@PLT
	movq	%rbp, %rdi
	movq	%rax, %rbx
	call	sdup@PLT
	movq	%r13, 8(%rbx)
	movq	(%rsp), %rdi
	movq	%rbx, %rsi
	movq	%rax, (%rbx)
	call	vec_push@PLT
	jmp	.L329
.L405:
	movl	$9, %edx
	leaq	.LC6(%rip), %rsi
	movq	%rbp, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	je	.L336
	leaq	16(,%rbx,4), %rdi
	call	xmalloc@PLT
	movq	%rax, %r14
	movzbl	0(%rbp), %eax
	leal	-65(%rax), %edx
	cmpb	$57, %dl
	ja	.L341
	movabsq	$288230372997595135, %rcx
	btq	%rdx, %rcx
	jnc	.L341
	movb	%al, (%r14)
	leaq	1(%r14), %r15
.L345:
	leaq	1(%rbp), %r12
	leaq	0(%rbp,%rbx), %r9
	movabsq	$288230372997595135, %r13
	cmpq	$1, %rbx
	ja	.L355
	jmp	.L347
	.p2align 4,,10
	.p2align 3
.L348:
	leal	-65(%r8), %eax
	cmpb	$57, %al
	ja	.L351
	btq	%rax, %r13
	jnc	.L351
.L349:
	movb	%r8b, (%r15)
	addq	$1, %r15
.L354:
	addq	$1, %r12
	cmpq	%r12, %r9
	je	.L347
.L355:
	movzbl	(%r12), %r8d
	cmpb	$57, %r8b
	jg	.L348
	cmpb	$47, %r8b
	jg	.L349
	cmpb	$46, %r8b
	jne	.L351
	movb	$95, (%r15)
	addq	$1, %r15
	jmp	.L354
.L407:
	movq	%rbp, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	jne	.L359
	movl	$6, %edx
	leaq	.LC11(%rip), %rsi
	movq	%rbp, %rdi
	movq	%r14, %r13
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L360
	jmp	.L359
	.p2align 4,,10
	.p2align 3
.L404:
	leaq	.LC5(%rip), %rdi
	call	sdup@PLT
	movq	%rax, %r14
	jmp	.L335
	.p2align 4,,10
	.p2align 3
.L368:
	cmpq	$0, g_compilation_arena(%rip)
	je	.L415
.L371:
	movq	%r12, %r13
	jmp	.L365
	.p2align 4,,10
	.p2align 3
.L408:
	movq	%rbp, %rdi
	call	source_function
	movl	$102, %r8d
	testl	%eax, %eax
	jne	.L358
	movq	%rbp, %rdi
	call	b_library_function@PLT
	cmpl	$1, %eax
	sbbl	%r8d, %r8d
	andl	$6, %r8d
	addl	$114, %r8d
	jmp	.L358
.L374:
	xorl	%r13d, %r13d
	jmp	.L329
.L409:
	movq	%r14, %rdi
	call	free@PLT
	jmp	.L360
.L351:
	movq	%r15, %rdi
	leaq	.LC10(%rip), %rcx
	xorl	%eax, %eax
	movq	%r9, (%rsp)
	movq	$-1, %rdx
	movl	$2, %esi
	addq	$3, %r15
	call	__sprintf_chk@PLT
	movq	(%rsp), %r9
	jmp	.L354
.L415:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L371
.L347:
	movb	$0, (%r15)
	jmp	.L335
.L411:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L373
.L341:
	movb	$95, (%r14)
	movzbl	0(%rbp), %r8d
	cmpb	$46, %r8b
	jne	.L416
	movb	$95, 1(%r14)
	leaq	2(%r14), %r15
	jmp	.L345
.L416:
	leaq	1(%r14), %rdi
	movl	$2, %esi
	leaq	3(%r14), %r15
	xorl	%eax, %eax
	leaq	.LC9(%rip), %rcx
	movq	$-1, %rdx
	call	__sprintf_chk@PLT
	jmp	.L345
.L406:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.cfi_endproc
.LFE59:
	.size	get_mangled_name, .-get_mangled_name
	.section	.rodata.str1.1
.LC15:
	.string	"main"
.LC16:
	.string	"__b_user_main"
.LC17:
	.string	"__bcc_body_"
	.text
	.p2align 4
	.type	emit_function_body_name, @function
emit_function_body_name:
.LFB62:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsi, %rbp
	leaq	.LC15(%rip), %rsi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	movq	%rbp, %rdi
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	strcmp@PLT
	movq	%rbx, %rcx
	testl	%eax, %eax
	jne	.L418
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movl	$13, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 16
	leaq	.LC16(%rip), %rdi
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L418:
	.cfi_restore_state
	movl	$1, %esi
	movl	$11, %edx
	leaq	.LC17(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdi
	call	get_mangled_name
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbx, %rsi
	movq	%rax, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	fputs@PLT
	.cfi_endproc
.LFE62:
	.size	emit_function_body_name, .-emit_function_body_name
	.section	.rodata.str1.1
.LC18:
	.string	"extern word "
.LC19:
	.string	"[];\n"
.LC20:
	.string	"word "
.LC21:
	.string	"[1];\n"
.LC22:
	.string	"static word "
.LC23:
	.string	"void"
.LC24:
	.string	");\n"
	.text
	.p2align 4
	.type	emit_function_prototypes, @function
emit_function_prototypes:
.LFB99:
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
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	cmpq	$0, 8+external_calls(%rip)
	je	.L421
	xorl	%ebp, %ebp
	leaq	.LC18(%rip), %r15
	leaq	external_calls(%rip), %r14
	leaq	.LC19(%rip), %r13
	.p2align 4,,10
	.p2align 3
.L423:
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rdi
	testq	%rdi, %rdi
	je	.L422
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L422:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addq	$1, %rbp
	cmpq	8+external_calls(%rip), %rbp
	jb	.L423
.L421:
	cmpq	$0, 8+g_known_functions(%rip)
	je	.L432
	movl	$0, 12(%rsp)
	movq	$0, (%rsp)
	.p2align 4,,10
	.p2align 3
.L430:
	leaq	g_known_functions(%rip), %rax
	movq	(%rsp), %rdx
	movq	8(%r12), %r13
	movq	(%rax), %rax
	movq	(%r12), %r14
	movq	(%rax,%rdx,8), %rbp
	testq	%r13, %r13
	je	.L425
	xorl	%r15d, %r15d
	jmp	.L428
	.p2align 4,,10
	.p2align 3
.L426:
	addq	$1, %r15
	cmpq	%r15, %r13
	je	.L425
.L428:
	movq	(%r14,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L426
	movq	8(%rax), %rax
	movq	%rbp, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L426
.L427:
	addq	$1, (%rsp)
	movq	(%rsp), %rax
	cmpq	8+g_known_functions(%rip), %rax
	jb	.L430
	movl	12(%rsp), %eax
	testl	%eax, %eax
	je	.L432
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
.L432:
	cmpq	$0, 8(%r12)
	je	.L420
	xorl	%r13d, %r13d
	leaq	.LC20(%rip), %r15
	leaq	.LC21(%rip), %r14
	jmp	.L436
	.p2align 4,,10
	.p2align 3
.L434:
	addq	$1, %r13
	cmpq	8(%r12), %r13
	jnb	.L420
.L436:
	movq	(%r12), %rax
	movq	(%rax,%r13,8), %rax
	cmpl	$1, (%rax)
	jne	.L434
	movq	8(%rax), %rbp
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	0(%rbp), %rdi
	testq	%rdi, %rdi
	je	.L435
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L435:
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	addq	$1, %r13
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC22(%rip), %rdi
	call	fwrite@PLT
	movq	0(%rbp), %rsi
	movq	%rbx, %rdi
	call	emit_function_body_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC23(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC24(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r12), %r13
	jb	.L436
.L420:
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
.L425:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC18(%rip), %rdi
	call	fwrite@PLT
	testq	%rbp, %rbp
	je	.L429
	movq	%rbp, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L429:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC19(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 12(%rsp)
	jmp	.L427
	.cfi_endproc
.LFE99:
	.size	emit_function_prototypes, .-emit_function_prototypes
	.section	.rodata.str1.1
.LC25:
	.string	"b_%s"
	.text
	.p2align 4
	.type	emit_function_name, @function
emit_function_name:
.LFB64:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rsi, %rbx
	leaq	.LC15(%rip), %rsi
	movq	%rbx, %rdi
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L461
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbp, %rcx
	movl	$13, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 16
	leaq	.LC16(%rip), %rdi
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L461:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	je	.L462
	movq	%rbx, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L467
.L462:
	movq	%rbx, %rdi
	call	get_mangled_name
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbp, %rsi
	popq	%rbx
	.cfi_def_cfa_offset 16
	movq	%rax, %rdi
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	fputs@PLT
	.p2align 4,,10
	.p2align 3
.L467:
	.cfi_restore_state
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbx, %rcx
	movq	%rbp, %rdi
	movl	$2, %esi
	popq	%rbx
	.cfi_def_cfa_offset 16
	leaq	.LC25(%rip), %rdx
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	__fprintf_chk@PLT
	.cfi_endproc
.LFE64:
	.size	emit_function_name, .-emit_function_name
	.p2align 4
	.type	edge_words_total.part.0.isra.0, @function
edge_words_total.part.0.isra.0:
.LFB116:
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
	je	.L472
	movq	%rdi, %r12
	movq	%rsi, %rbp
	xorl	%ebx, %ebx
.L471:
	movq	(%r12,%rbx,8), %rax
	testq	%rax, %rax
	je	.L470
	cmpl	$1, (%rax)
	je	.L478
.L470:
	addq	$1, %rbx
	cmpq	%rbp, %rbx
	jne	.L471
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
.L478:
	.cfi_restore_state
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r13
	jmp	.L470
	.p2align 4,,10
	.p2align 3
.L472:
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
.LFE116:
	.size	edge_words_total.part.0.isra.0, .-edge_words_total.part.0.isra.0
	.section	.rodata.str1.1
.LC26:
	.string	"  "
	.text
	.p2align 4
	.globl	emit_indent
	.type	emit_indent, @function
emit_indent:
.LFB73:
	.cfi_startproc
	endbr64
	testl	%esi, %esi
	jle	.L484
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	leaq	.LC26(%rip), %r13
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
	.p2align 4,,10
	.p2align 3
.L481:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L481
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
.L484:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	ret
	.cfi_endproc
.LFE73:
	.size	emit_indent, .-emit_indent
	.section	.rodata.str1.1
.LC27:
	.string	"#line %d \"%s\"\n"
	.text
	.p2align 4
	.globl	emit_line_directive
	.type	emit_line_directive, @function
emit_line_directive:
.LFB74:
	.cfi_startproc
	endbr64
	movl	g_no_line(%rip), %eax
	testl	%eax, %eax
	jne	.L487
	testq	%rdx, %rdx
	jne	.L495
.L487:
	ret
	.p2align 4,,10
	.p2align 3
.L495:
	movq	%rdx, %r8
	movl	%esi, %ecx
	leaq	.LC27(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	jmp	__fprintf_chk@PLT
	.cfi_endproc
.LFE74:
	.size	emit_line_directive, .-emit_line_directive
	.section	.rodata.str1.1
.LC28:
	.string	"\\n"
.LC29:
	.string	"\\t"
.LC30:
	.string	"\\%03o"
	.text
	.p2align 4
	.globl	emit_c_string
	.type	emit_c_string, @function
emit_c_string:
.LFB75:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	leaq	.LC28(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	leaq	.LC30(%rip), %r13
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
	jne	.L497
	jmp	.L504
	.p2align 4,,10
	.p2align 3
.L512:
	movq	%r13, %rdx
	movl	$2, %esi
	movq	%r12, %rdi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
.L500:
	movzbl	1(%rbp), %ebx
	addq	$1, %rbp
	testb	%bl, %bl
	je	.L504
.L497:
	cmpb	$92, %bl
	je	.L505
	cmpb	$34, %bl
	je	.L505
	cmpb	$10, %bl
	je	.L510
	cmpb	$9, %bl
	je	.L511
	movzbl	%bl, %ecx
	cmpb	$31, %bl
	jbe	.L512
	movq	%r12, %rsi
	movl	%ecx, %edi
	addq	$1, %rbp
	call	fputc@PLT
	movzbl	0(%rbp), %ebx
	testb	%bl, %bl
	jne	.L497
.L504:
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
.L505:
	.cfi_restore_state
	movq	%r12, %rsi
	movl	$92, %edi
	call	fputc@PLT
	movzbl	%bl, %edi
	movq	%r12, %rsi
	call	fputc@PLT
	jmp	.L500
	.p2align 4,,10
	.p2align 3
.L510:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	jmp	.L500
	.p2align 4,,10
	.p2align 3
.L511:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC29(%rip), %rdi
	call	fwrite@PLT
	jmp	.L500
	.cfi_endproc
.LFE75:
	.size	emit_c_string, .-emit_c_string
	.section	.rodata.str1.1
.LC31:
	.string	"B_ADDR(*__bcc_binding_cell("
.LC32:
	.string	"))"
.LC33:
	.string	"B_ADDR("
.LC34:
	.string	"b_argv_vector"
.LC35:
	.string	"__b_external_%s"
.LC36:
	.string	"[0]"
	.text
	.p2align 4
	.type	emit_ival_expr.part.0, @function
emit_ival_expr.part.0:
.LFB111:
	.cfi_startproc
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
	movq	48(%rsi), %rdi
	movq	%rsi, %rbx
	call	b_library_function@PLT
	testl	%eax, %eax
	je	.L514
	movq	48(%rbx), %rdi
	call	predefined_argv
	testl	%eax, %eax
	je	.L531
.L514:
	leaq	.LC33(%rip), %rdi
	movq	%rbp, %rcx
	movl	$7, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	48(%rbx), %r12
	movq	%r12, %rdi
	call	predefined_argv
	testl	%eax, %eax
	jne	.L532
	movq	%r12, %rdi
	call	global_data_kind
	cmpl	$2, %eax
	je	.L533
	movq	48(%rbx), %r12
	testq	%r12, %r12
	je	.L518
	movq	%r12, %rdi
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	48(%rbx), %r12
.L518:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L519
.L520:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
	jmp	.L516
	.p2align 4,,10
	.p2align 3
.L532:
	movq	%rbp, %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC34(%rip), %rdi
	call	fwrite@PLT
.L516:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbp, %rsi
	movl	$41, %edi
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	fputc@PLT
	.p2align 4,,10
	.p2align 3
.L531:
	.cfi_restore_state
	movq	%rbp, %rcx
	movl	$27, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rdi
	call	fwrite@PLT
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	emit_c_string
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbp, %rcx
	movl	$2, %edx
	popq	%rbp
	.cfi_def_cfa_offset 16
	movl	$1, %esi
	leaq	.LC32(%rip), %rdi
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L519:
	.cfi_restore_state
	movq	%r12, %rdi
	call	global_data_kind
	cmpl	$1, %eax
	jne	.L516
	jmp	.L520
	.p2align 4,,10
	.p2align 3
.L533:
	movq	48(%rbx), %rdi
	call	get_mangled_name
	leaq	.LC35(%rip), %rdx
	movl	$2, %esi
	movq	%rbp, %rdi
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	jmp	.L516
	.cfi_endproc
.LFE111:
	.size	emit_ival_expr.part.0, .-emit_ival_expr.part.0
	.section	.rodata.str1.1
.LC37:
	.string	"b_preinc(&("
.LC38:
	.string	"b_predec(&("
.LC39:
	.string	"b_postinc(&("
.LC40:
	.string	"b_postdec(&("
.LC41:
	.string	"WAND"
.LC42:
	.string	"WOR"
.LC43:
	.string	"WADD"
.LC44:
	.string	"WSUB"
.LC45:
	.string	"WMUL"
.LC46:
	.string	"WSHR"
.LC47:
	.string	"WSHL"
.LC48:
	.string	"WMOD"
.LC49:
	.string	"WDIV"
.LC50:
	.string	"="
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
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC61:
	.string	"B_PTR_N(__b_str%d, sizeof(__b_str%d))"
	.section	.rodata.str1.1
.LC62:
	.string	"__b_label_value_%d"
.LC63:
	.string	"__bcc_parameters[%zu]"
.LC64:
	.string	"(*__bcc_binding_cell("
.LC65:
	.string	"B_FUNCTION("
	.section	.rodata.str1.8
	.align 8
.LC66:
	.string	"({ word *__bcc_binding_%u = __bcc_binding_cell("
	.section	.rodata.str1.1
.LC67:
	.string	"); "
.LC68:
	.string	"; })"
.LC69:
	.string	"printf"
.LC70:
	.string	"malloc"
.LC71:
	.string	"calloc"
.LC72:
	.string	"realloc"
.LC73:
	.string	"dprintf"
.LC74:
	.string	"B_PTR("
.LC75:
	.string	"-+ #0"
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
	.string	", "
.LC88:
	.string	"B_INDEX("
.LC89:
	.string	"B_DEREF("
.LC90:
	.string	"WNEG("
.LC91:
	.string	"({ word __b_left_%u = "
.LC92:
	.string	"; word __b_right_%u = "
	.section	.rodata.str1.8
	.align 8
.LC93:
	.string	"; (word)%s(__b_left_%u, __b_right_%u); })"
	.section	.rodata.str1.1
.LC94:
	.string	" %s "
.LC95:
	.string	"%s("
.LC96:
	.string	"({ word *__b_dest_%u = &("
.LC97:
	.string	"); word __b_rhs_%u = ("
	.section	.rodata.str1.8
	.align 8
.LC98:
	.string	"); *__b_dest_%u = (*__b_dest_%u %s __b_rhs_%u); })"
	.align 8
.LC99:
	.string	"*__b_dest_%u %s __b_rhs_%u; })"
	.align 8
.LC100:
	.string	"b_%s(__b_dest_%u, __b_rhs_%u); })"
	.section	.rodata.str1.1
.LC101:
	.string	" ? "
.LC102:
	.string	" : "
.LC103:
	.string	"snprintf"
.LC104:
	.string	"sprintf"
.LC105:
	.string	"fprintf"
	.text
	.p2align 4
	.globl	emit_expr
	.type	emit_expr, @function
emit_expr:
.LFB85:
	.cfi_startproc
	endbr64
	cmpl	$10, (%rsi)
	ja	.L898
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rsi, %r15
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
	movq	%rdx, %rbp
	leaq	.L537(%rip), %rdx
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movl	(%rsi), %eax
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L537:
	.long	.L547-.L537
	.long	.L546-.L537
	.long	.L545-.L537
	.long	.L544-.L537
	.long	.L543-.L537
	.long	.L542-.L537
	.long	.L541-.L537
	.long	.L540-.L537
	.long	.L539-.L537
	.long	.L538-.L537
	.long	.L536-.L537
	.text
	.p2align 4,,10
	.p2align 3
.L538:
	movq	%rdi, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC101(%rip), %rdi
	call	fwrite@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC102(%rip), %rdi
.L922:
	call	fwrite@PLT
	movq	64(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L888:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rsi
	movl	$41, %edi
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
	.p2align 4,,10
	.p2align 3
.L536:
	.cfi_restore_state
	movq	%rdi, %rsi
	movl	$40, %edi
	call	fputc@PLT
.L924:
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC87(%rip), %rdi
.L923:
	call	fwrite@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	jmp	.L888
	.p2align 4,,10
	.p2align 3
.L547:
	movq	48(%rsi), %rcx
	leaq	.LC60(%rip), %rdx
.L910:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rdi
	movl	$2, %esi
	xorl	%eax, %eax
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
	jmp	__fprintf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L546:
	.cfi_restore_state
	movq	48(%r15), %rdi
	movq	40(%rsi), %rsi
	call	get_string_id
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rdi
	leaq	.LC61(%rip), %rdx
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 48
	movl	%eax, %ecx
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 40
	movl	%eax, %r8d
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 32
	movl	$2, %esi
	popq	%r13
	.cfi_restore 13
	.cfi_def_cfa_offset 24
	xorl	%eax, %eax
	popq	%r14
	.cfi_restore 14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_restore 15
	.cfi_def_cfa_offset 8
	jmp	__fprintf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L545:
	.cfi_restore_state
	movq	8+function_labels(%rip), %r13
	movq	48(%rsi), %r12
	testq	%r13, %r13
	je	.L548
	movq	function_labels(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L551
	.p2align 4,,10
	.p2align 3
.L549:
	addq	$1, %rbp
	cmpq	%r13, %rbp
	je	.L548
.L551:
	movq	(%r14,%rbp,8), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L549
	movl	%ebp, %ecx
	addl	$1, %ecx
	je	.L548
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rdi
	leaq	.LC62(%rip), %rdx
	xorl	%eax, %eax
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 48
	movl	$2, %esi
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
	jmp	__fprintf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L544:
	.cfi_restore_state
	movq	48(%rsi), %rax
	movl	28(%rsi), %edx
	cmpl	$2, (%rax)
	je	.L927
	testl	%edx, %edx
	jne	.L566
	movq	48(%rax), %r14
.L909:
	xorl	%r13d, %r13d
.L570:
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	64(%r15), %rcx
	testq	%rcx, %rcx
	je	.L888
	movq	$0, 16(%rsp)
	xorl	%r14d, %r14d
	movb	$0, 39(%rsp)
.L902:
	movq	$0, 8(%rsp)
.L584:
	movq	%rbp, (%rsp)
	xorl	%r12d, %r12d
	movl	%r14d, 24(%rsp)
	movq	%rcx, %r14
.L653:
	testq	%r13, %r13
	je	.L712
	movl	g_strict(%rip), %ebp
	testl	%ebp, %ebp
	je	.L928
.L712:
	xorl	%ebp, %ebp
.L609:
	movq	56(%r15), %rax
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
.L650:
	testl	%ebp, %ebp
	jne	.L929
.L651:
	addq	$1, %r12
	cmpq	%r14, %r12
	jnb	.L652
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC87(%rip), %rdi
	call	fwrite@PLT
	jmp	.L653
	.p2align 4,,10
	.p2align 3
.L543:
	movq	%rdi, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC88(%rip), %rdi
	call	fwrite@PLT
	jmp	.L924
	.p2align 4,,10
	.p2align 3
.L542:
	movl	48(%rsi), %r12d
	cmpl	$32, %r12d
	je	.L930
	cmpl	$53, %r12d
	je	.L931
	leal	-36(%r12), %eax
	cmpl	$1, %eax
	jbe	.L932
	cmpl	$31, %r12d
	je	.L933
	movq	%rdi, %rsi
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
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	jmp	.L913
	.p2align 4,,10
	.p2align 3
.L541:
	cmpl	$36, 48(%rsi)
	movq	56(%rsi), %r12
	movl	$12, %edx
	movq	%rbx, %rcx
	leaq	.LC39(%rip), %rax
	leaq	.LC40(%rip), %rdi
	movl	$1, %esi
	cmove	%rax, %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r12, %rsi
.L913:
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC32(%rip), %rdi
.L911:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
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
	jmp	fwrite@PLT
	.p2align 4,,10
	.p2align 3
.L540:
	.cfi_restore_state
	movl	48(%rsi), %r12d
	leal	-53(%r12), %eax
	cmpl	$1, %eax
	jbe	.L934
	leal	-28(%r12), %eax
	cmpl	$6, %eax
	ja	.L663
	leaq	.L665(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L665:
	.long	.L719-.L665
	.long	.L670-.L665
	.long	.L669-.L665
	.long	.L668-.L665
	.long	.L667-.L665
	.long	.L666-.L665
	.long	.L664-.L665
	.text
	.p2align 4,,10
	.p2align 3
.L539:
	movl	48(%rsi), %r9d
	movl	expression_id(%rip), %ecx
	movq	56(%rsi), %r13
	movq	64(%rsi), %r14
	leal	-47(%r9), %eax
	leal	1(%rcx), %r12d
	cmpl	$5, %eax
	jbe	.L935
	movl	%r12d, %ecx
	leaq	.LC96(%rip), %rdx
	xorl	%eax, %eax
	movl	%r9d, (%rsp)
	movl	$2, %esi
	movl	%r12d, expression_id(%rip)
	call	__fprintf_chk@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %ecx
	movl	$2, %esi
	movq	%rbx, %rdi
	leaq	.LC97(%rip), %rdx
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC67(%rip), %rdi
	call	fwrite@PLT
	movl	(%rsp), %r9d
	leal	-38(%r9), %eax
	cmpl	$8, %eax
	ja	.L673
	leaq	.L675(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L675:
	.long	.L683-.L675
	.long	.L682-.L675
	.long	.L681-.L675
	.long	.L680-.L675
	.long	.L679-.L675
	.long	.L678-.L675
	.long	.L677-.L675
	.long	.L720-.L675
	.long	.L674-.L675
	.text
	.p2align 4,,10
	.p2align 3
.L548:
	movq	32(%r15), %rcx
	testq	%rcx, %rcx
	jne	.L936
	movl	20(%r15), %eax
	testl	%eax, %eax
	jne	.L937
	movl	16(%r15), %eax
	testl	%eax, %eax
	jne	.L938
	movl	24(%r15), %eax
	cmpl	$2, %eax
	je	.L939
	testq	%r12, %r12
	je	.L559
	movq	%r12, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movl	24(%r15), %eax
.L559:
	cmpl	$1, %eax
	je	.L556
.L534:
	addq	$72, %rsp
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
.L928:
	.cfi_restore_state
	movq	%r13, %rdi
	call	source_function
	movl	%eax, 32(%rsp)
	testl	%eax, %eax
	jne	.L609
	movl	current_byteptr(%rip), %eax
	movq	16(%rsp), %rcx
	movl	%eax, 40(%rsp)
	cmpq	%rcx, %r12
	jne	.L610
	cmpb	$0, 39(%rsp)
	je	.L610
	testl	%eax, %eax
	je	.L611
.L612:
	movq	%rbx, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC84(%rip), %rdi
	call	fwrite@PLT
.L649:
	movl	$1, %ebp
	jmp	.L609
.L561:
	xorl	%r14d, %r14d
	testl	%edx, %edx
	je	.L565
	.p2align 4,,10
	.p2align 3
.L566:
	xorl	%r12d, %r12d
.L563:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rcx
	movq	%rbp, %rdx
	movq	%r15, %rsi
	movq	%rbx, %rdi
	xorl	%r8d, %r8d
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
	jmp	emit_b_call
	.p2align 4,,10
	.p2align 3
.L936:
	.cfi_restore_state
	subq	$1, %rcx
	leaq	.LC63(%rip), %rdx
	jmp	.L910
	.p2align 4,,10
	.p2align 3
.L932:
	cmpl	$36, %r12d
	leaq	.LC37(%rip), %rax
	movl	$11, %edx
	movq	%rbx, %rcx
	leaq	.LC38(%rip), %rdi
	movl	$1, %esi
	cmove	%rax, %rdi
	call	fwrite@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	jmp	.L913
	.p2align 4,,10
	.p2align 3
.L670:
	leaq	.LC46(%rip), %rcx
	.p2align 4,,10
	.p2align 3
.L671:
	leaq	.LC95(%rip), %rdx
	movl	$2, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC87(%rip), %rdi
	jmp	.L922
	.p2align 4,,10
	.p2align 3
.L719:
	leaq	.LC47(%rip), %rcx
	jmp	.L671
	.p2align 4,,10
	.p2align 3
.L664:
	leaq	.LC48(%rip), %rcx
	jmp	.L671
	.p2align 4,,10
	.p2align 3
.L669:
	leaq	.LC43(%rip), %rcx
	jmp	.L671
	.p2align 4,,10
	.p2align 3
.L667:
	leaq	.LC45(%rip), %rcx
	jmp	.L671
	.p2align 4,,10
	.p2align 3
.L668:
	leaq	.LC44(%rip), %rcx
	jmp	.L671
	.p2align 4,,10
	.p2align 3
.L666:
	leaq	.LC49(%rip), %rcx
	jmp	.L671
.L674:
	leaq	.LC52(%rip), %rcx
	.p2align 4,,10
	.p2align 3
.L676:
	movl	%r12d, %r9d
	movl	%r12d, %r8d
	leaq	.LC100(%rip), %rdx
.L912:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rdi
	movl	$2, %esi
	xorl	%eax, %eax
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
	jmp	__fprintf_chk@PLT
.L720:
	.cfi_restore_state
	leaq	.LC53(%rip), %rcx
	jmp	.L676
.L680:
	leaq	.LC57(%rip), %rcx
	jmp	.L676
.L681:
	leaq	.LC58(%rip), %rcx
	jmp	.L676
.L682:
	leaq	.LC59(%rip), %rcx
	jmp	.L676
.L683:
	leaq	.LC51(%rip), %rcx
	jmp	.L676
.L677:
	leaq	.LC54(%rip), %rcx
	jmp	.L676
.L678:
	leaq	.LC55(%rip), %rcx
	jmp	.L676
.L679:
	leaq	.LC56(%rip), %rcx
	jmp	.L676
	.p2align 4,,10
	.p2align 3
.L929:
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L651
	.p2align 4,,10
	.p2align 3
.L652:
	movl	24(%rsp), %r14d
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%r14d, %r14d
	je	.L654
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
.L654:
	movq	8(%rsp), %rax
	testq	%rax, %rax
	je	.L534
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rax, %rdi
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
	jmp	free@PLT
	.p2align 4,,10
	.p2align 3
.L935:
	.cfi_restore_state
	leaq	CSWTCH.187(%rip), %rdx
	movl	%r12d, %ecx
	movl	$2, %esi
	movl	%r12d, expression_id(%rip)
	movl	(%rdx,%rax,4), %r15d
	leaq	.LC96(%rip), %rdx
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %ecx
	movl	$2, %esi
	movq	%rbx, %rdi
	leaq	.LC97(%rip), %rdx
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r15d, %edi
	call	tk_name@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 136
	movl	%r12d, %ecx
	movl	%r12d, %r8d
	pushq	%r12
	.cfi_def_cfa_offset 144
	movq	%rax, %r9
	movl	$2, %esi
	movq	%rbx, %rdi
	leaq	.LC98(%rip), %rdx
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	popq	%rcx
	.cfi_def_cfa_offset 136
	popq	%rsi
	.cfi_def_cfa_offset 128
	jmp	.L534
	.p2align 4,,10
	.p2align 3
.L927:
	movq	48(%rax), %r12
	testq	%r12, %r12
	je	.L561
	testl	%edx, %edx
	jne	.L566
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L563
	movl	g_strict(%rip), %eax
	movq	%r12, %r14
	testl	%eax, %eax
	jne	.L940
	.p2align 4,,10
	.p2align 3
.L565:
	movq	%r14, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	jne	.L941
.L569:
	movq	48(%r15), %rax
	cmpl	$2, (%rax)
	movq	48(%rax), %r13
	jne	.L699
	leaq	.LC69(%rip), %rsi
	movq	%r13, %rdi
	movl	g_strict(%rip), %r14d
	call	strcmp@PLT
	movl	%eax, %r12d
	testl	%r14d, %r14d
	je	.L571
	movq	%r13, %r14
	testl	%eax, %eax
	jne	.L570
	movq	%r13, %rdi
	call	source_function
	movq	%r13, %rsi
	movq	$0, 16(%rsp)
	testl	%eax, %eax
	sete	%r12b
	xorl	%r14d, %r14d
	.p2align 4,,10
	.p2align 3
.L573:
	movq	%rbx, %rdi
	call	emit_function_name
	movl	$40, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movq	64(%r15), %rcx
	movq	16(%rsp), %rdi
	cmpq	%rcx, %rdi
	setb	%al
	andb	%r12b, %al
	movb	%al, 39(%rsp)
	je	.L581
	movq	56(%r15), %rax
	movq	(%rax,%rdi,8), %rax
	testq	%rax, %rax
	je	.L902
	cmpl	$1, (%rax)
	jne	.L902
	movq	%rcx, %rdi
	movl	$4, %esi
	movq	%rcx, (%rsp)
	movq	48(%rax), %r12
	call	calloc@PLT
	movq	(%rsp), %rcx
	testq	%rax, %rax
	movq	%rax, 8(%rsp)
	je	.L902
	movq	16(%rsp), %rax
	movzbl	(%r12), %r8d
	leaq	1(%rax), %rsi
	testb	%r8b, %r8b
	je	.L584
	movl	%r14d, 32(%rsp)
	xorl	%eax, %eax
	movq	%r13, 24(%rsp)
	movq	%rbx, 40(%rsp)
	movq	%rsi, %rbx
	movq	%rbp, 48(%rsp)
	movq	%r12, %rbp
	movq	%rcx, %r12
	.p2align 4,,10
	.p2align 3
.L607:
	leaq	1(%rax), %r9
	movzbl	1(%rbp,%rax), %r14d
	movq	%r9, %r13
	cmpb	$37, %r8b
	jne	.L587
	cmpb	$37, %r14b
	je	.L706
	testb	%r14b, %r14b
	jne	.L588
	jmp	.L901
	.p2align 4,,10
	.p2align 3
.L591:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %r14d
	testb	%r14b, %r14b
	je	.L590
.L588:
	movsbl	%r14b, %esi
	leaq	.LC75(%rip), %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L591
	cmpb	$42, %r14b
	jne	.L590
	cmpq	%r12, %rbx
	movzbl	1(%rbp,%r13), %ecx
	leaq	1(%r13), %rax
	adcq	$0, %rbx
.L595:
	cmpb	$46, %cl
	je	.L942
.L598:
	cmpb	$104, %cl
	jne	.L596
	cmpb	$104, 1(%rbp,%rax)
	leaq	1(%rax), %r9
	je	.L709
.L603:
	addq	$1, %rbx
.L587:
	movzbl	0(%rbp,%r9), %r8d
	movq	%r9, %rax
	testb	%r8b, %r8b
	jne	.L607
.L896:
	movl	32(%rsp), %r14d
	movq	24(%rsp), %r13
	movq	%r12, %rcx
	movq	40(%rsp), %rbx
	movq	48(%rsp), %rbp
	jmp	.L584
	.p2align 4,,10
	.p2align 3
.L933:
	movq	%rdi, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC90(%rip), %rdi
	jmp	.L923
	.p2align 4,,10
	.p2align 3
.L934:
	movl	expression_id(%rip), %eax
	leaq	.LC91(%rip), %rdx
	movl	$2, %esi
	leal	1(%rax), %r13d
	xorl	%eax, %eax
	movl	%r13d, %ecx
	movl	%r13d, expression_id(%rip)
	call	__fprintf_chk@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r13d, %ecx
	movl	$2, %esi
	movq	%rbx, %rdi
	leaq	.LC92(%rip), %rdx
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	64(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	cmpl	$53, %r12d
	movl	%r13d, %r9d
	movl	%r13d, %r8d
	leaq	.LC42(%rip), %rcx
	leaq	.LC41(%rip), %rax
	cmove	%rax, %rcx
	leaq	.LC93(%rip), %rdx
	jmp	.L912
	.p2align 4,,10
	.p2align 3
.L937:
	movq	%rbx, %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC34(%rip), %rdi
	jmp	.L911
	.p2align 4,,10
	.p2align 3
.L610:
	movq	8(%rsp), %rax
	testq	%rax, %rax
	je	.L613
	movl	(%rax,%r12,4), %r10d
	testl	%r10d, %r10d
	je	.L613
.L907:
	movl	40(%rsp), %r9d
	testl	%r9d, %r9d
	jne	.L612
.L611:
	leaq	.LC70(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L731
	testq	%r12, %r12
	je	.L685
.L731:
	movl	$1, 40(%rsp)
	xorl	%ebp, %ebp
	leaq	.LC72(%rip), %rdx
.L629:
	movq	%rdx, %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	leaq	.LC71(%rip), %rcx
	testl	%eax, %eax
	jne	.L644
	cmpq	$1, %r12
	je	.L926
.L645:
	movl	40(%rsp), %r8d
	testl	%r8d, %r8d
	jne	.L612
.L641:
	testl	%ebp, %ebp
	je	.L609
.L627:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC85(%rip), %rdi
	call	fwrite@PLT
	jmp	.L649
	.p2align 4,,10
	.p2align 3
.L706:
	leaq	2(%rax), %r9
	jmp	.L587
.L930:
	movq	%rdi, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC89(%rip), %rdi
	jmp	.L923
.L596:
	cmpb	$108, %cl
	jne	.L605
	cmpb	$108, 1(%rbp,%rax)
	leaq	1(%rax), %r9
	jne	.L603
.L709:
	leaq	2(%rax), %r9
	jmp	.L603
.L663:
	movq	%rdi, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edi
	call	tk_name@PLT
	movq	%rbx, %rdi
	movl	$2, %esi
	leaq	.LC94(%rip), %rdx
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	64(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	jmp	.L888
.L931:
	movq	%rdi, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC33(%rip), %rdi
	jmp	.L923
.L938:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L943
	movq	%r12, %rdi
	call	b_library_function@PLT
	movq	%rbx, %rcx
	testl	%eax, %eax
	je	.L557
	movl	$21, %edx
	movl	$1, %esi
	leaq	.LC64(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
	movq	%rbx, %rdi
	call	emit_c_string
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC32(%rip), %rdi
	jmp	.L911
.L613:
	leaq	.LC76(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L917
	leaq	.LC77(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L615
.L917:
	testq	%r12, %r12
	je	.L907
.L615:
	leaq	.LC78(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L616
	cmpq	$1, %r12
	jbe	.L944
.L618:
	leaq	.LC80(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	movl	%eax, %ebp
	testl	%eax, %eax
	jne	.L621
	cmpq	$2, %r12
	je	.L622
.L617:
	leaq	.LC82(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L625
	testq	%r12, %r12
	je	.L632
.L625:
	leaq	.LC83(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L631
	cmpq	$1, %r12
	jbe	.L632
.L633:
	cmpl	$0, 40(%rsp)
	jne	.L641
.L903:
	leaq	.LC72(%rip), %rdx
	jmp	.L629
	.p2align 4,,10
	.p2align 3
.L590:
	movzbl	0(%rbp,%r13), %ecx
	testb	%cl, %cl
	movb	%cl, (%rsp)
	je	.L901
	call	__ctype_b_loc@PLT
	movzbl	(%rsp), %ecx
	movq	(%rax), %rax
	jmp	.L593
	.p2align 4,,10
	.p2align 3
.L597:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %ecx
	testb	%cl, %cl
	je	.L896
.L593:
	testb	$8, 1(%rax,%rcx,2)
	jne	.L597
	movzbl	0(%rbp,%r13), %ecx
	movq	%r13, %rax
	jmp	.L595
.L571:
	movq	%r13, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L700
	leaq	.LC70(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L575
	leaq	.LC71(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L575
	leaq	.LC72(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L575
	testl	%r12d, %r12d
	je	.L945
	leaq	.LC105(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	movl	%eax, %r14d
	testl	%eax, %eax
	je	.L728
	xorl	%r14d, %r14d
.L697:
	leaq	.LC73(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L580
.L725:
	movq	$1, 16(%rsp)
	movl	$1, %r12d
.L692:
	testl	%r14d, %r14d
	je	.L946
.L578:
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$6, %edx
	movl	$1, %r14d
	leaq	.LC74(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rax
	movq	48(%rax), %rsi
	jmp	.L573
.L673:
	leaq	.LC50(%rip), %r8
	cmpl	$21, %r9d
	je	.L684
	movl	%r9d, %edi
	call	tk_name@PLT
	movq	%rax, %r8
.L684:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%r12d, %r9d
	movl	%r12d, %ecx
	movq	%rbx, %rdi
	leaq	.LC99(%rip), %rdx
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 48
	movl	$2, %esi
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 40
	xorl	%eax, %eax
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
	jmp	__fprintf_chk@PLT
.L942:
	.cfi_restore_state
	movzbl	1(%rbp,%rax), %edx
	leaq	1(%rax), %r13
	cmpb	$42, %dl
	jne	.L947
	cmpq	%r12, %rbx
	adcq	$0, %rbx
	addq	$2, %rax
	movzbl	0(%rbp,%rax), %ecx
	jmp	.L598
.L943:
	testq	%r12, %r12
	je	.L556
	movq	%r12, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L556:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	jmp	.L911
.L637:
	leaq	.LC70(%rip), %rsi
	movq	%r13, %rdi
	movq	%rcx, 56(%rsp)
	movq	%rdx, 48(%rsp)
	call	strcmp@PLT
	movq	48(%rsp), %rdx
	movq	56(%rsp), %rcx
	testl	%eax, %eax
	movl	%eax, %ebp
	je	.L722
	movq	%rdx, %rsi
	movq	%r13, %rdi
	movq	%rcx, 48(%rsp)
	call	strcmp@PLT
	movl	%eax, %ebp
	testl	%eax, %eax
	je	.L609
	movq	48(%rsp), %rcx
	xorl	%ebp, %ebp
.L644:
	movq	%rcx, %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	cmpq	$1, %r12
	jne	.L645
	testl	%eax, %eax
	jne	.L645
.L926:
	movl	40(%rsp), %edi
	testl	%edi, %edi
	jne	.L647
.L919:
	testl	%ebp, %ebp
	jne	.L642
.L722:
	movl	$0, 32(%rsp)
.L643:
	movq	%rbx, %rcx
	movl	$32, %edx
	movl	$1, %esi
	leaq	.LC86(%rip), %rdi
	call	fwrite@PLT
	movq	56(%r15), %rax
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC32(%rip), %rdi
	call	fwrite@PLT
	movl	32(%rsp), %eax
	orl	%eax, %ebp
	jmp	.L650
.L605:
	testb	%cl, %cl
	je	.L896
	leaq	1(%rax), %r9
	cmpq	%r12, %rbx
	jnb	.L603
	cmpb	$115, %cl
	jne	.L603
	movq	8(%rsp), %rax
	movl	$1, (%rax,%rbx,4)
	jmp	.L603
.L557:
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC65(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	jmp	.L888
.L941:
	movq	%r14, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L569
	movl	expression_id(%rip), %eax
	leaq	.LC66(%rip), %rdx
	movl	$2, %esi
	movq	%rbx, %rdi
	leal	1(%rax), %r13d
	xorl	%eax, %eax
	movl	%r13d, %ecx
	movl	%r13d, expression_id(%rip)
	call	__fprintf_chk@PLT
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_c_string
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC67(%rip), %rdi
	call	fwrite@PLT
	xorl	%ecx, %ecx
	movq	%rbp, %rdx
	movq	%r15, %rsi
	movq	%rbx, %rdi
	movl	%r13d, %r8d
	call	emit_b_call
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC68(%rip), %rdi
	jmp	.L911
.L939:
	movq	%r12, %rdi
	call	get_mangled_name
	leaq	.LC35(%rip), %rdx
	movq	%rax, %rcx
	jmp	.L910
.L700:
	movq	$0, 16(%rsp)
	movq	%r13, %rsi
	xorl	%r12d, %r12d
	jmp	.L573
.L575:
	testl	%r12d, %r12d
	je	.L948
	leaq	.LC105(%rip), %rsi
	movq	%r13, %rdi
	movl	$1, %r12d
	movl	$1, %r14d
	call	strcmp@PLT
	movq	$1, 16(%rsp)
	testl	%eax, %eax
	je	.L578
	jmp	.L697
.L616:
	leaq	.LC79(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	cmpq	$1, %r12
	jne	.L618
	testl	%eax, %eax
	jne	.L618
.L622:
	leaq	.LC83(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L628
	cmpl	$0, 40(%rsp)
	jne	.L627
	movl	$1, %ebp
	jmp	.L903
.L580:
	leaq	.LC104(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L725
	leaq	.LC103(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	cmpl	$1, %eax
	setb	%r12b
	sbbq	%rax, %rax
	andl	$2, %eax
	movq	%rax, 16(%rsp)
	jmp	.L692
.L947:
	testb	%dl, %dl
	movb	%dl, (%rsp)
	je	.L896
	call	__ctype_b_loc@PLT
	movzbl	(%rsp), %edx
	movq	(%rax), %rax
	jmp	.L600
	.p2align 4,,10
	.p2align 3
.L602:
	addq	$1, %r13
	movzbl	0(%rbp,%r13), %edx
	testb	%dl, %dl
	je	.L896
.L600:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L602
.L901:
	movzbl	0(%rbp,%r13), %ecx
	movq	%r13, %rax
	jmp	.L598
.L621:
	leaq	.LC81(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L730
	cmpq	$2, %r12
	je	.L622
.L730:
	xorl	%ebp, %ebp
	jmp	.L617
.L628:
	leaq	.LC72(%rip), %rdx
	movq	%r13, %rdi
	movq	%rdx, %rsi
	movq	%rdx, 48(%rsp)
	call	strcmp@PLT
	leaq	.LC72(%rip), %rdx
	testl	%eax, %eax
	jne	.L949
	cmpl	$0, 40(%rsp)
	jne	.L627
	leaq	.LC70(%rip), %rsi
	movq	%r13, %rdi
	movq	%rdx, 48(%rsp)
	call	strcmp@PLT
	movq	48(%rsp), %rdx
	testl	%eax, %eax
	jne	.L734
	testq	%r12, %r12
	je	.L642
.L734:
	movl	$1, %ebp
	jmp	.L629
.L940:
	movq	%r12, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	je	.L563
	cmpl	$0, 28(%r15)
	jne	.L566
	movq	48(%r15), %rax
	cmpl	$2, (%rax)
	movq	48(%rax), %r14
	jne	.L909
	jmp	.L565
.L631:
	leaq	.LC72(%rip), %rdx
	movq	%r13, %rdi
	movq	%rdx, %rsi
	movq	%rdx, 48(%rsp)
	call	strcmp@PLT
	leaq	.LC72(%rip), %rdx
	testl	%eax, %eax
	jne	.L634
	testq	%r12, %r12
	jne	.L633
	cmpl	$0, 40(%rsp)
	jne	.L627
	leaq	.LC70(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L627
.L642:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	movl	$1, %ebp
	leaq	.LC85(%rip), %rdi
	call	fwrite@PLT
	jmp	.L643
.L948:
	xorl	%eax, %eax
	movl	$1, %r12d
	movq	%rax, 16(%rsp)
	jmp	.L578
.L632:
	cmpl	$0, 40(%rsp)
	jne	.L627
	leaq	.LC70(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L732
	testb	$1, %r12b
	je	.L642
.L732:
	xorl	%edx, %edx
	movl	$1, %ebp
	movl	%edx, 40(%rsp)
	leaq	.LC72(%rip), %rdx
	jmp	.L629
.L685:
	movq	%rbx, %rcx
	movl	$9, %edx
	movl	$1, %esi
	xorl	%ebp, %ebp
	leaq	.LC84(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 32(%rsp)
	jmp	.L643
.L944:
	movl	$1, %ebp
	jmp	.L617
.L647:
	movq	%rbx, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC84(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 32(%rsp)
	jmp	.L643
.L634:
	leaq	.LC71(%rip), %rcx
	movq	%r13, %rdi
	movq	%rdx, 56(%rsp)
	movq	%rcx, %rsi
	movq	%rcx, 48(%rsp)
	call	strcmp@PLT
	movq	56(%rsp), %rdx
	testl	%eax, %eax
	jne	.L636
	testq	%r12, %r12
	jne	.L636
	cmpl	$0, 40(%rsp)
	leaq	.LC71(%rip), %rcx
	je	.L637
	movq	56(%r15), %rax
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	movq	(%rax), %rsi
	call	emit_expr
	jmp	.L651
.L949:
	cmpl	$0, 40(%rsp)
	movl	$1, %ebp
	jne	.L627
.L640:
	leaq	.LC70(%rip), %rsi
	movq	%r13, %rdi
	movq	%rdx, 40(%rsp)
	call	strcmp@PLT
	movq	40(%rsp), %rdx
	testl	%eax, %eax
	jne	.L733
	testq	%r12, %r12
	je	.L919
.L733:
	xorl	%eax, %eax
	movl	%eax, 40(%rsp)
	jmp	.L629
.L636:
	cmpl	$0, 40(%rsp)
	je	.L640
	jmp	.L641
.L945:
	xorl	%eax, %eax
	movq	%r13, %rsi
	movl	$1, %r12d
	movq	%rax, 16(%rsp)
	jmp	.L573
.L699:
	movq	%r13, %r14
	jmp	.L909
.L581:
	testq	%rcx, %rcx
	je	.L950
	xorl	%r11d, %r11d
	movb	%r12b, 39(%rsp)
	movq	%r11, 8(%rsp)
	jmp	.L584
	.p2align 4,,10
	.p2align 3
.L950:
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	testl	%r14d, %r14d
	jne	.L888
	jmp	.L534
.L728:
	movq	$1, 16(%rsp)
	movq	%r13, %rsi
	movl	$1, %r12d
	jmp	.L573
.L946:
	movq	%r13, %rsi
	jmp	.L573
.L898:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.cfi_endproc
.LFE85:
	.size	emit_expr, .-emit_expr
	.section	.rodata.str1.1
.LC106:
	.string	"({ word __bcc_callee_%u = "
.LC107:
	.string	"*__bcc_binding_%u"
.LC108:
	.string	"; word __bcc_args_%u[%zu] = {"
	.section	.rodata.str1.8
	.align 8
.LC109:
	.ascii	"}; word __bcc_builtin_result_%u; __b"
	.string	"cc_try_builtin(__bcc_callee_%u, %zu, __bcc_args_%u, &__bcc_builtin_result_%u) ? __bcc_builtin_result_%u : __bcc_is_source_function(__bcc_callee_%u) ? __bcc_invoke_source(__bcc_callee_%u, %zu, __bcc_args_%u) : ((word (*)())B_FUNCTION_CPTR(__bcc_callee_%u))("
	.section	.rodata.str1.1
.LC110:
	.string	"__bcc_args_%u[%zu]"
.LC111:
	.string	"); })"
	.text
	.p2align 4
	.type	emit_b_call, @function
emit_b_call:
.LFB84:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rcx, %r15
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdx, %r14
	leaq	.LC106(%rip), %rdx
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
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movl	expression_id(%rip), %eax
	movq	64(%rsi), %r12
	movl	$2, %esi
	movl	%r8d, 12(%rsp)
	leal	1(%rax), %ebp
	xorl	%eax, %eax
	movl	%ebp, %ecx
	movl	%ebp, expression_id(%rip)
	call	__fprintf_chk@PLT
	movl	12(%rsp), %r8d
	testl	%r8d, %r8d
	jne	.L962
	testq	%r15, %r15
	je	.L954
	movq	%r15, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
.L953:
	testq	%r12, %r12
	movl	$1, %r8d
	movl	%ebp, %ecx
	movl	$2, %esi
	cmovne	%r12, %r8
	leaq	.LC108(%rip), %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	xorl	%r15d, %r15d
	call	__fprintf_chk@PLT
	testq	%r12, %r12
	jne	.L955
	jmp	.L963
	.p2align 4,,10
	.p2align 3
.L964:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC87(%rip), %rdi
	call	fwrite@PLT
.L955:
	movq	56(%r13), %rax
	movq	%r14, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r15,8), %rsi
	addq	$1, %r15
	call	emit_expr
	cmpq	%r15, %r12
	jne	.L964
	pushq	%rbp
	.cfi_def_cfa_offset 88
	movq	%r12, %r9
	movl	%ebp, %r8d
	movl	%ebp, %ecx
	pushq	%rbp
	.cfi_def_cfa_offset 96
	leaq	.LC109(%rip), %rdx
	movl	$2, %esi
	movq	%rbx, %rdi
	pushq	%r12
	.cfi_def_cfa_offset 104
	xorl	%eax, %eax
	xorl	%r13d, %r13d
	leaq	.LC110(%rip), %r14
	pushq	%rbp
	.cfi_def_cfa_offset 112
	leaq	.LC87(%rip), %r15
	pushq	%rbp
	.cfi_def_cfa_offset 120
	pushq	%rbp
	.cfi_def_cfa_offset 128
	pushq	%rbp
	.cfi_def_cfa_offset 136
	pushq	%rbp
	.cfi_def_cfa_offset 144
	call	__fprintf_chk@PLT
	addq	$64, %rsp
	.cfi_def_cfa_offset 80
	jmp	.L958
	.p2align 4,,10
	.p2align 3
.L965:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
.L958:
	movq	%r13, %r8
	movl	%ebp, %ecx
	movq	%r14, %rdx
	movl	$2, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	addq	$1, %r13
	call	__fprintf_chk@PLT
	cmpq	%r13, %r12
	jne	.L965
.L956:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC111(%rip), %rdi
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
.L954:
	.cfi_restore_state
	movq	48(%r13), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	jmp	.L953
	.p2align 4,,10
	.p2align 3
.L963:
	movq	%rbx, %rsi
	movl	$48, %edi
	call	fputc@PLT
	pushq	%rbp
	.cfi_def_cfa_offset 88
	xorl	%r9d, %r9d
	movl	%ebp, %r8d
	pushq	%rbp
	.cfi_def_cfa_offset 96
	movl	%ebp, %ecx
	leaq	.LC109(%rip), %rdx
	movl	$2, %esi
	pushq	$0
	.cfi_def_cfa_offset 104
	movq	%rbx, %rdi
	xorl	%eax, %eax
	pushq	%rbp
	.cfi_def_cfa_offset 112
	pushq	%rbp
	.cfi_def_cfa_offset 120
	pushq	%rbp
	.cfi_def_cfa_offset 128
	pushq	%rbp
	.cfi_def_cfa_offset 136
	pushq	%rbp
	.cfi_def_cfa_offset 144
	call	__fprintf_chk@PLT
	addq	$64, %rsp
	.cfi_def_cfa_offset 80
	jmp	.L956
	.p2align 4,,10
	.p2align 3
.L962:
	movl	%r8d, %ecx
	leaq	.LC107(%rip), %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	jmp	.L953
	.cfi_endproc
.LFE84:
	.size	emit_b_call, .-emit_b_call
	.section	.rodata.str1.1
.LC112:
	.string	"word __%s_store[("
.LC113:
	.string	")];\n"
.LC114:
	.string	"word %s = 0;\n"
	.section	.rodata.str1.8
	.align 8
.LC115:
	.string	"(void)B_LOCAL_PTR_N(&%s, sizeof(%s));\n"
	.text
	.p2align 4
	.type	emit_auto_storage, @function
emit_auto_storage:
.LFB94:
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
	je	.L967
	xorl	%r12d, %r12d
	leaq	.LC26(%rip), %r14
	testl	%r13d, %r13d
	jle	.L969
	.p2align 4,,10
	.p2align 3
.L968:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r13d
	jne	.L968
.L969:
	movq	%r15, %rcx
	leaq	.LC112(%rip), %rdx
	movq	%rbp, %rdi
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	8(%rbx), %rsi
	movq	8(%rsp), %rdx
	movq	%rbp, %rdi
	call	emit_expr
	movq	%rbp, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC113(%rip), %rdi
	call	fwrite@PLT
.L967:
	testl	%r13d, %r13d
	jle	.L970
	xorl	%ebx, %ebx
	leaq	.LC26(%rip), %r14
	.p2align 4,,10
	.p2align 3
.L971:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %r12d
	leal	1(%rbx), %ebx
	cmpl	%ebx, %r13d
	jne	.L971
	xorl	%eax, %eax
	movq	%r15, %rcx
	leaq	.LC114(%rip), %rdx
	movq	%rbp, %rdi
	movl	$2, %esi
	call	__fprintf_chk@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L983
.L966:
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
.L983:
	.cfi_restore_state
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L972:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %r12d
	jne	.L972
.L974:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r15, %r8
	movq	%r15, %rcx
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC115(%rip), %rdx
	popq	%rbp
	.cfi_def_cfa_offset 40
	movl	$2, %esi
	popq	%r12
	.cfi_def_cfa_offset 32
	xorl	%eax, %eax
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	__fprintf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L970:
	.cfi_restore_state
	xorl	%eax, %eax
	movq	%r15, %rcx
	leaq	.LC114(%rip), %rdx
	movq	%rbp, %rdi
	movl	$2, %esi
	call	__fprintf_chk@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L966
	jmp	.L974
	.cfi_endproc
.LFE94:
	.size	emit_auto_storage, .-emit_auto_storage
	.p2align 4
	.globl	emit_ival_expr
	.type	emit_ival_expr, @function
emit_ival_expr:
.LFB86:
	.cfi_startproc
	endbr64
	cmpl	$2, (%rsi)
	je	.L986
	jmp	emit_expr
	.p2align 4,,10
	.p2align 3
.L986:
	jmp	emit_ival_expr.part.0
	.cfi_endproc
.LFE86:
	.size	emit_ival_expr, .-emit_ival_expr
	.p2align 4
	.globl	init_list_length
	.type	init_list_length, @function
init_list_length:
.LFB87:
	.cfi_startproc
	endbr64
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L987
	cmpl	$1, (%rdi)
	je	.L991
.L987:
	ret
	.p2align 4,,10
	.p2align 3
.L991:
	movq	24(%rdi), %rax
	ret
	.cfi_endproc
.LFE87:
	.size	init_list_length, .-init_list_length
	.p2align 4
	.globl	try_eval_const_expr
	.type	try_eval_const_expr, @function
try_eval_const_expr:
.LFB88:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$40, %rsp
	.cfi_def_cfa_offset 64
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L1029
	movl	(%rdi), %eax
	movq	%rdi, %rbx
	movq	%rsi, %rbp
	cmpl	$7, %eax
	je	.L994
	ja	.L995
	testl	%eax, %eax
	je	.L996
	cmpl	$5, %eax
	jne	.L1029
	movq	56(%rdi), %rdi
	leaq	16(%rsp), %rsi
	movq	$0, 16(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L992
	movl	48(%rbx), %eax
	cmpl	$31, %eax
	je	.L1000
	cmpl	$35, %eax
	je	.L1001
	.p2align 4,,10
	.p2align 3
.L1029:
	xorl	%eax, %eax
.L992:
	movq	24(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L1052
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L995:
	.cfi_restore_state
	cmpl	$10, %eax
	jne	.L1029
	movq	48(%rdi), %rdi
	leaq	16(%rsp), %rsi
	movq	$0, 16(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L992
	movq	56(%rbx), %rdi
	movq	%rbp, %rsi
	call	try_eval_const_expr
	jmp	.L992
	.p2align 4,,10
	.p2align 3
.L996:
	movq	48(%rdi), %rax
	movq	%rax, (%rsi)
	movl	$1, %eax
	jmp	.L992
	.p2align 4,,10
	.p2align 3
.L994:
	movq	56(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	movq	$0, 16(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1029
	movq	64(%rbx), %rdi
	leaq	16(%rsp), %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1029
	movl	48(%rbx), %eax
	subl	$22, %eax
	cmpl	$33, %eax
	ja	.L1029
	leaq	.L1007(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1007:
	.long	.L1020-.L1007
	.long	.L1019-.L1007
	.long	.L1018-.L1007
	.long	.L1017-.L1007
	.long	.L1016-.L1007
	.long	.L1015-.L1007
	.long	.L1029-.L1007
	.long	.L1029-.L1007
	.long	.L1014-.L1007
	.long	.L1013-.L1007
	.long	.L1012-.L1007
	.long	.L1011-.L1007
	.long	.L1010-.L1007
	.long	.L1029-.L1007
	.long	.L1029-.L1007
	.long	.L1029-.L1007
	.long	.L1029-.L1007
	.long	.L1029-.L1007
	.long	.L1029-.L1007
	.long	.L1029-.L1007
	.long	.L1029-.L1007
	.long	.L1029-.L1007
	.long	.L1029-.L1007
	.long	.L1029-.L1007
	.long	.L1029-.L1007
	.long	.L1029-.L1007
	.long	.L1029-.L1007
	.long	.L1029-.L1007
	.long	.L1029-.L1007
	.long	.L1029-.L1007
	.long	.L1029-.L1007
	.long	.L1009-.L1007
	.long	.L1008-.L1007
	.long	.L1006-.L1007
	.text
	.p2align 4,,10
	.p2align 3
.L1001:
	xorl	%eax, %eax
	cmpq	$0, 16(%rsp)
	sete	%al
	movq	%rax, 0(%rbp)
.L1022:
	movl	$1, %eax
	jmp	.L992
.L1006:
	movq	8(%rsp), %rax
	orq	16(%rsp), %rax
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1022
.L1008:
	movq	8(%rsp), %rax
	orq	16(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1022
.L1009:
	movq	8(%rsp), %rax
	andq	16(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1022
.L1010:
	movq	16(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L1029
	movq	8(%rsp), %rax
	cmpq	$-1, %rcx
	jne	.L1033
	movabsq	$-9223372036854775808, %rdx
	cmpq	%rdx, %rax
	je	.L1031
.L1033:
	cqto
	idivq	%rcx
.L1025:
	movq	%rdx, 0(%rbp)
	jmp	.L1022
.L1011:
	movq	16(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L1029
	movq	8(%rsp), %rdx
	cmpq	$-1, %rcx
	jne	.L1032
	movabsq	$-9223372036854775808, %rax
	cmpq	%rax, %rdx
	je	.L1051
.L1032:
	movq	%rdx, %rax
	cqto
	idivq	%rcx
.L1051:
	movq	%rax, 0(%rbp)
	jmp	.L1022
.L1012:
	movq	8(%rsp), %rax
	imulq	16(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1022
.L1013:
	movq	8(%rsp), %rax
	subq	16(%rsp), %rax
	jmp	.L1051
.L1014:
	movq	16(%rsp), %rax
	addq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1022
.L1015:
	movq	16(%rsp), %rax
	cmpq	%rax, 8(%rsp)
	setge	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1022
.L1016:
	movq	16(%rsp), %rax
	cmpq	%rax, 8(%rsp)
	setg	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1022
.L1017:
	movq	16(%rsp), %rax
	cmpq	%rax, 8(%rsp)
	setle	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1022
.L1018:
	movq	16(%rsp), %rax
	cmpq	%rax, 8(%rsp)
	setl	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1022
.L1019:
	movq	16(%rsp), %rax
	cmpq	%rax, 8(%rsp)
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1022
.L1020:
	movq	16(%rsp), %rax
	cmpq	%rax, 8(%rsp)
	sete	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1022
	.p2align 4,,10
	.p2align 3
.L1000:
	movq	16(%rsp), %rax
	negq	%rax
	movq	%rax, 0(%rbp)
	jmp	.L1022
.L1052:
	call	__stack_chk_fail@PLT
.L1031:
	xorl	%edx, %edx
	jmp	.L1025
	.cfi_endproc
.LFE88:
	.size	try_eval_const_expr, .-try_eval_const_expr
	.p2align 4
	.globl	nested_base_len
	.type	nested_base_len, @function
nested_base_len:
.LFB89:
	.cfi_startproc
	endbr64
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L1053
	cmpl	$1, (%rdi)
	je	.L1057
.L1053:
	ret
	.p2align 4,,10
	.p2align 3
.L1057:
	movq	24(%rdi), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmove	%rdx, %rax
	ret
	.cfi_endproc
.LFE89:
	.size	nested_base_len, .-nested_base_len
	.p2align 4
	.globl	edge_words_total
	.type	edge_words_total, @function
edge_words_total:
.LFB90:
	.cfi_startproc
	endbr64
	testq	%rdi, %rdi
	je	.L1058
	cmpl	$1, (%rdi)
	je	.L1063
.L1058:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L1063:
	movq	24(%rdi), %rsi
	movq	16(%rdi), %rdi
	jmp	edge_words_total.part.0.isra.0
	.cfi_endproc
.LFE90:
	.size	edge_words_total, .-edge_words_total
	.p2align 4
	.globl	edge_tail_words_top
	.type	edge_tail_words_top, @function
edge_tail_words_top:
.LFB91:
	.cfi_startproc
	endbr64
	xorl	%r9d, %r9d
	testq	%rdi, %rdi
	je	.L1076
	cmpl	$1, (%rdi)
	jne	.L1076
	movq	24(%rdi), %rcx
	movq	16(%rdi), %r8
	testq	%rcx, %rcx
	je	.L1076
	xorl	%edx, %edx
	jmp	.L1077
	.p2align 4,,10
	.p2align 3
.L1079:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L1076
.L1077:
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L1079
	cmpl	$1, (%rax)
	jne	.L1079
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
.L1080:
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r9
.L1066:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L1083
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L1066
	cmpl	$1, (%rax)
	jne	.L1066
	jmp	.L1080
	.p2align 4,,10
	.p2align 3
.L1076:
	.cfi_def_cfa_offset 8
	movq	%r9, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1083:
	.cfi_def_cfa_offset 16
	movq	%r9, %rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE91:
	.size	edge_tail_words_top, .-edge_tail_words_top
	.section	.rodata.str1.1
.LC116:
	.string	"%s[%zu] = "
.LC117:
	.string	";\n"
.LC118:
	.string	"%s[%zu] = B_ADDR(%s[%zu]);\n"
	.text
	.p2align 4
	.globl	emit_edge_list_init
	.type	emit_edge_list_init, @function
emit_edge_list_init:
.LFB92:
	.cfi_startproc
	endbr64
	testq	%rcx, %rcx
	je	.L1117
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rcx, %r15
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
	cmpl	$1, (%rcx)
	jne	.L1085
	cmpq	$0, 24(%rcx)
	je	.L1085
	movq	%rsi, (%rsp)
	movq	%rdi, %rbx
	movq	%rdx, %r12
	movl	%r9d, %ebp
	movq	%r8, 8(%rsp)
	xorl	%r13d, %r13d
.L1098:
	movq	16(%r15), %rax
	movq	(%rax,%r13,8), %r10
	testq	%r10, %r10
	je	.L1093
	movl	(%r10), %eax
	testl	%eax, %eax
	je	.L1120
	cmpl	$1, %eax
	je	.L1121
.L1093:
	addq	$1, %r13
	addq	$1, %r12
	cmpq	24(%r15), %r13
	jb	.L1098
	movq	8(%rsp), %r8
.L1085:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r8, %rax
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
.L1120:
	.cfi_restore_state
	xorl	%r14d, %r14d
	testl	%ebp, %ebp
	jle	.L1091
	movq	%r12, 16(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4,,10
	.p2align 3
.L1088:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC26(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1088
	movq	16(%rsp), %r12
	movq	%r14, %r10
.L1091:
	movq	(%rsp), %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	movq	%r12, %r8
	leaq	.LC116(%rip), %rdx
	movq	%rbx, %rdi
	movq	%r10, 16(%rsp)
	call	__fprintf_chk@PLT
	movq	16(%rsp), %r10
	movq	16(%r10), %rsi
	cmpl	$2, (%rsi)
	je	.L1122
	movq	96(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L1092:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1093
	.p2align 4,,10
	.p2align 3
.L1117:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	movq	%r8, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1121:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	24(%r10), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmovne	%rax, %rdx
	xorl	%r14d, %r14d
	movq	%rdx, 16(%rsp)
	testl	%ebp, %ebp
	jle	.L1097
	movq	%r12, 24(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4,,10
	.p2align 3
.L1094:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC26(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1094
	movq	24(%rsp), %r12
	movq	%r14, %r10
.L1097:
	movq	%r10, 24(%rsp)
	subq	$8, %rsp
	.cfi_def_cfa_offset 104
	movq	%r12, %r8
	movq	%rbx, %rdi
	movq	16(%rsp), %r14
	leaq	.LC118(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	pushq	%r14
	.cfi_def_cfa_offset 112
	movq	16(%rsp), %r9
	movq	%r9, %rcx
	call	__fprintf_chk@PLT
	popq	%rax
	.cfi_def_cfa_offset 104
	pushq	104(%rsp)
	.cfi_def_cfa_offset 112
	movq	%r14, %rdx
	movq	40(%rsp), %r10
	movl	%ebp, %r9d
	movq	%rbx, %rdi
	movq	32(%rsp), %rax
	movq	16(%rsp), %rsi
	movq	%r10, %rcx
	movq	%r10, 32(%rsp)
	leaq	(%r14,%rax), %r8
	call	emit_edge_list_init
	popq	%rcx
	.cfi_def_cfa_offset 104
	popq	%rsi
	.cfi_def_cfa_offset 96
	movq	16(%rsp), %r10
	movq	%rax, %rdx
	cmpl	$1, (%r10)
	jne	.L1095
	movq	24(%r10), %rsi
	movq	16(%r10), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, 8(%rsp)
.L1095:
	movq	8(%rsp), %rax
	cmpq	%rdx, %rax
	cmovnb	%rax, %rdx
	movq	%rdx, 8(%rsp)
	jmp	.L1093
	.p2align 4,,10
	.p2align 3
.L1122:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1092
	.cfi_endproc
.LFE92:
	.size	emit_edge_list_init, .-emit_edge_list_init
	.section	.rodata.str1.8
	.align 8
.LC119:
	.string	"static void __attribute__((constructor(101))) __b_register_globals(void) {\n"
	.section	.rodata.str1.1
.LC120:
	.string	"}\n"
	.section	.rodata.str1.8
	.align 8
.LC121:
	.string	"    (void)B_PTR_N(%s, sizeof(%s));\n"
	.align 8
.LC122:
	.string	"    (void)B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.align 8
.LC123:
	.string	"static void __attribute__((constructor(102))) __bcc_bind_functions(void) {\n"
	.align 8
.LC124:
	.string	"static void __b_initialize_globals(void) {\n"
	.section	.rodata.str1.1
.LC125:
	.string	"    "
.LC126:
	.string	" = B_FUNCTION("
	.section	.rodata.str1.8
	.align 8
.LC127:
	.string	"    static struct __bcc_source_function __bcc_function_%zu = {(void*)"
	.align 8
.LC128:
	.string	", 0, 0};\n    __bcc_register_function(&__bcc_function_%zu);\n"
	.align 8
.LC129:
	.string	"    static struct __bcc_library_binding __bcc_binding_%zu = {"
	.align 8
.LC130:
	.string	", 0, 0};\n    __bcc_register_binding(&__bcc_binding_%zu);\n"
	.align 8
.LC131:
	.string	"    static struct __bcc_library_binding __bcc_data_%zu = {"
	.align 8
.LC132:
	.string	", 0, 0};\n    __bcc_register_binding(&__bcc_data_%zu);\n"
	.align 8
.LC133:
	.string	"}\nstatic struct __bcc_initializer __bcc_module = {__b_initialize_globals, 0, 0};\nstatic void __attribute__((constructor(102))) __bcc_register_module(void) {\n    __bcc_register_initializer(&__bcc_module);\n}\n\n"
	.align 8
.LC134:
	.string	"    %s[0] = B_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC135:
	.string	"__%s_store"
.LC136:
	.string	"    %s[0] = "
	.text
	.p2align 4
	.type	emit_global_initializers, @function
emit_global_initializers:
.LFB101:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.LC120(%rip), %rax
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
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	cmpl	$16, current_word_bits(%rip)
	movq	%rdx, 8(%rsp)
	movq	%rax, (%rsp)
	je	.L1188
.L1124:
	movq	%rbx, %rcx
	movl	$75, %edx
	movl	$1, %esi
	xorl	%ebp, %ebp
	leaq	.LC123(%rip), %rdi
	leaq	.LC125(%rip), %r15
	call	fwrite@PLT
	cmpq	$0, 8(%r14)
	leaq	.LC126(%rip), %r13
	jne	.L1131
	jmp	.L1137
	.p2align 4,,10
	.p2align 3
.L1134:
	movq	8(%r14), %rax
	addq	$1, %rbp
	cmpq	%rax, %rbp
	jnb	.L1189
.L1131:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %r12
	cmpl	$1, (%r12)
	jne	.L1134
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r12), %rax
	movq	(%rax), %rdi
	testq	%rdi, %rdi
	je	.L1135
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1135:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$14, %edx
	movq	%r13, %rdi
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r12), %rax
	movq	%rbx, %rdi
	movq	(%rax), %rsi
	call	emit_function_body_name
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC24(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rcx
	movl	$2, %esi
	movq	%rbx, %rdi
	leaq	.LC127(%rip), %rdx
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	8(%r12), %rax
	movq	%rbx, %rdi
	movq	(%rax), %rsi
	call	emit_function_body_name
	movq	%rbp, %rcx
	movl	$2, %esi
	movq	%rbx, %rdi
	leaq	.LC128(%rip), %rdx
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	%rbp, %rcx
	movl	$2, %esi
	movq	%rbx, %rdi
	leaq	.LC129(%rip), %rdx
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	8(%r12), %rax
	movq	%rbx, %rdi
	movq	(%rax), %rsi
	call	emit_c_string
	leaq	.LC87(%rip), %rdi
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r12), %rax
	movq	(%rax), %rdi
	testq	%rdi, %rdi
	je	.L1136
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1136:
	movq	%rbp, %rcx
	leaq	.LC130(%rip), %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movl	$2, %esi
	addq	$1, %rbp
	call	__fprintf_chk@PLT
	movq	8(%r14), %rax
	cmpq	%rax, %rbp
	jb	.L1131
.L1189:
	testq	%rax, %rax
	je	.L1137
	xorl	%r15d, %r15d
	leaq	.LC87(%rip), %r13
	leaq	.LC132(%rip), %r12
	.p2align 4,,10
	.p2align 3
.L1140:
	movq	(%r14), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$2, (%rax)
	jne	.L1138
	movq	8(%rax), %rax
	movl	4(%rax), %edi
	testl	%edi, %edi
	jne	.L1138
	movq	16(%rax), %rbp
	movq	%r15, %rcx
	leaq	.LC131(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	movq	%rbx, %rdi
	call	__fprintf_chk@PLT
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	emit_c_string
	movq	%rbx, %rcx
	movl	$2, %edx
	movq	%r13, %rdi
	movl	$1, %esi
	call	fwrite@PLT
	testq	%rbp, %rbp
	je	.L1139
	movq	%rbp, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1139:
	movq	%r15, %rcx
	movq	%r12, %rdx
	movl	$2, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
.L1138:
	addq	$1, %r15
	cmpq	8(%r14), %r15
	jb	.L1140
.L1137:
	movq	(%rsp), %rdi
	movq	%rbx, %rcx
	movl	$2, %edx
	xorl	%ebp, %ebp
	movl	$1, %esi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$43, %edx
	movl	$1, %esi
	leaq	.LC124(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8(%r14)
	jne	.L1132
	jmp	.L1133
	.p2align 4,,10
	.p2align 3
.L1142:
	addq	$1, %rbp
	cmpq	8(%r14), %rbp
	jnb	.L1133
.L1132:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$2, (%rax)
	jne	.L1142
	movq	8(%rax), %r12
	movq	16(%r12), %rdi
	call	get_mangled_name
	cmpl	$2, 24(%r12)
	movq	56(%r12), %r13
	movq	%rax, %r15
	je	.L1190
	testq	%r13, %r13
	je	.L1142
	movl	0(%r13), %eax
	cmpl	$1, %eax
	je	.L1191
	testl	%eax, %eax
	jne	.L1142
	movl	$2, %esi
	movq	%r15, %rcx
	leaq	.LC136(%rip), %rdx
	movq	%rbx, %rdi
	call	__fprintf_chk@PLT
	movq	16(%r13), %rsi
	cmpl	$2, (%rsi)
	je	.L1192
	movq	8(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L1150:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addq	$1, %rbp
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r14), %rbp
	jb	.L1132
.L1133:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$207, %edx
	movl	$1, %esi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC133(%rip), %rdi
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
.L1190:
	.cfi_restore_state
	movq	%rax, %r9
	movq	%rax, %r8
	movq	%rax, %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC134(%rip), %rdx
	movq	%rbx, %rdi
	call	__fprintf_chk@PLT
	testq	%r13, %r13
	je	.L1142
	cmpl	$1, 0(%r13)
	jne	.L1142
	movq	%r15, %rsi
	leaq	.LC135(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	xorl	%r8d, %r8d
	movq	%rax, %rsi
	movq	56(%r12), %rax
	testq	%rax, %rax
	je	.L1145
	cmpl	$1, (%rax)
	je	.L1193
.L1145:
	cmpq	$0, 32(%r12)
	movq	48(%r12), %rax
	je	.L1146
	cmpq	%rax, %r8
	movq	%r8, %rdx
	cmovb	%rax, %r8
	testq	%rax, %rax
	cmovle	%rdx, %r8
.L1146:
	subq	$8, %rsp
	.cfi_def_cfa_offset 88
	movq	%r13, %rcx
	movl	$1, %r9d
	pushq	16(%rsp)
	.cfi_def_cfa_offset 96
	xorl	%edx, %edx
	movq	%rbx, %rdi
	call	emit_edge_list_init
	popq	%rcx
	.cfi_def_cfa_offset 88
	popq	%rsi
	.cfi_def_cfa_offset 80
	jmp	.L1142
	.p2align 4,,10
	.p2align 3
.L1191:
	subq	$8, %rsp
	.cfi_def_cfa_offset 88
	movq	24(%r13), %r8
	xorl	%edx, %edx
	movl	$1, %r9d
	pushq	16(%rsp)
	.cfi_def_cfa_offset 96
	movq	%r13, %rcx
	movq	%r15, %rsi
	movq	%rbx, %rdi
	call	emit_edge_list_init
	popq	%rax
	.cfi_def_cfa_offset 88
	popq	%rdx
	.cfi_def_cfa_offset 80
	jmp	.L1142
	.p2align 4,,10
	.p2align 3
.L1188:
	movq	%rdi, %rcx
	movl	$75, %edx
	movl	$1, %esi
	xorl	%ebp, %ebp
	leaq	.LC119(%rip), %rdi
	leaq	.LC121(%rip), %r12
	call	fwrite@PLT
	cmpq	$0, 8(%r14)
	jne	.L1125
	.p2align 4,,10
	.p2align 3
.L1130:
	leaq	.LC120(%rip), %rax
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, (%rsp)
	call	fwrite@PLT
	jmp	.L1124
	.p2align 4,,10
	.p2align 3
.L1196:
	movq	8(%rdx), %r15
	movq	16(%r15), %rdi
	call	get_mangled_name
	movq	%r12, %rdx
	movl	$2, %esi
	movq	%rbx, %rdi
	movq	%rax, %r8
	movq	%rax, %rcx
	movq	%rax, %r13
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	cmpl	$2, 24(%r15)
	je	.L1194
.L1127:
	addq	$1, %rbp
	cmpq	8(%r14), %rbp
	jnb	.L1130
.L1125:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L1195
	cmpl	$2, %eax
	jne	.L1127
	jmp	.L1196
	.p2align 4,,10
	.p2align 3
.L1194:
	movq	%r13, %r8
	movq	%r13, %rcx
	leaq	.LC122(%rip), %rdx
	movq	%rbx, %rdi
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	jmp	.L1127
	.p2align 4,,10
	.p2align 3
.L1195:
	movq	8(%rdx), %rax
	movq	(%rax), %rdi
	call	get_mangled_name
	movq	%r12, %rdx
	movl	$2, %esi
	movq	%rbx, %rdi
	movq	%rax, %rcx
	movq	%rax, %r8
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	jmp	.L1127
	.p2align 4,,10
	.p2align 3
.L1192:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1150
.L1193:
	movq	24(%rax), %r8
	jmp	.L1145
	.cfi_endproc
.LFE101:
	.size	emit_global_initializers, .-emit_global_initializers
	.section	.rodata.str1.1
.LC137:
	.string	"<"
.LC138:
	.string	"<="
.LC139:
	.string	">"
.LC140:
	.string	">="
.LC141:
	.string	"??"
.LC142:
	.string	"{ word __bcc_target = "
.LC143:
	.string	"break;\n"
.LC144:
	.string	"return"
.LC145:
	.string	"{\n"
.LC146:
	.string	"return "
	.section	.rodata.str1.8
	.align 8
.LC147:
	.string	"%s = B_LOCAL_PTR_N(__%s_store, sizeof(__%s_store));\n"
	.section	.rodata.str1.1
.LC148:
	.string	" else {\n"
.LC149:
	.string	" 0"
.LC150:
	.string	"goto %s;\n"
.LC151:
	.string	"continue outside loop"
	.section	.rodata.str1.8
	.align 8
.LC152:
	.string	"if (__bcc_target == __bcc_label_target_%zu) goto __b_label_%zu;\n"
	.align 8
.LC153:
	.string	"fputs(\"bcc: invalid label value\\n\", stderr); abort();\n"
	.section	.rodata.str1.1
.LC154:
	.string	"__bsw%d_case%zu"
.LC155:
	.string	"for(;;) {\n"
.LC156:
	.string	"word __sw = "
.LC157:
	.string	"__bsw%d_end"
.LC158:
	.string	"goto __bsw%d_dispatch;\n"
.LC159:
	.string	"goto __bsw%d_end;\n"
.LC160:
	.string	"duplicate default in switch"
.LC161:
	.string	"if ("
.LC162:
	.string	"__sw %s (word)%ld"
	.section	.rodata.str1.8
	.align 8
.LC163:
	.string	"(__sw >= (word)%ld && __sw <= (word)%ld)"
	.section	.rodata.str1.1
.LC164:
	.string	"__sw == (word)%ld"
.LC165:
	.string	") goto "
.LC166:
	.string	"__bsw%d_end:\n"
.LC167:
	.string	"__b_label_%d:\n"
.LC168:
	.string	"__bsw%d_dispatch:\n"
.LC169:
	.string	") {\n"
	.text
	.p2align 4
	.globl	emit_stmt
	.type	emit_stmt, @function
emit_stmt:
.LFB95:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	%edx, %r15d
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdi, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	leaq	.L1201(%rip), %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
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
	movq	%r8, 8(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 232(%rsp)
	movq	%r8, %rax
	testq	%rax, %rax
	setne	%r12b
.L1330:
	movl	g_no_line(%rip), %eax
	testl	%eax, %eax
	jne	.L1198
	testb	%r12b, %r12b
	jne	.L1505
.L1198:
	cmpl	$12, (%rbx)
	ja	.L1197
	movl	(%rbx), %eax
	movslq	0(%r13,%rax,4), %rax
	addq	%r13, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1201:
	.long	.L1212-.L1201
	.long	.L1211-.L1201
	.long	.L1210-.L1201
	.long	.L1209-.L1201
	.long	.L1208-.L1201
	.long	.L1207-.L1201
	.long	.L1206-.L1201
	.long	.L1197-.L1201
	.long	.L1205-.L1201
	.long	.L1204-.L1201
	.long	.L1203-.L1201
	.long	.L1202-.L1201
	.long	.L1200-.L1201
	.text
	.p2align 4,,10
	.p2align 3
.L1505:
	movl	4(%rbx), %ecx
	movq	8(%rsp), %r8
	movl	$2, %esi
	movq	%r14, %rdi
	leaq	.LC27(%rip), %rdx
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	jmp	.L1198
.L1200:
	movl	g_switch_id(%rip), %eax
	xorl	%ebp, %ebp
	addl	$1, %eax
	movl	%eax, 48(%rsp)
	movl	%eax, g_switch_id(%rip)
	xorl	%eax, %eax
	call	vec_new@PLT
	movq	%rax, %r12
	xorl	%eax, %eax
	call	vec_new@PLT
	movq	24(%rbx), %rdi
	movq	%r12, %rsi
	movq	%rax, 16(%rsp)
	call	collect_cases
	leaq	96(%rsp), %rax
	cmpq	$0, 8(%r12)
	movq	%rax, 24(%rsp)
	je	.L1286
	movl	%r15d, 52(%rsp)
	movq	24(%rsp), %r13
	movq	%r14, 32(%rsp)
	movq	%rbp, %r14
	movq	16(%rsp), %rbp
	movq	%rbx, 40(%rsp)
	movl	48(%rsp), %ebx
	.p2align 4,,10
	.p2align 3
.L1283:
	movl	$16, %edi
	call	xmalloc@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 312
	movl	%ebx, %r9d
	movq	%r13, %rdi
	movq	%rax, %r15
	movq	(%r12), %rax
	movl	$128, %ecx
	leaq	.LC154(%rip), %r8
	movl	$2, %edx
	movl	$128, %esi
	movq	(%rax,%r14,8), %rax
	movq	%rax, (%r15)
	xorl	%eax, %eax
	pushq	%r14
	.cfi_def_cfa_offset 320
	addq	$1, %r14
	call	__snprintf_chk@PLT
	movq	%r13, %rdi
	call	strlen@PLT
	movq	g_compilation_arena(%rip), %rdi
	xorl	%edx, %edx
	movq	%r13, %rsi
	movq	%rax, %rcx
	call	arena_xstrdup_range@PLT
	movq	%rbp, %rdi
	movq	%r15, %rsi
	movq	%rax, 8(%r15)
	call	vec_push@PLT
	popq	%rdi
	.cfi_def_cfa_offset 312
	popq	%r8
	.cfi_def_cfa_offset 304
	cmpq	8(%r12), %r14
	jb	.L1283
	movq	32(%rsp), %r14
	movq	40(%rsp), %rbx
	movl	52(%rsp), %r15d
.L1286:
	xorl	%ebp, %ebp
	leaq	.LC26(%rip), %r13
	testl	%r15d, %r15d
	jle	.L1506
	.p2align 4,,10
	.p2align 3
.L1284:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r15d
	jne	.L1284
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC155(%rip), %rdi
	call	fwrite@PLT
	leal	1(%r15), %eax
	movl	%eax, 52(%rsp)
.L1287:
	xorl	%ebp, %ebp
	.p2align 4,,10
	.p2align 3
.L1290:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r15d
	jne	.L1290
	movq	%r14, %rcx
	movl	$12, %edx
	movl	$1, %esi
	xorl	%ebp, %ebp
	leaq	.LC156(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	8(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	leaq	.LC117(%rip), %rax
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 40(%rsp)
	call	fwrite@PLT
	movl	48(%rsp), %r9d
	movq	24(%rsp), %rdi
	leaq	.LC157(%rip), %r8
	movl	$64, %ecx
	movl	$2, %edx
	movl	$64, %esi
	xorl	%eax, %eax
	call	__snprintf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L1291:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r15d
	jne	.L1291
	movl	48(%rsp), %ecx
	leaq	.LC158(%rip), %rdx
	movq	%r14, %rdi
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	24(%rbx), %rsi
	movq	24(%rsp), %rax
	xorl	%ebx, %ebx
	movq	8(%rsp), %r8
	movq	16(%rsp), %rcx
	movq	%r14, %rdi
	movl	$1, 64(%rsp)
	movq	%rax, 72(%rsp)
	movq	g_ctrl(%rip), %rax
	movl	52(%rsp), %edx
	movq	%rax, 80(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, g_ctrl(%rip)
	call	emit_stmt_switchctx
	movq	80(%rsp), %rax
	movq	%rax, g_ctrl(%rip)
	.p2align 4,,10
	.p2align 3
.L1292:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %r15d
	jne	.L1292
	leaq	.LC159(%rip), %rax
	movl	48(%rsp), %ecx
	movq	%r14, %rdi
	xorl	%ebx, %ebx
	movq	%rax, 56(%rsp)
	movq	%rax, %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L1293:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %r15d
	jne	.L1293
	movl	48(%rsp), %ecx
	xorl	%eax, %eax
	leaq	.LC168(%rip), %rdx
	movq	%r14, %rdi
	movl	$2, %esi
	call	__fprintf_chk@PLT
	cmpq	$0, 8(%r12)
	je	.L1507
.L1338:
	movq	$0, 24(%rsp)
	xorl	%ebx, %ebx
	movl	%r15d, 32(%rsp)
	.p2align 4,,10
	.p2align 3
.L1308:
	movq	(%r12), %rax
	movq	(%rax,%rbx,8), %r15
	movq	16(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1366
	xorl	%eax, %eax
	jmp	.L1297
	.p2align 4,,10
	.p2align 3
.L1296:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1366
.L1297:
	movq	(%rsi,%rax,8), %rdx
	cmpq	(%rdx), %r15
	jne	.L1296
	movq	8(%rdx), %rax
	cmpl	$61, 20(%r15)
	movq	%rax, 8(%rsp)
	jne	.L1298
.L1518:
	cmpq	$0, 24(%rsp)
	jne	.L1508
	movq	8(%rsp), %rax
	movq	%rax, 24(%rsp)
.L1299:
	addq	$1, %rbx
	cmpq	8(%r12), %rbx
	jb	.L1308
	movl	32(%rsp), %r15d
	leaq	.LC26(%rip), %r13
	leal	2(%r15), %ebx
	testl	%ebx, %ebx
	jle	.L1312
.L1310:
	xorl	%ebp, %ebp
	.p2align 4,,10
	.p2align 3
.L1313:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jne	.L1313
.L1312:
	movq	24(%rsp), %rax
	testq	%rax, %rax
	je	.L1314
	movq	%rax, %rcx
	leaq	.LC150(%rip), %rdx
	movq	%r14, %rdi
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
.L1315:
	movl	52(%rsp), %eax
	xorl	%ebp, %ebp
	leaq	.LC26(%rip), %r13
	testl	%eax, %eax
	jle	.L1316
	.p2align 4,,10
	.p2align 3
.L1317:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r15d
	jne	.L1317
.L1316:
	movl	48(%rsp), %ecx
	leaq	.LC166(%rip), %rdx
	movq	%r14, %rdi
	xorl	%eax, %eax
	movl	$2, %esi
	xorl	%ebp, %ebp
	leaq	.LC26(%rip), %r13
	call	__fprintf_chk@PLT
	testl	%ebx, %ebx
	jle	.L1509
	.p2align 4,,10
	.p2align 3
.L1318:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %ebx
	jne	.L1318
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	xorl	%ebx, %ebx
	leaq	.LC143(%rip), %rdi
	call	fwrite@PLT
	testl	%r15d, %r15d
	jle	.L1322
	.p2align 4,,10
	.p2align 3
.L1323:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r15d
	jne	.L1323
.L1322:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
.L1197:
	movq	232(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1502
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
.L1212:
	.cfi_restore_state
	xorl	%ebx, %ebx
	leaq	.LC26(%rip), %r13
	testl	%r15d, %r15d
	jle	.L1504
	.p2align 4,,10
	.p2align 3
.L1232:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r15d
	jne	.L1232
.L1504:
	movq	232(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1502
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
.L1501:
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
.L1211:
	.cfi_restore_state
	xorl	%r8d, %r8d
	leaq	.LC26(%rip), %r13
	testl	%r15d, %r15d
	jle	.L1510
	movq	%rbx, 16(%rsp)
	movl	%r8d, %ebx
	.p2align 4,,10
	.p2align 3
.L1230:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r15d
	jne	.L1230
	movq	16(%rsp), %rbx
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L1237
.L1236:
	leal	1(%r15), %edi
	movb	%r12b, 40(%rsp)
	xorl	%r13d, %r13d
	movl	%edi, 32(%rsp)
	movl	%r15d, 16(%rsp)
.L1244:
	movq	16(%rbx), %rdx
	movq	(%rdx,%r13,8), %r12
	testl	%ebp, %ebp
	je	.L1357
	subq	$1, %rax
	xorl	%ecx, %ecx
	cmpq	%r13, %rax
	je	.L1511
.L1239:
	movq	8(%rsp), %r8
	movl	32(%rsp), %edx
	movq	%r12, %rsi
	movq	%r14, %rdi
	call	emit_stmt
.L1242:
	movq	24(%rbx), %rax
	addq	$1, %r13
	cmpq	%rax, %r13
	jb	.L1244
	movl	16(%rsp), %r15d
	leaq	.LC26(%rip), %r13
	testl	%r15d, %r15d
	jle	.L1246
.L1237:
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L1247:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r15d
	jne	.L1247
.L1246:
	movq	232(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1502
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	jmp	.L1501
.L1210:
	xorl	%r13d, %r13d
	cmpq	$0, 24(%rbx)
	leaq	.LC26(%rip), %rbp
	je	.L1197
	.p2align 4,,10
	.p2align 3
.L1229:
	movq	16(%rbx), %rax
	movq	(%rax,%r13,8), %r12
	movq	(%r12), %rdi
	call	get_mangled_name
	movl	g_strict(%rip), %r11d
	movq	%rax, 16(%rsp)
	testl	%r11d, %r11d
	je	.L1512
	cmpq	$0, 8(%r12)
	je	.L1334
.L1333:
	xorl	%r12d, %r12d
	testl	%r15d, %r15d
	jle	.L1253
	.p2align 4,,10
	.p2align 3
.L1251:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1251
.L1253:
	movq	16(%rsp), %rcx
	movl	$2, %esi
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC147(%rip), %rdx
	movq	%rcx, %r9
	movq	%rcx, %r8
	call	__fprintf_chk@PLT
.L1252:
	addq	$1, %r13
	cmpq	24(%rbx), %r13
	jb	.L1229
	jmp	.L1197
.L1209:
	xorl	%r12d, %r12d
	leaq	.LC26(%rip), %r13
	testl	%r15d, %r15d
	jle	.L1513
	.p2align 4,,10
	.p2align 3
.L1227:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1227
	movq	%r14, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC161(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	8(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC169(%rip), %rdi
	call	fwrite@PLT
	testl	%ebp, %ebp
	jne	.L1340
	leal	1(%r15), %ebp
	movq	24(%rbx), %rsi
	movq	8(%rsp), %r8
	xorl	%ecx, %ecx
	movl	%ebp, %edx
	movq	%r14, %rdi
	call	emit_stmt
	jmp	.L1342
.L1208:
	movq	232(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1502
	movq	8(%rsp), %r8
	movl	%r15d, %edx
	movq	%rbx, %rsi
	movq	%r14, %rdi
	addq	$248, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
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
	jmp	emit_while
.L1205:
	.cfi_restore_state
	xorl	%ebx, %ebx
	leaq	.LC26(%rip), %r13
	testl	%r15d, %r15d
	jle	.L1268
	.p2align 4,,10
	.p2align 3
.L1219:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r15d
	jne	.L1219
.L1268:
	movq	232(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1502
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC143(%rip), %rdi
	jmp	.L1501
.L1204:
	movq	g_ctrl(%rip), %rbx
	testq	%rbx, %rbx
	jne	.L1269
	jmp	.L1270
	.p2align 4,,10
	.p2align 3
.L1271:
	movq	16(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L1270
.L1269:
	movl	(%rbx), %r9d
	testl	%r9d, %r9d
	jne	.L1271
	xorl	%ebp, %ebp
	leaq	.LC26(%rip), %r13
	testl	%r15d, %r15d
	jle	.L1275
	.p2align 4,,10
	.p2align 3
.L1274:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r15d
	jne	.L1274
.L1275:
	movq	232(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1502
	movq	8(%rbx), %rcx
	addq	$248, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r14, %rdi
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC150(%rip), %rdx
	popq	%rbp
	.cfi_def_cfa_offset 40
	movl	$2, %esi
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	__fprintf_chk@PLT
.L1203:
	.cfi_restore_state
	xorl	%ebp, %ebp
	leaq	.LC26(%rip), %r13
	testl	%r15d, %r15d
	jle	.L1276
	.p2align 4,,10
	.p2align 3
.L1216:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r15d
	jne	.L1216
.L1276:
	movq	%r14, %rcx
	movl	$22, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC142(%rip), %rdi
	leaq	.LC152(%rip), %r13
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	%r14, %rdi
	movq	8(%rsp), %rdx
	leaq	.LC26(%rip), %rbp
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	je	.L1218
	.p2align 4,,10
	.p2align 3
.L1217:
	xorl	%ebx, %ebx
	testl	%r15d, %r15d
	js	.L1278
	.p2align 4,,10
	.p2align 3
.L1277:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r15d
	jge	.L1277
.L1278:
	addq	$1, %r12
	xorl	%eax, %eax
	movq	%r13, %rdx
	movl	$2, %esi
	movq	%r12, %r8
	movq	%r12, %rcx
	movq	%r14, %rdi
	call	__fprintf_chk@PLT
	cmpq	8+function_labels(%rip), %r12
	jb	.L1217
.L1218:
	testl	%r15d, %r15d
	js	.L1279
	xorl	%ebx, %ebx
	leaq	.LC26(%rip), %r13
	.p2align 4,,10
	.p2align 3
.L1280:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r15d
	jge	.L1280
	movq	%r14, %rcx
	movl	$54, %edx
	movl	$1, %esi
	leaq	.LC153(%rip), %rdi
	call	fwrite@PLT
	testl	%r15d, %r15d
	je	.L1246
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L1282:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r15d
	jne	.L1282
	jmp	.L1246
.L1207:
	xorl	%ebp, %ebp
	leaq	.LC26(%rip), %r13
	testl	%r15d, %r15d
	jle	.L1265
	.p2align 4,,10
	.p2align 3
.L1224:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r15d
	jne	.L1224
.L1265:
	movq	%r14, %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC144(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%rbx)
	je	.L1514
	movq	%r14, %rsi
	movl	$32, %edi
	call	fputc@PLT
	movq	16(%rbx), %rsi
	movq	8(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	jmp	.L1504
.L1202:
	leaq	.LC26(%rip), %rax
	xorl	%ebp, %ebp
	movq	%rax, 16(%rsp)
	testl	%r15d, %r15d
	jle	.L1515
	.p2align 4,,10
	.p2align 3
.L1213:
	movq	16(%rsp), %rdi
	movq	%r14, %rcx
	movl	$2, %edx
	addl	$1, %ebp
	movl	$1, %esi
	call	fwrite@PLT
	cmpl	%ebp, %r15d
	jne	.L1213
	movq	16(%rbx), %rax
	movq	%rax, 24(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 32(%rsp)
	testq	%rax, %rax
	je	.L1516
.L1214:
	movq	function_labels(%rip), %rdx
	xorl	%ebp, %ebp
	jmp	.L1328
	.p2align 4,,10
	.p2align 3
.L1326:
	addq	$1, %rbp
	cmpq	%rbp, 32(%rsp)
	je	.L1215
.L1328:
	movq	(%rdx,%rbp,8), %rsi
	movq	24(%rsp), %rdi
	movq	%rdx, 16(%rsp)
	call	strcmp@PLT
	movq	16(%rsp), %rdx
	testl	%eax, %eax
	jne	.L1326
	leal	1(%rbp), %ecx
.L1327:
	leaq	.LC167(%rip), %rdx
	movq	%r14, %rdi
	xorl	%eax, %eax
	addl	$1, %r15d
	movl	$2, %esi
	call	__fprintf_chk@PLT
	leaq	.LC26(%rip), %rax
	movq	%rax, 16(%rsp)
	testl	%r15d, %r15d
	jle	.L1332
.L1329:
	xorl	%ebp, %ebp
	.p2align 4,,10
	.p2align 3
.L1331:
	movq	16(%rsp), %rdi
	movq	%r14, %rcx
	movl	$2, %edx
	addl	$1, %ebp
	movl	$1, %esi
	call	fwrite@PLT
	cmpl	%r15d, %ebp
	jne	.L1331
.L1332:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	xorl	%ebp, %ebp
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	jmp	.L1330
.L1206:
	xorl	%r12d, %r12d
	leaq	.LC26(%rip), %r13
	testl	%r15d, %r15d
	jle	.L1266
	.p2align 4,,10
	.p2align 3
.L1221:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1221
.L1266:
	testl	%ebp, %ebp
	jne	.L1517
.L1223:
	movq	16(%rbx), %rsi
	movq	8(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	jmp	.L1504
	.p2align 4,,10
	.p2align 3
.L1366:
	movq	$0, 8(%rsp)
	cmpl	$61, 20(%r15)
	je	.L1518
.L1298:
	movl	32(%rsp), %eax
	xorl	%ebp, %ebp
	leal	2(%rax), %r13d
	testl	%r13d, %r13d
	jle	.L1303
	.p2align 4,,10
	.p2align 3
.L1300:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %ebp
	leaq	.LC26(%rip), %rdi
	call	fwrite@PLT
	cmpl	%ebp, %r13d
	jne	.L1300
.L1303:
	movq	%r14, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC161(%rip), %rdi
	call	fwrite@PLT
	movl	20(%r15), %eax
	testl	%eax, %eax
	je	.L1519
	leaq	.LC139(%rip), %rcx
	cmpl	$26, %eax
	je	.L1304
	ja	.L1305
	leaq	.LC137(%rip), %rcx
	cmpl	$24, %eax
	je	.L1304
	cmpl	$25, %eax
	leaq	.LC141(%rip), %rcx
	leaq	.LC138(%rip), %rax
	cmove	%rax, %rcx
.L1304:
	movq	24(%r15), %r8
	leaq	.LC162(%rip), %rdx
	movq	%r14, %rdi
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
.L1306:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC165(%rip), %rdi
	call	fwrite@PLT
	movq	8(%rsp), %rdi
	movq	%r14, %rsi
	call	fputs@PLT
	movq	40(%rsp), %rdi
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	call	fwrite@PLT
	jmp	.L1299
	.p2align 4,,10
	.p2align 3
.L1519:
	movl	16(%r15), %esi
	movq	24(%r15), %rcx
	testl	%esi, %esi
	je	.L1307
	movq	32(%r15), %r8
	leaq	.LC163(%rip), %rdx
	movq	%r14, %rdi
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	jmp	.L1306
	.p2align 4,,10
	.p2align 3
.L1512:
	movq	8(%rsp), %rcx
	movl	%r15d, %edx
	movq	%r12, %rsi
	movq	%r14, %rdi
	call	emit_auto_storage
	cmpq	$0, 8(%r12)
	jne	.L1333
	movl	g_strict(%rip), %r10d
	testl	%r10d, %r10d
	je	.L1252
.L1334:
	xorl	%r12d, %r12d
	testl	%r15d, %r15d
	jle	.L1255
	.p2align 4,,10
	.p2align 3
.L1254:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1254
.L1255:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1252
.L1511:
	cmpl	$6, (%r12)
	movl	%ebp, %ecx
	jne	.L1239
	movl	g_no_line(%rip), %eax
	testl	%eax, %eax
	jne	.L1240
	cmpb	$0, 40(%rsp)
	je	.L1240
	movl	4(%r12), %ecx
	movq	8(%rsp), %r8
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC27(%rip), %rdx
	movl	$2, %esi
	call	__fprintf_chk@PLT
.L1240:
	leaq	.LC26(%rip), %rax
	xorl	%r15d, %r15d
	movq	%rax, 24(%rsp)
	movl	16(%rsp), %eax
	testl	%eax, %eax
	js	.L1243
	.p2align 4,,10
	.p2align 3
.L1241:
	movq	24(%rsp), %rdi
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r15d
	call	fwrite@PLT
	cmpl	%r15d, 16(%rsp)
	jge	.L1241
.L1243:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC146(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r12), %rsi
	movq	8(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1242
	.p2align 4,,10
	.p2align 3
.L1307:
	leaq	.LC164(%rip), %rdx
	movl	$2, %esi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	jmp	.L1306
	.p2align 4,,10
	.p2align 3
.L1357:
	xorl	%ecx, %ecx
	jmp	.L1239
.L1305:
	cmpl	$27, %eax
	leaq	.LC141(%rip), %rcx
	leaq	.LC140(%rip), %rax
	cmove	%rax, %rcx
	jmp	.L1304
.L1340:
	xorl	%ecx, %ecx
	leal	1(%r15), %ebp
	cmpq	$0, 32(%rbx)
	movq	24(%rbx), %rsi
	movq	8(%rsp), %r8
	sete	%cl
	movl	%ebp, %edx
	movq	%r14, %rdi
	call	emit_stmt
	testl	%r15d, %r15d
	jle	.L1258
	leaq	.LC26(%rip), %r13
.L1342:
	xorl	%r12d, %r12d
	.p2align 4,,10
	.p2align 3
.L1259:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r15d
	jne	.L1259
	movq	%r14, %rsi
	movl	$125, %edi
	call	fputc@PLT
	cmpq	$0, 32(%rbx)
	je	.L1261
	movq	%r14, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rsi
	movq	8(%rsp), %r8
	xorl	%ecx, %ecx
	movl	%ebp, %edx
	movq	%r14, %rdi
	xorl	%ebx, %ebx
	call	emit_stmt
	.p2align 4,,10
	.p2align 3
.L1262:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r15d
	jne	.L1262
.L1335:
	movq	%r14, %rsi
	movl	$125, %edi
	call	fputc@PLT
.L1261:
	movq	232(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1502
	addq	$248, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r14, %rsi
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
.L1517:
	.cfi_restore_state
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC146(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1223
.L1514:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC149(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1504
.L1314:
	movl	48(%rsp), %ecx
	movq	56(%rsp), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	movq	%r14, %rdi
	call	__fprintf_chk@PLT
	jmp	.L1315
.L1509:
	movq	%r14, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC143(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1322
.L1513:
	movq	%r14, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC161(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	8(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	movq	%r14, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC169(%rip), %rdi
	call	fwrite@PLT
	testl	%ebp, %ebp
	jne	.L1340
	leal	1(%r15), %ebp
	movq	24(%rbx), %rsi
	movq	8(%rsp), %r8
	xorl	%ecx, %ecx
	movl	%ebp, %edx
	movq	%r14, %rdi
	call	emit_stmt
.L1258:
	movq	%r14, %rsi
	movl	$125, %edi
	call	fputc@PLT
	cmpq	$0, 32(%rbx)
	je	.L1261
	movq	%r14, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rsi
	movq	8(%rsp), %r8
	xorl	%ecx, %ecx
	movl	%ebp, %edx
	movq	%r14, %rdi
	call	emit_stmt
	jmp	.L1335
.L1510:
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	jne	.L1236
	jmp	.L1246
.L1515:
	movq	16(%rbx), %rax
	movq	%rax, 24(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 32(%rsp)
	testq	%rax, %rax
	jne	.L1214
.L1215:
	xorl	%ecx, %ecx
	jmp	.L1327
	.p2align 4,,10
	.p2align 3
.L1279:
	movq	%r14, %rcx
	movl	$54, %edx
	movl	$1, %esi
	leaq	.LC153(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1246
.L1506:
	movq	%r14, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC155(%rip), %rdi
	call	fwrite@PLT
	leal	1(%r15), %eax
	movl	%eax, 52(%rsp)
	testl	%r15d, %r15d
	je	.L1287
	movq	%r14, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC156(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	8(%rsp), %rdx
	movq	%r14, %rdi
	call	emit_expr
	leaq	.LC117(%rip), %rax
	movq	%r14, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 40(%rsp)
	call	fwrite@PLT
	movl	48(%rsp), %ebp
	movq	24(%rsp), %rdi
	xorl	%eax, %eax
	movl	$64, %ecx
	movl	$2, %edx
	movl	$64, %esi
	movl	%ebp, %r9d
	leaq	.LC157(%rip), %r8
	call	__snprintf_chk@PLT
	movl	%ebp, %ecx
	leaq	.LC158(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	movq	%r14, %rdi
	call	__fprintf_chk@PLT
	movq	24(%rbx), %rsi
	movl	52(%rsp), %edx
	movq	%r14, %rdi
	movq	24(%rsp), %rax
	movq	8(%rsp), %r8
	movl	$1, 64(%rsp)
	movq	16(%rsp), %rcx
	movq	%rax, 72(%rsp)
	movq	g_ctrl(%rip), %rax
	movq	%rax, 80(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, g_ctrl(%rip)
	call	emit_stmt_switchctx
	movq	80(%rsp), %rax
	movl	%ebp, %ecx
	movq	%r14, %rdi
	movl	$2, %esi
	movq	%rax, g_ctrl(%rip)
	leaq	.LC159(%rip), %rax
	movq	%rax, %rdx
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	xorl	%eax, %eax
	movl	%ebp, %ecx
	leaq	.LC168(%rip), %rdx
	movl	$2, %esi
	movq	%r14, %rdi
	call	__fprintf_chk@PLT
	cmpq	$0, 8(%r12)
	jne	.L1338
	leal	2(%r15), %ebx
	cmpl	$-1, %r15d
	je	.L1520
	movl	48(%rsp), %ecx
	movq	56(%rsp), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	movq	%r14, %rdi
	call	__fprintf_chk@PLT
	jmp	.L1316
.L1507:
	movq	$0, 24(%rsp)
	leal	2(%r15), %ebx
	jmp	.L1310
.L1516:
	xorl	%ecx, %ecx
	leaq	.LC167(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	movq	%r14, %rdi
	addl	$1, %r15d
	call	__fprintf_chk@PLT
	jmp	.L1329
.L1270:
	leaq	.LC151(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L1508:
	leaq	.LC160(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L1520:
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	movl	%edx, 52(%rsp)
	movq	%rcx, 24(%rsp)
	jmp	.L1310
.L1502:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE95:
	.size	emit_stmt, .-emit_stmt
	.section	.rodata.str1.1
.LC170:
	.string	"%s:\n"
	.text
	.p2align 4
	.type	emit_stmt_switchctx, @function
emit_stmt_switchctx:
.LFB80:
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
	movq	%r8, 8(%rsp)
	testq	%rsi, %rsi
	je	.L1521
	movq	%rdi, %rbx
	movq	%rsi, %r13
	movl	%edx, %ebp
	movq	%rcx, %r15
.L1522:
	cmpl	$13, 0(%r13)
	ja	.L1525
	movl	0(%r13), %eax
	leaq	.L1527(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1527:
	.long	.L1525-.L1527
	.long	.L1531-.L1527
	.long	.L1525-.L1527
	.long	.L1530-.L1527
	.long	.L1529-.L1527
	.long	.L1525-.L1527
	.long	.L1525-.L1527
	.long	.L1525-.L1527
	.long	.L1525-.L1527
	.long	.L1525-.L1527
	.long	.L1525-.L1527
	.long	.L1528-.L1527
	.long	.L1525-.L1527
	.long	.L1526-.L1527
	.text
	.p2align 4,,10
	.p2align 3
.L1525:
	movq	8(%rsp), %r8
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
.L1526:
	.cfi_restore_state
	movq	8(%r15), %rcx
	movq	(%r15), %rsi
	testq	%rcx, %rcx
	je	.L1571
	xorl	%eax, %eax
	jmp	.L1541
	.p2align 4,,10
	.p2align 3
.L1540:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1571
.L1541:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%r13, (%rdx)
	jne	.L1540
	movq	8(%rdx), %rax
	movq	%rax, 16(%rsp)
.L1539:
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1602
	.p2align 4,,10
	.p2align 3
.L1542:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1542
	movq	16(%rsp), %rcx
	movl	$2, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC170(%rip), %rdx
	xorl	%r14d, %r14d
	call	__fprintf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L1545:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jle	.L1545
.L1544:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	movq	40(%r13), %r13
	jmp	.L1546
	.p2align 4,,10
	.p2align 3
.L1531:
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1603
	.p2align 4,,10
	.p2align 3
.L1537:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1537
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	je	.L1555
.L1554:
	leal	1(%rbp), %r12d
	xorl	%r14d, %r14d
.L1557:
	movq	16(%r13), %rdx
	movq	8(%rsp), %r8
	movq	%r15, %rcx
	movq	%rbx, %rdi
	movq	(%rdx,%r14,8), %rsi
	movl	%r12d, %edx
	addq	$1, %r14
	call	emit_stmt_switchctx
	cmpq	24(%r13), %r14
	jb	.L1557
	leaq	.LC26(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1556
.L1555:
	xorl	%r13d, %r13d
	.p2align 4,,10
	.p2align 3
.L1559:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1559
.L1556:
	addq	$40, %rsp
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
.L1530:
	.cfi_restore_state
	leal	1(%rbp), %eax
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %r12
	movl	%eax, 16(%rsp)
	testl	%ebp, %ebp
	jle	.L1604
	.p2align 4,,10
	.p2align 3
.L1535:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1535
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC161(%rip), %rdi
	call	fwrite@PLT
	movq	8(%rsp), %r14
	movq	16(%r13), %rsi
	movq	%rbx, %rdi
	movq	%r14, %rdx
	call	emit_expr
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC169(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %rsi
	movl	16(%rsp), %edx
	movq	%r14, %r8
	movq	%r15, %rcx
	movq	%rbx, %rdi
	xorl	%r14d, %r14d
	call	emit_stmt_switchctx
	.p2align 4,,10
	.p2align 3
.L1560:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1560
	movq	%rbx, %rsi
	movl	$125, %edi
	call	fputc@PLT
	cmpq	$0, 32(%r13)
	je	.L1562
	movq	%rbx, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r13), %rsi
	movl	16(%rsp), %edx
	movq	%r15, %rcx
	movq	8(%rsp), %r8
	movq	%rbx, %rdi
	xorl	%r13d, %r13d
	call	emit_stmt_switchctx
	.p2align 4,,10
	.p2align 3
.L1563:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1563
.L1564:
	movq	%rbx, %rsi
	movl	$125, %edi
	call	fputc@PLT
.L1562:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rsi
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
	.p2align 4,,10
	.p2align 3
.L1529:
	.cfi_restore_state
	movq	8(%rsp), %r8
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r15, %rcx
	movl	%ebp, %edx
	movq	%r13, %rsi
	movq	%rbx, %rdi
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
	jmp	emit_while
	.p2align 4,,10
	.p2align 3
.L1528:
	.cfi_restore_state
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1605
	.p2align 4,,10
	.p2align 3
.L1532:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1532
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L1606
.L1533:
	movq	function_labels(%rip), %r14
	xorl	%r12d, %r12d
	jmp	.L1550
	.p2align 4,,10
	.p2align 3
.L1548:
	movq	24(%rsp), %rax
	addq	$1, %r12
	cmpq	%rax, %r12
	je	.L1534
.L1550:
	movq	(%r14,%r12,8), %rsi
	movq	16(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1548
	leal	1(%r12), %ecx
.L1549:
	leaq	.LC167(%rip), %rdx
	movl	$2, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	leal	1(%rbp), %eax
	leaq	.LC26(%rip), %r12
	movl	%eax, 16(%rsp)
	testl	%eax, %eax
	jle	.L1553
.L1551:
	xorl	%r14d, %r14d
	.p2align 4,,10
	.p2align 3
.L1552:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, %ebp
	jne	.L1552
.L1553:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	movl	16(%rsp), %ebp
.L1546:
	testq	%r13, %r13
	jne	.L1522
.L1521:
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
.L1571:
	.cfi_restore_state
	movq	$0, 16(%rsp)
	jmp	.L1539
	.p2align 4,,10
	.p2align 3
.L1602:
	movq	16(%rsp), %rcx
	xorl	%eax, %eax
	movl	$2, %esi
	movq	%rbx, %rdi
	leaq	.LC170(%rip), %rdx
	call	__fprintf_chk@PLT
	testl	%ebp, %ebp
	jne	.L1544
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	jmp	.L1544
	.p2align 4,,10
	.p2align 3
.L1605:
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	jne	.L1533
	.p2align 4,,10
	.p2align 3
.L1534:
	xorl	%ecx, %ecx
	jmp	.L1549
	.p2align 4,,10
	.p2align 3
.L1604:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC161(%rip), %rdi
	call	fwrite@PLT
	movq	8(%rsp), %r14
	movq	16(%r13), %rsi
	movq	%rbx, %rdi
	movq	%r14, %rdx
	call	emit_expr
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC169(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %rsi
	movl	16(%rsp), %edx
	movq	%r14, %r8
	movq	%r15, %rcx
	movq	%rbx, %rdi
	call	emit_stmt_switchctx
	movq	%rbx, %rsi
	movl	$125, %edi
	call	fputc@PLT
	cmpq	$0, 32(%r13)
	je	.L1562
	movq	%rbx, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	movq	32(%r13), %rsi
	movl	16(%rsp), %edx
	movq	%r15, %rcx
	movq	8(%rsp), %r8
	movq	%rbx, %rdi
	call	emit_stmt_switchctx
	jmp	.L1564
	.p2align 4,,10
	.p2align 3
.L1603:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	jne	.L1554
	jmp	.L1556
.L1606:
	xorl	%ecx, %ecx
	leaq	.LC167(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	call	__fprintf_chk@PLT
	leal	1(%rbp), %eax
	movl	%eax, 16(%rsp)
	jmp	.L1551
	.cfi_endproc
.LFE80:
	.size	emit_stmt_switchctx, .-emit_stmt_switchctx
	.section	.rodata.str1.1
.LC171:
	.string	"__bloop%u_condition"
.LC172:
	.string	"%s:;\n"
.LC173:
	.string	"while ("
	.text
	.p2align 4
	.type	emit_while, @function
emit_while:
.LFB82:
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
	movq	%rsi, %r13
	movl	$64, %esi
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	%edx, %ebp
	movl	$2, %edx
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$136, %rsp
	.cfi_def_cfa_offset 192
	movq	%rcx, 8(%rsp)
	leaq	48(%rsp), %r15
	movl	$64, %ecx
	movq	%r8, (%rsp)
	movq	%r15, %rdi
	leaq	.LC171(%rip), %r8
	movq	%fs:40, %rax
	movq	%rax, 120(%rsp)
	movl	g_loop_id(%rip), %eax
	leal	1(%rax), %r9d
	xorl	%eax, %eax
	movl	%r9d, g_loop_id(%rip)
	call	__snprintf_chk@PLT
	movq	24(%r13), %rdi
	call	loop_has_continue
	testl	%eax, %eax
	jne	.L1630
	leaq	.LC26(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1612
.L1613:
	xorl	%r14d, %r14d
	.p2align 4,,10
	.p2align 3
.L1614:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%r14d, %ebp
	jne	.L1614
.L1612:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC173(%rip), %rdi
	call	fwrite@PLT
	movq	(%rsp), %r14
	movq	16(%r13), %rsi
	movq	%rbx, %rdi
	movq	%r14, %rdx
	call	emit_expr
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC169(%rip), %rdi
	call	fwrite@PLT
	movq	g_ctrl(%rip), %rax
	movq	8(%rsp), %rcx
	leal	1(%rbp), %edx
	movl	$0, 16(%rsp)
	movq	24(%r13), %rsi
	movq	%rax, 32(%rsp)
	leaq	16(%rsp), %rax
	movq	%r15, 24(%rsp)
	movq	%rax, g_ctrl(%rip)
	testq	%rcx, %rcx
	je	.L1616
	movq	%r14, %r8
	movq	%rbx, %rdi
	call	emit_stmt_switchctx
.L1617:
	movq	32(%rsp), %rax
	xorl	%r13d, %r13d
	leaq	.LC26(%rip), %r12
	movq	%rax, g_ctrl(%rip)
	testl	%ebp, %ebp
	jle	.L1619
	.p2align 4,,10
	.p2align 3
.L1618:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%r13d, %ebp
	jne	.L1618
.L1619:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
	movq	120(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1631
	addq	$136, %rsp
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
.L1630:
	.cfi_restore_state
	testl	%ebp, %ebp
	jle	.L1609
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %r12
	.p2align 4,,10
	.p2align 3
.L1610:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%r14d, %ebp
	jne	.L1610
	movq	%r15, %rcx
	leaq	.LC172(%rip), %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	jmp	.L1613
	.p2align 4,,10
	.p2align 3
.L1616:
	movq	(%rsp), %r8
	xorl	%ecx, %ecx
	movq	%rbx, %rdi
	call	emit_stmt
	jmp	.L1617
.L1609:
	movq	%r15, %rcx
	leaq	.LC172(%rip), %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	jmp	.L1612
.L1631:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE82:
	.size	emit_while, .-emit_while
	.section	.rodata.str1.1
.LC174:
	.string	"static "
.LC175:
	.string	""
	.section	.rodata.str1.8
	.align 8
.LC176:
	.string	"#ifndef %s\nextern word %s[];\n#define __b_external_%s (%s[0])\n#else\n#define __b_external_%s (%s)\n#endif\n"
	.section	.rodata.str1.1
.LC177:
	.string	"extern word %s[];\n"
.LC178:
	.string	"%sword %s[%zu];\n"
.LC179:
	.string	"static word __%s_store[%zu];\n"
	.text
	.p2align 4
	.type	emit_global_declarations, @function
emit_global_declarations:
.LFB100:
	.cfi_startproc
	cmpq	$0, 8(%rsi)
	je	.L1664
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
	xorl	%ebx, %ebx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movq	%rdx, 8(%rsp)
	jmp	.L1646
	.p2align 4,,10
	.p2align 3
.L1635:
	addq	$1, %rbx
	cmpq	8(%r14), %rbx
	jnb	.L1667
.L1646:
	movq	(%r14), %rax
	movq	(%rax,%rbx,8), %r12
	movl	(%r12), %eax
	testl	%eax, %eax
	je	.L1668
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L1635
	movq	8(%r12), %r13
	movq	16(%r13), %rdi
	call	get_mangled_name
	cmpl	$3, (%r12)
	movq	%rax, %r15
	je	.L1669
	cmpl	$1, 24(%r13)
	movl	$1, %r9d
	jne	.L1640
	movq	56(%r13), %rdi
	movl	$1, %r11d
	testq	%rdi, %rdi
	je	.L1641
	cmpl	$1, (%rdi)
	je	.L1670
.L1641:
	call	edge_tail_words_top
	leaq	(%rax,%r11), %r9
	movl	$1, %eax
	testq	%r9, %r9
	cmove	%rax, %r9
.L1640:
	movl	4(%r13), %eax
	movq	%r15, %r8
	movl	$2, %esi
	movq	%rbp, %rdi
	leaq	.LC174(%rip), %rcx
	leaq	.LC178(%rip), %rdx
	testl	%eax, %eax
	leaq	.LC175(%rip), %rax
	cmove	%rax, %rcx
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	cmpl	$2, 24(%r13)
	jne	.L1635
	movq	56(%r13), %rdi
	xorl	%r11d, %r11d
	testq	%rdi, %rdi
	je	.L1643
	cmpl	$1, (%rdi)
	je	.L1671
.L1643:
	cmpq	$0, 32(%r13)
	movq	48(%r13), %rax
	je	.L1644
	cmpq	%rax, %r11
	movq	%r11, %rdx
	cmovb	%rax, %r11
	testq	%rax, %rax
	cmovle	%rdx, %r11
.L1644:
	call	edge_tail_words_top
	movq	%r15, %rcx
	movl	$2, %esi
	movq	%rbp, %rdi
	addq	%r11, %rax
	movl	$1, %r8d
	leaq	.LC179(%rip), %rdx
	cmovne	%rax, %r8
	xorl	%eax, %eax
	addq	$1, %rbx
	call	__fprintf_chk@PLT
	cmpq	8(%r14), %rbx
	jb	.L1646
.L1667:
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
.L1668:
	.cfi_restore_state
	movq	8(%r12), %rsi
	movq	8(%rsp), %r8
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbp, %rdi
	call	emit_stmt
	jmp	.L1635
	.p2align 4,,10
	.p2align 3
.L1669:
	movq	16(%r13), %rdi
	call	global_data_kind
	testl	%eax, %eax
	je	.L1635
	movl	8(%r13), %edx
	testl	%edx, %edx
	je	.L1639
	movq	16(%r13), %rcx
	subq	$8, %rsp
	.cfi_def_cfa_offset 88
	movq	%r15, %r9
	movq	%r15, %r8
	leaq	.LC176(%rip), %rdx
	movl	$2, %esi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	pushq	%rcx
	.cfi_def_cfa_offset 96
	pushq	%r15
	.cfi_def_cfa_offset 104
	pushq	%r15
	.cfi_def_cfa_offset 112
	call	__fprintf_chk@PLT
	addq	$32, %rsp
	.cfi_def_cfa_offset 80
	jmp	.L1635
	.p2align 4,,10
	.p2align 3
.L1670:
	movq	24(%rdi), %r11
	jmp	.L1641
	.p2align 4,,10
	.p2align 3
.L1639:
	movq	%r15, %rcx
	leaq	.LC177(%rip), %rdx
	movq	%rbp, %rdi
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	jmp	.L1635
.L1671:
	movq	24(%rdi), %r11
	jmp	.L1643
	.p2align 4,,10
	.p2align 3
.L1664:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.cfi_endproc
.LFE100:
	.size	emit_global_declarations, .-emit_global_declarations
	.section	.rodata.str1.1
.LC180:
	.string	"{\n    B_FRAME;\n"
	.section	.rodata.str1.8
	.align 8
.LC181:
	.string	"    size_t __bcc_count = __bcc_current_call ? __bcc_current_call->count : 0;\n"
	.align 8
.LC182:
	.string	"    if (__bcc_count < %zu) __bcc_count = %zu;\n"
	.align 8
.LC183:
	.string	"    word __bcc_parameters[__bcc_count];\n    for (size_t __bcc_i = 0; __bcc_i < __bcc_count; ++__bcc_i)\n        __bcc_parameters[__bcc_i] = __bcc_current_call && __bcc_i < __bcc_current_call->count\n            ? __bcc_current_call->arguments[__bcc_i] : 0;\n"
	.align 8
.LC184:
	.string	"    (void)B_LOCAL_PTR_N(__bcc_parameters, sizeof(__bcc_parameters));\n"
	.align 8
.LC185:
	.string	"    static int __bcc_labels_ready;\n"
	.align 8
.LC186:
	.string	"    static word __bcc_label_target_%zu;\n"
	.align 8
.LC187:
	.string	"    static word __b_label_value_%zu;\n"
	.align 8
.LC188:
	.string	"    if (!__bcc_labels_ready) {\n"
	.align 8
.LC189:
	.string	"        __bcc_label_target_%zu = __bcc_new_label();\n"
	.align 8
.LC190:
	.string	"        __b_label_value_%zu = __bcc_label_target_%zu;\n"
	.align 8
.LC191:
	.string	"        __bcc_labels_ready = 1;\n    }\n"
	.section	.rodata.str1.1
.LC192:
	.string	"    return 0;\n}\n"
	.text
	.p2align 4
	.type	emit_function_body, @function
emit_function_body:
.LFB96:
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
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdx, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movq	32(%rsi), %rdi
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	movq	$0, 8+function_labels(%rip)
	call	collect_function_labels
	movq	%rbx, %rcx
	movl	$15, %edx
	movl	$1, %esi
	leaq	.LC180(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%r13)
	jne	.L1690
.L1674:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L1691
.L1676:
	cmpq	$0, 8+function_labels(%rip)
	jne	.L1692
.L1680:
	movq	32(%r13), %rsi
	movq	%r12, %r8
	movl	$1, %ecx
	movq	%rbx, %rdi
	movl	$1, %edx
	call	emit_stmt
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC192(%rip), %rdi
	call	fwrite@PLT
	movq	$0, 8+function_labels(%rip)
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1693
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
.L1690:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$77, %edx
	movl	$1, %esi
	leaq	.LC181(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC182(%rip), %rdx
	movq	%rbx, %rdi
	movq	%rcx, %r8
	call	__fprintf_chk@PLT
	movq	%rbx, %rcx
	movl	$255, %edx
	movl	$1, %esi
	leaq	.LC183(%rip), %rdi
	call	fwrite@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L1674
	movq	%rbx, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC184(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1674
	.p2align 4,,10
	.p2align 3
.L1692:
	movq	%rbx, %rcx
	movl	$35, %edx
	movl	$1, %esi
	leaq	.LC185(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	je	.L1681
	xorl	%ebp, %ebp
	leaq	.LC186(%rip), %r15
	leaq	.LC187(%rip), %r14
	.p2align 4,,10
	.p2align 3
.L1682:
	addq	$1, %rbp
	movq	%r15, %rdx
	movl	$2, %esi
	movq	%rbx, %rdi
	movq	%rbp, %rcx
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	xorl	%eax, %eax
	movq	%rbp, %rcx
	movq	%r14, %rdx
	movl	$2, %esi
	movq	%rbx, %rdi
	call	__fprintf_chk@PLT
	cmpq	8+function_labels(%rip), %rbp
	jb	.L1682
.L1681:
	movq	%rbx, %rcx
	movl	$31, %edx
	movl	$1, %esi
	leaq	.LC188(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	je	.L1683
	xorl	%ebp, %ebp
	leaq	.LC189(%rip), %r15
	leaq	.LC190(%rip), %r14
	.p2align 4,,10
	.p2align 3
.L1684:
	addq	$1, %rbp
	movq	%r15, %rdx
	movl	$2, %esi
	movq	%rbx, %rdi
	movq	%rbp, %rcx
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	xorl	%eax, %eax
	movq	%rbp, %r8
	movq	%rbp, %rcx
	movq	%r14, %rdx
	movl	$2, %esi
	movq	%rbx, %rdi
	call	__fprintf_chk@PLT
	cmpq	8+function_labels(%rip), %rbp
	jb	.L1684
.L1683:
	movq	%rbx, %rcx
	movl	$38, %edx
	movl	$1, %esi
	leaq	.LC191(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1680
	.p2align 4,,10
	.p2align 3
.L1691:
	movq	32(%r13), %rdi
	pxor	%xmm0, %xmm0
	movq	%rsp, %rsi
	movq	$0, 16(%rsp)
	movaps	%xmm0, (%rsp)
	call	collect_function_autos
	cmpq	$0, 8(%rsp)
	je	.L1677
	xorl	%ebp, %ebp
	.p2align 4,,10
	.p2align 3
.L1678:
	movq	(%rsp), %rax
	movq	%r12, %rcx
	movl	$1, %edx
	movq	%rbx, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	emit_auto_storage
	cmpq	8(%rsp), %rbp
	jb	.L1678
.L1677:
	cmpq	$0, g_compilation_arena(%rip)
	jne	.L1676
	movq	(%rsp), %rdi
	call	free@PLT
	jmp	.L1676
.L1693:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE96:
	.size	emit_function_body, .-emit_function_body
	.section	.rodata.str1.1
.LC193:
	.string	"#define BCC_USE_CURSES 1\n"
	.section	.rodata.str1.8
	.align 8
.LC194:
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
.LC195:
	.string	"#define __bcc_strict_runtime %d\n"
	.section	.rodata.str1.1
.LC196:
	.string	"#define B_BYTEPTR %d\n"
.LC197:
	.string	"#define WORD_BITS %d\n"
	.section	.rodata.str1.8
	.align 8
.LC198:
	.ascii	"/*\n  Word size emulation:\n    WORD_BITS=0   -> wrap at the"
	.ascii	" host pointer width\n    WORD_BITS=16  -> wrap arithmetic li"
	.ascii	"ke PDP-11 16-bit words\n    WORD_BITS=32  -> wrap arithmetic"
	.ascii	" at 32 bits\n  WVAL(x) sign-extends to word width after mask"
	.ascii	"ing.\n*/\n#if WORD_BITS == 16\n  #define WORD_MASK 0xFFFFU\n"
	.ascii	"  #define WVAL(x) ((word)(int16_t)((x) & WORD_MASK))\n  #def"
	.ascii	"ine SHIFT_MASK 15\n#elif WORD_BITS == 32\n  #define WORD_MAS"
	.ascii	"K 0xFFFFFFFFU\n  #define WVAL(x) ((word)(int32_t)((x) & WORD"
	.ascii	"_MASK))\n  #define SHIFT_MASK 31\n#else\n  #define WORD_MASK"
	.ascii	" (~(uword)0)\n  #define WVAL(x) ((word)(x))\n  #define SHIFT"
	.ascii	"_MASK ((int)(sizeof(word)*8 - 1))\n#endif\n\n/*\n * Safe ari"
	.ascii	"thmetic macros - avoid host-C undefined behavior:\n *   - Al"
	.ascii	"l arithmetic done in unsigned to prevent signed overflow UB\n"
	.ascii	" *   - Shift counts masked to valid range to prevent shift >"
	.ascii	"= width UB\n *   - Results wrapped with WVAL() for proper wo"
	.ascii	"rd semantics\n */\n#define WADD(a,b) WVAL((uword)(a) + (uwor"
	.ascii	"d)(b))\n#define WSUB(a,b) WVAL((uword)(a) - (uword)(b))\n#de"
	.ascii	"fine WMUL(a,b) WVAL((uword)(a) * (uword)(b))\n#define WDIV(a"
	.ascii	",b) __b_word_div((a),(b))\n#define WMOD(a,b) __b_word_mod((a"
	.ascii	"),(b))\n#defi"
	.string	"ne WSHL(a,n) __b_word_shl((a),(n))\n#define WSHR(a,n) __b_word_shr((a),(n))\n#define WAND(a,b) WVAL((uword)(a) & (uword)(b))\n#define WOR(a,b)  WVAL((uword)(a) | (uword)(b))\n#define WXOR(a,b) WVAL((uword)(a) ^ (uword)(b))\n#define WNEG(a)   WVAL(-(uword)(a))\n\n"
	.section	.rodata.str1.1
.LC199:
	.string	"%s/btarget.h"
	.section	.rodata.str1.8
	.align 8
.LC200:
	.string	"#define B_TARGET_DEFINE\n#define B_TARGET_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC201:
	.string	"%s/binit.h"
	.section	.rodata.str1.8
	.align 8
.LC202:
	.string	"#define B_INIT_DEFINE\n#define B_INIT_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC203:
	.string	"%s/bcall.h"
	.section	.rodata.str1.8
	.align 8
.LC204:
	.string	"#define B_CALL_DEFINE\n#define B_CALL_STORAGE __attribute__((common))\n"
	.section	.rodata.str1.1
.LC205:
	.string	"%s/bunix.h"
	.section	.rodata.str1.8
	.align 8
.LC206:
	.ascii	"static void __b_init(void) {\n    if (!__bcc_runtime_initial"
	.ascii	"ized) {\n        setvbuf(stdout, NULL, _IONBF, 0);\n        "
	.ascii	"__bcc_runtime_initialized = 1;\n    }\n    __bcc_run_initial"
	.ascii	"izers();\n}\nint b_rd_fd __attribute__((weak)) = 0;\n#define"
	.ascii	" rd_fd b_rd_fd\nint b_wr_fd __attribute__((weak)) = 1;\n#def"
	.ascii	"ine wr_fd b_wr_fd\nword b_rd_unit __attribute__((weak)) = 0;"
	.ascii	"\n#define rd_unit b_rd_unit\nword b_wr_unit __attribute__((w"
	.ascii	"eak)) = (word)-1;\n#define wr_unit b_wr_unit\nstatic void __"
	.ascii	"b_sync_rd(void){\n    if (rd_unit < 0) {\n        if (rd_fd "
	.ascii	"!= 0 && rd_fd > 2) close(rd_fd);\n        rd_fd = 0;\n    } "
	.ascii	"else {\n        rd_fd = __bcc_unix_fd_valid(rd_unit) ? (int)"
	.ascii	"rd_unit : -1;\n    }\n}\nstatic void __b_sync_wr(void){\n   "
	.ascii	" if (wr_unit < 0) {\n        if (wr_fd != 1 && wr_fd > 2) cl"
	.ascii	"ose(wr_fd);\n        wr_fd = 1;\n    } else {\n        wr_fd"
	.ascii	" = __bcc_unix_fd_valid(wr_unit) ? (int)wr_unit : -1;\n    }\n"
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
	.ascii	"b_argv __attribute__(("
	.ascii	"common));\n\n/* argv strings converted to B strings (packed "
	.ascii	"words, 004 terminator) */\nword *__b_argvb __attribute__((co"
	.ascii	"mmon));\nword b_argv_vector __attribute__((common));\n\nstat"
	.ascii	"ic void __b_setargs(int argc, char **argv);\nstatic word b_a"
	.ascii	"rgc(void);\nstatic word b_argv(word i);\n\n/* Command line r"
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
	.ascii	"s){\n    nwords = WVAL(nwords);\n    if (nwords < 0 || (uwor"
	.ascii	"d)nwords > SIZE_MAX / sizeof(word)) {\n        fprintf(stder"
	.ascii	"r, \"alloc: invalid size\\n\"); exit(1);\n    }\n    size_t "
	.ascii	"bytes = nwords ? (size_t)nwords * sizeof(word) : sizeof(word"
	.ascii	");\n    void *p = malloc(bytes);\n    if (!p) { fprintf(stde"
	.ascii	"rr, \"alloc: out of memory\\n\"); exit(1); }\n    return B_P"
	.ascii	"TR_N(p, bytes);\n}\n\n/* Host B runtime functions and compat"
	.ascii	"ibility helpers */\n/* String manipulation functions */\nsta"
	.ascii	"tic inlin"
	.ascii	"e word b_load(word addr){ return B_DEREF(addr); }\nstatic in"
	.ascii	"line void b_store(word addr, word v){ B_DEREF(addr) = WVAL(v"
	.ascii	");\n}\n\n/* B string access - byte packing within words.\n *"
	.ascii	"\n * In B_BYTEPTR=0 mode, bytes are packed into words with b"
	.ascii	"yte 0 at the LSB.\n * This matches PDP-11 (little-endian) co"
	.ascii	"nventions. The shift-based approach\n * operates on word VAL"
	.ascii	"UES (not memory layout), making it consistent across\n * arc"
	.ascii	"hitectures: char(s,0) always returns the least-significant b"
	.ascii	"yte of the\n * word at address s, regardless of host endiann"
	.ascii	"ess.\n *\n * Note: This only works correctly when ALL byte a"
	.ascii	"ccess goes through char()/lchar().\n * Mixing direct memory "
	.ascii	"access (like C's *(char*)ptr) with B word operations will\n "
	.ascii	"* give different results on big-endian hosts.\n */\nstatic w"
	.ascii	"ord b_char(word s, word i){\n#if B_BYTEPTR && WORD_BITS != 1"
	.ascii	"6\n    const unsigned char *p = (const unsigned char*)B_CPTR"
	.ascii	"(s);\n    return (word)p[(size_t)i];\n#else\n    const uword"
	.ascii	" W = (uword)B_WORD_BYTES;\n    uword wi = (uword)i / W;\n   "
	.ascii	" uword bi = (uword)i % W;\n    uword w  = (uword)B_INDEX(s, "
	.ascii	"wi);\n    return (word)((w >> (bi * 8)) & 0xFF);\n#endif\n}\n"
	.ascii	"\nstatic word b_lchar(word s, word i, word c){\n#if B_BYTEPT"
	.ascii	"R && WORD_BITS != 16\n    unsigned char *p = (unsigned char*"
	.ascii	")B_CPTR(s);\n    p[(size_t)i] = (unsigned char)(c & 0xFF);\n"
	.ascii	"    return c;\n#else\n    const uword W = (uword)B_WORD_BYTE"
	.ascii	"S;\n    uword wi = (uword)i / W;\n    uword bi = (uword)i % "
	.ascii	"W;\n\n    word addr = B_ADDR(B_INDEX(s, wi));\n    uword w  "
	.ascii	" = (uword)b_load(addr);\n\n    uword mask = (uword)0xFF << ("
	.ascii	"bi * 8);\n    w = (w & ~mask) | (((uword)c & 0xFF) << (bi * "
	.ascii	"8));\n\n#if WORD_BITS == 32\n    B_DEREF(addr) = (word)w;\n#"
	.ascii	"else\n    b_store(addr, (word)w);\n#endif\n    return c;\n#e"
	.ascii	"ndif\n}\n\n/* Command line argument support implementation *"
	.ascii	"/\nstatic word __b_pack_cstr(const char *s){\n    size_t n ="
	.ascii	" strlen(s);                 /* bytes, excluding NUL */\n    "
	.ascii	"size_t W = B_WORD_BYTES;              /* bytes per word */\n"
	.ascii	"    size_t total = n + 1;                 /* +1 for 004 term"
	.ascii	"inator */\n    siz"
	.ascii	"e_t words = (total + W - 1) / W;\n\n    word bp = b_alloc((w"
	.ascii	"ord)words);       /* B pointer to word storage */\n\n    /* "
	.ascii	"write bytes into the B string using lchar (handles packing f"
	.ascii	"or B_BYTEPTR=0) */\n    for (size_t i = 0; i < n; i++){\n   "
	.ascii	"     b_lchar(bp, (word)i, (word)(unsigned char)s[i]);\n    }"
	.ascii	"\n    b_lchar(bp, (word)n, (word)004);\n    return bp;\n}\n\n"
	.ascii	"static void __b_bstr_to_cstr(word s, char *buf, size_t max){"
	.ascii	"\n    size_t i = 0;\n    while (i + 1 < max) {\n        word"
	.ascii	" ch = b_char(s, (word)i);\n        if (ch == 004 || ch == 0)"
	.ascii	" break;\n        buf[i++] = (char)(ch & 0xFF);\n    }\n    b"
	.ascii	"uf[i] = 0;\n}\n\n/* Convert a B string (004-terminated) into"
	.ascii	" a temporary NUL-terminated C string */\nstatic const char *"
	.ascii	"__b_cstr(word s){\n    static char *slots[4];\n    static si"
	.ascii	"ze_t caps[4];\n    static int next = 0;\n\n    if (s == 0) r"
	.ascii	"eturn \"\";\n\n    size_t len = 0;\n    for (;; len++) {\n  "
	.ascii	"      word ch = b_char(s, (word)len);\n        if (ch == 004"
	.ascii	" || ch == 0) break;\n    }\n\n    int idx = next;\n    next "
	.ascii	"= (next + 1) & 3; /* simple ring buffer to survive multiple "
	.ascii	"args */\n\n    size_t need = len + 1;\n    if (need > caps[i"
	.ascii	"dx]) {\n        size_t ncap = need < 64 ? 64 : need;\n      "
	.ascii	"  char *nb = (char*)realloc(slots[idx], ncap);\n        if ("
	.ascii	"!nb) { fprintf(stderr, \"cstr: out of memory\\n\"); exit(1);"
	.ascii	" }\n        slots[idx] = nb;\n        caps[idx] = ncap;\n   "
	.ascii	" }\n\n    for (size_t i = 0; i < len; i++) slots[idx][i] = ("
	.ascii	"char)(b_char(s, (word)i) & 0xFF);\n    slots[idx][len] = 0;\n"
	.ascii	"    return slots[idx];\n}\n\n/* Duplicate a B string into a "
	.ascii	"freshly allocated C string */\nstatic char *__b_dup_bstr(wor"
	.ascii	"d s){\n    size_t cap = 64;\n    char *buf = (char*)malloc(c"
	.ascii	"ap);\n    if (!buf) { fprintf(stderr, \"system: out of memor"
	.ascii	"y\\n\"); exit(1); }\n\n    size_t i = 0;\n    for (;;) {\n  "
	.ascii	"      word ch = b_char(s, (word)i);\n        if (ch == 004 |"
	.ascii	"| ch == 0) break;\n        if (i + 1 >= cap) {\n            "
	.ascii	"size_t ncap = cap * 2;\n            char *nbuf = (char*)real"
	.ascii	"loc(buf, ncap);\n            if (!nbuf) { free(buf); fprintf"
	.ascii	"(stderr, \"system: out of memory\\"
	.ascii	"n\"); exit(1); }\n            buf = nbuf;\n            cap ="
	.ascii	" ncap;\n        }\n        buf[i++] = (char)(ch & 0xFF);\n  "
	.ascii	"  }\n    buf[i] = 0;\n    return buf;\n}\n\nstatic void __b_"
	.ascii	"setargs(int argc, char **argv){\n    __b_argc = argc;\n    _"
	.ascii	"_b_argv = argv;\n\n    __b_argvb = (word*)malloc(sizeof(word"
	.ascii	") * ((size_t)argc + 1));\n    if (!__b_argvb) { fprintf(stde"
	.ascii	"rr, \"argv: out of memory\\n\"); exit(1); }\n\n    word *vec"
	.ascii	"tor = (word*)malloc(sizeof(word) * ((size_t)argc + 1));\n   "
	.ascii	" if (!vector) { fprintf(stderr, \"argv: out of memory\\n\");"
	.ascii	" exit(1); }\n    vector[0] = WVAL(argc);\n    for (int i = 0"
	.ascii	"; i < argc; i++){\n        __b_argvb[i] = __b_pack_cstr(argv"
	.ascii	"[i]);\n        vector[i+1] = __b_pack_cstr(argv[i]);\n      "
	.ascii	"  b_lchar(vector[i+1], (word)strlen(argv[i]), 0);\n    }\n  "
	.ascii	"  b_argv_vector = B_PTR_N(vector, sizeof(word) * ((size_t)ar"
	.ascii	"gc + 1));\n}\nstatic word __b_argvalues(void) {\n    return "
	.ascii	"__b_argc ? B_PTR_N(__b_argvb, sizeof(word) * (size_t)__b_arg"
	.ascii	"c) : 0;\n}\n\nstatic word b_argc(void) { return (word)__b_ar"
	.ascii	"gc; }\n\nstatic word b_argv(word i) {\n    if (i < 0 || i >="
	.ascii	" __b_argc) return 0;\n    return __b_argvb[i];\n}\n\nstatic "
	.ascii	"word b_reread(void) {\n    if (__b_argc <= 1) return 0;\n\n "
	.ascii	"   /* A pipe can block before its reader starts. Stage the r"
	.ascii	"eplay in an\n       anonymous seekable file instead, preserv"
	.ascii	"ing empty argument fields. */\n    FILE *stream = tmpfile();"
	.ascii	"\n    if (!stream) {\n        fprintf(stderr, \"reread: cann"
	.ascii	"ot create replay file\\n\");\n        exit(1);\n    }\n    f"
	.ascii	"or (int i = 0; i < __b_argc; ++i) {\n        size_t length ="
	.ascii	" strlen(__b_argv[i]);\n        if (fwrite(__b_argv[i], 1, le"
	.ascii	"ngth, stream) != length ||\n            fputc(i + 1 < __b_ar"
	.ascii	"gc ? ' ' : '\\n', stream) == EOF)\n            goto failed;\n"
	.ascii	"    }\n    if (fflush(stream) != 0 || fseek(stream, 0, SEEK_"
	.ascii	"SET) != 0) goto failed;\n    int descriptor = dup(fileno(str"
	.ascii	"eam));\n    if (descriptor < 0) goto failed;\n    fclose(str"
	.ascii	"eam);\n    __b_sync_rd();\n    if (rd_fd != 0) close(rd_fd);"
	.ascii	"\n    rd_fd = descriptor;\n    rd_unit = (word)descriptor;\n"
	.ascii	"    return 0;\n\nfailed:\n    fclos"
	.ascii	"e(stream);\n    fprintf(stderr, \"reread: cannot stage comma"
	.ascii	"nd line\\n\");\n    exit(1);\n}\n\n/* I/O functions */\nstat"
	.ascii	"ic word b_getchr(void) {\n    __b_sync_rd();\n    unsigned c"
	.ascii	"har c;\n    ssize_t n = read(rd_fd, &c, 1);\n    if (n == 1)"
	.ascii	" return (word)c;\n    if (rd_fd != 0) {\n        close(rd_fd"
	.ascii	");\n        rd_fd = 0;\n        rd_unit = -1;\n        retur"
	.ascii	"n b_getchr();\n    }\n    return (word)004; /* Return *e on "
	.ascii	"EOF */\n}\nstatic word b_putchr(word w) {\n    __b_sync_wr()"
	.ascii	";\n    unsigned char c = (unsigned char)(w & 0xFF);\n    (vo"
	.ascii	"id)write(wr_fd, &c, 1);\n    return w;\n}\nstatic word b_put"
	.ascii	"str(word s) {\n    __b_sync_wr();\n    word i = 0;\n    for "
	.ascii	"(;;) {\n        word ch = __bcc_library_call2(\"char\", b_ch"
	.ascii	"ar, s, i++);\n        if (ch == 004 || (!__bcc_strict_runtim"
	.ascii	"e && ch == 0)) break;\n        __bcc_library_call1(\"putchar"
	.ascii	"\", b_putchar, ch);\n    }\n    return s;\n}\nstatic word b_"
	.ascii	"getstr(word buf) {\n    word i = 0;\n    for (;;) {\n       "
	.ascii	" word c = __bcc_library_call0(\"getchar\", b_getchar);\n    "
	.ascii	"    if (c == 004 || c == '\\n' || (!__bcc_strict_runtime && "
	.ascii	"c == '\\r')) break;\n        __bcc_library_call3(\"lchar\", "
	.ascii	"b_lchar, buf, i++, c);\n    }\n    __bcc_librar"
	.string	"y_call3(\"lchar\", b_lchar, buf, i, 004);\n    return __bcc_strict_runtime ? i : buf;\n}\nstatic word b_flush(void){\n    __b_sync_wr();\n    if (wr_fd == 1) {\n        fflush(stdout);\n    } else {\n        fsync(wr_fd);\n    }\n    return 0;\n}\n\n#include <stdarg.h>\n\n"
	.section	.rodata.str1.1
.LC207:
	.string	"%s/bformat.h"
	.section	.rodata.str1.8
	.align 8
.LC208:
	.string	"#define __bcc_format_linkage static\n"
	.align 8
.LC209:
	.ascii	"/* File I/O functions - with actual implementations */\n#inc"
	.ascii	"lude <fcntl.h>\nstatic word b_open(word name, word mode){\n "
	.ascii	"   const char *p = __b_cstr(name);\n    int flags = (mode =="
	.ascii	" 0) ? O_RDONLY : O_WRONLY;\n    return (word)open(p, flags);"
	.ascii	"\n}\nstatic word b_openr(word fd, word name){\n    return __"
	.ascii	"bcc_unix_redirect(fd, fd < 0 ? \"\" : __b_cstr(name), O_RDON"
	.ascii	"LY,\n                               0, &rd_fd, &rd_unit);\n}"
	.ascii	"\nstatic word b_openw(word fd, word name){\n    return __bcc"
	.ascii	"_unix_redirect(fd, fd < 0 ? \"\" : __b_cstr(name),\n        "
	.ascii	"                       O_WRONLY | O_CREAT | O_TRUNC, 1, &wr_"
	.ascii	"fd, &wr_unit);\n}\nstatic word b_close(word fd) {\n    if (!"
	.ascii	"__bcc_unix_fd_valid(fd)) return -1;\n    int cfd = (int)fd;\n"
	.ascii	"    word r = (word)close(cfd);\n    if (r == 0) {\n        i"
	.ascii	"f (cfd == rd_fd || cfd == rd_unit) { rd_fd = 0; rd_unit = -1"
	.ascii	"; }\n        if (cfd == wr_fd || cfd == wr_unit) { wr_fd = 1"
	.ascii	"; wr_unit = -1; }\n    }\n    return r;\n}\nstatic word b_re"
	.ascii	"ad(word fd, word buf, word n) {\n    if (!__bcc_unix_fd_vali"
	.ascii	"d(fd)) return -1;\n    if (n < 0) { errno = EINVAL; return -"
	.ascii	"1; }\n    if (n && !buf) { errno = EFAULT; return -1; }\n#if"
	.ascii	" WORD_BITS == 16\n    unsigned char *bytes = malloc(n ? (siz"
	.ascii	"e_t)n : 1);\n    if (!bytes) return -1;\n    ssize_t count ="
	.ascii	" read((int)fd, bytes, (size_t)n);\n    for (ssize_t i = 0; i"
	.ascii	" < count; i++) b_lchar(buf, (word)i, bytes[i]);\n    free(by"
	.ascii	"tes);\n    return WVAL(count);\n#else\n    char *p = (char*)"
	.ascii	"B_CPTR(buf);\n    return (word)read((int)fd, p, (size_t)n);\n"
	.ascii	"#endif\n}\nstatic word b_write(word fd, word buf, word n) {\n"
	.ascii	"    if (!__bcc_unix_fd_valid(fd)) return -1;\n    if (n < 0)"
	.ascii	" { errno = EINVAL; return -1; }\n    if (n && !buf) { errno "
	.ascii	"= EFAULT; return -1; }\n#if WORD_BITS == 16\n    unsigned ch"
	.ascii	"ar *bytes = malloc(n ? (size_t)n : 1);\n    if (!bytes) retu"
	.ascii	"rn -1;\n    for (word i = 0; i < n; i++) bytes[i] = (unsigne"
	.ascii	"d char)b_char(buf, i);\n    ssize_t count = write((int)fd, b"
	.ascii	"ytes, (size_t)n);\n    free(bytes);\n    return WVAL(count);"
	.ascii	"\n#else\n    return (word)write((int)fd, B_CPTR(buf), (size_"
	.ascii	"t)n);\n#endif\n}"
	.ascii	"\nstatic word b_creat(word name, word mode) {\n    const cha"
	.ascii	"r *p = __b_cstr(name);\n    return (word)creat(p, __bcc_unix"
	.ascii	"_mode(mode, 0));\n}\nstatic word b_seek(word fd, word offset"
	.ascii	", word whence) {\n    return __bcc_unix_seek(fd, offset, whe"
	.ascii	"nce);\n}\n\n/* Process control functions - with actual imple"
	.ascii	"mentations */\nstatic word b_fork(void) {\n    return (word)"
	.ascii	"fork();\n}\nstatic word __b_wait_status;\n\nstatic word b_wa"
	.ascii	"it(void) {\n    int st = 0;\n    pid_t pid = wait(&st);\n   "
	.ascii	" __b_wait_status = (word)st;\n    return (word)pid;\n}\n/* B"
	.ascii	"72 section 8 passes exactly count argument strings, includin"
	.ascii	"g arg0. */\nstatic word b_execv(word path, word argv, word c"
	.ascii	"ount) {\n    if (count < 0 || count > 255 || (count && !argv"
	.ascii	")) return -1;\n    char *name = __b_dup_bstr(path);\n    if "
	.ascii	"(!name) return -1;\n    char *arguments[256];\n    word *val"
	.ascii	"ues = count ? (word*)B_CPTR(argv) : NULL;\n    size_t n = (s"
	.ascii	"ize_t)count, i = 0;\n    for (; i < n; i++) {\n        if (!"
	.ascii	"values[i]) break;\n        arguments[i] = __b_dup_bstr(value"
	.ascii	"s[i]);\n        if (!arguments[i]) break;\n    }\n    if (i "
	.ascii	"== n) {\n        arguments[n] = NULL;\n        execv(name, a"
	.ascii	"rguments);\n    }\n    while (i) free(arguments[--i]);\n    "
	.ascii	"free(name);\n    return -1;\n}\n\nstatic word b_execl(word p"
	.ascii	"ath, ...) {\n    char *name = __b_dup_bstr(path);\n    if (!"
	.ascii	"name) return -1;\n    char *arguments[256];\n    size_t n = "
	.ascii	"0;\n    int complete = 0;\n    va_list ap;\n    va_start(ap,"
	.ascii	" path);\n    while (n < 255) {\n        word value = va_arg("
	.ascii	"ap, word);\n        if (!value) { complete = 1; break; }\n  "
	.ascii	"      arguments[n] = __b_dup_bstr(value);\n        if (!argu"
	.ascii	"ments[n]) break;\n        n++;\n    }\n    va_end(ap);\n    "
	.ascii	"if (complete) {\n        arguments[n] = NULL;\n        execv"
	.ascii	"(name, arguments);\n    }\n    while (n) free(arguments[--n]"
	.ascii	");\n    free(name);\n    return -1;\n}\n\nstatic word b_syst"
	.ascii	"em(word cmd) {\n    /* Split arguments without invoking a sh"
	.ascii	"ell or expanding their contents. */\n    char *line = __b_du"
	.ascii	"p_bstr(cmd);\n    if (!line) return -1;\n    char *argv[128]"
	.ascii	";\n    size_t argc = 0;\n    char "
	.ascii	"*p = line, *q = line;\n    while (*p) {\n        while (*p &"
	.ascii	"& isspace((unsigned char)*p)) p++;\n        if (!*p) break;\n"
	.ascii	"        if (argc + 1 >= sizeof(argv)/sizeof(argv[0])) { free"
	.ascii	"(line); return -1; }\n        argv[argc++] = q;\n        int"
	.ascii	" quote = 0;\n        while (*p && (quote || !isspace((unsign"
	.ascii	"ed char)*p))) {\n            unsigned char c = (unsigned cha"
	.ascii	"r)*p++;\n            if (c == '\\\\' && quote != '\\'') {\n "
	.ascii	"               if (!*p) { free(line); return -1; }\n        "
	.ascii	"        *q++ = *p++;\n            } else if (c == '\\'' || c"
	.ascii	" == '\"') {\n                if (!quote) quote = c;\n       "
	.ascii	"         else if (quote == c) quote = 0;\n                el"
	.ascii	"se *q++ = (char)c;\n            } else *q++ = (char)c;\n    "
	.ascii	"    }\n        if (quote) { free(line); return -1; }\n      "
	.ascii	"  if (*p) p++;\n        *q++ = 0;\n    }\n    if (argc == 0)"
	.ascii	" { free(line); return -1; }\n    argv[argc] = NULL;\n    pid"
	.ascii	"_t pid = fork();\n    if (pid == 0) {\n        execvp(argv[0"
	.ascii	"], argv);\n        _exit(127);\n    }\n    if (pid < 0) { fr"
	.ascii	"ee(line); return -1; }\n    int st = 0;\n    pid_t w;\n    d"
	.ascii	"o { w = waitpid(pid, &st, 0); } while (w < 0 && errno == EIN"
	.ascii	"TR);\n    free(line);\n    if (w < 0) return -1;\n    return"
	.ascii	" (word)st;\n}\n\nstatic word b_usleep(word usec) {\n    usle"
	.ascii	"ep((useconds_t)usec);\n    return 0;\n}\n\nstatic word b_cal"
	.ascii	"lf_dispatch(int nargs, word name, ...) {\n    static int __b"
	.ascii	"_callf_dl_done = 0;\n    if (!__b_callf_dl_done) {\n        "
	.ascii	"__b_callf_dl_done = 1;\n        const char *env = getenv(\"B"
	.ascii	"_CALLF_LIB\");\n        if (env && *env) {\n            cons"
	.ascii	"t char *p = env;\n            while (*p) {\n                "
	.ascii	"const char *start = p;\n                while (*p && *p != '"
	.ascii	":') p++;\n                size_t len = (size_t)(p - start);\n"
	.ascii	"                if (len) {\n                    char *path ="
	.ascii	" (char*)malloc(len + 1);\n                    if (path) {\n "
	.ascii	"                       memcpy(path, start, len);\n          "
	.ascii	"              path[len] = '\\0';\n                        (v"
	.ascii	"oid)dlopen(path, RTLD_NOW | RTLD_GLOBAL);\n                 "
	.ascii	"       free(path);\n       "
	.ascii	"             }\n                }\n                if (*p =="
	.ascii	" ':') p++;\n            }\n        }\n    }\n    if (nargs <"
	.ascii	" 0 || nargs > 10) return -1;\n    if (name == 0) return -1;\n"
	.ascii	" \n    char sym[256];\n    __b_bstr_to_cstr(name, sym, sizeo"
	.ascii	"f(sym));\n \n    void *fn = dlsym(RTLD_DEFAULT, sym);\n    i"
	.ascii	"f (!fn) {\n        size_t len = strlen(sym);\n        if (le"
	.ascii	"n + 2 < sizeof(sym)) {\n            sym[len] = '_'; sym[len "
	.ascii	"+ 1] = '\\0';\n            fn = dlsym(RTLD_DEFAULT, sym);\n "
	.ascii	"           sym[len] = '\\0';\n        }\n    }\n    if (!fn)"
	.ascii	" return -1;\n \n    void *args[10] = {0};\n    va_list ap;\n"
	.ascii	"    va_start(ap, name);\n    for (int i = 0; i < nargs && i "
	.ascii	"< 10; i++) {\n        word w = va_arg(ap, word);\n        ar"
	.ascii	"gs[i] = B_CPTR(w);\n    }\n    va_end(ap);\n \n    word r = "
	.ascii	"0;\n    switch (nargs) {\n    case 0: r = ((word (*)(void))f"
	.ascii	"n)(); break;\n    case 1: r = ((word (*)(void*))fn)(args[0])"
	.ascii	"; break;\n    case 2: r = ((word (*)(void*, void*))fn)(args["
	.ascii	"0], args[1]); break;\n    case 3: r = ((word (*)(void*, void"
	.ascii	"*, void*))fn)(args[0], args[1], args[2]); break;\n    case 4"
	.ascii	": r = ((word (*)(void*, void*, void*, void*))fn)(args[0], ar"
	.ascii	"gs[1], args[2], args[3]); break;\n    case 5: r = ((word (*)"
	.ascii	"(void*, void*, void*, void*, void*))fn)(args[0], args[1], ar"
	.ascii	"gs[2], args[3], args[4]); break;\n    case 6: r = ((word (*)"
	.ascii	"(void*, void*, void*, void*, void*, void*))fn)(args[0], args"
	.ascii	"[1], args[2], args[3], args[4], args[5]); break;\n    case 7"
	.ascii	": r = ((word (*)(void*, void*, void*, void*, void*, void*, v"
	.ascii	"oid*))fn)(args[0], args[1], args[2], args[3], args[4], args["
	.ascii	"5], args[6]); break;\n    case 8: r = ((word (*)(void*, void"
	.ascii	"*, void*, void*, void*, void*, void*, void*))fn)(args[0], ar"
	.ascii	"gs[1], args[2], args[3], args[4], args[5], args[6], args[7])"
	.ascii	"; break;\n    case 9: r = ((word (*)(void*, void*, void*, vo"
	.ascii	"id*, void*, void*, void*, void*, void*))fn)(args[0], args[1]"
	.ascii	", args[2], args[3], args[4], args[5], args[6], args[7], args"
	.ascii	"[8]); break;\n    case 10: r = ((word (*)(void*, void*, void"
	.ascii	"*, void*, void*, void*, void*, void*, void*, void*))fn)(args"
	.ascii	"[0], "
	.ascii	"args[1], args[2], args[3], args[4], args[5], args[6], args[7"
	.ascii	"], args[8], args[9]); break;\n    default: return -1;\n    }"
	.ascii	"\n    return r;\n}\n\n/* System functions - with actual impl"
	.ascii	"ementations where possible */\n/* Unix V1 counts 60 Hz ticks"
	.ascii	" since 1971, high word first (time(II)). */\nstatic word b_t"
	.ascii	"ime(word tvp) {\n    struct timespec now;\n    if (clock_get"
	.ascii	"time(CLOCK_REALTIME, &now) != 0) return -1;\n    if (tvp) {\n"
	.ascii	"        uint64_t elapsed = (uint64_t)now.tv_sec - UINT64_C(3"
	.ascii	"1536000);\n        uint32_t ticks = (uint32_t)(elapsed * 60 "
	.ascii	"+ (uint64_t)now.tv_nsec * 60 / 1000000000);\n        word *t"
	.ascii	"v = (word*)B_CPTR(tvp);\n        tv[0] = WVAL(ticks >> 16);\n"
	.ascii	"        tv[1] = WVAL(ticks & 65535);\n    }\n    return 0;\n"
	.ascii	"}\n\n/* B72 section 8 specifies a caller-owned, 16-byte date"
	.ascii	" buffer. */\nstatic word b_ctime(word tvp, word date) {\n   "
	.ascii	" if (!tvp || !date) return -1;\n    word *tv = (word*)B_CPTR"
	.ascii	"(tvp);\n    uint32_t ticks = ((uint32_t)(uint16_t)tv[0] << 1"
	.ascii	"6) | (uint16_t)tv[1];\n    unsigned days = ticks / 5184000U;"
	.ascii	"\n    unsigned seconds = ticks / 60U % 86400U;\n    unsigned"
	.ascii	" year = 1971, month = 0;\n    while (days >= (year % 4 == 0 "
	.ascii	"? 366U : 365U)) {\n        days -= year % 4 == 0 ? 366U : 36"
	.ascii	"5U;\n        year++;\n    }\n    static const unsigned lengt"
	.ascii	"hs[] = {31,28,31,30,31,30,31,31,30,31,30,31};\n    static co"
	.ascii	"nst char *months[] = {\"Jan\",\"Feb\",\"Mar\",\"Apr\",\"May\""
	.ascii	",\"Jun\",\"Jul\",\"Aug\",\"Sep\",\"Oct\",\"Nov\",\"Dec\"};\n"
	.ascii	"    for (;;) {\n        unsigned length = lengths[month] + ("
	.ascii	"month == 1 && year % 4 == 0);\n        if (days < length) br"
	.ascii	"eak;\n        days -= length;\n        month++;\n    }\n    "
	.ascii	"char text[16];\n    snprintf(text, sizeof(text), \"%s %2u %0"
	.ascii	"2u:%02u:%02u\", months[month], days + 1,\n             secon"
	.ascii	"ds / 3600, seconds / 60 % 60, seconds % 60);\n    for (size_"
	.ascii	"t i = 0; i < sizeof(text); i++) b_lchar(date, (word)i, (word"
	.ascii	")(unsigned char)text[i]);\n    return 0;\n}\n\nstatic word b"
	.ascii	"_getuid(void) {\n    return (word)getuid();\n}\nstatic word "
	.ascii	"b_chdir(word path) {\n    const char *p = __b_cstr(path);\n "
	.ascii	"   return (word)chdir(p);\n}\nstatic w"
	.ascii	"ord b_unlink(word path) {\n    const char *p = __b_cstr(path"
	.ascii	");\n    return (word)unlink(p);\n}\n\n/* System functions wi"
	.ascii	"th actual implementations */\nstatic word b_chmod(word path,"
	.ascii	" word mode) {\n    const char *p = __b_cstr(path);\n    retu"
	.ascii	"rn (word)chmod(p, __bcc_unix_mode(mode, 0));\n}\nstatic word"
	.ascii	" b_chown(word path, word owner) {\n    const char *p = __b_c"
	.ascii	"str(path);\n    return (word)chown(p, (uid_t)owner, (gid_t)-"
	.ascii	"1);\n}\nstatic word b_link(word old, word new) {\n    const "
	.ascii	"char *o = __b_cstr(old);\n    const char *n = __b_cstr(new);"
	.ascii	"\n    return (word)link(o, n);\n}\nstatic word b_stat(word p"
	.ascii	"ath, word bufp) {\n    if (!bufp) { errno = EFAULT; return -"
	.ascii	"1; }\n    const char *p = __b_cstr(path);\n    struct stat s"
	.ascii	"t;\n    if (stat(p, &st) != 0) return -1;\n    __bcc_unix_st"
	.ascii	"at((word*)B_CPTR(bufp), &st);\n    return 0;\n}\n\nstatic wo"
	.ascii	"rd b_fstat(word fd, word bufp) {\n    if (!__bcc_unix_fd_val"
	.ascii	"id(fd)) return -1;\n    if (!bufp) { errno = EFAULT; return "
	.ascii	"-1; }\n    struct stat st;\n    if (fstat((int)fd, &st) != 0"
	.ascii	") return -1;\n    __bcc_unix_stat((word*)B_CPTR(bufp), &st);"
	.ascii	"\n    return 0;\n}\n\nstatic word b_setuid(word uid) {\n    "
	.ascii	"return (word)setuid((uid_t)uid);\n}\nstatic word b_makdir(wo"
	.ascii	"rd path, word mode) {\n    const char *p = __b_cstr(path);\n"
	.ascii	"    return (word)mkdir(p, __bcc_unix_mode(mode, 1));\n}\n\ns"
	.ascii	"tatic word b_mkdir(word path, word mode) { return b_makdir(p"
	.ascii	"ath, mode); }\nstatic word b_putnum(word n) {\n    __bcc_lib"
	.ascii	"rary_call2(\"printn\", b_printn, n, (word)10);\n    return n"
	.ascii	";\n}\nstatic word b_gtty(word fd, word ttstat){\n    if (!__"
	.ascii	"bcc_unix_fd_valid(fd)) return -1;\n    if (!ttstat) { errno "
	.ascii	"= EFAULT; return -1; }\n    struct termios t;\n    if (tcget"
	.ascii	"attr((int)fd, &t) < 0) return -1;\n\n    word *vec = (word*)"
	.ascii	"B_CPTR(ttstat);\n    vec[0] = (word)t.c_iflag;\n    vec[1] ="
	.ascii	" (word)t.c_oflag;\n    vec[2] = (word)t.c_lflag;\n    return"
	.ascii	" 0;\n}\n\nstatic word b_stty(word fd, word ttstat){\n    if "
	.ascii	"(!__bcc_unix_fd_valid(fd)) return -1;\n    if (!ttstat) { er"
	.ascii	"rno = EFAULT; return -1; }\n    struct termios t;\n    if (t"
	.ascii	"cgetattr((int)fd, &t) < 0) re"
	.ascii	"turn -1;\n\n    word *vec = (word*)B_CPTR(ttstat);\n    t.c_"
	.ascii	"iflag = (tcflag_t)vec[0];\n    t.c_oflag = (tcflag_t)vec[1];"
	.ascii	"\n    t.c_lflag = (tcflag_t)vec[2];\n    return (word)tcse"
	.string	"tattr((int)fd, TCSANOW, &t);\n}\nstatic word b_intr(word mode) {\n    if (mode != 0 && mode != 1) { errno = ENOSYS; return -1; }\n    if (signal(SIGINT, mode == 0 ? SIG_IGN : SIG_DFL) == SIG_ERR) return -1;\n    return 0;\n}\n\n/* Builtin aliases for B source */\n\n"
	.section	.rodata.str1.1
.LC210:
	.string	"%s/bprimitives.h"
	.section	.rodata.str1.8
	.align 8
.LC211:
	.string	"#define B_BUILTIN_STORAGE __attribute__((weak))\n"
	.section	.rodata.str1.1
.LC212:
	.string	"word __b_user_main("
.LC213:
	.string	"void)\n"
	.section	.rodata.str1.8
	.align 8
.LC214:
	.string	"int main(int argc, char **argv){\n"
	.section	.rodata.str1.1
.LC215:
	.string	"    __b_setargs(argc, argv);\n"
.LC216:
	.string	"    __b_init();\n"
	.section	.rodata.str1.8
	.align 8
.LC217:
	.string	"    return (int)__bcc_call%zu("
	.section	.rodata.str1.1
.LC218:
	.string	", (word)argc"
.LC219:
	.string	", __b_argvalues()"
	.text
	.p2align 4
	.globl	emit_program_c
	.type	emit_program_c, @function
emit_program_c:
.LFB102:
	.cfi_startproc
	endbr64
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
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	movq	%rsi, %rdi
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movq	%rdx, 8(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	movaps	%xmm0, external_calls(%rip)
	pxor	%xmm0, %xmm0
	movq	%rsi, current_program(%rip)
	movl	%ecx, current_byteptr(%rip)
	movl	%r9d, current_word_bits(%rip)
	movq	$0, 16+external_calls(%rip)
	movq	$0, string_pool(%rip)
	movq	$0, 8+name_map(%rip)
	movups	%xmm0, 8+string_pool(%rip)
	call	collect_strings_program
	movl	g_use_curses(%rip), %edx
	testl	%edx, %edx
	jne	.L1720
.L1695:
	movq	%rbx, %rcx
	movl	$1529, %edx
	movl	$1, %esi
	leaq	.LC194(%rip), %rdi
	call	fwrite@PLT
	movl	g_strict(%rip), %eax
	xorl	%ecx, %ecx
	movq	%rbx, %rdi
	leaq	.LC195(%rip), %rdx
	movl	$2, %esi
	testl	%eax, %eax
	setne	%cl
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	xorl	%ecx, %ecx
	testl	%r13d, %r13d
	movl	$2, %esi
	setne	%cl
	leaq	.LC196(%rip), %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movl	%r12d, %ecx
	movl	$2, %esi
	movq	%rbx, %rdi
	leaq	.LC197(%rip), %rdx
	xorl	%eax, %eax
	leaq	16(%rsp), %r12
	call	__fprintf_chk@PLT
	movq	%rbx, %rcx
	movl	$1378, %edx
	movl	$1, %esi
	leaq	.LC198(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC199(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$73, %edx
	movl	$1, %esi
	leaq	.LC200(%rip), %rdi
	movq	%rax, %r13
	call	fwrite@PLT
	movq	16(%rsp), %rdx
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
	leaq	.LC201(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC202(%rip), %rdi
	movq	%rax, %r13
	call	fwrite@PLT
	movq	16(%rsp), %rdx
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
	leaq	.LC203(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	movq	%rax, %r14
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC204(%rip), %rdi
	movq	%rax, %r13
	call	fwrite@PLT
	movq	16(%rsp), %rdx
	movq	%rbx, %rcx
	movq	%r13, %rdi
	movl	$1, %esi
	call	fwrite@PLT
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	movq	%r13, %rdi
	call	free@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L1721
.L1696:
	movq	g_libb_path(%rip), %rsi
	leaq	.LC205(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	16(%rsp), %rdx
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
	movl	$11388, %edx
	movl	$1, %esi
	leaq	.LC206(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC207(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$36, %edx
	movl	$1, %esi
	leaq	.LC208(%rip), %rdi
	movq	%rax, %r13
	call	fwrite@PLT
	movq	16(%rsp), %rdx
	movq	%rbx, %rcx
	movq	%r13, %rdi
	movl	$1, %esi
	call	fwrite@PLT
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	movq	%r13, %rdi
	call	free@PLT
	movq	%rbx, %rcx
	movl	$12428, %edx
	movl	$1, %esi
	leaq	.LC209(%rip), %rdi
	call	fwrite@PLT
	movq	g_libb_path(%rip), %rsi
	leaq	.LC210(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	movq	%rax, %r13
	call	read_file_all@PLT
	movq	%rbx, %rcx
	movl	$48, %edx
	movl	$1, %esi
	leaq	.LC211(%rip), %rdi
	movq	%rax, %r12
	call	fwrite@PLT
	movq	16(%rsp), %rdx
	movq	%rbx, %rcx
	movq	%r12, %rdi
	movl	$1, %esi
	call	fwrite@PLT
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	movq	%r12, %rdi
	call	free@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L1722
.L1697:
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1723
.L1698:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	emit_function_prototypes
	movq	8(%rsp), %r14
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	movq	%r14, %rdx
	call	emit_global_declarations
	movq	%r14, %rdx
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	emit_global_initializers
	cmpq	$0, 8(%rbp)
	je	.L1694
	xorl	%r15d, %r15d
	xorl	%r13d, %r13d
	xorl	%r14d, %r14d
	jmp	.L1703
	.p2align 4,,10
	.p2align 3
.L1700:
	addq	$1, %r15
	cmpq	8(%rbp), %r15
	jnb	.L1724
.L1703:
	movq	0(%rbp), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L1700
	movq	8(%rax), %r12
	leaq	.LC15(%rip), %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1701
	leaq	.LC212(%rip), %rdx
	movl	$2, %esi
	movq	%rbx, %rdi
	movq	16(%r12), %r13
	call	__fprintf_chk@PLT
	movl	$1, %r14d
.L1702:
	movq	%rbx, %rcx
	movl	$6, %edx
	movl	$1, %esi
	addq	$1, %r15
	leaq	.LC213(%rip), %rdi
	call	fwrite@PLT
	movq	8(%rsp), %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_function_body
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	8(%rbp), %r15
	jb	.L1703
.L1724:
	testl	%r14d, %r14d
	jne	.L1725
.L1694:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1719
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
.L1701:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC22(%rip), %rdi
	call	fwrite@PLT
	movq	(%r12), %rsi
	movq	%rbx, %rdi
	call	emit_function_body_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1702
	.p2align 4,,10
	.p2align 3
.L1720:
	movq	%rbx, %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC193(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1695
	.p2align 4,,10
	.p2align 3
.L1725:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC214(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC215(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC216(%rip), %rdi
	call	fwrite@PLT
	movl	$2, %ecx
	movl	$2, %esi
	movq	%rbx, %rdi
	cmpq	%rcx, %r13
	leaq	.LC217(%rip), %rdx
	cmovbe	%r13, %rcx
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	leaq	.LC15(%rip), %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
	testq	%r13, %r13
	jne	.L1726
.L1707:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC24(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1719
	addq	$40, %rsp
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
.L1723:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1698
	.p2align 4,,10
	.p2align 3
.L1722:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L1697
	.p2align 4,,10
	.p2align 3
.L1721:
	movq	%r14, %rdi
	call	free@PLT
	jmp	.L1696
	.p2align 4,,10
	.p2align 3
.L1726:
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC218(%rip), %rdi
	call	fwrite@PLT
	cmpq	$1, %r13
	je	.L1707
	movq	%rbx, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC219(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1707
.L1719:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE102:
	.size	emit_program_c, .-emit_program_c
	.section	.rodata.str1.8
	.align 8
.LC220:
	.string	"/* Generated by BCC - B Compiler */\n"
	.section	.rodata.str1.1
.LC221:
	.string	"#include \"libb.h\"\n\n"
	.section	.rodata.str1.8
	.align 8
.LC222:
	.string	"#include <ncurses.h>\n#include <panel.h>\n\n"
	.text
	.p2align 4
	.globl	emit_program_c_ext
	.type	emit_program_c_ext, @function
emit_program_c_ext:
.LFB103:
	.cfi_startproc
	endbr64
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
	movl	%ecx, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	%r9d, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movl	80(%rsp), %esi
	testl	%esi, %esi
	je	.L1749
	pxor	%xmm0, %xmm0
	movq	%r14, %rdi
	movl	%r9d, current_word_bits(%rip)
	movaps	%xmm0, external_calls(%rip)
	pxor	%xmm0, %xmm0
	movups	%xmm0, 8+string_pool(%rip)
	movl	%ecx, current_byteptr(%rip)
	movq	%r14, current_program(%rip)
	movq	$0, 16+external_calls(%rip)
	movq	$0, string_pool(%rip)
	movq	$0, 8+name_map(%rip)
	call	collect_strings_program
	movl	$2, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC220(%rip), %rdx
	call	__fprintf_chk@PLT
	movl	g_strict(%rip), %edx
	xorl	%ecx, %ecx
	movq	%rbx, %rdi
	movl	$2, %esi
	testl	%edx, %edx
	leaq	.LC195(%rip), %rdx
	setne	%cl
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	xorl	%ecx, %ecx
	testl	%r13d, %r13d
	movl	$2, %esi
	setne	%cl
	leaq	.LC196(%rip), %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movl	%r12d, %ecx
	movl	$2, %esi
	movq	%rbx, %rdi
	leaq	.LC197(%rip), %rdx
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movl	$2, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC221(%rip), %rdx
	call	__fprintf_chk@PLT
	movl	g_use_curses(%rip), %ecx
	testl	%ecx, %ecx
	jne	.L1750
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1751
.L1730:
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_function_prototypes
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_global_declarations
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_global_initializers
	cmpq	$0, 8(%r14)
	je	.L1727
	movl	$0, 12(%rsp)
	xorl	%r15d, %r15d
	xorl	%r13d, %r13d
	jmp	.L1735
	.p2align 4,,10
	.p2align 3
.L1732:
	addq	$1, %r15
	cmpq	8(%r14), %r15
	jnb	.L1752
.L1735:
	movq	(%r14), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L1732
	movq	8(%rax), %r12
	leaq	.LC15(%rip), %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1733
	leaq	.LC212(%rip), %rdx
	movl	$2, %esi
	movq	%rbx, %rdi
	movq	16(%r12), %r13
	call	__fprintf_chk@PLT
	movl	$1, 12(%rsp)
.L1734:
	movq	%rbx, %rcx
	movl	$6, %edx
	movl	$1, %esi
	addq	$1, %r15
	leaq	.LC213(%rip), %rdi
	call	fwrite@PLT
	movq	%rbp, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_function_body
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	8(%r14), %r15
	jb	.L1735
.L1752:
	movl	12(%rsp), %eax
	testl	%eax, %eax
	jne	.L1753
.L1727:
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
.L1733:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC22(%rip), %rdi
	call	fwrite@PLT
	movq	(%r12), %rsi
	movq	%rbx, %rdi
	call	emit_function_body_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	jmp	.L1734
	.p2align 4,,10
	.p2align 3
.L1753:
	movq	%rbx, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC214(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC215(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC216(%rip), %rdi
	call	fwrite@PLT
	movl	$2, %ecx
	movl	$2, %esi
	movq	%rbx, %rdi
	cmpq	%rcx, %r13
	leaq	.LC217(%rip), %rdx
	cmovbe	%r13, %rcx
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	leaq	.LC15(%rip), %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
	testq	%r13, %r13
	jne	.L1754
.L1739:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC24(%rip), %rdi
	call	fwrite@PLT
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rcx
	movl	$2, %edx
	popq	%rbx
	.cfi_def_cfa_offset 48
	movl	$1, %esi
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
.L1751:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1730
	.p2align 4,,10
	.p2align 3
.L1750:
	movq	%rbx, %rcx
	movl	$41, %edx
	movl	$1, %esi
	leaq	.LC222(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	je	.L1730
	jmp	.L1751
	.p2align 4,,10
	.p2align 3
.L1749:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r14, %rsi
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
.L1754:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC218(%rip), %rdi
	call	fwrite@PLT
	cmpq	$1, %r13
	je	.L1739
	movq	%rbx, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC219(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1739
	.cfi_endproc
.LFE103:
	.size	emit_program_c_ext, .-emit_program_c_ext
	.section	.rodata
	.align 16
	.type	CSWTCH.187, @object
	.size	CSWTCH.187, 24
CSWTCH.187:
	.long	24
	.long	25
	.long	26
	.long	27
	.long	22
	.long	23
	.globl	g_libb_path
	.bss
	.align 8
	.type	g_libb_path, @object
	.size	g_libb_path, 8
g_libb_path:
	.zero	8
	.local	g_loop_id
	.comm	g_loop_id,4,4
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
.LC223:
	.string	"break"
.LC224:
	.string	"case"
.LC225:
	.string	"char"
.LC226:
	.string	"const"
.LC227:
	.string	"continue"
.LC228:
	.string	"default"
.LC229:
	.string	"do"
.LC230:
	.string	"double"
.LC231:
	.string	"else"
.LC232:
	.string	"enum"
.LC233:
	.string	"extern"
.LC234:
	.string	"float"
.LC235:
	.string	"for"
.LC236:
	.string	"goto"
.LC237:
	.string	"if"
.LC238:
	.string	"inline"
.LC239:
	.string	"int"
.LC240:
	.string	"long"
.LC241:
	.string	"register"
.LC242:
	.string	"restrict"
.LC243:
	.string	"short"
.LC244:
	.string	"signed"
.LC245:
	.string	"sizeof"
.LC246:
	.string	"static"
.LC247:
	.string	"struct"
.LC248:
	.string	"switch"
.LC249:
	.string	"typedef"
.LC250:
	.string	"union"
.LC251:
	.string	"unsigned"
.LC252:
	.string	"volatile"
.LC253:
	.string	"while"
.LC254:
	.string	"_Bool"
.LC255:
	.string	"_Complex"
.LC256:
	.string	"_Imaginary"
.LC257:
	.string	"_Alignas"
.LC258:
	.string	"_Alignof"
.LC259:
	.string	"_Atomic"
.LC260:
	.string	"_Generic"
.LC261:
	.string	"_Noreturn"
.LC262:
	.string	"_Static_assert"
.LC263:
	.string	"_Thread_local"
.LC264:
	.string	"NULL"
.LC265:
	.string	"true"
.LC266:
	.string	"false"
.LC267:
	.string	"bool"
.LC268:
	.string	"word"
.LC269:
	.string	"B_PTR"
.LC270:
	.string	"B_ADDR"
.LC271:
	.string	"B_DEREF"
	.section	.data.rel.ro.local,"aw"
	.align 32
	.type	c_keywords, @object
	.size	c_keywords, 424
c_keywords:
	.quad	.LC4
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
	.quad	.LC239
	.quad	.LC240
	.quad	.LC241
	.quad	.LC242
	.quad	.LC144
	.quad	.LC243
	.quad	.LC244
	.quad	.LC245
	.quad	.LC246
	.quad	.LC247
	.quad	.LC248
	.quad	.LC249
	.quad	.LC250
	.quad	.LC251
	.quad	.LC23
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
	.quad	0
	.local	name_map
	.comm	name_map,24,16
	.local	external_calls
	.comm	external_calls,24,16
	.local	string_pool
	.comm	string_pool,24,16
	.local	current_word_bits
	.comm	current_word_bits,4,4
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
