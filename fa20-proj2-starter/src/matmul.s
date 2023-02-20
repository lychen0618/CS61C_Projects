.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 72.
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 73.
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 74.
# =======================================================
matmul:
    # Error checks
    addi t0, zero, 72
    bge zero, a1, excep
    bge zero, a2, excep
    addi t0, zero, 73
    bge zero, a4, excep
    bge zero, a5, excep
    addi t0, zero, 74
    bne a2, a4, excep

    # Prologue
    addi sp, sp, -28
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s5, 20(sp)
    sw s6, 24(sp)

    mv t0, zero # out_counter
    mv t1, zero # in_counter

    mv s0, a0
    mv s1, a1
    mv s2, a2
    mv s3, a3
    mv s5, a5
    mv s6, a6

outer_loop_start:
    mv t1, zero

inner_loop_start:
    mv a0, s0
    mv a1, t1
    slli a1, a1, 2
    add a1, a1, s3
    mv a2, s2
    li a3, 1
    mv a4, s5

    addi sp, sp, -8
    sw t0, 0(sp)
    sw t1, 4(sp)
    jal dot
    lw t0, 0(sp)
    lw t1, 4(sp)
    addi sp, sp, 8

    sw a0, 0(s6)
    addi s6, s6, 4

    addi t1, t1, 1
    beq t1, s5, inner_loop_end
    j inner_loop_start

inner_loop_end:
    addi t0, t0, 1
    beq t0, s1, outer_loop_end
    slli t2, s2, 2
    add s0, s0, t2
    j outer_loop_start

outer_loop_end:
    # Epilogue
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    addi sp, sp, 28
    
    ret

excep:
    mv a0, t0
    ecall