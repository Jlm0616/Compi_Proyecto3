.data
nota1: .float 0.0
nota2: .float 0.0
nota3: .float 0.0
suma: .float 0.0
promedio: .float 0.0
a: .float 0.0
var_b: .float 0.0
c: .float 0.0
max: .float 0.0
min: .float 0.0
contador: .word 0
estado: .word 0
__f29: .float 0.0
__f30: .float 0.0
__f31: .float 0.0
__f32: .float 0.0
__f33: .float 0.0
__f34: .float 0.0
__t47: .word 0
opcion: .word 0
__t48: .word 0
datosIngresados: .word 0
__t49: .word 0
contadorMenu: .word 0
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
__t73: .word 0
__t74: .word 0
__t75: .word 0
__t76: .word 0
__t77: .word 0
__t78: .word 0
__t79: .word 0
__t80: .word 0
__t81: .word 0
__t82: .word 0
__t83: .word 0
__t84: .word 0
__t85: .word 0
__t86: .word 0
__t87: .word 0
__t88: .word 0
__t89: .word 0
__t90: .word 0
__t91: .word 0
__f35: .float 0.0
__f36: .float 0.0
__f37: .float 0.0
__f38: .float 0.0
__t92: .word 0
__t93: .word 0
__t94: .word 0
__t95: .word 0
__t96: .word 0
__t97: .word 0
__t98: .word 0
__t99: .word 0
__t100: .word 0
__t101: .word 0
__f39: .float 0.0
__f40: .float 0.0
__f41: .float 0.0
__f42: .float 0.0
__t102: .word 0
__t103: .word 0
__t104: .word 0
__t105: .word 0
__t106: .word 0
__t107: .word 0
__t108: .word 0
__t109: .word 0
__t110: .word 0
__t111: .word 0
__f43: .float 0.0
__f44: .float 0.0
__f45: .float 0.0
__f46: .float 0.0
__t112: .word 0
__t113: .word 0
__t114: .word 0
__t115: .word 0
__t116: .word 0
__t117: .word 0
__t118: .word 0
__t119: .word 0
__t120: .word 0
__t121: .word 0
__f47: .float 0.0
__f48: .float 0.0
__f49: .float 0.0
__f50: .float 0.0
__f51: .float 0.0
__f52: .float 0.0
__f53: .float 0.0
__f54: .float 0.0
__f55: .float 0.0
__f56: .float 0.0
__f57: .float 0.0
__f58: .float 0.0
__f59: .float 0.0
__t122: .word 0
__t123: .word 0
__t124: .word 0
__t125: .word 0
__t126: .word 0
__t127: .word 0
__t128: .word 0
__t129: .word 0
__t130: .word 0
__t131: .word 0
__t132: .word 0
__t133: .word 0
__t134: .word 0
__t135: .word 0
__t136: .word 0
__t137: .word 0
__t138: .word 0
__t139: .word 0
__t140: .word 0
__t141: .word 0
str0: .asciiz "========================================"
str1: .asciiz "\n"
str2: .asciiz "   SISTEMA DE GESTION DE ESTUDIANTES  "
str3: .asciiz "Visitas al menu: "
str4: .asciiz "1. Ingresar notas"
str5: .asciiz "2. Ver promedio"
str6: .asciiz "3. Ver nota maxima"
str7: .asciiz "4. Ver nota minima"
str8: .asciiz "5. Ver estado"
str9: .asciiz "0. Salir"
str10: .asciiz "Estado: REPROBADO"
str11: .asciiz "Estado: RECUPERACION"
str12: .asciiz "Estado: APROBADO"
str13: .asciiz "BIENVENIDO AL SISTEMA DE GESTION"
str14: .asciiz "Elija una opcion: "
str15: .asciiz "Saliendo del sistema..."
str16: .asciiz "El menu se mostro "
str17: .asciiz " veces"
str18: .asciiz "Ingrese nota 1 (0-7): "
str19: .asciiz "Ingrese nota 2 (0-7): "
str20: .asciiz "Ingrese nota 3 (0-7): "
str21: .asciiz "¡Notas ingresadas correctamente!"
str22: .asciiz "Primero debe ingresar notas (opcion 1)"
str23: .asciiz "El promedio es: "
str24: .asciiz "La nota maxima es: "
str25: .asciiz "La nota minima es: "
str26: .asciiz "--- RESULTADOS ---"
str27: .asciiz "Promedio: "
str28: .asciiz "Nota Maxima: "
str29: .asciiz "Nota Minima: "
str30: .asciiz "Opcion invalida!"
str31: .asciiz "¡Gracias por usar el sistema!"

