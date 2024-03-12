section .data
	prompt db "Enter a filename: "
	lprompt equ $ - prompt

	open_fail_msg db "Failed to open the specified file", 10;
	lopen_fail_msg equ $ - open_fail_msg


section .bss
	buffer resb 256
	fd resb 4

section .text
global _start

_start:
	; Print the filename prompt
	mov rax, 1
	mov rdi, 1
	mov rsi, prompt
	mov rdx, lprompt
	syscall

	; Read the response
	mov rax, 0
	mov rdi, 0
	mov rsi, buffer
	mov rdx, 256
	syscall

	; Try to open the file
	mov rax, 2
	mov rdi, buffer
	mov rsi, 0
	mov rdx, 00644
	syscall

	; Check for open failures
	cmp rax, 0
	je open_success
	call open_fail
	open_success:

	; Store the file descriptor
	mov [fd], rax

	; Close the file
	mov rax, 3
	mov rdi, [fd]
	syscall

	; Exit the program
	exit:
	mov rax, 60
	mov rdi, 0
	syscall

open_fail:
	mov rax, 1
	mov rdi, 1
	mov rsi, open_fail_msg
	mov rdx, lopen_fail_msg
	syscall

	mov rax, 60
	mov rdi, 1
	syscall

