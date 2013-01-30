restart
delete wave *
add wave *
force enable_add 0
force exp_a "10000110"
force exp_b "10000010"
force r_msb 1
run 80ns
force enable_add 1
run 80 ns
force enable_add 0
run 300 ns
force exp_a "10100110"
force exp_b "10110010"
run 80ns
force enable_add 1
run 80 ns