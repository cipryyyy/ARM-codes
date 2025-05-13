@Monte Carlo algorithm to aproximate the value of Pi
@Value found: 		3.14
@Execution time:	59ms

.data
    i:    	.word 10000		@Number of iterations, 10000 is more than enough
    seed: 	.word 978124		@Seed of number generator
.bss
    random: .skip 4			@The pseudo-random generated number
    pi:    	.skip 2			@Value of PI
.text
    .global _start
_divide:
    VMOV 			S0, R0		@Move the value of r0 into s0 (float register)
    VCVT.F32.S32 	S0, S0		@Convert from int to float
    VMOV 			S1, R1		@Same here
    VCVT.F32.S32 	S1, S1
    VDIV.F32 		S2, S0, S1	@Divide s0 by s1
    VMOV 			R0, S2		@Return result in r0
    MOV 			PC, LR		@Exit
_generator:
    PUSH 	{R0-R2, LR}		@Create the frame
    LDR 	R0, =seed		@Load the seed
    LDR 	R0, [R0]
    TST 	R1, R1, LSR #1		@Apply the algorithm
    MOVS 	R2, R0, RRX
    ADC 	R1, R1, R1
    EOR 	R2, R2, R0, LSL #12
    EOR 	R0, R2, R2, LSR #20
    LDR 	R1, =random			@Save the generated number (just the last halfword)
    STRH 	R2, [r1]
    LDR     R1, =seed			@Save the new seed
    STR     R0, [R1]
    POP 	{R0-R2, PC}			@Exit the frame
_start:							@11bit, otherwise it'll overflow
    MOV     R8, #0x7FF        	@radius
    MUL     R8, R8, R8        	@r square, to do x^2+y^2 <= r^2
    MOV     R10, #0				@Counter
    LDR     R11, =i				@Limit
    LDR     R11, [R11]
    MOV     R12, #0				@Point inside of the circle
_loop:
    BL      _generator			@Generate x
    LDR     R0, =random			@Load the value
    LDRSH   R0, [R0]          	
    LSL     R0, R0, #20       	@Downsize (otherwise it'll overflow)
    ASR     R0, R0, #20			@Shift with value
    MUL     R0, R0, R0			@x^2
    BL      _generator			@Repeat for y
    LDR     R1, =random
    LDRSH   R1, [R1]
    LSL     R1, R1, #20
    ASR     R1, R1, #20
    MUL     R1, R1, R1        
    ADD     R2, R0, R1    		@x^2+y^2   
    CMP     R2, R8				@x^2+y^2 <= r^2?
    ADDLE   R12, R12, #1     	@If so, increment point counter
    ADD     R10, R10, #1		@Increment step counter
    CMP     R10, R11			@Check if it's done
    BNE     _loop
	MOV 	R0, R12				@Move the counters in r0 and r1
	LSL		R0, #2				@Multiply by 4
	MOV 	R1, R11
	BL 		_divide				@Execute r0/r1
	LDR 	R1, =pi				@Save the value of Pi
	STR 	R0, [R1]
	B 		_end				@Quit
