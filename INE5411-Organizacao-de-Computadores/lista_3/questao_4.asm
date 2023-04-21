# Modifique o programa anterior fazendo o acesso à memória de forma indexada. Isto é, assumindo
# que o registrador $s0 contém o valor 0x10010020, faça um programa que contenha a sequência de
# instruções MIPS correspondentes às instruções C seguintes:
# i = 0;
# v[i] = 1;
# i = i + 1;
# v[i] = 3;
# i = i + 1;
# v[i] = 2;
# i = i + 1;
# v[i] = 1;
# i = i + 1;
# v[i] = 4;
# i = i + 1;
# v[i] = 5;


.data

.text
main:
	li	$s0, 0x10010020
	
	li	$a0, 1
	jal 	armazena
	
	li	$a0, 3
	jal	armazena
	
	li	$a0, 2
	jal	armazena
	
	li	$a0, 1
	jal	armazena
	
	li	$a0, 4
	jal 	armazena
	
	li	$a0, 5
	jal	armazena
	
	li	$v0, 10
	syscall


armazena:
	# $a0 -> número a ser armazenado
	sw	$a0, ($s0)
	addi	$s0, $s0, 4
	
	jr	$ra