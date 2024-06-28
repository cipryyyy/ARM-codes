.data
	dvd: .word -15	@dividend
	dvs: .word -7	@divisor
.bss
	qt: .skip 4		@quotient
	rm: .skip		@remainder
.text
	mov r10, #0		@Works as a boolean, check if only one value is negative
	ldr r0, =dvd	@Load values
	ldr r0, [r0]
	ldr r1, =dvs
	ldr r1, [r1]
	cmp r0, #0			@If it's negative
	rsbmi r0, r0, #0	@Sign is flipped
	addmi r10, #1		@Update the boolean
	cmp r1, #0			
	rsbmi r1, r1, #0
	addmi r10, #1	
	mov r2, #0		@Counter for the quotient
_loop:
	cmp r1, r0		@Divisor greater than dividend
	bgt _save		@Yes, save the result
	subs r0, r1		@No, decrement the divisor
	add r2, #1		@Increase the quotient
	b _loop			@Loop
_save:
	tst R10, #1 	@Check Z-Flag for parity
	rsbne r0, r0, #0	@Bool is true, one value is negative
	rsbne r2, r2, #0	@Flip the values
	ldr r1, =qt			@Load the addresses and save
	str r2, [r1]
	ldr r1, =rm
	str r0, [r1]
	b _end 			@exit
