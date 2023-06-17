//------------------------------------------------------------------------------ 
// Copyright (c) 2004 Xilinx, Inc. 
// All Rights Reserved 
//------------------------------------------------------------------------------ 
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /   Vendor: Xilinx 
// \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
//  \   \        Filename: BARRELSHIFTER_18BIT 
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
// Module: BARRELSHIFTER_18BIT
//
// Description: Verilog instantiation template for 
// DSP48 embedded MAC blocks arranged as a pipelined
// 18 bit barrel shifter. The macro uses 2 DSP
// slices 
//
// Device: Whitney Family
//
// Copyright (c) 2000 Xilinx, Inc.  All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////
//


module barrelshifter_18bit (CLK, RST, A_IN, SHIFT_IN, SHIFT_OUT);
	
input           CLK, RST;
input   [17:0]  A_IN;
input   [17:0]  SHIFT_IN;
output  [17:0]  SHIFT_OUT;

wire    [47:0]  PCOUT_1;
wire    [47:0]  POUT_2;
wire[17:0] BCOUT_1;
reg     SHIFT_MSB_REG1, SHIFT_MSB_REG2;

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin 
       SHIFT_MSB_REG1 <= 1'b0; 
       SHIFT_MSB_REG2 <= 1'b0;
       end
   else  
       begin 
       SHIFT_MSB_REG1 <= SHIFT_IN[17]; 
       SHIFT_MSB_REG2 <= SHIFT_MSB_REG1;
       end  
   end

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
   .CREG(0),           
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
   .ACOUT(),   
   .BCOUT(BCOUT_1),  
   .CARRYCASCOUT(), 
   .CARRYOUT(), 
   .MULTSIGNOUT(), 
   .OVERFLOW(), 
   .P(),          
   .PATTERNBDETECT(), 
   .PATTERNDETECT(), 
   .PCOUT(PCOUT_1),  
   .UNDERFLOW(), 
   .A({13'b0,A_IN[17:1]}),          
   .ACIN(30'b0),    
   .ALUMODE({2'b00,SHIFT_MSB_REG1,SHIFT_MSB_REG1}), 
   .B(SHIFT_IN),          
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
   .CEC(1'b0),      
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

//          
// Product[52:17], Instantiation block 2
//

DSP48E #(
   .ACASCREG(1),       
   .ALUMODEREG(1),     
   .AREG(2),           
   .AUTORESET_PATTERN_DETECT("FALSE"), 
   .AUTORESET_PATTERN_DETECT_OPTINV("MATCH"), 
   .A_INPUT("DIRECT"), 
   .BCASCREG(1),       
   .BREG(1),           
   .B_INPUT("CASCADE"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(1),  
   .CREG(0),           
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
   .A({12'b0,A_IN}),          
   .ACIN(30'b0),    
   .ALUMODE({2'b00,SHIFT_MSB_REG2,SHIFT_MSB_REG2}), 
   .B(18'b0),          
   .BCIN(BCOUT_1),    
   .C(48'b0),          
   .CARRYCASCIN(1'b0), 
   .CARRYIN(1'b0), 
   .CARRYINSEL(3'b0), 
   .CEA1(1'b1),      
   .CEA2(1'b1),      
   .CEALUMODE(1'b1), 
   .CEB1(1'b1),      
   .CEB2(1'b1),      
   .CEC(1'b0),      
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



assign SHIFT_OUT = POUT_2[17:0];

//
////////////////////////////////////////////////////////////////////////////////////

endmodule



