restart
delete wave *
add wave current_state
add wave next_state
add wave clk
add wave reset
add wave start
add wave ready_multi
add wave load_multi
add wave enable
add wave enable_res
add wave flush
add wave ready

force clk 0 0ns, 1 5ns -repeat 10ns

# init state, wait on release of reset
force reset 0 0ns
force start 1 0ns
force ready_multi 0 0ns

# release reset and press start afterwards
force reset 1 10ns
force start 0 20ns
force start 1 30ns

# multiplication is ready
force ready_multi 1 80ns
force ready_multi 0 90ns

run 200ns
