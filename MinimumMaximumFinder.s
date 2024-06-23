.bss
	min: .skip 4			@value of min
	mindex: .skip 1			@index of min
	.align				@align to word
	max: .skip 4			@value of max
	Mindex: .skip 1			@index of max
	.align				@align to word
.data
	@Array:
	V: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf, 0x10
	@End the array, used to calculate the length
	end: .word 0
.text
	.global MinMaxFinder
MinMaxFinder:
	ldr r0, =V	 	@Load the array
	mov r1, #0	 	@Reset the counter
	mov r2, #0	 	@Maximum value
	mov r3, #0	 	@Index
	ldr r4, =end 	@End of the array
	mov r6, #0	 	@Minimum value
	mov r7, #0	 	@Index
	sub r4, r4, r0	@Calculate the difference between start of array end end of array
	lsr r4, #2		@Divide by 4
_loop:
	ldr r5, [r0, r1, lsl #2]	@Load the element
	cmp r5, r2					@Compare to maximum
	movge r2, r5				@Save if greater
	movge r3, r1
	cmp r5, r6					@Compare to minimum
	movle r6, r5				@Save if lower
	movle r7, r1
	add r1, #1					@Increment
	cmp r1, r4					@Check if the array is ended
	bne _loop
	ldr r0, =max				@Store maximum
	ldr r1, =Mindex
	str r2, [r0]
	str r3, [r1]
	ldr r0, =min				@Store minimum
	ldr r1, =mindex
	str r6, [r0]
	str r7, [r1]
	b _end						@Jump to the end
