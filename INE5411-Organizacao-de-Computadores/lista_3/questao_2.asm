.data 

.text
main:

	li	$t0, 0		# Contador
	li	$t1, 5		# Limite do contador
	
loop:
	
	add	$t0, $t0, 1	
	add	$t2, $t2, $t0

	bne	$t1, $t0, loop

endloop:
	
	li	$v0, 10
	syscall