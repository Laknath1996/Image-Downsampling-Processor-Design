// inverter operation is done here.

module Inverter1(
clk
datain,
inverter_out,
);

input [7:0] datain;
input clk;
output reg [7:0] inverter_out;


always @(posedge clk) begin
	inverter_out = 255 - datain;
end


endmodule



//module Inverter1(
//clk
//);

//input clk;
//wire dataout;
//wire read_done;
//wire inversion_flag;
//wire invert_out;
//wire inversion_done;

//image_read Read(clk,dataout,read_done);

//invert invrt(dataout,inverter_out,read_done,inversion_done);

//image_write Write(inverter_out,inversion_done);

//endmodule



