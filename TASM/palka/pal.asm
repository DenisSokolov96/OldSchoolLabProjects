Data Segment
  tab db '-\|/'
  Num equ 4
  Tekpos dw 0
  MaxDel equ 4
  del db maxdel
  old1c dd ?
Data Ends
Code Segment
  assume cs:code, ds:data
  Timer Proc Far
    push ds es ax bx
    mov ax,data
    mov ds,ax
    dec byte ptr ds:del
    jnz No
    mov byte ptr ds:del,Maxdel
    mov ax,0B800h
    mov es,ax
    mov bx,Tekpos
    mov al,tab[bx]
    inc byte ptr ds:tekpos
    cmp byte ptr ds:tekpos,num
    jb Video
    mov byte ptr ds:tekpos,0
  Video:
    mov byte ptr es:[0],al
  No:
    pop bx ax es ds
    iret
  Timer EndP
 Start:
  mov ax,data
  mov ds,ax
  mov ax,351ch
  int 21h
  mov word ptr ds:old1c,bx
  mov word ptr ds:[old1c+2],es
  push cs
  pop ds
  mov dx,offset timer
  mov ax,251ch
  int 21h
 m1: mov ah,1
  int 16h
  jz m1
  mov ax,data
  mov ds,ax
  mov ax,251ch
  lds dx,ds:old1c
  int 21h
  mov ax,4c00h
  int 21h
Code Ends
End Start