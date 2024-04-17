@Sottrarre i registri r3 e r4 e salvare in r0
.text
	.global main
main:
	mov r3, #16
	mov r4, #3
	sub r1, r3, r4
	
	mov pc, lr
