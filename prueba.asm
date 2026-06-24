.data
__t25: .word 0
__t26: .word 0
r0: .word 0
__t27: .word 0
__t28: .word 0
__t29: .word 0
__t30: .word 0
r1: .word 0
__t31: .word 0
__t32: .word 0
__t33: .word 0
__t34: .word 0
r3: .word 0
__t35: .word 0
__t36: .word 0
__t37: .word 0
__t38: .word 0
r5: .word 0
__t39: .word 0
__t40: .word 0
__t41: .word 0
__t42: .word 0
__t43: .word 0
__t44: .word 0
__t45: .word 0
s0: .word 0
__t46: .word 0
__t47: .word 0
__t48: .word 0
__t49: .word 0
s1: .word 0
__t50: .word 0
__t51: .word 0
__t52: .word 0
__t53: .word 0
s3: .word 0
__t54: .word 0
__t55: .word 0
__t56: .word 0
__t57: .word 0
s5: .word 0
__t58: .word 0
__t59: .word 0
__t60: .word 0
__t61: .word 0
str0: .asciiz "=== FACTORIAL RECURSIVO ==="
str1: .asciiz "\n"
str2: .asciiz "factorialRec(0) = "
str3: .asciiz "factorialRec(1) = "
str4: .asciiz "factorialRec(3) = "
str5: .asciiz "factorialRec(5) = "
str6: .asciiz "=== FACTORIAL ITERATIVO ==="
str7: .asciiz "factorialIter(0) = "
str8: .asciiz "factorialIter(1) = "
str9: .asciiz "factorialIter(3) = "
str10: .asciiz "factorialIter(5) = "

