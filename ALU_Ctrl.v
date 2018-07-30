module ALU_Ctrl( funct_i, ALUOp_i, ALU_operation_o, FURslt_o );

//I/O ports 
input      [6-1:0] funct_i;		//function field
input      [3-1:0] ALUOp_i;		//

output     [4-1:0] ALU_operation_o;  	//4bit,invertA,invertB,operation
output     [2-1:0] FURslt_o;
     
//Internal Signals
wire		[4-1:0] ALU_operation_o;
wire		[2-1:0] FURslt_o;

reg [4-1:0]ALU_operation_o_reg;
reg [2-1:0] FURslt_o_reg;

//Main function

	//	ALU operation: Ainvert Binvert null operation

always@(funct_i,ALUOp_i)begin

if(ALUOp_i==3'b001)begin
	ALU_operation_o_reg = 4'b0010;		//addi
end
	else begin
		case({ALUOp_i,funct_i})		//010 : r type
		9'b000010010: ALU_operation_o_reg = 4'b0010;		//add
		9'b000010000: ALU_operation_o_reg = 4'b0110;		//sub
		9'b000010100: ALU_operation_o_reg = 4'b0000;		//and
		9'b000010110: ALU_operation_o_reg = 4'b0001;		//or
		9'b000010101: ALU_operation_o_reg = 4'b1100;		//nor
		9'b000100000: ALU_operation_o_reg = 4'b0111;		//SLT
		9'b000000000: ALU_operation_o_reg = 4'b1000;		//SLL(shift left)
		9'b000000010: ALU_operation_o_reg = 4'b0000;		//SRL(shift right)	(mux the result of shifter)
		9'b000000110: ALU_operation_o_reg = 4'b1010;		//SLLV(second bit for mux)
		9'b000000100: ALU_operation_o_reg = 4'b0010;		//SRLV	(one bit different)
		endcase
	end


if(ALUOp_i==3'b001)begin		//addi
FURslt_o_reg=2'b00;
end

else if(ALUOp_i==3'b101)begin		//lui
FURslt_o_reg=2'b10;		//from zero extend
end
else begin
	case({ALUOp_i,funct_i})		//010 : r type
	9'b000010010: FURslt_o_reg = 2'b00;		//add
	9'b000010000: FURslt_o_reg = 2'b00;		//sub
	9'b000010100: FURslt_o_reg = 2'b00;		//and
	9'b000010110: FURslt_o_reg = 2'b00;		//or
	9'b000010101: FURslt_o_reg = 2'b00;		//nor
	9'b000100000: FURslt_o_reg = 2'b00;		//SLT
	9'b000000000: FURslt_o_reg = 2'b01;		//SLL(shift left)
	9'b000000010: FURslt_o_reg = 2'b01;		//SRL(shift right)	(mux the result of shifter)
	9'b000000110: FURslt_o_reg = 2'b01;		//SLLV
	9'b000000100: FURslt_o_reg = 2'b01;		//SRLV	(one bit different)
	endcase

end		
end	//end of always

assign FURslt_o = FURslt_o_reg;
assign ALU_operation_o = ALU_operation_o_reg;


/*your code here*/

endmodule     
