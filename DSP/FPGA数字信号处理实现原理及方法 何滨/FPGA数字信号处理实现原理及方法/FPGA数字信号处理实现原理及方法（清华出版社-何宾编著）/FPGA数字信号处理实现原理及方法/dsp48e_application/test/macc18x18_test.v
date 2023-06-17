`timescale 1ns/1ps

module test_macc18x18;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [17:0]  A_IN;
reg   [17:0]  B_IN;
reg           ADD_SUB;
wire  [47:0]  PROD_OUT;



macc18x18 test(.CLK(CLK), .RST(RST), .A_IN(A_IN), .B_IN(B_IN), .ADD_SUB(ADD_SUB), .PROD_OUT(PROD_OUT));



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

#15 A_IN <= 18'd512; 
#65 A_IN <= 18'd2020;
#65 A_IN <= 18'd10;
#65 A_IN <= 18'd1115;
end

initial
begin

#15 B_IN <= 18'd512; 
#65 B_IN <= 18'd2020;
#65 B_IN <= 18'd10;
#65 B_IN <= 18'd1115;
end

initial
begin

#15 ADD_SUB <= 1'b0; 
#65 ADD_SUB <= 1'b0;
#65 ADD_SUB <= 1'b1;
#65 ADD_SUB <= 1'b1;
end



initial 

$monitor ($time, "clk=%b", CLK, " PROD_OUT = %h", PROD_OUT);
endmodule


