`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/21 17:45:39
// Design Name: 
// Module Name: control_unit
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


module cpu_control(
		input [5:0] op,
		input [5:0] func,
		input z,						// alu status
		output wreg,				// we of reg
		output regrt,				// 1 for rt & 0 for rd
		output jal,					// if instruction is jal
		output m2reg,				// 1 for memory->reg & 0 for ALU->reg
		output shift,				// 1 for sa & 0 for reg.qa
		output aluimm,				// 1 for imm & 0 for reg.qb
		output sext,				// 1 for signal ext & 0 for ext
		output wmem,				// we of memory
		output [3:0] aluc,
		output [1:0] pcsource	// 00 for P4,01 for P4+imm,10 for reg.qa,11 for jump
    );

	 wire r_type  = ~|op;
	 wire i_add   = r_type &  func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];
	 wire i_addi  =            ~op[5] &   ~op[4] &    op[3] &   ~op[2] &   ~op[1] &   ~op[0];
	 wire i_addiu =            ~op[5] &   ~op[4] &    op[3] &   ~op[2] &   ~op[1] &    op[0];
	 wire i_addu  = r_type &  func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] &  func[0];
	 wire i_and   = r_type &  func[5] & ~func[4] & ~func[3] &  func[2] & ~func[1] & ~func[0];
	 wire i_andi  =            ~op[5] &   ~op[4] &    op[3] &    op[2] &   ~op[1] &   ~op[0];
	 wire i_beq   =            ~op[5] &   ~op[4] &   ~op[3] &    op[2] &   ~op[1] &   ~op[0];
	 wire i_bne   =            ~op[5] &   ~op[4] &   ~op[3] &    op[2] &   ~op[1] &    op[0];
	 wire i_j     =            ~op[5] &   ~op[4] &   ~op[3] &   ~op[2] &    op[1] &   ~op[0];
	 wire i_jal   =            ~op[5] &   ~op[4] &   ~op[3] &   ~op[2] &    op[1] &    op[0];
	 wire i_jr    = r_type & ~func[5] & ~func[4] &  func[3] & ~func[2] & ~func[1] & ~func[0];
	 wire i_lui   =            ~op[5] &   ~op[4] &    op[3] &    op[2] &    op[1] &    op[0];
	 wire i_lw    =             op[5] &   ~op[4] &   ~op[3] &   ~op[2] &    op[1] &    op[0];
	 wire i_nor   = r_type &  func[5] & ~func[4] & ~func[3] &  func[2] &  func[1] &  func[0];
	 wire i_or    = r_type &  func[5] & ~func[4] & ~func[3] &  func[2] & ~func[1] &  func[0];
	 wire i_ori   =            ~op[5] &   ~op[4] &    op[3] &    op[2] &   ~op[1] &    op[0];
	 wire i_sll   = r_type & ~func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];
	 wire i_sllv  = r_type & ~func[5] & ~func[4] & ~func[3] &  func[2] & ~func[1] & ~func[0];
	 wire i_slt   = r_type &  func[5] & ~func[4] &  func[3] & ~func[2] &  func[1] & ~func[0];
	 wire i_slti  =            ~op[5] &   ~op[4] &    op[3] &   ~op[2] &    op[1] &   ~op[0];
	 wire i_sltiu =            ~op[5] &   ~op[4] &    op[3] &   ~op[2] &    op[1] &    op[0];
	 wire i_sltu  = r_type &  func[5] & ~func[4] &  func[3] & ~func[2] &  func[1] &  func[0];
	 wire i_sra   = r_type & ~func[5] & ~func[4] & ~func[3] & ~func[2] &  func[1] &  func[0];
	 wire i_srav  = r_type & ~func[5] & ~func[4] & ~func[3] &  func[2] &  func[1] &  func[0];
	 wire i_srl   = r_type & ~func[5] & ~func[4] & ~func[3] & ~func[2] &  func[1] & ~func[0];
	 wire i_srlv  = r_type & ~func[5] & ~func[4] & ~func[3] &  func[2] &  func[1] & ~func[0];
	 wire i_sub   = r_type &  func[5] & ~func[4] & ~func[3] & ~func[2] &  func[1] & ~func[0];
	 wire i_subu  = r_type &  func[5] & ~func[4] & ~func[3] & ~func[2] &  func[1] &  func[0];
	 wire i_sw    =             op[5] &   ~op[4] &    op[3] &   ~op[2] &    op[1] &    op[0];
	 wire i_xor   = r_type &  func[5] & ~func[4] & ~func[3] &  func[2] &  func[1] & ~func[0];
	 wire i_xori  =            ~op[5] &   ~op[4] &    op[3] &    op[2] &    op[1] &   ~op[0];
	 
	 assign wreg  = i_add  | i_addu  | i_and  | i_nor  | i_or   | i_sll   | i_sllv | i_slt   | i_sltu  |
						 i_sra  | i_srav  | i_srl  | i_srlv | i_sub  | i_subu  | i_xor  | i_addi  | i_addiu |
						 i_andi | i_lui   | i_lw   | i_ori  | i_slti | i_sltiu | i_xori | i_jal   ;
	 assign regrt = i_addi | i_addiu | i_andi | i_lui  | i_lw   | i_ori   | i_slti | i_sltiu | i_xori  ;
	 assign jal   = i_jal  ;
	 assign m2reg = i_lw   ;
	 assign shift = i_sll  | i_sra   | i_srl  ;
	 assign aluimm= i_addi | i_addiu | i_andi | i_lui  | i_ori  | i_slti  | i_xori | i_sltiu | i_lw | i_sw;
	 assign sext  = i_addi | i_beq   | i_bne  | i_lw   | i_sw   | i_slti  | i_addiu;
	 assign aluc[3]= i_sll | i_sllv  | i_slt  | i_sltu | i_sra  | i_srav  | i_srl  | i_srlv  | i_sltiu |
						  i_lui | i_slti  ;
	 assign aluc[2]= i_and | i_nor   | i_or   | i_sll  | i_sllv | i_sra   | i_srav | i_srl   | i_srlv  |
						  i_xor | i_andi  | i_beq  | i_bne  | i_ori  | i_xori  ;
	 assign aluc[1]= i_add | i_nor   | i_sll  | i_sllv | i_slt  | i_sltu  | i_slti | i_sltiu | i_sub   |
						  i_xor | i_addi  | i_beq  | i_bne  | i_xori | i_lw    | i_sw;
	 assign aluc[0]= i_nor | i_or    | i_ori  | i_slt  | i_slti | i_srl   | i_srlv | i_sub   | i_subu  ;
	 assign wmem   = i_sw  ;
	 assign pcsource[1]    = i_jr    | i_j    | i_jal  ;
	 assign pcsource[0]    = i_jal || i_j|| i_beq&&z|| i_bne&&!z;

endmodule
