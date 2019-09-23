.data


.text
loop:
li $v0, 5 #setting v0 to 5 for user input of a integer
syscall

slti $t0, $v0, 100 #cannot go above 99
beqz $t0, loop #will restart the loop if t0 is bigger than 99
slti $t1, $v0, -99 #cannot go below -99
addi $t1, $t1, -1 #subtracting 1 from t1 to make it equal zero if input is smaller than -99
beqz $t1,  loop #will restart the loop if t0 is smaller than -99
beqz $v0, exit #if v0 is zero program will stop
add $s1, $s1, $v0 #adding all values into s1
j loop
exit:

add $a0, $s1, $zero #printing result
li $v0, 1
syscall



