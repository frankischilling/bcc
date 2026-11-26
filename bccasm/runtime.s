	.intel_syntax noprefix
	.text

	.globl __b_init
	.type __b_init, @function
__b_init:
	xor eax, eax
	ret

	.globl __b_setargs
	.type __b_setargs, @function
__b_setargs:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	sub rsp, 8
	mov qword ptr [rip + __b_argc], rdi
	mov qword ptr [rip + __b_argv], rsi
	mov r12, rdi
	mov r13, rsi
	lea rdi, [r12*8]
	call rt_alloc
	mov qword ptr [rip + __b_argvb], rax
	xor ebx, ebx
.setargs_loop:
	cmp rbx, r12
	jae .setargs_done
	mov rdi, qword ptr [r13 + rbx*8]
	call __b_pack_cstr
	mov rdx, qword ptr [rip + __b_argvb]
	mov qword ptr [rdx + rbx*8], rax
	inc rbx
	jmp .setargs_loop
.setargs_done:
	xor eax, eax
	add rsp, 8
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret

	.globl b_putchar
	.type b_putchar, @function
b_putchar:
	push rbx
	mov rbx, rdi
	call rt_putchar_raw
	mov rax, rbx
	pop rbx
	ret

	.globl b_char
	.type b_char, @function
b_char:
	movzx eax, byte ptr [rdi + rsi]
	ret

	.globl b_lchar
	.type b_lchar, @function
b_lchar:
	mov byte ptr [rdi + rsi], dl
	mov rax, rdx
	ret

	.globl b_postinc
	.type b_postinc, @function
b_postinc:
	mov rax, qword ptr [rdi]
	lea rdx, [rax + 1]
	mov qword ptr [rdi], rdx
	ret

	.globl b_add_assign
	.type b_add_assign, @function
b_add_assign:
	mov rax, qword ptr [rdi]
	add rax, rsi
	mov qword ptr [rdi], rax
	ret

	.globl b_preinc
	.type b_preinc, @function
b_preinc:
	mov rax, qword ptr [rdi]
	inc rax
	mov qword ptr [rdi], rax
	ret

	.globl b_predec
	.type b_predec, @function
b_predec:
	mov rax, qword ptr [rdi]
	dec rax
	mov qword ptr [rdi], rax
	ret

	.globl b_postdec
	.type b_postdec, @function
b_postdec:
	mov rax, qword ptr [rdi]
	lea rdx, [rax - 1]
	mov qword ptr [rdi], rdx
	ret

	.globl b_sub_assign
	.type b_sub_assign, @function
b_sub_assign:
	mov rax, qword ptr [rdi]
	sub rax, rsi
	mov qword ptr [rdi], rax
	ret

	.globl b_mul_assign
	.type b_mul_assign, @function
b_mul_assign:
	mov rax, qword ptr [rdi]
	imul rax, rsi
	mov qword ptr [rdi], rax
	ret

	.globl b_div_assign
	.type b_div_assign, @function
b_div_assign:
	mov rax, qword ptr [rdi]
	xor edx, edx
	div rsi
	mov qword ptr [rdi], rax
	ret

	.globl b_mod_assign
	.type b_mod_assign, @function
b_mod_assign:
	mov rax, qword ptr [rdi]
	xor edx, edx
	div rsi
	mov rax, rdx
	mov qword ptr [rdi], rax
	ret

	.globl b_lsh_assign
	.type b_lsh_assign, @function
b_lsh_assign:
	mov rax, qword ptr [rdi]
	mov rcx, rsi
	shl rax, cl
	mov qword ptr [rdi], rax
	ret

	.globl b_rsh_assign
	.type b_rsh_assign, @function
b_rsh_assign:
	mov rax, qword ptr [rdi]
	mov rcx, rsi
	shr rax, cl
	mov qword ptr [rdi], rax
	ret

	.globl b_and_assign
	.type b_and_assign, @function
b_and_assign:
	mov rax, qword ptr [rdi]
	and rax, rsi
	mov qword ptr [rdi], rax
	ret

	.globl b_or_assign
	.type b_or_assign, @function
b_or_assign:
	mov rax, qword ptr [rdi]
	or rax, rsi
	mov qword ptr [rdi], rax
	ret

	.globl b_xor_assign
	.type b_xor_assign, @function
b_xor_assign:
	mov rax, qword ptr [rdi]
	xor rax, rsi
	mov qword ptr [rdi], rax
	ret

	.globl b_load
	.type b_load, @function
