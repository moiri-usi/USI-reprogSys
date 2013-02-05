restart
delete wave *
add wave *

force clk 0 0ns, 1 5ns -repeat 10ns
force reset 0 0ns
force load_mult 0 0ns
force add_ctrl 0 0ns
force ready_ctrl 0 0ns

force reset 1 10ns
force load_mult 1 20ns

force add_ctrl 1 60ns
force add_ctrl 0 70ns
force add_ctrl 1 160ns
force add_ctrl 0 170ns
force add_ctrl 1 210ns
force add_ctrl 0 220ns

force ready_ctrl 1 250ns

run 300ns 
