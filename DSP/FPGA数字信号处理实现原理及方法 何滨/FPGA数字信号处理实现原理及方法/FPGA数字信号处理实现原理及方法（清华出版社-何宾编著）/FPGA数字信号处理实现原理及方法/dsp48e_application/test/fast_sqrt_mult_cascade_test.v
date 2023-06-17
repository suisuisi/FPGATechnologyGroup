`timescale 1ns/1ps

module test_fast_sqrt_mult_cascade;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [7:0]  X_IN; 
wire  [4:0]  SQRT_OUT;



fast_sqrt_mult_cascade test(.CLK(CLK), .RST(RST), . X_IN(X_IN), . SQRT_OUT(SQRT_OUT));



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

#15 X_IN <= 8'd121; 
#10 X_IN <= 8'd49;
#10 X_IN <= 8'd48;
#10 X_IN <= 8'd16;
end




initial 

$monitor ($time, "clk=%b", CLK, " SQRT_OUT = %h", SQRT_OUT);
endmodule


