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
	mov rax, 1
	mov rdi, 1
	mov rsi, prompt
	mov rdx, lprompt
	syscall

	mov rax, 0
	mov rdi, 0
	mov rsi, buffer
	mov rdx, 256
	syscall

	mov rax, 2
	mov rdi, buffer
	mov rsi, 0
	mov rdx, 00644
	syscall

	cmp rax, -1
	jne open_success
	call open_fail
	open_success:

	mov [fd], rax

	mov rax, 3
	mov rdi, [fd]
	syscall

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

