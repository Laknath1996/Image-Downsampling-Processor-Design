//Author : Ashwin de Silva
//Last Updated : 2018 Apr 19

//This module contains the UART Receiver

module UART_Rx(

input clk,
input rx_in,
output [7:0] rx_byte,
output rx_done

);

parameter CLOCKS_PER_BIT = 55;//5209; //this is for 9600 baud rate

parameter IDLE = 3'b000;
parameter START = 3'b001;
parameter DATA_RX = 3'b010;
parameter STOP = 3'b110;
parameter CLEANUP = 3'b100;

parameter DELAY = 1;

reg [2:0] state = 0;
reg [7:0] data_byte = 0;
reg [32:0] clock_count = 0;
reg [2:0] rx_bit_index = 0;
reg rxdone = 0;

assign rx_byte = data_byte;
assign rx_done = rxdone;

always @(posedge clk)
	begin
		case(state)
			IDLE :
				begin 
					if (rx_in == 1'b0) begin
						rxdone <= 1'b0;
						data_byte <= 0;
						state <= START;
					end
					else begin
						rx_bit_index <= 0;
						clock_count <= 0;
						state <= IDLE;
					end
				end
				
			START :
				begin
					if (clock_count < ((CLOCKS_PER_BIT/2) - 1) ) begin
						clock_count <= clock_count + 1;
						state <= START;
					end
					else begin
						clock_count <= 0;
						state <= DATA_RX;
					end
				end
			
			DATA_RX :
				begin
					if (clock_count < CLOCKS_PER_BIT - 1) begin
						clock_count <= clock_count + 1;
						state <= DATA_RX;
					end
					else begin
						data_byte[rx_bit_index] <= rx_in;
						if (rx_bit_index < 7) begin
							rx_bit_index <= rx_bit_index + 1;
							state <= DATA_RX;
							clock_count <= 0;
						end
						else begin
							rx_bit_index <= 0;
							clock_count <= 0;
							state <= STOP;
						end
					end
				end
				
			STOP :
				begin
					if (clock_count < CLOCKS_PER_BIT - 1) begin
						clock_count <= clock_count + 1;
						state <= STOP;
					end
					else begin
						state <= CLEANUP;
						clock_count <= 0;
					end
				end
				
			CLEANUP :
			
				begin
					if (clock_count < DELAY - 1) begin
						clock_count <= clock_count + 1;
					end
					else begin
						rxdone <= 1'b1;
						state <= IDLE;
						clock_count <= 0;
					end
				end
			
			default : state <= IDLE;
			
		endcase
	end
endmodule


