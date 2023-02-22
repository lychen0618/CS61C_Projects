.globl classify

.text
classify:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0 (int)    argc
    #   a1 (char**) argv
    #   a2 (int)    print_classification, if this is zero, 
    #               you should print the classification. Otherwise,
    #               this function should not print ANYTHING.
    # Returns:
    #   a0 (int)    Classification
    # Exceptions:
    # - If there are an incorrect number of command line args,
    #   this function terminates the program with exit code 89.
    # - If malloc fails, this function terminats the program with exit code 88.
    #
    # Usage:
    #   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>

    li t0, 5
    bne a0, t0, exit89

    addi sp, sp, -52
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)

    sw s3, 16(sp) # m0 r
    sw s4, 20(sp) # m0 c

    sw s5, 24(sp) # m1 r
    sw s6, 28(sp) # m1 c

    sw s7, 32(sp) # addr m0
    sw s8, 36(sp) # addr m1

    sw s9, 40(sp) # input r
    sw s10, 44(sp) # input c

    sw s11, 48(sp) # addr input

    mv s0, a0
    addi s1, a1, 4
    mv s2, a2

	# =====================================
    # LOAD MATRICES
    # =====================================


    # Load pretrained m0
    lw a0, 0(s1)
    addi sp, sp, -8
    sw zero, 0(sp)
    sw zero, 4(sp)
    addi a1, sp, 0
    addi a2, sp, 4
    jal read_matrix
    mv s7, a0
    lw s3, 0(sp)
    lw s4, 4(sp)
    addi sp, sp, 8

    # Load pretrained m1
    lw a0, 4(s1)
    addi sp, sp, -8
    sw zero, 0(sp)
    sw zero, 4(sp)
    addi a1, sp, 0
    addi a2, sp, 4
    jal read_matrix
    mv s8, a0
    lw s5, 0(sp)
    lw s6, 4(sp)
    addi sp, sp, 8

    # Load input matrix
    lw a0, 8(s1)
    addi sp, sp, -8
    sw zero, 0(sp)
    sw zero, 4(sp)
    addi a1, sp, 0
    addi a2, sp, 4
    jal read_matrix
    mv s11, a0
    lw s9, 0(sp)
    lw s10, 4(sp)
    addi sp, sp, 8

    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)
    mul a0, s3, s10
    slli a0, a0, 2
    jal malloc
    beq a0, zero, exit88

    addi sp, sp, -4
    sw a0, 0(sp)

    mv a6, a0
    mv a0, s7
    mv a1, s3
    mv a2, s4
    mv a3, s11
    mv a4, s9
    mv a5, s10

    jal matmul
    
    lw a0, 0(sp)
    mul a1, s3, s10
    jal relu

    mul a0, s5, s10
    slli a0, a0, 2
    jal malloc
    beq a0, zero, exit88

    addi sp, sp, -4
    sw a0, 0(sp)
    
    mv a0, s8
    mv a1, s5
    mv a2, s6
    lw a3, 4(sp)
    mv a4, s3
    mv a5, s10
    lw a6, 0(sp)

    jal matmul
    
    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
    lw a0, 12(s1)
    lw a1, 0(sp)
    mv a2, s5
    mv a3, s10
    jal write_matrix

    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
    lw a0, 0(sp)
    mul a1, s5, s10
    jal argmax
    mv s0, a0

    # Print classification
    bne s2, zero, free_mem
    mv a1, a0
    jal print_int
    # Print newline afterwards for clarity
    li a1, '\n'
    jal print_char

free_mem:
    lw a0, 0(sp)
    jal free
    lw a0, 4(sp)
    jal free
    addi sp, sp, 8

    # output
    mv a0, s0

    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    lw s6, 28(sp)
    lw s7, 32(sp)
    lw s8, 36(sp)
    lw s9, 40(sp)
    lw s10, 44(sp)
    lw s11, 48(sp)
    addi sp, sp, 52

    ret

exit88:
    li a1, 88
    j exit2

exit89:
    li a1, 89
    j exit2