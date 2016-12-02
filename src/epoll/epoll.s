; ==========================================================================
; 
; 	Assembly Output For epoll.cpp
; 
; 	Produced with:
; 		g++ -Wall -Wextra -pedantic epoll.cpp -S -masm=intel
;
;	Sources:
;		
;
; ===========================================================================
	.file	"epoll.cpp"
	.intel_syntax noprefix
	.section	.rodata
	.type	_ZStL19piecewise_construct, @object
	.size	_ZStL19piecewise_construct, 1
_ZStL19piecewise_construct:
	.zero	1
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.text
	.globl	main
	.type	main, @function
main:
.LFB2341:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 1248
	mov	edx, 0
	mov	esi, 1
	mov	edi, 2
	call	socket							; create the socket
	mov	DWORD PTR [rbp-8], eax
	lea	rax, [rbp-48]
	mov	esi, 16
	mov	rdi, rax
	call	bzero							; bzero
	mov	WORD PTR [rbp-48], 2
	mov	edi, 8000							; bind to port 8000
	call	htons							; convert to net byte order
	mov	WORD PTR [rbp-46], ax
	mov	edi, 0								; INADDR_ANY
	call	htonl							;convert INADDR_ANY to byte order
	mov	DWORD PTR [rbp-44], eax
	lea	rcx, [rbp-48]
	mov	eax, DWORD PTR [rbp-8]
	mov	edx, 16
	mov	rsi, rcx
	mov	edi, eax
	call	bind 							; bind system call
	mov	eax, DWORD PTR [rbp-8]
	mov	esi, 10
	mov	edi, eax
	call	listen 							; listen system call
	mov	DWORD PTR [rbp-12], 10
	mov	edi, 10
	call	epoll_create					; epoll_create system call
	mov	DWORD PTR [rbp-16], eax
	mov	DWORD PTR [rbp-192], -2147483623
	mov	eax, DWORD PTR [rbp-8]
	mov	DWORD PTR [rbp-188], eax
	lea	rcx, [rbp-192]
	mov	edx, DWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rbp-16]
	mov	esi, 1
	mov	edi, eax
	call	epoll_ctl						; epoll_ctl system call
.L7:
	lea	rsi, [rbp-176]
	mov	eax, DWORD PTR [rbp-16]
	mov	ecx, -1
	mov	edx, 10
	mov	edi, eax
	call	epoll_wait						; epoll_wait system call
	mov	DWORD PTR [rbp-20], eax
	mov	DWORD PTR [rbp-4], 0
.L6:										; if (events[i].events & (EPOLLHUP | EPOLLERR)) {
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-20]
	jge	.L7
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, rdx
	add	rax, rax
	add	rax, rdx
	sal	rax, 2
	add	rax, rbp
	sub	rax, 176
	mov	eax, DWORD PTR [rax]
	and	eax, 24
	test	eax, eax
	je	.L3
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, rdx
	add	rax, rax
	add	rax, rdx
	sal	rax, 2
	add	rax, rbp
	sub	rax, 172
	mov	eax, DWORD PTR [rax]
	mov	edi, eax
	call	close							; close connection on failure
.L3:										; if (events[i].data.fd == sfd) {
	mov	eax, DWORD PTR [rbp-4]				
	movsx	rdx, eax
	mov	rax, rdx
	add	rax, rax
	add	rax, rdx
	sal	rax, 2
	add	rax, rbp
	sub	rax, 172
	mov	eax, DWORD PTR [rax]
	cmp	eax, DWORD PTR [rbp-8]
	jne	.L4
	mov	DWORD PTR [rbp-212], 16
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, rdx
	add	rax, rax
	add	rax, rdx
	sal	rax, 2
	add	rax, rbp
	sub	rax, 172
	mov	eax, DWORD PTR [rax]
	lea	rdx, [rbp-212]
	lea	rcx, [rbp-208]
	mov	rsi, rcx
	mov	edi, eax
	call	accept							; accept connection
	mov	DWORD PTR [rbp-24], eax
	mov	eax, DWORD PTR [rbp-24]
	mov	edx, 0
	mov	esi, 3
	mov	edi, eax
	mov	eax, 0
	call	fcntl							; fcntl part 1 make socket non-hang
	or	ah, 8
	mov	edx, eax
	mov	eax, DWORD PTR [rbp-24]
	mov	esi, 4
	mov	edi, eax
	mov	eax, 0
	call	fcntl							; fcntl make socket non-hang
	mov	eax, DWORD PTR [rbp-24]
	mov	DWORD PTR [rbp-188], eax
	lea	rcx, [rbp-192]
	mov	edx, DWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rbp-16]
	mov	esi, 1
	mov	edi, eax
	call	epoll_ctl 						; add new connection to epoll
	jmp	.L5
.L4:										; } else {
	lea	rax, [rbp-1248]
	mov	edx, 1024
	mov	esi, 0
	mov	rdi, rax
	call	memset
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, rdx
	add	rax, rax
	add	rax, rdx
	sal	rax, 2
	add	rax, rbp
	sub	rax, 172
	mov	eax, DWORD PTR [rax]
	lea	rcx, [rbp-1248]
	mov	edx, 1024
	mov	rsi, rcx
	mov	edi, eax
	call	read							; read data
	mov	QWORD PTR [rbp-32], rax
	mov	rsi, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, rdx
	add	rax, rax
	add	rax, rdx
	sal	rax, 2
	add	rax, rbp
	sub	rax, 172
	mov	eax, DWORD PTR [rax]
	lea	rcx, [rbp-1248]
	mov	rdx, rsi
	mov	rsi, rcx
	mov	edi, eax
	call	write							; write data
.L5:
	add	DWORD PTR [rbp-4], 1
	jmp	.L6
	.cfi_endproc
.LFE2341:
	.size	main, .-main
	.type	_Z41__static_initialization_and_destruction_0ii, @function
_Z41__static_initialization_and_destruction_0ii:
.LFB2801:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	DWORD PTR [rbp-4], edi
	mov	DWORD PTR [rbp-8], esi
	cmp	DWORD PTR [rbp-4], 1
	jne	.L10
	cmp	DWORD PTR [rbp-8], 65535
	jne	.L10
	mov	edi, OFFSET FLAT:_ZStL8__ioinit
	call	_ZNSt8ios_base4InitC1Ev
	mov	edx, OFFSET FLAT:__dso_handle
	mov	esi, OFFSET FLAT:_ZStL8__ioinit
	mov	edi, OFFSET FLAT:_ZNSt8ios_base4InitD1Ev
	call	__cxa_atexit
.L10:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2801:
	.size	_Z41__static_initialization_and_destruction_0ii, .-_Z41__static_initialization_and_destruction_0ii
	.type	_GLOBAL__sub_I_main, @function
_GLOBAL__sub_I_main:
.LFB2802:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	esi, 65535
	mov	edi, 1
	call	_Z41__static_initialization_and_destruction_0ii
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2802:
	.size	_GLOBAL__sub_I_main, .-_GLOBAL__sub_I_main
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I_main
	.hidden	__dso_handle
	.ident	"GCC: (GNU) 6.2.1 20160916 (Red Hat 6.2.1-2)"
	.section	.note.GNU-stack,"",@progbits
