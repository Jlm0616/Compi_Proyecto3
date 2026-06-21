.data
numero: .word 0
t0: .word 0
flag: .word 0
t1: .word 0
t2: .word 0
t3: .word 0
t4: .word 0
t5: .word 0
t6: .word 0
t7: .word 0
t8: .word 0
t9: .word 0
contador: .word 0
t10: .word 0
t11: .word 0
t12: .word 0
tsw1: .word 0
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
str0: .asciiz "rama if"
str1: .asciiz "if interno"
str2: .asciiz "fin if"
str3: .asciiz "rama else"
str4: .asciiz "iteracion"
str5: .asciiz "caso 0"
str6: .asciiz "default"
str7: .asciiz "fin else"
str8: .asciiz "fin programa"

.text
.globl main
main:
li $t0, 20
sw $t0, t0
lw $t0, t0
sw $t0, numero
li $t0, 1
sw $t0, t1
lw $t0, t1
sw $t0, flag
lw $t0, numero
sw $t0, t2
li $t0, 45
sw $t0, t3
lw $t1, t2
lw $t2, t3
sle $t0, $t1, $t2
sw $t0, t4
lw $t0, t4
beq $t0, $zero, L0
la $t0, str0
sw $t0, t5
lw $a0, t5
li $v0, 4
syscall
lw $t0, flag
sw $t0, t6
lw $t0, t6
beq $t0, $zero, L1
la $t0, str1
sw $t0, t7
lw $a0, t7
li $v0, 4
syscall
L1:
la $t0, str2
sw $t0, t8
lw $a0, t8
li $v0, 4
syscall
j L2
L0:
la $t0, str3
sw $t0, t9
lw $a0, t9
li $v0, 4
syscall
li $t0, 0
sw $t0, t10
lw $t0, t10
sw $t0, contador
_dowhile1_start:
la $t0, str4
sw $t0, t11
lw $a0, t11
li $v0, 4
syscall
lw $t0, contador
sw $t0, t12
_switch1:
li $t0, 1
sw $t0, tsw1
li $t0, 0
sw $t0, t13
_case1_1:
lw $t1, tsw1
li $t2, 0
seq $t0, $t1, $t2
sw $t0, t14
lw $t0, t14
bne $t0, $zero, _case1_1_b
lw $t1, t12
lw $t2, t13
seq $t0, $t1, $t2
sw $t0, t15
lw $t0, t15
bne $t0, $zero, _case1_1_b
j _case1_1_e
_case1_1_b:
li $t0, 0
sw $t0, tsw1
la $t0, str5
sw $t0, t16
lw $a0, t16
li $v0, 4
syscall
j _sw1_end
_case1_1_e:
_default1:
la $t0, str6
sw $t0, t17
lw $a0, t17
li $v0, 4
syscall
_sw1_end:
lw $t0, contador
sw $t0, t18
li $t0, 1
sw $t0, t19
lw $t1, t18
lw $t2, t19
add $t0, $t1, $t2
sw $t0, t20
lw $t0, t20
sw $t0, contador
lw $t0, contador
sw $t0, t21
li $t0, 1
sw $t0, t22
lw $t1, t21
lw $t2, t22
slt $t0, $t1, $t2
sw $t0, t23
lw $t0, t23
bne $t0, $zero, _dowhile1_start
_dowhile1_end:
la $t0, str7
sw $t0, t24
lw $a0, t24
li $v0, 4
syscall
L2:
la $t0, str8
sw $t0, t25
lw $a0, t25
li $v0, 4
syscall
li $v0, 10
syscall
