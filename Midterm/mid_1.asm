	ORG 0000H
	AJMP MAIN
	ORG 0050H
MAIN:
	MOV R0, #0AH	;個，#0AH為不顯示
	MOV R1, #0AH 	;十
	MOV R2, #0AH 	;百
	MOV R3, #0AH 	;千
LOOP:
	ACALL SHOW
	AJMP SCAN
	ACALL SHOW
	ACALL DELAY
FUNCTION:
	CJNE R6, #0AH, ISNEWNUM
ISNEWNUM:
	JC NEWNUM
	CJNE R6, #0AH, NOTBACK
	ACALL SHOW
	ACALL BACK
	ACALL SHOW
	AJMP LOOP
NOTBACK:
	CJNE R6, #0BH, NOTRESET
	ACALL SHOW
	ACALL RESET
	ACALL SHOW
	AJMP LOOP
NOTRESET:
	CJNE R6, #0CH, NOTENTER
	ACALL SHOW
	ACALL ENTER
	ACALL SHOW
	AJMP LOOP
NOTENTER:
	AJMP LOOP

;====================
NEWNUM:
	ACALL SHOW

	MOV A, R2 	;左移一位
	MOV R3, A
	MOV A, R1
	MOV R2, A
	MOV A, R0
	MOV R1, A

	MOV A, R6	;增加新位數
	MOV R0, A

	ACALL SHOW
	ACALL SHOW
	ACALL SHOW
	AJMP LOOP
;====================

SHOW:
;First digjt
	MOV DPTR, #POS		;選位數
	MOV A, #0H
	MOVC A, @A+DPTR
	MOV P2, A

	MOV DPTR, #NUMTABLE	;選數字
	MOV A, R0
	MOVC A, @A+DPTR
	MOV P1, A

	ACALL SHOWDELAY
	MOV P1, #0FFH
;Second digit
	MOV DPTR, #POS		;選位數
	MOV A, #1H
	MOVC A, @A+DPTR
	MOV P2, A

	MOV DPTR, #NUMTABLE	;選數字
	MOV A, R1
	MOVC A, @A+DPTR
	MOV P1, A

	ACALL SHOWDELAY
	MOV P1, #0FFH	
;Third digit
	MOV DPTR, #POS		;選位數
	MOV A, #2H
	MOVC A, @A+DPTR
	MOV P2, A

	MOV DPTR, #NUMTABLE	;選數字
	MOV A, R2
	MOVC A, @A+DPTR
	MOV P1, A

	ACALL SHOWDELAY
	MOV P1, #0FFH
;Forth digit
	MOV DPTR, #POS		;選位數
	MOV A, #3H
	MOVC A, @A+DPTR
	MOV P2, A

	MOV DPTR, #NUMTABLE	;選數字
	MOV A, R3
	MOVC A, @A+DPTR
	MOV P1, A

	ACALL SHOWDELAY
	MOV P1, #0FFH

	RET

SHOWONESECOND:
	MOV R4, #0H
	MOV R5, #0H
SHOWLOOP:

	SETB P3.7
	CLR P2.7
	CLR P2.6
	CLR P2.5
	CLR P2.4	

	CJNE R7, #0, NOT11
	MOV DPTR, #WALKINGMAN1
	AJMP SHOWMAN1
NOT11:
	CJNE R7, #1, NOT21
	MOV DPTR, #WALKINGMAN2
	AJMP SHOWMAN1
NOT12:
	CJNE R7, #2, SHOWMAN1
	MOV DPTR, #WALKINGMAN3
SHOWMAN1:
	MOV A, #0
	MOVC A, @A+DPTR
	MOV P3, A
	SETB P3.7

;First digjt
	MOV DPTR, #POS		;選位數
	MOV A, #0H
	MOVC A, @A+DPTR
	MOV P2, A

	MOV DPTR, #NUMTABLE	;選數字
	MOV A, R0
	MOVC A, @A+DPTR
	MOV P1, A

	;ACALL SHOWDELAY

	CLR P3.7
	SETB P2.7
	CLR P2.6
	CLR P2.5
	CLR P2.4	

	CJNE R7, #0, NOT21
	MOV DPTR, #WALKINGMAN1
	AJMP SHOWMAN2
NOT21:
	CJNE R7, #1, NOT22
	MOV DPTR, #WALKINGMAN2
	AJMP SHOWMAN2
NOT22:
	CJNE R7, #2, SHOWMAN2
	MOV DPTR, #WALKINGMAN3
SHOWMAN2:
	MOV A, #1
	MOVC A, @A+DPTR
	MOV P3, A

	MOV P1, #0FFH
