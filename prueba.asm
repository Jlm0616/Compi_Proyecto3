.data
a: .word 0
__t0: .word 0
var_b: .word 0
__t1: .word 0
c: .word 0
__t2: .word 0
d: .word 0
__t3: .word 0
e: .word 0
__t4: .word 0
__t5: .word 0
__t6: .word 0
__t7: .word 0
paso1: .word 0
__t8: .word 0
__t9: .word 0
__t10: .word 0
paso2: .word 0
__t11: .word 0
__t12: .word 0
__t13: .word 0
paso3: .word 0
__t14: .word 0
__t15: .word 0
__t16: .word 0
paso4: .word 0
__t17: .word 0
__t18: .word 0
__t19: .word 0
paso5: .word 0
__t20: .word 0
__t21: .word 0
__t22: .word 0
__t23: .word 0
__t24: .word 0
paso6: .word 0
__t25: .word 0
__t26: .word 0
__t27: .word 0
__t28: .word 0
__t29: .word 0
__t30: .word 0
__t31: .word 0
r1: .word 0
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
t1: .word 0
__t73: .word 0
__t74: .word 0
__t75: .word 0
__t76: .word 0
__t77: .word 0
t2: .word 0
__t78: .word 0
__t79: .word 0
__t80: .word 0
__t81: .word 0
__t82: .word 0
t3: .word 0
__t83: .word 0
__t84: .word 0
__t85: .word 0
t4: .word 0
__t86: .word 0
__t87: .word 0
__t88: .word 0
__t89: .word 0
__t90: .word 0
t5: .word 0
__t91: .word 0
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
__t112: .word 0
__t113: .word 0
__t114: .word 0
__t115: .word 0
__t116: .word 0
conParentesis: .word 0
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
str0: .asciiz "=== DIAGNOSTICO DE EXPRESION ==="
str1: .asciiz "\n"
str2: .asciiz "a = "
str3: .asciiz "var_b = "
str4: .asciiz "c = "
str5: .asciiz "d = "
str6: .asciiz "e = "
str7: .asciiz "paso1: a + var_b = "
str8: .asciiz "paso2: var_b * c = "
str9: .asciiz "paso3: d / e = "
str10: .asciiz "paso4: 2 ^ 3 = "
str11: .asciiz "paso5: d / e % 2 = "
str12: .asciiz "paso6: d / e % 2 ^ 3 = "
str13: .asciiz "r1 = "
str14: .asciiz "\n=== DIAGNOSTICO DE PRECEDENCIA ==="
str15: .asciiz "a + var_b * c = "
str16: .asciiz "d / e % 2 = "
str17: .asciiz "2 ^ 3 = "
str18: .asciiz "t1 - t2 % t3 = "
str19: .asciiz "(a + var_b * c) - (d / e % 2 ^ 3) = "
str20: .asciiz "\n=== CON PARENTESIS EXPLICITOS ==="
str21: .asciiz "a + (var_b*c) - ((d/e) % (2^3)) = "

