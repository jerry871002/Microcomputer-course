	ORG 0000H
	AJMP MAIN
	ORG 0050H
MAIN :
	MOV R1,#7FH
	MOV R2,#0FEH
LOOP :
	MOV A,R1
	ANL A,R2
	MOV P1,A

	MOV A,R1
	RR A
	MOV R1,A

	MOV A,R2
	RL A
	MOV R2,	A
	
	ACALL DELAY
	JMP LOOP
DELAY:
	MOV R5,#0FFH
DELAY1:
	MOV R6,#0FFH 
DELAY2:
	MOV R7,#05H 
DELAY3:
	DJNZ R7,DELAY3 
	DJNZ R6,DELAY2 
	DJNZ R5,DELAY1 
	RET