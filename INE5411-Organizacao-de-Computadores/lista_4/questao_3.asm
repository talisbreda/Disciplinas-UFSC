.text
main:

	li	$a0, 3		# Carrega o valor da base
	li	$a1, 3		# Carrega o valor do expoente
	jal	pow		# Faz o cálculo
	move	$s0, $v0	# Guarda o resultado
	
	# Imprime o resultado no console
	li	$v0, 1
	move	$a0, $s0
	syscall
	
	# Finaliza o programa
	li	$v0, 10
	syscall
	

pow:
	# $a0 -> base
	# $a1 -> expoente
	
	li	$t0, 0	# Contador
	li	$t1, 1	# Resultado
	
loop:
	
	mul	$t1, $t1, $a0	# resultado = resultado * base
	
	addi	$t0, $t0, 1	# i = i + 1
	blt	$t0, $a1, loop	# se i < expoente, continua o loop

endloop:
	
	move	$v0, $t1	# Guarda o resultado no registrador de retorno
	
	jr	$ra