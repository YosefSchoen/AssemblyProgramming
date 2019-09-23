.data
myList: .word 1, 9, 2, 4, 6, 7, 8

.text
la $a0, myList #storing array into a0
addi $a1, $zero, 7 #storing size in a1
addi $a2, $a0, 24 #address of last element in myList
addi $s0, $a1, 0 #I loop counter = a1 - 1

Iloop:
beq $s0, $zero, Output
add $s1, $a0, $zero # setting J loop counter to zero

j Jloop
JloopDone:
addi $s0, $s0, -1
j Iloop


Jloop:
beq $s1, $a2, JloopDone

lw $t0, 0($s1)
lw $t1, 4($s1)

slt $t2, $t1, $t0
beq $t2, 1, swap
swapDone:

addi $s1, $s1, 4
j Jloop


swap:
sw $t1, 0($s1) 
sw $t0, 4($s1)
j swapDone


Output:
addi $a2, $a2, 4
add $s0, $a0, $zero
addi $v0, $zero, 1

OPLoop:
beq $s0, $a2, end
lw $a0, 0($s0)
syscall

addi $s0, $s0, 4
j OPLoop
end:


