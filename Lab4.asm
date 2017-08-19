;Class:CSE 313 Machine Organization Lab
;Quarter: Fall 2016
;Name(s): Andrew Hedy, Steven Tang
;Lab#4: Fibonacci Sequence
;Description:The following program determines the value of the fibonacci sequence when a number is input. For instance, if the number 5 was input into location x3100
	    ;the fibonacci number would than be 5 located at location x3101 since 5 is the fifth number in the fibonacci sequence. Another example is if you input 
	    ;the number 8 into location x3100 the fibonacci number would than be 21 located at location x3101 since 21 is the eighth number of the fibonacci sequence. 
	    ;Locations x3102 and x3103 tell us the maximum location and fibonacci that can be represented in 16-bit 2's complement format. This should be the same for
	    ;all fibonacci sequences in LC-3. So in location x3102 the max n should be 23 and the max fibonacci should be 28657. 


.ORIG x3000

	;ORIGINAL VALUE INPUTED. SUBTRACT (2) TO FIND OUT WHERE TO BRANCH. 
	LDI R0, n		;STORE R0 INTO M[n] WHICH IS AT M[X3100]
	AND R1, R1, #0   	;CLEAR R1
	ADD R1, R0, #-2  	;THE VALUE (-2) IS ADDED TO R0 AND STORED IN R1

	;CONDITIONAL BRANCHES. IF R1 EQUALS NEG, POS, OR ZERO THE CODE BRANCHES TO LABEL. 
	BRn NEG  		;IF 'NEG' IS NEGATIVE, BRANCH
	BRz ZERO   		;IF 'ZERO' IS ZERO, BRAMCH
	BRp POS			;IF 'POS' IS POSITIVE, BRAMCH

	;IF R1 < 2 THAN BRANCH HERE AND Fn IS SIMPLY THE INPUT (n)
NEG	STI R0, Fn  		;STORE R0 INTO M[Fn] WHICH IS AT M[X3101]
	BR END   		;BRANCH TO LABEL 'END'

	;IF R1 = 2 THAN BRANCH HERE AND Fn IS STILL EQUAL TO 1 WHICH IS n-1. 
ZERO	ADD R0, R0, #-1 	;ADD VALUE (-1) TO R0 AND STORE IN R0
	STI R0, Fn  		;STORE R0 INTO M[Fn] WHICH IS AT M[x3101]
	BR END			;BRANCH TO LABEL 'END'

POS	AND R2, R2, #0  	;CLEAR R2
	ADD R2, R2, #1  	;ADD VALUE (1) TO R2
	AND R3, R3, #0  	;CLEAR R4
	ADD R3, R3, #1  	;ADD VALUE (1) TO R3
	AND R4, R4, #0 		;CLEAR R4
	AND R5, R5, #0  	;CLEAR R5
	ADD R5, R5, R0 		;R5+R0 AND STORE IN R5
	ADD R5, R5, #-2 	;ADD VALUE (-2) TO R5 AND STORE IN R5
 	
	;THIS LOOPS DECREMENTS n UNTIL IT REACHES 0 THEN EXITS LOOP. 
	;EACH TIME n IS DECREMENTED R2 AND R3 ARE ADDED AND STORED INTO R4. 
LOOP1	ADD R4, R2, R3 		;Fn = R2 + R3  
	AND R2, R2, #0 		;CLEAR R2
	ADD R2, R2, R3  	;R3+R2 AND STORE IN R2
	AND R3, R3, #0  	;CLEAR R3
	ADD R3, R3, R4  	;R3+R4 AND STORE IN R3
	ADD R5, R5, #-1  	;ADD VALUE (-1) TO R5 AND STORE IN R5. DECREMENT
	BRp LOOP1  		;IF POSITIVE BRANCH TO LABEL 'LOOP'
	STI R4, Fn		;STORE R4 INTO M[FIB] WHICH IS M[x3101]

END	AND R2, R2, #0  	;CLEAR R2
	ADD R2, R2, #1  	;ADD VALUE (1) TO R2 AND STORE IN R2
	AND R3, R3, #0  	;CLEAR R3
	ADD R3, R3, #1  	;ADD VALUE (1) TO R3 AND STORE IN R3
	AND R1, R1, #0 		;CLEAR R1
	ADD R1, R1, #2 		;ADD VALUE (2) TO R1 AND STORE IN R1
	AND R4, R4, #0 		;CLEAR R4

	;THIS LOOP INCREMENTS n UNTIL IT REACHES ITS MAXIMUM AMOUNT OF BITS
LOOP2	ADD R4, R2, R3 		;R4 = R2 + R3
	BRn STORE		;IF NEGATIVE BRANCH TO LABEL 'STORE'
	AND R2, R2, #0   	;CLEAR R2
	ADD R2, R2, R3   	;R2+R3 AND STORE IN R2
	AND R3, R3, #0   	;CLEAR R3
	ADD R3, R3, R4   	;R3+R4 AND STORE IN R3
	ADD R1, R1, #1  	;ADD VALUE (1) TO R1 AND STORE IN R1. INCREMENT
	BR LOOP2		;KEEP LOOPING UNTIL NEGATIVE. 

STORE	NOT R2, R2		;NEGATE R2
	ADD R2, R2, #1   	;ADD VALUE (1) TO R2 TO MAKE IT 2's COMPLEMENT
	ADD R4, R4, R2   	;R4+R2 AND STORE IN R4
	STI R1, N		;STORE R1 INTO M[N] WHICH IS AT M[x3102].
	STI R4, FN		;STORE R4 INTO M[FN] WHICH IS AT M[x3103].
	

HALT

	n	.FILL x3100	;FILLS VALUE INTO M[x3100]
	Fn	.FILL x3101	;FILLS VALUE INTO M[x3101]
	N	.FILL X3102	;FILLS VALUE INTO M[x3102]
	FN	.FILL x3103	;FILLS VALUE INTO M[x3103]

.END	