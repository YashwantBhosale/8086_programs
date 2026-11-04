; matrix addition and subtraction

.MODEL SMALL
.STACK 100
.DATA   

ARR1 DB 01H, 02H, 03H, 04H
ARR2 DB 01H, 02H, 03H, 04H
ROWS DB 2
COL DB 2
SIZE DB 4
ARR3 DB 4 DUP(0)

.CODE

MOV AX, @DATA
MOV DS, AX

LEA SI, ARR1
LEA BX, ARR2
LEA DI, ARR3   

MOV CL, SIZE

ADDN: MOV AL, [SI]
      ADD AL, [BX]
      MOV [DI], AL
      
      INC SI
      INC BX
      INC DI
      LOOP ADDN

LEA SI, ARR1
LEA BX, ARR2
LEA DI, ARR3   

MOV CL, SIZE

SUBT: MOV AL, [SI]
      SUB AL,[BX]
      MOV [DI], AL
      
      INC SI
      INC DI
      INC BX
      LOOP SUBT 
      HLT