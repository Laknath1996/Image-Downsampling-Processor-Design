//Author : Ashwin de Silva
//Last Updated : 2018 Apr 19

//This module contains the 2 to 1 multiplexer module for 16bit

module mux2to1_16bit(

input [15:0] A,
input [15:0] B,
input sel,
output reg [15:0] OUT

);

always @(A or B or sel) 
	begin
		case(sel)
			1'b0 : OUT = A;
			1'b1 : OUT = B;
		endcase
	end

endmodule