;Second digit
	MOV DPTR, #POS		;選位數
	MOV A, #1H
	MOVC A, @A+DPTR
	MOV P2, A

	MOV DPTR, #NUMTABLE	;選數字
	MOV A, R1
	MOVC A, @A+DPTR
	MOV P1, A

	;ACALL SHOWDELAY

	CLR P3.7
	CLR P2.7
	SETB P2.6
	CLR P2.5
	CLR P2.4	

	CJNE R7, #0, NOT31
	MOV DPTR, #WALKINGMAN1
	AJMP SHOWMAN3
NOT31:
	CJNE R7, #1, NOT32
	MOV DPTR, #WALKINGMAN2
	AJMP SHOWMAN3
NOT32:
	CJNE R7, #2, SHOWMAN3
	MOV DPTR, #WALKINGMAN3
SHOWMAN3:
	MOV A, #2
	MOVC A, @A+DPTR
	MOV P3, A

	MOV P1, #0FFH	
;Third digit
	MOV DPTR, #POS		;選位數
	MOV A, #2H
	MOVC A, @A+DPTR
	MOV P2, A

	MOV DPTR, #NUMTABLE	;選數字
	MOV A, R2
	MOVC A, @A+DPTR
	MOV P1, A

	;ACALL SHOWDELAY

	CLR P3.7
	CLR P2.7
	CLR P2.6
	SETB P2.5
	CLR P2.4	

	CJNE R7, #0, NOT41
	MOV DPTR, #WALKINGMAN1
	AJMP SHOWMAN4
NOT41:
	CJNE R7, #1, NOT42
	MOV DPTR, #WALKINGMAN2
	AJMP SHOWMAN4
NOT42:
	CJNE R7, #2, SHOWMAN4
	MOV DPTR, #WALKINGMAN3
SHOWMAN4:
	MOV A, #3
	MOVC A, @A+DPTR
	MOV P3, A

	MOV P1, #0FFH
;Forth digit
	MOV DPTR, #POS		;選位數
	MOV A, #3H
	MOVC A, @A+DPTR
	MOV P2, A

	MOV DPTR, #NUMTABLE	;選數字
	MOV A, R3
	MOVC A, @A+DPTR
	MOV P1, A

	;ACALL SHOWDELAY

	CLR P3.7
	CLR P2.7
	CLR P2.6
	CLR P2.5
	SETB P2.4	

	CJNE R7, #0, NOT51
	MOV DPTR, #WALKINGMAN1
	AJMP SHOWMAN5
NOT51:
	CJNE R7, #1, NOT52
	MOV DPTR, #WALKINGMAN2
	AJMP SHOWMAN5
NOT52:
	CJNE R7, #2, SHOWMAN5
	MOV DPTR, #WALKINGMAN3
SHOWMAN5:
	MOV A, #4
	MOVC A, @A+DPTR
	MOV P3, A

	MOV P1, #0FFH

	INC R4
	CJNE R4, #018H, SHOWLOOP
	MOV R4, #0
	INC R5
	CJNE R5, #03H, SHOWLOOP

	RET

SCAN:
ROW1:
	MOV P0, #7FH 		;掃描第一個row(s01~s04)
	CALL SHOW
	MOV A, P0
	ANL A, #0FH 		;將較高的4-bit清為0
	MOV R4, #0
	CJNE A, #0FH, COL1	;確認s01~s04是否有被按下
						;有則至掃描col的地方
ROW2:					;沒有則往下掃第二個row(s05~s08)
	MOV P0, #0BFH 		;掃描第二個row(s05~s08)
	CALL SHOW
	MOV A, P0
	ANL A, #0FH 		;將較高的4-bit清為0
	MOV R4, #4
	CJNE A, #0FH, COL1	;確認s05~s08是否有被按下
						;有則至掃描col的地方
ROW3:					;沒有則往下掃第三個row(s09~s12)
	MOV P0, #0DFH 		;掃描第三個row(s09~s12)
	CALL SHOW
	MOV A, P0
	ANL A, #0FH 		;將較高的4-bit清為0
	MOV R4, #8
	CJNE A, #0FH, COL1	;確認s09~s12是否有被按下
						;有則至掃描col的地方
ROW4:					;沒有則往下掃第四個row(s13~s16)
	MOV P0, #0EFH 		;掃描第四個row(s13~s16)
	CALL SHOW
	MOV A, P0
	ANL A, #0FH 		;將較高的4-bit清為0
	MOV R4, #12
	CJNE A, #0FH, COL1	;確認s13~s16是否有被按下
						;有則至掃描col的地方
	;JMP ROW1			;沒有則從頭掃描
