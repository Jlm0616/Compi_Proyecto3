.data
c: .word 0
r: .word 0
tsw1: .word 0
a: .word 0
var_b: .float 0.0
eq: .word 0
lt: .word 0
gt: .word 0
ge: .word 0
ne: .word 0
base: .float 0.0
temp: .float 0.0
__t31: .word 0
nb: .word 0
__t32: .word 0
__t33: .word 0
f: .float 0.0
__f13: .float 0.0
i: .word 0
__t34: .word 0
__f14: .float 0.0
__f15: .float 0.0
__f16: .float 0.0
__f17: .float 0.0
swR: .word 0
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
__t49: .word 0
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
r1: .word 0
__t60: .word 0
__t61: .word 0
__t62: .word 0
r2: .word 0
__t63: .word 0
__t64: .word 0
__t65: .word 0
r3: .word 0
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
var_neg: .word 0
__t78: .word 0
__t79: .word 0
__t80: .word 0
__t81: .word 0
__t82: .word 0
negF: .float 0.0
__f18: .float 0.0
__f19: .float 0.0
__f20: .float 0.0
__t83: .word 0
__t84: .word 0
__t85: .word 0
__t86: .word 0
__t87: .word 0
expR: .float 0.0
__f21: .float 0.0
__f22: .float 0.0
__t88: .word 0
__t89: .word 0
__t90: .word 0
__t91: .word 0
__t92: .word 0
entradaF: .float 0.0
__f23: .float 0.0
__t93: .word 0
__t94: .word 0
__t95: .word 0
__t96: .word 0
__t97: .word 0
__t98: .word 0
__t99: .word 0
__t100: .word 0
__f24: .float 0.0
__f25: .float 0.0
__t101: .word 0
__t102: .word 0
__f26: .float 0.0
__f27: .float 0.0
__t103: .word 0
__t104: .word 0
__f28: .float 0.0
__f29: .float 0.0
__t105: .word 0
__t106: .word 0
__f30: .float 0.0
__f31: .float 0.0
__t107: .word 0
__t108: .word 0
__t109: .word 0
__f32: .float 0.0
__t110: .word 0
__t111: .word 0
__t112: .word 0
__t113: .word 0
__f33: .float 0.0
__t114: .word 0
__t115: .word 0
__t116: .word 0
__t117: .word 0
__t118: .word 0
__t119: .word 0
__t120: .word 0
__t121: .word 0
__t122: .word 0
__t123: .word 0
__t124: .word 0
__t125: .word 0
__t126: .word 0
__t127: .word 0
__t128: .word 0
v: .word 0
__t129: .word 0
__f34: .float 0.0
__t130: .word 0
__t131: .word 0
__t132: .word 0
__t133: .word 0
__f35: .float 0.0
__t134: .word 0
__t135: .word 0
__t136: .word 0
__t137: .word 0
__t138: .word 0
__t139: .word 0
arrF: .float 0.0, 0.0, 0.0, 0.0
str0: .asciiz "=== BOOL ==="
str1: .asciiz "\n"
str2: .asciiz "b = "
str3: .asciiz "!b = "
str4: .asciiz "=== LOGICOS @ # ==="
str5: .asciiz "true @ true = "
str6: .asciiz "true # false = "
str7: .asciiz "=== RELACIONALES ==="
str8: .asciiz "greather_t(10,5) = "
str9: .asciiz "greather_te(5,5) = "
str10: .asciiz "n_equal(10,20) = "
str11: .asciiz "=== NEGATIVO UNARIO ==="
str12: .asciiz "-10 = "
str13: .asciiz "-3.5 = "
str14: .asciiz "=== EXPONENCIAL ==="
str15: .asciiz "5.0 * 2000 + 1.0 = "
str16: .asciiz "=== CIN FLOAT ==="
str17: .asciiz "Ingrese un float: "
str18: .asciiz "Leiste: "
str19: .asciiz "=== ARREGLO FLOAT ==="
str20: .asciiz "arrF[0][0] = "
str21: .asciiz "arrF[1][1] = "
str22: .asciiz "=== RETURN CHAR (via switch) ==="
str23: .asciiz "evaluarChar('A') = "
str24: .asciiz "evaluarChar('X') = "
str25: .asciiz "=== RETURN BOOL ==="
str26: .asciiz "verificar(10,3.5) = "
str27: .asciiz "verificar(0,0.5) = "
str28: .asciiz "=== FIN PRUEBAS ==="

