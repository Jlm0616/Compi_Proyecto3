.data
a: .word 0
var_b: .word 0
resultado: .word 0
__t0: .word 0
__t1: .word 0
__t2: .word 0
__t3: .word 0
x: .word 0
__t4: .word 0
y: .word 0
__t5: .word 0
s: .word 0
__t6: .word 0
__t7: .word 0
__t8: .word 0
__t9: .word 0
__t10: .word 0
str0: .asciiz "sumar(10,3) = "
str1: .asciiz "\n"

.text
.globl main
sumar:
subu $sp, $sp, 8
sw $ra, 4($sp)
sw $fp, 0($sp)
move $fp, $sp
la $t9, a
sw $a0, 0($t9)
la $t9, var_b
sw $a1, 0($t9)
la $t9, a
lw $t0, 0($t9)
la $t9, __t0
sw $t0, 0($t9)
la $t9, var_b
lw $t0, 0($t9)
la $t9, __t1
sw $t0, 0($t9)
la $t9, __t0
lw $t1, 0($t9)
la $t9, __t1
lw $t2, 0($t9)
add $t0, $t1, $t2
la $t9, __t2
sw $t0, 0($t9)
la $t9, __t2
lw $t0, 0($t9)
la $t9, resultado
sw $t0, 0($t9)
la $t9, resultado
lw $t0, 0($t9)
la $t9, __t3
sw $t0, 0($t9)
la $t9, __t3
lw $v0, 0($t9)
lw $fp, 0($sp)
lw $ra, 4($sp)
addu $sp, $sp, 8
jr $ra
main:
li $t0, 10
la $t9, __t4
sw $t0, 0($t9)
la $t9, __t4
lw $t0, 0($t9)
la $t9, x
sw $t0, 0($t9)
li $t0, 3
la $t9, __t5
sw $t0, 0($t9)
la $t9, __t5
lw $t0, 0($t9)
la $t9, y
sw $t0, 0($t9)
la $t9, x
lw $t0, 0($t9)
la $t9, __t6
sw $t0, 0($t9)
la $t9, y
lw $t0, 0($t9)
la $t9, __t7
sw $t0, 0($t9)
la $t9, __t6
lw $a0, 0($t9)
la $t9, __t7
lw $a1, 0($t9)
subu $sp, $sp, 8
sw $ra, 4($sp)
sw $fp, 0($sp)
jal sumar
lw $fp, 0($sp)
lw $ra, 4($sp)
addu $sp, $sp, 8
la $t9, __t8
sw $v0, 0($t9)
la $t9, __t8
lw $t0, 0($t9)
la $t9, s
sw $t0, 0($t9)
la $t0, str0
la $t9, __t9
sw $t0, 0($t9)
la $t9, __t9
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, s
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t10
sw $t0, 0($t9)
la $t9, __t10
lw $a0, 0($t9)
li $v0, 4
syscall
li $v0, 10
syscall
