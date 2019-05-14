TITLE Chapter 7, zd supplied (ShowFileTime.asm)
;Program: Chapter 7 Display File Time
;Description: Takes a file and shows what the time is.
;Student:	Jonathan Dao
;Date:	10/11/18
;Class:	CSCI 241
;Instructor:	Mr. Ding

INCLUDE Irvine32.inc

.data

msgPrompt BYTE "Please enter 16-bit hexadecimal (4-diget, e.g., 1207): ", 0
msgEquivalent Byte "Your equivalent binary is ", 0
msgResult BYTE "Your time is", 0
msgPretty BYTE ":", 0

.code
maintime PROC

	mov edx, OFFSET msgPrompt		;Prompt 1 for proc
	mov ecx, OFFSET msgEquivalent	;Prompt 2 for proc
	call inPrompt	;Asks for hex value, returns value in eax after displaying in binary.
	mov esi, OFFSET msgPretty	
	call ShowFileTime
	call crlf
	ret
maintime ENDP

;------------------------------------------------
inPrompt PROC
; Inserts hex prompt, writes as binary, returns input.
; Receives: EDX (Prompt 1 Asks for inputed 16bit hex value), ECX (Prompt2 says binary value will be...) 
; Returns: eax (Inputed 16bit hex number)
;------------------------------------------------

	
	call WriteString			;Write prompt
	call ReadHex				;Read input puts into eax
	call crlf
	mov edx, ecx				;Set to write prompt 2
	call WriteString			;Write Prompt 2
	mov ebx, 2 ;sets to write AX
	call WriteBinB				;Write inputed hex as binary.
	call crlf

	ret

inPrompt ENDP



;------------------------------------------------
DispTime PROC
; Displays
; Receives: AX (Time value.), esi (Prompt)
; Returns: nothing 
;------------------------------------------------

	cmp ax, 9
	ja GTen
	mov cx, ax
	mov eax, 0
	call WriteDec ; write 0
	mov ax, cx

	GTen:

		call WriteDec
		
	ret

DispTime ENDP


;------------------------------------------------
ShowFileTime PROC
; Writes file time using 16 bit, 5bit(hour):6bit(minute):5bitx2(second)
; Receives: AX (Time value.) esi (Display offset)
; Returns: Nothing
;------------------------------------------------

	mov bx, ax ;Saves original ax to bx
	
	;Hour 
	
	SHR ax, 11	;create leading zeros and move to lsb.
	call DispTime
	mov edx, esi
	call WriteString

	;Minutes
	mov ax, bx ; reset ax
	SHL ax, 5	;mov value wanted to hsb.
	ROL ax, 6	;create leading zeros and move to lsb.
	mov ah, 0
	call DispTime
	mov edx, esi
	call WriteString


	;Seconds
	mov ax, bx ; reset ax
	SHL ax, 11	;mov value wanted to hsb.
	ROL ax, 5
	add ax, ax ; time x 2
	call DispTime
	call crlf
	ret

ShowFileTime ENDP

end maintime
