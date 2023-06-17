`timescale 1ns/1ps

module test_mult35x35_parallel_pipe;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [34:0]  A_IN;
reg   [34:0]  B_IN;
wire  [69:0]  PROD_OUT;



MULT35X35_PARALLEL_PIPE test(.CLK(CLK), .RST(RST), .A_IN(A_IN), .B_IN(B_IN), .PROD_OUT(PROD_OUT));



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

#15 A_IN <= 35'd512; 
#65 A_IN <= 35'd1048575;//65537;//1048575;
#65 A_IN <= 35'd10;
#65 A_IN <= 35'd1115;
#65 A_IN <= 35'd17179869183;
end

initial
begin

#15 B_IN <= 35'd512; 
#65 B_IN <= 35'd10000;//2020;
#65 B_IN <= 35'd1048575;
#65 B_IN <= 35'd1115;
#65 B_IN <= 35'd17179869183;

end




initial 

$monitor ($time, "clk=%b", CLK, " PROD_OUT = %h", PROD_OUT);
endmodule


