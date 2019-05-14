TITLE Chapter 6, zd supplied (Color_Jump.asm)
;Program: Ch 6 Color Matrix Using Jump instruction.
;Description: Displays different forground colors on backgrounds with conditional jump loop.
;Student:	Jonathan Dao
;Date:	9/27/18
;Class:	CSCI 241
;Instructor:	Mr. Ding

INCLUDE Irvine32.inc

Var1 = "0"

.data

.code
main4 proc

	call GetTextColor
	mov bx, ax
	mov ax, 0

	Back:
				
		call SetTextColor	
					
		add al, 1
		mov dl, al
		mov al, Var1
		call WriteChar
		mov al, dl
		
		test al, 0fh
		JNZ Skip
		
		call Crlf
		test ax, 0ffh
		
		Skip:
			
			JNZ Back

	mov ax, bx
	call SetTextColor

	ret
main4 ENDP
end main4
