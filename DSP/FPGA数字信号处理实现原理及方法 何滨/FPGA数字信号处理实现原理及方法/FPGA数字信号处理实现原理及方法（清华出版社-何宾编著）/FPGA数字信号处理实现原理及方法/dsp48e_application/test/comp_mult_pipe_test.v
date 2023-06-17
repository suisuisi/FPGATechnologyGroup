`timescale 1ns/1ps

module test_comp_mult_pipe;

parameter CLK_PERIOD = 10;

	
reg           CLK, RST;
reg   [24:0]   A_REAL, A_IMAGINARY;
reg   [17:0]   B_REAL, B_IMAGINARY;
wire  [47:0]   PROD_REAL, PROD_IMAGINARY;



comp_mult_pipe test(.CLK(CLK), .RST(RST), .A_REAL(A_REAL), .B_REAL(B_REAL), .A_IMAGINARY(A_IMAGINARY), .B_IMAGINARY(B_IMAGINARY), .PROD_REAL(PROD_REAL), .PROD_IMAGINARY(PROD_IMAGINARY));



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

#15 A_REAL <= 25'd2; 
#65 A_REAL <= 25'd2020;
#65 A_REAL <= 25'd10;
#65 A_REAL <= 25'd1115;
end

initial
begin

#15 B_REAL <= 18'd6; 
#65 B_REAL <= 18'd2020;
#65 B_REAL <= 18'd10;
#65 B_REAL <= 18'd1115;
end

initial
begin

#15 A_IMAGINARY <= 25'd2; 
#65 A_IMAGINARY <= 25'd2000;
#65 A_IMAGINARY <= 25'd14;
#65 A_IMAGINARY <= 25'd1111;
end


initial
begin

#15 B_IMAGINARY <= 18'd2; 
#65 B_IMAGINARY <= 18'd2020;
#65 B_IMAGINARY <= 18'd10;
#65 B_IMAGINARY <= 18'd1115;
end



initial 

$monitor ($time, "clk=%b", CLK, " PROD_REAL = %h", PROD_REAL);
endmodule


