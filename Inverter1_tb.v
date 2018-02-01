module Inverter1_tb();

reg [7:0] datain;
wire [7:0] inverter_out;

Inverter1 inv(datain,inverter_out);

reg [7:0] RAM [39999:0];

integer i;
integer fd;

initial begin 
	$readmemh("cat.txt",RAM);
	
	for(i = 0; i < 40000 ; i = i + 1) begin 
		datain <= RAM[i];
		#2;
		fd = $fopen("output.txt","a+");
		$fwrite(fd,"%h",inverter_out);
		$fclose(fd);
		#2;
	end
end

endmodule

