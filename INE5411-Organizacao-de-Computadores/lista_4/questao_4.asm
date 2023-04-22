.data
	primeiro: .asciiz "\nDigite o valor do primeiro número: "
	segundo: .asciiz "\nDigite o valor do segundo número: "
	resultado: .asciiz "\nO resultado da soma é: "

.text
main:
	jal	soma		# Chama o procedimento de soma
	move	$s2, $v0	# Guarda o resultado da soma
	
	# Imprime a string de resultado
	li	$v0, 4
	la	$a0, resultado
	syscall
	
	# Imprime o resultado
	li	$v0, 1
	move	$a0, $s2
	syscall
	
	# Finaliza o programa
	li	$v0, 10
	syscall

leitura:
	# Imprime o texto para o primeiro input
	li	$v0, 4
	la	$a0, primeiro
	syscall

	# Captura o primeiro input
	li	$v0, 5
	syscall
	move	$s0, $v0
	
	# Imprime o texto para o segundo input
	li	$v0, 4
	la	$a0, segundo
	syscall
	
	# Captura o segundo input
	li	$v0, 5
	syscall
	move	$s1, $v0
	
	jr	$ra

soma:
	# Guarda o ponteiro da primeira chamada na pilha
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	jal	leitura		# Chama o procedimento de leitura de input
	add	$v0, $s0, $s1	# Realiza a soma
	
	# Recupera o ponteiro da primeira chamada
	lw	$ra, 0($sp)	
	addi	$sp, $sp, 4
	
	jr	$ra