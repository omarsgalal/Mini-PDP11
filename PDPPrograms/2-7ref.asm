mov N,R5
mov #500,R1
mov #1000,R2
mov #1500,R3
Routine:
mov (R1)+,R4
ADD -(R2),R4
MOV R4,(R3)+
INC R5
cmp R5,#0
BNE Routine
HLT
define N -25
