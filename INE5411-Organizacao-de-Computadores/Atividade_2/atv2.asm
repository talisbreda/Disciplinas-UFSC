.data	

	A: .word 1, 2, 3, 0, 1, 4, 0, 0, 1
	B: .word 1, 0, 0, -2, 1, 0, 5, -4, 1
	C: .word 0:9
	space: .asciiz " "
	newline: .asciiz "\n"
	.align 2
	filename: .asciiz "output.txt"

.text
main:
	
	li	$t0, 0		# Contador para o loop
	li	$t1, 9		# Limite do contador
	la	$t2, A  	# Endere�o de A
	la	$t3, B  	# Endere�o de B
	la 	$t4, C		# Endere�o de C

loop:
	
	lw	$t5, 0($t2)	# Carrega o elemento atual de A para o registrador
	lw	$t6, 0($t3)	# Carrega o elemento atual de B para o registrador
	
	mul	$t6, $t5, $t6	# Faz a multiplica��o no elemento atual
	sw	$t6, 0($t4)	# Armazena o resultado em C
	
	# Soma dos endere�os
	addi	$t2, $t2, 4
	addi	$t3, $t3, 4
	addi	$t4, $t4, 4
	
	addi	$t0, $t0, 1	# Soma do contador
	
	bne	$t0, $t1, loop  # Condi��o de continuidade do loop
	
endloop:
	
	li	$t0, 0		# Iterador de colunas
	li	$t1, 0		# Iterador de linhas
	li	$t2, 3		# Limite dos iteradores
	la	$t4, C		# Endere�o de C
	
	# Abrir arquivo 
	li	$v0, 13		# Comando para abrir arquivo
	la	$a0, filename	# Nome do arquivo
	li	$a1, 1		# Flag para modo escrita
	syscall
	
	move 	$s0, $v0	# Armazena a descri��o do arquivo em $s0
	
print_loop1:

	move	$t0, $zero	# Reseta o valor de $t0

	print_loop2:
	
		lw	$t5, 0($t4)	# Carrega o valor atual de C
		addi	$t5, $t5, 48	#
		sw	$t5, 0($t4)	# 
	
		# Imprime o inteiro
		li	$v0, 15		# Comando para escrever em arquivo
		move	$a0, $s0	# Descri��o do arquivo
#		move	$a1, $t5	# Elemento a ser escrito
		la	$a1, ($t4)
		li	$a2, 1		# Quantidade de elementos a serem escritos
		syscall
	
		# Imprime um espa�o
		li	$v0, 15		# Comando para escrever em arquivo
		move	$a0, $s0	# Carrega o arquivo
		la	$a1, space	# Elemento a ser escrito
		li	$a2, 1		# Quantidade de elementos a serem escritos
		syscall
	
		addi 	$t0, $t0, 1	# Soma o contador interno
		addi	$t4, $t4, 4	# Pula para o pr�ximo elemento da lista
	
		bne	$t0, $t2, print_loop2	# Condi��o de continuidade

	end_print_loop2:

		# Imprime uma nova linha
		li	$v0, 15		# Comando para escrever em arquivo
		move	$a0, $s0	# Carrega o arquivo
		la	$a1, newline	# Elemento a ser escrito
		li	$a2, 1		# Quantidade de elementos a serem escritos
		syscall
	
		addi	$t1, $t1, 1	# Soma o contador externo
	
		bne	$t1, $t2, print_loop1	# Condi��o de continuidade
		
	li	$v0, 16
	move	$a0, $s0
	syscall
