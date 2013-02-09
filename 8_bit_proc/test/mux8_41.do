restart
delete wave *
add wave *

force addr "00" 0ns
force data_in_1 "00001001" 0ns
force data_in_2 "00001010" 0ns
force data_in_3 "00001011" 0ns
force data_in_4 "00001100" 0ns

force addr "01" 10ns
force addr "10" 20ns
force addr "11" 30ns

run 100ns 
