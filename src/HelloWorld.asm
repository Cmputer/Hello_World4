section .data
    message db 'Hello, World!', 0
    prompt db 'Press the enter key to continue...', 0
    input db 100, 0
section .text
    global _start
_start:
    ; print "Hello, World!"
    mov eax, 4
    mov ebx, 1
    mov ecx, message
    mov edx, 13
    int 0x80

    ; print prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 31
    int 0x80

    ; read input
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 100
    int 0x80

    ; loop until input is empty
input_loop:
    cmp byte [input], 0
    jne input_error
    jmp input_loop

    ; input was empty, print message
print_message:
    call _print_message
    mov eax, 1
    xor ebx, ebx
    int 0x80

    ; print error message and read input again
input_error:
    mov eax, 4
    mov ebx, 1
    mov ecx, error_message
    mov edx, 36
    int 0x80
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 100
    int 0x80
    jmp input_loop

; subroutine to print the message
_print_message:
    mov eax, 4
    mov ebx, 1
    mov ecx, message
    mov edx, 13
    int 0x80
    ret
