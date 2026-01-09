Data Segment
 MsgStart db 10, 13, 'Start organ:', 10, 13, '/******************************\', 10, 13, '$'
 MsgStop db '\******************************/', 10, 13, 'Stop organ$', 10, 13, '$'
 Press db ' * button pressed - ', '$'
 NewStr db 10, 13, '$'
Data Ends
Code Segment
 assume cs:Code, ds:Data
 SetFrequency Proc
    out 42h,al
    xchg al,ah
    out 42h,al
    ret
 SetFrequency EndP
 TurnUpSound PROC
    in al,61h
    or al,00000011b
    out 61h,al
    ret
 TurnUpSound EndP
 SwitchOffSound Proc
    in al,61h
    and al,11111100b
    out 61h,al
    ret
 SwitchOffSound EndP
 StopProc Proc
    mov cx,0004h ; high byte - pause microseconds
    mov ax,8600h
    int 15h ; pause
    ret
 StopProc EndP
 Message Proc
    mov ah,09h
    int 21h
    ret
 Message EndP
 Start:
    mov ax,Data
    mov ds,ax
    lea dx,[MsgStart]
    call Message
    m1:
      lea dx,[Press]
      call Message
      mov ah,01h ; write to screen press button
      int 21h
      lea dx,[NewStr] ; \n
      call Message
      mov ah,al
      cmp ah,41h
      je m2
    m2:
      cmp al,1bh ; al == 1bh (code Esc)
      jz Exit
    mov bl,40
    mul bl
    add ax,600
    call SetFrequency
    call TurnUpSound
    call StopProc
    call SwitchOffSound
    jmp m1
 Exit:
    lea dx,[MsgStop]
    call Message
    mov ax,4c00h
    int 21h
Code Ends
  End Start
  End Exit