b_load:
	mov rax, qword ptr [rdi]
	ret

	.globl b_store
	.type b_store, @function
b_store:
	mov qword ptr [rdi], rsi
	ret

	.globl b_argc
	.type b_argc, @function
b_argc:
	mov rax, qword ptr [rip + __b_argc]
	ret

	.globl b_argv
	.type b_argv, @function
b_argv:
	mov rax, qword ptr [rip + __b_argc]
	cmp rdi, rax
	jae .argv_bad
	mov rax, qword ptr [rip + __b_argvb]
	test rax, rax
	je .argv_bad
	mov rax, qword ptr [rax + rdi*8]
	ret
.argv_bad:
	xor eax, eax
	ret

	.globl b_reread
	.type b_reread, @function
b_reread:
	xor eax, eax
	ret

	.globl b_putchr
	.type b_putchr, @function
b_putchr:
	jmp b_putchar

	.globl b_getchar
	.type b_getchar, @function
b_getchar:
	mov eax, 0
	xor edi, edi
	lea rsi, [rip + one_byte]
	mov edx, 1
	syscall
	cmp rax, 1
	jne .getc_eof
	movzx eax, byte ptr [rip + one_byte]
	ret
.getc_eof:
	mov eax, 4
	ret

	.globl b_getchr
	.type b_getchr, @function
b_getchr:
	jmp b_getchar

	.globl b_putstr
	.type b_putstr, @function
b_putstr:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 8
	mov rbx, rdi
.putstr_loop:
	movzx edi, byte ptr [rbx]
	inc rbx
	cmp dil, 4
	je .putstr_done
	test dil, dil
	je .putstr_done
	call rt_putchar_raw
	jmp .putstr_loop
.putstr_done:
	mov rax, rdi
	add rsp, 8
	pop rbx
	pop rbp
	ret

	.globl b_getstr
	.type b_getstr, @function
b_getstr:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 8
	mov rbx, rdi
.getstr_loop:
	mov eax, 0
	xor edi, edi
	lea rsi, [rip + one_byte]
	mov edx, 1
	syscall
	cmp rax, 1
	jne .getstr_done
	mov al, byte ptr [rip + one_byte]
	cmp al, 10
	je .getstr_done
	cmp al, 13
	je .getstr_done
	mov byte ptr [rbx], al
	inc rbx
	jmp .getstr_loop
.getstr_done:
	mov byte ptr [rbx], 4
	mov rax, rbx
	add rsp, 8
	pop rbx
	pop rbp
	ret

	.globl b_flush
	.type b_flush, @function
b_flush:
	xor eax, eax
	ret

	.globl b_print
	.type b_print, @function
b_print:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 8
	mov rbx, rdi
	test rdi, rdi
	jns .print_abs
	neg rdi
	mov qword ptr [rbp - 16], rdi
	mov edi, '-'
	call rt_putchar_raw
	mov rdi, qword ptr [rbp - 16]
.print_abs:
	mov esi, 10
	call rt_print_u
	mov edi, 10
	call rt_putchar_raw
	mov rax, rbx
	add rsp, 8
	pop rbx
	pop rbp
	ret

	.globl b_printn
	.type b_printn, @function
b_printn:
	push rbp
	mov rbp, rsp
	call rt_print_u
	xor eax, eax
	pop rbp
	ret

	.globl b_putnum
	.type b_putnum, @function
b_putnum:
	push rbp
	mov rbp, rsp
	mov esi, 10
	call rt_print_u
	xor eax, eax
	pop rbp
	ret

	.globl b_exit
	.type b_exit, @function
b_exit:
	mov eax, 60
	syscall
	hlt

	.globl b_abort
	.type b_abort, @function
b_abort:
	mov eax, 231
	mov edi, 134
	syscall
	hlt

	.globl b_free
	.type b_free, @function
b_free:
	xor eax, eax
	ret

	.globl b_alloc
	.type b_alloc, @function
b_alloc:
	push rbp
	mov rbp, rsp
	shl rdi, 3
	call rt_alloc
	pop rbp
	ret

	.globl __b_cstr
	.type __b_cstr, @function
__b_cstr:
	push rbp
	mov rbp, rsp
	mov rdx, 4096
	lea rsi, [rip + cstr_buf]
	call __b_bstr_to_cstr
	lea rax, [rip + cstr_buf]
	pop rbp
	ret

	.globl __b_bstr_to_cstr
	.type __b_bstr_to_cstr, @function
