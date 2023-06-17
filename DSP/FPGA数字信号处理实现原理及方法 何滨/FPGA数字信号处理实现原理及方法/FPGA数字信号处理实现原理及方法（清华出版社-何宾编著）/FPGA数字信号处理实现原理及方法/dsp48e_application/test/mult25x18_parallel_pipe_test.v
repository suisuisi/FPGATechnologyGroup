`timescale 1ns/1ps

module test_mult25x18_parallel_pipe;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [24:0]  A_IN;
reg   [17:0]  B_IN;
wire  [42:0]  PROD_OUT;



mult25x18_parallel_pipe test(.CLK(CLK), .RST(RST), .A_IN(A_IN), .B_IN(B_IN), .PROD_OUT(PROD_OUT));



initial 
begin
CLK <= 1'b0;
RST <= 1'b1;
#20 RST <= 1'b0;
end

initial 
begin


end


always
#(CLK_PERIOD/2) CLK = ~CLK;

initial
begin

#15 A_IN <= 25'd512; 
#65 A_IN <= 25'd2020;
#65 A_IN <= 25'd16777215;//10;
#65 A_IN <= 25'd1115;
end

initial
begin

#15 B_IN <= 18'd512; 
#65 B_IN <= 18'd2020;
#65 B_IN <= 18'd100000;
#65 B_IN <= 18'd1115;
end




initial 

$monitor ($time, "clk=%b", CLK, " PROD_OUT = %h", PROD_OUT);
endmodule


