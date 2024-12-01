; write a prgram in assembly language to transfer a block of memory. Starting address of source
; block is 0000:2000. Starting address of destination block is 0000:3000. Assume length of the 
; block is stored in CX register

MAIN: 
	MOV AX, 0000H
	MOV DS, AX ; load DS (default segment for SI)
	MOV ES, AX ; load ES (default segment for DI)
	MOV SI, 2000H ; load source block pointer
	MOV DI, 3000H ; load destination block pointer
	; MOV CX, 0FH ; CX register for block length (already loaded as per question)
BACK:
	MOV AX, [SI]
	MOV [DI], AX

	; here we transfer two bytes as src/dest is a 16-bit register
	; so we need to move memory pointers by 2 
	INC SI
	INC SI

	INC DI
	INC DI
	; assuming block length is in bytes as we are transferring two bytes at a time we need to 
	; decrement counter by 2
	DEC CX
	DEX CX
	JNZ BACK
	HLT
	