__b_bstr_to_cstr:
	test rdx, rdx
	je .bc_done
	dec rdx
	xor ecx, ecx
.bc_loop:
	cmp rcx, rdx
	jae .bc_term
	mov al, byte ptr [rdi + rcx]
	cmp al, 4
	je .bc_term
	test al, al
	je .bc_term
	mov byte ptr [rsi + rcx], al
	inc rcx
	jmp .bc_loop
.bc_term:
	mov byte ptr [rsi + rcx], 0
.bc_done:
	ret

	.globl __b_dup_bstr
	.type __b_dup_bstr, @function
__b_dup_bstr:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 8
	mov rbx, rdi
	call rt_bstrlen
	lea rdi, [rax + 1]
	call rt_alloc
	test rax, rax
	je .dup_done
	xor ecx, ecx
.dup_loop:
	mov dl, byte ptr [rbx + rcx]
	cmp dl, 4
	je .dup_term
	test dl, dl
	je .dup_term
	mov byte ptr [rax + rcx], dl
	inc rcx
	jmp .dup_loop
.dup_term:
	mov byte ptr [rax + rcx], 0
.dup_done:
	add rsp, 8
	pop rbx
	pop rbp
	ret

	.globl __b_pack_cstr
	.type __b_pack_cstr, @function
__b_pack_cstr:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 8
	mov rbx, rdi
	call rt_cstrlen
	lea rdi, [rax + 1]
	call rt_alloc
	test rax, rax
	je .pack_done
	xor ecx, ecx
.pack_loop:
	mov dl, byte ptr [rbx + rcx]
	test dl, dl
	je .pack_term
	mov byte ptr [rax + rcx], dl
	inc rcx
	jmp .pack_loop
.pack_term:
	mov byte ptr [rax + rcx], 4
.pack_done:
	add rsp, 8
	pop rbx
	pop rbp
	ret

	.globl b_open
	.type b_open, @function
b_open:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 8
	mov rbx, rsi
	call __b_cstr
	mov rdi, rax
	xor esi, esi
	test rbx, rbx
	je .open_call
	mov esi, 1
.open_call:
	mov eax, 2
	xor edx, edx
	syscall
	add rsp, 8
	pop rbx
	pop rbp
	ret

	.globl b_openr
	.type b_openr, @function
b_openr:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 8
	mov rbx, rdi
	mov rdi, rsi
	call __b_cstr
	mov rdi, rax
	xor esi, esi
	mov eax, 2
	xor edx, edx
	syscall
	test rax, rax
	js .openr_done
	cmp rax, rbx
	je .openr_store
	mov qword ptr [rbp - 16], rax
	mov rdi, rax
	mov rsi, rbx
	mov eax, 33
	syscall
	mov rdi, qword ptr [rbp - 16]
	mov eax, 3
	syscall
	mov rax, rbx
.openr_store:
	mov qword ptr [rip + b_rd_fd], rax
	mov qword ptr [rip + b_rd_unit], rbx
.openr_done:
	add rsp, 8
	pop rbx
	pop rbp
	ret

	.globl b_openw
	.type b_openw, @function
b_openw:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 8
	mov rbx, rdi
	mov rdi, rsi
	call __b_cstr
	mov rdi, rax
	mov esi, 577
	mov edx, 438
	mov eax, 2
	syscall
	test rax, rax
	js .openw_done
	cmp rax, rbx
	je .openw_store
	mov qword ptr [rbp - 16], rax
	mov rdi, rax
	mov rsi, rbx
	mov eax, 33
	syscall
	mov rdi, qword ptr [rbp - 16]
	mov eax, 3
	syscall
	mov rax, rbx
.openw_store:
	mov qword ptr [rip + b_wr_fd], rax
	mov qword ptr [rip + b_wr_unit], rbx
.openw_done:
	add rsp, 8
	pop rbx
	pop rbp
	ret

	.globl b_close
	.type b_close, @function
b_close:
	mov eax, 3
	syscall
	ret

	.globl b_read
	.type b_read, @function
b_read:
	mov eax, 0
	syscall
	ret

	.globl b_write
	.type b_write, @function
b_write:
	mov eax, 1
	syscall
	ret

	.globl b_creat
	.type b_creat, @function
