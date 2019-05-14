TITLE Chapter 7, zd supplied (Sub_Packed.asm)
;Program: Subtraction with packed BCD
;Description: Performs an operation of subtraction with two Packed_BCD's
;Student:	Jonathan Dao
;Date:	10/18/18
;Class:	CSCI 241
;Instructor:	Mr. Ding

INCLUDE Irvine32.inc

.data

msgProgram BYTE "Subtraction with Packed BCD", 0Dh, 0Ah, 0
msgPrompt1 BYTE "Enter the minuend (Up to 8 digits): ", 0
msgPrompt2 BYTE "Enter the Subtrahend (Up to 8 digits): ", 0
msgCFset BYTE "1:", 0
subIcon Byte " - ", 0
equalIcon Byte " = ", 0


.code
main07PackedBcdSub PROC


; Show program title
	mov edx, OFFSET msgProgram
	call WriteString
	call Crlf

; Input the Minuend by reading hexadecimal 
	mov edx, OFFSET msgPrompt1
	call WriteString
	call ReadHex
	mov ecx, eax	;Minuend in ecx

	call Crlf
; Input the Subtrahend by reading hexadecimal 
	mov edx, OFFSET msgPrompt2
	call WriteString
	call ReadHex
	mov ebx, eax	;Subtrahend in ebx
	call Crlf

; Call PackedBcdSub for EAX-EBX with result in EDX
	mov eax, ecx	;Prepair registers	;minuend in eax
									;subtrahend in ebx
	
	call PackedBcdSub		; edx holds difference
	mov ecx, edx			; store difference in ecx
; Check CF to add a borrow if necessary
	
	jnc nCFset
	mov edx, OFFSET msgCFset
	call WriteString

; Output by writing hexadecimal    
	
	nCFset:

	call WriteHex	; Write Minuend
	mov edx, OFFSET subIcon 
	call WriteString
	mov eax, ebx
	call WriteHex	;Write Subrtahend
	mov edx, OFFSET equalIcon 
	call WriteString
	mov eax, ecx
	call WriteHex	;Write Difference
	
	call Crlf
	ret
main07PackedBcdSub ENDP

;-----------------------------------------------------------------
PackedBcdSub PROC uses EAX EBX
;
; Performs operation EAX-EBX Packed BCD to return the difference
; Receives: EAX, First number, Minuend, to be subtracted from
;           EBX, Second number, Subtrahend, to be subtracted
; Returns:  EDX, Result, the difference
;           CF=1, if need a borrow, else CF=0
;----------------------------------------------------------------

	clc	;clear carry flag 
	mov ecx, 4	;set loop counter

	SubLoop:
		
		sbb al, bl
		das
		pushfd		;push carry
		

		ROR ebx, 8	; Rotate to sub al byte by byte
		ROR eax, 8
		
		popfd		;pop carry.

	loop SubLoop
	
	mov edx, eax ; move difference to return from edx
	 

	ret
PackedBcdSub ENDP

end ;main07PackedBcdSub
