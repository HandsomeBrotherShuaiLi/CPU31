`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/21 21:44:25
// Design Name: 
// Module Name: adddd
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


module adddd(
	input [31:0] a,
	input [31:0] b,
	output [31:0] c
);
	reg [31:0] tmp;
	
	assign c = tmp;
	always @(*) begin
		tmp = a + b;
	end

endmodule
