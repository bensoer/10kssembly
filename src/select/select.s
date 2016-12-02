; ==========================================================================
; 
; 	Assembly Output For select.cpp
; 
; 	Produced with:
; 		g++ -Wall -Wextra -pedantic select.cpp -S -masm=intel
;
;	Sources:
;		http://stackoverflow.com/questions/1658294/whats-the-purpose-of-the-lea-instruction
;
; ===========================================================================

	.file	"select.cpp"
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
	sub	rsp, 5472
	mov	edx, 0
	mov	esi, 1
	mov	edi, 2
	call	socket					; create socket
	mov	DWORD PTR [rbp-44], eax
	lea	rax, [rbp-64]
	mov	esi, 16
	mov	rdi, rax
	call	bzero					; bzero
	mov	WORD PTR [rbp-64], 2
	mov	edi, 8000
	call	htons					; convert 8000 to network byte order
	mov	WORD PTR [rbp-62], ax
	mov	edi, 0						; ANY_ADDR
	call	htonl					; convert ANY_ADDR to network byte order
	mov	DWORD PTR [rbp-60], eax
	mov	eax, DWORD PTR [rbp-44]
	lea	rcx, [rbp-64]
	mov	edx, 16
	mov	rsi, rcx
	mov	edi, eax
	call	bind 					; bind to address
	mov	eax, DWORD PTR [rbp-44]
	mov	esi, 10						; set max listen queue to 10
	mov	edi, eax
	call	listen                  ; listen for connections
	mov	eax, DWORD PTR [rbp-44]
	mov	DWORD PTR [rbp-4], eax
	mov	DWORD PTR [rbp-8], 0		; highestClientIndex = 0
	mov	eax, 0
	mov	ecx, 16
	lea	rdx, [rbp-4416]				; generating a pointer to &allset ?
	mov	rdi, rdx
#APP
# 48 "select.cpp" 1
	cld; rep; stosq
# 0 "" 2
#NO_APP
	mov	eax, edi
	mov	edx, ecx
	mov	DWORD PTR [rbp-28], edx
	mov	DWORD PTR [rbp-32], eax
	mov	eax, DWORD PTR [rbp-44]
	lea	edx, [rax+63]
	test	eax, eax
	cmovs	eax, edx
	sar	eax, 6
	mov	esi, eax
	movsx	rax, esi
	mov	rdi, QWORD PTR [rbp-4416+rax*8]
	mov	eax, DWORD PTR [rbp-44]
	cdq
	shr	edx, 26
	add	eax, edx
	and	eax, 63
	sub	eax, edx
	mov	edx, 1
	mov	ecx, eax
	sal	rdx, cl
	mov	rax, rdx
	or	rdi, rax
	mov	rdx, rdi
	movsx	rax, esi
	mov	QWORD PTR [rbp-4416+rax*8], rdx
	mov	DWORD PTR [rbp-12], 0
.L3:
	cmp	DWORD PTR [rbp-12], 1023
	ja	.L2
	mov	eax, DWORD PTR [rbp-12]
	mov	DWORD PTR [rbp-4160+rax*4], -1
	add	DWORD PTR [rbp-12], 1
	jmp	.L3
.L2:
	mov	rax, QWORD PTR [rbp-4416]		; copy of allSet to rset ?
	mov	QWORD PTR [rbp-4288], rax
	mov	rax, QWORD PTR [rbp-4408]
	mov	QWORD PTR [rbp-4280], rax
	mov	rax, QWORD PTR [rbp-4400]
	mov	QWORD PTR [rbp-4272], rax
	mov	rax, QWORD PTR [rbp-4392]
	mov	QWORD PTR [rbp-4264], rax
	mov	rax, QWORD PTR [rbp-4384]
	mov	QWORD PTR [rbp-4256], rax
	mov	rax, QWORD PTR [rbp-4376]
	mov	QWORD PTR [rbp-4248], rax
	mov	rax, QWORD PTR [rbp-4368]
	mov	QWORD PTR [rbp-4240], rax
	mov	rax, QWORD PTR [rbp-4360]
	mov	QWORD PTR [rbp-4232], rax
	mov	rax, QWORD PTR [rbp-4352]
	mov	QWORD PTR [rbp-4224], rax
	mov	rax, QWORD PTR [rbp-4344]
	mov	QWORD PTR [rbp-4216], rax
	mov	rax, QWORD PTR [rbp-4336]
	mov	QWORD PTR [rbp-4208], rax
	mov	rax, QWORD PTR [rbp-4328]
	mov	QWORD PTR [rbp-4200], rax
	mov	rax, QWORD PTR [rbp-4320]
	mov	QWORD PTR [rbp-4192], rax
	mov	rax, QWORD PTR [rbp-4312]
	mov	QWORD PTR [rbp-4184], rax
	mov	rax, QWORD PTR [rbp-4304]
	mov	QWORD PTR [rbp-4176], rax
	mov	rax, QWORD PTR [rbp-4296]
	mov	QWORD PTR [rbp-4168], rax
	mov	eax, DWORD PTR [rbp-4]
	lea	edi, [rax+1]
	lea	rax, [rbp-4288]
	mov	r8d, 0
	mov	ecx, 0
	mov	edx, 0
	mov	rsi, rax
	call	select								; call to select
	mov	DWORD PTR [rbp-16], eax
	mov	eax, DWORD PTR [rbp-44]
	lea	edx, [rax+63]
	test	eax, eax
	cmovs	eax, edx
	sar	eax, 6
	cdqe
	mov	rsi, QWORD PTR [rbp-4288+rax*8]
	mov	eax, DWORD PTR [rbp-44]
	cdq
	shr	edx, 26
	add	eax, edx
	and	eax, 63
	sub	eax, edx
	mov	edx, 1
	mov	ecx, eax
	sal	rdx, cl
	mov	rax, rdx
	and	rax, rsi
	test	rax, rax
	je	.L4
	mov	DWORD PTR [rbp-4436], 16
	mov	eax, DWORD PTR [rbp-44]
	lea	rdx, [rbp-4436]
	lea	rcx, [rbp-4432]
	mov	rsi, rcx
	mov	edi, eax
	call	accept								; accept a new connection
	mov	DWORD PTR [rbp-4440], eax
	mov	DWORD PTR [rbp-20], 0
