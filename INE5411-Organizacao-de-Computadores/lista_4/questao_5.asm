.data

	resultado1: .asciiz "O fatorial de "
	resultado2: .asciiz " é: "

.text
main:	

	li	$s0, 9

	move	$a0, $s0	# Valor a ser fatorialado
	jal	fatorial	# Chama de função
	move	$s1, $v0	# Armazena o resultado
	
	# =====================================================================================
	# Inicia impressão do resultado
	# =====================================================================================
	
	# Imprime primeira string
	li	$v0, 4
	la	$a0, resultado1
	syscall
	
	# Imprime o input
	li	$v0, 1
	move	$a0, $s0
	syscall
	
	# Imprime segunda string
	li	$v0, 4
	la	$a0, resultado2
	syscall
	
	# Imprime o resultado
	li	$v0, 1
	move	$a0, $s1
	syscall
	
	# =====================================================================================
	# Finaliza impressão do resultado
	# =====================================================================================
	
	# Finaliza o programa
	li	$v0, 10		# Finaliza o programa
	syscall			# Finaliza o programa

fatorial:
	# $a0 -< número
	addi	$sp, $sp, -8	# Reduz o stack pointer
	sw	$ra, 0($sp)	# Armazena o ponteiro da chamada no stack pointer

	bge	$a0, 1, else	# Se n > 1, pula para o else
	li	$v0, 1		# return 1
	j 	end		# Pula para o final

else:
	sw	$a0, 4($sp)	# Armazena o valor anterior na stack
	addi	$a0, $a0, -1	# n = n - 1
	jal	fatorial	# Chama o fatorial para n-1
	
	lw	$t0, 4($sp)	# Obtém o valor anterior da stack
	mul	$v0, $v0, $t0	# Multiplicação n * fatorial(n-1)

end:
	lw	$ra, 0($sp)	# Carrega o ponteiro da chamada anterior
	addi	$sp, $sp, 8	# Aumenta o stack pointer
	
	jr	$ra