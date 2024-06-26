.data
	V: .word 28, -98, 90, -86, 64, -70, -8, 71, 51, 82, 0, -93, 9, 31, 11, 17, 74, 67, -40, 99, 79, -51, 52, 63, -32, 81, 12, -19, -7, 6, -5, -83, 34, 23, 96, 78, -69, 100, 55, 7, 89, -46, -21, 61, 48, -64, 91, -74, 37, 56, 38, 4, -15, -65, 2, -100, 21, -91, -48, 27, -41, -35, -88, 72, 5, -67, -89, 95, -84, -95, -63, 45, -59, -76, -79, -1, -96, -16, 13, -55, -26, -10, 69, 92, -60, -72, -37, -52, 35, 46, 66, -11, 98, 25, -13, -25, -71, -56, 77, -57, 19, -30, 1, -87, 83, -6, -22, -75, -3, 60, -92, -99, -29, 70, 18, -61, -54, -31, 40, 36, -94, -2, -28, -9, -81, 57, -97, -4, 33, -45, 58, 50, 65, 41, 88, 39, -36, 87, 49, 42, -53, 54, 14, 73, 3, 20, -38, -68, -73, -90, 43, -27, -66, 15, -34, 86, -17, 22, 47, -58, 26, 85, 62, 24, 32, 16, 94, 30, 84, 97, 44, -33, -62, 75, -20, 68, 53, -47, -43, -44, 8, -23, 76, -78, 93, 10, -85, -24, -14, -39, -18, 59, 29, -82, -80, -49, -77, 80, -12, -50
	EOA: .word 1		@End Of Array
.text
	.global insertionSort
insertionSort:
	ldr r0, =V		@Load the array
	ldr r1, =EOA	@Calculate the length
	sub r1, r1, r0
	lsr r1, #2
	mov r2, #1		@Insertion starts from the second element
_loop1:
	ldr r3, [r0, r2, lsl #2]		@Load the i-th element
	mov r4, r2						@Copy the value (to check the previous elements)
_loop2:
	sub r4, r4, #1				@Subtract one
	ldr r5, [r0, r4, lsl #2]	@Load the element
	cmp r3, r5					@Check if last loaded element is smaller	
	add r6, r4, #1					@If yes, swap them in RAM
	strlt r5, [r0, r6, lsl #2]
	strlt r3, [r0, r4, lsl #2]
	cmp r4, #0					@Check if I reached the beginning of the array
	bne _loop2					@If not, repeat with the previous element
	add r2, #1					@If yes, proceed to sort the next element
	cmp r2, r1					@Check if I've completed the sorting
	bne _loop1				@If not, I proceed to sort
	b _end				@Jump to the end
