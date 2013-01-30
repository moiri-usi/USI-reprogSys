restart
delete wave *
add wave clk
add wave load_mult
add wave a_m
add wave b_m
add wave reset
add wave result_mult
add wave r_msb
add wave overflow_mult
add wave ready_mult
force clk 0 0ns, 1 20ns -repeat 40ns
force load_mult 1
force reset 1
force a_m "11100000000000000000000"
force b_m "11110000000000000000000"
run 80ns
force load_mult 0
run 200 ns
force load_mult 1
run 80 ns
force reset 0
force load_mult 0
run 80ns
force reset 1
force load_mult 1
run 80ns
force load_mult 0
run 2000ns