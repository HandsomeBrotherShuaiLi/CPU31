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
    input clk,//�洢��ʱ���źţ�������ʱ�� ram �ڲ�д������ 
    //input ena,//�洢����Ч�źţ��ߵ�ƽʱ�洢�������У�������� z 
    input wena,//�洢����д��Ч�źţ��ߵ�ƽΪд��Ч���͵�ƽΪ����Ч���� ena ͬʱ��Чʱ�ſɶԴ洢�����ж�д 
	input [9:0] addr, // �����ַ��ָ�����ݶ�д�ĵ�ַ
	input [31:0] data_in,
	output [31:0] data_out // �洢�����������ݣ�ram ����ʱ���������Ӧ��ַ������
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