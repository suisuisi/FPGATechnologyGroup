`timescale 1ns/1ps

module test_cntr_load;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [47:0]  C_IN;
reg           LOAD, ADD_SUB;
wire  [47:0]  CNTR_OUT;




cntr_load test (.CLK(CLK), .RST(RST), .C_IN(C_IN), .LOAD(LOAD),
 .ADD_SUB(ADD_SUB), .CNTR_OUT(CNTR_OUT));
	


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

#15 C_IN <= 96'd512; 
#65 C_IN <= 96'd2020;
//#65 C_IN <= 96'd10;
//#65 C_IN <= 96'd1115;
end

initial
begin

#15 LOAD <= 1'b1; 
#65 LOAD <= 1'b0;
#65 LOAD <= 1'b1;
#65 LOAD <= 1'b0;
end


initial
begin

#15 ADD_SUB <= 1'b1; 
#65 ADD_SUB <= 1'b1;
#65 ADD_SUB <= 1'b0;
#65 ADD_SUB <= 1'b0;
end




initial 

$monitor ($time, "clk=%b", CLK, " CNTR_OUT = %h", CNTR_OUT);
endmodule


