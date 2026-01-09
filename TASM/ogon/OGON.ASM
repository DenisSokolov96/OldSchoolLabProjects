Data Segment
   lines db 'ษอออออออออออออออออออออออออออออออออออป$'
   tab   db 'บÛ*Û*Û*Û*Û*Û*Û*Û*Û*Û*Û*Û*Û*Û*Û*Û*Û*Ûบ$'
         db 'ศอออออออออออออออออออออออออออออออออออผ$'
   cur_color db 1
   old1c     dd ?
Data Ends

Code Segment
 assume cs:code, ds:data

Print Proc
    push ds es di si cx ax dx

    mov ax, data
    mov ds, ax
    mov ax, 0B800h
    mov es, ax

    mov si, offset lines
    mov bh, 1 ;number str write
    mov cx, 3

    DrawRows:
        push cx

        ; DI: (Y-1)*160 + X*2
        mov al, 160
        mov bl, bh
        dec bl
        mul bl               ; AX = (Y-1) * 160
        add ax, 10           ; X = 10 (10*2=20)
        mov di, ax

        ; --- select color ---
        mov ah, 02h          ; standard color for 1 and 3 str
        cmp bh, 2            ; if str = 2
        jne NextChar
        mov ah, [cur_color]
     NextChar:
         lodsb
         cmp al, '$'
         jz NextRow
         mov ah, 02h
         cmp bh, 2
         jne ApplyChar

         cmp al, 'Û' ;0DBh
         je ColorForBlock

         cmp al, '*'
         je ColorForStar

         jmp ApplyChar

     ColorForBlock:
         mov ah, [cur_color]
         jmp ApplyChar

     ColorForStar:
          mov ah, [cur_color]
          add ah, 4
          xor ah, 8
          and ah, 0Fh

     ApplyChar:
         stosw
         jmp NextChar
     NextRow:
         inc bh
         pop cx
         loop DrawRows
         inc byte ptr [cur_color]
         test byte ptr [cur_color], 0Fh
         jnz ColorOk
         inc byte ptr [cur_color]
     ColorOk:
         pop dx ax cx si di es ds
         iret
Print EndP

Start:
    mov ax, data
    mov ds, ax

    mov ax, 0003h
    int 10h

    mov ax, 351Ch
    int 21h
    mov word ptr old1c, bx
    mov word ptr [old1c+2], es

    push ds
    mov dx, offset Print
    mov ax, cs
    mov ds, ax
    mov ax, 251Ch
    int 21h
    pop ds
m1:
    mov ah, 01h
    int 21h
    cmp al, 1bh
    jne m1

Exit:
    lds dx, old1c
    mov ax, 251Ch
    int 21h

    mov ax, 4c00h
    int 21h
Code Ends
End Start
