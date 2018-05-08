//Author : Ashwin de Silva
//Last Updated : 2018 Mar 29

//This module defines the Memory Buffer Register Unit (MBRU)

module MBRU(

input clk,
input fetch, //Connects to MIR Fetch Signal
input [7:0] ins_in, //This connects to IRAM dout
output reg [7:0] ins_out //This connects to control store MBRU

);

always@(posedge clk)
	begin
	if (fetch) ins_out <= ins_in;
	end

endmodule