COL1:
	CJNE A, #0EH, COL2	;0EH=00001110B
	MOV R5, #0
	AJMP WHICHBUTTON
COL2:
	CJNE A, #0DH, COL3	;0DH=00001101B
	MOV R5, #1
	AJMP WHICHBUTTON
COL3:
	CJNE A, #0BH, COL4	;0BH=00001011B
	MOV R5, #2
	AJMP WHICHBUTTON
COL4:
	CJNE A, #07H, NOCHANGE	;07H=00000111B
	MOV R5, #3
WHICHBUTTON:
	MOV A, R4
	ADD A, R5
	MOV R6, A
	AJMP FUNCTION
NOCHANGE:
	AJMP LOOP

;====================
BACK:
	MOV A, R1 	;右移一位
	MOV R0, A
	MOV A, R2
	MOV R1, A
	MOV A, R3
	MOV R2, A

	MOV R3, #0AH

	RET
;====================

;====================
RESET:
	MOV R0, #0AH	;個，#0AH為不顯示
	MOV R1, #0AH 	;十
	MOV R2, #0AH 	;百
	MOV R3, #0AH 	;千

	RET
;====================

;====================
ENTER:
	MOV R7, #0

	CJNE R3, #0AH, CHECK1
	MOV R3, #0
CHECK1:
	CJNE R2, #0AH, CHECK2
	MOV R2, #0
CHECK2:
	CJNE R1, #0AH, CHECK3
	MOV R1, #0
CHECK3:
	CJNE R0, #0AH, LOOP1
	MOV R0, #0
LOOP1:
	ACALL SHOWONESECOND

	INC R7
	CJNE R7, #3

	CJNE R0, #0H, DEC1
	MOV R0, #9H
	AJMP LOOP2
DEC1:
	DEC R0
	AJMP LOOP1
LOOP2:
	CJNE R1, #0H, DEC2
	MOV R1, #9H
	AJMP LOOP3
DEC2:
	DEC R1
	AJMP LOOP1
LOOP3:
	CJNE R2, #0H, DEC3
	MOV R2, #9H
	AJMP LOOP4
DEC3:
	DEC R2
	AJMP LOOP1
LOOP4:
	CJNE R3, #0H, DEC4
	MOV R0, #0AH
	MOV R1, #0AH
	MOV R2, #0AH
	MOV R3, #0AH
	ACALL SHOWONESECOND
	MOV R0, #0
	MOV R1, #0
	MOV R2, #0
	MOV R3, #0
	ACALL SHOWONESECOND
	MOV R0, #0AH
	MOV R1, #0AH
	MOV R2, #0AH
	MOV R3, #0AH
	ACALL SHOWONESECOND
	MOV R0, #0
	MOV R1, #0
	MOV R2, #0
	MOV R3, #0
	ACALL SHOWONESECOND
	MOV R0, #0AH
	MOV R1, #0AH
	MOV R2, #0AH
	MOV R3, #0AH
	RET

DEC4:
	DEC R3
	AJMP LOOP1

	RET
;====================

;====================
DELAY:
	MOV 30H, #0FFH
DELAY1:
	MOV 31H, #0FFH
DELAY2:
	MOV 32H, #0AH
DELAY3:
	DJNZ 32H, DELAY3
	DJNZ 31H, DELAY2
	DJNZ 30H, DELAY1
	RET
;====================
;====================
SHOWDELAY:
	MOV 30H, #0FFH
SHOWDELAY1:
	MOV 31H, #020H
SHOWDELAY2:
	DJNZ 31H, SHOWDELAY2
	DJNZ 30H, SHOWDELAY1
	RET
;====================

POS:
	DB 0FEH, 0FDH, 0FBH, 0F7H ;個十百千

NUMTABLE:
	DB 0C0H ;0
	DB 0F9H ;1
	DB 0A4H ;2
	DB 0B0H ;3
	DB 099H ;4
	DB 092H ;5
	DB 082H ;6
	DB 0F8H ;7
	DB 080H ;8
	DB 090H ;9
	DB 0FFH ;暗

WALKINGMAN1:
	DB 08H
	DB 6BH
	DB 7CH
	DB 52H
	DB 19H
WALKINGMAN2:
	DB 00H
	DB 64H
	DB 7EH
	DB 4DH
	DB 00H
WALKINGMAN3:
	DB 05H
	DB 69H
	DB 7EH
	DB 69H
	DB 05H