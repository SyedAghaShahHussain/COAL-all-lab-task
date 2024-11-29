.model small
.stack 100h
.data
 alph db "z y x w v u t s r q p o n m l k j i h g f e d c b a $"
 .code
 main proc 
    mov ax, @data 
    mov ds,ax
    mov dx,offset alph
    mov ah,09h
    int 21h
    
    mov ah,4ch
    int 21h
    
    main endp
 
 end main 
 
 
 
 