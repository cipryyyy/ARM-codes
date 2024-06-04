.data
	target: .byte 6
.bss
	out: .skip 4
.text
	.global _start
_fatt:
	push {r12, lr}
	mov r12, sp
	muls r1, r1, r0
	subs r0, #1
	cmp r0, #1
	blne _fatt
	pop {r12, pc}
_start:
	mov sp, #0
	mov r1, #1
	ldr r0, =target
	ldr r0, [r0]
	cmp r0, #0
	ble _end
	bl _fatt
	ldr r0, =out
	str r1, [r0]
	b _end
