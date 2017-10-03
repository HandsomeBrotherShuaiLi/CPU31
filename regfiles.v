`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/21 16:14:32
// Design Name: 
// Module Name: regfiles
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


module regfiles(
	input clk, //�Ĵ�����ʱ���źţ��½���д�����ݣ�ע�⣺pc Ϊ�����أ���Ϊ�½��أ�
	input rst, //reset �źţ�reset ��Ч=1ʱȫ���Ĵ�������
	input we, //д��Ч�źţ�we ��Чʱ�Ĵ������ܱ�д��
	input [4:0] raddr1, //�����ȡ�ļĴ����ĵ�ַ
	input [4:0] raddr2, //�����ȡ�ļĴ����ĵ�ַ
	input [4:0] waddr, //д�Ĵ����ĵ�ַ
	input [31:0] wdata, //д�Ĵ�������
	output [31:0] rdata1, //raddr1 ����Ӧ�Ĵ��������ݣ�ֻҪ��raddr1 �����뼴�����Ӧ����
	output [31:0] rdata2 //raddr2 ����Ӧ�Ĵ��������ݣ�ֻҪ��raddr2 �����뼴�����Ӧ����
	);
	reg [31:0] tmp_data[1023:0];//0�����⣿��������
	integer i;
	
	assign rdata1 = (raddr1==0) ? 0 : tmp_data[raddr1];
	assign rdata2 = (raddr2==0) ? 0 : tmp_data[raddr2];
	always @(negedge clk or posedge rst) begin
		if(rst) begin
			for(i=0;i<32;i=i+1)
				tmp_data[i] <= 0;
		end
		else 
		begin
		    if((waddr!=0)&&we)
			tmp_data[waddr] <= wdata;
		end
	end
endmodule