b_creat:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 8
	mov rbx, rsi
	call __b_cstr
	mov rdi, rax
	mov rsi, rbx
	mov eax, 85
	syscall
	add rsp, 8
	pop rbx
	pop rbp
	ret

	.globl b_seek
	.type b_seek, @function
b_seek:
	mov eax, 8
	syscall
	test rax, rax
	js .seek_ret
	xor eax, eax
.seek_ret:
	ret

	.globl b_fork
	.type b_fork, @function
b_fork:
	mov eax, 57
	syscall
	ret

	.globl b_wait
	.type b_wait, @function
b_wait:
	mov eax, 61
	mov edi, -1
	lea rsi, [rip + wait_status]
	xor edx, edx
	xor r10d, r10d
	syscall
	ret

	.globl b_execl
	.type b_execl, @function
b_execl:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	sub rsp, 728
	mov qword ptr [rbp - 80], rsi
	mov qword ptr [rbp - 88], rdx
	mov qword ptr [rbp - 96], rcx
	mov qword ptr [rbp - 104], r8
	mov qword ptr [rbp - 112], r9
	lea r12, [rbp - 640]
	call __b_dup_bstr
	mov qword ptr [r12], rax
	mov r15, rax
	mov ebx, 1
	xor r13d, r13d
.execl_loop:
	cmp ebx, 63
	jae .execl_finish
	cmp r13, 5
	jae .execl_stack_arg
	mov r14, qword ptr [rbp - 80 + r13*8]
	jmp .execl_have_arg
.execl_stack_arg:
	mov rax, r13
	sub rax, 5
	mov r14, qword ptr [rbp + 16 + rax*8]
.execl_have_arg:
	test r14, r14
	je .execl_finish
	mov rdi, r14
	call __b_dup_bstr
	mov qword ptr [r12 + rbx*8], rax
	inc ebx
	inc r13
	jmp .execl_loop
.execl_finish:
	mov qword ptr [r12 + rbx*8], 0
	mov rdi, r15
	mov rsi, r12
	mov rdx, 0
	mov eax, 59
	syscall
	mov rax, -1
	add rsp, 728
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret

	.globl b_execv
	.type b_execv, @function
b_execv:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	sub rsp, 2176
	mov r13, rsi
	lea r12, [rbp - 2112]
	call __b_dup_bstr
	mov r14, rax
	xor ebx, ebx
.execv_loop:
	cmp ebx, 255
	jae .execv_finish
	mov rdi, qword ptr [r13 + rbx*8]
	test rdi, rdi
	je .execv_finish
	call __b_dup_bstr
	mov qword ptr [r12 + rbx*8], rax
	inc ebx
	jmp .execv_loop
.execv_finish:
	mov qword ptr [r12 + rbx*8], 0
	mov rdi, r14
	mov rsi, r12
	mov rdx, 0
	mov eax, 59
	syscall
	mov rax, -1
	add rsp, 2176
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret

	.globl b_system
	.type b_system, @function
b_system:
	push rbp
	mov rbp, rsp
	sub rsp, 48
	call __b_cstr
	mov qword ptr [rbp - 8], rax
	mov eax, 57
	syscall
	test rax, rax
	js .system_fail
	je .system_child
	mov edi, eax
	lea rsi, [rip + wait_status]
	xor edx, edx
	xor r10d, r10d
	mov eax, 61
	syscall
	mov rax, qword ptr [rip + wait_status]
	jmp .system_done
.system_child:
	lea rax, [rip + shell_path]
	mov qword ptr [rbp - 40], rax
	lea rax, [rip + shell_dash_c]
	mov qword ptr [rbp - 32], rax
	mov rax, qword ptr [rbp - 8]
	mov qword ptr [rbp - 24], rax
	mov qword ptr [rbp - 16], 0
	lea rdi, [rip + shell_path]
	lea rsi, [rbp - 40]
	xor edx, edx
	mov eax, 59
	syscall
	mov eax, 60
	mov edi, 127
	syscall
.system_fail:
	mov rax, -1
.system_done:
	add rsp, 48
	pop rbp
	ret

	.globl b_usleep
	.type b_usleep, @function
b_usleep:
	sub rsp, 32
	mov rax, rdi
	xor edx, edx
	mov ecx, 1000000
	div rcx
	mov qword ptr [rsp], rax
	imul rdx, rdx, 1000
	mov qword ptr [rsp + 8], rdx
	mov eax, 35
	mov rdi, rsp
	xor esi, esi
	syscall
	xor eax, eax
	add rsp, 32
	ret

	.globl b_time
	.type b_time, @function