.text
.globl main
evaluarChar:
subu $sp, $sp, 96
sw $ra, 92($sp)
sw $a0, 4($sp)
li $t0, 0
sw $t0, 12($sp)
lw $t0, 12($sp)
sw $t0, 8($sp)
lw $t0, 4($sp)
sw $t0, 16($sp)
_switch1:
li $t0, 1
sw $t0, 20($sp)
li $t0, 65
sw $t0, 24($sp)
_case1_1:
lw $t1, 20($sp)
li $t2, 0
seq $t0, $t1, $t2
sw $t0, 28($sp)
lw $t0, 28($sp)
bne $t0, $zero, _case1_1_b
lw $t1, 16($sp)
lw $t2, 24($sp)
seq $t0, $t1, $t2
sw $t0, 32($sp)
lw $t0, 32($sp)
bne $t0, $zero, _case1_1_b
j _case1_1_e
_case1_1_b:
li $t0, 0
sw $t0, 20($sp)
li $t0, 1
sw $t0, 36($sp)
lw $t0, 36($sp)
sw $t0, 8($sp)
j _sw1_end
_case1_1_e:
li $t0, 66
sw $t0, 40($sp)
_case1_2:
lw $t1, 20($sp)
li $t2, 0
seq $t0, $t1, $t2
sw $t0, 44($sp)
lw $t0, 44($sp)
bne $t0, $zero, _case1_2_b
lw $t1, 16($sp)
lw $t2, 40($sp)
seq $t0, $t1, $t2
sw $t0, 48($sp)
lw $t0, 48($sp)
bne $t0, $zero, _case1_2_b
j _case1_2_e
_case1_2_b:
li $t0, 0
sw $t0, 20($sp)
li $t0, 2
sw $t0, 52($sp)
lw $t0, 52($sp)
sw $t0, 8($sp)
j _sw1_end
_case1_2_e:
_default1:
li $t0, 0
sw $t0, 56($sp)
lw $t0, 56($sp)
sw $t0, 8($sp)
_sw1_end:
lw $t0, 8($sp)
sw $t0, 60($sp)
lw $v0, 60($sp)
lw $ra, 92($sp)
addu $sp, $sp, 96
jr $ra
verificar:
subu $sp, $sp, 168
sw $ra, 164($sp)
sw $a0, 4($sp)
s.s $f14, 8($sp)
lw $t0, 4($sp)
sw $t0, 16($sp)
li $t0, 10
sw $t0, 20($sp)
lw $t1, 16($sp)
lw $t2, 20($sp)
seq $t0, $t1, $t2
sw $t0, 24($sp)
lw $t0, 24($sp)
sw $t0, 12($sp)
l.s $f0, 8($sp)
s.s $f0, 32($sp)
li.s $f0, 5.0
s.s $f0, 36($sp)
l.s $f1, 32($sp)
l.s $f2, 36($sp)
c.lt.s $f1, $f2
li $t0, 0
bc1f _cmp0
li $t0, 1
_cmp0:
sw $t0, 40($sp)
lw $t0, 40($sp)
sw $t0, 28($sp)
l.s $f0, 8($sp)
s.s $f0, 48($sp)
li.s $f0, 1.0
s.s $f0, 52($sp)
l.s $f1, 48($sp)
l.s $f2, 52($sp)
c.lt.s $f2, $f1
li $t0, 0
bc1f _cmp1
li $t0, 1
_cmp1:
sw $t0, 56($sp)
lw $t0, 56($sp)
sw $t0, 44($sp)
l.s $f0, 8($sp)
s.s $f0, 64($sp)
li.s $f0, 2.0
s.s $f0, 68($sp)
l.s $f1, 64($sp)
l.s $f2, 68($sp)
c.le.s $f2, $f1
li $t0, 0
bc1f _cmp2
li $t0, 1
_cmp2:
sw $t0, 72($sp)
lw $t0, 72($sp)
sw $t0, 60($sp)
lw $t0, 4($sp)
sw $t0, 80($sp)
li $t0, 0
sw $t0, 84($sp)
lw $t1, 80($sp)
lw $t2, 84($sp)
sne $t0, $t1, $t2
sw $t0, 88($sp)
lw $t0, 88($sp)
sw $t0, 76($sp)
lw $t0, 12($sp)
sw $t0, 96($sp)
lw $t0, 28($sp)
sw $t0, 100($sp)
lw $t1, 96($sp)
lw $t2, 100($sp)
and $t0, $t1, $t2
sw $t0, 104($sp)
lw $t0, 104($sp)
sw $t0, 92($sp)
lw $t0, 92($sp)
sw $t0, 108($sp)
lw $t0, 44($sp)
sw $t0, 112($sp)
lw $t1, 108($sp)
lw $t2, 112($sp)
or $t0, $t1, $t2
sw $t0, 116($sp)
lw $t0, 116($sp)
sw $t0, 92($sp)
lw $t0, 92($sp)
sw $t0, 120($sp)
lw $t0, 60($sp)
sw $t0, 124($sp)
lw $t1, 120($sp)
lw $t2, 124($sp)
and $t0, $t1, $t2
sw $t0, 128($sp)
lw $t0, 128($sp)
sw $t0, 92($sp)
lw $t0, 92($sp)
sw $t0, 132($sp)
lw $v0, 132($sp)
lw $ra, 164($sp)
addu $sp, $sp, 168
jr $ra
exponencial:
subu $sp, $sp, 72
sw $ra, 68($sp)
s.s $f12, 4($sp)
l.s $f0, 4($sp)
s.s $f0, 12($sp)
li.s $f0, 2000.0
s.s $f0, 16($sp)
l.s $f1, 12($sp)
l.s $f2, 16($sp)
mul.s $f0, $f1, $f2
s.s $f0, 20($sp)
l.s $f0, 20($sp)
s.s $f0, 8($sp)
l.s $f0, 8($sp)
s.s $f0, 28($sp)
li.s $f0, 1.0
s.s $f0, 32($sp)
l.s $f1, 28($sp)
l.s $f2, 32($sp)
add.s $f0, $f1, $f2
s.s $f0, 36($sp)
l.s $f0, 36($sp)
cvt.w.s $f0, $f0
mfc1 $t0, $f0
sw $t0, 24($sp)
lw $t0, 24($sp)
mtc1 $t0, $f0
cvt.s.w $f0, $f0
s.s $f0, 40($sp)
l.s $f0, 40($sp)
lw $ra, 68($sp)
addu $sp, $sp, 72
jr $ra
main:
subu $sp, $sp, 32
sw $ra, 28($sp)
li $t0, 1
la $t9, __t31
sw $t0, 0($t9)
la $t9, __t31
lw $t0, 0($t9)
mtc1 $t0, $f0
cvt.s.w $f0, $f0
la $t9, var_b
s.s $f0, 0($t9)
li $t0, 0
la $t9, __t32
sw $t0, 0($t9)
la $t9, __t32
lw $t0, 0($t9)
la $t9, nb
sw $t0, 0($t9)
li $t0, 65
la $t9, __t33
sw $t0, 0($t9)
la $t9, __t33
lw $t0, 0($t9)
la $t9, c
sw $t0, 0($t9)
li.s $f0, 3.5
la $t9, __f13
s.s $f0, 0($t9)
la $t9, __f13
l.s $f0, 0($t9)
la $t9, f
s.s $f0, 0($t9)
li $t0, 10
la $t9, __t34
sw $t0, 0($t9)
la $t9, __t34
lw $t0, 0($t9)
la $t9, i
sw $t0, 0($t9)
li.s $f0, 0.0
la $t9, __f14
s.s $f0, 0($t9)
li.s $f0, 0.0
la $t9, __f15
s.s $f0, 0($t9)
li.s $f0, 0.0
la $t9, __f16
s.s $f0, 0($t9)
li.s $f0, 0.0
la $t9, __f17
s.s $f0, 0($t9)
li $t8, 0
li $t9, 2
mul $t8, $t8, $t9
li $t9, 0
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, arrF
add $t8, $t9, $t8
la $t9, __f14
l.s $f0, 0($t9)
s.s $f0, 0($t8)
li $t8, 0
li $t9, 2
mul $t8, $t8, $t9
li $t9, 1
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, arrF
add $t8, $t9, $t8
la $t9, __f15
l.s $f0, 0($t9)
s.s $f0, 0($t8)
li $t8, 1
li $t9, 2
mul $t8, $t8, $t9
li $t9, 0
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, arrF
add $t8, $t9, $t8
la $t9, __f16
l.s $f0, 0($t9)
s.s $f0, 0($t8)
li $t8, 1
li $t9, 2
mul $t8, $t8, $t9
li $t9, 1
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, arrF
add $t8, $t9, $t8
la $t9, __f17
l.s $f0, 0($t9)
s.s $f0, 0($t8)
li $t0, 0
la $t9, __t35
sw $t0, 0($t9)
la $t9, __t35
lw $t0, 0($t9)
la $t9, swR
sw $t0, 0($t9)
la $t0, str0
la $t9, __t36
sw $t0, 0($t9)
la $t9, __t36
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t37
sw $t0, 0($t9)
la $t9, __t37
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str2
la $t9, __t38
sw $t0, 0($t9)
la $t9, __t38
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, var_b
l.s $f12, 0($t9)
li $v0, 2
syscall
la $t0, str1
la $t9, __t39
sw $t0, 0($t9)
la $t9, __t39
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, var_b
l.s $f0, 0($t9)
cvt.w.s $f0, $f0
mfc1 $t0, $f0
la $t9, __t40
sw $t0, 0($t9)
la $t9, __t40
lw $t1, 0($t9)
xori $t0, $t1, 1
la $t9, __t41
sw $t0, 0($t9)
la $t9, __t41
lw $t0, 0($t9)
la $t9, nb
sw $t0, 0($t9)
la $t0, str3
la $t9, __t42
sw $t0, 0($t9)
la $t9, __t42
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, nb
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t43
sw $t0, 0($t9)
la $t9, __t43
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t44
sw $t0, 0($t9)
la $t9, __t44
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str4
la $t9, __t45
sw $t0, 0($t9)
la $t9, __t45
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t46
sw $t0, 0($t9)
la $t9, __t46
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 1
la $t9, __t47
sw $t0, 0($t9)
li $t0, 1
la $t9, __t48
sw $t0, 0($t9)
la $t9, __t47
lw $t1, 0($t9)
la $t9, __t48
lw $t2, 0($t9)
and $t0, $t1, $t2
la $t9, __t49
sw $t0, 0($t9)
la $t9, __t49
lw $t0, 0($t9)
mtc1 $t0, $f0
cvt.s.w $f0, $f0
la $t9, var_b
s.s $f0, 0($t9)
la $t0, str5
la $t9, __t50
sw $t0, 0($t9)
la $t9, __t50
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, var_b
l.s $f12, 0($t9)
li $v0, 2
syscall
la $t0, str1
la $t9, __t51
sw $t0, 0($t9)
la $t9, __t51
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 1
la $t9, __t52
sw $t0, 0($t9)
li $t0, 0
la $t9, __t53
sw $t0, 0($t9)
la $t9, __t52
lw $t1, 0($t9)
la $t9, __t53
lw $t2, 0($t9)
or $t0, $t1, $t2
la $t9, __t54
sw $t0, 0($t9)
la $t9, __t54
lw $t0, 0($t9)
mtc1 $t0, $f0
cvt.s.w $f0, $f0
la $t9, var_b
s.s $f0, 0($t9)
la $t0, str6
la $t9, __t55
sw $t0, 0($t9)
la $t9, __t55
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, var_b
l.s $f12, 0($t9)
li $v0, 2
syscall
la $t0, str1
la $t9, __t56
sw $t0, 0($t9)
la $t9, __t56
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t57
sw $t0, 0($t9)
la $t9, __t57
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str7
la $t9, __t58
sw $t0, 0($t9)
la $t9, __t58
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t59
sw $t0, 0($t9)
la $t9, __t59
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 10
la $t9, __t60
sw $t0, 0($t9)
li $t0, 5
la $t9, __t61
sw $t0, 0($t9)
la $t9, __t60
lw $t1, 0($t9)
la $t9, __t61
lw $t2, 0($t9)
sgt $t0, $t1, $t2
la $t9, __t62
sw $t0, 0($t9)
la $t9, __t62
lw $t0, 0($t9)
la $t9, r1
sw $t0, 0($t9)
li $t0, 5
la $t9, __t63
sw $t0, 0($t9)
li $t0, 5
la $t9, __t64
sw $t0, 0($t9)
la $t9, __t63
lw $t1, 0($t9)
la $t9, __t64
lw $t2, 0($t9)
sge $t0, $t1, $t2
la $t9, __t65
sw $t0, 0($t9)
la $t9, __t65
lw $t0, 0($t9)
la $t9, r2
sw $t0, 0($t9)
li $t0, 10
la $t9, __t66
sw $t0, 0($t9)
li $t0, 20
la $t9, __t67
sw $t0, 0($t9)
la $t9, __t66
lw $t1, 0($t9)
la $t9, __t67
lw $t2, 0($t9)
sne $t0, $t1, $t2
la $t9, __t68
sw $t0, 0($t9)
la $t9, __t68
lw $t0, 0($t9)
la $t9, r3
sw $t0, 0($t9)
la $t0, str8
la $t9, __t69
sw $t0, 0($t9)
la $t9, __t69
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, r1
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t70
sw $t0, 0($t9)
la $t9, __t70
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str9
la $t9, __t71
sw $t0, 0($t9)
la $t9, __t71
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, r2
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t72
sw $t0, 0($t9)
la $t9, __t72
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str10
la $t9, __t73
sw $t0, 0($t9)
la $t9, __t73
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, r3
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t74
sw $t0, 0($t9)
la $t9, __t74
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t75
sw $t0, 0($t9)
la $t9, __t75
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str11
la $t9, __t76
sw $t0, 0($t9)
la $t9, __t76
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t77
sw $t0, 0($t9)
la $t9, __t77
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, i
lw $t0, 0($t9)
la $t9, __t78
sw $t0, 0($t9)
li $t0, -1
la $t9, __t79
sw $t0, 0($t9)
la $t9, __t78
lw $t1, 0($t9)
la $t9, __t79
lw $t2, 0($t9)
mul $t0, $t1, $t2
la $t9, __t80
sw $t0, 0($t9)
la $t9, __t80
lw $t0, 0($t9)
la $t9, var_neg
sw $t0, 0($t9)
la $t0, str12
la $t9, __t81
sw $t0, 0($t9)
la $t9, __t81
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, var_neg
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t82
sw $t0, 0($t9)
la $t9, __t82
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, f
l.s $f0, 0($t9)
la $t9, __f18
s.s $f0, 0($t9)
li.s $f0, -1.0
la $t9, __f19
s.s $f0, 0($t9)
la $t9, __f18
l.s $f1, 0($t9)
la $t9, __f19
l.s $f2, 0($t9)
mul.s $f0, $f1, $f2
la $t9, __f20
s.s $f0, 0($t9)
la $t9, __f20
l.s $f0, 0($t9)
la $t9, negF
s.s $f0, 0($t9)
la $t0, str13
la $t9, __t83
sw $t0, 0($t9)
la $t9, __t83
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, negF
l.s $f12, 0($t9)
li $v0, 2
syscall
la $t0, str1
la $t9, __t84
sw $t0, 0($t9)
la $t9, __t84
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t85
sw $t0, 0($t9)
la $t9, __t85
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str14
la $t9, __t86
sw $t0, 0($t9)
la $t9, __t86
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t87
sw $t0, 0($t9)
la $t9, __t87
lw $a0, 0($t9)
li $v0, 4
syscall
li.s $f0, 5.0
la $t9, __f21
s.s $f0, 0($t9)
la $t9, __f21
l.s $f12, 0($t9)
jal exponencial
la $t9, __f22
s.s $f0, 0($t9)
la $t9, __f22
l.s $f0, 0($t9)
la $t9, expR
s.s $f0, 0($t9)
la $t0, str15
la $t9, __t88
sw $t0, 0($t9)
la $t9, __t88
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, expR
l.s $f12, 0($t9)
li $v0, 2
syscall
la $t0, str1
la $t9, __t89
sw $t0, 0($t9)
la $t9, __t89
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t90
sw $t0, 0($t9)
la $t9, __t90
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str16
la $t9, __t91
sw $t0, 0($t9)
la $t9, __t91
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t92
sw $t0, 0($t9)
la $t9, __t92
lw $a0, 0($t9)
li $v0, 4
syscall
li.s $f0, 0.0
la $t9, __f23
s.s $f0, 0($t9)
la $t9, __f23
l.s $f0, 0($t9)
la $t9, entradaF
s.s $f0, 0($t9)
la $t0, str17
la $t9, __t93
sw $t0, 0($t9)
la $t9, __t93
lw $a0, 0($t9)
li $v0, 4
syscall
li $v0, 6
syscall
la $t9, entradaF
s.s $f0, 0($t9)
la $t0, str18
la $t9, __t94
sw $t0, 0($t9)
la $t9, __t94
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, entradaF
l.s $f12, 0($t9)
li $v0, 2
syscall
la $t0, str1
la $t9, __t95
sw $t0, 0($t9)
la $t9, __t95
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t96
sw $t0, 0($t9)
la $t9, __t96
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str19
la $t9, __t97
sw $t0, 0($t9)
la $t9, __t97
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t98
sw $t0, 0($t9)
la $t9, __t98
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 0
la $t9, __t99
sw $t0, 0($t9)
li $t0, 0
la $t9, __t100
sw $t0, 0($t9)
la $t9, __t99
lw $t8, 0($t9)
li $t9, 2
mul $t8, $t8, $t9
la $t9, __t100
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, arrF
add $t8, $t9, $t8
l.s $f0, 0($t8)
la $t9, __f24
s.s $f0, 0($t9)
li.s $f0, 1.5
la $t9, __f25
s.s $f0, 0($t9)
la $t9, __t99
lw $t8, 0($t9)
li $t9, 2
mul $t8, $t8, $t9
la $t9, __t100
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, arrF
add $t8, $t9, $t8
la $t9, __f25
l.s $f0, 0($t9)
s.s $f0, 0($t8)
li $t0, 0
la $t9, __t101
sw $t0, 0($t9)
li $t0, 1
la $t9, __t102
sw $t0, 0($t9)
la $t9, __t101
lw $t8, 0($t9)
li $t9, 2
mul $t8, $t8, $t9
la $t9, __t102
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, arrF
add $t8, $t9, $t8
l.s $f0, 0($t8)
la $t9, __f26
s.s $f0, 0($t9)
li.s $f0, 2.5
la $t9, __f27
s.s $f0, 0($t9)
la $t9, __t101
lw $t8, 0($t9)
li $t9, 2
mul $t8, $t8, $t9
la $t9, __t102
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, arrF
add $t8, $t9, $t8
la $t9, __f27
l.s $f0, 0($t9)
s.s $f0, 0($t8)
li $t0, 1
la $t9, __t103
sw $t0, 0($t9)
li $t0, 0
la $t9, __t104
sw $t0, 0($t9)
la $t9, __t103
lw $t8, 0($t9)
li $t9, 2
mul $t8, $t8, $t9
la $t9, __t104
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, arrF
add $t8, $t9, $t8
l.s $f0, 0($t8)
la $t9, __f28
s.s $f0, 0($t9)
li.s $f0, 3.5
la $t9, __f29
s.s $f0, 0($t9)
la $t9, __t103
lw $t8, 0($t9)
li $t9, 2
mul $t8, $t8, $t9
la $t9, __t104
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, arrF
add $t8, $t9, $t8
la $t9, __f29
l.s $f0, 0($t9)
s.s $f0, 0($t8)
li $t0, 1
la $t9, __t105
sw $t0, 0($t9)
li $t0, 1
la $t9, __t106
sw $t0, 0($t9)
la $t9, __t105
lw $t8, 0($t9)
li $t9, 2
mul $t8, $t8, $t9
la $t9, __t106
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, arrF
add $t8, $t9, $t8
l.s $f0, 0($t8)
la $t9, __f30
s.s $f0, 0($t9)
li.s $f0, 4.5
la $t9, __f31
s.s $f0, 0($t9)
la $t9, __t105
lw $t8, 0($t9)
li $t9, 2
mul $t8, $t8, $t9
la $t9, __t106
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, arrF
add $t8, $t9, $t8
la $t9, __f31
l.s $f0, 0($t9)
s.s $f0, 0($t8)
la $t0, str20
la $t9, __t107
sw $t0, 0($t9)
la $t9, __t107
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 0
la $t9, __t108
sw $t0, 0($t9)
li $t0, 0
la $t9, __t109
sw $t0, 0($t9)
la $t9, __t108
lw $t8, 0($t9)
li $t9, 2
mul $t8, $t8, $t9
la $t9, __t109
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, arrF
add $t8, $t9, $t8
l.s $f0, 0($t8)
la $t9, __f32
s.s $f0, 0($t9)
la $t9, __f32
l.s $f12, 0($t9)
li $v0, 2
syscall
la $t0, str1
la $t9, __t110
sw $t0, 0($t9)
la $t9, __t110
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str21
la $t9, __t111
sw $t0, 0($t9)
la $t9, __t111
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 1
la $t9, __t112
sw $t0, 0($t9)
li $t0, 1
la $t9, __t113
sw $t0, 0($t9)
la $t9, __t112
lw $t8, 0($t9)
li $t9, 2
mul $t8, $t8, $t9
la $t9, __t113
lw $t9, 0($t9)
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, arrF
add $t8, $t9, $t8
l.s $f0, 0($t8)
la $t9, __f33
s.s $f0, 0($t9)
la $t9, __f33
l.s $f12, 0($t9)
li $v0, 2
syscall
la $t0, str1
la $t9, __t114
sw $t0, 0($t9)
la $t9, __t114
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t115
sw $t0, 0($t9)
la $t9, __t115
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str22
la $t9, __t116
sw $t0, 0($t9)
la $t9, __t116
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t117
sw $t0, 0($t9)
la $t9, __t117
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 65
la $t9, __t118
sw $t0, 0($t9)
la $t9, __t118
lw $a0, 0($t9)
jal evaluarChar
la $t9, __t119
sw $v0, 0($t9)
la $t9, __t119
lw $t0, 0($t9)
la $t9, swR
sw $t0, 0($t9)
la $t0, str23
la $t9, __t120
sw $t0, 0($t9)
la $t9, __t120
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, swR
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t121
sw $t0, 0($t9)
la $t9, __t121
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 88
la $t9, __t122
sw $t0, 0($t9)
la $t9, __t122
lw $a0, 0($t9)
jal evaluarChar
la $t9, __t123
sw $v0, 0($t9)
la $t9, __t123
lw $t0, 0($t9)
la $t9, swR
sw $t0, 0($t9)
la $t0, str24
la $t9, __t124
sw $t0, 0($t9)
la $t9, __t124
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, swR
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t125
sw $t0, 0($t9)
la $t9, __t125
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t126
sw $t0, 0($t9)
la $t9, __t126
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str25
la $t9, __t127
sw $t0, 0($t9)
la $t9, __t127
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t128
sw $t0, 0($t9)
la $t9, __t128
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 10
la $t9, __t129
sw $t0, 0($t9)
li.s $f0, 3.5
la $t9, __f34
s.s $f0, 0($t9)
la $t9, __t129
lw $a0, 0($t9)
la $t9, __f34
l.s $f14, 0($t9)
jal verificar
la $t9, __t130
sw $v0, 0($t9)
la $t9, __t130
lw $t0, 0($t9)
la $t9, v
sw $t0, 0($t9)
la $t0, str26
la $t9, __t131
sw $t0, 0($t9)
la $t9, __t131
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, v
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t132
sw $t0, 0($t9)
la $t9, __t132
lw $a0, 0($t9)
li $v0, 4
syscall
li $t0, 0
la $t9, __t133
sw $t0, 0($t9)
li.s $f0, 0.5
la $t9, __f35
s.s $f0, 0($t9)
la $t9, __t133
lw $a0, 0($t9)
la $t9, __f35
l.s $f14, 0($t9)
jal verificar
la $t9, __t134
sw $v0, 0($t9)
la $t9, __t134
lw $t0, 0($t9)
la $t9, v
sw $t0, 0($t9)
la $t0, str27
la $t9, __t135
sw $t0, 0($t9)
la $t9, __t135
lw $a0, 0($t9)
li $v0, 4
syscall
la $t9, v
lw $a0, 0($t9)
li $v0, 1
syscall
la $t0, str1
la $t9, __t136
sw $t0, 0($t9)
la $t9, __t136
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t137
sw $t0, 0($t9)
la $t9, __t137
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str28
la $t9, __t138
sw $t0, 0($t9)
la $t9, __t138
lw $a0, 0($t9)
li $v0, 4
syscall
la $t0, str1
la $t9, __t139
sw $t0, 0($t9)
la $t9, __t139
lw $a0, 0($t9)
li $v0, 4
syscall
li $v0, 10
syscall
