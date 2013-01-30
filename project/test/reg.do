restart
delete wave *
add wave *
force clk 0 0ns, 1 20ns -repeat 40ns
force enable 1
force reset 0
force op "11000011001010110000000000000000" 
run 80ns
force reset 1
run 200 ns
force enable 0
run 2000ns
force reset 0
run 100ns