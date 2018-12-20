mov #16,R0
label1:
ROR n
dec R0
bne label1
mov #16,R0
label2:
ROL n
dec R0
bne label2
HLT
define n 5
