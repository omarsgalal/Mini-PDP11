;multiplier
mov n, R0
mov m, R2

clr R3
loop1:
add R2, R3
dec R0
BNE loop1

mov R3, x

hlt

define n 2
define m 6
define x 6