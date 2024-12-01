; write a program in 8086 assembly language to demonstrate encoded Scan key matrix mode of 8279
; only command word will change for N key roll over rest of the program will stay same
	MOV AL, 01H ; encoded scan 2 key lockout
	OUT 31H, AL

	MOV AL, 3FH ; program clock
	OUT 31H, AL
	
	MOV AL, 50H ; command word for reading FIFO
	OUT 31H, AL

READ:
	IN AL, 31H ; read FIFO status

	AND AL, 07H ; check last 3 bits (they indicate number of keys pressed)
	
	JZ READ ; keep checking untill a keypress occurs

	; following code will execute when keypress will occur
	IN AL, 30H ; read data from FIFO ram
	
	MOV BX, 02H
	CALL FAR F000:0D5EH ; in built function to display contents of AL

	JMP READ ; jump back to READ routine
