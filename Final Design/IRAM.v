 //Author : Ashwin de Silva
//Last Updated : 2018 Mar 30

//This module defines the IRAM (Read Only Memory) of the processor 

module IRAM(

input clk,
input [7:0] addr, //This connects to the PC
output reg [7:0] dout //This connects to MBRU

);

reg [7:0] ROM [120:0];

//Define the Assembly Instructions

parameter FETCH = 8'd0;
parameter NOP = 8'd2;
parameter LDAC = 8'd3;
parameter STAC = 8'd5;
parameter CLAC = 8'd7;
parameter MVACMAR = 8'd8;
parameter MVACC1 = 8'd9;
parameter MVACC2 = 8'd10;
parameter MVACC3 = 8'd11;
parameter MVACL = 8'd12;
parameter MVACE = 8'd13;
parameter MVACT = 8'd14;
parameter MVC1 = 8'd15;
parameter MVC2 = 8'd16;
parameter MVC3 = 8'd17;
parameter MVT = 8'd18;
parameter MVL = 8'd42;
parameter INAC = 8'd19;
parameter DEAC = 8'd20;
parameter ADDT = 8'd21;
parameter ADDL = 8'd22;
parameter SUBE = 8'd23;
parameter SUBL = 8'd24;
parameter DIV  = 8'd25;
parameter MUL2 = 8'd26;
parameter MUL4 = 8'd27;
parameter MUL512 = 8'd28;
parameter JUMP = 8'd29;
parameter JMPZ = 8'd32;
parameter JMNZ = 8'd37;
parameter L1 = 8'd120;
parameter L2 = 8'd21;

//Define memory space

always @(posedge clk)
	begin
		dout <= ROM[addr];
	end
	
initial 
begin

ROM[0] = CLAC; //AC <— 0 
ROM[1] = MVACMAR; //MAR <— AC 
ROM[2] = LDAC;//AC <— DRAM[0]
ROM[3] = INAC; //Ac <- AC + 1
ROM[4] = MVACL; //L <— AC (L = 256 : Length of one image side)
ROM[5] = MVL; //AC <- L 
ROM[6] = INAC; //AC <— AC  + 1 
ROM[7] = INAC; //AC <— AC + 1 
ROM[8] = MVACC1; //C1 <— AC (C1 = 258) 
ROM[9] = CLAC; //AC <— 0 
ROM[10] = INAC; //AC <— AC + 1 
ROM[11] = MVACC3; //C3 <— AC (C3 = 1)
ROM[12] = CLAC;// AC <- 0
ROM[13] = INAC;// AC <- AC + 1
ROM[14] = INAC; //AC <- AC + 1
ROM[15] = MVACC2; //C2 <- AC (C2 = 2)
 
ROM[16] = MVL; //AC <— L 
ROM[17] = DEAC; //AC <— AC - 1 
ROM[18] = DEAC; //AC <- AC - 1
ROM[19] = MUL512; //AC <— AC << 9 
ROM[20] = MVACE; //E <— AC (E = 261630) E = 65278

