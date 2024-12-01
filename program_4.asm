; write program in 8086 assembly language to configure Port A of 8255 as input port in mode 1. 
; Verify operation of this mode by writing a program to send input byte to port A under the 
; control of handshake signals.

	MOV AL, B0H ; control word to configure port A as mode 1 i/p and write it to control registers
	OUT 33H, AL 

	MOV AL, 09H ; control word to set INTEA using BSR mode
	OUT 33H, AL
	
BACK:
	IN AL, 30H ; take input from port A
	JMP BACK ; jump back and keep taking input

	; flow for handshake signals
	; 1. I/O device sends data on port A of 8255
	; 2. STB is driven low to indicate that there is valid data on data bus
	; 3. data gets latched on the i/p buffer of port A
	; 4. IBFA is driven high so that device doesn't send more data
	; 5. I/O device drives STB high as an acknowledgement
	; 6. now, INTEA = 1 AND IBFA = 1 => INTRA = 1 microprocessor is interrupted
	; 7. microprocessor reads data from port A in ISS
	; 8. IBFA goes low requesting new data from the device
	; go back to step 1
	
