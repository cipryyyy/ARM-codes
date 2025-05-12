.data
	i:    		.word 100000		@Number of iterations
	seed: 		.word 978124		@Seed of number generator
.bss
	random: 	.skip 4			@The pseudo-random generated number
	pi:    		.skip 2			@Value of PI
	.align
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
	PUSH 			{R0-R3, LR}				@Save registers
	LDR 			R0, =seed				@Load the seed
	LDR 			R0, [R0]
	tst 			R1, R1, lsr #1			@Apply the algorithm
	MOVS 			R2, R0, rrx
	ADC 			R1, R1, R1
	EOR 			R2, R2, R0, lsl #12
	EOR 			R0, R2, R2, lsr #20
	LDR 			R3, =random				@Save the generated number (just the last halfword)
	STRH 			R2, [r3]
	LDR     		R3, =seed				@Save the new seed
	STR     		R0, [R3]
	POP 			{R0-R3, PC}				@Exit the frame
_start:
	MOV				R8, #0x8888				@Radius squared
	MUL 			R8, R8, R8
	MOV 			R9, #0x8888				@Center of the circle
	MOV 			R10, #0					@Iteration counter
	LDR 			R11, =i					@Iteration limiter
	LDR 			R11, [R11]
	MOV 			R12, #0					@Point inside of the circle
_loop:
	BL 				_generator				@Generate x coordinate
	LDR 			R0, =random
	LDR 			R0, [R0]				@Load it in r0
	SUB 			R0, R0, r9				@Normalize it between [-0x8888, 0x8888]
	MUL 			R0, R0, R0				@Square it
	BL 				_generator				@Repeat for y coordinate
	LDR 			R1, =random
	LDR 			R1, [R1]
	SUB 			R1, R1, r9
	MUL 			R1, R1, R1
	ADD 			R2, R1, R0				@Sum x and y
	CMP 			R2, R8					@If r^2 <= x^2+y^2 
	ADDMI 			R12, R12, #1			@Point is inside
	ADD 			R10, #1					@Increment cycle counter
	CMP 			R10, R11				@Check if Cycle is done
	BNE 			_loop
	MOV 			R0, R12					@Move the counters in r0 and r1
	LSL				R0, #2					@Multiply by 4
	MOV 			R1, R11
	BL 				_divide					@Execute r0/r1
	LDR 			R1, =pi					@Save the value of Pi
	STR 			R0, [R1]
	B 				_end					@Quit
	
@TODO: value is a little higher, like 3.3 instead of 3.14, probably from the generator
