`timescale 1ns/1ps

module test_barrelshifter_18bit;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [17:0]  A_IN, SHIFT_IN;
wire  [17:0]  SHIFT_OUT;



BARRELSHIFTER_18BIT test(.CLK(CLK), .RST(RST), .A_IN(A_IN), .SHIFT_IN(SHIFT_IN), .SHIFT_OUT(SHIFT_OUT));



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

#110 A_IN <= 18'd512; 
#60 A_IN <= 18'd2020;
#60 A_IN <= 18'd10;
#60 A_IN <= 18'b110011001100110011;
#60 A_IN <= 18'b110011001100110011;
end

initial
begin

#110 SHIFT_IN <= 18'b000000000100000000; 
#60 SHIFT_IN <= 18'b010000000000000000;
#60 SHIFT_IN <= 18'b000001000000000000;
#60 SHIFT_IN <= 18'b000000000000001000;
#60 SHIFT_IN <= 18'b100000000000000000;
end




initial 

$monitor ($time, "clk=%b", CLK, " SHIFT_OUT = %h", SHIFT_OUT);
endmodule


