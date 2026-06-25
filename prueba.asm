.data
inicio: .word 0
veces: .word 0
contador: .word 0
i: .word 0
letra: .word 0
__t11: .word 0
__t12: .word 0
__t13: .word 0
__t14: .word 0
__t15: .word 0
__t16: .word 0
saludo: .word 0
__t17: .word 0
__t18: .word 0
__t19: .word 0
__t20: .word 0
__t21: .word 0
__t22: .word 0
__t23: .word 0
__t24: .word 0
__t25: .word 0
valorLeido: .word 0
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
__t45: .word 0
__t46: .word 0
__t47: .word 0
__t48: .word 0
fraccion: .float 0.0
__f0: .float 0.0
__t49: .word 0
__t50: .word 0
__t51: .word 0
__t52: .word 0
__t53: .word 0
edad: .word 0
__t54: .word 0
__t55: .word 0
__t56: .word 0
__t57: .word 0
__t58: .word 0
__t59: .word 0
__t60: .word 0
__t61: .word 0
resultadoDecremento: .word 0
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
numeros: .word 0:4
str0: .asciiz "=== PRUEBA CHAR ==="
str1: .asciiz "\n"
str2: .asciiz "letra = "
str3: .asciiz "Hola desde variable string"
str4: .asciiz "=== PRUEBA STRING VARIABLE ==="
str5: .asciiz "=== PRUEBA ARREGLO ENTERO ==="
str6: .asciiz "numeros[0][0] = "
str7: .asciiz "numeros[1][1] = "
str8: .asciiz "numeros[0][1] tras escribir 99 = "
str9: .asciiz "=== PRUEBA FRACCIONARIO ==="
str10: .asciiz "fraccion (5/6) = "
str11: .asciiz "=== PRUEBA CIN ENTERO ==="
str12: .asciiz "Ingrese un numero entero: "
str13: .asciiz "edad leida = "
str14: .asciiz "=== PRUEBA DECREMENTO (--) ==="
str15: .asciiz "probarDecremento(10, 3) = "
str16: .asciiz "=== FIN DE PRUEBA DE COBERTURA ==="

