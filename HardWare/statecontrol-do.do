quit -sim

vsim -gui work.statecontroltest
add wave -position insertpoint sim:/statecontroltest/*

run -all