ROM[21] = CLAC; //AC <— 0 ------------------L2 
ROM[22] = MVACT; //T <— AC (T = 0) 
ROM[23] = MVC1; //AC <— C1 
ROM[24] = SUBL; // AC <— AC - L 
ROM[25] = DEAC; // AC <— AC - 1 
ROM[26] = MVACMAR; //MAR <— AC 
ROM[27] = LDAC; //AC <— DRAM[MAR] 
ROM[28] = ADDT; //AC <—  AC + T 
ROM[29] = MVACT; //T <— AC 
ROM[30] = MVC1; //AC <— C1 
ROM[31] = SUBL; //AC <— AC - L 
ROM[32] = MVACMAR; //MAR <— AC 
ROM[33] = LDAC;//AC <— DRAM[MAR] 
ROM[34] = MUL2;//AC <— AC << 1 
ROM[35] = ADDT; //AC <— AC + T 
ROM[36] = MVACT; //T <— AC 
ROM[37] = MVC1; //AC <— C1 
ROM[38] = SUBL; //AC <— AC - L 
ROM[39] = INAC; //AC <— AC + 1 
ROM[40] = MVACMAR; //MAR <— AC 
ROM[41] = LDAC; //AC <— DRAM[MAR] 
ROM[42] = ADDT; //AC <— AC + T 
ROM[43] = MVACT; //T <— AC 
ROM[44] = MVC1; //AC <— C1 
ROM[45] = DEAC; //AC <— AC - 1 
ROM[46] = MVACMAR; //MAR <— AC 
ROM[47] = LDAC; //AC <— DRAM[MAR] 
ROM[48] = MUL2; //AC <— AC << 1 
ROM[49] = ADDT; //AC <— AC + T 
ROM[50] = MVACT; //T <— AC 
ROM[51] = MVC1; //AC <— C1 
ROM[52] = MVACMAR; //MAR <— AC 
ROM[53] = LDAC;//AC <— DRAM[MAR] 
ROM[54] = MUL4; //AC <— AC << 2 
ROM[55] = ADDT; //AC <— AC + T 
ROM[56] = MVACT; //T <— AC 
ROM[57] = MVC1; //AC  <— C1 
ROM[58] = INAC; //AC  <— AC + 1 
ROM[59] = MVACMAR; //MAR <— AC 
ROM[60] = LDAC; //AC <— DRAM[MAR] 
ROM[61] = MUL2; //AC <— AC << 1 
ROM[62] = ADDT; //AC <— AC + T 
ROM[63] = MVACT; //T <— AC 
ROM[64] = MVC1; //AC <— C1 
ROM[65] = ADDL; //AC <— AC + L 
ROM[66] = DEAC; //AC <— AC - 1 
ROM[67] = MVACMAR; //MAR <— AC 
ROM[68] = LDAC; //AC <— DRAM[MAR] 
ROM[69] = ADDT; //AC <— AC + T 
ROM[70] = MVACT; //T <— AC 
ROM[71] = MVC1;//AC <— C1 
ROM[72] = ADDL; //AC <— AC + L 
ROM[73] = MVACMAR; //MAR <— AC 
ROM[74] = LDAC; //AC <— DRAM[MAR] 
ROM[75] = MUL2; //AC <— AC << 1 
ROM[76] = ADDT; //AC <— AC + T 
ROM[77] = MVACT; //T <— AC 
ROM[78] = MVC1; //AC <— C1 
ROM[79] = ADDL; //AC <— AC + L 
ROM[80] = INAC; //AC <— AC + 1 
ROM[81] = MVACMAR; //MAR <— AC 
ROM[82] = LDAC; //AC <— DRAM[MAR] 
ROM[83] = ADDT; //AC <— AC + T 
ROM[84] = MVACT; //T <— AC 

ROM[85] = MVT; //AC <— C3 
ROM[86] = DIV; //MAR <— AC 
ROM[87] = MVC3;//AC <— T 
ROM[88] = MVACMAR; //AC <— AC >> 4 
ROM[89] = STAC; //DRAM[MAR] <— AC

ROM[90] = MVC3; //AC <— C3 
ROM[91] = INAC; //AC <— AC + 1 
ROM[92] = MVACC3; //C3 <— AC 
ROM[93] = MVC2; //AC <— C2 
ROM[94] = INAC; //AC <— AC + 1 
ROM[95] = INAC; //AC <— AC + 1 
ROM[96] = MVACC2; //C2 <— AC 
ROM[97] = MVC1; //AC <— C1 
ROM[98] = INAC; //AC <— AC + 1 
ROM[99] = INAC; //AC <— AC + 1 
ROM[100] = MVACC1; //C1 <— AC 

ROM[101] = MVC1;//AC <— C1 
ROM[102] = SUBE; //AC <— AC - E ; IF (AC - E == 0) THEN Z = 1 
ROM[103] = JMPZ; //IF (Z = 1) THEN GOTO L1
ROM[104] = L1;

ROM[105] = MVC2; //AC <— C2
ROM[106] = SUBL; //AC <— AC - L ; IF  (AC - L == 0 ) THEN Z = 1 
ROM[107] = JMNZ;  //IF  (Z = 0) THEN GOTO L2
ROM[108] = L2; 
ROM[109] = MVC1; //AC <— C1 
ROM[110] = ADDL; //AC <— AC + L 
ROM[111] = INAC; //AC <— AC + 1 
ROM[112] = INAC; //AC <— AC + 1 
ROM[113] = MVACC1; //C1 <— AC 
ROM[114] = CLAC; //AC <— 0 
ROM[115] = INAC; //AC <- AC + 1
ROM[116] = INAC; //AC <- AC + 1
ROM[117] = MVACC2; //C2 <— AC 
ROM[118] = JUMP; //GOTO L2
ROM[119] = L2;

ROM[120] = NOP; //-------------------------L1


end
endmodule


