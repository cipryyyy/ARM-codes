.data
	arr: .byte 0, 1, 2, 3, 4, 5
.bss
	val: .skip 1
	
.text
	ldr r0, =arr	
	ldr r3, =val	

	mov r1, #3		
	ldrb r2, [r0, r1]	
	strb r2, [r3]		
	
	mov r4, #5			
	strb r4, [r0, r1]	
