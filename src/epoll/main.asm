; ================================================================================
;
;	Epoll Server - WARNING DOES NOT WORK. MIGHT COMPILE
;
;	Compile:
;		nams -f elf64 -d ELF_TYPE -i .././ main.asm
;		gcc main.o -o main.out
;
; ================================================================================


%include "../constants.inc"
%include "../structures.inc"
%include "../functions.inc"

SECTION .data

format: dd `num: %d\n`, 10, 0
integer dd 0


INADDR_ANY	equ		0							; bind to any nic
IP			equ		htonl(INADDR_ANY)

PORT 		equ 	htons(8000)		; set port for server
EPOLL_QUEUE_LENGTH	equ 	10

my_sa: istruc sockaddr_in
            at sockaddr_in.sin_family, dw PROTO_FAM
            at sockaddr_in.sin_port, dw PORT
            at sockaddr_in.sin_addr, dd INADDR_ANY
            at sockaddr_in.sin_zero, dd 0, 0   ;  for struct sockaddr
        iend


events: dd epoll_event, 10

data: istruc epoll_data

event: istruc epoll_event
		at epoll_event.events, dd 0x001
		at epoll_event.data, istruc data


BUFFERLEN equ 1024


SECTION .bss


BUFFER resb BUFFERLEN
fd_socket resd 1
fd_conn resd 1
fd_conn_bytes resd 1

fd_epoll resd 1


SECTION .text
global main


main:

	; setup epoll
	mov event.events, 0x001
	mov event.data, data

	
	; create a socket
	call create_socket

	mov event.data.fd, [fd_socket]

	; create epoll
	mov rdi, EPOLL_QUEUE_LENGTH
	mov rax, SYS_EPOLL_CREATE
	syscall
	mov [fd_epoll], rax





	;call start_server


create_socket:

	enter 0,0

	; create a socket
	mov rdi, PROTO_FAM
 	mov rsi, PROTO_TYPE
 	mov rdx, PROTO
	mov rax, SYS_SOCKET
	syscall

	mov [fd_socket], rax ; sockfd is in rax, put a copy in rbx for now

	; bind the socket to a port
	mov rdi, [fd_socket]
	mov rax, SYS_BIND
	mov rsi, my_sa								; address to struct sockaddr my_sa
	mov rdx, sockaddr_in_size
	syscall

	; start listening for connections
	mov rdi, [fd_socket]
	mov rsi, SYS_LISTEN_BACKLOG
	mov rax, SYS_LISTEN
	syscall

	leave
	ret


start_server:

	; create a socket
	mov rdi, PROTO_FAM
 	mov rsi, PROTO_TYPE
 	mov rdx, PROTO
	mov rax, SYS_SOCKET
	syscall

	mov [fd_socket], rax ; sockfd is in rax, put a copy in rbx for now

	; bind the socket to a port
	mov rdi, [fd_socket]
	mov rax, SYS_BIND
	mov rsi, my_sa								; address to struct sockaddr my_sa
	mov rdx, sockaddr_in_size
	syscall

	; start listening for connections
	mov rdi, [fd_socket]
	mov rsi, SYS_LISTEN_BACKLOG
	mov rax, SYS_LISTEN
	syscall



close_connection:

	; shutdown connection
	mov rdi, [fd_conn]
	mov rsi, 2
	mov rax, SYS_SHUTDOWN
	syscall

	; close the connection
	mov rdi, [fd_conn]
	mov rax, SYS_CLOSE
	syscall

	mov rax, SYS_GETPID
	syscall

	mov rdi, rax
	mov rsi, 3
	mov rax, SYS_KILL

	call exit_nicely
	


	