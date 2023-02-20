.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 77.
# =================================================================
argmax:
    # Prologue

    addi t1, zero, 1
    blt a1, t1, excep
    mv t0, zero # counter
    mv t1, zero # max index
    lw t2, 0(a0) # max value

loop_start:
    lw t3, 0(a0)
    bge t2, t3, loop_continue
    mv t1, t0
    mv t2, t3

loop_continue:
    addi t0, t0, 1
    beq t0, a1, loop_end
    addi a0, a0, 4
    j loop_start

loop_end:
    mv a0, t1
    # Epilogue

    ret

excep:
    li a1, 77
    j exit2