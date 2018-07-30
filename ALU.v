module ALU( aluSrc1, aluSrc2, ALU_operation_i, result, zero, overflow );

//I/O ports 
input	[32-1:0] aluSrc1;
input	[32-1:0] aluSrc2;
input	 [4-1:0] ALU_operation_i;

output	[32-1:0] result;
output			 zero;
output			 overflow;

//Internal Signals
wire			 zero;
wire			 overflow;
wire	[32-1:0] result;

//Main function
/*your code here*/
wire carry_out_temp[31:0];
wire set;		//connect with the last result
	//wire overflow_temp;
 wire invertA;
 wire invertB;
 wire[1:0] operation;
  
 assign invertA = ALU_operation_i[3];
 assign invertB = ALU_operation_i[2];
 assign operation[1:0] = ALU_operation_i[1:0];
    


wire first_carry_in = ( ({invertA,invertB,operation} == 4'b0110) || ({invertA,invertB,operation} == 4'b0111) )? 1'b1 : 1'b0;  
  	//carry in = 1 if B is inverted and do the adad operation

	//ALU_1bit( result, carryOut, a, b, invertA, invertB, operation, carryIn, less )
  ALU_1bit alu_0 (result[0],carry_out_temp[0],aluSrc1[0],aluSrc2[0],invertA,invertB,operation[1:0],first_carry_in, set);	//set connect to last bit
  ALU_1bit alu_1 (result[1],carry_out_temp[1],aluSrc1[1],aluSrc2[1],invertA,invertB,operation[1:0],carry_out_temp[0],1'b0);
  ALU_1bit alu_2 (result[2],carry_out_temp[2],aluSrc1[2],aluSrc2[2],invertA,invertB,operation[1:0],carry_out_temp[1],1'b0);
  ALU_1bit alu_3 (result[3],carry_out_temp[3],aluSrc1[3],aluSrc2[3],invertA,invertB,operation[1:0],carry_out_temp[2],1'b0);
  ALU_1bit alu_4 (result[4],carry_out_temp[4],aluSrc1[4],aluSrc2[4],invertA,invertB,operation[1:0],carry_out_temp[3],1'b0);
  ALU_1bit alu_5 (result[5],carry_out_temp[5],aluSrc1[5],aluSrc2[5],invertA,invertB,operation[1:0],carry_out_temp[4],1'b0);
  ALU_1bit alu_6 (result[6],carry_out_temp[6],aluSrc1[6],aluSrc2[6],invertA,invertB,operation[1:0],carry_out_temp[5],1'b0);
  ALU_1bit alu_7 (result[7],carry_out_temp[7],aluSrc1[7],aluSrc2[7],invertA,invertB,operation[1:0],carry_out_temp[6],1'b0);
  ALU_1bit alu_8 (result[8],carry_out_temp[8],aluSrc1[8],aluSrc2[8],invertA,invertB,operation[1:0],carry_out_temp[7],1'b0);
  ALU_1bit alu_9 (result[9],carry_out_temp[9],aluSrc1[9],aluSrc2[9],invertA,invertB,operation[1:0],carry_out_temp[8],1'b0);
  ALU_1bit alu_10 (result[10],carry_out_temp[10],aluSrc1[10],aluSrc2[10],invertA,invertB,operation[1:0],carry_out_temp[9],1'b0);
  ALU_1bit alu_11 (result[11],carry_out_temp[11],aluSrc1[11],aluSrc2[11],invertA,invertB,operation[1:0],carry_out_temp[10],1'b0);
  ALU_1bit alu_12 (result[12],carry_out_temp[12],aluSrc1[12],aluSrc2[12],invertA,invertB,operation[1:0],carry_out_temp[11],1'b0);
  ALU_1bit alu_13 (result[13],carry_out_temp[13],aluSrc1[13],aluSrc2[13],invertA,invertB,operation[1:0],carry_out_temp[12],1'b0);
  ALU_1bit alu_14 (result[14],carry_out_temp[14],aluSrc1[14],aluSrc2[14],invertA,invertB,operation[1:0],carry_out_temp[13],1'b0);
  ALU_1bit alu_15 (result[15],carry_out_temp[15],aluSrc1[15],aluSrc2[15],invertA,invertB,operation[1:0],carry_out_temp[14],1'b0);
  ALU_1bit alu_16 (result[16],carry_out_temp[16],aluSrc1[16],aluSrc2[16],invertA,invertB,operation[1:0],carry_out_temp[15],1'b0);
  ALU_1bit alu_17 (result[17],carry_out_temp[17],aluSrc1[17],aluSrc2[17],invertA,invertB,operation[1:0],carry_out_temp[16],1'b0);
  ALU_1bit alu_18 (result[18],carry_out_temp[18],aluSrc1[18],aluSrc2[18],invertA,invertB,operation[1:0],carry_out_temp[17],1'b0);
  ALU_1bit alu_19 (result[19],carry_out_temp[19],aluSrc1[19],aluSrc2[19],invertA,invertB,operation[1:0],carry_out_temp[18],1'b0);
  ALU_1bit alu_20 (result[20],carry_out_temp[20],aluSrc1[20],aluSrc2[20],invertA,invertB,operation[1:0],carry_out_temp[19],1'b0);
  ALU_1bit alu_21 (result[21],carry_out_temp[21],aluSrc1[21],aluSrc2[21],invertA,invertB,operation[1:0],carry_out_temp[20],1'b0);
  ALU_1bit alu_22 (result[22],carry_out_temp[22],aluSrc1[22],aluSrc2[22],invertA,invertB,operation[1:0],carry_out_temp[21],1'b0);
  ALU_1bit alu_23 (result[23],carry_out_temp[23],aluSrc1[23],aluSrc2[23],invertA,invertB,operation[1:0],carry_out_temp[22],1'b0);
  ALU_1bit alu_24 (result[24],carry_out_temp[24],aluSrc1[24],aluSrc2[24],invertA,invertB,operation[1:0],carry_out_temp[23],1'b0);
  ALU_1bit alu_25 (result[25],carry_out_temp[25],aluSrc1[25],aluSrc2[25],invertA,invertB,operation[1:0],carry_out_temp[24],1'b0);
  ALU_1bit alu_26 (result[26],carry_out_temp[26],aluSrc1[26],aluSrc2[26],invertA,invertB,operation[1:0],carry_out_temp[25],1'b0);
  ALU_1bit alu_27 (result[27],carry_out_temp[27],aluSrc1[27],aluSrc2[27],invertA,invertB,operation[1:0],carry_out_temp[26],1'b0);
  ALU_1bit alu_28 (result[28],carry_out_temp[28],aluSrc1[28],aluSrc2[28],invertA,invertB,operation[1:0],carry_out_temp[27],1'b0);
  ALU_1bit alu_29 (result[29],carry_out_temp[29],aluSrc1[29],aluSrc2[29],invertA,invertB,operation[1:0],carry_out_temp[28],1'b0);
  ALU_1bit alu_30 (result[30],carry_out_temp[30],aluSrc1[30],aluSrc2[30],invertA,invertB,operation[1:0],carry_out_temp[29],1'b0);
  ALU_1bit_last alu_31 (result[31],carry_out_temp[31],aluSrc1[31],aluSrc2[31],invertA,invertB,operation[1:0],carry_out_temp[30],1'b0,overflow,set);
// ALU_1bit( result, carryOut, a, b, invertA, invertB, operation, carryIn, less , overflow , set);
  
  /*your code here*/

	assign zero = (result == 32'b0) ? 1'b1 : 1'b0;		//zero=1 if result=0


endmodule
