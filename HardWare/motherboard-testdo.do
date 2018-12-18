quit -sim

vsim -gui work.motherboardtest
mem load -i F:/Mini-PDP11/Assembler/program.mem /motherboardtest/fram/ram
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

add wave -position insertpoint sim:/motherboardtest/fcpu/sprf/RegIR/Q

add wave -position insertpoint sim:/motherboardtest/fcpu/sprf/RegMDR/Q
add wave -position insertpoint sim:/motherboardtest/fcpu/falu/tempF

add wave -r sim:/motherboardtest/*

run -all
