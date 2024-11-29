.model small
.stack 100h
.data
msg db "Enter a number between 0 and 9: $"
even db "The given number is even$"
odd db "The given number is odd$"
.code
main proc
mov ax, @data
mov ds, ax
mov ah, 09h
lea dx, msg
int 21h
mov ah, 01h ; read character input
int 21h
sub al, '0'
cmp al, 0 ; check if number is less than 0
jl invalid
cmp al, 9 ; check if number is greater than 9
jg invalid
mov ah, 0 ; clear ah register
 
mov bl,2 
div bl   ; divide by 2 for finding even or odd
cmp ah, 0 ; check if remainder is 0
je even_num
jmp odd_num
even_num:
mov ah, 09h
lea dx, even
int 21h
jmp exit
odd_num:
mov ah, 09h
lea dx, odd
int 21h 
invalid:
mov ah,4ch
int 21h
exit:
mov ax, 4C00h ; exit program
int 21h
end main