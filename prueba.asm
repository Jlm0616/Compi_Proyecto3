.data
__t1: .word 0
__t2: .word 0
__t3: .word 0
__t4: .word 0
prev: .word 0
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
r0: .word 0
__t15: .word 0
__t16: .word 0
__t17: .word 0
__t18: .word 0
r1: .word 0
__t19: .word 0
__t20: .word 0
__t21: .word 0
__t22: .word 0
r3: .word 0
__t23: .word 0
__t24: .word 0
__t25: .word 0
__t26: .word 0
r5: .word 0
__t27: .word 0
__t28: .word 0
__t29: .word 0
__t30: .word 0
str0: .asciiz "=== FACTORIAL RECURSIVO ==="
str1: .asciiz "\n"
str2: .asciiz "factorial(0) = "
str3: .asciiz "factorial(1) = "
str4: .asciiz "factorial(3) = "
str5: .asciiz "factorial(5) = "

.text
.globl main
factorial:
subu $sp, $sp, 24
sw $ra, 20($sp)
sw $fp, 16($sp)
move $fp, $sp
sw $a0, -4($fp)
li $t0, 1
sw $t0, -12($fp)
lw $t0, -12($fp)
sw $t0, -8($fp)
_dowhile1_start:
lw $t0, -8($fp)
la $t9, __t1
sw $t0, 0($t9)
la $t9, __t1
lw $v0, 0($t9)
lw $ra, 20($sp)
lw $fp, 16($sp)
addu $sp, $sp, 24
jr $ra
lw $t0, -4($fp)
la $t9, __t2
sw $t0, 0($t9)
li $t0, 1
la $t9, __t3
sw $t0, 0($t9)
la $t9, __t2
lw $t1, 0($t9)
la $t9, __t3
lw $t2, 0($t9)
sle $t0, $t1, $t2
la $t9, __t4
sw $t0, 0($t9)
la $t9, __t4
lw $t0, 0($t9)
bne $t0, $zero, _dowhile1_start
_dowhile1_end:
lw $t0, -4($fp)
la $t9, __t5
sw $t0, 0($t9)
li $t0, 1
la $t9, __t6
sw $t0, 0($t9)
la $t9, __t5
lw $t1, 0($t9)
la $t9, __t6
lw $t2, 0($t9)
sub $t0, $t1, $t2
la $t9, __t7
sw $t0, 0($t9)
la $t9, __t7
sw $a1, 0($t9)
jal factorial
la $t9, __t8
sw $v0, 0($t9)
la $t9, __t8
lw $t0, 0($t9)
la $t9, prev
sw $t0, 0($t9)
lw $t0, -4($fp)
la $t9, __t9
sw $t0, 0($t9)
la $t9, prev
lw $t0, 0($t9)
la $t9, __t10
sw $t0, 0($t9)
la $t9, __t9
lw $t1, 0($t9)
la $t9, __t10
lw $t2, 0($t9)
mul $t0, $t1, $t2
la $t9, __t11
sw $t0, 0($t9)
la $t9, __t11
lw $t0, 0($t9)
sw $t0, -8($fp)
lw $t0, -8($fp)
la $t9, __t12
sw $t0, 0($t9)
la $t9, __t12
lw $v0, 0($t9)
lw $ra, 20($sp)
lw $fp, 16($sp)
addu $sp, $sp, 24
jr $ra
main:
la $t0, str0
la $t9, __t13
sw $t0, 0($t9)
la $t9, __t13
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t14
sw $t0, 0($t9)
la $t9, __t14
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 0
la $t9, __t15
sw $t0, 0($t9)
la $t9, __t15
lw $a0, 0($t9)
jal factorial
la $t9, __t16
sw $v0, 0($t9)
la $t9, __t16
lw $t0, 0($t9)
la $t9, r0
sw $t0, 0($t9)
la $t0, str2
la $t9, __t17
sw $t0, 0($t9)
la $t9, __t17
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, r0
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t18
sw $t0, 0($t9)
la $t9, __t18
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 1
la $t9, __t19
sw $t0, 0($t9)
la $t9, __t19
lw $a0, 0($t9)
jal factorial
la $t9, __t20
sw $v0, 0($t9)
la $t9, __t20
lw $t0, 0($t9)
la $t9, r1
sw $t0, 0($t9)
la $t0, str3
la $t9, __t21
sw $t0, 0($t9)
la $t9, __t21
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, r1
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t22
sw $t0, 0($t9)
la $t9, __t22
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 3
la $t9, __t23
sw $t0, 0($t9)
la $t9, __t23
lw $a0, 0($t9)
jal factorial
la $t9, __t24
sw $v0, 0($t9)
la $t9, __t24
lw $t0, 0($t9)
la $t9, r3
sw $t0, 0($t9)
la $t0, str4
la $t9, __t25
sw $t0, 0($t9)
la $t9, __t25
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, r3
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t26
sw $t0, 0($t9)
la $t9, __t26
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 5
la $t9, __t27
sw $t0, 0($t9)
la $t9, __t27
lw $a0, 0($t9)
jal factorial
la $t9, __t28
sw $v0, 0($t9)
la $t9, __t28
lw $t0, 0($t9)
la $t9, r5
sw $t0, 0($t9)
la $t0, str5
la $t9, __t29
sw $t0, 0($t9)
la $t9, __t29
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, r5
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t30
sw $t0, 0($t9)
la $t9, __t30
lw $a0, 0($t9)
li $v0, 4
syscall
li $v0, 10
syscall
