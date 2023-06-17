`timescale 1ns/1ps

module test_div_mult_cascade;

parameter CLK_PERIOD = 10;

	
reg          CLK, RST;
reg   [3:0]  NUMERATOR_IN,  DENOMINATOR_IN;
wire  [3:0]  Q_OUT, R_OUT;



div_mult_cascade test(.CLK(CLK), .RST(RST), .NUMERATOR_IN(NUMERATOR_IN), .DENOMINATOR_IN(DENOMINATOR_IN), .Q_OUT(Q_OUT), .R_OUT(R_OUT));



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

#15 NUMERATOR_IN <= 4'd7; 
#65 NUMERATOR_IN <= 4'd9;
#65 NUMERATOR_IN <= 4'd5;
#65 NUMERATOR_IN <= 4'd8;
end

initial
begin

#15 DENOMINATOR_IN <= 4'd7; 
#65 DENOMINATOR_IN <= 4'd3;
#65 DENOMINATOR_IN <= 4'd2;
#65 DENOMINATOR_IN <= 4'd2;
end



initial 

$monitor ($time, "clk=%b", CLK, " Q_OUT = %h", Q_OUT);
endmodule


