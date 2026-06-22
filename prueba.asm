.data
n: .word 0
f: .float 0.0
t0: .word 0
t1: .word 0
t2: .word 0
t3: .word 0
t4: .word 0
t5: .word 0
str0: .asciiz "Ingresa un entero: "
str1: .asciiz "Leiste: "
str2: .asciiz "\n"
str3: .asciiz "Ingresa un flotante: "

.text
.globl main
main:
la $t0, str0
sw $t0, t0
lw $a0, t0
li $v0, 4
syscall
li $v0, 5
syscall
sw $v0, n
la $t0, str1
sw $t0, t1
lw $a0, t1
li $v0, 4
syscall
lw $a0, n
li $v0, 1
syscall
la $t0, str2
sw $t0, t2
lw $a0, t2
li $v0, 4
syscall
la $t0, str3
sw $t0, t3
lw $a0, t3
li $v0, 4
syscall
li $v0, 6
syscall
s.s $f0, f
la $t0, str1
sw $t0, t4
lw $a0, t4
li $v0, 4
syscall
l.s $f12, f
li $v0, 2
syscall
la $t0, str2
sw $t0, t5
lw $a0, t5
li $v0, 4
syscall
li $v0, 10
syscall