.text
.globl main
probarDecremento:
subu $sp, $sp, 96
sw $ra, 92($sp)
sw $a0, 4($sp)
sw $a1, 8($sp)
lw $t0, 4($sp)
sw $t0, 16($sp)
lw $t0, 16($sp)
sw $t0, 12($sp)
li $t0, 0
sw $t0, 24($sp)
lw $t0, 24($sp)
sw $t0, 20($sp)
_dowhile1_start:
lw $t0, 12($sp)
sw $t0, 28($sp)
lw $t0, 28($sp)
addi $t0, $t0, -1
sw $t0, 32($sp)
lw $t0, 32($sp)
sw $t0, 12($sp)
lw $t0, 20($sp)
sw $t0, 36($sp)
li $t0, 1
sw $t0, 40($sp)
lw $t1, 36($sp)
lw $t2, 40($sp)
add $t0, $t1, $t2
sw $t0, 44($sp)
lw $t0, 44($sp)
sw $t0, 20($sp)
lw $t0, 20($sp)
sw $t0, 48($sp)
lw $t0, 8($sp)
sw $t0, 52($sp)
lw $t1, 48($sp)
lw $t2, 52($sp)
slt $t0, $t1, $t2
sw $t0, 56($sp)
lw $t0, 56($sp)
bne $t0, $zero, _dowhile1_start
_dowhile1_end:
lw $t0, 12($sp)
sw $t0, 60($sp)
lw $v0, 60($sp)
lw $ra, 92($sp)
addu $sp, $sp, 96
jr $ra
main:
subu $sp, $sp, 32
sw $ra, 28($sp)
li $t0, 65
la $t9, __t11
sw $t0, 0($t9)
la $t9, __t11
lw $t0, 0($t9)
la $t9, letra
sw $t0, 0($t9)
la $t0, str0
la $t9, __t12
sw $t0, 0($t9)
la $t9, __t12
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t13
sw $t0, 0($t9)
la $t9, __t13
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str2
la $t9, __t14
sw $t0, 0($t9)
la $t9, __t14
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, letra
lw $a0, 0($t9)
li $v0, 11
syscall
la $t0, str1
la $t9, __t15
sw $t0, 0($t9)
la $t9, __t15
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t16
sw $t0, 0($t9)
la $t9, __t16
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str3
la $t9, __t17
sw $t0, 0($t9)
la $t9, __t17
lw $t0, 0($t9)
la $t9, saludo
sw $t0, 0($t9)
la $t0, str4
la $t9, __t18
sw $t0, 0($t9)
la $t9, __t18
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t19
sw $t0, 0($t9)
la $t9, __t19
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, saludo
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t20
sw $t0, 0($t9)
la $t9, __t20
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t21
sw $t0, 0($t9)
la $t9, __t21
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 1
la $t9, __t22
sw $t0, 0($t9)
li $t0, 2
la $t9, __t23
sw $t0, 0($t9)
li $t0, 3
la $t9, __t24
sw $t0, 0($t9)
li $t0, 4
la $t9, __t25
sw $t0, 0($t9)
li $t8, 0
li $t9, 2
mul $t8, $t8, $t9
li $t9, 0
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, numeros
add $t8, $t9, $t8
la $t9, __t22
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t8, 0
li $t9, 2
mul $t8, $t8, $t9
li $t9, 1
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, numeros
add $t8, $t9, $t8
la $t9, __t23
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t8, 1
li $t9, 2
mul $t8, $t8, $t9
li $t9, 0
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, numeros
add $t8, $t9, $t8
la $t9, __t24
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t8, 1
li $t9, 2
mul $t8, $t8, $t9
li $t9, 1
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, numeros
add $t8, $t9, $t8
la $t9, __t25
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t0, 0
la $t9, __t26
sw $t0, 0($t9)
la $t9, __t26
lw $t0, 0($t9)
la $t9, valorLeido
sw $t0, 0($t9)
la $t0, str5
la $t9, __t27
sw $t0, 0($t9)
la $t9, __t27
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t28
sw $t0, 0($t9)
la $t9, __t28
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 0
la $t9, __t29
sw $t0, 0($t9)
li $t0, 0
la $t9, __t30
sw $t0, 0($t9)
la $t9, __t29
lw $t8, 0($t9)
li $t9, 2
mul $t8, $t8, $t9
la $t9, __t30
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, numeros
add $t8, $t9, $t8
lw $t0, 0($t8)
la $t9, __t31
sw $t0, 0($t9)
la $t9, __t31
lw $t0, 0($t9)
la $t9, valorLeido
sw $t0, 0($t9)
la $t0, str6
la $t9, __t32
sw $t0, 0($t9)
la $t9, __t32
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, valorLeido
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t33
sw $t0, 0($t9)
la $t9, __t33
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 1
la $t9, __t34
sw $t0, 0($t9)
li $t0, 1
la $t9, __t35
sw $t0, 0($t9)
la $t9, __t34
lw $t8, 0($t9)
li $t9, 2
mul $t8, $t8, $t9
la $t9, __t35
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, numeros
add $t8, $t9, $t8
lw $t0, 0($t8)
la $t9, __t36
sw $t0, 0($t9)
la $t9, __t36
lw $t0, 0($t9)
la $t9, valorLeido
sw $t0, 0($t9)
la $t0, str7
la $t9, __t37
sw $t0, 0($t9)
la $t9, __t37
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, valorLeido
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
li $t0, 0
la $t9, __t39
sw $t0, 0($t9)
li $t0, 1
la $t9, __t40
sw $t0, 0($t9)
la $t9, __t39
lw $t8, 0($t9)
li $t9, 2
mul $t8, $t8, $t9
la $t9, __t40
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, numeros
add $t8, $t9, $t8
lw $t0, 0($t8)
la $t9, __t41
sw $t0, 0($t9)
li $t0, 99
la $t9, __t42
sw $t0, 0($t9)
la $t9, __t39
lw $t8, 0($t9)
li $t9, 2
mul $t8, $t8, $t9
la $t9, __t40
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, numeros
add $t8, $t9, $t8
la $t9, __t42
lw $t0, 0($t9)
sw $t0, 0($t8)
li $t0, 0
la $t9, __t43
sw $t0, 0($t9)
li $t0, 1
la $t9, __t44
sw $t0, 0($t9)
la $t9, __t43
lw $t8, 0($t9)
li $t9, 2
mul $t8, $t8, $t9
la $t9, __t44
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, numeros
add $t8, $t9, $t8
lw $t0, 0($t8)
la $t9, __t45
sw $t0, 0($t9)
la $t9, __t45
lw $t0, 0($t9)
la $t9, valorLeido
sw $t0, 0($t9)
la $t0, str8
la $t9, __t46
sw $t0, 0($t9)
la $t9, __t46
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, valorLeido
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t47
sw $t0, 0($t9)
la $t9, __t47
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t48
sw $t0, 0($t9)
la $t9, __t48
lw $a0, 0($t9)
li $v0, 4
syscall
li.s $f0, 0.8333333333333334
la $t9, __f0
s.s $f0, 0($t9)
la $t9, __f0
l.s $f0, 0($t9)
la $t9, fraccion
s.s $f0, 0($t9)
la $t0, str9
la $t9, __t49
sw $t0, 0($t9)
la $t9, __t49
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t50
sw $t0, 0($t9)
la $t9, __t50
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str10
la $t9, __t51
sw $t0, 0($t9)
la $t9, __t51
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, fraccion
l.s $f12, 0($t9)
li $v0, 2
syscall
la $t0, str1
la $t9, __t52
sw $t0, 0($t9)
la $t9, __t52
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t53
sw $t0, 0($t9)
la $t9, __t53
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 0
la $t9, __t54
sw $t0, 0($t9)
la $t9, __t54
lw $t0, 0($t9)
la $t9, edad
sw $t0, 0($t9)
la $t0, str11
la $t9, __t55
sw $t0, 0($t9)
la $t9, __t55
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t56
sw $t0, 0($t9)
la $t9, __t56
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str12
la $t9, __t57
sw $t0, 0($t9)
la $t9, __t57
lw $a0, 0($t9)
li $v0, 4
syscall
li $v0, 5
syscall
la $t9, edad
sw $v0, 0($t9)
la $t0, str1
la $t9, __t58
sw $t0, 0($t9)
la $t9, __t58
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str13
la $t9, __t59
sw $t0, 0($t9)
la $t9, __t59
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, edad
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t60
sw $t0, 0($t9)
la $t9, __t60
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t61
sw $t0, 0($t9)
la $t9, __t61
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 0
la $t9, __t62
sw $t0, 0($t9)
la $t9, __t62
lw $t0, 0($t9)
la $t9, resultadoDecremento
sw $t0, 0($t9)
la $t0, str14
la $t9, __t63
sw $t0, 0($t9)
la $t9, __t63
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t64
sw $t0, 0($t9)
la $t9, __t64
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 10
la $t9, __t65
sw $t0, 0($t9)
li $t0, 3
la $t9, __t66
sw $t0, 0($t9)
la $t9, __t65
lw $a0, 0($t9)
la $t9, __t66
lw $a1, 0($t9)
jal probarDecremento
la $t9, __t67
sw $v0, 0($t9)
la $t9, __t67
lw $t0, 0($t9)
la $t9, resultadoDecremento
sw $t0, 0($t9)
la $t0, str15
la $t9, __t68
sw $t0, 0($t9)
la $t9, __t68
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, resultadoDecremento
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t69
sw $t0, 0($t9)
la $t9, __t69
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t70
sw $t0, 0($t9)
la $t9, __t70
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str16
la $t9, __t71
sw $t0, 0($t9)
la $t9, __t71
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t72
sw $t0, 0($t9)
la $t9, __t72
lw $a0, 0($t9)
li $v0, 4
syscall
li $v0, 10
syscall
