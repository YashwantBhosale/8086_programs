; change the case of string alphabets

.MODEL SMALL
.DATA

STR DB 'CoEpCsE$'

.CODE

MOV AX, @DATA
MOV DS, AX
MOV ES, AX

LEA SI, STR

NEXT:CMP [SI], '$'
     JE STOP
     CMP [SI], 'a'
     JA SML
     JB BIG
     

SML: SUB [SI], 20H
     INC SI
     
     JMP NEXT 

BIG: ADD [SI], 20H
     INC SI
      
     JMP NEXT
     
STOP: MOV [SI], '$' 
      ; DISPLAY THE STRING 
      LEA DX, STR
      MOV AH, 09H 
      INT 21H
      HLT