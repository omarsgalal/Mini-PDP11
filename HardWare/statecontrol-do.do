quit -sim
vcom ./statecontrol-test.vhd
vsim -gui work.statecontroltest
add wave -position insertpoint sim:/statecontroltest/*

add wave -position insertpoint sim:/statecontroltest/sp/stateReg/Q

add wave -position insertpoint sim:/statecontroltest/sp/cnt/count

add wave -position insertpoint sim:/statecontroltest/sp/cu/*
run -all