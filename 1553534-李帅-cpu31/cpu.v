`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/21 20:48:24
// Design Name: 
// Module Name: cpu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cpu(
		//input [31:0] meminst, // instruction memory
		//input [31:0] memdata, // data memory
		input clock,
		input reset,
		output [31:0] pc, // the next pc address
		output [31:0] aluout, // the address written into memory
		output [31:0] data, // the data written into memory
		output wmem, // the signal of writing into memory
		output [31:0]meminst
    );
    //wire [31:0] meminst;
     wire [31:0]memdata;
	 wire [31:0] next_pc,p4offset,p4;
	 wire [31:0] regf_qa,regf_d;
	 wire [4:0] regf_wn,reg2f;
	 wire zero,ovfl,carry,negative;
	 wire wreg,regrt,jal,m2reg,shift,aluimm,sext;
	 wire [31:0] alua,alub;
	 wire [3:0] aluc;
	 wire [1:0] pcsource;
	 wire [31:0] immext;
	 wire [31:0] mem2d;
	 
	 assign regf_wn = reg2f | {5{jal}};
	 
	 wire [5:0] op = meminst[31:26];
	 wire [5:0] func = meminst[5:0];
	 wire [4:0] rs = meminst[25:21];
	 wire [4:0] rt = meminst[20:16];
	 wire [4:0] rd = meminst[15:11];
	// wire [31:0] sa = {27'b0,meminst[10:6]};//*******************
	 wire [4:0] sa1=meminst[10:6];
	 wire [31:0] sa;
	 wire [15:0] imm = meminst[15:0];
	 //wire [31:0] immshift = {immext[29:0],2'b00};//*******************
	wire [17:0] immshift1={2'b00,meminst[15:0]};
	 wire [31:0]immshift;
	 wire [31:0] addr;//***********************************************
	 wire [25:0] meminst1;
	assign meminst1={meminst[25:0]-26'b00_0001_0000_0000_0000_0000_0000};
	assign addr={p4[31:28],2'b00,meminst1[25:0]};
	//assign addr={p4[31:28],meminst[25:0],2'b00};
	 wire wregovfl = wreg & ~ovfl;
	// wire pc_ena=1'b1;
	// wire ins_ena=1'b1;
	 pcreg pcccc(clock,reset,next_pc,pc);
	 regfiles regf(clock,reset,wregovfl,rs,rt,regf_wn,regf_d,regf_qa,data);
	 alu aaalu(alua,alub,aluc,aluout,zero,carry,negative,ovfl);
	 cpu_control cu(op,func,zero,wreg,regrt,jal,m2reg,shift,aluimm,sext,wmem,aluc,pcsource);//
	 adddd addpc4(pc,32'h00000001,p4);//
	 adddd addoffset(p4,immshift,p4offset);//******************
	 mux2x5 reg_wn(rd,rt,regrt,reg2f);
	 mux2x32 mem2reg(aluout,memdata,m2reg,mem2d);
	 mux2x32 reg_d(mem2d,pc+1,jal,regf_d);//
	 mux2x32 alu_a(regf_qa,sa,shift,alua);//******************
	 mux2x32 alu_b(data,immext,aluimm,alub);
	 wire [31:0]regf_qabian;
	 assign regf_qabian=(regf_qa-32'h00400000)>>2;
	 mux4x32 pc_select(p4,p4offset,regf_qabian,addr,pcsource,next_pc);//******************
	 ext #(16) eimm(imm,sext,immext);//ext #16
	  ext #(18) eimm2(immshift1,sext,immshift);
	 ext #(5) eimm3(sa1,sext,sa);
	 //alu aaalu(alua,alub,aluc,aluout,zero,carry,negative,ovfl);
     dram dmem(clock,wmem,aluout[9:0],data,memdata);
     //instmem instnext(clock,reset,pc,meminst);
    wire ena_ip=1'b1;
     iiram_ip iram(.clka(clock),.ena(ena_ip),.addra(pc[9:0]),.douta(meminst));
endmodule