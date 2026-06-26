.data
__t0: .word 0
__t1: .word 0
__t2: .word 0
__t3: .word 0
__t4: .word 0
__t5: .word 0
__t6: .word 0
__t7: .word 0
__t8: .word 0
__t9: .word 0
__t10: .word 0
__t11: .word 0
__t12: .word 0
__t13: .word 0
__t14: .word 0
__t15: .word 0
__t16: .word 0
__t17: .word 0
__t18: .word 0
__t19: .word 0
__t20: .word 0
__t21: .word 0
__t22: .word 0
__t23: .word 0
__t24: .word 0
__t25: .word 0
__t26: .word 0
__t27: .word 0
__t28: .word 0
__t29: .word 0
__t30: .word 0
__t31: .word 0
__t32: .word 0
__t33: .word 0
__t34: .word 0
__t35: .word 0
__t36: .word 0
__t37: .word 0
__t38: .word 0
__t39: .word 0
__t40: .word 0
__t41: .word 0
__t42: .word 0
__t43: .word 0
__t44: .word 0
i: .word 0
__t45: .word 0
var_j: .word 0
__t46: .word 0
__t47: .word 0
__t48: .word 0
__t49: .word 0
__t50: .word 0
__t51: .word 0
__t52: .word 0
__t53: .word 0
__t54: .word 0
__t55: .word 0
__t56: .word 0
__t57: .word 0
__t58: .word 0
__t59: .word 0
__t60: .word 0
__t61: .word 0
__t62: .word 0
__t63: .word 0
__t64: .word 0
__t65: .word 0
m: .word 0:9
str0: .asciiz "m["
str1: .asciiz "]["
str2: .asciiz "] = "
str3: .asciiz "\n"

