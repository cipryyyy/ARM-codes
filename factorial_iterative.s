.data
	target: .byte 6
.bss
	out: .skip 4
.text
	.global _start
_start:
	ldr r0, =target
	ldr r0, [r0]
	cmp r0, #1
	ble _end
	mov r1, #1
_loop:
	mul r1, r1, r0
	subs r0, #1
	bne _loop
	ldr r0, =out
	str r1, [r0]
	b _end