b_time:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 8
	mov rbx, rdi
	xor edi, edi
	mov eax, 201
	syscall
	test rbx, rbx
	je .time_done
	movzx edx, ax
	mov qword ptr [rbx], rdx
	shr rax, 16
	movzx edx, ax
	mov qword ptr [rbx + 8], rdx
.time_done:
	xor eax, eax
	add rsp, 8
	pop rbx
	pop rbp
	ret

	.globl b_ctime
	.type b_ctime, @function
b_ctime:
	push rbp
	mov rbp, rsp
	sub rsp, 32
	mov rax, qword ptr [rdi]
	movzx eax, ax
	mov rdx, qword ptr [rdi + 8]
	movzx edx, dx
	shl rdx, 16
	or rax, rdx
	mov qword ptr [rbp - 8], rax
	lea rdi, [rbp - 8]
	call ctime@PLT
	test rax, rax
	je .ctime_fail
	lea rsi, [rip + ctime_buf]
	xor ecx, ecx
.ctime_copy:
	cmp ecx, 63
	jae .ctime_term
	mov dl, byte ptr [rax + rcx]
	test dl, dl
	je .ctime_term
	cmp dl, 10
	je .ctime_term
	mov byte ptr [rsi + rcx], dl
	inc ecx
	jmp .ctime_copy
.ctime_term:
	mov byte ptr [rsi + rcx], 4
	lea rax, [rip + ctime_buf]
	jmp .ctime_done
.ctime_fail:
	xor eax, eax
.ctime_done:
	add rsp, 32
	pop rbp
	ret

	.globl b_getuid
	.type b_getuid, @function
b_getuid:
	mov eax, 102
	syscall
	ret

	.globl b_setuid
	.type b_setuid, @function
b_setuid:
	mov eax, 105
	syscall
	ret

	.globl b_chdir
	.type b_chdir, @function
b_chdir:
	push rbp
	mov rbp, rsp
	call __b_cstr
	mov rdi, rax
	mov eax, 80
	syscall
	pop rbp
	ret

	.globl b_chmod
	.type b_chmod, @function
b_chmod:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 8
	mov rbx, rsi
	call __b_cstr
	mov rdi, rax
	mov rsi, rbx
	mov eax, 90
	syscall
	add rsp, 8
	pop rbx
	pop rbp
	ret

	.globl b_chown
	.type b_chown, @function
b_chown:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 8
	mov rbx, rsi
	call __b_cstr
	mov rdi, rax
	mov rsi, rbx
	mov rdx, -1
	mov eax, 92
	syscall
	add rsp, 8
	pop rbx
	pop rbp
	ret

	.globl b_link
	.type b_link, @function
b_link:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 8
	mov rbx, rsi
	mov rdx, 4096
	lea rsi, [rip + cstr_buf]
	call __b_bstr_to_cstr
	mov rdi, rbx
	mov rdx, 4096
	lea rsi, [rip + cstr_buf2]
	call __b_bstr_to_cstr
	lea rdi, [rip + cstr_buf]
	lea rsi, [rip + cstr_buf2]
	mov eax, 86
	syscall
	add rsp, 8
	pop rbx
	pop rbp
	ret

	.globl b_unlink
	.type b_unlink, @function
b_unlink:
	push rbp
	mov rbp, rsp
	call __b_cstr
	mov rdi, rax
	mov eax, 87
	syscall
	pop rbp
	ret

	.globl b_makdir
	.type b_makdir, @function
b_makdir:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 8
	mov rbx, rsi
	call __b_cstr
	mov rdi, rax
	mov rsi, rbx
	mov eax, 83
	syscall
	add rsp, 8
	pop rbx
	pop rbp
	ret

	.globl b_stat
	.type b_stat, @function
b_stat:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 8
	mov rbx, rsi
	call __b_cstr
	mov rdi, rax
	mov rsi, rbx
	mov eax, 4
	syscall
	add rsp, 8
	pop rbx
	pop rbp
	ret

	.globl b_fstat
	.type b_fstat, @function
b_fstat:
	mov eax, 5
	syscall
	ret

	.globl b_gtty
	.type b_gtty, @function
