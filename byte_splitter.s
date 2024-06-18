.data
	input: .word 0x12345678
.bss
	splitted: .skip 1
.text
	.global _split
_split:
	ldr r0, =input
	ldr r0, [r0]
	ldr r5, =splitted
	mov r1, #0
	mov r2, #0xF
_loop:
	and r3, r0, r2
	lsl r2, r2, #4
	lsl r4, r1, #2
	lsr r3, r3, r4
	strb r3, [r5, r1]
	add r1, #1
	cmp r1, #8
	bne _loop
	mov pc, lr
