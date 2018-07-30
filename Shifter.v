module Shifter( result, leftRight, shamt, sftSrc  );
    
  output wire[31:0] result;

  input wire leftRight;
  input wire[4:0] shamt;
  input wire[31:0] sftSrc ;

	reg [31:0]temp;

//assign result = ((leftRight == 1'b0) ) ? sftSrc>>shamt : sftSrc<<shamt;	

always @(*) begin
	if(leftRight==1'b0)begin
	temp = sftSrc>>shamt;	
	end

	if(leftRight==1'b1)begin
	temp = sftSrc<<shamt;	
	end

end

assign result = temp;
  /*your code here*/ 
	
endmodule