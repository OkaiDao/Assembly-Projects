TITLE Chapter 8            (NonRecFac.asm)
;Program: Replaces characters in an inputed string with characters that are also inputed.
;Student:	Jonathan Dao
;Date:	11/1/18
;Class:	CSCI 241
;Instructor:	Mr. Ding

INCLUDE Irvine32.inc

;------------------------------------------------------------------
StrReplace PROTO, source:PTR BYTE, oldch: BYTE, newch: BYTE
;
; Replace old char with new char in the source string
; Receives: source, a text message string address
;           oldch, a char in the string to be replaced
;           newch, a new char to replace the old one
; Returns:  EAX, the number of characters to be replaced
;------------------------------------------------------------------

;------------------------------------------------------------------
GetCharInput PROTO, prompt:PTR BYTE
;
; Get a char and check if the Enter key
; Receives: prompt, A prompt string offset asking user to enter key
; Returns:  AL, the char the user entered
;           CF=1 if the char is Enter key, else CF=0
;------------------------------------------------------------------


.data
msgPrompt1 BYTE "This program takes an inputed string and changes a chosen character based on user input.", 0dh, 0ah, 0
msgPrompt2 BYTE "Enter a string: ", 0
msgChar BYTE "Enter a character to change (Enter to quit): ", 0
msgNewChar BYTE "Enter new character (Enter to quit): ", 0
msgReplaced BYTE "Number of characters replaced: ", 0
MaxStr = 255
EnteredStr BYTE MaxStr+1 DUP (?)

.code
mainChar_Rep PROC


	mov edx, OFFSET msgPrompt1
	call WriteString
	call Crlf
	call Crlf
	mov edx, OFFSET msgPrompt2
	call WriteString
	mov edx, OFFSET EnteredStr
	mov ecx, MaxStr
	call ReadString

	ProStart:

		INVOKE GetCharInput, ADDR msgChar
		JC ProExit
		mov dl, al
		call Crlf

		INVOKE GetCharInput, ADDR msgNewChar
		JC ProExit

		call Crlf
	
		INVOKE StrReplace, ADDR EnteredStr, dl, al

		mov edx, OFFSET msgReplaced
		call WriteString
		call WriteDec
		call Crlf
		mov edx, OFFSET EnteredStr
		call WriteString
		call Crlf

		jmp ProStart

	ProExit:

		call Crlf
		ret
mainChar_Rep ENDP


StrReplace PROC USES ebx ecx edx, source:PTR BYTE, oldch: BYTE, newch: BYTE
;
; Replace old char with new char in the source string
; Receives: source, a text message string address
;           oldch, a char in the string to be replaced
;           newch, a new char to replace the old one
; Returns:  EAX, the number of characters to be replaced
;------------------------------------------------------------------

	mov esi, source
	mov edx, source
	call StrLength

	mov ecx, eax	;mov str length to ecx
	
	mov bl, oldch
	mov dl, newch

	mov eax, 0
	
	StringLoop:

	cmp bl, [esi]

	JNE Onward
	mov [esi], dl
	add eax, 1

	Onward:
		
		add esi, 1
			
	loop StringLoop

	ret
StrReplace ENDP

;------------------------------------------------------------------
GetCharInput PROC USES edx, prompt:PTR BYTE
;
; Get a char and check if the Enter key
; Receives: prompt, A prompt string offset asking user to enter key
; Returns:  AL, the char the user entered
;           CF=1 if the char is Enter key, else CF=0
;------------------------------------------------------------------

	mov edx, prompt
	call WriteString
	call ReadChar
	call WriteChar
	cmp al, 0dh
	jnz Continue

	STC
	jmp Done

	Continue:
	
		call Crlf
	
	Done:

	ret
GetCharInput ENDP

end mainChar_Rep