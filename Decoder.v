module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o );
     
//I/O ports
input	[6-1:0] instr_op_i;

output			RegWrite_o;
output	[3-1:0] 	ALUOp_o;
output			ALUSrc_o;
output			RegDst_o;
 
//Internal Signals
wire	[3-1:0] ALUOp_o;
wire			ALUSrc_o;
wire			RegWrite_o;
wire			RegDst_o;

//Main function

reg RegWrite_o_reg ,  ALUSrc_o_reg , RegDst_o_reg;
reg [3-1:0]ALUOp_o_reg;

			//instr_op_i gives me the type of instruction
always@(instr_op_i)begin
	case(instr_op_i)	//regdest
		6'b111111:RegDst_o_reg=1;		//r type
		6'b110111:RegDst_o_reg=0;		//i type
		6'b110000:RegDst_o_reg=0;		//lui
	endcase
	case(instr_op_i)	//
		6'b111111:RegWrite_o_reg=1;
		6'b110111:RegWrite_o_reg=1;
		6'b110000:RegWrite_o_reg=1;
	endcase
	case(instr_op_i)	//
		6'b111111:ALUOp_o_reg=3'b000;	//r type
		6'b110111:ALUOp_o_reg=3'b001;	//i type , addi
		6'b110000:ALUOp_o_reg=3'b101;	//lui
	endcase	
	case(instr_op_i)	//
		6'b111111:ALUSrc_o_reg=0;
		6'b110111:ALUSrc_o_reg=1;
		6'b110000:ALUSrc_o_reg=1;
	endcase
end

assign ALUOp_o = ALUOp_o_reg;
assign RegWrite_o = RegWrite_o_reg;
assign ALUSrc_o = ALUSrc_o_reg;
assign RegDst_o = RegDst_o_reg;


/*your code here*/

endmodule
   