b_gtty:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 80
	mov rbx, rsi
	mov esi, 0x5401
	lea rdx, [rbp - 80]
	mov eax, 16
	syscall
	test rax, rax
	js .gtty_done
	mov eax, dword ptr [rbp - 80]
	mov qword ptr [rbx], rax
	mov eax, dword ptr [rbp - 76]
	mov qword ptr [rbx + 8], rax
	mov eax, dword ptr [rbp - 68]
	mov qword ptr [rbx + 16], rax
	xor eax, eax
.gtty_done:
	add rsp, 80
	pop rbx
	pop rbp
	ret

	.globl b_stty
	.type b_stty, @function
b_stty:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	sub rsp, 80
	mov rbx, rdi
	mov r12, rsi
	mov esi, 0x5401
	lea rdx, [rbp - 96]
	mov eax, 16
	syscall
	test rax, rax
	js .stty_done
	mov eax, dword ptr [r12]
	mov dword ptr [rbp - 96], eax
	mov eax, dword ptr [r12 + 8]
	mov dword ptr [rbp - 92], eax
	mov eax, dword ptr [r12 + 16]
	mov dword ptr [rbp - 84], eax
	mov rdi, rbx
	mov esi, 0x5402
	lea rdx, [rbp - 96]
	mov eax, 16
	syscall
.stty_done:
	add rsp, 80
	pop r12
	pop rbx
	pop rbp
	ret

	.globl b_intr
	.type b_intr, @function
b_intr:
	push rbp
	mov rbp, rsp
	test rdi, rdi
	je .intr_off
	mov edi, 2
	lea rsi, [rip + rt_sigint_handler]
	call signal@PLT
	jmp .intr_ret
.intr_off:
	mov edi, 2
	xor esi, esi
	call signal@PLT
.intr_ret:
	cmp rax, -1
	sete al
	movzx eax, al
	neg rax
	pop rbp
	ret

	.type rt_sigint_handler, @function
rt_sigint_handler:
	mov qword ptr [rip + got_intr], 1
	ret

	.globl b_callf_dispatch
	.type b_callf_dispatch, @function
b_callf_dispatch:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	sub rsp, 200
	mov r12, rdi
	mov r13, rsi
	mov qword ptr [rbp - 80], rdx
	mov qword ptr [rbp - 88], rcx
	mov qword ptr [rbp - 96], r8
	mov qword ptr [rbp - 104], r9
	cmp qword ptr [rip + callf_dl_done], 0
	jne .callf_after_dlopen
	mov qword ptr [rip + callf_dl_done], 1
	lea rdi, [rip + callf_env_name]
	call getenv@PLT
	test rax, rax
	je .callf_after_dlopen
	mov rbx, rax
.callf_env_next:
	cmp byte ptr [rbx], 0
	je .callf_after_dlopen
	lea r14, [rip + callf_path_buf]
	xor r15d, r15d
.callf_env_copy:
	mov al, byte ptr [rbx]
	test al, al
	je .callf_env_term
	cmp al, ':'
	je .callf_env_term
	cmp r15, 4095
	jae .callf_env_advance
	mov byte ptr [r14 + r15], al
	inc r15
.callf_env_advance:
	inc rbx
	jmp .callf_env_copy
.callf_env_term:
	mov byte ptr [r14 + r15], 0
	test r15, r15
	je .callf_env_sep
	mov rdi, r14
	mov esi, 258
	call dlopen@PLT
.callf_env_sep:
	cmp byte ptr [rbx], ':'
	jne .callf_env_next
	inc rbx
	jmp .callf_env_next
.callf_after_dlopen:
	cmp r12, 0
	jl .callf_bad
	cmp r12, 10
	jg .callf_bad
	test r13, r13
	je .callf_bad
	mov rdi, r13
	call __b_cstr
	mov qword ptr [rbp - 112], rax
	xor edi, edi
	mov rsi, rax
	call dlsym@PLT
	test rax, rax
	jne .callf_found
	mov rdi, qword ptr [rbp - 112]
	call rt_cstrlen
	mov rdx, qword ptr [rbp - 112]
	cmp rax, 4094
	jae .callf_bad
	mov byte ptr [rdx + rax], '_'
	mov byte ptr [rdx + rax + 1], 0
	xor edi, edi
	mov rsi, rdx
	call dlsym@PLT
	test rax, rax
	je .callf_bad
.callf_found:
	mov r15, rax
	xor ebx, ebx
