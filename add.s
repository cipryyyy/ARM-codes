@Sommare r1 e r2 e salvare in r0
.text
	.global main		@ Obbligatorio usare main con raspy
main:
	mov r1, #10
	mov r2, #15
	add r0, r1, r2
	
	mov pc, lr			@ Ritorna il controllo al sistema operativo
						@ Obbligatorio mettere una newline vuota alla fine
	
