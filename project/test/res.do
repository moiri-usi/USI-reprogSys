restart
delete wave *
add wave *
force clk 0 0ns, 1 20ns -repeat 40ns
force flush 0
force reset 0
force enable 0
force sign 1 
force exp "10000110"
force mant "01010110000000000000000" 
run 80ns
force reset 1
force enable 1
run 200 ns
force flush 1
run 300 ns
force flush 0
run 2000ns
force reset 0
run 100ns