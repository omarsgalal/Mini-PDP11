noFinishError:
mov #-2,R1
BLO l1
br next
l1: 
mov R1, abdoq
BHI next
mov R1, abdow

next:

mov #2,R1
BHS l11
br next2
l11: 
mov R1, abdoe
BLS next2
mov R1, abdor

next2:

mov N, R1
mov M, R2
mov A, R5
add R1, R2
mov R2, (R5)+
adc R1, R2
mov R2, (R5)+
BR label2
label3:
SUB R1, R2
mov R2, (R5)+
SBC R1, R2
mov R2, (R5)+
AND R1, R2
mov R2, (R5)+
OR R1, R2
mov R2, (R5)+
XNOR R1, R2
mov R2, (R5)+
CMP R1, R2
mov R2, (R5)+
INC R2
mov R2, (R5)+
DEC R2
mov R2, (R5)+
BNE label4
label2:
CLR R2
mov R2, (R5)+
BEQ label3
label4:
INV R2
mov R2, (R5)+
LSR R2
mov R2, (R5)+
ROR R2
mov R2, (R5)+
RRC R2
mov R2, (R5)+
ASR R2
mov R2, (R5)+
LSL R2
mov R2, (R5)+
ROL R2
mov R2, (R5)+
NOP
RLC R2
mov R2, (R5)+

mov r2,r3
cmp r2,r3
BEQ finish
br noFinishError
finish:
HLT

define A,0
define N 5
define M 10
define Z 15
define abdoq 0
define abdow 0
define abdoe 0
define abdor 0