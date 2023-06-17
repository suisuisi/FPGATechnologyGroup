`timescale 1ns/1ps

module test_dsp_adder24;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [23:0]  AIN1, AIN2;
reg   [23:0]  BIN1, BIN2;
wire  [24:0]  OUT1, OUT2;



dsp_adder24 test(.AIN1(AIN1), .AIN2(AIN2), .BIN1(BIN1), .BIN2(BIN2), .CLK(CLK), .RST(RST), 
.OUT1(OUT1), .OUT2(OUT2));



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
#15 AIN1 <= 24'd8299999; 
#65 AIN1 <= 24'd2020;
#65 AIN1 <= 24'd10;
#65 AIN1 <= 24'd1115;
end

initial
begin
#15 AIN2 <= 24'd01010010; 
#65 AIN2 <= 24'd8388607;
#65 AIN2 <= 24'd10;
#65 AIN2 <= 24'd1115;
end


initial
begin
#15 BIN1 <= 24'd8288888; 
#65 BIN1 <= 24'd2020;
#65 BIN1 <= 24'd10;
#65 BIN1 <= 24'd1115;
end

initial
begin
#15 BIN2 <= 24'd512; 
#65 BIN2 <= 24'd8388607;
#65 BIN2 <= 24'd10;
#65 BIN2 <= 24'd1115;
end

initial 

$monitor ($time, "clk=%b", CLK, " OUT1 = %h", OUT1);
endmodule


