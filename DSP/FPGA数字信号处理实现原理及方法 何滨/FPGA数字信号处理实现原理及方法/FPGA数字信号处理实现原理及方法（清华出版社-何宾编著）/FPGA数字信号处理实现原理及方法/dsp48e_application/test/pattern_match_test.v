`timescale 1ns/1ps

module test_pattern_match;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [47:0]  AIN, CIN;
wire    PATTERN_MATCH_OUT;



pattern_match test(.CLK(CLK), .RST(RST), .AIN(AIN), .CIN(CIN), . PATTERN_MATCH_OUT(PATTERN_MATCH_OUT));



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

#15 AIN <= 48'd510; 
#65 AIN <= 48'd2025;
#65 AIN <= 48'd10;
#65 AIN <= 48'd1115;
end

initial
begin

#15 CIN <= 48'd512; 
#65 CIN <= 48'd2025;
#65 CIN <= 48'd110;
#65 CIN <= 48'd1115;
end




initial 

$monitor ($time, "clk=%b", CLK, " PATTERN_MATCH_OUT = %h", PATTERN_MATCH_OUT);
endmodule


