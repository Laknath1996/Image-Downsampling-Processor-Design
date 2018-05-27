#Author : Ashwin e Silva
#Last upate : 24th May 2018

#define the instructions

import numpy as np

ins_dict = {
     'FETCH' : 0,
     'NOP' : 2,
     'LDAC' : 3,
     'STAC' : 5,
     'CLAC' : 7,
     'MVACMAR' : 8,
     'MVACC1' : 9,
     'MVACC2' : 10,
     'MVACC3' : 11,
     'MVACL' : 12,
     'MVACE' : 13,
     'MVACT' : 14,
     'MVC1' : 15,
     'MVC2' : 16,
     'MVC3' : 17,
     'MVT' : 18,
     'MVL' : 42,
     'INAC' : 19,
     'DEAC' : 20,
     'ADDT' : 21,
     'ADDL' : 22,
     'SUBE' : 23,
     'SUBL' : 24,
     'DIV'  : 25,
     'MUL2' : 26,
     'MUL4' : 27,
     'MUL512' : 28,
     'JUMP' : 29,
     'JMPZ' : 32,
     'JMNZ' : 37,
     'L1' : 120,#8
     'L2' : 21
     }


#Assembly to .hex converter

bin_ins = [] #holds the binary instructions

with open('inverter_assembly.txt','r') as f :
    for line in f :
        bin_ins.append(ins_dict[line[:-1]])

hex_ins = []
for ins in bin_ins :
    ins = hex(ins)
    ins = ins[2:]
    hex_ins.append(ins)  

with open('inverter_bin.hex','w') as f :
    for l in hex_ins :
        f.write(l)
        f.write('\n')


