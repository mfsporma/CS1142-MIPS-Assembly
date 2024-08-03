# Author:      Matthew Sporman
# Username:    mfsporma
# Description: Creates a two-dimensional matrix of integers by user input.

.data
# Allocate maximum possible matrix size and initializes all elements to 1
matrix: .space 1600
newline: .asciiz "\n"

.text

main:
    # Read in matrix size N from user
    li $v0, 5          # syscall for reading an integer
    syscall
    move $t0, $v0      # N is stored in $t0

    # Check if N is outside of the designated range [1, 40]
    li $t1, 1
    li $t2, 40
    blt $t0, $t1, exit # if N < 1 run exit section
    bgt $t0, $t2, exit # if N > 40 run exit section

    # Initialize the matrix elements to '1'
    li $t3, 1600       # total bytes to be initialized
    la $t4, matrix     # Matrix address is loaded into temp registry $t4
    li $t8, 49         # ASCII value for '1' from table
    
loop:
    beq $t3, $zero, coordinates
    sb $t8, 0($t4)     # store ASCII '1' at the address in $t4
    addi $t4, $t4, 1   # move to the next byte in the matrix
    subi $t3, $t3, 1   # decrement the byte count
    j loop

coordinates:
    # Read row coordinate
    li $v0, 5          # syscall for reading an integer
    syscall
    move $t5, $v0      # store row value in $t5

    # Check if row coordinate is out of range
    blt $t5, $zero, printmatrix
    bge $t5, $t0, printmatrix

    # Read column coordinate
    li $v0, 5          
    syscall
    move $t6, $v0      # store column value in $t6

    # Check if column coordinate is out of range
    blt $t6, $zero, printmatrix
    bge $t6, $t0, printmatrix

    # Set the specified matrix element to zero
    mul $t7, $t5, $t0  # row * N
    add $t7, $t7, $t6  # row * N + column
    li $t8, 1
    mul $t7, $t7, $t8 
    la $t9, matrix
    add $t9, $t9, $t7
    li $t8, 48         # ASCII value for '0'
    sb $t8, 0($t9)     # set the element to '0'

    # jump function to continue reading next coordinates
    j coordinates

printmatrix:
    # Prints the matrix row by row
    li $t5, 0          # row index
printrow:
    bge $t5, $t0, exit # if row index >= N, exit
    li $t6, 0          # column index

printcolumn:
    bge $t6, $t0, printnewline # if column index >= N, print newline
    mul $t7, $t5, $t0  # row * N
    add $t7, $t7, $t6  # row * N + column
    li $t8, 1
    mul $t7, $t7, $t8  
    la $t9, matrix
    add $t9, $t9, $t7
    lb $a0, 0($t9)     # load the matrix element
    li $v0, 11         
    syscall

    addi $t6, $t6, 1   # move to the next column
    j printcolumn

printnewline:
    li $v0, 4          
    la $a0, newline
    syscall

    addi $t5, $t5, 1   # move to next row
    j printrow

exit:
    li $v0, 10         # syscall for exit
    syscall