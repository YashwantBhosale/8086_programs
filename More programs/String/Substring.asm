; find a substring in a given string

.MODEL SMALL
.DATA

S DB 'COEPCSE$'
CP DB 'CS$'   
FOUND DB "SUBSTR FOUND IN STR$" 
NOTFOUND DB "SUBSTR NOT FOUND IN STR$" 

.CODE

MOV AX, @DATA
MOV DS, AX
MOV ES, AX
     
LEA SI, S
LEA DI, CP

CLD

NEXT: MOV AL, [SI]
      CMP AL, [DI]
      JNZ MOVNXT ; NO MATCH IN S
      
      MOV DX, SI ; ST POS OF S
      MOV BX, DI
CHECK:
      MOV AL, [SI]
      MOV BL, [DI]
      CMP BL, '$'
      JE FD
      CMP AL, BL
      JNZ NOTF
      INC SI ;FIRST MATCH
      INC DI
      JMP CHECK ;CHECK AGN
      
NOTF:  MOV SI, DX
       INC SI
       LEA DI, CP
       JMP NEXT 
                     ; STOSD: [DI] <- AL
                     ; LODSB: AL <- [SI]
MOVNXT:INC SI
      CMP [SI], '$'
      JE NOTFD
      JMP NEXT     
      
FD: 
 ;PRINT FOUND MESSAGE
 LEA DX, FOUND
 MOV AH, 09H
 INT 21H 
 JMP STOP

NOTFD: 
;PRINT NOT FOUND MESSAGE
 LEA DX, NOTFOUND
 MOV AH, 09H
 INT 21H
 
STOP: HLT 
