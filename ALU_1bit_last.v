module ALU_1bit_last( result, carryOut, a, b, invertA, invertB, operation, carryIn, less , overflow , set);		//two more function 
  
  output wire result;
  output wire carryOut;
  output wire overflow;	//set if overflow happened
  output wire set;	//connect to the first ALU
  
  input wire a;		//source
  input wire b;
  input wire invertA;
  input wire invertB;
  input wire[1:0] operation;
  input wire carryIn;
  input wire less;
  
	wire           a_temp, b_temp;
	reg	result_reg;
	reg overflow_reg=1'b0;
	wire	      sum, cout_temp;

	xor xor1(a_temp,a,invertA);
	xor xor2(b_temp,b,invertB);
	Full_adder FA (sum,cout_temp,carryIn,a_temp,b_temp);
	assign carryOut = ( (operation == 2'b10) || (operation == 2'b11) ) ? cout_temp : 1'b0;	//add,sub,slt
	assign set = sum;		//set at here
	

	always@(*)		//mux
	begin
		
		case(operation)	//modifyed
			2'b00: result_reg = a_temp & b_temp;	//and
			2'b01: result_reg = a_temp | b_temp;	//or
			2'b10: result_reg = sum;		//add
			2'b11: result_reg = less;		//less
		endcase
	if( operation == 2'b10 || operation == 2'b11)	begin	//add or slt will cause overflow
	    case( {sum, invertB,a, b} )
    	        4'b1000: overflow_reg = 1'b1;
    	        4'b1101: overflow_reg = 1'b1;
    	        4'b0011: overflow_reg = 1'b1;
    	        4'b0110: overflow_reg = 1'b1;
    	        default: overflow_reg = 1'b0;
    	    endcase
    	end
	if(operation == 2'b00 || operation==2'b01)	begin	//can this be deleted?
    	   overflow_reg = 1'b0;
	end

end

	assign result = result_reg;
	assign overflow=overflow_reg;

  /*your code here*/ 
  
endmodule