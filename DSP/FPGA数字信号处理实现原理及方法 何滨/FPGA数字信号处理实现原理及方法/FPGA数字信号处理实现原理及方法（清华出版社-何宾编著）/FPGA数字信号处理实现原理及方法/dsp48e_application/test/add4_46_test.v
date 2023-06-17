`timescale 1ns/1ps

module test_add4_46;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [45:0]  AIN, BIN, CIN, DIN;
wire  [47:0]  SUM_OUT;



add4_46 test(.CLK(CLK), .RST(RST), .AIN(AIN), .BIN(BIN), .CIN(CIN), .DIN(DIN), .SUM_OUT(SUM_OUT));



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

#15 AIN <= 46'd512; 
#65 AIN <= 46'd2020;
#65 AIN <= 46'd10;
#65 AIN <= 46'd35184372088831;
end

initial
begin

#15 BIN <= 46'd512; 
#65 BIN <= 46'd2020;
#65 BIN <= 46'd10;
#65 BIN <= 46'd35184372088831;
end

initial
begin

#15 CIN <= 46'd514; 
#65 CIN <= 46'd2000;
#65 CIN <= 46'd14;
#65 CIN <= 46'd35184372088831;
end


initial
begin

#15 DIN <= 46'd512; 
#65 DIN <= 46'd2020;
#65 DIN <= 46'd10;
#65 DIN <= 46'd35184372088831;
end



initial 

$monitor ($time, "clk=%b", CLK, " SUM_OUT = %h", SUM_OUT);
endmodule


