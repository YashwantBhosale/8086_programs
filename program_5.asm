; write program to demonstrate 8255 mode 1 output mode, verify it's operation under the control of
; of relevant handshake signals.

	MOV AL, 84H ; configure port B in mode 1 output mode
	OUT 33H, AL

	MOV AL, 05H ; set INTEB for port B using BSR mode
	OUT 33H, AL

	MOV AL, 0FH ; get some sample data in AL register

	OUT 31H, AL ; output the desired result on port B

	; flow for working of 8255 in mode 1 output mode
	; 1. 8086 puts data on ouput buffer of port B
	; 2. OBFB goes low showing that output buffer is full and I/O device should read data
	; 3. I/O device reads data from the buffer 
	; 4. I/O device drives ACK low showing that it has successfully read data
	; 5. OBFB goes high showing O/P buffer is full
	; 6. OBFB = 1 AND INTEB = 1 => INTRB = 1, microprocessor is interrupted
	; 7. microprocessor loads new data in ISS
	; go back to step 1
