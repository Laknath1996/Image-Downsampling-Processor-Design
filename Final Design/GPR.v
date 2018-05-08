//Author : Ashwin de Silva
//Last Updated : 2018 Mar 29

//This module defines the General Purpose Registers

module GPR(

input clk,
input load,
input [23:0] C_bus, //connects to the MIR load signal
output reg [23:0] data_out //connects to the B_bus (MUX)

);

always@(posedge clk)
	begin 
		if (load) data_out <= C_bus;
	end

endmodule 


	