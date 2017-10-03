`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/21 16:35:04
// Design Name: 
// Module Name: dram
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


module dram (
    input clk,//存储器时钟信号，上升沿时向 ram 内部写入数据 
    //input ena,//存储器有效信号，高电平时存储器才运行，否则输出 z 
    input wena,//存储器读写有效信号，高电平为写有效，低电平为读有效，与 ena 同时有效时才可对存储器进行读写 
	input [9:0] addr, // 输入地址，指定数据读写的地址
	input [31:0] data_in,
	output [31:0] data_out // 存储器读出的数据，ram 工作时持续输出相应地址的数据
	);

	reg [31:0] tmp [0:1023];
	assign data_out = tmp[addr];
	
	always @(posedge clk) begin
		if(wena)
		begin
		tmp[addr] <= data_in;
	     end

    end

endmodule