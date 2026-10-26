	.file	"emitter.c"
	.text
	.p2align 4
	.type	loop_has_continue, @function
loop_has_continue:
.LFB46:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	leaq	.L5(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
.L13:
	testq	%rbx, %rbx
	je	.L17
	cmpl	$13, (%rbx)
	ja	.L17
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L5:
	.long	.L17-.L5
	.long	.L10-.L5
	.long	.L17-.L5
	.long	.L9-.L5
	.long	.L17-.L5
	.long	.L17-.L5
	.long	.L17-.L5
	.long	.L17-.L5
	.long	.L17-.L5
	.long	.L19-.L5
	.long	.L17-.L5
	.long	.L7-.L5
	.long	.L7-.L5
	.long	.L4-.L5
	.text
	.p2align 4,,10
	.p2align 3
.L17:
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
.L7:
	.cfi_restore_state
	movq	24(%rbx), %rbx
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L9:
	movq	24(%rbx), %rdi
	call	loop_has_continue
	testl	%eax, %eax
	je	.L24
.L19:
	movl	$1, %eax
.L26:
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
.L10:
	.cfi_restore_state
	movq	24(%rbx), %rbp
	testq	%rbp, %rbp
	je	.L17
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
	movl	$1, %eax
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L4:
	movq	40(%rbx), %rbx
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L24:
	movq	32(%rbx), %rbx
	jmp	.L13
	.cfi_endproc
.LFE46:
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
	je	.L27
	xorl	%r14d, %r14d
	movq	%r14, 24(%rsp)
	.p2align 4
	.p2align 3
.L38:
	leaq	string_pool(%rip), %rax
	movq	24(%rsp), %rdi
	cmpl	$16, current_word_bits(%rip)
	movl	$8, %r13d
	movq	(%rax), %rax
	leaq	.LC0(%rip), %rsi
	movq	(%rax,%rdi,8), %rax
	movq	16(%rax), %r15
	movq	8(%rax), %rbp
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
	jne	.L32
	leal	(%r13,%r13), %eax
	xorl	%ebx, %ebx
	movq	%r13, %r14
	movl	%eax, 20(%rsp)
	.p2align 4
	.p2align 3
.L33:
	movq	%r14, %rsi
	xorl	%r12d, %r12d
	xorl	%ecx, %ecx
	subq	%r13, %rsi
	jmp	.L36
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L47:
	movzbl	0(%rbp,%rsi), %eax
.L35:
	movzbl	%al, %eax
	addq	$1, %rsi
	salq	%cl, %rax
	addl	$8, %ecx
	orq	%rax, %r12
	cmpq	%r14, %rsi
	je	.L46
.L36:
	cmpq	%r15, %rsi
	jb	.L47
	cmpq	%rsi, %r15
	sete	%al
	sall	$2, %eax
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L46:
	testq	%rbx, %rbx
	je	.L37
	movq	(%rsp), %rsi
	movl	$44, %edi
	call	fputc@PLT
.L37:
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
	jb	.L33
.L32:
	movq	(%rsp), %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC2(%rip), %rdi
	call	fwrite@PLT
	addq	$1, 24(%rsp)
	movq	24(%rsp), %rax
	cmpq	8+string_pool(%rip), %rax
	jb	.L38
.L27:
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
	je	.L49
	movq	8(%rax), %r12
	testq	%r12, %r12
	je	.L49
	movq	(%rax), %r13
	xorl	%ebx, %ebx
	jmp	.L52
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L50:
	addq	$1, %rbx
	cmpq	%r12, %rbx
	je	.L49
.L52:
	movq	0(%r13,%rbx,8), %rax
	cmpl	$1, (%rax)
	jne	.L50
	movq	8(%rax), %rax
	movq	%rbp, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L50
.L56:
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
	testq	%r12, %r12
	je	.L55
	movq	g_known_functions(%rip), %r13
	xorl	%ebx, %ebx
	jmp	.L53
	.p2align 4,,10
	.p2align 3
.L66:
	addq	$1, %rbx
	cmpq	%r12, %rbx
	je	.L55
.L53:
	movq	0(%r13,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L66
	jmp	.L56
	.p2align 4,,10
	.p2align 3
.L55:
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
	.p2align 4
	.type	collect_cases, @function
collect_cases:
.LFB44:
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
	jmp	*%rax
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
.LFE44:
	.size	collect_cases, .-collect_cases
	.p2align 4
	.type	collect_function_labels, @function
collect_function_labels:
.LFB42:
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
	jmp	*%rax
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
.LFE42:
	.size	collect_function_labels, .-collect_function_labels
	.p2align 4
	.type	collect_function_autos, @function
collect_function_autos:
.LFB58:
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
	jmp	*%rax
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
	.p2align 4
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
.LFE58:
	.size	collect_function_autos, .-collect_function_autos
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
	je	.L166
	movq	g_known_variables(%rip), %rbx
	xorl	%ebp, %ebp
	leaq	(%rbx,%rax,8), %r13
	.p2align 4
	.p2align 3
.L153:
	movq	(%rbx), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	addq	$8, %rbx
	movzbl	%al, %eax
	orl	%eax, %ebp
	cmpq	%r13, %rbx
	jne	.L153
.L152:
	movq	current_program(%rip), %r13
	testq	%r13, %r13
	je	.L154
	movq	8(%r13), %r14
	xorl	%ebx, %ebx
	jmp	.L155
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L156:
	addq	$1, %rbx
.L155:
	cmpq	%rbx, %r14
	je	.L154
	movq	0(%r13), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$2, (%rax)
	jne	.L156
	movq	8(%rax), %rax
	movq	%r12, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L156
.L157:
	movl	$1, %ebp
	jmp	.L151
	.p2align 4,,10
	.p2align 3
.L154:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L159
.L161:
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
.L159:
	.cfi_restore_state
	movq	%r12, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	je	.L168
	testb	$1, %bpl
	je	.L161
.L168:
	movq	current_program(%rip), %r13
	testq	%r13, %r13
	je	.L151
	movq	8(%r13), %r14
	xorl	%ebx, %ebx
	jmp	.L163
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L164:
	addq	$1, %rbx
.L163:
	cmpq	%rbx, %r14
	je	.L151
	movq	0(%r13), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$3, (%rax)
	jne	.L164
	movq	8(%rax), %r15
	movq	%r12, %rsi
	movq	16(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L164
	movl	8(%r15), %eax
	movl	$2, %ebp
	testl	%eax, %eax
	jne	.L151
	jmp	.L157
.L166:
	xorl	%ebp, %ebp
	jmp	.L152
	.cfi_endproc
.LFE23:
	.size	global_data_kind, .-global_data_kind
	.section	.rodata.str1.1
.LC3:
	.string	"argv"
	.text
	.p2align 4
	.type	predefined_argv, @function
predefined_argv:
.LFB22:
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
	je	.L212
.L183:
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
.L212:
	.cfi_restore_state
	movq	%rbp, %rdi
	movl	%eax, %ebx
	call	source_function
	testl	%eax, %eax
	jne	.L183
	movq	8+g_known_variables(%rip), %r13
	testq	%r13, %r13
	je	.L185
	movq	g_known_variables(%rip), %r14
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L186:
	movq	(%r14,%r12,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	je	.L183
	addq	$1, %r12
	cmpq	%r13, %r12
	jne	.L186
.L185:
	movq	current_program(%rip), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L193
	movq	8(%rax), %rax
	xorl	%r12d, %r12d
	movq	%rax, (%rsp)
	jmp	.L187
	.p2align 4,,10
	.p2align 3
.L188:
	testl	%eax, %eax
	je	.L213
.L189:
	addq	$1, %r12
.L187:
	cmpq	%r12, (%rsp)
	je	.L193
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%r12,8), %rdx
	movl	(%rdx), %eax
	cmpl	$2, %eax
	jne	.L188
	movq	8(%rdx), %rax
	movq	%rbp, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L189
	jmp	.L183
	.p2align 4,,10
	.p2align 3
.L213:
	movq	8(%rdx), %rax
	movq	24(%rax), %r13
	testq	%r13, %r13
	je	.L189
	movq	16(%rax), %r14
	xorl	%r15d, %r15d
	jmp	.L190
	.p2align 4,,10
	.p2align 3
.L214:
	addq	$1, %r15
	cmpq	%r13, %r15
	je	.L189
.L190:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L214
	jmp	.L183
.L193:
	movl	$1, %ebx
	jmp	.L183
	.cfi_endproc
.LFE22:
	.size	predefined_argv, .-predefined_argv
	.p2align 4
	.type	get_string_id, @function
get_string_id:
.LFB14:
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
	je	.L216
	movq	string_pool(%rip), %rsi
	xorl	%eax, %eax
	jmp	.L219
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L217:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L216
.L219:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%rbx, (%rdx)
	jne	.L217
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
.L216:
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
.LFE14:
	.size	get_string_id, .-get_string_id
	.p2align 4
	.type	collect_strings_expr, @function
collect_strings_expr:
.LFB33:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L261
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
	leaq	.L230(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %rbx
.L227:
	cmpl	$10, (%rbx)
	ja	.L225
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L230:
	.long	.L225-.L230
	.long	.L238-.L230
	.long	.L225-.L230
	.long	.L237-.L230
	.long	.L229-.L230
	.long	.L265-.L230
	.long	.L265-.L230
	.long	.L264-.L230
	.long	.L264-.L230
	.long	.L231-.L230
	.long	.L229-.L230
	.text
	.p2align 4,,10
	.p2align 3
.L229:
	movq	48(%rbx), %rdi
	call	collect_strings_expr
.L265:
	movq	56(%rbx), %rbx
.L245:
	testq	%rbx, %rbx
	jne	.L227
.L225:
	popq	%rbx
	.cfi_remember_state
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
.L231:
	.cfi_restore_state
	movq	48(%rbx), %rdi
	call	collect_strings_expr
.L264:
	movq	56(%rbx), %rdi
	call	collect_strings_expr
	movq	64(%rbx), %rbx
	jmp	.L245
	.p2align 4,,10
	.p2align 3
.L237:
	movl	g_strict(%rip), %edx
	movq	48(%rbx), %rdi
	testl	%edx, %edx
	jne	.L267
.L239:
	call	collect_strings_expr
	cmpq	$0, 64(%rbx)
	je	.L225
	xorl	%ebp, %ebp
.L244:
	movq	56(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_expr
	cmpq	64(%rbx), %rbp
	jb	.L244
	popq	%rbx
	.cfi_remember_state
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
.L238:
	.cfi_restore_state
	movq	40(%rbx), %rsi
	movq	48(%rbx), %rdi
	popq	%rbx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_restore 13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_restore 14
	.cfi_def_cfa_offset 8
	jmp	get_string_id
	.p2align 4,,10
	.p2align 3
.L267:
	.cfi_restore_state
	movl	24(%rbx), %eax
	testl	%eax, %eax
	jne	.L239
	cmpl	$2, (%rdi)
	jne	.L239
	movq	48(%rdi), %r13
	movq	%r13, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	je	.L240
.L266:
	movq	48(%rbx), %rdi
	jmp	.L239
	.p2align 4,,10
	.p2align 3
.L261:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	ret
.L240:
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	movq	%r13, %rdi
	call	source_function
	movl	%eax, %r12d
	testl	%eax, %eax
	jne	.L266
	movq	8+external_calls(%rip), %rax
	testq	%rax, %rax
	je	.L242
	movq	external_calls(%rip), %rbp
	leaq	0(%rbp,%rax,8), %r14
.L243:
	movq	0(%rbp), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	addq	$8, %rbp
	movzbl	%al, %eax
	orl	%eax, %r12d
	cmpq	%r14, %rbp
	jne	.L243
	testl	%r12d, %r12d
	jne	.L266
.L242:
	movq	%r13, %rdi
	call	sdup@PLT
	leaq	external_calls(%rip), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L266
	.cfi_endproc
.LFE33:
	.size	collect_strings_expr, .-collect_strings_expr
	.p2align 4
	.type	collect_strings_init, @function
collect_strings_init:
.LFB34:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L277
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
	je	.L280
	cmpl	$1, %eax
	je	.L281
.L268:
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
.L280:
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
.L281:
	.cfi_restore_state
	cmpq	$0, 24(%rdi)
	je	.L268
	xorl	%ebp, %ebp
.L271:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_init
	cmpq	24(%rbx), %rbp
	jb	.L271
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L277:
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE34:
	.size	collect_strings_init, .-collect_strings_init
	.p2align 4
	.type	collect_strings_stmt, @function
collect_strings_stmt:
.LFB35:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L306
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.L287(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L284:
	cmpl	$13, (%rbx)
	ja	.L282
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L287:
	.long	.L282-.L287
	.long	.L295-.L287
	.long	.L282-.L287
	.long	.L294-.L287
	.long	.L288-.L287
	.long	.L291-.L287
	.long	.L291-.L287
	.long	.L282-.L287
	.long	.L282-.L287
	.long	.L282-.L287
	.long	.L291-.L287
	.long	.L289-.L287
	.long	.L288-.L287
	.long	.L286-.L287
	.text
	.p2align 4,,10
	.p2align 3
.L291:
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
.L295:
	.cfi_restore_state
	cmpq	$0, 24(%rbx)
	je	.L282
	xorl	%ebp, %ebp
.L296:
	movq	16(%rbx), %rax
	movq	(%rax,%rbp,8), %rdi
	addq	$1, %rbp
	call	collect_strings_stmt
	cmpq	24(%rbx), %rbp
	jb	.L296
.L282:
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
.L288:
	.cfi_restore_state
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rbx
.L297:
	testq	%rbx, %rbx
	jne	.L284
	jmp	.L282
	.p2align 4,,10
	.p2align 3
.L286:
	movq	40(%rbx), %rbx
	jmp	.L297
	.p2align 4,,10
	.p2align 3
.L294:
	movq	16(%rbx), %rdi
	call	collect_strings_expr
	movq	24(%rbx), %rdi
	call	collect_strings_stmt
	movq	32(%rbx), %rbx
	jmp	.L297
	.p2align 4,,10
	.p2align 3
.L289:
	movq	24(%rbx), %rbx
	jmp	.L297
	.p2align 4,,10
	.p2align 3
.L306:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE35:
	.size	collect_strings_stmt, .-collect_strings_stmt
	.p2align 4
	.type	collect_strings_program, @function
collect_strings_program:
.LFB36:
	.cfi_startproc
	cmpq	$0, 8(%rdi)
	je	.L319
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
	jmp	.L316
	.p2align 4,,10
	.p2align 3
.L312:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L322
.L316:
	movq	0(%rbp), %rax
	movq	(%rax,%rbx,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L323
	cmpl	$2, %eax
	je	.L324
	testl	%eax, %eax
	jne	.L312
	movq	8(%rdx), %rdi
	addq	$1, %rbx
	call	collect_strings_stmt
	cmpq	8(%rbp), %rbx
	jb	.L316
.L322:
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
.L323:
	.cfi_restore_state
	movq	8(%rdx), %rax
	movq	32(%rax), %rdi
	call	collect_strings_stmt
	jmp	.L312
	.p2align 4,,10
	.p2align 3
.L324:
	movq	8(%rdx), %r12
	movq	56(%r12), %rdi
	call	collect_strings_init
	movq	32(%r12), %rdi
	testq	%rdi, %rdi
	je	.L312
	call	collect_strings_expr
	jmp	.L312
	.p2align 4,,10
	.p2align 3
.L319:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
	.cfi_endproc
.LFE36:
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
	je	.L371
	movq	8+name_map(%rip), %r13
	movq	%rdi, %rbp
	testq	%r13, %r13
	je	.L327
	movq	name_map(%rip), %r14
	xorl	%ebx, %ebx
	jmp	.L329
	.p2align 4,,10
	.p2align 3
.L328:
	addq	$1, %rbx
	cmpq	%r13, %rbx
	je	.L327
.L329:
	movq	(%r14,%rbx,8), %r12
	movq	%rbp, %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L328
	movq	8(%r12), %r13
.L325:
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
.L327:
	.cfi_restore_state
	cmpb	$0, 0(%rbp)
	je	.L401
	movq	%rbp, %rdi
	call	strlen@PLT
	movl	$8, %esi
	movq	%rbp, %rdi
	movq	%rax, %r15
	call	strchr@PLT
	testq	%rax, %rax
	je	.L402
.L332:
	movabsq	$9223372036854775802, %rax
	cmpq	%r15, %rax
	jb	.L403
	leaq	10(%r15,%r15), %r13
	movq	%r13, %rdi
	call	xmalloc@PLT
	movq	%rax, %r14
	movabsq	$8314312742553149279, %rax
	movq	%rax, (%r14)
	movb	$95, 8(%r14)
	testq	%r15, %r15
	je	.L331
.L335:
	leaq	-1(%r14,%r13), %r15
	movq	%rbp, %r12
	leaq	9(%r14), %rbx
	leaq	.LC8(%rip), %r13
	.p2align 4
	.p2align 3
.L337:
	movzbl	(%r12), %edx
	movq	%rbx, %rdi
	movq	%r13, %rsi
	xorl	%eax, %eax
	addq	$2, %rbx
	addq	$1, %r12
	call	sprintf@PLT
	cmpq	%rbx, %r15
	jne	.L337
.L331:
	movl	g_strict(%rip), %edx
	testl	%edx, %edx
	jne	.L356
	movq	%rbp, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L404
.L356:
	movq	%r14, %rdi
	call	strlen@PLT
	leaq	14(%rax), %rdi
	call	xmalloc@PLT
	movl	$98, %edx
	movq	%rax, %r13
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L405
.L355:
	xorl	%eax, %eax
	movq	%r14, %rcx
	leaq	.LC12(%rip), %rsi
	movq	%r13, %rdi
	call	sprintf@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L406
.L357:
	leaq	8+c_keywords(%rip), %rbx
	leaq	.LC4(%rip), %rsi
	jmp	.L360
	.p2align 4,,10
	.p2align 3
.L407:
	movq	(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L361
.L360:
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L407
	movq	%r13, %rdi
	call	strlen@PLT
	leaq	15(%rax), %rdi
	call	xmalloc@PLT
	movq	%r13, %rdx
	leaq	.LC14(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %rbx
	xorl	%eax, %eax
	call	sprintf@PLT
	cmpq	$0, g_compilation_arena(%rip)
	je	.L408
.L370:
	movq	%rbx, %r13
.L361:
	movq	8+name_map(%rip), %r12
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
	testq	%r12, %r12
	je	.L362
	movq	name_map(%rip), %r14
	xorl	%ebx, %ebx
	jmp	.L364
	.p2align 4,,10
	.p2align 3
.L410:
	addq	$1, %rbx
	cmpq	%rbx, %r12
	je	.L409
.L364:
	movq	(%r14,%rbx,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L410
	movq	%r13, %rdi
	call	strlen@PLT
	leaq	16(%rax), %rdi
	call	xmalloc@PLT
	movl	$2, %ecx
	movq	%rax, %r12
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
	.p2align 4
	.p2align 3
.L366:
	leal	1(%rcx), %eax
	movq	%r13, %rdx
	leaq	.LC13(%rip), %rsi
	movq	%r12, %rdi
	movl	%eax, 12(%rsp)
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	8+name_map(%rip), %rbx
	testq	%rbx, %rbx
	je	.L365
	movq	(%rsp), %rax
	xorl	%r15d, %r15d
	movq	(%rax), %r14
	jmp	.L367
	.p2align 4,,10
	.p2align 3
.L411:
	addq	$1, %r15
	cmpq	%rbx, %r15
	je	.L365
.L367:
	movq	(%r14,%r15,8), %rax
	movq	%r12, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L411
	movl	12(%rsp), %ecx
	jmp	.L366
.L402:
	movl	$9, %edx
	leaq	.LC6(%rip), %rsi
	movq	%rbp, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	je	.L332
	leaq	16(,%r15,4), %rdi
	call	xmalloc@PLT
	movzbl	0(%rbp), %edx
	movq	%rax, %r14
	leaq	1(%rax), %r13
	leal	-65(%rdx), %eax
	cmpb	$57, %al
	ja	.L338
	movabsq	$288230372997595135, %rcx
	btq	%rax, %rcx
	jnc	.L338
	movb	%dl, (%r14)
.L342:
	leaq	1(%rbp), %rbx
	leaq	0(%rbp,%r15), %rcx
	movabsq	$288230372997595135, %r12
	cmpq	$1, %r15
	ja	.L352
	jmp	.L344
	.p2align 4,,10
	.p2align 3
.L345:
	leal	-65(%rax), %edx
	cmpb	$57, %dl
	ja	.L348
	btq	%rdx, %r12
	jnc	.L348
.L346:
	movb	%al, 0(%r13)
	addq	$1, %r13
.L351:
	addq	$1, %rbx
	cmpq	%rbx, %rcx
	je	.L344
.L352:
	movzbl	(%rbx), %eax
	cmpb	$57, %al
	jg	.L345
	cmpb	$47, %al
	jg	.L346
	cmpb	$46, %al
	jne	.L348
	movb	$95, 0(%r13)
	addq	$1, %r13
	jmp	.L351
.L403:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	leaq	10(%r15,%r15), %r13
	call	dief@PLT
	movq	%r13, %rdi
	call	xmalloc@PLT
	movq	%rax, %r14
	movabsq	$8314312742553149279, %rax
	movq	%rax, (%r14)
	movb	$95, 8(%r14)
	jmp	.L335
	.p2align 4,,10
	.p2align 3
.L409:
	leaq	name_map(%rip), %rax
	movq	%rax, (%rsp)
.L362:
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
	jmp	.L325
	.p2align 4,,10
	.p2align 3
.L401:
	leaq	.LC5(%rip), %rdi
	call	sdup@PLT
	movq	%rax, %r14
	jmp	.L331
	.p2align 4,,10
	.p2align 3
.L365:
	cmpq	$0, g_compilation_arena(%rip)
	je	.L412
.L368:
	movq	%r12, %r13
	jmp	.L362
	.p2align 4,,10
	.p2align 3
.L405:
	movq	%rbp, %rdi
	call	source_function
	movl	$102, %edx
	testl	%eax, %eax
	jne	.L355
	movq	%rbp, %rdi
	call	b_library_function@PLT
	cmpl	$1, %eax
	sbbl	%edx, %edx
	andl	$6, %edx
	addl	$114, %edx
	jmp	.L355
.L371:
	xorl	%r13d, %r13d
	jmp	.L325
.L406:
	movq	%r14, %rdi
	call	free@PLT
	jmp	.L357
.L404:
	movq	%rbp, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	jne	.L356
	movl	$6, %edx
	leaq	.LC11(%rip), %rsi
	movq	%rbp, %rdi
	movq	%r14, %r13
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L357
	jmp	.L356
.L338:
	movb	$95, (%r14)
	movzbl	0(%rbp), %eax
	cmpb	$46, %al
	jne	.L413
	movb	$95, 1(%r14)
	leaq	2(%r14), %r13
	jmp	.L342
.L348:
	movzbl	%al, %edx
	movq	%r13, %rdi
	leaq	.LC10(%rip), %rsi
	xorl	%eax, %eax
	movq	%rcx, (%rsp)
	addq	$3, %r13
	call	sprintf@PLT
	movq	(%rsp), %rcx
	jmp	.L351
.L344:
	movb	$0, 0(%r13)
	jmp	.L331
.L408:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L370
.L412:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L368
.L413:
	movzbl	%al, %edx
	movq	%r13, %rdi
	leaq	.LC9(%rip), %rsi
	xorl	%eax, %eax
	call	sprintf@PLT
	leaq	3(%r14), %r13
	jmp	.L342
	.cfi_endproc
.LFE24:
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
.LFB27:
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
	jne	.L415
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
.L415:
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
.LFE27:
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
.LFB64:
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
	je	.L418
	xorl	%ebp, %ebp
	leaq	.LC18(%rip), %r15
	leaq	external_calls(%rip), %r14
	leaq	.LC19(%rip), %r13
	.p2align 4
	.p2align 3
.L420:
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rdi
	testq	%rdi, %rdi
	je	.L419
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L419:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addq	$1, %rbp
	cmpq	8+external_calls(%rip), %rbp
	jb	.L420
.L418:
	cmpq	$0, 8+g_known_functions(%rip)
	je	.L429
	movl	$0, 12(%rsp)
	movq	$0, (%rsp)
	.p2align 4
	.p2align 3
.L427:
	leaq	g_known_functions(%rip), %rax
	movq	(%rsp), %rdx
	movq	8(%r12), %r13
	movq	(%rax), %rax
	movq	(%r12), %r14
	movq	(%rax,%rdx,8), %rbp
	testq	%r13, %r13
	je	.L422
	xorl	%r15d, %r15d
	jmp	.L425
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L423:
	addq	$1, %r15
	cmpq	%r15, %r13
	je	.L422
.L425:
	movq	(%r14,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L423
	movq	8(%rax), %rax
	movq	%rbp, %rsi
	movq	(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L423
.L424:
	addq	$1, (%rsp)
	movq	(%rsp), %rax
	cmpq	8+g_known_functions(%rip), %rax
	jb	.L427
	movl	12(%rsp), %eax
	testl	%eax, %eax
	je	.L429
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
.L429:
	cmpq	$0, 8(%r12)
	je	.L417
	xorl	%r13d, %r13d
	leaq	.LC20(%rip), %r15
	leaq	.LC21(%rip), %r14
	jmp	.L433
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L431:
	addq	$1, %r13
	cmpq	8(%r12), %r13
	jnb	.L417
.L433:
	movq	(%r12), %rax
	movq	(%rax,%r13,8), %rax
	cmpl	$1, (%rax)
	jne	.L431
	movq	8(%rax), %rbp
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$5, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	0(%rbp), %rdi
	testq	%rdi, %rdi
	je	.L432
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L432:
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
	jb	.L433
.L417:
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
.L422:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC18(%rip), %rdi
	call	fwrite@PLT
	testq	%rbp, %rbp
	je	.L426
	movq	%rbp, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L426:
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC19(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 12(%rsp)
	jmp	.L424
	.cfi_endproc
.LFE64:
	.size	emit_function_prototypes, .-emit_function_prototypes
	.section	.rodata.str1.1
.LC25:
	.string	"b_%s"
	.text
	.p2align 4
	.type	emit_function_name, @function
emit_function_name:
.LFB29:
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
	jne	.L458
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
.L458:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	je	.L459
	movq	%rbx, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L464
.L459:
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
.L464:
	.cfi_restore_state
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbx, %rdx
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 16
	leaq	.LC25(%rip), %rsi
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	fprintf@PLT
	.cfi_endproc
.LFE29:
	.size	emit_function_name, .-emit_function_name
	.p2align 4
	.type	edge_words_total.part.0.isra.0, @function
edge_words_total.part.0.isra.0:
.LFB81:
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
	je	.L469
	movq	%rdi, %r12
	movq	%rsi, %rbp
	xorl	%ebx, %ebx
.L468:
	movq	(%r12,%rbx,8), %rax
	testq	%rax, %rax
	je	.L467
	cmpl	$1, (%rax)
	je	.L475
.L467:
	addq	$1, %rbx
	cmpq	%rbp, %rbx
	jne	.L468
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
.L475:
	.cfi_restore_state
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r13
	jmp	.L467
	.p2align 4,,10
	.p2align 3
.L469:
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
.LFE81:
	.size	edge_words_total.part.0.isra.0, .-edge_words_total.part.0.isra.0
	.section	.rodata.str1.1
.LC26:
	.string	"  "
	.text
	.p2align 4
	.globl	emit_indent
	.type	emit_indent, @function
emit_indent:
.LFB38:
	.cfi_startproc
	testl	%esi, %esi
	jle	.L481
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
	.p2align 4
	.p2align 3
.L478:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L478
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
.L481:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	ret
	.cfi_endproc
.LFE38:
	.size	emit_indent, .-emit_indent
	.section	.rodata.str1.1
.LC27:
	.string	"#line %d \"%s\"\n"
	.text
	.p2align 4
	.globl	emit_line_directive
	.type	emit_line_directive, @function
emit_line_directive:
.LFB39:
	.cfi_startproc
	movl	g_no_line(%rip), %eax
	testl	%eax, %eax
	jne	.L484
	testq	%rdx, %rdx
	jne	.L492
.L484:
	ret
	.p2align 4,,10
	.p2align 3
.L492:
	movq	%rdx, %rcx
	xorl	%eax, %eax
	movl	%esi, %edx
	leaq	.LC27(%rip), %rsi
	jmp	fprintf@PLT
	.cfi_endproc
.LFE39:
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
.LFB40:
	.cfi_startproc
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
	jne	.L494
	jmp	.L501
	.p2align 4,,10
	.p2align 3
.L509:
	movq	%r13, %rsi
	movq	%r12, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L497:
	movzbl	1(%rbp), %ebx
	addq	$1, %rbp
	testb	%bl, %bl
	je	.L501
.L494:
	cmpb	$92, %bl
	je	.L502
	cmpb	$34, %bl
	je	.L502
	cmpb	$10, %bl
	je	.L507
	cmpb	$9, %bl
	je	.L508
	movzbl	%bl, %edx
	cmpb	$31, %bl
	jbe	.L509
	movq	%r12, %rsi
	movl	%edx, %edi
	addq	$1, %rbp
	call	fputc@PLT
	movzbl	0(%rbp), %ebx
	testb	%bl, %bl
	jne	.L494
.L501:
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
.L502:
	.cfi_restore_state
	movq	%r12, %rsi
	movl	$92, %edi
	call	fputc@PLT
	movzbl	%bl, %edi
	movq	%r12, %rsi
	call	fputc@PLT
	jmp	.L497
	.p2align 4,,10
	.p2align 3
.L507:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	jmp	.L497
	.p2align 4,,10
	.p2align 3
.L508:
	movq	%r12, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC29(%rip), %rdi
	call	fwrite@PLT
	jmp	.L497
	.cfi_endproc
.LFE40:
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
.LFB76:
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
	je	.L511
	movq	48(%rbx), %rdi
	call	predefined_argv
	testl	%eax, %eax
	je	.L528
.L511:
	leaq	.LC33(%rip), %rdi
	movq	%rbp, %rcx
	movl	$7, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	48(%rbx), %r12
	movq	%r12, %rdi
	call	predefined_argv
	testl	%eax, %eax
	jne	.L529
	movq	%r12, %rdi
	call	global_data_kind
	movq	48(%rbx), %r12
	cmpl	$2, %eax
	je	.L530
	testq	%r12, %r12
	je	.L515
	movq	%r12, %rdi
	call	get_mangled_name
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	48(%rbx), %r12
.L515:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L516
.L517:
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
	jmp	.L513
	.p2align 4,,10
	.p2align 3
.L529:
	movq	%rbp, %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC34(%rip), %rdi
	call	fwrite@PLT
.L513:
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
.L528:
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
.L516:
	.cfi_restore_state
	movq	%r12, %rdi
	call	global_data_kind
	cmpl	$1, %eax
	jne	.L513
	jmp	.L517
	.p2align 4,,10
	.p2align 3
.L530:
	movq	%r12, %rdi
	call	get_mangled_name
	leaq	.LC35(%rip), %rsi
	movq	%rbp, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L513
	.cfi_endproc
.LFE76:
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
	.string	"B_PTR("
.LC74:
	.string	"-+ #0"
.LC75:
	.string	"strlen"
.LC76:
	.string	"atoi"
.LC77:
	.string	"memmove"
.LC78:
	.string	"tcgetattr"
.LC79:
	.string	"tcsetattr"
.LC80:
	.string	"ioctl"
.LC81:
	.string	"memset"
.LC82:
	.string	"memcpy"
.LC83:
	.string	"__b_cstr("
.LC84:
	.string	"B_CPTR("
	.section	.rodata.str1.8
	.align 8
.LC85:
	.string	"(size_t)(sizeof(word) * (uword)("
	.section	.rodata.str1.1
.LC86:
	.string	", "
.LC87:
	.string	"B_INDEX("
.LC88:
	.string	"B_DEREF("
.LC89:
	.string	"WNEG("
.LC90:
	.string	"({ word __b_left_%u = "
.LC91:
	.string	"; word __b_right_%u = "
	.section	.rodata.str1.8
	.align 8
.LC92:
	.string	"; (word)%s(__b_left_%u, __b_right_%u); })"
	.section	.rodata.str1.1
.LC93:
	.string	" %s "
.LC94:
	.string	"%s("
.LC95:
	.string	"({ word *__b_dest_%u = &("
.LC96:
	.string	"); word __b_rhs_%u = ("
	.section	.rodata.str1.8
	.align 8
.LC97:
	.string	"); *__b_dest_%u = (*__b_dest_%u %s __b_rhs_%u); })"
	.align 8
.LC98:
	.string	"*__b_dest_%u %s __b_rhs_%u; })"
	.align 8
.LC99:
	.string	"b_%s(__b_dest_%u, __b_rhs_%u); })"
	.section	.rodata.str1.1
.LC100:
	.string	" ? "
.LC101:
	.string	" : "
.LC102:
	.string	"snprintf"
.LC103:
	.string	"sprintf"
.LC104:
	.string	"fprintf"
.LC105:
	.string	"dprintf"
	.text
	.p2align 4
	.globl	emit_expr
	.type	emit_expr, @function
emit_expr:
.LFB50:
	.cfi_startproc
	cmpl	$10, (%rsi)
	ja	.L894
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
	leaq	.L534(%rip), %rdx
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movl	(%rsi), %eax
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L534:
	.long	.L544-.L534
	.long	.L543-.L534
	.long	.L542-.L534
	.long	.L541-.L534
	.long	.L540-.L534
	.long	.L539-.L534
	.long	.L538-.L534
	.long	.L537-.L534
	.long	.L536-.L534
	.long	.L535-.L534
	.long	.L533-.L534
	.text
	.p2align 4,,10
	.p2align 3
.L535:
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
	leaq	.LC100(%rip), %rdi
	call	fwrite@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$3, %edx
	leaq	.LC101(%rip), %rdi
	call	fwrite@PLT
	movq	64(%r15), %rsi
.L908:
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L909:
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
.L533:
	.cfi_restore_state
	movq	%rdi, %rsi
	movl	$40, %edi
	call	fputc@PLT
.L912:
	movq	48(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC86(%rip), %rdi
.L911:
	call	fwrite@PLT
	movq	56(%r15), %rsi
	jmp	.L908
	.p2align 4,,10
	.p2align 3
.L544:
	movq	48(%rsi), %rdx
	leaq	.LC60(%rip), %rsi
.L906:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rdi
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
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L543:
	.cfi_restore_state
	movq	48(%r15), %rdi
	movq	40(%rsi), %rsi
	call	get_string_id
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rdi
	leaq	.LC61(%rip), %rsi
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 48
	movl	%eax, %edx
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 40
	movl	%eax, %ecx
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 32
	xorl	%eax, %eax
	popq	%r13
	.cfi_restore 13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_restore 14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_restore 15
	.cfi_def_cfa_offset 8
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L542:
	.cfi_restore_state
	movq	8+function_labels(%rip), %r13
	movq	48(%rsi), %r12
	testq	%r13, %r13
	je	.L545
	movq	function_labels(%rip), %r14
	xorl	%ebp, %ebp
	jmp	.L548
	.p2align 4,,10
	.p2align 3
.L546:
	addq	$1, %rbp
	cmpq	%r13, %rbp
	je	.L545
.L548:
	movq	(%r14,%rbp,8), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L546
	movl	%ebp, %edx
	addl	$1, %edx
	je	.L545
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rdi
	leaq	.LC62(%rip), %rsi
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
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L541:
	.cfi_restore_state
	movq	48(%rsi), %rax
	movl	24(%rsi), %edx
	cmpl	$2, (%rax)
	je	.L922
	testl	%edx, %edx
	jne	.L563
	movq	48(%rax), %r12
.L693:
	xorl	%r14d, %r14d
.L567:
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	64(%r15), %rdx
	testq	%rdx, %rdx
	je	.L909
	movq	$0, 16(%rsp)
	movl	$0, 32(%rsp)
	movb	$0, 39(%rsp)
	movq	$0, 24(%rsp)
.L583:
	movq	%rbp, (%rsp)
	xorl	%r12d, %r12d
	movq	%rdx, %r13
.L643:
	testq	%r14, %r14
	je	.L705
	movl	g_strict(%rip), %ebp
	testl	%ebp, %ebp
	je	.L923
.L705:
	xorl	%ebp, %ebp
.L606:
	movq	56(%r15), %rax
	movq	(%rsp), %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r12,8), %rsi
	call	emit_expr
.L675:
	testl	%ebp, %ebp
	jne	.L924
.L641:
	addq	$1, %r12
	cmpq	%r13, %r12
	jnb	.L642
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC86(%rip), %rdi
	call	fwrite@PLT
	jmp	.L643
	.p2align 4,,10
	.p2align 3
.L540:
	movq	%rdi, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC87(%rip), %rdi
	call	fwrite@PLT
	jmp	.L912
	.p2align 4,,10
	.p2align 3
.L539:
	movl	48(%rsi), %r12d
	cmpl	$32, %r12d
	je	.L925
	cmpl	$53, %r12d
	je	.L926
	leal	-36(%r12), %eax
	cmpl	$1, %eax
	jbe	.L927
	cmpl	$31, %r12d
	je	.L928
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
.L538:
	cmpl	$36, 48(%rsi)
	movq	56(%rsi), %r12
	leaq	.LC40(%rip), %rdi
	jne	.L650
	leaq	.LC39(%rip), %rdi
.L650:
	movl	$12, %edx
	movl	$1, %esi
	movq	%rbx, %rcx
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
.L907:
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
.L537:
	.cfi_restore_state
	movl	48(%rsi), %r12d
	leal	-53(%r12), %eax
	cmpl	$1, %eax
	jbe	.L929
	leal	-28(%r12), %eax
	cmpl	$6, %eax
	ja	.L653
	leaq	.L655(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L655:
	.long	.L713-.L655
	.long	.L660-.L655
	.long	.L659-.L655
	.long	.L658-.L655
	.long	.L657-.L655
	.long	.L656-.L655
	.long	.L654-.L655
	.text
	.p2align 4,,10
	.p2align 3
.L536:
	movl	48(%rsi), %r8d
	movl	expression_id(%rip), %ecx
	movq	56(%rsi), %r13
	movq	64(%rsi), %r14
	leal	-47(%r8), %eax
	leal	1(%rcx), %r12d
	cmpl	$5, %eax
	jbe	.L930
	movl	%r12d, %edx
	leaq	.LC95(%rip), %rsi
	xorl	%eax, %eax
	movl	%r8d, (%rsp)
	movl	%r12d, expression_id(%rip)
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC96(%rip), %rsi
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC67(%rip), %rdi
	call	fwrite@PLT
	movl	(%rsp), %r8d
	leal	-38(%r8), %eax
	cmpl	$8, %eax
	ja	.L663
	leaq	.L665(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L665:
	.long	.L673-.L665
	.long	.L672-.L665
	.long	.L671-.L665
	.long	.L670-.L665
	.long	.L669-.L665
	.long	.L668-.L665
	.long	.L667-.L665
	.long	.L714-.L665
	.long	.L664-.L665
	.text
	.p2align 4,,10
	.p2align 3
.L545:
	movq	32(%r15), %rdx
	testq	%rdx, %rdx
	jne	.L931
	movl	16(%r15), %eax
	testl	%eax, %eax
	jne	.L932
	movl	12(%r15), %eax
	testl	%eax, %eax
	jne	.L933
	movl	20(%r15), %eax
	cmpl	$2, %eax
	je	.L934
	testq	%r12, %r12
	je	.L556
	movq	%r12, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movl	20(%r15), %eax
.L556:
	cmpl	$1, %eax
	je	.L553
.L531:
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
.L923:
	.cfi_restore_state
	movq	%r14, %rdi
	call	source_function
	movl	%eax, 8(%rsp)
	testl	%eax, %eax
	jne	.L606
	movq	16(%rsp), %rax
	movl	current_byteptr(%rip), %ecx
	cmpq	%rax, %r12
	movl	%ecx, 40(%rsp)
	sete	%al
	andb	39(%rsp), %al
	movb	%al, 48(%rsp)
	jne	.L607
	movq	24(%rsp), %rax
	testq	%rax, %rax
	je	.L608
	movl	(%rax,%r12,4), %eax
	testl	%eax, %eax
	je	.L608
	testl	%ecx, %ecx
	je	.L609
	.p2align 4
	.p2align 3
.L610:
	movq	%rbx, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC83(%rip), %rdi
	call	fwrite@PLT
.L640:
	movl	$1, %ebp
	jmp	.L606
.L558:
	xorl	%r12d, %r12d
	testl	%edx, %edx
	je	.L562
	.p2align 4
	.p2align 3
.L563:
	xorl	%r13d, %r13d
.L560:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r13, %rcx
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
.L931:
	.cfi_restore_state
	subq	$1, %rdx
	leaq	.LC63(%rip), %rsi
	jmp	.L906
	.p2align 4,,10
	.p2align 3
.L927:
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
.L660:
	leaq	.LC46(%rip), %rdx
	.p2align 4
	.p2align 3
.L661:
	leaq	.LC94(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$2, %edx
	leaq	.LC86(%rip), %rdi
	call	fwrite@PLT
	movq	64(%r15), %rsi
	jmp	.L908
	.p2align 4,,10
	.p2align 3
.L713:
	leaq	.LC47(%rip), %rdx
	jmp	.L661
	.p2align 4,,10
	.p2align 3
.L659:
	leaq	.LC43(%rip), %rdx
	jmp	.L661
	.p2align 4,,10
	.p2align 3
.L654:
	leaq	.LC48(%rip), %rdx
	jmp	.L661
	.p2align 4,,10
	.p2align 3
.L657:
	leaq	.LC45(%rip), %rdx
	jmp	.L661
	.p2align 4,,10
	.p2align 3
.L658:
	leaq	.LC44(%rip), %rdx
	jmp	.L661
	.p2align 4,,10
	.p2align 3
.L656:
	leaq	.LC49(%rip), %rdx
	jmp	.L661
.L664:
	leaq	.LC52(%rip), %rdx
	.p2align 4
	.p2align 3
.L666:
	movl	%r12d, %r8d
	movl	%r12d, %ecx
	leaq	.LC99(%rip), %rsi
.L910:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rdi
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
	jmp	fprintf@PLT
.L714:
	.cfi_restore_state
	leaq	.LC53(%rip), %rdx
	jmp	.L666
.L667:
	leaq	.LC54(%rip), %rdx
	jmp	.L666
.L670:
	leaq	.LC57(%rip), %rdx
	jmp	.L666
.L671:
	leaq	.LC58(%rip), %rdx
	jmp	.L666
.L672:
	leaq	.LC59(%rip), %rdx
	jmp	.L666
.L673:
	leaq	.LC51(%rip), %rdx
	jmp	.L666
.L668:
	leaq	.LC55(%rip), %rdx
	jmp	.L666
.L669:
	leaq	.LC56(%rip), %rdx
	jmp	.L666
	.p2align 4,,10
	.p2align 3
.L924:
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	jmp	.L641
	.p2align 4,,10
	.p2align 3
.L642:
	movl	$41, %edi
	movq	%rbx, %rsi
	call	fputc@PLT
	movl	32(%rsp), %edi
	testl	%edi, %edi
	je	.L644
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
.L644:
	movq	24(%rsp), %rax
	testq	%rax, %rax
	je	.L531
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
.L930:
	.cfi_restore_state
	leaq	CSWTCH.183(%rip), %rdx
	leaq	.LC95(%rip), %rsi
	movl	%r12d, expression_id(%rip)
	movl	(%rdx,%rax,4), %r15d
	movl	%r12d, %edx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC96(%rip), %rsi
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r15d, %edi
	call	tk_name@PLT
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%r12d, %r9d
	movl	%r12d, %ecx
	movq	%rax, %r8
	movl	%r12d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 48
	leaq	.LC97(%rip), %rsi
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
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L922:
	.cfi_restore_state
	movq	48(%rax), %r13
	testq	%r13, %r13
	je	.L558
	testl	%edx, %edx
	jne	.L563
	movq	%r13, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L560
	movl	g_strict(%rip), %eax
	movq	%r13, %r12
	testl	%eax, %eax
	jne	.L935
	.p2align 4
	.p2align 3
.L562:
	movq	%r12, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	jne	.L936
.L566:
	movq	48(%r15), %rax
	cmpl	$2, (%rax)
	movq	48(%rax), %r12
	jne	.L693
	movl	g_strict(%rip), %r14d
	leaq	.LC69(%rip), %rsi
	movq	%r12, %rdi
	movl	%r14d, 32(%rsp)
	call	strcmp@PLT
	movl	%eax, %r13d
	testl	%r14d, %r14d
	je	.L568
	testl	%eax, %eax
	je	.L569
.L903:
	movq	%r12, %r14
	jmp	.L567
	.p2align 4,,10
	.p2align 3
.L928:
	movq	%rdi, %rcx
	movl	$5, %edx
	movl	$1, %esi
	leaq	.LC89(%rip), %rdi
	jmp	.L911
	.p2align 4,,10
	.p2align 3
.L607:
	movl	40(%rsp), %r10d
	testl	%r10d, %r10d
	jne	.L610
.L609:
	leaq	.LC70(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testq	%r12, %r12
	jne	.L728
	testl	%eax, %eax
	je	.L676
.L728:
	movl	$1, 40(%rsp)
	xorl	%ebp, %ebp
	leaq	.LC72(%rip), %rdx
.L678:
	movq	%rdx, %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L921
.L632:
	leaq	.LC71(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L634
.L921:
	cmpq	$1, %r12
	je	.L937
.L634:
	movl	40(%rsp), %r8d
	testl	%r8d, %r8d
	jne	.L610
.L628:
	testl	%ebp, %ebp
	je	.L606
.L624:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC84(%rip), %rdi
	call	fwrite@PLT
	jmp	.L640
	.p2align 4,,10
	.p2align 3
.L929:
	movl	expression_id(%rip), %eax
	leaq	.LC90(%rip), %rsi
	leal	1(%rax), %r13d
	xorl	%eax, %eax
	movl	%r13d, %edx
	movl	%r13d, expression_id(%rip)
	call	fprintf@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r13d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC91(%rip), %rsi
	call	fprintf@PLT
	movq	64(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	cmpl	$53, %r12d
	movl	%r13d, %r8d
	movl	%r13d, %ecx
	leaq	.LC42(%rip), %rdx
	leaq	.LC41(%rip), %rax
	cmove	%rax, %rdx
	leaq	.LC92(%rip), %rsi
	jmp	.L910
	.p2align 4,,10
	.p2align 3
.L932:
	movq	%rbx, %rcx
	movl	$13, %edx
	movl	$1, %esi
	leaq	.LC34(%rip), %rdi
	jmp	.L907
.L925:
	movq	%rdi, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC88(%rip), %rdi
	jmp	.L911
.L653:
	movq	%rdi, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	56(%r15), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	movl	%r12d, %edi
	call	tk_name@PLT
	leaq	.LC93(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	64(%r15), %rsi
	jmp	.L908
.L926:
	movq	%rdi, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC33(%rip), %rdi
	jmp	.L911
.L933:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L938
	movq	%r12, %rdi
	call	b_library_function@PLT
	movq	%rbx, %rcx
	testl	%eax, %eax
	je	.L554
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
	jmp	.L907
.L608:
	leaq	.LC75(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L917
	leaq	.LC76(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L612
.L917:
	testq	%r12, %r12
	je	.L607
.L612:
	leaq	.LC77(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L613
	cmpq	$1, %r12
	jbe	.L939
.L615:
	leaq	.LC79(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	movl	%eax, %ebp
	testl	%eax, %eax
	jne	.L618
	cmpq	$2, %r12
	je	.L619
.L614:
	leaq	.LC81(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testq	%r12, %r12
	movl	%eax, %edx
	sete	%al
	movb	%al, 48(%rsp)
	testl	%edx, %edx
	jne	.L622
	testb	%al, %al
	jne	.L902
.L622:
	leaq	.LC82(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L626
	cmpq	$1, %r12
	jbe	.L902
.L625:
	leaq	.LC72(%rip), %rdx
	movq	%r14, %rdi
	movq	%rdx, %rsi
	movq	%rdx, 48(%rsp)
	call	strcmp@PLT
	leaq	.LC72(%rip), %rdx
	testl	%eax, %eax
	je	.L628
.L629:
	leaq	.LC71(%rip), %rsi
	movq	%r14, %rdi
	movq	%rdx, 48(%rsp)
	call	strcmp@PLT
	testq	%r12, %r12
	movl	40(%rsp), %r11d
	movq	48(%rsp), %rdx
	sete	%cl
	testl	%eax, %eax
	sete	%al
	andl	%ecx, %eax
	xorl	$1, %eax
	movzbl	%al, %eax
	andl	%eax, %ebp
	testl	%r11d, %r11d
	jne	.L628
	leaq	.LC70(%rip), %rsi
	movq	%r14, %rdi
	movq	%rdx, 48(%rsp)
	movb	%cl, 40(%rsp)
	call	strcmp@PLT
	movq	48(%rsp), %rdx
	testl	%eax, %eax
	jne	.L729
	movzbl	40(%rsp), %ecx
	testb	%cl, %cl
	je	.L729
.L635:
	testl	%ebp, %ebp
	jne	.L638
	movl	$0, 8(%rsp)
.L637:
	movq	%rbx, %rcx
	movl	$32, %edx
	movl	$1, %esi
	leaq	.LC85(%rip), %rdi
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
	movl	8(%rsp), %eax
	orl	%eax, %ebp
	jmp	.L675
.L568:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	je	.L570
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movb	$0, 39(%rsp)
	movq	64(%r15), %rdx
	movq	$0, 16(%rsp)
.L571:
	testq	%rdx, %rdx
	je	.L940
	.p2align 4
	.p2align 3
.L703:
	movq	$0, 24(%rsp)
	movq	%r12, %r14
	jmp	.L583
.L663:
	leaq	.LC50(%rip), %rcx
	cmpl	$21, %r8d
	je	.L674
	movl	%r8d, %edi
	call	tk_name@PLT
	movq	%rax, %rcx
.L674:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%r12d, %r8d
	movl	%r12d, %edx
	movq	%rbx, %rdi
	leaq	.LC98(%rip), %rsi
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 48
	xorl	%eax, %eax
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
	jmp	fprintf@PLT
.L938:
	.cfi_restore_state
	testq	%r12, %r12
	je	.L553
	movq	%r12, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L553:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	jmp	.L907
.L569:
	movq	%r12, %rdi
	call	source_function
	movl	%eax, 32(%rsp)
	testl	%eax, %eax
	jne	.L903
.L698:
	movq	$0, 16(%rsp)
	movq	%r12, %rsi
	movl	$1, %r13d
.L575:
	movq	%rbx, %rdi
	call	emit_function_name
	movq	%rbx, %rsi
	movl	$40, %edi
	call	fputc@PLT
	movq	64(%r15), %rdx
	movq	16(%rsp), %rcx
	cmpq	%rdx, %rcx
	setb	%al
	andb	%r13b, %al
	movb	%al, 39(%rsp)
	je	.L700
	movq	56(%r15), %rax
	movq	(%rax,%rcx,8), %rax
	testq	%rax, %rax
	je	.L703
	cmpl	$1, (%rax)
	jne	.L703
	movq	%rdx, %rdi
	movl	$4, %esi
	movq	%rdx, (%rsp)
	movq	48(%rax), %r13
	call	calloc@PLT
	movq	(%rsp), %rdx
	testq	%rax, %rax
	movq	%rax, 24(%rsp)
	je	.L703
	movq	16(%rsp), %rax
	leaq	1(%rax), %rsi
	movzbl	0(%r13), %eax
	testb	%al, %al
	je	.L585
	movq	%r12, (%rsp)
	xorl	%r14d, %r14d
	movq	%rbx, 8(%rsp)
	movq	%rsi, %rbx
	movq	%rbp, 40(%rsp)
	movq	%r13, %rbp
	movq	%rdx, %r13
	.p2align 4
	.p2align 3
.L604:
	cmpb	$37, %al
	jne	.L897
	addq	$1, %r14
	movzbl	0(%rbp,%r14), %r12d
	cmpb	$37, %r12b
	je	.L897
	testb	%r12b, %r12b
	jne	.L587
	jmp	.L892
	.p2align 4,,10
	.p2align 3
.L589:
	addq	$1, %r14
	movzbl	0(%rbp,%r14), %r12d
	testb	%r12b, %r12b
	je	.L588
.L587:
	movsbl	%r12b, %esi
	leaq	.LC74(%rip), %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L589
	cmpb	$42, %r12b
	jne	.L588
	cmpq	%r13, %rbx
	adcq	$0, %rbx
	addq	$1, %r14
	movzbl	0(%rbp,%r14), %edx
.L593:
	cmpb	$46, %dl
	je	.L941
.L595:
	cmpb	$104, %dl
	je	.L942
	cmpb	$108, %dl
	je	.L943
	testb	%dl, %dl
	je	.L892
	leaq	1(%r14), %rax
	cmpb	$115, %dl
	jne	.L601
	cmpq	%r13, %rbx
	jnb	.L601
	movq	24(%rsp), %rcx
	movl	$1, (%rcx,%rbx,4)
	.p2align 4
	.p2align 3
.L601:
	addq	$1, %rbx
.L586:
	movq	%rax, %r14
	movzbl	0(%rbp,%rax), %eax
	testb	%al, %al
	jne	.L604
.L892:
	movq	(%rsp), %r12
	movq	8(%rsp), %rbx
	movq	%r13, %rdx
	movq	40(%rsp), %rbp
.L585:
	movq	%r12, %r14
	jmp	.L583
	.p2align 4,,10
	.p2align 3
.L897:
	leaq	1(%r14), %rax
	jmp	.L586
.L588:
	movzbl	0(%rbp,%r14), %edx
	testb	%dl, %dl
	movb	%dl, 48(%rsp)
	je	.L892
	call	__ctype_b_loc@PLT
	movzbl	48(%rsp), %edx
	movq	(%rax), %rax
	jmp	.L591
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L594:
	addq	$1, %r14
	movzbl	0(%rbp,%r14), %edx
	testb	%dl, %dl
	je	.L892
.L591:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L594
	movzbl	0(%rbp,%r14), %edx
	jmp	.L593
.L942:
	cmpb	$104, 1(%rbp,%r14)
	leaq	1(%r14), %rax
	jne	.L601
.L702:
	leaq	2(%r14), %rax
	jmp	.L601
.L941:
	movzbl	1(%rbp,%r14), %edx
	leaq	1(%r14), %rdi
	movq	%rdi, 48(%rsp)
	cmpb	$42, %dl
	jne	.L944
	cmpq	%r13, %rbx
	adcq	$0, %rbx
	addq	$2, %r14
	movzbl	0(%rbp,%r14), %edx
	jmp	.L595
.L943:
	cmpb	$108, 1(%rbp,%r14)
	leaq	1(%r14), %rax
	jne	.L601
	jmp	.L702
.L936:
	movq	%r12, %rdi
	call	source_function
	testl	%eax, %eax
	jne	.L566
	movl	expression_id(%rip), %eax
	leaq	.LC66(%rip), %rsi
	movq	%rbx, %rdi
	leal	1(%rax), %r12d
	xorl	%eax, %eax
	movl	%r12d, %edx
	movl	%r12d, expression_id(%rip)
	call	fprintf@PLT
	movq	%r13, %rsi
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
	movl	%r12d, %r8d
	call	emit_b_call
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC68(%rip), %rdi
	jmp	.L907
.L554:
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC65(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rsi
	movq	%rbx, %rdi
	call	emit_function_name
	jmp	.L909
.L570:
	leaq	.LC70(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L573
	leaq	.LC71(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L573
	leaq	.LC72(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L573
	testl	%r13d, %r13d
	je	.L698
	leaq	.LC104(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, 32(%rsp)
	testl	%eax, %eax
	je	.L726
	leaq	.LC105(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, 32(%rsp)
	testl	%eax, %eax
	je	.L726
	leaq	.LC103(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, 32(%rsp)
	testl	%eax, %eax
	je	.L726
	xorl	%edx, %edx
	movl	%edx, 32(%rsp)
.L684:
	leaq	.LC102(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L717
	movq	$2, 16(%rsp)
	movl	$1, %r13d
.L683:
	cmpl	$0, 32(%rsp)
	je	.L945
.L577:
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$6, %edx
	leaq	.LC73(%rip), %rdi
	call	fwrite@PLT
	movq	48(%r15), %rax
	movl	$1, 32(%rsp)
	movq	48(%rax), %rsi
	jmp	.L575
.L934:
	movq	%r12, %rdi
	call	get_mangled_name
	leaq	.LC35(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L906
.L573:
	testl	%r13d, %r13d
	je	.L946
	leaq	.LC104(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L725
	leaq	.LC105(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L947
.L725:
	movq	$1, 16(%rsp)
	movl	$1, %r13d
	jmp	.L577
.L613:
	leaq	.LC78(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L615
	cmpq	$1, %r12
	jne	.L615
	leaq	.LC82(%rip), %rsi
	movq	%r14, %rdi
	movl	$1, %ebp
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L626
	cmpl	$0, 40(%rsp)
	jne	.L624
	leaq	.LC72(%rip), %rdx
	movq	%r14, %rdi
	movq	%rdx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L638
	xorl	%eax, %eax
	movl	$1, %ebp
	movl	%eax, 40(%rsp)
	jmp	.L632
	.p2align 4,,10
	.p2align 3
.L944:
	testb	%dl, %dl
	movb	%dl, 56(%rsp)
	je	.L892
	call	__ctype_b_loc@PLT
	movzbl	56(%rsp), %edx
	movq	48(%rsp), %rdi
	movq	(%rax), %rax
	jmp	.L597
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L599:
	addq	$1, %rdi
	movzbl	0(%rbp,%rdi), %edx
	testb	%dl, %dl
	je	.L892
.L597:
	testb	$8, 1(%rax,%rdx,2)
	jne	.L599
	movzbl	0(%rbp,%rdi), %edx
	movq	%rdi, %r14
	jmp	.L595
.L618:
	leaq	.LC80(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L727
	cmpq	$2, %r12
	jne	.L727
.L619:
	leaq	.LC82(%rip), %rsi
	movq	%r14, %rdi
	movl	$1, %ebp
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L625
.L626:
	leaq	.LC72(%rip), %rdx
	movq	%r14, %rdi
	movq	%rdx, %rsi
	movq	%rdx, 56(%rsp)
	call	strcmp@PLT
	leaq	.LC72(%rip), %rdx
	testl	%eax, %eax
	jne	.L629
	movzbl	48(%rsp), %eax
	orl	%eax, %ebp
	cmpl	$0, 40(%rsp)
	jne	.L628
	leaq	.LC70(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L689
	cmpb	$0, 48(%rsp)
	jne	.L635
.L689:
	cmpq	$1, %r12
	jne	.L628
	jmp	.L635
	.p2align 4,,10
	.p2align 3
.L727:
	xorl	%ebp, %ebp
	jmp	.L614
.L937:
	movl	40(%rsp), %r9d
	testl	%r9d, %r9d
	je	.L635
	movq	%rbx, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC83(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 8(%rsp)
	jmp	.L637
.L902:
	movl	40(%rsp), %ebp
	testl	%ebp, %ebp
	jne	.L624
	leaq	.LC70(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testb	$1, %r12b
	jne	.L730
	testl	%eax, %eax
	je	.L638
.L730:
	xorl	%ecx, %ecx
	movl	$1, %ebp
	leaq	.LC72(%rip), %rdx
	movl	%ecx, 40(%rsp)
	jmp	.L678
.L935:
	movq	%r13, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	je	.L560
	cmpl	$0, 24(%r15)
	jne	.L563
	movq	48(%r15), %rax
	cmpl	$2, (%rax)
	movq	48(%rax), %r12
	jne	.L693
	jmp	.L562
.L717:
	movq	$0, 16(%rsp)
	xorl	%r13d, %r13d
	jmp	.L683
.L638:
	movq	%rbx, %rcx
	movl	$7, %edx
	movl	$1, %esi
	movl	$1, %ebp
	leaq	.LC84(%rip), %rdi
	call	fwrite@PLT
	jmp	.L637
.L946:
	xorl	%eax, %eax
	movl	$1, %r13d
	movq	%rax, 16(%rsp)
	jmp	.L577
.L939:
	movl	$1, %ebp
	jmp	.L614
.L676:
	movq	%rbx, %rcx
	movl	$9, %edx
	movl	$1, %esi
	xorl	%ebp, %ebp
	leaq	.LC83(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 8(%rsp)
	jmp	.L637
.L947:
	leaq	.LC103(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L725
	movl	$1, 32(%rsp)
	jmp	.L684
.L726:
	movq	$1, 16(%rsp)
	movq	%r12, %rsi
	movl	$1, %r13d
	jmp	.L575
.L945:
	movq	%r12, %rsi
	jmp	.L575
.L700:
	movb	%r13b, 39(%rsp)
	jmp	.L571
.L894:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L940:
	.cfi_def_cfa_offset 128
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%rbx, %rsi
	movl	$41, %edi
	call	fputc@PLT
	cmpl	$0, 32(%rsp)
	je	.L531
	jmp	.L909
.L729:
	xorl	%esi, %esi
	movl	%esi, 40(%rsp)
	jmp	.L678
	.cfi_endproc
.LFE50:
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
.LFB49:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rcx, %r15
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdx, %r14
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
	leaq	.LC106(%rip), %rsi
	movl	%r8d, 12(%rsp)
	leal	1(%rax), %ebp
	xorl	%eax, %eax
	movl	%ebp, %edx
	movl	%ebp, expression_id(%rip)
	call	fprintf@PLT
	movl	12(%rsp), %r8d
	testl	%r8d, %r8d
	jne	.L959
	testq	%r15, %r15
	je	.L951
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
.L950:
	testq	%r12, %r12
	movl	$1, %ecx
	movl	%ebp, %edx
	movq	%rbx, %rdi
	cmovne	%r12, %rcx
	leaq	.LC108(%rip), %rsi
	xorl	%eax, %eax
	xorl	%r15d, %r15d
	call	fprintf@PLT
	testq	%r12, %r12
	jne	.L952
	jmp	.L960
	.p2align 4,,10
	.p2align 3
.L961:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC86(%rip), %rdi
	call	fwrite@PLT
.L952:
	movq	56(%r13), %rax
	movq	%r14, %rdx
	movq	%rbx, %rdi
	movq	(%rax,%r15,8), %rsi
	addq	$1, %r15
	call	emit_expr
	cmpq	%r15, %r12
	jne	.L961
	subq	$8, %rsp
	.cfi_def_cfa_offset 88
	movl	%ebp, %r9d
	movq	%r12, %r8
	movl	%ebp, %ecx
	pushq	%rbp
	.cfi_def_cfa_offset 96
	movl	%ebp, %edx
	leaq	.LC109(%rip), %rsi
	movq	%rbx, %rdi
	pushq	%rbp
	.cfi_def_cfa_offset 104
	xorl	%eax, %eax
	xorl	%r13d, %r13d
	leaq	.LC110(%rip), %r14
	pushq	%r12
	.cfi_def_cfa_offset 112
	leaq	.LC86(%rip), %r15
	pushq	%rbp
	.cfi_def_cfa_offset 120
	pushq	%rbp
	.cfi_def_cfa_offset 128
	pushq	%rbp
	.cfi_def_cfa_offset 136
	pushq	%rbp
	.cfi_def_cfa_offset 144
	call	fprintf@PLT
	addq	$64, %rsp
	.cfi_def_cfa_offset 80
	jmp	.L955
	.p2align 4,,10
	.p2align 3
.L962:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
.L955:
	movq	%r13, %rcx
	movl	%ebp, %edx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	addq	$1, %r13
	call	fprintf@PLT
	cmpq	%r13, %r12
	jne	.L962
.L953:
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
.L951:
	.cfi_restore_state
	movq	48(%r13), %rsi
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	emit_expr
	jmp	.L950
	.p2align 4,,10
	.p2align 3
.L960:
	movq	%rbx, %rsi
	movl	$48, %edi
	call	fputc@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 88
	movl	%ebp, %r9d
	xorl	%r8d, %r8d
	pushq	%rbp
	.cfi_def_cfa_offset 96
	movl	%ebp, %ecx
	movl	%ebp, %edx
	leaq	.LC109(%rip), %rsi
	pushq	%rbp
	.cfi_def_cfa_offset 104
	movq	%rbx, %rdi
	xorl	%eax, %eax
	pushq	$0
	.cfi_def_cfa_offset 112
	pushq	%rbp
	.cfi_def_cfa_offset 120
	pushq	%rbp
	.cfi_def_cfa_offset 128
	pushq	%rbp
	.cfi_def_cfa_offset 136
	pushq	%rbp
	.cfi_def_cfa_offset 144
	call	fprintf@PLT
	addq	$64, %rsp
	.cfi_def_cfa_offset 80
	jmp	.L953
	.p2align 4,,10
	.p2align 3
.L959:
	movl	%r8d, %edx
	leaq	.LC107(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L950
	.cfi_endproc
.LFE49:
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
	je	.L964
	testl	%r13d, %r13d
	jle	.L965
	xorl	%r12d, %r12d
	leaq	.LC26(%rip), %r14
	.p2align 4
	.p2align 3
.L966:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%r12d, %r13d
	jne	.L966
.L965:
	movq	%r15, %rdx
	leaq	.LC112(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	8(%rbx), %rsi
	movq	8(%rsp), %rdx
	movq	%rbp, %rdi
	call	emit_expr
	movq	%rbp, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC113(%rip), %rdi
	call	fwrite@PLT
.L964:
	testl	%r13d, %r13d
	jle	.L967
	xorl	%ebx, %ebx
	leaq	.LC26(%rip), %r14
	.p2align 4
	.p2align 3
.L968:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %r12d
	leal	1(%rbx), %ebx
	cmpl	%ebx, %r13d
	jne	.L968
	xorl	%eax, %eax
	movq	%r15, %rdx
	leaq	.LC114(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	je	.L979
.L963:
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
.L979:
	.cfi_restore_state
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L973:
	movq	%rbp, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %r12d
	jne	.L973
.L970:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r15, %rcx
	movq	%r15, %rdx
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC115(%rip), %rsi
	popq	%rbp
	.cfi_def_cfa_offset 40
	xorl	%eax, %eax
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
.L967:
	.cfi_restore_state
	xorl	%eax, %eax
	movq	%r15, %rdx
	leaq	.LC114(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L963
	jmp	.L970
	.cfi_endproc
.LFE59:
	.size	emit_auto_storage, .-emit_auto_storage
	.p2align 4
	.globl	emit_ival_expr
	.type	emit_ival_expr, @function
emit_ival_expr:
.LFB51:
	.cfi_startproc
	cmpl	$2, (%rsi)
	je	.L982
	jmp	emit_expr
	.p2align 4,,10
	.p2align 3
.L982:
	jmp	emit_ival_expr.part.0
	.cfi_endproc
.LFE51:
	.size	emit_ival_expr, .-emit_ival_expr
	.p2align 4
	.globl	init_list_length
	.type	init_list_length, @function
init_list_length:
.LFB52:
	.cfi_startproc
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L983
	cmpl	$1, (%rdi)
	je	.L987
.L983:
	ret
	.p2align 4,,10
	.p2align 3
.L987:
	movq	24(%rdi), %rax
	ret
	.cfi_endproc
.LFE52:
	.size	init_list_length, .-init_list_length
	.p2align 4
	.globl	try_eval_const_expr
	.type	try_eval_const_expr, @function
try_eval_const_expr:
.LFB53:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L1024
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
	je	.L990
	ja	.L991
	testl	%eax, %eax
	je	.L992
	cmpl	$5, %eax
	jne	.L1000
	movq	56(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L988
	movl	48(%rbx), %eax
	cmpl	$31, %eax
	je	.L996
	cmpl	$35, %eax
	je	.L997
	.p2align 4
	.p2align 3
.L1000:
	xorl	%eax, %eax
.L988:
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
.L991:
	.cfi_restore_state
	cmpl	$10, %eax
	jne	.L1000
	movq	48(%rdi), %rdi
	leaq	8(%rsp), %rsi
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L988
	movq	56(%rbx), %rdi
	movq	%rbp, %rsi
	call	try_eval_const_expr
	jmp	.L988
	.p2align 4,,10
	.p2align 3
.L1024:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L992:
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	movq	48(%rdi), %rax
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
.L990:
	.cfi_restore_state
	movq	56(%rdi), %rdi
	movq	%rsp, %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1000
	movq	64(%rbx), %rdi
	leaq	8(%rsp), %rsi
	call	try_eval_const_expr
	testl	%eax, %eax
	je	.L1000
	movl	48(%rbx), %eax
	subl	$22, %eax
	cmpl	$33, %eax
	ja	.L1000
	leaq	.L1003(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1003:
	.long	.L1016-.L1003
	.long	.L1015-.L1003
	.long	.L1014-.L1003
	.long	.L1013-.L1003
	.long	.L1012-.L1003
	.long	.L1011-.L1003
	.long	.L1000-.L1003
	.long	.L1000-.L1003
	.long	.L1010-.L1003
	.long	.L1009-.L1003
	.long	.L1008-.L1003
	.long	.L1007-.L1003
	.long	.L1006-.L1003
	.long	.L1000-.L1003
	.long	.L1000-.L1003
	.long	.L1000-.L1003
	.long	.L1000-.L1003
	.long	.L1000-.L1003
	.long	.L1000-.L1003
	.long	.L1000-.L1003
	.long	.L1000-.L1003
	.long	.L1000-.L1003
	.long	.L1000-.L1003
	.long	.L1000-.L1003
	.long	.L1000-.L1003
	.long	.L1000-.L1003
	.long	.L1000-.L1003
	.long	.L1000-.L1003
	.long	.L1000-.L1003
	.long	.L1000-.L1003
	.long	.L1000-.L1003
	.long	.L1005-.L1003
	.long	.L1004-.L1003
	.long	.L1002-.L1003
	.text
	.p2align 4,,10
	.p2align 3
.L997:
	xorl	%eax, %eax
	cmpq	$0, 8(%rsp)
	sete	%al
	movq	%rax, 0(%rbp)
.L1018:
	movl	$1, %eax
	jmp	.L988
.L1002:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1018
.L1004:
	movq	(%rsp), %rax
	orq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1018
.L1005:
	movq	(%rsp), %rax
	andq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1018
.L1006:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L1000
	movq	(%rsp), %rax
	cmpq	$-1, %rcx
	jne	.L1028
	movabsq	$-9223372036854775808, %rdx
	cmpq	%rdx, %rax
	je	.L1026
.L1028:
	cqto
	idivq	%rcx
.L1021:
	movq	%rdx, 0(%rbp)
	jmp	.L1018
.L1007:
	movq	8(%rsp), %rcx
	testq	%rcx, %rcx
	je	.L1000
	movq	(%rsp), %rdx
	cmpq	$-1, %rcx
	jne	.L1027
	movabsq	$-9223372036854775808, %rax
	cmpq	%rax, %rdx
	je	.L1049
.L1027:
	movq	%rdx, %rax
	cqto
	idivq	%rcx
.L1049:
	movq	%rax, 0(%rbp)
	jmp	.L1018
.L1008:
	movq	(%rsp), %rax
	imulq	8(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1018
.L1009:
	movq	(%rsp), %rax
	subq	8(%rsp), %rax
	jmp	.L1049
.L1010:
	movq	8(%rsp), %rax
	addq	(%rsp), %rax
	movq	%rax, 0(%rbp)
	jmp	.L1018
.L1011:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setge	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1018
.L1012:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setg	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1018
.L1013:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setle	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1018
.L1014:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setl	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1018
.L1015:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	setne	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1018
.L1016:
	movq	8(%rsp), %rax
	cmpq	%rax, (%rsp)
	sete	%al
	movzbl	%al, %eax
	movq	%rax, 0(%rbp)
	jmp	.L1018
	.p2align 4,,10
	.p2align 3
.L996:
	movq	8(%rsp), %rax
	negq	%rax
	movq	%rax, 0(%rbp)
	jmp	.L1018
.L1026:
	xorl	%edx, %edx
	jmp	.L1021
	.cfi_endproc
.LFE53:
	.size	try_eval_const_expr, .-try_eval_const_expr
	.p2align 4
	.globl	nested_base_len
	.type	nested_base_len, @function
nested_base_len:
.LFB54:
	.cfi_startproc
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L1052
	cmpl	$1, (%rdi)
	je	.L1056
.L1052:
	ret
	.p2align 4,,10
	.p2align 3
.L1056:
	movq	24(%rdi), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmove	%rdx, %rax
	ret
	.cfi_endproc
.LFE54:
	.size	nested_base_len, .-nested_base_len
	.p2align 4
	.globl	edge_words_total
	.type	edge_words_total, @function
edge_words_total:
.LFB55:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L1057
	cmpl	$1, (%rdi)
	je	.L1062
.L1057:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L1062:
	movq	24(%rdi), %rsi
	movq	16(%rdi), %rdi
	jmp	edge_words_total.part.0.isra.0
	.cfi_endproc
.LFE55:
	.size	edge_words_total, .-edge_words_total
	.p2align 4
	.globl	edge_tail_words_top
	.type	edge_tail_words_top, @function
edge_tail_words_top:
.LFB56:
	.cfi_startproc
	xorl	%r9d, %r9d
	testq	%rdi, %rdi
	je	.L1075
	cmpl	$1, (%rdi)
	jne	.L1075
	movq	24(%rdi), %rcx
	movq	16(%rdi), %r8
	testq	%rcx, %rcx
	je	.L1075
	xorl	%edx, %edx
	jmp	.L1076
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1078:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L1075
.L1076:
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L1078
	cmpl	$1, (%rax)
	jne	.L1078
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
.L1079:
	movq	24(%rax), %rsi
	movq	16(%rax), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, %r9
.L1065:
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	je	.L1082
	movq	(%r8,%rdx,8), %rax
	testq	%rax, %rax
	je	.L1065
	cmpl	$1, (%rax)
	jne	.L1065
	jmp	.L1079
	.p2align 4,,10
	.p2align 3
.L1075:
	.cfi_def_cfa_offset 8
	movq	%r9, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1082:
	.cfi_def_cfa_offset 16
	movq	%r9, %rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE56:
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
	je	.L1084
	cmpl	$1, (%rcx)
	movq	%rcx, %r15
	jne	.L1084
	cmpq	$0, 24(%rcx)
	je	.L1084
	movq	%rsi, (%rsp)
	movq	%rdi, %rbx
	movl	%r9d, %ebp
	xorl	%r13d, %r13d
	movq	%r8, 8(%rsp)
.L1097:
	movq	16(%r15), %rax
	movq	(%rax,%r13,8), %r10
	testq	%r10, %r10
	je	.L1092
	movl	(%r10), %eax
	testl	%eax, %eax
	je	.L1116
	cmpl	$1, %eax
	je	.L1117
.L1092:
	addq	$1, %r13
	addq	$1, %r12
	cmpq	24(%r15), %r13
	jb	.L1097
	movq	8(%rsp), %rdx
.L1084:
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
.L1116:
	.cfi_restore_state
	xorl	%r14d, %r14d
	testl	%ebp, %ebp
	jle	.L1090
	movq	%r12, 16(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L1087:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC26(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1087
	movq	16(%rsp), %r12
	movq	%r14, %r10
.L1090:
	movq	(%rsp), %rdx
	leaq	.LC116(%rip), %rsi
	xorl	%eax, %eax
	movq	%r12, %rcx
	movq	%rbx, %rdi
	movq	%r10, 16(%rsp)
	call	fprintf@PLT
	movq	16(%rsp), %r10
	movq	16(%r10), %rsi
	cmpl	$2, (%rsi)
	je	.L1118
	movq	96(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L1091:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1092
	.p2align 4,,10
	.p2align 3
.L1117:
	movq	24(%r10), %rax
	movl	$1, %edx
	testq	%rax, %rax
	cmovne	%rax, %rdx
	xorl	%r14d, %r14d
	movq	%rdx, 16(%rsp)
	testl	%ebp, %ebp
	jle	.L1096
	movq	%r12, 24(%rsp)
	movl	%r14d, %r12d
	movq	%r10, %r14
	.p2align 4
	.p2align 3
.L1093:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r12d
	leaq	.LC26(%rip), %rdi
	call	fwrite@PLT
	cmpl	%r12d, %ebp
	jne	.L1093
	movq	24(%rsp), %r12
	movq	%r14, %r10
.L1096:
	movq	8(%rsp), %r14
	movq	(%rsp), %r8
	movq	%r12, %rcx
	movq	%rbx, %rdi
	leaq	.LC118(%rip), %rsi
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
	jne	.L1094
	movq	24(%r10), %rsi
	movq	16(%r10), %rdi
	call	edge_words_total.part.0.isra.0
	addq	%rax, 8(%rsp)
.L1094:
	movq	8(%rsp), %rax
	cmpq	%rdx, %rax
	cmovnb	%rax, %rdx
	movq	%rdx, 8(%rsp)
	jmp	.L1092
	.p2align 4,,10
	.p2align 3
.L1118:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1091
	.cfi_endproc
.LFE57:
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
.LFB66:
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
	je	.L1184
.L1120:
	movq	%rbx, %rcx
	movl	$75, %edx
	movl	$1, %esi
	xorl	%ebp, %ebp
	leaq	.LC123(%rip), %rdi
	leaq	.LC125(%rip), %r15
	call	fwrite@PLT
	cmpq	$0, 8(%r14)
	leaq	.LC126(%rip), %r13
	jne	.L1127
	jmp	.L1133
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1130:
	movq	8(%r14), %rax
	addq	$1, %rbp
	cmpq	%rax, %rbp
	jnb	.L1185
.L1127:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %r12
	cmpl	$1, (%r12)
	jne	.L1130
	movq	%r15, %rdi
	movq	%rbx, %rcx
	movl	$4, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r12), %rax
	movq	(%rax), %rdi
	testq	%rdi, %rdi
	je	.L1131
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1131:
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
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC127(%rip), %rsi
	call	fprintf@PLT
	movq	8(%r12), %rax
	movq	%rbx, %rdi
	movq	(%rax), %rsi
	call	emit_function_body_name
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC128(%rip), %rsi
	call	fprintf@PLT
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC129(%rip), %rsi
	call	fprintf@PLT
	movq	8(%r12), %rax
	movq	%rbx, %rdi
	movq	(%rax), %rsi
	call	emit_c_string
	leaq	.LC86(%rip), %rdi
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	8(%r12), %rax
	movq	(%rax), %rdi
	testq	%rdi, %rdi
	je	.L1132
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1132:
	movq	%rbp, %rdx
	leaq	.LC130(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	8(%r14), %rax
	addq	$1, %rbp
	cmpq	%rax, %rbp
	jb	.L1127
.L1185:
	testq	%rax, %rax
	je	.L1133
	xorl	%r15d, %r15d
	leaq	.LC86(%rip), %r13
	leaq	.LC132(%rip), %r12
	.p2align 4
	.p2align 3
.L1136:
	movq	(%r14), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$2, (%rax)
	jne	.L1134
	movq	8(%rax), %rax
	movl	4(%rax), %edi
	testl	%edi, %edi
	jne	.L1134
	movq	16(%rax), %rbp
	movq	%r15, %rdx
	leaq	.LC131(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	emit_c_string
	movq	%rbx, %rcx
	movl	$2, %edx
	movq	%r13, %rdi
	movl	$1, %esi
	call	fwrite@PLT
	testq	%rbp, %rbp
	je	.L1135
	movq	%rbp, %rdi
	call	get_mangled_name
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
.L1135:
	movq	%r15, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L1134:
	addq	$1, %r15
	cmpq	8(%r14), %r15
	jb	.L1136
.L1133:
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
	jne	.L1128
	jmp	.L1129
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1138:
	addq	$1, %rbp
	cmpq	8(%r14), %rbp
	jnb	.L1129
.L1128:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$2, (%rax)
	jne	.L1138
	movq	8(%rax), %r12
	movq	16(%r12), %rdi
	call	get_mangled_name
	cmpl	$2, 24(%r12)
	movq	56(%r12), %r13
	movq	%rax, %r15
	je	.L1186
	testq	%r13, %r13
	je	.L1138
	movl	0(%r13), %eax
	cmpl	$1, %eax
	je	.L1187
	testl	%eax, %eax
	jne	.L1138
	leaq	.LC136(%rip), %rsi
	movq	%r15, %rdx
	movq	%rbx, %rdi
	call	fprintf@PLT
	movq	16(%r13), %rsi
	cmpl	$2, (%rsi)
	je	.L1188
	movq	8(%rsp), %rdx
	movq	%rbx, %rdi
	call	emit_expr
.L1146:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addq	$1, %rbp
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	cmpq	8(%r14), %rbp
	jb	.L1128
.L1129:
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
.L1186:
	.cfi_restore_state
	movq	%rax, %r8
	movq	%rax, %rcx
	movq	%rax, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC134(%rip), %rsi
	call	fprintf@PLT
	testq	%r13, %r13
	je	.L1138
	cmpl	$1, 0(%r13)
	jne	.L1138
	movq	%r15, %rsi
	leaq	.LC135(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	xorl	%r8d, %r8d
	movq	%rax, %rsi
	movq	56(%r12), %rax
	testq	%rax, %rax
	je	.L1141
	cmpl	$1, (%rax)
	je	.L1189
.L1141:
	cmpq	$0, 32(%r12)
	je	.L1142
	movq	48(%r12), %rax
	movq	%r8, %rdx
	cmpq	%rax, %r8
	cmovb	%rax, %r8
	testq	%rax, %rax
	cmovle	%rdx, %r8
.L1142:
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
	jmp	.L1138
	.p2align 4,,10
	.p2align 3
.L1187:
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
	jmp	.L1138
	.p2align 4,,10
	.p2align 3
.L1184:
	movq	%rdi, %rcx
	movl	$75, %edx
	movl	$1, %esi
	xorl	%ebp, %ebp
	leaq	.LC119(%rip), %rdi
	leaq	.LC121(%rip), %r12
	call	fwrite@PLT
	cmpq	$0, 8(%r14)
	jne	.L1121
	.p2align 4
	.p2align 3
.L1126:
	leaq	.LC120(%rip), %rax
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, (%rsp)
	call	fwrite@PLT
	jmp	.L1120
	.p2align 4,,10
	.p2align 3
.L1192:
	movq	8(%rdx), %r15
	movq	16(%r15), %rdi
	call	get_mangled_name
	movq	%r12, %rsi
	movq	%rbx, %rdi
	movq	%rax, %rcx
	movq	%rax, %rdx
	movq	%rax, %r13
	xorl	%eax, %eax
	call	fprintf@PLT
	cmpl	$2, 24(%r15)
	je	.L1190
.L1123:
	addq	$1, %rbp
	cmpq	8(%r14), %rbp
	jnb	.L1126
.L1121:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %rdx
	movl	(%rdx), %eax
	cmpl	$1, %eax
	je	.L1191
	cmpl	$2, %eax
	jne	.L1123
	jmp	.L1192
	.p2align 4,,10
	.p2align 3
.L1190:
	movq	%r13, %rcx
	movq	%r13, %rdx
	leaq	.LC122(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1123
	.p2align 4,,10
	.p2align 3
.L1191:
	movq	8(%rdx), %rax
	movq	(%rax), %rdi
	call	get_mangled_name
	movq	%r12, %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1123
	.p2align 4,,10
	.p2align 3
.L1188:
	movq	%rbx, %rdi
	call	emit_ival_expr.part.0
	jmp	.L1146
.L1189:
	movq	24(%rax), %r8
	jmp	.L1141
	.cfi_endproc
.LFE66:
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
	.string	"continue outside loop"
.LC151:
	.string	"goto %s;\n"
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
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	leaq	.L1197(%rip), %r12
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
.L1320:
	movl	g_no_line(%rip), %edi
	testl	%edi, %edi
	jne	.L1194
	cmpb	$0, 24(%rsp)
	jne	.L1488
.L1194:
	cmpl	$12, (%rbx)
	ja	.L1193
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1197:
	.long	.L1208-.L1197
	.long	.L1207-.L1197
	.long	.L1206-.L1197
	.long	.L1205-.L1197
	.long	.L1204-.L1197
	.long	.L1203-.L1197
	.long	.L1202-.L1197
	.long	.L1193-.L1197
	.long	.L1201-.L1197
	.long	.L1200-.L1197
	.long	.L1199-.L1197
	.long	.L1198-.L1197
	.long	.L1196-.L1197
	.text
	.p2align 4,,10
	.p2align 3
.L1488:
	movl	4(%rbx), %edx
	movq	16(%rsp), %rcx
	movq	%r13, %rdi
	xorl	%eax, %eax
	leaq	.LC27(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1194
	.p2align 4,,10
	.p2align 3
.L1196:
	movl	g_switch_id(%rip), %eax
	xorl	%r12d, %r12d
	leaq	112(%rsp), %rbp
	leaq	.LC154(%rip), %r15
	addl	$1, %eax
	movl	%eax, 32(%rsp)
	movl	%eax, g_switch_id(%rip)
	xorl	%eax, %eax
	call	vec_new@PLT
	movq	%rax, %r14
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	call	vec_new@PLT
	movq	24(%rbx), %rdi
	movq	%r14, %rsi
	movq	%rax, 40(%rsp)
	call	collect_cases
	cmpq	$0, 8(%r14)
	je	.L1275
	movq	%rbx, 56(%rsp)
	movq	24(%rsp), %r14
	movq	%r13, 48(%rsp)
	movq	%r12, %r13
	movq	40(%rsp), %r12
	.p2align 4
	.p2align 3
.L1272:
	movl	$16, %edi
	call	xmalloc@PLT
	movl	32(%rsp), %ecx
	movq	%r13, %r8
	movq	%r15, %rdx
	movq	%rax, %rbx
	movq	(%r14), %rax
	movl	$128, %esi
	movq	%rbp, %rdi
	movq	(%rax,%r13,8), %rax
	addq	$1, %r13
	movq	%rax, (%rbx)
	xorl	%eax, %eax
	call	snprintf@PLT
	movq	%rbp, %rdi
	call	strlen@PLT
	movq	g_compilation_arena(%rip), %rdi
	xorl	%edx, %edx
	movq	%rbp, %rsi
	movq	%rax, %rcx
	call	arena_xstrdup_range@PLT
	movq	%rbx, %rsi
	movq	%r12, %rdi
	movq	%rax, 8(%rbx)
	call	vec_push@PLT
	cmpq	8(%r14), %r13
	jb	.L1272
	movq	48(%rsp), %r13
	movq	56(%rsp), %rbx
.L1275:
	movl	8(%rsp), %esi
	movl	8(%rsp), %r15d
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %r12
	testl	%esi, %esi
	jle	.L1489
	.p2align 4
	.p2align 3
.L1273:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%r14d, %r15d
	jne	.L1273
	movq	%r13, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC155(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 68(%rsp)
.L1276:
	movl	8(%rsp), %r15d
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1279:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, %r15d
	jne	.L1279
	movq	%r13, %rcx
	movl	$12, %edx
	movl	$1, %esi
	xorl	%r14d, %r14d
	leaq	.LC156(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r13, %rdi
	call	emit_expr
	leaq	.LC117(%rip), %rax
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %ecx
	movl	$64, %esi
	xorl	%eax, %eax
	leaq	.LC157(%rip), %rdx
	movq	%rbp, %rdi
	call	snprintf@PLT
	movl	8(%rsp), %r15d
	.p2align 4
	.p2align 3
.L1280:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, %r15d
	jne	.L1280
	movl	32(%rsp), %edx
	leaq	.LC158(%rip), %rsi
	movq	%r13, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	24(%rbx), %rsi
	movq	16(%rsp), %r8
	xorl	%ebx, %ebx
	movq	g_ctrl(%rip), %rax
	movq	40(%rsp), %rcx
	movq	%r13, %rdi
	movq	%rbp, 88(%rsp)
	movl	68(%rsp), %edx
	movl	$1, 80(%rsp)
	movq	%rax, 96(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, g_ctrl(%rip)
	call	emit_stmt_switchctx
	movq	96(%rsp), %rax
	movl	8(%rsp), %ebp
	movq	%rax, g_ctrl(%rip)
	.p2align 4
	.p2align 3
.L1281:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1281
	leaq	.LC159(%rip), %rax
	movl	32(%rsp), %edx
	movq	%r13, %rdi
	xorl	%ebx, %ebx
	movq	%rax, 72(%rsp)
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	8(%rsp), %ebp
	.p2align 4
	.p2align 3
.L1282:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jne	.L1282
	movl	32(%rsp), %edx
	xorl	%eax, %eax
	leaq	.LC168(%rip), %rsi
	movq	%r13, %rdi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	leal	2(%rax), %ebx
	movq	24(%rsp), %rax
	cmpq	$0, 8(%rax)
	je	.L1486
.L1328:
	movq	$0, 56(%rsp)
	xorl	%ebp, %ebp
	leaq	.LC26(%rip), %r14
	.p2align 4
	.p2align 3
.L1298:
	movq	24(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%rbp,8), %r15
	movq	40(%rsp), %rax
	movq	8(%rax), %rcx
	movq	(%rax), %rsi
	testq	%rcx, %rcx
	je	.L1355
	xorl	%eax, %eax
	jmp	.L1286
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1285:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1355
.L1286:
	movq	(%rsi,%rax,8), %rdx
	cmpq	(%rdx), %r15
	jne	.L1285
	movq	8(%rdx), %rax
	cmpl	$61, 20(%r15)
	movq	%rax, 16(%rsp)
	je	.L1490
.L1287:
	xorl	%r12d, %r12d
	testl	%ebx, %ebx
	jle	.L1293
	.p2align 4
	.p2align 3
.L1290:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fwrite@PLT
	addl	$1, %r12d
	cmpl	%ebx, %r12d
	jne	.L1290
.L1293:
	movl	$1, %esi
	movq	%r13, %rcx
	movl	$4, %edx
	leaq	.LC161(%rip), %rdi
	call	fwrite@PLT
	movl	20(%r15), %eax
	movq	24(%r15), %rsi
	testl	%eax, %eax
	je	.L1491
	leaq	.LC139(%rip), %rdx
	cmpl	$26, %eax
	je	.L1294
	ja	.L1295
	leaq	.LC137(%rip), %rdx
	cmpl	$24, %eax
	je	.L1294
	cmpl	$25, %eax
	leaq	.LC141(%rip), %rdx
	leaq	.LC138(%rip), %rax
	cmove	%rax, %rdx
.L1294:
	movq	%rsi, %rcx
	movq	%r13, %rdi
	xorl	%eax, %eax
	leaq	.LC162(%rip), %rsi
	call	fprintf@PLT
.L1296:
	movq	%r13, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC165(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rsp), %rdi
	movq	%r13, %rsi
	call	fputs@PLT
	movq	48(%rsp), %rdi
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	call	fwrite@PLT
.L1289:
	movq	24(%rsp), %rax
	addq	$1, %rbp
	cmpq	8(%rax), %rbp
	jb	.L1298
	leaq	.LC26(%rip), %r12
	testl	%ebx, %ebx
	jle	.L1302
.L1300:
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1303:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebx, %ebp
	jl	.L1303
.L1302:
	movq	56(%rsp), %rax
	testq	%rax, %rax
	je	.L1304
	movq	%rax, %rdx
	leaq	.LC151(%rip), %rsi
	movq	%r13, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L1305:
	movl	68(%rsp), %eax
	movl	8(%rsp), %r14d
	xorl	%ebp, %ebp
	leaq	.LC26(%rip), %r12
	testl	%eax, %eax
	jle	.L1306
	.p2align 4
	.p2align 3
.L1307:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%ebp, %eax
	addl	$1, %ebp
	cmpl	%eax, %r14d
	jne	.L1307
.L1306:
	movl	32(%rsp), %edx
	leaq	.LC166(%rip), %rsi
	movq	%r13, %rdi
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	leaq	.LC26(%rip), %r12
	call	fprintf@PLT
	testl	%ebx, %ebx
	jle	.L1492
	.p2align 4
	.p2align 3
.L1308:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %ebx
	jne	.L1308
	movq	%r13, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC143(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	jle	.L1312
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1313:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1313
.L1312:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
.L1193:
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
.L1208:
	.cfi_restore_state
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	leaq	.LC26(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1228
	.p2align 4
	.p2align 3
.L1227:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1227
.L1228:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
.L1487:
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
.L1207:
	.cfi_restore_state
	movl	8(%rsp), %eax
	movl	8(%rsp), %r15d
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %r12
	testl	%eax, %eax
	jle	.L1493
	.p2align 4
	.p2align 3
.L1225:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%r14d, %r15d
	jne	.L1225
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L1231
.L1230:
	movl	8(%rsp), %edi
	xorl	%r12d, %r12d
	addl	$1, %edi
	movl	%edi, 40(%rsp)
.L1238:
	movq	16(%rbx), %rdx
	movq	(%rdx,%r12,8), %r14
	testl	%ebp, %ebp
	je	.L1345
	subq	$1, %rax
	xorl	%ecx, %ecx
	cmpq	%r12, %rax
	je	.L1494
.L1233:
	movq	16(%rsp), %r8
	movl	40(%rsp), %edx
	movq	%r14, %rsi
	movq	%r13, %rdi
	call	emit_stmt
.L1236:
	movq	24(%rbx), %rax
	addq	$1, %r12
	cmpq	%rax, %r12
	jb	.L1238
	movl	8(%rsp), %eax
	leaq	.LC26(%rip), %r12
	testl	%eax, %eax
	jle	.L1240
.L1231:
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1241:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1241
.L1240:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	jmp	.L1487
	.p2align 4,,10
	.p2align 3
.L1206:
	xorl	%r14d, %r14d
	cmpq	$0, 24(%rbx)
	movl	8(%rsp), %r12d
	leaq	.LC26(%rip), %rbp
	je	.L1193
	.p2align 4
	.p2align 3
.L1224:
	movq	16(%rbx), %rax
	movq	(%rax,%r14,8), %r15
	movq	(%r15), %rdi
	call	get_mangled_name
	movl	g_strict(%rip), %r10d
	movq	%rax, 8(%rsp)
	testl	%r10d, %r10d
	je	.L1495
	cmpq	$0, 8(%r15)
	je	.L1324
.L1323:
	xorl	%r15d, %r15d
	testl	%r12d, %r12d
	jle	.L1246
	.p2align 4
	.p2align 3
.L1244:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1244
.L1246:
	movq	8(%rsp), %rcx
	leaq	.LC147(%rip), %rsi
	movq	%r13, %rdi
	xorl	%eax, %eax
	movq	%rcx, %r8
	movq	%rcx, %rdx
	call	fprintf@PLT
.L1245:
	addq	$1, %r14
	cmpq	24(%rbx), %r14
	jb	.L1224
	jmp	.L1193
	.p2align 4,,10
	.p2align 3
.L1205:
	movl	8(%rsp), %eax
	movl	8(%rsp), %r15d
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %r12
	testl	%eax, %eax
	jle	.L1496
	.p2align 4
	.p2align 3
.L1222:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%r14d, %r15d
	jne	.L1222
	movq	%r13, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC161(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r13, %rdi
	call	emit_expr
	movq	%r13, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC169(%rip), %rdi
	call	fwrite@PLT
	testl	%ebp, %ebp
	je	.L1497
.L1330:
	movl	8(%rsp), %r14d
	xorl	%ecx, %ecx
	movq	24(%rbx), %rsi
	movq	%r13, %rdi
	cmpq	$0, 32(%rbx)
	movq	16(%rsp), %r8
	leal	1(%r14), %ebp
	sete	%cl
	movl	%ebp, %edx
	call	emit_stmt
	testl	%r14d, %r14d
	jle	.L1251
	leaq	.LC26(%rip), %r12
.L1332:
	movl	8(%rsp), %r15d
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1252:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%r14d, %r15d
	jne	.L1252
	movq	%r13, %rsi
	movl	$125, %edi
	call	fputc@PLT
	cmpq	$0, 32(%rbx)
	je	.L1254
	movq	%r13, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rsi
	movq	16(%rsp), %r8
	movl	%ebp, %edx
	xorl	%ecx, %ecx
	movq	%r13, %rdi
	xorl	%ebx, %ebx
	call	emit_stmt
	movl	8(%rsp), %ebp
	.p2align 4
	.p2align 3
.L1255:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1255
.L1325:
	movq	%r13, %rsi
	movl	$125, %edi
	call	fputc@PLT
.L1254:
	addq	$248, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r13, %rsi
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
.L1204:
	.cfi_restore_state
	movq	16(%rsp), %r8
	movl	8(%rsp), %edx
	movq	%rbx, %rsi
	movq	%r13, %rdi
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
	.p2align 4,,10
	.p2align 3
.L1203:
	.cfi_restore_state
	movl	8(%rsp), %eax
	movl	8(%rsp), %r14d
	xorl	%ebp, %ebp
	leaq	.LC26(%rip), %r12
	testl	%eax, %eax
	jle	.L1256
	.p2align 4
	.p2align 3
.L1219:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r14d
	jne	.L1219
.L1256:
	movq	%r13, %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC144(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%rbx)
	je	.L1498
	movq	%r13, %rsi
	movl	$32, %edi
	call	fputc@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r13, %rdi
	call	emit_expr
	jmp	.L1228
	.p2align 4,,10
	.p2align 3
.L1202:
	movl	8(%rsp), %eax
	movl	8(%rsp), %r15d
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %r12
	testl	%eax, %eax
	jle	.L1257
	.p2align 4
	.p2align 3
.L1216:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%r14d, %r15d
	jne	.L1216
.L1257:
	testl	%ebp, %ebp
	jne	.L1499
.L1218:
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r13, %rdi
	call	emit_expr
	jmp	.L1228
	.p2align 4,,10
	.p2align 3
.L1201:
	movl	8(%rsp), %edx
	movl	8(%rsp), %ebp
	xorl	%ebx, %ebx
	leaq	.LC26(%rip), %r12
	testl	%edx, %edx
	jle	.L1258
	.p2align 4
	.p2align 3
.L1215:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1215
.L1258:
	movq	%r13, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC143(%rip), %rdi
	jmp	.L1487
	.p2align 4,,10
	.p2align 3
.L1199:
	movl	8(%rsp), %ecx
	movl	8(%rsp), %r14d
	xorl	%ebp, %ebp
	leaq	.LC26(%rip), %r12
	testl	%ecx, %ecx
	jle	.L1265
	.p2align 4
	.p2align 3
.L1212:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r14d
	jne	.L1212
.L1265:
	movq	%r13, %rcx
	movl	$22, %edx
	movl	$1, %esi
	xorl	%r12d, %r12d
	leaq	.LC142(%rip), %rdi
	leaq	.LC152(%rip), %r14
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	movq	16(%rsp), %rdx
	leaq	.LC26(%rip), %rbp
	call	emit_expr
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	movl	8(%rsp), %r15d
	je	.L1214
	.p2align 4
	.p2align 3
.L1213:
	xorl	%ebx, %ebx
	testl	%r15d, %r15d
	js	.L1267
	.p2align 4
	.p2align 3
.L1266:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %r15d
	jge	.L1266
.L1267:
	addq	$1, %r12
	xorl	%eax, %eax
	movq	%r14, %rsi
	movq	%r13, %rdi
	movq	%r12, %rcx
	movq	%r12, %rdx
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %r12
	jb	.L1213
.L1214:
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	js	.L1268
	xorl	%ebx, %ebx
	leaq	.LC26(%rip), %r12
	.p2align 4
	.p2align 3
.L1269:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jge	.L1269
	movq	%r13, %rcx
	movl	$54, %edx
	movl	$1, %esi
	leaq	.LC153(%rip), %rdi
	call	fwrite@PLT
	movl	8(%rsp), %ebp
	testl	%ebp, %ebp
	je	.L1240
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L1271:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L1271
	jmp	.L1240
	.p2align 4,,10
	.p2align 3
.L1200:
	movq	g_ctrl(%rip), %rbx
	testq	%rbx, %rbx
	jne	.L1259
	jmp	.L1260
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1261:
	movq	16(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L1260
.L1259:
	movl	(%rbx), %r8d
	testl	%r8d, %r8d
	jne	.L1261
.L1262:
	movl	8(%rsp), %edi
	movl	8(%rsp), %r14d
	xorl	%ebp, %ebp
	leaq	.LC26(%rip), %r12
	testl	%edi, %edi
	jle	.L1264
	.p2align 4
	.p2align 3
.L1263:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %ebp
	cmpl	%ebp, %r14d
	jne	.L1263
.L1264:
	movq	8(%rbx), %rdx
	addq	$248, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r13, %rdi
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC151(%rip), %rsi
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
.L1198:
	.cfi_restore_state
	movl	8(%rsp), %esi
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %rbp
	testl	%esi, %esi
	jle	.L1500
	.p2align 4
	.p2align 3
.L1209:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%r14d, 8(%rsp)
	jne	.L1209
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %r14
	movq	%rax, 32(%rsp)
	testq	%r14, %r14
	je	.L1501
.L1210:
	movq	function_labels(%rip), %r15
	xorl	%ebp, %ebp
	jmp	.L1318
	.p2align 4,,10
	.p2align 3
.L1316:
	addq	$1, %rbp
	cmpq	%r14, %rbp
	je	.L1211
.L1318:
	movq	(%r15,%rbp,8), %rsi
	movq	32(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1316
	leal	1(%rbp), %edx
.L1317:
	leaq	.LC167(%rip), %rsi
	movq	%r13, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	addl	$1, 8(%rsp)
	movl	8(%rsp), %eax
	leaq	.LC26(%rip), %rbp
	testl	%eax, %eax
	jle	.L1322
.L1319:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1321:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	addl	$1, %r14d
	cmpl	%eax, %r14d
	jne	.L1321
.L1322:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	xorl	%ebp, %ebp
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rbx
	jmp	.L1320
	.p2align 4,,10
	.p2align 3
.L1355:
	movq	$0, 16(%rsp)
	cmpl	$61, 20(%r15)
	jne	.L1287
.L1490:
	cmpq	$0, 56(%rsp)
	je	.L1288
	leaq	.LC160(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L1288:
	movq	16(%rsp), %rax
	movq	%rax, 56(%rsp)
	jmp	.L1289
	.p2align 4,,10
	.p2align 3
.L1495:
	movq	16(%rsp), %rcx
	movl	%r12d, %edx
	movq	%r15, %rsi
	movq	%r13, %rdi
	call	emit_auto_storage
	cmpq	$0, 8(%r15)
	jne	.L1323
	movl	g_strict(%rip), %r9d
	testl	%r9d, %r9d
	je	.L1245
	.p2align 4
	.p2align 3
.L1324:
	xorl	%r15d, %r15d
	testl	%r12d, %r12d
	jle	.L1248
	.p2align 4
	.p2align 3
.L1247:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	addl	$1, %r15d
	cmpl	%r15d, %r12d
	jne	.L1247
.L1248:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1245
	.p2align 4,,10
	.p2align 3
.L1491:
	movl	16(%r15), %ecx
	testl	%ecx, %ecx
	je	.L1297
	movq	32(%r15), %rcx
	movq	%rsi, %rdx
	movq	%r13, %rdi
	xorl	%eax, %eax
	leaq	.LC163(%rip), %rsi
	call	fprintf@PLT
	jmp	.L1296
.L1494:
	cmpl	$6, (%r14)
	movl	%ebp, %ecx
	jne	.L1233
	movl	g_no_line(%rip), %r15d
	testl	%r15d, %r15d
	jne	.L1234
	cmpb	$0, 24(%rsp)
	je	.L1234
	movl	4(%r14), %edx
	movq	16(%rsp), %rcx
	movq	%r13, %rdi
	xorl	%eax, %eax
	leaq	.LC27(%rip), %rsi
	call	fprintf@PLT
.L1234:
	movl	8(%rsp), %r11d
	leaq	.LC26(%rip), %rax
	xorl	%r15d, %r15d
	movq	%rax, 32(%rsp)
	testl	%r11d, %r11d
	js	.L1237
	.p2align 4
	.p2align 3
.L1235:
	movq	32(%rsp), %rdi
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	addl	$1, %r15d
	call	fwrite@PLT
	cmpl	%r15d, 8(%rsp)
	jge	.L1235
.L1237:
	movq	%r13, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC146(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r14), %rsi
	movq	16(%rsp), %rdx
	movq	%r13, %rdi
	call	emit_expr
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1236
	.p2align 4,,10
	.p2align 3
.L1345:
	xorl	%ecx, %ecx
	jmp	.L1233
	.p2align 4,,10
	.p2align 3
.L1297:
	movq	%rsi, %rdx
	movq	%r13, %rdi
	leaq	.LC164(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1296
	.p2align 4,,10
	.p2align 3
.L1295:
	cmpl	$27, %eax
	leaq	.LC141(%rip), %rdx
	leaq	.LC140(%rip), %rax
	cmove	%rax, %rdx
	jmp	.L1294
.L1497:
	movl	8(%rsp), %eax
	movq	24(%rbx), %rsi
	xorl	%ecx, %ecx
	movq	%r13, %rdi
	movq	16(%rsp), %r8
	leal	1(%rax), %ebp
	movl	%ebp, %edx
	call	emit_stmt
	jmp	.L1332
.L1500:
	movq	16(%rbx), %rax
	movq	8+function_labels(%rip), %r14
	movq	%rax, 32(%rsp)
	testq	%r14, %r14
	jne	.L1210
.L1211:
	xorl	%edx, %edx
	jmp	.L1317
.L1499:
	movq	%r13, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC146(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1218
.L1498:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC149(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1228
.L1304:
	movl	32(%rsp), %edx
	movq	72(%rsp), %rsi
	movq	%r13, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1305
.L1260:
	leaq	.LC150(%rip), %rdi
	xorl	%eax, %eax
	xorl	%ebx, %ebx
	call	dief@PLT
	jmp	.L1262
.L1496:
	movq	%r13, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC161(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rbx), %rsi
	movq	16(%rsp), %rdx
	movq	%r13, %rdi
	call	emit_expr
	movq	%r13, %rcx
	movl	$4, %edx
	movl	$1, %esi
	leaq	.LC169(%rip), %rdi
	call	fwrite@PLT
	testl	%ebp, %ebp
	jne	.L1330
	movl	8(%rsp), %ebp
	movq	24(%rbx), %rsi
	xorl	%ecx, %ecx
	movq	%r13, %rdi
	movq	16(%rsp), %r8
	addl	$1, %ebp
	movl	%ebp, %edx
	call	emit_stmt
.L1251:
	movq	%r13, %rsi
	movl	$125, %edi
	call	fputc@PLT
	cmpq	$0, 32(%rbx)
	je	.L1254
	movq	%r13, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC148(%rip), %rdi
	call	fwrite@PLT
	movq	32(%rbx), %rsi
	movq	16(%rsp), %r8
	xorl	%ecx, %ecx
	movl	%ebp, %edx
	movq	%r13, %rdi
	call	emit_stmt
	jmp	.L1325
.L1268:
	movq	%r13, %rcx
	movl	$54, %edx
	movl	$1, %esi
	leaq	.LC153(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1240
.L1493:
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	movq	24(%rbx), %rax
	testq	%rax, %rax
	jne	.L1230
	jmp	.L1240
.L1489:
	leaq	.LC155(%rip), %rdi
	movq	%r13, %rcx
	movl	$10, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movl	8(%rsp), %eax
	leal	1(%rax), %edi
	movl	%edi, 68(%rsp)
	testl	%eax, %eax
	je	.L1276
	movq	%r13, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC156(%rip), %rdi
	call	fwrite@PLT
	movq	16(%rsp), %r15
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	movq	%r15, %rdx
	call	emit_expr
	leaq	.LC117(%rip), %rax
	movq	%r13, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	fwrite@PLT
	movl	32(%rsp), %r14d
	movq	%rbp, %rdi
	xorl	%eax, %eax
	leaq	.LC157(%rip), %rdx
	movl	$64, %esi
	movl	%r14d, %ecx
	call	snprintf@PLT
	movl	%r14d, %edx
	movq	%r13, %rdi
	xorl	%eax, %eax
	leaq	.LC158(%rip), %rsi
	call	fprintf@PLT
	movq	24(%rbx), %rsi
	movl	68(%rsp), %edx
	movq	%r15, %r8
	movq	g_ctrl(%rip), %rax
	movq	40(%rsp), %rcx
	movq	%r13, %rdi
	movl	$1, 80(%rsp)
	movq	%rbp, 88(%rsp)
	movq	%rax, 96(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, g_ctrl(%rip)
	call	emit_stmt_switchctx
	movq	96(%rsp), %rax
	movl	%r14d, %edx
	movq	%r13, %rdi
	movq	%rax, g_ctrl(%rip)
	leaq	.LC159(%rip), %rax
	movq	%rax, %rsi
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%eax, %eax
	movl	%r14d, %edx
	movq	%r13, %rdi
	leaq	.LC168(%rip), %rsi
	call	fprintf@PLT
	movl	8(%rsp), %eax
	leal	2(%rax), %ebx
	movq	24(%rsp), %rax
	cmpq	$0, 8(%rax)
	jne	.L1328
	cmpl	$-1, 8(%rsp)
	je	.L1502
	movl	32(%rsp), %edx
	movq	72(%rsp), %rsi
	movq	%r13, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1306
.L1492:
	movq	%r13, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC143(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1312
.L1502:
	xorl	%edx, %edx
	movl	$1, %ebx
	movl	%edx, 68(%rsp)
.L1486:
	movq	$0, 56(%rsp)
	jmp	.L1300
.L1501:
	xorl	%edx, %edx
	leaq	.LC167(%rip), %rsi
	movq	%r13, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	addl	$1, 8(%rsp)
	jmp	.L1319
	.cfi_endproc
.LFE60:
	.size	emit_stmt, .-emit_stmt
	.section	.rodata.str1.1
.LC170:
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
	je	.L1503
	movq	%rdi, %rbx
	movq	%rsi, %r13
	movl	%edx, %ebp
	movq	%rcx, %r15
.L1504:
	cmpl	$13, 0(%r13)
	ja	.L1507
	movl	0(%r13), %eax
	leaq	.L1509(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L1509:
	.long	.L1507-.L1509
	.long	.L1513-.L1509
	.long	.L1507-.L1509
	.long	.L1512-.L1509
	.long	.L1511-.L1509
	.long	.L1507-.L1509
	.long	.L1507-.L1509
	.long	.L1507-.L1509
	.long	.L1507-.L1509
	.long	.L1507-.L1509
	.long	.L1507-.L1509
	.long	.L1510-.L1509
	.long	.L1507-.L1509
	.long	.L1508-.L1509
	.text
	.p2align 4,,10
	.p2align 3
.L1507:
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
.L1508:
	.cfi_restore_state
	movq	8(%r15), %rcx
	movq	(%r15), %rsi
	testq	%rcx, %rcx
	je	.L1553
	xorl	%eax, %eax
	jmp	.L1523
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1522:
	addq	$1, %rax
	cmpq	%rax, %rcx
	je	.L1553
.L1523:
	movq	(%rsi,%rax,8), %rdx
	cmpq	%r13, (%rdx)
	jne	.L1522
	movq	8(%rdx), %rax
	movq	%rax, 16(%rsp)
.L1521:
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1584
	.p2align 4
	.p2align 3
.L1524:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1524
	movq	16(%rsp), %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	xorl	%r14d, %r14d
	leaq	.LC170(%rip), %rsi
	call	fprintf@PLT
	.p2align 4
	.p2align 3
.L1527:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jle	.L1527
.L1526:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	movq	40(%r13), %r13
	jmp	.L1528
	.p2align 4,,10
	.p2align 3
.L1513:
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1585
	.p2align 4
	.p2align 3
.L1519:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1519
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	je	.L1537
.L1536:
	leal	1(%rbp), %r12d
	xorl	%r14d, %r14d
.L1539:
	movq	16(%r13), %rdx
	movq	8(%rsp), %r8
	movq	%r15, %rcx
	movq	%rbx, %rdi
	movq	(%rdx,%r14,8), %rsi
	movl	%r12d, %edx
	addq	$1, %r14
	call	emit_stmt_switchctx
	cmpq	24(%r13), %r14
	jb	.L1539
	leaq	.LC26(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1538
.L1537:
	xorl	%r13d, %r13d
	.p2align 4
	.p2align 3
.L1541:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1541
.L1538:
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
.L1512:
	.cfi_restore_state
	leal	1(%rbp), %eax
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %r12
	movl	%eax, 16(%rsp)
	testl	%ebp, %ebp
	jle	.L1586
	.p2align 4
	.p2align 3
.L1517:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1517
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
	.p2align 4
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
	movq	%rbx, %rsi
	movl	$125, %edi
	call	fputc@PLT
	cmpq	$0, 32(%r13)
	je	.L1544
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
	.p2align 4
	.p2align 3
.L1545:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%ebp, %r13d
	jne	.L1545
.L1546:
	movq	%rbx, %rsi
	movl	$125, %edi
	call	fputc@PLT
.L1544:
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
.L1511:
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
.L1510:
	.cfi_restore_state
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1587
	.p2align 4
	.p2align 3
.L1514:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%ebp, %r14d
	jne	.L1514
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L1588
.L1515:
	movq	function_labels(%rip), %r14
	xorl	%r12d, %r12d
	jmp	.L1532
	.p2align 4,,10
	.p2align 3
.L1530:
	movq	24(%rsp), %rax
	addq	$1, %r12
	cmpq	%rax, %r12
	je	.L1516
.L1532:
	movq	(%r14,%r12,8), %rsi
	movq	16(%rsp), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1530
	leal	1(%r12), %edx
.L1531:
	leaq	.LC167(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	leaq	.LC26(%rip), %r12
	movl	%eax, 16(%rsp)
	testl	%eax, %eax
	jle	.L1535
.L1533:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1534:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	movl	%r14d, %eax
	addl	$1, %r14d
	cmpl	%eax, %ebp
	jne	.L1534
.L1535:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	movq	24(%r13), %r13
	movl	16(%rsp), %ebp
.L1528:
	testq	%r13, %r13
	jne	.L1504
.L1503:
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
.L1553:
	.cfi_restore_state
	movq	$0, 16(%rsp)
	jmp	.L1521
	.p2align 4,,10
	.p2align 3
.L1587:
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	movq	8+function_labels(%rip), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	jne	.L1515
	.p2align 4
	.p2align 3
.L1516:
	xorl	%edx, %edx
	jmp	.L1531
	.p2align 4,,10
	.p2align 3
.L1584:
	movq	16(%rsp), %rdx
	xorl	%eax, %eax
	leaq	.LC170(%rip), %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	testl	%ebp, %ebp
	jne	.L1526
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	jmp	.L1526
	.p2align 4,,10
	.p2align 3
.L1586:
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
	je	.L1544
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
	jmp	.L1546
	.p2align 4,,10
	.p2align 3
.L1585:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC145(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 24(%r13)
	jne	.L1536
	jmp	.L1538
.L1588:
	xorl	%edx, %edx
	leaq	.LC167(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	leal	1(%rbp), %eax
	movl	%eax, 16(%rsp)
	jmp	.L1533
	.cfi_endproc
.LFE45:
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
	movq	%rsi, %r13
	movl	$64, %esi
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	%edx, %ebp
	leaq	.LC171(%rip), %rdx
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$120, %rsp
	.cfi_def_cfa_offset 176
	movl	g_loop_id(%rip), %eax
	leaq	48(%rsp), %r15
	movq	%rcx, 8(%rsp)
	movq	%r15, %rdi
	leal	1(%rax), %ecx
	xorl	%eax, %eax
	movq	%r8, (%rsp)
	movl	%ecx, g_loop_id(%rip)
	call	snprintf@PLT
	movq	24(%r13), %rdi
	call	loop_has_continue
	testl	%eax, %eax
	jne	.L1611
	leaq	.LC26(%rip), %r12
	testl	%ebp, %ebp
	jle	.L1594
.L1595:
	xorl	%r14d, %r14d
	.p2align 4
	.p2align 3
.L1596:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%r14d, %ebp
	jne	.L1596
.L1594:
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
	je	.L1598
	movq	%r14, %r8
	movq	%rbx, %rdi
	call	emit_stmt_switchctx
.L1599:
	movq	32(%rsp), %rax
	xorl	%r13d, %r13d
	leaq	.LC26(%rip), %r12
	movq	%rax, g_ctrl(%rip)
	testl	%ebp, %ebp
	jle	.L1601
	.p2align 4
	.p2align 3
.L1600:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r13d
	cmpl	%r13d, %ebp
	jne	.L1600
.L1601:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
	addq	$120, %rsp
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
.L1611:
	.cfi_restore_state
	testl	%ebp, %ebp
	jle	.L1591
	xorl	%r14d, %r14d
	leaq	.LC26(%rip), %r12
	.p2align 4
	.p2align 3
.L1592:
	movq	%rbx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	addl	$1, %r14d
	cmpl	%r14d, %ebp
	jne	.L1592
	movq	%r15, %rdx
	leaq	.LC172(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1595
	.p2align 4,,10
	.p2align 3
.L1598:
	movq	(%rsp), %r8
	xorl	%ecx, %ecx
	movq	%rbx, %rdi
	call	emit_stmt
	jmp	.L1599
.L1591:
	movq	%r15, %rdx
	leaq	.LC172(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1594
	.cfi_endproc
.LFE47:
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
.LFB65:
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
	je	.L1612
	movq	%rdi, %rbp
	movq	%rsi, %r12
	xorl	%ebx, %ebx
	jmp	.L1626
	.p2align 4,,10
	.p2align 3
.L1615:
	addq	$1, %rbx
	cmpq	8(%r12), %rbx
	jnb	.L1612
.L1626:
	movq	(%r12), %rax
	movq	(%rax,%rbx,8), %r14
	movl	(%r14), %eax
	testl	%eax, %eax
	je	.L1644
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L1615
	movq	8(%r14), %r13
	movq	16(%r13), %rdi
	call	get_mangled_name
	cmpl	$3, (%r14)
	movq	%rax, %r15
	je	.L1645
	cmpl	$1, 24(%r13)
	movl	$1, %r8d
	jne	.L1620
	movq	56(%r13), %rdi
	movl	$1, %r11d
	testq	%rdi, %rdi
	je	.L1621
	cmpl	$1, (%rdi)
	je	.L1646
.L1621:
	call	edge_tail_words_top
	leaq	(%rax,%r11), %r8
	movl	$1, %eax
	testq	%r8, %r8
	cmove	%rax, %r8
.L1620:
	movl	4(%r13), %eax
	leaq	.LC175(%rip), %rdx
	testl	%eax, %eax
	je	.L1622
	leaq	.LC174(%rip), %rdx
.L1622:
	xorl	%eax, %eax
	movq	%r15, %rcx
	leaq	.LC178(%rip), %rsi
	movq	%rbp, %rdi
	call	fprintf@PLT
	cmpl	$2, 24(%r13)
	jne	.L1615
	movq	56(%r13), %rdi
	xorl	%r11d, %r11d
	testq	%rdi, %rdi
	je	.L1623
	cmpl	$1, (%rdi)
	je	.L1647
.L1623:
	cmpq	$0, 32(%r13)
	je	.L1624
	movq	48(%r13), %rax
	movq	%r11, %rdx
	cmpq	%rax, %r11
	cmovb	%rax, %r11
	testq	%rax, %rax
	cmovle	%rdx, %r11
.L1624:
	call	edge_tail_words_top
	movq	%r15, %rdx
	leaq	.LC179(%rip), %rsi
	movq	%rbp, %rdi
	leaq	(%rax,%r11), %rcx
	movl	$1, %eax
	testq	%rcx, %rcx
	cmove	%rax, %rcx
	xorl	%eax, %eax
	addq	$1, %rbx
	call	fprintf@PLT
	cmpq	8(%r12), %rbx
	jb	.L1626
.L1612:
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
.L1644:
	.cfi_restore_state
	movq	8(%r14), %rsi
	movq	8(%rsp), %r8
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbp, %rdi
	call	emit_stmt
	jmp	.L1615
	.p2align 4,,10
	.p2align 3
.L1645:
	movq	16(%r13), %rdi
	call	global_data_kind
	testl	%eax, %eax
	je	.L1615
	movl	8(%r13), %esi
	testl	%esi, %esi
	je	.L1619
	movq	16(%r13), %rdx
	movq	%r15, %rcx
	movq	%r15, %r9
	movq	%r15, %r8
	leaq	.LC176(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	pushq	%rdx
	.cfi_def_cfa_offset 88
	pushq	%r15
	.cfi_def_cfa_offset 96
	call	fprintf@PLT
	popq	%rdx
	.cfi_def_cfa_offset 88
	popq	%rcx
	.cfi_def_cfa_offset 80
	jmp	.L1615
	.p2align 4,,10
	.p2align 3
.L1646:
	movq	24(%rdi), %r11
	jmp	.L1621
	.p2align 4,,10
	.p2align 3
.L1619:
	movq	%r15, %rdx
	leaq	.LC177(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L1615
.L1647:
	movq	24(%rdi), %r11
	jmp	.L1623
	.cfi_endproc
.LFE65:
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
	movq	$0, 8+function_labels(%rip)
	call	collect_function_labels
	movq	%rbx, %rcx
	movl	$15, %edx
	movl	$1, %esi
	leaq	.LC180(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 16(%r13)
	jne	.L1665
.L1650:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L1666
.L1652:
	cmpq	$0, 8+function_labels(%rip)
	jne	.L1667
.L1656:
	movq	32(%r13), %rsi
	movq	%r12, %r8
	movq	%rbx, %rdi
	movl	$1, %ecx
	movl	$1, %edx
	call	emit_stmt
	movq	%rbx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	leaq	.LC192(%rip), %rdi
	call	fwrite@PLT
	movq	$0, 8+function_labels(%rip)
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
.L1665:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$77, %edx
	movl	$1, %esi
	leaq	.LC181(%rip), %rdi
	call	fwrite@PLT
	movq	16(%r13), %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC182(%rip), %rsi
	movq	%rdx, %rcx
	call	fprintf@PLT
	movq	%rbx, %rcx
	movl	$255, %edx
	movl	$1, %esi
	leaq	.LC183(%rip), %rdi
	call	fwrite@PLT
	cmpl	$16, current_word_bits(%rip)
	jne	.L1650
	movq	%rbx, %rcx
	movl	$69, %edx
	movl	$1, %esi
	leaq	.LC184(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1650
	.p2align 4,,10
	.p2align 3
.L1667:
	movq	%rbx, %rcx
	movl	$35, %edx
	movl	$1, %esi
	leaq	.LC185(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	je	.L1657
	xorl	%ebp, %ebp
	leaq	.LC186(%rip), %r15
	leaq	.LC187(%rip), %r14
	.p2align 4
	.p2align 3
.L1658:
	addq	$1, %rbp
	movq	%r15, %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movq	%rbp, %rdx
	call	fprintf@PLT
	xorl	%eax, %eax
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %rbp
	jb	.L1658
.L1657:
	movq	%rbx, %rcx
	movl	$31, %edx
	movl	$1, %esi
	leaq	.LC188(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+function_labels(%rip)
	je	.L1659
	xorl	%ebp, %ebp
	leaq	.LC189(%rip), %r15
	leaq	.LC190(%rip), %r14
	.p2align 4
	.p2align 3
.L1660:
	addq	$1, %rbp
	movq	%r15, %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movq	%rbp, %rdx
	call	fprintf@PLT
	xorl	%eax, %eax
	movq	%rbp, %rcx
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	fprintf@PLT
	cmpq	8+function_labels(%rip), %rbp
	jb	.L1660
.L1659:
	movq	%rbx, %rcx
	movl	$38, %edx
	movl	$1, %esi
	leaq	.LC191(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1656
	.p2align 4,,10
	.p2align 3
.L1666:
	movq	32(%r13), %rdi
	pxor	%xmm0, %xmm0
	movq	%rsp, %rsi
	movq	$0, 16(%rsp)
	movaps	%xmm0, (%rsp)
	call	collect_function_autos
	cmpq	$0, 8(%rsp)
	je	.L1653
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L1654:
	movq	(%rsp), %rax
	movq	%r12, %rcx
	movl	$1, %edx
	movq	%rbx, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	emit_auto_storage
	cmpq	8(%rsp), %rbp
	jb	.L1654
.L1653:
	cmpq	$0, g_compilation_arena(%rip)
	jne	.L1652
	movq	(%rsp), %rdi
	call	free@PLT
	jmp	.L1652
	.cfi_endproc
.LFE61:
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
	.ascii	"else if (rd_fd != (int)rd_unit) {\n        rd_fd = (int)rd_u"
	.ascii	"nit;\n    }\n}\nstatic void __b_sync_wr(void){\n    if (wr_u"
	.ascii	"nit < 0) {\n        if (wr_fd != 1 && wr_fd > 2) close(wr_fd"
	.ascii	");\n        wr_fd = 1;\n    } else if (wr_fd != (int)wr_unit"
	.ascii	") {\n        wr_fd = (int)wr_unit;\n    }\n}\nstatic word b_"
	.ascii	"print(word x){\n    __b_sync_wr();\n    char buf[64];\n    i"
	.ascii	"nt n = snprintf(buf, sizeof(buf), \"%\" PRIdPTR \"\\n\", (in"
	.ascii	"tptr_t)x);\n    if (n > 0) (void)write(wr_fd, buf, (size_t)n"
	.ascii	");\n    return x;\n}\n\nstatic word b_putchar(word x){\n    "
	.ascii	"__b_sync_wr();\n    unsigned char bytes[2] = {(unsigned char"
	.ascii	")((uword)x >> 8), (unsigned char)x};\n    size_t start = byt"
	.ascii	"es[0] ? 0 : 1;\n    (void)write(wr_fd, bytes + start, 2 - st"
	.ascii	"art);\n    return x;\n}\nstatic word b_getchar(void){ __b_sy"
	.ascii	"nc_rd(); unsigned char c; ssize_t n = read(rd_fd, &c, 1); if"
	.ascii	" (n == 1) return (word)c; if (rd_fd != 0) { close(rd_fd); rd"
	.ascii	"_fd = 0; rd_unit = -1; return b_getchar(); } return (word)00"
	.ascii	"4; }\nstatic word b_exit(word code){ exit((int)code); return"
	.ascii	" 0; }\nstatic word b_abort(void){ abort(); return 0; }\nstat"
	.ascii	"ic word b_free(word p){ void *host = B_CPTR(p); B_FORGET(hos"
	.ascii	"t); free(host); return 0; }\n\n/* Sign-extend 16-bit value t"
	.ascii	"o full word size. Used by 16-bit B programs on 64-bit hosts."
	.ascii	" */\nstatic word sx64(word x){\n    return (word)(int16_t)(x"
	.ascii	" & 0xFFFF);\n}\n\n/* Command line argument support */\nint _"
	.ascii	"_b_argc __attribute__((common));\nchar **__b_argv __attribut"
	.ascii	"e__((common));\n\n/* argv"
	.ascii	" strings converted to B strings (packed words, 004 terminato"
	.ascii	"r) */\nword *__b_argvb __attribute__((common));\nword b_argv"
	.ascii	"_vector __attribute__((common));\n\nstatic void __b_setargs("
	.ascii	"int argc, char **argv);\nstatic word b_argc(void);\nstatic w"
	.ascii	"ord b_argv(word i);\n\n/* Command line reread buffer */\nsta"
	.ascii	"tic word b_reread(void);\n\n/* Helper functions for complex "
	.ascii	"lvalue operations (avoid GNU C extensions) */\n/* All use sa"
	.ascii	"fe W* macros to avoid host-C undefined behavior */\nstatic w"
	.ascii	"ord b_preinc(word *p) { return (*p = WADD(*p, 1)); }\nstatic"
	.ascii	" word b_predec(word *p) { return (*p = WSUB(*p, 1)); }\nstat"
	.ascii	"ic word b_postinc(word *p) { word old = WVAL(*p); *p = WADD("
	.ascii	"*p, 1); return old; }\nstatic word b_postdec(word *p) { word"
	.ascii	" old = WVAL(*p); *p = WSUB(*p, 1); return old; }\nstatic wor"
	.ascii	"d b_add_assign(word *p, word v) { return (*p = WADD(*p, v));"
	.ascii	" }\nstatic word b_sub_assign(word *p, word v) { return (*p ="
	.ascii	" WSUB(*p, v)); }\nstatic word b_mul_assign(word *p, word v) "
	.ascii	"{ return (*p = WMUL(*p, v)); }\nstatic word b_div_assign(wor"
	.ascii	"d *p, word v) { return (*p = WDIV(*p, v)); }\nstatic word b_"
	.ascii	"mod_assign(word *p, word v) { return (*p = WMOD(*p, v)); }\n"
	.ascii	"static word b_lsh_assign(word *p, word v) { return (*p = WSH"
	.ascii	"L(*p, v)); }\nstatic word b_rsh_assign(word *p, word v) { re"
	.ascii	"turn (*p = WSHR(*p, v)); }\nstatic word b_and_assign(word *p"
	.ascii	", word v) { return (*p = WAND(*p, v)); }\nstatic word b_or_a"
	.ascii	"ssign(word *p, word v) { return (*p = WOR(*p, v)); }\nstatic"
	.ascii	" word b_xor_assign(word *p, word v) { return (*p = WXOR(*p, "
	.ascii	"v)); }\n\nstatic word b_alloc(word nwords){\n    nwords = WV"
	.ascii	"AL(nwords);\n    if (nwords < 0 || (uword)nwords > SIZE_MAX "
	.ascii	"/ sizeof(word)) {\n        fprintf(stderr, \"alloc: invalid "
	.ascii	"size\\n\"); exit(1);\n    }\n    size_t bytes = nwords ? (si"
	.ascii	"ze_t)nwords * sizeof(word) : sizeof(word);\n    void *p = ma"
	.ascii	"lloc(bytes);\n    if (!p) { fprintf(stderr, \"alloc: out of "
	.ascii	"memory\\n\"); exit(1); }\n    return B_PTR_N(p, bytes);\n}\n"
	.ascii	"\n/* Host B runtime functions and compatibility helpers */\n"
	.ascii	"/* String manipulation functions */\nstatic inline word b_lo"
	.ascii	"ad(word"
	.ascii	" addr){ return B_DEREF(addr); }\nstatic inline void b_store("
	.ascii	"word addr, word v){ B_DEREF(addr) = WVAL(v);\n}\n\n/* B stri"
	.ascii	"ng access - byte packing within words.\n *\n * In B_BYTEPTR="
	.ascii	"0 mode, bytes are packed into words with byte 0 at the LSB.\n"
	.ascii	" * This matches PDP-11 (little-endian) conventions. The shif"
	.ascii	"t-based approach\n * operates on word VALUES (not memory lay"
	.ascii	"out), making it consistent across\n * architectures: char(s,"
	.ascii	"0) always returns the least-significant byte of the\n * word"
	.ascii	" at address s, regardless of host endianness.\n *\n * Note: "
	.ascii	"This only works correctly when ALL byte access goes through "
	.ascii	"char()/lchar().\n * Mixing direct memory access (like C's *("
	.ascii	"char*)ptr) with B word operations will\n * give different re"
	.ascii	"sults on big-endian hosts.\n */\nstatic word b_char(word s, "
	.ascii	"word i){\n#if B_BYTEPTR && WORD_BITS != 16\n    const unsign"
	.ascii	"ed char *p = (const unsigned char*)B_CPTR(s);\n    return (w"
	.ascii	"ord)p[(size_t)i];\n#else\n    const uword W = (uword)B_WORD_"
	.ascii	"BYTES;\n    uword wi = (uword)i / W;\n    uword bi = (uword)"
	.ascii	"i % W;\n    uword w  = (uword)B_INDEX(s, wi);\n    return (w"
	.ascii	"ord)((w >> (bi * 8)) & 0xFF);\n#endif\n}\n\nstatic word b_lc"
	.ascii	"har(word s, word i, word c){\n#if B_BYTEPTR && WORD_BITS != "
	.ascii	"16\n    unsigned char *p = (unsigned char*)B_CPTR(s);\n    p"
	.ascii	"[(size_t)i] = (unsigned char)(c & 0xFF);\n    return c;\n#el"
	.ascii	"se\n    const uword W = (uword)B_WORD_BYTES;\n    uword wi ="
	.ascii	" (uword)i / W;\n    uword bi = (uword)i % W;\n\n    word add"
	.ascii	"r = B_ADDR(B_INDEX(s, wi));\n    uword w   = (uword)b_load(a"
	.ascii	"ddr);\n\n    uword mask = (uword)0xFF << (bi * 8);\n    w = "
	.ascii	"(w & ~mask) | (((uword)c & 0xFF) << (bi * 8));\n\n#if WORD_B"
	.ascii	"ITS == 32\n    B_DEREF(addr) = (word)w;\n#else\n    b_store("
	.ascii	"addr, (word)w);\n#endif\n    return c;\n#endif\n}\n\n/* Comm"
	.ascii	"and line argument support implementation */\nstatic word __b"
	.ascii	"_pack_cstr(const char *s){\n    size_t n = strlen(s);       "
	.ascii	"          /* bytes, excluding NUL */\n    size_t W = B_WORD_"
	.ascii	"BYTES;              /* bytes per word */\n    size_t total ="
	.ascii	" n + 1;                 /* +1 for 004 terminator */\n    siz"
	.ascii	"e_t words = (total"
	.ascii	" + W - 1) / W;\n\n    word bp = b_alloc((word)words);       "
	.ascii	"/* B pointer to word storage */\n\n    /* write bytes into t"
	.ascii	"he B string using lchar (handles packing for B_BYTEPTR=0) */"
	.ascii	"\n    for (size_t i = 0; i < n; i++){\n        b_lchar(bp, ("
	.ascii	"word)i, (word)(unsigned char)s[i]);\n    }\n    b_lchar(bp, "
	.ascii	"(word)n, (word)004);\n    return bp;\n}\n\nstatic void __b_b"
	.ascii	"str_to_cstr(word s, char *buf, size_t max){\n    size_t i = "
	.ascii	"0;\n    while (i + 1 < max) {\n        word ch = b_char(s, ("
	.ascii	"word)i);\n        if (ch == 004 || ch == 0) break;\n        "
	.ascii	"buf[i++] = (char)(ch & 0xFF);\n    }\n    buf[i] = 0;\n}\n\n"
	.ascii	"/* Convert a B string (004-terminated) into a temporary NUL-"
	.ascii	"terminated C string */\nstatic const char *__b_cstr(word s){"
	.ascii	"\n    static char *slots[4];\n    static size_t caps[4];\n  "
	.ascii	"  static int next = 0;\n\n    if (s == 0) return \"\";\n\n  "
	.ascii	"  size_t len = 0;\n    for (;; len++) {\n        word ch = b"
	.ascii	"_char(s, (word)len);\n        if (ch == 004 || ch == 0) brea"
	.ascii	"k;\n    }\n\n    int idx = next;\n    next = (next + 1) & 3;"
	.ascii	" /* simple ring buffer to survive multiple args */\n\n    si"
	.ascii	"ze_t need = len + 1;\n    if (need > caps[idx]) {\n        s"
	.ascii	"ize_t ncap = need < 64 ? 64 : need;\n        char *nb = (cha"
	.ascii	"r*)realloc(slots[idx], ncap);\n        if (!nb) { fprintf(st"
	.ascii	"derr, \"cstr: out of memory\\n\"); exit(1); }\n        slots"
	.ascii	"[idx] = nb;\n        caps[idx] = ncap;\n    }\n\n    for (si"
	.ascii	"ze_t i = 0; i < len; i++) slots[idx][i] = (char)(b_char(s, ("
	.ascii	"word)i) & 0xFF);\n    slots[idx][len] = 0;\n    return slots"
	.ascii	"[idx];\n}\n\n/* Duplicate a B string into a freshly allocate"
	.ascii	"d C string */\nstatic char *__b_dup_bstr(word s){\n    size_"
	.ascii	"t cap = 64;\n    char *buf = (char*)malloc(cap);\n    if (!b"
	.ascii	"uf) { fprintf(stderr, \"system: out of memory\\n\"); exit(1)"
	.ascii	"; }\n\n    size_t i = 0;\n    for (;;) {\n        word ch = "
	.ascii	"b_char(s, (word)i);\n        if (ch == 004 || ch == 0) break"
	.ascii	";\n        if (i + 1 >= cap) {\n            size_t ncap = ca"
	.ascii	"p * 2;\n            char *nbuf = (char*)realloc(buf, ncap);\n"
	.ascii	"            if (!nbuf) { free(buf); fprintf(stderr, \"system"
	.ascii	": out of memory\\n\"); exit(1); }\n  "
	.ascii	"          buf = nbuf;\n            cap = ncap;\n        }\n "
	.ascii	"       buf[i++] = (char)(ch & 0xFF);\n    }\n    buf[i] = 0;"
	.ascii	"\n    return buf;\n}\n\nstatic void __b_setargs(int argc, ch"
	.ascii	"ar **argv){\n    __b_argc = argc;\n    __b_argv = argv;\n\n "
	.ascii	"   __b_argvb = (word*)malloc(sizeof(word) * ((size_t)argc + "
	.ascii	"1));\n    if (!__b_argvb) { fprintf(stderr, \"argv: out of m"
	.ascii	"emory\\n\"); exit(1); }\n\n    word *vector = (word*)malloc("
	.ascii	"sizeof(word) * ((size_t)argc + 1));\n    if (!vector) { fpri"
	.ascii	"ntf(stderr, \"argv: out of memory\\n\"); exit(1); }\n    vec"
	.ascii	"tor[0] = WVAL(argc);\n    for (int i = 0; i < argc; i++){\n "
	.ascii	"       __b_argvb[i] = __b_pack_cstr(argv[i]);\n        vecto"
	.ascii	"r[i+1] = __b_pack_cstr(argv[i]);\n        b_lchar(vector[i+1"
	.ascii	"], (word)strlen(argv[i]), 0);\n    }\n    b_argv_vector = B_"
	.ascii	"PTR_N(vector, sizeof(word) * ((size_t)argc + 1));\n}\nstatic"
	.ascii	" word __b_argvalues(void) {\n    return __b_argc ? B_PTR_N(_"
	.ascii	"_b_argvb, sizeof(word) * (size_t)__b_argc) : 0;\n}\n\nstatic"
	.ascii	" word b_argc(void) { return (word)__b_argc; }\n\nstatic word"
	.ascii	" b_argv(word i) {\n    int idx = (int)i;\n    if (idx < 0 ||"
	.ascii	" idx >= __b_argc) return 0;\n    return __b_argvb[idx];\n}\n"
	.ascii	"\nstatic word b_reread(void) {\n    if (__b_argc <= 1) retur"
	.ascii	"n 0;\n\n    /* A pipe can block before its reader starts. St"
	.ascii	"age the replay in an\n       anonymous seekable file instead"
	.ascii	", preserving empty argument fields. */\n    FILE *stream = t"
	.ascii	"mpfile();\n    if (!stream) {\n        fprintf(stderr, \"rer"
	.ascii	"ead: cannot create replay file\\n\");\n        exit(1);\n   "
	.ascii	" }\n    for (int i = 0; i < __b_argc; ++i) {\n        size_t"
	.ascii	" length = strlen(__b_argv[i]);\n        if (fwrite(__b_argv["
	.ascii	"i], 1, length, stream) != length ||\n            fputc(i + 1"
	.ascii	" < __b_argc ? ' ' : '\\n', stream) == EOF)\n            goto"
	.ascii	" failed;\n    }\n    if (fflush(stream) != 0 || fseek(stream"
	.ascii	", 0, SEEK_SET) != 0) goto failed;\n    int descriptor = dup("
	.ascii	"fileno(stream));\n    if (descriptor < 0) goto failed;\n    "
	.ascii	"fclose(stream);\n    __b_sync_rd();\n    if (rd_fd != 0) clo"
	.ascii	"se(rd_fd);\n    rd_fd = descriptor;\n    rd_unit = (word)des"
	.ascii	"criptor;\n    return 0;\n\nfailed:"
	.ascii	"\n    fclose(stream);\n    fprintf(stderr, \"reread: cannot "
	.ascii	"stage command line\\n\");\n    exit(1);\n}\n\n/* I/O functio"
	.ascii	"ns */\nstatic word b_getchr(void) {\n    __b_sync_rd();\n   "
	.ascii	" unsigned char c;\n    ssize_t n = read(rd_fd, &c, 1);\n    "
	.ascii	"if (n == 1) return (word)c;\n    if (rd_fd != 0) {\n        "
	.ascii	"close(rd_fd);\n        rd_fd = 0;\n        rd_unit = -1;\n  "
	.ascii	"      return b_getchr();\n    }\n    return (word)004; /* Re"
	.ascii	"turn *e on EOF */\n}\nstatic word b_putchr(word w) {\n    __"
	.ascii	"b_sync_wr();\n    unsigned char c = (unsigned char)(w & 0xFF"
	.ascii	");\n    (void)write(wr_fd, &c, 1);\n    return w;\n}\nstatic"
	.ascii	" word b_putstr(word s) {\n    __b_sync_wr();\n    word i = 0"
	.ascii	";\n    for (;;) {\n        word ch = __bcc_library_call2(\"c"
	.ascii	"har\", b_char, s, i++);\n        if (ch == 004 || (!__bcc_st"
	.ascii	"rict_runtime && ch == 0)) break;\n        __bcc_library_call"
	.ascii	"1(\"putchar\", b_putchar, ch);\n    }\n    return s;\n}\nsta"
	.ascii	"tic word b_getstr(word buf) {\n    word i = 0;\n    for (;;)"
	.ascii	" {\n        word c = __bcc_library_call0(\"getchar\", b_getc"
	.ascii	"har);\n        if (c == 004 || c == '\\n' || (!__bcc_strict_"
	.ascii	"runtime && c == '\\r')) break;\n        __bcc_library_call3("
	.ascii	"\"lchar\", b_lchar, buf, i++, c);\n    }\n    __bcc_librar"
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
	.ascii	"\n}\nstatic word b_openr(word fd, word name){\n    char buf["
	.ascii	"512];\n    __b_bstr_to_cstr(name, buf, sizeof(buf));\n    in"
	.ascii	"t target = (int)fd;\n    if (target < 0 || buf[0] == '\\0') "
	.ascii	"{\n        rd_fd = 0; rd_unit = -1; return 0;\n    }\n    in"
	.ascii	"t newfd = open(buf, O_RDONLY);\n    if (rd_fd != 0 && rd_fd "
	.ascii	"!= target) close(rd_fd);\n    if (newfd < 0) { rd_fd = -1; r"
	.ascii	"d_unit = (word)target; return -1; }\n    if (newfd != target"
	.ascii	") {\n        if (dup2(newfd, target) < 0) { close(newfd); re"
	.ascii	"turn -1; }\n        close(newfd);\n        newfd = target;\n"
	.ascii	"    }\n    rd_fd = newfd;\n    rd_unit = (word)target;\n    "
	.ascii	"return (word)newfd;\n}\nstatic word b_openw(word fd, word na"
	.ascii	"me){\n    char buf[512];\n    __b_bstr_to_cstr(name, buf, si"
	.ascii	"zeof(buf));\n    int target = (int)fd;\n    if (target < 0 |"
	.ascii	"| buf[0] == '\\0') {\n        wr_fd = 1; wr_unit = -1; retur"
	.ascii	"n 1;\n    }\n    int newfd = open(buf, O_WRONLY | O_CREAT | "
	.ascii	"O_TRUNC, 0666);\n    if (newfd < 0) return -1;\n    if (wr_f"
	.ascii	"d != 1 && wr_fd != target && wr_fd != newfd) close(wr_fd);\n"
	.ascii	"    if (newfd != target) {\n        if (dup2(newfd, target) "
	.ascii	"< 0) { close(newfd); return -1; }\n        close(newfd);\n  "
	.ascii	"      newfd = target;\n    }\n    wr_fd = newfd;\n    wr_uni"
	.ascii	"t = (word)target;\n    return (word)newfd;\n}\nstatic word b"
	.ascii	"_close(word fd) {\n    int cfd = (int)fd;\n    word r = (wor"
	.ascii	"d)close(cfd);\n    if (r == 0) {\n        if (cfd == rd_fd |"
	.ascii	"| cfd == (int)rd_unit) { rd_fd = 0; rd_unit = -1; }\n       "
	.ascii	" if (cfd == wr_fd || cfd == (int)wr_unit) { wr_fd = 1; wr_un"
	.ascii	"it = -1; }\n    }\n    return r;\n}\nstatic word b_read(word"
	.ascii	" fd, word buf, word n) {\n#if WORD_BITS == 16\n    if (n < 0"
	.ascii	") return -1;\n    unsigned char *bytes = malloc(n ? (size_t)"
	.ascii	"n : 1);\n    if (!bytes) return -1;\n    ssize_t count = rea"
	.ascii	"d((int)fd, bytes, (size_t)n);\n    for (ssize_t i = 0; i < c"
	.ascii	"ount; i++) b_lchar(buf"
	.ascii	", (word)i, bytes[i]);\n    free(bytes);\n    return WVAL(cou"
	.ascii	"nt);\n#else\n    char *p = (char*)B_CPTR(buf);\n    return ("
	.ascii	"word)read((int)fd, p, (size_t)n);\n#endif\n}\nstatic word b_"
	.ascii	"write(word fd, word buf, word n) {\n#if WORD_BITS == 16\n   "
	.ascii	" if (n < 0) return -1;\n    unsigned char *bytes = malloc(n "
	.ascii	"? (size_t)n : 1);\n    if (!bytes) return -1;\n    for (word"
	.ascii	" i = 0; i < n; i++) bytes[i] = (unsigned char)b_char(buf, i)"
	.ascii	";\n    ssize_t count = write((int)fd, bytes, (size_t)n);\n  "
	.ascii	"  free(bytes);\n    return WVAL(count);\n#else\n    return ("
	.ascii	"word)write((int)fd, B_CPTR(buf), (size_t)n);\n#endif\n}\nsta"
	.ascii	"tic word b_creat(word name, word mode) {\n    const char *p "
	.ascii	"= __b_cstr(name);\n    return (word)creat(p, __bcc_unix_mode"
	.ascii	"(mode, 0));\n}\nstatic word b_seek(word fd, word offset, wor"
	.ascii	"d whence) {\n    return __bcc_unix_seek(fd, offset, whence);"
	.ascii	"\n}\n\n/* Process control functions - with actual implementa"
	.ascii	"tions */\nstatic word b_fork(void) {\n    return (word)fork("
	.ascii	");\n}\nstatic word __b_wait_status;\n\nstatic word b_wait(vo"
	.ascii	"id) {\n    int st = 0;\n    pid_t pid = wait(&st);\n    __b_"
	.ascii	"wait_status = (word)st;\n    return (word)pid;\n}\n/* B72 se"
	.ascii	"ction 8 passes exactly count argument strings, including arg"
	.ascii	"0. */\nstatic word b_execv(word path, word argv, word count)"
	.ascii	" {\n    if (count < 0 || count > 255 || (count && !argv)) re"
	.ascii	"turn -1;\n    char *name = __b_dup_bstr(path);\n    if (!nam"
	.ascii	"e) return -1;\n    char *arguments[256];\n    word *values ="
	.ascii	" count ? (word*)B_CPTR(argv) : NULL;\n    size_t n = (size_t"
	.ascii	")count, i = 0;\n    for (; i < n; i++) {\n        if (!value"
	.ascii	"s[i]) break;\n        arguments[i] = __b_dup_bstr(values[i])"
	.ascii	";\n        if (!arguments[i]) break;\n    }\n    if (i == n)"
	.ascii	" {\n        arguments[n] = NULL;\n        execv(name, argume"
	.ascii	"nts);\n    }\n    while (i) free(arguments[--i]);\n    free("
	.ascii	"name);\n    return -1;\n}\n\nstatic word b_execl(word path, "
	.ascii	"...) {\n    char *name = __b_dup_bstr(path);\n    if (!name)"
	.ascii	" return -1;\n    char *arguments[256];\n    size_t n = 0;\n "
	.ascii	"   int complete = 0;\n    va_list ap;\n    va_start(ap, path"
	.ascii	");\n    while (n < 255) {\n     "
	.ascii	"   word value = va_arg(ap, word);\n        if (!value) { com"
	.ascii	"plete = 1; break; }\n        arguments[n] = __b_dup_bstr(val"
	.ascii	"ue);\n        if (!arguments[n]) break;\n        n++;\n    }"
	.ascii	"\n    va_end(ap);\n    if (complete) {\n        arguments[n]"
	.ascii	" = NULL;\n        execv(name, arguments);\n    }\n    while "
	.ascii	"(n) free(arguments[--n]);\n    free(name);\n    return -1;\n"
	.ascii	"}\n\nstatic word b_system(word cmd) {\n    /* Split argument"
	.ascii	"s without invoking a shell or expanding their contents. */\n"
	.ascii	"    char *line = __b_dup_bstr(cmd);\n    if (!line) return -"
	.ascii	"1;\n    char *argv[128];\n    size_t argc = 0;\n    char *p "
	.ascii	"= line, *q = line;\n    while (*p) {\n        while (*p && i"
	.ascii	"sspace((unsigned char)*p)) p++;\n        if (!*p) break;\n  "
	.ascii	"      if (argc + 1 >= sizeof(argv)/sizeof(argv[0])) { free(l"
	.ascii	"ine); return -1; }\n        argv[argc++] = q;\n        int q"
	.ascii	"uote = 0;\n        while (*p && (quote || !isspace((unsigned"
	.ascii	" char)*p))) {\n            unsigned char c = (unsigned char)"
	.ascii	"*p++;\n            if (c == '\\\\' && quote != '\\'') {\n   "
	.ascii	"             if (!*p) { free(line); return -1; }\n          "
	.ascii	"      *q++ = *p++;\n            } else if (c == '\\'' || c ="
	.ascii	"= '\"') {\n                if (!quote) quote = c;\n         "
	.ascii	"       else if (quote == c) quote = 0;\n                else"
	.ascii	" *q++ = (char)c;\n            } else *q++ = (char)c;\n      "
	.ascii	"  }\n        if (quote) { free(line); return -1; }\n        "
	.ascii	"if (*p) p++;\n        *q++ = 0;\n    }\n    if (argc == 0) {"
	.ascii	" free(line); return -1; }\n    argv[argc] = NULL;\n    pid_t"
	.ascii	" pid = fork();\n    if (pid == 0) {\n        execvp(argv[0],"
	.ascii	" argv);\n        _exit(127);\n    }\n    if (pid < 0) { free"
	.ascii	"(line); return -1; }\n    int st = 0;\n    pid_t w;\n    do "
	.ascii	"{ w = waitpid(pid, &st, 0); } while (w < 0 && errno == EINTR"
	.ascii	");\n    free(line);\n    if (w < 0) return -1;\n    return ("
	.ascii	"word)st;\n}\n\nstatic word b_usleep(word usec) {\n    usleep"
	.ascii	"((useconds_t)usec);\n    return 0;\n}\n\nstatic word b_callf"
	.ascii	"_dispatch(int nargs, word name, ...) {\n    static int __b_c"
	.ascii	"allf_dl_done = 0;\n    if (!__b_callf_dl_done) {\n        __"
	.ascii	"b_callf_dl_done = 1;\n        cons"
	.ascii	"t char *env = getenv(\"B_CALLF_LIB\");\n        if (env && *"
	.ascii	"env) {\n            const char *p = env;\n            while "
	.ascii	"(*p) {\n                const char *start = p;\n            "
	.ascii	"    while (*p && *p != ':') p++;\n                size_t len"
	.ascii	" = (size_t)(p - start);\n                if (len) {\n       "
	.ascii	"             char *path = (char*)malloc(len + 1);\n         "
	.ascii	"           if (path) {\n                        memcpy(path,"
	.ascii	" start, len);\n                        path[len] = '\\0';\n "
	.ascii	"                       (void)dlopen(path, RTLD_NOW | RTLD_GL"
	.ascii	"OBAL);\n                        free(path);\n               "
	.ascii	"     }\n                }\n                if (*p == ':') p+"
	.ascii	"+;\n            }\n        }\n    }\n    if (nargs < 0 || na"
	.ascii	"rgs > 10) return -1;\n    if (name == 0) return -1;\n \n    "
	.ascii	"char sym[256];\n    __b_bstr_to_cstr(name, sym, sizeof(sym))"
	.ascii	";\n \n    void *fn = dlsym(RTLD_DEFAULT, sym);\n    if (!fn)"
	.ascii	" {\n        size_t len = strlen(sym);\n        if (len + 2 <"
	.ascii	" sizeof(sym)) {\n            sym[len] = '_'; sym[len + 1] = "
	.ascii	"'\\0';\n            fn = dlsym(RTLD_DEFAULT, sym);\n        "
	.ascii	"    sym[len] = '\\0';\n        }\n    }\n    if (!fn) return"
	.ascii	" -1;\n \n    void *args[10] = {0};\n    va_list ap;\n    va_"
	.ascii	"start(ap, name);\n    for (int i = 0; i < nargs && i < 10; i"
	.ascii	"++) {\n        word w = va_arg(ap, word);\n        args[i] ="
	.ascii	" B_CPTR(w);\n    }\n    va_end(ap);\n \n    word r = 0;\n   "
	.ascii	" switch (nargs) {\n    case 0: r = ((word (*)(void))fn)(); b"
	.ascii	"reak;\n    case 1: r = ((word (*)(void*))fn)(args[0]); break"
	.ascii	";\n    case 2: r = ((word (*)(void*, void*))fn)(args[0], arg"
	.ascii	"s[1]); break;\n    case 3: r = ((word (*)(void*, void*, void"
	.ascii	"*))fn)(args[0], args[1], args[2]); break;\n    case 4: r = ("
	.ascii	"(word (*)(void*, void*, void*, void*))fn)(args[0], args[1], "
	.ascii	"args[2], args[3]); break;\n    case 5: r = ((word (*)(void*,"
	.ascii	" void*, void*, void*, void*))fn)(args[0], args[1], args[2], "
	.ascii	"args[3], args[4]); break;\n    case 6: r = ((word (*)(void*,"
	.ascii	" void*, void*, void*, void*, void*))fn)(args[0], args[1], ar"
	.ascii	"gs[2], args[3], args[4], args[5]); break;\n    case 7: r = ("
	.ascii	"(word (*)(void*, voi"
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
	.ascii	"(ticks & 65535);\n    }\n    return 0;\n}\n\n/* B72 section "
	.ascii	"8 specifies a caller-owned, 16-byte date buffer. */\nstatic "
	.ascii	"word b_ctime(word tvp, word date) {\n    if (!tvp || !date) "
	.ascii	"return -1;\n    word *tv = (word*)B_CPTR(tvp);\n    uint32_t"
	.ascii	" ticks = ((uint32_t)(uint16_t)tv[0] << 16) | (uint16_t)tv[1]"
	.ascii	";\n    unsigned days = ticks / 5184000U;\n    unsigned secon"
	.ascii	"ds = ticks / 60U % 86400U;\n    unsigned year = 1971, month "
	.ascii	"= 0;\n    while (days >= (year % 4 == 0 ? 366U : 365U)) {\n "
	.ascii	"       days -= year % 4 == 0 ? 366U : 365U;\n        year++;"
	.ascii	"\n    }\n    static const unsigned lengths[] = {31,28,31,30,"
	.ascii	"31,30,31,31,30,31,30,31};\n    static const char *months[] ="
	.ascii	" {\"Jan\",\"Feb\",\"Mar\",\"Apr\",\"May\",\"Jun\",\"Jul\",\""
	.ascii	"Aug\",\"Sep\",\"Oct\",\"Nov\",\"Dec\"};\n    for (;;) {\n   "
	.ascii	"     unsigned length = "
	.ascii	"lengths[month] + (month == 1 && year % 4 == 0);\n        if "
	.ascii	"(days < length) break;\n        days -= length;\n        mon"
	.ascii	"th++;\n    }\n    char text[16];\n    snprintf(text, sizeof("
	.ascii	"text), \"%s %2u %02u:%02u:%02u\", months[month], days + 1,\n"
	.ascii	"             seconds / 3600, seconds / 60 % 60, seconds % 60"
	.ascii	");\n    for (size_t i = 0; i < sizeof(text); i++) b_lchar(da"
	.ascii	"te, (word)i, (word)(unsigned char)text[i]);\n    return 0;\n"
	.ascii	"}\n\nstatic word b_getuid(void) {\n    return (word)getuid()"
	.ascii	";\n}\nstatic word b_chdir(word path) {\n    const char *p = "
	.ascii	"__b_cstr(path);\n    return (word)chdir(p);\n}\nstatic word "
	.ascii	"b_unlink(word path) {\n    const char *p = __b_cstr(path);\n"
	.ascii	"    return (word)unlink(p);\n}\n\n/* System functions with a"
	.ascii	"ctual implementations */\nstatic word b_chmod(word path, wor"
	.ascii	"d mode) {\n    const char *p = __b_cstr(path);\n    return ("
	.ascii	"word)chmod(p, __bcc_unix_mode(mode, 0));\n}\nstatic word b_c"
	.ascii	"hown(word path, word owner) {\n    const char *p = __b_cstr("
	.ascii	"path);\n    return (word)chown(p, (uid_t)owner, (gid_t)-1);\n"
	.ascii	"}\nstatic word b_link(word old, word new) {\n    const char "
	.ascii	"*o = __b_cstr(old);\n    const char *n = __b_cstr(new);\n   "
	.ascii	" return (word)link(o, n);\n}\nstatic word b_stat(word path, "
	.ascii	"word bufp) {\n    if (!bufp) { errno = EFAULT; return -1; }\n"
	.ascii	"    const char *p = __b_cstr(path);\n    struct stat st;\n  "
	.ascii	"  if (stat(p, &st) != 0) return -1;\n    __bcc_unix_stat((wo"
	.ascii	"rd*)B_CPTR(bufp), &st);\n    return 0;\n}\n\nstatic word b_f"
	.ascii	"stat(word fd, word bufp) {\n    if (!bufp) { errno = EFAULT;"
	.ascii	" return -1; }\n    struct stat st;\n    if (fstat((int)fd, &"
	.ascii	"st) != 0) return -1;\n    __bcc_unix_stat((word*)B_CPTR(bufp"
	.ascii	"), &st);\n    return 0;\n}\n\nstatic word b_setuid(word uid)"
	.ascii	" {\n    return (word)setuid((uid_t)uid);\n}\nstatic word b_m"
	.ascii	"akdir(word path, word mode) {\n    const char *p = __b_cstr("
	.ascii	"path);\n    return (word)mkdir(p, __bcc_unix_mode(mode, 1));"
	.ascii	"\n}\n\nstatic word b_mkdir(word path, word mode) { return b_"
	.ascii	"makdir(path, mode); }\nstatic word b_putnum(word n) {\n    _"
	.ascii	"_bcc_library_call2(\"printn\", b_printn, n, (word)10);\n    "
	.ascii	"return n;\n}\nstatic word b_gt"
	.ascii	"ty(word fd, word ttstat){\n    if (!ttstat) { errno = EFAULT"
	.ascii	"; return -1; }\n    struct termios t;\n    if (tcgetattr((in"
	.ascii	"t)fd, &t) < 0) return -1;\n\n    word *vec = (word*)B_CPTR(t"
	.ascii	"tstat);\n    vec[0] = (word)t.c_iflag;\n    vec[1] = (word)t"
	.ascii	".c_oflag;\n    vec[2] = (word)t.c_lflag;\n    return 0;\n}\n"
	.ascii	"\nstatic word b_stty(word fd, word ttstat){\n    if (!ttstat"
	.ascii	") { errno = EFAULT; return -1; }\n    struct termios t;\n   "
	.ascii	" if (tcgetattr((int)fd, &t) < 0) return -1;\n\n    word *vec"
	.ascii	" = (word*)B_CPTR(ttstat);\n    t.c_iflag = (tcflag_t)vec[0];"
	.ascii	"\n    t.c_oflag = (tcflag_t)vec[1];\n    t.c_lflag = (tcflag"
	.ascii	"_t)vec[2];\n    return (word)tcse"
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
.LFB67:
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
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	movq	%rsi, %rdi
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movaps	%xmm0, external_calls(%rip)
	pxor	%xmm0, %xmm0
	movq	%rdx, 8(%rsp)
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
	jne	.L1691
.L1669:
	movq	%rbx, %rcx
	movl	$1529, %edx
	movl	$1, %esi
	leaq	.LC194(%rip), %rdi
	call	fwrite@PLT
	movl	g_strict(%rip), %eax
	xorl	%edx, %edx
	movq	%rbx, %rdi
	leaq	.LC195(%rip), %rsi
	testl	%eax, %eax
	setne	%dl
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbx, %rdi
	setne	%dl
	leaq	.LC196(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%r12d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC197(%rip), %rsi
	leaq	24(%rsp), %r12
	call	fprintf@PLT
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
	movq	24(%rsp), %rdx
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
	movq	24(%rsp), %rdx
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
	movq	24(%rsp), %rdx
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
	je	.L1692
.L1670:
	movq	g_libb_path(%rip), %rsi
	leaq	.LC205(%rip), %rdi
	xorl	%eax, %eax
	call	fmt@PLT
	movq	%r12, %rsi
	movq	%rax, %rdi
	call	read_file_all@PLT
	movq	24(%rsp), %rdx
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
	movl	$11398, %edx
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
	movq	24(%rsp), %rdx
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
	movl	$12868, %edx
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
	movq	24(%rsp), %rdx
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
	je	.L1693
.L1671:
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1694
.L1672:
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
	je	.L1668
	xorl	%r15d, %r15d
	xorl	%r13d, %r13d
	xorl	%r14d, %r14d
	jmp	.L1677
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1674:
	addq	$1, %r15
	cmpq	8(%rbp), %r15
	jnb	.L1695
.L1677:
	movq	0(%rbp), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L1674
	movq	8(%rax), %r12
	leaq	.LC15(%rip), %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1675
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	movq	16(%r12), %r13
	leaq	.LC212(%rip), %rdi
	movl	$1, %r14d
	call	fwrite@PLT
.L1676:
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
	jb	.L1677
.L1695:
	testl	%r14d, %r14d
	jne	.L1696
.L1668:
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
.L1675:
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
	jmp	.L1676
	.p2align 4,,10
	.p2align 3
.L1691:
	movq	%rbx, %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC193(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1669
	.p2align 4,,10
	.p2align 3
.L1696:
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
	movl	$2, %edx
	leaq	.LC217(%rip), %rsi
	movq	%rbx, %rdi
	cmpq	%rdx, %r13
	cmovbe	%r13, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
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
	jne	.L1697
.L1681:
	movq	%rbx, %rcx
	movl	$3, %edx
	movl	$1, %esi
	leaq	.LC24(%rip), %rdi
	call	fwrite@PLT
	addq	$40, %rsp
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
.L1694:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1672
	.p2align 4,,10
	.p2align 3
.L1693:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L1671
	.p2align 4,,10
	.p2align 3
.L1692:
	movq	%r14, %rdi
	call	free@PLT
	jmp	.L1670
	.p2align 4,,10
	.p2align 3
.L1697:
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC218(%rip), %rdi
	call	fwrite@PLT
	cmpq	$1, %r13
	je	.L1681
	movq	%rbx, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC219(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1681
	.cfi_endproc
.LFE67:
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
.LFB68:
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
	movl	80(%rsp), %edi
	testl	%edi, %edi
	je	.L1720
	pxor	%xmm0, %xmm0
	movq	%rsi, %rdi
	movl	%r9d, current_word_bits(%rip)
	movaps	%xmm0, external_calls(%rip)
	pxor	%xmm0, %xmm0
	movups	%xmm0, 8+string_pool(%rip)
	movq	%rsi, current_program(%rip)
	movl	%ecx, current_byteptr(%rip)
	movq	$0, 16+external_calls(%rip)
	movq	$0, string_pool(%rip)
	movq	$0, 8+name_map(%rip)
	call	collect_strings_program
	movq	%rbx, %rcx
	movl	$36, %edx
	movl	$1, %esi
	leaq	.LC220(%rip), %rdi
	call	fwrite@PLT
	movl	g_strict(%rip), %ecx
	xorl	%edx, %edx
	movq	%rbx, %rdi
	leaq	.LC195(%rip), %rsi
	testl	%ecx, %ecx
	setne	%dl
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%edx, %edx
	testl	%r13d, %r13d
	movq	%rbx, %rdi
	setne	%dl
	leaq	.LC196(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	%r12d, %edx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	leaq	.LC197(%rip), %rsi
	call	fprintf@PLT
	movl	$1, %esi
	movq	%rbx, %rcx
	movl	$19, %edx
	leaq	.LC221(%rip), %rdi
	call	fwrite@PLT
	movl	g_use_curses(%rip), %esi
	testl	%esi, %esi
	jne	.L1721
	cmpq	$0, 8+string_pool(%rip)
	jne	.L1722
.L1701:
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
	je	.L1698
	movl	$0, 12(%rsp)
	xorl	%r15d, %r15d
	xorl	%r13d, %r13d
	jmp	.L1706
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1703:
	addq	$1, %r15
	cmpq	8(%r14), %r15
	jnb	.L1723
.L1706:
	movq	(%r14), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L1703
	movq	8(%rax), %r12
	leaq	.LC15(%rip), %rsi
	movq	(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L1704
	movq	%rbx, %rcx
	movl	$19, %edx
	movl	$1, %esi
	movq	16(%r12), %r13
	leaq	.LC212(%rip), %rdi
	call	fwrite@PLT
	movl	$1, 12(%rsp)
.L1705:
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
	jb	.L1706
.L1723:
	movl	12(%rsp), %eax
	testl	%eax, %eax
	jne	.L1724
.L1698:
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
.L1704:
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
	jmp	.L1705
	.p2align 4,,10
	.p2align 3
.L1722:
	movq	%rbx, %rdi
	call	emit_string_pool
	movq	%rbx, %rsi
	movl	$10, %edi
	call	fputc@PLT
	jmp	.L1701
	.p2align 4,,10
	.p2align 3
.L1721:
	movq	%rbx, %rcx
	movl	$41, %edx
	movl	$1, %esi
	leaq	.LC222(%rip), %rdi
	call	fwrite@PLT
	cmpq	$0, 8+string_pool(%rip)
	je	.L1701
	jmp	.L1722
	.p2align 4,,10
	.p2align 3
.L1724:
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
	movl	$2, %edx
	leaq	.LC217(%rip), %rsi
	movq	%rbx, %rdi
	cmpq	%rdx, %r13
	cmovbe	%r13, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
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
	jne	.L1725
.L1710:
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
.L1720:
	.cfi_restore_state
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
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
	jmp	emit_program_c
	.p2align 4,,10
	.p2align 3
.L1725:
	.cfi_restore_state
	movq	%rbx, %rcx
	movl	$12, %edx
	movl	$1, %esi
	leaq	.LC218(%rip), %rdi
	call	fwrite@PLT
	cmpq	$1, %r13
	je	.L1710
	movq	%rbx, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC219(%rip), %rdi
	call	fwrite@PLT
	jmp	.L1710
	.cfi_endproc
.LFE68:
	.size	emit_program_c_ext, .-emit_program_c_ext
	.section	.rodata
	.align 16
	.type	CSWTCH.183, @object
	.size	CSWTCH.183, 24
CSWTCH.183:
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
