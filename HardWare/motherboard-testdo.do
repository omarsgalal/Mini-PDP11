quit -sim

vsim -gui work.motherboardtest
mem load -i {F:/Mini-PDP11/Assembler/program.mem} /motherboardtest/fram/ram
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

add wave -position insertpoint sim:/motherboardtest/fcpu/sprf/RegMDR/Q
add wave -position insertpoint sim:/motherboardtest/fcpu/falu/tempF

add wave -r sim:/motherboardtest/*

run -all