.callf_arg_loop:
	cmp rbx, r12
	jae .callf_args_done
	cmp rbx, 4
	jae .callf_stack_src
	mov rax, qword ptr [rbp - 80 + rbx*8]
	jmp .callf_store_arg
.callf_stack_src:
	mov rax, rbx
	sub rax, 4
	mov rax, qword ptr [rbp + 16 + rax*8]
.callf_store_arg:
	mov qword ptr [rbp - 192 + rbx*8], rax
	inc rbx
	jmp .callf_arg_loop
.callf_args_done:
	cmp r12, 6
	jbe .callf_reg_call
	mov rbx, r12
.callf_push_loop:
	cmp rbx, 6
	jbe .callf_reg_call
	dec rbx
	push qword ptr [rbp - 192 + rbx*8]
	jmp .callf_push_loop
.callf_reg_call:
	mov rdi, qword ptr [rbp - 192]
	mov rsi, qword ptr [rbp - 184]
	mov rdx, qword ptr [rbp - 176]
	mov rcx, qword ptr [rbp - 168]
	mov r8,  qword ptr [rbp - 160]
	mov r9,  qword ptr [rbp - 152]
	xor eax, eax
	call r15
	mov r14, rax
	cmp r12, 6
	jbe .callf_done
	mov rax, r12
	sub rax, 6
	shl rax, 3
	add rsp, rax
.callf_done:
	mov rax, r14
	jmp .callf_epilogue
.callf_bad:
	mov rax, -1
.callf_epilogue:
	add rsp, 200
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret

	.globl sx64
	.type sx64, @function
sx64:
	movsx rax, di
	ret

	.globl b_printf
	.type b_printf, @function
b_printf:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	sub rsp, 104
	mov r12, rdi
	xor ebx, ebx
	xor r13d, r13d
	lea r14, [rbp - 88]
	mov qword ptr [r14 + 0], rsi
	mov qword ptr [r14 + 8], rdx
	mov qword ptr [r14 + 16], rcx
	mov qword ptr [r14 + 24], r8
	mov qword ptr [r14 + 32], r9
	lea r15, [rbp + 16]
.pf_loop:
	movzx eax, byte ptr [r12 + rbx]
	inc rbx
	cmp al, 4
	je .pf_done
	test al, al
	je .pf_done
	cmp al, '%'
	je .pf_percent
	movzx edi, al
	call rt_putchar_raw
	jmp .pf_loop
.pf_percent:
	movzx eax, byte ptr [r12 + rbx]
	inc rbx
	cmp al, 4
	je .pf_done
	test al, al
	je .pf_done
	cmp al, '%'
	je .pf_literal_percent
	mov byte ptr [rbp - 89], al
	call rt_next_arg
	movzx ecx, byte ptr [rbp - 89]
	cmp cl, 'd'
	je .pf_signed_dec
	cmp cl, 'u'
	je .pf_unsigned_dec
	cmp cl, 'o'
	je .pf_octal
	cmp cl, 'p'
	je .pf_ptr
	cmp cl, 'c'
	je .pf_char
	cmp cl, 's'
	je .pf_string
	cmp cl, 'z'
	je .pf_zmod
	mov edi, '%'
	call rt_putchar_raw
	movzx edi, byte ptr [rbp - 89]
	call rt_putchar_raw
	jmp .pf_loop
.pf_literal_percent:
	mov edi, '%'
	call rt_putchar_raw
	jmp .pf_loop
.pf_signed_dec:
	mov rdi, rax
	test rdi, rdi
	jns .pf_signed_abs
	neg rdi
	mov qword ptr [rbp - 96], rdi
	mov edi, '-'
	call rt_putchar_raw
	mov rdi, qword ptr [rbp - 96]
.pf_signed_abs:
	mov esi, 10
	call rt_print_u
	jmp .pf_loop
.pf_unsigned_dec:
	mov rdi, rax
	mov esi, 10
	call rt_print_u
	jmp .pf_loop
.pf_octal:
	mov rdi, rax
	mov esi, 8
	call rt_print_u
	jmp .pf_loop
.pf_ptr:
	mov qword ptr [rbp - 96], rax
	mov edi, '0'
	call rt_putchar_raw
	mov edi, 'x'
	call rt_putchar_raw
	mov rdi, qword ptr [rbp - 96]
	mov esi, 16
	call rt_print_u
	jmp .pf_loop
.pf_char:
	mov rdi, rax
	call rt_putchar_raw
	jmp .pf_loop
