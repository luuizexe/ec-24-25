.data
  N: .word 10
  v1: .float 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
  v2: .float 1, 2, 3, 1, 2, 3, 1, 2, 3, 1
  r: .float 0
  
.text
.globl main

main:
  la $t0, N
  lw $t0, 0($t0)
  la $t1, v1
  la $t2, v2
  la $t3, r
  lwc1 $f12, 0($t3)      # f12 = 0.0
  
Loop:
  lwc1 $f2, 0($t1)       # f2 = v1[i]
  lwc1 $f3, 0($t2)       # f3 = v2[i]
  lwc1 $f5, 4($t1)       # f5 = v1[i+1]
  lwc1 $f6, 4($t2)       # f6 = v2[i+1]
  add.s $f12, $f12, $f2  # f12 = f12 + f2
addi $t0, $t0, -2
  add.s $f12, $f12, $f5  # f12 = f12 + f2
  
  mul.s $f4, $f3, $f3    # f4 = f3 * f3
  mul.s $f7, $f6, $f6    # f4 = f3 * f3
  addi $t1, $t1, 8
  addi $t2, $t2, 8
  bne $t0, $0, Loop
  swc1 $f4, -4($t1)       # v1[i] = f4
  swc1 $f7, -8($t1)       # v1[i+1] = f7
  
end:
  swc1 $f12, 0($t3)
  addi $v0, $0, 2
  syscall

  addi $v0, $0, 10
  syscall
