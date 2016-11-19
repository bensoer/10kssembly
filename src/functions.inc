
%include "constants.inc"

SECTION .text
extern printf

argsexist:
;	enter 0,0
;	pusha

	cmp dword[rsp + 4], 1
	je return0

return1:
;	popa
	mov rax, 1
;	leave
	ret

return0:
;	popa
	mov rax, 0
;	leave
	ret

exit_with_rax:


	mov rdi, rax 			; set the exit code
	mov rax, SYS_EXIT
	syscall
	ret	

exit_error:

	mov rdi, 1
	mov rax, SYS_EXIT
	syscall
	ret

exit_nicely:
	
	mov rdi, 0
	mov rax, SYS_EXIT
	syscall
	ret

asmprintf_int:

     ;prep
     push rbp

     mov rdi, format
     mov rsi, [integer]
     mov rax, 0 

     call printf                 ; call printf system call
     
     ;cleanup
     pop rbp
    
     ret