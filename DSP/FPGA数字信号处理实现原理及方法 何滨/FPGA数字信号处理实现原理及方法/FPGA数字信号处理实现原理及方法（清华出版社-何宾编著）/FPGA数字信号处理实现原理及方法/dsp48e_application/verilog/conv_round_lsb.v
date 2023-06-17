//------------------------------------------------------------------------------ 
// Copyright (c) 2004 Xilinx, Inc. 
// All Rights Reserved 
//------------------------------------------------------------------------------ 
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /   Vendor: Xilinx 
// \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
//  \   \        Filename: conv_round_cc
//  /   /        Date Last Modified:  September 23, 2005 
// /___/   /\    Date Created: September 23, 2005 
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

/**********************************************************************/


module conv_round_lsb(AIN, BIN, CIN, CARRYIN, CLK, RST, ROUND_OUT_EVEN, ROUND_OUT_ODD);

input [24:0] AIN;
input [17:0] BIN;
input [47:0] CIN;
input        CARRYIN;
input CLK;
input RST;
output [43:0] ROUND_OUT_EVEN, ROUND_OUT_ODD;

wire [47:0] POUT1;
reg[47:0] CIN_REG, POUT1_REG;
reg ROUND_OUT_E_INT,ROUND_OUT_O_INT;
wire PDOUT, PBDOUT;

always@(posedge CLK)
begin
       if (RST)
       CIN_REG <= 48'b0;
       else
       CIN_REG <= CIN;
end

//
// Instantiation block 1
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
   .SEL_ROUNDING_MASK("MODE1"), 
   .USE_MULT("MULT_S"), 
   .USE_PATTERN_DETECT("PATDET"), 
   .USE_SIMD("ONE48") 
) 
DSP48E_1 (
   .ACOUT(),   
   .BCOUT(),  
   .CARRYCASCOUT(), 
   .CARRYOUT(), 
   .MULTSIGNOUT(), 
   .OVERFLOW(), 
   .P(POUT1),          
   .PATTERNBDETECT(PBDOUT), 
   .PATTERNDETECT(PDOUT), 
   .PCOUT(),  
   .UNDERFLOW(), 
   .A({5'b0,AIN}),          
   .ACIN(30'b0),    
   .ALUMODE(4'b0000), 
   .B(BIN),
   .BCIN(18'b0),    
   .C(CIN_REG),          
   .CARRYCASCIN(1'b0), 
   .CARRYIN(CARRYIN), 
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
   .OPMODE(7'b0110101), 
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

// End of DSP48E_1 instantiation


always@(posedge CLK)
begin
       if (RST)
       ROUND_OUT_E_INT <= 1'b0;
       else
       ROUND_OUT_E_INT <= !(!(POUT1[4]) | PDOUT);
end

always@(posedge CLK)
begin
       if (RST)
       ROUND_OUT_O_INT <= 1'b0;
       else
       ROUND_OUT_O_INT <= POUT1[4] | PBDOUT;
end

always@(posedge CLK)
begin
       if (RST)
       POUT1_REG <= 48'b0;
       else
       POUT1_REG <= POUT1;
end

assign ROUND_OUT_EVEN = {POUT1_REG[47:5],ROUND_OUT_E_INT};
assign ROUND_OUT_ODD  = {POUT1_REG[47:5],ROUND_OUT_O_INT};

endmodule








