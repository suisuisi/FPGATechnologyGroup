`timescale 1ns/1ps

module test_conv_round_cc;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [24:0]  AIN; 
reg   [17:0]  BIN;
reg   [47:0]  CIN;
wire  [43:0]  ROUND_OUT;



conv_round_cc test(.CLK(CLK), .RST(RST), .AIN(AIN), .BIN(BIN), .CIN(CIN), .ROUND_OUT(ROUND_OUT));



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

#15 AIN <= 25'd1; 
#15 AIN <= 25'd24; //1.1000


end

initial
begin

#15 BIN <= 18'd520; 
#15 BIN <= 18'd1;


end

initial
begin

#15 CIN <= 48'h000000000007; 
 
end



initial 

$monitor ($time, "clk=%b", CLK, " ROUND_OUT = %h", ROUND_OUT);
endmodule


