`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/21 16:05:49
// Design Name: 
// Module Name: pcreg
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


module pcreg(
	input clk,		// 1位输入，寄存器时钟信号，上升沿时为PC寄存器赋值
	input rst,		// 1位输入，重置信号，高电平时将PC寄存器清零
	//input ena,					// 注：当ena信号无效时，rst也可以重置寄存器
	input [31:0] data_in,		// 32位输入，输入数据将被存入寄存器内部
	output reg [31:0] data_out	// 32位输出，工作时始终输出PC寄存器内部存储的值
	);
	//initial begin
	//data_out=0;
	//end
always @ (posedge clk or posedge rst) begin
		if(rst)
			data_out <=0;
		else
			data_out <= data_in;
	end

endmodule
