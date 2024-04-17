
@Somma dei primi 256 con store

.arm
.org 0x1000
.bss
	output: .space 4
.data
	sum: .word 0x100
.text
	.global _start
_start:
	ldr r0, =sum
	ldr r0, [r0]
	mov r1, #0
_loop:
	add r1, r1, r0
	subs r0, r0, #1
	bne _loop
	bal _store
_store:
	ldr r10, =output
	str r1, [r10]