.text
.globl main
main:
li $t0, 2
sw $t0, __t0
lw $t0, __t0
sw $t0, a
li $t0, 3
sw $t0, __t1
lw $t0, __t1
sw $t0, var_b
li $t0, 5
sw $t0, __t2
lw $t0, __t2
sw $t0, c
li $t0, 7
sw $t0, __t3
lw $t0, __t3
sw $t0, d
li $t0, 11
sw $t0, __t4
lw $t0, __t4
sw $t0, e
la $t0, str0
sw $t0, __t5
lw $a0, __t5
li $v0, 4
syscall
la $t0, str1
sw $t0, __t6
lw $a0, __t6
li $v0, 4
syscall
la $t0, str1
sw $t0, __t7
lw $a0, __t7
li $v0, 4
syscall
lw $t0, a
sw $t0, __t8
lw $t0, var_b
sw $t0, __t9
lw $t1, __t8
lw $t2, __t9
add $t0, $t1, $t2
sw $t0, __t10
lw $t0, __t10
sw $t0, paso1
lw $t0, var_b
sw $t0, __t11
lw $t0, c
sw $t0, __t12
lw $t1, __t11
lw $t2, __t12
mul $t0, $t1, $t2
sw $t0, __t13
lw $t0, __t13
sw $t0, paso2
lw $t0, d
sw $t0, __t14
lw $t0, e
sw $t0, __t15
lw $t1, __t14
lw $t2, __t15
div $t1, $t2
mflo $t0
sw $t0, __t16
lw $t0, __t16
sw $t0, paso3
li $t0, 2
sw $t0, __t17
li $t0, 3
sw $t0, __t18
lw $t1, __t17
lw $t2, __t18
li $t0, 1
_pow0_start:
blez $t2, _pow1_end
mul $t0, $t0, $t1
addi $t2, $t2, -1
j _pow0_start
_pow1_end:
sw $t0, __t19
lw $t0, __t19
sw $t0, paso4
lw $t0, d
sw $t0, __t20
lw $t0, e
sw $t0, __t21
li $t0, 2
sw $t0, __t22
lw $t1, __t21
lw $t2, __t22
div $t1, $t2
mfhi $t0
sw $t0, __t23
lw $t1, __t20
lw $t2, __t23
div $t1, $t2
mflo $t0
sw $t0, __t24
lw $t0, __t24
sw $t0, paso5
lw $t0, d
sw $t0, __t25
lw $t0, e
sw $t0, __t26
li $t0, 2
sw $t0, __t27
li $t0, 3
sw $t0, __t28
lw $t1, __t27
lw $t2, __t28
li $t0, 1
_pow2_start:
blez $t2, _pow3_end
mul $t0, $t0, $t1
addi $t2, $t2, -1
j _pow2_start
_pow3_end:
sw $t0, __t29
lw $t1, __t26
lw $t2, __t29
div $t1, $t2
mfhi $t0
sw $t0, __t30
lw $t1, __t25
lw $t2, __t30
div $t1, $t2
mflo $t0
sw $t0, __t31
lw $t0, __t31
sw $t0, paso6
lw $t0, a
sw $t0, __t32
lw $t0, var_b
sw $t0, __t33
lw $t0, c
sw $t0, __t34
lw $t1, __t33
lw $t2, __t34
mul $t0, $t1, $t2
sw $t0, __t35
lw $t0, d
sw $t0, __t36
lw $t0, e
sw $t0, __t37
li $t0, 2
sw $t0, __t38
li $t0, 3
sw $t0, __t39
lw $t1, __t38
lw $t2, __t39
li $t0, 1
_pow4_start:
blez $t2, _pow5_end
mul $t0, $t0, $t1
addi $t2, $t2, -1
j _pow4_start
_pow5_end:
sw $t0, __t40
lw $t1, __t37
lw $t2, __t40
div $t1, $t2
mfhi $t0
sw $t0, __t41
lw $t1, __t36
lw $t2, __t41
div $t1, $t2
mflo $t0
sw $t0, __t42
lw $t1, __t35
lw $t2, __t42
sub $t0, $t1, $t2
sw $t0, __t43
lw $t1, __t32
lw $t2, __t43
add $t0, $t1, $t2
sw $t0, __t44
lw $t0, __t44
sw $t0, r1
la $t0, str2
sw $t0, __t45
lw $a0, __t45
li $v0, 4
syscall
lw $a0, a
li $v0, 1
syscall
la $t0, str1
sw $t0, __t46
lw $a0, __t46
li $v0, 4
syscall
la $t0, str3
sw $t0, __t47
lw $a0, __t47
li $v0, 4
syscall
lw $a0, var_b
li $v0, 1
syscall
la $t0, str1
sw $t0, __t48
lw $a0, __t48
li $v0, 4
syscall
la $t0, str4
sw $t0, __t49
lw $a0, __t49
li $v0, 4
syscall
lw $a0, c
li $v0, 1
syscall
la $t0, str1
sw $t0, __t50
lw $a0, __t50
li $v0, 4
syscall
la $t0, str5
sw $t0, __t51
lw $a0, __t51
li $v0, 4
syscall
lw $a0, d
li $v0, 1
syscall
la $t0, str1
sw $t0, __t52
lw $a0, __t52
li $v0, 4
syscall
la $t0, str6
sw $t0, __t53
lw $a0, __t53
li $v0, 4
syscall
lw $a0, e
li $v0, 1
syscall
la $t0, str1
sw $t0, __t54
lw $a0, __t54
li $v0, 4
syscall
la $t0, str1
sw $t0, __t55
lw $a0, __t55
li $v0, 4
syscall
la $t0, str7
sw $t0, __t56
lw $a0, __t56
li $v0, 4
syscall
lw $a0, paso1
li $v0, 1
syscall
la $t0, str1
sw $t0, __t57
lw $a0, __t57
li $v0, 4
syscall
la $t0, str8
sw $t0, __t58
lw $a0, __t58
li $v0, 4
syscall
lw $a0, paso2
li $v0, 1
syscall
la $t0, str1
sw $t0, __t59
lw $a0, __t59
li $v0, 4
syscall
la $t0, str9
sw $t0, __t60
lw $a0, __t60
li $v0, 4
syscall
lw $a0, paso3
li $v0, 1
syscall
la $t0, str1
sw $t0, __t61
lw $a0, __t61
li $v0, 4
syscall
la $t0, str10
sw $t0, __t62
lw $a0, __t62
li $v0, 4
syscall
lw $a0, paso4
li $v0, 1
syscall
la $t0, str1
sw $t0, __t63
lw $a0, __t63
li $v0, 4
syscall
la $t0, str11
sw $t0, __t64
lw $a0, __t64
li $v0, 4
syscall
lw $a0, paso5
li $v0, 1
syscall
la $t0, str1
sw $t0, __t65
lw $a0, __t65
li $v0, 4
syscall
la $t0, str12
sw $t0, __t66
lw $a0, __t66
li $v0, 4
syscall
lw $a0, paso6
li $v0, 1
syscall
la $t0, str1
sw $t0, __t67
lw $a0, __t67
li $v0, 4
syscall
la $t0, str13
sw $t0, __t68
lw $a0, __t68
li $v0, 4
syscall
lw $a0, r1
li $v0, 1
syscall
la $t0, str1
sw $t0, __t69
lw $a0, __t69
li $v0, 4
syscall
la $t0, str14
sw $t0, __t70
lw $a0, __t70
li $v0, 4
syscall
la $t0, str1
sw $t0, __t71
lw $a0, __t71
li $v0, 4
syscall
la $t0, str1
sw $t0, __t72
lw $a0, __t72
li $v0, 4
syscall
lw $t0, a
sw $t0, __t73
lw $t0, var_b
sw $t0, __t74
lw $t0, c
sw $t0, __t75
lw $t1, __t74
lw $t2, __t75
mul $t0, $t1, $t2
sw $t0, __t76
lw $t1, __t73
lw $t2, __t76
add $t0, $t1, $t2
sw $t0, __t77
lw $t0, __t77
sw $t0, t1
lw $t0, d
sw $t0, __t78
lw $t0, e
sw $t0, __t79
li $t0, 2
sw $t0, __t80
lw $t1, __t79
lw $t2, __t80
div $t1, $t2
mfhi $t0
sw $t0, __t81
lw $t1, __t78
lw $t2, __t81
div $t1, $t2
mflo $t0
sw $t0, __t82
lw $t0, __t82
sw $t0, t2
li $t0, 2
sw $t0, __t83
li $t0, 3
sw $t0, __t84
lw $t1, __t83
lw $t2, __t84
li $t0, 1
_pow6_start:
blez $t2, _pow7_end
mul $t0, $t0, $t1
addi $t2, $t2, -1
j _pow6_start
_pow7_end:
sw $t0, __t85
lw $t0, __t85
sw $t0, t3
lw $t0, t1
sw $t0, __t86
lw $t0, t2
sw $t0, __t87
lw $t0, t3
sw $t0, __t88
lw $t1, __t87
lw $t2, __t88
div $t1, $t2
mfhi $t0
sw $t0, __t89
lw $t1, __t86
lw $t2, __t89
sub $t0, $t1, $t2
sw $t0, __t90
lw $t0, __t90
sw $t0, t4
lw $t0, a
sw $t0, __t91
lw $t0, var_b
sw $t0, __t92
lw $t0, c
sw $t0, __t93
lw $t1, __t92
lw $t2, __t93
mul $t0, $t1, $t2
sw $t0, __t94
lw $t1, __t91
lw $t2, __t94
add $t0, $t1, $t2
sw $t0, __t95
lw $t0, d
sw $t0, __t96
lw $t0, e
sw $t0, __t97
li $t0, 2
sw $t0, __t98
li $t0, 3
sw $t0, __t99
lw $t1, __t98
lw $t2, __t99
li $t0, 1
_pow8_start:
blez $t2, _pow9_end
mul $t0, $t0, $t1
addi $t2, $t2, -1
j _pow8_start
_pow9_end:
sw $t0, __t100
lw $t1, __t97
lw $t2, __t100
div $t1, $t2
mfhi $t0
sw $t0, __t101
lw $t1, __t96
lw $t2, __t101
div $t1, $t2
mflo $t0
sw $t0, __t102
lw $t1, __t95
lw $t2, __t102
sub $t0, $t1, $t2
sw $t0, __t103
lw $t0, __t103
sw $t0, t5
la $t0, str15
sw $t0, __t104
lw $a0, __t104
li $v0, 4
syscall
lw $a0, t1
li $v0, 1
syscall
la $t0, str1
sw $t0, __t105
lw $a0, __t105
li $v0, 4
syscall
la $t0, str16
sw $t0, __t106
lw $a0, __t106
li $v0, 4
syscall
lw $a0, t2
li $v0, 1
syscall
la $t0, str1
sw $t0, __t107
lw $a0, __t107
li $v0, 4
syscall
la $t0, str17
sw $t0, __t108
lw $a0, __t108
li $v0, 4
syscall
lw $a0, t3
li $v0, 1
syscall
la $t0, str1
sw $t0, __t109
lw $a0, __t109
li $v0, 4
syscall
la $t0, str18
sw $t0, __t110
lw $a0, __t110
li $v0, 4
syscall
lw $a0, t4
li $v0, 1
syscall
la $t0, str1
sw $t0, __t111
lw $a0, __t111
li $v0, 4
syscall
la $t0, str19
sw $t0, __t112
lw $a0, __t112
li $v0, 4
syscall
lw $a0, t5
li $v0, 1
syscall
la $t0, str1
sw $t0, __t113
lw $a0, __t113
li $v0, 4
syscall
la $t0, str20
sw $t0, __t114
lw $a0, __t114
li $v0, 4
syscall
la $t0, str1
sw $t0, __t115
lw $a0, __t115
li $v0, 4
syscall
la $t0, str1
sw $t0, __t116
lw $a0, __t116
li $v0, 4
syscall
lw $t0, a
sw $t0, __t117
lw $t0, var_b
sw $t0, __t118
lw $t0, c
sw $t0, __t119
lw $t1, __t118
lw $t2, __t119
mul $t0, $t1, $t2
sw $t0, __t120
lw $t0, d
sw $t0, __t121
lw $t0, e
sw $t0, __t122
lw $t1, __t121
lw $t2, __t122
div $t1, $t2
mflo $t0
sw $t0, __t123
li $t0, 2
sw $t0, __t124
li $t0, 3
sw $t0, __t125
lw $t1, __t124
lw $t2, __t125
li $t0, 1
_pow10_start:
blez $t2, _pow11_end
mul $t0, $t0, $t1
addi $t2, $t2, -1
j _pow10_start
_pow11_end:
sw $t0, __t126
lw $t1, __t123
lw $t2, __t126
div $t1, $t2
mfhi $t0
sw $t0, __t127
lw $t1, __t120
lw $t2, __t127
sub $t0, $t1, $t2
sw $t0, __t128
lw $t1, __t117
lw $t2, __t128
add $t0, $t1, $t2
sw $t0, __t129
lw $t0, __t129
sw $t0, conParentesis
la $t0, str21
sw $t0, __t130
lw $a0, __t130
li $v0, 4
syscall
lw $a0, conParentesis
li $v0, 1
syscall
la $t0, str1
sw $t0, __t131
lw $a0, __t131
li $v0, 4
syscall
li $v0, 10
syscall
