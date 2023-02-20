.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 78.
# ==============================================================================
relu:
    # Prologue

    addi t1, zero, 1
    blt a1, t1, excep

    mv t0, zero # counter

loop_start:
    lw t1, 0(a0)
    bge t1, zero, loop_continue
    sw zero, 0(a0)

loop_continue:
    addi t0, t0, 1
    beq t0, a1, loop_end
    addi a0, a0, 4
    j loop_start

loop_end:
    # Epilogue

	ret

excep:
    addi a0, x0, 78
    ecall