.text
.globl main
factorialRec:
subu $sp, $sp, 72
sw $ra, 68($sp)
sw $fp, 64($sp)
move $fp, $sp
sw $a0, -4($fp)
li $t0, 1
sw $t0, -12($fp)
lw $t0, -12($fp)
sw $t0, -8($fp)
lw $t0, -4($fp)
sw $t0, -16($fp)
li $t0, 1
sw $t0, -20($fp)
lw $t1, -16($fp)
lw $t2, -20($fp)
sle $t0, $t1, $t2
sw $t0, -24($fp)
lw $t0, -24($fp)
beq $t0, $zero, L0
lw $t0, -8($fp)
sw $t0, -28($fp)
lw $v0, -28($fp)
lw $ra, 68($fp)
lw $fp, 64($fp)
addu $sp, $sp, 72
jr $ra
L0:
lw $t0, -4($fp)
sw $t0, -36($fp)
li $t0, 1
sw $t0, -40($fp)
lw $t1, -36($fp)
lw $t2, -40($fp)
sub $t0, $t1, $t2
sw $t0, -44($fp)
lw $a0, -44($fp)
sw $fp, 4($sp)
jal factorialRec
lw $fp, 4($sp)
sw $v0, -48($fp)
lw $t0, -48($fp)
sw $t0, -32($fp)
lw $t0, -4($fp)
sw $t0, -52($fp)
lw $t0, -32($fp)
sw $t0, -56($fp)
lw $t1, -52($fp)
lw $t2, -56($fp)
mul $t0, $t1, $t2
sw $t0, -60($fp)
lw $t0, -60($fp)
sw $t0, -8($fp)
lw $t0, -8($fp)
sw $t0, -64($fp)
lw $v0, -64($fp)
lw $ra, 68($fp)
lw $fp, 64($fp)
addu $sp, $sp, 72
jr $ra
factorialIter:
subu $sp, $sp, 72
sw $ra, 68($sp)
sw $fp, 64($sp)
move $fp, $sp
sw $a0, -4($fp)
li $t0, 1
sw $t0, -12($fp)
lw $t0, -12($fp)
sw $t0, -8($fp)
li $t0, 1
sw $t0, -20($fp)
lw $t0, -20($fp)
sw $t0, -16($fp)
_dowhile1_start:
lw $t0, -8($fp)
sw $t0, -24($fp)
lw $t0, -16($fp)
sw $t0, -28($fp)
lw $t1, -24($fp)
lw $t2, -28($fp)
mul $t0, $t1, $t2
sw $t0, -32($fp)
lw $t0, -32($fp)
sw $t0, -8($fp)
lw $t0, -16($fp)
sw $t0, -36($fp)
li $t0, 1
sw $t0, -40($fp)
lw $t1, -36($fp)
lw $t2, -40($fp)
add $t0, $t1, $t2
sw $t0, -44($fp)
lw $t0, -44($fp)
sw $t0, -16($fp)
lw $t0, -16($fp)
sw $t0, -48($fp)
lw $t0, -4($fp)
sw $t0, -52($fp)
lw $t1, -48($fp)
lw $t2, -52($fp)
sle $t0, $t1, $t2
sw $t0, -56($fp)
lw $t0, -56($fp)
bne $t0, $zero, _dowhile1_start
_dowhile1_end:
lw $t0, -8($fp)
sw $t0, -60($fp)
lw $v0, -60($fp)
lw $ra, 68($fp)
lw $fp, 64($fp)
addu $sp, $sp, 72
jr $ra
main:
la $t0, str0
la $t9, __t25
sw $t0, 0($t9)
la $t9, __t25
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t26
sw $t0, 0($t9)
la $t9, __t26
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 0
la $t9, __t27
sw $t0, 0($t9)
la $t9, __t27
lw $a0, 0($t9)
sw $fp, 4($sp)
jal factorialRec
lw $fp, 4($sp)
la $t9, __t28
sw $v0, 0($t9)
la $t9, __t28
lw $t0, 0($t9)
la $t9, r0
sw $t0, 0($t9)
la $t0, str2
la $t9, __t29
sw $t0, 0($t9)
la $t9, __t29
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, r0
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
li $t0, 1
la $t9, __t31
sw $t0, 0($t9)
la $t9, __t31
lw $a0, 0($t9)
sw $fp, 4($sp)
jal factorialRec
lw $fp, 4($sp)
la $t9, __t32
sw $v0, 0($t9)
la $t9, __t32
lw $t0, 0($t9)
la $t9, r1
sw $t0, 0($t9)
la $t0, str3
la $t9, __t33
sw $t0, 0($t9)
la $t9, __t33
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, r1
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t34
sw $t0, 0($t9)
la $t9, __t34
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 3
la $t9, __t35
sw $t0, 0($t9)
la $t9, __t35
lw $a0, 0($t9)
sw $fp, 4($sp)
jal factorialRec
lw $fp, 4($sp)
la $t9, __t36
sw $v0, 0($t9)
la $t9, __t36
lw $t0, 0($t9)
la $t9, r3
sw $t0, 0($t9)
la $t0, str4
la $t9, __t37
sw $t0, 0($t9)
la $t9, __t37
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, r3
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t38
sw $t0, 0($t9)
la $t9, __t38
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 5
la $t9, __t39
sw $t0, 0($t9)
la $t9, __t39
lw $a0, 0($t9)
sw $fp, 4($sp)
jal factorialRec
lw $fp, 4($sp)
la $t9, __t40
sw $v0, 0($t9)
la $t9, __t40
lw $t0, 0($t9)
la $t9, r5
sw $t0, 0($t9)
la $t0, str5
la $t9, __t41
sw $t0, 0($t9)
la $t9, __t41
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, r5
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t42
sw $t0, 0($t9)
la $t9, __t42
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t43
sw $t0, 0($t9)
la $t9, __t43
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str6
la $t9, __t44
sw $t0, 0($t9)
la $t9, __t44
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t45
sw $t0, 0($t9)
la $t9, __t45
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 0
la $t9, __t46
sw $t0, 0($t9)
la $t9, __t46
lw $a0, 0($t9)
sw $fp, 4($sp)
jal factorialIter
lw $fp, 4($sp)
la $t9, __t47
sw $v0, 0($t9)
la $t9, __t47
lw $t0, 0($t9)
la $t9, s0
sw $t0, 0($t9)
la $t0, str7
la $t9, __t48
sw $t0, 0($t9)
la $t9, __t48
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, s0
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t49
sw $t0, 0($t9)
la $t9, __t49
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 1
la $t9, __t50
sw $t0, 0($t9)
la $t9, __t50
lw $a0, 0($t9)
sw $fp, 4($sp)
jal factorialIter
lw $fp, 4($sp)
la $t9, __t51
sw $v0, 0($t9)
la $t9, __t51
lw $t0, 0($t9)
la $t9, s1
sw $t0, 0($t9)
la $t0, str8
la $t9, __t52
sw $t0, 0($t9)
la $t9, __t52
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, s1
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t53
sw $t0, 0($t9)
la $t9, __t53
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 3
la $t9, __t54
sw $t0, 0($t9)
la $t9, __t54
lw $a0, 0($t9)
sw $fp, 4($sp)
jal factorialIter
lw $fp, 4($sp)
la $t9, __t55
sw $v0, 0($t9)
la $t9, __t55
lw $t0, 0($t9)
la $t9, s3
sw $t0, 0($t9)
la $t0, str9
la $t9, __t56
sw $t0, 0($t9)
la $t9, __t56
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, s3
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t57
sw $t0, 0($t9)
la $t9, __t57
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 5
la $t9, __t58
sw $t0, 0($t9)
la $t9, __t58
lw $a0, 0($t9)
sw $fp, 4($sp)
jal factorialIter
lw $fp, 4($sp)
la $t9, __t59
sw $v0, 0($t9)
la $t9, __t59
lw $t0, 0($t9)
la $t9, s5
sw $t0, 0($t9)
la $t0, str10
la $t9, __t60
sw $t0, 0($t9)
la $t9, __t60
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, s5
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t61
sw $t0, 0($t9)
la $t9, __t61
lw $a0, 0($t9)
li $v0, 4
syscall
li $v0, 10
syscall
