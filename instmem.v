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
 input clk,//�洢��ʱ���źţ�������ʱ�� ram �ڲ�д������ 
   input ena,//rst�洢����Ч�źţ��ߵ�ƽʱ�洢�������У�������� z 
  // input wena,//�洢����д��Ч�źţ��ߵ�ƽΪд��Ч���͵�ƽΪ����Ч���� ena ͬʱ��Чʱ�ſɶԴ洢�����ж�д
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
