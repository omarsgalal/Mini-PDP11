quit -sim

vsim -gui work.motherboardtest
mem load -i {D:/CMP/3rd year/Arch Project/Mini-PDP11/Assembler/program.mem} /motherboardtest/fram/ram
add wave -position insertpoint sim:/motherboardtest/*
add wave -position insertpoint sim:/motherboardtest/fcpu/*

add wave -position insertpoint sim:/motherboardtest/fcpu/gprf/loopGenerateRegs(0)/Reg/Q
add wave -position insertpoint sim:/motherboardtest/fcpu/gprf/loopGenerateRegs(1)/Reg/Q
add wave -position insertpoint sim:/motherboardtest/fcpu/gprf/loopGenerateRegs(2)/Reg/Q
add wave -position insertpoint sim:/motherboardtest/fcpu/gprf/loopGenerateRegs(3)/Reg/Q
add wave -position insertpoint sim:/motherboardtest/fcpu/gprf/loopGenerateRegs(4)/Reg/Q
add wave -position insertpoint sim:/motherboardtest/fcpu/gprf/loopGenerateRegs(5)/Reg/Q
add wave -position insertpoint sim:/motherboardtest/fcpu/gprf/loopGenerateRegs(6)/Reg/Q
add wave -position insertpoint sim:/motherboardtest/fcpu/gprf/loopGenerateRegs(7)/Reg/Q


add wave -position insertpoint  \
sim:/motherboardtest/fcpu/gprfcontrol/finalSrcA
add wave -position insertpoint  \
sim:/motherboardtest/fcpu/gprfcontrol/finalDst
add wave -position insertpoint  \
sim:/motherboardtest/fcpu/gprfcontrol/finalSrcC


add wave -position insertpoint  \
sim:/motherboardtest/fcpu/gprf/decoderA
add wave -position insertpoint  \
sim:/motherboardtest/fcpu/gprf/decoderB
add wave -position insertpoint  \
sim:/motherboardtest/fcpu/gprf/decoderC

add wave -position insertpoint  \
sim:/motherboardtest/fcpu/gprf/enableDecoderA
add wave -position insertpoint  \
sim:/motherboardtest/fcpu/gprf/enableDecoderB
add wave -position insertpoint  \
sim:/motherboardtest/fcpu/gprf/enableDecoderC

add wave -position insertpoint  \
sim:/motherboardtest/fcpu/gprf/outDecoderA
add wave -position insertpoint  \
sim:/motherboardtest/fcpu/gprf/outDecoderB
add wave -position insertpoint  \
sim:/motherboardtest/fcpu/gprf/outDecoderC


add wave -position insertpoint  \
sim:/motherboardtest/fcpu/faluControl/aluOperation

add wave -position insertpoint  \
sim:/motherboardtest/fcpu/faluControl/IROperation

add wave -position insertpoint  \
sim:/motherboardtest/fcpu/sprf/RegMDR/Q

add wave -position insertpoint  \
sim:/motherboardtest/fcpu/sprf/RegMAR/Q

add wave -position insertpoint  \
sim:/motherboardtest/fcpu/sprf/controlIR

add wave -position insertpoint sim:/motherboardtest/fcpu/sprf/RegIR/Q

add wave -position insertpoint  \
sim:/motherboardtest/fcpu/falu/A
add wave -position insertpoint  \
sim:/motherboardtest/fcpu/falu/B
add wave -position insertpoint  \
sim:/motherboardtest/fcpu/falu/F


add wave -position insertpoint  \
sim:/motherboardtest/fcpu/sprf/controlIR
add wave -position insertpoint  \
sim:/motherboardtest/fcpu/sprf/controlMAR
add wave -position insertpoint  \
sim:/motherboardtest/fcpu/sprf/controlMDRIn
add wave -position insertpoint  \
sim:/motherboardtest/fcpu/sprf/controlMDROut

add wave -position insertpoint  \
sim:/motherboardtest/fcpu/sprf/enableMDRRead

add wave -position insertpoint  \
sim:/motherboardtest/fcpu/sprf/MDRInput

run -all
