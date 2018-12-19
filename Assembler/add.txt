;this program calcuates summation from 1 to n-1
mov #0,R0
label1:
add R0,output
inc R0
cmp R0,n
beq label2
BR label1
label2:
HLT
define N 7
define output 0