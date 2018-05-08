//Author : Ashwin de Silva
//Last Updated : 2018 Apr 19

//This module contains the 1 to 2 demultiplexer module

module demux1to2_8bit(

input [7:0] IN,
input sel,
output reg [7:0] A,
output reg [7:0] B

);

always @(IN or sel) 
	begin
		case(sel)
			1'b0 : A = IN;
			1'b1 : B = IN;
		endcase
	end

endmodule
