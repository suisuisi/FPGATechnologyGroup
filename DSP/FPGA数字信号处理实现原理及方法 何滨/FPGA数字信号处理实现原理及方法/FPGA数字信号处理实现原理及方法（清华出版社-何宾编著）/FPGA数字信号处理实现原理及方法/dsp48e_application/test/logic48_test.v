`timescale 1ns/1ps

module test_logic48;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [47:0]  AIN, BIN;
wire  [47:0]  LOGIC_OUT;//1, ABS_SUM_OUT2;

logic48 test(.CLK(CLK), .RST(RST), .AIN(AIN), .BIN(BIN), 
.LOGIC_OUT(LOGIC_OUT));

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

#15 AIN <= 48'd3;//24'd512; 
#65 AIN <= 48'd2020;
#65 AIN <= 48'd10;
#65 AIN <= 48'd1115;

end

initial
begin

#15 BIN <= 48'd514; 
#65 BIN <= 48'd2000;
#65 BIN <= 48'd14;
#65 BIN <= 48'd1111;

end

initial 

$monitor ($time, "clk=%b", CLK, " LOGIC_OUT = %h", LOGIC_OUT);
endmodule


