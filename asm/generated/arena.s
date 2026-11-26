	.file	"arena.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"out of memory"
	.text
	.p2align 4
	.globl	arena_new
	.type	arena_new, @function
arena_new:
.LFB14:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$16, %edi
	call	malloc@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L5
.L2:
	pxor	%xmm0, %xmm0
	movq	%rbx, %rax
	movups	%xmm0, (%rbx)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L5:
	.cfi_restore_state
	leaq	.LC0(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L2
	.cfi_endproc
.LFE14:
	.size	arena_new, .-arena_new
	.p2align 4
	.globl	arena_free
	.type	arena_free, @function
arena_free:
.LFB16:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L6
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	(%rdi), %rbx
	testq	%rbx, %rbx
	je	.L8
	.p2align 4
	.p2align 3
.L9:
	movq	%rbx, %rdi
	movq	(%rbx), %rbx
	call	free@PLT
	testq	%rbx, %rbx
	jne	.L9
.L8:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	jmp	free@PLT
	.p2align 4,,10
	.p2align 3
.L6:
	ret
	.cfi_endproc
.LFE16:
	.size	arena_free, .-arena_free
	.p2align 4
	.globl	arena_reset
	.type	arena_reset, @function
arena_reset:
.LFB17:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L29
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	(%rdi), %rbx
	testq	%rbx, %rbx
	je	.L19
	.p2align 4
	.p2align 3
.L20:
	movq	%rbx, %rdi
	movq	(%rbx), %rbx
	call	free@PLT
	testq	%rbx, %rbx
	jne	.L20
.L19:
	pxor	%xmm0, %xmm0
	movups	%xmm0, 0(%rbp)
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L29:
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE17:
	.size	arena_reset, .-arena_reset
	.section	.rodata.str1.1
.LC1:
	.string	"arena_alloc: NULL arena"
	.text
	.p2align 4
	.globl	arena_alloc
	.type	arena_alloc, @function
arena_alloc:
.LFB18:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rsi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	testq	%rdi, %rdi
	je	.L56
.L33:
	movq	8(%r12), %rbp
	addq	$7, %rbx
	andq	$-8, %rbx
	testq	%rbp, %rbp
	je	.L34
	movq	8(%rbp), %rax
	leaq	(%rax,%rbx), %rdx
	cmpq	%rdx, 16(%rbp)
	jnb	.L36
	movl	$65536, %r13d
	cmpq	%r13, %rbx
	cmovnb	%rbx, %r13
	leaq	24(%r13), %rdi
	call	malloc@PLT
	testq	%rax, %rax
	je	.L40
	movq	$0, (%rax)
	movq	%rbp, %rdx
	movq	%rax, %rbp
	movq	$0, 8(%rax)
	movq	%r13, 16(%rax)
.L39:
	movq	%rbp, (%rdx)
.L38:
	movq	%rbp, 8(%r12)
	movq	%rbx, %rdx
	xorl	%eax, %eax
.L36:
	movq	%rdx, 8(%rbp)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	leaq	24(%rbp,%rax), %rax
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
.L34:
	.cfi_restore_state
	movl	$65536, %r13d
	cmpq	%r13, %rbx
	cmovnb	%rbx, %r13
	leaq	24(%r13), %rdi
	call	malloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L40
	movq	$0, 0(%rbp)
	movq	$0, 8(%rbp)
	movq	%r13, 16(%rbp)
.L37:
	movq	%rbp, (%r12)
	jmp	.L38
	.p2align 4,,10
	.p2align 3
.L56:
	leaq	.LC1(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L33
.L40:
	leaq	.LC0(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	8(%r12), %rbp
	movq	$0, 0
	movq	$0, 8
	movq	%r13, 16
	testq	%rbp, %rbp
	je	.L37
	movq	%rbp, %rdx
	xorl	%ebp, %ebp
	jmp	.L39
	.cfi_endproc
.LFE18:
	.size	arena_alloc, .-arena_alloc
	.p2align 4
	.globl	arena_sdup
	.type	arena_sdup, @function
arena_sdup:
.LFB19:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L59
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	movq	%rsi, %rdi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rsi, %rbx
	call	strlen@PLT
	movq	%r12, %rdi
	leaq	1(%rax), %rbp
	movq	%rbp, %rsi
	call	arena_alloc
	movq	%rbp, %rdx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	memcpy@PLT
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L59:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE19:
	.size	arena_sdup, .-arena_sdup
	.p2align 4
	.globl	arena_xstrdup_range
	.type	arena_xstrdup_range, @function
arena_xstrdup_range:
.LFB20:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdx, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	cmpq	%rcx, %rdx
	jnb	.L66
	movq	%rcx, %rbx
	subq	%rdx, %rbx
	leaq	1(%rbx), %rsi
.L65:
	call	arena_alloc
	leaq	0(%rbp,%r12), %rsi
	movq	%rbx, %rdx
	movq	%rax, %rdi
	call	memcpy@PLT
	movb	$0, (%rax,%rbx)
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
.L66:
	.cfi_restore_state
	movl	$1, %esi
	xorl	%ebx, %ebx
	jmp	.L65
	.cfi_endproc
.LFE20:
	.size	arena_xstrdup_range, .-arena_xstrdup_range
	.section	.rodata.str1.1
.LC2:
	.string	"arena_fmt: vsnprintf failed"
	.text
	.p2align 4
	.globl	arena_fmt
	.type	arena_fmt, @function
arena_fmt:
.LFB21:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$224, %rsp
	.cfi_def_cfa_offset 256
	movq	%rdx, 64(%rsp)
	movq	%rcx, 72(%rsp)
	movq	%r8, 80(%rsp)
	movq	%r9, 88(%rsp)
	testb	%al, %al
	je	.L71
	movaps	%xmm0, 96(%rsp)
	movaps	%xmm1, 112(%rsp)
	movaps	%xmm2, 128(%rsp)
	movaps	%xmm3, 144(%rsp)
	movaps	%xmm4, 160(%rsp)
	movaps	%xmm5, 176(%rsp)
	movaps	%xmm6, 192(%rsp)
	movaps	%xmm7, 208(%rsp)
.L71:
	leaq	256(%rsp), %rax
	movq	%rsp, %rcx
	movq	%r12, %rdx
	xorl	%esi, %esi
	movq	%rax, 8(%rsp)
	xorl	%edi, %edi
	leaq	48(%rsp), %rax
	movl	$16, (%rsp)
	movl	$48, 4(%rsp)
	movdqu	(%rsp), %xmm0
	movq	%rax, 16(%rsp)
	movq	%rax, 40(%rsp)
	movups	%xmm0, 24(%rsp)
	call	vsnprintf@PLT
	movslq	%eax, %rbx
	testl	%ebx, %ebx
	js	.L73
.L70:
	addq	$1, %rbx
	movq	%rbp, %rdi
	movq	%rbx, %rsi
	call	arena_alloc
	leaq	24(%rsp), %rcx
	movq	%r12, %rdx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	movq	%rax, %rbp
	call	vsnprintf@PLT
	addq	$224, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%rbp, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L73:
	.cfi_restore_state
	leaq	.LC2(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L70
	.cfi_endproc
.LFE21:
	.size	arena_fmt, .-arena_fmt
	.section	.rodata.str1.1
.LC3:
	.string	"arena_mark: NULL arena"
	.text
	.p2align 4
	.globl	arena_mark
	.type	arena_mark, @function
arena_mark:
.LFB22:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	testq	%rdi, %rdi
	je	.L80
.L75:
	movq	8(%rbx), %rdx
	xorl	%eax, %eax
	testq	%rdx, %rdx
	je	.L76
	movq	8(%rdx), %rax
.L76:
	xchgq	%rdx, %rax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L80:
	.cfi_restore_state
	leaq	.LC3(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L75
	.cfi_endproc
.LFE22:
	.size	arena_mark, .-arena_mark
	.section	.rodata.str1.1
.LC4:
	.string	"arena_rewind: NULL arena"
	.text
	.p2align 4
	.globl	arena_rewind
	.type	arena_rewind, @function
arena_rewind:
.LFB23:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movq	%rdx, %r14
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	testq	%rdi, %rdi
	je	.L94
.L82:
	testq	%rbp, %rbp
	je	.L83
	movq	0(%rbp), %rbx
	testq	%rbx, %rbx
	je	.L88
	.p2align 4
	.p2align 3
.L87:
	movq	%rbx, %rdi
	movq	(%rbx), %rbx
	call	free@PLT
	testq	%rbx, %rbx
	jne	.L87
	testq	%rbp, %rbp
	je	.L86
.L88:
	movq	$0, 0(%rbp)
	movq	%r14, 8(%rbp)
	movq	%r13, 8(%r12)
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
.L83:
	.cfi_restore_state
	movq	(%r12), %rbx
	testq	%rbx, %rbx
	jne	.L87
.L86:
	xorl	%r13d, %r13d
	movq	$0, (%r12)
	movq	%r13, 8(%r12)
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
.L94:
	.cfi_restore_state
	leaq	.LC4(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L82
	.cfi_endproc
.LFE23:
	.size	arena_rewind, .-arena_rewind
	.section	.note.GNU-stack,"",@progbits
