restart

delete wave *
add wave *

force clk 0 0ns, 1 10ns -repeat 20ns
force rst_n 0 0ns

force rst_n 1 23ns
force in_instruction "00100000101000000" 0ns
force in_instruction "00100000110000001" 45ns
force in_instruction "00000000000000000" 65ns
force in_instruction "00000000000000000" 85ns
force in_instruction "00000000000000000" 105ns
force in_instruction "00000000000000000" 125ns
force in_instruction "01000000000000110" 145ns

run 1000ns
