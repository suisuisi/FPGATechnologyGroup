`timescale 1ns/1ps

module test_dsp_adder12;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [11:0]  AIN1, AIN2, AIN3, AIN4;
reg   [11:0]  BIN1, BIN2, BIN3, BIN4;
wire  [12:0]  OUT1, OUT2, OUT3, OUT4;



dsp_adder12 test(.AIN1(AIN1), .AIN2(AIN2), .AIN3(AIN3), .AIN4(AIN4), 
.BIN1(BIN1), .BIN2(BIN2), .BIN3(BIN3), .BIN4(BIN4), .CLK(CLK), .RST(RST), 
.OUT1(OUT1), .OUT2(OUT2), .OUT3(OUT3), .OUT4(OUT4));



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
#15 AIN1 <= 12'd512; 
#65 AIN1 <= 12'd2020;
#65 AIN1 <= 12'd10;
#65 AIN1 <= 12'd1115;
end

initial
begin
#15 AIN2 <= 12'd512; 
#65 AIN2 <= 12'd2020;
#65 AIN2 <= 12'd10;
#65 AIN2 <= 12'd1115;
end

initial
begin
#15 AIN3 <= 12'd512; 
#65 AIN3 <= 12'd2020;
#65 AIN3 <= 12'd10;
#65 AIN3 <= 12'd1115;
end

initial
begin
#15 AIN4 <= 12'd512; 
#65 AIN4 <= 12'd2020;
#65 AIN4 <= 12'd10;
#65 AIN4 <= 12'd1115;
end


initial
begin
#15 BIN1 <= 12'd512; 
#65 BIN1 <= 12'd2020;
#65 BIN1 <= 12'd10;
#65 BIN1 <= 12'd1115;
end

initial
begin
#15 BIN2 <= 12'd512; 
#65 BIN2 <= 12'd2020;
#65 BIN2 <= 12'd10;
#65 BIN2 <= 12'd1115;
end

initial
begin
#15 BIN3 <= 12'd512; 
#65 BIN3 <= 12'd2020;
#65 BIN3 <= 12'd10;
#65 BIN3 <= 12'd1115;
end

initial
begin
#15 BIN4 <= 12'd512; 
#65 BIN4 <= 12'd2020;
#65 BIN4 <= 12'd10;
#65 BIN4 <= 12'd1115;
end

initial 

$monitor ($time, "clk=%b", CLK, " OUT1 = %h", OUT1);
endmodule


