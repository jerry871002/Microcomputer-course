	ORG	0000H
	JMP	START
	ORG	0050H
START:
	
	;MOV R5, #40
	;CALL DELAY

	MOV	A, #00111000B  ;採用8位元資料存取/雙列字5*7點矩陣字型
	CALL COMMAND
	;MOV R5, #2
	;CALL DELAY

	MOV	A, #00001100B	;關掉游標
	CALL COMMAND
	;MOV R5, #2
	;CALL DELAY

	MOV	A, #00000110B
	CALL COMMAND

	MOV	A, #00000001B
	CALL COMMAND
	;MOV R5, #45	 
	;CALL DELAY

	MOV	A, #01000000B	;CG RAM
	CALL COMMAND
	;MOV R5, #5
	;CALL DELAY
SET_FONT:
	MOV	DPTR, #TABLE
	MOV R5, #2
	CALL DELAY
	MOV R0, #32
NEXT:
	CLR A
	MOVC A, @A+DPTR
	CALL WORD
	INC DPTR
	DJNZ R0, NEXT
	JMP LOOP
WORD:
	MOV P0, A
	MOV P1, #00000101B	;E=1, RW=0, RS=1
	MOV R5, #2
	CALL DELAY
	MOV P1, #00000000B	;E=0
	MOV R5, #2
	CALL DELAY
	RET

LOOP:
	MOV A, #10000000B
	CALL COMMAND
	MOV A, #0H
	CALL SENDDATA
	MOV R5, #5
	CALL DELAY

	MOV A, #10000000B
	CALL COMMAND
	MOV A, #1H
	CALL SENDDATA
	MOV R5, #5
	CALL DELAY

	MOV A, #10000000B
	CALL COMMAND
	MOV A, #2H
	CALL SENDDATA
	MOV R5, #5
	CALL DELAY

	MOV A, #10000000B
	CALL COMMAND
	MOV A, #3H
	CALL SENDDATA
	MOV R5, #5
	CALL DELAY
	JMP LOOP

COMMAND:
	MOV	P0, A
	MOV	P1, #00000100B  ;E=1 , RW=0 , RS=0
	MOV R5, #5
	CALL DELAY

	MOV	P1, #00000000B	;E=0 , RW=0 , RS=0
	MOV	R5, #5
	CALL DELAY			;延遲等訊號處裡完畢
	RET
SENDDATA:
	MOV	P0, A
	MOV	P1, #00000101B	;E=1, RW=0, RS=1
	MOV R5, #2
	CALL DELAY
	MOV	P1, #00000001B	;E=0
	MOV	R5, #2
	CALL	DELAY
	RET
DELAY:
	MOV	R6, #240
DELAY1:
	MOV	R7, #255
DELAY2:
	DJNZ R7,DELAY2
	DJNZ R6,DELAY1
	DJNZ R5,DELAY
	RET
TABLE:
	DB 01110B
	DB 10001B
	DB 10011B
	DB 10101B
	DB 11001B
	DB 10001B
	DB 01110B
	DB 00000B

	DB 01110B
	DB 10001B
	DB 10001B
	DB 11111B
	DB 10001B
	DB 10001B
	DB 01110B
	DB 00000B

	DB 01110B
	DB 10001B
	DB 11001B
	DB 10101B
	DB 10011B
	DB 10001B
	DB 01110B
	DB 00000B

	DB 01110B
	DB 10001B
	DB 10101B
	DB 10101B
	DB 10101B
	DB 10001B
	DB 01110B
	DB 00000B
END
