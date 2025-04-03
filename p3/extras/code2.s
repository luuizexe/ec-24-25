# Salto retardado
# Unidad de suma en punto flotante segmentada con latencia 2
# Unidad de multiplicación en punto flotante segmentada con latencia 4
# Unidad de división en punto flotante no segmentada con latencia 7



.data
n: .word 10
a: .word 1, 2, 3, 4, 5, 4, 3, 2, 1, 10
b: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
c: .space 4

.text
.globl main

main:
  la $t0, n
  lw $t0, 0($t0)
  la $t1, a
  la $t2, b
  la $t3, c
  addi $t4, $0, 0

loop:
  lw $t5, 0($t1)
  lw $t6, 0($t2)
  lw $a1, 4($t1)
  lw $a2, 4($t2)
  slt $t7, $t5, $t6
  slt $a3, $a1, $a2
  addi $t0, $t0, -2 
  beq $t7, $0, sig
  nop
  addi $t4, $t4, 1
  
sig:
  beq $a3, $0, skip
  nop
  addi $t4, $t4, 1

skip:
  addi $t1, $t1, 8
  addi $t2, $t2, 8
  bne $t0, $0, loop
  nop

end:
  addi $t4,$v0,0
  addi $v0, $0, 3
  syscall
  sw $t4, 0($t3)
  addi $v0, $0, 10
  syscall
