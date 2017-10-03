`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/21 15:59:17
// Design Name: 
// Module Name: alu
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


module alu(
input [31:0] a,
input [31:0] b,
input [3:0] aluc,
output [31:0] r, 
output zero,
output carry,
output negative,
output overflow 
);

reg zero_temp;
reg carry_temp;
reg negative_temp;
reg overflow_temp;
reg [31:0] r_temp;

assign r=r_temp;
assign zero=zero_temp;
assign carry=carry_temp;
assign negative=negative_temp;
assign overflow=overflow_temp;

wire [31:0] result_temp [7:0];
wire [7:0] zero_flag;
wire [7:0] carry_flag;
wire [7:0] negative_flag;
wire [7:0] overflow_flag;

addsub32 as32_1(a,b,aluc[1],aluc[0],result_temp[0],zero_flag[0],carry_flag[0],negative_flag[0],overflow_flag[0]);
addsub32 as32_2(a,b,aluc[1],aluc[0],result_temp[1],zero_flag[1],carry_flag[1],negative_flag[1],overflow_flag[1]);
addsub32 as32_3(a,b,aluc[1],aluc[0],result_temp[2],zero_flag[2],carry_flag[2],negative_flag[2],overflow_flag[2]);
addsub32 as32_4(a,b,aluc[1],aluc[0],result_temp[3],zero_flag[3],carry_flag[3],negative_flag[3],overflow_flag[3]);
shifter shift_1(a,b,aluc[1],aluc[0],result_temp[4],zero_flag[4],carry_flag[4],negative_flag[4],overflow_flag[4]);
shifter shift_2(a,b,aluc[1],aluc[0],result_temp[5],zero_flag[5],carry_flag[5],negative_flag[5],overflow_flag[5]);
shifter shift_3(a,b,aluc[1],aluc[0],result_temp[6],zero_flag[6],carry_flag[6],negative_flag[6],overflow_flag[6]);
shifter shift_4(a,b,aluc[1],aluc[0],result_temp[7],zero_flag[7],carry_flag[7],negative_flag[7],overflow_flag[7]);

always @(*) begin
r_temp=0;
zero_temp=0;
negative_temp=0;
overflow_temp=0;
carry_temp=0;
    casex(aluc)
         4'b0000:begin // a + b (unsigned)
            r_temp=result_temp[0];
            zero_temp=zero_flag[0];
            carry_temp=carry_flag[0];
            negative_temp=negative_flag[0];
            overflow_temp=overflow_flag[0];
        end
        4'b0010:begin // a + b (signed)
            zero_temp=zero_flag[1];
            carry_temp=carry_flag[1];
            negative_temp=negative_flag[1];
            overflow_temp=overflow_flag[1];
            if ( ~overflow_temp ) begin //fix bug
                r_temp=result_temp[3];
            end
        end
        4'b0001:begin // a - b(unsigned)
            r_temp=result_temp[2];
            zero_temp=zero_flag[2];
            carry_temp=carry_flag[2];
            negative_temp=negative_flag[2];
            overflow_temp=overflow_flag[2];
        end
        4'b0011:begin // a - b(signed)
            zero_temp=zero_flag[3];
            carry_temp=carry_flag[3];
            negative_temp=negative_flag[3];
            overflow_temp=overflow_flag[3];
            if ( ~overflow_temp ) begin //fix bug
                r_temp=result_temp[3];
            end
        end
        4'b1100: begin //sra
            r_temp=result_temp[4];
            zero_temp=zero_flag[4];
            carry_temp=carry_flag[4];
            negative_temp=negative_flag[4];
            overflow_temp=overflow_flag[4];
        end
        4'b1110:begin //srl
            r_temp=result_temp[5];
            zero_temp=zero_flag[5];
            carry_temp=carry_flag[5];
            negative_temp=negative_flag[5];
            overflow_temp=overflow_flag[5];
        end
        4'b1111:begin //sll
            r_temp=result_temp[6];
            zero_temp=zero_flag[6];
            carry_temp=carry_flag[6];
            negative_temp=negative_flag[6];
            overflow_temp=overflow_flag[6];
        end
        4'b1101:begin //slv
            r_temp=result_temp[7];
            zero_temp=zero_flag[7];
            carry_temp=carry_flag[7];
            negative_temp=negative_flag[7];
            overflow_temp=overflow_flag[7];
        end
        4'b0100:begin // AND
            r_temp = a & b; 
            if( r_temp == 0 )
                zero_temp = 1;
            else 
                zero_temp = 0;
            carry_temp = 0;
            overflow_temp = 0;
            if( r_temp[31] == 1 )
               negative_temp = 1;
            else if( r_temp[31] == 0 )
               negative_temp = 0;
        end
        4'b0101: begin //OR
            r_temp = a | b;
            if( r_temp == 0 )
                zero_temp=1;
            else 
                zero_temp=0;
            carry_temp=0;
            overflow_temp=0;
            if( r_temp[31] == 1 )
                negative_temp = 1;
            else if( r_temp[31] == 0 )
                negative_temp=0;
        end  
        4'b0110:begin //XOR
            r_temp = a^b;
            if(r_temp==0)
                zero_temp=1;
            else 
                zero_temp=0;
            carry_temp=0;
            overflow_temp=0;
            if( r_temp[31] == 1 )
               negative_temp = 1;
            else if(r_temp[31] == 0 )
               negative_temp = 0;
        end 
        4'b0111:begin //NOR
            r_temp = ~(a|b);
            if( r_temp == 0 )
                zero_temp = 1;
            else 
                zero_temp = 0;
            carry_temp=0;
            overflow_temp=0;
            if(r_temp[31]==1)
                negative_temp=1;
            else if(r_temp[31]==0)
            negative_temp=0;
        end  
        4'b1000:begin //LUI
            r_temp = {b[15:0],16'b0};
            if (r_temp == 0 )
                zero_temp = 1;
            else zero_temp = 0;
            if (r_temp[31])
                negative_temp = 1;
            else negative_temp = 0;
            carry_temp = 0;
            overflow_temp = 0;
        end
        4'b1001:begin //LUI
            r_temp = {b[15:0],16'b0};
            if (r_temp ==0)
                zero_temp =1;
            else zero_temp = 0;
            if (r_temp[31])
              negative_temp = 1;
            else negative_temp = 0;
            carry_temp = 0;
            overflow_temp = 0;
        end
        4'b1011:begin //SLT, SLTI
            r_temp=($signed(a)<$signed(b))?1:0;
        end
        4'b1010:begin //SLTU, SLTIU
            r_temp=(a<b)?1:0;
        end
    endcase
end    
endmodule
