.model small       ; Define memory model as 'small' which uses separate code and data segments.
.stack 100h        ; Define stack size as 100h (256 bytes).

.data
msg     db "Enter a number between 0 and 9: $"  ; Define a string for the user prompt.
even    db "The given number is even$"           ; Define a string for displaying if the number is even.
odd     db "The given number is odd$"            ; Define a string for displaying if the number is odd.

.code
main proc
    mov ax, @data     ; Load the address of the data segment into ax register.
    mov ds, ax        ; Set the data segment register (ds) to the address of the data segment.

    mov ah, 09h       ; DOS function 09h: Display string.
    lea dx, msg       ; Load the effective address (lea) of the msg string into dx.
    int 21h           ; Call interrupt 21h to print the message (display prompt to user).

    mov ah, 01h       ; DOS function 01h: Read a character from standard input.
    int 21h           ; Call interrupt 21h to get a single character input from user.

    sub al, '0'       ; Convert the ASCII character to its numerical value by subtracting ASCII '0' (i.e., convert '1' -> 1).
    
    cmp al, 0         ; Compare the input value with 0 (check if it's less than 0).
    jl invalid        ; Jump to invalid label if the number is less than 0 (invalid input).

    cmp al, 9         ; Compare the input value with 9 (check if it's greater than 9).
    jg invalid        ; Jump to invalid label if the number is greater than 9 (invalid input).

    mov ah, 0         ; Clear the AH register (it will hold the remainder of the division later).

    mov bl, 2         ; Load the value 2 into the BL register (to check if the number is divisible by 2).

    div bl            ; Divide AL (input number) by 2. 
                      ; The result will be in AL, and the remainder (modulus) will be in AH.

    cmp ah, 0         ; Compare the remainder (in AH) with 0.
    je even_num       ; If remainder is 0, jump to even_num (even case).
    jmp odd_num       ; Otherwise, jump to odd_num (odd case).

even_num:
    mov ah, 09h       ; DOS function 09h: Display string.
    lea dx, even      ; Load the address of the 'even' message.
    int 21h           ; Call interrupt 21h to print the "even" message.
    jmp exit          ; Jump to exit to terminate the program.

odd_num:
    mov ah, 09h       ; DOS function 09h: Display string.
    lea dx, odd       ; Load the address of the 'odd' message.
    int 21h           ; Call interrupt 21h to print the "odd" message.

invalid:
    mov ah, 4Ch       ; DOS function 4Ch: Exit program.
    int 21h           ; Call interrupt 21h to terminate the program.

exit:
    mov ax, 4C00h     ; DOS function 4Ch: Exit program with return code 0.
    int 21h           ; Call interrupt 21h to terminate the program.

end main            ; Mark the end of the main procedure.
