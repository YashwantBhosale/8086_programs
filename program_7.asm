; write ISS for divide by zero interrupt to display 'DIVIDE BY ZERO ERROR'
ORG 100H

MAIN:
   CLI
   MOV AX, 00H
   MOV DS, AX
   MOV [0000H], ISS ; store ip in IVT
   MOV [0002H], CS ; store cs in IVT
   STI
   MOV BL, 00H
   MOV AL, 05H
   DIV BL
   HLT

ISS:
   MOV AL, 00H ; write mode
   MOV BH, 00H ; page number
   MOV BL, 0011_1011b ; attribute if string contains only characters
   MOV CX, MSG_END - OFFSET MSG ; string size
   PUSH CS 
   POP ES
   MOV BP, OFFSET MSG
   MOV AH, 013H
   INT 10H
   JMP MSG_END
   
   MSG DB "DIVIDE BY ZERO ERROR"
MSG_END:
    IRET
