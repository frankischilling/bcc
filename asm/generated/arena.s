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
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	$16, %edi
	call	malloc@PLT
	movq	%rax, %rdx
	testq	%rax, %rax
	je	.L5
.L2:
	pxor	%xmm0, %xmm0
	movq	%rdx, %rax
	movups	%xmm0, (%rdx)
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L5:
	.cfi_restore_state
	movq	%rax, 8(%rsp)
	leaq	.LC0(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	8(%rsp), %rdx
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbx, 24(%rsp)
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	testq	%rdi, %rdi
	je	.L56
.L33:
	movq	8(%rbx), %rdx
	addq	$7, %rsi
	andq	$-8, %rsi
	testq	%rdx, %rdx
	je	.L34
	movq	8(%rdx), %rax
	leaq	(%rax,%rsi), %rcx
	cmpq	%rcx, 16(%rdx)
	jnb	.L36
	movq	%rbp, 32(%rsp)
	.cfi_offset 6, -16
	movl	$65536, %ebp
	cmpq	%rbp, %rsi
	movq	%rsi, (%rsp)
	cmovnb	%rsi, %rbp
	movq	%rdx, 8(%rsp)
	leaq	24(%rbp), %rdi
	call	malloc@PLT
	movq	(%rsp), %rsi
	testq	%rax, %rax
	je	.L40
	movq	$0, (%rax)
	movq	8(%rsp), %rcx
	movq	%rax, %rdx
	movq	$0, 8(%rax)
	movq	%rbp, 16(%rax)
.L39:
	movq	%rdx, (%rcx)
.L38:
	movq	%rdx, 8(%rbx)
	movq	32(%rsp), %rbp
	.cfi_restore 6
	movq	%rsi, %rcx
	xorl	%eax, %eax
.L36:
	movq	%rcx, 8(%rdx)
	movq	24(%rsp), %rbx
	leaq	24(%rdx,%rax), %rax
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L34:
	.cfi_restore_state
	movq	%rbp, 32(%rsp)
	.cfi_offset 6, -16
	movl	$65536, %ebp
	cmpq	%rbp, %rsi
	movq	%rsi, (%rsp)
	cmovnb	%rsi, %rbp
	leaq	24(%rbp), %rdi
	call	malloc@PLT
	movq	(%rsp), %rsi
	testq	%rax, %rax
	movq	%rax, %rdx
	je	.L40
	movq	$0, (%rdx)
	movq	$0, 8(%rdx)
	movq	%rbp, 16(%rdx)
.L37:
	movq	%rdx, (%rbx)
	jmp	.L38
	.p2align 4,,10
	.p2align 3
.L56:
	.cfi_restore 6
	leaq	.LC1(%rip), %rdi
	xorl	%eax, %eax
	movq	%rsi, (%rsp)
	call	dief@PLT
	movq	(%rsp), %rsi
	jmp	.L33
.L40:
	.cfi_offset 6, -16
	xorl	%eax, %eax
	leaq	.LC0(%rip), %rdi
	movq	%rsi, (%rsp)
	call	dief@PLT
	movq	8(%rbx), %rdx
	movq	(%rsp), %rsi
	movq	$0, 0
	movq	$0, 8
	testq	%rdx, %rdx
	movq	%rbp, 16
	je	.L37
	movq	%rdx, %rcx
	xorl	%edx, %edx
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
	je	.L58
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
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 24
	movq	%rax, %rdi
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 8
	jmp	memcpy@PLT
	.p2align 4,,10
	.p2align 3
.L58:
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
	movl	$1, %eax
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rcx, %rbx
	subq	%rdx, %rbx
	cmpq	%rcx, %rdx
	leaq	1(%rbx), %rsi
	cmovnb	%rax, %rsi
	xorl	%eax, %eax
	cmpq	%rdx, %rcx
	cmovc	%rax, %rbx
	call	arena_alloc
	leaq	(%r12,%rbp), %rsi
	movq	%rbx, %rdx
	movq	%rax, %rdi
	call	memcpy@PLT
	movb	$0, (%rax,%rbx)
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
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
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$240, %rsp
	.cfi_def_cfa_offset 272
	movq	%rdx, 80(%rsp)
	movq	%rcx, 88(%rsp)
	movq	%r8, 96(%rsp)
	movq	%r9, 104(%rsp)
	testb	%al, %al
	je	.L67
	movaps	%xmm0, 112(%rsp)
	movaps	%xmm1, 128(%rsp)
	movaps	%xmm2, 144(%rsp)
	movaps	%xmm3, 160(%rsp)
	movaps	%xmm4, 176(%rsp)
	movaps	%xmm5, 192(%rsp)
	movaps	%xmm6, 208(%rsp)
	movaps	%xmm7, 224(%rsp)
.L67:
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	leaq	272(%rsp), %rax
	movq	%rbp, %rdx
	xorl	%esi, %esi
	movq	%rax, 16(%rsp)
	leaq	8(%rsp), %rcx
	leaq	64(%rsp), %rax
	xorl	%edi, %edi
	movl	$16, 8(%rsp)
	movl	$48, 12(%rsp)
	movdqu	8(%rsp), %xmm0
	movq	%rax, 24(%rsp)
	movq	%rax, 48(%rsp)
	movups	%xmm0, 32(%rsp)
	call	vsnprintf@PLT
	movslq	%eax, %rbx
	testl	%ebx, %ebx
	js	.L71
.L68:
	movq	%r12, %rdi
	leaq	1(%rbx), %rsi
	call	arena_alloc
	leaq	32(%rsp), %rcx
	movq	%rbp, %rdx
	leaq	1(%rbx), %rsi
	movq	%rax, %rdi
	movq	%rax, %r12
	call	vsnprintf@PLT
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L72
	addq	$240, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%r12, %rax
	popq	%rbx
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
	leaq	.LC2(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L68
.L72:
	call	__stack_chk_fail@PLT
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
	testq	%rdi, %rdi
	je	.L84
	movq	8(%rdi), %rdx
	xorl	%eax, %eax
	testq	%rdx, %rdx
	je	.L81
	movq	8(%rdx), %rax
.L81:
	xchgq	%rdx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L84:
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	xorl	%eax, %eax
	movq	%rdi, 8(%rsp)
	leaq	.LC3(%rip), %rdi
	call	dief@PLT
	movq	8(%rsp), %rdx
	xorl	%eax, %eax
	movq	8(%rdx), %rdx
	testq	%rdx, %rdx
	je	.L75
	movq	8(%rdx), %rax
.L75:
	xchgq	%rdx, %rax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
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
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%rdx, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	testq	%rdi, %rdi
	je	.L98
.L86:
	testq	%rbp, %rbp
	je	.L87
	movq	0(%rbp), %rbx
	testq	%rbx, %rbx
	je	.L92
	.p2align 4
	.p2align 3
.L91:
	movq	%rbx, %rdi
	movq	(%rbx), %rbx
	call	free@PLT
	testq	%rbx, %rbx
	jne	.L91
	testq	%rbp, %rbp
	je	.L90
.L92:
	movq	$0, 0(%rbp)
	movq	%r13, 8(%rbp)
	movq	%rbp, 8(%r12)
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
.L87:
	.cfi_restore_state
	movq	(%r12), %rbx
	testq	%rbx, %rbx
	jne	.L91
.L90:
	movq	$0, (%r12)
	movq	%rbp, 8(%r12)
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
.L98:
	.cfi_restore_state
	leaq	.LC4(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L86
	.cfi_endproc
.LFE23:
	.size	arena_rewind, .-arena_rewind
	.ident	"GCC: (GNU) 16.1.1 20260430"
	.section	.note.GNU-stack,"",@progbits
