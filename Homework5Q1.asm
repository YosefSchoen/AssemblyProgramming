.data 
mylist: .byte 1, 3, -2, 5, 4, -7, 6, 9, -8, 1, 1, 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
code: .word 0,0,0,0,0,0
True: .asciiz "True"
False: .asciiz  "False"

.text
la $a0, mylist #storing myList into a0
addi $a1, $zero, 22 #storing size of myList (9) into a1
la $a2, code #storing code into a2

getIP:
add $s0, $a2, $zero #loading the address code into s0
addi $s1, $a2, 24 #loading the size of code 6 * 4 = 24


IPLoop:
beq $s0, $s1, IPLoopDone #if the s0 = s2 all 6 values were inputted
addi $v0, $zero, 5 #user will input value into v0
syscall

sw $v0, 0($s0) #storing the user inputted int into s0 from v0
addi $s0, $s0, 4 #incrementing s0 for next int to be read
j IPLoop


IPLoopDone:
add $s0, $a0, $zero #storing the address of the first element myList
add $s1, $a0, $a1, #storing the address of the last element myList
add $s1, $s1, -5 #the address of the last element myList - 6
j iLoop #jumping to the outer loop (iLoop)


iLoop:
beq $s0, $s1, print # if code is up to the last element jump to print result

addi $sp, $sp, -8 #making space in the stack
sw $s0, 0($sp) #storing values of s0, and s1 into the stack
sw $s1, 4($sp)

add $a0, $s0, $zero #storing the value of s0 into an argument register a0
la $a1, code #storing the code into argument register a1
jal jLoopFunction #jumping (and linking) to the inner loop (jLoop)

beq $v0, 1, print #if jLoop returns true were done

lw $s0, 0($sp) #unloading the values of s0 and s2 to the stack
lw $s1, 4($sp)
addi $sp, $sp, 8

add $s0, $s0, 1 #go to next element
j iLoop


jLoopFunction:
add $s0, $a0, $zero #parameters come from a0 and a1
add $s1, $a1, $zero #storing the parameters into s0 and s1
addi $s2, $s1, 24 #address of the last element
addi $v0, $zero, 1 #assume return value is true until proven false

jLoop:
beq $s1, $s2, jLoopDone #if s1 reaches s2 the inner loop is done

lb $t0, 0($s0) #load the current value of my list
lw $t1, 0($s1) #load the current value of code

bne $t0, $t1, fail #if the code does not match myList branch to fail

addi $s0, $s0, 1 #increment s0
addi $s1, $s1, 4 #increment s1
j jLoop

jLoopDone:
jr $ra #return back to where jLoop function was called (iLoop)

fail:
add $v0, $zero, $zero #if the code failed to match set v0 to 0
j jLoopDone #jump to jLoop done

print:
la $s0, code #loading code into s0
add $s2, $v0, $zero #whether or not code is found in myList
addi $s1, $s0, 24
addi $v0, $zero, 1


printLoop:
beq $s0, $s1, printLoopDone
lw $a0, 0($s0)
syscall

addi $s0, $s0, 4
j printLoop


printLoopDone:
addi $v0, $zero, 4 
beq $s2, 1, printTrue #if the code was correct it will branch to print true
beq $s2, 0, printFalse #if the code was incorrect it will branch to print false

printTrue: #will output true if program branches here
la $a0, True #loading string to print
syscall #printing
j end

printFalse: #will output false if program branches here
la $a0, False #loading string to print
syscall #printing
j end

end:
