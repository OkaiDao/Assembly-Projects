TITLE Chapter 6, zd supplied (BoolCalc.asm)
;Program: Uses a table to calculate bool values that a user inputs.
;Description: 

Comment !
- AND_op: Prompt the user for two hexadecimal integers. AND them
  together and display the result in hexadecimal.
- OR_op: Prompt the user for two hexadecimal integers. OR them
  together and display the result in hexadecimal.
- NOT_op: Prompt the user for a hexadecimal integer. NOT the
  integer and display the result in hexadecimal.
- XOR_op: Prompt the user for two hexadecimal integers. Exclusive-OR
  them together and display the result in hexadecimal.
!

;Student:	Jonathan Dao
;Date:	10/9/18
;Class:	CSCI 241
;Instructor:	Mr. Ding


INCLUDE Irvine32.inc

.data
msgMenu BYTE "---- Boolean Calculator ----------",0dh,0ah
   BYTE 0dh,0ah
   BYTE "1. x AND y"     ,0dh,0ah
   BYTE "2. x OR y"      ,0dh,0ah
   BYTE "3. NOT x"       ,0dh,0ah
   BYTE "4. x XOR y"     ,0dh,0ah
   BYTE "5. Exit program",0

msgAND BYTE "Boolean AND",0
msgOR  BYTE "Boolean OR",0
msgNOT BYTE "Boolean NOT",0
msgXOR BYTE "Boolean XOR",0

msgInvalid BYTE "The character entered is invalid, please choose another number: ",0
msgOperand1 BYTE "Input the first 32-bit hexadecimal operand:  ",0
msgOperand2 BYTE "Input the second 32-bit hexadecimal operand: ",0
msgResult   BYTE "The 32-bit hexadecimal result is:            ",0

caseTable BYTE '1'   ; lookup value
	DWORD AND_op
EntrySize = ($ - caseTable)
	BYTE '2'
	DWORD OR_op
	BYTE '3'
	DWORD NOT_op
	BYTE '4'
	DWORD XOR_op
	BYTE '5'
	DWORD ExitProgram
NumberOfEntries = ($ - caseTable) / EntrySize

.code
main08stub PROC

Menu:
	mov edx, OFFSET msgMenu   ; Show menu in a loop
	call WriteString
	call Crlf

Check:   
   call ReadChar	; Call ReadChar to get the input
   call Crlf
	
	;verify the input	
   call IsDigit	; if al is digit set ZF
   jnz Invalid	; if not digit go back
   cmp al, 35h	; check if digit is less than or equal to 5
   ja Invalid ; still invalid digit, go back
	jmp Next
 	; end verify
Invalid:
	mov edx, OFFSET msgInvalid 
	call WriteString
	call Crlf
	jmp Check

Next:
 
 mov ebx, OFFSET CaseTable
 call ChooseProcedure
 JNC Menu ; if CF set, exit
			  ; otherwise display menu again

	ret
main08stub ENDP

;------------------------------------------------
ChooseProcedure PROC
;
; Selects a procedure from the caseTable
; Receives: AL (the number of operation the user entered), EBX (The CaseTable)
; Returns: if CF set, exit; else continue 
;------------------------------------------------

Find:
   cmp al, [ebx]
   jne NotFound
   call NEAR PTR [ebx + 1]
   ;call WriteString
   JC Found
   call Crlf
   jmp Found

 NotFound:
  add ebx, EntrySize
  jmp Find

  Found:
	ret
ChooseProcedure ENDP

;------------------------------------------------
AND_op PROC
;
; Performs a boolean AND operation
; Receives: Nothing
; Returns: Nothing
;------------------------------------------------

	mov edx, OFFSET msgAND
	call WriteString
	call Crlf
	call Crlf

	mov edx, OFFSET msgOperand1 ;Breaks proc rule
	call WriteString
	call ReadHex ;input string moves string into eax
	mov ebx, eax	;Save first to ebx

	mov edx, OFFSET msgOperand2 ;Breaks proc rule
	call WriteString
	call ReadHex ;input string moves string into eax
		
	and ebx, eax
	mov eax, ebx
	
	mov edx, OFFSET msgResult
	call WriteString
	call WriteHex
    call Crlf

	ret

AND_op ENDP

;------------------------------------------------
OR_op PROC
;
; Performs a boolean OR operation
; Receives: Nothing
; Returns: Nothing
;------------------------------------------------

	mov edx, OFFSET msgOR
	call WriteString
	call Crlf
	call Crlf

	mov edx, OFFSET msgOperand1 ;Breaks proc rule
	call WriteString
	call ReadHex ;input string moves string into eax
	mov ebx, eax	;Save first to ebx

	mov edx, OFFSET msgOperand2 ;Breaks proc rule
	call WriteString
	call ReadHex ;input string moves string into eax
		
	or ebx, eax
	mov eax, ebx

	mov edx, OFFSET msgResult
	call WriteString
	call WriteHex
	call Crlf

	ret

OR_op ENDP

;------------------------------------------------
NOT_op PROC
;
; Performs a boolean NOT operation.
; Receives: Nothing
; Returns: Nothing
;------------------------------------------------

	mov edx, OFFSET msgNOT
	call WriteString
	call Crlf
	call Crlf

	mov edx, OFFSET msgOperand1 ;Breaks proc rule
	call WriteString
	call ReadHex ;input string moves string into eax

	not eax

	mov edx, OFFSET msgResult
	call WriteString
	call WriteHex
    call Crlf


	ret
	

NOT_op ENDP

;------------------------------------------------
XOR_op PROC
;
; Performs an Exclusive-OR operation
; Receives: Nothing
; Returns: Nothing
;------------------------------------------------

	mov edx, OFFSET msgXOR
	call WriteString
	call Crlf
	call Crlf

	mov edx, OFFSET msgOperand1 ;Breaks proc rule
	call WriteString
	call ReadHex ;input string moves string into eax
	mov ebx, eax	;Save first to ebx

	mov edx, OFFSET msgOperand2 ;Breaks proc rule
	call WriteString
	call ReadHex ;input string moves string into eax
		
	xor ebx, eax
	mov eax, ebx

	mov edx, OFFSET msgResult
	call WriteString
	call WriteHex
    call Crlf

	ret

XOR_op ENDP

;------------------------------------------------
ExitProgram PROC
;
; Receives: Nothing
; Returns: Sets CF = 1 to signal end of program
;------------------------------------------------

	stc
	ret

ExitProgram ENDP

END ;main08stub