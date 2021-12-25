TITLE OPERATIONS
;-----------------------------------------------
; AUTHOR : Youssef Gamal
;
;-----------------------------------------------

.386
.MODEL FLAT
.STACK 4096
ExitProcess PROTO NEAR32 stdcall , dwExitProcess:DWORD
INCLUDE io.h
 
cr EQU 0DH
Lf EQU 0AH

.DATA
prm1	BYTE  "1- X + Y ",cr,Lf,0
prm2	BYTE  "2- X * Y ",cr,Lf,0
prm3	BYTE  "3- X / Y ",cr,Lf,0
prm4	BYTE  "4- X ^ Y ",cr,Lf,0
prm5	BYTE  "Choose Operation Number from 1 to 4  or 0 to exit ",cr,Lf,0
prm6	BYTE  "Enter first number ",cr,Lf,0
prm7	BYTE  "Enter second number ",cr,Lf,0
prm8    BYTE  " INVALID !! TRY AGAIN ",cr,Lf,0
string  BYTE  11 DUP (?)
num1    DWORD ?
num2    DWORD ?
result  BYTE  "result = "
res     BYTE  11 DUP (?)


.CODE

Sum_2_digits PROC NEAR32

mov eax , num1
add eax , num2 
dtoa res , eax
output result
ret
Sum_2_digits ENDP

Mul_2_digits PROC NEAR32
mov eax ,num1
mul num2
dtoa res , eax
output result

ret
Mul_2_digits ENDP


Div_2_digits PROC NEAR32

mov edx,0
mov eax,num1
div num2
dtoa res , eax
output result
ret
Div_2_digits ENDP


X_Power_Y PROC NEAR32

mov ecx, num2
mov eax,1
l1:
mul num1
loop l1
dtoa res , eax
output result

ret
X_Power_Y ENDP


Start_Menu PROC NEAR32
output prm1
output prm2
output prm3 
output prm4
output prm5
input string,11
atod string

ret
Start_Menu ENDP
_start:

_for:

call Start_Menu
cmp eax,0
jl  _invalid
cmp eax , 4
jng  _ok

_invalid:
output prm8
jmp _start

_ok:

cmp eax,0
je  _end

 
cmp eax,1
jne _else2
output prm6
input string,11
atod string 
mov num1,eax
output prm7
input string,11
atod string
mov num2,eax
call Sum_2_digits
jmp _end


_else2:
cmp eax,2
jnle _else3
output prm6
input string,11
atod string 
mov num1,eax
output prm7
input string,11
atod string
mov num2,eax
call Mul_2_digits

jmp _end

_else3:
cmp eax,3
jne _else4
output prm6
input string,11
atod string 
mov num1,eax
output prm7
input string,11
atod string
mov num2,eax

cmp num2,0
je _invalid

call Div_2_digits

jmp _end

_else4:

cmp eax,4
jne _end
output prm6
input string,11
atod string 
mov num1,eax
output prm7
input string,11
atod string
mov num2,eax
cmp num2,0
jne _call_proc
dtoa res,1
output result
jmp _end

;---------------------------
; *OPTIMIZATION NEEDED !!
;--------------------------- 
_call_proc:
call X_Power_Y

jmp _end

_end:
INVOKE ExitProcess ,0
PUBLIC _start
END





