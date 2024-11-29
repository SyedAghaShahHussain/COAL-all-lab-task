.model small         ; Define memory model as 'small' (separate code and data segments).
.stack 100h          ; Define stack size of 100h (256 bytes).

.data
    numbers db 5 dup(0)       ; Define an array 'numbers' to hold 5 elements initialized to 0.
    prompt db 'Enter a number (0-9): $'  ; Prompt string for user input.
    newline db 0Dh, 0Ah, '$'  ; Newline characters (carriage return and line feed).
    display_msg db 'You entered: $'   ; Message to display before showing entered numbers.

.code
main proc
    ; Initialize the data segment
    mov ax, @data       ; Load the address of the data segment into the AX register.
    mov ds, ax          ; Set the DS (data segment) register to the address of the data segment.

    ; Input loop: Get 5 numbers from the user
    mov cx, 5           ; Set CX to 5 (we want to collect 5 numbers).
    mov si, 0           ; Initialize SI to 0 (array index).

input_loop:
    ; Display the prompt to the user
    mov dx, offset prompt  ; Load the address of the prompt string into DX.
    mov ah, 09h            ; DOS function 09h: Display string (print the prompt).
    int 21h                ; Call interrupt 21h to display the prompt.

    ; Read the user input (single character)
    mov ah, 01h            ; DOS function 01h: Read a character from standard input.
    int 21h                ; Call interrupt 21h to read one character from the user.
    sub al, '0'            ; Convert the ASCII value to a number by subtracting '0'.
    mov numbers[si], al    ; Store the input number in the 'numbers' array at index 'si'.

    ; Print newline after each input
    mov dx, offset newline ; Load the address of the newline string into DX.
    mov ah, 09h            ; DOS function 09h: Display string (print newline).
    int 21h                ; Call interrupt 21h to print the newline.

    ; Increment the index and loop
    inc si                 ; Increment the index (SI) to store the next number in the array.
    loop input_loop        ; Decrement CX and repeat the loop until CX is 0 (5 iterations).

    ; Display the "You entered: " message
    mov dx, offset display_msg  ; Load the address of the "You entered: " message into DX.
    mov ah, 09h                 ; DOS function 09h: Display string.
    int 21h                     ; Call interrupt 21h to display the message.

    ; Display the entered numbers
    mov cx, 5                  ; Set CX to 5 (number of entries to display).
    mov si, 0                  ; Reset SI to 0 (array index).

display_loop:
    mov al, numbers[si]   
