.data
valorExp: .word 0
__t0: .word 0
otroExp: .word 0
__t1: .word 0
suma: .word 0
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
str0: .asciiz "=== PRUEBA NOTACION EXPONENCIAL ==="
str1: .asciiz "\n"
str2: .asciiz "valorExp (1e3) = "
str3: .asciiz "otroExp (2e2) = "
str4: .asciiz "suma = "

.text
.globl main
main:
subu $sp, $sp, 32
sw $ra, 28($sp)
li $t0, 1000
la $t9, __t0
sw $t0, 0($t9)
la $t9, __t0
lw $t0, 0($t9)
la $t9, valorExp
sw $t0, 0($t9)
li $t0, 200
la $t9, __t1
sw $t0, 0($t9)
la $t9, __t1
lw $t0, 0($t9)
la $t9, otroExp
sw $t0, 0($t9)
li $t0, 0
la $t9, __t2
sw $t0, 0($t9)
la $t9, __t2
lw $t0, 0($t9)
la $t9, suma
sw $t0, 0($t9)
la $t0, str0
la $t9, __t3
sw $t0, 0($t9)
la $t9, __t3
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t4
sw $t0, 0($t9)
la $t9, __t4
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str2
la $t9, __t5
sw $t0, 0($t9)
la $t9, __t5
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, valorExp
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t6
sw $t0, 0($t9)
la $t9, __t6
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str3
la $t9, __t7
sw $t0, 0($t9)
la $t9, __t7
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, otroExp
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t8
sw $t0, 0($t9)
la $t9, __t8
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, valorExp
lw $t0, 0($t9)
la $t9, __t9
sw $t0, 0($t9)
la $t9, otroExp
lw $t0, 0($t9)
la $t9, __t10
sw $t0, 0($t9)
la $t9, __t9
lw $t1, 0($t9)
la $t9, __t10
lw $t2, 0($t9)
add $t0, $t1, $t2
la $t9, __t11
sw $t0, 0($t9)
la $t9, __t11
lw $t0, 0($t9)
la $t9, suma
sw $t0, 0($t9)
la $t0, str4
la $t9, __t12
sw $t0, 0($t9)
la $t9, __t12
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, suma
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t13
sw $t0, 0($t9)
la $t9, __t13
lw $a0, 0($t9)
li $v0, 4
syscall
li $v0, 10
syscall
