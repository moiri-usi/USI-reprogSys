restart
delete wave *
add wave add_b
add wave op_b

force add_b 000 0ns

force add_b 001 10ns

force add_b 010 20ns

force add_b 011 30ns

run 50ns
