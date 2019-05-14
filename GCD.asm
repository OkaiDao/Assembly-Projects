TITLE Chapter 7, zd supplied (GCD.asm)
;Program: Chapter 7 Greatest Common Divisor
;Description: Takes a file and shows what the time is.
;Student:	Jonathan Dao
;Date:	10/16/18
;Class:	CSCI 241
;Instructor:	Mr. Ding

INCLUDE Irvine32.inc

.data

msgPrompt BYTE "Enter two values, this program will calculate the greatest common denominator.", 0Dh, 0Ah, 0Dh, 0Ah, 0
msgVar1 BYTE "First Number: ", 0
msgVar2 BYTE "Second Number: ", 0
msgConc BYTE "The greatest common denominator is: ", 0

.code
mainGCD PROC

mov edx, OFFSET msgPrompt
call WriteString
mov edx, OFFSET msgVar1
call WriteString
call ReadInt
mov ebx, eax
call Crlf

mov edx, OFFSET msgVar2
call WriteString
call ReadInt
mov ecx, eax
call Crlf

call Crlf
mov edx, OFFSET msgConc
call WriteString

call FindGCD
mov eax, edx

call WriteDec

call Crlf
ret
mainGCD ENDP


;------------------------------------------------
FindGCD PROC
; Calculates the greatest common denominator.
; Receives: ebx (Var1), ecx (Var2)
; Returns: edx (GCD)
;------------------------------------------------

cmp ebx, 0 ;Check neg number.
JGE SecVar
NEG ebx ;If negative, get two's complement.

SecVar:

	cmp ecx, 0
	JGE GCDstep
	NEG ecx ;if negative get two's complement.

GCDstep:

	mov edx, 0
	mov eax, ebx
	div ecx

	mov ebx, ecx
	mov ecx, edx

	cmp ecx, 0

jnz GCDstep

	mov edx, ebx 
	ret

FindGCD ENDP

end mainGCD
