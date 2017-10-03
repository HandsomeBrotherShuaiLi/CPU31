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
	input clk,		// 1λ���룬�Ĵ���ʱ���źţ�������ʱΪPC�Ĵ�����ֵ
	input rst,		// 1λ���룬�����źţ��ߵ�ƽʱ��PC�Ĵ�������
	//input ena,					// ע����ena�ź���Чʱ��rstҲ�������üĴ���
	input [31:0] data_in,		// 32λ���룬�������ݽ�������Ĵ����ڲ�
	output reg [31:0] data_out	// 32λ���������ʱʼ�����PC�Ĵ����ڲ��洢��ֵ
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
