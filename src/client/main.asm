; ===========================================================================

;    Sources:
;		https://github.com/arno01/SLAE/blob/master/exam1/shell_bind_tcp.nasm
;		https://forum.nasm.us/index.php?topic=1811.0
;		https://ubuntuforums.org/archive/index.php/t-1105208.html
;		http://stackoverflow.com/questions/31373650/nasm-data-strings
;		http://stackoverflow.com/questions/21968011/nasm-printing-unix-time
;		http://syscalls.kernelgrok.com/
;		http://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/
;		http://www.nasm.us/doc/nasmdoc3.html
;		https://www.csee.umbc.edu/portal/help/nasm/sample.shtml
;		http://stackoverflow.com/questions/3941771/nasm-random-number-generator-function - contains how to get time of day
;
;	Future:
;		http://stackoverflow.com/questions/4298195/how-to-use-gettimeofday-to-get-the-current-date
;
;	Build:
;		nasm -f elf64 -d ELF_TYPE -i .././  main.asm
;
;
;
; ============================================================================

%include "../constants.inc"
%include "../structures.inc"
%include "../functions.inc"

SECTION .data

format: dd `Response: %s\n`, 10, 0
format2: dd `Sending: %s\n`, 10, 0
format3: dd `RTT: %d milliseconds\n`, 10, 0

MESSAGE db "Echo Helloo!", 0

BUFFERLEN equ 1024


PORT 		equ 	htons(8000)		; set port for server

;IP			equ		htonl(127.0.0.1)

;_ip equ 0x7F000001	; loopback - 127.0.0.1
;_port equ 2002


;LOCALHOST equ 0x0100007f
LOCALHOST equ htonl(0x7F000001)  ; THIS IS LOCALHOST IN HEX

my_sa: istruc sockaddr_in
            at sockaddr_in.sin_family, dw PROTO_FAM
            at sockaddr_in.sin_port, dw PORT
            at sockaddr_in.sin_addr, dd LOCALHOST
            at sockaddr_in.sin_zero, dd 0, 0   ;  for struct sockaddr
        iend

tv: istruc TIMEVAL
    		at  TIMEVAL.tv_sec,     dq 0
    		at  TIMEVAL.tv_usec,    dq 0
		iend

tv2: istruc TIMEVAL
	at  TIMEVAL.tv_sec,     dq 0
	at  TIMEVAL.tv_usec,    dq 0
iend

%define tv.tv_sec tv+TIMEVAL.tv_sec
%define tv.tv_usec tv+TIMEVAL.tv_usec

%define tv2.tv_sec tv2+TIMEVAL.tv_sec
%define tv2.tv_usec tv2+TIMEVAL.tv_usec

SECTION .bss
fd_socket resd 1
BUFFER resb BUFFERLEN

sendtime resq 1
recvtime resq 1

DIFBUFFER resq 1


SECTION .text
global main
extern printf


main:


	; create a socket
	mov rdi, PROTO_FAM
 	mov rsi, PROTO_TYPE
 	mov rdx, PROTO
	mov rax, SYS_SOCKET
	syscall

	mov [fd_socket], rax ; sockfd is in rax, put a copy in rbx for now

	; connect to a server
	mov rdi, [fd_socket]
	mov rsi, my_sa
	mov rdx, sockaddr_in_size
	mov rax, SYS_CONNECT
	syscall

loop:

	;print what were sending first
	push rbp

	mov rdi, format2
	mov rsi, MESSAGE
	mov rax, 0
	call printf

	pop rbp


	; get the system time
	;mov rdi, 0
	;mov rbx, 0
	;mov rax, SYS_TIME
	;syscall
	;mov [sendtime], rax

	mov rsi, 0
	mov rdi, tv
	mov rax, SYS_GETTIMEOFDAY
	syscall
	mov rax, [tv.tv_usec]
	mov [sendtime], rax


	;write to the server
	mov rdi, [fd_socket]
	mov rsi, MESSAGE
	mov rdx, 14
	mov rax, SYS_WRITE
	syscall

	;read the response
	; read from the descriptor
	mov rdi, [fd_socket]
	mov rsi, BUFFER
	mov rdx, BUFFERLEN
	mov rax, SYS_READ
	syscall

	; get the system time
	;mov rdi, 0
	;mov rbx, 0
	;mov rax, SYS_TIME
	;syscall
	;mov [recvtime], rax
	mov rsi, 0
	mov rdi, tv2
	mov rax, SYS_GETTIMEOFDAY
	syscall
	mov rax, [tv2.tv_usec]
	mov [recvtime], rax

	;print the response
	push rbp
	mov rdi, format
	mov rsi, BUFFER
	mov rax, 0
	call printf
	pop rbp


	; print system time difference
	mov rax, [sendtime]
	mov rbx, [recvtime]
	sub rbx, rax
	;rax now has the time difference in seconds
	mov [DIFBUFFER], rbx


	;print the response
	push rbp
	mov rdi, format3
	mov rsi, rbx
	mov rax, 0
	call printf
	pop rbp

	jmp loop