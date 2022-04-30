.data
	h: .byte 'H'
	q: .byte 'Q'
	n: .byte '9'
	p: .byte '+'
	
	HW: .asciiz "Hello, World!\n"
	
	s1: .asciiz " bottles of beer on the wall, "
	s2: .asciiz " bottles of beer.\n"
	s3: .asciiz "Take one down, pass it around, "
	s4: .asciiz " bottles of beer on the wall.\n\n"
	s5: .asciiz "1 bottle of beer on the wall, 1 bottle of beer.\n\nTake one down, pass it around, no more bottles of beer on the wall."
	
	sc: .space 1000

.text
	li $s6, 0 # Accumulator
	
	# Input source code
	li $v0, 8
	la $a0, sc
	li $a1, 1000
	syscall
	
	move $s0, $a0 # s0: sc address
	move $s1, $s0 # Ctr
	
	la $s2, h
	la $s3, q
	la $s4, n
	la $s5, p
	
	# Process source code
	While:
		sub $t0, $s1, $s0
		beq $t0, 1000, End
		
		lb $t1, ($s1)  # Load byte from current array element
		
		# 4 functions
		lb $t0, ($s2) # Load 'h' byte
		beq $t0, $t1, H
		lb $t0, ($s3) # Load 'q' byte
		beq $t0, $t1, Q
		lb $t0, ($s4) # Load '9' byte
		beq $t0, $t1, N
		lb $t0, ($s5) # Load '+' byte
		beq $t0, $t1, P
		
		j End
		
		Return:
		addi $s1, $s1, 1
		j While
		
	End:
		li $v0, 10
		syscall
		
	H:
		la $a0, HW
		li $v0, 4
		syscall
		j Return
		
	Q:
		la $a0, sc
		li $v0, 4
		syscall
		j Return
	
	N:
		li $t2, 99
		For:
			beq $t2, 0, ExitF
			
			li $v0, 1
			move $a0, $t2
			syscall
			li $v0, 4
			la $a0, s1
			syscall
			li $v0, 1
			move $a0, $t2
			syscall
			li $v0, 4
			la $a0, s2
			syscall
			
			subi $t2, $t2, 1
			
			li $v0, 4
			la $a0, s3
			syscall
			li $v0, 1
			move $a0, $t2
			syscall
			li $v0, 4
			la $a0, s4
			syscall
			j For
		ExitF:
		la $a0, s5
		syscall
			j Return
		
		P:
			addi $s6, $s6, 1
			j Return
		
