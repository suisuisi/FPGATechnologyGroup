`timescale 1ns/1ps

module test_conv_round_lsb;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [24:0]  AIN; 
reg   [17:0]  BIN;
reg   [47:0]  CIN;
reg           CARRYIN;
wire  [43:0]  ROUND_OUT_EVEN, ROUND_OUT_ODD;



conv_round_lsb test(.CLK(CLK), .RST(RST), .AIN(AIN), .BIN(BIN), .CIN(CIN), 
.CARRYIN(CARRYIN), .ROUND_OUT_EVEN(ROUND_OUT_EVEN), .ROUND_OUT_ODD(ROUND_OUT_ODD));



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


#15 AIN <= 25'h28; //10.1000 or 2.5
#15 AIN <= 25'h1ffffd8; //1..1.1000 or -2.5
#15 AIN <= 25'h1;
#15 AIN <= 25'h1;
#15 AIN <= 25'h28; //10.1000 or 2.5
#15 AIN <= 25'h1ffffd8; //1..1.1000 or -2.5
#15 AIN <= 25'h1;
#15 AIN <= 25'h1;
end

initial
begin

#15 BIN <= 18'h1; 
#15 BIN <= 18'h1;
#15 BIN <= 18'h38;//0011.1000 or 3.5
#15 BIN <= 18'h1ffe8; //1...1110.1000 or -1.5
#15 BIN <= 18'h1; 
#15 BIN <= 18'h1;
#15 BIN <= 18'h38;//0011.1000 or 3.5
#15 BIN <= 18'h1ffc8; //1...1100.1000 or -3.5
end

initial
begin
#15 CIN <= 48'h000000000007; 
end

initial
begin
//#15 CARRYIN <= 1'b0; //output (round to odd) = 3,-3,3,-1,3,-3,3,-3
#15 CARRYIN <= 1'b1; //output (round to even) = 2,-2,4,-2,2,-2,4,-4
end

initial 

$monitor ($time, "clk=%b", CLK, " ROUND_OUT_EVEN = %h", ROUND_OUT_EVEN);
endmodule


