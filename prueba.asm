.data
x: .word 0
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
y: .word 0
__t13: .word 0
__t14: .word 0
__t15: .word 0
__t16: .word 0
__t17: .word 0
__t18: .word 0
__t19: .word 0
__t20: .word 0
__t21: .word 0
z: .word 0
__t22: .word 0
__t23: .word 0
__t24: .word 0
__t25: .word 0
__t26: .word 0
__t27: .word 0
__t28: .word 0
__t29: .word 0
__t30: .word 0
w: .word 0
__t31: .word 0
__t32: .word 0
__t33: .word 0
__t34: .word 0
__t35: .word 0
__t36: .word 0
__t37: .word 0
m: .word 0
__t38: .word 0
__t39: .word 0
__t40: .word 0
__t41: .word 0
__t42: .word 0
__t43: .word 0
__t44: .word 0
r: .word 0
__t45: .word 0
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
s: .word 0
__t60: .word 0
__t61: .word 0
__t62: .word 0
__t63: .word 0
__t64: .word 0
__t65: .word 0
__t66: .word 0
__t67: .word 0
__t68: .word 0
__t69: .word 0
__t70: .word 0
__t71: .word 0
__t72: .word 0
str0: .asciiz "((2+3)*(4-1))^(2-1) = "
str1: .asciiz "\n"
str2: .asciiz "100/10/2/5 = "
str3: .asciiz "100-30-20-10 = "
str4: .asciiz "2^3^2 = "
str5: .asciiz "100%30%7 = "
str6: .asciiz "1+2*3+4*5+6*7 = "
str7: .asciiz "10-2*3+8/4%3 = "

.text
.globl main
main:
li $t0, 2
sw $t0, __t0
li $t0, 3
sw $t0, __t1
lw $t1, __t0
lw $t2, __t1
add $t0, $t1, $t2
sw $t0, __t2
li $t0, 4
sw $t0, __t3
li $t0, 1
sw $t0, __t4
lw $t1, __t3
lw $t2, __t4
sub $t0, $t1, $t2
sw $t0, __t5
lw $t1, __t2
lw $t2, __t5
mul $t0, $t1, $t2
sw $t0, __t6
li $t0, 2
sw $t0, __t7
li $t0, 1
sw $t0, __t8
lw $t1, __t7
lw $t2, __t8
sub $t0, $t1, $t2
sw $t0, __t9
lw $t1, __t6
lw $t2, __t9
li $t0, 1
_pow0_start:
blez $t2, _pow1_end
mul $t0, $t0, $t1
addi $t2, $t2, -1
j _pow0_start
_pow1_end:
sw $t0, __t10
lw $t0, __t10
sw $t0, x
la $t0, str0
sw $t0, __t11
lw $a0, __t11
li $v0, 4
syscall
lw $a0, x
li $v0, 1
syscall
la $t0, str1
sw $t0, __t12
lw $a0, __t12
li $v0, 4
syscall
li $t0, 100
sw $t0, __t13
li $t0, 10
sw $t0, __t14
lw $t1, __t13
lw $t2, __t14
div $t1, $t2
mflo $t0
sw $t0, __t15
li $t0, 2
sw $t0, __t16
lw $t1, __t15
lw $t2, __t16
div $t1, $t2
mflo $t0
sw $t0, __t17
li $t0, 5
sw $t0, __t18
lw $t1, __t17
lw $t2, __t18
div $t1, $t2
mflo $t0
sw $t0, __t19
lw $t0, __t19
sw $t0, y
la $t0, str2
sw $t0, __t20
lw $a0, __t20
li $v0, 4
syscall
lw $a0, y
li $v0, 1
syscall
la $t0, str1
sw $t0, __t21
lw $a0, __t21
li $v0, 4
syscall
li $t0, 100
sw $t0, __t22
li $t0, 30
sw $t0, __t23
lw $t1, __t22
lw $t2, __t23
sub $t0, $t1, $t2
sw $t0, __t24
li $t0, 20
sw $t0, __t25
lw $t1, __t24
lw $t2, __t25
sub $t0, $t1, $t2
sw $t0, __t26
li $t0, 10
sw $t0, __t27
lw $t1, __t26
lw $t2, __t27
sub $t0, $t1, $t2
sw $t0, __t28
lw $t0, __t28
sw $t0, z
la $t0, str3
sw $t0, __t29
lw $a0, __t29
li $v0, 4
syscall
lw $a0, z
li $v0, 1
syscall
la $t0, str1
sw $t0, __t30
lw $a0, __t30
li $v0, 4
syscall
li $t0, 2
sw $t0, __t31
li $t0, 3
sw $t0, __t32
li $t0, 2
sw $t0, __t33
lw $t1, __t32
lw $t2, __t33
li $t0, 1
_pow2_start:
blez $t2, _pow3_end
mul $t0, $t0, $t1
addi $t2, $t2, -1
j _pow2_start
_pow3_end:
sw $t0, __t34
lw $t1, __t31
lw $t2, __t34
li $t0, 1
_pow4_start:
blez $t2, _pow5_end
mul $t0, $t0, $t1
addi $t2, $t2, -1
j _pow4_start
_pow5_end:
sw $t0, __t35
lw $t0, __t35
sw $t0, w
la $t0, str4
sw $t0, __t36
lw $a0, __t36
li $v0, 4
syscall
lw $a0, w
li $v0, 1
syscall
la $t0, str1
sw $t0, __t37
lw $a0, __t37
li $v0, 4
syscall
li $t0, 100
sw $t0, __t38
li $t0, 30
sw $t0, __t39
lw $t1, __t38
lw $t2, __t39
div $t1, $t2
mfhi $t0
sw $t0, __t40
li $t0, 7
sw $t0, __t41
lw $t1, __t40
lw $t2, __t41
div $t1, $t2
mfhi $t0
sw $t0, __t42
lw $t0, __t42
sw $t0, m
la $t0, str5
sw $t0, __t43
lw $a0, __t43
li $v0, 4
syscall
lw $a0, m
li $v0, 1
syscall
la $t0, str1
sw $t0, __t44
lw $a0, __t44
li $v0, 4
syscall
li $t0, 1
sw $t0, __t45
li $t0, 2
sw $t0, __t46
li $t0, 3
sw $t0, __t47
lw $t1, __t46
lw $t2, __t47
mul $t0, $t1, $t2
sw $t0, __t48
lw $t1, __t45
lw $t2, __t48
add $t0, $t1, $t2
sw $t0, __t49
li $t0, 4
sw $t0, __t50
li $t0, 5
sw $t0, __t51
lw $t1, __t50
lw $t2, __t51
mul $t0, $t1, $t2
sw $t0, __t52
lw $t1, __t49
lw $t2, __t52
add $t0, $t1, $t2
sw $t0, __t53
li $t0, 6
sw $t0, __t54
li $t0, 7
sw $t0, __t55
lw $t1, __t54
lw $t2, __t55
mul $t0, $t1, $t2
sw $t0, __t56
lw $t1, __t53
lw $t2, __t56
add $t0, $t1, $t2
sw $t0, __t57
lw $t0, __t57
sw $t0, r
la $t0, str6
sw $t0, __t58
lw $a0, __t58
li $v0, 4
syscall
lw $a0, r
li $v0, 1
syscall
la $t0, str1
sw $t0, __t59
lw $a0, __t59
li $v0, 4
syscall
li $t0, 10
sw $t0, __t60
li $t0, 2
sw $t0, __t61
li $t0, 3
sw $t0, __t62
lw $t1, __t61
lw $t2, __t62
mul $t0, $t1, $t2
sw $t0, __t63
lw $t1, __t60
lw $t2, __t63
sub $t0, $t1, $t2
sw $t0, __t64
li $t0, 8
sw $t0, __t65
li $t0, 4
sw $t0, __t66
lw $t1, __t65
lw $t2, __t66
div $t1, $t2
mflo $t0
sw $t0, __t67
li $t0, 3
sw $t0, __t68
lw $t1, __t67
lw $t2, __t68
div $t1, $t2
mfhi $t0
sw $t0, __t69
lw $t1, __t64
lw $t2, __t69
add $t0, $t1, $t2
sw $t0, __t70
lw $t0, __t70
sw $t0, s
la $t0, str7
sw $t0, __t71
lw $a0, __t71
li $v0, 4
syscall
lw $a0, s
li $v0, 1
syscall
la $t0, str1
sw $t0, __t72
lw $a0, __t72
li $v0, 4
syscall
li $v0, 10
syscall
