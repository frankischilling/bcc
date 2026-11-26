	.file	"runtime_cache.c"
	.text
	.p2align 4
	.type	discard_temporary, @function
discard_temporary:
.LFB14:
	.cfi_startproc
	cmpb	$0, temporary_object(%rip)
	jne	.L8
	ret
	.p2align 4,,10
	.p2align 3
.L8:
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	temporary_object(%rip), %rdi
	call	unlink@PLT
	movb	$0, temporary_object(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE14:
	.size	discard_temporary, .-discard_temporary
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"gcc"
.LC1:
	.string	"-std=c99"
.LC2:
	.string	"-O2"
.LC3:
	.string	"-c"
.LC4:
	.string	"-o"
.LC5:
	.string	"libb.c"
.LC6:
	.string	"libb.h"
.LC7:
	.string	"btarget.h"
.LC8:
	.string	"binit.h"
.LC9:
	.string	"bcall.h"
.LC10:
	.string	"bunix.h"
.LC11:
	.string	"bformat.h"
.LC12:
	.string	"bprimitives.h"
.LC13:
	.string	"BCC_CACHE_DIR"
.LC14:
	.string	"%s"
.LC15:
	.string	"/tmp/bcc-libb-%lu"
.LC16:
	.string	"%s/libb.c"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC17:
	.string	"runtime source path is too long"
	.section	.rodata.str1.1
.LC18:
	.string	"%s/%s"
.LC19:
	.string	"rb"
	.section	.rodata.str1.8
	.align 8
.LC20:
	.string	"cannot read runtime dependency %s"
	.section	.rodata.str1.1
.LC21:
	.string	"%s/libb_%016lx_%d_%d_%d.o"
.LC22:
	.string	"%s.XXXXXX"
.LC23:
	.string	"cannot create runtime object"
.LC24:
	.string	"cannot protect runtime object"
.LC25:
	.string	"cannot close runtime object"
.LC26:
	.string	"fork failed"
.LC27:
	.string	"Failed to compile libb.c"
	.section	.rodata.str1.8
	.align 8
.LC28:
	.string	"cannot register runtime object cleanup"
	.section	.rodata.str1.1
.LC29:
	.string	"-I%s"
.LC30:
	.string	"-DB_BYTEPTR=%d"
.LC31:
	.string	"-DWORD_BITS=%d"
.LC32:
	.string	"-D__bcc_strict_runtime=%d"
.LC33:
	.string	"libb.c not found at %s"
.LC34:
	.string	"Compiling runtime library...\n"
	.text
	.p2align 4
	.globl	compile_libb
	.type	compile_libb, @function
compile_libb:
.LFB18:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.LC1(%rip), %rax
	movq	%rdi, %r15
	leaq	.LC13(%rip), %rdi
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rax, %xmm5
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
	subq	$25080, %rsp
	.cfi_def_cfa_offset 25136
	movq	.LC36(%rip), %xmm1
	leaq	16880(%rsp), %rax
	movl	%ecx, 44(%rsp)
	leaq	208(%rsp), %rcx
	movq	%rcx, (%rsp)
	movq	%rax, %xmm2
	leaq	336(%rsp), %rcx
	punpcklqdq	%xmm5, %xmm1
	movq	%rax, 112(%rsp)
	leaq	272(%rsp), %rax
	movq	%rcx, 24(%rsp)
	movq	%rax, %xmm3
	movq	%rax, 120(%rsp)
	leaq	496(%rsp), %rax
	movhps	(%rsp), %xmm2
	movq	%rax, %rcx
	movq	%rax, 8(%rsp)
	leaq	.LC4(%rip), %rax
	movq	%rcx, %xmm4
	movq	%rax, %xmm6
	movhps	24(%rsp), %xmm3
	movl	%esi, 36(%rsp)
	punpcklqdq	%xmm6, %xmm4
	movl	%edx, 40(%rsp)
	movaps	%xmm1, 96(%rsp)
	movaps	%xmm2, 80(%rsp)
	movaps	%xmm3, 64(%rsp)
	movaps	%xmm4, 48(%rsp)
	call	getenv@PLT
	testq	%rax, %rax
	je	.L10
	cmpb	$0, (%rax)
	jne	.L108
.L10:
	call	geteuid@PLT
	leaq	4592(%rsp), %rdi
	movl	$4096, %esi
	leaq	.LC15(%rip), %rdx
	movl	%eax, %ecx
	xorl	%eax, %eax
	movq	%rdi, 16(%rsp)
	call	snprintf@PLT
	movl	%eax, %ecx
.L12:
	cmpl	$1, %ecx
	jle	.L14
	movq	16(%rsp), %rsi
	movslq	%ecx, %rax
	subl	$2, %ecx
	leaq	(%rsi,%rax), %rdx
	leaq	4591(%rsp,%rax), %rax
	subq	%rcx, %rax
	jmp	.L15
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L18:
	movb	$0, -1(%rdx)
	subq	$1, %rdx
	cmpq	%rax, %rdx
	je	.L14
.L15:
	cmpb	$47, -1(%rdx)
	je	.L18
.L14:
	movq	16(%rsp), %rdi
	movl	$448, %esi
	call	mkdir@PLT
	testl	%eax, %eax
	je	.L109
	call	__errno_location@PLT
	cmpl	$17, (%rax)
	je	.L20
.L105:
	leaq	8688(%rsp), %r14
.L11:
	movl	$0, 32(%rsp)
.L13:
	movq	8(%rsp), %rdi
	xorl	%eax, %eax
	movq	%r15, %rcx
	movl	$4096, %esi
	leaq	.LC16(%rip), %rdx
	call	snprintf@PLT
	cmpl	$4095, %eax
	ja	.L110
.L21:
	leaq	.LC6(%rip), %rax
	movq	.LC37(%rip), %xmm0
	leaq	144(%rsp), %r13
	movabsq	$-3750763034362895579, %rbx
	movabsq	$1099511628211, %r12
	movq	%rax, %xmm7
	leaq	.LC8(%rip), %rax
	punpcklqdq	%xmm7, %xmm0
	movq	%rax, %xmm5
	leaq	.LC10(%rip), %rax
	movaps	%xmm0, 144(%rsp)
	movq	%rax, %xmm6
	movq	.LC38(%rip), %xmm0
	leaq	.LC12(%rip), %rax
	movq	%rax, %xmm7
	punpcklqdq	%xmm5, %xmm0
	movaps	%xmm0, 160(%rsp)
	movq	.LC39(%rip), %xmm0
	punpcklqdq	%xmm6, %xmm0
	movaps	%xmm0, 176(%rsp)
	movq	.LC40(%rip), %xmm0
	punpcklqdq	%xmm7, %xmm0
	movaps	%xmm0, 192(%rsp)
	.p2align 4
	.p2align 3
.L26:
	movq	0(%r13), %r8
	movq	%r15, %rcx
	leaq	.LC18(%rip), %rdx
	xorl	%eax, %eax
	movl	$8192, %esi
	movq	%r14, %rdi
	call	snprintf@PLT
	leaq	.LC19(%rip), %rsi
	movq	%r14, %rdi
	call	fopen@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	jne	.L23
	jmp	.L111
	.p2align 4,,10
	.p2align 3
.L24:
	movzbl	%al, %eax
	xorq	%rbx, %rax
	imulq	%r12, %rax
	movq	%rax, %rbx
.L23:
	movq	%rbp, %rdi
	call	fgetc@PLT
	cmpl	$-1, %eax
	jne	.L24
	movq	%rbp, %rdi
	call	ferror@PLT
	testl	%eax, %eax
	jne	.L112
.L25:
	movq	%rbp, %rdi
	addq	$8, %r13
	call	fclose@PLT
	cmpq	%r13, (%rsp)
	jne	.L26
	movl	32(%rsp), %eax
	testl	%eax, %eax
	jne	.L27
	movq	8(%rsp), %rdi
	movl	$4, %esi
	call	access@PLT
	testl	%eax, %eax
	jne	.L113
	movl	36(%rsp), %r8d
	testl	%r8d, %r8d
	jne	.L114
.L107:
	movq	112(%rsp), %rdi
	movq	%r15, %rcx
	movl	$8192, %esi
	xorl	%eax, %eax
	leaq	.LC29(%rip), %rdx
	call	snprintf@PLT
	movl	40(%rsp), %eax
	movq	(%rsp), %rdi
	xorl	%ecx, %ecx
	leaq	.LC30(%rip), %rdx
	movl	$64, %esi
	testl	%eax, %eax
	setne	%cl
	xorl	%eax, %eax
	call	snprintf@PLT
	movl	44(%rsp), %ecx
	movq	120(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC31(%rip), %rdx
	movl	$64, %esi
	call	snprintf@PLT
	movl	g_strict(%rip), %edx
	xorl	%ecx, %ecx
	movq	24(%rsp), %rdi
	movl	$64, %esi
	testl	%edx, %edx
	leaq	.LC32(%rip), %rdx
	setne	%cl
	xorl	%eax, %eax
	call	snprintf@PLT
.L36:
	movdqa	.LC35(%rip), %xmm0
	movq	%r14, %rdi
	movabsq	$24866934413088813, %rax
	movaps	%xmm0, 8688(%rsp)
	movq	%rax, 8701(%rsp)
	call	mkstemp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	js	.L39
.L40:
	movl	$0, 32(%rsp)
.L37:
	movl	$384, %esi
	movl	%ebx, %edi
	call	fchmod@PLT
	testl	%eax, %eax
	jne	.L115
.L41:
	movl	%ebx, %edi
	call	close@PLT
	testl	%eax, %eax
	jne	.L116
.L42:
	movq	.LC41(%rip), %xmm0
	leaq	.LC3(%rip), %rax
	movdqa	96(%rsp), %xmm5
	movq	%r14, 480(%rsp)
	movdqa	80(%rsp), %xmm7
	movdqa	64(%rsp), %xmm1
	movq	%rax, %xmm6
	movq	$0, 488(%rsp)
	movdqa	48(%rsp), %xmm2
	punpcklqdq	%xmm6, %xmm0
	movaps	%xmm5, 400(%rsp)
	movaps	%xmm0, 416(%rsp)
	movaps	%xmm7, 432(%rsp)
	movaps	%xmm1, 448(%rsp)
	movaps	%xmm2, 464(%rsp)
	call	fork@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	js	.L117
	je	.L118
.L44:
	movl	$0, 140(%rsp)
	leaq	140(%rsp), %rbp
	jmp	.L46
	.p2align 4,,10
	.p2align 3
.L119:
	call	__errno_location@PLT
	cmpl	$4, (%rax)
	jne	.L47
.L46:
	xorl	%edx, %edx
	movq	%rbp, %rsi
	movl	%ebx, %edi
	call	waitpid@PLT
	testl	%eax, %eax
	js	.L119
	testw	$-129, 140(%rsp)
	je	.L48
.L47:
	movq	%r14, %rdi
	call	unlink@PLT
	leaq	.LC27(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L48:
	movl	32(%rsp), %r10d
	testl	%r10d, %r10d
	je	.L52
	leaq	libb_o_path.1(%rip), %rbx
	movq	%r14, %rdi
	movq	%rbx, %rsi
	call	rename@PLT
	testl	%eax, %eax
	jne	.L52
.L61:
	leaq	libb_o_path.1(%rip), %rax
.L9:
	addq	$25080, %rsp
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
.L109:
	.cfi_restore_state
	movq	16(%rsp), %rdi
	movl	$448, %esi
	call	chmod@PLT
	testl	%eax, %eax
	jne	.L105
.L20:
	leaq	8688(%rsp), %r14
	movq	16(%rsp), %rdi
	movq	%r14, %rsi
	call	lstat@PLT
	testl	%eax, %eax
	jne	.L11
	movl	8712(%rsp), %eax
	andl	$61440, %eax
	cmpl	$16384, %eax
	jne	.L11
	movl	8716(%rsp), %ebx
	call	geteuid@PLT
	cmpl	%eax, %ebx
	jne	.L11
	movl	8712(%rsp), %eax
	andl	$511, %eax
	cmpl	$448, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, 32(%rsp)
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L112:
	movq	%r14, %rsi
	leaq	.LC20(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L25
.L52:
	cmpb	$0, temporary_object(%rip)
	jne	.L120
.L51:
	movq	%r14, %rdi
	call	strlen@PLT
	leaq	temporary_object(%rip), %rdi
	addq	$1, %rax
	cmpl	$8, %eax
	jb	.L54
	movl	%eax, %ecx
	movq	%r14, %rsi
	shrl	$3, %ecx
	rep movsq
	movq	%rsi, %r14
.L54:
	xorl	%edx, %edx
	testb	$4, %al
	je	.L55
	movl	(%r14), %edx
	movl	%edx, (%rdi)
	movl	$4, %edx
.L55:
	testb	$2, %al
	je	.L56
	movzwl	(%r14,%rdx), %ecx
	movw	%cx, (%rdi,%rdx)
	addq	$2, %rdx
.L56:
	testb	$1, %al
	je	.L57
	movzbl	(%r14,%rdx), %eax
	movb	%al, (%rdi,%rdx)
.L57:
	movl	registered.0(%rip), %r9d
	testl	%r9d, %r9d
	je	.L121
.L58:
	leaq	temporary_object(%rip), %rax
	jmp	.L9
.L110:
	leaq	.LC17(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L21
.L27:
	movl	g_strict(%rip), %ebp
	xorl	%eax, %eax
	movq	%rbx, %r8
	movl	$4224, %esi
	leaq	libb_o_path.1(%rip), %rbx
	leaq	.LC21(%rip), %rdx
	testl	%ebp, %ebp
	movq	%rbx, %rdi
	setne	%al
	pushq	%rax
	.cfi_def_cfa_offset 25144
	movl	52(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 25152
	movl	56(%rsp), %r9d
	xorl	%eax, %eax
	movq	32(%rsp), %rcx
	call	snprintf@PLT
	movq	24(%rsp), %rdi
	movl	$4, %esi
	call	access@PLT
	popq	%r12
	.cfi_def_cfa_offset 25144
	popq	%r13
	.cfi_def_cfa_offset 25136
	testl	%eax, %eax
	jne	.L30
.L66:
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	lstat@PLT
	testl	%eax, %eax
	je	.L122
.L31:
	movl	36(%rsp), %r11d
	testl	%r11d, %r11d
	jne	.L123
.L106:
	movq	112(%rsp), %rdi
	movq	%r15, %rcx
	movl	$8192, %esi
	xorl	%eax, %eax
	leaq	.LC29(%rip), %rdx
	call	snprintf@PLT
	movl	40(%rsp), %esi
	movq	(%rsp), %rdi
	xorl	%ecx, %ecx
	leaq	.LC30(%rip), %rdx
	testl	%esi, %esi
	movl	$64, %esi
	setne	%cl
	xorl	%eax, %eax
	call	snprintf@PLT
	movl	44(%rsp), %ecx
	movq	120(%rsp), %rdi
	xorl	%eax, %eax
	leaq	.LC31(%rip), %rdx
	movl	$64, %esi
	call	snprintf@PLT
	movl	g_strict(%rip), %edi
	xorl	%ecx, %ecx
	leaq	.LC32(%rip), %rdx
	movl	$64, %esi
	testl	%edi, %edi
	movq	24(%rsp), %rdi
	setne	%cl
	xorl	%eax, %eax
	call	snprintf@PLT
	movq	%rbx, %rcx
	movl	$4232, %esi
	movq	%r14, %rdi
	leaq	.LC22(%rip), %rdx
	xorl	%eax, %eax
	call	snprintf@PLT
	movq	%r14, %rdi
	call	mkstemp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	js	.L36
	jmp	.L37
.L116:
	movq	%r14, %rdi
	call	unlink@PLT
	leaq	.LC25(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L42
.L115:
	movl	%ebx, %edi
	call	close@PLT
	movq	%r14, %rdi
	call	unlink@PLT
	leaq	.LC24(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L41
.L108:
	movq	%rax, %rcx
	leaq	4592(%rsp), %rdi
	leaq	.LC14(%rip), %rdx
	xorl	%eax, %eax
	movl	$4096, %esi
	movq	%rdi, 16(%rsp)
	leaq	8688(%rsp), %r14
	call	snprintf@PLT
	movl	%eax, %ecx
	cmpl	$4095, %eax
	ja	.L11
	jmp	.L12
	.p2align 4,,10
	.p2align 3
.L113:
	movq	8(%rsp), %rsi
	leaq	.LC33(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movl	36(%rsp), %r8d
	testl	%r8d, %r8d
	je	.L107
.L114:
	movq	stderr(%rip), %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC34(%rip), %rdi
	call	fwrite@PLT
	jmp	.L107
	.p2align 4,,10
	.p2align 3
.L117:
	movq	%r14, %rdi
	call	unlink@PLT
	leaq	.LC26(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L44
.L39:
	leaq	.LC23(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L40
.L122:
	movl	8712(%rsp), %eax
	andl	$61440, %eax
	cmpl	$32768, %eax
	jne	.L31
	movl	8716(%rsp), %ebp
	call	geteuid@PLT
	cmpl	%eax, %ebp
	jne	.L31
	testb	$63, 8712(%rsp)
	jne	.L31
	cmpq	$1, 8704(%rsp)
	jne	.L31
	cmpq	$0, 8736(%rsp)
	jle	.L31
	movl	$4, %esi
	movq	%rbx, %rdi
	call	access@PLT
	testl	%eax, %eax
	jne	.L31
	jmp	.L61
	.p2align 4,,10
	.p2align 3
.L121:
	leaq	discard_temporary(%rip), %rdi
	call	atexit@PLT
	testl	%eax, %eax
	je	.L59
	cmpb	$0, temporary_object(%rip)
	jne	.L124
.L60:
	leaq	.LC28(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L59:
	movl	$1, registered.0(%rip)
	jmp	.L58
.L120:
	leaq	temporary_object(%rip), %rdi
	call	unlink@PLT
	movb	$0, temporary_object(%rip)
	jmp	.L51
.L30:
	movq	8(%rsp), %rsi
	leaq	.LC33(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L66
.L123:
	movq	stderr(%rip), %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC34(%rip), %rdi
	call	fwrite@PLT
	jmp	.L106
.L124:
	leaq	temporary_object(%rip), %rdi
	call	unlink@PLT
	movb	$0, temporary_object(%rip)
	jmp	.L60
.L111:
	movq	%r14, %rsi
	leaq	.LC20(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L23
.L118:
	leaq	.LC0(%rip), %rdi
	leaq	400(%rsp), %rsi
	call	execvp@PLT
	movl	$127, %edi
	call	_exit@PLT
	.cfi_endproc
.LFE18:
	.size	compile_libb, .-compile_libb
	.local	registered.0
	.comm	registered.0,4,4
	.local	libb_o_path.1
	.comm	libb_o_path.1,4224,32
	.local	temporary_object
	.comm	temporary_object,8192,32
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC35:
	.quad	7161675788338426927
	.quad	6365887973869317165
	.section	.data.rel.ro.local,"aw"
	.align 8
.LC36:
	.quad	.LC0
	.align 8
.LC37:
	.quad	.LC5
	.align 8
.LC38:
	.quad	.LC7
	.align 8
.LC39:
	.quad	.LC9
	.align 8
.LC40:
	.quad	.LC11
	.align 8
.LC41:
	.quad	.LC2
	.section	.note.GNU-stack,"",@progbits
