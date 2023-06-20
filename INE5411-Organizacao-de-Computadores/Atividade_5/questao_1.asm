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
	la	$s2, matriz	# endereco da matriz
	
	li	$t0, 0		# row
	li 	$t1, 0		# column
	
	blt	$t0, $s0, for_row
	j	end_for_row
	
	for_row:
	
		blt	$t1, $s0, for_column
		j	end_for_column
	
		for_column:
		
			mul	$t2, $t0, 64
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
	
	li	$v0, 10
	syscall

# --------------------------------------------------------------------
# TERMINA A CONSTRUÇÃO DA MATRIZ
# --------------------------------------------------------------------


# --------------------------------------------------------------------
# INICIA A SOMA
# --------------------------------------------------------------------

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
		l.s	$f1, ($t6)	# carrega A[i, j]
		
		add	$t7, $t2, $t5	# soma linha j e coluna i
		l.s	$f2, ($t7)	# carrega B[j, i]
		
		add.s	$f1, $f1, $f2	# soma A[i,j] + B[j, i]
		s.s	$f1, ($t6)	# armazena a soma
		
		addi	$t1, $t1, 1	# j++
		blt	$t1, $s0, forj
	
	end_forj:	
	
	addi	$t0, $t0, 1	# i++
	blt	$t0, $s0, fori
	
end_fori: