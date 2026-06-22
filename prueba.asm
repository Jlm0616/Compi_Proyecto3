.data
f0: .float 0.0
f1: .float 0.0
f2: .float 0.0
f3: .float 0.0
i: .word 0
t0: .word 0
var_j: .word 0
t1: .word 0
temp: .float 0.0
f4: .float 0.0
t2: .word 0
t3: .word 0
t4: .word 0
t5: .word 0
t6: .word 0
t7: .word 0
t8: .word 0
t9: .word 0
t10: .word 0
t11: .float 0.0
f5: .float 0.0
t12: .word 0
t13: .word 0
t14: .word 0
t15: .word 0
t16: .word 0
t17: .word 0
t18: .word 0
t19: .word 0
t20: .word 0
t21: .word 0
t22: .word 0
t23: .word 0
t24: .word 0
t25: .word 0
t26: .word 0
t27: .word 0
t28: .word 0
t29: .word 0
t30: .float 0.0
t31: .word 0
t32: .word 0
t33: .word 0
t34: .word 0
t35: .word 0
t36: .word 0
t37: .word 0
t38: .word 0
t39: .word 0
t40: .word 0
t41: .word 0
t42: .word 0
t43: .word 0
t44: .word 0
mat: .float 0.0, 0.0, 0.0, 0.0
str0: .asciiz "Ingresa 4 valores:"
str1: .asciiz "\n"
str2: .asciiz "mat["
str3: .asciiz "]["
str4: .asciiz "] = "
str5: .asciiz "\n=== MATRIZ INGRESADA ==="
str6: .asciiz " "

.text
.globl main
main:
li.s $f0, 0.0
s.s $f0, f0
li.s $f0, 0.0
s.s $f0, f1
li.s $f0, 0.0
s.s $f0, f2
li.s $f0, 0.0
s.s $f0, f3
li $t8, 0
li $t9, 2
mul $t8, $t8, $t9
li $t9, 0
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, mat
add $t9, $t9, $t8
l.s $f0, f0
s.s $f0, 0($t9)
li $t8, 0
li $t9, 2
mul $t8, $t8, $t9
li $t9, 1
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, mat
add $t9, $t9, $t8
l.s $f0, f1
s.s $f0, 0($t9)
li $t8, 1
li $t9, 2
mul $t8, $t8, $t9
li $t9, 0
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, mat
add $t9, $t9, $t8
l.s $f0, f2
s.s $f0, 0($t9)
li $t8, 1
li $t9, 2
mul $t8, $t8, $t9
li $t9, 1
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, mat
add $t9, $t9, $t8
l.s $f0, f3
s.s $f0, 0($t9)
li $t0, 0
sw $t0, t0
lw $t0, t0
sw $t0, i
li $t0, 0
sw $t0, t1
lw $t0, t1
sw $t0, var_j
li.s $f0, 0.0
s.s $f0, f4
l.s $f0, f4
s.s $f0, temp
la $t0, str0
sw $t0, t2
lw $a0, t2
li $v0, 4
syscall
la $t0, str1
sw $t0, t3
lw $a0, t3
li $v0, 4
syscall
li $t0, 0
sw $t0, t4
lw $t0, t4
sw $t0, i
_dowhile1_start:
li $t0, 0
sw $t0, t5
lw $t0, t5
sw $t0, var_j
_dowhile2_start:
la $t0, str2
sw $t0, t6
lw $a0, t6
li $v0, 4
syscall
lw $a0, i
li $v0, 1
syscall
la $t0, str3
sw $t0, t7
lw $a0, t7
li $v0, 4
syscall
lw $a0, var_j
li $v0, 1
syscall
la $t0, str4
sw $t0, t8
lw $a0, t8
li $v0, 4
syscall
li $v0, 6
syscall
s.s $f0, temp
lw $t0, i
sw $t0, t9
lw $t0, var_j
sw $t0, t10
lw $t8, t9
li $t9, 2
mul $t8, $t8, $t9
lw $t9, t10
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, mat
add $t9, $t9, $t8
l.s $f0, 0($t9)
s.s $f0, t11
l.s $f0, temp
s.s $f0, f5
lw $t8, t9
li $t9, 2
mul $t8, $t8, $t9
lw $t9, t10
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, mat
add $t9, $t9, $t8
l.s $f0, f5
s.s $f0, 0($t9)
lw $t0, var_j
sw $t0, t12
li $t0, 1
sw $t0, t13
lw $t1, t12
lw $t2, t13
add $t0, $t1, $t2
sw $t0, t14
lw $t0, t14
sw $t0, var_j
lw $t0, var_j
sw $t0, t15
li $t0, 2
sw $t0, t16
lw $t1, t15
lw $t2, t16
slt $t0, $t1, $t2
sw $t0, t17
lw $t0, t17
bne $t0, $zero, _dowhile2_start
_dowhile2_end:
lw $t0, i
sw $t0, t18
li $t0, 1
sw $t0, t19
lw $t1, t18
lw $t2, t19
add $t0, $t1, $t2
sw $t0, t20
lw $t0, t20
sw $t0, i
lw $t0, i
sw $t0, t21
li $t0, 2
sw $t0, t22
lw $t1, t21
lw $t2, t22
slt $t0, $t1, $t2
sw $t0, t23
lw $t0, t23
bne $t0, $zero, _dowhile1_start
_dowhile1_end:
la $t0, str5
sw $t0, t24
lw $a0, t24
li $v0, 4
syscall
la $t0, str1
sw $t0, t25
lw $a0, t25
li $v0, 4
syscall
li $t0, 0
sw $t0, t26
lw $t0, t26
sw $t0, i
_dowhile3_start:
li $t0, 0
sw $t0, t27
lw $t0, t27
sw $t0, var_j
_dowhile4_start:
lw $t0, i
sw $t0, t28
lw $t0, var_j
sw $t0, t29
lw $t8, t28
li $t9, 2
mul $t8, $t8, $t9
lw $t9, t29
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, mat
add $t9, $t9, $t8
l.s $f0, 0($t9)
s.s $f0, t30
l.s $f12, t30
li $v0, 2
syscall
la $t0, str6
sw $t0, t31
lw $a0, t31
li $v0, 4
syscall
lw $t0, var_j
sw $t0, t32
li $t0, 1
sw $t0, t33
lw $t1, t32
lw $t2, t33
add $t0, $t1, $t2
sw $t0, t34
lw $t0, t34
sw $t0, var_j
lw $t0, var_j
sw $t0, t35
li $t0, 2
sw $t0, t36
lw $t1, t35
lw $t2, t36
slt $t0, $t1, $t2
sw $t0, t37
lw $t0, t37
bne $t0, $zero, _dowhile4_start
_dowhile4_end:
la $t0, str1
sw $t0, t38
lw $a0, t38
li $v0, 4
syscall
lw $t0, i
sw $t0, t39
li $t0, 1
sw $t0, t40
lw $t1, t39
lw $t2, t40
add $t0, $t1, $t2
sw $t0, t41
lw $t0, t41
sw $t0, i
lw $t0, i
sw $t0, t42
li $t0, 2
sw $t0, t43
lw $t1, t42
lw $t2, t43
slt $t0, $t1, $t2
sw $t0, t44
lw $t0, t44
bne $t0, $zero, _dowhile3_start
_dowhile3_end:
li $v0, 10
syscall
