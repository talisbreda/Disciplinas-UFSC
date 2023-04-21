# Reproduza cada uma das expressões escritas em linguagem de alto nível a seguir para Assembly do
# MIPS. Considerações:
#  – As variáveis a e b são posições de memória (segmento de dados). Os valores (inteiros positivos)
# dessas variáveis devem ser informados pelo usuário via teclado.
#  – Implemente pequenos programas, um para cada expressão abaixo.
# a) if (a > b)
# a = a + 1;

# b) if (a ? b)
.text
main:
	# Le o valor de a
	li	$v0, 5
	syscall
	move	$s0, $v0
	
	# Le o valor de b
	li	$v0, 5
	syscall
	move	$s1, $v0
	
questao_a:
	ble	$s0, $s1, questao_b	# se a <= b, continua
	addi	$s0, $s0, 1		# senão, a = a + 1

questao_b:
	blt	$s0, $s1, questao_c	# se a < b, continua
	addi	$s1, $s1, 1		# senão, b = b + 1
	
questao_c:
	bgt	$s0, $s1, questao_d	# se a > b, continua
	addi	$s0, $s0, 1		# senão, a = a + 1

questao_d:
	bne	$s0, $s1, questao_e	# se a != b, continua
	move	$s1, $s0		# senão, b = a

questao_e:
	bge	$s0, $s1, else		# se a >= b, continua
	addi	$s0, $s0, 1		# senão, a = a+1
	j	questao_f
else:
	addi	$s1, $s1, 1		# se a >= b, b = b + 1

questao_f:
	li	$s0, 0	# a = 0
	li	$s1, 0 	# b = 0
	li	$s2, 5	# c = 5
	
f_loop:
	addi	$s0, $s0, 1	# a = a + 1
	addi	$s1, $s1, 2	# b = b + 2
	
	blt	$s0, $s2, f_loop	# se a < b, continua o loop

questao_g:
	li	$s0, 1		# a = 1
	li	$s1, 2		# b = 2
	
	li	$t0, 0		# i = 0

g_loop:
	addi	$s0, $s1, 1	# a = b + 1
	addi	$s1, $s1, 3	# b = b + 3
	
	addi	$t0, $t0, 1	# i = i + 1
	blt	$t0, 5, g_loop	# se i < 5, continua o loop

questao_h:
	beq	$s0, 1, case_1	# se a = 1, vai para o caso 1
	beq	$s0, 2, case_2 	# se a = 2, vai para o caso 2
	move	$s1, $s2	# caso default, b = c
	j	h_end

case_1:
	addi	$s1, $s2, 1	# a = b + 1
	j	h_end

case_2:
	addi	$s1, $s2, 2	# b = c + 1
	j	h_end

h_end:
	# Fim do programa
	li	$v0, 10
	syscall
	