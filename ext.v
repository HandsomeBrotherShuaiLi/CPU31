`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/21 16:26:38
// Design Name: 
// Module Name: ext
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


module ext #(parameter WIDTH=16)(
	input [WIDTH-1:0] a,
	input sext,
	output [31:0] b
    );
	 
	 reg [31:0] tmp;
	 assign b = tmp;
	 integer i;
	 always @ (*) begin
		if(sext) begin
			for(i=31;i>=WIDTH;i=i-1)
				tmp[i] = a[WIDTH-1];
			while(i>=0) begin
				tmp[i] = a[i];
				i = i-1;
			end
		end
		else begin
			for(i=31;i>=WIDTH;i=i-1)
				tmp[i] = 0;
			while(i>=0) begin
				tmp[i] = a[i];
				i = i-1;
			end
		end
	 end

endmodule
