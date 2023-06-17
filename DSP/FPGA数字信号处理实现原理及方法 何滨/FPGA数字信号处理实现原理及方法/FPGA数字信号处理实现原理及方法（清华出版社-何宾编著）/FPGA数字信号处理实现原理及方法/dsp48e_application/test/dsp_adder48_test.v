`timescale 1ns/1ps

module test_dsp_adder48;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [47:0]  AIN1;
reg   [47:0]  BIN1;
wire  [48:0]  OUT1;



dsp_adder48 test(.AIN1(AIN1), .BIN1(BIN1), .CLK(CLK), .RST(RST), .OUT1(OUT1));


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
#15 AIN1 <= 48'd140737488355327; 
#65 AIN1 <= 48'd2020;
#65 AIN1 <= 48'd140000088355327;
#65 AIN1 <= 48'd1115;
end


initial
begin
#15 BIN1 <= 48'd140737488355326; 
#65 BIN1 <= 48'd2020;
#65 BIN1 <= 48'd140737488355327;
#65 BIN1 <= 48'd1115;
end

initial 

$monitor ($time, "clk=%b", CLK, " OUT1 = %h", OUT1);
endmodule


