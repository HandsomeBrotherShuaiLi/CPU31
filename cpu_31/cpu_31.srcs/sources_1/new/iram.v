`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/21 16:43:24
// Design Name: 
// Module Name: iram
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

//��ʱ��addr��pc�Ѿ�����õ��ˡ�
module iram(
   input clk,//�洢��ʱ���źţ�������ʱ�� ram �ڲ�д������ 
    input ena,//�洢����Ч�źţ��ߵ�ƽʱ�洢�������У�������� z 
    input wena,//�洢����д��Ч�źţ��ߵ�ƽΪд��Ч���͵�ƽΪ����Ч���� ena ͬʱ��Чʱ�ſɶԴ洢�����ж�д 
	input [31:0] addr, // �����ַ��pc�ĵ�ַ
	output [31:0] data_out // �洢�����������ݣ�ram ����ʱ���������Ӧ��ַ������
    );
    reg [31:0] inst[32];
    assign data_out=inst;
    always @(posedge clk) begin
            if(ena) 
            begin
            if(wena)
            
               end
            else
            tmp[addr]=32'bz;
        end
    
endmodule
