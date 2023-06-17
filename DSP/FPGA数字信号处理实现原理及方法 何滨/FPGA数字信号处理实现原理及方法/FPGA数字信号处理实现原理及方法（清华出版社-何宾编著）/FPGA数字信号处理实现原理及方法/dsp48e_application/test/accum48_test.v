`timescale 1ns/1ps

module test_accum48;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [23:0]  A_IN, C_IN;
reg ADD_SUB;
wire  [47:0]  ACCUM48_OUT;



accum48 test(.CLK(CLK), .RST(RST), .A_IN(A_IN), .C_IN(C_IN), .ADD_SUB(ADD_SUB), .ACCUM48_OUT(ACCUM48_OUT));



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
#15 A_IN <= 24'd512; 
#65 A_IN <= 24'd2020;
#65 A_IN <= 24'd10;
#65 A_IN <= 24'd1115;
end

initial
begin
#15 C_IN <= 24'd514; 
#65 C_IN <= 24'd2000;
#65 C_IN <= 24'd14;
#65 C_IN <= 24'd1111;
end

initial
begin
#15 ADD_SUB <= 1'd0; 
#65 ADD_SUB <= 1'd0;
#65 ADD_SUB <= 1'd1;
#65 ADD_SUB <= 1'd1;
end

initial 

$monitor ($time, "clk=%b", CLK, " ACCUM48_OUT = %h", ACCUM48_OUT);
endmodule


