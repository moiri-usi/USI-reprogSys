restart
delete wave *
add wave *

force clk 0 0ns, 1 10ns -repeat 20ns
force reset_n 0 0ns
force data_in "00000001" 0ns

force reset_n 1 22ns

run 100ns 
