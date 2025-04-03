.data
  N: .word 10
  v1: .float 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
  v2: .float 1, 2, 3, 1, 2, 3, 1, 2, 3, 1
  
.text
.globl main

main:
  la $t0, N
  lw $t0, 0($t0)
  la $a1, v1
  la $a2, v2
  
Loop:
  lwc1 $f2, 0($a1)     # load v1[i]
  lwc1 $f4, 0($a2)     # load v2[i]
  lwc1 $f1, 4($a1)     # load v1[i + 4]
  lwc1 $f3, 4($a2)     # load v2[i + 4]
  mul.s $f2, $f2, $f4  # v1[i] x v2[i]
  mul.s $f1, $f1, $f3  # v1[i + 4] x v2[i + 4]
 addi $t0, $t0, -2
addi $a1, $a1, 8
  addi $a2, $a2, 4
  swc1 $f2, 0($a2)     # v2[i] = v1[i] x v2[i]
  swc1 $f1, 0($a2)     # v2[i + 4] = v1[i + 4] x v2[i + 4]
 
  bne $t0, $0, Loop
  
end:

  addi $v0, $0, 10
  syscall
