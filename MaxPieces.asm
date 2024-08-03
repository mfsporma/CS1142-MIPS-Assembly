# Name: Matthew Sporman
# User ISO: mfsporma
# Description: This program provides the maximum number of pieces 
# that can result from a given subdivision of a circular disk.

newline:
li $v0, 11        # syscall 11 prints chracter stored in $a0
addi $a0, $0, 10    # ASCII code 10 is a line feed
syscall

input:
li $v0, 5 # Syscall to read in user input to then store in $v0 register.
syscall

bltz $v0, exit # This will run the exit: loop portion of this program if input is negative.

move $t0, $v0 # Takes $v0 register and copies value to $t0 register.

addi $t1, $v0, 2 # Takes value from $v0 and adds 2 (n+2) writes to $t1 register.
mul $t2, $t0, $t0 # Takes value from $t0 and multiplies it by itself (n^2) writes to $t2 register.
add $t3, $t2, $t1 # n^2 calculation and adds them (n^2 + n +2) writes to $t3 register.
div $t4, $t3, 2 # n^2 + n + 2 calcuation and divides it by 2 and writes to $t4 register.

move $a0, $t4 # Copies the result from $t4 register to $a0 register to be printed to the console.
li $v0, 1 # This prints integer stored in register $a0
syscall

b newline
b input 

exit: # exit loop referenced in line 10.
	li $v0, 10 
	syscall