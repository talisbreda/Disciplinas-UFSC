.data 

.text
main:

	li	$t0, 0		# Contador
	li	$t1, 5		# Limite do contador
	
loop:
	
	add	$t0, $t0, 1	# i = i + 1
	add	$t2, $t2, $t0	# resultado = resultado + i

	bne	$t1, $t0, loop	# enquanto i < 5, continua

endloop:
	
	# Fim do programa
	li	$v0, 10
	syscall		
