

SECTION .data

; socket address structure
struc sockaddr_in
    .sin_family resw 1
    .sin_port resw 1
    .sin_addr resd 1
    .sin_zero resb 8
endstruc

struc TIMEVAL
    .tv_sec:    resq    1
    .tv_usec:   resq    1
endstruc

%define tv.tv_sec tv+TIMEVAL.tv_sec
%define tv.tv_usec tv+TIMEVAL.tv_usec


; epoll data structure
struc epoll_data
	.fd resw 1
	.u32 resd 1
	.u64 resd 2
endstruc

; epoll event structure
struc epoll_event
	.events resd 1
	.data resb 7
endstruc