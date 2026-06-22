.data
base: .word 0
t0: .word 0
exponente: .word 0
t1: .word 0
resultado: .word 0
t2: .word 0
t3: .word 0
t4: .word 0
t5: .word 0
t6: .word 0
t7: .word 0
base2: .word 0
t8: .word 0
exponente2: .word 0
t9: .word 0
resultado2: .word 0
t10: .word 0
t11: .word 0
t12: .word 0
t13: .word 0
t14: .word 0
t15: .word 0
base3: .word 0
t16: .word 0
exponente3: .word 0
t17: .word 0
resultado3: .word 0
t18: .word 0
t19: .word 0
t20: .word 0
t21: .word 0
t22: .word 0
t23: .word 0
str0: .asciiz "2 elevado a 10 es: "
str1: .asciiz "\n"
str2: .asciiz "5 elevado a 0 es: "
str3: .asciiz "3 elevado a 4 es: "

.text
.globl main
main:
li $t0, 2
sw $t0, t0
lw $t0, t0
sw $t0, base
li $t0, 10
sw $t0, t1
lw $t0, t1
sw $t0, exponente
li $t0, 0
sw $t0, t2
lw $t0, t2
sw $t0, resultado
lw $t0, base
sw $t0, t3
lw $t0, exponente
sw $t0, t4
lw $t1, t3
lw $t2, t4
li $t0, 1
_pow0_start:
blez $t2, _pow1_end
mul $t0, $t0, $t1
addi $t2, $t2, -1
j _pow0_start
_pow1_end:
sw $t0, t5
lw $t0, t5
sw $t0, resultado
la $t0, str0
sw $t0, t6
lw $a0, t6
li $v0, 4
syscall
lw $a0, resultado
li $v0, 1
syscall
la $t0, str1
sw $t0, t7
lw $a0, t7
li $v0, 4
syscall
li $t0, 5
sw $t0, t8
lw $t0, t8
sw $t0, base2
li $t0, 0
sw $t0, t9
lw $t0, t9
sw $t0, exponente2
li $t0, 0
sw $t0, t10
lw $t0, t10
sw $t0, resultado2
lw $t0, base2
sw $t0, t11
lw $t0, exponente2
sw $t0, t12
lw $t1, t11
lw $t2, t12
li $t0, 1
_pow2_start:
blez $t2, _pow3_end
mul $t0, $t0, $t1
addi $t2, $t2, -1
j _pow2_start
_pow3_end:
sw $t0, t13
lw $t0, t13
sw $t0, resultado2
la $t0, str2
sw $t0, t14
lw $a0, t14
li $v0, 4
syscall
lw $a0, resultado2
li $v0, 1
syscall
la $t0, str1
sw $t0, t15
lw $a0, t15
li $v0, 4
syscall
li $t0, 3
sw $t0, t16
lw $t0, t16
sw $t0, base3
li $t0, 4
sw $t0, t17
lw $t0, t17
sw $t0, exponente3
li $t0, 0
sw $t0, t18
lw $t0, t18
sw $t0, resultado3
lw $t0, base3
sw $t0, t19
lw $t0, exponente3
sw $t0, t20
lw $t1, t19
lw $t2, t20
li $t0, 1
_pow4_start:
blez $t2, _pow5_end
mul $t0, $t0, $t1
addi $t2, $t2, -1
j _pow4_start
_pow5_end:
sw $t0, t21
lw $t0, t21
sw $t0, resultado3
la $t0, str3
sw $t0, t22
lw $a0, t22
li $v0, 4
syscall
lw $a0, resultado3
li $v0, 1
syscall
la $t0, str1
sw $t0, t23
lw $a0, t23
li $v0, 4
syscall
li $v0, 10
syscall
