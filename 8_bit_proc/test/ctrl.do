restart

delete wave *
add wave clk
add wave reset_n
add wave opcode
add wave addr_in_1
add wave addr_in_2
add wave addr_out
add wave sel_const
add wave sel_in_1
add wave sel_in_2
add wave sel_op
add wave we_n

force clk 0 0ns, 1 10ns -repeat 20ns
force reset_n 0 0ns
force opcode "000" 0ns
force addr_in_1 "00" 0ns
force addr_in_2 "00" 0ns
force addr_out "00" 0ns

force reset_n 1 30ns
force opcode "011" 100ns
force addr_in_1 "01" 100ns
force addr_in_2 "11" 100ns
force addr_out "00" 100ns

run 200ns
