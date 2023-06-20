.data

.text
main:

# --------------------------------------------------------------------
# CONSTRÓI A MATRIZ
# --------------------------------------------------------------------

	li	$v0, 5
	syscall
	move	$s0, $v0	# MAX
	
	li	$s1, 0		# value
	li	$s2, 0x10010000	# endereco da matriz A
	
	mul	$s3, $s0, 4	# ajuste do MAX para memória
	
	li	$t9, 0
	bge	$t9, 2, end_for_matrix

for_matrix:
	
	li	$t0, 0		# row
	li 	$t1, 0		# column
	
	blt	$t0, $s0, for_row
	j	end_for_row
	
	for_row:
	
		blt	$t1, $s0, for_column
		j	end_for_column
	
		for_column:
		
			mul	$t2, $t0, $s3
			mul	$t3, $t1, 4
			add	$t2, $t2, $t3
			add	$t2, $t2, $s2
			
			sw	$s1, ($t2)
			addi	$s1, $s1, 1
			
			addi	$t1, $t1, 1
			blt	$t1, $s0, for_column
			
		end_for_column:
	
		li	$t1, 0
		addi	$t0, $t0, 1
		blt	$t0, $s0, for_row
		
	
	end_for_row:
	
	# soma de endereço para criação da matriz B
	mul	$t8, $s0, $s0
	mul	$t8, $t8, 4
	add	$s2, $s2, $t8	# salvando endereço da matriz B em $s4
	
	# verificação do for
	addi	$t9, $t9, 1
	blt	$t9, 2, for_matrix

end_for_matrix:

# --------------------------------------------------------------------
# TERMINA A CONSTRUÇÃO DA MATRIZ
# --------------------------------------------------------------------


# --------------------------------------------------------------------
# INICIA A SOMA
# --------------------------------------------------------------------
	li	$s2, 0x10010000	# endereco da matriz A
	
	# Calcula o endereço da matriz B com base na variável MAX
	mul	$s4, $s0, $s0
	mul	$s4, $s4, 4
	add	$s4, $s4, $s2

	li	$t0, 0	# i
	bge	$t0, $s0, end_fori
	
fori:

	li	$t1, 0	# j
	bge	$t1, $s0, end_forj

	forj:
		
		mul	$t2, $t0, 4	# ajuste para linha
		mul	$t3, $t2, $s0	# ajuste para coluna
		
		mul	$t4, $t1, 4	# ajuste para linha
		mul	$t5, $t4, $s0	# ajuste para coluna
		
		
		add	$t6, $t3, $t4	# soma linha i e coluna j
		add	$t6, $t6, $s2	# soma com o endereço basee
		l.s	$f1, ($t6)	# carrega A[i, j]
		
		add	$t7, $t2, $t5	# soma linha j e coluna i
		add 	$t7, $t7, $s4	# soma com o endereço base
		l.s	$f2, ($t7)	# carrega B[j, i]
		
		add.s	$f1, $f1, $f2	# soma A[i,j] + B[j, i]
		s.s	$f1, ($t6)	# armazena a soma
		
		addi	$t1, $t1, 1	# j++
		blt	$t1, $s0, forj
	
	end_forj:	
	
	addi	$t0, $t0, 1	# i++
	blt	$t0, $s0, fori
	
end_fori:
