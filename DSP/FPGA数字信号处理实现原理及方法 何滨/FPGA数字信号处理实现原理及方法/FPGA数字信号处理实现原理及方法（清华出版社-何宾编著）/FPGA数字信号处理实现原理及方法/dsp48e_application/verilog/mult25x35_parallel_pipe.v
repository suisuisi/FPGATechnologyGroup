//------------------------------------------------------------------------------ 
// Copyright (c) 2004 Xilinx, Inc. 
// All Rights Reserved 
//------------------------------------------------------------------------------ 
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /   Vendor: Xilinx 
// \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
//  \   \        Filename: MULT35X18_PARALLEL_PIPE 
//  /   /        Date Last Modified:  OCTOBER 05, 2004 
// /___/   /\    Date Created: OCTOBER 05, 2004 
// \   \  /  \ 
//  \___\/\___\ 
// 
//
// Revision History: 
// $Log: $
//------------------------------------------------------------------------------ 
//
//     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
//     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR
//     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION
//     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION
//     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS
//     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,
//     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
//     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
//     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
//     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
//     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
//     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
//     FOR A PARTICULAR PURPOSE.
//
//------------------------------------------------------------------------------ 
//
// Module: MULT25X35_PARALLEL_PIPE
//
// Description: Verilog instantiation template for 
// DSP48 embedded MAC blocks arranged as a pipelined
// 35 x 18 parallel multiplier. The macro uses 2 DSP
// slices 
//
// Device: Whitney Family
//
// Copyright (c) 2000 Xilinx, Inc.  All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////
//

module mult25x35_parallel_pipe (CLK, RST, A_IN, B_IN, PROD_OUT);
	
input           CLK, RST;
input   [24:0]  A_IN;
input   [34:0]  B_IN;
output  [59:0]  PROD_OUT;


wire    [29:0]   ACOUT_1;
wire    [47:0]   PCOUT_1, POUT_1, POUT_2;
wire    [29:0]   A_IN_WIRE;
reg     [16:0]   POUT_1_REG1;
assign A_IN_WIRE = A_IN;

//          
// Product[16:0], Instantiation block 1
//

