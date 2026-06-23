.data
countA: .word 0
__t0: .word 0
countB: .word 0
__t1: .word 0
countC: .word 0
__t2: .word 0
maxSuma: .word 0
__t3: .word 0
sumaFloat: .float 0.0
__f0: .float 0.0
__t4: .word 0
__t5: .word 0
__t6: .word 0
__t7: .word 0
__t8: .word 0
__t9: .word 0
__t10: .word 0
__t11: .word 0
__t12: .word 0
i: .word 0
__t13: .word 0
xf: .float 0.0
__f1: .float 0.0
var_j: .word 0
__t14: .word 0
yf: .float 0.0
__f2: .float 0.0
k: .word 0
__t15: .word 0
suma: .word 0
__t16: .word 0
__t17: .word 0
__t18: .word 0
__t19: .word 0
__t20: .word 0
__t21: .word 0
__t22: .word 0
__t23: .word 0
__t24: .word 0
r: .word 0
__t25: .word 0
__t26: .word 0
__t27: .word 0
categoria: .word 0
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
cond1: .word 0
__f3: .float 0.0
__f4: .float 0.0
__t38: .word 0
cond2: .word 0
__t39: .word 0
__t40: .word 0
__t41: .word 0
combinada: .word 0
__t42: .word 0
__t43: .word 0
__t44: .word 0
negCombinada: .word 0
__t45: .word 0
__t46: .word 0
__t47: .word 0
tsw1: .word 0
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
__f5: .float 0.0
__f6: .float 0.0
__f7: .float 0.0
__f8: .float 0.0
__f9: .float 0.0
__t81: .word 0
__t82: .word 0
__t83: .word 0
__t84: .word 0
__f10: .float 0.0
__f11: .float 0.0
__f12: .float 0.0
__t85: .word 0
__t86: .word 0
__t87: .word 0
__t88: .word 0
__t89: .word 0
__t90: .word 0
__t91: .word 0
__t92: .word 0
__t93: .word 0
__t94: .word 0
__t95: .word 0
__t96: .word 0
__f13: .float 0.0
__f14: .float 0.0
__f15: .float 0.0
__t97: .word 0
__t98: .word 0
__t99: .word 0
__t100: .word 0
__t101: .word 0
__t102: .word 0
potenciaFinal: .word 0
__t103: .word 0
__t104: .word 0
__t105: .word 0
__t106: .word 0
__t107: .word 0
__t108: .word 0
__t109: .word 0
__t110: .word 0
__t111: .word 0
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
__t142: .word 0
__t143: .word 0
__t144: .word 0
__t145: .word 0
__t146: .word 0
__t147: .word 0
__t148: .word 0
__t149: .word 0
__t150: .word 0
__t151: .word 0
__t152: .word 0
__t153: .word 0
__t154: .word 0
__t155: .word 0
__t156: .word 0
__t157: .word 0
matriz: .word 0:9
str0: .asciiz "countA(X)="
str1: .asciiz "\n"
str2: .asciiz "countB(Y)="
str3: .asciiz "countC(Z)="
str4: .asciiz "maxSuma="
str5: .asciiz "sumaFloat="
str6: .asciiz "potencia 3^maxSuma="
str7: .asciiz "Matriz fila 0: "
str8: .asciiz " "
str9: .asciiz "Matriz fila 1: "
str10: .asciiz "Matriz fila 2: "

