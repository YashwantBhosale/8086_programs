; Write a program in 8086 assembly language to demonstrate encoded mode seven segment display
; interface mode for 8279. Display digits 0 onwards in a right entry mode.

; 3000:0001 - 0A	3000:0009 - 0A
; 3000:0002 - B6	3000:000A - B6
; 3000:0003 - F4	3000:000B - F4
; 3000:0004 - 6C	3000:000C - 6C
; 3000:0005 - DC	3000:000D - DC
; 3000:0006 - DE	3000:000E - DE
; 3000:0007 - 70	3000:000F - 70
; 3000:0008 - FE	3000:0010 - FE

	MOV AL, 18H ; command word to set 16 8-bit right entry mode
	OUT 32H, AL

	MOV AL, 3FH ; program clock
	OUT 32H, AL

	MOV AL, 90H ; set 8279 for successive writes in FIFO ram
	OUT 32H, AL

	MOV CX, 0FH ; 16 numbers in lookup table
	MOV BX, 0001H ; pointer to 1st location of lookup table
	
LOOP:
	MOV AL, [BX] ; get the character to be displayed in AL
	OUT 31H, AL ; write to the data port to display the character

	CALL DELAY ; call delay routine to show effect of displaying character one by one
	
	INC BX ; increment lookup pointer

	DEC CX ; decrement counter

	JNZ LOOP ; loop until all characters are displayed
