	ORG 0000H
	JMP START
	ORG 0050H
START:
	MOV R0, #0
	MOV R1, #0
	MOV 30H, #00010001B
ROW1:
	MOV P1, #07FH
	CALL DELAY
	MOV A, P1
	ANL A, #0FH
	MOV R1, #1
	CJNE A, #0FH, COL1
ROW2:
	MOV P1, #0BFH
	CALL DELAY
	MOV A, P1
	ANL A, #0FH
	MOV R1, #5
	CJNE A, #0FH, COL1
	JMP ROW1  
COL1:
	CJNE A, #0EH, COL2
	MOV R0, #0
	JMP SHOW
COL2:
	CJNE A, #0DH, COL3
	MOV R0, #1
	JMP SHOW
COL3:
	CJNE A, #0BH, COL4
	MOV R0, #2
	JMP SHOW
COL4:
	CJNE A, #07H, ROW1
	MOV R0, #3	  
SHOW:
	MOV R2, #0
	MOV A, R0
	ADD A, R1
	MOV R3, A
	ADD A, #251	
	JC SETLEFT	   	
RIGHT:
	MOV P0, 30H
	CALL DELAY
	MOV A, 30H
	RR A
	MOV 30H, A
	INC R2
	CJNE R2, #128, RIGHT
	MOV R2, #0
	DJNZ R3, RIGHT
	MOV R0, #0
	MOV R2, #0
	MOV R1, #0
	MOV R3, #0
	AJMP ROW1

SETLEFT:
	CLR C
	MOV A, R0
	ADD A, R1
	SUBB A, #4
	MOV R3, A
LEFT:
	MOV P0, 30H
	CALL DELAY
	MOV A, 30H
	RL A
	MOV 30H, A
	INC R2
	CJNE R2, #128, LEFT
	MOV R2, #0
	DJNZ R3, LEFT
	MOV R0, #0
	MOV R2, #0
	MOV R1, #0
	MOV R3, #0
	AJMP ROW1

DELAY:
	MOV R5,#190
DELAY1:
	MOV R6,#200
DELAY2:
	DJNZ R6,DELAY2
	DJNZ R5,DELAY1
	RET
	END