.text
.globl main
main:
li $t0, 0
sw $t0, __t0
lw $t0, __t0
sw $t0, countA
li $t0, 0
sw $t0, __t1
lw $t0, __t1
sw $t0, countB
li $t0, 0
sw $t0, __t2
lw $t0, __t2
sw $t0, countC
li $t0, 0
sw $t0, __t3
lw $t0, __t3
sw $t0, maxSuma
li.s $f0, 0.0
s.s $f0, __f0
l.s $f0, __f0
s.s $f0, sumaFloat
li $t0, 0
sw $t0, __t4
li $t0, 0
sw $t0, __t5
li $t0, 0
sw $t0, __t6
li $t0, 0
sw $t0, __t7
li $t0, 0
sw $t0, __t8
li $t0, 0
sw $t0, __t9
li $t0, 0
sw $t0, __t10
li $t0, 0
sw $t0, __t11
li $t0, 0
sw $t0, __t12
li $t8, 0
li $t9, 3
mul $t8, $t8, $t9
li $t9, 0
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, __t4
sw $t0, 0($t9)
li $t8, 0
li $t9, 3
mul $t8, $t8, $t9
li $t9, 1
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, __t5
sw $t0, 0($t9)
li $t8, 0
li $t9, 3
mul $t8, $t8, $t9
li $t9, 2
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, __t6
sw $t0, 0($t9)
li $t8, 1
li $t9, 3
mul $t8, $t8, $t9
li $t9, 0
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, __t7
sw $t0, 0($t9)
li $t8, 1
li $t9, 3
mul $t8, $t8, $t9
li $t9, 1
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, __t8
sw $t0, 0($t9)
li $t8, 1
li $t9, 3
mul $t8, $t8, $t9
li $t9, 2
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, __t9
sw $t0, 0($t9)
li $t8, 2
li $t9, 3
mul $t8, $t8, $t9
li $t9, 0
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, __t10
sw $t0, 0($t9)
li $t8, 2
li $t9, 3
mul $t8, $t8, $t9
li $t9, 1
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, __t11
sw $t0, 0($t9)
li $t8, 2
li $t9, 3
mul $t8, $t8, $t9
li $t9, 2
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, __t12
sw $t0, 0($t9)
li $t0, 1
sw $t0, __t13
lw $t0, __t13
sw $t0, i
li.s $f0, 1.5
s.s $f0, __f1
l.s $f0, __f1
s.s $f0, xf
_dowhile1_start:
li $t0, 1
sw $t0, __t14
lw $t0, __t14
sw $t0, var_j
li.s $f0, 1.5
s.s $f0, __f2
l.s $f0, __f2
s.s $f0, yf
_dowhile2_start:
li $t0, 1
sw $t0, __t15
lw $t0, __t15
sw $t0, k
_dowhile3_start:
lw $t0, i
sw $t0, __t16
lw $t0, var_j
sw $t0, __t17
lw $t1, __t16
lw $t2, __t17
add $t0, $t1, $t2
sw $t0, __t18
lw $t0, k
sw $t0, __t19
lw $t1, __t18
lw $t2, __t19
add $t0, $t1, $t2
sw $t0, __t20
lw $t0, __t20
sw $t0, suma
lw $t0, suma
sw $t0, __t21
lw $t0, maxSuma
sw $t0, __t22
lw $t1, __t21
lw $t2, __t22
sgt $t0, $t1, $t2
sw $t0, __t23
lw $t0, __t23
beq $t0, $zero, L0
lw $t0, suma
sw $t0, __t24
lw $t0, __t24
sw $t0, maxSuma
L0:
lw $t0, suma
sw $t0, __t25
li $t0, 3
sw $t0, __t26
lw $t1, __t25
lw $t2, __t26
div $t1, $t2
mfhi $t0
sw $t0, __t27
lw $t0, __t27
sw $t0, r
li $t0, 88
sw $t0, __t28
lw $t0, __t28
sw $t0, categoria
lw $t0, r
sw $t0, __t29
li $t0, 0
sw $t0, __t30
lw $t1, __t29
lw $t2, __t30
seq $t0, $t1, $t2
sw $t0, __t31
lw $t0, __t31
beq $t0, $zero, L1
li $t0, 88
sw $t0, __t32
lw $t0, __t32
sw $t0, categoria
j L2
L1:
lw $t0, r
sw $t0, __t33
li $t0, 1
sw $t0, __t34
lw $t1, __t33
lw $t2, __t34
seq $t0, $t1, $t2
sw $t0, __t35
lw $t0, __t35
beq $t0, $zero, L3
li $t0, 89
sw $t0, __t36
lw $t0, __t36
sw $t0, categoria
j L4
L3:
li $t0, 90
sw $t0, __t37
lw $t0, __t37
sw $t0, categoria
L4:
L2:
l.s $f0, xf
s.s $f0, __f3
l.s $f0, yf
s.s $f0, __f4
l.s $f1, __f3
l.s $f2, __f4
c.le.s $f1, $f2
li $t0, 0
bc1t _cmp1
li $t0, 1
_cmp1:
sw $t0, __t38
lw $t0, __t38
sw $t0, cond1
lw $t0, suma
sw $t0, __t39
li $t0, 6
sw $t0, __t40
lw $t1, __t39
lw $t2, __t40
seq $t0, $t1, $t2
sw $t0, __t41
lw $t0, __t41
sw $t0, cond2
lw $t0, cond1
sw $t0, __t42
lw $t0, cond2
sw $t0, __t43
lw $t1, __t42
lw $t2, __t43
and $t0, $t1, $t2
sw $t0, __t44
lw $t0, __t44
sw $t0, combinada
lw $t0, combinada
sw $t0, __t45
lw $t1, __t45
xori $t0, $t1, 1
sw $t0, __t46
lw $t0, __t46
sw $t0, negCombinada
lw $t0, categoria
sw $t0, __t47
_switch1:
li $t0, 1
sw $t0, tsw1
li $t0, 88
sw $t0, __t48
_case1_1:
lw $t1, tsw1
li $t2, 0
seq $t0, $t1, $t2
sw $t0, __t49
lw $t0, __t49
bne $t0, $zero, _case1_1_b
lw $t1, __t47
lw $t2, __t48
seq $t0, $t1, $t2
sw $t0, __t50
lw $t0, __t50
bne $t0, $zero, _case1_1_b
j _case1_1_e
_case1_1_b:
li $t0, 0
sw $t0, tsw1
lw $t0, countA
sw $t0, __t51
li $t0, 1
sw $t0, __t52
lw $t1, __t51
lw $t2, __t52
add $t0, $t1, $t2
sw $t0, __t53
lw $t0, __t53
sw $t0, countA
lw $t0, i
sw $t0, __t54
li $t0, 3
sw $t0, __t55
lw $t1, __t54
lw $t2, __t55
div $t1, $t2
mfhi $t0
sw $t0, __t56
lw $t0, var_j
sw $t0, __t57
lw $t0, k
sw $t0, __t58
lw $t1, __t57
lw $t2, __t58
add $t0, $t1, $t2
sw $t0, __t59
li $t0, 3
sw $t0, __t60
lw $t1, __t59
lw $t2, __t60
div $t1, $t2
mfhi $t0
sw $t0, __t61
lw $t8, __t56
li $t9, 3
mul $t8, $t8, $t9
lw $t9, __t61
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, 0($t9)
sw $t0, __t62
lw $t0, i
sw $t0, __t63
li $t0, 3
sw $t0, __t64
lw $t1, __t63
lw $t2, __t64
div $t1, $t2
mfhi $t0
sw $t0, __t65
lw $t0, var_j
sw $t0, __t66
lw $t0, k
sw $t0, __t67
lw $t1, __t66
lw $t2, __t67
add $t0, $t1, $t2
sw $t0, __t68
li $t0, 3
sw $t0, __t69
lw $t1, __t68
lw $t2, __t69
div $t1, $t2
mfhi $t0
sw $t0, __t70
lw $t8, __t65
li $t9, 3
mul $t8, $t8, $t9
lw $t9, __t70
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, 0($t9)
sw $t0, __t71
li $t0, 1
sw $t0, __t72
lw $t1, __t71
lw $t2, __t72
add $t0, $t1, $t2
sw $t0, __t73
lw $t8, __t56
li $t9, 3
mul $t8, $t8, $t9
lw $t9, __t61
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, __t73
sw $t0, 0($t9)
j _sw1_end
_case1_1_e:
li $t0, 89
sw $t0, __t74
_case1_2:
lw $t1, tsw1
li $t2, 0
seq $t0, $t1, $t2
sw $t0, __t75
lw $t0, __t75
bne $t0, $zero, _case1_2_b
lw $t1, __t47
lw $t2, __t74
seq $t0, $t1, $t2
sw $t0, __t76
lw $t0, __t76
bne $t0, $zero, _case1_2_b
j _case1_2_e
_case1_2_b:
li $t0, 0
sw $t0, tsw1
lw $t0, countB
sw $t0, __t77
li $t0, 1
sw $t0, __t78
lw $t1, __t77
lw $t2, __t78
add $t0, $t1, $t2
sw $t0, __t79
lw $t0, __t79
sw $t0, countB
lw $t0, combinada
sw $t0, __t80
lw $t0, __t80
beq $t0, $zero, L5
l.s $f0, sumaFloat
s.s $f0, __f5
l.s $f0, xf
s.s $f0, __f6
l.s $f1, __f5
l.s $f2, __f6
add.s $f0, $f1, $f2
s.s $f0, __f7
l.s $f0, yf
s.s $f0, __f8
l.s $f1, __f7
l.s $f2, __f8
add.s $f0, $f1, $f2
s.s $f0, __f9
l.s $f0, __f9
s.s $f0, sumaFloat
L5:
j _sw1_end
_case1_2_e:
_default1:
lw $t0, countC
sw $t0, __t81
li $t0, 1
sw $t0, __t82
lw $t1, __t81
lw $t2, __t82
add $t0, $t1, $t2
sw $t0, __t83
lw $t0, __t83
sw $t0, countC
lw $t0, negCombinada
sw $t0, __t84
lw $t0, __t84
beq $t0, $zero, L6
l.s $f0, sumaFloat
s.s $f0, __f10
li.s $f0, 0.5
s.s $f0, __f11
l.s $f1, __f10
l.s $f2, __f11
add.s $f0, $f1, $f2
s.s $f0, __f12
l.s $f0, __f12
s.s $f0, sumaFloat
L6:
_sw1_end:
lw $t0, k
sw $t0, __t85
li $t0, 1
sw $t0, __t86
lw $t1, __t85
lw $t2, __t86
add $t0, $t1, $t2
sw $t0, __t87
lw $t0, __t87
sw $t0, k
lw $t0, k
sw $t0, __t88
li $t0, 3
sw $t0, __t89
lw $t1, __t88
lw $t2, __t89
sle $t0, $t1, $t2
sw $t0, __t90
lw $t0, __t90
bne $t0, $zero, _dowhile3_start
_dowhile3_end:
lw $t0, var_j
sw $t0, __t91
li $t0, 1
sw $t0, __t92
lw $t1, __t91
lw $t2, __t92
add $t0, $t1, $t2
sw $t0, __t93
lw $t0, __t93
sw $t0, var_j
lw $t0, var_j
sw $t0, __t94
li $t0, 3
sw $t0, __t95
lw $t1, __t94
lw $t2, __t95
sle $t0, $t1, $t2
sw $t0, __t96
lw $t0, __t96
bne $t0, $zero, _dowhile2_start
_dowhile2_end:
l.s $f0, yf
s.s $f0, __f13
li.s $f0, 1.5
s.s $f0, __f14
l.s $f1, __f13
l.s $f2, __f14
add.s $f0, $f1, $f2
s.s $f0, __f15
l.s $f0, __f15
s.s $f0, yf
lw $t0, i
sw $t0, __t97
li $t0, 1
sw $t0, __t98
lw $t1, __t97
lw $t2, __t98
add $t0, $t1, $t2
sw $t0, __t99
lw $t0, __t99
sw $t0, i
lw $t0, i
sw $t0, __t100
li $t0, 3
sw $t0, __t101
lw $t1, __t100
lw $t2, __t101
sle $t0, $t1, $t2
sw $t0, __t102
lw $t0, __t102
bne $t0, $zero, _dowhile1_start
_dowhile1_end:
li $t0, 3
sw $t0, __t103
lw $t0, maxSuma
sw $t0, __t104
lw $t1, __t103
lw $t2, __t104
li $t0, 1
_pow0_start:
blez $t2, _pow1_end
mul $t0, $t0, $t1
addi $t2, $t2, -1
j _pow0_start
_pow1_end:
sw $t0, __t105
lw $t0, __t105
sw $t0, potenciaFinal
la $t0, str0
sw $t0, __t106
lw $a0, __t106
li $v0, 4
syscall
lw $a0, countA
li $v0, 1
syscall
la $t0, str1
sw $t0, __t107
lw $a0, __t107
li $v0, 4
syscall
la $t0, str2
sw $t0, __t108
lw $a0, __t108
li $v0, 4
syscall
lw $a0, countB
li $v0, 1
syscall
la $t0, str1
sw $t0, __t109
lw $a0, __t109
li $v0, 4
syscall
la $t0, str3
sw $t0, __t110
lw $a0, __t110
li $v0, 4
syscall
lw $a0, countC
li $v0, 1
syscall
la $t0, str1
sw $t0, __t111
lw $a0, __t111
li $v0, 4
syscall
la $t0, str4
sw $t0, __t112
lw $a0, __t112
li $v0, 4
syscall
lw $a0, maxSuma
li $v0, 1
syscall
la $t0, str1
sw $t0, __t113
lw $a0, __t113
li $v0, 4
syscall
la $t0, str5
sw $t0, __t114
lw $a0, __t114
li $v0, 4
syscall
l.s $f12, sumaFloat
li $v0, 2
syscall
la $t0, str1
sw $t0, __t115
lw $a0, __t115
li $v0, 4
syscall
la $t0, str6
sw $t0, __t116
lw $a0, __t116
li $v0, 4
syscall
lw $a0, potenciaFinal
li $v0, 1
syscall
la $t0, str1
sw $t0, __t117
lw $a0, __t117
li $v0, 4
syscall
la $t0, str1
sw $t0, __t118
lw $a0, __t118
li $v0, 4
syscall
la $t0, str7
sw $t0, __t119
lw $a0, __t119
li $v0, 4
syscall
li $t0, 0
sw $t0, __t120
li $t0, 0
sw $t0, __t121
lw $t8, __t120
li $t9, 3
mul $t8, $t8, $t9
lw $t9, __t121
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, 0($t9)
sw $t0, __t122
lw $a0, __t122
li $v0, 1
syscall
la $t0, str8
sw $t0, __t123
lw $a0, __t123
li $v0, 4
syscall
li $t0, 0
sw $t0, __t124
li $t0, 1
sw $t0, __t125
lw $t8, __t124
li $t9, 3
mul $t8, $t8, $t9
lw $t9, __t125
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, 0($t9)
sw $t0, __t126
lw $a0, __t126
li $v0, 1
syscall
la $t0, str8
sw $t0, __t127
lw $a0, __t127
li $v0, 4
syscall
li $t0, 0
sw $t0, __t128
li $t0, 2
sw $t0, __t129
lw $t8, __t128
li $t9, 3
mul $t8, $t8, $t9
lw $t9, __t129
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, 0($t9)
sw $t0, __t130
lw $a0, __t130
li $v0, 1
syscall
la $t0, str1
sw $t0, __t131
lw $a0, __t131
li $v0, 4
syscall
la $t0, str9
sw $t0, __t132
lw $a0, __t132
li $v0, 4
syscall
li $t0, 1
sw $t0, __t133
li $t0, 0
sw $t0, __t134
lw $t8, __t133
li $t9, 3
mul $t8, $t8, $t9
lw $t9, __t134
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, 0($t9)
sw $t0, __t135
lw $a0, __t135
li $v0, 1
syscall
la $t0, str8
sw $t0, __t136
lw $a0, __t136
li $v0, 4
syscall
li $t0, 1
sw $t0, __t137
li $t0, 1
sw $t0, __t138
lw $t8, __t137
li $t9, 3
mul $t8, $t8, $t9
lw $t9, __t138
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, 0($t9)
sw $t0, __t139
lw $a0, __t139
li $v0, 1
syscall
la $t0, str8
sw $t0, __t140
lw $a0, __t140
li $v0, 4
syscall
li $t0, 1
sw $t0, __t141
li $t0, 2
sw $t0, __t142
lw $t8, __t141
li $t9, 3
mul $t8, $t8, $t9
lw $t9, __t142
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, 0($t9)
sw $t0, __t143
lw $a0, __t143
li $v0, 1
syscall
la $t0, str1
sw $t0, __t144
lw $a0, __t144
li $v0, 4
syscall
la $t0, str10
sw $t0, __t145
lw $a0, __t145
li $v0, 4
syscall
li $t0, 2
sw $t0, __t146
li $t0, 0
sw $t0, __t147
lw $t8, __t146
li $t9, 3
mul $t8, $t8, $t9
lw $t9, __t147
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, 0($t9)
sw $t0, __t148
lw $a0, __t148
li $v0, 1
syscall
la $t0, str8
sw $t0, __t149
lw $a0, __t149
li $v0, 4
syscall
li $t0, 2
sw $t0, __t150
li $t0, 1
sw $t0, __t151
lw $t8, __t150
li $t9, 3
mul $t8, $t8, $t9
lw $t9, __t151
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, 0($t9)
sw $t0, __t152
lw $a0, __t152
li $v0, 1
syscall
la $t0, str8
sw $t0, __t153
lw $a0, __t153
li $v0, 4
syscall
li $t0, 2
sw $t0, __t154
li $t0, 2
sw $t0, __t155
lw $t8, __t154
li $t9, 3
mul $t8, $t8, $t9
lw $t9, __t155
add $t8, $t8, $t9
sll $t8, $t8, 2
la $t9, matriz
add $t9, $t9, $t8
lw $t0, 0($t9)
sw $t0, __t156
lw $a0, __t156
li $v0, 1
syscall
la $t0, str1
sw $t0, __t157
lw $a0, __t157
li $v0, 4
syscall
li $v0, 10
syscall
