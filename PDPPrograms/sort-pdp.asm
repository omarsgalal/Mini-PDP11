MOV #150, R0
; initialization
MOV #1, (R0)+
MOV #5, (R0)+
MOV #2, (R0)+
MOV #7, (R0)+
MOV #23, (R0)+
MOV #3, (R0)+
MOV #12, (R0)+
MOV #4, (R0)+
MOV #6, (R0)+

MOV #150, R2

outerloop:
    MOV R2, R4 ;loop with R4
    MOV R2, R3 ;save the min value in R3
    innerloop:
        CMP @R3, @R4
        BHS skipMin
        MOV R4, R3
        skipMin:
        inc R4
        CMP R4, R0
        BEQ finishIneerLoop
        BR innerloop
    
    finishIneerLoop:
    JSR swap

    inc R2
    CMP R2, R0
    BEQ fin
    BR outerloop

fin:
HLT


swap:
    MOV @R2, R5
    MOV @R3, @R2
    MOV R5, @R3
    RTS