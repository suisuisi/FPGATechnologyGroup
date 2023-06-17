`timescale 1ns/1ps

module test_mult_low_power;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [14:0]  A_IN;
reg   [14:0]  B_IN;
wire  [29:0]  PROD_OUT;



mult_low_power test(.CLK(CLK), .RST(RST), .A_IN(A_IN), .B_IN(B_IN), .PROD_OUT(PROD_OUT));



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

#15 A_IN <= 15'd11950; 
//#65 A_IN <= 15'd2020;
//#65 A_IN <= 15'd12157;//10;
//#65 A_IN <= 15'd1115;
end

initial
begin

#15 B_IN <= 15'd11950; 
//#65 B_IN <= 15'd2020;
//#65 B_IN <= 15'd1000;
//#65 B_IN <= 15'd1115;
end




initial 

$monitor ($time, "clk=%b", CLK, " PROD_OUT = %h", PROD_OUT);
endmodule


