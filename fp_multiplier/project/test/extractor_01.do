restart
delete wave *
add wave *
force clk 0 0ns, 1 20ns -repeat 40ns
force load_mant 1
force reset 1
force result_mult "111100000000000000000001000000000000000000000000"
run 80ns
force load_mant 0
force reset 0
run 200 ns
run 2000ns