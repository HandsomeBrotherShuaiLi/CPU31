`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/21 21:19:08
// Design Name: 
// Module Name: instmem
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


module instmem(
 input clk,//存储器时钟信号，上升沿时向 ram 内部写入数据 
   input ena,//rst存储器有效信号，高电平时存储器才运行，否则输出 z 
  // input wena,//存储器读写有效信号，高电平为写有效，低电平为读有效，与 ena 同时有效时才可对存储器进行读写
   input [31:0]addr,
   output reg [31:0]meminst
    );
    //wire [31:0]Addr;
    //assign Addr=addr-32'h00400000;
    reg [31:0] reg_inst[0:1024];
   integer i;
    initial begin
    for(i=0;i<=31;i=i+1)
    reg_inst[i]=32'b0;
    end
    //reg [31:0]dataout;
   // assign meminst=dataout;
    initial begin
    $readmemh("S:/Vivado/lout.txt", reg_inst); 
    end
 
    always @(*)
    begin
    if(ena!=1)
   meminst= reg_inst[addr];
     else
    meminst=32'bz;
    end
   endmodule
