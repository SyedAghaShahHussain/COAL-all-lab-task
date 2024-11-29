.model small          ; Define memory model as 'small' (separate code and data segments).
.stack 100h           ; Define stack size of 100h (256 bytes).

.data
    arr db 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'  ; Array of characters (a-h).
    prompt db 'Enter a character (a-h): $'         ; Prompt message to ask user for input.
    found_msg db 'The character is found.$'         ; Message to display if the character is found in the array.
    not_found_msg db 'The character is not found.$' ; Message to display if the character is not found in the array.
    input_char db ?                                  ; Variable to store user input.
    newline db 0Dh, 0Ah, '$'                         ; New line characters for output formatting.

.code
main:
    ; Initialize the data segment
    mov ax, @data       ; Load the address of the data segment into the AX register.
    mov ds, ax          ; Set the DS (data segment) register to the address of the data segment.

    ; Print prompt for user input
    mov ah, 09h         ; DOS function 09h: Display string (print the prompt).
    lea dx, prompt      ; Load the effective address (LEA) of the prompt message into DX.
    int 21h             ; Call interrupt 21h to print the string stored at the address in DX (prompt message).

    ; Read character from input
    mov ah, 01h         ; DOS function 01h: Read a character from standard input.
    int 21h             ; Call interrupt 21h to read one character from the keyboard.
    mov input_char, al  ; Store the input character (AL) into the input_char variable.

    ; Initialize pointer to the array
    lea si, arr         ; Load the effective address of the array 'arr' into SI register (array pointer).
    mov cx, 8           ; Set CX to 8 (the length of the array, as there are 8 characters in the array).

    ; Loop through the array to check for the character
check_loop:
    cmp al, [si]        ; Compare the input character (AL) with the character at the address pointed by SI (current array element).
    je char_found       ; If the characters are equal, jump to the char_found label to print the found message.

    inc si              ; Increment the SI register to point to the next character in the array.
    loop check_loop     ; Decrement CX and loop until CX becomes zero, i.e., all array elements have been checked.

    ; If we reach here, the character was not found in the array
    jmp char_not_found  ; Jump to char_not_found to print the not found message.

char_found:
    ; Print found message
    mov ah, 09h         ; DOS function 09h: Display string (print the found message).
    lea dx, found_msg   ; Load the effective address of the "found" message into DX.
    int 21h             ; Call interrupt 21h to print the string stored at the address in DX (found message).
    jmp exit            ; Jump to the exit section of the program.

char_not_found:
    ; Print not found message
    mov ah, 09h         ; DOS function 09h: Display string (print the not found message).
    lea dx, not_found_msg ; Load the effective address of the "not found" message into DX.
    int 21h             ; Call interrupt 21h to print the string stored at the address in DX (not found message).

exit:
    ; Print newline to create a line break after the message
    mov ah, 09h         ; DOS function 09h: Display string (print a newline).
    lea dx, newline     ; Load the effective address of the newline string (0Dh, 0Ah) into DX.
    int 21h             ; Call interrupt 21h to print the newline string.

    ; Exit program
    mov ax, 4C00h       ; DOS function 4Ch: Exit program with return code 0 (success).
    int 21h             ; Call interrupt 21h to terminate the program and return to DOS.

end main              ; Mark the end of the main procedure.
