`timescale 1ns/1ps

module test_addsub48;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg		  ADD_SUB;
reg   [47:0]  A_IN, C_IN;
wire  [47:0]  ADDSUB48_OUT;



addsub48 test(.CLK(CLK), .RST(RST), .A_IN(A_IN), .C_IN(C_IN), .ADD_SUB(ADD_SUB), .ADDSUB48_OUT(ADDSUB48_OUT));



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

#15 A_IN <= 45'd512; 
#65 A_IN <= 45'd2020;
#65 A_IN <= 45'd1110;
#65 A_IN <= 45'd1110;
end

initial
begin

#15 C_IN <= 45'd512; 
#65 C_IN <= 45'd2020;
#65 C_IN <= 45'd10;
#65 C_IN <= 45'd1115;
end

initial
begin

#15 ADD_SUB <= 1'b0; 
#65 ADD_SUB <= 1'b0;
#65 ADD_SUB <= 1'b1;
#65 ADD_SUB <= 1'b1;
end



initial 

$monitor ($time, "clk=%b", CLK, " ADDSUB48_OUT = %h", ADDSUB48_OUT);
endmodule


