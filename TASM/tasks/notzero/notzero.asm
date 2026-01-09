Data Segment
   m db 5,0,3,0,0,0,7,0,9,10,9,5,0,6,0
   num db 0
Data Ends

MyStack Segment Stack
   db 128 dup(?)
   stack_top label word
MyStack Ends

Code Segment
   assume cs:code, ds:data, ss:MyStack
 Start:
     mov ax, data
     mov ds, ax
     mov ax, MyStack
     mov ss, ax
     mov sp, offset stack_top

     xor bx, bx
     mov cx, 15
   m1:
      cmp byte ptr m[bx], 0
      je no
      inc num
   no:
      inc bx
      loop m1

      mov dl, num
      add dl, 30h
      mov ah, 02h
      int 21h

      mov ah, 4ch
      mov al, 0
      int 21h
Code Ends
 End Start
