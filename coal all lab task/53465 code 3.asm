.model small
.stack 100h
.data
    arr db 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'  ; Array of characters
    prompt db 'Enter a character (a-h): $'
    found_msg db 'The character is found.$'
    not_found_msg db 'The character is not found.$'
    input_char db ?  ; Variable to store user input
    newline db 0Dh, 0Ah, '$'  ; New line characters

.code
main:
    ; Initialize the data segment
    mov ax, @data
    mov ds, ax

    ; Print prompt for user input
    mov ah, 09h
    lea dx, prompt
    int 21h

    ; Read character from input
    mov ah, 01h
    int 21h
    mov input_char, al  ; Store the input character

    ; Initialize pointer to the array
    lea si, arr          ; Load address of the array
    mov cx, 8            ; Length of the array

    ; Loop through the array to check for the character
check_loop:
    cmp al, [si]        ; Compare input character with the array element
    je char_found        ; If equal, jump to char_found

    inc si               ; Move to the next character in the array
    loop check_loop      ; Loop until all elements are checked

    ; If we reach here, the character was not found
    jmp char_not_found

char_found:
    ; Print found message
    mov ah, 09h
    lea dx, found_msg
    int 21h
    jmp exit

char_not_found:
    ; Print not found message
    mov ah, 09h
    lea dx, not_found_msg
    int 21h

exit:
    ; Print newline
    mov ah, 09h
    lea dx, newline
    int 21h

    ; Exit program
    mov ax, 4C00h
    int 21h

end main