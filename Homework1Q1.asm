.data
myarray: .word 1,1,1,1,1,1,1,1,1,1,1,1,1,0
newarray: .word


.text
la $a0, myarray #loading my array into a0
la $a1, newarray #loading the new array intp a1
li $v0, -1 #starting v0 at -1

loopstart: #loop will count every time a value is copied into a1
addi $v0, $v0, 1
lw $t0, 0($a0)
sw $t0, 0($a1)
addi $a0, $a0, 4
addi $a1, $a1, 4
bnez  $t0, loopstart

add $a0, $v0 $zero
addi $v0, $zero, 1
syscall


