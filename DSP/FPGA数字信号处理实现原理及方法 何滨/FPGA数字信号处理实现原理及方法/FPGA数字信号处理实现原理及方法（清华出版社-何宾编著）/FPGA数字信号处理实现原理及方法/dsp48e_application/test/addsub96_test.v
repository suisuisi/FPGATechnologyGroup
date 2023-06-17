`timescale 1ns/1ps

module test_addsub96;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [94:0]  AIN, BIN;
reg           ADD_SUB;
wire  [95:0]  SUM_OUT;


addsub96 test(.CLK(CLK), .RST(RST), .AIN(AIN), .BIN(BIN), .ADD_SUB(ADD_SUB), .SUM_OUT(SUM_OUT));



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
#15 BIN <= 95'd281474976710665; 
end

initial
begin
#15 AIN <= 95'd10; 
end

initial
begin
#15 ADD_SUB <= 1'b0; 
#115 ADD_SUB <= 1'b1;
end


initial 

$monitor ($time, "clk=%b", CLK, " SUM_OUT = %h", SUM_OUT);
endmodule


