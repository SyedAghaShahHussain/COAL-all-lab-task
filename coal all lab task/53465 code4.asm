.model small
.stack 100h
.data
    numbers db 5 dup(0)     
    prompt db 'Enter a number (0-9): $'
    newline db 0Dh, 0Ah, '$' 
    display_msg db 'You entered: $'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Input loop
    mov cx, 5              
    mov si, 0              

input_loop:
    ; Display prompt
    mov dx, offset prompt
    mov ah, 09h
    int 21h

    ; Read input
    mov ah, 01h
    int 21h
    sub al, '0'
    mov numbers[si], al    

    ; Print newline
    mov dx, offset newline
    mov ah, 09h
    int 21h

    inc si
    loop input_loop         

    ; Display numbers
    mov dx, offset display_msg
    mov ah, 09h
    int 21h

    mov cx, 5
    mov si, 0

display_loop:
    mov al, numbers[si]     
    add al, '0'             
    mov ah, 0Eh             
    int 10h                 

    mov al, ' '
    mov ah, 0Eh
    int 10h

    inc si
    loop display_loop       

    ; Print newline
    mov dx, offset newline
    mov ah, 09h
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h

main endp
end main
