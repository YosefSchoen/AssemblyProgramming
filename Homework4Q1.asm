.text

#get user input
addi $v0, $zero, 5 #get first number
syscall
add $s0, $v0, $zero

addi $v0, $zero, 12 #get operation
syscall
add $s1, $v0, $zero

addi $v0, $zero, 5 #get second number
syscall
add $s2, $v0, $zero

beq $s1, '+', callAdd #will call the right function based on Op code
beq $s1, '*', callMul
beq $s1, '^', callExp

#call function based on user input
callAdd:
add $a0, $s0, $zero #save s0 and s2 into aurgument registers
add $a1, $s2, $zero
jal addition #jumping to adition function with aurgument registers

add $a0, $v0, $zero #return parameter is argument for print
j print

callMul:
add $a0, $s0, $zero #save s0 and s2 into aurgument registers
add $a1, $s2, $zero

jal multiply #call multiply



add $a0, $v0, $zero #return parameter is argument for print
j print

callExp:
add $a0, $s0, $zero #save s0 and s2 into aurgument registers
add $a1, $s2, $zero
jal exponent

add $a0, $v0, $zero #return parameter is argument for print
j print


#addition
addition:
add $v0, $a0, $a1 #take values from argument registers
jr $ra #returns to call addition with sum

#multiplication
multiply:
add $s0, $a0, $zero #remove arguments from a0 and a1 to s0 and s1
add $s1, $a1, $zero

#if s1 is negative multiply both value by -1 (can't have a negative iteratotor
slt $s2, $s1, $zero #check if s1 is negative
beq $s2, $zero, mulContinue #if s1 is not negative skip to mulContinue
sub $s0, $zero, $s0 #0 - x = -x and x*(-y) = -x*y
sub $s1, $zero, $s1

mulContinue:
add $s2, $zero, $zero #s2 will be an iterator
add $s3, $zero, $zero #s3 will hold result

mulLoop:
beq $s2, $s1, mullLoopDone #if s2 = s1 repeated addition is finished
 
addi $sp, $sp, -16 #saving s0, s1 and s2 to the stack and ra (the return adress)
sw $s0, 0($sp)
sw $s1, 4($sp)
sw $s2, 8($sp)
sw $ra 12($sp)

add $a0, $s3, $zero 
add $a1, $s0, $zero
 
jal addition #call addition

lw $s0, 0($sp) #loading from the stack back to the apropriate registers
lw $s1, 4($sp)
lw $s2, 8($sp)
lw $ra, 12($sp)
add $sp, $sp, 16
 
add $s3, $v0, $zero
addi $s2, $s2, 1 #incrementing s2 by 1
j mulLoop

mullLoopDone:
add $v0, $s3, $zero #put return value into v0
jr $ra 

#exponantion
exponent:
add $s0, $a0, $zero #remove arguments from a0 and a1 to s0 and s1
add $s1, $a1, $zero

add $s2, $zero, $zero #s2 will be an iterator
addi $s3, $zero, 1 #s3 will hold result

expLoop:
beq $s2, $s1, expLoopDone #if s2 = s1 repeated addition is finished
 
addi $sp, $sp, -16 #saving s0, s1 and s2 to the stack and ra (the return adress)
sw $s0, 0($sp)
sw $s1, 4($sp)
sw $s2, 8($sp)
sw $ra 12($sp)

add $a0, $s3, $zero 
add $a1, $s0, $zero
 
jal multiply #call multiply

lw $s0, 0($sp) #loading from the stack back to the appropriate registers
lw $s1, 4($sp)
lw $s2, 8($sp)
lw $ra, 12($sp)
add $sp, $sp, 16
 
add $s3, $v0, $zero #taking return value from add and storing it into s3 (result)
addi $s2, $s2, 1 #incrementing s2 by 1
j expLoop

expLoopDone:
add $v0, $s3, $zero #put return value into v0
jr $ra 

print:
addi $v0, $zero, 1
syscall

end:
