//Author : Ashwin de Silva
//Last Updated : 2018 Mar 29

//This module defines the DRAM

module DRAM(

input clk,
input write,
input read,
input [7:0] din,
input [15:0] addr,
output reg [7:0] dout

);

reg [7:0] RAM [65535:0];//262144
integer i;

always @(posedge clk)
	begin
		if (write) RAM[addr] <= din;
		if (read) dout <= RAM[addr];
	end

	
endmodule

	