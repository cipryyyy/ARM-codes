.data
	i:    .word 10000
	seed: .word 1875
.bss
	random: .skip 4
	pi:    .skip 4
.text
.global _start

_divide:
	vmov s0, r0
	vmov s1, r1
	vdiv.F32 s2, s0, s1
	vmov s2, r0
_generator:
	push 	{r0-r3, lr}
	ldr 	r0, =seed
	ldr 	r0, [r0]
	tst 	r1, r1, lsr #1
	movs 	r2, r0, rrx
	adc 	r1, r1, r1
	eor 	r2, r2, r0, lsl #12
	eor 	r0, r2, r2, lsr #20
	ldr 	r3, =random
	str 	r2, [r3]
	ldr     r3, =seed
	str     r0, [r3]
	pop 	{r0-r3, pc}

_start:
	mov r10, #0
	ldr r11, =i
	ldr r11, [r11]
	mov r12, #0
_loop:
	bl _generator		@generate x
	ldr r0, =random
	ldr r0, [r0]
	bl _generator		@generate y
	ldr r1, =random
	ldr r1, [r1]
	
						@normalize
						@Check if in circle
						@If so, increment counter r12
						@Divide val
						@Multiply by 4
						@Store in pi
