.equ led, 0xff200000
.data
	wait: .byte 156
.text
	mov r0, #0x80000000
	ldr r1, =led
	str r0, [r1]
	mov r4, #32
trap1:
	sub r4, #1
	cmp r4, #0
	moveq r4, #32
	beq trap2
	bl pause
	asr r0, #1
	str r0, [r1]
	b trap1
trap2:
	sub r4, #1
	cmp r4, #0
	moveq r4, #32
	beq trap2
	bl pause
	lsr r0, #1
	str r0, [r1]
	b trap2
pause:
	push {r0, r1}
	ldr r0, =wait
	ldrb r1, [r0]
loopPause1:
	ldrb r2, [r0]
loopPause2:
	ldrb r3, [r0]
loopPause3:
	subs r3, #1
	bne loopPause3
	subs r2, #1
	bne loopPause2
	subs r1, #1
	bne loopPause1
	pop {r0, r1}
	mov pc, lr
