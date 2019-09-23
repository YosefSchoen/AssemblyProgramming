.data
getValue:.asciiz " ENTER VALUE"
getOpCode:.asciiz "ENTER OP-CODE"
Result:.asciiz "The result is"
Overflow:.asciiz "Overflow detected"

.text
la $a0, getValue #loading instruction for user
addi $v0, $zero, 4 #setting $v0 to 4 to write a string
syscall

addi $v0, $zero, 5 #setting $v0 to 5 to read an integer
syscall
add $a1, $v0, $zero #setting the user's integer to $a1

start:
la $a0, getOpCode #loading instruction for user
addi $v0, $zero, 4 #setting $v0 to 4 to write a string
syscall

addi $v0, $zero, 12 #setting $v0 to 8 to read a string
syscall
add $a2, $v0, $zero #setting the user's Op Code to $a2


beq $a2, '+', addition # checking which Op Code the user wrote and jumping to correct place
beq $a2, '-', subtract
beq $a2, '*', multiply
beq $a2, '@', end



addition:
la $a0, getValue #loading instruction for user
addi $v0, $zero, 4 #setting $v0 to 4 to write a string
syscall

addi $v0, $zero, 5 #setting $v0 to 5 to read an integer
syscall
add $a3, $v0, $zero #setting the user's integer to $a3

add $a1, $a1, $a3 #adding the user's 2 number
j end

subtract:
la $a0, getValue #loading instruction for user
addi $v0, $zero, 4 #setting $v0 to 4 to write a string
syscall

addi $v0, $zero, 5 #setting $v0 to 5 to read an integer
syscall
add $a3, $v0, $zero #setting the user's integer to $a3

sub $a1, $a1, $a3 #subtracting the user's 2 numbers
j end #jumping to the end

multiply:
la $a0, getValue #loading instruction for user
addi $v0, $zero, 4 #setting $v0 to 4 to write a string
syscall

addi $v0, $zero, 5 #setting $v0 to 5 to read an integer
syscall
add $a3, $v0, $zero #setting the user's integer to $a3

mult $a1, $a3 #multiplying the user's 2 numbers
mflo $a1
mfhi $t0

slti $t1, $a1, 0
beq $t1, 0, positive
beq $t1, 1, negative


positive:
beq $t0, 0, end
j overflow

negative:
beq $t0, -1, end
j overflow

overflow:
la $a0, Overflow
addi $v0, $zero, 4
syscall

j exit


end:
bne $a2, '@', start
la $a0, Result #loading text for user
addi $v0, $zero, 4 #setting $v0 to 4 to write a string
syscall

add $a0, $a1, $zero #loading $a1 to be printed to user
addi $v0, $zero, 1 #setting $v0 to 4 to write an integer
syscall

exit:


