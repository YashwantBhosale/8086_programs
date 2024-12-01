; Write a program in 8086 assembly language to configure Port A, B and C as output ports in simple 
; I/O mode. Generate flashing LEDs at Port C lines (with PCU and PCL turning on and off 
; alternately), running lights from right to left at Port B and running lights from left to right 
; at Port Fine tune the delay between flashing and running lights to  0.5 seconds

MAIN:
	MOV AL, 09H ; configure port A and B as output ports and port C as input port
	OUT 33H, AL

CHECK:
	IN AL, 32H ; read input at port C
	
	TEST AL, 80H ; check if MSB is set
	JNZ RIGHT_TO_LEFT

	TEST AL, 01H ; check if LSB is set
	JNZ LEFT_TO_RIGHT
	
	JMP BACK ; unconditionally keep checking

RIGHT_TO_LEFT:	
	MOV AL, 01H ; start from 1st LED	
DISPLAY_PORT_B:
	OUT 31H, AL ; display light on port B
	CALL DELAY  ; call delay routine for 0.5s delay
	SHL AL, 01H ; shift light to the left
	JNZ DISPLAY_PORT_B ; display light untill all the LEDs are lighted up one by one
	OUT 31H, AL ; clear all the lights in the end
	JMP CHECK ; jump back to keep checking

LEFT_TO_RIGHT:
	MOV AL, 08H ; start from rightmost bit
DISPLAY_PORT_A:
	OUT 30H, AL ; display light on port A
	CALL DELAY  ; call delay routine for 0.5s delay
	SHR AL, 01H ; shift light to the right
	JNZ DISPLAY_PORT_A ; display light untill all the LEDs are lighted up one by one
	OUT 30H, AL ; clear all the lights in the end
	JMP CHECK ; jump back to keep checking

; delay routine for 0.5s delay
DELAY:
	MOV CX, 0AH
OUTER_LOOP:
	MOV DX, CX
	MOV CX, 39DDH ; counter for inner loop
INNER_LOOP:
	LOOP INNER_LOOP
	MOV CX, DX
	LOOP OUTER_LOOP
	RET
