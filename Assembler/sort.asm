MOV N, R0
; initialization
MOV 1, (R0)+
MOV 5, (R0)+
MOV 2, (R0)+
MOV 7, (R0)+
MOV 8, (R0)+
MOV 3, (R0)+
MOV 9, (R0)+
MOV 4, (R0)+
MOV 6, (R0)+
; size of array
MOV 9, R1
ADD N, R1

outerloop:
MOV N, R2
INC N
MOV N, R3
MOV R2, R4

innerloop:
CMP @R3, @R4
BHS skipMin
MOV R3, R4
skipMin:
INC R3
CMP R1, R3
BEQ finishIneerLoop
BR innerloop
finishIneerLoop:
JSR funSwap
CMP R1, R2
BEQ finishOuterLoop
BR outerloop

finishOuterLoop:
HLT




funSwap:
MOV @R2, R5
MOV @R4, @R2
MOV R5, @R4
RTS

define N 200