.L8:
	cmp	DWORD PTR [rbp-20], 1023
	jg	.L5
	mov	eax, DWORD PTR [rbp-20]
	cdqe
	mov	eax, DWORD PTR [rbp-4160+rax*4]
	test	eax, eax
	jns	.L6
	mov	edx, DWORD PTR [rbp-4440]
	mov	eax, DWORD PTR [rbp-20]
	cdqe
	mov	DWORD PTR [rbp-4160+rax*4], edx
	mov	eax, DWORD PTR [rbp-20]
	cmp	eax, DWORD PTR [rbp-8]
	jle	.L14
	mov	eax, DWORD PTR [rbp-20]
	mov	DWORD PTR [rbp-8], eax
	jmp	.L14
.L6:
	add	DWORD PTR [rbp-20], 1
	jmp	.L8
.L14:
	nop
.L5:
	mov	eax, DWORD PTR [rbp-4440]
	lea	edx, [rax+63]
	test	eax, eax
	cmovs	eax, edx
	sar	eax, 6
	mov	esi, eax
	movsx	rax, esi
	mov	rdi, QWORD PTR [rbp-4416+rax*8]
	mov	eax, DWORD PTR [rbp-4440]
	cdq
	shr	edx, 26
	add	eax, edx
	and	eax, 63
	sub	eax, edx
	mov	edx, 1
	mov	ecx, eax
	sal	rdx, cl
	mov	rax, rdx
	or	rdi, rax
	mov	rdx, rdi
	movsx	rax, esi
	mov	QWORD PTR [rbp-4416+rax*8], rdx
	mov	eax, DWORD PTR [rbp-4440]
	cmp	DWORD PTR [rbp-4], eax
	jge	.L9
	mov	eax, DWORD PTR [rbp-4440]
	mov	DWORD PTR [rbp-4], eax
.L9:
	sub	DWORD PTR [rbp-16], 1
.L4:
	mov	DWORD PTR [rbp-24], 0
.L13:
	mov	eax, DWORD PTR [rbp-24]
	cmp	eax, DWORD PTR [rbp-8]
	jg	.L2
	mov	eax, DWORD PTR [rbp-24]
	cdqe
	mov	eax, DWORD PTR [rbp-4160+rax*4]
	test	eax, eax
	js	.L15
	mov	eax, DWORD PTR [rbp-24]
	cdqe
	mov	eax, DWORD PTR [rbp-4160+rax*4]
	lea	edx, [rax+63]
	test	eax, eax
	cmovs	eax, edx
	sar	eax, 6
	cdqe
	mov	rsi, QWORD PTR [rbp-4288+rax*8]
	mov	eax, DWORD PTR [rbp-24]
	cdqe
	mov	eax, DWORD PTR [rbp-4160+rax*4]
	cdq
	shr	edx, 26
	add	eax, edx
	and	eax, 63
	sub	eax, edx
	mov	edx, 1
	mov	ecx, eax
	sal	rdx, cl
	mov	rax, rdx
	and	rax, rsi
	test	rax, rax
	je	.L12
	lea	rax, [rbp-5472]
	mov	edx, 1024
	mov	esi, 0
	mov	rdi, rax
	call	memset								;memset for about to read/write
	mov	eax, DWORD PTR [rbp-24]
	cdqe
	mov	eax, DWORD PTR [rbp-4160+rax*4]
	lea	rcx, [rbp-5472]
	mov	edx, 1024
	mov	rsi, rcx
	mov	edi, eax	
	call	read								; read
	mov	QWORD PTR [rbp-40], rax
	mov	rdx, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rbp-24]
	cdqe
	mov	eax, DWORD PTR [rbp-4160+rax*4]
	lea	rcx, [rbp-5472]
	mov	rsi, rcx
	mov	edi, eax
	call	write								;write
	sub	DWORD PTR [rbp-16], 1
	jmp	.L12
.L15:
	nop
.L12:
	add	DWORD PTR [rbp-24], 1
	jmp	.L13
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
	jne	.L18
	cmp	DWORD PTR [rbp-8], 65535
	jne	.L18
	mov	edi, OFFSET FLAT:_ZStL8__ioinit
	call	_ZNSt8ios_base4InitC1Ev
	mov	edx, OFFSET FLAT:__dso_handle
	mov	esi, OFFSET FLAT:_ZStL8__ioinit
	mov	edi, OFFSET FLAT:_ZNSt8ios_base4InitD1Ev
	call	__cxa_atexit
.L18:
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
