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
	
	# Input do  block_size
	li	$v0, 5
	syscall
	move	$s5, $v0

	li	$t0, 0	# i
	bge	$t0, $s0, end_fori
	
fori:

	li	$t1, 0	# j
	bge	$t1, $s0, end_forj

	forj:
	
		move	$t2, $t0	# definindo ii
		add	$s6, $t0, $s5	# i + block_size
		bge	$t2, $s6, end_forii
		
		forii:
		
			move	$t3, $t1	# definindo jj
			add	$s7, $t1, $s5	# j + block_size
			bge	$t3, $s7, end_forjj
			
			forjj:
			
				mul	$t4, $t2, 4	# ajuste para linha
				mul	$t5, $t4, $s0	# ajuste para coluna
		
				mul	$t6, $t3, 4	# ajuste para linha
				mul	$t7, $t6, $s0	# ajuste para coluna
				
		
				add	$t8, $t5, $t6	# soma linha i e coluna j
				add	$t8, $t8, $s2	# soma com o endereço basee
				l.s	$f1, ($t8)	# carrega A[i, j]
		
				add	$t9, $t4, $t7	# soma linha j e coluna i
				add 	$t9, $t9, $s4	# soma com o endereço base
				l.s	$f2, ($t9)	# carrega B[j, i]
				
				add.s	$f1, $f1, $f2	# soma A[i,j] + B[j, i]
				s.s	$f1, ($t8)	# armazena a soma
				
				addi	$t3, $t3, 1
				blt	$t3, $s7, forjj
			
			end_forjj:
			
			addi	$t2, $t2, 1
			blt	$t2, $s6, forii
			
		end_forii:
		
		add	$t1, $t1, $s5	# j++
		blt	$t1, $s0, forj
	
	end_forj:	
	
	add	$t0, $t0, $s5	# i++
	blt	$t0, $s0, fori
	
end_fori:
