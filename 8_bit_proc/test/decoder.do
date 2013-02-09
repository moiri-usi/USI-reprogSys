restart

delete wave *
add wave *

force instruction "00000000000000000" 0ns
force instruction "00100000101000000" 20ns

run 200ns
