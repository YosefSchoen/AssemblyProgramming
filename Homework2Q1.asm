.data
list: .byte 3, 1, 2, 5, 13, 8, 1, 2 #making an array

.text
la $a0, list
addi $a1, $zero, 8 #size of array is 6
lb $s0, 0($a0) #first element is in s0

loop:
beq $a1, 1, end #go to end if a1 reaches last element
lb $t0, 1($a0)#loading next value into t0
slt $t1, $s0, $t0 #setting t1 to 1 if s0 is less than t0
beq $t1, 1, newLargest #if s0 is smaller go to newLargest
endOfLoop:
addi $a0, $a0, 1 #shift a0 to next element
addi $a1, $a1, -1 #subtract 1 from a1
j loop # go to begining of loop

newLargest:
add $s0, $t0, $zero #set t0 to be new Largest number
j endOfLoop #go to end of loop

end:
add $a0, $s0, $zero #print result
addi $v0, $zero, 1
syscall
