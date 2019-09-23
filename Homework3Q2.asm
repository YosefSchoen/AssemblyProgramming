.data
sequence: .byte 3, 9, 27, 82
notAProgression: .asciiz "Not a progression"
d: .asciiz "d = "
q: .asciiz "q = "


.text
la $a0, sequence #loading the sequence into a0
lb $a0, 0($a0)
addi $v0, $zero, 1 #printing the first term
syscall
la $a0, sequence

addi $a1, $zero, 4 #loading the size int a1
add $a2, $a0, $a1 #loading the address of the last element into a2
addi $a2, $a2, -2 #loading the address of the 3rd to last element into a2


arthmitic:
add $s0 ,$a0, $zero #initializing s0 as a pointer to the sequence in a0

arthmiticLoop:
beq $s0, $a2, arthmiticOP
lb $t0, 0($s0)
lb $t1, 1($s0)
lb $t2, 2($s0)

sub $t0, $t1, $t0 
sub $t1, $t2, $t1
bne $t0, $t1, geometric

addi $s0, $s0, 1
j arthmiticLoop

geometric:
add $s0, $a0, $zero #initializing s0 as a pointer to the sequence in a0

geometricLoop:
beq $s0, $a2, geometricOP
lb $t0, 0($s0)
lb $t1, 1($s0)
lb $t2, 2($s0)

div $t1, $t0
mfhi $t3 #remainder of t1/t0
mflo $t4 #quotient of t1/t0

div $t2, $t1
mfhi $t5 #remainder of t2/t1
mflo $t6 #quotient of t2/t1

bnez $t3, noSequence
bnez $t5, noSequence
bne $t4, $t6, noSequence

addi $s0, $s0, 1
j geometricLoop

arthmiticOP:
addi $s1, $zero, 1
la $a0, d
addi $v0, $zero, 4
syscall

add $a0, $t0, $zero
addi $v0, $zero, 1
syscall

la $a0, sequence

j geometric

geometricOP:
addi $s2, $zero, 1
la $a0, q
addi $v0, $zero, 4
syscall

add $a0, $t4, $zero
addi $v0, $zero, 1
syscall

la $a0, sequence

j end

noSequence:
beq $s1, 1, end
beq $s2, 1, end

noSequenceOP:
addi $v0, $zero, 4
la $a0, notAProgression
syscall

end:
