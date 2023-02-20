.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions (TODO):
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 75.
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 76.
# =======================================================
dot:
    # Prologue
    addi t1, zero, 1
    li t0, 75
    blt a2, t1, excep
    li t0, 76
    blt a3, t1, excep
    blt a4, t1, excep

    mv t0, zero # counter
    mv t1, zero # temp result
    slli a3, a3, 2
    slli a4, a4, 2

loop_start:
    lw t2, 0(a0)
    lw t3, 0(a1)
    mul t2, t2, t3
    add t1, t1, t2

    addi t0, t0, 1
    beq t0, a2, loop_end

    add a0, a0, a3
    add a1, a1, a4
    j loop_start

loop_end:
    mv a0, t1
    # Epilogue

    ret

excep:
    mv a1, t0
    j exit2
