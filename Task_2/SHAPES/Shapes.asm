TITLE DRAW SHAPES
;-----------------------------------------------
; AUTHOR : Youssef Gamal
;
;-----------------------------------------------

.386
.MODEL FLAT
ExitProcess PROTO NEAR32 stdcall , dwExitCode:DWORD
INCLUDE io.h 
cr EQU 0dh
Lf EQU 0ah
.STACK 4096


.DATA
prm1   BYTE "1-Print Solid Triangle ",cr,Lf,0
prm2   BYTE "2-Print Solid Square ",cr,Lf,0
prm3   BYTE "3-Print Solid Rectangle ",cr,Lf,0
prm4   BYTE "4-Print Framed Triangle",cr,Lf,0
prm5   BYTE "5-Print Framed Square ",cr,Lf,0
prm6   BYTE "6-Print Framed Rectangle ",cr,Lf,0
prm7   BYTE "Choose a number from 1 to 6  or 0 to exit ",cr,Lf,0
prm8   BYTE "Enter Len ",cr,Lf,0
prm9   BYTE "Enter Wid ",cr,Lf,0
prm10  BYTE " INVALID !!!! TRY AGAIN",cr,Lf,0
string BYTE 4 DUP (?)
Len DWORD ?
Wid  DWORD ?
NewLine BYTE cr,lf,0
Star   BYTE ('*'),0
Space  BYTE (' '),0


.CODE

;--------------------------SOLID-----------------------

;--------------------------SOLID TRIANGLE-----------------------
Print_Solid_Triangle PROC NEAR32
mov ecx,0

l1:
cmp ecx,Len
je   _end
mov ebx,0
l2:
cmp ebx,ecx
jg _end_l2
output Star
inc ebx

jmp l2

_end_l2:
output NewLine
inc ecx
jmp l1

_end:
ret 
Print_Solid_Triangle ENDP
;----------------------------------------------------------------


;--------------------------SOLID SQUARE-----------------------
Print_Solid_Square PROC NEAR32

mov ecx,0

l1:
cmp ecx,Len
je   _end
mov ebx,0
l2:
cmp ebx,Len
je _end_l2
output Star
inc ebx

jmp l2

_end_l2:
output NewLine
inc ecx
jmp l1

_end:
ret
Print_Solid_Square ENDP
;---------------------------------------------------------------


;--------------------------SOLID RECTANGLE-----------------------
Print_Solid_Rectangle PROC NEAR32

mov ecx,0

l1:
cmp ecx,Wid
je   _end
mov ebx,0
l2:
cmp ebx,Len
je _end_l2
output Star
inc ebx

jmp l2

_end_l2:
output NewLine
inc ecx
jmp l1

_end:
ret

Print_Solid_Rectangle ENDP
;------------------------------------------------------------------

;--------------------------FRAMED-----------------------

;--------------------------FRAMED TRIANGLE-----------------------
Print_Framed_Triangle PROC NEAR32

mov ecx,1

l1:
cmp ecx,Len
jg   _end

mov ebx,1
l2:
cmp ebx,ecx 
jg _end_l2

cmp ebx,1
je _print_star

cmp ecx,Len
je _print_star

cmp ebx,ecx
jne _else



_print_star:

output Star

jmp _cont

_else:
output  Space 


_cont:
inc ebx
jmp l2


_end_l2:
output NewLine
inc ecx
jmp l1

_end:
 ret
Print_Framed_Triangle ENDP
;-------------------------------------------------------------------------

;--------------------------FRAMED SQUARE-----------------------
Print_Framed_Square PROC NEAR32

mov ecx,1


l1:
cmp ecx,Len
jg   _end
mov ebx,1
l2:
cmp ebx,Len 
jg _end_l2

cmp ebx,1
je _print_star

cmp ebx,Len
je _print_star

cmp ecx,1
je _print_star

cmp ecx,Len
jne _else

_print_star:

output Star

jmp _cont

_else:
output  Space 

_cont:
inc ebx
jmp l2


_end_l2:
output NewLine
inc ecx
jmp l1

_end:
ret
Print_Framed_Square ENDP
;-----------------------------------------------------------------

;--------------------------FRAMED RECTANGLE-----------------------
Print_Framed_Rectangle PROC NEAR32

mov ecx,1

l1:
cmp ecx,Wid
jg   _end
mov ebx,1
l2:
cmp ebx,Len 
jg _end_l2

cmp ebx,1
je _print_star

cmp ebx,Len
je _print_star

cmp ecx,1
je _print_star

cmp ecx,Wid
jne _else

_print_star:

output Star

jmp _cont

_else:
output  Space 

_cont:
inc ebx
jmp l2


_end_l2:
output NewLine
inc ecx
jmp l1

_end:
ret
Print_Framed_Rectangle ENDP
;--------------------------------------------------------------

;---------------------MENU-----------------
Print_Menu PROC NEAR32
output prm1
output prm2
output prm3
output prm4
output prm5
output prm6
output prm7
input  string,4 
atod   string
ret
Print_Menu ENDP
;------------------------------------------

_start:

_for:

call Print_Menu
cmp eax,0
jl  _invalid
cmp eax , 6
jng  _ok

_invalid:
output prm10
jmp _start

_ok:

cmp eax,0
je  _end 
cmp eax,1
jne _else2
output prm8
input string,4
atod string
mov Len,eax
call Print_Solid_Triangle
jmp _end


_else2:
cmp eax,2
jne _else3
output prm8
input string,4
atod string
mov Len,eax
call Print_Solid_Square
jmp _end

_else3:
cmp eax,3
jne _else4
output prm8
input string,4
atod string
mov Len,eax
output prm9
input string,4
atod string
mov Wid,eax
call Print_Solid_Rectangle
jmp _end

_else4:

cmp eax,4
jne _else5
output prm8
input string,4
atod string
mov Len,eax
call Print_Framed_Triangle
jmp _end

_else5:
cmp eax,5
jne _else6
output prm8
input string,4
atod string
mov Len,eax
call Print_Framed_Square
jmp _end

_else6:
cmp eax,6
output prm8
input string,4
atod string
mov Len,eax
output prm9
input string,4
atod string
mov Wid,eax
call Print_Framed_Rectangle
jmp _end




_end:

invoke EXITPROCESS,0 
PUBLIC _start
END
