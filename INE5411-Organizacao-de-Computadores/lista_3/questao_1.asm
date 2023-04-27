#1) Converta as linhas de instruções escritas em linguagem C para instruções em Assembly do MIPS.
#Considere que:

# – As variáveis indicadas A = 10, B = 15, C = 20, D = 25, E = 30 e F = 35 foram todas armazenadas
#previamente na memória de dados. Use os registradores de $s0 até $s5 para manipular os dados.

# – Os vetores G e H possuem quatro posições cada e inicializam com zeros em suas posições
#(words). Use os registradores $s6 e $s7 para manipular estas posições.

# – Implemente as linhas de instruções abaixo como sendo linhas de um mesmo programa.

.data
	A: .word 10
	B: .word 15
	C: .word 20
	D: .word 25
	E: .word 30
	F: .word 35
	
	G: .word 0:4
	H: .word 0:4

.text

main:
	
	la	$s0, A
	la	$s1, B
	la	$s2, C
	la	$s3, D
	la	$s4, E
	la	$s5, F
	la	$s6, G
	la	$s7, H
	
	lw	$t0, ($s0)
	lw	$t1, ($s1)
	lw	$t2, ($s2)
	lw	$t3, ($s3)
	lw	$t4, ($s4)
	lw	$t5, ($s5)
	
	# =============================================================
	# a) G[0] = (A – (B + C) + F);
	add	$t6, $t1, $t2	# B+C
	sub	$t6, $t0, $t6	# A-(B+C)
	add	$t6, $t6, $t5	# (A-(B+C)) + F
	
	sw	$t6, ($s6)	# Armazena o resultado em G[0]
	
	# =============================================================
	# b)  G[1] = E – (A – B) * (B – C);
	sub	$t6, $t0, $t1	# A-B
	sub	$t7, $t1, $t2	# B-C (temporária)
	mul	$t6, $t6, $t7	# (A-B) * (B-C)
	sub	$t6, $t4, $t6	# E - ((A-B) * (B-C))
	
	sw	$t6, 4($s6)
	
	# =============================================================
	# c) G[2] = G[1] – C;
	lw	$t7, 4($s6)	# Carrega o valor de G[1]
	sub	$t6, $t7, $t2	# G[1] - C
	
	sw	$t6, 8($s6)	# Armazena o resultado em G[2]
	
	# =============================================================
	# d) G[3] = G[2] + G[0];
	lw	$t7, 8($s6)	# Carrega o valor de G[2]
	lw	$t8, 0($s6)	# Carrega o valor de G[0]
	
	add	$t6, $t7, $t8	# G[2] + G[0]
	
	sw	$t6, 12($s6)	# Armazena o resultado em G[1]
	
	# =============================================================
	# e)  H[0] = B – C;
	sub	$t6, $t1, $t2	# B-C
	
	sw	$t6, 0($s7)	# Armazena o resultado em G[0]
	
	# =============================================================
	# f) H[1] = A + C;
	add	$t6, $t0, $t2	# A+C
	
	sw	$t6, 4($s7)	# Armazena o resultado em H[1]
	
	# =============================================================
	# g)  H[2] = B – C + G[3];
	lw	$t7, 12($s6)	# Carrega o valor de G[3]
	
	sub	$t6, $t1, $t2	# B-C
	add	$t6, $t6, $t7	# (B-C) + G[3]
	
	sw	$t6, 8($s7)	# Armazena o resultado em H[2]
	
	# =============================================================
	# h)  H[3] = B – G[0] + D;
	lw	$t7, 0($s6)	# Carrega o valor de G[0]
	
	sub	$t6, $t1, $t7	# B - G[0]
	add	$t6, $t6, $t3	# (B - G[0]) + D
	
	sw	$t6, 12($s7)	# Armazena o resultado em H[3]
