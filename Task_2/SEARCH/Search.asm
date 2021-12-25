TITLE SEARCH FOR AN ELEMENT
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
max_siz EQU 5
.STACK 4096
	

.DATA
prm1   BYTE "Enter array elements - 5 elements",cr,Lf,0
prm2   BYTE "Enter value : ",cr,Lf,0
prm3   BYTE " Search For : : ",cr,Lf,0

arr    DWORD 5 DUP (?)
string BYTE 11 DUP (?)
not_found BYTE " NOT FOUND ",cr,Lf,0
found  BYTE "Found at : "
_AT BYTE 11 DUP (?)


.CODE


;------------------SEARCH---------------------
Search PROC NEAR32

output prm3
input string,11
atod string

lea ebx,arr
mov ecx,0
_for:
cmp ecx , max_siz
je _IFnotfound
cmp eax,[ebx+ecx*4]
je _IFfound

inc ecx 
jmp _for




_IFfound:
inc ecx
dtoa _AT,ecx
output found
jmp _end

_IFnotfound:
output not_found

_end:

ret
SEARCH ENDP
;-----------------------------------------


_start :

lea ebx,arr
mov ecx , max_siz
output prm1


 l1 :
 output prm2
 input string,11
atod string
mov [ebx],eax
add ebx,4
loop l1




call Search




INVOKE ExitProcess,0
PUBLIC _start
END

