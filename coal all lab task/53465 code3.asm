.model small         ; Define memory model as 'small' (separate code and data segments).
.stack 100h          ; Define stack size of 100h (256 bytes).

.data
    alph db "z y x w v u t s r q p o n m l k j i h g f e d c b a $"  ; Define a string of letters from 'z' to 'a', separated by spaces, ending with a '$'.

.code
main proc
    ; Initialize the data segment
    mov ax, @data      ; Load the address of the data segment into the AX register.
    mov ds, ax         ; Set the DS (data segment) register to the address of the data segment.

    ; Display the string (alphabet in reverse order)
    mov dx, offset alph   ; Load the address of the 'alph' string into the DX register.
    mov ah, 09h            ; DOS function 09h: Display string (print the string stored at the address in DX).
    int 21h                ; Call interrupt 21h to print the string at the address stored in DX (the reverse alphabet).

    ; Exit program
    mov ah, 4Ch            ; DOS function 4Ch: Exit program (terminate the program).
    int 21h                ; Call interrupt 21h to terminate the program.

main endp               ; Mark the end of the 'main' procedure.

end main                ; Mark the end of the program.
