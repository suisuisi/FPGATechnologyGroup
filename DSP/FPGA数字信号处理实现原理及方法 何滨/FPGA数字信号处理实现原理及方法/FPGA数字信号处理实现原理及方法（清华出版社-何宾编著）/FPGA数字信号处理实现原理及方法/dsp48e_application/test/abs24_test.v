`timescale 1ns/1ps

module test_abs24;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [23:0]  AIN, BIN;
wire  [47:0]  ABS_SUM_OUT;//1, ABS_SUM_OUT2;


abs24 test(.CLK(CLK), .RST(RST), .AIN(AIN), .BIN(BIN), 
.ABS_SUM_OUT(ABS_SUM_OUT));//, .ABS_SUM_OUT2(ABS_SUM_OUT2));

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

#15 AIN <= 24'd3;//24'd512; 
#65 AIN <= 24'd2020;
#65 AIN <= 24'd10;
#65 AIN <= 24'd1115;

end

initial
begin

#15 BIN <= 24'd5;//24'd514; 
#65 BIN <= 24'd2000;
#65 BIN <= 24'd14;
#65 BIN <= 24'd1111;

end

initial 

$monitor ($time, "clk=%b", CLK, " ABS_SUM_OUT = %h", ABS_SUM_OUT);
endmodule

