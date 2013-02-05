restart
delete wave *
add wave *
force clk 0 0ns, 1 20ns -repeat 40ns
force reset 0
run 80ns
force reset 1
force addr_A "000"
force addr_B "000"
force start 0
force show_AB 0
run 200 ns
force start 1
run 800 ns