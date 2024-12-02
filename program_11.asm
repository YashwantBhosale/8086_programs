; write a program in assembly language of 8086 to add two 32-bit numbers. First number
; is stored from 0000:2000, second number is stored from location 0000:3000.
; store the result 0000:4000 onwards
    
MAIN:
    MOV AX, 0000H
    MOV DS, AX
    MOV ES, AX
    CLC
    MOV SI, 2000H
    MOV DI, 3000H
    MOV BX, 4000H
    
    MOV AX, [SI]
    ADD AX, [DI]
    MOV [BX], AX    
    
    MOV AX, [SI+02H]
    ADC AX, [DI+02H]
    MOV [BX+02], AX
	; routine to store carry (if asked)
    ; MOV CL, 00H
    ; ADC CL, 01H
    ; MOV [BX+04H], CL
    HLT
    
