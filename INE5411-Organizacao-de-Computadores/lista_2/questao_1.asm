.data
	A: .word 10
	B: .word 20
	C: .word 30
	D: .word 40
	E: .word 50
	F: .word 60
	
	Alist: .word 10:80
	Blist: .word 20:250
	Clist: .word 30:20
	Dlist: .word 40:70

.text

main:
	
	la	$s0, A
	la	$s1, B
	la	$s2, C
	la	$s3, D
	la	$s4, E
	la	$s5, F
	
	lw	$t0, ($s0)
	lw	$t1, ($s1)
	lw	$t2, ($s2)
	lw	$t3, ($s3)
	lw	$t4, ($s4)
	lw	$t5, ($s5)
	
	# ===============================================================================================
	# Questao 1
	# ===============================================================================================
	
	# a) A = B - C
	sub	$t0, $t1, $t2	# Subtracao B-C
	sw	$t0, ($s0)	# Armazena o resultado no endereco de A
	
	
	# b) D = (A + B - C) 
	add	$t3, $t0, $t1	# Soma A+B
	sub	$t3, $t3, $t2	# Subtração (A+B)-C
	
	sw	$t3, ($s3)	# Armazena o resultado no endereco de D
	
	
	# c) F = (A + B) - D
	add	$t5, $t0, $t1	# Soma A+B
	sub	$t5, $t5, $t3	# Subtracao (A+B)-D
	
	sw	$t5, ($s5)	# Armazena o resultado no endereco de F
	
	
	# d) C = A - (B + D)
	add	$t2, $t1, $t3	# Soma B+D
	sub 	$t2, $t0, $t2	# Subtracao A-(B+D)
	
	sw	$t2, ($s2)	# Armazena o resultado no endereco de C
	
	
	# e) E = (A - (B - C) + F)
	sub 	$t4, $t1, $t2	# Subtracao B-C
	sub	$t4, $t0, $t4	# Subtracao A - (B-C)
	add	$t4, $t4, $t5	# Soma (A-(B-C)) + F
	
	sw	$t4, ($s4)	# Armazena o resultado no endereco de E
	
	
	# f) F = E – (A – B) * (B – C)
	sub	$t6, $t0, $t1	# Subtracao A-B (em registrador temporário)
	sub	$t5, $t1, $t2	# Subtracao B-C
	mul	$t5, $t6, $t5	# Multiplicacao (A-B) * (B-C)
	sub	$t5, $t4, $t5	# Subtracao E - (A-B) * (B-C)
	
	sw	$t5, ($s5)	# Aramzena o resultado no endereco de F
	
	
	# g) A = B[15] – C
	la	$s6, Blist	# Carrega o endereco da lista B
	
	li	$a0, 15		# Indice da lista B
	move	$a1, $s6	# Endereco da lista
	jal 	enderecador
	lw	$t6, ($v0)	# Carrega o valor no endereço B[15]
	
	sub	$t0, $t6, $t2	# Subtracao B[15]-C
	
	sw	$t0, ($s0)	# Armazena o resultado no endereco de A
	
	
	# h) B = A[5] + C[3]
	la	$s6, Alist	# Carrega o endereco da lista A
	la	$s7, Clist	# Carrega o endereco da lista C
	
	li	$a0, 5		# Indice da lista A
	move	$a1, $s6	# Endereco da lista A
	jal	enderecador	
	lw	$t6, ($v0)	# Carrega o valor de A[5]
	
	li	$a0, 3		# Indice da lista C
	move	$a1, $s7	# Endereco da lista C
	jal 	enderecador
	lw	$t7, ($v0)	# Carrega o valor de C[3]
	
	add	$t1, $t6, $t7	# Soma A[5] + C[3]
	
	sw 	$t1, ($s1)	# Armazena o resultado no endereco de B
	
	
	# i)  A[10] = B – C
	la	$s6, Alist	# Carrega o endereco da lista A
	
	li	$a0, 10		# Indice da lista A
	move	$a1, $s6	# Endereco da lista A
	jal	enderecador
	move	$s6, $v0	# Armazena o endereco do indice
	
	sub	$t6, $t1, $t2	# Subtracao B-C
	
	sw	$t6, ($s6)	# Armazena o resultado em A[10]
	
	
	# j)  B[245] = A + C
	la	$s6, Blist	# Carrega o endereco da lista B
	
	li	$a0, 245	# Indice da lista B
	move	$a1, $s6	# Endereco da lista B
	jal 	enderecador
	move	$s6, $v0	# Armazena o endereco do indice
	
	add	$t6, $t0, $t2	# Soma A+C
	
	sw	$t6, ($s6)	# Armazena o resultado em B[245]
	
	
	# k) A[45] = B – C + D[67]
	la	$s6, Alist	# Carrega o endereco da lista A
	la	$s7, Dlist	# Carrega o endereco da lista D
	
	li	$a0, 45		# Indice da lista A
	move	$a1, $s6	# Endereco base da lista A
	jal	enderecador
	move	$s6, $v0	# Armazena o endereco do indice
	
	li	$a0, 67		# Indice da lista D
	move	$a1, $s7	# Endereco base da lista D
	jal 	enderecador
	lw	$t7, ($v0)	# Carrega o valor de D[67]
	
	sub	$t6, $t1, $t2	# Subtracao B-C
	add	$t6, $t6, $t7	# Soma (B-C) + D[67]
	
	sw	$t6, ($s6)	# Armazena o resultado em A[45]
	
	
	# l)  A[79] = B – C[18] + D
	la	$s6, Alist	# Carrega o endereco base da lista A
	la	$s7, Clist	# Carrega o endereco base da lista C
	
	li	$a0, 79		# Indice da lista
	move	$a1, $s6	# Endereco da lista
	jal	enderecador	# Chamada de funcao
	move	$s6, $v0	# Passa o resultado para $s6
	
	li	$a0, 18		# Indice da lista C
	move	$a1, $s7	# Endereco da lista
	jal 	enderecador	# Chamada de funcao
	lw	$t7, ($s7)	# Carrega o valor de C[18]
		
	sub	$t6, $t1, $t7	# Subtracao B - C[18]
	add	$t6, $t6, $t3	# Soma (B - C[18]) + D
	
	sw	$t6, ($s6)	# Armazena o resultado em A[45]
	
	li	$v0, 10
	syscall			# Fecha o programa

enderecador:

	# $a0 -> Indice da lista
	# $a1 -> Endereco base da lista

	mul	$t9, $a0, 4	# Multiplica o indice desejado por 4
	add	$v0, $t9, $a1	# Soma endereco base + indice
	
	jr	$ra		# Retorna