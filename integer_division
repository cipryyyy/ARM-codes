.data
	dd: .word 12
	dr: .word 3
.bss
	qz: .space 4
	rm: .space 4
.text
	.global divide
divide:
	ldr r0,	=dd
	ldr r0, [r0]
	ldr r1,	=dr
	ldr r1, [r1]
	mov r2, #0
	mov r3, #-1
_loop:
	add r2, r1
	add r3, #1
	cmp r2, r0
	blt	_loop
	ldr r4, =qz
	str r3, [r4]
	subs r3, r0, r2
	addmi r3, r1
	ldr r4, =rm
	str r3, [r4]
