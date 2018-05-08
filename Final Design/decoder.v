//Author : Ashwin de Silva
//Last Updated : 2018 Mar 29

//This module define the B bus write enable 4 to 16 decoder

module decoder(

input [23:0] L,C1,C2,C3,T,E,
input [7:0] PC, //or 8
input [7:0] MDR, 
input [7:0] MBRU,
input [3:0] B_bus_ctrl,
output reg [23:0] B_bus

);

always@(B_bus_ctrl or L or C1 or C2 or C3 or T or E or PC or MBRU or MDR)
	begin 
		case(B_bus_ctrl)
		
			4'b0001 : B_bus <= {16'b0,MDR};
			
			4'b0010 : B_bus <= {16'b0,PC};
			
			4'b0011 : B_bus <= {16'b0, MBRU};
			
			4'b0100 : B_bus <= L;
			
			4'b0101 : B_bus <= C1;
			
			4'b0110 : B_bus <= C2;
			
			4'b0111 : B_bus <= C3;
			
			4'b1000 : B_bus <= T;
			
			4'b1001 : B_bus <= E;
			
			default : B_bus <= 24'b0;
			
		endcase
	end
	
endmodule

