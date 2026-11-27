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
.LFB49:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$16, %edi
	call	malloc@PLT
	testq	%rax, %rax
	je	.L5
	pxor	%xmm0, %xmm0
	movups	%xmm0, (%rax)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L5:
	.cfi_restore_state
	leaq	.LC0(%rip), %rdi
	call	dief@PLT
	.cfi_endproc
.LFE49:
	.size	arena_new, .-arena_new
	.p2align 4
	.globl	arena_free
	.type	arena_free, @function
arena_free:
.LFB51:
	.cfi_startproc
	endbr64
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
	.p2align 4,,10
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
.LFE51:
	.size	arena_free, .-arena_free
	.p2align 4
	.globl	arena_reset
	.type	arena_reset, @function
arena_reset:
.LFB52:
	.cfi_startproc
	endbr64
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
	.p2align 4,,10
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
.LFE52:
	.size	arena_reset, .-arena_reset
	.section	.rodata.str1.1
.LC1:
	.string	"arena_alloc: NULL arena"
	.text
	.p2align 4
	.globl	arena_alloc
	.type	arena_alloc, @function
arena_alloc:
.LFB53:
	.cfi_startproc
	endbr64
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
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	testq	%rdi, %rdi
	je	.L51
	movq	8(%rdi), %rbp
	leaq	7(%rsi), %rbx
	movq	%rdi, %r12
	andq	$-8, %rbx
	testq	%rbp, %rbp
	je	.L34
	movq	8(%rbp), %rax
	leaq	(%rax,%rbx), %rdx
	cmpq	%rdx, 16(%rbp)
	jnb	.L36
	movl	$65536, %eax
	cmpq	%rax, %rbx
	cmovnb	%rbx, %rax
	leaq	24(%rax), %rdi
	movq	%rax, %r13
	call	malloc@PLT
	testq	%rax, %rax
	je	.L38
	movq	$0, (%rax)
	movq	$0, 8(%rax)
	movq	%r13, 16(%rax)
	movq	%rax, 0(%rbp)
	movq	%rax, %rbp
.L37:
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
	je	.L38
	movq	$0, 0(%rbp)
	movq	$0, 8(%rbp)
	movq	%r13, 16(%rbp)
	movq	%rbp, (%r12)
	jmp	.L37
.L38:
	leaq	.LC0(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L51:
	leaq	.LC1(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.cfi_endproc
.LFE53:
	.size	arena_alloc, .-arena_alloc
	.p2align 4
	.globl	arena_sdup
	.type	arena_sdup, @function
arena_sdup:
.LFB54:
	.cfi_startproc
	endbr64
	testq	%rsi, %rsi
	je	.L54
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
.L54:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE54:
	.size	arena_sdup, .-arena_sdup
	.p2align 4
	.globl	arena_xstrdup_range
	.type	arena_xstrdup_range, @function
arena_xstrdup_range:
.LFB55:
	.cfi_startproc
	endbr64
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
	jnb	.L61
	movq	%rcx, %rbx
	subq	%rdx, %rbx
	leaq	1(%rbx), %rsi
.L60:
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
.L61:
	.cfi_restore_state
	movl	$1, %esi
	xorl	%ebx, %ebx
	jmp	.L60
	.cfi_endproc
.LFE55:
	.size	arena_xstrdup_range, .-arena_xstrdup_range
	.section	.rodata.str1.1
.LC2:
	.string	"arena_fmt: vsnprintf failed"
	.text
	.p2align 4
	.globl	arena_fmt
	.type	arena_fmt, @function
arena_fmt:
.LFB56:
	.cfi_startproc
	endbr64
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
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$248, %rsp
	.cfi_def_cfa_offset 288
	movq	%rdx, 80(%rsp)
	movq	%rcx, 88(%rsp)
	movq	%r8, 96(%rsp)
	movq	%r9, 104(%rsp)
	testb	%al, %al
	je	.L64
	movaps	%xmm0, 112(%rsp)
	movaps	%xmm1, 128(%rsp)
	movaps	%xmm2, 144(%rsp)
	movaps	%xmm3, 160(%rsp)
	movaps	%xmm4, 176(%rsp)
	movaps	%xmm5, 192(%rsp)
	movaps	%xmm6, 208(%rsp)
	movaps	%xmm7, 224(%rsp)
.L64:
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	leaq	288(%rsp), %rax
	xorl	%esi, %esi
	xorl	%edi, %edi
	movq	%rax, 16(%rsp)
	leaq	8(%rsp), %r9
	leaq	64(%rsp), %rax
	movq	%rbp, %r8
	movl	$2, %edx
	movq	%rax, 24(%rsp)
	leaq	32(%rsp), %r13
	movq	$-1, %rcx
	movl	$16, 8(%rsp)
	movl	$48, 12(%rsp)
	movdqu	8(%rsp), %xmm0
	movq	%rax, 48(%rsp)
	movups	%xmm0, 32(%rsp)
	call	__vsnprintf_chk@PLT
	testl	%eax, %eax
	js	.L68
	cltq
	movq	%r12, %rdi
	leaq	1(%rax), %rbx
	movq	%rbx, %rsi
	call	arena_alloc
	movq	%r13, %r9
	movq	%rbp, %r8
	movl	$2, %edx
	movq	$-1, %rcx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	movq	%rax, %r12
	call	__vsnprintf_chk@PLT
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L69
	addq	$248, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%r12, %rax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L68:
	.cfi_restore_state
	leaq	.LC2(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L69:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE56:
	.size	arena_fmt, .-arena_fmt
	.section	.rodata.str1.1
.LC3:
	.string	"arena_mark: NULL arena"
	.text
	.p2align 4
	.globl	arena_mark
	.type	arena_mark, @function
arena_mark:
.LFB57:
	.cfi_startproc
	endbr64
	testq	%rdi, %rdi
	je	.L78
	movq	8(%rdi), %rax
	xorl	%edx, %edx
	testq	%rax, %rax
	je	.L72
	movq	8(%rax), %rdx
.L72:
	ret
.L78:
	pushq	%rax
	.cfi_def_cfa_offset 16
	leaq	.LC3(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.cfi_endproc
.LFE57:
	.size	arena_mark, .-arena_mark
	.section	.rodata.str1.1
.LC4:
	.string	"arena_rewind: NULL arena"
	.text
	.p2align 4
	.globl	arena_rewind
	.type	arena_rewind, @function
arena_rewind:
.LFB58:
	.cfi_startproc
	endbr64
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
	testq	%rdi, %rdi
	je	.L92
	movq	%rdi, %r12
	movq	%rsi, %rbp
	movq	%rdx, %r13
	movq	%rsi, %r14
	testq	%rsi, %rsi
	je	.L81
	movq	(%rsi), %rbx
	testq	%rbx, %rbx
	je	.L86
	.p2align 4,,10
	.p2align 3
.L85:
	movq	%rbx, %rdi
	movq	(%rbx), %rbx
	call	free@PLT
	testq	%rbx, %rbx
	jne	.L85
	testq	%rbp, %rbp
	je	.L84
.L86:
	movq	$0, 0(%rbp)
	movq	%r13, 8(%rbp)
	movq	%r14, 8(%r12)
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
.L81:
	.cfi_restore_state
	movq	(%rdi), %rbx
	testq	%rbx, %rbx
	jne	.L85
.L84:
	xorl	%r14d, %r14d
	movq	$0, (%r12)
	movq	%r14, 8(%r12)
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
.L92:
	.cfi_restore_state
	leaq	.LC4(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.cfi_endproc
.LFE58:
	.size	arena_rewind, .-arena_rewind
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
