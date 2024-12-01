; Write a program in 8086 assembly language to demonstrate sensor matrix mode in 8279
MOV AL, 04H ;encoded scan sensor matrix mode
OUT 31H, AL

MOV AL, 3FH ; program clock command word
OUT 31H, AL

BACK:
	MOV AL, 41H ; first row of sensory matrix to be read
	OUT 31H, AL                                         

	IN, AL, 30H ; read data port

	MOV BX, 02H ; 2 digits in data fields

	CALL FAR F000:0D5EH ; in built function to display contents of AL

	JMP BACK
HLT
