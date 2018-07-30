module ALU_1bit( result, carryOut, a, b, invertA, invertB, operation, carryIn, less ); 
  
  output wire result;
  output wire carryOut;
  
  input wire a;		//sources
  input wire b;
  input wire invertA;
  input wire invertB;
  input wire[1:0] operation;
  input wire carryIn;
  input wire less;
  
	reg            result_temp;
	wire a_temp,b_temp;		//used to be reg
	wire	      sum, cout_temp;

	Full_adder FA (sum,cout_temp,carryIn,a_temp,b_temp);	//(sum, carryOut, carryIn, input1, input2)
	assign carryOut = ( (operation == 2'b10) || (operation == 2'b11) ) ? cout_temp : 1'b0;	//add,sub,slt
	xor xor1(a_temp,a,invertA);
	xor xor2(b_temp,b,invertB);

	always@(*)
	begin
		case(operation)	//modifyed
			2'b00: result_temp = a_temp & b_temp;	//and
			2'b01: result_temp = a_temp | b_temp;	//or
			2'b10: result_temp = sum;		//add
			2'b11: result_temp = less;		//less
		endcase
	end
	assign result = result_temp;
  /*your code here*/ 
  
endmodule