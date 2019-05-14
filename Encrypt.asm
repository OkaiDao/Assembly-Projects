TITLE Chapter 6, zd supplied (Encrypt.asm)
;Program: Encrypts a string.
;Description: Encrypts a string the user inputs.
;Student:	Jonathan Dao
;Date:	10/04/18
;Class:	CSCI 241
;Instructor:	Mr. Ding

INCLUDE Irvine32.inc

BUFMAX = 100
 
.data
prompt1  BYTE  "Enter the plain text: ",0
prompt2  BYTE  "Enter the encryption key: ",0
sEncrypt BYTE  "Cipher text:         ",0
sDecrypt BYTE  "Decrypted:           ",0

keyStr   BYTE   BUFMAX+1 DUP(0aah)
keySize  DWORD  44444444h
buffer   BYTE   BUFMAX+1 DUP(0ffh)
bufSize  DWORD  33333333h

.code
main11 PROC

      mov edx,OFFSET prompt1  ; display buffer prompt
      mov ebx,OFFSET buffer   ; point to the buffer
      call InputTheString
      mov bufSize, edx         ; save the buffer length
	  
      mov edx,OFFSET prompt2  ; display key prompt
      mov ebx,OFFSET keyStr   ; point to the key
      call InputTheString
      mov keySize, edx         ; save the key length
	  
	  
	  mov edx, OFFSET KeyStr	; Prepair registers
	  mov eax, OFFSET buffer
	  mov ebx, bufSize
	
	 call TranslateBuffer	;Encrypt
	 mov edx, OFFSET sEncrypt ;Set encrpy show prompt
	 call WriteString

	 mov ebx, OFFSET buffer ;Prepair Register
	 call DisplayMessage	;Display encription
	
	  mov edx, OFFSET KeyStr	; Prepair registers
	  mov eax, OFFSET buffer
	  mov ebx, bufSize
	
	 call TranslateBuffer	;Decript
	  mov edx, OFFSET sDecrypt ;Display decrypted message
	  call WriteString
	  mov ebx, OFFSET buffer ;Prepair Register
	  call DisplayMessage

	  ret
main11 ENDP

;-----------------------------------------------------
InputTheString PROC
;
; Prompts user for a plaintext string. Saves the string 
; and its length.
; Receives: ebx(string source)
; Returns: edx buff size
;-----------------------------------------------------
	

	call	WriteString
	mov	ecx, BUFMAX		; maximum character count1
	mov	edx, ebx   ; point to the buffer
		call	ReadString         	; input the string
	mov edx, eax
	call	Crlf

	ret
InputTheString ENDP

;-----------------------------------------------------
DisplayMessage PROC
;
; Displays the encrypted or decrypted message.
; Receives: EBX
; Returns:  nothing
;-----------------------------------------------------
	pushad
	mov	edx, ebx	; display the buffer
	call	WriteString
	call	Crlf
	call	Crlf
	popad
	ret
DisplayMessage ENDP

;-----------------------------------------------------
TranslateBuffer PROC ;USES eax ebx ecx edx
;
; Translates the string by exclusive-ORing each
; byte with the encryption key byte.
; Receives: eax (OFFSET buffer), ebx (bufSize), ecx (keySize), edx (OFFSET keyStr) 
; Returns: nothing
;-----------------------------------------------------


	mov esi, 0
	mov edi, 0
	mov ecx, 0

Start:
	mov cl, [edx + edi] 
	
	
	xor [eax + esi], cl   ; translate a byte

	add	esi, 1				; point to next byte
	add edi, 1				; point to next key

	mov cl, [edx + edi] 
	
	;cmp ecx, edi		;Check if last key
	;jne Continue
	cmp cl, 00h
	jne Continue
	;sub edx, edi
	mov edi, 0			;If last key go back to first.

Continue:
	
	cmp ebx, esi
	jne Start


	ret
TranslateBuffer ENDP

end main11

