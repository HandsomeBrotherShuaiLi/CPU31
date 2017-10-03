`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/21 22:03:32
// Design Name: 
// Module Name: cpu_test
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


module cpu_test;
reg clk;
reg reset;
wire [31:0]pc;
wire [31:0]aluout;
wire [31:0]data;
wire wmem;
//reg [31:0]pc_in;
//reg ena;
//pcreg uut(.clk(clk),.reset(reset),.ena(ena),.data_in(pc_in),data_out(pc));
cpu uut(.clock(clk),.reset(reset),.pc(pc),.aluout(aluout),.data(data),.wmem(wmem));
//integer file_output;
//integer counter = 0;
initial begin
   //         file_output = $fopen("_______result.txt");
            // Initialize Inputs
            reset = 1;
            clk = 0;
            #10   reset = 0;
        end
        
        always #5 clk = ~clk;
            /*  always @(posedge clk) begin
                                          counter = counter+1;
                                          if(reset==0) begin
                       $fdisplay(file_output,"instr = %h",cpu_test.uut.instnext.meminst);
                         $fdisplay(file_output,"pc = %h",cpu_test.uut.pcccc.data_out);
                          $fdisplay(file_output,"regfiles0 = %h",cpu_test.uut.regf.tmp_data[0]);
                          $fdisplay(file_output,"regfiles1 = %h",cpu_test.uut.regf.tmp_data[1]);
                          $fdisplay(file_output,"regfiles2 = %h",cpu_test.uut.regf.tmp_data[2]);
                          $fdisplay(file_output,"regfiles3 = %h",cpu_test.uut.regf.tmp_data[3]);
                          $fdisplay(file_output,"regfiles4 = %h",cpu_test.uut.regf.tmp_data[4]);
                          $fdisplay(file_output,"regfiles5 = %h",cpu_test.uut.regf.tmp_data[5]);
                          $fdisplay(file_output,"regfiles6 = %h",cpu_test.uut.regf.tmp_data[6]);
                          $fdisplay(file_output,"regfiles7 = %h",cpu_test.uut.regf.tmp_data[7]);
                          $fdisplay(file_output,"regfiles8 = %h",cpu_test.uut.regf.tmp_data[8]);
                          $fdisplay(file_output,"regfiles9 = %h",cpu_test.uut.regf.tmp_data[9]);
                          $fdisplay(file_output,"regfiles10 = %h",cpu_test.uut.regf.tmp_data[10]);
                          $fdisplay(file_output,"regfiles11 = %h",cpu_test.uut.regf.tmp_data[11]);
                          $fdisplay(file_output,"regfiles12 = %h",cpu_test.uut.regf.tmp_data[12]);
                          $fdisplay(file_output,"regfiles13 = %h",cpu_test.uut.regf.tmp_data[13]);
                          $fdisplay(file_output,"regfiles14 = %h",cpu_test.uut.regf.tmp_data[14]);
                          $fdisplay(file_output,"regfiles15 = %h",cpu_test.uut.regf.tmp_data[15]);
                          $fdisplay(file_output,"regfiles16 = %h",cpu_test.uut.regf.tmp_data[16]);
                          $fdisplay(file_output,"regfiles17 = %h",cpu_test.uut.regf.tmp_data[17]);
                          $fdisplay(file_output,"regfiles18 = %h",cpu_test.uut.regf.tmp_data[18]);
                          $fdisplay(file_output,"regfiles19 = %h",cpu_test.uut.regf.tmp_data[19]);
                          $fdisplay(file_output,"regfiles20 = %h",cpu_test.uut.regf.tmp_data[20]);
                          $fdisplay(file_output,"regfiles21 = %h",cpu_test.uut.regf.tmp_data[21]);
                          $fdisplay(file_output,"regfiles22 = %h",cpu_test.uut.regf.tmp_data[22]);
                          $fdisplay(file_output,"regfiles23 = %h",cpu_test.uut.regf.tmp_data[23]);
                          $fdisplay(file_output,"regfiles24 = %h",cpu_test.uut.regf.tmp_data[24]);
                          $fdisplay(file_output,"regfiles25 = %h",cpu_test.uut.regf.tmp_data[25]);
                          $fdisplay(file_output,"regfiles26 = %h",cpu_test.uut.regf.tmp_data[26]);
                          $fdisplay(file_output,"regfiles27 = %h",cpu_test.uut.regf.tmp_data[27]);
                          $fdisplay(file_output,"regfiles28 = %h",cpu_test.uut.regf.tmp_data[28]);
                          $fdisplay(file_output,"regfiles29 = %h",cpu_test.uut.regf.tmp_data[29]);
                          $fdisplay(file_output,"regfiles30 = %h",cpu_test.uut.regf.tmp_data[30]);
                          $fdisplay(file_output,"regfiles31 = %h",cpu_test.uut.regf.tmp_data[31]);
                         // $fdisplay(file_output,"instr = %h",cpu_test.uut.instnext.meminst);
                          //$fdisplay(file_output,"pc = %h",cpu_test.uut.pcccc.data_out);
                  end
                  end*/
                 
               
endmodule
