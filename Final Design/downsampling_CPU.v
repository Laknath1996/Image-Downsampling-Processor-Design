//Author : Ashwin de Silva
//Last Updated : 2018 Apr 19

//This module contains the CPU module (integrated)

module downsampling_CPU(

input clk,
input reset_IO,
// input reset_Proc,
input rx,
output tx,
output status_IO,
output status_CPU,
output check,
output [7:0] rx_out,
output [7:0] tx_out

);

//define busses

wire [15:0] address_bus_IO;
wire [15:0] address_bus_CPU;
wire [15:0] address_bus;

wire [7:0] data_in_bus;
wire [7:0] data_out_bus;

wire [7:0] data_write_bus_CPU;
wire [7:0] data_read_bus_CPU;

wire write;
wire read;

wire write_CPU;
wire read_CPU;

wire write_IO;
wire read_IO;

wire tx_start;

wire [7:0] rx_byte;
wire [7:0] tx_byte;

wire tx_done;
wire rx_done;

wire finish;

wire enable;

wire clka;

wire sel;

assign status_IO = ~sel;
assign status_CPU = sel; 
assign rx_out = rx_byte;
assign tx_out = tx_byte;

assign check = enable;


DRAM DRAM(

.addr(address_bus),
.din(data_in_bus),
.read(read),
.write(write),
.clk(clka),
.dout(data_out_bus)

);


/*
DataRAM_old DataRAM(

.address(address_bus),
.clock(clk),
.data(data_in_bus),
.rden(read),
.wren(write),
.q(data_out_bus)

);
*/


Processor Processor(

.din(data_read_bus_CPU),
.enable(enable),
.clk(clka),
//.reset(reset_Proc),
.dout(data_write_bus_CPU),
.addr_out(address_bus_CPU),
.finish(finish),
.write(write_CPU),
.read(read_CPU)

);

IO_module IO(

.clk(clka),
.reset(reset_IO),
.start(finish),
.rx_done(rx_done),
.tx_start(tx_start),
.tx_done(tx_done),
.ram_addr(address_bus_IO),
.write(write_IO),
.read(read_IO),
.reset_cpu(enable),
.sel(sel)

);

UART_Tx Tx(

.clk(clka),
.tx_start(tx_start),
.in_data_byte(tx_byte),
.tx_out(tx),
.tx_done(tx_done)

);

UART_Rx Rx(

.clk(clka),
.rx_in(rx),
.rx_byte(rx_byte),
.rx_done(rx_done)

);

mux2to1_16bit addr_mux(

.A(address_bus_IO),
.B(address_bus_CPU),
.sel(sel),
.OUT(address_bus)

);

mux2to1_8bit data_mux(

.A(rx_byte),
.B(data_write_bus_CPU),
.sel(sel),
.OUT(data_in_bus)

);

demux1to2_8bit data_demux(

.IN(data_out_bus),
.sel(sel),
.A(tx_byte),
.B(data_read_bus_CPU)

);

mux2to1 write_mux(

.A(write_IO),
.B(write_CPU),
.sel(sel),
.OUT(write)

);

mux2to1 read_mux(

.A(read_IO),
.B(read_CPU),
.sel(sel),
.OUT(read)

);


clock_gen clock(

.clk_in(clk),
.clk_out(clka)

);



endmodule