.text
.globl main
main:
subu $sp, $sp, 32
sw $ra, 28($sp)
li $t0, 0
la $t9, __t0
sw $t0, 0($t9)
li $t0, 0
la $t9, __t1
sw $t0, 0($t9)
li $t0, 0
la $t9, __t2
sw $t0, 0($t9)
li $t0, 0
la $t9, __t3
sw $t0, 0($t9)
li $t0, 0
la $t9, __t4
sw $t0, 0($t9)
li $t0, 0
la $t9, __t5
sw $t0, 0($t9)
li $t0, 0
la $t9, __t6
sw $t0, 0($t9)
li $t0, 0
la $t9, __t7
sw $t0, 0($t9)
li $t0, 0
la $t9, __t8
sw $t0, 0($t9)
li $t8, 0
li $t9, 3
mul $t8, $t8, $t9
li $t9, 0
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
la $t9, __t0
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t8, 0
li $t9, 3
mul $t8, $t8, $t9
li $t9, 1
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
la $t9, __t1
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t8, 0
li $t9, 3
mul $t8, $t8, $t9
li $t9, 2
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
la $t9, __t2
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t8, 1
li $t9, 3
mul $t8, $t8, $t9
li $t9, 0
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
la $t9, __t3
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t8, 1
li $t9, 3
mul $t8, $t8, $t9
li $t9, 1
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
la $t9, __t4
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t8, 1
li $t9, 3
mul $t8, $t8, $t9
li $t9, 2
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
la $t9, __t5
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t8, 2
li $t9, 3
mul $t8, $t8, $t9
li $t9, 0
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
la $t9, __t6
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t8, 2
li $t9, 3
mul $t8, $t8, $t9
li $t9, 1
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
la $t9, __t7
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t8, 2
li $t9, 3
mul $t8, $t8, $t9
li $t9, 2
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
la $t9, __t8
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t0, 0
la $t9, __t9
sw $t0, 0($t9)
li $t0, 0
la $t9, __t10
sw $t0, 0($t9)
la $t9, __t9
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t10
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
lw $t0, 0($t8)
la $t9, __t11
sw $t0, 0($t9)
li $t0, 1
la $t9, __t12
sw $t0, 0($t9)
la $t9, __t9
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t10
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
la $t9, __t12
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t0, 0
la $t9, __t13
sw $t0, 0($t9)
li $t0, 1
la $t9, __t14
sw $t0, 0($t9)
la $t9, __t13
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t14
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
lw $t0, 0($t8)
la $t9, __t15
sw $t0, 0($t9)
li $t0, 2
la $t9, __t16
sw $t0, 0($t9)
la $t9, __t13
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t14
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
la $t9, __t16
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t0, 0
la $t9, __t17
sw $t0, 0($t9)
li $t0, 2
la $t9, __t18
sw $t0, 0($t9)
la $t9, __t17
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t18
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
lw $t0, 0($t8)
la $t9, __t19
sw $t0, 0($t9)
li $t0, 3
la $t9, __t20
sw $t0, 0($t9)
la $t9, __t17
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t18
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
la $t9, __t20
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t0, 1
la $t9, __t21
sw $t0, 0($t9)
li $t0, 0
la $t9, __t22
sw $t0, 0($t9)
la $t9, __t21
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t22
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
lw $t0, 0($t8)
la $t9, __t23
sw $t0, 0($t9)
li $t0, 4
la $t9, __t24
sw $t0, 0($t9)
la $t9, __t21
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t22
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
la $t9, __t24
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t0, 1
la $t9, __t25
sw $t0, 0($t9)
li $t0, 1
la $t9, __t26
sw $t0, 0($t9)
la $t9, __t25
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t26
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
lw $t0, 0($t8)
la $t9, __t27
sw $t0, 0($t9)
li $t0, 5
la $t9, __t28
sw $t0, 0($t9)
la $t9, __t25
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t26
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
la $t9, __t28
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t0, 1
la $t9, __t29
sw $t0, 0($t9)
li $t0, 2
la $t9, __t30
sw $t0, 0($t9)
la $t9, __t29
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t30
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
lw $t0, 0($t8)
la $t9, __t31
sw $t0, 0($t9)
li $t0, 6
la $t9, __t32
sw $t0, 0($t9)
la $t9, __t29
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t30
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
la $t9, __t32
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t0, 2
la $t9, __t33
sw $t0, 0($t9)
li $t0, 0
la $t9, __t34
sw $t0, 0($t9)
la $t9, __t33
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t34
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
lw $t0, 0($t8)
la $t9, __t35
sw $t0, 0($t9)
li $t0, 7
la $t9, __t36
sw $t0, 0($t9)
la $t9, __t33
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t34
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
la $t9, __t36
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t0, 2
la $t9, __t37
sw $t0, 0($t9)
li $t0, 1
la $t9, __t38
sw $t0, 0($t9)
la $t9, __t37
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t38
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
lw $t0, 0($t8)
la $t9, __t39
sw $t0, 0($t9)
li $t0, 8
la $t9, __t40
sw $t0, 0($t9)
la $t9, __t37
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t38
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
la $t9, __t40
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t0, 2
la $t9, __t41
sw $t0, 0($t9)
li $t0, 2
la $t9, __t42
sw $t0, 0($t9)
la $t9, __t41
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t42
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
lw $t0, 0($t8)
la $t9, __t43
sw $t0, 0($t9)
li $t0, 9
la $t9, __t44
sw $t0, 0($t9)
la $t9, __t41
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t42
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
la $t9, __t44
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t0, 0
la $t9, __t45
sw $t0, 0($t9)
la $t9, __t45
lw $t0, 0($t9)
la $t9, i
sw $t0, 0($t9)
_dowhile1_start:
li $t0, 0
la $t9, __t46
sw $t0, 0($t9)
la $t9, __t46
lw $t0, 0($t9)
la $t9, var_j
sw $t0, 0($t9)
_dowhile2_start:
la $t0, str0
la $t9, __t47
sw $t0, 0($t9)
la $t9, __t47
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, i
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t48
sw $t0, 0($t9)
la $t9, __t48
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, var_j
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str2
la $t9, __t49
sw $t0, 0($t9)
la $t9, __t49
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, i
lw $t0, 0($t9)
la $t9, __t50
sw $t0, 0($t9)
la $t9, var_j
lw $t0, 0($t9)
la $t9, __t51
sw $t0, 0($t9)
la $t9, __t50
lw $t8, 0($t9)
li $t9, 3
mul $t8, $t8, $t9
la $t9, __t51
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, m
add $t8, $t9, $t8
lw $t0, 0($t8)
la $t9, __t52
sw $t0, 0($t9)
la $t9, __t52
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str3
la $t9, __t53
sw $t0, 0($t9)
la $t9, __t53
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, var_j
lw $t0, 0($t9)
la $t9, __t54
sw $t0, 0($t9)
li $t0, 1
la $t9, __t55
sw $t0, 0($t9)
la $t9, __t54
lw $t1, 0($t9)
la $t9, __t55
lw $t2, 0($t9)
add $t0, $t1, $t2
la $t9, __t56
sw $t0, 0($t9)
la $t9, __t56
lw $t0, 0($t9)
la $t9, var_j
sw $t0, 0($t9)
la $t9, var_j
lw $t0, 0($t9)
la $t9, __t57
sw $t0, 0($t9)
li $t0, 3
la $t9, __t58
sw $t0, 0($t9)
la $t9, __t57
lw $t1, 0($t9)
la $t9, __t58
lw $t2, 0($t9)
slt $t0, $t1, $t2
la $t9, __t59
sw $t0, 0($t9)
la $t9, __t59
lw $t0, 0($t9)
bne $t0, $zero, _dowhile2_start
_dowhile2_end:
la $t9, i
lw $t0, 0($t9)
la $t9, __t60
sw $t0, 0($t9)
li $t0, 1
la $t9, __t61
sw $t0, 0($t9)
la $t9, __t60
lw $t1, 0($t9)
la $t9, __t61
lw $t2, 0($t9)
add $t0, $t1, $t2
la $t9, __t62
sw $t0, 0($t9)
la $t9, __t62
lw $t0, 0($t9)
la $t9, i
sw $t0, 0($t9)
la $t9, i
lw $t0, 0($t9)
la $t9, __t63
sw $t0, 0($t9)
li $t0, 3
la $t9, __t64
sw $t0, 0($t9)
la $t9, __t63
lw $t1, 0($t9)
la $t9, __t64
lw $t2, 0($t9)
slt $t0, $t1, $t2
la $t9, __t65
sw $t0, 0($t9)
la $t9, __t65
lw $t0, 0($t9)
bne $t0, $zero, _dowhile1_start
_dowhile1_end:
li $v0, 10
syscall
