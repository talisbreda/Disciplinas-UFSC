.data

	a: .word 4
	b: .word 10
	val: .word 0

.text
main:

	lw	$a0, a
	lw	$a1, b
	jal 	calculaAreaQuadrado
	
	la	$s0, val
	sw	$v0, ($s0)
	
	li	$v0, 10
	syscall
	
calculaAreaQuadrado:
	# a0 -> h
	# a1 -> w
	
	mul 	$v0, $a0, $a1
	
	jr	$ra