TITLE Chapter 11 Color_Screen	     (Color_Screen.asm)
;Program: ; Write a program that fills each screen cell with a random character, in a random color. 
;The characters could be printable from ASCII code 20h (Space) to 07Ah (lower case z) without control characters. 
;Assign a 50% probability that the color of any character will be red. Assign a 25% probability of green and 25% of yellow.
;Student:	Jonathan Dao
;Date:	11/27/18
;Class:	CSCI 241
;Instructor: Mr. Ding

INCLUDE Irvine32.inc

BuffSize = 50

.data

outHandle HANDLE ?
cellsWritten DWORD ?
xyPos COORD <0,0>
xyPos2 COORD <0,21>
Buffer BYTE BuffSize DUP (?)


Attributes WORD BuffSize DUP (?)

.code
mainCS PROC
	

	;Fills Array with rando color and characters.
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov outHandle, eax
	mov esi, OFFSET Buffer
	mov edi, OFFSET Attributes
	mov ecx, 20

	LineDisp:
		
		push ecx
		mov ecx, 50

	
		Fill:

			call ChooseColor
			mov [edi], ax
			call ChooseCharacter
			mov [esi], al
			add edi, TYPE Attributes
			add esi, TYPE Buffer

		loop Fill

		mov esi, OFFSET Buffer
		mov edi, OFFSET Attributes
	
	
		INVOKE WriteConsoleOutputAttribute, outHandle, edi, BuffSize, xyPos, ADDR cellsWritten
		INVOKE WriteConsoleOutputCharacter, outHandle, esi, BuffSize, xyPos, ADDR cellsWritten

		add xyPos.y, 1
		
		pop ecx

	loop LineDisp	

	INVOKE SetConsoleCursorPosition, outHandle, xyPos2
	call Crlf
	
	ret

mainCS ENDP

;-----------------------------------------------------------------------
ChooseColor PROC
; Selects a color with 50% probability of red, 25% green and 25% yellow
; Receives: nothing
; Returns:  AX = randomly selected color

	mov eax, 4
	call RandomRange

	.IF eax <= 1		; If 0 or 1 Red
		mov ax, red+(black*16)					;Set Red
	.ELSEIF eax == 2	; If 2 Green
		mov ax, green+(black*16)					;Set Green			  
	.ELSE				; If 3 Yellow
		mov ax, yellow+(black*16)					;Set Yellow
	.ENDIF

	ret
ChooseColor ENDP

;-----------------------------------------------------------------------
ChooseCharacter PROC
; Randomly selects an ASCII character, from ASCII code 20h to 07Ah
; Receives: nothing
; Returns:  AL = randomly selected character

	mov eax, 5ah
	call RandomRange
	add al, 020h

	ret

ChooseCharacter ENDP

END mainCS
