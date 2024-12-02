; Write a Interrupt Service Subroutine (ISS) for INT3 to increment CX by two and display contents of 
; AX register on screen using INT 10 function call 0A of BIOS interrupt
org 100h;

MAIN:
	CLI
	MOV AX, 0000H
	MOV DS, AX
	; following 2 steps can be (and should be preferably) done manually by editing memory
	; but i am doing using code for the sake of simplicity :)
	MOV [000CH], ISS ; store IP in IVT
	MOV [000EH], CS ; store CS in IVT
	MOV CX, 02H ; test data in CX
	MOV AX, 1234H ; content in AX to display
	STI ; enable interrupts
	INT 3 ; call interrupt
	HLT

ISS:
	ADD CX, 02H ; increment contents of CX by 2
	MOV DX, AX ; move content to be displayed tempororily to DX
	MOV BX, CX ; backup contents of CX
	MOV CX, 01H	
	MOV AH, 0AH ; bios output function
	MOV AL, 'A'
	INT 10H ; display character
	MOV CX, 01H
	MOV AL, 'X'
	INT 10H
	MOV CX, 01H 
	MOV AL, '='
	INT 10H
	; main code to display the content
	MOV CH, 04H ; counter for 4 bits
	MOV CL, 0CH ; counter for shifting bits
BACK:
	MOV AX, DX ; get original content of AX
	SHR AX, CL ; get digit to be displayed to LSB
	AND AL, 0FH ; mask irrelevant bits 
	CMP AL, 09H ; check if digit is below 9
	JBE DISPLAY_CHAR ; if yes then display character
	ADD AL, 07H ; add 07 to adjust above 9 hex digits like A, B, ...
DISPLAY_CHAR:
	ADD AL, '0' ; convert digit to ascii
	MOV AH, 0AH ; bios output function
	MOV SI, CX
	MOV CX, 01H
	INT 10H ; display character
	MOV CX, SI
	SUB CL, 04H ; adjust number of bits to be shifted
	DEC CH
	JNZ BACK
	MOV CX, BX ; restore contents of CX
	IRET

