TITLE Chapter 4, zd supplied (Fibonacci.asm)
;Program: Ch 4, Loops
;Description: Creates a loop to repeat a formula to output a fibonacci sequence.
;Student:	Jonathan Dao
;Date:	9/18/18
;Class:	CSCI 241
;Instructor:	Mr. Ding

INCLUDE Irvine32.inc

Fib1 = 1
Fib2 = 1
.data

FibArry BYTE 12 DUP(?)
FDisp BYTE "First 12 Fibonacci numbers: ", 0Dh, 0Ah, 0

.code
main1 proc

	mov bl, Fib1
	mov dl, Fib2

	mov esi, 0
	mov [FibArry+esi], bl
	inc esi
	mov [FibArry+esi], dl
	

	mov al, 0
	mov ecx, 10

	Loop1:
	
		mov al, bl
		add al, dl
		mov bl, dl
		mov dl, al
		
		inc esi
		mov [FibArry+esi], al
			
		;call DumpRegs

	loop Loop1

	mov edx, 0
	mov edx, OFFSET FDisp
	call WriteString

	mov esi, OFFSET FibArry
	mov ecx, LENGTHOF FibArry
	mov ebx, TYPE FibArry
	call DumpMem
	

exit
main1 endp
end ;main1