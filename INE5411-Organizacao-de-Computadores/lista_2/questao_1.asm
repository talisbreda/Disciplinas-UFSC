.data
	A: .word 10
	B: .word 20
	C: .word 30
	D: .word 40
	E: .word 50
	F: .word 60
	
	Alist: .word 0:80
	Blist: .word 1:250
	Clist: .word 2:20
	Dlist: .word 3:70

.text
enderecador:
	move	$t9, $a0
	mul	$t9, $t9, 4
	add	$t9, $t9, $a1
	
	

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
	
	sw	$t3, ($s3)	# Armazena o resultado no endereco de C
	
	
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
	la	$s6, Blist	# Carrega o endereco da lista A
	
	li	$t9, 15		# Indice da lista A
	mul	$t9, $t9, 4	# Multiplicacao por 4 para apontar para o endereco
	add	$s6, $s6, $t9	# Soma endereco base + indice
	lw	$t6, ($s6)	# Carrega o valor no endereço A[15]
	
	sub	$t0, $t6, $t2	# Subtracao B[15]-C
	
	sw	$t0, ($s0)	# Armazena o resultado no endereco de A
	
	
	# h) B = A[5] + C[3]
	la	$s6, Alist	# Carrega o endereco da lita A
	la	$s7, Clist	# Carrega o endereco da lista C
	
	li	$t9, 5		# Indice da lista A
	mul	$t9, $t9, 4	# Ajuste para endereco
	add	$s6, $s7, $t9	# Soma endereco base + indice
	lw	$t6, ($s6)	# Carrega o valor de A[5]
	
	li	$t9, 3		# Indice da lista C
	mul	$t9, $t9, 4	# Ajuste para endereco
	add	$s7, $s7, $t9	# Soma endereco base + indice
	lw	$t7, ($s7)	# Carrega o valor de C[3]
	
	add	$t1, $t6, $t7	# Soma A[5] + C[3]
	
	sw 	$t1, ($s1)	# Armazena o resultado no endereco de B
	
	
	# i)  A[10] = B – C
	la	$s6, Alist	# Carrega o endereco da lista A
	
	li	$t9, 10		# Indice da lista A
	mul	$t9, $t9, 4	# Ajuste para endereco
	add	$s6, $s6, $t9	# Soma endereco base + indice
	
	sub	$t6, $t1, $t2	# Subtracao B-C
	
	sw	$t6, ($s6)	# Armazena o resultado em A[10]
	
	
	# j)  B[245] = A + C
	la	$s6, Blist	# Carrega o endereco da lista B
	
	li	$t9, 245	# Indice da lista B
	mul 	$t9, $t9, 4	# Ajuste para endereco
	add	$s6, $s6 ,$t9	# Soma endereco base + indice
	
	add	$t6, $t0, $t2	# Soma A+C
	
	sw	$t6, ($s6)	# Armazena o resultado em B[245]
	
	
	# k) A[45] = B – C + D[67]
	la	$s6, Alist	# Carrega o endereco da lista A
	la	$s7, Dlist	# Carrega o endereco da lista D
	
	li	$t9, 45		# Indice da lista A
	mul	$t9, $t9, 4	# Ajuste para endereco
	add	$s6, $s6, $t9	# Soma endereco base + indice
	
	li	$t9, 67		# Indice da lista D
	mul	$t9, $t9, 4	# Ajuste para endereco
	add	$s7, $s7, $t9	# Soma endereco base + indice
	lw	$t7, ($s7)	# Carrega o valor de D[67]
	
	sub	$t6, $t1, $t2	# Subtracao B-C
	add	$t6, $t6, $t7	# Soma (B-C) + D[67]
	
	sw	$t6, ($s6)	# Armazena o resultado em A[45]
	
	
	# l)  A[79] = B – C[18] + D
	la	$s6, Alist	# Carrega o endereco base da lista A
	la	$s7, Clist	# Carrega o endereco base da lista C
	
	li	$t9, 45