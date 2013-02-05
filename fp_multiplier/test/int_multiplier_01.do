restart
delete wave *
add wave *
force clk 0 0ns, 1 20ns -repeat 40ns
force load_mult 1
force reset 1
force a_m "00000000000000000000110"
force b_m "00000000000000000000111"
run 80 ns
force load_mult 0
run 2000ns
