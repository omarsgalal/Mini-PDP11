;this program divides N/M and stores result in N and reminder in M
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
RTS


define N 129
define M 8