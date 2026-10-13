.data
my_matrix:  .word 1, 2, 3, 4
            .word 5, 12, 7, 8
            .word 9, 10, 11, 6
rows_num:   .byte 3
cols_num:   .byte 4

.text
main:
    la a0, my_matrix
    lb a1, rows_num     # M
    lb a2, cols_num     # N
    jal ra, fmi

    mv t0, a0
    mv t1, a1

    li a0, 1
    mv a1, t0
    ecall
    li a0, 11
    li a1, ' '
    ecall
    li a0, 1
    mv a1, t1
    ecall

    li   a0, 10
    ecall

# fmi - find max index
# аргументы:
#   a0 - адрес начала массива
#   a1 - rows_num
#   a2 - cols_num
# возврат: 
#   a0, a1 - [i][j] строка столбец максимального элемента
fmi:
    blez a1, fmi_empty  # if rows_num <= 0, значит массив пуст
    blez a2, fmi_empty

    mv t0, a0           # cur_p (указатель на текущий элемент)

    li t1, 0            # max_i
    li t2, 0            # max_j
    lw t3, 0(t0)        # max_el (по умолчанию [0][0])

    li t4, 0            # i = 0
    
fmi_rows_loop_start:                            # for (i = 0; i < rows_num; i++)
    bge t4, a1, fmi_end                         # if t4 >= a1 then go to end
    li t5, 0                                    # j = 0

fmi_cols_loop:                                  # for (j = 0; j < cols_num; j++)
    bge t5, a2, fmi_rows_loop_end

    lw t6, 0(t0)
    ble t6, t3, fmi_continue_without_change_max

    mv t3, t6                                   # max_el = *cur_p
    mv t1, t4                                   # max_i = i
    mv t2, t5                                   # max_j = j

fmi_continue_without_change_max:

    addi t0, t0, 4
    addi t5, t5, 1                              # j++

    j fmi_cols_loop

fmi_rows_loop_end:
    addi t4, t4, 1                              # i++
    j fmi_rows_loop_start

fmi_end:
    mv a0, t1
    mv a1, t2
    ret

fmi_empty:
    li a0, -1
    li a1, -1
    ret

