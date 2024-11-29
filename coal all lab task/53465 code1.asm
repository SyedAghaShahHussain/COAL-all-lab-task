.model small
.stack 100h
.data
 alph db "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z $"
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
