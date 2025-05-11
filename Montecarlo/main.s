.data
	i:  .word 10000
.bss
	seed:   .skip 4
	random: .skip 4
	out:    .skip 4
.text
.global _start

_divide:
	vmov s0, r0
	vmov s1, r1
	vdiv.F32 s2, s0, s1

_generator:
	push 	{r1-r3, lr}
	
	tst 	r1, r1, lsr #1
	movs 	r2, r0, rrx
	adc 	r1, r1, r1
	eor 	r2, r2, r0, lsl #12
	eor 	r0, r2, r2, lsr #20
	
	ldr 	r3, =random
	str 	r2, [r3]
	pop 	{r1-r3, pc}
_start:
	mov r0, #1798
	