.pf_string:
	mov rdx, rax
.pf_string_loop:
	movzx edi, byte ptr [rdx]
	inc rdx
	cmp dil, 4
	je .pf_loop
	test dil, dil
	je .pf_loop
	mov qword ptr [rbp - 96], rdx
	call rt_putchar_raw
	mov rdx, qword ptr [rbp - 96]
	jmp .pf_string_loop
.pf_zmod:
	movzx ecx, byte ptr [r12 + rbx]
	inc rbx
	cmp cl, 'u'
	je .pf_unsigned_dec
	cmp cl, 'd'
	je .pf_signed_dec
	mov edi, '%'
	call rt_putchar_raw
	mov edi, 'z'
	call rt_putchar_raw
	movzx edi, cl
	call rt_putchar_raw
	jmp .pf_loop
.pf_done:
	xor eax, eax
	add rsp, 104
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret

	.type rt_next_arg, @function
rt_next_arg:
	cmp r13, 5
	jae .arg_stack
	mov rax, qword ptr [r14 + r13*8]
	inc r13
	ret
.arg_stack:
	mov rax, r13
	sub rax, 5
	mov rax, qword ptr [r15 + rax*8]
	inc r13
	ret

	.type rt_putchar_raw, @function
rt_putchar_raw:
	mov byte ptr [rsp - 1], dil
	mov eax, 1
	mov edi, 1
	lea rsi, [rsp - 1]
	mov edx, 1
	syscall
	ret

	.type rt_print_u, @function
rt_print_u:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 80
	mov rax, rdi
	mov ebx, esi
	lea r8, [rbp - 80]
	xor r9d, r9d
	test rax, rax
	jne .pu_loop
	mov edi, '0'
	call rt_putchar_raw
	jmp .pu_done
.pu_loop:
	xor edx, edx
	div rbx
	cmp dl, 10
	jb .pu_digit
	add dl, 'a' - 10
	jmp .pu_store
.pu_digit:
	add dl, '0'
.pu_store:
	mov byte ptr [r8 + r9], dl
	inc r9
	test rax, rax
	jne .pu_loop
.pu_emit:
	dec r9
	movzx edi, byte ptr [r8 + r9]
	call rt_putchar_raw
	test r9, r9
	jne .pu_emit
.pu_done:
	add rsp, 80
	pop rbx
	pop rbp
	ret

	.type rt_bstrlen, @function
rt_bstrlen:
	xor eax, eax
.bstrlen_loop:
	mov dl, byte ptr [rdi + rax]
	cmp dl, 4
	je .bstrlen_done
	test dl, dl
	je .bstrlen_done
	inc rax
	jmp .bstrlen_loop
.bstrlen_done:
	ret

	.type rt_cstrlen, @function
rt_cstrlen:
	xor eax, eax
.cstrlen_loop:
	cmp byte ptr [rdi + rax], 0
	je .cstrlen_done
	inc rax
	jmp .cstrlen_loop
.cstrlen_done:
	ret

	.type rt_alloc, @function
rt_alloc:
	test rdi, rdi
	jne .alloc_nonzero
	mov edi, 1
.alloc_nonzero:
	add rdi, 15
	and rdi, -16
	mov rsi, rdi
	xor edi, edi
	mov edx, 3
	mov r10d, 34
	mov r8, -1
	xor r9d, r9d
	mov eax, 9
	syscall
	cmp rax, -4095
	jbe .alloc_done
	xor eax, eax
.alloc_done:
	ret

	.data
	.globl b_rd_fd
b_rd_fd:
	.quad 0
	.globl b_wr_fd
b_wr_fd:
	.quad 1
	.globl b_rd_unit
b_rd_unit:
	.quad 0
	.globl b_wr_unit
b_wr_unit:
	.quad -1
__b_argc:
	.quad 0
__b_argv:
	.quad 0
__b_argvb:
	.quad 0
wait_status:
	.quad 0
one_byte:
	.byte 0
got_intr:
	.quad 0
callf_dl_done:
	.quad 0
callf_env_name:
	.asciz "B_CALLF_LIB"
shell_path:
	.asciz "/bin/sh"
shell_dash_c:
	.asciz "-c"

	.bss
	.balign 16
cstr_buf:
	.skip 4096
cstr_buf2:
	.skip 4096
ctime_buf:
	.skip 256
callf_path_buf:
	.skip 4096