DSP48E #(
   .ACASCREG(1),       
   .ALUMODEREG(1),     
   .AREG(1),           
   .AUTORESET_PATTERN_DETECT("FALSE"), 
   .AUTORESET_PATTERN_DETECT_OPTINV("MATCH"), 
   .A_INPUT("DIRECT"), 
   .BCASCREG(1),       
   .BREG(1),           
   .B_INPUT("DIRECT"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(1),  
   .CREG(1),           
   .MASK(48'h3FFFFFFFFFFF), 
   .MREG(1),           
   .MULTCARRYINREG(0), 
   .OPMODEREG(0),      
   .PATTERN(48'h000000000000), 
   .PREG(1),           
   .SEL_MASK("MASK"),  
   .SEL_PATTERN("PATTERN"), 
   .SEL_ROUNDING_MASK("SEL_MASK"), 
   .USE_MULT("MULT_S"), 
   .USE_PATTERN_DETECT("NO_PATDET"), 
   .USE_SIMD("ONE48") 
) 
DSP48E_1 (
   .ACOUT(ACOUT_1),   
   .BCOUT(),  
   .CARRYCASCOUT(), 
   .CARRYOUT(), 
   .MULTSIGNOUT(), 
   .OVERFLOW(), 
   .P(POUT_1),          
   .PATTERNBDETECT(), 
   .PATTERNDETECT(), 
   .PCOUT(PCOUT_1),  
   .UNDERFLOW(), 
   .A({5'b0,A_IN}),          
   .ACIN(30'b0),    
   .ALUMODE(4'b0000), 
   .B({1'b0,B_IN[16:0]}),          
   .BCIN(18'b0),    
   .C(48'b0),          
   .CARRYCASCIN(1'b0), 
   .CARRYIN(1'b0), 
   .CARRYINSEL(3'b0), 
   .CEA1(1'b0),      
   .CEA2(1'b1),      
   .CEALUMODE(1'b1), 
   .CEB1(1'b0),      
   .CEB2(1'b1),      
   .CEC(1'b1),      
   .CECARRYIN(1'b0), 
   .CECTRL(1'b1), 
   .CEM(1'b1),       
   .CEMULTCARRYIN(1'b0),
   .CEP(1'b1),       
   .CLK(CLK),       
   .MULTSIGNIN(1'b0), 
   .OPMODE(7'b0000101), 
   .PCIN(48'b0),      
   .RSTA(RST),     
   .RSTALLCARRYIN(RST), 
   .RSTALUMODE(RST), 
   .RSTB(RST),     
   .RSTC(RST),     
   .RSTCTRL(RST), 
   .RSTM(RST), 
   .RSTP(RST) 
);


always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin POUT_1_REG1 <= 17'b0; end
   else 
       begin POUT_1_REG1 <= POUT_1[16:0]; end       
   end



assign PROD_OUT[16:0] = POUT_1_REG1[16:0];

//          
// Product[52:17], Instantiation block 2
//
DSP48E #(
   .ACASCREG(1),       
   .ALUMODEREG(1),     
   .AREG(1),           
   .AUTORESET_PATTERN_DETECT("FALSE"), 
   .AUTORESET_PATTERN_DETECT_OPTINV("MATCH"), 
   .A_INPUT("CASCADE"), 
   .BCASCREG(1),       
   .BREG(2),           
   .B_INPUT("DIRECT"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(1),  
   .CREG(1),           
   .MASK(48'h3FFFFFFFFFFF), 
   .MREG(1),           
   .MULTCARRYINREG(0), 
   .OPMODEREG(0),      
   .PATTERN(48'h000000000000), 
   .PREG(1),           
   .SEL_MASK("MASK"),  
   .SEL_PATTERN("PATTERN"), 
   .SEL_ROUNDING_MASK("SEL_MASK"), 
   .USE_MULT("MULT_S"), 
   .USE_PATTERN_DETECT("NO_PATDET"), 
   .USE_SIMD("ONE48") 
) 
DSP48E_2 (
   .ACOUT(),   
   .BCOUT(),  
   .CARRYCASCOUT(), 
   .CARRYOUT(), 
   .MULTSIGNOUT(), 
   .OVERFLOW(), 
   .P(POUT_2),          
   .PATTERNBDETECT(), 
   .PATTERNDETECT(), 
   .PCOUT(),  
   .UNDERFLOW(), 
   .A(30'b0),          
   .ACIN(ACOUT_1),    
   .ALUMODE(4'b0000), 
   .B(B_IN[34:17]),          
   .BCIN(18'b0),    
   .C(48'b0),          
   .CARRYCASCIN(1'b0), 
   .CARRYIN(1'b0), 
   .CARRYINSEL(3'b0), 
   .CEA1(1'b0),      
   .CEA2(1'b1),      
   .CEALUMODE(1'b1), 
   .CEB1(1'b1),      
   .CEB2(1'b1),      
   .CEC(1'b1),      
   .CECARRYIN(1'b0), 
   .CECTRL(1'b1), 
   .CEM(1'b1),       
   .CEMULTCARRYIN(1'b0),
   .CEP(1'b1),       
   .CLK(CLK),       
   .MULTSIGNIN(1'b0), 
   .OPMODE(7'b1010101), 
   .PCIN(PCOUT_1),      
   .RSTA(RST),     
   .RSTALLCARRYIN(RST), 
   .RSTALUMODE(RST), 
   .RSTB(RST),     
   .RSTC(RST),     
   .RSTCTRL(RST), 
   .RSTM(RST), 
   .RSTP(RST) 
);


assign PROD_OUT[59:17] = POUT_2[42:0];

//
////////////////////////////////////////////////////////////////////////////////////

endmodule