.text
.globl main
calcularPromedio:
subu $sp, $sp, 88
sw $ra, 84($sp)
s.s $f12, 4($sp)
s.s $f14, 8($sp)
s.s $f16, 12($sp)
l.s $f0, 4($sp)
s.s $f0, 20($sp)
l.s $f0, 8($sp)
s.s $f0, 24($sp)
l.s $f1, 20($sp)
l.s $f2, 24($sp)
add.s $f0, $f1, $f2
s.s $f0, 28($sp)
l.s $f0, 12($sp)
s.s $f0, 32($sp)
l.s $f1, 28($sp)
l.s $f2, 32($sp)
add.s $f0, $f1, $f2
s.s $f0, 36($sp)
l.s $f0, 36($sp)
s.s $f0, 16($sp)
l.s $f0, 16($sp)
s.s $f0, 44($sp)
li.s $f0, 3.0
s.s $f0, 48($sp)
l.s $f1, 44($sp)
l.s $f2, 48($sp)
div.s $f0, $f1, $f2
s.s $f0, 52($sp)
l.s $f0, 52($sp)
s.s $f0, 40($sp)
l.s $f0, 40($sp)
s.s $f0, 56($sp)
l.s $f0, 56($sp)
lw $ra, 84($sp)
addu $sp, $sp, 88
jr $ra
obtenerEstado:
subu $sp, $sp, 72
sw $ra, 68($sp)
s.s $f12, 4($sp)
l.s $f0, 4($sp)
s.s $f0, 8($sp)
li.s $f0, 3.0
s.s $f0, 12($sp)
l.s $f1, 8($sp)
l.s $f2, 12($sp)
c.le.s $f1, $f2
li $t0, 0
bc1f _cmp0
li $t0, 1
_cmp0:
sw $t0, 16($sp)
lw $t0, 16($sp)
beq $t0, $zero, L0
li $t0, 0
sw $t0, 20($sp)
lw $v0, 20($sp)
lw $ra, 68($sp)
addu $sp, $sp, 72
jr $ra
L0:
l.s $f0, 4($sp)
s.s $f0, 24($sp)
li.s $f0, 4.0
s.s $f0, 28($sp)
l.s $f1, 24($sp)
l.s $f2, 28($sp)
c.le.s $f1, $f2
li $t0, 0
bc1f _cmp1
li $t0, 1
_cmp1:
sw $t0, 32($sp)
lw $t0, 32($sp)
beq $t0, $zero, L1
li $t0, 1
sw $t0, 36($sp)
lw $v0, 36($sp)
lw $ra, 68($sp)
addu $sp, $sp, 72
jr $ra
L1:
li $t0, 2
sw $t0, 40($sp)
lw $v0, 40($sp)
lw $ra, 68($sp)
addu $sp, $sp, 72
jr $ra
notaMaxima:
subu $sp, $sp, 88
sw $ra, 84($sp)
s.s $f12, 4($sp)
s.s $f14, 8($sp)
s.s $f16, 12($sp)
l.s $f0, 4($sp)
s.s $f0, 20($sp)
l.s $f0, 20($sp)
s.s $f0, 16($sp)
l.s $f0, 16($sp)
s.s $f0, 24($sp)
l.s $f0, 8($sp)
s.s $f0, 28($sp)
l.s $f1, 24($sp)
l.s $f2, 28($sp)
c.le.s $f1, $f2
li $t0, 0
bc1f _cmp2
li $t0, 1
_cmp2:
sw $t0, 32($sp)
lw $t0, 32($sp)
beq $t0, $zero, L2
l.s $f0, 8($sp)
s.s $f0, 36($sp)
l.s $f0, 36($sp)
s.s $f0, 16($sp)
L2:
l.s $f0, 16($sp)
s.s $f0, 40($sp)
l.s $f0, 12($sp)
s.s $f0, 44($sp)
l.s $f1, 40($sp)
l.s $f2, 44($sp)
c.le.s $f1, $f2
li $t0, 0
bc1f _cmp3
li $t0, 1
_cmp3:
sw $t0, 48($sp)
lw $t0, 48($sp)
beq $t0, $zero, L3
l.s $f0, 12($sp)
s.s $f0, 52($sp)
l.s $f0, 52($sp)
s.s $f0, 16($sp)
L3:
l.s $f0, 16($sp)
s.s $f0, 56($sp)
l.s $f0, 56($sp)
lw $ra, 84($sp)
addu $sp, $sp, 88
jr $ra
notaMinima:
subu $sp, $sp, 88
sw $ra, 84($sp)
s.s $f12, 4($sp)
s.s $f14, 8($sp)
s.s $f16, 12($sp)
l.s $f0, 4($sp)
s.s $f0, 20($sp)
l.s $f0, 20($sp)
s.s $f0, 16($sp)
l.s $f0, 8($sp)
s.s $f0, 24($sp)
l.s $f0, 16($sp)
s.s $f0, 28($sp)
l.s $f1, 24($sp)
l.s $f2, 28($sp)
c.le.s $f1, $f2
li $t0, 0
bc1f _cmp4
li $t0, 1
_cmp4:
sw $t0, 32($sp)
lw $t0, 32($sp)
beq $t0, $zero, L4
l.s $f0, 8($sp)
s.s $f0, 36($sp)
l.s $f0, 36($sp)
s.s $f0, 16($sp)
L4:
l.s $f0, 12($sp)
s.s $f0, 40($sp)
l.s $f0, 16($sp)
s.s $f0, 44($sp)
l.s $f1, 40($sp)
l.s $f2, 44($sp)
c.le.s $f1, $f2
li $t0, 0
bc1f _cmp5
li $t0, 1
_cmp5:
sw $t0, 48($sp)
lw $t0, 48($sp)
beq $t0, $zero, L5
l.s $f0, 12($sp)
s.s $f0, 52($sp)
l.s $f0, 52($sp)
s.s $f0, 16($sp)
L5:
l.s $f0, 16($sp)
s.s $f0, 56($sp)
l.s $f0, 56($sp)
lw $ra, 84($sp)
addu $sp, $sp, 88
jr $ra
mostrarMenu:
subu $sp, $sp, 128
sw $ra, 124($sp)
sw $a0, 4($sp)
la $t0, str0
sw $t0, 8($sp)
lw $a0, 8($sp)
li $v0, 4
syscall
la $t0, str1
sw $t0, 12($sp)
lw $a0, 12($sp)
li $v0, 4
syscall
la $t0, str2
sw $t0, 16($sp)
lw $a0, 16($sp)
li $v0, 4
syscall
la $t0, str1
sw $t0, 20($sp)
lw $a0, 20($sp)
li $v0, 4
syscall
la $t0, str0
sw $t0, 24($sp)
lw $a0, 24($sp)
li $v0, 4
syscall
la $t0, str1
sw $t0, 28($sp)
lw $a0, 28($sp)
li $v0, 4
syscall
la $t0, str3
sw $t0, 32($sp)
lw $a0, 32($sp)
li $v0, 4
syscall
lw $a0, 4($sp)
li $v0, 1
syscall
la $t0, str1
sw $t0, 36($sp)
lw $a0, 36($sp)
li $v0, 4
syscall
la $t0, str4
sw $t0, 40($sp)
lw $a0, 40($sp)
li $v0, 4
syscall
la $t0, str1
sw $t0, 44($sp)
lw $a0, 44($sp)
li $v0, 4
syscall
la $t0, str5
sw $t0, 48($sp)
lw $a0, 48($sp)
li $v0, 4
syscall
la $t0, str1
sw $t0, 52($sp)
lw $a0, 52($sp)
li $v0, 4
syscall
la $t0, str6
sw $t0, 56($sp)
lw $a0, 56($sp)
li $v0, 4
syscall
la $t0, str1
sw $t0, 60($sp)
lw $a0, 60($sp)
li $v0, 4
syscall
la $t0, str7
sw $t0, 64($sp)
lw $a0, 64($sp)
li $v0, 4
syscall
la $t0, str1
sw $t0, 68($sp)
lw $a0, 68($sp)
li $v0, 4
syscall
la $t0, str8
sw $t0, 72($sp)
lw $a0, 72($sp)
li $v0, 4
syscall
la $t0, str1
sw $t0, 76($sp)
lw $a0, 76($sp)
li $v0, 4
syscall
la $t0, str9
sw $t0, 80($sp)
lw $a0, 80($sp)
li $v0, 4
syscall
la $t0, str1
sw $t0, 84($sp)
lw $a0, 84($sp)
li $v0, 4
syscall
la $t0, str0
sw $t0, 88($sp)
lw $a0, 88($sp)
li $v0, 4
syscall
la $t0, str1
sw $t0, 92($sp)
lw $a0, 92($sp)
li $v0, 4
syscall
li $t0, 0
sw $t0, 96($sp)
lw $v0, 96($sp)
lw $ra, 124($sp)
addu $sp, $sp, 128
jr $ra
mostrarEstado:
subu $sp, $sp, 96
sw $ra, 92($sp)
sw $a0, 4($sp)
lw $t0, 4($sp)
sw $t0, 8($sp)
li $t0, 0
sw $t0, 12($sp)
lw $t1, 8($sp)
lw $t2, 12($sp)
seq $t0, $t1, $t2
sw $t0, 16($sp)
lw $t0, 16($sp)
beq $t0, $zero, L6
la $t0, str10
sw $t0, 20($sp)
lw $a0, 20($sp)
li $v0, 4
syscall
la $t0, str1
sw $t0, 24($sp)
lw $a0, 24($sp)
li $v0, 4
syscall
li $t0, 0
sw $t0, 28($sp)
lw $v0, 28($sp)
lw $ra, 92($sp)
addu $sp, $sp, 96
jr $ra
j L7
L6:
lw $t0, 4($sp)
sw $t0, 32($sp)
li $t0, 1
sw $t0, 36($sp)
lw $t1, 32($sp)
lw $t2, 36($sp)
seq $t0, $t1, $t2
sw $t0, 40($sp)
lw $t0, 40($sp)
beq $t0, $zero, L8
la $t0, str11
sw $t0, 44($sp)
lw $a0, 44($sp)
li $v0, 4
syscall
la $t0, str1
sw $t0, 48($sp)
lw $a0, 48($sp)
li $v0, 4
syscall
li $t0, 0
sw $t0, 52($sp)
lw $v0, 52($sp)
lw $ra, 92($sp)
addu $sp, $sp, 96
jr $ra
j L9
L8:
la $t0, str12
sw $t0, 56($sp)
lw $a0, 56($sp)
li $v0, 4
syscall
la $t0, str1
sw $t0, 60($sp)
lw $a0, 60($sp)
li $v0, 4
syscall
li $t0, 0
sw $t0, 64($sp)
lw $v0, 64($sp)
lw $ra, 92($sp)
addu $sp, $sp, 96
jr $ra
L9:
L7:
main:
subu $sp, $sp, 32
sw $ra, 28($sp)
li.s $f0, 0.0
la $t9, __f29
s.s $f0, 0($t9)
la $t9, __f29
l.s $f0, 0($t9)
la $t9, nota1
s.s $f0, 0($t9)
li.s $f0, 0.0
la $t9, __f30
s.s $f0, 0($t9)
la $t9, __f30
l.s $f0, 0($t9)
la $t9, nota2
s.s $f0, 0($t9)
li.s $f0, 0.0
la $t9, __f31
s.s $f0, 0($t9)
la $t9, __f31
l.s $f0, 0($t9)
la $t9, nota3
s.s $f0, 0($t9)
li.s $f0, 0.0
la $t9, __f32
s.s $f0, 0($t9)
la $t9, __f32
l.s $f0, 0($t9)
la $t9, promedio
s.s $f0, 0($t9)
li.s $f0, 0.0
la $t9, __f33
s.s $f0, 0($t9)
la $t9, __f33
l.s $f0, 0($t9)
la $t9, max
s.s $f0, 0($t9)
li.s $f0, 0.0
la $t9, __f34
s.s $f0, 0($t9)
la $t9, __f34
l.s $f0, 0($t9)
la $t9, min
s.s $f0, 0($t9)
li $t0, 0
la $t9, __t47
sw $t0, 0($t9)
la $t9, __t47
lw $t0, 0($t9)
la $t9, estado
sw $t0, 0($t9)
li $t0, 0
la $t9, __t48
sw $t0, 0($t9)
la $t9, __t48
lw $t0, 0($t9)
la $t9, opcion
sw $t0, 0($t9)
li $t0, 0
la $t9, __t49
sw $t0, 0($t9)
la $t9, __t49
lw $t0, 0($t9)
la $t9, datosIngresados
sw $t0, 0($t9)
li $t0, 0
la $t9, __t50
sw $t0, 0($t9)
la $t9, __t50
lw $t0, 0($t9)
la $t9, contadorMenu
sw $t0, 0($t9)
la $t0, str13
la $t9, __t51
sw $t0, 0($t9)
la $t9, __t51
lw $a0, 0($t9)
li $v0, 4
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
_dowhile1_start:
la $t9, contadorMenu
lw $t0, 0($t9)
la $t9, __t54
sw $t0, 0($t9)
li $t0, 1
la $t9, __t55
sw $t0, 0($t9)
la $t9, __t54
lw $t1, 0($t9)
la $t9, __t55
lw $t2, 0($t9)
add $t0, $t1, $t2
la $t9, __t56
sw $t0, 0($t9)
la $t9, __t56
lw $t0, 0($t9)
la $t9, contadorMenu
sw $t0, 0($t9)
la $t9, contadorMenu
lw $t0, 0($t9)
la $t9, __t57
sw $t0, 0($t9)
la $t9, __t57
lw $a0, 0($t9)
jal mostrarMenu
la $t9, __t58
sw $v0, 0($t9)
la $t0, str14
la $t9, __t59
sw $t0, 0($t9)
la $t9, __t59
lw $a0, 0($t9)
li $v0, 4
syscall
li $v0, 5
syscall
la $t9, opcion
sw $v0, 0($t9)
la $t0, str1
la $t9, __t60
sw $t0, 0($t9)
la $t9, __t60
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, opcion
lw $t0, 0($t9)
la $t9, __t61
sw $t0, 0($t9)
li $t0, 0
la $t9, __t62
sw $t0, 0($t9)
la $t9, __t61
lw $t1, 0($t9)
la $t9, __t62
lw $t2, 0($t9)
seq $t0, $t1, $t2
la $t9, __t63
sw $t0, 0($t9)
la $t9, __t63
lw $t0, 0($t9)
beq $t0, $zero, L10
la $t0, str15
la $t9, __t64
sw $t0, 0($t9)
la $t9, __t64
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t65
sw $t0, 0($t9)
la $t9, __t65
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, contadorMenu
lw $t0, 0($t9)
la $t9, __t66
sw $t0, 0($t9)
li $t0, 1
la $t9, __t67
sw $t0, 0($t9)
la $t9, __t66
lw $t1, 0($t9)
la $t9, __t67
lw $t2, 0($t9)
sub $t0, $t1, $t2
la $t9, __t68
sw $t0, 0($t9)
la $t9, __t68
lw $t0, 0($t9)
la $t9, contadorMenu
sw $t0, 0($t9)
la $t0, str16
la $t9, __t69
sw $t0, 0($t9)
la $t9, __t69
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, contadorMenu
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str17
la $t9, __t70
sw $t0, 0($t9)
la $t9, __t70
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t71
sw $t0, 0($t9)
la $t9, __t71
lw $a0, 0($t9)
li $v0, 4
syscall
j L11
L10:
la $t9, opcion
lw $t0, 0($t9)
la $t9, __t72
sw $t0, 0($t9)
li $t0, 1
la $t9, __t73
sw $t0, 0($t9)
la $t9, __t72
lw $t1, 0($t9)
la $t9, __t73
lw $t2, 0($t9)
seq $t0, $t1, $t2
la $t9, __t74
sw $t0, 0($t9)
la $t9, __t74
lw $t0, 0($t9)
beq $t0, $zero, L12
la $t0, str18
la $t9, __t75
sw $t0, 0($t9)
la $t9, __t75
lw $a0, 0($t9)
li $v0, 4
syscall
li $v0, 6
syscall
la $t9, nota1
s.s $f0, 0($t9)
la $t0, str1
la $t9, __t76
sw $t0, 0($t9)
la $t9, __t76
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str19
la $t9, __t77
sw $t0, 0($t9)
la $t9, __t77
lw $a0, 0($t9)
li $v0, 4
syscall
li $v0, 6
syscall
la $t9, nota2
s.s $f0, 0($t9)
la $t0, str1
la $t9, __t78
sw $t0, 0($t9)
la $t9, __t78
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str20
la $t9, __t79
sw $t0, 0($t9)
la $t9, __t79
lw $a0, 0($t9)
li $v0, 4
syscall
li $v0, 6
syscall
la $t9, nota3
s.s $f0, 0($t9)
la $t0, str1
la $t9, __t80
sw $t0, 0($t9)
la $t9, __t80
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 1
la $t9, __t81
sw $t0, 0($t9)
la $t9, __t81
lw $t0, 0($t9)
la $t9, datosIngresados
sw $t0, 0($t9)
la $t0, str21
la $t9, __t82
sw $t0, 0($t9)
la $t9, __t82
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t83
sw $t0, 0($t9)
la $t9, __t83
lw $a0, 0($t9)
li $v0, 4
syscall
j L13
L12:
la $t9, opcion
lw $t0, 0($t9)
la $t9, __t84
sw $t0, 0($t9)
li $t0, 2
la $t9, __t85
sw $t0, 0($t9)
la $t9, __t84
lw $t1, 0($t9)
la $t9, __t85
lw $t2, 0($t9)
seq $t0, $t1, $t2
la $t9, __t86
sw $t0, 0($t9)
la $t9, __t86
lw $t0, 0($t9)
beq $t0, $zero, L14
la $t9, datosIngresados
lw $t0, 0($t9)
la $t9, __t87
sw $t0, 0($t9)
li $t0, 0
la $t9, __t88
sw $t0, 0($t9)
la $t9, __t87
lw $t1, 0($t9)
la $t9, __t88
lw $t2, 0($t9)
seq $t0, $t1, $t2
la $t9, __t89
sw $t0, 0($t9)
la $t9, __t89
lw $t0, 0($t9)
beq $t0, $zero, L15
la $t0, str22
la $t9, __t90
sw $t0, 0($t9)
la $t9, __t90
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t91
sw $t0, 0($t9)
la $t9, __t91
lw $a0, 0($t9)
li $v0, 4
syscall
j L16
L15:
la $t9, nota1
l.s $f0, 0($t9)
la $t9, __f35
s.s $f0, 0($t9)
la $t9, nota2
l.s $f0, 0($t9)
la $t9, __f36
s.s $f0, 0($t9)
la $t9, nota3
l.s $f0, 0($t9)
la $t9, __f37
s.s $f0, 0($t9)
la $t9, __f35
l.s $f12, 0($t9)
la $t9, __f36
l.s $f14, 0($t9)
la $t9, __f37
l.s $f16, 0($t9)
jal calcularPromedio
la $t9, __f38
s.s $f0, 0($t9)
la $t9, __f38
l.s $f0, 0($t9)
la $t9, promedio
s.s $f0, 0($t9)
la $t0, str23
la $t9, __t92
sw $t0, 0($t9)
la $t9, __t92
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, promedio
l.s $f12, 0($t9)
li $v0, 2
syscall
la $t0, str1
la $t9, __t93
sw $t0, 0($t9)
la $t9, __t93
lw $a0, 0($t9)
li $v0, 4
syscall
L16:
j L17
L14:
la $t9, opcion
lw $t0, 0($t9)
la $t9, __t94
sw $t0, 0($t9)
li $t0, 3
la $t9, __t95
sw $t0, 0($t9)
la $t9, __t94
lw $t1, 0($t9)
la $t9, __t95
lw $t2, 0($t9)
seq $t0, $t1, $t2
la $t9, __t96
sw $t0, 0($t9)
la $t9, __t96
lw $t0, 0($t9)
beq $t0, $zero, L18
la $t9, datosIngresados
lw $t0, 0($t9)
la $t9, __t97
sw $t0, 0($t9)
li $t0, 0
la $t9, __t98
sw $t0, 0($t9)
la $t9, __t97
lw $t1, 0($t9)
la $t9, __t98
lw $t2, 0($t9)
seq $t0, $t1, $t2
la $t9, __t99
sw $t0, 0($t9)
la $t9, __t99
lw $t0, 0($t9)
beq $t0, $zero, L19
la $t0, str22
la $t9, __t100
sw $t0, 0($t9)
la $t9, __t100
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t101
sw $t0, 0($t9)
la $t9, __t101
lw $a0, 0($t9)
li $v0, 4
syscall
j L20
L19:
la $t9, nota1
l.s $f0, 0($t9)
la $t9, __f39
s.s $f0, 0($t9)
la $t9, nota2
l.s $f0, 0($t9)
la $t9, __f40
s.s $f0, 0($t9)
la $t9, nota3
l.s $f0, 0($t9)
la $t9, __f41
s.s $f0, 0($t9)
la $t9, __f39
l.s $f12, 0($t9)
la $t9, __f40
l.s $f14, 0($t9)
la $t9, __f41
l.s $f16, 0($t9)
jal notaMaxima
la $t9, __f42
s.s $f0, 0($t9)
la $t9, __f42
l.s $f0, 0($t9)
la $t9, max
s.s $f0, 0($t9)
la $t0, str24
la $t9, __t102
sw $t0, 0($t9)
la $t9, __t102
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, max
l.s $f12, 0($t9)
li $v0, 2
syscall
la $t0, str1
la $t9, __t103
sw $t0, 0($t9)
la $t9, __t103
lw $a0, 0($t9)
li $v0, 4
syscall
L20:
j L21
L18:
la $t9, opcion
lw $t0, 0($t9)
la $t9, __t104
sw $t0, 0($t9)
li $t0, 4
la $t9, __t105
sw $t0, 0($t9)
la $t9, __t104
lw $t1, 0($t9)
la $t9, __t105
lw $t2, 0($t9)
seq $t0, $t1, $t2
la $t9, __t106
sw $t0, 0($t9)
la $t9, __t106
lw $t0, 0($t9)
beq $t0, $zero, L22
la $t9, datosIngresados
lw $t0, 0($t9)
la $t9, __t107
sw $t0, 0($t9)
li $t0, 0
la $t9, __t108
sw $t0, 0($t9)
la $t9, __t107
lw $t1, 0($t9)
la $t9, __t108
lw $t2, 0($t9)
seq $t0, $t1, $t2
la $t9, __t109
sw $t0, 0($t9)
la $t9, __t109
lw $t0, 0($t9)
beq $t0, $zero, L23
la $t0, str22
la $t9, __t110
sw $t0, 0($t9)
la $t9, __t110
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t111
sw $t0, 0($t9)
la $t9, __t111
lw $a0, 0($t9)
li $v0, 4
syscall
j L24
L23:
la $t9, nota1
l.s $f0, 0($t9)
la $t9, __f43
s.s $f0, 0($t9)
la $t9, nota2
l.s $f0, 0($t9)
la $t9, __f44
s.s $f0, 0($t9)
la $t9, nota3
l.s $f0, 0($t9)
la $t9, __f45
s.s $f0, 0($t9)
la $t9, __f43
l.s $f12, 0($t9)
la $t9, __f44
l.s $f14, 0($t9)
la $t9, __f45
l.s $f16, 0($t9)
jal notaMinima
la $t9, __f46
s.s $f0, 0($t9)
la $t9, __f46
l.s $f0, 0($t9)
la $t9, min
s.s $f0, 0($t9)
la $t0, str25
la $t9, __t112
sw $t0, 0($t9)
la $t9, __t112
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, min
l.s $f12, 0($t9)
li $v0, 2
syscall
la $t0, str1
la $t9, __t113
sw $t0, 0($t9)
la $t9, __t113
lw $a0, 0($t9)
li $v0, 4
syscall
L24:
j L25
L22:
la $t9, opcion
lw $t0, 0($t9)
la $t9, __t114
sw $t0, 0($t9)
li $t0, 5
la $t9, __t115
sw $t0, 0($t9)
la $t9, __t114
lw $t1, 0($t9)
la $t9, __t115
lw $t2, 0($t9)
seq $t0, $t1, $t2
la $t9, __t116
sw $t0, 0($t9)
la $t9, __t116
lw $t0, 0($t9)
beq $t0, $zero, L26
la $t9, datosIngresados
lw $t0, 0($t9)
la $t9, __t117
sw $t0, 0($t9)
li $t0, 0
la $t9, __t118
sw $t0, 0($t9)
la $t9, __t117
lw $t1, 0($t9)
la $t9, __t118
lw $t2, 0($t9)
seq $t0, $t1, $t2
la $t9, __t119
sw $t0, 0($t9)
la $t9, __t119
lw $t0, 0($t9)
beq $t0, $zero, L27
la $t0, str22
la $t9, __t120
sw $t0, 0($t9)
la $t9, __t120
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t121
sw $t0, 0($t9)
la $t9, __t121
lw $a0, 0($t9)
li $v0, 4
syscall
j L28
L27:
la $t9, nota1
l.s $f0, 0($t9)
la $t9, __f47
s.s $f0, 0($t9)
la $t9, nota2
l.s $f0, 0($t9)
la $t9, __f48
s.s $f0, 0($t9)
la $t9, nota3
l.s $f0, 0($t9)
la $t9, __f49
s.s $f0, 0($t9)
la $t9, __f47
l.s $f12, 0($t9)
la $t9, __f48
l.s $f14, 0($t9)
la $t9, __f49
l.s $f16, 0($t9)
jal calcularPromedio
la $t9, __f50
s.s $f0, 0($t9)
la $t9, __f50
l.s $f0, 0($t9)
la $t9, promedio
s.s $f0, 0($t9)
la $t9, nota1
l.s $f0, 0($t9)
la $t9, __f51
s.s $f0, 0($t9)
la $t9, nota2
l.s $f0, 0($t9)
la $t9, __f52
s.s $f0, 0($t9)
la $t9, nota3
l.s $f0, 0($t9)
la $t9, __f53
s.s $f0, 0($t9)
la $t9, __f51
l.s $f12, 0($t9)
la $t9, __f52
l.s $f14, 0($t9)
la $t9, __f53
l.s $f16, 0($t9)
jal notaMaxima
la $t9, __f54
s.s $f0, 0($t9)
la $t9, __f54
l.s $f0, 0($t9)
la $t9, max
s.s $f0, 0($t9)
la $t9, nota1
l.s $f0, 0($t9)
la $t9, __f55
s.s $f0, 0($t9)
la $t9, nota2
l.s $f0, 0($t9)
la $t9, __f56
s.s $f0, 0($t9)
la $t9, nota3
l.s $f0, 0($t9)
la $t9, __f57
s.s $f0, 0($t9)
la $t9, __f55
l.s $f12, 0($t9)
la $t9, __f56
l.s $f14, 0($t9)
la $t9, __f57
l.s $f16, 0($t9)
jal notaMinima
la $t9, __f58
s.s $f0, 0($t9)
la $t9, __f58
l.s $f0, 0($t9)
la $t9, min
s.s $f0, 0($t9)
la $t9, promedio
l.s $f0, 0($t9)
la $t9, __f59
s.s $f0, 0($t9)
la $t9, __f59
l.s $f12, 0($t9)
jal obtenerEstado
la $t9, __t122
sw $v0, 0($t9)
la $t9, __t122
lw $t0, 0($t9)
la $t9, estado
sw $t0, 0($t9)
la $t0, str26
la $t9, __t123
sw $t0, 0($t9)
la $t9, __t123
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t124
sw $t0, 0($t9)
la $t9, __t124
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str27
la $t9, __t125
sw $t0, 0($t9)
la $t9, __t125
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, promedio
l.s $f12, 0($t9)
li $v0, 2
syscall
la $t0, str1
la $t9, __t126
sw $t0, 0($t9)
la $t9, __t126
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str28
la $t9, __t127
sw $t0, 0($t9)
la $t9, __t127
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, max
l.s $f12, 0($t9)
li $v0, 2
syscall
la $t0, str1
la $t9, __t128
sw $t0, 0($t9)
la $t9, __t128
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str29
la $t9, __t129
sw $t0, 0($t9)
la $t9, __t129
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, min
l.s $f12, 0($t9)
li $v0, 2
syscall
la $t0, str1
la $t9, __t130
sw $t0, 0($t9)
la $t9, __t130
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, estado
lw $t0, 0($t9)
la $t9, __t131
sw $t0, 0($t9)
la $t9, __t131
lw $a0, 0($t9)
jal mostrarEstado
la $t9, __t132
sw $v0, 0($t9)
la $t0, str1
la $t9, __t133
sw $t0, 0($t9)
la $t9, __t133
lw $a0, 0($t9)
li $v0, 4
syscall
L28:
j L29
L26:
la $t0, str30
la $t9, __t134
sw $t0, 0($t9)
la $t9, __t134
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t135
sw $t0, 0($t9)
la $t9, __t135
lw $a0, 0($t9)
li $v0, 4
syscall
L29:
L25:
L21:
L17:
L13:
L11:
la $t9, opcion
lw $t0, 0($t9)
la $t9, __t136
sw $t0, 0($t9)
li $t0, 0
la $t9, __t137
sw $t0, 0($t9)
la $t9, __t136
lw $t1, 0($t9)
la $t9, __t137
lw $t2, 0($t9)
sne $t0, $t1, $t2
la $t9, __t138
sw $t0, 0($t9)
la $t9, __t138
lw $t0, 0($t9)
bne $t0, $zero, _dowhile1_start
_dowhile1_end:
la $t0, str1
la $t9, __t139
sw $t0, 0($t9)
la $t9, __t139
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str31
la $t9, __t140
sw $t0, 0($t9)
la $t9, __t140
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t141
sw $t0, 0($t9)
la $t9, __t141
lw $a0, 0($t9)
li $v0, 4
syscall
li $v0, 10
syscall
