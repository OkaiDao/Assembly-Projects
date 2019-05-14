TITLE Chapter 6, zd supplied (Color_Matrix.asm)
;Program: Ch 6 Color Matrix
;Description: Displays different forground colors on backgrounds.
;Student:	Jonathan Dao
;Date:	9/27/18
;Class:	CSCI 241
;Instructor:	Mr. Ding

INCLUDE Irvine32.inc

.data

Var1 BYTE "O", 0

.code
main3 proc

	mov ecx, 16
	mov eax, 0
	mov edx, 0

	LoopOutter:
	
		mov ebx, ecx
		mov ecx, 16
	
			LoopInner:
				
				mov al, dl
				call SetTextColor	
					
				inc al
				mov dl, al
				mov al, Var1
				call WriteChar
			loop LoopInner

		call Crlf
		mov ecx, ebx

	loop LoopOutter
	
	mov al, 8
	mov ah, 0
	call SetTextColor

	ret
main3 ENDP
end main3