restart
delete wave *
add wave add_a
add wave op_a

force add_a 000 0ns

force add_a 001 10ns

force add_a 010 20ns

force add_a 011 30ns

run 50ns
