vsim -gui work.cpu
add wave -position insertpoint sim:/cpu/*

force -freeze sim:/cpu/resetRegs 1 0
force -freeze sim:/cpu/clk 0 0, 1 {50 ps} -r 100
run

force -freeze sim:/cpu/resetRegs 0 0
force -freeze sim:/cpu/gprf/loopGenerateRegs(0)/Reg/D 0002 0
run

