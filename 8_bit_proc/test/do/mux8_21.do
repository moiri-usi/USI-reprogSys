restart
delete wave *
add wave *

force addr 0 0ns
force data_in_1 "00001001" 0ns
force data_in_2 "00001010" 0ns

force addr 1 33ns

run 100ns 
