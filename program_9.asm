; write ISS to display OVERFLOW ERROR

MAIN: 
	STI
	MOV AL, 0FFH ; get first operand
	MUL AL 
	INTO ; triggers overflow interrupt if OF flag is set
	HLT

ISS:
	MOV AL, 00H ; write mode
	MOV BH, 00H ; page number
	MOV BL, 0011_1011b ; attribute if string only contains only characters
	MOV CX, MSG_END - OFFSET MSG ; string size
	PUSH CS
	POP ES
	MOV BP, OFFSET MSG
	MOV AH, 013H
	INT 10H
	JMP MSG_END

	MSG DB "OVERFLOW ERROR"
MSG_END:
	IRET
