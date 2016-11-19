

%define PROTO_FAM 			2					; AF_INET
%define PROTO_TYPE			1					; SOCK_STREAM
%define PROTO 				0
%define SYS_SOCKET			41					; sys_socket call name
%define SYS_BIND			49					; sys_bind call name
%define SYS_LISTEN			50					; sys_listen call name
%define SYS_LISTEN_BACKLOG	10					; how many tcp connections can be queued
%define SYS_ACCEPT			43					; accept a connection

%define SYS_READ			0					; sys call to read from descriptor
%define SYS_WRITE			1					; sys call to write to descriptor
%define SYS_CLOSE			3					; sys call to close the descriptor
%define SYS_SHUTDOWN		48					; sys call to shutdown connection

%define SYS_EXIT			60					; sys call to exit the program
%define SYS_FORK			57					; sys call to fork the process
%define SYS_GETPID			39					; sys call to get my process id
%define SYS_KILL			62					; sys call to kill process

; Convert numbers (constants!) to network byte order
%define htonl(x) ((x & 0xFF000000) >> 24) | ((x & 0x00FF0000) >> 8) | ((x & 0x0000FF00) << 8) | ((x & 0x000000FF) << 24)
%define htons(x) ((x >> 8) & 0xFF) | ((x & 0xFF) << 8)