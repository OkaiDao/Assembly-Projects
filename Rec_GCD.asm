TITLE Chapter 8, zd supplied (Rec_GCD.asm)
;Program: Chapter 8 Recursive Greatest Common Divisor
;Description: Calculates the greatest common divisor recursively.
;Student: Jonathan Dao
;Date:	10/30/18
;Class:	CSCI 241
;Instructor: Mr. Ding

INCLUDE Irvine32.inc

;---------------------------------------------------
CalcGcd PROTO, int1:DWORD, int2:DWORD
; Calculate the greatest common divisor, of
;     two nonnegative integers in recursion.
; Receives: int1, int2
; Returns:  EAX = Greatest common divisor
;---------------------------------------------------

;---------------------------------------------------
ShowResult PROTO, int1:DWORD, int2:DWORD, gcd:DWORD
; Show calculated GCD result as
;      "GCD of 5 and 20 is 5"
; Receives: int1, int2, gcd
;---------------------------------------------------

.data

msgProgram BYTE "This program shows the GCD between numbers in an array of values using PBV.", 0dh, 0ah, 0
msgFinish BYTE "End of program.", 0dh, 0ah, 0
msgPrompt BYTE "GCD of ", 0
msgAnd BYTE " and ", 0
msgIs BYTE " is ", 0


array DWORD 5,20, 10,24, 24,18, 11,7, 438,226, 26,13


.code
mainRec_GCD PROC
	;Displays program

	mov edx, OFFSET msgProgram
	call WriteString
	call Crlf
	mov esi, 0
	mov edi, 4
	mov ecx, 6

	ArLoop:

		INVOKE CalcGCD, [array+esi], [array+edi]
		INVOKE ShowResult, [array+esi], [array+edi], eax
		call Crlf

		cmp ecx, 0
		jz Done

		add esi, 8	;gives access violation when iterrating through final step of loop must reset after use
		add edi, 8

	loop ArLoop

	Done:

		mov esi, 0
		mov edi, 0

	ret
mainRec_GCD ENDP

;---------------------------------------------------
CalcGcd PROC USES ebx ecx edx, 
Int1 :DWORD, Int2 :DWORD 
; Calculate the greatest common divisor, of
;     two nonnegative integers in recursion.
; Receives: int1, int2
; Returns:  EAX = Greatest common divisor
;---------------------------------------------------


	mov eax, Int1
	mov ebx, Int2
	
	mov edx, 0
	div ebx
	mov eax, ebx
	mov ebx, edx
	
	cmp ebx, 0
	je FoundGCD


	INVOKE CalcGCD, eax, ebx

	FoundGCD:

	
	ret

CalcGcd ENDP
	

;---------------------------------------------------
ShowResult PROC USES eax edx,
int1:DWORD, int2:DWORD, gcd:DWORD
; Show calculated GCD result as
;      "GCD of 5 and 20 is 5"
; Receives: int1, int2, gcd
;---------------------------------------------------

	mov edx, OFFSET msgPrompt
	call WriteString
	mov eax, int1
	call WriteDec
	
	mov edx, OFFSET msgAnd
	call WriteString
	mov eax, int2
	call WriteDec
	
	mov edx, OFFSET msgIs
	call WriteString
	mov eax, gcd
	call WriteDec
	
	ret
ShowResult ENDP

end mainRec_GCD
