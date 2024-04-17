@Calcolo del dodicesimo numero di fibonacci
.data
	input: .word 12
.bss
	output: .skip 4
.text
	.global _start
_start:
	mov r0, #1
	mov r1, #1
	mov r9, #2
	ldr r10, =input
	ldr r10, [r10]
	cmp r10, #0
	beq _fib0
	cmp r9, r10
	bpl _fib12
_loop:
	add r9, #1
	add r2, r1, r0
	mov r0, r1
	mov r1, r2
	cmp r9, r10
	bmi _loop
	bal _print
_fib12:
	mov r2, #1
	bal _print
_fib0:
	mov r2, #0
	bal _print
_print:
	ldr r0, =output
	str r2, [r0]
	bal _end
