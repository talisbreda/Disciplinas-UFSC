.data
	A: .word 1, 2, 3, 0, 1, 4, 0, 0, 1
	B: .word 1, 0, 0, -2, 1, 0, 5, -4, 1
	C: .word 0:9
	string: .asciiz "                      "
	space: .asciiz " "
	fout: .asciiz "output.txt"
	
.text
	# ===============================================================================================
	# Início do Programa principal - main.
	# ===============================================================================================	
main:
	# Abre o arquivo txt 
	li	$v0, 13		# Comando para abrir arquivo
	la	$a0, fout	# Nome do arquivo
	li	$a1, 1		# Flag para modo escrita
	li	$a2, 0		# Modo ignorado (neste caso).
	syscall			
	move	$s5, $v0	# Armazena a descricao do arquivo em $s6
	
	
	jal	multiplica	# Chama funcao que multiplica matrizes


	# Escreve a string no arquivo		
	li	$v0, 15		# Comando para escrever em arquivo
	move	$a0, $s5	# Descrição do arquivo
	la	$a1, string	# Buffer do que será escrito
	li	$a2, 50		# Tamanho limite
	syscall	
	
	# Fecha o arquivo
	li	$v0, 16		# Código para fechar arquivo
	move	$a0, $s5	# Descrição do arquivo
	syscall	
	
end:
	# Loop eterno no final do programa
	j	end		
	# ===============================================================================================
	# Fim do programa principal. 
	# ===============================================================================================
		

	# ===============================================================================================
	# Início da multiplicação de matrizes
	# ===============================================================================================
multiplica:
	
	la	$s0, A  	# Endereco de A
	la	$s1, B  	# Endereco de B
	la 	$s2, C		# Endereco de C
	la	$s3, string	# Endereco variavel da string
	la	$s4, string	# Endereco fixo da string
		
	li	$t0, 0		# Contador para o loop
	li	$t1, 9		# Limite do contador

	loop:
	
		lw	$t2, 0($s0)	# Carrega o endereco atual de A para o registrador
		lw	$t3, 0($s1)	# Carrega o endereco atual de B para o registrador
	
		mul	$t3, $t2, $t3	# Faz a multiplicacao no $t2 atual
		sw	$t3, 0($s2)	# Armazena o resultado em C
	
		# Pula para o proximo índice de cada lista
		addi	$s0, $s0, 4
		addi	$s1, $s1, 4
		addi	$s2, $s2, 4
	
		addi	$t0, $t0, 1	# Soma do contador
	
		bne	$t0, $t1, loop  # Se o contador for diferente do limite, continua
	
	# ===============================================================================================
	# Fim da multiplicacao de matrizes
	# ===============================================================================================
	
save_to_string:	
	
	# ===============================================================================================
	# Inicio do armazenamento da matriz na string
	# ===============================================================================================
		
	# Armazena nova linha na string
	li	$t2, 10
	sw	$t2, ($s3)
	addi	$s3, $s3, 4
	
	li	$t0, 0		# Iterador de colunas
	li	$t1, 0		# Iterador de linhas
	li	$s0, 3		# Limite dos iteradores
	la	$s2, C		# Endereco de C
	
	save_loop1:

		move	$t0, $zero	# Reseta o valor do contador de colunas

		save_loop2:
	
			lw	$t2, 0($s2)	# Carrega o valor atual de C
			addi	$t2, $t2, 48	# Transforma o numero para a sua representacao ASCII
		
			sw	$t2, ($s3)	# Salva o índice na string
	
			addi 	$t0, $t0, 1	# Soma o contador de colunas
			addi	$s2, $s2, 4	# Pula para o proximo índice da lista
			addi	$s3, $s3, 4	# Soma o endereço da string
	
			bne	$t0, $s0, save_loop2	# Condicao de continuidade
	
		li	$t2, 10		# Carrega caracter de nova linha
		sw	$t2, ($s3)	# Salva a nova linha na string
		
		addi 	$s3, $s3, 4	# Soma o endereço da string
		addi	$t1, $t1, 1	# Soma o contador de linhas
	
		bne	$t1, $s0, save_loop1	# Condicao de continuidade

end_save:

	jr	$ra
	# ===============================================================================================
	# Fim do armazenamento da matriz na string
	# ===============================================================================================
	
