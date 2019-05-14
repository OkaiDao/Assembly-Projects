TITLE Chapter 8            (NonRecFac.asm)

Comment !
Description: Write a nonrecursive version of the Factorial procedure
(Section 8.5.2) that uses a loop. Write a short program that
interactively tests your Factorial procedure. Let the user enter
the value of n. Display the calculated factorial.
!
;Student:	Jonathan Dao
;Date:	10/23/18
;Class:	CSCI 241
;Instructor:	Mr. Ding

INCLUDE Irvine32.inc

.data
msgInput BYTE "Enter the value of n to calculate " 
   BYTE "the factorial (-1 to quit): ",0
msgOutput BYTE "The factorial is: ",0
factorialError  BYTE "Error: Result does not fit "
   BYTE "in 32 bits.",0

.code
mainNRF PROC

L1:
   ; message to display
   mov edx, OFFSET msgInput
   call WriteString
   ; get an integer n from the user
   call ReadInt		;value placed in eax
   call Crlf
   cmp eax, -1
   je quit   ; if n is -1, go quit
   
	 call _FactorialIterative
	jno finOutput
	mov edx, OFFSET factorialError
	call WriteString
	call Crlf
	call Crlf

	jmp Done

   ; if OK, display factorial 
	 finOutput:

	 mov edx, OFFSET msgOutput
	 call WriteString
	 call WriteInt
	call Crlf

Done:

   jmp L1

quit: 

mainNRF ENDP

;---------------------------------------------------
_FactorialIterative PROC USES ecx edx
;
; Calculates a factorial nonrecursively
; Receives: eax = value of n to calculate factorial
; Returns: eax = calculated factorial
;---------------------------------------------------

	cmp eax, 0
	jne stFac

	mov eax, 1
	stFac:

	mov ecx, eax
	mov ebx, 1
	mov eax, 1
	mov edx, 0

	LoopFac:
		
		mul ebx
		jo Finished	;check overflow
		
		cmp ebx, ecx
		je Finished

		inc ebx


		jmp LoopFac
   
   Finished:

		ret
_FactorialIterative ENDP

END mainNRF

