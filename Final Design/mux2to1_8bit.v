//Author : Ashwin de Silva
//Last Updated : 2018 Apr 19

//This module contains the 2 to 1 multiplexer module for 8bit

module mux2to1_8bit(

input [7:0] A,
input [7:0] B,
input sel,
output reg [7:0] OUT

);

always @(A or B or sel) 
	begin
		case(sel)
			1'b0 : OUT = A;
			1'b1 : OUT = B;
		endcase
	end

endmodule

