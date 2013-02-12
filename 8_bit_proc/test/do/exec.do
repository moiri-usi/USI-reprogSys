restart
delete wave *
add wave *

force ctrl "000" 0ns
force data_in_a "00000101" 0ns
force data_in_b "00000110" 0ns

force ctrl "001" 20ns
force ctrl "010" 40ns
force ctrl "011" 60ns
force ctrl "100" 80ns
force ctrl "101" 100ns

run 120ns 
