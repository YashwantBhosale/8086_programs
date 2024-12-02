; write a program in assembly language of 8086 to find number of positive elements in a block
; of memory. starting address of source block is 0000:2000. assume length of the block is
; stored in 0000:3000
LOAD_DATA:
    MOV AX, 0000H
    MOV DS, AX
    
    MOV BX, 3000H
    MOV WORD PTR [BX], 000AH
    
    MOV SI, 2000H           
    MOV BYTE PTR [SI], -5
    MOV BYTE PTR [SI+1], 12
    MOV BYTE PTR [SI+2], -3
    MOV BYTE PTR [SI+3], 45
    MOV BYTE PTR [SI+4], -1
    MOV BYTE PTR [SI+5], 0
    MOV BYTE PTR [SI+6], -128
    MOV BYTE PTR [SI+7], 7
    MOV BYTE PTR [SI+8], -50
    MOV BYTE PTR [SI+9], 32


MAIN: 
    MOV AX, 0000H
    MOV DS, AX
    MOV BX, 3000H
    MOV CX, [BX]
    MOV DX, 00H ; counter for positive numbers
    MOV SI, 2000H
    
LOOP:
    MOV AL, [SI]
    ROL AL, 1
    JC NEXT
    INC DX
NEXT:
    INC SI
    DEC CX
    JNZ LOOP
    HLT
    
    
    
