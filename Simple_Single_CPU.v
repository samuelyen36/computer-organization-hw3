module Simple_Single_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles

wire [31:0]const_four;
wire [31:0]PC_out;
wire [31:0]PC_plus_four;	//PC,PC+4
wire [31:0]instruction; //store the instruction from IM
wire RegDst,RegWrite,ALUSrc;
wire [2:0]ALUOP;
wire [2-1:0]FURslt,leftRight;
wire [3:0]ALU_operation;
wire [4:0]write_reg_num;
wire [32-1:0] write_data;
wire [32-1:0] read_data_1;
wire [32-1:0] read_data_2;
wire [32-1:0] SE_instruction;
wire [32-1:0] ZF_instruction;
wire [32-1:0] ALU_actual_input_2;
wire [31:0]ALU_ans;
wire ALU_zero,ALU_overflow;
wire [31:0] shift_ans;
wire [32-1:0]actual_shamt;
wire[32-1:0]shift_instruction;
wire [32-1:0]shift_register;

assign const_four = 32'd4;

//modules
Program_Counter PC(
        .clk_i(clk_i),      
       .rst_n(rst_n),     
	  .pc_in_i(PC_plus_four) ,   
	    .pc_out_o(PC_out) 
	    );
	
Adder Adder1(
        .src1_i(PC_out),     
	    .src2_i(const_four),
	    .sum_o(PC_plus_four)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(PC_out),  
	    .instr_o(instruction)   
	    );

Mux2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instruction[20:16]),
        .data1_i(instruction[15:11]),
        .select_i(RegDst),
        .data_o(write_reg_num)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_n(rst_n) ,     
        .RSaddr_i(instruction[25:21]) ,  
        .RTaddr_i(instruction[20:16]) ,  
        .RDaddr_i(write_reg_num) ,  
        .RDdata_i(write_data)  , 
        .RegWrite_i(RegWrite),
        .RSdata_o(read_data_1) ,  
        .RTdata_o(read_data_2)   
        );
	
Decoder Decoder(
        .instr_op_i(instruction[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALUOp_o(ALUOP),  //p is LARGE CASE 
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst)   
		);

ALU_Ctrl AC(
        .funct_i(instruction[5:0]),   
        .ALUOp_i(ALUOP),  
        .ALU_operation_o(ALU_operation),
		.FURslt_o(FURslt)
        );
	
Sign_Extend SE(
        .data_i(instruction[15:0]),
        .data_o(SE_instruction)
        );

Zero_Filled ZF(
        .data_i(instruction[15:0]),
        .data_o(ZF_instruction)
        );
		
Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(read_data_2),
        .data1_i(SE_instruction),
        .select_i(ALUSrc),
        .data_o(ALU_actual_input_2)
        );	
		
ALU ALU(
		.aluSrc1(read_data_1),
	    .aluSrc2(ALU_actual_input_2),
	    .ALU_operation_i(ALU_operation),
		.result(ALU_ans),
		.zero(ALU_zero),
		.overflow(ALU_overflow)
	    );


/*Mux_for_shift Mux_shift_input(		//midified at 4/29
	.data0_i(instruction[10:6]),
        .data1_i(read_data_1),
        .select_i(ALU_operation[1]),
        .data_o(actual_shamt)
);*/

Shifter shifter( 
		.result(shift_instruction), 
		.leftRight(ALU_operation[3]),
		.shamt(instruction[10:6]),
		.sftSrc(ALU_actual_input_2) 
		);
		
Shifter_32bits_input shifter_v( 
		.result(shift_register), 
		.leftRight(ALU_operation[3]),
		.shamt(ALU_actual_input_2),
		.sftSrc(read_data_1) 
	);

Mux2to1 #(.size(32)) Mux_for_shift_answer(
        .data0_i(shift_instruction),
        .data1_i(shift_register),
        .select_i(ALU_operation[1]),
        .data_o(shift_ans)
        );	


Mux3to1 #(.size(32)) RDdata_Source(
        .data0_i(ALU_ans),
        .data1_i(shift_ans),
		.data2_i(ZF_instruction),
        .select_i(FURslt),
        .data_o(write_data)
        );			

endmodule



