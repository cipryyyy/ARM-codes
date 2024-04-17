@Fare la somma deiquadrati dei primi addr_n numeri
.data
	addr_n: .word 2	@ input	
.bss
	addr_sum: .skip 4	@ output
.text
	ldr r1, =addr_n 	@In r1 tengo traccia del numero che calcolo
	ldr r1, [r1]
	mov r0, #0			@In r0 salvo la somma
loop:
	mov r2, r1
	mul r2, r2, r2
	add r0, r0, r2	@Faccio il quadrato in r2 e poi lo sommo in r0
	bl print_int 	@Chiamata al metodo per stampare il valore in r0
	sub r1, #1
	cmp r1, #0		@Controllo se sono arrivato alla fine
	beq end
	b loop	@loop
end:
	ldr r1, =addr_sum	@Salvo il valore in memoria
	str r0, [r1]
	bl exit_program
