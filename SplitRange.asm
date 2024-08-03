# Name: Matthew Sporman
# User ISO: mfsporma
# Description: This program reads in two integers S and E.
# S and E are the starting and ending values of a range of integers.

# Syscall for S
li $v0, 5
syscall
move $t0, $v0 # Takes first user input (S) puts it in ($v0) and copies to $t0 register.
move $s0, $v0

# Syscall for E
li $v0, 5
syscall
move $t1, $v0 # Takes second user input (E) puts it in $v0 and copies to $t1 register.
move $s1, $v0

# If E < S, run exit: loop
blt $t1, $t0, exit

# Initialize count of integers
li $t3, 0

incrementloop:
move $a0, $t0 # Copies S ($t0) to $a0 register to be printed via syscall
li $v0, 1
syscall

# Print a space
li $v0, 11 # syscall 11 prints character stored in $a0
addi $a0, $0, 32 # ASCII code 32 is a space
syscall

# Increment count of integers
addi $t3, $t3, 1

addi $t0, $t0, 1 # Increments S by 1 to then be printed again via syscall in incrementloop

blt $t1, $t0, printcount # This will cause exit: loop to run if $t1 register is smaller than $t0 register

b incrementloop # Runs incrementloop function until exit condition met.

# Print a line feed after printing integers
li $v0, 11 # syscall 11 prints character stored in $a0
addi $a0, $0, 10 # ASCII code 10 is a line feed
syscall

printcount:
# Print a newline character to move to the next line
li $v0, 11 # syscall 11 prints character stored in $a0
addi $a0, $0, 10 # ASCII code 10 is a line feed
syscall

move $a0, $t3 # Takes count value in $t3 and puts it in $a0 register to be printed via syscall
li $v0, 1
syscall

# Print a newline character to move to the next line
li $v0, 11 # syscall 11 prints character stored in $a0
addi $a0, $0, 10 # ASCII code 10 is a line feed
syscall

# Syscall for X number of Chunks
li $v0, 5
syscall
move $t4, $v0

# If chunk is <= 0, run exit: loop
blez $t4, exit

div $t3, $t4
mfhi $t5
mflo $t6

# Print big chunks
move $t7, $t6  # Set $t7 to the quotient
addi $t7, $t7, 1  # Increment quotient by 1 for big chunks

move $t0, $s0  # Set the starting value for chunks

bigchunkloop:
    bgtz $t5, printbigchunk # If remainder is positive, print big chunks
    j printsmallchunk # Otherwise, jump to printing small chunks
    
printbigchunk:
    move $t9, $t7  # Set $t9 to the quotient for big chunks
    addi $t5, $t5, -1  # Decrement remainder
    printchunk:
        bgtz $t9, printnumber # If quotient is positive, print number
        j incrementbigchunk # Otherwise, increment big chunk counter
    
    printnumber:
        # Print numbers
        move $a0, $t0  # Move current value to $a0
        li $v0, 1
        syscall
        
        # Print a space
        li $v0, 11
        addi $a0, $0, 32
        syscall
        
        # Increment current value
        addi $t0, $t0, 1
        
        # Decrement chunk size
        addi $t9, $t9, -1
        j printchunk
        
    incrementbigchunk:
        # Print a line feed after printing big chunk
        li $v0, 11 # syscall 11 prints character stored in $a0
        addi $a0, $0, 10 # ASCII code 10 is a line feed
        syscall
        j bigchunkloop

printsmallchunk:
    move $t9, $t6  # Set $t9 to the remainder for small chunks
    
    printchunksmall:
        beqz $t9, exit  # Exit loop if quotient is 0
        # Print numbers
        move $a0, $t0  # Move current value to $a0
        li $v0, 1
        syscall
        
        # Print a space
        li $v0, 11
        addi $a0, $0, 32
        syscall
        
        # Increment current value
        addi $t0, $t0, 1
        
        # Decrement chunk size
        addi $t9, $t9, -1
        j printchunksmall

# Exit the program
exit:
li $v0, 10
syscall
