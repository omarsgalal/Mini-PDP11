quit -sim
python ../Assembler/assembler.py "D:\\CMP\\3rd year\\Arch Project\\Mini-PDP11\\Assembler\\program2.asm" "D:\\CMP\\3rd year\\Arch Project\\Mini-PDP11\\Assembler\\program2.mem"
vsim -gui work.motherboard

mem load -i {D:/CMP/3rd year/Arch Project/Mini-PDP11/Assembler/program2.mem} /motherboard/fram/ram

add wave -position insertpoint sim:/motherboard/*

add wave -position insertpoint  \
sim:/motherboard/fcpu/clkAll

add wave -position insertpoint  \
sim:/motherboard/fcpu/gprf/busA
add wave -position insertpoint  \
sim:/motherboard/fcpu/gprf/busB
add wave -position insertpoint  \
sim:/motherboard/fcpu/gprf/busC

add wave -position insertpoint  \
sim:/motherboard/fcpu/gprf/loopGenerateRegs(0)/Reg/Q
add wave -position insertpoint  \
sim:/motherboard/fcpu/gprf/loopGenerateRegs(1)/Reg/Q
add wave -position insertpoint  \
sim:/motherboard/fcpu/gprf/loopGenerateRegs(2)/Reg/Q
add wave -position insertpoint  \
sim:/motherboard/fcpu/gprf/loopGenerateRegs(3)/Reg/Q
add wave -position insertpoint  \
sim:/motherboard/fcpu/gprf/loopGenerateRegs(4)/Reg/Q
add wave -position insertpoint  \
sim:/motherboard/fcpu/gprf/loopGenerateRegs(5)/Reg/Q
add wave -position insertpoint  \
sim:/motherboard/fcpu/gprf/loopGenerateRegs(6)/Reg/Q
add wave -position insertpoint  \
sim:/motherboard/fcpu/gprf/loopGenerateRegs(7)/Reg/Q


add wave -position insertpoint  \
sim:/motherboard/fcpu/sprf/IRReg
add wave -position insertpoint  \
sim:/motherboard/fcpu/sprf/MARReg
add wave -position insertpoint  \
sim:/motherboard/fcpu/sprf/MDRCPUReg
add wave -position insertpoint  \
sim:/motherboard/fcpu/sprf/MDRRAMReg

add wave -position insertpoint  \
sim:/motherboard/fcpu/controlSignals

add wave -position insertpoint  \
sim:/motherboard/fcpu/SC/stateReg/Q
add wave -position insertpoint  \
sim:/motherboard/fcpu/SC/cnt/count

add wave -position insertpoint  \
sim:/motherboard/fcpu/SC/stateClk

add wave -position insertpoint sim:/motherboard/fcpu/SC/stateReg/*

add wave -position insertpoint  \
sim:/motherboard/fcpu/falu/F

add wave -position insertpoint  \
sim:/motherboard/fcpu/falu/flagOut

add wave -position insertpoint  \
sim:/motherboard/fcpu/SC/cu/modeSrc

add wave -position insertpoint  \
sim:/motherboard/fcpu/SC/cu/state

add wave -position insertpoint  \
sim:/motherboard/fcpu/SC/cu/Flags

force -freeze sim:/motherboard/reset 1 0
run

force -freeze sim:/motherboard/reset 0 0

run -all