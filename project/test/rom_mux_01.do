restart
delete wave *
add wave add_a
add wave add_b
add wave op_a
add wave op_b

force add_a 000 0ns
force add_b 000 0ns

force add_a 001 10ns
force add_b 001 10ns

force add_a 010 20ns
force add_b 010 20ns

force add_a 011 30ns
force add_b 011 30ns

run 50ns
