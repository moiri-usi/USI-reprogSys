restart
delete wave *
add wave *

force clk 0 0ns, 1 10ns -repeat 20ns
force reset_n 0 0ns
force we_n "1111" 0ns
force data_in "10001000" 0ns

force reset_n 1 22ns
force we_n "1110" 40ns
force we_n "1101" 60ns
force we_n "1011" 80ns
force we_n "0111" 100ns

run 120ns 
