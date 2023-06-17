//------------------------------------------------------------------------------ 
// Copyright (c) 2004 Xilinx, Inc. 
// All Rights Reserved 
//------------------------------------------------------------------------------ 
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /   Vendor: Xilinx 
// \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
//  \   \        Filename: COMPLEX_MULT_PIPE 
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
////////////////////////////////////////////////////////////////////////////////////
//
// Module: COMPLEX_MULT_PIPE
//
// Description: Verilog instantiation template for 
// DSP48 embedded MAC blocks arranged as a pipelined
// complex multiplier. Macro uses 4 slices, 2 slices 
// used to get the real part of the product and 2 
// slices to get the imaginary part of the product.
//
// Device: Whitney Family
//
// Copyright (c) 2000 Xilinx, Inc.  All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////
//


module comp_mult_pipe (CLK, RST, A_REAL, B_REAL, A_IMAGINARY, B_IMAGINARY,
                          PROD_REAL, PROD_IMAGINARY);
	
input            CLK, RST;
input   [24:0]   A_REAL, A_IMAGINARY;
input   [17:0]   B_REAL, B_IMAGINARY;
output  [47:0]   PROD_REAL, PROD_IMAGINARY;

wire    [47:0]   PCOUT1, PCOUT3;


//          
// Instantiation block 1 (Real Product)
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
   .ACOUT(),   
   .BCOUT(),  
   .CARRYCASCOUT(), 
   .CARRYOUT(), 
   .MULTSIGNOUT(), 
   .OVERFLOW(), 
   .P(),          
   .PATTERNBDETECT(), 
   .PATTERNDETECT(), 
   .PCOUT(PCOUT1),  
   .UNDERFLOW(), 
   .A({5'b0,A_REAL}),          
   .ACIN(30'b0),    
   .ALUMODE(4'b0000), 
   .B(B_REAL),          
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



//          
// Instantiation block 2 (Real Product)
//

DSP48E #(
   .ACASCREG(1),       
   .ALUMODEREG(1),     
   .AREG(2),           
   .AUTORESET_PATTERN_DETECT("FALSE"), 
   .AUTORESET_PATTERN_DETECT_OPTINV("MATCH"), 
   .A_INPUT("DIRECT"), 
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
   .P(PROD_REAL),          
   .PATTERNBDETECT(), 
   .PATTERNDETECT(), 
   .PCOUT(),  
   .UNDERFLOW(), 
   .A({5'b0,A_IMAGINARY}),          
   .ACIN(30'b0),    
   .ALUMODE(4'b0011), 
   .B(B_IMAGINARY),          
   .BCIN(18'b0),    
   .C(48'b0),          
   .CARRYCASCIN(1'b0), 
   .CARRYIN(1'b0), 
   .CARRYINSEL(3'b0), 
   .CEA1(1'b1),      
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
   .OPMODE(7'b0010101), 
   .PCIN(PCOUT1),      
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
// Instantiation block 3 (Imaginary Product)
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

DSP48E_3 (
   .ACOUT(),   
   .BCOUT(),  
   .CARRYCASCOUT(), 
   .CARRYOUT(), 
   .MULTSIGNOUT(), 
   .OVERFLOW(), 
   .P(),          
   .PATTERNBDETECT(), 
   .PATTERNDETECT(), 
   .PCOUT(PCOUT3),  
   .UNDERFLOW(), 
   .A({5'b0,A_REAL}),          
   .ACIN(30'b0),    
   .ALUMODE(4'b0000), 
   .B(B_IMAGINARY),          
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

//          
// Instantiation block 4 (Imaginary Product)
//
DSP48E #(
   .ACASCREG(1),       
   .ALUMODEREG(1),     
   .AREG(2),           
   .AUTORESET_PATTERN_DETECT("FALSE"), 
   .AUTORESET_PATTERN_DETECT_OPTINV("MATCH"), 
   .A_INPUT("DIRECT"), 
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
DSP48E_4 (
   .ACOUT(),   
   .BCOUT(),  
   .CARRYCASCOUT(), 
   .CARRYOUT(), 
   .MULTSIGNOUT(), 
   .OVERFLOW(), 
   .P(PROD_IMAGINARY),          
   .PATTERNBDETECT(), 
   .PATTERNDETECT(), 
   .PCOUT(),  
   .UNDERFLOW(), 
   .A({5'b0,A_IMAGINARY}),          
   .ACIN(30'b0),    
   .ALUMODE(4'b0000), 
   .B(B_REAL),          
   .BCIN(18'b0),    
   .C(48'b0),          
   .CARRYCASCIN(1'b0), 
   .CARRYIN(1'b0), 
   .CARRYINSEL(3'b0), 
   .CEA1(1'b1),      
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
   .OPMODE(7'b0010101), 
   .PCIN(PCOUT3),      
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
////////////////////////////////////////////////////////////////////////////////////

endmodule






