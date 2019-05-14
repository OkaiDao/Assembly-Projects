TITLE Chapter 10            (Drunk_Walk.asm)
;Program: Emulates a person walking in a random direction.
;Student:	Jonathan Dao
;Date:	11/15/18
;Class:	CSCI 241
;Instructor: Mr. Ding

INCLUDE Irvine32.inc

WalkMax = 30

DrunkWalk STRUCT
	path COORD WalkMax DUP(<0,0>)
	pathsUsed Word 0
DrunkWalk ENDS

StartX = 39
StartY = 10

DisplayPosition PROTO currx: WORD, curryY:WORD

mWriteStr Macro text
	LOCAL string
	
	.data
	string BYTE text, 0

	.code
	push edx
	mov edx, OFFSET string
	call WriteString
	pop edx

ENDM

.data

aWalk DrunkWalk <>
msgPrompt Byte "How many number of steps will the Drunkard take? Enter Number: ", 0

.code

mainDrunk PROC
	
	mov edx, OFFSET msgPrompt
	call WriteString
	call ReadDec
	mov aWalk.pathsUsed, ax	;moves number of steps into pathUsed

	mov esi, OFFSET aWalk
	call TakeDrunkenWalk
	call crlf
	exit

mainDrunk ENDP
;-------------------------------------------------------
TakeDrunkenWalk PROC uses ebx ecx edx
;
; Take a walk in random directions (north, south, east,
; west).
; Receives: ESI points to a DrunkardWalk structure
; Returns:  the structure is initialized with random values
;-------------------------------------------------------
	pushad

; Use the OFFSET operator to obtain the address of
; path, the array of COORD objects, and copy it to EDI.
	mov	edi,esi
	add	edi,OFFSET DrunkWalk.path
	mov ecx, 0 ;clear ecx
	mov	cx, (DrunkWalk PTR [edi]).pathsUsed			; loop counter
	mov ebx, StartX
	mov edx, StartY
		
Again:
	; Insert current location in array.
	mov	ax, bx
	mov	(COORD PTR [edi]).X,ax
	mov	ax, dx
	mov	(COORD PTR [edi]).Y,ax

	INVOKE DisplayPosition, bx, dx

		Gen:

		mov	  eax,4			; choose a direction (0-3)
		call  RandomRange

		.IF eax == 0		; North
		  dec edx
		.ELSEIF eax == 1	; South
		  inc edx
		.ELSEIF eax == 2	; West
		  dec ebx
		.ELSE			; East (EAX = 3)
		  inc ebx
		.ENDIF

		cmp dx, StartY
		JNE NotEqual
		cmp bx, StartX; Compare the generated (X, Y) to the origin (39, 10)
		JNE NotEqual	; if not equal
		
		; From the previous (X, Y) ; Go back to Gen to re-generate a valid (X, Y)

		mov bx, (COORD PTR [edi]).X 
		mov dx, (COORD PTR [edi]).Y
	
		JMP Gen						

		NotEqual:

			add	edi,TYPE COORD		; point to next COORD
			loop	Again
		
		

Finish:
	mov (DrunkWalk PTR [esi]).pathsUsed, WalkMax
	popad
	ret

TakeDrunkenWalk ENDP

;-------------------------------------------------------
DisplayPosition PROC currX:WORD, currY:WORD
; Display the current X and Y positions.
;-------------------------------------------------------
	pushad
	
	mWriteStr "("
	movzx eax,currX			; current X position
	call	 WriteDec
	mWriteStr ","
	movzx eax,currY			; current Y position
	call	 WriteDec
	mWriteStr ") "	
	
	popad
	ret

DisplayPosition ENDP


end mainDrunk
