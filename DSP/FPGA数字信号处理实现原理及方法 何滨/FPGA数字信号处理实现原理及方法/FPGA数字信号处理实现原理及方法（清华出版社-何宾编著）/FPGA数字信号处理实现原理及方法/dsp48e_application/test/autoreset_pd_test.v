`timescale 1ns/1ps

module test_autoreset_pd;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg[29:0] A_IN;
reg[17:0] B_IN;
reg   [47:0]  C_IN;
wire          AUTORESET_OUT;



autoreset_pd test(.CLK(CLK), .RST(RST), .A_IN(A_IN), .B_IN(B_IN), .C_IN(C_IN), .AUTORESET_OUT(AUTORESET_OUT));



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
#15 A_IN <= 48'd5; 
#15 A_IN <= 48'd20;
#15 A_IN <= 48'd14;
#15 A_IN <= 48'd10;
end

initial
begin
#15 B_IN <= 48'd1; 
#15 B_IN <= 48'd5;
#15 B_IN <= 48'd14;
#15 B_IN <= 48'd10;
end

initial
begin
#15 C_IN <= 48'd100; 
//#65 C_IN <= 48'd2000;
//#65 C_IN <= 48'd14;
//#65 C_IN <= 48'd1111;
end

initial 

$monitor ($time, "clk=%b", CLK, " AUTORESET_OUT = %b", AUTORESET_OUT);
endmodule


