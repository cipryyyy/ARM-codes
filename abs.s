@Trovare il valore assoluto di r1 e r2 e salvare in r0
.text
	.global main
main:
	mov r1, #16		@2
	mov r2, #3		@18
	cmp r1, r2		@Compara
	bmi neg			@Se negativo (r1 < r2)
	bpl pos			@Se positivo (r1 >= r2)
	
neg:
	sub r0, r2, r1
	b end
pos:
	sub r0, r1, r2
	b end

end:
	mov pc, lr
