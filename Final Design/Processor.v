//Author : Ashwin de Silva
//Last Updated : 2018 Mar 29

//This module defines the CPU 

module Processor(

//input reset,
input enable,
input clk,
input [7:0] din,
output [15:0] addr_out,
output [7:0] dout,
output finish,
output read,
output write

);

wire [7:0] ins_address;
wire [7:0] ins_in;
wire [7:0] ins_out;
wire [29:0] MIR;
wire [23:0] A_bus;
wire [23:0] B_bus;
wire [23:0] C_bus;
wire Z_flag;
//wire [7:0] data_bus_wr;
//wire [7:0] data_bus_rd;
//wire [16:0] address_bus;
wire [23:0] L_bus;
wire [23:0] C1_bus;
wire [23:0] C2_bus;
wire [23:0] C3_bus;
wire [23:0] T_bus;
wire [23:0] E_bus;
wire [7:0] MDR_bus;
wire finish_flag;

assign read = MIR[6];
assign write = MIR[5];

assign finish = finish_flag;

//Define the Control Store 

control_store CTRL(
.enable(enable),
.clk(clk),
.Z_flag(Z_flag),
.addr(MIR[29:22]),
.MBRU(ins_out),
.MIR(MIR),
.finish(finish_flag)

);

//Define the PC (Program Counter)

PC PC(
.enable(enable),
//.reset(reset),
.clk(clk),
.inc(MIR[4]),
.C_bus(C_bus),
.finish(finish_flag),
.ins_address(ins_address),
.load(MIR[15])
);

//Define the Instruction Memory

IRAM IRAM(
.clk(clk),
.addr(ins_address),
.dout(ins_in)
);

//Define the MBRU

MBRU MBRU(
.clk(clk),
.fetch(MIR[7]),
.ins_in(ins_in),
.ins_out(ins_out)
);

//Define the General Purpose Registers

//L

GPR L(
.clk(clk),
.load(MIR[14]),
.C_bus(C_bus),
.data_out(L_bus)
);

//C1

GPR C1(
.clk(clk),
.load(MIR[13]),
.C_bus(C_bus),
.data_out(C1_bus)
);

//C2

GPR C2(
.clk(clk),
.load(MIR[12]),
.C_bus(C_bus),
.data_out(C2_bus)
);

//C3

GPR C3(
.clk(clk),
.load(MIR[11]),
.C_bus(C_bus),
.data_out(C3_bus)
);

//T

GPR T(
.clk(clk),
.load(MIR[10]),
.C_bus(C_bus),
.data_out(T_bus)
);

//E

GPR E(
.clk(clk),
.load(MIR[9]),
.C_bus(C_bus),
.data_out(E_bus)
);

//AC

GPR AC(
.clk(clk),
.load(MIR[8]),
.C_bus(C_bus),
.data_out(A_bus)
);

//Define the MDR

MDR MDR(
.clk(clk),
.load(MIR[16]),
.read(MIR[6]),
.write(MIR[5]),
.C_bus(C_bus[7:0]),
.data_in_DRAM(din),
.data_out_DRAM(dout),
.data_out_Bbus(MDR_bus)
);

//Define the MAR

MAR MAR(
.clk(clk),
.load(MIR[17]),
.C_bus(C_bus[15:0]),
.data_address(addr_out)
);

//Define the Data Memory

/*
DRAM DRAM(
.clk(clk),
.write(MIR[5]),
.read(MIR[6]),
.din(data_bus_wr),
.dout(data_bus_rd),
.addr(address_bus)
);
*/

//Define the ALU

ALU ALU(
.A_bus(A_bus),
.B_bus(B_bus),
.operation(MIR[21:18]),
.C_bus(C_bus),
.enable(enable),
.clk(clk),
.Z_flag(Z_flag)
);

//Define the decoder for B bus

decoder decoder(
.L(L_bus),
.C1(C1_bus),
.C2(C2_bus),
.C3(C3_bus),
.T(T_bus),
.E(E_bus),
.PC(ins_address),
.MDR(MDR_bus),
.MBRU(ins_out),
.B_bus_ctrl(MIR[3:0]),
.B_bus(B_bus)
);

endmodule











