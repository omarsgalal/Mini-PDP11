JSR label1

HLT
label1:
mov #0,R0
label2:
sub m,n
inc R0
cmp m,n
bhi label2
mov n,m
mov r0,n
JSR label3
RTS

label3:
mov #0,R0
label4:
add R0,output
inc R0
cmp R0,z
beq label5
BR label4
label5:
RTS

define z 7
define output 0
define N 129
define M 8