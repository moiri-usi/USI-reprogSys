#!/usr/bin/python
# -*- coding: utf-8 -*-

###############################################################
#                         IMPORT MODULES                      #
###############################################################
import sys, os


def compiler(instruction):
    d={"REGA":0,"REGB":1,"REGC":2,"REGD":3}
    def int2bin(n, count=24):
	"""returns the binary of integer n, using count number of digits"""
        return "".join([str((n >> y) & 1) for y in range(count-1, -1, -1)])
    split_inst = filter(None,instruction.replace("\n"," ").replace(","," ").split(" "))    


    if "NOP" in split_inst[0]:
        opcode = 0
    elif "MOVE" in split_inst[0]:
        if split_inst[1].isdigit():    
            opcode  = 1 << 14;  opcode += int(split_inst[1]) << 6; opcode += d[split_inst[2]]
    elif "ADD" in split_inst[0]:
        if split_inst[1].isdigit():
	    opcode  = 2 << 14;  opcode += int(split_inst[1]) << 6;  opcode += d[split_inst[2]] << 4; opcode += d[split_inst[2]] << 2;  opcode += d[split_inst[3]]
        else:
            opcode  = 2 << 14;  opcode += 0 << 6;                   opcode += d[split_inst[1]] << 4; opcode += d[split_inst[2]] << 2;  opcode += d[split_inst[3]]
    elif "OR" in split_inst[0]:
        if split_inst[1].isdigit():
            opcode  = 3 << 14;  opcode += int(split_inst[1]) << 6;  opcode += d[split_inst[2]] << 4; opcode += d[split_inst[2]] << 2;  opcode += d[split_inst[3]]
        else:
            opcode  = 3 << 14;  opcode += 0 << 6;                   opcode += d[split_inst[1]] << 4; opcode += d[split_inst[2]] << 2;  opcode += d[split_inst[3]]                        
    elif "AND" in split_inst[0]:
        if split_inst[1].isdigit():
            opcode  = 4 << 14;  opcode += int(split_inst[1]) << 6;  opcode += d[split_inst[2]] << 4; opcode += d[split_inst[2]] << 2;  opcode += d[split_inst[3]]
        else:
            opcode  = 4 << 14;  opcode += 0 << 6;                   opcode += d[split_inst[1]] << 4; opcode += d[split_inst[2]] << 2;  opcode += d[split_inst[3]]
    elif "SL" in split_inst[0]:
        if split_inst[1].isdigit():
            opcode  = 5 << 14;  opcode += int(split_inst[1]) << 6;  opcode += d[split_inst[2]]
    return int2bin(opcode,17)

if len(sys.argv) == 2:
    if sys.argv[1] == "-h":
	print "Registers: REGA, REGB, REGC, REGD"
	print ""
	print "Instructions: "
	print "NOP  - No operation"
	print "MOVE - Move data: MOVE 5,REGA -- REGA=5"
	print "ADD  - Addition:    ADD 5,REGA,REGB / ADD REGA,REGB,REGC -- REGC = REGA + REGB"
	print "OR   - Logical OR : OR 5,REGA,REGB  / OR REGA,REGB,REGC  -- REGC = REGA || REGB" 
	print "AND  - Logical AND: OR 5,REGA,REGB  / AND REGA,REGB,REGC -- REGC = REGA && RECB"
	print "SL   - Left shift:  SL 4,REGB       / SL REGA,REGB       -- REGB = REGA << 1"
	print ""
	print "Example:"
	print "SL 5,REGA"
	print "SL 8,REGB"
	print "NOP"
	print "NOP"
	print "ADD 5,REGA,REGC"
	print "NOP"
	print "NOP"
	print "ADD REGC,REGB,REGD"
	print ""
	print "Execution:./comp.py input output"

	exit()

if len(sys.argv) == 3:
    print "Compiling... "
    f=open(sys.argv[2],'w')
    for line in open(sys.argv[1],'r'):
        if not line.isspace():
	    f.write(compiler(line)+"\n")
    print "Completed"