# Tális Breda - 22102202
# Enzo Nicolás - 22100614

.data
	A: .word 0
	B: .word 10
	C: .word 0
	D: .word 20
	E: .word 10
		
.text
principal:
	la	$s0, A
	la	$s1, B
	la	$s2, C
	la	$s3, D
	la	$s4, E
	
	lw 	$t0, 0($s0)
	lw	$t1, 0($s1)
	addi	$t0, $t1, 35
	
	lw 	$t2, 0($s2)
	lw	$t3, 0($s3)
	sub	$t2, $t3, $t0
	
	lw	$t4, 0($s4)
	add 	$s5, $t2, $t4
	
	sw	$s5, 0($s2)